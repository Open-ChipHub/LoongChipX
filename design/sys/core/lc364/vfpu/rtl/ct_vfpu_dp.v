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
module ct_vfpu_dp (
  // &Ports, @23
  input    wire  [31:0]  cp0_vfpu_fxcr,
  input    wire          cp0_vfpu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_dp_ex2_pipe7_inst_vld,
  input    wire  [11:0]  ctrl_ex1_pipe6_eu_sel,
  input    wire          ctrl_ex1_pipe6_inst_vld,
  input    wire          ctrl_ex1_pipe6_mfvr_inst_vld,
  input    wire          ctrl_ex1_pipe6_mfvr_inst_vld_dup0,
  input    wire          ctrl_ex1_pipe6_mfvr_inst_vld_dup1,
  input    wire          ctrl_ex1_pipe6_mfvr_inst_vld_dup2,
  input    wire          ctrl_ex1_pipe6_mfvr_inst_vld_dup3,
  input    wire  [11:0]  ctrl_ex1_pipe7_eu_sel,
  input    wire          ctrl_ex1_pipe7_mfvr_inst_vld,
  input    wire          ctrl_ex1_pipe7_mfvr_inst_vld_dup0,
  input    wire          ctrl_ex1_pipe7_mfvr_inst_vld_dup1,
  input    wire          ctrl_ex1_pipe7_mfvr_inst_vld_dup2,
  input    wire          ctrl_ex1_pipe7_mfvr_inst_vld_dup3,
  input    wire          ctrl_ex2_pipe6_inst_vld,
  input    wire          ctrl_ex2_pipe6_mfvr_inst_vld,
  input    wire          ctrl_ex2_pipe7_inst_vld,
  input    wire          ctrl_ex2_pipe7_mfvr_inst_vld,
  input    wire          ctrl_ex3_pipe6_inst_vld,
  input    wire          ctrl_ex3_pipe7_inst_vld,
  input    wire          ctrl_ex4_pipe6_inst_vld,
  input    wire          forever_cpuclk,
  input    wire          idu_vfpu_is_vdiv_gateclk_issue,
  input    wire          idu_vfpu_is_vdiv_issue,
  input    wire  [31:0]  idu_vfpu_rf_pipe6_opcode,
  input    wire  [4 :0]  idu_vfpu_rf_pipe6_dst_ereg,
  input    wire  [6 :0]  idu_vfpu_rf_pipe6_dst_preg,
  input    wire          idu_vfpu_rf_pipe6_dst_vld,
  input    wire  [6 :0]  idu_vfpu_rf_pipe6_dst_vreg,
  input    wire          idu_vfpu_rf_pipe6_dste_vld,
  input    wire          idu_vfpu_rf_pipe6_dstv_vld,
  input    wire  [11:0]  idu_vfpu_rf_pipe6_eu_sel,
  input    wire  [19:0]  idu_vfpu_rf_pipe6_func,
  input    wire          idu_vfpu_rf_pipe6_gateclk_sel,
  input    wire  [6 :0]  idu_vfpu_rf_pipe6_iid,
  input    wire  [2 :0]  idu_vfpu_rf_pipe6_imm0,
  input    wire  [5 :0]  idu_vfpu_rf_pipe6_inst_type,
  input    wire          idu_vfpu_rf_pipe6_mla_srcv2_vld,
  input    wire  [6 :0]  idu_vfpu_rf_pipe6_mla_srcv2_vreg,
  input    wire  [2 :0]  idu_vfpu_rf_pipe6_ready_stage,
  input    wire  [63:0]  idu_vfpu_rf_pipe6_srcv0_fr,
  input    wire  [63:0]  idu_vfpu_rf_pipe6_srcv1_fr,
  input    wire  [63:0]  idu_vfpu_rf_pipe6_srcv2_fr,
  input    wire  [2 :0]  idu_vfpu_rf_pipe6_vmla_type,
  input    wire  [31:0]  idu_vfpu_rf_pipe7_opcode,
  input    wire  [4 :0]  idu_vfpu_rf_pipe7_dst_ereg,
  input    wire  [6 :0]  idu_vfpu_rf_pipe7_dst_preg,
  input    wire          idu_vfpu_rf_pipe7_dst_vld,
  input    wire  [6 :0]  idu_vfpu_rf_pipe7_dst_vreg,
  input    wire          idu_vfpu_rf_pipe7_dste_vld,
  input    wire          idu_vfpu_rf_pipe7_dstv_vld,
  input    wire  [11:0]  idu_vfpu_rf_pipe7_eu_sel,
  input    wire  [19:0]  idu_vfpu_rf_pipe7_func,
  input    wire          idu_vfpu_rf_pipe7_gateclk_sel,
  input    wire  [2 :0]  idu_vfpu_rf_pipe7_imm0,
  input    wire  [5 :0]  idu_vfpu_rf_pipe7_inst_type,
  input    wire          idu_vfpu_rf_pipe7_mla_srcv2_vld,
  input    wire  [6 :0]  idu_vfpu_rf_pipe7_mla_srcv2_vreg,
  input    wire  [2 :0]  idu_vfpu_rf_pipe7_ready_stage,
  input    wire  [63:0]  idu_vfpu_rf_pipe7_srcv0_fr,
  input    wire  [63:0]  idu_vfpu_rf_pipe7_srcv1_fr,
  input    wire  [63:0]  idu_vfpu_rf_pipe7_srcv2_fr,
  input    wire  [2 :0]  idu_vfpu_rf_pipe7_vmla_type,
  input    wire  [4 :0]  iu_vfpu_ex1_pipe0_mtvr_inst,
  input    wire          iu_vfpu_ex1_pipe0_mtvr_vld,
  input    wire  [6 :0]  iu_vfpu_ex1_pipe0_mtvr_vreg,
  input    wire  [4 :0]  iu_vfpu_ex1_pipe1_mtvr_inst,
  input    wire          iu_vfpu_ex1_pipe1_mtvr_vld,
  input    wire  [6 :0]  iu_vfpu_ex1_pipe1_mtvr_vreg,
  input    wire  [63:0]  iu_vfpu_ex2_pipe0_mtvr_src0,
  input    wire  [63:0]  iu_vfpu_ex2_pipe1_mtvr_src0,
  input    wire          pad_yy_icg_scan_en,
  input    wire          pipe6_dp_ex1_mult_id,
  input    wire  [63:0]  pipe6_dp_ex1_vfalu_mfvr_data,
  input    wire  [4 :0]  pipe6_dp_ex3_vfalu_ereg_data,
  input    wire  [63:0]  pipe6_dp_ex3_vfalu_freg_data,
  input    wire  [4 :0]  pipe6_dp_ex3_vfmau_ereg_data,
  input    wire  [63:0]  pipe6_dp_ex3_vfmau_freg_data,
  input    wire  [4 :0]  pipe6_dp_ex4_vfmau_ereg_data,
  input    wire  [63:0]  pipe6_dp_ex4_vfmau_freg_data,
  input    wire  [4 :0]  pipe6_dp_vfdsu_ereg,
  input    wire  [4 :0]  pipe6_dp_vfdsu_ereg_data,
  input    wire  [63:0]  pipe6_dp_vfdsu_freg_data,
  input    wire          pipe6_dp_vfdsu_inst_vld,
  input    wire  [6 :0]  pipe6_dp_vfdsu_vreg,
  input    wire          pipe7_dp_ex1_mult_id,
  input    wire  [63:0]  pipe7_dp_ex1_vfalu_mfvr_data,
  input    wire  [4 :0]  pipe7_dp_ex3_vfalu_ereg_data,
  input    wire  [63:0]  pipe7_dp_ex3_vfalu_freg_data,
  input    wire  [4 :0]  pipe7_dp_ex3_vfmau_ereg_data,
  input    wire  [63:0]  pipe7_dp_ex3_vfmau_freg_data,
  input    wire  [4 :0]  pipe7_dp_ex4_vfmau_ereg_data,
  input    wire  [63:0]  pipe7_dp_ex4_vfmau_freg_data,
  input    wire  [6 :0]  vdivu_vfpu_ex1_pipe6_dst_vreg,
  input    wire          vdivu_vfpu_ex1_pipe6_result_vld,
  input    wire          vdivu_vfpu_pipe6_req_for_bubble,
  input    wire          vdivu_vfpu_pipe6_vdiv_busy,
  input    wire  [63:0]  vdsp_vfpu_ex1_pipe6_mfvr_data,
  input    wire  [63:0]  vdsp_vfpu_ex1_pipe7_mfvr_data,
  input    wire          vfdsu_dp_fdiv_busy,
  input    wire          vfdsu_dp_inst_wb_req,
  output   wire          dp_ctrl_ex1_pipe6_data_vld_pre,
  output   wire          dp_ctrl_ex1_pipe7_data_vld_pre,
  output   wire          dp_ctrl_ex2_pipe6_data_vld_pre,
  output   wire          dp_ctrl_ex2_pipe7_data_vld_pre,
  output   wire          dp_ctrl_ex3_pipe6_data_vld_pre,
  output   wire          dp_ctrl_ex3_pipe6_fwd_vld_pre,
  output   wire          dp_ctrl_ex3_pipe7_data_vld_pre,
  output   wire          dp_ctrl_ex3_pipe7_fwd_vld_pre,
  output   wire          dp_ctrl_ex4_pipe6_fwd_vld_pre,
  output   wire          dp_ctrl_ex4_pipe7_fwd_vld_pre,
  output   wire          dp_ctrl_pipe6_vfdsu_inst_vld,
  output   reg           dp_ex1_pipe6_dst_vld_pre,
  output   reg           dp_ex1_pipe7_dst_vld_pre,
  output   reg   [6 :0]  dp_ex3_pipe6_dst_vreg,
  output   reg   [63:0]  dp_ex3_pipe6_freg_data,
  output   reg   [6 :0]  dp_ex3_pipe7_dst_vreg,
  output   reg   [63:0]  dp_ex3_pipe7_freg_data,
  output   reg   [4 :0]  dp_ex4_pipe6_dst_ereg,
  output   reg   [6 :0]  dp_ex4_pipe6_dst_vreg,
  output   wire          dp_ex4_pipe6_normal_dste_wb_vld,
  output   wire          dp_ex4_pipe6_normal_dstv_wb_vld,
  output   reg   [4 :0]  dp_ex4_pipe7_dst_ereg,
  output   reg   [6 :0]  dp_ex4_pipe7_dst_vreg,
  output   reg           dp_ex4_pipe7_dste_vld,
  output   reg           dp_ex4_pipe7_dstv_vld,
  output   wire  [4 :0]  dp_ex5_pipe6_ereg_data_pre,
  output   wire  [63:0]  dp_ex5_pipe6_freg_data_pre,
  output   wire  [4 :0]  dp_ex5_pipe7_ereg_data_pre,
  output   wire  [63:0]  dp_ex5_pipe7_freg_data_pre,
  output   wire  [6 :0]  dp_rbus_pipe6_ex1_vreg,
  output   wire  [6 :0]  dp_rbus_pipe6_ex1_vreg_dup0,
  output   wire  [6 :0]  dp_rbus_pipe6_ex1_vreg_dup1,
  output   wire  [6 :0]  dp_rbus_pipe6_ex1_vreg_dup2,
  output   wire  [6 :0]  dp_rbus_pipe6_ex2_vreg,
  output   wire  [6 :0]  dp_rbus_pipe6_ex2_vreg_dup0,
  output   wire  [6 :0]  dp_rbus_pipe6_ex2_vreg_dup1,
  output   wire  [6 :0]  dp_rbus_pipe6_ex2_vreg_dup2,
  output   wire  [6 :0]  dp_rbus_pipe6_ex3_vreg_dup0,
  output   wire  [6 :0]  dp_rbus_pipe6_ex3_vreg_dup1,
  output   wire  [6 :0]  dp_rbus_pipe6_ex3_vreg_dup2,
  output   wire  [6 :0]  dp_rbus_pipe6_ex3_vreg_dup3,
  output   wire  [6 :0]  dp_rbus_pipe7_ex1_vreg,
  output   wire  [6 :0]  dp_rbus_pipe7_ex1_vreg_dup0,
  output   wire  [6 :0]  dp_rbus_pipe7_ex1_vreg_dup1,
  output   wire  [6 :0]  dp_rbus_pipe7_ex1_vreg_dup2,
  output   wire  [6 :0]  dp_rbus_pipe7_ex2_vreg,
  output   wire  [6 :0]  dp_rbus_pipe7_ex2_vreg_dup0,
  output   wire  [6 :0]  dp_rbus_pipe7_ex2_vreg_dup1,
  output   wire  [6 :0]  dp_rbus_pipe7_ex2_vreg_dup2,
  output   wire  [6 :0]  dp_rbus_pipe7_ex3_vreg_dup0,
  output   wire  [6 :0]  dp_rbus_pipe7_ex3_vreg_dup1,
  output   wire  [6 :0]  dp_rbus_pipe7_ex3_vreg_dup2,
  output   wire  [6 :0]  dp_rbus_pipe7_ex3_vreg_dup3,
  output   wire  [19:0]  dp_vfalu_ex1_pipe6_func,
  output   wire  [2 :0]  dp_vfalu_ex1_pipe6_imm0,
  output   wire  [63:0]  dp_vfalu_ex1_pipe6_mtvr_src0,
  output   wire  [2 :0]  dp_vfalu_ex1_pipe6_sel,
  output   wire  [63:0]  dp_vfalu_ex1_pipe6_srcf0,
  output   wire  [63:0]  dp_vfalu_ex1_pipe6_srcf1,
  output   wire  [63:0]  dp_vfalu_ex1_pipe6_srcf2,
  output   wire  [19:0]  dp_vfalu_ex1_pipe7_func,
  output   wire  [2 :0]  dp_vfalu_ex1_pipe7_imm0,
  output   wire  [63:0]  dp_vfalu_ex1_pipe7_mtvr_src0,
  output   wire  [2 :0]  dp_vfalu_ex1_pipe7_sel,
  output   wire  [63:0]  dp_vfalu_ex1_pipe7_srcf0,
  output   wire  [63:0]  dp_vfalu_ex1_pipe7_srcf1,
  output   wire  [63:0]  dp_vfalu_ex1_pipe7_srcf2,
  output   wire  [4 :0]  dp_vfdsu_ex1_pipe6_dst_ereg,
  output   wire  [6 :0]  dp_vfdsu_ex1_pipe6_dst_vreg,
  output   wire  [6 :0]  dp_vfdsu_ex1_pipe6_iid,
  output   wire  [2 :0]  dp_vfdsu_ex1_pipe6_imm0,
  output   wire          dp_vfdsu_ex1_pipe6_sel,
  output   wire  [63:0]  dp_vfdsu_ex1_pipe6_srcf0,
  output   wire  [63:0]  dp_vfdsu_ex1_pipe6_srcf1,
  output   wire  [63:0]  dp_vfdsu_ex1_pipe6_srcf2,
  output   wire          dp_vfdsu_fdiv_gateclk_issue,
  output   wire          dp_vfdsu_idu_fdiv_issue,
  output   wire  [6 :0]  dp_vfmau_ex1_pipe6_dst_vreg,
  output   wire  [2 :0]  dp_vfmau_ex1_pipe6_imm0,
  output   wire          dp_vfmau_ex1_pipe6_sel,
  output   wire  [6 :0]  dp_vfmau_ex1_pipe7_dst_vreg,
  output   wire  [2 :0]  dp_vfmau_ex1_pipe7_imm0,
  output   wire          dp_vfmau_ex1_pipe7_sel,
  output   wire  [5 :0]  dp_vfmau_pipe6_inst_type,
  output   wire          dp_vfmau_pipe6_mla_srcv2_vld,
  output   wire  [6 :0]  dp_vfmau_pipe6_mla_srcv2_vreg,
  output   wire  [2 :0]  dp_vfmau_pipe6_mla_type,
  output   wire          dp_vfmau_pipe6_sel,
  output   wire          dp_vfmau_pipe6_vfmau_sel,
  output   wire  [5 :0]  dp_vfmau_pipe7_inst_type,
  output   wire          dp_vfmau_pipe7_mla_srcv2_vld,
  output   wire  [6 :0]  dp_vfmau_pipe7_mla_srcv2_vreg,
  output   wire  [2 :0]  dp_vfmau_pipe7_mla_type,
  output   wire          dp_vfmau_pipe7_sel,
  output   wire          dp_vfmau_pipe7_vfmau_sel,
  output   wire          vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup0,
  output   wire          vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup1,
  output   wire          vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup2,
  output   wire          vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup3,
  output   wire          vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup4,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe6_preg_dup0,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe6_preg_dup1,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe6_preg_dup2,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe6_preg_dup3,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe6_preg_dup4,
  output   wire          vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup0,
  output   wire          vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup1,
  output   wire          vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup2,
  output   wire          vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup3,
  output   wire          vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup4,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe7_preg_dup0,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe7_preg_dup1,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe7_preg_dup2,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe7_preg_dup3,
  output   wire  [6 :0]  vfpu_idu_ex1_pipe7_preg_dup4,
  output   wire          vfpu_idu_vdiv_busy,
  output   wire          vfpu_idu_vdiv_wb_stall,
  output   wire  [63:0]  vfpu_iu_ex2_pipe6_mfvr_data,
  output   wire          vfpu_iu_ex2_pipe6_mfvr_data_vld,
  output   wire  [6 :0]  vfpu_iu_ex2_pipe6_mfvr_preg,
  output   wire  [63:0]  vfpu_iu_ex2_pipe7_mfvr_data,
  output   wire          vfpu_iu_ex2_pipe7_mfvr_data_vld,
  output   wire  [6 :0]  vfpu_iu_ex2_pipe7_mfvr_preg,
  output   wire          vfpu_yy_xx_dqnan,
  output   wire  [2 :0]  vfpu_yy_xx_rm
); 



