/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/
module ct_biu_lowpower (
  // &Ports, @24
  input    wire       bus_arb_w_fifo_clk_en,
  input    wire       coreclk,
  input    wire       cp0_biu_icg_en,
  input    wire       forever_coreclk,
  input    wire       pad_yy_icg_scan_en,
  input    wire       read_ar_clk_en,
  input    wire       read_busy,
  input    wire       read_r_clk_en,
  input    wire       round_w_clk_en,
  input    wire       snoop_ac_clk_en,
  input    wire       snoop_cd_clk_en,
  input    wire       snoop_cr_clk_en,
  input    wire       st_aw_clk_en,
  input    wire       st_w_clk_en,
  input    wire       vict_aw_clk_en,
  input    wire       vict_w_clk_en,
  input    wire       write_b_clk_en,
  input    wire       write_busy,
  output   wire       accpuclk,
  output   wire       arcpuclk,
  output   wire       bcpuclk,
  output   wire       biu_yy_xx_no_op,
  output   wire       bus_arb_w_fifo_clk,
  output   wire       cdcpuclk,
  output   wire       crcpuclk,
  output   wire       rcpuclk,
  output   wire       round_wcpuclk,
  output   wire       st_awcpuclk,
  output   wire       st_wcpuclk,
  output   wire       vict_awcpuclk,
  output   wire       vict_wcpuclk
); 



// &Regs; @25
// &Wires; @26


