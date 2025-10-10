#include "initialize.h"
#include "util.h"
#include "loongarch_state.h"
#include "irq.h"

#define LOWMEM_BEGIN 0
#define LOWMEM_SIZE 0x10000000
#define HIGHMEM_BEGIN 0x90000000ul
#define HIGHMEM_SIZE 0xf0000000ul

#define CKP_RAM_SIZE 0x100000000

#define __4KB 0x1000

void* fread_all_nofail(const char *__restrict __filename, int64_t* size) {
    FILE *f = fopen_nofail(__filename, "rb");
    fseek(f, 0, SEEK_END);
    int64_t fsize = ftell(f);
    fseek(f, 0, SEEK_SET);  /* same as rewind(f); */

    void *string = malloc(fsize + 1);
    assert(fread(string, fsize, 1, f) == 1);
    fclose(f);
    *size = fsize;
    return string;
}

uint64_t xor_sum(const void* buf, uint64_t size) {
    assert(size % __4KB == 0);
    uint64_t r = 0;
    for(uint64_t addr = 0; addr < size; addr += 8) {
        r ^= *(uint64_t*)((char*)buf + addr);
    }
    return r;
}

// size was fixed
uint64_t simple_decompress(const char* filename, uint64_t base_addr, uint64_t size, RAM* ram) {
    assert(size % __4KB == 0);
    int64_t input_size;
    void* input_buf =  fread_all_nofail(filename, &input_size);
    uint64_t index = 0;
    uint64_t xs = 0;
    for(uint64_t addr = 0; addr < size; addr += __4KB) {
        ram->writen(base_addr + addr, (uint8_t*)input_buf + index, __4KB);
        xs ^= xor_sum((uint8_t*)input_buf + index, __4KB);
        index += __4KB;
        // zero page need not copy
    }
    printf("my:%lx input:%lx\n", xs, *(int64_t *)((uint8_t*)input_buf + index));
    printf("index:%lx, input_size:%lx\n", index, input_size);
    // assert(xs == *(int64_t *)((uint8_t*)input_buf + index));
    // assert(index + 8 == input_size);
    free(input_buf);
    return xs;
}

