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


// &ModuleBeg; @24
module ct_cp0_regs (
  // &Ports, @25
  input    wire  [39 :0]  biu_cp0_apb_base,
  input    wire           biu_cp0_cmplt,
  input    wire  [2  :0]  biu_cp0_coreid,
  input    wire  [7  :0]  ext_interrupt,
  input    wire           biu_cp0_me_int,
  input    wire           biu_cp0_ms_int,
  input    wire           biu_cp0_mt_int,
  input    wire  [127:0]  biu_cp0_rdata,
  input    wire  [39 :0]  biu_cp0_rvba,
  input    wire           biu_cp0_se_int,
  input    wire           biu_cp0_ss_int,
  input    wire           biu_cp0_st_int,
  input    wire           cp0_mret,
  input    wire           cp0_ertn,
  input    wire           cp0_cprs,
  input    wire           cp0_sret,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [63 :0]  hpcp_cp0_data,
  input    wire           hpcp_cp0_int_vld,
  input    wire           hpcp_cp0_sce,
  input    wire  [6  :0]  idu_cp0_fesr_acc_updt_val,
  input    wire           idu_cp0_fesr_acc_updt_vld,
  input    wire           ifu_cp0_bht_inv_done,
  input    wire           ifu_cp0_btb_inv_done,
  input    wire           ifu_cp0_icache_inv_done,
  input    wire  [127:0]  ifu_cp0_icache_read_data,
  input    wire           ifu_cp0_icache_read_data_vld,
  input    wire           ifu_cp0_ind_btb_inv_done,
  input    wire           ifu_cp0_rst_inv_req,
  input    wire  [11 :0]  iui_regs_addr,
  input    wire  [15 :0]  iui_regs_iocsr_addr,
  input    wire           iui_regs_csr_wr,
  input    wire           iui_regs_csrw,
  input    wire           iui_regs_ex3_inst_csr,
  input    wire           iui_regs_inst_mret,
  input    wire           iui_regs_inst_ertn,
  input    wire           iui_regs_inst_sret,
  input    wire           iui_regs_inv_expt,
  input    wire  [31 :0]  iui_regs_opcode,
  input    wire  [63 :0]  iui_regs_ori_src0,
  input    wire  [63 :0]  iui_regs_cpu_cfg_code,
  input    wire           iui_regs_rst_inv_d,
  input    wire           iui_regs_rst_inv_i,
  input    wire           iui_regs_sel,
  input    wire           iui_regs_sel_ipi,
  input    wire  [63 :0]  iui_regs_src0,
  input    wire  [63 :0]  iui_ipi_regs_src,
  input    wire           iui_update_ipi_status_en,
  input    wire  [31 :0]  iui_update_ipi_status_src,
  input    wire           iui_update_ipi_mailbox0_en,
  input    wire           iui_update_ipi_mailbox1_en,
  input    wire           iui_update_ipi_mailbox2_en,
  input    wire           iui_update_ipi_mailbox3_en,
  input    wire  [ 3 :0]  iui_update_ipi_mailbox_sel,
  input    wire  [31 :0]  iui_update_ipi_regs_src0,
  input    wire  [31 :0]  iui_update_ipi_regs_src1,
  input    wire  [31 :0]  iui_update_ipi_regs_src2,
  input    wire  [31 :0]  iui_update_ipi_regs_src3,
  input    wire  [31 :0]  iui_update_ipi_regs_mask0,
  input    wire  [31 :0]  iui_update_ipi_regs_mask1,
  input    wire  [31 :0]  iui_update_ipi_regs_mask2,
  input    wire  [31 :0]  iui_update_ipi_regs_mask3,
  input    wire           lsu_cp0_dcache_done,
  input    wire  [127:0]  lsu_cp0_dcache_read_data,
  input    wire           lsu_cp0_dcache_read_data_vld,
  input    wire  [63 :0]  lsu_cp0_ld_va,
  input    wire  [39 :0]  lsu_cp0_ld_pa,
  input    wire           lsu_cp0_ld_vld,
  input    wire  [63 :0]  mmu_cp0_data,
  input    wire  [63 :0]  mmu_cp0_satp_data,
  input    wire           mmu_cp0_type,
  input    wire  [26 :0]  mmu_cp0_vpn,
  input    wire           mmu_cp0_fst_vld,
  input    wire  [39 :0]  mmu_cp0_fst_addr,
  input    wire           mmu_cp0_scd_vld,
  input    wire  [39 :0]  mmu_cp0_scd_addr,
  input    wire           mmu_cp0_thd_vld,
  input    wire  [39 :0]  mmu_cp0_thd_addr,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [63 :0]  pmp_cp0_data,
  input    wire  [63 :0]  sysio_core_gl_stable_timer,
  input    wire  [63 :0]  rtu_cp0_epc,
  input    wire           rtu_cp0_expt_gateclk_vld,
  input    wire  [63 :0]  rtu_cp0_expt_mtval,
  input    wire           rtu_cp0_expt_vld,
  input    wire           rtu_cp0_fp_dirty_vld,
  input    wire           rtu_cp0_int_ack,
  input    wire           rtu_cp0_vec_dirty_vld,
  input    wire           rtu_cp0_vsetvl_vill,
  input    wire  [7  :0]  rtu_cp0_vsetvl_vl,
  input    wire           rtu_cp0_vsetvl_vl_vld,
  input    wire  [1  :0]  rtu_cp0_vsetvl_vlmul,
  input    wire  [2  :0]  rtu_cp0_vsetvl_vsew,
  input    wire           rtu_cp0_vsetvl_vtype_vld,
  input    wire  [6  :0]  rtu_cp0_vstart,
  input    wire           rtu_cp0_vstart_vld,
  input    wire  [15 :0]  rtu_yy_xx_expt_vec,
  input    wire           rtu_yy_xx_flush,
  output   wire           cp0_biu_icg_en,
  output   wire  [31 :0]  cp0_had_cpuid_0,
  output   wire  [1  :0]  cp0_had_trace_pm_wdata,
  output   wire           cp0_had_trace_pm_wen,
  output   wire           cp0_hpcp_icg_en,
  output   wire  [11 :0]  cp0_hpcp_index,
  output   wire           cp0_hpcp_int_disable,
  output   wire  [31 :0]  cp0_hpcp_mcntwen,
  output   wire           cp0_hpcp_pmdm,
  output   wire           cp0_hpcp_pmds,
  output   wire           cp0_hpcp_pmdu,
  output   wire  [63 :0]  cp0_hpcp_wdata,
  output   wire           cp0_idu_cskyee,
  output   wire           cp0_idu_dlb_disable,
  output   wire  [2  :0]  cp0_idu_frm,
  output   wire  [1  :0]  cp0_idu_fs,
  output   wire           cp0_idu_icg_en,
  output   wire           cp0_idu_iq_bypass_disable,
  output   wire           cp0_idu_rob_fold_disable,
  output   wire           cp0_idu_src2_fwd_disable,
  output   wire           cp0_idu_srcv2_fwd_disable,
  output   wire           cp0_idu_vill,
  output   wire  [1  :0]  cp0_idu_vs,
  output   wire  [6  :0]  cp0_idu_vstart,
  output   wire           cp0_idu_zero_delay_move_disable,
  output   wire           cp0_ifu_bht_en,
  output   wire           cp0_ifu_bht_inv,
  output   wire           cp0_ifu_btb_en,
  output   wire           cp0_ifu_btb_inv,
  output   wire           cp0_ifu_icache_en,
  output   wire           cp0_ifu_icache_inv,
  output   wire           cp0_ifu_icache_pref_en,
  output   wire  [16 :0]  cp0_ifu_icache_read_index,
  output   wire           cp0_ifu_icache_read_req,
  output   wire           cp0_ifu_icache_read_tag,
  output   wire           cp0_ifu_icache_read_way,
  output   wire           cp0_ifu_icg_en,
  output   wire           cp0_ifu_ind_btb_en,
  output   wire           cp0_ifu_ind_btb_inv,
  output   wire           cp0_ifu_insde,
  output   wire           cp0_ifu_iwpe,
  output   wire           cp0_ifu_l0btb_en,
  output   wire           cp0_ifu_lbuf_en,
  output   wire           cp0_ifu_nsfe,
  output   wire           cp0_ifu_ras_en,
  output   wire  [39 :0]  cp0_ifu_rvbr,
  output   wire  [39 :0]  cp0_ifu_vbr,
  output   wire  [2  :0]  cp0_ifu_ecfg_vs,
  output   wire  [63 :0]  cp0_ifu_eentry,
  output   wire  [7  :0]  cp0_ifu_vl,
  output   wire  [1  :0]  cp0_ifu_vlmul,
  output   wire           cp0_ifu_vsetvli_pred_disable,
  output   wire           cp0_ifu_vsetvli_pred_mode,
  output   wire  [2  :0]  cp0_ifu_vsew,
  output   wire           cp0_iu_div_entry_disable,
  output   wire           cp0_iu_div_entry_disable_clr,
  output   wire  [62 :0]  cp0_iu_ex3_efpc,
  output   wire           cp0_iu_ex3_efpc_vld,
  output   wire           cp0_iu_icg_en,
  output   wire           cp0_iu_vill,
  output   wire           cp0_iu_bju_chflw_en,
  output   wire  [7  :0]  cp0_iu_vl,
  output   wire           cp0_iu_vsetvli_pre_decd_disable,
  output   wire  [6  :0]  cp0_iu_vstart,
  output   wire  [63 :0]  cp0_iu_timer,
  output   wire           cp0_lsu_amr,
  output   wire           cp0_lsu_amr2,
  output   wire           cp0_lsu_cb_aclr_dis,
  output   wire           cp0_lsu_corr_dis,
  output   wire           cp0_lsu_ctc_flush_dis,
  output   wire           cp0_lsu_da_fwd_dis,
  output   wire           cp0_lsu_dcache_clr,
  output   wire           cp0_lsu_dcache_en,
  output   wire           cp0_lsu_dcache_inv,
  output   wire  [1  :0]  cp0_lsu_dcache_pref_dist,
  output   wire           cp0_lsu_dcache_pref_en,
  output   wire  [16 :0]  cp0_lsu_dcache_read_index,
  output   wire           cp0_lsu_dcache_read_ld_tag,
  output   wire           cp0_lsu_dcache_read_req,
  output   wire           cp0_lsu_dcache_read_st_tag,
  output   wire           cp0_lsu_dcache_read_way,
  output   wire           cp0_lsu_fencei_broad_dis,
  output   wire           cp0_lsu_fencerw_broad_dis,
  output   wire           cp0_lsu_icg_en,
  output   wire  [1  :0]  cp0_lsu_l2_pref_dist,
  output   wire           cp0_lsu_l2_pref_en,
  output   wire           cp0_lsu_l2_st_pref_en,
  output   wire           cp0_lsu_mm,
  output   wire           cp0_lsu_nsfe,
  output   wire           cp0_lsu_pfu_mmu_dis,
  output   wire  [29 :0]  cp0_lsu_timeout_cnt,
  output   wire           cp0_lsu_tlb_broad_dis,
  output   wire           cp0_lsu_tvm,
  output   wire           cp0_lsu_ucme,
  output   wire  [6  :0]  cp0_lsu_vstart,
  output   wire           cp0_lsu_wa,
  output   wire           cp0_lsu_wr_burst_dis,
  output   wire           cp0_mmu_cskyee,
  output   wire           cp0_mmu_icg_en,
  output   wire           cp0_mmu_maee,
  output   wire  [1  :0]  cp0_mmu_mpp,
  output   wire           cp0_mmu_mprv,
  output   wire           cp0_mmu_mxr,
  output   wire           cp0_mmu_ptw_en,
  output   wire  [1  :0]  cp0_mmu_reg_num,
  output   wire           cp0_mmu_satp_sel,
  output   wire           cp0_mmu_sum,
  output   wire  [63 :0]  cp0_mmu_wdata,
  output   wire           cp0_mmu_wreg,
  output   wire           cp0_mmu_crmd_da,
  output   wire           cp0_mmu_crmd_pg,
  output   wire  [15: 0]  cp0_mmu_cur_asid,
  output   wire  [1 : 0]  cp0_mmu_da_mode_datf,
  output   wire  [1 : 0]  cp0_mmu_da_mode_datm,
  output   wire  [63: 0]  cp0_mmu_ptw_pgdl,
  output   wire  [63: 0]  cp0_mmu_ptw_pgdh,
  output   wire  [63: 0]  cp0_mmu_dmw0,
  output   wire  [63: 0]  cp0_mmu_dmw1,
  output   wire  [63: 0]  cp0_mmu_dmw2,
  output   wire  [63: 0]  cp0_mmu_dmw3,
  output   wire  [63 :0]  cp0_pad_mstatus,
  output   wire           cp0_pmp_icg_en,
  output   wire  [1  :0]  cp0_pmp_mpp,
  output   wire           cp0_pmp_mprv,
  output   wire  [4  :0]  cp0_pmp_reg_num,
  output   wire  [63 :0]  cp0_pmp_wdata,
  output   wire           cp0_pmp_wreg,
  output   wire           cp0_rtu_icg_en,
  output   wire           cp0_rtu_srt_en,
  output   wire  [63 :0]  cp0_vfpu_fcsr,
  output   wire  [31 :0]  cp0_vfpu_fxcr,
  output   wire           cp0_vfpu_icg_en,
  output   wire  [7  :0]  cp0_vfpu_vl,
  output   wire           cp0_xx_core_arch,
  output   wire           cp0_xx_core_icg_en,
  output   wire           cp0_yy_dcache_pref_en,
  output   wire           cp0_yy_hyper,
  output   wire  [1  :0]  cp0_yy_priv_mode,
  output   wire           cp0_yy_virtual_mode,
  output   wire           regs_iui_cfr_no_op,
  output   wire           regs_iui_chk_vld,
  output   wire           regs_iui_cindex_l2,
  output   wire           regs_iui_cins_no_op,
  output   wire           regs_iui_cskyee,
  output   wire  [63 :0]  regs_iui_data_out,
  output   wire  [63 :0]  regs_iui_iocsr_data_out,
  output   wire  [63 :0]  regs_iui_mailbox0_data,
  output   wire  [63 :0]  regs_iui_cfg_data_out,
  output   wire           regs_iui_dca_sel,
  output   wire           regs_iui_fs_off,
  output   wire           regs_iui_hpcp_regs_sel,
  output   wire           regs_iui_hpcp_scr_inv,
  output   wire  [14 :0]  regs_iui_int_sel,
  output   wire           regs_iui_l2_regs_sel,
  output   wire  [1  :0]  regs_iui_pm,
  output   wire  [3  :0]  regs_iui_reg_idx,
  output   wire           regs_iui_scnt_inv,
  output   wire           regs_iui_tee_ff,
  output   wire           regs_iui_tee_vld,
  output   wire           regs_iui_tsr,
  output   wire           regs_iui_tvm,
  output   wire           regs_iui_tw,
  output   wire           regs_iui_ucnt_inv,
  output   wire           regs_iui_v,
  output   wire  [2  :0]  regs_iui_ecfg_vs,
  output   wire           regs_iui_vs_off,
  output   wire  [63 :0]  regs_iui_wdata,
  output   wire           regs_lpmd_int_vld,
  output   wire           regs_xx_icg_en
); 



// &Regs; @26
reg              amr;                            
reg              amr2;                           
reg              bht_inv;                        
reg              bpe;                            
reg              btb_inv;                        
reg              btbe;                           
reg              cb_aclr_dis;                    
reg     [63 :0]  cdata0;                         
reg     [63 :0]  cdata1;                         
reg     [127:0]  cdata_read_data;                
reg     [20 :0]  cindex_index;                   
reg     [3  :0]  cindex_rid;                     
reg     [3  :0]  cindex_way;                     
reg              cins_ff;                        
reg              cins_r;                         
reg              clintee;                        
reg              clr;                            
reg     [31 :0]  cnt_sel;                        
reg              corr_dis;                       
reg              cskyisaee;                      
reg              ctc_flush_dis;                  
reg              da_fwd_dis;                     
reg     [63 :0]  data_out;                       
reg     [63 :0]  iocsr_data_out;                       
reg     [63 :0]  regs_iui_cfg_data;                       
reg              dcache_inv;                     
reg     [1  :0]  dcache_pref_dist;               
reg              dcache_pref_en;                 
reg              de;                             
reg              div_entry_dis;                  
reg              dlb_dis;                        
reg     [15 :0]  edeleg;                         
reg              fcsr_dz;                        
reg     [2  :0]  fcsr_frm;                       
reg              fcsr_nv;                        
reg              fcsr_nx;                        
reg              fcsr_of;                        
reg     [1  :0]  fcsr_raw_vxrm;                  
reg              fcsr_raw_vxsat;                 
reg              fcsr_uf;                        
reg              fencei_broad_dis;               
reg              fencerw_broad_dis;              
reg     [1  :0]  fs;                             
reg              fxcr_dqnan;                     
reg              fxcr_fe;                        
reg              ibp_inv;                        
reg              ibpe;                           
reg              icache_inv;                     
reg              icache_pref_en;                 
reg              ie;                             
reg     [2  :0]  index;                          
reg              insde;                          
reg              iq_bypass_dis;                  
reg              iwpe;                           
reg              l0btbe;                         
reg     [1  :0]  l2_pref_dist;                   
reg     [3  :0]  l2_regs_idx;                    
reg              l2pld;                          
reg              l2stpld;                        
reg     [8  :0]  local_icg_en;                   
reg              lpe;                            
reg              m_intr;                         
reg     [4  :0]  m_vector;                       
reg              maee;                           
reg     [31 :0]  mcnten_reg;                     
reg     [31 :0]  mcntwen_reg;                    
reg     [31 :0]  mcpuid_value;                   
reg              meie;                           
reg     [62 :0]  mepc_reg;                       
reg              mhrd;                           
reg              mie_bit;                        
reg              mm;                             
reg              moie;                           
reg              moie_deleg;                     
reg              mpie;                           
reg     [1  :0]  mpp;                            
reg              mprv;                           
reg     [38 :0]  mrvbr_reg;                      
reg     [63 :0]  mscratch_value;                 
reg              msie;                           
reg              mtie;                           
reg     [63 :0]  mtval_data;                     
reg     [61 :0]  mtvec_base;                     
reg     [1  :0]  mtvec_mode;                     
reg              mxr;                            
reg              nsfe;                           
reg     [3  :0]  par_dis;                        
reg              pfu_mmu_dis;                    
reg     [1  :0]  pm;                             
reg     [1  :0]  pm_wdata;                       
reg              pmdm;                           
reg              pmds;                           
reg              pmdu;                           
reg              rob_fold_dis;                   
reg              rse;                            
reg              rst_sample;                     
reg              s_intr;                         
reg     [4  :0]  s_vector;                       
reg     [31 :0]  scnten_reg;                     
reg              seie;                           
reg              seie_deleg;                     
reg              seip_reg;                       
reg     [1  :0]  sel;                            
reg     [62 :0]  sepc_reg;                       
reg              sie_bit;                        
reg              spie;                           
reg              spp;                            
reg              src2_fwd_dis;                   
reg              srcv2_fwd_dis;                  
reg              sre;                            
reg     [63 :0]  sscratch_value;                 
reg              ssie;                           
reg              ssie_deleg;                     
reg              ssip_reg;                       
reg              stie;                           
reg              stie_deleg;                     
reg              stip_reg;                       
reg     [63 :0]  stval_data;                     
reg     [61 :0]  stvec_base;                     
reg     [1  :0]  stvec_mode;                     
reg              sum;                            
reg     [29 :0]  timeout_cnt;                    
reg              tlb_broad_dis;                  
reg              tsr;                            
reg              tvm;                            
reg              tw;                             
reg              ucme;                           
reg     [18 :0]  vec_num;                        
reg     [7  :0]  vl_raw_vl;                      
reg     [1  :0]  vs_raw;                         
reg              vsetvli_dis;                    
reg              vsetvli_pred;                   
reg     [6  :0]  vstart_raw_vstart;              
reg              vtype_raw_vill;                 
reg     [1  :0]  vtype_raw_vlmul;                
reg     [2  :0]  vtype_raw_vsew;                 
reg              wa;                             
reg              wr_burst_dis;                   
reg              zero_move_dis;
reg              timer_clr;  
reg              tcfg_en;


// &Wires; @27
wire             cdata_clk;                      
wire             cdata_data_vld;                 
wire             cfr_bits_done;                  
wire             cindex_rid_dcache_data;         
wire             cindex_rid_dcache_data_ecc;     
wire             cindex_rid_dcache_ld_tag;       
wire             cindex_rid_dcache_ld_tag_ecc;   
wire             cindex_rid_dcache_st_tag;       
wire             cindex_rid_dcache_st_tag_ecc;   
wire             cindex_rid_icache_data;         
wire             cindex_rid_icache_data_ecc;     
wire             cindex_rid_icache_tag;          
wire             cindex_rid_icache_tag_ecc;      
wire             cindex_rid_l2cache_data;        
wire             cindex_rid_l2cache_data_ecc;    
wire             cindex_rid_l2cache_tag;         
wire             cindex_rid_l2cache_tag_ecc;     
wire             cins_no_op_data_vld;            
wire             cins_read_data_vld;             
wire             clr_done;                       
wire             cp0_regs_sel;                   
wire    [31 :0]  cpuid_index0_value;             
wire    [31 :0]  cpuid_index1_value;             
wire    [31 :0]  cpuid_index2_value;             
wire    [31 :0]  cpuid_index3_value;             
wire    [31 :0]  cpuid_index4_value;             
wire             cpuid_index5_core_num_1;        
wire             cpuid_index5_core_num_2;        
wire             cpuid_index5_core_num_3;        
wire    [31 :0]  cpuid_index5_value;             
wire    [31 :0]  cpuid_index6_value;             
wire             ecc_en;                         
wire             ecc_int_vld;                    
wire    [15 :0]  edeleg_upd_val;                 
wire    [25 :0]  extensions;                     
wire             fccee;                          
wire             fcsr_local_en;                  
wire    [63 :0]  fcsr_value;                     
wire    [1  :0]  fcsr_vxrm;                      
wire             fcsr_vxsat;                     
wire             fflags_local_en;                
wire    [63 :0]  fflags_value;                   
wire             frm_local_en;                   
wire    [63 :0]  frm_value;                      
wire             fs_dirty_upd;                   
wire             fxcr_local_en;                  
wire    [63 :0]  fxcr_value;                     
wire    [63 :0]  hedeleg_value;                  
wire             hpm_regs_sel;                   
wire    [63 :0]  hstatus_value;                  
wire             index_max;                      
wire    [2  :0]  index_next_val;                 
wire    [14 :0]  int_sel;                        
wire             inv;                            
wire             l2_regs_sel;                    
wire    [63 :0]  mapbaddr_value;                 
wire    [63 :0]  marchid_value;                  
wire             mcause_local_en;                
wire    [63 :0]  mcause_value;                   
wire             mccr2_local_en;                 
wire    [63 :0]  mcdata0_value;                  
wire    [63 :0]  mcdata1_value;                  
wire             mcer2_local_en;                 
wire    [63 :0]  mcer_value;                     
wire             mcie;                           
wire             mcie_deleg;                     
wire             mcindex_local_en;               
wire    [63 :0]  mcindex_value;                  
wire             mcins_local_en;                 
wire    [63 :0]  mcins_value;                    
wire             mcip;                           
wire             mcip_acc_en;                    
wire             mcip_deleg_vld;                 
wire             mcip_en;                        
wire             mcip_nodeleg_vld;               
wire             mcnten_hit;                     
wire             mcnten_local_en;                
wire    [63 :0]  mcnten_value;                   
wire             mcntwen_hit;                    
wire             mcntwen_local_en;               
wire    [63 :0]  mcntwen_value;                  
wire             mcor_local_en;                  
wire    [63 :0]  mcor_value;                     
wire             mcpuid_local_en;                
wire             mdeleg_vld;                     
wire             medeleg_local_en;               
wire    [63 :0]  medeleg_value;                  
wire             medeleg_vld;                    
wire             meicr2_local_en;                
wire    [63 :0]  meicr_value;                    
wire             meip;                           
wire             meip_en;                        
wire             meip_vld;                       
wire             mepc_local_en;                  
wire    [63 :0]  mepc_value;                     
wire    [63 :0]  mhartid_value;                  
wire             mhcr_local_en;                  
wire    [63 :0]  mhcr_value;                     
wire             mhie;                           
wire             mhie_deleg;                     
wire             mhint2_local_en;                
wire    [63 :0]  mhint2_value;                   
wire             mhint3_local_en;                
wire    [63 :0]  mhint3_value;                   
wire             mhint4_local_en;                
wire             mhint_local_en;                 
wire    [63 :0]  mhint_value;                    
wire             mhip;                           
wire             mhip_acc_en;                    
wire             mhip_deleg_vld;                 
wire             mhip_en;                        
wire             mhip_nodeleg_vld;               
wire             mhpmcr_local_en;                
wire             mideleg_local_en;               
wire    [63 :0]  mideleg_value;                  
wire             mideleg_vld;                    
wire             mie_local_en;                   
wire    [63 :0]  mie_value;                      
wire    [63 :0]  mimpid_value;                   
wire             mip_local_en;                   
wire    [63 :0]  mip_upd_value;                  
wire    [63 :0]  mip_value;                      
wire             misa_hypervisor;                
wire             misa_local_en;                  
wire    [63 :0]  misa_value;                     
wire             misa_vector;                    
wire             mmu_regs_sel;                   
wire             moip;                           
wire             moip_acc_en;                    
wire             moip_deleg_vld;                 
wire             moip_en;                        
wire             moip_nodeleg_vld;               
wire             mpv;                            
wire    [63 :0]  mrvbr_value;                    
wire             mscratch_local_en;              
wire             msip;                           
wire             msip_en;                        
wire             msip_vld;                       
wire             msmpr_local_en;                 
wire             mstatus_local_en;               
wire    [63 :0]  mstatus_value;                  
wire             mteecfg_local_en;               
wire    [63 :0]  mteecfg_value;                  
wire             mtip;                           
wire             mtip_en;                        
wire             mtip_vld;                       
wire             mtval_local_en;                 
wire    [63 :0]  mtval_upd_data;                 
wire    [63 :0]  mtval_value;                    
wire             mtvec_local_en;                 
wire    [63 :0]  mtvec_value;                    
wire    [63 :0]  mvendorid_value;                
wire    [63 :0]  mwmsr_value;                    
wire    [1  :0]  mxl;                            
wire             mxstatus_local_en;              
wire    [63 :0]  mxstatus_value;     
wire    [63 :0]  csrtval_value;
wire             arch_ctrl_local_en;
wire             crmd_local_en;
wire             prmd_local_en;
wire             ectl_local_en;
wire             estat_local_en;
wire             era_local_en;
wire             badv_local_en;
wire             eentry_local_en;
wire             tlbidx_local_en;
wire             tlbehi_local_en;
wire             tlbelo0_local_en;
wire             tlbelo1_local_en;
wire             asid_local_en;
wire             pgdl_local_en;
wire             pgdh_local_en;
wire             pgd_local_en;
wire             pwcl_local_en;
wire             pwch_local_en;
wire             stlbps_local_en;
wire             rvacfg_local_en;
wire             cpuid_local_en;
wire             save0_local_en;
wire             save1_local_en;
wire             save2_local_en;
wire             save3_local_en;
wire             tid_local_en;
wire             tcfg_local_en;
wire             tval_local_en;
wire             cntc_local_en;
wire             ticlr_local_en;
wire             llbctl_local_en;
wire             impctl1_local_en;
wire             impctl2_local_en;
wire             tlbrentry_local_en;
wire             tlbrehi_local_en;
wire             merrentry_local_en;
wire             dmw0_local_en;
wire             dmw1_local_en;
wire             dmw2_local_en;
wire             dmw3_local_en;
wire             BRK_local_en;
wire             dis_cache_local_en;
wire             euen_local_en;
wire             misc_local_en;
wire             ecfg_local_en;
wire             debug0_local_en;
wire             debug1_local_en;
wire             debug2_local_en;
wire             debug3_local_en;
wire             debug4_local_en;
wire             debug5_local_en;
wire             debug6_local_en;
wire             debug7_local_en;
wire             dgwavedump_local_en;
wire             cpcsr_local_en;
wire             cpcsr_tcfg_local_en;
wire             cpcsr_crmd_local_en;
wire             fcsr0_local_en;
wire             fcsr1_local_en;
wire             fcsr2_local_en;
wire             fcsr3_local_en;
wire             fwpc_local_en;
wire             fwps_local_en;
wire             mwpc_local_en;
wire             mwps_local_en;
wire             ifuc_local_en;
wire             cacc_local_en;
wire             mscc_local_en;

