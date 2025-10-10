#include "rand64.h"
#include "log.h"

using namespace std;

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

static void res_checkheader(FILE* f, const char* header) {
    char line_buffer[1024];
    fscanf(f, "%s", line_buffer);
    lsassert(strcmp(line_buffer, header) == 0);
}

static uint64_t res_getline_binary(FILE* f) {
    char line_buffer[1024];
    fscanf(f, "%s", line_buffer);
    return strtoul(line_buffer, NULL, 2);
}

rand64::rand64()
{
}

rand64::rand64(RAM* ram)
{
    this->ram = ram;
}

rand64::~rand64()
{

}

vector<uint64_t> res_get_binary(const char* filename) {
    vector<uint64_t> r;
    FILE* f = open_res(filename);
    char line_buffer[1024];
    uint64_t data;
    res_checkheader(f, "@00");
    while(fscanf(f, "%s", line_buffer) == 1) {
        data = strtoul(line_buffer, NULL, 2);
        r.push_back(data);
    }
    close_res(f);
    return move(r);
}

vector<uint64_t> res_get_hex_tpye1(const char* filename) {
    vector<uint64_t> r;
    FILE* f = open_res(filename);
    char line_buffer[1024];
    uint64_t data;
    uint64_t temp[8];
    while(fgets(line_buffer, 1024, f)) {
        if (line_buffer[0] == '@') {
            continue;
        }
        sscanf(line_buffer,"%lx%lx%lx%lx%lx%lx%lx%lx",&temp[0],&temp[1],&temp[2],&temp[3],&temp[4],&temp[5],&temp[6],&temp[7]);
        data = temp[0] + (temp[1]<<8) + (temp[2]<<16) + (temp[3]<<24) + (temp[4]<<32) + (temp[5]<<40) + (temp[6]<<48) + (temp[7]<<56);
        r.push_back(data);
    }
    close_res(f);
    return move(r);
}

vector<uint64_t> res_get_hex_tpye2(const char* filename) {
    vector<uint64_t> r;
    FILE* f = open_res(filename);
    char line_buffer[1024];
    uint64_t data;
    while(fscanf(f, "%s", line_buffer) == 1) {
        if (line_buffer[0] == '@') {
            continue;
        }
        sscanf(line_buffer,"%lx\n",&data);
        r.push_back(data);
    }
    close_res(f);
    return move(r);
}

void rand64::reseed(uint64_t seed){
    mtrand.seed(seed);
}

int rand64::allocate_mat(int line){
    if(0 <= mat_type && mat_type <= 3)
        return mat_type << _CACHE_SHIFT;
    else
        return allocated_mat[line];
}

