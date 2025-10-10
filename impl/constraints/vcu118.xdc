# XDC constraints for the Xilinx VCU118 board
# part: xcvu9p-flga2104-2L-e

# General configuration
# set_property CFGBVS GND                                [current_design]
# set_property CONFIG_VOLTAGE 1.8                        [current_design]
# set_property BITSTREAM.GENERAL.COMPRESS true           [current_design]
# set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN {DIV-1} [current_design]
# set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES       [current_design]
# set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8           [current_design]
# set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES        [current_design]

set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8 			[current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN div-1 	[current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES 		[current_design]
set_property BITSTREAM.CONFIG.SPI_OPCODE 8'h6B 			[current_design]
set_property CONFIG_MODE SPIx8 							[current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE 			[current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pulldown 		[current_design]
set_property CONFIG_VOLTAGE 1.8 						[current_design]


# System clocks
# 300 MHz
#set_property -dict {LOC G31  IOSTANDARD DIFF_SSTL12} [get_ports clk_300mhz_p]
#set_property -dict {LOC F31  IOSTANDARD DIFF_SSTL12} [get_ports clk_300mhz_n]
#create_clock -period 3.333 -name clk_300mhz [get_ports clk_300mhz_p]

# 250 MHz
#set_property -dict {LOC E12  IOSTANDARD DIFF_SSTL12} [get_ports clk_250mhz_1_p]
#set_property -dict {LOC D12  IOSTANDARD DIFF_SSTL12} [get_ports clk_250mhz_1_n]
#create_clock -period 4 -name clk_250mhz_1 [get_ports clk_250mhz_1_p]

#set_property -dict {LOC AW26 IOSTANDARD DIFF_SSTL12} [get_ports clk_250mhz_2_p]
#set_property -dict {LOC AW27 IOSTANDARD DIFF_SSTL12} [get_ports clk_250mhz_2_n]
#create_clock -period 4 -name clk_250mhz_2 [get_ports clk_250mhz_2_p]

# # 125 MHz
# set_property -dict {LOC AY24 IOSTANDARD LVDS} [get_ports clk_125mhz_p]
# set_property -dict {LOC AY23 IOSTANDARD LVDS} [get_ports clk_125mhz_n]
# create_clock -period 8.000 -name clk_125mhz [get_ports clk_125mhz_p]

# # 90 MHz
# set_property -dict {LOC AL20 IOSTANDARD LVCMOS18} [get_ports clk_90mhz]
# create_clock -period 11.111 -name clk_90mhz [get_ports clk_90mhz]


# 50 MHz
# set_property -dict {LOC AL20 IOSTANDARD LVCMOS18} [get_ports clk]
# create_clock -period 20.000 -name clk [get_ports clk]

# # LEDs
# set_property -dict {LOC AT32 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[0]}]
# set_property -dict {LOC AV34 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[1]}]
# set_property -dict {LOC AY30 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[2]}]
# set_property -dict {LOC BB32 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[3]}]
# set_property -dict {LOC BF32 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[4]}]
# set_property -dict {LOC AU37 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[5]}]
# set_property -dict {LOC AV36 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[6]}]
# set_property -dict {LOC BA37 IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {led[7]}]

# set_false_path -to [get_ports {led[*]}]
# set_output_delay 0 [get_ports {led[*]}]

# Reset button
set_property -dict {LOC L19  IOSTANDARD LVCMOS12} [get_ports reset]

# # Push buttons
# set_property -dict {LOC BB24 IOSTANDARD LVCMOS18} [get_ports btnu]
# set_property -dict {LOC BF22 IOSTANDARD LVCMOS18} [get_ports btnl]
# set_property -dict {LOC BE22 IOSTANDARD LVCMOS18} [get_ports btnd]
# set_property -dict {LOC BE23 IOSTANDARD LVCMOS18} [get_ports btnr]
# set_property -dict {LOC BD23 IOSTANDARD LVCMOS18} [get_ports btnc]

# set_false_path -from [get_ports {btnu btnl btnd btnr btnc}]
# set_input_delay 0 [get_ports {btnu btnl btnd btnr btnc}]

# # DIP switches
# set_property -dict {LOC B17  IOSTANDARD LVCMOS12} [get_ports {sw[0]}]
# set_property -dict {LOC G16  IOSTANDARD LVCMOS12} [get_ports {sw[1]}]
# set_property -dict {LOC J16  IOSTANDARD LVCMOS12} [get_ports {sw[2]}]
# set_property -dict {LOC D21  IOSTANDARD LVCMOS12} [get_ports {sw[3]}]

# set_false_path -from [get_ports {sw[*]}]
# set_input_delay 0 [get_ports {sw[*]}]

# PMOD0
#set_property -dict {LOC AY14 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[0]}]
#set_property -dict {LOC AY15 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[1]}]
#set_property -dict {LOC AW15 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[2]}]
#set_property -dict {LOC AV15 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[3]}]
#set_property -dict {LOC AV16 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[4]}]
#set_property -dict {LOC AU16 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[5]}]
#set_property -dict {LOC AT15 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[6]}]
#set_property -dict {LOC AT16 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports {pmod0[7]}]

#set_false_path -to [get_ports {pmod0[*]}]
#set_output_delay 0 [get_ports {pmod0[*]}]

# PMOD1
#set_property -dict {LOC N28  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[0]}]
#set_property -dict {LOC M30  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[1]}]
#set_property -dict {LOC N30  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[2]}]
#set_property -dict {LOC P30  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[3]}]
#set_property -dict {LOC P29  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[4]}]
#set_property -dict {LOC L31  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[5]}]
#set_property -dict {LOC M31  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[6]}]
#set_property -dict {LOC R29  IOSTANDARD LVCMOS12 SLEW SLOW DRIVE 8} [get_ports {pmod1[7]}]

#set_false_path -to [get_ports {pmod1[*]}]
#set_output_delay 0 [get_ports {pmod1[*]}]

# UART
# set_property -dict {LOC BB21 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports io_uart_txd]
# set_property -dict {LOC AW25 IOSTANDARD LVCMOS18} [get_ports io_uart_rxd]
# set_property -dict {LOC BB22 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports uart_rts]
# set_property -dict {LOC AY25 IOSTANDARD LVCMOS18} [get_ports uart_cts]

# set_false_path -to [get_ports {io_uart_txd}]
# set_output_delay 0 [get_ports {io_uart_txd}]
# set_false_path -from [get_ports {io_uart_rxd}]
# set_input_delay 0 [get_ports {io_uart_rxd}]

# set_false_path -to [get_ports {io_uart_txd uart_rts}]
# set_output_delay 0 [get_ports {io_uart_txd uart_rts}]
# set_false_path -from [get_ports {io_uart_rxd uart_cts}]
# set_input_delay 0 [get_ports {io_uart_rxd uart_cts}]

# DDR C1
# 250 MHZ clk
set_property PACKAGE_PIN E12        [ get_ports "c1_sys_clk_p" ]
set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c1_sys_clk_p" ]
set_property PACKAGE_PIN D12        [ get_ports "c1_sys_clk_n" ]
set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c1_sys_clk_n" ]

set_property PACKAGE_PIN E13      [get_ports "c1_ddr4_act_n"];
set_property PACKAGE_PIN D14      [get_ports "c1_ddr4_adr[0]"];
set_property PACKAGE_PIN C12      [get_ports "c1_ddr4_adr[10]"];
set_property PACKAGE_PIN B13      [get_ports "c1_ddr4_adr[11]"];
set_property PACKAGE_PIN C13      [get_ports "c1_ddr4_adr[12]"];
set_property PACKAGE_PIN D15      [get_ports "c1_ddr4_adr[13]"];
set_property PACKAGE_PIN H14      [get_ports "c1_ddr4_adr[14]"];
set_property PACKAGE_PIN H15      [get_ports "c1_ddr4_adr[15]"];
set_property PACKAGE_PIN F15      [get_ports "c1_ddr4_adr[16]"];
set_property PACKAGE_PIN B15      [get_ports "c1_ddr4_adr[1]"];
set_property PACKAGE_PIN B16      [get_ports "c1_ddr4_adr[2]"];
set_property PACKAGE_PIN C14      [get_ports "c1_ddr4_adr[3]"];
set_property PACKAGE_PIN C15      [get_ports "c1_ddr4_adr[4]"];
set_property PACKAGE_PIN A13      [get_ports "c1_ddr4_adr[5]"];
set_property PACKAGE_PIN A14      [get_ports "c1_ddr4_adr[6]"];
set_property PACKAGE_PIN A15      [get_ports "c1_ddr4_adr[7]"];
set_property PACKAGE_PIN A16      [get_ports "c1_ddr4_adr[8]"];
set_property PACKAGE_PIN B12      [get_ports "c1_ddr4_adr[9]"];
set_property PACKAGE_PIN G15      [get_ports "c1_ddr4_ba[0]"];
set_property PACKAGE_PIN G13      [get_ports "c1_ddr4_ba[1]"];
set_property PACKAGE_PIN H13      [get_ports "c1_ddr4_bg"];
set_property PACKAGE_PIN E14      [get_ports "c1_ddr4_ck_c"];
set_property PACKAGE_PIN F14      [get_ports "c1_ddr4_ck_t"];
set_property PACKAGE_PIN A10      [get_ports "c1_ddr4_cke"];
set_property PACKAGE_PIN F13      [get_ports "c1_ddr4_cs_n"];
set_property PACKAGE_PIN G11      [get_ports "c1_ddr4_dm_n[0]"];
set_property PACKAGE_PIN R18      [get_ports "c1_ddr4_dm_n[1]"];
set_property PACKAGE_PIN K17      [get_ports "c1_ddr4_dm_n[2]"];
set_property PACKAGE_PIN G18      [get_ports "c1_ddr4_dm_n[3]"];
set_property PACKAGE_PIN B18      [get_ports "c1_ddr4_dm_n[4]"];
set_property PACKAGE_PIN P20      [get_ports "c1_ddr4_dm_n[5]"];
set_property PACKAGE_PIN L23      [get_ports "c1_ddr4_dm_n[6]"];
set_property PACKAGE_PIN G22      [get_ports "c1_ddr4_dm_n[7]"];
set_property PACKAGE_PIN F11      [get_ports "c1_ddr4_dq[0]"];
set_property PACKAGE_PIN E11      [get_ports "c1_ddr4_dq[1]"];
set_property PACKAGE_PIN F10      [get_ports "c1_ddr4_dq[2]"];
set_property PACKAGE_PIN F9       [get_ports "c1_ddr4_dq[3]"];
set_property PACKAGE_PIN H12      [get_ports "c1_ddr4_dq[4]"];
set_property PACKAGE_PIN G12      [get_ports "c1_ddr4_dq[5]"];
set_property PACKAGE_PIN E9       [get_ports "c1_ddr4_dq[6]"];
set_property PACKAGE_PIN D9       [get_ports "c1_ddr4_dq[7]"];
set_property PACKAGE_PIN R19      [get_ports "c1_ddr4_dq[8]"];
set_property PACKAGE_PIN P19      [get_ports "c1_ddr4_dq[9]"];
set_property PACKAGE_PIN M18      [get_ports "c1_ddr4_dq[10]"];
set_property PACKAGE_PIN M17      [get_ports "c1_ddr4_dq[11]"];
set_property PACKAGE_PIN N19      [get_ports "c1_ddr4_dq[12]"];
set_property PACKAGE_PIN N18      [get_ports "c1_ddr4_dq[13]"];
set_property PACKAGE_PIN N17      [get_ports "c1_ddr4_dq[14]"];
set_property PACKAGE_PIN M16      [get_ports "c1_ddr4_dq[15]"];
set_property PACKAGE_PIN L16      [get_ports "c1_ddr4_dq[16]"];
set_property PACKAGE_PIN K16      [get_ports "c1_ddr4_dq[17]"];
set_property PACKAGE_PIN L18      [get_ports "c1_ddr4_dq[18]"];
set_property PACKAGE_PIN K18      [get_ports "c1_ddr4_dq[19]"];
set_property PACKAGE_PIN J17      [get_ports "c1_ddr4_dq[20]"];
set_property PACKAGE_PIN H17      [get_ports "c1_ddr4_dq[21]"];
set_property PACKAGE_PIN H19      [get_ports "c1_ddr4_dq[22]"];
set_property PACKAGE_PIN H18      [get_ports "c1_ddr4_dq[23]"];
set_property PACKAGE_PIN F19      [get_ports "c1_ddr4_dq[24]"];
set_property PACKAGE_PIN F18      [get_ports "c1_ddr4_dq[25]"];
set_property PACKAGE_PIN E19      [get_ports "c1_ddr4_dq[26]"];
set_property PACKAGE_PIN E18      [get_ports "c1_ddr4_dq[27]"];
set_property PACKAGE_PIN G20      [get_ports "c1_ddr4_dq[28]"];
set_property PACKAGE_PIN F20      [get_ports "c1_ddr4_dq[29]"];
set_property PACKAGE_PIN E17      [get_ports "c1_ddr4_dq[30]"];
set_property PACKAGE_PIN D16      [get_ports "c1_ddr4_dq[31]"];
set_property PACKAGE_PIN D17      [get_ports "c1_ddr4_dq[32]"];
set_property PACKAGE_PIN C17      [get_ports "c1_ddr4_dq[33]"];
set_property PACKAGE_PIN C19      [get_ports "c1_ddr4_dq[34]"];
set_property PACKAGE_PIN C18      [get_ports "c1_ddr4_dq[35]"];
set_property PACKAGE_PIN D20      [get_ports "c1_ddr4_dq[36]"];
set_property PACKAGE_PIN D19      [get_ports "c1_ddr4_dq[37]"];
set_property PACKAGE_PIN C20      [get_ports "c1_ddr4_dq[38]"];
set_property PACKAGE_PIN B20      [get_ports "c1_ddr4_dq[39]"];
set_property PACKAGE_PIN N23      [get_ports "c1_ddr4_dq[40]"];
set_property PACKAGE_PIN M23      [get_ports "c1_ddr4_dq[41]"];
set_property PACKAGE_PIN R21      [get_ports "c1_ddr4_dq[42]"];
set_property PACKAGE_PIN P21      [get_ports "c1_ddr4_dq[43]"];
set_property PACKAGE_PIN R22      [get_ports "c1_ddr4_dq[44]"];
set_property PACKAGE_PIN P22      [get_ports "c1_ddr4_dq[45]"];
set_property PACKAGE_PIN T23      [get_ports "c1_ddr4_dq[46]"];
set_property PACKAGE_PIN R23      [get_ports "c1_ddr4_dq[47]"];
set_property PACKAGE_PIN K24      [get_ports "c1_ddr4_dq[48]"];
set_property PACKAGE_PIN J24      [get_ports "c1_ddr4_dq[49]"];
set_property PACKAGE_PIN M21      [get_ports "c1_ddr4_dq[50]"];
set_property PACKAGE_PIN L21      [get_ports "c1_ddr4_dq[51]"];
set_property PACKAGE_PIN K21      [get_ports "c1_ddr4_dq[52]"];
set_property PACKAGE_PIN J21      [get_ports "c1_ddr4_dq[53]"];
set_property PACKAGE_PIN K22      [get_ports "c1_ddr4_dq[54]"];
set_property PACKAGE_PIN J22      [get_ports "c1_ddr4_dq[55]"];
set_property PACKAGE_PIN H23      [get_ports "c1_ddr4_dq[56]"];
set_property PACKAGE_PIN H22      [get_ports "c1_ddr4_dq[57]"];
set_property PACKAGE_PIN E23      [get_ports "c1_ddr4_dq[58]"];
set_property PACKAGE_PIN E22      [get_ports "c1_ddr4_dq[59]"];
set_property PACKAGE_PIN F21      [get_ports "c1_ddr4_dq[60]"];
set_property PACKAGE_PIN E21      [get_ports "c1_ddr4_dq[61]"];
set_property PACKAGE_PIN F24      [get_ports "c1_ddr4_dq[62]"];
set_property PACKAGE_PIN F23      [get_ports "c1_ddr4_dq[63]"];
set_property PACKAGE_PIN D10      [get_ports "c1_ddr4_dqs_c[0]"];
set_property PACKAGE_PIN P16      [get_ports "c1_ddr4_dqs_c[1]"];
set_property PACKAGE_PIN J19      [get_ports "c1_ddr4_dqs_c[2]"];
set_property PACKAGE_PIN E16      [get_ports "c1_ddr4_dqs_c[3]"];
set_property PACKAGE_PIN A18      [get_ports "c1_ddr4_dqs_c[4]"];
set_property PACKAGE_PIN M22      [get_ports "c1_ddr4_dqs_c[5]"];
set_property PACKAGE_PIN L20      [get_ports "c1_ddr4_dqs_c[6]"];
set_property PACKAGE_PIN G23      [get_ports "c1_ddr4_dqs_c[7]"];
set_property PACKAGE_PIN D11      [get_ports "c1_ddr4_dqs_t[0]"];
set_property PACKAGE_PIN P17      [get_ports "c1_ddr4_dqs_t[1]"];
set_property PACKAGE_PIN K19      [get_ports "c1_ddr4_dqs_t[2]"];
set_property PACKAGE_PIN F16      [get_ports "c1_ddr4_dqs_t[3]"];
set_property PACKAGE_PIN A19      [get_ports "c1_ddr4_dqs_t[4]"];
set_property PACKAGE_PIN N22      [get_ports "c1_ddr4_dqs_t[5]"];
set_property PACKAGE_PIN M20      [get_ports "c1_ddr4_dqs_t[6]"];
set_property PACKAGE_PIN H24      [get_ports "c1_ddr4_dqs_t[7]"];
set_property PACKAGE_PIN C8       [get_ports "c1_ddr4_odt"];
set_property PACKAGE_PIN N20      [get_ports "c1_ddr4_reset_n"];

# DDR C2
# 250 MHZ clk
set_property PACKAGE_PIN AW26       [ get_ports "c2_sys_clk_p" ]
set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c2_sys_clk_p" ]
set_property PACKAGE_PIN AW27       [ get_ports "c2_sys_clk_n" ]
set_property IOSTANDARD DIFF_SSTL12 [ get_ports "c2_sys_clk_n" ]

set_property PACKAGE_PIN AN25     [get_ports "c2_ddr4_act_n"];
set_property PACKAGE_PIN AM27     [get_ports "c2_ddr4_adr[0]"];
set_property PACKAGE_PIN AL27     [get_ports "c2_ddr4_adr[1]"];
set_property PACKAGE_PIN AP26     [get_ports "c2_ddr4_adr[2]"];
set_property PACKAGE_PIN AP25     [get_ports "c2_ddr4_adr[3]"];
set_property PACKAGE_PIN AN28     [get_ports "c2_ddr4_adr[4]"];
set_property PACKAGE_PIN AM28     [get_ports "c2_ddr4_adr[5]"];
set_property PACKAGE_PIN AP28     [get_ports "c2_ddr4_adr[6]"];
set_property PACKAGE_PIN AP27     [get_ports "c2_ddr4_adr[7]"];
set_property PACKAGE_PIN AN26     [get_ports "c2_ddr4_adr[8]"];
set_property PACKAGE_PIN AM26     [get_ports "c2_ddr4_adr[9]"];
set_property PACKAGE_PIN AR28     [get_ports "c2_ddr4_adr[10]"];
set_property PACKAGE_PIN AR27     [get_ports "c2_ddr4_adr[11]"];
set_property PACKAGE_PIN AV25     [get_ports "c2_ddr4_adr[12]"];
set_property PACKAGE_PIN AT25     [get_ports "c2_ddr4_adr[13]"];
set_property PACKAGE_PIN AV28     [get_ports "c2_ddr4_adr[14]"];
set_property PACKAGE_PIN AU26     [get_ports "c2_ddr4_adr[15]"];
set_property PACKAGE_PIN AV26     [get_ports "c2_ddr4_adr[16]"];
set_property PACKAGE_PIN AR25     [get_ports "c2_ddr4_ba[0]"];
set_property PACKAGE_PIN AU28     [get_ports "c2_ddr4_ba[1]"];
set_property PACKAGE_PIN AU27     [get_ports "c2_ddr4_bg"];
set_property PACKAGE_PIN AT27     [get_ports "c2_ddr4_ck_c"];
set_property PACKAGE_PIN AT26     [get_ports "c2_ddr4_ck_t"];
set_property PACKAGE_PIN AW28     [get_ports "c2_ddr4_cke"];
set_property PACKAGE_PIN AY29     [get_ports "c2_ddr4_cs_n"];
set_property PACKAGE_PIN BD30     [get_ports "c2_ddr4_dq[0]"];
set_property PACKAGE_PIN BE30     [get_ports "c2_ddr4_dq[1]"];
set_property PACKAGE_PIN BD32     [get_ports "c2_ddr4_dq[2]"];
set_property PACKAGE_PIN BE33     [get_ports "c2_ddr4_dq[3]"];
set_property PACKAGE_PIN BC33     [get_ports "c2_ddr4_dq[4]"];
set_property PACKAGE_PIN BD33     [get_ports "c2_ddr4_dq[5]"];
set_property PACKAGE_PIN BC31     [get_ports "c2_ddr4_dq[6]"];
set_property PACKAGE_PIN BD31     [get_ports "c2_ddr4_dq[7]"];
set_property PACKAGE_PIN BA32     [get_ports "c2_ddr4_dq[8]"];
set_property PACKAGE_PIN BB33     [get_ports "c2_ddr4_dq[9]"];
set_property PACKAGE_PIN BA30     [get_ports "c2_ddr4_dq[10]"];
set_property PACKAGE_PIN BA31     [get_ports "c2_ddr4_dq[11]"];
set_property PACKAGE_PIN AW31     [get_ports "c2_ddr4_dq[12]"];
set_property PACKAGE_PIN AW32     [get_ports "c2_ddr4_dq[13]"];
set_property PACKAGE_PIN AY32     [get_ports "c2_ddr4_dq[14]"];
set_property PACKAGE_PIN AY33     [get_ports "c2_ddr4_dq[15]"];
set_property PACKAGE_PIN AV30     [get_ports "c2_ddr4_dq[16]"];
set_property PACKAGE_PIN AW30     [get_ports "c2_ddr4_dq[17]"];
set_property PACKAGE_PIN AU33     [get_ports "c2_ddr4_dq[18]"];
set_property PACKAGE_PIN AU34     [get_ports "c2_ddr4_dq[19]"];
set_property PACKAGE_PIN AT31     [get_ports "c2_ddr4_dq[20]"];
set_property PACKAGE_PIN AU32     [get_ports "c2_ddr4_dq[21]"];
set_property PACKAGE_PIN AU31     [get_ports "c2_ddr4_dq[22]"];
set_property PACKAGE_PIN AV31     [get_ports "c2_ddr4_dq[23]"];
set_property PACKAGE_PIN AR33     [get_ports "c2_ddr4_dq[24]"];
set_property PACKAGE_PIN AT34     [get_ports "c2_ddr4_dq[25]"];
set_property PACKAGE_PIN AT29     [get_ports "c2_ddr4_dq[26]"];
set_property PACKAGE_PIN AT30     [get_ports "c2_ddr4_dq[27]"];
set_property PACKAGE_PIN AP30     [get_ports "c2_ddr4_dq[28]"];
set_property PACKAGE_PIN AR30     [get_ports "c2_ddr4_dq[29]"];
set_property PACKAGE_PIN AN30     [get_ports "c2_ddr4_dq[30]"];
set_property PACKAGE_PIN AN31     [get_ports "c2_ddr4_dq[31]"];
set_property PACKAGE_PIN BE34     [get_ports "c2_ddr4_dq[32]"];
set_property PACKAGE_PIN BF34     [get_ports "c2_ddr4_dq[33]"];
set_property PACKAGE_PIN BC35     [get_ports "c2_ddr4_dq[34]"];
set_property PACKAGE_PIN BC36     [get_ports "c2_ddr4_dq[35]"];
set_property PACKAGE_PIN BD36     [get_ports "c2_ddr4_dq[36]"];
set_property PACKAGE_PIN BE37     [get_ports "c2_ddr4_dq[37]"];
set_property PACKAGE_PIN BF36     [get_ports "c2_ddr4_dq[38]"];
set_property PACKAGE_PIN BF37     [get_ports "c2_ddr4_dq[39]"];
set_property PACKAGE_PIN BD37     [get_ports "c2_ddr4_dq[40]"];
set_property PACKAGE_PIN BE38     [get_ports "c2_ddr4_dq[41]"];
set_property PACKAGE_PIN BC39     [get_ports "c2_ddr4_dq[42]"];
set_property PACKAGE_PIN BD40     [get_ports "c2_ddr4_dq[43]"];
set_property PACKAGE_PIN BB38     [get_ports "c2_ddr4_dq[44]"];
set_property PACKAGE_PIN BB39     [get_ports "c2_ddr4_dq[45]"];
set_property PACKAGE_PIN BC38     [get_ports "c2_ddr4_dq[46]"];
set_property PACKAGE_PIN BD38     [get_ports "c2_ddr4_dq[47]"];
set_property PACKAGE_PIN BB36     [get_ports "c2_ddr4_dq[48]"];
set_property PACKAGE_PIN BB37     [get_ports "c2_ddr4_dq[49]"];
set_property PACKAGE_PIN BA39     [get_ports "c2_ddr4_dq[50]"];
set_property PACKAGE_PIN BA40     [get_ports "c2_ddr4_dq[51]"];
set_property PACKAGE_PIN AW40     [get_ports "c2_ddr4_dq[52]"];
set_property PACKAGE_PIN AY40     [get_ports "c2_ddr4_dq[53]"];
set_property PACKAGE_PIN AY38     [get_ports "c2_ddr4_dq[54]"];
set_property PACKAGE_PIN AY39     [get_ports "c2_ddr4_dq[55]"];
set_property PACKAGE_PIN AW35     [get_ports "c2_ddr4_dq[56]"];
set_property PACKAGE_PIN AW36     [get_ports "c2_ddr4_dq[57]"];
set_property PACKAGE_PIN AU40     [get_ports "c2_ddr4_dq[58]"];
set_property PACKAGE_PIN AV40     [get_ports "c2_ddr4_dq[59]"];
set_property PACKAGE_PIN AU38     [get_ports "c2_ddr4_dq[60]"];
set_property PACKAGE_PIN AU39     [get_ports "c2_ddr4_dq[61]"];
set_property PACKAGE_PIN AV38     [get_ports "c2_ddr4_dq[62]"];
set_property PACKAGE_PIN AV39     [get_ports "c2_ddr4_dq[63]"];
set_property PACKAGE_PIN BF31     [get_ports "c2_ddr4_dqs_c[0]"];
set_property PACKAGE_PIN BA34     [get_ports "c2_ddr4_dqs_c[1]"];
set_property PACKAGE_PIN AV29     [get_ports "c2_ddr4_dqs_c[2]"];
set_property PACKAGE_PIN AP32     [get_ports "c2_ddr4_dqs_c[3]"];
set_property PACKAGE_PIN BF35     [get_ports "c2_ddr4_dqs_c[4]"];
set_property PACKAGE_PIN BF39     [get_ports "c2_ddr4_dqs_c[5]"];
set_property PACKAGE_PIN BA36     [get_ports "c2_ddr4_dqs_c[6]"];
set_property PACKAGE_PIN AW38     [get_ports "c2_ddr4_dqs_c[7]"];
set_property PACKAGE_PIN BF30     [get_ports "c2_ddr4_dqs_t[0]"];
set_property PACKAGE_PIN AY34     [get_ports "c2_ddr4_dqs_t[1]"];
set_property PACKAGE_PIN AU29     [get_ports "c2_ddr4_dqs_t[2]"];
set_property PACKAGE_PIN AP31     [get_ports "c2_ddr4_dqs_t[3]"];
set_property PACKAGE_PIN BE35     [get_ports "c2_ddr4_dqs_t[4]"];
set_property PACKAGE_PIN BE39     [get_ports "c2_ddr4_dqs_t[5]"];
set_property PACKAGE_PIN BA35     [get_ports "c2_ddr4_dqs_t[6]"];
set_property PACKAGE_PIN AW37     [get_ports "c2_ddr4_dqs_t[7]"];
set_property PACKAGE_PIN BE32     [get_ports "c2_ddr4_dm_n[0]"];
set_property PACKAGE_PIN BB31     [get_ports "c2_ddr4_dm_n[1]"];
set_property PACKAGE_PIN AV33     [get_ports "c2_ddr4_dm_n[2]"];
set_property PACKAGE_PIN AR32     [get_ports "c2_ddr4_dm_n[3]"];
set_property PACKAGE_PIN BC34     [get_ports "c2_ddr4_dm_n[4]"];
set_property PACKAGE_PIN BE40     [get_ports "c2_ddr4_dm_n[5]"];
set_property PACKAGE_PIN AY37     [get_ports "c2_ddr4_dm_n[6]"];
set_property PACKAGE_PIN AV35     [get_ports "c2_ddr4_dm_n[7]"];
set_property PACKAGE_PIN BB29     [get_ports "c2_ddr4_odt"];
set_property PACKAGE_PIN BD35     [get_ports "c2_ddr4_reset_n"];


# # Gigabit Ethernet SGMII PHY
# set_property -dict {LOC AU24 IOSTANDARD LVDS} [get_ports phy_sgmii_rx_p]
# set_property -dict {LOC AV24 IOSTANDARD LVDS} [get_ports phy_sgmii_rx_n]
# set_property -dict {LOC AU21 IOSTANDARD LVDS} [get_ports phy_sgmii_tx_p]
# set_property -dict {LOC AV21 IOSTANDARD LVDS} [get_ports phy_sgmii_tx_n]
# set_property -dict {LOC AT22 IOSTANDARD LVDS} [get_ports phy_sgmii_clk_p]
# set_property -dict {LOC AU22 IOSTANDARD LVDS} [get_ports phy_sgmii_clk_n]
# set_property -dict {LOC BA21 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports phy_reset_n]
# set_property -dict {LOC AR24 IOSTANDARD LVCMOS18} [get_ports phy_int_n]
# set_property -dict {LOC AR23 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports phy_mdio]
# set_property -dict {LOC AV23 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports phy_mdc]

# # 625 MHz ref clock from SGMII PHY
# #create_clock -period 1.600 -name phy_sgmii_clk [get_ports phy_sgmii_clk_p]

# set_false_path -to [get_ports {phy_reset_n phy_mdio phy_mdc}]
# set_output_delay 0 [get_ports {phy_reset_n phy_mdio phy_mdc}]
# set_false_path -from [get_ports {phy_int_n phy_mdio}]
# set_input_delay 0 [get_ports {phy_int_n phy_mdio}]

# QSFP28 Interfaces
#set_property -dict {LOC Y2  } [get_ports qsfp1_rx1_p];# MGTYRXP0_231 GTYE4_CHANNEL_X1Y48 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC Y1  } [get_ports qsfp1_rx1_n];# MGTYRXN0_231 GTYE4_CHANNEL_X1Y48 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC V7  } [get_ports qsfp1_tx1_p];# MGTYTXP0_231 GTYE4_CHANNEL_X1Y48 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC V6  } [get_ports qsfp1_tx1_n];# MGTYTXN0_231 GTYE4_CHANNEL_X1Y48 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC W4  } [get_ports qsfp1_rx2_p];# MGTYRXP1_231 GTYE4_CHANNEL_X1Y49 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC W3  } [get_ports qsfp1_rx2_n];# MGTYRXN1_231 GTYE4_CHANNEL_X1Y49 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC T7  } [get_ports qsfp1_tx2_p];# MGTYTXP1_231 GTYE4_CHANNEL_X1Y49 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC T6  } [get_ports qsfp1_tx2_n];# MGTYTXN1_231 GTYE4_CHANNEL_X1Y49 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC V2  } [get_ports qsfp1_rx3_p];# MGTYRXP2_231 GTYE4_CHANNEL_X1Y50 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC V1  } [get_ports qsfp1_rx3_n];# MGTYRXN2_231 GTYE4_CHANNEL_X1Y50 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC P7  } [get_ports qsfp1_tx3_p];# MGTYTXP2_231 GTYE4_CHANNEL_X1Y50 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC P6  } [get_ports qsfp1_tx3_n];# MGTYTXN2_231 GTYE4_CHANNEL_X1Y50 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC U4  } [get_ports qsfp1_rx4_p];# MGTYRXP3_231 GTYE4_CHANNEL_X1Y51 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC U3  } [get_ports qsfp1_rx4_n];# MGTYRXN3_231 GTYE4_CHANNEL_X1Y51 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC M7  } [get_ports qsfp1_tx4_p];# MGTYTXP3_231 GTYE4_CHANNEL_X1Y51 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC M6  } [get_ports qsfp1_tx4_n];# MGTYTXN3_231 GTYE4_CHANNEL_X1Y51 / GTYE4_COMMON_X1Y12
#set_property -dict {LOC W9  } [get_ports qsfp1_mgt_refclk_0_p];# MGTREFCLK0P_231 from U38.4
#set_property -dict {LOC W8  } [get_ports qsfp1_mgt_refclk_0_n];# MGTREFCLK0N_231 from U38.5
#set_property -dict {LOC U9  } [get_ports qsfp1_mgt_refclk_1_p];# MGTREFCLK1P_231 from U57.28
#set_property -dict {LOC U8  } [get_ports qsfp1_mgt_refclk_1_n];# MGTREFCLK1N_231 from U57.29
#set_property -dict {LOC AM23 IOSTANDARD LVDS} [get_ports qsfp1_recclk_p];# to U57.16
#set_property -dict {LOC AM22 IOSTANDARD LVDS} [get_ports qsfp1_recclk_n];# to U57.17
#set_property -dict {LOC AM21 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports qsfp1_modsell]
#set_property -dict {LOC BA22 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports qsfp1_resetl]
#set_property -dict {LOC AL21 IOSTANDARD LVCMOS18 PULLUP true} [get_ports qsfp1_modprsl]
#set_property -dict {LOC AP21 IOSTANDARD LVCMOS18 PULLUP true} [get_ports qsfp1_intl]
#set_property -dict {LOC AN21 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports qsfp1_lpmode]

# 156.25 MHz MGT reference clock
#create_clock -period 6.400 -name qsfp1_mgt_refclk_0 [get_ports qsfp1_mgt_refclk_0_p]

#set_false_path -to [get_ports {qsfp1_modsell qsfp1_resetl qsfp1_lpmode}]
#set_output_delay 0 [get_ports {qsfp1_modsell qsfp1_resetl qsfp1_lpmode}]
#set_false_path -from [get_ports {qsfp1_modprsl qsfp1_intl}]
#set_input_delay 0 [get_ports {qsfp1_modprsl qsfp1_intl}]

#set_property -dict {LOC T2  } [get_ports qsfp2_rx1_p];# MGTYRXP0_232 GTYE4_CHANNEL_X1Y52 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC T1  } [get_ports qsfp2_rx1_n];# MGTYRXN0_232 GTYE4_CHANNEL_X1Y52 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC L5  } [get_ports qsfp2_tx1_p];# MGTYTXP0_232 GTYE4_CHANNEL_X1Y52 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC L4  } [get_ports qsfp2_tx1_n];# MGTYTXN0_232 GTYE4_CHANNEL_X1Y52 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC R4  } [get_ports qsfp2_rx2_p];# MGTYRXP1_232 GTYE4_CHANNEL_X1Y53 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC R3  } [get_ports qsfp2_rx2_n];# MGTYRXN1_232 GTYE4_CHANNEL_X1Y53 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC K7  } [get_ports qsfp2_tx2_p];# MGTYTXP1_232 GTYE4_CHANNEL_X1Y53 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC K6  } [get_ports qsfp2_tx2_n];# MGTYTXN1_232 GTYE4_CHANNEL_X1Y53 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC P2  } [get_ports qsfp2_rx3_p];# MGTYRXP2_232 GTYE4_CHANNEL_X1Y54 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC P1  } [get_ports qsfp2_rx3_n];# MGTYRXN2_232 GTYE4_CHANNEL_X1Y54 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC J5  } [get_ports qsfp2_tx3_p];# MGTYTXP2_232 GTYE4_CHANNEL_X1Y54 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC J4  } [get_ports qsfp2_tx3_n];# MGTYTXN2_232 GTYE4_CHANNEL_X1Y54 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC M2  } [get_ports qsfp2_rx4_p];# MGTYRXP3_232 GTYE4_CHANNEL_X1Y55 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC M1  } [get_ports qsfp2_rx4_n];# MGTYRXN3_232 GTYE4_CHANNEL_X1Y55 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC H7  } [get_ports qsfp2_tx4_p];# MGTYTXP3_232 GTYE4_CHANNEL_X1Y55 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC H6  } [get_ports qsfp2_tx4_n];# MGTYTXN3_232 GTYE4_CHANNEL_X1Y55 / GTYE4_COMMON_X1Y13
#set_property -dict {LOC R9  } [get_ports qsfp2_mgt_refclk_0_p];# MGTREFCLK0P_232 from U104.13
#set_property -dict {LOC R8  } [get_ports qsfp2_mgt_refclk_0_n];# MGTREFCLK0N_232 from U104.14
#set_property -dict {LOC N9  } [get_ports qsfp2_mgt_refclk_1_p];# MGTREFCLK1P_232 from U57.35
#set_property -dict {LOC N8  } [get_ports qsfp2_mgt_refclk_1_n];# MGTREFCLK1N_232 from U57.34
#set_property -dict {LOC AP23 IOSTANDARD LVDS} [get_ports qsfp2_recclk_p];# to U57.12
#set_property -dict {LOC AP22 IOSTANDARD LVDS} [get_ports qsfp2_recclk_n];# to U57.13
#set_property -dict {LOC AN23 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports qsfp2_modsell]
#set_property -dict {LOC AY22 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports qsfp2_resetl]
#set_property -dict {LOC AN24 IOSTANDARD LVCMOS18 PULLUP true} [get_ports qsfp2_modprsl]
#set_property -dict {LOC AT21 IOSTANDARD LVCMOS18 PULLUP true} [get_ports qsfp2_intl]
#set_property -dict {LOC AT24 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports qsfp2_lpmode]

# 156.25 MHz MGT reference clock
#create_clock -period 6.400 -name qsfp2_mgt_refclk_0 [get_ports qsfp2_mgt_refclk_0_p]

#set_false_path -to [get_ports {qsfp2_modsell qsfp2_resetl qsfp2_lpmode}]
#set_output_delay 0 [get_ports {qsfp2_modsell qsfp2_resetl qsfp2_lpmode}]
#set_false_path -from [get_ports {qsfp2_modprsl qsfp2_intl}]
#set_input_delay 0 [get_ports {qsfp2_modprsl qsfp2_intl}]

# I2C interface
#set_property -dict {LOC AM24 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports i2c_scl]
#set_property -dict {LOC AL24 IOSTANDARD LVCMOS18 SLEW SLOW DRIVE 8} [get_ports i2c_sda]

#set_false_path -to [get_ports {i2c_sda i2c_scl}]
#set_output_delay 0 [get_ports {i2c_sda i2c_scl}]
#set_false_path -from [get_ports {i2c_sda i2c_scl}]
#set_input_delay 0 [get_ports {i2c_sda i2c_scl}]

# PCIe Interface
#set_property -dict {LOC AA4  } [get_ports {pcie_rx_p[0]}]  ;# MGTYRXP3_227 GTYE4_CHANNEL_X1Y35 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AA3  } [get_ports {pcie_rx_n[0]}]  ;# MGTYRXN3_227 GTYE4_CHANNEL_X1Y35 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC Y7   } [get_ports {pcie_tx_p[0]}]  ;# MGTYTXP3_227 GTYE4_CHANNEL_X1Y35 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC Y6   } [get_ports {pcie_tx_n[0]}]  ;# MGTYTXN3_227 GTYE4_CHANNEL_X1Y35 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AB2  } [get_ports {pcie_rx_p[1]}]  ;# MGTYRXP2_227 GTYE4_CHANNEL_X1Y34 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AB1  } [get_ports {pcie_rx_n[1]}]  ;# MGTYRXN2_227 GTYE4_CHANNEL_X1Y34 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AB7  } [get_ports {pcie_tx_p[1]}]  ;# MGTYTXP2_227 GTYE4_CHANNEL_X1Y34 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AB6  } [get_ports {pcie_tx_n[1]}]  ;# MGTYTXN2_227 GTYE4_CHANNEL_X1Y34 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AC4  } [get_ports {pcie_rx_p[2]}]  ;# MGTYRXP1_227 GTYE4_CHANNEL_X1Y33 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AC3  } [get_ports {pcie_rx_n[2]}]  ;# MGTYRXN1_227 GTYE4_CHANNEL_X1Y33 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AD7  } [get_ports {pcie_tx_p[2]}]  ;# MGTYTXP1_227 GTYE4_CHANNEL_X1Y33 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AD6  } [get_ports {pcie_tx_n[2]}]  ;# MGTYTXN1_227 GTYE4_CHANNEL_X1Y33 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AD2  } [get_ports {pcie_rx_p[3]}]  ;# MGTYRXP0_227 GTYE4_CHANNEL_X1Y32 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AD1  } [get_ports {pcie_rx_n[3]}]  ;# MGTYRXN0_227 GTYE4_CHANNEL_X1Y32 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AF7  } [get_ports {pcie_tx_p[3]}]  ;# MGTYTXP0_227 GTYE4_CHANNEL_X1Y32 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AF6  } [get_ports {pcie_tx_n[3]}]  ;# MGTYTXN0_227 GTYE4_CHANNEL_X1Y32 / GTYE4_COMMON_X1Y8
#set_property -dict {LOC AE4  } [get_ports {pcie_rx_p[4]}]  ;# MGTYRXP3_226 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AE3  } [get_ports {pcie_rx_n[4]}]  ;# MGTYRXN3_226 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AH7  } [get_ports {pcie_tx_p[4]}]  ;# MGTYTXP3_226 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AH6  } [get_ports {pcie_tx_n[4]}]  ;# MGTYTXN3_226 GTYE4_CHANNEL_X1Y31 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AF2  } [get_ports {pcie_rx_p[5]}]  ;# MGTYRXP2_226 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AF1  } [get_ports {pcie_rx_n[5]}]  ;# MGTYRXN2_226 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AK7  } [get_ports {pcie_tx_p[5]}]  ;# MGTYTXP2_226 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AK6  } [get_ports {pcie_tx_n[5]}]  ;# MGTYTXN2_226 GTYE4_CHANNEL_X1Y30 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AG4  } [get_ports {pcie_rx_p[6]}]  ;# MGTYRXP1_226 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AG3  } [get_ports {pcie_rx_n[6]}]  ;# MGTYRXN1_226 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AM7  } [get_ports {pcie_tx_p[6]}]  ;# MGTYTXP1_226 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AM6  } [get_ports {pcie_tx_n[6]}]  ;# MGTYTXN1_226 GTYE4_CHANNEL_X1Y29 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AH2  } [get_ports {pcie_rx_p[7]}]  ;# MGTYRXP0_226 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AH1  } [get_ports {pcie_rx_n[7]}]  ;# MGTYRXN0_226 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AN5  } [get_ports {pcie_tx_p[7]}]  ;# MGTYTXP0_226 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AN4  } [get_ports {pcie_tx_n[7]}]  ;# MGTYTXN0_226 GTYE4_CHANNEL_X1Y28 / GTYE4_COMMON_X1Y7
#set_property -dict {LOC AJ4  } [get_ports {pcie_rx_p[8]}]  ;# MGTYRXP3_225 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AJ3  } [get_ports {pcie_rx_n[8]}]  ;# MGTYRXN3_225 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AP7  } [get_ports {pcie_tx_p[8]}]  ;# MGTYTXP3_225 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AP6  } [get_ports {pcie_tx_n[8]}]  ;# MGTYTXN3_225 GTYE4_CHANNEL_X1Y27 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AK2  } [get_ports {pcie_rx_p[9]}]  ;# MGTYRXP2_225 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AK1  } [get_ports {pcie_rx_n[9]}]  ;# MGTYRXN2_225 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AR5  } [get_ports {pcie_tx_p[9]}]  ;# MGTYTXP2_225 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AR4  } [get_ports {pcie_tx_n[9]}]  ;# MGTYTXN2_225 GTYE4_CHANNEL_X1Y26 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AM2  } [get_ports {pcie_rx_p[10]}];# MGTYRXP1_225 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AM1  } [get_ports {pcie_rx_n[10]}];# MGTYRXN1_225 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AT7  } [get_ports {pcie_tx_p[10]}];# MGTYTXP1_225 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AT6  } [get_ports {pcie_tx_n[10]}];# MGTYTXN1_225 GTYE4_CHANNEL_X1Y25 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AP2  } [get_ports {pcie_rx_p[11]}];# MGTYRXP0_225 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AP1  } [get_ports {pcie_rx_n[11]}];# MGTYRXN0_225 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AU5  } [get_ports {pcie_tx_p[11]}];# MGTYTXP0_225 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AU4  } [get_ports {pcie_tx_n[11]}];# MGTYTXN0_225 GTYE4_CHANNEL_X1Y24 / GTYE4_COMMON_X1Y6
#set_property -dict {LOC AT2  } [get_ports {pcie_rx_p[12]}];# MGTYRXP3_224 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AT1  } [get_ports {pcie_rx_n[12]}];# MGTYRXN3_224 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AW5  } [get_ports {pcie_tx_p[12]}];# MGTYTXP3_224 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AW4  } [get_ports {pcie_tx_n[12]}];# MGTYTXN3_224 GTYE4_CHANNEL_X1Y23 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AV2  } [get_ports {pcie_rx_p[13]}];# MGTYRXP2_224 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AV1  } [get_ports {pcie_rx_n[13]}];# MGTYRXN2_224 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BA5  } [get_ports {pcie_tx_p[13]}];# MGTYTXP2_224 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BA4  } [get_ports {pcie_tx_n[13]}];# MGTYTXN2_224 GTYE4_CHANNEL_X1Y22 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AY2  } [get_ports {pcie_rx_p[14]}];# MGTYRXP1_224 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AY1  } [get_ports {pcie_rx_n[14]}];# MGTYRXN1_224 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BC5  } [get_ports {pcie_tx_p[14]}];# MGTYTXP1_224 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BC4  } [get_ports {pcie_tx_n[14]}];# MGTYTXN1_224 GTYE4_CHANNEL_X1Y21 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BB2  } [get_ports {pcie_rx_p[15]}];# MGTYRXP0_224 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BB1  } [get_ports {pcie_rx_n[15]}];# MGTYRXN0_224 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BE5  } [get_ports {pcie_tx_p[15]}];# MGTYTXP0_224 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC BE4  } [get_ports {pcie_tx_n[15]}];# MGTYTXN0_224 GTYE4_CHANNEL_X1Y20 / GTYE4_COMMON_X1Y5
#set_property -dict {LOC AC9  } [get_ports pcie_refclk_1_p];# MGTREFCLK0P_227
#set_property -dict {LOC AC8  } [get_ports pcie_refclk_1_n];# MGTREFCLK0N_227
#set_property -dict {LOC AL9  } [get_ports pcie_refclk_2_p];# MGTREFCLK0P_225
#set_property -dict {LOC AL8  } [get_ports pcie_refclk_2_n];# MGTREFCLK0N_225
#set_property -dict {LOC AM17 IOSTANDARD LVCMOS18 PULLUP true} [get_ports pcie_reset_n]

# 100 MHz MGT reference clock
#create_clock -period 10 -name pcie_mgt_refclk_1 [get_ports pcie_refclk_1_p]
#create_clock -period 10 -name pcie_mgt_refclk_2 [get_ports pcie_refclk_2_p]

#set_false_path -from [get_ports {pcie_reset_n}]
#set_input_delay 0 [get_ports {pcie_reset_n}]

# QSPI flash
#set_property -dict {LOC AM19 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {qspi_1_dq[0]}]
#set_property -dict {LOC AM18 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {qspi_1_dq[1]}]
#set_property -dict {LOC AN20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {qspi_1_dq[2]}]
#set_property -dict {LOC AP20 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {qspi_1_dq[3]}]
#set_property -dict {LOC BF16 IOSTANDARD LVCMOS18 DRIVE 12} [get_ports {qspi_1_cs}]

#set_false_path -to [get_ports {qspi_1_dq[*] qspi_1_cs}]
#set_output_delay 0 [get_ports {qspi_1_dq[*] qspi_1_cs}]
#set_false_path -from [get_ports {qspi_1_dq}]
#set_input_delay 0 [get_ports {qspi_1_dq}]
