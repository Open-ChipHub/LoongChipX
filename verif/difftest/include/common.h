#ifndef CHIPLAB_COMMON_H
#define CHIPLAB_COMMON_H

#ifndef NUM_CORES
#define NUM_CORES 1
#endif

#ifndef FIRST_INST_ADDRESS
#define FIRST_INST_ADDRESS 0x1c000000
#endif

/* nemu memory size */
#define EMU_RAM_SIZE (4 * 1024 * 1024 * 1024UL) // 4 GB

#include <verilated.h>
#include <verilated_save.h>
#include <sys/time.h>
#include "VTop.h"

extern std::chrono::nanoseconds diff_nano_seconds;
extern std::chrono::nanoseconds emu_nano_seconds;

extern struct timeval start, end;

#endif //CHIPLAB_COMMON_H