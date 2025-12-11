#ifndef CHIPLAB_DIFF_MANAGE_H
#define CHIPLAB_DIFF_MANAGE_H

#include <verilated.h>
#include <verilated_save.h>
#include "difftest.h"

extern Difftest** difftest;

class DiffManage {
public:
    int init_difftest();
    void init_ram(uint8_t* ram);
    int difftest_state();
    int do_step(vluint64_t& main_time);
    int check_end();
    void display();
    void fastforward(uint64_t cycles);
    void fastforward_end();
    void restore_checkpoint(const char* path);
    void save_checkpoint(const char* path);
    uint64_t get_fastforward_cycle();
    void write_csr_ref2dut();
    ~DiffManage();

    bool proxy_snapshot = false;
    uint64_t snapshot_dist = 0;
    uint64_t last_snapshot_time = 0;
    uint64_t proxy_snapshot_buffer[3][512];
    int proxy_buffer_index = 0;
    bool proxy_buffer_init = false;
};

#endif //CHIPLAB_DIFF_MANAGE_H
