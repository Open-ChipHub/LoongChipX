VCS = vcs

LCX_HOME := $(shell realpath ../../../)
$(info LCX_HOME=$(LCX_HOME))
export LCX_HOME

VERIF_DIR  := $(LCX_HOME)/verif
COMMON_DIR := $(LCX_HOME)/verif/common

VCS_COMPILE_OPTS := -cpp g++ \
                    -cc gcc \
                    -LDFLAGS -Wl,--no-as-needed

VCS_FLAGS := -sverilog -full64 $(VCS_COMPILE_OPTS) -kdb -lca \
			 -debug_acc+all -debug_access \
			 +nospecify +notimingchecks   \
			 +vc

## NOTING: +vcs+initreg+random
## this parameter indicates that vcs will initialize all 
## registers by value 0.
VCS_FLAGS += +vcs+initreg+random +lint=TFIPC-L

VCS_DEFINE := +define+VERDI_DUMP #+define+NO_WAVE_DUMP_DEBUG
VCS_DEFINE += +define+VCS_SIM

VCS_FILELISTS ?= $(VERIF_DIR)/filelists/vcs_files.lst


VCS_DPI_HOME := $(VERIF_DIR)/ext/dpi
VCS_DPI_SRC  :=  axi.cpp  log.cpp  ram.cpp  sim.cpp
VCS_DPI_SRC  :=  elfloader.cc
VCS_DPI_SRC  := $(addprefix $(VCS_DPI_HOME)/, $(VCS_DPI_SRC))
VCS_DPI_SRC  := 


SIM_TOP_NAME := soc_top
VCS_FLAGS += -top $(SIM_TOP_NAME)


all: sim

# compile all cxx, load dpi.so by shared dynamic library
CC = g++
LIB_DPI_OBJ := $(addsuffix .o, $(basename $(VCS_DPI_SRC)))
VCS_INC := $(VCS_HOME)/include
CCFLAGS = -fPIC -Wall

$(LIB_DPI_OBJ): %.o : %.cpp
	$(CC) $(CCFLAGS) -I$(VCS_INC) -c $< -o $@

dpi:$(LIB_DPI_OBJ)
	gcc -fPIC -shared $(CFLAGS) $(LIB_DPI_OBJ) -o libsysdpi.so

# big little hybrid
HETE_ARCH ?= little

VCS_DEFINE += +define+MMU_ON

CASE_NAME ?= simu-coremark-mmu
CASE_BIN  ?= coremark.bin

TEST_CASE ?= $(VERIF_DIR)/ext/$(CASE_NAME)/$(CASE_BIN)
TEST_CASE_RAM := testcase_ram.bin

simu:
	@make -C $(VERIF_DIR)/ext/$(CASE_NAME) clean
	@make -C $(VERIF_DIR)/ext/$(CASE_NAME)
	#dd if=/dev/zero of=testcase.bin bs=1M count=1
	cat $(TEST_CASE) > $(TEST_CASE_RAM)
	$(LCX_HOME)/scripts/gen_axi_ram.py  $(TEST_CASE_RAM)

compile: simu 
	$(VCS) $(VCS_FLAGS) $(VCS_DEFINE) -f $(VCS_FILELISTS) $(VCS_DPI_SRC)
	./simv -verdi 

sim: simu
	$(VCS) $(VCS_FLAGS) $(VCS_DEFINE) -f $(VCS_FILELISTS) $(VCS_DPI_SRC)
	./simv #+vcs+initreg+0

VERDI := verdi

ifneq ("$(wildcard novas.rc)","")
VERDI_OPTS := -sv -rcFile novas.rc -guiConf novas.conf
else
VERDI_OPTS := -sv
endif

VERDI_OPTS += -ssy -ssv -ssf


WAVE := soc_top.fsdb

verdi:
	$(VERDI) $(VERDI_OPTS) $(WAVE) -top $(SIM_TOP_NAME) -f $(VCS_FILELISTS) -nologo > /dev/null &


.PHONY: vmlinux vmlinux.bin

clean:
	rm -rf simv.daidir csrc simv ucli* *.fsdb* \
	verdiLog inter.* *.log *.pat *.hex *.img .vcs* \
	*.so stack.info* vmlinux* *exe.report* *.bin
