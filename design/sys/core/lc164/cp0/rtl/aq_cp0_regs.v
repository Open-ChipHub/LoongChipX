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
module aq_cp0_regs (
  // &Ports, @25
  input    wire  [2  :0]  biu_cp0_coreid,
  input    wire           biu_cp0_me_int,
  input    wire           biu_cp0_ms_int,
  input    wire           biu_cp0_mt_int,
  input    wire  [63 :0]  biu_cp0_rvba,
  input    wire           biu_cp0_se_int,
  input    wire           biu_cp0_ss_int,
  input    wire           biu_cp0_st_int,
  input    wire  [7  :0]  ext_interrupt,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           dtu_cp0_dcsr_mprven,
  input    wire  [1  :0]  dtu_cp0_dcsr_prv,
  input    wire  [63 :0]  dtu_cp0_rdata,
  input    wire           forever_cpuclk,
  input    wire  [63 :0]  hpcp_cp0_data,
  input    wire           hpcp_cp0_int_vld,
  input    wire           hpcp_cp0_sce,
  input    wire           ifu_cp0_bht_inv_done,
  input    wire           ifu_cp0_icache_inv_done,
  input    wire  [127:0]  ifu_cp0_icache_read_data,
  input    wire           ifu_cp0_icache_read_data_vld,
  input    wire  [63 :0]  iui_inst_rs2,
  input    wire  [5  :0]  iui_regs_csr_cpucfg_op,
  input    wire           iui_regs_csr_en,
  input    wire           iui_regs_csr_wen,
  input    wire           iui_regs_csr_wen_no_imm_ill,
  input    wire           iui_regs_csr_write,
  input    wire           iui_regs_csr_write_no_imm_ill,
  input    wire  [11 :0]  iui_regs_imm,
  input    wire           iui_regs_inst_ertn,
  input    wire           iui_regs_inst_mret,
  input    wire           iui_regs_inst_sret,
  input    wire           iui_regs_inst_cprs,
  input    wire  [63 :0]  iui_regs_wdata,
  input    wire           iui_vsetvl_bypass,
  input    wire  [4  :0]  iui_vsetvl_data,
  input    wire  [127:0]  lsu_cp0_dcache_read_data,
  input    wire           lsu_cp0_dcache_read_data_vld,
  input    wire           lsu_cp0_icc_done,
  input    wire           mmu_cp0_cmplt,
  input    wire  [63 :0]  mmu_cp0_data,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [63 :0]  pmp_cp0_data,
  input    wire  [63 :0]  rtu_cp0_epc,
  input    wire           rtu_cp0_exit_debug,
  input    wire  [4  :0]  rtu_cp0_fflags,
  input    wire           rtu_cp0_fflags_updt,
  input    wire           rtu_cp0_split_vld,
  input    wire           rtu_cp0_fs_dirty_updt,
  input    wire           rtu_cp0_fs_dirty_updt_dp,
  input    wire  [63 :0]  rtu_cp0_tval,
  input    wire  [7  :0]  rtu_cp0_vl,
  input    wire           rtu_cp0_vl_vld,
  input    wire           rtu_cp0_vs_dirty_updt,
  input    wire           rtu_cp0_vs_dirty_updt_dp,
  input    wire  [6  :0]  rtu_cp0_vstart,
  input    wire           rtu_cp0_vstart_vld,
  input    wire           rtu_cp0_vxsat,
  input    wire           rtu_cp0_vxsat_vld,
  input    wire           rtu_yy_xx_dbgon,
  input    wire           rtu_yy_xx_expt_int,
  input    wire  [14 :0]  rtu_yy_xx_expt_vec,
  input    wire           rtu_yy_xx_expt_vld,
  input    wire           rtu_yy_xx_flush,
  input    wire           special_regs_vill,
  input    wire           special_regs_vsetvl_dp,
  input    wire           special_vsetvl_illegal,
  input    wire  [39 :0]  sysio_cp0_apb_base,
  output   wire           cp0_biu_icg_en,
  output   wire           cp0_dtu_icg_en,
  output   wire           cp0_dtu_mexpt_vld,
  output   wire           cp0_dtu_pcfifo_frz,
  output   wire  [63 :0]  cp0_dtu_satp,
  output   wire           cp0_hpcp_icg_en,
  output   wire           cp0_hpcp_int_off_vld,
  output   wire  [31 :0]  cp0_hpcp_mcntwen,
  output   wire           cp0_hpcp_pmdm,
  output   wire           cp0_hpcp_pmds,
  output   wire           cp0_hpcp_pmdu,
  output   wire           cp0_idu_cskyee,
  output   wire           cp0_idu_dis_fence_in_dbg,
  output   wire  [2  :0]  cp0_idu_frm,
  output   wire  [1  :0]  cp0_idu_fs,
  output   wire           cp0_idu_icg_en,
  output   wire           cp0_idu_ucme,
  output   wire           cp0_idu_vill,
  output   wire           cp0_idu_vl_zero,
  output   wire  [1  :0]  cp0_idu_vlmul,
  output   wire  [1  :0]  cp0_idu_vs,
  output   wire  [1  :0]  cp0_idu_vsew,
  output   wire  [6  :0]  cp0_idu_vstart,
  output   wire           cp0_ifu_bht_en,
  output   wire           cp0_ifu_btb_clr,
  output   wire           cp0_ifu_btb_en,
  output   wire           cp0_ifu_icache_en,
  output   wire           cp0_ifu_icache_pref_en,
  output   wire  [13 :0]  cp0_ifu_icache_read_index,
  output   wire           cp0_ifu_icache_read_req,
  output   wire           cp0_ifu_icache_read_tag,
  output   wire           cp0_ifu_icache_read_way,
  output   wire           cp0_ifu_icg_en,
  output   wire           cp0_ifu_iwpe,
  output   wire           cp0_ifu_ras_en,
  output   wire           cp0_iu_icg_en,
  output   wire  [1  :0]  cp0_lsu_amr,
  output   wire           cp0_lsu_dcache_en,
  output   wire  [1  :0]  cp0_lsu_dcache_pref_dist,
  output   wire           cp0_lsu_dcache_pref_en,
  output   wire  [16 :0]  cp0_lsu_dcache_read_idx,
  output   wire           cp0_lsu_dcache_read_req,
  output   wire           cp0_lsu_dcache_read_type,
  output   wire  [1  :0]  cp0_lsu_dcache_read_way,
  output   wire           cp0_lsu_dcache_wa,
  output   wire           cp0_lsu_dcache_wb,
  output   wire           cp0_lsu_icg_en,
  output   wire           cp0_lsu_mm,
  output   wire  [1  :0]  cp0_lsu_mpp,
  output   wire           cp0_lsu_mprv,
  output   wire           cp0_lsu_we_en,
  output   wire           cp0_mmu_icg_en,
  output   wire           cp0_mmu_maee,
  output   wire           cp0_mmu_mxr,
  output   wire           cp0_mmu_ptw_en,
  output   wire  [63 :0]  cp0_mmu_satp_data,
  output   wire           cp0_mmu_satp_wen,
  output   wire           cp0_mmu_sum,
  output   wire           cp0_mmu_crmd_da,
  output   wire           cp0_mmu_crmd_pg,
  output   wire  [63 :0]  cp0_mmu_dmw0,
  output   wire  [63 :0]  cp0_mmu_dmw1,
  output   wire  [63 :0]  cp0_mmu_dmw2,
  output   wire  [63 :0]  cp0_mmu_dmw3,
  output   wire  [15 :0]  cp0_mmu_cur_asid,
  output   wire  [63 :0]  cp0_mmu_ptw_pgdh,
  output   wire  [63 :0]  cp0_mmu_ptw_pgdl,
  output   wire           cp0_pmp_icg_en,
  output   wire           cp0_rtu_icg_en,
  output   wire  [14 :0]  cp0_rtu_int_vld,
  output   wire  [2  :0]  cp0_rtu_ecfg_vs,
  output   wire  [63 :0]  cp0_rtu_trap_pc,
  output   wire           cp0_rtu_vstart_eq_0,
  output   wire           cp0_vpu_icg_en,
  output   wire           cp0_vpu_xx_bf16,
  output   wire           cp0_vpu_xx_dqnan,
  output   wire  [2  :0]  cp0_vpu_xx_rm,
  output   wire  [4  :0]  cp0_vpu_fflags_enable,
  output   wire  [63 :0]  cp0_xx_mrvbr,
  output   wire  [1  :0]  cp0_yy_priv_mode,
  output   wire           regs_clk,
  output   wire           regs_iui_csr_inv,
  output   wire           regs_iui_mcins_stall,
  output   wire           regs_iui_mcor_stall,
  output   wire  [63 :0]  regs_iui_era,
  output   wire  [63 :0]  regs_iui_mepc,
  output   wire  [1  :0]  regs_iui_pm,
  output   wire  [63 :0]  regs_iui_rdata,
  output   wire  [63 :0]  regs_iui_rdtime,
  output   wire  [63 :0]  regs_iui_cfg_data,
  output   wire  [63 :0]  regs_iui_rdata_for_w,
  output   wire  [63 :0]  regs_iui_sepc,
  output   wire  [63 :0]  regs_iui_cprs,
  output   wire           regs_iui_smcir_stall,
  output   wire           regs_iui_trigger_mro,
  output   wire           regs_iui_trigger_smode,
  output   wire           regs_iui_tsr,
  output   wire           regs_iui_tvm,
  output   wire           regs_iui_tw,
  output   wire           regs_lpmd_int_vld,
  output   wire           regs_special_bht_inv,
  output   wire           regs_special_dcache_clr,
  output   wire           regs_special_dcache_inv,
  output   wire           regs_special_dcache_req,
  output   wire           regs_special_icache_inv,
  output   wire           regs_xx_icg_en
); 



// &Regs; @26
reg     [63 :0]  regs_csr_rdata;               
reg     [63 :0]  regs_csr_rdata_for_w;         
reg              regs_ext_imm_inv;             
reg              regs_imm_inv;                 
reg              timer_clr;  
reg              tcfg_en;