void rand64::load_raw(const char* testpath) {
    log_debug("testpath:%s", testpath);
    auto page        	= res_get_binary((string(testpath) + "page.res").c_str());
    auto page_size   	= res_get_binary((string(testpath) + "page_size.res").c_str());
    auto tlb_attr    	= res_get_binary((string(testpath) + "tlb_attr.res").c_str());
    auto map          	= res_get_binary((string(testpath) + "map.res").c_str());
    auto mapinit     	= res_get_binary((string(testpath) + "mapinit.res").c_str());
    auto init_reg       = res_get_hex_tpye1((string(testpath) + "init.reg.res").c_str());
    auto init_vreg       = res_get_hex_tpye1((string(testpath) + "init.vreg.res").c_str());
    auto pc          	= res_get_hex_tpye1((string(testpath) + "pc.res").c_str());
    auto instruction 	= res_get_hex_tpye1((string(testpath) + "instruction.res").c_str());
    auto illegal_pc 	= res_get_hex_tpye1((string(testpath) + "illegal_pc.res").c_str());
    auto illegal_next_pc= res_get_hex_tpye1((string(testpath) + "illegal_next_pc.res").c_str());
    auto data_init_addr = res_get_hex_tpye2((string(testpath) + "data_init_addr.res").c_str());
    auto data_init_data = res_get_hex_tpye2((string(testpath) + "data_init_data.res").c_str());
    auto parameter      = res_get_hex_tpye2((string(testpath) + "parameter.res").c_str());

    log_debug("page number: %ld", parameter[0]);
    this->page_num = parameter[0];

    this->raw_page_res.insert(raw_map_res.begin(), page.begin(), page.begin() + this->page_num);
    for (auto &i : this->raw_page_res) {
        i &= 0xffffffffful;
    }
    this->page_is_data.insert(page_is_data.begin(), page.begin(), page.begin() + this->page_num);
    for (auto &i : this->page_is_data) {
        i >>= 36;
    }

    this->raw_page_size_res.insert(raw_page_size_res.begin(), page_size.begin(), page_size.begin() +  this->page_num);
    this->raw_tlb_attr_res.insert(raw_tlb_attr_res.begin(), tlb_attr.begin(), tlb_attr.end());
    this->raw_map_res.insert(raw_map_res.begin(), map.begin(), map.begin() +  this->page_num);
    this->raw_mapinit_res.insert(raw_mapinit_res.begin(), mapinit.begin(), mapinit.begin() +  this->page_num);

    this->raw_init_reg_res.insert(raw_init_reg_res.begin(), init_reg.begin(), init_reg.end());
    this->raw_init_vreg_res.insert(raw_init_vreg_res.begin(), init_vreg.begin(), init_vreg.end());
    lsassert(this->raw_init_vreg_res.size() == 128);
    /*  first line and two syscalls */
    lsassertm(pc[0] + 3 == pc.size(), "%ld,%ld\n", pc[0], pc.size());
    this->instruction_num = pc[0] + 2;
    this->raw_pc_res.insert(raw_pc_res.begin(), pc.begin() + 1, pc.begin() + 1 +  this->instruction_num);
    this->raw_instruction_res.insert(raw_instruction_res.begin(), instruction.begin(), instruction.begin() +  this->instruction_num);

    for (size_t i = 0; i < this->raw_pc_res.size(); ++ i) {
        this->vaddr2inst_map[this->raw_pc_res[i]] = this->raw_instruction_res[i];
    }

    if (illegal_pc.front() != 0) {
        this->raw_illegal_pc_res.insert(raw_illegal_pc_res.begin(), illegal_pc.begin() + 1, illegal_pc.end());
        this->raw_illegal_next_pc_res.insert(raw_illegal_next_pc_res.begin(), illegal_next_pc.begin() + 1, illegal_next_pc.end());
    }

    lsassert(this->raw_instruction_res[this->instruction_num - 2] == 0x2b0000);
    lsassert(this->raw_instruction_res[this->instruction_num - 1] == 0x2b0000);
    // this->raw_instruction_res[ this->instruction_num - 2] = 0x50000000;
    // this->raw_instruction_res[ this->instruction_num - 1] = 0x50000000;

    lsassert(data_init_addr[0] == data_init_addr.size() - 1);
    if(data_init_addr.front() != 0){
        this->raw_data_init_addr_res.insert(raw_data_init_addr_res.begin(), data_init_addr.begin() + 1, data_init_addr.begin() + 1 +  data_init_addr[0]);
        this->raw_data_init_data_res.insert(raw_data_init_data_res.begin(), data_init_data.begin(), data_init_data.begin() +  data_init_addr[0]);
    }

    log_debug("first_page            :%16lx, last_page            :%16lx", this->raw_page_res.front(), this->raw_page_res.back());
    log_debug("first_page_size       :%16lx, last_page_size       :%16lx", this->raw_page_size_res.front(), this->raw_page_size_res.back());
    log_debug("first_map             :%16lx, last_map             :%16lx", this->raw_map_res.front(), this->raw_map_res.back());
    log_debug("first_mapinit         :%16lx, last_mapinit         :%16lx", this->raw_mapinit_res.front(), this->raw_mapinit_res.back());
    log_debug("first_pc              :%16lx, last_pc              :%16lx", this->raw_pc_res.front(), this->raw_pc_res.back());
    log_debug("first_instruction     :%16lx, last_instruction     :%16lx", this->raw_instruction_res.front(), this->raw_instruction_res.back());
    if (illegal_pc.front() != 0) {
        log_debug("first_illegal_pc      :%16lx, last_illegal_pc      :%16lx", this->raw_illegal_pc_res.front(), this->raw_illegal_pc_res.back());
        log_debug("first_illegal_next_pc :%16lx, last_illegal_next_pc :%16lx", this->raw_illegal_next_pc_res.front(), this->raw_illegal_next_pc_res.back());
    }
    if(data_init_addr.front() != 0){
        log_debug("first_data_init_addr  :%16lx, last_data_init_addr  :%16lx", this->raw_data_init_addr_res.front(), this->raw_data_init_addr_res.back());
        log_debug("first_data_init_data  :%16lx, last_data_init_data  :%16lx", this->raw_data_init_data_res.front(), this->raw_data_init_data_res.back());
    }
    
    uint64_t inst_map = 0x100000000l;
    // uint64_t max_map = *max_element(this->raw_map_res.begin(), this->raw_map_res.end());
    // log_debug("max_map :%lx", max_map);

    for (auto &&item : raw_map_res)
    {
        if (item == 0) {
            item = inst_map;
            inst_map ++;
        }
    }

    log_debug("GPR:");
    for (size_t i = 0; i < 32; i++)
    {
        log_debug("r%02d:%016lx", i, this->raw_init_reg_res[i]);
    }

    log_debug("FPR:");
    for (size_t i = 0; i < 32; i++)
    {
        log_debug("f%02d:%016lx", i, this->raw_init_reg_res[i + 32]);
    }
    log_debug("LLBIT:%16lx", this->raw_init_reg_res[65]);
    log_debug("EFLAG:%16lx", this->raw_init_reg_res[75]);
    log_debug("FCSR :%08lx", int(this->raw_init_reg_res[80]));
    log_debug("FCC  :%08lx", int(this->raw_init_reg_res[81]));
    log_debug("SCR0 :%16lx", this->raw_init_reg_res[82]);
    log_debug("SCR1 :%16lx", this->raw_init_reg_res[83]);
    log_debug("SCR2 :%16lx", this->raw_init_reg_res[84]);
    log_debug("SCR3 :%16lx", this->raw_init_reg_res[85]);

    // fpr only fr0-fr16
    for (size_t i = 0; i < 16; i++)
    {
        if (this->raw_init_reg_res[i + 32] !=  this->raw_init_vreg_res[i * 4]) {
            log_error("f%d mismatch", i);
            abort();
        }
    }

    this->alloc_pfn();
    this->build_page_index_map();
    this->build_page_table();
}

