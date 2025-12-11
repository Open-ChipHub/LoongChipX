#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <sys/timeb.h>
#include <mutex>
#include <atomic>
#include <thread>
#include <condition_variable>


// function : dev_read
// description : read data from device to local memory (buffer), (i.e. device-to-host)
// parameter :
//       dev_fd : device instance
//       addr   : source address in the device
//       buffer : buffer base pointer
//       size   : data size
// return:
//       int : 0=success,  -1=failed
int dev_read (int dev_fd, uint64_t addr, void *buffer, uint64_t size) {
    if ( addr != lseek(dev_fd, addr, SEEK_SET) )                                 // seek
        return -1;                                                               // seek failed
    if ( size != read(dev_fd, buffer, size) )                                    // read device to buffer
        return -1;                                                               // read failed
    return 0;
}


// function : dev_write
// description : write data from local memory (buffer) to device, (i.e. host-to-device)
// parameter :
//       dev_fd : device instance
//       addr   : target address in the device
//       buffer : buffer base pointer
//       size   : data size
// return:
//       int : 0=success,  -1=failed
int dev_write (int dev_fd, uint64_t addr, void *buffer, uint64_t size) {
    if ( addr != lseek(dev_fd, addr, SEEK_SET) )                                 // seek
        return -1;                                                               // seek failed
    if ( size != write(dev_fd, buffer, size) )                                   // write device from buffer
        return -1;                                                               // write failed
    return 0;
}

void load_mem(int wfd, const char* path) {
    FILE* fd = fopen(path, "r");
    if (fd < 0) {
        perror("open mem file");
        return;
    }
    while (!feof(fd)) {
        uint64_t addr = 0;
        char buf[10240];
        uint8_t buf_rev[10240];
        char buf_char[3];
        buf_char[3] = '\0';
        int ret = fscanf(fd, "%lx", &addr);
        if (ret != 1) {
            break;
        }
        fscanf(fd, "%s", buf);
        for (int i = 0; i < strlen(buf) / 2; i++) {
            int ix2 = i << 1;
            buf_char[0] = buf[strlen(buf) - 2 - ix2];
            buf_char[1] = buf[strlen(buf) - 1 - ix2];
            buf_rev[i] = strtol(buf_char, NULL, 16);
        }
        dev_write(wfd, addr, buf_rev, strlen(buf));

    }
    fclose(fd);
}


int main() {
    int rfd = open("/dev/xdma0_c2h_0", O_RDONLY);
    if (rfd < 0) {
        perror("open /dev/xdma0_c2h_0");
        return -1;
    }
    int wfd = open("/dev/xdma0_h2c_0", O_WRONLY);
    if (wfd < 0) {
        perror("open /dev/xdma0_h2c_0");
        return -1;
    }
    FILE* fd = fopen("./xdma_rw.bin", "wb");
    if (fd < 0) {
        perror("open bin file");
        return -1;
    }
    load_mem(wfd, "/home/lizilin/projects/LoongChipX/impl/work-xlnx/vmlinux.ddr.upload");
    int data = 1;
    dev_write(wfd, 0x12ff00000ULL, &data, sizeof(data));
    sleep(1);
    data = 0;
    dev_write(wfd, 0x12ff00000ULL, &data, sizeof(data));
    char buf[512];
    for (int i = 0; i < 1000; i++) {
        dev_read(rfd, 0x13ff00000ULL, buf, 512);
        fwrite(buf, 512, 1, fd);
    }
    fclose(fd);
    return 0;

}
