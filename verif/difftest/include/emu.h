#ifndef CHIPLAB_EMU_H
#define CHIPLAB_EMU_H

#include <verilated.h>
#include <verilated_save.h>
#include "diff_manage.h"
#include "common.h"
#include "lightsss.h"

static const int status_cause        = 0xff;
static const int status_trace_err    = 0x700;
static const int status_trace_err_rf = 0x100;
static const int status_trace_err_pc = 0x200;
static const int status_perf_err     = 0x400;

static const int status_fork_forward = 0x800;

static const int status_exit         = 0x1f000;
static const int status_call_finish  = 0x1000;
static const int status_uart_exit    = 0x2000;
static const int status_test_end     = 0x4000;
static const int status_time_limit   = 0x8000;
static const int status_test_wait    = 0x10000;

static const int status_unhandled = 0x60000;
static const int status_unhandled_ex_code = 0x20000;
static const int status_unhandled_syscall = 0x40000;

#define CONFREG_UART_DATA       top->confreg_uart_data
#define CONFREG_UART_DISPLAY    top->write_uart_valid

class Emulator {
private:
    vluint64_t *main_time;
    int trapCode;
    bool need_wakeup=false;
    /* init ram. The ram img will be mapped to EMU. */
    void init_ram(const char*path, const char *file_in);
    uint64_t lasttime_snapshot = 0;
    LightSSS *lightsss = NULL;
    void fork_child_init();
    inline bool is_fork_child() {
        return lightsss->is_child();
    }
public:
    DiffManage* dm;
    uint8_t *ram;

    /* input: ram img path */
    char img[128];
    /* output path */
    char simu_out_path[128];
    char uart_out_path[128];

    Emulator(VTop *top, const char*path, const char* file_out, const char*uart_path, const char*file_in, const char*data_vlog);
    ~Emulator();
    void init_ram(uint8_t* ram);

    /* do init work such as init_difftest, init_nemuproxy */
    void init_emu(vluint64_t* main_time);
    void init_random_vlog(const char *path, const char *file_in);
    void set_need_wakeup(){
        need_wakeup=true;
    }

    uint32_t uptime(){
        struct timeval t;
        gettimeofday(&t, NULL);
        int s = t.tv_sec - start.tv_sec;
        int us = t.tv_usec - start.tv_usec;
        if (us < 0) {
            s--;
            us += 1000000;
        }
        return s * 1000 + (us + 500) / 1000;
    }//Obtain the time in milliseconds.
    /* difftest execute one step to compare dut and ref */
    int process();
    /* used by slice */
    void close();
    void fastforward(uint64_t cycles);
};

#endif //CHIPLAB_EMU_H
