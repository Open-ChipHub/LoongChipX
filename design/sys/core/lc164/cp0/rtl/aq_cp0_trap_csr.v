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
module aq_cp0_trap_csr (
  // &Ports, @25
  input    wire          biu_cp0_me_int,
  input    wire          biu_cp0_ms_int,
  input    wire          biu_cp0_mt_int,
  input    wire          biu_cp0_se_int,
  input    wire          biu_cp0_ss_int,
  input    wire          biu_cp0_st_int,
  input    wire          cpurst_b,
  input    wire  [7 :0]  ext_interrupt,
  input    wire          dtu_cp0_dcsr_mprven,
  input    wire  [1 :0]  dtu_cp0_dcsr_prv,
  input    wire          fcsr_local_en,
  input    wire          fflags_local_en,
  input    wire          float_clk,
  input    wire          frm_local_en,
  input    wire          fxcr_local_en,
  input    wire          hpcp_cp0_int_vld,
  input    wire          iui_regs_inst_ertn,
  input    wire          iui_regs_inst_mret,
  input    wire          iui_regs_inst_sret,
  input    wire          iui_regs_inst_cprs,
  input    wire  [63:0]  iui_regs_wdata,
  input    wire          mcause_local_en,
  input    wire          medeleg_local_en,
  input    wire          mepc_local_en,
  input    wire          mideleg_local_en,
  input    wire          mie_local_en,
  input    wire          mip_local_en,
  input    wire          mscratch_local_en,
  input    wire          mstatus_local_en,
  input    wire          mtval_local_en,
  input    wire          mtvec_local_en,

  // LoongArch
  input    wire          arch_ctrl_local_en,
  input    wire          crmd_local_en,
  input    wire          prmd_local_en,
  input    wire          euen_local_en,
  input    wire          misc_local_en,
  input    wire          ecfg_local_en,
  input    wire          estat_local_en,
  input    wire          era_local_en,
  input    wire          badv_local_en,
  input    wire          eentry_local_en,
  input    wire          tlbidx_local_en,
  input    wire          tlbehi_local_en,
  input    wire          tlbelo0_local_en,
  input    wire          tlbelo1_local_en,
  input    wire          asid_local_en,
  input    wire          pgdl_local_en,
  input    wire          pgdh_local_en,
  input    wire          pgd_local_en,
  input    wire          pwcl_local_en,
  input    wire          pwch_local_en,
  input    wire          stlbps_local_en,
  input    wire          rvacfg_local_en,
  input    wire          cpuid_local_en,
  input    wire          save0_local_en,
  input    wire          save1_local_en,
  input    wire          save2_local_en,
  input    wire          save3_local_en,
  input    wire          tid_local_en,
  input    wire          tcfg_local_en,
  input    wire          tval_local_en,
  input    wire          cntc_local_en,
  input    wire          ticlr_local_en,
  input    wire          llbctl_local_en,
  input    wire          tlbrentry_local_en,
  input    wire          tlbrehi_local_en,
  input    wire          merrentry_local_en,
  input    wire          dmw0_local_en,
  input    wire          dmw1_local_en,
  input    wire          dmw2_local_en,
  input    wire          dmw3_local_en,
  input    wire          BRK_local_en,
  input    wire          dis_cache_local_en,
  input    wire          debug0_local_en,
  input    wire          debug1_local_en,
  input    wire          dgwavedump_local_en,
  input    wire          cpcsr_local_en,
  input    wire          cpcsr_tcfg_local_en,
  input    wire          cpcsr_crmd_local_en,
  input    wire          mwpc_local_en,
  input    wire          mwps_local_en,
  input    wire          fwpc_local_en,
  input    wire          fwps_local_en,
  input    wire          fcsr0_local_en,
  input    wire          fcsr1_local_en,
  input    wire          fcsr2_local_en,
  input    wire          fcsr3_local_en,
  input    wire  [5 :0]  iui_regs_csr_cpucfg_op,
  input    wire          regs_clintee,
  input    wire          regs_clk,
  input    wire          regs_flush_clk,
  input    wire  [1 :0]  regs_mxl,
  input    wire  [63:0]  rtu_cp0_epc,
  input    wire          rtu_cp0_exit_debug,
  input    wire          rtu_cp0_fs_dirty_updt,
  input    wire          rtu_cp0_fs_dirty_updt_dp,
  input    wire  [63:0]  rtu_cp0_tval,
  input    wire          rtu_cp0_vs_dirty_updt,
  input    wire          rtu_cp0_vs_dirty_updt_dp,
  input    wire          rtu_cp0_fflags_updt,
  input    wire          rtu_cp0_split_vld,
  input    wire  [4 :0]  rtu_cp0_fflags,
  input    wire          rtu_yy_xx_dbgon,
  input    wire          rtu_yy_xx_expt_int,
  input    wire  [14:0]  rtu_yy_xx_expt_vec,
  input    wire          rtu_yy_xx_expt_vld,
  input    wire          scause_local_en,
  input    wire          sepc_local_en,
  input    wire          sie_local_en,
  input    wire          sip_local_en,
  input    wire          sscratch_local_en,
  input    wire          sstatus_local_en,
  input    wire          stval_local_en,
  input    wire          stvec_local_en,
  output   wire          cp0_dtu_mexpt_vld,
  output   wire          cp0_hpcp_int_off_vld,
  output   wire  [1 :0]  cp0_idu_fs,
  output   wire  [1 :0]  cp0_idu_vs,
  output   wire  [1 :0]  cp0_lsu_mpp,
  output   wire          cp0_lsu_mprv,
  output   wire          cp0_mmu_mxr,
  output   wire          cp0_mmu_sum,
  output   wire  [14:0]  cp0_rtu_int_vld,
  output   wire  [2 :0]  cp0_rtu_ecfg_vs,
  output   wire  [63:0]  cp0_rtu_trap_pc,
  output   wire  [1 :0]  cp0_yy_priv_mode,
  output   wire  [4 :0]  cp0_vpu_fflags_enable,
  output   wire          fs_dirty_upd_gate,
  output   wire  [63:0]  mcause_value,
  output   wire  [63:0]  medeleg_value,
  output   wire  [63:0]  mepc_value,
  output   wire  [63:0]  mideleg_value,
  output   wire  [63:0]  mie_value,
  output   wire  [63:0]  mip_value,
  output   wire  [63:0]  mscratch_value,
  output   wire  [63:0]  mstatus_value,
  output   wire  [63:0]  mtval_value,
  output   wire  [63:0]  mtvec_value,

  // LoongArch
  output   wire  [63:0]  csrarch_value,
  output   wire  [63:0]  csrcrmd_value,
  output   wire  [63:0]  csrprmd_value,
  output   wire  [63:0]  csreuen_value,
  output   wire  [63:0]  csrmisc_value,
  output   wire  [63:0]  csrecfg_value,
  output   wire  [63:0]  csrestat_value,
  output   wire  [63:0]  csrera_value,
  output   wire  [63:0]  csrbadv_value,
  output   wire  [63:0]  csrbadi_value,
  output   wire  [63:0]  csreentry_value,
  output   wire  [63:0]  csrtlbrentry_value,
  output   wire  [63:0]  csrmerrentry_value,
  output   wire  [63:0]  csrtlbidx_value,
  output   wire  [63:0]  csrpwcl_value,
  output   wire  [63:0]  csrpwch_value,
  output   wire  [63:0]  csrstlbps_value,
  output   wire  [63:0]  csrrvacfg_value,
  output   wire  [63:0]  csrasid_value,
  output   wire  [63:0]  csrdmw0_value,
  output   wire  [63:0]  csrdmw1_value,
  output   wire  [63:0]  csrdmw2_value,
  output   wire  [63:0]  csrdmw3_value,
  output   wire  [63:0]  csrtid_value,
  output   wire  [63:0]  csrtcfg_value,
  output   wire  [63:0]  csrtval_value,
  output   wire  [63:0]  csrcntc_value,
  output   wire  [63:0]  csrticlr_value,
  output   wire  [63:0]  csrsave0_value,
  output   wire  [63:0]  csrsave1_value,
  output   wire  [63:0]  csrsave2_value,
  output   wire  [63:0]  csrsave3_value,
  output   wire  [63:0]  cpuid_value,
  output   wire  [63:0]  csrpgdl_value,
  output   wire  [63:0]  csrpgdh_value,
  output   wire  [63:0]  csrprcfg1_value,
  output   wire  [63:0]  csrprcfg2_value,
  output   wire  [63:0]  csrprcfg3_value,
  output   wire  [63:0]  csrrehi_value,
  output   wire  [63:0]  debug0_value,
  output   wire  [63:0]  debug1_value,
  output   wire  [63:0]  debug_wave_dump_value,
  output   wire  [63:0]  mwpc_value,
  output   wire  [63:0]  mwps_value,
  output   wire  [63:0]  fwpc_value,
  output   wire  [63:0]  fwps_value,
  output   wire  [63:0]  fcsr0_value,
  output   wire  [63:0]  fcsr1_value,
  output   wire  [63:0]  fcsr2_value,
  output   wire  [63:0]  fcsr3_value,
  output   wire  [63:0]  regs_iui_era,
  output   wire          cp0_mmu_crmd_da,
  output   wire          cp0_mmu_crmd_pg,
  output   wire  [63:0]  cp0_mmu_dmw0,
  output   wire  [63:0]  cp0_mmu_dmw1,
  output   wire  [63:0]  cp0_mmu_dmw2,
  output   wire  [63:0]  cp0_mmu_dmw3,
  output   wire          regs_fs_off,
  output   wire  [63:0]  regs_iui_rdtime,
  output   reg   [63:0]  regs_iui_cfg_data,
  output   wire  [63:0]  regs_iui_mepc,
  output   wire  [1 :0]  regs_iui_pm,
  output   wire  [63:0]  regs_iui_sepc,
  output   wire  [63:0]  regs_iui_cprs,
  output   wire          regs_iui_tsr,
  output   wire          regs_iui_tvm,
  output   wire          regs_iui_tw,
  output   wire          regs_lpmd_int_vld,
  output   wire  [1 :0]  regs_pm,
  output   wire          regs_tvm,
  output   wire  [63:0]  scause_value,
  output   wire  [63:0]  sepc_value,
  output   wire  [63:0]  sie_value,
  output   wire  [63:0]  sip_raw,
  output   wire  [63:0]  sip_value,
  output   wire  [63:0]  sscratch_value,
  output   wire  [63:0]  sstatus_value,
  output   wire  [63:0]  stval_value,
  output   wire  [63:0]  stvec_value,
  output   wire          vs_dirty_upd_gate
); 



