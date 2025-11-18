#include <sys/mman.h>
#include "difftest.h"

std::chrono::nanoseconds emu_nano_seconds = std::chrono::nanoseconds(0);

extern FILE* trace_out;
extern FILE* uart_out;

// not compare estat
static const int DIFFTEST_NR_GREG   = 32;
static const int DIFFTEST_NR_CSRREG = 12;
static const int DIFFTEST_NR_FPREG  = 34;
static const int DIFFTEST_NR_REG = DIFFTEST_NR_GREG + DIFFTEST_NR_CSRREG;

static const char* reg_name[] = {
        "r0",      "ra",     "tp",      "sp",      "a0",      "a1",     "a2",        "a3",        "a4",      "a5",
        "a6",      "a7",     "t0",      "t1",      "t2",      "t3",     "t4",        "t5",        "t6",      "t7",
        "t8",      " x",     "fp",      "s0",      "s1",      "s2",     "s3",        "s4",        "s5",      "s6",
        "s7",      "s8",
        "crmd",    "prmd",   "euen",    "ecfg",    "era",     "badv",   "eentry",    "tlbidx",    "tlbehi",  "tlbelo0",
        "tlbelo1", "asid",   "pgdl",    "pgdh",    "save0",   "save1",  "save2",     "save3",     "tid",     "tcfg",
        "tval",    "llbctl", "tlbrentry", "dmw0",  "dmw1",    "estat",   "cur_pc"
};

static const char compare_mask[] = {
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  1,  1,  1,  1,  1,
    1,  1,  1,  1,  1,  0,  1
};

#ifdef RAND_TEST
/* used only do rand test. compare only when flag is true */
static bool diff_flag = false;
#endif

bool do_check_inst_rdtime(uint32_t inst);

static uint32_t estat_last;
static uint32_t estat_flag;
static uint32_t estat_mask;
static uint32_t estat_new;

#ifdef DEAD_CLOCK_EN
static bool dead_clock_enable = false;
static int dead_clock = 0;
#endif
extern long long inst_total;

int debug = 0;
int debug_hit_num = 0;

