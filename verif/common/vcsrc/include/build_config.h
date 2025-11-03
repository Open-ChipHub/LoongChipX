#ifndef __CONFIG_BUILD_H
#define __CONFIG_BUILD_H

// enable dumps at logs/sim.log
#define CONFIG_INSN_TRACE
//#define WITH_PMSLICE
//macro WITH_PMCNT is generated in pmcnt.h
#ifndef WITH_PMCNT
#define WITH_PMCNT 1
#endif
#define WITH_WATCH_PADDR
// #define USE_DRAM_SIM
// #define MONITOR_DRAM_SIM
// #define WITH_RECORD_PC
// #define FCSR_COMPARE

// #define CONFIG_DIFFTEST 1

#define FORK_INTERVAL 1000
#define SLOT_SIZE     2
#define WAIT_INTERVAL 5

#define SIMU_TRACE     1
#define OUTPUT_PC_INFO 1

#define DEAD_CLOCK_EN  1
    #define DEAD_CLOCK_SIZE 10000

#define TRACE_COMP     1


#endif // __CONFIG_BUILD_H 
