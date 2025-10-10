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
module ct_hpcp_cntinten_reg (
  // &Ports, @23
  input    wire       cntinten_wen_x,
  input    wire       cpurst_b,
  input    wire       hpcp_clk,
  input    wire       hpcp_wdata_x,
  output   reg        cntinten_x
); 



// &Regs; @24

// &Wires @25


always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
      cntinten_x <= 1'b0;
  else if(cntinten_wen_x) 
      cntinten_x <= hpcp_wdata_x;
  else
      cntinten_x <= cntinten_x;
end

// &Force("output","cntinten_x"); @37
// &ModuleEnd; @38
endmodule


