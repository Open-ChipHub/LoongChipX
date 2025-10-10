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

// &Depend("cpu_cfig.h"); @17
// &Depend("aq_lsu_cfig.h"); @18

// &ModuleBeg; @20
module aq_lsu_dc (
  // &Ports, @21
  input    wire  [39 :0]  ag_dc_addr,
  input    wire  [4  :0]  ag_dc_amo_func,
  input    wire           ag_dc_buf,
  input    wire  [7  :0]  ag_dc_bytes_vld,
  input    wire           ag_dc_ca,
  input    wire  [3  :0]  ag_dc_data_shift,
  input    wire  [5  :0]  ag_dc_dest_reg,
  input    wire           ag_dc_expt_vld,
  input    wire  [19 :0]  ag_dc_func,
  input    wire  [4  :0]  ag_dc_hint_size,
  input    wire  [15 :0]  ag_dc_inst_pc,
  input    wire           ag_dc_inst_vld,
  input    wire           ag_dc_inst_vld_dp,
  input    wire           ag_dc_inst_vld_gate,
  input    wire           ag_dc_pf_amr_mask,
  input    wire  [1  :0]  ag_dc_priv_mode,
  input    wire           ag_dc_sec,
  input    wire  [1  :0]  ag_dc_sew,
  input    wire           ag_dc_sh,
  input    wire           ag_dc_so,
  input    wire           ag_dc_src2_depd,
  input    wire  [5  :0]  ag_dc_src2_reg,
  input    wire  [63 :0]  ag_dc_st_data,
  input    wire           ag_dc_unalign,
  input    wire           ag_dc_unalign_last,
  input    wire           ag_dc_vec_nop,
  input    wire  [1  :0]  ag_dc_virt_idx,
  input    wire  [9  :0]  ag_dc_vlsu_split_cnt,
  input    wire           ag_dc_vlsu_split_last,
  input    wire           ag_dc_vlsu_sseg_first,
  input    wire           ag_dc_vlsu_vl_update,
  input    wire  [6  :0]  ag_dc_vlsu_vl_upval,
  input    wire  [3  :0]  ag_dc_vlsu_wdata_shift,
  input    wire           ag_inst_store,
  input    wire           amr_dc_wa_dis,
  input    wire           arb_dc_grant,
  input    wire           cp0_lsu_dcache_en,
  input    wire           cp0_lsu_dcache_wa,
  input    wire           cp0_lsu_icg_en,
  input    wire           cpurst_b,
  input    wire  [63 :0]  dcache_data_dout_bank0,
  input    wire  [63 :0]  dcache_data_dout_bank1,
  input    wire  [63 :0]  dcache_data_dout_bank2,
  input    wire  [63 :0]  dcache_data_dout_bank3,
  input    wire  [7  :0]  dcache_dirty_dout,
  input    wire  [119:0]  dcache_tag_dout_bank0,
  input    wire  [119:0]  dcache_tag_dout_bank1,
  input    wire           forever_cpuclk,
  input    wire           hpcp_lsu_cnt_en,
  input    wire  [3  :0]  icc_dc_acc_fifo,
  input    wire  [1  :0]  icc_dc_acc_idx,
  input    wire           icc_dc_sel,
  input    wire           ifu_lsu_warm_up,
  input    wire  [4  :0]  lfb_dc_amo_func,
  input    wire           lfb_dc_amo_inst,
  input    wire           lfb_dc_bus_err,
  input    wire  [7  :0]  lfb_dc_bytes_vld,
  input    wire  [63 :0]  lfb_dc_data,
  input    wire  [3  :0]  lfb_dc_data_shift,
  input    wire           lfb_dc_data_vld,
  input    wire  [5  :0]  lfb_dc_dest_reg,
  input    wire  [1  :0]  lfb_dc_ele_size,
  input    wire           lfb_dc_fls,
  input    wire           lfb_dc_full,
  input    wire           lfb_dc_hit_addr,
  input    wire           lfb_dc_hit_idx,
  input    wire           lfb_dc_hit_preg,
  input    wire           lfb_dc_lock,
  input    wire  [39 :0]  lfb_dc_mtval,
  input    wire           lfb_dc_pop_en,
  input    wire           lfb_dc_ptw,
  input    wire  [1  :0]  lfb_dc_sew,
  input    wire           lfb_dc_sign_ext,
  input    wire  [1  :0]  lfb_dc_size,
  input    wire           lfb_dc_so_vld,
  input    wire           lfb_dc_split,
  input    wire           lfb_dc_split_first,
  input    wire           lfb_dc_split_second,
  input    wire  [1  :0]  lfb_dc_stb_id,
  input    wire           lfb_dc_uncmplt_vreg,
  input    wire  [7  :0]  lfb_dc_vfunc,
  input    wire           lfb_dc_vl_update,
  input    wire  [6  :0]  lfb_dc_vl_val,
  input    wire           lfb_dc_vls,
  input    wire           lfb_dc_vsplit_last,
  input    wire           lm_pass,
  input    wire  [39 :0]  mcic_dc_addr,
  input    wire  [7  :0]  mcic_dc_bytes_vld,
  input    wire  [1  :0]  mcic_dc_priv_mode,
  input    wire           mcic_dc_req,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [39 :0]  pfb_xx_pa,
  input    wire  [3  :0]  rdl_dc_acc_fifo,
  input    wire  [1  :0]  rdl_dc_acc_idx,
  input    wire  [39 :0]  rdl_dc_acc_tag,
  input    wire           rdl_dc_sel,
  input    wire           rtu_lsu_async_expt_ack,
  input    wire           rtu_yy_xx_async_flush,
  input    wire           rtu_yy_xx_dbgon,
  input    wire  [1  :0]  stb_dc_create_id,
  input    wire           stb_dc_fwd_vld,
  input    wire           stb_dc_hit_addr,
  input    wire           stb_dc_hit_addr_wca,
  input    wire           stb_dc_hit_dca,
  input    wire           stb_dc_hit_idx,
  input    wire           stb_dc_hit_not_ready,
  input    wire  [63 :0]  stb_dc_ld_data,
  input    wire           stb_dc_ld_fwd_vld,
  input    wire           stb_dc_merge_en,
  input    wire           stb_dc_multi_or_part_hit,
  input    wire           stb_dc_pop_en,
  input    wire           stb_dc_ready,
  input    wire           stb_dc_so_vld,
  input    wire           vb_dc_hit_idx,
  input    wire           vb_dc_pop_en,
  input    wire           vlsu_buf_stall,
  input    wire  [3  :0]  vlsu_lsu_data_shift,
  input    wire           vlsu_lsu_data_vld,
  input    wire  [63 :0]  vlsu_lsu_fwd_data,
  input    wire  [4  :0]  vlsu_lsu_fwd_dest_reg,
  input    wire           vlsu_lsu_fwd_vld,
  input    wire           vlsu_lsu_src2_depd,
  input    wire  [4  :0]  vlsu_lsu_src2_reg,
  input    wire  [63 :0]  vlsu_lsu_wdata,
  output   wire  [4  :0]  da_amo_alu_func,
  output   wire  [1  :0]  da_amo_alu_size,
  output   wire  [63 :0]  da_amo_alu_src0,
  output   wire           da_amo_src_vld,
  output   wire  [1  :0]  da_amo_stb_id,
  output   wire  [63 :0]  da_dtu_data,
  output   wire           da_dtu_data_vld,
  output   wire  [1  :0]  da_stb_amo_src_id,
  output   wire  [63 :0]  da_xx_fwd_data,
  output   wire  [5  :0]  da_xx_fwd_dst_reg,
  output   wire           da_xx_fwd_vld,
  output   wire           da_xx_no_op,
  output   wire           dc_ag_stall,
  output   wire           dc_amr_cancel,
  output   wire  [39 :0]  dc_amr_st_addr,
  output   wire           dc_amr_st_mask,
  output   wire           dc_amr_st_miss,
  output   wire           dc_amr_st_req,
  output   wire           dc_amr_st_req_gate,
  output   wire  [4  :0]  dc_amr_st_size,
  output   wire  [13 :0]  dc_arb_data_idx,
  output   wire           dc_arb_data_req,
  output   wire  [3  :0]  dc_arb_data_way,
  output   wire  [11 :0]  dc_arb_tag_idx,
  output   wire           dc_arb_tag_req,
  output   wire  [3  :0]  dc_arb_tag_sel,
  output   wire  [3  :0]  dc_arb_tag_way,
  output   wire  [9  :0]  dc_dbginfo,
  output   wire  [127:0]  dc_icc_dcache_data,
  output   wire  [3  :0]  dc_icc_dcache_dirty,
  output   wire  [27 :0]  dc_icc_dcache_tag,
  output   wire           dc_icc_dcache_tagvld,
  output   wire           dc_lfb_alias_hit,
  output   wire  [1  :0]  dc_lfb_alias_idx,
  output   wire  [4  :0]  dc_lfb_amo_func,
  output   wire           dc_lfb_amo_inst,
  output   wire  [2  :0]  dc_lfb_attr,
  output   wire  [7  :0]  dc_lfb_bytes_vld,
  output   wire           dc_lfb_ca,
  output   wire           dc_lfb_create_en,
  output   wire           dc_lfb_create_en_gate,
  output   wire  [5  :0]  dc_lfb_dest_reg,
  output   wire  [1  :0]  dc_lfb_ele_size,
  output   wire           dc_lfb_fls,
  output   wire  [3  :0]  dc_lfb_hit_way,
  output   wire           dc_lfb_inst_ld,
  output   wire           dc_lfb_lock,
  output   wire  [39 :0]  dc_lfb_pa,
  output   wire  [1  :0]  dc_lfb_priv_mode,
  output   wire           dc_lfb_ptw,
  output   wire  [1  :0]  dc_lfb_sew,
  output   wire  [3  :0]  dc_lfb_shift,
  output   wire           dc_lfb_sign_ext,
  output   wire  [1  :0]  dc_lfb_size,
  output   wire           dc_lfb_split,
  output   wire           dc_lfb_split_last,
  output   wire  [1  :0]  dc_lfb_st_id,
  output   wire  [7  :0]  dc_lfb_vfunc,
  output   wire  [1  :0]  dc_lfb_virt_idx,
  output   wire  [6  :0]  dc_lfb_vl_val,
  output   wire           dc_lfb_vls,
  output   wire           dc_lfb_vsplit_last,
  output   wire           dc_mcic_bus_err,
  output   wire  [63 :0]  dc_mcic_data,
  output   wire           dc_mcic_data_vld,
  output   wire           dc_pfb_dca_vld,
  output   wire           dc_pfb_hit_idx,
  output   wire  [39 :0]  dc_pfb_ld_chk_pa,
  output   wire  [1  :0]  dc_pfb_ld_chk_virt_idx,
  output   wire  [39 :0]  dc_pfb_ld_init_pa,
  output   wire  [1  :0]  dc_pfb_ld_init_virt_idx,
  output   wire           dc_pfb_ld_mask,
  output   wire           dc_pfb_ld_miss,
  output   wire  [15 :0]  dc_pfb_ld_pc,
  output   wire           dc_pfb_ld_vld,
  output   wire           dc_pfb_ld_vld_gate,
  output   wire  [1  :0]  dc_pfb_priv_mode,
  output   wire           dc_rdl_alias_hit,
  output   wire  [1  :0]  dc_rdl_alias_idx,
  output   wire  [3  :0]  dc_rdl_alias_way,
  output   wire           dc_rdl_cache_hit,
  output   wire  [127:0]  dc_rdl_dcache_data,
  output   wire  [3  :0]  dc_rdl_dcache_dirty,
  output   wire  [3  :0]  dc_rdl_dcache_fifo,
  output   wire  [27 :0]  dc_rdl_dcache_tag,
  output   wire           dc_rdl_dcache_vld,
  output   wire           dc_stb_alct,
  output   wire  [1  :0]  dc_stb_alias_idx,
  output   wire           dc_stb_amo_inst,
  output   wire  [2  :0]  dc_stb_attr,
  output   wire  [7  :0]  dc_stb_bytes_vld,
  output   wire           dc_stb_cache_hit,
  output   wire           dc_stb_clr_vld,
  output   reg   [63 :0]  dc_stb_data,
  output   wire  [3  :0]  dc_stb_data_shift,
  output   wire           dc_stb_dca_inst,
  output   wire  [1  :0]  dc_stb_dca_type,
  output   wire  [3  :0]  dc_stb_hit_way,
  output   wire           dc_stb_lock,
  output   wire  [39 :0]  dc_stb_pa,
  output   wire  [1  :0]  dc_stb_priv_mode,
  output   wire           dc_stb_req,
  output   wire           dc_stb_req_gate,
  output   wire  [1  :0]  dc_stb_size,
  output   wire           dc_stb_src2_depd,
  output   wire  [4  :0]  dc_stb_src2_reg,
  output   wire  [1  :0]  dc_stb_virt_idx,
  output   wire           dc_stb_wait_lfb,
  output   wire  [7  :0]  dc_xx_bytes_vld,
  output   wire           dc_xx_dcache_req_mask,
  output   wire  [5  :0]  dc_xx_dest_preg,
  output   wire           dc_xx_no_op,
  output   wire  [39 :0]  dc_xx_pa,
  output   wire           lm_clr,
  output   wire  [39 :0]  lm_req_addr,
  output   wire  [1  :0]  lm_req_size,
  output   wire           lm_set,
  output   wire           lm_set_gate,
  output   reg            lsu_hpcp_cache_read_access,
  output   reg            lsu_hpcp_cache_read_miss,
  output   reg            lsu_hpcp_cache_write_access,
  output   reg            lsu_hpcp_cache_write_miss,
  output   reg            lsu_hpcp_inst_store,
  output   reg            lsu_hpcp_unalign_inst,
  output   wire  [63 :0]  lsu_iu_ex2_data,
  output   wire           lsu_iu_ex2_data_vld,
  output   wire  [4  :0]  lsu_iu_ex2_dest_reg,
  output   wire           lsu_rtu_async_expt_vld,
  output   wire           lsu_rtu_async_ld_inst,
  output   wire  [39 :0]  lsu_rtu_async_tval,
  output   wire  [63 :0]  lsu_rtu_ex2_data,
  output   wire           lsu_rtu_ex2_data_vld,
  output   wire  [5  :0]  lsu_rtu_ex2_dest_reg,
  output   wire  [63 :0]  lsu_rtu_wb_data,
  output   wire  [5  :0]  lsu_rtu_wb_dest_reg,
  output   wire           lsu_rtu_wb_vld,
  output   wire  [7  :0]  lsu_vlsu_bytes_vld,
  output   wire  [63 :0]  lsu_vlsu_data,
  output   wire           lsu_vlsu_data_grant,
  output   wire           lsu_vlsu_data_vld,
  output   wire           lsu_vlsu_dc_create_vld,
  output   wire           lsu_vlsu_dc_fld_req,
  output   wire           lsu_vlsu_dc_fof,
  output   wire  [2  :0]  lsu_vlsu_dc_nf,
  output   wire  [1  :0]  lsu_vlsu_dc_sew,
  output   wire  [9  :0]  lsu_vlsu_dc_split_cnt,
  output   wire           lsu_vlsu_dc_sseg_first,
  output   wire           lsu_vlsu_dc_stall,
  output   wire           lsu_vlsu_st_stall,
  output   wire  [4  :0]  lsu_vlsu_dest_reg,
  output   wire           lsu_vlsu_expt_vld,
  output   wire  [19 :0]  lsu_vlsu_func,
  output   wire  [1  :0]  lsu_vlsu_sew,
  output   wire           lsu_vlsu_split_last,
  output   wire           lsu_vlsu_st_expt,
  output   wire  [3  :0]  lsu_vlsu_st_offset,
  output   wire  [1  :0]  lsu_vlsu_st_sew,
  output   wire  [1  :0]  lsu_vlsu_st_size,
  output   wire           lsu_vlsu_vl_update,
  output   wire  [6  :0]  lsu_vlsu_vl_upval
); 



