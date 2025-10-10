
.text
.globl main
.globl _start
.globl _setting
.globl __stack

# RAM 0x1C06_0000-0x1C06_1FFF 16KB
# Stack_top = 0x1C06_1F00

_start:
    li.d $r1, 0
    li.d $r2, 0
  # li.d $r3, 0x01C061F00
    li.d $r3, 0x100200000
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
    
    bl main

sys_exit:
    li.d $r4, 0x1FF80000 #    
    li.d $r5, 0xF
    st.d $r5, $r4, 0
    nop
1:
    bl 1b 


