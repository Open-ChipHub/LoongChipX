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


// &ModuleBeg; @25
module ct_cp0_iui (
  // &Ports, @26
  input    wire           biu_cp0_cmplt,
  input    wire  [127:0]  biu_cp0_rdata,
  input    wire  [2  :0]  biu_cp0_coreid,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire           hpcp_cp0_cmplt,
  input    wire  [63 :0]  hpcp_cp0_data,
  input    wire  [4  :0]  idu_cp0_rf_func,
  input    wire           idu_cp0_rf_gateclk_sel,
  input    wire  [6  :0]  idu_cp0_rf_iid,
  input    wire  [31 :0]  idu_cp0_rf_opcode,
  input    wire  [6  :0]  idu_cp0_rf_preg,
  input    wire           idu_cp0_rf_sel,
  input    wire  [63 :0]  idu_cp0_rf_src0,
  input    wire  [63 :0]  idu_cp0_rf_src1,
  input    wire           ifu_cp0_icache_inv_done,
  input    wire           ifu_cp0_rst_inv_req,
  input    wire           lpmd_cmplt,
  input    wire           lsu_cp0_dcache_done,
  input    wire           mmu_cp0_cmplt,
  input    wire           mmu_cp0_tlb_done,
  input    wire           pad_yy_icg_scan_en,
  input    wire           sysio_core_restart_vld,
  input    wire           core_sysio_restart_grnt,
  input    wire           sysio_core_cp0_update_ipi_status_en,
  input    wire  [31 :0]  sysio_core_cp0_update_ipi_status_src,
  input    wire           sysio_core_cp0_update_mailbox0_en,
  input    wire           sysio_core_cp0_update_mailbox1_en,
  input    wire           sysio_core_cp0_update_mailbox2_en,
  input    wire           sysio_core_cp0_update_mailbox3_en,
  input    wire           sysio_core_cp0_req_grnt,
  input    wire  [3  :0]  sysio_core_cp0_update_bit_sel,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_src0,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_src1,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_src2,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_src3,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_mask0,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_mask1,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_mask2,
  input    wire  [31 :0]  sysio_core_cp0_update_mailbox_mask3,
  input    wire           regs_iui_cfr_no_op,
  input    wire           regs_iui_chk_vld,
  input    wire           regs_iui_cindex_l2,
  input    wire           regs_iui_cins_no_op,
  input    wire           regs_iui_cskyee,
  input    wire  [63 :0]  regs_iui_data_out,
  input    wire  [63 :0]  regs_iui_iocsr_data_out,
  input    wire  [63 :0]  regs_iui_mailbox0_data,
  input    wire  [63 :0]  regs_iui_cfg_data_out,
  input    wire           regs_iui_dca_sel,
  input    wire           regs_iui_fs_off,
  input    wire           regs_iui_hpcp_regs_sel,
  input    wire           regs_iui_hpcp_scr_inv,
  input    wire  [14 :0]  regs_iui_int_sel,
  input    wire           regs_iui_l2_regs_sel,
  input    wire  [1  :0]  regs_iui_pm,
  input    wire  [3  :0]  regs_iui_reg_idx,
  input    wire           regs_iui_scnt_inv,
  input    wire           regs_iui_tee_ff,
  input    wire           regs_iui_tee_vld,
  input    wire           regs_iui_tsr,
  input    wire           regs_iui_tvm,
  input    wire           regs_iui_tw,
  input    wire           regs_iui_ucnt_inv,
  input    wire           regs_iui_v,
  input    wire           regs_iui_vs_off,
  input    wire  [2  :0]  regs_iui_ecfg_vs,
  input    wire  [63 :0]  regs_iui_wdata,
  input    wire           regs_xx_icg_en,
  input    wire           rtu_yy_xx_commit0,
  input    wire  [6  :0]  rtu_yy_xx_commit0_iid,
  input    wire           rtu_yy_xx_dbgon,
  input    wire           rtu_yy_xx_flush,
  output   wire  [15 :0]  cp0_biu_op,
  output   wire           cp0_biu_sel,
  output   wire  [63 :0]  cp0_biu_wdata,
  output   wire  [3  :0]  cp0_hpcp_op,
  output   wire           cp0_hpcp_sel,
  output   wire  [63 :0]  cp0_hpcp_src0,
  output   wire           cp0_ifu_rst_inv_done,
  output   wire           cp0_ifu_boot_stall,
  output   wire           cp0_iu_ex3_abnormal,
  output   wire  [4  :0]  cp0_iu_ex3_expt_vec,
  output   wire           cp0_iu_ex3_expt_vld,
  output   wire           cp0_iu_ex3_flush,
  output   wire  [6  :0]  cp0_iu_ex3_iid,
  output   wire           cp0_iu_ex3_inst_vld,
  output   wire  [31 :0]  cp0_iu_ex3_mtval,
  output   wire  [63 :0]  cp0_iu_ex3_rslt_data,
  output   wire  [6  :0]  cp0_iu_ex3_rslt_preg,
  output   wire  [4  :0]  cp0_iu_ex3_rslt_dreg,
  output   wire           cp0_iu_ex3_rslt_vld,
  output   wire           cp0_mmu_tlb_all_inv,
  output   wire           cp0_mret,
  output   wire           cp0_ertn,
  output   wire           cp0_cprs,
  output   wire           cp0_rtu_xx_int_b,
  output   wire  [12 :0]  cp0_rtu_xx_vec,
  output   wire           cp0_sret,
  output   wire           core_sysio_wr_req,
  output   wire  [3  :0]  core_sysio_wr_sel,
  output   wire  [31 :0]  core_sysio_wr_ipi_send_data,
  output   wire  [63 :0]  core_sysio_wr_mail_box_send_data,
  output   wire  [63 :0]  core_sysio_mailbox0_data,
  output   wire           inst_lpmd_ex1_ex2,
  output   wire  [11 :0]  iui_regs_addr,
  output   wire           iui_regs_csr_wr,
  output   wire           iui_regs_csrw,
  output   wire           iui_regs_ex3_inst_csr,
  output   wire           iui_regs_inst_mret,
  output   wire           iui_regs_inst_ertn,
  output   wire           iui_regs_inst_sret,
  output   wire           iui_regs_inv_expt,
  output   wire  [31 :0]  iui_regs_opcode,
  output   wire  [63 :0]  iui_regs_ori_src0,
  output   wire  [63 :0]  iui_regs_cpu_cfg_code,
  output   wire           iui_regs_rst_inv_d,
  output   wire           iui_regs_rst_inv_i,
  output   wire           iui_regs_sel,
  output   wire           iui_regs_sel_ipi,
  output   wire  [63 :0]  iui_regs_src0,
  output   wire  [63 :0]  iui_ipi_regs_src,
  output   wire  [15 :0]  iui_regs_iocsr_addr,
  output   wire           iui_update_ipi_status_en,
  output   wire  [31 :0]  iui_update_ipi_status_src,
  output   wire           iui_update_ipi_mailbox0_en,
  output   wire           iui_update_ipi_mailbox1_en,
  output   wire           iui_update_ipi_mailbox2_en,
  output   wire           iui_update_ipi_mailbox3_en,
  output   wire  [ 3 :0]  iui_update_ipi_mailbox_sel,
  output   wire  [31 :0]  iui_update_ipi_regs_src0,
  output   wire  [31 :0]  iui_update_ipi_regs_src1,
  output   wire  [31 :0]  iui_update_ipi_regs_src2,
  output   wire  [31 :0]  iui_update_ipi_regs_src3,
  output   wire  [31 :0]  iui_update_ipi_regs_mask0,
  output   wire  [31 :0]  iui_update_ipi_regs_mask1,
  output   wire  [31 :0]  iui_update_ipi_regs_mask2,
  output   wire  [31 :0]  iui_update_ipi_regs_mask3,
  output   wire  [1  :0]  iui_top_cur_state
); 



// &Regs; @27
reg              addr_inv;               
reg              cp0_expt_vld;           
reg              cp0_flush;              
reg     [63 :0]  cp0_rslt_reg;           
reg     [1  :0]  cur_state;              
reg              inst_csr_ex2;           
reg              inst_iocsr_ex2;           
reg     [6  :0]  iui_ex1_iid;            
reg              iui_ex1_inst_csrrc;     
reg              iui_ex1_inst_csrrci;    
reg              iui_ex1_inst_csrrs;     
reg              iui_ex1_inst_csrrsi;    
reg              iui_ex1_inst_csrrw;     
reg              iui_ex1_inst_csrrd;     
reg              iui_ex1_inst_csrwr;     
reg              iui_ex1_inst_movgr2fcsr_wr;     
reg              iui_ex1_inst_movfcsr2gr_rd;     
reg              iui_ex1_inst_csrxchg;     
reg              iui_ex1_inst_csrrwi;    
reg              iui_ex1_inst_mret;      
reg              iui_ex1_inst_ertn;      
reg              iui_ex1_inst_sret;      
reg              iui_ex1_inst_wfi;       
reg              iui_ex1_inst_idle;       
reg              iui_ex1_inst_cprs;       
reg              iui_ex1_inst_cpucfg;       
reg              iui_ex1_inst_iocsrrd;       
reg              iui_ex1_inst_iocsrwr;       
reg              iui_ex1_inst_tlbop;       
reg     [31 :0]  iui_ex1_opcode;         
reg     [6  :0]  iui_ex1_preg;           
reg     [63 :0]  iui_ex1_src0;           
reg     [63 :0]  iui_ex1_src1;           
reg              iui_flop_commit;        
reg     [12 :0]  iui_int_vec;            
reg              iui_int_vld_b;          
reg     [1  :0]  next_state;             
reg              rst_cache_inv;          
reg              rst_cache_inv_nxt;      
reg              rst_dcache_inv;         
reg              rst_dcache_inv_nxt;     
reg              rst_icache_inv;         
reg              rst_icache_inv_nxt;     
reg              rst_tlb_inv;            
reg              rst_tlb_inv_nxt;                