//==========================================================
// low power gated clock for read channel 
//==========================================================
// &Instance("gated_clk_cell","x_read_channel_ar_gated_cell"); @31
gated_clk_cell  x_read_channel_ar_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (arcpuclk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (read_ar_clk_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @32
//           .clk_out          (arcpuclk        ), @33
//           .external_en      (1'b0            ), @34
//           .global_en        (1'b1            ), @35
//           .local_en         (read_ar_clk_en  ), @36
//           .module_en        (cp0_biu_icg_en) @37
//         ); @38

// &Instance("gated_clk_cell","x_read_channel_r_gated_cell"); @40
gated_clk_cell  x_read_channel_r_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (rcpuclk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (read_r_clk_en     ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @41
//           .clk_out          (rcpuclk         ), @42
//           .external_en      (1'b0            ), @43
//           .global_en        (1'b1            ), @44
//           .local_en         (read_r_clk_en   ), @45
//           .module_en        (cp0_biu_icg_en) @46
//         ); @47
//==========================================================
// low power gated clock for write channel 
//==========================================================
// &Instance("gated_clk_cell","x_write_channel_vict_aw_gated_cell"); @51
gated_clk_cell  x_write_channel_vict_aw_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (vict_awcpuclk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vict_aw_clk_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @52
//           .clk_out          (vict_awcpuclk   ), @53
//           .external_en      (1'b0            ), @54
//           .global_en        (1'b1            ), @55
//           .local_en         (vict_aw_clk_en ), @56
//           .module_en        (cp0_biu_icg_en) @57
//         ); @58

// &Instance("gated_clk_cell","x_write_channel_st_aw_gated_cell"); @60
gated_clk_cell  x_write_channel_st_aw_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (st_awcpuclk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (st_aw_clk_en      ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @61
//           .clk_out          (st_awcpuclk     ), @62
//           .external_en      (1'b0            ), @63
//           .global_en        (1'b1            ), @64
//           .local_en         (st_aw_clk_en    ), @65
//           .module_en        (cp0_biu_icg_en) @66
//         ); @67

// &Instance("gated_clk_cell","x_write_channel_vict_w_gated_cell"); @69
gated_clk_cell  x_write_channel_vict_w_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (vict_wcpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vict_w_clk_en     ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @70
//           .clk_out          (vict_wcpuclk    ), @71
//           .external_en      (1'b0            ), @72
//           .global_en        (1'b1            ), @73
//           .local_en         (vict_w_clk_en   ), @74
//           .module_en        (cp0_biu_icg_en) @75
//         ); @76

// &Instance("gated_clk_cell","x_write_channel_st_w_gated_cell"); @78
gated_clk_cell  x_write_channel_st_w_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (st_wcpuclk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (st_w_clk_en       ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @79
//           .clk_out          (st_wcpuclk      ), @80
//           .external_en      (1'b0            ), @81
//           .global_en        (1'b1            ), @82
//           .local_en         (st_w_clk_en     ), @83
//           .module_en        (cp0_biu_icg_en) @84
//         ); @85

// &Instance("gated_clk_cell","x_write_channel_round_w_gated_cell"); @87
gated_clk_cell  x_write_channel_round_w_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (round_wcpuclk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (round_w_clk_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @88
//           .clk_out          (round_wcpuclk   ), @89
//           .external_en      (1'b0            ), @90
//           .global_en        (1'b1            ), @91
//           .local_en         (round_w_clk_en  ), @92
//           .module_en        (cp0_biu_icg_en) @93
//         ); @94

// &Instance("gated_clk_cell", "x_lsu_bus_arb_w_fifo_gated_clk"); @96
gated_clk_cell  x_lsu_bus_arb_w_fifo_gated_clk (
  .clk_in                (coreclk              ),
  .clk_out               (bus_arb_w_fifo_clk   ),
  .external_en           (1'b0                 ),
  .global_en             (1'b1                 ),
  .local_en              (bus_arb_w_fifo_clk_en),
  .module_en             (cp0_biu_icg_en       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

// &Connect(.clk_in        (coreclk            ), @97
//          .external_en   (1'b0               ), @98
//          .global_en     (1'b1               ), @99
//          .module_en     (cp0_biu_icg_en     ), @100
//          .local_en      (bus_arb_w_fifo_clk_en), @101
//          .clk_out       (bus_arb_w_fifo_clk )); @102

// &Instance("gated_clk_cell","x_write_channel_b_gated_cell"); @104
gated_clk_cell  x_write_channel_b_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (bcpuclk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (write_b_clk_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @105
//           .clk_out          (bcpuclk         ), @106
//           .external_en      (1'b0            ), @107
//           .global_en        (1'b1            ), @108
//           .local_en         (write_b_clk_en  ), @109
//           .module_en        (cp0_biu_icg_en) @110
//         ); @111
//==========================================================
// low power gated clock for snoop channel 
//==========================================================
// &Instance("gated_clk_cell","x_snoop_channel_ac_gated_cell"); @115
gated_clk_cell  x_snoop_channel_ac_gated_cell (
  .clk_in             (forever_coreclk   ),
  .clk_out            (accpuclk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (snoop_ac_clk_en   ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (forever_coreclk ), @116
//           .clk_out          (accpuclk        ), @117
//           .external_en      (1'b0            ), @118
//           .global_en        (1'b1            ), @119
//           .local_en         (snoop_ac_clk_en ), @120
//           .module_en        (cp0_biu_icg_en) @121
//         ); @122

// &Instance("gated_clk_cell","x_snoop_channel_cr_gated_cell"); @124
gated_clk_cell  x_snoop_channel_cr_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (crcpuclk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (snoop_cr_clk_en   ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @125
//           .clk_out          (crcpuclk        ), @126
//           .external_en      (1'b0            ), @127
//           .global_en        (1'b1            ), @128
//           .local_en         (snoop_cr_clk_en ), @129
//           .module_en        (cp0_biu_icg_en) @130
//         ); @131

// &Instance("gated_clk_cell","x_snoop_channel_cd_gated_cell"); @133
gated_clk_cell  x_snoop_channel_cd_gated_cell (
  .clk_in             (coreclk           ),
  .clk_out            (cdcpuclk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (snoop_cd_clk_en   ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (coreclk         ), @134
//           .clk_out          (cdcpuclk        ), @135
//           .external_en      (1'b0            ), @136
//           .global_en        (1'b1            ), @137
//           .local_en         (snoop_cd_clk_en ), @138
//           .module_en        (cp0_biu_icg_en) @139
//         ); @140

//for low power mode
assign biu_yy_xx_no_op = !read_busy && !write_busy;

// &ModuleEnd; @145
endmodule




