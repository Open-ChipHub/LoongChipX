#ifndef __LOONGARCH_STATE_H
#define __LOONGARCH_STATE_H

#include <stdint.h>
#include <stdio.h>

#ifdef __cplusplus
extern "C" {
#endif

/* basic CSR register */
#define LOONGARCH_CSR_CRMD           0x0 /* 32 current mode info */
#define  CSR_CRMD_DACM_SHIFT         7
#define  CSR_CRMD_DACM_WIDTH         2
#define  CSR_CRMD_DACM               (0x3UL << CSR_CRMD_DACM_SHIFT)
#define  CSR_CRMD_DACF_SHIFT         5
#define  CSR_CRMD_DACF_WIDTH         2
#define  CSR_CRMD_DACF               (0x3UL << CSR_CRMD_DACF_SHIFT)
#define  CSR_CRMD_PG_SHIFT           4
#define  CSR_CRMD_PG                 (0x1UL << CSR_CRMD_PG_SHIFT)
#define  CSR_CRMD_DA_SHIFT           3
#define  CSR_CRMD_DA                 (0x1UL << CSR_CRMD_DA_SHIFT)
#define  CSR_CRMD_IE_SHIFT           2
#define  CSR_CRMD_IE                 (0x1UL << CSR_CRMD_IE_SHIFT)
#define  CSR_CRMD_PLV_SHIFT          0
#define  CSR_CRMD_PLV_WIDTH          2
#define  CSR_CRMD_PLV                (0x3UL << CSR_CRMD_PLV_SHIFT)

#define  PLV_USER                    3
#define  PLV_KERN                    0
#define  PLV_MASK                    0x3

#define LOONGARCH_CSR_PRMD           0x1 /* 32 prev-exception mode info */
#define  CSR_PRMD_PIE_SHIFT          2
#define  CSR_PRMD_PIE                (0x1UL << CSR_PRMD_PIE_SHIFT)
#define  CSR_PRMD_PPLV_SHIFT         0
#define  CSR_PRMD_PPLV_WIDTH         2
#define  CSR_PRMD_PPLV               (0x3UL << CSR_PRMD_PPLV_SHIFT)

#define LOONGARCH_CSR_EUEN           0x2 /* 32 coprocessor enable */
#define  CSR_EUEN_LBTEN_SHIFT        3
#define  CSR_EUEN_LBTEN              (0x1UL << CSR_EUEN_LBTEN_SHIFT)
#define  CSR_EUEN_LASXEN_SHIFT       2
#define  CSR_EUEN_LASXEN             (0x1UL << CSR_EUEN_LASXEN_SHIFT)
#define  CSR_EUEN_LSXEN_SHIFT        1
#define  CSR_EUEN_LSXEN              (0x1UL << CSR_EUEN_LSXEN_SHIFT)
#define  CSR_EUEN_FPEN_SHIFT         0
#define  CSR_EUEN_FPEN               (0x1UL << CSR_EUEN_FPEN_SHIFT)

#define LOONGARCH_CSR_MISC           0x3 /* 32 misc config */

#define LOONGARCH_CSR_ECFG           0x4 /* 32 exception config */
#define  CSR_ECFG_VS_SHIFT           16
#define  CSR_ECFG_VS_WIDTH           3
#define  CSR_ECFG_VS                 (0x7UL << CSR_ECFG_VS_SHIFT)
#define  CSR_ECFG_IM_SHIFT           0
#define  CSR_ECFG_IM_WIDTH           13
#define  CSR_ECFG_IM                 (0x1fffUL << CSR_ECFG_IM_SHIFT)

#define  CSR_ECFG_IPMASK             0x00001fff

#define LOONGARCH_CSR_ESTAT          0x5 /* Exception status */
#define  CSR_ESTAT_ESUBCODE_SHIFT    22
#define  CSR_ESTAT_ESUBCODE_WIDTH    9
#define  CSR_ESTAT_ESUBCODE          (0x1ffULL << CSR_ESTAT_ESUBCODE_SHIFT)
#define  CSR_ESTAT_EXC_SH            16
#define  CSR_ESTAT_EXC_WIDTH         5
#define  CSR_ESTAT_EXC               (0x1fULL << CSR_ESTAT_EXC_SH)
#define  CSR_ESTAT_IS_SHIFT          0
#define  CSR_ESTAT_IS_WIDTH          15
#define  CSR_ESTAT_IS                (0x7fffULL << CSR_ESTAT_IS_SHIFT)

#define  CSR_ESTAT_IPMASK            0x00001fff

#define  EXCODE_IP                   64
#define  EXCCODE_RSV                 0
#define  EXCCODE_TLBL                1
#define  EXCCODE_TLBS                2
#define  EXCCODE_TLBI                3
#define  EXCCODE_MOD                 4
#define  EXCCODE_TLBRI               5
#define  EXCCODE_TLBXI               6
#define  EXCCODE_TLBPE               7
#define  EXCCODE_ADE                 8
#define  EXCCODE_UNALIGN             9
#define  EXCCODE_OOB                 10
#define  EXCCODE_SYS                 11
#define  EXCCODE_BP                  12
#define  EXCCODE_RI                  13
#define  EXCCODE_IPE                 14
#define  EXCCODE_FPDIS               15
#define  EXCCODE_LSXDIS              16
#define  EXCCODE_LASXDIS             17
#define  EXCCODE_FPE                 18
#define  EXCCODE_WATCH               19
#define  EXCCODE_BTDIS               20
#define  EXCCODE_BTE                 21
#define  EXCCODE_PSI                 22
#define  EXCCODE_HYP                 23
#define  EXCCODE_FC                  24
#define  EXCCODE_SE                  25

#define LOONGARCH_CSR_ERA            0x6 /* 64 error PC */

#define LOONGARCH_CSR_BADV           0x7 /* 64 bad virtual address */

#define LOONGARCH_CSR_BADI           0x8 /* 32 bad instruction */

#define LOONGARCH_CSR_EEPN           0xc /* 64 exception enter base address */
#define  LOONGARCH_EEPN_CPUID        (0x3ffULL << 0)

#define CU_FPE                       1
#define CU_LSXE                      (1 << 1)
#define CU_LASXE                     (1 << 2)
#define CU_LBTE                      (1 << 3)

/* TLB related CSR register : start with TLB if no pagewalk */
/* 32 TLB Index, EHINV, PageSize, is_gtlb */
#define LOONGARCH_CSR_TLBIDX         0x10
#define  CSR_TLBIDX_EHINV_SHIFT      31
#define  CSR_TLBIDX_EHINV            (0x1ULL << CSR_TLBIDX_EHINV_SHIFT)
#define  CSR_TLBIDX_PS_SHIFT         24
#define  CSR_TLBIDX_PS_WIDTH         6
#define  CSR_TLBIDX_PS               (0x3fULL << CSR_TLBIDX_PS_SHIFT)
#define  CSR_TLBIDX_IDX_SHIFT        0
#define  CSR_TLBIDX_IDX_WIDTH        12
#define  CSR_TLBIDX_IDX              (0xfffULL << CSR_TLBIDX_IDX_SHIFT)
#define  CSR_TLBIDX_SIZEM            0x3f000000
#define  CSR_TLBIDX_SIZE             CSR_TLBIDX_PS_SHIFT
#define  CSR_TLBIDX_IDXM             0xfff

#define LOONGARCH_CSR_TLBEHI         0x11 /* 64 TLB EntryHi without ASID */

#define LOONGARCH_CSR_TLBELO0        0x12 /* 64 TLB EntryLo0 */
#define  CSR_TLBLO0_RPLV_SHIFT       63
#define  CSR_TLBLO0_RPLV             (0x1ULL << CSR_TLBLO0_RPLV_SHIFT)
#define  CSR_TLBLO0_XI_SHIFT         62
#define  CSR_TLBLO0_XI               (0x1ULL << CSR_TLBLO0_XI_SHIFT)
#define  CSR_TLBLO0_RI_SHIFT         61
#define  CSR_TLBLO0_RI               (0x1ULL << CSR_TLBLO0_RI_SHIFT)
#define  CSR_TLBLO0_PPN_SHIFT        12
#define  CSR_TLBLO0_PPN_WIDTH        36 /* ignore lower 12bits */
#define  CSR_TLBLO0_PPN              (0xfffffffffULL << CSR_TLBLO0_PPN_SHIFT)
#define  CSR_TLBLO0_GLOBAL_SHIFT     6
#define  CSR_TLBLO0_GLOBAL           (0x1ULL << CSR_TLBLO0_GLOBAL_SHIFT)
#define  CSR_TLBLO0_CCA_SHIFT        4
#define  CSR_TLBLO0_CCA_WIDTH        2
#define  CSR_TLBLO0_CCA              (0x3ULL << CSR_TLBLO0_CCA_SHIFT)
#define  CSR_TLBLO0_PLV_SHIFT        2
#define  CSR_TLBLO0_PLV_WIDTH        2
#define  CSR_TLBLO0_PLV              (0x3ULL << CSR_TLBLO0_PLV_SHIFT)
#define  CSR_TLBLO0_WE_SHIFT         1
#define  CSR_TLBLO0_WE               (0x1ULL << CSR_TLBLO0_WE_SHIFT)
#define  CSR_TLBLO0_V_SHIFT          0
#define  CSR_TLBLO0_V                (0x1ULL << CSR_TLBLO0_V_SHIFT)

#define LOONGARCH_CSR_TLBELO1        0x13 /* 64 TLB EntryLo1 */
#define  CSR_TLBLO1_RPLV_SHIFT       63
#define  CSR_TLBLO1_RPLV             (0x1ULL << CSR_TLBLO1_RPLV_SHIFT)
#define  CSR_TLBLO1_XI_SHIFT         62
#define  CSR_TLBLO1_XI               (0x1ULL << CSR_TLBLO1_XI_SHIFT)
#define  CSR_TLBLO1_RI_SHIFT         61
#define  CSR_TLBLO1_RI               (0x1ULL << CSR_TLBLO1_RI_SHIFT)
#define  CSR_TLBLO1_PPN_SHIFT        12
#define  CSR_TLBLO1_PPN_WIDTH        36 /* ignore lower 12bits */
#define  CSR_TLBLO1_PPN              (0xfffffffffULL << CSR_TLBLO1_PPN_SHIFT)
#define  CSR_TLBLO1_GLOBAL_SHIFT     6
#define  CSR_TLBLO1_GLOBAL           (0x1ULL << CSR_TLBLO1_GLOBAL_SHIFT)
#define  CSR_TLBLO1_CCA_SHIFT        4
#define  CSR_TLBLO1_CCA_WIDTH        2
#define  CSR_TLBLO1_CCA              (0x3ULL << CSR_TLBLO1_CCA_SHIFT)
#define  CSR_TLBLO1_PLV_SHIFT        2
#define  CSR_TLBLO1_PLV_WIDTH        2
#define  CSR_TLBLO1_PLV              (0x3ULL << CSR_TLBLO1_PLV_SHIFT)
#define  CSR_TLBLO1_WE_SHIFT         1
#define  CSR_TLBLO1_WE               (0x1ULL << CSR_TLBLO1_WE_SHIFT)
#define  CSR_TLBLO1_V_SHIFT          0
#define  CSR_TLBLO1_V                (0x1ULL << CSR_TLBLO1_V_SHIFT)

#define LOONGARCH_ENTRYLO_RI         (1ULL << 61)
#define LOONGARCH_ENTRYLO_XI         (1ULL << 62)

#define LOONGARCH_CSR_TLBWIRED       0x14 /* 32   TLB wired */
#define LOONGARCH_CSR_GTLBC          0x15 /* guest-related TLB */
#define  CSR_GTLBC_RID_SHIFT         16
#define  CSR_GTLBC_RID_WIDTH         8
#define  CSR_GTLBC_RID               (0xffULL << CSR_GTLBC_RID_SHIFT)
#define  CSR_GTLBC_TOTI_SHIFT        13
#define  CSR_GTLBC_TOTI              (0x1ULL << CSR_GTLBC_TOTI_SHIFT)
#define  CSR_GTLBC_USERID_SHIFT      12
#define  CSR_GTLBC_USERID            (0x1ULL << CSR_GTLBC_USERID_SHIFT)
#define  CSR_GTLBC_GMTLBSZ_SHIFT     0
#define  CSR_GTLBC_GMTLBSZ_WIDTH     6
#define  CSR_GTLBC_GMTLBSZ           (0x3fULL << CSR_GTLBC_GVTLBSZ_SHIFT)

#define LOONGARCH_CSR_TRGP           0x16 /* guest-related TLB */
#define  CSR_TRGP_RID_SHIFT          16
#define  CSR_TRGP_RID_WIDTH          8
#define  CSR_TRGP_RID                (0xffULL << CSR_TRGP_RID_SHIFT)
#define  CSR_TRGP_GTLB_SHIFT         0
#define  CSR_TRGP_GTLB               (1 << CSR_TRGP_GTLB_SHIFT)

#define LOONGARCH_CSR_ASID           0x18 /* 64 ASID */
#define  CSR_ASID_BIT_SHIFT          16 /* ASIDBits */
#define  CSR_ASID_BIT_WIDTH          8
#define  CSR_ASID_BIT                (0xffULL << CSR_ASID_BIT_SHIFT)
#define  CSR_ASID_ASID_SHIFT         0
#define  CSR_ASID_ASID_WIDTH         10
#define  CSR_ASID_ASID               (0x3ffULL << CSR_ASID_ASID_SHIFT)

/* 64 page table base address when badv[47] = 0 */
#define LOONGARCH_CSR_PGDL           0x19
/* 64 page table base address when badv[47] = 1 */
#define LOONGARCH_CSR_PGDH           0x1a

#define LOONGARCH_CSR_PGD            0x1b /* 64 page table base */

#define LOONGARCH_CSR_PWCTL0         0x1c /* 64 PWCtl0 */
#define  CSR_PWCTL0_PTEW_SHIFT       30
#define  CSR_PWCTL0_PTEW_WIDTH       2
#define  CSR_PWCTL0_PTEW             (0x3ULL << CSR_PWCTL0_PTEW_SHIFT)
#define  CSR_PWCTL0_DIR1WIDTH_SHIFT  25
#define  CSR_PWCTL0_DIR1WIDTH_WIDTH  5
#define  CSR_PWCTL0_DIR1WIDTH        (0x1fULL << CSR_PWCTL0_DIR1WIDTH_SHIFT)
#define  CSR_PWCTL0_DIR1BASE_SHIFT   20
#define  CSR_PWCTL0_DIR1BASE_WIDTH   5
#define  CSR_PWCTL0_DIR1BASE         (0x1fULL << CSR_PWCTL0_DIR1BASE_SHIFT)
#define  CSR_PWCTL0_DIR0WIDTH_SHIFT  15
#define  CSR_PWCTL0_DIR0WIDTH_WIDTH  5
#define  CSR_PWCTL0_DIR0WIDTH        (0x1fULL << CSR_PWCTL0_DIR0WIDTH_SHIFT)
#define  CSR_PWCTL0_DIR0BASE_SHIFT   10
#define  CSR_PWCTL0_DIR0BASE_WIDTH   5
#define  CSR_PWCTL0_DIR0BASE         (0x1fULL << CSR_PWCTL0_DIR0BASE_SHIFT)
#define  CSR_PWCTL0_PTWIDTH_SHIFT    5
#define  CSR_PWCTL0_PTWIDTH_WIDTH    5
#define  CSR_PWCTL0_PTWIDTH          (0x1fULL << CSR_PWCTL0_PTWIDTH_SHIFT)
#define  CSR_PWCTL0_PTBASE_SHIFT     0
#define  CSR_PWCTL0_PTBASE_WIDTH     5
#define  CSR_PWCTL0_PTBASE           (0x1fULL << CSR_PWCTL0_PTBASE_SHIFT)

#define LOONGARCH_CSR_PWCTL1         0x1d /* 64 PWCtl1 */
#define  CSR_PWCTL1_DIR3WIDTH_SHIFT  18
#define  CSR_PWCTL1_DIR3WIDTH_WIDTH  5
#define  CSR_PWCTL1_DIR3WIDTH        (0x1fULL << CSR_PWCTL1_DIR3WIDTH_SHIFT)
#define  CSR_PWCTL1_DIR3BASE_SHIFT   12
#define  CSR_PWCTL1_DIR3BASE_WIDTH   5
#define  CSR_PWCTL1_DIR3BASE         (0x1fULL << CSR_PWCTL0_DIR3BASE_SHIFT)
#define  CSR_PWCTL1_DIR2WIDTH_SHIFT  6
#define  CSR_PWCTL1_DIR2WIDTH_WIDTH  5
#define  CSR_PWCTL1_DIR2WIDTH        (0x1fULL << CSR_PWCTL1_DIR2WIDTH_SHIFT)
#define  CSR_PWCTL1_DIR2BASE_SHIFT   0
#define  CSR_PWCTL1_DIR2BASE_WIDTH   5
#define  CSR_PWCTL1_DIR2BASE         (0x1fULL << CSR_PWCTL0_DIR2BASE_SHIFT)

#define LOONGARCH_CSR_STLBPGSIZE     0x1e /* 64 */
#define  CSR_STLBPGSIZE_PS_WIDTH     6
#define  CSR_STLBPGSIZE_PS           (0x3f)

#define LOONGARCH_CSR_RVACFG         0x1f
#define  CSR_RVACFG_RDVA_WIDTH       4
#define  CSR_RVACFG_RDVA             (0xf)

/* read only CSR register : start with CPU */
#define LOONGARCH_CSR_CPUID          0x20 /* 32 CPU core number */
#define  CSR_CPUID_CID_WIDTH         9
#define  CSR_CPUID_CID               (0x1ff)

#define LOONGARCH_CSR_PRCFG1         0x21 /* 32 CPU info */
#define  CSR_CONF1_VSMAX_SHIFT       12
#define  CSR_CONF1_VSMAX_WIDTH       3
#define  CSR_CONF1_VSMAX             (7ULL << CSR_CONF1_VSMAX_SHIFT)
/* stable timer bits - 1, 0x2f = 47*/
#define  CSR_CONF1_TMRBITS_SHIFT     4
#define  CSR_CONF1_TMRBITS_WIDTH     8
#define  CSR_CONF1_TMRBITS           (0xffULL << CSR_CONF1_TMRBITS_SHIFT)
#define  CSR_CONF1_KSNUM_SHIFT       0
#define  CSR_CONF1_KSNUM_WIDTH       4
#define  CSR_CONF1_KSNUM             (0x8)

#define LOONGARCH_CSR_PRCFG2         0x22
#define  CSR_CONF2_PGMASK_SUPP       0x3ffff000

#define LOONGARCH_CSR_PRCFG3         0x23
#define  CSR_CONF3_STLBIDX_SHIFT     20
#define  CSR_CONF3_STLBIDX_WIDTH     6
#define  CSR_CONF3_STLBIDX           (0x3fULL << CSR_CONF3_STLBIDX_SHIFT)
#define  CSR_STLB_SETS               256
#define  CSR_CONF3_STLBWAYS_SHIFT    12
#define  CSR_CONF3_STLBWAYS_WIDTH    8
#define  CSR_CONF3_STLBWAYS          (0xffULL << CSR_CONF3_STLBWAYS_SHIFT)
#define  CSR_STLBWAYS_SIZE           8
#define  CSR_CONF3_MTLBSIZE_SHIFT    4
#define  CSR_CONF3_MTLBSIZE_WIDTH    8
#define  CSR_CONF3_MTLBSIZE          (0xffULL << CSR_CONF3_MTLBSIZE_SHIFT)
/* mean VTLB 64 index */
#define  CSR_MTLB_SIZE               64
#define  CSR_CONF3_TLBORG_SHIFT      0
#define  CSR_CONF3_TLBORG_WIDTH      4
#define  CSR_CONF3_TLBORG            (0xfULL << CSR_CONF3_TLBORG_SHIFT)
/* mean use MTLB+STLB */
#define  TLB_ORG                     2

/* Kscratch : start with KS */
#define LOONGARCH_CSR_KS0            0x30 /* 64 */
#define LOONGARCH_CSR_KS1            0x31 /* 64 */
#define LOONGARCH_CSR_KS2            0x32 /* 64 */
#define LOONGARCH_CSR_KS3            0x33 /* 64 */
#define LOONGARCH_CSR_KS4            0x34 /* 64 */
#define LOONGARCH_CSR_KS5            0x35 /* 64 */
#define LOONGARCH_CSR_KS6            0x36 /* 64 */
#define LOONGARCH_CSR_KS7            0x37 /* 64 */
#define LOONGARCH_CSR_KS8            0x38 /* 64 */

/* timer : start with TM */
#define LOONGARCH_CSR_TMID           0x40 /* 32 timer ID */

#define LOONGARCH_CSR_TCFG           0x41 /* 64 timer config */
#define  CSR_TCFG_VAL_SHIFT          2
#define  CSR_TCFG_VAL_WIDTH          48
#define  CSR_TCFG_VAL                (0x3fffffffffffULL << CSR_TCFG_VAL_SHIFT)
#define  CSR_TCFG_PERIOD_SHIFT       1
#define  CSR_TCFG_PERIOD             (0x1ULL << CSR_TCFG_PERIOD_SHIFT)
#define  CSR_TCFG_EN                 (0x1)

#define LOONGARCH_CSR_TVAL           0x42 /* 64 timer ticks remain */

#define LOONGARCH_CSR_CNTC           0x43 /* 64 timer offset */

#define LOONGARCH_CSR_TINTCLR        0x44 /* 64 timer interrupt clear */
#define  CSR_TINTCLR_TI_SHIFT        0
#define  CSR_TINTCLR_TI              (1 << CSR_TINTCLR_TI_SHIFT)

/* guest : start with GST */
#define LOONGARCH_CSR_GSTAT          0x50 /* 32 basic guest info */
#define  CSR_GSTAT_GID_SHIFT         16
#define  CSR_GSTAT_GID_WIDTH         8
#define  CSR_GSTAT_GID               (0xffULL << CSR_GSTAT_GID_SHIFT)
#define  CSR_GSTAT_GIDBIT_SHIFT      4
#define  CSR_GSTAT_GIDBIT_WIDTH      6
#define  CSR_GSTAT_GIDBIT            (0x3fULL << CSR_GSTAT_GIDBIT_SHIFT)
#define  CSR_GSTAT_PVM_SHIFT         1
#define  CSR_GSTAT_PVM               (0x1ULL << CSR_GSTAT_PVM_SHIFT)
#define  CSR_GSTAT_VM_SHIFT          0
#define  CSR_GSTAT_VM                (0x1ULL << CSR_GSTAT_VM_SHIFT)

#define LOONGARCH_CSR_GCFG           0x51 /* 32 guest config */
#define  CSR_GCFG_GPERF_SHIFT        24
#define  CSR_GCFG_GPERF_WIDTH        3
#define  CSR_GCFG_GPERF              (0x7ULL << CSR_GCFG_GPERF_SHIFT)
#define  CSR_GCFG_GCI_SHIFT          20
#define  CSR_GCFG_GCI_WIDTH          2
#define  CSR_GCFG_GCI                (0x3ULL << CSR_GCFG_GCI_SHIFT)
#define  CSR_GCFG_GCI_ALL            (0x0ULL << CSR_GCFG_GCI_SHIFT)
#define  CSR_GCFG_GCI_HIT            (0x1ULL << CSR_GCFG_GCI_SHIFT)
#define  CSR_GCFG_GCI_SECURE         (0x2ULL << CSR_GCFG_GCI_SHIFT)
#define  CSR_GCFG_GCIP_SHIFT         16
#define  CSR_GCFG_GCIP               (0xfULL << CSR_GCFG_GCIP_SHIFT)
#define  CSR_GCFG_GCIP_ALL           (0x1ULL << CSR_GCFG_GCIP_SHIFT)
#define  CSR_GCFG_GCIP_HIT           (0x1ULL << (CSR_GCFG_GCIP_SHIFT + 1))
#define  CSR_GCFG_GCIP_SECURE        (0x1ULL << (CSR_GCFG_GCIP_SHIFT + 2))
#define  CSR_GCFG_TORU_SHIFT         15
#define  CSR_GCFG_TORU               (0x1ULL << CSR_GCFG_TORU_SHIFT)
#define  CSR_GCFG_TORUP_SHIFT        14
#define  CSR_GCFG_TORUP              (0x1ULL << CSR_GCFG_TORUP_SHIFT)
#define  CSR_GCFG_TOP_SHIFT          13
#define  CSR_GCFG_TOP                (0x1ULL << CSR_GCFG_TOP_SHIFT)
#define  CSR_GCFG_TOPP_SHIFT         12
#define  CSR_GCFG_TOPP               (0x1ULL << CSR_GCFG_TOPP_SHIFT)
#define  CSR_GCFG_TOE_SHIFT          11
#define  CSR_GCFG_TOE                (0x1ULL << CSR_GCFG_TOE_SHIFT)
#define  CSR_GCFG_TOEP_SHIFT         10
#define  CSR_GCFG_TOEP               (0x1ULL << CSR_GCFG_TOEP_SHIFT)
#define  CSR_GCFG_TIT_SHIFT          9
#define  CSR_GCFG_TIT                (0x1ULL << CSR_GCFG_TIT_SHIFT)
#define  CSR_GCFG_TITP_SHIFT         8
#define  CSR_GCFG_TITP               (0x1ULL << CSR_GCFG_TITP_SHIFT)
#define  CSR_GCFG_SIT_SHIFT          7
#define  CSR_GCFG_SIT                (0x1ULL << CSR_GCFG_SIT_SHIFT)
#define  CSR_GCFG_SITP_SHIFT         6
#define  CSR_GCFG_SITP               (0x1ULL << CSR_GCFG_SITP_SHIFT)
#define  CSR_GCFG_CACTRL_SHIFT       4
#define  CSR_GCFG_CACTRL_WIDTH       2
#define  CSR_GCFG_CACTRL             (0x3ULL << CSR_GCFG_CACTRL_SHIFT)
#define  CSR_GCFG_CACTRL_GUEST       (0x0ULL << CSR_GCFG_CACTRL_SHIFT)
#define  CSR_GCFG_CACTRL_ROOT        (0x1ULL << CSR_GCFG_CACTRL_SHIFT)
#define  CSR_GCFG_CACTRL_NEST        (0x2ULL << CSR_GCFG_CACTRL_SHIFT)
#define  CSR_GCFG_CCCP_WIDTH         4
#define  CSR_GCFG_CCCP               (0xf)
#define  CSR_GCFG_CCCP_GUEST         (0x1ULL << 0)
#define  CSR_GCFG_CCCP_ROOT          (0x1ULL << 1)
#define  CSR_GCFG_CCCP_NEST          (0x1ULL << 2)

#define LOONGARCH_CSR_GINTC          0x52 /* 64 guest exception control */
#define  CSR_GINTC_HC_SHIFT          16
#define  CSR_GINTC_HC_WIDTH          8
#define  CSR_GINTC_HC                (0xffULL << CSR_GINTC_HC_SHIFT)
#define  CSR_GINTC_PIP_SHIFT         8
#define  CSR_GINTC_PIP_WIDTH         8
#define  CSR_GINTC_PIP               (0xffULL << CSR_GINTC_PIP_SHIFT)
#define  CSR_GINTC_VIP_SHIFT         0
#define  CSR_GINTC_VIP_WIDTH         8
#define  CSR_GINTC_VIP               (0xff)

#define LOONGARCH_CSR_GCNTC          0x53 /* 64 guest timer offset */

/* LLBCTL */
#define LOONGARCH_CSR_LLBCTL          0x60 /* 32 csr number to be changed */
#define  CSR_LLBCTL_ROLLB_SHIFT       0
#define  CSR_LLBCTL_ROLLB             (1ULL << CSR_LLBCTL_ROLLB_SHIFT)
#define  CSR_LLBCTL_WCLLB_SHIFT       1
#define  CSR_LLBCTL_WCLLB             (1ULL << CSR_LLBCTL_WCLLB_SHIFT)
#define  CSR_LLBCTL_KLO_SHIFT         2
#define  CSR_LLBCTL_KLO               (1ULL << CSR_LLBCTL_KLO_SHIFT)

/* implement dependent */
#define LOONGARCH_CSR_IMPCTL1        0x80 /* 32 loongarch config */
#define  CSR_MISPEC_SHIFT            20
#define  CSR_MISPEC_WIDTH            8
#define  CSR_MISPEC                  (0xffULL << CSR_MISPEC_SHIFT)
#define  CSR_SSEN_SHIFT              18
#define  CSR_SSEN                    (1ULL << CSR_SSEN_SHIFT)
#define  CSR_SCRAND_SHIFT            17
#define  CSR_SCRAND                  (1ULL << CSR_SCRAND_SHIFT)
#define  CSR_LLEXCL_SHIFT            16
#define  CSR_LLEXCL                  (1ULL << CSR_LLEXCL_SHIFT)
#define  CSR_DISVC_SHIFT             15
#define  CSR_DISVC                   (1ULL << CSR_DISVC_SHIFT)
#define  CSR_VCLRU_SHIFT             14
#define  CSR_VCLRU                   (1ULL << CSR_VCLRU_SHIFT)
#define  CSR_DCLRU_SHIFT             13
#define  CSR_DCLRU                   (1ULL << CSR_DCLRU_SHIFT)
#define  CSR_FASTLDQ_SHIFT           12
#define  CSR_FASTLDQ                 (1ULL << CSR_FASTLDQ_SHIFT)
#define  CSR_USERCAC_SHIFT           11
#define  CSR_USERCAC                 (1ULL << CSR_USERCAC_SHIFT)
#define  CSR_ANTI_MISPEC_SHIFT       10
#define  CSR_ANTI_MISPEC             (1ULL << CSR_ANTI_MISPEC_SHIFT)
#define  CSR_ANTI_FLUSHSFB_SHIFT     9
#define  CSR_ANTI_FLUSHSFB           (1ULL << CSR_ANTI_FLUSHSFB_SHIFT)
#define  CSR_STFILL_SHIFT            8
#define  CSR_STFILL                  (1ULL << CSR_STFILL_SHIFT)
#define  CSR_LIFEP_SHIFT             7
#define  CSR_LIFEP                   (1ULL << CSR_LIFEP_SHIFT)
#define  CSR_LLSYNC_SHIFT            6
#define  CSR_LLSYNC                  (1ULL << CSR_LLSYNC_SHIFT)
#define  CSR_BRBTDIS_SHIFT           5
#define  CSR_BRBTDIS                 (1ULL << CSR_BRBTDIS_SHIFT)
#define  CSR_RASDIS_SHIFT            4
#define  CSR_RASDIS                  (1ULL << CSR_RASDIS_SHIFT)
#define  CSR_STPRE_SHIFT             2
#define  CSR_STPRE_WIDTH             2
#define  CSR_STPRE                   (3ULL << CSR_STPRE_SHIFT)
#define  CSR_INSTPRE_SHIFT           1
#define  CSR_INSTPRE                 (1ULL << CSR_INSTPRE_SHIFT)
#define  CSR_DATAPRE_SHIFT           0
#define  CSR_DATAPRE                 (1ULL << CSR_DATAPRE_SHIFT)

#define LOONGARCH_CSR_IMPCTL2        0x81 /* 32 Flush */
#define  CSR_IMPCTL2_MTLB_SHIFT      0
#define  CSR_IMPCTL2_MTLB            (1ULL << CSR_IMPCTL2_MTLB_SHIFT)
#define  CSR_IMPCTL2_STLB_SHIFT      1
#define  CSR_IMPCTL2_STLB            (1ULL << CSR_IMPCTL2_STLB_SHIFT)
#define  CSR_IMPCTL2_DTLB_SHIFT      2
#define  CSR_IMPCTL2_DTLB            (1ULL << CSR_IMPCTL2_DTLB_SHIFT)
#define  CSR_IMPCTL2_ITLB_SHIFT      3
#define  CSR_IMPCTL2_ITLB            (1ULL << CSR_IMPCTL2_ITLB_SHIFT)
#define  CSR_IMPCTL2_BTAC_SHIFT      4
#define  CSR_IMPCTL2_BTAC            (1ULL << CSR_IMPCTL2_BTAC_SHIFT)

#define  LOONGARCH_FLUSH_VTLB        1
#define  LOONGARCH_FLUSH_FTLB        (1 << 1)
#define  LOONGARCH_FLUSH_DTLB        (1 << 2)
#define  LOONGARCH_FLUSH_ITLB        (1 << 3)
#define  LOONGARCH_FLUSH_BTAC        (1 << 4)

#define LOONGARCH_CSR_GNMI           0x82

/* TLB Refill Only */
#define LOONGARCH_CSR_TLBRENT        0x88 /* 64 TLB refill exception address */
#define LOONGARCH_CSR_TLBRBADV       0x89 /* 64 TLB refill badvaddr */
#define LOONGARCH_CSR_TLBRERA        0x8a /* 64 TLB refill ERA */
#define LOONGARCH_CSR_TLBRSAVE       0x8b /* 64 KScratch for TLB refill */
#define LOONGARCH_CSR_TLBRELO0       0x8c /* 64 TLB refill entrylo0 */
#define LOONGARCH_CSR_TLBRELO1       0x8d /* 64 TLB refill entrylo1 */
#define LOONGARCH_CSR_TLBREHI        0x8e /* 64 TLB refill entryhi */
#define LOONGARCH_CSR_TLBRPRMD       0x8f /* 64 TLB refill mode info */

/* error related */
#define LOONGARCH_CSR_ERRCTL         0x90 /* 32 ERRCTL */
#define LOONGARCH_CSR_ERRINFO        0x91
#define LOONGARCH_CSR_ERRINFO1       0x92
#define LOONGARCH_CSR_ERRENT         0x93 /* 64 error exception base */
#define LOONGARCH_CSR_ERRERA         0x94 /* 64 error exception PC */
#define LOONGARCH_CSR_ERRSAVE        0x95 /* 64 KScratch for error exception */

#define LOONGARCH_CSR_CTAG           0x98 /* 64 TagLo + TagHi */

/* shadow MCSR : 0xc0 ~ 0xff */
#define LOONGARCH_CSR_MCSR0          0xc0 /* 64 cpucfg0 and 1 */
#define  MCSR0_INT_IMPL_SHIFT        58
#define  MCSR0_INT_IMPL              0
#define  MCSR0_IOCSR_BRD_SHIFT       57
#define  MCSR0_IOCSR_BRD             (1ULL << MCSR0_IOCSR_BRD_SHIFT)
#define  MCSR0_HUGEPG_SHIFT          56
#define  MCSR0_HUGEPG                (1ULL << MCSR0_HUGEPG_SHIFT)
#define  MCSR0_RPLVTLB_SHIFT         55
#define  MCSR0_RPLVTLB               (1ULL << MCSR0_RPLVTLB_SHIFT)
#define  MCSR0_EXEPROT_SHIFT         54
#define  MCSR0_EXEPROT               (1ULL << MCSR0_EXEPROT_SHIFT)
#define  MCSR0_RI_SHIFT              53
#define  MCSR0_RI                    (1ULL << MCSR0_RI_SHIFT)
#define  MCSR0_UAL_SHIFT             52
#define  MCSR0_UAL                   (1ULL << MCSR0_UAL_SHIFT)
#define  MCSR0_VABIT_SHIFT           44
#define  MCSR0_VABIT_WIDTH           8
#define  MCSR0_VABIT                 (0xffULL << MCSR0_VABIT_SHIFT)
#define  VABIT_DEFAULT               0x2f
#define  MCSR0_PABIT_SHIFT           36
#define  MCSR0_PABIT_WIDTH           8
#define  MCSR0_PABIT                 (0xffULL << MCSR0_PABIT_SHIFT)
#define  PABIT_DEFAULT               0x2f
#define  MCSR0_IOCSR_SHIFT           35
#define  MCSR0_IOCSR                 (1ULL << MCSR0_IOCSR_SHIFT)
#define  MCSR0_PAGING_SHIFT          34
#define  MCSR0_PAGING                (1ULL << MCSR0_PAGING_SHIFT)
#define  MCSR0_GR64_SHIFT            33
#define  MCSR0_GR64                  (1ULL << MCSR0_GR64_SHIFT)
#define  GR64_DEFAULT                1
#define  MCSR0_GR32_SHIFT            32
#define  MCSR0_GR32                  (1ULL << MCSR0_GR32_SHIFT)
#define  GR32_DEFAULT                0
#define  MCSR0_PRID_WIDTH            32
#define  MCSR0_PRID                  0x14C010

#define LOONGARCH_CSR_MCSR1          0xc1 /* 64 cpucfg2 and 3 */
#define  MCSR1_HPFOLD_SHIFT          43
#define  MCSR1_HPFOLD                (1ULL << MCSR1_HPFOLD_SHIFT)
#define  MCSR1_SPW_LVL_SHIFT         40
#define  MCSR1_SPW_LVL_WIDTH         3
#define  MCSR1_SPW_LVL               (7ULL << MCSR1_SPW_LVL_SHIFT)
#define  MCSR1_ICACHET_SHIFT         39
#define  MCSR1_ICACHET               (1ULL << MCSR1_ICACHET_SHIFT)
#define  MCSR1_ITLBT_SHIFT           38
#define  MCSR1_ITLBT                 (1ULL << MCSR1_ITLBT_SHIFT)
#define  MCSR1_LLDBAR_SHIFT          37
#define  MCSR1_LLDBAR                (1ULL << MCSR1_LLDBAR_SHIFT)
#define  MCSR1_SCDLY_SHIFT           36
#define  MCSR1_SCDLY                 (1ULL << MCSR1_SCDLY_SHIFT)
#define  MCSR1_LLEXC_SHIFT           35
#define  MCSR1_LLEXC                 (1ULL << MCSR1_LLEXC_SHIFT)
#define  MCSR1_UCACC_SHIFT           34
#define  MCSR1_UCACC                 (1ULL << MCSR1_UCACC_SHIFT)
#define  MCSR1_SFB_SHIFT             33
#define  MCSR1_SFB                   (1ULL << MCSR1_SFB_SHIFT)
#define  MCSR1_CCDMA_SHIFT           32
#define  MCSR1_CCDMA                 (1ULL << MCSR1_CCDMA_SHIFT)
#define  MCSR1_LAMO_SHIFT            22
#define  MCSR1_LAMO                  (1ULL << MCSR1_LAMO_SHIFT)
#define  MCSR1_LSPW_SHIFT            21
#define  MCSR1_LSPW                  (1ULL << MCSR1_LSPW_SHIFT)
#define  MCSR1_LOONGARCHBT_SHIFT     20
#define  MCSR1_LOONGARCHBT           (1ULL << MCSR1_LOONGARCHBT_SHIFT)
#define  MCSR1_ARMBT_SHIFT           19
#define  MCSR1_ARMBT                 (1ULL << MCSR1_ARMBT_SHIFT)
#define  MCSR1_X86BT_SHIFT           18
#define  MCSR1_X86BT                 (1ULL << MCSR1_X86BT_SHIFT)
#define  MCSR1_LLFTPVERS_SHIFT       15
#define  MCSR1_LLFTPVERS_WIDTH       3
#define  MCSR1_LLFTPVERS             (7ULL << MCSR1_LLFTPVERS_SHIFT)
#define  MCSR1_LLFTP_SHIFT           14
#define  MCSR1_LLFTP                 (1ULL << MCSR1_LLFTP_SHIFT)
#define  MCSR1_VZVERS_SHIFT          11
#define  MCSR1_VZVERS_WIDTH          3
#define  MCSR1_VZVERS                (7ULL << MCSR1_VZVERS_SHIFT)
#define  MCSR1_VZ_SHIFT              10
#define  MCSR1_VZ                    (1ULL << MCSR1_VZ_SHIFT)
#define  MCSR1_CRYPTO_SHIFT          9
#define  MCSR1_CRYPTO                (1ULL << MCSR1_CRYPTO_SHIFT)
#define  MCSR1_COMPLEX_SHIFT         8
#define  MCSR1_COMPLEX               (1ULL << MCSR1_COMPLEX_SHIFT)
#define  MCSR1_LASX_SHIFT            7
#define  MCSR1_LASX                  (1ULL << MCSR1_LASX_SHIFT)
#define  MCSR1_LSX_SHIFT             6
#define  MCSR1_LSX                   (1ULL << MCSR1_LSX_SHIFT)
#define  MCSR1_FPVERS_SHIFT          3
#define  MCSR1_FPVERS_WIDTH          3
#define  MCSR1_FPVERS                (7ULL << MCSR1_FPVERS_SHIFT)
#define  MCSR1_FPDP_SHIFT            2
#define  MCSR1_FPDP                  (1ULL << MCSR1_FPDP_SHIFT)
#define  MCSR1_FPSP_SHIFT            1
#define  MCSR1_FPSP                  (1ULL << MCSR1_FPSP_SHIFT)
#define  MCSR1_FP_SHIFT              0
#define  MCSR1_FP                    (1ULL << MCSR1_FP_SHIFT)

#define LOONGARCH_CSR_MCSR2          0xc2 /* 64 cpucfg4 and 5 */
#define  MCSR2_CCDIV_SHIFT           48
#define  MCSR2_CCDIV_WIDTH           16
#define  MCSR2_CCDIV                 (0xffffULL << MCSR2_CCDIV_SHIFT)
#define  MCSR2_CCMUL_SHIFT           32
#define  MCSR2_CCMUL_WIDTH           16
#define  MCSR2_CCMUL                 (0xffffULL << MCSR2_CCMUL_SHIFT)
#define  MCSR2_CCFREQ_WIDTH          32
#define  MCSR2_CCFREQ                (0xffffffff)
#define  CCFREQ_DEFAULT              0x5f5e100 /* 100MHZ */

#define LOONGARCH_CSR_MCSR3          0xc3 /* 64 cpucfg6 */
#define  MCSR3_UPM_SHIFT             14
#define  MCSR3_UPM                   (1ULL << MCSR3_UPM_SHIFT)
#define  MCSR3_PMBITS_SHIFT          8
#define  MCSR3_PMBITS_WIDTH          6
#define  MCSR3_PMBITS                (0x3fULL << MCSR3_PMBITS_SHIFT)
#define  PMBITS_DEFAULT              0x40
#define  MCSR3_PMNUM_SHIFT           4
#define  MCSR3_PMNUM_WIDTH           4
#define  MCSR3_PMNUM                 (0xfULL << MCSR3_PMNUM_SHIFT)
#define  MCSR3_PAMVER_SHIFT          1
#define  MCSR3_PAMVER_WIDTH          3
#define  MCSR3_PAMVER                (0x7ULL << MCSR3_PAMVER_SHIFT)
#define  MCSR3_PMP_SHIFT             0
#define  MCSR3_PMP                   (1ULL << MCSR3_PMP_SHIFT)

#define LOONGARCH_CSR_MCSR8          0xc8 /* 64 cpucfg16 and 17 */
#define  MCSR8_L1I_SIZE_SHIFT        56
#define  MCSR8_L1I_SIZE_WIDTH        7
#define  MCSR8_L1I_SIZE              (0x7fULL << MCSR8_L1I_SIZE_SHIFT)
#define  MCSR8_L1I_IDX_SHIFT         48
#define  MCSR8_L1I_IDX_WIDTH         8
#define  MCSR8_L1I_IDX               (0xffULL << MCSR8_L1I_IDX_SHIFT)
#define  MCSR8_L1I_WAY_SHIFT         32
#define  MCSR8_L1I_WAY_WIDTH         16
#define  MCSR8_L1I_WAY               (0xffffULL << MCSR8_L1I_WAY_SHIFT)
#define  MCSR8_L3DINCL_SHIFT         16
#define  MCSR8_L3DINCL               (1ULL << MCSR8_L3DINCL_SHIFT)
#define  MCSR8_L3DPRIV_SHIFT         15
#define  MCSR8_L3DPRIV               (1ULL << MCSR8_L3DPRIV_SHIFT)
#define  MCSR8_L3DPRE_SHIFT          14
#define  MCSR8_L3DPRE                (1ULL << MCSR8_L3DPRE_SHIFT)
#define  MCSR8_L3IUINCL_SHIFT        13
#define  MCSR8_L3IUINCL              (1ULL << MCSR8_L3IUINCL_SHIFT)
#define  MCSR8_L3IUPRIV_SHIFT        12
#define  MCSR8_L3IUPRIV              (1ULL << MCSR8_L3IUPRIV_SHIFT)
#define  MCSR8_L3IUUNIFY_SHIFT       11
#define  MCSR8_L3IUUNIFY             (1ULL << MCSR8_L3IUUNIFY_SHIFT)
#define  MCSR8_L3IUPRE_SHIFT         10
#define  MCSR8_L3IUPRE               (1ULL << MCSR8_L3IUPRE_SHIFT)
#define  MCSR8_L2DINCL_SHIFT         9
#define  MCSR8_L2DINCL               (1ULL << MCSR8_L2DINCL_SHIFT)
#define  MCSR8_L2DPRIV_SHIFT         8
#define  MCSR8_L2DPRIV               (1ULL << MCSR8_L2DPRIV_SHIFT)
#define  MCSR8_L2DPRE_SHIFT          7
#define  MCSR8_L2DPRE                (1ULL << MCSR8_L2DPRE_SHIFT)
#define  MCSR8_L2IUINCL_SHIFT        6
#define  MCSR8_L2IUINCL              (1ULL << MCSR8_L2IUINCL_SHIFT)
#define  MCSR8_L2IUPRIV_SHIFT        5
#define  MCSR8_L2IUPRIV              (1ULL << MCSR8_L2IUPRIV_SHIFT)
#define  MCSR8_L2IUUNIFY_SHIFT       4
#define  MCSR8_L2IUUNIFY             (1ULL << MCSR8_L2IUUNIFY_SHIFT)
#define  MCSR8_L2IUPRE_SHIFT         3
#define  MCSR8_L2IUPRE               (1ULL << MCSR8_L2IUPRE_SHIFT)
#define  MCSR8_L1DPRE_SHIFT          2
#define  MCSR8_L1DPRE                (1ULL << MCSR8_L1DPRE_SHIFT)
#define  MCSR8_L1IUUNIFY_SHIFT       1
#define  MCSR8_L1IUUNIFY             (1ULL << MCSR8_L1IUUNIFY_SHIFT)
#define  MCSR8_L1IUPRE_SHIFT         0
#define  MCSR8_L1IUPRE               (1ULL << MCSR8_L1IUPRE_SHIFT)

#define LOONGARCH_CSR_MCSR9          0xc9 /* 64 cpucfg18 and 19 */
#define  MCSR9_L2U_SIZE_SHIFT        56
#define  MCSR9_L2U_SIZE_WIDTH        7
#define  MCSR9_L2U_SIZE              (0x7fULL << MCSR9_L2U_SIZE_SHIFT)
#define  MCSR9_L2U_IDX_SHIFT         48
#define  MCSR9_L2U_IDX_WIDTH         8
#define  MCSR9_L2U_IDX               (0xffULL << MCSR9_IDX_LOG_SHIFT)
#define  MCSR9_L2U_WAY_SHIFT         32
#define  MCSR9_L2U_WAY_WIDTH         16
#define  MCSR9_L2U_WAY               (0xffffULL << MCSR9_L2U_WAY_SHIFT)
#define  MCSR9_L1D_SIZE_SHIFT        24
#define  MCSR9_L1D_SIZE_WIDTH        7
#define  MCSR9_L1D_SIZE              (0x7fULL << MCSR9_L1D_SIZE_SHIFT)
#define  MCSR9_L1D_IDX_SHIFT         16
#define  MCSR9_L1D_IDX_WIDTH         8
#define  MCSR9_L1D_IDX               (0xffULL << MCSR9_L1D_IDX_SHIFT)
#define  MCSR9_L1D_WAY_SHIFT         0
#define  MCSR9_L1D_WAY_WIDTH         16
#define  MCSR9_L1D_WAY               (0xffffULL << MCSR9_L1D_WAY_SHIFT)

#define LOONGARCH_CSR_MCSR10         0xca /* 64 cpucfg20 */
#define  MCSR10_L3U_SIZE_SHIFT       24
#define  MCSR10_L3U_SIZE_WIDTH       7
#define  MCSR10_L3U_SIZE             (0x7fULL << MCSR10_L3U_SIZE_SHIFT)
#define  MCSR10_L3U_IDX_SHIFT        16
#define  MCSR10_L3U_IDX_WIDTH        8
#define  MCSR10_L3U_IDX              (0xffULL << MCSR10_L3U_IDX_SHIFT)
#define  MCSR10_L3U_WAY_SHIFT        0
#define  MCSR10_L3U_WAY_WIDTH        16
#define  MCSR10_L3U_WAY              (0xffffULL << MCSR10_L3U_WAY_SHIFT)

#define LOONGARCH_CSR_MCSR24         0xf0 /* 64 cpucfg48 */
#define  MCSR24_RAMCG_SHIFT          3
#define  MCSR24_RAMCG                (1ULL << MCSR24_RAMCG_SHIFT)
#define  MCSR24_VFPUCG_SHIFT         2
#define  MCSR24_VFPUCG               (1ULL << MCSR24_VFPUCG_SHIFT)
#define  MCSR24_NAPEN_SHIFT          1
#define  MCSR24_NAPEN                (1ULL << MCSR24_NAPEN_SHIFT)
#define  MCSR24_MCSRLOCK_SHIFT       0
#define  MCSR24_MCSRLOCK             (1ULL << MCSR24_MCSRLOCK_SHIFT)

/* uncached accelerate windows */
#define LOONGARCH_CSR_UCAWIN         0x100 /* read only info */
#define LOONGARCH_CSR_UCAWIN0_LO     0x102 /* win0 low */
#define LOONGARCH_CSR_UCAWIN0_HI     0x103 /* win0 high */
#define LOONGARCH_CSR_UCAWIN1_LO     0x104 /* win1 low */
#define LOONGARCH_CSR_UCAWIN1_HI     0x105 /* win1 high */
#define LOONGARCH_CSR_UCAWIN2_LO     0x106 /* win2 low */
#define LOONGARCH_CSR_UCAWIN2_HI     0x107 /* win2 high */
#define LOONGARCH_CSR_UCAWIN3_LO     0x108 /* win3 low */
#define LOONGARCH_CSR_UCAWIN3_HI     0x109 /* win3 high */

/* direct map windows */
#define LOONGARCH_CSR_DMWIN0         0x180 /* 64 direct map win0: MEM & IF */
#define LOONGARCH_CSR_DMWIN1         0x181 /* 64 direct map win1: MEM & IF */
#define LOONGARCH_CSR_DMWIN2         0x182 /* 64 direct map win2: MEM */
#define LOONGARCH_CSR_DMWIN3         0x183 /* 64 direct map win3: MEM */
#define  CSR_DMW_PLV0                0x1
#define  CSR_DMW_PLV1                0x2
#define  CSR_DMW_PLV2                0x4
#define  CSR_DMW_PLV3                0x8
#define  CSR_DMW_BASE_SH             48
#define dmwin_va2pa(va) \
    (va & (((unsigned long)1 << CSR_DMW_BASE_SH) - 1))

#define  CSR_DMW32_BASE_SH           29
#define dmwin32_va2pa(va, winval)                                       \
        ((va & ((1UL << CSR_DMW32_BASE_SH) - 1)) | ((winval & 0x0e000000) << 4))

/* performance counter */
#define LOONGARCH_CSR_PERFCTRL0      0x200 /* 32 perf event 0 config */
#define LOONGARCH_CSR_PERFCNTR0      0x201 /* 64 perf event 0 count value */
#define LOONGARCH_CSR_PERFCTRL1      0x202 /* 32 perf event 1 config */
#define LOONGARCH_CSR_PERFCNTR1      0x203 /* 64 perf event 1 count value */
#define LOONGARCH_CSR_PERFCTRL2      0x204 /* 32 perf event 2 config */
#define LOONGARCH_CSR_PERFCNTR2      0x205 /* 64 perf event 2 count value */
#define LOONGARCH_CSR_PERFCTRL3      0x206 /* 32 perf event 3 config */
#define LOONGARCH_CSR_PERFCNTR3      0x207 /* 64 perf event 3 count value */
#define  CSR_PERFCTRL_PLV0           (1ULL << 16)
#define  CSR_PERFCTRL_PLV1           (1ULL << 17)
#define  CSR_PERFCTRL_PLV2           (1ULL << 18)
#define  CSR_PERFCTRL_PLV3           (1ULL << 19)
#define  CSR_PERFCTRL_IE             (1ULL << 20)
#define  CSR_PERFCTRL_EVENT          0x3ff

/* debug */
#define LOONGARCH_CSR_MWPC           0x300 /* data breakpoint config */
#define LOONGARCH_CSR_MWPS           0x301 /* data breakpoint status */

#define LOONGARCH_CSR_DB0ADDR        0x310 /* data breakpoint 0 address */
#define LOONGARCH_CSR_DB0MASK        0x311 /* data breakpoint 0 mask */
#define LOONGARCH_CSR_DB0CTL         0x312 /* data breakpoint 0 control */
#define LOONGARCH_CSR_DB0ASID        0x313 /* data breakpoint 0 asid */

#define LOONGARCH_CSR_DB1ADDR        0x318 /* data breakpoint 1 address */
#define LOONGARCH_CSR_DB1MASK        0x319 /* data breakpoint 1 mask */
#define LOONGARCH_CSR_DB1CTL         0x31a /* data breakpoint 1 control */
#define LOONGARCH_CSR_DB1ASID        0x31b /* data breakpoint 1 asid */

#define LOONGARCH_CSR_DB2ADDR        0x320 /* data breakpoint 2 address */
#define LOONGARCH_CSR_DB2MASK        0x321 /* data breakpoint 2 mask */
#define LOONGARCH_CSR_DB2CTL         0x322 /* data breakpoint 2 control */
#define LOONGARCH_CSR_DB2ASID        0x323 /* data breakpoint 2 asid */

#define LOONGARCH_CSR_DB3ADDR        0x328 /* data breakpoint 3 address */
#define LOONGARCH_CSR_DB3MASK        0x329 /* data breakpoint 3 mask */
#define LOONGARCH_CSR_DB3CTL         0x32a /* data breakpoint 3 control */
#define LOONGARCH_CSR_DB3ASID        0x32b /* data breakpoint 3 asid */

#define LOONGARCH_CSR_FWPC           0x380 /* instruction breakpoint config */
#define LOONGARCH_CSR_FWPS           0x381 /* instruction breakpoint status */

#define LOONGARCH_CSR_IB0ADDR        0x390 /* inst breakpoint 0 address */
#define LOONGARCH_CSR_IB0MASK        0x391 /* inst breakpoint 0 mask */
#define LOONGARCH_CSR_IB0CTL         0x392 /* inst breakpoint 0 control */
#define LOONGARCH_CSR_IB0ASID        0x393 /* inst breakpoint 0 asid */
#define LOONGARCH_CSR_IB1ADDR        0x398 /* inst breakpoint 1 address */
#define LOONGARCH_CSR_IB1MASK        0x399 /* inst breakpoint 1 mask */
#define LOONGARCH_CSR_IB1CTL         0x39a /* inst breakpoint 1 control */
#define LOONGARCH_CSR_IB1ASID        0x39b /* inst breakpoint 1 asid */

#define LOONGARCH_CSR_IB2ADDR        0x3a0 /* inst breakpoint 2 address */
#define LOONGARCH_CSR_IB2MASK        0x3a1 /* inst breakpoint 2 mask */
#define LOONGARCH_CSR_IB2CTL         0x3a2 /* inst breakpoint 2 control */
#define LOONGARCH_CSR_IB2ASID        0x3a3 /* inst breakpoint 2 asid */

#define LOONGARCH_CSR_IB3ADDR        0x3a8 /* inst breakpoint 3 address */
#define LOONGARCH_CSR_IB3MASK        0x3a9 /* inst breakpoint 3 mask */
#define LOONGARCH_CSR_IB3CTL         0x3aa /* inst breakpoint 3 control */
#define LOONGARCH_CSR_IB3ASID        0x3ab /* inst breakpoint 3 asid */

#define LOONGARCH_CSR_IB4ADDR        0x3b0 /* inst breakpoint 4 address */
#define LOONGARCH_CSR_IB4MASK        0x3b1 /* inst breakpoint 4 mask */
#define LOONGARCH_CSR_IB4CTL         0x3b2 /* inst breakpoint 4 control */
#define LOONGARCH_CSR_IB4ASID        0x3b3 /* inst breakpoint 4 asid */

#define LOONGARCH_CSR_IB5ADDR        0x3b8 /* inst breakpoint 5 address */
#define LOONGARCH_CSR_IB5MASK        0x3b9 /* inst breakpoint 5 mask */
#define LOONGARCH_CSR_IB5CTL         0x3ba /* inst breakpoint 5 control */
#define LOONGARCH_CSR_IB5ASID        0x3bb /* inst breakpoint 5 asid */

#define LOONGARCH_CSR_IB6ADDR        0x3c0 /* inst breakpoint 6 address */
#define LOONGARCH_CSR_IB6MASK        0x3c1 /* inst breakpoint 6 mask */
#define LOONGARCH_CSR_IB6CTL         0x3c2 /* inst breakpoint 6 control */
#define LOONGARCH_CSR_IB6ASID        0x3c3 /* inst breakpoint 6 asid */

#define LOONGARCH_CSR_IB7ADDR        0x3c8 /* inst breakpoint 7 address */
#define LOONGARCH_CSR_IB7MASK        0x3c9 /* inst breakpoint 7 mask */
#define LOONGARCH_CSR_IB7CTL         0x3ca /* inst breakpoint 7 control */
#define LOONGARCH_CSR_IB7ASID        0x3cb /* inst breakpoint 7 asid */

#define LOONGARCH_CSR_DEBUG          0x500 /* debug config */
#define  CSR_DEBUG_DM                0
#define  CSR_DEBUG_DMVER             1
#define  CSR_DEBUG_DINT              8
#define  CSR_DEBUG_DBP               9
#define  CSR_DEBUG_DIB               10
#define  CSR_DEBUG_DDB               11

#define LOONGARCH_CSR_DERA           0x501 /* debug era */
#define LOONGARCH_CSR_DESAVE         0x502 /* debug save */

#define LOONGARCH_CSR_PRID           0xc0 /* 32 LOONGARCH CP0 PRID */

#define LOONGARCH_CPUCFG0       0x0
#define CPUCFG0_3A5000_PRID     0x0014c010

#define LOONGARCH_CPUCFG1       0x1
#define  CPUCFG1_ISGR32         BIT(0)
#define  CPUCFG1_ISGR64         BIT(1)
#define  CPUCFG1_PAGING         BIT(2)
#define  CPUCFG1_IOCSR          BIT(3)
#define  CPUCFG1_PABITS         (47 << 4)
#define  CPUCFG1_VABITS         (47 << 12)
#define  CPUCFG1_UAL            BIT(20)
#define  CPUCFG1_RI             BIT(21)
#define  CPUCFG1_XI             BIT(22)
#define  CPUCFG1_RPLV           BIT(23)
#define  CPUCFG1_HUGEPG         BIT(24)
#define  CPUCFG1_IOCSRBRD       BIT(25)
#define  CPUCFG1_MSGINT         BIT(26)

#define LOONGARCH_CPUCFG2       0x2
#define  CPUCFG2_FP             BIT(0)
#define  CPUCFG2_FPSP           BIT(1)
#define  CPUCFG2_FPDP           BIT(2)
#define  CPUCFG2_FPVERS         (0 << 3)
#define  CPUCFG2_LSX            BIT(6)
#define  CPUCFG2_LASX           BIT(7)
#define  CPUCFG2_COMPLEX        BIT(8)
#define  CPUCFG2_CRYPTO         BIT(9)
#define  CPUCFG2_LVZP           BIT(10)
#define  CPUCFG2_LVZVER         (0 << 11)
#define  CPUCFG2_LLFTP          BIT(14)
#define  CPUCFG2_LLFTPREV       (1 << 15)
#define  CPUCFG2_X86BT          BIT(18)
#define  CPUCFG2_ARMBT          BIT(19)
#define  CPUCFG2_MIPSBT         BIT(20)
#define  CPUCFG2_LSPW           BIT(21)
#define  CPUCFG2_LAM            BIT(22)

#define LOONGARCH_CPUCFG3       0x3
#define  CPUCFG3_CCDMA          BIT(0)
#define  CPUCFG3_SFB            BIT(1)
#define  CPUCFG3_UCACC          BIT(2)
#define  CPUCFG3_LLEXC          BIT(3)
#define  CPUCFG3_SCDLY          BIT(4)
#define  CPUCFG3_LLDBAR         BIT(5)
#define  CPUCFG3_ITLBT          BIT(6)
#define  CPUCFG3_ICACHET        BIT(7)
#define  CPUCFG3_SPW_LVL        (4 << 8)
#define  CPUCFG3_SPW_HG_HF      BIT(11)
#define  CPUCFG3_RVA            BIT(12)
#define  CPUCFG3_RVAMAX         (7 << 13)

#define LOONGARCH_CPUCFG4       0x4
#define  CCFREQ_100M            100000000   /* 100M */

#define LOONGARCH_CPUCFG5       0x5
#define  CPUCFG5_CCMUL          1
#define  CPUCFG5_CCDIV          (1 << 16)

#define LOONGARCH_CPUCFG6       0x6
#define  CPUCFG6_PMP            BIT(0)
#define  CPUCFG6_PAMVER         (1 << 1)
#define  CPUCFG6_PMNUM          (3 << 4)
#define  CPUCFG6_PMBITS         (63 << 8)
#define  CPUCFG6_UPM            BIT(14)

#define LOONGARCH_CPUCFG16      0x10
#define  CPUCFG16_L1_IUPRE      BIT(0)
#define  CPUCFG16_L1_UNIFY      BIT(1)
#define  CPUCFG16_L1_DPRE       BIT(2)
#define  CPUCFG16_L2_IUPRE      BIT(3)
#define  CPUCFG16_L2_IUUNIFY    BIT(4)
#define  CPUCFG16_L2_IUPRIV     BIT(5)
#define  CPUCFG16_L2_IUINCL     BIT(6)
#define  CPUCFG16_L2_DPRE       BIT(7)
#define  CPUCFG16_L2_DPRIV      BIT(8)
#define  CPUCFG16_L2_DINCL      BIT(9)
#define  CPUCFG16_L3_IUPRE      BIT(10)
#define  CPUCFG16_L3_IUUNIFY    BIT(11)
#define  CPUCFG16_L3_IUPRIV     BIT(12)
#define  CPUCFG16_L3_IUINCL     BIT(13)
#define  CPUCFG16_L3_DPRE       BIT(14)
#define  CPUCFG16_L3_DPRIV      BIT(15)
#define  CPUCFG16_L3_DINCL      BIT(16)

#define LOONGARCH_CPUCFG17      0x11
#define  CPUCFG17_L1I_WAYS_M    (3 << 0)
#define  CPUCFG17_L1I_SETS_M    (8 << 16)
#define  CPUCFG17_L1I_SIZE_M    (6 << 24)

#define LOONGARCH_CPUCFG18      0x12
#define  CPUCFG18_L1D_WAYS_M    (3 << 0)
#define  CPUCFG18_L1D_SETS_M    (8 << 16)
#define  CPUCFG18_L1D_SIZE_M    (6 << 24)

#define LOONGARCH_CPUCFG19      0x13
#define  CPUCFG19_L2_WAYS_M     (0xf << 0)
#define  CPUCFG19_L2_SETS_M     (8 << 16)
#define  CPUCFG19_L2_SIZE_M     (6 << 24)

#define LOONGARCH_CPUCFG20      0x14
#define  CPUCFG20_L3_WAYS_M     (0xf << 0)
#define  CPUCFG20_L3_SETS_M     (0xe << 16)
#define  CPUCFG20_L3_SIZE_M     (0x6 << 24)

#define LOONGARCH_CPUCFG48      0x30
#define  CPUCFG48_MCSR_LCK      BIT(0)
#define  CPUCFG48_NAP_EN        BIT(1)
#define  CPUCFG48_VFPU_CG       BIT(2)
#define  CPUCFG48_RAM_CG        BIT(3)

#define LOONGARCH_PAGE_HUGE  0x40
#define LOONGARCH_HUGE_GLOBAL    0x1000
#define LOONGARCH_HUGE_GLOBAL_SH 12

#define LOONGARCH_PAGE_PRESENT 0x80
#define LOONGARCH_PAGE_VALID 0x1
#define LOONGARCH_PAGE_WRITE 0x100
#define LOONGARCH_PAGE_DIRTY 0x2

// TODO: uint64_t CSR_MCSR16;

#if 0
#define CPU_LOONGARCH_CSR    \
    uint64_t CSR_CRMD;       \
    uint64_t CSR_PRMD;       \
    uint64_t CSR_EUEN;       \
    uint64_t CSR_MISC;       \
    uint64_t CSR_ECFG;       \
    uint64_t CSR_ESTAT;      \
    uint64_t CSR_ERA;        \
    uint64_t CSR_BADV;       \
    uint64_t CSR_BADI;       \
    uint64_t CSR_EENTRY;     \
    uint64_t CSR_TLBIDX;     \
    uint64_t CSR_TLBEHI;     \
    uint64_t CSR_TLBELO0;    \
    uint64_t CSR_TLBELO1;    \
    uint64_t CSR_ASID;       \
    uint64_t CSR_PGDL;       \
    uint64_t CSR_PGDH;       \
    uint64_t CSR_PGD;        \
    uint64_t CSR_PWCL;       \
    uint64_t CSR_PWCH;       \
    uint64_t CSR_STLBPS;     \
    uint64_t CSR_RVACFG;     \
    uint64_t CSR_CPUID;      \
    uint64_t CSR_PRCFG1;     \
    uint64_t CSR_PRCFG2;     \
    uint64_t CSR_PRCFG3;     \
    uint64_t CSR_SAVE[4];   \
    uint64_t CSR_TID;        \
    uint64_t CSR_TCFG;       \
    uint64_t CSR_TVAL;       \
    uint64_t CSR_CNTC;       \
    uint64_t CSR_TICLR;      \
    uint64_t CSR_LLBCTL;     \
    uint64_t CSR_IMPCTL1;    \
    uint64_t CSR_IMPCTL2;    \
    uint64_t CSR_TLBRENTRY;  \
    uint64_t CSR_TLBRBADV;   \
    uint64_t CSR_TLBRERA;    \
    uint64_t CSR_TLBRSAVE;   \
    uint64_t CSR_TLBRELO0;   \
    uint64_t CSR_TLBRELO1;   \
    uint64_t CSR_TLBREHI;    \
    uint64_t CSR_TLBRPRMD;   \
    uint64_t CSR_MERRCTL;    \
    uint64_t CSR_MERRINFO1;  \
    uint64_t CSR_MERRINFO2;  \
    uint64_t CSR_MERRENTRY;  \
    uint64_t CSR_MERRERA;    \
    uint64_t CSR_MERRSAVE;   \
    uint64_t CSR_CTAG;       \
    uint64_t CSR_DMW[4];     \
    uint64_t CSR_DBG;        \
    uint64_t CSR_DERA;       \
    uint64_t CSR_DSAVE;      \
                             
#endif

#define CPU_LOONGARCH_CSR    \
    uint64_t CSR_CRMD;       \
    uint64_t CSR_PRMD;       \
    uint64_t CSR_EUEN;       \
    uint64_t CSR_MISC;       \
    uint64_t CSR_ECFG;       \
    uint64_t CSR_ESTAT;      \
    uint64_t CSR_ERA;        \
    uint64_t CSR_BADV;       \
    uint64_t CSR_BADI;       \
    uint64_t CSR_EENTRY;     \
    uint64_t CSR_TLBIDX;     \
    uint64_t CSR_TLBEHI;     \
    uint64_t CSR_TLBELO0;    \
    uint64_t CSR_TLBELO1;    \
    uint64_t CSR_ASID;       \
    uint64_t CSR_PGDL;       \
    uint64_t CSR_PGDH;       \
    uint64_t CSR_PGD;        \
    uint64_t CSR_PWCL;       \
    uint64_t CSR_PWCH;       \
    uint64_t CSR_STLBPS;     \
    uint64_t CSR_RVACFG;     \
    uint64_t CSR_CPUID;      \
    uint64_t CSR_PRCFG1;     \
    uint64_t CSR_PRCFG2;     \
    uint64_t CSR_PRCFG3;     \
    uint64_t CSR_SAVE[4];   \
    uint64_t CSR_TID;        \
    uint64_t CSR_TCFG;       \
    uint64_t CSR_TVAL;       \
    uint64_t CSR_CNTC;       \
    uint64_t CSR_TICLR;      \
    uint64_t CSR_LLBCTL;     \
    uint64_t CSR_TLBRENTRY;  \
    uint64_t CSR_TLBREHI;    \
    uint64_t CSR_MERRENTRY;  \
    uint64_t CSR_DMW[4];     \



#define LASX_REG_WIDTH (256)
struct lafpr_t {
    int64_t val64[LASX_REG_WIDTH / 64];
};
typedef struct lafpr_t lafpr_t;

/// here should set packed attribute for strcut.
/// if we use fread restore struct, don't generate padding zero.
struct __attribute__((__packed__)) LOONGARCH_RTL_STATE {
    uint64_t gpr[32];
    uint64_t PC;

#if 0
    uint64_t scr[4];
#endif

    lafpr_t fpr[32];
    uint8_t cf[8];
    uint32_t fcsr0;

    CPU_LOONGARCH_CSR;
};

typedef struct LOONGARCH_RTL_STATE LOONGARCH_RTL_STATE;

static void loongarch_rtl_state_dump(LOONGARCH_RTL_STATE *ls, FILE *f)
{
    int i;
    fprintf(f, "PC  000 0x%lx\n", ls->PC);
    for (i = 0; i < 32; i++) {
        fprintf(f, "GPR %03x 0x%016lx\n", i, ls->gpr[i]);
    }

#if 0
    fprintf(f, "FCSR 0 %08x\n", ls->fcsr0);

    for (i = 0; i < 4; i++) {
        fprintf(f, "SCR %03x 0x%016lx\n", i, ls->scr[i]);
    }
#endif

    for (i = 0; i < 8; i++) {
        fprintf(f, "FCC %x %x\n", i, ls->cf[i]);
    }
    for (i = 0; i < 32; i++) {
        fprintf(f, "FPR %03x 0x%016lx\n", i, ls->fpr[i].val64[0]);
    }

    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_CRMD, ls->CSR_CRMD, "CSR_CRMD");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PRMD, ls->CSR_PRMD, "CSR_PRMD");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_EUEN, ls->CSR_EUEN, "CSR_EUEN");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_MISC, ls->CSR_MISC, "CSR_MISC");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ECFG, ls->CSR_ECFG, "CSR_ECFG");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ESTAT, ls->CSR_ESTAT, "CSR_ESTAT");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERA, ls->CSR_ERA, "CSR_ERA");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_BADV, ls->CSR_BADV, "CSR_BADV");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_BADI, ls->CSR_BADI, "CSR_BADI");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_EEPN, ls->CSR_EENTRY, "CSR_EEPN");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBIDX, ls->CSR_TLBIDX, "CSR_TLBIDX");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBEHI, ls->CSR_TLBEHI, "CSR_TLBEHI");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBELO0, ls->CSR_TLBELO0, "CSR_TLBELO0");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBELO1, ls->CSR_TLBELO1, "CSR_TLBELO1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ASID, ls->CSR_ASID, "CSR_ASID");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PGDL, ls->CSR_PGDL, "CSR_PGDL");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PGDH, ls->CSR_PGDH, "CSR_PGDH");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PGD, ls->CSR_PGD, "CSR_PGD");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PWCTL0, ls->CSR_PWCL, "CSR_PWCTL0");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PWCTL1, ls->CSR_PWCH, "CSR_PWCTL1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_STLBPGSIZE, ls->CSR_STLBPS, "CSR_STLBPGSIZE");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_RVACFG, ls->CSR_RVACFG, "CSR_RVACFG");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_CPUID, ls->CSR_CPUID, "CSR_CPUID");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PRCFG1, ls->CSR_PRCFG1, "CSR_PRCFG1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PRCFG2, ls->CSR_PRCFG2, "CSR_PRCFG2");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_PRCFG3, ls->CSR_PRCFG3, "CSR_PRCFG3");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[0], "CSR_KS0");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[1], "CSR_KS1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[2], "CSR_KS2");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[3], "CSR_KS3");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[4], "CSR_KS4");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[5], "CSR_KS5");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[6], "CSR_KS6");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_KS0, ls->CSR_SAVE[7], "CSR_KS7");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TMID, ls->CSR_TID, "CSR_TID");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TCFG, ls->CSR_TCFG, "CSR_TCFG");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TVAL, ls->CSR_TVAL, "CSR_TVAL");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_CNTC, ls->CSR_CNTC, "CSR_CNTC");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TINTCLR, ls->CSR_TICLR, "CSR_TICLR");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_LLBCTL, ls->CSR_LLBCTL, "CSR_LLBCTL");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_IMPCTL1, ls->CSR_IMPCTL1, "CSR_IMPCTL1");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_IMPCTL2, ls->CSR_IMPCTL2, "CSR_IMPCTL2");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBRBADV, ls->CSR_TLBRBADV, "CSR_TLBRBADV");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBRERA, ls->CSR_TLBRERA, "CSR_TLBRERA");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBRSAVE, ls->CSR_TLBRSAVE, "CSR_TLBRSAVE");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBRELO0, ls->CSR_TLBRELO0, "CSR_TLBRELO0");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBRELO1, ls->CSR_TLBRELO1, "CSR_TLBRELO1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBREHI, ls->CSR_TLBREHI, "CSR_TLBREHI");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_TLBRPRMD, ls->CSR_TLBRPRMD, "CSR_TLBRPRMD");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERRCTL, ls->CSR_MERRCTL, "CSR_MERRCTL");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERRINFO, ls->CSR_MERRINFO1, "CSR_ERRINFO");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERRINFO1, ls->CSR_MERRINFO1, "CSR_ERRINFO1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERRENT, ls->CSR_MERRENTRY, "CSR_ERRENT");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERRERA, ls->CSR_MERRERA, "CSR_ERRERA");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_ERRSAVE, ls->CSR_MERRSAVE, "CSR_ERRSAVE");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_CTAG, ls->CSR_CTAG, "CSR_CTAG");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_DMWIN0, ls->CSR_DMW[0], "CSR_DMWIN0");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_DMWIN1, ls->CSR_DMW[1], "CSR_DMWIN1");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_DMWIN2, ls->CSR_DMW[2], "CSR_DMWIN2");
    fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_DMWIN3, ls->CSR_DMW[3], "CSR_DMWIN3");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_DERA, ls->CSR_DERA, "CSR_DERA");
    // fprintf(f, "CSR %03x 0x%016lx %s\n", LOONGARCH_CSR_DESAVE, ls->CSR_DSAVE, "CSR_DSAVE");
}

