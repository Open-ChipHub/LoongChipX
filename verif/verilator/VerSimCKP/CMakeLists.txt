cmake_minimum_required(VERSION 3.22)
project(VerilatorSim)

set(CMAKE_CXX_STANDARD 14)

add_executable(VerilatorSim ../../common/softfpu/softfpu.cpp
							../../common/memory/memorysim_write.cpp
							../../common/memory/memorysim_check.cpp
							../../common/memory/memorysim_read.cpp
							../../common/vcsrc/log.cpp
							../../common/vcsrc/serial.cpp
							../../common/vcsrc/fpr.cpp
							../../common/vcsrc/sim_config.cpp
							../../common/vcsrc/snapshot.cpp
							../../common/vcsrc/rand64.cpp
							../../common/vcsrc/config.cpp
							../../common/vcsrc/initialize.cpp
							../../common/vcsrc/ram.cpp
							../../common/vcsrc/fifo8.cpp
							../../common/vcsrc/axi.cpp
							../../common/sim_main.cpp
							../../difftest/lightsss.cpp
							../../difftest/diff_manage.cpp
							../../difftest/difftest.cpp
							../../difftest/interface.cpp
							../../difftest/emuproxy.cpp
							../../difftest/emu.cpp
							)

include_directories(obj_dir 
	                /home/airxs/local/verilator/include
	                ../../common/memory
	                ../../common/vcsrc/include
	                ../../common/memory/DRAMsim3/src
	                ../../difftest/include
	                )

add_definitions("-DWAVE_VCD -DVERILATOR_THREAD_NUM=8")