/* Round number down to multiple */
#define ALIGN_DOWN(n, m) ((n) / (m) * (m))

/* Round number up to multiple. Safe when m is not a power of 2 (see
 * ROUND_UP for a faster version when a power of 2 is guaranteed) */
#define ALIGN_UP(n, m) ALIGN_DOWN((n) + (m) - 1, (m))

void rand64::alloc_pfn() {
    // uint64_t pc_start = 0;
    uint64_t data_start_init = 0x50000000;
    uint64_t data_start = data_start_init;
    /* first page, init and eentry */
    if (this->raw_page_res[0] != 0x8000 || this->raw_map_res[0] != 1) {
        log_fatal("please check first page");
        abort();
    }
    this->map2pfn.insert({1, 0x8000000});
    for (size_t i = 0; i < this->page_num; i++)
    {
        uint64_t map_num = this->raw_map_res[i];
        // if (map_num == 0) {
        //     if (this->page_is_data[i]) {
        //         log_error("map.res:num is 0(inst page), while msb of page.res is 1(data page)");
        //     }
        // }
        if (!this->map2pfn.count(map_num)) {
            uint64_t page_size = (1 << this->raw_page_size_res[i]);
            data_start = ALIGN_UP(data_start, page_size);
            this->map2pfn.insert({map_num, data_start});
            data_start += page_size;
        }
    }
    if(fill_type != 0){
        uint64_t fill_mask = 0xffffffffffffffffllu;
        uint64_t fill_data = 0x0000000000000000llu;
        switch(fill_type){
            case 4:
                // JIRL $r0, $rRAND, 0
                fill_mask = 0x000003e0000003e0llu;
                fill_data = 0x4c0000004c000000llu;
                break;
            case 3:
                // likely a branch
                fill_mask = 0x3fffffff3fffffffllu;
                fill_data = 0x4000000040000000llu;
                break;
            case 2:
                // likely a instruction
                fill_mask = 0x7fffffff7fffffffllu;
                fill_data = 0x0000000000000000llu;
                break;
            default:
                // all codes
                break;
        }
        for(uint64_t addr = data_start_init;addr < data_start;addr += 8){
            uint64_t data = (mtrand() & fill_mask) ^ fill_data;
            this->ram->write64(addr, data);
        }
    }
    log_debug("paddr_end:%16lx, pages:%d", data_start, this->map2pfn.size());
    if (data_start > this->ram->size) {
        log_fatal("ram too small");
        abort();
    }
}

void rand64::build_page_index_map() {
    for (size_t i = 0; i < this->raw_page_res.size(); i++)
    {
        this->page_index_map.insert({this->raw_page_res[i], i});
    }
    // for (auto i : this->page_index_map) {
    //      log_trace("%lx:%d", i.first, i.second);
    // }
}