// &Regs; @22
reg              async_expt_vld;             
reg              async_ld_inst;              
reg     [39 :0]  async_mtval;                
reg     [7  :0]  bytes_vld_align;            
reg     [4  :0]  da_amo_func;                
reg              da_amo_inst;                
reg     [7  :0]  da_bytes_vld;               
reg     [63 :0]  da_data;                    
reg     [5  :0]  da_dest_reg;                
reg     [1  :0]  da_ele_size;                
reg              da_expt_vld;                
reg              da_fls;                     
reg              da_inst_vld;                
reg              da_lock;                    
reg              da_sc_inst;                 
reg     [1  :0]  da_sew;                     
reg              da_sign_ext;                
reg     [1  :0]  da_size;                    
reg     [1  :0]  da_stb_id;                  
reg              da_vec_nop;                 
reg     [7  :0]  da_vfunc;                   
reg              da_vl_update;               
reg     [6  :0]  da_vl_val;                  
reg              da_vls;                     
reg              da_vsplit_last;             
reg     [63 :0]  data_align;                 
reg     [63 :0]  data_align_ext;             
reg     [63 :0]  data_align_fls_ext;         
reg     [63 :0]  data_align_vls_ext;         
reg     [4  :0]  dc_amo_func;                
reg     [2  :0]  dc_attr;                    
reg     [7  :0]  dc_bytes_vld;               
reg     [1  :0]  dc_cur_state;               
reg     [7  :0]  dc_da_bytes_vld_ext;        
reg     [63 :0]  dc_data;                    
reg     [3  :0]  dc_data_shift;              
reg     [1  :0]  dc_dca_type;                
reg     [5  :0]  dc_dest_reg;                
reg     [1  :0]  dc_ele_size;                
reg              dc_expt_vld;                
reg              dc_fls;                     
reg     [19 :0]  dc_func;                    
reg     [4  :0]  dc_hint_size;               
reg     [15 :0]  dc_ld_pc;                   
reg     [1  :0]  dc_next_state;              
reg     [39 :0]  dc_pa;                      
reg              dc_pf_amr_mask;             
reg     [39 :0]  dc_pf_amr_pa;               
reg     [1  :0]  dc_pf_virt_idx;             
reg     [1  :0]  dc_priv_mode;               
reg              dc_ptw;                     
reg     [1  :0]  dc_sew;                     
reg              dc_sign_ext;                
reg     [1  :0]  dc_size;                    
reg              dc_split;                   
reg              dc_split_last;              
reg              dc_src2_depd;               
reg     [5  :0]  dc_src2_reg;                
reg              dc_sseg_first;              
reg     [63 :0]  dc_st_data_reg;             
reg     [7  :0]  dc_vfunc;                   
reg     [1  :0]  dc_virt_idx;                
reg              dc_vl_update;               
reg     [6  :0]  dc_vl_val;                  
reg              dc_vls;                     
reg              dc_vls_nop;                 
reg     [3  :0]  dc_vlsu_data_shift;         
reg     [9  :0]  dc_vsplit_cnt;              
reg              dc_vsplit_last;             
reg     [3  :0]  dc_wdata_shift;             
reg              dc_wdata_vld;               
reg     [127:0]  dc_xx_dcache_data;          
reg     [27 :0]  dc_xx_dcache_tag;           
reg              dc_xx_dcache_vld;           
reg              debug_mode_async_err;       
reg              mb_bus_err;                 
reg     [7  :0]  mb_bytes_vld;               
reg     [63 :0]  mb_data;                    
reg              mb_data_vld;                
reg              mb_vld;                     

// &Wires; @23
wire             ag_dc_create_vld;           
wire    [63 :0]  ag_dc_st_create_data;       
wire             ag_dc_st_create_vld;        
wire    [4  :0]  ag_ptw_amo_func;            
wire    [2  :0]  ag_ptw_attr;                
wire    [7  :0]  ag_ptw_bytes_vld;           
wire    [3  :0]  ag_ptw_data_shift;          
wire    [5  :0]  ag_ptw_dest_reg;            
wire             ag_ptw_expt_vld;            
wire    [19 :0]  ag_ptw_func;                
wire    [15 :0]  ag_ptw_inst_pc;             
wire    [39 :0]  ag_ptw_pa;                  
wire             ag_ptw_pf_amr_mask;         
wire    [1  :0]  ag_ptw_priv_mode;           
wire             ag_ptw_split;               
wire             ag_ptw_split_last;          
wire    [1  :0]  ag_ptw_virt_idx;            
wire             ag_ptw_vld;                 
wire             ag_ptw_vld_dp;              
wire             ag_st_inst;                 
wire             ag_vfls;                    
wire             ag_vls;                     
wire             ag_vls_create_vld;          
wire    [4  :0]  amo_func;                   
wire             amo_inst;                   
wire    [7  :0]  bytes_vld;                  
wire             da_amo_no_wd;               
wire             da_clk;                     
wire             da_clk_en;                  
wire             da_data_clk;                
wire             da_data_clk_en;             
wire    [63 :0]  da_dc_fwd_data;             
wire             da_vfls;                    
wire    [63 :0]  data;                       
wire    [63 :0]  data_align_vfls_ext;        
wire    [3  :0]  data_shift;                 
wire             data_vld;                   
wire             dc_alias_hit;               
wire             dc_alias_hit_raw;           
wire    [1  :0]  dc_alias_idx;               
wire    [3  :0]  dc_alias_way;               
wire             dc_amo_inst;                
wire             dc_async_ld_inst;           
wire    [39 :0]  dc_async_mtval;             
wire             dc_async_vld;               
wire             dc_ca;                      
wire             dc_ca_after;                
wire             dc_cache_hit;               
wire             dc_cache_hit_raw;           
wire             dc_cache_miss;              
wire             dc_clk;                     
wire             dc_clk_en;                  
wire    [4  :0]  dc_da_amo_func;             
wire             dc_da_amo_inst;             
wire             dc_da_amo_no_wd;            
wire    [7  :0]  dc_da_bytes_vld;            
wire    [7  :0]  dc_da_bytes_vld_aft_mask;   
wire    [63 :0]  dc_da_data;                 
wire             dc_da_data_vld;             
wire             dc_da_data_vld_dp;          
wire    [5  :0]  dc_da_dest_reg;             
wire    [1  :0]  dc_da_element_size;         
wire             dc_da_expt_vld;             
wire             dc_da_fls;                  
wire             dc_da_lock;                 
wire             dc_da_merge_vld;            
wire    [1  :0]  dc_da_sew;                  
wire             dc_da_sign_ext;             
wire    [1  :0]  dc_da_size;                 
wire    [1  :0]  dc_da_stb_id;               
wire             dc_da_vec_nop;              
wire    [7  :0]  dc_da_vfunc;                
wire             dc_da_vl_update;            
wire    [6  :0]  dc_da_vl_val;               
wire             dc_da_vls;                  
wire             dc_da_vsplit_last;          
wire             dc_data_grant;              
wire    [2  :0]  dc_data_sel;                
wire             dc_dca_inst;                
wire             dc_dca_reply;               
wire             dc_dp_clk;                  
wire             dc_dp_clk_en;               
wire             dc_excl;                    
wire             dc_fwd_fpu;                 
wire             dc_fwd_lsu;                 
wire    [7  :0]  dc_hit_way;                 
wire    [3  :0]  dc_hit_way_group;           
wire             dc_inst_vld;                
wire             dc_ld_amo_inst;             
wire    [63 :0]  dc_ld_data_from_dcache;     
wire             dc_ld_data_vld;             
wire             dc_ld_fwd_sel;              
wire             dc_ld_inst;                 
wire             dc_ld_reply;                
wire             dc_lm_pass;                 
wire             dc_lock_trans;              
wire             dc_lr_inst;                 
wire             dc_mb_clk;                  
wire             dc_mb_clk_en;               
wire             dc_mb_create_en;            
wire             dc_mb_data_vld;             
wire             dc_mb_first_data_vld;       
wire             dc_pfb_vld;                 
wire             dc_ptw_vld;                 
wire    [3  :0]  dc_rdata_shift;             
wire             dc_reply;                   
wire             dc_req_vld;                 
wire             dc_sc_data_sel;             
wire             dc_sc_data_vld;             
wire             dc_sc_inst;                 
wire    [63 :0]  dc_sc_rdata;                
wire             dc_so;                      
wire             dc_split_first;             
wire             dc_split_second;            
wire             dc_st_alct;                 
wire    [3  :0]  dc_st_data_shift;           
wire    [3  :0]  dc_st_data_shift_raw;       
wire             dc_st_dp_clk;               
wire             dc_st_dp_clk_en;            
wire             dc_st_fwd;                  
wire    [63 :0]  dc_st_fwd_data;             
wire             dc_st_fwd_vld;              
wire             dc_st_inst;                 
wire             dc_st_reply;                
wire    [4  :0]  dc_st_src2_reg;             
wire    [63 :0]  dc_st_wdata;                
wire             dc_st_wdata_ready;          
wire             dc_stage_pipedown;          
wire             dc_stage_vld;               
wire    [3  :0]  dc_tag_hit;                 
wire             dc_vec_nop;                 
wire             dc_vfls;                    
wire             dc_wakeup;                  
wire             dc_wakeup_imm;              
wire    [63 :0]  dc_way0_data_dout;          
wire    [63 :0]  dc_way1_data_dout;          
wire    [63 :0]  dc_way2_data_dout;          
wire    [63 :0]  dc_way3_data_dout;          
wire             dc_wdata_vld_final;         
wire             dcache_acc_ca;              
wire    [27 :0]  dcache_acc_tag;             
wire    [1  :0]  dcache_acc_virt_idx;        
wire             dcache_wa;                  
wire    [5  :0]  dest_reg;                   
wire    [1  :0]  element_size;               
wire             expt_clk;                   
wire             expt_clk_en;                
wire             expt_vld;                   
wire             fls;                        
wire             hpcp_clk;                   
wire             hpcp_clk_en;                
wire             lfb_data_sel;               
wire             lfb_vfls;                   
wire             lock;                       
wire    [63 :0]  mb_bytes_vld_ext;           
wire             mb_dc_rdata_ready;          
wire             mb_dc_ready;                
wire             mb_pop_en;                  
wire    [3  :0]  rdl_icc_acc_fifo;           
wire    [1  :0]  rdl_icc_acc_idx;            
wire    [1  :0]  sew;                        
wire             sign_ext;                   
wire    [1  :0]  size;                       
wire             split_second;               
wire    [1  :0]  stb_id;                     
wire             vec_nop;                    
wire             vfls;                       
wire    [7  :0]  vfunc;                      
wire             vl_update;                  
wire    [6  :0]  vl_val;                     
wire             vls;                        
wire             vlsu_create_wdata_en;       
wire    [3  :0]  vlsu_fwd_data_shift;        
wire             vsplit_last;                
wire    [63 :0]  way0_data_dout;             
wire    [27 :0]  way0_tag;                   
wire             way0_tag_hit;               
wire             way0_tag_vld;               
wire    [63 :0]  way1_data_dout;             
wire    [27 :0]  way1_tag;                   
wire             way1_tag_hit;               
wire             way1_tag_vld;               
wire    [63 :0]  way2_data_dout;             
wire    [27 :0]  way2_tag;                   
wire             way2_tag_hit;               
wire             way2_tag_vld;               
wire    [63 :0]  way3_data_dout;             
wire    [27 :0]  way3_tag;                   
wire             way3_tag_hit;               
wire             way3_tag_vld;               
wire    [27 :0]  way4_tag;                   
wire             way4_tag_hit;               
wire             way4_tag_vld;               
wire    [27 :0]  way5_tag;                   
wire             way5_tag_hit;               
wire             way5_tag_vld;               
wire    [27 :0]  way6_tag;                   
wire             way6_tag_hit;               
wire             way6_tag_vld;               
wire    [27 :0]  way7_tag;                   
wire             way7_tag_hit;               
wire             way7_tag_vld;               


