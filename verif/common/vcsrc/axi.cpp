

#include "axi.h"

using namespace AXISim;
AXI_wrapper::AXI_wrapper(VTop *master,class RAM *ram):master(master),ram(ram){
    INFO(PRINT_BOLDYELLOW,"[AXI_wrapper] Initialized.\n");
    winflight = false;
    rinflight = false;
    // rread = false;
    wfinish = false;
    rtask = {0};
    wtask = {0};
    assert(SIM_AXI_WIDTH % 2 == 0); /** for use of handle_r()*/
}

AXI_wrapper::~AXI_wrapper(){
    ;
}

int AXI_wrapper::save_signal(int cycles){
    return 0;
}

int AXI_wrapper::handle_aw(int cycles){
    if (master->axi_aw_valid){
        struct AXI_wreq wreq={
            master->axi_aw_addr,
            master->axi_aw_size,
            master->axi_aw_burst,
            master->axi_aw_prot,
            master->axi_aw_cache,
            master->axi_aw_id,
            master->axi_aw_len,
            0,
            0,
            0,
            0
        };
        wreq_list.push(wreq);
        master->axi_aw_ready = true;
    }else master->axi_aw_ready = false;
    return 0;
}

int AXI_wrapper::handle_w(int cycles){

    if (wreq_list.empty()){
        master->axi_w_ready = false;
        return 0;
    }

    if (winflight){
        /** process according to wtask */
        master->axi_w_ready = true;
        if(master->axi_w_valid){
            ram->writen(wtask.addr & 0xfffffff0,master->axi_w_data,SIM_AXI_WIDTH*4,master->axi_w_strb);
            /** handle next cycle task */
            if(wtask.len == 0){
                DEBUG(DEBUG_AXI,PRINT_GREEN,"wtask finish, id: %d",wtask.id);
                wreq_list.pop();
                wtask_finished = wtask;
                wfinish = true;
                if(wreq_list.empty()) winflight = false;
                else get_wtask(cycles);
            }else update_wtask(cycles);
        }
    }else{
        master->axi_w_ready = false;
        winflight = true;
        get_wtask(cycles);
    }
    // DEBUG(DEBUG_AXI,PRINT_MAGENTA,"rinflight: %d",rinflight);
    return 0;
}

int AXI_wrapper::handle_b(int cycles){
    if(wfinish){
        master->axi_b_valid = true;
        master->axi_b_resp = 0;
        master->axi_b_id = wtask_finished.id;
        wfinish = false;
    }else{
        master->axi_b_valid = false;
    }
    return 0;
}

int AXI_wrapper::handle_ar(int cycles){
    if (master->axi_ar_valid){
        struct AXI_rreq rreq={
            master->axi_ar_addr,
            master->axi_ar_size,
            master->axi_ar_burst,
            master->axi_ar_prot,
            master->axi_ar_cache,
            master->axi_ar_id,
            master->axi_ar_len,
            0,
            0,
            0,
            0
        };
        rreq_list.push(rreq);
        master->axi_ar_ready = true;
        DEBUG(DEBUG_AXI,PRINT_DEBUG,"Get ar at cycle %d. addr: %lx burst: %d len: %d",cycles,rreq.addr,rreq.burst,rreq.len);
    }else master->axi_ar_ready = false;
    return 0;
}

int AXI_wrapper::handle_r(int cycles){
    if (rreq_list.empty()){
        master->axi_r_last = false;
        master->axi_r_valid = false;
        return 0;
    }

    if (rinflight){
        /** process according to rtask */
        uint32_t rdata[SIM_AXI_WIDTH];
        if(!rtask.read){
            ram->readx(rtask.addr & 0xfffffff0,rdata,rtask.cache & 0x1,rtask.addr,1 << rtask.size); // default cached size : SIM_AXI_WIDTH*4 = 128
            DEBUG(DEBUG_AXI,PRINT_MAGENTA,"addr:%lx,len %d,data:%x",rtask.addr,rtask.len,rdata[0]);
            rtask.read = true;
            for(int i=0; i<SIM_AXI_WIDTH; i++){
                master->axi_r_data[i] = rdata[i];
            }
        }
        master->axi_r_id   = rreq_list.front().id;
        master->axi_r_last = rtask.len == 0;

        /** handle next cycle task */
        if(master->axi_r_ready){
            master->axi_r_valid = true;
            if(rtask.len == 0){ 
                rreq_list.pop();
                if(rreq_list.empty()) rinflight = false;
                else get_rtask(cycles);
            }else update_rtask(cycles);
        }else master->axi_r_valid = false;
    }else{
        rinflight = true;
        master->axi_r_last = false;
        master->axi_r_valid = false;
        get_rtask(cycles);
    }
    return 0;
}

uint64_t AXI_wrapper::addr_inc(bool wrap,uint64_t bound,uint64_t offset, uint64_t addr){
    if(wrap){
        DEBUG(DEBUG_AXI,PRINT_YELLOW,"addr: %lx bound: %ld ",addr,bound);
        uint64_t base = addr / bound * bound;
        DEBUG(DEBUG_AXI,PRINT_YELLOW,"base: %lx ",base);
        return (addr + offset) % bound + base;
    }else{
        return addr + offset;
    }
}

void AXI_wrapper::get_rtask(int cycles){
    rtask.size  = rreq_list.front().size;
    rtask.burst = rreq_list.front().burst;
    rtask.len   = rreq_list.front().len;
    rtask.cache = rreq_list.front().cache;
    rtask.read = false;
    bool wrap = rtask.burst == 2;
    uint64_t offset = 1 << rtask.size;
    rtask.bound = offset * (rtask.len + 1);

    rtask.addr = rreq_list.front().addr;
    DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Get rtask at cycle %d. rtask addr: %lx rtask burst: %d rtask len: %d",cycles,rtask.addr,rtask.burst,rtask.len);
}

void AXI_wrapper::update_rtask(int cycles){
    rtask.len--;
    bool wrap = rtask.burst == 2;
    uint64_t offset = 1 << rtask.size;
    rtask.addr = addr_inc(wrap,rtask.bound,offset,rtask.addr);
    rtask.read = false;
    DEBUG(DEBUG_AXI,PRINT_GREEN,"Update rtask at cycle %d. rtask addr: %lx rtask burst: %d rtask size: %d rtask len: %d",cycles,rtask.addr,rtask.burst,rtask.size,rtask.len);
}


void AXI_wrapper::get_wtask(int cycles){
    wtask.size  = wreq_list.front().size;
    wtask.burst = wreq_list.front().burst;
    wtask.len   = wreq_list.front().len;
    wtask.id    = wreq_list.front().id;
    wtask.cache = wreq_list.front().cache;
    bool wrap = wtask.burst == 2;
    uint64_t offset = 1 << wtask.size;
    wtask.bound = offset * (wtask.len + 1);

    wtask.addr = wreq_list.front().addr & ~((1llu << wtask.size) - 1);
    DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Get wtask at cycle %d. wtask addr: %lx wtask burst: %d wtask len: %d",cycles,wtask.addr,wtask.burst,wtask.len);
}


void AXI_wrapper::update_wtask(int cycles){
    wtask.len--;
    bool wrap = wtask.burst == 2;
    uint64_t offset = 1 << wtask.size;
    wtask.addr = addr_inc(wrap,wtask.bound,offset,wtask.addr);
    DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Update wtask at cycle %d. wtask addr: %lx wtask burst: %d wtask len: %d",cycles,wtask.addr,wtask.burst,wtask.len);
}
