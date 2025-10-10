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
module aq_rtu_retire (
  // &Ports, @27
  input    wire          async_select_next_pc,
  input    wire          cp0_rtu_fence_idle,
  input    wire          cp0_rtu_icg_en,
  input    wire          cp0_rtu_in_lpmd,
  input    wire  [63:0]  cp0_rtu_trap_pc,
  input    wire          cp0_rtu_vstart_eq_0,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_retire_ex2_retire_vld,
  input    wire  [63:0]  dp_retire_ex2_cur_pc,
  input    wire          dp_retire_ex2_fs_dirty,
  input    wire  [21:0]  dp_retire_ex2_halt_info,
  input    wire          dp_retire_ex2_inst_branch,
  input    wire          dp_retire_ex2_inst_chgflw,
  input    wire          dp_retire_ex2_inst_dret,
  input    wire          dp_retire_ex2_inst_ebreak,
  input    wire          dp_retire_ex2_inst_expt,
  input    wire          dp_retire_ex2_inst_flush,
  input    wire          dp_retire_ex2_inst_ertn,
  input    wire          dp_retire_ex2_inst_mret,
  input    wire          dp_retire_ex2_inst_split,
  input    wire          dp_retire_ex2_inst_sret,
  input    wire          dp_retire_ex2_inst_vstart,
  input    wire  [63:0]  dp_retire_ex2_next_pc,
  input    wire  [63:0]  dp_retire_ex2_tval,
  input    wire  [14:0]  dp_retire_ex2_vec,
  input    wire          dp_retire_ex2_vs_dirty,
  input    wire  [6 :0]  dp_retire_ex2_vstart,
  input    wire          dtu_rtu_async_halt_req,
  input    wire  [63:0]  dtu_rtu_dpc,
  input    wire          dtu_rtu_ebreak_action,
  input    wire  [63:0]  dtu_rtu_pending_tval,
  input    wire          dtu_rtu_resume_req,
  input    wire          dtu_rtu_step_en,
  input    wire          dtu_rtu_sync_flush,
  input    wire          dtu_rtu_sync_halt_req,
  input    wire          forever_cpuclk,
  input    wire          hpcp_rtu_cnt_en,
  input    wire          ifu_rtu_reset_halt_req,
  input    wire          ifu_rtu_warm_up,
  input    wire  [14:0]  int_retire_int_vec,
  input    wire          int_retire_int_vld,
  input    wire          iu_rtu_depd_lsu_chgflow_vld,
  input    wire          iu_rtu_ex2_bju_ras_mispred,
  input    wire          iu_xx_no_op,
  input    wire          lsu_rtu_async_expt_vld,
  input    wire          lsu_rtu_async_ld_inst,
  input    wire  [39:0]  lsu_rtu_async_tval,
  input    wire          lsu_rtu_ex1_buffer_vld,
  input    wire          lsu_rtu_no_op,
  input    wire          mmu_xx_mmu_en,
  input    wire          pad_yy_icg_scan_en,
  input    wire          vidu_rtu_no_op,
  input    wire          vpu_rtu_no_op,
  input    wire          wb_retire_wb_no_op,
  output   wire          retire_ctrl_commit_clear,
  output   wire          retire_ctrl_commit_clear_for_bju,
  output   wire          retire_rbus_fs_dirty,
  output   wire          retire_rbus_vs_dirty,
  output   wire  [10:0]  retire_top_dbg_info,
  output   wire  [63:0]  rtu_cp0_epc,
  output   wire          rtu_cp0_exit_debug,
  output   wire  [63:0]  rtu_cp0_tval,
  output   wire  [6 :0]  rtu_cp0_vstart,
  output   wire          rtu_cp0_vstart_vld,
  output   wire          rtu_cpu_no_retire,
  output   wire  [63:0]  rtu_dtu_dpc,
  output   wire          rtu_dtu_halt_ack,
  output   wire          rtu_dtu_pending_ack,
  output   wire          rtu_dtu_retire_chgflw,
  output   wire          rtu_dtu_retire_debug_expt_vld,
  output   reg   [21:0]  rtu_dtu_retire_halt_info,
  output   wire          rtu_dtu_retire_ertn,
  output   wire          rtu_dtu_retire_mret,
  output   wire  [63:0]  rtu_dtu_retire_next_pc,
  output   wire          rtu_dtu_retire_sret,
  output   wire          rtu_dtu_retire_vld,
  output   reg   [63:0]  rtu_dtu_tval,
  output   wire          rtu_hpcp_int_vld,
  output   wire          rtu_hpcp_retire_inst_vld,
  output   wire  [63:0]  rtu_hpcp_retire_pc,
  output   wire          rtu_idu_flush_fe,
  output   wire          rtu_idu_flush_stall,
  output   wire          rtu_idu_flush_wbt,
  output   wire          rtu_idu_pipeline_empty,
  output   wire  [63:0]  rtu_ifu_chgflw_pc,
  output   wire          rtu_ifu_chgflw_vld,
  output   wire          rtu_ifu_dbg_mask,
  output   wire          rtu_ifu_flush_fe,
  output   wire          rtu_lsu_async_expt_ack,
  output   wire          rtu_lsu_expt_ack,
  output   wire          rtu_lsu_expt_exit,
  output   wire  [26:0]  rtu_mmu_bad_vpn,
  output   wire          rtu_mmu_expt_vld,
  output   wire          rtu_pad_halted,
  output   wire          rtu_pad_retire,
  output   wire  [63:0]  rtu_pad_retire_pc,
  output   wire          rtu_vidu_flush_wbt,
  output   wire          rtu_yy_xx_async_flush,
  output   wire          rtu_yy_xx_dbgon,
  output   wire          rtu_yy_xx_expt_int,
  output   wire  [14:0]  rtu_yy_xx_expt_vec,
  output   wire          rtu_yy_xx_expt_vld,
  output   wire          rtu_yy_xx_flush,
  output   wire          rtu_yy_xx_flush_fe
); 



