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

// &ModuleBeg; @22
module ct_clk_top (
  // &Ports, @23
  input    wire       biu_xx_dbg_wakeup,
  input    wire       biu_xx_int_wakeup,
  input    wire       biu_xx_normal_work,
  input    wire       biu_xx_pmp_sel,
  input    wire       biu_xx_snoop_vld,
  input    wire       cp0_xx_core_icg_en,
  input    wire       had_xx_clk_en,
  input    wire       pll_core_clk,
  output   wire       coreclk,
  output   wire       forever_coreclk
); 



// &Regs; @24
// &Wires; @25
wire         core_clk_en;       


// &Force("output", "forever_coreclk"); @27

assign forever_coreclk = pll_core_clk;
//==============================================================================
//      global ICG for core 
//==============================================================================
assign core_clk_en = biu_xx_normal_work |
                     biu_xx_int_wakeup | 
                     biu_xx_dbg_wakeup | 
                     biu_xx_snoop_vld |
                     had_xx_clk_en | 
                     biu_xx_pmp_sel |
                     cp0_xx_core_icg_en ;
// &Force("nonport","core_clk_en"); @41
// &Force("output","coreclk"); @42

assign coreclk = forever_coreclk;
// &ModuleEnd; @58
endmodule


