
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)

set ipName xlnx_xdma_fifo

create_project $ipName . -force -part $partNumber
set_property board_part $boardName [current_project]

create_ip -name fifo_generator -vendor xilinx.com -library ip -module_name $ipName

set_property -dict { 
  CONFIG.Fifo_Implementation {Independent_Clocks_Builtin_FIFO}
  CONFIG.synchronization_stages {3}
  CONFIG.INTERFACE_TYPE {Native}
  CONFIG.Input_Data_Width {512}
  CONFIG.Input_Depth {512}
  CONFIG.Output_Data_Width {512}
  CONFIG.Output_Depth {512}
  CONFIG.Use_Embedded_Registers {false}
  CONFIG.Reset_Pin {true}
  CONFIG.Reset_Type {Synchronous_Reset}
  CONFIG.Full_Flags_Reset_Value {0}
  CONFIG.Use_Dout_Reset {true}
  CONFIG.Data_Count_Width {9}
  CONFIG.Write_Data_Count_Width {9}
  CONFIG.Read_Data_Count_Width {9}
  CONFIG.Read_Clock_Frequency {250}
  CONFIG.Write_Clock_Frequency {50}
  CONFIG.Programmable_Full_Type {Single_Programmable_Full_Threshold_Constant}
  CONFIG.Full_Threshold_Assert_Value {400}
  CONFIG.Full_Threshold_Negate_Value {399}
  CONFIG.Empty_Threshold_Assert_Value {5}
  CONFIG.Empty_Threshold_Negate_Value {6}
  CONFIG.FIFO_Implementation_wach {Common_Clock_Distributed_RAM}
  CONFIG.Full_Threshold_Assert_Value_wach {1023}
  CONFIG.Empty_Threshold_Assert_Value_wach {1022}
  CONFIG.FIFO_Implementation_wdch {Common_Clock_Block_RAM}
  CONFIG.FIFO_Implementation_wrch {Common_Clock_Distributed_RAM}
  CONFIG.Full_Threshold_Assert_Value_wrch {1023}
  CONFIG.Empty_Threshold_Assert_Value_wrch {1022}
  CONFIG.FIFO_Implementation_rach {Common_Clock_Distributed_RAM}
  CONFIG.Full_Threshold_Assert_Value_rach {1023}
  CONFIG.Empty_Threshold_Assert_Value_rach {1022}
  CONFIG.FIFO_Implementation_rdch {Common_Clock_Block_RAM}
  CONFIG.FIFO_Implementation_axis {Common_Clock_Block_RAM}
} [get_ips $ipName]

generate_target {instantiation_template} [get_files ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
generate_target all [get_files  ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$ipName.srcs/sources_1/ip/$ipName/$ipName.xci]
launch_run -jobs 6 ${ipName}_synth_1
wait_on_run ${ipName}_synth_1