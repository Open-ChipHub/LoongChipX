// DESCRIPTION: Verilator: Verilog example module
//
// This file ONLY is placed under the Creative Commons Public Domain, for
// any use, without warranty, 2017 by Wilson Snyder.
// SPDX-License-Identifier: CC0-1.0
//======================================================================

// For std::unique_ptr
#include <memory>

// Include common routines
#include <verilated.h>

#if defined(WAVE_FST)
#include <verilated_fst_c.h>
#elif defined(WAVE_VCD)
#include <verilated_vcd_c.h>
#endif

#include <iostream>
#include <stdio.h>
#include <signal.h>

// Include model header, generated from Verilating "Top.v"
#include "VTop.h"
#include "VTop__Syms.h"
#include "VTop___024root.h"

#include "config.h"
#include "sim_config.h"
#include "ram.h"
#include "rand64.h"
#include "axi.h"
#include "lsassert.h"
#include "trace.h"
#include "log.h"
#include "initialize.h"

#include "snapshot.h"
#include "dramsim3.h"
#include "fpr.h"
#include "commonprint.h"
#include "build_config.h"
#include "loongarch_state.h"
#include "util.h"
#include "../memory/memorysim.h"
#include "memorysim.h"

#ifdef USE_DRAM_SIM
using namespace MemorySim;
#else
using namespace AXISim;
#endif
// Legacy function required only so linking works on Cygwin and MSVC++
double sc_time_stamp() { return 0; }


void cpu_irq_handler(void *opaque, int n, int level) {
    VTop *Top = (VTop *)opaque;
    if (level) {
        Top->core_in_interrupt |= 1 << (n - 2);
    } else {
        Top->core_in_interrupt &= ~(1 << (n - 2));
    }
}

FILE* smart_fopen(
    Config& config,
    const std::string& dir,
    const std::string& name,
    const std::string& ext,
    const char* mode,
    const char* image_dir){
    std::string fname;
    if (image_dir != nullptr) {
        fname = string(image_dir) + "." + name;
        std::replace(fname.begin(), fname.end(), '/', '_');
    }
    else{
        fname = name + "." + config.timestamp;
    }
    fname = dir + "/" + fname + ext;
    FILE* ret = fopen_nofail(fname.c_str(), mode);
    if(ret != nullptr){
        log_info("Opened file \"%s\"", fname.c_str());
    }
    else{
        log_error("Failed on opening file \"%s\"", fname.c_str());
    }
    lsassert(ret != nullptr);
    if(image_dir == nullptr){
        bool sym_ret = config.link_to(fname, dir + "/" + name + ext);
        if(!sym_ret){
            fprintf(stderr,"Error on linking \"%s\"", fname.c_str());
        }
        lsassert(sym_ret);
    }
    return ret;
}


// Construct a VerilatedContext to hold simulation time, etc.
// Multiple modules (made later below with VTop) may share the same
// context to share time, or modules may have different contexts if
// they should be independent from each other.
//
// thread pool is shared by sub-process, so we manage it manually
VerilatedContext* contextp = nullptr;
Snapshot* snapshot = nullptr;
SimConfig sim_cfg;
#if defined(WAVE_FST)
VerilatedFstC* trace = nullptr;
string trace_ext = ".fst";
#elif defined(WAVE_VCD)
VerilatedVcdC* trace = nullptr;
string trace_ext = ".vcd";
#endif
void clear_simulator(){
    bool error = false;
    #ifndef WAVE_NONE
    if(snapshot != nullptr && snapshot->trace_opened && trace != nullptr){
        log_error("Closing trace on exit.");
        trace->close();
    }
    #endif
    if(snapshot != nullptr && snapshot->snapshot_isparent()){
        log_error("Abnormal exit is dectected.");
        snapshot->snapshot_stats();
        snapshot->snapshot_clear();
        delete snapshot;
        snapshot = nullptr;
        delete contextp;
        error = true;
    }
    if(error){
        exit(1);
    }
}

bool sim_finish = false;
uint64_t snapshot_dist   = 100000;
uint64_t rollback_dist   = 1;
int sigint_triggered = 0;

bool sim_wave_on = false;

