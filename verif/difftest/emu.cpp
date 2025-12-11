#include <cstdio>
#include <sys/mman.h>
#include <stdlib.h>
#include "emu.h"
#include "lightsss.h"
#include "build_config.h"
#include <zlib.h>
#include "compress.h"

int enable_fork = 0;

static VTop *top = nullptr;

FILE* trace_out;
FILE* uart_out;
FILE* diff_out;

/* ram to emu */
static uint8_t *ram;
static long img_size = 0;
void *get_img_start() { return &ram[0]; }

static unsigned long trace_next_start = 0;
static int prefix_end;
static unsigned long tail_base = 0;

long long inst_total;
struct timeval start, end;

char* chiplab_home;
char* difftest_ref_so;

std::chrono::nanoseconds diff_nano_seconds = std::chrono::nanoseconds(0);

static vluint64_t hex2int64(const char *buf, const int width) {
    vluint64_t data = 0, h = 0;
    for (int i = 0; i < width; i += 1) {
        h = ('a' <= buf[i]) ? buf[i] - 'a' + 10 : buf[i] - '0';
        data = (data << 4) | h;
    }
    return data;
}

Emulator::Emulator(VTop *topp, const char *path, const char *file_out, const char *uart_path, const char *file_in, const char *data_vlog):
          trapCode(STATE_RUNNING)
{
    dm = new DiffManage();
#ifdef DIFF_HARDWARE
    xdma = new XDMA();
#endif
    top = topp;

    sprintf(simu_out_path, "./%s%s", path, file_out);

#ifdef SLICE_SIMU_TRACE
    int simu_out_path_index = 0;
    char suffix[80];
    int suffix_index = 0;
    while (simu_out_path[simu_out_path_index] != '\0') {
        simu_out_path_index++;
    }
    prefix_end = simu_out_path_index;
    sprintf(suffix, ".%ldns-%ldns", trace_next_start, trace_next_start+TRACE_SLICE_SIZE);
    while (suffix[suffix_index] != '\0') {
        simu_out_path[simu_out_path_index] = suffix[suffix_index];
        simu_out_path_index++;
        suffix_index++;
    }
    simu_out_path[simu_out_path_index] = '\0';
    trace_next_start += TRACE_SLICE_SIZE;
#endif

    if ((trace_out = fopen(simu_out_path, "w")) == NULL) {
        printf("simu_trace.txt open error!!!!\n");
        fprintf(trace_out, "simu_trace.txt open error!!!!\n");
        exit(1);
    }

    sprintf(uart_out_path, "./%s%s", path, uart_path);
    if ((uart_out = fopen(uart_out_path, "w")) == NULL) {
        printf("uart.txt open error!!!!\n");
        fprintf(trace_out, "uart.txt open error!!!!\n");
        if (trace_out) fclose(trace_out);
        exit(1);
    }

    char diff_out_path[128];
    const char uart_output_file[] = "/diff.bin";
    sprintf(diff_out_path, "./%s%s", path, uart_output_file);
    if ((diff_out = fopen(diff_out_path, "wb")) == NULL) {
        printf("diff.bin open error!!!!\n");
        fprintf(diff_out, "diff.bin open error!!!!\n");
        if (diff_out) fclose(diff_out);
        exit(1);
    }

    // init_ram(path, file_in);
    #ifdef RAND_TEST
    init_random_vlog(path, data_vlog);
    #endif
    if (enable_fork) {
        lightsss = new LightSSS;
        FORK_PRINTF("enable fork debugging...\n")
    }
}

void Emulator::init_emu(vluint64_t* main_time, uint64_t snapshot_dist, bool proxy_snapshot) {
    this->main_time = main_time;
    dm->init_difftest();
    dm->snapshot_dist = snapshot_dist;
    dm->proxy_snapshot = proxy_snapshot;
}

void Emulator::init_ram(uint8_t* ram, uint64_t size) {
    assert(ram != NULL);
    this->ram = ram;
    this->ram_size = size;
    dm->init_ram(ram);
}