parameter PADDR = 40;
parameter D_TAG_TAG_LEN = `D_TAG_TAG_WIDTH;

parameter BYTE  = 2'b00;
parameter HALF  = 2'b01;
parameter WORD  = 2'b10;
parameter DWORD = 2'b11;

//==============================================================================
//   Interface to DCACHE
//==============================================================================
assign way0_data_dout[`LSU_DATAW-1:0] = dcache_data_dout_bank0[`LSU_DATAW-1:0];
assign way1_data_dout[`LSU_DATAW-1:0] = dcache_data_dout_bank1[`LSU_DATAW-1:0];
assign way2_data_dout[`LSU_DATAW-1:0] = dcache_data_dout_bank2[`LSU_DATAW-1:0];
assign way3_data_dout[`LSU_DATAW-1:0] = dcache_data_dout_bank3[`LSU_DATAW-1:0];

assign way0_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank0[D_TAG_TAG_LEN-1:0];
assign way1_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank0[30+D_TAG_TAG_LEN-1:30];
assign way2_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank0[60+D_TAG_TAG_LEN-1:60];
assign way3_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank0[90+D_TAG_TAG_LEN-1:90];
assign way4_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank1[D_TAG_TAG_LEN-1:0];
assign way5_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank1[30+D_TAG_TAG_LEN-1:30];
assign way6_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank1[60+D_TAG_TAG_LEN-1:60];
assign way7_tag[D_TAG_TAG_LEN-1:0] = dcache_tag_dout_bank1[90+D_TAG_TAG_LEN-1:90];

assign way0_tag_vld = dcache_tag_dout_bank0[29];
assign way1_tag_vld = dcache_tag_dout_bank0[59];
assign way2_tag_vld = dcache_tag_dout_bank0[89];
assign way3_tag_vld = dcache_tag_dout_bank0[119];
assign way4_tag_vld = dcache_tag_dout_bank1[29];
assign way5_tag_vld = dcache_tag_dout_bank1[59];
assign way6_tag_vld = dcache_tag_dout_bank1[89];
assign way7_tag_vld = dcache_tag_dout_bank1[119];

// &Force("bus","rdl_dc_acc_tag",PADDR-1,0); @99

assign dcache_acc_tag[D_TAG_TAG_LEN-1:0] = dc_req_vld ? dc_pa[39:40-D_TAG_TAG_LEN] : rdl_dc_acc_tag[39:40-D_TAG_TAG_LEN];
assign dcache_acc_virt_idx[1:0]          = dc_req_vld ? dc_virt_idx[1:0]           : rdl_dc_acc_idx[1:0];
assign dcache_acc_ca                     = dc_req_vld ? dc_ca                      : 1'b1;

assign way0_tag_hit = (way0_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way0_tag_vld & dcache_acc_ca;
assign way1_tag_hit = (way1_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way1_tag_vld & dcache_acc_ca;
assign way2_tag_hit = (way2_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way2_tag_vld & dcache_acc_ca;
assign way3_tag_hit = (way3_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way3_tag_vld & dcache_acc_ca;

assign way4_tag_hit = (way4_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way4_tag_vld & dcache_acc_ca;
assign way5_tag_hit = (way5_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way5_tag_vld & dcache_acc_ca;
assign way6_tag_hit = (way6_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way6_tag_vld & dcache_acc_ca;
assign way7_tag_hit = (way7_tag[D_TAG_TAG_LEN-1:0] == dcache_acc_tag[D_TAG_TAG_LEN-1:0]) & way7_tag_vld & dcache_acc_ca;


assign dc_hit_way[7:0] = {way7_tag_hit,way6_tag_hit,way5_tag_hit,way4_tag_hit,
                          way3_tag_hit,way2_tag_hit,way1_tag_hit,way0_tag_hit};

assign dc_tag_hit[3:0] = dc_virt_idx[0] ? dc_hit_way[7:4] : dc_hit_way[3:0];

assign dc_hit_way_group[0] = |dc_hit_way[3:0];
assign dc_hit_way_group[1] = |dc_hit_way[7:4];
assign dc_hit_way_group[2] = 1'b0;
assign dc_hit_way_group[3] = 1'b0;

assign dc_alias_way[3:0] = {4{dc_hit_way_group[1]}} & dc_hit_way[7:4] |
                           {4{dc_hit_way_group[0]}} & dc_hit_way[3:0];

assign dc_cache_hit_raw = |(dc_hit_way_group[1:0] &  (2'b1 << dcache_acc_virt_idx[0]));
assign dc_alias_hit_raw = |(dc_hit_way_group[1:0] & ~(2'b1 << dcache_acc_virt_idx[0]));

// &CombBeg; @149
always @( way6_tag[27:0]
       or way0_tag[27:0]
       or way1_tag_vld
       or way6_tag_vld
       or rdl_icc_acc_fifo[3:0]
       or way4_tag[27:0]
       or way5_tag[27:0]
       or way4_tag_vld
       or way2_tag[27:0]
       or way2_tag_vld
       or way7_tag_vld
       or way3_tag[27:0]
       or way1_tag[27:0]
       or way0_tag_vld
       or way7_tag[27:0]
       or way3_tag_vld
       or way5_tag_vld
       or rdl_icc_acc_idx[0])
begin
  case({rdl_icc_acc_idx[0],rdl_icc_acc_fifo[3:0]})
    5'b00001: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way0_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way0_tag_vld; end 
    5'b00010: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way1_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way1_tag_vld; end
    5'b00100: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way2_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way2_tag_vld; end
    5'b01000: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way3_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way3_tag_vld; end
    5'b10001: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way4_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way4_tag_vld; end
    5'b10010: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way5_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way5_tag_vld; end
    5'b10100: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way6_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way6_tag_vld; end
    5'b11000: begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = way7_tag[D_TAG_TAG_LEN-1:0]; dc_xx_dcache_vld = way7_tag_vld; end
    default : begin dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0] = {D_TAG_TAG_LEN{1'b0}};       dc_xx_dcache_vld = 1'b0;         end
  endcase
// &CombEnd; @161
end
// &CombBeg; @186
// &CombEnd; @206
// &CombBeg; @223
// &CombEnd; @231

assign dc_cache_hit     = dc_cache_hit_raw & cp0_lsu_dcache_en;
assign dc_alias_hit     = dc_alias_hit_raw & cp0_lsu_dcache_en;

// &Force("bus","rdl_dc_acc_idx",1,0); @238
assign dc_cache_miss     = !dc_cache_hit;
assign dc_alias_idx[1:0] = {dc_hit_way_group[3] | dc_hit_way_group[2],
                            dc_hit_way_group[3] | dc_hit_way_group[1]};

assign rdl_icc_acc_fifo[3:0] = {4{icc_dc_sel}} & icc_dc_acc_fifo[3:0] |
                               {4{rdl_dc_sel}} & rdl_dc_acc_fifo[3:0];
assign rdl_icc_acc_idx[1:0]  = {2{icc_dc_sel}} & icc_dc_acc_idx[1:0] |
                               {2{rdl_dc_sel}} & rdl_dc_acc_idx[1:0];

// &CombBeg; @248
always @( way1_data_dout[63:0]
       or rdl_icc_acc_fifo[3:0]
       or way3_data_dout[63:0]
       or way0_data_dout[63:0]
       or way2_data_dout[63:0])
begin
  case(rdl_icc_acc_fifo[3:0])
    4'b0001: dc_xx_dcache_data[127:0] = {way1_data_dout[63:0],way0_data_dout[63:0]};
    4'b0010: dc_xx_dcache_data[127:0] = {way0_data_dout[63:0],way1_data_dout[63:0]};
    4'b0100: dc_xx_dcache_data[127:0] = {way3_data_dout[63:0],way2_data_dout[63:0]};
    4'b1000: dc_xx_dcache_data[127:0] = {way2_data_dout[63:0],way3_data_dout[63:0]};
    default: dc_xx_dcache_data[127:0] = 128'bx;
  endcase
// &CombEnd; @263
end

// &Force("nonport","dcache_acc_virt_idx"); @265
// &Force("nonport","rdl_icc_acc_idx"); @266

//================================================
//  interface to ICC
//================================================
assign dc_icc_dcache_tag[D_TAG_TAG_LEN-1:0] = dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0];
assign dc_icc_dcache_tagvld      = dc_xx_dcache_vld;
assign dc_icc_dcache_dirty[3:0]  = dcache_dirty_dout[3:0];
assign dc_icc_dcache_data[127:0] = dc_xx_dcache_data[127:0];

//================================================
//  interface to RDL
//================================================
assign dc_rdl_dcache_vld         = dc_xx_dcache_vld;
assign dc_rdl_dcache_tag[D_TAG_TAG_LEN-1:0] = dc_xx_dcache_tag[D_TAG_TAG_LEN-1:0];
assign dc_rdl_dcache_fifo[3:0]   = dcache_dirty_dout[7:4];
assign dc_rdl_dcache_dirty[3:0]  = dcache_dirty_dout[3:0];
assign dc_rdl_dcache_data[127:0] = dc_xx_dcache_data[127:0];
assign dc_rdl_cache_hit          = dc_cache_hit_raw;
assign dc_rdl_alias_hit          = dc_alias_hit_raw;
assign dc_rdl_alias_idx[1:0]     = dc_alias_idx[1:0];
assign dc_rdl_alias_way[3:0]     = dc_alias_way[3:0];


//==============================================================================
//                    DC pipeline 
//==============================================================================
//================================================
//  ag and ptw arbiter
//================================================
// &Force("bus", "ag_dc_func",19,0); @296
// &Force("input", "ag_dc_sh"); @297
// &Force("input", "ag_dc_sec"); @298

assign ag_ptw_vld                       = mcic_dc_req | ag_dc_inst_vld;
assign ag_ptw_vld_dp                    = mcic_dc_req | ag_dc_inst_vld_dp;
assign ag_ptw_bytes_vld[`LSU_BYTEW-1:0] = mcic_dc_req ? mcic_dc_bytes_vld[`LSU_BYTEW-1:0] : ag_dc_bytes_vld[`LSU_BYTEW-1:0];
assign ag_ptw_func[19:0]                = mcic_dc_req ? 20'h10602 : ag_dc_func[19:0];
assign ag_ptw_amo_func[4:0]             = mcic_dc_req ? 5'b0  : ag_dc_amo_func[4:0];
assign ag_ptw_attr[2:0]                 = mcic_dc_req ? 3'b101 : {ag_dc_buf,ag_dc_so,ag_dc_ca};
assign ag_ptw_pa[PADDR-1:0]             = mcic_dc_req ? mcic_dc_addr[PADDR-1:0] : ag_dc_addr[PADDR-1:0];
assign ag_ptw_virt_idx[1:0]             = mcic_dc_req ? mcic_dc_addr[13:12] : ag_dc_virt_idx[1:0];
assign ag_ptw_dest_reg[5:0]             = mcic_dc_req ? 6'b0 : ag_dc_dest_reg[5:0];
assign ag_ptw_split                     = mcic_dc_req ? 1'b0 : ag_dc_unalign;
assign ag_ptw_split_last                = mcic_dc_req ? 1'b1 : ag_dc_unalign_last;
assign ag_ptw_expt_vld                  = mcic_dc_req ? 1'b0 : ag_dc_expt_vld;
assign ag_ptw_data_shift[3:0]           = mcic_dc_req ? 4'b0000 : ag_dc_data_shift[3:0];
assign ag_ptw_inst_pc[15:0]             = mcic_dc_req ? 16'b0: ag_dc_inst_pc[15:0];
assign ag_ptw_priv_mode[1:0]            = mcic_dc_req ? mcic_dc_priv_mode[1:0] : ag_dc_priv_mode[1:0];
assign ag_ptw_pf_amr_mask               = mcic_dc_req ? 1'b0 : ag_dc_pf_amr_mask;

