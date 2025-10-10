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

// &Depend("aq_dtu_cfig.h"); @23
// &Depend("cpu_cfig.h"); @24
// &ModuleBeg; @25
module aq_cp0_iui (
  // &Ports, @27
  input    wire          cpurst_b,
  input    wire          idu_cp0_ex1_dp_sel,
  input    wire  [5 :0]  idu_cp0_ex1_dst0_reg,
  input    wire          idu_cp0_ex1_expt_acc_error,
  input    wire          idu_cp0_ex1_expt_high,
  input    wire          idu_cp0_ex1_expt_illegal,
  input    wire          idu_cp0_ex1_expt_illegal_fp,
  input    wire          idu_cp0_ex1_expt_page_fault,
  input    wire  [19:0]  idu_cp0_ex1_func,
  input    wire          idu_cp0_ex1_gateclk_sel,
  input    wire  [21:0]  idu_cp0_ex1_halt_info,
  input    wire          idu_cp0_ex1_length,
  input    wire  [31:0]  idu_cp0_ex1_opcode,
  input    wire          idu_cp0_ex1_sel,
  input    wire          idu_cp0_ex1_split,
  input    wire  [63:0]  idu_cp0_ex1_src0_data,
  input    wire  [63:0]  idu_cp0_ex1_src1_data,
  input    wire          ifu_cp0_warm_up,
  input    wire  [63:0]  iu_cp0_ex1_cur_pc,
  input    wire          iui_inst_vsetvl_decd,
  input    wire          regs_clk,
  input    wire          regs_iui_csr_inv,
  input    wire          regs_iui_mcins_stall,
  input    wire          regs_iui_mcor_stall,
  input    wire  [63:0]  regs_iui_era,
  input    wire  [63:0]  regs_iui_mepc,
  input    wire  [1 :0]  regs_iui_pm,
  input    wire  [63:0]  regs_iui_rdata,
  input    wire  [63:0]  regs_iui_rdtime,
  input    wire  [63:0]  regs_iui_cfg_data,
  input    wire  [63:0]  regs_iui_rdata_for_w,
  input    wire  [63:0]  regs_iui_sepc,
  input    wire  [63:0]  regs_iui_cprs,
  input    wire          regs_iui_smcir_stall,
  input    wire          regs_iui_trigger_mro,
  input    wire          regs_iui_trigger_smode,
  input    wire          regs_iui_tsr,
  input    wire          regs_iui_tvm,
  input    wire          regs_iui_tw,
  input    wire          rtu_yy_xx_dbgon,
  input    wire          special_iui_stall,
  input    wire  [63:0]  special_iui_vsetvl_wdata,
  input    wire          vidu_cp0_vid_fof_vld,
  output   wire  [11:0]  cp0_dtu_addr,
  output   wire          cp0_dtu_rreg,
  output   wire  [63:0]  cp0_dtu_wdata,
  output   wire          cp0_dtu_wreg,
  output   wire  [11:0]  cp0_hpcp_index,
  output   wire  [63:0]  cp0_hpcp_wdata,
  output   wire          cp0_hpcp_wreg,
  output   wire          cp0_idu_issue_stall,
  output   wire          cp0_idu_vsetvl_dis_stall,
  output   wire  [11:0]  cp0_mmu_addr,
  output   wire  [63:0]  cp0_mmu_wdata,
  output   wire          cp0_mmu_wreg,
  output   wire  [11:0]  cp0_pmp_addr,
  output   wire  [63:0]  cp0_pmp_wdata,
  output   wire          cp0_pmp_wreg,
  output   wire          cp0_rtu_ex1_chgflw,
  output   wire  [63:0]  cp0_rtu_ex1_chgflw_pc,
  output   wire          cp0_rtu_ex1_cmplt,
  output   wire          cp0_rtu_ex1_cmplt_dp,
  output   wire  [63:0]  cp0_rtu_ex1_expt_tval,
  output   wire  [14:0]  cp0_rtu_ex1_expt_vec,
  output   wire          cp0_rtu_ex1_expt_vld,
  output   wire          cp0_rtu_ex1_flush,
  output   wire  [21:0]  cp0_rtu_ex1_halt_info,
  output   wire          cp0_rtu_ex1_inst_ertn,
  output   wire          cp0_rtu_ex1_inst_dret,
  output   wire          cp0_rtu_ex1_inst_ebreak,
  output   wire          cp0_rtu_ex1_inst_len,
  output   wire          cp0_rtu_ex1_inst_mret,
  output   wire          cp0_rtu_ex1_inst_split,
  output   wire          cp0_rtu_ex1_inst_sret,
  output   wire          cp0_rtu_ex1_vs_dirty,
  output   wire          cp0_rtu_ex1_vs_dirty_dp,
  output   wire  [63:0]  cp0_rtu_ex1_wb_data,
  output   wire          cp0_rtu_ex1_wb_dp,
  output   wire  [5 :0]  cp0_rtu_ex1_wb_preg,
  output   wire          cp0_rtu_ex1_wb_vld,
  output   wire  [63:0]  iui_inst_rs2,
  output   wire  [5 :0]  iui_regs_csr_cpucfg_op,
  output   wire          iui_regs_csr_en,
  output   wire          iui_regs_csr_wen,
  output   wire          iui_regs_csr_wen_no_imm_ill,
  output   wire          iui_regs_csr_write,
  output   wire          iui_regs_csr_write_no_imm_ill,
  output   wire  [11:0]  iui_regs_imm,
  output   wire          iui_regs_inst_ertn,
  output   wire          iui_regs_inst_mret,
  output   wire          iui_regs_inst_sret,
  output   wire          iui_regs_inst_cprs,
  output   wire  [63:0]  iui_regs_wdata,
  output   wire          iui_special_cache,
  output   wire  [5 :0]  iui_special_cache_func,
  output   wire          iui_special_fence,
  output   wire          iui_special_fencei,
  output   wire  [63:0]  iui_special_rs1,
  output   wire          iui_special_rs1_x0,
  output   wire  [63:0]  iui_special_rs2,
  output   wire          iui_special_rs2_x0,
  output   wire          iui_special_sfence,
  output   wire          iui_special_sync,
  output   wire          iui_special_synci,
  output   wire          iui_special_vsetvl,
  output   wire          iui_special_vsetvl_dp,
  output   wire  [63:0]  iui_special_vsetvl_rs1,
  output   wire  [11:0]  iui_special_vsetvl_rs2,
  output   wire          iui_special_wfi,
  output   wire          iui_vsetvl_bypass,
  output   wire  [4 :0]  iui_vsetvl_data
); 



