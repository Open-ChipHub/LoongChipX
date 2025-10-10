#include <stdio.h>
#include <string.h>
#include <stdint.h>
#include <stdlib.h>
#include "trace.h"
#include "lsassert.h"
#include "util.h"
#include "loongarch_state.h"

#define RESET   "\033[0m"
#define BLACK   "\033[30m"      /* Black */
#define RED     "\033[31m"      /* Red */
#define GREEN   "\033[32m"      /* Green */
#define YELLOW  "\033[33m"      /* Yellow */
#define BLUE    "\033[34m"      /* Blue */
#define MAGENTA "\033[35m"      /* Magenta */
#define CYAN    "\033[36m"      /* Cyan */
#define WHITE   "\033[37m"      /* White */
#define BOLDBLACK   "\033[1m\033[30m"      /* Bold Black */
#define BOLDRED     "\033[1m\033[31m"      /* Bold Red */
#define BOLDGREEN   "\033[1m\033[32m"      /* Bold Green */
#define BOLDYELLOW  "\033[1m\033[33m"      /* Bold Yellow */
#define BOLDBLUE    "\033[1m\033[34m"      /* Bold Blue */
#define BOLDMAGENTA "\033[1m\033[35m"      /* Bold Magenta */
#define BOLDCYAN    "\033[1m\033[36m"      /* Bold Cyan */
#define BOLDWHITE   "\033[1m\033[37m"      /* Bold White */

int diff_fcsr = 0;

uint64_t gpr[32] = {};
uint64_t fpr[32] = {};
uint32_t fcsr;
uint8_t fcc;
#define stack_trace_SIZE 1024
typedef struct stacktrace {
    uint64_t trace[stack_trace_SIZE];
    size_t index;
}stacktrace;

stacktrace kernel_stack_trace;
stacktrace spec_stack_trace;

void stack_trace_push(stacktrace* t,uint64_t pc) {
    t->trace[t->index] = pc;
    ++ t->index;
    if (t->index >= stack_trace_SIZE) {
        printf("stack_trace overflow, set to zero\n");
        t->index = 0;
    }
}

uint64_t stack_trace_pop(stacktrace* t, uint64_t pc) {
    if (t->index <= 0) {
        printf("stack_trace underflow, set to zero\n");
        t->index = 0;
        return 0;
    }
    -- t->index;
    return t->trace[t->index];
}

void stack_trace_print(stacktrace* t) {
    printf("stack trace:");
    for (size_t i = 0; i < t->index; ++ i) {
        printf("%lx ", t->trace[i]);
    }
    printf("\n");
}

int is_kernel_pc(uint64_t pc) {
    return pc >> 60 == 9;
}

int is_spec_pc(uint64_t pc) {
    return pc >> 28 == 0x12;
}

void dump_gpr() {
    fprintf(stdout,"GPR\n");
    for (size_t i = 0; i < 32; i++)
    {
        fprintf(stdout,"r%02ld:%016lx\n", i, gpr[i]);
    }
    return;
}

void dump_fpr() {
    fprintf(stdout,"FPR\n");
    for (size_t i = 0; i < 32; i++)
    {
        fprintf(stdout,"f%02ld:%016lx\n", i, fpr[i]);
    }
    fprintf(stdout,"FCC:%02x\n", fcc);
    return;
}

void dump_reg() {
    dump_gpr();
    dump_fpr();
}
void update_regs(trace_item *t) {
    if (t->type == TRACE_ITEM_COMMIT) {
        if (t->commit.wen && t->commit.write_type == WR_TYPE_FIX) {
            gpr[t->commit.laddr] = t->commit.res;
        }
        else if (t->commit.wen && t->commit.write_type == WR_TYPE_FLOAT) {
            fpr[t->commit.laddr] = t->commit.res;
        } else if(t->commit.wen && t->commit.write_type == WR_TYPE_FCC) {
            fcc &= ~(1 << t->commit.laddr);
            fcc |= (t->commit.res << t->commit.laddr);
        }
    } else if (t->type == TRACE_ITEM_EX) {
    } else {
        abort();
    }
}

