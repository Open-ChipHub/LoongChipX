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
// &ModuleBeg; @24
module aq_ifu_ibuf_entry (
  // &Ports, @25
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          ibuf_cpuclk,
  input    wire          ibuf_create0_acc_err,
  input    wire  [21:0]  ibuf_create0_halt_info,
  input    wire  [31:0]  ibuf_create0_inst,
  input    wire          ibuf_create0_pgflt,
  input    wire  [1 :0]  ibuf_create0_pred_taken,
  input    wire          ibuf_entry_create0_data_en,
  input    wire          ibuf_entry_create0_en,
  input    wire          ibuf_entry_retire0_en,
  input    wire          ibuf_flush_en,
  input    wire          pad_yy_icg_scan_en,
  input    wire          vec_ibuf_warm_up,
  output   wire          ibuf_entry_acc_err,
  output   wire  [21:0]  ibuf_entry_halt_info,
  output   wire  [31:0]  ibuf_entry_inst,
  output   wire          ibuf_entry_pgflt,
  output   wire  [1 :0]  ibuf_entry_pred_taken,
  output   wire          ibuf_entry_vld
); 



// &Regs; @26
reg             entry_acc_err;             
reg     [21:0]  entry_halt_info;           
reg     [31:0]  entry_inst;                
reg             entry_pgflt;               
reg     [1 :0]  entry_pred_taken;          
reg             entry_vld;                 

// &Wires; @27
wire            entry_acc_err_upd;         
wire            entry_cpuclk;              
wire            entry_create;              
wire            entry_data_create;         
wire    [21:0]  entry_halt_info_upd;       
wire            entry_icg_create;          
wire            entry_icg_en;              
wire    [31:0]  entry_inst_upd;            
wire            entry_pgflt_upd;           
wire    [1 :0]  entry_pred_taken_upd;      
wire            entry_retire;              


//==========================================================
// Instruction Buffer Entry Module
// 1. Instance ICG cell 
// 2. Entry Content
//==========================================================

//------------------------------------------------
// 1. Instace ICG cell
//------------------------------------------------
assign entry_icg_create = ibuf_entry_create0_data_en;
assign entry_icg_en = entry_icg_create || vec_ibuf_warm_up;
// &Instance("gated_clk_cell", "x_ibuf_data_icg_cell"); @42
gated_clk_cell  x_ibuf_data_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_cpuclk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_icg_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @43
//          .external_en (1'b0), @44
//          .global_en   (cp0_yy_clk_en), @45
//          .module_en ( cp0_ifu_icg_en), @46
//          .local_en    (entry_icg_en), @47
//          .clk_out     (entry_cpuclk)); @48

//------------------------------------------------
// 2. Entry Content
// a. Entry Create and Retire Signal
// b. Entry Valid Signal
// c. Entry Instruction
//------------------------------------------------
// a. Entry Create and Retire Signal
assign entry_create  = ibuf_entry_create0_en;
assign entry_data_create = ibuf_entry_create0_en;
assign entry_retire  = ibuf_entry_retire0_en;

// b. Entry Valid Signal
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_vld <= 1'b0;
  else if(ibuf_flush_en)
    entry_vld <= 1'b0;
  else if(entry_create)
    entry_vld <= 1'b1;
  else if(entry_retire)
    entry_vld <= 1'b0;
  else
    entry_vld <= entry_vld;
end

// c. Entry Instruction
assign entry_inst_upd[31:0] = {32{ibuf_entry_create0_data_en}} & ibuf_create0_inst[31:0];

always @(posedge entry_cpuclk)
begin
  if(entry_data_create || vec_ibuf_warm_up)
    entry_inst[31:0] <= entry_inst_upd[31:0];
  else
    entry_inst[31:0] <= entry_inst[31:0];
end

//==========================================================
// Instruction Predict Taken
//==========================================================
assign entry_pred_taken_upd[1:0] = {2{ibuf_entry_create0_data_en}} & ibuf_create0_pred_taken[1:0];

assign entry_halt_info_upd[`TDT_HINFO_WIDTH-1:0] = {`TDT_HINFO_WIDTH{ibuf_entry_create0_data_en}} & ibuf_create0_halt_info[`TDT_HINFO_WIDTH-1:0];

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_pred_taken[1:0] <= 2'b0;
  else if(entry_data_create)
    entry_pred_taken[1:0] <= entry_pred_taken_upd[1:0];
  else
    entry_pred_taken[1:0] <= entry_pred_taken[1:0];
end

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= {`TDT_HINFO_WIDTH{1'b0}};
  else if(entry_data_create)
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= entry_halt_info_upd[`TDT_HINFO_WIDTH-1:0];
  else
    entry_halt_info[`TDT_HINFO_WIDTH-1:0] <= entry_halt_info[`TDT_HINFO_WIDTH-1:0];
end

//==========================================================
// Instruction Bus Access Error
//==========================================================
assign entry_acc_err_upd = ibuf_entry_create0_data_en && ibuf_create0_acc_err;

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_acc_err <= 1'b0;
  else if(entry_data_create)
    entry_acc_err <= entry_acc_err_upd;
  else
    entry_acc_err <= entry_acc_err;
end

assign entry_pgflt_upd = ibuf_entry_create0_data_en && ibuf_create0_pgflt;

always @(posedge entry_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_pgflt <= 1'b0;
  else if(entry_data_create)
    entry_pgflt <= entry_pgflt_upd;
  else
    entry_pgflt <= entry_pgflt;
end

//==========================================================
// Rename for Output
//==========================================================

assign ibuf_entry_vld             = entry_vld;
assign ibuf_entry_inst[31:0]      = entry_inst[31:0];
assign ibuf_entry_pred_taken[1:0] = entry_pred_taken[1:0];
assign ibuf_entry_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry_halt_info[`TDT_HINFO_WIDTH-1:0];
assign ibuf_entry_acc_err         = entry_acc_err;
assign ibuf_entry_pgflt           = entry_pgflt;


// &ModuleEnd; @169
endmodule


