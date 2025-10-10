
#ifndef __STRING_H__
#define __STRING_H__

#include "datatype.h"

void* memcpy(void* dest, const void* src, size_t len);
void* memset(void* dest, int byte, size_t len);
size_t strlen(const char *s);
int strcmp(const char* s1, const char* s2);
char* strcpy(char* dest, const char* src);
long atol(const char* str);


#endif