// &Regs; @28
reg             bkpt_req_split_lsu_trigger_buf;       
reg             bkpt_req_split_trigger_t1_buf;        
reg             dbg_mode_on;                          
reg             dbg_mode_on_after_req;                
reg     [2 :0]  flush_cur_state;                      
reg     [2 :0]  flush_next_state;                     
reg     [3 :0]  halt_cause;                           
reg             halt_req_split_trigger_t1_buf;        
reg             no_retire;                            
reg             retire_async_flush;                   
reg     [21:0]  retire_buf_split_trigger_t1_halt_info; 
reg     [63:0]  retire_chgflw_pc;                     
reg     [31:0]  retire_cnt;                           
reg             retire_int_vld_flop;                  
reg             retire_trap_chgflw_vld;               
reg     [63:0]  retire_trap_epc;                      
reg     [63:0]  retire_trap_tval;                     
reg     [14:0]  retire_trap_vec;                      
reg             retire_xret_vld;                      

// &Wires; @29
wire            bkpt_req_buf_split_trigger_t1;        
wire            bkpt_req_ebreak;                      
wire            bkpt_req_pending;                     
wire            bkpt_req_split_trigger_t1;            
wire            bkpt_req_t1_retire_vld;               
wire            bkpt_req_t1_retire_vld_raw;           
wire            bkpt_req_trigger_t0;                  
wire            bkpt_req_trigger_t1;                  
wire            bkpt_req_trigger_t1_raw;              
wire            halt_req;                             
wire            halt_req_buf_split_trigger_t1;        
wire            halt_req_dm_async;                    
wire            halt_req_dm_sync;                     
wire            halt_req_ebreak;                      
wire            halt_req_pending;                     
wire            halt_req_reset;                       
wire            halt_req_split_trigger_t1;            
wire            halt_req_step;                        
wire            halt_req_t1;                          
wire            halt_req_t1_raw;                      
wire            halt_req_t1_retire_vld;               
wire            halt_req_t1_retire_vld_raw;           
wire            halt_req_trigger_t0;                  
wire            halt_req_trigger_t1;                  
wire            halt_req_trigger_t1_raw;              
wire            retire_async_expt;                    
wire    [63:0]  retire_async_expt_tval;               
wire    [14:0]  retire_async_expt_vec;                
wire            retire_async_trap_vld;                
wire            retire_bju_flush_req;                 
wire            retire_bkpt_expt;                     
wire            retire_bkpt_expt_lsu_trigger_t1;      
wire            retire_bkpt_expt_split_lsu_trigger_t1; 
wire            retire_bkpt_expt_t1;                  
wire            retire_chgflw_vld;                    
wire            retire_clk;                           
wire            retire_clk_en;                        
wire            retire_commit_clear;                  
wire            retire_commit_clear_for_bju;          
wire            retire_cpu_no_op;                     
wire            retire_dbg_mode_async_trap_vld;       
wire            retire_debug_flush;                   
wire            retire_ex2_retire_normal;             
wire            retire_ex2_retire_vld;                
wire            retire_exit_debug;                    
wire            retire_expt_debug;                    
wire            retire_expt_inst;                     
wire            retire_flush_be;                      
wire            retire_flush_fe;                      
wire            retire_flush_fe_set;                  
wire            retire_flush_wait;                    
wire            retire_fs_dirty;                      
wire    [21:0]  retire_halt_info;                     
wire            retire_inst_expt;                     
wire    [14:0]  retire_inst_expt_vec;                 
wire            retire_inst_flush;                    
wire            retire_inst_flush_fe_set;             
wire            retire_int_inst;                      
wire    [14:0]  retire_int_vec;                       
wire            retire_mmu_trap;                      
wire            retire_pending_bkpt_expt;             
wire            retire_pipeline_empty;                
wire            retire_sync_expt;                                          
wire    [63:0]  retire_sync_tval_64;                  
wire    [63:0]  retire_trap_epc_64;                   
wire            retire_trap_int;                      
wire            retire_trap_vld;                      
wire            retire_tval_use_pipeline;             
wire            retire_vs_dirty;                      
wire    [6 :0]  retire_vstart;                        
wire            retire_vstart_updt;                   


//==========================================================
//                          Retire
//==========================================================
assign retire_ex2_retire_vld    = ctrl_retire_ex2_retire_vld;
//inst with async expt should commit its result
assign retire_ex2_retire_normal = retire_ex2_retire_vld
                                  && !retire_sync_expt;

//==========================================================
//                       Trap Process
//==========================================================
//----------------------------------------------------------
//                           Expt
//----------------------------------------------------------
// Expt source includes:
//   1. EX1 Expt
//   2. bus error
//   3. breakpoint
assign retire_inst_expt             = dp_retire_ex2_inst_expt || retire_bkpt_expt;
assign retire_inst_expt_vec[14:0]   = dp_retire_ex2_vec[14:0];

