
export CC   := clang++ 
export CXX  := clang++ 
export LINK := clang++

LCX_HOME := $(shell realpath ../)
$(info LCX_HOME=$(LCX_HOME))
export LCX_HOME
VERILATOR = verilator
VERIF_DIR  := $(LCX_HOME)/verif
COMMON_DIR := $(LCX_HOME)/verif/common
DIFFTEST_DIR := $(LCX_HOME)/verif/difftest

CXXFLAGS_OPTIMIZE ?=
CXXFLAGS      ?=
LDFLAGS       ?=
OBJCACHE	  ?= $(shell command -v ccache >/dev/null 2>&1; if [ $$? -eq 0 ]; then echo "ccache"; fi)

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
LDFLAGS +=-L$(COMMON_DIR)/softfpu
LIBS    += -ldramsim3
LIBS    += -lz
WAVE_FLAGS=--trace-fst
CXXFLAGS+=-DWAVE_FST

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

VERILATOR_DEFINE := -DDIFF_HARDWARE

VERILATOR_FILELISTS ?= $(LCX_HOME)/test/xdma_diff_files.lst
VERILATOR_SRC   += -f $(VERILATOR_FILELISTS)
VERILATOR_INPUT ?= $(VERILATOR_DEFINE) --top-module Top ${VERILATOR_SRC} -Wno-CMPCONST -Wno-fatal

default: run

vtop_mk    := ./obj_dir/VTop.mk
vtop_xml   := ./obj_dir/VTop.xml
vtop_stems := ./obj_dir/VTop.stems

CXX_SRC :=  $(LCX_HOME)/test/xdma_diff.cpp

$(vtop_mk):
	@echo "CXX_SRC=$(CXX_SRC)"
	@mkdir -p $(dir $@)
	$(VERILATOR) $(CXX_SRC) -cc --exe $(VERILATOR_FLAGS) $(VERILATOR_INPUT) >$@.out 2>$@.err
	find -L obj_dir -name "VTop.h" | xargs sed -i 's/private/public/g'
	find -L obj_dir -name "VTop.h" | xargs sed -i 's/const vlSymsp/vlSymsp/g'
	find -L obj_dir -name "VTop__Syms.h" | xargs sed -i 's/VlThreadPool\* const/VlThreadPool*/g'

build: $(vtop_mk) 
	$(MAKE) OBJCACHE="$(OBJCACHE)" CXXFLAGS="$(CXXFLAGS)" LDFLAGS="$(LDFLAGS)" LIBS="$(LIBS)" -C obj_dir -f $(COMMON_DIR)/Makefile_obj

run: build
	obj_dir/VTop

clean:
	rm -rf obj_dir/