// &Regs; @24
reg     [31:0]  dp_ex1_pipe6_opcode;
reg     [4 :0]  dp_ex1_pipe6_dst_ereg;                
reg     [6 :0]  dp_ex1_pipe6_dst_preg;                
reg     [6 :0]  dp_ex1_pipe6_dst_preg_dup0;           
reg     [6 :0]  dp_ex1_pipe6_dst_preg_dup1;           
reg     [6 :0]  dp_ex1_pipe6_dst_preg_dup2;           
reg     [6 :0]  dp_ex1_pipe6_dst_preg_dup3;           
reg     [6 :0]  dp_ex1_pipe6_dst_vreg;                
reg     [6 :0]  dp_ex1_pipe6_dst_vreg_dup0;           
reg     [6 :0]  dp_ex1_pipe6_dst_vreg_dup1;           
reg     [6 :0]  dp_ex1_pipe6_dst_vreg_dup2;           
reg             dp_ex1_pipe6_dste_vld;                
reg             dp_ex1_pipe6_dstv_vld;                
reg     [19:0]  dp_ex1_pipe6_func;                    
reg     [6 :0]  dp_ex1_pipe6_iid;                     
reg     [2 :0]  dp_ex1_pipe6_imm0;                    
reg     [6 :0]  dp_ex1_pipe6_mla_srcv2_vreg;          
reg     [2 :0]  dp_ex1_pipe6_ready_stage;             
reg     [63:0]  dp_ex1_pipe6_vfpu_srcf0;              
reg     [63:0]  dp_ex1_pipe6_vfpu_srcf1;              
reg     [63:0]  dp_ex1_pipe6_vfpu_srcf2;              
reg     [31:0]  dp_ex1_pipe7_opcode;
reg     [4 :0]  dp_ex1_pipe7_dst_ereg;                
reg     [6 :0]  dp_ex1_pipe7_dst_preg;                
reg     [6 :0]  dp_ex1_pipe7_dst_preg_dup0;           
reg     [6 :0]  dp_ex1_pipe7_dst_preg_dup1;           
reg     [6 :0]  dp_ex1_pipe7_dst_preg_dup2;           
reg     [6 :0]  dp_ex1_pipe7_dst_preg_dup3;           
reg     [6 :0]  dp_ex1_pipe7_dst_vreg;                
reg     [6 :0]  dp_ex1_pipe7_dst_vreg_dup0;           
reg     [6 :0]  dp_ex1_pipe7_dst_vreg_dup1;           
reg     [6 :0]  dp_ex1_pipe7_dst_vreg_dup2;           
reg             dp_ex1_pipe7_dste_vld;                
reg             dp_ex1_pipe7_dstv_vld;                
reg     [19:0]  dp_ex1_pipe7_func;                    
reg     [2 :0]  dp_ex1_pipe7_imm0;                    
reg     [6 :0]  dp_ex1_pipe7_mla_srcv2_vreg;          
reg     [2 :0]  dp_ex1_pipe7_ready_stage;             
reg     [63:0]  dp_ex1_pipe7_vfpu_srcf0;              
reg     [63:0]  dp_ex1_pipe7_vfpu_srcf1;              
reg     [63:0]  dp_ex1_pipe7_vfpu_srcf2;              
reg     [4 :0]  dp_ex2_pipe6_dst_ereg;                
reg     [6 :0]  dp_ex2_pipe6_dst_preg;                
reg     [6 :0]  dp_ex2_pipe6_dst_vreg;                
reg     [6 :0]  dp_ex2_pipe6_dst_vreg_dup0;           
reg     [6 :0]  dp_ex2_pipe6_dst_vreg_dup1;           
reg     [6 :0]  dp_ex2_pipe6_dst_vreg_dup2;           
reg             dp_ex2_pipe6_dste_vld;                
reg             dp_ex2_pipe6_dstv_vld;                
reg     [4 :0]  dp_ex2_pipe6_ereg_data;               
reg     [4 :0]  dp_ex2_pipe6_eu_sel;                  
reg     [63:0]  dp_ex2_pipe6_freg_data;               
reg     [63:0]  dp_ex2_pipe6_mfvr_data;               
reg     [2 :0]  dp_ex2_pipe6_ready_stage;             
reg     [4 :0]  dp_ex2_pipe7_dst_ereg;                
reg     [6 :0]  dp_ex2_pipe7_dst_preg;                
reg     [6 :0]  dp_ex2_pipe7_dst_vreg;                
reg     [6 :0]  dp_ex2_pipe7_dst_vreg_dup0;           
reg     [6 :0]  dp_ex2_pipe7_dst_vreg_dup1;           
reg     [6 :0]  dp_ex2_pipe7_dst_vreg_dup2;           
reg             dp_ex2_pipe7_dste_vld;                
reg             dp_ex2_pipe7_dstv_vld;                
reg     [3 :0]  dp_ex2_pipe7_eu_sel;                  
reg     [63:0]  dp_ex2_pipe7_mfvr_data;               
reg     [2 :0]  dp_ex2_pipe7_ready_stage;             
reg     [4 :0]  dp_ex3_pipe6_dst_ereg;                
reg     [6 :0]  dp_ex3_pipe6_dst_vreg_dup0;           
reg     [6 :0]  dp_ex3_pipe6_dst_vreg_dup1;           
reg     [6 :0]  dp_ex3_pipe6_dst_vreg_dup2;           
reg     [6 :0]  dp_ex3_pipe6_dst_vreg_dup3;           
reg             dp_ex3_pipe6_dste_vld;                
reg             dp_ex3_pipe6_dstv_vld;                
reg     [4 :0]  dp_ex3_pipe6_ereg_data;               
reg     [4 :0]  dp_ex3_pipe6_ereg_data_raw;           
reg     [4 :0]  dp_ex3_pipe6_eu_sel;                  
reg     [63:0]  dp_ex3_pipe6_freg_data_raw;           
reg     [2 :0]  dp_ex3_pipe6_ready_stage;             
reg             dp_ex3_pipe6_vreg_fwd_vld;            
reg     [4 :0]  dp_ex3_pipe7_dst_ereg;                
reg     [6 :0]  dp_ex3_pipe7_dst_vreg_dup0;           
reg     [6 :0]  dp_ex3_pipe7_dst_vreg_dup1;           
reg     [6 :0]  dp_ex3_pipe7_dst_vreg_dup2;           
reg     [6 :0]  dp_ex3_pipe7_dst_vreg_dup3;           
reg             dp_ex3_pipe7_dste_vld;                
reg             dp_ex3_pipe7_dstv_vld;                
reg     [4 :0]  dp_ex3_pipe7_ereg_data;               
reg     [3 :0]  dp_ex3_pipe7_eu_sel;                  
reg     [2 :0]  dp_ex3_pipe7_ready_stage;             
reg             dp_ex3_pipe7_vfalu_wb_vld;            
reg             dp_ex3_pipe7_vreg_fwd_vld;            
reg             dp_ex4_pipe6_dste_vld;                
reg             dp_ex4_pipe6_dstv_vld;                
reg     [4 :0]  dp_ex4_pipe6_ereg_data;               
reg     [3 :0]  dp_ex4_pipe6_eu_sel;                  
reg     [63:0]  dp_ex4_pipe6_freg_data;               
reg     [2 :0]  dp_ex4_pipe6_ready_stage;             
reg             dp_ex4_pipe6_vreg_fwd_vld;            
reg     [1 :0]  dp_ex4_pipe6_wb_vld;                  
reg     [4 :0]  dp_ex4_pipe7_ereg_data;               
reg     [3 :0]  dp_ex4_pipe7_eu_sel;                  
reg     [63:0]  dp_ex4_pipe7_freg_data;               
reg     [2 :0]  dp_ex4_pipe7_ready_stage;             
reg             dp_ex4_pipe7_vreg_fwd_vld;            
reg     [1 :0]  dp_ex4_pipe7_wb_vld;                  

// &Wires; @25
wire    [63:0]  dp_ex1_pipe6_mfvr_data;               
wire            dp_ex1_pipe6_pipe_clk;                
wire            dp_ex1_pipe6_pipe_en;                 
wire    [63:0]  dp_ex1_pipe7_mfvr_data;               
wire            dp_ex1_pipe7_pipe_clk;                
wire            dp_ex1_pipe7_pipe_en;                 
wire            dp_ex2_pipe6_clk;                     
wire    [4 :0]  dp_ex2_pipe6_dst_ereg_pre;            
wire    [6 :0]  dp_ex2_pipe6_dst_vreg_pre;            
wire            dp_ex2_pipe6_en;                      
wire    [4 :0]  dp_ex2_pipe6_eu_sel_pre;              
wire    [2 :0]  dp_ex2_pipe6_ready_stage_pre;         
wire            dp_ex2_pipe7_clk;                     
wire            dp_ex2_pipe7_en;                      
wire    [3 :0]  dp_ex2_pipe7_eu_sel_pre;              
wire    [2 :0]  dp_ex2_pipe7_ready_stage_pre;         
wire            dp_ex3_pipe6_clk;                     
wire            dp_ex3_pipe6_en;                      
wire            dp_ex3_pipe6_vreg_fwd_vld_pre;        
wire            dp_ex3_pipe7_clk;                     
wire            dp_ex3_pipe7_en;                      
wire            dp_ex3_pipe7_vfalu_wb_vld_pre;        
wire            dp_ex3_pipe7_vreg_fwd_vld_pre;        
wire            dp_ex4_pipe6_clk;                     
wire            dp_ex4_pipe6_en;                      
wire    [4 :0]  dp_ex4_pipe6_ereg_data_new;           
wire    [1 :0]  dp_ex4_pipe6_ereg_sel;                
wire            dp_ex4_pipe6_vreg_fwd_vld_pre;        
wire    [1 :0]  dp_ex4_pipe6_wb_vld_pre;              
wire            dp_ex4_pipe7_clk;                     
wire            dp_ex4_pipe7_en;                      
wire    [4 :0]  dp_ex4_pipe7_ereg_data_new;           
wire    [1 :0]  dp_ex4_pipe7_ereg_sel;                
wire            dp_ex4_pipe7_vreg_fwd_vld_pre;        
wire    [1 :0]  dp_ex4_pipe7_wb_vld_pre;              
wire            ex1_pipe6_eu_sel_vec_mtvr;            
wire            ex1_pipe7_eu_sel_vec_mtvr;            
wire    [4 :0]  pipe6_dp_ex4_vfalu_ereg_data;         
wire    [19:0]  pipe6_mtvr_func;                      
wire    [6 :0]  pipe6_mtvr_vreg;                      
wire    [4 :0]  pipe7_dp_ex4_vfalu_ereg_data;         
wire    [19:0]  pipe7_mtvr_func;                      
wire    [6 :0]  pipe7_mtvr_vreg;                      


// &Depend("cpu_cfig.h"); @27
parameter VLEN       = 128;
parameter EU_WIDTH   = 12;
parameter SILEN      = 64;
parameter FPR_MSB    = 63;
parameter VREG       = 7;
parameter VL         = 8;
parameter XLEN       = 64;
parameter FUNC_WIDTH = 20;

// &Force("bus","iu_vfpu_ex1_pipe0_mtvr_inst",4,0); @37
// &Force("bus","iu_vfpu_ex1_pipe1_mtvr_inst",4,0); @38

// &Force("bus","idu_vfpu_rf_pipe6_eu_sel",EU_WIDTH-1,0); @40
// &Force("bus","idu_vfpu_rf_pipe7_eu_sel",EU_WIDTH-1,0); @41

//==========================================================
//                 Pipe6 Instrcution Data
//==========================================================
//----------------------------------------------------------
//                    EX1 data preparation
//----------------------------------------------------------
assign pipe6_mtvr_func[19:0]   = 
    {20{iu_vfpu_ex1_pipe0_mtvr_inst[4]}} & 20'b0010_0000_0000_0010_0001   //half
  | {20{iu_vfpu_ex1_pipe0_mtvr_inst[0]}} & 20'b0010_1000_0000_0010_0001   //single
  | {20{iu_vfpu_ex1_pipe0_mtvr_inst[1]}} & 20'b0011_0000_0000_0010_0001   //double
  | {20{iu_vfpu_ex1_pipe0_mtvr_inst[2]}} & 20'b0000_0000_0000_0010_0100   //vmove to element 0
  | {20{iu_vfpu_ex1_pipe0_mtvr_inst[3]}} & 20'b0000_0000_0000_0100_0100;  //vcopy to all element

