cmake_minimum_required(VERSION 3.22)
project(VerilatorSim)

set(CMAKE_CXX_STANDARD 14)

add_executable(VerilatorSim ../../common/softfpu/softfpu.cpp
							../../common/memory/memorysim_write.cpp
							../../common/memory/memorysim_check.cpp
							../../common/memory/memorysim_read.cpp
							../../common/vcsrc/log.cpp
							../../common/vcsrc/serial.cpp
							../../common/vcsrc/FPR.cpp
							../../common/vcsrc/sim_config.cpp
							../../common/vcsrc/snapshot.cpp
							../../common/vcsrc/rand64.cpp
							../../common/vcsrc/config.cpp
							../../common/vcsrc/initialize.cpp
							../../common/vcsrc/ram.cpp
							../../common/vcsrc/fifo8.cpp
							../../common/vcsrc/axi.cpp
							../../common/vcsrc/sim_main.cpp
							)

include_directories(obj_dir 
	                /home/airxs/local/verilator/include
	                )

add_definitions("-DWAVE_VCD -DVERILATOR_THREAD_NUM=8")