void sigint_handler(int signum){
    if(sigint_triggered > 0){
        log_info("Catched multiple SIGINT (Ctrl-C), exit.");
        exit(1);
    }
    sigint_triggered += 1;

    if(snapshot == nullptr || contextp == nullptr){
        exit(1);
    }

    if(snapshot->get_active_pid() != getpid()){
        sim_cfg.wave_end_cycles = std::min(sim_cfg.wave_end_cycles, contextp->time()/2 + snapshot_dist);
        return;
    }

    if(!snapshot->snapshot_isparent()){
        exit(1);
    }

    sleep(1); // wait other process

    log_info("Catched SIGINT (Ctrl-C)");
    string action = sim_cfg.action_on_sigint;
    if(sim_cfg.action_on_sigint == "interactive"){
        log_info("Please input command(quit,replay):");
        string cmd;
        while(true){
            cin >> cmd;
            if(cmd == "replay" || cmd == "quit"){
                action = cmd;
                break;
            }
            else {
                if(cmd != "help"){
                    log_info("Got unknown command \"%s\"", cmd.c_str());
                }
                // print help
                log_info("Please input command(quit,replay):");
            }
        }
    }
    else action = sim_cfg.action_on_sigint;

    // do action
    if(action != "quit"){
        if(action != "replay"){
            log_info("Got unknown action \"%s\"", action.c_str());
        }
        snapshot->error = true;
    }
    sim_finish = true;
}

uint64_t dbg_sim_cycles;
bool checkpoint = false;