static const char* get_regname(const trace_item *t) {
    switch(t->commit.write_type) {
        case WR_TYPE_FIX : return "GR";
        case WR_TYPE_FLOAT : {
            if (t->commit.write_size == WR_SIZE_DWORD) {
                return "FR";
            } else if (t->commit.write_size == WR_SIZE_QWORD) {
                return "VR";
            } else if (t->commit.write_size == WR_SIZE_DQWORD) {
                return "XVR";
            } else {
                lsassert(0);
            }
        }
        case WR_TYPE_FCC : return "FCC";
        default:
            return "UNKNOWN";
    }
}
int64_t comment_res_number = -1;
void dump_trace_item(trace_item *t) {
    update_regs(t);
    if (t->type == TRACE_ITEM_COMMIT) {
        fprintf(stdout, "commit_id:%ld, debug_id:%lx, pc:%012lx, inst:%09lx, wen:%d, laddr:%s%02d, res:%016lx, res1(vec):%016lx, paddr:%016lx, comment_res:%ld, if:%d\n", t->commit.commit_id, t->commit.id, t->commit.pc, t->commit.inst, t->commit.wen,  get_regname(t), t->commit.laddr, t->commit.res, t->commit.res1, t->commit.paddr, comment_res_number, t->commit.fusion_type);
    } else if (t->type == TRACE_ITEM_EX) {
            fprintf(stdout, "exception_id:0x%lx, ecode:%lx, badv:%016lx, epc:%012lx, bad_inst:%09lx, line:%ld\n", t->exception.exception_id, t->exception.ecode, t->exception.badv, t->exception.epc, t->exception.bad_inst, t->exception.line);
    } else {
        abort();
    }
}

void dump_trace_item_load(trace_item *t) {
    if (t->type == TRACE_ITEM_COMMIT) {
        fprintf(stdout, "pc:%012lx, load:%d, inst:%09lx, vaddr:%016lx\n",t->commit.pc, is_ld_inst(t->commit.inst), t->commit.inst, t->commit.vaddr);
    } else if (t->type == TRACE_ITEM_EX) {

    } else {
        abort();
    }
}

void dump_trace_item_dda(trace_item *t) {
    if (t->type == TRACE_ITEM_COMMIT) {
        fprintf(stdout, "pc:%012lx, load:%d, inst:%09lx, vaddr:%016lx\n",t->commit.pc, is_ld_inst(t->commit.inst), t->commit.inst, t->commit.vaddr);
    } else if (t->type == TRACE_ITEM_EX) {

    } else {
        abort();
    }
}

#define GETBIT(__a, __index) ((__a >> __index) & 1)

void dump_fcsr(int fcsr) {
    int rm = (fcsr >> 8) & 0x3;
    static const char* rm_mode[4] = {
        "RNE",
        "RZ",
        "RP",
        "RM",
    };
    printf("    Enables:V:%d, Z:%d, O:%d, U:%d, I:%d\n", GETBIT(fcsr, 4), GETBIT(fcsr, 3), GETBIT(fcsr, 2), GETBIT(fcsr, 1), GETBIT(fcsr, 0));
    printf("    RM     :%d(%s)\n", rm, rm_mode[rm]);
    printf("    Flags  :V:%d, Z:%d, O:%d, U:%d, I:%d\n", GETBIT(fcsr, 20), GETBIT(fcsr, 19), GETBIT(fcsr, 18), GETBIT(fcsr, 17), GETBIT(fcsr, 16));
    printf("    Cause  :V:%d, Z:%d, O:%d, U:%d, I:%d\n", GETBIT(fcsr, 28), GETBIT(fcsr, 27), GETBIT(fcsr, 26), GETBIT(fcsr, 25), GETBIT(fcsr, 24));
}

int dump_trace(const char *filename, const char* arg) {
    int dump_stack_trace = 0;
    int dump_syscall = 0;

    if (arg != NULL) {
        dump_stack_trace = strstr(arg, "stack_trace") != NULL;
        dump_syscall = strstr(arg, "syscall") != NULL;
    }

    FILE* sim_trace_file = fopen_nofail(filename, "rb");
    trace_item t;
    while (fread(&t, sizeof(t), 1, sim_trace_file) == 1) {
        fprintf(stdout, "cycles:%ld, ", t.sim_cycle);
        if (t.type == TRACE_ITEM_COMMIT) {
            if (is_random_test_pc(t.commit.pc)) ++ comment_res_number;
            dump_trace_item(&t);
            if (dump_stack_trace) {
                if (is_call(t.commit.inst)) {
                    if (is_kernel_pc(t.commit.pc)) {
                        stack_trace_push(&kernel_stack_trace, t.commit.pc + 4);
                        stack_trace_print(&kernel_stack_trace);
                    } else if (is_spec_pc(t.commit.pc)) {
                        stack_trace_push(&spec_stack_trace, t.commit.pc + 4);
                        stack_trace_print(&spec_stack_trace);
                    }
                    fprintf(stdout, "call:%lx\n", call_target(t.commit.pc, t.commit.inst, gpr));
                } else if (is_ret(t.commit.inst)) {
                    if (is_kernel_pc(t.commit.pc)) {
                        stack_trace_pop(&kernel_stack_trace, ret_target(t.commit.inst, gpr));
                    } else if (is_spec_pc(t.commit.pc)) {
                        stack_trace_pop(&spec_stack_trace, ret_target(t.commit.inst, gpr));
                    }
                    fprintf(stdout, "return:%lx\n", ret_target(t.commit.inst, gpr));
                }
            }
            update_regs(&t);
            if (is_amop(t.commit.inst)) {
                comment_res_number ++;
            }
            else if (is_fsel(t.commit.inst)) {
                comment_res_number ++;
            }
            //  else if (is_movgr2frh_w(t.commit.inst)) {
            //     comment_res_number ++;
            // }
        } else if (t.type == TRACE_ITEM_EX) {
            if (is_random_test_pc(t.exception.epc)) {
                ++ comment_res_number;
            }
            dump_trace_item(&t);
            if (dump_syscall) {
                if (t.exception.ecode == SYS) {
                    fprintf(stdout, "syscall:%ld, arg0:%lx, arg1:%lx, arg2:%lx, arg3:%lx, arg4:%lx, arg5:%lx, arg6:%lx\n", gpr[11], gpr[4], gpr[5], gpr[6], gpr[7], gpr[8], gpr[9], gpr[10]);
                }
            }
        } else {
            abort();
        }
    };

    fprintf(stdout,"\n\n");
    return 0;
}

