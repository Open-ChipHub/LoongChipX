
#include "loongarchaddrspace.h"
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

    li.d    $t0, 0xffffffff
    li.d    $t1, KERNEL_ENTRY
    and     $t1, $t1, $t0
    jirl    $zero, $t1, 0






