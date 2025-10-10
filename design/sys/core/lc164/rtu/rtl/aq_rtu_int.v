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
module aq_rtu_int (
  // &Ports, @25
  input    wire  [14:0]  cp0_rtu_int_vld,
  input    wire  [2 :0]  cp0_rtu_ecfg_vs,
  input    wire          dp_int_ex2_inst_split,
  input    wire          dtu_rtu_int_mask,
  output   wire  [14:0]  int_retire_int_vec,
  output   wire          int_retire_int_vld
); 



// &Regs; @26
reg     [14:0]  int_vec;              

// &Wires; @27
wire            int_vld;              
wire    [14:0]  int_vld_raw;          



//==========================================================
//                        Int Source
//==========================================================
assign int_vld_raw[14:0] = cp0_rtu_int_vld[14:0];


always @( int_vld_raw[14:0])
begin
casez(int_vld_raw[14:0])
  15'b001???????????? : int_vec[14:0] = 15'd12; // IPI
  15'b0001??????????? : int_vec[14:0] = 15'd11; // Timer Int
  15'b00001?????????? : int_vec[14:0] = 15'd10; // PMI 
  15'b000001????????? : int_vec[14:0] = 15'd9;  // HW7
  15'b0000001???????? : int_vec[14:0] = 15'd8;  // HW6
  15'b00000001??????? : int_vec[14:0] = 15'd7;  // HW5
  15'b000000001?????? : int_vec[14:0] = 15'd6;  // HW4
  15'b0000000001????? : int_vec[14:0] = 15'd5;  // HW3
  15'b00000000001???? : int_vec[14:0] = 15'd4;  // HW2
  15'b000000000001??? : int_vec[14:0] = 15'd3;  // HW1
  15'b0000000000001?? : int_vec[14:0] = 15'd2;  // HW0
  15'b00000000000001? : int_vec[14:0] = 15'd1;  // SWI1
  15'b000000000000001 : int_vec[14:0] = 15'd0;  // SWI0
  default             : int_vec[14:0] = {15{1'bx}};
endcase
// &CombEnd; @1245
end

//==========================================================
//                        Int Judge
//==========================================================
assign int_vld = |int_vld_raw[14:0]
                 && !dtu_rtu_int_mask
                 && !dp_int_ex2_inst_split;

//==========================================================
//                          Output
//==========================================================
assign int_retire_int_vld       = int_vld;
assign int_retire_int_vec[14:0] = (cp0_rtu_ecfg_vs[2:0] == 3'b0) ? 
                                {13{1'b0}} 
                              // ecode + 64  
                              : {9'h4, int_vec[3:0]};  // interupt number

// &ModuleEnd; @69
endmodule



