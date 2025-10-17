#ifndef __TRACE_H
#define __TRACE_H

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

enum IF_TYPE{
  IF_TYPE_NONE,
  IF_TYPE_REDUCE,
  IF_TYPE_UNREDUCE,
};

enum WR_TYPE {
    WR_TYPE_FIX   = 0,
    WR_TYPE_FLOAT = 1,
    WR_TYPE_VEC   = 2,
    WR_TYPE_FCC   = 3,
};

enum WR_SIZE {
    WR_SIZE_BYTE  = 0,
    WR_SIZE_HWORD = 1,
    WR_SIZE_WORD  = 2,
    WR_SIZE_DWORD = 3,
    WR_SIZE_QWORD = 4,
    WR_SIZE_DQWORD = 5,
};
enum TRACE_ITEM_TYPE{
  TRACE_ITEM_COMMIT,
  TRACE_ITEM_EX, // pc as epc, inst as badv, res as ecode
};

typedef struct {
    uint64_t commit_id; // instruction count, increase 1 every commit instruction
    uint64_t pc;        // instruction pc
    uint64_t inst;      // instruction raw bits
    uint64_t res;       // logic register write content or store content, fist int64 of vector commit
    uint64_t res1;       // second int64 of vector commit
    uint64_t id;        // debug id
    uint64_t paddr;     // physical address
    uint64_t vaddr;     // virtual address
    uint64_t exctime;      // actual execution timestamp
    uint32_t fcsr;        // fcsr, correct when fpu arith op
    uint8_t wen;        // writen enable
    uint8_t laddr;      // logic register addr
    uint8_t prf;        // physical register addr
    uint8_t package_head; // first committed instruction in commit package
    uint8_t excu;         // execution unit
    uint8_t fusion_type;  // instruction fusion type @IF_TYPE
    uint8_t write_type; // write type
    uint8_t write_size; // write size
    uint8_t vzoui;
} commit_info;

typedef struct {
    uint64_t exception_id; // exception count, increase 1 every exception
    uint64_t ecode;
    uint64_t badv;
    uint64_t epc;
    uint64_t bad_inst; //for random test only, find by epc
    uint64_t line; //for random test only, line of epc, pc.res
} exception_info;

typedef struct {
    uint64_t type; // trace yype @TRACE_ITEM_TYPE
    uint64_t sim_cycle; // sim_cycles
    union {
        commit_info commit;
        exception_info exception;
    };
} trace_item;

#define TLBRI      0x1
#define TLBXI      0x2
#define TLBMOD     0x3
#define TLBLI      0x4
#define TLBSI      0x5
#define ADEL       0x6
#define BOUND      0x7
#define ALIGN      0x8
#define MSAFPE     0x9
#define __FPE        0xa
#define RI         0xb
#define X86SETTAG  0xc
#define ILLEGAL_PC 0xd
#define TLBFI      0xe

#define INT   0x00 // interrupt if CSR.ECFGVS=0
#define PIL   0x02 // page illegal load
#define PIS   0x04 // page illegal store
#define PIF   0x06 // page illegal fetch
#define PME   0x08 // page modified exception
#define PNR   0x0a // page not readed exception
#define PNX   0x0c // page not executed exception
#define PPI   0x0e // page previlege illegal
#define ADEF  0x10 // address error fetch
#define ADEM  0x11 // address error memory
#define ALE   0x12 // address align exception
#define BCE   0x14 // bound check exception
#define SYS   0x16 // syscall
#define BRK   0x18 // breakpoint
#define INE   0x1a // instruction not exists
#define IPE   0x1c // instruction previlege error
#define FPD   0x1e // float point disabled
#define SXD   0x20 // simd extension disabled
#define ASXD  0x22 // advanced simd extension disabled
#define FPE   0x24 // float instruction error
#define VFPE  0x25 // vector float instruction error
#define WPEF  0x26 // vector float instruction error
#define WPEM  0x27 // vector float instruction error
#define BTD   0x28 // binary translation disabled
#define BTE   0x2a // binary translation exception
#define GSPR  0x2c // guest sensitive previlege resource exception
#define HVC   0x2e // hypervisor call
#define GCSC  0x30 // guest csr software change
#define GCHC  0x31 // guest csr hardware change
#define REDO  0x32 // flush pipeline, eg, store-load violation
#define TLBR  0x36 // tlb refill
#define ERTN  0x38 // ertn
#define NONE  0x7c // not a expection
static inline uint64_t rtlecode2rpgecode(uint64_t rtlecode) {
    switch (rtlecode)
    {
        case PIL:  return TLBLI;
        case PIS:  return TLBSI;
        case PIF:  return TLBFI;
        case PME:  return TLBMOD;
        case PNR:  return TLBRI;
        case PNX:  return TLBXI;
        case ADEF: return ILLEGAL_PC;
        case ADEM: return ADEL;
        case ALE:  return ALIGN;
        case BCE:  return BOUND;
        case INE:  return RI;
        case FPE:  return __FPE;
        default:   return -1;
    }
}

