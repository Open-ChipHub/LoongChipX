
.text

.globl _start

_start:
    li.d  $r5, 0xf
    csrwr $r5, 0xfff
    la.abs      $t0, 0f
    jirl        $zero, $t0, 0

0:
    li.d $r1, 0
    li.d $r2, 0
    la.abs $r3, _stack_end
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

    li.d $r11, 0x0000000000000011
    csrwr $r11, 0x180 

    li.d $r11, 0x800000000000000f
    csrwr $r11, 0x181

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    li.d  $r12, 0x10
    csrwr $r12, 0x0  # Cache ON

    li.d   $a1, 0x100
    li.d   $a2, 0x101
    li.d   $a3, 0x110
    li.d   $a4, 0x103
    la.abs $r12, atomic
    li.d   $r13, 4
    li.d   $r16, 7
    stx.b  $a1, $r12, $r13
    stx.b  $a2, $r12, $r13

    addi.d $r13, $r12, 6
    asrtle.d $r12, $r13
    asrtgt.d $r13, $r12
    
    li.d   $r14, 5
    stx.b  $a3, $r12, $r14
    stx.b  $a3, $r12, $r14
    
    li.d   $r15, 6
    stx.b  $a4, $r12, $r15
    stx.b  $a4, $r12, $r15
    
    stx.b  $a4, $r12, $r16
    stx.b  $a4, $r12, $r16

    tlbclr
    tlbflush
    tlbsrch
    tlbrd
    tlbwr
    tlbfill

    # FPU
    ftintrz.w.d     $fa3, $fa0
    ffint.d.w       $fa1, $fa3
    ffint.d.l       $fa1, $fa1
    fsub.d          $fa5, $fa5, $fa1
    fadd.d          $fa1, $fa1, $fa1

    la.abs $r12, main_hardid_0
    jirl $r1, $r12, 0
    la.abs $r12, boot_secondary_addr
    la.abs $r13, boot_secondary
    st.d   $r13, $r12, 0
    bl switch_second
1:
    bl 1b 


sys_exit:
    la $r5, exit_pc
    li.d $r4, 0x54000000 // bl .
    st.d $r4, $r5, 0
    dbar 0
    ibar 0
    jirl $r0, $r5, 0
2:
    bl 2b 


.globl boot_secondary
boot_secondary:
    li.d $r1, 0
    li.d $r2, 0
    la.abs $r3, _stack_end
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

    li.d $r11, 0x0000000000000011
    csrwr $r11, 0x180 

    li.d $r11, 0x800000000000000f
    csrwr $r11, 0x181

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    li.d  $r12, 0x10
    csrwr $r12, 0x0  # Cache ON

    bl info_second_core

    la.abs $r12, main_hardid_1
    jirl $r1, $r12, 0

    la.abs $r12, boot_third_addr
    la.abs $r13, boot_third
    st.d   $r13, $r12, 0
    bl switch_third

3:
    bl 3b 


.globl boot_third
boot_third:
    li.d $r1, 0
    li.d $r2, 0
    la.abs $r3, _stack_end
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

    li.d $r11, 0x0000000000000011
    csrwr $r11, 0x180 

    li.d $r11, 0x800000000000000f
    csrwr $r11, 0x181

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    li.d  $r12, 0x10
    csrwr $r12, 0x0  # Cache ON

    bl info_third_core

    la.abs $r12, main_hardid_2
    jirl $r1, $r12, 0

    la.abs $r12, boot_fourth_addr
    la.abs $r13, boot_fourth
    st.d   $r13, $r12, 0
    bl switch_fourth

4:
    bl 4b 


.globl boot_fourth
boot_fourth:
    li.d $r1, 0
    li.d $r2, 0
    la.abs $r3, _stack_end
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

    li.d $r11, 0x0000000000000011
    csrwr $r11, 0x180 

    li.d $r11, 0x800000000000000f
    csrwr $r11, 0x181

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    li.d  $r12, 0x10
    csrwr $r12, 0x0  # Cache ON

    bl info_fourth_core

    la.abs $r12, main_hardid_3
    jirl $r1, $r12, 0

5:
    bl 5b 


    .globl  atomic
    .section        .data 
    .align  3
    .type   atomic, @object
    .size   atomic, 8
atomic:
    .space  8

    .globl  ll_sc
    .section        .data
    .align  3
    .type   ll_sc, @object
    .size   ll_sc, 8
ll_sc:
    .space  8

    .globl  exit_pc
    .section        .dymmy_exit
    .align  3
    .type   exit_pc, @object
    .size   exit_pc, 8
exit_pc:
    .space  8

    .globl  stack
    .section  .stack
    .align  3
    .type   stack, @object
    .size   stack, 8192
stack:
    .space  8192