// &Wires; @28
wire             cp0_ex1_select;         
wire             cp0_ex2_expt_vld;       
wire             cp0_ex2_select;         
wire             cp0_ex3_select;         
wire             cp0_inst_cmplt;         
wire             cp0_select;             
wire             cpuclk;                 
wire             csr_addr_inv;           
wire    [63 :0]  csrrc_src0;             
wire    [63 :0]  csrrci_src0;            
wire    [63 :0]  csrrs_src0;             
wire    [63 :0]  csrrsi_src0;            
wire    [63 :0]  csrrw_src0;             
wire    [63 :0]  csrrwi_src0;            
wire    [63 :0]  csrwr_src0;            
wire    [63 :0]  csrxchg_src0;            
wire             inst_csr_ex1;           
wire             inst_cpucfg_ex1;           
wire             inst_iocsrrd_ex1;           
wire             inst_iocsrwr_ex1;           
wire             inst_iocsr_ex1;           
wire             inst_csr_wr;            
wire             inst_lpmd;              
wire             inst_tlbop_ex2;           
wire             inst_mret_ex2;          
wire             inst_ertn_ex2;          
wire             inst_sret_ex2;          
wire             int_vld;                
wire    [11 :0]  iui_addr;               
wire    [11 :0]  mvfcsr_addr;               
wire    [1  :0]  fcsr_addr;               
wire             iui_clk_en;             
wire             iui_csr_hpcp;           
wire             iui_csr_inst_imm;       
wire             iui_csr_l2regs;         
wire             iui_csr_mcir;           
wire             iui_ex2_commit;         
wire             iui_flush;              
wire             iui_fs_inv;             
wire             iui_hs_inv;             
wire             iui_inst_csr;           
wire             iui_inst_csrrc;         
wire             iui_inst_csrrci;        
wire             iui_inst_csrrs;         
wire             iui_inst_csrrsi;        
wire             iui_inst_csrrw;         
wire             iui_inst_csrrd;         
wire             iui_inst_csrwr;         
wire             iui_inst_movgr2fcsr_wr;         
wire             iui_inst_movfcsr2gr_rd;         
wire             iui_inst_csrxchg;         
wire             iui_inst_csrrwi;        
wire             iui_inst_mret;          
wire             iui_inst_ertn;          
wire             iui_inst_idle;          
wire             iui_inst_cprs;          
wire             iui_inst_cpucfg;          
wire             iui_inst_iocsrrd;          
wire             iui_inst_iocsrwr;          
wire             iui_inst_tlbop;          
wire             iui_inst_ro;            
wire             iui_inst_sret;          
wire             iui_inst_wfi;           
wire             iui_m_mode;             
wire    [31 :0]  iui_opcode;             
wire    [6  :0]  iui_preg;               
wire             iui_privilege;          
wire             iui_s_inv;              
wire             iui_s_mode;             
wire    [63 :0]  iui_src0;               
wire    [63 :0]  iui_src1;               
wire    [15 :0]  iui_iocsr_addr;               
wire    [ 1 :0]  iui_iocsr_width;               
wire    [63 :0]  regs_iui_iocsr_data_ext;
wire             iui_tee_inv;            
wire             iui_u_inv;              
wire             iui_cfg_inv;              
wire             iui_u_mode;             
wire    [63 :0]  iui_uimm;               
wire             iui_v_mode;             
wire             iui_vs_inv;             
wire             iui_w_inv;              
wire             rf_inst_csrrc;          
wire             rf_inst_csrrci;         
wire             rf_inst_csrrs;          
wire             rf_inst_csrrsi;         
wire             rf_inst_csrrw;          
wire             rf_inst_csrrd;          
wire             rf_inst_csrwr;          
wire             rf_inst_movgr2fcsr_wr;          
wire             rf_inst_movfcsr2gr_rd;          
wire             rf_inst_csrxchg;          
wire             rf_inst_csrrwi;         
wire             rf_inst_mret;           
wire             rf_inst_sret;           
wire             rf_inst_ertn;           
wire             rf_inst_wfi;            
wire             rf_inst_idle;            
wire             rf_inst_cprs;            
wire             rf_inst_cpucfg;            
wire             rf_inst_iocsrrd;            
wire             rf_inst_iocsrwr;            
wire             rst_inv_done;           
wire    [12 :0]  valid_int_vec;  


parameter IDLE     = 2'b00;
parameter EX1      = 2'b01;
parameter EX2      = 2'b10;
parameter EX3      = 2'b11;

parameter RST_IDLE = 1'b0;
parameter RST_WFC  = 1'b1;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign iui_clk_en = idu_cp0_rf_gateclk_sel 
                 || (cur_state[1:0] == EX1) 
                 || (cur_state[1:0] == EX2)
                 || (cur_state[1:0] == EX3) 
                 || inst_csr_ex2
                 || rtu_yy_xx_flush && (cp0_expt_vld || cp0_flush 
                                     || cur_state[1:0] != IDLE)
                 || ifu_cp0_rst_inv_req 
                 || ifu_cp0_icache_inv_done
                 || lsu_cp0_dcache_done
                 || mmu_cp0_tlb_done
                 || rst_cache_inv != RST_IDLE && rst_inv_done
                 || int_vld || !iui_int_vld_b;

