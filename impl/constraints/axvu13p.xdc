# XDC constraints for the Xilinx AXVU13P
# part: xcvu13p-fhgb2104-2-i

# General configuration
set_property CONFIG_MODE SPIx8 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 85.0 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]


# RESET
set_property PACKAGE_PIN BF35 [get_ports sys_rst_n]
set_property IOSTANDARD LVCMOS12 [get_ports sys_rst_n]

# Clock
set_property PACKAGE_PIN AV18          [get_ports sys_clk_p]
set_property PACKAGE_PIN AW18          [get_ports sys_clk_n]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_HSTL_I_18 [get_ports sys_clk_n]

# UART
set_property PACKAGE_PIN BF25 [get_ports rs232_uart_rxd]
set_property PACKAGE_PIN BE25 [get_ports rs232_uart_txd]
set_property IOSTANDARD LVCMOS18 [get_ports rs232_uart_rxd]
set_property IOSTANDARD LVCMOS18 [get_ports rs232_uart_txd]

# DDR4
set_property PACKAGE_PIN AF32 [get_ports c0_sys_clk_p]
set_property PACKAGE_PIN AF33 [get_ports c0_sys_clk_n]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c0_sys_clk_p]
set_property IOSTANDARD DIFF_SSTL12 [get_ports c0_sys_clk_n]

set_property PACKAGE_PIN AJ34 [get_ports c0_ddr4_reset_n]
set_property PACKAGE_PIN AK31 [get_ports c0_ddr4_act_n]

set_property PACKAGE_PIN AW34 [get_ports {c0_ddr4_dq[0]}]
set_property PACKAGE_PIN AW33 [get_ports {c0_ddr4_dq[1]}]
set_property PACKAGE_PIN AY36 [get_ports {c0_ddr4_dq[2]}]
set_property PACKAGE_PIN BA33 [get_ports {c0_ddr4_dq[3]}]
set_property PACKAGE_PIN AV33 [get_ports {c0_ddr4_dq[4]}]
set_property PACKAGE_PIN AY33 [get_ports {c0_ddr4_dq[5]}]
set_property PACKAGE_PIN AY35 [get_ports {c0_ddr4_dq[6]}]
set_property PACKAGE_PIN AV34 [get_ports {c0_ddr4_dq[7]}]
set_property PACKAGE_PIN AL32 [get_ports {c0_ddr4_dq[8]}]
set_property PACKAGE_PIN AM34 [get_ports {c0_ddr4_dq[9]}]

set_property PACKAGE_PIN AP33 [get_ports {c0_ddr4_dq[10]}]
set_property PACKAGE_PIN AM32 [get_ports {c0_ddr4_dq[11]}]
set_property PACKAGE_PIN AL34 [get_ports {c0_ddr4_dq[12]}]
set_property PACKAGE_PIN AN34 [get_ports {c0_ddr4_dq[13]}]
set_property PACKAGE_PIN AP34 [get_ports {c0_ddr4_dq[14]}]
set_property PACKAGE_PIN AR33 [get_ports {c0_ddr4_dq[15]}]
set_property PACKAGE_PIN BD39 [get_ports {c0_ddr4_dq[16]}]
set_property PACKAGE_PIN BE38 [get_ports {c0_ddr4_dq[17]}]
set_property PACKAGE_PIN BB38 [get_ports {c0_ddr4_dq[18]}]
set_property PACKAGE_PIN BF38 [get_ports {c0_ddr4_dq[19]}]

set_property PACKAGE_PIN BF37 [get_ports {c0_ddr4_dq[20]}]
set_property PACKAGE_PIN BC39 [get_ports {c0_ddr4_dq[21]}]
set_property PACKAGE_PIN BC38 [get_ports {c0_ddr4_dq[22]}]
set_property PACKAGE_PIN BE37 [get_ports {c0_ddr4_dq[23]}]
set_property PACKAGE_PIN BE36 [get_ports {c0_ddr4_dq[24]}]
set_property PACKAGE_PIN BD36 [get_ports {c0_ddr4_dq[25]}]
set_property PACKAGE_PIN BB35 [get_ports {c0_ddr4_dq[26]}]
set_property PACKAGE_PIN BE35 [get_ports {c0_ddr4_dq[27]}]
set_property PACKAGE_PIN BA35 [get_ports {c0_ddr4_dq[28]}]
set_property PACKAGE_PIN BB36 [get_ports {c0_ddr4_dq[29]}]

