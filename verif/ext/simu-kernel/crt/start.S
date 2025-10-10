#include "entry.h"

.text
.globl _start

__kernel_entry:
    li.d      $r12 , ENTRY_ADDR
    li.d      $a0 , 0
    li.d      $a1 , 0
    li.d      $a2 , 0
    li.d      $a3 , 0
    jirl      $r0, $r12, 0     #jump to kernel entry 

    .globl  stack
    .section  .stack,"aw",@nobits
    .align  3
    .type   stack, @object
    .size   stack, 8192
stack:
    .space  8192