// &Regs; @28
reg             iui_csr_wen_f;                
reg     [63:0]  iui_expt_tval;                
reg     [3 :0]  iui_expt_vec;                 

// &Wires; @29
wire            iui_accflt_expt;              
wire            iui_cancel;                   
wire    [63:0]  iui_chgflw_pc;                
wire            iui_csr_expt_vld;             
wire            iui_csr_expt_vld_no_imm_ill;  
wire    [63:0]  iui_csr_rdata;                
wire    [63:0]  iui_csr_rs1;                  
wire    [63:0]  iui_csr_src0;                  
wire            iui_csr_stall;                
wire    [63:0]  iui_csr_wdata;                
wire            iui_csr_wen;                  
wire            iui_csr_wen_vld;              
wire            iui_csr_wen_vld_no_imm_ill;   
wire            iui_csr_write_inv;            
wire            iui_csr_write_no_imm_ill;     
wire    [63:0]  iui_csrrc_rs1;                
wire    [63:0]  iui_csrrs_rs1;                
wire    [63:0]  iui_csrrw_rs1;                
wire    [63:0]  iui_csrwr_rs0;                
wire    [63:0]  iui_csrxchg_rs0;                
wire    [63:0]  iui_ex1_expt_pc;              
wire    [63:0]  iui_ex1_pc;                   
wire            iui_expt_vld;                 
wire            iui_idu_expt_vld;             
wire            iui_ifu_expt_vld;             
wire            iui_illegal_expt;             
wire            iui_inst_cache;               
wire    [5 :0]  iui_inst_cache_func;          
wire            iui_inst_chgflw;              
wire            iui_inst_cmplt;               
wire            iui_inst_csr;                 
wire            iui_inst_iocsr;                 
wire            iui_inst_iocsrrd;                 
wire            iui_inst_iocsrwr;                 
wire    [2 :0]  iui_inst_csr_func;            
wire            iui_inst_dis_stall;           
wire            iui_inst_ertn;                
wire            iui_inst_cprs;                
wire            iui_inst_dret;                
wire            iui_inst_rdtime;
wire            iui_inst_rdtimelw;
wire            iui_inst_rdtimehw;
wire            iui_inst_rdtimed;
wire            iui_inst_cpucfg;
wire    [5 :0]  iui_inst_dst_idx;             
wire            iui_inst_dst_vld;             
wire            iui_inst_dst_vld_dp;          
wire            iui_inst_ebreak;              
wire            iui_inst_syscall;               
wire            iui_inst_fence;               
wire            iui_inst_fencei;              
wire            iui_inst_flush;               
wire    [19:0]  iui_inst_func;                
wire    [21:0]  iui_inst_halt_info;           
wire    [11:0]  iui_inst_imm;                 
wire            iui_inst_issue_stall;         
wire            iui_inst_mret;                
wire            iui_inst_nop;                 
wire    [31:0]  iui_inst_opcode;              
wire    [63:0]  iui_inst_rs1;                 
wire            iui_inst_rs1_x0;              
wire            iui_inst_rs2_x0;              
wire            iui_inst_sel;                 
wire            iui_inst_sel_dp;              
wire            iui_inst_sfence;              
wire            iui_inst_sret;                
wire            iui_inst_sync;                
wire            iui_inst_synci;               
wire            iui_inst_vld;                 
wire            iui_inst_vld_no_brir;         
wire            iui_inst_vsetvl;              
wire            iui_inst_vsetvl_dp;           
wire            iui_inst_vsetvl_raw;          
wire            iui_inst_wfi;                 
wire            iui_msyscall_expt;              
wire            iui_mmode;                    
wire            iui_pageflt_expt;             
wire            iui_ssyscall_expt;              
wire            iui_smode;                    
wire            iui_smode_csr_inv;            
wire            iui_smode_special_inv;        
wire            iui_special_expt_vld;         
wire            iui_usyscall_expt;              
wire            iui_umode;                    
wire            iui_umode_csr_inv;            
wire            iui_umode_special_inv;        
wire    [63:0]  iui_vsetvl_rs1;               
wire    [11:0]  iui_vsetvl_rs2;               
wire            iui_vsetvl_stall;             
wire    [63:0]  iui_wdata;    
wire    [63:0]  rdtime_val;
wire    [63:0]  cpucfg_val;
wire    [63:0]  cp0_misc_val;                
wire    [63:0]  regs_iui_iocsr_rdata;                
wire            iui_inst_csrrd;
wire            iui_inst_csrwr;
wire            iui_inst_csrxchg;
wire            cp0_inst_misc;