int dump_trace_csv(const char *filename) {
    FILE* sim_trace_file = fopen_nofail(filename, "rb");

    trace_item t;
    fprintf(stdout, "sim_cycle, debug_id, pc\n");
    while (fread(&t, sizeof(t), 1, sim_trace_file) == 1) {
        if (t.type == TRACE_ITEM_COMMIT) {
            fprintf(stdout, "%ld, %ld, %lx\n", t.sim_cycle, t.commit.id, t.commit.pc);
        }
    };

    fprintf(stdout,"\n\n");
    return 0;
}

#define READ_VALUE_FILE(__N) \
    for (size_t i = 0; i < __N; i++) { \
        value1 = get_next_int(value1_file);\
        value2 = get_next_int(value2_file);\
        value_res_number ++; \
    }

#define READ_PC_FILE \
    pc = get_next_int(pc_file);\
    insn = get_next_int(instruction_file);\
    pc_res_line ++;

static uint64_t get_next_int(FILE* f) {
    uint64_t temp[8];
    lsassert(fscanf(f,"%lx%lx%lx%lx%lx%lx%lx%lx",&temp[0],&temp[1],&temp[2],&temp[3],&temp[4],&temp[5],&temp[6],&temp[7]) == 8);
    return temp[0] + (temp[1]<<8) + (temp[2]<<16) + (temp[3]<<24) + (temp[4]<<32) + (temp[5]<<40) + (temp[6]<<48) + (temp[7]<<56);
}

enum ERROR_TYPE {
    ERROR_NONE,
    ERROR_COMMIT_PC,
    ERROR_COMMIT_INSN,
    ERROR_COMMIT_VALUE1,
    ERROR_COMMIT_VALUE1_SINGLE_FLOAT,
    ERROR_COMMIT_VALUE1_FCC,
    ERROR_COMMIT_VALUE2,
    ERROR_COMMIT_VALUE2_FCSR,
    ERROR_RAISE_EXCEPTION,
    ERROR_NOT_RAISE_EXCEPTION,
    ERROR_EXCEPTION_ECODE,
    ERROR_TRACE_SHORT,
};

const char* error_type_str(int etype) {
    switch (etype)
    {
        case ERROR_NONE:                       return "NONE";
        case ERROR_COMMIT_PC:                  return "COMMIT_PC";
        case ERROR_COMMIT_INSN:                return "COMMIT_INSN";
        case ERROR_COMMIT_VALUE1:              return "COMMIT_VALUE1";
        case ERROR_COMMIT_VALUE1_SINGLE_FLOAT: return "COMMIT_VALUE1_SINGLE_FLOAT";
        case ERROR_COMMIT_VALUE1_FCC:          return "COMMIT_VALUE1_FCC";
        case ERROR_COMMIT_VALUE2:              return "COMMIT_VALUE2";
        case ERROR_COMMIT_VALUE2_FCSR:         return "COMMIT_VALUE2_FCSR";
        case ERROR_RAISE_EXCEPTION:            return "RAISE_EXCEPTION";
        case ERROR_NOT_RAISE_EXCEPTION:        return "NOT_RAISE_EXCEPTION";
        case ERROR_EXCEPTION_ECODE:            return "EXCEPTION_ECODE";
        case ERROR_TRACE_SHORT:                return "TRACE_SHORT";
    default:
        return "UNKNOW_ERROR";
        break;
    }
}