int main(int argc, char** argv, char** env) {

    // Prevent unused variable warnings
    if (false && argc && argv && env) {}

    atexit(clear_simulator);
    signal(SIGINT,&sigint_handler);

    // Create logs/ directory in case we have traces to put under it
    Verilated::mkdir("logs");

    log_set_level(LOG_DEBUG);
    Config config(argc, argv);
    config.read_config();

    if(config.has_key("log_level")) {
        string log_level = config.get_value("log_level");
        if (log_level == "trace") {
            log_set_level(LOG_TRACE);
        } else if (log_level == "debug") {
            log_set_level(LOG_DEBUG);
        } else if (log_level == "info") {
            log_set_level(LOG_INFO);
        } else if (log_level == "warn") {
            log_set_level(LOG_WARN);
        } else if (log_level == "error") {
            log_set_level(LOG_ERROR);
        } else if (log_level == "fatal") {
            log_set_level(LOG_FATAL);
        } else {
            log_error("unknown log_level:%s", log_level.c_str());
        }
    }

    // TODO: run_mode
    sim_cfg.setup(config);
    uint64_t sim_cycles_limit  = config.get_value_or_else("sim_cycles" , UINT64_MAX / 2) * 2;
    uint64_t ins_cnt_end       = config.get_value_or_else("ins_cnt_end", UINT64_MAX);
    // by default, when run kernel, only record user performance counters
    uint64_t watch_paddr = config.get_value_or_else("watch_paddr", 0);
    string   log_dir = config.get_value_or_cstr("log_dir", "logs");
    snapshot_dist   = config.get_value_or_else("snapshot_dist"   , 100000);
    rollback_dist   = config.get_value_or_else("rollback_dist"   , 1);
    #ifdef USE_DRAM_SIM
    string dramsim_config = config.get_value_or_cstr("dramsim_config","../../common/memory/DRAMsim3/configs/DDR4_8Gb_x16_3200.ini");
    uint64_t dram_tick_period = config.get_value_or_else("dramsim_tick_period",1);
    uint64_t dram_tick_step   = config.get_value_or_else("dramsim_tick_step",1);
    assert(dram_tick_period > 0);
    assert(dram_tick_step   > 0);
    #endif
    uint64_t random_test_seed = config.get_value_or_else("random_test_seed", 0);
    uint64_t random_test_mat  = config.get_value_or_else("random_test_mat", 0x1);
    uint64_t random_fill_type = config.get_value_or_else("random_fill_type", 1);

    if (sim_cfg.wave_begin_cycles >= sim_cfg.wave_end_cycles) {
        fprintf(stderr, "error, wave_begin:%ld, wave_end:%ld\n", sim_cfg.wave_begin_cycles, sim_cfg.wave_end_cycles);
        return 0;
    }


#ifdef WITH_PMSLICE
    // dump pmslice
    FILE* pmslice_file = NULL;
    if(config.get_value_or_bool("pmslice_dump", false)){
        pmslice_file = fopen_nofail_with_dir(sim_cfg.real_log_dir.c_str(), "pmslice.csv", "w");
    }
#endif
#if WITH_PMCNT
    FILE* pmcnt_file = fopen_nofail_with_dir(sim_cfg.real_log_dir.c_str(), "pmcnt.csv", "w");
    uint64_t pmcnt_record_freq = config.get_value_or_else("pmcnt_record_freq",1000000);
    uint64_t pmcnt_record_next = pmcnt_record_freq;
#endif


#ifdef WITH_RECORD_PC
    bool with_record_pc = config.get_value_or_bool("with_record_pc", true);
#endif
#ifdef CONFIG_INSN_TRACE
    bool log_insn_trace = config.get_value_or_bool("log_insn_trace", true);
    FILE *trace_file = NULL;
    if (log_insn_trace) {
        trace_file = fopen_nofail_with_dir(sim_cfg.real_log_dir.c_str(), "insn_trace.bin", "wb");
    }
#endif

#if WITH_PMCNT
    bool pmcnt_started = false;
#endif

    // Create snapshot moniter
    snapshot = new Snapshot(true, rollback_dist);

    // Create framwork performance record moniter
    FPR fpr;

    contextp = new VerilatedContext;

    // Set debug level, 0 is off, 9 is highest presently used
    // May be overridden by commandArgs argument parsing
    contextp->debug(0);

    // Randomization reset policy
    // May be overridden by commandArgs argument parsing
    contextp->randReset(2);

    // Verilator must compute traced signals
    contextp->traceEverOn(true);

    // Pass arguments so Verilated code can see them, e.g. $value$plusargs
    // This needs to be called before you create any model

    contextp->commandArgs(argc - config.argc, argv + config.argc);
    log_info("Using verilator random seed:%d", contextp->randSeed());

    // Construct the Verilated model, from VTop.h generated from Verilating "Top.v".
    // Using unique_ptr is similar to "VTop* Top = new VTop" then deleting at end.
    // "Top" will be the hierarchical name of the module.
    VTop *Top = new VTop{contextp, "Sim_Top"};


    bool sym_ret;
    #if defined(WAVE_FST)
    trace = new VerilatedFstC;
    #elif defined(WAVE_VCD)
    trace = new VerilatedVcdC;
    #endif
    #ifndef WAVE_NONE
    string trace_name = sim_cfg.real_log_dir + "/wave" + trace_ext;
    #endif

    auto ram = RAM(0, sim_cfg.real_log_dir);
    auto random_test = rand64(&ram);

    extern std::string image_dir;
    sim_initialize(config, sim_cfg, ram, random_test);
    if (sim_cfg.with_serial && !checkpoint) {
        qemu_irq irq = qemu_allocate_irq(cpu_irq_handler, (void*)Top, 7);
        ram.ram_add_serial(irq);
    } else if (sim_cfg.with_serial && checkpoint) {
        qemu_irq irq = qemu_allocate_irq(cpu_irq_handler, (void*)Top, 7);
        ram.ram_load_serial(irq, (image_dir + "/checkpoint_serial.bin").c_str());
    }

    // Set VTop's input signals
    Top->reset = !1;
    Top->clk = 0;

    // Reset AXI
    Top->axi_r_valid = 0;
    Top->axi_b_valid = 0;

    Top->dump_pc = 0x000000C01C000000;
    Top->dump_pc = 0xffffffffffffffff;
    // Top->dump_pc = 0x9000000000982120;

    Top->dump_cycles = 0xffffffffffffffff;
    // Top->dump_cycles = 0x0;

    // this signal enable dump pc trace.
    // Top->debug_dump_on = 1;

    uint64_t sim_cycles = 0;
    if(sim_cfg.wave_begin_cycles != 0){
        snapshot->wave = 0;
    }

    // set ipc threshold to 0 when run random test
    int ipc_threshold = sim_cfg.run_random ? 0 : 1; 
    fpr.ipc_moniter_init(6,12,1,ipc_threshold,40000,ins_cnt_end,sim_cfg.run_random);
    fpr.record_start();
        INFO(PRINT_BOLDYELLOW,"[AXI_wrapper] Initializing.\n");
    #ifdef USE_DRAM_SIM
    MemorySim::AXI_wrapper axi_wrapper(Top,&ram,dramsim_config,sim_cfg.dramsim_output);
    #else
    AXISim::AXI_wrapper axi_wrapper(Top,&ram);
    #endif

    uint64_t dram_cnt = 0;//Dram用的计数器，用来分半频

    dbg_sim_cycles = 0;

    sim_wave_on = false;

    // Simulate until $finish
    while (!contextp->gotFinish() && !sim_finish && sim_cycles < sim_cycles_limit) {
        if (sim_cycles / 2 == sim_cfg.wave_begin_cycles) {
            //snapshot->wave = sim_cfg.runtime_wave;
        }
        if (sim_cycles / 2 == sim_cfg.wave_end_cycles) {
            //snapshot->wave = 0;
            sim_finish = true;
        }

        ++ sim_cycles;
        contextp->timeInc(1);
        Top->clk = !Top->clk;
        Top->eval();

        // if (Top->debug_wave_dump_on) {
        //     printf("debug_wave_dump_on :%lx\n", Top->debug_wave_dump_on);
        // }

        dbg_sim_cycles = Top->dbg_sim_cycles;

        // Turn ON wave dump
        if (Top->debug_wave_dump_on == 0x11) {
            sim_wave_on = true;
        } else if (Top->debug_wave_dump_on == 0xFF) {
        // Turn OFF wave dump
            sim_wave_on = false;
        }

        #define WAVE_DUMP_BEGIN_PC 0x9000000002821301
        #define WAVE_DUMP_END_PC   0xffffffff

        // open dump wave
        if ((Top->dbg_retire0_pc == WAVE_DUMP_BEGIN_PC) 
             && (Top->dbg_retire0_vld)) {
            if (!sim_wave_on) {
                sim_wave_on = true;
                printf("------ Open Wave Dump! ------\n");
            }
        }

        // close dump wave
        if ((Top->dbg_retire0_pc == WAVE_DUMP_END_PC) 
             && (Top->dbg_retire0_vld)) {
            if (sim_wave_on) {
                sim_wave_on = false;
                printf("------ Close Wave Dump! ------\n");
            }
        }

   
#ifndef WAVE_NONE
        if (snapshot->wave && snapshot->trace_opened) {
                trace->dump(sim_cycles);
        }
#endif

        if (contextp->time() >= 10) {
            axi_wrapper.handle_ar(sim_cycles);
            axi_wrapper.handle_r(sim_cycles);
            axi_wrapper.handle_aw(sim_cycles);
            axi_wrapper.handle_w(sim_cycles);
            axi_wrapper.handle_b(sim_cycles);
            
            #ifdef USE_DRAM_SIM
                dram_cnt += dram_tick_step;
                if(dram_cnt >= dram_tick_period){
                    dram_cnt -= dram_tick_period;
                    axi_wrapper.dramsim_tick();//Dram need a tick
                }
            #endif
        }

        if (sim_cycles/10 % 10000 == 1000) {
            ram.ram_update_io();
        }

        // Toggle control signals on an edge that doesn't correspond
        // to where the controls are sampled; in this example we do
        // this only on a negedge of clk, because we know
        // reset is not sampled there.
        ++ sim_cycles;
        contextp->timeInc(1);
        Top->clk = !Top->clk;
        if (contextp->time() > 1 && contextp->time() < 10) {
            Top->reset = !0;  // Assert reset
        } else {
            Top->reset = !1;  // Deassert reset
        }
        Top->eval();
        
#ifndef WAVE_NONE
        if (snapshot->wave && snapshot->trace_opened) {
            if (sim_wave_on)
                trace->dump(sim_cycles);
        }
#endif

#ifdef GEN_SNAPSHOT
        if(snapshot->snapshot_isparent()){
            int cycle = sim_cycles/2;
            if(cycle % snapshot_dist == 11){
                // snapshot->snapshot_stats();
                log_info("snapshot gen at cycle %d",cycle);
                snapshot->snapshot_gen();
            }
        }
#endif

        if(snapshot->trace_reopen){
            if(!snapshot->trace_opened){
                if (sim_wave_on) {
#ifndef WAVE_NONE
                    Top->trace(trace, 99, 0);
                    trace->open(trace_name.c_str());
#endif
                    snapshot->trace_reopen = false;
                    snapshot->trace_opened = true;
#if VERILATOR_THREAD_NUM > 1
#if VERILATOR_VERSION_INTEGER >= 4226000
                    Top->vlSymsp->__Vm_threadPoolp = new VlThreadPool(Top->contextp(), VERILATOR_THREAD_NUM);
#else
                    Top->vlSymsp->__Vm_threadPoolp = new VlThreadPool(Top->contextp(), VERILATOR_THREAD_NUM - 1, 0);
#endif
#endif
                }
            }
        }
    }

    if(snapshot->snapshot_isparent()){
        if(snapshot->error) {
            if(snapshot->trace_opened){
                log_info("Find error, and waveform is already opened. (Do not wake up snapshot)");
                sim_finish = true;
            }
            else{
                log_info("Find error, try to wake up snapshot");
                snapshot->snapshot_wakeup();
            }
        }
        else if(sim_cfg.snapshot_on_failure && contextp->gotFinish() && !snapshot->trace_opened){
            log_info("Find error, try to wake up snapshot");
            snapshot->snapshot_wakeup();
        }

    }

    #ifndef WAVE_NONE
    if(snapshot->trace_opened){
        trace->close();
        snapshot->trace_opened = false;
    }
    #endif

    // Final model cleanup
    Top->final();
    delete Top;

    DEBUG(DEBUG_MAIN,PRINT_DEBUG,"PID: %d, sim cycles: %ld",getpid(),sim_cycles);

    int ret = 0;
    if(snapshot->snapshot_isparent()){
        if (sim_cfg.run_random) {
            char cmd[1024];
            sprintf(cmd, "./print_trace 2 ./%s/insn_trace.bin %s", sim_cfg.real_log_dir.c_str(), config.get_value("random_test_dir").c_str());
            int r = system(cmd);
            if (r != 0) {
                ret = 1;
            }
        }
        snapshot->snapshot_stats();
        snapshot->snapshot_clear();
        delete snapshot;
        snapshot = nullptr;
        #if VM_COVERAGE
            Verilated::mkdir("logs");
            contextp->coveragep()->write("logs/coverage.dat");
        #endif
        delete contextp;
    }
    return ret;
}
