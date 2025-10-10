#ifndef __RAM_H
#define __RAM_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <sys/mman.h>
#include <string>

#include "lsassert.h"
# define ELF_CLASS  ELFCLASS64
#include "elf.h"
#include "serial.h"
#include "irq.h"

using namespace std;

class RAM {
    uint8_t* base;
    FILE* debugcon;
    bool with_io = true;
    bool addr_loop = false;
    SerialState *ss = NULL;
    qemu_irq_handler cpu_irq_handler;
    string log_dir;
public:
    uint64_t size;

RAM(uint64_t size, string log_dir = ".");
~RAM();

void set_size(uint64_t size);
void set_io(bool with_io);
void set_addr_loop(bool addr_loop);
inline void check_addr(uint64_t& addr, uint64_t size, bool isload);
inline void loop_addr(uint64_t& addr);
bool check_io(uint64_t addr, uint64_t size);
uint64_t handle_io(uint64_t addr, uint64_t size, uint64_t data, bool isload);

uint8_t io_read8(uint64_t addr);
uint16_t io_read16(uint64_t addr);
uint32_t io_read32(uint64_t addr);
uint64_t io_read64(uint64_t addr);
void io_readn(uint64_t addr, void* dst, uint64_t num_bytes);
void io_write8(uint64_t addr, uint8_t data);
void io_write16(uint64_t addr, uint16_t data);
void io_write32(uint64_t addr, uint32_t data);
void io_write64(uint64_t addr, uint64_t data);
void io_writen(uint64_t addr, uint64_t data, uint64_t num_bytes);

uint8_t read8(uint64_t addr);
uint16_t read16(uint64_t addr);
uint32_t read32(uint64_t addr);
uint64_t read64(uint64_t addr);
void readn(uint64_t addr, void* dst, uint64_t num_bytes);
void readx(uint64_t addr, void* dst, bool is_cached, uint64_t full_addr, uint64_t num_bytes);
void write8(uint64_t addr, uint8_t data);
void write16(uint64_t addr, uint16_t data);
void write32(uint64_t addr, uint32_t data);
void write64(uint64_t addr, uint64_t data);
void writen(uint64_t addr, void* src, uint64_t num_bytes);
void writen(uint64_t addr, void* src, uint64_t num_bytes, uint64_t mask);

void ram_load_binary(uint64_t addr, const char *filename);
int ram_load_elf(const char *filename, uint64_t& entry_addr);
int ram_add_serial(qemu_irq irq);
int ram_load_serial(qemu_irq irq, const char* filename);
int ram_load_random_test(const char *dir);
void ram_set_cpu_irq(qemu_irq_handler handler);

void ram_update_io(void);

};

#endif //__RAM_H