int compare_trace(const char* trace_filename, const char* random_test_dir) {
    int64_t comment_res_number = 0;
    int64_t value_res_number = 1;
    int64_t pc_res_line = 0;
    int error_reason = ERROR_NONE;
    FILE* sim_trace_file = fopen_nofail(trace_filename, "rb");

    FILE* pc_file          = fopen_nofail_with_dir(random_test_dir, "/pc.res", "r");
    FILE* instruction_file = fopen_nofail_with_dir(random_test_dir, "/instruction.res", "r");
    FILE* value1_file      = fopen_nofail_with_dir(random_test_dir, "/value1.res", "r");
    FILE* value2_file      = fopen_nofail_with_dir(random_test_dir, "/value2.res", "r");
    FILE* epc_file         = fopen_nofail_with_dir(random_test_dir, "/exceptionPcIndex.res", "r");
    FILE* ecode_file       = fopen_nofail_with_dir(random_test_dir, "/except_type.res", "r");

    char dummy[1024];
    /* skip header lines */
    lsassert(fgets(dummy, 1024, pc_file) == dummy);
    lsassert(fgets(dummy, 1024, instruction_file) == dummy);
    lsassert(fgets(dummy, 1024, value1_file) == dummy);
    lsassert(fgets(dummy, 1024, value2_file) == dummy);
    lsassert(fgets(dummy, 1024, epc_file) == dummy);
    lsassert(fgets(dummy, 1024, ecode_file) == dummy);

    trace_item t = {0};
    uint64_t value1, value2, pc, insn;
    printf(RED);

    int64_t next_epc_line = 0;
    int64_t next_ecode = 0;
    if (fscanf(epc_file,"%lx", &next_epc_line) != 1) {
        next_epc_line = INT64_MAX;
    } else {
        int cnt = fscanf(ecode_file,"%lx", &next_ecode);
        lsassert(cnt == 1);
    }
    pc = get_next_int(pc_file);
    insn = get_next_int(instruction_file);
    while (1) {
        if (pc_res_line < next_epc_line) {
            READ_VALUE_FILE(1);
            do {
                if (fread(&t, sizeof(t), 1, sim_trace_file) != 1) {
                    error_reason = ERROR_TRACE_SHORT;
                    fprintf(stdout, "trace short\n");
                    goto end;
                }
                // dump_trace_item(&t);
                if (t.type == TRACE_ITEM_COMMIT) {
                    if (is_movgr2frh_w_first(t.commit.inst)) {
                        continue;
                    }
                    update_regs(&t);
                    if (is_random_test_pc(t.commit.pc)) {
                        if (pc != t.commit.pc) {
                            error_reason = ERROR_COMMIT_PC;
                        } else if (!(t.commit.inst >> 32) && (insn != t.commit.inst)) {
                            // skip compare of split insn, rdtime,rpcnt,movx2frh_w
                            error_reason = ERROR_COMMIT_INSN;
                        } else if (t.commit.wen) {
                            if(t.commit.write_type == WR_TYPE_FLOAT && (t.commit.laddr & 1)){
                                if((uint32_t)t.commit.res != (uint32_t)value1) {
                                    error_reason = ERROR_COMMIT_VALUE1_SINGLE_FLOAT;
                                }
                            }
                            else if (t.commit.write_type == WR_TYPE_FCC) {
                                if(t.commit.res != ((value1 >> t.commit.laddr) & 1)) {
                                    error_reason = ERROR_COMMIT_VALUE1_FCC;
                                }
                            } else if (t.commit.res != value1){
                                error_reason = ERROR_COMMIT_VALUE1;
                            }
                            if (diff_fcsr && is_fp_arith_inst(t.commit.inst) && t.commit.fcsr != value2) {
                                error_reason = ERROR_COMMIT_VALUE2_FCSR;
                            }
                        }
                        if (error_reason) {
                            printf("error commit, commit_id:%ld\n", t.commit.commit_id);
                            printf("golden trace res:%016lx, pc:%lx, insn:%x\n", value1, pc, (int)insn);
                            printf("sim    trace res:%016lx, pc:%lx, insn:%lx\n", t.commit.res, t.commit.pc, t.commit.inst);
                            if (error_reason == ERROR_COMMIT_VALUE2_FCSR) {
                                printf("goldem trace fcsr(value2):%08lx\n", value2);
                                dump_fcsr((int)value2);
                                printf("sim    trace fcsr(value2):%08x\n", t.commit.fcsr);
                                dump_fcsr(t.commit.fcsr);
                            }
                            goto end;
                        }
                        if(!is_rdtime_spliting(t.commit.inst)){
                            READ_PC_FILE;
                        }
                        comment_res_number ++;
                        if (is_amop(t.commit.inst)) {
                            READ_VALUE_FILE(1);
                            comment_res_number ++;
                        }
                        else if (is_movgr2frh_w_second(t.commit.inst) || is_fsel(t.commit.inst)) {
                            READ_VALUE_FILE(7);
                            comment_res_number ++;
                        }
                        else if (t.commit.write_type == WR_TYPE_FLOAT) {
                            READ_VALUE_FILE(3);
                        }
                        break;
                    }
                } else if (t.type == TRACE_ITEM_EX) {
                    if (t.exception.ecode == SYS) {
                        goto success;
                    }
                    if (is_random_test_pc(t.exception.epc)) {
                        error_reason = ERROR_RAISE_EXCEPTION;
                        printf("error, exception_id:%ld\n", t.exception.exception_id);
                        printf("error, this insn should not raise ex\n");
                        printf("error  trace, epc(line):%lx, real_pc:%lx, badv:%lx, rtl_ecode:%lx(%s), rpg_ecode:%lx(%s)\n",pc_res_line, t.exception.epc, t.exception.badv, t.exception.ecode, rtl_ename[t.exception.ecode], rtlecode2rpgecode(t.exception.ecode), rpg_ename[rtlecode2rpgecode(t.exception.ecode)]);
                        goto end;
                        break;
                    }
                } else {
                    abort();
                }
            } while (1);
        } else if (pc_res_line == next_epc_line) {
            do {
                if (fread(&t, sizeof(t), 1, sim_trace_file) != 1) {
                    error_reason = ERROR_TRACE_SHORT;
                    fprintf(stdout, "trace short\n");
                    goto end;
                }
                // dump_trace_item(&t);
                if (t.type == TRACE_ITEM_COMMIT) {
                    if (is_random_test_pc(t.commit.pc) && t.commit.wen) {
                        update_regs(&t);
                    }
                    if (is_random_test_pc(t.commit.pc)) {
                        error_reason = ERROR_NOT_RAISE_EXCEPTION;
                        printf("error, commit_id:%ld\n", t.commit.commit_id);
                        printf("this insn should raise ex, rpg ecode:%ld(%s)\n", next_ecode, rpg_ename[next_ecode]);
                        goto end;
                        break;
                    }
                } else if (t.type == TRACE_ITEM_EX) {
                    if (t.exception.ecode == SYS) {
                        goto success;
                    }
                    if (is_random_test_pc(t.exception.epc)) {
                        if (rtlecode2rpgecode(t.exception.ecode) != next_ecode) {
                            error_reason = ERROR_EXCEPTION_ECODE;
                            printf("error, exception_id:%ld\n", t.exception.exception_id);
                            printf("exception code mismatch\n");
                            printf("golden trace, rpg_ecode:%lx(%s)\n", next_ecode, rpg_ename[next_ecode]);
                            printf("error  trace, epc(line):%lx, real_pc:%lx, badv:%lx, rtl_ecode:%lx(%s), rpg_ecode:%lx(%s)\n",pc_res_line, t.exception.epc, t.exception.badv, t.exception.ecode, rtl_ename[t.exception.ecode], rtlecode2rpgecode(t.exception.ecode), rpg_ename[rtlecode2rpgecode(t.exception.ecode)]);
                            goto end;
                        }
                        READ_PC_FILE;
                        READ_VALUE_FILE(1);
                        value_res_number ++;
                        comment_res_number ++;
                        if (is_fp_inst(t.exception.bad_inst)) {
                            READ_VALUE_FILE(3);
                        }
                        if (fscanf(epc_file,"%lx", &next_epc_line) != 1) {
                            next_epc_line = INT64_MAX;
                        } else {
                            int cnt = fscanf(ecode_file,"%lx", &next_ecode);
                            lsassert(cnt == 1);
                        }
                        break;
                    }
                } else {
                    abort();
                }
            } while (1);
        } else {
            abort();
        }
    }

success:
    printf(RESET);
    printf(GREEN "SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS SUCCESS\n" RESET);

end:

    if (error_reason) {
        printf("ERROR:%s\n", error_type_str(error_reason));

        switch (error_reason)
        {
            case ERROR_COMMIT_PC: {

                    break;
                }
            case ERROR_COMMIT_INSN: {

                    break;
                }
            case ERROR_COMMIT_VALUE1: {

                    break;
                }
            case ERROR_COMMIT_VALUE1_SINGLE_FLOAT: {

                    break;
                }
            case ERROR_COMMIT_VALUE1_FCC: {

                    break;
                }
            case ERROR_COMMIT_VALUE2: {

                    break;
                }
            case ERROR_COMMIT_VALUE2_FCSR: {

                    break;
                }
            case ERROR_RAISE_EXCEPTION: {

                    break;
                }
            case ERROR_NOT_RAISE_EXCEPTION: {

                    break;
                }
            case ERROR_EXCEPTION_ECODE: {

                    break;
                }
            case ERROR_TRACE_SHORT: {

                    break;
                }
        default:
            break;
        }
        printf("value1/2.res line num:%ld, comment_res_NO[*]:%ld, pc/instruction.res line num:%ld\n", value_res_number, comment_res_number, pc_res_line);
        printf("sim trace info:\n");
        dump_trace_item(&t);
        dump_reg();
    }

    fclose(sim_trace_file);
    fclose(pc_file);
    fclose(instruction_file);
    fclose(value1_file);
    fclose(value2_file);
    fclose(epc_file);
    exit(!!error_reason);
    return 0;
}

