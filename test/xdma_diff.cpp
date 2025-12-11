#include <stdio.h>
#include <verilated.h>
#include <verilated_save.h>
#include <verilated_fst_c.h>
#include <queue>
#include "VTop.h"
#include "VTop__Syms.h"
#include "VTop___024root.h"

#define DIFFTEST_COMMIT_WIDTH 6
#define NUM_CORES 1
typedef struct {
    uint8_t valid = 0;
    uint8_t code;
    uint64_t pc;
    uint64_t cycleCnt = 0;
    uint64_t instrCnt = 0;
} trap_event_t;

typedef struct {
    uint8_t excp_valid = 0;
    uint8_t eret;
    uint64_t interrupt;
    uint64_t exception;
    uint64_t exceptionPC;
    uint64_t exceptionInst;
} excp_event_t;

typedef struct {
    uint8_t valid = 0;
    uint64_t pc;
    uint32_t inst;
    uint8_t skip;
    uint8_t is_TLBFILL;
    uint8_t TLBFILL_index;
    uint8_t is_CNTinst;
    uint64_t timer_64_value;
    uint8_t wen;
    uint8_t wdest;
    uint64_t wdata;
    uint8_t csr_rstat;
    uint64_t csr_data;
} instr_commit_t;

typedef struct {
    uint64_t gpr[32];
    uint64_t fpr[32];
    uint64_t fccr;
    uint64_t fcsr0;
} arch_greg_state_t;

typedef struct __attribute__((packed)) {
    uint64_t crmd;
    uint64_t prmd;
    uint64_t euen;
    uint64_t ecfg;
    uint64_t era, badv, eentry;
    uint64_t tlbidx, tlbehi, tlbelo0, tlbelo1;
    uint64_t asid, pgdl, pgdh;
    uint64_t save0, save1, save2, save3;
    uint64_t tid, tcfg, tval; // ticlr;
    uint64_t llbctl, tlbrentry, dmw0, dmw1;
    uint64_t estat;
    uint64_t cur_pc;
} arch_csr_state_t;



typedef struct __attribute__((packed)) {
    uint64_t cntc;
    uint64_t ticlr;
    uint64_t misc;
    uint64_t badi;
    uint64_t pwcl;
    uint64_t pwch;
    uint64_t stlbps;
    uint64_t rvacfg;
    uint64_t tlbrehi;
} arch_csr_state_t_ext;

typedef struct {
    uint8_t  valid = 0;
    uint64_t paddr;
    uint64_t data;
    uint8_t  mask;
} store_event_t;



typedef struct {
    uint8_t valid = 0;
    uint64_t paddr;
    uint64_t vaddr;
} load_event_t;


typedef struct {
    uint8_t valid = 0;
    uint8_t source;
    uint64_t vpn;
    uint64_t ppn;
    uint32_t exception;
} tlb_event_t;


typedef struct {
    trap_event_t trap;
    excp_event_t excp;
    instr_commit_t commit[DIFFTEST_COMMIT_WIDTH];
    arch_greg_state_t regs;
    arch_csr_state_t csr;
    store_event_t store[DIFFTEST_COMMIT_WIDTH];
    load_event_t load[DIFFTEST_COMMIT_WIDTH];
    tlb_event_t tlb[2];
} difftest_core_state_t;

difftest_core_state_t ref;
std::queue<difftest_core_state_t> ref_queue;
int diff_buff_offset = 0;
char diff_buffer[163840];
uint64_t cycle = 0;
uint64_t sim_cycle = 0;

FILE* out_fp;

void diff(int end) {
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
                auto trap = &ref.trap;
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
                auto excp = &ref.excp;
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
                auto commit = &ref.commit[0];
                commit->valid = 1;
                uint16_t commit_start_offset = offset;
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
                auto greg = &ref.regs;
                auto csr = &ref.csr;
                uint8_t num = diff_buffer[offset];
                offset++;
                for (int j = 0; j < num; j++) {
                    uint8_t greg_offset = diff_buffer[offset];
                    offset++;
                    if (greg_offset < 66) {
                        ((uint64_t*)greg)[greg_offset] = *((uint64_t*)(diff_buffer + offset));
                    } else {
                        *((uint64_t*)(csr) + (greg_offset - 66)) = *((uint64_t*)(diff_buffer + offset));
                    }
                    offset += 8;
                }
            }

            if (event_valids & 0x10) {
                auto store = &ref.store[0];
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
                auto load = &ref.load[0];
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
                    auto tlb = &ref.tlb[j];
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

            if (package_size != offset - start_offset) {
                printf("decode package size error, package_size: %d, offset: %d, start_offset: %d\n", package_size, offset, start_offset);
            }
            printf("start_offset: %d, size: %d, end: %d\n", start_offset, offset - start_offset, end);
            ref_queue.push(ref);
        }
    }

