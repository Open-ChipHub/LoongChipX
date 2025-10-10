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

// &ModuleBeg; @22
module aq_fdsu_double_dp (
  // &Ports, @23
  input    wire          ex1_pipe_clk,
  input    wire          ex1_pipedown,
  input    wire          ex2_pipe_clk,
  input    wire          ex2_pipedown,
  input    wire          ex3_pipedown,
  input    wire          expnt_rst_clk,
  input    wire          fdsu_ex1_dz,
  input    wire  [12:0]  fdsu_ex1_expnt_adder_op0,
  input    wire          fdsu_ex1_nv,
  input    wire          fdsu_ex1_of_result_lfn,
  input    wire  [12:0]  fdsu_ex1_op0_id_expnt_neg,
  input    wire          fdsu_ex1_op0_norm,
  input    wire          fdsu_ex1_op1_norm,
  input    wire          fdsu_ex1_result_inf,
  input    wire          fdsu_ex1_result_lfn,
  input    wire          fdsu_ex1_result_qnan,
  input    wire          fdsu_ex1_result_sign,
  input    wire          fdsu_ex1_result_zero,
  input    wire          fdsu_ex1_save_op0,
  input    wire          fdsu_ex2_of,
  input    wire          fdsu_ex2_potnt_of,
  input    wire          fdsu_ex2_potnt_uf,
  input    wire          fdsu_ex2_result_inf,
  input    wire          fdsu_ex2_result_lfn,
  input    wire          fdsu_ex2_rslt_denorm,
  input    wire  [12:0]  fdsu_ex2_srt_expnt_rst,
  input    wire          fdsu_ex2_uf,
  input    wire  [12:0]  fdsu_ex3_expnt_adjust_result,
  input    wire          fdsu_ex3_rslt_denorm,
  input    wire  [12:0]  fdsu_op0_ff1_cnt,
  input    wire          fdsu_save_op0_neg_expnt,
  output   wire  [12:0]  fdsu_ex1_id_expnt_f,
  output   wire  [12:0]  fdsu_ex2_expnt_adder_op0,
  output   wire          fdsu_ex2_of_rm_lfn,
  output   wire          fdsu_ex2_op0_norm,
  output   wire          fdsu_ex2_op1_norm,
  output   wire  [12:0]  fdsu_ex3_expnt_rst,
  output   wire          fdsu_ex3_potnt_uf,
  output   wire          fdsu_ex3_result_inf,
  output   wire          fdsu_ex3_result_lfn,
  output   wire          fdsu_ex3_result_qnan,
  output   wire          fdsu_ex3_result_sign,
  output   wire          fdsu_ex3_result_zero,
  output   wire          fdsu_ex3_rslt_denorm_in,
  output   wire          fdsu_ex4_dz,
  output   wire  [12:0]  fdsu_ex4_expnt_rst,
  output   wire          fdsu_ex4_nv,
  output   wire          fdsu_ex4_of,
  output   wire          fdsu_ex4_of_rm_lfn,
  output   wire          fdsu_ex4_potnt_of,
  output   wire          fdsu_ex4_potnt_uf,
  output   wire          fdsu_ex4_result_inf,
  output   wire          fdsu_ex4_result_lfn,
  output   wire          fdsu_ex4_result_qnan,
  output   wire          fdsu_ex4_result_sign,
  output   wire          fdsu_ex4_result_zero,
  output   wire          fdsu_ex4_rslt_denorm,
  output   wire          fdsu_ex4_uf,
  output   wire  [12:0]  fdsu_op0_id_expnt
); 



// &Regs; @24
reg             fdsu_dz;                     
reg     [12:0]  fdsu_expnt_rst;              
reg             fdsu_nv;                     
reg             fdsu_of;                     
reg             fdsu_of_rm_lfn;              
reg             fdsu_op0_norm;               
reg             fdsu_op1_norm;               
reg             fdsu_potnt_of;               
reg             fdsu_potnt_uf;               
reg             fdsu_result_inf;             
reg             fdsu_result_lfn;             
reg             fdsu_result_qnan;            
reg             fdsu_result_sign;            
reg             fdsu_result_zero;            
reg             fdsu_uf;                     
reg             fdsu_yy_rslt_denorm;         

// &Wires; @25
wire            ex2_result_inf;              
wire            ex2_result_lfn;              


// In 906 FDSU, if one op0/1 is not norm, it will not enter EX2.
//assign fdsu_op0_norm = 1'b1;
//assign fdsu_op1_norm = 1'b1;
// //&Force("input", "ex1_op0_norm"); @30
// //&Force("input", "ex1_op1_norm"); @31

// double_expnt_rst is used to save:
//  1. op0 denormal expnt;
//  2. op0 expnt;
//  3. result expnt.
always @ (posedge expnt_rst_clk)
begin
  if (fdsu_ex1_save_op0)
    fdsu_expnt_rst[12:0] <= fdsu_op0_ff1_cnt[12:0];
  else if(fdsu_save_op0_neg_expnt)
    fdsu_expnt_rst[12:0] <= fdsu_ex1_op0_id_expnt_neg[12:0];
  else if (ex1_pipedown)
    fdsu_expnt_rst[12:0] <= fdsu_ex1_expnt_adder_op0[12:0];
  else if (ex2_pipedown)
    fdsu_expnt_rst[12:0] <= fdsu_ex2_srt_expnt_rst[12:0];
  else if (ex3_pipedown)
    fdsu_expnt_rst[12:0] <= fdsu_ex3_expnt_adjust_result[12:0];
  else
    fdsu_expnt_rst[12:0] <= fdsu_expnt_rst[12:0];
