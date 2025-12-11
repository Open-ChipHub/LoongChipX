#include "xdma.h"
#include <unistd.h>

#define XDMA_BLOCK_SIZE 64
#define XDMA_BUFFER_NUM 64
#define XDMA_SINGLE_TRANSFER_SIZE 8
#define XDMA_BUFFER_SIZE (XDMA_BLOCK_SIZE * XDMA_BUFFER_NUM)
#define XDMA_DIFF_ADDRESS 0x13ff00000ULL
#define XDMA_RESET_ADDRESS 0x12ff00000ULL

extern Difftest** difftest;

template <typename Func, typename Obj, typename... Args> void thread_wrapper(Func func, Obj obj, Args... args) {
  signal(SIGSEGV, signal_handler);
  (obj->*func)(args...);
}

XDMA::XDMA(DiffManage* dm) {
    this->dm = dm;
    c2h_fd = open("/dev/xdma0_c2h_0", O_RDONLY);
    if (c2h_fd == -1) {
        perror("open c2h_fd");
        exit(-1);
    }
    h2c_fd = open("/dev/xdma0_h2c_0", O_WRONLY);
    if (h2c_fd == -1) {
        perror("open h2c_fd");
        exit(-1);
    }
    if (posix_memalign(&receive_buffer, 4096, XDMA_BUFFER_SIZE) != 0) {
        perror("posix_memalign");
        exit(-1);
    }
    if (posix_memalign(&diff_buffer, 4096, XDMA_BUFFER_SIZE + XDMA_BLOCK_SIZE) != 0) {
        perror("posix_memalign");
        exit(-1);
    }

    receive_count.store(0, std::memory_order_relaxed);
    receive_index = 0;
    diff_recv_index = 0;
    diff_buff_offset = 0;
    trapCode = STATE_RUNNING;
}

int XDMA::start() {
    reset();
    running = true;
    std::unique_lock<std::mutex> lock(thread_mtx);

    receive_thread = std::thread(thread_wrapper<decltype(&XDMA::receive_func), XDMA>, &XDMA::receive_func, this);
    process_thread = std::thread(thread_wrapper<decltype(&XDMA::process_func), XDMA>, &XDMA::process_func, this);
    
    while (running) {
        thread_cv.wait(lock); // wait notify from stop
    }

    receive_thread.join();
    process_thread.join();
    close(c2h_fd);
    close(h2c_fd);
    
    return trapCode;
}

void XDMA::stop() {
    running = false;
    thread_cv.notify_one();
}

void XDMA::reset() {
    int data = 1;
    write_dev(XDMA_RESET_ADDRESS, &data, sizeof(int));
    usleep(500000);
    write_dev(XDMA_RESET_ADDRESS, &data, sizeof(int));
    usleep(500000);
}

int XDMA::read_dev (uint64_t addr, void *buffer, uint64_t size) {
    if ( addr != lseek(c2h_fd, addr, SEEK_SET) )                                 // seek
        return -1;                                                               // seek failed
    if ( size != read(c2h_fd, buffer, size) )                                    // read device to buffer
        return -1;                                                               // read failed
    return 0;
}

int XDMA::write_dev (uint64_t addr, void *buffer, uint64_t size) {
    if ( addr != lseek(h2c_fd, addr, SEEK_SET) )                                 // seek
        return -1;                                                               // seek failed
    if ( size != write(h2c_fd, buffer, size) )                                   // write device from buffer
        return -1;                                                               // write failed
    return 0;
}

void XDMA::receive_func() {
    while (running) {
        if (receive_count > XDMA_BUFFER_NUM - XDMA_SINGLE_TRANSFER_SIZE) {
            continue;
        }
        int ret = read_dev(receive_buffer + receive_index, XDMA_DIFF_ADDRESS, XDMA_BLOCK_SIZE * XDMA_SINGLE_TRANSFER_SIZE);
        if (ret == -1) {
            printf("read c2h_fd failed\n");
            continue;
        }
        receive_count.fetch_add(XDMA_SINGLE_TRANSFER_SIZE, std::memory_order_release);
        receive_index = (receive_index + XDMA_SINGLE_TRANSFER_SIZE * XDMA_BLOCK_SIZE) % XDMA_BUFFER_SIZE;
    }
}