set_property PACKAGE_PIN BC36 [get_ports {c0_ddr4_dq[30]}]
set_property PACKAGE_PIN BD35 [get_ports {c0_ddr4_dq[31]}]
set_property PACKAGE_PIN BB31 [get_ports {c0_ddr4_dq[32]}]
set_property PACKAGE_PIN BA30 [get_ports {c0_ddr4_dq[33]}]
set_property PACKAGE_PIN AY30 [get_ports {c0_ddr4_dq[34]}]
set_property PACKAGE_PIN BA29 [get_ports {c0_ddr4_dq[35]}]
set_property PACKAGE_PIN AY32 [get_ports {c0_ddr4_dq[36]}]
set_property PACKAGE_PIN BB30 [get_ports {c0_ddr4_dq[37]}]
set_property PACKAGE_PIN AY31 [get_ports {c0_ddr4_dq[38]}]
set_property PACKAGE_PIN BB29 [get_ports {c0_ddr4_dq[39]}]

set_property PACKAGE_PIN BD29 [get_ports {c0_ddr4_dq[40]}]
set_property PACKAGE_PIN BE32 [get_ports {c0_ddr4_dq[41]}]
set_property PACKAGE_PIN BD33 [get_ports {c0_ddr4_dq[42]}]
set_property PACKAGE_PIN BE30 [get_ports {c0_ddr4_dq[43]}]
set_property PACKAGE_PIN BE31 [get_ports {c0_ddr4_dq[44]}]
set_property PACKAGE_PIN BE33 [get_ports {c0_ddr4_dq[45]}]
set_property PACKAGE_PIN BC29 [get_ports {c0_ddr4_dq[46]}]
set_property PACKAGE_PIN BF30 [get_ports {c0_ddr4_dq[47]}]
set_property PACKAGE_PIN AP30 [get_ports {c0_ddr4_dq[48]}]
set_property PACKAGE_PIN AP29 [get_ports {c0_ddr4_dq[49]}]

set_property PACKAGE_PIN AL30 [get_ports {c0_ddr4_dq[50]}]
set_property PACKAGE_PIN AM31 [get_ports {c0_ddr4_dq[51]}]
set_property PACKAGE_PIN AN31 [get_ports {c0_ddr4_dq[52]}]
set_property PACKAGE_PIN AR30 [get_ports {c0_ddr4_dq[53]}]
set_property PACKAGE_PIN AN29 [get_ports {c0_ddr4_dq[54]}]
set_property PACKAGE_PIN AL29 [get_ports {c0_ddr4_dq[55]}]
set_property PACKAGE_PIN AU32 [get_ports {c0_ddr4_dq[56]}]
set_property PACKAGE_PIN AW31 [get_ports {c0_ddr4_dq[57]}]
set_property PACKAGE_PIN AU30 [get_ports {c0_ddr4_dq[58]}]
set_property PACKAGE_PIN AT30 [get_ports {c0_ddr4_dq[59]}]

set_property PACKAGE_PIN AV32 [get_ports {c0_ddr4_dq[60]}]
set_property PACKAGE_PIN AV31 [get_ports {c0_ddr4_dq[61]}]
set_property PACKAGE_PIN AU31 [get_ports {c0_ddr4_dq[62]}]
set_property PACKAGE_PIN AT29 [get_ports {c0_ddr4_dq[63]}]
# set_property PACKAGE_PIN Y33  [get_ports {c0_ddr4_dq[64]}]
# set_property PACKAGE_PIN AB34 [get_ports {c0_ddr4_dq[65]}]
# set_property PACKAGE_PIN Y32  [get_ports {c0_ddr4_dq[66]}]
# set_property PACKAGE_PIN Y30  [get_ports {c0_ddr4_dq[67]}]
# set_property PACKAGE_PIN W34  [get_ports {c0_ddr4_dq[68]}]
# set_property PACKAGE_PIN W33  [get_ports {c0_ddr4_dq[69]}]
# set_property PACKAGE_PIN AA34 [get_ports {c0_ddr4_dq[70]}]
# set_property PACKAGE_PIN W30  [get_ports {c0_ddr4_dq[71]}]

