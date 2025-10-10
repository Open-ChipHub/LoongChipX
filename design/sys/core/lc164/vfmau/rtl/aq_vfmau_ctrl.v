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

// &ModuleBeg; @24
module aq_vfmau_ctrl (
  // &Ports, @25
  input    wire         ex2_dst_double,
  input    wire         ex2_mac,
  input    wire         ex2_simd,
  input    wire  [5:0]  ex2_special_sel,
  input    wire         ex3_dst_double,
  input    wire         ex3_mac,
  input    wire         ex3_special_cmplt,
  input    wire         ex4_dst_double,
  input    wire         ex4_mac,
  input    wire  [9:0]  vpu_group_0_xx_ex1_eu_sel,
  input    wire         vpu_group_0_xx_ex1_sel,
  input    wire  [9:0]  vpu_group_0_xx_ex2_eu_sel,
  input    wire         vpu_group_0_xx_ex2_sel,
  input    wire         vpu_group_0_xx_ex2_stall,
  input    wire  [9:0]  vpu_group_0_xx_ex3_eu_sel,
  input    wire         vpu_group_0_xx_ex3_sel,
  input    wire         vpu_group_0_xx_ex3_stall,
  input    wire  [9:0]  vpu_group_0_xx_ex4_eu_sel,
  input    wire         vpu_group_0_xx_ex4_sel,
  input    wire         vpu_group_0_xx_ex4_stall,
  input    wire         vpu_group_0_xx_ex5_stall,
  output   wire         ctrl_dp_ex1_inst_pipe_down,
  output   wire         ctrl_dp_ex1_inst_vld,
  output   wire         ctrl_dp_ex2_inst_pipe_down,
  output   wire         ctrl_dp_ex2_inst_vld,
  output   wire         ctrl_dp_ex3_inst_pipe_down,
  output   wire         ctrl_dp_ex3_inst_vld,
  output   wire         ctrl_dp_ex4_inst_pipe_down,
  output   wire         ctrl_dp_ex4_inst_vld,
  output   wire         vfmau_vpu_ex2_result_ready_in_ex3,
  output   wire         vfmau_vpu_ex3_result_ready_in_ex4
); 



wire           ex1_inst_vld;                     
wire           ex2_inst_vld;                     
wire           ex3_inst_vld;                     
wire           ex4_inst_vld;                     


parameter DOUBLE_WIDTH = 64;
parameter DOUBLE_FRAC  = 52;
parameter DOUBLE_EXPN  = 11;

parameter SINGLE_WIDTH = 32;
parameter SINGLE_FRAC  = 23;
parameter SINGLE_EXPN  =  8;

parameter HALF_WIDTH   = 16;
parameter HALF_FRAC    = 10;
parameter HALF_EXPN    =  5;

parameter BHALF_WIDTH  = 16;
parameter BHALF_FRAC   =  7;
parameter BHALF_EXPN   =  8;

parameter FUNC_WIDTH   = 20;
//==========================================================
//                     EX1 Interface
//==========================================================
assign ex1_inst_vld               = vpu_group_0_xx_ex1_sel && vpu_group_0_xx_ex1_eu_sel[0];
assign ctrl_dp_ex1_inst_vld       = ex1_inst_vld;
assign ctrl_dp_ex1_inst_pipe_down = ex1_inst_vld && !vpu_group_0_xx_ex2_stall;
//==========================================================
//                     EX2 inst vld ctrl
//==========================================================
assign ex2_inst_vld               = vpu_group_0_xx_ex2_sel && vpu_group_0_xx_ex2_eu_sel[0]; 
assign ctrl_dp_ex2_inst_vld       = ex2_inst_vld;
assign ctrl_dp_ex2_inst_pipe_down = ex2_inst_vld && !vpu_group_0_xx_ex3_stall;

assign vfmau_vpu_ex2_result_ready_in_ex3 = ex2_inst_vld && ((|ex2_special_sel[5:0])&& !ex2_simd || !ex2_mac &&!ex2_dst_double);

//==========================================================
//                     EX3 inst vld ctrl
//==========================================================
assign ex3_inst_vld               = vpu_group_0_xx_ex3_sel && vpu_group_0_xx_ex3_eu_sel[0]; 
assign ctrl_dp_ex3_inst_vld       = ex3_inst_vld && (ex3_mac || ex3_dst_double) && !ex3_special_cmplt;
assign ctrl_dp_ex3_inst_pipe_down = ex3_inst_vld && (ex3_mac || ex3_dst_double) && !vpu_group_0_xx_ex4_stall && !ex3_special_cmplt;


assign vfmau_vpu_ex3_result_ready_in_ex4 = ex3_inst_vld 
                                        && !ex3_special_cmplt 
                                        && (ex3_mac^ex3_dst_double);                                 
//==========================================================
//                     EX4 inst vld ctrl
//==========================================================
assign ex4_inst_vld               = vpu_group_0_xx_ex4_sel && vpu_group_0_xx_ex4_eu_sel[0]; 
assign ctrl_dp_ex4_inst_vld       = ex4_inst_vld;
assign ctrl_dp_ex4_inst_pipe_down = ex4_inst_vld && ex4_mac && ex4_dst_double && !vpu_group_0_xx_ex5_stall;
endmodule


