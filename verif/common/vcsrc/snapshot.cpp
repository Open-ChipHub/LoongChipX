#include "snapshot.h"
#include <errno.h>

using namespace std;

SnapshotMoniter::SnapshotMoniter(){
    //attach ss_info to shared memory
    if((key[SNAPSHOT_SSINFO] = ftok(".",'3')) < 0){
        perror("[SnapshotMonitor] ss_info key");
        exit(EXIT_FAILURE);
    }

    if((id[SNAPSHOT_SSINFO] = shmget(key[SNAPSHOT_SSINFO],1024,0666 | IPC_CREAT/*|IPC_EXCL*/)) == -1){
        perror("[SnapshotMonitor] ss_info id");
        exit(EXIT_FAILURE);
    }

    if((ss_info = (SnapshotInfo*)(shmat(id[SNAPSHOT_SSINFO],NULL,0))) == (void*)-1){
        perror("[SnapshotMonitor] ss_info shmat");
        exit(EXIT_FAILURE);
    }

    //get shared semaphore
    if((key[SNAPSHOT_SEMAPHORE] = ftok(".",'2') < 0)){
        perror("[SnapshotMonitor] semaphore key");
        exit(EXIT_FAILURE);
    }
    if((id[SNAPSHOT_SEMAPHORE] = semget(key[SNAPSHOT_SEMAPHORE],1024,0666 | IPC_CREAT/*|IPC_EXCL*/)) == -1){
        perror("[SnapshotMonitor] semaphore id");
        exit(EXIT_FAILURE);
    }

    //init ss_info
    for(int i=0;i<SNAPSHOT_UPPERBOUND+1;i++){
        ss_info->error[i] = false;
        ss_info->wave[i] = false;
        ss_info->pid[i] = -1;
        ss_info->id[i] = 0;
    }
    ss_info->pid[SNAPSHOT_UPPERBOUND] = getpid();
    ss_info->cnt = 0;
    ss_info->id_allocator = 1; // start from 1 because 0 represents invalid
}

SnapshotMoniter::~SnapshotMoniter(){
    if(type == type_parent){
        if(semctl(id[SNAPSHOT_SEMAPHORE],1,IPC_RMID,0) == -1) // remove semaphore
        {
            perror("[SnapshotMonitor] semaphore semctl rm:");
        }
        if(shmdt(ss_info) == -1){
            perror("[SnapshotMonitor] ss_info shmdt");
        }

        if(shmctl(id[SNAPSHOT_SSINFO],IPC_RMID,NULL) == -1){
            perror("[SnapshotMonitor] ss_info shmctl");
        }
    }
}

void SnapshotMoniter::ss_wait(int index){
    // unsigned short index;
    // find the target semaphore
    // for(int i=0;i < SNAPSHOT_UPPERBOUND; i++){
    //     DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,comparing %d",getpid(),i);
    //     if(ss_info->pid[i] == getpid()){
    //         index = i;
    //         break;
    //     }
    // }
    sembuf sembuf_minus={(short unsigned int)index,-1,SEM_UNDO};
    DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,waiting on semaphore %d",getpid(),index);
    // try to get targeted semaphore
    while(true){
        int ret = semop(id[SNAPSHOT_SEMAPHORE],&sembuf_minus,1);
        if(ret == 0)break;
        if(errno != EINTR)abort();
        DEBUG(DEBUG_MAIN,PRINT_DEBUG,"wakeup by intr(PID: %d,waiting on semaphore %d)",getpid(),index);
    }

    DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,get semaphore %d and continue",getpid(),index);
}

Snapshot::Snapshot(bool wave_open, int rollback_dist){
    this->pid  = getpid();
    this->active_pid = this->pid;
    this->wave = wave_open;
    this->error = false;
    this->trace_reopen = wave_open;
    this->trace_opened = false;
    this->rollback_dist = rollback_dist;
}

Snapshot::~Snapshot(){
    ;
}

int Snapshot::find_victim(){
    int index = 0;
    int min_id = ss_moniter.ss_info->id[0];
    for(int i=0;i<SNAPSHOT_UPPERBOUND;i++){
        if(ss_moniter.ss_info->id[i] == 0){
            return -1;
        }else if(ss_moniter.ss_info->id[i] < min_id){
            index = i;
            min_id = ss_moniter.ss_info->id[i];
        }
    }
    return index;
}

int Snapshot::find_vacant(){
    for(int i=0;i<SNAPSHOT_UPPERBOUND;i++){
        if(ss_moniter.ss_info->id[i] == 0) return i;
    }
    return -1;
}

