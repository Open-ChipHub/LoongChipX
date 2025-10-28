# LoongChipX

**LoongChipX** is an open-source heterogeneous multi-core processor platform. It includes the high-performance, multiple-issue, out-of-order LabCore364; the five-stage pipelined LabCore164; the LoongArch32-compatible small core LabCore132; as well as a high-performance six-issue processor currently under development. Our goal is to build a multi-core heterogeneous processor platform that supports simulation and verification, and provides corresponding software support, such as the Linux kernel, GCC, LLVM compiler, and more.

中文说明[在此](README.zh-cn.md).

## Table of Contents
- [Introduction](#intro_en)
- [Directory Structure](#instr_en)
- [Design Document](#design_en)
- [Quick Start](#start_en)

## <a nane="intro_en"></a> Introduction

### 364

The 364 is a 64-bit high-performance processor core designed for embedded systems and SoC applications, based on the LoongArch instruction set architecture. The design focuses on performance optimization, implementing advanced high-performance techniques such as a 3-issue, 8-execution superscalar architecture.

### 164

The 164 is a 64-bit ultra-high-efficiency processor core designed for embedded systems, based on the LoongArch instruction set architecture. The architecture implements a 5-stage dual-issue in-order pipeline and is specifically optimized for low power consumption.

### 132

132 is a 32-bit processor core designed for embedded systems, featuring the LoongArch32 instruction set and supporting simulation verification and rapid development.

## <a name="instr_en"></a> Directory Structure

The directory structure is as follows:

```shell
LoongChipX
├── design
│   ├── common    (Shared code)
│   ├── soc       (Code for Soc top)
│   └── sys
│       ├── ccx   (Code for Cache Coherence Protocols)
│       ├── core  (Code for Cores)
│       │   ├── lc164    (5-stage core，with l1DCache and l1ICache,100K LOC)
│       │   └── lc364    (3-issue core，with l1DCache and l1ICache,300K LOC)
│       ├── filelists    (file lists)
│       └── llc   (Code for Last Level Cache)
├── impl     (files for FPGA implement)
├── ip       (IP for FPGA implement)
├── scripts  (scripts)
└── verif    (files for verification)
    ├── common   (common codes)
    ├── config   (config files)
    ├── ext      (testbench)
    │   ├── loader    (Code for program loader)
    │   ├── simu-coremark-mmu    (coremark with mmu)
    │   ├── simu-coremark-user   (Bare-Metal coremark)
    │   ├── simu-funcs    (function test)
    │   ├── simu-hello    (hello function test)
    │   ├── simu-hello-dual-core    (hello function test with dual cores)
    │   ├── simu-hello-quad-core    (hello function test with quad cores)
    │   └── simu-kernel   (kernel test)
    ├── filelists
    ├── vcs
    │   ├── CoreMark
    │   └── Hello
    └── verilator
        ├── VerSimApp
        ├── VerSimCKP
        └── VerSimKernel
```

## <a name="design_en"></a> Design Document

TODO

## <a name="start_en"></a> Quick Start

The following instructions will allow you to compile and run a Verilator model of the ChipX Cpre within testbenchs, and implement on FPGA.


### Development Environment

Before compiling and running, please check if the development environment meets the following requirements:
- Make. version 4.3 or higher.
- The simulation tools. supporting Verilator and Verdi, with Verilator version 5.008 or higher.
- Clang compiler. version 14.0.0 or higher.
- Serial port software, such as minicom, version 2.8 or higher.
- Linux kernel.version 6.10,git clone from github.
- Cross Compiler. verison 13.0 or higher,git clone from 可从[build_Tools](https://github.com/loongson/build-tools/releases/).
- Vivado.version 2022.2.

### simulator run

1.Checkout the repository and initialize all submodules.
``` shell
git clone https://github.com/Open-ChipHub/LoongChipX.git
cd LoongChipX
git submodule update --init --recursive
```

2.Compile testbench

The testbenchs we support include:
- hello: The "Hello World" program.
- func: Some test programs targeting modules such as LSU and CSR.
- coremark: A performance benchmark program.
- linux kenel: The Linux kernel.

before we compile testbenchs,set the environment variable.
``` shell
export CROSS_COMPILE=loongarch64-linux-gnu-gcc
export PATH=/path/of/your/cross_compile/bin:$PATH
```

go to directory and compile.such as coremark
``` shell
cd ext/simu-coremark-user
make
```

follow these instructions for compile linux kernel.
编译linux内核时，请执行以下指令
``` shell
make ARCH=loongarch CROSS_COMPILE=loongarch64-linux-gnu- menuconfig
make -j4
cp vmlinux $(LoongChipX_PATH)/verif/ext/simu-kernel/
```

The simulation environment supports various functions, which can be achieved by modifying the config file as needed.

The specific parameters and their meanings in the config file are shown below:

| Parameter       | Range              | Function                                     |
| --------------- | ------------------ | -------------------------------------------- |
| bios_mode       | 'auto' or binary file path | BIOS mode. 'auto' means the simulation environment automatically generates the BIOS; a specific BIOS file path can also be provided |
| kernel          | Binary file path   | Test case. Specify the binary file path of the test program |
| log_dir         | Directory          | Path to save simulation results                |
| runtime_wave    | '0' or '1'         | Whether to keep the simulation waveform files  |
| random_test     | '0' or '1'         | Whether to perform random instruction testing  |
| random_test_dir | Directory for random instruction testing | File path for random instruction test cases |
| difftest        | '0' or '1'         | Whether to perform DiffTest                      |


3. Compile and Simulation

follow these instructions for Verilator.
``` shell
cd verif/verilator/VerSimApp
make CXX=clang
```
Output for waveform and serial-print can be found in `verif/verilator/VerSimApp/logs/`.

Otherwise,follow these instructions for Vcs.
``` shell
cd verif/vcs/CoreMark
make
```
Output for waveform and serial-print can be found in `verif/vcs/Coremark`.

4.Difftest
Chipx support Difftest function,which can compare every instruction with gold trace during runing.
Difftest can be configure in config files,such as config/config.batch_random.
```shell
difftest=1
```
and then run:
```shell
make
```

5.Random Test

Download Random Data and unzip to scripts directory.And then go to `verif/verilator/verRandom`,and add parameter in `config/config.kernel.random` file.
```shell
random_test=1
random_test_dir=../../../scripts/Random_Data/
```
and then run:
```shell
make
```

6.Implement on FPGA
[AMD VCU118](https://china.xilinx.com/products/boards-and-kits/vcu118.html) are supported in ChipX.
follow this instructions:

```shell
cd impl/
export VIVADO=/path/to/Vivado/2022.2/bin/vivado
make
```

then,vivado project will be generated in `impl/work-xlnx`.
prepare linux kernel file and rootfs.
follow this instructions to generate BIN file.
``` shell
make vmlinux
```

prepare serial software such as minicom.run:
```shell
minicom -s
```
configure Serial Port.
connect FPGA board and computer.BIN file can be upload to FPGA.then run:
```shell
make upload 
```
Reset the core,and Serial Software can receive message from FPGA.


## Follow us

## LICENSE

LoongChipX is licensed under [Mulan PSL v2](LICENSE).
