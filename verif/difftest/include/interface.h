#ifndef CHIPLAB_INTERFACE_H
#define CHIPLAB_INTERFACE_H

#include "difftest.h"
#include "stdint.h"

/**
 * Headers for Verilog DPI-C difftest interface
 * These hearders are called to copy signals of dut
 */
#define DIFFTEST_DPIC_FUNC_NAME(name) \
    v_difftest_##name

#define DIFFTEST_DPIC_FUNC_DECL(name) \
    extern "C" void DIFFTEST_DPIC_FUNC_NAME(name)

#define DPIC_ARG_BIT  uint8_t
#define DPIC_ARG_BYTE char
#define DPIC_ARG_INT  int
#define DPIC_ARG_LONG long long
#define DPIC_ARG_BIT_OUT  uint8_t*
#define DPIC_ARG_BYTE_OUT char*
#define DPIC_ARG_INT_OUT  int*
#define DPIC_ARG_LONG_OUT uint64_t*

// v_difftest_InstrCommit
#define INTERFACE_INSTR_COMMIT           \
  DIFFTEST_DPIC_FUNC_DECL(InstrCommit) ( \
    DPIC_ARG_BYTE coreid,                \
    DPIC_ARG_BYTE index,                 \
    DPIC_ARG_BIT  valid,                 \
    DPIC_ARG_LONG pc,                    \
    DPIC_ARG_INT  instr,                 \
    DPIC_ARG_BIT  skip,                  \
    DPIC_ARG_BIT  is_TLBFILL,            \
    DPIC_ARG_BYTE TLBFILL_index,         \
    DPIC_ARG_BIT  is_CNTinst,            \
    DPIC_ARG_LONG timer_64_value,        \
    DPIC_ARG_BIT  wen,                   \
    DPIC_ARG_BYTE wdest,                 \
    DPIC_ARG_LONG wdata,                 \
    DPIC_ARG_BIT  csr_rstat,             \
    DPIC_ARG_INT  csr_data               \
  )

// v_difftest_ExcpEvent
#define INTERFACE_EXCP_EVENT             \
  DIFFTEST_DPIC_FUNC_DECL(ExcpEvent) (   \
    DPIC_ARG_BYTE coreid,                \
    DPIC_ARG_BIT  excp_valid,            \
    DPIC_ARG_BIT  eret,                  \
    DPIC_ARG_INT  intrNo,                \
    DPIC_ARG_INT  cause,                 \
    DPIC_ARG_LONG exceptionPC,           \
    DPIC_ARG_INT  exceptionInst          \
  )

// v_difftest_TrapEvent
#define INTERFACE_TRAP_EVENT             \
  DIFFTEST_DPIC_FUNC_DECL(TrapEvent) (   \
    DPIC_ARG_BYTE coreid,                \
    DPIC_ARG_BIT  valid,                 \
    DPIC_ARG_BYTE code,                  \
    DPIC_ARG_LONG pc,                    \
    DPIC_ARG_LONG cycleCnt,              \
    DPIC_ARG_LONG instrCnt               \
  )

// v_difftest_StoreEvent
#define INTERFACE_STORE_EVENT            \
  DIFFTEST_DPIC_FUNC_DECL(StoreEvent) (  \
    DPIC_ARG_BYTE coreid,                \
    DPIC_ARG_BYTE index,                 \
    DPIC_ARG_BIT  valid,                 \
    DPIC_ARG_LONG storePAddr,            \
    DPIC_ARG_LONG storeData,             \
    DPIC_ARG_BYTE storeMask              \
  )

// v_difftest_LoadEvent
#define INTERFACE_LOAD_EVENT             \
  DIFFTEST_DPIC_FUNC_DECL(LoadEvent) (   \
    DPIC_ARG_BYTE coreid,                \
    DPIC_ARG_BYTE index,                 \
    DPIC_ARG_BIT  valid,                 \
    DPIC_ARG_LONG paddr,                 \
    DPIC_ARG_LONG vaddr                  \
  )

