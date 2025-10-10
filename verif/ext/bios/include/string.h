#ifndef XIL_STRING_H	/* prevent circular inclusions */
#define XIL_STRING_H	/* by using protection macros */

// #include "xil_types.h"
#include <stddef.h>

void* memcpy(void* dest, const void* src, size_t len);

void* memset(void* dest, int byte, size_t len);

size_t strlen(const char *s);

int strcmp(const char* s1, const char* s2);

char* strcpy(char* dest, const char* src);

long atol(const char* str);

#endif	/* end of protection macro */