no_enough_mem:;
    diff_buff_offset = end - start_offset;
    for (int i = 0; i < diff_buff_offset; i++) {
        diff_buffer[i] = diff_buffer[start_offset + i];
    }
}

// Compare ref and dut and print differences
void print_diff(const difftest_core_state_t& ref, const difftest_core_state_t& dut, uint64_t cycle) {
    printf("diff at cycle %ld\n", cycle);
    
    // Compare trap event
    if (memcmp(&ref.trap, &dut.trap, sizeof(trap_event_t)) != 0) {
        printf("  Trap event difference:\n");
        printf("    ref.valid: %d, dut.valid: %d\n", ref.trap.valid, dut.trap.valid);
        printf("    ref.code: 0x%x, dut.code: 0x%x\n", ref.trap.code, dut.trap.code);
        printf("    ref.pc: 0x%lx, dut.pc: 0x%lx\n", ref.trap.pc, dut.trap.pc);
        printf("    ref.cycleCnt: 0x%lx, dut.cycleCnt: 0x%lx\n", ref.trap.cycleCnt, dut.trap.cycleCnt);
        printf("    ref.instrCnt: 0x%lx, dut.instrCnt: 0x%lx\n", ref.trap.instrCnt, dut.trap.instrCnt);
    }
    
    // Compare exception event
    if (memcmp(&ref.excp, &dut.excp, sizeof(excp_event_t)) != 0) {
        printf("  Exception event difference:\n");
        printf("    ref.excp_valid: %d, dut.excp_valid: %d\n", ref.excp.excp_valid, dut.excp.excp_valid);
        printf("    ref.eret: %d, dut.eret: %d\n", ref.excp.eret, dut.excp.eret);
        printf("    ref.interrupt: 0x%lx, dut.interrupt: 0x%lx\n", ref.excp.interrupt, dut.excp.interrupt);
        printf("    ref.exception: 0x%lx, dut.exception: 0x%lx\n", ref.excp.exception, dut.excp.exception);
        printf("    ref.exceptionPC: 0x%lx, dut.exceptionPC: 0x%lx\n", ref.excp.exceptionPC, dut.excp.exceptionPC);
        printf("    ref.exceptionInst: 0x%lx, dut.exceptionInst: 0x%lx\n", ref.excp.exceptionInst, dut.excp.exceptionInst);
    }
    
    // Compare instruction commit events
    for (int i = 0; i < DIFFTEST_COMMIT_WIDTH; i++) {
        if (memcmp(&ref.commit[i], &dut.commit[i], sizeof(instr_commit_t)) != 0) {
            printf("  Commit[%d] difference:\n", i);
            printf("    ref.valid: %d, dut.valid: %d\n", ref.commit[i].valid, dut.commit[i].valid);
            printf("    ref.pc: 0x%lx, dut.pc: 0x%lx\n", ref.commit[i].pc, dut.commit[i].pc);
            printf("    ref.inst: 0x%x, dut.inst: 0x%x\n", ref.commit[i].inst, dut.commit[i].inst);
            printf("    ref.skip: %d, dut.skip: %d\n", ref.commit[i].skip, dut.commit[i].skip);
            printf("    ref.is_TLBFILL: %d, dut.is_TLBFILL: %d\n", ref.commit[i].is_TLBFILL, dut.commit[i].is_TLBFILL);
            printf("    ref.TLBFILL_index: %d, dut.TLBFILL_index: %d\n", ref.commit[i].TLBFILL_index, dut.commit[i].TLBFILL_index);
            printf("    ref.is_CNTinst: %d, dut.is_CNTinst: %d\n", ref.commit[i].is_CNTinst, dut.commit[i].is_CNTinst);
            printf("    ref.timer_64_value: 0x%lx, dut.timer_64_value: 0x%lx\n", ref.commit[i].timer_64_value, dut.commit[i].timer_64_value);
            printf("    ref.wen: %d, dut.wen: %d\n", ref.commit[i].wen, dut.commit[i].wen);
            printf("    ref.wdest: %d, dut.wdest: %d\n", ref.commit[i].wdest, dut.commit[i].wdest);
            printf("    ref.wdata: 0x%lx, dut.wdata: 0x%lx\n", ref.commit[i].wdata, dut.commit[i].wdata);
            printf("    ref.csr_rstat: %d, dut.csr_rstat: %d\n", ref.commit[i].csr_rstat, dut.commit[i].csr_rstat);
            printf("    ref.csr_data: 0x%lx, dut.csr_data: 0x%lx\n", ref.commit[i].csr_data, dut.commit[i].csr_data);
        }
    }
    
    // Compare general registers
    printf("  Register differences:\n");
    bool reg_diff = false;
    for (int i = 0; i < 32; i++) {
        if (ref.regs.gpr[i] != dut.regs.gpr[i]) {
            printf("    gpr[%d]: ref=0x%lx, dut=0x%lx\n", i, ref.regs.gpr[i], dut.regs.gpr[i]);
            reg_diff = true;
        }
    }
    
    for (int i = 0; i < 32; i++) {
        if (ref.regs.fpr[i] != dut.regs.fpr[i]) {
            printf("    fpr[%d]: ref=0x%lx, dut=0x%lx\n", i, ref.regs.fpr[i], dut.regs.fpr[i]);
            reg_diff = true;
        }
    }
    
    if (ref.regs.fccr != dut.regs.fccr) {
        printf("    fccr: ref=0x%lx, dut=0x%lx\n", ref.regs.fccr, dut.regs.fccr);
        reg_diff = true;
    }
    
    if (ref.regs.fcsr0 != dut.regs.fcsr0) {
        printf("    fcsr0: ref=0x%lx, dut=0x%lx\n", ref.regs.fcsr0, dut.regs.fcsr0);
        reg_diff = true;
    }
    
    if (!reg_diff) {
        printf("    No register differences\n");
    }
    
    // Compare CSR registers
    printf("  CSR differences:\n");
    bool csr_diff = false;
    
    if (ref.csr.crmd != dut.csr.crmd) {
        printf("    crmd: ref=0x%lx, dut=0x%lx\n", ref.csr.crmd, dut.csr.crmd);
        csr_diff = true;
    }
    
    if (ref.csr.prmd != dut.csr.prmd) {
        printf("    prmd: ref=0x%lx, dut=0x%lx\n", ref.csr.prmd, dut.csr.prmd);
        csr_diff = true;
    }
    
    if (ref.csr.euen != dut.csr.euen) {
        printf("    euen: ref=0x%lx, dut=0x%lx\n", ref.csr.euen, dut.csr.euen);
        csr_diff = true;
    }
    
    if (ref.csr.ecfg != dut.csr.ecfg) {
        printf("    ecfg: ref=0x%lx, dut=0x%lx\n", ref.csr.ecfg, dut.csr.ecfg);
        csr_diff = true;
    }
    
    if (ref.csr.era != dut.csr.era) {
        printf("    era: ref=0x%lx, dut=0x%lx\n", ref.csr.era, dut.csr.era);
        csr_diff = true;
    }
    
    if (ref.csr.badv != dut.csr.badv) {
        printf("    badv: ref=0x%lx, dut=0x%lx\n", ref.csr.badv, dut.csr.badv);
        csr_diff = true;
    }
    
    if (ref.csr.eentry != dut.csr.eentry) {
        printf("    eentry: ref=0x%lx, dut=0x%lx\n", ref.csr.eentry, dut.csr.eentry);
        csr_diff = true;
    }
    
    if (ref.csr.tlbidx != dut.csr.tlbidx) {
        printf("    tlbidx: ref=0x%lx, dut=0x%lx\n", ref.csr.tlbidx, dut.csr.tlbidx);
        csr_diff = true;
    }
    
    if (ref.csr.tlbehi != dut.csr.tlbehi) {
        printf("    tlbehi: ref=0x%lx, dut=0x%lx\n", ref.csr.tlbehi, dut.csr.tlbehi);
        csr_diff = true;
    }
    
    if (ref.csr.tlbelo0 != dut.csr.tlbelo0) {
        printf("    tlbelo0: ref=0x%lx, dut=0x%lx\n", ref.csr.tlbelo0, dut.csr.tlbelo0);
        csr_diff = true;
    }
    
    if (ref.csr.tlbelo1 != dut.csr.tlbelo1) {
        printf("    tlbelo1: ref=0x%lx, dut=0x%lx\n", ref.csr.tlbelo1, dut.csr.tlbelo1);
        csr_diff = true;
    }
    
    if (ref.csr.asid != dut.csr.asid) {
        printf("    asid: ref=0x%lx, dut=0x%lx\n", ref.csr.asid, dut.csr.asid);
        csr_diff = true;
    }
    
    if (ref.csr.pgdl != dut.csr.pgdl) {
        printf("    pgdl: ref=0x%lx, dut=0x%lx\n", ref.csr.pgdl, dut.csr.pgdl);
        csr_diff = true;
    }
    
    if (ref.csr.pgdh != dut.csr.pgdh) {
        printf("    pgdh: ref=0x%lx, dut=0x%lx\n", ref.csr.pgdh, dut.csr.pgdh);
        csr_diff = true;
    }
    
    if (ref.csr.save0 != dut.csr.save0) {
        printf("    save0: ref=0x%lx, dut=0x%lx\n", ref.csr.save0, dut.csr.save0);
        csr_diff = true;
    }
    
    if (ref.csr.save1 != dut.csr.save1) {
        printf("    save1: ref=0x%lx, dut=0x%lx\n", ref.csr.save1, dut.csr.save1);
        csr_diff = true;
    }
    
    if (ref.csr.save2 != dut.csr.save2) {
        printf("    save2: ref=0x%lx, dut=0x%lx\n", ref.csr.save2, dut.csr.save2);
        csr_diff = true;
    }
    
    if (ref.csr.save3 != dut.csr.save3) {
        printf("    save3: ref=0x%lx, dut=0x%lx\n", ref.csr.save3, dut.csr.save3);
        csr_diff = true;
    }
    
    if (ref.csr.tid != dut.csr.tid) {
        printf("    tid: ref=0x%lx, dut=0x%lx\n", ref.csr.tid, dut.csr.tid);
        csr_diff = true;
    }
    
    if (ref.csr.tcfg != dut.csr.tcfg) {
        printf("    tcfg: ref=0x%lx, dut=0x%lx\n", ref.csr.tcfg, dut.csr.tcfg);
        csr_diff = true;
    }
    
    if (ref.csr.tval != dut.csr.tval) {
        printf("    tval: ref=0x%lx, dut=0x%lx\n", ref.csr.tval, dut.csr.tval);
        csr_diff = true;
    }
    
    if (ref.csr.llbctl != dut.csr.llbctl) {
        printf("    llbctl: ref=0x%lx, dut=0x%lx\n", ref.csr.llbctl, dut.csr.llbctl);
        csr_diff = true;
    }
    
    if (ref.csr.tlbrentry != dut.csr.tlbrentry) {
        printf("    tlbrentry: ref=0x%lx, dut=0x%lx\n", ref.csr.tlbrentry, dut.csr.tlbrentry);
        csr_diff = true;
    }
    
    if (ref.csr.dmw0 != dut.csr.dmw0) {
        printf("    dmw0: ref=0x%lx, dut=0x%lx\n", ref.csr.dmw0, dut.csr.dmw0);
        csr_diff = true;
    }
    
    if (ref.csr.dmw1 != dut.csr.dmw1) {
        printf("    dmw1: ref=0x%lx, dut=0x%lx\n", ref.csr.dmw1, dut.csr.dmw1);
        csr_diff = true;
    }
    
    if (ref.csr.estat != dut.csr.estat) {
        printf("    estat: ref=0x%lx, dut=0x%lx\n", ref.csr.estat, dut.csr.estat);
        csr_diff = true;
    }
    
    if (ref.csr.cur_pc != dut.csr.cur_pc) {
        printf("    cur_pc: ref=0x%lx, dut=0x%lx\n", ref.csr.cur_pc, dut.csr.cur_pc);
        csr_diff = true;
    }
    
    if (!csr_diff) {
        printf("    No CSR differences\n");
    }
    
    // Compare store events
    for (int i = 0; i < DIFFTEST_COMMIT_WIDTH; i++) {
        if (memcmp(&ref.store[i], &dut.store[i], sizeof(store_event_t)) != 0) {
            printf("  Store event[%d] difference:\n", i);
            printf("    ref.valid: %d, dut.valid: %d\n", ref.store[i].valid, dut.store[i].valid);
            printf("    ref.paddr: 0x%lx, dut.paddr: 0x%lx\n", ref.store[i].paddr, dut.store[i].paddr);
            printf("    ref.data: 0x%lx, dut.data: 0x%lx\n", ref.store[i].data, dut.store[i].data);
            printf("    ref.mask: 0x%x, dut.mask: 0x%x\n", ref.store[i].mask, dut.store[i].mask);
        }
    }
    
    // Compare load events
    for (int i = 0; i < DIFFTEST_COMMIT_WIDTH; i++) {
        if (memcmp(&ref.load[i], &dut.load[i], sizeof(load_event_t)) != 0) {
            printf("  Load event[%d] difference:\n", i);
            printf("    ref.valid: %d, dut.valid: %d\n", ref.load[i].valid, dut.load[i].valid);
            printf("    ref.paddr: 0x%lx, dut.paddr: 0x%lx\n", ref.load[i].paddr, dut.load[i].paddr);
            printf("    ref.vaddr: 0x%lx, dut.vaddr: 0x%lx\n", ref.load[i].vaddr, dut.load[i].vaddr);
        }
    }
    
    // Compare TLB events
    for (int i = 0; i < 2; i++) {
        if (memcmp(&ref.tlb[i], &dut.tlb[i], sizeof(tlb_event_t)) != 0) {
            printf("  TLB event[%d] difference:\n", i);
            printf("    ref.valid: %d, dut.valid: %d\n", ref.tlb[i].valid, dut.tlb[i].valid);
            printf("    ref.source: %d, dut.source: %d\n", ref.tlb[i].source, dut.tlb[i].source);
            printf("    ref.vpn: 0x%lx, dut.vpn: 0x%lx\n", ref.tlb[i].vpn, dut.tlb[i].vpn);
            printf("    ref.ppn: 0x%lx, dut.ppn: 0x%lx\n", ref.tlb[i].ppn, dut.tlb[i].ppn);
            printf("    ref.exception: 0x%x, dut.exception: 0x%x\n", ref.tlb[i].exception, dut.tlb[i].exception);
        }
    }
}

