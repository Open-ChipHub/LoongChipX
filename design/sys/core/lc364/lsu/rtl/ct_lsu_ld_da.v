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

// &ModuleBeg; @28
module ct_lsu_ld_da (
  // &Ports, @29
  input    wire  [127:0]  cb_ld_da_data,
  input    wire           cb_ld_da_data_vld,
  input    wire           cp0_lsu_dcache_en,
  input    wire           cp0_lsu_icg_en,
  input    wire           cp0_lsu_l2_pref_en,
  input    wire           cp0_lsu_nsfe,
  input    wire           cp0_yy_clk_en,
  input    wire           cp0_yy_dcache_pref_en,
  input    wire           cpurst_b,
  input    wire           ctrl_ld_clk,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank0_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank1_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank2_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank3_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank4_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank5_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank6_dout,
  input    wire  [31 :0]  dcache_lsu_ld_data_bank7_dout,
  input    wire           forever_cpuclk,
  input    wire  [39 :0]  ld_dc_addr0,
  input    wire           ld_dc_ahead_predict,
  input    wire           ld_dc_ahead_preg_wb_vld,
  input    wire           ld_dc_ahead_vreg_wb_vld,
  input    wire           ld_dc_already_da,
  input    wire           ld_dc_atomic,
  input    wire           ld_dc_bkpta_data,
  input    wire           ld_dc_bkptb_data,
  input    wire  [2  :0]  ld_dc_borrow_db,
  input    wire           ld_dc_borrow_icc,
  input    wire           ld_dc_borrow_icc_tag,
  input    wire           ld_dc_borrow_mmu,
  input    wire           ld_dc_borrow_sndb,
  input    wire           ld_dc_borrow_vb,
  input    wire           ld_dc_borrow_vld,
  input    wire           ld_dc_boundary,
  input    wire  [15 :0]  ld_dc_da_bytes_vld,
  input    wire  [15 :0]  ld_dc_da_bytes_vld1,
  input    wire           ld_dc_da_cb_addr_create,
  input    wire           ld_dc_da_cb_merge_en,
  input    wire  [7  :0]  ld_dc_da_data_rot_sel,
  input    wire           ld_dc_da_expt_vld_gate_en,
  input    wire           ld_dc_da_icc_tag_vld,
  input    wire           ld_dc_da_inst_vld,
  input    wire           ld_dc_da_old,
  input    wire           ld_dc_da_page_buf,
  input    wire           ld_dc_da_page_ca,
  input    wire           ld_dc_da_page_sec,
  input    wire           ld_dc_da_page_share,
  input    wire           ld_dc_da_page_so,
  input    wire           ld_dc_da_pf_inst,
  input    wire  [26 :0]  ld_dc_da_tag_read,
  input    wire           ld_dc_dcache_hit,
  input    wire           ld_dc_expt_access_fault_extra,
  input    wire           ld_dc_expt_access_fault_mask,
  input    wire  [14  :0] ld_dc_expt_vec,
  input    wire           ld_dc_expt_vld_except_access_err,
  input    wire  [15 :0]  ld_dc_fwd_bytes_vld,
  input    wire           ld_dc_fwd_sq_vld,
  input    wire           ld_dc_fwd_wmb_vld,
  input    wire  [3  :0]  ld_dc_get_dcache_data,
  input    wire           ld_dc_hit_high_region,
  input    wire           ld_dc_hit_low_region,
  input    wire  [6  :0]  ld_dc_iid,
  input    wire  [2  :0]  ld_dc_inst_size,
  input    wire  [1  :0]  ld_dc_inst_type,
  input    wire  [31 :0]  ld_dc_inst_code,
  input    wire           ld_dc_inst_vfls,
  input    wire           ld_dc_inst_vld,
  input    wire  [14 :0]  ld_dc_ldfifo_pc,
  input    wire  [11 :0]  ld_dc_lsid,
  input    wire           ld_dc_mmu_req,
  input    wire  [63 :0]  ld_dc_mt_value,
  input    wire           ld_dc_no_spec,
  input    wire           ld_dc_no_spec_exist,
  input    wire           ld_dc_pfu_info_set_vld,
  input    wire  [39 :0]  ld_dc_pfu_va,
  input    wire  [6  :0]  ld_dc_preg,
  input    wire  [3  :0]  ld_dc_preg_sign_sel,
  input    wire           ld_dc_secd,
  input    wire           ld_dc_settle_way,
  input    wire           ld_dc_sign_extend,
  input    wire           ld_dc_spec_fail,
  input    wire           ld_dc_split,
  input    wire           ld_dc_vector_nop,
  input    wire  [5  :0]  ld_dc_vreg,
  input    wire           ld_dc_vreg_sign_sel,
  input    wire           ld_dc_wait_fence,
  input    wire           ld_hit_prefetch,
  input    wire           lfb_ld_da_hit_idx,
  input    wire           lm_ld_da_hit_idx,
  input    wire           lsu_special_clk,
  input    wire           mmu_lsu_access_fault0,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [39 :0]  pfu_biu_req_addr,
  input    wire           rb_ld_da_full,
  input    wire           rb_ld_da_hit_idx,
  input    wire           rb_ld_da_merge_fail,
  input    wire           rtu_yy_xx_commit0,
  input    wire  [6  :0]  rtu_yy_xx_commit0_iid,
  input    wire           rtu_yy_xx_commit1,
  input    wire  [6  :0]  rtu_yy_xx_commit1_iid,
  input    wire           rtu_yy_xx_commit2,
  input    wire  [6  :0]  rtu_yy_xx_commit2_iid,
  input    wire           rtu_yy_xx_flush,
  input    wire  [127:0]  sd_ex1_data_bypass,
  input    wire           sd_ex1_inst_vld,
  input    wire           sf_spec_hit,
  input    wire           sf_spec_mark,
  input    wire  [63 :0]  sq_ld_da_fwd_data,
  input    wire  [63 :0]  sq_ld_da_fwd_data_pe,
  input    wire           sq_ld_dc_data_discard_req,
  input    wire           sq_ld_dc_fwd_bypass_multi,
  input    wire           sq_ld_dc_fwd_bypass_req,
  input    wire  [11 :0]  sq_ld_dc_fwd_id,
  input    wire           sq_ld_dc_fwd_multi,
  input    wire           sq_ld_dc_fwd_multi_mask,
  input    wire           sq_ld_dc_newest_fwd_data_vld_req,
  input    wire           sq_ld_dc_other_discard_req,
  input    wire  [39 :0]  st_da_addr,
  input    wire  [127:0]  wmb_ld_da_fwd_data,
  input    wire           wmb_ld_dc_discard_req,
  output   wire  [39 :0]  ld_da_addr,
  output   reg            ld_da_bkpta_data,
  output   reg            ld_da_bkptb_data,
  output   reg            ld_da_borrow_vld,
  output   wire           ld_da_boundary_after_mask,
  output   reg   [15 :0]  ld_da_bytes_vld,
  output   wire  [127:0]  ld_da_cb_data,
  output   wire           ld_da_cb_data_vld,
  output   wire           ld_da_cb_ecc_cancel,
  output   wire           ld_da_cb_ld_inst_vld,
  output   wire  [255:0]  ld_da_data256,
  output   wire  [63 :0]  ld_da_data_ori,
  output   reg   [7  :0]  ld_da_data_rot_sel,
  output   reg            ld_da_dcache_hit,
  output   wire  [11 :0]  ld_da_ecc_wakeup,
  output   wire           ld_da_fwd_ecc_stall,
  output   wire  [127:0]  ld_da_icc_read_data,
  output   wire  [11 :0]  ld_da_idu_already_da,
  output   wire  [11 :0]  ld_da_idu_bkpta_data,
  output   wire  [11 :0]  ld_da_idu_bkptb_data,
  output   wire  [11 :0]  ld_da_idu_boundary_gateclk_en,
  output   wire  [11 :0]  ld_da_idu_pop_entry,
  output   wire           ld_da_idu_pop_vld,
  output   wire  [11 :0]  ld_da_idu_rb_full,
  output   wire  [11 :0]  ld_da_idu_secd,
  output   wire  [11 :0]  ld_da_idu_spec_fail,
  output   wire  [11 :0]  ld_da_idu_wait_fence,
  output   wire  [7  :0]  ld_da_idx,
  output   reg   [6  :0]  ld_da_iid,
  output   reg   [2  :0]  ld_da_inst_size,
  output   reg            ld_da_inst_vfls,
  output   reg            ld_da_inst_vld,
  output   reg   [14 :0]  ld_da_ldfifo_pc,
  output   wire           ld_da_lfb_discard_grnt,
  output   wire           ld_da_lfb_set_wakeup_queue,
  output   wire  [12 :0]  ld_da_lfb_wakeup_queue_next,
  output   wire           ld_da_lm_discard_grnt,
  output   wire           ld_da_lm_ecc_err,
  output   wire           ld_da_lm_no_req,
  output   wire           ld_da_lm_vector_nop,
  output   reg   [11 :0]  ld_da_lsid,
  output   wire           ld_da_mcic_borrow_mmu,
  output   wire           ld_da_mcic_borrow_mmu_req,
  output   wire  [63 :0]  ld_da_mcic_bypass_data,
  output   wire           ld_da_mcic_data_err,
  output   wire           ld_da_mcic_rb_full,
  output   wire           ld_da_mcic_wakeup,
  output   reg            ld_da_old,
  output   reg            ld_da_page_buf,
  output   reg            ld_da_page_ca,
  output   reg            ld_da_page_sec,
  output   reg            ld_da_page_sec_ff,
  output   reg            ld_da_page_share,
  output   reg            ld_da_page_share_ff,
  output   reg            ld_da_page_so,
  output   wire           ld_da_pfu_act_dp_vld,
  output   wire           ld_da_pfu_act_vld,
  output   wire           ld_da_pfu_biu_req_hit_idx,
  output   wire           ld_da_pfu_evict_cnt_vld,
  output   wire           ld_da_pfu_pf_inst_vld,
  output   reg   [39 :0]  ld_da_pfu_va,
  output   reg   [39 :0]  ld_da_ppfu_va,
  output   reg   [27 :0]  ld_da_ppn_ff,
  output   reg   [6  :0]  ld_da_preg,
  output   reg   [3  :0]  ld_da_preg_sign_sel,
  output   wire           ld_da_rb_atomic,
  output   wire           ld_da_rb_cmit,
  output   wire           ld_da_rb_cmplt_success,
  output   wire           ld_da_rb_create_dp_vld,
  output   wire           ld_da_rb_create_gateclk_en,
  output   wire           ld_da_rb_create_judge_vld,
  output   wire           ld_da_rb_create_lfb,
  output   wire           ld_da_rb_create_vld,
  output   wire           ld_da_rb_data_vld,
  output   wire           ld_da_rb_dest_vld,
  output   wire           ld_da_rb_discard_grnt,
  output   wire           ld_da_rb_full_gateclk_en,
  output   wire           ld_da_rb_ldamo,
  output   wire           ld_da_rb_merge_dp_vld,
  output   wire           ld_da_rb_merge_expt_vld,
  output   wire           ld_da_rb_merge_gateclk_en,
  output   wire           ld_da_rb_merge_vld,
  output   wire  [35 :0]  ld_da_sf_addr_tto4,
  output   wire  [15 :0]  ld_da_sf_bytes_vld,
  output   wire           ld_da_sf_spec_chk_req,
  output   reg            ld_da_sign_extend,
  output   wire           ld_da_snq_borrow_icc,
  output   wire           ld_da_snq_borrow_sndb,
  output   wire           ld_da_special_gateclk_en,
  output   wire           ld_da_sq_data_discard_vld,
  output   reg   [11 :0]  ld_da_sq_fwd_id,
  output   wire           ld_da_sq_fwd_multi_vld,
  output   wire           ld_da_sq_global_discard_vld,
  output   wire           ld_da_st_da_hit_idx,
  output   wire  [2  :0]  ld_da_vb_borrow_vb,
  output   wire           ld_da_vb_snq_data_reissue,
  output   reg   [5  :0]  ld_da_vreg,
  output   reg            ld_da_vreg_sign_sel,
  output   wire           ld_da_wait_fence_gateclk_en,
  output   wire           ld_da_wb_cmplt_req,
  output   wire  [63 :0]  ld_da_wb_data,
  output   wire           ld_da_wb_data_req,
  output   wire           ld_da_wb_data_req_gateclk_en,
  output   reg   [14 :0]  ld_da_wb_expt_vec,
  output   wire           ld_da_wb_expt_vld,
  output   wire  [63 :0]  ld_da_wb_mt_value,
  output   wire           ld_da_wb_no_spec_hit,
  output   wire           ld_da_wb_no_spec_mispred,
  output   wire           ld_da_wb_no_spec_miss,
  output   wire           ld_da_wb_spec_fail,
  output   wire  [1  :0]  ld_da_wb_vreg_sign_sel,
  output   wire           ld_da_wmb_discard_vld,
  output   wire           lsu_hpcp_ld_cache_access,
  output   wire           lsu_hpcp_ld_cache_miss,
  output   wire           lsu_hpcp_ld_data_discard,
  output   wire           lsu_hpcp_ld_discard_sq,
  output   wire           lsu_hpcp_ld_unalign_inst,
  output   wire  [6  :0]  lsu_idu_da_pipe3_fwd_preg,
  output   wire  [63 :0]  lsu_idu_da_pipe3_fwd_preg_data,
  output   wire           lsu_idu_da_pipe3_fwd_preg_vld,
  output   wire  [6  :0]  lsu_idu_da_pipe3_fwd_vreg,
  output   wire  [63 :0]  lsu_idu_da_pipe3_fwd_vreg_fr_data,
  output   wire           lsu_idu_da_pipe3_fwd_vreg_vld,
  output   wire  [63 :0]  lsu_idu_da_pipe3_fwd_vreg_vr0_data,
  output   wire  [63 :0]  lsu_idu_da_pipe3_fwd_vreg_vr1_data,
  output   wire  [11 :0]  lsu_idu_ld_da_wait_old,
  output   wire           lsu_idu_ld_da_wait_old_gateclk_en,
  output   wire  [6  :0]  lsu_rtu_da_pipe3_split_spec_fail_iid,
  output   wire           lsu_rtu_da_pipe3_split_spec_fail_vld
); 