int get_disjoint_set_id(const vector<int>& tbl,int i){
    while(i != tbl[i]){
        i = tbl[i]; 
    }
    return i;
}

void merge_disjoint_set(vector<int>& tbl,int i, int j){
    int x = get_disjoint_set_id(tbl, i);
    int y = get_disjoint_set_id(tbl, j);
    int smallest = x < y ? x : y;
    int other    = x < y ? y : x;

    tbl[other] = smallest;
    tbl[i] = smallest;
    tbl[j] = smallest;
}

void rand64::prepare_mat(){
    vector<std::pair<uint64_t, int>> addresses;
    for (size_t i = 0; i < this->raw_tlb_attr_res.size(); i++)
    {
        uint64_t vaddr = this->raw_page_res[i];
        addresses.push_back(std::make_pair(vaddr,i));
    }
    std::sort(addresses.begin(), addresses.end());
    // merge mat blocks using Disjoint-set
    vector<int> blocks;
    blocks.resize(this->raw_tlb_attr_res.size());
    allocated_mat.resize(this->raw_tlb_attr_res.size());
    int prob_cc = -mat_type;
    for (size_t i = 0; i < this->raw_tlb_attr_res.size(); i++){
        blocks[i] = i;
        int mat;
        if(mat_type < 0){
            mat = (mtrand() & 0xff) < prob_cc ? _CACHE_CC : _CACHE_WUC;
        }
        else {
            mat = (mtrand() & 0x1) ? _CACHE_CC : _CACHE_WUC;
        }
        allocated_mat[i] = mat;
    }
    map<uint64_t,int> occurs;

    // when virtual pages have same physical page, put into same set
    for (size_t i = 0; i < this->raw_tlb_attr_res.size(); i++){
        uint64_t vaddr = addresses[i].first;
        uint64_t id    = addresses[i].second;
        bool huge_page = this->raw_page_size_res[id] == this->pagebit_big;
        uint64_t paddr = this->map2pfn[this->raw_map_res[id]];
        map<uint64_t,int>::iterator it = occurs.find(paddr);
        if(it != occurs.end()){
            merge_disjoint_set(blocks, i, it->second);
        }
        else{
            occurs[paddr] = i;
        }
    }

    // when virtual page continues, put into same set
    for (size_t i = 1; i < this->raw_tlb_attr_res.size(); i++){
        uint64_t prev_vaddr = addresses[i - 1].first;
        int      prev_id    = addresses[i - 1].second;
        bool     prev_huge_page = this->raw_page_size_res[prev_id] == this->pagebit_big;
        int      prev_page_bits = prev_huge_page ? pagebit_mini : pagebit_big;
        int      prev_page_size = 1 << prev_page_bits;
        uint64_t vaddr = addresses[i].first;
        if(prev_vaddr + prev_page_size == vaddr){
            merge_disjoint_set(blocks, i - 1, i);
        }
    }

    // each set use same mat
    for (size_t i = 0; i < this->raw_tlb_attr_res.size(); i++){
        int t = addresses[i].second;
        int s = addresses[get_disjoint_set_id(blocks,i)].second;
        allocated_mat[t] = allocated_mat[s];
    }
}

