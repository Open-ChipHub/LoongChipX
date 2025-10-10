#include "ram.h"
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include "commonprint.h"
#include "log.h"
#include "util.h"

#define ELF_LOAD_FAILED       -1
#define ELF_LOAD_NOT_ELF      -2
#define ELF_LOAD_WRONG_ARCH   -3
#define ELF_LOAD_WRONG_ENDIAN -4

extern uint64_t dbg_sim_cycles;

RAM::RAM(uint64_t size, string log_dir) {
    this->size = size;
    this->log_dir = log_dir;
    if (size) {
        this->base = (uint8_t*)mmap(nullptr, this->size, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
        if(this->base == MAP_FAILED) {
            perror("mmap");
        }
    }
    this->debugcon = fopen_nofail((log_dir + "/debugcon.txt").c_str(), "w");
}
RAM::~RAM() {
    munmap((void*)base, this->size);
    fclose(this->debugcon);
}

void RAM::set_size(uint64_t size) {
    lsassertm(!this->size, "size has been set\n");
    this->size = size;
    this->base = (uint8_t*)mmap(nullptr, this->size, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
    if(this->base == MAP_FAILED) {
        perror("mmap");
    }
    *(uint64_t*)(this->base + 0x1fe00008) = (1 << 2 | 1 << 3 | 1 << 4 | 1 << 11);
    *(uint64_t*)(this->base + 0x1fe00010) = *(uint64_t *)"Loongson-3A5000";
    *(uint64_t*)(this->base + 0x1fe00020) = *(uint64_t *)"3A5000" & 0xffffffffffffULL;;
    *(uint32_t*)(this->base + 0x10013ffc) = 0x80;

}

void RAM::set_io(bool with_io){
    this->with_io = with_io;
}

void RAM::set_addr_loop(bool addr_loop) {
    this->addr_loop = addr_loop;
}

inline void RAM::check_addr(uint64_t& addr, uint64_t size, bool isload) {
    /* error precdict load may has false addr, find it and set addr to zero */
    if (addr + size > this->size) {
        DEBUG(DEBUG_RAM,PRINT_DEBUG, "ram_size:%lx, addr:%lx size:%ld, is_load:%d\n", this->size, addr, size, isload);
        if (isload) {
            addr = 0;
        } else {
            DEBUG(DEBUG_RAM,PRINT_DEBUG, "store addr out of range\n");
            log_error("store addr out of range, ram_size:%lx, addr:%lx, size:%d\n", this->size, addr, size);
        addr = 0;
        }
    }
}

inline void RAM::loop_addr(uint64_t& addr) {
    if (this->addr_loop) {
        addr %= this->size;
    }
}

bool RAM::check_io(uint64_t addr, uint64_t size) {
    if (!this->with_io) {
        return false;
    }
    uint64_t end_addr = addr + size;
    if (addr >= 0x1fe00000 && addr <0x20000000) {
        if (end_addr > 0x1fe00000 && end_addr <=0x20000000) {
            DEBUG(DEBUG_RAM,PRINT_DEBUG,"io_addr:%lx, size:%ld\n", addr, size);
            return true;
        }
    }
    return false;
}
uint64_t RAM::handle_io(uint64_t addr, uint64_t size, uint64_t data, bool isload) {
    if (addr == 0x1fe002e0) {
        if (isload) {
            return 0xaa;
        } else {
            DEBUG(DEBUG_RAM,PRINT_DEBUG, "debugcon, %x %c\n", (int)data, (char)data);
            fprintf(this->debugcon, "%c", (char)data);
	        fflush(this->debugcon);

            return 0;
        }
    }
    return 0;
}

uint8_t RAM::io_read8(uint64_t addr) {
    lsassertm(0, "not implemented");
}
uint16_t RAM::io_read16(uint64_t addr){
    lsassertm(0, "not implemented");
}

uint32_t RAM::io_read32(uint64_t addr) {
    return handle_io(addr, 4, 0, true);
}
uint64_t RAM::io_read64(uint64_t addr) {
    return handle_io(addr, 8, 0, true);
}
void RAM::io_readn(uint64_t addr, void* dst, uint64_t num_bytes) {
    // lsassertm(0, "not implemented");
}

void RAM::io_write8(uint64_t addr, uint8_t data){
    handle_io(addr, 1, data, false);
}
void RAM::io_write16(uint64_t addr, uint16_t data){
    lsassertm(0, "not implemented");
}
void RAM::io_write32(uint64_t addr, uint32_t data) {
    handle_io(addr, 4, data, false);
}
void RAM::io_write64(uint64_t addr, uint64_t data) {
    handle_io(addr, 8, data, false);
}
void RAM::io_writen(uint64_t addr, uint64_t data, uint64_t num_bytes) {
    switch (addr) {
    case 0x1fe002e0:
        DEBUG(DEBUG_RAM,PRINT_DEBUG, "debugcon, %x %c\n", (int)data, (char)data);
        fprintf(this->debugcon, "%c", (char)data);
        fflush(this->debugcon);
        break;
    case 0x1fe001e0 ... 0x1fe001e7:
        lsassert(num_bytes == 1);
        serial_ioport_write((void*)this->ss, addr, data, 1);
        break;
    case 0x1FF10000 ... 0x1FF11000:
        serial_ioport_write((void*)this->ss, addr, data, 1);
        // printf("%c", (char)data);
        // fflush(stdout);
        break;
    case 0x1fe01004:
        break;
    case 0x1fe01048:
        break;
    default:
        log_error("unassigned memory write, addr:%lx\n", addr);
        break;
    }
    return;
}

uint8_t RAM::read8(uint64_t addr) {
    loop_addr(addr);
    if (check_io(addr, 1)) {
        return io_read8(addr);
    }
    check_addr(addr, 1, true);
    return *(uint8_t*)(base + addr);
}
uint16_t RAM::read16(uint64_t addr) {
    loop_addr(addr);
    if (check_io(addr, 2)) {
        return io_read16(addr);
    }
    check_addr(addr, 2, true);
    return *(uint16_t*)(base + addr);
}

uint32_t RAM::read32(uint64_t addr) {
    loop_addr(addr);
    if (check_io(addr, 4)) {
        return io_read32(addr);
    }
    check_addr(addr, 4, true);
    return *(uint32_t*)(base + addr);
}
uint64_t RAM::read64(uint64_t addr) {
    loop_addr(addr);
    if (check_io(addr, 8)) {
        return io_read64(addr);
    }
    check_addr(addr, 8, true);
    return *(uint64_t*)(base + addr);
}
void RAM::readn(uint64_t addr, void* dst, uint64_t num_bytes) {
    loop_addr(addr);
    if (check_io(addr, num_bytes)) {
        io_readn(addr, dst, num_bytes);
    }
    check_addr(addr, num_bytes, true);
    memcpy(dst, base + addr, num_bytes);
}

void RAM::readx(uint64_t addr, void* dst, bool is_cached, uint64_t full_addr, uint64_t num_bytes) {
    uint64_t r;
    loop_addr(addr);
    if (!is_cached) {
        if (check_io(full_addr, num_bytes)) {
            switch (full_addr) {
            case 0x1fe001e0 ... 0x1fe001e7:
                if(num_bytes != 1) {
                    log_error("serial read should be one byte, num_bytes:%ld", num_bytes);
                }
                r = serial_ioport_read((void*)this->ss, full_addr, 1);
                *((uint8_t*)dst + (full_addr & 0xf)) = (uint8_t)r;
                return;
            case 0x1FF10000 ... 0x1FF11000:
                if(num_bytes != 1) {
                    log_error("serial read should be one byte, num_bytes:%ld", num_bytes);
                }
                r = serial_ioport_read((void*)this->ss, full_addr, 1);
                *((uint8_t*)dst + (full_addr & 0xf)) = (uint8_t)r;
                return;
            case 0x1fe00008:
            case 0x1fe00010:
            case 0x1fe00020:
                break;
            default:
                printf("Error at: 0x%lx\n", dbg_sim_cycles);
                log_error("unassigned uncached memory read, addr:%lx\n", full_addr);
                break;
            }
        }
    }
    check_addr(addr, num_bytes, true);
    memcpy(dst, base + addr, 16);
}

void RAM::write8(uint64_t addr, uint8_t data) {
    loop_addr(addr);
    if (check_io(addr, 1)) {
        return io_write8(addr, data);
    }
    check_addr(addr, 1, false);
    *(uint8_t*)(base + addr) = data;
}
void RAM::write16(uint64_t addr, uint16_t data) {
    loop_addr(addr);
    if (check_io(addr, 2)) {
        return io_write16(addr, data);
    }
    check_addr(addr, 2, false);
    *(uint16_t*)(base + addr) = data;
}
void RAM::write32(uint64_t addr, uint32_t data) {
    loop_addr(addr);
    if (check_io(addr, 4)) {
        return io_write32(addr, data);
    }
    check_addr(addr, 4, false);
    *(uint32_t*)(base + addr) = data;
}
void RAM::write64(uint64_t addr, uint64_t data) {
    loop_addr(addr);
    if (check_io(addr, 8)) {
        return io_write64(addr, data);
    }
    check_addr(addr, 8, false);
    *(uint64_t*)(base + addr) = data;
}
void RAM::writen(uint64_t addr, void* src, uint64_t num_bytes) {
    // loop_addr(addr);
    // check_addr(addr, num_bytes, false);
    memcpy(base + addr, src, num_bytes);
}

void RAM::writen(uint64_t addr, void* src, uint64_t num_bytes, uint64_t mask) {
    lsassert(num_bytes <= 64);
    loop_addr(addr);
    if (check_io(addr, num_bytes)) {
        if (mask == 0) {
            log_error("mask should not be zero");
        }
        int size = __builtin_popcountll(mask);
        int disp = __builtin_ctzll(mask);
        // log_warn("mask:%lx, disp:%d, size:%d", mask, disp, size);
        uint64_t full_addr = addr + disp;
        uint64_t data;
        switch (size) {
        case 1: data = *(uint8_t*)((uint8_t*)src + disp); break;
        case 2: data = *(uint16_t*)((uint8_t*)src + disp); break;
        case 4: data = *(uint32_t*)((uint8_t*)src + disp); break;
        case 8: data = *(uint64_t*)((uint8_t*)src + disp); break;
        default:
            data = 'a';
            log_error("unsupported size %d\n", size);
            break;
        }
        return io_writen(full_addr, data, size);
    }
    check_addr(addr, num_bytes, false);
    for (size_t i = 0; i < num_bytes; i++)
    {
        if ((mask >> i) & 1) {
            *(uint8_t*)(base + addr + i) = *((uint8_t*)src + i);
        }
    }
}

static void *load_at(int fd, off_t offset, size_t size)
{
    void *ptr;
    if (lseek(fd, offset, SEEK_SET) < 0)
        return NULL;
    ptr = malloc(size);
    if (read(fd, ptr, size) != size) {
        free(ptr);
        return NULL;
    }
    return ptr;
}
void RAM::ram_load_binary(uint64_t addr, const char *filename) {
    FILE *fileptr;
    char *buffer;
    uint64_t filelen;

    fileptr = fopen(filename, "rb");  // Open the file in binary mode
    if (fileptr == NULL) {
        perror(filename);
        abort();
    }
    fseek(fileptr, 0, SEEK_END);          // Jump to the end of the file
    filelen = ftell(fileptr);             // Get the current byte offset in the file
    rewind(fileptr);                      // Jump back to the beginning of the file

    buffer = (char *)malloc(filelen * sizeof(char)); // Enough memory for the file
    lsassert(buffer);
    uint64_t r = fread(buffer, filelen, 1, fileptr); // Read in the entire file
    lsassert(r == 1);
    fclose(fileptr); // Close the file
    this->writen(addr, buffer, filelen);
    free(buffer); // Free the memory
}
int RAM::ram_load_elf(const char *filename, uint64_t& entry_addr) {
    int size, i, total_size;
    uint64_t mem_size, file_size;
    uint8_t e_ident[EI_NIDENT];
    uint8_t *data = NULL;
    int ret;
    struct elfhdr ehdr;     
    struct elf_shdr *symtab, *strtab, *shdr_table = NULL;
    struct elf_phdr *phdr = NULL, *ph;
    int fd = open(filename, O_RDONLY);
    if (fd < 0) {
        perror(filename);
        goto fail;
    }

    if (read(fd, e_ident, sizeof(e_ident)) != sizeof(e_ident))
        goto fail;
    if (e_ident[0] != ELFMAG0 ||
        e_ident[1] != ELFMAG1 ||
        e_ident[2] != ELFMAG2 ||
        e_ident[3] != ELFMAG3) {
        ret = ELF_LOAD_NOT_ELF;
        goto fail;
    }
    lsassert(e_ident[EI_CLASS] == ELFCLASS64);
    lseek(fd, 0, SEEK_SET);


    if (read(fd, &ehdr, sizeof(ehdr)) != sizeof(ehdr))
        goto fail;

    entry_addr = ehdr.e_entry;

    size = ehdr.e_phnum * sizeof(phdr[0]);
    if (lseek(fd, ehdr.e_phoff, SEEK_SET) != ehdr.e_phoff) {
        goto fail;
    }
    phdr = (struct elf_phdr *)malloc(size);
    if (!phdr)
        goto fail;
    if (read(fd, phdr, size) != size)
        goto fail;

    total_size = 0;
    for(i = 0; i < ehdr.e_phnum; i++) {
        ph = &phdr[i];
        if (ph->p_type == PT_LOAD) {
            mem_size = ph->p_memsz; /* Size of the ROM */
            file_size = ph->p_filesz; /* Size of the allocated data */
            data = (uint8_t*)malloc(file_size);
            if (ph->p_filesz > 0) {
                if (lseek(fd, ph->p_offset, SEEK_SET) < 0) {
                    goto fail;
                }
                if (read(fd, data, file_size) != file_size) {
                    goto fail;
                }
                this->writen(ph->p_paddr & 0xffffffff, data, file_size);
                DEBUG(DEBUG_RAM,PRINT_DEBUG, "%lx, %lx, \n", ph->p_paddr, file_size);
            }
        }
    }

fail:
    close(fd);
    return ret;
}


int RAM::ram_add_serial(qemu_irq irq) {
    lsassertm(this->ss == NULL, "serial has been initialized\n");
    this->ss = simple_serial_init(0x1FF10000, irq, 115200);
    return 0;
}

int RAM::ram_load_serial(qemu_irq irq, const char* filename) {
    lsassertm(this->ss == NULL, "serial has been initialized\n");
    this->ss = simple_serial_restore(0x1FF10000, irq, 115200, filename);
    return 0;
}

static FILE* open_res(const char* path) {
    FILE* f = fopen(path, "r");
    if (f == NULL) {
        perror(path);
        abort();
    }
    return f;
}

static void close_res(FILE* f) {
    int r = fclose(f);
    if (r != 0) {
        perror("fclose");
        abort();
    }
}

int RAM::ram_load_random_test(const char *dir) {
    char filename_buffer[1024];
    
    sprintf(filename_buffer, "%s/%s", dir, "initializer.res");
    FILE* initializer_res = open_res(filename_buffer);
    int inst;
    uint64_t pc = 0x1c000000;
    while (fscanf(initializer_res, "%x", &inst) == 1)
    {
        this->write32(pc, inst);
        pc += 4;
    }
    fclose(initializer_res);
    /* jirl zero, zero, 0 */
    this->write32(pc, 0x4c000000);


    sprintf(filename_buffer, "%s/%s", dir, "instruction.res");
    FILE* instruction_res = open_res(filename_buffer);
    char first_line[100];
    fscanf(instruction_res, "%s", first_line);
    lsassert(first_line[0] == '@' && first_line[1] == '0' && first_line[2] == '0');
    int b0, b1, b2, b3, b4, b5, b6, b7;
    pc = 0;
    while (fscanf(instruction_res, "%x%x%x%x%x%x%x%x", &b0, &b1, &b2, &b3, &b4, &b5, &b6, &b7) == 8)
    {
        inst = b0 | (b1 << 8) | (b2 << 16) | (b3 << 24);
        if (inst == 0x002b0000) {
            inst = 0x50000000;
        }
        this->write32(pc, inst);
        pc += 4;
    }
    fclose(instruction_res);

    /* branch to self */
    this->write32(pc, 0x50000000);

    sprintf(filename_buffer, "%s/%s", dir, "data_init_addr.res");
    FILE* data_init_addr_res = open_res(filename_buffer);

    sprintf(filename_buffer, "%s/%s", dir, "data_init_data.res");
    FILE* data_init_data_res = open_res(filename_buffer);
    uint64_t data_count;
    fscanf(data_init_addr_res, "%lx", &data_count);
    fscanf(data_init_data_res, "%s", first_line);
    lsassert(first_line[0] == '@' && first_line[1] == '0' && first_line[2] == '0');

    uint64_t data_addr;
    /* uint8_t */
    uint64_t data_data;
    while (fscanf(data_init_addr_res, "%lx", &data_addr) == 1 && fscanf(data_init_data_res, "%lx", &data_data) == 1) {
        fprintf(stderr, "%lx:%lx\n",data_addr,  data_data);
        *(uint8_t*)(this->base + data_addr) = (uint8_t)data_data;
        -- data_count;
    }
    lsassertm(data_count == 0, "data_count:%ld\n", data_count);
    fclose(data_init_addr_res);
    fclose(data_init_data_res);
    return 0;
}


void RAM::ram_set_cpu_irq(qemu_irq_handler handler) {
    this->cpu_irq_handler = handler;
}

void RAM::ram_update_io(void) {
    serial_check_io(this->ss);
}
