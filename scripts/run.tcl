set project $::env(PROJECT)

# for test
# set project_part xcvu19p-fsva3824-2-e

if {$::env(BOARD) eq "vcu118"} {
   # VCU118
   set project_board xilinx.com:vcu118:part0:2.4
   set project_part xcvu9p-flga2104-2l-e
} elseif {$::env(BOARD) eq "vcu129"} {
   # VCU129
   set project_board xilinx.com:vcu129:part0:1.0
   set project_part xcvu29p-fsga2577-2L-e
} elseif {$::env(BOARD) eq "axvu13p"} {
   # Alinx axvu13p
   set project_board ""
   set project_part xcvu13p-fhgb2104-2-i
} elseif {$::env(BOARD) eq "vc709"} {
   # VCU129
   set project_board xilinx.com:vc709:part0:1.8
   set project_part xc7vx690tffg1761-2
} else {
   exit 1
}


set project_home $::env(PROJECT_HOME)

set TOP_NAME $::env(SYNTH_TOP_MODULE)

set IP_DIR {../../ip/amd}

create_project $project . -force -part $project_part
set_property board_part $project_board [current_project]

if {$::env(BOARD) eq "vcu118"} {
   # VCU118 Board
   add_files -fileset constrs_1 -norecurse ../constraints/vcu118.xdc
} elseif {$::env(BOARD) eq "vcu129"} {
   # VC129 Board
    add_files -fileset constrs_1 -norecurse ../constraints/vcu129.xdc
} elseif {$::env(BOARD) eq "axvu13p"} {
   # Alinx axvu13p Board
    add_files -fileset constrs_1 -norecurse ../constraints/axvu13p.xdc
} elseif {$::env(BOARD) eq "vc709"} {
   # VC709 Board
    add_files -fileset constrs_1 -norecurse ../constraints/vc709.xdc
} else {
   exit 1
}

source add_loongchipx_filelists.tcl
# source add_devices.tcl
# source add_simulations.tcl

if {$::env(BOARD) eq "vcu129"} {
   # VCU129 Board
   read_ip { \
      "../../ip/amd/xlnx_dwidth_converter/xlnx_dwidth_converter.srcs/sources_1/ip/xlnx_dwidth_converter/xlnx_dwidth_converter.xci" \
      "../../ip/amd/xlnx_clock_converter/xlnx_clock_converter.srcs/sources_1/ip/xlnx_clock_converter/xlnx_clock_converter.xci" \
      "../../ip/amd/xlnx_ddr4/xlnx_ddr4.srcs/sources_1/ip/xlnx_ddr4/xlnx_ddr4.xci" 
    }
} elseif {$::env(BOARD) eq "vcu118"} {
   # VCU118 Board
   read_ip { \
      "../../ip/amd/xlnx_cpu_cconvt/xlnx_cpu_cconvt.srcs/sources_1/ip/xlnx_cpu_cconvt/xlnx_cpu_cconvt.xci" \
      "../../ip/amd/xlnx_ddr4_cconvt/xlnx_ddr4_cconvt.srcs/sources_1/ip/xlnx_ddr4_cconvt/xlnx_ddr4_cconvt.xci" \
      "../../ip/amd/xlnx_ddr4_reset/xlnx_ddr4_reset.srcs/sources_1/ip/xlnx_ddr4_reset/xlnx_ddr4_reset.xci" \
      "../../ip/amd/xlnx_ddr4/xlnx_ddr4.srcs/sources_1/ip/xlnx_ddr4/xlnx_ddr4.xci" \
      "../../ip/amd/xlnx_vio/xlnx_vio.srcs/sources_1/ip/xlnx_vio/xlnx_vio.xci" \
   }
} elseif {$::env(BOARD) eq "axvu13p"} {
   # VCU118 Board
   read_ip { \
      "../../ip/amd/xlnx_cpu_cconvt/xlnx_cpu_cconvt.srcs/sources_1/ip/xlnx_cpu_cconvt/xlnx_cpu_cconvt.xci" \
      "../../ip/amd/xlnx_ddr4_cconvt/xlnx_ddr4_cconvt.srcs/sources_1/ip/xlnx_ddr4_cconvt/xlnx_ddr4_cconvt.xci" \
      "../../ip/amd/xlnx_ddr4_reset/xlnx_ddr4_reset.srcs/sources_1/ip/xlnx_ddr4_reset/xlnx_ddr4_reset.xci" \
      "../../ip/amd/xlnx_ddr4/xlnx_ddr4.srcs/sources_1/ip/xlnx_ddr4/xlnx_ddr4.xci" \
      "../../ip/amd/xlnx_vio/xlnx_vio.srcs/sources_1/ip/xlnx_vio/xlnx_vio.xci" \
   }
}

set_property top $TOP_NAME [current_fileset]

# set_property include_dirs { \
#    "../../design/include" \
# } [current_fileset]

set include_file_list {
   design/sys/ccx/rtl/ccx_config.h \
   design/sys/llc/rtl/llc_config.h \
}