int Difftest::step(vluint64_t &main_time) {
    // progress = false;
    idx_commit = 0;
    int index = 0;
    uint32_t insn = 0;

    if (sim_over) {
        printf("==============================================================\n");
        printf("test end!!\n");
#ifdef SIMU_TRACE
        fprintf(trace_out, "==============================================================\n");
        fprintf(trace_out, "test end!!\n");
#endif
        return STATE_END;
    }

    while (idx_commit < DIFFTEST_COMMIT_WIDTH && dut.commit[idx_commit].valid) {
        inst_total += 1;
        insn = proxy->get_inst(dut.commit[idx_commit].pc);
        dut.commit[idx_commit].inst = insn;
#ifndef TRACE_COMP
        dut.commit[idx_commit].valid = 0;
#endif
#ifdef OUTPUT_PC_INFO
#ifdef PRINT_CLK_TIME
        printf("[%010ldns] cpu : pc = %08lx, inst = %08x, reg = %02d, val = %08x\n",
            main_time, dut.commit[idx_commit].pc, dut.commit[idx_commit].inst, dut.commit[idx_commit].wen ? dut.commit[idx_commit].wdest : 0, dut.commit[idx_commit].wdata);
#else
        printf("cpu : pc = 0x%08lx, inst = %08x, reg = %02d, val = %08lx\n",
            dut.commit[idx_commit].pc, dut.commit[idx_commit].inst, dut.commit[idx_commit].wen ? dut.commit[idx_commit].wdest : 0, dut.commit[idx_commit].wdata);
#endif
#endif

#ifdef SIMU_TRACE
        fprintf(trace_out, "[%010ldns] cpu : pc = 0x%08lx, inst = %08x, reg = %02d, val = %08lx\n",
            main_time, dut.commit[idx_commit].pc, dut.commit[idx_commit].inst, dut.commit[idx_commit].wen ? dut.commit[idx_commit].wdest : 0, dut.commit[idx_commit].wdata);

#endif
        idx_commit++;
    }

    /* store difftest. valid = {4'b0, sc(llbit=1), stw, sth, stb} */
    for (int index = 0; index < DIFFTEST_COMMIT_WIDTH; index++) {
        if (dut.store[index].valid) {
            store_queue.push({dut.store[index].paddr, dut.store[index].data, dut.store[index].mask});
        }
    }

    if (!store_queue.empty()) {
        store_data_t ref_store_data;
        while (proxy->get_store(&ref_store_data)) {
            
            store_data_t dut_store_data = store_queue.front();
            store_queue.pop();
            if (ref_store_data.paddr != dut_store_data.paddr ||
                ref_store_data.data != dut_store_data.data ||
                ref_store_data.mask != dut_store_data.mask) {
                printf("store different:\n");
                printf("ref_store_data: paddr = 0x%lx, data = 0x%lx, mask = 0x%x\n", ref_store_data.paddr, ref_store_data.data, ref_store_data.mask);
                printf(" dut_store_data: paddr = 0x%lx, data = 0x%lx, mask = 0x%x\n", dut_store_data.paddr, dut_store_data.data, dut_store_data.mask);
#ifdef SIMU_TRACE
                fprintf(trace_out,"store different:\n");
                fprintf(trace_out,"ref_store_data: paddr = 0x%lx, data = 0x%lx, mask = 0x%x\n", ref_store_data.paddr, ref_store_data.data, ref_store_data.mask);
                fprintf(trace_out," dut_store_data: paddr = 0x%lx, data = 0x%lx, mask = 0x%x\n", dut_store_data.paddr, dut_store_data.data, dut_store_data.mask);
#endif
                return STATE_ABORT;
            }
            if (store_queue.empty()) break;
        }
    }

    for (int i = 0; i < 2; i++) {
        if (dut.tlb[i].valid) {
            proxy->check_paddr(dut.tlb[i].vpn, dut.tlb[i].source, &ref.tlb[i].ppn, &ref.tlb[i].exception);
            if (ref.tlb[i].exception != 0x8 && // adef
                ((dut.tlb[i].exception == 0) && ref.tlb[i].ppn != dut.tlb[i].ppn ||
                  ref.tlb[i].exception != dut.tlb[i].exception)) {
                printf("TLB different:\n");
                printf("ref_tlb: vpn = 0x%lx, source = 0x%x, ppn = 0x%lx, exception = 0x%x\n", dut.tlb[i].vpn, dut.tlb[i].source, ref.tlb[i].ppn, ref.tlb[i].exception);
                printf(" dut_tlb: vpn = 0x%lx, source = 0x%x, ppn = 0x%lx, exception = 0x%x\n", dut.tlb[i].vpn, dut.tlb[i].source, dut.tlb[i].ppn, dut.tlb[i].exception);
    #ifdef SIMU_TRACE
                fprintf(trace_out,"TLB different:\n");
                fprintf(trace_out,"ref_tlb: vpn = 0x%lx, source = 0x%x, ppn = 0x%lx, exception = 0x%x\n", dut.tlb[i].vpn, dut.tlb[i].source, ref.tlb[i].ppn, ref.tlb[i].exception);
                fprintf(trace_out," dut_tlb: vpn = 0x%lx, source = 0x%x, ppn = 0x%lx, exception = 0x%x\n", dut.tlb[i].vpn, dut.tlb[i].source, dut.tlb[i].ppn, dut.tlb[i].exception);
    #endif
                return STATE_ABORT;
            }
        }
    }

    if(idx_commit == 0 && !dut.excp.excp_valid){
#ifdef DEAD_CLOCK_EN
        dead_clock++;
        if (dead_clock_enable && dead_clock > DEAD_CLOCK_SIZE) {
            printf("CPU status no change for %d cycles, simulation must exist error!!!!\n", DEAD_CLOCK_SIZE);
            // fprintf(trace_out,"CPU status no change for %d cycles, simulation must exist error!!!!\n", DEAD_CLOCK_SIZE);
            return STATE_TIME_LIMIT;
        }
#endif
        return STATE_RUNNING;
    }
#ifdef DEAD_CLOCK_EN
    //TODO: let emulator report it's idle or not?
    dead_clock_enable = dut.excp.excp_valid || dut.commit[idx_commit - 1].inst != 0x06488000u;
    dead_clock = 0;
#endif

#ifndef TRACE_COMP
    if (idx_commit > 0 && dut.commit[idx_commit - 1].pc == END_PC || dut.excp.exceptionPC == END_PC) {
        sim_over = true;
    }
    return STATE_RUNNING;
#else
    /* pull down estat bit-by-bit */
    estat_flag = 0x00000004;
    estat_new = dut.csr.estat & 0x00001ffc;
    estat_mask = estat_new ^ estat_last;
    if (estat_mask) {
        for (int i = 0; i < 11; i++) {
            if ((estat_mask & estat_flag) && (estat_last & estat_flag)) {
                proxy->estat_sync(dut.csr.estat, estat_flag);
            }
            estat_flag = estat_flag << 1;
        }
    }
    estat_last = dut.csr.estat;

    if(idx_commit > 0) dut.csr.cur_pc = dut.commit[idx_commit - 1].pc;

    /// only for debug print
    if (dut.commit[0].valid && (dut.commit[0].pc == 0x90000000015d0200)) {
        printf("Exception 0\n");
        debug = 1;
    }

    // uint64_t cur_pc = proxy->get_cur_pc();
    // if (dut.commit[0].pc != cur_pc){
    //     printf("MisMatch PC: 0x%08lx-> 0x%08lx\n", dut.commit[0].pc, cur_pc);
    //     #ifdef SIMU_TRACE
    //     fprintf(trace_out, "MisMatch PC: 0x%08lx-> 0x%08lx\n", dut.commit[0].pc, cur_pc);
    //     #endif
    // }

    // /* check if instruction is split */
    // if (do_check_instruction_split(insn, &split_num)) {
    //     dut.commit[0].valid = 0;
    //     return STATE_RUNNING;
    // }

    // /* clear split info */
    // split_num = 0;

    /* exec the first instruction */
    do_first_instr_commit();

    /* sync estat to emulator */
    for (index = 0; index < idx_commit; index++) {
        if (dut.commit[index].csr_rstat) {
            proxy->estat_sync(dut.commit[index].csr_data, 0x00001fff);
        }
    }

    /// only for debug.
    if (dut.commit[0].valid && (dut.commit[0].pc == 0x080001cc)) {
        // printf("Trigger Debugger.\n");
        debug = 1;
    }

    /// only for debug.
    if (dut.commit[0].valid && (dut.commit[0].pc == 0x08002000)) {
        printf("\x1b[32mException Exit.\x1b[0m\n");
        sim_over = true;
        exit(1);
    }

    if (dut.commit[0].valid && (dut.commit[0].pc == 0x00000310)) {
        if (debug_hit_num == 10)
            debug = 2;
        else
            debug_hit_num++;
        debug = 3;
    }


    for (index = 0; index < idx_commit; index++) {
        do_instr_commit(index);
        dut.commit[index].valid = 0;
    }

    /* check simulation end */
    if (idx_commit > 0 && dut.commit[idx_commit - 1].pc == END_PC || dut.excp.excp_valid && dut.excp.exceptionPC == END_PC) {
        sim_over = true;
        return STATE_RUNNING;
    }

    /* load address of peripherals */
    for (index = 0; index < idx_commit; index++) {
#ifdef RAND_TEST
        if (dut.load[index].valid && (dut.load[index].paddr & 0x00000000f8000000 || !(dut.load[index].paddr & ~0xfff))) {
            proxy->regcpy(dut_regs_ptr, DIFFTEST_TO_REF, DIFF_TO_REF_GR);
        }
#else
        if (dut.load[index].valid && (dut.load[index].paddr & 0x00000000f8000000)) {
            proxy->regcpy(dut_regs_ptr, DIFFTEST_TO_REF, DIFF_TO_REF_ALL);
        }
#endif
    }

    if (dut.excp.excp_valid) {
        if (dut.excp.interrupt != 0) {
            proxy->raise_trap(1, dut.excp.interrupt, dut.excp.exception);
        } else if (dut.excp.exception != 0) {
            /// in emu, when a (PIL, PIS, PIF) exception raise,
            /// emu longjump EENTRY + offset and dot need trigger.
            // proxy->raise_trap(0, dut.excp.interrupt, dut.excp.exception);
        }
    }

    bool is_copy_gpr = false;
    if (do_check_instruction_skip(insn, is_copy_gpr)) {
        if (is_copy_gpr)
            proxy->regcpy(dut_regs_ptr, DIFFTEST_TO_REF, DIFF_TO_REF_GR);
        return STATE_RUNNING;
    }

    /// start compare results.
    /* copy emulator result to ref_regs_ptr */
    proxy->regcpy(ref_regs_ptr, REF_TO_DUT, DIFF_TO_REF_ALL);

    proxy->csrcpy(&ref.csr.crmd, REF_TO_DUT);
    proxy->csrcpy_idx(0x41, &dut.csr.tcfg, 0xffffffffffffffff,  DUT_TO_REF);

    proxy->csrcpy_idx(0x19, &ref.csr.pgdl, 0xffffffffffffffff,  REF_TO_DUT);
    if (ref.csr.pgdl != dut.csr.pgdl) {
        printf("warning: pgdl error, dut = %x, ref = %x\n", dut.csr.pgdl, ref.csr.pgdl);
        return STATE_ABORT;
    }   

    ref.csr.tval = dut.csr.tval;
    if(dut.excp.excp_valid){
        dut.csr.cur_pc = ref.csr.cur_pc;
    }
    
    bool ecode_error = false;
    // if((dut.csr.estat | 0x00001fff) != (ref.csr.estat | 0x00001fff)){
    //     printf("warning: ecode error, dut = %x, ref = %x\n", dut.csr.estat, ref.csr.estat);
    //     #ifdef SIMU_TRACE
    //     fprintf(trace_out,"warning: ecode error, dut = %x, ref = %x\n", dut.csr.estat, ref.csr.estat);
    //     #endif
    //     ecode_error = true;
    // }
    
    for(int i = 0; i < DIFFTEST_NR_CSRREG; i++) {
        if (!compare_mask[i])
            dut_regs_ptr[DIFFTEST_NR_GREG + i] = ref_regs_ptr[DIFFTEST_NR_GREG + i] = 0;
    }

    /* compare */
    if (ecode_error) {
        printf("[ERROR]: Ecode Error!\n");
    }

    bool pc_unmatch = false;

    if (idx_commit > 0)
        if (dut.commit[0].pc != ref.csr.cur_pc) {
            printf("MisMatch PC: 0x%08lx-> 0x%08lx\n", dut.commit[0].pc, ref.csr.cur_pc);
        #ifdef SIMU_TRACE
            fprintf(trace_out, "MisMatch PC: 0x%08lx-> 0x%08lx\n", dut.commit[0].pc, ref.csr.cur_pc);
        #endif
            pc_unmatch = true;
        }

    if (memcmp(dut_regs_ptr, ref_regs_ptr, DIFFTEST_NR_GREG * sizeof(uint64_t))){
        for (int i = 0; i < DIFFTEST_NR_GREG; i ++) {
            if (dut_regs_ptr[i] != ref_regs_ptr[i]) {
                printf("%2s(r%2d) different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n", reg_name[i], i,
                       ref.csr.cur_pc, ref_regs_ptr[i], dut_regs_ptr[i]);
#ifdef SIMU_TRACE
                fprintf(trace_out, "%2s(r%2d) different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n", reg_name[i],
                        i, ref.csr.cur_pc, ref_regs_ptr[i], dut_regs_ptr[i]);
#endif
            }
        }
        return STATE_ABORT;
    } else {
        // return STATE_RUNNING;
    }

    if (memcmp(&dut.regs.fpr[0], &ref.regs.fpr[0], DIFFTEST_NR_FPREG * sizeof(uint64_t))){
        for (int i = 0; i < DIFFTEST_NR_GREG; i ++) {
            if (dut.regs.fpr[i] != ref.regs.fpr[i]) {
                if ((dut.regs.fpr[i]) == (ref.regs.fpr[i]))
                    continue;
                printf("%2s(f%2d) different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n",
                       reg_name[i], i, ref.csr.cur_pc, ref.regs.fpr[i], dut.regs.fpr[i]);
#ifdef SIMU_TRACE
                fprintf(trace_out, "%2s(f%2d) different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n",
                        reg_name[i], i, ref.csr.cur_pc, ref.regs.fpr[i], dut.regs.fpr[i]);
#endif
            }
        }
        if (dut.regs.fccr != ref.regs.fccr) {
            printf("fccr different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n",
                    ref.csr.cur_pc, ref.regs.fccr, dut.regs.fccr);
#ifdef SIMU_TRACE
            fprintf(trace_out, "fccr different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n",
                    ref.csr.cur_pc, ref.regs.fccr, dut.regs.fccr);
#endif
        }
        if (dut.regs.fcsr0 != ref.regs.fcsr0) {
            printf("fcsr0 different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n",
                    ref.csr.cur_pc, ref.regs.fcsr0, dut.regs.fcsr0);
#ifdef SIMU_TRACE
            fprintf(trace_out, "fcsr0 different at pc = 0x%08lx, right= 0x%08lx, wrong = 0x%08lx\n",
                    ref.csr.cur_pc, ref.regs.fcsr0, dut.regs.fcsr0);
#endif
        }
        return STATE_ABORT;
    } else {
        if (pc_unmatch) return STATE_ABORT;
        return STATE_RUNNING;
    }
#endif
}