static const char* rpg_ename[] = {
    "NONE",
    "TLBRI",
    "TLBXI",
    "TLBMOD",
    "TLBLI",
    "TLBSI",
    "ADEL",
    "BOUND",
    "ALIGN",
    "MSAFPE",
    "__FPE",
    "RI",
    "X86SETTAG",
    "ILLEGAL_PC",
    "TLBFI",
};

static const char* rtl_ename[] = {
    [PIL]  = "PIL",
    [PIS]  = "PIS",
    [PIF]  = "PIF",
    [PME]  = "PME",
    [PNR]  = "PNR",
    [PNX]  = "PNX",
    [PPI]  = "PPI",
    [ADEF] = "ADEF",
    [ADEM] = "ADEM",
    [ALE]  = "ALE",
    [BCE]  = "BCE",
    [SYS]  = "SYS",
    [BRK]  = "BRK",
    [INE]  = "INE",
    [IPE]  = "IPE",
    [FPD]  = "FPD",
    [SXD]  = "SXD",
    [ASXD] = "ASXD",
    [FPE]  = "FPE",
    [VFPE] = "VFPE",
    [WPEF] = "WPEF",
    [WPEM] = "WPEM",
    [BTD]  = "BTD",
    [BTE]  = "BTE",
    [GSPR] = "GSPR",
    [HVC]  = "HVC",
    [GCSC] = "GCSC",
    [GCHC] = "GCHC",
    [REDO] = "REDO",
    [TLBR] = "TLBR",
    [ERTN] = "ERTN",
    [NONE] = "NONE",
};

static inline uint64_t is_random_test_pc(uint64_t pc) {
    static uint64_t pc_has_been_zero = 0;
    if (pc == 0) {pc_has_been_zero = 1;}
    // 0x8000 : page.res first page
    return pc_has_been_zero && !((pc >> 14) == (0x8000 >> 2) && (pc & 0x3) == 0x0);
}

static inline uint64_t is_amop(uint64_t insn) {
    uint32_t am_op = insn & 0xffff8000;
    return (am_op >= 0x38600000 && am_op <= 0x38718000);
}

static inline uint64_t is_fsel(uint64_t insn) {
    return (insn & 0xfffc0000) == 0x0d000000;
}

static inline uint64_t is_fload(uint64_t insn) {
    return (insn & 0xffc00000) == 0x2b000000 ||  //FLD.S
           (insn & 0xffc00000) == 0x2b800000 ||  //FLD.D
           (insn & 0xffff8000) == 0x38300000 ||  //FLDX.S
           (insn & 0xffff8000) == 0x38340000;    //FLDX.D
}

// fp instrutions that may consumes 4 line value.res when exception
static inline uint64_t is_fp_inst(uint64_t insn) {
    return ((insn & 0xffff8000) >= 0x01008000 && (insn & 0xfffffc00) <= 0x011e4800) ||//FADD.S-FRINT.D
           ((insn & 0xfff00000) >= 0x08100000 && (insn & 0xfff00000) <= 0x08e00000) ||//FMADD.S-FNMSUB.D
           is_fsel(insn) ||
           is_fload(insn);
}

