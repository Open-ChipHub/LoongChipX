#ifndef __SNAPSHOT_H
#define __SNAPSHOT_H

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <sys/sem.h>
#include <list>

#ifdef __linux__
#include <sys/wait.h>
#endif

#include "commonprint.h"

#define SNAPSHOT_UPPERBOUND 10
#define SNAPSHOT_SSINFO 0
#define SNAPSHOT_SEMAPHORE 1

const int type_parent = 1;
const int type_child  = 2;

/** shared info in shared memory */
typedef struct SnapshotInfo{
    /** whether a process has went wrong */
    bool  error[SNAPSHOT_UPPERBOUND+1]; // one more for current process
    /** whether a process dump wave */
    bool  wave[SNAPSHOT_UPPERBOUND+1]; // one more for current process
    /** processes' pid */
    pid_t pid [SNAPSHOT_UPPERBOUND+1];

    int id[SNAPSHOT_UPPERBOUND];
    int cnt;
    int id_allocator;
}SnapshotInfo;

/** snapshot manager of original thread */
class SnapshotMoniter{
    
public:
    /** ipc key */
    key_t key[2]; // one for ss_info, one for semaphore
    /** ipc id for ss_info */
    int id[2]; // one for ss_info, one for semaphore
    /** whether it is parent process, in case of false release of shared memory */
    int type = type_parent;
    /** snapshot info shared by all process */
    SnapshotInfo *ss_info;

    SnapshotMoniter();
    ~SnapshotMoniter();

    void ss_wait(int);
};

class Snapshot{
    pid_t pid = -1;
    pid_t active_pid = -1;
    int   type = type_parent;
    SnapshotMoniter ss_moniter;

    typedef int (*call_back)(void);

private:
    int find_victim();
    int find_vacant();
    int find_latest();
    int snapshot_insert(int,pid_t);
    int snapshot_recycle();

public:
    bool wave;
    bool error;
    bool trace_reopen;
    bool trace_opened;
    int rollback_dist;

    int  error_set();
    int  error_clear();

    pid_t get_parent_pid();
    pid_t get_active_pid();

    int  snapshot_gen();
    int  snapshot_wakeup();
    int  snapshot_clear();
    bool snapshot_isparent();
    void snapshot_stats();

    Snapshot(bool wave_open, int rollback_dist);
    ~Snapshot();
};



#endif