// &Regs; @26
reg     [15:0]  edeleg;                  
reg     [1 :0]  fs_reg;                  
reg             m_intr;                  
reg     [4 :0]  m_vector;                
reg             meie;                    
reg     [62:0]  mepc_reg;                
reg             mie_bit;                 
reg             moie;                    
reg             moie_deleg;              
reg             mpie;                    
reg     [1 :0]  mpp;                     
reg             mprv;                    
reg     [63:0]  mscratch;                
reg             msie;                    
reg             mtie;                    
reg     [63:0]  mtval_data;              
reg     [61:0]  mtvec_base;              
reg     [1 :0]  mtvec_mode;              
reg             mxr;                     
reg     [1 :0]  pm_bits;                 
reg     [1 :0]  pm_wdata;                
reg             s_intr;                  
reg     [4 :0]  s_vector;                
reg             seie;                    
reg             seie_deleg;              
reg             seip_reg;                
reg     [62:0]  sepc_reg;                
reg             sie_bit;                 
reg             spie;                    
reg             spp;                     
reg     [63:0]  sscratch;                
reg             ssie;                    
reg             ssie_deleg;              
reg             ssip_reg;                
reg             stie;                    
reg             stie_deleg;              
reg             stip_reg;                
reg     [63:0]  stval_data;              
reg     [61:0]  stvec_base;              
reg     [1 :0]  stvec_mode;              
reg             sum;                     
reg             tsr;                     
reg             tvm;                     
reg             tw;                      
reg     [18:0]  vec_num;   
reg             timer_clr;              
reg             tcfg_en;              

// &Wires; @27
wire    [15:0]  edeleg_upd_val;      
wire    [1 :0]  fs;                      
wire            fs_dirty_upd;            
wire            fs_off;                  
wire            int_off_vld;             
wire    [14:0]  int_sel;                 
wire            lpmd_ack_vld;            
wire            mcie;                    
wire            mcie_deleg;              
wire            mcip;                    
wire            mcip_acc_en;             
wire            mcip_deleg_vld;          
wire            mcip_en;                 
wire            mcip_nodeleg_vld;        
wire            mdeleg_vld_dp;           
wire            medeleg_vld_dp;          
wire            meip;                    
wire            meip_en;                 
wire            meip_vld;                
wire            mhie;                    
wire            mhie_deleg;              
wire            mhip;                    
wire            mhip_acc_en;             
wire            mhip_deleg_vld;          
wire            mhip_en;                 
wire            mhip_nodeleg_vld;        
wire    [63:0]  mideleg;                 
wire            mideleg_vld_dp;          
wire            moip;                    
wire            moip_acc_en;             
wire            moip_deleg_vld;          
wire            moip_en;                 
wire            moip_nodeleg_vld;        
wire            mpv;                     
wire            msip;                    
wire            msip_en;                 
wire            msip_vld;                
wire            mtip;                    
wire            mtip_en;                 
wire            mtip_vld;                
wire    [1 :0]  pm;                      
wire            pm_wen;                  
wire            regs_intr;               
wire            regs_mpp_write_ill;      
wire    [39:0]  regs_trap_pc;            
wire    [39:0]  regs_tvec;               
wire    [4 :0]  regs_vector;             
wire            sd;                      
wire            seip;                    
wire            seip_acc_en;             
wire            seip_deleg_vld;          
wire            seip_en;                 
wire            seip_nodeleg_vld;        
wire            ssip;                    
wire            ssip_acc_en;             
wire            ssip_deleg_vld;          
wire            ssip_en;                 
wire            ssip_nodeleg_vld;        
wire            sstatus_spp;             
wire            stip;                    
wire            stip_acc_en;             
wire            stip_deleg_vld;          
wire            stip_en;                 
wire            stip_nodeleg_vld;        
wire    [1 :0]  sxl;                     
wire    [1 :0]  uxl;                     
wire    [39:0]  vec_int_pc;              
wire    [1 :0]  vs;                      
wire            vxrm_local_en;           
wire            vxsat_local_en;          
wire    [1 :0]  xs;                      

wire    [63:0]  mtval_upd_data;
wire    [63:0]  csrtimer_value;
wire    [63:0]  cpcsr_value;
wire    [63:0]  cpcsr_crmd_value;



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
    arch_ctrl[0]     <= iui_regs_wdata[0];
  end
  else begin
    arch_ctrl[63:0]  <= arch_ctrl[63:0];
  end
end

assign csrarch_value[63:0] = arch_ctrl[63:0];


assign cpuid_value[63:0] = {61'b0, 3'b0};



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
  else if(rtu_yy_xx_expt_vld) begin
    crmd_plv  <= 2'b0;
    crmd_ie   <= 1'b0;
  end
  else if(iui_regs_inst_ertn) begin
    crmd_plv  <= prmd_pplv;
    crmd_ie   <= prmd_pie;
  end

`ifdef CPU_CHECKPOINT
  else if(iui_regs_inst_cprs) begin
    crmd_plv  <= cpcsr_crmd_value[1:0];
    crmd_ie   <= cpcsr_crmd_value[2];
  end
`endif

  else if(crmd_local_en) begin
    crmd_plv  <= iui_regs_wdata[1:0];
    crmd_ie   <= iui_regs_wdata[2];
  end
  else begin
    crmd_plv  <= crmd_plv;
    crmd_ie   <= crmd_ie;
  end
end


reg [1:0] crmd_datf;
reg [1:0] crmd_datm;
reg       crmd_da;
reg       crmd_pg;
reg [1:0] csr_errctl_pdatf;
reg [1:0] csr_errctl_pdatm;
reg       csr_errctl_pda;
reg       csr_errctl_ppg;

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
  // else if(rtu_yy_xx_expt_vld) begin
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
    crmd_da   <= iui_regs_wdata[3];
    crmd_pg   <= iui_regs_wdata[4];
    crmd_datf <= iui_regs_wdata[6:5];
    crmd_datm <= iui_regs_wdata[8:7];
  end

`ifdef CPU_CHECKPOINT
  else if(iui_regs_inst_cprs) begin
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


reg  csr_errctl_pwe;
reg  csr_tlbrprmd_pwe;
wire csr_tlbrera_istlbr = 1'b0;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    crmd_we   <= 1'b0;
  else if(rtu_yy_xx_expt_vld)
    crmd_we   <= 1'b0;
  else if(csr_errctl_ismerr)
    crmd_we   <= csr_errctl_pwe;
  else if(iui_regs_inst_ertn)
    crmd_we   <= prmd_pwe;
  else if(csr_tlbrera_istlbr)
    crmd_we   <= csr_tlbrprmd_pwe;

`ifdef CPU_CHECKPOINT
  else if(iui_regs_inst_cprs) begin
    crmd_we   <= cpcsr_crmd_value[9];
  end
