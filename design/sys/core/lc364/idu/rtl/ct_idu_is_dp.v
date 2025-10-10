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

// &ModuleBeg; @26
module ct_idu_is_dp (
  // &Ports, @27
  input    wire  [7  :0]  aiq0_aiq_create0_entry,
  input    wire  [7  :0]  aiq0_aiq_create1_entry,
  input    wire  [7  :0]  aiq1_aiq_create0_entry,
  input    wire  [7  :0]  aiq1_aiq_create1_entry,
  input    wire  [11 :0]  biq_aiq_create0_entry,
  input    wire  [11 :0]  biq_aiq_create1_entry,
  input    wire           cp0_idu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           ctrl_aiq0_create0_dp_en,
  input    wire           ctrl_aiq0_create0_gateclk_en,
  input    wire           ctrl_aiq0_create1_dp_en,
  input    wire           ctrl_aiq0_create1_gateclk_en,
  input    wire           ctrl_aiq1_create0_dp_en,
  input    wire           ctrl_aiq1_create0_gateclk_en,
  input    wire           ctrl_aiq1_create1_dp_en,
  input    wire           ctrl_aiq1_create1_gateclk_en,
  input    wire           ctrl_biq_create0_dp_en,
  input    wire           ctrl_biq_create0_gateclk_en,
  input    wire           ctrl_biq_create1_dp_en,
  input    wire           ctrl_biq_create1_gateclk_en,
  input    wire           ctrl_dp_dis_inst0_ereg_vld,
  input    wire           ctrl_dp_dis_inst0_freg_vld,
  input    wire           ctrl_dp_dis_inst0_preg_vld,
  input    wire           ctrl_dp_dis_inst0_vreg_vld,
  input    wire           ctrl_dp_dis_inst1_ereg_vld,
  input    wire           ctrl_dp_dis_inst1_freg_vld,
  input    wire           ctrl_dp_dis_inst1_preg_vld,
  input    wire           ctrl_dp_dis_inst1_vreg_vld,
  input    wire           ctrl_dp_dis_inst2_ereg_vld,
  input    wire           ctrl_dp_dis_inst2_freg_vld,
  input    wire           ctrl_dp_dis_inst2_preg_vld,
  input    wire           ctrl_dp_dis_inst2_vreg_vld,
  input    wire           ctrl_dp_dis_inst3_ereg_vld,
  input    wire           ctrl_dp_dis_inst3_freg_vld,
  input    wire           ctrl_dp_dis_inst3_preg_vld,
  input    wire           ctrl_dp_dis_inst3_vreg_vld,
  input    wire  [1  :0]  ctrl_dp_is_dis_aiq0_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_aiq0_create1_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_aiq1_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_aiq1_create1_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_biq_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_biq_create1_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_lsiq_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_lsiq_create1_sel,
  input    wire           ctrl_dp_is_dis_pst_create1_iid_sel,
  input    wire  [2  :0]  ctrl_dp_is_dis_pst_create2_iid_sel,
  input    wire  [2  :0]  ctrl_dp_is_dis_pst_create3_iid_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_rob_create0_sel,
  input    wire  [2  :0]  ctrl_dp_is_dis_rob_create1_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_rob_create2_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_sdiq_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_sdiq_create1_sel,
  input    wire           ctrl_dp_is_dis_stall,
  input    wire  [1  :0]  ctrl_dp_is_dis_viq0_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_viq0_create1_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_viq1_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_viq1_create1_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_vmb_create0_sel,
  input    wire  [1  :0]  ctrl_dp_is_dis_vmb_create1_sel,
  input    wire           ctrl_dp_is_inst0_vld,
  input    wire           ctrl_dp_is_inst1_vld,
  input    wire           ctrl_dp_is_inst2_vld,
  input    wire           ctrl_dp_is_inst3_vld,
  input    wire           ctrl_ir_pipedown,
  input    wire           ctrl_ir_pipedown_gateclk,
  input    wire           ctrl_lsiq_create0_dp_en,
  input    wire           ctrl_lsiq_create0_gateclk_en,
  input    wire           ctrl_lsiq_create1_dp_en,
  input    wire           ctrl_lsiq_create1_gateclk_en,
  input    wire           ctrl_sdiq_create0_dp_en,
  input    wire           ctrl_sdiq_create0_gateclk_en,
  input    wire           ctrl_sdiq_create1_dp_en,
  input    wire           ctrl_sdiq_create1_gateclk_en,
  input    wire           ctrl_viq0_create0_dp_en,
  input    wire           ctrl_viq0_create0_gateclk_en,
  input    wire           ctrl_viq0_create1_dp_en,
  input    wire           ctrl_viq0_create1_gateclk_en,
  input    wire           ctrl_viq1_create0_dp_en,
  input    wire           ctrl_viq1_create0_gateclk_en,
  input    wire           ctrl_viq1_create1_dp_en,
  input    wire           ctrl_viq1_create1_gateclk_en,
  input    wire  [1  :0]  ctrl_xx_is_inst0_sel,
  input    wire  [2  :0]  ctrl_xx_is_inst_sel,
  input    wire           ctrl_xx_rf_pipe0_preg_lch_vld_dupx,
  input    wire           ctrl_xx_rf_pipe1_preg_lch_vld_dupx,
  input    wire           ctrl_xx_rf_pipe6_vmla_lch_vld_dupx,
  input    wire           ctrl_xx_rf_pipe7_vmla_lch_vld_dupx,
  input    wire  [3  :0]  dp_ir_inst01_src_match,
  input    wire  [3  :0]  dp_ir_inst02_src_match,
  input    wire  [3  :0]  dp_ir_inst03_src_match,
  input    wire  [271:0]  dp_ir_inst0_data,
  input    wire  [3  :0]  dp_ir_inst12_src_match,
  input    wire  [3  :0]  dp_ir_inst13_src_match,
  input    wire  [271:0]  dp_ir_inst1_data,
  input    wire  [3  :0]  dp_ir_inst23_src_match,
  input    wire  [271:0]  dp_ir_inst2_data,
  input    wire  [271:0]  dp_ir_inst3_data,
  input    wire  [6  :0]  dp_xx_rf_pipe0_dst_preg_dupx,
  input    wire  [6  :0]  dp_xx_rf_pipe1_dst_preg_dupx,
  input    wire  [6  :0]  dp_xx_rf_pipe6_dst_vreg_dupx,
  input    wire  [6  :0]  dp_xx_rf_pipe7_dst_vreg_dupx,
  input    wire           forever_cpuclk,
  input    wire           iu_idu_div_inst_vld,
  input    wire  [6  :0]  iu_idu_div_preg_dupx,
  input    wire  [6  :0]  iu_idu_ex2_pipe0_wb_preg_dupx,
  input    wire           iu_idu_ex2_pipe0_wb_preg_vld_dupx,
  input    wire           iu_idu_ex2_pipe1_mult_inst_vld_dupx,
  input    wire  [6  :0]  iu_idu_ex2_pipe1_preg_dupx,
  input    wire  [6  :0]  iu_idu_ex2_pipe1_wb_preg_dupx,
  input    wire           iu_idu_ex2_pipe1_wb_preg_vld_dupx,
  input    wire  [4  :0]  iu_idu_pcfifo_dis_inst0_pid,
  input    wire  [4  :0]  iu_idu_pcfifo_dis_inst1_pid,
  input    wire  [4  :0]  iu_idu_pcfifo_dis_inst2_pid,
  input    wire  [4  :0]  iu_idu_pcfifo_dis_inst3_pid,
  input    wire  [11 :0]  lsiq_aiq_create0_entry,
  input    wire  [11 :0]  lsiq_aiq_create1_entry,
  input    wire           lsiq_dp_create_bypass_oldest,
  input    wire           lsiq_dp_no_spec_store_vld,
  input    wire           lsu_idu_ag_pipe3_load_inst_vld,
  input    wire  [6  :0]  lsu_idu_ag_pipe3_preg_dupx,
  input    wire           lsu_idu_ag_pipe3_vload_inst_vld,
  input    wire  [6  :0]  lsu_idu_ag_pipe3_vreg_dupx,
  input    wire           lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx,
  input    wire           lsu_idu_dc_pipe3_load_inst_vld_dupx,
  input    wire  [6  :0]  lsu_idu_dc_pipe3_preg_dupx,
  input    wire           lsu_idu_dc_pipe3_vload_fwd_inst_vld,
  input    wire           lsu_idu_dc_pipe3_vload_inst_vld_dupx,
  input    wire  [6  :0]  lsu_idu_dc_pipe3_vreg_dupx,
  input    wire  [7  :0]  lsu_idu_vmb_create0_entry,
  input    wire  [7  :0]  lsu_idu_vmb_create1_entry,
  input    wire  [6  :0]  lsu_idu_wb_pipe3_wb_preg_dupx,
  input    wire           lsu_idu_wb_pipe3_wb_preg_vld_dupx,
  input    wire  [6  :0]  lsu_idu_wb_pipe3_wb_vreg_dupx,
  input    wire           lsu_idu_wb_pipe3_wb_vreg_vld_dupx,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_idu_flush_fe,
  input    wire           rtu_idu_flush_is,
  input    wire           rtu_idu_retire_int_vld,
  input    wire  [6  :0]  rtu_idu_rob_inst0_iid,
  input    wire  [6  :0]  rtu_idu_rob_inst1_iid,
  input    wire  [6  :0]  rtu_idu_rob_inst2_iid,
  input    wire  [6  :0]  rtu_idu_rob_inst3_iid,
  input    wire  [11 :0]  sdiq_aiq_create0_entry,
  input    wire  [11 :0]  sdiq_aiq_create1_entry,
  input    wire  [11 :0]  sdiq_dp_create0_entry,
  input    wire  [11 :0]  sdiq_dp_create1_entry,
  input    wire           vfpu_idu_ex1_pipe6_data_vld_dupx,
  input    wire           vfpu_idu_ex1_pipe6_fmla_data_vld_dupx,
  input    wire           vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex1_pipe6_preg_dupx,
  input    wire  [6  :0]  vfpu_idu_ex1_pipe6_vreg_dupx,
  input    wire           vfpu_idu_ex1_pipe7_data_vld_dupx,
  input    wire           vfpu_idu_ex1_pipe7_fmla_data_vld_dupx,
  input    wire           vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex1_pipe7_preg_dupx,
  input    wire  [6  :0]  vfpu_idu_ex1_pipe7_vreg_dupx,
  input    wire           vfpu_idu_ex2_pipe6_data_vld_dupx,
  input    wire           vfpu_idu_ex2_pipe6_fmla_data_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex2_pipe6_vreg_dupx,
  input    wire           vfpu_idu_ex2_pipe7_data_vld_dupx,
  input    wire           vfpu_idu_ex2_pipe7_fmla_data_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex2_pipe7_vreg_dupx,
  input    wire           vfpu_idu_ex3_pipe6_data_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex3_pipe6_vreg_dupx,
  input    wire           vfpu_idu_ex3_pipe7_data_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex3_pipe7_vreg_dupx,
  input    wire  [6  :0]  vfpu_idu_ex5_pipe6_wb_vreg_dupx,
  input    wire           vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx,
  input    wire  [6  :0]  vfpu_idu_ex5_pipe7_wb_vreg_dupx,
  input    wire           vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx,
  input    wire  [7  :0]  viq0_viq_create0_entry,
  input    wire  [7  :0]  viq0_viq_create1_entry,
  input    wire  [7  :0]  viq1_viq_create0_entry,
  input    wire  [7  :0]  viq1_viq_create1_entry,
  output   wire  [226:0]  dp_aiq0_bypass_data,
  output   wire  [226:0]  dp_aiq0_create0_data,
  output   wire  [226:0]  dp_aiq0_create1_data,
  output   wire           dp_aiq0_create_div,
  output   wire           dp_aiq0_create_src0_rdy_for_bypass,
  output   wire           dp_aiq0_create_src1_rdy_for_bypass,
  output   wire           dp_aiq0_create_src2_rdy_for_bypass,
  output   wire  [213:0]  dp_aiq1_bypass_data,
  output   wire  [213:0]  dp_aiq1_create0_data,
  output   wire  [213:0]  dp_aiq1_create1_data,
  output   wire           dp_aiq1_create_alu,
  output   wire           dp_aiq1_create_src0_rdy_for_bypass,
  output   wire           dp_aiq1_create_src1_rdy_for_bypass,
  output   wire           dp_aiq1_create_src2_rdy_for_bypass,
  output   wire  [6  :0]  dp_aiq_dis_inst0_src0_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst0_src1_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst0_src2_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst1_src0_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst1_src1_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst1_src2_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst2_src0_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst2_src1_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst2_src2_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst3_src0_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst3_src1_preg,
  output   wire  [6  :0]  dp_aiq_dis_inst3_src2_preg,
  output   wire           dp_aiq_sdiq_create0_src_sel,
  output   wire           dp_aiq_sdiq_create1_src_sel,
  output   wire  [81 :0]  dp_biq_bypass_data,
  output   wire  [81 :0]  dp_biq_create0_data,
  output   wire  [81 :0]  dp_biq_create1_data,
  output   wire           dp_biq_create_src0_rdy_for_bypass,
  output   wire           dp_biq_create_src1_rdy_for_bypass,
  output   wire  [12 :0]  dp_ctrl_is_dis_inst2_ctrl_info,
  output   wire  [12 :0]  dp_ctrl_is_dis_inst3_ctrl_info,
  output   wire           dp_ctrl_is_inst0_bar,
  output   wire           dp_ctrl_is_inst0_dst_vld,
  output   wire           dp_ctrl_is_inst0_dste_vld,
  output   wire           dp_ctrl_is_inst0_dstv_vec,
  output   wire           dp_ctrl_is_inst0_dstv_vld,
  output   wire           dp_ctrl_is_inst0_pcfifo,
  output   wire           dp_ctrl_is_inst1_bar,
  output   wire           dp_ctrl_is_inst1_dst_vld,
  output   wire           dp_ctrl_is_inst1_dste_vld,
  output   wire           dp_ctrl_is_inst1_dstv_vec,
  output   wire           dp_ctrl_is_inst1_dstv_vld,
  output   wire           dp_ctrl_is_inst1_pcfifo,
  output   wire           dp_ctrl_is_inst2_bar,
  output   wire           dp_ctrl_is_inst2_dst_vld,
  output   wire           dp_ctrl_is_inst2_dste_vld,
  output   wire           dp_ctrl_is_inst2_dstv_vec,
  output   wire           dp_ctrl_is_inst2_dstv_vld,
  output   wire           dp_ctrl_is_inst2_pcfifo,
  output   wire           dp_ctrl_is_inst3_bar,
  output   wire           dp_ctrl_is_inst3_dst_vld,
  output   wire           dp_ctrl_is_inst3_dste_vld,
  output   wire           dp_ctrl_is_inst3_dstv_vec,
  output   wire           dp_ctrl_is_inst3_dstv_vld,
  output   wire           dp_ctrl_is_inst3_pcfifo,
  output   wire  [162:0]  dp_lsiq_bypass_data,
  output   wire           dp_lsiq_create0_bar,
  output   wire  [162:0]  dp_lsiq_create0_data,
  output   wire           dp_lsiq_create0_load,
  output   wire           dp_lsiq_create0_no_spec,
  output   wire           dp_lsiq_create0_src0_rdy_for_bypass,
  output   wire           dp_lsiq_create0_src1_rdy_for_bypass,
  output   wire           dp_lsiq_create0_srcvm_rdy_for_bypass,
  output   wire           dp_lsiq_create0_store,
  output   wire           dp_lsiq_create1_bar,
  output   wire  [162:0]  dp_lsiq_create1_data,
  output   wire           dp_lsiq_create1_load,
  output   wire           dp_lsiq_create1_no_spec,
  output   wire           dp_lsiq_create1_store,
  output   wire  [26 :0]  dp_sdiq_create0_data,
  output   wire  [26 :0]  dp_sdiq_create1_data,
  output   wire  [150:0]  dp_viq0_bypass_data,
  output   wire  [150:0]  dp_viq0_create0_data,
  output   wire  [150:0]  dp_viq0_create1_data,
  output   wire           dp_viq0_create_srcv0_rdy_for_bypass,
  output   wire           dp_viq0_create_srcv1_rdy_for_bypass,
  output   wire           dp_viq0_create_srcv2_rdy_for_bypass,
  output   wire           dp_viq0_create_srcvm_rdy_for_bypass,
  output   wire           dp_viq0_create_vdiv,
  output   wire  [149:0]  dp_viq1_bypass_data,
  output   wire  [149:0]  dp_viq1_create0_data,
  output   wire  [149:0]  dp_viq1_create1_data,
  output   wire           dp_viq1_create_srcv0_rdy_for_bypass,
  output   wire           dp_viq1_create_srcv1_rdy_for_bypass,
  output   wire           dp_viq1_create_srcv2_rdy_for_bypass,
  output   wire           dp_viq1_create_srcvm_rdy_for_bypass,
  output   wire  [6  :0]  dp_viq_dis_inst0_srcv2_vreg,
  output   wire  [6  :0]  dp_viq_dis_inst1_srcv2_vreg,
  output   wire  [6  :0]  dp_viq_dis_inst2_srcv2_vreg,
  output   wire  [6  :0]  dp_viq_dis_inst3_srcv2_vreg,
  output   reg            idu_lsu_vmb_create0_dst_ready,
  output   reg   [11 :0]  idu_lsu_vmb_create0_sdiq_entry,
  output   reg   [6  :0]  idu_lsu_vmb_create0_split_num,
  output   reg            idu_lsu_vmb_create0_unit_stride,
  output   reg            idu_lsu_vmb_create0_vamo,
  output   reg   [7  :0]  idu_lsu_vmb_create0_vl,
  output   reg   [5  :0]  idu_lsu_vmb_create0_vreg,
  output   reg   [1  :0]  idu_lsu_vmb_create0_vsew,
  output   reg            idu_lsu_vmb_create1_dst_ready,
  output   reg   [11 :0]  idu_lsu_vmb_create1_sdiq_entry,
  output   reg   [6  :0]  idu_lsu_vmb_create1_split_num,
  output   reg            idu_lsu_vmb_create1_unit_stride,
  output   reg            idu_lsu_vmb_create1_vamo,
  output   reg   [7  :0]  idu_lsu_vmb_create1_vl,
  output   reg   [5  :0]  idu_lsu_vmb_create1_vreg,
  output   reg   [1  :0]  idu_lsu_vmb_create1_vsew,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst0_dst_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst0_dstv_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst0_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst0_ereg_iid,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst0_preg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst0_preg_iid,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst0_rel_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst0_rel_preg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst0_rel_vreg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst0_vreg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst0_vreg_iid,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst1_dst_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst1_dstv_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst1_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst1_ereg_iid,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst1_preg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst1_preg_iid,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst1_rel_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst1_rel_preg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst1_rel_vreg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst1_vreg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst1_vreg_iid,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst2_dst_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst2_dstv_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst2_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst2_ereg_iid,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst2_preg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst2_preg_iid,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst2_rel_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst2_rel_preg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst2_rel_vreg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst2_vreg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst2_vreg_iid,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst3_dst_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst3_dstv_reg,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst3_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst3_ereg_iid,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst3_preg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst3_preg_iid,
  output   wire  [4  :0]  idu_rtu_pst_dis_inst3_rel_ereg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst3_rel_preg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst3_rel_vreg,
  output   wire  [5  :0]  idu_rtu_pst_dis_inst3_vreg,
  output   wire  [6  :0]  idu_rtu_pst_dis_inst3_vreg_iid,
  output   reg   [39 :0]  idu_rtu_rob_create0_data,
  output   reg   [39 :0]  idu_rtu_rob_create1_data,
  output   reg   [39 :0]  idu_rtu_rob_create2_data,
  output   wire  [39 :0]  idu_rtu_rob_create3_data
); 



// &Regs; @28
reg     [271:0]  is_aiq0_create0_data;                   
reg     [6  :0]  is_aiq0_create0_iid;                    
reg     [23 :0]  is_aiq0_create0_lch_rdy_aiq0;           
reg     [23 :0]  is_aiq0_create0_lch_rdy_aiq1;           
reg     [23 :0]  is_aiq0_create0_lch_rdy_biq;            
reg     [23 :0]  is_aiq0_create0_lch_rdy_lsiq;           
reg     [11 :0]  is_aiq0_create0_lch_rdy_sdiq;           
reg     [4  :0]  is_aiq0_create0_pid;                    
reg     [271:0]  is_aiq0_create1_data;                   
reg     [6  :0]  is_aiq0_create1_iid;                    
reg     [23 :0]  is_aiq0_create1_lch_rdy_aiq0;           
reg     [23 :0]  is_aiq0_create1_lch_rdy_aiq1;           
reg     [23 :0]  is_aiq0_create1_lch_rdy_biq;            
reg     [23 :0]  is_aiq0_create1_lch_rdy_lsiq;           
reg     [11 :0]  is_aiq0_create1_lch_rdy_sdiq;           
reg     [4  :0]  is_aiq0_create1_pid;                    
reg     [271:0]  is_aiq1_create0_data;                   
reg     [6  :0]  is_aiq1_create0_iid;                    
reg     [23 :0]  is_aiq1_create0_lch_rdy_aiq0;           
reg     [23 :0]  is_aiq1_create0_lch_rdy_aiq1;           
reg     [23 :0]  is_aiq1_create0_lch_rdy_biq;            
reg     [23 :0]  is_aiq1_create0_lch_rdy_lsiq;           
reg     [11 :0]  is_aiq1_create0_lch_rdy_sdiq;           
reg     [271:0]  is_aiq1_create1_data;                   
reg     [6  :0]  is_aiq1_create1_iid;                    
reg     [23 :0]  is_aiq1_create1_lch_rdy_aiq0;           
reg     [23 :0]  is_aiq1_create1_lch_rdy_aiq1;           
reg     [23 :0]  is_aiq1_create1_lch_rdy_biq;            
reg     [23 :0]  is_aiq1_create1_lch_rdy_lsiq;           
reg     [11 :0]  is_aiq1_create1_lch_rdy_sdiq;           
reg     [271:0]  is_biq_create0_data;                    
reg     [6  :0]  is_biq_create0_iid;                     
reg     [4  :0]  is_biq_create0_pid;                     
reg     [271:0]  is_biq_create1_data;                    
reg     [6  :0]  is_biq_create1_iid;                     
reg     [4  :0]  is_biq_create1_pid;                     
reg     [3  :0]  is_inst01_create_src_match;             
reg     [3  :0]  is_inst01_src_match;                    
reg     [3  :0]  is_inst02_create_src_match;             
reg     [3  :0]  is_inst02_src_match;                    
reg     [3  :0]  is_inst03_create_src_match;             
reg     [3  :0]  is_inst03_src_match;                    
reg     [2  :0]  is_inst0_aiq0_create0_src_match;        
reg     [2  :0]  is_inst0_aiq0_create1_src_match;        
reg     [2  :0]  is_inst0_aiq1_create0_src_match;        
reg     [2  :0]  is_inst0_aiq1_create1_src_match;        
reg     [1  :0]  is_inst0_biq_create0_src_match;         
reg     [1  :0]  is_inst0_biq_create1_src_match;         
reg     [271:0]  is_inst0_create_data;                   
reg     [1  :0]  is_inst0_lsiq_create0_src_match;        
reg     [1  :0]  is_inst0_lsiq_create1_src_match;        
reg              is_inst0_sdiq_create0_src_match;        
reg              is_inst0_sdiq_create1_src_match;        
reg              is_inst0_viq0_create0_src_match;        
reg              is_inst0_viq0_create1_src_match;        
reg              is_inst0_viq1_create0_src_match;        
reg              is_inst0_viq1_create1_src_match;        
reg     [3  :0]  is_inst12_create_src_match;             
reg     [3  :0]  is_inst12_src_match;                    
reg     [3  :0]  is_inst13_create_src_match;             
reg     [3  :0]  is_inst13_src_match;                    
reg     [2  :0]  is_inst1_aiq0_create0_src_match;        
reg     [2  :0]  is_inst1_aiq0_create1_src_match;        
reg     [2  :0]  is_inst1_aiq1_create0_src_match;        
reg     [2  :0]  is_inst1_aiq1_create1_src_match;        
reg     [1  :0]  is_inst1_biq_create0_src_match;         
reg     [1  :0]  is_inst1_biq_create1_src_match;         
reg     [271:0]  is_inst1_create_data;                   
reg     [1  :0]  is_inst1_lsiq_create0_src_match;        
reg     [1  :0]  is_inst1_lsiq_create1_src_match;        
reg              is_inst1_sdiq_create0_src_match;        
reg              is_inst1_sdiq_create1_src_match;        
reg              is_inst1_viq0_create0_src_match;        
reg              is_inst1_viq0_create1_src_match;        
reg              is_inst1_viq1_create0_src_match;        
reg              is_inst1_viq1_create1_src_match;        
reg     [3  :0]  is_inst23_create_src_match;             
reg     [3  :0]  is_inst23_src_match;                    
reg     [2  :0]  is_inst2_aiq0_create0_src_match;        
reg     [2  :0]  is_inst2_aiq0_create1_src_match;        
reg     [2  :0]  is_inst2_aiq1_create0_src_match;        
reg     [2  :0]  is_inst2_aiq1_create1_src_match;        
reg     [4  :0]  is_inst2_alloc_pid;                     
reg     [1  :0]  is_inst2_biq_create0_src_match;         
reg     [1  :0]  is_inst2_biq_create1_src_match;         
reg     [271:0]  is_inst2_create_data;                   
reg     [1  :0]  is_inst2_lsiq_create0_src_match;        
reg     [1  :0]  is_inst2_lsiq_create1_src_match;        
reg              is_inst2_sdiq_create0_src_match;        
reg              is_inst2_sdiq_create1_src_match;        
reg              is_inst2_viq0_create0_src_match;        
reg              is_inst2_viq0_create1_src_match;        
reg              is_inst2_viq1_create0_src_match;        
reg              is_inst2_viq1_create1_src_match;        
reg     [4  :0]  is_inst3_alloc_pid;                     
reg     [271:0]  is_inst3_create_data;                   
reg     [271:0]  is_lsiq_create0_data;                   
reg     [6  :0]  is_lsiq_create0_iid;                    
reg     [271:0]  is_lsiq_create1_data;                   
reg     [6  :0]  is_lsiq_create1_iid;                    
reg     [271:0]  is_sdiq_create0_data;                   
reg     [271:0]  is_sdiq_create1_data;                   
reg     [271:0]  is_viq0_create0_data;                   
reg     [6  :0]  is_viq0_create0_iid;                    
reg     [7  :0]  is_viq0_create0_lch_rdy_viq0;           
reg     [7  :0]  is_viq0_create0_lch_rdy_viq1;           
reg     [271:0]  is_viq0_create1_data;                   
reg     [6  :0]  is_viq0_create1_iid;                    
reg     [7  :0]  is_viq0_create1_lch_rdy_viq0;           
reg     [7  :0]  is_viq0_create1_lch_rdy_viq1;           
reg     [271:0]  is_viq1_create0_data;                   
reg     [6  :0]  is_viq1_create0_iid;                    
reg     [7  :0]  is_viq1_create0_lch_rdy_viq0;           
reg     [7  :0]  is_viq1_create0_lch_rdy_viq1;           
reg     [271:0]  is_viq1_create1_data;                   
reg     [6  :0]  is_viq1_create1_iid;                    
reg     [7  :0]  is_viq1_create1_lch_rdy_viq0;           
reg     [7  :0]  is_viq1_create1_lch_rdy_viq1;           

// &Wires; @29
wire    [226:0]  aiq0_create0_data;                      
wire    [226:0]  aiq0_create1_data;                      
wire    [213:0]  aiq1_create0_data;                      
wire    [213:0]  aiq1_create1_data;                      
wire    [81 :0]  biq_create0_data;                       
wire    [81 :0]  biq_create1_data;                       
wire    [7  :0]  ctrl_is_aiq0_create0_entry;             
wire    [7  :0]  ctrl_is_aiq0_create1_entry;             
wire    [7  :0]  ctrl_is_aiq1_create0_entry;             
wire    [7  :0]  ctrl_is_aiq1_create1_entry;             
wire    [11 :0]  ctrl_is_biq_create0_entry;              
wire    [11 :0]  ctrl_is_biq_create1_entry;              
wire    [11 :0]  ctrl_is_lsiq_create0_entry;             
wire    [11 :0]  ctrl_is_lsiq_create1_entry;             
wire    [11 :0]  ctrl_is_sdiq_create0_entry;             
wire    [11 :0]  ctrl_is_sdiq_create1_entry;             
wire    [7  :0]  ctrl_is_viq0_create0_entry;             
wire    [7  :0]  ctrl_is_viq0_create1_entry;             
wire    [7  :0]  ctrl_is_viq1_create0_entry;             
wire    [7  :0]  ctrl_is_viq1_create1_entry;             
wire    [6  :0]  dis_inst0_iid;                          
wire    [6  :0]  dis_inst1_iid;                          
wire    [6  :0]  dis_inst2_iid;                          
wire    [6  :0]  dis_inst3_iid;                          
wire             dp_lsiq_create0_sti_sel;                
wire             dp_lsiq_create1_sti_sel;                
wire             dp_sdiq_create0_sti_sel;                
wire             dp_sdiq_create1_sti_sel;                
wire             is_dis_inst012_bkpta_inst;              
wire             is_dis_inst012_bkptb_inst;              
wire             is_dis_inst012_fp_dirty;                
wire    [2  :0]  is_dis_inst012_pc_offset;               
wire             is_dis_inst012_vec_dirty;               
wire             is_dis_inst01_bkpta_inst;               
wire             is_dis_inst01_bkptb_inst;               
wire             is_dis_inst01_fp_dirty;                 
wire    [2  :0]  is_dis_inst01_pc_offset;                
wire             is_dis_inst01_vec_dirty;                
wire             is_dis_inst0_fp_dirty;                  
wire    [2  :0]  is_dis_inst0_pc_offset;                 
wire             is_dis_inst0_ras;                       
wire             is_dis_inst0_vec_dirty;                 
wire             is_dis_inst123_bkpta_inst;              
wire             is_dis_inst123_bkptb_inst;              
wire             is_dis_inst123_fp_dirty;                
wire    [2  :0]  is_dis_inst123_pc_offset;               
wire             is_dis_inst123_vec_dirty;               
wire             is_dis_inst12_bkpta_inst;               
wire             is_dis_inst12_bkptb_inst;               
wire             is_dis_inst12_fp_dirty;                 
wire    [2  :0]  is_dis_inst12_pc_offset;                
wire             is_dis_inst12_vec_dirty;                
wire             is_dis_inst1_fp_dirty;                  
wire    [2  :0]  is_dis_inst1_pc_offset;                 
wire             is_dis_inst1_ras;                       
wire             is_dis_inst1_vec_dirty;                 
wire             is_dis_inst23_bkpta_inst;               
wire             is_dis_inst23_bkptb_inst;               
wire             is_dis_inst23_fp_dirty;                 
wire    [2  :0]  is_dis_inst23_pc_offset;                
wire             is_dis_inst23_vec_dirty;                
wire             is_dis_inst2_fp_dirty;                  
wire    [2  :0]  is_dis_inst2_pc_offset;                 
wire             is_dis_inst2_ras;                       
wire             is_dis_inst2_vec_dirty;                 
wire             is_dis_inst3_fp_dirty;                  
wire    [2  :0]  is_dis_inst3_pc_offset;                 
wire             is_dis_inst3_ras;                       
wire             is_dis_inst3_vec_dirty;                 
wire    [4  :0]  is_inst0_alloc_pid;                     
wire             is_inst0_create_dp_en;                  
wire             is_inst0_create_gateclk_en;             
wire             is_inst0_entry_vld;                     
wire    [6  :0]  is_inst0_iid;                           
wire    [23 :0]  is_inst0_lch_rdy_aiq0;                  
wire    [23 :0]  is_inst0_lch_rdy_aiq0_create0;          
wire    [23 :0]  is_inst0_lch_rdy_aiq0_create1;          
wire    [23 :0]  is_inst0_lch_rdy_aiq1;                  
wire    [23 :0]  is_inst0_lch_rdy_aiq1_create0;          
wire    [23 :0]  is_inst0_lch_rdy_aiq1_create1;          
wire    [23 :0]  is_inst0_lch_rdy_biq;                   
wire    [23 :0]  is_inst0_lch_rdy_biq_create0;           
wire    [23 :0]  is_inst0_lch_rdy_biq_create1;           
wire    [23 :0]  is_inst0_lch_rdy_lsiq;                  
wire    [23 :0]  is_inst0_lch_rdy_lsiq_create0;          
wire    [23 :0]  is_inst0_lch_rdy_lsiq_create1;          
wire    [11 :0]  is_inst0_lch_rdy_sdiq;                  
wire    [11 :0]  is_inst0_lch_rdy_sdiq_create0;          
wire    [11 :0]  is_inst0_lch_rdy_sdiq_create1;          
wire    [7  :0]  is_inst0_lch_rdy_viq0;                  
wire    [7  :0]  is_inst0_lch_rdy_viq0_create0;          
wire    [7  :0]  is_inst0_lch_rdy_viq0_create1;          
wire    [7  :0]  is_inst0_lch_rdy_viq1;                  
wire    [7  :0]  is_inst0_lch_rdy_viq1_create0;          
wire    [7  :0]  is_inst0_lch_rdy_viq1_create1;          
wire             is_inst0_pcfifo;                        
wire    [4  :0]  is_inst0_pid;                           
wire    [271:0]  is_inst0_read_data;                     
wire    [6  :0]  is_inst0_src0_preg;                     
wire    [6  :0]  is_inst0_src1_preg;                     
wire    [6  :0]  is_inst0_src2_preg;                     
wire    [6  :0]  is_inst0_srcv2_vreg;                    
wire    [4  :0]  is_inst1_alloc_pid;                     
wire             is_inst1_create_dp_en;                  
wire             is_inst1_create_gateclk_en;             
wire             is_inst1_entry_vld;                     
wire    [6  :0]  is_inst1_iid;                           
wire    [23 :0]  is_inst1_lch_rdy_aiq0;                  
wire    [23 :0]  is_inst1_lch_rdy_aiq0_create0;          
wire    [23 :0]  is_inst1_lch_rdy_aiq0_create1;          
wire    [23 :0]  is_inst1_lch_rdy_aiq1;                  
wire    [23 :0]  is_inst1_lch_rdy_aiq1_create0;          
wire    [23 :0]  is_inst1_lch_rdy_aiq1_create1;          
wire    [23 :0]  is_inst1_lch_rdy_biq;                   
wire    [23 :0]  is_inst1_lch_rdy_biq_create0;           
wire    [23 :0]  is_inst1_lch_rdy_biq_create1;           
wire    [23 :0]  is_inst1_lch_rdy_lsiq;                  
wire    [23 :0]  is_inst1_lch_rdy_lsiq_create0;          
wire    [23 :0]  is_inst1_lch_rdy_lsiq_create1;          
wire    [11 :0]  is_inst1_lch_rdy_sdiq;                  
wire    [11 :0]  is_inst1_lch_rdy_sdiq_create0;          
wire    [11 :0]  is_inst1_lch_rdy_sdiq_create1;          
wire    [7  :0]  is_inst1_lch_rdy_viq0;                  
wire    [7  :0]  is_inst1_lch_rdy_viq0_create0;          
wire    [7  :0]  is_inst1_lch_rdy_viq0_create1;          
wire    [7  :0]  is_inst1_lch_rdy_viq1;                  
wire    [7  :0]  is_inst1_lch_rdy_viq1_create0;          
wire    [7  :0]  is_inst1_lch_rdy_viq1_create1;          
wire             is_inst1_pcfifo;                        
wire    [4  :0]  is_inst1_pid;                           
wire    [271:0]  is_inst1_read_data;                     
wire    [6  :0]  is_inst1_src0_preg;                     
wire    [6  :0]  is_inst1_src1_preg;                     
wire    [6  :0]  is_inst1_src2_preg;                     
wire    [6  :0]  is_inst1_srcv2_vreg;                    
wire             is_inst2_create_dp_en;                  
wire             is_inst2_create_gateclk_en;             
wire             is_inst2_entry_vld;                     
wire    [6  :0]  is_inst2_iid;                           
wire    [23 :0]  is_inst2_lch_rdy_aiq0;                  
wire    [23 :0]  is_inst2_lch_rdy_aiq0_create0;          
wire    [23 :0]  is_inst2_lch_rdy_aiq0_create1;          
wire    [23 :0]  is_inst2_lch_rdy_aiq1;                  
wire    [23 :0]  is_inst2_lch_rdy_aiq1_create0;          
wire    [23 :0]  is_inst2_lch_rdy_aiq1_create1;          
wire    [23 :0]  is_inst2_lch_rdy_biq;                   
wire    [23 :0]  is_inst2_lch_rdy_biq_create0;           
wire    [23 :0]  is_inst2_lch_rdy_biq_create1;           
wire    [23 :0]  is_inst2_lch_rdy_lsiq;                  
wire    [23 :0]  is_inst2_lch_rdy_lsiq_create0;          
wire    [23 :0]  is_inst2_lch_rdy_lsiq_create1;          
wire    [11 :0]  is_inst2_lch_rdy_sdiq;                  
wire    [11 :0]  is_inst2_lch_rdy_sdiq_create0;          
wire    [11 :0]  is_inst2_lch_rdy_sdiq_create1;          
wire    [7  :0]  is_inst2_lch_rdy_viq0;                  
wire    [7  :0]  is_inst2_lch_rdy_viq0_create0;          
wire    [7  :0]  is_inst2_lch_rdy_viq0_create1;          
wire    [7  :0]  is_inst2_lch_rdy_viq1;                  
wire    [7  :0]  is_inst2_lch_rdy_viq1_create0;          
wire    [7  :0]  is_inst2_lch_rdy_viq1_create1;          
wire             is_inst2_pcfifo;                        
wire    [4  :0]  is_inst2_pid;                           
wire    [271:0]  is_inst2_read_data;                     
wire    [6  :0]  is_inst2_src0_preg;                     
wire    [6  :0]  is_inst2_src1_preg;                     
wire    [6  :0]  is_inst2_src2_preg;                     
wire    [6  :0]  is_inst2_srcv2_vreg;                    
wire             is_inst3_create_dp_en;                  
wire             is_inst3_create_gateclk_en;             
wire             is_inst3_entry_vld;                     
wire    [6  :0]  is_inst3_iid;                           
wire    [23 :0]  is_inst3_lch_rdy_aiq0;                  
wire    [23 :0]  is_inst3_lch_rdy_aiq1;                  
wire    [23 :0]  is_inst3_lch_rdy_biq;                   
wire    [23 :0]  is_inst3_lch_rdy_lsiq;                  
wire    [11 :0]  is_inst3_lch_rdy_sdiq;                  
wire    [7  :0]  is_inst3_lch_rdy_viq0;                  
wire    [7  :0]  is_inst3_lch_rdy_viq1;                  
wire             is_inst3_pcfifo;                        
wire    [4  :0]  is_inst3_pid;                           
wire    [271:0]  is_inst3_read_data;                     
wire    [6  :0]  is_inst3_src0_preg;                     
wire    [6  :0]  is_inst3_src1_preg;                     
wire    [6  :0]  is_inst3_src2_preg;                     
wire    [6  :0]  is_inst3_srcv2_vreg;                    
wire             is_inst_clk;                            
wire             is_inst_clk_en;                         
wire             is_inst_create_dp_en;                   
wire             is_inst_create_gateclk_en;              
wire    [11 :0]  is_lsiq_create0_entry;                  
wire    [11 :0]  is_lsiq_create0_sdiq_entry;             
wire    [11 :0]  is_lsiq_create1_entry;                  
wire    [11 :0]  is_lsiq_create1_sdiq_entry;             
wire    [162:0]  lsiq_create0_data;                      
wire    [162:0]  lsiq_create1_data;                      
wire    [26 :0]  sdiq_create0_data;                      
wire    [26 :0]  sdiq_create1_data;                      
wire             sdiq_vmb_create1_dp_en;                 
wire    [11 :0]  sdiq_vmb_create1_entry;                 
wire    [150:0]  viq0_create0_data;                      
wire    [150:0]  viq0_create1_data;                      
wire    [149:0]  viq1_create0_data;                      
wire    [149:0]  viq1_create1_data;                      


//==========================================================
//                       Parameters
//==========================================================
//----------------------------------------------------------
//                 IS ctrl path parameters
//----------------------------------------------------------
parameter IS_CTRL_WIDTH       = 13;

parameter IS_CTRL_VMB         = 12;
parameter IS_CTRL_PIPE7       = 11;
parameter IS_CTRL_PIPE6       = 10;
parameter IS_CTRL_PIPE67      = 9;
parameter IS_CTRL_SPECIAL     = 8;
parameter IS_CTRL_STADDR      = 7;
parameter IS_CTRL_INTMASK     = 6;
parameter IS_CTRL_SPLIT       = 5;
parameter IS_CTRL_LSU         = 4;
parameter IS_CTRL_BJU         = 3;
parameter IS_CTRL_DIV         = 2;
parameter IS_CTRL_MULT        = 1;
parameter IS_CTRL_ALU         = 0;

//----------------------------------------------------------
//                 IR/IS pipeline select
//----------------------------------------------------------
parameter IS_WIDTH             = 272;

parameter IS_VL_PRED           = 271;
parameter IS_VL                = 270;
parameter IS_LCH_PREG          = 262;
parameter IS_VAMO              = 261;
parameter IS_UNIT_STRIDE       = 260;
parameter IS_VMB               = 259;
parameter IS_DSTV_IMP          = 258;
parameter IS_VIQ_SRCV12_SWITCH = 257;
parameter IS_VSETVL            = 256;
parameter IS_VSETVLI           = 255;
parameter IS_VSEW              = 254;
parameter IS_VLMUL             = 251;
parameter IS_VMUL              = 249;
parameter IS_VMUL_UNSPLIT      = 248;
parameter IS_VMLA_SHORT        = 247;
parameter IS_VMLA_TYPE         = 246;
parameter IS_SPLIT_NUM         = 243;
parameter IS_NO_SPEC           = 236;
parameter IS_ALU_SHORT         = 235;
parameter IS_MLA               = 234;
parameter IS_STR               = 233;
parameter IS_SPLIT_LAST        = 232;
parameter IS_MFVR              = 231;
parameter IS_MTVR              = 230;
parameter IS_VMLA              = 229;
parameter IS_VDIV              = 228;
parameter IS_PIPE7             = 227;
parameter IS_PIPE6             = 226;
parameter IS_PIPE67            = 225;
parameter IS_IID_PLUS          = 224;
parameter IS_BKPTB_INST        = 220;
parameter IS_BKPTA_INST        = 219;
parameter IS_EXPT              = 218;
parameter IS_RTS               = 211;
parameter IS_SPECIAL           = 210;
parameter IS_LSU               = 209;
parameter IS_DIV               = 208;
parameter IS_MULT              = 207;
parameter IS_INTMASK           = 206;
parameter IS_SPLIT             = 205;
parameter IS_LENGTH            = 204;
parameter IS_PCFIFO            = 203;
parameter IS_PCALL             = 202;
parameter IS_BJU               = 201;
parameter IS_LSU_PC            = 200;
parameter IS_BAR_TYPE          = 185;
parameter IS_BAR               = 181;
parameter IS_STADDR            = 180;
parameter IS_STORE             = 179;
parameter IS_LOAD              = 178;
parameter IS_ALU               = 177;
parameter IS_DST_REL_EREG      = 176;
parameter IS_DST_EREG          = 171;
parameter IS_DST_REL_VREG      = 166;
parameter IS_DST_VREG          = 159;
parameter IS_DSTV_REG          = 152;
parameter IS_SRCVM_LSU_MATCH   = 147;
parameter IS_SRCVM_BP_RDY      = 146;
parameter IS_SRCVM_DATA        = 144;
parameter IS_SRCVM_VREG        = 144;
parameter IS_SRCVM_WB          = 137;
parameter IS_SRCV2_LSU_MATCH   = 135;
parameter IS_SRCV2_BP_RDY      = 134;
parameter IS_SRCV2_DATA        = 132;
parameter IS_SRCV2_VREG        = 131;
parameter IS_SRCV2_WB          = 124;
parameter IS_SRCV1_LSU_MATCH   = 122;
parameter IS_SRCV1_BP_RDY      = 121;
parameter IS_SRCV1_DATA        = 119;
parameter IS_SRCV1_VREG        = 119;
parameter IS_SRCV1_WB          = 112;
parameter IS_SRCV0_LSU_MATCH   = 110;
parameter IS_SRCV0_BP_RDY      = 109;
parameter IS_SRCV0_DATA        = 107;
parameter IS_SRCV0_VREG        = 107;
parameter IS_SRCV0_WB          = 100;
parameter IS_DSTE_VLD          = 98;
parameter IS_DSTV_VLD          = 97;
parameter IS_SRCVM_VLD         = 96;
parameter IS_SRCV2_VLD         = 95;
parameter IS_SRCV1_VLD         = 94;
parameter IS_SRCV0_VLD         = 93;
parameter IS_DST_REL_PREG      = 92;
parameter IS_DST_PREG          = 85;
parameter IS_DST_REG           = 78;
parameter IS_SRC2_LSU_MATCH    = 72;
parameter IS_SRC2_BP_RDY       = 71;
parameter IS_SRC2_DATA         = 69;
parameter IS_SRC2_PREG         = 68;
parameter IS_SRC2_WB           = 61;
parameter IS_SRC1_LSU_MATCH    = 59;
parameter IS_SRC1_BP_RDY       = 58;
parameter IS_SRC1_DATA         = 56;
parameter IS_SRC1_PREG         = 56;
parameter IS_SRC1_WB           = 49;
parameter IS_SRC0_LSU_MATCH    = 47;
parameter IS_SRC0_BP_RDY       = 46;
parameter IS_SRC0_DATA         = 44;
parameter IS_SRC0_PREG         = 44;
parameter IS_SRC0_WB           = 37;
parameter IS_DST_VLD           = 35;
parameter IS_SRC2_VLD          = 34;
parameter IS_SRC1_VLD          = 33;
parameter IS_SRC0_VLD          = 32;
parameter IS_OPCODE            = 31;

//----------------------------------------------------------
//                    AIQ0 Parameters
//----------------------------------------------------------
parameter AIQ0_WIDTH             = 227;

parameter AIQ0_VL                = 226;
parameter AIQ0_LCH_PREG          = 218;
parameter AIQ0_SPECIAL           = 217;
parameter AIQ0_VSEW              = 216;
parameter AIQ0_VLMUL             = 213;
parameter AIQ0_LCH_RDY_SDIQ      = 211;
parameter AIQ0_LCH_RDY_LSIQ      = 199;
parameter AIQ0_LCH_RDY_BIQ       = 175;
parameter AIQ0_LCH_RDY_AIQ1      = 151;
parameter AIQ0_LCH_RDY_AIQ0      = 127;
parameter AIQ0_ALU_SHORT         = 103;
parameter AIQ0_PID               = 102;
parameter AIQ0_PCFIFO            = 97;
parameter AIQ0_MTVR              = 96;
parameter AIQ0_DIV               = 95;
parameter AIQ0_HIGH_HW_EXPT      = 94;
parameter AIQ0_EXPT_VEC          = 93;
parameter AIQ0_EXPT_VLD          = 88;
parameter AIQ0_SRC2_LSU_MATCH    = 87;
parameter AIQ0_SRC2_DATA         = 86;
parameter AIQ0_SRC2_PREG         = 86;
parameter AIQ0_SRC2_WB           = 79;
parameter AIQ0_SRC2_RDY          = 78;
parameter AIQ0_SRC1_LSU_MATCH    = 77;
parameter AIQ0_SRC1_DATA         = 76;
parameter AIQ0_SRC1_PREG         = 76;
parameter AIQ0_SRC1_WB           = 69;
parameter AIQ0_SRC1_RDY          = 68;
parameter AIQ0_SRC0_LSU_MATCH    = 67;
parameter AIQ0_SRC0_DATA         = 66;
parameter AIQ0_SRC0_PREG         = 66;
parameter AIQ0_SRC0_WB           = 59;
parameter AIQ0_SRC0_RDY          = 58;
parameter AIQ0_DST_VREG          = 57;
parameter AIQ0_DST_PREG          = 50;
parameter AIQ0_DSTV_VLD          = 43;
parameter AIQ0_DST_VLD           = 42;
parameter AIQ0_SRC2_VLD          = 41;
parameter AIQ0_SRC1_VLD          = 40;
parameter AIQ0_SRC0_VLD          = 39;
parameter AIQ0_IID               = 38;
parameter AIQ0_OPCODE            = 31;

//----------------------------------------------------------
//                    AIQ1 Parameters
//----------------------------------------------------------
parameter AIQ1_WIDTH             = 214;

parameter AIQ1_VL                = 213;
parameter AIQ1_LCH_PREG          = 205;
parameter AIQ1_VSEW              = 204;
parameter AIQ1_VLMUL             = 201;
parameter AIQ1_LCH_RDY_SDIQ      = 199;
parameter AIQ1_LCH_RDY_LSIQ      = 187;
parameter AIQ1_LCH_RDY_BIQ       = 163;
parameter AIQ1_LCH_RDY_AIQ1      = 139;
parameter AIQ1_LCH_RDY_AIQ0      = 115;
parameter AIQ1_ALU_SHORT         = 91;
parameter AIQ1_MLA               = 90;
parameter AIQ1_MTVR              = 89;
parameter AIQ1_SRC2_LSU_MATCH    = 88;
parameter AIQ1_SRC2_DATA         = 87;
parameter AIQ1_SRC2_PREG         = 86;
parameter AIQ1_SRC2_WB           = 79;
parameter AIQ1_SRC2_RDY          = 78;
parameter AIQ1_SRC1_LSU_MATCH    = 77;
parameter AIQ1_SRC1_DATA         = 76;
parameter AIQ1_SRC1_PREG         = 76;
parameter AIQ1_SRC1_WB           = 69;
parameter AIQ1_SRC1_RDY          = 68;
parameter AIQ1_SRC0_LSU_MATCH    = 67;
parameter AIQ1_SRC0_DATA         = 66;
parameter AIQ1_SRC0_PREG         = 66;
parameter AIQ1_SRC0_WB           = 59;
parameter AIQ1_SRC0_RDY          = 58;
parameter AIQ1_DST_VREG          = 57;
parameter AIQ1_DST_PREG          = 50;
parameter AIQ1_DSTV_VLD          = 43;
parameter AIQ1_DST_VLD           = 42;
parameter AIQ1_SRC2_VLD          = 41;
parameter AIQ1_SRC1_VLD          = 40;
parameter AIQ1_SRC0_VLD          = 39;
parameter AIQ1_IID               = 38;
parameter AIQ1_OPCODE            = 31;

//----------------------------------------------------------
//                    BIQ Parameters
//----------------------------------------------------------
parameter BIQ_WIDTH             = 82;

parameter BIQ_VL                = 81;
parameter BIQ_VSEW              = 73;
parameter BIQ_VLMUL             = 70;
parameter BIQ_PCALL             = 68;
parameter BIQ_RTS               = 67;
parameter BIQ_PID               = 66;
parameter BIQ_LENGTH            = 61;
parameter BIQ_SRC1_LSU_MATCH    = 60;
parameter BIQ_SRC1_DATA         = 59;
parameter BIQ_SRC1_PREG         = 59;
parameter BIQ_SRC1_WB           = 52;
parameter BIQ_SRC1_RDY          = 51;
parameter BIQ_SRC0_LSU_MATCH    = 50;
parameter BIQ_SRC0_DATA         = 49;
parameter BIQ_SRC0_PREG         = 49;
parameter BIQ_SRC0_WB           = 42;
parameter BIQ_SRC0_RDY          = 41;
parameter BIQ_SRC1_VLD          = 40;
parameter BIQ_SRC0_VLD          = 39;
parameter BIQ_IID               = 38;
parameter BIQ_OPCODE            = 31;

//----------------------------------------------------------
//                    LSIQ Parameters
//----------------------------------------------------------
parameter LSIQ_WIDTH             = 163;

parameter LSIQ_VL                = 162;
parameter LSIQ_VMB               = 154;
parameter LSIQ_SPLIT_NUM         = 153;
parameter LSIQ_VSEW              = 146;
parameter LSIQ_VLMUL             = 143;
parameter LSIQ_BKPTB_DATA        = 141;
parameter LSIQ_BKPTA_DATA        = 140;
parameter LSIQ_AGEVEC_ALL        = 139;
parameter LSIQ_ALREADY_DA        = 128;
parameter LSIQ_UNALIGN_2ND       = 127;
parameter LSIQ_SPEC_FAIL         = 126;
parameter LSIQ_NO_SPEC_EXIST     = 125;
parameter LSIQ_NO_SPEC           = 124;
parameter LSIQ_SPLIT             = 123;
parameter LSIQ_SDIQ_ENTRY        = 122;
parameter LSIQ_STADDR            = 110;
parameter LSIQ_PC                = 109;
parameter LSIQ_BAR_TYPE          = 94;
parameter LSIQ_BAR               = 90;
parameter LSIQ_STORE             = 89;
parameter LSIQ_LOAD              = 88;
parameter LSIQ_SRCVM_LSU_MATCH   = 87;
parameter LSIQ_SRCVM_DATA        = 86;
parameter LSIQ_SRCVM_VREG        = 86;
parameter LSIQ_SRCVM_WB          = 79;
parameter LSIQ_SRCVM_RDY         = 78;
parameter LSIQ_SRC1_LSU_MATCH    = 77;
parameter LSIQ_SRC1_DATA         = 76;
parameter LSIQ_SRC1_PREG         = 76;
parameter LSIQ_SRC1_WB           = 69;
parameter LSIQ_SRC1_RDY          = 68;
parameter LSIQ_SRC0_LSU_MATCH    = 67;
parameter LSIQ_SRC0_DATA         = 66;
parameter LSIQ_SRC0_PREG         = 66;
parameter LSIQ_SRC0_WB           = 59;
parameter LSIQ_SRC0_RDY          = 58;
parameter LSIQ_DST_VREG          = 57;
parameter LSIQ_DST_PREG          = 50;
parameter LSIQ_DSTV_VLD          = 43;
parameter LSIQ_DST_VLD           = 42;
parameter LSIQ_SRCVM_VLD         = 41;
parameter LSIQ_SRC1_VLD          = 40;
parameter LSIQ_SRC0_VLD          = 39;
parameter LSIQ_IID               = 38;
parameter LSIQ_OPCODE            = 31;

//----------------------------------------------------------
//                    SDIQ Parameters
//----------------------------------------------------------
parameter SDIQ_WIDTH             = 27;

parameter SDIQ_LOAD              = 26;
parameter SDIQ_STADDR1_IN_STQ    = 25;
parameter SDIQ_STADDR0_IN_STQ    = 24;
parameter SDIQ_STDATA1_VLD       = 23;
parameter SDIQ_UNALIGN           = 22;
parameter SDIQ_SRCV0_LSU_MATCH   = 21;
parameter SDIQ_SRCV0_DATA        = 20;
parameter SDIQ_SRCV0_VREG        = 20;
parameter SDIQ_SRCV0_WB          = 13;
parameter SDIQ_SRCV0_RDY         = 12;
parameter SDIQ_SRC0_LSU_MATCH    = 11;
parameter SDIQ_SRC0_DATA         = 10;
parameter SDIQ_SRC0_PREG         = 10;
parameter SDIQ_SRC0_WB           = 3;
parameter SDIQ_SRC0_RDY          = 2;
parameter SDIQ_SRCV0_VLD         = 1;
parameter SDIQ_SRC0_VLD          = 0;

//----------------------------------------------------------
//                    VIQ0 Parameters
//----------------------------------------------------------
parameter VIQ0_WIDTH             = 151;

parameter VIQ0_VL                = 150;
parameter VIQ0_VSEW              = 142;
parameter VIQ0_VLMUL             = 139;
parameter VIQ0_VMUL              = 137;
parameter VIQ0_VMLA_SHORT        = 136;
parameter VIQ0_VDIV              = 135;
parameter VIQ0_LCH_RDY_VIQ1      = 134;
parameter VIQ0_LCH_RDY_VIQ0      = 126;
parameter VIQ0_VMLA_TYPE         = 118;
parameter VIQ0_SPLIT_NUM         = 115;
parameter VIQ0_SPLIT_LAST        = 108;
parameter VIQ0_MFVR              = 107;
parameter VIQ0_VMLA              = 106;
parameter VIQ0_SRCVM_DATA        = 105;
parameter VIQ0_SRCVM_LSU_MATCH   = 105;
parameter VIQ0_SRCVM_VREG        = 104;
parameter VIQ0_SRCVM_WB          = 97;
parameter VIQ0_SRCVM_RDY         = 96;
parameter VIQ0_SRCV2_DATA        = 95;
parameter VIQ0_SRCV2_LSU_MATCH   = 95;
parameter VIQ0_SRCV2_VREG        = 93;
parameter VIQ0_SRCV2_WB          = 86;
parameter VIQ0_SRCV2_RDY         = 85;
parameter VIQ0_SRCV1_DATA        = 84;
parameter VIQ0_SRCV1_LSU_MATCH   = 84;
parameter VIQ0_SRCV1_VREG        = 83;
parameter VIQ0_SRCV1_WB          = 76;
parameter VIQ0_SRCV1_RDY         = 75;
parameter VIQ0_SRCV0_DATA        = 74;
parameter VIQ0_SRCV0_LSU_MATCH   = 74;
parameter VIQ0_SRCV0_VREG        = 73;
parameter VIQ0_SRCV0_WB          = 66;
parameter VIQ0_SRCV0_RDY         = 65;
parameter VIQ0_DST_EREG          = 64;
parameter VIQ0_DST_VREG          = 59;
parameter VIQ0_DST_PREG          = 52;
parameter VIQ0_DSTE_VLD          = 45;
parameter VIQ0_DSTV_VLD          = 44;
parameter VIQ0_DST_VLD           = 43;
parameter VIQ0_SRCVM_VLD         = 42;
parameter VIQ0_SRCV2_VLD         = 41;
parameter VIQ0_SRCV1_VLD         = 40;
parameter VIQ0_SRCV0_VLD         = 39;
parameter VIQ0_IID               = 38;
parameter VIQ0_OPCODE            = 31;

//----------------------------------------------------------
//                    VIQ1 Parameters
//----------------------------------------------------------
parameter VIQ1_WIDTH             = 150;

parameter VIQ1_VL                = 149;
parameter VIQ1_VSEW              = 141;
parameter VIQ1_VLMUL             = 138;
parameter VIQ1_VMUL_UNSPLIT      = 136;
parameter VIQ1_VMLA_SHORT        = 135;
parameter VIQ1_LCH_RDY_VIQ1      = 134;
parameter VIQ1_LCH_RDY_VIQ0      = 126;
parameter VIQ1_VMLA_TYPE         = 118;
parameter VIQ1_SPLIT_NUM         = 115;
parameter VIQ1_SPLIT_LAST        = 108;
parameter VIQ1_MFVR              = 107;
parameter VIQ1_VMLA              = 106;
parameter VIQ1_SRCVM_DATA        = 105;
parameter VIQ1_SRCVM_LSU_MATCH   = 105;
parameter VIQ1_SRCVM_VREG        = 104;
parameter VIQ1_SRCVM_WB          = 97;
parameter VIQ1_SRCVM_RDY         = 96;
parameter VIQ1_SRCV2_DATA        = 95;
parameter VIQ1_SRCV2_LSU_MATCH   = 95;
parameter VIQ1_SRCV2_VREG        = 93;
parameter VIQ1_SRCV2_WB          = 86;
parameter VIQ1_SRCV2_RDY         = 85;
parameter VIQ1_SRCV1_DATA        = 84;
parameter VIQ1_SRCV1_LSU_MATCH   = 84;
parameter VIQ1_SRCV1_VREG        = 83;
parameter VIQ1_SRCV1_WB          = 76;
parameter VIQ1_SRCV1_RDY         = 75;
parameter VIQ1_SRCV0_DATA        = 74;
parameter VIQ1_SRCV0_LSU_MATCH   = 74;
parameter VIQ1_SRCV0_VREG        = 73;
parameter VIQ1_SRCV0_WB          = 66;
parameter VIQ1_SRCV0_RDY         = 65;
parameter VIQ1_DST_EREG          = 64;
parameter VIQ1_DST_VREG          = 59;
parameter VIQ1_DST_PREG          = 52;
parameter VIQ1_DSTE_VLD          = 45;
parameter VIQ1_DSTV_VLD          = 44;
parameter VIQ1_DST_VLD           = 43;
parameter VIQ1_SRCVM_VLD         = 42;
parameter VIQ1_SRCV2_VLD         = 41;
parameter VIQ1_SRCV1_VLD         = 40;
parameter VIQ1_SRCV0_VLD         = 39;
parameter VIQ1_IID               = 38;
parameter VIQ1_OPCODE            = 31;

//----------------------------------------------------------
//                    ISA  Parameters
//----------------------------------------------------------
parameter ISA_DST_REL_EREG       = 78;
parameter ISA_DST_EREG           = 73;
parameter ISA_DST_REL_VREG       = 68;
parameter ISA_DST_VREG           = 61;
parameter ISA_DSTV_REG           = 54;
parameter ISA_DST_REL_FREG       = 49;
parameter ISA_DST_FREG           = 42;
parameter ISA_DSTF_REG           = 35;
parameter ISA_DST_REL_PREG       = 30;
parameter ISA_DST_PREG           = 23;
parameter ISA_DST_REG            = 16;
parameter ISA_DST_EREG_VLD       = 11;
parameter ISA_DST_VREG_VLD       = 10;
parameter ISA_DST_FREG_VLD       = 9;
parameter ISA_DST_PREG_VLD       = 8;
parameter ISA_IID                = 7;
parameter ISA_VLD                = 0;

//parameter ISA_INT_VLD            = 0;

//----------------------------------------------------------
//                     ROB Parameters
//----------------------------------------------------------
parameter ROB_WIDTH              = 40;

parameter ROB_VL_PRED            = 39;
parameter ROB_VL                 = 38;
parameter ROB_VEC_DIRTY          = 30;
parameter ROB_VSETVLI            = 29;
parameter ROB_VSEW               = 28;
parameter ROB_VLMUL              = 25;
parameter ROB_NO_SPEC_MISPRED    = 23;
parameter ROB_NO_SPEC_MISS       = 22;
parameter ROB_NO_SPEC_HIT        = 21;
parameter ROB_LOAD               = 20;
parameter ROB_FP_DIRTY           = 19;
parameter ROB_INST_NUM           = 18;
parameter ROB_BKPTB_INST         = 16;
parameter ROB_BKPTA_INST         = 15;
parameter ROB_BKPTB_DATA         = 14;
parameter ROB_BKPTA_DATA         = 13;
parameter ROB_STORE              = 12;
parameter ROB_RAS                = 11;
parameter ROB_PCFIFO             = 10;
parameter ROB_BJU                = 9;
parameter ROB_INTMASK            = 8;
parameter ROB_SPLIT              = 7;
parameter ROB_PC_OFFSET          = 6;
parameter ROB_CMPLT_CNT          = 3;
parameter ROB_CMPLT              = 1;
parameter ROB_VLD                = 0;

//==========================================================
//                IR/IS pipeline registers
//==========================================================
//----------------------------------------------------------
//           control singals for pipeline entry
//----------------------------------------------------------
assign is_inst0_create_dp_en      = ctrl_ir_pipedown && !ctrl_dp_is_dis_stall;
assign is_inst1_create_dp_en      = ctrl_ir_pipedown && !ctrl_dp_is_dis_stall;
assign is_inst2_create_dp_en      = ctrl_ir_pipedown && !ctrl_dp_is_dis_stall;
assign is_inst3_create_dp_en      = ctrl_ir_pipedown && !ctrl_dp_is_dis_stall;

assign is_inst_create_dp_en       = ctrl_ir_pipedown && !ctrl_dp_is_dis_stall;

assign is_inst0_create_gateclk_en = ctrl_ir_pipedown_gateclk;
assign is_inst1_create_gateclk_en = ctrl_ir_pipedown_gateclk;
assign is_inst2_create_gateclk_en = ctrl_ir_pipedown_gateclk;
assign is_inst3_create_gateclk_en = ctrl_ir_pipedown_gateclk;

assign is_inst_create_gateclk_en  = ctrl_ir_pipedown_gateclk;

assign is_inst0_entry_vld         = ctrl_dp_is_inst0_vld;
assign is_inst1_entry_vld         = ctrl_dp_is_inst1_vld;
assign is_inst2_entry_vld         = ctrl_dp_is_inst2_vld;
assign is_inst3_entry_vld         = ctrl_dp_is_inst3_vld;

//----------------------------------------------------------
//             IS pipeline registers shift MUX
//----------------------------------------------------------
// &CombBeg; @539
always @( dp_ir_inst0_data[IS_WIDTH-1:0]
       or is_inst2_read_data[IS_WIDTH-1:0]
       or ctrl_xx_is_inst0_sel[1:0])
begin
  case(ctrl_xx_is_inst0_sel[1:0])
    2'b01  : is_inst0_create_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
    2'b10  : is_inst0_create_data[IS_WIDTH-1:0] = dp_ir_inst0_data[IS_WIDTH-1:0];
    default: is_inst0_create_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
  endcase
// &CombEnd; @545
end

// &CombBeg; @547
always @( dp_ir_inst0_data[IS_WIDTH-1:0]
       or ctrl_xx_is_inst_sel[2:0]
       or dp_ir_inst1_data[IS_WIDTH-1:0]
       or is_inst3_read_data[IS_WIDTH-1:0])
begin
  case(ctrl_xx_is_inst_sel[2:0])
    3'b001 : is_inst1_create_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
    3'b010 : is_inst1_create_data[IS_WIDTH-1:0] = dp_ir_inst0_data[IS_WIDTH-1:0];
    3'b100 : is_inst1_create_data[IS_WIDTH-1:0] = dp_ir_inst1_data[IS_WIDTH-1:0];
    default: is_inst1_create_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
  endcase
// &CombEnd; @554
end

// &CombBeg; @556
always @( dp_ir_inst0_data[IS_WIDTH-1:0]
       or ctrl_xx_is_inst_sel[2:0]
       or dp_ir_inst1_data[IS_WIDTH-1:0]
       or dp_ir_inst2_data[IS_WIDTH-1:0])
begin
  case(ctrl_xx_is_inst_sel[2:0])
    3'b001 : is_inst2_create_data[IS_WIDTH-1:0] = dp_ir_inst0_data[IS_WIDTH-1:0];
    3'b010 : is_inst2_create_data[IS_WIDTH-1:0] = dp_ir_inst1_data[IS_WIDTH-1:0];
    3'b100 : is_inst2_create_data[IS_WIDTH-1:0] = dp_ir_inst2_data[IS_WIDTH-1:0];
    default: is_inst2_create_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
  endcase
// &CombEnd; @563
end

// &CombBeg; @565
always @( ctrl_xx_is_inst_sel[2:0]
       or dp_ir_inst1_data[270:0]
       or dp_ir_inst2_data[270:0]
       or dp_ir_inst3_data[270:0])
begin
  case(ctrl_xx_is_inst_sel[2:0])
    3'b001 : is_inst3_create_data[IS_WIDTH-1:0] = dp_ir_inst1_data[IS_WIDTH-1:0];
    3'b010 : is_inst3_create_data[IS_WIDTH-1:0] = dp_ir_inst2_data[IS_WIDTH-1:0];
    3'b100 : is_inst3_create_data[IS_WIDTH-1:0] = dp_ir_inst3_data[IS_WIDTH-1:0];
    default: is_inst3_create_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
  endcase
// &CombEnd; @572
end

//----------------------------------------------------------
//            pipeline entry registers instance
//----------------------------------------------------------
// &ConnRule(s/^x_/is_inst0_/); @577
// &Instance("ct_idu_is_pipe_entry", "x_ct_idu_is_dp_inst0"); @578
ct_idu_is_pipe_entry  x_ct_idu_is_dp_inst0 (
  .cp0_idu_icg_en                          (cp0_idu_icg_en                         ),
  .cp0_yy_clk_en                           (cp0_yy_clk_en                          ),
  .cpurst_b                                (cpurst_b                               ),
  .ctrl_xx_rf_pipe0_preg_lch_vld_dupx      (ctrl_xx_rf_pipe0_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe1_preg_lch_vld_dupx      (ctrl_xx_rf_pipe1_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe6_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe6_vmla_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe7_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe7_vmla_lch_vld_dupx     ),
  .dp_xx_rf_pipe0_dst_preg_dupx            (dp_xx_rf_pipe0_dst_preg_dupx           ),
  .dp_xx_rf_pipe1_dst_preg_dupx            (dp_xx_rf_pipe1_dst_preg_dupx           ),
  .dp_xx_rf_pipe6_dst_vreg_dupx            (dp_xx_rf_pipe6_dst_vreg_dupx           ),
  .dp_xx_rf_pipe7_dst_vreg_dupx            (dp_xx_rf_pipe7_dst_vreg_dupx           ),
  .forever_cpuclk                          (forever_cpuclk                         ),
  .iu_idu_div_inst_vld                     (iu_idu_div_inst_vld                    ),
  .iu_idu_div_preg_dupx                    (iu_idu_div_preg_dupx                   ),
  .iu_idu_ex2_pipe0_wb_preg_dupx           (iu_idu_ex2_pipe0_wb_preg_dupx          ),
  .iu_idu_ex2_pipe0_wb_preg_vld_dupx       (iu_idu_ex2_pipe0_wb_preg_vld_dupx      ),
  .iu_idu_ex2_pipe1_mult_inst_vld_dupx     (iu_idu_ex2_pipe1_mult_inst_vld_dupx    ),
  .iu_idu_ex2_pipe1_preg_dupx              (iu_idu_ex2_pipe1_preg_dupx             ),
  .iu_idu_ex2_pipe1_wb_preg_dupx           (iu_idu_ex2_pipe1_wb_preg_dupx          ),
  .iu_idu_ex2_pipe1_wb_preg_vld_dupx       (iu_idu_ex2_pipe1_wb_preg_vld_dupx      ),
  .lsu_idu_ag_pipe3_load_inst_vld          (lsu_idu_ag_pipe3_load_inst_vld         ),
  .lsu_idu_ag_pipe3_preg_dupx              (lsu_idu_ag_pipe3_preg_dupx             ),
  .lsu_idu_ag_pipe3_vload_inst_vld         (lsu_idu_ag_pipe3_vload_inst_vld        ),
  .lsu_idu_ag_pipe3_vreg_dupx              (lsu_idu_ag_pipe3_vreg_dupx             ),
  .lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx (lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx),
  .lsu_idu_dc_pipe3_load_inst_vld_dupx     (lsu_idu_dc_pipe3_load_inst_vld_dupx    ),
  .lsu_idu_dc_pipe3_preg_dupx              (lsu_idu_dc_pipe3_preg_dupx             ),
  .lsu_idu_dc_pipe3_vload_fwd_inst_vld     (lsu_idu_dc_pipe3_vload_fwd_inst_vld    ),
  .lsu_idu_dc_pipe3_vload_inst_vld_dupx    (lsu_idu_dc_pipe3_vload_inst_vld_dupx   ),
  .lsu_idu_dc_pipe3_vreg_dupx              (lsu_idu_dc_pipe3_vreg_dupx             ),
  .lsu_idu_wb_pipe3_wb_preg_dupx           (lsu_idu_wb_pipe3_wb_preg_dupx          ),
  .lsu_idu_wb_pipe3_wb_preg_vld_dupx       (lsu_idu_wb_pipe3_wb_preg_vld_dupx      ),
  .lsu_idu_wb_pipe3_wb_vreg_dupx           (lsu_idu_wb_pipe3_wb_vreg_dupx          ),
  .lsu_idu_wb_pipe3_wb_vreg_vld_dupx       (lsu_idu_wb_pipe3_wb_vreg_vld_dupx      ),
  .pad_yy_icg_scan_en                      (pad_yy_icg_scan_en                     ),
  .rtu_idu_flush_fe                        (rtu_idu_flush_fe                       ),
  .rtu_idu_flush_is                        (rtu_idu_flush_is                       ),
  .vfpu_idu_ex1_pipe6_data_vld_dupx        (vfpu_idu_ex1_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_preg_dupx            (vfpu_idu_ex1_pipe6_preg_dupx           ),
  .vfpu_idu_ex1_pipe6_vreg_dupx            (vfpu_idu_ex1_pipe6_vreg_dupx           ),
  .vfpu_idu_ex1_pipe7_data_vld_dupx        (vfpu_idu_ex1_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_preg_dupx            (vfpu_idu_ex1_pipe7_preg_dupx           ),
  .vfpu_idu_ex1_pipe7_vreg_dupx            (vfpu_idu_ex1_pipe7_vreg_dupx           ),
  .vfpu_idu_ex2_pipe6_data_vld_dupx        (vfpu_idu_ex2_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe6_vreg_dupx            (vfpu_idu_ex2_pipe6_vreg_dupx           ),
  .vfpu_idu_ex2_pipe7_data_vld_dupx        (vfpu_idu_ex2_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe7_vreg_dupx            (vfpu_idu_ex2_pipe7_vreg_dupx           ),
  .vfpu_idu_ex3_pipe6_data_vld_dupx        (vfpu_idu_ex3_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe6_vreg_dupx            (vfpu_idu_ex3_pipe6_vreg_dupx           ),
  .vfpu_idu_ex3_pipe7_data_vld_dupx        (vfpu_idu_ex3_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe7_vreg_dupx            (vfpu_idu_ex3_pipe7_vreg_dupx           ),
  .vfpu_idu_ex5_pipe6_wb_vreg_dupx         (vfpu_idu_ex5_pipe6_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx    ),
  .vfpu_idu_ex5_pipe7_wb_vreg_dupx         (vfpu_idu_ex5_pipe7_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx    ),
  .x_create_data                           (is_inst0_create_data                   ),
  .x_create_dp_en                          (is_inst0_create_dp_en                  ),
  .x_create_gateclk_en                     (is_inst0_create_gateclk_en             ),
  .x_entry_vld                             (is_inst0_entry_vld                     ),
  .x_read_data                             (is_inst0_read_data                     )
);


// &ConnRule(s/^x_/is_inst1_/); @580
// &Instance("ct_idu_is_pipe_entry", "x_ct_idu_is_dp_inst1"); @581
ct_idu_is_pipe_entry  x_ct_idu_is_dp_inst1 (
  .cp0_idu_icg_en                          (cp0_idu_icg_en                         ),
  .cp0_yy_clk_en                           (cp0_yy_clk_en                          ),
  .cpurst_b                                (cpurst_b                               ),
  .ctrl_xx_rf_pipe0_preg_lch_vld_dupx      (ctrl_xx_rf_pipe0_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe1_preg_lch_vld_dupx      (ctrl_xx_rf_pipe1_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe6_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe6_vmla_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe7_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe7_vmla_lch_vld_dupx     ),
  .dp_xx_rf_pipe0_dst_preg_dupx            (dp_xx_rf_pipe0_dst_preg_dupx           ),
  .dp_xx_rf_pipe1_dst_preg_dupx            (dp_xx_rf_pipe1_dst_preg_dupx           ),
  .dp_xx_rf_pipe6_dst_vreg_dupx            (dp_xx_rf_pipe6_dst_vreg_dupx           ),
  .dp_xx_rf_pipe7_dst_vreg_dupx            (dp_xx_rf_pipe7_dst_vreg_dupx           ),
  .forever_cpuclk                          (forever_cpuclk                         ),
  .iu_idu_div_inst_vld                     (iu_idu_div_inst_vld                    ),
  .iu_idu_div_preg_dupx                    (iu_idu_div_preg_dupx                   ),
  .iu_idu_ex2_pipe0_wb_preg_dupx           (iu_idu_ex2_pipe0_wb_preg_dupx          ),
  .iu_idu_ex2_pipe0_wb_preg_vld_dupx       (iu_idu_ex2_pipe0_wb_preg_vld_dupx      ),
  .iu_idu_ex2_pipe1_mult_inst_vld_dupx     (iu_idu_ex2_pipe1_mult_inst_vld_dupx    ),
  .iu_idu_ex2_pipe1_preg_dupx              (iu_idu_ex2_pipe1_preg_dupx             ),
  .iu_idu_ex2_pipe1_wb_preg_dupx           (iu_idu_ex2_pipe1_wb_preg_dupx          ),
  .iu_idu_ex2_pipe1_wb_preg_vld_dupx       (iu_idu_ex2_pipe1_wb_preg_vld_dupx      ),
  .lsu_idu_ag_pipe3_load_inst_vld          (lsu_idu_ag_pipe3_load_inst_vld         ),
  .lsu_idu_ag_pipe3_preg_dupx              (lsu_idu_ag_pipe3_preg_dupx             ),
  .lsu_idu_ag_pipe3_vload_inst_vld         (lsu_idu_ag_pipe3_vload_inst_vld        ),
  .lsu_idu_ag_pipe3_vreg_dupx              (lsu_idu_ag_pipe3_vreg_dupx             ),
  .lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx (lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx),
  .lsu_idu_dc_pipe3_load_inst_vld_dupx     (lsu_idu_dc_pipe3_load_inst_vld_dupx    ),
  .lsu_idu_dc_pipe3_preg_dupx              (lsu_idu_dc_pipe3_preg_dupx             ),
  .lsu_idu_dc_pipe3_vload_fwd_inst_vld     (lsu_idu_dc_pipe3_vload_fwd_inst_vld    ),
  .lsu_idu_dc_pipe3_vload_inst_vld_dupx    (lsu_idu_dc_pipe3_vload_inst_vld_dupx   ),
  .lsu_idu_dc_pipe3_vreg_dupx              (lsu_idu_dc_pipe3_vreg_dupx             ),
  .lsu_idu_wb_pipe3_wb_preg_dupx           (lsu_idu_wb_pipe3_wb_preg_dupx          ),
  .lsu_idu_wb_pipe3_wb_preg_vld_dupx       (lsu_idu_wb_pipe3_wb_preg_vld_dupx      ),
  .lsu_idu_wb_pipe3_wb_vreg_dupx           (lsu_idu_wb_pipe3_wb_vreg_dupx          ),
  .lsu_idu_wb_pipe3_wb_vreg_vld_dupx       (lsu_idu_wb_pipe3_wb_vreg_vld_dupx      ),
  .pad_yy_icg_scan_en                      (pad_yy_icg_scan_en                     ),
  .rtu_idu_flush_fe                        (rtu_idu_flush_fe                       ),
  .rtu_idu_flush_is                        (rtu_idu_flush_is                       ),
  .vfpu_idu_ex1_pipe6_data_vld_dupx        (vfpu_idu_ex1_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_preg_dupx            (vfpu_idu_ex1_pipe6_preg_dupx           ),
  .vfpu_idu_ex1_pipe6_vreg_dupx            (vfpu_idu_ex1_pipe6_vreg_dupx           ),
  .vfpu_idu_ex1_pipe7_data_vld_dupx        (vfpu_idu_ex1_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_preg_dupx            (vfpu_idu_ex1_pipe7_preg_dupx           ),
  .vfpu_idu_ex1_pipe7_vreg_dupx            (vfpu_idu_ex1_pipe7_vreg_dupx           ),
  .vfpu_idu_ex2_pipe6_data_vld_dupx        (vfpu_idu_ex2_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe6_vreg_dupx            (vfpu_idu_ex2_pipe6_vreg_dupx           ),
  .vfpu_idu_ex2_pipe7_data_vld_dupx        (vfpu_idu_ex2_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe7_vreg_dupx            (vfpu_idu_ex2_pipe7_vreg_dupx           ),
  .vfpu_idu_ex3_pipe6_data_vld_dupx        (vfpu_idu_ex3_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe6_vreg_dupx            (vfpu_idu_ex3_pipe6_vreg_dupx           ),
  .vfpu_idu_ex3_pipe7_data_vld_dupx        (vfpu_idu_ex3_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe7_vreg_dupx            (vfpu_idu_ex3_pipe7_vreg_dupx           ),
  .vfpu_idu_ex5_pipe6_wb_vreg_dupx         (vfpu_idu_ex5_pipe6_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx    ),
  .vfpu_idu_ex5_pipe7_wb_vreg_dupx         (vfpu_idu_ex5_pipe7_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx    ),
  .x_create_data                           (is_inst1_create_data                   ),
  .x_create_dp_en                          (is_inst1_create_dp_en                  ),
  .x_create_gateclk_en                     (is_inst1_create_gateclk_en             ),
  .x_entry_vld                             (is_inst1_entry_vld                     ),
  .x_read_data                             (is_inst1_read_data                     )
);


// &ConnRule(s/^x_/is_inst2_/); @583
// &Instance("ct_idu_is_pipe_entry", "x_ct_idu_is_dp_inst2"); @584
ct_idu_is_pipe_entry  x_ct_idu_is_dp_inst2 (
  .cp0_idu_icg_en                          (cp0_idu_icg_en                         ),
  .cp0_yy_clk_en                           (cp0_yy_clk_en                          ),
  .cpurst_b                                (cpurst_b                               ),
  .ctrl_xx_rf_pipe0_preg_lch_vld_dupx      (ctrl_xx_rf_pipe0_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe1_preg_lch_vld_dupx      (ctrl_xx_rf_pipe1_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe6_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe6_vmla_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe7_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe7_vmla_lch_vld_dupx     ),
  .dp_xx_rf_pipe0_dst_preg_dupx            (dp_xx_rf_pipe0_dst_preg_dupx           ),
  .dp_xx_rf_pipe1_dst_preg_dupx            (dp_xx_rf_pipe1_dst_preg_dupx           ),
  .dp_xx_rf_pipe6_dst_vreg_dupx            (dp_xx_rf_pipe6_dst_vreg_dupx           ),
  .dp_xx_rf_pipe7_dst_vreg_dupx            (dp_xx_rf_pipe7_dst_vreg_dupx           ),
  .forever_cpuclk                          (forever_cpuclk                         ),
  .iu_idu_div_inst_vld                     (iu_idu_div_inst_vld                    ),
  .iu_idu_div_preg_dupx                    (iu_idu_div_preg_dupx                   ),
  .iu_idu_ex2_pipe0_wb_preg_dupx           (iu_idu_ex2_pipe0_wb_preg_dupx          ),
  .iu_idu_ex2_pipe0_wb_preg_vld_dupx       (iu_idu_ex2_pipe0_wb_preg_vld_dupx      ),
  .iu_idu_ex2_pipe1_mult_inst_vld_dupx     (iu_idu_ex2_pipe1_mult_inst_vld_dupx    ),
  .iu_idu_ex2_pipe1_preg_dupx              (iu_idu_ex2_pipe1_preg_dupx             ),
  .iu_idu_ex2_pipe1_wb_preg_dupx           (iu_idu_ex2_pipe1_wb_preg_dupx          ),
  .iu_idu_ex2_pipe1_wb_preg_vld_dupx       (iu_idu_ex2_pipe1_wb_preg_vld_dupx      ),
  .lsu_idu_ag_pipe3_load_inst_vld          (lsu_idu_ag_pipe3_load_inst_vld         ),
  .lsu_idu_ag_pipe3_preg_dupx              (lsu_idu_ag_pipe3_preg_dupx             ),
  .lsu_idu_ag_pipe3_vload_inst_vld         (lsu_idu_ag_pipe3_vload_inst_vld        ),
  .lsu_idu_ag_pipe3_vreg_dupx              (lsu_idu_ag_pipe3_vreg_dupx             ),
  .lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx (lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx),
  .lsu_idu_dc_pipe3_load_inst_vld_dupx     (lsu_idu_dc_pipe3_load_inst_vld_dupx    ),
  .lsu_idu_dc_pipe3_preg_dupx              (lsu_idu_dc_pipe3_preg_dupx             ),
  .lsu_idu_dc_pipe3_vload_fwd_inst_vld     (lsu_idu_dc_pipe3_vload_fwd_inst_vld    ),
  .lsu_idu_dc_pipe3_vload_inst_vld_dupx    (lsu_idu_dc_pipe3_vload_inst_vld_dupx   ),
  .lsu_idu_dc_pipe3_vreg_dupx              (lsu_idu_dc_pipe3_vreg_dupx             ),
  .lsu_idu_wb_pipe3_wb_preg_dupx           (lsu_idu_wb_pipe3_wb_preg_dupx          ),
  .lsu_idu_wb_pipe3_wb_preg_vld_dupx       (lsu_idu_wb_pipe3_wb_preg_vld_dupx      ),
  .lsu_idu_wb_pipe3_wb_vreg_dupx           (lsu_idu_wb_pipe3_wb_vreg_dupx          ),
  .lsu_idu_wb_pipe3_wb_vreg_vld_dupx       (lsu_idu_wb_pipe3_wb_vreg_vld_dupx      ),
  .pad_yy_icg_scan_en                      (pad_yy_icg_scan_en                     ),
  .rtu_idu_flush_fe                        (rtu_idu_flush_fe                       ),
  .rtu_idu_flush_is                        (rtu_idu_flush_is                       ),
  .vfpu_idu_ex1_pipe6_data_vld_dupx        (vfpu_idu_ex1_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_preg_dupx            (vfpu_idu_ex1_pipe6_preg_dupx           ),
  .vfpu_idu_ex1_pipe6_vreg_dupx            (vfpu_idu_ex1_pipe6_vreg_dupx           ),
  .vfpu_idu_ex1_pipe7_data_vld_dupx        (vfpu_idu_ex1_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_preg_dupx            (vfpu_idu_ex1_pipe7_preg_dupx           ),
  .vfpu_idu_ex1_pipe7_vreg_dupx            (vfpu_idu_ex1_pipe7_vreg_dupx           ),
  .vfpu_idu_ex2_pipe6_data_vld_dupx        (vfpu_idu_ex2_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe6_vreg_dupx            (vfpu_idu_ex2_pipe6_vreg_dupx           ),
  .vfpu_idu_ex2_pipe7_data_vld_dupx        (vfpu_idu_ex2_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe7_vreg_dupx            (vfpu_idu_ex2_pipe7_vreg_dupx           ),
  .vfpu_idu_ex3_pipe6_data_vld_dupx        (vfpu_idu_ex3_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe6_vreg_dupx            (vfpu_idu_ex3_pipe6_vreg_dupx           ),
  .vfpu_idu_ex3_pipe7_data_vld_dupx        (vfpu_idu_ex3_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe7_vreg_dupx            (vfpu_idu_ex3_pipe7_vreg_dupx           ),
  .vfpu_idu_ex5_pipe6_wb_vreg_dupx         (vfpu_idu_ex5_pipe6_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx    ),
  .vfpu_idu_ex5_pipe7_wb_vreg_dupx         (vfpu_idu_ex5_pipe7_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx    ),
  .x_create_data                           (is_inst2_create_data                   ),
  .x_create_dp_en                          (is_inst2_create_dp_en                  ),
  .x_create_gateclk_en                     (is_inst2_create_gateclk_en             ),
  .x_entry_vld                             (is_inst2_entry_vld                     ),
  .x_read_data                             (is_inst2_read_data                     )
);


// &ConnRule(s/^x_/is_inst3_/); @586
// &Instance("ct_idu_is_pipe_entry", "x_ct_idu_is_dp_inst3"); @587
ct_idu_is_pipe_entry  x_ct_idu_is_dp_inst3 (
  .cp0_idu_icg_en                          (cp0_idu_icg_en                         ),
  .cp0_yy_clk_en                           (cp0_yy_clk_en                          ),
  .cpurst_b                                (cpurst_b                               ),
  .ctrl_xx_rf_pipe0_preg_lch_vld_dupx      (ctrl_xx_rf_pipe0_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe1_preg_lch_vld_dupx      (ctrl_xx_rf_pipe1_preg_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe6_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe6_vmla_lch_vld_dupx     ),
  .ctrl_xx_rf_pipe7_vmla_lch_vld_dupx      (ctrl_xx_rf_pipe7_vmla_lch_vld_dupx     ),
  .dp_xx_rf_pipe0_dst_preg_dupx            (dp_xx_rf_pipe0_dst_preg_dupx           ),
  .dp_xx_rf_pipe1_dst_preg_dupx            (dp_xx_rf_pipe1_dst_preg_dupx           ),
  .dp_xx_rf_pipe6_dst_vreg_dupx            (dp_xx_rf_pipe6_dst_vreg_dupx           ),
  .dp_xx_rf_pipe7_dst_vreg_dupx            (dp_xx_rf_pipe7_dst_vreg_dupx           ),
  .forever_cpuclk                          (forever_cpuclk                         ),
  .iu_idu_div_inst_vld                     (iu_idu_div_inst_vld                    ),
  .iu_idu_div_preg_dupx                    (iu_idu_div_preg_dupx                   ),
  .iu_idu_ex2_pipe0_wb_preg_dupx           (iu_idu_ex2_pipe0_wb_preg_dupx          ),
  .iu_idu_ex2_pipe0_wb_preg_vld_dupx       (iu_idu_ex2_pipe0_wb_preg_vld_dupx      ),
  .iu_idu_ex2_pipe1_mult_inst_vld_dupx     (iu_idu_ex2_pipe1_mult_inst_vld_dupx    ),
  .iu_idu_ex2_pipe1_preg_dupx              (iu_idu_ex2_pipe1_preg_dupx             ),
  .iu_idu_ex2_pipe1_wb_preg_dupx           (iu_idu_ex2_pipe1_wb_preg_dupx          ),
  .iu_idu_ex2_pipe1_wb_preg_vld_dupx       (iu_idu_ex2_pipe1_wb_preg_vld_dupx      ),
  .lsu_idu_ag_pipe3_load_inst_vld          (lsu_idu_ag_pipe3_load_inst_vld         ),
  .lsu_idu_ag_pipe3_preg_dupx              (lsu_idu_ag_pipe3_preg_dupx             ),
  .lsu_idu_ag_pipe3_vload_inst_vld         (lsu_idu_ag_pipe3_vload_inst_vld        ),
  .lsu_idu_ag_pipe3_vreg_dupx              (lsu_idu_ag_pipe3_vreg_dupx             ),
  .lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx (lsu_idu_dc_pipe3_load_fwd_inst_vld_dupx),
  .lsu_idu_dc_pipe3_load_inst_vld_dupx     (lsu_idu_dc_pipe3_load_inst_vld_dupx    ),
  .lsu_idu_dc_pipe3_preg_dupx              (lsu_idu_dc_pipe3_preg_dupx             ),
  .lsu_idu_dc_pipe3_vload_fwd_inst_vld     (lsu_idu_dc_pipe3_vload_fwd_inst_vld    ),
  .lsu_idu_dc_pipe3_vload_inst_vld_dupx    (lsu_idu_dc_pipe3_vload_inst_vld_dupx   ),
  .lsu_idu_dc_pipe3_vreg_dupx              (lsu_idu_dc_pipe3_vreg_dupx             ),
  .lsu_idu_wb_pipe3_wb_preg_dupx           (lsu_idu_wb_pipe3_wb_preg_dupx          ),
  .lsu_idu_wb_pipe3_wb_preg_vld_dupx       (lsu_idu_wb_pipe3_wb_preg_vld_dupx      ),
  .lsu_idu_wb_pipe3_wb_vreg_dupx           (lsu_idu_wb_pipe3_wb_vreg_dupx          ),
  .lsu_idu_wb_pipe3_wb_vreg_vld_dupx       (lsu_idu_wb_pipe3_wb_vreg_vld_dupx      ),
  .pad_yy_icg_scan_en                      (pad_yy_icg_scan_en                     ),
  .rtu_idu_flush_fe                        (rtu_idu_flush_fe                       ),
  .rtu_idu_flush_is                        (rtu_idu_flush_is                       ),
  .vfpu_idu_ex1_pipe6_data_vld_dupx        (vfpu_idu_ex1_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe6_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe6_preg_dupx            (vfpu_idu_ex1_pipe6_preg_dupx           ),
  .vfpu_idu_ex1_pipe6_vreg_dupx            (vfpu_idu_ex1_pipe6_vreg_dupx           ),
  .vfpu_idu_ex1_pipe7_data_vld_dupx        (vfpu_idu_ex1_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex1_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex1_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx   (vfpu_idu_ex1_pipe7_mfvr_inst_vld_dupx  ),
  .vfpu_idu_ex1_pipe7_preg_dupx            (vfpu_idu_ex1_pipe7_preg_dupx           ),
  .vfpu_idu_ex1_pipe7_vreg_dupx            (vfpu_idu_ex1_pipe7_vreg_dupx           ),
  .vfpu_idu_ex2_pipe6_data_vld_dupx        (vfpu_idu_ex2_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe6_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe6_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe6_vreg_dupx            (vfpu_idu_ex2_pipe6_vreg_dupx           ),
  .vfpu_idu_ex2_pipe7_data_vld_dupx        (vfpu_idu_ex2_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex2_pipe7_fmla_data_vld_dupx   (vfpu_idu_ex2_pipe7_fmla_data_vld_dupx  ),
  .vfpu_idu_ex2_pipe7_vreg_dupx            (vfpu_idu_ex2_pipe7_vreg_dupx           ),
  .vfpu_idu_ex3_pipe6_data_vld_dupx        (vfpu_idu_ex3_pipe6_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe6_vreg_dupx            (vfpu_idu_ex3_pipe6_vreg_dupx           ),
  .vfpu_idu_ex3_pipe7_data_vld_dupx        (vfpu_idu_ex3_pipe7_data_vld_dupx       ),
  .vfpu_idu_ex3_pipe7_vreg_dupx            (vfpu_idu_ex3_pipe7_vreg_dupx           ),
  .vfpu_idu_ex5_pipe6_wb_vreg_dupx         (vfpu_idu_ex5_pipe6_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe6_wb_vreg_vld_dupx    ),
  .vfpu_idu_ex5_pipe7_wb_vreg_dupx         (vfpu_idu_ex5_pipe7_wb_vreg_dupx        ),
  .vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx     (vfpu_idu_ex5_pipe7_wb_vreg_vld_dupx    ),
  .x_create_data                           (is_inst3_create_data                   ),
  .x_create_dp_en                          (is_inst3_create_dp_en                  ),
  .x_create_gateclk_en                     (is_inst3_create_gateclk_en             ),
  .x_entry_vld                             (is_inst3_entry_vld                     ),
  .x_read_data                             (is_inst3_read_data                     )
);


//----------------------------------------------------------
//               Output for Control Logic
//----------------------------------------------------------
assign dp_ctrl_is_inst0_bar       = is_inst0_read_data[IS_BAR];
assign dp_ctrl_is_inst1_bar       = is_inst1_read_data[IS_BAR];
assign dp_ctrl_is_inst2_bar       = is_inst2_read_data[IS_BAR];
assign dp_ctrl_is_inst3_bar       = is_inst3_read_data[IS_BAR];

assign is_inst0_src0_preg[6:0]    = is_inst0_read_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign is_inst1_src0_preg[6:0]    = is_inst1_read_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign is_inst2_src0_preg[6:0]    = is_inst2_read_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign is_inst3_src0_preg[6:0]    = is_inst3_read_data[IS_SRC0_PREG:IS_SRC0_PREG-6];

assign is_inst0_src1_preg[6:0]    = is_inst0_read_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign is_inst1_src1_preg[6:0]    = is_inst1_read_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign is_inst2_src1_preg[6:0]    = is_inst2_read_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign is_inst3_src1_preg[6:0]    = is_inst3_read_data[IS_SRC1_PREG:IS_SRC1_PREG-6];

assign is_inst0_src2_preg[6:0]    = is_inst0_read_data[IS_SRC2_PREG:IS_SRC2_PREG-6];
assign is_inst1_src2_preg[6:0]    = is_inst1_read_data[IS_SRC2_PREG:IS_SRC2_PREG-6];
assign is_inst2_src2_preg[6:0]    = is_inst2_read_data[IS_SRC2_PREG:IS_SRC2_PREG-6];
assign is_inst3_src2_preg[6:0]    = is_inst3_read_data[IS_SRC2_PREG:IS_SRC2_PREG-6];

assign is_inst0_srcv2_vreg[6:0]   = is_inst0_read_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6];
assign is_inst1_srcv2_vreg[6:0]   = is_inst1_read_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6];
assign is_inst2_srcv2_vreg[6:0]   = is_inst2_read_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6];
assign is_inst3_srcv2_vreg[6:0]   = is_inst3_read_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6];

assign dp_aiq_dis_inst0_src0_preg[6:0]  = is_inst0_src0_preg[6:0];
assign dp_aiq_dis_inst1_src0_preg[6:0]  = is_inst1_src0_preg[6:0];
assign dp_aiq_dis_inst2_src0_preg[6:0]  = is_inst2_src0_preg[6:0];
assign dp_aiq_dis_inst3_src0_preg[6:0]  = is_inst3_src0_preg[6:0];

assign dp_aiq_dis_inst0_src1_preg[6:0]  = is_inst0_src1_preg[6:0];
assign dp_aiq_dis_inst1_src1_preg[6:0]  = is_inst1_src1_preg[6:0];
assign dp_aiq_dis_inst2_src1_preg[6:0]  = is_inst2_src1_preg[6:0];
assign dp_aiq_dis_inst3_src1_preg[6:0]  = is_inst3_src1_preg[6:0];

assign dp_aiq_dis_inst0_src2_preg[6:0]  = is_inst0_src2_preg[6:0];
assign dp_aiq_dis_inst1_src2_preg[6:0]  = is_inst1_src2_preg[6:0];
assign dp_aiq_dis_inst2_src2_preg[6:0]  = is_inst2_src2_preg[6:0];
assign dp_aiq_dis_inst3_src2_preg[6:0]  = is_inst3_src2_preg[6:0];

assign dp_viq_dis_inst0_srcv2_vreg[6:0] = is_inst0_srcv2_vreg[6:0];
assign dp_viq_dis_inst1_srcv2_vreg[6:0] = is_inst1_srcv2_vreg[6:0];
assign dp_viq_dis_inst2_srcv2_vreg[6:0] = is_inst2_srcv2_vreg[6:0];
assign dp_viq_dis_inst3_srcv2_vreg[6:0] = is_inst3_srcv2_vreg[6:0];

//----------------------------------------------------------
//             IS pipeline preg match create
//----------------------------------------------------------
// &CombBeg; @640
always @( dp_ir_inst13_src_match[3:0]
       or dp_ir_inst03_src_match[3:0]
       or is_inst23_src_match[3:0]
       or dp_ir_inst02_src_match[3:0]
       or dp_ir_inst12_src_match[3:0]
       or dp_ir_inst01_src_match[3:0]
       or dp_ir_inst23_src_match[3:0]
       or ctrl_xx_is_inst_sel[2:0])
begin
  case(ctrl_xx_is_inst_sel[2:0])
    3'b001 : begin
               is_inst01_create_src_match[3:0] = is_inst23_src_match[3:0];
               is_inst02_create_src_match[3:0] = 4'b0;
               is_inst03_create_src_match[3:0] = 4'b0;
               is_inst12_create_src_match[3:0] = 4'b0;
               is_inst13_create_src_match[3:0] = 4'b0;
               is_inst23_create_src_match[3:0] = dp_ir_inst01_src_match[3:0];
             end
    3'b010 : begin
               is_inst01_create_src_match[3:0] = 4'b0;
               is_inst02_create_src_match[3:0] = 4'b0;
               is_inst03_create_src_match[3:0] = 4'b0;
               is_inst12_create_src_match[3:0] = dp_ir_inst01_src_match[3:0];
               is_inst13_create_src_match[3:0] = dp_ir_inst02_src_match[3:0];
               is_inst23_create_src_match[3:0] = dp_ir_inst12_src_match[3:0];
             end
    3'b100 : begin
               is_inst01_create_src_match[3:0] = dp_ir_inst01_src_match[3:0];
               is_inst02_create_src_match[3:0] = dp_ir_inst02_src_match[3:0];
               is_inst03_create_src_match[3:0] = dp_ir_inst03_src_match[3:0];
               is_inst12_create_src_match[3:0] = dp_ir_inst12_src_match[3:0];
               is_inst13_create_src_match[3:0] = dp_ir_inst13_src_match[3:0];
               is_inst23_create_src_match[3:0] = dp_ir_inst23_src_match[3:0];
             end
    default: begin
               is_inst01_create_src_match[3:0] = {4{1'bx}};
               is_inst02_create_src_match[3:0] = {4{1'bx}};
               is_inst03_create_src_match[3:0] = {4{1'bx}};
               is_inst12_create_src_match[3:0] = {4{1'bx}};
               is_inst13_create_src_match[3:0] = {4{1'bx}};
               is_inst23_create_src_match[3:0] = {4{1'bx}};
             end
  endcase
// &CombEnd; @675
end

//----------------------------------------------------------
//              Instance of Gated Cell
//----------------------------------------------------------
assign is_inst_clk_en = is_inst_create_gateclk_en;
// &Instance("gated_clk_cell", "x_is_inst_gated_clk"); @681
gated_clk_cell  x_is_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (is_inst_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (is_inst_clk_en    ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @682
//          .external_en (1'b0), @683
//          .global_en   (cp0_yy_clk_en), @684
//          .module_en   (cp0_idu_icg_en), @685
//          .local_en    (is_inst_clk_en), @686
//          .clk_out     (is_inst_clk)); @687

//----------------------------------------------------------
//             IS pipeline preg match create
//----------------------------------------------------------

always @(posedge is_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    is_inst01_src_match[3:0] <= 4'b0;
    is_inst02_src_match[3:0] <= 4'b0;
    is_inst03_src_match[3:0] <= 4'b0;
    is_inst12_src_match[3:0] <= 4'b0;
    is_inst13_src_match[3:0] <= 4'b0;
    is_inst23_src_match[3:0] <= 4'b0;
  end
  else if(is_inst_create_dp_en) begin
    is_inst01_src_match[3:0] <= is_inst01_create_src_match[3:0];
    is_inst02_src_match[3:0] <= is_inst02_create_src_match[3:0];
    is_inst03_src_match[3:0] <= is_inst03_create_src_match[3:0];
    is_inst12_src_match[3:0] <= is_inst12_create_src_match[3:0];
    is_inst13_src_match[3:0] <= is_inst13_create_src_match[3:0];
    is_inst23_src_match[3:0] <= is_inst23_create_src_match[3:0];
  end
  else begin
    is_inst01_src_match[3:0] <= is_inst01_src_match[3:0];
    is_inst02_src_match[3:0] <= is_inst02_src_match[3:0];
    is_inst03_src_match[3:0] <= is_inst03_src_match[3:0];
    is_inst12_src_match[3:0] <= is_inst12_src_match[3:0];
    is_inst13_src_match[3:0] <= is_inst13_src_match[3:0];
    is_inst23_src_match[3:0] <= is_inst23_src_match[3:0];
  end
end

//==========================================================
//                   Create Data for ROB
//==========================================================
//prepare inst pc offset
assign is_dis_inst0_pc_offset[2:0]   = (is_inst0_read_data[IS_SPLIT]
                                     || is_inst0_read_data[IS_BJU])
                                       ? 3'd0 : (is_inst0_read_data[IS_LENGTH]
                                                 ? 3'd2 : 3'd1);
assign is_dis_inst1_pc_offset[2:0]   = (is_inst1_read_data[IS_SPLIT]
                                     || is_inst1_read_data[IS_BJU])
                                       ? 3'd0 : (is_inst1_read_data[IS_LENGTH]
                                                 ? 3'd2 : 3'd1);
assign is_dis_inst2_pc_offset[2:0]   = (is_inst2_read_data[IS_SPLIT]
                                     || is_inst2_read_data[IS_BJU])
                                       ? 3'd0 : (is_inst2_read_data[IS_LENGTH]
                                                 ? 3'd2 : 3'd1);
assign is_dis_inst3_pc_offset[2:0]   = (is_inst3_read_data[IS_SPLIT]
                                     || is_inst3_read_data[IS_BJU])
                                       ? 3'd0 : (is_inst3_read_data[IS_LENGTH]
                                                 ? 3'd2 : 3'd1);

assign is_dis_inst0_ras              = is_inst0_read_data[IS_RTS]
                                       || is_inst0_read_data[IS_PCALL];
assign is_dis_inst1_ras              = is_inst1_read_data[IS_RTS]
                                       || is_inst1_read_data[IS_PCALL];
assign is_dis_inst2_ras              = is_inst2_read_data[IS_RTS]
                                       || is_inst2_read_data[IS_PCALL];
assign is_dis_inst3_ras              = is_inst3_read_data[IS_RTS]
                                       || is_inst3_read_data[IS_PCALL];

assign is_dis_inst0_fp_dirty         = is_inst0_read_data[IS_DSTV_VLD]
                                       && !is_inst0_read_data[IS_DST_VREG]
                                       && !is_inst0_read_data[IS_DSTV_IMP]
                                       || is_inst0_read_data[IS_DSTE_VLD];
assign is_dis_inst1_fp_dirty         = is_inst1_read_data[IS_DSTV_VLD]
                                       && !is_inst1_read_data[IS_DST_VREG]
                                       && !is_inst1_read_data[IS_DSTV_IMP]
                                       || is_inst1_read_data[IS_DSTE_VLD];
assign is_dis_inst2_fp_dirty         = is_inst2_read_data[IS_DSTV_VLD]
                                       && !is_inst2_read_data[IS_DST_VREG]
                                       && !is_inst2_read_data[IS_DSTV_IMP]
                                       || is_inst2_read_data[IS_DSTE_VLD];
assign is_dis_inst3_fp_dirty         = is_inst3_read_data[IS_DSTV_VLD]
                                       && !is_inst3_read_data[IS_DST_VREG]
                                       && !is_inst3_read_data[IS_DSTV_IMP]
                                       || is_inst3_read_data[IS_DSTE_VLD];

assign is_dis_inst0_vec_dirty        = is_inst0_read_data[IS_DSTV_VLD]
                                       && is_inst0_read_data[IS_DST_VREG]
                                       && !is_inst0_read_data[IS_DSTV_IMP]
                                       || is_inst0_read_data[IS_VSETVLI]
                                       || is_inst0_read_data[IS_VSETVL];
assign is_dis_inst1_vec_dirty        = is_inst1_read_data[IS_DSTV_VLD]
                                       && is_inst1_read_data[IS_DST_VREG]
                                       && !is_inst1_read_data[IS_DSTV_IMP]
                                       || is_inst1_read_data[IS_VSETVLI]
                                       || is_inst1_read_data[IS_VSETVL];
assign is_dis_inst2_vec_dirty        = is_inst2_read_data[IS_DSTV_VLD]
                                       && is_inst2_read_data[IS_DST_VREG]
                                       && !is_inst2_read_data[IS_DSTV_IMP]
                                       || is_inst2_read_data[IS_VSETVLI]
                                       || is_inst2_read_data[IS_VSETVL];
assign is_dis_inst3_vec_dirty        = is_inst3_read_data[IS_DSTV_VLD]
                                       && is_inst3_read_data[IS_DST_VREG]
                                       && !is_inst3_read_data[IS_DSTV_IMP]
                                       || is_inst3_read_data[IS_VSETVLI]
                                       || is_inst3_read_data[IS_VSETVL];

//----------------------------------------------------------
//                  Create Data for Port 0
//----------------------------------------------------------
assign is_dis_inst01_pc_offset[2:0]  = is_dis_inst0_pc_offset[2:0]
                                       + is_dis_inst1_pc_offset[2:0];
assign is_dis_inst012_pc_offset[2:0] = is_dis_inst0_pc_offset[2:0]
                                       + is_dis_inst1_pc_offset[2:0]
                                       + is_dis_inst2_pc_offset[2:0];

assign is_dis_inst01_bkpta_inst      = is_inst0_read_data[IS_BKPTA_INST]
                                       || is_inst1_read_data[IS_BKPTA_INST];
assign is_dis_inst01_bkptb_inst      = is_inst0_read_data[IS_BKPTB_INST]
                                       || is_inst1_read_data[IS_BKPTB_INST];
assign is_dis_inst012_bkpta_inst     = is_inst0_read_data[IS_BKPTA_INST]
                                       || is_inst1_read_data[IS_BKPTA_INST]
                                       || is_inst2_read_data[IS_BKPTA_INST];
assign is_dis_inst012_bkptb_inst     = is_inst0_read_data[IS_BKPTB_INST]
                                       || is_inst1_read_data[IS_BKPTB_INST]
                                       || is_inst2_read_data[IS_BKPTB_INST];

assign is_dis_inst01_fp_dirty        = is_dis_inst0_fp_dirty
                                       || is_dis_inst1_fp_dirty;
assign is_dis_inst012_fp_dirty       = is_dis_inst0_fp_dirty
                                       || is_dis_inst1_fp_dirty
                                       || is_dis_inst2_fp_dirty;
assign is_dis_inst01_vec_dirty       = is_dis_inst0_vec_dirty
                                       || is_dis_inst1_vec_dirty;
assign is_dis_inst012_vec_dirty      = is_dis_inst0_vec_dirty
                                       || is_dis_inst1_vec_dirty
                                       || is_dis_inst2_vec_dirty;

// &CombBeg; @820
always @( is_inst0_read_data[205:204]
       or is_dis_inst01_fp_dirty
       or is_dis_inst012_vec_dirty
       or is_dis_inst0_ras
       or is_dis_inst01_vec_dirty
       or is_dis_inst01_bkpta_inst
       or is_inst0_read_data[202]
       or is_dis_inst01_bkptb_inst
       or is_inst0_read_data[219:218]
       or is_dis_inst0_vec_dirty
       or is_dis_inst012_pc_offset[2:0]
       or is_dis_inst0_pc_offset[2:0]
       or is_inst0_read_data[179]
       or is_dis_inst0_fp_dirty
       or is_dis_inst012_bkptb_inst
       or is_dis_inst012_bkpta_inst
       or is_inst0_read_data[270:262]
       or is_inst0_read_data[200]
       or is_dis_inst01_pc_offset[2:0]
       or ctrl_dp_is_dis_rob_create0_sel[1:0]
       or is_inst0_read_data[254:249]
       or is_dis_inst012_fp_dirty
       or is_inst0_read_data[177])
begin
  case (ctrl_dp_is_dis_rob_create0_sel[1:0])
    2'd0: begin //inst0
            idu_rtu_rob_create0_data[ROB_VEC_DIRTY]                 = is_dis_inst0_vec_dirty;
            idu_rtu_rob_create0_data[ROB_VSETVLI]                   = is_inst0_read_data[IS_VSETVLI];
            idu_rtu_rob_create0_data[ROB_VSEW:ROB_VSEW-2]           = is_inst0_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create0_data[ROB_VL:ROB_VL-7]               = is_inst0_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create0_data[ROB_VL_PRED]                   = is_inst0_read_data[IS_VL_PRED];
            idu_rtu_rob_create0_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst0_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create0_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create0_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create0_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create0_data[ROB_LOAD]                      = is_inst0_read_data[IS_LOAD];
            idu_rtu_rob_create0_data[ROB_FP_DIRTY]                  = is_dis_inst0_fp_dirty;
            idu_rtu_rob_create0_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
            idu_rtu_rob_create0_data[ROB_BKPTB_INST]                = is_inst0_read_data[IS_BKPTB_INST];
            idu_rtu_rob_create0_data[ROB_BKPTA_INST]                = is_inst0_read_data[IS_BKPTA_INST];
            idu_rtu_rob_create0_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create0_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create0_data[ROB_STORE]                     = is_inst0_read_data[IS_STADDR];
            idu_rtu_rob_create0_data[ROB_RAS]                       = is_dis_inst0_ras;
            idu_rtu_rob_create0_data[ROB_PCFIFO]                    = is_inst0_read_data[IS_PCFIFO];
            idu_rtu_rob_create0_data[ROB_BJU]                       = is_inst0_read_data[IS_BJU];
            idu_rtu_rob_create0_data[ROB_INTMASK]                   = is_inst0_read_data[IS_INTMASK];
            idu_rtu_rob_create0_data[ROB_SPLIT]                     = is_inst0_read_data[IS_SPLIT];
            idu_rtu_rob_create0_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst0_pc_offset[2:0];
            idu_rtu_rob_create0_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
            idu_rtu_rob_create0_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create0_data[ROB_VLD]                       = 1'b1;
          end
    2'd1: begin //inst0 and inst1
            idu_rtu_rob_create0_data[ROB_VEC_DIRTY]                 = is_dis_inst01_vec_dirty;
            idu_rtu_rob_create0_data[ROB_VSETVLI]                   = is_inst0_read_data[IS_VSETVLI];
            idu_rtu_rob_create0_data[ROB_VSEW:ROB_VSEW-2]           = is_inst0_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create0_data[ROB_VL:ROB_VL-7]               = is_inst0_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create0_data[ROB_VL_PRED]                   = is_inst0_read_data[IS_VL_PRED];
            idu_rtu_rob_create0_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst0_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create0_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create0_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create0_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create0_data[ROB_LOAD]                      = is_inst0_read_data[IS_LOAD];
            idu_rtu_rob_create0_data[ROB_FP_DIRTY]                  = is_dis_inst01_fp_dirty;
            idu_rtu_rob_create0_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd2;
            idu_rtu_rob_create0_data[ROB_BKPTB_INST]                = is_dis_inst01_bkptb_inst;
            idu_rtu_rob_create0_data[ROB_BKPTA_INST]                = is_dis_inst01_bkpta_inst;
            idu_rtu_rob_create0_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create0_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create0_data[ROB_STORE]                     = is_inst0_read_data[IS_STADDR];
            idu_rtu_rob_create0_data[ROB_RAS]                       = is_dis_inst0_ras;
            idu_rtu_rob_create0_data[ROB_PCFIFO]                    = is_inst0_read_data[IS_PCFIFO];
            idu_rtu_rob_create0_data[ROB_BJU]                       = is_inst0_read_data[IS_BJU];
            idu_rtu_rob_create0_data[ROB_INTMASK]                   = is_inst0_read_data[IS_INTMASK];
            idu_rtu_rob_create0_data[ROB_SPLIT]                     = is_inst0_read_data[IS_SPLIT];
            idu_rtu_rob_create0_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst01_pc_offset[2:0];
            idu_rtu_rob_create0_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd2;
            idu_rtu_rob_create0_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create0_data[ROB_VLD]                       = 1'b1;
          end
    2'd2: begin //inst0, inst1 and inst2
            idu_rtu_rob_create0_data[ROB_VEC_DIRTY]                 = is_dis_inst012_vec_dirty;
            idu_rtu_rob_create0_data[ROB_VSETVLI]                   = is_inst0_read_data[IS_VSETVLI];
            idu_rtu_rob_create0_data[ROB_VSEW:ROB_VSEW-2]           = is_inst0_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create0_data[ROB_VL:ROB_VL-7]               = is_inst0_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create0_data[ROB_VL_PRED]                   = is_inst0_read_data[IS_VL_PRED];
            idu_rtu_rob_create0_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst0_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create0_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create0_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create0_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create0_data[ROB_LOAD]                      = is_inst0_read_data[IS_LOAD];
            idu_rtu_rob_create0_data[ROB_FP_DIRTY]                  = is_dis_inst012_fp_dirty;
            idu_rtu_rob_create0_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd3;
            idu_rtu_rob_create0_data[ROB_BKPTB_INST]                = is_dis_inst012_bkptb_inst;
            idu_rtu_rob_create0_data[ROB_BKPTA_INST]                = is_dis_inst012_bkpta_inst;
            idu_rtu_rob_create0_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create0_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create0_data[ROB_STORE]                     = is_inst0_read_data[IS_STADDR];
            idu_rtu_rob_create0_data[ROB_RAS]                       = is_dis_inst0_ras;
            idu_rtu_rob_create0_data[ROB_PCFIFO]                    = is_inst0_read_data[IS_PCFIFO];
            idu_rtu_rob_create0_data[ROB_BJU]                       = is_inst0_read_data[IS_BJU];
            idu_rtu_rob_create0_data[ROB_INTMASK]                   = is_inst0_read_data[IS_INTMASK];
            idu_rtu_rob_create0_data[ROB_SPLIT]                     = is_inst0_read_data[IS_SPLIT];
            idu_rtu_rob_create0_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst012_pc_offset[2:0];
            idu_rtu_rob_create0_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd3;
            idu_rtu_rob_create0_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create0_data[ROB_VLD]                       = 1'b1;
          end
    default: begin
            idu_rtu_rob_create0_data[ROB_WIDTH-1:0]                 = {ROB_WIDTH{1'bx}};
          end
  endcase
// &CombEnd; @910
end

//----------------------------------------------------------
//                  Create Data for Port 1
//----------------------------------------------------------
//prepare inst1, inst2 and inst1/2 pc offset
assign is_dis_inst12_pc_offset[2:0]  = is_dis_inst1_pc_offset[2:0]
                                       + is_dis_inst2_pc_offset[2:0];
assign is_dis_inst123_pc_offset[2:0] = is_dis_inst1_pc_offset[2:0]
                                       + is_dis_inst2_pc_offset[2:0]
                                       + is_dis_inst3_pc_offset[2:0];

assign is_dis_inst12_bkpta_inst      = is_inst1_read_data[IS_BKPTA_INST]
                                       || is_inst2_read_data[IS_BKPTA_INST];
assign is_dis_inst12_bkptb_inst      = is_inst1_read_data[IS_BKPTB_INST]
                                       || is_inst2_read_data[IS_BKPTB_INST];
assign is_dis_inst123_bkpta_inst     = is_inst1_read_data[IS_BKPTA_INST]
                                       || is_inst2_read_data[IS_BKPTA_INST]
                                       || is_inst3_read_data[IS_BKPTA_INST];
assign is_dis_inst123_bkptb_inst     = is_inst1_read_data[IS_BKPTB_INST]
                                       || is_inst2_read_data[IS_BKPTB_INST]
                                       || is_inst3_read_data[IS_BKPTB_INST];

assign is_dis_inst12_fp_dirty        = is_dis_inst1_fp_dirty
                                       || is_dis_inst2_fp_dirty;
assign is_dis_inst123_fp_dirty       = is_dis_inst1_fp_dirty
                                       || is_dis_inst2_fp_dirty
                                       || is_dis_inst3_fp_dirty;
assign is_dis_inst12_vec_dirty       = is_dis_inst1_vec_dirty
                                       || is_dis_inst2_vec_dirty;
assign is_dis_inst123_vec_dirty      = is_dis_inst1_vec_dirty
                                       || is_dis_inst2_vec_dirty
                                       || is_dis_inst3_vec_dirty;

// &CombBeg; @944
always @( is_inst1_read_data[177]
       or is_inst3_read_data[254:249]
       or is_dis_inst3_pc_offset[2:0]
       or is_inst3_read_data[205:204]
       or is_dis_inst3_ras
       or is_dis_inst2_vec_dirty
       or is_dis_inst123_fp_dirty
       or is_inst3_read_data[219:218]
       or is_dis_inst123_bkpta_inst
       or is_inst2_read_data[202]
       or is_dis_inst12_vec_dirty
       or is_dis_inst12_pc_offset[2:0]
       or is_inst1_read_data[219:218]
       or is_inst3_read_data[200]
       or is_dis_inst12_bkptb_inst
       or is_dis_inst12_fp_dirty
       or is_dis_inst2_fp_dirty
       or is_inst3_read_data[177]
       or is_dis_inst123_vec_dirty
       or is_inst2_read_data[219:218]
       or is_inst1_read_data[200]
       or is_inst1_read_data[179]
       or is_inst2_read_data[270:262]
       or is_inst3_read_data[270:262]
       or is_dis_inst12_bkpta_inst
       or is_inst1_read_data[254:249]
       or is_dis_inst123_bkptb_inst
       or is_inst2_read_data[179]
       or is_inst2_read_data[200]
       or is_dis_inst3_fp_dirty
       or is_inst1_read_data[270:262]
       or is_inst2_read_data[177]
       or is_inst1_read_data[205:204]
       or is_dis_inst3_vec_dirty
       or is_inst1_read_data[202]
       or is_dis_inst123_pc_offset[2:0]
       or is_inst3_read_data[202]
       or ctrl_dp_is_dis_rob_create1_sel[2:0]
       or is_dis_inst1_ras
       or is_inst3_read_data[179]
       or is_dis_inst2_pc_offset[2:0]
       or is_dis_inst1_vec_dirty
       or is_inst2_read_data[254:249]
       or is_dis_inst2_ras
       or is_dis_inst1_pc_offset[2:0]
       or is_dis_inst1_fp_dirty
       or is_inst2_read_data[205:204])
begin
  case (ctrl_dp_is_dis_rob_create1_sel[2:0])
    3'd0: begin //inst1
            idu_rtu_rob_create1_data[ROB_VEC_DIRTY]                 = is_dis_inst1_vec_dirty;
            idu_rtu_rob_create1_data[ROB_VSETVLI]                   = is_inst1_read_data[IS_VSETVLI];
            idu_rtu_rob_create1_data[ROB_VSEW:ROB_VSEW-2]           = is_inst1_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create1_data[ROB_VL:ROB_VL-7]               = is_inst1_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create1_data[ROB_VL_PRED]                   = is_inst1_read_data[IS_VL_PRED];
            idu_rtu_rob_create1_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst1_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create1_data[ROB_LOAD]                      = is_inst1_read_data[IS_LOAD];
            idu_rtu_rob_create1_data[ROB_FP_DIRTY]                  = is_dis_inst1_fp_dirty;
            idu_rtu_rob_create1_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
            idu_rtu_rob_create1_data[ROB_BKPTB_INST]                = is_inst1_read_data[IS_BKPTB_INST];
            idu_rtu_rob_create1_data[ROB_BKPTA_INST]                = is_inst1_read_data[IS_BKPTA_INST];
            idu_rtu_rob_create1_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_STORE]                     = is_inst1_read_data[IS_STADDR];
            idu_rtu_rob_create1_data[ROB_RAS]                       = is_dis_inst1_ras;
            idu_rtu_rob_create1_data[ROB_PCFIFO]                    = is_inst1_read_data[IS_PCFIFO];
            idu_rtu_rob_create1_data[ROB_BJU]                       = is_inst1_read_data[IS_BJU];
            idu_rtu_rob_create1_data[ROB_INTMASK]                   = is_inst1_read_data[IS_INTMASK];
            idu_rtu_rob_create1_data[ROB_SPLIT]                     = is_inst1_read_data[IS_SPLIT];
            idu_rtu_rob_create1_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst1_pc_offset[2:0];
            idu_rtu_rob_create1_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
            idu_rtu_rob_create1_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create1_data[ROB_VLD]                       = 1'b1;
          end
    3'd1: begin //inst1 and inst2
            idu_rtu_rob_create1_data[ROB_VEC_DIRTY]                 = is_dis_inst12_vec_dirty;
            idu_rtu_rob_create1_data[ROB_VSETVLI]                   = is_inst1_read_data[IS_VSETVLI];
            idu_rtu_rob_create1_data[ROB_VSEW:ROB_VSEW-2]           = is_inst1_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create1_data[ROB_VL:ROB_VL-7]               = is_inst1_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create1_data[ROB_VL_PRED]                   = is_inst1_read_data[IS_VL_PRED];
            idu_rtu_rob_create1_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst1_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create1_data[ROB_LOAD]                      = is_inst1_read_data[IS_LOAD];
            idu_rtu_rob_create1_data[ROB_FP_DIRTY]                  = is_dis_inst12_fp_dirty;
            idu_rtu_rob_create1_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd2;
            idu_rtu_rob_create1_data[ROB_BKPTB_INST]                = is_dis_inst12_bkptb_inst;
            idu_rtu_rob_create1_data[ROB_BKPTA_INST]                = is_dis_inst12_bkpta_inst;
            idu_rtu_rob_create1_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_STORE]                     = is_inst1_read_data[IS_STADDR];
            idu_rtu_rob_create1_data[ROB_RAS]                       = is_dis_inst1_ras;
            idu_rtu_rob_create1_data[ROB_PCFIFO]                    = is_inst1_read_data[IS_PCFIFO];
            idu_rtu_rob_create1_data[ROB_BJU]                       = is_inst1_read_data[IS_BJU];
            idu_rtu_rob_create1_data[ROB_INTMASK]                   = is_inst1_read_data[IS_INTMASK];
            idu_rtu_rob_create1_data[ROB_SPLIT]                     = is_inst1_read_data[IS_SPLIT];
            idu_rtu_rob_create1_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst12_pc_offset[2:0];
            idu_rtu_rob_create1_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd2;
            idu_rtu_rob_create1_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create1_data[ROB_VLD]                       = 1'b1;
          end
    3'd2: begin //inst2
            idu_rtu_rob_create1_data[ROB_VEC_DIRTY]                 = is_dis_inst2_vec_dirty;
            idu_rtu_rob_create1_data[ROB_VSETVLI]                   = is_inst2_read_data[IS_VSETVLI];
            idu_rtu_rob_create1_data[ROB_VSEW:ROB_VSEW-2]           = is_inst2_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create1_data[ROB_VL:ROB_VL-7]               = is_inst2_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create1_data[ROB_VL_PRED]                   = is_inst2_read_data[IS_VL_PRED];
            idu_rtu_rob_create1_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst2_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create1_data[ROB_LOAD]                      = is_inst2_read_data[IS_LOAD];
            idu_rtu_rob_create1_data[ROB_FP_DIRTY]                  = is_dis_inst2_fp_dirty;
            idu_rtu_rob_create1_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
            idu_rtu_rob_create1_data[ROB_BKPTB_INST]                = is_inst2_read_data[IS_BKPTB_INST];
            idu_rtu_rob_create1_data[ROB_BKPTA_INST]                = is_inst2_read_data[IS_BKPTA_INST];
            idu_rtu_rob_create1_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_STORE]                     = is_inst2_read_data[IS_STADDR];
            idu_rtu_rob_create1_data[ROB_RAS]                       = is_dis_inst2_ras;
            idu_rtu_rob_create1_data[ROB_PCFIFO]                    = is_inst2_read_data[IS_PCFIFO];
            idu_rtu_rob_create1_data[ROB_BJU]                       = is_inst2_read_data[IS_BJU];
            idu_rtu_rob_create1_data[ROB_INTMASK]                   = is_inst2_read_data[IS_INTMASK];
            idu_rtu_rob_create1_data[ROB_SPLIT]                     = is_inst2_read_data[IS_SPLIT];
            idu_rtu_rob_create1_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst2_pc_offset[2:0];
            idu_rtu_rob_create1_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
            idu_rtu_rob_create1_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create1_data[ROB_VLD]                       = 1'b1;
          end
    3'd3: begin //inst3
            idu_rtu_rob_create1_data[ROB_VEC_DIRTY]                 = is_dis_inst3_vec_dirty;
            idu_rtu_rob_create1_data[ROB_VSETVLI]                   = is_inst3_read_data[IS_VSETVLI];
            idu_rtu_rob_create1_data[ROB_VSEW:ROB_VSEW-2]           = is_inst3_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create1_data[ROB_VL:ROB_VL-7]               = is_inst3_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create1_data[ROB_VL_PRED]                   = is_inst3_read_data[IS_VL_PRED];
            idu_rtu_rob_create1_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst3_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create1_data[ROB_LOAD]                      = is_inst3_read_data[IS_LOAD];
            idu_rtu_rob_create1_data[ROB_FP_DIRTY]                  = is_dis_inst3_fp_dirty;
            idu_rtu_rob_create1_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
            idu_rtu_rob_create1_data[ROB_BKPTB_INST]                = is_inst3_read_data[IS_BKPTB_INST];
            idu_rtu_rob_create1_data[ROB_BKPTA_INST]                = is_inst3_read_data[IS_BKPTA_INST];
            idu_rtu_rob_create1_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_STORE]                     = is_inst3_read_data[IS_STADDR];
            idu_rtu_rob_create1_data[ROB_RAS]                       = is_dis_inst3_ras;
            idu_rtu_rob_create1_data[ROB_PCFIFO]                    = is_inst3_read_data[IS_PCFIFO];
            idu_rtu_rob_create1_data[ROB_BJU]                       = is_inst3_read_data[IS_BJU];
            idu_rtu_rob_create1_data[ROB_INTMASK]                   = is_inst3_read_data[IS_INTMASK];
            idu_rtu_rob_create1_data[ROB_SPLIT]                     = is_inst3_read_data[IS_SPLIT];
            idu_rtu_rob_create1_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst3_pc_offset[2:0];
            idu_rtu_rob_create1_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
            idu_rtu_rob_create1_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create1_data[ROB_VLD]                       = 1'b1;
          end
    3'd4: begin //inst1, inst2 and inst3
            idu_rtu_rob_create1_data[ROB_VEC_DIRTY]                 = is_dis_inst123_vec_dirty;
            idu_rtu_rob_create1_data[ROB_VSETVLI]                   = is_inst1_read_data[IS_VSETVLI];
            idu_rtu_rob_create1_data[ROB_VSEW:ROB_VSEW-2]           = is_inst1_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create1_data[ROB_VL:ROB_VL-7]               = is_inst1_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create1_data[ROB_VL_PRED]                   = is_inst1_read_data[IS_VL_PRED];
            idu_rtu_rob_create1_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst1_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create1_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create1_data[ROB_LOAD]                      = is_inst1_read_data[IS_LOAD];
            idu_rtu_rob_create1_data[ROB_FP_DIRTY]                  = is_dis_inst123_fp_dirty;
            idu_rtu_rob_create1_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd3;
            idu_rtu_rob_create1_data[ROB_BKPTB_INST]                = is_dis_inst123_bkptb_inst;
            idu_rtu_rob_create1_data[ROB_BKPTA_INST]                = is_dis_inst123_bkpta_inst;
            idu_rtu_rob_create1_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create1_data[ROB_STORE]                     = is_inst1_read_data[IS_STADDR];
            idu_rtu_rob_create1_data[ROB_RAS]                       = is_dis_inst1_ras;
            idu_rtu_rob_create1_data[ROB_PCFIFO]                    = is_inst1_read_data[IS_PCFIFO];
            idu_rtu_rob_create1_data[ROB_BJU]                       = is_inst1_read_data[IS_BJU];
            idu_rtu_rob_create1_data[ROB_INTMASK]                   = is_inst1_read_data[IS_INTMASK];
            idu_rtu_rob_create1_data[ROB_SPLIT]                     = is_inst1_read_data[IS_SPLIT];
            idu_rtu_rob_create1_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst123_pc_offset[2:0];
            idu_rtu_rob_create1_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd3;
            idu_rtu_rob_create1_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create1_data[ROB_VLD]                       = 1'b1;
          end
    default: begin
            idu_rtu_rob_create1_data[ROB_WIDTH-1:0]                 = {ROB_WIDTH{1'bx}};
          end
  endcase
// &CombEnd; @1090
end

//----------------------------------------------------------
//                  Create Data for Port 2
//----------------------------------------------------------
//prepare inst2, inst3 and inst2/3 pc offset
assign is_dis_inst23_pc_offset[2:0]  = is_dis_inst2_pc_offset[2:0]
                                       + is_dis_inst3_pc_offset[2:0];
assign is_dis_inst23_bkpta_inst      = is_inst2_read_data[IS_BKPTA_INST]
                                       || is_inst3_read_data[IS_BKPTA_INST];
assign is_dis_inst23_bkptb_inst      = is_inst2_read_data[IS_BKPTB_INST]
                                       || is_inst3_read_data[IS_BKPTB_INST];

assign is_dis_inst23_fp_dirty        = is_dis_inst2_fp_dirty
                                       || is_dis_inst3_fp_dirty;
assign is_dis_inst23_vec_dirty       = is_dis_inst2_vec_dirty
                                       || is_dis_inst3_vec_dirty;

// &CombBeg; @1108
always @( is_inst3_read_data[254:249]
       or is_dis_inst3_pc_offset[2:0]
       or is_inst3_read_data[205:204]
       or is_dis_inst3_ras
       or is_dis_inst2_vec_dirty
       or is_inst3_read_data[219:218]
       or is_dis_inst23_pc_offset[2:0]
       or is_inst2_read_data[202]
       or is_inst3_read_data[200]
       or is_dis_inst23_bkptb_inst
       or is_dis_inst23_fp_dirty
       or is_dis_inst2_fp_dirty
       or is_inst3_read_data[177]
       or is_inst2_read_data[219:218]
       or ctrl_dp_is_dis_rob_create2_sel[1:0]
       or is_inst2_read_data[270:262]
       or is_inst3_read_data[270:262]
       or is_dis_inst3_fp_dirty
       or is_inst2_read_data[200]
       or is_inst2_read_data[179]
       or is_inst2_read_data[177]
       or is_dis_inst3_vec_dirty
       or is_dis_inst23_bkpta_inst
       or is_dis_inst23_vec_dirty
       or is_inst3_read_data[202]
       or is_inst3_read_data[179]
       or is_dis_inst2_pc_offset[2:0]
       or is_inst2_read_data[254:249]
       or is_dis_inst2_ras
       or is_inst2_read_data[205:204])
begin
  case (ctrl_dp_is_dis_rob_create2_sel[1:0])
    2'd0: begin //inst2
            idu_rtu_rob_create2_data[ROB_VEC_DIRTY]                 = is_dis_inst2_vec_dirty;
            idu_rtu_rob_create2_data[ROB_VSETVLI]                   = is_inst2_read_data[IS_VSETVLI];
            idu_rtu_rob_create2_data[ROB_VSEW:ROB_VSEW-2]           = is_inst2_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create2_data[ROB_VL:ROB_VL-7]               = is_inst2_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create2_data[ROB_VL_PRED]                   = is_inst2_read_data[IS_VL_PRED];
            idu_rtu_rob_create2_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst2_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create2_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create2_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create2_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create2_data[ROB_LOAD]                      = is_inst2_read_data[IS_LOAD];
            idu_rtu_rob_create2_data[ROB_FP_DIRTY]                  = is_dis_inst2_fp_dirty;
            idu_rtu_rob_create2_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
            idu_rtu_rob_create2_data[ROB_BKPTB_INST]                = is_inst2_read_data[IS_BKPTB_INST];
            idu_rtu_rob_create2_data[ROB_BKPTA_INST]                = is_inst2_read_data[IS_BKPTA_INST];
            idu_rtu_rob_create2_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create2_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create2_data[ROB_STORE]                     = is_inst2_read_data[IS_STADDR];
            idu_rtu_rob_create2_data[ROB_RAS]                       = is_dis_inst2_ras;
            idu_rtu_rob_create2_data[ROB_PCFIFO]                    = is_inst2_read_data[IS_PCFIFO];
            idu_rtu_rob_create2_data[ROB_BJU]                       = is_inst2_read_data[IS_BJU];
            idu_rtu_rob_create2_data[ROB_INTMASK]                   = is_inst2_read_data[IS_INTMASK];
            idu_rtu_rob_create2_data[ROB_SPLIT]                     = is_inst2_read_data[IS_SPLIT];
            idu_rtu_rob_create2_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst2_pc_offset[2:0];
            idu_rtu_rob_create2_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
            idu_rtu_rob_create2_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create2_data[ROB_VLD]                       = 1'b1;
          end
    2'd2: begin //inst2 and inst3
            idu_rtu_rob_create2_data[ROB_VEC_DIRTY]                 = is_dis_inst23_vec_dirty;
            idu_rtu_rob_create2_data[ROB_VSETVLI]                   = is_inst2_read_data[IS_VSETVLI];
            idu_rtu_rob_create2_data[ROB_VSEW:ROB_VSEW-2]           = is_inst2_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create2_data[ROB_VL:ROB_VL-7]               = is_inst2_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create2_data[ROB_VL_PRED]                   = is_inst2_read_data[IS_VL_PRED];
            idu_rtu_rob_create2_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst2_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create2_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create2_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create2_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create2_data[ROB_LOAD]                      = is_inst2_read_data[IS_LOAD];
            idu_rtu_rob_create2_data[ROB_FP_DIRTY]                  = is_dis_inst23_fp_dirty;
            idu_rtu_rob_create2_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd2;
            idu_rtu_rob_create2_data[ROB_BKPTB_INST]                = is_dis_inst23_bkptb_inst;
            idu_rtu_rob_create2_data[ROB_BKPTA_INST]                = is_dis_inst23_bkpta_inst;
            idu_rtu_rob_create2_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create2_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create2_data[ROB_STORE]                     = is_inst2_read_data[IS_STADDR];
            idu_rtu_rob_create2_data[ROB_RAS]                       = is_dis_inst2_ras;
            idu_rtu_rob_create2_data[ROB_PCFIFO]                    = is_inst2_read_data[IS_PCFIFO];
            idu_rtu_rob_create2_data[ROB_BJU]                       = is_inst2_read_data[IS_BJU];
            idu_rtu_rob_create2_data[ROB_INTMASK]                   = is_inst2_read_data[IS_INTMASK];
            idu_rtu_rob_create2_data[ROB_SPLIT]                     = is_inst2_read_data[IS_SPLIT];
            idu_rtu_rob_create2_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst23_pc_offset[2:0];
            idu_rtu_rob_create2_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd2;
            idu_rtu_rob_create2_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create2_data[ROB_VLD]                       = 1'b1;
          end
    2'd3: begin //inst3
            idu_rtu_rob_create2_data[ROB_VEC_DIRTY]                 = is_dis_inst3_vec_dirty;
            idu_rtu_rob_create2_data[ROB_VSETVLI]                   = is_inst3_read_data[IS_VSETVLI];
            idu_rtu_rob_create2_data[ROB_VSEW:ROB_VSEW-2]           = is_inst3_read_data[IS_VSEW:IS_VSEW-2];
            idu_rtu_rob_create2_data[ROB_VL:ROB_VL-7]               = is_inst3_read_data[IS_VL:IS_VL-7];
            idu_rtu_rob_create2_data[ROB_VL_PRED]                   = is_inst3_read_data[IS_VL_PRED];
            idu_rtu_rob_create2_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst3_read_data[IS_VLMUL:IS_VLMUL-1];
            idu_rtu_rob_create2_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
            idu_rtu_rob_create2_data[ROB_NO_SPEC_MISS]              = 1'b0;
            idu_rtu_rob_create2_data[ROB_NO_SPEC_HIT]               = 1'b0;
            idu_rtu_rob_create2_data[ROB_LOAD]                      = is_inst3_read_data[IS_LOAD];
            idu_rtu_rob_create2_data[ROB_FP_DIRTY]                  = is_dis_inst3_fp_dirty;
            idu_rtu_rob_create2_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
            idu_rtu_rob_create2_data[ROB_BKPTB_INST]                = is_inst3_read_data[IS_BKPTB_INST];
            idu_rtu_rob_create2_data[ROB_BKPTA_INST]                = is_inst3_read_data[IS_BKPTA_INST];
            idu_rtu_rob_create2_data[ROB_BKPTB_DATA]                = 1'b0;
            idu_rtu_rob_create2_data[ROB_BKPTA_DATA]                = 1'b0;
            idu_rtu_rob_create2_data[ROB_STORE]                     = is_inst3_read_data[IS_STADDR];
            idu_rtu_rob_create2_data[ROB_RAS]                       = is_dis_inst3_ras;
            idu_rtu_rob_create2_data[ROB_PCFIFO]                    = is_inst3_read_data[IS_PCFIFO];
            idu_rtu_rob_create2_data[ROB_BJU]                       = is_inst3_read_data[IS_BJU];
            idu_rtu_rob_create2_data[ROB_INTMASK]                   = is_inst3_read_data[IS_INTMASK];
            idu_rtu_rob_create2_data[ROB_SPLIT]                     = is_inst3_read_data[IS_SPLIT];
            idu_rtu_rob_create2_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst3_pc_offset[2:0];
            idu_rtu_rob_create2_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
            idu_rtu_rob_create2_data[ROB_CMPLT]                     = 1'b0;
            idu_rtu_rob_create2_data[ROB_VLD]                       = 1'b1;
          end
    default: begin
            idu_rtu_rob_create2_data[ROB_WIDTH-1:0]                 = {ROB_WIDTH{1'bx}};
          end
  endcase
// &CombEnd; @1198
end

//----------------------------------------------------------
//                  Create Data for Port 3
//----------------------------------------------------------
//create port 0 is always from inst3
assign idu_rtu_rob_create3_data[ROB_VEC_DIRTY]                 = is_dis_inst3_vec_dirty;
assign idu_rtu_rob_create3_data[ROB_VSETVLI]                   = is_inst3_read_data[IS_VSETVLI];
assign idu_rtu_rob_create3_data[ROB_VSEW:ROB_VSEW-2]           = is_inst3_read_data[IS_VSEW:IS_VSEW-2];
assign idu_rtu_rob_create3_data[ROB_VL:ROB_VL-7]               = is_inst3_read_data[IS_VL:IS_VL-7];
assign idu_rtu_rob_create3_data[ROB_VL_PRED]                   = is_inst3_read_data[IS_VL_PRED];
assign idu_rtu_rob_create3_data[ROB_VLMUL:ROB_VLMUL-1]         = is_inst3_read_data[IS_VLMUL:IS_VLMUL-1];
assign idu_rtu_rob_create3_data[ROB_NO_SPEC_MISPRED]           = 1'b0;
assign idu_rtu_rob_create3_data[ROB_NO_SPEC_MISS]              = 1'b0;
assign idu_rtu_rob_create3_data[ROB_NO_SPEC_HIT]               = 1'b0;
assign idu_rtu_rob_create3_data[ROB_LOAD]                      = is_inst3_read_data[IS_LOAD];
assign idu_rtu_rob_create3_data[ROB_FP_DIRTY]                  = is_dis_inst3_fp_dirty;
assign idu_rtu_rob_create3_data[ROB_INST_NUM:ROB_INST_NUM-1]   = 2'd1;
assign idu_rtu_rob_create3_data[ROB_BKPTB_INST]                = is_inst3_read_data[IS_BKPTB_INST];
assign idu_rtu_rob_create3_data[ROB_BKPTA_INST]                = is_inst3_read_data[IS_BKPTA_INST];
assign idu_rtu_rob_create3_data[ROB_BKPTB_DATA]                = 1'b0;
assign idu_rtu_rob_create3_data[ROB_BKPTA_DATA]                = 1'b0;
assign idu_rtu_rob_create3_data[ROB_STORE]                     = is_inst3_read_data[IS_STADDR];
assign idu_rtu_rob_create3_data[ROB_RAS]                       = is_dis_inst3_ras;
assign idu_rtu_rob_create3_data[ROB_PCFIFO]                    = is_inst3_read_data[IS_PCFIFO];
assign idu_rtu_rob_create3_data[ROB_BJU]                       = is_inst3_read_data[IS_BJU];
assign idu_rtu_rob_create3_data[ROB_INTMASK]                   = is_inst3_read_data[IS_INTMASK];
assign idu_rtu_rob_create3_data[ROB_SPLIT]                     = is_inst3_read_data[IS_SPLIT];
assign idu_rtu_rob_create3_data[ROB_PC_OFFSET:ROB_PC_OFFSET-2] = is_dis_inst3_pc_offset[2:0];
assign idu_rtu_rob_create3_data[ROB_CMPLT_CNT:ROB_CMPLT_CNT-1] = 2'd1;
assign idu_rtu_rob_create3_data[ROB_CMPLT]                     = 1'b0;
assign idu_rtu_rob_create3_data[ROB_VLD]                       = 1'b1;

//----------------------------------------------------------
//                       Assign IID
//----------------------------------------------------------
assign is_inst0_iid[6:0] = rtu_idu_rob_inst0_iid[6:0];
assign is_inst1_iid[6:0] = (ctrl_dp_is_dis_pst_create1_iid_sel)
                           ? rtu_idu_rob_inst0_iid[6:0]
                           : rtu_idu_rob_inst1_iid[6:0];
assign is_inst2_iid[6:0] =
   {7{ctrl_dp_is_dis_pst_create2_iid_sel[0]}} & rtu_idu_rob_inst0_iid[6:0]
 | {7{ctrl_dp_is_dis_pst_create2_iid_sel[1]}} & rtu_idu_rob_inst1_iid[6:0]
 | {7{ctrl_dp_is_dis_pst_create2_iid_sel[2]}} & rtu_idu_rob_inst2_iid[6:0];
assign is_inst3_iid[6:0] =
   {7{ctrl_dp_is_dis_pst_create3_iid_sel[0]}} & rtu_idu_rob_inst1_iid[6:0]
 | {7{ctrl_dp_is_dis_pst_create3_iid_sel[1]}} & rtu_idu_rob_inst2_iid[6:0]
 | {7{ctrl_dp_is_dis_pst_create3_iid_sel[2]}} & rtu_idu_rob_inst3_iid[6:0];

//==========================================================
//                 Create Data for PST
//==========================================================
//----------------------------------------------------------
//                 Output for Control Logic
//----------------------------------------------------------
assign dp_ctrl_is_inst0_dst_vld  = is_inst0_read_data[IS_DST_VLD];
assign dp_ctrl_is_inst1_dst_vld  = is_inst1_read_data[IS_DST_VLD];
assign dp_ctrl_is_inst2_dst_vld  = is_inst2_read_data[IS_DST_VLD];
assign dp_ctrl_is_inst3_dst_vld  = is_inst3_read_data[IS_DST_VLD];

assign dp_ctrl_is_inst0_dstv_vld = is_inst0_read_data[IS_DSTV_VLD];
assign dp_ctrl_is_inst1_dstv_vld = is_inst1_read_data[IS_DSTV_VLD];
assign dp_ctrl_is_inst2_dstv_vld = is_inst2_read_data[IS_DSTV_VLD];
assign dp_ctrl_is_inst3_dstv_vld = is_inst3_read_data[IS_DSTV_VLD];

assign dp_ctrl_is_inst0_dstv_vec = is_inst0_read_data[IS_DST_VREG];
assign dp_ctrl_is_inst1_dstv_vec = is_inst1_read_data[IS_DST_VREG];
assign dp_ctrl_is_inst2_dstv_vec = is_inst2_read_data[IS_DST_VREG];
assign dp_ctrl_is_inst3_dstv_vec = is_inst3_read_data[IS_DST_VREG];

assign dp_ctrl_is_inst0_dste_vld = is_inst0_read_data[IS_DSTE_VLD];
assign dp_ctrl_is_inst1_dste_vld = is_inst1_read_data[IS_DSTE_VLD];
assign dp_ctrl_is_inst2_dste_vld = is_inst2_read_data[IS_DSTE_VLD];
assign dp_ctrl_is_inst3_dste_vld = is_inst3_read_data[IS_DSTE_VLD];

//----------------------------------------------------------
//                     Output for RTU
//----------------------------------------------------------
//implicit dest should create iid+1, which is iid of split consumer
assign dis_inst0_iid[6:0]      = is_inst0_iid[6:0] +
                                 {3'b0,is_inst0_read_data[IS_IID_PLUS:IS_IID_PLUS-3]};
assign dis_inst1_iid[6:0]      = is_inst1_iid[6:0] +
                                 {3'b0,is_inst1_read_data[IS_IID_PLUS:IS_IID_PLUS-3]};
assign dis_inst2_iid[6:0]      = is_inst2_iid[6:0] +
                                 {3'b0,is_inst2_read_data[IS_IID_PLUS:IS_IID_PLUS-3]};
assign dis_inst3_iid[6:0]      = is_inst3_iid[6:0] +
                                 {3'b0,is_inst3_read_data[IS_IID_PLUS:IS_IID_PLUS-3]};

//power optimization: operand mux for pst_create_iid
assign idu_rtu_pst_dis_inst0_preg_iid[6:0] = {7{ctrl_dp_dis_inst0_preg_vld}}
                                             & dis_inst0_iid[6:0];
assign idu_rtu_pst_dis_inst1_preg_iid[6:0] = {7{ctrl_dp_dis_inst1_preg_vld}}
                                             & dis_inst1_iid[6:0];
assign idu_rtu_pst_dis_inst2_preg_iid[6:0] = {7{ctrl_dp_dis_inst2_preg_vld}}
                                             & dis_inst2_iid[6:0];
assign idu_rtu_pst_dis_inst3_preg_iid[6:0] = {7{ctrl_dp_dis_inst3_preg_vld}}
                                             & dis_inst3_iid[6:0];

assign idu_rtu_pst_dis_inst0_vreg_iid[6:0] = {7{ctrl_dp_dis_inst0_vreg_vld
                                             || ctrl_dp_dis_inst0_freg_vld}}
                                             & dis_inst0_iid[6:0];
assign idu_rtu_pst_dis_inst1_vreg_iid[6:0] = {7{ctrl_dp_dis_inst1_vreg_vld
                                             || ctrl_dp_dis_inst1_freg_vld}}
                                             & dis_inst1_iid[6:0];
assign idu_rtu_pst_dis_inst2_vreg_iid[6:0] = {7{ctrl_dp_dis_inst2_vreg_vld
                                             || ctrl_dp_dis_inst2_freg_vld}}
                                             & dis_inst2_iid[6:0];
assign idu_rtu_pst_dis_inst3_vreg_iid[6:0] = {7{ctrl_dp_dis_inst3_vreg_vld
                                             || ctrl_dp_dis_inst3_freg_vld}}
                                             & dis_inst3_iid[6:0];

//if inst expt, it should write ereg, split inst should always its iid without plus
//no problem because split consumer never read ereg
assign idu_rtu_pst_dis_inst0_ereg_iid[6:0] = {7{ctrl_dp_dis_inst0_ereg_vld}}
                                             & is_inst0_iid[6:0];
assign idu_rtu_pst_dis_inst1_ereg_iid[6:0] = {7{ctrl_dp_dis_inst1_ereg_vld}}
                                             & is_inst1_iid[6:0];
assign idu_rtu_pst_dis_inst2_ereg_iid[6:0] = {7{ctrl_dp_dis_inst2_ereg_vld}}
                                             & is_inst2_iid[6:0];
assign idu_rtu_pst_dis_inst3_ereg_iid[6:0] = {7{ctrl_dp_dis_inst3_ereg_vld}}
                                             & is_inst3_iid[6:0];

assign idu_rtu_pst_dis_inst0_dst_reg[5:0]  = is_inst0_read_data[IS_DST_REG:IS_DST_REG-5];
assign idu_rtu_pst_dis_inst1_dst_reg[5:0]  = is_inst1_read_data[IS_DST_REG:IS_DST_REG-5];
assign idu_rtu_pst_dis_inst2_dst_reg[5:0]  = is_inst2_read_data[IS_DST_REG:IS_DST_REG-5];
assign idu_rtu_pst_dis_inst3_dst_reg[5:0]  = is_inst3_read_data[IS_DST_REG:IS_DST_REG-5];

assign idu_rtu_pst_dis_inst0_preg[6:0]     = is_inst0_read_data[IS_DST_PREG:IS_DST_PREG-6];
assign idu_rtu_pst_dis_inst1_preg[6:0]     = is_inst1_read_data[IS_DST_PREG:IS_DST_PREG-6];
assign idu_rtu_pst_dis_inst2_preg[6:0]     = is_inst2_read_data[IS_DST_PREG:IS_DST_PREG-6];
assign idu_rtu_pst_dis_inst3_preg[6:0]     = is_inst3_read_data[IS_DST_PREG:IS_DST_PREG-6];

assign idu_rtu_pst_dis_inst0_rel_preg[6:0] = is_inst0_read_data[IS_DST_REL_PREG:IS_DST_REL_PREG-6];
assign idu_rtu_pst_dis_inst1_rel_preg[6:0] = is_inst1_read_data[IS_DST_REL_PREG:IS_DST_REL_PREG-6];
assign idu_rtu_pst_dis_inst2_rel_preg[6:0] = is_inst2_read_data[IS_DST_REL_PREG:IS_DST_REL_PREG-6];
assign idu_rtu_pst_dis_inst3_rel_preg[6:0] = is_inst3_read_data[IS_DST_REL_PREG:IS_DST_REL_PREG-6];

assign idu_rtu_pst_dis_inst0_dstv_reg[4:0]  = is_inst0_read_data[IS_DSTV_REG:IS_DSTV_REG-4];
assign idu_rtu_pst_dis_inst1_dstv_reg[4:0]  = is_inst1_read_data[IS_DSTV_REG:IS_DSTV_REG-4];
assign idu_rtu_pst_dis_inst2_dstv_reg[4:0]  = is_inst2_read_data[IS_DSTV_REG:IS_DSTV_REG-4];
assign idu_rtu_pst_dis_inst3_dstv_reg[4:0]  = is_inst3_read_data[IS_DSTV_REG:IS_DSTV_REG-4];

assign idu_rtu_pst_dis_inst0_vreg[5:0]     = is_inst0_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
assign idu_rtu_pst_dis_inst1_vreg[5:0]     = is_inst1_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
assign idu_rtu_pst_dis_inst2_vreg[5:0]     = is_inst2_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
assign idu_rtu_pst_dis_inst3_vreg[5:0]     = is_inst3_read_data[IS_DST_VREG-1:IS_DST_VREG-6];

assign idu_rtu_pst_dis_inst0_rel_vreg[5:0] = is_inst0_read_data[IS_DST_REL_VREG-1:IS_DST_REL_VREG-6];
assign idu_rtu_pst_dis_inst1_rel_vreg[5:0] = is_inst1_read_data[IS_DST_REL_VREG-1:IS_DST_REL_VREG-6];
assign idu_rtu_pst_dis_inst2_rel_vreg[5:0] = is_inst2_read_data[IS_DST_REL_VREG-1:IS_DST_REL_VREG-6];
assign idu_rtu_pst_dis_inst3_rel_vreg[5:0] = is_inst3_read_data[IS_DST_REL_VREG-1:IS_DST_REL_VREG-6];

assign idu_rtu_pst_dis_inst0_ereg[4:0]     = is_inst0_read_data[IS_DST_EREG:IS_DST_EREG-4];
assign idu_rtu_pst_dis_inst1_ereg[4:0]     = is_inst1_read_data[IS_DST_EREG:IS_DST_EREG-4];
assign idu_rtu_pst_dis_inst2_ereg[4:0]     = is_inst2_read_data[IS_DST_EREG:IS_DST_EREG-4];
assign idu_rtu_pst_dis_inst3_ereg[4:0]     = is_inst3_read_data[IS_DST_EREG:IS_DST_EREG-4];

assign idu_rtu_pst_dis_inst0_rel_ereg[4:0] = is_inst0_read_data[IS_DST_REL_EREG:IS_DST_REL_EREG-4];
assign idu_rtu_pst_dis_inst1_rel_ereg[4:0] = is_inst1_read_data[IS_DST_REL_EREG:IS_DST_REL_EREG-4];
assign idu_rtu_pst_dis_inst2_rel_ereg[4:0] = is_inst2_read_data[IS_DST_REL_EREG:IS_DST_REL_EREG-4];
assign idu_rtu_pst_dis_inst3_rel_ereg[4:0] = is_inst3_read_data[IS_DST_REL_EREG:IS_DST_REL_EREG-4];

// &Force("input","rtu_idu_retire_int_vld"); @1360

//==========================================================
//                 Create Data for LSU VMB
//==========================================================
//----------------------------------------------------------
//                  Create Data for Port 0
//----------------------------------------------------------
// &CombBeg; @1459
always @( is_inst2_read_data[269:262]
       or is_inst1_read_data[242:236]
       or is_inst0_read_data[269:262]
       or is_inst2_read_data[242:236]
       or is_inst2_read_data[157:152]
       or is_inst0_read_data[260:259]
       or is_inst3_read_data[269:262]
       or is_inst3_read_data[242:236]
       or is_inst2_read_data[260:259]
       or ctrl_sdiq_create0_dp_en
       or is_inst3_read_data[260:259]
       or is_inst1_read_data[157:152]
       or is_inst0_read_data[157:152]
       or is_inst2_read_data[252:251]
       or is_inst0_read_data[242:236]
       or is_inst0_read_data[252:251]
       or is_inst3_read_data[252:251]
       or sdiq_dp_create0_entry[11:0]
       or is_inst1_read_data[269:262]
       or is_inst1_read_data[252:251]
       or ctrl_dp_is_dis_vmb_create0_sel[1:0]
       or is_inst1_read_data[260:259]
       or is_inst3_read_data[157:152])
begin
  case (ctrl_dp_is_dis_vmb_create0_sel[1:0])
    2'd0: begin //inst0
            idu_lsu_vmb_create0_vl[7:0]                            = is_inst0_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create0_vsew[1:0]                          = is_inst0_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create0_vreg[5:0]                          = is_inst0_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create0_split_num[6:0]                     = is_inst0_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create0_unit_stride                        = is_inst0_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create0_vamo                               = is_inst0_read_data[IS_VAMO];
            idu_lsu_vmb_create0_sdiq_entry[11:0]                   = sdiq_dp_create0_entry[11:0];
            idu_lsu_vmb_create0_dst_ready                          = !ctrl_sdiq_create0_dp_en;
          end
    2'd1: begin //inst1
            idu_lsu_vmb_create0_vl[7:0]                            = is_inst1_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create0_vsew[1:0]                          = is_inst1_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create0_vreg[5:0]                          = is_inst1_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create0_split_num[6:0]                     = is_inst1_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create0_unit_stride                        = is_inst1_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create0_vamo                               = is_inst1_read_data[IS_VAMO];
            idu_lsu_vmb_create0_sdiq_entry[11:0]                   = sdiq_dp_create0_entry[11:0];
            idu_lsu_vmb_create0_dst_ready                          = !ctrl_sdiq_create0_dp_en;
          end
    2'd2: begin //inst2
            idu_lsu_vmb_create0_vl[7:0]                            = is_inst2_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create0_vsew[1:0]                          = is_inst2_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create0_vreg[5:0]                          = is_inst2_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create0_split_num[6:0]                     = is_inst2_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create0_unit_stride                        = is_inst2_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create0_vamo                               = is_inst2_read_data[IS_VAMO];
            idu_lsu_vmb_create0_sdiq_entry[11:0]                   = sdiq_dp_create0_entry[11:0];
            idu_lsu_vmb_create0_dst_ready                          = !ctrl_sdiq_create0_dp_en;
          end
    2'd3: begin //inst3
            idu_lsu_vmb_create0_vl[7:0]                            = is_inst3_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create0_vsew[1:0]                          = is_inst3_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create0_vreg[5:0]                          = is_inst3_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create0_split_num[6:0]                     = is_inst3_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create0_unit_stride                        = is_inst3_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create0_vamo                               = is_inst3_read_data[IS_VAMO];
            idu_lsu_vmb_create0_sdiq_entry[11:0]                   = sdiq_dp_create0_entry[11:0];
            idu_lsu_vmb_create0_dst_ready                          = !ctrl_sdiq_create0_dp_en;
          end
    default: begin
            idu_lsu_vmb_create0_vl[7:0]                            = {8{1'bx}};
            idu_lsu_vmb_create0_vsew[1:0]                          = {2{1'bx}};
            idu_lsu_vmb_create0_vreg[5:0]                          = {6{1'bx}};
            idu_lsu_vmb_create0_split_num[6:0]                     = {7{1'bx}};
            idu_lsu_vmb_create0_unit_stride                        = 1'bx;
            idu_lsu_vmb_create0_vamo                               = 1'bx;
            idu_lsu_vmb_create0_sdiq_entry[11:0]                   = {12{1'bx}};
            idu_lsu_vmb_create0_dst_ready                          = 1'bx;
          end
  endcase
// &CombEnd; @1512
end

//----------------------------------------------------------
//                  Create Data for Port 1
//----------------------------------------------------------
// &CombBeg; @1517
always @( is_inst2_read_data[269:262]
       or is_inst1_read_data[242:236]
       or is_inst0_read_data[269:262]
       or sdiq_vmb_create1_dp_en
       or is_inst2_read_data[242:236]
       or is_inst2_read_data[157:152]
       or is_inst0_read_data[260:259]
       or is_inst3_read_data[269:262]
       or is_inst3_read_data[242:236]
       or is_inst2_read_data[260:259]
       or ctrl_dp_is_dis_vmb_create1_sel[1:0]
       or is_inst3_read_data[260:259]
       or is_inst1_read_data[157:152]
       or is_inst0_read_data[157:152]
       or is_inst2_read_data[252:251]
       or is_inst0_read_data[242:236]
       or is_inst0_read_data[252:251]
       or is_inst3_read_data[252:251]
       or is_inst1_read_data[269:262]
       or is_inst1_read_data[252:251]
       or sdiq_vmb_create1_entry[11:0]
       or is_inst1_read_data[260:259]
       or is_inst3_read_data[157:152])
begin
  case (ctrl_dp_is_dis_vmb_create1_sel[1:0])
    2'd0: begin //inst0
            idu_lsu_vmb_create1_vl[7:0]                            = is_inst0_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create1_vsew[1:0]                          = is_inst0_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create1_vreg[5:0]                          = is_inst0_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create1_split_num[6:0]                     = is_inst0_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create1_unit_stride                        = is_inst0_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create1_vamo                               = is_inst0_read_data[IS_VAMO];
            idu_lsu_vmb_create1_sdiq_entry[11:0]                   = sdiq_vmb_create1_entry[11:0];
            idu_lsu_vmb_create1_dst_ready                          = !sdiq_vmb_create1_dp_en;
          end
    2'd1: begin //inst1
            idu_lsu_vmb_create1_vl[7:0]                            = is_inst1_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create1_vsew[1:0]                          = is_inst1_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create1_vreg[5:0]                          = is_inst1_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create1_split_num[6:0]                     = is_inst1_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create1_unit_stride                        = is_inst1_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create1_vamo                               = is_inst1_read_data[IS_VAMO];
            idu_lsu_vmb_create1_sdiq_entry[11:0]                   = sdiq_vmb_create1_entry[11:0];
            idu_lsu_vmb_create1_dst_ready                          = !sdiq_vmb_create1_dp_en;
          end
    2'd2: begin //inst2
            idu_lsu_vmb_create1_vl[7:0]                            = is_inst2_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create1_vsew[1:0]                          = is_inst2_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create1_vreg[5:0]                          = is_inst2_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create1_split_num[6:0]                     = is_inst2_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create1_unit_stride                        = is_inst2_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create1_vamo                               = is_inst2_read_data[IS_VAMO];
            idu_lsu_vmb_create1_sdiq_entry[11:0]                   = sdiq_vmb_create1_entry[11:0];
            idu_lsu_vmb_create1_dst_ready                          = !sdiq_vmb_create1_dp_en;
          end
    2'd3: begin //inst3
            idu_lsu_vmb_create1_vl[7:0]                            = is_inst3_read_data[IS_VL:IS_VL-7];
            idu_lsu_vmb_create1_vsew[1:0]                          = is_inst3_read_data[IS_VSEW-1:IS_VSEW-2];
            idu_lsu_vmb_create1_vreg[5:0]                          = is_inst3_read_data[IS_DST_VREG-1:IS_DST_VREG-6];
            idu_lsu_vmb_create1_split_num[6:0]                     = is_inst3_read_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
            idu_lsu_vmb_create1_unit_stride                        = is_inst3_read_data[IS_UNIT_STRIDE];
            idu_lsu_vmb_create1_vamo                               = is_inst3_read_data[IS_VAMO];
            idu_lsu_vmb_create1_sdiq_entry[11:0]                   = sdiq_vmb_create1_entry[11:0];
            idu_lsu_vmb_create1_dst_ready                          = !sdiq_vmb_create1_dp_en;
          end
    default: begin
            idu_lsu_vmb_create1_vl[7:0]                            = {8{1'bx}};
            idu_lsu_vmb_create1_vsew[1:0]                          = {2{1'bx}};
            idu_lsu_vmb_create1_vreg[5:0]                          = {6{1'bx}};
            idu_lsu_vmb_create1_split_num[6:0]                     = {7{1'bx}};
            idu_lsu_vmb_create1_unit_stride                        = 1'bx;
            idu_lsu_vmb_create1_vamo                               = 1'bx;
            idu_lsu_vmb_create1_sdiq_entry[11:0]                   = {12{1'bx}};
            idu_lsu_vmb_create1_dst_ready                          = 1'bx;
          end
  endcase
// &CombEnd; @1570
end

//==========================================================
//                 Assign PCFIFO ID (PID)
//==========================================================
assign is_inst0_pcfifo   = is_inst0_read_data[IS_PCFIFO];
assign is_inst1_pcfifo   = is_inst1_read_data[IS_PCFIFO];
assign is_inst2_pcfifo   = is_inst2_read_data[IS_PCFIFO];
assign is_inst3_pcfifo   = is_inst3_read_data[IS_PCFIFO];

assign dp_ctrl_is_inst0_pcfifo = is_inst0_pcfifo;
assign dp_ctrl_is_inst1_pcfifo = is_inst1_pcfifo;
assign dp_ctrl_is_inst2_pcfifo = is_inst2_pcfifo;
assign dp_ctrl_is_inst3_pcfifo = is_inst3_pcfifo;

assign is_inst0_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst0_pid[4:0];
assign is_inst1_alloc_pid[4:0] = (is_inst0_pcfifo)
                                 ? iu_idu_pcfifo_dis_inst1_pid[4:0]
                                 : iu_idu_pcfifo_dis_inst0_pid[4:0];
// &CombBeg; @1589
always @( iu_idu_pcfifo_dis_inst0_pid[4:0]
       or iu_idu_pcfifo_dis_inst1_pid[4:0]
       or iu_idu_pcfifo_dis_inst2_pid[4:0]
       or is_inst0_pcfifo
       or is_inst1_pcfifo)
begin
  if(is_inst0_pcfifo && is_inst1_pcfifo)
    is_inst2_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst2_pid[4:0];
  else if(is_inst0_pcfifo || is_inst1_pcfifo)
    is_inst2_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst1_pid[4:0];
  else
    is_inst2_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst0_pid[4:0];
// &CombEnd; @1596
end
//cannot dispatch 4 pcfifo inst
// &CombBeg; @1598
always @( iu_idu_pcfifo_dis_inst0_pid[4:0]
       or iu_idu_pcfifo_dis_inst1_pid[4:0]
       or iu_idu_pcfifo_dis_inst2_pid[4:0]
       or iu_idu_pcfifo_dis_inst3_pid[4:0]
       or is_inst2_pcfifo
       or is_inst0_pcfifo
       or is_inst1_pcfifo)
begin
  if(is_inst0_pcfifo && is_inst1_pcfifo && is_inst2_pcfifo)
    is_inst3_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst3_pid[4:0];
  else if(is_inst0_pcfifo && is_inst1_pcfifo
     || is_inst0_pcfifo && is_inst2_pcfifo
     || is_inst1_pcfifo && is_inst2_pcfifo)
    is_inst3_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst2_pid[4:0];
  else if(is_inst0_pcfifo
          || is_inst1_pcfifo
          || is_inst2_pcfifo)
    is_inst3_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst1_pid[4:0];
  else
    is_inst3_alloc_pid[4:0] = iu_idu_pcfifo_dis_inst0_pid[4:0];
// &CombEnd; @1611
end

//power optimization: mask pipedown index if dst not valid
assign is_inst0_pid[4:0] = {5{is_inst0_pcfifo}} & is_inst0_alloc_pid[4:0];
assign is_inst1_pid[4:0] = {5{is_inst1_pcfifo}} & is_inst1_alloc_pid[4:0];
assign is_inst2_pid[4:0] = {5{is_inst2_pcfifo}} & is_inst2_alloc_pid[4:0];
assign is_inst3_pid[4:0] = {5{is_inst3_pcfifo}} & is_inst3_alloc_pid[4:0];

//==========================================================
//               Create Launch Ready for AIQ
//==========================================================
//----------------------------------------------------------
//               Issue Queue Create entry
//----------------------------------------------------------
assign ctrl_is_aiq0_create0_entry[7:0] = {8{ctrl_aiq0_create0_dp_en}}
                                         & aiq0_aiq_create0_entry[7:0];
assign ctrl_is_aiq0_create1_entry[7:0] = {8{ctrl_aiq0_create1_dp_en}}
                                         & aiq0_aiq_create1_entry[7:0];

assign ctrl_is_aiq1_create0_entry[7:0] = {8{ctrl_aiq1_create0_dp_en}}
                                         & aiq1_aiq_create0_entry[7:0];
assign ctrl_is_aiq1_create1_entry[7:0] = {8{ctrl_aiq1_create1_dp_en}}
                                         & aiq1_aiq_create1_entry[7:0];

assign ctrl_is_biq_create0_entry[11:0] = {12{ctrl_biq_create0_dp_en}}
                                         & biq_aiq_create0_entry[11:0];
assign ctrl_is_biq_create1_entry[11:0] = {12{ctrl_biq_create1_dp_en}}
                                         & biq_aiq_create1_entry[11:0];

assign ctrl_is_lsiq_create0_entry[11:0] = {12{ctrl_lsiq_create0_dp_en}}
                                         & lsiq_aiq_create0_entry[11:0];
assign ctrl_is_lsiq_create1_entry[11:0] = {12{ctrl_lsiq_create1_dp_en}}
                                         & lsiq_aiq_create1_entry[11:0];

assign ctrl_is_sdiq_create0_entry[11:0] = {12{ctrl_sdiq_create0_dp_en}}
                                          & sdiq_aiq_create0_entry[11:0];
assign ctrl_is_sdiq_create1_entry[11:0] = {12{ctrl_sdiq_create1_dp_en}}
                                          & sdiq_aiq_create1_entry[11:0];

assign ctrl_is_viq0_create0_entry[7:0] = {8{ctrl_viq0_create0_dp_en}}
                                         & viq0_viq_create0_entry[7:0];
assign ctrl_is_viq0_create1_entry[7:0] = {8{ctrl_viq0_create1_dp_en}}
                                         & viq0_viq_create1_entry[7:0];

assign ctrl_is_viq1_create0_entry[7:0] = {8{ctrl_viq1_create0_dp_en}}
                                         & viq1_viq_create0_entry[7:0];
assign ctrl_is_viq1_create1_entry[7:0] = {8{ctrl_viq1_create1_dp_en}}
                                         & viq1_viq_create1_entry[7:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready AIQ0
//----------------------------------------------------------
// &CombBeg; @1663
always @( is_inst02_src_match[2:0]
       or is_inst03_src_match[2:0]
       or is_inst01_src_match[2:0]
       or ctrl_dp_is_dis_aiq0_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_aiq0_create0_sel[1:0])
    2'd0:   is_inst0_aiq0_create0_src_match[2:0] = 3'b0;
    2'd1:   is_inst0_aiq0_create0_src_match[2:0] = is_inst01_src_match[2:0];
    2'd2:   is_inst0_aiq0_create0_src_match[2:0] = is_inst02_src_match[2:0];
    2'd3:   is_inst0_aiq0_create0_src_match[2:0] = is_inst03_src_match[2:0];
    default:is_inst0_aiq0_create0_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @1671
end

// &CombBeg; @1673
always @( is_inst02_src_match[2:0]
       or ctrl_dp_is_dis_aiq0_create1_sel[1:0]
       or is_inst03_src_match[2:0]
       or is_inst01_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq0_create1_sel[1:0])
    2'd0:   is_inst0_aiq0_create1_src_match[2:0] = 3'b0;
    2'd1:   is_inst0_aiq0_create1_src_match[2:0] = is_inst01_src_match[2:0];
    2'd2:   is_inst0_aiq0_create1_src_match[2:0] = is_inst02_src_match[2:0];
    2'd3:   is_inst0_aiq0_create1_src_match[2:0] = is_inst03_src_match[2:0];
    default:is_inst0_aiq0_create1_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @1681
end

assign is_inst0_lch_rdy_aiq0_create0[23:0] =
  {is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[7]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[6]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[5]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[4]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[3]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[2]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[1]}},
   is_inst0_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[0]}}};
assign is_inst0_lch_rdy_aiq0_create1[23:0] =
  {is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[7]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[6]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[5]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[4]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[3]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[2]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[1]}},
   is_inst0_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[0]}}};

assign is_inst0_lch_rdy_aiq0[23:0] =   is_inst0_lch_rdy_aiq0_create0[23:0]
                                     | is_inst0_lch_rdy_aiq0_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready AIQ1
//----------------------------------------------------------
// &CombBeg; @1708
always @( is_inst02_src_match[2:0]
       or is_inst03_src_match[2:0]
       or is_inst01_src_match[2:0]
       or ctrl_dp_is_dis_aiq1_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_aiq1_create0_sel[1:0])
    2'd0:   is_inst0_aiq1_create0_src_match[2:0] = 3'b0;
    2'd1:   is_inst0_aiq1_create0_src_match[2:0] = is_inst01_src_match[2:0];
    2'd2:   is_inst0_aiq1_create0_src_match[2:0] = is_inst02_src_match[2:0];
    2'd3:   is_inst0_aiq1_create0_src_match[2:0] = is_inst03_src_match[2:0];
    default:is_inst0_aiq1_create0_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @1716
end

// &CombBeg; @1718
always @( ctrl_dp_is_dis_aiq1_create1_sel[1:0]
       or is_inst02_src_match[2:0]
       or is_inst03_src_match[2:0]
       or is_inst01_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq1_create1_sel[1:0])
    2'd0:   is_inst0_aiq1_create1_src_match[2:0] = 3'b0;
    2'd1:   is_inst0_aiq1_create1_src_match[2:0] = is_inst01_src_match[2:0];
    2'd2:   is_inst0_aiq1_create1_src_match[2:0] = is_inst02_src_match[2:0];
    2'd3:   is_inst0_aiq1_create1_src_match[2:0] = is_inst03_src_match[2:0];
    default:is_inst0_aiq1_create1_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @1726
end

assign is_inst0_lch_rdy_aiq1_create0[23:0] =
  {is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[7]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[6]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[5]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[4]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[3]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[2]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[1]}},
   is_inst0_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[0]}}};
assign is_inst0_lch_rdy_aiq1_create1[23:0] =
  {is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[7]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[6]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[5]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[4]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[3]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[2]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[1]}},
   is_inst0_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[0]}}};

assign is_inst0_lch_rdy_aiq1[23:0] =   is_inst0_lch_rdy_aiq1_create0[23:0]
                                     | is_inst0_lch_rdy_aiq1_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready BIQ
//----------------------------------------------------------
// &CombBeg; @1753
always @( ctrl_dp_is_dis_biq_create0_sel[1:0]
       or is_inst01_src_match[1:0]
       or is_inst03_src_match[1:0]
       or is_inst02_src_match[1:0])
begin
  case(ctrl_dp_is_dis_biq_create0_sel[1:0])
    2'd0:   is_inst0_biq_create0_src_match[1:0] = 2'b0;
    2'd1:   is_inst0_biq_create0_src_match[1:0] = is_inst01_src_match[1:0];
    2'd2:   is_inst0_biq_create0_src_match[1:0] = is_inst02_src_match[1:0];
    2'd3:   is_inst0_biq_create0_src_match[1:0] = is_inst03_src_match[1:0];
    default:is_inst0_biq_create0_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @1761
end

// &CombBeg; @1763
always @( ctrl_dp_is_dis_biq_create1_sel[1:0]
       or is_inst01_src_match[1:0]
       or is_inst03_src_match[1:0]
       or is_inst02_src_match[1:0])
begin
  case(ctrl_dp_is_dis_biq_create1_sel[1:0])
    2'd0:   is_inst0_biq_create1_src_match[1:0] = 2'b0;
    2'd1:   is_inst0_biq_create1_src_match[1:0] = is_inst01_src_match[1:0];
    2'd2:   is_inst0_biq_create1_src_match[1:0] = is_inst02_src_match[1:0];
    2'd3:   is_inst0_biq_create1_src_match[1:0] = is_inst03_src_match[1:0];
    default:is_inst0_biq_create1_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @1771
end

assign is_inst0_lch_rdy_biq_create0[23:0] =
  {is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[11]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[10]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[9]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[8]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[7]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[6]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[5]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[4]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[3]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[2]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[1]}},
   is_inst0_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[0]}}};
assign is_inst0_lch_rdy_biq_create1[23:0] =
  {is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[11]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[10]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[9]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[8]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[7]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[6]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[5]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[4]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[3]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[2]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[1]}},
   is_inst0_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[0]}}};

assign is_inst0_lch_rdy_biq[23:0] =   is_inst0_lch_rdy_biq_create0[23:0]
                                    | is_inst0_lch_rdy_biq_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready LSIQ
//----------------------------------------------------------
// &CombBeg; @1806
always @( is_inst01_src_match[1:0]
       or is_inst03_src_match[1:0]
       or is_inst02_src_match[1:0]
       or ctrl_dp_is_dis_lsiq_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_lsiq_create0_sel[1:0])
    2'd0:   is_inst0_lsiq_create0_src_match[1:0] = 2'b0;
    2'd1:   is_inst0_lsiq_create0_src_match[1:0] = is_inst01_src_match[1:0];
    2'd2:   is_inst0_lsiq_create0_src_match[1:0] = is_inst02_src_match[1:0];
    2'd3:   is_inst0_lsiq_create0_src_match[1:0] = is_inst03_src_match[1:0];
    default:is_inst0_lsiq_create0_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @1814
end

// &CombBeg; @1816
always @( is_inst01_src_match[1:0]
       or is_inst03_src_match[1:0]
       or is_inst02_src_match[1:0]
       or ctrl_dp_is_dis_lsiq_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_lsiq_create1_sel[1:0])
    2'd0:   is_inst0_lsiq_create1_src_match[1:0] = 2'b0;
    2'd1:   is_inst0_lsiq_create1_src_match[1:0] = is_inst01_src_match[1:0];
    2'd2:   is_inst0_lsiq_create1_src_match[1:0] = is_inst02_src_match[1:0];
    2'd3:   is_inst0_lsiq_create1_src_match[1:0] = is_inst03_src_match[1:0];
    default:is_inst0_lsiq_create1_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @1824
end

assign is_inst0_lch_rdy_lsiq_create0[23:0] =
  {is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[11]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[10]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[9]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[8]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[7]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[6]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[5]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[4]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[3]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[2]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[1]}},
   is_inst0_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[0]}}};
assign is_inst0_lch_rdy_lsiq_create1[23:0] =
  {is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[11]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[10]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[9]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[8]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[7]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[6]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[5]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[4]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[3]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[2]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[1]}},
   is_inst0_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[0]}}};

assign is_inst0_lch_rdy_lsiq[23:0] =  is_inst0_lch_rdy_lsiq_create0[23:0]
                                    | is_inst0_lch_rdy_lsiq_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready SDIQ
//----------------------------------------------------------
// &CombBeg; @1859
always @( is_inst03_src_match[2:1]
       or is_inst01_src_match[2:1]
       or is_inst02_src_match[2:1]
       or ctrl_dp_is_dis_sdiq_create0_sel[1:0]
       or dp_sdiq_create0_sti_sel)
begin
  case(ctrl_dp_is_dis_sdiq_create0_sel[1:0])
    2'd0:   is_inst0_sdiq_create0_src_match = 1'b0;
    2'd1:   is_inst0_sdiq_create0_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst01_src_match[1]
                                              : is_inst01_src_match[2];
    2'd2:   is_inst0_sdiq_create0_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst02_src_match[1]
                                              : is_inst02_src_match[2];
    2'd3:   is_inst0_sdiq_create0_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst03_src_match[1]
                                              : is_inst03_src_match[2];
    default:is_inst0_sdiq_create0_src_match = 1'bx;
  endcase
// &CombEnd; @1873
end

// &CombBeg; @1875
always @( is_inst03_src_match[2:1]
       or is_inst01_src_match[2:1]
       or is_inst02_src_match[2:1]
       or dp_sdiq_create0_sti_sel
       or dp_sdiq_create1_sti_sel
       or ctrl_dp_is_dis_sdiq_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_sdiq_create1_sel[1:0])
    2'd0:   is_inst0_sdiq_create1_src_match = 1'b0;
    2'd1:   is_inst0_sdiq_create1_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst01_src_match[1]
                                              : is_inst01_src_match[2];
    2'd2:   is_inst0_sdiq_create1_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst02_src_match[1]
                                              : is_inst02_src_match[2];
    2'd3:   is_inst0_sdiq_create1_src_match = dp_sdiq_create1_sti_sel
                                              ? is_inst03_src_match[1]
                                              : is_inst03_src_match[2];
    default:is_inst0_sdiq_create1_src_match = 1'bx;
  endcase
// &CombEnd; @1889
end

assign is_inst0_lch_rdy_sdiq_create0[11:0] =
  {is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[11],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[10],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[9],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[8],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[7],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[6],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[5],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[4],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[3],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[2],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[1],
   is_inst0_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[0]};
assign is_inst0_lch_rdy_sdiq_create1[11:0] =
  {is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[11],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[10],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[9],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[8],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[7],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[6],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[5],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[4],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[3],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[2],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[1],
   is_inst0_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[0]};

assign is_inst0_lch_rdy_sdiq[11:0] =  is_inst0_lch_rdy_sdiq_create0[11:0]
                                    | is_inst0_lch_rdy_sdiq_create1[11:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready VIQ0
//----------------------------------------------------------
// &CombBeg; @1924
always @( is_inst03_src_match[3]
       or is_inst02_src_match[3]
       or ctrl_dp_is_dis_viq0_create0_sel[1:0]
       or is_inst01_src_match[3])
begin
  case(ctrl_dp_is_dis_viq0_create0_sel[1:0])
    2'd0:   is_inst0_viq0_create0_src_match = 1'b0;
    2'd1:   is_inst0_viq0_create0_src_match = is_inst01_src_match[3];
    2'd2:   is_inst0_viq0_create0_src_match = is_inst02_src_match[3];
    2'd3:   is_inst0_viq0_create0_src_match = is_inst03_src_match[3];
    default:is_inst0_viq0_create0_src_match = 1'bx;
  endcase
// &CombEnd; @1932
end

// &CombBeg; @1934
always @( is_inst03_src_match[3]
       or is_inst02_src_match[3]
       or ctrl_dp_is_dis_viq0_create1_sel[1:0]
       or is_inst01_src_match[3])
begin
  case(ctrl_dp_is_dis_viq0_create1_sel[1:0])
    2'd0:   is_inst0_viq0_create1_src_match = 1'b0;
    2'd1:   is_inst0_viq0_create1_src_match = is_inst01_src_match[3];
    2'd2:   is_inst0_viq0_create1_src_match = is_inst02_src_match[3];
    2'd3:   is_inst0_viq0_create1_src_match = is_inst03_src_match[3];
    default:is_inst0_viq0_create1_src_match = 1'bx;
  endcase
// &CombEnd; @1942
end

assign is_inst0_lch_rdy_viq0_create0[7:0] =
  {is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[7],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[6],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[5],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[4],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[3],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[2],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[1],
   is_inst0_viq0_create0_src_match & ctrl_is_viq0_create0_entry[0]};
assign is_inst0_lch_rdy_viq0_create1[7:0] =
  {is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[7],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[6],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[5],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[4],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[3],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[2],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[1],
   is_inst0_viq0_create1_src_match & ctrl_is_viq0_create1_entry[0]};

assign is_inst0_lch_rdy_viq0[7:0] =  is_inst0_lch_rdy_viq0_create0[7:0]
                                   | is_inst0_lch_rdy_viq0_create1[7:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready VIQ1
//----------------------------------------------------------
// &CombBeg; @1969
always @( is_inst03_src_match[3]
       or is_inst02_src_match[3]
       or ctrl_dp_is_dis_viq1_create0_sel[1:0]
       or is_inst01_src_match[3])
begin
  case(ctrl_dp_is_dis_viq1_create0_sel[1:0])
    2'd0:   is_inst0_viq1_create0_src_match = 1'b0;
    2'd1:   is_inst0_viq1_create0_src_match = is_inst01_src_match[3];
    2'd2:   is_inst0_viq1_create0_src_match = is_inst02_src_match[3];
    2'd3:   is_inst0_viq1_create0_src_match = is_inst03_src_match[3];
    default:is_inst0_viq1_create0_src_match = 1'bx;
  endcase
// &CombEnd; @1977
end

// &CombBeg; @1979
always @( is_inst03_src_match[3]
       or is_inst02_src_match[3]
       or is_inst01_src_match[3]
       or ctrl_dp_is_dis_viq1_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq1_create1_sel[1:0])
    2'd0:   is_inst0_viq1_create1_src_match = 1'b0;
    2'd1:   is_inst0_viq1_create1_src_match = is_inst01_src_match[3];
    2'd2:   is_inst0_viq1_create1_src_match = is_inst02_src_match[3];
    2'd3:   is_inst0_viq1_create1_src_match = is_inst03_src_match[3];
    default:is_inst0_viq1_create1_src_match = 1'bx;
  endcase
// &CombEnd; @1987
end

assign is_inst0_lch_rdy_viq1_create0[7:0] =
  {is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[7],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[6],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[5],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[4],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[3],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[2],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[1],
   is_inst0_viq1_create0_src_match & ctrl_is_viq1_create0_entry[0]};
assign is_inst0_lch_rdy_viq1_create1[7:0] =
  {is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[7],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[6],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[5],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[4],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[3],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[2],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[1],
   is_inst0_viq1_create1_src_match & ctrl_is_viq1_create1_entry[0]};

assign is_inst0_lch_rdy_viq1[7:0] =  is_inst0_lch_rdy_viq1_create0[7:0]
                                   | is_inst0_lch_rdy_viq1_create1[7:0];

//----------------------------------------------------------
//         Dispatch Inst1 Create Launch Ready AIQ0
//----------------------------------------------------------
// &CombBeg; @2014
always @( ctrl_dp_is_dis_aiq0_create0_sel[1:0]
       or is_inst13_src_match[2:0]
       or is_inst12_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq0_create0_sel[1:0])
    2'd0:   is_inst1_aiq0_create0_src_match[2:0] = 3'b0;
    2'd1:   is_inst1_aiq0_create0_src_match[2:0] = 3'b0;
    2'd2:   is_inst1_aiq0_create0_src_match[2:0] = is_inst12_src_match[2:0];
    2'd3:   is_inst1_aiq0_create0_src_match[2:0] = is_inst13_src_match[2:0];
    default:is_inst1_aiq0_create0_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2022
end

// &CombBeg; @2024
always @( ctrl_dp_is_dis_aiq0_create1_sel[1:0]
       or is_inst13_src_match[2:0]
       or is_inst12_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq0_create1_sel[1:0])
    2'd0:   is_inst1_aiq0_create1_src_match[2:0] = 3'b0;
    2'd1:   is_inst1_aiq0_create1_src_match[2:0] = 3'b0;
    2'd2:   is_inst1_aiq0_create1_src_match[2:0] = is_inst12_src_match[2:0];
    2'd3:   is_inst1_aiq0_create1_src_match[2:0] = is_inst13_src_match[2:0];
    default:is_inst1_aiq0_create1_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2032
end

assign is_inst1_lch_rdy_aiq0_create0[23:0] =
  {is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[7]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[6]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[5]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[4]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[3]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[2]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[1]}},
   is_inst1_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[0]}}};
assign is_inst1_lch_rdy_aiq0_create1[23:0] =
  {is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[7]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[6]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[5]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[4]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[3]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[2]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[1]}},
   is_inst1_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[0]}}};

assign is_inst1_lch_rdy_aiq0[23:0] =   is_inst1_lch_rdy_aiq0_create0[23:0]
                                     | is_inst1_lch_rdy_aiq0_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst1 Create Launch Ready AIQ1
//----------------------------------------------------------
// &CombBeg; @2059
always @( ctrl_dp_is_dis_aiq1_create0_sel[1:0]
       or is_inst13_src_match[2:0]
       or is_inst12_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq1_create0_sel[1:0])
    2'd0:   is_inst1_aiq1_create0_src_match[2:0] = 3'b0;
    2'd1:   is_inst1_aiq1_create0_src_match[2:0] = 3'b0;
    2'd2:   is_inst1_aiq1_create0_src_match[2:0] = is_inst12_src_match[2:0];
    2'd3:   is_inst1_aiq1_create0_src_match[2:0] = is_inst13_src_match[2:0];
    default:is_inst1_aiq1_create0_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2067
end

// &CombBeg; @2069
always @( ctrl_dp_is_dis_aiq1_create1_sel[1:0]
       or is_inst13_src_match[2:0]
       or is_inst12_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq1_create1_sel[1:0])
    2'd0:   is_inst1_aiq1_create1_src_match[2:0] = 3'b0;
    2'd1:   is_inst1_aiq1_create1_src_match[2:0] = 3'b0;
    2'd2:   is_inst1_aiq1_create1_src_match[2:0] = is_inst12_src_match[2:0];
    2'd3:   is_inst1_aiq1_create1_src_match[2:0] = is_inst13_src_match[2:0];
    default:is_inst1_aiq1_create1_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2077
end

assign is_inst1_lch_rdy_aiq1_create0[23:0] =
  {is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[7]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[6]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[5]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[4]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[3]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[2]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[1]}},
   is_inst1_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[0]}}};
assign is_inst1_lch_rdy_aiq1_create1[23:0] =
  {is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[7]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[6]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[5]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[4]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[3]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[2]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[1]}},
   is_inst1_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[0]}}};

assign is_inst1_lch_rdy_aiq1[23:0] =   is_inst1_lch_rdy_aiq1_create0[23:0]
                                     | is_inst1_lch_rdy_aiq1_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst1 Create Launch Ready BIQ
//----------------------------------------------------------
// &CombBeg; @2104
always @( ctrl_dp_is_dis_biq_create0_sel[1:0]
       or is_inst12_src_match[1:0]
       or is_inst13_src_match[1:0])
begin
  case(ctrl_dp_is_dis_biq_create0_sel[1:0])
    2'd0:   is_inst1_biq_create0_src_match[1:0] = 2'b0;
    2'd1:   is_inst1_biq_create0_src_match[1:0] = 2'b0;
    2'd2:   is_inst1_biq_create0_src_match[1:0] = is_inst12_src_match[1:0];
    2'd3:   is_inst1_biq_create0_src_match[1:0] = is_inst13_src_match[1:0];
    default:is_inst1_biq_create0_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2112
end

// &CombBeg; @2114
always @( ctrl_dp_is_dis_biq_create1_sel[1:0]
       or is_inst12_src_match[1:0]
       or is_inst13_src_match[1:0])
begin
  case(ctrl_dp_is_dis_biq_create1_sel[1:0])
    2'd0:   is_inst1_biq_create1_src_match[1:0] = 2'b0;
    2'd1:   is_inst1_biq_create1_src_match[1:0] = 2'b0;
    2'd2:   is_inst1_biq_create1_src_match[1:0] = is_inst12_src_match[1:0];
    2'd3:   is_inst1_biq_create1_src_match[1:0] = is_inst13_src_match[1:0];
    default:is_inst1_biq_create1_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2122
end

assign is_inst1_lch_rdy_biq_create0[23:0] =
  {is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[11]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[10]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[9]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[8]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[7]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[6]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[5]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[4]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[3]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[2]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[1]}},
   is_inst1_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[0]}}};
assign is_inst1_lch_rdy_biq_create1[23:0] =
  {is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[11]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[10]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[9]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[8]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[7]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[6]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[5]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[4]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[3]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[2]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[1]}},
   is_inst1_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[0]}}};

assign is_inst1_lch_rdy_biq[23:0] =   is_inst1_lch_rdy_biq_create0[23:0]
                                    | is_inst1_lch_rdy_biq_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst1 Create Launch Ready LSIQ
//----------------------------------------------------------
// &CombBeg; @2157
always @( is_inst12_src_match[1:0]
       or ctrl_dp_is_dis_lsiq_create0_sel[1:0]
       or is_inst13_src_match[1:0])
begin
  case(ctrl_dp_is_dis_lsiq_create0_sel[1:0])
    2'd0:   is_inst1_lsiq_create0_src_match[1:0] = 2'b0;
    2'd1:   is_inst1_lsiq_create0_src_match[1:0] = 2'b0;
    2'd2:   is_inst1_lsiq_create0_src_match[1:0] = is_inst12_src_match[1:0];
    2'd3:   is_inst1_lsiq_create0_src_match[1:0] = is_inst13_src_match[1:0];
    default:is_inst1_lsiq_create0_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2165
end

// &CombBeg; @2167
always @( is_inst12_src_match[1:0]
       or is_inst13_src_match[1:0]
       or ctrl_dp_is_dis_lsiq_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_lsiq_create1_sel[1:0])
    2'd0:   is_inst1_lsiq_create1_src_match[1:0] = 2'b0;
    2'd1:   is_inst1_lsiq_create1_src_match[1:0] = 2'b0;
    2'd2:   is_inst1_lsiq_create1_src_match[1:0] = is_inst12_src_match[1:0];
    2'd3:   is_inst1_lsiq_create1_src_match[1:0] = is_inst13_src_match[1:0];
    default:is_inst1_lsiq_create1_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2175
end

assign is_inst1_lch_rdy_lsiq_create0[23:0] =
  {is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[11]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[10]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[9]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[8]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[7]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[6]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[5]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[4]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[3]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[2]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[1]}},
   is_inst1_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[0]}}};
assign is_inst1_lch_rdy_lsiq_create1[23:0] =
  {is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[11]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[10]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[9]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[8]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[7]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[6]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[5]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[4]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[3]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[2]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[1]}},
   is_inst1_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[0]}}};

assign is_inst1_lch_rdy_lsiq[23:0] =  is_inst1_lch_rdy_lsiq_create0[23:0]
                                    | is_inst1_lch_rdy_lsiq_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst1 Create Launch Ready SDIQ
//----------------------------------------------------------
// &CombBeg; @2210
always @( is_inst12_src_match[2:1]
       or is_inst13_src_match[2:1]
       or ctrl_dp_is_dis_sdiq_create0_sel[1:0]
       or dp_sdiq_create0_sti_sel)
begin
  case(ctrl_dp_is_dis_sdiq_create0_sel[1:0])
    2'd0:   is_inst1_sdiq_create0_src_match = 1'b0;
    2'd1:   is_inst1_sdiq_create0_src_match = 1'b0;
    2'd2:   is_inst1_sdiq_create0_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst12_src_match[1]
                                              : is_inst12_src_match[2];
    2'd3:   is_inst1_sdiq_create0_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst13_src_match[1]
                                              : is_inst13_src_match[2];
    default:is_inst1_sdiq_create0_src_match = 1'bx;
  endcase
// &CombEnd; @2222
end

// &CombBeg; @2224
always @( is_inst12_src_match[2:1]
       or is_inst13_src_match[2:1]
       or dp_sdiq_create0_sti_sel
       or dp_sdiq_create1_sti_sel
       or ctrl_dp_is_dis_sdiq_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_sdiq_create1_sel[1:0])
    2'd0:   is_inst1_sdiq_create1_src_match = 1'b0;
    2'd1:   is_inst1_sdiq_create1_src_match = 1'b0;
    2'd2:   is_inst1_sdiq_create1_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst12_src_match[1]
                                              : is_inst12_src_match[2];
    2'd3:   is_inst1_sdiq_create1_src_match = dp_sdiq_create1_sti_sel
                                              ? is_inst13_src_match[1]
                                              : is_inst13_src_match[2];
    default:is_inst1_sdiq_create1_src_match = 1'bx;
  endcase
// &CombEnd; @2236
end

assign is_inst1_lch_rdy_sdiq_create0[11:0] =
  {is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[11],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[10],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[9],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[8],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[7],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[6],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[5],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[4],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[3],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[2],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[1],
   is_inst1_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[0]};
assign is_inst1_lch_rdy_sdiq_create1[11:0] =
  {is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[11],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[10],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[9],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[8],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[7],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[6],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[5],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[4],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[3],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[2],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[1],
   is_inst1_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[0]};

assign is_inst1_lch_rdy_sdiq[11:0] =  is_inst1_lch_rdy_sdiq_create0[11:0]
                                    | is_inst1_lch_rdy_sdiq_create1[11:0];


//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready VIQ0
//----------------------------------------------------------
// &CombBeg; @2272
always @( is_inst12_src_match[3]
       or is_inst13_src_match[3]
       or ctrl_dp_is_dis_viq0_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq0_create0_sel[1:0])
    2'd0:   is_inst1_viq0_create0_src_match = 1'b0;
    2'd1:   is_inst1_viq0_create0_src_match = 1'b0;
    2'd2:   is_inst1_viq0_create0_src_match = is_inst12_src_match[3];
    2'd3:   is_inst1_viq0_create0_src_match = is_inst13_src_match[3];
    default:is_inst1_viq0_create0_src_match = 1'bx;
  endcase
// &CombEnd; @2280
end

// &CombBeg; @2282
always @( is_inst12_src_match[3]
       or is_inst13_src_match[3]
       or ctrl_dp_is_dis_viq0_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq0_create1_sel[1:0])
    2'd0:   is_inst1_viq0_create1_src_match = 1'b0;
    2'd1:   is_inst1_viq0_create1_src_match = 1'b0;
    2'd2:   is_inst1_viq0_create1_src_match = is_inst12_src_match[3];
    2'd3:   is_inst1_viq0_create1_src_match = is_inst13_src_match[3];
    default:is_inst1_viq0_create1_src_match = 1'bx;
  endcase
// &CombEnd; @2290
end

assign is_inst1_lch_rdy_viq0_create0[7:0] =
  {is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[7],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[6],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[5],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[4],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[3],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[2],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[1],
   is_inst1_viq0_create0_src_match & ctrl_is_viq0_create0_entry[0]};
assign is_inst1_lch_rdy_viq0_create1[7:0] =
  {is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[7],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[6],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[5],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[4],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[3],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[2],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[1],
   is_inst1_viq0_create1_src_match & ctrl_is_viq0_create1_entry[0]};

assign is_inst1_lch_rdy_viq0[7:0] =  is_inst1_lch_rdy_viq0_create0[7:0]
                                   | is_inst1_lch_rdy_viq0_create1[7:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready VIQ1
//----------------------------------------------------------
// &CombBeg; @2317
always @( is_inst12_src_match[3]
       or is_inst13_src_match[3]
       or ctrl_dp_is_dis_viq1_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq1_create0_sel[1:0])
    2'd0:   is_inst1_viq1_create0_src_match = 1'b0;
    2'd1:   is_inst1_viq1_create0_src_match = 1'b0;
    2'd2:   is_inst1_viq1_create0_src_match = is_inst12_src_match[3];
    2'd3:   is_inst1_viq1_create0_src_match = is_inst13_src_match[3];
    default:is_inst1_viq1_create0_src_match = 1'bx;
  endcase
// &CombEnd; @2325
end

// &CombBeg; @2327
always @( is_inst12_src_match[3]
       or is_inst13_src_match[3]
       or ctrl_dp_is_dis_viq1_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq1_create1_sel[1:0])
    2'd0:   is_inst1_viq1_create1_src_match = 1'b0;
    2'd1:   is_inst1_viq1_create1_src_match = 1'b0;
    2'd2:   is_inst1_viq1_create1_src_match = is_inst12_src_match[3];
    2'd3:   is_inst1_viq1_create1_src_match = is_inst13_src_match[3];
    default:is_inst1_viq1_create1_src_match = 1'bx;
  endcase
// &CombEnd; @2335
end

assign is_inst1_lch_rdy_viq1_create0[7:0] =
  {is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[7],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[6],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[5],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[4],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[3],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[2],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[1],
   is_inst1_viq1_create0_src_match & ctrl_is_viq1_create0_entry[0]};
assign is_inst1_lch_rdy_viq1_create1[7:0] =
  {is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[7],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[6],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[5],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[4],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[3],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[2],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[1],
   is_inst1_viq1_create1_src_match & ctrl_is_viq1_create1_entry[0]};

assign is_inst1_lch_rdy_viq1[7:0] =  is_inst1_lch_rdy_viq1_create0[7:0]
                                   | is_inst1_lch_rdy_viq1_create1[7:0];

//----------------------------------------------------------
//         Dispatch Inst2 Create Launch Ready AIQ0
//----------------------------------------------------------
// &CombBeg; @2362
always @( is_inst23_src_match[2:0]
       or ctrl_dp_is_dis_aiq0_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_aiq0_create0_sel[1:0])
    2'd0:   is_inst2_aiq0_create0_src_match[2:0] = 3'b0;
    2'd1:   is_inst2_aiq0_create0_src_match[2:0] = 3'b0;
    2'd2:   is_inst2_aiq0_create0_src_match[2:0] = 3'b0;
    2'd3:   is_inst2_aiq0_create0_src_match[2:0] = is_inst23_src_match[2:0];
    default:is_inst2_aiq0_create0_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2370
end

// &CombBeg; @2372
always @( is_inst23_src_match[2:0]
       or ctrl_dp_is_dis_aiq0_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_aiq0_create1_sel[1:0])
    2'd0:   is_inst2_aiq0_create1_src_match[2:0] = 3'b0;
    2'd1:   is_inst2_aiq0_create1_src_match[2:0] = 3'b0;
    2'd2:   is_inst2_aiq0_create1_src_match[2:0] = 3'b0;
    2'd3:   is_inst2_aiq0_create1_src_match[2:0] = is_inst23_src_match[2:0];
    default:is_inst2_aiq0_create1_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2380
end

assign is_inst2_lch_rdy_aiq0_create0[23:0] =
  {is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[7]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[6]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[5]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[4]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[3]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[2]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[1]}},
   is_inst2_aiq0_create0_src_match[2:0] & {3{ctrl_is_aiq0_create0_entry[0]}}};
assign is_inst2_lch_rdy_aiq0_create1[23:0] =
  {is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[7]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[6]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[5]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[4]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[3]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[2]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[1]}},
   is_inst2_aiq0_create1_src_match[2:0] & {3{ctrl_is_aiq0_create1_entry[0]}}};

assign is_inst2_lch_rdy_aiq0[23:0] =   is_inst2_lch_rdy_aiq0_create0[23:0]
                                     | is_inst2_lch_rdy_aiq0_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst2 Create Launch Ready AIQ1
//----------------------------------------------------------
// &CombBeg; @2407
always @( is_inst23_src_match[2:0]
       or ctrl_dp_is_dis_aiq1_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_aiq1_create0_sel[1:0])
    2'd0:   is_inst2_aiq1_create0_src_match[2:0] = 3'b0;
    2'd1:   is_inst2_aiq1_create0_src_match[2:0] = 3'b0;
    2'd2:   is_inst2_aiq1_create0_src_match[2:0] = 3'b0;
    2'd3:   is_inst2_aiq1_create0_src_match[2:0] = is_inst23_src_match[2:0];
    default:is_inst2_aiq1_create0_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2415
end

// &CombBeg; @2417
always @( ctrl_dp_is_dis_aiq1_create1_sel[1:0]
       or is_inst23_src_match[2:0])
begin
  case(ctrl_dp_is_dis_aiq1_create1_sel[1:0])
    2'd0:   is_inst2_aiq1_create1_src_match[2:0] = 3'b0;
    2'd1:   is_inst2_aiq1_create1_src_match[2:0] = 3'b0;
    2'd2:   is_inst2_aiq1_create1_src_match[2:0] = 3'b0;
    2'd3:   is_inst2_aiq1_create1_src_match[2:0] = is_inst23_src_match[2:0];
    default:is_inst2_aiq1_create1_src_match[2:0] = {3{1'bx}};
  endcase
// &CombEnd; @2425
end

assign is_inst2_lch_rdy_aiq1_create0[23:0] =
  {is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[7]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[6]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[5]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[4]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[3]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[2]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[1]}},
   is_inst2_aiq1_create0_src_match[2:0] & {3{ctrl_is_aiq1_create0_entry[0]}}};
assign is_inst2_lch_rdy_aiq1_create1[23:0] =
  {is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[7]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[6]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[5]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[4]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[3]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[2]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[1]}},
   is_inst2_aiq1_create1_src_match[2:0] & {3{ctrl_is_aiq1_create1_entry[0]}}};

assign is_inst2_lch_rdy_aiq1[23:0] =   is_inst2_lch_rdy_aiq1_create0[23:0]
                                     | is_inst2_lch_rdy_aiq1_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst2 Create Launch Ready BIQ
//----------------------------------------------------------
// &CombBeg; @2452
always @( ctrl_dp_is_dis_biq_create0_sel[1:0]
       or is_inst23_src_match[1:0])
begin
  case(ctrl_dp_is_dis_biq_create0_sel[1:0])
    2'd0:   is_inst2_biq_create0_src_match[1:0] = 2'b0;
    2'd1:   is_inst2_biq_create0_src_match[1:0] = 2'b0;
    2'd2:   is_inst2_biq_create0_src_match[1:0] = 2'b0;
    2'd3:   is_inst2_biq_create0_src_match[1:0] = is_inst23_src_match[1:0];
    default:is_inst2_biq_create0_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2460
end

// &CombBeg; @2462
always @( ctrl_dp_is_dis_biq_create1_sel[1:0]
       or is_inst23_src_match[1:0])
begin
  case(ctrl_dp_is_dis_biq_create1_sel[1:0])
    2'd0:   is_inst2_biq_create1_src_match[1:0] = 2'b0;
    2'd1:   is_inst2_biq_create1_src_match[1:0] = 2'b0;
    2'd2:   is_inst2_biq_create1_src_match[1:0] = 2'b0;
    2'd3:   is_inst2_biq_create1_src_match[1:0] = is_inst23_src_match[1:0];
    default:is_inst2_biq_create1_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2470
end

assign is_inst2_lch_rdy_biq_create0[23:0] =
  {is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[11]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[10]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[9]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[8]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[7]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[6]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[5]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[4]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[3]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[2]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[1]}},
   is_inst2_biq_create0_src_match[1:0] & {2{ctrl_is_biq_create0_entry[0]}}};
assign is_inst2_lch_rdy_biq_create1[23:0] =
  {is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[11]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[10]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[9]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[8]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[7]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[6]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[5]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[4]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[3]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[2]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[1]}},
   is_inst2_biq_create1_src_match[1:0] & {2{ctrl_is_biq_create1_entry[0]}}};

assign is_inst2_lch_rdy_biq[23:0] =   is_inst2_lch_rdy_biq_create0[23:0]
                                    | is_inst2_lch_rdy_biq_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst2 Create Launch Ready LSIQ
//----------------------------------------------------------
// &CombBeg; @2505
always @( ctrl_dp_is_dis_lsiq_create0_sel[1:0]
       or is_inst23_src_match[1:0])
begin
  case(ctrl_dp_is_dis_lsiq_create0_sel[1:0])
    2'd0:   is_inst2_lsiq_create0_src_match[1:0] = 2'b0;
    2'd1:   is_inst2_lsiq_create0_src_match[1:0] = 2'b0;
    2'd2:   is_inst2_lsiq_create0_src_match[1:0] = 2'b0;
    2'd3:   is_inst2_lsiq_create0_src_match[1:0] = is_inst23_src_match[1:0];
    default:is_inst2_lsiq_create0_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2513
end

// &CombBeg; @2515
always @( is_inst23_src_match[1:0]
       or ctrl_dp_is_dis_lsiq_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_lsiq_create1_sel[1:0])
    2'd0:   is_inst2_lsiq_create1_src_match[1:0] = 2'b0;
    2'd1:   is_inst2_lsiq_create1_src_match[1:0] = 2'b0;
    2'd2:   is_inst2_lsiq_create1_src_match[1:0] = 2'b0;
    2'd3:   is_inst2_lsiq_create1_src_match[1:0] = is_inst23_src_match[1:0];
    default:is_inst2_lsiq_create1_src_match[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @2523
end

assign is_inst2_lch_rdy_lsiq_create0[23:0] =
  {is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[11]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[10]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[9]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[8]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[7]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[6]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[5]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[4]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[3]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[2]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[1]}},
   is_inst2_lsiq_create0_src_match[1:0] & {2{ctrl_is_lsiq_create0_entry[0]}}};
assign is_inst2_lch_rdy_lsiq_create1[23:0] =
  {is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[11]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[10]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[9]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[8]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[7]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[6]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[5]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[4]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[3]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[2]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[1]}},
   is_inst2_lsiq_create1_src_match[1:0] & {2{ctrl_is_lsiq_create1_entry[0]}}};

assign is_inst2_lch_rdy_lsiq[23:0] =  is_inst2_lch_rdy_lsiq_create0[23:0]
                                    | is_inst2_lch_rdy_lsiq_create1[23:0];

//----------------------------------------------------------
//         Dispatch Inst2 Create Launch Ready SDIQ
//----------------------------------------------------------
// &CombBeg; @2558
always @( ctrl_dp_is_dis_sdiq_create0_sel[1:0]
       or is_inst23_src_match[2:1]
       or dp_sdiq_create0_sti_sel)
begin
  case(ctrl_dp_is_dis_sdiq_create0_sel[1:0])
    2'd0:   is_inst2_sdiq_create0_src_match = 1'b0;
    2'd1:   is_inst2_sdiq_create0_src_match = 1'b0;
    2'd2:   is_inst2_sdiq_create0_src_match = 1'b0;
    2'd3:   is_inst2_sdiq_create0_src_match = dp_sdiq_create0_sti_sel
                                              ? is_inst23_src_match[1]
                                              : is_inst23_src_match[2];
    default:is_inst2_sdiq_create0_src_match = 1'bx;
  endcase
// &CombEnd; @2568
end

// &CombBeg; @2570
always @( is_inst23_src_match[2:1]
       or dp_sdiq_create1_sti_sel
       or ctrl_dp_is_dis_sdiq_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_sdiq_create1_sel[1:0])
    2'd0:   is_inst2_sdiq_create1_src_match = 1'b0;
    2'd1:   is_inst2_sdiq_create1_src_match = 1'b0;
    2'd2:   is_inst2_sdiq_create1_src_match = 1'b0;
    2'd3:   is_inst2_sdiq_create1_src_match = dp_sdiq_create1_sti_sel
                                              ? is_inst23_src_match[1]
                                              : is_inst23_src_match[2];
    default:is_inst2_sdiq_create1_src_match = 1'bx;
  endcase
// &CombEnd; @2580
end

assign is_inst2_lch_rdy_sdiq_create0[11:0] =
  {is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[11],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[10],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[9],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[8],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[7],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[6],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[5],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[4],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[3],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[2],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[1],
   is_inst2_sdiq_create0_src_match & ctrl_is_sdiq_create0_entry[0]};
assign is_inst2_lch_rdy_sdiq_create1[11:0] =
  {is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[11],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[10],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[9],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[8],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[7],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[6],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[5],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[4],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[3],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[2],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[1],
   is_inst2_sdiq_create1_src_match & ctrl_is_sdiq_create1_entry[0]};

assign is_inst2_lch_rdy_sdiq[11:0] =  is_inst2_lch_rdy_sdiq_create0[11:0]
                                    | is_inst2_lch_rdy_sdiq_create1[11:0];


//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready VIQ0
//----------------------------------------------------------
// &CombBeg; @2616
always @( is_inst23_src_match[3]
       or ctrl_dp_is_dis_viq0_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq0_create0_sel[1:0])
    2'd0:   is_inst2_viq0_create0_src_match = 1'b0;
    2'd1:   is_inst2_viq0_create0_src_match = 1'b0;
    2'd2:   is_inst2_viq0_create0_src_match = 1'b0;
    2'd3:   is_inst2_viq0_create0_src_match = is_inst23_src_match[3];
    default:is_inst2_viq0_create0_src_match = 1'bx;
  endcase
// &CombEnd; @2624
end

// &CombBeg; @2626
always @( is_inst23_src_match[3]
       or ctrl_dp_is_dis_viq0_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq0_create1_sel[1:0])
    2'd0:   is_inst2_viq0_create1_src_match = 1'b0;
    2'd1:   is_inst2_viq0_create1_src_match = 1'b0;
    2'd2:   is_inst2_viq0_create1_src_match = 1'b0;
    2'd3:   is_inst2_viq0_create1_src_match = is_inst23_src_match[3];
    default:is_inst2_viq0_create1_src_match = 1'bx;
  endcase
// &CombEnd; @2634
end

assign is_inst2_lch_rdy_viq0_create0[7:0] =
  {is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[7],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[6],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[5],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[4],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[3],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[2],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[1],
   is_inst2_viq0_create0_src_match & ctrl_is_viq0_create0_entry[0]};
assign is_inst2_lch_rdy_viq0_create1[7:0] =
  {is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[7],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[6],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[5],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[4],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[3],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[2],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[1],
   is_inst2_viq0_create1_src_match & ctrl_is_viq0_create1_entry[0]};

assign is_inst2_lch_rdy_viq0[7:0] =  is_inst2_lch_rdy_viq0_create0[7:0]
                                   | is_inst2_lch_rdy_viq0_create1[7:0];

//----------------------------------------------------------
//         Dispatch Inst0 Create Launch Ready VIQ1
//----------------------------------------------------------
// &CombBeg; @2661
always @( is_inst23_src_match[3]
       or ctrl_dp_is_dis_viq1_create0_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq1_create0_sel[1:0])
    2'd0:   is_inst2_viq1_create0_src_match = 1'b0;
    2'd1:   is_inst2_viq1_create0_src_match = 1'b0;
    2'd2:   is_inst2_viq1_create0_src_match = 1'b0;
    2'd3:   is_inst2_viq1_create0_src_match = is_inst23_src_match[3];
    default:is_inst2_viq1_create0_src_match = 1'bx;
  endcase
// &CombEnd; @2669
end

// &CombBeg; @2671
always @( is_inst23_src_match[3]
       or ctrl_dp_is_dis_viq1_create1_sel[1:0])
begin
  case(ctrl_dp_is_dis_viq1_create1_sel[1:0])
    2'd0:   is_inst2_viq1_create1_src_match = 1'b0;
    2'd1:   is_inst2_viq1_create1_src_match = 1'b0;
    2'd2:   is_inst2_viq1_create1_src_match = 1'b0;
    2'd3:   is_inst2_viq1_create1_src_match = is_inst23_src_match[3];
    default:is_inst2_viq1_create1_src_match = 1'bx;
  endcase
// &CombEnd; @2679
end

assign is_inst2_lch_rdy_viq1_create0[7:0] =
  {is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[7],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[6],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[5],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[4],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[3],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[2],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[1],
   is_inst2_viq1_create0_src_match & ctrl_is_viq1_create0_entry[0]};
assign is_inst2_lch_rdy_viq1_create1[7:0] =
  {is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[7],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[6],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[5],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[4],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[3],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[2],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[1],
   is_inst2_viq1_create1_src_match & ctrl_is_viq1_create1_entry[0]};

assign is_inst2_lch_rdy_viq1[7:0] =  is_inst2_lch_rdy_viq1_create0[7:0]
                                   | is_inst2_lch_rdy_viq1_create1[7:0];

//----------------------------------------------------------
//            Dispatch Inst3 Create Launch Ready
//----------------------------------------------------------
assign is_inst3_lch_rdy_aiq0[23:0] = 24'b0;
assign is_inst3_lch_rdy_aiq1[23:0] = 24'b0;
assign is_inst3_lch_rdy_biq[23:0]  = 24'b0;
assign is_inst3_lch_rdy_lsiq[23:0] = 24'b0;
assign is_inst3_lch_rdy_sdiq[11:0] = 12'b0;
assign is_inst3_lch_rdy_viq0[7:0]  = 8'b0;
assign is_inst3_lch_rdy_viq1[7:0]  = 8'b0;

//==========================================================
//               Create Data for Issue Queue
//==========================================================
//----------------------------------------------------------
//                  Create Data for AIQ0
//----------------------------------------------------------
// &CombBeg; @2720
always @( is_inst2_pid[4:0]
       or is_inst2_lch_rdy_aiq0[23:0]
       or is_inst2_lch_rdy_sdiq[11:0]
       or is_inst0_lch_rdy_sdiq[11:0]
       or is_inst3_lch_rdy_aiq0[23:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_lch_rdy_aiq0[23:0]
       or is_inst0_lch_rdy_biq[23:0]
       or is_inst1_pid[4:0]
       or is_inst0_lch_rdy_aiq1[23:0]
       or is_inst0_lch_rdy_aiq0[23:0]
       or is_inst1_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_lsiq[23:0]
       or is_inst1_iid[6:0]
       or is_inst3_lch_rdy_biq[23:0]
       or is_inst0_lch_rdy_lsiq[23:0]
       or is_inst1_read_data[270:0]
       or is_inst3_lch_rdy_sdiq[11:0]
       or is_inst1_lch_rdy_lsiq[23:0]
       or is_inst3_lch_rdy_lsiq[23:0]
       or is_inst1_lch_rdy_aiq1[23:0]
       or is_inst3_lch_rdy_aiq1[23:0]
       or ctrl_dp_is_dis_aiq0_create0_sel[1:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst2_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_aiq1[23:0]
       or is_inst3_pid[4:0]
       or is_inst0_pid[4:0]
       or is_inst2_iid[6:0]
       or is_inst1_lch_rdy_sdiq[11:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_aiq0_create0_sel[1:0])
    2'd0: begin
          is_aiq0_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_aiq0_create0_iid[6:0]           = is_inst0_iid[6:0];
          is_aiq0_create0_pid[4:0]           = is_inst0_pid[4:0];
          is_aiq0_create0_lch_rdy_aiq0[23:0] = is_inst0_lch_rdy_aiq0[23:0];
          is_aiq0_create0_lch_rdy_aiq1[23:0] = is_inst0_lch_rdy_aiq1[23:0];
          is_aiq0_create0_lch_rdy_biq[23:0]  = is_inst0_lch_rdy_biq[23:0];
          is_aiq0_create0_lch_rdy_lsiq[23:0] = is_inst0_lch_rdy_lsiq[23:0];
          is_aiq0_create0_lch_rdy_sdiq[11:0] = is_inst0_lch_rdy_sdiq[11:0];
          end
    2'd1: begin
          is_aiq0_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_aiq0_create0_iid[6:0]           = is_inst1_iid[6:0];
          is_aiq0_create0_pid[4:0]           = is_inst1_pid[4:0];
          is_aiq0_create0_lch_rdy_aiq0[23:0] = is_inst1_lch_rdy_aiq0[23:0];
          is_aiq0_create0_lch_rdy_aiq1[23:0] = is_inst1_lch_rdy_aiq1[23:0];
          is_aiq0_create0_lch_rdy_biq[23:0]  = is_inst1_lch_rdy_biq[23:0];
          is_aiq0_create0_lch_rdy_lsiq[23:0] = is_inst1_lch_rdy_lsiq[23:0];
          is_aiq0_create0_lch_rdy_sdiq[11:0] = is_inst1_lch_rdy_sdiq[11:0];
          end
    2'd2: begin
          is_aiq0_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_aiq0_create0_iid[6:0]           = is_inst2_iid[6:0];
          is_aiq0_create0_pid[4:0]           = is_inst2_pid[4:0];
          is_aiq0_create0_lch_rdy_aiq0[23:0] = is_inst2_lch_rdy_aiq0[23:0];
          is_aiq0_create0_lch_rdy_aiq1[23:0] = is_inst2_lch_rdy_aiq1[23:0];
          is_aiq0_create0_lch_rdy_biq[23:0]  = is_inst2_lch_rdy_biq[23:0];
          is_aiq0_create0_lch_rdy_lsiq[23:0] = is_inst2_lch_rdy_lsiq[23:0];
          is_aiq0_create0_lch_rdy_sdiq[11:0] = is_inst2_lch_rdy_sdiq[11:0];
          end
    2'd3: begin
          is_aiq0_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_aiq0_create0_iid[6:0]           = is_inst3_iid[6:0];
          is_aiq0_create0_pid[4:0]           = is_inst3_pid[4:0];
          is_aiq0_create0_lch_rdy_aiq0[23:0] = is_inst3_lch_rdy_aiq0[23:0];
          is_aiq0_create0_lch_rdy_aiq1[23:0] = is_inst3_lch_rdy_aiq1[23:0];
          is_aiq0_create0_lch_rdy_biq[23:0]  = is_inst3_lch_rdy_biq[23:0];
          is_aiq0_create0_lch_rdy_lsiq[23:0] = is_inst3_lch_rdy_lsiq[23:0];
          is_aiq0_create0_lch_rdy_sdiq[11:0] = is_inst3_lch_rdy_sdiq[11:0];
          end
    default: begin
          is_aiq0_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_aiq0_create0_iid[6:0]           = {7{1'bx}};
          is_aiq0_create0_pid[4:0]           = {5{1'bx}};
          is_aiq0_create0_lch_rdy_aiq0[23:0] = {24{1'bx}};
          is_aiq0_create0_lch_rdy_aiq1[23:0] = {24{1'bx}};
          is_aiq0_create0_lch_rdy_biq[23:0]  = {24{1'bx}};
          is_aiq0_create0_lch_rdy_lsiq[23:0] = {24{1'bx}};
          is_aiq0_create0_lch_rdy_sdiq[11:0] = {12{1'bx}};
          end
  endcase
// &CombEnd; @2773
end

// &CombBeg; @2775
always @( is_inst2_pid[4:0]
       or is_inst2_lch_rdy_aiq0[23:0]
       or is_inst2_lch_rdy_sdiq[11:0]
       or is_inst0_lch_rdy_sdiq[11:0]
       or is_inst3_lch_rdy_aiq0[23:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_lch_rdy_aiq0[23:0]
       or is_inst0_lch_rdy_biq[23:0]
       or is_inst1_pid[4:0]
       or is_inst0_lch_rdy_aiq1[23:0]
       or is_inst0_lch_rdy_aiq0[23:0]
       or is_inst1_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_lsiq[23:0]
       or is_inst1_iid[6:0]
       or is_inst3_lch_rdy_biq[23:0]
       or is_inst0_lch_rdy_lsiq[23:0]
       or is_inst1_read_data[270:0]
       or is_inst3_lch_rdy_sdiq[11:0]
       or ctrl_dp_is_dis_aiq0_create1_sel[1:0]
       or is_inst1_lch_rdy_lsiq[23:0]
       or is_inst3_lch_rdy_lsiq[23:0]
       or is_inst1_lch_rdy_aiq1[23:0]
       or is_inst3_lch_rdy_aiq1[23:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst2_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_aiq1[23:0]
       or is_inst3_pid[4:0]
       or is_inst0_pid[4:0]
       or is_inst2_iid[6:0]
       or is_inst1_lch_rdy_sdiq[11:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_aiq0_create1_sel[1:0])
    2'd0: begin
          is_aiq0_create1_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_aiq0_create1_iid[6:0]           = is_inst0_iid[6:0];
          is_aiq0_create1_pid[4:0]           = is_inst0_pid[4:0];
          is_aiq0_create1_lch_rdy_aiq0[23:0] = is_inst0_lch_rdy_aiq0[23:0];
          is_aiq0_create1_lch_rdy_aiq1[23:0] = is_inst0_lch_rdy_aiq1[23:0];
          is_aiq0_create1_lch_rdy_biq[23:0]  = is_inst0_lch_rdy_biq[23:0];
          is_aiq0_create1_lch_rdy_lsiq[23:0] = is_inst0_lch_rdy_lsiq[23:0];
          is_aiq0_create1_lch_rdy_sdiq[11:0] = is_inst0_lch_rdy_sdiq[11:0];
          end
    2'd1: begin
          is_aiq0_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_aiq0_create1_iid[6:0]           = is_inst1_iid[6:0];
          is_aiq0_create1_pid[4:0]           = is_inst1_pid[4:0];
          is_aiq0_create1_lch_rdy_aiq0[23:0] = is_inst1_lch_rdy_aiq0[23:0];
          is_aiq0_create1_lch_rdy_aiq1[23:0] = is_inst1_lch_rdy_aiq1[23:0];
          is_aiq0_create1_lch_rdy_biq[23:0]  = is_inst1_lch_rdy_biq[23:0];
          is_aiq0_create1_lch_rdy_lsiq[23:0] = is_inst1_lch_rdy_lsiq[23:0];
          is_aiq0_create1_lch_rdy_sdiq[11:0] = is_inst1_lch_rdy_sdiq[11:0];
          end
    2'd2: begin
          is_aiq0_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_aiq0_create1_iid[6:0]           = is_inst2_iid[6:0];
          is_aiq0_create1_pid[4:0]           = is_inst2_pid[4:0];
          is_aiq0_create1_lch_rdy_aiq0[23:0] = is_inst2_lch_rdy_aiq0[23:0];
          is_aiq0_create1_lch_rdy_aiq1[23:0] = is_inst2_lch_rdy_aiq1[23:0];
          is_aiq0_create1_lch_rdy_biq[23:0]  = is_inst2_lch_rdy_biq[23:0];
          is_aiq0_create1_lch_rdy_lsiq[23:0] = is_inst2_lch_rdy_lsiq[23:0];
          is_aiq0_create1_lch_rdy_sdiq[11:0] = is_inst2_lch_rdy_sdiq[11:0];
          end
    2'd3: begin
          is_aiq0_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_aiq0_create1_iid[6:0]           = is_inst3_iid[6:0];
          is_aiq0_create1_pid[4:0]           = is_inst3_pid[4:0];
          is_aiq0_create1_lch_rdy_aiq0[23:0] = is_inst3_lch_rdy_aiq0[23:0];
          is_aiq0_create1_lch_rdy_aiq1[23:0] = is_inst3_lch_rdy_aiq1[23:0];
          is_aiq0_create1_lch_rdy_biq[23:0]  = is_inst3_lch_rdy_biq[23:0];
          is_aiq0_create1_lch_rdy_lsiq[23:0] = is_inst3_lch_rdy_lsiq[23:0];
          is_aiq0_create1_lch_rdy_sdiq[11:0] = is_inst3_lch_rdy_sdiq[11:0];
          end
    default: begin
          is_aiq0_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_aiq0_create1_iid[6:0]           = {7{1'bx}};
          is_aiq0_create1_pid[4:0]           = {5{1'bx}};
          is_aiq0_create1_lch_rdy_aiq0[23:0] = {24{1'bx}};
          is_aiq0_create1_lch_rdy_aiq1[23:0] = {24{1'bx}};
          is_aiq0_create1_lch_rdy_biq[23:0]  = {24{1'bx}};
          is_aiq0_create1_lch_rdy_lsiq[23:0] = {24{1'bx}};
          is_aiq0_create1_lch_rdy_sdiq[11:0] = {12{1'bx}};
          end
  endcase
// &CombEnd; @2828
end

//----------------------------------------------------------
//                Reorganize for AIQ0 create
//----------------------------------------------------------
//operand mux for iq create
assign dp_aiq0_create0_data[AIQ0_WIDTH-1:0] = {AIQ0_WIDTH{ctrl_aiq0_create0_gateclk_en}}
                                              & aiq0_create0_data[AIQ0_WIDTH-1:0];

assign aiq0_create0_data[AIQ0_VL:AIQ0_VL-7]                      = is_aiq0_create0_data[IS_VL:IS_VL-7];
assign aiq0_create0_data[AIQ0_LCH_PREG]                          = is_aiq0_create0_data[IS_LCH_PREG];
assign aiq0_create0_data[AIQ0_SPECIAL]                           = is_aiq0_create0_data[IS_SPECIAL];
assign aiq0_create0_data[AIQ0_VSEW:AIQ0_VSEW-2]                  = is_aiq0_create0_data[IS_VSEW:IS_VSEW-2];
assign aiq0_create0_data[AIQ0_VLMUL:AIQ0_VLMUL-1]                = is_aiq0_create0_data[IS_VLMUL:IS_VLMUL-1];
assign aiq0_create0_data[AIQ0_DIV]                               = is_aiq0_create0_data[IS_DIV];
assign aiq0_create0_data[AIQ0_LCH_RDY_SDIQ:AIQ0_LCH_RDY_SDIQ-11] = is_aiq0_create0_lch_rdy_sdiq[11:0];
assign aiq0_create0_data[AIQ0_LCH_RDY_LSIQ:AIQ0_LCH_RDY_LSIQ-23] = is_aiq0_create0_lch_rdy_lsiq[23:0];
assign aiq0_create0_data[AIQ0_LCH_RDY_BIQ:AIQ0_LCH_RDY_BIQ-23]   = is_aiq0_create0_lch_rdy_biq[23:0];
assign aiq0_create0_data[AIQ0_LCH_RDY_AIQ1:AIQ0_LCH_RDY_AIQ1-23] = is_aiq0_create0_lch_rdy_aiq1[23:0];
assign aiq0_create0_data[AIQ0_LCH_RDY_AIQ0:AIQ0_LCH_RDY_AIQ0-23] = is_aiq0_create0_lch_rdy_aiq0[23:0];
assign aiq0_create0_data[AIQ0_ALU_SHORT]                         = is_aiq0_create0_data[IS_ALU_SHORT];
assign aiq0_create0_data[AIQ0_PID:AIQ0_PID-4]                    = is_aiq0_create0_pid[4:0];
assign aiq0_create0_data[AIQ0_PCFIFO]                            = is_aiq0_create0_data[IS_PCFIFO];
assign aiq0_create0_data[AIQ0_MTVR]                              = is_aiq0_create0_data[IS_MTVR];
assign aiq0_create0_data[AIQ0_HIGH_HW_EXPT]                      = is_aiq0_create0_data[IS_EXPT];
assign aiq0_create0_data[AIQ0_EXPT_VEC:AIQ0_EXPT_VEC-4]          = is_aiq0_create0_data[IS_EXPT-1:IS_EXPT-5];
assign aiq0_create0_data[AIQ0_EXPT_VLD]                          = is_aiq0_create0_data[IS_EXPT-6];
assign aiq0_create0_data[AIQ0_SRC2_LSU_MATCH]                    = is_aiq0_create0_data[IS_SRC2_LSU_MATCH];
assign aiq0_create0_data[AIQ0_SRC2_DATA:AIQ0_SRC2_DATA-8]        = is_aiq0_create0_data[IS_SRC2_DATA-1:IS_SRC2_DATA-9];
assign aiq0_create0_data[AIQ0_SRC1_LSU_MATCH]                    = is_aiq0_create0_data[IS_SRC1_LSU_MATCH];
assign aiq0_create0_data[AIQ0_SRC1_DATA:AIQ0_SRC1_DATA-8]        = is_aiq0_create0_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign aiq0_create0_data[AIQ0_SRC0_LSU_MATCH]                    = is_aiq0_create0_data[IS_SRC0_LSU_MATCH];
assign aiq0_create0_data[AIQ0_SRC0_DATA:AIQ0_SRC0_DATA-8]        = is_aiq0_create0_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign aiq0_create0_data[AIQ0_DST_VREG:AIQ0_DST_VREG-6]          = is_aiq0_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign aiq0_create0_data[AIQ0_DST_PREG:AIQ0_DST_PREG-6]          = is_aiq0_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign aiq0_create0_data[AIQ0_DSTV_VLD]                          = is_aiq0_create0_data[IS_DSTV_VLD];
assign aiq0_create0_data[AIQ0_DST_VLD]                           = is_aiq0_create0_data[IS_DST_VLD];
assign aiq0_create0_data[AIQ0_SRC2_VLD]                          = is_aiq0_create0_data[IS_SRC2_VLD];
assign aiq0_create0_data[AIQ0_SRC1_VLD]                          = is_aiq0_create0_data[IS_SRC1_VLD];
assign aiq0_create0_data[AIQ0_SRC0_VLD]                          = is_aiq0_create0_data[IS_SRC0_VLD];
assign aiq0_create0_data[AIQ0_IID:AIQ0_IID-6]                    = is_aiq0_create0_iid[6:0];
assign aiq0_create0_data[AIQ0_OPCODE:AIQ0_OPCODE-31]             = is_aiq0_create0_data[IS_OPCODE:IS_OPCODE-31];

//operand mux for iq create
assign dp_aiq0_create1_data[AIQ0_WIDTH-1:0] = {AIQ0_WIDTH{ctrl_aiq0_create1_gateclk_en}}
                                              & aiq0_create1_data[AIQ0_WIDTH-1:0];

assign aiq0_create1_data[AIQ0_VL:AIQ0_VL-7]                      = is_aiq0_create1_data[IS_VL:IS_VL-7];
assign aiq0_create1_data[AIQ0_LCH_PREG]                          = is_aiq0_create1_data[IS_LCH_PREG];
assign aiq0_create1_data[AIQ0_SPECIAL]                           = is_aiq0_create1_data[IS_SPECIAL];
assign aiq0_create1_data[AIQ0_VSEW:AIQ0_VSEW-2]                  = is_aiq0_create1_data[IS_VSEW:IS_VSEW-2];
assign aiq0_create1_data[AIQ0_VLMUL:AIQ0_VLMUL-1]                = is_aiq0_create1_data[IS_VLMUL:IS_VLMUL-1];
assign aiq0_create1_data[AIQ0_DIV]                               = is_aiq0_create1_data[IS_DIV];
assign aiq0_create1_data[AIQ0_LCH_RDY_SDIQ:AIQ0_LCH_RDY_SDIQ-11] = is_aiq0_create1_lch_rdy_sdiq[11:0];
assign aiq0_create1_data[AIQ0_LCH_RDY_LSIQ:AIQ0_LCH_RDY_LSIQ-23] = is_aiq0_create1_lch_rdy_lsiq[23:0];
assign aiq0_create1_data[AIQ0_LCH_RDY_BIQ:AIQ0_LCH_RDY_BIQ-23]   = is_aiq0_create1_lch_rdy_biq[23:0];
assign aiq0_create1_data[AIQ0_LCH_RDY_AIQ1:AIQ0_LCH_RDY_AIQ1-23] = is_aiq0_create1_lch_rdy_aiq1[23:0];
assign aiq0_create1_data[AIQ0_LCH_RDY_AIQ0:AIQ0_LCH_RDY_AIQ0-23] = is_aiq0_create1_lch_rdy_aiq0[23:0];
assign aiq0_create1_data[AIQ0_ALU_SHORT]                         = is_aiq0_create1_data[IS_ALU_SHORT];
assign aiq0_create1_data[AIQ0_PID:AIQ0_PID-4]                    = is_aiq0_create1_pid[4:0];
assign aiq0_create1_data[AIQ0_PCFIFO]                            = is_aiq0_create1_data[IS_PCFIFO];
assign aiq0_create1_data[AIQ0_MTVR]                              = is_aiq0_create1_data[IS_MTVR];
assign aiq0_create1_data[AIQ0_HIGH_HW_EXPT]                      = is_aiq0_create1_data[IS_EXPT];
assign aiq0_create1_data[AIQ0_EXPT_VEC:AIQ0_EXPT_VEC-4]          = is_aiq0_create1_data[IS_EXPT-1:IS_EXPT-5];
assign aiq0_create1_data[AIQ0_EXPT_VLD]                          = is_aiq0_create1_data[IS_EXPT-6];
assign aiq0_create1_data[AIQ0_SRC2_LSU_MATCH]                    = is_aiq0_create1_data[IS_SRC2_LSU_MATCH];
assign aiq0_create1_data[AIQ0_SRC2_DATA:AIQ0_SRC2_DATA-8]        = is_aiq0_create1_data[IS_SRC2_DATA-1:IS_SRC2_DATA-9];
assign aiq0_create1_data[AIQ0_SRC1_LSU_MATCH]                    = is_aiq0_create1_data[IS_SRC1_LSU_MATCH];
assign aiq0_create1_data[AIQ0_SRC1_DATA:AIQ0_SRC1_DATA-8]        = is_aiq0_create1_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign aiq0_create1_data[AIQ0_SRC0_LSU_MATCH]                    = is_aiq0_create1_data[IS_SRC0_LSU_MATCH];
assign aiq0_create1_data[AIQ0_SRC0_DATA:AIQ0_SRC0_DATA-8]        = is_aiq0_create1_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign aiq0_create1_data[AIQ0_DST_VREG:AIQ0_DST_VREG-6]          = is_aiq0_create1_data[IS_DST_VREG:IS_DST_VREG-6];
assign aiq0_create1_data[AIQ0_DST_PREG:AIQ0_DST_PREG-6]          = is_aiq0_create1_data[IS_DST_PREG:IS_DST_PREG-6];
assign aiq0_create1_data[AIQ0_DSTV_VLD]                          = is_aiq0_create1_data[IS_DSTV_VLD];
assign aiq0_create1_data[AIQ0_DST_VLD]                           = is_aiq0_create1_data[IS_DST_VLD];
assign aiq0_create1_data[AIQ0_SRC2_VLD]                          = is_aiq0_create1_data[IS_SRC2_VLD];
assign aiq0_create1_data[AIQ0_SRC1_VLD]                          = is_aiq0_create1_data[IS_SRC1_VLD];
assign aiq0_create1_data[AIQ0_SRC0_VLD]                          = is_aiq0_create1_data[IS_SRC0_VLD];
assign aiq0_create1_data[AIQ0_IID:AIQ0_IID-6]                    = is_aiq0_create1_iid[6:0];
assign aiq0_create1_data[AIQ0_OPCODE:AIQ0_OPCODE-31]             = is_aiq0_create1_data[IS_OPCODE:IS_OPCODE-31];

assign dp_aiq0_bypass_data[AIQ0_VL:AIQ0_VL-7]                       = is_aiq0_create0_data[IS_VL:IS_VL-7];
assign dp_aiq0_bypass_data[AIQ0_LCH_PREG]                           = is_aiq0_create0_data[IS_LCH_PREG];
assign dp_aiq0_bypass_data[AIQ0_SPECIAL]                            = is_aiq0_create0_data[IS_SPECIAL];
assign dp_aiq0_bypass_data[AIQ0_VSEW:AIQ0_VSEW-2]                   = is_aiq0_create0_data[IS_VSEW:IS_VSEW-2];
assign dp_aiq0_bypass_data[AIQ0_VLMUL:AIQ0_VLMUL-1]                 = is_aiq0_create0_data[IS_VLMUL:IS_VLMUL-1];
assign dp_aiq0_bypass_data[AIQ0_DIV]                                = is_aiq0_create0_data[IS_DIV];
assign dp_aiq0_bypass_data[AIQ0_LCH_RDY_SDIQ:AIQ0_LCH_RDY_SDIQ-11]  = is_aiq0_create0_lch_rdy_sdiq[11:0];
assign dp_aiq0_bypass_data[AIQ0_LCH_RDY_LSIQ:AIQ0_LCH_RDY_LSIQ-23]  = is_aiq0_create0_lch_rdy_lsiq[23:0];
assign dp_aiq0_bypass_data[AIQ0_LCH_RDY_BIQ:AIQ0_LCH_RDY_BIQ-23]    = is_aiq0_create0_lch_rdy_biq[23:0];
assign dp_aiq0_bypass_data[AIQ0_LCH_RDY_AIQ1:AIQ0_LCH_RDY_AIQ1-23]  = is_aiq0_create0_lch_rdy_aiq1[23:0];
assign dp_aiq0_bypass_data[AIQ0_LCH_RDY_AIQ0:AIQ0_LCH_RDY_AIQ0-23]  = is_aiq0_create0_lch_rdy_aiq0[23:0];
assign dp_aiq0_bypass_data[AIQ0_ALU_SHORT]                          = is_aiq0_create0_data[IS_ALU_SHORT];
assign dp_aiq0_bypass_data[AIQ0_PID:AIQ0_PID-4]                     = is_aiq0_create0_pid[4:0];
assign dp_aiq0_bypass_data[AIQ0_PCFIFO]                             = is_aiq0_create0_data[IS_PCFIFO];
assign dp_aiq0_bypass_data[AIQ0_MTVR]                               = is_aiq0_create0_data[IS_MTVR];
assign dp_aiq0_bypass_data[AIQ0_HIGH_HW_EXPT]                       = is_aiq0_create0_data[IS_EXPT];
assign dp_aiq0_bypass_data[AIQ0_EXPT_VEC:AIQ0_EXPT_VEC-4]           = is_aiq0_create0_data[IS_EXPT-1:IS_EXPT-5];
assign dp_aiq0_bypass_data[AIQ0_EXPT_VLD]                           = is_aiq0_create0_data[IS_EXPT-6];
assign dp_aiq0_bypass_data[AIQ0_SRC2_LSU_MATCH]                     = 1'b0;
assign dp_aiq0_bypass_data[AIQ0_SRC2_PREG:AIQ0_SRC2_PREG-6]         = is_aiq0_create0_data[IS_SRC2_PREG:IS_SRC2_PREG-6];
assign dp_aiq0_bypass_data[AIQ0_SRC2_WB]                            = is_aiq0_create0_data[IS_SRC2_WB];
assign dp_aiq0_bypass_data[AIQ0_SRC2_RDY]                           = 1'b0;
assign dp_aiq0_bypass_data[AIQ0_SRC1_LSU_MATCH]                     = 1'b0;
assign dp_aiq0_bypass_data[AIQ0_SRC1_PREG:AIQ0_SRC1_PREG-6]         = is_aiq0_create0_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign dp_aiq0_bypass_data[AIQ0_SRC1_WB]                            = is_aiq0_create0_data[IS_SRC1_WB];
assign dp_aiq0_bypass_data[AIQ0_SRC1_RDY]                           = 1'b0;
assign dp_aiq0_bypass_data[AIQ0_SRC0_LSU_MATCH]                     = 1'b0;
assign dp_aiq0_bypass_data[AIQ0_SRC0_PREG:AIQ0_SRC0_PREG-6]         = is_aiq0_create0_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign dp_aiq0_bypass_data[AIQ0_SRC0_WB]                            = is_aiq0_create0_data[IS_SRC0_WB];
assign dp_aiq0_bypass_data[AIQ0_SRC0_RDY]                           = 1'b0;
assign dp_aiq0_bypass_data[AIQ0_DST_VREG:AIQ0_DST_VREG-6]           = is_aiq0_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign dp_aiq0_bypass_data[AIQ0_DST_PREG:AIQ0_DST_PREG-6]           = is_aiq0_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign dp_aiq0_bypass_data[AIQ0_DSTV_VLD]                           = is_aiq0_create0_data[IS_DSTV_VLD];
assign dp_aiq0_bypass_data[AIQ0_DST_VLD]                            = is_aiq0_create0_data[IS_DST_VLD];
assign dp_aiq0_bypass_data[AIQ0_SRC2_VLD]                           = is_aiq0_create0_data[IS_SRC2_VLD];
assign dp_aiq0_bypass_data[AIQ0_SRC1_VLD]                           = is_aiq0_create0_data[IS_SRC1_VLD];
assign dp_aiq0_bypass_data[AIQ0_SRC0_VLD]                           = is_aiq0_create0_data[IS_SRC0_VLD];
assign dp_aiq0_bypass_data[AIQ0_IID:AIQ0_IID-6]                     = is_aiq0_create0_iid[6:0];
assign dp_aiq0_bypass_data[AIQ0_OPCODE:AIQ0_OPCODE-31]              = is_aiq0_create0_data[IS_OPCODE:IS_OPCODE-31];

assign dp_aiq0_create_src0_rdy_for_bypass = is_aiq0_create0_data[IS_SRC0_BP_RDY];
assign dp_aiq0_create_src1_rdy_for_bypass = is_aiq0_create0_data[IS_SRC1_BP_RDY];
assign dp_aiq0_create_src2_rdy_for_bypass = is_aiq0_create0_data[IS_SRC2_BP_RDY];
assign dp_aiq0_create_div                 = is_aiq0_create0_data[IS_DIV];

//----------------------------------------------------------
//                  Create Data for AIQ1
//----------------------------------------------------------
// &CombBeg; @2957
always @( is_inst2_lch_rdy_aiq0[23:0]
       or is_inst2_lch_rdy_sdiq[11:0]
       or is_inst0_lch_rdy_sdiq[11:0]
       or is_inst3_lch_rdy_aiq0[23:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_lch_rdy_aiq0[23:0]
       or is_inst0_lch_rdy_biq[23:0]
       or is_inst0_lch_rdy_aiq1[23:0]
       or is_inst0_lch_rdy_aiq0[23:0]
       or is_inst1_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_lsiq[23:0]
       or is_inst1_iid[6:0]
       or is_inst3_lch_rdy_biq[23:0]
       or is_inst0_lch_rdy_lsiq[23:0]
       or is_inst1_read_data[270:0]
       or is_inst3_lch_rdy_sdiq[11:0]
       or is_inst1_lch_rdy_lsiq[23:0]
       or is_inst3_lch_rdy_lsiq[23:0]
       or is_inst3_lch_rdy_aiq1[23:0]
       or is_inst1_lch_rdy_aiq1[23:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst2_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_aiq1[23:0]
       or ctrl_dp_is_dis_aiq1_create0_sel[1:0]
       or is_inst2_iid[6:0]
       or is_inst1_lch_rdy_sdiq[11:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_aiq1_create0_sel[1:0])
    2'd0: begin
          is_aiq1_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_aiq1_create0_iid[6:0]           = is_inst0_iid[6:0];
          is_aiq1_create0_lch_rdy_aiq0[23:0] = is_inst0_lch_rdy_aiq0[23:0];
          is_aiq1_create0_lch_rdy_aiq1[23:0] = is_inst0_lch_rdy_aiq1[23:0];
          is_aiq1_create0_lch_rdy_biq[23:0]  = is_inst0_lch_rdy_biq[23:0];
          is_aiq1_create0_lch_rdy_lsiq[23:0] = is_inst0_lch_rdy_lsiq[23:0];
          is_aiq1_create0_lch_rdy_sdiq[11:0] = is_inst0_lch_rdy_sdiq[11:0];
          end
    2'd1: begin
          is_aiq1_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_aiq1_create0_iid[6:0]           = is_inst1_iid[6:0];
          is_aiq1_create0_lch_rdy_aiq0[23:0] = is_inst1_lch_rdy_aiq0[23:0];
          is_aiq1_create0_lch_rdy_aiq1[23:0] = is_inst1_lch_rdy_aiq1[23:0];
          is_aiq1_create0_lch_rdy_biq[23:0]  = is_inst1_lch_rdy_biq[23:0];
          is_aiq1_create0_lch_rdy_lsiq[23:0] = is_inst1_lch_rdy_lsiq[23:0];
          is_aiq1_create0_lch_rdy_sdiq[11:0] = is_inst1_lch_rdy_sdiq[11:0];
          end
    2'd2: begin
          is_aiq1_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_aiq1_create0_iid[6:0]           = is_inst2_iid[6:0];
          is_aiq1_create0_lch_rdy_aiq0[23:0] = is_inst2_lch_rdy_aiq0[23:0];
          is_aiq1_create0_lch_rdy_aiq1[23:0] = is_inst2_lch_rdy_aiq1[23:0];
          is_aiq1_create0_lch_rdy_biq[23:0]  = is_inst2_lch_rdy_biq[23:0];
          is_aiq1_create0_lch_rdy_lsiq[23:0] = is_inst2_lch_rdy_lsiq[23:0];
          is_aiq1_create0_lch_rdy_sdiq[11:0] = is_inst2_lch_rdy_sdiq[11:0];
          end
    2'd3: begin
          is_aiq1_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_aiq1_create0_iid[6:0]           = is_inst3_iid[6:0];
          is_aiq1_create0_lch_rdy_aiq0[23:0] = is_inst3_lch_rdy_aiq0[23:0];
          is_aiq1_create0_lch_rdy_aiq1[23:0] = is_inst3_lch_rdy_aiq1[23:0];
          is_aiq1_create0_lch_rdy_biq[23:0]  = is_inst3_lch_rdy_biq[23:0];
          is_aiq1_create0_lch_rdy_lsiq[23:0] = is_inst3_lch_rdy_lsiq[23:0];
          is_aiq1_create0_lch_rdy_sdiq[11:0] = is_inst3_lch_rdy_sdiq[11:0];
          end
    default: begin
          is_aiq1_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_aiq1_create0_iid[6:0]           = {7{1'bx}};
          is_aiq1_create0_lch_rdy_aiq0[23:0] = {24{1'bx}};
          is_aiq1_create0_lch_rdy_aiq1[23:0] = {24{1'bx}};
          is_aiq1_create0_lch_rdy_biq[23:0]  = {24{1'bx}};
          is_aiq1_create0_lch_rdy_lsiq[23:0] = {24{1'bx}};
          is_aiq1_create0_lch_rdy_sdiq[11:0] = {12{1'bx}};
          end
  endcase
// &CombEnd; @3005
end

// &CombBeg; @3007
always @( is_inst2_lch_rdy_aiq0[23:0]
       or is_inst2_lch_rdy_sdiq[11:0]
       or is_inst0_lch_rdy_sdiq[11:0]
       or is_inst3_lch_rdy_aiq0[23:0]
       or ctrl_dp_is_dis_aiq1_create1_sel[1:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_lch_rdy_aiq0[23:0]
       or is_inst0_lch_rdy_biq[23:0]
       or is_inst0_lch_rdy_aiq1[23:0]
       or is_inst0_lch_rdy_aiq0[23:0]
       or is_inst1_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_lsiq[23:0]
       or is_inst1_iid[6:0]
       or is_inst3_lch_rdy_biq[23:0]
       or is_inst0_lch_rdy_lsiq[23:0]
       or is_inst1_read_data[270:0]
       or is_inst3_lch_rdy_sdiq[11:0]
       or is_inst1_lch_rdy_lsiq[23:0]
       or is_inst3_lch_rdy_lsiq[23:0]
       or is_inst3_lch_rdy_aiq1[23:0]
       or is_inst1_lch_rdy_aiq1[23:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst2_lch_rdy_biq[23:0]
       or is_inst2_lch_rdy_aiq1[23:0]
       or is_inst2_iid[6:0]
       or is_inst1_lch_rdy_sdiq[11:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_aiq1_create1_sel[1:0])
    2'd0: begin
          is_aiq1_create1_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_aiq1_create1_iid[6:0]           = is_inst0_iid[6:0];
          is_aiq1_create1_lch_rdy_aiq0[23:0] = is_inst0_lch_rdy_aiq0[23:0];
          is_aiq1_create1_lch_rdy_aiq1[23:0] = is_inst0_lch_rdy_aiq1[23:0];
          is_aiq1_create1_lch_rdy_biq[23:0]  = is_inst0_lch_rdy_biq[23:0];
          is_aiq1_create1_lch_rdy_lsiq[23:0] = is_inst0_lch_rdy_lsiq[23:0];
          is_aiq1_create1_lch_rdy_sdiq[11:0] = is_inst0_lch_rdy_sdiq[11:0];
          end
    2'd1: begin
          is_aiq1_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_aiq1_create1_iid[6:0]           = is_inst1_iid[6:0];
          is_aiq1_create1_lch_rdy_aiq0[23:0] = is_inst1_lch_rdy_aiq0[23:0];
          is_aiq1_create1_lch_rdy_aiq1[23:0] = is_inst1_lch_rdy_aiq1[23:0];
          is_aiq1_create1_lch_rdy_biq[23:0]  = is_inst1_lch_rdy_biq[23:0];
          is_aiq1_create1_lch_rdy_lsiq[23:0] = is_inst1_lch_rdy_lsiq[23:0];
          is_aiq1_create1_lch_rdy_sdiq[11:0] = is_inst1_lch_rdy_sdiq[11:0];
          end
    2'd2: begin
          is_aiq1_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_aiq1_create1_iid[6:0]           = is_inst2_iid[6:0];
          is_aiq1_create1_lch_rdy_aiq0[23:0] = is_inst2_lch_rdy_aiq0[23:0];
          is_aiq1_create1_lch_rdy_aiq1[23:0] = is_inst2_lch_rdy_aiq1[23:0];
          is_aiq1_create1_lch_rdy_biq[23:0]  = is_inst2_lch_rdy_biq[23:0];
          is_aiq1_create1_lch_rdy_lsiq[23:0] = is_inst2_lch_rdy_lsiq[23:0];
          is_aiq1_create1_lch_rdy_sdiq[11:0] = is_inst2_lch_rdy_sdiq[11:0];
          end
    2'd3: begin
          is_aiq1_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_aiq1_create1_iid[6:0]           = is_inst3_iid[6:0];
          is_aiq1_create1_lch_rdy_aiq0[23:0] = is_inst3_lch_rdy_aiq0[23:0];
          is_aiq1_create1_lch_rdy_aiq1[23:0] = is_inst3_lch_rdy_aiq1[23:0];
          is_aiq1_create1_lch_rdy_biq[23:0]  = is_inst3_lch_rdy_biq[23:0];
          is_aiq1_create1_lch_rdy_lsiq[23:0] = is_inst3_lch_rdy_lsiq[23:0];
          is_aiq1_create1_lch_rdy_sdiq[11:0] = is_inst3_lch_rdy_sdiq[11:0];
          end
    default: begin
          is_aiq1_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_aiq1_create1_iid[6:0]           = {7{1'bx}};
          is_aiq1_create1_lch_rdy_aiq0[23:0] = {24{1'bx}};
          is_aiq1_create1_lch_rdy_aiq1[23:0] = {24{1'bx}};
          is_aiq1_create1_lch_rdy_biq[23:0]  = {24{1'bx}};
          is_aiq1_create1_lch_rdy_lsiq[23:0] = {24{1'bx}};
          is_aiq1_create1_lch_rdy_sdiq[11:0] = {12{1'bx}};
          end
  endcase
// &CombEnd; @3055
end

//----------------------------------------------------------
//                Reorganize for AIQ1 create
//----------------------------------------------------------
//operand mux for iq create
assign dp_aiq1_create0_data[AIQ1_WIDTH-1:0] = {AIQ1_WIDTH{ctrl_aiq1_create0_gateclk_en}}
                                              & aiq1_create0_data[AIQ1_WIDTH-1:0];

assign aiq1_create0_data[AIQ1_VL:AIQ1_VL-7]                      = is_aiq1_create0_data[IS_VL:IS_VL-7];
assign aiq1_create0_data[AIQ1_LCH_PREG]                          = is_aiq1_create0_data[IS_LCH_PREG];
assign aiq1_create0_data[AIQ1_VSEW:AIQ1_VSEW-2]                  = is_aiq1_create0_data[IS_VSEW:IS_VSEW-2];
assign aiq1_create0_data[AIQ1_VLMUL:AIQ1_VLMUL-1]                = is_aiq1_create0_data[IS_VLMUL:IS_VLMUL-1];
assign aiq1_create0_data[AIQ1_LCH_RDY_SDIQ:AIQ1_LCH_RDY_SDIQ-11] = is_aiq1_create0_lch_rdy_sdiq[11:0];
assign aiq1_create0_data[AIQ1_LCH_RDY_LSIQ:AIQ1_LCH_RDY_LSIQ-23] = is_aiq1_create0_lch_rdy_lsiq[23:0];
assign aiq1_create0_data[AIQ1_LCH_RDY_BIQ:AIQ1_LCH_RDY_BIQ-23]   = is_aiq1_create0_lch_rdy_biq[23:0];
assign aiq1_create0_data[AIQ1_LCH_RDY_AIQ1:AIQ1_LCH_RDY_AIQ1-23] = is_aiq1_create0_lch_rdy_aiq1[23:0];
assign aiq1_create0_data[AIQ1_LCH_RDY_AIQ0:AIQ1_LCH_RDY_AIQ0-23] = is_aiq1_create0_lch_rdy_aiq0[23:0];
assign aiq1_create0_data[AIQ1_ALU_SHORT]                         = is_aiq1_create0_data[IS_ALU_SHORT];
assign aiq1_create0_data[AIQ1_MLA]                               = is_aiq1_create0_data[IS_MLA];
assign aiq1_create0_data[AIQ1_MTVR]                              = is_aiq1_create0_data[IS_MTVR];
assign aiq1_create0_data[AIQ1_SRC2_LSU_MATCH]                    = is_aiq1_create0_data[IS_SRC2_LSU_MATCH];
assign aiq1_create0_data[AIQ1_SRC2_DATA:AIQ1_SRC2_DATA-9]        = is_aiq1_create0_data[IS_SRC2_DATA:IS_SRC2_DATA-9];
assign aiq1_create0_data[AIQ1_SRC1_LSU_MATCH]                    = is_aiq1_create0_data[IS_SRC1_LSU_MATCH];
assign aiq1_create0_data[AIQ1_SRC1_DATA:AIQ1_SRC1_DATA-8]        = is_aiq1_create0_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign aiq1_create0_data[AIQ1_SRC0_LSU_MATCH]                    = is_aiq1_create0_data[IS_SRC0_LSU_MATCH];
assign aiq1_create0_data[AIQ1_SRC0_DATA:AIQ1_SRC0_DATA-8]        = is_aiq1_create0_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign aiq1_create0_data[AIQ1_DST_VREG:AIQ1_DST_VREG-6]          = is_aiq1_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign aiq1_create0_data[AIQ1_DST_PREG:AIQ1_DST_PREG-6]          = is_aiq1_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign aiq1_create0_data[AIQ1_DSTV_VLD]                          = is_aiq1_create0_data[IS_DSTV_VLD];
assign aiq1_create0_data[AIQ1_DST_VLD]                           = is_aiq1_create0_data[IS_DST_VLD];
assign aiq1_create0_data[AIQ1_SRC2_VLD]                          = is_aiq1_create0_data[IS_SRC2_VLD];
assign aiq1_create0_data[AIQ1_SRC1_VLD]                          = is_aiq1_create0_data[IS_SRC1_VLD];
assign aiq1_create0_data[AIQ1_SRC0_VLD]                          = is_aiq1_create0_data[IS_SRC0_VLD];
assign aiq1_create0_data[AIQ1_IID:AIQ1_IID-6]                    = is_aiq1_create0_iid[6:0];
assign aiq1_create0_data[AIQ1_OPCODE:AIQ1_OPCODE-31]             = is_aiq1_create0_data[IS_OPCODE:IS_OPCODE-31];

//operand mux for iq create
assign dp_aiq1_create1_data[AIQ1_WIDTH-1:0] = {AIQ1_WIDTH{ctrl_aiq1_create1_gateclk_en}}
                                              & aiq1_create1_data[AIQ1_WIDTH-1:0];

assign aiq1_create1_data[AIQ1_VL:AIQ1_VL-7]                      = is_aiq1_create1_data[IS_VL:IS_VL-7];
assign aiq1_create1_data[AIQ1_LCH_PREG]                          = is_aiq1_create1_data[IS_LCH_PREG];
assign aiq1_create1_data[AIQ1_VSEW:AIQ1_VSEW-2]                  = is_aiq1_create1_data[IS_VSEW:IS_VSEW-2];
assign aiq1_create1_data[AIQ1_VLMUL:AIQ1_VLMUL-1]                = is_aiq1_create1_data[IS_VLMUL:IS_VLMUL-1];
assign aiq1_create1_data[AIQ1_LCH_RDY_SDIQ:AIQ1_LCH_RDY_SDIQ-11] = is_aiq1_create1_lch_rdy_sdiq[11:0];
assign aiq1_create1_data[AIQ1_LCH_RDY_LSIQ:AIQ1_LCH_RDY_LSIQ-23] = is_aiq1_create1_lch_rdy_lsiq[23:0];
assign aiq1_create1_data[AIQ1_LCH_RDY_BIQ:AIQ1_LCH_RDY_BIQ-23]   = is_aiq1_create1_lch_rdy_biq[23:0];
assign aiq1_create1_data[AIQ1_LCH_RDY_AIQ1:AIQ1_LCH_RDY_AIQ1-23] = is_aiq1_create1_lch_rdy_aiq1[23:0];
assign aiq1_create1_data[AIQ1_LCH_RDY_AIQ0:AIQ1_LCH_RDY_AIQ0-23] = is_aiq1_create1_lch_rdy_aiq0[23:0];
assign aiq1_create1_data[AIQ1_ALU_SHORT]                         = is_aiq1_create1_data[IS_ALU_SHORT];
assign aiq1_create1_data[AIQ1_MLA]                               = is_aiq1_create1_data[IS_MLA];
assign aiq1_create1_data[AIQ1_MTVR]                              = is_aiq1_create1_data[IS_MTVR];
assign aiq1_create1_data[AIQ1_SRC2_LSU_MATCH]                    = is_aiq1_create1_data[IS_SRC2_LSU_MATCH];
assign aiq1_create1_data[AIQ1_SRC2_DATA:AIQ1_SRC2_DATA-9]        = is_aiq1_create1_data[IS_SRC2_DATA:IS_SRC2_DATA-9];
assign aiq1_create1_data[AIQ1_SRC1_LSU_MATCH]                    = is_aiq1_create1_data[IS_SRC1_LSU_MATCH];
assign aiq1_create1_data[AIQ1_SRC1_DATA:AIQ1_SRC1_DATA-8]        = is_aiq1_create1_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign aiq1_create1_data[AIQ1_SRC0_LSU_MATCH]                    = is_aiq1_create1_data[IS_SRC0_LSU_MATCH];
assign aiq1_create1_data[AIQ1_SRC0_DATA:AIQ1_SRC0_DATA-8]        = is_aiq1_create1_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign aiq1_create1_data[AIQ1_DST_VREG:AIQ1_DST_VREG-6]          = is_aiq1_create1_data[IS_DST_VREG:IS_DST_VREG-6];
assign aiq1_create1_data[AIQ1_DST_PREG:AIQ1_DST_PREG-6]          = is_aiq1_create1_data[IS_DST_PREG:IS_DST_PREG-6];
assign aiq1_create1_data[AIQ1_DSTV_VLD]                          = is_aiq1_create1_data[IS_DSTV_VLD];
assign aiq1_create1_data[AIQ1_DST_VLD]                           = is_aiq1_create1_data[IS_DST_VLD];
assign aiq1_create1_data[AIQ1_SRC2_VLD]                          = is_aiq1_create1_data[IS_SRC2_VLD];
assign aiq1_create1_data[AIQ1_SRC1_VLD]                          = is_aiq1_create1_data[IS_SRC1_VLD];
assign aiq1_create1_data[AIQ1_SRC0_VLD]                          = is_aiq1_create1_data[IS_SRC0_VLD];
assign aiq1_create1_data[AIQ1_IID:AIQ1_IID-6]                    = is_aiq1_create1_iid[6:0];
assign aiq1_create1_data[AIQ1_OPCODE:AIQ1_OPCODE-31]             = is_aiq1_create1_data[IS_OPCODE:IS_OPCODE-31];

assign dp_aiq1_bypass_data[AIQ1_VL:AIQ1_VL-7]                       = is_aiq1_create0_data[IS_VL:IS_VL-7];
assign dp_aiq1_bypass_data[AIQ1_LCH_PREG]                           = is_aiq1_create0_data[IS_LCH_PREG];
assign dp_aiq1_bypass_data[AIQ1_VSEW:AIQ1_VSEW-2]                   = is_aiq1_create0_data[IS_VSEW:IS_VSEW-2];
assign dp_aiq1_bypass_data[AIQ1_VLMUL:AIQ1_VLMUL-1]                 = is_aiq1_create0_data[IS_VLMUL:IS_VLMUL-1];
assign dp_aiq1_bypass_data[AIQ1_LCH_RDY_SDIQ:AIQ1_LCH_RDY_SDIQ-11]  = is_aiq1_create0_lch_rdy_sdiq[11:0];
assign dp_aiq1_bypass_data[AIQ1_LCH_RDY_LSIQ:AIQ1_LCH_RDY_LSIQ-23]  = is_aiq1_create0_lch_rdy_lsiq[23:0];
assign dp_aiq1_bypass_data[AIQ1_LCH_RDY_BIQ:AIQ1_LCH_RDY_BIQ-23]    = is_aiq1_create0_lch_rdy_biq[23:0];
assign dp_aiq1_bypass_data[AIQ1_LCH_RDY_AIQ1:AIQ1_LCH_RDY_AIQ1-23]  = is_aiq1_create0_lch_rdy_aiq1[23:0];
assign dp_aiq1_bypass_data[AIQ1_LCH_RDY_AIQ0:AIQ1_LCH_RDY_AIQ0-23]  = is_aiq1_create0_lch_rdy_aiq0[23:0];
assign dp_aiq1_bypass_data[AIQ1_ALU_SHORT]                          = is_aiq1_create0_data[IS_ALU_SHORT];
assign dp_aiq1_bypass_data[AIQ1_MLA]                                = is_aiq1_create0_data[IS_MLA];
assign dp_aiq1_bypass_data[AIQ1_MTVR]                               = is_aiq1_create0_data[IS_MTVR];
assign dp_aiq1_bypass_data[AIQ1_SRC2_LSU_MATCH]                     = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_SRC2_DATA]                          = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_SRC2_PREG:AIQ1_SRC2_PREG-6]         = is_aiq1_create0_data[IS_SRC2_PREG:IS_SRC2_PREG-6];
assign dp_aiq1_bypass_data[AIQ1_SRC2_WB]                            = is_aiq1_create0_data[IS_SRC2_WB];
assign dp_aiq1_bypass_data[AIQ1_SRC2_RDY]                           = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_SRC1_LSU_MATCH]                     = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_SRC1_PREG:AIQ1_SRC1_PREG-6]         = is_aiq1_create0_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign dp_aiq1_bypass_data[AIQ1_SRC1_WB]                            = is_aiq1_create0_data[IS_SRC1_WB];
assign dp_aiq1_bypass_data[AIQ1_SRC1_RDY]                           = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_SRC0_LSU_MATCH]                     = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_SRC0_PREG:AIQ1_SRC0_PREG-6]         = is_aiq1_create0_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign dp_aiq1_bypass_data[AIQ1_SRC0_WB]                            = is_aiq1_create0_data[IS_SRC0_WB];
assign dp_aiq1_bypass_data[AIQ1_SRC0_RDY]                           = 1'b0;
assign dp_aiq1_bypass_data[AIQ1_DST_VREG:AIQ1_DST_VREG-6]           = is_aiq1_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign dp_aiq1_bypass_data[AIQ1_DST_PREG:AIQ1_DST_PREG-6]           = is_aiq1_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign dp_aiq1_bypass_data[AIQ1_DSTV_VLD]                           = is_aiq1_create0_data[IS_DSTV_VLD];
assign dp_aiq1_bypass_data[AIQ1_DST_VLD]                            = is_aiq1_create0_data[IS_DST_VLD];
assign dp_aiq1_bypass_data[AIQ1_SRC2_VLD]                           = is_aiq1_create0_data[IS_SRC2_VLD];
assign dp_aiq1_bypass_data[AIQ1_SRC1_VLD]                           = is_aiq1_create0_data[IS_SRC1_VLD];
assign dp_aiq1_bypass_data[AIQ1_SRC0_VLD]                           = is_aiq1_create0_data[IS_SRC0_VLD];
assign dp_aiq1_bypass_data[AIQ1_IID:AIQ1_IID-6]                     = is_aiq1_create0_iid[6:0];
assign dp_aiq1_bypass_data[AIQ1_OPCODE:AIQ1_OPCODE-31]              = is_aiq1_create0_data[IS_OPCODE:IS_OPCODE-31];

assign dp_aiq1_create_src0_rdy_for_bypass = is_aiq1_create0_data[IS_SRC0_BP_RDY];
assign dp_aiq1_create_src1_rdy_for_bypass = is_aiq1_create0_data[IS_SRC1_BP_RDY];
assign dp_aiq1_create_src2_rdy_for_bypass = is_aiq1_create0_data[IS_SRC2_BP_RDY];
assign dp_aiq1_create_alu                 = is_aiq1_create0_data[IS_ALU];

//----------------------------------------------------------
//                  Create Data for BIQ
//----------------------------------------------------------
// &CombBeg; @3167
always @( is_inst2_pid[4:0]
       or ctrl_dp_is_dis_biq_create0_sel[1:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_pid[4:0]
       or is_inst1_iid[6:0]
       or is_inst1_read_data[270:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst3_pid[4:0]
       or is_inst2_iid[6:0]
       or is_inst0_pid[4:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_biq_create0_sel[1:0])
    2'd0: begin
          is_biq_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_biq_create0_iid[6:0]           = is_inst0_iid[6:0];
          is_biq_create0_pid[4:0]           = is_inst0_pid[4:0];
          end
    2'd1: begin
          is_biq_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_biq_create0_iid[6:0]           = is_inst1_iid[6:0];
          is_biq_create0_pid[4:0]           = is_inst1_pid[4:0];
          end
    2'd2: begin
          is_biq_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_biq_create0_iid[6:0]           = is_inst2_iid[6:0];
          is_biq_create0_pid[4:0]           = is_inst2_pid[4:0];
          end
    2'd3: begin
          is_biq_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_biq_create0_iid[6:0]           = is_inst3_iid[6:0];
          is_biq_create0_pid[4:0]           = is_inst3_pid[4:0];
          end
    default: begin
          is_biq_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_biq_create0_iid[6:0]           = {7{1'bx}};
          is_biq_create0_pid[4:0]           = {5{1'bx}};
          end
  endcase
// &CombEnd; @3195
end

// &CombBeg; @3197
always @( is_inst2_pid[4:0]
       or ctrl_dp_is_dis_biq_create1_sel[1:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_pid[4:0]
       or is_inst1_iid[6:0]
       or is_inst1_read_data[270:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst3_pid[4:0]
       or is_inst2_iid[6:0]
       or is_inst0_pid[4:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_biq_create1_sel[1:0])
    2'd0: begin
          is_biq_create1_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_biq_create1_iid[6:0]           = is_inst0_iid[6:0];
          is_biq_create1_pid[4:0]           = is_inst0_pid[4:0];
          end
    2'd1: begin
          is_biq_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_biq_create1_iid[6:0]           = is_inst1_iid[6:0];
          is_biq_create1_pid[4:0]           = is_inst1_pid[4:0];
          end
    2'd2: begin
          is_biq_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_biq_create1_iid[6:0]           = is_inst2_iid[6:0];
          is_biq_create1_pid[4:0]           = is_inst2_pid[4:0];
          end
    2'd3: begin
          is_biq_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_biq_create1_iid[6:0]           = is_inst3_iid[6:0];
          is_biq_create1_pid[4:0]           = is_inst3_pid[4:0];
          end
    default: begin
          is_biq_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_biq_create1_iid[6:0]           = {7{1'bx}};
          is_biq_create1_pid[4:0]           = {5{1'bx}};
          end
  endcase
// &CombEnd; @3225
end

//----------------------------------------------------------
//                Reorganize for BIQ create
//----------------------------------------------------------
//operand mux for iq create
assign dp_biq_create0_data[BIQ_WIDTH-1:0] = {BIQ_WIDTH{ctrl_biq_create0_gateclk_en}}
                                            & biq_create0_data[BIQ_WIDTH-1:0];

assign biq_create0_data[BIQ_VL:BIQ_VL-7]               = is_biq_create0_data[IS_VL:IS_VL-7];
assign biq_create0_data[BIQ_VSEW:BIQ_VSEW-2]           = is_biq_create0_data[IS_VSEW:IS_VSEW-2];
assign biq_create0_data[BIQ_VLMUL:BIQ_VLMUL-1]         = is_biq_create0_data[IS_VLMUL:IS_VLMUL-1];
assign biq_create0_data[BIQ_PCALL]                     = is_biq_create0_data[IS_PCALL];
assign biq_create0_data[BIQ_RTS]                       = is_biq_create0_data[IS_RTS];
assign biq_create0_data[BIQ_PID:BIQ_PID-4]             = is_biq_create0_pid[4:0];
assign biq_create0_data[BIQ_LENGTH]                    = is_biq_create0_data[IS_LENGTH];
assign biq_create0_data[BIQ_SRC1_LSU_MATCH]            = is_biq_create0_data[IS_SRC1_LSU_MATCH];
assign biq_create0_data[BIQ_SRC1_DATA:BIQ_SRC1_DATA-8] = is_biq_create0_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign biq_create0_data[BIQ_SRC0_LSU_MATCH]            = is_biq_create0_data[IS_SRC0_LSU_MATCH];
assign biq_create0_data[BIQ_SRC0_DATA:BIQ_SRC0_DATA-8] = is_biq_create0_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign biq_create0_data[BIQ_SRC1_VLD]                  = is_biq_create0_data[IS_SRC1_VLD];
assign biq_create0_data[BIQ_SRC0_VLD]                  = is_biq_create0_data[IS_SRC0_VLD];
assign biq_create0_data[BIQ_IID:BIQ_IID-6]             = is_biq_create0_iid[6:0];
assign biq_create0_data[BIQ_OPCODE:BIQ_OPCODE-31]      = is_biq_create0_data[IS_OPCODE:IS_OPCODE-31];

//operand mux for iq create
assign dp_biq_create1_data[BIQ_WIDTH-1:0] = {BIQ_WIDTH{ctrl_biq_create1_gateclk_en}}
                                            & biq_create1_data[BIQ_WIDTH-1:0];

assign biq_create1_data[BIQ_VL:BIQ_VL-7]               = is_biq_create1_data[IS_VL:IS_VL-7];
assign biq_create1_data[BIQ_VSEW:BIQ_VSEW-2]           = is_biq_create1_data[IS_VSEW:IS_VSEW-2];
assign biq_create1_data[BIQ_VLMUL:BIQ_VLMUL-1]         = is_biq_create1_data[IS_VLMUL:IS_VLMUL-1];
assign biq_create1_data[BIQ_PCALL]                     = is_biq_create1_data[IS_PCALL];
assign biq_create1_data[BIQ_RTS]                       = is_biq_create1_data[IS_RTS];
assign biq_create1_data[BIQ_PID:BIQ_PID-4]             = is_biq_create1_pid[4:0];
assign biq_create1_data[BIQ_LENGTH]                    = is_biq_create1_data[IS_LENGTH];
assign biq_create1_data[BIQ_SRC1_LSU_MATCH]            = is_biq_create1_data[IS_SRC1_LSU_MATCH];
assign biq_create1_data[BIQ_SRC1_DATA:BIQ_SRC1_DATA-8] = is_biq_create1_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign biq_create1_data[BIQ_SRC0_LSU_MATCH]            = is_biq_create1_data[IS_SRC0_LSU_MATCH];
assign biq_create1_data[BIQ_SRC0_DATA:BIQ_SRC0_DATA-8] = is_biq_create1_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign biq_create1_data[BIQ_SRC1_VLD]                  = is_biq_create1_data[IS_SRC1_VLD];
assign biq_create1_data[BIQ_SRC0_VLD]                  = is_biq_create1_data[IS_SRC0_VLD];
assign biq_create1_data[BIQ_IID:BIQ_IID-6]             = is_biq_create1_iid[6:0];
assign biq_create1_data[BIQ_OPCODE:BIQ_OPCODE-31]      = is_biq_create1_data[IS_OPCODE:IS_OPCODE-31];

assign dp_biq_bypass_data[BIQ_VL:BIQ_VL-7]                = is_biq_create0_data[IS_VL:IS_VL-7];
assign dp_biq_bypass_data[BIQ_VSEW:BIQ_VSEW-2]            = is_biq_create0_data[IS_VSEW:IS_VSEW-2];
assign dp_biq_bypass_data[BIQ_VLMUL:BIQ_VLMUL-1]          = is_biq_create0_data[IS_VLMUL:IS_VLMUL-1];
assign dp_biq_bypass_data[BIQ_PCALL]                      = is_biq_create0_data[IS_PCALL];
assign dp_biq_bypass_data[BIQ_RTS]                        = is_biq_create0_data[IS_RTS];
assign dp_biq_bypass_data[BIQ_PID:BIQ_PID-4]              = is_biq_create0_pid[4:0];
assign dp_biq_bypass_data[BIQ_LENGTH]                     = is_biq_create0_data[IS_LENGTH];
assign dp_biq_bypass_data[BIQ_SRC1_LSU_MATCH]             = 1'b0;
assign dp_biq_bypass_data[BIQ_SRC1_PREG:BIQ_SRC1_PREG-6]  = is_biq_create0_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign dp_biq_bypass_data[BIQ_SRC1_WB]                    = is_biq_create0_data[IS_SRC1_WB];
assign dp_biq_bypass_data[BIQ_SRC1_RDY]                   = 1'b0;
assign dp_biq_bypass_data[BIQ_SRC0_LSU_MATCH]             = 1'b0;
assign dp_biq_bypass_data[BIQ_SRC0_PREG:BIQ_SRC0_PREG-6]  = is_biq_create0_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign dp_biq_bypass_data[BIQ_SRC0_WB]                    = is_biq_create0_data[IS_SRC0_WB];
assign dp_biq_bypass_data[BIQ_SRC0_RDY]                   = 1'b0;
assign dp_biq_bypass_data[BIQ_SRC1_VLD]                   = is_biq_create0_data[IS_SRC1_VLD];
assign dp_biq_bypass_data[BIQ_SRC0_VLD]                   = is_biq_create0_data[IS_SRC0_VLD];
assign dp_biq_bypass_data[BIQ_IID:BIQ_IID-6]              = is_biq_create0_iid[6:0];
assign dp_biq_bypass_data[BIQ_OPCODE:BIQ_OPCODE-31]       = is_biq_create0_data[IS_OPCODE:IS_OPCODE-31];

assign dp_biq_create_src0_rdy_for_bypass = is_biq_create0_data[IS_SRC0_BP_RDY];
assign dp_biq_create_src1_rdy_for_bypass = is_biq_create0_data[IS_SRC1_BP_RDY];

//----------------------------------------------------------
//                  Create Data for LSIQ
//----------------------------------------------------------
// &CombBeg; @3296
always @( is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_iid[6:0]
       or is_inst1_read_data[270:0]
       or is_inst0_read_data[270:0]
       or ctrl_dp_is_dis_lsiq_create0_sel[1:0]
       or is_inst3_read_data[270:0]
       or is_inst2_iid[6:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_lsiq_create0_sel[1:0])
    2'd0: begin
          is_lsiq_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_lsiq_create0_iid[6:0]           = is_inst0_iid[6:0];
          end
    2'd1: begin
          is_lsiq_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_lsiq_create0_iid[6:0]           = is_inst1_iid[6:0];
          end
    2'd2: begin
          is_lsiq_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_lsiq_create0_iid[6:0]           = is_inst2_iid[6:0];
          end
    2'd3: begin
          is_lsiq_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_lsiq_create0_iid[6:0]           = is_inst3_iid[6:0];
          end
    default: begin
          is_lsiq_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_lsiq_create0_iid[6:0]           = {7{1'bx}};
          end
  endcase
// &CombEnd; @3319
end

// &CombBeg; @3321
always @( is_inst3_iid[6:0]
       or is_inst1_iid[6:0]
       or is_inst1_read_data[270:0]
       or is_inst3_read_data[270:0]
       or ctrl_dp_is_dis_lsiq_create1_sel[1:0]
       or is_inst2_iid[6:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_lsiq_create1_sel[1:0])
    2'd1: begin
          is_lsiq_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_lsiq_create1_iid[6:0]           = is_inst1_iid[6:0];
          end
    2'd2: begin
          is_lsiq_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_lsiq_create1_iid[6:0]           = is_inst2_iid[6:0];
          end
    2'd3: begin
          is_lsiq_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_lsiq_create1_iid[6:0]           = is_inst3_iid[6:0];
          end
    default: begin
          is_lsiq_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_lsiq_create1_iid[6:0]           = {7{1'bx}};
          end
  endcase
// &CombEnd; @3340
end

//staddr indicate inst created into sdiq
//some vector load use vmb entry id instead of sdiq entry id
assign is_lsiq_create0_entry[11:0]      = is_lsiq_create0_data[IS_LOAD]
                                          ? {4'b0,lsu_idu_vmb_create0_entry[7:0]}
                                          : sdiq_dp_create0_entry[11:0];

assign sdiq_vmb_create1_entry[11:0]     = is_lsiq_create0_data[IS_STADDR]
                                          ? sdiq_dp_create1_entry[11:0]
                                          : sdiq_dp_create0_entry[11:0];

assign sdiq_vmb_create1_dp_en           = is_lsiq_create0_data[IS_STADDR]
                                          ? ctrl_sdiq_create1_dp_en 
                                          : ctrl_sdiq_create0_dp_en; 

assign is_lsiq_create1_entry[11:0]      = is_lsiq_create1_data[IS_LOAD]
                                          ? {4'b0,lsu_idu_vmb_create1_entry[7:0]}
                                          : (is_lsiq_create0_data[IS_STADDR]
                                             ? sdiq_dp_create1_entry[11:0]
                                             : sdiq_dp_create0_entry[11:0]);

assign is_lsiq_create0_sdiq_entry[11:0] = is_lsiq_create0_entry[11:0];
assign is_lsiq_create1_sdiq_entry[11:0] = is_lsiq_create1_entry[11:0];

//----------------------------------------------------------
//                Reorganize for LSIQ create
//----------------------------------------------------------
//operand mux for iq create
assign dp_lsiq_create0_data[LSIQ_WIDTH-1:0]                  = {LSIQ_WIDTH{ctrl_lsiq_create0_gateclk_en}}
                                                               & lsiq_create0_data[LSIQ_WIDTH-1:0];

assign dp_lsiq_create0_sti_sel                               = is_lsiq_create0_data[IS_STADDR]
                                                               && !is_lsiq_create0_data[IS_STR];

assign lsiq_create0_data[LSIQ_VL:LSIQ_VL-7]                  = is_lsiq_create0_data[IS_VL:IS_VL-7];
assign lsiq_create0_data[LSIQ_VMB]                           = is_lsiq_create0_data[IS_VMB];
assign lsiq_create0_data[LSIQ_SPLIT_NUM:LSIQ_SPLIT_NUM-6]    = is_lsiq_create0_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign lsiq_create0_data[LSIQ_VSEW:LSIQ_VSEW-2]              = is_lsiq_create0_data[IS_VSEW:IS_VSEW-2];
assign lsiq_create0_data[LSIQ_VLMUL:LSIQ_VLMUL-1]            = is_lsiq_create0_data[IS_VLMUL:IS_VLMUL-1];
assign lsiq_create0_data[LSIQ_BKPTB_DATA]                    = 1'b0;
assign lsiq_create0_data[LSIQ_BKPTA_DATA]                    = 1'b0;
assign lsiq_create0_data[LSIQ_AGEVEC_ALL:LSIQ_AGEVEC_ALL-10] = 11'b0;
assign lsiq_create0_data[LSIQ_ALREADY_DA]                    = 1'b0;
assign lsiq_create0_data[LSIQ_UNALIGN_2ND]                   = 1'b0;
assign lsiq_create0_data[LSIQ_SPEC_FAIL]                     = 1'b0;
assign lsiq_create0_data[LSIQ_NO_SPEC_EXIST]                 = lsiq_dp_no_spec_store_vld;
assign lsiq_create0_data[LSIQ_NO_SPEC]                       = is_lsiq_create0_data[IS_NO_SPEC];
assign lsiq_create0_data[LSIQ_SPLIT]                         = is_lsiq_create0_data[IS_SPLIT];
assign lsiq_create0_data[LSIQ_SDIQ_ENTRY:LSIQ_SDIQ_ENTRY-11] = is_lsiq_create0_sdiq_entry[11:0];
assign lsiq_create0_data[LSIQ_STADDR]                        = is_lsiq_create0_data[IS_STADDR];
assign lsiq_create0_data[LSIQ_PC:LSIQ_PC-14]                 = is_lsiq_create0_data[IS_LSU_PC:IS_LSU_PC-14];
assign lsiq_create0_data[LSIQ_BAR_TYPE:LSIQ_BAR_TYPE-3]      = is_lsiq_create0_data[IS_BAR_TYPE:IS_BAR_TYPE-3];
assign lsiq_create0_data[LSIQ_BAR]                           = is_lsiq_create0_data[IS_BAR];
assign lsiq_create0_data[LSIQ_STORE]                         = is_lsiq_create0_data[IS_STORE];
assign lsiq_create0_data[LSIQ_LOAD]                          = is_lsiq_create0_data[IS_LOAD];
assign lsiq_create0_data[LSIQ_SRCVM_LSU_MATCH]               = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                               ? is_lsiq_create0_data[IS_SRCV1_LSU_MATCH]
                                                               : is_lsiq_create0_data[IS_SRCVM_LSU_MATCH];
assign lsiq_create0_data[LSIQ_SRCVM_DATA:LSIQ_SRCVM_DATA-8]  = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                               ? is_lsiq_create0_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8]
                                                               : is_lsiq_create0_data[IS_SRCVM_DATA:IS_SRCVM_DATA-8];
assign lsiq_create0_data[LSIQ_SRC1_LSU_MATCH]                = dp_lsiq_create0_sti_sel
                                                               ? 1'b0 : is_lsiq_create0_data[IS_SRC1_LSU_MATCH];
assign lsiq_create0_data[LSIQ_SRC1_DATA:LSIQ_SRC1_DATA-8]    = dp_lsiq_create0_sti_sel
                                                               ? 9'b0000000_1_1
                                                               : is_lsiq_create0_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign lsiq_create0_data[LSIQ_SRC0_LSU_MATCH]                = is_lsiq_create0_data[IS_SRC0_LSU_MATCH];
assign lsiq_create0_data[LSIQ_SRC0_DATA:LSIQ_SRC0_DATA-8]    = is_lsiq_create0_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign lsiq_create0_data[LSIQ_DST_VREG:LSIQ_DST_VREG-6]      = is_lsiq_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign lsiq_create0_data[LSIQ_DST_PREG:LSIQ_DST_PREG-6]      = is_lsiq_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign lsiq_create0_data[LSIQ_DSTV_VLD]                      = is_lsiq_create0_data[IS_DSTV_VLD];
assign lsiq_create0_data[LSIQ_DST_VLD]                       = is_lsiq_create0_data[IS_DST_VLD];
assign lsiq_create0_data[LSIQ_SRCVM_VLD]                     = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                               ? is_lsiq_create0_data[IS_SRCV1_VLD]
                                                               : is_lsiq_create0_data[IS_SRCVM_VLD];
assign lsiq_create0_data[LSIQ_SRC1_VLD]                      = is_lsiq_create0_data[IS_SRC1_VLD]
                                                               && !dp_lsiq_create0_sti_sel;
assign lsiq_create0_data[LSIQ_SRC0_VLD]                      = is_lsiq_create0_data[IS_SRC0_VLD];
assign lsiq_create0_data[LSIQ_IID:LSIQ_IID-6]                = is_lsiq_create0_iid[6:0];
assign lsiq_create0_data[LSIQ_OPCODE:LSIQ_OPCODE-31]         = is_lsiq_create0_data[IS_OPCODE:IS_OPCODE-31];

//operand mux for iq create
assign dp_lsiq_create1_data[LSIQ_WIDTH-1:0]                  = {LSIQ_WIDTH{ctrl_lsiq_create1_gateclk_en}}
                                                               & lsiq_create1_data[LSIQ_WIDTH-1:0];

assign dp_lsiq_create1_sti_sel                               = is_lsiq_create1_data[IS_STADDR]
                                                               && !is_lsiq_create1_data[IS_STR];

assign lsiq_create1_data[LSIQ_VL:LSIQ_VL-7]                  = is_lsiq_create1_data[IS_VL:IS_VL-7];
assign lsiq_create1_data[LSIQ_VMB]                           = is_lsiq_create1_data[IS_VMB];
assign lsiq_create1_data[LSIQ_SPLIT_NUM:LSIQ_SPLIT_NUM-6]    = is_lsiq_create1_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign lsiq_create1_data[LSIQ_VSEW:LSIQ_VSEW-2]              = is_lsiq_create1_data[IS_VSEW:IS_VSEW-2];
assign lsiq_create1_data[LSIQ_VLMUL:LSIQ_VLMUL-1]            = is_lsiq_create1_data[IS_VLMUL:IS_VLMUL-1];
assign lsiq_create1_data[LSIQ_BKPTB_DATA]                    = 1'b0;
assign lsiq_create1_data[LSIQ_BKPTA_DATA]                    = 1'b0;
assign lsiq_create1_data[LSIQ_AGEVEC_ALL:LSIQ_AGEVEC_ALL-10] = 11'b0;
assign lsiq_create1_data[LSIQ_ALREADY_DA]                    = 1'b0;
assign lsiq_create1_data[LSIQ_UNALIGN_2ND]                   = 1'b0;
assign lsiq_create1_data[LSIQ_SPEC_FAIL]                     = 1'b0;
assign lsiq_create1_data[LSIQ_NO_SPEC_EXIST]                 = lsiq_dp_no_spec_store_vld;
assign lsiq_create1_data[LSIQ_NO_SPEC]                       = is_lsiq_create1_data[IS_NO_SPEC];
assign lsiq_create1_data[LSIQ_SPLIT]                         = is_lsiq_create1_data[IS_SPLIT];
assign lsiq_create1_data[LSIQ_SDIQ_ENTRY:LSIQ_SDIQ_ENTRY-11] = is_lsiq_create1_sdiq_entry[11:0];
assign lsiq_create1_data[LSIQ_STADDR]                        = is_lsiq_create1_data[IS_STADDR];
assign lsiq_create1_data[LSIQ_PC:LSIQ_PC-14]                 = is_lsiq_create1_data[IS_LSU_PC:IS_LSU_PC-14];
assign lsiq_create1_data[LSIQ_BAR_TYPE:LSIQ_BAR_TYPE-3]      = is_lsiq_create1_data[IS_BAR_TYPE:IS_BAR_TYPE-3];
assign lsiq_create1_data[LSIQ_BAR]                           = is_lsiq_create1_data[IS_BAR];
assign lsiq_create1_data[LSIQ_STORE]                         = is_lsiq_create1_data[IS_STORE];
assign lsiq_create1_data[LSIQ_LOAD]                          = is_lsiq_create1_data[IS_LOAD];
assign lsiq_create1_data[LSIQ_SRCVM_LSU_MATCH]               = is_lsiq_create1_data[IS_SRCV1_VLD]
                                                               ? is_lsiq_create1_data[IS_SRCV1_LSU_MATCH]
                                                               : is_lsiq_create1_data[IS_SRCVM_LSU_MATCH];
assign lsiq_create1_data[LSIQ_SRCVM_DATA:LSIQ_SRCVM_DATA-8]  = is_lsiq_create1_data[IS_SRCV1_VLD]
                                                               ? is_lsiq_create1_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8]
                                                               : is_lsiq_create1_data[IS_SRCVM_DATA:IS_SRCVM_DATA-8];
assign lsiq_create1_data[LSIQ_SRC1_LSU_MATCH]                = dp_lsiq_create1_sti_sel
                                                               ? 1'b0 : is_lsiq_create1_data[IS_SRC1_LSU_MATCH];
assign lsiq_create1_data[LSIQ_SRC1_DATA:LSIQ_SRC1_DATA-8]    = dp_lsiq_create1_sti_sel
                                                               ? 9'b0000000_1_1
                                                               : is_lsiq_create1_data[IS_SRC1_DATA:IS_SRC1_DATA-8];
assign lsiq_create1_data[LSIQ_SRC0_LSU_MATCH]                = is_lsiq_create1_data[IS_SRC0_LSU_MATCH];
assign lsiq_create1_data[LSIQ_SRC0_DATA:LSIQ_SRC0_DATA-8]    = is_lsiq_create1_data[IS_SRC0_DATA:IS_SRC0_DATA-8];
assign lsiq_create1_data[LSIQ_DST_VREG:LSIQ_DST_VREG-6]      = is_lsiq_create1_data[IS_DST_VREG:IS_DST_VREG-6];
assign lsiq_create1_data[LSIQ_DST_PREG:LSIQ_DST_PREG-6]      = is_lsiq_create1_data[IS_DST_PREG:IS_DST_PREG-6];
assign lsiq_create1_data[LSIQ_DSTV_VLD]                      = is_lsiq_create1_data[IS_DSTV_VLD];
assign lsiq_create1_data[LSIQ_DST_VLD]                       = is_lsiq_create1_data[IS_DST_VLD];
assign lsiq_create1_data[LSIQ_SRCVM_VLD]                     = is_lsiq_create1_data[IS_SRCV1_VLD]
                                                               ? is_lsiq_create1_data[IS_SRCV1_VLD]
                                                               : is_lsiq_create1_data[IS_SRCVM_VLD];
assign lsiq_create1_data[LSIQ_SRC1_VLD]                      = is_lsiq_create1_data[IS_SRC1_VLD]
                                                               && !dp_lsiq_create1_sti_sel;
assign lsiq_create1_data[LSIQ_SRC0_VLD]                      = is_lsiq_create1_data[IS_SRC0_VLD];
assign lsiq_create1_data[LSIQ_IID:LSIQ_IID-6]                = is_lsiq_create1_iid[6:0];
assign lsiq_create1_data[LSIQ_OPCODE:LSIQ_OPCODE-31]         = is_lsiq_create1_data[IS_OPCODE:IS_OPCODE-31];

//agevec signal is used for oldest. for bypass inst, agevec is from create 0
//agevec[11:0] not indicate pratical agevec
assign dp_lsiq_bypass_data[LSIQ_VL:LSIQ_VL-7]                  = is_lsiq_create0_data[IS_VL:IS_VL-7];
assign dp_lsiq_bypass_data[LSIQ_VMB]                           = is_lsiq_create0_data[IS_VMB];
assign dp_lsiq_bypass_data[LSIQ_SPLIT_NUM:LSIQ_SPLIT_NUM-6]    = is_lsiq_create0_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign dp_lsiq_bypass_data[LSIQ_VSEW:LSIQ_VSEW-2]              = is_lsiq_create0_data[IS_VSEW:IS_VSEW-2];
assign dp_lsiq_bypass_data[LSIQ_VLMUL:LSIQ_VLMUL-1]            = is_lsiq_create0_data[IS_VLMUL:IS_VLMUL-1];
assign dp_lsiq_bypass_data[LSIQ_BKPTB_DATA]                    = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_BKPTA_DATA]                    = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_AGEVEC_ALL:LSIQ_AGEVEC_ALL-10] = {10'b0,!lsiq_dp_create_bypass_oldest};
assign dp_lsiq_bypass_data[LSIQ_ALREADY_DA]                    = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_UNALIGN_2ND]                   = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_SPEC_FAIL]                     = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_NO_SPEC_EXIST]                 = lsiq_dp_no_spec_store_vld;
assign dp_lsiq_bypass_data[LSIQ_NO_SPEC]                       = is_lsiq_create0_data[IS_NO_SPEC];
assign dp_lsiq_bypass_data[LSIQ_SPLIT]                         = is_lsiq_create0_data[IS_SPLIT];
assign dp_lsiq_bypass_data[LSIQ_SDIQ_ENTRY:LSIQ_SDIQ_ENTRY-11] = is_lsiq_create0_sdiq_entry[11:0];
assign dp_lsiq_bypass_data[LSIQ_STADDR]                        = is_lsiq_create0_data[IS_STADDR];
assign dp_lsiq_bypass_data[LSIQ_PC:LSIQ_PC-14]                 = is_lsiq_create0_data[IS_LSU_PC:IS_LSU_PC-14];
assign dp_lsiq_bypass_data[LSIQ_BAR_TYPE:LSIQ_BAR_TYPE-3]      = is_lsiq_create0_data[IS_BAR_TYPE:IS_BAR_TYPE-3];
assign dp_lsiq_bypass_data[LSIQ_BAR]                           = is_lsiq_create0_data[IS_BAR];
assign dp_lsiq_bypass_data[LSIQ_STORE]                         = is_lsiq_create0_data[IS_STORE];
assign dp_lsiq_bypass_data[LSIQ_LOAD]                          = is_lsiq_create0_data[IS_LOAD];
assign dp_lsiq_bypass_data[LSIQ_SRCVM_LSU_MATCH]               = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_SRCVM_VREG:LSIQ_SRCVM_VREG-6]  = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                                 ? is_lsiq_create0_data[IS_SRCV1_VREG:IS_SRCV1_VREG-6]
                                                                 : is_lsiq_create0_data[IS_SRCVM_VREG:IS_SRCVM_VREG-6];
assign dp_lsiq_bypass_data[LSIQ_SRCVM_WB]                      = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                                 ? is_lsiq_create0_data[IS_SRCV1_WB]
                                                                 : is_lsiq_create0_data[IS_SRCVM_WB];
assign dp_lsiq_bypass_data[LSIQ_SRCVM_RDY]                     = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_SRC1_LSU_MATCH]                = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_SRC1_PREG:LSIQ_SRC1_PREG-6]    = is_lsiq_create0_data[IS_SRC1_PREG:IS_SRC1_PREG-6];
assign dp_lsiq_bypass_data[LSIQ_SRC1_WB]                       = is_lsiq_create0_data[IS_SRC1_WB]
                                                              || dp_lsiq_create0_sti_sel;
assign dp_lsiq_bypass_data[LSIQ_SRC1_RDY]                      = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_SRC0_LSU_MATCH]                = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_SRC0_PREG:LSIQ_SRC0_PREG-6]    = is_lsiq_create0_data[IS_SRC0_PREG:IS_SRC0_PREG-6];
assign dp_lsiq_bypass_data[LSIQ_SRC0_WB]                       = is_lsiq_create0_data[IS_SRC0_WB];
assign dp_lsiq_bypass_data[LSIQ_SRC0_RDY]                      = 1'b0;
assign dp_lsiq_bypass_data[LSIQ_DST_VREG:LSIQ_DST_VREG-6]      = is_lsiq_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign dp_lsiq_bypass_data[LSIQ_DST_PREG:LSIQ_DST_PREG-6]      = is_lsiq_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign dp_lsiq_bypass_data[LSIQ_DSTV_VLD]                      = is_lsiq_create0_data[IS_DSTV_VLD];
assign dp_lsiq_bypass_data[LSIQ_DST_VLD]                       = is_lsiq_create0_data[IS_DST_VLD];
assign dp_lsiq_bypass_data[LSIQ_SRCVM_VLD]                     = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                                 ? is_lsiq_create0_data[IS_SRCV1_VLD]
                                                                 : is_lsiq_create0_data[IS_SRCVM_VLD];
assign dp_lsiq_bypass_data[LSIQ_SRC1_VLD]                      = is_lsiq_create0_data[IS_SRC1_VLD]
                                                             && !dp_lsiq_create0_sti_sel;
assign dp_lsiq_bypass_data[LSIQ_SRC0_VLD]                      = is_lsiq_create0_data[IS_SRC0_VLD];
assign dp_lsiq_bypass_data[LSIQ_IID:LSIQ_IID-6]                = is_lsiq_create0_iid[6:0];
assign dp_lsiq_bypass_data[LSIQ_OPCODE:LSIQ_OPCODE-31]         = is_lsiq_create0_data[IS_OPCODE:IS_OPCODE-31];

assign dp_lsiq_create0_src0_rdy_for_bypass                     = is_lsiq_create0_data[IS_SRC0_BP_RDY];
assign dp_lsiq_create0_src1_rdy_for_bypass                     = is_lsiq_create0_data[IS_SRC1_BP_RDY]
                                                                 || dp_lsiq_create0_sti_sel;
assign dp_lsiq_create0_srcvm_rdy_for_bypass                    = is_lsiq_create0_data[IS_SRCV1_VLD]
                                                                 ? is_lsiq_create0_data[IS_SRCV1_BP_RDY]
                                                                 : is_lsiq_create0_data[IS_SRCVM_BP_RDY];

assign dp_lsiq_create0_load                                    = is_lsiq_create0_data[IS_LOAD];
assign dp_lsiq_create0_store                                   = is_lsiq_create0_data[IS_STORE];
assign dp_lsiq_create0_bar                                     = is_lsiq_create0_data[IS_BAR];
assign dp_lsiq_create0_no_spec                                 = is_lsiq_create0_data[IS_NO_SPEC];

assign dp_lsiq_create1_load                                    = is_lsiq_create1_data[IS_LOAD];
assign dp_lsiq_create1_store                                   = is_lsiq_create1_data[IS_STORE];
assign dp_lsiq_create1_bar                                     = is_lsiq_create1_data[IS_BAR];
assign dp_lsiq_create1_no_spec                                 = is_lsiq_create1_data[IS_NO_SPEC];

//----------------------------------------------------------
//                  Create Data for SDIQ
//----------------------------------------------------------
// &CombBeg; @3549
always @( is_inst1_read_data[270:0]
       or ctrl_dp_is_dis_sdiq_create0_sel[1:0]
       or is_inst0_read_data[270:0]
       or is_inst3_read_data[270:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_sdiq_create0_sel[1:0])
    2'd0: is_sdiq_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
    2'd1: is_sdiq_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
    2'd2: is_sdiq_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
    2'd3: is_sdiq_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
    default: is_sdiq_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
  endcase
// &CombEnd; @3557
end

// &CombBeg; @3559
always @( is_inst1_read_data[270:0]
       or is_inst3_read_data[270:0]
       or ctrl_dp_is_dis_sdiq_create1_sel[1:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_sdiq_create1_sel[1:0])
    2'd1: is_sdiq_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
    2'd2: is_sdiq_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
    2'd3: is_sdiq_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
    default: is_sdiq_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
  endcase
// &CombEnd; @3566
end

//----------------------------------------------------------
//                Reorganize for SDIQ create
//----------------------------------------------------------
//operand mux for iq create
assign dp_sdiq_create0_data[SDIQ_WIDTH-1:0] = {SDIQ_WIDTH{ctrl_sdiq_create0_gateclk_en}}
                                              & sdiq_create0_data[SDIQ_WIDTH-1:0];

assign dp_sdiq_create0_sti_sel              = !is_sdiq_create0_data[IS_STR];
assign dp_aiq_sdiq_create0_src_sel          = dp_sdiq_create0_sti_sel;

assign sdiq_create0_data[SDIQ_LOAD]                         = is_sdiq_create0_data[IS_LOAD];
assign sdiq_create0_data[SDIQ_STADDR1_IN_STQ]               = 1'b0;
assign sdiq_create0_data[SDIQ_STADDR0_IN_STQ]               = 1'b0;
assign sdiq_create0_data[SDIQ_STDATA1_VLD]                  = 1'b0;
assign sdiq_create0_data[SDIQ_UNALIGN]                      = 1'b0;
assign sdiq_create0_data[SDIQ_SRCV0_LSU_MATCH]              = is_sdiq_create0_data[IS_SRCV2_LSU_MATCH];
assign sdiq_create0_data[SDIQ_SRCV0_DATA:SDIQ_SRCV0_DATA-8] = is_sdiq_create0_data[IS_SRCV2_DATA-1:IS_SRCV2_DATA-9];
assign sdiq_create0_data[SDIQ_SRC0_LSU_MATCH]               = dp_sdiq_create0_sti_sel
                                                              ? is_sdiq_create0_data[IS_SRC1_LSU_MATCH]
                                                              : is_sdiq_create0_data[IS_SRC2_LSU_MATCH];
assign sdiq_create0_data[SDIQ_SRC0_DATA:SDIQ_SRC0_DATA-8]   = dp_sdiq_create0_sti_sel
                                                              ? is_sdiq_create0_data[IS_SRC1_DATA:IS_SRC1_DATA-8]
                                                              : is_sdiq_create0_data[IS_SRC2_DATA-1:IS_SRC2_DATA-9];
assign sdiq_create0_data[SDIQ_SRCV0_VLD]                    = is_sdiq_create0_data[IS_SRCV2_VLD];
assign sdiq_create0_data[SDIQ_SRC0_VLD]                     = dp_sdiq_create0_sti_sel
                                                              ? is_sdiq_create0_data[IS_SRC1_VLD]
                                                              : is_sdiq_create0_data[IS_SRC2_VLD];

//operand mux for iq create
assign dp_sdiq_create1_data[SDIQ_WIDTH-1:0] = {SDIQ_WIDTH{ctrl_sdiq_create1_gateclk_en}}
                                              & sdiq_create1_data[SDIQ_WIDTH-1:0];

assign dp_sdiq_create1_sti_sel              = !is_sdiq_create1_data[IS_STR];
assign dp_aiq_sdiq_create1_src_sel          = dp_sdiq_create1_sti_sel;

assign sdiq_create1_data[SDIQ_LOAD]                         = is_sdiq_create1_data[IS_LOAD];
assign sdiq_create1_data[SDIQ_STADDR1_IN_STQ]               = 1'b0;
assign sdiq_create1_data[SDIQ_STADDR0_IN_STQ]               = 1'b0;
assign sdiq_create1_data[SDIQ_STDATA1_VLD]                  = 1'b0;
assign sdiq_create1_data[SDIQ_UNALIGN]                      = 1'b0;
assign sdiq_create1_data[SDIQ_SRCV0_LSU_MATCH]              = is_sdiq_create1_data[IS_SRCV2_LSU_MATCH];
assign sdiq_create1_data[SDIQ_SRCV0_DATA:SDIQ_SRCV0_DATA-8] = is_sdiq_create1_data[IS_SRCV2_DATA-1:IS_SRCV2_DATA-9];
assign sdiq_create1_data[SDIQ_SRC0_LSU_MATCH]               = dp_sdiq_create1_sti_sel
                                                              ? is_sdiq_create1_data[IS_SRC1_LSU_MATCH]
                                                              : is_sdiq_create1_data[IS_SRC2_LSU_MATCH];
assign sdiq_create1_data[SDIQ_SRC0_DATA:SDIQ_SRC0_DATA-8]   = dp_sdiq_create1_sti_sel
                                                              ? is_sdiq_create1_data[IS_SRC1_DATA:IS_SRC1_DATA-8]
                                                              : is_sdiq_create1_data[IS_SRC2_DATA-1:IS_SRC2_DATA-9];
assign sdiq_create1_data[SDIQ_SRCV0_VLD]                    = is_sdiq_create1_data[IS_SRCV2_VLD];
assign sdiq_create1_data[SDIQ_SRC0_VLD]                     = dp_sdiq_create1_sti_sel
                                                              ? is_sdiq_create1_data[IS_SRC1_VLD]
                                                              : is_sdiq_create1_data[IS_SRC2_VLD];

//----------------------------------------------------------
//                  Create Data for VIQ0
//----------------------------------------------------------
// &CombBeg; @3624
always @( is_inst2_lch_rdy_viq0[7:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_iid[6:0]
       or is_inst1_lch_rdy_viq0[7:0]
       or is_inst1_read_data[270:0]
       or ctrl_dp_is_dis_viq0_create0_sel[1:0]
       or is_inst2_lch_rdy_viq1[7:0]
       or is_inst1_lch_rdy_viq1[7:0]
       or is_inst3_lch_rdy_viq0[7:0]
       or is_inst0_read_data[270:0]
       or is_inst3_lch_rdy_viq1[7:0]
       or is_inst3_read_data[270:0]
       or is_inst0_lch_rdy_viq1[7:0]
       or is_inst2_iid[6:0]
       or is_inst0_lch_rdy_viq0[7:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_viq0_create0_sel[1:0])
    2'd0: begin
          is_viq0_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_viq0_create0_iid[6:0]           = is_inst0_iid[6:0];
          is_viq0_create0_lch_rdy_viq0[7:0]  = is_inst0_lch_rdy_viq0[7:0];
          is_viq0_create0_lch_rdy_viq1[7:0]  = is_inst0_lch_rdy_viq1[7:0];
          end
    2'd1: begin
          is_viq0_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_viq0_create0_iid[6:0]           = is_inst1_iid[6:0];
          is_viq0_create0_lch_rdy_viq0[7:0]  = is_inst1_lch_rdy_viq0[7:0];
          is_viq0_create0_lch_rdy_viq1[7:0]  = is_inst1_lch_rdy_viq1[7:0];
          end
    2'd2: begin
          is_viq0_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_viq0_create0_iid[6:0]           = is_inst2_iid[6:0];
          is_viq0_create0_lch_rdy_viq0[7:0]  = is_inst2_lch_rdy_viq0[7:0];
          is_viq0_create0_lch_rdy_viq1[7:0]  = is_inst2_lch_rdy_viq1[7:0];
          end
    2'd3: begin
          is_viq0_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_viq0_create0_iid[6:0]           = is_inst3_iid[6:0];
          is_viq0_create0_lch_rdy_viq0[7:0]  = is_inst3_lch_rdy_viq0[7:0];
          is_viq0_create0_lch_rdy_viq1[7:0]  = is_inst3_lch_rdy_viq1[7:0];
          end
    default: begin
          is_viq0_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_viq0_create0_iid[6:0]           = {7{1'bx}};
          is_viq0_create0_lch_rdy_viq0[7:0]  = {8{1'bx}};
          is_viq0_create0_lch_rdy_viq1[7:0]  = {8{1'bx}};
          end
  endcase
// &CombEnd; @3657
end

// &CombBeg; @3659
always @( is_inst2_lch_rdy_viq0[7:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_iid[6:0]
       or is_inst1_lch_rdy_viq0[7:0]
       or is_inst1_read_data[270:0]
       or ctrl_dp_is_dis_viq0_create1_sel[1:0]
       or is_inst2_lch_rdy_viq1[7:0]
       or is_inst1_lch_rdy_viq1[7:0]
       or is_inst3_lch_rdy_viq0[7:0]
       or is_inst0_read_data[270:0]
       or is_inst3_lch_rdy_viq1[7:0]
       or is_inst3_read_data[270:0]
       or is_inst0_lch_rdy_viq1[7:0]
       or is_inst2_iid[6:0]
       or is_inst0_lch_rdy_viq0[7:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_viq0_create1_sel[1:0])
    2'd0: begin
          is_viq0_create1_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_viq0_create1_iid[6:0]           = is_inst0_iid[6:0];
          is_viq0_create1_lch_rdy_viq0[7:0]  = is_inst0_lch_rdy_viq0[7:0];
          is_viq0_create1_lch_rdy_viq1[7:0]  = is_inst0_lch_rdy_viq1[7:0];
          end
    2'd1: begin
          is_viq0_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_viq0_create1_iid[6:0]           = is_inst1_iid[6:0];
          is_viq0_create1_lch_rdy_viq0[7:0]  = is_inst1_lch_rdy_viq0[7:0];
          is_viq0_create1_lch_rdy_viq1[7:0]  = is_inst1_lch_rdy_viq1[7:0];
          end
    2'd2: begin
          is_viq0_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_viq0_create1_iid[6:0]           = is_inst2_iid[6:0];
          is_viq0_create1_lch_rdy_viq0[7:0]  = is_inst2_lch_rdy_viq0[7:0];
          is_viq0_create1_lch_rdy_viq1[7:0]  = is_inst2_lch_rdy_viq1[7:0];
          end
    2'd3: begin
          is_viq0_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_viq0_create1_iid[6:0]           = is_inst3_iid[6:0];
          is_viq0_create1_lch_rdy_viq0[7:0]  = is_inst3_lch_rdy_viq0[7:0];
          is_viq0_create1_lch_rdy_viq1[7:0]  = is_inst3_lch_rdy_viq1[7:0];
          end
    default: begin
          is_viq0_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_viq0_create1_iid[6:0]           = {7{1'bx}};
          is_viq0_create1_lch_rdy_viq0[7:0]  = {8{1'bx}};
          is_viq0_create1_lch_rdy_viq1[7:0]  = {8{1'bx}};
          end
  endcase
// &CombEnd; @3692
end

//----------------------------------------------------------
//                Reorganize for VIQ0 create
//----------------------------------------------------------
//operand mux for iq create
assign dp_viq0_create0_data[VIQ0_WIDTH-1:0] = {VIQ0_WIDTH{ctrl_viq0_create0_gateclk_en}}
                                              & viq0_create0_data[VIQ0_WIDTH-1:0];

assign viq0_create0_data[VIQ0_VL:VIQ0_VL-7]                     = is_viq0_create0_data[IS_VL:IS_VL-7];
assign viq0_create0_data[VIQ0_VSEW:VIQ0_VSEW-2]                 = is_viq0_create0_data[IS_VSEW:IS_VSEW-2];
assign viq0_create0_data[VIQ0_VLMUL:VIQ0_VLMUL-1]               = is_viq0_create0_data[IS_VLMUL:IS_VLMUL-1];
assign viq0_create0_data[VIQ0_VMUL]                             = is_viq0_create0_data[IS_VMUL];
assign viq0_create0_data[VIQ0_VMLA_SHORT]                       = is_viq0_create0_data[IS_VMLA_SHORT];
assign viq0_create0_data[VIQ0_VDIV]                             = is_viq0_create0_data[IS_VDIV];
assign viq0_create0_data[VIQ0_LCH_RDY_VIQ1:VIQ0_LCH_RDY_VIQ1-7] = is_viq0_create0_lch_rdy_viq1[7:0];
assign viq0_create0_data[VIQ0_LCH_RDY_VIQ0:VIQ0_LCH_RDY_VIQ0-7] = is_viq0_create0_lch_rdy_viq0[7:0];
assign viq0_create0_data[VIQ0_VMLA_TYPE:VIQ0_VMLA_TYPE-2]       = is_viq0_create0_data[IS_VMLA_TYPE:IS_VMLA_TYPE-2];
assign viq0_create0_data[VIQ0_SPLIT_NUM:VIQ0_SPLIT_NUM-6]       = is_viq0_create0_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign viq0_create0_data[VIQ0_SPLIT_LAST]                       = is_viq0_create0_data[IS_SPLIT_LAST];
assign viq0_create0_data[VIQ0_MFVR]                             = is_viq0_create0_data[IS_MFVR];
assign viq0_create0_data[VIQ0_VMLA]                             = is_viq0_create0_data[IS_VMLA];
assign viq0_create0_data[VIQ0_SRCVM_DATA]                       = is_viq0_create0_data[IS_SRCVM_LSU_MATCH];
assign viq0_create0_data[VIQ0_SRCVM_DATA-1:VIQ0_SRCVM_DATA-9]   = is_viq0_create0_data[IS_SRCVM_DATA:IS_SRCVM_DATA-8];
assign viq0_create0_data[VIQ0_SRCV2_DATA]                       = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create0_data[IS_SRCV1_LSU_MATCH]
                                                                  : is_viq0_create0_data[IS_SRCV2_LSU_MATCH];
assign viq0_create0_data[VIQ0_SRCV2_DATA-1:VIQ0_SRCV2_DATA-10]  = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? {1'b0,is_viq0_create0_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8]}
                                                                  : is_viq0_create0_data[IS_SRCV2_DATA:IS_SRCV2_DATA-9];
assign viq0_create0_data[VIQ0_SRCV1_DATA]                       = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create0_data[IS_SRCV2_LSU_MATCH]
                                                                  : is_viq0_create0_data[IS_SRCV1_LSU_MATCH];
assign viq0_create0_data[VIQ0_SRCV1_DATA-1:VIQ0_SRCV1_DATA-9]   = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create0_data[IS_SRCV2_DATA-1:IS_SRCV2_DATA-9]
                                                                  : is_viq0_create0_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8];
assign viq0_create0_data[VIQ0_SRCV0_DATA]                       = is_viq0_create0_data[IS_SRCV0_LSU_MATCH];
assign viq0_create0_data[VIQ0_SRCV0_DATA-1:VIQ0_SRCV0_DATA-9]   = is_viq0_create0_data[IS_SRCV0_DATA:IS_SRCV0_DATA-8];
assign viq0_create0_data[VIQ0_DST_EREG:VIQ0_DST_EREG-4]         = is_viq0_create0_data[IS_DST_EREG:IS_DST_EREG-4];
assign viq0_create0_data[VIQ0_DST_VREG:VIQ0_DST_VREG-6]         = is_viq0_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign viq0_create0_data[VIQ0_DST_PREG:VIQ0_DST_PREG-6]         = is_viq0_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign viq0_create0_data[VIQ0_DSTE_VLD]                         = is_viq0_create0_data[IS_DSTE_VLD];
assign viq0_create0_data[VIQ0_DSTV_VLD]                         = is_viq0_create0_data[IS_DSTV_VLD];
assign viq0_create0_data[VIQ0_DST_VLD]                          = is_viq0_create0_data[IS_DST_VLD];
assign viq0_create0_data[VIQ0_SRCVM_VLD]                        = is_viq0_create0_data[IS_SRCVM_VLD];
assign viq0_create0_data[VIQ0_SRCV2_VLD]                        = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create0_data[IS_SRCV1_VLD]
                                                                  : is_viq0_create0_data[IS_SRCV2_VLD];
assign viq0_create0_data[VIQ0_SRCV1_VLD]                        = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create0_data[IS_SRCV2_VLD]
                                                                  : is_viq0_create0_data[IS_SRCV1_VLD];
assign viq0_create0_data[VIQ0_SRCV0_VLD]                        = is_viq0_create0_data[IS_SRCV0_VLD];
assign viq0_create0_data[VIQ0_IID:VIQ0_IID-6]                   = is_viq0_create0_iid[6:0];
assign viq0_create0_data[VIQ0_OPCODE:VIQ0_OPCODE-31]            = is_viq0_create0_data[IS_OPCODE:IS_OPCODE-31];

//operand mux for iq create
assign dp_viq0_create1_data[VIQ0_WIDTH-1:0] = {VIQ0_WIDTH{ctrl_viq0_create1_gateclk_en}}
                                              & viq0_create1_data[VIQ0_WIDTH-1:0];

assign viq0_create1_data[VIQ0_VL:VIQ0_VL-7]                     = is_viq0_create1_data[IS_VL:IS_VL-7];
assign viq0_create1_data[VIQ0_VSEW:VIQ0_VSEW-2]                 = is_viq0_create1_data[IS_VSEW:IS_VSEW-2];
assign viq0_create1_data[VIQ0_VLMUL:VIQ0_VLMUL-1]               = is_viq0_create1_data[IS_VLMUL:IS_VLMUL-1];
assign viq0_create1_data[VIQ0_VMUL]                             = is_viq0_create1_data[IS_VMUL];
assign viq0_create1_data[VIQ0_VMLA_SHORT]                       = is_viq0_create1_data[IS_VMLA_SHORT];
assign viq0_create1_data[VIQ0_LCH_RDY_VIQ1:VIQ0_LCH_RDY_VIQ1-7] = is_viq0_create1_lch_rdy_viq1[7:0];
assign viq0_create1_data[VIQ0_LCH_RDY_VIQ0:VIQ0_LCH_RDY_VIQ0-7] = is_viq0_create1_lch_rdy_viq0[7:0];
assign viq0_create1_data[VIQ0_VMLA_TYPE:VIQ0_VMLA_TYPE-2]       = is_viq0_create1_data[IS_VMLA_TYPE:IS_VMLA_TYPE-2];
assign viq0_create1_data[VIQ0_SPLIT_NUM:VIQ0_SPLIT_NUM-6]       = is_viq0_create1_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign viq0_create1_data[VIQ0_SPLIT_LAST]                       = is_viq0_create1_data[IS_SPLIT_LAST];
assign viq0_create1_data[VIQ0_MFVR]                             = is_viq0_create1_data[IS_MFVR];
assign viq0_create1_data[VIQ0_VMLA]                             = is_viq0_create1_data[IS_VMLA];
assign viq0_create1_data[VIQ0_VDIV]                             = is_viq0_create1_data[IS_VDIV];
assign viq0_create1_data[VIQ0_SRCVM_DATA]                       = is_viq0_create1_data[IS_SRCVM_LSU_MATCH];
assign viq0_create1_data[VIQ0_SRCVM_DATA-1:VIQ0_SRCVM_DATA-9]   = is_viq0_create1_data[IS_SRCVM_DATA:IS_SRCVM_DATA-8];
assign viq0_create1_data[VIQ0_SRCV2_DATA]                       = is_viq0_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create1_data[IS_SRCV1_LSU_MATCH]
                                                                  : is_viq0_create1_data[IS_SRCV2_LSU_MATCH];
assign viq0_create1_data[VIQ0_SRCV2_DATA-1:VIQ0_SRCV2_DATA-10]  = is_viq0_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? {1'b0,is_viq0_create1_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8]}
                                                                  : is_viq0_create1_data[IS_SRCV2_DATA:IS_SRCV2_DATA-9];
assign viq0_create1_data[VIQ0_SRCV1_DATA]                       = is_viq0_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create1_data[IS_SRCV2_LSU_MATCH]
                                                                  : is_viq0_create1_data[IS_SRCV1_LSU_MATCH];
assign viq0_create1_data[VIQ0_SRCV1_DATA-1:VIQ0_SRCV1_DATA-9]   = is_viq0_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create1_data[IS_SRCV2_DATA-1:IS_SRCV2_DATA-9]
                                                                  : is_viq0_create1_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8];
assign viq0_create1_data[VIQ0_SRCV0_DATA]                       = is_viq0_create1_data[IS_SRCV0_LSU_MATCH];
assign viq0_create1_data[VIQ0_SRCV0_DATA-1:VIQ0_SRCV0_DATA-9]   = is_viq0_create1_data[IS_SRCV0_DATA:IS_SRCV0_DATA-8];
assign viq0_create1_data[VIQ0_DST_EREG:VIQ0_DST_EREG-4]         = is_viq0_create1_data[IS_DST_EREG:IS_DST_EREG-4];
assign viq0_create1_data[VIQ0_DST_VREG:VIQ0_DST_VREG-6]         = is_viq0_create1_data[IS_DST_VREG:IS_DST_VREG-6];
assign viq0_create1_data[VIQ0_DST_PREG:VIQ0_DST_PREG-6]         = is_viq0_create1_data[IS_DST_PREG:IS_DST_PREG-6];
assign viq0_create1_data[VIQ0_DSTE_VLD]                         = is_viq0_create1_data[IS_DSTE_VLD];
assign viq0_create1_data[VIQ0_DSTV_VLD]                         = is_viq0_create1_data[IS_DSTV_VLD];
assign viq0_create1_data[VIQ0_DST_VLD]                          = is_viq0_create1_data[IS_DST_VLD];
assign viq0_create1_data[VIQ0_SRCVM_VLD]                        = is_viq0_create1_data[IS_SRCVM_VLD];
assign viq0_create1_data[VIQ0_SRCV2_VLD]                        = is_viq0_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create1_data[IS_SRCV1_VLD]
                                                                  : is_viq0_create1_data[IS_SRCV2_VLD];
assign viq0_create1_data[VIQ0_SRCV1_VLD]                        = is_viq0_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq0_create1_data[IS_SRCV2_VLD]
                                                                  : is_viq0_create1_data[IS_SRCV1_VLD];
assign viq0_create1_data[VIQ0_SRCV0_VLD]                        = is_viq0_create1_data[IS_SRCV0_VLD];
assign viq0_create1_data[VIQ0_IID:VIQ0_IID-6]                   = is_viq0_create1_iid[6:0];
assign viq0_create1_data[VIQ0_OPCODE:VIQ0_OPCODE-31]            = is_viq0_create1_data[IS_OPCODE:IS_OPCODE-31];

assign dp_viq0_bypass_data[VIQ0_VL:VIQ0_VL-7]                      = is_viq0_create0_data[IS_VL:IS_VL-7];
assign dp_viq0_bypass_data[VIQ0_VSEW:VIQ0_VSEW-2]                  = is_viq0_create0_data[IS_VSEW:IS_VSEW-2];
assign dp_viq0_bypass_data[VIQ0_VLMUL:VIQ0_VLMUL-1]                = is_viq0_create0_data[IS_VLMUL:IS_VLMUL-1];
assign dp_viq0_bypass_data[VIQ0_VMUL]                              = is_viq0_create0_data[IS_VMUL];
assign dp_viq0_bypass_data[VIQ0_VMLA_SHORT]                        = is_viq0_create0_data[IS_VMLA_SHORT];
assign dp_viq0_bypass_data[VIQ0_LCH_RDY_VIQ1:VIQ0_LCH_RDY_VIQ1-7]  = is_viq0_create0_lch_rdy_viq1[7:0];
assign dp_viq0_bypass_data[VIQ0_LCH_RDY_VIQ0:VIQ0_LCH_RDY_VIQ0-7]  = is_viq0_create0_lch_rdy_viq0[7:0];
assign dp_viq0_bypass_data[VIQ0_VMLA_TYPE:VIQ0_VMLA_TYPE-2]        = is_viq0_create0_data[IS_VMLA_TYPE:IS_VMLA_TYPE-2];
assign dp_viq0_bypass_data[VIQ0_SPLIT_NUM:VIQ0_SPLIT_NUM-6]        = is_viq0_create0_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign dp_viq0_bypass_data[VIQ0_SPLIT_LAST]                        = is_viq0_create0_data[IS_SPLIT_LAST];
assign dp_viq0_bypass_data[VIQ0_MFVR]                              = is_viq0_create0_data[IS_MFVR];
assign dp_viq0_bypass_data[VIQ0_VMLA]                              = is_viq0_create0_data[IS_VMLA];
assign dp_viq0_bypass_data[VIQ0_VDIV]                              = is_viq0_create0_data[IS_VDIV];
assign dp_viq0_bypass_data[VIQ0_SRCVM_LSU_MATCH]                   = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCVM_VREG:VIQ0_SRCVM_VREG-6]      = is_viq0_create0_data[IS_SRCVM_VREG:IS_SRCVM_VREG-6];
assign dp_viq0_bypass_data[VIQ0_SRCVM_WB]                          = is_viq0_create0_data[IS_SRCVM_WB];
assign dp_viq0_bypass_data[VIQ0_SRCVM_RDY]                         = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV2_LSU_MATCH]                   = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV2_DATA-1]                      = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV2_VREG:VIQ0_SRCV2_VREG-6]      = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq0_create0_data[IS_SRCV1_VREG:IS_SRCV1_VREG-6]
                                                                     : is_viq0_create0_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6];
assign dp_viq0_bypass_data[VIQ0_SRCV2_WB]                          = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq0_create0_data[IS_SRCV1_WB]
                                                                     : is_viq0_create0_data[IS_SRCV2_WB];
assign dp_viq0_bypass_data[VIQ0_SRCV2_RDY]                         = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV1_LSU_MATCH]                   = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV1_VREG:VIQ0_SRCV1_VREG-6]      = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq0_create0_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6]
                                                                     : is_viq0_create0_data[IS_SRCV1_VREG:IS_SRCV1_VREG-6];
assign dp_viq0_bypass_data[VIQ0_SRCV1_WB]                          = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq0_create0_data[IS_SRCV2_WB]
                                                                     : is_viq0_create0_data[IS_SRCV1_WB];
assign dp_viq0_bypass_data[VIQ0_SRCV1_RDY]                         = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV0_LSU_MATCH]                   = 1'b0;
assign dp_viq0_bypass_data[VIQ0_SRCV0_VREG:VIQ0_SRCV0_VREG-6]      = is_viq0_create0_data[IS_SRCV0_VREG:IS_SRCV0_VREG-6];
assign dp_viq0_bypass_data[VIQ0_SRCV0_WB]                          = is_viq0_create0_data[IS_SRCV0_WB];
assign dp_viq0_bypass_data[VIQ0_SRCV0_RDY]                         = 1'b0;
assign dp_viq0_bypass_data[VIQ0_DST_EREG:VIQ0_DST_EREG-4]          = is_viq0_create0_data[IS_DST_EREG:IS_DST_EREG-4];
assign dp_viq0_bypass_data[VIQ0_DST_VREG:VIQ0_DST_VREG-6]          = is_viq0_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign dp_viq0_bypass_data[VIQ0_DST_PREG:VIQ0_DST_PREG-6]          = is_viq0_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign dp_viq0_bypass_data[VIQ0_DSTE_VLD]                          = is_viq0_create0_data[IS_DSTE_VLD];
assign dp_viq0_bypass_data[VIQ0_DSTV_VLD]                          = is_viq0_create0_data[IS_DSTV_VLD];
assign dp_viq0_bypass_data[VIQ0_DST_VLD]                           = is_viq0_create0_data[IS_DST_VLD];
assign dp_viq0_bypass_data[VIQ0_SRCVM_VLD]                         = is_viq0_create0_data[IS_SRCVM_VLD];
assign dp_viq0_bypass_data[VIQ0_SRCV2_VLD]                         = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq0_create0_data[IS_SRCV1_VLD]
                                                                     : is_viq0_create0_data[IS_SRCV2_VLD];
assign dp_viq0_bypass_data[VIQ0_SRCV1_VLD]                         = is_viq0_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq0_create0_data[IS_SRCV2_VLD]
                                                                     : is_viq0_create0_data[IS_SRCV1_VLD];
assign dp_viq0_bypass_data[VIQ0_SRCV0_VLD]                         = is_viq0_create0_data[IS_SRCV0_VLD];
assign dp_viq0_bypass_data[VIQ0_IID:VIQ0_IID-6]                    = is_viq0_create0_iid[6:0];
assign dp_viq0_bypass_data[VIQ0_OPCODE:VIQ0_OPCODE-31]             = is_viq0_create0_data[IS_OPCODE:IS_OPCODE-31];

assign dp_viq0_create_srcv0_rdy_for_bypass = is_viq0_create0_data[IS_SRCV0_BP_RDY];
assign dp_viq0_create_srcv1_rdy_for_bypass = is_viq0_create0_data[IS_SRCV1_BP_RDY];
assign dp_viq0_create_srcv2_rdy_for_bypass = is_viq0_create0_data[IS_SRCV2_BP_RDY];
assign dp_viq0_create_srcvm_rdy_for_bypass = is_viq0_create0_data[IS_SRCVM_BP_RDY];
assign dp_viq0_create_vdiv                 = is_viq0_create0_data[IS_VDIV];

//----------------------------------------------------------
//                  Create Data for VIQ1
//----------------------------------------------------------
// &CombBeg; @3861
always @( is_inst2_lch_rdy_viq0[7:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_iid[6:0]
       or is_inst1_lch_rdy_viq0[7:0]
       or is_inst1_read_data[270:0]
       or is_inst2_lch_rdy_viq1[7:0]
       or is_inst1_lch_rdy_viq1[7:0]
       or ctrl_dp_is_dis_viq1_create0_sel[1:0]
       or is_inst3_lch_rdy_viq0[7:0]
       or is_inst0_read_data[270:0]
       or is_inst3_lch_rdy_viq1[7:0]
       or is_inst3_read_data[270:0]
       or is_inst0_lch_rdy_viq1[7:0]
       or is_inst2_iid[6:0]
       or is_inst0_lch_rdy_viq0[7:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_viq1_create0_sel[1:0])
    2'd0: begin
          is_viq1_create0_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_viq1_create0_iid[6:0]           = is_inst0_iid[6:0];
          is_viq1_create0_lch_rdy_viq0[7:0]  = is_inst0_lch_rdy_viq0[7:0];
          is_viq1_create0_lch_rdy_viq1[7:0]  = is_inst0_lch_rdy_viq1[7:0];
          end
    2'd1: begin
          is_viq1_create0_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_viq1_create0_iid[6:0]           = is_inst1_iid[6:0];
          is_viq1_create0_lch_rdy_viq0[7:0]  = is_inst1_lch_rdy_viq0[7:0];
          is_viq1_create0_lch_rdy_viq1[7:0]  = is_inst1_lch_rdy_viq1[7:0];
          end
    2'd2: begin
          is_viq1_create0_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_viq1_create0_iid[6:0]           = is_inst2_iid[6:0];
          is_viq1_create0_lch_rdy_viq0[7:0]  = is_inst2_lch_rdy_viq0[7:0];
          is_viq1_create0_lch_rdy_viq1[7:0]  = is_inst2_lch_rdy_viq1[7:0];
          end
    2'd3: begin
          is_viq1_create0_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_viq1_create0_iid[6:0]           = is_inst3_iid[6:0];
          is_viq1_create0_lch_rdy_viq0[7:0]  = is_inst3_lch_rdy_viq0[7:0];
          is_viq1_create0_lch_rdy_viq1[7:0]  = is_inst3_lch_rdy_viq1[7:0];
          end
    default: begin
          is_viq1_create0_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_viq1_create0_iid[6:0]           = {7{1'bx}};
          is_viq1_create0_lch_rdy_viq0[7:0]  = {8{1'b1}};
          is_viq1_create0_lch_rdy_viq1[7:0]  = {8{1'b1}};
          end
  endcase
// &CombEnd; @3894
end

// &CombBeg; @3896
always @( is_inst2_lch_rdy_viq0[7:0]
       or is_inst0_iid[6:0]
       or is_inst3_iid[6:0]
       or is_inst1_iid[6:0]
       or is_inst1_lch_rdy_viq0[7:0]
       or is_inst1_read_data[270:0]
       or is_inst2_lch_rdy_viq1[7:0]
       or is_inst1_lch_rdy_viq1[7:0]
       or is_inst3_lch_rdy_viq0[7:0]
       or is_inst0_read_data[270:0]
       or is_inst3_lch_rdy_viq1[7:0]
       or is_inst3_read_data[270:0]
       or is_inst0_lch_rdy_viq1[7:0]
       or ctrl_dp_is_dis_viq1_create1_sel[1:0]
       or is_inst2_iid[6:0]
       or is_inst0_lch_rdy_viq0[7:0]
       or is_inst2_read_data[270:0])
begin
  case(ctrl_dp_is_dis_viq1_create1_sel[1:0])
    2'd0: begin
          is_viq1_create1_data[IS_WIDTH-1:0] = is_inst0_read_data[IS_WIDTH-1:0];
          is_viq1_create1_iid[6:0]           = is_inst0_iid[6:0];
          is_viq1_create1_lch_rdy_viq0[7:0]  = is_inst0_lch_rdy_viq0[7:0];
          is_viq1_create1_lch_rdy_viq1[7:0]  = is_inst0_lch_rdy_viq1[7:0];
          end
    2'd1: begin
          is_viq1_create1_data[IS_WIDTH-1:0] = is_inst1_read_data[IS_WIDTH-1:0];
          is_viq1_create1_iid[6:0]           = is_inst1_iid[6:0];
          is_viq1_create1_lch_rdy_viq0[7:0]  = is_inst1_lch_rdy_viq0[7:0];
          is_viq1_create1_lch_rdy_viq1[7:0]  = is_inst1_lch_rdy_viq1[7:0];
          end
    2'd2: begin
          is_viq1_create1_data[IS_WIDTH-1:0] = is_inst2_read_data[IS_WIDTH-1:0];
          is_viq1_create1_iid[6:0]           = is_inst2_iid[6:0];
          is_viq1_create1_lch_rdy_viq0[7:0]  = is_inst2_lch_rdy_viq0[7:0];
          is_viq1_create1_lch_rdy_viq1[7:0]  = is_inst2_lch_rdy_viq1[7:0];
          end
    2'd3: begin
          is_viq1_create1_data[IS_WIDTH-1:0] = is_inst3_read_data[IS_WIDTH-1:0];
          is_viq1_create1_iid[6:0]           = is_inst3_iid[6:0];
          is_viq1_create1_lch_rdy_viq0[7:0]  = is_inst3_lch_rdy_viq0[7:0];
          is_viq1_create1_lch_rdy_viq1[7:0]  = is_inst3_lch_rdy_viq1[7:0];
          end
    default: begin
          is_viq1_create1_data[IS_WIDTH-1:0] = {IS_WIDTH{1'bx}};
          is_viq1_create1_iid[6:0]           = {7{1'bx}};
          is_viq1_create1_lch_rdy_viq0[7:0]  = {8{1'b1}};
          is_viq1_create1_lch_rdy_viq1[7:0]  = {8{1'b1}};
          end
  endcase
// &CombEnd; @3929
end

//----------------------------------------------------------
//                Reorganize for VIQ1 create
//----------------------------------------------------------
//operand mux for iq create
assign dp_viq1_create0_data[VIQ1_WIDTH-1:0] = {VIQ1_WIDTH{ctrl_viq1_create0_gateclk_en}}
                                              & viq1_create0_data[VIQ1_WIDTH-1:0];

assign viq1_create0_data[VIQ1_VL:VIQ1_VL-7]                     = is_viq1_create0_data[IS_VL:IS_VL-7];
assign viq1_create0_data[VIQ1_VSEW:VIQ1_VSEW-2]                 = is_viq1_create0_data[IS_VSEW:IS_VSEW-2];
assign viq1_create0_data[VIQ1_VLMUL:VIQ1_VLMUL-1]               = is_viq1_create0_data[IS_VLMUL:IS_VLMUL-1];
assign viq1_create0_data[VIQ1_VMUL_UNSPLIT]                     = is_viq1_create0_data[IS_VMUL_UNSPLIT];
assign viq1_create0_data[VIQ1_VMLA_SHORT]                       = is_viq1_create0_data[IS_VMLA_SHORT];
assign viq1_create0_data[VIQ1_LCH_RDY_VIQ1:VIQ1_LCH_RDY_VIQ1-7] = is_viq1_create0_lch_rdy_viq1[7:0];
assign viq1_create0_data[VIQ1_LCH_RDY_VIQ0:VIQ1_LCH_RDY_VIQ0-7] = is_viq1_create0_lch_rdy_viq0[7:0];
assign viq1_create0_data[VIQ1_VMLA_TYPE:VIQ1_VMLA_TYPE-2]       = is_viq1_create0_data[IS_VMLA_TYPE:IS_VMLA_TYPE-2];
assign viq1_create0_data[VIQ1_SPLIT_NUM:VIQ1_SPLIT_NUM-6]       = is_viq1_create0_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign viq1_create0_data[VIQ1_SPLIT_LAST]                       = is_viq1_create0_data[IS_SPLIT_LAST];
assign viq1_create0_data[VIQ1_MFVR]                             = is_viq1_create0_data[IS_MFVR];
assign viq1_create0_data[VIQ1_VMLA]                             = is_viq1_create0_data[IS_VMLA];
assign viq1_create0_data[VIQ1_SRCVM_DATA]                       = is_viq1_create0_data[IS_SRCVM_LSU_MATCH];
assign viq1_create0_data[VIQ1_SRCVM_DATA-1:VIQ1_SRCVM_DATA-9]   = is_viq1_create0_data[IS_SRCVM_DATA:IS_SRCVM_DATA-8];
assign viq1_create0_data[VIQ1_SRCV2_DATA]                       = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create0_data[IS_SRCV1_LSU_MATCH]
                                                                  : is_viq1_create0_data[IS_SRCV2_LSU_MATCH];
assign viq1_create0_data[VIQ1_SRCV2_DATA-1:VIQ1_SRCV2_DATA-10]  = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? {1'b0,is_viq1_create0_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8]}
                                                                  : is_viq1_create0_data[IS_SRCV2_DATA:IS_SRCV2_DATA-9];
assign viq1_create0_data[VIQ1_SRCV1_DATA]                       = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create0_data[IS_SRCV2_LSU_MATCH]
                                                                  : is_viq1_create0_data[IS_SRCV1_LSU_MATCH];
assign viq1_create0_data[VIQ1_SRCV1_DATA-1:VIQ1_SRCV1_DATA-9]   = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create0_data[IS_SRCV2_DATA-1:IS_SRCV2_DATA-9]
                                                                  : is_viq1_create0_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8];
assign viq1_create0_data[VIQ1_SRCV0_DATA]                       = is_viq1_create0_data[IS_SRCV0_LSU_MATCH];
assign viq1_create0_data[VIQ1_SRCV0_DATA-1:VIQ1_SRCV0_DATA-9]   = is_viq1_create0_data[IS_SRCV0_DATA:IS_SRCV0_DATA-8];
assign viq1_create0_data[VIQ1_DST_EREG:VIQ1_DST_EREG-4]         = is_viq1_create0_data[IS_DST_EREG:IS_DST_EREG-4];
assign viq1_create0_data[VIQ1_DST_VREG:VIQ1_DST_VREG-6]         = is_viq1_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign viq1_create0_data[VIQ1_DST_PREG:VIQ1_DST_PREG-6]         = is_viq1_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign viq1_create0_data[VIQ1_DSTE_VLD]                         = is_viq1_create0_data[IS_DSTE_VLD];
assign viq1_create0_data[VIQ1_DSTV_VLD]                         = is_viq1_create0_data[IS_DSTV_VLD];
assign viq1_create0_data[VIQ1_DST_VLD]                          = is_viq1_create0_data[IS_DST_VLD];
assign viq1_create0_data[VIQ1_SRCVM_VLD]                        = is_viq1_create0_data[IS_SRCVM_VLD];
assign viq1_create0_data[VIQ1_SRCV2_VLD]                        = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create0_data[IS_SRCV1_VLD]
                                                                  : is_viq1_create0_data[IS_SRCV2_VLD];
assign viq1_create0_data[VIQ1_SRCV1_VLD]                        = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create0_data[IS_SRCV2_VLD]
                                                                  : is_viq1_create0_data[IS_SRCV1_VLD];
assign viq1_create0_data[VIQ1_SRCV0_VLD]                        = is_viq1_create0_data[IS_SRCV0_VLD];
assign viq1_create0_data[VIQ1_IID:VIQ1_IID-6]                   = is_viq1_create0_iid[6:0];
assign viq1_create0_data[VIQ1_OPCODE:VIQ1_OPCODE-31]            = is_viq1_create0_data[IS_OPCODE:IS_OPCODE-31];

//operand mux for iq create
assign dp_viq1_create1_data[VIQ1_WIDTH-1:0] = {VIQ1_WIDTH{ctrl_viq1_create1_gateclk_en}}
                                              & viq1_create1_data[VIQ1_WIDTH-1:0];

assign viq1_create1_data[VIQ1_VL:VIQ1_VL-7]                     = is_viq1_create1_data[IS_VL:IS_VL-7];
assign viq1_create1_data[VIQ1_VSEW:VIQ1_VSEW-2]                 = is_viq1_create1_data[IS_VSEW:IS_VSEW-2];
assign viq1_create1_data[VIQ1_VLMUL:VIQ1_VLMUL-1]               = is_viq1_create1_data[IS_VLMUL:IS_VLMUL-1];
assign viq1_create1_data[VIQ1_VMUL_UNSPLIT]                     = is_viq1_create1_data[IS_VMUL_UNSPLIT];
assign viq1_create1_data[VIQ1_VMLA_SHORT]                       = is_viq1_create1_data[IS_VMLA_SHORT];
assign viq1_create1_data[VIQ1_LCH_RDY_VIQ1:VIQ1_LCH_RDY_VIQ1-7] = is_viq1_create1_lch_rdy_viq1[7:0];
assign viq1_create1_data[VIQ1_LCH_RDY_VIQ0:VIQ1_LCH_RDY_VIQ0-7] = is_viq1_create1_lch_rdy_viq0[7:0];
assign viq1_create1_data[VIQ1_VMLA_TYPE:VIQ1_VMLA_TYPE-2]       = is_viq1_create1_data[IS_VMLA_TYPE:IS_VMLA_TYPE-2];
assign viq1_create1_data[VIQ1_SPLIT_NUM:VIQ1_SPLIT_NUM-6]       = is_viq1_create1_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign viq1_create1_data[VIQ1_SPLIT_LAST]                       = is_viq1_create1_data[IS_SPLIT_LAST];
assign viq1_create1_data[VIQ1_MFVR]                             = is_viq1_create1_data[IS_MFVR];
assign viq1_create1_data[VIQ1_VMLA]                             = is_viq1_create1_data[IS_VMLA];
assign viq1_create1_data[VIQ1_SRCVM_DATA]                       = is_viq1_create1_data[IS_SRCVM_LSU_MATCH];
assign viq1_create1_data[VIQ1_SRCVM_DATA-1:VIQ1_SRCVM_DATA-9]   = is_viq1_create1_data[IS_SRCVM_DATA:IS_SRCVM_DATA-8];
assign viq1_create1_data[VIQ1_SRCV2_DATA]                       = is_viq1_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create1_data[IS_SRCV1_LSU_MATCH]
                                                                  : is_viq1_create1_data[IS_SRCV2_LSU_MATCH];
assign viq1_create1_data[VIQ1_SRCV2_DATA-1:VIQ1_SRCV2_DATA-10]  = is_viq1_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? {1'b0,is_viq1_create1_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8]}
                                                                  : is_viq1_create1_data[IS_SRCV2_DATA:IS_SRCV2_DATA-9];
assign viq1_create1_data[VIQ1_SRCV1_DATA]                       = is_viq1_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create1_data[IS_SRCV2_LSU_MATCH]
                                                                  : is_viq1_create1_data[IS_SRCV1_LSU_MATCH];
assign viq1_create1_data[VIQ1_SRCV1_DATA-1:VIQ1_SRCV1_DATA-9]   = is_viq1_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create1_data[IS_SRCV2_DATA-1:IS_SRCV2_DATA-9]
                                                                  : is_viq1_create1_data[IS_SRCV1_DATA:IS_SRCV1_DATA-8];
assign viq1_create1_data[VIQ1_SRCV0_DATA]                       = is_viq1_create1_data[IS_SRCV0_LSU_MATCH];
assign viq1_create1_data[VIQ1_SRCV0_DATA-1:VIQ1_SRCV0_DATA-9]   = is_viq1_create1_data[IS_SRCV0_DATA:IS_SRCV0_DATA-8];
assign viq1_create1_data[VIQ1_DST_EREG:VIQ1_DST_EREG-4]         = is_viq1_create1_data[IS_DST_EREG:IS_DST_EREG-4];
assign viq1_create1_data[VIQ1_DST_VREG:VIQ1_DST_VREG-6]         = is_viq1_create1_data[IS_DST_VREG:IS_DST_VREG-6];
assign viq1_create1_data[VIQ1_DST_PREG:VIQ1_DST_PREG-6]         = is_viq1_create1_data[IS_DST_PREG:IS_DST_PREG-6];
assign viq1_create1_data[VIQ1_DSTE_VLD]                         = is_viq1_create1_data[IS_DSTE_VLD];
assign viq1_create1_data[VIQ1_DSTV_VLD]                         = is_viq1_create1_data[IS_DSTV_VLD];
assign viq1_create1_data[VIQ1_DST_VLD]                          = is_viq1_create1_data[IS_DST_VLD];
assign viq1_create1_data[VIQ1_SRCVM_VLD]                        = is_viq1_create1_data[IS_SRCVM_VLD];
assign viq1_create1_data[VIQ1_SRCV2_VLD]                        = is_viq1_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create1_data[IS_SRCV1_VLD]
                                                                  : is_viq1_create1_data[IS_SRCV2_VLD];
assign viq1_create1_data[VIQ1_SRCV1_VLD]                        = is_viq1_create1_data[IS_VIQ_SRCV12_SWITCH]
                                                                  ? is_viq1_create1_data[IS_SRCV2_VLD]
                                                                  : is_viq1_create1_data[IS_SRCV1_VLD];
assign viq1_create1_data[VIQ1_SRCV0_VLD]                        = is_viq1_create1_data[IS_SRCV0_VLD];
assign viq1_create1_data[VIQ1_IID:VIQ1_IID-6]                   = is_viq1_create1_iid[6:0];
assign viq1_create1_data[VIQ1_OPCODE:VIQ1_OPCODE-31]            = is_viq1_create1_data[IS_OPCODE:IS_OPCODE-31];

assign dp_viq1_bypass_data[VIQ1_VL:VIQ1_VL-7]                      = is_viq1_create0_data[IS_VL:IS_VL-7];
assign dp_viq1_bypass_data[VIQ1_VSEW:VIQ1_VSEW-2]                  = is_viq1_create0_data[IS_VSEW:IS_VSEW-2];
assign dp_viq1_bypass_data[VIQ1_VLMUL:VIQ1_VLMUL-1]                = is_viq1_create0_data[IS_VLMUL:IS_VLMUL-1];
assign dp_viq1_bypass_data[VIQ1_VMUL_UNSPLIT]                      = is_viq1_create0_data[IS_VMUL_UNSPLIT];
assign dp_viq1_bypass_data[VIQ1_VMLA_SHORT]                        = is_viq1_create0_data[IS_VMLA_SHORT];
assign dp_viq1_bypass_data[VIQ1_LCH_RDY_VIQ1:VIQ1_LCH_RDY_VIQ1-7]  = is_viq1_create0_lch_rdy_viq1[7:0];
assign dp_viq1_bypass_data[VIQ1_LCH_RDY_VIQ0:VIQ1_LCH_RDY_VIQ0-7]  = is_viq1_create0_lch_rdy_viq0[7:0];
assign dp_viq1_bypass_data[VIQ1_VMLA_TYPE:VIQ1_VMLA_TYPE-2]        = is_viq1_create0_data[IS_VMLA_TYPE:IS_VMLA_TYPE-2];
assign dp_viq1_bypass_data[VIQ1_SPLIT_NUM:VIQ1_SPLIT_NUM-6]        = is_viq1_create0_data[IS_SPLIT_NUM:IS_SPLIT_NUM-6];
assign dp_viq1_bypass_data[VIQ1_SPLIT_LAST]                        = is_viq1_create0_data[IS_SPLIT_LAST];
assign dp_viq1_bypass_data[VIQ1_MFVR]                              = is_viq1_create0_data[IS_MFVR];
assign dp_viq1_bypass_data[VIQ1_VMLA]                              = is_viq1_create0_data[IS_VMLA];
assign dp_viq1_bypass_data[VIQ1_SRCVM_LSU_MATCH]                   = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCVM_VREG:VIQ1_SRCVM_VREG-6]      = is_viq1_create0_data[IS_SRCVM_VREG:IS_SRCVM_VREG-6];
assign dp_viq1_bypass_data[VIQ1_SRCVM_WB]                          = is_viq1_create0_data[IS_SRCVM_WB];
assign dp_viq1_bypass_data[VIQ1_SRCVM_RDY]                         = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV2_LSU_MATCH]                   = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV2_DATA-1]                      = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV2_VREG:VIQ1_SRCV2_VREG-6]      = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq1_create0_data[IS_SRCV1_VREG:IS_SRCV1_VREG-6]
                                                                     : is_viq1_create0_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6];
assign dp_viq1_bypass_data[VIQ1_SRCV2_WB]                          = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq1_create0_data[IS_SRCV1_WB]
                                                                     : is_viq1_create0_data[IS_SRCV2_WB];
assign dp_viq1_bypass_data[VIQ1_SRCV2_RDY]                         = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV1_LSU_MATCH]                   = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV1_VREG:VIQ1_SRCV1_VREG-6]      = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq1_create0_data[IS_SRCV2_VREG:IS_SRCV2_VREG-6]
                                                                     : is_viq1_create0_data[IS_SRCV1_VREG:IS_SRCV1_VREG-6];
assign dp_viq1_bypass_data[VIQ1_SRCV1_WB]                          = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq1_create0_data[IS_SRCV2_WB]
                                                                     : is_viq1_create0_data[IS_SRCV1_WB];
assign dp_viq1_bypass_data[VIQ1_SRCV1_RDY]                         = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV0_LSU_MATCH]                   = 1'b0;
assign dp_viq1_bypass_data[VIQ1_SRCV0_VREG:VIQ1_SRCV0_VREG-6]      = is_viq1_create0_data[IS_SRCV0_VREG:IS_SRCV0_VREG-6];
assign dp_viq1_bypass_data[VIQ1_SRCV0_WB]                          = is_viq1_create0_data[IS_SRCV0_WB];
assign dp_viq1_bypass_data[VIQ1_SRCV0_RDY]                         = 1'b0;
assign dp_viq1_bypass_data[VIQ1_DST_EREG:VIQ1_DST_EREG-4]          = is_viq1_create0_data[IS_DST_EREG:IS_DST_EREG-4];
assign dp_viq1_bypass_data[VIQ1_DST_VREG:VIQ1_DST_VREG-6]          = is_viq1_create0_data[IS_DST_VREG:IS_DST_VREG-6];
assign dp_viq1_bypass_data[VIQ1_DST_PREG:VIQ1_DST_PREG-6]          = is_viq1_create0_data[IS_DST_PREG:IS_DST_PREG-6];
assign dp_viq1_bypass_data[VIQ1_DSTE_VLD]                          = is_viq1_create0_data[IS_DSTE_VLD];
assign dp_viq1_bypass_data[VIQ1_DSTV_VLD]                          = is_viq1_create0_data[IS_DSTV_VLD];
assign dp_viq1_bypass_data[VIQ1_DST_VLD]                           = is_viq1_create0_data[IS_DST_VLD];
assign dp_viq1_bypass_data[VIQ1_SRCVM_VLD]                         = is_viq1_create0_data[IS_SRCVM_VLD];
assign dp_viq1_bypass_data[VIQ1_SRCV2_VLD]                         = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq1_create0_data[IS_SRCV1_VLD]
                                                                     : is_viq1_create0_data[IS_SRCV2_VLD];
assign dp_viq1_bypass_data[VIQ1_SRCV1_VLD]                         = is_viq1_create0_data[IS_VIQ_SRCV12_SWITCH]
                                                                     ? is_viq1_create0_data[IS_SRCV2_VLD]
                                                                     : is_viq1_create0_data[IS_SRCV1_VLD];
assign dp_viq1_bypass_data[VIQ1_SRCV0_VLD]                         = is_viq1_create0_data[IS_SRCV0_VLD];
assign dp_viq1_bypass_data[VIQ1_IID:VIQ1_IID-6]                    = is_viq1_create0_iid[6:0];
assign dp_viq1_bypass_data[VIQ1_OPCODE:VIQ1_OPCODE-31]             = is_viq1_create0_data[IS_OPCODE:IS_OPCODE-31];

assign dp_viq1_create_srcv0_rdy_for_bypass = is_viq1_create0_data[IS_SRCV0_BP_RDY];
assign dp_viq1_create_srcv1_rdy_for_bypass = is_viq1_create0_data[IS_SRCV1_BP_RDY];
assign dp_viq1_create_srcv2_rdy_for_bypass = is_viq1_create0_data[IS_SRCV2_BP_RDY];
assign dp_viq1_create_srcvm_rdy_for_bypass = is_viq1_create0_data[IS_SRCVM_BP_RDY];

//==========================================================
//             Output for IR pre dispatch logic
//==========================================================
//if inst shift between IS registers, the pre dispatch information
//should be re-calculaten by IR ctrl related logic.
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_VMB]     = is_inst2_read_data[IS_VMB];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_PIPE7]   = is_inst2_read_data[IS_PIPE7];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_PIPE6]   = is_inst2_read_data[IS_PIPE6];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_PIPE67]  = is_inst2_read_data[IS_PIPE67];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_SPECIAL] = is_inst2_read_data[IS_SPECIAL];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_STADDR]  = is_inst2_read_data[IS_STADDR];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_INTMASK] = is_inst2_read_data[IS_INTMASK];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_SPLIT]   = is_inst2_read_data[IS_SPLIT];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_LSU]     = is_inst2_read_data[IS_LSU];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_BJU]     = is_inst2_read_data[IS_BJU];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_DIV]     = is_inst2_read_data[IS_DIV];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_MULT]    = is_inst2_read_data[IS_MULT];
assign dp_ctrl_is_dis_inst2_ctrl_info[IS_CTRL_ALU]     = is_inst2_read_data[IS_ALU];

assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_VMB]     = is_inst3_read_data[IS_VMB];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_PIPE7]   = is_inst3_read_data[IS_PIPE7];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_PIPE6]   = is_inst3_read_data[IS_PIPE6];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_PIPE67]  = is_inst3_read_data[IS_PIPE67];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_SPECIAL] = is_inst3_read_data[IS_SPECIAL];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_STADDR]  = is_inst3_read_data[IS_STADDR];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_INTMASK] = is_inst3_read_data[IS_INTMASK];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_SPLIT]   = is_inst3_read_data[IS_SPLIT];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_LSU]     = is_inst3_read_data[IS_LSU];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_BJU]     = is_inst3_read_data[IS_BJU];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_DIV]     = is_inst3_read_data[IS_DIV];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_MULT]    = is_inst3_read_data[IS_MULT];
assign dp_ctrl_is_dis_inst3_ctrl_info[IS_CTRL_ALU]     = is_inst3_read_data[IS_ALU];

// &ModuleEnd; @4124
endmodule


