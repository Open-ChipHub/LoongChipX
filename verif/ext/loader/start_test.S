
#include "loongarchaddrspace.h"
#include "laregs.h"
#include "entry.h"

.globl _start

_start:
    /* Save boot rom start args */
    li.d    $a0, 0
    li.d    $a1, 0
    li.d    $a2, 0
    li.d    $a3, 0

    li.d    $sp, 0x12000000

    bl      boot_uart_init

    bl      log_test_instructions

    bl      test_cases

    bl      log_test_over

    bl      jump_kernel
    li.d    $t0, 0xffffffff
    li.d    $t1, KERNEL_ENTRY
    and     $t1, $t1, $t0
    jirl    $zero, $t1, 0

test_cases:
    addi.d  $r3,$r3,-48
    st.d    $r1,$r3,8

    li.d $r11, 0x33
    li.d $r12, 0xff
    li.d $r13, 0x12300
    csrwr $r13, LA_CSR_KS0
    csrxchg $r11, $r12, LA_CSR_KS0
    bl log_csr

    li.d $r11, 0x0000000000000011
    # li.d $r11, 0x8000000000000001
    csrwr $r11, LA_CSR_DMWIN0 
    bl log_csr

    li.d  $r12, 0x14
    csrwr $r12, LA_CSR_CRMD  # IE=1, DA=0, PG=1, MMU ON
    bl log_csr

    # sync data
    dbar 0
    bl log_dbar

_test_atomic:
    la.abs $r11, atomic
    li.d $r12, 0x1234
    li.d $r13, 0xf1f1
    li.d $r14, 0x8
    st.d $r12, $r11, 0
    bl log_atomic
    # stx.d $r12, $r11, $r14

    # amswap.w $r20, $r13, $r11
    # amswap.d $r20, $r13, $r11

    addi.w     $t1, $zero, 1
    amor_db.w  $t0, $t1, $r11
    bl log_atomic

    dbar 0

    # ld.d $r13, $r11, 0
    # add.d      $r13, $r13, $zero

    # amswap_db.w $r20, $r13, $r11
    # amswap_db.d $r20, $r13, $r11

    # st.d $r12, $r11, 0

    # ammax.w $r20, $r13, $r11
    # ammax.d $r20, $r13, $r11

    # ammax_db.w $r20, $r13, $r11
    # ammax_db.d $r20, $r13, $r11

    bl log_atomic

    rdtime.d  $r11, $zero
    rdtimeh.w $r11, $zero
    rdtimel.w $r11, $zero

    bl log_csr

    # set page table
    la $r12, stack
    
    csrwr $r12, LA_CSR_PGDL # PGDL
    csrwr $r12, LA_CSR_PGDH # PGDH

    bl log_csr

    li.d $r11, 0x0000000000000011
    bl log_csr
    csrwr $r11, LA_CSR_DMWIN0 
    bl log_csr

    li.d $r11, 0x800000000000000f
    csrwr $r11, LA_CSR_DMWIN1
    bl log_csr
    
    li.d  $r12, 0x14
    csrwr $r12, LA_CSR_CRMD  # IE=1, DA=0, PG=1, MMU ON


    li.d  $r12, 0x7 // PPLV = 11, PIE=1
    csrwr $r12, LA_CSR_PRMD

    # Set Expection
    la $r12, stack
    csrwr $r12, LA_CSR_EENTRY

    li.d $r12, 0xBFC
    csrwr $r12, LA_CSR_ECFG
    bl log_csr

    invtlb 0, $zero, $zero

    li.d $r13, 0x6
    cpucfg $r13, $r13

    la $r13, test_cases
    li.d  $r12, 0x1800000000-0x1C000000
    add.d $r13, $r13, $r12
    csrwr $r13, LA_CSR_ERA
    bl log_csr

    ld.d    $r1,$r3,8
    addi.d  $r3,$r3,48
    jirl    $zero, $r1, 0


# data area

    .globl  save_sp
    .section        .data,"aw",@nobits
    .align  3
    .type   save_sp, @object
    .size   save_sp, 8
save_sp:
    .space  8

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

    .globl  exit_pc
    .section        .dymmy_exit,"aw",@nobits
    .align  3
    .type   exit_pc, @object
    .size   exit_pc, 8
exit_pc:
    .space  8

    .globl  stack
    .section  .stack,"aw",@nobits
    .align  3
    .type   stack, @object
    .size   stack, 8192
stack:
    .space  8192