extern void *get_img_start();
void Difftest::do_first_instr_commit() {
    if (dut.commit[0].valid && dut.commit[0].pc == FIRST_INST_ADDRESS) {
        printf("The first instruction of core %d has commited. Difftest enabled.\n", coreid);

#if 0
        assert(!get_img_start());
        proxy->memcpy(0x0, get_img_start(), EMU_RAM_SIZE, DIFFTEST_TO_REF);
        munmap(get_img_start(), EMU_RAM_SIZE);
#endif
        proxy->regcpy(dut_regs_ptr, DIFFTEST_TO_REF, DIFF_TO_REF_ALL);
    }
}

void Difftest::do_instr_commit(int i) {

    /* rdtime{L/H}.w rdtime.d */
    if (do_check_inst_rdtime(dut.commit[i].inst)) {
        struct la64_timer timer;
        timer.counter_id = dut.csr.tid;
        timer.stable_timer = dut.commit[i].timer_64_value - 1;
        timer.time_val = dut.csr.tval;
        // printf("timer64: 0x%lx, low: 0x%x, high: 0x%x\n",dut.commit[i].timer_64_value,timer_low,timer_high);
        proxy->timercpy(&timer, DUT_TO_REF);
    }

    state->record_inst(dut.commit[i].pc, dut.commit[i].inst, dut.commit[i].wen, dut.commit[i].wdest, dut.commit[i].wdata, dut.commit[i].skip);

    /* single step exec */
    auto start = std::chrono::steady_clock::now();
    proxy->exec(1, false);
    auto end = std::chrono::steady_clock::now();
    emu_nano_seconds += std::chrono::nanoseconds(end-start);

}

