set PS_NAME   xlnx_bd_xdma
set partNumber $::env(XILINX_PART)
set boardName  $::env(XILINX_BOARD)
set xpr_name xlnx_bd_xdma.xpr

# 检查项目文件是否存在并保存到变量
set project_exists [file exists $xpr_name]

if {$project_exists} {
  open_project -part $partNumber $xpr_name
} else {
  create_project $PS_NAME . -force -part $partNumber
  create_bd_design "xlnx_bd_xdma"
}
set_property board_part $boardName [current_project]


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


  # Create interface ports
  set CFG_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 CFG_AXI ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.HAS_BURST {0} \
   CONFIG.HAS_CACHE {0} \
   CONFIG.HAS_LOCK {0} \
   CONFIG.HAS_QOS {0} \
   CONFIG.HAS_REGION {0} \
   CONFIG.PROTOCOL {AXI4} \
   ] $CFG_AXI

  set DDR_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 DDR_AXI ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.FREQ_HZ {100000000} \
   CONFIG.NUM_READ_OUTSTANDING {32} \
   CONFIG.NUM_WRITE_OUTSTANDING {16} \
   CONFIG.PROTOCOL {AXI4} \
   ] $DDR_AXI

  set DIFF_AXI [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 DIFF_AXI ]
  set_property -dict [ list \
   CONFIG.ADDR_WIDTH {64} \
   CONFIG.DATA_WIDTH {512} \
   CONFIG.FREQ_HZ {250000000} \
   CONFIG.NUM_READ_OUTSTANDING {2} \
   CONFIG.NUM_WRITE_OUTSTANDING {2} \
   CONFIG.PROTOCOL {AXI4} \
   ] $DIFF_AXI

  set pcie_mgt [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:pcie_7x_mgt_rtl:1.0 pcie_mgt ]

  set pice_clk [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 pice_clk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {100000000} \
   ] $pice_clk


  # Create ports
  set axi_aclk [ create_bd_port -dir O -type clk axi_aclk ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {250000000} \
 ] $axi_aclk
  set axi_aresetn [ create_bd_port -dir O -type rst axi_aresetn ]
  set axi_m_clock [ create_bd_port -dir I -type clk -freq_hz 100000000 axi_m_clock ]
  set axi_m_resetn [ create_bd_port -dir I -type rst axi_m_resetn ]
  set pcie_rstn [ create_bd_port -dir I -type rst pcie_rstn ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_LOW} \
 ] $pcie_rstn
  set pice_lnkup [ create_bd_port -dir O pice_lnkup ]

  # Create instance: axi_clock_converter_0, and set properties
  set axi_clock_converter_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_clock_converter:2.1 axi_clock_converter_0 ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
   CONFIG.M02_HAS_REGSLICE {4} \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect_0

  # Create instance: util_ds_buf, and set properties
  set util_ds_buf [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_ds_buf:2.1 util_ds_buf ]
  set_property -dict [ list \
   CONFIG.C_BUF_TYPE {IBUFDSGTE} \
 ] $util_ds_buf

  # Create instance: xdma_0, and set properties
  set xdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xdma:4.1 xdma_0 ]
  set_property -dict [ list \
   CONFIG.PF0_DEVICE_ID_mqdma {903F} \
   CONFIG.PF2_DEVICE_ID_mqdma {903F} \
   CONFIG.PF3_DEVICE_ID_mqdma {903F} \
   CONFIG.axi_data_width {512_bit} \
   CONFIG.cfg_mgmt_if {false} \
   CONFIG.coreclk_freq {500} \
   CONFIG.pcie_extended_tag {false} \
   CONFIG.pf0_device_id {903F} \
   CONFIG.pf0_link_status_slot_clock_config {false} \
   CONFIG.pf0_msix_cap_pba_bir {BAR_1:0} \
   CONFIG.pf0_msix_cap_table_bir {BAR_1:0} \
   CONFIG.pl_link_cap_max_link_speed {8.0_GT/s} \
   CONFIG.pl_link_cap_max_link_width {X16} \
   CONFIG.plltype {QPLL1} \
   CONFIG.xdma_axi_intf_mm {AXI_Memory_Mapped} \
   CONFIG.xdma_pcie_64bit_en {true} \
   CONFIG.xdma_rnum_chnl {1} \
   CONFIG.xdma_wnum_chnl {1} \
 ] $xdma_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_clock_converter_0_M_AXI [get_bd_intf_ports DDR_AXI] [get_bd_intf_pins axi_clock_converter_0/M_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_clock_converter_0/S_AXI] [get_bd_intf_pins axi_interconnect_0/M00_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_ports CFG_AXI] [get_bd_intf_pins axi_interconnect_0/M01_AXI]
  connect_bd_intf_net -intf_net axi_interconnect_0_M02_AXI [get_bd_intf_ports DIFF_AXI] [get_bd_intf_pins axi_interconnect_0/M02_AXI]
  connect_bd_intf_net -intf_net diff_clock_rtl_0_1 [get_bd_intf_ports pice_clk] [get_bd_intf_pins util_ds_buf/CLK_IN_D]
  connect_bd_intf_net -intf_net xdma_0_M_AXI [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins xdma_0/M_AXI]
  connect_bd_intf_net -intf_net xdma_0_pcie_mgt [get_bd_intf_ports pcie_mgt] [get_bd_intf_pins xdma_0/pcie_mgt]

  # Create port connections
  connect_bd_net -net axi_m_clock_1 [get_bd_ports axi_m_clock] [get_bd_pins axi_clock_converter_0/m_axi_aclk]
  connect_bd_net -net axi_m_resetn_1 [get_bd_ports axi_m_resetn] [get_bd_pins axi_clock_converter_0/m_axi_aresetn]
  connect_bd_net -net reset_rtl_0_1 [get_bd_ports pcie_rstn] [get_bd_pins xdma_0/sys_rst_n]
  connect_bd_net -net util_ds_buf_IBUF_DS_ODIV2 [get_bd_pins util_ds_buf/IBUF_DS_ODIV2] [get_bd_pins xdma_0/sys_clk]
  connect_bd_net -net util_ds_buf_IBUF_OUT [get_bd_pins util_ds_buf/IBUF_OUT] [get_bd_pins xdma_0/sys_clk_gt]
  connect_bd_net -net xdma_0_axi_aclk [get_bd_ports axi_aclk] [get_bd_pins axi_clock_converter_0/s_axi_aclk] [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/M02_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins xdma_0/axi_aclk]
  connect_bd_net -net xdma_0_axi_aresetn [get_bd_ports axi_aresetn] [get_bd_pins axi_clock_converter_0/s_axi_aresetn] [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/M02_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins xdma_0/axi_aresetn]
  connect_bd_net -net xdma_0_user_lnk_up [get_bd_ports pice_lnkup] [get_bd_pins xdma_0/user_lnk_up]

  # Create address segments
  assign_bd_address -offset 0x00012FF00000 -range 0x00001000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI] [get_bd_addr_segs CFG_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x000100000000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI] [get_bd_addr_segs DDR_AXI/Reg] -force
  assign_bd_address -offset 0x00013FF00000 -range 0x00001000 -target_address_space [get_bd_addr_spaces xdma_0/M_AXI] [get_bd_addr_segs DIFF_AXI/Reg] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################
if {!$project_exists} {
  create_root_design ""
}

generate_target all [get_files  ./$PS_NAME.srcs/sources_1/bd/$PS_NAME/$PS_NAME.bd]
export_ip_user_files -of_objects [get_files ./$PS_NAME.srcs/sources_1/bd/$PS_NAME/$PS_NAME.bd] -no_script -sync -force -quiet
create_ip_run [get_files -of_objects [get_fileset sources_1] ./$PS_NAME.srcs/sources_1/bd/$PS_NAME/$PS_NAME.bd]
