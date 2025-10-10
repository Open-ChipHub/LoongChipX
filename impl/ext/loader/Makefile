
CROSS_COMPILE = loongarch64-linux-gnu-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size

INCLUDES := -Ibl -I.

### 
CCFLAGS := -static -G0 -pipe -Wa,-mla-global-with-pcrel -g -O2 -fPIC
CCFLAGS += -DMEM_START=0x900000001C000000 -fno-stack-protector -DBL_PAYLOAD=\"vmlinux.bin\"

LDFLAGS := -Tlink.lds -Map=link.map -static

LDFLAGS += --defsym=MEM_START=0x900000001C000000
LDFLAGS += --defsym=KERNEL_START=0x900000001C000000

# --gc-sections, we ignored all "Unnecessary* sections and symbols
# -u instead of all symbol are checked out 
# LDFLAGS += --gc-sections -u _start #

KERNEL_DIR ?= /home/airxs/user/cpu/dev/system/linux/linux-6.10-labcore164

##-----------------------------------------------------##
BIOS_NAME = loader#
##-----------------------------------------------------##


all: $(BIOS_NAME).bin


OBJ = start.o dbg_uart.o

start.o: payload_vmlinux
	$(CC) $(CCFLAGS) -D__ASSEMBLY__ -c start.S -o start.o

dbg_uart.o: dbg_uart.c
	$(CC) $(CCFLAGS) -D__ASSEMBLY__ -c dbg_uart.c -o dbg_uart.o

payload.o: payload_vmlinux
	$(CC) $(CCFLAGS) $(INCLUDES) -D__ASSEMBLY__ payload.S -c -o $@

vmlinux:
	cp $(KERNEL_DIR)/vmlinux .
	$(OBJCOPY) -O binary vmlinux vmlinux.bin


payload_vmlinux: vmlinux
	readelf -l vmlinux | grep Entry | cut -d " " -f 3 > tmp.txt
	@echo "#ifndef _BL_ENRRY_CONFIG_H" > entry.h
	@echo "#define _BL_ENRRY_CONFIG_H" >> entry.h
	@echo " " >> entry.h
	@echo -n "#define KERNEL_ENTRY " >> entry.h
	@cat tmp.txt >> entry.h
	@echo " " >> entry.h
	@echo "#endif" >> entry.h


$(BIOS_NAME).exe: $(OBJ)
	$(LD) $(LDFLAGS) -L. $(OBJ) -o $@ 
	$(OBJDUMP) -ald $@ > $@.S
	@echo "ELF SIZE DUMP:"
	@$(SIZE) $@ | tee $@.size


$(BIOS_NAME).bin: $(BIOS_NAME).exe
	$(OBJCOPY) -O binary $< $@
# 	dd if=vmlinux.bin of=$@ bs=1024 skip=1 seek=1

.PHONY: $(BIOS_NAME).exe

clean:
	rm -rf  $(BIOS_NAME).exe* link.map \
	*.hex* *.pat *.coe *.mif *.vlog *.o \
	$(BIOS_NAME).bin* payload_vmlinux \
	vmlinux* la320.dtb tmp.txt
