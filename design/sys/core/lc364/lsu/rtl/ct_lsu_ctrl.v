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
module ct_lsu_ctrl (
  // &Ports, @27
  input    wire  [1  :0]  cp0_lsu_dcache_pref_dist,
  input    wire           cp0_lsu_icg_en,
  input    wire  [1  :0]  cp0_lsu_l2_pref_dist,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           dcache_arb_ld_dc_borrow_vld_gate,
  input    wire           dcache_arb_st_dc_borrow_vld_gate,
  input    wire           forever_cpuclk,
  input    wire           hpcp_lsu_cnt_en,
  input    wire           icc_vb_create_gateclk_en,
  input    wire           idu_lsu_rf_pipe3_gateclk_sel,
  input    wire           idu_lsu_rf_pipe3_sel,
  input    wire           idu_lsu_rf_pipe4_gateclk_sel,
  input    wire           idu_lsu_rf_pipe4_sel,
  input    wire           idu_lsu_rf_pipe5_gateclk_sel,
  input    wire           idu_lsu_vmb_create0_gateclk_en,
  input    wire           idu_lsu_vmb_create1_gateclk_en,
  input    wire           ld_ag_inst_vld,
  input    wire           ld_ag_stall_ori,
  input    wire  [11 :0]  ld_ag_stall_restart_entry,
  input    wire           ld_da_borrow_vld,
  input    wire  [11 :0]  ld_da_ecc_wakeup,
  input    wire  [11 :0]  ld_da_idu_already_da,
  input    wire  [11 :0]  ld_da_idu_bkpta_data,
  input    wire  [11 :0]  ld_da_idu_bkptb_data,
  input    wire  [11 :0]  ld_da_idu_boundary_gateclk_en,
  input    wire  [11 :0]  ld_da_idu_pop_entry,
  input    wire           ld_da_idu_pop_vld,
  input    wire  [11 :0]  ld_da_idu_rb_full,
  input    wire  [11 :0]  ld_da_idu_secd,
  input    wire  [11 :0]  ld_da_idu_spec_fail,
  input    wire  [11 :0]  ld_da_idu_wait_fence,
  input    wire           ld_da_inst_vld,
  input    wire           ld_da_rb_full_gateclk_en,
  input    wire           ld_da_special_gateclk_en,
  input    wire           ld_da_wait_fence_gateclk_en,
  input    wire           ld_dc_borrow_vld,
  input    wire  [11 :0]  ld_dc_idu_lq_full,
  input    wire  [11 :0]  ld_dc_idu_tlb_busy,
  input    wire  [11 :0]  ld_dc_imme_wakeup,
  input    wire           ld_dc_inst_vld,
  input    wire           ld_dc_lq_full_gateclk_en,
  input    wire           ld_dc_tlb_busy_gateclk_en,
  input    wire           ld_wb_data_vld,
  input    wire           ld_wb_inst_vld,
  input    wire  [11 :0]  lfb_depd_wakeup,
  input    wire           lfb_empty,
  input    wire           lfb_pop_depd_ff,
  input    wire           lm_lfb_depd_wakeup,
  input    wire  [2  :0]  lsu_had_amr_state,
  input    wire  [1  :0]  lsu_had_cdr_state,
  input    wire  [5  :0]  lsu_had_ctcq_entry_2_cmplt,
  input    wire  [5  :0]  lsu_had_ctcq_entry_cmplt,
  input    wire  [5  :0]  lsu_had_ctcq_entry_vld,
  input    wire  [2  :0]  lsu_had_icc_state,
  input    wire  [7  :0]  lsu_had_lfb_addr_entry_dcache_hit,
  input    wire  [7  :0]  lsu_had_lfb_addr_entry_rcl_done,
  input    wire  [7  :0]  lsu_had_lfb_addr_entry_vld,
  input    wire  [1  :0]  lsu_had_lfb_data_entry_last,
  input    wire  [1  :0]  lsu_had_lfb_data_entry_vld,
  input    wire           lsu_had_lfb_lf_sm_vld,
  input    wire  [12 :0]  lsu_had_lfb_wakeup_queue,
  input    wire  [2  :0]  lsu_had_lm_state,
  input    wire           lsu_had_mcic_data_req,
  input    wire           lsu_had_mcic_frz,
  input    wire  [7  :0]  lsu_had_rb_entry_fence,
  input    wire  [3  :0]  lsu_had_rb_entry_state_0,
  input    wire  [3  :0]  lsu_had_rb_entry_state_1,
  input    wire  [3  :0]  lsu_had_rb_entry_state_2,
  input    wire  [3  :0]  lsu_had_rb_entry_state_3,
  input    wire  [3  :0]  lsu_had_rb_entry_state_4,
  input    wire  [3  :0]  lsu_had_rb_entry_state_5,
  input    wire  [3  :0]  lsu_had_rb_entry_state_6,
  input    wire  [3  :0]  lsu_had_rb_entry_state_7,
  input    wire  [2  :0]  lsu_had_sdb_entry_vld,
  input    wire           lsu_had_snoop_data_req,
  input    wire           lsu_had_snoop_tag_req,
  input    wire  [5  :0]  lsu_had_snq_entry_issued,
  input    wire  [5  :0]  lsu_had_snq_entry_vld,
  input    wire           lsu_had_sq_not_empty,
  input    wire  [1  :0]  lsu_had_vb_addr_entry_vld,
  input    wire  [2  :0]  lsu_had_vb_data_entry_vld,
  input    wire  [3  :0]  lsu_had_vb_rcl_sm_state,
  input    wire           lsu_had_wmb_ar_pending,
  input    wire           lsu_had_wmb_aw_pending,
  input    wire  [7  :0]  lsu_had_wmb_create_ptr,
  input    wire  [7  :0]  lsu_had_wmb_data_ptr,
  input    wire  [7  :0]  lsu_had_wmb_entry_vld,
  input    wire  [7  :0]  lsu_had_wmb_read_ptr,
  input    wire           lsu_had_wmb_w_pending,
  input    wire           lsu_had_wmb_write_imme,
  input    wire  [7  :0]  lsu_had_wmb_write_ptr,
  input    wire           lsu_has_fence,
  input    wire           lsu_hpcp_ld_cache_access,
  input    wire           lsu_hpcp_ld_cache_miss,
  input    wire           lsu_hpcp_ld_cross_4k_stall,
  input    wire           lsu_hpcp_ld_data_discard,
  input    wire           lsu_hpcp_ld_discard_sq,
  input    wire           lsu_hpcp_ld_other_stall,
  input    wire           lsu_hpcp_ld_unalign_inst,
  input    wire           lsu_hpcp_st_cache_access,
  input    wire           lsu_hpcp_st_cache_miss,
  input    wire           lsu_hpcp_st_cross_4k_stall,
  input    wire           lsu_hpcp_st_other_stall,
  input    wire           lsu_hpcp_st_unalign_inst,
  input    wire  [11 :0]  lsu_idu_ld_ag_wait_old,
  input    wire           lsu_idu_ld_ag_wait_old_gateclk_en,
  input    wire  [11 :0]  lsu_idu_ld_da_wait_old,
  input    wire           lsu_idu_ld_da_wait_old_gateclk_en,
  input    wire  [11 :0]  lsu_idu_st_ag_wait_old,
  input    wire           lsu_idu_st_ag_wait_old_gateclk_en,
  input    wire  [11 :0]  mmu_lsu_tlb_wakeup,
  input    wire           pad_yy_icg_scan_en,
  input    wire           pfu_lfb_create_gateclk_en,
  input    wire           pfu_part_empty,
  input    wire           rb_empty,
  input    wire           rb_ld_wb_cmplt_req,
  input    wire           rb_ld_wb_data_req,
  input    wire           sd_ex1_inst_vld,
  input    wire  [11 :0]  sq_data_depd_wakeup,
  input    wire           sq_empty,
  input    wire  [11 :0]  sq_global_depd_wakeup,
  input    wire           st_ag_inst_vld,
  input    wire           st_ag_stall_ori,
  input    wire  [11 :0]  st_ag_stall_restart_entry,
  input    wire           st_da_borrow_vld,
  input    wire  [11 :0]  st_da_ecc_wakeup,
  input    wire  [11 :0]  st_da_idu_already_da,
  input    wire  [11 :0]  st_da_idu_bkpta_data,
  input    wire  [11 :0]  st_da_idu_bkptb_data,
  input    wire  [11 :0]  st_da_idu_boundary_gateclk_en,
  input    wire  [11 :0]  st_da_idu_pop_entry,
  input    wire           st_da_idu_pop_vld,
  input    wire  [11 :0]  st_da_idu_rb_full,
  input    wire  [11 :0]  st_da_idu_secd,
  input    wire  [11 :0]  st_da_idu_spec_fail,
  input    wire  [11 :0]  st_da_idu_wait_fence,
  input    wire           st_da_inst_vld,
  input    wire           st_da_rb_create_gateclk_en,
  input    wire           st_da_rb_full_gateclk_en,
  input    wire           st_da_wait_fence_gateclk_en,
  input    wire           st_dc_borrow_vld,
  input    wire  [11 :0]  st_dc_idu_sq_full,
  input    wire  [11 :0]  st_dc_idu_tlb_busy,
  input    wire  [11 :0]  st_dc_imme_wakeup,
  input    wire           st_dc_inst_vld,
  input    wire           st_dc_sq_full_gateclk_en,
  input    wire           st_dc_tlb_busy_gateclk_en,
  input    wire           st_wb_inst_vld,
  input    wire           vb_empty,
  input    wire           vmb_empty,
  input    wire           vmb_ld_wb_data_req,
  input    wire  [11 :0]  wmb_depd_wakeup,
  input    wire           wmb_empty,
  input    wire           wmb_ld_wb_data_req,
  input    wire           wmb_no_op,
  input    wire           wmb_st_wb_cmplt_req,
  input    wire           wmb_write_req_icc,
  output   wire           ctrl_ld_clk,
  output   wire           ctrl_st_clk,
  output   wire  [183:0]  lsu_had_debug_info,
  output   wire           lsu_had_no_op,
  output   reg            lsu_hpcp_cache_read_access,
  output   reg            lsu_hpcp_cache_read_miss,
  output   reg            lsu_hpcp_cache_write_access,
  output   reg            lsu_hpcp_cache_write_miss,
  output   reg            lsu_hpcp_fence_stall,
  output   reg            lsu_hpcp_ld_stall_cross_4k,
  output   reg            lsu_hpcp_ld_stall_other,
  output   reg            lsu_hpcp_replay_data_discard,
  output   reg            lsu_hpcp_replay_discard_sq,
  output   reg            lsu_hpcp_st_stall_cross_4k,
  output   reg            lsu_hpcp_st_stall_other,
  output   reg   [1  :0]  lsu_hpcp_unalign_inst,
  output   wire  [11 :0]  lsu_idu_already_da,
  output   wire  [11 :0]  lsu_idu_bkpta_data,
  output   wire  [11 :0]  lsu_idu_bkptb_data,
  output   wire  [11 :0]  lsu_idu_lq_full,
  output   wire           lsu_idu_lq_full_gateclk_en,
  output   wire           lsu_idu_lsiq_pop0_vld,
  output   wire           lsu_idu_lsiq_pop1_vld,
  output   wire  [11 :0]  lsu_idu_lsiq_pop_entry,
  output   wire           lsu_idu_lsiq_pop_vld,
  output   wire  [11 :0]  lsu_idu_rb_full,
  output   wire           lsu_idu_rb_full_gateclk_en,
  output   wire  [11 :0]  lsu_idu_secd,
  output   wire  [11 :0]  lsu_idu_spec_fail,
  output   wire  [11 :0]  lsu_idu_sq_full,
  output   wire           lsu_idu_sq_full_gateclk_en,
  output   wire  [11 :0]  lsu_idu_tlb_busy,
  output   wire           lsu_idu_tlb_busy_gateclk_en,
  output   wire  [11 :0]  lsu_idu_tlb_wakeup,
  output   wire  [11 :0]  lsu_idu_unalign_gateclk_en,
  output   wire  [11 :0]  lsu_idu_wait_fence,
  output   wire           lsu_idu_wait_fence_gateclk_en,
  output   wire  [11 :0]  lsu_idu_wait_old,
  output   wire           lsu_idu_wait_old_gateclk_en,
  output   wire  [11 :0]  lsu_idu_wakeup,
  output   reg   [3  :0]  lsu_pfu_l1_dist_sel,
  output   reg   [3  :0]  lsu_pfu_l2_dist_sel,
  output   wire           lsu_special_clk,
  output   wire           lsu_yy_xx_no_op
); 