void XDMA::process_func() {
    while (running) {
        int current = receive_count.load(std::memory_order_acquire);
        if (current == 0) {
            continue;
        }
        // if (!firstCommit) {
        //     if (current >= DIFFTEST_CORE_STATE_SIZE) {
        //         first_commit();
        //         diff_recv_index = DIFFTEST_CORE_STATE_SIZE + (XDMA_BLOCK_SIZE - DIFFTEST_CORE_STATE_SIZE % XDMA_BLOCK_SIZE);
        //         receive_count.fetch_sub(diff_recv_index, std::memory_order_release);
        //     }
        //     return;
        // }
        for (int i = 0; i < current; i++) {
            memcpy(diff_buffer + diff_buff_offset + i * XDMA_BLOCK_SIZE, receive_buffer + (diff_recv_index + i * XDMA_BLOCK_SIZE) % XDMA_BUFFER_SIZE, XDMA_BLOCK_SIZE);
        }
        diff(diff_buff_offset + current * XDMA_BLOCK_SIZE);
        receive_count.fetch_sub(current, std::memory_order_release);
    }
}

void XDMA::first_commit() {
    firstCommit = true;
    for (int i = 0; i < NUM_CORES; i++) {
        auto trap = difftest[i]->get_trap_event();
        trap->valid = receive_buffer[0];
        trap->code = receive_buffer[1];
        trap->pc = *((uint64_t*)(receive_buffer + 2));
        trap->cycleCnt = *((uint64_t*)(receive_buffer + 10));
        trap->instrCnt = *((uint64_t*)(receive_buffer + 18));

        auto excp = difftest[i]->get_excp_event();
        excp->excp_valid = receive_buffer[0];
        excp->eret = receive_buffer[1];
        excp->interrupt = *((uint64_t*)(receive_buffer + 2));
        excp->exception = *((uint64_t*)(receive_buffer + 10));
        excp->exceptionPC = *((uint64_t*)(receive_buffer + 18));
        excp->exceptionInst = *((uint64_t*)(receive_buffer + 26));

        for (int j = 0; j < DIFFTEST_COMMIT_WIDTH; j++) {
            auto commit = difftest[i]->get_instr_commit(j);
            commit->valid = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE];
            commit->pc = *((uint64_t*)(receive_buffer + INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 1));
            commit->inst = *((uint32_t*)(receive_buffer + INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 9));
            commit->skip = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 13];
            commit->is_TLBFILL = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 14];
            commit->TLBFILL_index = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 15];
            commit->is_CNTinst = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 16];
            commit->timer_64_value = *((uint64_t*)(receive_buffer + INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 17));
            commit->wen = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 25];
            commit->wdest = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 26];
            commit->wdata = *((uint64_t*)(receive_buffer + INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 27));
            commit->csr_rstat = receive_buffer[INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 35];
            commit->csr_data = *((uint64_t*)(receive_buffer + INSTR_COMMIT_OFFSET + j * INSTR_COMMIT_SIZE + 36));
        }

        auto greg = difftest[i]->get_arch_greg_state();
        memcpy(greg, receive_buffer + ARCH_GREG_STATE_OFFSET, ARCH_GREG_STATE_SIZE);

        auto csr = difftest[i]->get_arch_csr_state();
        memcpy(csr, receive_buffer + ARCH_CSR_STATE_OFFSET, ARCH_CSR_STATE_SIZE);

        for (int j = 0; j < DIFFTEST_COMMIT_WIDTH; j++) {
            auto store = difftest[i]->get_instr_store(j);
            store->valid = receive_buffer[STORE_EVENT_OFFSET + j * INSTR_STORE_SIZE];
            store->paddr = *((uint64_t*)(receive_buffer + STORE_EVENT_OFFSET + j * INSTR_STORE_SIZE + 1));
            store->data = *((uint64_t*)(receive_buffer + STORE_EVENT_OFFSET + j * INSTR_STORE_SIZE + 9));
            store->mask = *((uint8_t*)(receive_buffer + STORE_EVENT_OFFSET + j * INSTR_STORE_SIZE + 17));
        }

        for (int j = 0; j < DIFFTEST_COMMIT_WIDTH; j++) {
            auto load = difftest[i]->get_instr_load(j);
            load->valid = receive_buffer[LOAD_EVENT_OFFSET + j * INSTR_LOAD_SIZE];
            load->paddr = *((uint64_t*)(receive_buffer + LOAD_EVENT_OFFSET + j * INSTR_LOAD_SIZE + 1));
            load->vaddr = *((uint64_t*)(receive_buffer + LOAD_EVENT_OFFSET + j * INSTR_LOAD_SIZE + 9));
        }

        for (int j = 0; j < 2; j++) {
            auto tlb = difftest[i]->get_instr_tlb(j);
            tlb->valid = receive_buffer[TLB_EVENT_OFFSET + j * INSTR_TLB_SIZE];
            tlb->source = receive_buffer[TLB_EVENT_OFFSET + j * INSTR_TLB_SIZE + 1];
            tlb->vpn = *((uint64_t*)(receive_buffer + TLB_EVENT_OFFSET + j * INSTR_TLB_SIZE + 2));
            tlb->ppn = *((uint64_t*)(receive_buffer + TLB_EVENT_OFFSET + j * INSTR_TLB_SIZE + 10));
            tlb->exception = *((uint32_t*)(receive_buffer + TLB_EVENT_OFFSET + j * INSTR_TLB_SIZE + 18));
        }
    }
}