wire            rf_inst_movgr2fcsr_wr;
wire            rf_inst_movfcsr2gr_rd;
wire [1:0]      fcsr_addr;
wire [11:0]     lui_fcsr_addr;

//==========================================================
// CP0 IUI Module
// 1. Prepare CSR and Special Inst Information
// 2. Generate Retire and Exception Signals
//==========================================================

//==========================================================
//             Generate Instruction Information
//==========================================================
// Prepare CSR and Special Inst Information
//   1. Get the instruction functions
//   2. Generate CSR Inst Information
//   3. Generate Special Inst Information
//------------------------------------------------

//----------------------------------------------------------
//                  Instruction Functions
//----------------------------------------------------------
// &Force("input", "ifu_cp0_warm_up"); @49
assign iui_inst_sel          = idu_cp0_ex1_gateclk_sel && !iui_idu_expt_vld && !iui_cancel;
assign iui_inst_sel_dp       = idu_cp0_ex1_dp_sel && !iui_idu_expt_vld && !iui_cancel;
assign iui_inst_vld          = iui_inst_sel;
assign iui_inst_vld_no_brir  = idu_cp0_ex1_sel && !iui_idu_expt_vld && !iui_cancel;
assign iui_inst_func[19:0]   = {20{iui_inst_sel}} & idu_cp0_ex1_func[19:0];
assign iui_inst_dst_vld      = iui_inst_csr && (iui_inst_csrwr
                                                || iui_inst_csrrd
                                                || iui_inst_csrxchg)
                               || iui_inst_iocsrrd
                               || cp0_inst_misc
                               || iui_inst_vsetvl;

assign iui_inst_dst_vld_dp   = iui_inst_csr && (iui_inst_csrwr
                                             || iui_inst_csrrd
                                             || iui_inst_csrxchg) 
                            || iui_inst_iocsrrd
                            || cp0_inst_misc
                            || iui_inst_vsetvl_dp;

assign iui_inst_dst_idx[5:0] = {6{iui_inst_sel}} & idu_cp0_ex1_dst0_reg[5:0];
assign iui_inst_rs1[63:0]    = {64{iui_inst_sel}} & idu_cp0_ex1_src0_data[63:0];
assign iui_inst_rs2[63:0]    = {64{iui_inst_sel}} & idu_cp0_ex1_src1_data[63:0];
assign iui_inst_imm[11:0]    = {12{iui_inst_sel}} & idu_cp0_ex1_opcode[21:10];
assign iui_vsetvl_data[4:0]  = iui_inst_func[3] && iui_inst_func[9] ? idu_cp0_ex1_opcode[24:20]
                                                                    : idu_cp0_ex1_src0_data[4:0];
assign iui_vsetvl_bypass     = idu_cp0_ex1_gateclk_sel && iui_inst_vsetvl_decd;                                                                    
// &Force("bus", "idu_cp0_ex1_src1_data", 63, 0); @64
assign iui_inst_opcode[31:0] = {32{idu_cp0_ex1_gateclk_sel}} & idu_cp0_ex1_opcode[31:0];
assign iui_inst_halt_info[`TDT_HINFO_WIDTH-1:0] =
  {`TDT_HINFO_WIDTH{idu_cp0_ex1_gateclk_sel}} & idu_cp0_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];

assign iui_inst_rs1_x0 = iui_inst_sel && iui_inst_opcode[9:5] == 5'b0;
assign iui_inst_rs2_x0 = iui_inst_sel && iui_inst_opcode[4:0] == 5'b0;

