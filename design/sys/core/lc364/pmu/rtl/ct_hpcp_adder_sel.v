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
module ct_hpcp_adder_sel (
  // &Ports, @23
  input    wire  [3 :0]  event00_adder,
  input    wire  [3 :0]  event01_adder,
  input    wire  [3 :0]  event02_adder,
  input    wire  [3 :0]  event03_adder,
  input    wire  [3 :0]  event04_adder,
  input    wire  [3 :0]  event05_adder,
  input    wire  [3 :0]  event06_adder,
  input    wire  [3 :0]  event07_adder,
  input    wire  [3 :0]  event08_adder,
  input    wire  [3 :0]  event09_adder,
  input    wire  [3 :0]  event10_adder,
  input    wire  [3 :0]  event11_adder,
  input    wire  [3 :0]  event12_adder,
  input    wire  [3 :0]  event13_adder,
  input    wire  [3 :0]  event14_adder,
  input    wire  [3 :0]  event15_adder,
  input    wire  [3 :0]  event16_adder,
  input    wire  [3 :0]  event17_adder,
  input    wire  [3 :0]  event18_adder,
  input    wire  [3 :0]  event19_adder,
  input    wire  [3 :0]  event20_adder,
  input    wire  [3 :0]  event21_adder,
  input    wire  [3 :0]  event22_adder,
  input    wire  [3 :0]  event23_adder,
  input    wire  [3 :0]  event24_adder,
  input    wire  [3 :0]  event25_adder,
  input    wire  [3 :0]  event26_adder,
  input    wire  [3 :0]  event27_adder,
  input    wire  [3 :0]  event28_adder,
  input    wire  [3 :0]  event29_adder,
  input    wire  [3 :0]  event30_adder,
  input    wire  [3 :0]  event31_adder,
  input    wire  [3 :0]  event32_adder,
  input    wire  [3 :0]  event33_adder,
  input    wire  [3 :0]  event34_adder,
  input    wire  [3 :0]  event35_adder,
  input    wire  [3 :0]  event36_adder,
  input    wire  [3 :0]  event37_adder,
  input    wire  [3 :0]  event38_adder,
  input    wire  [3 :0]  event39_adder,
  input    wire  [3 :0]  event40_adder,
  input    wire  [3 :0]  event41_adder,
  input    wire  [3 :0]  event42_adder,
  input    wire  [3 :0]  event43_adder,
  input    wire  [3 :0]  event44_adder,
  input    wire  [3 :0]  event45_adder,
  input    wire  [3 :0]  event46_adder,
  input    wire  [3 :0]  event47_adder,
  input    wire  [3 :0]  event48_adder,
  input    wire  [3 :0]  event49_adder,
  input    wire  [3 :0]  event50_adder,
  input    wire  [3 :0]  event51_adder,
  input    wire  [63:0]  mhpmevtx_value,
  output   reg   [3 :0]  mhpmcntx_adder
); 



// &Regs; @24

// &Wires @25




// &Force("bus","mhpmevtx_value",63,0); @29
// &CombBeg; @30
always @( event03_adder[3:0]
       or event27_adder[3:0]
       or event36_adder[3:0]
       or event38_adder[3:0]
       or event35_adder[3:0]
       or event22_adder[3:0]
       or event28_adder[3:0]
       or event31_adder[3:0]
       or event15_adder[3:0]
       or event19_adder[3:0]
       or event09_adder[3:0]
       or event42_adder[3:0]
       or event43_adder[3:0]
       or event44_adder[3:0]
       or event45_adder[3:0]
       or event46_adder[3:0]
       or event47_adder[3:0]
       or event48_adder[3:0]
       or event49_adder[3:0]
       or event50_adder[3:0]
       or event51_adder[3:0]
       or event37_adder[3:0]
       or event14_adder[3:0]
       or event12_adder[3:0]
       or event04_adder[3:0]
       or event23_adder[3:0]
       or event39_adder[3:0]
       or event00_adder[3:0]
       or event01_adder[3:0]
       or event18_adder[3:0]
       or event06_adder[3:0]
       or event16_adder[3:0]
       or event07_adder[3:0]
       or event21_adder[3:0]
       or event08_adder[3:0]
       or event02_adder[3:0]
       or event11_adder[3:0]
       or event13_adder[3:0]
       or event05_adder[3:0]
       or event29_adder[3:0]
       or event41_adder[3:0]
       or event20_adder[3:0]
       or event40_adder[3:0]
       or event10_adder[3:0]
       or event33_adder[3:0]
       or mhpmevtx_value[5:0]
       or event17_adder[3:0]
       or event24_adder[3:0]
       or event34_adder[3:0]
       or event32_adder[3:0]
       or event25_adder[3:0]
       or event26_adder[3:0]
       or event30_adder[3:0])