// &Wires; @27
wire             fcsr_local_en;                
wire    [63 :0]  fcsr_value;                   
wire             fflags_local_en;              
wire    [63 :0]  fflags_value;                 
wire             float_clk;                    
wire             frm_local_en;                 
wire    [63 :0]  frm_value;                    
wire             fs_dirty_upd_gate;            
wire             fxcr_local_en;                
wire    [63 :0]  fxcr_value;                   
wire    [63 :0]  hpcp_value;                   
wire    [63 :0]  mapbaddr_value;               
wire    [63 :0]  marchid_value;                
wire             mcause_local_en;              
wire    [63 :0]  mcause_value;                 
wire    [63 :0]  mccr2_value;                  
wire    [63 :0]  mcdata0_value;                
wire    [63 :0]  mcdata1_value;                
wire    [63 :0]  mcer2_value;                  
wire    [63 :0]  mcer_value;                   
wire             mcindex_local_en;             
wire    [63 :0]  mcindex_value;                
wire             mcins_local_en;               
wire    [63 :0]  mcins_value;                  
wire             mcnten_local_en;              
wire    [63 :0]  mcnten_value;                 
wire             mcntwen_local_en;             
wire    [63 :0]  mcntwen_value;                
wire             mcor_local_en;                
wire    [63 :0]  mcor_value;                   
wire             mcpuid_local_en;              
wire    [63 :0]  mcpuid_value;                 
wire             medeleg_local_en;             
wire    [63 :0]  medeleg_value;                
wire    [63 :0]  meicr2_value;                 
wire    [63 :0]  meicr_value;                  
wire             mepc_local_en;                
wire    [63 :0]  mepc_value;                   
wire    [63 :0]  mhartid_value;                
wire             mhcr_local_en;                
wire    [63 :0]  mhcr_value;                   
wire             mhint2_local_en;              
wire    [63 :0]  mhint2_value;                 
wire    [63 :0]  mhint3_value;                 
wire    [63 :0]  mhint4_value;                 
wire             mhint_local_en;               
wire    [63 :0]  mhint_value;                  
wire             mhpmcr_local_en;              
wire             mideleg_local_en;             
wire    [63 :0]  mideleg_value;                
wire             mie_local_en;                 
wire    [63 :0]  mie_value;                    
wire    [63 :0]  mimpid_value;                 
wire             mip_local_en;                 
wire    [63 :0]  mip_value;                    
wire    [63 :0]  misa_value;                   
wire    [63 :0]  mmu_value;                    
wire    [63 :0]  mrmr_value;                   
wire    [63 :0]  mrvbr_value;                  
wire             mscratch_local_en;            
wire    [63 :0]  mscratch_value;               
wire             mstatus_local_en;             
wire    [63 :0]  mstatus_value;                
wire             mtval_local_en;               
wire    [63 :0]  mtval_value;                  
wire             mtvec_local_en;               
wire    [63 :0]  mtvec_value;                  
wire    [63 :0]  mvendorid_value;              
wire             mxstatus_local_en;            
wire    [63 :0]  mxstatus_value;               
wire    [63 :0]  pmp_value;                    
wire             regs_clintee;                 
wire             regs_clk_en;                  
wire    [11 :0]  regs_csr_imm;                 
wire             regs_csr_wen;                 
wire             regs_csr_wen_no_imm_ill;      
wire             regs_csr_write_no_imm_ill;    
wire             regs_flush_clk;               
wire             regs_flush_clk_en;            
wire             regs_fs_off;                  
wire             regs_mcins_busy;              
wire             regs_mcor_busy;               
wire    [1  :0]  regs_mxl;                     
wire    [1  :0]  regs_pm;                      
wire             regs_scnt_inv;                
wire             regs_smode;                   
wire             regs_tvm;                     
wire             regs_ucnt_inv;                
wire             regs_umode;                   
wire             satp_local_en;                
wire    [63 :0]  satp_value;                   
wire             scause_local_en;              
wire    [63 :0]  scause_value;                 
wire    [63 :0]  scer2_value;                  
wire    [63 :0]  scer_value;                   
wire             scnten_local_en;              
wire    [63 :0]  scnten_value;                 
wire             sepc_local_en;                
wire    [63 :0]  sepc_value;                   
wire    [63 :0]  shcr_value;                   
wire    [63 :0]  shint2_value;                 
wire    [63 :0]  shint_value;                  
wire             shpmcr_local_en;              
wire             sie_local_en;                 
wire    [63 :0]  sie_value;                    
wire             sip_local_en;                 
wire    [63 :0]  sip_raw;                      
wire    [63 :0]  sip_value;                    
wire             smcir_local_en;               
wire             smcir_local_en_raw;           
wire             sscratch_local_en;            
wire    [63 :0]  sscratch_value;               
wire             sstatus_local_en;             
wire    [63 :0]  sstatus_value;                
wire             stval_local_en;               
wire    [63 :0]  stval_value;                  
wire             stvec_local_en;               
wire    [63 :0]  stvec_value;                  
wire             sxstatus_local_en;            
wire    [63 :0]  sxstatus_value;               
wire    [63 :0]  vl_value;                     
wire    [63 :0]  vlenb_value;                  
wire             vs_dirty_upd_gate;            
wire    [63 :0]  vstart_value;                 
wire    [63 :0]  vtype_value;                  
wire    [63 :0]  vxrm_value;                   
wire    [63 :0]  vxsat_value;                  

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
wire             dgwavedump_local_en;
wire             cpcsr_local_en;
wire             cpcsr_tcfg_local_en;
wire             cpcsr_crmd_local_en;
wire             mwpc_local_en;
wire             mwps_local_en;
wire             fwpc_local_en;
wire             fwps_local_en;
wire             fcsr0_local_en;
wire             fcsr1_local_en;
wire             fcsr2_local_en;
wire             fcsr3_local_en;

wire    [63 :0]  csrarch_value;
wire    [63 :0]  csrcrmd_value;
wire    [63 :0]  csrprmd_value;
wire    [63 :0]  csreuen_value;
wire    [63 :0]  csrmisc_value;
wire    [63 :0]  csrecfg_value;
wire    [63 :0]  csrestat_value;
wire    [63 :0]  csrera_value;
wire    [63 :0]  csrbadv_value;
wire    [63 :0]  csrbadi_value;
wire    [63 :0]  csreentry_value;
wire    [63 :0]  csrimpctl1_value;
wire    [63 :0]  csrimpctl2_value;
wire    [63 :0]  csrtlbrentry_value;
wire    [63 :0]  csrmerrentry_value;
wire    [63 :0]  csrtlbidx_value;
wire    [63 :0]  csrpwcl_value;
wire    [63 :0]  csrpwch_value;
wire    [63 :0]  csrstlbps_value;
wire    [63 :0]  csrrvacfg_value;
wire    [63 :0]  csrasid_value;
wire    [63 :0]  csrdmw0_value;
wire    [63 :0]  csrdmw1_value;
wire    [63 :0]  csrdmw2_value;
wire    [63 :0]  csrdmw3_value;
wire    [63 :0]  csrtid_value;
wire    [63 :0]  csrtcfg_value;
wire    [63 :0]  csrtval_value;
wire    [63 :0]  csrcntc_value;
wire    [63 :0]  csrticlr_value;
wire    [63 :0]  csrsave0_value;
wire    [63 :0]  csrsave1_value;
wire    [63 :0]  csrsave2_value;
wire    [63 :0]  csrsave3_value;
wire    [63 :0]  cpuid_value;
wire    [63 :0]  csrpgdh_value;
wire    [63 :0]  csrpgdl_value;
wire    [63 :0]  csrprcfg1_value;
wire    [63 :0]  csrprcfg2_value;
wire    [63 :0]  csrprcfg3_value;
wire    [63 :0]  csrrehi_value;
wire    [63 :0]  debug0_value;
wire    [63 :0]  debug1_value;
wire    [63 :0]  debug_wave_dump_value;
wire    [63 :0]  mwpc_value;
wire    [63 :0]  mwps_value;
wire    [63 :0]  fwpc_value;
wire    [63 :0]  fwps_value;
wire    [63 :0]  fcsr0_value;
wire    [63 :0]  fcsr1_value;
wire    [63 :0]  fcsr2_value;
wire    [63 :0]  fcsr3_value;


//==========================================================
//                       CSR Address
//==========================================================
// 1. Machine Level CSRs
// 2. Supervisor Level CSRs
// 3. User Level CSRs
// 4. C-SKY Extension CSRs
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
// Machine Information Registers
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

// LA User Floating-Point CSRs
parameter FCSR0     = 12'hF00;
parameter FCSR1     = 12'hF01;
parameter FCSR2     = 12'hF02;
parameter FCSR3     = 12'hF03;

//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
parameter FFLAGS    = 12'h001;
parameter FRM       = 12'h002;
parameter FCSR      = 12'h003;

//---------- User Vector CSRs ----------
parameter VSTART    = 12'h008;
parameter VXSAT     = 12'h009;
parameter VXRM      = 12'h00A;
parameter VL        = 12'hC20;
parameter VTYPE     = 12'hC21;
parameter VLENB     = 12'hC22;

//-------- User Counter/Timers ---------
parameter CYCLE    = 12'hC00;
parameter TIME     = 12'hC01;
parameter INSTRET  = 12'hC02;
parameter HPMCNT3  = 12'hC03;
parameter HPMCNT4  = 12'hC04;
parameter HPMCNT5  = 12'hC05;
parameter HPMCNT6  = 12'hC06;
parameter HPMCNT7  = 12'hC07;
parameter HPMCNT8  = 12'hC08;
parameter HPMCNT9  = 12'hC09;
parameter HPMCNT10 = 12'hC0A;
parameter HPMCNT11 = 12'hC0B;
parameter HPMCNT12 = 12'hC0C;
parameter HPMCNT13 = 12'hC0D;
parameter HPMCNT14 = 12'hC0E;
parameter HPMCNT15 = 12'hC0F;
parameter HPMCNT16 = 12'hC10;
parameter HPMCNT17 = 12'hC11;
parameter HPMCNT18 = 12'hC12;
parameter HPMCNT19 = 12'hC13;
parameter HPMCNT20 = 12'hC14;
parameter HPMCNT21 = 12'hC15;
parameter HPMCNT22 = 12'hC16;
parameter HPMCNT23 = 12'hC17;
parameter HPMCNT24 = 12'hC18;
parameter HPMCNT25 = 12'hC19;
parameter HPMCNT26 = 12'hC1A;
parameter HPMCNT27 = 12'hC1B;
parameter HPMCNT28 = 12'hC1C;
parameter HPMCNT29 = 12'hC1D;
parameter HPMCNT30 = 12'hC1E;
parameter HPMCNT31 = 12'hC1F;

//----------------------------------------------------------
//                       Debug CSRs
//----------------------------------------------------------
parameter DCSR       = 12'h7B0;
parameter DPC        = 12'h7B1;
parameter DSCRATCH0  = 12'h7B2;
parameter DSCRATCH1  = 12'h7B3;

//----------------------------------------------------------
//                      Trigger CSRs
//----------------------------------------------------------
parameter TSELECT    = 12'h7A0;
parameter TDATA1     = 12'h7A1;
parameter TDATA2     = 12'h7A2;
parameter TDATA3     = 12'h7A3;
parameter TINFO      = 12'h7A4;
parameter TCONTROL   = 12'h7A5;
parameter MCONTEXT   = 12'h7A8;
parameter SCONTEXT   = 12'h7AA;

//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// 0x7C0-0x7FF
// parameter M_EXT_CSR0 = 12'b0111_11??_????;
// 0xBC0-0xBFF
// parameter M_EXT_CSR1 = 12'b1011_11??_????;
// 0xFC0-0xFFF
// parameter M_EXT_CSR2 = 12'b1111_11??_????;