void XDMA::diff(int end) {
    uint16_t offset = 0;
    uint16_t start_offset;
    while (1) {
        start_offset = offset;
        for (int i = 0; i < NUM_CORES; i++) {
            uint8_t event_valids = diff_buffer[offset];
            offset += 1;
            uint16_t package_size = *((uint16_t*)(diff_buffer + offset));
            offset += 2;
            if (end - start_offset < package_size || offset >= end) {
                goto no_enough_mem;
            }
            if (event_valids & 0x1) {
                auto trap = difftest[i]->get_trap_event();
                trap->valid = 1;
                uint8_t mask = diff_buffer[offset];
                offset++;
                if (mask & 0x1) {
                    trap->code = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x2) {
                    trap->pc = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x4) {
                    trap->cycleCnt = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x8) {
                    trap->instrCnt = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
            }

            if (event_valids & 0x2) {
                auto excp = difftest[i]->get_excp_event();
                excp->excp_valid = 1;
                uint8_t mask = diff_buffer[offset];
                offset++;
                if (mask & 0x1) {
                    excp->eret = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x2) {
                    excp->interrupt = *((uint64_t*)(diff_buffer + offset));
                    offset += 4;
                }
                if (mask & 0x4) {
                    excp->exception = *((uint64_t*)(diff_buffer + offset));
                    offset += 4;
                }
                if (mask & 0x8) {
                    excp->exceptionPC = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x10) {
                    excp->exceptionInst = *((uint64_t*)(diff_buffer + offset));
                    offset += 4;
                }
            }

            if (event_valids & 0x4) {
                auto commit = difftest[i]->get_instr_commit(0);
                commit->valid = 1;
                uint16_t mask = *((uint16_t*)(diff_buffer + offset));
                offset += 2;
                if (mask & 0x1) {
                    commit->pc = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x2) {
                    commit->inst = *((uint64_t*)(diff_buffer + offset));
                    offset += 4;
                }
                if (mask & 0x4) {
                    commit->skip = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x8) {
                    commit->is_TLBFILL = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x10) {
                    commit->TLBFILL_index = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x20) {
                    commit->is_CNTinst = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x40) {
                    commit->timer_64_value = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x80) {
                    commit->wen = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x100) {
                    commit->wdest = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x200) {
                    commit->wdata = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x400) {
                    commit->csr_rstat = diff_buffer[offset];
                    offset++;
                }
                if (mask & 0x800) {
                    commit->csr_data = *((uint32_t*)(diff_buffer + offset));
                    offset += 4;
                }
            }

            // GREG_EVENT FPREG_EVENT CSR_EVENT
            if (event_valids & 0x8) {
                auto greg = difftest[i]->get_greg_state();
                auto csr = difftest[i]->get_csr_event();
                uint8_t num = diff_buffer[offset];
                offset++;
                for (int j = 0; j < num; j++) {
                    uint8_t greg_offset = diff_buffer[offset];
                    offset++;
                    if (greg_offset < 66) {
                        greg->greg[greg_offset] = *((uint64_t*)(diff_buffer + offset));
                    } else {
                        *((uint64_t*)(csr) + (greg_offset - 66)) = *((uint64_t*)(diff_buffer + offset));
                    }
                    offset += 8;
                }
            }

            if (event_valids & 0x10) {
                auto store = difftest[i]->get_store_event(0);
                store->valid = 1;
                uint8_t mask = diff_buffer[offset];
                offset++;
                if (mask & 0x1) {
                    store->paddr = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x2) {
                    store->data = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x4) {
                    store->mask = *((uint64_t*)(diff_buffer + offset));
                    offset++;
                }
            }

            if (event_valids & 0x20) {
                auto load = difftest[i]->get_load_event(0);
                load->valid = 1;
                uint8_t mask = diff_buffer[offset];
                offset++;
                if (mask & 0x1) {
                    load->paddr = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
                if (mask & 0x2) {
                    load->vaddr = *((uint64_t*)(diff_buffer + offset));
                    offset += 8;
                }
            }

            for (int j = 0; j < 2; j++) {
                if (event_valids & (0x40 << j)) {
                    auto tlb = difftest[i]->get_tlb_event(j);
                    tlb->valid = 1;
                    uint8_t mask = diff_buffer[offset];
                    offset++;
                    if (mask & 0x1) {
                        tlb->source = *((uint64_t*)(diff_buffer + offset));
                        offset++;
                    }
                    if (mask & 0x2) {
                        tlb->vpn = *((uint64_t*)(diff_buffer + offset));
                        offset += 8;
                    }
                    if (mask & 0x4) {
                        tlb->ppn = *((uint64_t*)(diff_buffer + offset));
                        offset += 8;
                    }
                    if (mask & 0x8) {
                        tlb->exception = diff_buffer[offset];
                        offset += 4;
                    }
                }
            }

            trapCode = dm->do_step(difftest[0]->get_trap_event()->cycleCnt);
            switch (trapCode) {
                case STATE_END:
                case STATE_TIME_LIMIT:
                    stop();
                    return;
                default:
                    dm->display();
                    return;
            }

            // clear valid siganls
            auto trap = difftest[i]->get_trap_event();
            trap->valid = 0;
            auto excp = difftest[i]->get_excp_event();
            excp->excp_valid = 0;
            for (int j = 0; j < DIFFTEST_COMMIT_WIDTH; j++) {
                auto commit = difftest[i]->get_commit_event(j);
                commit->valid = 0;
                auto store = difftest[i]->get_store_event(j);
                store->valid = 0;
                auto load = difftest[i]->get_load_event(j);
                load->valid = 0;
            }
            for (int j = 0; j < 2; j++) {
                auto tlb = difftest[i]->get_tlb_event(j);
                tlb->valid = 0;
            }
        }
    }

no_enough_mem:;
    diff_buff_offset = end - start_offset;
    for (int i = 0; i < diff_buff_offset; i++) {
        diff_buffer[i] = diff_buffer[start_offset + i];
    }
}