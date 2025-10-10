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

// &ModuleBeg; @22
module aq_hpcp_adder_sel (
  // &Ports, @23
  input    wire          event01_adder,
  input    wire          event02_adder,
  input    wire          event03_adder,
  input    wire          event04_adder,
  input    wire          event05_adder,
  input    wire          event06_adder,
  input    wire          event07_adder,
  input    wire          event08_adder,
  input    wire          event09_adder,
  input    wire          event10_adder,
  input    wire          event11_adder,
  input    wire          event12_adder,
  input    wire          event13_adder,
  input    wire          event14_adder,
  input    wire          event15_adder,
  input    wire          event16_adder,
  input    wire          event17_adder,
  input    wire          event18_adder,
  input    wire          event19_adder,
  input    wire          event20_adder,
  input    wire          event21_adder,
  input    wire          event22_adder,
  input    wire          event23_adder,
  input    wire          event24_adder,
  input    wire          event25_adder,
  input    wire          event26_adder,
  input    wire          event27_adder,
  input    wire          event28_adder,
  input    wire          event29_adder,
  input    wire          event30_adder,
  input    wire          event31_adder,
  input    wire          event32_adder,
  input    wire          event33_adder,
  input    wire          event34_adder,
  input    wire          event35_adder,
  input    wire          event36_adder,
  input    wire          event37_adder,
  input    wire          event38_adder,
  input    wire          event39_adder,
  input    wire          event40_adder,
  input    wire          event41_adder,
  input    wire          event42_adder,
  input    wire  [63:0]  mhpmevtx_value,
  output   reg           mhpmcntx_adder
); 



// &Regs; @24

// &Wires @25




// &Force("bus","mhpmevtx_value",63,0); @29
// &CombBeg; @30
always @( event06_adder
       or event41_adder
       or event07_adder
       or event21_adder
       or event32_adder
       or event10_adder
       or event13_adder
       or event05_adder
       or event04_adder
       or event19_adder
       or event36_adder
       or event29_adder
       or event15_adder
       or event16_adder
       or event11_adder
       or event39_adder
       or event33_adder
       or event27_adder
       or event20_adder
       or event17_adder
       or event23_adder
       or event24_adder
       or event01_adder
       or event26_adder
       or event30_adder
       or event25_adder
       or event09_adder
       or event42_adder
       or event34_adder
       or event02_adder
       or event03_adder
       or event28_adder
       or event35_adder
       or event37_adder
       or event18_adder
       or event38_adder
       or event31_adder
       or event12_adder
       or event40_adder
       or mhpmevtx_value[5:0]
       or event14_adder
       or event22_adder
       or event08_adder)
begin
case(mhpmevtx_value[5:0])
  6'd1   : mhpmcntx_adder = event01_adder;
  6'd2   : mhpmcntx_adder = event02_adder;
  6'd3   : mhpmcntx_adder = event03_adder;
  6'd4   : mhpmcntx_adder = event04_adder;
  6'd5   : mhpmcntx_adder = event05_adder;
  6'd6   : mhpmcntx_adder = event06_adder;
  6'd7   : mhpmcntx_adder = event07_adder;
  6'd8   : mhpmcntx_adder = event08_adder;
  6'd9   : mhpmcntx_adder = event09_adder;
  6'd10  : mhpmcntx_adder = event10_adder;
  6'd11  : mhpmcntx_adder = event11_adder;
  6'd12  : mhpmcntx_adder = event12_adder;
  6'd13  : mhpmcntx_adder = event13_adder;
  6'd14  : mhpmcntx_adder = event14_adder;
  6'd15  : mhpmcntx_adder = event15_adder;
  6'd16  : mhpmcntx_adder = event16_adder;
  6'd17  : mhpmcntx_adder = event17_adder;
  6'd18  : mhpmcntx_adder = event18_adder;
  6'd19  : mhpmcntx_adder = event19_adder;
  6'd20  : mhpmcntx_adder = event20_adder;
  6'd21  : mhpmcntx_adder = event21_adder;
  6'd22  : mhpmcntx_adder = event22_adder;
  6'd23  : mhpmcntx_adder = event23_adder;
  6'd24  : mhpmcntx_adder = event24_adder;
  6'd25  : mhpmcntx_adder = event25_adder;
  6'd26  : mhpmcntx_adder = event26_adder;
  6'd27  : mhpmcntx_adder = event27_adder;
  6'd28  : mhpmcntx_adder = event28_adder;
  6'd29  : mhpmcntx_adder = event29_adder;
  6'd30  : mhpmcntx_adder = event30_adder;
  6'd31  : mhpmcntx_adder = event31_adder;
  6'd32  : mhpmcntx_adder = event32_adder;
  6'd33  : mhpmcntx_adder = event33_adder;
  6'd34  : mhpmcntx_adder = event34_adder;
  6'd35  : mhpmcntx_adder = event35_adder;
  6'd36  : mhpmcntx_adder = event36_adder;
  6'd37  : mhpmcntx_adder = event37_adder;
  6'd38  : mhpmcntx_adder = event38_adder;
  6'd39  : mhpmcntx_adder = event39_adder;
  6'd40  : mhpmcntx_adder = event40_adder;
  6'd41  : mhpmcntx_adder = event41_adder;
  6'd42  : mhpmcntx_adder = event42_adder;
  default: mhpmcntx_adder = 1'bx;
endcase
// &CombEnd; @76
end

// &ModuleEnd; @78
endmodule



