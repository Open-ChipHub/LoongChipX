#ifndef __UTIL_H
#define __UTIL_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

static inline FILE* fopen_nofail(const char *__restrict __filename, const char *__restrict __modes) {
    FILE* f = fopen(__filename, __modes);
    if (!f) {
        fprintf(stderr, "can not open %s: %s\n", __filename, strerror(errno));
        exit(EXIT_FAILURE);
    }
    return f;
}

static inline FILE* fopen_nofail_with_dir(const char *__restrict __dirname, const char *__restrict __filename, const char *__restrict __modes) {
    char name[1024];
    int r = snprintf(name, sizeof(name), "%s/%s", __dirname, __filename);
    if (r <= 0 || r >= sizeof(name)) {
        fprintf(stderr, "can not open %s: %s\n", __filename, strerror(errno));
        exit(EXIT_FAILURE);
    }
    return fopen_nofail(name, __modes);
}


#endif //__UTIL_H
