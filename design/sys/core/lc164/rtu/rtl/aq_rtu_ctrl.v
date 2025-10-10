/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

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
module aq_rtu_ctrl (
  // &Ports, @24
  input    wire       cp0_rtu_ex1_cmplt,
  input    wire       cp0_rtu_icg_en,
  input    wire       cp0_yy_clk_en,
  input    wire       cpurst_b,
  input    wire       dp_ctrl_ex1_cmplt_dp,
  input    wire       forever_cpuclk,
  input    wire       ifu_rtu_warm_up,
  input    wire       iu_rtu_ex1_alu_cmplt,
  input    wire       iu_rtu_ex1_bju_cmplt,
  input    wire       iu_rtu_ex1_div_cmplt,
  input    wire       iu_rtu_ex1_mul_cmplt,
  input    wire       lsu_rtu_ex1_cmplt,
  input    wire       lsu_rtu_ex1_cmplt_for_pcgen,
  input    wire       pad_yy_icg_scan_en,
  input    wire       retire_ctrl_commit_clear,
  input    wire       retire_ctrl_commit_clear_for_bju,
  input    wire       vpu_rtu_ex1_cmplt,
  output   reg        async_select_next_pc,
  output   wire       ctrl_dp_ex1_cmplt_dp,
  output   wire       ctrl_retire_ex2_retire_vld,
  output   wire       ctrl_top_dbg_info,
  output   wire       dp_misc_clk,
  output   wire       rtu_idu_commit,
  output   wire       rtu_idu_commit_for_bju,
  output   wire       rtu_iu_ex1_cmplt,
  output   wire       rtu_iu_ex1_cmplt_dp
); 



// &Regs; @25
reg          ctrl_ex2_cmplt;                  

// &Wires; @26
wire         cmplt_clk;                       
wire         cmplt_clk_en;                    
wire         ctrl_ex1_alu_cmplt;              
wire         ctrl_ex1_bju_cmplt;              
wire         ctrl_ex1_cmplt;                  
wire         ctrl_ex1_cmplt_dp;               
wire         ctrl_ex1_cmplt_for_pcgen;        
wire         ctrl_ex1_commit;                 
wire         ctrl_ex1_commit_for_bju;         
wire         ctrl_ex1_cp0_cmplt;              
wire         ctrl_ex1_div_cmplt;              
wire         ctrl_ex1_lsu_cmplt;              
wire         ctrl_ex1_lsu_cmplt_for_pcgen;    
wire         ctrl_ex1_mul_cmplt;              
wire         ctrl_ex1_vec_cmplt;              
wire         ctrl_ex2_retire_vld;             


//==========================================================
//                      EX1 Complete BUS
//==========================================================
// EX1 cmplt signal includes:
//   * ALU
//   * MUL
//   * DIV
//   * LSU
//   * VEC

assign ctrl_ex1_alu_cmplt = iu_rtu_ex1_alu_cmplt;
assign ctrl_ex1_mul_cmplt = iu_rtu_ex1_mul_cmplt;
assign ctrl_ex1_bju_cmplt = iu_rtu_ex1_bju_cmplt;
assign ctrl_ex1_div_cmplt = iu_rtu_ex1_div_cmplt;
assign ctrl_ex1_lsu_cmplt = lsu_rtu_ex1_cmplt;
assign ctrl_ex1_vec_cmplt = vpu_rtu_ex1_cmplt;
assign ctrl_ex1_cp0_cmplt = cp0_rtu_ex1_cmplt;

// lsu_cmplt_for_pcgen is only for pcgen to opt timing.
assign ctrl_ex1_lsu_cmplt_for_pcgen = lsu_rtu_ex1_cmplt_for_pcgen;

assign ctrl_ex1_cmplt = ctrl_ex1_alu_cmplt
                     || ctrl_ex1_mul_cmplt
                     || ctrl_ex1_bju_cmplt
                     || ctrl_ex1_div_cmplt
                     || ctrl_ex1_lsu_cmplt
                     || ctrl_ex1_vec_cmplt
                     || ctrl_ex1_cp0_cmplt;
assign ctrl_ex1_cmplt_dp = dp_ctrl_ex1_cmplt_dp;

assign ctrl_ex1_cmplt_for_pcgen = ctrl_ex1_alu_cmplt
                               || ctrl_ex1_mul_cmplt
                               || ctrl_ex1_bju_cmplt
                               || ctrl_ex1_div_cmplt
                               || ctrl_ex1_lsu_cmplt_for_pcgen
                               || ctrl_ex1_vec_cmplt
                               || ctrl_ex1_cp0_cmplt;

//==========================================================
//                    EX1 Commit Signal
//==========================================================
// EX1 commit will be clear:
//   * ex2_inst_expt
//   * ex2_inst_int
//   * ex2_inst_dbg
//   * ex2_inst_flush

assign ctrl_ex1_commit = !retire_ctrl_commit_clear;
assign ctrl_ex1_commit_for_bju = !retire_ctrl_commit_clear_for_bju;

//==========================================================
//                        Retire Vld
//==========================================================
always @ (posedge cmplt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ctrl_ex2_cmplt <= 1'b0;
  else
    ctrl_ex2_cmplt <= ctrl_ex1_cmplt;
end

assign ctrl_ex2_retire_vld = ctrl_ex2_cmplt;

always @ (posedge cmplt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    async_select_next_pc <= 1'b0;
  else if(ctrl_ex1_cmplt)
    async_select_next_pc <= 1'b1;
  else if(ctrl_ex1_cmplt_dp)
    async_select_next_pc <= 1'b0;
end

//==========================================================
//                           ICG
//==========================================================
assign cmplt_clk_en = ctrl_ex1_cmplt_dp
                   || ctrl_ex2_cmplt
                   || ifu_rtu_warm_up;
// &Instance("gated_clk_cell", "x_cmplt_clk"); @107
gated_clk_cell  x_cmplt_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (cmplt_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (cmplt_clk_en      ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @108
//          .external_en (1'b0), @109
//          .global_en   (cp0_yy_clk_en), @110
//          .module_en   (cp0_rtu_icg_en), @111
//          .local_en    (cmplt_clk_en), @112
//          .clk_out     (cmplt_clk)); @113

assign dp_misc_clk = cmplt_clk;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign ctrl_dp_ex1_cmplt_dp       = ctrl_ex1_cmplt_dp;
assign ctrl_retire_ex2_retire_vld = ctrl_ex2_retire_vld;

assign ctrl_top_dbg_info = {ctrl_ex1_commit};

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign rtu_idu_commit = ctrl_ex1_commit;
assign rtu_idu_commit_for_bju = ctrl_ex1_commit_for_bju;

//----------------------------------------------------------
//                          For IU
//----------------------------------------------------------
assign rtu_iu_ex1_cmplt = ctrl_ex1_cmplt_for_pcgen;
assign rtu_iu_ex1_cmplt_dp = ctrl_ex1_cmplt_dp;


// &ModuleEnd; @164
endmodule



