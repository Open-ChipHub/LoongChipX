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
module aq_ifu_ipack (
  // &Ports, @24
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_ipack_cancel,
  input    wire          forever_cpuclk,
  input    wire          ibuf_ipack_stall,
  input    wire          icache_ipack_acc_err,
  input    wire  [31:0]  icache_ipack_inst,
  input    wire          icache_ipack_inst_vld,
  input    wire          icache_ipack_inst_vld_gate,
  input    wire          icache_ipack_pgflt,
  input    wire          icache_ipack_unalign,
  input    wire          iu_ifu_tar_pc_vld,
  input    wire          pad_yy_icg_scan_en,
  input    wire          pred_ipack_chgflw_vld0,
  input    wire          pred_ipack_delay_stall,
  input    wire          pred_ipack_mask,
  input    wire          pred_ipack_ret_stall,
  input    wire          rtu_ifu_chgflw_vld,
  input    wire          rtu_ifu_flush_fe,
  output   wire          ipack_ibuf_acc_err,
  output   wire  [31:0]  ipack_ibuf_inst,
  output   wire          ipack_ibuf_inst_vld,
  output   wire          ipack_ibuf_inst_vld_raw,
  output   wire          ipack_ibuf_pgflt,
  output   wire          ipack_pcgen_reissue,
  output   wire  [31:0]  ipack_pred_inst0,
  output   wire          ipack_pred_inst0_expt,
  output   wire          ipack_pred_inst0_vld,
  output   wire          ipack_top_entry0_vld,
  output   wire          ipack_top_entry1_vld,
  output   wire          ipack_top_entry2_vld
); 



// &Regs; @25
// &Wires; @26              
wire            entry_acc_err;            
wire            entry_create_en;          
wire            entry_create_icg_en;      
wire    [31:0]  entry_inst;               
wire            entry_pgflt;              
wire            entry_retire_en;          
wire            entry_upd_acc_err;        
wire    [31:0]  entry_upd_inst;           
wire            entry_upd_pgflt;          
wire            entry_vld;                
wire            icache_inst_vld;           
wire            ipack_acc_err;            
wire            ipack_align_create;        
wire            ipack_all_vld;             
wire            ipack_buf_flush;           
wire            ipack_buf_stall;           
wire            ipack_cpuclk;              
wire            ipack_empty;               
wire    [31:0]  ipack_inst;          
wire            ipack_vld;           
wire            ipack_full;                
wire            ipack_icg_en;              
wire            ipack_pgflt;              
wire    [31:0]  ipack_retire_inst;         
wire            ipack_retire_vld;                    


//==========================================================
// Instruction Package Module
// 1. Instance ICG Cell
// 2. Instruction Package Buffer to ID stage
// 3. Generate Valid Instruction
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign ipack_icg_en = icache_ipack_inst_vld_gate
                   || !ipack_empty;
// &Instance("gated_clk_cell", "x_aq_ifu_ipack_icg_cell"); @40
gated_clk_cell  x_aq_ifu_ipack_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ipack_cpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ipack_icg_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @41
//          .clk_out     (ipack_cpuclk), @42
//          .external_en (1'b0), @43
//          .global_en   (cp0_yy_clk_en), @44
//          .module_en   (cp0_ifu_icg_en), @45
//          .local_en    (ipack_icg_en) @46
// ); @47

//------------------------------------------------
// 2. Instruction Package Buffer Implementation
// a. Flush Condition
// b. Create Condition
// c. Retire Condition
// d. Instance Instruction Package Buffer Entry
//------------------------------------------------

// a. Flush Condition
assign ipack_buf_flush      = rtu_ifu_flush_fe || iu_ifu_tar_pc_vld 
                           || rtu_ifu_chgflw_vld;
assign icache_inst_vld      = icache_ipack_inst_vld && !ctrl_ipack_cancel;

// b. Create Condition
assign ipack_buf_stall      = pred_ipack_ret_stall || ibuf_ipack_stall;