int Snapshot::find_latest(){
    int index = -1;
    int sort[SNAPSHOT_UPPERBOUND];
    int max_id = 0;
    for (int i = 0; i < SNAPSHOT_UPPERBOUND; i++) {
        sort[i] = i;
    }

    for (int i = 0; i < SNAPSHOT_UPPERBOUND - 1; i++)
        for (int j = 0; j < SNAPSHOT_UPPERBOUND - 1 - i; j++)
            if (ss_moniter.ss_info->id[sort[j]] > ss_moniter.ss_info->id[sort[j + 1]])
                swap(sort[j], sort[j + 1]);

    // for(int i=0;i<SNAPSHOT_UPPERBOUND;i++){
    //     if(ss_moniter.ss_info->id[i] == 0) continue;
    //     if(ss_moniter.ss_info->id[i] > max_id){
    //         index = i;
    //         max_id = ss_moniter.ss_info->id[i];
    //     }
    // }
    for(int i = SNAPSHOT_UPPERBOUND - this->rollback_dist; i < SNAPSHOT_UPPERBOUND; i++) {
        if (ss_moniter.ss_info->id[sort[i]] != 0) return sort[i];
    }

    return index;
}

int Snapshot::snapshot_insert(int index,pid_t pid){
    ss_moniter.ss_info->id[index]  = ss_moniter.ss_info->id_allocator;
    ss_moniter.ss_info->pid[index] = pid;
    ss_moniter.ss_info->cnt++;
    ss_moniter.ss_info->id_allocator ++; 
    return 0;
}

int Snapshot::snapshot_recycle(){
    //kill the victim snapshot process
    //victim is the oldest element in pid_list defualtly
    pid_t victim = find_victim();
    if(victim == -1) ERROR("Vacant available, no need to recycle.");

    ss_moniter.ss_info->id[victim] = 0;
    victim = ss_moniter.ss_info->pid[victim];
    kill(victim,SIGKILL);
    waitpid(victim,NULL,0);
    ss_moniter.ss_info->cnt--;
    DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"kill %d",victim);
    return 0;
}

int Snapshot::snapshot_gen(){
    //if pid_list is full, kill the victim snapshot process
    if(ss_moniter.ss_info->cnt == SNAPSHOT_UPPERBOUND){
        DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,gen snapshot: need recycle",getpid());
        snapshot_recycle();
    }

    int index = find_vacant();
    if(index == -1) ERROR("Can't find vacant.");
    //fork
    if((pid = fork()) < 0){
        ERROR("fork fail!");
        return -1;
    }else if(pid != 0){ // parent insert child's pid into pid_list
        //for parent process, fork() returns child's pid
        //for child  process, fork() returns 0
        DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,gen snapshot: vacant found %d",getpid(),index);
        snapshot_insert(index,pid);
        return 0;
    }
    // child process
    type = type_child;
    ss_moniter.type = type_child;
    DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,gen snapshot: child process waiting",getpid());
    ss_moniter.ss_wait(index);
    this->error = false;
    this->wave = true;
    this->trace_reopen = true;
    return 0;
}

int Snapshot::snapshot_wakeup(){
    if(type == type_parent){
        int index = find_latest();
        if(index == -1){
            ERROR("Can not find proper snapshot.");
            return -1;
        }
        DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"PID: %d,trying to wakeup snapshot %d",getpid(),index);
        pid_t pid = ss_moniter.ss_info->pid[index];
        INFO(PRINT_BLUE,"[Snapshot] Switch to snapshot %d, PID: %d\n",index,pid);
        active_pid = pid;
    
        sembuf sem_buf ={(unsigned short)index,1,};
        semop(ss_moniter.id[SNAPSHOT_SEMAPHORE],&sem_buf,1);

        // wait until child process return
        if(waitpid(pid,NULL,0) == -1) ERROR("waitpid wrong");
        INFO(PRINT_BLUE,"[Snapshot] Return from snapshot %d\n",index);
    }
    
    return 0;
}

int Snapshot::snapshot_clear(){
    INFO(PRINT_BLUE,"[Snapshot] Clear all snapshots\n");
    for(int i=0; i<SNAPSHOT_UPPERBOUND;i++){
        if(ss_moniter.ss_info->id[i] == 0) continue;
        ss_moniter.ss_info->id[i] = 0;
        pid_t victim = ss_moniter.ss_info->pid[i];
        kill(victim,SIGKILL);
        waitpid(victim,NULL,0);
        ss_moniter.ss_info->cnt--;
        DEBUG(DEBUG_SNAPSHOT,PRINT_DEBUG,"kill %d",victim);
    }
    return 0;
}

bool Snapshot::snapshot_isparent(){
    return type == type_parent;
}

void Snapshot::snapshot_stats(){
    INFO(PRINT_BLUE,"[Snapshot]:\n");
    INFO(PRINT_BLUE,"  cnt:%d,id_allocator:%d\n",ss_moniter.ss_info->cnt,ss_moniter.ss_info->id_allocator);
    INFO(PRINT_BLUE,"  ID\tPID\tERROR\n");
    for(int i=0; i<SNAPSHOT_UPPERBOUND;i++){
        INFO(PRINT_BLUE,"  %d\t%d\t%d\n",ss_moniter.ss_info->id[i],ss_moniter.ss_info->pid[i],ss_moniter.ss_info->error[i]);
    }
}

pid_t Snapshot::get_parent_pid(){
    return pid;
}

pid_t Snapshot::get_active_pid(){
    return active_pid;
}

int Snapshot::error_set(){
    this->error = true; 
    return 0;
}

int Snapshot::error_clear(){
    this->error = false; 
    return 0;
}
