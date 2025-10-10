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

// &ModuleBeg; @23
module ct_vfmau_lza_32 (
  // &Ports, @24
  input    wire  [2:0]  lza_precod,
  output   wire         lza_p0,
  output   wire         lza_p1,
  output   wire         lza_vld
); 



// &Regs; @25
// &Wires; @26


assign lza_vld = |lza_precod[2:0];
assign lza_p0  = !lza_precod[2] && lza_precod[1];
assign lza_p1  = !lza_precod[2] && !lza_precod[1];

// &ModuleEnd; @32
endmodule