// &Regs; @28

// &Wires; @29
wire             cp0_lsu_clk;                      
wire             cp0_lsu_clk_en;                   
wire    [3  :0]  cp0_lsu_l1_dist_sel;              
wire    [3  :0]  cp0_lsu_l2_dist_sel;              
wire             cp0_lsu_up_vld;                   
wire             ctrl_ld_clk_en;                   
wire             ctrl_st_clk_en;                   
wire    [11 :0]  ld_rf_imme_wakeup;                
wire             ld_rf_restart_vld;                
wire             lsu_hpcp_clk;                     
wire             lsu_hpcp_clk_en;                  
wire             lsu_hpcp_up_vld;                  
wire             lsu_pref_dist_up;                 
wire             lsu_special_clk_en;               
wire    [11 :0]  st_rf_imme_wakeup;                
wire             st_rf_restart_vld;                


parameter LSIQ_ENTRY=12;

//==========================================================
//              Instance of Global Gated Cell
//==========================================================
assign lsu_special_clk_en = ld_da_special_gateclk_en
                            ||  st_da_rb_create_gateclk_en
                            ||  wmb_write_req_icc
                            ||  icc_vb_create_gateclk_en
                            ||  pfu_lfb_create_gateclk_en
                            ||  !rb_empty
                            ||  !vb_empty
                            ||  !lfb_empty
                            ||  !vmb_empty
                            ||  lfb_pop_depd_ff
                            ||  !pfu_part_empty
                            ||  lsu_has_fence
                            ||  lm_lfb_depd_wakeup
			    ||  idu_lsu_vmb_create0_gateclk_en
			    ||  idu_lsu_vmb_create1_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_special_clk"); @51
