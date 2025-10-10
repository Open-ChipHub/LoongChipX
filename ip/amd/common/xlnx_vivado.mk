ifeq ($(VIVADO),)
	$(info "VIVADO is not available, set env VIVADO (the default is vivado)")
	VIVADO := vivado 
endif

CURR_PRJ ?= 

all: compile_ip

VIVADO_BATCH := $(VIVADO) -mode batch -nojournal -nolog

compile_ip:
	$(VIVADO_BATCH) -source config/conf.tcl

clean:
	rm -rf *.log *.jou *.str *.hw *.ip_user_files *.xpr *.cache *.gen *.runs *.srcs