void rand64::build_page_table() {
    /*
     * always 4 level page, 48 bit vaddr, currently support 4kb and 16kb
     * 16kb:
     * pwcl:0x5e56e
     * 31 30 || 29 28 27 26 25 || 24 23 22 21 20 || 19 18 17 16 15 || 14 13 12 11 10 || 9  8  7  6  5 || 4  3  2  1  0
     *  0  0 ||  0  0  0  0  0 ||  0  0  0  0  0 ||  0  1  0  1  1 ||  1  1  0  0  1 || 0  1  0  1  1 || 0  1  1  1  0
     * PTEbit|| Dir2_width:0   || Dir2_base:0    || Dir1_width:11  || Dir1_base:25   || PTwidth:11    || PTbase:14(ps)
     * 
     * pwch:0x2e4
     * 31 30 29 28 27 26 25 24 || 23 22 21 20 19 18 || 17 16 15 14 13 12 || 11 10  9  8  7  6 || 5  4  3  2  1  0
     *  0  0  0  0  0  0  0  0 ||  0  0  0  0  0  0 ||  0  0  0  0  0  0 ||  0  0  1  0  1  1 || 1  0  0  1  0  0
     *  None                   || Dir4_width:1      || Dir4_base:47      || Dir3_width:11     || Dir3_base:36
     * 
     * vaddr:
     *    PGDH/PGDL  ||           Dir3_width:11          ||          Dir1_width:11           ||          PTwidth:11              14:ldpte  ||
     *            47 || 46 45 44 43 42 41 40 39 38 37 36 || 35 34 33 32 31 30 29 28 27 26 25 || 24 23 22 21 20 19 18 17 16 15 ||    14     || 13 12 11 10  9  8  7  6  5  4  3  2  1  0
     */

    int va_len = 48;
    int ptbase = 14;
    int ptwidth = 11;
    int dir1base = 25;
    int dir1width = 11;
    int dir2base = 0;
    int dir2width = 0;
    int dir3base = 36;
    int dir3width = 11 + 1;
    int dir4base = 0;
    int dir4width = 0;
    int pte_size = 8;

    int page_size = (1 << ptbase);

    uint64_t pt_size = (1 << ptwidth) * pte_size;
    uint64_t dir1_size = (1 << dir1width) * pte_size;
    uint64_t dir2_size = (1 << dir2width) * pte_size;
    uint64_t dir3_size = (1 << dir3width) * pte_size;
    uint64_t dir4_size = (1 << dir4width) * pte_size;

    uint64_t pt_num = (1 << ptwidth);
    uint64_t dir1_num = (1 << dir1width);
    uint64_t dir2_num = (1 << dir2width);
    uint64_t dir3_num = (1 << dir3width);
    uint64_t dir4_num = (1 << dir4width);

    uint64_t invalid_base = 0x20000000;
    uint64_t invalid_base_high = invalid_base;


    uint64_t invalid_pt = ALIGN_UP(invalid_base_high, page_size);
    uint64_t invalid_dir1 = ALIGN_UP(invalid_pt + pt_size, page_size);
    uint64_t invalid_dir2 = ALIGN_UP(invalid_dir1 + dir1_size, page_size);
    uint64_t invalid_dir3 = ALIGN_UP(invalid_dir2 + dir2_size, page_size);
    uint64_t invalid_dir4 = ALIGN_UP(invalid_dir3 + dir3_size, page_size);

    log_debug("invalid_pt:%x", invalid_pt);
    log_debug("invalid_dir1:%x", invalid_dir1);
    log_debug("invalid_dir2:%x", invalid_dir2);
    log_debug("invalid_dir3:%x", invalid_dir3);
    log_debug("invalid_dir4:%x", invalid_dir4);


    invalid_base_high = ALIGN_UP(invalid_dir4 + dir4_size, page_size);

    uint64_t pgdl = invalid_dir3;
    uint64_t pgdh = pgdl + dir3_size / 2;

    log_debug("pgdl:%x", pgdl);
    log_debug("pgdh:%x", pgdh);

    // dir2 is unused
    if (dir4width) {
        for (uint64_t i = 0; i < dir4_num; i++)
        {
            this->ram->write64(invalid_dir4 + i * pte_size, invalid_dir3);
        }
    }
    if (dir3width) {
        for (uint64_t i = 0; i < dir3_num; i++)
        {
            this->ram->write64(invalid_dir3 + i * pte_size, invalid_dir1);
        }
    }
    if (dir1width) {
        for (uint64_t i = 0; i < dir1_num; i++)
        {
            this->ram->write64(invalid_dir1 + i * pte_size, invalid_pt);
        }
    }


    if (this->pagebit_mini == 0xe) {//16kb

    } else if (this->pagebit_mini == 0x12) {
        // TODO:
        log_fatal("currently unsupported");
        abort();
    } else {
        log_fatal("currently unsupported");
        abort();
    }

    // prepare mat value when use random mat
    if(mat_type < 0 || mat_type > 3){
        prepare_mat();
    }
    map<uint64_t,int> mat_checker;

    // only pages with tlb_attr need physical page
    for (size_t i = 0; i < this->raw_tlb_attr_res.size(); i++)
    {
        uint64_t vaddr = this->raw_page_res[i];
        // fixed
        vaddr <<= 12;
        bool huge_page = this->raw_page_size_res[i] == this->pagebit_big;
        uint64_t tlb_attr = this->raw_tlb_attr_res[i];
        uint64_t paddr = this->map2pfn[this->raw_map_res[i]];
        uint64_t dir3_disp = ((vaddr >> dir3base) & ((1 << dir3width) - 1)) * pte_size;
        uint64_t dir1_disp = ((vaddr >> dir1base) & ((1 << dir1width) - 1)) * pte_size;
        uint64_t pt_disp   = ((vaddr >> ptbase) & ((1 << ptwidth) - 1)) * pte_size;

        log_trace("vaddr:%lx, paddr:%lx, huge_page:%d, dir3_disp:%lx, dir1_disp:%lx, pt_disp:%lx", vaddr, paddr, huge_page, dir3_disp, dir1_disp, pt_disp);

        uint64_t target_dir1_addr = this->ram->read64(pgdl + dir3_disp);
        log_trace("target_dir1_addr:%lx", target_dir1_addr);
        if (target_dir1_addr == invalid_dir1) {
            // alloc dir 1
            target_dir1_addr = invalid_base_high;
            invalid_base_high = ALIGN_UP(invalid_base_high + dir1_size, page_size);

            this->ram->write64(pgdl + dir3_disp, target_dir1_addr);
            for (uint64_t i = 0; i < dir1_num; i++)
            {
                this->ram->write64(target_dir1_addr + i * pte_size, invalid_pt);
            }
            log_trace("alloc dir 1, target_dir1_addr:%lx", target_dir1_addr);
        }
        int mat = allocate_mat(i);

        map<uint64_t,int>::iterator it = mat_checker.find(paddr);
        if(it != mat_checker.end()){
            assert(mat == it->second);
        }
        else{
            mat_checker[paddr] = mat;
        }

        if (huge_page) {
            uint64_t huge_pte = paddr;
            huge_pte |= tlbattr2pteattr(tlb_attr);
            huge_pte |= _PAGE_HGLOBAL;
            huge_pte |= _PAGE_HUGE;
            huge_pte |= mat;
            this->ram->write64(target_dir1_addr + dir1_disp, huge_pte);
            log_trace("set huge dir1 entry, target_dir1_addr + dir1_disp:%lx", target_dir1_addr + dir1_disp);
        } else {
            uint64_t target_pt_addr = this->ram->read64(target_dir1_addr + dir1_disp);
            if (target_pt_addr == invalid_pt) {
                // alloc pt
                target_pt_addr = invalid_base_high;
                invalid_base_high = ALIGN_UP(invalid_base_high + pt_size, page_size);
                log_trace("alloc pt, target_pt_addr:%lx", target_pt_addr);

                this->ram->write64(target_dir1_addr + dir1_disp, target_pt_addr);
                log_trace("set dir1, target_dir1_addr + dir1_disp:%lx", target_dir1_addr + dir1_disp);
            }
            uint64_t pte = paddr;
            pte |= tlbattr2pteattr(tlb_attr);
            pte |= _PAGE_GLOBAL;
            pte |= mat;
            this->ram->write64(target_pt_addr + pt_disp, pte);
        }
    }


    log_debug("invalid_base_high:%x", invalid_base_high);
    if (invalid_base_high > 0x50000000) {
        log_fatal("page table entry too large");
        abort();
    }
}