`endif

  else if(crmd_local_en)
    crmd_we   <= iui_regs_wdata[9];
  else
    crmd_we   <= crmd_we;
end

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
  else if(rtu_yy_xx_expt_vld) begin
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
    prmd_pplv  <= iui_regs_wdata[1:0];
    prmd_pie   <= iui_regs_wdata[2];
    prmd_pwe   <= iui_regs_wdata[3];
  end
  else begin
    prmd_pplv  <= prmd_pplv;
    prmd_pie   <= prmd_pie;
    prmd_pwe   <= prmd_pwe;
  end
end

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
    fpe   <= iui_regs_wdata[0];
    sxe   <= iui_regs_wdata[1];
    asxe  <= iui_regs_wdata[2];
    bte   <= iui_regs_wdata[3];
  end
  else begin
    fpe   <= fpe;
    sxe   <= sxe;
    asxe  <= asxe;
    bte   <= bte;
  end  
end

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
    va32l1   <= iui_regs_wdata[1];
    va32l2   <= iui_regs_wdata[2];
    va32l3   <= iui_regs_wdata[3];
    drdtl1   <= iui_regs_wdata[5];
    drdtl2   <= iui_regs_wdata[6];
    drdtl3   <= iui_regs_wdata[7];
    rpcntl1  <= iui_regs_wdata[9];
    rpcntl2  <= iui_regs_wdata[10];
    rpcntl3  <= iui_regs_wdata[11];
    alcl0    <= iui_regs_wdata[12];
    alcl1    <= iui_regs_wdata[13];
    alcl2    <= iui_regs_wdata[14];
    alcl3    <= iui_regs_wdata[15];
    dwpl0    <= iui_regs_wdata[16];
    dwpl1    <= iui_regs_wdata[17];
    dwpl2    <= iui_regs_wdata[18];
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
  else if(rtu_yy_xx_expt_vld)
    csrera[63:0] <= rtu_cp0_epc[63:0];
  else if(era_local_en)
    csrera[63:0] <= iui_regs_wdata[63:0];
  else
    csrera[63:0] <= csrera[63:0];
end

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
    csreentry[63:0] <= iui_regs_wdata[63:0];
  else
    csreentry[63:0] <= csreentry[63:0];
end

assign csreentry_value[63:0]  = csreentry[63:0];


//==========================================================
//                      ECFG Registers
//==========================================================
reg [12:0] lie;
reg [2:0]  evs;
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    lie[12:0]   <= 13'b0;
    evs[2:0]     <= 3'b0;
  end
  else if(ecfg_local_en) begin
    lie[12:0]   <= iui_regs_wdata[12:0];
    evs[2:0]     <= iui_regs_wdata[18:16];
  end
  else begin
    lie[12:0]   <= lie[12:0];
    evs[2:0]     <= evs[2:0];
  end  
end


assign csrecfg_value[63:0]  = {{45{1'b0}}, evs[2:0], 3'b0, lie[12:0]};

wire [2:0] ecfg_vs = evs[2:0];
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
    swis[1:0]  <= iui_regs_wdata[1:0];
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
    ext_is[7:0]  <= iui_regs_wdata[7:0];
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
    perfm_is  <= iui_regs_wdata[8];
  end
  else begin
    perfm_is  <= perfm_is;
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
    timer_is  <= iui_regs_wdata[9];
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
  else if(estat_local_en) begin
    ipi_is  <= iui_regs_wdata[10];
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
  else if(rtu_yy_xx_expt_vld) begin
    ecode[5:0]      <= rtu_yy_xx_expt_vec[5:0];
    subecode[8:0]   <= rtu_yy_xx_expt_vec[14:6];
  end
  else if(estat_local_en) begin
    ecode[5:0]      <= iui_regs_wdata[21:16];
    subecode[8:0]   <= iui_regs_wdata[30:22];
  end
  else begin
    ecode[5:0]      <= ecode[5:0];
    subecode[8:0]   <= subecode[8:0];
  end
end


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
assign mtval_upd_data[63:0] = rtu_cp0_tval[63:0];


reg [63:0] badv;                                                                                            
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    badv[63:0] <= 64'b0;
  else if(rtu_yy_xx_expt_vld) 
    badv[63:0] <= mtval_upd_data[63:0];
  else if(badv_local_en)
    badv[63:0] <= iui_regs_wdata[63:0];
  else
    badv[63:0] <= badv[63:0];
end

assign csrbadv_value[63:0] = badv[63:0];


//==========================================================
//               Define the BADI register
//==========================================================
reg [63:0] badi;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    badi[63:0] <= 64'b0;
  else if(rtu_yy_xx_expt_vld) 
    badi[63:0] <= mtval_upd_data[63:0];
  else if(badv_local_en)
    badi[63:0] <= iui_regs_wdata[63:0];
  else
    badi[63:0] <= badi[63:0];
end

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
    asid[9:0] <= iui_regs_wdata[9:0];
  else
    asid[9:0] <= asid[9:0];
end

assign csrasid_value[63:0] = {{32'b0}, {8'b0}, asidbits, {6'b0}, asid};

//==========================================================
//               Define the PGDL register
//==========================================================
reg [63:0] pgdl;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pgdl[63:0] <= 64'b0;
  else if(pgdl_local_en)
    pgdl[63:0] <= {iui_regs_wdata[63:12], {12{1'b0}}};
  else
    pgdl[63:0] <= pgdl[63:0];
end

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
    pgdh[63:0] <= {iui_regs_wdata[63:12], {12{1'b0}}};
  else
    pgdh[63:0] <= pgdh[63:0];
end

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
    tlb_ne    <= 1'b1;
  end
  else if(tlbidx_local_en) begin
    tlb_index <= iui_regs_wdata[15:0];
    tlb_ps    <= iui_regs_wdata[29:24];
    tlb_ne    <= iui_regs_wdata[31]; 
  end
  else begin
    tlb_index <= tlb_index;
    tlb_ps    <= tlb_ps;
    tlb_ne    <= tlb_ne; 
  end
end


assign csrtlbidx_value[63:0] = {{32'b0}, tlb_ne, 1'b0, tlb_ps, 8'b0, tlb_index};

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
    ptbase      <= iui_regs_wdata[4:0];
    ptwidth     <= iui_regs_wdata[9:5];
    dir1_base   <= iui_regs_wdata[14:10];
    dir1_width  <= iui_regs_wdata[19:15];
    dir2_base   <= iui_regs_wdata[24:20];
    dir2_width  <= iui_regs_wdata[29:25];
    ptewidth    <= iui_regs_wdata[31:30];
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
    dir3_base   <= iui_regs_wdata[5 : 0];
    dir3_width  <= iui_regs_wdata[11: 6];
    dir4_base   <= iui_regs_wdata[17:12];
    dir4_width  <= iui_regs_wdata[23:18];
  end
  else begin
    dir3_base   <= dir3_base;
    dir3_width  <= dir3_width;
    dir4_base   <= dir4_base;
    dir4_width  <= dir4_width;
  end
end

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
    stlbps_ps   <= iui_regs_wdata[5 : 0];
  end
  else begin
    stlbps_ps   <= stlbps_ps;
  end
end

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
    rvacfg_rbits   <= iui_regs_wdata[3 : 0];
  end
  else begin
    rvacfg_rbits   <= rvacfg_rbits;
  end
end

assign csrrvacfg_value[63:0] = {{60'b0}, rvacfg_rbits};


//==========================================================
//               Define the TID register
//==========================================================
reg [63:0] tid;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tid[63:0] <= 64'b0;
  else if(tid_local_en)
    tid[63:0] <= {iui_regs_wdata[63:0]};
  else
    tid[63:0] <= tid[63:0];
end

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
    tcfg_initval[61:0] <= iui_regs_wdata[63:2];
    tcfg_periodic      <= iui_regs_wdata[1];
  end

`ifdef CPU_CHECKPOINT
  else if(cpcsr_tcfg_local_en) begin
    tcfg_initval[61:0] <= iui_regs_wdata[63:2];
    tcfg_periodic      <= iui_regs_wdata[1];
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
    tcfg_en   <= iui_regs_wdata[0];
  end

