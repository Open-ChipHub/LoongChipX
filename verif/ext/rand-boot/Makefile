
CROSS_COMPILE = loongarch64-linux-gnu-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
AR = $(CROSS_COMPILE)ar
OBJDUMP = $(CROSS_COMPILE)objdump
OBJCOPY = $(CROSS_COMPILE)objcopy
SIZE = $(CROSS_COMPILE)size


### 
CFLAGS := -static -G0 -pipe -Wa,-mla-global-with-pcrel -g -O2 -fPIC
CFLAGS += -fno-stack-protector

LDFLAGS := -Ttext=0x8000000 -Map=link.map -static

compile:
	$(CC) $(CFLAGS) init_rand_boot.S -c -o init_rand_boot.o
	$(LD) $(LDFLAGS) init_rand_boot.o -o init_rand_boot
	$(OBJCOPY) -O binary init_rand_boot rand_boot.bin
	$(OBJDUMP) -ald init_rand_boot > init_rand_boot.obj.S


.PHONY: clean compile

clean:
	rm -rf init_rand_boot rand_boot.bin init_rand_boot.obj.S *.o link.map