// Processor Control and Status Extension 
parameter MXSTATUS   = 12'h7C0;
parameter MHCR       = 12'h7C1;
parameter MCOR       = 12'h7C2;
parameter MCCR2      = 12'h7C3;
parameter MCER2      = 12'h7C4;
parameter MHINT      = 12'h7C5;
parameter MRMR       = 12'h7C6;
parameter MRVBR      = 12'h7C7;
parameter MCER       = 12'h7C8;
parameter MCNTWEN    = 12'h7C9;
parameter MCNTINTEN  = 12'h7CA;
parameter MCNTOF     = 12'h7CB;
parameter MHINT2     = 12'h7CC;
parameter MHINT3     = 12'h7CD;
parameter MHINT4     = 12'h7CE;

//------ Processor Data Extension ------
parameter MCINS      = 12'h7D2;
parameter MCINDEX    = 12'h7D3;
parameter MCDATA0    = 12'h7D4;
parameter MCDATA1    = 12'h7D5;
parameter MEICR      = 12'h7D6;
parameter MEICR2     = 12'h7D7;

//------- Processor ID Extension -------
parameter MCPUID     = 12'hFC0;
parameter MAPBADDR   = 12'hFC1;

//-----------Debug Extension -----------
parameter MHALTCAUSE = 12'hFE0;
parameter MDBGINFO   = 12'hFE1;
parameter MPCFIFO    = 12'hFE2;

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
parameter SXSTATUS   = 12'h5C0;
parameter SHCR       = 12'h5C1;
parameter SCER2      = 12'h5C2;
parameter SCER       = 12'h5C3;
parameter SCNTINTEN  = 12'h5C4;
parameter SCNTOF     = 12'h5C5;
parameter SHINT      = 12'h5C6;
parameter SHINT2     = 12'h5C7;
parameter SCNTIHBT   = 12'h5C8;
parameter SHPMCR     = 12'h5C9;
parameter SHPMSP     = 12'h5CA;
parameter SHPMEP     = 12'h5CB;

//----- Supervisor Counters/Timers -----
parameter SCYCLE     = 12'h5E0;
parameter SINSTRET   = 12'h5E2;
parameter SHPMCNT3   = 12'h5E3;
parameter SHPMCNT4   = 12'h5E4;
parameter SHPMCNT5   = 12'h5E5;
parameter SHPMCNT6   = 12'h5E6;
parameter SHPMCNT7   = 12'h5E7;
parameter SHPMCNT8   = 12'h5E8;
parameter SHPMCNT9   = 12'h5E9;
parameter SHPMCNT10  = 12'h5EA;
parameter SHPMCNT11  = 12'h5EB;
parameter SHPMCNT12  = 12'h5EC;
parameter SHPMCNT13  = 12'h5ED;
parameter SHPMCNT14  = 12'h5EE;
parameter SHPMCNT15  = 12'h5EF;
parameter SHPMCNT16  = 12'h5F0;
parameter SHPMCNT17  = 12'h5F1;
parameter SHPMCNT18  = 12'h5F2;
parameter SHPMCNT19  = 12'h5F3;
parameter SHPMCNT20  = 12'h5F4;
parameter SHPMCNT21  = 12'h5F5;
parameter SHPMCNT22  = 12'h5F6;
parameter SHPMCNT23  = 12'h5F7;
parameter SHPMCNT24  = 12'h5F8;
parameter SHPMCNT25  = 12'h5F9;
parameter SHPMCNT26  = 12'h5FA;
parameter SHPMCNT27  = 12'h5FB;
parameter SHPMCNT28  = 12'h5FC;
parameter SHPMCNT29  = 12'h5FD;
parameter SHPMCNT30  = 12'h5FE;
parameter SHPMCNT31  = 12'h5FF;

//------ TLB Operation Extension -------
parameter SMIR       = 12'h9C0;
parameter SMEL       = 12'h9C1;
parameter SMEH       = 12'h9C2;
parameter SMCIR      = 12'h9C3;

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
parameter FXCR       = 12'h800;


//==========================================================
//                 CSRs Illegal Instruction
//==========================================================
// 1. Addr Illegal
// 2. access SATP in S mode && tvm
// 3. scounteren inhibit
// 4. mcounteren inhibit
// 5. !FS && float CSRs
// 6. !FS && vector CSRs
// assign regs_mmode = regs_pm[1:0] == 2'b11;
assign regs_smode = regs_pm[1:0] == 2'b01;
assign regs_umode = regs_pm[1:0] == 2'b00;
assign regs_csr_imm[11:0]   = iui_regs_imm[11:0];

assign regs_iui_trigger_mro   = regs_csr_imm[11:0] == TINFO;
assign regs_iui_trigger_smode = regs_csr_imm[11:0] == SCONTEXT;

// &CombBeg; @364
always @( regs_ext_imm_inv
       or regs_smode
       or regs_fs_off
       or rtu_yy_xx_dbgon
       or regs_csr_imm[11:0]
       or regs_ucnt_inv
       or regs_tvm)
begin
  casez(regs_csr_imm[11:0])
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
    CRMD,
    PRMD,
    EUEN,
    MISC,
    ECFG,
    ESTAT,
    ERA ,
    BADV,
    BADI,
    EENTRY,
    TLBIDX,
    TLBEHI,
    TLBELO0,
    TLBELO1,
    ASID,
    PGDL,
    PGDH,
    PGD,
    PWCL,
    PWCH,
    STLBPS,
    RVACFG,
    CPUID,
    PRCFG1,
    PRCFG2,
    PRCFG3,
    SAVE0,
    SAVE1,
    SAVE2,
    SAVE3,
    TID,
    TCFG,
    TVAL,
    CNTC,
    TICLR,
    LLBCTL,
    IMPCTL1,
    IMPCTL2,
    TLBRENTRY,
    TLBREHI,
    MERRENTRY,
    DMW0,
    DMW1,
    DMW2,
    DMW3,
    BRK,
    DIS_CACHE,
    DEBUG0,
    DEBUG1,
    DGWDUMP,
    CPRS,
    CPRS_CRMD,
    CPRS_TCFG,
    // PMU 
    PERFCTRL0,
    PERFCNTR0,
    PERFCTRL1,
    PERFCNTR1,
    PERFCTRL2,
    PERFCNTR2,
    PERFCTRL3,
    PERFCNTR3,
    PERFCTRL4,
    PERFCNTR4,
    PERFCTRL5,
    PERFCNTR5,
    PERFCTRL6,
    PERFCNTR6,
    MWPC,
    MWPS,
    FWPC,
    FWPS     : regs_imm_inv = 1'b0;
    FCSR0,
    FCSR1,
    FCSR2,
    FCSR3    : regs_imm_inv = 1'b0;

//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
    FFLAGS,
    FRM,
    FCSR      : regs_imm_inv = regs_fs_off;


//-------- User Counter/Timers ---------
    CYCLE,
    TIME,
    INSTRET,
    HPMCNT3,
    HPMCNT4,
    HPMCNT5,
    HPMCNT6,
    HPMCNT7,
    HPMCNT8,
    HPMCNT9,
    HPMCNT10,
    HPMCNT11,
    HPMCNT12,
    HPMCNT13,
    HPMCNT14,
    HPMCNT15,
    HPMCNT16,
    HPMCNT17,
    HPMCNT18,
    HPMCNT19,
    HPMCNT20,
    HPMCNT21,
    HPMCNT22,
    HPMCNT23,
    HPMCNT24,
    HPMCNT25,
    HPMCNT26,
    HPMCNT27,
    HPMCNT28,
    HPMCNT29,
    HPMCNT30,
    HPMCNT31 : regs_imm_inv = regs_ucnt_inv;

//----------------------------------------------------------
//                       Debug CSRs
//----------------------------------------------------------
    DCSR,
    DPC,
    DSCRATCH0,
    DSCRATCH1 : regs_imm_inv = !rtu_yy_xx_dbgon;

//----------------------------------------------------------
//                      Trigger CSRs
//----------------------------------------------------------
    TSELECT,
    TDATA1,
    TDATA2,
    TDATA3,
    TINFO,
    TCONTROL,
    MCONTEXT,
    SCONTEXT :  regs_imm_inv = 1'b0;

//----------------------------------------------------------
//                  M-Mode Extension CSRs
//----------------------------------------------------------
// 0x7C0-0x7FF
    12'b0111_11??_????,
// 0xBC0-0xBFF
    12'b1011_11??_????,
// 0xFC0-0xFFF
    12'b1111_11??_????: regs_imm_inv = regs_ext_imm_inv;

//----------------------------------------------------------
//                  S-Mode Extension CSRs
//----------------------------------------------------------
// 0x5C0-0x5FF
    12'b0101_11??_????,
// 0x9C0-0x9FF
    12'b1001_11??_????,
// 0xDC0-0xDFF
    12'b1101_11??_????: regs_imm_inv = regs_ext_imm_inv;

//----------------------------------------------------------
//                  U-Mode Extension CSRs
//----------------------------------------------------------
// 0x800-0x8FF
    12'b1000_????_????,
// 0xCC0-0xCFF
    12'b1100_11??_????: regs_imm_inv = regs_ext_imm_inv;

    default   : regs_imm_inv = 1'b1;
  endcase
// &CombEnd; @599
end

//==========================================================
//                  Extension CSRs Invalid
//==========================================================
// &CombBeg; @604
always @( hpcp_cp0_sce
       or regs_smode
       or regs_fs_off
       or regs_csr_imm[11:0]
       or regs_scnt_inv)
begin
  case(regs_csr_imm[11:0])
//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    MXSTATUS,
    MHCR,
    MCOR,
    MCCR2,
    MCER2,
    MHINT,
    MRMR,
    MRVBR,
    MCER,
    MCNTWEN,
    MCNTINTEN,
    MCNTOF,
    MHINT2,
    MHINT3,
    MHINT4    : regs_ext_imm_inv = 1'b0;

//------ Processor Data Extension ------
    MCINS,
    MCINDEX,
    MCDATA0,
    MCDATA1,
    MEICR,
    MEICR2    : regs_ext_imm_inv = 1'b0;

//------- Processor ID Extension -------
    MCPUID,
    MAPBADDR  : regs_ext_imm_inv = 1'b0;

//------- Processor ID Extension -------
    MHALTCAUSE,
    MDBGINFO,
    MPCFIFO : regs_ext_imm_inv = 1'b0;

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    SXSTATUS,
    SHCR,
    SCER2,
    SCER,
    SCNTINTEN,
    SCNTOF,
    SHINT,
    SHINT2,
    SCNTIHBT   : regs_ext_imm_inv = 1'b0;
    SHPMCR,
    SHPMSP,
    SHPMEP     : regs_ext_imm_inv = regs_smode && !hpcp_cp0_sce; 

//----- Supervisor Counters/Timers -----
    SCYCLE,
    SINSTRET,
    SHPMCNT3,
    SHPMCNT4,
    SHPMCNT5,
    SHPMCNT6,
    SHPMCNT7,
    SHPMCNT8,
    SHPMCNT9,
    SHPMCNT10,
    SHPMCNT11,
    SHPMCNT12,
    SHPMCNT13,
    SHPMCNT14,
    SHPMCNT15,
    SHPMCNT16,
    SHPMCNT17,
    SHPMCNT18,
    SHPMCNT19,
    SHPMCNT20,
    SHPMCNT21,
    SHPMCNT22,
    SHPMCNT23,
    SHPMCNT24,
    SHPMCNT25,
    SHPMCNT26,
    SHPMCNT27,
    SHPMCNT28,
    SHPMCNT29,
    SHPMCNT30,
    SHPMCNT31 : regs_ext_imm_inv = regs_scnt_inv;

