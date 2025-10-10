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

// &ModuleBeg; @26
module aq_fadd_double_dp (
  // &Ports @27
  input    wire          double_pipe_ex1_src0_cnan,
  input    wire          double_pipe_ex1_src0_inf,
  input    wire          double_pipe_ex1_src0_qnan,
  input    wire          double_pipe_ex1_src0_snan,
  input    wire          double_pipe_ex1_src0_zero,
  input    wire          double_pipe_ex1_src1_cnan,
  input    wire          double_pipe_ex1_src1_inf,
  input    wire          double_pipe_ex1_src1_qnan,
  input    wire          double_pipe_ex1_src1_snan,
  input    wire          double_pipe_ex1_src1_zero,
  input    wire          ex2_act_s,
  input    wire          ex2_bhalf,
  input    wire  [8 :0]  ex2_bhalf0_addsub_rslt,
  input    wire  [6 :0]  ex2_bhalf0_sel_final_f,
  input    wire  [15:0]  ex2_bhalf0_special_data,
  input    wire          ex2_double,
  input    wire  [53:0]  ex2_double_addsub_rslt,
  input    wire  [51:0]  ex2_double_sel_final_f,
  input    wire  [63:0]  ex2_double_special_data,
  input    wire  [10:0]  ex2_e_add_rslt,
  input    wire          ex2_half,
  input    wire  [11:0]  ex2_half0_addsub_rslt,
  input    wire  [9 :0]  ex2_half0_sel_final_f,
  input    wire  [15:0]  ex2_half0_special_data,
  input    wire          ex2_nv,
  input    wire          ex2_op_cmp,
  input    wire          ex2_op_sel,
  input    wire  [10:0]  ex2_sel_final_e,
  input    wire          ex2_sel_final_sign,
  input    wire          ex2_single,
  input    wire  [24:0]  ex2_single0_addsub_rslt,
  input    wire  [22:0]  ex2_single0_sel_final_f,
  input    wire  [31:0]  ex2_single0_special_data,
  input    wire          ex2_special_value_vld,
  input    wire          fadd_ex1_pipe_clk,
  input    wire          fadd_ex1_pipedown,
  input    wire          fadd_ex2_nocmp_pipe_clk,
  input    wire          fadd_ex2_nocmp_pipedown,
  input    wire          fadd_ex2_pipe_clk,
  input    wire          fadd_ex2_pipedown,
  output   wire          ex1_src0_0,
  output   wire          ex1_src1_0,
  output   wire  [8 :0]  ex2_bhalf0_rslt,
  output   wire  [53:0]  ex2_double_rslt,
  output   wire  [11:0]  ex2_half0_rslt,
  output   wire          ex2_nocmp_nosel,
  output   wire  [24:0]  ex2_single0_rslt,
  output   reg           ex2_src0_0,
  output   reg           ex2_src0_cnan,
  output   reg           ex2_src0_inf,
  output   reg           ex2_src0_qnan,
  output   reg           ex2_src0_snan,
  output   reg           ex2_src1_0,
  output   reg           ex2_src1_cnan,
  output   reg           ex2_src1_inf,
  output   reg           ex2_src1_qnan,
  output   reg           ex2_src1_snan,
  output   reg           ex3_act_s,
  output   reg           ex3_expt_mask,
  output   reg           ex3_nv,
  output   reg   [10:0]  ex3_org_e,
  output   reg           ex3_special_n_op_sel
); 



// &Regs; @28

// &Wires; @29
wire            ex1_src0_cnan;            
wire            ex1_src0_inf;             
wire            ex1_src0_qnan;            
wire            ex1_src0_snan;            
wire            ex1_src1_cnan;            
wire            ex1_src1_inf;             
wire            ex1_src1_qnan;            
wire            ex1_src1_snan;            
wire            ex2_act_sign;             
wire            ex2_nv_final;             
wire    [10:0]  ex2_org_e;                
wire            ex2_r_expt_mask;          
wire    [10:0]  ex2_special_e;            
wire            ex2_special_n_op_sel;     
wire            ex2_special_sign;         


//assign ex1_act_sub = (ex1_op_add) &&
//                     (sa ^ sb) ||
//                     (ex1_op_sub  || ex1_op_cmp  || ex1_cmp_sel) &&
//                     (sa ^~ sb);
//assign ex1_act_s   = (ex1_es && ex1_cmp_sub)
//                   ? ~ex1_e_big_s
//                   : ex1_e_big_s;
//assign ex1_cmp_sub = ex1_op_sub || ex1_op_cmp || ex1_cmp_sel;
//assign ex1_cmp_sel = ex1_op_sel;


assign ex1_src0_cnan = double_pipe_ex1_src0_cnan;
assign ex1_src1_cnan = double_pipe_ex1_src1_cnan;
assign ex1_src0_snan = double_pipe_ex1_src0_snan;
assign ex1_src1_snan = double_pipe_ex1_src1_snan;
assign ex1_src0_qnan = double_pipe_ex1_src0_qnan;
assign ex1_src1_qnan = double_pipe_ex1_src1_qnan;
assign ex1_src0_inf  = double_pipe_ex1_src0_inf; 
assign ex1_src1_inf  = double_pipe_ex1_src1_inf; 
assign ex1_src0_0    = double_pipe_ex1_src0_zero;
assign ex1_src1_0    = double_pipe_ex1_src1_zero;

