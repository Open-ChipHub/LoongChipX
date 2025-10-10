
set PS_NAME   xlnx_bd_soc

create_bd_design "xlnx_bd_soc"

##################################################################
# DESIGN PROCs
##################################################################

# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Input Port
  create_bd_port -dir I -type clk -freq_hz 100000000 bd_soc_clk
  
  create_bd_port -dir I -type rst bd_soc_ddr_reset
  set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_ports bd_soc_ddr_reset]
  
  create_bd_port -dir I -type rst vio_cpu_reset
  set_property CONFIG.POLARITY ACTIVE_HIGH [get_bd_ports vio_cpu_reset]

  # Reset 100M
  set rst_system_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_system_100M ]
  set_property CONFIG.C_AUX_RESET_HIGH {1} [get_bd_cells rst_system_100M]
  connect_bd_net [get_bd_pins $rst_system_100M/slowest_sync_clk] [get_bd_ports bd_soc_clk]
  connect_bd_net [get_bd_pins $rst_system_100M/ext_reset_in] [get_bd_ports bd_soc_ddr_reset]
  connect_bd_net [get_bd_pins $rst_system_100M/aux_reset_in] [get_bd_ports vio_cpu_reset]


  # Create interface ports
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]
  set_property -dict [ list \
    CONFIG.NUM_MI {2} \
    CONFIG.NUM_SI {2} \
  ] $axi_interconnect


  # JTAG 
  set jtag_axi [ create_bd_cell -type ip -vlnv xilinx.com:ip:jtag_axi:1.2 jtag_axi ]
  set_property -dict [ list \
    CONFIG.M_AXI_ADDR_WIDTH {64} \
    CONFIG.M_AXI_DATA_WIDTH {64} \
    CONFIG.M_AXI_ID_WIDTH {3} \
    CONFIG.M_HAS_BURST {0} \
    CONFIG.RD_TXN_QUEUE_LENGTH {8} \
    CONFIG.WR_TXN_QUEUE_LENGTH {8} \
  ] $jtag_axi

  connect_bd_net [get_bd_pins rst_system_100M/peripheral_aresetn] [get_bd_pins jtag_axi/aresetn]
  connect_bd_intf_net [get_bd_intf_pins jtag_axi/M_AXI] -boundary_type upper [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins jtag_axi/aclk]
  
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/ACLK]
  connect_bd_net [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_interconnect/S01_ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]

  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/S00_ACLK]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/M00_ACLK]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/M01_ACLK]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/S01_ACLK]

  # UART
  set axi_uart [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_uart ]

  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect/M01_AXI] [get_bd_intf_pins axi_uart/S_AXI]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_uart/s_axi_aclk]
  connect_bd_net [get_bd_pins axi_uart/s_axi_aresetn] [get_bd_pins rst_system_100M/peripheral_aresetn]


  # Create AXI Ports
  set s_axi [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 s_axi ]
  set_property -dict [list \
    CONFIG.HAS_REGION \
    [get_property CONFIG.HAS_REGION [get_bd_intf_pins axi_interconnect/xbar/S00_AXI]] \
    CONFIG.NUM_READ_OUTSTANDING \
    [get_property CONFIG.NUM_READ_OUTSTANDING [get_bd_intf_pins axi_interconnect/xbar/S00_AXI]] \
    CONFIG.NUM_WRITE_OUTSTANDING \
    [get_property CONFIG.NUM_WRITE_OUTSTANDING [get_bd_intf_pins axi_interconnect/xbar/S00_AXI]]\
    ] [get_bd_intf_ports s_axi]
  connect_bd_intf_net [get_bd_intf_pins axi_interconnect/S01_AXI] [get_bd_intf_ports s_axi]

  # 100M AXI
  set_property -dict [list \
    CONFIG.ADDR_WIDTH 48 \
    CONFIG.DATA_WIDTH 128 \
    CONFIG.FREQ_HZ 100000000 \
    CONFIG.HAS_QOS 0 \
    CONFIG.ID_WIDTH 8 \
  ] [get_bd_intf_ports s_axi]

  
  make_bd_intf_pins_external  [get_bd_intf_pins axi_uart/UART]
  set_property name rs232_uart [get_bd_intf_ports UART_0]
  create_bd_port -dir O -type intr uart_int
  connect_bd_net [get_bd_pins axi_uart/ip2intc_irpt] [get_bd_ports uart_int]

  create_bd_port -dir O -type rst core_reset
  connect_bd_net [get_bd_pins rst_system_100M/mb_reset] [get_bd_ports core_reset]

  create_bd_port -dir O -from 0 -to 0 -type rst peripheral_aresetn
  connect_bd_net [get_bd_pins rst_system_100M/peripheral_aresetn] [get_bd_ports peripheral_aresetn]


  create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 DDR4_AXI
  set_property -dict [list CONFIG.NUM_READ_OUTSTANDING \
                       [get_property CONFIG.NUM_READ_OUTSTANDING \
                       [get_bd_intf_pins axi_interconnect/xbar/M00_AXI]] \
                       CONFIG.NUM_WRITE_OUTSTANDING [get_property CONFIG.NUM_WRITE_OUTSTANDING \
                       [get_bd_intf_pins axi_interconnect/xbar/M00_AXI]]] \
                       [get_bd_intf_ports DDR4_AXI]

  set_property -dict [list \
    CONFIG.ADDR_WIDTH 31 \
    CONFIG.DATA_WIDTH 512 \
    CONFIG.ID_WIDTH 9 \
    CONFIG.FREQ_HZ 100000000 \
  ] [get_bd_intf_ports DDR4_AXI]

  connect_bd_intf_net [get_bd_intf_pins axi_interconnect/M00_AXI] [get_bd_intf_ports DDR4_AXI]


  # # Create Address Mapping
  assign_bd_address [get_bd_addr_segs {axi_uart/S_AXI/Reg }]
  assign_bd_address [get_bd_addr_segs {DDR4_AXI/Reg }]

  set_property offset 0x00011FF00000 [get_bd_addr_segs {s_axi/SEG_axi_uart_Reg}]
  set_property offset 0x00011FF00000 [get_bd_addr_segs {jtag_axi/Data/SEG_axi_uart_Reg}]

  set_property offset 0x000000000000 [get_bd_addr_segs {s_axi/SEG_DDR4_AXI_Reg}]
  set_property range 4G [get_bd_addr_segs {s_axi/SEG_DDR4_AXI_Reg}]

  set_property offset 0x000000000000 [get_bd_addr_segs {jtag_axi/Data/SEG_DDR4_AXI_Reg}]
  set_property range 4G [get_bd_addr_segs {jtag_axi/Data/SEG_DDR4_AXI_Reg}]

  

  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


