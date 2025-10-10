
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

    li.d $r11, 0x0000000000000011
    csrwr $r11, 0x180 

    li.d $r11, 0x800000000000000f
    csrwr $r11, 0x181

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    li.d  $r12, 0x10
    csrwr $r12, 0x0  # Cache ON

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

   

# data area

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


