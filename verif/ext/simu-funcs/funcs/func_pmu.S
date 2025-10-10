#include "func_test.h"


TEST_FUN_START(pmu)
	li.d $r12, 0x1234

	ret
TEST_FUN_END(pmu)