void Difftest::display() {
    fflush(NULL);
    state->display();
    printf("\n==============  DUT Regs  ==============\n");
    for (int i = 0; i < 32; i ++) {
        printf("%s(r%2d): 0x%016lx ", reg_name[i], i, dut_regs_ptr[i]);
        if (i % 4 == 3) printf("\n");
    }
    printf("pc: 0x%016lx\n", dut.csr.cur_pc);
    printf("CRMD: 0x%016lx,    PRMD: 0x%016lx,   EUEN: 0x%016lx\n", dut.csr.crmd, dut.csr.prmd, dut.csr.euen);
    printf("ECFG: 0x%016lx,   ESTAT: 0x%016lx,    ERA: 0x%016lx\n", dut.csr.ecfg, dut.csr.estat, dut.csr.era);
    printf("BADV: 0x%016lx,  EENTRY: 0x%016lx, LLBCTL: 0x%016lx\n", dut.csr.badv, dut.csr.eentry, dut.csr.llbctl);
    printf("cpu.ll_bit: %lu\n", dut.csr.llbctl & 0x1);
    printf("INDEX: 0x%016lx, TLBEHI: 0x%016lx, TLBELO0: 0x%08x, TLBELO1: 0x%08x\n", dut.csr.tlbidx, dut.csr.tlbehi, dut.csr.tlbelo0, dut.csr.tlbelo1);
    printf("ASID: 0x%016lx, TLBRENTRY: 0x%016lx, DMW0: 0x%08x, DMW1: 0x%08x\n", dut.csr.asid, dut.csr.tlbrentry, dut.csr.dmw0, dut.csr.dmw1);
    printf("*******************************************************************************\n");
#ifdef SIMU_TRACE
    fprintf(trace_out,"\n==============  DUT Regs  ==============\n");
        for (int i = 0; i < 32; i ++) {
        fprintf(trace_out,"%s(r%2d): 0x%08x ", reg_name[i], i, dut_regs_ptr[i]);
        if (i % 4 == 3) fprintf(trace_out,"\n");
    }
    fprintf(trace_out,"pc: 0x%08lx\n", dut.csr.cur_pc);
    fprintf(trace_out,"CRMD: 0x%08lx,    PRMD: 0x%08lx,   EUEN: 0x%08lx\n", dut.csr.crmd, dut.csr.prmd, dut.csr.euen);
    fprintf(trace_out,"ECFG: %08lx8x,   ESTAT: 0x%08lx,    ERA: 0x%08lx\n", dut.csr.ecfg, dut.csr.estat, dut.csr.era);
    fprintf(trace_out,"BADV: 0x%08lx,  EENTRY: 0x%08lx, LLBCTL: 0x%08lx\n", dut.csr.badv, dut.csr.eentry, dut.csr.llbctl);
    fprintf(trace_out,"cpu.ll_bit: %lu\n", dut.csr.llbctl & 0x1);
    fprintf(trace_out,"INDEX: 0x%08lx, TLBEHI: 0x%08lx, TLBELO0: 0x%08x, TLBELO1: 0x%08x\n", dut.csr.tlbidx, dut.csr.tlbehi, dut.csr.tlbelo0, dut.csr.tlbelo1);
    fprintf(trace_out,"ASID: 0x%08lx, TLBRENTRY: 0x%08lx, DMW0: 0x%08x, DMW1: 0x%08x\n", dut.csr.asid, dut.csr.tlbrentry, dut.csr.dmw0, dut.csr.dmw1);
    fprintf(trace_out,"*******************************************************************************\n");
#endif
    printf("\n==============  REF Regs  ==============\n");
    fflush(NULL);

    proxy->isa_reg_display();
    fflush(NULL);
}