int64_t rand64::vaddr2line(uint64_t vaddr, int page_bits) {
    uint64_t page_num = ALIGN_DOWN(vaddr, (1 << page_bits)) >> 12;

    if(this->page_index_map.count(page_num) == 1) {
        int64_t line = this->page_index_map[page_num];
        if (page_bits == this->raw_page_size_res[line]) {
            return line;
        }
    }
    return -1;
}

uint64_t rand64::vaddr2paddr(uint64_t vaddr) {
    if (!this->with_tlb) {
        return vaddr;
    }
    vaddr &= 0XFFFFFFFFFFFFUL;

    int64_t line = vaddr2line(vaddr, this->pagebit_mini);
    if(line != -1) {
        return this->map2pfn[this->raw_map_res[line]] + (vaddr % (1 << this->pagebit_mini));
    }

    line = vaddr2line(vaddr, this->pagebit_big);
    if(line != -1) {
        return this->map2pfn[this->raw_map_res[line]] + (vaddr % (1 << this->pagebit_big));
    }
    //lsassertm(0, "paddr not found, vaddr:%lx\n", vaddr);
    return -1;
}

uint64_t rand64::vaddr2inst(uint64_t vaddr) {
    auto iter = this->vaddr2inst_map.find(vaddr);
    if(iter != this->vaddr2inst_map.end()) {
        return iter->second;
    } else {
        return UINT64_MAX;
    }
}