assign retire_async_expt            = lsu_rtu_async_expt_vld;
assign retire_async_expt_vec[14:0]  = 15'd8;
assign retire_async_expt_tval[63:0] = {24'b0, lsu_rtu_async_tval[39:0]};

assign retire_sync_expt             = retire_inst_expt
                                   || retire_pending_bkpt_expt;

assign retire_expt_inst             = retire_sync_expt
                                   || retire_async_expt;
//expt in debug mode: expt except bkpt will set cmderr3
assign retire_expt_debug            = retire_pending_bkpt_expt
                                   || retire_async_expt
                                   || dp_retire_ex2_inst_expt
                                      && !retire_bkpt_expt;

//----------------------------------------------------------
//                           Int
//----------------------------------------------------------
// Int source from rtu_int.
assign retire_int_inst        = int_retire_int_vld;
assign retire_int_vec[14:0]   = int_retire_int_vec[14:0];

//----------------------------------------------------------
//                       Trap Vector
//----------------------------------------------------------
// Trap level:
//   1. pending bkpt expt
//   2. Int
//   3. async expt
//   4. sync expt
// &CombBeg; @83
always @( retire_inst_expt_vec[14:0]
       or retire_async_expt
       or retire_bkpt_expt
       or retire_int_vec[14:0]
       or retire_async_expt_vec[14:0]
       or retire_int_inst
       or retire_pending_bkpt_expt)
begin
  if (retire_pending_bkpt_expt)
    retire_trap_vec[14:0] = 15'd12;
  else if (retire_int_inst)
    retire_trap_vec[14:0] = retire_int_vec[14:0];
  else if (retire_async_expt)
    retire_trap_vec[14:0] = retire_async_expt_vec[14:0];
  else if (retire_bkpt_expt)
    retire_trap_vec[14:0] = 15'd12;
  else
    retire_trap_vec[14:0] = retire_inst_expt_vec[14:0];
// &CombEnd; @94
end

assign retire_mmu_trap = retire_trap_vec[14:0] == 15'd1
                      || retire_trap_vec[14:0] == 15'd2
                      || retire_trap_vec[14:0] == 15'd3;

//----------------------------------------------------------
//                        Trap TVAL
//----------------------------------------------------------
// 0, 1, 12 inst fetch expt use pc+if_high.
// 2 ill inst use opcode
// 4, 5, 6, 7, 13, 15 ld/st use addr.
//   bus err addr from async tval. others is in pipeline tval.
assign retire_tval_use_pipeline  = retire_inst_expt_vec[14:0] == 15'b1
                                || retire_inst_expt_vec[14:0] == 15'd2
                                || retire_inst_expt_vec[14:0] == 15'd3
                                || retire_inst_expt_vec[14:0] == 15'd4
                                || retire_inst_expt_vec[14:0] == 15'd5
                                || retire_inst_expt_vec[14:0] == 15'd6
                                || retire_inst_expt_vec[14:0] == 15'd7
                                || retire_inst_expt_vec[14:0] == 15'd8
                                || retire_inst_expt_vec[14:0] == 15'd9
                                || retire_inst_expt_vec[14:0] == 15'd10
                                || bkpt_req_trigger_t0;

assign retire_sync_tval_64[63:0] = dp_retire_ex2_tval[63:0];

// &CombBeg; @123
always @( retire_async_expt
       or retire_sync_tval_64[63:0]
       or retire_async_expt_tval[63:0]
       or retire_int_inst
       or retire_tval_use_pipeline
       or dtu_rtu_pending_tval[63:0]
       or retire_pending_bkpt_expt)
begin
  if (retire_pending_bkpt_expt)
    retire_trap_tval[63:0] = dtu_rtu_pending_tval[63:0];
  else if (retire_int_inst)
    retire_trap_tval[63:0] = 64'b0;
  else if (retire_async_expt)
    retire_trap_tval[63:0] = retire_async_expt_tval[63:0];
  else if (retire_tval_use_pipeline)
    retire_trap_tval[63:0] = retire_sync_tval_64[63:0];
  else
    retire_trap_tval[63:0] = 64'b0;
// &CombEnd; @134
end

//----------------------------------------------------------
//                         Trap EPC
//----------------------------------------------------------
// epc save next pc:
//   1. only int
//   2. only async expt without split
//   3. int with async expt.
// epc save cur pc:
//   1. sync expt
//   2. async expt with split
//   3. async expt with sync expt
//   4. int with sync expt
// &CombBeg; @148
always @( retire_async_expt
       or dp_retire_ex2_inst_split
       or dp_retire_ex2_cur_pc[63:0]
       or dp_retire_ex2_next_pc[63:0]
       or retire_sync_expt)
begin
  if (retire_sync_expt
   || retire_async_expt && dp_retire_ex2_inst_split)
    retire_trap_epc[63:0] = dp_retire_ex2_cur_pc[63:0];
  else
    retire_trap_epc[63:0] = dp_retire_ex2_next_pc[63:0];
// &CombEnd; @154
end

assign retire_trap_epc_64[63:0]  = retire_trap_epc[63:0];

//----------------------------------------------------------
//                         Trap Ack
//----------------------------------------------------------
assign retire_trap_vld = retire_ex2_retire_vld
                         && !halt_req && !dbg_mode_on
                         && (retire_expt_inst || retire_int_inst);

assign retire_trap_int = retire_int_inst && !retire_pending_bkpt_expt;

//----------------------------------------------------------
//                        Async Ack
//----------------------------------------------------------
assign retire_async_trap_vld = retire_async_expt
                               && retire_trap_vld
                               && (!retire_int_inst
                                  || !retire_pending_bkpt_expt);
//debug mode async trap
assign retire_dbg_mode_async_trap_vld = retire_async_expt
                                        && retire_ex2_retire_vld
                                        &&  !retire_pending_bkpt_expt;

//==========================================================
//                      Debug Process
//==========================================================
//----------------------------------------------------------
//                Halt Request : Timing 0
//----------------------------------------------------------
//t0 halt request will enter debug mode when not in debug mode
assign halt_req_reset            = ifu_rtu_reset_halt_req;
//async halt req ignore db      g_mode_on
assign halt_req_dm_async         = dtu_rtu_async_halt_req;
assign halt_req_ebreak           = retire_ex2_retire_vld
                                   && dtu_rtu_ebreak_action
                                   && dp_retire_ex2_inst_ebreak
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && !dbg_mode_on_after_req;
assign halt_req_trigger_t0       = retire_ex2_retire_vld
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_ACTION]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && !dbg_mode_on_after_req;
assign halt_req_pending          = retire_ex2_retire_vld
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_ACTION]
                                   && !dbg_mode_on_after_req;