// &Instance("gated_clk_cell", "x_iui_gated_clk"); @55
gated_clk_cell  x_iui_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (cpuclk            ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (iui_clk_en        ),
  .module_en          (regs_xx_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @56
//          .external_en (1'b0), @57
//          .global_en   (cp0_yy_clk_en), @58
//          .module_en   (regs_xx_icg_en), @59
//          .local_en    (iui_clk_en), @60
//          .clk_out     (cpuclk)); @61

//==========================================================
//                Define the CSR ADDR
// 1. Machine Level CSRs
// 2. Supervisor Level CSRs
// 3. User Level CSRs
// 4. C-SKY Extension CSRs
//==========================================================

// Machine Information Registers
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
// 3. User Level CSRs
// User Floating-Point CSRs
parameter FFLAGS    = 12'h101;
parameter FRM       = 12'h102;
parameter FCSR      = 12'h103;
parameter VSTART    = 12'h108;
parameter VXSAT     = 12'h109;
parameter VXRM      = 12'h10A;


parameter VL       = 12'hC20;
parameter VTYPE    = 12'hC21;
parameter VLENB    = 12'hC22;

// 4. C-SKY Extension CSRs
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

// Processor Data Extension; M-Mode
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

// Supervisor Counters/Timers
parameter SCYCLE    = 12'h5E0;
parameter SINSTRET  = 12'h5E2;
parameter SHPMCNT3  = 12'h5E3;
parameter SHPMCNT4  = 12'h5E4;
parameter SHPMCNT5  = 12'h5E5;
parameter SHPMCNT6  = 12'h5E6;
parameter SHPMCNT7  = 12'h5E7;
parameter SHPMCNT8  = 12'h5E8;
parameter SHPMCNT9  = 12'h5E9;
parameter SHPMCNT10 = 12'h5EA;
parameter SHPMCNT11 = 12'h5EB;
parameter SHPMCNT12 = 12'h5EC;
parameter SHPMCNT13 = 12'h5ED;
parameter SHPMCNT14 = 12'h5EE;
parameter SHPMCNT15 = 12'h5EF;
parameter SHPMCNT16 = 12'h5F0;
parameter SHPMCNT17 = 12'h5F1;
parameter SHPMCNT18 = 12'h5F2;
parameter SHPMCNT19 = 12'h5F3;
parameter SHPMCNT20 = 12'h5F4;
parameter SHPMCNT21 = 12'h5F5;
parameter SHPMCNT22 = 12'h5F6;
parameter SHPMCNT23 = 12'h5F7;
parameter SHPMCNT24 = 12'h5F8;
parameter SHPMCNT25 = 12'h5F9;
parameter SHPMCNT26 = 12'h5FA;
parameter SHPMCNT27 = 12'h5FB;
parameter SHPMCNT28 = 12'h5FC;
parameter SHPMCNT29 = 12'h5FD;
parameter SHPMCNT30 = 12'h5FE;
parameter SHPMCNT31 = 12'h5FF;

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
//                Handling the CP0 operations
//==========================================================
//CP0 need to flop insctuction type signals and source operands
//for use of both ex1 and ex2 stages
// CP0 funcs from idu rf stage
// WFI:    5'b01001
// SRET:   5'b01000
// MRET:   5'b01010
// CSRRW:  5'b10000
// CSRRS:  5'b10001
// CSRRC:  5'b10010
// CSRRWI: 5'b10011
// CSRRSI: 5'b10100
// CSRRCI: 5'b10101

// assign rf_inst_wfi    = idu_cp0_rf_func[3] &&  idu_cp0_rf_func[0];
// assign rf_inst_sret   = idu_cp0_rf_func[3] && !idu_cp0_rf_func[1] && !idu_cp0_rf_func[0];
// assign rf_inst_mret   = idu_cp0_rf_func[3] &&  idu_cp0_rf_func[1];
// assign rf_inst_csrrw  = idu_cp0_rf_func[4] &&  idu_cp0_rf_func[2:0] == 3'b000;
// assign rf_inst_csrrs  = idu_cp0_rf_func[4] &&  idu_cp0_rf_func[2:0] == 3'b001;
// assign rf_inst_csrrc  = idu_cp0_rf_func[4] &&  idu_cp0_rf_func[2:0] == 3'b010;
// assign rf_inst_csrrwi = idu_cp0_rf_func[4] &&  idu_cp0_rf_func[2:0] == 3'b011;
// assign rf_inst_csrrsi = idu_cp0_rf_func[4] &&  idu_cp0_rf_func[2:0] == 3'b100;
// assign rf_inst_csrrci = idu_cp0_rf_func[4] &&  idu_cp0_rf_func[2:0] == 3'b101;

assign rf_inst_wfi    = 1'b0;
assign rf_inst_sret   = 1'b0;
assign rf_inst_mret   = 1'b0;
assign rf_inst_csrrw  = 1'b0;
assign rf_inst_csrrs  = 1'b0;
assign rf_inst_csrrc  = 1'b0;
assign rf_inst_csrrwi = 1'b0;
assign rf_inst_csrrsi = 1'b0;
assign rf_inst_csrrci = 1'b0;


wire [31:0] cp0_inst_opcode = idu_cp0_rf_opcode[31:0];

assign rf_inst_csrwr    = ({cp0_inst_opcode[31:24], cp0_inst_opcode[9:5]} == 13'b00000100_00001); //csrwr
assign rf_inst_csrrd    = ({cp0_inst_opcode[31:24], cp0_inst_opcode[9:5]} == 13'b00000100_00000); //csrrd

assign rf_inst_movgr2fcsr_wr  = (cp0_inst_opcode[31:10] == 22'b0000000100010100110000); // movgr2fcsr  
assign rf_inst_movfcsr2gr_rd  = (cp0_inst_opcode[31:10] == 22'b0000000100010100110010); // movfcsr2gr

assign rf_inst_csrxchg  = ({cp0_inst_opcode[31:24]} == 8'b00000100) 
                            && (cp0_inst_opcode[9:5] != 5'b00000)
                            && (cp0_inst_opcode[9:5] != 5'b00001);

assign rf_inst_ertn     = (cp0_inst_opcode[31: 0] == 32'b00000110010010000011100000000000); // ertn
assign rf_inst_idle     = (cp0_inst_opcode[31:15] == 17'b00000110010010001); // idle
assign rf_inst_cprs     = (cp0_inst_opcode[31:15] == 17'b00000110010010010); // cprs

assign rf_inst_cpucfg   = (cp0_inst_opcode[31:10] == 22'b00000000000000000_11011);

assign rf_inst_iocsrrd  = (cp0_inst_opcode[31:12] == 20'b00000110010010000_000);
assign rf_inst_iocsrwr  = (cp0_inst_opcode[31:12] == 20'b00000110010010000_001);

assign rf_inst_tlbop    = (cp0_inst_opcode[31:10] == 22'b00000110010010000_01000) ||  // tlbclr
                          (cp0_inst_opcode[31:10] == 22'b00000110010010000_01001) ||  // tlbflush
                          (cp0_inst_opcode[31:10] == 22'b00000110010010000_01010) ||  // tlbsrch
                          (cp0_inst_opcode[31:10] == 22'b00000110010010000_01011) ||  // tlbrd
                          (cp0_inst_opcode[31:10] == 22'b00000110010010000_01100) ||  // tlbwr
                          (cp0_inst_opcode[31:10] == 22'b00000110010010000_01101);    // tlbfill


always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    iui_ex1_inst_wfi      <= 1'b0; 
    iui_ex1_inst_sret     <= 1'b0; 
    iui_ex1_inst_mret     <= 1'b0; 
    iui_ex1_inst_csrrw    <= 1'b0; 
    iui_ex1_inst_csrrs    <= 1'b0; 
    iui_ex1_inst_csrrc    <= 1'b0; 
    iui_ex1_inst_csrrwi   <= 1'b0; 
    iui_ex1_inst_csrrsi   <= 1'b0; 
    iui_ex1_inst_csrrci   <= 1'b0; 

    iui_ex1_inst_csrrd    <= 1'b0;
    iui_ex1_inst_csrwr    <= 1'b0;
    iui_ex1_inst_movgr2fcsr_wr    <= 1'b0;
    iui_ex1_inst_movfcsr2gr_rd    <= 1'b0;
    iui_ex1_inst_csrxchg  <= 1'b0;
    iui_ex1_inst_ertn     <= 1'b0;
    iui_ex1_inst_idle     <= 1'b0;
    iui_ex1_inst_cprs     <= 1'b0;
    iui_ex1_inst_cpucfg   <= 1'b0;
    iui_ex1_inst_iocsrrd  <= 1'b0;
    iui_ex1_inst_iocsrwr  <= 1'b0;
    iui_ex1_inst_tlbop    <= 1'b0;

    iui_ex1_iid[6:0]      <= 7'b0; 
    iui_ex1_opcode[31:0]  <= 32'b0; 
    iui_ex1_src0[63:0]    <= 64'b0;
    iui_ex1_src1[63:0]    <= 64'b0;
    iui_ex1_preg[6:0]     <= 7'b0; 
  end
  else if(idu_cp0_rf_gateclk_sel) begin
    iui_ex1_inst_wfi      <= rf_inst_wfi; 
    iui_ex1_inst_sret     <= rf_inst_sret; 
    iui_ex1_inst_mret     <= rf_inst_mret; 
    iui_ex1_inst_csrrw    <= rf_inst_csrrw; 
    iui_ex1_inst_csrrs    <= rf_inst_csrrs; 
    iui_ex1_inst_csrrc    <= rf_inst_csrrc; 
    iui_ex1_inst_csrrwi   <= rf_inst_csrrwi; 
    iui_ex1_inst_csrrsi   <= rf_inst_csrrsi; 
    iui_ex1_inst_csrrci   <= rf_inst_csrrci; 

    iui_ex1_inst_csrrd    <= rf_inst_csrrd;
    iui_ex1_inst_csrwr    <= rf_inst_csrwr;
    iui_ex1_inst_movgr2fcsr_wr    <= rf_inst_movgr2fcsr_wr;
    iui_ex1_inst_movfcsr2gr_rd    <= rf_inst_movfcsr2gr_rd;
    iui_ex1_inst_csrxchg  <= rf_inst_csrxchg;
    iui_ex1_inst_ertn     <= rf_inst_ertn;
    iui_ex1_inst_idle     <= rf_inst_idle;
    iui_ex1_inst_cprs     <= rf_inst_cprs;
    iui_ex1_inst_cpucfg   <= rf_inst_cpucfg;
    iui_ex1_inst_iocsrrd  <= rf_inst_iocsrrd;
    iui_ex1_inst_iocsrwr  <= rf_inst_iocsrwr;
    iui_ex1_inst_tlbop    <= rf_inst_tlbop;

    iui_ex1_iid[6:0]      <= idu_cp0_rf_iid[6:0]; 
    iui_ex1_opcode[31:0]  <= idu_cp0_rf_opcode[31:0]; 
    iui_ex1_src0[63:0]    <= idu_cp0_rf_src0[63:0];
    iui_ex1_src1[63:0]    <= idu_cp0_rf_src1[63:0];
    iui_ex1_preg[6:0]     <= idu_cp0_rf_preg[6:0]; 
  end
  else begin
    iui_ex1_inst_wfi      <= iui_ex1_inst_wfi; 
    iui_ex1_inst_sret     <= iui_ex1_inst_sret; 
    iui_ex1_inst_mret     <= iui_ex1_inst_mret; 
    iui_ex1_inst_csrrw    <= iui_ex1_inst_csrrw; 
    iui_ex1_inst_csrrs    <= iui_ex1_inst_csrrs; 
    iui_ex1_inst_csrrc    <= iui_ex1_inst_csrrc; 
    iui_ex1_inst_csrrwi   <= iui_ex1_inst_csrrwi; 
    iui_ex1_inst_csrrsi   <= iui_ex1_inst_csrrsi; 
    iui_ex1_inst_csrrci   <= iui_ex1_inst_csrrci; 

    iui_ex1_inst_csrrd    <= iui_ex1_inst_csrrd;
    iui_ex1_inst_csrwr    <= iui_ex1_inst_csrwr;
    iui_ex1_inst_movgr2fcsr_wr    <= iui_ex1_inst_movgr2fcsr_wr;
    iui_ex1_inst_movfcsr2gr_rd    <= iui_ex1_inst_movfcsr2gr_rd;
    iui_ex1_inst_csrxchg  <= iui_ex1_inst_csrxchg;
    iui_ex1_inst_ertn     <= iui_ex1_inst_ertn;
    iui_ex1_inst_idle     <= iui_ex1_inst_idle;
    iui_ex1_inst_cprs     <= iui_ex1_inst_cprs;
    iui_ex1_inst_cpucfg   <= iui_ex1_inst_cpucfg;
    iui_ex1_inst_iocsrrd  <= iui_ex1_inst_iocsrrd;
    iui_ex1_inst_iocsrwr  <= iui_ex1_inst_iocsrwr;
    iui_ex1_inst_tlbop    <= iui_ex1_inst_tlbop;

    iui_ex1_iid[6:0]      <= iui_ex1_iid[6:0]; 
    iui_ex1_opcode[31:0]  <= iui_ex1_opcode[31:0]; 
    iui_ex1_src0[63:0]    <= iui_ex1_src0[63:0];
    iui_ex1_src1[63:0]    <= iui_ex1_src1[63:0];
    iui_ex1_preg[6:0]     <= iui_ex1_preg[6:0]; 
  end
end

// RISCV64
assign iui_inst_wfi     = iui_ex1_inst_wfi; 
assign iui_inst_sret    = iui_ex1_inst_sret; 
assign iui_inst_mret    = iui_ex1_inst_mret; 
assign iui_inst_csrrw   = iui_ex1_inst_csrrw; 
assign iui_inst_csrrs   = iui_ex1_inst_csrrs; 
assign iui_inst_csrrc   = iui_ex1_inst_csrrc; 
assign iui_inst_csrrwi  = iui_ex1_inst_csrrwi; 
assign iui_inst_csrrsi  = iui_ex1_inst_csrrsi; 
assign iui_inst_csrrci  = iui_ex1_inst_csrrci; 

// LoongArch64
assign iui_inst_csrrd   = iui_ex1_inst_csrrd;
assign iui_inst_csrwr   = iui_ex1_inst_csrwr;
assign iui_inst_movgr2fcsr_wr   = iui_ex1_inst_movgr2fcsr_wr;
assign iui_inst_movfcsr2gr_rd   = iui_ex1_inst_movfcsr2gr_rd;
assign iui_inst_csrxchg = iui_ex1_inst_csrxchg;
assign iui_inst_ertn    = iui_ex1_inst_ertn;
assign iui_inst_idle    = iui_ex1_inst_idle;
assign iui_inst_cprs    = iui_ex1_inst_cprs;
assign iui_inst_cpucfg  = iui_ex1_inst_cpucfg;

assign iui_inst_iocsrrd  = iui_ex1_inst_iocsrrd;
assign iui_inst_iocsrwr  = iui_ex1_inst_iocsrwr;
assign iui_inst_tlbop    = iui_ex1_inst_tlbop;

assign iui_opcode[31:0] = iui_ex1_opcode[31:0]; 
assign iui_preg[6:0]    = iui_ex1_preg[6:0]; 
assign iui_src0[63:0]   = iui_ex1_src0[63:0];
assign iui_src1[63:0]   = iui_ex1_src1[63:0];
// assign iui_addr[11:0]   = iui_ex1_opcode[31:20];

assign iui_iocsr_addr[15:0]  = iui_ex1_src0[15:0];
assign iui_iocsr_width[1:0]  = iui_ex1_opcode[11:10];


assign fcsr_addr[1:0]   =   {2{iui_ex1_inst_movgr2fcsr_wr}} &  iui_ex1_opcode[1:0] 
                          | {2{iui_ex1_inst_movfcsr2gr_rd}} &  iui_ex1_opcode[6:5];

assign mvfcsr_addr[11:0] = {8'hf0, 2'b00, fcsr_addr[1:0]};

assign iui_addr[11:0]   = (iui_ex1_inst_movgr2fcsr_wr || iui_ex1_inst_movfcsr2gr_rd) ?
                          mvfcsr_addr[11:0] : iui_ex1_opcode[21:10];

assign iui_uimm[63:0]   = {59'b0, iui_ex1_opcode[19:15]};

assign iui_inst_csr     = iui_inst_csrrd || 
                          iui_inst_csrwr || 
                          iui_inst_csrxchg ||
                          iui_inst_movfcsr2gr_rd ||
                          iui_inst_movgr2fcsr_wr;

assign iui_inst_ro      = iui_inst_csrrd ||
                          iui_inst_movfcsr2gr_rd ||  
                          (iui_inst_csrxchg && iui_src0[63:0]==64'b0);

//==========================================================
//                Qualify CSR Addr
//==========================================================
// &CombBeg; @442
always @( iui_addr[11:0])
begin
  addr_inv = 1'b1; 
  casez(iui_addr[11:0])
    ARCH      : addr_inv = 1'b0;
    CRMD      : addr_inv = 1'b0;
    PRMD      : addr_inv = 1'b0;
    EUEN      : addr_inv = 1'b0;
    MISC      : addr_inv = 1'b0;
    ECFG      : addr_inv = 1'b0;
    ESTAT     : addr_inv = 1'b0;
    ERA       : addr_inv = 1'b0;
    BADV      : addr_inv = 1'b0;
    BADI      : addr_inv = 1'b0;
    EENTRY    : addr_inv = 1'b0;
    TLBIDX    : addr_inv = 1'b0;
    TLBEHI    : addr_inv = 1'b0;
    TLBELO0   : addr_inv = 1'b0;
    TLBELO1   : addr_inv = 1'b0;
    ASID      : addr_inv = 1'b0;
    PGDL      : addr_inv = 1'b0;
    PGDH      : addr_inv = 1'b0;
    PGD       : addr_inv = 1'b0;
    PWCL      : addr_inv = 1'b0;
    PWCH      : addr_inv = 1'b0;
    STLBPS    : addr_inv = 1'b0;
    RVACFG    : addr_inv = 1'b0;
    CPUID     : addr_inv = 1'b0;
    PRCFG1    : addr_inv = 1'b0;
    PRCFG2    : addr_inv = 1'b0;
    PRCFG3    : addr_inv = 1'b0;

    SAVE0     : addr_inv = 1'b0;
    SAVE1     : addr_inv = 1'b0;
    SAVE2     : addr_inv = 1'b0;
    SAVE3     : addr_inv = 1'b0;
    TID       : addr_inv = 1'b0;
    TCFG      : addr_inv = 1'b0;
    TVAL      : addr_inv = 1'b0;
    CNTC      : addr_inv = 1'b0;
    TICLR     : addr_inv = 1'b0;
    LLBCTL    : addr_inv = 1'b0;
    IMPCTL1   : addr_inv = 1'b0;
    IMPCTL2   : addr_inv = 1'b0;
    TLBRENTRY : addr_inv = 1'b0;
    TLBREHI   : addr_inv = 1'b0;
    MERRENTRY : addr_inv = 1'b0;
    DMW0      : addr_inv = 1'b0;
    DMW1      : addr_inv = 1'b0;
    DMW2      : addr_inv = 1'b0;
    DMW3      : addr_inv = 1'b0;
    BRK       : addr_inv = 1'b0;
    DIS_CACHE : addr_inv = 1'b0;

    DEBUG0    : addr_inv = 1'b0;
    DEBUG1    : addr_inv = 1'b0;
    DGWDUMP   : addr_inv = 1'b0;
    CPRS      : addr_inv = 1'b0;
    CPRS_CRMD : addr_inv = 1'b0;
    CPRS_TCFG : addr_inv = 1'b0;

    DEBUG2    : addr_inv = 1'b0;
    DEBUG3    : addr_inv = 1'b0;
    DEBUG4    : addr_inv = 1'b0;
    DEBUG5    : addr_inv = 1'b0;
    DEBUG6    : addr_inv = 1'b0;
    DEBUG7    : addr_inv = 1'b0;

    // PMU 
    PERFCTRL0 : addr_inv = 1'b0;
    PERFCNTR0 : addr_inv = 1'b0;
    PERFCTRL1 : addr_inv = 1'b0;
    PERFCNTR1 : addr_inv = 1'b0;
    PERFCTRL2 : addr_inv = 1'b0;
    PERFCNTR2 : addr_inv = 1'b0;
    PERFCTRL3 : addr_inv = 1'b0;
    PERFCNTR3 : addr_inv = 1'b0;
    PERFCTRL4 : addr_inv = 1'b0;
    PERFCNTR4 : addr_inv = 1'b0;
    PERFCTRL5 : addr_inv = 1'b0;
    PERFCNTR5 : addr_inv = 1'b0;
    PERFCTRL6 : addr_inv = 1'b0;
    PERFCNTR6 : addr_inv = 1'b0;

    MWPC      : addr_inv = 1'b0;
    MWPS      : addr_inv = 1'b0;
    FWPC      : addr_inv = 1'b0;
    FWPS      : addr_inv = 1'b0;

    IFUC      : addr_inv = 1'b0;
    CACC      : addr_inv = 1'b0;
    MSCC      : addr_inv = 1'b0;

    // FPU
    FCSR0     : addr_inv = 1'b0;
    FCSR1     : addr_inv = 1'b0;
    FCSR2     : addr_inv = 1'b0;
    FCSR3     : addr_inv = 1'b0;


    /// Extension CSRs
    MXSTATUS  : addr_inv = 1'b0;
    MHCR      : addr_inv = 1'b0;
    MCOR      : addr_inv = 1'b0;
    MCCR2     : addr_inv = 1'b0;
    MCER2     : addr_inv = 1'b0;
    MHINT     : addr_inv = 1'b0;
    MRVBR     : addr_inv = 1'b0;
    MCER      : addr_inv = 1'b0;
    MCNTWEN   : addr_inv = 1'b0;
    MCNTINTEN : addr_inv = 1'b0;
    MCNTOF    : addr_inv = 1'b0;
    MHINT2    : addr_inv = 1'b0;
    MHINT3    : addr_inv = 1'b0;
    MHINT4    : addr_inv = 1'b0;

    MSMPR     : addr_inv = 1'b0;


    MCINS     : addr_inv = 1'b0;
    MCINDEX   : addr_inv = 1'b0;
    MCDATA0   : addr_inv = 1'b0;
    MCDATA1   : addr_inv = 1'b0;
    MEICR     : addr_inv = 1'b0;
    MEICR2    : addr_inv = 1'b0;

    MCPUID    : addr_inv = 1'b0;
    MAPBADDR  : addr_inv = 1'b0;


    SXSTATUS  : addr_inv = 1'b0;
    SHCR      : addr_inv = 1'b0;
    SCER2     : addr_inv = 1'b0;
    SCER      : addr_inv = 1'b0;
    SCNTINTEN : addr_inv = 1'b0;
    SCNTOF    : addr_inv = 1'b0;
    SHINT     : addr_inv = 1'b0;
    SHINT2    : addr_inv = 1'b0;
          
    SCNTIHBT  : addr_inv = 1'b0;
    SHPMCR    : addr_inv = 1'b0;
    SHPMSP    : addr_inv = 1'b0;
    SHPMEP    : addr_inv = 1'b0;

    SMIR      : addr_inv = 1'b0;
    SMEL      : addr_inv = 1'b0;
    SMEH      : addr_inv = 1'b0;
    SMCIR     : addr_inv = 1'b0;

    FXCR      : addr_inv = 1'b0;

    default   : addr_inv = 1'b1; 
  endcase
// &CombEnd; @728
end
assign csr_addr_inv = iui_inst_csr && addr_inv;

//==========================================================
//              Commit signal to select cp0
//==========================================================
assign iui_ex2_commit = rtu_yy_xx_commit0
                        && (rtu_yy_xx_commit0_iid[6:0]
                            == iui_ex1_iid[6:0]);

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iui_flop_commit <= 1'b0; 
  else if(cur_state[1:0] == EX2)
    iui_flop_commit <= iui_ex2_commit;
  else
    iui_flop_commit <= iui_flop_commit;
end

//==========================================================
//              FSM of CP0 iui control logic
//==========================================================
// State Description:
// IDLE : wait for cp0 insctuction
// EX1  : first cycle in which write value to psr and regs
// EX2  : wait for biu align or no operation (if possible)
//        complete cp0 insctuction
// EX3  : request cbus/rbus

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cur_state[1:0] <= IDLE;
  else if(rtu_yy_xx_flush)
    cur_state[1:0] <= IDLE;
  else
    cur_state[1:0] <= next_state[1:0];
end

// &CombBeg; @768
always @( cur_state[1:0]
       or idu_cp0_rf_sel
       or cp0_inst_cmplt)
begin
  case(cur_state[1:0])
  IDLE  : if(idu_cp0_rf_sel)
            next_state[1:0] = EX1;
          else
            next_state[1:0] = IDLE;
  EX1   :   next_state[1:0] = EX2;
  EX2   : if(cp0_inst_cmplt)
            next_state[1:0] = EX3;
          else
            next_state[1:0] = EX2;
  EX3   :   next_state[1:0] = IDLE;
  default : next_state[1:0] = IDLE;
  endcase
// &CombEnd; @782
end

//-------------------control signal by iui FSM-------------
//EX1 stage select
assign cp0_ex1_select = (cur_state[1:0] == EX1);// && iui_ex1_commit;
//EX2 stage select
assign cp0_ex2_select = (cur_state[1:0] == EX2) && iui_ex2_commit;
//EX3 stage select
assign cp0_ex3_select = (cur_state[1:0] == EX3);

assign iui_top_cur_state[1:0] = cur_state[1:0];
//cp0 select
// //&Force ("output", "cp0_select"); @794
assign cp0_select     = cp0_ex1_select
                     || cp0_ex2_select
                     || cp0_ex3_select && iui_flop_commit;
//cp0 rbus request:only request rbus when current instruction can
//                 be completed in EX2  state.
assign cp0_iu_ex3_inst_vld = cp0_ex3_select;
//complete signal to idu: release barriered insctuction
//assign iui_ex_cmplt        = cp0_ex3_select;

//==========================================================
//              FSM of reset cache inv cctl logic
//==========================================================
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
      rst_cache_inv <= RST_IDLE;
  else
      rst_cache_inv <= rst_cache_inv_nxt;
end

// &CombBeg; @815
always @( rst_cache_inv
       or rst_inv_done
       or ifu_cp0_rst_inv_req)
begin
case(rst_cache_inv)
  RST_IDLE:
  begin
    if(ifu_cp0_rst_inv_req)
      rst_cache_inv_nxt = RST_WFC;
    else
      rst_cache_inv_nxt = RST_IDLE;
  end
  RST_WFC:
  begin
    if(rst_inv_done)
      rst_cache_inv_nxt = RST_IDLE;
    else
      rst_cache_inv_nxt = RST_WFC;
  end
  default:
  begin
    rst_cache_inv_nxt = RST_IDLE;
  end
endcase
// &CombEnd; @836
end

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    rst_icache_inv <= RST_IDLE;
  else
    rst_icache_inv <= rst_icache_inv_nxt;
end

// &CombBeg; @846
always @( rst_icache_inv
       or ifu_cp0_icache_inv_done
       or ifu_cp0_rst_inv_req)
begin
case(rst_icache_inv)
  RST_IDLE:
  begin
    if(ifu_cp0_rst_inv_req)
      rst_icache_inv_nxt = RST_WFC;
    else
      rst_icache_inv_nxt = RST_IDLE;
  end
  RST_WFC:
  begin
    if(ifu_cp0_icache_inv_done)
      rst_icache_inv_nxt = RST_IDLE;
    else
      rst_icache_inv_nxt = RST_WFC;
  end
  default:
  begin
    rst_icache_inv_nxt = RST_IDLE;
  end
endcase
// &CombEnd; @867
end

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    rst_dcache_inv <= RST_IDLE;
  else
    rst_dcache_inv <= rst_dcache_inv_nxt;
end

// &CombBeg; @877
always @( rst_dcache_inv
       or ifu_cp0_rst_inv_req
       or lsu_cp0_dcache_done)
begin
case(rst_dcache_inv)
  RST_IDLE:
  begin
    if(ifu_cp0_rst_inv_req)
      rst_dcache_inv_nxt = RST_WFC;
    else
      rst_dcache_inv_nxt = RST_IDLE;
  end
  RST_WFC:
  begin
    if(lsu_cp0_dcache_done)
      rst_dcache_inv_nxt = RST_IDLE;
    else
      rst_dcache_inv_nxt = RST_WFC;
  end
  default:
  begin
    rst_dcache_inv_nxt = RST_IDLE;
  end
endcase
// &CombEnd; @898
end

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    rst_tlb_inv <= RST_IDLE;
  else
    rst_tlb_inv <= rst_tlb_inv_nxt;
end

// &CombBeg; @908
always @( rst_tlb_inv
       or ifu_cp0_rst_inv_req
       or mmu_cp0_tlb_done)
begin
case(rst_tlb_inv)
  RST_IDLE:
  begin
    if(ifu_cp0_rst_inv_req)
      rst_tlb_inv_nxt = RST_WFC;
    else
      rst_tlb_inv_nxt = RST_IDLE;
  end
  RST_WFC:
  begin
    if(mmu_cp0_tlb_done)
      rst_tlb_inv_nxt = RST_IDLE;
    else
      rst_tlb_inv_nxt = RST_WFC;
  end
  default:
  begin
    rst_tlb_inv_nxt = RST_IDLE;
  end
endcase
// &CombEnd; @929
end

assign rst_inv_done = rst_icache_inv == RST_IDLE && rst_dcache_inv == RST_IDLE
                   && rst_tlb_inv == RST_IDLE;
assign iui_regs_rst_inv_i = rst_icache_inv == RST_WFC 
                         && !ifu_cp0_icache_inv_done;
assign iui_regs_rst_inv_d = rst_dcache_inv == RST_WFC;
assign cp0_mmu_tlb_all_inv = rst_tlb_inv == RST_IDLE && ifu_cp0_rst_inv_req;
assign cp0_ifu_rst_inv_done = rst_cache_inv == RST_WFC && rst_inv_done;

//==========================================================
//                Qualify CP0 insctuctions
//==========================================================
assign iui_m_mode = regs_iui_pm[1:0] == 2'b00;
assign iui_s_mode = regs_iui_pm[1:0] == 2'b01;
assign iui_u_mode = regs_iui_pm[1:0] == 2'b11;
assign iui_v_mode = regs_iui_v       == 1'b1;

// vs-mode access hs-mode csr or inst
assign iui_hs_inv = 1'b0;

// s-mode access m-mode csr or inst
assign iui_s_inv  = iui_s_mode  
                && (iui_inst_ertn
                    || iui_inst_idle && regs_iui_tw
                    || iui_inst_csr && regs_iui_scnt_inv
                    || iui_inst_csr && regs_iui_hpcp_scr_inv
                    );

// u-mode access m/s-mode csr or inst
assign iui_u_inv  = iui_u_mode  
                && (iui_inst_ertn
                    || iui_inst_idle
                    || iui_inst_csr && ((iui_addr[11:0] != 12'hFFF) // TODO: performance register
                                        // && (iui_addr[11:0] != 12'h42)
                                        && (iui_addr[11:0] != 12'h130) // DEBUG0
                                        && (iui_addr[11:0] != 12'h131) // DEBUG1
                                        && (iui_addr[11:0] != 12'h132) // DGWDUMP
                                        && (iui_addr[11:0] != 12'h133) // CPRS
                                        && (iui_addr[11:0] != 12'h134) // CPRS_TCFG
                                        && (iui_addr[11:0] != 12'hF00) // FCSR0
                                        && (iui_addr[11:0] != 12'hF01) // FCSR1
                                        && (iui_addr[11:0] != 12'hF02) // FCSR2
                                        && (iui_addr[11:0] != 12'hF03) // FCSR3
                                        && (iui_addr[11:0] != 12'h135) // DEBUG2
                                        && (iui_addr[11:0] != 12'h136) // DEBUG3
                                        && (iui_addr[11:0] != 12'h137) // DEBUG4
                                        && (iui_addr[11:0] != 12'h138) // DEBUG5
                                        && (iui_addr[11:0] != 12'h139) // DEBUG6
                                        && (iui_addr[11:0] != 12'h13a) // DEBUG7
                                        && (iui_addr[11:0] != 12'h200) // PERFCTRL0
                                        && (iui_addr[11:0] != 12'h201) // PERFCNTR0
                                        && (iui_addr[11:0] != 12'h202) // PERFCTRL1
                                        && (iui_addr[11:0] != 12'h203) // PERFCNTR1
                                        && (iui_addr[11:0] != 12'h204) // PERFCTRL2
                                        && (iui_addr[11:0] != 12'h205) // PERFCNTR2
                                        && (iui_addr[11:0] != 12'h206) // PERFCTRL3
                                        && (iui_addr[11:0] != 12'h207) // PERFCNTR3
                                        && (iui_addr[11:0] != 12'h208) // PERFCTRL4
                                        && (iui_addr[11:0] != 12'h209) // PERFCNTR4
                                        && (iui_addr[11:0] != 12'h20a) // PERFCTRL5
                                        && (iui_addr[11:0] != 12'h20b) // PERFCNTR5
                                        && (iui_addr[11:0] != 12'h20c) // PERFCTRL6
                                        && (iui_addr[11:0] != 12'h20d) // PERFCNTR6
                                        )
                    );

assign iui_cfg_inv = iui_inst_cpucfg && (iui_regs_cpu_cfg_code[15:8] != 8'b0);

// write read-only csr
assign iui_w_inv   = iui_inst_csr && !iui_inst_ro 
                    //// TODO:
                    && 1'b0; 

// fs illegal 
//according to riscv-v-spec pull 135:
assign iui_fs_inv  = iui_inst_csr && regs_iui_fs_off
                     && ((iui_addr[11:0] == FXCR)
                      || (iui_addr[11:0] == FCSR)
                      || (iui_addr[11:0] == FFLAGS)
                      || (iui_addr[11:0] == FRM)
                      || (iui_addr[11:0] == VXSAT)
                      || (iui_addr[11:0] == VXRM)
                        );

assign iui_vs_inv  = iui_inst_csr && regs_iui_vs_off
                     && ((iui_addr[11:0] == VL)
                      || (iui_addr[11:0] == VTYPE)
                      || (iui_addr[11:0] == VSTART)
                      || (iui_addr[11:0] == VLENB)
                        );
assign iui_tee_inv = iui_inst_csr && regs_iui_chk_vld
                  && !regs_iui_tee_vld && !iui_inst_ro
                  && ((iui_addr[11:0] == MTEECFG) && !regs_iui_tee_ff
                   || (iui_addr[11:0] == MCCR2)
                   || (iui_addr[11:0] == MHINT4)
                   || (iui_addr[11:0] == MCER2)
                   || (iui_addr[11:0] == MEICR2)
                   || (iui_addr[11:0] == MCINS) && regs_iui_cindex_l2
                    )
                  ;
//in debug mode or m-mode set, the cp0 insctuction
//execute with privilege
assign iui_privilege = (rtu_yy_xx_dbgon
                    || iui_m_mode
                    || iui_s_mode && !iui_v_mode && !iui_s_inv
                    || iui_s_mode && iui_v_mode  && !iui_s_inv && !iui_hs_inv
                    || iui_u_mode && !iui_u_inv
                       ) && !csr_addr_inv && !iui_w_inv && !iui_fs_inv && !iui_cfg_inv
                     && !iui_vs_inv && !iui_tee_inv;

//the instruction need write back into conctol register
//should be selected only when cp0 in EX1 state
//following singals are selected only when ex1 stage
assign inst_csr_ex1      = cp0_ex1_select && iui_privilege && iui_inst_csr;
assign inst_cpucfg_ex1   = cp0_ex1_select && iui_privilege && iui_inst_cpucfg;
assign inst_mret_ex2     = cp0_ex2_select && iui_privilege && iui_inst_mret;
assign inst_ertn_ex2     = cp0_ex2_select && iui_privilege && iui_inst_ertn;
assign inst_sret_ex2     = cp0_ex2_select && iui_privilege && iui_inst_sret;

assign inst_tlbop_ex2    = cp0_ex1_select && iui_privilege && iui_inst_tlbop;

assign inst_iocsrrd_ex1  = cp0_ex1_select && iui_inst_iocsrrd;
assign inst_iocsrwr_ex1  = cp0_ex1_select && iui_inst_iocsrwr;

assign inst_iocsr_ex1    = inst_iocsrrd_ex1 || inst_iocsrwr_ex1;

//signal for lpmd enter into low power mode, not valid in ex3 stage
assign inst_lpmd_ex1_ex2 = (cp0_ex1_select || cp0_ex2_select) && iui_privilege
                           && iui_inst_idle;

//signal for inst csr in EX3 stage, used to increase index of CPUID
assign iui_regs_ex3_inst_csr = cp0_ex3_select && iui_flop_commit
                            && iui_privilege && iui_inst_csr;

//csr write insctuction
assign inst_csr_wr = cp0_select && iui_privilege && iui_inst_csr 
                  && !iui_inst_ro;

//low power insctuction
assign inst_lpmd   = cp0_select && iui_privilege && iui_inst_idle;

//instruction type singel for flush and iu special generation
//ignore psr s bit only indicate insctuction type information
//assign cp0_csr     = cp0_select && iui_inst_csr;
//assign cp0_wfi     = cp0_select && iui_inst_wfi;
assign cp0_mret    = cp0_select && iui_inst_mret;
assign cp0_sret    = cp0_select && iui_inst_sret;
assign cp0_ertn    = cp0_select && iui_inst_ertn;
assign cp0_cprs    = cp0_select && iui_inst_cprs;

//==========================================================
//          Generate select and data signals to regs
//==========================================================
// write valid in EX2
always @ (posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inst_csr_ex2 <= 1'b0;
  else if(cp0_ex1_select)
    inst_csr_ex2 <= (inst_csr_ex1 && !iui_inst_ro);
  else
    inst_csr_ex2 <= 1'b0;
end

// write valid in EX2
always @ (posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inst_iocsr_ex2 <= 1'b0;
  else if(cp0_ex1_select)
    inst_iocsr_ex2 <= inst_iocsr_ex1;
  else
    inst_iocsr_ex2 <= 1'b0;
end

assign iui_regs_sel          = inst_csr_ex2 && cp0_ex2_select;
assign iui_regs_sel_ipi      = inst_iocsr_ex2 && cp0_ex2_select;
assign iui_regs_inst_mret    = inst_mret_ex2;
assign iui_regs_inst_ertn    = inst_ertn_ex2;
assign iui_regs_inst_sret    = inst_sret_ex2;
assign iui_regs_csr_wr       = iui_inst_csr && !iui_inst_ro;
assign iui_regs_addr[11:0]   = iui_addr[11:0];
assign iui_regs_inv_expt     = !iui_privilege && cp0_ex2_select;
assign iui_regs_opcode[31:0] = {32{!iui_privilege}} & iui_opcode[31:0];
assign iui_regs_ori_src0[63:0] = (iui_inst_csrrs || iui_inst_csrrc) ? iui_src0[63:0]
                                                                    : iui_uimm[63:0];
assign iui_regs_csrw         = iui_inst_csrrw || iui_inst_csrrwi;

assign iui_regs_iocsr_addr[15:0]     =  iui_iocsr_addr[15:0];
assign regs_iui_iocsr_data_ext[63:0] =  {64{iui_iocsr_width[1:0] == 2'b00}} & {{56{regs_iui_iocsr_data_out[ 7]}}, regs_iui_iocsr_data_out[ 7:0]}
                                       |{64{iui_iocsr_width[1:0] == 2'b01}} & {{48{regs_iui_iocsr_data_out[15]}}, regs_iui_iocsr_data_out[15:0]}
                                       |{64{iui_iocsr_width[1:0] == 2'b10}} & {{32{regs_iui_iocsr_data_out[31]}}, regs_iui_iocsr_data_out[31:0]}
                                       |{64{iui_iocsr_width[1:0] == 2'b11}} & {regs_iui_iocsr_data_out[63:0]};


/// cpucfg
assign iui_regs_cpu_cfg_code[63:0] = iui_src0[63:0];

assign csrrw_src0[63:0]  = iui_src0[63:0];
assign csrrs_src0[63:0]  = cp0_rslt_reg[63:0] |   iui_src0[63:0];
assign csrrc_src0[63:0]  = cp0_rslt_reg[63:0] & (~iui_src0[63:0]);
assign csrrwi_src0[63:0] = iui_uimm[63:0];
assign csrrsi_src0[63:0] = cp0_rslt_reg[63:0] |   iui_uimm[63:0];
assign csrrci_src0[63:0] = cp0_rslt_reg[63:0] & (~iui_uimm[63:0]);


assign csrwr_src0[63:0]   = iui_src0[63:0];
assign csrxchg_src0[63:0] = cp0_rslt_reg[63:0] & (~iui_src0[63:0]) |
                            iui_src1[63:0] & ( iui_src0[63:0]);


assign iui_regs_src0[63:0] = {64{iui_inst_csrwr}}    & csrwr_src0[63:0]
                           | {64{iui_inst_movgr2fcsr_wr}}    & iui_src0[63:0] 
                           | {64{iui_inst_csrxchg}}  & csrxchg_src0[63:0];

assign iui_ipi_regs_src[63:0] = iui_src1[63:0];

//----------------------------------------------------------
// sysio signal
//----------------------------------------------------------

assign iui_update_ipi_status_en         = sysio_core_cp0_update_ipi_status_en;
assign iui_update_ipi_status_src[31:0]  = sysio_core_cp0_update_ipi_status_src[31:0];

assign iui_update_ipi_mailbox0_en = sysio_core_cp0_update_mailbox0_en;
assign iui_update_ipi_mailbox1_en = sysio_core_cp0_update_mailbox1_en;
assign iui_update_ipi_mailbox2_en = sysio_core_cp0_update_mailbox2_en;
assign iui_update_ipi_mailbox3_en = sysio_core_cp0_update_mailbox3_en;

assign iui_update_ipi_mailbox_sel[3:0] = sysio_core_cp0_update_bit_sel[3:0];

assign iui_update_ipi_regs_mask0[31:0] = sysio_core_cp0_update_mailbox_mask0[31:0];
assign iui_update_ipi_regs_mask1[31:0] = sysio_core_cp0_update_mailbox_mask1[31:0];
assign iui_update_ipi_regs_mask2[31:0] = sysio_core_cp0_update_mailbox_mask2[31:0];
assign iui_update_ipi_regs_mask3[31:0] = sysio_core_cp0_update_mailbox_mask3[31:0];

assign iui_update_ipi_regs_src0[31:0] = sysio_core_cp0_update_mailbox_src0[31:0];
assign iui_update_ipi_regs_src1[31:0] = sysio_core_cp0_update_mailbox_src1[31:0];
assign iui_update_ipi_regs_src2[31:0] = sysio_core_cp0_update_mailbox_src2[31:0];
assign iui_update_ipi_regs_src3[31:0] = sysio_core_cp0_update_mailbox_src3[31:0];



//==========================================================
//                 SysIO Interface                   
//==========================================================
wire iocsr_send_block;
wire iui_ipi_req_save;
wire iui_ipi_mail_send;
wire save_ipi_mail_send;
reg save_ipi_send_state;
reg save_mail_box_state;

assign iui_ipi_send_en  = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == IPISEND);
assign iui_mail_send_en = iui_regs_sel_ipi && (iui_regs_iocsr_addr[15:0] == MAILSEND);

// TODO: if block?
// assign iocsr_send_block = iui_ipi_regs_src[31];
assign iocsr_send_block = 1'b1;

assign iui_ipi_mail_send  = iui_ipi_send_en || iui_mail_send_en;
assign save_ipi_mail_send = save_ipi_send_state || save_mail_box_state;

assign iui_ipi_req_save = iui_ipi_mail_send && iocsr_send_block && !sysio_core_cp0_req_grnt;


always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    save_ipi_send_state <= 1'b0;
    save_mail_box_state <= 1'b0;
  end
  else if(iui_ipi_req_save) begin
    save_ipi_send_state <= iui_ipi_send_en;
    save_mail_box_state <= iui_mail_send_en;
  end
  else if(sysio_core_cp0_req_grnt) begin // clear
    save_ipi_send_state <= 1'b0;
    save_mail_box_state <= 1'b0;
  end
  else begin
    save_ipi_send_state <= save_ipi_send_state;
    save_mail_box_state <= save_mail_box_state;
  end
end

reg [31:0] save_ipi_send_data;
reg [63:0] save_mail_send_data;
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    save_ipi_send_data[31:0]  <= 32'b0;
    save_mail_send_data[63:0] <= 64'b0;
  end  
  else if(iui_ipi_req_save) begin
    save_ipi_send_data[31:0]  <= iui_ipi_regs_src[31:0];
    save_mail_send_data[63:0] <= iui_ipi_regs_src[63:0];
  end
  else if(sysio_core_cp0_req_grnt) begin // clear
    save_ipi_send_data[31:0]  <= 32'b0;
    save_mail_send_data[63:0] <= 64'b0;
  end
  else begin
    save_ipi_send_data[31:0]  <= save_ipi_send_data[31:0];
    save_mail_send_data[63:0] <= save_mail_send_data[63:0];
  end
end


assign core_sysio_wr_req      = iui_ipi_mail_send || save_ipi_mail_send;
assign core_sysio_wr_sel[3:0] = {2'b0, 
                                 iui_mail_send_en || save_mail_box_state, 
                                 iui_ipi_send_en || save_ipi_send_state};
// sysio_core_cp0_req_grnt
assign core_sysio_wr_ipi_send_data[31:0]      =   {32{iui_ipi_mail_send}}   & iui_ipi_regs_src[31:0]
                                                | {32{save_ipi_mail_send}} & save_ipi_send_data[31:0];

assign core_sysio_wr_mail_box_send_data[63:0] =   {64{iui_ipi_mail_send}}   & iui_ipi_regs_src[63:0]
                                                | {64{save_ipi_mail_send}} & save_mail_send_data[63:0];; 

assign core_sysio_mailbox0_data[63:0] = regs_iui_mailbox0_data[63:0];


//--------------------------------------------------
//   Interface to IFU Ctrl
//--------------------------------------------------
reg ifu_boot_stall_state;

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(~cpurst_b) begin
    ifu_boot_stall_state <= (biu_cp0_coreid[2:0] != 3'b0);
  end 
  else if(sysio_core_restart_vld && core_sysio_restart_grnt) begin
    ifu_boot_stall_state <= 1'b0;
  end
  else begin
    ifu_boot_stall_state <= ifu_boot_stall_state;
  end
end

assign cp0_ifu_boot_stall = ifu_boot_stall_state;

// for cut off cp0 - l2 write data path
assign iui_csr_inst_imm    = iui_inst_csrrwi || iui_inst_csrrsi || iui_inst_csrrci;

assign cp0_biu_sel         = (cp0_ex1_select || cp0_ex2_select) 
                          && iui_inst_csr && regs_iui_l2_regs_sel && iui_privilege;
assign cp0_biu_wdata[63:0] = regs_iui_dca_sel ? regs_iui_wdata[63:0]
                             : iui_csr_inst_imm ? iui_uimm[63:0] : iui_src0[63:0];

assign cp0_biu_op[15:8]    = {regs_iui_dca_sel, 7'b0};
assign cp0_biu_op[7:4]     = regs_iui_reg_idx[3:0];
assign cp0_biu_op[3]       = !iui_inst_ro;
assign cp0_biu_op[2]       = iui_inst_csrrw || iui_inst_csrrwi;
assign cp0_biu_op[1]       = iui_inst_csrrs || iui_inst_csrrsi;
assign cp0_biu_op[0]       = iui_inst_csrrc || iui_inst_csrrci;

//assign cp0_biu_l2_csrw       = iui_inst_csrrw || iui_inst_csrrwi;
//assign cp0_biu_l2_csrs       = iui_inst_csrrs || iui_inst_csrrsi;
//assign cp0_biu_l2_csrc       = iui_inst_csrrc || iui_inst_csrrci;
//assign cp0_biu_l2_wdata[63:0] = iui_csr_inst_imm ? iui_uimm[63:0] : iui_src0[63:0];
//assign cp0_biu_l2_rd_vld     = inst_csr_ex1 && regs_iui_l2_regs_sel;
//assign cp0_biu_l2_wr_vld     = inst_csr_ex2 && (cur_state[1:0] == EX2) && regs_iui_l2_regs_sel;
//
// cp0-hpcp req-cmplt
assign cp0_hpcp_sel         = (cp0_ex1_select || cp0_ex2_select) 
                              && iui_inst_csr && regs_iui_hpcp_regs_sel && iui_privilege;

assign cp0_hpcp_op[3]       = !iui_inst_ro && cp0_ex2_select;
assign cp0_hpcp_op[2]       = iui_inst_csrrw || iui_inst_csrrwi;
assign cp0_hpcp_op[1]       = iui_inst_csrrs || iui_inst_csrrsi;
assign cp0_hpcp_op[0]       = iui_inst_csrrc || iui_inst_csrrci;
assign cp0_hpcp_src0[63:0]  = iui_csr_inst_imm ? iui_uimm[63:0] : iui_src0[63:0];

//mtcr mcir valid signal, used for complete signal
assign iui_csr_mcir = inst_csr_wr && regs_iui_cskyee && iui_addr[11:0] == SMCIR;

// L2 reg access inst should wait for cmplt
assign iui_csr_l2regs = cp0_select && iui_privilege && iui_inst_csr && regs_iui_l2_regs_sel;
assign iui_csr_hpcp   = cp0_select && iui_privilege && iui_inst_csr && regs_iui_hpcp_regs_sel;

//==========================================================
//            Handling the CP0 complete signal
//==========================================================
//all cp0 insctuction can be completed when:
//1.if low power insctuction, IFU/LSU gets no operation
//2.if mtcr mcir, MMU acknowledge complete
//3.inv and clr bit in cfr is 0
assign cp0_inst_cmplt = ( !(inst_lpmd || iui_csr_mcir || iui_csr_l2regs || iui_csr_hpcp)
                         || lpmd_cmplt
                         || mmu_cp0_cmplt
                         || hpcp_cp0_cmplt
                         || biu_cp0_cmplt)
                        && regs_iui_cfr_no_op
                        && regs_iui_cins_no_op;

//==========================================================
//           Generate data valid signal to IU 
//==========================================================
//if there is a mfcr insctuction, data valid 
assign cp0_iu_ex3_rslt_vld        = (iui_inst_csr || iui_inst_cpucfg
                                     || iui_inst_iocsrrd || iui_inst_iocsrwr)
                                    && iui_privilege
                                    && cp0_ex3_select
                                    && iui_flop_commit;
assign cp0_iu_ex3_rslt_preg[6:0]  = iui_preg[6:0];
assign cp0_iu_ex3_rslt_dreg[4:0]  = iui_opcode[4:0];

// &Force("bus", "biu_cp0_rdata", 127, 0); @1148
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cp0_rslt_reg[63:0] <= 64'b0;
  else if(biu_cp0_cmplt)
    cp0_rslt_reg[63:0] <= biu_cp0_rdata[63:0];
  else if(hpcp_cp0_cmplt)
    cp0_rslt_reg[63:0] <= hpcp_cp0_data[63:0];
  else if(inst_csr_ex1)
    cp0_rslt_reg[63:0] <= regs_iui_data_out[63:0];
  else if(inst_cpucfg_ex1)
    cp0_rslt_reg[63:0] <= regs_iui_cfg_data_out[63:0];
  else if(inst_iocsrrd_ex1)
    cp0_rslt_reg[63:0] <= regs_iui_iocsr_data_ext[63:0];
  else
    cp0_rslt_reg[63:0] <= cp0_rslt_reg[63:0];
end
assign cp0_iu_ex3_rslt_data[63:0] = cp0_rslt_reg[63:0];

//==========================================================
//            Special insctuction result 
//==========================================================
assign cp0_iu_ex3_iid[6:0]  = iui_ex1_iid[6:0];
assign cp0_iu_ex3_abnormal  = 1'b1;
//assign cp0_iu_ex3_unctace   = cp0_mret
//                              || cp0_sret
//                              || cp0_wfi;
//assign cp0_iu_ex3_idly_clr  = 1'b0;

//==========================================================
//             Generate Exception to IU 
//==========================================================

//----------------------------------------------------------
//          Generate CP0 Exception Valid
//----------------------------------------------------------
// Generate privilege exception when the CP0 is selected 
// at EX1 stage in user mode.
assign cp0_ex2_expt_vld = !iui_privilege && cp0_ex2_select;

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cp0_expt_vld <= 1'b0;
  else if(rtu_yy_xx_flush)
    cp0_expt_vld <= 1'b0;
  else if(cp0_ex2_select)
    cp0_expt_vld <= cp0_ex2_expt_vld;
  else
    cp0_expt_vld <= cp0_expt_vld;
end

assign cp0_iu_ex3_expt_vld = cp0_expt_vld;
assign cp0_iu_ex3_mtval[31:0] = iui_opcode[31:0];
    
//----------------------------------------------------------
//         Generate CP0 Exception Vector 
//----------------------------------------------------------
assign cp0_iu_ex3_expt_vec[4:0] = 5'hE;

//==========================================================
//             Generate Interrupt to RTU 
//==========================================================
//----------------------------------------------------------
//          Generate iui int valid
//----------------------------------------------------------

assign int_vld = |regs_iui_int_sel[12:0];
always @ (posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iui_int_vld_b <= 1'b1;
  else if(int_vld)
    iui_int_vld_b <= 1'b0;
  else 
    iui_int_vld_b <= 1'b1;
end

//----------------------------------------------------------
//         Generate iui int vector
//----------------------------------------------------------
reg [3:0] int_source_number;

always @( regs_iui_int_sel[12:0])
begin
casez(regs_iui_int_sel[12:0])
  13'b1???????????? : int_source_number[3:0] = 4'd12; // IPI
  13'b01??????????? : int_source_number[3:0] = 4'd11; // Timer Int
  13'b001?????????? : int_source_number[3:0] = 4'd10; // PMI 
  13'b0001????????? : int_source_number[3:0] = 4'd9;  // HW7
  13'b00001???????? : int_source_number[3:0] = 4'd8;  // HW6
  13'b000001??????? : int_source_number[3:0] = 4'd7;  // HW5
  13'b0000001?????? : int_source_number[3:0] = 4'd6;  // HW4
  13'b00000001????? : int_source_number[3:0] = 4'd5;  // HW3
  13'b000000001???? : int_source_number[3:0] = 4'd4;  // HW2
  13'b0000000001??? : int_source_number[3:0] = 4'd3;  // HW1
  13'b00000000001?? : int_source_number[3:0] = 4'd2;  // HW0
  13'b000000000001? : int_source_number[3:0] = 4'd1;  // SWI1
  13'b0000000000001 : int_source_number[3:0] = 4'd0;  // SWI0
  default           : int_source_number[3:0] = {4{1'bx}};
endcase
// &CombEnd; @1245
end


assign valid_int_vec[12:0] = (regs_iui_ecfg_vs[2:0] == 3'b0) ? 
                                {13{1'b0}} 
                              // ecode + 64  
                              : {9'h4, int_source_number[3:0]};  // interupt number

always @ (posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    iui_int_vec[12:0] <= 13'b0;
  else if(int_vld)
    iui_int_vec[12:0] <= valid_int_vec[12:0];
  else 
    iui_int_vec[12:0] <= iui_int_vec[12:0];
end

assign cp0_rtu_xx_int_b     = iui_int_vld_b;
assign cp0_rtu_xx_vec[12:0] = iui_int_vec[12:0];


//==========================================================
//                 generate cp0 flush                   
//==========================================================
//cp0 will generate flush if
//1.mret/sret
//2.csr inst
//3.wfi
assign iui_flush = cp0_select;

//flop out for timing optimization
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cp0_flush <= 1'b0;
  else if(rtu_yy_xx_flush)
    cp0_flush <= 1'b0;
  else if(cp0_ex2_select)
    cp0_flush <= iui_flush;
  else
    cp0_flush <= cp0_flush;
end

assign  cp0_iu_ex3_flush = cp0_flush;

// &ModuleEnd; @1285
endmodule