wire             pm_wen;                         
wire             pmp_regs_sel;                   
wire             regs_cindex_sel_l2;             
wire             regs_clk;                       
wire             regs_clk_en;                    
wire             regs_dca_sel;                   
wire             regs_flush_clk;                 
wire             regs_flush_clk_en;              
wire             satp_local_en;                  
wire             scause_local_en;                
wire    [63 :0]  scause_value;                   
wire             scer2_local_en;                 
wire    [63 :0]  scer_value;                     
wire    [2  :0]  sck;                            
wire             scnt_addr_hit;                  
wire             scnten_hit;                     
wire             scnten_local_en;                
wire    [63 :0]  scnten_value;                   
wire             sd;                             
wire             seip;                           
wire             seip_acc_en;                    
wire             seip_deleg_vld;                 
wire             seip_en;                        
wire             seip_nodeleg_vld;               
wire             seip_upd_val;                   
wire             sepc_local_en;                  
wire    [63 :0]  sepc_value;                     
wire    [63 :0]  shcr_value;                     
wire             shpmcr_local_en;                
wire             sie_local_en;                   
wire    [63 :0]  sie_value;                      
wire             sip_local_en;                   
wire    [63 :0]  sip_value;                      
wire             sscratch_local_en;              
wire             ssip;                           
wire             ssip_acc_en;                    
wire             ssip_deleg_vld;                 
wire             ssip_en;                        
wire             ssip_nodeleg_vld;               
wire             ssip_upd_val;                   
wire             sstatus_local_en;               
wire             sstatus_spp;                    
wire    [63 :0]  sstatus_value;                  
wire             stip;                           
wire             stip_acc_en;                    
wire             stip_deleg_vld;                 
wire             stip_en;                        
wire             stip_nodeleg_vld;               
wire             stip_upd_val;                   
wire             stval_local_en;                 
wire    [63 :0]  stval_upd_data;                 
wire    [63 :0]  stval_value;                    
wire             stvec_local_en;                 
wire    [63 :0]  stvec_value;                    
wire    [1  :0]  sxl;                            
wire             sxstatus_local_en;              
wire    [63 :0]  sxstatus_value;                 
wire             tee_ff;                         
wire             tee_lock;                       
wire             ucnt_addr_hit;                  
wire    [1  :0]  uxl;                            
wire             v;                              
wire             ve;                             
wire             vec_clk;                        
wire             vec_clk_en;                     
wire    [63 :0]  vl_value;                       
wire    [7  :0]  vl_vl;                          
wire    [63 :0]  vlenb_value;                                              
wire             vs_dirty_upd;                   
wire    [63 :0]  vsstatus_value;                 
wire             vstart_local_en;                
wire    [63 :0]  vstart_value;                   
wire    [6  :0]  vstart_vstart;                  
wire    [63 :0]  vtype_value;                    
wire             vtype_vill;                     
wire    [1  :0]  vtype_vlmul;                    
wire    [2  :0]  vtype_vsew;                     
wire             vxrm_local_en;                  
wire    [63 :0]  vxrm_value;                     
wire             vxsat_local_en;                 
wire    [63 :0]  vxsat_value;                    
wire             wb;                             
wire             wbr;                            
wire    [1  :0]  xs;                             
wire             ipi_expt_vld;                            
wire             iui_ipi_set_val;                            
wire             iui_ipi_set_vld;                            


//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign regs_clk_en = iui_regs_sel
                  || idu_cp0_fesr_acc_updt_vld;
// &Instance("gated_clk_cell", "x_regs_gated_clk"); @34
gated_clk_cell  x_regs_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (regs_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (regs_clk_en       ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @35
//          .external_en (1'b0), @36
//          .global_en   (cp0_yy_clk_en), @37
//          .module_en   (regs_xx_icg_en), @38
//          .local_en    (regs_clk_en), @39
//          .clk_out     (regs_clk)); @40

assign vec_clk_en = vstart_local_en
                 || rtu_cp0_vstart_vld
                 || rtu_cp0_vsetvl_vl_vld
                 || rtu_cp0_vsetvl_vtype_vld;
// &Instance("gated_clk_cell", "x_vec_gated_clk"); @46
gated_clk_cell  x_vec_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vec_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (vec_clk_en        ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @47
//          .external_en (1'b0), @48
//          .global_en   (cp0_yy_clk_en), @49
//          .module_en   (regs_xx_icg_en), @50
//          .local_en    (vec_clk_en), @51
//          .clk_out     (vec_clk)); @52

assign regs_flush_clk_en = rtu_yy_xx_flush || iui_regs_sel
                        || rtu_cp0_expt_gateclk_vld
                        || !regs_iui_cins_no_op
                        || cfr_bits_done
                        || iui_regs_inst_mret
                        || iui_regs_inst_ertn
                        || iui_regs_inst_sret
                        || iui_regs_inv_expt
                        || iui_regs_ex3_inst_csr
                        || fs_dirty_upd
                        || vs_dirty_upd
                        || rst_sample
                        || ifu_cp0_rst_inv_req
                        || tee_ff
                          ;
// &Instance("gated_clk_cell", "x_regs_flush_gated_clk"); @68
gated_clk_cell  x_regs_flush_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (regs_flush_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (regs_flush_clk_en ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @69
//          .external_en (1'b0), @70
//          .global_en   (cp0_yy_clk_en), @71
//          .module_en   (regs_xx_icg_en), @72
//          .local_en    (regs_flush_clk_en), @73
//          .clk_out     (regs_flush_clk)); @74

// &Instance("gated_clk_cell", "x_cp0_cdata_gated_clk"); @76
gated_clk_cell  x_cp0_cdata_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (cdata_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (cins_r            ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in(forever_cpuclk), @77
//          .global_en(cp0_yy_clk_en), @78
//          .module_en   (regs_xx_icg_en), @79
//          .local_en(cins_r), @80
//          .external_en(1'b0), @81
//          .clk_out(cdata_clk)); @82

// CSR list in LA C910
parameter ARCH      = 12'hFFF;
parameter CRMD      = 12'h0;
parameter PRMD      = 12'h1;
parameter EUEN      = 12'h2;
parameter MISC      = 12'h3;
parameter ECFG      = 12'h4;
parameter ESTAT     = 12'h5;
parameter ERA       = 12'h6;
parameter BADV      = 12'h7;
parameter BADI      = 12'h8;
parameter EENTRY    = 12'hc;

parameter TLBIDX    = 12'h10;
parameter TLBEHI    = 12'h11;
parameter TLBELO0   = 12'h12;
parameter TLBELO1   = 12'h13;
parameter ASID      = 12'h18;
parameter PGDL      = 12'h19;
parameter PGDH      = 12'h1a;
parameter PGD       = 12'h1b;

parameter PWCL      = 12'h1c;
parameter PWCH      = 12'h1d;
parameter STLBPS    = 12'h1e;
parameter RVACFG    = 12'h1f;

parameter CPUID     = 12'h20;
parameter PRCFG1    = 12'h21;
parameter PRCFG2    = 12'h22;
parameter PRCFG3    = 12'h23;
parameter SAVE0     = 12'h30;
parameter SAVE1     = 12'h31;
parameter SAVE2     = 12'h32;
parameter SAVE3     = 12'h33;
parameter TID       = 12'h40;
parameter TCFG      = 12'h41;
parameter TVAL      = 12'h42;
parameter CNTC      = 12'h43;
parameter TICLR     = 12'h44;
parameter LLBCTL    = 12'h60;

parameter IMPCTL1   = 12'h80;
parameter IMPCTL2   = 12'h81;

parameter TLBRENTRY = 12'h88;
parameter TLBREHI   = 12'h8E;

parameter MERRENTRY = 12'h93;
parameter DMW0      = 12'h180;
parameter DMW1      = 12'h181;
parameter DMW2      = 12'h182;
parameter DMW3      = 12'h183;
parameter BRK       = 12'h100;
parameter DIS_CACHE = 12'h101;

parameter DEBUG0    = 12'h130;
parameter DEBUG1    = 12'h131;
parameter DGWDUMP   = 12'h132;
parameter CPRS      = 12'h133;
parameter CPRS_CRMD = 12'h12f;
parameter CPRS_TCFG = 12'h134;

parameter DEBUG2    = 12'h135;
parameter DEBUG3    = 12'h136;
parameter DEBUG4    = 12'h137;
parameter DEBUG5    = 12'h138;
parameter DEBUG6    = 12'h139;
parameter DEBUG7    = 12'h13a;

parameter PERFCTRL0 = 12'h200;
parameter PERFCNTR0 = 12'h201;
parameter PERFCTRL1 = 12'h202;
parameter PERFCNTR1 = 12'h203;
parameter PERFCTRL2 = 12'h204;
parameter PERFCNTR2 = 12'h205;
parameter PERFCTRL3 = 12'h206;
parameter PERFCNTR3 = 12'h207;
parameter PERFCTRL4 = 12'h208;
parameter PERFCNTR4 = 12'h209;
parameter PERFCTRL5 = 12'h20a;
parameter PERFCNTR5 = 12'h20b;
parameter PERFCTRL6 = 12'h20c;
parameter PERFCNTR6 = 12'h20d;

parameter MWPC      = 12'h300;
parameter MWPS      = 12'h301;
parameter FWPC      = 12'h380;
parameter FWPS      = 12'h381;

parameter IFUC      = 12'h550;
parameter CACC      = 12'h551;
parameter MSCC      = 12'h552;

// LA User Floating-Point CSRs
parameter FCSR0     = 12'hF00;
parameter FCSR1     = 12'hF01;
parameter FCSR2     = 12'hF02;
parameter FCSR3     = 12'hF03;


parameter IPISS     = 16'h1000;
parameter IPIEN     = 16'h1004;
parameter IPIST     = 16'h1008;
parameter IPICL     = 16'h100c;
parameter MABOX0    = 16'h1020;
parameter MABOX1    = 16'h1028;
parameter MABOX2    = 16'h1030;
parameter MABOX3    = 16'h1038;
parameter IPISEND   = 16'h1040;
parameter MAILSEND  = 16'h1048;

//==========================================================
//                       RISCV CSR CODE
//==========================================================
/// TODO:
// User Floating-Point CSRs
parameter FFLAGS    = 12'h101;
parameter FRM       = 12'h102;
parameter FCSR      = 12'h103;
parameter VSTART    = 12'h108;
parameter VXSAT     = 12'h109;
parameter VXRM      = 12'h10A;

parameter MHPMCR    = 12'h7F0;
parameter VL        = 12'hC20;
parameter VTYPE     = 12'hC21;
parameter VLENB     = 12'hC22;

// C-SKY Extension CSRs
// Processor Control and Status Extension; M-Mode
parameter MXSTATUS  = 12'h7C0;
parameter MHCR      = 12'h7C1;
parameter MCOR      = 12'h7C2;
parameter MCCR2     = 12'h7C3;
parameter MCER2     = 12'h7C4;
parameter MHINT     = 12'h7C5;
parameter MRMR      = 12'h7C6;
parameter MRVBR     = 12'h7C7;
parameter MCER      = 12'h7C8;
parameter MCNTWEN   = 12'h7C9;
parameter MCNTINTEN = 12'h7CA;
parameter MCNTOF    = 12'h7CB;
parameter MHINT2    = 12'h7CC;
parameter MHINT3    = 12'h7CD;
parameter MHINT4    = 12'h7CE;

parameter MSMPR     = 12'h7F3;
parameter MTEECFG   = 12'h7F4;

// Processor Control and Status Extension; M-Mode
parameter MCINS     = 12'h7D2;
parameter MCINDEX   = 12'h7D3;
parameter MCDATA0   = 12'h7D4;
parameter MCDATA1   = 12'h7D5;
parameter MEICR     = 12'h7D6;
parameter MEICR2    = 12'h7D7;

// Processor ID Extension; M-Mode
parameter MCPUID    = 12'hFC0;
parameter MAPBADDR  = 12'hFC1;
parameter MWMSR     = 12'hFC2;

// Processor Control and Status Extension; S-Mode
parameter SXSTATUS  = 12'h5C0;
parameter SHCR      = 12'h5C1;
parameter SCER2     = 12'h5C2;
parameter SCER      = 12'h5C3;
parameter SCNTINTEN = 12'h5C4;
parameter SCNTOF    = 12'h5C5;
parameter SHINT     = 12'h5C6;
parameter SHINT2    = 12'h5C7;
parameter SCNTIHBT  = 12'h5C8;
parameter SHPMCR    = 12'h5C9;
parameter SHPMSP    = 12'h5CA;
parameter SHPMEP    = 12'h5CB;

// TLB Operation Extension; S-Mode
parameter SMIR      = 12'h9C0;
parameter SMEL      = 12'h9C1;
parameter SMEH      = 12'h9C2;
parameter SMCIR     = 12'h9C3;

// Float Point Register Extension; U-Mode
parameter FXCR      = 12'h800;

// 5. Hypervisor Extension CSRs
parameter HSTATUS   = 12'h600;
parameter HEDELEG   = 12'h602;

parameter VSSTATUS  = 12'h200;



//==========================================================
//                    LoongArch CSR
//==========================================================
//==========================================================
//              Generate Local Signal to CSRs
//==========================================================
assign arch_ctrl_local_en  = iui_regs_sel & (iui_regs_addr[11:0] == ARCH);
assign crmd_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == CRMD);
assign prmd_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == PRMD);
assign euen_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == EUEN);
assign misc_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == MISC);
assign ecfg_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == ECFG);
assign estat_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == ESTAT);
assign era_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == ERA);
assign badv_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == BADV);
assign eentry_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == EENTRY);
assign tlbidx_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == TLBIDX);
assign tlbehi_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == TLBEHI);
assign tlbelo0_local_en    = iui_regs_sel & (iui_regs_addr[11:0] == TLBELO0);
assign tlbelo1_local_en    = iui_regs_sel & (iui_regs_addr[11:0] == TLBELO1);
assign asid_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == ASID);
assign pgdl_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == PGDL);
assign pgdh_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == PGDH);
assign pgd_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == PGD);


assign pwcl_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == PWCL);
assign pwch_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == PWCH);
assign stlbps_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == STLBPS);
assign rvacfg_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == RVACFG);

assign cpuid_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == CPUID);
assign save0_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == SAVE0);
assign save1_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == SAVE1);
assign save2_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == SAVE2);
assign save3_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == SAVE3);
assign tid_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == TID);
assign tcfg_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == TCFG);
assign tval_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == TVAL);
assign cntc_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == CNTC);
assign ticlr_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == TICLR);
assign llbctl_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == LLBCTL);

assign impctl1_local_en    = iui_regs_sel & (iui_regs_addr[11:0] == IMPCTL1);
assign impctl2_local_en    = iui_regs_sel & (iui_regs_addr[11:0] == IMPCTL2);

assign tlbrentry_local_en  = iui_regs_sel & (iui_regs_addr[11:0] == TLBRENTRY);
assign tlbrehi_local_en    = iui_regs_sel & (iui_regs_addr[11:0] == TLBREHI);

assign merrentry_local_en  = iui_regs_sel & (iui_regs_addr[11:0] == MERRENTRY);
assign dmw0_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == DMW0);
assign dmw1_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == DMW1);
assign dmw2_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == DMW2);
assign dmw3_local_en       = iui_regs_sel & (iui_regs_addr[11:0] == DMW3);
assign BRK_local_en        = iui_regs_sel & (iui_regs_addr[11:0] == BRK);
assign dis_cache_local_en  = iui_regs_sel & (iui_regs_addr[11:0] == DIS_CACHE);

assign debug0_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG0);
assign debug1_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG1);
assign dgwavedump_local_en = iui_regs_sel & (iui_regs_addr[11:0] == DGWDUMP);
assign cpcsr_local_en      = iui_regs_sel & (iui_regs_addr[11:0] == CPRS);
assign cpcsr_tcfg_local_en = iui_regs_sel & (iui_regs_addr[11:0] == CPRS_TCFG);
assign cpcsr_crmd_local_en = iui_regs_sel & (iui_regs_addr[11:0] == CPRS_CRMD);

assign debug2_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG2);
assign debug3_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG3);
assign debug4_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG4);
assign debug5_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG5);
assign debug6_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG6);
assign debug7_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == DEBUG7);

assign mwpc_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == MWPC);
assign mwps_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == MWPS);
assign fwpc_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == FWPC);
assign fwps_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == FWPS);

assign ifuc_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == IFUC);
assign cacc_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == CACC);
assign mscc_local_en     = iui_regs_sel & (iui_regs_addr[11:0] == MSCC);

assign fcsr0_local_en = iui_regs_sel & (iui_regs_addr[11:0] == FCSR0);
assign fcsr1_local_en = iui_regs_sel & (iui_regs_addr[11:0] == FCSR1);
assign fcsr2_local_en = iui_regs_sel & (iui_regs_addr[11:0] == FCSR2);
assign fcsr3_local_en = iui_regs_sel & (iui_regs_addr[11:0] == FCSR3);


/// float point
assign fflags_local_en     = iui_regs_sel && iui_regs_addr[11:0] == FFLAGS;       
assign frm_local_en        = iui_regs_sel && iui_regs_addr[11:0] == FRM;  
assign fcsr_local_en       = iui_regs_sel && iui_regs_addr[11:0] == FCSR;  
assign vstart_local_en     = iui_regs_sel && iui_regs_addr[11:0] == VSTART;  
assign vxsat_local_en      = iui_regs_sel && iui_regs_addr[11:0] == VXSAT;  
assign vxrm_local_en       = iui_regs_sel && iui_regs_addr[11:0] == VXRM;  


/// extension
assign mxstatus_local_en   = iui_regs_sel && iui_regs_addr[11:0] == MXSTATUS;
assign mhcr_local_en       = iui_regs_sel && iui_regs_addr[11:0] == MHCR;       
assign mcor_local_en       = iui_regs_sel && iui_regs_addr[11:0] == MCOR;     
assign mhint_local_en      = iui_regs_sel && iui_regs_addr[11:0] == MHINT;
assign mhint2_local_en     = iui_regs_sel && iui_regs_addr[11:0] == MHINT2;
assign mhint3_local_en     = iui_regs_sel && iui_regs_addr[11:0] == MHINT3;
assign mhint4_local_en     = iui_regs_addr[11:0] == MHINT4;
assign mhpmcr_local_en     = iui_regs_sel && iui_regs_addr[11:0] == MHPMCR;
assign msmpr_local_en      = iui_regs_addr[11:0] == MSMPR;  
assign mteecfg_local_en    = 1'b0;
assign mcntwen_local_en    = iui_regs_sel && iui_regs_addr[11:0] == MCNTWEN;
assign mccr2_local_en      = iui_regs_addr[11:0] == MCCR2;      
assign mcer2_local_en      = iui_regs_addr[11:0] == MCER2;     
assign meicr2_local_en     = iui_regs_addr[11:0] == MEICR2;
assign mcins_local_en      = iui_regs_sel && iui_regs_addr[11:0] == MCINS;       
assign mcindex_local_en    = iui_regs_sel && iui_regs_addr[11:0] == MCINDEX;     
assign mcpuid_local_en     = iui_regs_addr[11:0] == MCPUID;
assign sxstatus_local_en   = iui_regs_sel && iui_regs_addr[11:0] == SXSTATUS;     
assign scer2_local_en      = iui_regs_addr[11:0] == SCER2;     
assign fxcr_local_en       = iui_regs_sel && iui_regs_addr[11:0] == FXCR;  
assign shpmcr_local_en     = iui_regs_sel && iui_regs_addr[11:0] == SHPMCR;


//==========================================================
//                      Arch Control Registers
//==========================================================
reg [63:0] arch_ctrl;

// default arch_ctrl[0] is 0, stands for LoongArch 
// arch_ctrl[0] = 1, use RISCV

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    arch_ctrl[63:0]  <= 64'b0;
  end  
  else if(arch_ctrl_local_en) begin
    arch_ctrl[0]  <= iui_regs_src0[0];
  end
  else begin
    arch_ctrl[63:0]  <= arch_ctrl[63:0];
  end
end

wire [63:0] csrarch_value;

assign csrarch_value[63:0] = arch_ctrl[63:0];

assign cp0_xx_core_arch = arch_ctrl[0];


//==========================================================
//                 1. Machine Level CSRs
//==========================================================



//==========================================================
//               Machine Information Registers
//==========================================================