assign entry_create_en = icache_inst_vld 
                       && !(entry_vld && ipack_buf_stall);

assign entry_create_icg_en = icache_ipack_inst_vld_gate && !icache_ipack_unalign;

// create inst
assign entry_upd_inst[31:0] = icache_ipack_inst[31:0];

// create acc err
assign entry_upd_acc_err = icache_ipack_acc_err;

// create pgflt
assign entry_upd_pgflt   = icache_ipack_pgflt;

// c. Retire Condition
assign entry_retire_en = !ipack_buf_stall;

// d. Instance Instruction Package Buffer Entry
// &ConnRule(s/ipack_entry/entry/); @106
// &Instance("aq_ifu_ipack_entry","x_aq_ifu_ipack_entry"); @107
aq_ifu_ipack_entry  x_aq_ifu_ipack_entry (
  .cp0_ifu_icg_en            (cp0_ifu_icg_en           ),
  .cp0_yy_clk_en             (cp0_yy_clk_en            ),
  .cpurst_b                  (cpurst_b                 ),
  .forever_cpuclk            (forever_cpuclk           ),
  .ipack_buf_flush           (ipack_buf_flush          ),
  .ipack_cpuclk              (ipack_cpuclk             ),
  .ipack_entry_acc_err       (entry_acc_err           ),
  .ipack_entry_create_en     (entry_create_en         ),
  .ipack_entry_create_icg_en (entry_create_icg_en     ),
  .ipack_entry_inst          (entry_inst              ),
  .ipack_entry_pgflt         (entry_pgflt             ),
  .ipack_entry_retire_en     (entry_retire_en         ),
  .ipack_entry_upd_acc_err   (entry_upd_acc_err       ),
  .ipack_entry_upd_inst      (entry_upd_inst          ),
  .ipack_entry_upd_pgflt     (entry_upd_pgflt         ),
  .ipack_entry_vld           (entry_vld               ),
  .pad_yy_icg_scan_en        (pad_yy_icg_scan_en       )
);

//------------------------------------------------
// 3. Generate Valid Instruction
// a. Valid Instruction Package
// b. Instruction Access Error for I-Buffer
//------------------------------------------------

// a. Valid Instruction Package
// Generate Empty Statu for Prediction
assign ipack_empty = !entry_vld;
assign ipack_full  = entry_vld;

// Generate First Valid Inst for Prediction
assign ipack_vld        = entry_vld;
assign ipack_inst[31:0] = entry_vld ? entry_inst[31:0] : 32'b0;

// Retire Number for I-Buffer
assign ipack_retire_vld    = entry_vld;

// Retire Inst for I-Buffer
assign ipack_retire_inst[31:0] = ipack_inst[31:0];

// b. Instruction Access Error for I-Buffer
assign ipack_acc_err = entry_vld && entry_acc_err;

assign ipack_pgflt   = entry_vld && entry_pgflt;


//==========================================================
// Rename for Output
//==========================================================

// Output to id pred
assign ipack_pred_inst0_vld   = ipack_vld;// && !ibuf_ipack_stall;
assign ipack_pred_inst0[31:0] = ipack_inst[31:0];
assign ipack_pred_inst0_expt  = entry_vld && entry_acc_err
                                || entry_vld && entry_pgflt;

// Output to ibuf
assign ipack_ibuf_inst_vld     = ipack_retire_vld && !ipack_buf_stall;
assign ipack_ibuf_inst_vld_raw = ipack_retire_vld;

assign ipack_ibuf_inst[31:0] = ipack_retire_inst[31:0];
assign ipack_ibuf_acc_err    = ipack_acc_err;
assign ipack_ibuf_pgflt      = ipack_pgflt;

assign ipack_pcgen_reissue   = ibuf_ipack_stall && icache_inst_vld;

// Output to top
assign ipack_top_entry0_vld  = entry_vld;
assign ipack_top_entry1_vld  = entry_vld;
assign ipack_top_entry2_vld  = entry_vld;


// &ModuleEnd; @264
endmodule