// v_difftest_CSRState
#define INTERFACE_CSRREG_STATE           \
  DIFFTEST_DPIC_FUNC_DECL(CSRRegState) ( \
    DPIC_ARG_BYTE coreid,               \
    DPIC_ARG_LONG crmd,                 \
    DPIC_ARG_LONG prmd,                 \
    DPIC_ARG_LONG euen,                 \
    DPIC_ARG_LONG ecfg,                 \
    DPIC_ARG_LONG estat,                \
    DPIC_ARG_LONG era,                  \
    DPIC_ARG_LONG badv,                 \
    DPIC_ARG_LONG eentry,               \
    DPIC_ARG_LONG tlbidx,               \
    DPIC_ARG_LONG tlbehi,               \
    DPIC_ARG_LONG tlbelo0,              \
    DPIC_ARG_LONG tlbelo1,              \
    DPIC_ARG_LONG asid,                 \
    DPIC_ARG_LONG pgdl,                 \
    DPIC_ARG_LONG pgdh,                 \
    DPIC_ARG_LONG save0,                \
    DPIC_ARG_LONG save1,                \
    DPIC_ARG_LONG save2,                \
    DPIC_ARG_LONG save3,                \
    DPIC_ARG_LONG tid,                  \
    DPIC_ARG_LONG tcfg,                 \
    DPIC_ARG_LONG tval,                 \
    DPIC_ARG_LONG ticlr,                \
    DPIC_ARG_LONG llbctl,               \
    DPIC_ARG_LONG tlbrentry,            \
    DPIC_ARG_LONG dmw0,                 \
    DPIC_ARG_LONG dmw1                  \
  )

// v_difftest_GRegState
#define INTERFACE_GREG_STATE \
    DIFFTEST_DPIC_FUNC_DECL(GRegState) (     \
        DPIC_ARG_BYTE coreid,                \
        DPIC_ARG_LONG gpr_0,                 \
        DPIC_ARG_LONG gpr_1,                 \
        DPIC_ARG_LONG gpr_2,                 \
        DPIC_ARG_LONG gpr_3,                 \
        DPIC_ARG_LONG gpr_4,                 \
        DPIC_ARG_LONG gpr_5,                 \
        DPIC_ARG_LONG gpr_6,                 \
        DPIC_ARG_LONG gpr_7,                 \
        DPIC_ARG_LONG gpr_8,                 \
        DPIC_ARG_LONG gpr_9,                 \
        DPIC_ARG_LONG gpr_10,                \
        DPIC_ARG_LONG gpr_11,                \
        DPIC_ARG_LONG gpr_12,                \
        DPIC_ARG_LONG gpr_13,                \
        DPIC_ARG_LONG gpr_14,                \
        DPIC_ARG_LONG gpr_15,                \
        DPIC_ARG_LONG gpr_16,                \
        DPIC_ARG_LONG gpr_17,                \
        DPIC_ARG_LONG gpr_18,                \
        DPIC_ARG_LONG gpr_19,                \
        DPIC_ARG_LONG gpr_20,                \
        DPIC_ARG_LONG gpr_21,                \
        DPIC_ARG_LONG gpr_22,                \
        DPIC_ARG_LONG gpr_23,                \
        DPIC_ARG_LONG gpr_24,                \
        DPIC_ARG_LONG gpr_25,                \
        DPIC_ARG_LONG gpr_26,                \
        DPIC_ARG_LONG gpr_27,                \
        DPIC_ARG_LONG gpr_28,                \
        DPIC_ARG_LONG gpr_29,                \
        DPIC_ARG_LONG gpr_30,                \
        DPIC_ARG_LONG gpr_31                 \
    )

// v_difftest_FPRegState
#define INTERFACE_FPREG_STATE \
    DIFFTEST_DPIC_FUNC_DECL(FPRegState) (     \
        DPIC_ARG_BYTE coreid,                \
        DPIC_ARG_LONG fpr_0,                 \
        DPIC_ARG_LONG fpr_1,                 \
        DPIC_ARG_LONG fpr_2,                 \
        DPIC_ARG_LONG fpr_3,                 \
        DPIC_ARG_LONG fpr_4,                 \
        DPIC_ARG_LONG fpr_5,                 \
        DPIC_ARG_LONG fpr_6,                 \
        DPIC_ARG_LONG fpr_7,                 \
        DPIC_ARG_LONG fpr_8,                 \
        DPIC_ARG_LONG fpr_9,                 \
        DPIC_ARG_LONG fpr_10,                \
        DPIC_ARG_LONG fpr_11,                \
        DPIC_ARG_LONG fpr_12,                \
        DPIC_ARG_LONG fpr_13,                \
        DPIC_ARG_LONG fpr_14,                \
        DPIC_ARG_LONG fpr_15,                \
        DPIC_ARG_LONG fpr_16,                \
        DPIC_ARG_LONG fpr_17,                \
        DPIC_ARG_LONG fpr_18,                \
        DPIC_ARG_LONG fpr_19,                \
        DPIC_ARG_LONG fpr_20,                \
        DPIC_ARG_LONG fpr_21,                \
        DPIC_ARG_LONG fpr_22,                \
        DPIC_ARG_LONG fpr_23,                \
        DPIC_ARG_LONG fpr_24,                \
        DPIC_ARG_LONG fpr_25,                \
        DPIC_ARG_LONG fpr_26,                \
        DPIC_ARG_LONG fpr_27,                \
        DPIC_ARG_LONG fpr_28,                \
        DPIC_ARG_LONG fpr_29,                \
        DPIC_ARG_LONG fpr_30,                \
        DPIC_ARG_LONG fpr_31,                \
        DPIC_ARG_BYTE fccr,                  \
        DPIC_ARG_INT  fcsr0                  \
    )
