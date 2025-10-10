
CROSS_COMPILE = loongarch64-linux-gnu-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size

INCLUDES := -Iinclude -Iclib -I.

### 
CCFLAGS := -static -G0 -pipe -Wa,-mla-global-with-pcrel -fPIC -g -O0

LDFLAGS := -Tlinker.script -Map=link.map -static -G0 

LDFLAGS += --defsym=MEM_START=0x1C000000

# --gc-sections, we ignored all "Unnecessary* sections and symbols
# -u instead of all symbol are checked out 
# LDFLAGS += --gc-sections -u _start #

##-----------------------------------------------------##
TEST_CASE = simu-kernel#
##-----------------------------------------------------##

all: $(TEST_CASE).bin

KERNEL_DIR := /home/airxs/user/cpu/dev/system/linux/linux-6.10-labcore-rc1

vmlinux:
	cp $(KERNEL_DIR)/vmlinux .

payload_vmlinux: vmlinux
	readelf -l vmlinux | grep Entry | cut -d " " -f 3 > tmp.txt
	@echo "#ifndef _BL_ENRRY_CONFIG_H" > entry.h
	@echo "#define _BL_ENRRY_CONFIG_H" >> entry.h
	@echo -n "#define ENTRY_ADDR " >> entry.h
	@cat tmp.txt >> entry.h
	@echo "#endif" >> entry.h
	$(OBJCOPY) -O binary --set-section-flags .bss=alloc,load,contents $< $@


crt: payload_vmlinux
	$(CC) $(CCFLAGS) -I. -c crt/start.S -o crt/start.o

s0loader.bin:  crt  
	$(LD) $(LDFLAGS) -L. crt/start.o  -o s0loader.exe
	$(OBJCOPY) -O binary s0loader.exe $@ --set-section-flags .bss=alloc,load,contents
	$(OBJDUMP) -alD s0loader.exe > s0loader.exe.S
# 	@echo "ELF SIZE DUMP:"
# 	@$(SIZE) s0loader.exe | tee s0loader.exe.size

				 
$(TEST_CASE).bin: s0loader.bin 
	dd if=s0loader.bin of=$@ bs=1 count=50
	dd if=payload_vmlinux of=$@ bs=512 seek=2 skip=2
	chmod a+x $@


.PHONY: hello_world crt

clean:
	rm -rf s0loader.* *.exe* link.map tmp.txt \
	*.hex* *.pat *.bin* vmlinux payload_vmlinux
