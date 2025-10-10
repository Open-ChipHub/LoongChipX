
# General configuration

set_property CFGBVS GND                                [current_design]
set_property CONFIG_VOLTAGE 1.8                        [current_design]
set_property BITSTREAM.GENERAL.COMPRESS true           [current_design]
set_property BITSTREAM.CONFIG.EXTMASTERCCLK_EN {DIV-1} [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR YES       [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 8           [current_design]
set_property BITSTREAM.CONFIG.SPI_FALL_EDGE YES        [current_design]


# set_property PACKAGE_PIN N34      [get_ports "clk"] ;# Bank  70 VCCO - VCC1V8   - IO_L14N_T2L_N3_GC_70
# set_property IOSTANDARD  LVDS     [get_ports "clk"] ;# Bank  70 VCCO - VCC1V8   - IO_L14N_T2L_N3_GC_70
# create_clock -period 20.000 -name clk [get_ports clk]

# set_property PACKAGE_PIN T34      [get_ports "reset"] ;# Bank  70 VCCO - VCC1V8   - IO_T1U_N12_70
# set_property IOSTANDARD  LVCMOS18 [get_ports "reset"] ;# Bank  70 VCCO - VCC1V8   - IO_T1U_N12_70

set_property PACKAGE_PIN BA22     [get_ports "io_uart_rxd"] ;# Bank  65 VCCO - VCC1V8   - IO_L2N_T0L_N3_FWE_FCS2_B_65
set_property IOSTANDARD  LVCMOS18 [get_ports "io_uart_rxd"] ;# Bank  65 VCCO - VCC1V8   - IO_L2N_T0L_N3_FWE_FCS2_B_65
set_property PACKAGE_PIN AY22     [get_ports "io_uart_txd"] ;# Bank  65 VCCO - VCC1V8   - IO_L2P_T0L_N2_FOE_B_65
set_property IOSTANDARD  LVCMOS18 [get_ports "io_uart_txd"] ;# Bank  65 VCCO - VCC1V8   - IO_L2P_T0L_N2_FOE_B_65
# set_property PACKAGE_PIN BC21     [get_ports "UART0_RTS_B"] ;# Bank  65 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_RS1_65
# set_property IOSTANDARD  LVCMOS18 [get_ports "UART0_RTS_B"] ;# Bank  65 VCCO - VCC1V8   - IO_L1N_T0L_N1_DBC_RS1_65
# set_property PACKAGE_PIN BB21     [get_ports "UART0_CTS_B"] ;# Bank  65 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_RS0_65
# set_property IOSTANDARD  LVCMOS18 [get_ports "UART0_CTS_B"] ;# Bank  65 VCCO - VCC1V8   - IO_L1P_T0L_N0_DBC_RS0_65


# DDR4
set_property PACKAGE_PIN AW35     	 [get_ports c0_sys_clk_p] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L13P_T2L_N0_GC_QBC_63
set_property IOSTANDARD  DIFF_SSTL12 [get_ports c0_sys_clk_p] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L13P_T2L_N0_GC_QBC_63
set_property PACKAGE_PIN AW36        [get_ports c0_sys_clk_n] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L13N_T2L_N1_GC_QBC_63
set_property IOSTANDARD  DIFF_SSTL12 [get_ports c0_sys_clk_n] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L13N_T2L_N1_GC_QBC_63

# set_property PACKAGE_PIN BC37        [get_ports c0_ddr4_act_n] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L8P_T1L_N2_AD5P_63
# set_property IOSTANDARD  SSTL12_DCI  [get_ports c0_ddr4_act_n] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L8P_T1L_N2_AD5P_63


# # set_property PACKAGE_PIN AR33     [get_ports "c0_ddr4_adr[17"] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L24P_T3U_N10_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports "c0_ddr4_adr[17"] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L24P_T3U_N10_63
# set_property PACKAGE_PIN AT35     	[get_ports c0_ddr4_adr[16]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L23N_T3U_N9_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[16]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L23N_T3U_N9_63
# set_property PACKAGE_PIN AR35     	[get_ports c0_ddr4_adr[15]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L23P_T3U_N8_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[15]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L23P_T3U_N8_63
# set_property PACKAGE_PIN AR37     	[get_ports c0_ddr4_adr[14]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L21N_T3L_N5_AD8N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[14]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L21N_T3L_N5_AD8N_63
# set_property PACKAGE_PIN AR34     	[get_ports c0_ddr4_adr[13]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L24N_T3U_N11_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[13]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L24N_T3U_N11_63
# set_property PACKAGE_PIN BD37     	[get_ports c0_ddr4_adr[12]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L8N_T1L_N3_AD5N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[12]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L8N_T1L_N3_AD5N_63
# set_property PACKAGE_PIN BB36     	[get_ports c0_ddr4_adr[11]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L10P_T1U_N6_QBC_AD4P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[11]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L10P_T1U_N6_QBC_AD4P_63
# set_property PACKAGE_PIN AU36     	[get_ports c0_ddr4_adr[10]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L19P_T3L_N0_DBC_AD9P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[10]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L19P_T3L_N0_DBC_AD9P_63
# set_property PACKAGE_PIN AY37     	[get_ports c0_ddr4_adr[9]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_T1U_N12_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[9]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_T1U_N12_63
# set_property PACKAGE_PIN BA35     	[get_ports c0_ddr4_adr[8]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L11P_T1U_N8_GC_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[8]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L11P_T1U_N8_GC_63
# set_property PACKAGE_PIN BC36     	[get_ports c0_ddr4_adr[7]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L10N_T1U_N7_QBC_AD4N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[7]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L10N_T1U_N7_QBC_AD4N_63
# set_property PACKAGE_PIN BA34     	[get_ports c0_ddr4_adr[6]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L12P_T1U_N10_GC_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[6]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L12P_T1U_N10_GC_63
# set_property PACKAGE_PIN BB34     	[get_ports c0_ddr4_adr[5]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L12N_T1U_N11_GC_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[5]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L12N_T1U_N11_GC_63
# set_property PACKAGE_PIN AY36     	[get_ports c0_ddr4_adr[4]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L14N_T2L_N3_GC_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[4]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L14N_T2L_N3_GC_63
# set_property PACKAGE_PIN AY35     	[get_ports c0_ddr4_adr[3]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L14P_T2L_N2_GC_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[3]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L14P_T2L_N2_GC_63
# set_property PACKAGE_PIN AV37     	[get_ports c0_ddr4_adr[2]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L15N_T2L_N5_AD11N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[2]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L15N_T2L_N5_AD11N_63
# set_property PACKAGE_PIN AV36     	[get_ports c0_ddr4_adr[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L15P_T2L_N4_AD11P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L15P_T2L_N4_AD11P_63
# set_property PACKAGE_PIN AU34     	[get_ports c0_ddr4_adr[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L18P_T2U_N10_AD2P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_adr[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L18P_T2U_N10_AD2P_63


# set_property PACKAGE_PIN AU35     	[get_ports c0_ddr4_ba[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_T2U_N12_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_ba[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_T2U_N12_63
# set_property PACKAGE_PIN AU37     	[get_ports c0_ddr4_ba[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L19N_T3L_N1_DBC_AD9N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_ba[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L19N_T3L_N1_DBC_AD9N_63

# set_property PACKAGE_PIN BA37     	[get_ports c0_ddr4_bg[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L9P_T1L_N4_AD12P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_bg[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L9P_T1L_N4_AD12P_63
# set_property PACKAGE_PIN BD35     	[get_ports c0_ddr4_bg[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L7P_T1L_N0_QBC_AD13P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_bg[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L7P_T1L_N0_QBC_AD13P_63


# # set_property PACKAGE_PIN BB37       [get_ports c0_ddr4_cke[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L9N_T1L_N5_AD12N_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_cke[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L9N_T1L_N5_AD12N_63
# set_property PACKAGE_PIN BD36     	[get_ports c0_ddr4_cke[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L7N_T1L_N1_QBC_AD13N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_cke[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L7N_T1L_N1_QBC_AD13N_63


# # set_property PACKAGE_PIN AT34       [get_ports "c0_ddr4_odt1"] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L22N_T3U_N7_DBC_AD0N_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports "c0_ddr4_odt1"] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L22N_T3U_N7_DBC_AD0N_63
# set_property PACKAGE_PIN AR36     	[get_ports c0_ddr4_odt[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L21P_T3L_N4_AD8P_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_odt[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L21P_T3L_N4_AD8P_63


# # set_property PACKAGE_PIN AT33       [get_ports c0_ddr4_cs_n[3]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L22P_T3U_N6_DBC_AD0P_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_cs_n[3]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L22P_T3U_N6_DBC_AD0P_63
# # set_property PACKAGE_PIN AU32       [get_ports c0_ddr4_cs_n[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L20N_T3L_N3_AD1N_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_cs_n[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L20N_T3L_N3_AD1N_63
# # set_property PACKAGE_PIN AT32       [get_ports c0_ddr4_cs_n[2]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L20P_T3L_N2_AD1P_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_cs_n[2]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L20P_T3L_N2_AD1P_63
# set_property PACKAGE_PIN AT37     	[get_ports c0_ddr4_cs_n[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_T3U_N12_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_cs_n[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_T3U_N12_63



# # set_property PACKAGE_PIN AV32       [get_ports c0_ddr4_ck_t[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L16P_T2U_N6_QBC_AD3P_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_ck_t[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L16P_T2U_N6_QBC_AD3P_63
# set_property PACKAGE_PIN AW33     	[get_ports c0_ddr4_ck_t[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L17P_T2U_N8_AD10P_63
# set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports c0_ddr4_ck_t[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L17P_T2U_N8_AD10P_63


# # set_property PACKAGE_PIN AV33       [get_ports c0_ddr4_ck_c[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L16N_T2U_N7_QBC_AD3N_63
# # set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_ck_c[1]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L16N_T2U_N7_QBC_AD3N_63
# set_property PACKAGE_PIN AW34     	[get_ports c0_ddr4_ck_c[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L17N_T2U_N9_AD10N_63
# set_property IOSTANDARD  DIFF_SSTL12_DCI [get_ports c0_ddr4_ck_c[0]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L17N_T2U_N9_AD10N_63


# set_property PACKAGE_PIN BB30     	[get_ports c0_ddr4_reset_n] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_T2U_N12_62
# set_property IOSTANDARD  LVCMOS12 [get_ports c0_ddr4_reset_n] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_T2U_N12_62


# set_property PACKAGE_PIN AV34     	[get_ports c0_ddr4_parity] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L18N_T2U_N11_AD2N_63
# set_property IOSTANDARD  SSTL12_DCI [get_ports c0_ddr4_parity] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L18N_T2U_N11_AD2N_63



# set_property PACKAGE_PIN BF24     	[get_ports c0_ddr4_dq[71]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L9N_T1L_N5_AD12N_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[71]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L9N_T1L_N5_AD12N_61
# set_property PACKAGE_PIN BF25     	[get_ports c0_ddr4_dq[70]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L9P_T1L_N4_AD12P_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[70]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L9P_T1L_N4_AD12P_61
# set_property PACKAGE_PIN BF23     	[get_ports c0_ddr4_dq[69]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L8P_T1L_N2_AD5P_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[69]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L8P_T1L_N2_AD5P_61
# set_property PACKAGE_PIN BG22     	[get_ports c0_ddr4_dq[68]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L8N_T1L_N3_AD5N_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[68]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L8N_T1L_N3_AD5N_61
# set_property PACKAGE_PIN BE22     	[get_ports c0_ddr4_dq[67]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L11P_T1U_N8_GC_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[67]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L11P_T1U_N8_GC_61
# set_property PACKAGE_PIN BF22     	[get_ports c0_ddr4_dq[66]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L11N_T1U_N9_GC_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[66]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L11N_T1U_N9_GC_61
# set_property PACKAGE_PIN BD23     	[get_ports c0_ddr4_dq[65]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L12P_T1U_N10_GC_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[65]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L12P_T1U_N10_GC_61
# set_property PACKAGE_PIN BE23     	[get_ports c0_ddr4_dq[64]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L12N_T1U_N11_GC_61
# set_property IOSTANDARD  POD12_DCI [get_ports c0_ddr4_dq[64]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L12N_T1U_N11_GC_61
# set_property PACKAGE_PIN BL28     	[get_ports c0_ddr4_dq[63]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L2N_T0L_N3_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[63]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L2N_T0L_N3_62
# set_property PACKAGE_PIN BL27     	[get_ports c0_ddr4_dq[62]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L2P_T0L_N2_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[62]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L2P_T0L_N2_62
# set_property PACKAGE_PIN BJ30     	[get_ports c0_ddr4_dq[61]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L3N_T0L_N5_AD15N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[61]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L3N_T0L_N5_AD15N_62
# set_property PACKAGE_PIN BJ29     	[get_ports c0_ddr4_dq[60]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L3P_T0L_N4_AD15P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[60]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L3P_T0L_N4_AD15P_62
# set_property PACKAGE_PIN BK26     	[get_ports c0_ddr4_dq[59]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L6N_T0U_N11_AD6N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[59]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L6N_T0U_N11_AD6N_62
# set_property PACKAGE_PIN BL30     	[get_ports c0_ddr4_dq[58]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L5N_T0U_N9_AD14N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[58]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L5N_T0U_N9_AD14N_62
# set_property PACKAGE_PIN BK30     	[get_ports c0_ddr4_dq[57]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L5P_T0U_N8_AD14P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[57]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L5P_T0U_N8_AD14P_62
# set_property PACKAGE_PIN BJ26     	[get_ports c0_ddr4_dq[56]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L6P_T0U_N10_AD6P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[56]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L6P_T0U_N10_AD6P_62
# set_property PACKAGE_PIN AY32     	[get_ports c0_ddr4_dq[55]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L3P_T0L_N4_AD15P_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[55]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L3P_T0L_N4_AD15P_63
# set_property PACKAGE_PIN BB32     	[get_ports c0_ddr4_dq[54]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L2P_T0L_N2_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[54]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L2P_T0L_N2_63
# set_property PACKAGE_PIN BC32     	[get_ports c0_ddr4_dq[53]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L2N_T0L_N3_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[53]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L2N_T0L_N3_63
# set_property PACKAGE_PIN BA32     	[get_ports c0_ddr4_dq[52]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L3N_T0L_N5_AD15N_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[52]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L3N_T0L_N5_AD15N_63
# set_property PACKAGE_PIN BC34     	[get_ports c0_ddr4_dq[51]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L6P_T0U_N10_AD6P_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[51]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L6P_T0U_N10_AD6P_63
# set_property PACKAGE_PIN BC33     	[get_ports c0_ddr4_dq[50]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L5P_T0U_N8_AD14P_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[50]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L5P_T0U_N8_AD14P_63
# set_property PACKAGE_PIN BD33     	[get_ports c0_ddr4_dq[49]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L5N_T0U_N9_AD14N_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[49]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L5N_T0U_N9_AD14N_63
# set_property PACKAGE_PIN BD34     	[get_ports c0_ddr4_dq[48]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L6N_T0U_N11_AD6N_63
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[48]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L6N_T0U_N11_AD6N_63
# set_property PACKAGE_PIN BB25     	[get_ports c0_ddr4_dq[47]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L15N_T2L_N5_AD11N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[47]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L15N_T2L_N5_AD11N_61
# set_property PACKAGE_PIN BB26     	[get_ports c0_ddr4_dq[46]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L15P_T2L_N4_AD11P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[46]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L15P_T2L_N4_AD11P_61
# set_property PACKAGE_PIN BC24     	[get_ports c0_ddr4_dq[45]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L14P_T2L_N2_GC_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[45]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L14P_T2L_N2_GC_61
# set_property PACKAGE_PIN BC23     	[get_ports c0_ddr4_dq[44]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L14N_T2L_N3_GC_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[44]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L14N_T2L_N3_GC_61
# set_property PACKAGE_PIN BB22     	[get_ports c0_ddr4_dq[43]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L18P_T2U_N10_AD2P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[43]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L18P_T2U_N10_AD2P_61
# set_property PACKAGE_PIN BC22     	[get_ports c0_ddr4_dq[42]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L18N_T2U_N11_AD2N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[42]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L18N_T2U_N11_AD2N_61
# set_property PACKAGE_PIN BA25     	[get_ports c0_ddr4_dq[41]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L17P_T2U_N8_AD10P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[41]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L17P_T2U_N8_AD10P_61
# set_property PACKAGE_PIN BA24     	[get_ports c0_ddr4_dq[40]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L17N_T2U_N9_AD10N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[40]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L17N_T2U_N9_AD10N_61
# set_property PACKAGE_PIN BJ25     	[get_ports c0_ddr4_dq[39]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L3P_T0L_N4_AD15P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[39]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L3P_T0L_N4_AD15P_61
# set_property PACKAGE_PIN BJ24     	[get_ports c0_ddr4_dq[38]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L3N_T0L_N5_AD15N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[38]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L3N_T0L_N5_AD15N_61
# set_property PACKAGE_PIN BL22     	[get_ports c0_ddr4_dq[37]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L2N_T0L_N3_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[37]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L2N_T0L_N3_61
# set_property PACKAGE_PIN BK22     	[get_ports c0_ddr4_dq[36]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L2P_T0L_N2_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[36]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L2P_T0L_N2_61
# set_property PACKAGE_PIN BK25     	[get_ports c0_ddr4_dq[35]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L5P_T0U_N8_AD14P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[35]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L5P_T0U_N8_AD14P_61
# set_property PACKAGE_PIN BL25     	[get_ports c0_ddr4_dq[34]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L5N_T0U_N9_AD14N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[34]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L5N_T0U_N9_AD14N_61
# set_property PACKAGE_PIN BH23     	[get_ports c0_ddr4_dq[33]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L6N_T0U_N11_AD6N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[33]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L6N_T0U_N11_AD6N_61
# set_property PACKAGE_PIN BH24     	[get_ports c0_ddr4_dq[32]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L6P_T0U_N10_AD6P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[32]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L6P_T0U_N10_AD6P_61
# set_property PACKAGE_PIN AV24     	[get_ports c0_ddr4_dq[31]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L20P_T3L_N2_AD1P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[31]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L20P_T3L_N2_AD1P_61
# set_property PACKAGE_PIN AW23     	[get_ports c0_ddr4_dq[30]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L20N_T3L_N3_AD1N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[30]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L20N_T3L_N3_AD1N_61
# set_property PACKAGE_PIN BA23     	[get_ports c0_ddr4_dq[29]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L21N_T3L_N5_AD8N_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[29]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L21N_T3L_N5_AD8N_61
# set_property PACKAGE_PIN AY23     	[get_ports c0_ddr4_dq[28]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L21P_T3L_N4_AD8P_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[28]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L21P_T3L_N4_AD8P_61
# set_property PACKAGE_PIN AV26     	[get_ports c0_ddr4_dq[27]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L24N_T3U_N11_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[27]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L24N_T3U_N11_61
# set_property PACKAGE_PIN AV27     	[get_ports c0_ddr4_dq[26]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L24P_T3U_N10_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[26]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L24P_T3U_N10_61
# set_property PACKAGE_PIN AY26     	[get_ports c0_ddr4_dq[25]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L23N_T3U_N9_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[25]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L23N_T3U_N9_61
# set_property PACKAGE_PIN AW26     	[get_ports c0_ddr4_dq[24]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L23P_T3U_N8_61
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[24]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L23P_T3U_N8_61
# set_property PACKAGE_PIN AY28     	[get_ports c0_ddr4_dq[23]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L20N_T3L_N3_AD1N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[23]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L20N_T3L_N3_AD1N_62
# set_property PACKAGE_PIN AW28     	[get_ports c0_ddr4_dq[22]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L20P_T3L_N2_AD1P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[22]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L20P_T3L_N2_AD1P_62
# set_property PACKAGE_PIN BA30     	[get_ports c0_ddr4_dq[21]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L21N_T3L_N5_AD8N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[21]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L21N_T3L_N5_AD8N_62
# set_property PACKAGE_PIN AY30     	[get_ports c0_ddr4_dq[20]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L21P_T3L_N4_AD8P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[20]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L21P_T3L_N4_AD8P_62
# set_property PACKAGE_PIN AY31     	[get_ports c0_ddr4_dq[19]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L24N_T3U_N11_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[19]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L24N_T3U_N11_62
# set_property PACKAGE_PIN AW31     	[get_ports c0_ddr4_dq[18]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L24P_T3U_N10_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[18]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L24P_T3U_N10_62
# set_property PACKAGE_PIN AW29     	[get_ports c0_ddr4_dq[17]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L23N_T3U_N9_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[17]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L23N_T3U_N9_62
# set_property PACKAGE_PIN AV29     	[get_ports c0_ddr4_dq[16]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L23P_T3U_N8_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[16]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L23P_T3U_N8_62
# set_property PACKAGE_PIN BF29     	[get_ports c0_ddr4_dq[15]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L8P_T1L_N2_AD5P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[15]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L8P_T1L_N2_AD5P_62
# set_property PACKAGE_PIN BG30     	[get_ports c0_ddr4_dq[14]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L8N_T1L_N3_AD5N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[14]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L8N_T1L_N3_AD5N_62
# set_property PACKAGE_PIN BG29     	[get_ports c0_ddr4_dq[13]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L9P_T1L_N4_AD12P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[13]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L9P_T1L_N4_AD12P_62
# set_property PACKAGE_PIN BH29     	[get_ports c0_ddr4_dq[12]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L9N_T1L_N5_AD12N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[12]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L9N_T1L_N5_AD12N_62
# set_property PACKAGE_PIN BE26     	[get_ports c0_ddr4_dq[11]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L12P_T1U_N10_GC_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[11]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L12P_T1U_N10_GC_62
# set_property PACKAGE_PIN BE27     	[get_ports c0_ddr4_dq[10]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L12N_T1U_N11_GC_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[10]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L12N_T1U_N11_GC_62
# set_property PACKAGE_PIN BF28     	[get_ports c0_ddr4_dq[9]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L11N_T1U_N9_GC_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[9]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L11N_T1U_N9_GC_62
# set_property PACKAGE_PIN BF27     	[get_ports c0_ddr4_dq[8]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L11P_T1U_N8_GC_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[8]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L11P_T1U_N8_GC_62
# set_property PACKAGE_PIN BD30     	[get_ports c0_ddr4_dq[7]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L15P_T2L_N4_AD11P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[7]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L15P_T2L_N4_AD11P_62
# set_property PACKAGE_PIN BE30     	[get_ports c0_ddr4_dq[6]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L15N_T2L_N5_AD11N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[6]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L15N_T2L_N5_AD11N_62
# set_property PACKAGE_PIN BD28     	[get_ports c0_ddr4_dq[5]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L14P_T2L_N2_GC_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[5]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L14P_T2L_N2_GC_62
# set_property PACKAGE_PIN BE28     	[get_ports c0_ddr4_dq[4]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L14N_T2L_N3_GC_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[4]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L14N_T2L_N3_GC_62
# set_property PACKAGE_PIN BB31     	[get_ports c0_ddr4_dq[3]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L17P_T2U_N8_AD10P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[3]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L17P_T2U_N8_AD10P_62
# set_property PACKAGE_PIN BC31     	[get_ports c0_ddr4_dq[2]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L17N_T2U_N9_AD10N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[2]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L17N_T2U_N9_AD10N_62
# set_property PACKAGE_PIN BC29     	[get_ports c0_ddr4_dq[1]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L18N_T2U_N11_AD2N_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[1]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L18N_T2U_N11_AD2N_62
# set_property PACKAGE_PIN BB29     	[get_ports c0_ddr4_dq[0]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L18P_T2U_N10_AD2P_62
# set_property IOSTANDARD  POD12_DCI  [get_ports c0_ddr4_dq[0]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L18P_T2U_N10_AD2P_62


# set_property PACKAGE_PIN BG24     	[get_ports c0_ddr4_dqs_c[17]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L7N_T1L_N1_QBC_AD13N_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[17]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L7N_T1L_N1_QBC_AD13N_61
# set_property PACKAGE_PIN BE20     	[get_ports c0_ddr4_dqs_c[16]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L1N_T0L_N1_DBC_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[16]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L1N_T0L_N1_DBC_62
# set_property PACKAGE_PIN BJ28     	[get_ports c0_ddr4_dqs_c[15]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L1N_T0L_N1_DBC_63
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[15]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L1N_T0L_N1_DBC_63
# set_property PACKAGE_PIN BK28     	[get_ports c0_ddr4_dqs_c[14]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L13N_T2L_N1_GC_QBC_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[14]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L13N_T2L_N1_GC_QBC_61
# set_property PACKAGE_PIN BE32     	[get_ports c0_ddr4_dqs_c[13]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L1N_T0L_N1_DBC_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[13]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L1N_T0L_N1_DBC_61
# set_property PACKAGE_PIN BA33     	[get_ports c0_ddr4_dqs_c[12]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L19N_T3L_N1_DBC_AD9N_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[12]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L19N_T3L_N1_DBC_AD9N_61
# set_property PACKAGE_PIN BD24     	[get_ports c0_ddr4_dqs_c[11]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L19N_T3L_N1_DBC_AD9N_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[11]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L19N_T3L_N1_DBC_AD9N_62
# set_property PACKAGE_PIN BD26     	[get_ports c0_ddr4_dqs_c[10]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L7N_T1L_N1_QBC_AD13N_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[10]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L7N_T1L_N1_QBC_AD13N_62
# set_property PACKAGE_PIN BL23     	[get_ports c0_ddr4_dqs_c[9]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L13N_T2L_N1_GC_QBC_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[9]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L13N_T2L_N1_GC_QBC_62
# set_property PACKAGE_PIN BK23     	[get_ports c0_ddr4_dqs_c[8]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L10N_T1U_N7_QBC_AD4N_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[8]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L10N_T1U_N7_QBC_AD4N_61
# set_property PACKAGE_PIN AW24     	[get_ports c0_ddr4_dqs_c[7]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L4N_T0U_N7_DBC_AD7N_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[7]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L4N_T0U_N7_DBC_AD7N_62
# set_property PACKAGE_PIN BA27     	[get_ports c0_ddr4_dqs_c[6]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L4N_T0U_N7_DBC_AD7N_63
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[6]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L4N_T0U_N7_DBC_AD7N_63
# set_property PACKAGE_PIN BA29     	[get_ports c0_ddr4_dqs_c[5]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L16N_T2U_N7_QBC_AD3N_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[5]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L16N_T2U_N7_QBC_AD3N_61
# set_property PACKAGE_PIN AV31     	[get_ports c0_ddr4_dqs_c[4]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L4N_T0U_N7_DBC_AD7N_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[4]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L4N_T0U_N7_DBC_AD7N_61
# set_property PACKAGE_PIN BG27     	[get_ports c0_ddr4_dqs_c[3]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L22N_T3U_N7_DBC_AD0N_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[3]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L22N_T3U_N7_DBC_AD0N_61
# set_property PACKAGE_PIN BH27     	[get_ports c0_ddr4_dqs_c[2]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L22N_T3U_N7_DBC_AD0N_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[2]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L22N_T3U_N7_DBC_AD0N_62
# set_property PACKAGE_PIN BD29     	[get_ports c0_ddr4_dqs_c[1]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L10N_T1U_N7_QBC_AD4N_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[1]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L10N_T1U_N7_QBC_AD4N_62
# set_property PACKAGE_PIN BC27     	[get_ports c0_ddr4_dqs_c[0]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L16N_T2U_N7_QBC_AD3N_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_c[0]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L16N_T2U_N7_QBC_AD3N_62


# set_property PACKAGE_PIN BG25     	[get_ports c0_ddr4_dqs_t[17]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L7P_T1L_N0_QBC_AD13P_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[17]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L7P_T1L_N0_QBC_AD13P_61
# set_property PACKAGE_PIN BH28     	[get_ports c0_ddr4_dqs_t[16]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L1P_T0L_N0_DBC_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[16]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L1P_T0L_N0_DBC_62
# set_property PACKAGE_PIN BE31     	[get_ports c0_ddr4_dqs_t[15]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L1P_T0L_N0_DBC_63
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[15]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L1P_T0L_N0_DBC_63
# set_property PACKAGE_PIN BD25     	[get_ports c0_ddr4_dqs_t[14]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L13P_T2L_N0_GC_QBC_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[14]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L13P_T2L_N0_GC_QBC_61
# set_property PACKAGE_PIN BL24     	[get_ports c0_ddr4_dqs_t[13]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L1P_T0L_N0_DBC_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[13]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L1P_T0L_N0_DBC_61
# set_property PACKAGE_PIN AW25     	[get_ports c0_ddr4_dqs_t[12]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L19P_T3L_N0_DBC_AD9P_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[12]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L19P_T3L_N0_DBC_AD9P_61
# set_property PACKAGE_PIN BA28     	[get_ports c0_ddr4_dqs_t[11]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L19P_T3L_N0_DBC_AD9P_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[11]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L19P_T3L_N0_DBC_AD9P_62
# set_property PACKAGE_PIN BG26     	[get_ports c0_ddr4_dqs_t[10]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L7P_T1L_N0_QBC_AD13P_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[10]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L7P_T1L_N0_QBC_AD13P_62
# set_property PACKAGE_PIN BC28     	[get_ports c0_ddr4_dqs_t[9]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L13P_T2L_N0_GC_QBC_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[9]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L13P_T2L_N0_GC_QBC_62
# set_property PACKAGE_PIN BE21     	[get_ports c0_ddr4_dqs_t[8]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L10P_T1U_N6_QBC_AD4P_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[8]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L10P_T1U_N6_QBC_AD4P_61
# set_property PACKAGE_PIN BK27     	[get_ports c0_ddr4_dqs_t[7]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L4P_T0U_N6_DBC_AD7P_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[7]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L4P_T0U_N6_DBC_AD7P_62
# set_property PACKAGE_PIN AY33     	[get_ports c0_ddr4_dqs_t[6]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L4P_T0U_N6_DBC_AD7P_63
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[6]] ;# Bank  63 VCCO - DDR4_VDDQ_1V2 - IO_L4P_T0U_N6_DBC_AD7P_63
# set_property PACKAGE_PIN BC26     	[get_ports c0_ddr4_dqs_t[5]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L16P_T2U_N6_QBC_AD3P_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[5]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L16P_T2U_N6_QBC_AD3P_61
# set_property PACKAGE_PIN BJ23     	[get_ports c0_ddr4_dqs_t[4]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L4P_T0U_N6_DBC_AD7P_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[4]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L4P_T0U_N6_DBC_AD7P_61
# set_property PACKAGE_PIN AY27     	[get_ports c0_ddr4_dqs_t[3]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L22P_T3U_N6_DBC_AD0P_61
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[3]] ;# Bank  61 VCCO - DDR4_VDDQ_1V2 - IO_L22P_T3U_N6_DBC_AD0P_61
# set_property PACKAGE_PIN AU31     	[get_ports c0_ddr4_dqs_t[2]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L22P_T3U_N6_DBC_AD0P_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[2]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L22P_T3U_N6_DBC_AD0P_62
# set_property PACKAGE_PIN BH26     	[get_ports c0_ddr4_dqs_t[1]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L10P_T1U_N6_QBC_AD4P_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[1]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L10P_T1U_N6_QBC_AD4P_62
# set_property PACKAGE_PIN BB27     	[get_ports c0_ddr4_dqs_t[0]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L16P_T2U_N6_QBC_AD3P_62
# set_property IOSTANDARD  DIFF_POD12_DCI [get_ports c0_ddr4_dqs_t[0]] ;# Bank  62 VCCO - DDR4_VDDQ_1V2 - IO_L16P_T2U_N6_QBC_AD3P_62






