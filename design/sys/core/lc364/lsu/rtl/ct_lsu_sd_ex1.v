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

// &ModuleBeg; @25
module ct_lsu_sd_ex1 (
  // &Ports, @26
  input    wire           cp0_lsu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           ctrl_st_clk,
  input    wire           forever_cpuclk,
  input    wire           idu_lsu_rf_pipe5_gateclk_sel,
  input    wire  [11 :0]  idu_lsu_rf_pipe5_sdiq_entry,
  input    wire           idu_lsu_rf_pipe5_sel,
  input    wire  [63 :0]  idu_lsu_rf_pipe5_src0,
  input    wire  [63 :0]  idu_lsu_rf_pipe5_srcv0_fr,
  input    wire           idu_lsu_rf_pipe5_srcv0_fr_vld,
  input    wire           idu_lsu_rf_pipe5_srcv0_vld,
  input    wire  [63 :0]  idu_lsu_rf_pipe5_srcv0_vr0,
  input    wire  [63 :0]  idu_lsu_rf_pipe5_srcv0_vr1,
  input    wire           idu_lsu_rf_pipe5_stdata1_vld,
  input    wire           idu_lsu_rf_pipe5_unalign,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_yy_xx_flush,
  output   wire  [11 :0]  lsu_idu_ex1_sdiq_entry,
  output   wire           lsu_idu_ex1_sdiq_frz_clr,
  output   wire           lsu_idu_ex1_sdiq_pop_vld,
  output   wire  [63 :0]  sd_ex1_data,
  output   wire  [127:0]  sd_ex1_data_bypass,
  output   reg            sd_ex1_inst_vld,
  output   wire  [3  :0]  sd_rf_ex1_sdid,
  output   wire           sd_rf_inst_vld_short
); 



// &Regs; @27
reg              sd_ex1_boundary;              
reg     [11 :0]  sd_ex1_sdid_oh;               
reg              sd_ex1_secd;                  
reg     [63 :0]  sd_ex1_src0_data;             
reg     [63 :0]  sd_ex1_srcv0_fr_data;         
reg              sd_ex1_srcv0_fr_vld;          
reg              sd_ex1_srcv0_vld;             
reg     [63 :0]  sd_ex1_srcv0_vr0_data;        
reg     [63 :0]  sd_ex1_srcv0_vr1_data;        

// &Wires; @28
wire             sd_ex1_clk;                   
wire             sd_ex1_clk_en;                
wire    [63 :0]  sd_ex1_data_64;               
wire             sd_ex1_data_clk;              
wire             sd_ex1_data_clk_en;           
wire             sd_ex1_vdata_clk;             
wire             sd_ex1_vdata_clk_en;          
wire             sd_rf_ex1_inst_vld;           


parameter LSIQ_ENTRY  = 12;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign sd_ex1_clk_en = idu_lsu_rf_pipe5_gateclk_sel;
// &Instance("gated_clk_cell", "x_lsu_sd_ex1_gated_clk"); @36
gated_clk_cell  x_lsu_sd_ex1_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (sd_ex1_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (sd_ex1_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @37
//          .external_en   (1'b0               ), @38
//          .global_en     (cp0_yy_clk_en      ), @39
//          .module_en     (cp0_lsu_icg_en     ), @40
//          .local_en      (sd_ex1_clk_en      ), @41
//          .clk_out       (sd_ex1_clk         )); @42

assign sd_ex1_data_clk_en = idu_lsu_rf_pipe5_gateclk_sel 
                            && !idu_lsu_rf_pipe5_srcv0_vld;
// &Instance("gated_clk_cell", "x_lsu_sd_ex1_data_gated_clk"); @46
gated_clk_cell  x_lsu_sd_ex1_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (sd_ex1_data_clk   ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (sd_ex1_data_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @47
//          .external_en   (1'b0               ), @48
//          .global_en     (cp0_yy_clk_en      ), @49
//          .module_en     (cp0_lsu_icg_en     ), @50
//          .local_en      (sd_ex1_data_clk_en      ), @51
//          .clk_out       (sd_ex1_data_clk         )); @52

assign sd_ex1_vdata_clk_en = idu_lsu_rf_pipe5_gateclk_sel
                             && idu_lsu_rf_pipe5_srcv0_vld;
// &Instance("gated_clk_cell", "x_lsu_sd_ex1_vdata_gated_clk"); @56
gated_clk_cell  x_lsu_sd_ex1_vdata_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (sd_ex1_vdata_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (sd_ex1_vdata_clk_en),
  .module_en           (cp0_lsu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in        (forever_cpuclk     ), @57
//          .external_en   (1'b0               ), @58
//          .global_en     (cp0_yy_clk_en      ), @59
//          .module_en     (cp0_lsu_icg_en     ), @60
//          .local_en      (sd_ex1_vdata_clk_en      ), @61
//          .clk_out       (sd_ex1_vdata_clk         )); @62
//==========================================================
//                      encode sdid
//==========================================================
assign sd_rf_ex1_sdid[3:0]  = {4{idu_lsu_rf_pipe5_sdiq_entry[0]}} & 4'd0
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[1]}} & 4'd1
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[2]}} & 4'd2
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[3]}} & 4'd3
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[4]}} & 4'd4
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[5]}} & 4'd5
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[6]}} & 4'd6
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[7]}} & 4'd7
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[8]}} & 4'd8
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[9]}} & 4'd9
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[10]}} & 4'd10
                              | {4{idu_lsu_rf_pipe5_sdiq_entry[11]}} & 4'd11;