begin
case(mhpmevtx_value[5:0])
  6'd0   : mhpmcntx_adder[3:0] = event00_adder[3:0];
  6'd1   : mhpmcntx_adder[3:0] = event01_adder[3:0];
  6'd2   : mhpmcntx_adder[3:0] = event02_adder[3:0];
  6'd3   : mhpmcntx_adder[3:0] = event03_adder[3:0];
  6'd4   : mhpmcntx_adder[3:0] = event04_adder[3:0];
  6'd5   : mhpmcntx_adder[3:0] = event05_adder[3:0];
  6'd6   : mhpmcntx_adder[3:0] = event06_adder[3:0];
  6'd7   : mhpmcntx_adder[3:0] = event07_adder[3:0];
  6'd8   : mhpmcntx_adder[3:0] = event08_adder[3:0];
  6'd9   : mhpmcntx_adder[3:0] = event09_adder[3:0];
  6'd10  : mhpmcntx_adder[3:0] = event10_adder[3:0];
  6'd11  : mhpmcntx_adder[3:0] = event11_adder[3:0];
  6'd12  : mhpmcntx_adder[3:0] = event12_adder[3:0];
  6'd13  : mhpmcntx_adder[3:0] = event13_adder[3:0];
  6'd14  : mhpmcntx_adder[3:0] = event14_adder[3:0];
  6'd15  : mhpmcntx_adder[3:0] = event15_adder[3:0];
  6'd16  : mhpmcntx_adder[3:0] = event16_adder[3:0];
  6'd17  : mhpmcntx_adder[3:0] = event17_adder[3:0];
  6'd18  : mhpmcntx_adder[3:0] = event18_adder[3:0];
  6'd19  : mhpmcntx_adder[3:0] = event19_adder[3:0];
  6'd20  : mhpmcntx_adder[3:0] = event20_adder[3:0];
  6'd21  : mhpmcntx_adder[3:0] = event21_adder[3:0];
  6'd22  : mhpmcntx_adder[3:0] = event22_adder[3:0];
  6'd23  : mhpmcntx_adder[3:0] = event23_adder[3:0];
  6'd24  : mhpmcntx_adder[3:0] = event24_adder[3:0];
  6'd25  : mhpmcntx_adder[3:0] = event25_adder[3:0];
  6'd26  : mhpmcntx_adder[3:0] = event26_adder[3:0];
  6'd27  : mhpmcntx_adder[3:0] = event27_adder[3:0];
  6'd28  : mhpmcntx_adder[3:0] = event28_adder[3:0];
  6'd29  : mhpmcntx_adder[3:0] = event29_adder[3:0];
  6'd30  : mhpmcntx_adder[3:0] = event30_adder[3:0];
  6'd31  : mhpmcntx_adder[3:0] = event31_adder[3:0];
  6'd32  : mhpmcntx_adder[3:0] = event32_adder[3:0];
  6'd33  : mhpmcntx_adder[3:0] = event33_adder[3:0];
  6'd34  : mhpmcntx_adder[3:0] = event34_adder[3:0];
  6'd35  : mhpmcntx_adder[3:0] = event35_adder[3:0];
  6'd36  : mhpmcntx_adder[3:0] = event36_adder[3:0];
  6'd37  : mhpmcntx_adder[3:0] = event37_adder[3:0];
  6'd38  : mhpmcntx_adder[3:0] = event38_adder[3:0];
  6'd39  : mhpmcntx_adder[3:0] = event39_adder[3:0];
  6'd40  : mhpmcntx_adder[3:0] = event40_adder[3:0];
  6'd41  : mhpmcntx_adder[3:0] = event41_adder[3:0];
  6'd42  : mhpmcntx_adder[3:0] = event42_adder[3:0];
  6'd43  : mhpmcntx_adder[3:0] = event43_adder[3:0];
  6'd44  : mhpmcntx_adder[3:0] = event44_adder[3:0];
  6'd45  : mhpmcntx_adder[3:0] = event45_adder[3:0];
  6'd46  : mhpmcntx_adder[3:0] = event46_adder[3:0];
  6'd47  : mhpmcntx_adder[3:0] = event47_adder[3:0];
  6'd48  : mhpmcntx_adder[3:0] = event48_adder[3:0];
  6'd49  : mhpmcntx_adder[3:0] = event49_adder[3:0];
  6'd50  : mhpmcntx_adder[3:0] = event50_adder[3:0];
  6'd51  : mhpmcntx_adder[3:0] = event51_adder[3:0];
  default: mhpmcntx_adder[3:0] = {4{1'bx}};
endcase
// &CombEnd; @76
end

// &ModuleEnd; @78
endmodule



