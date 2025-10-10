
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

### Generation Clock
set ipName xlnx_clk_wiz

puts $boardName

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

###### EDIT #######

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name $ipName

if {$::env(BOARD) eq "vcu129"} {

set_property -dict [list \
  CONFIG.CLKOUT1_JITTER {294.871} \
  CONFIG.CLKOUT1_PHASE_ERROR {297.237} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {20.000} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {52.375} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {52.375} \
  CONFIG.MMCM_DIVCLK_DIVIDE {5} \
] [get_ips $ipName]

} elseif {$::env(BOARD) eq "vcu118"} {

# # 20MHZ
# set_property -dict [list \
#   CONFIG.CLKOUT1_JITTER {294.871} \
#   CONFIG.CLKOUT1_PHASE_ERROR {297.237} \
#   CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {20.000} \
#   CONFIG.MMCM_CLKFBOUT_MULT_F {52.375} \
#   CONFIG.MMCM_CLKOUT0_DIVIDE_F {52.375} \
#   CONFIG.MMCM_DIVCLK_DIVIDE {5} \
#   CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
#   CONFIG.USE_LOCKED {false} \
#   CONFIG.USE_RESET {false} \

# 10MHZ
set_property -dict [list \
  CONFIG.CLKOUT1_JITTER {460.700} \
  CONFIG.CLKOUT1_PHASE_ERROR {523.418} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {10.000} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {92.375} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {92.375} \
  CONFIG.MMCM_DIVCLK_DIVIDE {10} \
  CONFIG.OPTIMIZE_CLOCKING_STRUCTURE_EN {true} \
  CONFIG.USE_LOCKED {false} \
  CONFIG.USE_RESET {false} \
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