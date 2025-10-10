
CROSS_COMPILE = loongarch64-linux-gnu-
# CROSS_COMPILE = loongarch64-linux-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size

INCLUDES := -Iinclude -Iclib

### 
CCFLAGS := -static -G0 -pipe -Wa,-mla-global-with-pcrel -fPIC -g -O2

LDSTART ?= --defsym=MEM_START=0x1C000000

LDFLAGS += $(LDSTART) -Tlinker.script -Map=link.map -static -G0 

# LDFLAGS += --strip-all

# --gc-sections, we ignored all "Unnecessary* sections and symbols
# -u instead of all symbol are checked out 
# LDFLAGS += --gc-sections -u _start #

CCFLAGS +=  -fno-builtin #-nostdinc

##-----------------------------------------------------##
TEST_CASE = coremark#
##-----------------------------------------------------##

all: $(TEST_CASE).bin

# Generate libla.a
LA_LIB := libla.a

LIB_NEWLIB_SRC := printf.c #vasprintf.c #__thead_printf.c 
LIB_NEWLIB_SRC := $(addprefix newlib_wrap/, $(LIB_NEWLIB_SRC))
LIB_NEWLIB_OBJ := $(addsuffix .o, $(basename $(LIB_NEWLIB_SRC)))

LIB_CLIB_SRC := fputc.c string.c vtimer.c
LIB_CLIB_SRC := $(addprefix clib/, $(LIB_CLIB_SRC))
LIB_CLIB_OBJ := $(addsuffix .o, $(basename $(LIB_CLIB_SRC)))

LIB_CLIB_OBJ += utils/utils.o

# $(info $(LIB_NEWLIB_OBJ))
# $(info $(LIB_CLIB_OBJ))

$(LIB_NEWLIB_OBJ): %.o : %.c
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

$(LIB_CLIB_OBJ): %.o : %.c
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

LIB_OBJ := $(LIB_NEWLIB_OBJ) $(LIB_CLIB_OBJ)

lib_obj: $(LIB_NEWLIB_OBJ) $(LIB_CLIB_OBJ)
	$(AR) -r $(LA_LIB) $(LIB_OBJ)

crt:
	$(CC) $(CCFLAGS) -c crt/start.S -o crt/start.o


# TEST CoreMark
TEST_APP1_SRC := core_list_join.c core_util.c core_matrix.c \
                 core_portme.c core_state.c core_main.c

TEST_APP1_SRC := $(addprefix coremark/, $(TEST_APP1_SRC))
TEST_APP1_OBJ := $(addsuffix .o, $(basename $(TEST_APP1_SRC)))

$(TEST_APP1_OBJ): %.o : %.c
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

coremark.exe: lib_obj crt $(TEST_APP1_OBJ) 
	$(LD) $(LDFLAGS) -L. crt/start.o $(TEST_APP1_OBJ) -o $@ --start-group -lla --end-group
	$(OBJDUMP) -alD $@ > $@.S
	@echo "ELF SIZE DUMP:"
	@$(SIZE) $@ | tee $@.size

OBJCOPY_FLAGS := --set-section-flags .bss=alloc,load,contents \
				 --set-section-flags .stack=alloc,load,contents \
				 --set-section-flags .dymmy_exit=alloc,load,contents \
				 --set-section-flags .bss..page_aligned=alloc,load,contents
				 
$(TEST_CASE).bin: $(TEST_CASE).exe
	$(OBJCOPY) -O binary $< $@ $(OBJCOPY_FLAGS)
	$(OBJCOPY) -O binary $< $@.text -j .text*  -j .rodata* -j .eh_frame*
	$(OBJCOPY) -O binary $< $@.data -j .data*  -j .bss -j .COMMON


.PHONY: hello_world crt

clean:
	rm -rf $(LIB_OBJ) $(TEST_APP0_OBJ) $(TEST_APP1_OBJ) $(LA_LIB) \
	*.exe* link.map *.hex* *.pat *.bin*