int skip_trace_tlbr(trace_item* t, int* rem, long* idx, FILE* sim_trace_file){
    int num = 0;
    while(*rem && t->type == TRACE_ITEM_EX && t->exception.ecode == TLBR){
        int reach_ertn = 0;
        while(rem && !reach_ertn){
            reach_ertn = t->type == TRACE_ITEM_EX && t->exception.ecode == ERTN;
            *rem = fread(t, sizeof(trace_item), 1, sim_trace_file);
            *idx+= *rem;
        }
        num ++;
    }
    return num;
}

int skip_trace_sc(trace_item* t, int* rem, long* idx, FILE* sim_trace_file){
    int num = 0;
    if((*rem && t->type == TRACE_ITEM_COMMIT && (t->commit.inst & 0xff000000) == 0x21000000) || (t->commit.inst & 0xff000000) == 0x23000000){
        unsigned long pc = t->commit.pc;
        // SC fail
        while(!(pc == t->commit.pc && t->commit.wen == 1 && t->commit.res == 1)){

            *rem = fread(t, sizeof(trace_item), 1, sim_trace_file);
            *idx+= *rem;
        }
        num ++;
    }
    return num;
}

void print_trace_match(trace_item* tp, int* rem, long* idx,const char* filename){
    const trace_item t = *tp;
    fprintf(stdout, "Trace:%s\n", filename);
    fprintf(stdout, "Machted %ld node\n", *idx);
    if(!*rem)fprintf(stdout, "Compeletely machted\n");
    else{
        if(t.type == TRACE_ITEM_COMMIT){
            fprintf(stdout, "commit_id:%ld, debug_id:%lx, pc:%012lx, inst:%09lx, wen:%d, laddr:%s%02d, res:%016lx, paddr:%016lx, if:%d, exctime:%ld, prf:%2d\n", t.commit.commit_id, t.commit.id, t.commit.pc, t.commit.inst, t.commit.wen, get_regname(&t), t.commit.laddr, t.commit.res, t.commit.paddr, t.commit.fusion_type, t.commit.exctime,t.commit.prf);
        }
        else if(t.type == TRACE_ITEM_EX){
            fprintf(stdout, "exception_id:0x%lx, ecode:%lx, badv:%016lx, epc:%012lx, bad_inst:%09lx, line:%ld\n", t.exception.exception_id, t.exception.ecode, t.exception.badv, t.exception.epc, t.exception.bad_inst, t.exception.line);
        }
        else{
            abort();
        }
    }
}

