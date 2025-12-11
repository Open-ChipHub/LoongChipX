
# xdma 驱动安装

- 安装xdma驱动

```
git clone https://github.com/Xilinx/dma_ip_drivers.git
cd dma_ip_drivers/XDMA/linux-kernel/xdma
sudo make install
```

- 将下面命令添加到开机任务中

```
/sbin/modprobe xdma poll_mode=1
```

- 编译bitstream: 修改`scripts/run.tcl`中`XILINX_XDMA := 1`，进入`impl/`目录运行make生成bitstream
- 运行测试:
    1. 将板子的pcie接口连接到主板的pcie接口
    2. 加载bitstream到板子(板子最好独立供电)
    3. 主机**关机**并重启,如果pcie成功识别板子上的led会被点亮
    4. `cd dma_ip_drivers/XDMA/linux-kernel/tests && sudo ./load_driver.sh`
    5. 如果测试通过，说明xdma驱动安装成功

# 寄存器地址

0x0-0xffffffff: 4G空间，写入内存
0x12ff00000: 写入reset寄存器
0x13ff00000: 读取difftest数据

# package格式

每一个difftest包分为包头和包体, 只有变化的数据才会写入包体，包头长度固定为3字节,所有数据都以1字节对齐

```
package_head

[0:0]: valids: 表示ExcpEvent, TrapEvent等是否有效
[3:1]: package_len：整个包的大小，包含包头

TrapEvent:
[0:0]: valids: 表示TrapEvent各个字段是否有效，1字节
例如 valids为4'b1101, 
valids[0]为code字段，1字节，
valids[2]为cycleCnt,8字节，
valids[3]为instrCnt,8字节
那么TrapEvent的包体为{instrCnt, cycleCnt, code, valids}

GREG, FPREG, CSR
由于这三个数量较大，因此它的包体结构为:
{{reg_val, reg_id}, {reg_val, reg_id}, ..., reg_num}
reg_num为1字节，表示记录了多少个变更的寄存器
reg_id为1字节，31-0表示greg,65-32表示fpreg,其他是csr
reg_val为8字节

具体解析过程可以查看verif/difftest/xdma.cpp的diff函数

TLBEvent目前未使用，可以在xdma_diff.v中修改diff_valids开启
```

# xdma-difftest

- 修改`verif/common/verilator.mk`中`HARDWARE := 1`
- 烧写bitstream加载xdma驱动
- 进入`verif/verilator/VerSimKernel`，执行`sudo make`,会自动加载upload文件到内存并开启测试,
upload文件目录可以通过在config中添加`image_path=/path/to/upload/file`修改
