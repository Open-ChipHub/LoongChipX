#include "sim_config.h"

#include <sys/stat.h>
#include <cassert>
#include <algorithm>

void SimConfig::setup_dir(Config& config){
    log_dir   = config.get_value_or_cstr("log_dir", "logs");
    image_dir = config.get_value_or_cstr("image_dir","");
    real_log_dir = log_dir + "/" + config.timestamp;
    // if (image_dir != "") {
    //     std::string tmp = image_dir;
    //     std::replace(tmp.begin(), tmp.end(), '/', '_');
    //     real_log_dir = log_dir + "/" + tmp + '_' + config.timestamp;
    // }
    mkdir(real_log_dir.c_str(), 0777);
    config.link_to(real_log_dir, log_dir + "/latest");
}

void SimConfig::setup(Config& config){
    run_random = config.get_value_or_bool("random_test" , false);
    run_kernel = config.get_value_or_bool("run_kernel" , false);
    load_image    = config.get_value_or_bool("load_image" , false);
    with_serial   = config.get_value_or_bool("with_serial", false);
    runtime_wave  = config.get_value_or_bool("runtime_wave", false);
    snapshot_on_dead = config.get_value_or_bool("snapshot_on_dead", true);
    snapshot_on_failure = config.get_value_or_bool("snapshot_on_failure", false);
    action_on_sigint = config.get_value_or_cstr("action_on_sigint", "quit");

    wave_begin_cycles = config.get_value_or_else("wave_begin" , 0         );
    wave_end_cycles   = config.get_value_or_else("wave_end"   , UINT64_MAX);
    sim_cycles_limit  = config.get_value_or_else("sim_cycles" , UINT64_MAX / 2) * 2;
    ins_cnt_end       = config.get_value_or_else("ins_cnt_end", UINT64_MAX);
    // by default, when run kernel, only record user performance counters
    pmcfg_plv = config.get_value_or_else("pmcfg_plv"   , run_kernel ? 0x8 : 0xf);
    watch_paddr = config.get_value_or_else("watch_paddr", 0);

    setup_dir(config);

    dramsim_output = real_log_dir;
    snapshot_dist   = config.get_value_or_else("snapshot_dist"   , 100000);
    rollback_dist   = config.get_value_or_else("rollback_dist"   , 1);
    #ifdef USE_DRAM_SIM
    dramsim_config = config.get_value_or_cstr("dramsim_config","../../common/memory/DRAMsim3/configs/DDR4_8Gb_x16_3200.ini");
    dram_tick_period = config.get_value_or_else("dramsim_tick_period",1);
    dram_tick_step   = config.get_value_or_else("dramsim_tick_step",1);
    assert(dram_tick_period > 0);
    assert(dram_tick_step   > 0);
    #endif
    
    random_test_seed = config.get_value_or_else("random_test_seed", time(NULL));
    random_test_mat  = config.get_value_or_else("random_test_mat", 0x1);
    random_fill_type = config.get_value_or_else("random_fill_type", 1);

    ipc_monitor_alert = config.get_value_or_bool("ipc_monitor_alert", false);
}