void Emulator::init_ram(const char *path, const char *file_in) {
    sprintf(img, "./%s%s", path, file_in);
    assert(img != NULL);
    printf("The image is %s\n", img);

    /* initialize memory using Linux mmap */
    printf("Using simulated %luMB RAM\n", EMU_RAM_SIZE / (1024 * 1024));
    ram = (uint8_t *) mmap(NULL, EMU_RAM_SIZE, PROT_READ | PROT_WRITE, MAP_ANON | MAP_PRIVATE, -1, 0);
    if (ram == (uint8_t *) MAP_FAILED) {
        printf("Cound not mmap 0x%lx bytes\n", EMU_RAM_SIZE);
        assert(0);
    }

    int ret = 0;
    if (!strcmp(img + (strlen(img) - 4), ".dat")) { // file extension: .dat
        FILE *fp = fopen(img, "rt");
        assert(fp != nullptr);
        char buf[32];
        int cnt = 0;
        char tmp_buf[8] = {0};
        vluint64_t ptr = 0;
        while (fscanf(fp, "%32s", buf) != EOF) {
            if (buf[0] == '@') {
                /*
                if(cnt != 0) {
                    ram[ptr] = hex2int64(tmp_buf, 8);
                    cnt = 0;
                }
                */
                sscanf(buf + 1, "%lx", &ptr);
                //ptr = ptr/4;
            } else {
                /*
               if (cnt != 3) {
                    tmp_buf[6-2*cnt] = buf[0];
                    tmp_buf[7-2*cnt] = buf[1];
                    cnt += 1;
               }
               else {
                    tmp_buf[6-2*cnt] = buf[0];
                    tmp_buf[7-2*cnt] = buf[1];
                    cnt = 0;
                    ram[ptr] = hex2int64(tmp_buf, 8);
                    printf("addr: %lx\n data: %lx\n", ptr*4, ram[ptr]);
                    ptr += 1;
               }
               */
                ram[ptr] = hex2int64(buf, 2);
                ptr += 1;
            }
        }
        if (cnt != 0) {
            //ram[ptr] = hex2int64(tmp_buf, 8);
            ram[ptr] = hex2int64(buf, 2);
        }
        fclose(fp);
    } else if (!strcmp(img + (strlen(img) - 4), ".bin")) {  // file extension: .dat
        FILE *fp = fopen(img, "rb");
        if (fp == NULL) {
            printf("Can not open '%s'\n", img);
            assert(0);
        }

        fseek(fp, 0, SEEK_END);
        img_size = ftell(fp);
        if (img_size > EMU_RAM_SIZE) {
            img_size = EMU_RAM_SIZE;
        }

        fseek(fp, 0, SEEK_SET);
        ret = fread(ram, img_size, 1, fp);

        assert(ret == 1);
        fclose(fp);
    } else {
        printf("%s file format is not supported. You should use file format like xxx.dat or xxx.bin.\n", img);
        exit(1);
    }
}
void Emulator::init_random_vlog(const char *path, const char *file_in) {
    sprintf(img, "./%s%s", path, file_in);
    assert(img != NULL);
    printf("Data vlog is %s\n", img);
    FILE *data_vlog = fopen(img, "rt");
    
    vluint64_t addr;
    int byte_num,data;
    char line[65];
    while(fgets(line,65,data_vlog)!=NULL){
        sscanf(line,"%llx %x  %x\n",&addr, &byte_num,&data);
        int data_temp = data;
        if (byte_num == 1) {
            ram[addr] = (char) data;
        } else {
            for (int i=0;i<byte_num;i++) {
                data_temp = data_temp&0xff;
                ram[addr+i] = (char)data_temp;
                data_temp = data>>(8*((i+1)%4));
            }
        }
    }
}

void Emulator::close() {
    if (trace_out) {
        fclose(trace_out);
    }
    int i;
    //clear simu_out_path string
    for (i = prefix_end; i < 128; i++) {
        simu_out_path[i] = 0;
    }
#ifdef DIFF_HARDWARE
    xdma->stop();
#endif
}

#ifdef DIFF_HARDWARE
int Emulator::hard_process(std::vector<addr_map_t> addr_maps) {
    dm->write_csr_ref2dut();
    for (auto& map : addr_maps) {
        xdma->dev_write(map.start, ram + map.start, map.size);
    }
    return xdma->start();
}
#endif

