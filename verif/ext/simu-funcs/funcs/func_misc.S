
#include "func_test.h"


TEST_FUN_START(misc)
	li.d $r12, 0x1234

	rdtime.d $r11, $zero
    rdtimeh.w $r11, $zero
    rdtimel.w $r11, $zero
    ret
TEST_FUN_END(misc)