int diff_trace_res(const char *filename1, const char *filename2) {
    FILE* sim_trace_file1 = fopen_nofail(filename1, "rb");
    FILE* sim_trace_file2 = fopen_nofail(filename2, "rb");

    trace_item t1, t2;
    long t1_idx=0,t2_idx=0;
    int t1_rem,t2_rem;
    int t1_tlbr=0,t2_tlbr=0;

    int skip_tlbr = 1;
    int skip_sc   = 0;
    int skip_rdt_val = 0;

    int num_diff = 0;
    int max_diff = 10;
    t1_rem = fread(&t1, sizeof(trace_item), 1, sim_trace_file1);
    t2_rem = fread(&t2, sizeof(trace_item), 1, sim_trace_file2);
    while (t1_rem == 1 && t2_rem == 1) {
        if(skip_tlbr){
            t1_tlbr += skip_trace_tlbr(&t1,&t1_rem,&t1_idx,sim_trace_file1);
            t2_tlbr += skip_trace_tlbr(&t2,&t2_rem,&t2_idx,sim_trace_file2);
            if(t1_rem != 1 || t2_rem != 1)break;
        }
        if(skip_sc){
            skip_trace_sc(&t1,&t1_rem,&t1_idx,sim_trace_file1);
            skip_trace_sc(&t2,&t2_rem,&t2_idx,sim_trace_file2);
            if(t1_rem != 1 || t2_rem != 1)break;
        }
        int diff = 0;
        if(t1.type != t2.type) diff = 1;
        else if(t1.type == TRACE_ITEM_COMMIT){
            if (t1.commit.pc != t2.commit.pc) diff = 1;
            else if (t1.commit.wen != t2.commit.wen) diff = 1;
            else if (t1.commit.inst != t2.commit.inst) diff = 1;
            else if (skip_rdt_val && (t1.commit.inst & 0xfffff000) == 0x00006000); // is rdt cpucfg
            else if (t1.commit.wen && t1.commit.res != t2.commit.res) diff = 1;
        }
        else if(t1.type == TRACE_ITEM_EX){
            if(t1.exception.ecode != t2.exception.ecode) diff = 1;
            else if(t1.exception.badv  != t2.exception.badv ) diff = 1;
            else if(t1.exception.epc   != t2.exception.epc  ) diff = 1;
        }
        else{
            abort();
        }
        if(diff){
            num_diff += 1;
            if(num_diff < max_diff){
                print_trace_match(&t1,&t1_rem,&t1_idx,filename1);
                print_trace_match(&t2,&t2_rem,&t2_idx,filename2);
            }
            else{
                break;
            }
        }
        t1_idx++;t2_idx++;
        t1_rem = fread(&t1, sizeof(trace_item), 1, sim_trace_file1);
        t2_rem = fread(&t2, sizeof(trace_item), 1, sim_trace_file2);
    };
    print_trace_match(&t1,&t1_rem,&t1_idx,filename1);
    print_trace_match(&t2,&t2_rem,&t2_idx,filename2);
    fprintf(stdout,"\n\n");
    return 0;
}

