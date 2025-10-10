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
module aq_ifu_ras_entry (
  // &Ports, @24
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          ras_entry_upd,
  input    wire  [23:0]  ras_upd_pc,
  output   wire  [23:0]  ras_entry_pc
); 



// &Regs; @25
reg     [23:0]  entry_pc;          

// &Wires; @26
wire            entry_clk;         
wire            entry_clk_en;      


//==========================================================
// IFU Ras Entry Module
// 1. Instance ICG Cell
// 2. Entry PC
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign entry_clk_en = ras_entry_upd;
// &Instance("gated_clk_cell", "x_ras_entry_icg_cell"); @38
gated_clk_cell  x_ras_entry_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_clk_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @39
//          .external_en (1'b0), @40
//          .global_en   (cp0_yy_clk_en), @41
//          .module_en ( cp0_ifu_icg_en), @42
//          .local_en    (entry_clk_en), @43
//          .clk_out     (entry_clk) @44
//         ); @45

//------------------------------------------------
// 2. Entry PC
//------------------------------------------------
always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    entry_pc[23:0] <= 24'b0;
  end
  else if(ras_entry_upd)
  begin
    entry_pc[23:0] <= ras_upd_pc[23:0];
  end
  else
  begin
    entry_pc[23:0] <= entry_pc[23:0];
  end
end


//==========================================================
// Rename for Output
//==========================================================
assign ras_entry_pc[23:0] = entry_pc[23:0];


// &ModuleEnd; @73
endmodule


