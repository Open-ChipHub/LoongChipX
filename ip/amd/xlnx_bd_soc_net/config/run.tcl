
set PS_NAME   xlnx_bd_soc_net

create_bd_design "xlnx_bd_soc_net"

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
    CONFIG.NUM_MI {4} \
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

  # AXI SmartConnet
  set axi_smartconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:smartconnect:1.0 axi_smartconnect ]
  set_property CONFIG.NUM_SI {4} [get_bd_cells $axi_smartconnect]


  # UART
  set axi_uart [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uart16550:2.0 axi_uart ]
  apply_board_connection -board_interface "rs232_uart" -ip_intf "axi_uart/UART" -diagram "xlnx_bd_soc_net"

  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect/M01_AXI] [get_bd_intf_pins axi_uart/S_AXI]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_uart/s_axi_aclk]
  connect_bd_net [get_bd_pins axi_uart/s_axi_aresetn] [get_bd_pins rst_system_100M/peripheral_aresetn]


  # Ethernet
  set axi_ethernet [create_bd_cell -type ip -vlnv xilinx.com:ip:axi_ethernet:7.2  axi_ethernet ]
  apply_board_connection -board_interface "sgmii_lvds" -ip_intf "axi_ethernet/sgmii" -diagram "xlnx_bd_soc_net" 
  apply_board_connection -board_interface "mdio_mdc" -ip_intf "axi_ethernet/mdio" -diagram "xlnx_bd_soc_net" 
  apply_board_connection -board_interface "sgmii_phyclk" -ip_intf "axi_ethernet/lvds_clk" -diagram "xlnx_bd_soc_net" 
  apply_board_connection -board_interface "phy_reset_out" -ip_intf "axi_ethernet/phy_rst_n" -diagram "xlnx_bd_soc_net" 
  set_property CONFIG.PHYADDR {1} [get_bd_cells axi_ethernet]
  set_property -dict [list \
    CONFIG.DIFFCLK_BOARD_INTERFACE {Custom} \
    CONFIG.lvdsclkrate {125} \
  ] [get_bd_cells axi_ethernet]

  set_property -dict [list CONFIG.FREQ_HZ 125000000] [get_bd_intf_ports sgmii_phyclk]

  # Create instance: axi_ethernet_dma, and set properties
  set axi_ethernet_dma [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_dma:7.1 axi_ethernet_dma ]
  set_property -dict [ list \
   CONFIG.c_include_mm2s_dre {1} \
   CONFIG.c_include_s2mm_dre {1} \
   CONFIG.c_sg_length_width {16} \
   CONFIG.c_sg_use_stsapp_length {1} \
   CONFIG.c_addr_width {32} \
 ] $axi_ethernet_dma


  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect/M02_AXI] [get_bd_intf_pins axi_ethernet/s_axi]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/M02_ACLK]
  connect_bd_net [get_bd_pins axi_interconnect/M02_ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_pins axi_ethernet/s_axi_lite_resetn] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_ethernet/s_axi_lite_clk]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_ethernet/axis_clk]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_ethernet_dma/s_axi_lite_aclk]

  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_interconnect/M03_ACLK]
  connect_bd_net [get_bd_pins axi_interconnect/M03_ARESETN] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_intf_net [get_bd_intf_pins axi_ethernet_dma/S_AXI_LITE] -boundary_type upper [get_bd_intf_pins axi_interconnect/M03_AXI]

  connect_bd_net [get_bd_pins axi_ethernet_dma/axi_resetn] [get_bd_pins rst_system_100M/peripheral_aresetn]

  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_ethernet_dma/m_axi_sg_aclk]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_ethernet_dma/m_axi_mm2s_aclk]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins axi_ethernet_dma/m_axi_s2mm_aclk]

  connect_bd_net [get_bd_pins axi_ethernet/axi_txd_arstn] [get_bd_pins axi_ethernet_dma/mm2s_prmry_reset_out_n]
  connect_bd_net [get_bd_pins axi_ethernet/axi_txc_arstn] [get_bd_pins axi_ethernet_dma/mm2s_cntrl_reset_out_n]
  connect_bd_net [get_bd_pins axi_ethernet/axi_rxd_arstn] [get_bd_pins axi_ethernet_dma/s2mm_prmry_reset_out_n]
  connect_bd_net [get_bd_pins axi_ethernet/axi_rxs_arstn] [get_bd_pins axi_ethernet_dma/s2mm_sts_reset_out_n]  

  connect_bd_intf_net [get_bd_intf_pins axi_ethernet_dma/M_AXIS_CNTRL] [get_bd_intf_pins axi_ethernet/s_axis_txc]
  connect_bd_intf_net [get_bd_intf_pins axi_ethernet_dma/M_AXIS_MM2S] [get_bd_intf_pins axi_ethernet/s_axis_txd]
  connect_bd_intf_net [get_bd_intf_pins axi_ethernet_dma/S_AXIS_S2MM] [get_bd_intf_pins axi_ethernet/m_axis_rxd]
  connect_bd_intf_net [get_bd_intf_pins axi_ethernet_dma/S_AXIS_STS] [get_bd_intf_pins axi_ethernet/m_axis_rxs]


  # AXI SmartConnet
  connect_bd_intf_net -boundary_type upper [get_bd_intf_pins axi_interconnect/M00_AXI] [get_bd_intf_pins $axi_smartconnect/S00_AXI]
  connect_bd_intf_net [get_bd_intf_pins $axi_smartconnect/S01_AXI] [get_bd_intf_pins axi_ethernet_dma/M_AXI_SG]
  connect_bd_intf_net [get_bd_intf_pins $axi_smartconnect/S02_AXI] [get_bd_intf_pins axi_ethernet_dma/M_AXI_MM2S]
  connect_bd_intf_net [get_bd_intf_pins $axi_smartconnect/S03_AXI] [get_bd_intf_pins axi_ethernet_dma/M_AXI_S2MM]
  
  connect_bd_net [get_bd_pins $axi_smartconnect/aresetn] [get_bd_pins rst_system_100M/peripheral_aresetn]
  connect_bd_net [get_bd_ports bd_soc_clk] [get_bd_pins $axi_smartconnect/aclk]


  set axi_ethernet_constant [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 axi_ethernet_constant ]
  connect_bd_net [get_bd_pins axi_ethernet_constant/dout] [get_bd_pins axi_ethernet/signal_detect]


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

  
  create_bd_port -dir O -type intr uart_int
  connect_bd_net [get_bd_pins axi_uart/ip2intc_irpt] [get_bd_ports uart_int]

  create_bd_port -dir O -type rst core_reset
  connect_bd_net [get_bd_pins rst_system_100M/mb_reset] [get_bd_ports core_reset]

  create_bd_port -dir O -from 0 -to 0 -type rst peripheral_aresetn
  connect_bd_net [get_bd_pins rst_system_100M/peripheral_aresetn] [get_bd_ports peripheral_aresetn]

  create_bd_port -dir O -type intr eth_interrupt
  connect_bd_net [get_bd_pins /axi_ethernet/interrupt] [get_bd_ports eth_interrupt]

  create_bd_port -dir O -type intr mac_irq
  connect_bd_net [get_bd_pins /axi_ethernet/mac_irq] [get_bd_ports mac_irq]

  create_bd_port -dir O -type intr mm2s_introut
  connect_bd_net [get_bd_pins /axi_ethernet_dma/mm2s_introut] [get_bd_ports mm2s_introut]

  create_bd_port -dir O -type intr s2mm_introut
  connect_bd_net [get_bd_pins /axi_ethernet_dma/s2mm_introut] [get_bd_ports s2mm_introut]


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

  connect_bd_intf_net [get_bd_intf_ports DDR4_AXI] [get_bd_intf_pins $axi_smartconnect/M00_AXI]


  # # Create Address Mapping
  assign_bd_address [get_bd_addr_segs {axi_uart/S_AXI/Reg }]
  assign_bd_address [get_bd_addr_segs {DDR4_AXI/Reg }]
  assign_bd_address [get_bd_addr_segs {axi_ethernet/s_axi/Reg0 }]
  assign_bd_address [get_bd_addr_segs {axi_ethernet_dma/S_AXI_LITE/Reg }]

  set_property offset 0x00011FF00000 [get_bd_addr_segs {s_axi/SEG_axi_uart_Reg}]
  set_property offset 0x00011FF00000 [get_bd_addr_segs {jtag_axi/Data/SEG_axi_uart_Reg}]

  set_property offset 0x000000000000 [get_bd_addr_segs {s_axi/SEG_DDR4_AXI_Reg}]
  set_property range 2G [get_bd_addr_segs {s_axi/SEG_DDR4_AXI_Reg}]

  exclude_bd_addr_seg [get_bd_addr_segs jtag_axi/Data/SEG_axi_uart_Reg]
  exclude_bd_addr_seg [get_bd_addr_segs jtag_axi/Data/SEG_axi_ethernet_Reg0]
  exclude_bd_addr_seg [get_bd_addr_segs jtag_axi/Data/SEG_axi_ethernet_dma_Reg]
  
  set_property offset 0x000000000000 [get_bd_addr_segs {jtag_axi/Data/SEG_DDR4_AXI_Reg}]
  set_property range 2G [get_bd_addr_segs {jtag_axi/Data/SEG_DDR4_AXI_Reg}]

  set_property offset 0x000000000000 [get_bd_addr_segs {axi_ethernet_dma/Data_S2MM/SEG_DDR4_AXI_Reg}]
  set_property range 2G [get_bd_addr_segs {axi_ethernet_dma/Data_S2MM/SEG_DDR4_AXI_Reg}]
  
  set_property offset 0x000000000000 [get_bd_addr_segs {axi_ethernet_dma/Data_MM2S/SEG_DDR4_AXI_Reg}]
  set_property range 2G [get_bd_addr_segs {axi_ethernet_dma/Data_MM2S/SEG_DDR4_AXI_Reg}]

  set_property offset 0x000000000000 [get_bd_addr_segs {axi_ethernet_dma/Data_SG/SEG_DDR4_AXI_Reg}]
  set_property range 2G [get_bd_addr_segs {axi_ethernet_dma/Data_SG/SEG_DDR4_AXI_Reg}]

  set_property offset 0x00011FD00000 [get_bd_addr_segs {s_axi/SEG_axi_ethernet_Reg0}]
  set_property offset 0x00011FE00000 [get_bd_addr_segs {s_axi/SEG_axi_ethernet_dma_Reg}]



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


