#ifndef RAND64_H
#define RAND64_H

#pragma once

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <vector>
#include <algorithm>
#include <string>
#include <set>
#include <map>
#include <random>
#include <unordered_map>
#include "ram.h"
#include "pgtable-bits.h"
#include "lsassert.h"

using namespace std;
#define PATH_LENGTH 1024
#define EX_TLBR    0x3f
#define EX_SYSCALL 0x0b

#define BASE_ADDR 0x8000000

#define TLB_REFILL_ENTRY_ADDR_DISP 0x1000
#define E_ENTRY_ADDR_DISP 0x2000
#define TLB_REFILL_DATA_ADDR_DISP 0x3000
#define ILLEGAL_NEXT_PC_DATA_ADDR_DISP 0x4000
#define REG_INIT_ADDR_DISP 0x5000

#define TLB_REFILL_ENTRY_ADDR (BASE_ADDR + TLB_REFILL_ENTRY_ADDR_DISP)
#define E_ENTRY_ADDR (BASE_ADDR + E_ENTRY_ADDR_DISP)
#define TLB_REFILL_DATA_ADDR (BASE_ADDR + TLB_REFILL_DATA_ADDR_DISP)
#define ILLEGAL_NEXT_PC_DATA_ADDR (BASE_ADDR + ILLEGAL_NEXT_PC_DATA_ADDR_DISP)
#define ILLEGAL_NEXT_PC_DATA_ADDR_DMW (0x8000000000000000 + ILLEGAL_NEXT_PC_DATA_ADDR)
#define REG_INIT_ADDR (BASE_ADDR + REG_INIT_ADDR_DISP)



#define TLB_V 0x1
#define TLB_W 0x4
#define TLB_XI 0x10 // if bit was set, it is not allowed to execute
#define TLB_RI 0x40

struct TLB_REFILL_CSR {
    // uint64_t TLBIDX; //0x10
    uint64_t TLBEHI; //0x11
    uint64_t TLBElO0; //0x12
    uint64_t TLBElO1; //0x13
    // uint64_t ASID; //0x18
};


class rand64
{
    vector<uint64_t> raw_page_res;
    vector<uint64_t> page_is_data;
    vector<uint64_t> raw_page_size_res;
    vector<uint64_t> raw_tlb_attr_res;
    vector<uint64_t> raw_map_res;
    vector<uint64_t> raw_mapinit_res;
    vector<uint64_t> raw_pc_res;
    vector<uint64_t> raw_instruction_res;
    vector<uint64_t> raw_illegal_pc_res;
    vector<uint64_t> raw_illegal_next_pc_res;

    vector<uint64_t> raw_data_init_addr_res;
    vector<uint64_t> raw_data_init_data_res;
    vector<uint64_t> raw_init_reg_res;
    vector<uint64_t> raw_init_vreg_res;
    
    // vector<uint64_t> pfn;
    map<uint64_t, size_t> page_index_map;

    // index paddr
    map<uint64_t, uint64_t> map2pfn;
    map<uint64_t, uint64_t> vaddr2inst_map;
    uint64_t page_num;
    uint64_t instruction_num;
    RAM* ram;
    int pagebit_mini = 14;
    int pagebit_big = 25;
    std::mt19937_64 mtrand;
    // mat for each res line
    void prepare_mat();
    int allocate_mat(int);
    vector<int> allocated_mat;

public:
    bool enable = false;
    int fill_type = 1;
    int mat_type  = 1;

    uint64_t with_tlb;
    // 0: none, 64:64, 128:128, 256:256
    uint64_t fpr_bits;
    rand64();
    rand64(RAM* ram);
    ~rand64();
    void reseed(uint64_t seed);
    void load_raw(const char* testpath);
    void alloc_pfn();
    void build_page_index_map();
    void build_page_table();
    uint64_t vaddr2paddr(uint64_t vaddr);
    uint64_t vaddr2inst(uint64_t vaddr);
    int64_t pc2line(uint64_t pc);
    TLB_REFILL_CSR get_tlbr_data(uint64_t vaddr, int* error);
    int handle_tlbr(uint64_t vaddr);
    int handle_illegal_pc(uint64_t pc);
    uint64_t setupRAM(RAM* ram);
    int64_t vaddr2line(uint64_t vaddr, int page_bits);
    int64_t tlbattr2eloattr(uint64_t tlbattr);
    int64_t tlbattr2pteattr(uint64_t tlbattr);
private:

};

#endif
