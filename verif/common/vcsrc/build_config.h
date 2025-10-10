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
#define USE_DRAM_SIM
//#define MONITOR_DRAM_SIM
//#define WITH_RECORD_PC
//#define FCSR_COMPARE

#endif // __CONFIG_BUILD_H 
