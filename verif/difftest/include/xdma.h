#ifndef __XDMA_H__
#define __XDMA_H__
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <mutex>
#include <atomic>
#include <thread>
#include <condition_variable>
#include "difftest.h"



class XDMA {
public:
    XDMA(DiffManage* dm);
    void reset();

    int write_dev(uint64_t addr, void *buffer, uint64_t size);
    int read_dev(uint64_t addr, void *buffer, uint64_t size);
    int start();
    void stop();

private:
    void receive_func();
    void process_func();

    void first_commit();
    void diff(int end);

private:
    DiffManage* dm;
    int c2h_fd;
    int h2c_fd;
    bool running = false;
    bool firstCommit = false;

    std::mutex thread_mtx;
    std::condition_variable thread_cv;
    std::thread process_thread;
    std::thread receive_thread;
    uint8_t* receive_buffer;
    uint8_t* diff_buffer;
    int receive_index;
    int diff_recv_index;
    int diff_buff_offset;
    std::atomic_int receive_count;

    int trapCode;
};

#endif