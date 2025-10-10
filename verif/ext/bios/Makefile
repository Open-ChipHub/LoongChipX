
CROSS_COMPILE = loongarch64-linux-gnu-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size

INCLUDES := -Iinclude

### 
CCFLAGS := -static -G0 -pipe -Wa,-mla-global-with-pcrel -fno-builtin -g -O2
CFLAGS := -static -G0 -pipe -Wa,-mla-global-with-pcrel -fno-builtin -g -O2

LDFLAGS := -Tsrc/lscript.ld -melf64loongarch -nostdlib -Map=link.map -static -G0 

# LDFLAGS += --strip-all
LDFLAGS += -e 0x1C000000

CCFLAGS += -Wint-to-pointer-cast #-mcmodel=large
CFLAGS += -Wint-to-pointer-cast #-mcmodel=large

# --gc-sections, we ignored all "Unnecessary* sections and symbols
# -u instead of all symbol are checked out 
LDFLAGS += --gc-sections -u _start


all: all_obj

# Generate libplatform.a
LA_LIB := libplatform.a

LIB_SPILIB_SRC := xspi.c  \
					xspi_g.c xspi_options.c  \
					xspi_selftest.c  \
					xspi_sinit.c  \
					xspi_stats.c 
LIB_SPILIB_SRC := $(addprefix libsrc/spi_v4_9/src/, $(LIB_SPILIB_SRC))
LIB_SPILIB_OBJ := $(addsuffix .o, $(basename $(LIB_SPILIB_SRC)))

LIB_UARTLIB_SRC := xuartns550.c \
					xuartns550_l.c \
					xil_printf.c \
					outbyte.c \
					print.c \
					putnum.c 

LIB_UARTLIB_SRC := $(addprefix libsrc/uartns550_v3_8/src/, $(LIB_UARTLIB_SRC))
LIB_UARTLIB_OBJ := $(addsuffix .o, $(basename $(LIB_UARTLIB_SRC)))


LIB_UTILLIB_SRC := string.c \
					snprintf.c
LIB_UTILLIB_SRC := $(addprefix libsrc/util/, $(LIB_UTILLIB_SRC))
LIB_UTILLIB_OBJ := $(addsuffix .o, $(basename $(LIB_UTILLIB_SRC)))


$(LIB_SPILIB_OBJ): %.o : %.c
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

$(LIB_UARTLIB_OBJ): %.o : %.c
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

$(LIB_UTILLIB_OBJ): %.o : %.c
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

LIB_OBJ := $(LIB_SPILIB_OBJ) $(LIB_UARTLIB_OBJ) $(LIB_UTILLIB_OBJ)

lib_obj: $(LIB_SPILIB_OBJ) $(LIB_UARTLIB_OBJ) $(LIB_UTILLIB_OBJ)
	$(AR) -r $(LA_LIB) $(LIB_OBJ)


start.o:
	$(CC) $(CCFLAGS) $(INCLUDES) -c crt/start.S -o $@



##-----------------------------------------------------##
BIOS_NAME = bios#
##-----------------------------------------------------##

all_obj: $(BIOS_NAME)

APP0_SRC := bootloader.c platform.c
APP0_SRC := $(addprefix src/, $(APP0_SRC))
APP0_OBJ := $(addsuffix .o, $(basename $(APP0_SRC)))

$(APP0_OBJ): %.o : %.c
	$(CC) $(CFLAGS) $(INCLUDES) -c $< -o $@

$(BIOS_NAME).exe: lib_obj $(APP0_OBJ) start.o
	$(LD) $(LDFLAGS) -L. start.o $(APP0_OBJ) -lplatform -o $@ 
	$(OBJDUMP) -alD $@ > $@.S
	@echo "ELF SIZE DUMP:"
	@$(SIZE) $@ | tee $@.size

$(BIOS_NAME).hex: $(BIOS_NAME).exe
	$(OBJCOPY) -O binary $< $@
	$(OBJCOPY) -O binary $< $@.text -j .text*  -j .rodata* -j .eh_frame*
	$(OBJCOPY) -O binary $< $@.data -j .data*  -j .bss -j .COMMON


$(BIOS_NAME): $(BIOS_NAME).hex
	bin/convert $(BIOS_NAME).hex.text $(BIOS_NAME).hex.data


.PHONY: $(BIOS_NAME) crt

clean:
	rm -rf $(APP0_OBJ) *.exe* link.map \
		*.hex* *.pat *.mif *.coe *.vlog \
		libsrc/uartns550_v3_8/src/*.o \
		libsrc/spi_v4_9/src/*.o src/*.o \
		start.o libplatform.a *.log $(LIB_OBJ)