gated_clk_cell  x_lsu_special_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lsu_special_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lsu_special_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @52
//          .external_en   (1'b0               ), @53
//          .global_en     (1'b1               ), @54
//          .module_en     (cp0_lsu_icg_en     ), @55
//          .local_en      (lsu_special_clk_en ), @56
//          .clk_out       (lsu_special_clk    )); @57

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//ctrl_ld_clk is used for ld pipe
assign ctrl_ld_clk_en = idu_lsu_rf_pipe3_gateclk_sel
                        ||  ld_ag_inst_vld
                        ||  ld_dc_inst_vld
                        ||  ld_da_inst_vld
                        ||  rb_ld_wb_cmplt_req
                        ||  ld_wb_inst_vld
                        ||  wmb_ld_wb_data_req
                        ||  vmb_ld_wb_data_req
                        ||  rb_ld_wb_data_req
                        ||  ld_wb_data_vld
                        ||  dcache_arb_ld_dc_borrow_vld_gate
                        ||  ld_dc_borrow_vld
                        ||  ld_da_borrow_vld;
// &Instance("gated_clk_cell", "x_lsu_ctrl_ld_clk"); @76
gated_clk_cell  x_lsu_ctrl_ld_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ctrl_ld_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ctrl_ld_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @77
//          .external_en   (1'b0               ), @78
//          .global_en     (1'b1               ), @79
//          .module_en     (cp0_lsu_icg_en     ), @80
//          .local_en      (ctrl_ld_clk_en     ), @81
//          .clk_out       (ctrl_ld_clk        )); @82

