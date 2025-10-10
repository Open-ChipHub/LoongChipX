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
module aq_fadd_double_cmp_max (
  // &Ports, @27
  input    wire          add_cmp_act_s,
  input    wire          add_cmp_both_zero,
  input    wire          add_cmp_ex2_src0_eq_src1,
  input    wire  [10:0]  dp_maxmin_src_a_e,
  input    wire  [51:0]  dp_maxmin_src_a_f,
  input    wire          dp_maxmin_src_a_s,
  input    wire  [10:0]  dp_maxmin_src_b_e,
  input    wire  [52:0]  dp_maxmin_src_b_f,
  input    wire          dp_maxmin_src_b_s,
  input    wire          dp_maxmin_src_chg,
  input    wire          ex2_src0_snan,
  input    wire          ex2_src0_qnan,
  input    wire          ex2_src1_snan,
  input    wire          ex2_src1_qnan,
  input    wire          ex2_op_feq,
  input    wire          ex2_op_fle,
  input    wire          ex2_op_flt,
  input    wire          ex2_op_fne,
  input    wire          ex2_op_faf,
  input    wire          ex2_op_fueq,
  input    wire          ex2_op_fult,
  input    wire          ex2_op_fule,
  input    wire          ex2_op_fune,
  input    wire          ex2_op_fuord, // UN
  input    wire          ex2_op_ford, // OR
  input    wire          ex2_signal,
  input    wire          ex2_op_max,
  input    wire          ex2_op_sela,
  output   wire          double_pipe_ex2_cmp_r,
  output   wire  [6 :0]  ex2_bhalf0_sel_final_f,
  output   wire  [51:0]  ex2_double_sel_final_f,
  output   wire  [9 :0]  ex2_half0_sel_final_f,
  output   wire  [10:0]  ex2_sel_final_e,
  output   wire          ex2_sel_final_sign,
  output   wire  [22:0]  ex2_single0_sel_final_f
); 



// &Regs; @28
// &Wires; @29
wire            ex2_act_s;                
wire    [6 :0]  ex2_bhalf0_sel_rst_max_f; 
wire    [6 :0]  ex2_bhalf0_sel_rst_min_f; 
wire    [6 :0]  ex2_bhalf0_src0_f;        
wire    [6 :0]  ex2_bhalf0_src1_f;        
wire            ex2_both_zero;            
wire            ex2_cmp_feq;              
wire            ex2_cmp_fle;              
wire            ex2_cmp_flt;              
wire            ex2_cmp_fne;              
wire            ex2_cmp_r;                
wire    [51:0]  ex2_double_sel_rst_max_f; 
wire    [51:0]  ex2_double_sel_rst_min_f; 
wire    [51:0]  ex2_double_src0_f;        
wire    [51:0]  ex2_double_src1_f;        
wire    [9 :0]  ex2_half0_sel_rst_max_f;  
wire    [9 :0]  ex2_half0_sel_rst_min_f;  
wire    [9 :0]  ex2_half0_src0_f;         
wire    [9 :0]  ex2_half0_src1_f;         
wire            ex2_s_equal;              
wire            ex2_sel_rst_both0_sign;   
wire    [10:0]  ex2_sel_rst_max_e;        
wire            ex2_sel_rst_max_s;        
wire    [10:0]  ex2_sel_rst_min_e;        
wire            ex2_sel_rst_min_s;        
wire    [22:0]  ex2_single0_sel_rst_max_f; 
wire    [22:0]  ex2_single0_sel_rst_min_f; 
wire    [22:0]  ex2_single0_src0_f;       
wire    [22:0]  ex2_single0_src1_f;       
wire    [10:0]  ex2_src0_e;               
wire    [51:0]  ex2_src0_f;               
wire            ex2_src0_s;               
wire    [10:0]  ex2_src1_e;               
wire            ex2_src1_s;               
wire    [52:0]  ex2_src1_sel;             
wire            ex2_src_chg;       
wire            ex2_cmp_fun;
wire            ex2_cmp_fueq;
wire            ex2_cmp_fune;
wire            ex2_cmp_fule;
wire            ex2_cmp_fult;
wire            ex2_cmp_ford;