static inline uint64_t is_fp_arith_inst(uint64_t insn) {
    return ((insn & 0xffff8000) >= 0x01008000 && (insn & 0xffff8000) <= 0x01110000) ||//FADD.S-FSCALEB.D
           ((insn & 0xfffffc00) >= 0x01142400 && (insn & 0xfffffc00) <= 0x01142800) ||//FLOGB.S-FLOGB.D
           ((insn & 0xfffffc00) >= 0x01144400 && (insn & 0xfffffc00) <= 0x01146800) ||//FSQRT.S-FRSQRT.D
           ((insn & 0xfffffc00) == 0x0114c000) || //MOVGR2FCSR
           ((insn & 0xfffffc00) >= 0x01191800 && (insn & 0xfffffc00) <= 0x011e4800) ||//FCVT.S.D-FRINT.D
           ((insn & 0xfff00000) >= 0x08100000 && (insn & 0xfff00000) <= 0x0c200000);  //FMADD.S-FCMP.cond.D
}


static inline uint64_t is_movgr2frh_w_first(uint64_t insn) {
    return (insn & 0xfffffc00) == 0x0114ac00;
}

static inline uint64_t is_movgr2frh_w_second(uint64_t insn) {
    return (insn & 0x1fffffc00) == 0x100000400;
}

static inline uint64_t is_rdtime_spliting(uint64_t insn) {
    // 1st instruction splited from a raw rdtime 
    uint32_t op = insn & 0xfffffc00;
    return (op >= 0x6000 && op <= 0x6800);
}

static inline uint64_t is_jirl_call(uint64_t insn) {
    return (insn & 0xfc00001f) == 0x4c000001;
}

static inline uint64_t is_bl_call(uint64_t insn) {
    return (insn & 0xfc000000) == 0x54000000;
}

static inline uint64_t is_call(uint64_t insn) {
    return is_jirl_call(insn) || is_bl_call(insn);
}

static inline uint64_t call_target(uint64_t pc, uint64_t insn, uint64_t *gpr) {
    if (is_jirl_call(insn)) {
        int rj = (insn >> 5) & 0X1f;
        int64_t offset = ((int64_t)((insn >> 10) & 0xffff)) << 48 >> 46;
        return gpr[rj] + offset;
    } else if (is_bl_call(insn)) {
        return pc + ((int64_t)(((insn >> 10) & 0xffff) | ((insn & 0x3ff) << 16)) << 38 >> 36) + 4;
    } else {
        return 0;
    }
}

static inline uint64_t is_ret(uint64_t insn) {
    // jirl $r0, $r1, 0
    return insn == 0x4c000020;
}

static inline uint64_t ret_target(uint64_t insn, uint64_t *gpr) {
    // jirl $r0, $r1, 0
    if (is_ret(insn)) {
        return gpr[1];
    } else {
        return 0;
    }
}

#define ARRAY_LEN(arr) ((int) (sizeof (arr) / sizeof (arr)[0]))

const static uint32_t la_ld[][2] = {
    {0x28000000, 0xffc00000},	// ld.b
    {0x28400000, 0xffc00000},	// ld.h
    {0x28800000, 0xffc00000},	// ld.w
    {0x28c00000, 0xffc00000},	// ld.d
    {0x2a000000, 0xffc00000},	// ld.bu
    {0x2a400000, 0xffc00000},	// ld.hu
    {0x2a800000, 0xffc00000},	// ld.wu
    {0x38000000, 0xffff8000},	// ldx.b
    {0x38040000, 0xffff8000},	// ldx.h
    {0x38080000, 0xffff8000},	// ldx.w
    {0x380c0000, 0xffff8000},	// ldx.d
    {0x38200000, 0xffff8000},	// ldx.bu
    {0x38240000, 0xffff8000},	// ldx.hu
    {0x38280000, 0xffff8000},	// ldx.wu
    {0x24000000, 0xff000000},	// ldptr.w
    {0x26000000, 0xff000000},	// ldptr.d
    {0x2b000000, 0xffc00000},	// fld.s
    {0x38300000, 0xffff8000},	// fldx.s
    {0x2b800000, 0xffc00000},	// fld.d
    {0x38340000, 0xffff8000},	// fldx.d
};
static inline int is_ld_inst(uint64_t insn) {
    int len = ARRAY_LEN(la_ld);
    for (int i = 0; i < len; i++) {
        if ((insn & la_ld[i][1]) == la_ld[i][0]) {
            return 1;
        }
    }
    return 0;
}

#ifdef __cplusplus
}
#endif

#endif //__TRACE_H