void Difftest::fastforward(uint64_t cycles) {
    for (int i = 0; i < cycles; i++) {
        proxy->exec(1, true);
    }
    proxy->regcpy(ref_regs_ptr, REF_TO_DUT, DIFF_TO_REF_ALL);
    proxy->csrcpy(&ref.csr.crmd, REF_TO_DUT);
    struct la64_timer timer;
    proxy->timercpy(&timer, REF_TO_DUT);
    _fastforward_timer = timer.stable_timer;
    ref_ext.misc = get_ref_csr(0x3);
    ref_ext.badi = get_ref_csr(0x8);
    ref_ext.pwcl = get_ref_csr(0x1c);
    ref_ext.pwch = get_ref_csr(0x1d);
    ref_ext.stlbps = get_ref_csr(0x1e);
    ref_ext.rvacfg = get_ref_csr(0x1f);
    ref_ext.cntc = get_ref_csr(0x43);
    ref_ext.ticlr = get_ref_csr(0x44);
    ref_ext.tlbrehi = get_ref_csr(0x8e);
    store_data_t store_data;
    while (proxy->get_store(&store_data));

    _fastforward_cycles = timer.stable_timer;
    _fastforward_pc = proxy->get_cur_pc();
    inst_total = timer.stable_timer;
    printf("fastforward pc: %lx\n", _fastforward_pc);
}

