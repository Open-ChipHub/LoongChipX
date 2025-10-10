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

// &ModuleBeg; @24
module ct_idu_is_aiq_lch_rdy_3 (
  // &Ports, @25
  input    wire         cpurst_b,
  input    wire         vld,
  input    wire         x_create_dp_en,
  input    wire  [1:0]  x_create_entry,
  input    wire  [2:0]  x_create_lch_rdy,
  input    wire         y_clk,
  input    wire         y_create0_dp_en,
  input    wire  [2:0]  y_create0_src_match,
  input    wire         y_create1_dp_en,
  input    wire  [2:0]  y_create1_src_match,
  output   reg   [2:0]  x_read_lch_rdy
); 



// &Regs; @26
reg     [2:0]  lch_rdy;            

// &Wires; @27
wire           lch_rdy_create0_en; 
wire           lch_rdy_create1_en; 



parameter WIDTH = 3;
//==========================================================
//                     Preg Register
//==========================================================
assign lch_rdy_create0_en = y_create0_dp_en && x_create_entry[0];
assign lch_rdy_create1_en = y_create1_dp_en && x_create_entry[1];

always @(posedge y_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    lch_rdy[WIDTH-1:0] <= {WIDTH{1'b0}};
  else if(x_create_dp_en)
    lch_rdy[WIDTH-1:0] <= x_create_lch_rdy[WIDTH-1:0];
  else if(vld && lch_rdy_create0_en)
    lch_rdy[WIDTH-1:0] <= y_create0_src_match[WIDTH-1:0];
  else if(vld && lch_rdy_create1_en)
    lch_rdy[WIDTH-1:0] <= y_create1_src_match[WIDTH-1:0];
  else
    lch_rdy[WIDTH-1:0] <= lch_rdy[WIDTH-1:0];
end

//==========================================================
//                      Read Port
//==========================================================
// &CombBeg; @54
always @( y_create0_src_match[2:0]
       or lch_rdy[2:0]
       or y_create1_src_match[2:0]
       or lch_rdy_create1_en
       or lch_rdy_create0_en)
begin
  case({lch_rdy_create1_en,lch_rdy_create0_en})
    2'b01  : x_read_lch_rdy[WIDTH-1:0] = y_create0_src_match[WIDTH-1:0];
    2'b10  : x_read_lch_rdy[WIDTH-1:0] = y_create1_src_match[WIDTH-1:0];
    default: x_read_lch_rdy[WIDTH-1:0] = lch_rdy[WIDTH-1:0];
  endcase
// &CombEnd; @60
end

// &ModuleEnd; @62
endmodule


