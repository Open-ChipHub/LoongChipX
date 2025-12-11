#include "diff_manage.h"
#include "common.h"

Difftest** difftest = NULL;
extern long long inst_total;

int DiffManage::init_difftest() {
    difftest = new Difftest*[NUM_CORES];
    for (int i = 0; i < NUM_CORES; ++i) {
        difftest[i] = new Difftest(i);
    }
    return 0;
}

void DiffManage::init_ram(uint8_t* ram){
    for (int i = 0; i < NUM_CORES; i++) {
        difftest[i]->init_ram(ram);
    }
}

int DiffManage::difftest_state() {
    /* trap as long as any core trapping */
    for (int i = 0; i < NUM_CORES; i++) {
        if (difftest[i]->get_trap_valid()) {
            return difftest[i]->get_trap_code();
        }
    }
    return STATE_RUNNING;
}

int DiffManage::do_step(vluint64_t &main_time) {
    if (proxy_snapshot && inst_total - last_snapshot_time >= snapshot_dist) {
        if (proxy_buffer_init || difftest[0]->first_commit) {
            difftest[0]->get_proxy()->save_checkpoint("snapshot.ckpt", proxy_snapshot_buffer[proxy_buffer_index], true);
            last_snapshot_time = inst_total;
            proxy_buffer_index = (proxy_buffer_index + 1) % 3;
            proxy_buffer_init = true;
        }
    }
    int ret = 0;
    for (int i = 0; i < NUM_CORES; ++i) {
        ret = difftest[i]->step(main_time);
        if (ret)
            return ret;
    }
    return STATE_RUNNING;
}

int DiffManage::check_end() {
    int end = 0;
    for (int i = 0; i < NUM_CORES; ++i) {
        end |= difftest[i]->get_proxy_check_end();
    }
    if (end) {
        printf("END by Syscall\n");
    #ifdef RAND_TEST
        printf("Random_PASS\n");
    #endif
    }
    return end;
}

void DiffManage::display() {
    for (int i = 0; i < NUM_CORES; ++i) {
        difftest[i]->display();
    }
}

void DiffManage::fastforward(uint64_t cycles) {
    difftest[0]->_fastforward = true;
    difftest[0]->fastforward(cycles);
}

void DiffManage::fastforward_end() {
    difftest[0]->_fastforward = false;
}

uint64_t DiffManage::get_fastforward_cycle() {
    return difftest[0]->_fastforward_cycles;
}

void DiffManage::save_checkpoint(const char* path) {
    if (proxy_snapshot && proxy_buffer_init) {
        proxy_buffer_index = proxy_buffer_index == 0 ? 2 : proxy_buffer_index - 1;
        difftest[0]->get_proxy()->restore_checkpoint(path, proxy_snapshot_buffer[proxy_buffer_index], true);
    }
    difftest[0]->get_proxy()->save_checkpoint(path, NULL, false);
}

void DiffManage::restore_checkpoint(const char* path) {
    difftest[0]->get_proxy()->restore_checkpoint(path, NULL, false);
}

void DiffManage::write_csr_ref2dut() {
    for (int i = 0; i < NUM_CORES; ++i) {
        difftest[i]->write_csr_ref2dut();
    }
}

DiffManage::~DiffManage() {
    for(int i = 0; i < NUM_CORES; ++i) {
        delete difftest[i];
        difftest[i] = NULL;
    }
    delete difftest;
    difftest = NULL;
}