int Emulator::process() {
    if (enable_fork && is_fork_child() && main_time != 0) {
        if (*main_time == lightsss->get_end_cycles()) {
            FORK_PRINTF("checkpoint has reached the main process abort point: %lu\n", *main_time)
        }
        if (*main_time == lightsss->get_end_cycles() + 10) {
            return status_fork_forward;
        }
    } else if(!enable_fork){
    }

    trapCode = dm->difftest_state();
    // if (trapCode != STATE_RUNNING) {
    //     printf("trapeCode = %d\n", trapCode);
    //     return 0;
    // }
    auto start = std::chrono::steady_clock::now();
    trapCode = dm->do_step(*main_time);
    auto end = std::chrono::steady_clock::now();
    diff_nano_seconds += std::chrono::nanoseconds(end-start);

    if (enable_fork) {
        static bool have_initial_fork = false;
        uint64_t timer = uptime();
        // check if it's time to fork a checkpoint process
        if (((timer - lasttime_snapshot > FORK_INTERVAL) || !have_initial_fork) && !is_fork_child()) {
            have_initial_fork = true;
            lasttime_snapshot = timer;
            switch (lightsss->do_fork()) {
                case FORK_ERROR: return -1;
                case FORK_CHILD: fork_child_init();
                default: break;
            }
        }
    }
    switch (trapCode) {
        case STATE_RUNNING:
            return 0;
        case STATE_END:
            return status_test_end;
        case STATE_TIME_LIMIT:
            return status_time_limit;
        default:
            dm->display();
            return status_trace_err;
    }
}

// BUG: restore to keeptiming_advance() may fall into infinite loop
void Emulator::fastforward(uint64_t cycles) {
    for (int i = 0; i < 10; i++) {
        top->clk = !top->clk;
        top->eval();
        top->clk = !top->clk;
        top->eval();
    }
    dm->fastforward(cycles);
    top->reset = !1;
    for (int i = 0; i < 2; i++) {
        top->clk = !top->clk;
        top->eval();
        top->clk = !top->clk;
        top->eval();
    }
    dm->fastforward_end();
    *main_time = dm->get_fastforward_cycle();
}

void Emulator::save_checkpoint(const char* path) {
    dm->save_checkpoint(path);
    char buf[1024];
    sprintf(buf, "%s/ram.gz", path);
    MMapCompressor::compressAndSave(this->ram, this->ram_size, buf);
}

void Emulator::restore_checkpoint(const char* path) {
    dm->restore_checkpoint(path);
    char buf[1024];
    sprintf(buf, "%s/ram.gz", path);
    MMapCompressor::loadAndDecompress(buf, this->ram);
}

void Emulator::fork_child_init() {
#ifdef VERILATOR_VERSION_INTEGER // >= v4.220
    #if VERILATOR_VERSION_INTEGER >= 5016000
    // This will cause 288 bytes leaked for each one fork call.
    // However, one million snapshots cause only 288MB leaks, which is still acceptable.
    // See verilator/test_regress/t/t_wrapper_clone.cpp:48 to avoid leaks.
    top->atClone();
    #else
    // #error Please use Verilator v5.016 or newer versions.
    #endif                 // check VERILATOR_VERSION_INTEGER values
#elif EMU_THREAD > 1   // VERILATOR_VERSION_INTEGER not defined
    #ifdef VERILATOR_4_210 // v4.210 <= version < 4.220
    top->vlSymsp->__Vm_threadPoolp = new VlThreadPool(top->contextp(), EMU_THREAD - 1, 0);
    #else                  // older than v4.210
    top->__Vm_threadPoolp = new VlThreadPool(top->contextp(), EMU_THREAD - 1, 0);
    #endif
#endif

    FORK_PRINTF("the oldest checkpoint start to dump wave and dump nemu log...\n")
}

Emulator::~Emulator() {
    fclose(trace_out);
    fclose(uart_out);
    fclose(diff_out);
    if (enable_fork && !is_fork_child()) {
        if (need_wakeup) {
            lightsss->wakeup_child(*main_time);
        } else {
            lightsss->do_clear();
        }
        delete lightsss;
    }

    delete dm;
    dm = NULL;
#ifdef DIFF_HARDWARE
    delete xdma;
    xdma = NULL;
#endif
}