// &Regs; @30
reg     [39 :0]  ld_da_addr0;                         
reg     [8  :0]  ld_da_addr0_idx;                     
reg              ld_da_ahead_predict;                 
reg              ld_da_ahead_preg_wb_vld;             
reg              ld_da_ahead_vreg_wb_vld;             
reg              ld_da_already_da;                    
reg              ld_da_atomic;                        
reg     [2  :0]  ld_da_borrow_db;                     
reg              ld_da_borrow_icc;                    
reg              ld_da_borrow_icc_tag;                
reg              ld_da_borrow_mmu;                    
reg              ld_da_borrow_sndb;                   
reg              ld_da_borrow_vb;                     
reg              ld_da_boundary;                      
reg     [15 :0]  ld_da_bytes_vld1;                    
reg              ld_da_cb_addr_create;                
reg              ld_da_cb_merge_en;                   
reg              ld_da_data_discard_sq;               
reg              ld_da_data_vld_newest_fwd_sq_dup0;   
reg              ld_da_data_vld_newest_fwd_sq_dup1;   
reg              ld_da_data_vld_newest_fwd_sq_dup2;   
reg              ld_da_data_vld_newest_fwd_sq_dup3;   
reg     [31 :0]  ld_da_dcache_data_bank0;             
reg     [31 :0]  ld_da_dcache_data_bank1;             
reg     [31 :0]  ld_da_dcache_data_bank2;             
reg     [31 :0]  ld_da_dcache_data_bank3;             
reg     [31 :0]  ld_da_dcache_data_bank4;             
reg     [31 :0]  ld_da_dcache_data_bank5;             
reg     [31 :0]  ld_da_dcache_data_bank6;             
reg     [31 :0]  ld_da_dcache_data_bank7;             
reg              ld_da_discard_wmb;                   
reg              ld_da_expt_access_fault_extra;       
reg              ld_da_expt_access_fault_mask;        
reg              ld_da_expt_access_fault_mmu;         
reg     [14  :0] ld_da_expt_vec;                      
reg              ld_da_expt_vld_except_access_err;    
reg              ld_da_fwd_bypass_sq_multi;           
reg     [15 :0]  ld_da_fwd_bytes_vld;                 
reg     [15 :0]  ld_da_fwd_bytes_vld_dup;             
reg     [127:0]  ld_da_fwd_data_bypass;               
reg              ld_da_fwd_sq_bypass;                 
reg              ld_da_fwd_sq_multi;                  
reg              ld_da_fwd_sq_multi_mask;             
reg              ld_da_fwd_sq_vld;                    
reg              ld_da_fwd_wmb_vld;                   
reg              ld_da_hit_high_region;               
reg              ld_da_hit_high_region_dup0;          
reg              ld_da_hit_high_region_dup1;          
reg              ld_da_hit_high_region_dup2;          
reg              ld_da_hit_high_region_dup3;          
reg              ld_da_hit_low_region;                
reg              ld_da_hit_low_region_dup0;           
reg              ld_da_hit_low_region_dup1;           
reg              ld_da_hit_low_region_dup2;           
reg              ld_da_hit_low_region_dup3;           
reg     [31 :0]  ld_da_inst_code;                        
reg     [1  :0]  ld_da_inst_type;                     
reg              ld_da_mmu_req;                       
reg     [63 :0]  ld_da_mt_value;                      
reg              ld_da_no_spec;                       
reg              ld_da_no_spec_exist;                 
reg              ld_da_other_discard_sq;              
reg              ld_da_pf_inst;                       
reg     [63 :0]  ld_da_preg_data_sign_extend;         
reg              ld_da_secd;                          
reg              ld_da_settle_way;                    
reg              ld_da_spec_fail;                     
reg              ld_da_split;                         
reg              ld_da_split_miss_ff;                 
reg     [26 :0]  ld_da_tag_read;                      
reg              ld_da_vector_nop;                    
reg              ld_da_wait_fence;                    
reg     [63 :0]  ld_da_wb_mt_value_ori;               

// &Wires; @31
wire    [127:0]  ld_da_ahead_preg_data_settle;        
wire    [63 :0]  ld_da_ahead_preg_data_sign0;         
wire    [63 :0]  ld_da_ahead_preg_data_sign1;         
wire    [63 :0]  ld_da_ahead_preg_data_sign2;         
wire    [63 :0]  ld_da_ahead_preg_data_sign3;         
wire    [127:0]  ld_da_ahead_preg_data_unsettle;      
wire             ld_da_borrow_clk;                    
wire             ld_da_borrow_clk_en;                 
wire             ld_da_borrow_db_vld;                 
wire             ld_da_boundary_cross_2k;             
wire             ld_da_boundary_first;                
wire    [127:0]  ld_da_cb_bypass_data_am;             
wire    [127:0]  ld_da_cb_bypass_data_for_merge;      
wire             ld_da_clk;                           
wire             ld_da_clk_en;                        
wire             ld_da_cmit_hit0;                     
wire             ld_da_cmit_hit1;                     
wire             ld_da_cmit_hit2;                     
wire    [39 :0]  ld_da_cmp_pfu_biu_req_addr;          
wire    [39 :0]  ld_da_cmp_st_da_addr;                
wire             ld_da_data0_clk;                     
wire             ld_da_data0_clk_en;                  
wire    [127:0]  ld_da_data128;                       
wire             ld_da_data1_clk;                     
wire             ld_da_data1_clk_en;                  
wire    [255:0]  ld_da_data256_way0;                  
wire    [255:0]  ld_da_data256_way1;                  
wire             ld_da_data2_clk;                     
wire             ld_da_data2_clk_en;                  
wire             ld_da_data3_clk;                     
wire             ld_da_data3_clk_en;                  
wire             ld_da_data_discard_sq_final;         
wire             ld_da_data_discard_sq_req;           
wire    [127:0]  ld_da_data_settle;                   
wire    [127:0]  ld_da_data_unrot;                    
wire             ld_da_data_vld;                      
wire    [127:0]  ld_da_dcache_data128_ahead_am;       
wire    [127:0]  ld_da_dcache_data_after_merge;       
wire             ld_da_dcache_miss;                   
wire    [127:0]  ld_da_dcache_pass_data128_ahead_am;  
wire    [127:0]  ld_da_dcache_pass_data128_am;        
wire             ld_da_discard_dc_req;                
wire             ld_da_discard_from_lfb_req;          
wire             ld_da_discard_from_lm_req;           
wire             ld_da_discard_from_rb_req;           
wire             ld_da_discard_wmb_final;             
wire             ld_da_discard_wmb_req;               
wire             ld_da_ecc_data_req_mask;             
wire             ld_da_ecc_mcic_wakup;                
wire             ld_da_ecc_spec_fail;                 
wire             ld_da_ecc_stall;                     
wire             ld_da_ecc_stall_already;             
wire             ld_da_ecc_stall_fatal;               
wire             ld_da_ecc_stall_gate;                
wire             ld_da_expt_access_fault;             
wire             ld_da_expt_clk;                      
wire             ld_da_expt_clk_en;                   
wire             ld_da_expt_ori;                      
wire             ld_da_expt_vld;                      
wire             ld_da_ff_clk;                        
wire             ld_da_ff_clk_en;                     
wire             ld_da_fof_not_first;                 
wire    [127:0]  ld_da_fwd_data_am;                   
wire    [127:0]  ld_da_fwd_data_pe_am;                
wire             ld_da_fwd_sq_bypass_vld;             
wire    [127:0]  ld_da_fwd_sq_data_am;                
wire    [127:0]  ld_da_fwd_sq_data_pe_am;             
wire             ld_da_fwd_sq_multi_final;            
wire             ld_da_fwd_sq_multi_req;              
wire             ld_da_fwd_vld;                       
wire    [127:0]  ld_da_fwd_wmb_data_am;               
wire    [127:0]  ld_da_high_region_data128_am;        
wire             ld_da_hit_idx_discard_req;           
wire             ld_da_hit_idx_discard_vld;           
wire    [127:0]  ld_da_icc_data_read;                 
wire    [127:0]  ld_da_icc_tag_read;                  
wire             ld_da_idu_boundary_gateclk_vld;      
wire             ld_da_idu_secd_vld;                  
wire             ld_da_inst_clk;                      
wire             ld_da_inst_clk_en;                   
wire             ld_da_inst_cmplt;                    
wire             ld_da_inst_fof;                      
wire             ld_da_ld_inst;                       
wire             ld_da_ldamo_inst;                    
wire    [127:0]  ld_da_low_region_data128_am;         
wire             ld_da_lr_inst;                       
wire    [11 :0]  ld_da_mask_lsid;                     
wire    [63 :0]  ld_da_mcic_bypass_data_ori;          
wire             ld_da_merge_from_cb;                 
wire             ld_da_merge_mask;                    
wire             ld_da_other_discard_sq_req;          
wire             ld_da_other_discard_sq_vld;          
wire             ld_da_pfu_info_clk;                  
wire             ld_da_pfu_info_clk_en;               
wire             ld_da_rb_create_vld_unmask;          
wire             ld_da_rb_full_req;                   
wire             ld_da_rb_full_vld;                   
wire             ld_da_rb_merge_vld_unmask;           
wire             ld_da_restart_no_cache;              
wire             ld_da_restart_vld;                   
wire             ld_da_spec_chk_req;                  
wire             ld_da_split_last;                    
wire             ld_da_split_miss;                    
wire             ld_da_sq_fwd_ecc_discard;            
wire             ld_da_tag_clk;                       
wire             ld_da_tag_clk_en;                    
wire             ld_da_tag_ecc_stall_ori;             
wire             ld_da_wait_fence_req;                
wire             ld_da_wait_fence_vld;                
wire             ld_da_wb_data_req_mask;              
wire    [127:0]  sq_ld_da_fwd_data_128;               
wire    [127:0]  sq_ld_da_fwd_data_pe_128;            
wire    [127:0]  wmb_ld_da_fwd_data_128;              


parameter VB_DATA_ENTRY = 3,
          LSIQ_ENTRY    = 12,
          SQ_ENTRY      = 12,
          WMB_ENTRY     = 8,
          VMB_ENTRY     = 8;
parameter PC_LEN        = 15;
parameter PC_WIDTH      = 64;

parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;
//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//------------------normal reg------------------------------
assign ld_da_clk_en = ld_dc_inst_vld
                      ||  ld_da_ecc_stall_gate
                      ||  ld_dc_borrow_vld
                          && ld_dc_borrow_mmu;
// &Instance("gated_clk_cell", "x_lsu_ld_da_gated_clk"); @52
gated_clk_cell  x_lsu_ld_da_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @53
//          .external_en   (1'b0               ), @54
//          .global_en     (1'b1               ), @55
//          .module_en     (cp0_lsu_icg_en     ), @56
//          .local_en      (ld_da_clk_en       ), @57
//          .clk_out       (ld_da_clk          )); @58

assign ld_da_inst_clk_en = ld_dc_inst_vld;
// &Instance("gated_clk_cell", "x_lsu_ld_da_inst_gated_clk"); @61
gated_clk_cell  x_lsu_ld_da_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_inst_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ld_da_inst_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @62
//          .external_en   (1'b0               ), @63
//          .global_en     (cp0_yy_clk_en      ), @64
//          .module_en     (cp0_lsu_icg_en     ), @65
//          .local_en      (ld_da_inst_clk_en  ), @66
//          .clk_out       (ld_da_inst_clk     )); @67