assign iui_regs_csr_cpucfg_op[5:0] = iui_inst_rs1[5:0]; // cpucfg

//----------------------------------------------------------
//                    Generate CSR Inst
//----------------------------------------------------------
assign iui_inst_csrrd   = (iui_inst_func[8:0] == 9'b101101100); //csrrd
assign iui_inst_csrwr   = (iui_inst_func[8:0] == 9'b101101101); //csrwr
assign iui_inst_csrxchg = (iui_inst_func[8:0] == 9'b101101110); //csrxchg

assign iui_inst_iocsrrd = (iui_inst_func[8:0] == 9'b101111110); //iocsrrd
assign iui_inst_iocsrwr = (iui_inst_func[8:0] == 9'b101111111); //iocsrwr

assign iui_inst_csr = idu_cp0_ex1_sel && (  iui_inst_csrrd
                                         || iui_inst_csrwr
                                         || iui_inst_csrxchg);

assign iui_inst_iocsr = iui_inst_iocsrrd || iui_inst_iocsrwr;

assign iui_csr_wen  = iui_inst_csr && (iui_inst_csrwr || iui_inst_csrxchg || rf_inst_movgr2fcsr_wr) && (!iui_inst_rs2_x0 || rf_inst_movgr2fcsr_wr);

always @ (posedge regs_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    iui_csr_wen_f <= 1'b0;
  else if (iui_csr_wen && iui_csr_stall)
    iui_csr_wen_f <= 1'b1;
  else
    iui_csr_wen_f <= 1'b0;
end

assign iui_csr_wen_vld = iui_csr_wen && !iui_csr_wen_f
                                     && !iui_csr_expt_vld;

assign iui_csr_wen_vld_no_imm_ill = iui_csr_wen && !iui_csr_wen_f
                                                && !iui_csr_expt_vld_no_imm_ill;
assign iui_csr_write_no_imm_ill   = iui_csr_wen && !iui_csr_expt_vld_no_imm_ill;

// csr_func[0]: CSRRW
// csr_func[1]: CSRRS
// csr_func[2]: CSRRC
assign iui_inst_csr_func[2:0] = {3{iui_inst_func[0]}}
                              & idu_cp0_ex1_func[6:4];

//----------- CSR write data -----------
assign iui_csr_rdata[63:0] = regs_iui_rdata_for_w[63:0];
assign iui_csr_src0[63:0]  = iui_inst_rs2[63:0];

/// TODO: iocsrrd data 
assign regs_iui_iocsr_rdata[63:0] = 64'b0;

assign iui_csrwr_rs0[63:0]   = iui_inst_rs2[63:0];

assign iui_csrxchg_rs0[63:0] = iui_csr_rdata[63:0] & (~iui_inst_rs1[63:0]) | // n-rd 
                               iui_inst_rs2[63:0]  & ( iui_inst_rs1[63:0]);  // o-rd

assign iui_csrrc_rs1[63:0] = iui_csr_rdata[63:0] & (~iui_inst_rs1[63:0]);

assign iui_csr_wdata[63:0] = {64{iui_inst_csrwr  }} & iui_csrwr_rs0[63:0]
                           | {64{iui_inst_csrxchg}} & iui_csrxchg_rs0[63:0]
                           | {64{rf_inst_movgr2fcsr_wr}} & iui_inst_rs1[63:0];

//----------------------------------------------------------
//                  Generate Special Inst
//----------------------------------------------------------
//------------- Fence Inst -------------
assign iui_inst_fence  = iui_inst_vld && (iui_inst_func[8:0] == 9'b101000111); // dbar
assign iui_inst_fencei = iui_inst_vld && (iui_inst_func[8:0] == 9'b101000011); // ibar
assign iui_inst_sfence = iui_inst_vld && (iui_inst_func[8:0] == 9'b100101001); // invtlb
assign iui_inst_sync   = iui_inst_vld && 1'b0;
assign iui_inst_synci  = iui_inst_vld && (iui_inst_func[8:0] == 9'b100000100);

// cacop inst
assign iui_inst_cache  = iui_inst_vld && ((iui_inst_func[8:0] == 9'b101110001)    // l1icacop
                                          || (iui_inst_func[8:0] == 9'b101111001) // l1dcacop
                                          || (iui_inst_func[8:0] == 9'b100101101) // l2cacop
                                         );

wire l1icacop_inst = iui_inst_vld && (iui_inst_func[8:0] == 9'b101110001);
wire l1dcacop_inst = iui_inst_vld && (iui_inst_func[8:0] == 9'b101111001);
wire l2cacop_inst  = iui_inst_vld && (iui_inst_func[8:0] == 9'b100101101);


// `define FUNC_DCACHE_IALL   6'b00_01_01
// `define FUNC_DCACHE_CALL   6'b00_10_01
// `define FUNC_DCACHE_CIALL  6'b00_11_01
// `define FUNC_DCACHE_ISW    6'b01_01_01
// `define FUNC_DCACHE_CSW    6'b01_10_01
// `define FUNC_DCACHE_CISW   6'b01_11_01
// `define FUNC_ICACHE_IVA    6'b10_01_10
// `define FUNC_ICACHE_IPA    6'b11_01_10

assign iui_inst_cache_func[5:0] =   {6{l1icacop_inst}} & 6'b00_11_01
                                  | {6{l1dcacop_inst}} & 6'b00_11_01
                                  | {6{l2cacop_inst }} & 6'b00_11_01;

//------------ Special Inst ------------
assign iui_inst_syscall  = iui_inst_vld && (iui_inst_func[8:0] == 9'b101001001) && !rtu_yy_xx_dbgon;
assign iui_inst_ebreak   = iui_inst_vld && (iui_inst_func[8:0] == 9'b101001010);
assign iui_inst_mret     = iui_inst_vld && 1'b0 && !rtu_yy_xx_dbgon;
assign iui_inst_sret     = iui_inst_vld && 1'b0 && !rtu_yy_xx_dbgon;
assign iui_inst_wfi      = iui_inst_vld && 1'b0 && !rtu_yy_xx_dbgon;
assign iui_inst_dret     = iui_inst_vld && 1'b0 && rtu_yy_xx_dbgon;

assign iui_inst_ertn     = iui_inst_vld && (iui_inst_func[8:0] == 9'b100101010) // ertn
                           && !rtu_yy_xx_dbgon;

assign iui_inst_cprs     = iui_inst_vld && (iui_inst_func[8:0] == 9'b100101011) // cprs
                           && !rtu_yy_xx_dbgon;

assign iui_inst_rdtimelw = iui_inst_vld && (iui_inst_func[8:0] == 9'b101001101) && !rtu_yy_xx_dbgon;
assign iui_inst_rdtimehw = iui_inst_vld && (iui_inst_func[8:0] == 9'b101001110) && !rtu_yy_xx_dbgon;
assign iui_inst_rdtimed  = iui_inst_vld && (iui_inst_func[8:0] == 9'b101001111) && !rtu_yy_xx_dbgon;
assign iui_inst_cpucfg   = iui_inst_vld && (iui_inst_func[8:0] == 9'b101001000) && !rtu_yy_xx_dbgon;


//------------ Vector Inst -------------
// &Force("nonport", "iui_inst_vld_no_brir"); @160
// &Force("nonport", "iui_inst_sel_dp"); @161
assign iui_inst_vsetvl     = 1'b0;
assign iui_inst_vsetvl_raw = 1'b0;
assign iui_inst_vsetvl_dp  = 1'b0;
// &Force("output","iui_inst_rs2"); @166
// vector inst rs1 in src1, rs2 in src0
assign iui_vsetvl_rs1[63:0]  = iui_inst_rs2[63:0];
assign iui_vsetvl_rs2[11:0]  = iui_inst_func[3] && iui_inst_func[9] ?
                                            {1'b0, iui_inst_opcode[30:20]}
                                          : iui_inst_rs1[11:0];

//-------------- NOP Inst --------------
assign iui_inst_nop    = iui_inst_vld && !(|iui_inst_func[2:0]);

//==========================================================
//                  Cmplt and Expt Signal
//==========================================================
assign iui_mmode = regs_iui_pm[1:0] == 2'b00;
assign iui_smode = regs_iui_pm[1:0] == 2'b01;
assign iui_umode = regs_iui_pm[1:0] == 2'b11;

//----------------------------------------------------------
//                           Expt
//----------------------------------------------------------
//--------- Special Inst Expt ----------
// 1. s mode inv
//   a. mret
//   b. sret && tsr
//   c. wfi && tw
//   d. sfence && tvm
// 2. U mode inv
//   1. mret
//   2. sret
//   3. wfi
//   4. sfence
// 3. syscall
// 4. vsetvl && !vs (in idu)
assign iui_smode_special_inv = iui_smode
                           && (iui_inst_mret
                            || iui_inst_ertn
                            || iui_inst_sret   && regs_iui_tsr
                            || iui_inst_wfi    && regs_iui_tw
                            || iui_inst_sfence && regs_iui_tvm);

assign iui_umode_special_inv = iui_umode
                           && (iui_inst_mret
                            || iui_inst_ertn
                            || iui_inst_sret
                            || iui_inst_wfi
                            || iui_inst_sfence);

assign iui_special_expt_vld = iui_umode_special_inv
                           || iui_smode_special_inv
                           || iui_inst_syscall;


//----------- CSR Inst Expt ------------
// 1. access M csr in Smode
// 2. access M, S csr in Umode
// 3. write read only CSR
// 4. regs_iui_expt
//   a. csr addr inv
//   b. !FS && float csr
//   c. !VS && vector_csr
//   d. S mode stap && tvm
//   e. scounter ucounter inv.

assign iui_csr_write_inv = iui_csr_wen && (iui_inst_imm[11:10] == 2'b11
                                           || regs_iui_trigger_mro)
                          && !rf_inst_movgr2fcsr_wr;

assign iui_smode_csr_inv = iui_smode
                        && iui_inst_csr && (iui_inst_imm[11:10] == 2'b11
                                            && !regs_iui_trigger_smode)
                        && !rf_inst_movfcsr2gr_rd && !rf_inst_movgr2fcsr_wr;

assign iui_umode_csr_inv = iui_umode
                        && iui_inst_csr && iui_inst_imm[11:10] != 2'b11
                        && !rf_inst_movfcsr2gr_rd && !rf_inst_movgr2fcsr_wr;

assign iui_csr_expt_vld = iui_smode_csr_inv
                       || iui_umode_csr_inv
                       || regs_iui_csr_inv && iui_inst_csr
                       || iui_csr_write_inv;

assign iui_csr_expt_vld_no_imm_ill = iui_smode_csr_inv
                                  || iui_umode_csr_inv
                                  || iui_csr_write_inv;

// Expt Source:
//   1. expt from idu
//   2. special inst expt
//   3. CSR inst expt

assign iui_ifu_expt_vld = idu_cp0_ex1_expt_page_fault
                       || idu_cp0_ex1_expt_acc_error;

assign iui_idu_expt_vld = iui_ifu_expt_vld
                       || idu_cp0_ex1_expt_illegal;

assign iui_cancel   = iui_inst_halt_info[`TDT_HINFO_CANCEL]
                      && idu_cp0_ex1_gateclk_sel;

assign iui_expt_vld = (iui_idu_expt_vld
                    || iui_special_expt_vld
                    || iui_csr_expt_vld)
                    && idu_cp0_ex1_gateclk_sel;

assign iui_pageflt_expt   = idu_cp0_ex1_expt_page_fault;
assign iui_accflt_expt    = idu_cp0_ex1_expt_acc_error;
assign iui_illegal_expt   = idu_cp0_ex1_expt_illegal
                            || iui_special_expt_vld
                            || iui_csr_expt_vld;
assign iui_msyscall_expt  = iui_inst_syscall && iui_mmode;
assign iui_ssyscall_expt  = iui_inst_syscall && iui_smode;
assign iui_usyscall_expt  = iui_inst_syscall && iui_umode;

// &CombBeg; @278
always @( iui_accflt_expt
       or iui_illegal_expt
       or iui_pageflt_expt
       or iui_ssyscall_expt
       or iui_idu_expt_vld
       or iui_usyscall_expt
       or iui_msyscall_expt
       or idu_cp0_ex1_expt_illegal
       or idu_cp0_ex1_expt_illegal_fp)
begin
  if (iui_pageflt_expt)
    iui_expt_vec[3:0] = 4'd3;
  else if (iui_accflt_expt)
    iui_expt_vec[3:0] = 4'd8;
  else if(iui_idu_expt_vld)begin
    if(idu_cp0_ex1_expt_illegal & idu_cp0_ex1_expt_illegal_fp) iui_expt_vec[3:0] = 4'd15;
    else iui_expt_vec[3:0] = 4'd13;
  end
  else if(iui_msyscall_expt)
    iui_expt_vec[3:0] = 4'd0;
  else if(iui_ssyscall_expt)
    iui_expt_vec[3:0] = 4'd0;
  else if(iui_usyscall_expt)
    iui_expt_vec[3:0] = 4'd11;
  else if(iui_illegal_expt)
    iui_expt_vec[3:0] = 4'd13;
  else
    iui_expt_vec[3:0] = 4'd0;
// &CombEnd; @295
end

assign iui_ex1_pc[63:0]      = {64{idu_cp0_ex1_gateclk_sel}} & iu_cp0_ex1_cur_pc[63:0];
assign iui_ex1_expt_pc[63:0] = iui_ex1_pc[63:0] + {{62{1'b0}}, idu_cp0_ex1_expt_high, 1'b0};

// &CombBeg; @301
always @( iui_accflt_expt
       or iui_pageflt_expt
       or iui_cancel
       or iui_ex1_expt_pc[63:0]
       or iui_inst_opcode[31:0])
begin
  if (iui_pageflt_expt || iui_accflt_expt || iui_cancel)
    iui_expt_tval[63:0] = iui_ex1_expt_pc[63:0];
  else
    iui_expt_tval[63:0] = {{32{1'b0}}, iui_inst_opcode[31:0]};
// &CombEnd; @306
end

//----------------------------------------------------------
//                          Stall
//----------------------------------------------------------
// Stall Source:
//   special stall:
//     1. cache inst stall
//     2. fence inst stall
//     2. lpmd stall
//   vsetvl stall
//   csr Stall
//     1. MMU
//     2. MCOR
assign iui_vsetvl_stall = iui_inst_vsetvl_raw && vidu_cp0_vid_fof_vld;

assign iui_csr_stall = regs_iui_smcir_stall
                    || regs_iui_mcor_stall
                    || regs_iui_mcins_stall;

assign iui_inst_issue_stall = special_iui_stall
                           || iui_vsetvl_stall
                           || iui_csr_stall;
//assign iui_inst_dis_stall   = iui_inst_vsetvl_raw;
assign iui_inst_dis_stall   = 1'b0;


//----------------------------------------------------------
//                          Flush
//----------------------------------------------------------
// Not Flush inst:
//   1. CSRR
//   2. SYNC
//   3. FENCE
//   3. expt
assign iui_inst_flush = !(iui_inst_csr && !iui_csr_wen
                       || iui_inst_fence
                       || iui_inst_sfence
                       || iui_inst_sync
                       || iui_inst_vsetvl_raw
                       || iui_inst_nop)
                       && iui_inst_sel && !iui_expt_vld && !iui_cancel;


//----------------------------------------------------------
//                        Changeflow
//----------------------------------------------------------
// Chgflow inst:
//  1. mret
//  2. sret
assign iui_inst_chgflw = (iui_inst_mret 
                          || iui_inst_ertn 
                          || iui_inst_cprs 
                          || iui_inst_sret)
                      && !iui_expt_vld && !iui_cancel;

assign iui_chgflw_pc[63:0] = iui_inst_ertn ?   regs_iui_era[63:0]
                                             : regs_iui_cprs[63:0];

//----------------------------------------------------------
//                          Cmplt
//----------------------------------------------------------
assign iui_inst_cmplt = idu_cp0_ex1_sel && !iui_inst_issue_stall;

//----------------------------------------------------------
//                         WB Data
//----------------------------------------------------------

assign iui_inst_rdtime    =    iui_inst_rdtimelw 
                            || iui_inst_rdtimehw 
                            || iui_inst_rdtimed;

assign rdtime_val[63:0]   =  {64{iui_inst_rdtimelw}} & {32'b0, regs_iui_rdtime[31:0]}
                           | {64{iui_inst_rdtimehw}} & {regs_iui_rdtime[63:32], 32'b0}
                           | {64{iui_inst_rdtimed}}  & {regs_iui_rdtime[63:0]};


assign cpucfg_val[63:0]   = regs_iui_cfg_data[63:0];


assign cp0_misc_val[63:0] =   {64{iui_inst_rdtime}} & {regs_iui_rdtime[63:0]}
                            | {64{iui_inst_cpucfg}} & {cpucfg_val[63:0]};

assign cp0_inst_misc      =    iui_inst_rdtime 
                            || iui_inst_cpucfg;

// 1. CSR rdata
// 2. vsetvl wdata
assign iui_wdata[63:0] = iui_inst_csr ? regs_iui_rdata[63:0] :
                                        iui_inst_iocsr ? regs_iui_iocsr_rdata[63:0] :
                                            cp0_inst_misc ? 
                                                cp0_misc_val[63:0]
                                              : special_iui_vsetvl_wdata[63:0];

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
// &Force("output","iui_regs_csr_en"); @381

assign rf_inst_movgr2fcsr_wr  = (idu_cp0_ex1_opcode[31:10] == 22'b0000000100010100110000); // movgr2fcsr  
assign rf_inst_movfcsr2gr_rd  = (idu_cp0_ex1_opcode[31:10] == 22'b0000000100010100110010); // movfcsr2gr
assign fcsr_addr[1:0]   =   {2{rf_inst_movgr2fcsr_wr}} &  idu_cp0_ex1_opcode[1:0] 
                          | {2{rf_inst_movfcsr2gr_rd}} &  idu_cp0_ex1_opcode[6:5];

assign lui_fcsr_addr[11:0] = {8'hf0, 2'b00, fcsr_addr[1:0]};

assign iui_regs_imm[11:0]   = rf_inst_movgr2fcsr_wr || rf_inst_movfcsr2gr_rd ? lui_fcsr_addr[11:0] : iui_inst_imm[11:0];
assign iui_regs_csr_wen     = iui_csr_wen_vld;
assign iui_regs_csr_wen_no_imm_ill = iui_csr_wen_vld_no_imm_ill;
assign iui_regs_csr_write   = iui_csr_wen;
assign iui_regs_csr_write_no_imm_ill = iui_csr_write_no_imm_ill;
assign iui_regs_csr_en      = iui_inst_csr && !iui_csr_expt_vld;
assign iui_regs_wdata[63:0] = iui_csr_wdata[63:0];

assign iui_regs_inst_ertn   = iui_inst_ertn && !iui_special_expt_vld;
assign iui_regs_inst_mret   = iui_inst_mret && !iui_special_expt_vld;
assign iui_regs_inst_sret   = iui_inst_sret && !iui_special_expt_vld;
assign iui_regs_inst_cprs   = iui_inst_cprs && !iui_special_expt_vld;

assign iui_special_fence    = iui_inst_fence  && !iui_special_expt_vld;
assign iui_special_fencei   = iui_inst_fencei && !iui_special_expt_vld;
assign iui_special_sfence   = iui_inst_sfence && !iui_special_expt_vld;
assign iui_special_sync     = iui_inst_sync   && !iui_special_expt_vld;
assign iui_special_synci    = iui_inst_synci  && !iui_special_expt_vld;
assign iui_special_wfi      = iui_inst_wfi    && !iui_special_expt_vld;
assign iui_special_cache    = iui_inst_cache  && !iui_special_expt_vld;
assign iui_special_vsetvl   = iui_inst_vsetvl;
assign iui_special_vsetvl_dp = iui_inst_vsetvl_raw;

// assign iui_special_imm[11:0] = iui_inst_imm[11:0];
assign iui_special_rs1[63:0] = iui_inst_rs1[63:0];
assign iui_special_rs1_x0 = iui_inst_rs1_x0;
assign iui_special_rs2[63:0] = iui_inst_rs2[63:0];
assign iui_special_rs2_x0 = iui_inst_rs2_x0;

assign iui_special_vsetvl_rs1[63:0] = iui_vsetvl_rs1[63:0];
assign iui_special_vsetvl_rs2[11:0] = iui_vsetvl_rs2[11:0];

assign iui_special_cache_func[5:0] = iui_inst_cache_func[5:0];

//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign cp0_rtu_ex1_cmplt           = iui_inst_cmplt;
assign cp0_rtu_ex1_cmplt_dp        = idu_cp0_ex1_dp_sel;
assign cp0_rtu_ex1_inst_len        = idu_cp0_ex1_length;
assign cp0_rtu_ex1_inst_split      = idu_cp0_ex1_split;
assign cp0_rtu_ex1_wb_dp           = iui_inst_dst_vld_dp;
assign cp0_rtu_ex1_wb_vld          = iui_inst_dst_vld && iui_inst_cmplt && !iui_expt_vld && !iui_cancel;
assign cp0_rtu_ex1_wb_preg[5:0]    = iui_inst_dst_idx[5:0];
assign cp0_rtu_ex1_wb_data[63:0]   = iui_wdata[63:0];
assign cp0_rtu_ex1_chgflw          = iui_inst_chgflw;
assign cp0_rtu_ex1_flush           = iui_inst_flush;
assign cp0_rtu_ex1_chgflw_pc[63:0] = iui_chgflw_pc[63:0];
assign cp0_rtu_ex1_inst_ebreak     = iui_inst_ebreak;
assign cp0_rtu_ex1_inst_ertn       = iui_inst_ertn;
assign cp0_rtu_ex1_inst_dret       = iui_inst_dret;
assign cp0_rtu_ex1_inst_mret       = iui_inst_mret;
assign cp0_rtu_ex1_inst_sret       = iui_inst_sret;
assign cp0_rtu_ex1_vs_dirty        = iui_inst_vsetvl;
assign cp0_rtu_ex1_vs_dirty_dp     = iui_inst_vsetvl_raw;

assign cp0_rtu_ex1_expt_vld             = iui_expt_vld && idu_cp0_ex1_dp_sel;
assign cp0_rtu_ex1_expt_vec[14:0]       = {11'b0, iui_expt_vec[3:0]};
assign cp0_rtu_ex1_expt_tval[63:0]      = iui_expt_tval[63:0];

assign cp0_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] = iui_inst_halt_info[`TDT_HINFO_WIDTH-1:0];

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign cp0_idu_vsetvl_dis_stall = iui_inst_dis_stall;
assign cp0_idu_issue_stall      = iui_inst_issue_stall;

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
assign cp0_hpcp_index[11:0] = iui_inst_imm[11:0];
assign cp0_hpcp_wreg        = iui_csr_wen_vld;
assign cp0_hpcp_wdata[63:0] = iui_csr_wdata[63:0];

//----------------------------------------------------------
//                         For PMP
//----------------------------------------------------------
assign cp0_pmp_addr[11:0]  = iui_inst_imm[11:0];
assign cp0_pmp_wreg        = iui_csr_wen_vld;
assign cp0_pmp_wdata[63:0] = iui_csr_wdata[63:0];

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign cp0_mmu_addr[11:0]  = iui_inst_imm[11:0];
assign cp0_mmu_wreg        = iui_csr_wen_vld;
assign cp0_mmu_wdata[63:0] = iui_csr_wdata[63:0];

//----------------------------------------------------------
//                         For DTU
//----------------------------------------------------------
assign cp0_dtu_wreg        = iui_csr_wen_vld;
assign cp0_dtu_rreg        = iui_regs_csr_en;
assign cp0_dtu_addr[11:0]  = iui_inst_imm[11:0];
assign cp0_dtu_wdata[63:0] = iui_csr_wdata[63:0];



// &ModuleEnd; @503
endmodule



