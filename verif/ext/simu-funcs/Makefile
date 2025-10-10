
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

LDFLAGS := -Tlinker.script -Map=link.map -static -G0 

# LDFLAGS += --strip-all
LDFLAGS += --defsym=MEM_START=0x1C000000

# --gc-sections, we ignored all "Unnecessary* sections and symbols
# -u instead of all symbol are checked out 
# LDFLAGS += --gc-sections -u _start #

CCFLAGS +=  -fno-builtin #-nostdinc

##-----------------------------------------------------##
TEST_CASE = test_func#
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

LIB_CLIB_OBJ += utils/utils.o mmu/pagetable.o

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


TEST_FUNCS_SRC := func_main.S func_alu.S func_fpu.S \
                  func_lsu.S func_csr.S func_misc.S \
                  func_expt.S

TEST_FUNCS_SRC := $(addprefix funcs/, $(TEST_FUNCS_SRC))
TEST_FUNCS_OBJ := $(addsuffix .o, $(basename $(TEST_FUNCS_SRC)))


$(TEST_FUNCS_OBJ): %.o : %.S
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@

$(TEST_CASE).exe: lib_obj crt $(TEST_FUNCS_OBJ) 
	$(LD) $(LDFLAGS) -L. crt/start.o $(TEST_FUNCS_OBJ) -o $@ --start-group -lla --end-group
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
	rm -rf $(LIB_OBJ) $(TEST_FUNCS_OBJ) $(LA_LIB) \
	*.exe* link.map *.hex* *.pat *.bin*
