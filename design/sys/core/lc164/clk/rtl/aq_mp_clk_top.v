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
module aq_mp_clk_top (
  // &Ports, @24
  input    wire       axim_clk_en,
  input    wire       clkgen_rst_b,
  input    wire       pad_yy_scan_mode,
  input    wire       pll_core_cpuclk,
  output   wire       apb_clk,
  output   wire       apb_clk_en,
  output   reg        axim_clk_en_f,
  output   wire       forever_cpuclk
); 



// &Regs; @25
reg          apb_clk_en_f;     
reg          peripheral_clk_en; 

// &Wires; @26


// &Depend("BUFGCE.v"); @28
// &Force("output","forever_cpuclk"); @29

assign forever_cpuclk = pll_core_cpuclk;

//================================================
//            APB CLOCK
//================================================
// &Force("output", "apb_clk_en"); @36

always@(posedge forever_cpuclk or negedge clkgen_rst_b)
begin
  if (!clkgen_rst_b)
    peripheral_clk_en <= 1'b0;
  else
    peripheral_clk_en <= ~peripheral_clk_en;
end

always@(posedge forever_cpuclk)
begin
  apb_clk_en_f <= peripheral_clk_en;
end

assign apb_clk_en = pad_yy_scan_mode ? 1'b1 : apb_clk_en_f;

// &Force("output","apb_clk"); @54
assign apb_clk = forever_cpuclk;

// &Instance("gated_clk_cell", "x_apb_gated_clk"); @62
// &Connect(.clk_in      (forever_cpuclk), @63
//          .external_en (1'b0          ), @64
//          .global_en   (1'b1          ), @65
//          .module_en   (1'b0          ), @66
//          .local_en    (apb_clk_en_f  ), @67
//          .clk_out     (apb_clk       ) @68
//          .pad_yy_icg_scan_en (1'b0) @69
// ); @70


//================================================
//           AXIM CLK_EN
//================================================
// &Force("output", "axim_clk_en_f"); @77

always@(posedge forever_cpuclk)
begin
  axim_clk_en_f <= axim_clk_en;
end

////================================================
////            JTAG_CLOCK
////================================================
//
//assign forever_jtgclk = pad_had_jtg_tclk;

// &ModuleEnd; @90
endmodule


