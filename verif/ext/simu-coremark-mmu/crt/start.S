
.text

.globl _start

_start:
    li.d $r1, 0
    li.d $r2, 0
    la $r3, _stack_end
    li.d $r4, 0
    li.d $r5, 0
    li.d $r6, 0
    li.d $r7, 0
    li.d $r8, 0
    li.d $r9, 0
    li.d $r10, 0
    li.d $r11, 0
    li.d $r12, 0
    li.d $r13, 0
    li.d $r14, 0
    li.d $r15, 0
    li.d $r16, 0
    li.d $r17, 0
    li.d $r18, 0
    li.d $r19, 0
    li.d $r20, 0
    li.d $r21, 0
    li.d $r22, 0
    li.d $r23, 0
    li.d $r24, 0
    li.d $r25, 0
    li.d $r26, 0
    li.d $r27, 0
    li.d $r28, 0
    li.d $r29, 0
    li.d $r30, 0
    li.d $r31, 0

    li.d $r11, 0x33
    li.d $r12, 0xff
    li.d $r13, 0x12300
    csrwr $r13, 0x30
    csrxchg $r11, $r12, 0x30

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    move      $t0, $s1
    addi.w    $t1, $zero, 0x4
    csrxchg   $t0, $t1, 0x0

    bl __create_pgd_mapping

    # sync data
    dbar 0

    li.d   $t1, 0
    csrwr  $t1, 0x550
    ibar 0

    rdtime.d $r11, $zero
    rdtimeh.w $r11, $zero
    rdtimel.w $r11, $zero

    bl log_mapping_success

    # set page table
    la $r12, pgd_table
    
    csrwr $r12, 0x19 # PGDL
    csrwr $r12, 0x1a # PGDH

    li.d $r11, 0x0000000000000011
    csrwr $r11, 0x180 

    li.d $r11, 0x800000000000000f
    csrwr $r11, 0x181
    
    li.d  $r12, 0x10
    csrwr $r12, 0x0  # DA=0, PG=1, MMU ON


    li.d  $r12, 0x3 // pplv = 11
    csrwr $r12, 0x1

    li.d      $t0, 0x4
    addi.w    $t1, $zero, 0x4
    csrxchg   $t0, $t1, 0x0


    la $r12, _expt_base
    csrwr $r12, 0xc

    invtlb 0, $zero, $zero

    li.d $r13, 0x6
    cpucfg $r13, $r13

    la $r13, _jump_user_expt
    li.d  $r12, 0x1800000000-0x1C000000
    add.d $r13, $r13, $r12
    csrwr $r13, 0x6
    ertn

# user space
_jump_user_expt:
    break 0
    bl _jump_user_main

_jump_user_main:
    la.abs $r3, _stack_end

    bl enter_user

_test_atomic:
    la.abs $r11, atomic
    li.d $r12, 0x1234
    li.d $r13, 0xf1f1
    li.d $r14, 0x8
    st.d $r12, $r11, 0
    # stx.d $r12, $r11, $r14

    # amswap.w $r20, $r13, $r11
    # amswap.d $r20, $r13, $r11

    addi.w      $t1, $zero, 1
    amadd_db.w  $t0, $t1, $r11

    dbar 0

    ld.d $r13, $r11, 0
    add.d      $r13, $r13, $zero

    # amswap_db.w $r20, $r13, $r11
    # amswap_db.d $r20, $r13, $r11

    # st.d $r12, $r11, 0

    # ammax.w $r20, $r13, $r11
    # ammax.d $r20, $r13, $r11

    # ammax_db.w $r20, $r13, $r11
    # ammax_db.d $r20, $r13, $r11


_test_llsc:
    li.d $r13, 0xf1
    li.d $r14, 0xf0
    
    la.abs $r11, ll_sc


    ll.d $r15, $r11, 0

    ld.d $r14, $r11, 0

    sc.d $r13, $r11, 0

    add.d $r13, $r13, $zero

__enter_main:
    la.abs $r12, main
    la.abs $r1, sys_exit // return system_exit
    jirl $r0, $r12, 0

sys_exit:
    la $r5, exit_pc
    li.d $r4, 0x54000000 // bl .
    st.d $r4, $r5, 0
    ibar 0
    jirl $r0, $r5, 0
1:
    bl 1b 

   
.section .expt.text
.globl  expt_vector
.type   expt_vector, @function
expt_vector:    
    bl enter_expt

    # modify era, next inst
    csrrd $r13, 0x6
    addi.d $r13, $r13, 4
    csrwr $r13, 0x6
    ertn


# data area

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