//================================================
//  DC FSM
//================================================
parameter IDLE  = 2'b00;
parameter DCS   = 2'b01;
parameter FRZ   = 2'b10;
parameter REPLY = 2'b11;

always@(posedge dc_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dc_cur_state[1:0] <= IDLE;
  else if (rtu_yy_xx_async_flush)
    dc_cur_state[1:0] <= IDLE;
  else
    dc_cur_state[1:0] <= dc_next_state[1:0];
end

// &CombBeg; @344
always @( ag_ptw_vld
       or dc_wakeup
       or dc_reply
       or arb_dc_grant
       or dc_cur_state)
begin
  case(dc_cur_state)
  IDLE: begin
    if (ag_ptw_vld)
      dc_next_state = DCS;
    else
      dc_next_state = IDLE;
  end
  DCS: begin
    if (dc_reply & dc_wakeup)
      dc_next_state = REPLY;
    else if (dc_reply)
      dc_next_state = FRZ;
    else if (!ag_ptw_vld)
      dc_next_state = IDLE;
    else
      dc_next_state = DCS;
  end
  FRZ: begin
    if (dc_wakeup)
      dc_next_state = REPLY;
    else
      dc_next_state = FRZ;
  end
  REPLY: begin
    if (arb_dc_grant)
      dc_next_state = DCS;
    else
      dc_next_state = REPLY;
  end
  default: dc_next_state= IDLE;
  endcase
// &CombEnd; @376
end

assign dc_req_vld  = dc_cur_state == DCS;
assign dc_inst_vld = dc_req_vld & !dc_ptw;
assign dc_ptw_vld  = dc_req_vld &  dc_ptw;

assign dc_stage_vld = !(dc_cur_state == IDLE);
                     
assign dc_stage_pipedown = (dc_cur_state == IDLE) |
                           (dc_cur_state == DCS) & !dc_reply;

assign dc_ag_stall = (dc_cur_state == DCS) & dc_reply |
                     (dc_cur_state == FRZ) |
                     (dc_cur_state == REPLY);

assign dc_xx_dcache_req_mask = (dc_cur_state == FRZ);

assign dc_xx_no_op = dc_cur_state == IDLE;

//================================================
//  DC datapath
//================================================
parameter ST     = 0;
parameter SIGN   = 1;
parameter SIZE_0 = 9;
parameter SIZE_1 = 10;
parameter FFLS   = 12;
parameter FVLS   = 13;

assign ag_dc_create_vld = dc_stage_pipedown & ag_ptw_vld_dp;

assign ag_st_inst       = (ag_ptw_func[16] && !ag_ptw_func[12] && ag_ptw_func[0]) 
                         | ((ag_ptw_func[19:12] == 8'b0001_0001) && ag_ptw_func[8])
                         | ((ag_ptw_func[19:12] == 8'b0001_0001) && !ag_ptw_func[8] 
                            && !ag_ptw_func[7]);

assign ag_vfls          =  (ag_ptw_func[19:12] == 8'b0001_0100)  // vector
                         | (ag_ptw_func[19:12] == 8'b0001_0010); // float

assign ag_vls           =  (ag_ptw_func[19:12] == 8'b0001_0100); // vector

always@(posedge dc_dp_clk)
begin
  if (ag_dc_create_vld | ifu_lsu_warm_up) begin
    dc_ptw                    <= mcic_dc_req;
    dc_pa[PADDR-1:0]          <= ag_ptw_pa[PADDR-1:0];
    dc_virt_idx[1:0]          <= ag_ptw_virt_idx[1:0];
    dc_func[19:0]             <= ag_ptw_func[19:0];
    dc_amo_func[4:0]          <= ag_ptw_amo_func[4:0];
    dc_sign_ext               <= ag_ptw_func[SIGN];
    dc_dca_type[1:0]          <= ag_ptw_func[2:1];
    dc_fls                    <= (ag_ptw_func[19:12] == 8'b0001_0010);
    dc_vls                    <= (ag_ptw_func[19:12] == 8'b0001_0100);
    dc_size[1:0]              <= ag_ptw_func[SIZE_1:SIZE_0];
    dc_hint_size[4:0]         <= ag_dc_hint_size[4:0];
    dc_ele_size[1:0]          <= ag_ptw_func[SIZE_1:SIZE_0];
    dc_dest_reg[5:0]          <= ag_ptw_dest_reg[5:0];
    dc_attr[2:0]              <= ag_ptw_attr[2:0]; 
    dc_bytes_vld[`LSU_BYTEW-1:0] <= ag_ptw_bytes_vld[`LSU_BYTEW-1:0];
    dc_data_shift[3:0]        <= ag_ptw_data_shift[3:0];
    dc_split                  <= ag_ptw_split;
    dc_split_last             <= ag_ptw_split_last;
    dc_expt_vld               <= ag_ptw_expt_vld;
    dc_ld_pc[15:0]            <= ag_ptw_inst_pc[15:0];
    dc_priv_mode[1:0]         <= ag_ptw_priv_mode[1:0];
    dc_pf_amr_mask            <= ag_ptw_pf_amr_mask;
  end
end

assign dc_vfls         = dc_vls | dc_fls;
assign dc_excl         = dc_func[2:1] == 2'b10;
assign dc_ld_inst      = dc_func[16] && !dc_func[12] && !dc_func[0];
assign dc_st_inst      = (dc_func[16] && !dc_func[12] && dc_func[0]) 
                          | dc_amo_inst 
                          | dc_sc_inst;
assign dc_lr_inst      = (dc_func[19:12] == 8'b0001_0001) && !dc_func[8] &&  dc_func[7];
assign dc_sc_inst      = (dc_func[19:12] == 8'b0001_0001) && !dc_func[8] && !dc_func[7];
assign dc_amo_inst     = (dc_func[19:12] == 8'b0001_0001) && dc_func[8];
assign dc_lock_trans   = (dc_func[19:12] == 8'b0001_0001); // atomic inst
assign dc_dca_inst     = dc_func[16] && !dc_func[12] && dc_func[8];
assign dc_ld_amo_inst  = dc_ld_inst | dc_amo_inst | dc_lr_inst;

assign dc_ca           = dc_attr[0];
assign dc_so           = dc_attr[1];
assign dc_split_first  = dc_split & !dc_split_last;
assign dc_split_second = dc_split & dc_split_last;
assign dc_ca_after     = dc_ca & cp0_lsu_dcache_en;
assign dc_st_alct      = dc_ca_after & dcache_wa;
assign dcache_wa       = cp0_lsu_dcache_wa & !amr_dc_wa_dis;

//================================================
//  DC store data 
//================================================
assign ag_vls_create_vld = ag_dc_create_vld & ag_vls;

always@(posedge dc_dp_clk)
begin
  if (ag_vls_create_vld | ifu_lsu_warm_up) begin
    dc_vfunc[7:0]               <= ag_ptw_func[19:12];
    dc_sew[1:0]                 <= ag_dc_sew[1:0];
    dc_vls_nop                  <= ag_dc_vec_nop;
    dc_wdata_shift[3:0]         <= ag_dc_vlsu_wdata_shift[3:0];
    dc_vsplit_cnt[9:0]          <= ag_dc_vlsu_split_cnt[9:0];
    dc_sseg_first               <= ag_dc_vlsu_sseg_first;
    dc_vl_update                <= ag_dc_vlsu_vl_update;
    dc_vl_val[6:0]              <= ag_dc_vlsu_vl_upval[6:0];
    dc_vsplit_last              <= ag_dc_vlsu_split_last;
  end
end

assign dc_vec_nop = dc_vls & dc_vls_nop;

assign ag_dc_st_create_vld = ag_dc_create_vld & ag_st_inst;

assign vlsu_create_wdata_en = dc_stage_vld & dc_vfls & 
                             !dc_wdata_vld &
                              vlsu_lsu_data_vld;

always@(posedge dc_st_dp_clk)
begin
  if (ag_dc_st_create_vld | ifu_lsu_warm_up)
    dc_src2_reg[5:0] <= ag_dc_src2_reg[5:0];
  else if (vlsu_create_wdata_en)
    dc_src2_reg[5:0] <= {1'b0,vlsu_lsu_src2_reg[4:0]};
end

assign ag_dc_st_create_data[`LSU_DATAW-1:0] = ag_dc_st_data[63:0]; 

always@(posedge dc_st_dp_clk)
begin
  if (ag_dc_st_create_vld | ifu_lsu_warm_up)
    dc_st_data_reg[`LSU_DATAW-1:0] <= ag_dc_st_create_data[`LSU_DATAW-1:0];
  else if (vlsu_create_wdata_en)
    dc_st_data_reg[`LSU_DATAW-1:0] <= vlsu_lsu_wdata[`LSU_DATAW-1:0];
  else if (dc_stage_vld & dc_st_fwd_vld)
    dc_st_data_reg[`LSU_DATAW-1:0] <= dc_st_fwd_data[`LSU_DATAW-1:0];
end

always@(posedge dc_st_dp_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dc_src2_depd <= 1'b0;
  else if (ag_dc_st_create_vld)
    dc_src2_depd <= ag_vfls | ag_dc_src2_depd;
  else if (vlsu_create_wdata_en)
    dc_src2_depd <= vlsu_lsu_src2_depd;
  else if (dc_stage_vld & dc_st_fwd_vld)
    dc_src2_depd <= 1'b0;
end

always@(posedge dc_st_dp_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dc_wdata_vld <= 1'b0;
  else if (ag_dc_st_create_vld)
    dc_wdata_vld <= !ag_vfls;
  else if (vlsu_create_wdata_en) 
    dc_wdata_vld <= 1'b1;
end

always@(posedge dc_st_dp_clk)
begin
  if (vlsu_create_wdata_en | ifu_lsu_warm_up)
    dc_vlsu_data_shift[3:0] <= vlsu_lsu_data_shift[3:0];
end

assign dc_wdata_vld_final          = dc_wdata_vld | vlsu_create_wdata_en;

assign dc_st_wdata_ready           = !dc_src2_depd | vlsu_create_wdata_en & !vlsu_lsu_src2_depd | dc_st_fwd_vld;
assign dc_st_wdata[`LSU_DATAW-1:0] = dc_st_fwd_vld 
                                     ? dc_st_fwd_data[`LSU_DATAW-1:0] 
                                     : vlsu_create_wdata_en ? vlsu_lsu_wdata[`LSU_DATAW-1:0] 
                                                            : dc_st_data_reg[`LSU_DATAW-1:0];
assign dc_st_src2_reg[4:0] = vlsu_create_wdata_en ? vlsu_lsu_src2_reg[4:0] 
                                                  : dc_src2_reg[4:0];

//for timing,vector flop data shift from vlsu and merge it with addr_shift
assign vlsu_fwd_data_shift[3:0] = dc_wdata_vld
                                  ? dc_vlsu_data_shift[3:0]
                                  : vlsu_lsu_data_shift[3:0];

//================================================
//  store data forwarding
//================================================

assign dc_fwd_lsu    = da_xx_fwd_vld & !dc_vfls &
                      (dc_src2_reg[5:0] == da_xx_fwd_dst_reg[5:0]);
assign dc_fwd_fpu    = vlsu_lsu_fwd_vld & dc_fls & dc_wdata_vld &
                      (dc_src2_reg[4:0] == vlsu_lsu_fwd_dest_reg[4:0]);

assign dc_st_fwd     = dc_fwd_fpu | dc_fwd_lsu;
assign dc_st_fwd_vld = dc_src2_depd & dc_st_fwd;

assign dc_st_fwd_data[`LSU_DATAW-1:0] = dc_fwd_lsu
                                      ? da_dc_fwd_data[`LSU_DATAW-1:0]
                                      : vlsu_lsu_fwd_data[`LSU_DATAW-1:0];

assign dc_data_grant             = dc_stage_vld & dc_st_inst & dc_vfls & 
                                  !dc_wdata_vld & (!dc_split | dc_split_last);

//amo and fls should keep original st data,not data shrinked
assign lsu_vlsu_data_grant        = dc_data_grant;
assign lsu_vlsu_st_offset[3:0]    = dc_fls ? 4'b0000 : dc_wdata_shift[3:0];
assign lsu_vlsu_st_size[1:0]      = dc_ele_size[1:0];
assign lsu_vlsu_st_sew[1:0]       = (dc_fls | dc_amo_inst) ? dc_ele_size[1:0] : dc_sew[1:0];
assign lsu_vlsu_st_expt           = dc_expt_vld;

assign lsu_vlsu_dc_create_vld     = dc_inst_vld & dc_vls & dc_ld_inst;
assign lsu_vlsu_dc_nf[2:0]        = dc_vfunc[6:4];
assign lsu_vlsu_dc_sew[1:0]       = dc_sew[1:0];
assign lsu_vlsu_dc_fof            = dc_vfunc[2];
assign lsu_vlsu_dc_split_cnt[9:0] = dc_vfunc[6] || dc_expt_vld
                                    ? dc_vsplit_cnt[9:0]
                                    : {dc_vsplit_cnt[9:3],3'b0};
assign lsu_vlsu_dc_sseg_first     = dc_sseg_first;

// &Force("output","dc_ag_stall"); @599
assign lsu_vlsu_dc_fld_req  = dc_inst_vld & dc_fls & dc_ld_inst;
assign lsu_vlsu_dc_stall    = dc_ag_stall | dc_split & !dc_split_last;
assign lsu_vlsu_st_stall    = (!ag_ptw_vld | lsu_vlsu_dc_stall) & ~(dc_fls & dc_st_inst);
//================================================
//   local monitor
//================================================
assign lm_req_addr[PADDR-1:0] = dc_pa[PADDR-1:0];
assign lm_req_size[1:0]       = dc_size[1:0];
assign lm_set                 = dc_inst_vld & dc_lr_inst & !dc_ld_reply;
assign lm_set_gate            = dc_inst_vld & dc_lr_inst;
assign lm_clr                 = dc_inst_vld & (dc_sc_inst | dc_amo_inst) & !dc_reply;
assign dc_lm_pass             = lm_pass;

//================================================
//   dcache request
//================================================

assign dc_arb_tag_req         = dc_cur_state == REPLY;
assign dc_arb_tag_sel[3:0]    = 4'b1111;
assign dc_arb_tag_way[3:0]    = 4'b1111;
assign dc_arb_tag_idx[11:0]   = dc_pa[11:0];

assign dc_arb_data_req        = dc_cur_state == REPLY;
assign dc_arb_data_way[3:0]   = 4'b1111;
assign dc_arb_data_idx[13:0]  = {dc_virt_idx[1:0], dc_pa[11:0]};

//================================================
//   reply
//================================================
//--------------------------------------
//  ld_reply
//--------------------------------------
// 1.create_lfb: cache_miss
//  a) lfb_full
//  b) lfb_hit_idx
//  c) stb_hit_idx
//  d) stb_multi_part_hit
// 2.cache hit (may turn to cache miss if rdl)
//  a) stb_multi_part_hit
//  b) lfb_hit_preg for int, lfb_uncmplt_vld for vls
// 3.dc_data_vld which can return data (may turn to cache miss if rdl)
//  a) lfb_dc_data_vld
// 4.split
//  a) first, mb_not_grant
//  b) second, mb_data_not_ready
// 5.SO 
//  a) lfb or stb has so reqeust
// 6.AMO_LD or LR
//  a) lfb or stb hit idx 
// 7.FVLS
//  a) FVLSU has no enough buffer
// 8.hit stb_dca
assign dc_ld_reply = dc_cache_miss & (lfb_dc_full | lfb_dc_hit_idx | stb_dc_hit_idx | vb_dc_hit_idx) |
                     stb_dc_multi_or_part_hit | stb_dc_hit_not_ready |                 
                     !dc_vls & lfb_dc_hit_preg | 
                     (dc_cache_hit | dc_expt_vld | dc_vec_nop) & dc_vls & lfb_dc_uncmplt_vreg |
                     (dc_cache_hit | dc_expt_vld | dc_vec_nop) & lfb_dc_data_vld |
                     stb_dc_hit_dca |
                     dc_split_first & !mb_dc_ready | dc_split_second & !mb_dc_rdata_ready |
                     dc_so & (lfb_dc_so_vld | stb_dc_so_vld) |
                     dc_lock_trans & (lfb_dc_hit_idx | stb_dc_hit_idx) |
                     dc_vfls & vlsu_buf_stall;


//--------------------------------------
//  st_reply
//--------------------------------------
// 1. st data not ready
// 2. create LFB and create STB at the same time: WA cache miss
//  a) lfb_full
//  b) lfb_hit_idx (for reduce memcpy st_hit_lfb_idx, for store which is cache_miss & no
//  need to create lfb, it check lfb_dc_hit_addr, to avoid miss state
//  changed to hit)
//  c) stb_hit_idx
//  d) vb_hit_idx
//  e) stb can not merge & stb_full
// 3. only create STB 
//  a) stb can not merge & stb_full
//  b) lfb_hit_idx
//  c) vb_hit_idx
// 4. SO 
//  a) lfb or stb has so reqeust
// 5. AMO_ST or SC
//  a) lfb or stb hit idx 
// 6. hit stb_dca
// 7. SC 
//  a)lfb_data_vld
assign dc_st_reply = !dc_wdata_vld_final |
                     !dc_fls & !dc_st_wdata_ready |
                     !stb_dc_ready | 
                      dc_cache_miss & (dc_st_alct | dc_alias_hit) & !stb_dc_merge_en & (lfb_dc_full | stb_dc_hit_idx | lfb_dc_hit_idx) |
                      dc_cache_miss & !(dc_st_alct | dc_alias_hit) & !stb_dc_merge_en & stb_dc_hit_addr  |
                      dc_cache_hit & (lfb_dc_hit_idx | stb_dc_hit_addr_wca) |
                      lfb_dc_hit_addr |   
                      vb_dc_hit_idx |
                      dc_sc_inst & (lfb_dc_data_vld | lfb_dc_hit_preg) |
                      stb_dc_hit_dca |
                      dc_so & (lfb_dc_so_vld | stb_dc_so_vld) |
                      dc_lock_trans & stb_dc_hit_idx;


//--------------------------------------
//  dcache_reply
//--------------------------------------
// 1.create STB
//  a) stb_full
//  b) stb hit idx
//  c) lfb_hit idx: for lfb replace line is dca hit line
// 2.not create STB
//  a) lfb hit idx
assign dc_dca_reply = !(dc_cache_hit_raw | dc_alias_hit_raw) & lfb_dc_hit_idx |
                       (dc_cache_hit_raw | dc_alias_hit_raw) & (!stb_dc_ready | stb_dc_hit_idx | lfb_dc_hit_idx);

assign dc_reply = dc_ld_amo_inst & dc_ld_reply |
                  dc_st_inst & dc_st_reply |
                  dc_dca_inst & dc_dca_reply;

//================================================
//  dc_wakeup
//================================================
assign dc_wakeup = lfb_dc_data_vld | 
                   lfb_dc_pop_en |
                   stb_dc_pop_en |
                   stb_dc_fwd_vld |
                   vb_dc_pop_en | 
                   dc_wakeup_imm;

assign dc_wakeup_imm = dc_st_inst & !dc_st_wdata_ready |
                       dc_ld_inst & dc_vfls & vlsu_buf_stall;
                   
//================================================
//  dc_data_vld
//================================================
assign dc_ld_data_vld = dc_inst_vld & dc_ld_amo_inst & (dc_cache_hit | dc_expt_vld | dc_vec_nop) & !dc_reply;
assign dc_sc_data_vld = dc_inst_vld & dc_sc_inst & !dc_st_reply;


//================================================
//  LFB create
//================================================
// 1.ld cache miss
// 2.st cache miss in alct_mode
// &Force("output","dc_lfb_create_en"); @748
assign dc_lfb_create_en = dc_req_vld & !dc_expt_vld & !dc_vec_nop &
                         !dc_reply &
                          dc_cache_miss &
                         (dc_ld_amo_inst | 
                         (dc_st_inst & !dc_sc_inst | 
                          dc_sc_inst & dc_lm_pass) & (dc_st_alct | dc_alias_hit) & !stb_dc_merge_en);

assign dc_lfb_create_en_gate = dc_req_vld & !dc_expt_vld & !dc_vec_nop &
                               dc_cache_miss &
                              (dc_ld_amo_inst | 
                              (dc_st_inst & !dc_sc_inst | 
                               dc_sc_inst & dc_lm_pass) & (dc_st_alct | dc_alias_hit) & !stb_dc_merge_en);

assign dc_lfb_pa[PADDR-1:0]  = dc_pa[PADDR-1:0];
assign dc_lfb_virt_idx[1:0]  = dc_virt_idx[1:0];
assign dc_lfb_size[1:0]      = dc_size[1:0];
assign dc_lfb_ele_size[1:0]  = dc_ele_size[1:0];
assign dc_lfb_sew[1:0]       = dc_sew[1:0];
assign dc_lfb_sign_ext       = dc_sign_ext;
assign dc_lfb_dest_reg[5:0]  = dc_dest_reg[5:0];
assign dc_lfb_attr[2:0]      = dc_attr[2:0];
assign dc_lfb_ca             = dc_ca_after;
assign dc_lfb_vls            = dc_vls;
assign dc_lfb_fls            = dc_fls;
assign dc_lfb_lock           = dc_lock_trans;
assign dc_lfb_vfunc[7:0]     = dc_vfunc[7:0];
assign dc_lfb_ptw            = dc_ptw;
assign dc_lfb_split          = dc_split;
assign dc_lfb_split_last     = dc_split_last;
assign dc_lfb_inst_ld        = dc_ld_amo_inst;
assign dc_lfb_st_id[1:0]     = stb_dc_create_id[1:0];
assign dc_lfb_alias_hit      = dc_alias_hit;
assign dc_lfb_alias_idx[1:0] = dc_alias_idx[1:0];
assign dc_lfb_bytes_vld[`LSU_BYTEW-1:0]= dc_bytes_vld[`LSU_BYTEW-1:0];
assign dc_lfb_shift[3:0]     = dc_rdata_shift[3:0];
assign dc_lfb_hit_way[3:0]   = dc_alias_way[3:0];
assign dc_lfb_vl_val[6:0]    = dc_vl_val[6:0];
assign dc_lfb_vsplit_last    = dc_vsplit_last;
assign dc_lfb_priv_mode[1:0] = dc_priv_mode[1:0];
assign dc_lfb_amo_inst       = dc_amo_inst;
assign dc_lfb_amo_func[4:0]  = dc_amo_func[4:0];

//================================================
//  STB create
//================================================
// &Force("output","dc_stb_req_gate"); @794

assign dc_stb_req = dc_req_vld & !dc_reply & !dc_expt_vld & !dc_vec_nop &
                   (dc_st_inst  & !dc_sc_inst | 
                    dc_sc_inst  & dc_lm_pass |
                    dc_dca_inst & (dc_cache_hit_raw | dc_alias_hit_raw));

assign dc_stb_req_gate = dc_req_vld & !dc_expt_vld & !dc_vec_nop &
                        (dc_st_inst & !dc_sc_inst | 
                         dc_sc_inst & dc_lm_pass |
                         dc_dca_inst);

assign dc_stb_dca_inst                   = dc_dca_inst;
assign dc_stb_wait_lfb                   = (dc_st_alct | dc_alias_hit | dc_amo_inst & dc_ca_after) & !dc_cache_hit;
assign dc_stb_cache_hit                  = dc_cache_hit;
assign dc_stb_hit_way[3:0]               = dc_cache_hit_raw ? dc_tag_hit[3:0] : dc_alias_way[3:0];
assign dc_stb_alias_idx[1:0]             = dc_alias_idx[1:0];
assign dc_stb_virt_idx[1:0]              = dc_virt_idx[1:0];
assign dc_stb_lock                       = dc_lock_trans;
assign dc_stb_alct                       = dc_st_alct;
assign dc_stb_pa[PADDR-1:0]              = dc_pa[PADDR-1:0];
assign dc_stb_dca_type[1:0]              = dc_dca_type[1:0];
assign dc_stb_bytes_vld[`LSU_BYTEW-1:0]  = dc_bytes_vld[`LSU_BYTEW-1:0];
assign dc_stb_size[1:0]                  = dc_size[1:0];
assign dc_stb_attr[2:0]                  = dc_attr[2:0];
assign dc_stb_src2_depd                  = !dc_st_wdata_ready || dc_amo_inst;
assign dc_stb_src2_reg[4:0]              = dc_st_src2_reg[4:0];
assign dc_stb_data_shift[3:0]            = dc_data_shift[3:0];
assign dc_stb_priv_mode[1:0]             = dc_priv_mode[1:0];
assign dc_stb_amo_inst                   = dc_amo_inst;

//for amo,st data should not shift at this stage
assign dc_st_data_shift_raw[3:0] = dc_amo_inst
                                   ? 4'h0
                                   : dc_data_shift[3:0];

//for vector stdata timing,merge two shift here
assign dc_st_data_shift[3:0] = dc_vls 
                               ? dc_st_data_shift_raw[3:0] + vlsu_fwd_data_shift[3:0]
                               : dc_st_data_shift_raw[3:0];

// &CombBeg; @835
always @( dc_st_wdata[63:0]
       or dc_st_data_shift[2:0])
begin
  casez(dc_st_data_shift[2:0])
  3'b000 : dc_stb_data[63:0] =  dc_st_wdata[63:0];
  3'b001 : dc_stb_data[63:0] = {dc_st_wdata[55:0],dc_st_wdata[63:56]};
  3'b010 : dc_stb_data[63:0] = {dc_st_wdata[47:0],dc_st_wdata[63:48]};
  3'b011 : dc_stb_data[63:0] = {dc_st_wdata[39:0],dc_st_wdata[63:40]};
  3'b100 : dc_stb_data[63:0] = {dc_st_wdata[31:0],dc_st_wdata[63:32]};
  3'b101 : dc_stb_data[63:0] = {dc_st_wdata[23:0],dc_st_wdata[63:24]};
  3'b110 : dc_stb_data[63:0] = {dc_st_wdata[15:0],dc_st_wdata[63:16]};
  3'b111 : dc_stb_data[63:0] = {dc_st_wdata[7:0], dc_st_wdata[63:8]};
  default: dc_stb_data[63:0] =  dc_st_wdata[63:0];
  endcase
// &CombEnd; @869
end

//================================================
//  PFB request
//================================================
// &Force("bus","pfb_xx_pa",PADDR-1,0); @874

//for pfu/amr,use individual addr to check sequence
//unalign last will use original addr
always@(posedge dc_dp_clk)
begin
  if (ag_dc_create_vld & !mcic_dc_req & !ag_dc_unalign_last | ifu_lsu_warm_up)
  begin
    dc_pf_amr_pa[PADDR-1:0]  <= ag_dc_addr[PADDR-1:0];
    dc_pf_virt_idx[1:0]      <= ag_dc_virt_idx[1:0];
   end
end

assign dc_pfb_vld = dc_inst_vld & 
                   !dc_expt_vld & 
                   !dc_vec_nop & 
                   !dc_reply & 
                    dc_ld_inst & 
                   !dc_lock_trans & 
                    dc_ca_after;

assign dc_pfb_ld_vld  = dc_pfb_vld;

assign dc_pfb_ld_vld_gate = dc_inst_vld &
                           !dc_expt_vld & 
                           !dc_vec_nop & 
                            dc_ld_inst & 
                           !dc_lock_trans & 
                            dc_ca_after;

//for unalign inst,deliver both two split addr to pfu for cross 4k performance 
assign dc_pfb_ld_mask               = dc_pf_amr_mask;
assign dc_pfb_ld_miss               = !(dc_cache_hit | dc_alias_hit);
assign dc_pfb_ld_chk_pa[PADDR-1:0]  = dc_pf_amr_pa[PADDR-1:0];
assign dc_pfb_ld_chk_virt_idx[1:0]  = dc_pf_virt_idx[1:0];
assign dc_pfb_ld_init_pa[PADDR-1:0] = dc_pa[PADDR-1:0];
assign dc_pfb_ld_init_virt_idx[1:0] = dc_virt_idx[1:0];
assign dc_pfb_dca_vld               = dc_inst_vld & dc_dca_inst;
assign dc_pfb_ld_pc[15:0]           = dc_ld_pc[15:0];
assign dc_pfb_priv_mode[1:0]        = dc_priv_mode[1:0];

assign dc_pfb_hit_idx = pfb_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == dc_pa[`D_TAG_INDEX_WIDTH+6-1:6] & dc_ca_after & dc_stb_req_gate;

//================================================
//  AMR request
//================================================
assign dc_amr_st_req = dc_inst_vld & 
                      !dc_vec_nop & 
                      !dc_reply & 
                       dc_st_inst & 
                      !dc_lock_trans & 
                       dc_ca_after;
assign dc_amr_cancel = dc_inst_vld &
                      !dc_reply & 
                       dc_st_inst & 
                      (dc_lock_trans | !dc_ca_after);

assign dc_amr_st_req_gate = dc_inst_vld &
                           !dc_vec_nop & 
                            dc_st_inst & 
                           !dc_lock_trans & 
                            dc_ca_after;

assign dc_amr_st_mask            = dc_pf_amr_mask;
assign dc_amr_st_miss            = !(dc_cache_hit | dc_alias_hit);
assign dc_amr_st_size[4:0]       = dc_hint_size[4:0];
assign dc_amr_st_addr[PADDR-1:0] = dc_pf_amr_pa[PADDR-1:0];

//================================================
//  data mux
//================================================
assign dc_way0_data_dout[63:0] = dc_pa[3] ? way1_data_dout[63:0] : way0_data_dout[63:0];
assign dc_way1_data_dout[63:0] = dc_pa[3] ? way0_data_dout[63:0] : way1_data_dout[63:0];
assign dc_way2_data_dout[63:0] = dc_pa[3] ? way3_data_dout[63:0] : way2_data_dout[63:0];
assign dc_way3_data_dout[63:0] = dc_pa[3] ? way2_data_dout[63:0] : way3_data_dout[63:0];

assign dc_ld_data_from_dcache[`LSU_DATAW-1:0] = {`LSU_DATAW{dc_tag_hit[0] & dc_ld_amo_inst}} & dc_way0_data_dout[`LSU_DATAW-1:0] | 
                                                {`LSU_DATAW{dc_tag_hit[1] & dc_ld_amo_inst}} & dc_way1_data_dout[`LSU_DATAW-1:0] |
                                                {`LSU_DATAW{dc_tag_hit[2] & dc_ld_amo_inst}} & dc_way2_data_dout[`LSU_DATAW-1:0] | 
                                                {`LSU_DATAW{dc_tag_hit[3] & dc_ld_amo_inst}} & dc_way3_data_dout[`LSU_DATAW-1:0];

assign dc_sc_rdata[`LSU_DATAW-1:0] = dc_lm_pass ? {{(`LSU_DATAW-1){1'b0}}, 1'b1} : {`LSU_DATAW{1'b0}};

assign lfb_data_sel   = lfb_dc_data_vld;
assign dc_sc_data_sel = dc_inst_vld & dc_sc_inst;
assign dc_ld_fwd_sel  = dc_inst_vld & stb_dc_ld_fwd_vld;

assign dc_data_sel[2:0] =  {lfb_data_sel, dc_sc_data_sel, dc_ld_fwd_sel};

// &CombBeg; @970
always @( dc_data_sel[2:0]
       or stb_dc_ld_data[63:0]
       or dc_sc_rdata[63:0]
       or dc_ld_data_from_dcache[63:0]
       or lfb_dc_data[63:0])
begin
  casez(dc_data_sel[2:0])
    3'b1?? : dc_data[`LSU_DATAW-1:0] = lfb_dc_data[`LSU_DATAW-1:0];
    3'b01? : dc_data[`LSU_DATAW-1:0] = dc_sc_rdata[`LSU_DATAW-1:0];
    3'b001 : dc_data[`LSU_DATAW-1:0] = stb_dc_ld_data[`LSU_DATAW-1:0];
    default: dc_data[`LSU_DATAW-1:0] = dc_ld_data_from_dcache[`LSU_DATAW-1:0]; 
  endcase
// &CombEnd; @977
end
    


//================================================
//    int Misalign merge buffer
//================================================
assign dc_mb_create_en = dc_inst_vld & 
                         dc_ld_inst &
                        !dc_reply &
                        !dc_vls & 
                         dc_split_first;

assign dc_mb_data_vld = dc_ld_data_vld & !dc_vls & dc_split_second |
                        lfb_dc_data_vld & !lfb_dc_vls & lfb_dc_split_second;

assign mb_pop_en      = mb_vld & dc_mb_data_vld;

always@(posedge dc_mb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mb_vld <= 1'b0;
  else if (dc_mb_create_en)
    mb_vld <= 1'b1;
  else if (mb_pop_en)
    mb_vld <= 1'b0;
end

always@(posedge dc_mb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mb_data_vld <= 1'b0;
  else if (dc_mb_create_en)
    mb_data_vld <= dc_mb_first_data_vld;
  else if (dc_mb_first_data_vld)
    mb_data_vld <= 1'b1;
end

always@(posedge dc_mb_clk)
begin
  if (dc_mb_create_en | ifu_lsu_warm_up)
    mb_bytes_vld[7:0]  <= dc_bytes_vld[7:0];
end

assign dc_mb_first_data_vld  = dc_ld_data_vld & !dc_vls & dc_split_first |
                               lfb_dc_data_vld & !lfb_dc_vls & lfb_dc_split_first;

always@(posedge dc_mb_clk)
begin
  if (dc_mb_first_data_vld | ifu_lsu_warm_up) begin
    mb_data[63:0]   <= dc_data[63:0];
    mb_bus_err      <= lfb_dc_bus_err;
  end
end

assign mb_dc_ready       = !mb_vld;
assign mb_dc_rdata_ready =  mb_vld & mb_data_vld;

//================================================
// DATA ALIGN
//================================================
assign mb_bytes_vld_ext[63:0] = {{8{mb_bytes_vld[7]}},
                                 {8{mb_bytes_vld[6]}},
                                 {8{mb_bytes_vld[5]}},
                                 {8{mb_bytes_vld[4]}},
                                 {8{mb_bytes_vld[3]}},
                                 {8{mb_bytes_vld[2]}},
                                 {8{mb_bytes_vld[1]}},
                                 {8{mb_bytes_vld[0]}}} & {64{mb_vld & split_second}};
                                 

// &CombBeg; @1057
// &CombEnd; @1064
assign data[63:0]  = mb_bytes_vld_ext[63:0] & mb_data[63:0] |
                    ~mb_bytes_vld_ext[63:0] & dc_data[63:0];

assign split_second              = lfb_data_sel ? lfb_dc_split_second              : dc_split_second;
assign bytes_vld[`LSU_BYTEW-1:0] = lfb_data_sel ? lfb_dc_bytes_vld[`LSU_BYTEW-1:0] : dc_bytes_vld[`LSU_BYTEW-1:0];
assign sign_ext                  = lfb_data_sel ? lfb_dc_sign_ext                  : dc_sign_ext;
assign size[1:0]                 = lfb_data_sel ? lfb_dc_size[1:0]                 : dc_size[1:0];
assign dest_reg[5:0]             = lfb_data_sel ? lfb_dc_dest_reg[5:0]             : dc_dest_reg[5:0];
assign vls                       = lfb_data_sel ? lfb_dc_vls                       : dc_vls;
assign fls                       = lfb_data_sel ? lfb_dc_fls                       : dc_fls;
assign lock                      = lfb_data_sel ? lfb_dc_lock                      : dc_lock_trans;
assign vfunc[7:0]                = lfb_data_sel ? lfb_dc_vfunc[7:0]                : dc_vfunc[7:0];
assign element_size[1:0]         = lfb_data_sel ? lfb_dc_ele_size[1:0]             : dc_ele_size[1:0];
assign sew[1:0]                  = lfb_data_sel ? lfb_dc_sew[1:0]                  : dc_sew[1:0];
assign vl_update                 = lfb_data_sel ? lfb_dc_vl_update                 : dc_vl_update;
assign vl_val[6:0]               = lfb_data_sel ? lfb_dc_vl_val[6:0]               : dc_vl_val[6:0];
assign vsplit_last               = lfb_data_sel ? lfb_dc_vsplit_last               : dc_vsplit_last;
assign vec_nop                   = lfb_data_sel ? 1'b0                             : dc_vec_nop;
assign expt_vld                  = lfb_data_sel ? 1'b0                             : dc_expt_vld;
assign data_shift[3:0]           = lfb_data_sel ? lfb_dc_data_shift[3:0]           : dc_rdata_shift[3:0];
//assign ld_inst                   = lfb_data_sel ? lfb_dc_ld_inst                   : dc_ld_amo_inst;
assign amo_inst                  = lfb_data_sel ? lfb_dc_amo_inst                  : dc_amo_inst;
assign amo_func[4:0]             = lfb_data_sel ? lfb_dc_amo_func[4:0]             : dc_amo_func[4:0];
assign stb_id[1:0]               = lfb_data_sel ? lfb_dc_stb_id[1:0]               : stb_dc_create_id[1:0];
//assign pa[PADDR-1:0]             = lfb_data_sel ? lfb_dc_mtval[PADDR-1:0]          : dc_pa[PADDR-1:0];

assign vfls = vls | fls;
assign dc_rdata_shift[3:0] = dc_sc_inst ? 4'b0000 : dc_data_shift[3:0];

// &CombBeg; @1104
always @( data_shift[2:0]
       or data[63:0])
begin
  casez(data_shift[2:0])
  3'b000 : data_align[63:0] = data[63:0];
  3'b001 : data_align[63:0] = {data[7:0],data[63:8]};
  3'b010 : data_align[63:0] = {data[15:0],data[63:16]};
  3'b011 : data_align[63:0] = {data[23:0],data[63:24]};
  3'b100 : data_align[63:0] = {data[31:0],data[63:32]};
  3'b101 : data_align[63:0] = {data[39:0],data[63:40]};
  3'b110 : data_align[63:0] = {data[47:0],data[63:48]};
  3'b111 : data_align[63:0] = {data[55:0],data[63:56]};
  default: data_align[63:0] = data[63:0];
  endcase
// &CombEnd; @1151
end

// &CombBeg; @1153
always @( data_align[63:0]
       or size[1:0]
       or sign_ext)
begin
  case({sign_ext, size[1:0]})
  {1'b0,BYTE} : data_align_ext[63:0] = {56'b0,data_align[7:0]};
  {1'b0,HALF} : data_align_ext[63:0] = {48'b0,data_align[15:0]};
  {1'b0,WORD} : data_align_ext[63:0] = {32'b0,data_align[31:0]};
  {1'b1,BYTE} : data_align_ext[63:0] = {{56{data_align[7]}},data_align[7:0]};
  {1'b1,HALF} : data_align_ext[63:0] = {{48{data_align[15]}},data_align[15:0]};
  {1'b1,WORD} : data_align_ext[63:0] = {{32{data_align[31]}},data_align[31:0]};
  default     : data_align_ext[63:0] = data_align[63:0];
  endcase
// &CombEnd; @1188
end

//================================================
//  vlsu data prepare
//================================================
// &CombBeg; @1194
// &CombEnd; @1244
// &CombBeg; @1246
always @( element_size[1:0]
       or data_align[63:0]
       or sew[1:0]
       or sign_ext)
begin
  case({element_size[1:0],sew[1:0],sign_ext})
  {BYTE,HALF,1'b0} : data_align_vls_ext[63:0] = {{8'b0,data_align[31:24]},
                                                 {8'b0,data_align[23:16]},
                                                 {8'b0,data_align[15:8]},
                                                 {8'b0,data_align[7:0]}};
  {BYTE,HALF,1'b1} : data_align_vls_ext[63:0] = {{{8{data_align[31]}},data_align[31:24]},
                                                 {{8{data_align[23]}},data_align[23:16]},
                                                 {{8{data_align[15]}},data_align[15:8]},
                                                 {{8{data_align[7]}}, data_align[7:0]}};
  {BYTE,WORD,1'b0} : data_align_vls_ext[63:0] = {{24'b0,data_align[15:8]},
                                                 {24'b0,data_align[7:0]}};
  {BYTE,WORD,1'b1} : data_align_vls_ext[63:0] = {{{24{data_align[15]}},data_align[15:8]},
                                                 {{24{data_align[7]}}, data_align[7:0]}};
  {HALF,WORD,1'b0} : data_align_vls_ext[63:0] = {{16'b0,data_align[31:16]},
                                                 {16'b0,data_align[15:0]}};
  {HALF,WORD,1'b1} : data_align_vls_ext[63:0] = {{{16{data_align[31]}},data_align[31:16]},
                                                 {{16{data_align[15]}}, data_align[15:0]}};
  default          : data_align_vls_ext[63:0] = data_align[63:0];
  endcase
// &CombEnd; @1274
end

// &CombBeg; @1277
always @( data_align[63:0]
       or size[1:0])
begin
  case(size[1:0])
  HALF    : data_align_fls_ext[`LSU_DATAW-1:0] = {{{`LSU_DATAW-16{1'b1}},data_align[15:0]}};
  WORD    : data_align_fls_ext[`LSU_DATAW-1:0] = {{{`LSU_DATAW-32{1'b1}},data_align[31:0]}};
  default : data_align_fls_ext[`LSU_DATAW-1:0] = data_align[`LSU_DATAW-1:0];
  endcase
// &CombEnd; @1283
end

assign data_align_vfls_ext[`LSU_DATAW-1:0] = fls ? data_align_fls_ext[`LSU_DATAW-1:0] : data_align_vls_ext[`LSU_DATAW-1:0];

//for vlsu merge,convert to reg_bytes_vld
// &CombBeg; @1289
// &CombEnd; @1308
// &CombBeg; @1310
// &CombEnd; @1338
// &CombBeg; @1340
always @( dc_da_bytes_vld[7:0])
begin
  casez(dc_da_bytes_vld[7:0])
  8'b??????10 : bytes_vld_align[7:0] = {dc_da_bytes_vld[0],dc_da_bytes_vld[7:1]};
  8'b?????100 : bytes_vld_align[7:0] = {dc_da_bytes_vld[1:0],dc_da_bytes_vld[7:2]};
  8'b????1000 : bytes_vld_align[7:0] = {dc_da_bytes_vld[2:0],dc_da_bytes_vld[7:3]};
  8'b???10000 : bytes_vld_align[7:0] = {dc_da_bytes_vld[3:0],dc_da_bytes_vld[7:4]};
  8'b??100000 : bytes_vld_align[7:0] = {dc_da_bytes_vld[4:0],dc_da_bytes_vld[7:5]};
  8'b?1000000 : bytes_vld_align[7:0] = {dc_da_bytes_vld[5:0],dc_da_bytes_vld[7:6]};
  8'b10000000 : bytes_vld_align[7:0] = {dc_da_bytes_vld[6:0],dc_da_bytes_vld[7]};
  default     : bytes_vld_align[7:0] = dc_da_bytes_vld[7:0];
  endcase
// &CombEnd; @1351
end

// &CombBeg; @1353
always @( element_size[1:0]
       or bytes_vld_align[7:0]
       or sew[1:0])
begin
  casez({element_size[1:0],sew[1:0]})
  {BYTE,HALF} : dc_da_bytes_vld_ext[7:0] = {{2{bytes_vld_align[3]}},
                                            {2{bytes_vld_align[2]}},
                                            {2{bytes_vld_align[1]}},
                                            {2{bytes_vld_align[0]}}};
  {BYTE,WORD} : dc_da_bytes_vld_ext[7:0] = {{4{bytes_vld_align[1]}},
                                            {4{bytes_vld_align[0]}}};
  {HALF,WORD} : dc_da_bytes_vld_ext[7:0] = {{2{bytes_vld_align[3:2]}},
                                            {2{bytes_vld_align[1:0]}}};
  default     : dc_da_bytes_vld_ext[7:0] = bytes_vld_align[7:0];
  endcase
// &CombEnd; @1404
end

//for vlsu merge timing,mask bytes_vld advance
assign dc_da_amo_no_wd = dc_da_amo_inst && dc_da_vfunc[3];

assign dc_da_merge_vld = dc_da_data_vld
                         && dc_da_vls
                         && !dc_da_amo_no_wd;

assign dc_da_bytes_vld_aft_mask[`LSU_BYTEW-1:0] = {`LSU_BYTEW{dc_da_merge_vld}}
                                               & ({`LSU_BYTEW{dc_da_vfunc[6]}} | dc_da_bytes_vld_ext[`LSU_BYTEW-1:0]);
                                       
//================================================
//     LSU int data forward to IDU in DC stage
//================================================
assign lfb_vfls = lfb_dc_vls | lfb_dc_fls;

assign data_vld = dc_ld_data_vld & !dc_vfls & !dc_expt_vld & (!dc_split | dc_split_second) |
                  lfb_dc_data_vld & !lfb_dc_ptw & !lfb_vfls & (!lfb_dc_split | lfb_dc_split_second) |
                  dc_sc_data_vld & !dc_vfls;

assign lsu_rtu_ex2_data_vld      = data_vld;
assign lsu_rtu_ex2_dest_reg[5:0] = dest_reg[5:0];
assign lsu_rtu_ex2_data[63:0]    = data_align_ext[63:0];

assign lsu_iu_ex2_data_vld       = data_vld;
assign lsu_iu_ex2_dest_reg[4:0]  = dest_reg[4:0];
assign lsu_iu_ex2_data[63:0]     = data_align_ext[63:0];

//================================================
//  dc/da
//================================================
assign dc_da_data_vld    = dc_ld_data_vld & (!dc_split | dc_split_second) |
                           lfb_dc_data_vld & !lfb_dc_ptw & (!lfb_dc_split | lfb_dc_split_second) |
                           dc_sc_data_vld;

assign dc_da_data_vld_dp = dc_inst_vld & (!dc_split | dc_split_second) |
                           lfb_dc_data_vld & !lfb_dc_ptw & (!lfb_dc_split | lfb_dc_split_second);

assign dc_da_dest_reg[5:0]             = dest_reg[5:0];
assign dc_da_data[`LSU_DATAW-1:0]      = vfls ? data_align_vfls_ext[`LSU_DATAW-1:0] : data_align_ext[`LSU_DATAW-1:0];
assign dc_da_bytes_vld[`LSU_BYTEW-1:0] = bytes_vld[`LSU_BYTEW-1:0];
assign dc_da_vls               = vls;
assign dc_da_fls               = fls;
assign dc_da_lock              = lock;
assign dc_da_sign_ext          = sign_ext;
assign dc_da_size[1:0]         = size[1:0];
assign dc_da_expt_vld          = expt_vld;
assign dc_da_sew[1:0]          = sew[1:0];
assign dc_da_element_size[1:0] = element_size[1:0];
assign dc_da_vfunc[7:0]        = vfunc[7:0];
assign dc_da_vl_update         = vl_update;
assign dc_da_vl_val[6:0]       = vl_val[6:0];
assign dc_da_vsplit_last       = vsplit_last;
assign dc_da_vec_nop           = vec_nop;
//assign dc_da_ld_inst           = ld_inst;
assign dc_da_amo_inst          = amo_inst;
assign dc_da_amo_func[4:0]     = amo_func[4:0];
assign dc_da_stb_id[1:0]       = stb_id[1:0];
//assign dc_da_pa[PADDR-1:0]     = pa[PADDR-1:0];

//================================================
//  DC TO MCIC
//================================================

assign dc_mcic_data_vld           = dc_ptw_vld & dc_cache_hit & !dc_ld_reply |
                                    lfb_dc_data_vld & lfb_dc_ptw;
assign dc_mcic_data[63:0]         = dc_data[63:0];
assign dc_mcic_bus_err            = lfb_dc_data_vld & lfb_dc_ptw & lfb_dc_bus_err;

//================================================
//  DC TO LFB/STB/VB to check dependency
//================================================
assign dc_stb_clr_vld       = dc_stage_vld & 
                              (dc_req_vld & dc_ld_amo_inst & dc_cache_miss & stb_dc_hit_idx |
                               dc_ld_amo_inst & stb_dc_multi_or_part_hit |
                               dc_req_vld & dc_st_inst & dc_cache_miss & (dc_st_alct | dc_alias_hit) & !stb_dc_merge_en & stb_dc_hit_idx |
                               dc_st_inst & dc_st_wdata_ready & !stb_dc_merge_en & stb_dc_hit_addr |
                               dc_lock_trans & stb_dc_hit_idx |
                               dc_dca_inst & stb_dc_hit_idx);


assign dc_xx_pa[PADDR-1:0]  = dc_pa[PADDR-1:0];
assign dc_xx_dest_preg[5:0] = dc_dest_reg[5:0];

assign dc_xx_bytes_vld[`LSU_BYTEW-1:0] = dc_bytes_vld[`LSU_BYTEW-1:0];

assign dc_async_vld              = lfb_dc_data_vld & !lfb_dc_ptw & lfb_dc_bus_err & 
                                   (!lfb_dc_split | lfb_dc_split_first | lfb_dc_split_second & !(mb_vld & mb_bus_err));
assign dc_async_ld_inst          = !lfb_dc_lock;
assign dc_async_mtval[PADDR-1:0] = lfb_dc_mtval[PADDR-1:0];

always@(posedge expt_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    async_expt_vld <= 1'b0;
  else if (dc_async_vld & !rtu_yy_xx_dbgon)
    async_expt_vld <= 1'b1;
  else if (rtu_lsu_async_expt_ack & !rtu_yy_xx_dbgon)
    async_expt_vld <= 1'b0;
end

assign expt_clk_en = async_expt_vld | dc_async_vld | debug_mode_async_err; 
// &Instance("gated_clk_cell", "x_aq_lsu_async_expt_gated_clk"); @1572
gated_clk_cell  x_aq_lsu_async_expt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (expt_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (expt_clk_en       ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1573
//          .external_en (1'b0), @1574
//          .global_en   (1'b1), @1575
//          .module_en   (cp0_lsu_icg_en), @1576
//          .local_en    (expt_clk_en), @1577
//          .clk_out     (expt_clk)); @1578

always@(posedge expt_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    async_mtval[PADDR-1:0] <= {PADDR{1'b0}};
    async_ld_inst          <= 1'b0;
  end
  else if (dc_async_vld & (!async_expt_vld | rtu_lsu_async_expt_ack & !rtu_yy_xx_dbgon)) begin
    async_mtval[PADDR-1:0] <= dc_async_mtval[PADDR-1:0];
    async_ld_inst          <= dc_async_ld_inst;
  end
end

//----------------------async expt on debug---------------------------------------
//when dbgon, async_expt req should use seperate signal
//async_expt info in debug mode is not needed
always@(posedge expt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    debug_mode_async_err <= 1'b0;
  else if (rtu_yy_xx_dbgon & dc_async_vld)
    debug_mode_async_err <= 1'b1;
  else if (!rtu_yy_xx_dbgon | rtu_lsu_async_expt_ack & rtu_yy_xx_dbgon)
    debug_mode_async_err <= 1'b0;
end

assign lsu_rtu_async_expt_vld   = async_expt_vld & !rtu_yy_xx_dbgon | debug_mode_async_err & rtu_yy_xx_dbgon;
assign lsu_rtu_async_ld_inst    = async_ld_inst;
assign lsu_rtu_async_tval[PADDR-1:0] = async_mtval[PADDR-1:0];

//==============================================================================
//  DA stage
//==============================================================================

always@(posedge da_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    da_inst_vld <= 1'b0;
  else if (rtu_yy_xx_async_flush)
    da_inst_vld <= 1'b0;
  else if (dc_da_data_vld)
    da_inst_vld <= 1'b1;
  else if (da_inst_vld)
    da_inst_vld <= 1'b0;
end

//for vlsu wb timing,bytes_vld used as control signal now
always@(posedge da_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    da_bytes_vld[`LSU_BYTEW-1:0]  <= {`LSU_BYTEW{1'b0}};
  else if (rtu_yy_xx_async_flush)
    da_bytes_vld[`LSU_BYTEW-1:0]  <= {`LSU_BYTEW{1'b0}};
  else if (dc_da_data_vld)
    da_bytes_vld[`LSU_BYTEW-1:0]  <= dc_da_bytes_vld_aft_mask[`LSU_BYTEW-1:0];
  else if (da_inst_vld)
    da_bytes_vld[`LSU_BYTEW-1:0]  <= {`LSU_BYTEW{1'b0}};
end

always@(posedge da_clk)
begin
  if (dc_da_data_vld_dp | ifu_lsu_warm_up) begin
    da_vls             <= dc_da_vls;
    da_fls             <= dc_da_fls;
    da_lock            <= dc_da_lock;
    da_sign_ext        <= dc_da_sign_ext;
    da_size[1:0]       <= dc_da_size[1:0];
    da_dest_reg[5:0]   <= dc_da_dest_reg[5:0];
    da_expt_vld        <= dc_da_expt_vld;
    da_sc_inst         <= dc_sc_data_vld;
//    da_ld_inst         <= dc_da_ld_inst;
    da_amo_inst        <= dc_da_amo_inst;
    da_amo_func[4:0]   <= dc_da_amo_func[4:0];
    da_stb_id[1:0]     <= dc_da_stb_id[1:0];
  end  
end

//for power saving
always@(posedge da_data_clk)
begin
  if (dc_da_data_vld_dp | ifu_lsu_warm_up) begin
    da_data[`LSU_DATAW-1:0] <= dc_da_data[`LSU_DATAW-1:0];
//    da_pa[PADDR-1:0]        <= dc_da_pa[PADDR-1:0];
  end  
end

always@(posedge da_clk)
begin
  if (dc_da_data_vld_dp & dc_da_vls | ifu_lsu_warm_up) begin
    da_sew[1:0]        <= dc_da_sew[1:0];
    da_ele_size[1:0]   <= dc_da_element_size[1:0];
    da_vfunc[7:0]      <= dc_da_vfunc[7:0];
    da_vl_update       <= dc_da_vl_update;
    da_vl_val[6:0]     <= dc_da_vl_val[6:0];
    da_vsplit_last     <= dc_da_vsplit_last;
    da_vec_nop         <= dc_da_vec_nop;
  end  
end

assign da_vfls = da_vls | da_fls;

assign da_amo_no_wd = da_amo_inst && da_vfunc[3];

// &Force("output","da_xx_fwd_vld"); @1682
// &Force("output","da_xx_fwd_dst_reg"); @1683
// &Force("output","da_xx_fwd_data"); @1684

assign da_xx_fwd_vld                  = da_inst_vld & !da_vfls;
assign da_xx_fwd_dst_reg[5:0]         = da_dest_reg[5:0];
assign da_xx_fwd_data[63:0]           = da_data[63:0];
assign da_dc_fwd_data[`LSU_DATAW-1:0] = da_data[`LSU_DATAW-1:0];

assign lsu_rtu_wb_vld           = da_inst_vld & !da_vfls & !da_expt_vld;
assign lsu_rtu_wb_dest_reg[5:0] = da_dest_reg[5:0];
assign lsu_rtu_wb_data[63:0]    = da_data[63:0];

assign lsu_vlsu_data_vld      = da_inst_vld & da_vfls & !da_amo_no_wd;  //exclude amo wd0
assign lsu_vlsu_func[19:0]    = {da_vfunc[7:0], 
                                 da_vls, 
                                 da_fls,
                                 4'b0,
                                 da_lock,
                                 1'b1,
                                 da_ele_size[1:0],
                                 da_sign_ext,
                                 1'b0};
assign lsu_vlsu_sew[1:0]                  = da_sew[1:0];
assign lsu_vlsu_bytes_vld[`LSU_BYTEW-1:0] = da_bytes_vld[`LSU_BYTEW-1:0];
assign lsu_vlsu_dest_reg[4:0]             = da_dest_reg[4:0];
assign lsu_vlsu_data[`LSU_DATAW-1:0]      = da_data[`LSU_DATAW-1:0];
assign lsu_vlsu_vl_update                 = da_vl_update;
assign lsu_vlsu_vl_upval[6:0]             = da_vl_val[6:0];
assign lsu_vlsu_split_last                = da_vsplit_last;
assign lsu_vlsu_expt_vld                  = da_expt_vld;

assign da_xx_no_op = !da_inst_vld;

//for amo
assign da_stb_amo_src_id[1:0] = da_stb_id[1:0];
  
assign da_amo_src_vld         = da_inst_vld & da_amo_inst & !(da_vls & da_vec_nop); 
assign da_amo_stb_id[1:0]     = da_stb_id[1:0];
assign da_amo_alu_src0[63:0]  = da_data[63:0];
assign da_amo_alu_size[1:0]   = da_vls ? da_sew[1:0] : da_size[1:0]; 
assign da_amo_alu_func[4:0]   = da_amo_func[4:0];

//================================================
//  HPCP
//================================================

always@(posedge hpcp_clk)
begin
  if (hpcp_lsu_cnt_en | ifu_lsu_warm_up) begin
    lsu_hpcp_cache_read_access  <= dc_inst_vld & !dc_reply & dc_ld_amo_inst & dc_ca;
    lsu_hpcp_cache_write_access <= dc_inst_vld & !dc_reply & dc_st_inst & dc_ca;
    lsu_hpcp_cache_read_miss    <= dc_lfb_create_en & dc_ld_amo_inst & !(dc_cache_hit_raw | dc_alias_hit_raw) & dc_ca;
    lsu_hpcp_cache_write_miss   <= dc_lfb_create_en & dc_st_inst & !(dc_cache_hit_raw | dc_alias_hit_raw) & dc_ca;
    lsu_hpcp_inst_store         <= ag_inst_store;
    lsu_hpcp_unalign_inst       <= dc_inst_vld & !dc_reply & dc_split_last;
  end
end

assign hpcp_clk_en = hpcp_lsu_cnt_en | ifu_lsu_warm_up;

// &Instance("gated_clk_cell", "x_aq_lsu_hpcp_gated_clk"); @1743
gated_clk_cell  x_aq_lsu_hpcp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (hpcp_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (hpcp_clk_en       ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1744
//          .external_en (1'b0), @1745
//          .global_en   (1'b1), @1746
//          .module_en   (cp0_lsu_icg_en), @1747
//          .local_en    (hpcp_clk_en), @1748
//          .clk_out     (hpcp_clk)); @1749

//================================================
//  DT interface
//================================================
assign da_dtu_data_vld   = da_inst_vld & !da_vls & !da_sc_inst & !da_expt_vld;
assign da_dtu_data[63:0] = da_data[63:0];

//================================================
//  ICG
//================================================
//assign dc_clk_en = ag_dc_inst_vld_gate | mcic_dc_req |
//                  (dc_cur_state != IDLE);
//                   
//&Instance("gated_clk_cell", "x_aq_lsu_dc_gated_clk");
// //&Connect(.clk_in      (forever_cpuclk), @1764
// //         .external_en (1'b0), @1765
// //         .global_en   (1'b1), @1766
// //         .module_en   (cp0_lsu_icg_en), @1767
// //         .local_en    (dc_clk_en), @1768
// //         .clk_out     (dc_clk)); @1769

assign dc_clk_en    = ag_dc_inst_vld_gate | mcic_dc_req | ifu_lsu_warm_up | 
                      (dc_cur_state != IDLE);

assign dc_dp_clk_en = (ag_dc_inst_vld_gate | mcic_dc_req) & !dc_cur_state[1] | ifu_lsu_warm_up; 

// &Instance("gated_clk_cell", "x_aq_lsu_dc_gated_clk"); @1776
gated_clk_cell  x_aq_lsu_dc_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dc_clk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dc_clk_en         ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1777
//          .external_en (1'b0), @1778
//          .global_en   (1'b1), @1779
//          .module_en   (cp0_lsu_icg_en), @1780
//          .local_en    (dc_clk_en), @1781
//          .clk_out     (dc_clk)); @1782

// &Instance("gated_clk_cell", "x_aq_lsu_dc_dp_gated_clk"); @1784
gated_clk_cell  x_aq_lsu_dc_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dc_dp_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dc_dp_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1785
//          .external_en (1'b0), @1786
//          .global_en   (1'b1), @1787
//          .module_en   (cp0_lsu_icg_en), @1788
//          .local_en    (dc_dp_clk_en), @1789
//          .clk_out     (dc_dp_clk)); @1790

assign dc_st_dp_clk_en = ag_dc_inst_vld_gate & ag_st_inst | 
                         ifu_lsu_warm_up | 
                         dc_st_fwd_vld & dc_stage_vld | 
                         vlsu_create_wdata_en;
// &Instance("gated_clk_cell", "x_aq_lsu_dc_st_dp_gated_clk"); @1796
gated_clk_cell  x_aq_lsu_dc_st_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dc_st_dp_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dc_st_dp_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1797
//          .external_en (1'b0), @1798
//          .global_en   (1'b1), @1799
//          .module_en   (cp0_lsu_icg_en), @1800
//          .local_en    (dc_st_dp_clk_en), @1801
//          .clk_out     (dc_st_dp_clk)); @1802

assign dc_mb_clk_en = dc_inst_vld & !dc_vls & dc_split |
                      lfb_dc_data_vld & !lfb_dc_vls & lfb_dc_split | 
                      ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_dc_mb_gated_clk"); @1807
gated_clk_cell  x_aq_lsu_dc_mb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dc_mb_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (dc_mb_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1808
//          .external_en (1'b0), @1809
//          .global_en   (1'b1), @1810
//          .module_en   (cp0_lsu_icg_en), @1811
//          .local_en    (dc_mb_clk_en), @1812
//          .clk_out     (dc_mb_clk)); @1813

assign da_clk_en = dc_da_data_vld_dp | ifu_lsu_warm_up | da_inst_vld;
// &Instance("gated_clk_cell", "x_aq_lsu_da_gated_clk"); @1816
gated_clk_cell  x_aq_lsu_da_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (da_clk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (da_clk_en         ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1817
//          .external_en (1'b0), @1818
//          .global_en   (1'b1), @1819
//          .module_en   (cp0_lsu_icg_en), @1820
//          .local_en    (da_clk_en), @1821
//          .clk_out     (da_clk)); @1822

assign da_data_clk_en = dc_da_data_vld_dp | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_aq_lsu_da_data_gated_clk"); @1825
gated_clk_cell  x_aq_lsu_da_data_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (da_data_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (da_data_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1826
//          .external_en (1'b0), @1827
//          .global_en   (1'b1), @1828
//          .module_en   (cp0_lsu_icg_en), @1829
//          .local_en    (da_data_clk_en), @1830
//          .clk_out     (da_data_clk)); @1831

assign dc_dbginfo[9:0] = {dc_cur_state[1:0],dc_src2_depd, dc_ptw, dc_func[3:0], mb_vld, mb_data_vld};

//assign lsu_had_st_req              = dc_inst_vld & dc_st_inst & !dc_reply;
//assign lsu_had_st_addr[PADDR-1:0]  = dc_pa[PADDR-1:0];
//assign lsu_had_st_data[63:0]       = dc_st_wdata[63:0];
//
//assign lsu_had_ld_req              = da_inst_vld & da_ld_inst;
//assign lsu_had_ld_addr[PADDR-1:0]  = da_pa[PADDR-1:0];
//assign lsu_had_ld_data[63:0]       = da_data[63:0];

//==============================================================================
//  ASSERTION
//==============================================================================
// &Force("nonport","rdl_pf_vld"); @1847
// &Force("nonport", "icc_rdl_sel"); @1885

// &ModuleEnd; @1900
endmodule