std::string image_dir;
extern bool checkpoint;
void sim_initialize(Config& config, const SimConfig& sim_cfg, RAM& ram, rand64& random_test){
    if (sim_cfg.load_image) {
        checkpoint = true;
        ram.set_size(2ull << 32);
        image_dir = config.get_value("image_dir");
        log_info("load image, from directory \"%s\"", image_dir.c_str());
        // simple_decompress((image_dir + "/lowmem.c.bin").c_str(), LOWMEM_BEGIN, LOWMEM_SIZE, &ram);
        simple_decompress((image_dir + "/checkpoint_ram.bin").c_str(), 0, CKP_RAM_SIZE, &ram);

        FILE *reg_file = fopen_nofail((image_dir + "/checkpoint_csr.bin").c_str(), "rb");
        // load state from binary
        LOONGARCH_RTL_STATE la_state;
        lsassert(fread(&la_state, sizeof(la_state), 1, reg_file) == 1);
        fclose(reg_file);
        if ((int64_t)la_state.CSR_CNTC < 0) {
            la_state.CSR_CNTC = 0;
        }
        loongarch_rtl_state_dump(&la_state, stderr);
        // restore cpu in-core states
        uint64_t base_offset = 0;
        // invalide all tlb entries
        ram.write32(0x1c000000 + base_offset + 0 * 4, 0x06498000);
        base_offset += 4;
        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);

#if 0
        // restore stable counter (preparation)
        ram.write32(0x1c000000 + base_offset + 0 * 4, 0x14000000 | ((icount >> 12) & 0xfffff) <<  5 | 2         ); // lu12i.w $r2,pc
        ram.write32(0x1c000000 + base_offset + 1 * 4, 0x03800000 | ((icount >>  0) &   0xfff) << 10 | 2 | 2 << 5); // ori     $r2,$r2,pc
        ram.write32(0x1c000000 + base_offset + 2 * 4, 0x16000000 | ((icount >> 32) & 0xfffff) <<  5 | 2         ); // lu32i.d $r2,pc
        ram.write32(0x1c000000 + base_offset + 3 * 4, 0x03000000 | ((icount >> 52) &   0xfff) << 10 | 2 | 2 << 5); // lu52i.d $r2,$r2,pc
        ram.write32(0x1c000000 + base_offset + 4 * 4, 0x04000020 | (0x1002 << 10) | 2); // csrwr $r2,0x1000
        base_offset += 5*4;
#endif
        // restore cpu pc (preparation)
        ram.write32(0x1c000000 + base_offset + 0 * 4, 0x14000000 | ((la_state.PC >> 12) & 0xfffff) <<  5 | 2         ); // lu12i.w $r2,pc
        ram.write32(0x1c000000 + base_offset + 1 * 4, 0x03800000 | ((la_state.PC >>  0) &   0xfff) << 10 | 2 | 2 << 5); // ori     $r2,$r2,pc
        ram.write32(0x1c000000 + base_offset + 2 * 4, 0x16000000 | ((la_state.PC >> 32) & 0xfffff) <<  5 | 2         ); // lu32i.d $r2,pc
        ram.write32(0x1c000000 + base_offset + 3 * 4, 0x03000000 | ((la_state.PC >> 52) &   0xfff) << 10 | 2 | 2 << 5); // lu52i.d $r2,$r2,pc
        ram.write32(0x1c000000 + base_offset + 4 * 4, 0x04000020 | (0x133 << 10) | 2); // csrwr $r2,0x133
        base_offset += 5*4;

        // restore cpu pc (preparation)
        ram.write32(0x1c000000 + base_offset + 0 * 4, 0x14000000 | ((la_state.CSR_CRMD >> 12) & 0xfffff) <<  5 | 2         ); // lu12i.w $r2,pc
        ram.write32(0x1c000000 + base_offset + 1 * 4, 0x03800000 | ((la_state.CSR_CRMD >>  0) &   0xfff) << 10 | 2 | 2 << 5); // ori     $r2,$r2,pc
        ram.write32(0x1c000000 + base_offset + 2 * 4, 0x16000000 | ((la_state.CSR_CRMD >> 32) & 0xfffff) <<  5 | 2         ); // lu32i.d $r2,pc
        ram.write32(0x1c000000 + base_offset + 3 * 4, 0x03000000 | ((la_state.CSR_CRMD >> 52) &   0xfff) << 10 | 2 | 2 << 5); // lu52i.d $r2,$r2,pc
        ram.write32(0x1c000000 + base_offset + 4 * 4, 0x04000020 | (0x12f << 10) | 2); // csrwr $r2,0x133
        base_offset += 5*4;

        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);

        // restore cpu csr
        chkpt_csr_restore(&ram,&base_offset,&la_state);
        // restore cpu general purpose register

        // float
        for(int i=0; i<32;i++){
            ram.write32(0x1c000000 + base_offset + i*5*4 + 0*4, 0x14000000 | ((la_state.fpr[i].val64[0] >> 12) & 0xfffff) <<  5 | 2         ); // lu12i.w $i,gpr
            ram.write32(0x1c000000 + base_offset + i*5*4 + 1*4, 0x03800000 | ((la_state.fpr[i].val64[0] >>  0) &   0xfff) << 10 | 2 | 2 << 5); // ori     $i,$i,gpr
            ram.write32(0x1c000000 + base_offset + i*5*4 + 2*4, 0x16000000 | ((la_state.fpr[i].val64[0] >> 32) & 0xfffff) <<  5 | 2         ); // lu32i.d $i,gpr
            ram.write32(0x1c000000 + base_offset + i*5*4 + 3*4, 0x03000000 | ((la_state.fpr[i].val64[0] >> 52) &   0xfff) << 10 | 2 | 2 << 5); // lu52i.d $i,$i,gpr
            ram.write32(0x1c000000 + base_offset + i*5*4 + 4*4, 0x0114a800 | 2 << 5 | i); // movgr2fr.d $i(fix), $i(float)
        }
        base_offset += 32*5*4;
        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);
        
        // fcc
        for(int i=0; i<8;i++){
            ram.write32(0x1c000000 + base_offset + i*2*4 + 0*4, 0x03800000 | ((la_state.cf[i] >>  0) &   0xfff) << 10 | 0 | 2 << 5); // ori     $i,$0,gpr
            ram.write32(0x1c000000 + base_offset + i*2*4 + 1*4, 0x0114d800 | 2 << 5 | i); // movgr2cf $i(fix), $i(float)
        }
        base_offset += 8*2*4;
        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);
        
        // fcsr
        ram.write32(0x1c000000 + base_offset + 0*4, 0x14000000 | ((la_state.fcsr0 >> 12) & 0xfffff) <<  5 | 31          );  // lu12i.w $31,gpr
        ram.write32(0x1c000000 + base_offset + 1*4, 0x03800000 | ((la_state.fcsr0 >>  0) &   0xfff) << 10 | 31 | 31 << 5); // ori     $31,$31,gpr
        ram.write32(0x1c000000 + base_offset + 2*4, 0x114c0000 | 31 << 5 | 0); // movgr2fcsr $31(fix), $0(fcsr)
        base_offset += 1*3*4;

        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);

        uint64_t long_jump_pc = 0x900000001c000000 + base_offset + 5*4;
        ram.write32(0x1c000000 + base_offset + 0*4, 0x14000000 | ((long_jump_pc >> 12) & 0xfffff) <<  5 | 0xc); //    lu12i.w $r12,-349526(0xaaaaa)
        ram.write32(0x1c000000 + base_offset + 1*4, 0x03800000 | ((long_jump_pc >>  0) &   0xfff) << 10 | 0xc | 0xc << 5 ); //    ori     $r12,$r12,0xaaa
        ram.write32(0x1c000000 + base_offset + 2*4, 0x16000000 | ((long_jump_pc >> 32) & 0xfffff) <<  5 | 0xc ); //    lu32i.d $r12,-349526(0xaaaaa)
        ram.write32(0x1c000000 + base_offset + 3*4, 0x03000000 | ((long_jump_pc >> 52) &   0xfff) << 10 | 0xc | 0xc << 5 ); //    lu52i.d $r12,$r12,-1366(0xaaa)
        ram.write32(0x1c000000 + base_offset + 4*4, 0x4c000180); //    jirl    $r0,$r12,0
        base_offset += 5*4;

        /// restore cpu crmd csr and trun on mmu
        /// FIXME: when restore crmd upto user mode, the following code
        ///        which running at address: 0x900000001c000000, it will
        ///        raise an address exception and abort
        ///        so, we use cpsr inst restore pc and crmd(csr 0x12f) meanwhile. 
        /// chkpt_csr_crmd_restore(&ram,&base_offset,&la_state);

        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);
        // fix
        for(int i=1; i<32;i++){
            ram.write32(0x1c000000 + base_offset + (i-1)*4*4 + 0*4, 0x14000000 | ((la_state.gpr[i] >> 12) & 0xfffff) <<  5 | i         ); // lu12i.w $i,gpr
            ram.write32(0x1c000000 + base_offset + (i-1)*4*4 + 1*4, 0x03800000 | ((la_state.gpr[i] >>  0) &   0xfff) << 10 | i | i << 5); // ori     $i,$i,gpr
            ram.write32(0x1c000000 + base_offset + (i-1)*4*4 + 2*4, 0x16000000 | ((la_state.gpr[i] >> 32) & 0xfffff) <<  5 | i         ); // lu32i.d $i,gpr
            ram.write32(0x1c000000 + base_offset + (i-1)*4*4 + 3*4, 0x03000000 | ((la_state.gpr[i] >> 52) &   0xfff) << 10 | i | i << 5); // lu52i.d $i,$i,gpr
        }
        base_offset += 31*4*4;

        // restore cpu pc (trigger)
        printf("base_offset(pc): 0x%08lx, %3d\n", base_offset, __LINE__);
        ram.write32(0x1c000000 + base_offset, 0x06490000); // cprs 
    }
    else if (sim_cfg.run_random) {
#ifndef CONFIG_INSN_TRACE
        log_fatal("random test must define CONFIG_INSN_TRACE");
        return 1;
#endif
        random_test.enable = true;
        random_test.fpr_bits =  config.has_key("fpr_bits") ? atoi(config.get_value("fpr_bits").c_str()) : 0;
        ram.set_size(1ull << 34);
        ram.set_io(false);
        ram.set_addr_loop(true);

        random_test.mat_type  = sim_cfg.random_test_mat;
        random_test.fill_type = sim_cfg.random_fill_type;
        log_info("Using random test seed:%d", sim_cfg.random_test_seed);
        random_test.reseed(sim_cfg.random_test_seed);

        random_test.load_raw(config.get_value("random_test_dir").c_str());
        random_test.with_tlb = true;
        random_test.setupRAM(&ram);
        // ram.ram_load_random_test(config.get_value("random_test_dir").c_str());
    } else {
        ram.set_size(2ull << 32);
        uint64_t entry_addr;
        ram.ram_load_elf(static_cast<const char *>(config.get_value("kernel").c_str()), entry_addr);
        
        log_info("kernel :%s\n", config.get_value("kernel").c_str());
        
        if (config.has_key("bios_mode") && config.get_value("bios_mode").compare("auto") == 0) {
            log_info("auto gen bios, entry at %lx", entry_addr);
            ram.write32(0x1c000000 + 0  * 4, 0x04003020); //    csrwr   $r0,0xc
            ram.write32(0x1c000000 + 1  * 4, 0x04022020); //    csrwr   $r0,0x88
            ram.write32(0x1c000000 + 2  * 4, 0x14000000 | ((entry_addr >> 12) & 0xfffff) <<  5 | 0xc); //    lu12i.w $r12,-349526(0xaaaaa)
            ram.write32(0x1c000000 + 3  * 4, 0x03800000 | ((entry_addr >>  0) &   0xfff) << 10 | 0xc | 0xc << 5 ); //    ori     $r12,$r12,0xaaa
            ram.write32(0x1c000000 + 4  * 4, 0x16000000 | ((entry_addr >> 32) & 0xfffff) <<  5 | 0xc ); //    lu32i.d $r12,-349526(0xaaaaa)
            ram.write32(0x1c000000 + 5  * 4, 0x03000000 | ((entry_addr >> 52) &   0xfff) << 10 | 0xc | 0xc << 5 ); //    lu52i.d $r12,$r12,-1366(0xaaa)
            ram.write32(0x1c000000 + 6  * 4, 0x00150004); //    move    $r4,$r0
            ram.write32(0x1c000000 + 7  * 4, 0x00150005); //    move    $r5,$r0
            ram.write32(0x1c000000 + 8  * 4, 0x00150006); //    move    $r6,$r0
            ram.write32(0x1c000000 + 9  * 4, 0x00150007); //    move    $r7,$r0
            // Prevent from x signals
            ram.write32(0x1c000000 + 10 * 4, 0x04000020 | (0x18 << 10)); // csrwr $r0,0x18 
            ram.write32(0x1c000000 + 11 * 4, 0x04000020 | (0x19 << 10)); // csrwr $r0,0x19
            ram.write32(0x1c000000 + 12 * 4, 0x04000020 | (0x1a << 10)); // csrwr $r0,0x1a 
            ram.write32(0x1c000000 + 13 * 4, 0x04000020 | (0x1b << 10)); // csrwr $r0,0x1b 
            ram.write32(0x1c000000 + 14 * 4, 0x0395b821); // 	ori	$r1,$r1,0x56e
            ram.write32(0x1c000000 + 15 * 4, 0x04007021); // 	csrwr	$r1,0x1c
            ram.write32(0x1c000000 + 16 * 4, 0x038b9001); // 	ori	$r1,$r0,0x2e4
            ram.write32(0x1c000000 + 17 * 4, 0x04007421); // 	csrwr	$r1,0x1d
            ram.write32(0x1c000000 + 18 * 4, 0x4c000180); //    jirl    $r0,$r12,0
        }
        else {
            log_info("load bios, from config file");
            ram.ram_load_binary(0x1c000000, static_cast<const char *>(config.get_value("bios").c_str()));
        }
        if (config.has_key("args")) {
            auto args = config.get_value("kernel") + " " + config.get_value("args");
            vector<size_t> space_index;
            int last_isspace = true;
            for (size_t i = 0; i < args.length(); i++) {
                if (isspace(args[i])) {
                    last_isspace = true;
                } else {
                    if (last_isspace) {
                        space_index.push_back(i);
                    }
                    last_isspace = false;
                }
            }
            replace(args.begin(), args.end(), ' ', '\0');
            const uint64_t base = 0;
            const uint64_t base2 = 512;
            lsassertm(space_index.size() < 60, "args too long\n");
            ram.write64(base, space_index.size());
            for (size_t i = 0; i < space_index.size(); i++)
            {
                ram.write64(base + 8 + i*8, (space_index[i] + base2) | 0x9000000000000000ULL);
            }
            ram.writen(base2, (void*)args.c_str(), args.size());
        }
    }
}
