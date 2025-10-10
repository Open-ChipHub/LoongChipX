
#include "memorysim.h"

namespace MemorySim{

AXI_wrapper::AXI_wrapper(VTop *master,class RAM *ram,const std::string config_path,const std::string output_path):master(master),ram(ram),rchecker(0),wchecker(1){
    INFO(PRINT_BOLDYELLOW,"[AXI_wrapper] Initialized.\n");
    winflight = false;
    rinflight = false;
    rtask = {0};
    wtask = {0};
    dram = dramsim3::GetMemorySystem(config_path,output_path,nullptr,nullptr);
    dram->RegisterCallbacks(std::bind(&AXI_wrapper::read_complete, this, std::placeholders::_1),
                            std::bind(&AXI_wrapper::write_complete, this, std::placeholders::_1));
    dram->ResetStats();
    assert(SIM_AXI_WIDTH % 2 == 0); /** for use of handle_r()*/
    assert(respond_write.empty());
    return;
}

AXI_wrapper::~AXI_wrapper(){
    dram->PrintStats();
    return;
}

int AXI_wrapper::dramsim_tick(){
    // DEBUG(DEBUG_AXI,PRINT_BOLDCYAN,"Enter tick");
    dram->ClockTick();
    return 0;
}

int AXI_wrapper::handle_ar(int cycles){
    if (master->axi_ar_valid){
        if(dram->WillAcceptTransaction(master->axi_ar_addr,false)){
            struct AXI_rreq rreq={
                master->axi_ar_addr,
                master->axi_ar_size,
                master->axi_ar_burst,
                master->axi_ar_prot,
                0,
                master->axi_ar_id,
                master->axi_ar_len,
                0,
                0,
                0,
                0
            };
            dram->AddTransaction(rreq.addr,false);
            inflight_read[rreq.addr].push(rreq);
            #ifdef MONITOR_DRAM_SIM
            rchecker.insert(master->axi_ar_id, cycles);
            #endif
            master->axi_ar_ready = true;
            DEBUG(DEBUG_AXI,PRINT_BOLDCYAN,"Get ar at cycle %d. axi.addr:%lx req.addr: %lx id:%x burst: %d len: %d",cycles,master->axi_ar_addr,rreq.addr,rreq.id,rreq.burst,rreq.len);
        }else {
            DEBUG(DEBUG_AXI,PRINT_BOLDCYAN,"Block a  ar at cycle %d. addr: %lx burst: %d len: %d",cycles,master->axi_ar_addr,master->axi_ar_burst,master->axi_ar_len);
            master->axi_ar_ready = false;
        }
    }else master->axi_ar_ready = false;
    return 0;
}

void print_queue(std::queue<struct AXI_rreq> que){
    int i = 0;

        DEBUG(DEBUG_AXI,PRINT_BOLDWHITE,"Que SIZE=%lu",que.size());
    while(!que.empty()){
        auto &req = que.front();
        DEBUG(DEBUG_AXI,PRINT_BOLDWHITE,"#%d in queue: id[%d] addr[%lx] len[%d] size[%d]",i,req.id,req.addr,req.len,req.size);
        que.pop();
        i++;
    }
}

void AXI_wrapper::read_complete(uint64_t addr){
    // if(inflight_read[addr].empty()) ERROR("No read inflight found.");
    if(inflight_read[addr].empty()) DEBUG(DEBUG_AXI,PRINT_BOLDWHITE,"No read inflight of Addr[%lx]found.",addr);

    DEBUG(DEBUG_AXI,PRINT_DEBUG,"Read at %lx finished",addr);
    while(!inflight_read[addr].empty()){

        auto &read_req = inflight_read[addr].front();
        // ram->readn(inflight_read[addr].front().addr,inflight_read[addr].front().data,SIM_AXI_MAX_LEN*4);
        // ram->readn(read_req.addr,read_req.data,SIM_AXI_MAX_LEN*4);
        for(int i=0;i<SIM_AXI_MAX_LEN/SIM_AXI_WIDTH;i++){
            ram->readx((read_req.addr + i*SIM_AXI_WIDTH*4) & 0xfffffff0,&inflight_read[addr].front().data[SIM_AXI_WIDTH*i],read_req.cache & 0x1,read_req.addr,1 << read_req.size); // default cached size : SIM_AXI_WIDTH*4 = 128
        }
        // DEBUG(DEBUG_AXI,PRINT_DEBUG,"Read at %llx reqAddr[%llx] finished id=%x read_req.cache & 0x1[%d] 1 << read_req.size:%d",addr,read_req.addr,read_req.id,read_req.cache & 0x1,1 << read_req.size);
        for(int i=0;i<SIM_AXI_WIDTH;i++){
            DEBUG(DEBUG_AXI,PRINT_RED,"Data[%d]:%x",i,inflight_read[addr].front().data[i]);
        }
        
        if(inflight_read[addr].size() > 1){
            DEBUG(DEBUG_AXI,PRINT_RED,"!!!! inflight_read.size=%lu",inflight_read[addr].size());
            print_queue(inflight_read[addr]);
        }

        respond_read.push(inflight_read[addr].front());
        inflight_read[addr].pop();
    }
    return;
}

int AXI_wrapper::handle_r(int cycles){
    // DEBUG(DEBUG_AXI,PRINT_BOLDWHITE,"Enter R");
    if (respond_read.empty()){
        master->axi_r_last = false;
        master->axi_r_valid = false;
        return 0;
    }
    //Not Empty

    int r_id = respond_read.front().id;
    master->axi_r_id  = r_id;
    if (!rinflight){
        rinflight = true;
        get_rtask(cycles);
    }

    /** process according to rtask */
    for(int i=0; i<SIM_AXI_WIDTH; i++){
        master->axi_r_data[i] = rtask.data[i];

        ///assert
        if(master->axi_r_data[i] != ram->read32((rtask.addr & 0xfffffff0) + i * 4 + SIM_AXI_WIDTH * 4 * (rtask.len - rtask.remain))){
            DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Mismatch");
            DEBUG(DEBUG_AXI,PRINT_MAGENTA,"addr:%lx,len %d, remain:%d",rtask.addr,rtask.len,rtask.remain);
            for(int j = 0; j<SIM_AXI_WIDTH; j++){
                DEBUG(DEBUG_AXI,PRINT_MAGENTA,"data%d:%x(%x)",j,rtask.data[j],ram->read32(rtask.addr + j * 4 + SIM_AXI_WIDTH * 4 * (rtask.len - rtask.remain)));
            }
            //assert(master->axi_r_data[i] == ram->read32(rtask.addr + i * 4 + SIM_AXI_WIDTH * 4 * (rtask.len - rtask.remain)));
        }

        ///end assert
    }
    master->axi_r_last = rtask.remain == 0;

    /** handle next cycle task */
    if(master->axi_r_ready){
        /*
            valid必须要在ready后才置高，但是id必须先拉高，无论是否ready
            因为Spinal中的AXIArbiter是通过ID来分配的,即ready依赖于ID。
            C++所有更新都是在低沿更新，如果不等CPU的Ready就把valid拉高，会出现在低电平的半周期fire。
            会造成Verilog认为已经收了这个数据，而C++以为没收，于是就寄了。
        */
        master->axi_r_valid       = true;   
        DEBUG(DEBUG_AXI,PRINT_MAGENTA,"addr:%lx,id:%x,len %d, remain:%d",rtask.addr,r_id,rtask.len,rtask.remain);
        if(rtask.remain == 0){ 
            respond_read.pop();
            #ifdef MONITOR_DRAM_SIM
            rchecker.remove(master->axi_r_id, cycles);
            #endif
            rinflight = !respond_read.empty();
            if(rinflight) 
                get_rtask(cycles);
        }else 
            update_rtask(cycles);
        DEBUG(DEBUG_AXI,PRINT_MAGENTA,"data0:%x,data1:%x,data2:%x,data3=%x,remain=%d,rinflight=%d",rtask.data[0],rtask.data[1],rtask.data[2],rtask.data[3],rtask.remain,rinflight);
    }else{
        master->axi_r_valid       = false;
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
    rtask.size   = respond_read.front().size;
    rtask.burst  = respond_read.front().burst;
    rtask.len    = respond_read.front().len;
    rtask.remain = rtask.len;
    rtask.addr   = respond_read.front().addr;

    memcpy(rtask.data,respond_read.front().data,SIM_AXI_WIDTH*4);

    DEBUG(DEBUG_AXI,PRINT_MAGENTA,"Get rtask at cycle %d. rtask addr: %lx rtask burst: %d rtask len: %d",cycles,rtask.addr,rtask.burst,rtask.len);
    return;
}

void AXI_wrapper::update_rtask(int cycles){
    rtask.remain--;
    memcpy(rtask.data,&(respond_read.front().data[(rtask.len-rtask.remain)*SIM_AXI_WIDTH]),SIM_AXI_WIDTH*4);

    DEBUG(DEBUG_AXI,PRINT_GREEN,"Update rtask at cycle %d. rtask addr: %lx rtask burst: %d rtask size: %d rtask len: %d",cycles,rtask.addr,rtask.burst,rtask.size,rtask.len);
    return;
}


}
