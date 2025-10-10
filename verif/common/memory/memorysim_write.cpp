
#include "memorysim.h"

namespace MemorySim{


int AXI_wrapper::handle_aw(int cycles){
    if (master->axi_aw_valid){
        if(!coalesce_full()){
            struct AXI_wreq wreq={
                master->axi_aw_addr,
                master->axi_aw_size,
                master->axi_aw_burst,
                master->axi_aw_prot,
                0,
                master->axi_aw_id,
                master->axi_aw_len,  // len
                master->axi_aw_len,  // remain   ?????WTF?
                0,
                0,
                0,
                0,
                0
            };
            coalesce_write.push(wreq);
            master->axi_aw_ready = true;
            #ifdef MONITOR_DRAM_SIM
            wchecker.insert(master->axi_aw_id, cycles);
            #endif

            DEBUG(DEBUG_AXI,PRINT_BOLDMAGENTA,"Get a AW id[%d] cache[%x] burst[%d] addr %lx",master->axi_aw_id,master->axi_aw_cache,master->axi_aw_burst,master->axi_aw_addr);
        }else{
            DEBUG(DEBUG_AXI,PRINT_BOLDMAGENTA,"A aw blocked");
        
            master->axi_aw_ready = false;
        }
    }else master->axi_aw_ready = false;
    return 0;
}

int AXI_wrapper::handle_w(int cycles){
    if(master->axi_w_valid){
        DEBUG(DEBUG_AXI,PRINT_BOLDWHITE,"get a  W");
        int w_cnt = coalesce_write.front().len - coalesce_write.front().remain;//第几拍
        for(int i=0; i<SIM_AXI_WIDTH; i++){
            coalesce_write.front().data[w_cnt*SIM_AXI_WIDTH+i] = master->axi_w_data[i];
        }
        coalesce_write.front().strb[w_cnt] = master->axi_w_strb;
        coalesce_write.front().remain --;
        master->axi_w_ready = true;
        
        if(master->axi_w_last){//收完数据了就从接受队列中取出，然后放到Write队列
            require_write.push(coalesce_write.front());
            coalesce_write.pop();
        }
    }

    if(!require_write.empty()){//检测一下，Darm能不能接新的Write请求，能接的话就写一个
        if(dram->WillAcceptTransaction(require_write.front().addr,true)){
            dram->AddTransaction(require_write.front().addr,true);
            inflight_write[require_write.front().addr].push(require_write.front());
            require_write.pop();
        }
    }
    return 0;
}

void AXI_wrapper::write_complete(uint64_t addr){
    if(inflight_write[addr].empty())ERROR("No inflight write found.");

    DEBUG(DEBUG_AXI,PRINT_BOLDCYAN,"Write at %lx finished",addr);

    while(!inflight_write[addr].empty()){ 
        const MemorySim::AXI_wreq& write_req = inflight_write[addr].front();
        bool wrap      = write_req.burst == 2;
        uint64_t waddr = write_req.addr & ~((1llu << write_req.size) - 1);
        uint64_t offset = 1 << write_req.size;
        uint64_t bound = offset * (write_req.len + 1);

        for(int i=0;i<=write_req.len;i++){
            ram->writen(waddr & 0xfffffffffffffff0,(void*)(write_req.data + i * SIM_AXI_WIDTH),SIM_AXI_WIDTH*4,write_req.strb[i]);
            waddr = addr_inc(wrap,bound,offset,waddr);
            DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Update wtask at wtask addr: %lx wtask burst: %d wtask len: %d",waddr,write_req.burst,write_req.len);
        }
        if(false && write_req.addr == 0x50016d40){
            for(int j = 0; j<SIM_AXI_MAX_LEN; j++){
                DEBUG(DEBUG_AXI,PRINT_MAGENTA,"data%d:%x(%x)",j,write_req.data[j],ram->read32(rtask.addr + j * 4 + SIM_AXI_WIDTH * 4 * (rtask.len - rtask.remain)));
            }
        }
        respond_write.push(write_req);
        inflight_write[addr].pop();
    }
    return;
}

int AXI_wrapper::handle_b (int cycles){
    if(respond_write.empty()){
        master->axi_b_valid = false;
    }else{
        DEBUG(DEBUG_AXI,PRINT_BOLDCYAN,"[%d]Issue B id = %x",cycles,respond_write.front().id);
        master->axi_b_valid = true;
        master->axi_b_resp = 0;
        master->axi_b_id = respond_write.front().id;
        if(master->axi_b_ready){
            DEBUG(DEBUG_AXI,PRINT_BOLDCYAN,"[%d]B done",cycles);
            #ifdef MONITOR_DRAM_SIM
            wchecker.remove(master->axi_b_id, cycles);
            #endif
            respond_write.pop();
        }
    }

    return 0;
}

bool AXI_wrapper::coalesce_full(){
    return coalesce_write.size() >= SIM_AXI_WCMAX; 
}

void AXI_wrapper::get_wtask(int cycles){
    wtask.size  = respond_write.front().size;
    wtask.burst = respond_write.front().burst;
    wtask.len   = respond_write.front().len;
    bool wrap = wtask.burst == 2;
    uint64_t offset = 1 << wtask.size;
    wtask.remain = wtask.len;

    wtask.addr = respond_write.front().addr;
    DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Get wtask at cycle %d. wtask addr: %lx wtask burst: %d wtask len: %d",cycles,wtask.addr,wtask.burst,wtask.len);
    return;
}


void AXI_wrapper::update_wtask(int cycles){
    wtask.remain--;
    bool wrap = wtask.burst == 2;
    uint64_t offset = 1 << wtask.size;
    uint64_t bound  = offset * (wtask.len + 1);
    wtask.addr = addr_inc(wrap,bound,offset,wtask.addr);
    DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Update wtask at cycle %d. wtask addr: %lx wtask burst: %d wtask len: %d",cycles,wtask.addr,wtask.burst,wtask.len);
    return;
}
}