assign pipe6_mtvr_vreg[VREG-1:0]    = iu_vfpu_ex1_pipe0_mtvr_vreg[VREG-1:0];

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
 assign dp_ex1_pipe6_pipe_en = idu_vfpu_rf_pipe6_gateclk_sel
                            || iu_vfpu_ex1_pipe0_mtvr_vld;

//  &Instance("gated_clk_cell", "x_dp_ex1_pipe6_pipe_gated_clk"); @64
gated_clk_cell  x_dp_ex1_pipe6_pipe_gated_clk (
  .clk_in                (forever_cpuclk       ),
  .clk_out               (dp_ex1_pipe6_pipe_clk),
  .external_en           (1'b0                 ),
  .global_en             (cp0_yy_clk_en        ),
  .local_en              (dp_ex1_pipe6_pipe_en ),
  .module_en             (cp0_vfpu_icg_en      ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

//  &Connect(.clk_in      (forever_cpuclk), @65
//           .external_en (1'b0), @66
//           .global_en   (cp0_yy_clk_en), @67
//           .module_en   (cp0_vfpu_icg_en), @68
//           .local_en    (dp_ex1_pipe6_pipe_en), @69
//           .clk_out     (dp_ex1_pipe6_pipe_clk)); @70

//----------------------------------------------------------
//                    RF/EX1 data pipeline
//----------------------------------------------------------
always @(posedge dp_ex1_pipe6_pipe_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex1_pipe6_opcode[31:0]             <= 32'b0;
    dp_ex1_pipe6_func[19:0]               <= 20'b0;
    dp_ex1_pipe6_iid[6:0]                 <= 7'b0;    
    dp_ex1_pipe6_dst_ereg[4:0]            <= 5'b0;
    dp_ex1_pipe6_dst_preg[6:0]            <= 7'b0;
    dp_ex1_pipe6_dst_preg_dup0[6:0]            <= 7'b0;
    dp_ex1_pipe6_dst_preg_dup1[6:0]            <= 7'b0;
    dp_ex1_pipe6_dst_preg_dup2[6:0]            <= 7'b0;
    dp_ex1_pipe6_dst_preg_dup3[6:0]            <= 7'b0;
    dp_ex1_pipe6_dst_vreg[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe6_dst_vreg_dup0[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe6_dst_vreg_dup1[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe6_dst_vreg_dup2[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe6_mla_srcv2_vreg[VREG-1:0] <= {VREG{1'b0}};
    dp_ex1_pipe6_dste_vld                 <= 1'b0;
    dp_ex1_pipe6_dstv_vld                 <= 1'b0;
//    dp_ex1_pipe6_dst_vld                  <= 1'b0;
    dp_ex1_pipe6_imm0[2:0]                <= 3'b0;
    dp_ex1_pipe6_ready_stage[2:0]         <= 3'b0;
  end
  else if(idu_vfpu_rf_pipe6_gateclk_sel)
  begin
    dp_ex1_pipe6_opcode[31:0]             <= idu_vfpu_rf_pipe6_opcode[31:0];
    dp_ex1_pipe6_func[19:0]               <= idu_vfpu_rf_pipe6_func[19:0];
    dp_ex1_pipe6_iid[6:0]                 <= idu_vfpu_rf_pipe6_iid[6:0];    
    dp_ex1_pipe6_dst_ereg[4:0]            <= idu_vfpu_rf_pipe6_dst_ereg[4:0];
    dp_ex1_pipe6_dst_preg[6:0]            <= idu_vfpu_rf_pipe6_dst_preg[6:0];
    dp_ex1_pipe6_dst_preg_dup0[6:0]            <= idu_vfpu_rf_pipe6_dst_preg[6:0];
    dp_ex1_pipe6_dst_preg_dup1[6:0]            <= idu_vfpu_rf_pipe6_dst_preg[6:0];
    dp_ex1_pipe6_dst_preg_dup2[6:0]            <= idu_vfpu_rf_pipe6_dst_preg[6:0];
    dp_ex1_pipe6_dst_preg_dup3[6:0]            <= idu_vfpu_rf_pipe6_dst_preg[6:0];
    dp_ex1_pipe6_dst_vreg[VREG-1:0]       <= idu_vfpu_rf_pipe6_dst_vreg[VREG-1:0];
    dp_ex1_pipe6_dst_vreg_dup0[VREG-1:0]       <= idu_vfpu_rf_pipe6_dst_vreg[VREG-1:0];
    dp_ex1_pipe6_dst_vreg_dup1[VREG-1:0]       <= idu_vfpu_rf_pipe6_dst_vreg[VREG-1:0];
    dp_ex1_pipe6_dst_vreg_dup2[VREG-1:0]       <= idu_vfpu_rf_pipe6_dst_vreg[VREG-1:0];
    dp_ex1_pipe6_mla_srcv2_vreg[VREG-1:0] <= idu_vfpu_rf_pipe6_mla_srcv2_vreg[VREG-1:0];
    dp_ex1_pipe6_dste_vld                 <= idu_vfpu_rf_pipe6_dste_vld;
    dp_ex1_pipe6_dstv_vld                 <= idu_vfpu_rf_pipe6_dstv_vld;
 //   dp_ex1_pipe6_dst_vld                  <= idu_vfpu_rf_pipe6_dst_vld;
    dp_ex1_pipe6_imm0[2:0]                <= idu_vfpu_rf_pipe6_imm0[2:0];
    dp_ex1_pipe6_ready_stage[2:0]         <= idu_vfpu_rf_pipe6_ready_stage[2:0];
  end
  else if(iu_vfpu_ex1_pipe0_mtvr_vld)     
  begin
    dp_ex1_pipe6_opcode[31:0]             <= dp_ex1_pipe6_opcode[31:0];
    dp_ex1_pipe6_func[19:0]               <= pipe6_mtvr_func[19:0];
    dp_ex1_pipe6_iid[6:0]                 <= dp_ex1_pipe6_iid[6:0];  //no complete     
    dp_ex1_pipe6_dst_ereg[4:0]            <= dp_ex1_pipe6_dst_ereg[4:0];
    dp_ex1_pipe6_dst_preg[6:0]            <= dp_ex1_pipe6_dst_preg[6:0];
    dp_ex1_pipe6_dst_preg_dup0[6:0]            <= dp_ex1_pipe6_dst_preg_dup0[6:0];
    dp_ex1_pipe6_dst_preg_dup1[6:0]            <= dp_ex1_pipe6_dst_preg_dup1[6:0];
    dp_ex1_pipe6_dst_preg_dup2[6:0]            <= dp_ex1_pipe6_dst_preg_dup2[6:0];
    dp_ex1_pipe6_dst_preg_dup3[6:0]            <= dp_ex1_pipe6_dst_preg_dup3[6:0];
    dp_ex1_pipe6_dst_vreg[VREG-1:0]       <= pipe6_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe6_dst_vreg_dup0[VREG-1:0]       <= pipe6_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe6_dst_vreg_dup1[VREG-1:0]       <= pipe6_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe6_dst_vreg_dup2[VREG-1:0]       <= pipe6_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe6_mla_srcv2_vreg[VREG-1:0] <= dp_ex1_pipe6_mla_srcv2_vreg[VREG-1:0];
    dp_ex1_pipe6_dste_vld                 <= 1'b0;
    dp_ex1_pipe6_dstv_vld                 <= 1'b1;
 //   dp_ex1_pipe6_dst_vld                  <= 1'b0;
    dp_ex1_pipe6_imm0[2:0]                <= dp_ex1_pipe6_imm0[2:0];
    dp_ex1_pipe6_ready_stage[2:0]         <= 3'b1;
  end
  else
  begin
    dp_ex1_pipe6_opcode[31:0]             <= dp_ex1_pipe6_opcode[31:0];
    dp_ex1_pipe6_func[19:0]               <= dp_ex1_pipe6_func[19:0];      
    dp_ex1_pipe6_iid[6:0]                 <= dp_ex1_pipe6_iid[6:0];     
    dp_ex1_pipe6_dst_ereg[4:0]            <= dp_ex1_pipe6_dst_ereg[4:0];           
    dp_ex1_pipe6_dst_preg[6:0]            <= dp_ex1_pipe6_dst_preg[6:0];           
    dp_ex1_pipe6_dst_preg_dup0[6:0]            <= dp_ex1_pipe6_dst_preg_dup0[6:0];           
    dp_ex1_pipe6_dst_preg_dup1[6:0]            <= dp_ex1_pipe6_dst_preg_dup1[6:0];           
    dp_ex1_pipe6_dst_preg_dup2[6:0]            <= dp_ex1_pipe6_dst_preg_dup2[6:0];           
    dp_ex1_pipe6_dst_preg_dup3[6:0]            <= dp_ex1_pipe6_dst_preg_dup3[6:0];           
    dp_ex1_pipe6_dst_vreg[VREG-1:0]       <= dp_ex1_pipe6_dst_vreg[VREG-1:0];           
    dp_ex1_pipe6_dst_vreg_dup0[VREG-1:0]       <= dp_ex1_pipe6_dst_vreg_dup0[VREG-1:0];           
    dp_ex1_pipe6_dst_vreg_dup1[VREG-1:0]       <= dp_ex1_pipe6_dst_vreg_dup1[VREG-1:0];           
    dp_ex1_pipe6_dst_vreg_dup2[VREG-1:0]       <= dp_ex1_pipe6_dst_vreg_dup2[VREG-1:0];           
    dp_ex1_pipe6_mla_srcv2_vreg[VREG-1:0] <= dp_ex1_pipe6_mla_srcv2_vreg[VREG-1:0];     
    dp_ex1_pipe6_dste_vld                 <= dp_ex1_pipe6_dste_vld;                
    dp_ex1_pipe6_dstv_vld                 <= dp_ex1_pipe6_dstv_vld;                
 //   dp_ex1_pipe6_dst_vld                  <= dp_ex1_pipe6_dst_vld;                 
    dp_ex1_pipe6_imm0[2:0]                <= dp_ex1_pipe6_imm0[2:0];
    dp_ex1_pipe6_ready_stage[2:0]         <= dp_ex1_pipe6_ready_stage[2:0];
  end
end

//assign dp_ctrl_ex1_pipe6_dst_vld    = dp_ex1_pipe6_dst_vld;
// &CombBeg; @164
always @( idu_vfpu_rf_pipe6_gateclk_sel
       or idu_vfpu_rf_pipe6_dst_vld
       or iu_vfpu_ex1_pipe0_mtvr_vld)
begin
 if(idu_vfpu_rf_pipe6_gateclk_sel)
   dp_ex1_pipe6_dst_vld_pre  = idu_vfpu_rf_pipe6_dst_vld;
 else if(iu_vfpu_ex1_pipe0_mtvr_vld)
    dp_ex1_pipe6_dst_vld_pre  = 1'b0;
 else 
    dp_ex1_pipe6_dst_vld_pre  = idu_vfpu_rf_pipe6_dst_vld;
// &CombEnd; @171
end
assign dp_ctrl_pipe6_vfdsu_inst_vld = pipe6_dp_vfdsu_inst_vld;
//----------------------------------------------------------
//                    EX1 MFCR Inst
//----------------------------------------------------------
assign vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup0 = ctrl_ex1_pipe6_mfvr_inst_vld;
assign vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup1 = ctrl_ex1_pipe6_mfvr_inst_vld_dup0;
assign vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup2 = ctrl_ex1_pipe6_mfvr_inst_vld_dup1;
assign vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup3 = ctrl_ex1_pipe6_mfvr_inst_vld_dup2;
assign vfpu_idu_ex1_pipe6_mfvr_inst_vld_dup4 = ctrl_ex1_pipe6_mfvr_inst_vld_dup3;
assign vfpu_idu_ex1_pipe6_preg_dup0[6:0]     = dp_ex1_pipe6_dst_preg[6:0];
assign vfpu_idu_ex1_pipe6_preg_dup1[6:0]     = dp_ex1_pipe6_dst_preg_dup0[6:0];
assign vfpu_idu_ex1_pipe6_preg_dup2[6:0]     = dp_ex1_pipe6_dst_preg_dup1[6:0];
assign vfpu_idu_ex1_pipe6_preg_dup3[6:0]     = dp_ex1_pipe6_dst_preg_dup2[6:0];
assign vfpu_idu_ex1_pipe6_preg_dup4[6:0]     = dp_ex1_pipe6_dst_preg_dup3[6:0];

//----------------------------------------------------------
//                    EX2 data preparation
//----------------------------------------------------------
assign dp_ex1_pipe6_mfvr_data[XLEN-1:0] = ex1_pipe6_eu_sel_vec_mtvr 
                                        ? vdsp_vfpu_ex1_pipe6_mfvr_data[XLEN-1:0]
                                        : pipe6_dp_ex1_vfalu_mfvr_data[XLEN-1:0];
//select singal rebuild
//bit0: FALU
//bit1: FDSU/VDIV no data 
//bit2: FMAU
//bit3: VDSP
//bit4: FDSU/VDIV return data
assign  dp_ex2_pipe6_eu_sel_pre[0]  = |ctrl_ex1_pipe6_eu_sel[2:0];
assign  dp_ex2_pipe6_eu_sel_pre[1]  = ctrl_ex1_pipe6_eu_sel[3] || ctrl_ex1_pipe6_eu_sel[11];
assign  dp_ex2_pipe6_eu_sel_pre[2]  = ctrl_ex1_pipe6_eu_sel[4];
assign  dp_ex2_pipe6_eu_sel_pre[3]  = |ctrl_ex1_pipe6_eu_sel[10:5];
assign  dp_ex2_pipe6_eu_sel_pre[4]  =  pipe6_dp_vfdsu_inst_vld|| vdivu_vfpu_ex1_pipe6_result_vld;

assign dp_ex2_pipe6_dst_vreg_pre[VREG-1:0] = pipe6_dp_vfdsu_inst_vld 
                                           ? pipe6_dp_vfdsu_vreg[VREG-1:0]
                                           : (vdivu_vfpu_ex1_pipe6_result_vld 
                                             ? vdivu_vfpu_ex1_pipe6_dst_vreg[VREG-1:0]
                                             : dp_ex1_pipe6_dst_vreg[VREG-1:0]);
assign dp_ex2_pipe6_ready_stage_pre[2:0] = (pipe6_dp_vfdsu_inst_vld || vdivu_vfpu_ex1_pipe6_result_vld) 
                                         ? 3'b001
                                         : (pipe6_dp_ex1_mult_id)
                                           ? 3'b100
                                           : dp_ex1_pipe6_ready_stage[2:0];

assign dp_ex2_pipe6_dst_ereg_pre[4:0] = pipe6_dp_vfdsu_inst_vld 
                                      ? pipe6_dp_vfdsu_ereg[4:0] 
                                      : dp_ex1_pipe6_dst_ereg[4:0];
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign dp_ex2_pipe6_en =  ctrl_ex1_pipe6_inst_vld 
                       || pipe6_dp_vfdsu_inst_vld
                       || vdivu_vfpu_ex1_pipe6_result_vld;

// &Instance("gated_clk_cell", "x_dp_ex2_pipe6_gated_clk"); @226
gated_clk_cell  x_dp_ex2_pipe6_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_ex2_pipe6_clk  ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_ex2_pipe6_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @227
//          .external_en (1'b0), @228
//          .global_en   (cp0_yy_clk_en), @229
//          .module_en   (cp0_vfpu_icg_en), @230
//          .local_en    (dp_ex2_pipe6_en), @231
//          .clk_out     (dp_ex2_pipe6_clk)); @232

//----------------------------------------------------------
//                 Pipe6 EX1/EX2 Pipeline
//----------------------------------------------------------
always @(posedge dp_ex2_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex2_pipe6_eu_sel[4:0]           <= 5'b0;
    dp_ex2_pipe6_ready_stage[2:0]      <= 3'b0;
    dp_ex2_pipe6_dst_ereg[4:0]         <= 5'b0;
    dp_ex2_pipe6_dst_vreg[VREG-1:0]    <= {VREG{1'b0}};
    dp_ex2_pipe6_dst_vreg_dup0[VREG-1:0]    <= {VREG{1'b0}};
    dp_ex2_pipe6_dst_vreg_dup1[VREG-1:0]    <= {VREG{1'b0}};
    dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0]    <= {VREG{1'b0}};
    dp_ex2_pipe6_dst_preg[6:0]         <= 7'b0;
    dp_ex2_pipe6_dstv_vld              <= 1'b0;
    dp_ex2_pipe6_dste_vld              <= 1'b0;
    dp_ex2_pipe6_mfvr_data[63:0]       <= 64'b0;
  end
  else if(ctrl_ex1_pipe6_inst_vld || pipe6_dp_vfdsu_inst_vld || vdivu_vfpu_ex1_pipe6_result_vld)
  begin
    dp_ex2_pipe6_eu_sel[4:0]           <= dp_ex2_pipe6_eu_sel_pre[4:0];
    dp_ex2_pipe6_ready_stage[2:0]      <= dp_ex2_pipe6_ready_stage_pre[2:0];
    dp_ex2_pipe6_dst_ereg[4:0]         <= dp_ex2_pipe6_dst_ereg_pre[4:0];  
    dp_ex2_pipe6_dst_vreg[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_pre[VREG-1:0];  
    dp_ex2_pipe6_dst_vreg_dup0[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_pre[VREG-1:0];  
    dp_ex2_pipe6_dst_vreg_dup1[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_pre[VREG-1:0];  
    dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_pre[VREG-1:0];  
    dp_ex2_pipe6_dst_preg[6:0]         <= dp_ex1_pipe6_dst_preg[6:0];  
    dp_ex2_pipe6_dstv_vld              <= dp_ex1_pipe6_dstv_vld || pipe6_dp_vfdsu_inst_vld || vdivu_vfpu_ex1_pipe6_result_vld;
    dp_ex2_pipe6_dste_vld              <= dp_ex1_pipe6_dste_vld && !vdivu_vfpu_ex1_pipe6_result_vld || pipe6_dp_vfdsu_inst_vld;
    dp_ex2_pipe6_mfvr_data[63:0]       <= dp_ex1_pipe6_mfvr_data[63:0];
  end
  else
  begin
    dp_ex2_pipe6_eu_sel[4:0]           <= dp_ex2_pipe6_eu_sel[4:0];
    dp_ex2_pipe6_ready_stage[2:0]      <= dp_ex2_pipe6_ready_stage[2:0];
    dp_ex2_pipe6_dst_ereg[4:0]         <= dp_ex2_pipe6_dst_ereg[4:0];  
    dp_ex2_pipe6_dst_vreg[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg[VREG-1:0];  
    dp_ex2_pipe6_dst_vreg_dup0[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_dup0[VREG-1:0];  
    dp_ex2_pipe6_dst_vreg_dup1[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_dup1[VREG-1:0];  
    dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0]    <= dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0];  
    dp_ex2_pipe6_dst_preg[6:0]         <= dp_ex2_pipe6_dst_preg[6:0];  
    dp_ex2_pipe6_dste_vld              <= dp_ex2_pipe6_dste_vld;
    dp_ex2_pipe6_mfvr_data[63:0]       <= dp_ex2_pipe6_mfvr_data[63:0];
  end
end

always @(posedge dp_ex2_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dp_ex2_pipe6_freg_data[63:0] <= 64'b0;
  else if(pipe6_dp_vfdsu_inst_vld && !pipe6_dp_vfdsu_vreg[VREG-1])
    dp_ex2_pipe6_freg_data[63:0] <= pipe6_dp_vfdsu_freg_data[63:0];
  else
    dp_ex2_pipe6_freg_data[63:0] <= dp_ex2_pipe6_freg_data[63:0];
end

always @(posedge dp_ex2_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dp_ex2_pipe6_ereg_data[4:0] <= 5'b0;
  else if(pipe6_dp_vfdsu_inst_vld)
    dp_ex2_pipe6_ereg_data[4 :0] <= pipe6_dp_vfdsu_ereg_data[4 :0];
  else if(ctrl_ex1_pipe6_inst_vld && dp_ex1_pipe6_dste_vld && dp_ex2_pipe6_eu_sel_pre[3])
    dp_ex2_pipe6_ereg_data[4 :0] <= 5'b0;
  else
    dp_ex2_pipe6_ereg_data[4 :0] <= dp_ex2_pipe6_ereg_data[4 :0];
end
//----------------------------------------------------------
//                    MFCR Data Output
//----------------------------------------------------------
assign vfpu_iu_ex2_pipe6_mfvr_data_vld       = ctrl_ex2_pipe6_mfvr_inst_vld;
assign vfpu_iu_ex2_pipe6_mfvr_data[XLEN-1:0] = dp_ex2_pipe6_mfvr_data[XLEN-1:0];
assign vfpu_iu_ex2_pipe6_mfvr_preg[6:0]      = dp_ex2_pipe6_dst_preg[6:0];

//----------------------------------------------------------
//                    EX3 data preparation
//----------------------------------------------------------
//forward valid signal
assign dp_ex3_pipe6_vreg_fwd_vld_pre  = dp_ex2_pipe6_ready_stage[0] && 
                                        dp_ex2_pipe6_dstv_vld;

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign dp_ex3_pipe6_en =  ctrl_ex2_pipe6_inst_vld;
//  &Instance("gated_clk_cell", "x_dp_ex3_pipe6_gated_clk"); @321
gated_clk_cell  x_dp_ex3_pipe6_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_ex3_pipe6_clk  ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_ex3_pipe6_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

//  &Connect(.clk_in      (forever_cpuclk), @322
//           .external_en (1'b0), @323
//           .global_en   (cp0_yy_clk_en), @324
//           .module_en   (cp0_vfpu_icg_en), @325
//           .local_en    (dp_ex3_pipe6_en), @326
//           .clk_out     (dp_ex3_pipe6_clk)); @327

//----------------------------------------------------------
//                 Pipe6 EX2/EX3 Data Pipeline
//----------------------------------------------------------
always @(posedge dp_ex3_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex3_pipe6_eu_sel[4:0]        <= 5'b0; 
    dp_ex3_pipe6_ready_stage[2:0]   <= 3'b0;
    dp_ex3_pipe6_dst_ereg[4:0]      <= 5'b0;
    dp_ex3_pipe6_dst_vreg[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe6_dst_vreg_dup0[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe6_dst_vreg_dup1[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe6_dst_vreg_dup2[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe6_dst_vreg_dup3[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe6_dstv_vld           <= 1'b0;
    dp_ex3_pipe6_dste_vld           <= 1'b0;
    dp_ex3_pipe6_vreg_fwd_vld       <= 1'b0;
  end
  else if(ctrl_ex2_pipe6_inst_vld)
  begin
    dp_ex3_pipe6_eu_sel[4:0]        <= dp_ex2_pipe6_eu_sel[4:0];
    dp_ex3_pipe6_ready_stage[2:0]   <= dp_ex2_pipe6_ready_stage[2:0];
    dp_ex3_pipe6_dst_ereg[4:0]      <= dp_ex2_pipe6_dst_ereg[4:0];  
    dp_ex3_pipe6_dst_vreg[VREG-1:0] <= dp_ex2_pipe6_dst_vreg[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup0[VREG-1:0] <= dp_ex2_pipe6_dst_vreg_dup0[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup1[VREG-1:0] <= dp_ex2_pipe6_dst_vreg_dup1[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup2[VREG-1:0] <= dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup3[VREG-1:0] <= dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0];  
    dp_ex3_pipe6_dstv_vld           <= dp_ex2_pipe6_dstv_vld;
    dp_ex3_pipe6_dste_vld           <= dp_ex2_pipe6_dste_vld;
    dp_ex3_pipe6_vreg_fwd_vld       <= dp_ex3_pipe6_vreg_fwd_vld_pre;
  end
  else
  begin
    dp_ex3_pipe6_eu_sel[4:0]        <= dp_ex3_pipe6_eu_sel[4:0];
    dp_ex3_pipe6_ready_stage[2:0]   <= dp_ex3_pipe6_ready_stage[2:0];
    dp_ex3_pipe6_dst_ereg[4:0]      <= dp_ex3_pipe6_dst_ereg[4:0];  
    dp_ex3_pipe6_dst_vreg[VREG-1:0] <= dp_ex3_pipe6_dst_vreg[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup0[VREG-1:0] <= dp_ex3_pipe6_dst_vreg_dup0[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup1[VREG-1:0] <= dp_ex3_pipe6_dst_vreg_dup1[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup2[VREG-1:0] <= dp_ex3_pipe6_dst_vreg_dup2[VREG-1:0];  
    dp_ex3_pipe6_dst_vreg_dup3[VREG-1:0] <= dp_ex3_pipe6_dst_vreg_dup3[VREG-1:0];  
    dp_ex3_pipe6_dstv_vld           <= dp_ex3_pipe6_dstv_vld;
    dp_ex3_pipe6_dste_vld           <= dp_ex3_pipe6_dste_vld;
    dp_ex3_pipe6_vreg_fwd_vld       <= dp_ex3_pipe6_vreg_fwd_vld;
  end
end
always @(posedge dp_ex3_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dp_ex3_pipe6_freg_data_raw[63:0] <= 64'b0;
  else if(ctrl_ex2_pipe6_inst_vld && dp_ex2_pipe6_eu_sel[4] && !dp_ex2_pipe6_dst_vreg[VREG-1])
    dp_ex3_pipe6_freg_data_raw[63:0] <= dp_ex2_pipe6_freg_data[63:0];
  else
    dp_ex3_pipe6_freg_data_raw[63:0] <= dp_ex3_pipe6_freg_data_raw[63:0];
end

always @(posedge dp_ex3_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    dp_ex3_pipe6_ereg_data_raw[4:0] <= 5'b0;
  else if(ctrl_ex2_pipe6_inst_vld && dp_ex2_pipe6_dste_vld)
    dp_ex3_pipe6_ereg_data_raw[4:0] <= dp_ex2_pipe6_ereg_data[4 :0];
  else
    dp_ex3_pipe6_ereg_data_raw[4:0] <= dp_ex3_pipe6_ereg_data_raw[4 :0];
end

// &Force("output","dp_ex3_pipe6_dst_vreg"); @397
// &Force("output","dp_ex3_pipe6_freg_data"); @398

// &CombBeg; @400
always @( dp_ex3_pipe6_eu_sel[0]
       or pipe6_dp_ex3_vfmau_freg_data[63:0]
       or pipe6_dp_ex3_vfalu_freg_data[63:0]
       or dp_ex3_pipe6_freg_data_raw[63:0]
       or dp_ex3_pipe6_eu_sel[2])
begin
case({dp_ex3_pipe6_eu_sel[2],dp_ex3_pipe6_eu_sel[0]})
  2'b10  : dp_ex3_pipe6_freg_data[FPR_MSB:0] = pipe6_dp_ex3_vfmau_freg_data[FPR_MSB:0];
  2'b01  : dp_ex3_pipe6_freg_data[FPR_MSB:0] = pipe6_dp_ex3_vfalu_freg_data[FPR_MSB:0];
  default: dp_ex3_pipe6_freg_data[FPR_MSB:0] = dp_ex3_pipe6_freg_data_raw[FPR_MSB:0];
endcase
// &CombEnd; @406
end

// &CombBeg; @408
always @( dp_ex3_pipe6_ereg_data_raw[4:0]
       or pipe6_dp_ex3_vfmau_ereg_data[4:0]
       or dp_ex3_pipe6_eu_sel[0]
       or dp_ex3_pipe6_eu_sel[2]
       or pipe6_dp_ex3_vfalu_ereg_data[4:0])
begin
case({dp_ex3_pipe6_eu_sel[2],dp_ex3_pipe6_eu_sel[0]})
  2'b10  : dp_ex3_pipe6_ereg_data[4:0] = pipe6_dp_ex3_vfmau_ereg_data[4:0];
  2'b01  : dp_ex3_pipe6_ereg_data[4:0] = pipe6_dp_ex3_vfalu_ereg_data[4:0];
  default: dp_ex3_pipe6_ereg_data[4:0] = dp_ex3_pipe6_ereg_data_raw[4:0];
endcase
// &CombEnd; @414
end

//----------------------------------------------------------
//                    EX4 data preparation
//----------------------------------------------------------
//forward valid signal
assign dp_ex4_pipe6_vreg_fwd_vld_pre  = dp_ex3_pipe6_vreg_fwd_vld
                                     || dp_ex3_pipe6_ready_stage[1] && dp_ex3_pipe6_dstv_vld;
                                    
//forward data seletion
//bit0: Ex3 data
//bit1: Ex4 FMA data
assign dp_ex4_pipe6_wb_vld_pre[0] =!dp_ex3_pipe6_ready_stage[1] && dp_ex3_pipe6_dstv_vld;
assign dp_ex4_pipe6_wb_vld_pre[1] = dp_ex3_pipe6_ready_stage[1] && dp_ex3_pipe6_eu_sel[2]
                                 && dp_ex3_pipe6_dstv_vld;

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign dp_ex4_pipe6_en =  ctrl_ex3_pipe6_inst_vld;
//  &Instance("gated_clk_cell", "x_dp_ex4_pipe6_gated_clk"); @434
gated_clk_cell  x_dp_ex4_pipe6_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_ex4_pipe6_clk  ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_ex4_pipe6_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

//  &Connect(.clk_in      (forever_cpuclk), @435
//           .external_en (1'b0), @436
//           .global_en   (cp0_yy_clk_en), @437
//           .module_en   (cp0_vfpu_icg_en), @438
//           .local_en    (dp_ex4_pipe6_en), @439
//           .clk_out     (dp_ex4_pipe6_clk)); @440

//----------------------------------------------------------
//                 Pipe6 EX3/EX4 Data Pipeline
//----------------------------------------------------------
always @(posedge dp_ex4_pipe6_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex4_pipe6_eu_sel[3:0]          <= 4'b0;
    dp_ex4_pipe6_ready_stage[2:0]     <= 3'b0;
    dp_ex4_pipe6_dst_ereg[4:0]        <= 5'b0;
    dp_ex4_pipe6_dst_vreg[VREG-1:0]   <= {VREG{1'b0}};
    dp_ex4_pipe6_dstv_vld             <= 1'b0;
    dp_ex4_pipe6_dste_vld             <= 1'b0;
    dp_ex4_pipe6_vreg_fwd_vld         <= 1'b0;
    dp_ex4_pipe6_freg_data[FPR_MSB:0] <= {FPR_MSB+1{1'b0}};
    dp_ex4_pipe6_ereg_data[4:0]       <= 5'b0;
    dp_ex4_pipe6_wb_vld[1:0]          <= 2'b0;
  end
  else if(ctrl_ex3_pipe6_inst_vld)
  begin
    dp_ex4_pipe6_eu_sel[3:0]          <= dp_ex3_pipe6_eu_sel[3:0];
    dp_ex4_pipe6_ready_stage[2:0]     <= dp_ex3_pipe6_ready_stage[2:0];
    dp_ex4_pipe6_dst_ereg[4:0]        <= dp_ex3_pipe6_dst_ereg[4:0];  
    dp_ex4_pipe6_dst_vreg[VREG-1:0]   <= dp_ex3_pipe6_dst_vreg[VREG-1:0];  
    dp_ex4_pipe6_dstv_vld             <= dp_ex3_pipe6_dstv_vld;
    dp_ex4_pipe6_dste_vld             <= dp_ex3_pipe6_dste_vld;
    dp_ex4_pipe6_vreg_fwd_vld         <= dp_ex4_pipe6_vreg_fwd_vld_pre;
    dp_ex4_pipe6_freg_data[FPR_MSB:0] <= dp_ex3_pipe6_freg_data[FPR_MSB:0];
    dp_ex4_pipe6_ereg_data[4:0]       <= dp_ex3_pipe6_ereg_data[4:0];
    dp_ex4_pipe6_wb_vld[1:0]          <= dp_ex4_pipe6_wb_vld_pre[1:0];
  end
  else 
  begin
    dp_ex4_pipe6_eu_sel[3:0]          <= dp_ex4_pipe6_eu_sel[3:0];
    dp_ex4_pipe6_ready_stage[2:0]     <= dp_ex4_pipe6_ready_stage[2:0];
    dp_ex4_pipe6_dst_ereg[4:0]        <= dp_ex4_pipe6_dst_ereg[4:0];  
    dp_ex4_pipe6_dst_vreg[VREG-1:0]   <= dp_ex4_pipe6_dst_vreg[VREG-1:0];  
    dp_ex4_pipe6_dstv_vld             <= dp_ex4_pipe6_dstv_vld;
    dp_ex4_pipe6_dste_vld             <= dp_ex4_pipe6_dste_vld;
    dp_ex4_pipe6_vreg_fwd_vld         <= dp_ex4_pipe6_vreg_fwd_vld;
    dp_ex4_pipe6_freg_data[FPR_MSB:0] <= dp_ex4_pipe6_freg_data[FPR_MSB:0];
    dp_ex4_pipe6_ereg_data[4:0]       <= dp_ex4_pipe6_ereg_data[4:0];
    dp_ex4_pipe6_wb_vld[1:0]          <= dp_ex4_pipe6_wb_vld[1:0];
  end
end

// &Force("output","dp_ex4_pipe6_dst_ereg"); @488
// &Force("output","dp_ex4_pipe6_dst_vreg"); @489

//----------------------------------------------------------
//                    EX5 data preparation
//----------------------------------------------------------
assign pipe6_dp_ex4_vfalu_ereg_data[4:0] = 5'b0;
assign dp_ex5_pipe6_freg_data_pre[FPR_MSB:0] = (dp_ex4_pipe6_wb_vld[1])
                                             ? pipe6_dp_ex4_vfmau_freg_data[FPR_MSB:0]
                                             : dp_ex4_pipe6_freg_data[FPR_MSB:0];

assign dp_ex4_pipe6_ereg_sel[0] = dp_ex4_pipe6_eu_sel[0] && dp_ex4_pipe6_ready_stage[1];
assign dp_ex4_pipe6_ereg_sel[1] = dp_ex4_pipe6_eu_sel[2] && dp_ex4_pipe6_ready_stage[1];

assign dp_ex4_pipe6_ereg_data_new[4:0] = dp_ex4_pipe6_ereg_sel[1] 
                                       ? pipe6_dp_ex4_vfmau_ereg_data[4:0]
                                       : pipe6_dp_ex4_vfalu_ereg_data[4:0];

assign dp_ex5_pipe6_ereg_data_pre[4:0] = (|dp_ex4_pipe6_ereg_sel[1:0])
                                       ? dp_ex4_pipe6_ereg_data_new[4:0]
                                       : dp_ex4_pipe6_ereg_data[4:0];

// &Force("output","dp_ex5_pipe6_freg_data_pre"); @513
// &Force("output","dp_ex5_pipe6_ereg_data_pre"); @514

assign dp_ex4_pipe6_normal_dstv_wb_vld = ctrl_ex4_pipe6_inst_vld 
                                      && dp_ex4_pipe6_dstv_vld
                                      && !dp_ex4_pipe6_eu_sel[1];  //not vfdsu
assign dp_ex4_pipe6_normal_dste_wb_vld = ctrl_ex4_pipe6_inst_vld 
                                      && dp_ex4_pipe6_dste_vld
                                      && !dp_ex4_pipe6_eu_sel[1];

//==========================================================
//                 Instruction Dispatch
//==========================================================
//----------------------------------------------------------
//                     Pipe6 FALU 
//----------------------------------------------------------
assign dp_vfalu_ex1_pipe6_sel[2:0]         = {1'b0,ctrl_ex1_pipe6_eu_sel[1:0]};
assign dp_vfalu_ex1_pipe6_func[19:0]       = dp_ex1_pipe6_func[19:0];
assign dp_vfalu_ex1_pipe6_imm0[2:0]        = dp_ex1_pipe6_imm0[2:0];
assign dp_vfalu_ex1_pipe6_mtvr_src0[63:0]  = iu_vfpu_ex2_pipe0_mtvr_src0[63:0];
//----------------------------------------------------------
//                    Pipe6 VFDSU
//----------------------------------------------------------
assign dp_vfdsu_ex1_pipe6_sel                = ctrl_ex1_pipe6_eu_sel[3];
assign dp_vfdsu_ex1_pipe6_iid[6:0]           = dp_ex1_pipe6_iid[6:0];
assign dp_vfdsu_ex1_pipe6_dst_vreg[VREG-1:0] = dp_ex1_pipe6_dst_vreg[VREG-1:0];
assign dp_vfdsu_ex1_pipe6_dst_ereg[4:0]      = dp_ex1_pipe6_dst_ereg[4:0];
assign dp_vfdsu_ex1_pipe6_imm0[2:0]          = dp_ex1_pipe6_imm0[2:0];
assign dp_vfdsu_fdiv_gateclk_issue           = idu_vfpu_is_vdiv_gateclk_issue;
assign dp_vfdsu_idu_fdiv_issue               = idu_vfpu_is_vdiv_issue;

//----------------------------------------------------------
//                    Pipe6 VFMAU
//----------------------------------------------------------
assign dp_vfmau_ex1_pipe6_sel                  = ctrl_ex1_pipe6_eu_sel[4];
assign dp_vfmau_ex1_pipe6_imm0[2:0]            = dp_ex1_pipe6_imm0[2:0];
assign dp_vfmau_ex1_pipe6_dst_vreg[VREG-1:0]   = dp_ex1_pipe6_dst_vreg[VREG-1:0];
assign dp_vfmau_pipe6_mla_srcv2_vreg[VREG-1:0] = idu_vfpu_rf_pipe6_mla_srcv2_vreg[VREG-1:0];
assign dp_vfmau_pipe6_mla_srcv2_vld            = idu_vfpu_rf_pipe6_mla_srcv2_vld;
assign dp_vfmau_pipe6_mla_type[2:0]            = idu_vfpu_rf_pipe6_vmla_type[2:0];
assign dp_vfmau_pipe6_inst_type[5:0]           = idu_vfpu_rf_pipe6_inst_type[5:0];
assign dp_vfmau_pipe6_vfmau_sel                = idu_vfpu_rf_pipe6_eu_sel[4];
assign dp_vfmau_pipe6_sel                      = idu_vfpu_rf_pipe6_gateclk_sel;

//==========================================================
//                  Result Bus
//==========================================================
assign dp_ctrl_ex1_pipe6_data_vld_pre = idu_vfpu_rf_pipe6_gateclk_sel && idu_vfpu_rf_pipe6_dstv_vld && idu_vfpu_rf_pipe6_ready_stage[0];
assign dp_ctrl_ex2_pipe6_data_vld_pre = dp_ex1_pipe6_dstv_vld && dp_ex1_pipe6_ready_stage[1] && !pipe6_dp_ex1_mult_id;
assign dp_ctrl_ex3_pipe6_data_vld_pre = dp_ex2_pipe6_dstv_vld && dp_ex2_pipe6_ready_stage[2];

assign dp_ctrl_ex3_pipe6_fwd_vld_pre  = dp_ex3_pipe6_vreg_fwd_vld_pre;
assign dp_ctrl_ex4_pipe6_fwd_vld_pre  = dp_ex4_pipe6_vreg_fwd_vld_pre;

assign dp_rbus_pipe6_ex1_vreg[VREG-1:0] = dp_ex1_pipe6_dst_vreg[VREG-1:0];
assign dp_rbus_pipe6_ex1_vreg_dup0[VREG-1:0] = dp_ex1_pipe6_dst_vreg_dup0[VREG-1:0];
assign dp_rbus_pipe6_ex1_vreg_dup1[VREG-1:0] = dp_ex1_pipe6_dst_vreg_dup1[VREG-1:0];
assign dp_rbus_pipe6_ex1_vreg_dup2[VREG-1:0] = dp_ex1_pipe6_dst_vreg_dup2[VREG-1:0];
assign dp_rbus_pipe6_ex2_vreg[VREG-1:0] = dp_ex2_pipe6_dst_vreg[VREG-1:0];                                   
assign dp_rbus_pipe6_ex2_vreg_dup0[VREG-1:0] = dp_ex2_pipe6_dst_vreg_dup0[VREG-1:0];                                   
assign dp_rbus_pipe6_ex2_vreg_dup1[VREG-1:0] = dp_ex2_pipe6_dst_vreg_dup1[VREG-1:0];                                   
assign dp_rbus_pipe6_ex2_vreg_dup2[VREG-1:0] = dp_ex2_pipe6_dst_vreg_dup2[VREG-1:0];                                   
assign dp_rbus_pipe6_ex3_vreg_dup0[VREG-1:0] = dp_ex3_pipe6_dst_vreg_dup0[VREG-1:0];
assign dp_rbus_pipe6_ex3_vreg_dup1[VREG-1:0] = dp_ex3_pipe6_dst_vreg_dup1[VREG-1:0];
assign dp_rbus_pipe6_ex3_vreg_dup2[VREG-1:0] = dp_ex3_pipe6_dst_vreg_dup2[VREG-1:0];
assign dp_rbus_pipe6_ex3_vreg_dup3[VREG-1:0] = dp_ex3_pipe6_dst_vreg_dup3[VREG-1:0];

assign vfpu_idu_vdiv_wb_stall = vdivu_vfpu_pipe6_req_for_bubble || vfdsu_dp_inst_wb_req;
assign vfpu_idu_vdiv_busy     = vdivu_vfpu_pipe6_vdiv_busy || vfdsu_dp_fdiv_busy;

//==========================================================
//                 Pipe7 Instrcution Data
//==========================================================
//----------------------------------------------------------
//                    EX1 data preparation
//----------------------------------------------------------
assign pipe7_mtvr_func[19:0]     = 
    {20{iu_vfpu_ex1_pipe1_mtvr_inst[4]}} & 20'b0010_0000_0000_0010_0001   //half
  | {20{iu_vfpu_ex1_pipe1_mtvr_inst[0]}} & 20'b0010_1000_0000_0010_0001   //single
  | {20{iu_vfpu_ex1_pipe1_mtvr_inst[1]}} & 20'b0011_0000_0000_0010_0001   //double
  | {20{iu_vfpu_ex1_pipe1_mtvr_inst[2]}} & 20'b0000_0000_0000_0010_0100   //vmove to element 0
  | {20{iu_vfpu_ex1_pipe1_mtvr_inst[3]}} & 20'b0000_0000_0000_0100_0100;  //vcopy to all elements

assign pipe7_mtvr_vreg[VREG-1:0] = iu_vfpu_ex1_pipe1_mtvr_vreg[VREG-1:0];

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
 assign dp_ex1_pipe7_pipe_en = idu_vfpu_rf_pipe7_gateclk_sel
                            || iu_vfpu_ex1_pipe1_mtvr_vld;
//  &Instance("gated_clk_cell", "x_dp_ex1_pipe7_pipe_gated_clk"); @617
gated_clk_cell  x_dp_ex1_pipe7_pipe_gated_clk (
  .clk_in                (forever_cpuclk       ),
  .clk_out               (dp_ex1_pipe7_pipe_clk),
  .external_en           (1'b0                 ),
  .global_en             (cp0_yy_clk_en        ),
  .local_en              (dp_ex1_pipe7_pipe_en ),
  .module_en             (cp0_vfpu_icg_en      ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

//  &Connect(.clk_in      (forever_cpuclk), @618
//           .external_en (1'b0), @619
//           .global_en   (cp0_yy_clk_en), @620
//           .module_en   (cp0_vfpu_icg_en), @621
//           .local_en    (dp_ex1_pipe7_pipe_en), @622
//           .clk_out     (dp_ex1_pipe7_pipe_clk)); @623

//----------------------------------------------------------
//                    RF/EX1 data pipeline
//----------------------------------------------------------
always @(posedge dp_ex1_pipe7_pipe_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex1_pipe7_opcode[31:0]             <= 32'b0;
    dp_ex1_pipe7_func[19:0]               <= 20'b0;
    dp_ex1_pipe7_dst_ereg[4:0]            <= 5'b0;
    dp_ex1_pipe7_dst_preg[6:0]            <= 7'b0;
    dp_ex1_pipe7_dst_preg_dup0[6:0]            <= 7'b0;
    dp_ex1_pipe7_dst_preg_dup1[6:0]            <= 7'b0;
    dp_ex1_pipe7_dst_preg_dup2[6:0]            <= 7'b0;
    dp_ex1_pipe7_dst_preg_dup3[6:0]            <= 7'b0;
    dp_ex1_pipe7_dst_vreg[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0]       <= {VREG{1'b0}};
    dp_ex1_pipe7_mla_srcv2_vreg[VREG-1:0] <= {VREG{1'b0}};
    dp_ex1_pipe7_dste_vld                 <= 1'b0;
    dp_ex1_pipe7_dstv_vld                 <= 1'b0;
//    dp_ex1_pipe7_dst_vld                  <= 1'b0;
    dp_ex1_pipe7_imm0[2:0]                <= 3'b0;
    dp_ex1_pipe7_ready_stage[2:0]         <= 3'b0;
  end
  else if(idu_vfpu_rf_pipe7_gateclk_sel)
  begin
    dp_ex1_pipe7_opcode[31:0]             <= idu_vfpu_rf_pipe7_opcode[31:0];
    dp_ex1_pipe7_func[19:0]               <= idu_vfpu_rf_pipe7_func[19:0];
    dp_ex1_pipe7_dst_ereg[4:0]            <= idu_vfpu_rf_pipe7_dst_ereg[4:0];
    dp_ex1_pipe7_dst_preg[6:0]            <= idu_vfpu_rf_pipe7_dst_preg[6:0];
    dp_ex1_pipe7_dst_preg_dup0[6:0]            <= idu_vfpu_rf_pipe7_dst_preg[6:0];
    dp_ex1_pipe7_dst_preg_dup1[6:0]            <= idu_vfpu_rf_pipe7_dst_preg[6:0];
    dp_ex1_pipe7_dst_preg_dup2[6:0]            <= idu_vfpu_rf_pipe7_dst_preg[6:0];
    dp_ex1_pipe7_dst_preg_dup3[6:0]            <= idu_vfpu_rf_pipe7_dst_preg[6:0];
    dp_ex1_pipe7_dst_vreg[VREG-1:0]       <= idu_vfpu_rf_pipe7_dst_vreg[VREG-1:0];
    dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0]       <= idu_vfpu_rf_pipe7_dst_vreg[VREG-1:0];
    dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0]       <= idu_vfpu_rf_pipe7_dst_vreg[VREG-1:0];
    dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0]       <= idu_vfpu_rf_pipe7_dst_vreg[VREG-1:0];
    dp_ex1_pipe7_mla_srcv2_vreg[VREG-1:0] <= idu_vfpu_rf_pipe7_mla_srcv2_vreg[VREG-1:0];
    dp_ex1_pipe7_dste_vld                 <= idu_vfpu_rf_pipe7_dste_vld;
    dp_ex1_pipe7_dstv_vld                 <= idu_vfpu_rf_pipe7_dstv_vld;
 //   dp_ex1_pipe7_dst_vld                  <= idu_vfpu_rf_pipe7_dst_vld;
    dp_ex1_pipe7_imm0[2:0]                <= idu_vfpu_rf_pipe7_imm0[2:0];
    dp_ex1_pipe7_ready_stage[2:0]         <= idu_vfpu_rf_pipe7_ready_stage[2:0];
  end
  else if(iu_vfpu_ex1_pipe1_mtvr_vld)
  begin
    dp_ex1_pipe7_opcode[31:0]             <= dp_ex1_pipe7_opcode[31:0];
    dp_ex1_pipe7_func[19:0]               <= pipe7_mtvr_func[19:0];
    dp_ex1_pipe7_dst_ereg[4:0]            <= dp_ex1_pipe7_dst_ereg[4:0];
    dp_ex1_pipe7_dst_preg[6:0]            <= dp_ex1_pipe7_dst_preg[6:0];
    dp_ex1_pipe7_dst_preg_dup0[6:0]            <= dp_ex1_pipe7_dst_preg_dup0[6:0];
    dp_ex1_pipe7_dst_preg_dup1[6:0]            <= dp_ex1_pipe7_dst_preg_dup1[6:0];
    dp_ex1_pipe7_dst_preg_dup2[6:0]            <= dp_ex1_pipe7_dst_preg_dup2[6:0];
    dp_ex1_pipe7_dst_preg_dup3[6:0]            <= dp_ex1_pipe7_dst_preg_dup3[6:0];
    dp_ex1_pipe7_dst_vreg[VREG-1:0]       <= pipe7_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0]       <= pipe7_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0]       <= pipe7_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0]       <= pipe7_mtvr_vreg[VREG-1:0];
    dp_ex1_pipe7_mla_srcv2_vreg[VREG-1:0] <= dp_ex1_pipe7_mla_srcv2_vreg[VREG-1:0];
    dp_ex1_pipe7_dste_vld                 <= 1'b0;
    dp_ex1_pipe7_dstv_vld                 <= 1'b1;
//    dp_ex1_pipe7_dst_vld                  <= 1'b0;
    dp_ex1_pipe7_imm0[2:0]                <= dp_ex1_pipe7_imm0[2:0];
    dp_ex1_pipe7_ready_stage[2:0]         <= 3'b1;
  end
  else
  begin
    dp_ex1_pipe7_opcode[31:0]             <= dp_ex1_pipe7_opcode[31:0];
    dp_ex1_pipe7_func[19:0]               <= dp_ex1_pipe7_func[19:0];              
    dp_ex1_pipe7_dst_ereg[4:0]            <= dp_ex1_pipe7_dst_ereg[4:0];           
    dp_ex1_pipe7_dst_preg[6:0]            <= dp_ex1_pipe7_dst_preg[6:0];           
    dp_ex1_pipe7_dst_preg_dup0[6:0]            <= dp_ex1_pipe7_dst_preg_dup0[6:0];           
    dp_ex1_pipe7_dst_preg_dup1[6:0]            <= dp_ex1_pipe7_dst_preg_dup1[6:0];           
    dp_ex1_pipe7_dst_preg_dup2[6:0]            <= dp_ex1_pipe7_dst_preg_dup2[6:0];           
    dp_ex1_pipe7_dst_preg_dup3[6:0]            <= dp_ex1_pipe7_dst_preg_dup3[6:0];           
    dp_ex1_pipe7_dst_vreg[VREG-1:0]       <= dp_ex1_pipe7_dst_vreg[VREG-1:0];           
    dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0]       <= dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0];           
    dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0]       <= dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0];           
    dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0]       <= dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0];           
    dp_ex1_pipe7_mla_srcv2_vreg[VREG-1:0] <= dp_ex1_pipe7_mla_srcv2_vreg[VREG-1:0];     
    dp_ex1_pipe7_dste_vld                 <= dp_ex1_pipe7_dste_vld;                
    dp_ex1_pipe7_dstv_vld                 <= dp_ex1_pipe7_dstv_vld;                
 //   dp_ex1_pipe7_dst_vld                  <= dp_ex1_pipe7_dst_vld;                 
    dp_ex1_pipe7_imm0[2:0]                <= dp_ex1_pipe7_imm0[2:0];
    dp_ex1_pipe7_ready_stage[2:0]         <= dp_ex1_pipe7_ready_stage[2:0];
  end
end
// &CombBeg; @711
always @( idu_vfpu_rf_pipe7_dst_vld
       or iu_vfpu_ex1_pipe1_mtvr_vld
       or idu_vfpu_rf_pipe7_gateclk_sel)
begin
 if(idu_vfpu_rf_pipe7_gateclk_sel)
   dp_ex1_pipe7_dst_vld_pre  = idu_vfpu_rf_pipe7_dst_vld;
 else if(iu_vfpu_ex1_pipe1_mtvr_vld)
    dp_ex1_pipe7_dst_vld_pre  = 1'b0;
 else 
    dp_ex1_pipe7_dst_vld_pre  = idu_vfpu_rf_pipe7_dst_vld;
// &CombEnd; @718
end
//assign dp_ctrl_ex1_pipe7_dst_vld = dp_ex1_pipe7_dst_vld;

//----------------------------------------------------------
//                    EX1 MFCR Inst
//----------------------------------------------------------
assign vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup0 = ctrl_ex1_pipe7_mfvr_inst_vld;
assign vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup1 = ctrl_ex1_pipe7_mfvr_inst_vld_dup0;
assign vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup2 = ctrl_ex1_pipe7_mfvr_inst_vld_dup1;
assign vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup3 = ctrl_ex1_pipe7_mfvr_inst_vld_dup2;
assign vfpu_idu_ex1_pipe7_mfvr_inst_vld_dup4 = ctrl_ex1_pipe7_mfvr_inst_vld_dup3;
assign vfpu_idu_ex1_pipe7_preg_dup0[6:0]     = dp_ex1_pipe7_dst_preg[6:0];
assign vfpu_idu_ex1_pipe7_preg_dup1[6:0]     = dp_ex1_pipe7_dst_preg_dup0[6:0];
assign vfpu_idu_ex1_pipe7_preg_dup2[6:0]     = dp_ex1_pipe7_dst_preg_dup1[6:0];
assign vfpu_idu_ex1_pipe7_preg_dup3[6:0]     = dp_ex1_pipe7_dst_preg_dup2[6:0];
assign vfpu_idu_ex1_pipe7_preg_dup4[6:0]     = dp_ex1_pipe7_dst_preg_dup3[6:0];

//----------------------------------------------------------
//                    EX2 data preparation
//----------------------------------------------------------
assign dp_ex1_pipe7_mfvr_data[XLEN-1:0] = ex1_pipe7_eu_sel_vec_mtvr 
                                        ? vdsp_vfpu_ex1_pipe7_mfvr_data[XLEN-1:0]
                                        : pipe7_dp_ex1_vfalu_mfvr_data[XLEN-1:0];

//select singal rebuild
//bit0: FALU
//bit1: FDSU
//bit2: FMAU
assign  dp_ex2_pipe7_eu_sel_pre[0]  = |ctrl_ex1_pipe7_eu_sel[2:0];
assign  dp_ex2_pipe7_eu_sel_pre[1]  = ctrl_ex1_pipe7_eu_sel[3] ||ctrl_ex1_pipe7_eu_sel[11];
assign  dp_ex2_pipe7_eu_sel_pre[2]  = ctrl_ex1_pipe7_eu_sel[4];
assign  dp_ex2_pipe7_eu_sel_pre[3]  = 1'b0;

assign dp_ex2_pipe7_ready_stage_pre[2:0] = (pipe7_dp_ex1_mult_id)
                                         ? 3'b100
                                         : dp_ex1_pipe7_ready_stage[2:0]; 

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign dp_ex2_pipe7_en =  ctrl_dp_ex2_pipe7_inst_vld;
//  &Instance("gated_clk_cell", "x_dp_ex2_pipe7_gated_clk"); @763
gated_clk_cell  x_dp_ex2_pipe7_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_ex2_pipe7_clk  ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_ex2_pipe7_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

//  &Connect(.clk_in      (forever_cpuclk), @764
//           .external_en (1'b0), @765
//           .global_en   (cp0_yy_clk_en), @766
//           .module_en   (cp0_vfpu_icg_en), @767
//           .local_en    (dp_ex2_pipe7_en), @768
//           .clk_out     (dp_ex2_pipe7_clk)); @769

//----------------------------------------------------------
//                 Pipe7 EX1/EX2 Pipeline
//----------------------------------------------------------
always @(posedge dp_ex2_pipe7_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex2_pipe7_eu_sel[3:0]        <= 4'b0;
    dp_ex2_pipe7_ready_stage[2:0]   <= 3'b0;
    dp_ex2_pipe7_dst_ereg[4:0]      <= 5'b0;
    dp_ex2_pipe7_dst_vreg[VREG-1:0] <= {VREG{1'b0}};
    dp_ex2_pipe7_dst_vreg_dup0[VREG-1:0] <= {VREG{1'b0}};
    dp_ex2_pipe7_dst_vreg_dup1[VREG-1:0] <= {VREG{1'b0}};
    dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0] <= {VREG{1'b0}};
    dp_ex2_pipe7_dst_preg[6:0]      <= 7'b0;
    dp_ex2_pipe7_dstv_vld           <= 1'b0;
    dp_ex2_pipe7_dste_vld           <= 1'b0;
    dp_ex2_pipe7_mfvr_data[63:0]    <= 64'b0; 
  end
  else if(ctrl_dp_ex2_pipe7_inst_vld)
  begin
    dp_ex2_pipe7_eu_sel[3:0]        <= dp_ex2_pipe7_eu_sel_pre[3:0];
    dp_ex2_pipe7_ready_stage[2:0]   <= dp_ex2_pipe7_ready_stage_pre[2:0];
    dp_ex2_pipe7_dst_ereg[4:0]      <= dp_ex1_pipe7_dst_ereg[4:0];  
    dp_ex2_pipe7_dst_vreg[VREG-1:0] <= dp_ex1_pipe7_dst_vreg[VREG-1:0];  
    dp_ex2_pipe7_dst_vreg_dup0[VREG-1:0] <= dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0];  
    dp_ex2_pipe7_dst_vreg_dup1[VREG-1:0] <= dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0];  
    dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0] <= dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0];  
    dp_ex2_pipe7_dst_preg[6:0]      <= dp_ex1_pipe7_dst_preg[6:0];  
    dp_ex2_pipe7_dstv_vld           <= dp_ex1_pipe7_dstv_vld;
    dp_ex2_pipe7_dste_vld           <= dp_ex1_pipe7_dste_vld;
    dp_ex2_pipe7_mfvr_data[63:0]    <= dp_ex1_pipe7_mfvr_data[63:0];  
  end
  else
  begin
    dp_ex2_pipe7_eu_sel[3:0]        <= dp_ex2_pipe7_eu_sel[3:0];
    dp_ex2_pipe7_ready_stage[2:0]   <= dp_ex2_pipe7_ready_stage[2:0];
    dp_ex2_pipe7_dst_ereg[4:0]      <= dp_ex2_pipe7_dst_ereg[4:0];  
    dp_ex2_pipe7_dst_vreg[VREG-1:0] <= dp_ex2_pipe7_dst_vreg[VREG-1:0];  
    dp_ex2_pipe7_dst_vreg_dup0[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup0[VREG-1:0];  
    dp_ex2_pipe7_dst_vreg_dup1[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup1[VREG-1:0];  
    dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0];  
    dp_ex2_pipe7_dst_preg[5:0]      <= dp_ex2_pipe7_dst_preg[5:0];  
    dp_ex2_pipe7_dstv_vld           <= dp_ex2_pipe7_dstv_vld;
    dp_ex2_pipe7_dste_vld           <= dp_ex2_pipe7_dste_vld;
    dp_ex2_pipe7_mfvr_data[63:0]    <= dp_ex2_pipe7_mfvr_data[63:0];
  end
end

//----------------------------------------------------------
//                    MFCR Data Output
//----------------------------------------------------------
assign vfpu_iu_ex2_pipe7_mfvr_data_vld   = ctrl_ex2_pipe7_mfvr_inst_vld;
assign vfpu_iu_ex2_pipe7_mfvr_data[63:0] = dp_ex2_pipe7_mfvr_data[63:0];
assign vfpu_iu_ex2_pipe7_mfvr_preg[6:0]  = dp_ex2_pipe7_dst_preg[6:0];

//----------------------------------------------------------
//                    EX3 data preparation
//----------------------------------------------------------
//forward valid signal
assign dp_ex3_pipe7_vreg_fwd_vld_pre  = dp_ex2_pipe7_ready_stage[0] 
                                     && dp_ex2_pipe7_dstv_vld;
//forward signal
assign dp_ex3_pipe7_vfalu_wb_vld_pre  = dp_ex2_pipe7_ready_stage[0] 
                                     && dp_ex2_pipe7_eu_sel[0];

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign dp_ex3_pipe7_en =  ctrl_ex2_pipe7_inst_vld;
//  &Instance("gated_clk_cell", "x_dp_ex3_pipe7_gated_clk"); @841
gated_clk_cell  x_dp_ex3_pipe7_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_ex3_pipe7_clk  ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_ex3_pipe7_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

//  &Connect(.clk_in      (forever_cpuclk), @842
//           .external_en (1'b0), @843
//           .global_en   (cp0_yy_clk_en), @844
//           .module_en   (cp0_vfpu_icg_en), @845
//           .local_en    (dp_ex3_pipe7_en), @846
//           .clk_out     (dp_ex3_pipe7_clk)); @847

//----------------------------------------------------------
//                 Pipe7 EX2/EX3 Data Pipeline
//----------------------------------------------------------
always @(posedge dp_ex3_pipe7_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex3_pipe7_eu_sel[3:0]        <= 4'b0; 
    dp_ex3_pipe7_ready_stage[2:0]   <= 3'b0;
    dp_ex3_pipe7_dst_ereg[4:0]      <= 5'b0;
    dp_ex3_pipe7_dst_vreg[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe7_dst_vreg_dup0[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe7_dst_vreg_dup1[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe7_dst_vreg_dup2[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe7_dst_vreg_dup3[VREG-1:0] <= {VREG{1'b0}};
    dp_ex3_pipe7_dstv_vld           <= 1'b0;
    dp_ex3_pipe7_dste_vld           <= 1'b0;
    dp_ex3_pipe7_vreg_fwd_vld       <= 1'b0;
    dp_ex3_pipe7_vfalu_wb_vld       <= 1'b0;
  end
  else if(ctrl_ex2_pipe7_inst_vld)
  begin
    dp_ex3_pipe7_eu_sel[3:0]        <= dp_ex2_pipe7_eu_sel[3:0];
    dp_ex3_pipe7_ready_stage[2:0]   <= dp_ex2_pipe7_ready_stage[2:0];
    dp_ex3_pipe7_dst_ereg[4:0]      <= dp_ex2_pipe7_dst_ereg[4:0];  
    dp_ex3_pipe7_dst_vreg[VREG-1:0] <= dp_ex2_pipe7_dst_vreg[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup0[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup0[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup1[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup1[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup2[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup3[VREG-1:0] <= dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0];  
    dp_ex3_pipe7_dstv_vld           <= dp_ex2_pipe7_dstv_vld;
    dp_ex3_pipe7_dste_vld           <= dp_ex2_pipe7_dste_vld;
    dp_ex3_pipe7_vreg_fwd_vld       <= dp_ex3_pipe7_vreg_fwd_vld_pre;
    dp_ex3_pipe7_vfalu_wb_vld       <= dp_ex3_pipe7_vfalu_wb_vld_pre;
  end
  else
  begin
    dp_ex3_pipe7_eu_sel[3:0]        <= dp_ex3_pipe7_eu_sel[3:0];
    dp_ex3_pipe7_ready_stage[2:0]   <= dp_ex3_pipe7_ready_stage[2:0];
    dp_ex3_pipe7_dst_ereg[4:0]      <= dp_ex3_pipe7_dst_ereg[4:0];  
    dp_ex3_pipe7_dst_vreg[VREG-1:0] <= dp_ex3_pipe7_dst_vreg[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup0[VREG-1:0] <= dp_ex3_pipe7_dst_vreg_dup0[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup1[VREG-1:0] <= dp_ex3_pipe7_dst_vreg_dup1[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup2[VREG-1:0] <= dp_ex3_pipe7_dst_vreg_dup2[VREG-1:0];  
    dp_ex3_pipe7_dst_vreg_dup3[VREG-1:0] <= dp_ex3_pipe7_dst_vreg_dup3[VREG-1:0];  
    dp_ex3_pipe7_dstv_vld           <= dp_ex3_pipe7_dstv_vld;
    dp_ex3_pipe7_dste_vld           <= dp_ex3_pipe7_dste_vld;
    dp_ex3_pipe7_vreg_fwd_vld       <= dp_ex3_pipe7_vreg_fwd_vld;
    dp_ex3_pipe7_vfalu_wb_vld       <= dp_ex3_pipe7_vfalu_wb_vld;
  end
end

// &Force("output","dp_ex3_pipe7_dst_vreg"); @901
// &Force("output","dp_ex3_pipe7_freg_data"); @902
// &CombBeg; @903
always @( dp_ex3_pipe7_eu_sel[0]
       or pipe7_dp_ex3_vfalu_freg_data[63:0]
       or pipe7_dp_ex3_vfmau_freg_data[63:0]
       or dp_ex3_pipe7_eu_sel[2])
begin
case({dp_ex3_pipe7_eu_sel[2],dp_ex3_pipe7_eu_sel[0]})
  2'b10  : dp_ex3_pipe7_freg_data[FPR_MSB:0] = pipe7_dp_ex3_vfmau_freg_data[FPR_MSB:0];
  2'b01  : dp_ex3_pipe7_freg_data[FPR_MSB:0] = pipe7_dp_ex3_vfalu_freg_data[FPR_MSB:0];
  default: dp_ex3_pipe7_freg_data[FPR_MSB:0] = {FPR_MSB+1{1'bx}};
endcase
// &CombEnd; @909
end

// &CombBeg; @911
always @( pipe7_dp_ex3_vfalu_ereg_data[4:0]
       or dp_ex3_pipe7_eu_sel[0]
       or pipe7_dp_ex3_vfmau_ereg_data[4:0]
       or dp_ex3_pipe7_eu_sel[2])
begin
case({dp_ex3_pipe7_eu_sel[2],dp_ex3_pipe7_eu_sel[0]})
  2'b10  : dp_ex3_pipe7_ereg_data[4:0] = pipe7_dp_ex3_vfmau_ereg_data[4:0];
  2'b01  : dp_ex3_pipe7_ereg_data[4:0] = pipe7_dp_ex3_vfalu_ereg_data[4:0];
  default: dp_ex3_pipe7_ereg_data[4:0] = 5'b0;
endcase
// &CombEnd; @917
end

//----------------------------------------------------------
//                    EX4 data preparation
//----------------------------------------------------------
//forward valid signal
assign dp_ex4_pipe7_vreg_fwd_vld_pre  = dp_ex3_pipe7_vreg_fwd_vld
                                     || dp_ex3_pipe7_ready_stage[1];
                                    
//forward data seletion
//bit0: Ex3 data
//bit1: Ex4 FMA data
assign dp_ex4_pipe7_wb_vld_pre[0] = !dp_ex3_pipe7_ready_stage[1];
assign dp_ex4_pipe7_wb_vld_pre[1] = dp_ex3_pipe7_ready_stage[1] && dp_ex3_pipe7_eu_sel[2];

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign dp_ex4_pipe7_en =  ctrl_ex3_pipe7_inst_vld;
//  &Instance("gated_clk_cell", "x_dp_ex4_pipe7_gated_clk"); @936
gated_clk_cell  x_dp_ex4_pipe7_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_ex4_pipe7_clk  ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_ex4_pipe7_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

//  &Connect(.clk_in      (forever_cpuclk), @937
//           .external_en (1'b0), @938
//           .global_en   (cp0_yy_clk_en), @939
//           .module_en   (cp0_vfpu_icg_en), @940
//           .local_en    (dp_ex4_pipe7_en), @941
//           .clk_out     (dp_ex4_pipe7_clk)); @942

//----------------------------------------------------------
//                 Pipe7 EX3/EX4 Data Pipeline
//----------------------------------------------------------
always @(posedge dp_ex4_pipe7_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex4_pipe7_eu_sel[3:0]          <= 4'b0;
    dp_ex4_pipe7_ready_stage[2:0]     <= 3'b0;
    dp_ex4_pipe7_dst_ereg[4:0]        <= 5'b0;
    dp_ex4_pipe7_dst_vreg[VREG-1:0]   <= {VREG{1'b0}};
    dp_ex4_pipe7_dstv_vld             <= 1'b0;
    dp_ex4_pipe7_dste_vld             <= 1'b0;
    dp_ex4_pipe7_vreg_fwd_vld         <= 1'b0;
    dp_ex4_pipe7_freg_data[FPR_MSB:0] <= {FPR_MSB+1{1'b0}};
    dp_ex4_pipe7_ereg_data[4:0]       <= 5'b0;
    dp_ex4_pipe7_wb_vld[1:0]          <= 2'b0;    
  end
  else if(ctrl_ex3_pipe7_inst_vld)
  begin
    dp_ex4_pipe7_eu_sel[3:0]          <= dp_ex3_pipe7_eu_sel[3:0];
    dp_ex4_pipe7_ready_stage[2:0]     <= dp_ex3_pipe7_ready_stage[2:0];
    dp_ex4_pipe7_dst_ereg[4:0]        <= dp_ex3_pipe7_dst_ereg[4:0];  
    dp_ex4_pipe7_dst_vreg[VREG-1:0]   <= dp_ex3_pipe7_dst_vreg[VREG-1:0];  
    dp_ex4_pipe7_dstv_vld             <= dp_ex3_pipe7_dstv_vld;
    dp_ex4_pipe7_dste_vld             <= dp_ex3_pipe7_dste_vld;
    dp_ex4_pipe7_vreg_fwd_vld         <= dp_ex4_pipe7_vreg_fwd_vld_pre;
    dp_ex4_pipe7_freg_data[FPR_MSB:0] <= dp_ex3_pipe7_freg_data[FPR_MSB:0];
    dp_ex4_pipe7_ereg_data[4:0]       <= dp_ex3_pipe7_ereg_data[4:0];
    dp_ex4_pipe7_wb_vld[1:0]          <= dp_ex4_pipe7_wb_vld_pre[1:0];    
  end
  else 
  begin
    dp_ex4_pipe7_eu_sel[3:0]          <= dp_ex4_pipe7_eu_sel[3:0];
    dp_ex4_pipe7_ready_stage[2:0]     <= dp_ex4_pipe7_ready_stage[2:0];
    dp_ex4_pipe7_dst_ereg[4:0]        <= dp_ex4_pipe7_dst_ereg[4:0];  
    dp_ex4_pipe7_dst_vreg[VREG-1:0]   <= dp_ex4_pipe7_dst_vreg[VREG-1:0];  
    dp_ex4_pipe7_dstv_vld             <= dp_ex4_pipe7_dstv_vld;
    dp_ex4_pipe7_dste_vld             <= dp_ex4_pipe7_dste_vld;
    dp_ex4_pipe7_vreg_fwd_vld         <= dp_ex4_pipe7_vreg_fwd_vld;
    dp_ex4_pipe7_freg_data[FPR_MSB:0] <= dp_ex4_pipe7_freg_data[FPR_MSB:0];
    dp_ex4_pipe7_ereg_data[4:0]       <= dp_ex4_pipe7_ereg_data[4:0];
    dp_ex4_pipe7_wb_vld[1:0]          <= dp_ex4_pipe7_wb_vld[1:0];    
  end
end

// &Force("output","dp_ex4_pipe7_dst_vreg"); @990
// &Force("output","dp_ex4_pipe7_dst_ereg"); @991
// &Force("output","dp_ex4_pipe7_dstv_vld"); @992
// &Force("output","dp_ex4_pipe7_dste_vld"); @993

//----------------------------------------------------------
//                    EX5 data preparation
//----------------------------------------------------------
assign pipe7_dp_ex4_vfalu_ereg_data[4:0] = 5'b0;
assign dp_ex5_pipe7_freg_data_pre[FPR_MSB:0] = (dp_ex4_pipe7_wb_vld[1])
                                               ? pipe7_dp_ex4_vfmau_freg_data[FPR_MSB:0]
                                               : dp_ex4_pipe7_freg_data[FPR_MSB:0];

assign dp_ex4_pipe7_ereg_sel[0] = dp_ex4_pipe7_eu_sel[0] && dp_ex4_pipe7_ready_stage[1];
assign dp_ex4_pipe7_ereg_sel[1] = dp_ex4_pipe7_eu_sel[2] && dp_ex4_pipe7_ready_stage[1];

assign dp_ex4_pipe7_ereg_data_new[4:0] = dp_ex4_pipe7_ereg_sel[1] ?
                                         pipe7_dp_ex4_vfmau_ereg_data[4:0]:
                                         pipe7_dp_ex4_vfalu_ereg_data[4:0];

assign dp_ex5_pipe7_ereg_data_pre[4:0] = (|dp_ex4_pipe7_ereg_sel[1:0])
                                       ? dp_ex4_pipe7_ereg_data_new[4:0]
                                       : dp_ex4_pipe7_ereg_data[4:0];


// &Force("output","dp_ex5_pipe7_freg_data_pre"); @1018
// &Force("output","dp_ex5_pipe7_freg_data_pre"); @1019

//==========================================================
//                 Instruction Dispatch
//==========================================================
//----------------------------------------------------------
//                     Pipe7 FALU 
//----------------------------------------------------------
assign dp_vfalu_ex1_pipe7_sel[2:0]         = ctrl_ex1_pipe7_eu_sel[2:0];
assign dp_vfalu_ex1_pipe7_func[19:0]       = dp_ex1_pipe7_func[19:0];
assign dp_vfalu_ex1_pipe7_imm0[2:0]        = dp_ex1_pipe7_imm0[2:0];
assign dp_vfalu_ex1_pipe7_mtvr_src0[63:0]  = iu_vfpu_ex2_pipe1_mtvr_src0[63:0];

//----------------------------------------------------------
//                    Pipe7 VFMAU
//----------------------------------------------------------
assign dp_vfmau_ex1_pipe7_sel                   = ctrl_ex1_pipe7_eu_sel[4];
assign dp_vfmau_ex1_pipe7_imm0[2:0]             = dp_ex1_pipe7_imm0[2:0];
assign dp_vfmau_ex1_pipe7_dst_vreg[VREG-1:0]    = dp_ex1_pipe7_dst_vreg[VREG-1:0];
assign dp_vfmau_pipe7_mla_srcv2_vreg[VREG-1:0]  = idu_vfpu_rf_pipe7_mla_srcv2_vreg[VREG-1:0];
assign dp_vfmau_pipe7_mla_srcv2_vld             = idu_vfpu_rf_pipe7_mla_srcv2_vld;
assign dp_vfmau_pipe7_mla_type[2:0]             = idu_vfpu_rf_pipe7_vmla_type[2:0];
assign dp_vfmau_pipe7_inst_type[5:0]            = idu_vfpu_rf_pipe7_inst_type[5:0];
assign dp_vfmau_pipe7_vfmau_sel                 = idu_vfpu_rf_pipe7_eu_sel[4];
assign dp_vfmau_pipe7_sel                       = idu_vfpu_rf_pipe7_gateclk_sel;

//==========================================================
//                  Result Bus
//==========================================================
assign dp_ctrl_ex1_pipe7_data_vld_pre = idu_vfpu_rf_pipe7_gateclk_sel && idu_vfpu_rf_pipe7_dstv_vld && idu_vfpu_rf_pipe7_ready_stage[0];
assign dp_ctrl_ex2_pipe7_data_vld_pre = dp_ex1_pipe7_dstv_vld && dp_ex1_pipe7_ready_stage[1] && !pipe7_dp_ex1_mult_id;
assign dp_ctrl_ex3_pipe7_data_vld_pre = dp_ex2_pipe7_dstv_vld && dp_ex2_pipe7_ready_stage[2];

assign dp_ctrl_ex3_pipe7_fwd_vld_pre  = dp_ex3_pipe7_vreg_fwd_vld_pre;
assign dp_ctrl_ex4_pipe7_fwd_vld_pre  = dp_ex4_pipe7_vreg_fwd_vld_pre;

assign dp_rbus_pipe7_ex1_vreg[VREG-1:0] = dp_ex1_pipe7_dst_vreg[VREG-1:0];
assign dp_rbus_pipe7_ex1_vreg_dup0[VREG-1:0] = dp_ex1_pipe7_dst_vreg_dup0[VREG-1:0];
assign dp_rbus_pipe7_ex1_vreg_dup1[VREG-1:0] = dp_ex1_pipe7_dst_vreg_dup1[VREG-1:0];
assign dp_rbus_pipe7_ex1_vreg_dup2[VREG-1:0] = dp_ex1_pipe7_dst_vreg_dup2[VREG-1:0];
assign dp_rbus_pipe7_ex2_vreg[VREG-1:0] = dp_ex2_pipe7_dst_vreg[VREG-1:0];                                   
assign dp_rbus_pipe7_ex2_vreg_dup0[VREG-1:0] = dp_ex2_pipe7_dst_vreg_dup0[VREG-1:0];                                   
assign dp_rbus_pipe7_ex2_vreg_dup1[VREG-1:0] = dp_ex2_pipe7_dst_vreg_dup1[VREG-1:0];                                   
assign dp_rbus_pipe7_ex2_vreg_dup2[VREG-1:0] = dp_ex2_pipe7_dst_vreg_dup2[VREG-1:0];                                   
assign dp_rbus_pipe7_ex3_vreg_dup0[VREG-1:0] = dp_ex3_pipe7_dst_vreg_dup0[VREG-1:0];
assign dp_rbus_pipe7_ex3_vreg_dup1[VREG-1:0] = dp_ex3_pipe7_dst_vreg_dup1[VREG-1:0];
assign dp_rbus_pipe7_ex3_vreg_dup2[VREG-1:0] = dp_ex3_pipe7_dst_vreg_dup2[VREG-1:0];
assign dp_rbus_pipe7_ex3_vreg_dup3[VREG-1:0] = dp_ex3_pipe7_dst_vreg_dup3[VREG-1:0];

//==========================================================
//                 Global Singal
//==========================================================
// &Force("bus","cp0_vfpu_fxcr",31,0); @1085
assign vfpu_yy_xx_rm[2:0]      = cp0_vfpu_fxcr[26:24];
assign vfpu_yy_xx_dqnan        = cp0_vfpu_fxcr[23];

// &Force("bus","idu_vfpu_rf_pipe6_split_num",6,0); @1090
// &Force("bus","idu_vfpu_rf_pipe7_split_num",6,0); @1091
// &Instance("ct_vfpu_vm_mask_extract", "x_ct_vfpu_pipe6_vm_mask_extract"); @1209
// &Connect(.ex1_lmul                   (dp_ex1_pipe6_lmul                  ), @1210
//          .ex1_narrow                 (dp_ex1_pipe6_narrow                ), @1211
//          .ex1_sew                    (dp_ex1_pipe6_sew                   ), @1212
//          .ex1_split_count            (dp_ex1_pipe6_split_count           ), @1213
//          .ex1_vm_byte_mask_src       (dp_ex1_pipe6_vm_vsrc_mask          ), @1214
//          .ex1_vm_byte_mask_dst       (dp_ex1_pipe6_vm_vdst_mask          ), @1215
//          .ex1_vm_mask_source         (dp_ex1_pipe6_vm_mask_source        ), @1216
//          .ex1_wide                   (dp_ex1_pipe6_wide                  ), @1217
//          .ex2_lmul                   (dp_ex2_pipe6_lmul                  ), @1218
//          .ex2_split_count            (dp_ex2_pipe6_split_count           ), @1219
//          .ex2_vm_byte_mask_dst       (dp_ex2_pipe6_vm_vdst_mask          ), @1220
//          .ex2_vm_mask_compare_select (dp_ex2_pipe6_vm_compare_select     ) @1221
// ); @1222
// &Instance("ct_vfpu_vl_mask_extract", "x_ct_vfpu_pipe6_vl_mask_extract"); @1224
// &Connect(.ex1_narrow                 (dp_ex1_pipe6_narrow          ), @1225
//          .ex1_sew                    (dp_ex1_pipe6_sew             ), @1226
//          .ex1_split_count            (dp_ex1_pipe6_split_count     ), @1227
//          .ex1_vl                     (dp_ex1_pipe6_vl              ), @1228
//          .ex1_vl_byte_mask_src       (dp_ex1_pipe6_vl_vsrc_mask    ), @1229
//          .ex1_vl_byte_mask_dst       (dp_ex1_pipe6_vl_vdst_mask    ), @1230
//          .ex1_wide                   (dp_ex1_pipe6_wide            ), @1231
//          .ex2_vl                     (dp_ex2_pipe6_vl              ), @1232
//          .ex2_lmul                   (dp_ex2_pipe6_lmul            ), @1233
//          .ex2_sew                    (dp_ex2_pipe6_sew             ), @1234
//          .ex2_vl_mask_layout         (dp_ex2_pipe6_vl_mask_layout  ) @1235
// ); @1236
// &CombBeg; @1280
// &CombEnd; @1286
// &CombBeg; @1288
// &CombEnd; @1294
//  &Instance("gated_clk_cell", "x_dp_ex2_pipe6_vec_result_gated_clk"); @1298
//  &Connect(.clk_in      (forever_cpuclk), @1299
//           .external_en (1'b0), @1300
//           .global_en   (cp0_yy_clk_en), @1301
//           .module_en   (cp0_vfpu_icg_en), @1302
//           .local_en    (dp_ex2_pipe6_vec_result_en), @1303
//           .clk_out     (dp_ex2_pipe6_vec_result_clk)); @1304
//  &Instance("gated_clk_cell", "x_dp_ex3_pipe6_vec_result_gated_clk"); @1348
//  &Connect(.clk_in      (forever_cpuclk), @1349
//           .external_en (1'b0), @1350
//           .global_en   (cp0_yy_clk_en), @1351
//           .module_en   (cp0_vfpu_icg_en), @1352
//           .local_en    (dp_ex3_pipe6_vec_result_en), @1353
//           .clk_out     (dp_ex3_pipe6_vec_result_clk)); @1354
// &CombBeg; @1382
// &CombEnd; @1388
// &CombBeg; @1390
// &CombEnd; @1396
//  &Instance("gated_clk_cell", "x_dp_ex4_pipe6_vec_result_gated_clk"); @1412
//  &Connect(.clk_in      (forever_cpuclk), @1413
//           .external_en (1'b0), @1414
//           .global_en   (cp0_yy_clk_en), @1415
//           .module_en   (cp0_vfpu_icg_en), @1416
//           .local_en    (dp_ex4_pipe6_vec_result_en), @1417
//           .clk_out     (dp_ex4_pipe6_vec_result_clk)); @1418
// &CombBeg; @1448
// &CombEnd; @1455
// &CombBeg; @1457
// &CombEnd; @1464
// &Force("bus","cp0_vfpu_fcsr",63,0); @1527
// &Instance("ct_vfpu_vm_mask_extract", "x_ct_vfpu_pipe7_vm_mask_extract"); @1647
// &Connect(.ex1_lmul                   (dp_ex1_pipe7_lmul                  ), @1648
//          .ex1_narrow                 (dp_ex1_pipe7_narrow                ), @1649
//          .ex1_sew                    (dp_ex1_pipe7_sew                   ), @1650
//          .ex1_split_count            (dp_ex1_pipe7_split_count           ), @1651
//          .ex1_vm_byte_mask_src       (dp_ex1_pipe7_vm_vsrc_mask          ), @1652
//          .ex1_vm_byte_mask_dst       (dp_ex1_pipe7_vm_vdst_mask          ), @1653
//          .ex1_vm_mask_source         (dp_ex1_pipe7_vm_mask_source        ), @1654
//          .ex1_wide                   (dp_ex1_pipe7_wide                  ), @1655
//          .ex2_lmul                   (dp_ex2_pipe7_lmul                  ), @1656
//          .ex2_split_count            (dp_ex2_pipe7_split_count           ), @1657
//          .ex2_vm_byte_mask_dst       (dp_ex2_pipe7_vm_vdst_mask          ), @1658
//          .ex2_vm_mask_compare_select (dp_ex2_pipe7_vm_compare_select     ) @1659
// ); @1660
// &Instance("ct_vfpu_vl_mask_extract", "x_ct_vfpu_pipe7_vl_mask_extract"); @1662
// &Connect(.ex1_narrow                 (dp_ex1_pipe7_narrow          ), @1663
//          .ex1_sew                    (dp_ex1_pipe7_sew             ), @1664
//          .ex1_split_count            (dp_ex1_pipe7_split_count     ), @1665
//          .ex1_vl                     (dp_ex1_pipe7_vl              ), @1666
//          .ex1_vl_byte_mask_src       (dp_ex1_pipe7_vl_vsrc_mask    ), @1667
//          .ex1_vl_byte_mask_dst       (dp_ex1_pipe7_vl_vdst_mask    ), @1668
//          .ex1_wide                   (dp_ex1_pipe7_wide            ), @1669
//          .ex2_vl                     (dp_ex2_pipe7_vl              ), @1670
//          .ex2_lmul                   (dp_ex2_pipe7_lmul            ), @1671
//          .ex2_sew                    (dp_ex2_pipe7_sew             ), @1672
//          .ex2_vl_mask_layout         (dp_ex2_pipe7_vl_mask_layout  ) @1673
// ); @1674
// &CombBeg; @1721
// &CombEnd; @1727
// &CombBeg; @1729
// &CombEnd; @1735
// &CombBeg; @1761
// &CombEnd; @1767
// &CombBeg; @1769
// &CombEnd; @1775
//  &Instance("gated_clk_cell", "x_dp_ex4_pipe7_vec_result_gated_clk"); @1793
//  &Connect(.clk_in      (forever_cpuclk), @1794
//           .external_en (1'b0), @1795
//           .global_en   (cp0_yy_clk_en), @1796
//           .module_en   (cp0_vfpu_icg_en), @1797
//           .local_en    (dp_ex4_pipe7_vec_result_en), @1798
//           .clk_out     (dp_ex4_pipe7_vec_result_clk)); @1799
// &CombBeg; @1830
// &CombEnd; @1837
// &CombBeg; @1839
// &CombEnd; @1846
// &Force("bus","iu_vfpu_ex1_pipe0_mtvr_vsew",2,0); @1921
// &Force("bus","iu_vfpu_ex1_pipe1_mtvr_vsew",2,0); @1922
always @(posedge dp_ex1_pipe6_pipe_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex1_pipe6_vfpu_srcf0[FPR_MSB:0]       <= {FPR_MSB+1{1'b0}};
    dp_ex1_pipe6_vfpu_srcf1[FPR_MSB:0]       <= {FPR_MSB+1{1'b0}}; 
    dp_ex1_pipe6_vfpu_srcf2[FPR_MSB:0]       <= {FPR_MSB+1{1'b0}}; 
  end
  else if (idu_vfpu_rf_pipe6_gateclk_sel && |idu_vfpu_rf_pipe6_eu_sel[4:0])
  begin
    dp_ex1_pipe6_vfpu_srcf0[FPR_MSB:0]       <= idu_vfpu_rf_pipe6_srcv0_fr[FPR_MSB:0];
    dp_ex1_pipe6_vfpu_srcf1[FPR_MSB:0]       <= idu_vfpu_rf_pipe6_srcv1_fr[FPR_MSB:0];
    dp_ex1_pipe6_vfpu_srcf2[FPR_MSB:0]       <= idu_vfpu_rf_pipe6_srcv2_fr[FPR_MSB:0];
  end
  else
  begin
    dp_ex1_pipe6_vfpu_srcf0[FPR_MSB:0]       <= dp_ex1_pipe6_vfpu_srcf0[FPR_MSB:0];    
    dp_ex1_pipe6_vfpu_srcf1[FPR_MSB:0]       <= dp_ex1_pipe6_vfpu_srcf1[FPR_MSB:0];    
    dp_ex1_pipe6_vfpu_srcf2[FPR_MSB:0]       <= dp_ex1_pipe6_vfpu_srcf2[FPR_MSB:0];    
  end
end
assign dp_vfalu_ex1_pipe6_srcf0[FPR_MSB:0] = dp_ex1_pipe6_vfpu_srcf0[FPR_MSB:0];
assign dp_vfalu_ex1_pipe6_srcf1[FPR_MSB:0] = dp_ex1_pipe6_vfpu_srcf1[FPR_MSB:0];
assign dp_vfalu_ex1_pipe6_srcf2[FPR_MSB:0] = dp_ex1_pipe6_vfpu_srcf2[FPR_MSB:0];

assign dp_vfdsu_ex1_pipe6_srcf0[FPR_MSB:0] = dp_ex1_pipe6_vfpu_srcf0[FPR_MSB:0];
assign dp_vfdsu_ex1_pipe6_srcf1[FPR_MSB:0] = dp_ex1_pipe6_vfpu_srcf1[FPR_MSB:0];
assign dp_vfdsu_ex1_pipe6_srcf2[FPR_MSB:0] = dp_ex1_pipe6_vfpu_srcf2[FPR_MSB:0];

always @(posedge dp_ex1_pipe7_pipe_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    dp_ex1_pipe7_vfpu_srcf0[FPR_MSB:0]       <= {FPR_MSB+1{1'b0}};
    dp_ex1_pipe7_vfpu_srcf1[FPR_MSB:0]       <= {FPR_MSB+1{1'b0}}; 
    dp_ex1_pipe7_vfpu_srcf2[FPR_MSB:0]       <= {FPR_MSB+1{1'b0}}; 
  end
  else if (idu_vfpu_rf_pipe7_gateclk_sel && |idu_vfpu_rf_pipe7_eu_sel[4:0])
  begin
    dp_ex1_pipe7_vfpu_srcf0[FPR_MSB:0]       <= idu_vfpu_rf_pipe7_srcv0_fr[FPR_MSB:0];
    dp_ex1_pipe7_vfpu_srcf1[FPR_MSB:0]       <= idu_vfpu_rf_pipe7_srcv1_fr[FPR_MSB:0];
    dp_ex1_pipe7_vfpu_srcf2[FPR_MSB:0]       <= idu_vfpu_rf_pipe7_srcv2_fr[FPR_MSB:0];
  end
  else
  begin
    dp_ex1_pipe7_vfpu_srcf0[FPR_MSB:0]       <= dp_ex1_pipe7_vfpu_srcf0[FPR_MSB:0];    
    dp_ex1_pipe7_vfpu_srcf1[FPR_MSB:0]       <= dp_ex1_pipe7_vfpu_srcf1[FPR_MSB:0];    
    dp_ex1_pipe7_vfpu_srcf2[FPR_MSB:0]       <= dp_ex1_pipe7_vfpu_srcf2[FPR_MSB:0];    
  end
end
assign dp_vfalu_ex1_pipe7_srcf0[FPR_MSB:0] = dp_ex1_pipe7_vfpu_srcf0[FPR_MSB:0];
assign dp_vfalu_ex1_pipe7_srcf1[FPR_MSB:0] = dp_ex1_pipe7_vfpu_srcf1[FPR_MSB:0];
assign dp_vfalu_ex1_pipe7_srcf2[FPR_MSB:0] = dp_ex1_pipe7_vfpu_srcf2[FPR_MSB:0];

assign ex1_pipe6_eu_sel_vec_mtvr = 1'b0;
assign ex1_pipe7_eu_sel_vec_mtvr = 1'b0;


// &ModuleEnd; @1977
endmodule


