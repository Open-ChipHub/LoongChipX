
#include "memorysim.h"
#include <cassert>

namespace MemorySim{
    AXI_checker::AXI_checker(int channel_id){
        this->channel_id = channel_id;
        //assert(SIM_AXI_ID == 7);
        for(int i=0;i < (1 << (SIM_AXI_ID));i += 1){
            time[i] = -1;
            next[i] = -1;
            prev[i] = -1;
        }
        head = last = -1;
        last_cycles = 0;
    }

    void AXI_checker::check(int cycles){
        if(head != -1){
            if(time[head] + 40000 < cycles){
                ERROR("AXI ID %d in channel %d is pending for too many cycles.", head, channel_id);
            }
        }
        last_cycles = cycles;
    }
    AXI_checker::~AXI_checker(){
        check(last_cycles);
        fprintf(stderr, "AXI checker %d seems OK\n", channel_id);
    }
    void AXI_checker::insert(int id, int cycles){
        //fprintf(stderr, "I%d[%d](from %d)\n", channel_id, id, last);
        check(cycles);
        assert(time[ id ] == -1);
        assert(next[ id ] == -1);
        if(head == -1){
            assert(last == -1);
            head = last = id;
        } else {
            assert(last != -1);
            next[last] = id  ;
            prev[ id ] = last;
            last = id;
        }
        time[id] = cycles;
    }
    void AXI_checker::remove(int id, int cycles){
        assert(time[ id ] >= 0);
        //fprintf(stderr, "R%d[%d..%d->%d->%d..%d]", channel_id, head, prev[id], id, next[id], last);
        check(cycles);
        if(head == id){
            assert(prev[id] == -1);
            head = next[id];
        } else {
            assert(prev[id] != -1);
            next[prev[id]] = next[id];
        }
        if(last == id){
            assert(next[id] == -1);
            last = prev[id];
        } else {
            assert(next[id] != -1);
            prev[next[id]] = prev[id];
        }
        next[id] = -1;
        prev[id] = -1;
        time[id] = -1;
    }
}