// &Force("output","ex1_src0_0"); @53
// &Force("output","ex1_src1_0"); @54
//==============================================================================
//                     EX1 pipedown to EX2
//==============================================================================
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown) begin
    ex2_src0_qnan         <= ex1_src0_qnan;
    ex2_src0_snan         <= ex1_src0_snan;
    ex2_src1_qnan         <= ex1_src1_qnan;
    ex2_src1_snan         <= ex1_src1_snan;
    ex2_src0_cnan         <= ex1_src0_cnan;
    ex2_src1_cnan         <= ex1_src1_cnan;
    ex2_src0_inf          <= ex1_src0_inf; 
    ex2_src1_inf          <= ex1_src1_inf; 
    ex2_src0_0            <= ex1_src0_0;   
    ex2_src1_0            <= ex1_src1_0;   
  end
end

//====================================
// compare and max/min source 0 and 1
//
//====================================

//===================================
// combine all of the result together
// the special result
// the maxmin result 
// the unorder sel result and so on
//===================================


// &Force("bus","ex2_unorder_result_f",63,0);                                                  @87
// &Force("bus","double_pipe_ex2_srcv2",63,0);                                                  @88
// &Force("bus","double_pipe_ex2_special_result",63,0); @89
                                                 
assign ex2_double_rslt[53:0]        = ex2_special_value_vld ? {2'b0,ex2_double_special_data[51:0]}   :
                                      ex2_op_sel ? {2'b0, ex2_double_sel_final_f[51:0]} 
                                                 : ex2_double_addsub_rslt[53:0];
assign ex2_single0_rslt[24:0]       = ex2_special_value_vld ? {2'b0,ex2_single0_special_data[22:0]}   :
                                      ex2_op_sel ? {2'b0, ex2_single0_sel_final_f[22:0]} 
                                                  : ex2_single0_addsub_rslt[24:0];
assign ex2_half0_rslt[11:0]         = ex2_special_value_vld ? {2'b0,ex2_half0_special_data[9:0]}    :
                                      ex2_op_sel ? {2'b0, ex2_half0_sel_final_f[9:0]} 
                                                  : ex2_half0_addsub_rslt[11:0];
assign ex2_bhalf0_rslt[8:0]         = ex2_special_value_vld ? {2'b0,ex2_bhalf0_special_data[6:0]}   :
                                      ex2_op_sel ? {2'b0, ex2_bhalf0_sel_final_f[6:0]} 
                                                  : ex2_bhalf0_addsub_rslt[8:0];

//=======================
// the expnt and sign
// combine together
//=======================
assign ex2_special_sign    = ex2_double && ex2_double_special_data[63]  || 
                             ex2_single && ex2_single0_special_data[31] ||
                             ex2_half   && ex2_half0_special_data[15]   ||
                             ex2_bhalf  && ex2_bhalf0_special_data[15];
assign ex2_special_e[10:0] = {11{ex2_double}} & ex2_double_special_data[62:52]         | 
                             {11{ex2_single}} & {3'b0,ex2_single0_special_data[30:23]} |
                             {11{ex2_half  }} & {6'b0,ex2_half0_special_data[14:10]}   |
                             {11{ex2_bhalf }} & {3'b0,ex2_bhalf0_special_data[14:7]};                                        
assign ex2_org_e[10:0]     = ex2_special_value_vld      ? ex2_special_e[10:0] :
                             ex2_op_sel                 ? ex2_sel_final_e[10:0] : ex2_e_add_rslt[10:0];
//assign ex2_e_adjust[5:0]   = ex2_e_adjust_pre[5:0];
assign ex2_act_sign        = ex2_special_value_vld      ? ex2_special_sign :
                             ex2_op_sel                 ? ex2_sel_final_sign : ex2_act_s;


assign ex2_nocmp_nosel     = !ex2_op_cmp && !ex2_op_sel;
//==============================================================================
//                          EX2 pipedown to EX3:
//==============================================================================
assign ex2_special_n_op_sel = ex2_op_sel || ex2_special_value_vld; 
assign ex2_r_expt_mask      = 1'b0;
assign ex2_nv_final         = ex2_nv;
always @(posedge fadd_ex2_pipe_clk)
begin
  if(fadd_ex2_pipedown) begin
    ex3_special_n_op_sel  <= ex2_special_n_op_sel;
    ex3_nv                <= ex2_nv_final;
    ex3_expt_mask         <= ex2_r_expt_mask;
  end
end

always @(posedge fadd_ex2_nocmp_pipe_clk)
begin
  if(fadd_ex2_nocmp_pipedown) begin
//    ex3_data[56:0]   <= ex2_final_rst[56:0];
    ex3_org_e[10:0]  <= ex2_org_e[10:0];
    ex3_act_s        <= ex2_act_sign;

  end
end
// &ModuleEnd; @190
endmodule