//==========================================================
//                 Pipeline Register
//==========================================================
//------------------control part----------------------------
//+----------+
//| inst_vld |
//+----------+
assign sd_rf_inst_vld_short = idu_lsu_rf_pipe5_gateclk_sel;
assign sd_rf_ex1_inst_vld = idu_lsu_rf_pipe5_sel  &&  !rtu_yy_xx_flush;
// &Force("output","sd_ex1_inst_vld"); @89
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    sd_ex1_inst_vld  <=  1'b0;
  else
    sd_ex1_inst_vld  <=  sd_rf_ex1_inst_vld;
end

//+------+------+----------+------+
//| sdid | secd | boundary | data |
//+------+------+----------+------+
always @(posedge sd_ex1_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    sd_ex1_sdid_oh[LSIQ_ENTRY-1:0]  <=  {LSIQ_ENTRY{1'b0}};
    sd_ex1_secd                     <=  1'b0;
    sd_ex1_boundary                 <=  1'b0;
    sd_ex1_srcv0_vld                <=  1'b0;
    sd_ex1_srcv0_fr_vld             <=  1'b0;
  end
  else if (sd_ex1_clk_en)
  begin
    sd_ex1_sdid_oh[LSIQ_ENTRY-1:0]  <=  idu_lsu_rf_pipe5_sdiq_entry[LSIQ_ENTRY-1:0];
    sd_ex1_secd                     <=  idu_lsu_rf_pipe5_stdata1_vld;
    sd_ex1_boundary                 <=  idu_lsu_rf_pipe5_unalign;
    sd_ex1_srcv0_vld                <=  idu_lsu_rf_pipe5_srcv0_vld;
    sd_ex1_srcv0_fr_vld             <=  idu_lsu_rf_pipe5_srcv0_fr_vld;
  end
end

always @(posedge sd_ex1_data_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  sd_ex1_src0_data[63:0]            <=  64'b0;
  else if (sd_ex1_data_clk_en)
  sd_ex1_src0_data[63:0]            <=  idu_lsu_rf_pipe5_src0[63:0];
end

always @(posedge sd_ex1_vdata_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    sd_ex1_srcv0_vr1_data[63:0]     <=  64'b0;
    sd_ex1_srcv0_vr0_data[63:0]     <=  64'b0;
    sd_ex1_srcv0_fr_data[63:0]      <=  64'b0;
  end
  else if (sd_ex1_vdata_clk_en)
  begin
    sd_ex1_srcv0_vr1_data[63:0]     <=  idu_lsu_rf_pipe5_srcv0_vr1[63:0];
    sd_ex1_srcv0_vr0_data[63:0]     <=  idu_lsu_rf_pipe5_srcv0_vr0[63:0];
    sd_ex1_srcv0_fr_data[63:0]      <=  idu_lsu_rf_pipe5_srcv0_fr[63:0];
  end
end
//==========================================================
//        data select
//==========================================================
assign sd_ex1_data_64[63:0]  = sd_ex1_srcv0_vld  
                               ? (sd_ex1_srcv0_fr_vld
                                  ? sd_ex1_srcv0_fr_data[63:0]
                                  : sd_ex1_srcv0_vr0_data[63:0])
                               : sd_ex1_src0_data[63:0];

//sd_ex1_data used for sq data rot,sd_ex1_data_bypass used for ld_da data bypass 
// &Force("nonport","sd_ex1_srcv0_vr1_data"); @158
assign sd_ex1_data[63:0]         = sd_ex1_data_64[63:0];
assign sd_ex1_data_bypass[127:0] = {64'b0,sd_ex1_data_64[63:0]};
//==========================================================
//        Generage interface to idu
//==========================================================
assign lsu_idu_ex1_sdiq_pop_vld   = sd_ex1_inst_vld
                                    &&  (!sd_ex1_boundary  ||  sd_ex1_secd);
assign lsu_idu_ex1_sdiq_frz_clr   = sd_ex1_inst_vld
                                    &&  sd_ex1_boundary
                                    &&  !sd_ex1_secd;
assign lsu_idu_ex1_sdiq_entry[LSIQ_ENTRY-1:0] = sd_ex1_sdid_oh[LSIQ_ENTRY-1:0];

// &ModuleEnd; @172
endmodule


