# Makefile Script

LCX_HOME := $(shell realpath ../)
$(info LCX_HOME=$(LCX_HOME))

# project name 
PROJECT = loongchipx
PROJECT_HOME = $(LCX_HOME)/impl
SYNTH_TOP_MODULE = soc_top_xlnx

# big little hybrid
# HETE_ARCH := little
HETE_ARCH := big
# HETE_ARCH := hybrid

# BOARD := vcu118
# BOARD := vcu129
BOARD := axvu13p
XILINX_BOARD := 
XILINX_PART  := 

# Here export this parameter, after we use then in vivado project 
export LCX_HOME
export PROJECT
export PROJECT_HOME
export BOARD
export SYNTH_TOP_MODULE
export HETE_ARCH

ifeq (, $(VIVADO))
$(info "VIVADO is not available, set env VIVADO (the default is vivado)")
VIVADO := vivado 
endif

VIVADO_BATCH = $(VIVADO) -mode batch -nojournal

WORKS := $(PROJECT_HOME)/work-xlnx
XILINX_IPS_DIR := $(LCX_HOME)/ip/amd

ifeq ($(BOARD), vcu129)
	XILINX_BOARD := xilinx.com:vcu129:part0:1.0
	XILINX_PART := xcvu29p-fsga2577-2L-e
else ifeq ($(BOARD), vcu118)
	XILINX_BOARD := xilinx.com:vcu118:part0:2.4
	XILINX_PART := xcvu9p-flga2104-2l-e
else ifeq ($(BOARD), axvu13p)
	XILINX_BOARD := #axvu13p
	XILINX_PART := xcvu13p-fhgb2104-2-i
else ifeq ($(BOARD), v709)
	XILINX_BOARD := xilinx.com:vc709:part0:1.8
	XILINX_PART := xc7vx690tffg1761-2
else 
	$(error ERROR: NOT MATCH BOARD Configuration)
endif

export XILINX_PART
export XILINX_BOARD

$(info project_home: $(PROJECT_HOME))

XILINX_IPS := 	axi_clock_converter.xci


ifeq ($(BOARD), vcu129)
	XILINX_IPS := xlnx_dwidth_converter.xci \
				  xlnx_clock_converter.xci \
	              xlnx_ddr4.xci  \
	              xlnx_gig_ethernet_pcs_pma.xci  \
	              xlnx_clk_wiz.xci

else ifeq ($(BOARD), vcu118)
	XILINX_IPS := xlnx_cpu_cconvt.xci \
				  xlnx_ddr4_cconvt.xci \
				  xlnx_ddr4_reset.xci \
				  xlnx_ddr4.xci \
				  xlnx_gig_ethernet_pcs_pma.xci \
				  xlnx_vio.xci 
else ifeq ($(BOARD), axvu13p)
	XILINX_IPS := xlnx_cpu_cconvt.xci \
				  xlnx_ddr4_cconvt.xci \
				  xlnx_ddr4_reset.xci \
				  xlnx_ddr4.xci \
				  xlnx_vio.xci 
endif

IPS := $(addprefix $(WORKS)/, $(XILINX_IPS))


all: compile gen_mcs

# Generate seperate project and get xci 
$(IPS): %.xci :	
	mkdir -p $(WORKS)
	@echo Generating $(@F)
	@cd $(XILINX_IPS_DIR)/$(basename $(@F)) && make compile_ip
	cp $(XILINX_IPS_DIR)/$(basename $(@F))/$(basename $(@F)).srcs/sources_1/ip/$(basename $(@F))/$(@F) $@


VIVADO_RUN_TCL := $(LCX_HOME)/scripts/run.tcl


compile: $(IPS)
	mkdir -p $(WORKS)
	rm -rf $(WORKS)/add_loongchipx_filelists.tcl
	$(LCX_HOME)/scripts/gen_vivado_lcx_filelsts.py
	cd $(WORKS) && $(VIVADO_BATCH) -source $(VIVADO_RUN_TCL)
	cd $(WORKS) && cp $(PROJECT).runs/impl_1/$(SYNTH_TOP_MODULE).* .

run_impl:
	cd $(WORKS) && $(VIVADO_BATCH) -source $(LCX_HOME)/scripts/open_run_impl.tcl
	cd $(WORKS) && cp $(PROJECT).runs/impl_1/$(SYNTH_TOP_MODULE).* .


LOADER_DIR     := $(PROJECT_HOME)/ext/loader
LOADER_ELE     := $(PROJECT_HOME)/ext/loader/loader.bin
LOADER_FILE    := bios.bin
LOADER_OFFSET  := 0x1c000000

KERNEL_ELF     := $(PROJECT_HOME)/ext/loader/vmlinux.bin
KERNEL_FILE    := vmlinux.ddr.bin
KERNEL_OFFSET  := 0x200000

UP_BIT_FILE := vmlinux.ddr.upload

LINUX_DIR := /home/airxs/user/cpu/system/linux/linux-6.10-labcore164


vmlinux:
	make -C $(LINUX_DIR) -j10
	make -C $(LOADER_DIR) clean
	make -C $(LOADER_DIR) KERNEL_DIR=$(LINUX_DIR)
	cd $(WORKS) && rm -rf $(UP_BIT_FILE) $(LOADER_FILE) $(KERNEL_FILE)
	cd $(WORKS) && cp $(LOADER_ELE) $(LOADER_FILE)
	cd $(WORKS) && cp $(KERNEL_ELF) $(KERNEL_FILE)
	cd $(WORKS) && $(LCX_HOME)/scripts/gen_upload_data.py \
					$(LOADER_FILE) $(LOADER_OFFSET) \
					$(KERNEL_FILE) $(KERNEL_OFFSET) \
					$(UP_BIT_FILE)

upload: vmlinux
	$(VIVADO_BATCH) -source $(LCX_HOME)/scripts/upload_bs_ddr_and_run.tcl -tclargs $(WORKS) $(SYNTH_TOP_MODULE) $(WORKS)/$(UP_BIT_FILE)


MCS := $(SYNTH_TOP_MODULE).mcs
BIT := $(SYNTH_TOP_MODULE).bit

gen_mcs: compile
	cd $(WORKS) && $(VIVADO_BATCH) -source $(LCX_HOME)/scripts/gen_mcs.tcl -tclargs $(MCS) $(BIT)

clean:
	rm -rf $(WORKS)/* $(WORKS)/.Xil .Xil
	make -C $(PROJECT_HOME)/ext/loader clean
	make -C $(LCX_HOME)/ip/amd/xlnx_clk_wiz clean
	make -C $(LCX_HOME)/ip/amd/xlnx_dconvt clean
	make -C $(LCX_HOME)/ip/amd/xlnx_cpu_cconvt clean
	make -C $(LCX_HOME)/ip/amd/xlnx_ddr4_cconvt clean
	make -C $(LCX_HOME)/ip/amd/xlnx_ddr4 clean
	make -C $(LCX_HOME)/ip/amd/xlnx_ddr4_reset clean
	make -C $(LCX_HOME)/ip/amd/xlnx_vio clean


.PHONY: compile clean