//t0 halt request
assign halt_req                  = halt_req_reset
                                || halt_req_ebreak
                                || halt_req_trigger_t0
                                || halt_req_pending
                                || halt_req_dm_async;

//----------------------------------------------------------
//                Halt Request : Timing 1
//----------------------------------------------------------
//cannot ack t1 halt request when:
//1.inst with pending halt or expt
//2.in debug mode
assign halt_req_t1_retire_vld_raw = retire_ex2_retire_vld
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                    && !dbg_mode_on_after_req;
//3.ack t0 halt request
//4.t1 bkpt expt request (see below)
assign halt_req_t1_retire_vld     = halt_req_t1_retire_vld_raw
                                    && !halt_req;
//Halt Request with Timing 1
assign halt_req_dm_sync           = halt_req_t1_retire_vld
                                    && !dp_retire_ex2_inst_split
                                    && dtu_rtu_sync_halt_req;
assign halt_req_step              = halt_req_t1_retire_vld
                                    && !dp_retire_ex2_inst_split
                                    && dtu_rtu_step_en;
assign halt_req_trigger_t1_raw    = halt_req_t1_retire_vld
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];
// &Force("nonport","veri_halt_req_t1"); @239

//split inst t1 trigger will be buffered and ack in last split inst
assign halt_req_trigger_t1        = halt_req_trigger_t1_raw
                                    && !dp_retire_ex2_inst_split;
assign halt_req_split_trigger_t1  = halt_req_trigger_t1_raw
                                    && dp_retire_ex2_inst_split;
//buffered split trigger will ack at non-split inst
assign halt_req_buf_split_trigger_t1 = halt_req_t1_retire_vld
                                   && !dp_retire_ex2_inst_split
                                   && halt_req_split_trigger_t1_buf;

//t1 halt request will generate inst flush and signal dtu pending halt
assign halt_req_t1_raw            = halt_req_dm_sync
                                 || halt_req_trigger_t1
                                 || halt_req_buf_split_trigger_t1
                                 || halt_req_step;

//cannot ack t1 halt request when:
//4.t1 bkpt expt request
assign halt_req_t1                = halt_req_t1_raw
                                    && !retire_bkpt_expt_t1;

//----------------------------------------------------------
//              Bkpt Expt Request : Timing 0
//----------------------------------------------------------
assign bkpt_req_ebreak           = retire_ex2_retire_vld
                                   && !dtu_rtu_ebreak_action
                                   && dp_retire_ex2_inst_ebreak
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT];
assign bkpt_req_pending          = retire_ex2_retire_vld
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];

assign bkpt_req_trigger_t0       = retire_ex2_retire_vld
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT]
                                   && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                   && !dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];
//normal bkpt expt includes       ebreak and t0 trigger
assign retire_bkpt_expt          = bkpt_req_ebreak
                                   || bkpt_req_trigger_t0;
//pending bkpt expt has highest priority
assign retire_pending_bkpt_expt  = bkpt_req_pending;

//----------------------------------------------------------
//              Bkpt Expt Request : Timing 1
//----------------------------------------------------------
//cannot ack t1 halt request when:
//1.inst with pending halt or expt
assign bkpt_req_t1_retire_vld_raw = retire_ex2_retire_vld
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_PENDING_HALT];
//2.ack t0 halt request
assign bkpt_req_t1_retire_vld     = bkpt_req_t1_retire_vld_raw
                                    && !halt_req;
//Halt Request with Timing 1
assign bkpt_req_trigger_t1_raw    = bkpt_req_t1_retire_vld
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_MATCH]
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_CHAIN]
                                    && dp_retire_ex2_halt_info[`TDT_HINFO_TIMING]
                                    && !dp_retire_ex2_halt_info[`TDT_HINFO_ACTION];
// &Force("nonport","veri_retire_bkpt_expt_t1"); @318
//split inst t1 trigger will be buffered and ack in last split inst
assign bkpt_req_trigger_t1        = bkpt_req_trigger_t1_raw
                                    && !dp_retire_ex2_inst_split;
assign bkpt_req_split_trigger_t1  = bkpt_req_trigger_t1_raw
                                    && dp_retire_ex2_inst_split;
//buffered split trigger will ack  at non-split inst
assign bkpt_req_buf_split_trigger_t1 = bkpt_req_t1_retire_vld
                                   && bkpt_req_split_trigger_t1_buf
                                   && !dp_retire_ex2_inst_split;

assign retire_bkpt_expt_t1        = bkpt_req_trigger_t1
                                 || bkpt_req_buf_split_trigger_t1;