TLB_REFILL_CSR rand64::get_tlbr_data(uint64_t vaddr, int* error) {
    lsassert(this->with_tlb);
    vaddr &= 0XFFFFFFFFFFFFUL;
    TLB_REFILL_CSR csr = {};
    csr.TLBElO0 = 0;
    csr.TLBElO1 = 0;
    uint64_t mini_page_size = 1 << this->pagebit_mini;
    uint64_t aligned_vaddr0 = ALIGN_DOWN(vaddr, (mini_page_size * 2));
    uint64_t aligned_vaddr1 = (ALIGN_DOWN(vaddr, (mini_page_size * 2)) + mini_page_size);
    int64_t line0 = vaddr2line(aligned_vaddr0, this->pagebit_mini);
    int64_t line1 = vaddr2line(aligned_vaddr1, this->pagebit_mini);
    if ((line0 != -1) || (line1 != -1)) {
        int mat = allocate_mat(line0);
        if ((line0 != -1)) {
            uint64_t p = this->map2pfn[this->raw_map_res[line0]];
            lsassert((p & ((1 << this->pagebit_mini) - 1)) == 0);
            csr.TLBElO0 |= tlbattr2eloattr(this->raw_tlb_attr_res[line0]) | _PAGE_GLOBAL | mat | p;
             log_trace("aligned_vaddr0:%lx, line:%ld, map:%lx, paddr:%lx", aligned_vaddr0, line0, this->raw_map_res[line0], p);
        }
        if ((line1 != -1)) {
            uint64_t p = this->map2pfn[this->raw_map_res[line1]];
            lsassert((p & ((1 << this->pagebit_mini) - 1)) == 0);
            csr.TLBElO1 |= tlbattr2eloattr(this->raw_tlb_attr_res[line1]) | _PAGE_GLOBAL | mat | p;
             log_trace("aligned_vaddr1:%lx, line:%ld, map:%lx, paddr:%lx", aligned_vaddr1, line1, this->raw_map_res[line1], p);
        }
        csr.TLBEHI = aligned_vaddr0 | this->pagebit_mini;
         log_trace("vaddr:%lx, tlbehi:%lx, tlbelo0:%lx, tlbelo1:%lx", vaddr, csr.TLBEHI, csr.TLBElO0, csr.TLBElO1);
        return csr;

    }
    uint64_t big_page_size = 1 << this->pagebit_big;
    uint64_t half_big_page_size = 1 << (this->pagebit_big - 1);
    int64_t line = vaddr2line(vaddr, this->pagebit_big);
    if (line != -1) {
        int mat = allocate_mat(line);
        uint64_t p = this->map2pfn[this->raw_map_res[line]];
        lsassert((p & ((1 << this->pagebit_big) - 1)) == 0);
        csr.TLBEHI = ALIGN_DOWN(vaddr, big_page_size) | (this->pagebit_big - 1);
        uint64_t page_attr = tlbattr2eloattr(this->raw_tlb_attr_res[line]);
        csr.TLBElO0 |= page_attr | _PAGE_GLOBAL | mat | p;
        csr.TLBElO1 |= page_attr | _PAGE_GLOBAL | mat | (p + half_big_page_size);
        log_trace("vaddr:%lx, tlbehi:%lx, tlbelo0:%lx, tlbelo1:%lx", vaddr, csr.TLBEHI, csr.TLBElO0, csr.TLBElO1);
        return csr;
    }
    *error = -1;
    return csr;
}

int rand64::handle_tlbr(uint64_t vaddr) {
    int error = 0;
    TLB_REFILL_CSR csr = this->get_tlbr_data(vaddr, &error);
    if (error) {
        return -1;
    }
    this->ram->write64(TLB_REFILL_DATA_ADDR + (0 << 3), csr.TLBEHI);
    this->ram->write64(TLB_REFILL_DATA_ADDR + (1 << 3), csr.TLBElO0);
    this->ram->write64(TLB_REFILL_DATA_ADDR + (2 << 3), csr.TLBElO1);
    return 0;
}

int rand64::handle_illegal_pc(uint64_t illegal_pc) {
    static uint64_t illegal_pc_index = 0;
    if (illegal_pc_index >= this->raw_illegal_pc_res.size()) {
        log_error("illegal_pc mismatch:%ld, rtl_illegal_pc:0x%lx, rpg_illegal_pc out of range", illegal_pc_index, illegal_pc);
        return -1;
    }
    if (this->raw_illegal_pc_res[illegal_pc_index] != illegal_pc) {
        log_error("illegal_pc mismatch:%ld, rtl_illegal_pc:0x%lx, rpg_illegal_pc:0x%lx", illegal_pc_index, illegal_pc, this->raw_illegal_pc_res[illegal_pc_index]);
        return -1;
    }

    uint64_t illegal_next_pc = this->raw_illegal_next_pc_res[illegal_pc_index];
    log_trace("handle_illegal_pc:%ld, illegal_pc:0x%lx, illegal_next_pc:0x%lx", illegal_pc_index, illegal_pc, illegal_next_pc);
    this->ram->write64(ILLEGAL_NEXT_PC_DATA_ADDR & 0xfffffffffffful, illegal_next_pc);
    illegal_pc_index ++;
    return 0;
}

