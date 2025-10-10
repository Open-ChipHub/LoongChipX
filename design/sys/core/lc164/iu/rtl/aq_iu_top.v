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

// &ModuleBeg; @23
module aq_iu_top (
  // &Ports, @24
  input    wire          cp0_iu_icg_en,
  input    wire  [63:0]  cp0_xx_mrvbr,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [63:0]  da_xx_fwd_data,
  input    wire  [5 :0]  da_xx_fwd_dst_reg,
  input    wire          da_xx_fwd_vld,
  input    wire          forever_cpuclk,
  input    wire          hpcp_iu_cnt_en,
  input    wire          idu_alu_ex1_gateclk_sel,
  input    wire          idu_bju_ex1_gateclk_sel,
  input    wire          idu_div_ex1_gateclk_sel,
  input    wire  [31:0]  idu_iu_ex1_alu_inst,
  input    wire          idu_iu_ex1_alu_dp_sel,
  input    wire          idu_iu_ex1_alu_sel,
  input    wire  [1 :0]  idu_iu_ex1_bht_pred,
  input    wire          idu_iu_ex1_bju_br_sel,
  input    wire          idu_iu_ex1_bju_dp_sel,
  input    wire          idu_iu_ex1_bju_sel,
  input    wire          idu_iu_ex1_div_dp_sel,
  input    wire          idu_iu_ex1_div_sel,
  input    wire  [5 :0]  idu_iu_ex1_dst0_reg,
  input    wire  [19:0]  idu_iu_ex1_func,
  input    wire          idu_iu_ex1_inst_vld,
  input    wire          idu_iu_ex1_length,
  input    wire          idu_iu_ex1_mult_dp_sel,
  input    wire          idu_iu_ex1_mult_sel,
  input    wire          idu_iu_ex1_pipedown_vld,
  input    wire          idu_iu_ex1_split,
  input    wire  [63:0]  idu_iu_ex1_src0_data,
  input    wire          idu_iu_ex1_src0_ready,
  input    wire  [5 :0]  idu_iu_ex1_src0_reg,
  input    wire  [63:0]  idu_iu_ex1_src1_data,
  input    wire          idu_iu_ex1_src1_ready,
  input    wire  [5 :0]  idu_iu_ex1_src1_reg,
  input    wire  [63:0]  idu_iu_ex1_src2_data,
  input    wire  [2 :0]  idu_iu_ex1_srcc_reg,
  input    wire          idu_iu_ex1_srcc_data,
  input    wire          idu_mult_ex1_gateclk_sel,
  input    wire  [63:0]  ifu_iu_chgflw_pc,
  input    wire          ifu_iu_chgflw_vld,
  input    wire  [63:0]  ifu_iu_ex1_pc_pred,
  input    wire          ifu_iu_reset_vld,
  input    wire          ifu_iu_warm_up,
  input    wire  [63:0]  lsu_iu_ex2_data,
  input    wire          lsu_iu_ex2_data_vld,
  input    wire  [4 :0]  lsu_iu_ex2_dest_reg,
  input    wire          mmu_xx_mmu_en,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_iu_div_wb_grant,
  input    wire          rtu_iu_div_wb_grant_for_full,
  input    wire          rtu_iu_ex1_cmplt,
  input    wire          rtu_iu_ex1_cmplt_dp,
  input    wire          rtu_iu_ex1_inst_len,
  input    wire          rtu_iu_ex1_inst_split,
  input    wire  [63:0]  rtu_iu_ex2_cur_pc,
  input    wire  [63:0]  rtu_iu_ex2_next_pc,
  input    wire          rtu_iu_mul_wb_grant,
  input    wire          rtu_iu_mul_wb_grant_for_full,
  input    wire          rtu_yy_xx_flush_fe,
  output   wire  [63:0]  iu_cp0_ex1_cur_pc,
  output   wire  [8 :0]  iu_dtu_debug_info,
  output   wire          iu_hpcp_inst_bht_mispred,
  output   wire          iu_hpcp_inst_condbr,
  output   wire          iu_hpcp_jump_8m,
  output   wire          iu_idu_bju_full,
  output   wire          iu_idu_bju_global_full,
  output   wire          iu_idu_div_full,
  output   wire          iu_idu_mult_full,
  output   wire          iu_idu_mult_issue_stall,
  output   wire  [63:0]  iu_ifu_bht_cur_pc,
  output   wire          iu_ifu_bht_mispred,
  output   wire          iu_ifu_bht_mispred_gate,
  output   wire  [1 :0]  iu_ifu_bht_pred,
  output   wire          iu_ifu_bht_taken,
  output   wire          iu_ifu_br_vld,
  output   wire          iu_ifu_br_vld_gate,
  output   wire          iu_ifu_link_vld,
  output   wire          iu_ifu_link_vld_gate,
  output   wire          iu_ifu_pc_mispred,
  output   wire          iu_ifu_pc_mispred_gate,
  output   wire          iu_ifu_ret_vld,
  output   wire          iu_ifu_ret_vld_gate,
  output   wire  [63:0]  iu_ifu_tar_pc,
  output   wire          iu_ifu_tar_pc_vld,
  output   wire          iu_ifu_tar_pc_vld_gate,
  output   wire  [15:0]  iu_lsu_ex1_cur_pc,
  output   wire          iu_rtu_depd_lsu_chgflow_vld,
  output   wire  [63:0]  iu_rtu_depd_lsu_next_pc,
  output   wire  [63:0]  iu_rtu_div_data,
  output   wire  [5 :0]  iu_rtu_div_preg,
  output   wire          iu_rtu_div_wb_dp,
  output   wire          iu_rtu_div_wb_vld,
  output   wire          iu_rtu_ex1_alu_cmplt,
  output   wire          iu_rtu_ex1_alu_cmplt_dp,
  output   wire  [63:0]  iu_rtu_ex1_alu_data,
  output   wire          iu_rtu_ex1_alu_inst_len,
  output   wire          iu_rtu_ex1_alu_inst_split,
  output   wire  [5 :0]  iu_rtu_ex1_alu_preg,
  output   wire          iu_rtu_ex1_alu_wb_dp,
  output   wire          iu_rtu_ex1_alu_wb_vld,
  output   wire          iu_rtu_ex1_bju_cmplt,
  output   wire          iu_rtu_ex1_bju_cmplt_dp,
  output   wire  [63:0]  iu_rtu_ex1_bju_data,
  output   wire          iu_rtu_ex1_bju_inst_len,
  output   wire  [5 :0]  iu_rtu_ex1_bju_preg,
  output   wire          iu_rtu_ex1_bju_wb_dp,
  output   wire          iu_rtu_ex1_bju_wb_vld,
  output   wire          iu_rtu_ex1_branch_inst,
  output   wire  [63:0]  iu_rtu_ex1_cur_pc,
  output   wire          iu_rtu_ex1_div_cmplt,
  output   wire          iu_rtu_ex1_div_cmplt_dp,
  output   wire          iu_rtu_ex1_mul_cmplt,
  output   wire          iu_rtu_ex1_mul_cmplt_dp,
  output   wire  [63:0]  iu_rtu_ex1_next_pc,
  output   wire          iu_rtu_ex2_bju_ras_mispred,
  output   wire  [63:0]  iu_rtu_ex3_mul_data,
  output   wire  [5 :0]  iu_rtu_ex3_mul_preg,
  output   wire          iu_rtu_ex3_mul_wb_vld,
  output   wire          iu_xx_no_op,
  output   wire          iu_yy_xx_cancel
); 