//------ TLB Operation Extension -------
    SMIR,
    SMEL,
    SMEH,
    SMCIR     : regs_ext_imm_inv = 1'b0;

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
    FXCR      : regs_ext_imm_inv = regs_fs_off;
    default   : regs_ext_imm_inv = 1'b0;
  endcase
// &CombEnd; @713
end

//==========================================================
//                    CSRs Write Decode
//==========================================================
assign regs_csr_wen = iui_regs_csr_wen;
assign regs_csr_wen_no_imm_ill = iui_regs_csr_wen_no_imm_ill;
assign regs_csr_write_no_imm_ill = iui_regs_csr_write_no_imm_ill;


//==========================================================
//                    LoongArch CSR
//==========================================================
//==========================================================
//              Generate Local Signal to CSRs
//==========================================================
assign arch_ctrl_local_en  = regs_csr_wen & (regs_csr_imm[11:0] == ARCH);
assign crmd_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == CRMD);
assign prmd_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == PRMD);
assign euen_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == EUEN);
assign misc_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == MISC);
assign ecfg_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == ECFG);
assign estat_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == ESTAT);
assign era_local_en        = regs_csr_wen & (regs_csr_imm[11:0] == ERA);
assign badv_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == BADV);
assign eentry_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == EENTRY);
assign tlbidx_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == TLBIDX);
assign tlbehi_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == TLBEHI);
assign tlbelo0_local_en    = regs_csr_wen & (regs_csr_imm[11:0] == TLBELO0);
assign tlbelo1_local_en    = regs_csr_wen & (regs_csr_imm[11:0] == TLBELO1);
assign asid_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == ASID);
assign pgdl_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == PGDL);
assign pgdh_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == PGDH);
assign pgd_local_en        = regs_csr_wen & (regs_csr_imm[11:0] == PGD);


assign pwcl_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == PWCL);
assign pwch_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == PWCH);
assign stlbps_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == STLBPS);
assign rvacfg_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == RVACFG);

assign cpuid_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == CPUID);
assign save0_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == SAVE0);
assign save1_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == SAVE1);
assign save2_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == SAVE2);
assign save3_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == SAVE3);
assign tid_local_en        = regs_csr_wen & (regs_csr_imm[11:0] == TID);
assign tcfg_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == TCFG);
assign tval_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == TVAL);
assign cntc_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == CNTC);
assign ticlr_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == TICLR);
assign llbctl_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == LLBCTL);

assign impctl1_local_en    = regs_csr_wen & (regs_csr_imm[11:0] == IMPCTL1);
assign impctl2_local_en    = regs_csr_wen & (regs_csr_imm[11:0] == IMPCTL2);
assign tlbrentry_local_en  = regs_csr_wen & (regs_csr_imm[11:0] == TLBRENTRY);
assign tlbrehi_local_en    = regs_csr_wen & (regs_csr_imm[11:0] == TLBREHI);

assign merrentry_local_en  = regs_csr_wen & (regs_csr_imm[11:0] == MERRENTRY);
assign dmw0_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == DMW0);
assign dmw1_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == DMW1);
assign dmw2_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == DMW2);
assign dmw3_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == DMW3);
assign BRK_local_en        = regs_csr_wen & (regs_csr_imm[11:0] == BRK);
assign dis_cache_local_en  = regs_csr_wen & (regs_csr_imm[11:0] == DIS_CACHE);

assign debug0_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == DEBUG0);
assign debug1_local_en     = regs_csr_wen & (regs_csr_imm[11:0] == DEBUG1);
assign dgwavedump_local_en = regs_csr_wen & (regs_csr_imm[11:0] == DGWDUMP);

assign cpcsr_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == CPRS);
assign cpcsr_tcfg_local_en = regs_csr_wen & (regs_csr_imm[11:0] == CPRS_TCFG);
assign cpcsr_crmd_local_en = regs_csr_wen & (regs_csr_imm[11:0] == CPRS_CRMD);

assign mwpc_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == MWPC);
assign mwps_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == MWPS);
assign fwpc_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == FWPC);
assign fwps_local_en       = regs_csr_wen & (regs_csr_imm[11:0] == FWPS);

assign fcsr0_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == FCSR0);
assign fcsr1_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == FCSR1);
assign fcsr2_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == FCSR2);
assign fcsr3_local_en      = regs_csr_wen & (regs_csr_imm[11:0] == FCSR3);


//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
//--- Machine Information Registers ----
// MVENDORID RO
// MARCHID   RO
// MIMPID    RO
// MHARTID   RO

// //--------- Machine Trap Setup ---------
// assign mstatus_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MSTATUS;
// // MISA      Implement RO
// assign medeleg_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MEDELEG;
// assign mideleg_local_en   = regs_csr_wen && regs_csr_imm[11:0] == MIDELEG;
// assign mie_local_en       = regs_csr_wen && regs_csr_imm[11:0] == MIE;
// assign mtvec_local_en     = regs_csr_wen && regs_csr_imm[11:0] == MTVEC;
// assign mcnten_local_en    = regs_csr_wen && regs_csr_imm[11:0] == MCNTEN;

// //------- Machine Trap Handling --------
// assign mscratch_local_en  = regs_csr_wen && regs_csr_imm[11:0] == MSCRATCH;
// assign mepc_local_en      = regs_csr_wen && regs_csr_imm[11:0] == MEPC;
// assign mcause_local_en    = regs_csr_wen && regs_csr_imm[11:0] == MCAUSE;
// assign mtval_local_en     = regs_csr_wen && regs_csr_imm[11:0] == MTVAL;
// assign mip_local_en       = regs_csr_wen && regs_csr_imm[11:0] == MIP;

//- Machine Protection and Translation -
// PMPCFGx PMPADDRx in PMP

//------ Machine Counters/Timers -------
// MHPMCNTx in HPCP

//------- Machine Counter Setup --------
// MCNTIHBT, MHPMEVT in HPCP


//----------------------------------------------------------
//                  Supervisor Level CSRs
//----------------------------------------------------------
//------- Supervisor Trap Setup --------
// assign sstatus_local_en   = regs_csr_wen && regs_csr_imm[11:0] == SSTATUS;
// assign sie_local_en       = regs_csr_wen && regs_csr_imm[11:0] == SIE;
// assign stvec_local_en     = regs_csr_wen && regs_csr_imm[11:0] == STVEC;
// assign scnten_local_en    = regs_csr_wen && regs_csr_imm[11:0] == SCNTEN;

// //------ Supervisor Trap Handling ------
// assign sscratch_local_en  = regs_csr_wen && regs_csr_imm[11:0] == SSCRATCH;
// assign sepc_local_en      = regs_csr_wen && regs_csr_imm[11:0] == SEPC;
// assign scause_local_en    = regs_csr_wen && regs_csr_imm[11:0] == SCAUSE;
// assign stval_local_en     = regs_csr_wen && regs_csr_imm[11:0] == STVAL;
// assign sip_local_en       = regs_csr_wen && regs_csr_imm[11:0] == SIP;

// // Supervisor Protection and Translation 
// assign satp_local_en      = regs_csr_wen && regs_csr_imm[11:0] == SATP;


//----------------------------------------------------------
//                     User Level CSRs
//----------------------------------------------------------
//------ User Floating-Point CSRs ------
assign fflags_local_en    = regs_csr_wen && regs_csr_imm[11:0] == FFLAGS;
assign frm_local_en       = regs_csr_wen && regs_csr_imm[11:0] == FRM;
assign fcsr_local_en      = regs_csr_wen && regs_csr_imm[11:0] == FCSR;

//---------- User Vector CSRs ----------
// VL        RO
// VTYPE     RO
// VLENB     RO

//-------- User Counter/Timers ---------
// HPMCNTx in HPCP


//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
assign mxstatus_local_en  = 1'b0;
assign mhcr_local_en      = 1'b0;
assign mcor_local_en      = 1'b0;
// parameter MCCR2     = 12'h7C3;
// parameter MCER2     = 12'h7C4;
assign mhint_local_en     = 1'b0;
// parameter MRMR      = 12'h7C6;
// parameter MRVBR     = 12'h7C7;
// parameter MCER      = 12'h7C8;
assign mcntwen_local_en   = 1'b0;
// MCNTINTEN in HPCP
// MCNTOF    in HPCP
assign mhint2_local_en    = 1'b0;
// parameter MHINT3    = 12'h7CD;
// parameter MHINT4    = 12'h7CE;
assign mhpmcr_local_en   = 1'b0;

//------ Processor Data Extension ------
assign mcins_local_en     = 1'b0;
assign mcindex_local_en   = 1'b0;
// parameter MCDATA0   = 12'h7D4;
// parameter MCDATA1   = 12'h7D5;
// parameter MEICR     = 12'h7D6;
// parameter MEICR2    = 12'h7D7;

//------- Processor ID Extension -------
assign mcpuid_local_en    = 1'b0;
// parameter MAPBADDR  = 12'hFC1;

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
assign sxstatus_local_en  = 1'b0;
// SHCR RO
// parameter SCER2     = 12'h5C2;
// parameter SCER      = 12'h5C3;
// SCNTINTEN in HPCP
// SCNTOF    in HPCP
// parameter SHINT     = 12'h5C6;
// parameter SHINT2    = 12'h5C7;

//----- Supervisor Counters/Timers -----
// SHPMCNTx in HPCP

//------ TLB Operation Extension -------
assign smcir_local_en     = 1'b0;
assign smcir_local_en_raw = 1'b0;
// SMXX in MMU
//
assign shpmcr_local_en    = 1'b0;

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
assign fxcr_local_en      = 1'b0;