// the sign is used to calculate the the compare result

assign  ex2_act_s         =  add_cmp_act_s;
assign  ex2_both_zero     =  add_cmp_both_zero;

//------------------------------------------------------------------------------
//                          CMP Normal Result:
//------------------------------------------------------------------------------

assign ex2_s_equal  = ex2_src0_s == ex2_src1_s;
assign ex2_cmp_feq  = ex2_s_equal && add_cmp_ex2_src0_eq_src1 || ex2_both_zero;
assign ex2_cmp_flt  = (ex2_act_s && !ex2_cmp_feq) && !ex2_cmp_fun;
assign ex2_cmp_fle  = (ex2_cmp_feq || ex2_cmp_flt) && !ex2_cmp_fun;
assign ex2_cmp_fne  = !ex2_cmp_feq;
assign ex2_cmp_fun  = ex2_src0_snan || ex2_src0_qnan ||
                      ex2_src1_snan || ex2_src1_qnan;
assign ex2_cmp_fueq = ex2_cmp_feq || ex2_cmp_fun;
assign ex2_cmp_fune = ex2_cmp_fne || ex2_cmp_fun;
assign ex2_cmp_fule = ex2_cmp_fle || ex2_cmp_fun;
assign ex2_cmp_fult = ex2_cmp_flt || ex2_cmp_fun;
assign ex2_cmp_ford = !ex2_cmp_fun;

assign ex2_cmp_r    = ex2_op_fle  && ex2_cmp_fle ||
                      ex2_op_feq  && ex2_cmp_feq ||
                      ex2_op_flt  && ex2_cmp_flt ||
                      ex2_op_fne  && ex2_cmp_fne ||
                      ex2_op_fune && ex2_cmp_fune||
                      ex2_op_fueq && ex2_cmp_fueq||
                      ex2_op_fule && ex2_cmp_fule||
                      ex2_op_fult && ex2_cmp_fult||
                      ex2_op_fuord&& ex2_cmp_fun ||
                      ex2_op_ford && ex2_cmp_ford;

//------------------------------------------------------------------------------
//                    EX2 int special result:
//------------------------------------------------------------------------------
//cmp instruction
//if src0 or src1 is nan, rst is 0, so just need focus on inf

assign double_pipe_ex2_cmp_r = ex2_cmp_r;

//------------------------------------------------------------------------------
//                          Max/Min Normal Result:
//------------------------------------------------------------------------------
//To gengrate max/min rst
//In double, for timing design, max/min rst pipedown to ex3. Here in order to
//simplify rtu design, we also pipedown to ex3 in single
assign ex2_src0_f[51:0]              = dp_maxmin_src_a_f[51:0];
assign ex2_src0_e[10:0]              = dp_maxmin_src_a_e[10:0];
assign ex2_src0_s                    = dp_maxmin_src_a_s;
assign ex2_src1_sel[52:0]             = dp_maxmin_src_b_f[52:0];
assign ex2_src_chg                    = dp_maxmin_src_chg;
assign ex2_src1_e[10:0]               = dp_maxmin_src_b_e[10:0];
//assign ex2_src1_f[52:0]               = dp_maxmin_src_b_f[52:0];
assign ex2_src1_s                     = dp_maxmin_src_b_s;

assign ex2_double_src1_f[51:0]        = ex2_src1_sel[51:0];
assign ex2_single0_src1_f[22:0]       = ex2_src1_sel[22:0];
assign ex2_half0_src1_f[9:0]          = ex2_src1_sel[9:0];
assign ex2_bhalf0_src1_f[6:0]         = ex2_src1_sel[6:0];


//assign ex2_double_src0_f_tmp[52:0]    = ex2_act_sub         ? ~ex2_double_adder_a[52:0]    : ex2_double_adder_a[52:0];
assign ex2_double_src0_f[51:0]        = ex2_src0_f[51:0];
//assign ex2_single0_src0_f_tmp[23:0]   = ex2_act_sub         ? ~ex2_single0_adder_a[23:0]    : ex2_single0_adder_a[23:0];
assign ex2_single0_src0_f[22:0]       = ex2_src0_f[22:0];
//assign ex2_half0_src0_f_tmp[10:0]     = ex2_act_sub         ? ~ex2_half0_adder_a[10:0]    : ex2_half0_adder_a[10:0];
assign ex2_half0_src0_f[9:0]          = ex2_src0_f[9:0];
//assign ex2_bhalf0_src0_f_tmp[7:0]     = ex2_act_sub         ? ~ex2_bhalf0_adder_a[7:0]    : ex2_bhalf0_adder_a[7:0];
assign ex2_bhalf0_src0_f[6:0]         = ex2_src0_f[6:0];

