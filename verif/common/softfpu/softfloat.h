#ifndef _SIM_SOFTFLOAT_H
#define _SIM_SOFTFLOAT_H

#include<cstdint>

// catagory
#define SOFTFLOAT_FARITH  8
#define SOFTFLOAT_FCMP    9
#define SOFTFLOAT_FCVT   10

// rounding mode
#define SOFTFLOAT_RM_RNE 0
#define SOFTFLOAT_RM_RZ  1
#define SOFTFLOAT_RM_RP  2
#define SOFTFLOAT_RM_RN  3

// float exception
#define SOFTFLOAT_EX_I 0
#define SOFTFLOAT_EX_U 1
#define SOFTFLOAT_EX_O 2
#define SOFTFLOAT_EX_Z 3
#define SOFTFLOAT_EX_V 4

// float comparison condition
#define SOFTFLOAT_CMP_AF  0x0
#define SOFTFLOAT_CMP_LT  0x1
#define SOFTFLOAT_CMP_EQ  0x2
#define SOFTFLOAT_CMP_LE  0x3
#define SOFTFLOAT_CMP_UN  0x4
#define SOFTFLOAT_CMP_ULT 0x5
#define SOFTFLOAT_CMP_UEQ 0x6
#define SOFTFLOAT_CMP_ULE 0x7
#define SOFTFLOAT_CMP_NE  0x8
#define SOFTFLOAT_CMP_OR  0xa
#define SOFTFLOAT_CMP_UNE 0xc

// float convertion
#define SOFTFLOAT_CVT_FCVT  0
#define SOFTFLOAT_CVT_FFINT 1
#define SOFTFLOAT_CVT_FTINT 2
#define SOFTFLOAT_CVT_FRINT 3
                            
// float arithmatics
#define SOFTFLOAT_FADD      0
#define SOFTFLOAT_FSUB      1
#define SOFTFLOAT_FMUL      2
#define SOFTFLOAT_FDIV      3
#define SOFTFLOAT_FMADD     4
#define SOFTFLOAT_FMSUB     5
#define SOFTFLOAT_FNMADD    6
#define SOFTFLOAT_FNMSUB    7
#define SOFTFLOAT_FMAX      8
#define SOFTFLOAT_FMIN      9
#define SOFTFLOAT_FMAXA     10
#define SOFTFLOAT_FMINA     11
#define SOFTFLOAT_FABS      12
#define SOFTFLOAT_FNEG      13
#define SOFTFLOAT_FSQRT     14
#define SOFTFLOAT_FRECIP    15
#define SOFTFLOAT_FRSQRT    16
#define SOFTFLOAT_FSCALEB   17
#define SOFTFLOAT_FLOGB     18
#define SOFTFLOAT_FCOPYSIGN 19
#define SOFTFLOAT_FCLASS    20

#define SOFTFLOAT_SIZE_SW 0
#define SOFTFLOAT_SIZE_SL 1
#define SOFTFLOAT_SIZE_DW 2
#define SOFTFLOAT_SIZE_DL 3

class Softfloat{
private:
    uint8_t vzoui;
    
    uint64_t soft_arith(uint8_t op,uint8_t size,uint64_t a,uint64_t b,uint64_t c); //arith
    uint64_t soft_cmp  (uint8_t op,uint8_t size,uint64_t a,uint64_t b,uint64_t c); //cmp
    uint64_t soft_cvt  (uint8_t op,uint8_t size,uint64_t a,uint64_t b,uint64_t c); //cvt

public:
    Softfloat();
    ~Softfloat();
    uint8_t switch_rm(uint8_t);
    uint64_t get_result(uint8_t cat,uint8_t op,uint8_t size,uint64_t a,uint64_t b,uint64_t c);
    uint8_t get_vziou();
};

#endif