assign retire_bkpt_expt_lsu_trigger_t1       = bkpt_req_trigger_t1
                                               && dp_retire_ex2_halt_info[`TDT_HINFO_LDST];
assign retire_bkpt_expt_split_lsu_trigger_t1 = bkpt_req_buf_split_trigger_t1
                                               && bkpt_req_split_lsu_trigger_buf;

//----------------------------------------------------------
//                   Debug Sync Flush
//----------------------------------------------------------
//when dtu signal sync flush, rtu should flush when any inst
//retire: include step and icount
assign retire_debug_flush  = retire_ex2_retire_vld
                             && dtu_rtu_sync_flush
                             && !dp_retire_ex2_inst_split
                             && !dbg_mode_on_after_req;

//----------------------------------------------------------
//                     Exit Debug Mode
//----------------------------------------------------------
//exit debug ignore exception:
//execute dret in debug mode should not generate exception
assign retire_exit_debug   = dbg_mode_on_after_req
                             && (dtu_rtu_resume_req
                              || retire_ex2_retire_vld
                                 && dp_retire_ex2_inst_dret);

//----------------------------------------------------------
//                     Cause Select
//----------------------------------------------------------
//select cause according to priority
//not includes itrigger and etrigger, which fire in 
// &CombBeg; @370
always @( halt_req_trigger_t0
       or halt_req_buf_split_trigger_t1
       or halt_req_pending
       or halt_req_dm_sync
       or dp_retire_ex2_halt_info[11:8]
       or halt_req_ebreak
       or halt_req_reset
       or halt_req_trigger_t1
       or halt_req_dm_async)
begin
  if(halt_req_dm_async)
    halt_cause[3:0] = 4'd8;
  else if(halt_req_pending)
    halt_cause[3:0] = dp_retire_ex2_halt_info[`TDT_HINFO_CAUSE:`TDT_HINFO_CAUSE-3];
  else if(halt_req_trigger_t0
       || halt_req_trigger_t1
       || halt_req_buf_split_trigger_t1)
    halt_cause[3:0] = 4'd2;
  else if(halt_req_ebreak)
    halt_cause[3:0] = 4'd1;
  else if(halt_req_reset)
    halt_cause[3:0] = 4'd5;
  else if(halt_req_dm_sync)
    halt_cause[3:0] = 4'd3;
  else //halt_req_step
    halt_cause[3:0] = 4'd4;
// &CombEnd; @387
end

//----------------------------------------------------------
//                       Debug Mode
//----------------------------------------------------------
//debug mode on after request:
//used to mask ifu inst fetch and new halt request
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dbg_mode_on_after_req <= 1'b0;
  else if (halt_req)
    dbg_mode_on_after_req <= 1'b1;
  else if (retire_exit_debug)
    dbg_mode_on_after_req <= 1'b0;
end

//debug mode on after flush be:
//indicate hart is in halt
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dbg_mode_on <= 1'b0;
  else if (retire_flush_be && dbg_mode_on_after_req)
    dbg_mode_on <= 1'b1;
  else if (retire_exit_debug)
    dbg_mode_on <= 1'b0;
end

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_async_flush <= 1'b0;
  else
    retire_async_flush <= halt_req_dm_async;
end

//----------------------------------------------------------
//                Split inst t1 halt info
//----------------------------------------------------------
//if split inst hit t0 trigger, it will ack as normal inst
//if split inst hit t1 trigger, rtu will buffer and merge
//halt info, then ack at last split inst (!split)
//if split inst flush, t1 halt info will be flushed
//chain 1 match will clear/not merge into halt info 
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    halt_req_split_trigger_t1_buf <= 1'b0;
  else if (retire_flush_be || halt_req_trigger_t1)
    halt_req_split_trigger_t1_buf <= 1'b0;
  else if (halt_req_split_trigger_t1)
    halt_req_split_trigger_t1_buf <= 1'b1;
end

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    bkpt_req_split_trigger_t1_buf  <= 1'b0;
    bkpt_req_split_lsu_trigger_buf <= 1'b0;
  end
  else if (retire_flush_be || bkpt_req_trigger_t1) begin
    bkpt_req_split_trigger_t1_buf  <= 1'b0;
    bkpt_req_split_lsu_trigger_buf <= 1'b0;
  end
  else if (bkpt_req_split_trigger_t1) begin
    bkpt_req_split_trigger_t1_buf  <= 1'b1;
    bkpt_req_split_lsu_trigger_buf <= dp_retire_ex2_halt_info[`TDT_HINFO_LDST];
  end