set_property PACKAGE_PIN BA34 [get_ports {c0_ddr4_dm_n[0]}]
set_property PACKAGE_PIN AT33 [get_ports {c0_ddr4_dm_n[1]}]
set_property PACKAGE_PIN BF39 [get_ports {c0_ddr4_dm_n[2]}]
set_property PACKAGE_PIN BC34 [get_ports {c0_ddr4_dm_n[3]}]
set_property PACKAGE_PIN BC31 [get_ports {c0_ddr4_dm_n[4]}]
set_property PACKAGE_PIN BF32 [get_ports {c0_ddr4_dm_n[5]}]
set_property PACKAGE_PIN AP31 [get_ports {c0_ddr4_dm_n[6]}]
set_property PACKAGE_PIN AW29 [get_ports {c0_ddr4_dm_n[7]}]
# set_property PACKAGE_PIN AA32 [get_ports {c0_ddr4_dm_n[8]}]

# set_property PACKAGE_PIN W31  [get_ports {c0_ddr4_dqs_t[8]}]

set_property PACKAGE_PIN AW35 [get_ports {c0_ddr4_dqs_t[0]}]
set_property PACKAGE_PIN AW36 [get_ports {c0_ddr4_dqs_c[0]}]
set_property PACKAGE_PIN AN32 [get_ports {c0_ddr4_dqs_t[1]}]
set_property PACKAGE_PIN AN33 [get_ports {c0_ddr4_dqs_c[1]}]
set_property PACKAGE_PIN BD40 [get_ports {c0_ddr4_dqs_t[2]}]
set_property PACKAGE_PIN BE40 [get_ports {c0_ddr4_dqs_c[2]}]
set_property PACKAGE_PIN BB37 [get_ports {c0_ddr4_dqs_t[3]}]
set_property PACKAGE_PIN BC37 [get_ports {c0_ddr4_dqs_c[3]}]
set_property PACKAGE_PIN BA32 [get_ports {c0_ddr4_dqs_t[4]}]
set_property PACKAGE_PIN BB32 [get_ports {c0_ddr4_dqs_c[4]}]
set_property PACKAGE_PIN BD30 [get_ports {c0_ddr4_dqs_t[5]}]
set_property PACKAGE_PIN BD31 [get_ports {c0_ddr4_dqs_c[5]}]
set_property PACKAGE_PIN AM29 [get_ports {c0_ddr4_dqs_t[6]}]
set_property PACKAGE_PIN AM30 [get_ports {c0_ddr4_dqs_c[6]}]
set_property PACKAGE_PIN AU29 [get_ports {c0_ddr4_dqs_t[7]}]
set_property PACKAGE_PIN AV29 [get_ports {c0_ddr4_dqs_c[7]}]
# set_property PACKAGE_PIN Y31  [get_ports {c0_ddr4_dqs_c[8]}]


set_property PACKAGE_PIN AC33 [get_ports {c0_ddr4_adr[0]}]
set_property PACKAGE_PIN AG29 [get_ports {c0_ddr4_adr[1]}]
set_property PACKAGE_PIN AJ29 [get_ports {c0_ddr4_adr[2]}]
set_property PACKAGE_PIN AG32 [get_ports {c0_ddr4_adr[3]}]
set_property PACKAGE_PIN AK28 [get_ports {c0_ddr4_adr[4]}]
set_property PACKAGE_PIN AJ30 [get_ports {c0_ddr4_adr[5]}]
set_property PACKAGE_PIN AG31 [get_ports {c0_ddr4_adr[6]}]
set_property PACKAGE_PIN AH31 [get_ports {c0_ddr4_adr[7]}]
set_property PACKAGE_PIN AG30 [get_ports {c0_ddr4_adr[8]}]
set_property PACKAGE_PIN AH32 [get_ports {c0_ddr4_adr[9]}]
set_property PACKAGE_PIN AJ27 [get_ports {c0_ddr4_adr[10]}]
set_property PACKAGE_PIN AJ31 [get_ports {c0_ddr4_adr[11]}]
set_property PACKAGE_PIN AF34 [get_ports {c0_ddr4_adr[12]}]
set_property PACKAGE_PIN AF30 [get_ports {c0_ddr4_adr[13]}]
set_property PACKAGE_PIN AE30 [get_ports {c0_ddr4_adr[14]}]
set_property PACKAGE_PIN AH29 [get_ports {c0_ddr4_adr[15]}]
set_property PACKAGE_PIN AJ28 [get_ports {c0_ddr4_adr[16]}]


