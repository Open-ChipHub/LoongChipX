include ../../common/verilator.mk


VERILATOR_DEFINE += 

VERILATOR_SRC += 


# big little hybrid
HETE_ARCH := little
# HETE_ARCH := big
# HETE_ARCH := hybrid

ifeq ("$(HETE_ARCH)","big")
	VERILATOR_FILELISTS := $(VERIF_DIR)/filelists/verilator_bigcore_files.lst
	VCS_DEFINE += +define+CPU_SINGLE_RETIRE
else ifeq ("$(HETE_ARCH)","little")
	VERILATOR_FILELISTS := $(VERIF_DIR)/filelists/verilator_littlecore_files.lst
# else ifeq ("$(HETE_ARCH)","hybrid")
# 	VERILATOR_FILELISTS := $(VERIF_DIR)/filelists/vcs_hybrid_files.lst
else
$(error "We set HETE_ARCH (big, little, hybrid)")
endif


CONFIG  :=  $(VERIF_DIR)/config/config.kernel.checkpoint

sub-run:
	rm -rf board.h
	@if [ "${HETE_ARCH}" = "big" ]; then \
		echo "\`define HETE_ARCH_BIG 1" > board.h; \
	elif [ "${HETE_ARCH}" = "little" ]; then \
		echo "\`define HETE_ARCH_LITTLE 1" > board.h; \
	elif [ "${HETE_ARCH}" = "hybrid" ]; then \
		echo "\`define HETE_ARCH_HYBRID 1" > board.h; \
	fi