uint64_t rand64::setupRAM(RAM* ram) {
    this->ram = ram;
    /* 
     *  jump to 0x8000000, first page
     *  1410000d    lu12i.w $r13,32768(0x8000)
     *  4c00000d    jirl    $r13,$r0,0
     */
    this->ram->write32(0x1c000000, 0x1410000d);
    this->ram->write32(0x1c000004, 0x4c0001a0);
    for (size_t i = 0; i < 32; i++)
    {
        this->ram->write64(REG_INIT_ADDR + (8 * i), this->raw_init_reg_res[i]);
    }
    log_debug("grp init ok");

    for (size_t i = 0; i < 32; i++)
    {
        this->ram->write64(REG_INIT_ADDR + 256 + (8 * i), this->raw_init_reg_res[i + 32]);
    }
    log_debug("fpr init ok");
    this->ram->write64(REG_INIT_ADDR + 512, this->fpr_bits);
    this->ram->write64(REG_INIT_ADDR + 65 * 8, this->raw_init_reg_res[65]);
    this->ram->write64(REG_INIT_ADDR + 75 * 8, this->raw_init_reg_res[75]);
    this->ram->write64(REG_INIT_ADDR + 80 * 8, this->raw_init_reg_res[80]);
    this->ram->write64(REG_INIT_ADDR + 81 * 8, this->raw_init_reg_res[81]);
    this->ram->write64(REG_INIT_ADDR + 82 * 8, this->raw_init_reg_res[82]);
    this->ram->write64(REG_INIT_ADDR + 83 * 8, this->raw_init_reg_res[83]);
    this->ram->write64(REG_INIT_ADDR + 84 * 8, this->raw_init_reg_res[84]);
    this->ram->write64(REG_INIT_ADDR + 85 * 8, this->raw_init_reg_res[85]);

    for (size_t i = 0; i < this->raw_pc_res.size(); i++)
    {
        // uint64_t paddr = this->raw_pc_res[i];
        uint64_t paddr = vaddr2paddr(this->raw_pc_res[i]);
        this->ram->write32(paddr, (uint32_t)this->raw_instruction_res[i]);
    }
    log_debug("instruction init ok");

    for (size_t i = 0; i < this->raw_data_init_addr_res.size(); i++)
    {
        uint64_t paddr = vaddr2paddr(this->raw_data_init_addr_res[i]);
        this->ram->write8(paddr, (uint8_t)this->raw_data_init_data_res[i]);
    }
    log_debug("data init ok");
    this->ram->ram_load_binary(BASE_ADDR, "./exec_binary/rand_boot.bin");

    return 0;
}

int64_t rand64::pc2line(uint64_t pc) {
    auto const& v = this->raw_pc_res;
    auto it = find(v.begin(), v.end(), pc);

    if (it != v.end()) 
    {
        return  it - v.begin();
    }

    return -1;
}

int64_t rand64::tlbattr2eloattr(uint64_t tlbattr) {
    uint64_t r = 0;
    if (tlbattr & TLB_V) { r |= _PAGE_VALID; };
    if (tlbattr & TLB_W) { r |= _PAGE_DIRTY; };
    if (tlbattr & TLB_RI) { r |= _PAGE_NO_READ; };
    if (tlbattr & TLB_XI) { r |= _PAGE_NO_EXEC; };
    // return  _PAGE_VALID | _PAGE_DIRTY;
    return  r;
}

int64_t rand64::tlbattr2pteattr(uint64_t tlbattr) {
    uint64_t r = 0;
    if (tlbattr & TLB_V) { r |= _PAGE_VALID; r|= _PAGE_PRESENT;};
    if (tlbattr & TLB_W) { r |= _PAGE_DIRTY; r|= _PAGE_WRITE;};
    if (tlbattr & TLB_RI) { r |= _PAGE_NO_READ; };
    if (tlbattr & TLB_XI) { r |= _PAGE_NO_EXEC; };
    // return  _PAGE_VALID | _PAGE_DIRTY;
    return  r;
}