int main(int argc, char** argv, char** envp) {
    Verilated::mkdir("logs");

    VerilatedContext* contextp = new VerilatedContext;

    // Set debug level, 0 is off, 9 is highest presently used
    // May be overridden by commandArgs argument parsing
    contextp->debug(0);

    // Randomization reset policy
    // May be overridden by commandArgs argument parsing
    contextp->randReset(2);

    // Verilator must compute traced signals
    contextp->traceEverOn(true);

    // Construct the Verilated model, from VTop.h generated from Verilating "Top.v".
    // Using unique_ptr is similar to "VTop* Top = new VTop" then deleting at end.
    // "Top" will be the hierarchical name of the module.
    VTop *Top = new VTop{contextp, "Sim_Top"};
    VerilatedFstC* trace = new VerilatedFstC;
    Top->trace(trace, 99);
    trace->open("/home/lizilin/projects/LoongChipX/test/logs/xdma_diff.fst");
    // reset
    Top->dma_InstrCommit_valid_0 = 0;
    Top->dma_ExcpEvent_excp_valid = 0;
    Top->dma_LoadEvent_valid_0 = 0;
    Top->dma_StoreEvent_valid_0 = 0;
    Top->dma_TLBEvent_valid_0 = 0;
    Top->dma_TLBEvent_valid_1 = 0;
    Top->DIFF_AXI_rvalid = 0;

    Top->dma_aresetn = 1;
    Top->axi_resetn = 1;
    for (int i = 0; i < 16; i++) {
        Top->dma_clk = 1;
        Top->axi_clk = (i % 4) < 2;
        Top->eval();
        trace->dump(sim_cycle++);
        Top->dma_clk = 0;
        Top->axi_clk = (i % 4) < 2;
        Top->eval();
        trace->dump(sim_cycle++);
    }
    Top->dma_aresetn = 0;
    Top->axi_resetn = 0;
    for (int i = 0; i < 100; i++) {
        Top->dma_clk = 1;
        Top->axi_clk = (i % 4) < 2;
        Top->eval();
        trace->dump(sim_cycle++);
        Top->dma_clk = 0;
        Top->axi_clk = (i % 4) < 2;
        Top->eval();
        trace->dump(sim_cycle++);
    }
    Top->dma_aresetn = 1;
    Top->axi_resetn = 1;
    Top->DIFF_AXI_arvalid = 1;
    Top->DIFF_AXI_arlen = 7;
    Top->DIFF_AXI_arsize = 6;
    Top->DIFF_AXI_rready = 1;



    FILE* diff_fd = fopen("/home/lizilin/projects/LoongChipX/verif/verilator/VerSimKernel/logs/latest/diff.bin", "rb");
    if (diff_fd == NULL) {
        return -1;
    }

    std::queue<difftest_core_state_t> dut_queue;
    // 在difftest中#define LOG_DIFF会在log目录下生成diff_out.bin
    out_fp = fopen("/home/lizilin/projects/LoongChipX/test/logs/diff_out.bin", "wb");
    if (out_fp == NULL) {
        printf("open diff_out.bin failed\n");
        return -1;
    }
    bool init = false;

    while (!feof(diff_fd)) {
            Top->dma_clk = 1;
            Top->axi_clk = (cycle % 4) < 2;
            Top->eval();
            
            trace->dump(sim_cycle++);
            Top->dma_clk = 0;
            Top->axi_clk = (cycle % 4) < 2;
            Top->eval();
            trace->dump(sim_cycle++);
            if ((cycle % 4 == 2)) {
                difftest_core_state_t dut;
                fread(&dut, sizeof(difftest_core_state_t), 1, diff_fd);
                dut_queue.push(dut);

                // InstrCommit_0
                Top->dma_InstrCommit_valid_0 = dut.commit[0].valid;
                Top->dma_InstrCommit_pc_0 = dut.commit[0].pc;
                Top->dma_InstrCommit_instr_0 = dut.commit[0].inst;
                Top->dma_InstrCommit_skip_0 = dut.commit[0].skip;
                Top->dma_InstrCommit_is_TLBFILL_0 = dut.commit[0].is_TLBFILL;
                Top->dma_InstrCommit_TLBFILL_index_0 = dut.commit[0].TLBFILL_index;
                Top->dma_InstrCommit_is_CNTinst_0 = dut.commit[0].is_CNTinst;
                Top->dma_InstrCommit_timer_64_value_0 = dut.commit[0].timer_64_value;
                Top->dma_InstrCommit_wen_0 = dut.commit[0].wen;
                Top->dma_InstrCommit_wdest_0 = dut.commit[0].wdest;
                Top->dma_InstrCommit_wdata_0 = dut.commit[0].wdata;
                Top->dma_InstrCommit_csr_rstat_0 = dut.commit[0].csr_rstat;
                Top->dma_InstrCommit_csr_data_0 = dut.commit[0].csr_data;
                
                // ExcpEvent
                Top->dma_ExcpEvent_excp_valid = dut.excp.excp_valid;
                Top->dma_ExcpEvent_eret = dut.excp.eret;
                Top->dma_ExcpEvent_intrNo = dut.excp.interrupt;
                Top->dma_ExcpEvent_cause = dut.excp.exception;
                Top->dma_ExcpEvent_exceptionPC = dut.excp.exceptionPC;
                Top->dma_ExcpEvent_exceptionInst = dut.excp.exceptionInst;
                
                // StoreEvent_0
                Top->dma_StoreEvent_valid_0 = dut.store[0].valid;
                Top->dma_StoreEvent_storePAddr_0 = dut.store[0].paddr;
                Top->dma_StoreEvent_storeData_0 = dut.store[0].data;
                Top->dma_StoreEvent_storeMask_0 = dut.store[0].mask;
                
                // LoadEvent_0
                Top->dma_LoadEvent_valid_0 = dut.load[0].valid;
                Top->dma_LoadEvent_paddr_0 = dut.load[0].paddr;
                Top->dma_LoadEvent_vaddr_0 = dut.load[0].vaddr;
                
                // CSRRegState
                Top->dma_CSRRegState_crmd = dut.csr.crmd;
                Top->dma_CSRRegState_prmd = dut.csr.prmd;
                Top->dma_CSRRegState_euen = dut.csr.euen;
                Top->dma_CSRRegState_ecfg = dut.csr.ecfg;
                Top->dma_CSRRegState_estat = dut.csr.estat;
                Top->dma_CSRRegState_era = dut.csr.era;
                Top->dma_CSRRegState_badv = dut.csr.badv;
                Top->dma_CSRRegState_eentry = dut.csr.eentry;
                Top->dma_CSRRegState_tlbidx = dut.csr.tlbidx;
                Top->dma_CSRRegState_tlbehi = dut.csr.tlbehi;
                Top->dma_CSRRegState_tlbelo0 = dut.csr.tlbelo0;
                Top->dma_CSRRegState_tlbelo1 = dut.csr.tlbelo1;
                Top->dma_CSRRegState_asid = dut.csr.asid;
                Top->dma_CSRRegState_pgdl = dut.csr.pgdl;
                Top->dma_CSRRegState_pgdh = dut.csr.pgdh;
                Top->dma_CSRRegState_save0 = dut.csr.save0;
                Top->dma_CSRRegState_save1 = dut.csr.save1;
                Top->dma_CSRRegState_save2 = dut.csr.save2;
                Top->dma_CSRRegState_save3 = dut.csr.save3;
                Top->dma_CSRRegState_tid = dut.csr.tid;
                Top->dma_CSRRegState_tcfg = dut.csr.tcfg;
                Top->dma_CSRRegState_tval = dut.csr.tval;
                Top->dma_CSRRegState_llbctl = dut.csr.llbctl;
                Top->dma_CSRRegState_tlbrentry = dut.csr.tlbrentry;
                Top->dma_CSRRegState_dmw0 = dut.csr.dmw0;
                Top->dma_CSRRegState_dmw1 = dut.csr.dmw1;
                
                // GRegState
                Top->dma_GRegState_gpr_0 = dut.regs.gpr[0];
                Top->dma_GRegState_gpr_1 = dut.regs.gpr[1];
                Top->dma_GRegState_gpr_2 = dut.regs.gpr[2];
                Top->dma_GRegState_gpr_3 = dut.regs.gpr[3];
                Top->dma_GRegState_gpr_4 = dut.regs.gpr[4];
                Top->dma_GRegState_gpr_5 = dut.regs.gpr[5];
                Top->dma_GRegState_gpr_6 = dut.regs.gpr[6];
                Top->dma_GRegState_gpr_7 = dut.regs.gpr[7];
                Top->dma_GRegState_gpr_8 = dut.regs.gpr[8];
                Top->dma_GRegState_gpr_9 = dut.regs.gpr[9];
                Top->dma_GRegState_gpr_10 = dut.regs.gpr[10];
                Top->dma_GRegState_gpr_11 = dut.regs.gpr[11];
                Top->dma_GRegState_gpr_12 = dut.regs.gpr[12];
                Top->dma_GRegState_gpr_13 = dut.regs.gpr[13];
                Top->dma_GRegState_gpr_14 = dut.regs.gpr[14];
                Top->dma_GRegState_gpr_15 = dut.regs.gpr[15];
                Top->dma_GRegState_gpr_16 = dut.regs.gpr[16];
                Top->dma_GRegState_gpr_17 = dut.regs.gpr[17];
                Top->dma_GRegState_gpr_18 = dut.regs.gpr[18];
                Top->dma_GRegState_gpr_19 = dut.regs.gpr[19];
                Top->dma_GRegState_gpr_20 = dut.regs.gpr[20];
                Top->dma_GRegState_gpr_21 = dut.regs.gpr[21];
                Top->dma_GRegState_gpr_22 = dut.regs.gpr[22];
                Top->dma_GRegState_gpr_23 = dut.regs.gpr[23];
                Top->dma_GRegState_gpr_24 = dut.regs.gpr[24];
                Top->dma_GRegState_gpr_25 = dut.regs.gpr[25];
                Top->dma_GRegState_gpr_26 = dut.regs.gpr[26];
                Top->dma_GRegState_gpr_27 = dut.regs.gpr[27];
                Top->dma_GRegState_gpr_28 = dut.regs.gpr[28];
                Top->dma_GRegState_gpr_29 = dut.regs.gpr[29];
                Top->dma_GRegState_gpr_30 = dut.regs.gpr[30];
                Top->dma_GRegState_gpr_31 = dut.regs.gpr[31];
                
                
                
                // FPRegState
                Top->dma_FPRegState_fpr_0 = dut.regs.fpr[0];
                Top->dma_FPRegState_fpr_1 = dut.regs.fpr[1];
                Top->dma_FPRegState_fpr_2 = dut.regs.fpr[2];
                Top->dma_FPRegState_fpr_3 = dut.regs.fpr[3];
                Top->dma_FPRegState_fpr_4 = dut.regs.fpr[4];
                Top->dma_FPRegState_fpr_5 = dut.regs.fpr[5];
                Top->dma_FPRegState_fpr_6 = dut.regs.fpr[6];
                Top->dma_FPRegState_fpr_7 = dut.regs.fpr[7];
                Top->dma_FPRegState_fpr_8 = dut.regs.fpr[8];
                Top->dma_FPRegState_fpr_9 = dut.regs.fpr[9];
                Top->dma_FPRegState_fpr_10 = dut.regs.fpr[10];
                Top->dma_FPRegState_fpr_11 = dut.regs.fpr[11];
                Top->dma_FPRegState_fpr_12 = dut.regs.fpr[12];
                Top->dma_FPRegState_fpr_13 = dut.regs.fpr[13];
                Top->dma_FPRegState_fpr_14 = dut.regs.fpr[14];
                Top->dma_FPRegState_fpr_15 = dut.regs.fpr[15];
                Top->dma_FPRegState_fpr_16 = dut.regs.fpr[16];
                Top->dma_FPRegState_fpr_17 = dut.regs.fpr[17];
                Top->dma_FPRegState_fpr_18 = dut.regs.fpr[18];
                Top->dma_FPRegState_fpr_19 = dut.regs.fpr[19];
                Top->dma_FPRegState_fpr_20 = dut.regs.fpr[20];
                Top->dma_FPRegState_fpr_21 = dut.regs.fpr[21];
                Top->dma_FPRegState_fpr_22 = dut.regs.fpr[22];
                Top->dma_FPRegState_fpr_23 = dut.regs.fpr[23];
                Top->dma_FPRegState_fpr_24 = dut.regs.fpr[24];
                Top->dma_FPRegState_fpr_25 = dut.regs.fpr[25];
                Top->dma_FPRegState_fpr_26 = dut.regs.fpr[26];
                Top->dma_FPRegState_fpr_27 = dut.regs.fpr[27];
                Top->dma_FPRegState_fpr_28 = dut.regs.fpr[28];
                Top->dma_FPRegState_fpr_29 = dut.regs.fpr[29];
                Top->dma_FPRegState_fpr_30 = dut.regs.fpr[30];
                Top->dma_FPRegState_fpr_31 = dut.regs.fpr[31];
                Top->dma_FPRegState_fccr = dut.regs.fccr;
                Top->dma_FPRegState_fcsr0 = dut.regs.fcsr0;
                
                // TLBEvent_0
                Top->dma_TLBEvent_valid_0 = dut.tlb[0].valid;
                Top->dma_TLBEvent_source_0 = dut.tlb[0].source;
                Top->dma_TLBEvent_vpn_0 = dut.tlb[0].vpn;
                Top->dma_TLBEvent_ppn_0 = dut.tlb[0].ppn;
                Top->dma_TLBEvent_exception_0 = dut.tlb[0].exception;
                
                // TLBEvent_1
                Top->dma_TLBEvent_valid_1 = dut.tlb[1].valid;
                Top->dma_TLBEvent_source_1 = dut.tlb[1].source;
                Top->dma_TLBEvent_vpn_1 = dut.tlb[1].vpn;
                Top->dma_TLBEvent_ppn_1 = dut.tlb[1].ppn;
                Top->dma_TLBEvent_exception_1 = dut.tlb[1].exception;
            }
        if (Top->DIFF_AXI_rvalid & Top->DIFF_AXI_rready) {
            for (int j = 0; j < 16; j++) {
                *((uint32_t*)(diff_buffer + diff_buff_offset + j*4)) = Top->DIFF_AXI_rdata[j];
            }
            for (int i = diff_buff_offset + 63; i >= diff_buff_offset; i--) {
                printf("%02x", (uint8_t)diff_buffer[i]);
            }
            printf("\n");
            fwrite(diff_buffer+diff_buff_offset, 64, 1, out_fp);
            diff(diff_buff_offset + 64);

            while (ref_queue.size() > 0 && dut_queue.size() > 0) {
                difftest_core_state_t ref = ref_queue.front();
                ref_queue.pop();
                difftest_core_state_t dut = dut_queue.front();
                dut_queue.pop();
                
                if (ref.commit[0].valid) {
                    memcpy(&dut.csr, &ref.csr, sizeof(arch_csr_state_t));
                    init = true;
                }
                if (init) {
                    bool error = false;
                    if (dut.commit[0].valid && (memcmp(&ref.commit[0], &dut.commit[0], sizeof(instr_commit_t)) != 0) ||
                        (memcmp(&ref.regs, &dut.regs, sizeof(arch_greg_state_t)) != 0) ||
                        (memcmp(&ref.csr, &dut.csr, sizeof(arch_csr_state_t)) != 0)) {
                        printf("commit inst diff\n");
                        error = true;
                    }
                    if (dut.excp.excp_valid && memcmp(&ref.excp, &dut.excp, sizeof(excp_event_t)) != 0) {
                        printf("excp diff\n");
                        error = true;
                    }
                    if (dut.load[0].valid && memcmp(&ref.load[0], &dut.load[0], sizeof(load_event_t)) != 0) {
                        printf("load inst diff\n");
                        error = true;
                    }
                    if (dut.store[0].valid && memcmp(&ref.store[0], &dut.store[0], sizeof(store_event_t)) != 0) {
                        printf("store inst diff\n");
                        error = true;
                    }
                    if(error) {
                        print_diff(ref, dut, sim_cycle);
                        goto end;
                    }
                }
            }
        }
        cycle++;
    }
end:;
    Top->final();
    delete Top;
    trace->close();
    fclose(out_fp);
    return 0;
}