wire [63:0] cpuid_value;
assign cpuid_value[63:0] = {61'b0, biu_cp0_coreid[2:0]};


//==========================================================
//                      CRMD Registers
//==========================================================
reg [1:0] crmd_plv;
reg [1:0] prmd_pplv;
reg crmd_ie;
reg prmd_pie;
reg crmd_we;
reg prmd_pwe;


always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    crmd_plv  <= 2'b0;
    crmd_ie   <= 1'b0;
  end  
  else if(rtu_cp0_expt_vld) begin
    crmd_plv  <= 2'b0;
    crmd_ie   <= 1'b0;
  end
  else if(iui_regs_inst_ertn) begin
    crmd_plv  <= prmd_pplv;
    crmd_ie   <= prmd_pie;
  end

`ifdef CPU_CHECKPOINT
  else if(cp0_cprs) begin
    crmd_plv  <= cpcsr_crmd_value[1:0];
    crmd_ie   <= cpcsr_crmd_value[2];
  end
`endif

  else if(crmd_local_en) begin
    crmd_plv  <= iui_regs_src0[1:0];
    crmd_ie   <= iui_regs_src0[2];
  end
  else begin
    crmd_plv  <= crmd_plv;
    crmd_ie   <= crmd_ie;
  end
end




reg [1:0] crmd_datf;
reg [1:0] crmd_datm;
reg crmd_da;
reg crmd_pg;


reg [1:0] csr_errctl_pdatf;
reg [1:0] csr_errctl_pdatm;
reg csr_errctl_pda;
reg csr_errctl_ppg;


wire csr_errctl_ismerr = 1'b0;


always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    crmd_da   <= 1'b1;
    crmd_pg   <= 1'b0;
    crmd_datf <= 2'b0;
    crmd_datm <= 2'b0;
  end
  /// NOTING: expt not clear da pg
  // else if(rtu_cp0_expt_vld) begin
  //   crmd_da   <= 1'b1;
  //   crmd_pg   <= 1'b0;
  //   crmd_datf <= 2'b0;
  //   crmd_datm <= 2'b0;
  // end
  else if(csr_errctl_ismerr) begin
    crmd_da   <= csr_errctl_pda;
    crmd_pg   <= csr_errctl_ppg;
    crmd_datf <= csr_errctl_pdatf;
    crmd_datm <= csr_errctl_pdatm;
  end
  else if(crmd_local_en) begin
    crmd_da   <= iui_regs_src0[3];
    crmd_pg   <= iui_regs_src0[4];
    crmd_datf <= iui_regs_src0[6:5];
    crmd_datm <= iui_regs_src0[8:7];
  end
`ifdef CPU_CHECKPOINT
  else if(cp0_cprs) begin
    crmd_da   <= cpcsr_crmd_value[3];
    crmd_pg   <= cpcsr_crmd_value[4];
    crmd_datf <= cpcsr_crmd_value[6:5];
    crmd_datm <= cpcsr_crmd_value[8:7];
  end
`endif
  else begin
    crmd_da   <= crmd_da;
    crmd_pg   <= crmd_pg;
    crmd_datf <= crmd_datf;
    crmd_datm <= crmd_datm;
  end
end



reg csr_errctl_pwe;
reg csr_tlbrprmd_pwe;
wire csr_tlbrera_istlbr = 1'b0;


always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    crmd_we   <= 1'b0;
  else if(rtu_cp0_expt_vld)
    crmd_we   <= 1'b0;
  else if(csr_errctl_ismerr)
    crmd_we   <= csr_errctl_pwe;
  else if(iui_regs_inst_ertn)
    crmd_we   <= prmd_pwe;
  else if(csr_tlbrera_istlbr)
    crmd_we   <= csr_tlbrprmd_pwe;
`ifdef CPU_CHECKPOINT
  else if(cp0_cprs) begin
    crmd_we   <= cpcsr_crmd_value[9];
  end
`endif
  else if(crmd_local_en)
    crmd_we   <= iui_regs_src0[9];
  else
    crmd_we   <= crmd_we;
end


wire [63:0] csrcrmd_value;
assign csrcrmd_value[63:0]  = {{54{1'b0}}, crmd_we, crmd_datm, crmd_datf, crmd_pg, crmd_da,
                              crmd_ie, crmd_plv};



//==========================================================
//                      PRMD Registers
//==========================================================

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    prmd_pplv  <= 2'b0;
    prmd_pie   <= 1'b0;
    prmd_pwe   <= 1'b0;
  end  
  else if(rtu_cp0_expt_vld) begin
    prmd_pplv  <= crmd_plv;
    prmd_pie   <= crmd_ie;
    prmd_pwe   <= crmd_we;
  end
  else if(iui_regs_inst_ertn) begin
    prmd_pplv  <= 2'b0;
    prmd_pie   <= 1'b0;
    prmd_pwe   <= 1'b0;
  end
  else if(prmd_local_en) begin
    prmd_pplv  <= iui_regs_src0[1:0];
    prmd_pie   <= iui_regs_src0[2];
    prmd_pwe   <= iui_regs_src0[3];
  end
  else begin
    prmd_pplv  <= prmd_pplv;
    prmd_pie   <= prmd_pie;
    prmd_pwe   <= prmd_pwe;
  end
end


wire [63:0] csrprmd_value;
assign csrprmd_value[63:0]  = {{60{1'b0}}, prmd_pwe, prmd_pie, prmd_pplv};



//==========================================================
//                      EUEN Registers
//==========================================================
reg fpe;
reg sxe;
reg asxe;
reg bte;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    fpe   <= 1'b0;
    sxe   <= 1'b0;
    asxe  <= 1'b0;
    bte   <= 1'b0;
  end
  else if(euen_local_en) begin
    fpe   <= iui_regs_src0[0];
    sxe   <= iui_regs_src0[1];
    asxe  <= iui_regs_src0[2];
    bte   <= iui_regs_src0[3];
  end
  else begin
    fpe   <= fpe;
    sxe   <= sxe;
    asxe  <= asxe;
    bte   <= bte;
  end  
end


wire [63:0] csreuen_value;
assign csreuen_value[63:0]  = {{60{1'b0}}, bte, asxe, sxe, fpe};


//==========================================================
//                      MISC Registers
//==========================================================
reg va32l1;
reg va32l2;
reg va32l3;
reg drdtl1;
reg drdtl2;
reg drdtl3;
reg rpcntl1;
reg rpcntl2;
reg rpcntl3;
reg alcl0;
reg alcl1;
reg alcl2;
reg alcl3;
reg dwpl0;
reg dwpl1;
reg dwpl2;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    va32l1   <= 1'b0;
    va32l2   <= 1'b0;
    va32l3   <= 1'b0;    
    drdtl1   <= 1'b0;
    drdtl2   <= 1'b0;
    drdtl3   <= 1'b0;    
    rpcntl1  <= 1'b0;
    rpcntl2  <= 1'b0;
    rpcntl3  <= 1'b0;    
    alcl0    <= 1'b0;
    alcl1    <= 1'b0;
    alcl2    <= 1'b0;
    alcl3    <= 1'b0;
    dwpl0    <= 1'b0;
    dwpl1    <= 1'b0;
    dwpl2    <= 1'b0;
  end
  else if(misc_local_en) begin
    va32l1   <= iui_regs_src0[1];
    va32l2   <= iui_regs_src0[2];
    va32l3   <= iui_regs_src0[3];
    drdtl1   <= iui_regs_src0[5];
    drdtl2   <= iui_regs_src0[6];
    drdtl3   <= iui_regs_src0[7];
    rpcntl1  <= iui_regs_src0[9];
    rpcntl2  <= iui_regs_src0[10];
    rpcntl3  <= iui_regs_src0[11];
    alcl0    <= iui_regs_src0[12];
    alcl1    <= iui_regs_src0[13];
    alcl2    <= iui_regs_src0[14];
    alcl3    <= iui_regs_src0[15];
    dwpl0    <= iui_regs_src0[16];
    dwpl1    <= iui_regs_src0[17];
    dwpl2    <= iui_regs_src0[18];
  end
  else begin
    va32l1   <= va32l1;
    va32l2   <= va32l2;
    va32l3   <= va32l3;
    drdtl1   <= drdtl1;
    drdtl2   <= drdtl2;
    drdtl3   <= drdtl3;
    rpcntl1  <= rpcntl1;
    rpcntl2  <= rpcntl2;
    rpcntl3  <= rpcntl3;
    alcl0    <= alcl0;
    alcl1    <= alcl1;
    alcl2    <= alcl2;
    alcl3    <= alcl3;
    dwpl0    <= dwpl0;
    dwpl1    <= dwpl1;
    dwpl2    <= dwpl2;
  end  
end


wire [63:0] csrmisc_value;
assign csrmisc_value[63:0]  = {{48{1'b0}}, dwpl2, dwpl1, dwpl0,
                                           alcl3, alcl2, alcl1, alcl0,
                                           rpcntl3, rpcntl2, rpcntl1,
                                           drdtl3, drdtl2, drdtl1,
                                           va32l3, va32l2, va32l1 };

//==========================================================
//               Define the ERA register
//  Machine Exception PC Register
//  64-bit Machine Mode Read/Write
//  Providing the Machine Exception PC Register
//  the definiton for MEPC register is listed as follows
//==========================================================

reg [63:0] csrera;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    csrera[63:0] <= 64'b0;
  else if(rtu_cp0_expt_vld)
    csrera[63:0] <= rtu_cp0_epc[63:0];
  else if(era_local_en)
    csrera[63:0] <= iui_regs_src0[63:0];
  else
    csrera[63:0] <= csrera[63:0];
end

wire [63:0] csrera_value;
assign csrera_value[63:0]  = csrera[63:0];

//==========================================================
//               Define the EENTRY register
//  Machine Exception PC Register
//  64-bit Machine Mode Read/Write
//  Providing the Machine Exception PC Register
//  the definiton for MEPC register is listed as follows
//==========================================================
reg [63:0] csreentry;
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    csreentry[63:0] <= 64'b0;
  else if(eentry_local_en)
    csreentry[63:0] <= iui_regs_src0[63:0];
  else
    csreentry[63:0] <= csreentry[63:0];
end

wire [63:0] csreentry_value;
assign csreentry_value[63:0]  = csreentry[63:0];


//==========================================================
//                      ECFG Registers
//==========================================================
reg [12:0] lie;
reg [2:0]  vs;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    lie[12:0]   <= 13'b0;
    vs[2:0]     <= 3'b0;
  end
  else if(ecfg_local_en) begin
    lie[12:0]   <= iui_regs_src0[12:0];
    vs[2:0]     <= iui_regs_src0[18:16];
  end
  else begin
    lie[12:0]   <= lie[12:0];
    vs[2:0]     <= vs[2:0];
  end  
end


wire [63:0] csrecfg_value;
assign csrecfg_value[63:0]  = {{45{1'b0}}, vs[2:0], 3'b0, lie[12:0]};

wire [2:0] ecfg_vs = vs[2:0];
//==========================================================
//                      ESTAT Registers
//==========================================================

// is[7:0] : External interrupt
// is[8]   : Performance monitor
// is[9]   : Timer 
// is[10]  : IPI

// Softeware Interrupt
reg [1 : 0]  swis;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    swis[1:0]  <= 2'b0;
  end
  else if(estat_local_en) begin
    swis[1:0]  <= iui_regs_src0[1:0];
  end
  else begin
    swis[1:0]  <= swis[1:0];
  end
end

// External interrupt
reg [7 : 0]  sample_interrupts;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    sample_interrupts[7:0]  <= 8'b0;
  end
  else begin
    sample_interrupts[7:0]  <= ext_interrupt[7:0];
  end
end


reg [7:0] ext_is;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ext_is[7:0]  <= 8'b0;
  end
  else if(estat_local_en) begin
    ext_is[7:0]  <= iui_regs_src0[7:0];
  end
  else begin
    ext_is[7:0]   <= sample_interrupts[7:0];
  end
end

// Performance monitor
reg perfm_is;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    perfm_is  <= 1'b0;
  end
  else if(estat_local_en) begin
    perfm_is  <= iui_regs_src0[8];
  end
  else begin
    perfm_is  <= hpcp_cp0_int_vld;
  end
end

// Timer
reg timer_is;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    timer_is  <= 1'b0;
  end
  else if(estat_local_en) begin
    timer_is  <= iui_regs_src0[9];
  end
  else if(timer_clr) begin
    timer_is  <= 1'b0;
  end
  else if(tcfg_en && (csrtval_value == 64'h0)) begin
    timer_is  <= 1'b1;
  end
  else begin
    timer_is  <= timer_is;
  end
end

// IPI
reg ipi_is;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ipi_is  <= 1'b0;
  end
  else if(ipi_expt_vld) begin
    ipi_is  <= ipi_expt_vld;
  end
  else if(iui_ipi_set_vld) begin
    ipi_is  <= iui_ipi_set_val;
  end
  else if(estat_local_en) begin
    ipi_is  <= iui_regs_src0[10];
  end
  else begin
    ipi_is  <= ipi_is;
  end
end


reg [5 : 0]  ecode;
reg [8 : 0]  subecode;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ecode[5:0]      <= 6'b0;
    subecode[8:0]   <= 9'b0;
  end
  else if(rtu_cp0_expt_vld) begin
    ecode[5:0]      <= rtu_yy_xx_expt_vec[5:0];
    subecode[8:0]   <= rtu_yy_xx_expt_vec[14:6];
  end
  else if(estat_local_en) begin
    ecode[5:0]      <= iui_regs_src0[21:16];
    subecode[8:0]   <= iui_regs_src0[30:22];
  end
  else begin
    ecode[5:0]      <= ecode[5:0];
    subecode[8:0]   <= subecode[8:0];
  end
end


wire [63:0] csrestat_value;
wire msgint;

assign msgint = 0;

assign csrestat_value[63:0]  = {{33{1'b0}}, 
                                subecode[8:0], 
                                ecode[5:0], 
                                msgint, 
                                2'b00, 
                                ipi_is,
                                timer_is,
                                perfm_is,
                                ext_is[7:0], 
                                swis[1:0]};


wire [12:0] csr_except_pending;

assign csr_except_pending[12:0]  =  {ipi_is, timer_is, perfm_is, ext_is[7:0], swis[1:0]} & lie[12:0];

assign int_sel[14:0] = {15{crmd_ie}} & {2'b00, ipi_is, timer_is, perfm_is, ext_is[7:0], swis[1:0]} & {2'b0, lie[12:0]};


//==========================================================
//               Define the BADV register
//==========================================================
assign mtval_upd_data[63:0] = rtu_cp0_expt_vld ? rtu_cp0_expt_mtval[63:0]
                                               : {32'b0, iui_regs_opcode[31:0]};


reg [63:0] badv;                                                                                            
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    badv[63:0] <= 64'b0;
  else if(rtu_cp0_expt_vld || iui_regs_inv_expt) 
    badv[63:0] <= mtval_upd_data[63:0];
  else if(badv_local_en)
    badv[63:0] <= iui_regs_src0[63:0];
  else
    badv[63:0] <= badv[63:0];
end

wire [63:0] csrbadv_value;
assign csrbadv_value[63:0] = badv[63:0];


//==========================================================
//               Define the BADI register
//==========================================================
reg [63:0] badi;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    badi[63:0] <= 64'b0;
  else if(rtu_cp0_expt_vld || iui_regs_inv_expt) 
    badi[63:0] <= mtval_upd_data[63:0];
  else if(badv_local_en)
    badi[63:0] <= iui_regs_src0[63:0];
  else
    badi[63:0] <= badi[63:0];
end

wire [63:0] csrbadi_value;
assign csrbadi_value[63:0] = badi[63:0];



//==========================================================
//               Define the ASID register
//==========================================================
reg [9:0] asid;
wire [7:0] asidbits = 8'd10;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    asid[9:0] <= 10'b0;
  else if(asid_local_en)
    asid[9:0] <= iui_regs_src0[9:0];
  else
    asid[9:0] <= asid[9:0];
end

wire [63:0] asid_value;
assign asid_value[63:0] = {{32'b0}, {8'b0}, asidbits, {6'b0}, asid};

//==========================================================
//               Define the PGDL register
//==========================================================
reg [63:0] pgdl;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pgdl[63:0] <= 64'b0;
  else if(pgdl_local_en)
    pgdl[63:0] <= {iui_regs_src0[63:12], {12{1'b0}}};
  else
    pgdl[63:0] <= pgdl[63:0];
end

wire [63:0] csrpgdl_value;
assign csrpgdl_value[63:0] = pgdl[63:0];



//==========================================================
//               Define the PGDH register
//==========================================================
reg [63:0] pgdh;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pgdh[63:0] <= 64'b0;
  else if(pgdh_local_en)
    pgdh[63:0] <= {iui_regs_src0[63:12], {12{1'b0}}};
  else
    pgdh[63:0] <= pgdh[63:0];
end

wire [63:0] csrpgdh_value;
assign csrpgdh_value[63:0] = pgdh[63:0];


//==========================================================
//               Define the TLBIDX register
//==========================================================
reg [15:0] tlb_index;  
reg [5 :0] tlb_ps;  
reg        tlb_ne;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tlb_index <= 16'b0;
    tlb_ps    <= 6'hc;
    tlb_ne    <= 1'b0;
  end
  else if(tlbidx_local_en) begin
    tlb_index <= iui_regs_src0[15:0];
    tlb_ps    <= iui_regs_src0[29:24];
    tlb_ne    <= iui_regs_src0[31]; 
  end
  else begin
    tlb_index <= tlb_index;
    tlb_ps    <= tlb_ps;
    tlb_ne    <= tlb_ne; 
  end
end

wire [63:0] csrtlbidx_value;
assign csrtlbidx_value[63:0] = {{32'b0}, tlb_ne, 1'b0, tlb_ps, 8'b0, tlb_index};

//==========================================================
//               Define the TLBEHI register
//==========================================================
reg [60:0] tlb_ehi;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tlb_ehi <= 16'b0;
  end
  else if(tlbehi_local_en) begin
    tlb_ehi <= iui_regs_src0[63:13];
  end
  else begin
    tlb_ehi <= tlb_ehi;
  end
end

wire [63:0] csrtlbehi_value;
assign csrtlbehi_value[63:0] = {tlb_ehi[60:0], 13'b0};


//==========================================================
//               Define the TLBELO0 register
//==========================================================
reg [63:0] tlb_elo0;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tlb_elo0 <= 16'b0;
  end
  else if(tlbelo0_local_en) begin
    tlb_elo0 <= iui_regs_src0[63:0];
  end
  else begin
    tlb_elo0 <= tlb_elo0;
  end
end

wire [63:0] csrtlbelo0_value;
assign csrtlbelo0_value[63:0] = tlb_elo0[63:0];


//==========================================================
//               Define the TLBELO1 register
//==========================================================
reg [63:0] tlb_elo1;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tlb_elo1 <= 16'b0;
  end
  else if(tlbelo1_local_en) begin
    tlb_elo1 <= iui_regs_src0[63:0];
  end
  else begin
    tlb_elo1 <= tlb_elo1;
  end
end

wire [63:0] csrtlbelo1_value;
assign csrtlbelo1_value[63:0] = tlb_elo1[63:0];


//==========================================================
//               Define the PWCL register
//==========================================================
reg [4:0] ptbase;
reg [4:0] ptwidth;
reg [4:0] dir1_base;
reg [4:0] dir1_width;
reg [4:0] dir2_base;
reg [4:0] dir2_width;
reg [1:0] ptewidth;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ptbase      <= 5'd12;
    ptwidth     <= 5'd9;
    dir1_base   <= 5'd21;
    dir1_width  <= 5'd9;
    dir2_base   <= 5'd30;
    dir2_width  <= 5'd9;
    ptewidth    <= 2'd0;
  end
  else if(pwcl_local_en) begin
    ptbase      <= iui_regs_src0[4:0];
    ptwidth     <= iui_regs_src0[9:5];
    dir1_base   <= iui_regs_src0[14:10];
    dir1_width  <= iui_regs_src0[19:15];
    dir2_base   <= iui_regs_src0[24:20];
    dir2_width  <= iui_regs_src0[29:25];
    ptewidth    <= iui_regs_src0[31:30];
  end
  else begin
    ptbase      <= ptbase;
    ptwidth     <= ptwidth;
    dir1_base   <= dir1_base;
    dir1_width  <= dir1_width;
    dir2_base   <= dir2_base;
    dir2_width  <= dir2_width;
    ptewidth    <= ptewidth;
  end
end

wire [63:0] csrpwcl_value;
assign csrpwcl_value[63:0] = {{32'b0}, ptewidth, dir2_width, dir2_base, dir1_width, dir1_base, ptwidth, ptbase};


//==========================================================
//               Define the PWCH register
//==========================================================
reg [5:0] dir3_base;
reg [5:0] dir3_width;
reg [5:0] dir4_base;
reg [5:0] dir4_width;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    dir3_base   <= 6'd39;
    dir3_width  <= 6'd0;
    dir4_base   <= 6'd48;
    dir4_width  <= 6'd0;
  end
  else if(pwch_local_en) begin
    dir3_base   <= iui_regs_src0[5 : 0];
    dir3_width  <= iui_regs_src0[11: 6];
    dir4_base   <= iui_regs_src0[17:12];
    dir4_width  <= iui_regs_src0[23:18];
  end
  else begin
    dir3_base   <= dir3_base;
    dir3_width  <= dir3_width;
    dir4_base   <= dir4_base;
    dir4_width  <= dir4_width;
  end
end

wire [63:0] csrpwch_value;
assign csrpwch_value[63:0] = {{40'b0}, dir4_width, dir4_base, dir3_width, dir3_base};


//==========================================================
//               Define the STLBPS register
//==========================================================
reg [5:0] stlbps_ps;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    stlbps_ps   <= 6'd0;
  end
  else if(stlbps_local_en) begin
    stlbps_ps   <= iui_regs_src0[5 : 0];
  end
  else begin
    stlbps_ps   <= stlbps_ps;
  end
end
wire [63:0] csrstlbps_value;
assign csrstlbps_value[63:0] = {{58'b0}, stlbps_ps};


//==========================================================
//               Define the RVACFG register
//==========================================================
reg [3:0] rvacfg_rbits;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    rvacfg_rbits   <= 4'd0;
  end
  else if(rvacfg_local_en) begin
    rvacfg_rbits   <= iui_regs_src0[3 : 0];
  end
  else begin
    rvacfg_rbits   <= rvacfg_rbits;
  end
end

wire [63:0] csrrvacfg_value;
assign csrrvacfg_value[63:0] = {{60'b0}, rvacfg_rbits};


//==========================================================
//               Define the TID register
//==========================================================
reg [63:0] tid;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tid[63:0] <= {61'b0, biu_cp0_coreid[2:0]};
  else if(tid_local_en)
    tid[63:0] <= {iui_regs_src0[63:0]};
  else
    tid[63:0] <= tid[63:0];
end
wire [63:0] csrtid_value;
assign csrtid_value[63:0] = tid[63:0];


//==========================================================
//               Define the TCFG register
//==========================================================

reg        tcfg_periodic;
reg [61:0] tcfg_initval;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tcfg_initval[61:0] <= 62'b0;
    tcfg_periodic      <= 1'b0;
  end
  else if(tcfg_local_en) begin
    tcfg_initval[61:0] <= iui_regs_src0[63:2];
    tcfg_periodic      <= iui_regs_src0[1];
  end

`ifdef CPU_CHECKPOINT
  else if(cpcsr_tcfg_local_en) begin
    tcfg_initval[61:0] <= iui_regs_src0[63:2];
    tcfg_periodic      <= iui_regs_src0[1];
  end
`endif

  else begin
    tcfg_initval[61:0] <= tcfg_initval[61:0];
    tcfg_periodic      <= tcfg_periodic;
  end
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tcfg_en   <= 1'b0;
  end
  else if(tcfg_local_en) begin
    tcfg_en   <= iui_regs_src0[0];
  end

`ifdef CPU_CHECKPOINT
  else if(cpcsr_tcfg_local_en) begin
    tcfg_en   <= iui_regs_src0[0];
  end
`endif

  else if(tcfg_en && (csrtval_value == 64'h0) && !tcfg_periodic) begin
    tcfg_en   <= 1'b0;
  end
  else begin
    tcfg_en   <= tcfg_en;
  end
end

wire [63:0] csrtcfg_value;
assign csrtcfg_value[63:0] = {tcfg_initval, tcfg_periodic, tcfg_en};



//==========================================================
//               Define the TICLR register
//==========================================================

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    timer_clr  <= 1'b0;
  else if(ticlr_local_en)
    timer_clr  <= {iui_regs_src0[0]};
  else if (timer_clr)
    timer_clr  <= 1'b0;
  else
    timer_clr  <= timer_clr;
end
wire [63:0] csrticlr_value;
assign csrticlr_value[63:0] = 64'b0;


//==========================================================
//               Define the TVAL register
//==========================================================
reg [63:0] tval;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tval[63:0] <= 64'h0;
  // when write tcfg, we need update tval
  else if(tcfg_local_en)
    tval[63:0] <= {iui_regs_src0[63:2], {2'b0}};
  else if(tval_local_en)
    tval[63:0] <= {iui_regs_src0[63:2], {2'b0}};
  else if(tcfg_en) begin
      if (tval[63:0] != 64'h0) begin
        tval[63:0] <= tval[63:0] - 1'b1;
      end
      else if (tcfg_periodic) begin
        tval[63:0] <= {tcfg_initval[61:0], {2'b0}};
      end
  end
  else
    tval[63:0] <= tval[63:0];
end

assign csrtval_value[63:0] = tval[63:0];


//==========================================================
//               Define the CNTC register
//==========================================================
reg [63:0] cntc;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cntc[63:0] <= 64'b0;
  else if(cntc_local_en)
    cntc[63:0] <= {iui_regs_src0[63:0]};
  else
    cntc[63:0] <= cntc[63:0];
end
wire [63:0] csrcntc_value;
assign csrcntc_value[63:0] = cntc[63:0];


// //==========================================================
// //               Define the TIMER register
// //==========================================================
// reg [63:0] timer;  
// always @(posedge regs_flush_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b)
//     timer[63:0] <= 64'b0;
//   else
//     timer[63:0] <= timer[63:0] + 1'b1;
// end

// wire [63:0] csrtimer_value; 

// assign csrtimer_value[63:0] = timer[63:0] + cntc[63:0];

// assign cp0_iu_timer[63:0]   = csrtimer_value[63:0];

assign cp0_iu_timer[63:0]   = sysio_core_gl_stable_timer[63:0];

//==========================================================
//               Define the SAVE0 register
//==========================================================
reg [63:0] save0;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    save0[63:0] <= 64'b0;
  else if(save0_local_en)
    save0[63:0] <= {iui_regs_src0[63:0]};
  else
    save0[63:0] <= save0[63:0];
end
wire [63:0] csrsave0_value;
assign csrsave0_value[63:0] = save0[63:0];


//==========================================================
//               Define the SAVE1 register
//==========================================================
reg [63:0] save1;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    save1[63:0] <= 64'b0;
  else if(save1_local_en)
    save1[63:0] <= {iui_regs_src0[63:0]};
  else
    save1[63:0] <= save1[63:0];
end
wire [63:0] csrsave1_value;
assign csrsave1_value[63:0] = save1[63:0];


//==========================================================
//               Define the SAVE2 register
//==========================================================
reg [63:0] save2;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    save2[63:0] <= 64'b0;
  else if(save2_local_en)
    save2[63:0] <= {iui_regs_src0[63:0]};
  else
    save2[63:0] <= save2[63:0];
end
wire [63:0] csrsave2_value;
assign csrsave2_value[63:0] = save2[63:0];


//==========================================================
//               Define the SAVE3 register
//==========================================================
reg [63:0] save3;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    save3[63:0] <= 64'b0;
  else if(save3_local_en)
    save3[63:0] <= {iui_regs_src0[63:0]};
  else
    save3[63:0] <= save3[63:0];
end
wire [63:0] csrsave3_value;
assign csrsave3_value[63:0] = save3[63:0];

//==========================================================
//               Define the IMPCTL1 register
//==========================================================
reg [63:0] impctl1_entry;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    impctl1_entry[63:0] <= 64'b0;
  else if(impctl1_local_en)
    impctl1_entry[63:0] <= {iui_regs_src0[63:0]};
  else
    impctl1_entry[63:0] <= impctl1_entry[63:0];
end
wire [63:0] csrimpctl1_value;
assign csrimpctl1_value[63:0] = impctl1_entry[63:0];



//==========================================================
//               Define the IMPCTL2 register
//==========================================================
reg [63:0] impctl2_entry;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    impctl2_entry[63:0] <= 64'b0;
  else if(impctl2_local_en)
    impctl2_entry[63:0] <= {iui_regs_src0[63:0]};
  else
    impctl2_entry[63:0] <= impctl2_entry[63:0];
end
wire [63:0] csrimpctl2_value;
assign csrimpctl2_value[63:0] = impctl2_entry[63:0];



//==========================================================
//               Define the TLBRENTRY register
//==========================================================
reg [63:0] tlbr_entry;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tlbr_entry[63:0] <= 64'b0;
  else if(tlbrentry_local_en)
    tlbr_entry[63:0] <= {iui_regs_src0[63:12], {12'b0}};
  else
    tlbr_entry[63:0] <= tlbr_entry[63:0];
end
wire [63:0] csrtlbrentry_value;
assign csrtlbrentry_value[63:0] = tlbr_entry[63:0];


//==========================================================
//               Define the TLBREHI register
//==========================================================
reg [5:0] tlbrehi_ps;  
reg [26:0] tlbrehi_vppn; 
reg [23:0] tlbrehi_sign_ext;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    tlbrehi_ps       <= 6'd12;
    tlbrehi_vppn     <= 27'h0;
    tlbrehi_sign_ext <= 24'b0;
  end
  else if(tlbrehi_local_en) begin
    tlbrehi_ps       <= iui_regs_src0[5:0];
    tlbrehi_vppn     <= iui_regs_src0[39:13];
    tlbrehi_sign_ext <= iui_regs_src0[63:40];
  end
  else begin
    tlbrehi_ps       <= tlbrehi_ps;
    tlbrehi_vppn     <= tlbrehi_vppn;
    tlbrehi_sign_ext <= tlbrehi_sign_ext;
  end
end
wire [63:0] csrrehi_value;
assign csrrehi_value[63:0] = {tlbrehi_sign_ext, tlbrehi_vppn, {7'b0}, tlbrehi_ps};


//==========================================================
//               Define the MERRENTRY register
//==========================================================
reg [63:0] merr_entry;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    merr_entry[63:0] <= 64'b0;
  else if(merrentry_local_en)
    merr_entry[63:0] <= {iui_regs_src0[63:12], {12'b0}};
  else
    merr_entry[63:0] <= merr_entry[63:0];
end
wire [63:0] csrmerrentry_value;
assign csrmerrentry_value[63:0] = merr_entry[63:0];


//==========================================================
//               Define the DMW0 register
//==========================================================
reg       dmw0_plv0;  
reg       dmw0_plv1;  
reg       dmw0_plv2;  
reg       dmw0_plv3;  
reg [1:0] dmw0_mat;  
reg [3:0] dmw0_vseg;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    dmw0_plv0      <= 1'b0;
    dmw0_plv1      <= 1'b0;
    dmw0_plv2      <= 1'b0;
    dmw0_plv3      <= 1'b0;
    dmw0_mat[1:0]  <= 2'b0;
    dmw0_vseg[3:0] <= 4'b0;
  end
  else if(dmw0_local_en) begin
    dmw0_plv0      <= iui_regs_src0[0];
    dmw0_plv1      <= iui_regs_src0[1];
    dmw0_plv2      <= iui_regs_src0[2];
    dmw0_plv3      <= iui_regs_src0[3];
    dmw0_mat[1:0]  <= iui_regs_src0[5:4];
    dmw0_vseg[3:0] <= iui_regs_src0[63:60];
  end
  else begin
    dmw0_plv0      <= dmw0_plv0;
    dmw0_plv1      <= dmw0_plv1;
    dmw0_plv2      <= dmw0_plv2;
    dmw0_plv3      <= dmw0_plv3;
    dmw0_mat[1:0]  <= dmw0_mat[1:0];
    dmw0_vseg[3:0] <= dmw0_vseg[3:0];
  end
end
wire [63:0] csrdmw0_value;
assign csrdmw0_value[63:0] = {dmw0_vseg[3:0], {54{1'b0}}, dmw0_mat[1:0], dmw0_plv3,
                              dmw0_plv2, dmw0_plv1, dmw0_plv0};


//==========================================================
//               Define the DMW1 register
//==========================================================
reg       dmw1_plv0;  
reg       dmw1_plv1;  
reg       dmw1_plv2;  
reg       dmw1_plv3;  
reg [1:0] dmw1_mat;  
reg [3:0] dmw1_vseg;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    dmw1_plv0      <= 1'b0;
    dmw1_plv1      <= 1'b0;
    dmw1_plv2      <= 1'b0;
    dmw1_plv3      <= 1'b0;
    dmw1_mat[1:0]  <= 2'b0;
    dmw1_vseg[3:0] <= 4'b0;
  end
  else if(dmw1_local_en) begin
    dmw1_plv0      <= iui_regs_src0[0];
    dmw1_plv1      <= iui_regs_src0[1];
    dmw1_plv2      <= iui_regs_src0[2];
    dmw1_plv3      <= iui_regs_src0[3];
    dmw1_mat[1:0]  <= iui_regs_src0[5:4];
    dmw1_vseg[3:0] <= iui_regs_src0[63:60];
  end
  else begin
    dmw1_plv0      <= dmw1_plv0;
    dmw1_plv1      <= dmw1_plv1;
    dmw1_plv2      <= dmw1_plv2;
    dmw1_plv3      <= dmw1_plv3;
    dmw1_mat[1:0]  <= dmw1_mat[1:0];
    dmw1_vseg[3:0] <= dmw1_vseg[3:0];
  end
end
wire [63:0] csrdmw1_value;
assign csrdmw1_value[63:0] = {dmw1_vseg[3:0], {54{1'b0}}, dmw1_mat[1:0], dmw1_plv3,
                              dmw1_plv2, dmw1_plv1, dmw1_plv0};



//==========================================================
//               Define the DMW2 register
//==========================================================
reg       dmw2_plv0;  
reg       dmw2_plv1;  
reg       dmw2_plv2;  
reg       dmw2_plv3;  
reg [1:0] dmw2_mat;  
reg [3:0] dmw2_vseg;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    dmw2_plv0      <= 1'b0;
    dmw2_plv1      <= 1'b0;
    dmw2_plv2      <= 1'b0;
    dmw2_plv3      <= 1'b0;
    dmw2_mat[1:0]  <= 2'b0;
    dmw2_vseg[3:0] <= 4'b0;
  end
  else if(dmw2_local_en) begin
    dmw2_plv0      <= iui_regs_src0[0];
    dmw2_plv1      <= iui_regs_src0[1];
    dmw2_plv2      <= iui_regs_src0[2];
    dmw2_plv3      <= iui_regs_src0[3];
    dmw2_mat[1:0]  <= iui_regs_src0[5:4];
    dmw2_vseg[3:0] <= iui_regs_src0[63:60];
  end
  else begin
    dmw2_plv0      <= dmw2_plv0;
    dmw2_plv1      <= dmw2_plv1;
    dmw2_plv2      <= dmw2_plv2;
    dmw2_plv3      <= dmw2_plv3;
    dmw2_mat[1:0]  <= dmw2_mat[1:0];
    dmw2_vseg[3:0] <= dmw2_vseg[3:0];
  end
end
wire [63:0] csrdmw2_value;
assign csrdmw2_value[63:0] = {dmw2_vseg[3:0], {54{1'b0}}, dmw2_mat[1:0], dmw2_plv3,
                              dmw2_plv2, dmw2_plv1, dmw2_plv0};


//==========================================================
//               Define the DMW3 register
//==========================================================
reg       dmw3_plv0;  
reg       dmw3_plv1;  
reg       dmw3_plv2;  
reg       dmw3_plv3;  
reg [1:0] dmw3_mat;  
reg [3:0] dmw3_vseg;  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    dmw3_plv0      <= 1'b0;
    dmw3_plv1      <= 1'b0;
    dmw3_plv2      <= 1'b0;
    dmw3_plv3      <= 1'b0;
    dmw3_mat[1:0]  <= 2'b0;
    dmw3_vseg[3:0] <= 4'b0;
  end
  else if(dmw3_local_en) begin
    dmw3_plv0      <= iui_regs_src0[0];
    dmw3_plv1      <= iui_regs_src0[1];
    dmw3_plv2      <= iui_regs_src0[2];
    dmw3_plv3      <= iui_regs_src0[3];
    dmw3_mat[1:0]  <= iui_regs_src0[5:4];
    dmw3_vseg[3:0] <= iui_regs_src0[63:60];
  end
  else begin
    dmw3_plv0      <= dmw3_plv0;
    dmw3_plv1      <= dmw3_plv1;
    dmw3_plv2      <= dmw3_plv2;
    dmw3_plv3      <= dmw3_plv3;
    dmw3_mat[1:0]  <= dmw3_mat[1:0];
    dmw3_vseg[3:0] <= dmw3_vseg[3:0];
  end
end
wire [63:0] csrdmw3_value;
assign csrdmw3_value[63:0] = {dmw3_vseg[3:0], {54{1'b0}}, dmw3_mat[1:0], dmw3_plv3,
                              dmw3_plv2, dmw3_plv1, dmw3_plv0};


//==========================================================
//               Define the PRCFG1 register
//==========================================================
wire [3:0] savenum = 4'd4;
wire [7:0] timerbits = 8'd0;
wire [2:0] vsmax = 3'd7;

wire [63:0] csrprcfg1_value;
assign csrprcfg1_value[63:0] = {{32'b0, 17'b0}, vsmax, timerbits, savenum};



//==========================================================
//               Define the PRCFG2 register
//==========================================================
wire [63:0] psval;

assign psval[10:0]  = 11'b0;
assign psval[11]    = 1'b1;
assign psval[63:12] = 52'b0;

wire [63:0] csrprcfg2_value;
assign csrprcfg2_value[63:0] = psval[63:0];


//==========================================================
//               Define the PRCFG3 register
//==========================================================
wire [3:0] tlbtype;
wire [7:0] mtlbentries;
wire [7:0] stlbway;
wire [5:0] stlbsets;

assign tlbtype[3:0]     = 4'b1;
assign mtlbentries[7:0] = 8'd6;
assign stlbway[7:0]     = 8'd0;
assign stlbsets[5:0]    = 6'd0;

wire [63:0] csrprcfg3_value;
assign csrprcfg3_value[63:0] = {{38'b0}, stlbsets, stlbway, mtlbentries, tlbtype};



//==========================================================
//               Define the Debug 0 register
//==========================================================

reg [63:0] debug_ld_va_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_ld_va_reg[63:0] <= 64'b0;
  else if(debug0_local_en)
    debug_ld_va_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(lsu_cp0_ld_vld)
    debug_ld_va_reg[63:0] <= {lsu_cp0_ld_va[63:0]};
  else
    debug_ld_va_reg[63:0] <= debug_ld_va_reg[63:0];
end
wire [63:0] debug0_value;
assign debug0_value[63:0] = debug_ld_va_reg[63:0];


//==========================================================
//               Define the Debug 1 register
//==========================================================

reg [63:0] debug_ld_pa_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_ld_pa_reg[63:0] <= 64'b0;
  else if(debug1_local_en)
    debug_ld_pa_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(lsu_cp0_ld_vld)
    debug_ld_pa_reg[63:0] <= {24'b0, lsu_cp0_ld_pa[39:0]};
  else
    debug_ld_pa_reg[63:0] <= debug_ld_pa_reg[63:0];
end
wire [63:0] debug1_value;
assign debug1_value[63:0] = debug_ld_pa_reg[63:0];


//==========================================================
//           Define the ChechPoint Restore Register
//==========================================================

reg [63:0] cpcsr_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cpcsr_reg[63:0] <= 64'b0;
  else if(cpcsr_local_en)
    cpcsr_reg[63:0] <= {iui_regs_src0[63:0]};
  else
    cpcsr_reg[63:0] <= cpcsr_reg[63:0];
end
wire [63:0] cpcsr_value;
assign cpcsr_value[63:0] = cpcsr_reg[63:0];


//==========================================================
//       Define the ChechPoint Restore Register(CRMD)
//==========================================================

reg [63:0] cpcsr_crmd_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cpcsr_crmd_reg[63:0] <= 64'b0;
  else if(cpcsr_crmd_local_en)
    cpcsr_crmd_reg[63:0] <= {iui_regs_src0[63:0]};
  else
    cpcsr_crmd_reg[63:0] <= cpcsr_crmd_reg[63:0];
end
wire [63:0] cpcsr_crmd_value;
assign cpcsr_crmd_value[63:0] = cpcsr_crmd_reg[63:0];


//==========================================================
//               Define the Wave debug register
//==========================================================

reg [63:0] debug_wave_dump_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_wave_dump_reg[63:0] <= 64'b0;
  else if(dgwavedump_local_en)
    debug_wave_dump_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(|debug_wave_dump_reg[63:0])
    debug_wave_dump_reg[63:0] <= 64'b0;
  else
    debug_wave_dump_reg[63:0] <= debug_wave_dump_reg[63:0];
end
wire [63:0] debug_wave_dump_value;
assign debug_wave_dump_value[63:0] = debug_wave_dump_reg[63:0];


//==========================================================
//               Define the Debug 2 register
//==========================================================
reg [63:0] debug_pgdl_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_pgdl_reg[63:0] <= 64'b0;
  else if(debug2_local_en)
    debug_pgdl_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(mmu_cp0_fst_vld)
    debug_pgdl_reg[63:0] <= {csrpgdl_value[63:1], mmu_cp0_type};
  else
    debug_pgdl_reg[63:0] <= debug_pgdl_reg[63:0];
end
wire [63:0] debug2_value;
assign debug2_value[63:0] = debug_pgdl_reg[63:0];

//==========================================================
//               Define the Debug 3 register
//==========================================================
reg [63:0] debug_pgdh_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_pgdh_reg[63:0] <= 64'b0;
  else if(debug3_local_en)
    debug_pgdh_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(mmu_cp0_fst_vld)
    debug_pgdh_reg[63:0] <= {csrpgdh_value[63:0]};
  else
    debug_pgdh_reg[63:0] <= debug_pgdh_reg[63:0];
end
wire [63:0] debug3_value;
assign debug3_value[63:0] = debug_pgdh_reg[63:0];

//==========================================================
//               Define the Debug 4 register
//==========================================================
reg [63:0] debug_pfst_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_pfst_reg[63:0] <= 64'b0;
  else if(debug4_local_en)
    debug_pfst_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(mmu_cp0_fst_vld)
    debug_pfst_reg[63:0] <= {24'b0, mmu_cp0_fst_addr[39:0]};
  else
    debug_pfst_reg[63:0] <= debug_pfst_reg[63:0];
end
wire [63:0] debug4_value;
assign debug4_value[63:0] = debug_pfst_reg[63:0];

//==========================================================
//               Define the Debug 5 register
//==========================================================
reg [63:0] debug_pscd_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_pscd_reg[63:0] <= 64'b0;
  else if(debug5_local_en)
    debug_pscd_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(mmu_cp0_scd_vld)
    debug_pscd_reg[63:0] <= {24'b0, mmu_cp0_scd_addr[39:0]};
  else
    debug_pscd_reg[63:0] <= debug_pscd_reg[63:0];
end
wire [63:0] debug5_value;
assign debug5_value[63:0] = debug_pscd_reg[63:0];

//==========================================================
//               Define the Debug 6 register
//==========================================================
reg [63:0] debug_pthd_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_pthd_reg[63:0] <= 64'b0;
  else if(debug6_local_en)
    debug_pthd_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(mmu_cp0_thd_vld)
    debug_pthd_reg[63:0] <= {24'b0, mmu_cp0_thd_addr[39:0]};
  else
    debug_pthd_reg[63:0] <= debug_pthd_reg[63:0];
end
wire [63:0] debug6_value;
assign debug6_value[63:0] = debug_pthd_reg[63:0];

//==========================================================
//               Define the Debug 7 register
//==========================================================
reg [63:0] debug_vpn_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_vpn_reg[63:0] <= 64'b0;
  else if(debug7_local_en)
    debug_vpn_reg[63:0] <= {iui_regs_src0[63:0]};
  else if(mmu_cp0_fst_vld)
    debug_vpn_reg[63:0] <= {37'b0, mmu_cp0_vpn[26:0]};
  else
    debug_vpn_reg[63:0] <= debug_vpn_reg[63:0];
end
wire [63:0] debug7_value;
assign debug7_value[63:0] = debug_vpn_reg[63:0];


//==========================================================
//               Define the MWPC register
//==========================================================
reg [63:0] mwpc_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mwpc_reg[63:0] <= 64'b0;
  else if(mwpc_local_en)
    mwpc_reg[63:0] <= {iui_regs_src0[63:0]};
  else
    mwpc_reg[63:0] <= mwpc_reg[63:0];
end
wire [63:0] mwpc_value;
assign mwpc_value[63:0] = mwpc_reg[63:0];


//==========================================================
//               Define the MWPS register
//==========================================================
reg [63:0] mwps_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mwps_reg[63:0] <= 64'b0;
  else if(mwps_local_en)
    mwps_reg[63:0] <= {iui_regs_src0[63:0]};
  else
    mwps_reg[63:0] <= mwps_reg[63:0];
end
wire [63:0] mwps_value;
assign mwps_value[63:0] = mwps_reg[63:0];


//==========================================================
//               Define the FWPC register
//==========================================================
reg [63:0] fwpc_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fwpc_reg[63:0] <= 64'b0;
  else if(fwpc_local_en)
    fwpc_reg[63:0] <= {iui_regs_src0[63:0]};
  else
    fwpc_reg[63:0] <= fwpc_reg[63:0];
end
wire [63:0] fwpc_value;
assign fwpc_value[63:0] = fwpc_reg[63:0];


//==========================================================
//               Define the FWPS register
//==========================================================
reg [63:0] fwps_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fwps_reg[63:0] <= 64'b0;
  else if(fwps_local_en)
    fwps_reg[63:0] <= {iui_regs_src0[63:0]};
  else
    fwps_reg[63:0] <= fwps_reg[63:0];
end
wire [63:0] fwps_value;
assign fwps_value[63:0] = fwps_reg[63:0];


//==========================================================
//               Define the IPI_Status register
//==========================================================
wire iui_ipi_status_set;
wire iui_ipi_status_clear;
wire iui_ipi_enable_en;
wire iui_ipi_set_en;
wire iui_ipi_clear_en;
wire iui_ipi_mailbox0_en;
wire iui_ipi_mailbox1_en;
wire iui_ipi_mailbox2_en;
wire iui_ipi_mailbox3_en;


assign iui_ipi_status_set   = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == IPIST);
assign iui_ipi_status_clear = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == IPICL);
assign iui_ipi_enable_en    = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == IPIEN);
assign iui_ipi_set_en       = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == IPIST);
assign iui_ipi_clear_en     = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == IPICL);

assign iui_ipi_mailbox0_en  = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == MABOX0);
assign iui_ipi_mailbox1_en  = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == MABOX1);
assign iui_ipi_mailbox2_en  = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == MABOX2);
assign iui_ipi_mailbox3_en  = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == MABOX3);


wire [31:0] iui_update_ipi_regs_src0_val;
wire [31:0] iui_update_ipi_regs_src1_val;
wire [31:0] iui_update_ipi_regs_src2_val;
wire [31:0] iui_update_ipi_regs_src3_val;


wire [31:0] iui_ipi_set_status;
wire [31:0] iui_ipi_clr_status;
reg  [31:0] ipi_status_reg;  



assign iui_ipi_set_status[31:0] = ipi_status_reg[31:0] | iui_ipi_regs_src[31:0];
assign iui_ipi_clr_status[31:0] = ipi_status_reg[31:0] & (~iui_ipi_regs_src[31:0]);

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ipi_status_reg[31:0] <= 32'b0;
  else if(iui_update_ipi_status_en)
    ipi_status_reg[31:0] <= iui_update_ipi_status_src[31:0];
  else if(iui_ipi_status_set)
    ipi_status_reg[31:0] <= iui_ipi_set_status[31:0];
  else if(iui_ipi_status_clear)
    ipi_status_reg[31:0] <= iui_ipi_clr_status[31:0];
  else
    ipi_status_reg[31:0] <= ipi_status_reg[31:0];
end

wire [63:0] csr_ipi_status_value; 
assign csr_ipi_status_value[63:0] = {{32{ipi_status_reg[31]}}, ipi_status_reg[31:0]};

//==========================================================
//               Define the IPI_Enable register
//==========================================================
reg [31:0] ipi_enable_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ipi_enable_reg[31:0] <= 32'b0;
  else if(iui_ipi_enable_en)
    ipi_enable_reg[31:0] <= iui_ipi_regs_src[31:0];
  else
    ipi_enable_reg[31:0] <= ipi_enable_reg[31:0];
end

wire [63:0] csr_ipi_enable_value; 
assign csr_ipi_enable_value[63:0] = {{32{ipi_enable_reg[31]}}, ipi_enable_reg[31:0]};

assign ipi_expt_vld = |(ipi_status_reg[31:0] & ipi_enable_reg[31:0]);

assign iui_ipi_set_val = |((iui_ipi_set_status[31:0] 
                            | iui_ipi_clr_status[31:0])
                          & ipi_enable_reg[31:0]);

assign iui_ipi_set_vld = iui_ipi_status_set 
                             || iui_ipi_status_clear;

//==========================================================
//               Define the IPI_Set register
//==========================================================
reg [31:0] ipi_set_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ipi_set_reg[31:0] <= 32'b0;
  else if(iui_ipi_set_en)
    ipi_set_reg[31:0] <= iui_ipi_regs_src[31:0];
  else
    ipi_set_reg[31:0] <= ipi_set_reg[31:0];
end

//==========================================================
//               Define the IPI_Clear register
//==========================================================
reg [31:0] ipi_clear_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ipi_clear_reg[31:0] <= 32'b0;
  else if(iui_ipi_clear_en)
    ipi_clear_reg[31:0] <= iui_ipi_regs_src[31:0];
  else
    ipi_clear_reg[31:0] <= ipi_clear_reg[31:0];
end


assign iui_update_ipi_regs_src0_val[31:0] = iui_update_ipi_regs_src0[31:0] & (~iui_update_ipi_regs_mask0[31:0]);
assign iui_update_ipi_regs_src1_val[31:0] = iui_update_ipi_regs_src1[31:0] & (~iui_update_ipi_regs_mask1[31:0]);
assign iui_update_ipi_regs_src2_val[31:0] = iui_update_ipi_regs_src2[31:0] & (~iui_update_ipi_regs_mask2[31:0]);
assign iui_update_ipi_regs_src3_val[31:0] = iui_update_ipi_regs_src3[31:0] & (~iui_update_ipi_regs_mask3[31:0]);


//==========================================================
//               Define the MailBox0 register
//==========================================================
reg  [63:0] mailbox0_reg;  
wire [31:0] iui_ori_regs_src0_hi;
wire [31:0] iui_ori_regs_src0_lo;

assign iui_ori_regs_src0_hi[31:0] = iui_update_ipi_regs_mask0[31:0] & mailbox0_reg[63:32];
assign iui_ori_regs_src0_lo[31:0] = iui_update_ipi_regs_mask0[31:0] & mailbox0_reg[31: 0];

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mailbox0_reg[63:0] <= 64'b0;
  else if(iui_ipi_mailbox0_en)
    mailbox0_reg[63:0] <= iui_ipi_regs_src[63:0];
  else if(iui_update_ipi_mailbox0_en) begin
    if (iui_update_ipi_mailbox_sel[0]) begin
      mailbox0_reg[63:32] <= iui_ori_regs_src0_hi[31:0] | iui_update_ipi_regs_src0_val[31:0];
    end else 
      mailbox0_reg[31: 0] <= iui_ori_regs_src0_lo[31:0] | iui_update_ipi_regs_src0_val[31:0];
  end
  else
    mailbox0_reg[63:0] <= mailbox0_reg[63:0];
end

assign regs_iui_mailbox0_data[63:0] = mailbox0_reg[63:0];

//==========================================================
//               Define the MailBox1 register
//==========================================================
reg  [63:0] mailbox1_reg;  
wire [31:0] iui_ori_regs_src1_hi;
wire [31:0] iui_ori_regs_src1_lo;

assign iui_ori_regs_src1_hi[31:0] = iui_update_ipi_regs_mask1[31:0] & mailbox1_reg[63:32];
assign iui_ori_regs_src1_lo[31:0] = iui_update_ipi_regs_mask1[31:0] & mailbox1_reg[31: 0];

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mailbox1_reg[63:0] <= 64'b0;
  else if(iui_ipi_mailbox1_en)
    mailbox1_reg[63:0] <= iui_ipi_regs_src[63:0];
  else if(iui_update_ipi_mailbox1_en) begin
    if (iui_update_ipi_mailbox_sel[1]) begin
      mailbox1_reg[63:32] <= iui_ori_regs_src1_hi[31:0] | iui_update_ipi_regs_src1_val[31:0];
    end else 
      mailbox1_reg[31: 0] <= iui_ori_regs_src1_lo[31:0] | iui_update_ipi_regs_src1_val[31:0];
  end
  else
    mailbox1_reg[63:0] <= mailbox1_reg[63:0];
end


//==========================================================
//               Define the MailBox2 register
//==========================================================
reg  [63:0] mailbox2_reg;  
wire [31:0] iui_ori_regs_src2_hi;
wire [31:0] iui_ori_regs_src2_lo;

assign iui_ori_regs_src2_hi[31:0] = iui_update_ipi_regs_mask2[31:0] & mailbox2_reg[63:32];
assign iui_ori_regs_src2_lo[31:0] = iui_update_ipi_regs_mask2[31:0] & mailbox2_reg[31: 0];
  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mailbox2_reg[63:0] <= 64'b0;
  else if(iui_ipi_mailbox2_en)
    mailbox2_reg[63:0] <= iui_ipi_regs_src[63:0];
  else if(iui_update_ipi_mailbox2_en) begin
    if (iui_update_ipi_mailbox_sel[2]) begin
      mailbox2_reg[63:32] <= iui_ori_regs_src2_hi[31:0] | iui_update_ipi_regs_src2_val[31:0];
    end else 
      mailbox2_reg[31: 0] <= iui_ori_regs_src2_lo[31:0] | iui_update_ipi_regs_src2_val[31:0];
  end
  else
    mailbox2_reg[63:0] <= mailbox2_reg[63:0];
end


//==========================================================
//               Define the MailBox3 register
//==========================================================
reg  [63:0] mailbox3_reg;  
wire [31:0] iui_ori_regs_src3_hi;
wire [31:0] iui_ori_regs_src3_lo;

assign iui_ori_regs_src3_hi[31:0] = iui_update_ipi_regs_mask3[31:0] & mailbox3_reg[63:32];
assign iui_ori_regs_src3_lo[31:0] = iui_update_ipi_regs_mask3[31:0] & mailbox3_reg[31: 0];  

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mailbox3_reg[63:0] <= 64'b0;
  else if(iui_ipi_mailbox3_en)
    mailbox3_reg[63:0] <= iui_ipi_regs_src[63:0];
  else if(iui_update_ipi_mailbox3_en) begin
    if (iui_update_ipi_mailbox_sel[3]) begin
      mailbox3_reg[63:32] <= iui_ori_regs_src3_hi[31:0] | iui_update_ipi_regs_src3_val[31:0];
    end else 
      mailbox3_reg[31: 0] <= iui_ori_regs_src3_lo[31:0] | iui_update_ipi_regs_src3_val[31:0];
  end
  else
    mailbox3_reg[63:0] <= mailbox3_reg[63:0];
end



//==========================================================
// select read data from all regs in cp0
//==========================================================
// &CombBeg; @3665

always @(iui_regs_iocsr_addr[15:0]
       or csr_ipi_status_value[63:0]
       or csr_ipi_enable_value[63:0]
       or mailbox0_reg[63:0]
       or mailbox1_reg[63:0]
       or mailbox2_reg[63:0]
       or mailbox3_reg[63:0]
      )
begin
  case(iui_regs_iocsr_addr[15:0])
    IPISS     : iocsr_data_out[63:0] = csr_ipi_status_value[63:0];
    IPIEN     : iocsr_data_out[63:0] = csr_ipi_enable_value[63:0];
    MABOX0    : iocsr_data_out[63:0] = mailbox0_reg[63:0];
    MABOX1    : iocsr_data_out[63:0] = mailbox1_reg[63:0];
    MABOX2    : iocsr_data_out[63:0] = mailbox2_reg[63:0];
    MABOX3    : iocsr_data_out[63:0] = mailbox3_reg[63:0];
    default   : iocsr_data_out[63:0] = 64'b0; 
  endcase
// &CombEnd; @3742
end

assign regs_iui_iocsr_data_out[63:0] = iocsr_data_out[63:0];


//==========================================================
//               Define the CSR_IFU register
//==========================================================

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
wire ifu_enable_btb            = 1'b1;
wire ifu_enable_l0btb          = 1'b1;
wire ifu_lbuf_enable           = 1'b1;
wire ifu_bht_enable            = 1'b1;
wire ifu_rsa_enable            = 1'b1;
wire ifu_ind_btb_en            = 1'b1;
wire icache_reset_enable       = 1'b1;


always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    lpe    <= ifu_lbuf_enable;
    ibpe   <= ifu_ind_btb_en;
    l0btbe <= ifu_enable_l0btb;
    btbe   <= ifu_enable_btb;
    bpe    <= ifu_bht_enable;
    rse    <= ifu_rsa_enable;
    ie     <= icache_reset_enable;
  end
  else if(ifuc_local_en) begin
    lpe    <= iui_regs_src0[6];
    ibpe   <= iui_regs_src0[5];
    btbe   <= iui_regs_src0[4];
    bpe    <= iui_regs_src0[3];
    rse    <= iui_regs_src0[2];
    l0btbe <= iui_regs_src0[1];
    ie     <= iui_regs_src0[0];
  end
  else begin
    lpe    <= lpe;
    ibpe   <= ibpe;
    l0btbe <= l0btbe;
    btbe   <= btbe;
    bpe    <= bpe;
    rse    <= rse;
    ie     <= ie;
  end
end

wire [63:0] csr_ifu_value;
assign csr_ifu_value[63:0] = {57'b0,
                              lpe,
                              ibpe,
                              btbe,
                              bpe,
                              rse,
                              l0btbe,
                              ie};

//==========================================================
//               Define the CSR_CACHE register
//==========================================================

//==========================================================
//               Enable/Disable ICache/DCache
//==========================================================

wire default_dcache_reset_enable       = 1'b1;
wire default_dcache_write_alloc_enable = 1'b1;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    wa                    <= default_dcache_write_alloc_enable;
    de                    <= default_dcache_reset_enable;
  end
  else if(cacc_local_en)
  begin
    wa                    <= iui_regs_src0[2];
    de                    <= iui_regs_src0[1];
  end
  else
  begin
    wa                    <= wa;
    de                    <= de;
  end
end

wire [63:0] csr_cache_value;
assign csr_cache_value[63:0] = {62'b0, wa, de};

//==========================================================
//               Define the CSR_MISC register
//==========================================================
reg bju_chflw_en;

wire default_icache_pref_en = 1'b1;
wire default_dcache_pref_en = 1'b1;
wire default_l2_st_pref_en  = 1'b1;
wire default_l2_pref_en     = 1'b0;
wire default_bju_chflw_en   = 1'b0;


`ifdef CPU_SINGLE_RETIRE
  wire default_rob_single_retire  = 1'b1;
`else 
  wire default_rob_single_retire  = 1'b0;
`endif

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    corr_dis              <= 1'b0;
    bju_chflw_en          <= default_bju_chflw_en;
    fencei_broad_dis      <= 1'b0;
    fencerw_broad_dis     <= 1'b0;
    tlb_broad_dis         <= 1'b0;
    l2stpld               <= default_l2_st_pref_en;
    nsfe                  <= 1'b0;
    l2_pref_dist[1:0]     <= 2'b10;
    l2pld                 <= default_l2_pref_en;
    dcache_pref_dist[1:0] <= 2'b10;
    sre                   <= default_rob_single_retire;
    iwpe                  <= 1'b0;
    icache_pref_en        <= default_icache_pref_en;
    amr2                  <= 1'b0;
    amr                   <= 1'b0;
    dcache_pref_en        <= default_dcache_pref_en;
  end
  else if(mscc_local_en) begin
    corr_dis              <= iui_regs_src0[17];
    fencei_broad_dis      <= iui_regs_src0[16];
    fencerw_broad_dis     <= iui_regs_src0[15];
    tlb_broad_dis         <= iui_regs_src0[14];
    l2stpld               <= iui_regs_src0[13];
    nsfe                  <= iui_regs_src0[12];
    l2_pref_dist[1:0]     <= iui_regs_src0[11:10]; 
    l2pld                 <= iui_regs_src0[9];
    dcache_pref_dist[1:0] <= iui_regs_src0[8:7];
    sre                   <= iui_regs_src0[6];
    iwpe                  <= iui_regs_src0[5];
    bju_chflw_en          <= iui_regs_src0[4];
    icache_pref_en        <= iui_regs_src0[3];
    amr2                  <= iui_regs_src0[2];
    amr                   <= iui_regs_src0[1];
    dcache_pref_en        <= iui_regs_src0[0];
  end
  else begin
    corr_dis              <= corr_dis;
    bju_chflw_en          <= bju_chflw_en;
    fencei_broad_dis      <= fencei_broad_dis;
    fencerw_broad_dis     <= fencerw_broad_dis;
    tlb_broad_dis         <= tlb_broad_dis;
    l2stpld               <= l2stpld;
    nsfe                  <= nsfe;
    l2_pref_dist[1:0]     <= l2_pref_dist[1:0];
    l2pld                 <= l2pld;
    dcache_pref_dist[1:0] <= dcache_pref_dist[1:0];
    sre                   <= sre;
    iwpe                  <= iwpe;
    icache_pref_en        <= icache_pref_en;
    amr2                  <= amr2;
    amr                   <= amr;
    dcache_pref_en        <= dcache_pref_en;
  end
end


//---------------------------------------------------------
// TODO:
wire default_rob_fold_disable    = 1'b1;
wire default_cb_aclr_disable     = 1'b0;
//---------------------------------------------------------
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    vsetvli_pred          <= 1'b0;
    ctc_flush_dis         <= 1'b0;
    par_dis[3:0]          <= 4'b0;
    pfu_mmu_dis           <= 1'b0;
    vsetvli_dis           <= 1'b0;
    local_icg_en[8:0]     <= 9'b0;
    da_fwd_dis            <= 1'b0;
    src2_fwd_dis          <= 1'b0;
    div_entry_dis         <= 1'b0;
    cb_aclr_dis           <= default_cb_aclr_disable;
    wr_burst_dis          <= 1'b0;
    zero_move_dis         <= 1'b0;
    dlb_dis               <= 1'b0;
    rob_fold_dis          <= default_rob_fold_disable;
    iq_bypass_dis         <= 1'b0;
    srcv2_fwd_dis         <= 1'b0;
  end
  else if(mscc_local_en) begin
    vsetvli_pred          <= iui_regs_src0[56];
    ctc_flush_dis         <= iui_regs_src0[55];
    par_dis[3:0]          <= iui_regs_src0[54:51];
    pfu_mmu_dis           <= iui_regs_src0[50];
    vsetvli_dis           <= iui_regs_src0[49];
    local_icg_en[8:0]     <= iui_regs_src0[48:40];
    da_fwd_dis            <= iui_regs_src0[39];
    src2_fwd_dis          <= iui_regs_src0[38];
    div_entry_dis         <= iui_regs_src0[37];
    cb_aclr_dis           <= iui_regs_src0[36];
    wr_burst_dis          <= iui_regs_src0[35];
    zero_move_dis         <= iui_regs_src0[34];
    dlb_dis               <= iui_regs_src0[33];
    rob_fold_dis          <= iui_regs_src0[32];
    iq_bypass_dis         <= iui_regs_src0[31];
    srcv2_fwd_dis         <= iui_regs_src0[30];
  end
  else begin
    vsetvli_pred          <= vsetvli_pred;
    ctc_flush_dis         <= ctc_flush_dis;
    par_dis[3:0]          <= par_dis[3:0];
    pfu_mmu_dis           <= pfu_mmu_dis;
    vsetvli_dis           <= vsetvli_dis;
    local_icg_en[8:0]     <= local_icg_en[8:0];
    da_fwd_dis            <= da_fwd_dis;
    src2_fwd_dis          <= src2_fwd_dis;
    div_entry_dis         <= div_entry_dis;
    cb_aclr_dis           <= cb_aclr_dis;
    wr_burst_dis          <= wr_burst_dis;
    zero_move_dis         <= zero_move_dis;
    dlb_dis               <= dlb_dis;
    rob_fold_dis          <= rob_fold_dis;
    iq_bypass_dis         <= iq_bypass_dis;
    srcv2_fwd_dis         <= srcv2_fwd_dis;
  end
end


wire [63:0] csr_misc_value;
assign csr_misc_value[63:0] = {19'b0, 
                              /// misc 1
                               vsetvli_pred,
                               ctc_flush_dis,
                               par_dis[3:0],
                               pfu_mmu_dis,
                               vsetvli_dis,
                               local_icg_en[8:0],
                               da_fwd_dis,
                               src2_fwd_dis,
                               div_entry_dis,
                               cb_aclr_dis,
                               wr_burst_dis,
                               zero_move_dis,
                               dlb_dis,
                               rob_fold_dis,
                               iq_bypass_dis,
                               srcv2_fwd_dis,
                              /// misc 0
                               corr_dis, 
                               fencei_broad_dis,
                               fencerw_broad_dis,
                               tlb_broad_dis,
                               l2stpld,
                               nsfe,
                               l2_pref_dist[1:0],
                               l2pld,
                               dcache_pref_dist[1:0],
                               sre,
                               iwpe,
                               bju_chflw_en,
                               icache_pref_en,
                               amr2,
                               amr,
                               dcache_pref_en};



assign cp0_iu_bju_chflw_en = bju_chflw_en;


//==========================================================
//              User Floating-Point CSRs
//==========================================================
reg [1:0] rv_la_rm;
reg [2:0] la_rv_rm;

reg [63:0] fcsr0_reg;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fcsr0_reg[63:0]  <= 64'b0;
  else if(fcsr0_local_en)
    fcsr0_reg[63:0]  <= {iui_regs_src0[63:0]};
  else if(fcsr1_local_en)
    fcsr0_reg[4:0]   <= iui_regs_src0[4:0];   // enable
  else if(fcsr2_local_en) begin
    fcsr0_reg[28:24] <= iui_regs_src0[28:24]; // cause
    fcsr0_reg[20:16] <= iui_regs_src0[20:16]; // flags    
  end
  else if (idu_cp0_fesr_acc_updt_vld) begin
    fcsr0_reg[28:24] <= idu_cp0_fesr_acc_updt_val[4:0]; // cause
    fcsr0_reg[20:16] <= fcsr0_reg[20:16] | idu_cp0_fesr_acc_updt_val[4:0]; // flags (accumulate)
  end    
  else if(fcsr3_local_en)
    fcsr0_reg[9:8] <= iui_regs_src0[9:8];     // rm
  else
    fcsr0_reg[63:0] <= fcsr0_reg[63:0];
end


wire [63:0] fcsr0_value;
wire [63:0] fcsr1_value;
wire [63:0] fcsr2_value;
wire [63:0] fcsr3_value;

wire [4:0] fcsr0_flags;
// fcsr0_reg[20:16]
assign fcsr0_flags[4:0] = {fcsr_nv, fcsr_dz, fcsr_of, fcsr_uf, fcsr_nx};

assign fcsr0_value[63:0] = fcsr0_reg[63:0];
assign fcsr1_value[63:0] = {32'b0, 27'b0, fcsr0_reg[4:0]};
assign fcsr2_value[63:0] = {32'b0, 3'b0,  fcsr0_reg[28:24], 3'b0, fcsr0_flags[4:0], 16'b0};
assign fcsr3_value[63:0] = {32'b0, 22'b0, fcsr0_reg[9:8], 8'b0};


always @(fcsr_frm[2:0])
begin
  rv_la_rm[1:0] = 2'b00; 
  casez(fcsr_frm[2:0])
    3'b000  : rv_la_rm[1:0] = 2'b00; // rne
    3'b001  : rv_la_rm[1:0] = 2'b01; // rz
    3'b011  : rv_la_rm[1:0] = 2'b10; // rp
    3'b010  : rv_la_rm[1:0] = 2'b11; // rn
    default : rv_la_rm[1:0] = 2'bxx; 
  endcase
end


always @(iui_regs_src0[9:8])
begin
  la_rv_rm[2:0] = 3'b111; 
  casez(iui_regs_src0[9:8])
    2'b00   : la_rv_rm[2:0] = 3'b000; // rne
    2'b01   : la_rv_rm[2:0] = 3'b001; // rz
    2'b10   : la_rv_rm[2:0] = 3'b011; // rn
    2'b11   : la_rv_rm[2:0] = 3'b010; // rp
    default : la_rv_rm[2:0] = 3'bxxx; 
  endcase
end

//        RV             LA
// NX: No-eXact  -> I: Inexact
// UF: UnderFlow -> U: Underflow
// OF: OverFlow  -> O: Overflow
// DZ: Div Zero  -> Z: division by Zero
// NV: iNValid   -> V: inValid operation

//==========================================================
//               Define the FRM register
//==========================================================
// 3. Define User Floating-Point CSRs
//==========================================================

//==========================================================
//               Define the FFLAGS register
//==========================================================
assign fflags_value[63:0] = {59'b0, fcsr_value[4:0]};

//==========================================================
//               Define the FRM register
//==========================================================
assign frm_value[63:0] = {61'b0, fcsr_value[7:5]};

//==========================================================
//               Define the FCSR register
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    fcsr_raw_vxrm[1:0] <= 2'b0;
    fcsr_raw_vxsat     <= 1'b0;
    fcsr_frm[2:0]      <= 3'b0;
    fcsr_nv            <= 1'b0;
    fcsr_dz            <= 1'b0;
    fcsr_of            <= 1'b0;
    fcsr_uf            <= 1'b0;
    fcsr_nx            <= 1'b0;
  end
  else if(fcsr0_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= la_rv_rm[2:0];
    fcsr_nv            <= iui_regs_src0[20];
    fcsr_dz            <= iui_regs_src0[19];
    fcsr_of            <= iui_regs_src0[18];
    fcsr_uf            <= iui_regs_src0[17];
    fcsr_nx            <= iui_regs_src0[16];
  end
  else if(fcsr2_local_en) // cause, flags
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= fcsr_frm[2:0];
    fcsr_nv            <= iui_regs_src0[20];
    fcsr_dz            <= iui_regs_src0[19];
    fcsr_of            <= iui_regs_src0[18];
    fcsr_uf            <= iui_regs_src0[17];
    fcsr_nx            <= iui_regs_src0[16];
  end
  else if(fcsr_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= iui_regs_src0[10:9];
    fcsr_raw_vxsat     <= iui_regs_src0[8];
    fcsr_frm[2:0]      <= iui_regs_src0[7:5];
    fcsr_nv            <= iui_regs_src0[4];
    fcsr_dz            <= iui_regs_src0[3];
    fcsr_of            <= iui_regs_src0[2];
    fcsr_uf            <= iui_regs_src0[1];
    fcsr_nx            <= iui_regs_src0[0];
  end
  else if(vxrm_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= iui_regs_src0[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= fcsr_frm[2:0];
    fcsr_nv            <= fcsr_nv;
    fcsr_dz            <= fcsr_dz;
    fcsr_of            <= fcsr_of;
    fcsr_uf            <= fcsr_uf;
    fcsr_nx            <= fcsr_nx;
  end
  else if(vxsat_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= iui_regs_src0[0];
    fcsr_frm[2:0]      <= fcsr_frm[2:0];
    fcsr_nv            <= fcsr_nv;
    fcsr_dz            <= fcsr_dz;
    fcsr_of            <= fcsr_of;
    fcsr_uf            <= fcsr_uf;
    fcsr_nx            <= fcsr_nx;
  end
  else if(frm_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= iui_regs_src0[2:0];
    fcsr_nv            <= fcsr_nv;
    fcsr_dz            <= fcsr_dz;
    fcsr_of            <= fcsr_of;
    fcsr_uf            <= fcsr_uf;
    fcsr_nx            <= fcsr_nx;
  end
  else if(fflags_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= fcsr_frm[2:0];
    fcsr_nv            <= iui_regs_src0[4];
    fcsr_dz            <= iui_regs_src0[3];
    fcsr_of            <= iui_regs_src0[2];
    fcsr_uf            <= iui_regs_src0[1];
    fcsr_nx            <= iui_regs_src0[0];
  end
  else if(fxcr_local_en)
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= iui_regs_src0[26:24];
    fcsr_nv            <= iui_regs_src0[4];
    fcsr_dz            <= iui_regs_src0[3];
    fcsr_of            <= iui_regs_src0[2];
    fcsr_uf            <= iui_regs_src0[1];
    fcsr_nx            <= iui_regs_src0[0];
  end
  else if (idu_cp0_fesr_acc_updt_vld) begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat || idu_cp0_fesr_acc_updt_val[6];
    fcsr_frm[2:0]      <= fcsr_frm[2:0];
    fcsr_nv            <= fcsr_nv || idu_cp0_fesr_acc_updt_val[4];
    fcsr_dz            <= fcsr_dz || idu_cp0_fesr_acc_updt_val[3];
    fcsr_of            <= fcsr_of || idu_cp0_fesr_acc_updt_val[2];
    fcsr_uf            <= fcsr_uf || idu_cp0_fesr_acc_updt_val[1];
    fcsr_nx            <= fcsr_nx || idu_cp0_fesr_acc_updt_val[0];
  end
  else
  begin
    fcsr_raw_vxrm[1:0] <= fcsr_raw_vxrm[1:0];
    fcsr_raw_vxsat     <= fcsr_raw_vxsat;
    fcsr_frm[2:0]      <= fcsr_frm[2:0];
    fcsr_nv            <= fcsr_nv;
    fcsr_dz            <= fcsr_dz;
    fcsr_of            <= fcsr_of;
    fcsr_uf            <= fcsr_uf;
    fcsr_nx            <= fcsr_nx;
  end
end

assign fcsr_vxsat     = 1'b0;
assign fcsr_vxrm[1:0] = 2'b0;

assign fcsr_value[63:0] = {32'b0, 21'b0, fcsr_vxrm[1:0], fcsr_vxsat, 
                           fcsr_frm[2:0], fcsr_nv, fcsr_dz, fcsr_of,
                           fcsr_uf, fcsr_nx};

assign cp0_vfpu_fcsr[63:0] = fcsr_value[63:0];

//==========================================================
//               Define the VSTART register
//==========================================================
always @(posedge vec_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    vstart_raw_vstart[6:0]   <= 7'b0;
  else if(vstart_local_en)
    vstart_raw_vstart[6:0]   <= iui_regs_src0[6:0];
  else if (rtu_cp0_vstart_vld)
    vstart_raw_vstart[6:0]   <= rtu_cp0_vstart[6:0];
  else
    vstart_raw_vstart[6:0]   <= vstart_raw_vstart[6:0];
end

assign vstart_vstart[6:0] = 7'b0;

assign vstart_value[63:0] = {57'b0, vstart_vstart[6:0]};

assign cp0_idu_vstart[6:0]  = vstart_vstart[6:0];
assign cp0_iu_vstart[6:0]   = vstart_vstart[6:0];
assign cp0_lsu_vstart[6:0]  = vstart_vstart[6:0];

//==========================================================
//               Define the VXSAT register
//==========================================================
assign vxsat_value[63:0] = {63'b0, fcsr_vxsat};

//==========================================================
//               Define the VXRM register
//==========================================================
assign vxrm_value[63:0] = {62'b0, fcsr_vxrm[1:0]};

//==========================================================
//                Define the VL register
//==========================================================
always @(posedge vec_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    vtype_raw_vill       <= 1'b1;
    vtype_raw_vsew[2:0]  <= 3'b0;
    vtype_raw_vlmul[1:0] <= 2'b0;
  end
  else if (rtu_cp0_vsetvl_vtype_vld)
  begin
    vtype_raw_vill       <= rtu_cp0_vsetvl_vill;
    vtype_raw_vsew[2:0]  <= rtu_cp0_vsetvl_vsew[2:0];
    vtype_raw_vlmul[1:0] <= rtu_cp0_vsetvl_vlmul[1:0];
  end
  else
  begin
    vtype_raw_vill       <= vtype_raw_vill;
    vtype_raw_vsew[2:0]  <= vtype_raw_vsew[2:0];
    vtype_raw_vlmul[1:0] <= vtype_raw_vlmul[1:0];
  end
end

assign vtype_vill       = 1'b1;
assign vtype_vsew[2:0]  = 3'b0;
assign vtype_vlmul[1:0] = 2'b0;

assign vtype_value[63:0] = {vtype_vill, 56'b0, 2'b0,
                            vtype_vsew[2:0], vtype_vlmul[1:0]};

assign cp0_idu_vill       = vtype_vill;
assign cp0_iu_vill        = vtype_vill;
assign cp0_ifu_vsew[2:0]  = vtype_vsew[2:0];
assign cp0_ifu_vlmul[1:0] = vtype_vlmul[1:0];

//==========================================================
//                Define the VL register
//==========================================================
always @(posedge vec_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    vl_raw_vl[7:0]   <= 8'b0;
  else if (rtu_cp0_vsetvl_vl_vld)
    vl_raw_vl[7:0]   <= rtu_cp0_vsetvl_vl[7:0];
  else
    vl_raw_vl[7:0]   <= vl_raw_vl[7:0];
end

assign vl_vl[7:0] = 8'b0;

assign vl_value[63:0] = {56'b0, vl_vl[7:0]};

assign cp0_vfpu_vl[7:0] = vl_vl[7:0];
assign cp0_ifu_vl[7:0]  = vl_vl[7:0];
//assign cp0_idu_vl[7:0]  = vl_vl[7:0];
assign cp0_iu_vl[7:0]   = vl_vl[7:0];
//assign cp0_lsu_vl[7:0]  = vl_vl[7:0];

//==========================================================
//               Define the VXRM register
//==========================================================
assign vlenb_value[63:0] = 64'd16; //VLEN 128 bit






//==========================================================
// 4. C-SKY Extension CSRs
//==========================================================

//==========================================================
//               Define the MXSTATUS register
//  Machine Extension Status register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Extension Status of the current core
//  the definiton for MXSTATUS register is listed as follows
//==========================================================
assign pm_wen = rtu_cp0_expt_vld
                || iui_regs_inst_ertn;

// &CombBeg; @1889
always @( rtu_cp0_expt_vld
       or pm[1:0]
       or sstatus_spp
       or mpp[1:0]
       or iui_regs_inst_sret
       or iui_regs_inst_ertn)
begin
  if(rtu_cp0_expt_vld)
    pm_wdata[1:0] = 2'b00;
  else if(iui_regs_inst_ertn)
    pm_wdata[1:0] = mpp[1:0];
  else if(iui_regs_inst_sret)
    pm_wdata[1:0] = {1'b0, sstatus_spp};
  else
    pm_wdata[1:0] = pm[1:0];
// &CombEnd; @1900
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pm[1:0] <= 2'b11;
  else if(pm_wen)
    pm[1:0] <= pm_wdata[1:0];
  else 
    pm[1:0] <= pm[1:0];
end

assign cp0_had_trace_pm_wen = pm_wen;
assign cp0_had_trace_pm_wdata[1:0] = pm_wdata[1:0];

always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    mm    <= 1'b1;
    pmds  <= 1'b0;
    pmdu  <= 1'b0;
  end
  else if(mxstatus_local_en)
  begin
    mm    <= iui_regs_src0[15];
    pmds  <= iui_regs_src0[11];
    pmdu  <= iui_regs_src0[10];
  end
  else if(sxstatus_local_en)
  begin
    mm    <= iui_regs_src0[15];
    pmds  <= iui_regs_src0[11];
    pmdu  <= iui_regs_src0[10];
  end
  else if(mhpmcr_local_en)
  begin
    mm    <= mm;
    pmds  <= iui_regs_src0[11];
    pmdu  <= iui_regs_src0[10];
  end
  else if(shpmcr_local_en)
  begin
    mm    <= mm;
    pmds  <= iui_regs_src0[11];
    pmdu  <= iui_regs_src0[10];
  end
  else
  begin
    mm    <= mm;
    pmds  <= pmds;
    pmdu  <= pmdu;
  end
end
assign fccee = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    cskyisaee <= 1'b1;
    maee      <= 1'b1;
    insde     <= 1'b0;
    mhrd      <= 1'b0;
    clintee   <= 1'b1;
    ucme      <= 1'b1;
    pmdm      <= 1'b0;
  end
  else if(mxstatus_local_en)
  begin
    cskyisaee <= iui_regs_src0[22];
    maee      <= iui_regs_src0[21];
    insde     <= iui_regs_src0[19];
    mhrd      <= iui_regs_src0[18];
    clintee   <= iui_regs_src0[17];
    ucme      <= iui_regs_src0[16];
    pmdm      <= iui_regs_src0[13];
  end
  else if(mhpmcr_local_en)
  begin
    cskyisaee <= cskyisaee;
    maee      <= maee;
    insde     <= insde;
    mhrd      <= mhrd;
    clintee   <= clintee;
    ucme      <= ucme;
    pmdm      <= iui_regs_src0[13];
  end
  else
  begin
    cskyisaee <= cskyisaee;
    maee      <= maee;
    insde     <= insde;
    mhrd      <= mhrd;
    clintee   <= clintee;
    ucme      <= ucme;
    pmdm      <= pmdm;
  end
end


assign ve = 1'b0;
assign v  = 1'b0;

assign mxstatus_value[63:0]  = {32'b0, pm[1:0], 7'b0, cskyisaee, maee,
                                fccee, insde, mhrd, clintee, ucme, mm,
                                1'b0, pmdm, 1'b0, pmds, pmdu, v, ve, 
                                8'b0};

//==========================================================
//               Define the MHCR register
//  Machine Hardware Config register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Hardware Config of the current core
//  the definiton for MHCR register is listed as follows
//==========================================================
assign sck[2:0] = 3'b0;//biu_cp0_clkratio[2:0];

assign wbr = 1'b1;

// always @(posedge regs_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b)
//     ibpe <= ifu_ind_btb_en;
//   else if(mhcr_local_en)
//     ibpe <= iui_regs_src0[7];
//   else
//     ibpe <= ibpe;
// end

// always @(posedge regs_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b)
//   begin
//     l0btbe <= ifu_enable_l0btb;
//     btbe   <= ifu_enable_btb;
//   end
//   else if(mhcr_local_en)
//   begin
//     l0btbe <= iui_regs_src0[12];
//     btbe   <= iui_regs_src0[6];
//   end
//   else
//   begin
//     l0btbe <= l0btbe;
//     btbe   <= btbe;
//   end
// end

// assign wb = 1'b1;

// //==========================================================
// //               Enable/Disable ICache/DCache
// //==========================================================

// always @(posedge regs_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b)
//   begin
//     bpe <= ifu_bht_enable;
//     rse <= ifu_rsa_enable;
//     wa  <= dcache_write_alloc_enable;
//     de  <= dcache_reset_enable;
//     ie  <= icache_reset_enable;
//   end
//   else if(mhcr_local_en)
//   begin
//     bpe <= iui_regs_src0[5];
//     rse <= iui_regs_src0[4];
//     wa  <= iui_regs_src0[2];
//     de  <= iui_regs_src0[1];
//     ie  <= iui_regs_src0[0];
//   end
//   else
//   begin
//     bpe <= bpe;
//     rse <= rse;
//     wa  <= wa;
//     de  <= de;
//     ie  <= ie;
//   end
// end

assign mhcr_value[63:0] = {45'b0, sck[2:0], 3'b0, l0btbe, 3'b0, wbr, ibpe,
                           btbe, bpe, rse, wb, wa, de, ie};

//==========================================================
//               Define the MCOR register
//  Machine Cache Operation register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Operation Interface
//  the definiton for MCOR register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      ibp_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
      ibp_inv <= 1'b0;
  else if(mcor_local_en) 
      ibp_inv <= iui_regs_src0[18];
  else if(ifu_cp0_ind_btb_inv_done)
      ibp_inv <= 1'b0;
  else
      ibp_inv <= ibp_inv;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    btb_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
    btb_inv <= 1'b0;
  else if(mcor_local_en) 
    btb_inv <= iui_regs_src0[17];
  else if(ifu_cp0_btb_inv_done)
    btb_inv <= 1'b0;
  else
    btb_inv <= btb_inv;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
    bht_inv <= 1'b0;
  else if(mcor_local_en) 
    bht_inv <= iui_regs_src0[16];
  else if(ifu_cp0_bht_inv_done)
    bht_inv <= 1'b0;
  else
    bht_inv <= bht_inv;
end

//if sel dcache bit is set, wait lsu dcache done
//else always done
assign clr_done = !sel[1] || lsu_cp0_dcache_done;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
   clr <= 1'b0;
  else if(rtu_yy_xx_flush)
   clr <= 1'b0;
  else if(mcor_local_en) 
   clr <= iui_regs_src0[5];
  else if(clr && clr_done)
   clr <= 1'b0;
  else
   clr <= clr;
end

// 1.when inv and clr complete, clear the inv and clr bit.
// 2.mtcr cfr will update inv and clr bit
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      icache_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
      icache_inv <= 1'b0;
  else if(mcor_local_en) 
      icache_inv <= iui_regs_src0[4];
  else if(icache_inv && (ifu_cp0_icache_inv_done || !sel[0]))
      icache_inv <= 1'b0;
  else
      icache_inv <= icache_inv;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      dcache_inv <= 1'b0;
  else if(rtu_yy_xx_flush)
      dcache_inv <= 1'b0;
  else if(mcor_local_en) 
      dcache_inv <= iui_regs_src0[4];
  else if(dcache_inv && (lsu_cp0_dcache_done || !sel[1]))
      dcache_inv <= 1'b0;
  else
      dcache_inv <= dcache_inv;
end

assign inv = icache_inv || dcache_inv;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sel[1:0] <= 2'b0;
  else if(mcor_local_en) 
    sel[1:0] <= iui_regs_src0[1:0];
  else
    sel[1:0] <= sel[1:0];
end

assign mcor_value[63:0] = {45'b0, ibp_inv, btb_inv, bht_inv, 10'b0,
                           clr, inv, 2'b0, sel[1:0]};
assign cfr_bits_done = ifu_cp0_ind_btb_inv_done || ifu_cp0_btb_inv_done
                    || ifu_cp0_bht_inv_done || clr && clr_done
                    || icache_inv && (ifu_cp0_icache_inv_done || !sel[0])
                    || dcache_inv && (lsu_cp0_dcache_done || !sel[1]);

//==========================================================
//               Define the MHINT register
//  Machine Hint register
//  64-bit Machine Mode Read/Write
//  Providing the hint register
//  the definiton for MHINT register is listed as follows
//  BIU burst enable
//  LSU read weak order enable
//  PLB preload enable
//==========================================================
assign ecc_en = 1'b0;

// wire default_icache_pref_en = 1'b1;
// wire default_dcache_pref_en = 1'b1;
// wire default_l2_st_pref_en  = 1'b1;
// wire default_l2_pref_en     = 1'b1;

// `ifdef CPU_SINGLE_RETIRE
//   wire default_rob_single_retire  = 1'b1;
// `else 
//   wire default_rob_single_retire  = 1'b0;
// `endif

// always @(posedge regs_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b) begin
//     corr_dis              <= 1'b0;
//     fencei_broad_dis      <= 1'b0;
//     fencerw_broad_dis     <= 1'b0;
//     tlb_broad_dis         <= 1'b0;
//     l2stpld               <= default_l2_st_pref_en;
//     nsfe                  <= 1'b0;
//     l2_pref_dist[1:0]     <= 2'b10;
//     l2pld                 <= default_l2_pref_en;
//     dcache_pref_dist[1:0] <= 2'b10;
//     sre                   <= default_rob_single_retire;
//     iwpe                  <= 1'b0;
//     lpe                   <= ifu_lbuf_enable;
//     icache_pref_en        <= default_icache_pref_en;
//     amr2                  <= 1'b0;
//     amr                   <= 1'b0;
//     dcache_pref_en        <= default_dcache_pref_en;
//   end
//   else if(mhint_local_en) begin
//     corr_dis              <= iui_regs_src0[24];
//     fencei_broad_dis      <= iui_regs_src0[23];
//     fencerw_broad_dis     <= iui_regs_src0[22];
//     tlb_broad_dis         <= iui_regs_src0[21];
//     l2stpld               <= iui_regs_src0[20];
//     nsfe                  <= iui_regs_src0[18];
//     l2_pref_dist[1:0]     <= iui_regs_src0[17:16]; 
//     l2pld                 <= iui_regs_src0[15];
//     dcache_pref_dist[1:0] <= iui_regs_src0[14:13];
//     sre                   <= iui_regs_src0[11];
//     iwpe                  <= iui_regs_src0[10];
//     lpe                   <= iui_regs_src0[9];
//     icache_pref_en        <= iui_regs_src0[8];
//     amr2                  <= iui_regs_src0[5];
//     amr                   <= iui_regs_src0[3];
//     dcache_pref_en        <= iui_regs_src0[2];
//   end
//   else begin
//     corr_dis              <= corr_dis;
//     fencei_broad_dis      <= fencei_broad_dis;
//     fencerw_broad_dis     <= fencerw_broad_dis;
//     tlb_broad_dis         <= tlb_broad_dis;
//     l2stpld               <= l2stpld;
//     nsfe                  <= nsfe;
//     l2_pref_dist[1:0]     <= l2_pref_dist[1:0];
//     l2pld                 <= l2pld;
//     dcache_pref_dist[1:0] <= dcache_pref_dist[1:0];
//     sre                   <= sre;
//     iwpe                  <= iwpe;
//     lpe                   <= lpe;
//     icache_pref_en        <= icache_pref_en;
//     amr2                  <= amr2;
//     amr                   <= amr;
//     dcache_pref_en        <= dcache_pref_en;
//   end
// end

assign mhint_value[63:0] = {32'b0, 7'b0, corr_dis, fencei_broad_dis, fencerw_broad_dis,
                            tlb_broad_dis, l2stpld, ecc_en,
                            nsfe, l2_pref_dist[1:0], l2pld, 
                            dcache_pref_dist[1:0], 1'b0, sre,
                            iwpe, lpe, icache_pref_en, 2'b0, amr2,
                            1'b0, amr, dcache_pref_en, 2'b0};

//==========================================================
//               Define the MRVBR register
//  Machine Reset VBR register
//  64-bit Machine Mode Read Only
//  Providing the RVBR register
//==========================================================
// &Force("bus", "biu_cp0_rvba", 39, 0); @2400
always @(posedge forever_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    rst_sample <= 1'b0;
  else if(ifu_cp0_rst_inv_req)
    rst_sample <= 1'b1;
  else
    rst_sample <= 1'b0;
end
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mrvbr_reg[38:0] <= 39'b0; 
  else if(rst_sample)
    mrvbr_reg[38:0] <= biu_cp0_rvba[39:1];
  else
    mrvbr_reg[38:0] <= mrvbr_reg[38:0];
end

assign mrvbr_value[63:0] = {24'b0, mrvbr_reg[38:0], 1'b0};


//==========================================================
//               Define the MHINT2 register
//  Machine Hint 2 register
//  64-bit Machine Mode Read/Write
//  Providing the hint2 register
//  the definiton for MHINT2 register is listed as follows
//==========================================================
// always @(posedge regs_clk or negedge cpurst_b)
// begin
//   if(!cpurst_b) begin
//     vsetvli_pred  <= 1'b0;
//     ctc_flush_dis <= 1'b0;
//     par_dis[3:0]  <= 4'b0;
//     pfu_mmu_dis   <= 1'b0;
//     vsetvli_dis   <= 1'b0;
//     local_icg_en[8:0] <= 9'b0;
//     da_fwd_dis    <= 1'b0;
//     src2_fwd_dis  <= 1'b0;
//     div_entry_dis <= 1'b0;
//     cb_aclr_dis   <= 1'b0;
//     wr_burst_dis  <= 1'b0;
//     zero_move_dis <= 1'b0;
//     dlb_dis       <= 1'b0;
//     rob_fold_dis  <= disable_rob_fold;
//     iq_bypass_dis <= 1'b0;
//     srcv2_fwd_dis <= 1'b0;
//   end
//   else if(mhint2_local_en) begin
//     vsetvli_pred  <= iui_regs_src0[33];
//     ctc_flush_dis <= iui_regs_src0[32];
//     par_dis[3:0]  <= iui_regs_src0[31:28];
//     pfu_mmu_dis   <= iui_regs_src0[27];
//     vsetvli_dis   <= iui_regs_src0[26];
//     local_icg_en[8:0] <= iui_regs_src0[22:14];
//     da_fwd_dis    <= iui_regs_src0[13];
//     src2_fwd_dis  <= iui_regs_src0[12];
//     div_entry_dis <= iui_regs_src0[11];
//     cb_aclr_dis   <= iui_regs_src0[10];
//     wr_burst_dis  <= iui_regs_src0[9];
//     zero_move_dis <= iui_regs_src0[4];
//     dlb_dis       <= iui_regs_src0[3];
//     rob_fold_dis  <= iui_regs_src0[2];
//     iq_bypass_dis <= iui_regs_src0[1];
//     srcv2_fwd_dis <= iui_regs_src0[0];
//   end
//   else begin
//     vsetvli_pred  <= vsetvli_pred;
//     ctc_flush_dis <= ctc_flush_dis;
//     par_dis[3:0]  <= par_dis[3:0];
//     pfu_mmu_dis   <= pfu_mmu_dis;
//     vsetvli_dis   <= vsetvli_dis;
//     local_icg_en[8:0] <= local_icg_en[8:0];
//     da_fwd_dis    <= da_fwd_dis;
//     src2_fwd_dis  <= src2_fwd_dis;
//     div_entry_dis <= div_entry_dis;
//     cb_aclr_dis   <= cb_aclr_dis;
//     wr_burst_dis  <= wr_burst_dis;
//     zero_move_dis <= zero_move_dis;
//     dlb_dis       <= dlb_dis;
//     rob_fold_dis  <= rob_fold_dis;
//     iq_bypass_dis <= iq_bypass_dis;
//     srcv2_fwd_dis <= srcv2_fwd_dis;
//   end
// end

assign mhint2_value[63:0] = {30'b0, vsetvli_pred, ctc_flush_dis, par_dis[3:0], pfu_mmu_dis, vsetvli_dis, 3'b0,
                            local_icg_en[8:0], da_fwd_dis, src2_fwd_dis, div_entry_dis, cb_aclr_dis,
                            wr_burst_dis, 4'b0, zero_move_dis, 
                            dlb_dis, rob_fold_dis, iq_bypass_dis, srcv2_fwd_dis};

//==========================================================
//               Define the MHINT3 register
//  Machine Hint 3 register
//  64-bit Machine Mode Read/Write
//  Providing the hint3 register
//  the definiton for MHINT3 register is listed as follows
//==========================================================
//rst value
//timeout_cnt = 64,no_req_cnt = 16
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    timeout_cnt[29:0] <= 30'h10404040; 
  end
  else if(mhint3_local_en) begin
    timeout_cnt[29:0] <= iui_regs_src0[29:0];
  end
  else begin
    timeout_cnt[29:0] <= timeout_cnt[29:0];
  end
end

assign mhint3_value[63:0] = {32'b0, 2'b0, timeout_cnt[29:0]};

//==========================================================
//               Define the MCNTWEN register
//  Machine Counter Write Enable Register
//  64-bit Machine Mode Read/Write
//  Providing the Write Enable info for S-Mode Interface to
//  Mode Counters
//  the definiton for MCNTWEN register is listed as follows
//  HPM31...HPM3, IR, TM, CY
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mcntwen_reg[31:0] <= 32'b0;
  else if(mcntwen_local_en)
    mcntwen_reg[31:0] <= {iui_regs_src0[31:2], 1'b0, iui_regs_src0[0]};
  else
    mcntwen_reg[31:0] <= mcntwen_reg[31:0];
end

assign mcntwen_value[63:0] = {32'b0, mcntwen_reg[31:0]};

assign mteecfg_value[63:0]   = 64'b0;
assign tee_lock              = 1'b0;
assign tee_ff                = 1'b0;

assign regs_iui_tee_vld      = 1'b1;
assign regs_iui_chk_vld      = 1'b0;
assign regs_iui_tee_ff       = 1'b1;

//==========================================================
//               Define the MCER register
//  Machine Cache Error Register
//  64-bit Machine Mode Read/Write
//  Providing the Cache Error Information
//  the definiton for MCER register is listed as follows
//==========================================================
// &Instance("gated_clk_cell", "x_ecc_gated_clk"); @2656
// &Connect(.clk_in      (forever_cpuclk), @2657
//          .external_en (1'b0), @2658
//          .global_en   (cp0_yy_clk_en), @2659
//          .module_en   (regs_xx_icg_en), @2660
//          .local_en    (ecc_clk_en), @2661
//          .clk_out     (ecc_clk)); @2662
assign mcer_value[63:0] = 64'b0;
assign ecc_int_vld = 1'b0;


//==========================================================
//               Define the MEICR register
//  Machine Error Injection Control Register
//  64-bit Machine Mode Read/Write
//  Providing the Cache Error Injection function
//  the definiton for MEICR register is listed as follows
//==========================================================
assign meicr_value[63:0] = 64'b0;


//==========================================================
//               Define the MCINS register
//  Machine Cache Instruction register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Read Line Instruction
//  the definiton for MCINS register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cins_r <= 1'b0;
  else if(rtu_yy_xx_flush)
    cins_r <= 1'b0;
  else if(mcins_local_en)
    cins_r <= iui_regs_src0[0];
  else if(cins_read_data_vld)
    cins_r <= 1'b0;
  else
    cins_r <= cins_r;
end
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cins_ff <= 1'b0;
  else if(rtu_yy_xx_flush)
    cins_ff <= 1'b0;
  else if(mcins_local_en)
    cins_ff <= iui_regs_src0[0];
  else if(cins_ff && (!regs_dca_sel || biu_cp0_cmplt))
    cins_ff <= 1'b0;
  else
    cins_ff <= cins_ff;
end

//write only register
assign mcins_value[63:0] = 64'd0;

//==========================================================
//               Define the MCINDEX register
//  Machine Cache Read Line Index register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Read Line Index
//  the definiton for MCINDEX register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cindex_rid[3:0]    <= 4'b0;
    cindex_way[3:0]    <= 4'b0;
    cindex_index[20:0] <= 21'b0;
  end
  else if (mcindex_local_en) begin
    cindex_rid[3:0]    <= iui_regs_src0[31:28];
    cindex_way[3:0]    <= iui_regs_src0[24:21];
    cindex_index[20:0] <= iui_regs_src0[20:0];
  end
  else begin
    cindex_rid[3:0]    <= cindex_rid[3:0];
    cindex_way[3:0]    <= cindex_way[3:0];
    cindex_index[20:0] <= cindex_index[20:0];
  end
end

assign mcindex_value[63:0] = {32'b0, cindex_rid[3:0], 3'b0,
                              cindex_way[3:0], cindex_index[20:0]};

//ram select
assign cindex_rid_icache_tag           = (cindex_rid[3:0] == 4'd0);
assign cindex_rid_icache_data          = (cindex_rid[3:0] == 4'd1);
assign cindex_rid_dcache_st_tag        = (cindex_rid[3:0] == 4'd2);
assign cindex_rid_dcache_data          = (cindex_rid[3:0] == 4'd3);
assign cindex_rid_l2cache_tag          = (cindex_rid[3:0] == 4'd4);
assign cindex_rid_l2cache_data         = (cindex_rid[3:0] == 4'd5);

assign cindex_rid_dcache_ld_tag        = (cindex_rid[3:0] == 4'd12);

assign cindex_rid_icache_tag_ecc       = 1'b0;
assign cindex_rid_icache_data_ecc      = 1'b0;
assign cindex_rid_dcache_st_tag_ecc    = 1'b0;
assign cindex_rid_dcache_data_ecc      = 1'b0;
assign cindex_rid_dcache_ld_tag_ecc    = 1'b0;

assign cindex_rid_l2cache_tag_ecc      = 1'b0;
assign cindex_rid_l2cache_data_ecc     = 1'b0;


//==========================================================
//               Define the MCDATA0/1 register
//  Machine Cache Read Line Data register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY Cache Read Line Data Register
//  the definiton for MCDATA0/1 register is listed as follows
//==========================================================
assign cdata_data_vld = ifu_cp0_icache_read_data_vld
                     || lsu_cp0_dcache_read_data_vld
                     || biu_cp0_cmplt;
// &CombBeg; @2943
always @( lsu_cp0_dcache_read_data_vld
       or biu_cp0_rdata[127:0]
       or ifu_cp0_icache_read_data[127:0]
       or ifu_cp0_icache_read_data_vld
       or biu_cp0_cmplt
       or lsu_cp0_dcache_read_data[127:0])
begin
  case({biu_cp0_cmplt,
        lsu_cp0_dcache_read_data_vld,
        ifu_cp0_icache_read_data_vld})
    3'b001 : cdata_read_data[127:0] = ifu_cp0_icache_read_data[127:0];
    3'b010 : cdata_read_data[127:0] = lsu_cp0_dcache_read_data[127:0];
    3'b100 : cdata_read_data[127:0] = biu_cp0_rdata[127:0];
    default: cdata_read_data[127:0] = {128{1'bx}};
  endcase
// &CombEnd; @2952
end

always @(posedge cdata_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    cdata0[63:0] <= 64'b0;
    cdata1[63:0] <= 64'b0;
  end
  else if (cdata_data_vld) begin
    cdata0[63:0] <= cdata_read_data[63:0];
    cdata1[63:0] <= cdata_read_data[127:64];
  end
  else begin
    cdata0[63:0] <= cdata0[63:0];
    cdata1[63:0] <= cdata1[63:0];
  end
end

assign mcdata0_value[63:0] = cdata0[63:0];
assign mcdata1_value[63:0] = cdata1[63:0];

assign cins_no_op_data_vld = cins_r
                             && !(cindex_rid_icache_tag
                               || cindex_rid_icache_data
                               || cindex_rid_dcache_st_tag
                               || cindex_rid_dcache_data
                               || cindex_rid_l2cache_tag
                               || cindex_rid_l2cache_data
                               || cindex_rid_icache_tag_ecc
                               || cindex_rid_icache_data_ecc
                               || cindex_rid_dcache_st_tag_ecc
                               || cindex_rid_dcache_data_ecc
                               || cindex_rid_l2cache_tag_ecc
                               || cindex_rid_l2cache_data_ecc
                               || cindex_rid_dcache_ld_tag
                               || cindex_rid_dcache_ld_tag_ecc
                               );

assign cins_read_data_vld  = cdata_data_vld || cins_no_op_data_vld;


//==========================================================
//               Define the MCPUID register
//  Machine CPUID register
//  64-bit Machine Mode Read/Write
//  Providing the C-SKY CPUID Register
//  the definiton for MCPUID register is listed as follows
//==========================================================
//----------------------------------------------------------
//                    Index Register
//----------------------------------------------------------
assign index_max = (index[2:0] == 3'd6);
assign index_next_val[2:0] = (index_max) ? 3'd0
                                         : index[2:0] + 3'd1;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    index[2:0] <= 3'b0;
  else if(iui_regs_ex3_inst_csr && mcpuid_local_en)
    index[2:0] <= index_next_val[2:0];
  else
    index[2:0] <= index[2:0];
end

//----------------------------------------------------------
//                Inplement of cpuid register
//----------------------------------------------------------
// &CombBeg; @3020
always @( cpuid_index1_value[31:0]
       or cpuid_index2_value[31:0]
       or cpuid_index5_value[31:0]
       or index[2:0]
       or cpuid_index6_value[31:0]
       or cpuid_index0_value[31:0]
       or cpuid_index4_value[31:0]
       or cpuid_index3_value[31:0])
begin
  case(index[2:0])
  3'b000   : mcpuid_value[31:0] = cpuid_index0_value[31:0];
  3'b001   : mcpuid_value[31:0] = cpuid_index1_value[31:0];
  3'b010   : mcpuid_value[31:0] = cpuid_index2_value[31:0];
  3'b011   : mcpuid_value[31:0] = cpuid_index3_value[31:0];
  3'b100   : mcpuid_value[31:0] = cpuid_index4_value[31:0];
  3'b101   : mcpuid_value[31:0] = cpuid_index5_value[31:0];
  3'b110   : mcpuid_value[31:0] = cpuid_index6_value[31:0];
  default  : mcpuid_value[31:0] = 32'b0;
  endcase
// &CombEnd; @3031
end

//---------------------------------------------------------
//                    Index 0
//---------------------------------------------------------
    assign cpuid_index0_value[31:28] = 4'b0000;

//------------------------------------------------
//                     Arch  
//------------------------------------------------
    assign cpuid_index0_value[27:26] = 2'b10;   // CSKY V3 ISA Arch

//------------------------------------------------
//                     Family
//------------------------------------------------
    assign cpuid_index0_value[25:22] = 4'b0100; // C Series Family

//------------------------------------------------
//                     Class 
//------------------------------------------------
    assign cpuid_index0_value[21:18] = 4'b0011; // C960 Class

//------------------------------------------------
//                     Model 
//------------------------------------------------
    assign cpuid_index0_value[17:12] = 6'b0; 
    assign cpuid_index0_value[11] = 1'b0;
    assign cpuid_index0_value[10] = 1'b0;  
    assign cpuid_index0_value[9] = 1'b0;
    assign cpuid_index0_value[8] = 1'b1;  //FPU

//------------------------------------------------
//                    ISA Revision
//------------------------------------------------
//Revision 0:
//  Initial revision
    assign cpuid_index0_value[7:3] = 5'b00001; 

//------------------------------------------------
//                     Version
//------------------------------------------------
    assign cpuid_index0_value[2:0] = 3'b101; //CPID Rev.5.0

//---------------------------------------------------------
//                    Index 1
//---------------------------------------------------------
    assign cpuid_index1_value[31:28] = 4'b0001;

//------------------------------------------------
//                    Revision
//------------------------------------------------
    assign cpuid_index1_value[27:24] = `REVISION;

//------------------------------------------------
//                  Sub Version
//------------------------------------------------
    assign cpuid_index1_value[23:18] = `SUB_VERSION;

//------------------------------------------------
//                     Patch
//------------------------------------------------
    assign cpuid_index1_value[17:12] = `PATCH;

//------------------------------------------------
//                    PRODUCT ID
//------------------------------------------------
    assign cpuid_index1_value[11:0] = `PRODUCT_ID;

//---------------------------------------------------------
//                    Index 2
//---------------------------------------------------------
    assign cpuid_index2_value[31:28] = 4'b0010;

//---------------------------------------------------------
//                    BUS0 
//---------------------------------------------------------
    assign cpuid_index2_value[27:24] = 4'b0110; //AXI128

//---------------------------------------------------------
//                    BUS1
//---------------------------------------------------------
    assign cpuid_index2_value[23:20] = 4'b0;

//---------------------------------------------------------
//                    PLIC
//---------------------------------------------------------
    assign cpuid_index2_value[19] = 1'b1;

//---------------------------------------------------------
//                    CLINT
//---------------------------------------------------------
    assign cpuid_index2_value[18] = 1'b1;

//------------------------------------------------
//                    Reserved 
//------------------------------------------------
    assign cpuid_index2_value[17:16] = 2'b0;

//---------------------------------------------------------
//                    COPROCESSOR
//---------------------------------------------------------
    assign cpuid_index2_value[15:1] = 15'b0;

    assign cpuid_index2_value[0]     = 1'b1;

//---------------------------------------------------------
//                    Index 3
//---------------------------------------------------------
    assign cpuid_index3_value[31:28] = 4'b0011;

//------------------------------------------------
//                    Reserved 
//------------------------------------------------
    assign cpuid_index3_value[27:25] = 3'b0;


//------------------------------------------------
//                    IBP 
//------------------------------------------------
    assign cpuid_index3_value[24:22] = 3'b001;

//------------------------------------------------
//                      BTB
//------------------------------------------------
    assign cpuid_index3_value[21:19] = 3'b010; 

//------------------------------------------------
//                      BHT   
//------------------------------------------------
    assign cpuid_index3_value[18:16] = 3'b011; //8K BHT 

//------------------------------------------------
//                      DSPM 
//------------------------------------------------
    assign cpuid_index3_value[15:12] = 4'b0000; 

//------------------------------------------------
//                      ISPM 
//------------------------------------------------
    assign cpuid_index3_value[11:8] = 4'b0000; 

//------------------------------------------------
//                     DCACHE
//------------------------------------------------
    assign cpuid_index3_value[7:4]   = 4'b0111;

//------------------------------------------------
//                     ICACHE
//------------------------------------------------
    assign cpuid_index3_value[3:0]   = 4'b0111;
//---------------------------------------------------------
//                    Index 4
//---------------------------------------------------------
    assign cpuid_index4_value[31:28] = 4'b0100;

//------------------------------------------------
//                 ICache Way Info
//------------------------------------------------
    assign cpuid_index4_value[27:26] = 2'b0; // 2-Way

//------------------------------------------------
//                ICache Line Size
//------------------------------------------------
    assign cpuid_index4_value[25:24] = 2'b10; // 64-Bytes

//------------------------------------------------
//                   ICache ECC
//------------------------------------------------
    assign cpuid_index4_value[23:22] = 2'b0; // NO ECC

//------------------------------------------------
//                 DCache Way Info
//------------------------------------------------
    assign cpuid_index4_value[21:20] = 2'b0; // 2-Way

//------------------------------------------------
//                DCache Line Size
//------------------------------------------------
    assign cpuid_index4_value[19:18] = 2'b10; // 64-Bytes

//------------------------------------------------
//                   DCache ECC
//------------------------------------------------
    assign cpuid_index4_value[17:16] = 2'b0; // NO ECC

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index4_value[15:12] = 4'b0;

//------------------------------------------------
//                    WAY
//------------------------------------------------
    assign cpuid_index4_value[11:8] = 4'b0100;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index4_value[7:6] = 2'b0;

//------------------------------------------------
//                    ECC
//------------------------------------------------
    assign cpuid_index4_value[5:4] = 2'b0;

//------------------------------------------------
//                  L2 CACHE
//------------------------------------------------
    assign cpuid_index4_value[3:0] = 4'b0111;

//---------------------------------------------------------
//                    Index 5
//---------------------------------------------------------
    assign cpuid_index5_value[31:28] = 4'b0101;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index5_value[27:4] = 24'b0;

//------------------------------------------------
//                    SLAVEIF
//------------------------------------------------
    assign cpuid_index5_value[3] = 1'b0;

//------------------------------------------------
//                    CORENUM
//------------------------------------------------
    assign cpuid_index5_core_num_1 = 1'b1;
    assign cpuid_index5_core_num_2 = 1'b0;
    assign cpuid_index5_core_num_3 = 1'b0;
    assign cpuid_index5_value[2:0] = {2'b0, cpuid_index5_core_num_1}
                                   + {2'b0, cpuid_index5_core_num_2}
                                   + {2'b0, cpuid_index5_core_num_3};
  
//---------------------------------------------------------
//                    Index 6
//---------------------------------------------------------
    assign cpuid_index6_value[31:28] = 4'b0110;

//------------------------------------------------
//                    Reserved
//------------------------------------------------
    assign cpuid_index6_value[27:12] = 16'b0;

//------------------------------------------------
//                    MMU_TLB
//------------------------------------------------
    assign cpuid_index6_value[11:8] = 4'b1010;

//------------------------------------------------
//                    MGU ZONE SIZE
//------------------------------------------------
    assign cpuid_index6_value[7:4] = 4'b0101; // PMP 4K

//------------------------------------------------
//                    MGU ZONE NUM
//------------------------------------------------
    assign cpuid_index6_value[3:0] = 4'b0011; 

//==========================================================
//               Define the MAPBADDR register
//==========================================================
assign mapbaddr_value[63:0] = {{24{biu_cp0_apb_base[39]}}, biu_cp0_apb_base[39:0]};

//==========================================================
//               Define the MWMSR register
//==========================================================
assign mwmsr_value[63:0] = 64'b0;

//==========================================================
//               Define the SXSTATUS register
//  Supervisor Extension Status Register
//  64-bit Supervisor Mode Read/Write
//  Providing the C-SKY Extension Status Register
//  the definiton for SXSTATUS register is listed as follows
//==========================================================
assign sxstatus_value[63:0]  = {32'b0, pm[1:0], 7'b0, cskyisaee, maee,
                                fccee, insde, mhrd, clintee, ucme, mm,
                                1'b0, pmdm, 1'b0, pmds, pmdu, 10'b0};


//==========================================================
//               Define the SHCR register
//  Supervisor Hardware Config register
//  64-bit Supervisor Mode Read Only
//  Providing the C-SKY Hardware Config of the current core
//  the definiton for SHCR register is listed as follows
//==========================================================
assign shcr_value[63:0] = {45'b0, sck[2:0], 3'b0, l0btbe, 3'b0, wbr, ibpe,
                           btbe, bpe, rse, wb, wa, de, ie};


//==========================================================
//               Define the SCER register
//  Supervisor Cache Error Register
//  64-bit Supervisor Mode Read Only
//  Providing the Cache Error Information
//  the definiton for MCER register is listed as follows
//==========================================================
assign scer_value[63:0] = 64'b0;


//==========================================================
//               Define the FXCR register
//  Float Point Extension Control Register
//  64-bit User Mode Read/Write
//  Providing the C-SKY Float Point Register
//  the definiton for FXCR register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    fxcr_dqnan   <= 1'b0;
    fxcr_fe      <= 1'b0;
  end
  else if (fxcr_local_en)
  begin
    fxcr_dqnan   <= iui_regs_src0[23];
    fxcr_fe      <= iui_regs_src0[5];
  end
  else if (idu_cp0_fesr_acc_updt_vld)
  begin
    fxcr_dqnan   <= fxcr_dqnan;
    fxcr_fe      <= fxcr_fe || idu_cp0_fesr_acc_updt_val[5];
  end
  else
  begin
    fxcr_dqnan   <= fxcr_dqnan;
    fxcr_fe      <= fxcr_fe;
  end
end

assign fxcr_value[63:0]    = {37'b0, fcsr_frm[2:0], fxcr_dqnan, 
                              17'b0, fxcr_fe, fcsr_nv,
                              fcsr_dz, fcsr_of, fcsr_uf, fcsr_nx};

assign cp0_vfpu_fxcr[31:0] = fxcr_value[31:0];

//==========================================================
//               Define the HSTATUS register
//  Hypervisor Status Register
//  64-bit hypervisor Mode Read/Write
//  Providing the CPU Status
//  the definiton for HSTATUS register is listed as follows
//==========================================================
assign hstatus_value[63:0] = 64'b0;

//==========================================================
//               Define the HEDELEG register
//  Hypervisor Exception Delegation Register
//  64-bit Machine Mode Read/Write
//  Providing the CPU Status
//  the definiton for HEDELEG register is listed as follows
//==========================================================
assign hedeleg_value[63:0] = 64'b0;

//==========================================================
//               Define the VSTATUS register
//  Virtial Supervisor Status Register
//  64-bit hypervisor Mode Read/Write
//  Providing the CPU Status
//  the definiton for VSSTATUS register is listed as follows
//==========================================================
assign vsstatus_value[63:0] = 64'b0;





//==========================================================
// select regs depending on the implementation location
//==========================================================
// assign cp0_regs_sel = iui_regs_addr[11:8] == 4'hF  // M-Infor
//                    || iui_regs_addr[11:4] == 8'h30 // M-Trap Setup
//                    || iui_regs_addr[11:4] == 8'h34 // M-Trap Handling
//                    || iui_regs_addr[11:4] == 8'h10 // S-Trap Setup
//                    || iui_regs_addr[11:4] == 8'h14 // S-Trap Handling
//                    || iui_regs_addr[11:4] == 8'h7C && !l2_regs_sel 
//                       && iui_regs_addr[3:1] != 3'b101 // Extension CSR 
//                    || iui_regs_addr[11:4] == 8'h7D // Extension Cache Read
//                    || iui_regs_addr[11:4] == 8'h5C && !scer2_local_en
//                       && iui_regs_addr[3:2] == 2'b00 // S-Extension CSR 
//                    || mteecfg_local_en
//                    || iui_regs_addr[11:8] == 4'h0  // User F-CSR
//                    || iui_regs_addr[11:8] == 4'h8  // FXCR
//                    || iui_regs_addr[11:8] == 4'h6  // Hypervisor CSR
//                    || iui_regs_addr[11:8] == 4'h2  // VS CSR
//                    || iui_regs_addr[11:4] == 8'hC2;// Vector

reg cp0_regs_sel_r;

always @( iui_regs_addr[11:0])
begin
  cp0_regs_sel_r = 1'b0; 
  casez(iui_regs_addr[11:0])
    ARCH      : cp0_regs_sel_r = 1'b1;
    CRMD      : cp0_regs_sel_r = 1'b1;
    PRMD      : cp0_regs_sel_r = 1'b1;
    EUEN      : cp0_regs_sel_r = 1'b1;
    MISC      : cp0_regs_sel_r = 1'b1;
    ECFG      : cp0_regs_sel_r = 1'b1;
    ESTAT     : cp0_regs_sel_r = 1'b1;
    ERA       : cp0_regs_sel_r = 1'b1;
    BADV      : cp0_regs_sel_r = 1'b1;
    BADI      : cp0_regs_sel_r = 1'b1;
    EENTRY    : cp0_regs_sel_r = 1'b1;
    TLBIDX    : cp0_regs_sel_r = 1'b1;
    TLBEHI    : cp0_regs_sel_r = 1'b1;
    TLBELO0   : cp0_regs_sel_r = 1'b1;
    TLBELO1   : cp0_regs_sel_r = 1'b1;
    ASID      : cp0_regs_sel_r = 1'b1;
    PGDL      : cp0_regs_sel_r = 1'b1;
    PGDH      : cp0_regs_sel_r = 1'b1;
    PGD       : cp0_regs_sel_r = 1'b1;
    
    PWCL      : cp0_regs_sel_r = 1'b1;
    PWCH      : cp0_regs_sel_r = 1'b1;
    STLBPS    : cp0_regs_sel_r = 1'b1;
    RVACFG    : cp0_regs_sel_r = 1'b1;
    
    CPUID     : cp0_regs_sel_r = 1'b1;
    PRCFG1    : cp0_regs_sel_r = 1'b1;
    PRCFG2    : cp0_regs_sel_r = 1'b1;
    PRCFG3    : cp0_regs_sel_r = 1'b1;
    SAVE0     : cp0_regs_sel_r = 1'b1;
    SAVE1     : cp0_regs_sel_r = 1'b1;
    SAVE2     : cp0_regs_sel_r = 1'b1;
    SAVE3     : cp0_regs_sel_r = 1'b1;
    TID       : cp0_regs_sel_r = 1'b1;
    TCFG      : cp0_regs_sel_r = 1'b1;
    TVAL      : cp0_regs_sel_r = 1'b1;
    CNTC      : cp0_regs_sel_r = 1'b1;
    TICLR     : cp0_regs_sel_r = 1'b1;
    LLBCTL    : cp0_regs_sel_r = 1'b1;

    IMPCTL1   : cp0_regs_sel_r = 1'b1;
    IMPCTL2   : cp0_regs_sel_r = 1'b1;
    
    TLBRENTRY : cp0_regs_sel_r = 1'b1;
    TLBREHI   : cp0_regs_sel_r = 1'b1;

    MERRENTRY : cp0_regs_sel_r = 1'b1;
    DMW0      : cp0_regs_sel_r = 1'b1;
    DMW1      : cp0_regs_sel_r = 1'b1;
    DMW2      : cp0_regs_sel_r = 1'b1;
    DMW3      : cp0_regs_sel_r = 1'b1;
    BRK       : cp0_regs_sel_r = 1'b1;
    DIS_CACHE : cp0_regs_sel_r = 1'b1;
    
    DEBUG0    : cp0_regs_sel_r = 1'b1;
    DEBUG1    : cp0_regs_sel_r = 1'b1;
    DGWDUMP   : cp0_regs_sel_r = 1'b1;

    CPRS      : cp0_regs_sel_r = 1'b1;
    CPRS_TCFG : cp0_regs_sel_r = 1'b1;
    CPRS_CRMD : cp0_regs_sel_r = 1'b1;

    DEBUG2    : cp0_regs_sel_r = 1'b1;
    DEBUG3    : cp0_regs_sel_r = 1'b1;
    DEBUG4    : cp0_regs_sel_r = 1'b1;
    DEBUG5    : cp0_regs_sel_r = 1'b1;
    DEBUG6    : cp0_regs_sel_r = 1'b1;
    DEBUG7    : cp0_regs_sel_r = 1'b1;

    MWPC      : cp0_regs_sel_r = 1'b1;
    MWPS      : cp0_regs_sel_r = 1'b1;
    FWPC      : cp0_regs_sel_r = 1'b1;
    FWPS      : cp0_regs_sel_r = 1'b1;

    IFUC      : cp0_regs_sel_r = 1'b1;
    CACC      : cp0_regs_sel_r = 1'b1;
    MSCC      : cp0_regs_sel_r = 1'b1;

    FCSR0     : cp0_regs_sel_r = 1'b1;
    FCSR1     : cp0_regs_sel_r = 1'b1;
    FCSR2     : cp0_regs_sel_r = 1'b1;
    FCSR3     : cp0_regs_sel_r = 1'b1;


    /// Extension CSRs
    MXSTATUS  : cp0_regs_sel_r = 1'b1;
    MHCR      : cp0_regs_sel_r = 1'b1;
    MCOR      : cp0_regs_sel_r = 1'b1;
    MCCR2     : cp0_regs_sel_r = 1'b1;
    MCER2     : cp0_regs_sel_r = 1'b1;
    MHINT     : cp0_regs_sel_r = 1'b1;
    MRVBR     : cp0_regs_sel_r = 1'b1;
    MCER      : cp0_regs_sel_r = 1'b1;
    MCNTWEN   : cp0_regs_sel_r = 1'b1;
    MCNTINTEN : cp0_regs_sel_r = 1'b1;
    MCNTOF    : cp0_regs_sel_r = 1'b1;
    MHINT2    : cp0_regs_sel_r = 1'b1;
    MHINT3    : cp0_regs_sel_r = 1'b1;
    MHINT4    : cp0_regs_sel_r = 1'b1;

    MSMPR     : cp0_regs_sel_r = 1'b1;


    MCINS     : cp0_regs_sel_r = 1'b1;
    MCINDEX   : cp0_regs_sel_r = 1'b1;
    MCDATA0   : cp0_regs_sel_r = 1'b1;
    MCDATA1   : cp0_regs_sel_r = 1'b1;
    MEICR     : cp0_regs_sel_r = 1'b1;
    MEICR2    : cp0_regs_sel_r = 1'b1;

    MCPUID    : cp0_regs_sel_r = 1'b1;
    MAPBADDR  : cp0_regs_sel_r = 1'b1;


    SXSTATUS  : cp0_regs_sel_r = 1'b1;
    SHCR      : cp0_regs_sel_r = 1'b1;
    SCER2     : cp0_regs_sel_r = 1'b1;
    SCER      : cp0_regs_sel_r = 1'b1;
    SCNTINTEN : cp0_regs_sel_r = 1'b1;
    SCNTOF    : cp0_regs_sel_r = 1'b1;
    SHINT     : cp0_regs_sel_r = 1'b1;
    SHINT2    : cp0_regs_sel_r = 1'b1;
          
    SCNTIHBT  : cp0_regs_sel_r = 1'b1;
    SHPMCR    : cp0_regs_sel_r = 1'b1;
    SHPMSP    : cp0_regs_sel_r = 1'b1;
    SHPMEP    : cp0_regs_sel_r = 1'b1;

    SMIR      : cp0_regs_sel_r = 1'b1;
    SMEL      : cp0_regs_sel_r = 1'b1;
    SMEH      : cp0_regs_sel_r = 1'b1;
    SMCIR     : cp0_regs_sel_r = 1'b1;

    FXCR      : cp0_regs_sel_r = 1'b1;

    default   : cp0_regs_sel_r = 1'b0; 
  endcase
// &CombEnd; @728
end

assign cp0_regs_sel = cp0_regs_sel_r;

assign pmp_regs_sel = 1'b0;

assign hpm_regs_sel = iui_regs_addr[11:0] == 12'h200  // PERFCTRL0
                   || iui_regs_addr[11:0] == 12'h201  // PERFCNTR0
                   || iui_regs_addr[11:0] == 12'h202  // PERFCTRL1
                   || iui_regs_addr[11:0] == 12'h203  // PERFCNTR1
                   || iui_regs_addr[11:0] == 12'h204  // PERFCTRL2
                   || iui_regs_addr[11:0] == 12'h205  // PERFCNTR2
                   || iui_regs_addr[11:0] == 12'h206  // PERFCTRL3
                   || iui_regs_addr[11:0] == 12'h207  // PERFCNTR3
                   || iui_regs_addr[11:0] == 12'h208  // PERFCTRL4
                   || iui_regs_addr[11:0] == 12'h209  // PERFCNTR4
                   || iui_regs_addr[11:0] == 12'h20a  // PERFCTRL5
                   || iui_regs_addr[11:0] == 12'h20b  // PERFCNTR5
                   || iui_regs_addr[11:0] == 12'h20c  // PERFCTRL6
                   || iui_regs_addr[11:0] == 12'h20d  // PERFCNTR6
                   ;

assign l2_regs_sel  = mccr2_local_en || mcer2_local_en 
//                   || mrmr_local_en  || mrvbr_local_en
                   || regs_dca_sel
                   || msmpr_local_en  || mteecfg_local_en && !(tee_lock && iui_regs_csr_wr)
                   || meicr2_local_en || scer2_local_en || mhint4_local_en;

assign mmu_regs_sel = iui_regs_addr[11:8] == 4'h9;


//==========================================================
// select read data from all regs in cp0
//==========================================================
// &CombBeg; @3665
always @(*)
begin
  case(iui_regs_addr[11:0])

    ARCH      : data_out[63:0] = csrarch_value[63:0];
    CRMD      : data_out[63:0] = csrcrmd_value[63:0];
    PRMD      : data_out[63:0] = csrprmd_value[63:0];
    EUEN      : data_out[63:0] = csreuen_value[63:0];
    MISC      : data_out[63:0] = csrmisc_value[63:0];
    ECFG      : data_out[63:0] = csrecfg_value[63:0];
    ESTAT     : data_out[63:0] = csrestat_value[63:0];
    ERA       : data_out[63:0] = csrera_value[63:0];
    BADV      : data_out[63:0] = csrbadv_value[63:0];
    BADI      : data_out[63:0] = csrbadi_value[63:0];

    IMPCTL1   : data_out[63:0] = csrimpctl2_value[63:0];
    IMPCTL2   : data_out[63:0] = csrimpctl1_value[63:0];

    EENTRY    : data_out[63:0] = csreentry_value[63:0];
    TLBRENTRY : data_out[63:0] = csrtlbrentry_value[63:0];
    MERRENTRY : data_out[63:0] = csrmerrentry_value[63:0];

    TLBIDX    : data_out[63:0] = csrtlbidx_value[63:0];
    TLBEHI    : data_out[63:0] = csrtlbehi_value[63:0];
    TLBELO0   : data_out[63:0] = csrtlbelo0_value[63:0];
    TLBELO1   : data_out[63:0] = csrtlbelo1_value[63:0];

    PWCL      : data_out[63:0] = csrpwcl_value[63:0];
    PWCH      : data_out[63:0] = csrpwch_value[63:0];
    STLBPS    : data_out[63:0] = csrstlbps_value[63:0];
    RVACFG    : data_out[63:0] = csrrvacfg_value[63:0];

    ASID      : data_out[63:0] = asid_value[63:0];

    DMW0      : data_out[63:0] = csrdmw0_value[63:0];
    DMW1      : data_out[63:0] = csrdmw1_value[63:0];
    DMW2      : data_out[63:0] = csrdmw2_value[63:0];
    DMW3      : data_out[63:0] = csrdmw3_value[63:0];

    TID       : data_out[63:0] = csrtid_value[63:0];
    TCFG      : data_out[63:0] = csrtcfg_value[63:0];
    TVAL      : data_out[63:0] = csrtval_value[63:0];
    CNTC      : data_out[63:0] = csrcntc_value[63:0];
    TICLR     : data_out[63:0] = csrticlr_value[63:0];

    SAVE0     : data_out[63:0] = csrsave0_value[63:0];
    SAVE1     : data_out[63:0] = csrsave1_value[63:0];
    SAVE2     : data_out[63:0] = csrsave2_value[63:0];
    SAVE3     : data_out[63:0] = csrsave3_value[63:0];

    CPUID     : data_out[63:0] = cpuid_value[63:0];
    PRCFG1    : data_out[63:0] = csrprcfg1_value[63:0];
    PRCFG2    : data_out[63:0] = csrprcfg2_value[63:0];
    PRCFG3    : data_out[63:0] = csrprcfg3_value[63:0];

    TLBREHI   : data_out[63:0] = csrrehi_value[63:0];
    
    DEBUG0    : data_out[63:0] = debug0_value[63:0];
    DEBUG1    : data_out[63:0] = debug1_value[63:0];
    DGWDUMP   : data_out[63:0] = debug_wave_dump_value[63:0];
    CPRS      : data_out[63:0] = cpcsr_value[63:0];

    DEBUG2    : data_out[63:0] = debug2_value[63:0];
    DEBUG3    : data_out[63:0] = debug3_value[63:0];
    DEBUG4    : data_out[63:0] = debug4_value[63:0];
    DEBUG5    : data_out[63:0] = debug5_value[63:0];
    DEBUG6    : data_out[63:0] = debug6_value[63:0];
    DEBUG7    : data_out[63:0] = debug7_value[63:0];

    MWPC      : data_out[63:0] = mwpc_value[63:0];
    MWPS      : data_out[63:0] = mwps_value[63:0];
    FWPC      : data_out[63:0] = fwpc_value[63:0];
    FWPS      : data_out[63:0] = fwps_value[63:0];
    
    IFUC      : data_out[63:0] = csr_ifu_value[63:0];
    CACC      : data_out[63:0] = csr_cache_value[63:0];
    MSCC      : data_out[63:0] = csr_misc_value[63:0];

    // FPU
    FCSR0     : data_out[63:0] = fcsr0_value[63:0];
    FCSR1     : data_out[63:0] = fcsr1_value[63:0];
    FCSR2     : data_out[63:0] = fcsr2_value[63:0];
    FCSR3     : data_out[63:0] = fcsr3_value[63:0];

    /// float, vector
    FFLAGS    : data_out[63:0] = fflags_value[63:0];
    FRM       : data_out[63:0] = frm_value[63:0];
    FCSR      : data_out[63:0] = fcsr_value[63:0];
    VSTART    : data_out[63:0] = vstart_value[63:0];
    VXSAT     : data_out[63:0] = vxsat_value[63:0];
    VXRM      : data_out[63:0] = vxrm_value[63:0];
    VL        : data_out[63:0] = vl_value[63:0];
    VTYPE     : data_out[63:0] = vtype_value[63:0];
    VLENB     : data_out[63:0] = vlenb_value[63:0];


    /// extension register
    MXSTATUS  : data_out[63:0] = mxstatus_value[63:0];
    MHCR      : data_out[63:0] = mhcr_value[63:0];
    MCOR      : data_out[63:0] = mcor_value[63:0];
    MHINT     : data_out[63:0] = mhint_value[63:0];
    MRVBR     : data_out[63:0] = mrvbr_value[63:0];
    MCER      : data_out[63:0] = mcer_value[63:0];
    MCNTWEN   : data_out[63:0] = mcntwen_value[63:0];
    MHINT2    : data_out[63:0] = mhint2_value[63:0];
    MHINT3    : data_out[63:0] = mhint3_value[63:0];

    MTEECFG   : data_out[63:0] = mteecfg_value[63:0];

    MCINS     : data_out[63:0] = mcins_value[63:0];
    MCINDEX   : data_out[63:0] = mcindex_value[63:0];
    MCDATA0   : data_out[63:0] = mcdata0_value[63:0];
    MCDATA1   : data_out[63:0] = mcdata1_value[63:0];
    MEICR     : data_out[63:0] = meicr_value[63:0];

    MCPUID    : data_out[63:0] = {32'b0, mcpuid_value[31:0]};
    MAPBADDR  : data_out[63:0] = mapbaddr_value[63:0];
    MWMSR     : data_out[63:0] = mwmsr_value[63:0];

    SXSTATUS  : data_out[63:0] = sxstatus_value[63:0];
    SHCR      : data_out[63:0] = shcr_value[63:0];
    SCER      : data_out[63:0] = scer_value[63:0];

    FXCR      : data_out[63:0] = fxcr_value[63:0];

    HSTATUS   : data_out[63:0] = hstatus_value[63:0];
    HEDELEG   : data_out[63:0] = hedeleg_value[63:0];

    VSSTATUS  : data_out[63:0] = vsstatus_value[63:0];

    default   : data_out[63:0] = 64'b0; 
  endcase
// &CombEnd; @3742
end


//==========================================================
//                    CPUCFG 0 Register
//==========================================================
wire [63:0] cpucfg_0_value = {40'b0, 8'h14, 12'hc00, 1'b0, cpuid_value[2:0]};

//==========================================================
//                    CPUCFG 1 Register
//==========================================================

wire [1:0] cpucfg_1_arch       = 2'b10;
wire       cpucfg_1_pgmmu      = 1'b1;
wire       cpucfg_1_iocsr      = 1'b0;
wire [7:0] cpucfg_1_palen      = 8'd38;
wire [7:0] cpucfg_1_valen      = 8'd47;
wire       cpucfg_1_ual        = 1'b1;
wire       cpucfg_1_ri         = 1'b0;
wire       cpucfg_1_ep         = 1'b0;
wire       cpucfg_1_rplv       = 1'b0;
wire       cpucfg_1_hp         = 1'b1;
wire       cpucfg_1_crc        = 1'b1;
wire       cpucfg_1_msg_int    = 1'b0;

wire [63:0] cpucfg_1_value = {{37'b0}, 
                              cpucfg_1_msg_int, 
                              cpucfg_1_crc,
                              cpucfg_1_hp,
                              cpucfg_1_rplv,
                              cpucfg_1_ep,
                              cpucfg_1_ri,
                              cpucfg_1_ual,
                              cpucfg_1_valen,
                              cpucfg_1_palen,
                              cpucfg_1_iocsr,
                              cpucfg_1_pgmmu,
                              cpucfg_1_arch};

//==========================================================
//                    CPUCFG 2 Register
//==========================================================
wire       cpucfg_2_fp         = 1'b1; 
wire       cpucfg_2_fp_sp      = 1'b1; 
wire       cpucfg_2_fp_dp      = 1'b1; 
wire [2:0] cpucfg_2_fp_ver     = 3'b0; 
wire       cpucfg_2_lsx        = 1'b0;
wire       cpucfg_2_lasx       = 1'b0;
wire       cpucfg_2_complex    = 1'b0;
wire       cpucfg_2_crypto     = 1'b0;
wire       cpucfg_2_lvz        = 1'b0;
wire [2:0] cpucfg_2_lvz_ver    = 3'b0;
wire       cpucfg_2_llftp      = 1'b1;
wire [2:0] cpucfg_2_llftp_ver  = 3'b0;
wire       cpucfg_2_lbt_x86    = 1'b0;
wire       cpucfg_2_lbt_arm    = 1'b0;
wire       cpucfg_2_lbt_mips   = 1'b0;
wire       cpucfg_2_lspw       = 1'b0;
wire       cpucfg_2_lam        = 1'b1;
wire       cpucfg_2_hptw       = 1'b1;

wire [63:0] cpucfg_2_value = {{39'b0},
                              cpucfg_2_hptw,
                              1'b0,             // bit 23
                              cpucfg_2_lam,
                              cpucfg_2_lspw,
                              cpucfg_2_lbt_mips,
                              cpucfg_2_lbt_arm,
                              cpucfg_2_lbt_x86,
                              cpucfg_2_llftp_ver,
                              cpucfg_2_llftp,
                              cpucfg_2_lvz_ver,
                              cpucfg_2_lvz,
                              cpucfg_2_crypto,
                              cpucfg_2_complex,
                              cpucfg_2_lasx,
                              cpucfg_2_lsx,
                              cpucfg_2_fp_ver,
                              cpucfg_2_fp_dp,
                              cpucfg_2_fp_sp,
                              cpucfg_2_fp};

//==========================================================
//                    CPUCFG 3 Register
//==========================================================
wire [63:0] cpucfg_3_value  = 64'b0;


//==========================================================
//                    CPUCFG 4 Register
//==========================================================
wire [31:0] cc_freq         = 32'd100000000; // 100MHz default

wire [63:0] cpucfg_4_value  = {32'b0, cc_freq};

//==========================================================
//                    CPUCFG 5 Register
//==========================================================

wire [15:0] cpucfg_5_cc_mul = 16'd1;
wire [15:0] cpucfg_5_cc_div = 16'd1;

wire [63:0] cpucfg_5_value  = {{32'b0}, 
                               cpucfg_5_cc_div[15:0],
                               cpucfg_5_cc_mul[15:0]};

//==========================================================
//                    CPUCFG 6 Register
//==========================================================

wire        cpucfg_6_pmp     = 1'b1;
wire [2:0]  cpucfg_6_pmver   = 3'b1;
wire [3:0]  cpucfg_6_pmnum   = 4'd3; // default 4 performance counters
wire [5:0]  cpucfg_6_pmbits  = 6'd63;
wire        cpucfg_6_upm     = 1'd1;

wire [63:0] cpucfg_6_value   = { {49'b0},
                                 cpucfg_6_upm,
                                 cpucfg_6_pmbits[5:0],
                                 cpucfg_6_pmnum[3:0],
                                 cpucfg_6_pmver[2:0],
                                 cpucfg_6_pmp};


//==========================================================
//                    CPUCFG 10 Register
//==========================================================
wire       cpucfg_10_l1iu_present    = 1'b1;
wire       cpucfg_10_l1iu_unify      = 1'b0;
wire       cpucfg_10_l1d_present     = 1'b1;
wire       cpucfg_10_l2iu_present    = 1'b1;
wire       cpucfg_10_l2iu_unify      = 1'b1;
wire       cpucfg_10_l2iu_private    = 1'b1;
wire       cpucfg_10_l2iu_inclusive  = 1'b1;
wire       cpucfg_10_l2d_present     = 1'b0;
wire       cpucfg_10_l2d_private     = 1'b0;
wire       cpucfg_10_l2d_inclusive   = 1'b0;
wire       cpucfg_10_l3iu_present    = 1'b0;
wire       cpucfg_10_l3iu_unify      = 1'b0;
wire       cpucfg_10_l3iu_private    = 1'b0;
wire       cpucfg_10_l3iu_inclusive  = 1'b0;
wire       cpucfg_10_l3d_present     = 1'b0;
wire       cpucfg_10_l3d_private     = 1'b0;
wire       cpucfg_10_l3d_inclusive   = 1'b0;

wire [63:0] cpucfg_10_value = {{47'b0},
                                cpucfg_10_l3d_inclusive,
                                cpucfg_10_l3d_private,
                                cpucfg_10_l3d_present,
                                cpucfg_10_l3iu_inclusive,
                                cpucfg_10_l3iu_private,
                                cpucfg_10_l3iu_unify,
                                cpucfg_10_l3iu_present,
                                cpucfg_10_l2d_inclusive,
                                cpucfg_10_l2d_private,
                                cpucfg_10_l2d_present,
                                cpucfg_10_l2iu_inclusive,
                                cpucfg_10_l2iu_private,
                                cpucfg_10_l2iu_unify,
                                cpucfg_10_l2iu_present,
                                cpucfg_10_l1d_present,
                                cpucfg_10_l1iu_unify,
                                cpucfg_10_l1iu_present};

//==========================================================
//                    CPUCFG 11 Register (L1IC 64KB)
//==========================================================
wire [15:0] cpucfg_11_way         = 16'd1;
wire [ 8:0] cpucfg_11_index       = 8'd9;   // 2^9
wire [ 6:0] cpucfg_11_line_size   = 7'd6;   // 2^6 
wire [63:0] cpucfg_11_value       = {{33'b0},
                                    cpucfg_11_line_size[6:0],
                                    cpucfg_11_index[7:0],
                                    cpucfg_11_way[15:0]};

//==========================================================
//                    CPUCFG 12 Register (L1DC 64KB)
//==========================================================
wire [15:0] cpucfg_12_way         = 16'd1;
wire [ 8:0] cpucfg_12_index       = 8'd9;   // 2^9
wire [ 6:0] cpucfg_12_line_size   = 7'd6;   // 2^6 
wire [63:0] cpucfg_12_value       = {{33'b0},
                                    cpucfg_12_line_size[6:0],
                                    cpucfg_12_index[7:0],
                                    cpucfg_12_way[15:0]};

//==========================================================
//                    CPUCFG 13 Register (L2C 4MB)
//==========================================================
wire [15:0] cpucfg_13_way         = 16'd15;
wire [ 8:0] cpucfg_13_index       = 8'd12;  // 2^12
wire [ 6:0] cpucfg_13_line_size   = 7'd6;   // 2^6 
wire [63:0] cpucfg_13_value       = {{33'b0},
                                    cpucfg_13_line_size[6:0],
                                    cpucfg_13_index[7:0],
                                    cpucfg_13_way[15:0]};


always @(iui_regs_cpu_cfg_code[5:0]
         or cpucfg_0_value[63:0]
         or cpucfg_1_value[63:0]
         or cpucfg_2_value[63:0]
         or cpucfg_3_value[63:0]
         or cpucfg_4_value[63:0]
         or cpucfg_5_value[63:0]
         or cpucfg_6_value[63:0]
         or cpucfg_10_value[63:0]
         or cpucfg_11_value[63:0]
         or cpucfg_12_value[63:0]
         or cpucfg_13_value[63:0]
        )
begin
  case(iui_regs_cpu_cfg_code[5:0])
    6'h0      : regs_iui_cfg_data[63:0] = cpucfg_0_value[63:0];  
    6'h1      : regs_iui_cfg_data[63:0] = cpucfg_1_value[63:0];  
    6'h2      : regs_iui_cfg_data[63:0] = cpucfg_2_value[63:0];  
    6'h3      : regs_iui_cfg_data[63:0] = cpucfg_3_value[63:0];  
    6'h4      : regs_iui_cfg_data[63:0] = cpucfg_4_value[63:0];  
    6'h5      : regs_iui_cfg_data[63:0] = cpucfg_5_value[63:0];  
    6'h6      : regs_iui_cfg_data[63:0] = cpucfg_6_value[63:0];  
    6'h10     : regs_iui_cfg_data[63:0] = cpucfg_10_value[63:0];  
    6'h11     : regs_iui_cfg_data[63:0] = cpucfg_11_value[63:0];  
    6'h12     : regs_iui_cfg_data[63:0] = cpucfg_12_value[63:0];  
    6'h13     : regs_iui_cfg_data[63:0] = cpucfg_13_value[63:0];  
    default   : regs_iui_cfg_data[63:0] = 64'b0; 
  endcase
// &CombEnd; @3743
end


//==========================================================
//                 Generate output to IUI
//==========================================================
wire enable_virtual     = 1'b0;
wire enable_sup_eret    = 1'b0;
wire enable_sup_wfi     = 1'b0;
wire enable_sup_tvm     = 1'b0; /// sup permit fence inst

// control signals
assign regs_iui_tsr     = enable_sup_eret;
assign regs_iui_tw      = enable_sup_wfi;
assign regs_iui_tvm     = enable_sup_tvm;
assign regs_iui_v       = enable_virtual;
assign regs_iui_pm[1:0] = crmd_plv[1:0];
assign regs_iui_cskyee  = cskyisaee;

// //&Force("output", "regs_iui_cfr_no_op"); @3758
// &Force("output", "regs_iui_cins_no_op"); @3759
assign regs_iui_cfr_no_op  = !(ibp_inv || btb_inv || bht_inv || inv || clr || mcor_local_en);
assign regs_iui_cins_no_op = !(cins_r || mcins_local_en);

// data signals
assign regs_iui_data_out[63:0] = {64{cp0_regs_sel}}  & data_out[63:0] 
                               | {64{pmp_regs_sel}}  & pmp_cp0_data[63:0]
                               | {64{hpm_regs_sel}}  & hpcp_cp0_data[63:0]
                               | {64{mmu_regs_sel}}  & mmu_cp0_data[63:0];
assign regs_iui_l2_regs_sel    = l2_regs_sel;

assign regs_iui_cfg_data_out[63:0] = regs_iui_cfg_data[63:0];

// interrupt select
assign regs_iui_int_sel[14:0] = int_sel[14:0];

// status invalid exception

assign regs_iui_fs_off = fpe;
assign regs_iui_vs_off = sxe;

// int valid for low power mode
assign regs_lpmd_int_vld = (| csr_except_pending[12:0]) && crmd_ie;

// counter read enable generation
// address decode
// &CombBeg; @3785
always @( iui_regs_addr[4:0])
begin
case(iui_regs_addr[4:0])
  5'h00:   cnt_sel[31:0] = 32'h00000001;
  5'h01:   cnt_sel[31:0] = 32'h00000002;
  5'h02:   cnt_sel[31:0] = 32'h00000004;
  5'h03:   cnt_sel[31:0] = 32'h00000008;
  5'h04:   cnt_sel[31:0] = 32'h00000010;
  5'h05:   cnt_sel[31:0] = 32'h00000020;
  5'h06:   cnt_sel[31:0] = 32'h00000040;
  5'h07:   cnt_sel[31:0] = 32'h00000080;
  5'h08:   cnt_sel[31:0] = 32'h00000100;
  5'h09:   cnt_sel[31:0] = 32'h00000200;
  5'h0A:   cnt_sel[31:0] = 32'h00000400;
  5'h0B:   cnt_sel[31:0] = 32'h00000800;
  5'h0C:   cnt_sel[31:0] = 32'h00001000;
  5'h0D:   cnt_sel[31:0] = 32'h00002000;
  5'h0E:   cnt_sel[31:0] = 32'h00004000;
  5'h0F:   cnt_sel[31:0] = 32'h00008000;
  5'h10:   cnt_sel[31:0] = 32'h00010000;
  5'h11:   cnt_sel[31:0] = 32'h00020000;
  5'h12:   cnt_sel[31:0] = 32'h00040000;
  5'h13:   cnt_sel[31:0] = 32'h00080000;
  5'h14:   cnt_sel[31:0] = 32'h00100000;
  5'h15:   cnt_sel[31:0] = 32'h00200000;
  5'h16:   cnt_sel[31:0] = 32'h00400000;
  5'h17:   cnt_sel[31:0] = 32'h00800000;
  5'h18:   cnt_sel[31:0] = 32'h01000000;
  5'h19:   cnt_sel[31:0] = 32'h02000000;
  5'h1A:   cnt_sel[31:0] = 32'h04000000;
  5'h1B:   cnt_sel[31:0] = 32'h08000000;
  5'h1C:   cnt_sel[31:0] = 32'h10000000;
  5'h1D:   cnt_sel[31:0] = 32'h20000000;
  5'h1E:   cnt_sel[31:0] = 32'h40000000;
  5'h1F:   cnt_sel[31:0] = 32'h80000000;
  default: cnt_sel[31:0] = {32{1'bx}};
endcase
// &CombEnd; @3821
end

assign ucnt_addr_hit = iui_regs_addr[11:5] == 7'h60;
assign mcnten_hit    = |(mcnten_reg[31:0] & cnt_sel[31:0]);
assign scnten_hit    = |(scnten_reg[31:0] & cnt_sel[31:0]);

assign scnt_addr_hit = iui_regs_addr[11:5] == 7'h2F;
assign mcntwen_hit   = |(mcntwen_reg[31:0] & cnt_sel[31:0]);

assign regs_iui_scnt_inv = ucnt_addr_hit && !mcnten_hit
                        || scnt_addr_hit && !mcnten_hit
                        || scnt_addr_hit && !mcntwen_hit && iui_regs_csr_wr;
assign regs_iui_ucnt_inv = ucnt_addr_hit && !(mcnten_hit && scnten_hit);

assign regs_iui_hpcp_scr_inv = (iui_regs_addr[11:0] == SHPMCR 
                                || iui_regs_addr[11:0] == SHPMSP
                                || iui_regs_addr[11:0] == SHPMEP)
                            && !hpcp_cp0_sce;
// &Force("output", "regs_xx_icg_en"); @3839
assign regs_xx_icg_en = local_icg_en[2];

//==========================================================
//                 Generate output to other modules
//==========================================================
// Global, IFU, IDU, LSU, MMU, PMP, HPCP, RTU, L2, HAD, PAD
//==========================================================

//==========================================================
//   Generate Global signals
//==========================================================
// endian mode
//assign endian_mode = 1'b0;
//assign endian_v2   = biu_cp0_endian_v2;
//assign cp0_yy_be   = endian_mode;
//assign cp0_yy_be_v1 = endian_mode && !endian_v2;
//assign cp0_yy_be_v2 = endian_mode && endian_v2;

wire hypervisor = 1'b0;

// priviledge mode
assign cp0_yy_priv_mode[1:0] = crmd_plv[1:0];
assign cp0_yy_virtual_mode   = enable_virtual;
assign cp0_yy_hyper          = hypervisor;

// dcache prefetch enable, l2 cache prefetch enalbe included
assign cp0_yy_dcache_pref_en = dcache_pref_en || l2pld;


//==========================================================
//                 Generate output to IFU
//==========================================================
// IFU function modules enable
assign cp0_ifu_bht_en         = bpe;
assign cp0_ifu_btb_en         = btbe;
assign cp0_ifu_l0btb_en       = l0btbe;
assign cp0_ifu_icache_en      = ie;
assign cp0_ifu_icache_pref_en = icache_pref_en;
assign cp0_ifu_ind_btb_en     = ibpe;
assign cp0_ifu_insde          = insde;
assign cp0_ifu_iwpe           = iwpe;
assign cp0_ifu_lbuf_en        = lpe;
assign cp0_ifu_ras_en         = rse;
assign cp0_ifu_nsfe           = nsfe;

// IFU Cache modules invalid
assign cp0_ifu_bht_inv        = bht_inv;
assign cp0_ifu_btb_inv        = btb_inv;
assign cp0_ifu_icache_inv     = icache_inv && sel[0] || iui_regs_rst_inv_i;
assign cp0_ifu_ind_btb_inv    = ibp_inv;

// I-Cache Read
assign cp0_ifu_icache_read_req         = cins_r && (cindex_rid_icache_tag
                                         || cindex_rid_icache_data
                                         || cindex_rid_icache_tag_ecc
                                         || cindex_rid_icache_data_ecc);
assign cp0_ifu_icache_read_tag         = cindex_rid_icache_tag || cindex_rid_icache_tag_ecc;
assign cp0_ifu_icache_read_way         = cindex_way[0];
assign cp0_ifu_icache_read_index[16:0] = cindex_index[16:0];

// Vector Base Reg
assign cp0_ifu_vbr[39:0]     = csreentry[39:0];
assign cp0_ifu_rvbr[39:0]    = mrvbr_value[39:0];

// Local ICG Enable
assign cp0_ifu_icg_en        = local_icg_en[0];

assign cp0_ifu_ecfg_vs[2:0]  = ecfg_vs[2:0];
assign regs_iui_ecfg_vs[2:0] = ecfg_vs[2:0];

assign cp0_ifu_eentry[63:0]  = csreentry_value[63:0];

//==========================================================
//                 Generate output to IDU
//==========================================================
// Float Point Status
//assign cp0_idu_fcr[5:0] = {fxcr_id, fcsr_value[4:0]};
assign cp0_idu_frm[2:0] = fcsr_value[7:5];
assign cp0_idu_fs[1:0]  = {1'b0, fpe};
assign cp0_idu_vs[1:0]  = {1'b0, sxe};

// Hint2 Control Signals
assign cp0_idu_zero_delay_move_disable = zero_move_dis;
assign cp0_idu_dlb_disable             = dlb_dis;
assign cp0_idu_rob_fold_disable        = rob_fold_dis;
assign cp0_idu_iq_bypass_disable       = iq_bypass_dis;
assign cp0_idu_srcv2_fwd_disable       = srcv2_fwd_dis;
assign cp0_idu_src2_fwd_disable        = src2_fwd_dis;

// C-Sky Extension Enable
assign cp0_idu_cskyee   = cskyisaee;

// Local ICG Enable
assign cp0_idu_icg_en   = local_icg_en[1];


//==========================================================
//              Generate output to IU
//==========================================================
// Exception Related Information
assign cp0_iu_ex3_efpc[62:0]  = cp0_cprs ? cpcsr_value[63:1] : csrera_value[63:1];
assign cp0_iu_ex3_efpc_vld    = cp0_ertn | cp0_cprs;

assign cp0_iu_div_entry_disable     = div_entry_dis;
assign cp0_iu_div_entry_disable_clr = div_entry_dis && mhint2_local_en && !iui_regs_src0[11];

// Local ICG Enable
assign cp0_iu_icg_en                    = local_icg_en[2];
assign cp0_iu_vsetvli_pre_decd_disable  = vsetvli_dis;
assign cp0_ifu_vsetvli_pred_disable     = vsetvli_dis;
assign cp0_ifu_vsetvli_pred_mode        = vsetvli_pred;

//==========================================================
//                 Generate output to LSU
//==========================================================
// LSU function modules enable
assign cp0_lsu_dcache_en             = de;
assign cp0_lsu_dcache_pref_en        = dcache_pref_en;
assign cp0_lsu_dcache_pref_dist[1:0] = dcache_pref_dist[1:0];
assign cp0_lsu_l2_pref_en            = l2pld;
assign cp0_lsu_l2_pref_dist[1:0]     = l2_pref_dist[1:0];
assign cp0_lsu_l2_st_pref_en         = l2stpld;


// LSU related control flags
assign cp0_lsu_tvm                   = enable_sup_tvm;
assign cp0_lsu_ucme                  = ucme;
assign cp0_lsu_wa                    = wa;
assign cp0_lsu_mm                    = mm;
assign cp0_lsu_nsfe                  = nsfe;

// Hint functions
assign cp0_lsu_amr2                  = amr2;
assign cp0_lsu_amr                   = amr;
//assign cp0_lsu_exclusive_wb          = exclusive_wb;
assign cp0_lsu_wr_burst_dis          = wr_burst_dis;
assign cp0_lsu_cb_aclr_dis           = cb_aclr_dis;
assign cp0_lsu_da_fwd_dis            = da_fwd_dis;
assign cp0_lsu_pfu_mmu_dis           = pfu_mmu_dis;
assign cp0_lsu_fencei_broad_dis      = fencei_broad_dis;
assign cp0_lsu_fencerw_broad_dis     = fencerw_broad_dis;
assign cp0_lsu_tlb_broad_dis         = tlb_broad_dis;
assign cp0_lsu_corr_dis              = corr_dis;
assign cp0_lsu_ctc_flush_dis         = ctc_flush_dis;

// Dcache Clear and Invalid
assign cp0_lsu_dcache_clr            = clr && sel[1];
assign cp0_lsu_dcache_inv            = dcache_inv && sel[1] || iui_regs_rst_inv_d;

// Dcache Read Cache Line Request
assign cp0_lsu_dcache_read_req         = cins_r && (cindex_rid_dcache_st_tag
                                         || cindex_rid_dcache_ld_tag
                                         || cindex_rid_dcache_data
                                         || cindex_rid_dcache_st_tag_ecc
                                         || cindex_rid_dcache_ld_tag_ecc
                                         || cindex_rid_dcache_data_ecc
                                         );
assign cp0_lsu_dcache_read_st_tag      = cindex_rid_dcache_st_tag
                                         || cindex_rid_dcache_st_tag_ecc;
assign cp0_lsu_dcache_read_ld_tag      = cindex_rid_dcache_ld_tag
                                         || cindex_rid_dcache_ld_tag_ecc;
assign cp0_lsu_dcache_read_way         = cindex_way[0];
assign cp0_lsu_dcache_read_index[16:0] = cindex_index[16:0];

// Local ICG Enable
assign cp0_lsu_icg_en                  = local_icg_en[3];

assign cp0_lsu_timeout_cnt[29:0]       = timeout_cnt[29:0];

//==========================================================
//                 Generate output to MMU
//==========================================================
wire enable_phy_check            = 1'b0;
wire enable_sup_access_user_addr = 1'b1;
wire enable_load_exe_addr_space  = 1'b1;

// MMU Regs select and write information
assign cp0_mmu_wreg         = iui_regs_sel && mmu_regs_sel;
assign cp0_mmu_satp_sel     = 1'b0;
assign cp0_mmu_reg_num[1:0] = iui_regs_addr[1:0];
assign cp0_mmu_wdata[63:0]  = iui_regs_src0[63:0];

// MMU related control flags
assign cp0_mmu_mxr          = enable_load_exe_addr_space;
assign cp0_mmu_sum          = enable_sup_access_user_addr;
assign cp0_mmu_mprv         = enable_phy_check;
assign cp0_mmu_mpp[1:0]     = prmd_pplv[1:0];
assign cp0_mmu_cskyee       = cskyisaee;
assign cp0_mmu_maee         = maee;
assign cp0_mmu_ptw_en       = !mhrd;


assign cp0_mmu_crmd_da        = crmd_da;
assign cp0_mmu_crmd_pg        = crmd_pg;
assign cp0_mmu_da_mode_datf   = crmd_datf;
assign cp0_mmu_da_mode_datm   = crmd_datm;
assign cp0_mmu_ptw_pgdl       = csrpgdl_value;
assign cp0_mmu_ptw_pgdh       = csrpgdh_value;
assign cp0_mmu_cur_asid[15:0] = asid_value[15:0];

assign cp0_mmu_dmw0           = csrdmw0_value;
assign cp0_mmu_dmw1           = csrdmw1_value;
assign cp0_mmu_dmw2           = csrdmw2_value;
assign cp0_mmu_dmw3           = csrdmw3_value;


// Local ICG Enable
assign cp0_mmu_icg_en = local_icg_en[4];


//==========================================================
//                 Generate output to PMP
//==========================================================
// PMP Regs select and write information
assign cp0_pmp_wreg         = iui_regs_sel && pmp_regs_sel;
assign cp0_pmp_reg_num[4:0] = iui_regs_addr[4:0];
assign cp0_pmp_wdata[63:0]  = iui_regs_src0[63:0];

// MPRV Judgement
assign cp0_pmp_mprv         = enable_phy_check;
assign cp0_pmp_mpp[1:0]     = crmd_plv[1:0];

// Local ICG Enable
assign cp0_pmp_icg_en       = local_icg_en[4];


//==========================================================
//                 Generate output to HPCP
//==========================================================
// HPCP Regs select and write information
//assign cp0_hpcp_wreg        = iui_regs_sel && hpm_regs_sel;
assign regs_iui_hpcp_regs_sel = hpm_regs_sel;
assign cp0_hpcp_index[11:0]   = iui_regs_addr[11:0];
assign cp0_hpcp_wdata[63:0]   = iui_regs_src0[63:0];

assign cp0_hpcp_pmdm          = pmdm;
assign cp0_hpcp_pmds          = pmds;
assign cp0_hpcp_pmdu          = pmdu;
assign cp0_hpcp_mcntwen[31:0] = mcntwen_reg[31:0];

// Local ICG Enable
assign cp0_hpcp_icg_en = local_icg_en[2];

//==========================================================
//                 Generate output to L2
//==========================================================
// L2 Regs select and write information
//assign cp0_biu_l2_wreg         = iui_regs_sel 
//                             && (mccr2_local_en || mcer2_local_en 
//                              || mrmr_local_en  || mrvbr_local_en
//                              || meicr2_local_en || mhint4_local_en);
//assign cp0_biu_l2_reg_sel[5:0] = {mhint4_local_en, meicr2_local_en, mrmr_local_en,
//                                  mrvbr_local_en, mcer2_local_en || scer2_local_en,
//                                  mccr2_local_en};
//assign cp0_biu_l2_wdata[63:0]  = iui_regs_src0[63:0];

// Mhint select and write information
//assign cp0_biu_l2_chr2_wen         = mhint2_local_en;
//assign cp0_biu_l2_chr2_wdata[7:0] = {iui_regs_src0[25:22], iui_regs_src0[8:5]};

// L2cache Read Cache Line Request
// &CombBeg; @4110
always @( mteecfg_local_en
       or mhint4_local_en
       or msmpr_local_en
       or mcer2_local_en
       or meicr2_local_en
       or mccr2_local_en
       or scer2_local_en)
begin
case({mccr2_local_en, mhint4_local_en, mcer2_local_en || scer2_local_en,
      meicr2_local_en, msmpr_local_en, mteecfg_local_en})
  6'b100000: l2_regs_idx[3:0] = 4'b0000;
  6'b010000: l2_regs_idx[3:0] = 4'b0001;
  6'b001000: l2_regs_idx[3:0] = 4'b0010;
  6'b000100: l2_regs_idx[3:0] = 4'b0011;
  6'b000010: l2_regs_idx[3:0] = 4'b0100;
  6'b000001: l2_regs_idx[3:0] = 4'b0101;
  default  : l2_regs_idx[3:0] = {4{1'b0}};
endcase
// &CombEnd; @4121
end
assign regs_iui_reg_idx[3:0] = l2_regs_idx[3:0];

assign regs_iui_dca_sel      = regs_dca_sel;
assign regs_iui_cindex_l2    = regs_cindex_sel_l2;
assign regs_dca_sel          = cins_ff && regs_cindex_sel_l2;
assign regs_cindex_sel_l2    = (cindex_rid_l2cache_tag
                                             || cindex_rid_l2cache_data
                                             || cindex_rid_l2cache_tag_ecc
                                             || cindex_rid_l2cache_data_ecc
                                             );
assign regs_iui_wdata[63:0] = {32'b0, cindex_rid[3:0], 3'b0, cindex_way[3:0], cindex_index[20:0]};

//assign cp0_biu_l2_read_req         = cins_ff && (cindex_rid_l2cache_tag
//                                             || cindex_rid_l2cache_data
//                                             || cindex_rid_l2cache_tag_ecc
//                                             || cindex_rid_l2cache_data_ecc
//                                             );
//assign cp0_biu_l2_read_tag         = cindex_rid_l2cache_tag;
//assign cp0_biu_l2_read_data        = cindex_rid_l2cache_data;
//assign cp0_biu_l2_read_tag_ecc     = cindex_rid_l2cache_tag_ecc;
//assign cp0_biu_l2_read_data_ecc    = cindex_rid_l2cache_data_ecc;
//assign cp0_biu_l2_read_way[3:0]    = cindex_way[3:0];
//assign cp0_biu_l2_read_index[20:0] = cindex_index[20:0];

// Local ICG Enable
assign cp0_biu_icg_en                 = local_icg_en[5];
assign cp0_xx_core_icg_en             = local_icg_en[8];

//==========================================================
//              Generate output to RTU
//==========================================================
// Single Retire Enable
assign cp0_rtu_srt_en                 = sre;

// Local ICG Enable
assign cp0_rtu_icg_en                 = local_icg_en[6];

//==========================================================
//              Generate output to VFPU
//==========================================================
// Local ICG Enable
assign cp0_vfpu_icg_en                = local_icg_en[7];

//==========================================================
//              Generate output to HAD
//==========================================================
assign cp0_had_cpuid_0[31:0]          = cpuid_index0_value[31:0];
//assign cp0_had_mcause_data[63:0]    = mcause_value[63:0];

//==========================================================
//              Generate output to PAD
//==========================================================
assign cp0_pad_mstatus[63:0]          = mstatus_value[63:0];


// &ModuleEnd; @4181
endmodule