// &Regs; @25
// &Wires; @26
wire    [63:0]  ag_bju_pc;                   
wire    [63:0]  bju_ag_cur_pc;               
wire    [63:0]  bju_ag_offset;               
wire            bju_ag_offset_sel;           
wire            bju_ag_use_pc;               
wire    [3 :0]  bju_deginfo;                 
wire            bju_entry_no_vld;            
wire            bju_ras_not_vld;             
wire            div_ctrl_no_op;              
wire    [2 :0]  div_dbginfo;                 
wire    [5 :0]  idu_iu_ex1_dst_preg;         
wire            idu_iu_ex1_inst_len;         
wire    [63:0]  idu_iu_ex1_src0;             
wire    [63:0]  idu_iu_ex1_src1;             
wire    [63:0]  idu_iu_ex1_src2;             
wire            idu_iu_ex1_srcc;         
wire            mul_ctrl_no_op;              
wire    [1 :0]  mul_dbginfo;                 


// &Instance("aq_iu_alu"); @28
aq_iu_alu  x_aq_iu_alu (
  .idu_alu_ex1_gateclk_sel   (idu_alu_ex1_gateclk_sel  ),
  .idu_iu_ex1_alu_dp_sel     (idu_iu_ex1_alu_dp_sel    ),
  .idu_iu_ex1_alu_inst       (idu_iu_ex1_alu_inst      ),
  .idu_iu_ex1_alu_sel        (idu_iu_ex1_alu_sel       ),
  .idu_iu_ex1_dst0_reg       (idu_iu_ex1_dst0_reg      ),
  .idu_iu_ex1_func           (idu_iu_ex1_func          ),
  .idu_iu_ex1_inst_len       (idu_iu_ex1_inst_len      ),
  .idu_iu_ex1_split          (idu_iu_ex1_split         ),
  .idu_iu_ex1_src0           (idu_iu_ex1_src0          ),
  .idu_iu_ex1_src1           (idu_iu_ex1_src1          ),
  .idu_iu_ex1_src2           (idu_iu_ex1_src2          ),
  .iu_rtu_ex1_alu_cmplt      (iu_rtu_ex1_alu_cmplt     ),
  .iu_rtu_ex1_alu_cmplt_dp   (iu_rtu_ex1_alu_cmplt_dp  ),
  .iu_rtu_ex1_alu_data       (iu_rtu_ex1_alu_data      ),
  .iu_rtu_ex1_alu_inst_len   (iu_rtu_ex1_alu_inst_len  ),
  .iu_rtu_ex1_alu_inst_split (iu_rtu_ex1_alu_inst_split),
  .iu_rtu_ex1_alu_preg       (iu_rtu_ex1_alu_preg      ),
  .iu_rtu_ex1_alu_wb_dp      (iu_rtu_ex1_alu_wb_dp     ),
  .iu_rtu_ex1_alu_wb_vld     (iu_rtu_ex1_alu_wb_vld    )
);