`ifdef CPU_CHECKPOINT
  else if(cpcsr_tcfg_local_en) begin
    tcfg_en   <= iui_regs_wdata[0];
  end
`endif

  else if(tcfg_en && (csrtval_value == 64'h0) && !tcfg_periodic) begin
    tcfg_en   <= 1'b0;
  end
  else begin
    tcfg_en   <= tcfg_en;
  end
end

assign csrtcfg_value[63:0] = {tcfg_initval, tcfg_periodic, tcfg_en};



//==========================================================
//               Define the TICLR register
//==========================================================

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    timer_clr  <= 1'b0;
  else if(ticlr_local_en)
    timer_clr  <= {iui_regs_wdata[0]};
  else if (timer_clr)
    timer_clr  <= 1'b0;
  else
    timer_clr  <= timer_clr;
end

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
    tval[63:0] <= {iui_regs_wdata[63:2], {2'b0}};
  else if(tval_local_en)
    tval[63:0] <= {iui_regs_wdata[63:2], {2'b0}};
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
    cntc[63:0] <= {iui_regs_wdata[63:0]};
  else
    cntc[63:0] <= cntc[63:0];
end

assign csrcntc_value[63:0] = cntc[63:0];


//==========================================================
//               Define the TIMER register
//==========================================================
reg [63:0] timer;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    timer[63:0] <= 64'b0;
  else
    timer[63:0] <= timer[63:0] + 1'b1;
end 

assign csrtimer_value[63:0] = timer[63:0] + cntc[63:0];

// assign cp0_iu_timer[63:0]   = csrtimer_value[63:0];

//==========================================================
//               Define the SAVE0 register
//==========================================================
reg [63:0] save0;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    save0[63:0] <= 64'b0;
  else if(save0_local_en)
    save0[63:0] <= {iui_regs_wdata[63:0]};
  else
    save0[63:0] <= save0[63:0];
end

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
    save1[63:0] <= {iui_regs_wdata[63:0]};
  else
    save1[63:0] <= save1[63:0];
end

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
    save2[63:0] <= {iui_regs_wdata[63:0]};
  else
    save2[63:0] <= save2[63:0];
end

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
    save3[63:0] <= {iui_regs_wdata[63:0]};
  else
    save3[63:0] <= save3[63:0];
end

assign csrsave3_value[63:0] = save3[63:0];




//==========================================================
//               Define the TLBRENTRY register
//==========================================================
reg [63:0] tlbr_entry;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    tlbr_entry[63:0] <= 64'b0;
  else if(tlbrentry_local_en)
    tlbr_entry[63:0] <= {iui_regs_wdata[63:12], {12'b0}};
  else
    tlbr_entry[63:0] <= tlbr_entry[63:0];
end

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
    tlbrehi_ps       <= iui_regs_wdata[5:0];
    tlbrehi_vppn     <= iui_regs_wdata[39:13];
    tlbrehi_sign_ext <= iui_regs_wdata[63:40];
  end
  else begin
    tlbrehi_ps       <= tlbrehi_ps;
    tlbrehi_vppn     <= tlbrehi_vppn;
    tlbrehi_sign_ext <= tlbrehi_sign_ext;
  end
end

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
    merr_entry[63:0] <= {iui_regs_wdata[63:12], {12'b0}};
  else
    merr_entry[63:0] <= merr_entry[63:0];
end

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
    dmw0_plv0      <= iui_regs_wdata[0];
    dmw0_plv1      <= iui_regs_wdata[1];
    dmw0_plv2      <= iui_regs_wdata[2];
    dmw0_plv3      <= iui_regs_wdata[3];
    dmw0_mat[1:0]  <= iui_regs_wdata[5:4];
    dmw0_vseg[3:0] <= iui_regs_wdata[63:60];
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
    dmw1_plv0      <= iui_regs_wdata[0];
    dmw1_plv1      <= iui_regs_wdata[1];
    dmw1_plv2      <= iui_regs_wdata[2];
    dmw1_plv3      <= iui_regs_wdata[3];
    dmw1_mat[1:0]  <= iui_regs_wdata[5:4];
    dmw1_vseg[3:0] <= iui_regs_wdata[63:60];
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
    dmw2_plv0      <= iui_regs_wdata[0];
    dmw2_plv1      <= iui_regs_wdata[1];
    dmw2_plv2      <= iui_regs_wdata[2];
    dmw2_plv3      <= iui_regs_wdata[3];
    dmw2_mat[1:0]  <= iui_regs_wdata[5:4];
    dmw2_vseg[3:0] <= iui_regs_wdata[63:60];
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
    dmw3_plv0      <= iui_regs_wdata[0];
    dmw3_plv1      <= iui_regs_wdata[1];
    dmw3_plv2      <= iui_regs_wdata[2];
    dmw3_plv3      <= iui_regs_wdata[3];
    dmw3_mat[1:0]  <= iui_regs_wdata[5:4];
    dmw3_vseg[3:0] <= iui_regs_wdata[63:60];
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

assign csrdmw3_value[63:0] = {dmw3_vseg[3:0], {54{1'b0}}, dmw3_mat[1:0], dmw3_plv3,
                              dmw3_plv2, dmw3_plv1, dmw3_plv0};


//==========================================================
//               Define the PRCFG1 register
//==========================================================
wire [3:0] savenum = 4'd4;
wire [7:0] timerbits = 8'd0;
wire [2:0] vsmax = 3'd7;

assign csrprcfg1_value[63:0] = {{32'b0, 17'b0}, vsmax, timerbits, savenum};



//==========================================================
//               Define the PRCFG2 register
//==========================================================
wire [63:0] psval;

assign psval[10:0]  = 11'b0;
assign psval[11]    = 1'b1;
assign psval[63:12] = 52'b0;

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
assign stlbway[5:0]     = 6'd0;

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
    debug_ld_va_reg[63:0] <= {iui_regs_wdata[63:0]};
  // else if(lsu_cp0_ld_vld)
  //   debug_ld_va_reg[63:0] <= {64'b0};
  else
    debug_ld_va_reg[63:0] <= debug_ld_va_reg[63:0];
end

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
    debug_ld_pa_reg[63:0] <= {iui_regs_wdata[63:0]};
  // else if(lsu_cp0_ld_vld)
  //   debug_ld_pa_reg[63:0] <= {64'b0};
  else
    debug_ld_pa_reg[63:0] <= debug_ld_pa_reg[63:0];
end

assign debug1_value[63:0] = debug_ld_pa_reg[63:0];


//==========================================================
//               Define the Wave debug register
//==========================================================

reg [63:0] debug_wave_dump_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    debug_wave_dump_reg[63:0] <= 64'b0;
  else if(dgwavedump_local_en)
    debug_wave_dump_reg[63:0] <= {iui_regs_wdata[63:0]};
  else if(|debug_wave_dump_reg[63:0])
    debug_wave_dump_reg[63:0] <= 64'b0;
  else
    debug_wave_dump_reg[63:0] <= debug_wave_dump_reg[63:0];
end

assign debug_wave_dump_value[63:0] = debug_wave_dump_reg[63:0];


//==========================================================
//           Define the ChechPoint Restore Register
//==========================================================

reg [63:0] cpcsr_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cpcsr_reg[63:0] <= 64'b0;
  else if(cpcsr_local_en)
    cpcsr_reg[63:0] <= {iui_regs_wdata[63:0]};
  else
    cpcsr_reg[63:0] <= cpcsr_reg[63:0];
end

assign cpcsr_value[63:0] = cpcsr_reg[63:0];

assign regs_iui_cprs[63:0] = cpcsr_value[63:0];

//==========================================================
//       Define the ChechPoint Restore Register(CRMD)
//==========================================================

reg [63:0] cpcsr_crmd_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cpcsr_crmd_reg[63:0] <= 64'b0;
  else if(cpcsr_crmd_local_en)
    cpcsr_crmd_reg[63:0] <= {iui_regs_wdata[63:0]};
  else
    cpcsr_crmd_reg[63:0] <= cpcsr_crmd_reg[63:0];
end

assign cpcsr_crmd_value[63:0] = cpcsr_crmd_reg[63:0];



//==========================================================
//               Define the MWPC register
//==========================================================
reg [63:0] mwpc_reg;  
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mwpc_reg[63:0] <= 64'b0;
  else if(mwpc_local_en)
    mwpc_reg[63:0] <= {iui_regs_wdata[63:0]};
  else
    mwpc_reg[63:0] <= mwpc_reg[63:0];
end

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
    mwps_reg[63:0] <= {iui_regs_wdata[63:0]};
  else
    mwps_reg[63:0] <= mwps_reg[63:0];
end

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
    fwpc_reg[63:0] <= {iui_regs_wdata[63:0]};
  else
    fwpc_reg[63:0] <= fwpc_reg[63:0];
end

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
    fwps_reg[63:0] <= {iui_regs_wdata[63:0]};
  else
    fwps_reg[63:0] <= fwps_reg[63:0];
end

assign fwps_value[63:0] = fwps_reg[63:0];


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
    fcsr0_reg[63:0]  <= {iui_regs_wdata[63:0]};
  else if(fcsr1_local_en)
    fcsr0_reg[4:0]   <= iui_regs_wdata[4:0];     // enable
  else if(fcsr2_local_en) begin
    fcsr0_reg[28:24] <= iui_regs_wdata[28:24]; // cause
    fcsr0_reg[20:16] <= iui_regs_wdata[20:16]; // flags    
  end
  else if (rtu_cp0_fflags_updt) begin
    // if split inst, cause will accumulate
    fcsr0_reg[28:24] <= fcsr0_reg[28:24] & {5{rtu_cp0_split_vld}} | rtu_cp0_fflags[4:0]; // cause
    fcsr0_reg[20:16] <= fcsr0_reg[20:16] | rtu_cp0_fflags[4:0]; // flags (accumulate)
  end    
  else if(fcsr3_local_en)
    fcsr0_reg[9:8] <= iui_regs_wdata[9:8];     // rm
  else
    fcsr0_reg[63:0] <= fcsr0_reg[63:0];
end

assign cp0_vpu_fflags_enable = fcsr0_reg[4:0];

wire [4:0] fcsr0_flags;
// fcsr0_reg[20:16]
assign fcsr0_flags[4:0] = fcsr0_reg[4:0];

assign fcsr0_value[63:0] = fcsr0_reg[63:0];
assign fcsr1_value[63:0] = {32'b0, 27'b0, fcsr0_reg[4:0]};
assign fcsr2_value[63:0] = {32'b0, 3'b0,  fcsr0_reg[28:24], 3'b0, fcsr0_flags[4:0], 16'b0};
assign fcsr3_value[63:0] = {32'b0, 22'b0, fcsr0_reg[9:8], 8'b0};


// always @(fcsr_frm[2:0])
// begin
//   rv_la_rm[1:0] = 2'b00; 
//   casez(fcsr_frm[2:0])
//     3'b000  : rv_la_rm[1:0] = 2'b00; // rne
//     3'b001  : rv_la_rm[1:0] = 2'b01; // rz
//     3'b011  : rv_la_rm[1:0] = 2'b10; // rp
//     3'b010  : rv_la_rm[1:0] = 2'b11; // rn
//     default : rv_la_rm[1:0] = 2'bxx; 
//   endcase
// end


always @(iui_regs_wdata[9:8])
begin
  la_rv_rm[2:0] = 3'b111; 
  casez(iui_regs_wdata[9:8])
    2'b00   : la_rv_rm[2:0] = 3'b000; // rne
    2'b01   : la_rv_rm[2:0] = 3'b001; // rz
    2'b10   : la_rv_rm[2:0] = 3'b011; // rn
    2'b11   : la_rv_rm[2:0] = 3'b010; // rp
    default : la_rv_rm[2:0] = 3'bxxx; 
  endcase
end



//==========================================================
//                    CPUCFG 0 Register
//==========================================================
// cpu464
// wire [63:0] cpucfg_0_value = {40'b0, 8'h14, 12'hc00, 1'b0, cpuid_value[2:0]};

// cpu164
wire [63:0] cpucfg_0_value = {40'b0, 8'h14, 12'h900, 1'b0, cpuid_value[2:0]};

//==========================================================
//                    CPUCFG 1 Register
//==========================================================
wire [1:0] cpucfg_1_arch       = 2'b10;
wire       cpucfg_1_pgmmu      = 1'b1;
wire       cpucfg_1_iocsr      = 1'b0;
wire [7:0] cpucfg_1_palen      = 8'd38;
wire [7:0] cpucfg_1_valen      = 8'd47;
wire       cpucfg_1_ual        = 1'b1; // TODO:
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
wire [2:0] cpucfg_2_fp_ver     = 3'b1; 
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

wire        cpucfg_6_pmp     = 1'b0; // TODO: Add Performance Counters
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
wire       cpucfg_10_l2iu_present    = 1'b0;
wire       cpucfg_10_l2iu_unify      = 1'b0;
wire       cpucfg_10_l2iu_private    = 1'b0;
wire       cpucfg_10_l2iu_inclusive  = 1'b0;
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
//                    CPUCFG 11 Register (L1IC 32KB)
//==========================================================
wire [15:0] cpucfg_11_way         = 16'd2;
wire [ 8:0] cpucfg_11_index       = 8'd8;   // 2^8
wire [ 6:0] cpucfg_11_line_size   = 7'd6;   // 2^6 
wire [63:0] cpucfg_11_value       = {{33'b0},
                                    cpucfg_11_line_size[6:0],
                                    cpucfg_11_index[7:0],
                                    cpucfg_11_way[15:0]};

//==========================================================
//                    CPUCFG 12 Register (L1DC 32KB)
//==========================================================
wire [15:0] cpucfg_12_way         = 16'd4;
wire [ 8:0] cpucfg_12_index       = 8'd7;   // 2^7
wire [ 6:0] cpucfg_12_line_size   = 7'd6;   // 2^6 
wire [63:0] cpucfg_12_value       = {{33'b0},
                                    cpucfg_12_line_size[6:0],
                                    cpucfg_12_index[7:0],
                                    cpucfg_12_way[15:0]};

//==========================================================
//                    CPUCFG 13 Register (L2C 0MB)
//==========================================================
wire [15:0] cpucfg_13_way         = 16'd0;
wire [ 8:0] cpucfg_13_index       = 8'd0;  // 2^0
wire [ 6:0] cpucfg_13_line_size   = 7'd0;   // 2^0 
wire [63:0] cpucfg_13_value       = {{33'b0},
                                    cpucfg_13_line_size[6:0],
                                    cpucfg_13_index[7:0],
                                    cpucfg_13_way[15:0]};


always @(iui_regs_csr_cpucfg_op[5:0]
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
  case(iui_regs_csr_cpucfg_op[5:0])
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
//                 Trap Setup and Handling
//==========================================================
//----------------------------------------------------------
//                    Machine Trap Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mstatus    | M status register.  |                    |
// | medeleg    | M expt delegation.  |                    |
// | mideleg    | M int delegation.   |                    |
// | mie        | M int enable.       |                    |
// | mtvec      | M trap handle addr. |                    |
// |------------|---------------------|--------------------|
// ps. misa in info_csr;
//     mcounteren in hpcp_csr.

//----------------------------------------------------------
//                    Machine Trap Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | mscratch   | Scrratch for M trap.|                    |
// | mepc       | M expt pc.          |                    |
// | mcause     | M trap cause.       |                    |
// | mtval      | M bad addr or inst. |                    |
// | mip        | M int pedning.    . |                    |
// |------------|---------------------|--------------------|

//----------------------------------------------------------
//                  Supervisor Trap Setup
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | sstatus    | S status register.  |                    |
// | sie        | S int enable.       |                    |
// | stvec      | S trap handle addr. |                    |
// |------------|---------------------|--------------------|
// ps. U-mode trap is not support, sedeleg and sideleg is not exist.
//    scounteren in hpcp_csr.

//----------------------------------------------------------
//                 Supervisor Trap Handling
//----------------------------------------------------------
// |------------|---------------------|--------------------|
// |    Name    |    Description      |        Note        |
// |------------|---------------------|--------------------|
// | sscratch   | Scrratch for S trap.|                    |
// | sepc       | S expt pc.          |                    |
// | scause     | S trap cause.       |                    |
// | stval      | S bad addr or inst. |                    |
// | sip        | S int pedning.    . |                    |
// |------------|---------------------|--------------------|

//==========================================================
//                    Define the MSTATUS
//==========================================================
// Machine Status Register
// 64-bit Machine Mode Read/Write
// Providing the CPU Status
// the definiton for MSTATUS register is listed as follows
// ===============================================================
// |63|62 40| 39|38 36|35 34|33 32|31 25|24 23| 22|21| 20| 19| 18|
// +--+-----+---+-----+-----+-----+-----+-----+---+--+---+---+---+
// |SD| Res |MPV| Res | SXL | UXL | Res | VS  |TSR|TM|TVM|MXR|SUM|
// ===============================================================
// ===================================================================
// | 17 |16 15|14 13|12 11|10 9| 8 |  7 | 6 |  5 | 4 | 3 | 2 | 1 | 0 |
// +----+-----+-----+-----+----+---+----+---+----+---+---+---+---+---+
// |MPRV| Res | FS  | MPP | Res|SPP|MPIE|Res|SPIE|Res|MIE|Res|SIE|Res|
// ===================================================================
assign sd = vs[1:0] == 2'b11 || fs_reg[1:0] == 2'b11 || xs[1:0] == 2'b11;

assign mpv = 1'b0;

assign sxl[1:0] = regs_mxl[1:0];

assign uxl[1:0] = regs_mxl[1:0];

// &Force("input", "rtu_cp0_vs_dirty_updt"); @134
// &Force("input", "rtu_cp0_vs_dirty_updt_dp"); @135
assign vs = 2'b0;
assign vs_dirty_upd_gate = 1'b0;
assign vxrm_local_en = 1'b0;
assign vxsat_local_en = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    tsr  <= 1'b0;
    tw   <= 1'b0;
    tvm  <= 1'b0;
    mprv <= 1'b0;
  end
  else if(mstatus_local_en)
  begin
    tsr  <= iui_regs_wdata[22];
    tw   <= iui_regs_wdata[21];
    tvm  <= iui_regs_wdata[20];
    mprv <= iui_regs_wdata[17];
  end
  else
  begin
    tsr  <= tsr;
    tw   <= tw;
    tvm  <= tvm;
    mprv <= mprv;
  end
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    mxr  <= 1'b0;
    sum  <= 1'b0;
  end
  else if(mstatus_local_en)
  begin
    mxr  <= iui_regs_wdata[19];
    sum  <= iui_regs_wdata[18];
  end
  else if(sstatus_local_en)
  begin
    mxr  <= iui_regs_wdata[19];
    sum  <= iui_regs_wdata[18];
  end
  else
  begin
    mxr  <= mxr;
    sum  <= sum;
  end
end

assign xs[1:0] = 2'b00;

assign fs_dirty_upd_gate = rtu_cp0_fs_dirty_updt_dp && (fs[1:0] == 2'b1 || fs[1:0] == 2'b10);
assign fs_dirty_upd = (rtu_cp0_fs_dirty_updt
                    || fcsr_local_en
                    || frm_local_en
                    || fflags_local_en
                    || fxcr_local_en
                    || vxrm_local_en
                    || vxsat_local_en)
                   && (fs[1:0] == 2'b1 || fs[1:0] == 2'b10);

always @(posedge float_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fs_reg[1:0] <= 2'b0;
  else if(mstatus_local_en)
    fs_reg[1:0] <= iui_regs_wdata[14:13];
  else if(sstatus_local_en)
    fs_reg[1:0] <= iui_regs_wdata[14:13];
  else if(fs_dirty_upd)
    fs_reg[1:0] <= 2'b11;
  else
    fs_reg[1:0] <= fs_reg[1:0];
end

assign fs[1:0] = fs_reg[1:0];
assign fs_off = fpe == 2'b0;


// PM field in mxstatus.
assign pm_wen = rtu_yy_xx_expt_vld
                || iui_regs_inst_mret
                || iui_regs_inst_sret
                || rtu_cp0_exit_debug;

// &CombBeg; @235
always @( mdeleg_vld_dp
       or pm[1:0]
       or sstatus_spp
       or rtu_cp0_exit_debug
       or iui_regs_inst_sret
       or dtu_cp0_dcsr_prv[1:0]
       or mpp[1:0]
       or iui_regs_inst_mret)
begin
  if(rtu_cp0_exit_debug)
    pm_wdata[1:0] = dtu_cp0_dcsr_prv[1:0];
  else if(iui_regs_inst_mret)
    pm_wdata[1:0] = mpp[1:0];
  else if(iui_regs_inst_sret)
    pm_wdata[1:0] = {1'b0, sstatus_spp};
  else if(!mdeleg_vld_dp)
    pm_wdata[1:0] = 2'b11;
  else if(mdeleg_vld_dp)
    pm_wdata[1:0] = 2'b01;
  else
    pm_wdata[1:0] = pm[1:0];
// &CombEnd; @248
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pm_bits[1:0] <= 2'b11;
  else if(pm_wen)
    pm_bits[1:0] <= pm_wdata[1:0];
  else
    pm_bits[1:0] <= pm_bits[1:0];
end

//when in debug mode, all op should executed at m mode priv level
assign pm[1:0] = pm_bits[1:0] | {2{rtu_yy_xx_dbgon}};

assign regs_mpp_write_ill = iui_regs_wdata[12:11] == 2'b10; 

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpp[1:0] <= 2'b11;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mpp[1:0] <= pm[1:0];
  else if(iui_regs_inst_mret)
    mpp[1:0] <= 2'b00;
  else if(mstatus_local_en && regs_mpp_write_ill)
    mpp[1:0] <= 2'b00;
  else if(mstatus_local_en)
    mpp[1:0] <= iui_regs_wdata[12:11];
  else
    mpp[1:0] <= mpp[1:0];
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    spp <= 1'b1;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    spp <= pm[0];
  else if(iui_regs_inst_sret)
    spp <= 1'b0;
  else if(mstatus_local_en)
    spp <= iui_regs_wdata[8];
  else if(sstatus_local_en)
    spp <= iui_regs_wdata[8];
  else
    spp <= spp;
end

assign sstatus_spp = spp;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mpie <= 1'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mpie <= mie_bit;
  else if(iui_regs_inst_mret)
    mpie <= 1'b1;
  else if(mstatus_local_en)
    mpie <= iui_regs_wdata[7];
  else
    mpie <= mpie;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    spie <= 1'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    spie <= sie_bit;
  else if(iui_regs_inst_sret)
    spie <= 1'b1;
  else if(mstatus_local_en)
    spie <= iui_regs_wdata[5];
  else if(sstatus_local_en)
    spie <= iui_regs_wdata[5];
  else
    spie <= spie;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mie_bit <= 1'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mie_bit <= 1'b0;
  else if(iui_regs_inst_mret)
    mie_bit <= mpie;
  else if(mstatus_local_en)
    mie_bit <= iui_regs_wdata[3];
  else
    mie_bit <= mie_bit;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sie_bit <= 1'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    sie_bit <= 1'b0;
  else if(iui_regs_inst_sret)
    sie_bit <= spie;
  else if(mstatus_local_en)
    sie_bit <= iui_regs_wdata[1];
  else if(sstatus_local_en)
    sie_bit <= iui_regs_wdata[1];
  else
    sie_bit <= sie_bit;
end

assign mstatus_value[63:0]  = {sd, 23'b0, mpv, 3'b0, sxl[1:0], uxl[1:0], 7'b0, vs[1:0],
                               tsr, tw, tvm, mxr, sum, mprv, 
                               xs[1:0], fs_reg[1:0], mpp[1:0], 2'b0, spp,
                               mpie, 1'b0, spie, 1'b0, mie_bit, 1'b0, sie_bit, 1'b0};

//==========================================================
//                    Define the SSTATUS
//==========================================================
//  Supervisor Status Register
//  64-bit Supervisor Mode Read/Write
//  Providing the CPU Status
//  the definiton for SSTATUS register is listed as follows
//==========================================================
assign sstatus_value[63:0]  = {sd, 29'b0, uxl[1:0], 7'b0, vs[1:0], 3'b0,
                               mxr, sum, 1'b0, xs[1:0], fs_reg[1:0],
                               4'b0, sstatus_spp, 2'b0, spie, 1'b0,
                               2'b0, sie_bit, 1'b0};

//==========================================================
//                    Define the MEDELEG
//==========================================================
//  Machine Exception Delegation Register
//  64-bit Machine Mode Read/Write
//  Providing the CPU Status
//  the definiton for MEDELEG register is listed as follows
//==========================================================
assign edeleg_upd_val[15:0] = {iui_regs_wdata[15], 1'b0, 
                               iui_regs_wdata[13:12], 2'b0,
                               iui_regs_wdata[9:0]};

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    edeleg[15:0] <= 16'b0;
  else if(medeleg_local_en)
    edeleg[15:0] <= edeleg_upd_val[15:0];
  else
    edeleg[15:0] <= edeleg[15:0];
end
assign medeleg_value[63:0] = {48'b0, edeleg[15:0]};

// decode the vector value
// &CombBeg; @401
always @( rtu_yy_xx_expt_vec[4:0])
begin
case(rtu_yy_xx_expt_vec[4:0])
  5'd1:    vec_num[18:0] = 19'h0002;
  5'd2:    vec_num[18:0] = 19'h0004;
  5'd3:    vec_num[18:0] = 19'h0008;
  5'd4:    vec_num[18:0] = 19'h0010;
  5'd5:    vec_num[18:0] = 19'h0020;
  5'd6:    vec_num[18:0] = 19'h0040;
  5'd7:    vec_num[18:0] = 19'h0080;
  5'd8:    vec_num[18:0] = 19'h0100;
  5'd9:    vec_num[18:0] = 19'h0200;
  5'd11:   vec_num[18:0] = 19'h0800;
  5'd12:   vec_num[18:0] = 19'h1000;
  5'd13:   vec_num[18:0] = 19'h2000;
  5'd15:   vec_num[18:0] = 19'h8000;
  5'd16:   vec_num[18:0] = 19'h10000;
  5'd17:   vec_num[18:0] = 19'h20000;
  5'd18:   vec_num[18:0] = 19'h40000;
  default: vec_num[18:0] = 19'h0;
endcase
// &CombEnd; @421
end

// medeleg valid when cpu in s-mode and vector hit
assign medeleg_vld_dp = (pm[1] == 1'b0) && !rtu_yy_xx_expt_int
                 && |(vec_num[15:0] & edeleg[15:0]);

//==========================================================
//                    Define the MIDELEG
//==========================================================
//  Machine Interrupt Delegation Register
//  64-bit Machine Mode Read/Write
//  Providing the CPU Status
//  the definiton for MIDELEG register is listed as follows
//  mhie for pc trace Halt int
//  moie for hpm Overflow int
//  mcie for error Correction int
//==========================================================
assign mhie_deleg = 1'b0;

assign mcie_deleg = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    moie_deleg <= 1'b0;
    seie_deleg <= 1'b0;
    stie_deleg <= 1'b0;
    ssie_deleg <= 1'b0;
  end
  else if(mideleg_local_en)
  begin
    moie_deleg <= iui_regs_wdata[17];
    seie_deleg <= iui_regs_wdata[9];
    stie_deleg <= iui_regs_wdata[5];
    ssie_deleg <= iui_regs_wdata[1];
  end
  else
  begin
    moie_deleg <= moie_deleg;
    seie_deleg <= seie_deleg;
    stie_deleg <= stie_deleg;
    ssie_deleg <= ssie_deleg;
  end
end

assign mideleg[63:0] = {45'b0, mhie_deleg, moie_deleg, mcie_deleg,
                        6'b0, seie_deleg, 1'b0,
                        2'b0, stie_deleg, 1'b0,
                        2'b0, ssie_deleg, 1'b0};

assign mideleg_value[63:0] = mideleg[63:0];

// mideleg valid when cpu in s-mode/u-mode and vector hit
assign mideleg_vld_dp = (pm[1] == 1'b0) && rtu_yy_xx_expt_int
                 && |(vec_num[18:0] & mideleg[18:0]);

assign mdeleg_vld_dp = medeleg_vld_dp || mideleg_vld_dp;

//==========================================================
//                      Define the MIE
//==========================================================
//  Machine Interrupt Enable Register
//  64-bit Machine Mode Read/Write
//  Providing the Interrupt Local Enable of the current core
//  the definiton for MIE register is listed as follows
//==========================================================
assign mhie = 1'b0;

assign mcie = 1'b0;

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    moie <= 1'b0;
    meie <= 1'b0;
    seie <= 1'b0;
    mtie <= 1'b0;
    stie <= 1'b0;
    msie <= 1'b0;
    ssie <= 1'b0;
  end
  else if(mie_local_en)
  begin
    moie <= iui_regs_wdata[17];
    meie <= iui_regs_wdata[11];
    seie <= iui_regs_wdata[9];
    mtie <= iui_regs_wdata[7];
    stie <= iui_regs_wdata[5];
    msie <= iui_regs_wdata[3];
    ssie <= iui_regs_wdata[1];
  end
  else if(sie_local_en)
  begin
    moie <= moip_acc_en ? iui_regs_wdata[17] : moie;
    meie <= meie;
    seie <= seip_acc_en ? iui_regs_wdata[9] : seie;
    mtie <= mtie;
    stie <= stip_acc_en ? iui_regs_wdata[5] : stie;
    msie <= msie;
    ssie <= ssip_acc_en ? iui_regs_wdata[1] : ssie;
  end
  else
  begin
    moie <= moie;
    meie <= meie;
    seie <= seie;
    mtie <= mtie;
    stie <= stie;
    msie <= msie;
    ssie <= ssie;
  end
end
 
assign mie_value[63:0] =  {45'b0, mhie, moie, mcie, 4'b0, 
                                  meie, 1'b0, seie, 1'b0, 
                                  mtie, 1'b0, stie, 1'b0, 
                                  msie, 1'b0, ssie, 1'b0}; 

//==========================================================
//                      Define the SIE
//==========================================================
//  Supervisor Interrupt Enable Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Interrupt Local Enable of the current core
//  the definiton for SIE register is listed as follows
//==========================================================
assign sie_value[63:0] =  {45'b0, mhie && mhip_acc_en,
                            moie && moip_acc_en, mcie && mcip_acc_en,
                            6'b0, seie && seip_acc_en, 1'b0, 
                            2'b0, stie && stip_acc_en, 1'b0, 
                            2'b0, ssie && ssip_acc_en, 1'b0}; 

//==========================================================
//                     Define the MTVEC
//==========================================================
//  Machine Trap Vector Register
//  64-bit Machine Mode Read/Write
//  Providing the Trap Vector Base and Mode 
//  the definiton for MTVEC register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtvec_mode[1:0] <= 2'b0;
  else if(mtvec_local_en)
    mtvec_mode[1:0] <= iui_regs_wdata[1:0];
  else
    mtvec_mode[1:0] <= mtvec_mode[1:0];
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtvec_base[61:0] <= 62'b0;
  else if(mtvec_local_en)
    mtvec_base[61:0] <= iui_regs_wdata[63:2];
  else
    mtvec_base[61:0] <= mtvec_base[61:0];
end

assign mtvec_value[63:0] = {mtvec_base[61:0], 1'b0, mtvec_mode[0]};
// &Force("output", "mtvec_value"); &Force("bus", "mtvec_value", 63, 0); @664

//==========================================================
//                     Define the STVEC
//==========================================================
//  Supervisor Trap Vector Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Trap Vector Base and Mode 
//  the definiton for STVEC register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    stvec_mode[1:0] <= 2'b0;
  else if(stvec_local_en)
    stvec_mode[1:0] <= iui_regs_wdata[1:0];
  else
    stvec_mode[1:0] <= stvec_mode[1:0];
end

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    stvec_base[61:0] <= 62'b0;
  else if(stvec_local_en)
    stvec_base[61:0] <= iui_regs_wdata[63:2];
  else
    stvec_base[61:0] <= stvec_base[61:0];
end

assign stvec_value[63:0] = {stvec_base[61:0], 1'b0, stvec_mode[0]};
// &Force("output", "stvec_value"); &Force("bus", "stvec_value", 63, 0); @695

//==========================================================
//                   Define the MSCRATCH
//==========================================================
//  Machine Scratch Register
//  64-bit Machine Mode Read/Write
//  Providing the Software Scratch register
//  the definiton for MSCRATCH register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mscratch[63:0] <= 64'b0;
  else if(mscratch_local_en)
    mscratch[63:0] <= iui_regs_wdata[63:0];
  else
    mscratch[63:0] <= mscratch[63:0];
end

assign mscratch_value[63:0] = mscratch[63:0];

//==========================================================
//                   Define the SSCRATCH
//==========================================================
//  Supervisor Scratch Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Software Scratch register
//  the definiton for SSCRATCH register is listed as follows
//==========================================================
always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sscratch[63:0] <= 64'b0;
  else if(sscratch_local_en)
    sscratch[63:0] <= iui_regs_wdata[63:0];
  else
    sscratch[63:0] <= sscratch[63:0];
end

assign sscratch_value[63:0] = sscratch[63:0];

//==========================================================
//                     Define the MEPC
//==========================================================
//  Machine Exception PC Register
//  64-bit Machine Mode Read/Write
//  Providing the Machine Exception PC Register
//  the definiton for MEPC register is listed as follows
//==========================================================
// &Force("bus", "rtu_cp0_epc", 63, 0); @745
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mepc_reg[62:0] <= 63'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    mepc_reg[62:0] <= rtu_cp0_epc[63:1];
  else if(mepc_local_en)
    mepc_reg[62:0] <= iui_regs_wdata[63:1];
  else
    mepc_reg[62:0] <= mepc_reg[62:0];
end

assign mepc_value[63:0] = {mepc_reg[62:0], 1'b0};

//==========================================================
//                     Define the SEPC
//==========================================================
//  Supervisor Exception PC Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Supervisor Exception PC Register
//  the definiton for SEPC register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    sepc_reg[62:0] <= 63'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    sepc_reg[62:0] <= rtu_cp0_epc[63:1];
  else if(sepc_local_en)
    sepc_reg[62:0] <= iui_regs_wdata[63:1];
  else
    sepc_reg[62:0] <= sepc_reg[62:0];
end

assign sepc_value[63:0] = {sepc_reg[62:0], 1'b0};

//==========================================================
//                    Define the MCAUSE
//==========================================================
//  Machine CAUSE Register
//  64-bit Machine Mode Read/Write
//  Providing the Machine Trap Cause register
//  the definiton for MCAUSE register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    m_intr <= 1'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    m_intr <= rtu_yy_xx_expt_int;
  else if(mcause_local_en)
    m_intr <= iui_regs_wdata[63];
  else
    m_intr <= m_intr;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    m_vector[4:0] <= 5'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp)
    m_vector[4:0] <= rtu_yy_xx_expt_vec[4:0];
  else if(mcause_local_en)
    m_vector[4:0] <= iui_regs_wdata[4:0];
  else
    m_vector[4:0] <= m_vector[4:0];
end

assign mcause_value[63:0]  = {m_intr, 58'b0, m_vector[4:0]};

//==========================================================
//                    Define the SCAUSE
//==========================================================
//  Supervisor CAUSE Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Supervisor Trap Cause register
//  the definiton for SCAUSE register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    s_intr <= 1'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    s_intr <= rtu_yy_xx_expt_int;
  else if(scause_local_en)
    s_intr <= iui_regs_wdata[63];
  else
    s_intr <= s_intr;
end

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    s_vector[4:0] <= 5'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp)
    s_vector[4:0] <= rtu_yy_xx_expt_vec[4:0];
  else if(scause_local_en)
    s_vector[4:0] <= iui_regs_wdata[4:0];
  else
    s_vector[4:0] <= s_vector[4:0];
end

assign scause_value[63:0] = {s_intr, 58'b0, s_vector[4:0]};

//==========================================================
//                     Define the MTVAL
//==========================================================
//  Machine Trap value Register
//  64-bit Machine Mode Read/Write
//  Providing the trap value register
//  the definiton for MTVAL register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mtval_data[63:0] <= 64'b0;
  else if(rtu_yy_xx_expt_vld && !mdeleg_vld_dp) 
    mtval_data[63:0] <= rtu_cp0_tval[63:0];
  else if(mtval_local_en)
    mtval_data[63:0] <= iui_regs_wdata[63:0];
  else
    mtval_data[63:0] <= mtval_data[63:0];
end

assign mtval_value[63:0] = mtval_data[63:0];

//==========================================================
//                     Define the STVAL
//==========================================================
//  Supervisor Trap value Register
//  64-bit Supervisor Mode Read/Write
//  Providing the trap value register
//  the definiton for STVAL register is listed as follows
//==========================================================
always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    stval_data[63:0] <= 64'b0;
  else if(rtu_yy_xx_expt_vld && mdeleg_vld_dp) 
    stval_data[63:0] <= rtu_cp0_tval[63:0];
  else if(stval_local_en)
    stval_data[63:0] <= iui_regs_wdata[63:0];
  else
    stval_data[63:0] <= stval_data[63:0];
end

assign stval_value[63:0] = stval_data[63:0];

//==========================================================
//                      Define the MIP
//==========================================================
//  Machine Interrupt Pending Register
//  64-bit Machine Mode Read/Write
//  Providing the Interrupt Pending of the current core
//  the definiton for MIP register is listed as follows
//==========================================================
assign mhip_acc_en = mideleg[18];
assign moip_acc_en = mideleg[17];
assign mcip_acc_en = mideleg[16];
assign seip_acc_en = mideleg[9];
assign stip_acc_en = mideleg[5];
assign ssip_acc_en = mideleg[1];

always @(posedge regs_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    seip_reg <= 1'b0;
    stip_reg <= 1'b0;
    ssip_reg <= 1'b0;
  end
  else if(mip_local_en)
  begin
    seip_reg <= iui_regs_wdata[9];
    stip_reg <= iui_regs_wdata[5];
    ssip_reg <= iui_regs_wdata[1];
  end
  else if(sip_local_en && ssip_acc_en)
  begin
    seip_reg <= seip_reg;
    stip_reg <= stip_reg;
    ssip_reg <= iui_regs_wdata[1];
  end
  else
  begin
    seip_reg <= seip_reg;
    stip_reg <= stip_reg;
    ssip_reg <= ssip_reg;
  end
end
  
assign mhip = 1'b0;
assign moip = hpcp_cp0_int_vld;
// assign mcip = ecc_int_vld;
assign mcip = 1'b0;
assign meip = biu_cp0_me_int;
assign mtip = biu_cp0_mt_int;
assign msip = biu_cp0_ms_int;

assign seip = biu_cp0_se_int || seip_reg;
assign stip = biu_cp0_st_int && regs_clintee || stip_reg;
assign ssip = biu_cp0_ss_int && regs_clintee || ssip_reg;

assign mip_value[63:0] =  {45'b0, mhip, moip, mcip, 4'b0,
                                  meip, 1'b0, seip, 1'b0, 
                                  mtip, 1'b0, stip, 1'b0, 
                                  msip, 1'b0, ssip, 1'b0}; 

assign sip_raw[63:0] = {48'b0, 4'b0,
                               2'b0, seip_reg, 1'b0,
                               2'b0, stip_reg, 1'b0,
                               2'b0, ssip_reg, 1'b0};

//==========================================================
//                      Define the SIP
//==========================================================
//  Supervisor Interrupt Pending Register
//  64-bit Supervisor Mode Read/Write
//  Providing the Interrupt Pending of the current core
//  the definiton for SIP register is listed as follows
//==========================================================
assign sip_value[63:0] =  {45'b0, mhip && mhip_acc_en,
                            moip && moip_acc_en, mcip && mcip_acc_en,
                            6'b0, seip && seip_acc_en, 1'b0, 
                            2'b0, stip && stip_acc_en, 1'b0, 
                            2'b0, ssip && ssip_acc_en, 1'b0}; 

//==========================================================
//                      Int Judgement
//==========================================================
assign mhip_en = mhie && mhip;
assign moip_en = moie && moip;
assign mcip_en = mcie && mcip;
assign meip_en = meie && meip;
assign mtip_en = mtie && mtip;
assign msip_en = msie && msip;

assign seip_en = seie && seip;
assign stip_en = stie && stip;
assign ssip_en = ssie && ssip;

// For MEI, MTI, MSI: 
assign mhip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                        || pm[1:0] == 2'b01
                        || pm[1:0] == 2'b00)
                      && mhip_en && !mideleg[18];
assign moip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                        || pm[1:0] == 2'b01
                        || pm[1:0] == 2'b00)
                      && moip_en && !mideleg[17];
assign mcip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                        || pm[1:0] == 2'b01
                        || pm[1:0] == 2'b00)
                      && mcip_en && !mideleg[16];
assign mhip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                      || pm[1:0] == 2'b00)
                    && mhip_en && mideleg[18];
assign moip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                      || pm[1:0] == 2'b00)
                    && moip_en && mideleg[17];
assign mcip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                      || pm[1:0] == 2'b00)
                    && mcip_en && mideleg[16];
assign meip_vld = (pm[1:0] != 2'b11 || mie_bit) && meip_en;
assign mtip_vld = (pm[1:0] != 2'b11 || mie_bit) && mtip_en;
assign msip_vld = (pm[1:0] != 2'b11 || mie_bit) && msip_en;

// For SEI, STI, SSI: 
// M-Mode -> MIE Controlled when non-delegation;
// S-Mode -> SIE Controlled
// U-Mode -> Global always on
assign seip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                          || pm[1:0] == 2'b01
                          || pm[1:0] == 2'b00)
                        && seip_en && !mideleg[9];
assign stip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit 
                          || pm[1:0] == 2'b01
                          || pm[1:0] == 2'b00)
                        && stip_en && !mideleg[5];
assign ssip_nodeleg_vld = (pm[1:0] == 2'b11 && mie_bit
                          || pm[1:0] == 2'b01
                          || pm[1:0] == 2'b00)
                        && ssip_en && !mideleg[1];
assign seip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                        || pm[1:0] == 2'b00)
                      && seip_en && mideleg[9];
assign stip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                        || pm[1:0] == 2'b00)
                      && stip_en && mideleg[5];
assign ssip_deleg_vld = (pm[1:0] == 2'b01 && sie_bit
                        || pm[1:0] == 2'b00)
                      && ssip_en && mideleg[1];

assign lpmd_ack_vld = meip_en || mtip_en || msip_en || moip_en || mcip_en
                   || seip_en || stip_en || ssip_en;

//==========================================================
//                  Trap Address Generate
//==========================================================
assign regs_tvec[39:0]  = pm[1:0] == 2'b11 ? mtvec_value[39:0]
                                           : stvec_value[39:0];

assign regs_vector[4:0] = pm[1:0] == 2'b11 ? m_vector[4:0]
                                           : s_vector[4:0];

assign regs_intr        = pm[1:0] == 2'b11 ? m_intr
                                           : s_intr;

assign vec_int_pc[39:0] = {regs_tvec[39:2], 2'b0}
                        + {33'b0, regs_vector[4:0], 2'b0};

assign regs_trap_pc[39:0] = regs_intr && regs_tvec[0] ? vec_int_pc[39:0]
                                                      : {regs_tvec[39:2], 2'b0};

//==========================================================
//                     HPCP information
//==========================================================
assign int_off_vld = (pm[1:0] == 2'b11) && !mie_bit
                  || (pm[1:0] == 2'b01) && !sie_bit;

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign regs_pm[1:0] = crmd_plv[1:0];
assign regs_tvm     = tvm;
assign regs_fs_off  = fs_off;

assign regs_iui_tsr     = tsr;
assign regs_iui_tvm     = tvm;
assign regs_iui_tw      = tw;
assign regs_iui_pm[1:0] = crmd_plv[1:0];

assign regs_iui_era[63:0]  = csrera_value[63:0];
assign regs_iui_mepc[63:0] = {24'b0, mepc_reg[38:0], 1'b0};
assign regs_iui_sepc[63:0] = {24'b0, sepc_reg[38:0], 1'b0};

assign regs_lpmd_int_vld = lpmd_ack_vld;

assign regs_iui_rdtime[63:0] = csrtimer_value[63:0];

//----------------------------------------------------------
//                          For XX
//----------------------------------------------------------
assign cp0_yy_priv_mode[1:0] = crmd_plv[1:0];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
wire [63:0] trap_value;
wire [ 2:0] expt_mode;
wire [15:0] expt_tmp_off;
wire [17:0] expt_page_offset;
wire [61:0] expt_pc_plus_offset;
wire [62:0] expt_virtual_pc;

reg  [14:0] expt_ecode;

always @(posedge regs_flush_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    expt_ecode[14:0]  <=  15'b0;
  end
  else if(rtu_yy_xx_expt_vld) begin
    expt_ecode[14:0]  <=  rtu_yy_xx_expt_vec[14:0];
  end
  else begin
    expt_ecode[14:0]  <=  expt_ecode[14:0];
  end
end


// page_offset = 2^(ecfg.vs+2)
assign expt_mode[2:0]            =  ecfg_vs[2:0];
assign expt_tmp_off[15:0]        =  {8'b0, expt_ecode[7:0]} << ecfg_vs[2:0];
assign expt_page_offset[17:0]    =  {expt_tmp_off[15:0], 2'b0};
assign expt_pc_plus_offset[61:0] =  csreentry_value[63:2] | {{46{1'b0}}, expt_page_offset[17:2]};
assign expt_virtual_pc[62:0]     =  (expt_mode[2:0] != 3'b0) 
                                    ? {expt_pc_plus_offset[61:0], 1'b0}                                       
                                    : {csreentry_value[63:2], 1'b0};

assign trap_value[63:0]          =  {expt_virtual_pc[62:0], 1'b0};

assign cp0_rtu_int_vld[14:0] = int_sel[14:0];
assign cp0_rtu_trap_pc[63:0] = trap_value[63:0];
assign cp0_rtu_ecfg_vs[2:0]  = evs[2:0];

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign cp0_idu_fs[1:0] = {1'b0, fpe};
assign cp0_idu_vs[1:0] = vs[1:0];

//----------------------------------------------------------
//                         For PMP
//----------------------------------------------------------
//assign cp0_pmp_mpp[1:0] = mpp[1:0];
//assign cp0_pmp_mprv     = mprv;

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_sum        = sum;
//assign cp0_mmu_mpp[1:0] = mpp[1:0];
//assign cp0_mmu_mprv     = mprv;
assign cp0_mmu_mxr        = mxr;

assign cp0_mmu_crmd_da    = crmd_da;
assign cp0_mmu_crmd_pg    = crmd_pg;

assign cp0_mmu_dmw0[63:0] = csrdmw0_value[63:0];
assign cp0_mmu_dmw1[63:0] = csrdmw1_value[63:0];
assign cp0_mmu_dmw2[63:0] = csrdmw2_value[63:0];
assign cp0_mmu_dmw3[63:0] = csrdmw3_value[63:0];

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign cp0_lsu_mpp[1:0] = prmd_pplv[1:0];
assign cp0_lsu_mprv     = rtu_yy_xx_dbgon ? dtu_cp0_dcsr_mprven && mprv : mprv;

//----------------------------------------------------------
//                         For HAD
//----------------------------------------------------------
assign cp0_dtu_mexpt_vld = rtu_yy_xx_expt_vld && !mdeleg_vld_dp;

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
assign cp0_hpcp_int_off_vld = int_off_vld;


//==========================================================
//                   Check DiffTest
//==========================================================

`ifdef CHECK_DIFFTEST
DifftestCSRRegState DifftestCSRRegState(
    .clock              (regs_clk               ),
    .coreid             ('0                     ),
    .crmd               (csrcrmd_value[63:0]    ),
    .prmd               (csrprmd_value[63:0]    ),
    .euen               (csreuen_value[63:0]    ),
    .ecfg               (csrecfg_value[63:0]    ),
    .estat              (csrestat_value[63:0]   ),
    .era                (csrera_value[63:0]     ),
    .badv               (csrbadv_value[63:0]    ),
    .eentry             (csreentry_value[63:0]  ),
    .tlbidx             (csrtlbidx_value[63:0]  ),
    .tlbehi             (64'b0                  ),
    .tlbelo0            (64'b0                  ),
    .tlbelo1            (64'b0                  ),
    .asid               (csrasid_value[63:0]    ),
    .pgdl               (csrpgdl_value[63:0]    ),
    .pgdh               (csrpgdh_value[63:0]    ),
    .save0              (csrsave0_value[63:0]   ),
    .save1              (csrsave1_value[63:0]   ),
    .save2              (csrsave2_value[63:0]   ),
    .save3              (csrsave3_value[63:0]   ),
    .tid                (csrtid_value[63:0]     ),
    .tcfg               (csrtcfg_value[63:0]    ),
    .tval               (csrtval_value[63:0]    ),
    .ticlr              (csrticlr_value[63:0]   ),
    .llbctl             (64'b0                  ),
    .tlbrentry          (64'b0                  ),
    .dmw0               (csrdmw0_value[63:0]    ),
    .dmw1               (csrdmw1_value[63:0]    )
);
`endif



// &ModuleEnd; @1155
endmodule



