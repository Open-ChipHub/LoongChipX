
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

### Generation Clock
set ipName xlnx_ddr4

puts $boardName

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

###### EDIT #######
create_ip -name ddr4 -vendor xilinx.com -library ip -version 2.2 -module_name $ipName

if {$::env(BOARD) eq "vcu129"} {

set_property -dict [list \
  CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {30} \
  CONFIG.C0.DDR4_AxiAddressWidth {34} \
  CONFIG.C0.DDR4_AxiDataWidth {512} \
  CONFIG.C0.DDR4_AxiIDWidth {5} \
  CONFIG.C0.DDR4_AxiSelection {true} \
  CONFIG.C0.DDR4_CasLatency {17} \
  CONFIG.C0.DDR4_Ecc {true} \
  CONFIG.C0.DDR4_InputClockPeriod {3332} \
  CONFIG.C0.DDR4_MemoryPart {MTA18ASF2G72PZ-2G9} \
  CONFIG.C0.DDR4_MemoryType {RDIMMs} \
  CONFIG.C0.DDR4_TimePeriod {833} \
  CONFIG.C0_DDR4_BOARD_INTERFACE {ddr4_sdram} \
] [get_ips $ipName]

} elseif {$::env(BOARD) eq "vcu118"} {

set_property -dict [list \
  CONFIG.C0.DDR4_AxiAddressWidth {31} \
  CONFIG.C0.DDR4_AxiDataWidth {512} \
  CONFIG.C0.DDR4_AxiIDWidth {5} \
  CONFIG.C0.DDR4_AxiSelection {true} \
  CONFIG.C0.DDR4_DataWidth {64} \
  CONFIG.C0.DDR4_InputClockPeriod {4000} \
  CONFIG.C0.DDR4_MemoryPart {MT40A256M16LY-062E} \
  CONFIG.C0.DDR4_TimePeriod {833} \
  CONFIG.C0_CLOCK_BOARD_INTERFACE {default_250mhz_clk1} \
  CONFIG.C0_DDR4_BOARD_INTERFACE {ddr4_sdram_c1_083} \
  CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {100} \
  CONFIG.ADDN_UI_CLKOUT2_FREQ_HZ {50} \
  CONFIG.RESET_BOARD_INTERFACE {reset} \
] [get_ips $ipName]
} elseif {$::env(BOARD) eq "axvu13p"} {

set_property -dict [list \
  CONFIG.C0.DDR4_AxiSelection {true} \
  CONFIG.C0.DDR4_AxiAddressWidth {34} \
  CONFIG.C0.DDR4_AxiDataWidth {512} \
  CONFIG.C0.DDR4_AxiIDWidth {5} \
  CONFIG.C0.DDR4_DataWidth {64} \
  CONFIG.ADDN_UI_CLKOUT1_FREQ_HZ {100} \
  CONFIG.ADDN_UI_CLKOUT2_FREQ_HZ {50} \
  CONFIG.C0.DDR4_InputClockPeriod {5003} \
  CONFIG.C0.DDR4_MemoryPart {MTA16ATF2G64HZ-2G3} \
  CONFIG.C0.DDR4_MemoryType {SODIMMs} \
  CONFIG.C0.DDR4_TimePeriod {938} \
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