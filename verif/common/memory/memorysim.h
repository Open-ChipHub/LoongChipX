#ifndef _SIM_MEMORY_H
#define _SIM_MEMORY_H
#include <stdint.h>
#include <queue>
#include <unordered_map>
#include <functional>
#include "dramsim3.h"
#include "VTop.h"
#include "../vcsrc/ram.h"
#include "../vcsrc/axi.h"
#include "../vcsrc/commonprint.h"
namespace MemorySim{
struct AXI_rreq{
  uint64_t addr     ; // 64
  uint8_t  size  : 3; 
  uint8_t  burst : 2;
  uint8_t  prot  : 3; // 8
  uint8_t  cache : 4;
  uint16_t  id    : SIM_AXI_ID; // 8
  uint8_t  len      ; // 8
  uint8_t  qos   : 4;
  uint8_t  region: 4; // 8
  uint8_t  lock  : 2;
  uint8_t  user  : SIM_AXI_USER;
  uint8_t        : 0;
  uint32_t data[SIM_AXI_MAX_LEN];
};

struct AXI_wreq{
  uint64_t addr     ; // 64
  uint8_t  size  : 3; 
  uint8_t  burst : 2;
  uint8_t  prot  : 3; // 8
  uint8_t  cache : 4; 
  uint16_t  id    : SIM_AXI_ID; // 8
  uint8_t  len      ; // 8
  uint8_t  remain   ;
  uint8_t  qos   : 4;
  uint8_t  region: 4; // 8
  uint8_t  lock  : 2; 
  uint8_t  user  : SIM_AXI_USER;
  uint8_t        : 0;
  uint32_t  strb[SIM_AXI_MAX_LEN/SIM_AXI_WIDTH]     ;    //Note:Strb最多16位，但是，就怕后面变是吧
  uint32_t data[SIM_AXI_MAX_LEN];
};

struct AXI_rtask{
  uint64_t addr     ; // 64
  uint8_t  size  : 3; 
  uint8_t  burst : 2;
  uint8_t  len      ;
  uint8_t        : 0;
  uint8_t remain    ;
  uint32_t data[SIM_AXI_WIDTH];
};

struct AXI_wtask{
  uint64_t addr     ; // 64
  uint8_t  size  : 3; 
  uint8_t  burst : 2;
  uint8_t  len      ;
  uint8_t        : 0;
  uint8_t remain    ;
};

class AXI_checker{
    int time[1 << (SIM_AXI_ID)];
    int next[1 << (SIM_AXI_ID)];
    int prev[1 << (SIM_AXI_ID)];
    int head;
    int last;
    int last_cycles;
    int channel_id ;
public:
    AXI_checker(int channel_id);
    ~AXI_checker();
    void check(int cycles);
    void insert(int id, int cycles);
    void remove(int id, int cycles);
};

class AXI_wrapper{
private:
    VTop *master;
    dramsim3::MemorySystem *dram;
    class RAM *ram;

    std::queue<struct AXI_rreq> respond_read;
    std::queue<struct AXI_wreq> coalesce_write;
    std::queue<struct AXI_wreq> require_write;
    std::queue<struct AXI_wreq> respond_write;
    std::unordered_map<uint64_t, std::queue<struct AXI_rreq>> inflight_read;
    std::unordered_map<uint64_t, std::queue<struct AXI_wreq>> inflight_write;
    bool rinflight;
    bool winflight;

    struct AXI_rtask rtask;
    struct AXI_wtask wtask;

    AXI_checker rchecker;
    AXI_checker wchecker;

    uint64_t addr_inc(bool wrap,uint64_t bound,uint64_t offset, uint64_t addr);
    void get_rtask(int cycles);
    void get_wtask(int cycles);
    void update_rtask(int cycles);
    void update_wtask(int cycles);

    void read_complete(uint64_t addr);
    void write_complete(uint64_t addr);

    bool coalesce_full();

public:
    AXI_wrapper(VTop *master,class RAM *ram,const std::string config_path,const std::string output_path);
    ~AXI_wrapper();

    int handle_aw(int cycles);
    int handle_w (int cycles);
    int handle_b (int cycles);
    int handle_ar(int cycles);
    int handle_r (int cycles);
    int dramsim_tick();

};

}

#endif