uint64_t get_trace_dist(uint64_t* dist, int buf_size, const char *filename){
    FILE* sim_trace_file = fopen_nofail(filename, "rb");
    trace_item t;
    uint64_t count = 0;
    memset(dist, 0, 8 << buf_size);

    uint64_t buf_mask = (1 << buf_size) - 1;
    while(fread(&t, sizeof(trace_item), 1, sim_trace_file) == 1){
        if(t.type == TRACE_ITEM_COMMIT){
            uint64_t pc = t.commit.pc;
            uint64_t hash = pc;
            pc >>= buf_size;
            hash ^= pc;
            pc >>= buf_size;
            hash ^= pc;
            hash &= buf_mask;
            dist[hash] += 1;
            count += 1;
        }
    }
    return count;
}

int diff_trace_dist(const char *filename1, const char *filename2) {
    int buf_size = 21;
    int buf_word = 1 << buf_size;
    uint64_t* dist1 = (uint64_t*)malloc(8 << buf_size);
    uint64_t* dist2 = (uint64_t*)malloc(8 << buf_size);
    if(dist1 == NULL || dist2 == NULL) abort();
    int i = 0;
    uint64_t count[2] = {
        get_trace_dist(dist1,buf_size,filename1),
        get_trace_dist(dist2,buf_size,filename2)
    };
    uint64_t count_min  = count[0] < count[1] ? count[0] : count[1];
    uint64_t count_max  = count[0] < count[1] ? count[1] : count[0];

    uint64_t count_same = 0;
    for(i = 0;i < buf_word;i += 1){
        uint64_t n1 = dist1[i];
        uint64_t n2 = dist2[i];
        count_same += n2 < n1 ? n2 : n1;
    }
    uint64_t count_more = count_max - count_min;
    uint64_t count_diff = count_min - count_same;

    free(dist1);
    free(dist2);
    
    const char* filename_min = count[0] < count[1] ? filename1 : filename2;
    const char* filename_max = count[0] < count[1] ? filename2 : filename1;
    fprintf(stdout, "trace \"%s\"(%lu insts)\n", filename_max, count_max);
    fprintf(stdout, "compares to\n");
    fprintf(stdout, "trace \"%s\"(%lu insts)\n", filename_min, count_min);
    fprintf(stdout, "Has %12lu(%f%%) same PC\n", count_same, count_same * 100.0 / count_min);
    fprintf(stdout, "Has %12lu(%f%%) more PC\n", count_more, count_more * 100.0 / count_min);
    fprintf(stdout, "Has %12lu(%f%%) diff PC\n", count_diff, count_diff * 100.0 / count_min);
    fprintf(stdout,"\n\n");
    return 0;
}

