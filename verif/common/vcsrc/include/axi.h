#ifndef _SIM_AXI_H
#define _SIM_AXI_H

#include <stdint.h>
#include <queue>

#include "VTop.h"
#include "ram.h"
#include "commonprint.h"

#define SIM_AXI_WIDTH 4
#define SIM_AXI_ID    9
#define SIM_AXI_USER  4
#define SIM_AXI_MAX_LEN 16
#define SIM_AXI_WCMAX 10

namespace AXISim{
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
};

struct AXI_wreq{
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
};

struct AXI_rtask{
  uint64_t addr     ; // 64
  uint8_t  size  : 3; 
  uint8_t  burst : 2;
  uint8_t  len      ;
  uint8_t  cache : 4;
  uint8_t        : 0;
  bool     read     ;
  uint64_t bound    ;
};

struct AXI_wtask{
  uint64_t addr     ; // 64
  uint8_t  size  : 3; 
  uint8_t  burst : 2;
  uint8_t  len      ;
  uint16_t  id       ;
  uint8_t  cache : 4;
  uint8_t        : 0;
  uint64_t bound    ;
};

class AXI_wrapper{
private:
    VTop *master;
    class RAM *ram;

    std::queue<struct AXI_rreq> rreq_list;
    std::queue<struct AXI_wreq> wreq_list;
    bool winflight;
    bool wfinish;
    bool rinflight;

    struct AXI_rtask rtask;
    struct AXI_wtask wtask;
    struct AXI_wtask wtask_finished;

public:
    AXI_wrapper(VTop *master,class RAM *ram);
    ~AXI_wrapper();

    int save_signal(int cylces);
    int handle_aw(int cycles);
    int handle_w(int cycles);
    int handle_ar(int cycles);
    int handle_r(int cycles);
    int handle_b(int cycles);

    uint64_t addr_inc(bool wrap,uint64_t bound,uint64_t offset, uint64_t addr);
    void  get_rtask(int cycles);
    void  get_wtask(int cycles);
    void  update_rtask(int cycles);
    void  update_wtask(int cycles);
};

}
#endif
