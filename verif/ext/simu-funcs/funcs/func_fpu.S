#include "func_test.h"

TEST_FUN_START(fpu)

	add.d $zero, $zero, $zero


	li.d $t0, 0x4008CCCCCCCCCCCD #  3.1
	li.d $t1, 0xC00999999999999A # -3.2

	li.d $t2, 0xFFFFFFFFFFFFFFFF

	movgr2fr.d  $fa0, $t0
	movgr2fr.d  $fa1, $t1

	# movgr2frh.w $fa1, $t2
	# movfrh2gr.s $t3,  $fa1
	li.d          $t1, 1
	movgr2cf      $fcc0, $t1

	fsel          $fa3, $fa0, $fa1, $fcc0

	li.d $t3, 0x4008000000000000 # 3
	li.d $t4, 0x0000000040400000 # 3

	movgr2fr.d  $fa2, $t3
	movgr2fr.d  $fa3, $t4

	frsqrt.s $fa0, $fa3
	frsqrt.d $fa1, $fa2

	movfr2gr.d $t0,  $fa0
	movfr2gr.d $t1,  $fa1

	add.d $t0, $t0, $zero
	add.d $t1, $t1, $zero
	
	li.d $t5, 0x000000003F13CD3A # 0.577350269
	li.d $t6, 0x3FE279A74576233F # 0.577350269


	# fmax.d  $fa2, $fa0, $fa1
	# fmaxa.d $fa3, $fa0, $fa1
	
	# li.d $t0, 0x12345678
	# li.d $t1, 0x11111111
	# li.d $t2, 0x22222222
	# li.d $t3, 0x33333333
	# li.d $s2, 0x44444444
	# fst.d  $fa0, $sp, 0
	# fld.d  $fa0, $sp, 0
	# movfcsr2gr  $t3, $fcsr0  
	# movgr2fcsr  $fcsr0, $t0
	# movgr2fr.d  $fa0, $s2
	# fcmp.cor.d  $fcc0, $fa0, $fa0
	# bceqz       $fcc0, fpu_br
	# fabs.d      $fa0, $fa0
	# fcmp.cule.d $fcc1, $fa0, $fa1
	# bceqz       $fcc1, fpu_br
	# movgr2fr.d  $fa0, $s2

	# li.d       $t0, 0x3ff0000000000000
    # li.d       $t1, 0x3ff0000008000000
    # li.d       $t2, 0x3ff0000009000000
    # li.d       $t3, 0x3ff000000A000000
    # li.d       $t4, 0x3ff000000B000000
    # li.d       $t5, 0x3ff000000C000000
    # movgr2fr.d $fa0, $t0
    # movgr2fr.d $fa1, $t3
    # movgr2fr.d $fa0, $t2
    # fmov.d     $fa2, $fa0

fpu_br:
	li.d $t0, 0x1234
	li.d $a0, 0x1234
	ret
	
TEST_FUN_END(fpu)