//==========================================================
//                      CSRs Read Port
//==========================================================
// &CombBeg; @875
always @( scer2_value[63:0]
       or mhint3_value[63:0]
       or satp_value[63:0]
       or shint2_value[63:0]
       or sepc_value[63:0]
       or mxstatus_value[63:0]
       or mrvbr_value[63:0]
       or vxrm_value[63:0]
       or sip_value[63:0]
       or mip_value[63:0]
       or stvec_value[63:0]
       or mhartid_value[63:0]
       or mtvec_value[63:0]
       or hpcp_value[63:0]
       or mhint_value[63:0]
       or mcpuid_value[63:0]
       or vxsat_value[63:0]
       or mccr2_value[63:0]
       or mcindex_value[63:0]
       or mhint4_value[63:0]
       or mvendorid_value[63:0]
       or sxstatus_value[63:0]
       or frm_value[63:0]
       or scause_value[63:0]
       or meicr2_value[63:0]
       or mcause_value[63:0]
       or mcntwen_value[63:0]
       or sstatus_value[63:0]
       or scer_value[63:0]
       or mcer2_value[63:0]
       or mtval_value[63:0]
       or scnten_value[63:0]
       or mimpid_value[63:0]
       or vl_value[63:0]
       or marchid_value[63:0]
       or fxcr_value[63:0]
       or vlenb_value[63:0]
       or mmu_value[63:0]
       or mepc_value[63:0]
       or mideleg_value[63:0]
       or meicr_value[63:0]
       or mcdata1_value[63:0]
       or sie_value[63:0]
       or fflags_value[63:0]
       or mhcr_value[63:0]
       or fcsr_value[63:0]
       or mcer_value[63:0]
       or mscratch_value[63:0]
       or mcins_value[63:0]
       or mstatus_value[63:0]
       or shint_value[63:0]
       or medeleg_value[63:0]
       or pmp_value[63:0]
       or misa_value[63:0]
       or sscratch_value[63:0]
       or mie_value[63:0]
       or mrmr_value[63:0]
       or stval_value[63:0]
       or mcdata0_value[63:0]
       or regs_csr_imm[11:0]
       or mcnten_value[63:0]
       or mapbaddr_value[63:0]
       or shcr_value[63:0]
       or mhint2_value[63:0]
       or vtype_value[63:0]
       or dtu_cp0_rdata[63:0]
       or mcor_value[63:0]
       or vstart_value[63:0]

       or csrarch_value[63:0]
       or csrcrmd_value[63:0]
       or csrprmd_value[63:0]
       or csreuen_value[63:0]
       or csrmisc_value[63:0]
       or csrecfg_value[63:0]
       or csrestat_value[63:0]
       or csrera_value[63:0]
       or csrbadv_value[63:0]
       or csrbadi_value[63:0]
       or csreentry_value[63:0]
       or csrimpctl1_value[63:0]
       or csrimpctl2_value[63:0]
       or csrtlbrentry_value[63:0]
       or csrmerrentry_value[63:0]
       or csrtlbidx_value[63:0]
       or csrpwcl_value[63:0]
       or csrpwch_value[63:0]
       or csrstlbps_value[63:0]
       or csrrvacfg_value[63:0]
       or csrasid_value[63:0]
       or csrdmw0_value[63:0]
       or csrdmw1_value[63:0]
       or csrdmw2_value[63:0]
       or csrdmw3_value[63:0]
       or csrtid_value[63:0]
       or csrtcfg_value[63:0]
       or csrtval_value[63:0]
       or csrcntc_value[63:0]
       or csrticlr_value[63:0]
       or csrsave0_value[63:0]
       or csrsave1_value[63:0]
       or csrsave2_value[63:0]
       or csrsave3_value[63:0]
       or cpuid_value[63:0]
       or csrprcfg1_value[63:0]
       or csrprcfg2_value[63:0]
       or csrprcfg3_value[63:0]
       or csrrehi_value[63:0]
       or debug0_value[63:0]
       or debug1_value[63:0]
       or debug_wave_dump_value[63:0]
       or mwpc_value[63:0]
       or mwps_value[63:0]
       or fwpc_value[63:0]
       or fwps_value[63:0]
       or fcsr0_value[63:0]
       or fcsr1_value[63:0]
       or fcsr2_value[63:0]
       or fcsr3_value[63:0])
begin
  case (regs_csr_imm[11:0])
//----------------------------------------------------------
//                    Machine Level CSRs
//----------------------------------------------------------
    ARCH      : regs_csr_rdata[63:0] = csrarch_value[63:0];
    CRMD      : regs_csr_rdata[63:0] = csrcrmd_value[63:0];
    PRMD      : regs_csr_rdata[63:0] = csrprmd_value[63:0];
    EUEN      : regs_csr_rdata[63:0] = csreuen_value[63:0];
    MISC      : regs_csr_rdata[63:0] = csrmisc_value[63:0];
    ECFG      : regs_csr_rdata[63:0] = csrecfg_value[63:0];
    ESTAT     : regs_csr_rdata[63:0] = csrestat_value[63:0];
    ERA       : regs_csr_rdata[63:0] = csrera_value[63:0];
    BADV      : regs_csr_rdata[63:0] = csrbadv_value[63:0];
    BADI      : regs_csr_rdata[63:0] = csrbadi_value[63:0];
    EENTRY    : regs_csr_rdata[63:0] = csreentry_value[63:0];
    IMPCTL1   : regs_csr_rdata[63:0] = csrimpctl1_value[63:0];
    IMPCTL2   : regs_csr_rdata[63:0] = csrimpctl2_value[63:0];
    TLBRENTRY : regs_csr_rdata[63:0] = csrtlbrentry_value[63:0];
    MERRENTRY : regs_csr_rdata[63:0] = csrmerrentry_value[63:0];
    TLBIDX    : regs_csr_rdata[63:0] = csrtlbidx_value[63:0];
    PWCL      : regs_csr_rdata[63:0] = csrpwcl_value[63:0];
    PWCH      : regs_csr_rdata[63:0] = csrpwch_value[63:0];
    STLBPS    : regs_csr_rdata[63:0] = csrstlbps_value[63:0];
    RVACFG    : regs_csr_rdata[63:0] = csrrvacfg_value[63:0];
    ASID      : regs_csr_rdata[63:0] = csrasid_value[63:0];
    DMW0      : regs_csr_rdata[63:0] = csrdmw0_value[63:0];
    DMW1      : regs_csr_rdata[63:0] = csrdmw1_value[63:0];
    DMW2      : regs_csr_rdata[63:0] = csrdmw2_value[63:0];
    DMW3      : regs_csr_rdata[63:0] = csrdmw3_value[63:0];
    TID       : regs_csr_rdata[63:0] = csrtid_value[63:0];
    TCFG      : regs_csr_rdata[63:0] = csrtcfg_value[63:0];
    TVAL      : regs_csr_rdata[63:0] = csrtval_value[63:0];
    CNTC      : regs_csr_rdata[63:0] = csrcntc_value[63:0];
    TICLR     : regs_csr_rdata[63:0] = csrticlr_value[63:0];
    SAVE0     : regs_csr_rdata[63:0] = csrsave0_value[63:0];
    SAVE1     : regs_csr_rdata[63:0] = csrsave1_value[63:0];
    SAVE2     : regs_csr_rdata[63:0] = csrsave2_value[63:0];
    SAVE3     : regs_csr_rdata[63:0] = csrsave3_value[63:0];
    CPUID     : regs_csr_rdata[63:0] = cpuid_value[63:0];
    PRCFG1    : regs_csr_rdata[63:0] = csrprcfg1_value[63:0];
    PRCFG2    : regs_csr_rdata[63:0] = csrprcfg2_value[63:0];
    PRCFG3    : regs_csr_rdata[63:0] = csrprcfg3_value[63:0];
    TLBREHI   : regs_csr_rdata[63:0] = csrrehi_value[63:0];
    DEBUG0    : regs_csr_rdata[63:0] = debug0_value[63:0];
    DEBUG1    : regs_csr_rdata[63:0] = debug1_value[63:0];
    DGWDUMP   : regs_csr_rdata[63:0] = debug_wave_dump_value[63:0];
    MWPC      : regs_csr_rdata[63:0] = mwpc_value[63:0];
    MWPS      : regs_csr_rdata[63:0] = mwps_value[63:0];
    FWPC      : regs_csr_rdata[63:0] = fwpc_value[63:0];
    FWPS      : regs_csr_rdata[63:0] = fwps_value[63:0];
    // FPU
    FCSR0     : regs_csr_rdata[63:0] = fcsr0_value[63:0];
    FCSR1     : regs_csr_rdata[63:0] = fcsr1_value[63:0];
    FCSR2     : regs_csr_rdata[63:0] = fcsr2_value[63:0];
    FCSR3     : regs_csr_rdata[63:0] = fcsr3_value[63:0];

//----------------------------------------------------------
//                       Debug CSRs
//----------------------------------------------------------
    DCSR,
    DPC,
    DSCRATCH0,
    DSCRATCH1 : regs_csr_rdata[63:0] = dtu_cp0_rdata[63:0];

//----------------------------------------------------------
//                      Trigger CSRs
//----------------------------------------------------------
    TSELECT,
    TDATA1,
    TDATA2,
    TDATA3,
    TINFO,
    TCONTROL,
    MCONTEXT,
    SCONTEXT :  regs_csr_rdata[63:0] = dtu_cp0_rdata[63:0];

//----------------------------------------------------------
//               M-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    MXSTATUS  : regs_csr_rdata[63:0] = mxstatus_value[63:0];
    MHCR      : regs_csr_rdata[63:0] = mhcr_value[63:0];
    MCOR      : regs_csr_rdata[63:0] = mcor_value[63:0];
    MCCR2     : regs_csr_rdata[63:0] = mccr2_value[63:0];
    MCER2     : regs_csr_rdata[63:0] = mcer2_value[63:0];
    MHINT     : regs_csr_rdata[63:0] = mhint_value[63:0];
    MRMR      : regs_csr_rdata[63:0] = mrmr_value[63:0];
    MRVBR     : regs_csr_rdata[63:0] = mrvbr_value[63:0];
    MCER      : regs_csr_rdata[63:0] = mcer_value[63:0];
    MCNTWEN   : regs_csr_rdata[63:0] = mcntwen_value[63:0];
    MCNTINTEN : regs_csr_rdata[63:0] = hpcp_value[63:0];
    MCNTOF    : regs_csr_rdata[63:0] = hpcp_value[63:0];
    MHINT2    : regs_csr_rdata[63:0] = mhint2_value[63:0];
    MHINT3    : regs_csr_rdata[63:0] = mhint3_value[63:0];
    MHINT4    : regs_csr_rdata[63:0] = mhint4_value[63:0];

//------ Processor Data Extension ------
    MCINS     : regs_csr_rdata[63:0] = mcins_value[63:0];
    MCINDEX   : regs_csr_rdata[63:0] = mcindex_value[63:0];
    MCDATA0   : regs_csr_rdata[63:0] = mcdata0_value[63:0];
    MCDATA1   : regs_csr_rdata[63:0] = mcdata1_value[63:0];
    MEICR     : regs_csr_rdata[63:0] = meicr_value[63:0];
    MEICR2    : regs_csr_rdata[63:0] = meicr2_value[63:0];

//------- Processor ID Extension -------
    MCPUID    : regs_csr_rdata[63:0] = mcpuid_value[63:0];
    MAPBADDR  : regs_csr_rdata[63:0] = mapbaddr_value[63:0];

//------------Debug Extension-----------
    MHALTCAUSE,
    MDBGINFO,
    MPCFIFO   : regs_csr_rdata[63:0] = dtu_cp0_rdata[63:0];