assign ex2_sel_rst_both0_sign         =  ex2_op_max ? ex2_src0_s && ex2_src1_s : ex2_src0_s || ex2_src1_s;
assign ex2_sel_rst_max_s              =  ex2_act_s ^ ex2_src_chg ? ex2_src1_s  : ex2_src0_s;
assign ex2_sel_rst_min_s              = !ex2_act_s ^ ex2_src_chg ? ex2_src1_s  : ex2_src0_s;
assign ex2_double_sel_rst_max_f[51:0] =  ex2_act_s ^ ex2_src_chg ? ex2_double_src1_f[51:0] : ex2_double_src0_f[51:0];
assign ex2_double_sel_rst_min_f[51:0] = !ex2_act_s ^ ex2_src_chg ? ex2_double_src1_f[51:0] : ex2_double_src0_f[51:0];

assign ex2_single0_sel_rst_max_f[22:0] =  ex2_act_s ^ ex2_src_chg ? ex2_single0_src1_f[22:0] : ex2_single0_src0_f[22:0];
assign ex2_single0_sel_rst_min_f[22:0] = !ex2_act_s ^ ex2_src_chg ? ex2_single0_src1_f[22:0] : ex2_single0_src0_f[22:0];

assign ex2_half0_sel_rst_max_f[9:0] =  ex2_act_s ^ ex2_src_chg ? ex2_half0_src1_f[9:0] : ex2_half0_src0_f[9:0];
assign ex2_half0_sel_rst_min_f[9:0] = !ex2_act_s ^ ex2_src_chg ? ex2_half0_src1_f[9:0] : ex2_half0_src0_f[9:0];

assign ex2_bhalf0_sel_rst_max_f[6:0] =  ex2_act_s ^ ex2_src_chg ? ex2_bhalf0_src1_f[6:0] : ex2_bhalf0_src0_f[6:0];
assign ex2_bhalf0_sel_rst_min_f[6:0] = !ex2_act_s ^ ex2_src_chg ? ex2_bhalf0_src1_f[6:0] : ex2_bhalf0_src0_f[6:0];

assign ex2_sel_final_sign            = ex2_both_zero ? ex2_sel_rst_both0_sign :
                                       ex2_op_max    ? ex2_sel_rst_max_s
                                                     : ex2_sel_rst_min_s;
assign ex2_sel_rst_max_e[10:0] =  ex2_act_s ^ ex2_src_chg ? ex2_src1_e[10:0] : ex2_src0_e[10:0];
assign ex2_sel_rst_min_e[10:0] = !ex2_act_s ^ ex2_src_chg ? ex2_src1_e[10:0] : ex2_src0_e[10:0];
assign ex2_sel_final_e[10:0]   = ex2_op_max ? ex2_sel_rst_max_e[10:0] : ex2_sel_rst_min_e[10:0];

assign ex2_double_sel_final_f[51:0]   = ex2_op_max ? ex2_double_sel_rst_max_f[51:0] : ex2_double_sel_rst_min_f[51:0];
assign ex2_single0_sel_final_f[22:0]  = ex2_op_max ? ex2_single0_sel_rst_max_f[22:0] : ex2_single0_sel_rst_min_f[22:0];
assign ex2_half0_sel_final_f[9:0]     = ex2_op_max ? ex2_half0_sel_rst_max_f[9:0] : ex2_half0_sel_rst_min_f[9:0];
assign ex2_bhalf0_sel_final_f[6:0]    = ex2_op_max ? ex2_bhalf0_sel_rst_max_f[6:0] : ex2_bhalf0_sel_rst_min_f[6:0];


// &ModuleEnd; @168
endmodule