//ctrl_st_clk is used for st/sd pipe
assign ctrl_st_clk_en = idu_lsu_rf_pipe4_gateclk_sel
                        ||  st_ag_inst_vld
                        ||  idu_lsu_rf_pipe5_gateclk_sel
                        ||  sd_ex1_inst_vld
                        ||  st_dc_inst_vld
                        ||  st_da_inst_vld
                        ||  wmb_st_wb_cmplt_req
                        ||  st_wb_inst_vld
                        ||  dcache_arb_st_dc_borrow_vld_gate
                        ||  st_dc_borrow_vld
                        ||  st_da_borrow_vld;
// &Instance("gated_clk_cell", "x_lsu_ctrl_st_clk"); @96
gated_clk_cell  x_lsu_ctrl_st_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ctrl_st_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ctrl_st_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @97
//          .external_en   (1'b0               ), @98
//          .global_en     (1'b1               ), @99
//          .module_en     (cp0_lsu_icg_en     ), @100
//          .local_en      (ctrl_st_clk_en     ), @101
//          .clk_out       (ctrl_st_clk        )); @102

assign cp0_lsu_clk_en = cp0_lsu_up_vld;
// &Instance("gated_clk_cell", "x_cp0_lsu_gated_clk"); @105
gated_clk_cell  x_cp0_lsu_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (cp0_lsu_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (cp0_lsu_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @106
//          .external_en   (1'b0               ), @107
//          .global_en     (cp0_yy_clk_en      ), @108
//          .module_en     (cp0_lsu_icg_en     ), @109
//          .local_en      (cp0_lsu_clk_en     ), @110
//          .clk_out       (cp0_lsu_clk       )); @111

assign lsu_hpcp_clk_en  = lsu_hpcp_up_vld;
// &Instance("gated_clk_cell", "x_lsu_hpcp_gated_clk"); @115
gated_clk_cell  x_lsu_hpcp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lsu_hpcp_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (lsu_hpcp_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @116
//          .external_en   (1'b0               ), @117
//          .global_en     (cp0_yy_clk_en      ), @118
//          .module_en     (cp0_lsu_icg_en     ), @119
//          .local_en      (lsu_hpcp_clk_en    ), @120
//          .clk_out       (lsu_hpcp_clk       )); @121

//==========================================================
//                Generate cp0 signal
//==========================================================
//for timing, flop some cp0_lsu signals
assign cp0_lsu_l1_dist_sel[3:0] = {cp0_lsu_dcache_pref_dist[1]  &&  cp0_lsu_dcache_pref_dist[0],    //8x
                                  cp0_lsu_dcache_pref_dist[1]  &&  !cp0_lsu_dcache_pref_dist[0],    //4x
                                  !cp0_lsu_dcache_pref_dist[1]  &&  cp0_lsu_dcache_pref_dist[0],    //2x
                                  !cp0_lsu_dcache_pref_dist[1]  &&  !cp0_lsu_dcache_pref_dist[0]};  //1x

assign cp0_lsu_l2_dist_sel[3:0] = {cp0_lsu_l2_pref_dist[1]  &&  cp0_lsu_l2_pref_dist[0],    //8x
                                  cp0_lsu_l2_pref_dist[1]  &&  !cp0_lsu_l2_pref_dist[0],    //4x
                                  !cp0_lsu_l2_pref_dist[1]  &&  cp0_lsu_l2_pref_dist[0],    //2x
                                  !cp0_lsu_l2_pref_dist[1]  &&  !cp0_lsu_l2_pref_dist[0]};  //1x

assign lsu_pref_dist_up = (lsu_pfu_l1_dist_sel[3:0] 
                              !=  cp0_lsu_l1_dist_sel[3:0])
                          ||  (lsu_pfu_l2_dist_sel[3:0]
                              !=  cp0_lsu_l2_dist_sel[3:0]);

assign cp0_lsu_up_vld   =  lsu_pref_dist_up;

// &Force("output","lsu_pfu_l1_dist_sel"); @145
// &Force("output","lsu_pfu_l2_dist_sel"); @146
always @(posedge cp0_lsu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    lsu_pfu_l1_dist_sel[3:0]  <= 4'b0;
    lsu_pfu_l2_dist_sel[3:0]  <= 4'b0;
  end
  else if(cp0_lsu_up_vld)
  begin
    lsu_pfu_l1_dist_sel[3:0]  <=  cp0_lsu_l1_dist_sel[3:0];
    lsu_pfu_l2_dist_sel[3:0]  <=  cp0_lsu_l2_dist_sel[3:0];
  end
end

//==========================================================
//        interface to hpcp
//==========================================================
// &Force("output","lsu_hpcp_cache_read_access"); @170
// &Force("output","lsu_hpcp_cache_read_miss"); @171
// &Force("output","lsu_hpcp_cache_write_access"); @172
// &Force("output","lsu_hpcp_cache_write_miss"); @173
// &Force("output","lsu_hpcp_replay_discard_sq"); @174
// &Force("output","lsu_hpcp_replay_data_discard"); @175
// &Force("output","lsu_hpcp_ld_stall_cross_4k"); @176
// &Force("output","lsu_hpcp_ld_stall_other"); @177
// &Force("output","lsu_hpcp_st_stall_cross_4k"); @178
// &Force("output","lsu_hpcp_st_stall_other"); @179
// &Force("output","lsu_hpcp_fence_stall"); @180
// &Force("output","lsu_hpcp_unalign_inst"); @181

assign lsu_hpcp_up_vld  = (ld_da_inst_vld
                           || st_da_inst_vld
                           || ld_ag_inst_vld
                           || st_ag_inst_vld
                           || lsu_has_fence
                           || lsu_hpcp_cache_read_access
                           || lsu_hpcp_cache_read_miss
                           || lsu_hpcp_cache_write_access
                           || lsu_hpcp_cache_write_miss
                           || lsu_hpcp_replay_discard_sq
                           || lsu_hpcp_replay_data_discard
                           || lsu_hpcp_ld_stall_cross_4k
                           || lsu_hpcp_ld_stall_other
                           || lsu_hpcp_st_stall_cross_4k
                           || lsu_hpcp_st_stall_other
                           || lsu_hpcp_ld_unalign_inst
                           || lsu_hpcp_st_unalign_inst
                           || lsu_hpcp_fence_stall)
                          &&  hpcp_lsu_cnt_en;
always @(posedge lsu_hpcp_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    lsu_hpcp_cache_read_access    <= 1'b0;
    lsu_hpcp_cache_read_miss      <= 1'b0; 
    lsu_hpcp_cache_write_access   <= 1'b0;
    lsu_hpcp_cache_write_miss     <= 1'b0; 
    lsu_hpcp_replay_discard_sq    <= 1'b0; 
    lsu_hpcp_replay_data_discard  <= 1'b0; 
    lsu_hpcp_ld_stall_cross_4k    <= 1'b0; 
    lsu_hpcp_ld_stall_other       <= 1'b0;
    lsu_hpcp_st_stall_cross_4k    <= 1'b0; 
    lsu_hpcp_st_stall_other       <= 1'b0;
    lsu_hpcp_unalign_inst[1:0]    <= 2'b0; 
    lsu_hpcp_fence_stall          <= 1'b0; 
  end
  else if(lsu_hpcp_up_vld)
  begin
    lsu_hpcp_cache_read_access    <= lsu_hpcp_ld_cache_access;
    lsu_hpcp_cache_read_miss      <= lsu_hpcp_ld_cache_miss;
    lsu_hpcp_cache_write_access   <= lsu_hpcp_st_cache_access;
    lsu_hpcp_cache_write_miss     <= lsu_hpcp_st_cache_miss;
    lsu_hpcp_replay_discard_sq    <= lsu_hpcp_ld_discard_sq; 
    lsu_hpcp_replay_data_discard  <= lsu_hpcp_ld_data_discard; 
    lsu_hpcp_ld_stall_cross_4k    <= lsu_hpcp_ld_cross_4k_stall; 
    lsu_hpcp_ld_stall_other       <= lsu_hpcp_ld_other_stall; 
    lsu_hpcp_st_stall_cross_4k    <= lsu_hpcp_st_cross_4k_stall; 
    lsu_hpcp_st_stall_other       <= lsu_hpcp_st_other_stall; 
    lsu_hpcp_unalign_inst[1:0]    <= {1'b0,lsu_hpcp_ld_unalign_inst} + {1'b0,lsu_hpcp_st_unalign_inst}; 
    lsu_hpcp_fence_stall          <= lsu_has_fence; 
  end
end

//==========================================================
//        Pipeline signal
//==========================================================
//------------------rf stage--------------------------------
assign ld_rf_restart_vld                  = idu_lsu_rf_pipe3_sel
                                            &&  ld_ag_stall_ori;
assign ld_rf_imme_wakeup[LSIQ_ENTRY-1:0]  = ld_ag_stall_restart_entry[LSIQ_ENTRY-1:0]
                                            & {LSIQ_ENTRY{ld_rf_restart_vld}};

assign st_rf_restart_vld                  = idu_lsu_rf_pipe4_sel
                                            &&  st_ag_stall_ori;
assign st_rf_imme_wakeup[LSIQ_ENTRY-1:0]  = st_ag_stall_restart_entry[LSIQ_ENTRY-1:0]
                                            & {LSIQ_ENTRY{st_rf_restart_vld}};
//------------------ag stage--------------------------------
assign lsu_idu_tlb_busy[LSIQ_ENTRY-1:0]   = ld_dc_idu_tlb_busy[LSIQ_ENTRY-1:0]
                                            | st_dc_idu_tlb_busy[LSIQ_ENTRY-1:0];
//------------------dc stage--------------------------------
assign lsu_idu_lq_full[LSIQ_ENTRY-1:0]    = ld_dc_idu_lq_full[LSIQ_ENTRY-1:0];
assign lsu_idu_sq_full[LSIQ_ENTRY-1:0]    = st_dc_idu_sq_full[LSIQ_ENTRY-1:0];
//------------------da stage--------------------------------
assign lsu_idu_wait_fence[LSIQ_ENTRY-1:0] = ld_da_idu_wait_fence[LSIQ_ENTRY-1:0]
                                            | st_da_idu_wait_fence[LSIQ_ENTRY-1:0];
assign lsu_idu_rb_full[LSIQ_ENTRY-1:0]    = ld_da_idu_rb_full[LSIQ_ENTRY-1:0]
                                            | st_da_idu_rb_full[LSIQ_ENTRY-1:0];
assign lsu_idu_already_da[LSIQ_ENTRY-1:0] = ld_da_idu_already_da[LSIQ_ENTRY-1:0]
                                            | st_da_idu_already_da[LSIQ_ENTRY-1:0];

//---------------boundary signal----------------------------
assign lsu_idu_unalign_gateclk_en[LSIQ_ENTRY-1:0] = 
                ld_da_idu_boundary_gateclk_en[LSIQ_ENTRY-1:0]
                | st_da_idu_boundary_gateclk_en[LSIQ_ENTRY-1:0];

assign lsu_idu_secd[LSIQ_ENTRY-1:0]       = ld_da_idu_secd[LSIQ_ENTRY-1:0]
                                            | st_da_idu_secd[LSIQ_ENTRY-1:0];
assign lsu_idu_spec_fail[LSIQ_ENTRY-1:0]  = ld_da_idu_spec_fail[LSIQ_ENTRY-1:0]
                                            | st_da_idu_spec_fail[LSIQ_ENTRY-1:0];
assign lsu_idu_bkpta_data[LSIQ_ENTRY-1:0] = ld_da_idu_bkpta_data[LSIQ_ENTRY-1:0]
                                            | st_da_idu_bkpta_data[LSIQ_ENTRY-1:0];
assign lsu_idu_bkptb_data[LSIQ_ENTRY-1:0] = ld_da_idu_bkptb_data[LSIQ_ENTRY-1:0]
                                            | st_da_idu_bkptb_data[LSIQ_ENTRY-1:0];

//------------------pop signals-----------------------------
assign lsu_idu_lsiq_pop_vld               = ld_da_idu_pop_vld
                                            ||  st_da_idu_pop_vld;
assign lsu_idu_lsiq_pop_entry[LSIQ_ENTRY-1:0] = ld_da_idu_pop_entry[LSIQ_ENTRY-1:0]
                                                | st_da_idu_pop_entry[LSIQ_ENTRY-1:0];
//--------------pop num-----------------
//assign lsu_idu_lsiq_pop_num[3:0]  = {2'b0,
//                                    ld_da_lsiq_pop_vld  &  st_da_lsiq_pop_vld,
//                                    ld_da_lsiq_pop_vld  ^  st_da_lsiq_pop_vld};
assign lsu_idu_lsiq_pop0_vld = ld_da_idu_pop_vld;
assign lsu_idu_lsiq_pop1_vld = st_da_idu_pop_vld;

//--------------gateclk-----------------
assign lsu_idu_lq_full_gateclk_en   = ld_dc_lq_full_gateclk_en;
assign lsu_idu_sq_full_gateclk_en   = st_dc_sq_full_gateclk_en;
assign lsu_idu_tlb_busy_gateclk_en  = ld_dc_tlb_busy_gateclk_en
                                      ||  st_dc_tlb_busy_gateclk_en;
assign lsu_idu_rb_full_gateclk_en   = ld_da_rb_full_gateclk_en
                                      ||  st_da_rb_full_gateclk_en;
assign lsu_idu_wait_fence_gateclk_en= ld_da_wait_fence_gateclk_en
                                      ||  st_da_wait_fence_gateclk_en;

//==========================================================
//        Imme & Buffer maintain restart
//==========================================================
assign lsu_idu_wakeup[LSIQ_ENTRY-1:0]       = ld_rf_imme_wakeup[LSIQ_ENTRY-1:0]
                                              | st_rf_imme_wakeup[LSIQ_ENTRY-1:0]
                                              | ld_dc_imme_wakeup[LSIQ_ENTRY-1:0]
                                              | st_dc_imme_wakeup[LSIQ_ENTRY-1:0]
                                              | ld_da_idu_secd[LSIQ_ENTRY-1:0]
                                              | ld_da_ecc_wakeup[LSIQ_ENTRY-1:0]
                                              | st_da_idu_secd[LSIQ_ENTRY-1:0]
                                              | st_da_ecc_wakeup[LSIQ_ENTRY-1:0]
                                              | sq_global_depd_wakeup[LSIQ_ENTRY-1:0]
                                              | sq_data_depd_wakeup[LSIQ_ENTRY-1:0]
                                              | wmb_depd_wakeup[LSIQ_ENTRY-1:0]
                                              | lfb_depd_wakeup[LSIQ_ENTRY-1:0];

assign lsu_idu_tlb_wakeup[LSIQ_ENTRY-1:0] = mmu_lsu_tlb_wakeup[LSIQ_ENTRY-1:0];

//merge idu wakeup
assign lsu_idu_wait_old[LSIQ_ENTRY-1:0] = lsu_idu_ld_ag_wait_old[LSIQ_ENTRY-1:0]
                                          | lsu_idu_st_ag_wait_old[LSIQ_ENTRY-1:0]
                                          | lsu_idu_ld_da_wait_old[LSIQ_ENTRY-1:0];

assign lsu_idu_wait_old_gateclk_en = lsu_idu_ld_ag_wait_old_gateclk_en
                                     | lsu_idu_st_ag_wait_old_gateclk_en
                                     | lsu_idu_ld_da_wait_old_gateclk_en;
//==========================================================
//                Generate no_op signal
//==========================================================
assign lsu_had_no_op    = wmb_no_op
                          &&  sq_empty
                          &&  rb_empty
                          &&  lfb_empty
                          &&  vmb_empty
                          &&  vb_empty;

assign lsu_yy_xx_no_op  = wmb_empty
                          &&  sq_empty
                          &&  rb_empty
                          &&  lfb_empty
                          &&  vmb_empty
                          &&  vb_empty;


assign lsu_had_debug_info[183:0] = {lsu_had_amr_state[2:0],
      lsu_had_icc_state[2:0],
      lsu_had_lfb_addr_entry_vld[7:0],
      lsu_had_lfb_addr_entry_rcl_done[7:0],
      lsu_had_lfb_addr_entry_dcache_hit[7:0],
      lsu_had_lfb_data_entry_vld[1:0],
      lsu_had_lfb_data_entry_last[1:0],
      lsu_had_lfb_lf_sm_vld,
      lsu_had_lfb_wakeup_queue[12:0],
      lsu_had_vb_addr_entry_vld[1:0],
      lsu_had_vb_data_entry_vld[2:0],
      lsu_had_vb_rcl_sm_state[3:0],
      lsu_had_lm_state[2:0],
      lsu_had_mcic_data_req,
      lsu_had_mcic_frz,
      lsu_had_rb_entry_fence[7:0],
      lsu_had_rb_entry_state_0[3:0],
      lsu_had_rb_entry_state_1[3:0],
      lsu_had_rb_entry_state_2[3:0],
      lsu_had_rb_entry_state_3[3:0],
      lsu_had_rb_entry_state_4[3:0],
      lsu_had_rb_entry_state_5[3:0],
      lsu_had_rb_entry_state_6[3:0],
      lsu_had_rb_entry_state_7[3:0],
      lsu_had_sq_not_empty,
      lsu_had_wmb_ar_pending,
      lsu_had_wmb_aw_pending,
      lsu_had_wmb_w_pending,
      lsu_had_wmb_entry_vld[7:0],
      lsu_had_wmb_create_ptr[7:0],
      lsu_had_wmb_write_ptr[7:0],
      lsu_had_wmb_data_ptr[7:0],
      lsu_had_wmb_read_ptr[7:0],
      lsu_had_wmb_write_imme,
      lsu_had_snq_entry_vld[5:0],
      lsu_had_snq_entry_issued[5:0],
      lsu_had_snoop_tag_req,
      lsu_had_snoop_data_req,
      lsu_had_sdb_entry_vld[2:0],
      lsu_had_cdr_state[1:0],
      lsu_had_ctcq_entry_vld[5:0],
      lsu_had_ctcq_entry_cmplt[5:0],
      lsu_had_ctcq_entry_2_cmplt[5:0]      
      };

// &ModuleEnd; @389
endmodule


