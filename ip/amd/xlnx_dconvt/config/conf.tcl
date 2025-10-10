
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

### Generation Clock
set ipName xlnx_dwidth_converter

puts $boardName

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

###### EDIT #######

create_ip -name axi_dwidth_converter -vendor xilinx.com -library ip -version 2.1 -module_name $ipName

if {$::env(BOARD) eq "vcu129"} {

set_property -dict [list \
  CONFIG.ADDR_WIDTH {48} \
  CONFIG.MI_DATA_WIDTH {512} \
  CONFIG.SI_DATA_WIDTH {128} \
  CONFIG.SI_ID_WIDTH {5} \
] [get_ips $ipName]

} elseif {$::env(BOARD) eq "vcu118"} {

set_property -dict [list \
  CONFIG.ADDR_WIDTH {48} \
  CONFIG.MI_DATA_WIDTH {512} \
  CONFIG.SI_DATA_WIDTH {128} \
  CONFIG.SI_ID_WIDTH {5} \
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