end

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if (retire_flush_be || halt_req_trigger_t1 || bkpt_req_trigger_t1)
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if (halt_req_split_trigger_t1 || bkpt_req_split_trigger_t1)
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0] <=
    retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0]
                | dp_retire_ex2_halt_info[`TDT_HINFO_WIDTH-1:0];
end

//----------------------------------------------------------
//                Retire Halt Info
//----------------------------------------------------------
//if there is buffered split trigger t1 halt/bkpt req
//merge buffered halt info into retired halt info
assign retire_halt_info[`TDT_HINFO_WIDTH-1:0] =
    dp_retire_ex2_halt_info[`TDT_HINFO_WIDTH-1:0]
  | {`TDT_HINFO_WIDTH{(halt_req_buf_split_trigger_t1
                    || bkpt_req_buf_split_trigger_t1)}}
    & retire_buf_split_trigger_t1_halt_info[`TDT_HINFO_WIDTH-1:0];

//==========================================================
//                      Flush Control
//==========================================================
assign retire_inst_flush    = dp_retire_ex2_inst_flush;
assign retire_bju_flush_req = iu_rtu_ex2_bju_ras_mispred
                              || iu_rtu_depd_lsu_chgflow_vld;

//----------------------------------------------------------
//                        Flush Set
//----------------------------------------------------------
// Flush fe will be set when:
//   1. int/ expt
//   2. flush inst
//   3. t1 bkpt expt
//   4. t0 and t1 halt req:
//      halt req will sync with inst retire by itself
assign retire_inst_flush_fe_set    = retire_ex2_retire_vld
                                     && (retire_expt_inst
                                      || retire_int_inst
                                      || retire_inst_flush
                                      || retire_vstart_updt
                                      || retire_bkpt_expt_t1
                                      || retire_debug_flush)
                                     || halt_req
                                     || halt_req_t1;
//   5. bju flush(without retire)
assign retire_flush_fe_set         = retire_inst_flush_fe_set
                                     || retire_bju_flush_req;

assign retire_commit_clear         = retire_inst_flush_fe_set
                                     || retire_bju_flush_req
                                     || retire_flush_fe;

assign retire_commit_clear_for_bju = retire_inst_flush_fe_set
                                     || iu_rtu_ex2_bju_ras_mispred
                                     || retire_flush_fe;

//----------------------------------------------------------
//                        Flush FSM
//----------------------------------------------------------
parameter FLUSH_IDLE  = 3'b000;
parameter FLUSH_FE    = 3'b001;
parameter FLUSH_WAIT  = 3'b100;
parameter FLUSH_BE    = 3'b010;
parameter FLUSH_FE_BE = 3'b011;

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    flush_cur_state[2:0] <= 3'b0;
  else if (halt_req_dm_async)
    flush_cur_state[2:0] <= FLUSH_FE_BE;
  else
    flush_cur_state[2:0] <= flush_next_state[2:0];
end

// &CombBeg; @537
always @( retire_cpu_no_op
       or retire_flush_fe_set
       or flush_cur_state)
begin
  case(flush_cur_state)
  FLUSH_IDLE:
    if (retire_flush_fe_set)
      flush_next_state = FLUSH_FE;
    else
      flush_next_state = FLUSH_IDLE;
  FLUSH_FE:
    if (retire_cpu_no_op)
      flush_next_state = FLUSH_BE;
    else
      flush_next_state = FLUSH_WAIT;
  FLUSH_WAIT:
    if (retire_cpu_no_op)
      flush_next_state = FLUSH_BE;
    else
      flush_next_state = FLUSH_WAIT;
  FLUSH_BE:
    flush_next_state = FLUSH_IDLE;
  FLUSH_FE_BE:
    flush_next_state = FLUSH_IDLE;
  default:
    flush_next_state = FLUSH_IDLE;
  endcase
// &CombEnd; @561
end

assign retire_flush_wait = flush_cur_state == FLUSH_WAIT;
assign retire_flush_fe   = flush_cur_state[0];
assign retire_flush_be   = flush_cur_state[1];

assign retire_cpu_no_op      = !retire_ex2_retire_vld
                               && wb_retire_wb_no_op
                               && lsu_rtu_no_op
                               && iu_xx_no_op
                               && vpu_rtu_no_op
                               && vidu_rtu_no_op;
assign retire_pipeline_empty = retire_cpu_no_op
                               && !lsu_rtu_ex1_buffer_vld;

//==========================================================
//                        Changeflow
//==========================================================
// To opt timing, trap_vld chgflw will be flop.
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_trap_chgflw_vld <= 1'b0;
  else if (retire_trap_vld)
    retire_trap_chgflw_vld <= 1'b1;
  else if (retire_flush_be)
    retire_trap_chgflw_vld <= 1'b0;
end

assign retire_chgflw_vld = 
            retire_ex2_retire_vld && !retire_trap_vld
            && (dp_retire_ex2_inst_chgflw || dp_retire_ex2_inst_flush)
         || retire_vstart_updt && !retire_trap_vld
         || retire_trap_chgflw_vld && retire_flush_fe
         || retire_exit_debug;

always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_xret_vld <= 1'b0;
  else if (retire_ex2_retire_normal && (dp_retire_ex2_inst_mret
                                     || dp_retire_ex2_inst_ertn
                                     || dp_retire_ex2_inst_sret))
    retire_xret_vld <= 1'b1;
  else if (retire_flush_be)
    retire_xret_vld <= 1'b0;
end

//----------------------------------------------------------
//                      Changeflow PC
//----------------------------------------------------------
// &Force("bus","dtu_rtu_dpc",63,0); @611
// &CombBeg; @612
always @( retire_exit_debug
       or cp0_rtu_trap_pc[63:0]
       or dp_retire_ex2_next_pc[63:0]
       or dtu_rtu_dpc[63:0]
       or retire_trap_chgflw_vld)
begin
  if(retire_exit_debug)
    retire_chgflw_pc[63:0] = dtu_rtu_dpc[63:0];
  else if(retire_trap_chgflw_vld)
    retire_chgflw_pc[63:0] = cp0_rtu_trap_pc[63:0];
  else
    retire_chgflw_pc[63:0] = dp_retire_ex2_next_pc[63:0];
// &CombEnd; @619
end

//==========================================================
//                      VSTART Update
//==========================================================
//vstart should update when lsu expt (including data trigger hit)
//(use inst expt here because vstart inst can only from lsu)
assign retire_vstart_updt = retire_ex2_retire_vld
                            && !retire_pending_bkpt_expt
                            && dp_retire_ex2_inst_vstart
                            && (retire_inst_expt
                            || !retire_inst_expt && !cp0_rtu_vstart_eq_0);
assign retire_vstart[6:0] = {7{retire_inst_expt}} & dp_retire_ex2_vstart[6:0];

//==========================================================
//                       FS VS Dirty
//==========================================================
assign retire_fs_dirty = retire_ex2_retire_normal && dp_retire_ex2_fs_dirty;
assign retire_vs_dirty = retire_ex2_retire_normal && dp_retire_ex2_vs_dirty;

//==========================================================
//                   No Retire For Debug
//==========================================================
always @ (posedge forever_cpuclk)
begin
  if (retire_ex2_retire_vld || ifu_rtu_warm_up)
    retire_cnt[31:0] <= 32'b0;
  else
    retire_cnt[31:0] <= retire_cnt[31:0] + 32'b1;
end

always @ (posedge forever_cpuclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    no_retire <= 1'b0;
  else if (retire_ex2_retire_vld)
    no_retire <= 1'b0;
  else if (retire_cnt[31:0] == 32'd8192)
    no_retire <= 1'b1;
end

assign rtu_cpu_no_retire = !no_retire && retire_cnt[31:0] == 32'd8192 && cp0_rtu_fence_idle
                                                                      && !dbg_mode_on
                                                                      && !cp0_rtu_in_lpmd;
// &Force("input", "cp0_rtu_fence_idle"); @665
// &Force("input", "cp0_rtu_in_lpmd"); @666

//==========================================================
//                     HPCP Information
//==========================================================
always @ (posedge retire_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    retire_int_vld_flop <= 1'b0;
  else
    retire_int_vld_flop <= retire_trap_vld && retire_trap_int;
end

//==========================================================
//                           ICG
//==========================================================
assign retire_clk_en = halt_req
                    || retire_exit_debug
                    || retire_flush_fe_set
                    || retire_trap_chgflw_vld
                    || flush_cur_state != FLUSH_IDLE
                    || retire_async_flush
                    || halt_req_trigger_t1
                    || halt_req_split_trigger_t1
                    || bkpt_req_trigger_t1
                    || bkpt_req_split_trigger_t1;
// &Instance("gated_clk_cell", "x_retire_clk"); @692
gated_clk_cell  x_retire_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (retire_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (retire_clk_en     ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @693
//          .external_en (1'b0), @694
//          .global_en   (cp0_yy_clk_en), @695
//          .module_en   (cp0_rtu_icg_en), @696
//          .local_en    (retire_clk_en), @697
//          .clk_out     (retire_clk)); @698

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign retire_ctrl_commit_clear         = retire_commit_clear;
assign retire_ctrl_commit_clear_for_bju = retire_commit_clear_for_bju;

assign retire_rbus_fs_dirty             = retire_fs_dirty;
assign retire_rbus_vs_dirty             = retire_vs_dirty;

assign retire_top_dbg_info[10:0] = {retire_ex2_retire_vld,
                                    dbg_mode_on_after_req,
                                    flush_cur_state[2:0],
                                    retire_cpu_no_op,
                                    lsu_rtu_ex1_buffer_vld,
                                    lsu_rtu_no_op,
                                    iu_xx_no_op,
                                    vpu_rtu_no_op,
                                    vidu_rtu_no_op};

//----------------------------------------------------------
//                          For xx
//----------------------------------------------------------
assign rtu_yy_xx_expt_vld      = retire_trap_vld;
assign rtu_yy_xx_expt_int      = retire_trap_int;
assign rtu_yy_xx_expt_vec[14:0]= retire_trap_vec[14:0];

assign rtu_yy_xx_dbgon         = dbg_mode_on;

assign rtu_yy_xx_flush_fe      = retire_flush_fe;
assign rtu_yy_xx_flush         = retire_flush_be;

assign rtu_yy_xx_async_flush   = retire_async_flush;

//----------------------------------------------------------
//                         For Pad
//----------------------------------------------------------
assign rtu_pad_retire          = retire_ex2_retire_vld;
assign rtu_pad_retire_pc[63:0] = dp_retire_ex2_cur_pc[63:0];
assign rtu_pad_halted          = dbg_mode_on;

//----------------------------------------------------------
//                         For DTU
//----------------------------------------------------------
//trigger signals
// &CombBeg; @750
always @( halt_req_t1_raw
       or halt_req
       or retire_bkpt_expt_t1
       or halt_req_buf_split_trigger_t1
       or retire_halt_info[21:0]
       or bkpt_req_buf_split_trigger_t1
       or halt_req_t1
       or halt_cause[3:0])
begin
  rtu_dtu_retire_halt_info[`TDT_HINFO_WIDTH-1:0] = retire_halt_info[`TDT_HINFO_WIDTH-1:0];
  if(1'b1) begin
  rtu_dtu_retire_halt_info[`TDT_HINFO_ACTION]       = halt_req    || halt_req_t1;
  rtu_dtu_retire_halt_info[`TDT_HINFO_PENDING_HALT] = halt_req_t1 || retire_bkpt_expt_t1;
  rtu_dtu_retire_halt_info[`TDT_HINFO_ACTION01]     = retire_halt_info[`TDT_HINFO_ACTION01]
                                                      || halt_req_buf_split_trigger_t1
                                                      && bkpt_req_buf_split_trigger_t1
                                                      || retire_bkpt_expt_t1
                                                      && halt_req_t1_raw;
  rtu_dtu_retire_halt_info[`TDT_HINFO_CAUSE:`TDT_HINFO_CAUSE-3] = halt_cause[3:0];
  end
// &CombEnd; @762
end

//halt signals
assign rtu_dtu_dpc[63:0]             = dtu_rtu_async_halt_req && async_select_next_pc ?
                                       {dp_retire_ex2_next_pc[63:0]} :
                                       {dp_retire_ex2_cur_pc[63:0]};

// &CombBeg; @769
always @( retire_bkpt_expt_split_lsu_trigger_t1
       or retire_sync_tval_64[63:0]
       or dp_retire_ex2_cur_pc[63:0]
       or retire_bkpt_expt_lsu_trigger_t1)
begin
  //if load/store mcontrol, update load/store address
  if(retire_bkpt_expt_lsu_trigger_t1)
    rtu_dtu_tval[63:0]               = retire_sync_tval_64[63:0];
  //if split load/store mcontrol, update 0
  else if(retire_bkpt_expt_split_lsu_trigger_t1)
    rtu_dtu_tval[63:0]               = 64'b0;
  //otherwise update cur pc
  else
    rtu_dtu_tval[63:0]               = {dp_retire_ex2_cur_pc[63:0]};
// &CombEnd; @780
end

assign rtu_dtu_halt_ack              = halt_req;
assign rtu_dtu_pending_ack           = halt_req_pending || bkpt_req_pending;

//inst retire and pcfifo
assign rtu_dtu_retire_vld            = retire_ex2_retire_vld
                                       && (retire_flush_fe_set || !dp_retire_ex2_inst_split);
assign rtu_dtu_retire_debug_expt_vld = retire_ex2_retire_vld
                                       && dbg_mode_on
                                       && retire_expt_debug;
assign rtu_dtu_retire_ertn           = dp_retire_ex2_inst_ertn;
assign rtu_dtu_retire_mret           = dp_retire_ex2_inst_mret;
assign rtu_dtu_retire_sret           = dp_retire_ex2_inst_sret;
assign rtu_dtu_retire_chgflw         = dp_retire_ex2_inst_branch;
assign rtu_dtu_retire_next_pc[63:0]  = dp_retire_ex2_next_pc[63:0];

//----------------------------------------------------------
//                         For IFU
//----------------------------------------------------------
assign rtu_ifu_chgflw_vld       = retire_chgflw_vld;
assign rtu_ifu_flush_fe         = retire_flush_fe;
assign rtu_ifu_chgflw_pc[63:0]  = retire_chgflw_pc[63:0];

assign rtu_ifu_dbg_mask         = dbg_mode_on_after_req;

//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign rtu_cp0_epc[63:0]        = retire_trap_epc_64[63:0];
assign rtu_cp0_tval[63:0]       = retire_trap_tval[63:0];

assign rtu_cp0_vstart_vld       = retire_vstart_updt;
assign rtu_cp0_vstart[6:0]      = retire_vstart[6:0];

assign rtu_cp0_exit_debug       = retire_exit_debug;

//----------------------------------------------------------
//                         For IDU
//----------------------------------------------------------
assign rtu_idu_flush_stall      = retire_flush_wait || retire_flush_be;
assign rtu_idu_pipeline_empty   = retire_pipeline_empty;
assign rtu_idu_flush_fe         = retire_flush_fe;
assign rtu_idu_flush_wbt        = retire_flush_be;
assign rtu_vidu_flush_wbt       = retire_flush_be;

//----------------------------------------------------------
//                         For LSU
//----------------------------------------------------------
assign rtu_lsu_expt_ack         = retire_trap_chgflw_vld && retire_flush_be;
assign rtu_lsu_expt_exit        = retire_xret_vld && retire_flush_be;
assign rtu_lsu_async_expt_ack   = dbg_mode_on
                                  ? retire_dbg_mode_async_trap_vld
                                  : retire_async_trap_vld;

//----------------------------------------------------------
//                         For HPCP
//----------------------------------------------------------
// &Force("input", "hpcp_rtu_cnt_en"); @837
assign rtu_hpcp_retire_inst_vld = retire_ex2_retire_vld && !dp_retire_ex2_inst_split;
assign rtu_hpcp_retire_pc[63:0] = dp_retire_ex2_cur_pc[63:0]; 
assign rtu_hpcp_int_vld         = retire_int_vld_flop;

//----------------------------------------------------------
//                         For MMU
//----------------------------------------------------------
assign rtu_mmu_expt_vld         = retire_trap_vld
                                  && !retire_trap_int && retire_mmu_trap;
assign rtu_mmu_bad_vpn[26:0]    = retire_trap_tval[38:12];

// &Force("output","flush_next_state"); @850




//==========================================================
//                   Check DiffTest
//==========================================================
`ifdef CHECK_DIFFTEST

`define CPU_CORE cpu_subsystem.core0_subsystem
`define RTU `CPU_CORE.x_aq_top_0.x_aq_core.x_aq_rtu_top
`define CP0_TRAP_CSR `CPU_CORE.x_aq_top_0.x_aq_core.x_aq_cp0_top.x_aq_cp0_regs.x_aq_cp0_trap_csr


wire [63 :0] timer_64_value;

wire [63 :0] rtu_wb_data;
wire [5  :0] rtu_wb_reg;
wire         rtu_wb_vld;
wire [63 :0] rtu_wb0_data;
wire [5  :0] rtu_wb0_reg;
wire         rtu_wb0_vld;
wire [63 :0] rtu_wb1_data;
wire [5  :0] rtu_wb1_reg;
wire         rtu_wb1_vld;

assign rtu_wb0_data[63:0] = `RTU.rtu_idu_wb0_data[63:0];
assign rtu_wb0_reg [5 :0] = `RTU.rtu_idu_wb0_reg[5 :0];
assign rtu_wb0_vld        = `RTU.rtu_idu_wb0_vld;

assign rtu_wb1_data[63:0] = `RTU.rtu_idu_wb1_data[63:0];
assign rtu_wb1_reg [5 :0] = `RTU.rtu_idu_wb1_reg[5 :0];
assign rtu_wb1_vld        = `RTU.rtu_idu_wb1_vld;

assign rtu_wb_data[63:0]  = rtu_wb0_vld ? rtu_wb0_data[63:0] : rtu_wb1_data[63:0];
assign rtu_wb_reg [5 :0]  = rtu_wb0_vld ? rtu_wb0_reg[5 :0] : rtu_wb1_reg[5 :0];
assign rtu_wb_vld         = rtu_wb0_vld || rtu_wb1_vld;


assign timer_64_value[63: 0] = `CP0_TRAP_CSR.csrtimer_value[63:0];


DifftestInstrCommit DifftestInstrCommit(
    .clock              (forever_cpuclk             ),
    .coreid             ('0                         ),
    .index              ('0                         ),
    .valid              (retire_ex2_retire_vld      ),
    .pc                 (dp_retire_ex2_cur_pc[63:0] ),
    .instr              (32'b0                      ),
    .skip               ('0                         ),
    .is_TLBFILL         ('0                         ),
    .TLBFILL_index      ('0                         ),
    .is_CNTinst         ('0                         ),
    .timer_64_value     (timer_64_value[63:0]       ),
    .wen                (rtu_wb_vld                 ),
    .wdest              ({2'b0, rtu_wb_reg [5 :0]}  ),
    .wdata              (rtu_wb_data[63:0]          ),
    .csr_rstat          ('0                         ),
    .csr_data           ('0                         )
);



wire [63:0] csr_estat_value = `CP0_TRAP_CSR.csrestat_value[63:0];

wire [5 :0] csr_ecode = csr_estat_value[21:16];
wire [12:0] csr_cause = csr_estat_value[12: 0];


DifftestExcpEvent DifftestExcpEvent(
    .clock              (forever_cpuclk                  ),
    .coreid             ('0                              ),
    .excp_valid         (rtu_yy_xx_expt_vld              ),
    .eret               (dp_retire_ex2_inst_ertn         ),
    .intrNo             ({19'b0, csr_cause[12:0]}        ),
    .cause              ({26'b0, rtu_yy_xx_expt_vec[5:0]}),
    .exceptionPC        (rtu_cp0_epc[63:0]               ),
    .exceptionInst      (32'b0                           )
);

`endif

// &ModuleEnd; @853
endmodule



