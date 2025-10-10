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
module ct_fspu_half (
  // &Ports, @19
  input    wire          check_nan,
  input    wire          ex1_op_fmvvf,
  input    wire          ex1_op_fsgnj,
  input    wire          ex1_op_fsgnjn,
  input    wire          ex1_op_fsgnjx,
  input    wire  [63:0]  ex1_oper0,
  input    wire  [63:0]  ex1_oper1,
  input    wire          ex1_scalar,
  input    wire  [63:0]  mtvr_src0,
  output   wire  [63:0]  ex1_result,
  output   wire  [15:0]  result_fclass,
  output   wire  [63:0]  result_fmfvr
); 



// &Regs; @20
// &Wires; @21
wire            ex1_half_expnt0_max; 
wire            ex1_half_expnt0_zero; 
wire            ex1_half_frac0_all0; 
wire            ex1_half_frac0_msb;  
wire            ex1_half_neg_dn;     
wire            ex1_half_neg_inf;    
wire            ex1_half_neg_nm;     
wire            ex1_half_neg_zero;   
wire            ex1_half_op0_sign;   
wire            ex1_half_pos_dn;     
wire            ex1_half_pos_inf;    
wire            ex1_half_pos_nm;     
wire            ex1_half_pos_zero;   
wire            ex1_half_qnan;       
wire            ex1_half_snan;       
wire            ex1_mtvr_cnan;       
wire            ex1_op0_cnan;        
wire            ex1_op1_cnan;        
wire    [15:0]  ex1_oper0_half;      
wire    [15:0]  ex1_oper1_half;      
wire    [15:0]  mtvr_src0_f;         
wire    [15:0]  result_fclasss;      
wire    [63:0]  result_fmfvrs;       
wire    [63:0]  result_fmtvrs;       
wire    [63:0]  result_fsgnjns;      
wire    [63:0]  result_fsgnjs;       
wire    [63:0]  result_fsgnjxs;      
wire    [47:0]  vfpu_half_default_ext;

// &Force("bus","ex1_oper1",63,0); @22
// assign ex1_op0_cnan    = ex1_scalar && !(&ex1_oper0[63:16]);
assign ex1_op0_cnan    = 1'b0;
// assign ex1_op1_cnan    = ex1_scalar && !(&ex1_oper1[63:16]);
assign ex1_op1_cnan    = 1'b0;

assign ex1_oper0_half[15:0] = (ex1_op0_cnan)
                              ? 16'h7e00
                              : ex1_oper0[15:0];
assign ex1_oper1_half[15:0] = (ex1_op1_cnan)
                              ? 16'h7e00
                              : ex1_oper1[15:0];
//Sign bit prepare                              
assign ex1_half_op0_sign      = ex1_oper0_half[15];   
//exponent max
assign ex1_half_expnt0_max    = &ex1_oper0_half[14:10];
//exponent zero
assign ex1_half_expnt0_zero   = ~|ex1_oper0_half[14:10];
//fraction zero
assign ex1_half_frac0_all0    = ~|ex1_oper0_half[9:0];

//freaction msb
assign ex1_half_frac0_msb     = ex1_oper0_half[9];



//FLASS.S
assign ex1_half_neg_inf  = ex1_half_op0_sign   && ex1_half_expnt0_max  && ex1_half_frac0_all0;
assign ex1_half_neg_nm   = ex1_half_op0_sign   && !ex1_half_expnt0_max && !ex1_half_expnt0_zero;
assign ex1_half_neg_dn   = ex1_half_op0_sign   && ex1_half_expnt0_zero && !ex1_half_frac0_all0;
assign ex1_half_neg_zero = ex1_half_op0_sign   && ex1_half_expnt0_zero && ex1_half_frac0_all0;
assign ex1_half_pos_zero = !ex1_half_op0_sign  && ex1_half_expnt0_zero && ex1_half_frac0_all0;
assign ex1_half_pos_dn   = !ex1_half_op0_sign  && ex1_half_expnt0_zero && !ex1_half_frac0_all0; 
assign ex1_half_pos_nm   = !ex1_half_op0_sign  && !ex1_half_expnt0_max && !ex1_half_expnt0_zero;
assign ex1_half_pos_inf  = !ex1_half_op0_sign  && ex1_half_expnt0_max  && ex1_half_frac0_all0;
assign ex1_half_snan     = ex1_half_expnt0_max && !ex1_half_frac0_all0 && !ex1_half_frac0_msb;
assign ex1_half_qnan     = ex1_half_expnt0_max && ex1_half_frac0_msb;
assign result_fclasss[15:0] = {
                               6'b0,
                               ex1_half_qnan,
                               ex1_half_snan,
                               ex1_half_pos_inf,
                               ex1_half_pos_nm,
                               ex1_half_pos_dn,
                               ex1_half_pos_zero,
                               ex1_half_neg_zero,
                               ex1_half_neg_dn,
                               ex1_half_neg_nm,
                               ex1_half_neg_inf
                              };

// assign vfpu_half_default_ext[47:0] = 48'hffffffffffff;
assign vfpu_half_default_ext[47:0] = 48'h0;

//FSGNJX.S
assign result_fsgnjxs[63:0] = {vfpu_half_default_ext[47:0],
                               ex1_oper0_half[15]^ex1_oper1_half[15],
                               ex1_oper0_half[14:0]};



//FSGNJN.S
assign result_fsgnjns[63:0] = {vfpu_half_default_ext[47:0],
                               ~ex1_oper1_half[15],
                               ex1_oper0_half[14:0]};


//FSGNJ.S
assign result_fsgnjs[63:0]  = {vfpu_half_default_ext[47:0],
                               ex1_oper1_half[15],
                               ex1_oper0_half[14:0]};

// assign ex1_mtvr_cnan        = check_nan && !(&mtvr_src0[63:16]);
// assign mtvr_src0_f[15:0]    = ex1_mtvr_cnan ? 16'h7e00 
//                                         : mtvr_src0[15:0];
assign ex1_mtvr_cnan        = check_nan && !(&mtvr_src0[63:16]);
assign mtvr_src0_f[15:0]    = mtvr_src0[15:0];

//FMV.W.X
assign result_fmtvrs[63:0]  = {vfpu_half_default_ext[47:0],mtvr_src0_f[15:0]};



//FMV.X.W

assign result_fmfvrs[63:0]  = {{48{ex1_oper0[15]}},ex1_oper0[15:0]};

assign result_fmfvr[63:0]   = result_fmfvrs[63:0];


assign result_fclass[15:0]  = result_fclasss[15:0];

//Final Result
assign ex1_result[63:0] = {64{ex1_op_fmvvf}}        & result_fmtvrs[63:0]  | 
                          {64{ex1_op_fsgnj}}       & result_fsgnjs[63:0]  | 
                          {64{ex1_op_fsgnjn}}      & result_fsgnjns[63:0] | 
                          {64{ex1_op_fsgnjx}}      & result_fsgnjxs[63:0]; 
// &ModuleEnd; @113
endmodule