int diff_trace_cycles(const char *filename1, const char *filename2) {
    FILE* sim_trace_file1 = fopen_nofail(filename1, "rb");
    FILE* sim_trace_file2 = fopen_nofail(filename2, "rb");

    trace_item t1, t2;
    int64_t bias = 0;
    while (fread(&t1, sizeof(trace_item), 1, sim_trace_file1) == 1 && fread(&t2, sizeof(trace_item), 1, sim_trace_file2) == 1) {
        if (t1.sim_cycle != (t2.sim_cycle + bias)) {
            dump_trace_item(&t1);
            dump_trace_item(&t2);
            printf("cycles diff:%ld, bias:%ld, relative diff:%ld\n", t1.sim_cycle - t2.sim_cycle, bias,  t1.sim_cycle - t2.sim_cycle - bias);
            bias = t1.sim_cycle - t2.sim_cycle;
        }
    };
    fprintf(stdout,"\n\n");
    return 0;
}

void dump_fastforward_rtl_state(const char *filename) {
    FILE *reg_file = fopen_nofail(filename, "rb");
    uint64_t icount;
    lsassert(fread(&icount, sizeof(icount), 1, reg_file) == 1);
    // load state from binary
    LOONGARCH_RTL_STATE la_state;
    lsassert(fread(&la_state, sizeof(la_state), 1, reg_file) == 1);
    fclose(reg_file);
    loongarch_rtl_state_dump(&la_state, stdout);
}

int load_pattern(const char *filename, const char* arg) {
    FILE* sim_trace_file = fopen_nofail(filename, "rb");

    trace_item t;
    while (fread(&t, sizeof(t), 1, sim_trace_file) == 1) {
        fprintf(stdout, "cycles:%ld, ", t.sim_cycle);
        if (t.type == TRACE_ITEM_COMMIT) {
            dump_trace_item_load(&t);
        } else if (t.type == TRACE_ITEM_EX) {
              
        } else {
            abort();
        }
    };

    fprintf(stdout,"\n\n");
    return 0;
}

// dda: Data-Dependent Memory Accesses 
int dda_pattern(const char *filename, const char* arg) {
    FILE* sim_trace_file = fopen_nofail(filename, "rb");

    trace_item t;
    while (fread(&t, sizeof(t), 1, sim_trace_file) == 1) {
        if (t.type == TRACE_ITEM_COMMIT) {
            dump_trace_item_dda(&t);
        } else if (t.type == TRACE_ITEM_EX) {
              
        } else {
            abort();
        }
    };

    fprintf(stdout,"\n\n");
    return 0;
}

int main(int argc, char **argv) {
    if (argc < 3)
    {
        printf("print insn_trace.bin        : ./print_trace 1  ./logs/insn_trace.bin\n");
        printf("diff with random test       : ./print_trace 2  ./logs/insn_trace.bin ../testcase/randomTest/\n");
        printf("diff cycles                 : ./print_trace 3  ./logs/insn_trace1.bin ./logs/insn_trace2.bin\n");
        printf("format insn_trace.bin to csv: ./print_trace 4  ./logs/insn_trace.bin\n");
        printf("print sizeof(trace_item)    : ./print_trace 5\n");
        printf("print rtl regs              : ./print_trace 6  ./regs.bin\n");
        printf("diff insn_trace.bin         : ./print_trace 7  ./logs/insn_trace1.bin ./logs/insn_trace2.bin\n");
        printf("diff log pc distribution    : ./print_trace 8  ./logs/insn_trace1.bin ./logs/insn_trace2.bin\n");
        printf("print load_pattern          : ./print_trace 9  ./logs/insn_trace.bin\n");
        printf("print dda_pattern           : ./print_trace 10 ./logs/insn_trace.bin\n");
        return 0;
    }
    char* arg = NULL;
    if (argc > 3) {
        arg = argv[3];
    }

    int print_type = atoi(argv[1]);
    switch (print_type)
    {
    case 1:
        dump_trace(argv[2], arg);
        break;
    case 2:
        compare_trace(argv[2], argv[3]);
        break;
    case 3:
        diff_trace_cycles(argv[2], argv[3]);
        break;
    case 4:
        dump_trace_csv(argv[2]);
        break;
    case 5:
        printf("sizeof trace_item:%ld\n", sizeof(trace_item));
        break;
    case 6:
        dump_fastforward_rtl_state(argv[2]);
        break;
    case 7:
        diff_trace_res(argv[2], argv[3]);
        break;
    case 8:
        diff_trace_dist(argv[2], argv[3]);
        break;
    case 9:
        load_pattern(argv[2], arg);
        break;
    case 10:
        dda_pattern(argv[2], arg);
        break;
    default:
        printf("function not supported\n");
        break;
    }
    return 0;
}
