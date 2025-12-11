
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

### Generation Clock
set ipName xlnx_xdma

puts $boardName

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

###### EDIT #######
create_ip -name xdma -vendor xilinx.com -library ip -version 4.1 -module_name $ipName

set_property -dict { 
   CONFIG.PF0_DEVICE_ID_mqdma {903F}
   CONFIG.PF2_DEVICE_ID_mqdma {903F}
   CONFIG.PF3_DEVICE_ID_mqdma {903F}
   CONFIG.axi_data_width {512_bit}
   CONFIG.cfg_mgmt_if {false}
   CONFIG.coreclk_freq {500}
   CONFIG.enable_ibert {false}
   CONFIG.mode_selection {Advanced}
   CONFIG.pcie_extended_tag {false}
   CONFIG.pf0_device_id {903F}
   CONFIG.pf0_interrupt_pin {NONE}
   CONFIG.pf0_link_status_slot_clock_config {false}
   CONFIG.pf0_msi_enabled {false}
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s}
   CONFIG.pl_link_cap_max_link_width {X16}
   CONFIG.plltype {QPLL1}
   CONFIG.xdma_axi_intf_mm {AXI_Memory_Mapped}
} [get_ips $ipName]

#####################

generate_target {instantiation_template} [get_files ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 6 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1