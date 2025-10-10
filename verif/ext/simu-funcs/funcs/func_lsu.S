
#include "func_test.h"


TEST_FUN_START(lsu)
	li.d $r12, 0x1234
	dbar 0
    invtlb 0, $zero, $zero

_test_unalign:
    la.abs $r11, unalign_mem  

    # initalized
    li.d $r12, 0x1234567890ABCDEF   
    st.d $r12, $r11, 0
    addi.d $r11, $r11, 8
    st.d $r12, $r11, 0

    la.abs $r11, unalign_mem
    addi.d $r11, $r11, 8
    li.d   $r15, -4

    # load
    ldptr.w $r21, $r11, -4
    ldptr.d $r22, $r11, -4
    addi.d $r21, $r21, 0
    addi.d $r22, $r22, 0

    ld.w $r21, $r11, -4
    ld.d $r22, $r11, -4
    addi.d $r21, $r21, 0
    addi.d $r22, $r22, 0

    ldx.w $r21, $r11, $r15
    ldx.d $r22, $r11, $r15
    addi.d $r21, $r21, 0
    addi.d $r22, $r22, 0

    # store
    li.d $r12, 0xFEDCBA0987654321
    stptr.w $r12, $r11, -4
    addi.d $r15, $r11, 2
    dbar 0
    invtlb 0, $zero, $zero
    ldptr.d $r21, $r15, 0
    addi.d $r13, $r12, 0
    addi.d $r21, $r21, 0

    stptr.d $r12, $r11, -4
    dbar 0
    invtlb 0, $zero, $zero
    ldptr.d $r22, $r11, -4
    addi.d $r13, $r12, 0
    addi.d $r22, $r22, 0

    st.w $r12, $r11, -4
    dbar 0
    invtlb 0, $zero, $zero
    ldptr.w $r21, $r11, -4
    addi.d $r13, $r12, 0
    addi.d $r21, $r21, 0

    st.d $r12, $r11, -4
    dbar 0
    invtlb 0, $zero, $zero
    ldptr.d $r22, $r11, -4
    addi.d $r13, $r12, 0
    addi.d $r22, $r22, 0


    stx.w $r12, $r11, $r15
    dbar 0
    invtlb 0, $zero, $r15
    ldptr.w $r21, $r11,-4
    addi.d $r13, $r12, 0
    addi.d $r21, $r21, 0

    stx.d $r12, $r11, $r15
    dbar 0
    invtlb 0, $zero, $r15
    ldptr.d $r22, $r11,-4
    addi.d $r13, $r12, 0
    addi.d $r22, $r22, 0


_test_atomic:
    la.abs $r11, atomic
    li.d $r12, 0x1234
    li.d $r13, 0xf1f1
    li.d $r14, 0x8
    st.d $r12, $r11, 0
    stx.d $r12, $r11, $r14

    amswap.w $r20, $r13, $r11
    amswap.d $r20, $r13, $r11

    addi.w      $t1, $zero, 1
    amadd_db.w  $t0, $t1, $r11

    dbar 0

    ld.d $r13, $r11, 0
    add.d      $r13, $r13, $zero

    amswap_db.w $r20, $r13, $r11
    amswap_db.d $r20, $r13, $r11

    st.d $r12, $r11, 0

    ammax.w $r20, $r13, $r11
    ammax.d $r20, $r13, $r11

    ammax_db.w $r20, $r13, $r11
    ammax_db.d $r20, $r13, $r11


_test_llsc:
    li.d $r13, 0xf1
    li.d $r14, 0xf0
    
    la.abs $r11, ll_sc

    ll.d $r15, $r11, 0

    ld.d $r14, $r11, 0

    sc.d $r13, $r11, 0

    add.d $r13, $r13, $zero
    
    ret
TEST_FUN_END(lsu)


    .globl  unalign_mem
    .section        .data,"aw",@nobits
    .align  3
    .type   unalign_mem, @object
    .size   unalign_mem, 16
unalign_mem:
    .space  16

    .globl  atomic
    .section        .data,"aw",@nobits
    .align  3
    .type   atomic, @object
    .size   atomic, 8
atomic:
    .space  8

    .globl  ll_sc
    .section        .data,"aw",@nobits
    .align  3
    .type   ll_sc, @object
    .size   ll_sc, 8
ll_sc:
    .space  8



