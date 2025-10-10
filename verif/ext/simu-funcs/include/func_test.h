#ifndef __FUNC_TEST_H__
#define __FUNC_TEST_H__

#ifndef ASM_NL
#define ASM_NL		 ;
#endif


#define SYM_L_GLOBAL(name)			.globl name
#define SYM_L_WEAK(name)			.weak name
#define SYM_L_LOCAL(name)			/* nothing */

#define TEST_FUN_START(name)  \
		SYM_L_GLOBAL(__test_func_ ## name) ASM_NL \
		.align 4,0x90 ASM_NL \
        __test_func_ ## name :


#define TEST_FUN_END(name)	\
		.type __test_func_ ## name 0 ASM_NL		\
		.size __test_func_ ## name, .-__test_func_ ## name


#define CALL_TEST_FUN(name) \
		bl __test_func_ ## name  ASM_NL\
		nop

#endif

