#pragma once
#include<cstdint>
#include<string>

#include "config.h"
#include "build_config.h"

class SimConfig{
public:
    bool run_random ;
    bool run_kernel ;
    bool load_image    ;
    bool with_serial   ;
    bool runtime_wave  ;
    bool snapshot_on_dead ;

    uint64_t wave_begin_cycles ;
    uint64_t wave_end_cycles;
    uint64_t sim_cycles_limit  ;
    uint64_t ins_cnt_end       ;
    uint64_t watch_paddr ;

    // directories
    std::string image_dir;
    std::string log_dir;
    std::string real_log_dir;
    std::string dramsim_output;

    #ifdef USE_DRAM_SIM
    std::string dramsim_config ;
    uint64_t dram_tick_period ;
    uint64_t dram_tick_step   ;
    #endif
    uint64_t random_test_seed ;
    uint64_t random_test_mat  ;
    uint64_t random_fill_type ;
    bool ipc_monitor_alert    ;

    // only for verilator backend
    uint64_t snapshot_dist   ;
    uint64_t rollback_dist   ;
    uint64_t pmcfg_plv ;
    bool snapshot_on_failure ;
    std::string action_on_sigint ;

    void setup(Config& config);
    void setup_dir(Config& config);
};
