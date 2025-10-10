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
module aq_iu_div_shift2_kernel (
  // &Ports, @24
  input    wire          cpurst_b,
  input    wire          div_align,
  input    wire          div_clk,
  input    wire  [63:0]  div_divisor_reg,
  input    wire  [5 :0]  div_ff1_res,
  input    wire          div_iterating,
  input    wire          div_prepare_src0,
  input    wire          div_prepare_src1,
  input    wire  [63:0]  div_quotient_reg,
  input    wire  [63:0]  div_remainder_reg,
  input    wire          ifu_iu_warm_up,
  output   wire  [63:0]  div_divisor_update_data,
  output   wire          div_iter_cmplt,
  output   wire  [63:0]  div_quotient_reg_updt,
  output   reg   [63:0]  div_remainder_reg_updt
); 



// &Regs; @25
reg     [5 :0]  div_iter_count;             
reg     [1 :0]  div_shift_in;               
reg     [5 :0]  div_src2_count;             

// &Wires; @26
wire    [65:0]  div_divisor_01;             
wire    [65:0]  div_divisor_10;             
wire    [5 :0]  div_iter_count_updt;        
wire            div_iter_count_updt_0;      
wire    [5 :0]  div_iter_sub;               
wire            div_remainder_lt_divisor_01; 
wire            div_remainder_lt_divisor_10; 
wire            div_remainder_lt_divisor_11; 
wire            div_suber_c1_01;            
wire            div_suber_c1_10;            
wire            div_suber_c1_11;            
wire    [65:0]  div_suber_res1_01;          
wire    [65:0]  div_suber_res1_10;          
wire    [65:0]  div_suber_res1_11;          


//==========================================================
//                    2bit Shift Kernel
//==========================================================
// This is shift kernel of divider.
// Each iter product 2-bit result.

// &Force("bus", "div_quotient_reg", 63, 0); @34
//----------------------------------------------------------
//                    Iteration Counter
//----------------------------------------------------------
// Calculate iterations @ WFI2, Decrease iterations @ ITER.
assign div_iter_sub[5:0]          = div_align ? div_src2_count[5:0]
                                              : div_iterating ? 6'b10
                                                              : 6'b0;

assign div_iter_count_updt_0 = div_iter_count[5:0] < div_iter_sub[5:0];
assign div_iter_count_updt[5:0] = div_iter_count_updt_0 ? 6'b0
                                                        : div_iter_count[5:0] - div_iter_sub[5:0];

always @ (posedge div_clk)
begin
  if(ifu_iu_warm_up)
    div_src2_count[5:0] <= 6'b0;
  else if(div_prepare_src1)
    div_src2_count[5:0] <= div_ff1_res[5:0];
end
always @ (posedge div_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    div_iter_count[5:0] <= 6'b0;
  else if (div_prepare_src0)
    div_iter_count[5:0] <= div_ff1_res[5:0];
  else if (div_align || div_iterating)
    div_iter_count[5:0] <= div_iter_count_updt[5:0];
end

assign div_iter_cmplt     = div_iterating && (div_iter_count[5:0] == 6'b0
                                           || div_iter_count[5:0] == 6'b1);
// &Force("output", "div_iter_cmplt"); @66
// //&Force("output", "div_iter_count"); @67

assign div_divisor_update_data[63:0] = div_align ? div_divisor_reg[63:0] << {div_iter_count_updt[5:1], 1'b0} : div_divisor_reg[63:0] >> 2'b10;

//----------------------------------------------------------
//                   Calcuate Interation
//----------------------------------------------------------
// Do iteration compare @ ITER.
// Using divisor x1, x2, x3 compare with remainder to get shift_in and new remainder.
assign div_divisor_01[65:0]                 = {2'b0, div_divisor_reg[63:0]};
assign div_divisor_10[65:0]                 = {1'b0, div_divisor_reg[63:0], 1'b0};
///assign div_divisor_11[33:0]                 = div_divisor_01[33:0] + div_divisor_10[33:0];

assign {div_suber_c1_01, div_suber_res1_01[65:0]} = {3'b0, div_remainder_reg[63:0]} - {1'b0, div_divisor_01[65:0]};
assign {div_suber_c1_10, div_suber_res1_10[65:0]} = {3'b0, div_remainder_reg[63:0]} - {1'b0, div_divisor_10[65:0]};
assign {div_suber_c1_11, div_suber_res1_11[65:0]} = {3'b0, div_remainder_reg[63:0]} - {1'b0, div_divisor_01[65:0]} - {1'b0, div_divisor_10[65:0]};
assign div_remainder_lt_divisor_01          = div_suber_c1_01;
assign div_remainder_lt_divisor_10          = div_suber_c1_10;
assign div_remainder_lt_divisor_11          = div_suber_c1_11;

//----------------------------------------------------------
//                Generate Iteration Results
//----------------------------------------------------------
// &CombBeg; @90
always @( div_remainder_lt_divisor_01
       or div_remainder_lt_divisor_10
       or div_remainder_lt_divisor_11)
begin
  casez({div_remainder_lt_divisor_01, div_remainder_lt_divisor_10, div_remainder_lt_divisor_11})
    3'b1??:  div_shift_in[1:0] = 2'b00;
    3'b01?:  div_shift_in[1:0] = 2'b01;
    3'b001:  div_shift_in[1:0] = 2'b10;
    3'b000:  div_shift_in[1:0] = 2'b11;
    default: div_shift_in[1:0] = {2{1'bx}};
  endcase
// &CombEnd; @98
end

assign div_quotient_reg_updt[63:0]        = {div_quotient_reg[61:0], div_shift_in[1:0]};

// &CombBeg; @102
always @( div_suber_res1_10[63:0]
       or div_suber_res1_01[63:0]
       or div_remainder_lt_divisor_01
       or div_remainder_lt_divisor_10
       or div_suber_res1_11[63:0]
       or div_remainder_reg[63:0]
       or div_remainder_lt_divisor_11)
begin
  casez({div_remainder_lt_divisor_01, div_remainder_lt_divisor_10, div_remainder_lt_divisor_11})
    3'b1??:  div_remainder_reg_updt[63:0] = div_remainder_reg[63:0];
    3'b01?:  div_remainder_reg_updt[63:0] = div_suber_res1_01[63:0];
    3'b001:  div_remainder_reg_updt[63:0] = div_suber_res1_10[63:0];
    3'b000:  div_remainder_reg_updt[63:0] = div_suber_res1_11[63:0];
    default: div_remainder_reg_updt[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @110
end





// &ModuleEnd; @116
endmodule


