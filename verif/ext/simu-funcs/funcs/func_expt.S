
#include "func_test.h"

.section .expt.text

TEST_FUN_START(expt)
	li.d $r12, 0x1234

    # modify era, next inst
    csrrd $r13, 0x6
    addi.d $r13, $r13, 4
    csrwr $r13, 0x6
    ertn


TEST_FUN_END(expt)


