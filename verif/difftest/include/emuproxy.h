#ifndef CHIPLAB_NEMUPROXY_H
#define CHIPLAB_NEMUPROXY_H

#include <stdio.h>
#include <stdint.h>

struct la64_timer {
    // for stable_counter
    uint64_t counter_id;
    uint64_t stable_timer;
    // for TVAL csr
    uint64_t time_val;
};

typedef uint64_t paddr_t;
typedef uint64_t vaddr_t;

class EmuProxy {
private:
    void* handle = NULL;
public:
    /* coreid is used to distinguish multi-cores */
    EmuProxy(int coreid);
    ~EmuProxy();

    void (*memcpy)(paddr_t emu_addr, void* dut_buf, size_t n, bool direction);
    void (*regcpy)(void* dut, bool direction, int reg_type);
    void (*csrcpy)(void* dut, bool direction);
    void (*csrcpy_idx)(int csr_idx, uint64_t* dut_buf, uint64_t mask, bool direction);
    int  (*store_commit)(uint64_t saddr, uint64_t sdata);
    void (*exec)(uint64_t n);
    void (*raise_trap)(int is_interrupt, uint64_t is, uint64_t ecode);
    void (*isa_reg_display)();
    void (*timercpy)(void* dut);
    void (*estat_sync)(uint64_t index, uint64_t mask);
    void (*init)(uint8_t* ram);
    uint32_t (*get_inst)(uint64_t addr);
    uint64_t (*get_cur_pc)(void);
    uint64_t (*get_prev_pc)(void);
    int  (*check_end)();
};

#define check_and_assert(func)                \
    do {                                      \
        if (!func) {                          \
            printf("ERROR: %s\n", dlerror()); \
            assert(func);                     \
        }                                     \
    } while (0);

#endif //CHIPLAB_NEMUPROXY_H