#define INTERFACE_GREG_RESTORE \
    DIFFTEST_DPIC_FUNC_DECL(GRegRestore) (     \
        DPIC_ARG_BIT_OUT valid,                  \
        DPIC_ARG_BYTE    coreid,                 \
        DPIC_ARG_LONG_OUT gpr_0,                 \
        DPIC_ARG_LONG_OUT gpr_1,                 \
        DPIC_ARG_LONG_OUT gpr_2,                 \
        DPIC_ARG_LONG_OUT gpr_3,                 \
        DPIC_ARG_LONG_OUT gpr_4,                 \
        DPIC_ARG_LONG_OUT gpr_5,                 \
        DPIC_ARG_LONG_OUT gpr_6,                 \
        DPIC_ARG_LONG_OUT gpr_7,                 \
        DPIC_ARG_LONG_OUT gpr_8,                 \
        DPIC_ARG_LONG_OUT gpr_9,                 \
        DPIC_ARG_LONG_OUT gpr_10,                \
        DPIC_ARG_LONG_OUT gpr_11,                \
        DPIC_ARG_LONG_OUT gpr_12,                \
        DPIC_ARG_LONG_OUT gpr_13,                \
        DPIC_ARG_LONG_OUT gpr_14,                \
        DPIC_ARG_LONG_OUT gpr_15,                \
        DPIC_ARG_LONG_OUT gpr_16,                \
        DPIC_ARG_LONG_OUT gpr_17,                \
        DPIC_ARG_LONG_OUT gpr_18,                \
        DPIC_ARG_LONG_OUT gpr_19,                \
        DPIC_ARG_LONG_OUT gpr_20,                \
        DPIC_ARG_LONG_OUT gpr_21,                \
        DPIC_ARG_LONG_OUT gpr_22,                \
        DPIC_ARG_LONG_OUT gpr_23,                \
        DPIC_ARG_LONG_OUT gpr_24,                \
        DPIC_ARG_LONG_OUT gpr_25,                \
        DPIC_ARG_LONG_OUT gpr_26,                \
        DPIC_ARG_LONG_OUT gpr_27,                \
        DPIC_ARG_LONG_OUT gpr_28,                \
        DPIC_ARG_LONG_OUT gpr_29,                \
        DPIC_ARG_LONG_OUT gpr_30,                \
        DPIC_ARG_LONG_OUT gpr_31,                \
        DPIC_ARG_BYTE_OUT fcc                    \
    )