//----------------------------------------------------------
//               S-Mode T-Head Extension CSRs
//----------------------------------------------------------
// Processor Control and Status Extension 
    SXSTATUS  : regs_csr_rdata[63:0] = sxstatus_value[63:0];
    SHCR      : regs_csr_rdata[63:0] = shcr_value[63:0];
    SCER2     : regs_csr_rdata[63:0] = scer2_value[63:0];
    SCER      : regs_csr_rdata[63:0] = scer_value[63:0];
    SCNTINTEN : regs_csr_rdata[63:0] = hpcp_value[63:0];
    SCNTOF    : regs_csr_rdata[63:0] = hpcp_value[63:0];
    SHINT     : regs_csr_rdata[63:0] = shint_value[63:0];
    SHINT2    : regs_csr_rdata[63:0] = shint2_value[63:0];
    SCNTIHBT,       
    SHPMCR,
    SHPMSP,
    SHPMEP    : regs_csr_rdata[63:0] = hpcp_value[63:0];


//----- Supervisor Counters/Timers -----
    SCYCLE,
    SINSTRET,
    SHPMCNT3,
    SHPMCNT4,
    SHPMCNT5,
    SHPMCNT6,
    SHPMCNT7,
    SHPMCNT8,
    SHPMCNT9,
    SHPMCNT10,
    SHPMCNT11,
    SHPMCNT12,
    SHPMCNT13,
    SHPMCNT14,
    SHPMCNT15,
    SHPMCNT16,
    SHPMCNT17,
    SHPMCNT18,
    SHPMCNT19,
    SHPMCNT20,
    SHPMCNT21,
    SHPMCNT22,
    SHPMCNT23,
    SHPMCNT24,
    SHPMCNT25,
    SHPMCNT26,
    SHPMCNT27,
    SHPMCNT28,
    SHPMCNT29,
    SHPMCNT30,
    SHPMCNT31 : regs_csr_rdata[63:0] = hpcp_value[63:0];

//------ TLB Operation Extension -------
    SMIR,
    SMEL,
    SMEH,
    SMCIR : regs_csr_rdata[63:0] = mmu_value[63:0];

//----------------------------------------------------------
//               U-Mode T-Head Extension CSRs
//----------------------------------------------------------
//--- Float Point Register Extension ---
    FXCR      : regs_csr_rdata[63:0] = fxcr_value[63:0];

    default   : regs_csr_rdata[63:0] = 64'b0; 
  endcase
// &CombEnd; @1181
end


//==========================================================
//                 Regs Read Data For Write
//==========================================================

// &CombBeg; @1188
always @( sip_raw[63:0]
       or regs_csr_rdata[63:0]
       or regs_csr_imm[11:0])
begin
  case (regs_csr_imm[11:0])
    default : regs_csr_rdata_for_w[63:0] = regs_csr_rdata[63:0]; 
  endcase
// &CombEnd; @1193
end

//==========================================================
//                      CSRs Instance
//==========================================================
// &Instance("aq_cp0_info_csr"); @1198
aq_cp0_info_csr  x_aq_cp0_info_csr (
  .biu_cp0_coreid           (biu_cp0_coreid          ),
  .cpurst_b                 (cpurst_b                ),
  .iui_regs_csr_en          (iui_regs_csr_en         ),
  .marchid_value            (marchid_value           ),
  .mcpuid_local_en          (mcpuid_local_en         ),
  .mcpuid_value             (mcpuid_value            ),
  .mhartid_value            (mhartid_value           ),
  .mimpid_value             (mimpid_value            ),
  .misa_value               (misa_value              ),
  .mvendorid_value          (mvendorid_value         ),
  .regs_clk                 (regs_clk                ),
  .regs_mxl                 (regs_mxl                )
);


// &Instance("aq_cp0_trap_csr"); @1200
aq_cp0_trap_csr  x_aq_cp0_trap_csr (
  .biu_cp0_me_int           (biu_cp0_me_int          ),
  .biu_cp0_ms_int           (biu_cp0_ms_int          ),
  .biu_cp0_mt_int           (biu_cp0_mt_int          ),
  .biu_cp0_se_int           (biu_cp0_se_int          ),
  .biu_cp0_ss_int           (biu_cp0_ss_int          ),
  .biu_cp0_st_int           (biu_cp0_st_int          ),
  .cp0_dtu_mexpt_vld        (cp0_dtu_mexpt_vld       ),
  .cp0_hpcp_int_off_vld     (cp0_hpcp_int_off_vld    ),
  .cp0_idu_fs               (cp0_idu_fs              ),
  .cp0_idu_vs               (cp0_idu_vs              ),
  .cp0_lsu_mpp              (cp0_lsu_mpp             ),
  .cp0_lsu_mprv             (cp0_lsu_mprv            ),
  .cp0_mmu_mxr              (cp0_mmu_mxr             ),
  .cp0_mmu_sum              (cp0_mmu_sum             ),
  .cp0_rtu_int_vld          (cp0_rtu_int_vld         ),
  .cp0_rtu_ecfg_vs          (cp0_rtu_ecfg_vs         ),
  .cp0_rtu_trap_pc          (cp0_rtu_trap_pc         ),
  .cp0_yy_priv_mode         (cp0_yy_priv_mode        ),
  .cpurst_b                 (cpurst_b                ),
  .dtu_cp0_dcsr_mprven      (dtu_cp0_dcsr_mprven     ),
  .dtu_cp0_dcsr_prv         (dtu_cp0_dcsr_prv        ),
  .fcsr_local_en            (fcsr_local_en           ),
  .fflags_local_en          (fflags_local_en         ),
  .float_clk                (float_clk               ),
  .frm_local_en             (frm_local_en            ),
  .fs_dirty_upd_gate        (fs_dirty_upd_gate       ),
  .fxcr_local_en            (fxcr_local_en           ),
  .hpcp_cp0_int_vld         (hpcp_cp0_int_vld        ),
  .iui_regs_inst_ertn       (iui_regs_inst_ertn      ),
  .iui_regs_inst_mret       (iui_regs_inst_mret      ),
  .iui_regs_inst_sret       (iui_regs_inst_sret      ),
  .iui_regs_inst_cprs       (iui_regs_inst_cprs      ),
  .iui_regs_wdata           (iui_regs_wdata          ),
  .mcause_local_en          (mcause_local_en         ),
  .mcause_value             (mcause_value            ),
  .medeleg_local_en         (medeleg_local_en        ),
  .medeleg_value            (medeleg_value           ),
  .mepc_local_en            (mepc_local_en           ),
  .mepc_value               (mepc_value              ),
  .mideleg_local_en         (mideleg_local_en        ),
  .mideleg_value            (mideleg_value           ),
  .mie_local_en             (mie_local_en            ),
  .mie_value                (mie_value               ),
  .mip_local_en             (mip_local_en            ),
  .mip_value                (mip_value               ),
  .mscratch_local_en        (mscratch_local_en       ),
  .mscratch_value           (mscratch_value          ),
  .mstatus_local_en         (mstatus_local_en        ),
  .mstatus_value            (mstatus_value           ),
  .mtval_local_en           (mtval_local_en          ),
  .mtval_value              (mtval_value             ),
  .mtvec_local_en           (mtvec_local_en          ),
  
  .ext_interrupt            (ext_interrupt           ),
  .arch_ctrl_local_en       (arch_ctrl_local_en      ),
  .crmd_local_en            (crmd_local_en           ),
  .prmd_local_en            (prmd_local_en           ),
  .euen_local_en            (euen_local_en           ),
  .misc_local_en            (misc_local_en           ),
  .ecfg_local_en            (ecfg_local_en           ),
  .estat_local_en           (estat_local_en          ),
  .era_local_en             (era_local_en            ),
  .badv_local_en            (badv_local_en           ),
  .eentry_local_en          (eentry_local_en         ),
  .tlbidx_local_en          (tlbidx_local_en         ),
  .tlbehi_local_en          (tlbehi_local_en         ),
  .tlbelo0_local_en         (tlbelo0_local_en        ),
  .tlbelo1_local_en         (tlbelo1_local_en        ),
  .asid_local_en            (asid_local_en           ),
  .pgdl_local_en            (pgdl_local_en           ),
  .pgdh_local_en            (pgdh_local_en           ),
  .pgd_local_en             (pgd_local_en            ),
  .pwcl_local_en            (pwcl_local_en           ),
  .pwch_local_en            (pwch_local_en           ),
  .stlbps_local_en          (stlbps_local_en         ),
  .rvacfg_local_en          (rvacfg_local_en         ),
  .cpuid_local_en           (cpuid_local_en          ),
  .save0_local_en           (save0_local_en          ),
  .save1_local_en           (save1_local_en          ),
  .save2_local_en           (save2_local_en          ),
  .save3_local_en           (save3_local_en          ),
  .tid_local_en             (tid_local_en            ),
  .tcfg_local_en            (tcfg_local_en           ),
  .tval_local_en            (tval_local_en           ),
  .cntc_local_en            (cntc_local_en           ),
  .ticlr_local_en           (ticlr_local_en          ),
  .llbctl_local_en          (llbctl_local_en         ),
  .tlbrentry_local_en       (tlbrentry_local_en      ),
  .tlbrehi_local_en         (tlbrehi_local_en        ),
  .merrentry_local_en       (merrentry_local_en      ),
  .dmw0_local_en            (dmw0_local_en           ),
  .dmw1_local_en            (dmw1_local_en           ),
  .dmw2_local_en            (dmw2_local_en           ),
  .dmw3_local_en            (dmw3_local_en           ),
  .BRK_local_en             (BRK_local_en            ),
  .dis_cache_local_en       (dis_cache_local_en      ),
  .debug0_local_en          (debug0_local_en         ),
  .debug1_local_en          (debug1_local_en         ),
  .dgwavedump_local_en      (dgwavedump_local_en     ),
  .cpcsr_local_en           (cpcsr_local_en          ),
  .cpcsr_tcfg_local_en      (cpcsr_tcfg_local_en     ),
  .cpcsr_crmd_local_en      (cpcsr_crmd_local_en     ),

  .mwpc_local_en            (mwpc_local_en           ),
  .mwps_local_en            (mwps_local_en           ),
  .fwpc_local_en            (fwpc_local_en           ),
  .fwps_local_en            (fwps_local_en           ),
  .fcsr0_local_en           (fcsr0_local_en          ),
  .fcsr1_local_en           (fcsr1_local_en          ),
  .fcsr2_local_en           (fcsr2_local_en          ),
  .fcsr3_local_en           (fcsr3_local_en          ),
  .iui_regs_csr_cpucfg_op   (iui_regs_csr_cpucfg_op  ),

  .csrarch_value            (csrarch_value[63:0]     ),
  .csrcrmd_value            (csrcrmd_value[63:0]     ),
  .csrprmd_value            (csrprmd_value[63:0]     ),
  .csreuen_value            (csreuen_value[63:0]     ),
  .csrmisc_value            (csrmisc_value[63:0]     ),
  .csrecfg_value            (csrecfg_value[63:0]     ),
  .csrestat_value           (csrestat_value[63:0]    ),
  .csrera_value             (csrera_value[63:0]      ),
  .csrbadv_value            (csrbadv_value[63:0]     ),
  .csrbadi_value            (csrbadi_value[63:0]     ),
  .csreentry_value          (csreentry_value[63:0]   ),
  .csrtlbrentry_value       (csrtlbrentry_value[63:0]),
  .csrmerrentry_value       (csrmerrentry_value[63:0]),
  .csrtlbidx_value          (csrtlbidx_value[63:0]   ),
  .csrpwcl_value            (csrpwcl_value[63:0]     ),
  .csrpwch_value            (csrpwch_value[63:0]     ),
  .csrstlbps_value          (csrstlbps_value[63:0]   ),
  .csrrvacfg_value          (csrrvacfg_value[63:0]   ),
  .csrasid_value            (csrasid_value[63:0]     ),
  .csrdmw0_value            (csrdmw0_value[63:0]     ),
  .csrdmw1_value            (csrdmw1_value[63:0]     ),
  .csrdmw2_value            (csrdmw2_value[63:0]     ),
  .csrdmw3_value            (csrdmw3_value[63:0]     ),
  .csrtid_value             (csrtid_value[63:0]      ),
  .csrtcfg_value            (csrtcfg_value[63:0]     ),
  .csrtval_value            (csrtval_value[63:0]     ),
  .csrcntc_value            (csrcntc_value[63:0]     ),
  .csrticlr_value           (csrticlr_value[63:0]    ),
  .csrsave0_value           (csrsave0_value[63:0]    ),
  .csrsave1_value           (csrsave1_value[63:0]    ),
  .csrsave2_value           (csrsave2_value[63:0]    ),
  .csrsave3_value           (csrsave3_value[63:0]    ),
  .cpuid_value              (cpuid_value[63:0]       ),
  .csrpgdh_value            (csrpgdh_value[63:0]     ),
  .csrpgdl_value            (csrpgdl_value[63:0]     ),
  .csrprcfg1_value          (csrprcfg1_value[63:0]   ),
  .csrprcfg2_value          (csrprcfg2_value[63:0]   ),
  .csrprcfg3_value          (csrprcfg3_value[63:0]   ),
  .csrrehi_value            (csrrehi_value[63:0]     ),
  .debug0_value             (debug0_value[63:0]      ),
  .debug1_value             (debug1_value[63:0]      ),
  .debug_wave_dump_value    (debug_wave_dump_value[63:0]),
  .mwpc_value               (mwpc_value[63:0]        ),
  .mwps_value               (mwps_value[63:0]        ),
  .fwpc_value               (fwpc_value[63:0]        ),
  .fwps_value               (fwps_value[63:0]        ),
  .fcsr0_value              (fcsr0_value[63:0]       ),
  .fcsr1_value              (fcsr1_value[63:0]       ),
  .fcsr2_value              (fcsr2_value[63:0]       ),
  .fcsr3_value              (fcsr3_value[63:0]       ),
  .cp0_mmu_crmd_da          (cp0_mmu_crmd_da         ),
  .cp0_mmu_crmd_pg          (cp0_mmu_crmd_pg         ),
  .cp0_mmu_dmw0             (cp0_mmu_dmw0            ),
  .cp0_mmu_dmw1             (cp0_mmu_dmw1            ),
  .cp0_mmu_dmw2             (cp0_mmu_dmw2            ),
  .cp0_mmu_dmw3             (cp0_mmu_dmw3            ),
  .mtvec_value              (mtvec_value             ),
  .regs_clintee             (regs_clintee            ),
  .regs_clk                 (regs_clk                ),
  .regs_flush_clk           (regs_flush_clk          ),
  .regs_fs_off              (regs_fs_off             ),
  .regs_iui_era             (regs_iui_era            ),
  .regs_iui_mepc            (regs_iui_mepc           ),
  .regs_iui_rdtime          (regs_iui_rdtime         ),
  .regs_iui_cfg_data        (regs_iui_cfg_data       ),
  .regs_iui_pm              (regs_iui_pm             ),
  .regs_iui_sepc            (regs_iui_sepc           ),
  .regs_iui_cprs            (regs_iui_cprs           ),
  .regs_iui_tsr             (regs_iui_tsr            ),
  .regs_iui_tvm             (regs_iui_tvm            ),
  .regs_iui_tw              (regs_iui_tw             ),
  .regs_lpmd_int_vld        (regs_lpmd_int_vld       ),
  .regs_mxl                 (regs_mxl                ),
  .regs_pm                  (regs_pm                 ),
  .regs_tvm                 (regs_tvm                ),
  .rtu_cp0_epc              (rtu_cp0_epc             ),
  .rtu_cp0_exit_debug       (rtu_cp0_exit_debug      ),
  .rtu_cp0_fs_dirty_updt    (rtu_cp0_fs_dirty_updt   ),
  .rtu_cp0_fs_dirty_updt_dp (rtu_cp0_fs_dirty_updt_dp),
  .rtu_cp0_tval             (rtu_cp0_tval            ),
  .rtu_cp0_vs_dirty_updt    (rtu_cp0_vs_dirty_updt   ),
  .rtu_cp0_vs_dirty_updt_dp (rtu_cp0_vs_dirty_updt_dp),
  .rtu_cp0_fflags_updt      (rtu_cp0_fflags_updt     ),
  .rtu_cp0_split_vld        (rtu_cp0_split_vld       ),
  .rtu_cp0_fflags           (rtu_cp0_fflags          ),
  .rtu_yy_xx_dbgon          (rtu_yy_xx_dbgon         ),
  .rtu_yy_xx_expt_int       (rtu_yy_xx_expt_int      ),
  .rtu_yy_xx_expt_vec       (rtu_yy_xx_expt_vec      ),
  .rtu_yy_xx_expt_vld       (rtu_yy_xx_expt_vld      ),
  .cp0_vpu_fflags_enable    (cp0_vpu_fflags_enable   ),
  .scause_local_en          (scause_local_en         ),
  .scause_value             (scause_value            ),
  .sepc_local_en            (sepc_local_en           ),
  .sepc_value               (sepc_value              ),
  .sie_local_en             (sie_local_en            ),
  .sie_value                (sie_value               ),
  .sip_local_en             (sip_local_en            ),
  .sip_raw                  (sip_raw                 ),
  .sip_value                (sip_value               ),
  .sscratch_local_en        (sscratch_local_en       ),
  .sscratch_value           (sscratch_value          ),
  .sstatus_local_en         (sstatus_local_en        ),
  .sstatus_value            (sstatus_value           ),
  .stval_local_en           (stval_local_en          ),
  .stval_value              (stval_value             ),
  .stvec_local_en           (stvec_local_en          ),
  .stvec_value              (stvec_value             ),
  .vs_dirty_upd_gate        (vs_dirty_upd_gate       )
);