set_property PACKAGE_PIN AE31 [get_ports {c0_ddr4_ck_t[0]}]
set_property PACKAGE_PIN AE32 [get_ports {c0_ddr4_ck_c[0]}]
set_property PACKAGE_PIN AD33 [get_ports {c0_ddr4_ck_t[1]}]
set_property PACKAGE_PIN AE33 [get_ports {c0_ddr4_ck_c[1]}]

set_property PACKAGE_PIN AB32 [get_ports {c0_ddr4_odt[0]}]
set_property PACKAGE_PIN AD30 [get_ports {c0_ddr4_odt[1]}]

set_property PACKAGE_PIN AC31 [get_ports {c0_ddr4_cs_n[0]}]
set_property PACKAGE_PIN AD31 [get_ports {c0_ddr4_cs_n[1]}]

set_property PACKAGE_PIN AJ33 [get_ports {c0_ddr4_cke[0]}]
set_property PACKAGE_PIN AG34 [get_ports {c0_ddr4_cke[1]}]

set_property PACKAGE_PIN AH28 [get_ports {c0_ddr4_ba[0]}]
set_property PACKAGE_PIN AC32 [get_ports {c0_ddr4_ba[1]}]

set_property PACKAGE_PIN AH34 [get_ports {c0_ddr4_bg[0]}]
set_property PACKAGE_PIN AH33 [get_ports {c0_ddr4_bg[1]}]