bool Difftest::do_check_instruction_skip(uint32_t inst, bool &is_copy) {

    /// stand for if we need copy gpr(because of instruction lazy write back)
    /// when skip this instruction.
    is_copy = false;

    /// csrrd:   00000100  00000
    /// csrwr:   00000100  00001
    /// csrxchg: 00000100  !=0 1

#if 0
    if (((inst >> 24) == 0x4) && (((inst >> 5) & 0x1F) == 0x1)) {// csrrw
        is_copy = true;
        return true;
    }

    if (((inst >> 24) == 0x4) && (((inst >> 5) & 0x1F) == 0x0)) {// csrrd
        is_copy = true;
        return true;
    }

    if (((inst >> 24) == 0x4) && (((inst >> 5) & 0x1F) != 0x0) && (((inst >> 5) & 0x1F) != 0x1) ) {// csrxchg
        is_copy = true;
        return true;
    }
#endif

#define CHECK_SKIP_LOAD_INST 1

#if CHECK_SKIP_LOAD_INST
    /// ll.w: 00100000
    if (((inst >> 24) == 0x20)) {
        return true;
    }

    /// ll.d: 00100010
    if (((inst >> 24) == 0x22)) {
        return true;
    }

    /// ldptr.w : 00100100
    if (((inst >> 24) == 0x24)) {
        return true;
    }

    /// ldptr.d : 00100110
    if (((inst >> 24) == 0x26)) {
        return true;
    }

    /// ld.b : 0010100000
    if (((inst >> 22) == 0xa0)) {
        return true;
    }

    /// ld.h : 0010100001
    if (((inst >> 22) == 0xa1)) {
        return true;
    }

    /// ld.w : 0010100010
    if (((inst >> 22) == 0xa2)) {
        return true;
    }

    /// ld.d : 0010100011
    if (((inst >> 22) == 0xa3)) {
        return true;
    }

    /// ld.bu : 0010101000
    if (((inst >> 22) == 0xa8)) {
        return true;
    }

    /// ld.hu : 0010101001
    if (((inst >> 22) == 0xa9)) {
        return true;
    }

    /// ld.wu : 0010101010
    if (((inst >> 22) == 0xaa)) {
        return true;
    }

    /// fld.s : 0010101100
    if (((inst >> 22) == 0xac)) {
        return true;
    }

    /// fld.d : 0010101110
    if (((inst >> 22) == 0xae)) {
        return true;
    }

    /// ldx.b : 00111000000000000
    if (((inst >> 15) == 0x7000)) {
        return true;
    }

    /// ldx.h : 00111000000001000
    if (((inst >> 15) == 0x7008)) {
        return true;
    }

    /// ldx.w : 00111000000010000
    if (((inst >> 15) == 0x7010)) {
        return true;
    }

    /// ldx.d : 00111000000011000
    if (((inst >> 15) == 0x7018)) {
        return true;
    }

    /// ldx.bu : 00111000001000000
    if (((inst >> 15) == 0x7040)) {
        return true;
    }

    /// ldx.hu : 00111000001001000
    if (((inst >> 15) == 0x7048)) {
        return true;
    }

    /// ldx.wu : 00111000001010000
    if (((inst >> 15) == 0x7050)) {
        return true;
    }

    /// fldx.s : 00111000001100000
    if (((inst >> 15) == 0x7060)) {
        return true;
    }

    /// fldx.d : 00111000001101000
    if (((inst >> 15) == 0x7068)) {
        return true;
    }

    /// iocsr: 0000011001001000000
    if ((inst >> 13) == 0x3240) {
        return true;
    }
#endif

    return false;
}

bool do_check_inst_rdtime(uint32_t inst) {
    /// rdtimel.w 0000000000000000011000
    if (((inst >> 10) == 0x18)) {
        return true;
    }

    /// rdtimeh.w 0000000000000000011001
    if (((inst >> 10) == 0x19)) {
        return true;
    }

    /// rdtime.d 0000000000000000011010
    if (((inst >> 10) == 0x1a)) {
        return true;
    }

    return false;
}

Difftest::Difftest(int coreid): coreid(coreid) {
    proxy = new DIFF_PROXY(coreid);
    state = new DiffState;
}

Difftest::~Difftest() {
    delete proxy;
    proxy = NULL;
    delete state;
    state = NULL;
}