#define INTERFACE_FPREG_RESTORE \
    DIFFTEST_DPIC_FUNC_DECL(FPRegRestore) (     \
        DPIC_ARG_BIT_OUT valid,                  \
        DPIC_ARG_BYTE    coreid,                 \
        DPIC_ARG_LONG_OUT fpr_0,                 \
        DPIC_ARG_LONG_OUT fpr_1,                 \
        DPIC_ARG_LONG_OUT fpr_2,                 \
        DPIC_ARG_LONG_OUT fpr_3,                 \
        DPIC_ARG_LONG_OUT fpr_4,                 \
        DPIC_ARG_LONG_OUT fpr_5,                 \
        DPIC_ARG_LONG_OUT fpr_6,                 \
        DPIC_ARG_LONG_OUT fpr_7,                 \
        DPIC_ARG_LONG_OUT fpr_8,                 \
        DPIC_ARG_LONG_OUT fpr_9,                 \
        DPIC_ARG_LONG_OUT fpr_10,                \
        DPIC_ARG_LONG_OUT fpr_11,                \
        DPIC_ARG_LONG_OUT fpr_12,                \
        DPIC_ARG_LONG_OUT fpr_13,                \
        DPIC_ARG_LONG_OUT fpr_14,                \
        DPIC_ARG_LONG_OUT fpr_15,                \
        DPIC_ARG_LONG_OUT fpr_16,                \
        DPIC_ARG_LONG_OUT fpr_17,                \
        DPIC_ARG_LONG_OUT fpr_18,                \
        DPIC_ARG_LONG_OUT fpr_19,                \
        DPIC_ARG_LONG_OUT fpr_20,                \
        DPIC_ARG_LONG_OUT fpr_21,                \
        DPIC_ARG_LONG_OUT fpr_22,                \
        DPIC_ARG_LONG_OUT fpr_23,                \
        DPIC_ARG_LONG_OUT fpr_24,                \
        DPIC_ARG_LONG_OUT fpr_25,                \
        DPIC_ARG_LONG_OUT fpr_26,                \
        DPIC_ARG_LONG_OUT fpr_27,                \
        DPIC_ARG_LONG_OUT fpr_28,                \
        DPIC_ARG_LONG_OUT fpr_29,                \
        DPIC_ARG_LONG_OUT fpr_30,                \
        DPIC_ARG_LONG_OUT fpr_31                 \
    )

#define INTERFACE_CSRREG_RESTORE \
    DIFFTEST_DPIC_FUNC_DECL(CSRRegRestore) (    \
        DPIC_ARG_BIT_OUT valid,                  \
        DPIC_ARG_BYTE    coreid,                 \
        DPIC_ARG_LONG_OUT crmd,                  \
        DPIC_ARG_LONG_OUT prmd,                  \
        DPIC_ARG_LONG_OUT euen,                  \
        DPIC_ARG_LONG_OUT misc,                  \
        DPIC_ARG_LONG_OUT ecfg,                  \
        DPIC_ARG_LONG_OUT estat,                 \
        DPIC_ARG_LONG_OUT era,                   \
        DPIC_ARG_LONG_OUT badv,                  \
        DPIC_ARG_LONG_OUT badi,                  \
        DPIC_ARG_LONG_OUT eentry,                \
        DPIC_ARG_LONG_OUT tlbidx,                \
        DPIC_ARG_LONG_OUT asid,                  \
        DPIC_ARG_LONG_OUT pgdl,                  \
        DPIC_ARG_LONG_OUT pgdh,                  \
        DPIC_ARG_LONG_OUT pwcl,                  \
        DPIC_ARG_LONG_OUT pwch,                  \
        DPIC_ARG_LONG_OUT stlbps,                \
        DPIC_ARG_LONG_OUT rvacfg,                \
        DPIC_ARG_LONG_OUT save0,                 \
        DPIC_ARG_LONG_OUT save1,                 \
        DPIC_ARG_LONG_OUT save2,                 \
        DPIC_ARG_LONG_OUT save3,                 \
        DPIC_ARG_LONG_OUT tid,                   \
        DPIC_ARG_LONG_OUT tcfg,                  \
        DPIC_ARG_LONG_OUT tval,                  \
        DPIC_ARG_LONG_OUT ticlr,                 \
        DPIC_ARG_LONG_OUT cntc,                  \
        DPIC_ARG_LONG_OUT timer,                 \
        DPIC_ARG_LONG_OUT tlbrentry,             \
        DPIC_ARG_LONG_OUT tlbrehi,               \
        DPIC_ARG_LONG_OUT dmw0,                  \
        DPIC_ARG_LONG_OUT dmw1,                  \
        DPIC_ARG_LONG_OUT fcsr                   \
    )

#define INTERFACE_PC_RESTORE \
    DIFFTEST_DPIC_FUNC_DECL(PCRestore) (    \
        DPIC_ARG_BIT_OUT valid,                  \
        DPIC_ARG_BYTE    coreid,                 \
        DPIC_ARG_LONG_OUT pc                     \
    )

INTERFACE_INSTR_COMMIT;
INTERFACE_EXCP_EVENT;
INTERFACE_TRAP_EVENT;
INTERFACE_STORE_EVENT;
INTERFACE_LOAD_EVENT;
INTERFACE_CSRREG_STATE;
INTERFACE_GREG_STATE;
INTERFACE_FPREG_STATE;
INTERFACE_GREG_RESTORE;
INTERFACE_FPREG_RESTORE;
INTERFACE_CSRREG_RESTORE;
INTERFACE_PC_RESTORE;

#endif //CHIPLAB_INTERFACE_H
