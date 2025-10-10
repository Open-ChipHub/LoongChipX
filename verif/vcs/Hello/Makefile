include ../../common/vcs.mk

CASE_NAME := simu-hello

CASE_BIN  := hello_world.bin



# VCS_FILELISTS

# big little hybrid
# HETE_ARCH := little
HETE_ARCH := big
# HETE_ARCH := hybrid

ifeq ("$(HETE_ARCH)","big")
	VCS_FILELISTS := $(VERIF_DIR)/filelists/vcs_bigcore_files.lst
	VCS_DEFINE += +define+CPU_SINGLE_RETIRE
else ifeq ("$(HETE_ARCH)","little")
	VCS_FILELISTS := $(VERIF_DIR)/filelists/vcs_littlecore_files.lst
else ifeq ("$(HETE_ARCH)","hybrid")
	VCS_FILELISTS := $(VERIF_DIR)/filelists/vcs_hybrid_files.lst
else
$(error "We set HETE_ARCH (big, little, hybrid)")
endif