// &Instance("aq_iu_mul"); @30
aq_iu_mul  x_aq_iu_mul (
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .forever_cpuclk               (forever_cpuclk              ),
  .idu_iu_ex1_dst_preg          (idu_iu_ex1_dst_preg         ),
  .idu_iu_ex1_func              (idu_iu_ex1_func             ),
  .idu_iu_ex1_mult_dp_sel       (idu_iu_ex1_mult_dp_sel      ),
  .idu_iu_ex1_mult_sel          (idu_iu_ex1_mult_sel         ),
  .idu_iu_ex1_src0              (idu_iu_ex1_src0             ),
  .idu_iu_ex1_src1              (idu_iu_ex1_src1             ),
  .idu_iu_ex1_src2              (idu_iu_ex1_src2             ),
  .idu_iu_ex1_inst              (idu_iu_ex1_alu_inst         ),
  .idu_mult_ex1_gateclk_sel     (idu_mult_ex1_gateclk_sel    ),
  .ifu_iu_warm_up               (ifu_iu_warm_up              ),
  .iu_idu_mult_full             (iu_idu_mult_full            ),
  .iu_idu_mult_issue_stall      (iu_idu_mult_issue_stall     ),
  .iu_rtu_ex1_mul_cmplt         (iu_rtu_ex1_mul_cmplt        ),
  .iu_rtu_ex1_mul_cmplt_dp      (iu_rtu_ex1_mul_cmplt_dp     ),
  .iu_rtu_ex3_mul_data          (iu_rtu_ex3_mul_data         ),
  .iu_rtu_ex3_mul_preg          (iu_rtu_ex3_mul_preg         ),
  .iu_rtu_ex3_mul_wb_vld        (iu_rtu_ex3_mul_wb_vld       ),
  .mul_ctrl_no_op               (mul_ctrl_no_op              ),
  .mul_dbginfo                  (mul_dbginfo                 ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_iu_mul_wb_grant          (rtu_iu_mul_wb_grant         ),
  .rtu_iu_mul_wb_grant_for_full (rtu_iu_mul_wb_grant_for_full),
  .rtu_yy_xx_flush_fe           (rtu_yy_xx_flush_fe          )
);


// &Instance("aq_iu_div"); @32
aq_iu_div  x_aq_iu_div (
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .div_ctrl_no_op               (div_ctrl_no_op              ),
  .div_dbginfo                  (div_dbginfo                 ),
  .forever_cpuclk               (forever_cpuclk              ),
  .idu_div_ex1_gateclk_sel      (idu_div_ex1_gateclk_sel     ),
  .idu_iu_ex1_div_dp_sel        (idu_iu_ex1_div_dp_sel       ),
  .idu_iu_ex1_div_sel           (idu_iu_ex1_div_sel          ),
  .idu_iu_ex1_dst_preg          (idu_iu_ex1_dst_preg         ),
  .idu_iu_ex1_func              (idu_iu_ex1_func             ),
  .idu_iu_ex1_src0              (idu_iu_ex1_src0             ),
  .idu_iu_ex1_src1              (idu_iu_ex1_src1             ),
  .idu_iu_ex1_inst              (idu_iu_ex1_alu_inst         ),
  .ifu_iu_warm_up               (ifu_iu_warm_up              ),
  .iu_idu_div_full              (iu_idu_div_full             ),
  .iu_rtu_div_data              (iu_rtu_div_data             ),
  .iu_rtu_div_preg              (iu_rtu_div_preg             ),
  .iu_rtu_div_wb_dp             (iu_rtu_div_wb_dp            ),
  .iu_rtu_div_wb_vld            (iu_rtu_div_wb_vld           ),
  .iu_rtu_ex1_div_cmplt         (iu_rtu_ex1_div_cmplt        ),
  .iu_rtu_ex1_div_cmplt_dp      (iu_rtu_ex1_div_cmplt_dp     ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .rtu_iu_div_wb_grant          (rtu_iu_div_wb_grant         ),
  .rtu_iu_div_wb_grant_for_full (rtu_iu_div_wb_grant_for_full)
);


// &Instance("aq_iu_bju"); @34
aq_iu_bju  x_aq_iu_bju (
  .ag_bju_pc                   (ag_bju_pc                  ),
  .bju_ag_cur_pc               (bju_ag_cur_pc              ),
  .bju_ag_offset               (bju_ag_offset              ),
  .bju_ag_offset_sel           (bju_ag_offset_sel          ),
  .bju_ag_use_pc               (bju_ag_use_pc              ),
  .bju_deginfo                 (bju_deginfo                ),
  .bju_entry_no_vld            (bju_entry_no_vld           ),
  .bju_ras_not_vld             (bju_ras_not_vld            ),
  .cp0_iu_icg_en               (cp0_iu_icg_en              ),
  .cp0_xx_mrvbr                (cp0_xx_mrvbr               ),
  .cp0_yy_clk_en               (cp0_yy_clk_en              ),
  .cpurst_b                    (cpurst_b                   ),
  .da_xx_fwd_data              (da_xx_fwd_data             ),
  .da_xx_fwd_dst_reg           (da_xx_fwd_dst_reg          ),
  .da_xx_fwd_vld               (da_xx_fwd_vld              ),
  .forever_cpuclk              (forever_cpuclk             ),
  .hpcp_iu_cnt_en              (hpcp_iu_cnt_en             ),
  .idu_bju_ex1_gateclk_sel     (idu_bju_ex1_gateclk_sel    ),
  .idu_iu_ex1_inst             (idu_iu_ex1_alu_inst        ),
  .idu_iu_ex1_bht_pred         (idu_iu_ex1_bht_pred        ),
  .idu_iu_ex1_bju_br_sel       (idu_iu_ex1_bju_br_sel      ),
  .idu_iu_ex1_bju_dp_sel       (idu_iu_ex1_bju_dp_sel      ),
  .idu_iu_ex1_bju_sel          (idu_iu_ex1_bju_sel         ),
  .idu_iu_ex1_dst_preg         (idu_iu_ex1_dst_preg        ),
  .idu_iu_ex1_func             (idu_iu_ex1_func            ),
  .idu_iu_ex1_inst_len         (idu_iu_ex1_inst_len        ),
  .idu_iu_ex1_inst_vld         (idu_iu_ex1_inst_vld        ),
  .idu_iu_ex1_pipedown_vld     (idu_iu_ex1_pipedown_vld    ),
  .idu_iu_ex1_split            (idu_iu_ex1_split           ),
  .idu_iu_ex1_src0             (idu_iu_ex1_src0            ),
  .idu_iu_ex1_src0_ready       (idu_iu_ex1_src0_ready      ),
  .idu_iu_ex1_src0_reg         (idu_iu_ex1_src0_reg        ),
  .idu_iu_ex1_src1             (idu_iu_ex1_src1            ),
  .idu_iu_ex1_src1_ready       (idu_iu_ex1_src1_ready      ),
  .idu_iu_ex1_src1_reg         (idu_iu_ex1_src1_reg        ),
  .idu_iu_ex1_src2             (idu_iu_ex1_src2            ),
  .idu_iu_ex1_srcc_reg         (idu_iu_ex1_srcc_reg        ),
  .idu_iu_ex1_srcc             (idu_iu_ex1_srcc            ),
  .ifu_iu_chgflw_pc            (ifu_iu_chgflw_pc           ),
  .ifu_iu_chgflw_vld           (ifu_iu_chgflw_vld          ),
  .ifu_iu_ex1_pc_pred          (ifu_iu_ex1_pc_pred         ),
  .ifu_iu_reset_vld            (ifu_iu_reset_vld           ),
  .ifu_iu_warm_up              (ifu_iu_warm_up             ),
  .iu_cp0_ex1_cur_pc           (iu_cp0_ex1_cur_pc          ),
  .iu_hpcp_inst_bht_mispred    (iu_hpcp_inst_bht_mispred   ),
  .iu_hpcp_inst_condbr         (iu_hpcp_inst_condbr        ),
  .iu_hpcp_jump_8m             (iu_hpcp_jump_8m            ),
  .iu_idu_bju_full             (iu_idu_bju_full            ),
  .iu_idu_bju_global_full      (iu_idu_bju_global_full     ),
  .iu_ifu_bht_cur_pc           (iu_ifu_bht_cur_pc          ),
  .iu_ifu_bht_mispred          (iu_ifu_bht_mispred         ),
  .iu_ifu_bht_mispred_gate     (iu_ifu_bht_mispred_gate    ),
  .iu_ifu_bht_pred             (iu_ifu_bht_pred            ),
  .iu_ifu_bht_taken            (iu_ifu_bht_taken           ),
  .iu_ifu_br_vld               (iu_ifu_br_vld              ),
  .iu_ifu_br_vld_gate          (iu_ifu_br_vld_gate         ),
  .iu_ifu_link_vld             (iu_ifu_link_vld            ),
  .iu_ifu_link_vld_gate        (iu_ifu_link_vld_gate       ),
  .iu_ifu_pc_mispred           (iu_ifu_pc_mispred          ),
  .iu_ifu_pc_mispred_gate      (iu_ifu_pc_mispred_gate     ),
  .iu_ifu_ret_vld              (iu_ifu_ret_vld             ),
  .iu_ifu_ret_vld_gate         (iu_ifu_ret_vld_gate        ),
  .iu_ifu_tar_pc               (iu_ifu_tar_pc              ),
  .iu_ifu_tar_pc_vld           (iu_ifu_tar_pc_vld          ),
  .iu_ifu_tar_pc_vld_gate      (iu_ifu_tar_pc_vld_gate     ),
  .iu_lsu_ex1_cur_pc           (iu_lsu_ex1_cur_pc          ),
  .iu_rtu_depd_lsu_chgflow_vld (iu_rtu_depd_lsu_chgflow_vld),
  .iu_rtu_depd_lsu_next_pc     (iu_rtu_depd_lsu_next_pc    ),
  .iu_rtu_ex1_bju_cmplt        (iu_rtu_ex1_bju_cmplt       ),
  .iu_rtu_ex1_bju_cmplt_dp     (iu_rtu_ex1_bju_cmplt_dp    ),
  .iu_rtu_ex1_bju_data         (iu_rtu_ex1_bju_data        ),
  .iu_rtu_ex1_bju_inst_len     (iu_rtu_ex1_bju_inst_len    ),
  .iu_rtu_ex1_bju_preg         (iu_rtu_ex1_bju_preg        ),
  .iu_rtu_ex1_bju_wb_dp        (iu_rtu_ex1_bju_wb_dp       ),
  .iu_rtu_ex1_bju_wb_vld       (iu_rtu_ex1_bju_wb_vld      ),
  .iu_rtu_ex1_branch_inst      (iu_rtu_ex1_branch_inst     ),
  .iu_rtu_ex1_cur_pc           (iu_rtu_ex1_cur_pc          ),
  .iu_rtu_ex1_next_pc          (iu_rtu_ex1_next_pc         ),
  .iu_rtu_ex2_bju_ras_mispred  (iu_rtu_ex2_bju_ras_mispred ),
  .iu_yy_xx_cancel             (iu_yy_xx_cancel            ),
  .lsu_iu_ex2_data             (lsu_iu_ex2_data            ),
  .lsu_iu_ex2_data_vld         (lsu_iu_ex2_data_vld        ),
  .lsu_iu_ex2_dest_reg         (lsu_iu_ex2_dest_reg        ),
  .mmu_xx_mmu_en               (mmu_xx_mmu_en              ),
  .pad_yy_icg_scan_en          (pad_yy_icg_scan_en         ),
  .rtu_iu_ex1_cmplt            (rtu_iu_ex1_cmplt           ),
  .rtu_iu_ex1_cmplt_dp         (rtu_iu_ex1_cmplt_dp        ),
  .rtu_iu_ex1_inst_len         (rtu_iu_ex1_inst_len        ),
  .rtu_iu_ex1_inst_split       (rtu_iu_ex1_inst_split      ),
  .rtu_iu_ex2_cur_pc           (rtu_iu_ex2_cur_pc          ),
  .rtu_iu_ex2_next_pc          (rtu_iu_ex2_next_pc         )
);


// &Instance("aq_iu_addr_gen"); @36
aq_iu_addr_gen  x_aq_iu_addr_gen (
  .ag_bju_pc               (ag_bju_pc              ),
  .bju_ag_cur_pc           (bju_ag_cur_pc          ),
  .bju_ag_offset           (bju_ag_offset          ),
  .bju_ag_offset_sel       (bju_ag_offset_sel      ),
  .bju_ag_use_pc           (bju_ag_use_pc          ),
  .idu_bju_ex1_gateclk_sel (idu_bju_ex1_gateclk_sel),
  .idu_iu_ex1_src0         (idu_iu_ex1_src0        ),
  .idu_iu_ex1_src2         (idu_iu_ex1_src2        ),
  .mmu_xx_mmu_en           (mmu_xx_mmu_en          )
);



assign iu_xx_no_op = !idu_iu_ex1_inst_vld && div_ctrl_no_op && mul_ctrl_no_op && bju_entry_no_vld && bju_ras_not_vld;

// input signal Rename
assign idu_iu_ex1_dst_preg[5:0] = idu_iu_ex1_dst0_reg[5:0];
assign idu_iu_ex1_src0[63:0]    = idu_iu_ex1_src0_data[63:0];
assign idu_iu_ex1_src1[63:0]    = idu_iu_ex1_src1_data[63:0];
assign idu_iu_ex1_src2[63:0]    = idu_iu_ex1_src2_data[63:0];
assign idu_iu_ex1_srcc          = idu_iu_ex1_srcc_data;
assign idu_iu_ex1_inst_len      = idu_iu_ex1_length;
assign iu_dtu_debug_info[8:0]   = {bju_deginfo[3:0], mul_dbginfo[1:0], div_dbginfo[2:0]};


// &ModuleEnd; @50
endmodule


