######################################################################
#
# DESCRIPTION: Verilator Example: Small Makefile
#
# This calls the object directory makefile.  That allows the objects to
# be placed in the "current directory" which simplifies the Makefile.
#
# This file ONLY is placed under the Creative Commons Public Domain, for
# any use, without warranty, 2020 by Wilson Snyder.
# SPDX-License-Identifier: CC0-1.0
#
######################################################################
# Check for sanity to avoid later confusion
export CC   := clang++ 
export CXX  := clang++ 
export LINK := clang++

LCX_HOME := $(shell realpath ../../../)
$(info LCX_HOME=$(LCX_HOME))
export LCX_HOME

VERIF_DIR  := $(LCX_HOME)/verif
COMMON_DIR := $(LCX_HOME)/verif/common
DIFFTEST_DIR := $(LCX_HOME)/verif/difftest

ifneq ($(words $(CURDIR)),1)
 $(error Unsupported: GNU Make cannot build in directories containing spaces, build elsewhere: '$(CURDIR)')
endif

######################################################################
# Set up variables

# If $VERILATOR_ROOT isn't in the environment, we assume it is part of a
# package install, and verilator is in your path. Otherwise find the
# binary relative to $VERILATOR_ROOT (such as when inside the git sources).
$(info VERILATOR_ROOT: $(VERILATOR_ROOT))
ifeq ($(VERILATOR_ROOT),)
VERILATOR = verilator
VERILATOR_COVERAGE = verilator_coverage
else
export VERILATOR_ROOT
VERILATOR = $(VERILATOR_ROOT)/bin/verilator
VERILATOR_COVERAGE = $(VERILATOR_ROOT)/bin/verilator_coverage
endif
XML2STEMS = xml2stems

#
MAKEFILE_PATH = $(abspath $(lastword $(MAKEFILE_LIST)))
MAKEFILE_DIR  = $(dir $(MAKEFILE_PATH))
WAVE_FLAGS    ?=
CXXFLAGS_OPTIMIZE ?=
CXXFLAGS      ?=
LDFLAGS       ?=
OBJCACHE	  ?= $(shell command -v ccache >/dev/null 2>&1; if [ $$? -eq 0 ]; then echo "ccache"; fi)

WAVE          ?= VCD
CONFIG        ?= $(VERIF_DIR)/config/config.hello

# Generate makefile dependencies (not shown as complicates the Makefile)
#VERILATOR_FLAGS += -MMD
# Optimize
#CXXFLAGS_OPTIMIZE += -march=native -mtune=native
MACHINE=$(shell gcc -dumpmachine)
ifeq ("$(MACHINE)", "x86_64-linux-gnu")
CXXFLAGS_OPTIMIZE += -mavx2 #-flto=thin
#LD = lld
#LDFLAGS += "-fuse-ld=lld"
endif

ifeq ("$(MACHINE)", "x86_64-pc-linux-gnu")
CXXFLAGS_OPTIMIZE += -mavx2 -march=native -flto=thin
CXXFLAGS += -stdlib=libstdc++
LDFLAGS += -stdlib=libstdc++
endif

CXXFLAGS_OPTIMIZE += -O3 
CXXFLAGS += $(CXXFLAGS_OPTIMIZE)

ifeq ("$(RANDOM_INIT)", "1")
VERILATOR_FLAGS += -x-assign unique --x-initial unique
else
VERILATOR_FLAGS += -x-assign 0 --x-initial 0
endif

VERILATOR_FLAGS += -O3
# Warn abount lint issues; may not want this on less solid designs
VERILATOR_FLAGS += -Wall
# Make waveforms vcd:--trace, fst:--trace-fst, only one should be selected
# VERILATOR_FLAGS += --trace

# include files path
CXXFLAGS+=-I$(COMMON_DIR)/memory/DRAMsim3/src/
CXXFLAGS+=-I$(COMMON_DIR)/memory/
# lib files path
LDFLAGS +=-L$(COMMON_DIR)/memory/DRAMsim3/
LIBS    += -ldramsim3

ifeq ("$(WAVE)", "FST")
    WAVE_FLAGS=--trace-fst
    CXXFLAGS+=-DWAVE_FST
else ifeq ("$(WAVE)", "VCD")
    WAVE_FLAGS=--trace
    CXXFLAGS+=-DWAVE_VCD
else
    CXXFLAGS+=-DWAVE_NONE
endif

VERILATOR_THREAD_NUM  ?= 8
ifneq ($(VERILATOR_THREAD_NUM),0)
VERILATOR_FLAGS += --threads $(VERILATOR_THREAD_NUM)
# fork and multithreads dump wavs is dangerous, but only one wave is allowed currently
# this just slightly increase the speed of wave dump
VERILATOR_FLAGS += --trace-threads 2
CXXFLAGS += -DVERILATOR_THREAD_NUM=$(VERILATOR_THREAD_NUM)
endif


VERILATOR_FLAGS += $(WAVE_FLAGS)
# Check SystemVerilog assertions
VERILATOR_FLAGS += --assert
VERILATOR_FLAGS += -CFLAGS "$(CXXFLAGS_OPTIMIZE)"
# Generate coverage analysis
#VERILATOR_FLAGS += --coverage
# Run Verilator in debug mode
#VERILATOR_FLAGS += --debug
# Add this trace to get a backtrace in gdb
#VERILATOR_FLAGS += --gdbbt

# Input files for Verilator