end

//assign fdsu_ex1_op0_id_expnt_neg[12:0] = ~fdsu_expnt_rst[12:0] + 13'b1;
assign fdsu_op0_id_expnt[12:0]         = fdsu_expnt_rst[12:0];
assign fdsu_ex1_id_expnt_f[12:0]       = fdsu_expnt_rst[12:0];
assign fdsu_ex3_expnt_rst[12:0]        = fdsu_expnt_rst[12:0];
assign fdsu_ex4_expnt_rst[12:0]        = fdsu_expnt_rst[12:0];
assign fdsu_ex2_expnt_adder_op0[12:0]  = fdsu_expnt_rst[12:0];


always @ (posedge expnt_rst_clk)
begin
  if (ex2_pipedown)
    fdsu_yy_rslt_denorm <= fdsu_ex2_rslt_denorm;
  else if (ex3_pipedown)
    fdsu_yy_rslt_denorm <= fdsu_ex3_rslt_denorm;
  else
    fdsu_yy_rslt_denorm <= fdsu_yy_rslt_denorm;
end
assign fdsu_ex3_rslt_denorm_in = fdsu_yy_rslt_denorm;
assign fdsu_ex4_rslt_denorm = fdsu_yy_rslt_denorm;

always @ (posedge expnt_rst_clk)
begin
  if (ex1_pipedown)
  begin
    fdsu_result_inf  <= fdsu_ex1_result_inf;
    fdsu_result_lfn  <= fdsu_ex1_result_lfn;
  end
  else if(ex2_pipedown)
  begin
    fdsu_result_inf <= ex2_result_inf;
    fdsu_result_lfn <= ex2_result_lfn;
  end
end
// EX2 signal used in EX3 & EX4
always @ (posedge ex2_pipe_clk)
begin
  if (ex2_pipedown)
  begin
    fdsu_of         <= fdsu_ex2_of;
    fdsu_uf         <= fdsu_ex2_uf;
    fdsu_potnt_of   <= fdsu_ex2_potnt_of;
    fdsu_potnt_uf   <= fdsu_ex2_potnt_uf;
  end
  else
  begin
    fdsu_of         <= fdsu_of;
    fdsu_uf         <= fdsu_uf;
    fdsu_potnt_of   <= fdsu_potnt_of;
    fdsu_potnt_uf   <= fdsu_potnt_uf;
  end
end
assign ex2_result_inf = fdsu_result_inf || fdsu_ex2_result_inf;
assign ex2_result_lfn = fdsu_result_lfn || fdsu_ex2_result_lfn;
assign fdsu_ex3_result_qnan = fdsu_result_qnan;
assign fdsu_ex3_result_zero = fdsu_result_zero;

always @(posedge ex1_pipe_clk)
begin
  if(ex1_pipedown)
  begin
    fdsu_result_qnan <= fdsu_ex1_result_qnan;
    fdsu_result_zero <= fdsu_ex1_result_zero;
    fdsu_result_sign    <= fdsu_ex1_result_sign;
    fdsu_op0_norm       <= fdsu_ex1_op0_norm;
    fdsu_op1_norm       <= fdsu_ex1_op1_norm;
    fdsu_of_rm_lfn      <= fdsu_ex1_of_result_lfn;
    fdsu_nv              <= fdsu_ex1_nv;
    fdsu_dz              <= fdsu_ex1_dz;
  end
end
assign fdsu_ex3_result_sign = fdsu_result_sign;
assign fdsu_ex4_result_sign = fdsu_result_sign;



assign fdsu_ex4_nv              = fdsu_nv;
assign fdsu_ex4_dz              = fdsu_dz;
assign fdsu_ex4_result_qnan = fdsu_result_qnan;
assign fdsu_ex4_result_zero = fdsu_result_zero;
assign fdsu_ex2_op0_norm   = fdsu_op0_norm;
assign fdsu_ex2_op1_norm   = fdsu_op1_norm;
assign fdsu_ex2_of_rm_lfn  = fdsu_of_rm_lfn;
assign fdsu_ex4_of_rm_lfn  = fdsu_of_rm_lfn;
assign fdsu_ex3_result_inf = fdsu_result_inf;
assign fdsu_ex3_result_lfn = fdsu_result_lfn;
assign fdsu_ex4_result_inf = fdsu_result_inf;
assign fdsu_ex4_result_lfn = fdsu_result_lfn;
assign fdsu_ex4_of         = fdsu_of;
assign fdsu_ex4_uf         = fdsu_uf;
assign fdsu_ex4_potnt_of   = fdsu_potnt_of;
assign fdsu_ex4_potnt_uf   = fdsu_potnt_uf;
assign fdsu_ex3_potnt_uf   = fdsu_potnt_uf;




// &ModuleEnd; @149
endmodule