set_property PACKAGE_PIN AF2 [get_ports {pcie_rxp[0]}]
set_property PACKAGE_PIN AF1 [get_ports {pcie_rxn[0]}]
set_property PACKAGE_PIN AF7 [get_ports {pcie_txp[0]}]
set_property PACKAGE_PIN AF6 [get_ports {pcie_txn[0]}]
set_property PACKAGE_PIN AG4 [get_ports {pcie_rxp[1]}]
set_property PACKAGE_PIN AG3 [get_ports {pcie_rxn[1]}]
set_property PACKAGE_PIN AG9 [get_ports {pcie_txp[1]}]
set_property PACKAGE_PIN AG8 [get_ports {pcie_txn[1]}]
set_property PACKAGE_PIN AH2 [get_ports {pcie_rxp[2]}]
set_property PACKAGE_PIN AH1 [get_ports {pcie_rxn[2]}]
set_property PACKAGE_PIN AH7 [get_ports {pcie_txp[2]}]
set_property PACKAGE_PIN AH6 [get_ports {pcie_txn[2]}]
set_property PACKAGE_PIN AJ4 [get_ports {pcie_rxp[3]}]
set_property PACKAGE_PIN AJ3 [get_ports {pcie_rxn[3]}]
set_property PACKAGE_PIN AJ9 [get_ports {pcie_txp[3]}]
set_property PACKAGE_PIN AJ8 [get_ports {pcie_txn[3]}]
set_property PACKAGE_PIN AK2 [get_ports {pcie_rxp[4]}]
set_property PACKAGE_PIN AK1 [get_ports {pcie_rxn[4]}]
set_property PACKAGE_PIN AK7 [get_ports {pcie_txp[4]}]
set_property PACKAGE_PIN AK6 [get_ports {pcie_txn[4]}]
set_property PACKAGE_PIN AL4 [get_ports {pcie_rxp[5]}]
set_property PACKAGE_PIN AL3 [get_ports {pcie_rxn[5]}]
set_property PACKAGE_PIN AL9 [get_ports {pcie_txp[5]}]
set_property PACKAGE_PIN AL8 [get_ports {pcie_txn[5]}]
set_property PACKAGE_PIN AM2 [get_ports {pcie_rxp[6]}]
set_property PACKAGE_PIN AM1 [get_ports {pcie_rxn[6]}]
set_property PACKAGE_PIN AM7 [get_ports {pcie_txp[6]}]
set_property PACKAGE_PIN AM6 [get_ports {pcie_txn[6]}]
set_property PACKAGE_PIN AN4 [get_ports {pcie_rxp[7]}]
set_property PACKAGE_PIN AN3 [get_ports {pcie_rxn[7]}]
set_property PACKAGE_PIN AN9 [get_ports {pcie_txp[7]}]
set_property PACKAGE_PIN AN8 [get_ports {pcie_txn[7]}]
set_property PACKAGE_PIN AP2 [get_ports {pcie_rxp[8]}]
set_property PACKAGE_PIN AP1 [get_ports {pcie_rxn[8]}]
set_property PACKAGE_PIN AP7 [get_ports {pcie_txp[8]}]
set_property PACKAGE_PIN AP6 [get_ports {pcie_txn[8]}]
set_property PACKAGE_PIN AR4 [get_ports {pcie_rxp[9]}]
set_property PACKAGE_PIN AR3 [get_ports {pcie_rxn[9]}]
set_property PACKAGE_PIN AR9 [get_ports {pcie_txp[9]}]
set_property PACKAGE_PIN AR8 [get_ports {pcie_txn[9]}]
set_property PACKAGE_PIN AT2 [get_ports {pcie_rxp[10]}]
set_property PACKAGE_PIN AT1 [get_ports {pcie_rxn[10]}]
set_property PACKAGE_PIN AT7 [get_ports {pcie_txp[10]}]
set_property PACKAGE_PIN AT6 [get_ports {pcie_txn[10]}]
set_property PACKAGE_PIN AU4 [get_ports {pcie_rxp[11]}]
set_property PACKAGE_PIN AU3 [get_ports {pcie_rxn[11]}]
set_property PACKAGE_PIN AU9 [get_ports {pcie_txp[11]}]
set_property PACKAGE_PIN AU8 [get_ports {pcie_txn[11]}]
set_property PACKAGE_PIN AV2 [get_ports {pcie_rxp[12]}]
set_property PACKAGE_PIN AV1 [get_ports {pcie_rxn[12]}]
set_property PACKAGE_PIN AV7 [get_ports {pcie_txp[12]}]
set_property PACKAGE_PIN AV6 [get_ports {pcie_txn[12]}]
set_property PACKAGE_PIN AW4 [get_ports {pcie_rxp[13]}]
set_property PACKAGE_PIN AW3 [get_ports {pcie_rxn[13]}]
set_property PACKAGE_PIN BB5 [get_ports {pcie_txp[13]}]
set_property PACKAGE_PIN BB4 [get_ports {pcie_txn[13]}]
set_property PACKAGE_PIN BA2 [get_ports {pcie_rxp[14]}]
set_property PACKAGE_PIN BA1 [get_ports {pcie_rxn[14]}]
set_property PACKAGE_PIN BD5 [get_ports {pcie_txp[14]}]
set_property PACKAGE_PIN BD4 [get_ports {pcie_txn[14]}]
set_property PACKAGE_PIN BC2 [get_ports {pcie_rxp[15]}]
set_property PACKAGE_PIN BC1 [get_ports {pcie_rxn[15]}]
set_property PACKAGE_PIN BF5 [get_ports {pcie_txp[15]}]
set_property PACKAGE_PIN BF4 [get_ports {pcie_txn[15]}]
set_property PACKAGE_PIN AT10 [get_ports pcie_refclkn]
set_property PACKAGE_PIN AT11 [get_ports pcie_refclkp]
create_clock -period 10.000 -name pcie_sys_clk [get_ports pcie_refclkp]
set_property PACKAGE_PIN AR26 [get_ports pcie_rstn]
set_property IOSTANDARD LVCMOS18 [get_ports pcie_rstn]
set_property PULLUP true [get_ports pcie_rstn]
set_false_path -from [get_ports pcie_rstn]
set_property PACKAGE_PIN BC18 [get_ports pcie_lnkup]
set_property IOSTANDARD LVCMOS18 [get_ports pcie_lnkup]

set_false_path -from [get_cells xdma_diff/stall_cdc_reg] -to [get_cells -hierarchical *stall_s3*]
set_false_path -from [get_clocks -of_objects [get_pins ddr4/inst/u_ddr4_infrastructure/gen_mmcme4.u_mmcme_adv_inst/CLKOUT2]] -to [get_clocks -of_objects [get_pins xdma_wrapper/xlnx_bd_xdma_i/xdma_0/inst/pcie4_ip_i/inst/gt_top_i/diablo_gt.diablo_gt_phy_wrapper/phy_clk_i/bufg_gt_userclk/O]]






















