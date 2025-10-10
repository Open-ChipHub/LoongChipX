
#include "func_test.h"


TEST_FUN_START(csr)
	li.d $r12, 0x1234

	li.d $r11, 0x33
    li.d $r12, 0xff
    li.d $r13, 0x12300
    csrwr $r13, 0x30
    csrxchg $r11, $r12, 0x30

    move      $t0, $s1
    addi.w    $t1, $zero, 0x4
    csrxchg   $t0, $t1, 0x0


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

    ret
TEST_FUN_END(csr)


