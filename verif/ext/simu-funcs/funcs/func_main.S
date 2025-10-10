
#include "func_test.h"

.globl main

main:
	li.d $r12, 0x1234

	# clear counter
	csrwr $zero, 0x201
	csrwr $zero, 0x203
	csrwr $zero, 0x205
	csrwr $zero, 0x207
	csrwr $zero, 0x209
	csrwr $zero, 0x20b
	csrwr $zero, 0x20d

	# set 
	li.d  $r12, 0x1f0000
	csrwr $r12, 0x200
	li.d  $r12, 0x1f0001
	csrwr $r12, 0x202
	li.d  $r12, 0x1f0003
	csrwr $r12, 0x204
	li.d  $r12, 0x1f000e
	csrwr $r12, 0x206
	li.d  $r12, 0x1f0010
	csrwr $r12, 0x208
	li.d  $r12, 0x1f0028
	csrwr $r12, 0x20a
	li.d  $r12, 0x1f0029
	csrwr $r12, 0x20c
	
	# CALL_TEST_FUN(misc) 
	# CALL_TEST_FUN(fpu) 
	CALL_TEST_FUN(lsu) 
	bl info_fpu

	csrrd $r13, 0x201
	add.d $r13, $r13, $zero

	csrrd $r13, 0x203
	add.d $r13, $r13, $zero

	csrrd $r13, 0x205
	add.d $r13, $r13, $zero

	csrrd $r13, 0x207
	add.d $r13, $r13, $zero

	csrrd $r13, 0x209
	add.d $r13, $r13, $zero

	csrrd $r13, 0x20b
	add.d $r13, $r13, $zero

	csrrd $r13, 0x20d
	add.d $r13, $r13, $zero

	la  $t0, cpsr_check
	csrwr $t0, 0x133

	.word 0x06490000

	bl info_checkpoint_failed

	b .


cpsr_check:
	bl info_checkpoint_pass

pr_info_test:	
	bl info_test

	b .


.type main 0
.size main, .-main