assign ld_da_borrow_clk_en = ld_dc_borrow_vld;
// &Instance("gated_clk_cell", "x_lsu_ld_da_borrow_gated_clk"); @70
gated_clk_cell  x_lsu_ld_da_borrow_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (ld_da_borrow_clk   ),
  .external_en         (1'b0               ),
  .global_en           (1'b1               ),
  .local_en            (ld_da_borrow_clk_en),
  .module_en           (cp0_lsu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in        (forever_cpuclk     ), @71
//          .external_en   (1'b0               ), @72
//          .global_en     (1'b1               ), @73
//          .module_en     (cp0_lsu_icg_en     ), @74
//          .local_en      (ld_da_borrow_clk_en), @75
//          .clk_out       (ld_da_borrow_clk   )); @76

assign ld_da_expt_clk_en  = ld_dc_inst_vld
                            &&  ld_dc_da_expt_vld_gate_en
                            || ld_da_ecc_stall_gate;
// &Instance("gated_clk_cell", "x_lsu_ld_da_expt_gated_clk"); @81
gated_clk_cell  x_lsu_ld_da_expt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_expt_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ld_da_expt_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @82
//          .external_en   (1'b0               ), @83
//          .global_en     (cp0_yy_clk_en      ), @84
//          .module_en     (cp0_lsu_icg_en     ), @85
//          .local_en      (ld_da_expt_clk_en  ), @86
//          .clk_out       (ld_da_expt_clk     )); @87

//------------------pfu_addr reg----------------------------
assign ld_da_pfu_info_clk_en  = ld_dc_pfu_info_set_vld;
// &Instance("gated_clk_cell", "x_lsu_ld_da_pfu_info_gated_clk"); @91
gated_clk_cell  x_lsu_ld_da_pfu_info_gated_clk (
  .clk_in                (lsu_special_clk      ),
  .clk_out               (ld_da_pfu_info_clk   ),
  .external_en           (1'b0                 ),
  .global_en             (1'b1                 ),
  .local_en              (ld_da_pfu_info_clk_en),
  .module_en             (cp0_lsu_icg_en       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

// &Connect(.clk_in        (lsu_special_clk    ), @92
//          .external_en   (1'b0               ), @93
//          .global_en     (1'b1               ), @94
//          .module_en     (cp0_lsu_icg_en     ), @95
//          .local_en      (ld_da_pfu_info_clk_en ), @96
//          .clk_out       (ld_da_pfu_info_clk    )); @97

//------------------dcache reg------------------------------
assign ld_da_data0_clk_en = ld_dc_get_dcache_data[0] || ld_da_ecc_stall_gate;
// &Instance("gated_clk_cell", "x_lsu_ld_da_data0_gated_clk"); @101
gated_clk_cell  x_lsu_ld_da_data0_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_data0_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_data0_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @102
//          .external_en   (1'b0               ), @103
//          .global_en     (1'b1               ), @104
//          .module_en     (cp0_lsu_icg_en     ), @105
//          .local_en      (ld_da_data0_clk_en ), @106
//          .clk_out       (ld_da_data0_clk    )); @107

assign ld_da_data1_clk_en = ld_dc_get_dcache_data[1] || ld_da_ecc_stall_gate;
// &Instance("gated_clk_cell", "x_lsu_ld_da_data1_gated_clk"); @110
gated_clk_cell  x_lsu_ld_da_data1_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_data1_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_data1_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @111
//          .external_en   (1'b0               ), @112
//          .global_en     (1'b1               ), @113
//          .module_en     (cp0_lsu_icg_en     ), @114
//          .local_en      (ld_da_data1_clk_en ), @115
//          .clk_out       (ld_da_data1_clk    )); @116

assign ld_da_data2_clk_en = ld_dc_get_dcache_data[2] || ld_da_ecc_stall_gate;
// &Instance("gated_clk_cell", "x_lsu_ld_da_data2_gated_clk"); @119
gated_clk_cell  x_lsu_ld_da_data2_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_data2_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_data2_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @120
//          .external_en   (1'b0               ), @121
//          .global_en     (1'b1               ), @122
//          .module_en     (cp0_lsu_icg_en     ), @123
//          .local_en      (ld_da_data2_clk_en ), @124
//          .clk_out       (ld_da_data2_clk    )); @125

assign ld_da_data3_clk_en = ld_dc_get_dcache_data[3] || ld_da_ecc_stall_gate;
// &Instance("gated_clk_cell", "x_lsu_ld_da_data3_gated_clk"); @128
gated_clk_cell  x_lsu_ld_da_data3_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_data3_clk   ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_data3_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @129
//          .external_en   (1'b0               ), @130
//          .global_en     (1'b1               ), @131
//          .module_en     (cp0_lsu_icg_en     ), @132
//          .local_en      (ld_da_data3_clk_en ), @133
//          .clk_out       (ld_da_data3_clk    )); @134

assign ld_da_tag_clk_en = ld_dc_da_icc_tag_vld;
// &Instance("gated_clk_cell", "x_lsu_ld_da_tag_gated_clk"); @137
gated_clk_cell  x_lsu_ld_da_tag_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_tag_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_tag_clk_en  ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @138
//          .external_en   (1'b0               ), @139
//          .global_en     (1'b1               ), @140
//          .module_en     (cp0_lsu_icg_en     ), @141
//          .local_en      (ld_da_tag_clk_en ), @142
//          .clk_out       (ld_da_tag_clk    )); @143
//==========================================================
//                 Pipeline Register
//==========================================================
//------------------control part----------------------------
//+----------+------------+
//| inst_vld | borrow_vld |
//+----------+------------+
// &Force("output","ld_da_inst_vld"); @151
always @(posedge ctrl_ld_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_inst_vld          <=  1'b0;
    ld_da_ahead_preg_wb_vld <=  1'b0;
    ld_da_ahead_vreg_wb_vld <=  1'b0;
  end
  else if(rtu_yy_xx_flush)
  begin
    ld_da_inst_vld          <=  1'b0;
    ld_da_ahead_preg_wb_vld <=  1'b0;
    ld_da_ahead_vreg_wb_vld <=  1'b0;
  end
  else if(ld_dc_da_inst_vld && ~ld_da_ecc_stall)
  begin
    ld_da_inst_vld          <=  1'b1;
    ld_da_ahead_preg_wb_vld <=  ld_dc_ahead_preg_wb_vld;
    ld_da_ahead_vreg_wb_vld <=  ld_dc_ahead_vreg_wb_vld;
  end
  else
  begin
    ld_da_inst_vld          <=  1'b0;
    ld_da_ahead_preg_wb_vld <=  1'b0;
    ld_da_ahead_vreg_wb_vld <=  1'b0;
  end
end

// &Force("output","ld_da_borrow_vld"); @188
always @(posedge ctrl_ld_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_da_borrow_vld        <=  1'b0;
  else if(ld_dc_borrow_vld)
    ld_da_borrow_vld        <=  1'b1;
  else
    ld_da_borrow_vld        <=  1'b0;
end

assign ld_da_ecc_stall_already = 1'b0;
assign ld_da_ecc_stall_fatal   = 1'b0;
//assign ld_da_ecc_stall_data    = 1'b0;
//+----------+----------+----------+----------+
//| data 0/4 | data 1/5 | data 2/6 | data 3/7 | 
//+----------+----------+----------+----------+
//data bank0 and bank4 use a common gateclk because they are read
//simultaneously in all case
always @(posedge ld_da_data0_clk)
begin
  ld_da_dcache_data_bank0[31:0] <=  dcache_lsu_ld_data_bank0_dout[31:0];
  ld_da_dcache_data_bank4[31:0] <=  dcache_lsu_ld_data_bank4_dout[31:0];
end

always @(posedge ld_da_data1_clk)
begin
  ld_da_dcache_data_bank1[31:0] <=  dcache_lsu_ld_data_bank1_dout[31:0];
  ld_da_dcache_data_bank5[31:0] <=  dcache_lsu_ld_data_bank5_dout[31:0];
end

always @(posedge ld_da_data2_clk)
begin
  ld_da_dcache_data_bank2[31:0] <=  dcache_lsu_ld_data_bank2_dout[31:0];
  ld_da_dcache_data_bank6[31:0] <=  dcache_lsu_ld_data_bank6_dout[31:0];
end

always @(posedge ld_da_data3_clk)
begin
  ld_da_dcache_data_bank3[31:0] <=  dcache_lsu_ld_data_bank3_dout[31:0];
  ld_da_dcache_data_bank7[31:0] <=  dcache_lsu_ld_data_bank7_dout[31:0];
end
//------------------tag read for debug-------------------------------
always @(posedge ld_da_tag_clk)
begin
  if(ld_dc_da_icc_tag_vld)
  ld_da_tag_read[26:0] <=  ld_dc_da_tag_read[26:0];
end

//------------------expt part-------------------------------
//+----------+
//| expt_vec |
//+----------+
always @(posedge ld_da_expt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_expt_vec[14:0]              <=  15'b0;
    ld_da_mt_value[PC_WIDTH-1:0]      <=  {PC_WIDTH{1'b0}};
  end
  else if(ld_dc_inst_vld  &&  ld_dc_da_expt_vld_gate_en && !ld_da_ecc_stall)
  begin
    ld_da_expt_vec[14:0]          <=  ld_dc_expt_vec[14:0];
    ld_da_mt_value[PC_WIDTH-1:0]  <=  ld_dc_mt_value[PC_WIDTH-1:0];
  end
end

//------------------borrow part-----------------------------
//+-----+------+-----+------------+
//| vb | sndb | mmu | settle way |
//+-----+------+-----+------------+
always @(posedge ld_da_borrow_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_borrow_db[VB_DATA_ENTRY-1:0]  <=  {VB_DATA_ENTRY{1'b0}};
    ld_da_borrow_vb                     <=  1'b0;
    ld_da_borrow_sndb                   <=  1'b0;
    ld_da_borrow_mmu                    <=  1'b0;
    ld_da_borrow_icc                    <=  1'b0;
    ld_da_borrow_icc_tag                <=  1'b0;
    ld_da_settle_way                    <=  1'b0;
  end
  else if(ld_dc_borrow_vld && !ld_da_ecc_stall)
  begin
    ld_da_borrow_db[VB_DATA_ENTRY-1:0]  <=  ld_dc_borrow_db[VB_DATA_ENTRY-1:0];
    ld_da_borrow_vb                     <=  ld_dc_borrow_vb;
    ld_da_borrow_sndb                   <=  ld_dc_borrow_sndb;
    ld_da_borrow_mmu                    <=  ld_dc_borrow_mmu;
    ld_da_borrow_icc                    <=  ld_dc_borrow_icc;
    ld_da_borrow_icc_tag                <=  ld_dc_borrow_icc_tag;
    ld_da_settle_way                    <=  ld_dc_settle_way;
  end
end

//------------------inst part----------------------------
//+----------+
//| expt_vld |
//+----------+
//+-----------+-----------+------+-----------+
//| inst_type | inst_size | secd | inst_zone |
//+-----------+-----------+------+-----------+
//+-------------+----+-----+------+-----+------------+------------+
//| sign_extend | ex | iid | lsid | old | bytes_vld0 | bytes_vld1 |
//+-------------+----+-----+------+-----+------------+------------+
//+----------+------+---------------+-------+
//| boundary | preg | rar_spec_fail | split |
//+----------+------+---------------+-------+
//+------------+-----------+-------+-------+
//| already_da | ldfifo_pc | bkpta | bkptb |
//+------------+-----------+-------+-------+
//+----+----+-----+-----+-------+
//| so | ca | buf | sec | share |
//+----+----+-----+-----+-------+
//+------------+-------------+-----------+------------+
//| fwd_sq_vld | fwd_wmb_vld | sq_fwd_id | wmb_fwd_id |
//+------------+-------------+-----------+------------+
//+--------------+----------------+-----------------+
//| sq_fwd_multi | sq_discard_req | wmb_discard_req |
//+--------------+----------------+-----------------+
// &Force("output","ld_da_inst_size"); @466
// &Force("output","ld_da_sign_extend"); @467
// &Force("output","ld_da_iid"); @468
// &Force("output","ld_da_bytes_vld"); @469
// &Force("output","ld_da_lsid"); @470
// &Force("output","ld_da_bkpta_data"); @471
// &Force("output","ld_da_bkptb_data"); @472
// &Force("output","ld_da_inst_vfls"); @473
// &Force("output","ld_da_pfu_va"); @474
// &Force("output","ld_da_preg"); @475
// &Force("output","ld_da_vreg"); @476
// &Force("output","ld_da_ldfifo_pc"); @477
// &Force("output","ld_da_preg_sign_sel"); @478
// &Force("output","ld_da_vreg_sign_sel"); @479
// &Force("nonport","ld_da_ahead_predict"); @480
// &Force("nonport","ld_da_nf_cnt"); @481
always @(posedge ld_da_inst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_mmu_req                     <=  1'b0;
    ld_da_expt_vld_except_access_err  <=  1'b0;
    ld_da_expt_access_fault_mask      <=  1'b0;
    ld_da_expt_access_fault_extra     <=  1'b0;
    ld_da_expt_access_fault_mmu       <=  1'b0;
    ld_da_pfu_va[`PA_WIDTH-1:0]     <=  {`PA_WIDTH{1'b0}};
    ld_da_split                     <=  1'b0;
    ld_da_inst_type[1:0]            <=  2'b0;
    ld_da_inst_size[2:0]            <=  3'b0;
    ld_da_secd                      <=  1'b0;
    ld_da_sign_extend               <=  1'b0;
    ld_da_inst_code[31:0]           <=  32'b0;
    ld_da_atomic                    <=  1'b0;
    ld_da_iid[6:0]                  <=  7'b0;
    ld_da_lsid[LSIQ_ENTRY-1:0]      <=  {LSIQ_ENTRY{1'b0}};
    ld_da_boundary                  <=  1'b0;
    ld_da_preg[6:0]                 <=  7'b0;
    ld_da_already_da                <=  1'b0;
    ld_da_ldfifo_pc[PC_LEN-1:0]     <=  {PC_LEN{1'b0}};
    ld_da_ahead_predict             <=  1'b0;
    ld_da_wait_fence                <=  1'b0;
    ld_da_other_discard_sq          <=  1'b0;
    ld_da_data_discard_sq           <=  1'b0;
    ld_da_fwd_sq_bypass             <=  1'b0;
    ld_da_fwd_sq_vld                <=  1'b0;
    ld_da_data_vld_newest_fwd_sq_dup0    <=  1'b0;
    ld_da_data_vld_newest_fwd_sq_dup1    <=  1'b0;
    ld_da_data_vld_newest_fwd_sq_dup2    <=  1'b0;
    ld_da_data_vld_newest_fwd_sq_dup3    <=  1'b0;
    ld_da_fwd_sq_multi              <=  1'b0;
    ld_da_fwd_sq_multi_mask         <=  1'b0;
    ld_da_fwd_bypass_sq_multi       <=  1'b0;
    ld_da_sq_fwd_id[SQ_ENTRY-1:0]   <=  {SQ_ENTRY{1'b0}};
    ld_da_discard_wmb               <=  1'b0;
    ld_da_fwd_wmb_vld               <=  1'b0;
    //ld_da_wmb_fwd_id[WMB_ENTRY-1:0] <=  {WMB_ENTRY{1'b0}};
    ld_da_spec_fail                 <=  1'b0;
    ld_da_bkpta_data                <=  1'b0;
    ld_da_bkptb_data                <=  1'b0;
    ld_da_vreg[5:0]                 <=  6'b0;
    ld_da_inst_vfls                 <=  1'b0;
    ld_da_bytes_vld1[15:0]          <=  16'b0;
    ld_da_fwd_bytes_vld[15:0]       <=  16'b0;
    ld_da_fwd_bytes_vld_dup[15:0]   <=  16'b0;
    ld_da_preg_sign_sel[3:0]        <=  4'b0;
    ld_da_vreg_sign_sel             <=  1'b0;
    ld_da_cb_addr_create            <=  1'b0;
    ld_da_cb_merge_en               <=  1'b0;
    ld_da_pf_inst                   <=  1'b0;
    ld_da_no_spec                   <=  1'b0;
    ld_da_no_spec_exist             <=  1'b0;
    ld_da_vector_nop                <=  1'b0;
  end
  else if(ld_dc_inst_vld)
  begin
    ld_da_mmu_req                     <=  ld_dc_mmu_req;
    ld_da_expt_vld_except_access_err  <=  ld_dc_expt_vld_except_access_err;
    ld_da_expt_access_fault_mask      <=  ld_dc_expt_access_fault_mask;
    ld_da_expt_access_fault_extra     <=  ld_dc_expt_access_fault_extra;
    ld_da_expt_access_fault_mmu       <=  mmu_lsu_access_fault0;
    ld_da_pfu_va[`PA_WIDTH-1:0]     <=  ld_dc_pfu_va[`PA_WIDTH-1:0];
    ld_da_split                     <=  ld_dc_split;
    ld_da_inst_code[31:0]           <=  ld_dc_inst_code[31:0];
    ld_da_inst_type[1:0]            <=  ld_dc_inst_type[1:0];
    ld_da_inst_size[2:0]            <=  ld_dc_inst_size[2:0];
    ld_da_secd                      <=  ld_dc_secd;
    ld_da_sign_extend               <=  ld_dc_sign_extend;
    ld_da_atomic                    <=  ld_dc_atomic;
    ld_da_iid[6:0]                  <=  ld_dc_iid[6:0];
    ld_da_lsid[LSIQ_ENTRY-1:0]      <=  ld_dc_lsid[LSIQ_ENTRY-1:0];
    ld_da_boundary                  <=  ld_dc_boundary;
    ld_da_preg[6:0]                 <=  ld_dc_preg[6:0];
    ld_da_already_da                <=  ld_dc_already_da;
    ld_da_ldfifo_pc[PC_LEN-1:0]     <=  ld_dc_ldfifo_pc[PC_LEN-1:0];
    ld_da_ahead_predict             <=  ld_dc_ahead_predict;
    ld_da_wait_fence                <=  ld_dc_wait_fence;
    ld_da_other_discard_sq          <=  sq_ld_dc_other_discard_req;
    ld_da_data_discard_sq           <=  sq_ld_dc_data_discard_req;
    ld_da_fwd_sq_bypass             <=  sq_ld_dc_fwd_bypass_req;
    ld_da_fwd_sq_vld                <=  ld_dc_fwd_sq_vld;
    ld_da_data_vld_newest_fwd_sq_dup0    <=  sq_ld_dc_newest_fwd_data_vld_req;
    ld_da_data_vld_newest_fwd_sq_dup1    <=  sq_ld_dc_newest_fwd_data_vld_req;
    ld_da_data_vld_newest_fwd_sq_dup2    <=  sq_ld_dc_newest_fwd_data_vld_req;
    ld_da_data_vld_newest_fwd_sq_dup3    <=  sq_ld_dc_newest_fwd_data_vld_req;
    ld_da_fwd_sq_multi              <=  sq_ld_dc_fwd_multi;
    ld_da_fwd_sq_multi_mask         <=  sq_ld_dc_fwd_multi_mask;
    ld_da_fwd_bypass_sq_multi       <=  sq_ld_dc_fwd_bypass_multi;
    ld_da_sq_fwd_id[SQ_ENTRY-1:0]   <=  sq_ld_dc_fwd_id[SQ_ENTRY-1:0];
    ld_da_discard_wmb               <=  wmb_ld_dc_discard_req;
    ld_da_fwd_wmb_vld               <=  ld_dc_fwd_wmb_vld;
    //ld_da_wmb_fwd_id[WMB_ENTRY-1:0] <=  wmb_ld_dc_fwd_id[WMB_ENTRY-1:0];
    ld_da_spec_fail                 <=  ld_dc_spec_fail;
    ld_da_bkpta_data                <=  ld_dc_bkpta_data;
    ld_da_bkptb_data                <=  ld_dc_bkptb_data;
    ld_da_vreg[5:0]                 <=  ld_dc_vreg[5:0];
    ld_da_inst_vfls                 <=  ld_dc_inst_vfls;
    ld_da_bytes_vld1[15:0]          <=  ld_dc_da_bytes_vld1[15:0];
    ld_da_fwd_bytes_vld[15:0]       <=  ld_dc_fwd_bytes_vld[15:0];
    ld_da_fwd_bytes_vld_dup[15:0]   <=  ld_dc_fwd_bytes_vld[15:0];
    ld_da_preg_sign_sel[3:0]        <=  ld_dc_preg_sign_sel[3:0];
    ld_da_vreg_sign_sel             <=  ld_dc_vreg_sign_sel;
    ld_da_cb_addr_create            <=  ld_dc_da_cb_addr_create;
    ld_da_cb_merge_en               <=  ld_dc_da_cb_merge_en;
    ld_da_pf_inst                   <=  ld_dc_da_pf_inst;
    ld_da_no_spec                   <=  ld_dc_no_spec;
    ld_da_no_spec_exist             <=  ld_dc_no_spec_exist;
    ld_da_vector_nop                <=  ld_dc_vector_nop;
  end
end

//------------------inst/borrow share part------------------
//+------+-----------------+------------------+
//| addr | dcache_data_sel | page_information |
//+------+-----------------+------------------+
// &Force("output","ld_da_page_ca"); @628
// &Force("output","ld_da_page_so"); @629
// &Force("output","ld_da_page_sec"); @630
// &Force("output","ld_da_page_share"); @631
// &Force("output","ld_da_data_rot_sel"); @632
always @(posedge ld_da_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_addr0[`PA_WIDTH-1:0]    <=  {`PA_WIDTH{1'b0}};
    ld_da_addr0_idx[8:0]          <=  9'b0;
    ld_da_old                     <=  1'b0;
    ld_da_page_so                 <=  1'b0;
    ld_da_page_ca                 <=  1'b0;
    ld_da_page_buf                <=  1'b0;
    ld_da_page_sec                <=  1'b0;
    ld_da_page_share              <=  1'b0;
    ld_da_data_rot_sel[7:0]       <=  8'b0;
    ld_da_bytes_vld[15:0]         <=  16'b0;
  end
  else if((ld_dc_inst_vld  ||  ld_dc_borrow_vld && !ld_dc_borrow_vb && !ld_dc_borrow_sndb) && !ld_da_ecc_stall)
  begin
    ld_da_addr0[`PA_WIDTH-1:0]    <=  ld_dc_addr0[`PA_WIDTH-1:0];
    ld_da_addr0_idx[8:0]          <=  ld_dc_addr0[14:6];
    ld_da_old                     <=  ld_dc_da_old;
    ld_da_page_so                 <=  ld_dc_da_page_so;
    ld_da_page_ca                 <=  ld_dc_da_page_ca;
    ld_da_page_buf                <=  ld_dc_da_page_buf;
    ld_da_page_sec                <=  ld_dc_da_page_sec;
    ld_da_page_share              <=  ld_dc_da_page_share;
    ld_da_data_rot_sel[7:0]       <=  ld_dc_da_data_rot_sel[7:0];
    ld_da_bytes_vld[15:0]         <=  ld_dc_da_bytes_vld[15:0];
  end
end

always @(posedge ld_da_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_dcache_hit              <=  1'b0;
    ld_da_hit_low_region          <=  1'b0;
    ld_da_hit_low_region_dup0     <=  1'b0;
    ld_da_hit_low_region_dup1     <=  1'b0;
    ld_da_hit_low_region_dup2     <=  1'b0;
    ld_da_hit_low_region_dup3     <=  1'b0;
    ld_da_hit_high_region         <=  1'b0;
    ld_da_hit_high_region_dup0    <=  1'b0;
    ld_da_hit_high_region_dup1    <=  1'b0;
    ld_da_hit_high_region_dup2    <=  1'b0;
    ld_da_hit_high_region_dup3    <=  1'b0;
  end
  else if((ld_dc_inst_vld  ||  ld_dc_borrow_vld && ld_dc_borrow_mmu) && !ld_da_ecc_stall)
  begin
    ld_da_dcache_hit              <=  ld_dc_dcache_hit;
    ld_da_hit_low_region          <=  ld_dc_hit_low_region;
    ld_da_hit_low_region_dup0     <=  ld_dc_hit_low_region;
    ld_da_hit_low_region_dup1     <=  ld_dc_hit_low_region;
    ld_da_hit_low_region_dup2     <=  ld_dc_hit_low_region;
    ld_da_hit_low_region_dup3     <=  ld_dc_hit_low_region;
    ld_da_hit_high_region         <=  ld_dc_hit_high_region;
    ld_da_hit_high_region_dup0    <=  ld_dc_hit_high_region;
    ld_da_hit_high_region_dup1    <=  ld_dc_hit_high_region;
    ld_da_hit_high_region_dup2    <=  ld_dc_hit_high_region;
    ld_da_hit_high_region_dup3    <=  ld_dc_hit_high_region;
  end
end

//+----------+
//| pfu_addr |
//+----------+
//low power pfu_addr, reverse only when pfb/sdb not empty
always @(posedge ld_da_pfu_info_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_da_ppfu_va[`PA_WIDTH-1:0]      <=  {`PA_WIDTH{1'b0}};
  else if(ld_dc_pfu_info_set_vld && !ld_da_ecc_stall)
    ld_da_ppfu_va[`PA_WIDTH-1:0]      <=  ld_dc_pfu_va[`PA_WIDTH-1:0];
end

//==========================================================
//        Generate expt info
//==========================================================
assign ld_da_expt_access_fault  = (ld_da_mmu_req
                                          &&  ld_da_expt_access_fault_mmu
                                      ||  ld_da_expt_access_fault_extra)
                                  &&  !ld_da_expt_access_fault_mask;

// //&Force("output","ld_da_expt_vld"); @789
//ecc err will not trigger expt, cause interrupt instead
// &Force("output","ld_da_wb_expt_vld"); @791
assign ld_da_expt_ori = ld_da_expt_vld_except_access_err
                         ||  ld_da_expt_access_fault
                         ||  ld_da_ecc_stall_fatal;

assign ld_da_expt_vld = (ld_da_expt_vld_except_access_err
                         ||  ld_da_expt_access_fault
                         ||  ld_da_ecc_stall_fatal)
                        && !ld_da_fof_not_first
                        && !ld_da_vector_nop;

assign ld_da_wb_expt_vld = (ld_da_expt_vld_except_access_err
                               ||  ld_da_expt_access_fault)
                           && !ld_da_fof_not_first
                           && !ld_da_vector_nop;

// &CombBeg; @807
always @( ld_da_mt_value[63:0]
       or ld_da_expt_access_fault
       or ld_da_expt_vec[14:0]
       or ld_da_atomic)
begin
ld_da_wb_expt_vec[14:0]  = ld_da_expt_vec[14:0];

ld_da_wb_mt_value_ori[PC_WIDTH-1:0]  = ld_da_mt_value[PC_WIDTH-1:0];
if(ld_da_expt_access_fault &&  !ld_da_atomic)
begin
  ld_da_wb_expt_vec[14:0]  = 15'd5;
  ld_da_wb_mt_value_ori[PC_WIDTH-1:0]  = {PC_WIDTH{1'b0}};
end
else if(ld_da_expt_access_fault &&  ld_da_atomic)
begin
  ld_da_wb_expt_vec[14:0]  = 15'd7;
  ld_da_wb_mt_value_ori[PC_WIDTH-1:0]  = {PC_WIDTH{1'b0}};
end
// &CombEnd; @821
end

// &Force("output","ld_da_element_cnt"); @824
// &Force("output","ld_da_vlmul"); @825
// &Force("output","ld_da_inst_fof"); @826
// &Force("output","ld_da_split"); @827
// &Force("output","ld_da_setvl_val"); @828
// &Force("output","ld_da_rb_expt_vld"); @829
assign ld_da_wb_mt_value[PC_WIDTH-1:0] = ld_da_wb_mt_value_ori[PC_WIDTH-1:0];
assign ld_da_fof_not_first = 1'b0;
assign ld_da_inst_fof = 1'b0;
//==========================================================
//        Generate inst type
//==========================================================
//ld/ldr/lrw/pop/lrs is treated as ld inst
assign ld_da_ld_inst    = !ld_da_atomic
                          &&  (ld_da_inst_type[1:0]  == 2'b00);
assign ld_da_ldamo_inst = ld_da_atomic
                          &&  (ld_da_inst_type[1:0]  == 2'b00);
assign ld_da_lr_inst    = ld_da_atomic
                          &&  (ld_da_inst_type[1:0]  == 2'b01);

//==========================================================
//        Data forward from sq/wmb
//==========================================================
//data forward from sq/wmb is done in sq/wmb file
assign sq_ld_da_fwd_data_128[127:0] = {sq_ld_da_fwd_data[63:0],sq_ld_da_fwd_data[63:0]};
assign sq_ld_da_fwd_data_pe_128[127:0] = {sq_ld_da_fwd_data_pe[63:0],sq_ld_da_fwd_data_pe[63:0]};
assign wmb_ld_da_fwd_data_128[127:0] = wmb_ld_da_fwd_data[127:0];

assign ld_da_fwd_wmb_data_am[127:0] = {{{8{ld_da_bytes_vld[15]}}  & wmb_ld_da_fwd_data_128[127:120]}
                                      ,{{8{ld_da_bytes_vld[14]}}  & wmb_ld_da_fwd_data_128[119:112]}
                                      ,{{8{ld_da_bytes_vld[13]}}  & wmb_ld_da_fwd_data_128[111:104]}
                                      ,{{8{ld_da_bytes_vld[12]}}  & wmb_ld_da_fwd_data_128[103:96]}
                                      ,{{8{ld_da_bytes_vld[11]}}  & wmb_ld_da_fwd_data_128[95:88]}
                                      ,{{8{ld_da_bytes_vld[10]}}  & wmb_ld_da_fwd_data_128[87:80]}
                                      ,{{8{ld_da_bytes_vld[9]}}   & wmb_ld_da_fwd_data_128[79:72]}
                                      ,{{8{ld_da_bytes_vld[8]}}   & wmb_ld_da_fwd_data_128[71:64]}
                                      ,{{8{ld_da_bytes_vld[7]}}   & wmb_ld_da_fwd_data_128[63:56]}
                                      ,{{8{ld_da_bytes_vld[6]}}   & wmb_ld_da_fwd_data_128[55:48]}
                                      ,{{8{ld_da_bytes_vld[5]}}   & wmb_ld_da_fwd_data_128[47:40]}
                                      ,{{8{ld_da_bytes_vld[4]}}   & wmb_ld_da_fwd_data_128[39:32]}
                                      ,{{8{ld_da_bytes_vld[3]}}   & wmb_ld_da_fwd_data_128[31:24]}
                                      ,{{8{ld_da_bytes_vld[2]}}   & wmb_ld_da_fwd_data_128[23:16]}
                                      ,{{8{ld_da_bytes_vld[1]}}   & wmb_ld_da_fwd_data_128[15:8]}
                                      ,{{8{ld_da_bytes_vld[0]}}   & wmb_ld_da_fwd_data_128[7:0]}};

assign ld_da_fwd_sq_data_pe_am[127:0] = {{{8{ld_da_bytes_vld[15]}}  & sq_ld_da_fwd_data_pe_128[127:120]}
                                        ,{{8{ld_da_bytes_vld[14]}}  & sq_ld_da_fwd_data_pe_128[119:112]}
                                        ,{{8{ld_da_bytes_vld[13]}}  & sq_ld_da_fwd_data_pe_128[111:104]}
                                        ,{{8{ld_da_bytes_vld[12]}}  & sq_ld_da_fwd_data_pe_128[103:96]}
                                        ,{{8{ld_da_bytes_vld[11]}}  & sq_ld_da_fwd_data_pe_128[95:88]}
                                        ,{{8{ld_da_bytes_vld[10]}}  & sq_ld_da_fwd_data_pe_128[87:80]}
                                        ,{{8{ld_da_bytes_vld[9]}}   & sq_ld_da_fwd_data_pe_128[79:72]}
                                        ,{{8{ld_da_bytes_vld[8]}}   & sq_ld_da_fwd_data_pe_128[71:64]}
                                        ,{{8{ld_da_bytes_vld[7]}}   & sq_ld_da_fwd_data_pe_128[63:56]}
                                        ,{{8{ld_da_bytes_vld[6]}}   & sq_ld_da_fwd_data_pe_128[55:48]}
                                        ,{{8{ld_da_bytes_vld[5]}}   & sq_ld_da_fwd_data_pe_128[47:40]}
                                        ,{{8{ld_da_bytes_vld[4]}}   & sq_ld_da_fwd_data_pe_128[39:32]}
                                        ,{{8{ld_da_bytes_vld[3]}}   & sq_ld_da_fwd_data_pe_128[31:24]}
                                        ,{{8{ld_da_bytes_vld[2]}}   & sq_ld_da_fwd_data_pe_128[23:16]}
                                        ,{{8{ld_da_bytes_vld[1]}}   & sq_ld_da_fwd_data_pe_128[15:8]}
                                        ,{{8{ld_da_bytes_vld[0]}}   & sq_ld_da_fwd_data_pe_128[7:0]}};

assign ld_da_fwd_sq_data_am[127:0]    = {{{8{ld_da_bytes_vld[15]}}  & sq_ld_da_fwd_data_128[127:120]}
                                        ,{{8{ld_da_bytes_vld[14]}}  & sq_ld_da_fwd_data_128[119:112]}
                                        ,{{8{ld_da_bytes_vld[13]}}  & sq_ld_da_fwd_data_128[111:104]}
                                        ,{{8{ld_da_bytes_vld[12]}}  & sq_ld_da_fwd_data_128[103:96]}
                                        ,{{8{ld_da_bytes_vld[11]}}  & sq_ld_da_fwd_data_128[95:88]}
                                        ,{{8{ld_da_bytes_vld[10]}}  & sq_ld_da_fwd_data_128[87:80]}
                                        ,{{8{ld_da_bytes_vld[9]}}   & sq_ld_da_fwd_data_128[79:72]}
                                        ,{{8{ld_da_bytes_vld[8]}}   & sq_ld_da_fwd_data_128[71:64]}
                                        ,{{8{ld_da_bytes_vld[7]}}   & sq_ld_da_fwd_data_128[63:56]}
                                        ,{{8{ld_da_bytes_vld[6]}}   & sq_ld_da_fwd_data_128[55:48]}
                                        ,{{8{ld_da_bytes_vld[5]}}   & sq_ld_da_fwd_data_128[47:40]}
                                        ,{{8{ld_da_bytes_vld[4]}}   & sq_ld_da_fwd_data_128[39:32]}
                                        ,{{8{ld_da_bytes_vld[3]}}   & sq_ld_da_fwd_data_128[31:24]}
                                        ,{{8{ld_da_bytes_vld[2]}}   & sq_ld_da_fwd_data_128[23:16]}
                                        ,{{8{ld_da_bytes_vld[1]}}   & sq_ld_da_fwd_data_128[15:8]}
                                        ,{{8{ld_da_bytes_vld[0]}}   & sq_ld_da_fwd_data_128[7:0]}};

assign ld_da_fwd_data_am[127:0]     = ld_da_fwd_sq_vld
                                      ? ld_da_fwd_sq_data_am[127:0]
                                      : ld_da_fwd_wmb_data_am[127:0];


assign ld_da_fwd_data_pe_am[31:0]   = ld_da_data_vld_newest_fwd_sq_dup0
                                      ? ld_da_fwd_sq_data_pe_am[31:0]
                                      : ld_da_fwd_wmb_data_am[31:0];
assign ld_da_fwd_data_pe_am[63:32]  = ld_da_data_vld_newest_fwd_sq_dup1
                                      ? ld_da_fwd_sq_data_pe_am[63:32]
                                      : ld_da_fwd_wmb_data_am[63:32];
assign ld_da_fwd_data_pe_am[95:64]  = ld_da_data_vld_newest_fwd_sq_dup2
                                      ? ld_da_fwd_sq_data_pe_am[95:64]
                                      : ld_da_fwd_wmb_data_am[95:64];
assign ld_da_fwd_data_pe_am[127:96] = ld_da_data_vld_newest_fwd_sq_dup3
                                      ? ld_da_fwd_sq_data_pe_am[127:96]
                                      : ld_da_fwd_wmb_data_am[127:96];

// &CombBeg; @954
always @( sd_ex1_data_bypass[127:0]
       or ld_da_inst_size[2:0])
begin
case(ld_da_inst_size[2:0])
  3'b000: ld_da_fwd_data_bypass[127:0] = {120'b0,sd_ex1_data_bypass[7:0]};  //byte
  3'b001: ld_da_fwd_data_bypass[127:0] = {112'b0,sd_ex1_data_bypass[15:0]}; //half
  3'b010: ld_da_fwd_data_bypass[127:0] = {96'b0,sd_ex1_data_bypass[31:0]};  //word
  3'b011: ld_da_fwd_data_bypass[127:0] = {64'b0,sd_ex1_data_bypass[63:0]};  //dword
  default:ld_da_fwd_data_bypass[127:0] = sd_ex1_data_bypass[127:0];         //qword
endcase
// &CombEnd; @962
end

///TODO: when dcache disable, we can get data from vmb.
/// FIXME, Why vmb_vld meanwhilw dcache hit?
assign ld_da_fwd_vld          = ld_da_fwd_sq_vld
                                ||  ld_da_fwd_sq_bypass_vld  
                                ||  ld_da_fwd_wmb_vld
                                    && (ld_da_dcache_hit
                                        || ~cp0_lsu_dcache_en);

assign ld_da_merge_from_cb    = ld_da_cb_merge_en
                                && cb_ld_da_data_vld
                                && !ld_da_ecc_stall_already;

//==========================================================
//                Settle data from cache
//==========================================================
//------------------cache data settle to vb/snq------------
assign ld_da_data256_way0[255:0]  = {ld_da_dcache_data_bank7[31:0],
                                    ld_da_dcache_data_bank6[31:0],
                                    ld_da_dcache_data_bank5[31:0],
                                    ld_da_dcache_data_bank4[31:0],
                                    ld_da_dcache_data_bank3[31:0],
                                    ld_da_dcache_data_bank2[31:0],
                                    ld_da_dcache_data_bank1[31:0],
                                    ld_da_dcache_data_bank0[31:0]};

assign ld_da_data256_way1[255:0]  = {ld_da_dcache_data_bank3[31:0],
                                    ld_da_dcache_data_bank2[31:0],
                                    ld_da_dcache_data_bank1[31:0],
                                    ld_da_dcache_data_bank0[31:0],
                                    ld_da_dcache_data_bank7[31:0],
                                    ld_da_dcache_data_bank6[31:0],
                                    ld_da_dcache_data_bank5[31:0],
                                    ld_da_dcache_data_bank4[31:0]};


assign ld_da_data256[255:0]       = ld_da_settle_way
                                    ? ld_da_data256_way1[255:0]
                                    : ld_da_data256_way0[255:0];
//------------------cache data settle-----------------------

assign ld_da_high_region_data128_am[127:0]= {{{8{ld_da_bytes_vld[15]}}  & ld_da_dcache_data_bank7[31:24]}
                                            ,{{8{ld_da_bytes_vld[14]}}  & ld_da_dcache_data_bank7[23:16]}
                                            ,{{8{ld_da_bytes_vld[13]}}  & ld_da_dcache_data_bank7[15:8]}
                                            ,{{8{ld_da_bytes_vld[12]}}  & ld_da_dcache_data_bank7[7:0]}
                                            ,{{8{ld_da_bytes_vld[11]}}  & ld_da_dcache_data_bank6[31:24]}
                                            ,{{8{ld_da_bytes_vld[10]}}  & ld_da_dcache_data_bank6[23:16]}
                                            ,{{8{ld_da_bytes_vld[9]}}   & ld_da_dcache_data_bank6[15:8]}
                                            ,{{8{ld_da_bytes_vld[8]}}   & ld_da_dcache_data_bank6[7:0]}
                                            ,{{8{ld_da_bytes_vld[7]}}   & ld_da_dcache_data_bank5[31:24]}
                                            ,{{8{ld_da_bytes_vld[6]}}   & ld_da_dcache_data_bank5[23:16]}
                                            ,{{8{ld_da_bytes_vld[5]}}   & ld_da_dcache_data_bank5[15:8]}
                                            ,{{8{ld_da_bytes_vld[4]}}   & ld_da_dcache_data_bank5[7:0]}
                                            ,{{8{ld_da_bytes_vld[3]}}   & ld_da_dcache_data_bank4[31:24]}
                                            ,{{8{ld_da_bytes_vld[2]}}   & ld_da_dcache_data_bank4[23:16]}
                                            ,{{8{ld_da_bytes_vld[1]}}   & ld_da_dcache_data_bank4[15:8]}
                                            ,{{8{ld_da_bytes_vld[0]}}   & ld_da_dcache_data_bank4[7:0]}};

assign ld_da_low_region_data128_am[127:0] = {{{8{ld_da_bytes_vld[15]}}  & ld_da_dcache_data_bank3[31:24]}
                                            ,{{8{ld_da_bytes_vld[14]}}  & ld_da_dcache_data_bank3[23:16]}
                                            ,{{8{ld_da_bytes_vld[13]}}  & ld_da_dcache_data_bank3[15:8]}
                                            ,{{8{ld_da_bytes_vld[12]}}  & ld_da_dcache_data_bank3[7:0]}
                                            ,{{8{ld_da_bytes_vld[11]}}  & ld_da_dcache_data_bank2[31:24]}
                                            ,{{8{ld_da_bytes_vld[10]}}  & ld_da_dcache_data_bank2[23:16]}
                                            ,{{8{ld_da_bytes_vld[9]}}   & ld_da_dcache_data_bank2[15:8]}
                                            ,{{8{ld_da_bytes_vld[8]}}   & ld_da_dcache_data_bank2[7:0]}
                                            ,{{8{ld_da_bytes_vld[7]}}   & ld_da_dcache_data_bank1[31:24]}
                                            ,{{8{ld_da_bytes_vld[6]}}   & ld_da_dcache_data_bank1[23:16]}
                                            ,{{8{ld_da_bytes_vld[5]}}   & ld_da_dcache_data_bank1[15:8]}
                                            ,{{8{ld_da_bytes_vld[4]}}   & ld_da_dcache_data_bank1[7:0]}
                                            ,{{8{ld_da_bytes_vld[3]}}   & ld_da_dcache_data_bank0[31:24]}
                                            ,{{8{ld_da_bytes_vld[2]}}   & ld_da_dcache_data_bank0[23:16]}
                                            ,{{8{ld_da_bytes_vld[1]}}   & ld_da_dcache_data_bank0[15:8]}
                                            ,{{8{ld_da_bytes_vld[0]}}   & ld_da_dcache_data_bank0[7:0]}};

//==========================================================
//        Compare tag and select data from cache/sq|wmb
//==========================================================
//------------------compare tag-----------------------------
//assign ld_da_tag[17:0]      = ld_da_addr0[31:14];
// &Force("output","ld_da_idx"); @1090
assign ld_da_idx[7:0]       = ld_da_addr0_idx[7:0];

// &Force("output","ld_da_dcache_hit"); @1093
assign ld_da_dcache_miss    = !ld_da_dcache_hit;

//------------------select data-----------------------------
//hit region refer to LSU spec
assign ld_da_dcache_pass_data128_am[127:0]  = {128{ld_da_hit_low_region}}  & ld_da_low_region_data128_am[127:0]
                                              | {128{ld_da_hit_high_region}}  & ld_da_high_region_data128_am[127:0];

assign ld_da_dcache_pass_data128_ahead_am[31:0]   = {32{ld_da_hit_low_region_dup0}}  & ld_da_low_region_data128_am[31:0]
                                                    | {32{ld_da_hit_high_region_dup0}}  & ld_da_high_region_data128_am[31:0];
assign ld_da_dcache_pass_data128_ahead_am[63:32]  = {32{ld_da_hit_low_region_dup1}}  & ld_da_low_region_data128_am[63:32]
                                                    | {32{ld_da_hit_high_region_dup1}}  & ld_da_high_region_data128_am[63:32];
assign ld_da_dcache_pass_data128_ahead_am[95:64]  = {32{ld_da_hit_low_region_dup2}}  & ld_da_low_region_data128_am[95:64]
                                                    | {32{ld_da_hit_high_region_dup2}}  & ld_da_high_region_data128_am[95:64];
assign ld_da_dcache_pass_data128_ahead_am[127:96] = {32{ld_da_hit_low_region_dup3}}  & ld_da_low_region_data128_am[127:96]
                                                    | {32{ld_da_hit_high_region_dup3}}  & ld_da_high_region_data128_am[127:96];

assign ld_da_dcache_data128_ahead_am[127:0] = ld_da_dcache_pass_data128_ahead_am[127:0];
 
// cache buffer bypass
assign ld_da_cb_bypass_data_am[127:0] = {{{8{ld_da_bytes_vld1[15]}}  & cb_ld_da_data[127:120]}
                                        ,{{8{ld_da_bytes_vld1[14]}}  & cb_ld_da_data[119:112]}
                                        ,{{8{ld_da_bytes_vld1[13]}}  & cb_ld_da_data[111:104]}
                                        ,{{8{ld_da_bytes_vld1[12]}}  & cb_ld_da_data[103:96]}
                                        ,{{8{ld_da_bytes_vld1[11]}}  & cb_ld_da_data[95:88]}
                                        ,{{8{ld_da_bytes_vld1[10]}}  & cb_ld_da_data[87:80]}
                                        ,{{8{ld_da_bytes_vld1[9]}}   & cb_ld_da_data[79:72]}
                                        ,{{8{ld_da_bytes_vld1[8]}}   & cb_ld_da_data[71:64]}
                                        ,{{8{ld_da_bytes_vld1[7]}}   & cb_ld_da_data[63:56]}
                                        ,{{8{ld_da_bytes_vld1[6]}}   & cb_ld_da_data[55:48]}
                                        ,{{8{ld_da_bytes_vld1[5]}}   & cb_ld_da_data[47:40]}
                                        ,{{8{ld_da_bytes_vld1[4]}}   & cb_ld_da_data[39:32]}
                                        ,{{8{ld_da_bytes_vld1[3]}}   & cb_ld_da_data[31:24]}
                                        ,{{8{ld_da_bytes_vld1[2]}}   & cb_ld_da_data[23:16]}
                                        ,{{8{ld_da_bytes_vld1[1]}}   & cb_ld_da_data[15:8]}
                                        ,{{8{ld_da_bytes_vld1[0]}}   & cb_ld_da_data[7:0]}};

assign ld_da_cb_bypass_data_for_merge[127:0]  = ld_da_merge_from_cb
                                                ? ld_da_cb_bypass_data_am[127:0]
                                                : 128'b0;

assign ld_da_dcache_data_after_merge[127:0]   = ld_da_cb_bypass_data_for_merge[127:0]
                                                | ld_da_dcache_pass_data128_am[127:0];


assign ld_da_data_unrot[127:120]  = ld_da_fwd_bytes_vld[15]
                                    ? ld_da_fwd_data_am[127:120]
                                    : ld_da_dcache_data_after_merge[127:120];
assign ld_da_data_unrot[119:112]  = ld_da_fwd_bytes_vld[14]
                                    ? ld_da_fwd_data_am[119:112]
                                    : ld_da_dcache_data_after_merge[119:112];
assign ld_da_data_unrot[111:104]  = ld_da_fwd_bytes_vld[13]
                                    ? ld_da_fwd_data_am[111:104]
                                    : ld_da_dcache_data_after_merge[111:104];
assign ld_da_data_unrot[103:96]  = ld_da_fwd_bytes_vld[12]
                                    ? ld_da_fwd_data_am[103:96]
                                    : ld_da_dcache_data_after_merge[103:96];
assign ld_da_data_unrot[95:88]  = ld_da_fwd_bytes_vld[11]
                                    ? ld_da_fwd_data_am[95:88]
                                    : ld_da_dcache_data_after_merge[95:88];
assign ld_da_data_unrot[87:80]  = ld_da_fwd_bytes_vld[10]
                                    ? ld_da_fwd_data_am[87:80]
                                    : ld_da_dcache_data_after_merge[87:80];
assign ld_da_data_unrot[79:72]  = ld_da_fwd_bytes_vld[9]
                                    ? ld_da_fwd_data_am[79:72]
                                    : ld_da_dcache_data_after_merge[79:72];
assign ld_da_data_unrot[71:64]  = ld_da_fwd_bytes_vld[8]
                                    ? ld_da_fwd_data_am[71:64]
                                    : ld_da_dcache_data_after_merge[71:64];
assign ld_da_data_unrot[63:56]  = ld_da_fwd_bytes_vld[7]
                                    ? ld_da_fwd_data_am[63:56]
                                    : ld_da_dcache_data_after_merge[63:56];
assign ld_da_data_unrot[55:48]  = ld_da_fwd_bytes_vld[6]
                                    ? ld_da_fwd_data_am[55:48]
                                    : ld_da_dcache_data_after_merge[55:48];
assign ld_da_data_unrot[47:40]  = ld_da_fwd_bytes_vld[5]
                                    ? ld_da_fwd_data_am[47:40]
                                    : ld_da_dcache_data_after_merge[47:40];
assign ld_da_data_unrot[39:32]  = ld_da_fwd_bytes_vld[4]
                                    ? ld_da_fwd_data_am[39:32]
                                    : ld_da_dcache_data_after_merge[39:32];
assign ld_da_data_unrot[31:24]  = ld_da_fwd_bytes_vld[3]
                                    ? ld_da_fwd_data_am[31:24]
                                    : ld_da_dcache_data_after_merge[31:24];
assign ld_da_data_unrot[23:16]  = ld_da_fwd_bytes_vld[2]
                                    ? ld_da_fwd_data_am[23:16]
                                    : ld_da_dcache_data_after_merge[23:16];
assign ld_da_data_unrot[15:8]  = ld_da_fwd_bytes_vld[1]
                                    ? ld_da_fwd_data_am[15:8]
                                    : ld_da_dcache_data_after_merge[15:8];
assign ld_da_data_unrot[7:0]  = ld_da_fwd_bytes_vld[0]
                                    ? ld_da_fwd_data_am[7:0]
                                    : ld_da_dcache_data_after_merge[7:0];

//rotate data
// &Instance("ct_lsu_rot_data", "x_lsu_ld_da_data_rot"); @1200
ct_lsu_rot_data  x_lsu_ld_da_data_rot (
  .data_in            (ld_da_data_unrot  ),
  .data_settle_out    (ld_da_data_settle ),
  .rot_sel            (ld_da_data_rot_sel)
);

// &Connect(.rot_sel         (ld_da_data_rot_sel     ), @1201
//          .data_in         (ld_da_data_unrot   ), @1202
//          .data_settle_out (ld_da_data_settle )); @1203

assign ld_da_data128[127:0]   = ld_da_fwd_sq_bypass
                                ? ld_da_fwd_data_bypass[127:0]
                                : ld_da_data_settle[127:0];
assign ld_da_wb_data[63:0]  = ld_da_data128[63:0];

//------------------select data from cache or sq/wmb--------
assign ld_da_data_vld               = ld_da_inst_vld
                                      &&  !ld_da_expt_vld
                                      &&  (ld_da_fwd_vld ||  ld_da_dcache_hit);
assign ld_da_rb_data_vld = ld_da_data_vld;
// &Force("output","ld_da_rb_data_vld"); @1223

//------------------select data for ahead-------------------
assign ld_da_ahead_preg_data_unsettle[127:120] = ld_da_fwd_bytes_vld_dup[15]
                                            ? ld_da_fwd_data_pe_am[127:120]
                                            : ld_da_dcache_data128_ahead_am[127:120];
assign ld_da_ahead_preg_data_unsettle[119:112] = ld_da_fwd_bytes_vld_dup[14]
                                            ? ld_da_fwd_data_pe_am[119:112]
                                            : ld_da_dcache_data128_ahead_am[119:112];
assign ld_da_ahead_preg_data_unsettle[111:104] = ld_da_fwd_bytes_vld_dup[13]
                                            ? ld_da_fwd_data_pe_am[111:104]
                                            : ld_da_dcache_data128_ahead_am[111:104];
assign ld_da_ahead_preg_data_unsettle[103:96] = ld_da_fwd_bytes_vld_dup[12]
                                            ? ld_da_fwd_data_pe_am[103:96]
                                            : ld_da_dcache_data128_ahead_am[103:96];
assign ld_da_ahead_preg_data_unsettle[95:88] = ld_da_fwd_bytes_vld_dup[11]
                                            ? ld_da_fwd_data_pe_am[95:88]
                                            : ld_da_dcache_data128_ahead_am[95:88];
assign ld_da_ahead_preg_data_unsettle[87:80] = ld_da_fwd_bytes_vld_dup[10]
                                            ? ld_da_fwd_data_pe_am[87:80]
                                            : ld_da_dcache_data128_ahead_am[87:80];
assign ld_da_ahead_preg_data_unsettle[79:72] = ld_da_fwd_bytes_vld_dup[9]
                                            ? ld_da_fwd_data_pe_am[79:72]
                                            : ld_da_dcache_data128_ahead_am[79:72];
assign ld_da_ahead_preg_data_unsettle[71:64] = ld_da_fwd_bytes_vld_dup[8]
                                            ? ld_da_fwd_data_pe_am[71:64]
                                            : ld_da_dcache_data128_ahead_am[71:64];
assign ld_da_ahead_preg_data_unsettle[63:56] = ld_da_fwd_bytes_vld_dup[7]
                                            ? ld_da_fwd_data_pe_am[63:56]
                                            : ld_da_dcache_data128_ahead_am[63:56];
assign ld_da_ahead_preg_data_unsettle[55:48] = ld_da_fwd_bytes_vld_dup[6]
                                            ? ld_da_fwd_data_pe_am[55:48]
                                            : ld_da_dcache_data128_ahead_am[55:48];
assign ld_da_ahead_preg_data_unsettle[47:40] = ld_da_fwd_bytes_vld_dup[5]
                                            ? ld_da_fwd_data_pe_am[47:40]
                                            : ld_da_dcache_data128_ahead_am[47:40];
assign ld_da_ahead_preg_data_unsettle[39:32] = ld_da_fwd_bytes_vld_dup[4]
                                            ? ld_da_fwd_data_pe_am[39:32]
                                            : ld_da_dcache_data128_ahead_am[39:32];
assign ld_da_ahead_preg_data_unsettle[31:24] = ld_da_fwd_bytes_vld_dup[3]
                                            ? ld_da_fwd_data_pe_am[31:24]
                                            : ld_da_dcache_data128_ahead_am[31:24];
assign ld_da_ahead_preg_data_unsettle[23:16] = ld_da_fwd_bytes_vld_dup[2]
                                            ? ld_da_fwd_data_pe_am[23:16]
                                            : ld_da_dcache_data128_ahead_am[23:16];
assign ld_da_ahead_preg_data_unsettle[15:8] = ld_da_fwd_bytes_vld_dup[1]
                                            ? ld_da_fwd_data_pe_am[15:8]
                                            : ld_da_dcache_data128_ahead_am[15:8];
assign ld_da_ahead_preg_data_unsettle[7:0] = ld_da_fwd_bytes_vld_dup[0]
                                            ? ld_da_fwd_data_pe_am[7:0]
                                            : ld_da_dcache_data128_ahead_am[7:0];

//rotate preg data
// &Instance("ct_lsu_rot_data", "x_lsu_ld_da_ahead_preg_data_rot"); @1276
ct_lsu_rot_data  x_lsu_ld_da_ahead_preg_data_rot (
  .data_in                        (ld_da_ahead_preg_data_unsettle),
  .data_settle_out                (ld_da_ahead_preg_data_settle  ),
  .rot_sel                        (ld_da_data_rot_sel            )
);

// &Connect(.rot_sel         (ld_da_data_rot_sel     ), @1277
//          .data_in         (ld_da_ahead_preg_data_unsettle), @1278
//          .data_settle_out (ld_da_ahead_preg_data_settle )); @1279

//assign ld_da_ahead_vreg_data_unsettle[127:0]  = ld_da_dcache_pass_data128_am[127:0];
//assign ld_da_ahead_vreg_data_unsettle[127:0]  = ld_da_ahead_preg_data_unsettle[127:0];
//rotate vreg data
//&Instance("ct_lsu_rot_data", "x_lsu_ld_da_ahead_vreg_data_rot");
// //&Connect(.rot_sel         (ld_da_data_rot_sel     ), @1285
// //         .data_in         (ld_da_ahead_vreg_data_unsettle), @1286
// //         .data_settle_out (ld_da_ahead_vreg_data_settle )); @1287

//------------------for read buffer merge--------
//boundary inst do not fwd from sd_ex1
assign ld_da_data_ori[63:0]         = ld_da_data_unrot[127:64]
                                      | ld_da_data_unrot[63:0];


//==========================================================
//            Data settle and Sign extend
//==========================================================
//sign extend
assign ld_da_ahead_preg_data_sign0[63:0]      = ld_da_ahead_preg_data_settle[63:0];
assign ld_da_ahead_preg_data_sign1[63:0]      = {{56{ld_da_ahead_preg_data_settle[7]}},ld_da_ahead_preg_data_settle[7:0]};
assign ld_da_ahead_preg_data_sign2[63:0]      = {{48{ld_da_ahead_preg_data_settle[15]}},ld_da_ahead_preg_data_settle[15:0]};
assign ld_da_ahead_preg_data_sign3[63:0]      = {{32{ld_da_ahead_preg_data_settle[31]}},ld_da_ahead_preg_data_settle[31:0]};

// &CombBeg; @1308
always @( ld_da_ahead_preg_data_sign1[63:0]
       or ld_da_ahead_preg_data_sign0[63:0]
       or ld_da_preg_sign_sel[3:0]
       or ld_da_ahead_preg_data_sign3[63:0]
       or ld_da_ahead_preg_data_sign2[63:0])
begin
case(ld_da_preg_sign_sel[3:0])
  4'b1000:ld_da_preg_data_sign_extend[63:0] = ld_da_ahead_preg_data_sign3[63:0];
  4'b0100:ld_da_preg_data_sign_extend[63:0] = ld_da_ahead_preg_data_sign2[63:0];
  4'b0010:ld_da_preg_data_sign_extend[63:0] = ld_da_ahead_preg_data_sign1[63:0];
  4'b0001:ld_da_preg_data_sign_extend[63:0] = ld_da_ahead_preg_data_sign0[63:0];
  default:ld_da_preg_data_sign_extend[63:0] = {64{1'bx}};
endcase
// &CombEnd; @1316
end

//vector data
//assign ld_da_vreg_data_sign_extend[63:0]  = ld_da_vreg_sign_sel && (ld_da_inst_size[1:0] == 2'b10)
//                                            ? {{32{1'b1}},ld_da_ahead_vreg_data_settle[31:0]}
//                                            : ld_da_vreg_sign_sel && (ld_da_inst_size[1:0] == 2'b01)
//                                              ? {{48{1'b1}},ld_da_ahead_vreg_data_settle[15:0]} 
//                                              : ld_da_ahead_vreg_data_settle[63:0];

// &Force("output","ld_da_inst_vls"); @1326
// &Force("output","ld_da_element_size"); @1327
// &Force("output","ld_da_vsew"); @1328
// &CombBeg; @1329
// &CombEnd; @1347
assign ld_da_wb_vreg_sign_sel[1:0] = {ld_da_vreg_sign_sel && (ld_da_inst_size[1:0] == 2'b10),
                                      ld_da_vreg_sign_sel && (ld_da_inst_size[1:0] == 2'b01)};

//==========================================================
//        Request read buffer & Compare index & discard
//==========================================================
//------------------origin create read buffer---------------
//-----------create---------------------
//ld            : cache miss, boundary first
//lr            : cache miss
//ld amo        : any
//borrow mmu    : cache miss

//judge vld pass to read buffer to get rb_full signal
// &Force("output","ld_da_rb_create_judge_vld"); @1365
assign ld_da_rb_create_judge_vld        = ld_da_inst_vld
                                              &&  !ld_da_expt_vld
                                              &&  !ld_da_discard_dc_req
                                              &&  (ld_da_ld_inst &&  !ld_da_secd
                                                  ||  ld_da_atomic)
                                          ||  ld_da_borrow_mmu  &&  ld_da_borrow_vld;

assign ld_da_rb_create_vld_unmask       = ld_da_inst_vld
                                              &&  !ld_da_expt_vld
                                              &&  !ld_da_wait_fence_req
                                              &&  !ld_da_discard_dc_req
                                              &&  !ld_da_sq_fwd_ecc_discard
                                              &&  (ld_da_ld_inst  
                                                      &&  !ld_da_secd 
                                                      &&  (!ld_da_rb_data_vld
                                                          ||  ld_da_boundary_after_mask)
                                                  ||  ld_da_ldamo_inst
                                                      &&  !ld_da_vector_nop
                                                  ||  ld_da_lr_inst
                                                      &&  !ld_da_data_vld)
                                          ||  ld_da_borrow_mmu
                                              &&  ld_da_dcache_miss
                                              &&  ld_da_borrow_vld;

//------------------index hit/discard grnt signal-----------
//addr is used to compare index, so addr0 is enough
assign ld_da_addr[`PA_WIDTH-1:0]           = ld_da_addr0[`PA_WIDTH-1:0];

//because rb and lfb use a common wait queue, they can be granted simultaneously
assign ld_da_discard_from_rb_req  = ld_da_rb_create_vld_unmask
                                        &&  ld_da_page_ca
                                        &&  rb_ld_da_hit_idx
                                    ||  ld_da_rb_merge_vld_unmask
                                        &&  (rb_ld_da_merge_fail
                                            ||  rb_ld_da_hit_idx
                                                &&  ld_da_page_ca
                                                &&  !ld_da_rb_data_vld)
                                    || ld_da_tag_ecc_stall_ori
                                       &&  rb_ld_da_hit_idx;

assign ld_da_discard_from_lfb_req = (ld_da_rb_create_vld_unmask
                                        ||  ld_da_rb_merge_vld_unmask
                                            && !ld_da_rb_data_vld)
                                       &&  ld_da_page_ca
                                       &&  lfb_ld_da_hit_idx
                                    || ld_da_tag_ecc_stall_ori
                                       &&  lfb_ld_da_hit_idx;

assign ld_da_discard_from_lm_req  = (ld_da_rb_create_vld_unmask
                                        ||  ld_da_rb_merge_vld_unmask
                                            && !ld_da_rb_data_vld)
                                       &&  ld_da_page_ca
                                       &&  lm_ld_da_hit_idx
                                    || ld_da_tag_ecc_stall_ori
                                       &&  lm_ld_da_hit_idx;

assign ld_da_hit_idx_discard_req  = ld_da_discard_from_rb_req
                                    ||  ld_da_discard_from_lfb_req
                                    ||  ld_da_discard_from_lm_req;

//because ld_da_hit_idx_discard_vld = ld_da_hit_idx_discard_req, then grnt
//signal needn't see ld_da_hit_idx_discard_vld
assign ld_da_rb_discard_grnt      = ld_da_discard_from_rb_req;
assign ld_da_lfb_discard_grnt     = ld_da_discard_from_lfb_req;
assign ld_da_lm_discard_grnt      = ld_da_discard_from_lm_req;

//record lfb wakeup queue if hit index and create rb
// &Force("output","ld_da_lfb_set_wakeup_queue"); @1433
assign ld_da_lfb_set_wakeup_queue = ld_da_hit_idx_discard_vld;

assign ld_da_lfb_wakeup_queue_next[LSIQ_ENTRY:0]  = {ld_da_mcic_borrow_mmu,
                                                    ld_da_mask_lsid[LSIQ_ENTRY-1:0]};

//------------------create read buffer info-----------------
// &Force("output","ld_da_rb_create_vld"); @1440
assign ld_da_rb_create_vld          = ld_da_rb_create_vld_unmask  
                                      &&  !ld_da_ecc_stall
                                      &&  !ld_da_mcic_data_err
                                      &&  !ld_da_hit_idx_discard_req;
// &Force("output","ld_da_rb_create_dp_vld"); @1445
assign ld_da_rb_create_dp_vld       = ld_da_rb_create_vld_unmask;
// &Force("output","ld_da_rb_create_gateclk_en"); @1447
assign ld_da_rb_create_gateclk_en   = ld_da_rb_create_vld_unmask;

assign ld_da_special_gateclk_en     = ld_da_rb_create_gateclk_en;
//-----------merge signal---------------
//merge signal is used for secd ld instruction
assign ld_da_rb_merge_vld_unmask    = ld_da_inst_vld
                                      &&  !ld_da_wait_fence_req
                                      &&  !ld_da_expt_vld
                                      &&  !ld_da_discard_dc_req
                                      &&  !ld_da_sq_fwd_ecc_discard
                                      &&  ld_da_ld_inst
                                      &&  ld_da_secd
                                      &&  ld_da_boundary;
assign ld_da_rb_merge_vld           = ld_da_rb_merge_vld_unmask
                                      &&  !ld_da_ecc_stall
                                      &&  !ld_da_hit_idx_discard_req;

assign ld_da_rb_merge_dp_vld        = ld_da_rb_merge_vld_unmask;
                                      
//for data merge
//assign ld_da_rb_merge_ecc_stall     = ld_da_ecc_data_req_mask;

//merge expt is for secd ld inst has exception
assign ld_da_rb_merge_expt_vld      = ld_da_inst_vld
                                      &&  ld_da_expt_vld
                                      &&  ld_da_ld_inst
                                      &&  ld_da_secd
                                      &&  ld_da_boundary;

assign ld_da_rb_merge_gateclk_en    = ld_da_rb_merge_vld_unmask;

//-----------rb create signal-----------
//this inst will request lfb addr entry in rb
assign ld_da_rb_create_lfb          = ld_da_page_ca;

assign ld_da_rb_atomic              = ld_da_inst_vld  &&  ld_da_atomic;
assign ld_da_rb_ldamo               = ld_da_inst_vld  &&  ld_da_ldamo_inst;
assign ld_da_rb_cmplt_success       = ld_da_borrow_vld
                                      ||  ld_da_inst_vld
                                          &&  !ld_da_boundary_first
                                          &&  ld_da_inst_cmplt;
assign ld_da_rb_dest_vld            = ld_da_inst_vld;

//==========================================================
//        Compare index
//==========================================================
//it's for the corner condition of read buffer creating port
//if both ld_da & st_da create rb and their index are the same
//------------------compare st_da stage---------------------
assign ld_da_cmp_st_da_addr[`PA_WIDTH-1:0] = st_da_addr[`PA_WIDTH-1:0];
assign ld_da_st_da_hit_idx      = (ld_da_rb_create_vld_unmask
                                      ||  ld_da_rb_merge_vld_unmask)
                                  &&  (ld_da_idx[7:0] ==  ld_da_cmp_st_da_addr[13:6]);
//------------------compare pfu-----------------------------
//if timing is not enough, change ld_da_rb_create_vld_unmask to judge
assign ld_da_cmp_pfu_biu_req_addr[`PA_WIDTH-1:0] = pfu_biu_req_addr[`PA_WIDTH-1:0];
assign ld_da_pfu_biu_req_hit_idx  = (ld_da_rb_create_vld_unmask
                                        ||  ld_da_rb_merge_vld_unmask)
                                    &&  (ld_da_idx[7:0]
                                        ==  ld_da_cmp_pfu_biu_req_addr[13:6]);
//==========================================================
//        Generage commit signal
//==========================================================
assign ld_da_cmit_hit0  = {rtu_yy_xx_commit0,rtu_yy_xx_commit0_iid[6:0]}
                          ==  {1'b1,ld_da_iid[6:0]};
assign ld_da_cmit_hit1  = {rtu_yy_xx_commit1,rtu_yy_xx_commit1_iid[6:0]}
                          ==  {1'b1,ld_da_iid[6:0]};
assign ld_da_cmit_hit2  = {rtu_yy_xx_commit2,rtu_yy_xx_commit2_iid[6:0]}
                          ==  {1'b1,ld_da_iid[6:0]};

assign ld_da_rb_cmit    = ld_da_cmit_hit0
                          ||  ld_da_cmit_hit1
                          ||  ld_da_cmit_hit2;

//==========================================================
//        Restart signal
//==========================================================
assign ld_da_fwd_sq_bypass_vld      = ld_da_fwd_sq_bypass
                                      &&  sd_ex1_inst_vld;
assign ld_da_data_discard_sq_final  = ld_da_data_discard_sq
                                      ||  ld_da_fwd_sq_bypass
                                          &&  !sd_ex1_inst_vld;
assign ld_da_fwd_sq_multi_final     = ld_da_fwd_sq_multi
                                          &&  !ld_da_fwd_sq_multi_mask
                                      ||  ld_da_fwd_bypass_sq_multi;
assign ld_da_discard_wmb_final      = !ld_da_page_ca
                                          &&  ld_da_fwd_wmb_vld
                                      ||  ld_da_discard_wmb;
//-------------------dc reastart req------------------------
assign ld_da_discard_dc_req       = ld_da_other_discard_sq
                                    ||  ld_da_data_discard_sq_final
                                    ||  ld_da_fwd_sq_multi_final
                                    ||  ld_da_discard_wmb_final;
//------------------arbitrate-------------------------------
//1. other discard sq
//2. fwd sq data not vld
//3. fwd sq multi
//4. discard wmb
//5. wait_fence
//6. discard rb/lfb
//7. rb_full
assign ld_da_other_discard_sq_req = ld_da_inst_vld
                                    &&  ld_da_other_discard_sq;
assign ld_da_data_discard_sq_req  = ld_da_inst_vld
                                    &&  ld_da_data_discard_sq_final;
assign ld_da_fwd_sq_multi_req     = ld_da_inst_vld
                                    &&  ld_da_fwd_sq_multi_final;
assign ld_da_discard_wmb_req      = ld_da_inst_vld
                                    &&  ld_da_discard_wmb_final;
assign ld_da_wait_fence_req       = ld_da_inst_vld
                                    &&  ld_da_ld_inst
                                    &&  ld_da_data_vld
                                    &&  ld_da_wait_fence;
assign ld_da_rb_full_req          = ld_da_rb_create_vld
                                    &&  rb_ld_da_full;

assign ld_da_other_discard_sq_vld = ld_da_other_discard_sq_req;
assign ld_da_sq_data_discard_vld  = !ld_da_other_discard_sq_req
                                    &&  ld_da_data_discard_sq_req;
// &Force("output","ld_da_sq_fwd_multi_vld"); @1573
assign ld_da_sq_fwd_multi_vld     = !ld_da_other_discard_sq_req
                                    &&  !ld_da_data_discard_sq_req
                                    &&  ld_da_fwd_sq_multi_req;
assign ld_da_wmb_discard_vld      = !ld_da_other_discard_sq_req
                                    &&  !ld_da_fwd_sq_multi_req
                                    &&  !ld_da_data_discard_sq_req
                                    &&  ld_da_discard_wmb_req;
assign ld_da_wait_fence_vld         = !ld_da_other_discard_sq_req
                                    &&  !ld_da_fwd_sq_multi_req
                                    &&  !ld_da_data_discard_sq_req
                                    &&  !ld_da_discard_wmb_req
                                    &&  ld_da_wait_fence_req;
assign ld_da_wait_fence_gateclk_en  = ld_da_wait_fence_req;
//this logic may be redundant, ld_da_hit_idx_discard_req
//needn't judge other condition, because this signal has already see other
//signals
assign ld_da_hit_idx_discard_vld  = ld_da_hit_idx_discard_req
                                    && !ld_da_ecc_stall;
assign ld_da_rb_full_vld          = !ld_da_other_discard_sq_req
                                    &&  !ld_da_fwd_sq_multi_req
                                    &&  !ld_da_data_discard_sq_req
                                    &&  !ld_da_discard_wmb_req
                                    &&  !ld_da_wait_fence_req
                                    &&  !ld_da_hit_idx_discard_req
                                    &&  ld_da_rb_full_req;
assign ld_da_rb_full_gateclk_en   = ld_da_rb_create_gateclk_en
                                    &&  rb_ld_da_full;

assign ld_da_restart_vld          = ld_da_other_discard_sq_req
                                    ||  ld_da_fwd_sq_multi_req
                                    ||  ld_da_data_discard_sq_req
                                    ||  ld_da_discard_wmb_req
                                    ||  ld_da_hit_idx_discard_req
                                    ||  ld_da_rb_full_req
                                    ||  ld_da_wait_fence_req;

//interface to sq
assign ld_da_sq_global_discard_vld= ld_da_other_discard_sq_vld
                                    ||  ld_da_sq_fwd_multi_vld;
//==========================================================
//                    Settle data
//==========================================================
//------------------settle data to register mode------------
//rot_set signal is set in da stage and plays a role in wb stage

//==========================================================
//                    ECC handling
//==========================================================
// &Instance("ct_lsu_27bit_2stage_ecc_decode","x_ct_lsu_27bit_2stage_ecc_decode_w0"); @1687
// &Connect(.data_decode    (w0_tag_bf_ecc[33:0]        ),   @1688
//          .stage_dp_clk   (ld_da_clk                  ),  @1689
//          .ecc_stage_vld  (tag_ecc_pipe_down          ),  @1690
//          .ham_error      (w0_tag_ham_error           ),  @1691
//          .parity_error   (w0_tag_parity_error        ),  @1692
//          .corrected_data (w0_tag_corrected[26:0]     )  @1693
//         ); @1694
// &Instance("ct_lsu_27bit_2stage_ecc_decode","x_ct_lsu_27bit_2stage_ecc_decode_w1"); @1696
// &Connect(.data_decode    (w1_tag_bf_ecc[33:0]        ),   @1697
//          .stage_dp_clk   (ld_da_clk                  ),  @1698
//          .ecc_stage_vld  (tag_ecc_pipe_down          ),  @1699
//          .ham_error      (w1_tag_ham_error           ),  @1700
//          .parity_error   (w1_tag_parity_error        ),  @1701
//          .corrected_data (w1_tag_corrected[26:0]     )  @1702
//         ); @1703
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank0"); @1776
// &Connect(.data_decode    (data_bank0_bf_ecc[38:0]     ),   @1777
//          .ham_error      (data_bank0_ham_error        ),  @1778
//          .parity_error   (data_bank0_parity_error     ),  @1779
//          .corrected_data (data_bank0_corrected[31:0]  )  @1780
//         ); @1781
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank1"); @1783
// &Connect(.data_decode    (data_bank1_bf_ecc[38:0]     ),   @1784
//          .ham_error      (data_bank1_ham_error        ),  @1785
//          .parity_error   (data_bank1_parity_error     ),  @1786
//          .corrected_data (data_bank1_corrected[31:0]  )  @1787
//         ); @1788
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank2"); @1790
// &Connect(.data_decode    (data_bank2_bf_ecc[38:0]     ),   @1791
//          .ham_error      (data_bank2_ham_error        ),  @1792
//          .parity_error   (data_bank2_parity_error     ),  @1793
//          .corrected_data (data_bank2_corrected[31:0]  )  @1794
//         ); @1795
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank3"); @1797
// &Connect(.data_decode    (data_bank3_bf_ecc[38:0]     ),   @1798
//          .ham_error      (data_bank3_ham_error        ),  @1799
//          .parity_error   (data_bank3_parity_error     ),  @1800
//          .corrected_data (data_bank3_corrected[31:0]  )  @1801
//         ); @1802
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank4"); @1804
// &Connect(.data_decode    (data_bank4_bf_ecc[38:0]     ),   @1805
//          .ham_error      (data_bank4_ham_error        ),  @1806
//          .parity_error   (data_bank4_parity_error     ),  @1807
//          .corrected_data (data_bank4_corrected[31:0]  )  @1808
//         ); @1809
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank5"); @1811
// &Connect(.data_decode    (data_bank5_bf_ecc[38:0]     ),   @1812
//          .ham_error      (data_bank5_ham_error        ),  @1813
//          .parity_error   (data_bank5_parity_error     ),  @1814
//          .corrected_data (data_bank5_corrected[31:0]  )  @1815
//         ); @1816
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank6"); @1818
// &Connect(.data_decode    (data_bank6_bf_ecc[38:0]     ),   @1819
//          .ham_error      (data_bank6_ham_error        ),  @1820
//          .parity_error   (data_bank6_parity_error     ),  @1821
//          .corrected_data (data_bank6_corrected[31:0]  )  @1822
//         ); @1823
// &Instance("ct_lsu_32bit_ecc_decode", "x_ct_dcache_32bit_ecc_decode_bank7"); @1825
// &Connect(.data_decode    (data_bank7_bf_ecc[38:0]     ),   @1826
//          .ham_error      (data_bank7_ham_error        ),  @1827
//          .parity_error   (data_bank7_parity_error     ),  @1828
//          .corrected_data (data_bank7_corrected[31:0]  )  @1829
//         ); @1830
// &Force("output","ld_da_mcic_data_err"); @2038
// &Force("output","ld_da_mcic_data_err"); @2085
assign ld_da_tag_ecc_stall_ori         = 1'b0;  
//assign ld_da_tag_ecc_stall             = 1'b0;  
assign ld_da_ecc_stall_gate            = 1'b0;
assign ld_da_ecc_stall                 = 1'b0;
assign ld_da_ecc_data_req_mask         = 1'b0;
assign ld_da_ecc_mcic_wakup            = 1'b0;
assign ld_da_ecc_wakeup[LSIQ_ENTRY-1:0]= {LSIQ_ENTRY{1'b0}};
assign ld_da_lm_ecc_err                = 1'b0;
assign ld_da_vb_snq_data_reissue       = 1'b0;
assign ld_da_mcic_data_err             = 1'b0;
assign ld_da_fwd_ecc_stall             = 1'b0;
assign ld_da_sq_fwd_ecc_discard        = 1'b0;
assign lsu_idu_ld_da_wait_old[LSIQ_ENTRY-1:0]= {LSIQ_ENTRY{1'b0}};
assign lsu_idu_ld_da_wait_old_gateclk_en     = 1'b0;
assign ld_da_restart_no_cache          = 1'b0;
//==========================================================
//        Generage interface to cache buffer
//==========================================================
assign ld_da_cb_data[127:0] = {128{ld_da_hit_low_region}}  & ld_da_data256_way0[127:0]
                              | {128{ld_da_hit_high_region}}  & ld_da_data256_way0[255:128];
assign ld_da_cb_data_vld    = ld_da_inst_vld
                              &&  ld_da_ld_inst
                              &&  ld_da_cb_addr_create 
                              &&  ld_da_dcache_hit
                              &&  !ld_da_expt_vld
                              &&  !ld_da_restart_no_cache 
                              &&  !rtu_yy_xx_flush 
//                              &&  !(ld_da_ecc_data_req_mask || ld_da_ecc_stall_already)
                              &&  !ld_da_fwd_vld; 
 
assign ld_da_cb_ld_inst_vld = ld_da_inst_vld
                              &&  ld_da_ld_inst
                              &&  ld_da_cb_addr_create;

assign ld_da_cb_ecc_cancel  = ld_da_ecc_data_req_mask || ld_da_ecc_stall_already;
//==========================================================
//        Generage interface to prefetch buffer
//==========================================================
// &Force("output","ld_da_pfu_pf_inst_vld"); @2125
assign ld_da_pfu_pf_inst_vld      = ld_da_inst_vld
                                    &&  ld_da_pf_inst
                                    &&  !ld_da_already_da
                                    &&  !ld_da_expt_ori;

assign ld_da_boundary_cross_2k    = ld_da_pfu_va[11]
                                    !=  ld_da_addr0[11];
//if cache miss and not hit idx, then it can create pmb
assign ld_da_pfu_act_vld          = ld_da_inst_vld
                                    &&  ld_da_pf_inst
                                    &&  !ld_da_expt_ori
                                    &&  (ld_da_rb_create_vld || ld_da_split_miss_ff)
                                    &&  !ld_da_data_vld
                                    &&  !ld_da_boundary_cross_2k;//cross 4k condition will get wrong ppn

assign ld_da_pfu_act_dp_vld       = ld_da_inst_vld
                                    &&  ld_da_pf_inst
                                    &&  !ld_da_expt_ori
                                    &&  !ld_da_data_vld
                                    &&  !ld_da_boundary_cross_2k;//cross 4k condition will get wrong ppn

//for evict count
assign ld_da_pfu_evict_cnt_vld    = ld_da_pfu_pf_inst_vld;

//==========================================================
//        Generage interface to WB stage signal
//==========================================================
//------------------write back cmplt part request-----------
assign ld_da_inst_cmplt    = ld_da_expt_vld
                             || (ld_da_vector_nop || ld_da_expt_ori)
                                 &&  !(ld_da_secd
                                       && ld_da_inst_fof)
                             ||  ld_da_ld_inst
                                 &&  !ld_da_page_so
                                 &&  !ld_da_inst_fof
                             ||  ld_da_inst_fof
                                 &&  ld_da_data_vld
                                 &&  !ld_da_secd
                             ||  ld_da_lr_inst
                                 &&  ld_da_data_vld; 

assign ld_da_wb_cmplt_req     = ld_da_inst_vld
                                &&  !ld_da_ecc_stall
                                &&  !ld_da_sq_fwd_ecc_discard
                                &&  !ld_da_restart_vld
                                &&  !ld_da_boundary_first
                                &&  ld_da_inst_cmplt;
//------------------write back data part request------------
assign ld_da_wb_data_req_mask = ld_da_other_discard_sq_req
                                ||  ld_da_fwd_sq_multi_req
                                ||  ld_da_data_discard_sq_req
                                ||  ld_da_discard_wmb_req
                                ||  ld_da_wait_fence_req;

assign ld_da_wb_data_req      = ld_da_inst_vld
                                &&  (ld_da_ld_inst 
                                     || ld_da_lr_inst
                                     || ld_da_ldamo_inst 
                                        && (ld_da_ecc_stall_fatal
                                            ||  ld_da_vector_nop))
                                &&  (!ld_da_expt_vld
                                        &&  ld_da_rb_data_vld
                                     || ld_da_ecc_stall_fatal) 
                                &&  !ld_da_ecc_data_req_mask
                                &&  !ld_da_sq_fwd_ecc_discard
                                &&  !ld_da_wb_data_req_mask
                                &&  !ld_da_boundary_after_mask;

assign ld_da_wb_data_req_gateclk_en = ld_da_inst_vld
                                      &&  (ld_da_dcache_hit
                                           || ld_da_fwd_sq_vld
                                           || ld_da_fwd_wmb_vld
                                           || ld_da_fwd_sq_bypass
                                           || ld_da_vector_nop
                                           || ld_da_fof_not_first
                                           || ld_da_ecc_stall_fatal); 
//------------------other signal---------------------------
assign ld_da_wb_spec_fail     = (ld_da_spec_fail || ld_da_ecc_spec_fail)
                                &&  !ld_da_expt_vld
                                &&  !ld_da_split;

//assign ld_da_wb_sign[2:0]     = {3{ld_da_sign}};

//==========================================================
//        Generate interface to borrow module
//==========================================================
assign ld_da_borrow_db_vld = ld_da_borrow_vld
                             && (ld_da_borrow_sndb || ld_da_borrow_vb);

assign ld_da_vb_borrow_vb[VB_DATA_ENTRY-1:0] = {VB_DATA_ENTRY{ld_da_borrow_db_vld}}
                                                & ld_da_borrow_db[VB_DATA_ENTRY-1:0];

assign ld_da_snq_borrow_sndb              = ld_da_borrow_vld
                                            &&  ld_da_borrow_sndb;

assign ld_da_snq_borrow_icc               = ld_da_borrow_vld
                                            &&  ld_da_borrow_icc;
//for icc, settle way actually means high region

assign ld_da_icc_tag_read[127:0]  = {101'b0,ld_da_tag_read[26:0]};
assign ld_da_icc_data_read[127:0] = ld_da_settle_way
                                    ? ld_da_data256_way0[255:128]
                                    : ld_da_data256_way0[127:0];
assign ld_da_icc_read_data[127:0] = ld_da_borrow_icc_tag
                                    ? ld_da_icc_tag_read[127:0]
                                    : ld_da_icc_data_read[127:0];

// &Force("output","ld_da_mcic_borrow_mmu"); @2258
assign ld_da_mcic_borrow_mmu              = ld_da_borrow_vld
                                            &&  ld_da_borrow_mmu;
assign ld_da_mcic_borrow_mmu_req          = ld_da_mcic_borrow_mmu
                                            && !ld_da_ecc_data_req_mask;

assign ld_da_mcic_wakeup                  = ld_da_mcic_borrow_mmu
                                               && !ld_da_ecc_stall
                                               &&  rtu_yy_xx_flush
                                            || ld_da_ecc_mcic_wakup;
//rb_full_vld has exclude ld_da_hit_idx_discard_req
assign ld_da_mcic_rb_full                 = ld_da_borrow_vld
                                            &&  ld_da_borrow_mmu
                                            &&  !rtu_yy_xx_flush
                                            &&  ld_da_rb_full_vld;
assign ld_da_mcic_bypass_data_ori[63:0]   = ld_da_addr0[3]
                                            ? ld_da_dcache_pass_data128_am[127:64]
                                            : ld_da_dcache_pass_data128_am[63:0];

assign ld_da_mcic_bypass_data[63:0]       = ld_da_mcic_data_err
                                            ? 64'b0
                                            : ld_da_mcic_bypass_data_ori[63:0];
//==========================================================
//              Interface to other module
//==========================================================
//-----------interface to local monitor---------------------
assign ld_da_lm_no_req      = ld_da_inst_vld
                              &&  ld_da_lr_inst
                              &&  ld_da_data_vld;

assign ld_da_lm_vector_nop  = ld_da_inst_vld
                              &&  ld_da_ldamo_inst 
                              &&  ld_da_vector_nop; 
//==========================================================
//        Generate lsiq signal
//==========================================================
assign ld_da_mask_lsid[LSIQ_ENTRY-1:0]      = {LSIQ_ENTRY{ld_da_inst_vld}}
                                              & ld_da_lsid[LSIQ_ENTRY-1:0];

assign ld_da_merge_mask                     = ld_da_merge_from_cb
                                              && ld_da_dcache_hit
                                              && !ld_da_fwd_vld;

// &Force("output","ld_da_boundary_after_mask"); @2301
assign ld_da_boundary_after_mask            = ld_da_inst_vld
                                              &&  ld_da_boundary
                                              &&  !ld_da_merge_mask
                                              &&  !ld_da_expt_vld;

assign ld_da_boundary_first                 = ld_da_boundary_after_mask
                                              &&  !ld_da_secd;

assign ld_da_ecc_spec_fail = 1'b0;

//-----------lsiq signal----------------
assign ld_da_idu_already_da[LSIQ_ENTRY-1:0] = ld_da_mask_lsid[LSIQ_ENTRY-1:0];

assign ld_da_idu_rb_full[LSIQ_ENTRY-1:0]    = {LSIQ_ENTRY{ld_da_rb_full_vld}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];

assign ld_da_idu_wait_fence[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{ld_da_wait_fence_vld}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];

// &Force("output","ld_da_idu_pop_vld"); @2326
assign ld_da_idu_pop_vld                    = ld_da_inst_vld
                                              &&  !ld_da_boundary_first
                                              &&  !ld_da_ecc_stall
                                              &&  !ld_da_sq_fwd_ecc_discard
                                              &&  !ld_da_restart_vld;
assign ld_da_idu_pop_entry[LSIQ_ENTRY-1:0]  = {LSIQ_ENTRY{ld_da_idu_pop_vld}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];

assign ld_da_idu_spec_fail[LSIQ_ENTRY-1:0]  = {LSIQ_ENTRY{ld_da_spec_fail
                                                          &&  ld_da_boundary_first
                                                          || ld_da_ecc_spec_fail}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];
assign ld_da_idu_bkpta_data[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{ld_da_bkpta_data
                                                          &&  ld_da_boundary_first}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];
assign ld_da_idu_bkptb_data[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{ld_da_bkptb_data
                                                          &&  ld_da_boundary_first}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];
            
//---------boundary gateclk-------------
assign ld_da_idu_boundary_gateclk_vld       = ld_da_inst_vld
                                              &&  ld_da_boundary_first;

assign ld_da_idu_boundary_gateclk_en[LSIQ_ENTRY-1:0]  = 
                {LSIQ_ENTRY{ld_da_idu_boundary_gateclk_vld}}
                & ld_da_mask_lsid[LSIQ_ENTRY-1:0];
//-----------imme wakeup----------------
assign ld_da_idu_secd_vld                   = ld_da_boundary_first
                                              &&  !ld_da_ecc_stall
                                              &&  !ld_da_sq_fwd_ecc_discard
                                              &&  !ld_da_restart_vld;

assign ld_da_idu_secd[LSIQ_ENTRY-1:0]       = {LSIQ_ENTRY{ld_da_idu_secd_vld}}
                                              & ld_da_mask_lsid[LSIQ_ENTRY-1:0];

//==========================================================
//        Generate interface to rtu
//==========================================================
assign lsu_rtu_da_pipe3_split_spec_fail_vld = ld_da_inst_vld
                                              &&  !ld_da_expt_vld
                                              &&  ld_da_split
                                              &&  (ld_da_spec_fail || ld_da_ecc_spec_fail);
assign lsu_rtu_da_pipe3_split_spec_fail_iid[6:0]  = ld_da_iid[6:0];

//==========================================================
//        pipe3 data wb
//==========================================================
assign lsu_idu_da_pipe3_fwd_preg_vld        = ld_da_ahead_preg_wb_vld
                                              && !ld_da_expt_access_fault_mmu;
assign lsu_idu_da_pipe3_fwd_preg[6:0]       = ld_da_preg[6:0];
assign lsu_idu_da_pipe3_fwd_preg_data[63:0] = ld_da_preg_data_sign_extend[63:0];
assign lsu_idu_da_pipe3_fwd_vreg_vld        = ld_da_ahead_vreg_wb_vld
                                              && !ld_da_expt_access_fault_mmu;
//assign lsu_idu_da_pipe3_fwd_vreg[6:0]       = {1'b0,ld_da_vreg[5:0]};

//assign lsu_idu_da_pipe3_fwd_vreg_fr_data[63:0]  = ld_da_vreg_data_sign_extend[63:0];
assign lsu_idu_da_pipe3_fwd_vreg[6:0]           = 7'b0;
assign lsu_idu_da_pipe3_fwd_vreg_fr_data[63:0]  = 64'b0;
assign lsu_idu_da_pipe3_fwd_vreg_vr0_data[63:0] = 64'b0;
assign lsu_idu_da_pipe3_fwd_vreg_vr1_data[63:0] = 64'b0;

//==========================================================
//                Flop for ld_da
//==========================================================
assign ld_da_ff_clk_en  = ld_da_inst_vld
                          && (cp0_yy_dcache_pref_en || cp0_lsu_l2_pref_en);
// &Instance("gated_clk_cell", "x_lsu_ld_da_ff_gated_clk"); @2393
gated_clk_cell  x_lsu_ld_da_ff_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_da_ff_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ld_da_ff_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @2394
//          .external_en   (1'b0               ), @2395
//          .global_en     (1'b1               ), @2396
//          .module_en     (cp0_lsu_icg_en     ), @2397
//          .local_en      (ld_da_ff_clk_en    ), @2398
//          .clk_out       (ld_da_ff_clk       )); @2399

always @(posedge ld_da_ff_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_da_ppn_ff[`PA_WIDTH-13:0]  <=  {`PA_WIDTH-12{1'b0}};
    ld_da_page_sec_ff             <=  1'b0;
    ld_da_page_share_ff           <=  1'b0;
  end
  else if(ld_da_inst_vld)
  begin
    ld_da_ppn_ff[`PA_WIDTH-13:0]  <=  ld_da_addr0[`PA_WIDTH-1:12];
    ld_da_page_sec_ff             <=  ld_da_page_sec;
    ld_da_page_share_ff           <=  ld_da_page_share;
  end
end

//for preload
//when split load cache miss,record
assign ld_da_split_miss = ld_da_inst_vld
                          && ld_da_ld_inst
                          && ld_da_page_ca
                          && cp0_lsu_dcache_en
                          && ld_da_split
                          && !ld_da_secd
                          && !ld_da_expt_vld
                          && ld_da_rb_create_vld
                          && !ld_da_data_vld;

assign ld_da_split_last = ld_da_inst_vld
                          && ld_da_ld_inst
                          && !ld_da_split;

always @(posedge ld_da_ff_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_da_split_miss_ff           <=  1'b0;
  else if(ld_da_split_miss)
    ld_da_split_miss_ff           <=  1'b1;
  else if(ld_da_split_last)
    ld_da_split_miss_ff           <=  1'b0;
end
//==========================================================
//        interface for spec_fail prediction
//==========================================================
assign ld_da_spec_chk_req  = ld_da_inst_vld
                             && ld_da_ld_inst
                             && cp0_lsu_nsfe
                             && !ld_da_page_so 
                             && !ld_da_expt_vld_except_access_err 
                             && !ld_da_restart_vld; 

assign ld_da_sf_spec_chk_req         = ld_da_spec_chk_req;
//assign ld_da_sf_iid[6:0]             = ld_da_iid[6:0];
assign ld_da_sf_addr_tto4[`PA_WIDTH-5:0]  = ld_da_addr0[`PA_WIDTH-1:4];
assign ld_da_sf_bytes_vld[15:0]           = ld_da_bytes_vld[15:0];


//wb_cmplt
assign ld_da_wb_no_spec_miss     = ld_da_inst_vld
                                   && cp0_lsu_nsfe
                                   && !ld_da_no_spec
                                   && sf_spec_mark;
assign ld_da_wb_no_spec_hit      = ld_da_inst_vld
                                   && cp0_lsu_nsfe
                                   && ld_da_no_spec
                                   && sf_spec_hit;
assign ld_da_wb_no_spec_mispred  = ld_da_inst_vld
                                   && cp0_lsu_nsfe
                                   && ld_da_no_spec
                                   && (!ld_da_no_spec_exist || !sf_spec_hit);

//==========================================================
//        interface to hpcp
//==========================================================
// &Force("output","ld_da_rb_merge_vld"); @2476
assign lsu_hpcp_ld_cache_access = ld_da_inst_vld
                                  &&  ld_da_ld_inst
                                  &&  ld_da_page_ca
                                  &&  cp0_lsu_dcache_en
                                  &&  !ld_da_already_da;
assign lsu_hpcp_ld_cache_miss   = ld_da_inst_vld
                                  &&  ld_da_ld_inst
                                  &&  ld_da_page_ca
                                  &&  cp0_lsu_dcache_en
                                  &&  !ld_da_data_vld
                                  &&  (ld_da_rb_create_vld
                                          &&  !rb_ld_da_full
                                              || ld_da_rb_merge_vld
                                              || ld_da_discard_from_lfb_req
                                          && ld_hit_prefetch);
assign lsu_hpcp_ld_discard_sq    = ld_da_inst_vld
                                   &&  (ld_da_other_discard_sq_req
                                        || ld_da_fwd_sq_multi_req)
                                   &&  !ld_da_already_da;

assign lsu_hpcp_ld_data_discard  = ld_da_inst_vld
                                   &&  ld_da_data_discard_sq_req
                                   &&  !ld_da_already_da;

assign lsu_hpcp_ld_unalign_inst  = ld_da_inst_vld
                                   &&  !ld_da_already_da
                                   &&  ld_da_secd;
// &Force("nonport","ld_da_already_da"); @2505
// &ModuleEnd; @2507
endmodule


