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
    ~DiffManage();
};

#endif //CHIPLAB_DIFF_MANAGE_H
