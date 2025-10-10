#include <iostream>
#include "fpr.h"
#include <unistd.h>
#include <math.h>
#include "commonprint.h"

void FPR::record_start(){
    time_start = second();
    last_cycles_time = time_start;
}

void FPR::record_end(){
    time_end = second();
}

void FPR::compute_time_span(){
    time_span = (int)(time_end - time_start);
}

int FPR::runtime_info_record(){
    // runtime info
    bool first_run = false;
    int  run_times;
    int  runtime_last,runtime_avg;

    string res_buf[FPR_BUFSIZE];
    int i=0;
    fstream history_file;
    string history_info;
    history_file.open(history_file_path, ios::in);
    if (!history_file.is_open()){ // checking whether the file is open
        INFO(PRINT_BOLDYELLOW,"[FPR] Run for first time.\n");
        first_run = true;
    }else{
        while (getline(history_file, history_info)){
            res_buf[i++] = history_info;
        }
        if(res_buf[0].length() == 0){
            ERROR("History runtime info error.");
            first_run = true;
        }
    }

    if(first_run){
        run_times = 1;
        runtime_last = runtime_avg = time_span;
    }else{
        INFO(PRINT_BOLDYELLOW,"[FPR] Get history runtime info.\n");
        string run_times_his = res_buf[1].substr(11);
        DEBUG(DEBUG_FPR,PRINT_DEBUG,"run times his: %s",run_times_his.c_str());
        DEBUG(DEBUG_FPR,PRINT_DEBUG,"run times his: %d",atoi(run_times_his.c_str()));
        run_times = atoi(run_times_his.c_str()) + 1;
        runtime_last = time_span;
        runtime_avg = (atoi(res_buf[3].substr(13).c_str())*atoi(run_times_his.c_str()) + time_span)/run_times;
    }

    i = 0;
    fstream new_file;
    new_file.open(history_file_path, ios::out);
    if (!new_file.is_open()){ // checking whether the file is open
        ERROR("Open history file failed.\n");
        return -1;
    }
    new_file << "Centaur320 Runtime Info v" << version <<"\n";
    new_file << "Run times: " << run_times << "\n";
    new_file << "Runtime last: " << runtime_last << "\n";
    new_file << "Runtime avg: " << runtime_avg << "\n";
    return 0;
}

int FPR::ipc_moniter_init(int issue_width,int commit_width,int threshold,int window_threshold,int window_size,uint64_t inst_upperbound,bool run_random){
    this->issue_width = issue_width;
    this->commit_width = commit_width;
    this->threshold = threshold;
    this->window_threshold = window_threshold;
    this->window_size = window_size;
    this->inst_upperbound = inst_upperbound;
    this->run_random = run_random;
    fstream perf_file;
    perf_file.open(perf_file_path, ios::out);
    perf_file.close();

    this->total_cylce = 0;
    this->total_inst = 0;
    this->window_cycle = 0;
    this->window_inst = 0;
    this->ipc_last=0.0;
    this->ipc_last_last=0.0;

    this->his_pt=0;

    return 0;
}

int FPR::ipc_moniter_commit(int cycles, uint8_t *commit){
    int commit_num =0;
    for(int i=0;i<this->commit_width;i++){
        commit_num+=(int)(commit[i]);
    }
    fstream perf_file;
    // if(commit_num < threshold){
    //     perf_file.open(perf_file_path, ios::app);
    //     perf_file << "cycle: " << cycles << " ipc: " << commit_num << "\n";
    //     perf_file.close();
    // }
    total_cylce++;
    total_inst+=commit_num;
    window_cycle++;
    window_inst+=commit_num;
    if(total_inst>=100000000*(his_pt+1)){
        if(his_pt < FPR_HIS_MAX){
            cycle_his[his_pt] = total_cylce;
            inst_his[his_pt++] = total_inst;
        } 
    }
    if(total_inst>=inst_upperbound) return FPR_INST_END;
    if(total_cylce>=FPR_CYCLE_BOUND) return FPR_CYCLE_END;
    if(window_cycle>=window_size && total_cylce>20000){
        double ipc = (double)window_inst/(double)window_cycle;
        if(ipc <= 0.00001){
            log_error("ipc < 0.00001, may crash! %f ,cycle:%d  insts:%d\n",ipc,total_cylce,total_inst);
            return FPR_SYS_CRASH;
        }
        else if(!run_random && fabs(ipc - 0.5000)<0.0001 && fabs(ipc_last - 0.5000)<0.0001 && fabs(ipc_last_last - 0.5000)<0.0001){
            char dir[1024];
            getcwd(dir,1024);
            log_error("ipc = 0.5000, may panic %f ,cycle:%d  insts:%d\nerror locate in %s",ipc,total_cylce,total_inst,dir);
            // return FPR_SYS_PANIC;
            return 0;
        }else if(ipc <= (double)window_threshold){
            char dir[1024];
            getcwd(dir,1024);
            log_warn("ipc abnormal! %f ,cycle:%d  insts:%d\nerror locate in %s",ipc,total_cylce,total_inst,dir);
            window_cycle = 0;
            window_inst = 0;
            ipc_last = ipc;
            ipc_last_last = ipc_last;
            return FPR_LOW_IPC;
        }

        ipc_last = ipc;
        ipc_last_last = ipc_last;
        window_cycle = 0;
        window_inst = 0;
    }
    
    return 0;
}

void FPR::ipc_moniter_cycles(uint64_t cycles) {
    double current_time = second();
    log_info("sim cycles:%ld, insts:%ld, last time span:%f, average time span:%f", cycles, total_inst, current_time - this->last_cycles_time, (current_time - this->time_start) / ((double)cycles / 10000));
    this->last_cycles_time = current_time;
}

void FPR::ipc_moniter_stats(){
    fstream perf_file;
    double ipc = total_inst/total_cylce;
    perf_file.open(perf_file_path, ios::app);
    perf_file << "[Summary]\n"
              << "- total cycle: " << total_cylce << "\n"
              << "- total inst: " << total_inst << "\n"
              << "- ipc: " << 1.0 * total_inst / total_cylce << "\n"
              << "[end]" << endl;
    perf_file.close();
}
