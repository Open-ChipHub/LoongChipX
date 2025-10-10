
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

### Generation Clock
set ipName xlnx_ddr4_reset

puts $boardName

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

###### EDIT #######

create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version 5.0 -module_name $ipName

if {$::env(BOARD) eq "vcu129"} {
set_property -dict [list \
  CONFIG.C_AUX_RESET_HIGH {0} 
] [get_ips $ipName]

} elseif {$::env(BOARD) eq "vcu118"} {

set_property -dict [list \
  CONFIG.C_AUX_RESET_HIGH {1} 
] [get_ips $ipName]

} elseif {$::env(BOARD) eq "axvu13p"} {

set_property -dict [list \
  CONFIG.C_AUX_RESET_HIGH {1} 
] [get_ips $ipName]

} else {
   exit 1
}

#####################

generate_target {instantiation_template} [get_files ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 6 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1