if {$::env(HETE_ARCH) eq "big"} {
   lappend include_file_list \
      design/sys/core/lc364/cpu/rtl/cpu_cfig.h \
      design/sys/core/lc364/mmu/rtl/sysmap.h 
} elseif {$::env(HETE_ARCH) eq "little"} {
   lappend include_file_list \
      design/sys/core/lc164/cpu/rtl/cpu_cfig.h \
      design/sys/core/lc164/cpu/rtl/aq_dtu_cfig.h \
      design/sys/core/lc164/idu/rtl/aq_idu_cfig.h \
      design/sys/core/lc164/lsu/rtl/aq_lsu_cfig.h \
      design/sys/core/lc164/mmu/rtl/sysmap.h 
} elseif {$::env(HETE_ARCH) eq "hybrid"} {
   lappend include_file_list \
      design/sys/core/lc364/cpu/rtl/cpu_cfig.h \
      design/sys/core/lc364/mmu/rtl/sysmap.h \
      design/sys/core/lc164/cpu/rtl/cpu_cfig.h \
      design/sys/core/lc164/cpu/rtl/aq_dtu_cfig.h \
      design/sys/core/lc164/idu/rtl/aq_idu_cfig.h \
      design/sys/core/lc164/lsu/rtl/aq_lsu_cfig.h \
      design/sys/core/lc164/mmu/rtl/sysmap.h
} else {
   puts "Not Support HETE_ARCH!"
   exit 1
}

puts $include_file_list

foreach inc $include_file_list { 
   puts $inc
   set file "../../$inc" 
   set file_obj [get_files -of_objects [get_filesets sources_1] [list "$file"]]
   set_property -dict { file_type {Verilog Header} is_global_include 1} -objects $file_obj
}


# Add BD
# set BD_NAME xlnx_bd_soc_net
set BD_NAME xlnx_bd_soc

if {$::env(BOARD) eq "axvu13p"} {
      ## add block design
      source ../../ip/amd/$BD_NAME/config/run.tcl
      make_wrapper -files [get_files \
                            ./$project.srcs/sources_1/bd/$BD_NAME/$BD_NAME.bd] -top
      add_files -norecurse ./$project.gen/sources_1/bd/$BD_NAME/hdl/${BD_NAME}_wrapper.v
      ## generation 
      generate_target all [get_files  ./$project.srcs/sources_1/bd/$BD_NAME/$BD_NAME.bd]
      export_ip_user_files -of_objects [get_files ./$project.srcs/sources_1/bd/$BD_NAME/$BD_NAME.bd] -no_script -sync -force -quiet
      create_ip_run [get_files -of_objects [get_fileset sources_1] ./$project.srcs/sources_1/bd/$BD_NAME/$BD_NAME.bd]
}


update_compile_order -fileset sources_1

set_property top sim_top [get_filesets sim_1]
update_compile_order -fileset sim_1

add_files -fileset constrs_1 -norecurse ../constraints/$project.xdc

set_property strategy Flow_AlternateRoutability [get_runs synth_1]
# set_property strategy Flow_PerfThresholdCarry [get_runs synth_1]

# set_property strategy Flow_RunPhysOpt [get_runs impl_1]
# set_property strategy Flow_RunPostRoutePhysOpt [get_runs impl_1]
# set_property strategy Performance_ExtraTimingOpt [get_runs impl_1]
set_property strategy Performance_NetDelay_low [get_runs impl_1]


launch_runs synth_1 -jobs 10
wait_on_run synth_1
# open_run synth_1

# exec mkdir -p reports/
# exec rm -rf reports/*

# # reports
# check_timing -verbose                                                   -file reports/$project.check_timing.rpt
# report_timing -max_paths 100 -nworst 100 -delay_type max -sort_by slack -file reports/$project.timing_WORST_100.rpt
# report_timing -nworst 1 -delay_type max -sort_by group                  -file reports/$project.timing.rpt
# report_utilization -hierarchical                                        -file reports/$project.utilization.rpt
# report_cdc                                                              -file reports/$project.cdc.rpt
# report_clock_interaction                                                -file reports/$project.clock_interaction.rpt

# set for RuntimeOptimized implementation
# set_property "steps.place_design.args.directive" "RuntimeOptimized" [get_runs impl_1]
# set_property "steps.route_design.args.directive" "RuntimeOptimized" [get_runs impl_1]

launch_runs impl_1 -jobs 10
wait_on_run impl_1
launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
# open_run impl_1

# output Verilog netlist + SDC for timing simulation
# write_verilog -force -mode funcsim work-fpga/${project}_funcsim.v
# write_verilog -force -mode timesim work-fpga/${project}_timesim.v
# write_sdf     -force work-fpga/${project}_timesim.sdf

# # reports
# exec mkdir -p reports/
# exec rm -rf reports/*
# check_timing                                                              -file reports/${project}.check_timing.rpt
# report_timing -max_paths 100 -nworst 100 -delay_type max -sort_by slack   -file reports/${project}.timing_WORST_100.rpt
# report_timing -nworst 1 -delay_type max -sort_by group                    -file reports/${project}.timing.rpt
# report_utilization -hierarchical                                          -file reports/${project}.utilization.rpt
