
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

    li.w  $r11, 0x01 # FPE=1, SXE=0, ASXE=0, BTE=0
    csrwr $r11, 0x2  # CSR EUEN

    la $r13, __enter_main
    csrwr $r13, 0x6
    ertn

__enter_main:
    # li.d $r13, 0x11
    # csrwr $r13, 0x132
    la $r12, main
    la $r1, sys_exit // return system_exit
    jirl $r0, $r12, 0

sys_exit:
    
    # li.d $r13, 0xFF
    # csrwr $r13, 0x132

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