#ifdef __cplusplus

static void chkpt_csr_restore_one(RAM*ram,uint64_t* offset,int target,uint64_t content){
    ram->write32(0x1c000000 + *offset + 0 * 4, 0x14000000 | ((content >> 12) & 0xfffff) <<  5 | 2         ); // lu12i.w $r2,pc
    ram->write32(0x1c000000 + *offset + 1 * 4, 0x03800000 | ((content >>  0) &   0xfff) << 10 | 2 | 2 << 5); // ori     $r2,$r2,pc
    ram->write32(0x1c000000 + *offset + 2 * 4, 0x16000000 | ((content >> 32) & 0xfffff) <<  5 | 2         ); // lu32i.d $r2,pc
    ram->write32(0x1c000000 + *offset + 3 * 4, 0x03000000 | ((content >> 52) &   0xfff) << 10 | 2 | 2 << 5); // lu52i.d $r2,$r2,pc
    ram->write32(0x1c000000 + *offset + 4 * 4, 0x04000020 | (target << 10) | 2); // csrwr $r2,0x1000
    *offset += 4*5;
}

static void chkpt_csr_restore(RAM*ram,uint64_t* offset,LOONGARCH_RTL_STATE*ls){
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_CRMD, ls->CSR_CRMD);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PRMD, ls->CSR_PRMD);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_EUEN, ls->CSR_EUEN);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_MISC, ls->CSR_MISC);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ECFG, ls->CSR_ECFG);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ESTAT, ls->CSR_ESTAT);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERA, ls->CSR_ERA);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_BADV, ls->CSR_BADV);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_BADI, ls->CSR_BADI);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_EEPN, ls->CSR_EENTRY);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBIDX, ls->CSR_TLBIDX);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBEHI, ls->CSR_TLBEHI);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBELO0, ls->CSR_TLBELO0);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBELO1, ls->CSR_TLBELO1);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ASID, ls->CSR_ASID);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PGDL, ls->CSR_PGDL);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PGDH, ls->CSR_PGDH);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PGD, ls->CSR_PGD);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PWCTL0, ls->CSR_PWCL);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PWCTL1, ls->CSR_PWCH);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_STLBPGSIZE, ls->CSR_STLBPS);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_RVACFG, ls->CSR_RVACFG);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_CPUID, ls->CSR_CPUID);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PRCFG1, ls->CSR_PRCFG1);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PRCFG2, ls->CSR_PRCFG2);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_PRCFG3, ls->CSR_PRCFG3);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS0, ls->CSR_SAVE[0]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS1, ls->CSR_SAVE[1]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS2, ls->CSR_SAVE[2]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS3, ls->CSR_SAVE[3]);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS4, ls->CSR_SAVE[4]);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS5, ls->CSR_SAVE[5]);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS6, ls->CSR_SAVE[6]);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_KS7, ls->CSR_SAVE[7]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TMID, ls->CSR_TID);

    /// We first set TVAL, CNTC. later set TCFG
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TVAL, ls->CSR_TVAL);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_CNTC, ls->CSR_CNTC);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TCFG, ls->CSR_TCFG);
    /// only restore tcfg
    chkpt_csr_restore_one(ram,offset, 0x134, ls->CSR_TCFG);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TINTCLR, ls->CSR_TICLR);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_LLBCTL, ls->CSR_LLBCTL);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_IMPCTL1, ls->CSR_IMPCTL1);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_IMPCTL2, ls->CSR_IMPCTL2);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRENT, ls->CSR_TLBRENTRY);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRBADV, ls->CSR_TLBRBADV);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRERA, ls->CSR_TLBRERA);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRSAVE, ls->CSR_TLBRSAVE);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRELO0, ls->CSR_TLBRELO0);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRELO1, ls->CSR_TLBRELO1);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBREHI, ls->CSR_TLBREHI);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_TLBRPRMD, ls->CSR_TLBRPRMD);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERRCTL, ls->CSR_MERRCTL);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERRINFO, ls->CSR_MERRINFO1);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERRINFO1, ls->CSR_MERRINFO2);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERRENT, ls->CSR_MERRENTRY);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERRERA, ls->CSR_MERRERA);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_ERRSAVE, ls->CSR_MERRSAVE);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_CTAG, ls->CSR_CTAG);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DMWIN0, ls->CSR_DMW[0]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DMWIN1, ls->CSR_DMW[1]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DMWIN2, ls->CSR_DMW[2]);
    chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DMWIN3, ls->CSR_DMW[3]);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DEBUG, ls->CSR_DBG);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DERA, ls->CSR_DERA);
    // chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_DESAVE, ls->CSR_DSAVE);
}

static void chkpt_csr_crmd_restore(RAM*ram,uint64_t* offset,LOONGARCH_RTL_STATE*ls){
	chkpt_csr_restore_one(ram,offset, LOONGARCH_CSR_CRMD, ls->CSR_CRMD);
}

#endif

#ifdef __cplusplus
}
#endif

#endif //__LOONGARCH_STATE_H