// &Instance("aq_cp0_prtc_csr"); @1202
aq_cp0_prtc_csr  x_aq_cp0_prtc_csr (
  .cp0_dtu_satp             (cp0_dtu_satp            ),
  .cp0_mmu_satp_data        (cp0_mmu_satp_data       ),
  .cp0_mmu_satp_wen         (cp0_mmu_satp_wen        ),
  .cpurst_b                 (cpurst_b                ),
  .iui_regs_wdata           (iui_regs_wdata          ),
  .mmu_cp0_cmplt            (mmu_cp0_cmplt           ),
  .mmu_cp0_data             (mmu_cp0_data            ),
  .mmu_value                (mmu_value               ),
  .pmp_cp0_data             (pmp_cp0_data            ),
  .pmp_value                (pmp_value               ),
  .regs_clk                 (regs_clk                ),
  .regs_iui_smcir_stall     (regs_iui_smcir_stall    ),
  .satp_local_en            (satp_local_en           ),
  .satp_value               (satp_value              ),
  .smcir_local_en           (smcir_local_en          ),
  .smcir_local_en_raw       (smcir_local_en_raw      )
);


// &Instance("aq_cp0_hpcp_csr"); @1204
aq_cp0_hpcp_csr  x_aq_cp0_hpcp_csr (
  .cp0_hpcp_mcntwen         (cp0_hpcp_mcntwen        ),
  .cpurst_b                 (cpurst_b                ),
  .hpcp_cp0_data            (hpcp_cp0_data           ),
  .hpcp_value               (hpcp_value              ),
  .iui_regs_csr_write       (iui_regs_csr_write      ),
  .iui_regs_imm             (iui_regs_imm            ),
  .iui_regs_wdata           (iui_regs_wdata          ),
  .mcnten_local_en          (mcnten_local_en         ),
  .mcnten_value             (mcnten_value            ),
  .mcntwen_local_en         (mcntwen_local_en        ),
  .mcntwen_value            (mcntwen_value           ),
  .regs_clk                 (regs_clk                ),
  .regs_scnt_inv            (regs_scnt_inv           ),
  .regs_smode               (regs_smode              ),
  .regs_ucnt_inv            (regs_ucnt_inv           ),
  .regs_umode               (regs_umode              ),
  .scnten_local_en          (scnten_local_en         ),
  .scnten_value             (scnten_value            )
);


// &Instance("aq_cp0_float_csr"); @1206
aq_cp0_float_csr  x_aq_cp0_float_csr (
  .cp0_idu_frm              (cp0_idu_frm             ),
  .cp0_idu_vill             (cp0_idu_vill            ),
  .cp0_idu_vl_zero          (cp0_idu_vl_zero         ),
  .cp0_idu_vlmul            (cp0_idu_vlmul           ),
  .cp0_idu_vsew             (cp0_idu_vsew            ),
  .cp0_idu_vstart           (cp0_idu_vstart          ),
  .cp0_rtu_vstart_eq_0      (cp0_rtu_vstart_eq_0     ),
  .cp0_vpu_xx_bf16          (cp0_vpu_xx_bf16         ),
  .cp0_vpu_xx_dqnan         (cp0_vpu_xx_dqnan        ),
  .cp0_vpu_xx_rm            (cp0_vpu_xx_rm           ),
  .cp0_yy_clk_en            (cp0_yy_clk_en           ),
  .cpurst_b                 (cpurst_b                ),
  .fcsr_local_en            (fcsr_local_en           ),
  .fcsr_value               (fcsr_value              ),
  .fcsr0_value              (fcsr0_value             ),
  .fflags_local_en          (fflags_local_en         ),
  .fflags_value             (fflags_value            ),
  .float_clk                (float_clk               ),
  .forever_cpuclk           (forever_cpuclk          ),
  .frm_local_en             (frm_local_en            ),
  .frm_value                (frm_value               ),
  .fs_dirty_upd_gate        (fs_dirty_upd_gate       ),
  .fxcr_local_en            (fxcr_local_en           ),
  .fxcr_value               (fxcr_value              ),
  .iui_inst_rs2             (iui_inst_rs2            ),
  .iui_regs_csr_wen         (iui_regs_csr_wen        ),
  .iui_regs_wdata           (iui_regs_wdata          ),
  .iui_vsetvl_bypass        (iui_vsetvl_bypass       ),
  .iui_vsetvl_data          (iui_vsetvl_data         ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      ),
  .regs_clk                 (regs_clk                ),
  .regs_xx_icg_en           (regs_xx_icg_en          ),
  .rtu_cp0_fflags           (rtu_cp0_fflags          ),
  .rtu_cp0_fflags_updt      (rtu_cp0_fflags_updt     ),
  .rtu_cp0_split_vld        (rtu_cp0_split_vld       ),
  .rtu_cp0_vl               (rtu_cp0_vl              ),
  .rtu_cp0_vl_vld           (rtu_cp0_vl_vld          ),
  .rtu_cp0_vstart           (rtu_cp0_vstart          ),
  .rtu_cp0_vstart_vld       (rtu_cp0_vstart_vld      ),
  .rtu_cp0_vxsat            (rtu_cp0_vxsat           ),
  .rtu_cp0_vxsat_vld        (rtu_cp0_vxsat_vld       ),
  .special_regs_vill        (special_regs_vill       ),
  .special_regs_vsetvl_dp   (special_regs_vsetvl_dp  ),
  .special_vsetvl_illegal   (special_vsetvl_illegal  ),
  .vl_value                 (vl_value                ),
  .vlenb_value              (vlenb_value             ),
  .vs_dirty_upd_gate        (vs_dirty_upd_gate       ),
  .vstart_value             (vstart_value            ),
  .vtype_value              (vtype_value             ),
  .vxrm_value               (vxrm_value              ),
  .vxsat_value              (vxsat_value             )
);


