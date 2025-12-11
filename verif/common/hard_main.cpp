

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

#ifdef CONFIG_DIFFTEST
#include "emu.h"
#endif

#ifdef CONFIG_DIFFTEST
Emulator *emulator;
extern char* difftest_ref_so;
#endif
extern long long inst_total;

Snapshot* snapshot = nullptr;
SimConfig sim_cfg;

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
    printf("SIGINT handler, inst_num: %lx\n", inst_total);
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

void load_mem(uint8_t* mem, const char* path) {
    FILE* fd = fopen(path, "r");
    if (fd < 0) {
        perror("open mem file");
        return;
    }
    while (!feof(fd)) {
        uint64_t addr = 0;
        char buf[10240];
        uint8_t buf_rev[10240];
        char buf_char[3];
        buf_char[3] = '\0';
        int ret = fscanf(fd, "%lx", &addr);
        if (ret != 1) {
            break;
        }
        fscanf(fd, "%s", buf);
        for (int i = 0; i < strlen(buf) / 2; i++) {
            int ix2 = i << 1;
            buf_char[0] = buf[strlen(buf) - 2 - ix2];
            buf_char[1] = buf[strlen(buf) - 1 - ix2];
            mem[addr + i] = strtol(buf_char, NULL, 16);
        }

    }
    fclose(fd);
}

uint64_t dbg_sim_cycles;
bool checkpoint = false;

int main(int argc, char** argv, char** env) {

    // Prevent unused variable warnings
    if (false && argc && argv && env) {}

    atexit(clear_simulator);
    signal(SIGINT,&sigint_handler);
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
    uint64_t random_test_seed = config.get_value_or_else("random_test_seed", 0);
    uint64_t random_test_mat  = config.get_value_or_else("random_test_mat", 0x1);
    uint64_t random_fill_type = config.get_value_or_else("random_fill_type", 1);

    uint64_t sim_cycles = 0;
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

    auto now = std::chrono::system_clock::now();

    const char simu_trace_file[] = "./simu_trace.txt";
    const char uart_output_file[] = "./uart_output.txt";
    const char ram_file[] = "ram.dat";
    const char data_vlog_file[] = "data.vlog";

    const char* diff_so = config.get_value_or_cstr("diff_so_path", NULL);
    if (diff_so != NULL) {
        difftest_ref_so = const_cast<char*>(diff_so);
    }

    emulator = new Emulator(NULL, "./", simu_trace_file, uart_output_file, ram_file, data_vlog_file);
    emulator->init_emu(&sim_cycles, sim_cfg.snapshot_dist, true);

    uint8_t* emulator_ram = (uint8_t*)mmap(nullptr, (2ull << 32), PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
    if (!emulator_ram) {
        printf("Mmap Error!\n");
        exit(1);
    }
    
    load_mem(emulator_ram, sim_cfg.image_path.c_str());
    emulator->init_ram(emulator_ram, (2ull << 32));
    int result = emulator->hard_process(ram.addr_maps);
    if (sim_cfg.checkpoint_on_failure && !result) {
        // BUG: 内存没有回滚，只是寄存器回滚了(使用snapshot替换)
        emulator->save_checkpoint(sim_cfg.real_log_dir.c_str());
    }
    auto elapsed_time = std::chrono::duration_cast<std::chrono::milliseconds>(std::chrono::system_clock::now()-now);
    printf("Guest cycle spent: %ld (this will be different from cycleCnt if emu loads a snapshot)\n",
        sim_cycles);
    printf("Host time spent: %'ldms\n" , elapsed_time.count());
    printf("total inst: %ld\n", inst_total);
    return 0;
}