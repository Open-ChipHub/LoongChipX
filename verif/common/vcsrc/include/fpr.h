#ifndef __FPR_H
#define __FPR_H

#include <sys/time.h>
#include <stdlib.h>
#include <stdint.h>
#include <string>
#include <fstream>
#include "log.h"

static inline double second(){
    struct timespec _t;
    clock_gettime(CLOCK_REALTIME, &_t);
    return _t.tv_sec + _t.tv_nsec/1.0e9;
}

using namespace std;

#define FPR_BUFSIZE  20
#define FPR_LOW_IPC  -1
#define FPR_INST_END -2
#define FPR_SYS_CRASH -3
#define FPR_CYCLE_END -4
#define FPR_SYS_PANIC -5

#define FPR_CYCLE_BOUND 1100000000ll
#define FPR_HIS_MAX 10

class FPR {
    // framwork related
    private:
    double time_start,time_end;
    int time_span;
    double last_cycles_time;
    const string history_file_path = "../RuntimeInfo/history.txt";
    const int version = 1;

    public:
    void record_start();
    void record_end();
    void record_perf();
    void compute_time_span();

    int  runtime_info_record();

    // core related
    private:
    int issue_width;
    int commit_width;
    int threshold;
    const string perf_file_path = "../RuntimeInfo/perf.txt";


    int window_threshold;
    int window_size;
    int window_cycle;
    int window_inst;
    bool* callback;

    uint64_t inst_upperbound;

    bool run_random;

    public:
    uint64_t cycle_his[FPR_HIS_MAX];
    uint64_t inst_his[FPR_HIS_MAX];
    int his_pt;
    uint64_t total_cylce;
    uint64_t total_inst;
    float ipc_last,ipc_last_last;
    int  ipc_moniter_init(int issue_width,int commit_width,int threshold,int window_threshold,int window_size,uint64_t inst_upperbound,bool run_random);
    int  ipc_moniter_commit(int cylces, uint8_t *commit);
    void ipc_moniter_cycles(uint64_t cycles);
    void ipc_moniter_stats();
};














#endif