// &Instance("aq_cp0_ext_csr"); @1208
aq_cp0_ext_csr  x_aq_cp0_ext_csr (
  .biu_cp0_rvba                 (biu_cp0_rvba                ),
  .cp0_biu_icg_en               (cp0_biu_icg_en              ),
  .cp0_dtu_icg_en               (cp0_dtu_icg_en              ),
  .cp0_dtu_pcfifo_frz           (cp0_dtu_pcfifo_frz          ),
  .cp0_hpcp_icg_en              (cp0_hpcp_icg_en             ),
  .cp0_hpcp_pmdm                (cp0_hpcp_pmdm               ),
  .cp0_hpcp_pmds                (cp0_hpcp_pmds               ),
  .cp0_hpcp_pmdu                (cp0_hpcp_pmdu               ),
  .cp0_idu_cskyee               (cp0_idu_cskyee              ),
  .cp0_idu_dis_fence_in_dbg     (cp0_idu_dis_fence_in_dbg    ),
  .cp0_idu_icg_en               (cp0_idu_icg_en              ),
  .cp0_idu_ucme                 (cp0_idu_ucme                ),
  .cp0_ifu_bht_en               (cp0_ifu_bht_en              ),
  .cp0_ifu_btb_clr              (cp0_ifu_btb_clr             ),
  .cp0_ifu_btb_en               (cp0_ifu_btb_en              ),
  .cp0_ifu_icache_en            (cp0_ifu_icache_en           ),
  .cp0_ifu_icache_pref_en       (cp0_ifu_icache_pref_en      ),
  .cp0_ifu_icache_read_index    (cp0_ifu_icache_read_index   ),
  .cp0_ifu_icache_read_req      (cp0_ifu_icache_read_req     ),
  .cp0_ifu_icache_read_tag      (cp0_ifu_icache_read_tag     ),
  .cp0_ifu_icache_read_way      (cp0_ifu_icache_read_way     ),
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_ifu_iwpe                 (cp0_ifu_iwpe                ),
  .cp0_ifu_ras_en               (cp0_ifu_ras_en              ),
  .cp0_iu_icg_en                (cp0_iu_icg_en               ),
  .cp0_lsu_amr                  (cp0_lsu_amr                 ),
  .cp0_lsu_dcache_en            (cp0_lsu_dcache_en           ),
  .cp0_lsu_dcache_pref_dist     (cp0_lsu_dcache_pref_dist    ),
  .cp0_lsu_dcache_pref_en       (cp0_lsu_dcache_pref_en      ),
  .cp0_lsu_dcache_read_idx      (cp0_lsu_dcache_read_idx     ),
  .cp0_lsu_dcache_read_req      (cp0_lsu_dcache_read_req     ),
  .cp0_lsu_dcache_read_type     (cp0_lsu_dcache_read_type    ),
  .cp0_lsu_dcache_read_way      (cp0_lsu_dcache_read_way     ),
  .cp0_lsu_dcache_wa            (cp0_lsu_dcache_wa           ),
  .cp0_lsu_dcache_wb            (cp0_lsu_dcache_wb           ),
  .cp0_lsu_icg_en               (cp0_lsu_icg_en              ),
  .cp0_lsu_mm                   (cp0_lsu_mm                  ),
  .cp0_lsu_we_en                (cp0_lsu_we_en               ),
  .cp0_mmu_icg_en               (cp0_mmu_icg_en              ),
  .cp0_mmu_maee                 (cp0_mmu_maee                ),
  .cp0_mmu_ptw_en               (cp0_mmu_ptw_en              ),
  .cp0_pmp_icg_en               (cp0_pmp_icg_en              ),
  .cp0_rtu_icg_en               (cp0_rtu_icg_en              ),
  .cp0_vpu_icg_en               (cp0_vpu_icg_en              ),
  .cp0_xx_mrvbr                 (cp0_xx_mrvbr                ),
  .cpurst_b                     (cpurst_b                    ),
  .ifu_cp0_bht_inv_done         (ifu_cp0_bht_inv_done        ),
  .ifu_cp0_icache_inv_done      (ifu_cp0_icache_inv_done     ),
  .ifu_cp0_icache_read_data     (ifu_cp0_icache_read_data    ),
  .ifu_cp0_icache_read_data_vld (ifu_cp0_icache_read_data_vld),
  .iui_regs_wdata               (iui_regs_wdata              ),
  .lsu_cp0_dcache_read_data     (lsu_cp0_dcache_read_data    ),
  .lsu_cp0_dcache_read_data_vld (lsu_cp0_dcache_read_data_vld),
  .lsu_cp0_icc_done             (lsu_cp0_icc_done            ),
  .mapbaddr_value               (mapbaddr_value              ),
  .mccr2_value                  (mccr2_value                 ),
  .mcdata0_value                (mcdata0_value               ),
  .mcdata1_value                (mcdata1_value               ),
  .mcer2_value                  (mcer2_value                 ),
  .mcer_value                   (mcer_value                  ),
  .mcindex_local_en             (mcindex_local_en            ),
  .mcindex_value                (mcindex_value               ),
  .mcins_local_en               (mcins_local_en              ),
  .mcins_value                  (mcins_value                 ),
  .mcor_local_en                (mcor_local_en               ),
  .mcor_value                   (mcor_value                  ),
  .meicr2_value                 (meicr2_value                ),
  .meicr_value                  (meicr_value                 ),
  .mhcr_local_en                (mhcr_local_en               ),
  .mhcr_value                   (mhcr_value                  ),
  .mhint2_local_en              (mhint2_local_en             ),
  .mhint2_value                 (mhint2_value                ),
  .mhint3_value                 (mhint3_value                ),
  .mhint4_value                 (mhint4_value                ),
  .mhint_local_en               (mhint_local_en              ),
  .mhint_value                  (mhint_value                 ),
  .mhpmcr_local_en              (mhpmcr_local_en             ),
  .mrmr_value                   (mrmr_value                  ),
  .mrvbr_value                  (mrvbr_value                 ),
  .mxstatus_local_en            (mxstatus_local_en           ),
  .mxstatus_value               (mxstatus_value              ),
  .impctl1_local_en             (impctl1_local_en            ),
  .csrimpctl1_value             (csrimpctl1_value            ),
  .impctl2_local_en             (impctl2_local_en            ),
  .csrimpctl2_value             (csrimpctl2_value            ),
  .regs_clintee                 (regs_clintee                ),
  .regs_clk                     (regs_clk                    ),
  .regs_flush_clk               (regs_flush_clk              ),
  .regs_iui_mcins_stall         (regs_iui_mcins_stall        ),
  .regs_iui_mcor_stall          (regs_iui_mcor_stall         ),
  .regs_mcins_busy              (regs_mcins_busy             ),
  .regs_mcor_busy               (regs_mcor_busy              ),
  .regs_pm                      (regs_pm                     ),
  .regs_special_bht_inv         (regs_special_bht_inv        ),
  .regs_special_dcache_clr      (regs_special_dcache_clr     ),
  .regs_special_dcache_inv      (regs_special_dcache_inv     ),
  .regs_special_dcache_req      (regs_special_dcache_req     ),
  .regs_special_icache_inv      (regs_special_icache_inv     ),
  .regs_xx_icg_en               (regs_xx_icg_en              ),
  .rtu_yy_xx_flush              (rtu_yy_xx_flush             ),
  .scer2_value                  (scer2_value                 ),
  .scer_value                   (scer_value                  ),
  .shcr_value                   (shcr_value                  ),
  .shint2_value                 (shint2_value                ),
  .shint_value                  (shint_value                 ),
  .shpmcr_local_en              (shpmcr_local_en             ),
  .sxstatus_local_en            (sxstatus_local_en           ),
  .sxstatus_value               (sxstatus_value              ),
  .sysio_cp0_apb_base           (sysio_cp0_apb_base          )
);


//==========================================================
//                           ICG
//==========================================================
assign regs_clk_en = iui_regs_csr_write
                  || iui_regs_csr_en && mcpuid_local_en;
// &Instance("gated_clk_cell", "x_regs_clk"); @1215
gated_clk_cell  x_regs_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (regs_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (regs_clk_en       ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1216
//          .external_en (1'b0), @1217
//          .global_en   (cp0_yy_clk_en), @1218
//          .module_en   (regs_xx_icg_en), @1219
//          .local_en    (regs_clk_en), @1220
//          .clk_out     (regs_clk)); @1221

assign regs_flush_clk_en = rtu_cp0_exit_debug
                        || iui_regs_csr_wen
                        || iui_regs_inst_mret
                        || iui_regs_inst_sret
                        || rtu_yy_xx_expt_vld
                        || regs_mcor_busy
                        || regs_mcins_busy;
// &Instance("gated_clk_cell", "x_regs_flush_clk"); @1230
gated_clk_cell  x_regs_flush_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (regs_flush_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (regs_flush_clk_en ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @1231
//          .external_en (1'b0), @1232
//          .global_en   (cp0_yy_clk_en), @1233
//          .module_en   (regs_xx_icg_en), @1234
//          .local_en    (regs_flush_clk_en), @1235
//          .clk_out     (regs_flush_clk)); @1236

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign regs_iui_csr_inv           = regs_imm_inv;
assign regs_iui_rdata[63:0]       = regs_csr_rdata[63:0];
assign regs_iui_rdata_for_w[63:0] = regs_csr_rdata_for_w[63:0];

assign cp0_mmu_cur_asid[15:0]     = csrasid_value[15:0];
assign cp0_mmu_ptw_pgdh[63:0]     = csrpgdh_value[63:0];
assign cp0_mmu_ptw_pgdl[63:0]     = csrpgdl_value[63:0];

// &Force("output", "regs_xx_icg_en"); @1248
// &Force("output", "regs_clk"); @1249

// &ModuleEnd; @1251
endmodule