VERILATOR_DEFINE := -DNO_WAVE_DUMP_DEBUG
VERILATOR_DEFINE += -DCPU_SINGLE_RETIRE
VERILATOR_DEFINE += -DDEBUG_PC_WAVE_DUMP
VERILATOR_DEFINE += -DCPU_CHECKPOINT
VERILATOR_DEFINE += -DDUAL_CORE
VERILATOR_DEFINE += -DTRIPLE_CORE
# VERILATOR_DEFINE += -DQUAD_CORE


VERILATOR_FILELISTS ?= $(VERIF_DIR)/filelists/verilator_littlecore_files.lst
VERILATOR_SRC   += -f $(VERILATOR_FILELISTS)
VERILATOR_INPUT ?= $(VERILATOR_DEFINE) --top-module Top ${VERILATOR_SRC} -Wno-CMPCONST -Wno-fatal

######################################################################
default: sub-run run

vtop_mk    := ./obj_dir/VTop.mk
vtop_xml   := ./obj_dir/VTop.xml
vtop_stems := ./obj_dir/VTop.stems


CXX_SRC :=  $(COMMON_DIR)/memory/memorysim_check.cpp   \
			$(COMMON_DIR)/memory/memorysim_write.cpp   \
			$(COMMON_DIR)/memory/memorysim_read.cpp    \
			$(COMMON_DIR)/vcsrc/snapshot.cpp           \
			$(COMMON_DIR)/vcsrc/serial.cpp             \
			$(COMMON_DIR)/vcsrc/initialize.cpp         \
			$(COMMON_DIR)/vcsrc/config.cpp             \
			$(COMMON_DIR)/vcsrc/fifo8.cpp              \
			$(COMMON_DIR)/vcsrc/log.cpp                \
			$(COMMON_DIR)/vcsrc/fpr.cpp                \
			$(COMMON_DIR)/vcsrc/ram.cpp                \
			$(COMMON_DIR)/vcsrc/rand64.cpp             \
			$(COMMON_DIR)/vcsrc/axi.cpp                \
			$(COMMON_DIR)/vcsrc/sim_config.cpp         \
			$(COMMON_DIR)/sim_main.cpp

CXXFLAGS += -I$(COMMON_DIR)/memory -I$(COMMON_DIR)/vcsrc/include -I$(COMMON_DIR)/softfpu


memory:
	$(MAKE) -C $(COMMON_DIR)/memory/DRAMsim3

$(vtop_mk):
	@echo "CXX_SRC=$(CXX_SRC)"
	@mkdir -p $(dir $@)
	$(VERILATOR) $(CXX_SRC) -cc --exe $(VERILATOR_FLAGS) $(VERILATOR_INPUT) >$@.out 2>$@.err
	find -L obj_dir -name "VTop.h" | xargs sed -i 's/private/public/g'
	find -L obj_dir -name "VTop.h" | xargs sed -i 's/const vlSymsp/vlSymsp/g'
	find -L obj_dir -name "VTop__Syms.h" | xargs sed -i 's/VlThreadPool\* const/VlThreadPool*/g'

build: $(vtop_mk) memory 
	$(MAKE) OBJCACHE="$(OBJCACHE)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)" LIBS="$(LIBS)" -C obj_dir -f $(COMMON_DIR)/Makefile_obj

print_trace: vcsrc/print_trace.c vcsrc/trace.h
	gcc vcsrc/print_trace.c -o print_trace

run: build 
	mkdir -p logs
	obj_dir/VTop $(CONFIG) +trace

sub-run:

show-config:
	$(VERILATOR) -V

hello:
	make -C $(VERIF_DIR)/ext/simu-hello clean
	make -C $(VERIF_DIR)/ext/simu-hello LDSTART=--defsym=MEM_START=0x1C100000

coremark:
	make -C $(VERIF_DIR)/ext/simu-coremark-user clean
	make -C $(VERIF_DIR)/ext/simu-coremark-user LDSTART=--defsym=MEM_START=0x80000000

kernel:
	make -C $(VERIF_DIR)/ext/simu-kernel clean
	make -C $(VERIF_DIR)/ext/simu-kernel

#------------------------------- Verdi -------------------------------#
VERDI := verdi
VERDI_OPTS := -rcFile config/novas.rc -guiConf config/novas.conf
VERDI_OPTS += -ssy -ssv

VERDI_DEFINE := +define+CPU_RANDOM_TEST
VERDI_DEFINE += +define+DBG_GOLD_TRACE
VERDI_DEFINE += +define+DBG_GOLD_TRACE_ALU_DIFF
VERDI_DEFINE += +define+DUAL_CORE
VERDI_DEFINE += +define+TRIPLE_CORE
# VERDI_DEFINE += +define+QUAD_CORE

WAVE = wave.vcd.fsdb

vcd2fsdb:
	vcd2fsdb logs/latest/wave.vcd -o $(WAVE)

verdi:
	cat $(VERILATOR_FILELISTS) > files.verdi.lst
	echo -e "\$${LCX_HOME}/verif/common/vsrc/Top_verdi_dummy.v" >> files.verdi.lst
	$(VERDI) $(VERDI_DEFINE) -sv -ssy -ssv -ssf $(WAVE) -top Sim_Top -f files.verdi.lst -nologo > /dev/null &


maintainer-copy::
mostlyclean maintainer-clean::
	-rm -rf *.log *.dmp *.vpd coverage.dat core obj_dir find_out_* \
	$(WAVE) ./obj_dir/find_out_* *exe.report* logs board.h \
	vcd2fsdbLog verdiLog 
	$(MAKE) clean -C $(COMMON_DIR)/memory/DRAMsim3  

clean:
	-rm -rf *exe.report* logs board.h
	-rm -rf ./obj_dir

clean_all: mostlyclean

distclean: clean
	-rm -rf logs find_out_*

.PHONY: memory

FORCE:
