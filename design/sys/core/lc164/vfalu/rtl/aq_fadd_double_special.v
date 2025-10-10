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

// &ModuleBeg; @26
module aq_fadd_double_special (
  // &Ports, @27
  input    wire          cp0_vpu_xx_dqnan,
  input    wire  [10:0]  dp_maxmin_src_a_e,
  input    wire  [51:0]  dp_maxmin_src_a_f,
  input    wire          dp_maxmin_src_a_s,
  input    wire  [10:0]  dp_maxmin_src_b_e,
  input    wire  [52:0]  dp_maxmin_src_b_f,
  input    wire          dp_maxmin_src_b_s,
  input    wire          dp_maxmin_src_chg,
  input    wire          ex2_act_sub,
  input    wire          ex2_op_add_sub,
  input    wire          ex2_op_cmp,
  input    wire          ex2_signal,
  input    wire          ex2_op_max,
  input    wire          ex2_op_min,
  input    wire          ex2_op_sel,
  input    wire          ex2_op_sub,
  input    wire          ex2_src0_0,
  input    wire          ex2_src0_cnan,
  input    wire          ex2_src0_inf,
  input    wire          ex2_src0_qnan,
  input    wire          ex2_src0_snan,
  input    wire          ex2_src1_0,
  input    wire          ex2_src1_cnan,
  input    wire          ex2_src1_inf,
  input    wire          ex2_src1_qnan,
  input    wire          ex2_src1_snan,
  output   wire  [15:0]  ex2_bhalf0_special_data,
  output   wire          ex2_both_zero,
  output   wire  [63:0]  ex2_double_special_data,
  output   wire  [15:0]  ex2_half0_special_data,
  output   wire          ex2_nv,
  output   wire  [31:0]  ex2_single0_special_data,
  output   wire          ex2_special_value_vld
); 



// &Regs; @28
reg     [15:0]  ex2_bhalf0_special_data_pre; 
reg     [63:0]  ex2_double_special_data_pre; 
reg     [15:0]  ex2_half0_special_data_pre;  
reg     [31:0]  ex2_single0_special_data_pre; 
reg             ex2_special_feq_rst;         
reg             ex2_special_flt_rst;         
reg     [5 :0]  ex2_special_sel_0_a;         
reg     [5 :0]  ex2_special_sel_0_b;         
reg     [8 :0]  ex2_special_sel_1_a;         
reg     [8 :0]  ex2_special_sel_2_a;         
reg     [8 :0]  ex2_special_sel_2_b;         

// &Wires; @29
wire    [6 :0]  ex2_bhalf0_src1_f;           
wire            ex2_cmp_nv;                  
wire    [51:0]  ex2_double_src1_f;             
wire    [9 :0]  ex2_half0_src1_f;            
wire            ex2_nv_add_sub;                  
wire            ex2_nv_inf;                  
wire            ex2_nv_sel;                   
wire    [15:0]  ex2_orig_src0_bhalf;         
wire    [63:0]  ex2_orig_src0_double;        
wire    [15:0]  ex2_orig_src0_half;          
wire            ex2_orig_src0_s;             
wire    [31:0]  ex2_orig_src0_single;        
wire    [15:0]  ex2_orig_src1_bhalf;         
wire    [63:0]  ex2_orig_src1_double;        
wire    [15:0]  ex2_orig_src1_half;          
wire            ex2_orig_src1_s;             
wire    [31:0]  ex2_orig_src1_single;        
wire            ex2_r_inf_sign_0_a;          
wire            ex2_r_inf_sign_0_b;          
wire            ex2_r_inf_sign_0_c;          
wire            ex2_r_inf_sign_2_a;          
wire            ex2_r_inf_sign_2_b;          
wire    [22:0]  ex2_single0_src1_f;           
wire    [6 :0]  ex2_special_sel;             
wire    [5 :0]  ex2_special_sel_0;           
wire    [8 :0]  ex2_special_sel_1;           
wire    [8 :0]  ex2_special_sel_2;           
wire    [8 :0]  ex2_special_sel_final_t;     
wire    [2 :0]  ex2_special_sign_0;          
wire    [2 :0]  ex2_special_sign_1;          
wire    [2 :0]  ex2_special_sign_1_a;        
wire    [2 :0]  ex2_special_sign_2;          
wire    [2 :0]  ex2_special_sign_2_a;        
wire    [2 :0]  ex2_special_sign_2_b;        
wire    [2 :0]  ex2_special_sign_final;      
wire    [31:0]  ex2_src0_bhalf;              
wire    [63:0]  ex2_src0_double;             
wire    [10:0]  ex2_src0_e;                  
wire    [51:0]  ex2_src0_f;                  
wire    [31:0]  ex2_src0_half;               
wire            ex2_src0_nan;                
wire            ex2_src0_s;                  
wire    [31:0]  ex2_src0_single;             
wire    [31:0]  ex2_src1_bhalf;              
wire    [63:0]  ex2_src1_double;             
wire    [10:0]  ex2_src1_e;                  
wire    [31:0]  ex2_src1_half;               
wire            ex2_src1_nan;                
wire            ex2_src1_s;                  
wire    [52:0]  ex2_src1_sel;                
wire    [31:0]  ex2_src1_single;             
wire            ex2_src_chg;                 
wire            fadd_ex2_dp_wb_vld;          
wire            fadd_ex2_float_nv;           
wire            fadd_ex2_rtu_wb_vld;         

//special result calculation
//Add/Sub, all op is add
//|  S0  |  S1  | Result |Result Sign|Result f| Expt|
//  snan           qnan     s0            f0     nv
//         snan |  qnan     s1            f1    nv
//  qnan           qnan     s0            f0
//         qnan    qnan     s1            f1
//   inf   no inf  inf      s0            f0
//   inf    inf    inf      s0
//  no inf  inf    inf      s1            f1
//   inf  - inf    cnan                          nv
//CMP
//|  S0  |  S1  | Result |Result Sign|Result f| Expt|
//  snan            0                            nv
//         snan     0                            nv
//  qnan            0
//         qnan     0
//
//MAX/MIN
//|  S0  |  S1  | Result |Result Sign|Result f| Expt|
//  snan   qnan    snan                          nv
//  snan    nm     qnan                          nv
//  nm     snan    qnan                          nv
//  qnan    nm      nm
//  nm     qnan     nm
// Tips:cnan seem as qnan in op

//assign ex2_src_a_f[52:0]              = dp_maxmin_src_a_f[52:0];
//assign ex2_src_a_e[10:0]              = dp_maxmin_src_a_e[10:0];
//assign ex2_src_a_s                    = dp_maxmin_src_a_s;
//assign ex2_src1_sel[63:0]             = dp_maxmin_src_b[63:0];
assign ex2_src0_f[51:0]              = dp_maxmin_src_a_f[51:0];
assign ex2_src0_e[10:0]              = dp_maxmin_src_a_e[10:0];
assign ex2_src0_s                    = dp_maxmin_src_a_s;
//assign ex2_src1_sel[63:0]             = dp_maxmin_src_b[63:0];

assign ex2_src_chg                    = dp_maxmin_src_chg;
assign ex2_src1_e[10:0]               = dp_maxmin_src_b_e[10:0];
assign ex2_src1_sel[52:0]             = dp_maxmin_src_b_f[52:0];
assign ex2_src1_s                     = dp_maxmin_src_b_s;

//assign ex2_src_chg                    = dp_maxmin_src_chg;

assign ex2_double_src1_f[51:0]        = ex2_src1_sel[51:0];
assign ex2_single0_src1_f[22:0]       = ex2_src1_sel[22:0];
assign ex2_half0_src1_f[9:0]          = ex2_src1_sel[9:0];
assign ex2_bhalf0_src1_f[6:0]         = ex2_src1_sel[6:0];


assign ex2_src0_double[63:0]     = {ex2_src0_s, ex2_src0_e[10:0], ex2_src0_f[51:0]};
assign ex2_src0_single[31:0]     = {ex2_src0_s, ex2_src0_e[ 7:0], ex2_src0_f[22:0]};
assign ex2_src0_half[31:0]       = {16'hffff,ex2_src0_s, ex2_src0_e[ 4:0], ex2_src0_f[9:0]};
assign ex2_src0_bhalf[31:0]      = {16'hffff,ex2_src0_s, ex2_src0_e[ 7:0], ex2_src0_f[6:0]};
                                           
assign ex2_src1_double[63:0]     = {ex2_src1_s, ex2_src1_e[10:0], ex2_double_src1_f[51:0]};
assign ex2_src1_single[31:0]     = {ex2_src1_s, ex2_src1_e[7:0], ex2_single0_src1_f[22:0]};
assign ex2_src1_half[31:0]       = {16'hffff,ex2_src1_s, ex2_src1_e[ 4:0], ex2_half0_src1_f[9:0]};
assign ex2_src1_bhalf[31:0]      = {16'hffff,ex2_src1_s, ex2_src1_e[ 7:0], ex2_bhalf0_src1_f[6:0]};

assign ex2_src0_nan  = ex2_src0_qnan || ex2_src0_snan;
assign ex2_src1_nan  = ex2_src1_qnan || ex2_src1_snan;

assign ex2_both_zero = ex2_src0_0 && ex2_src1_0;


assign ex2_nv_add_sub = ex2_src0_snan || ex2_src1_snan || (ex2_src0_inf && ex2_src1_inf) && ex2_act_sub;
assign ex2_nv_inf     = (ex2_src0_inf && ex2_src1_inf) && ex2_act_sub;
assign ex2_nv_sel     = ex2_src0_snan || ex2_src1_snan;
assign ex2_orig_src0_s = ex2_src_chg ? ex2_src1_s : ex2_src0_s;
assign ex2_orig_src1_s = ex2_src_chg ? ex2_src0_s : ex2_src1_s;

// for add/sub nan
// qnan_src1,qnan_src0,cnan,inf,zero,src2, 6 bit
// &CombBeg; @106
always @( ex2_src0_snan
       or ex2_src1_snan
       or ex2_src0_cnan
       or ex2_src0_qnan
       or ex2_src1_cnan
       or ex2_src1_qnan
       or cp0_vpu_xx_dqnan)
begin
if(ex2_src0_snan && cp0_vpu_xx_dqnan)
  ex2_special_sel_0_a[5:0] = {1'b0, 1'b1, 4'b0};  // src0_qnan
else if(ex2_src1_snan && cp0_vpu_xx_dqnan)
  ex2_special_sel_0_a[5:0] = {1'b1, 5'b0};        // src1_qnan
else if(ex2_src0_cnan && cp0_vpu_xx_dqnan)
  ex2_special_sel_0_a[5:0] = {2'b0, 1'b1, 3'b0};  // cnan
else if(ex2_src0_qnan  && cp0_vpu_xx_dqnan)
  ex2_special_sel_0_a[5:0] = {1'b0, 1'b1, 4'b0};  // src0_qnan
else if(ex2_src1_cnan  && cp0_vpu_xx_dqnan)
  ex2_special_sel_0_a[5:0] = {2'b0, 1'b1, 3'b0};  // cnan
else if(ex2_src1_qnan  && cp0_vpu_xx_dqnan)
  ex2_special_sel_0_a[5:0] = {1'b1, 5'b0};        // src1_qnan
else
  ex2_special_sel_0_a[5:0] = {2'b0, 1'b1, 3'b0};
// &CombEnd; @121
end

// for add/sub inf
// falu,qnan_src2,qnan_src1,qnan_src0,cnan,inf,zero,src2, 8 bit
// &CombBeg; @125
always @( ex2_nv_inf)
begin
  if(ex2_nv_inf)
    ex2_special_sel_0_b[5:0] = {2'b0, 1'b1, 3'b0}; // inf - inf, rst is cnan
  else
    ex2_special_sel_0_b[5:0] = {3'b0, 1'b1, 2'b0}; // inf
// &CombEnd; @130
end
assign ex2_special_sel_0[5:0] = ex2_special_sel_0_b[5:0];

// for both inf
assign ex2_r_inf_sign_0_b      = ex2_orig_src0_s;
// for only one inf
assign ex2_r_inf_sign_0_a      = ex2_src0_inf && ex2_orig_src0_s || ex2_src1_inf && (ex2_orig_src1_s ^ ex2_op_sub);
// merge two situation
assign ex2_r_inf_sign_0_c      = ex2_src0_inf && ex2_src1_inf ? ex2_r_inf_sign_0_b : ex2_r_inf_sign_0_a;
assign ex2_special_sign_0[2:0] = {ex2_r_inf_sign_0_c,2'b0};



// for max/min, has nan
// src1, src0, qnan_src2,qnan_src1,qnan_src0,cnan,inf,zero,src2
// &CombBeg; @145
always @( ex2_src0_snan
       or ex2_src1_snan
       or ex2_src0_qnan
       or ex2_src1_qnan
       or ex2_src0_cnan
       or cp0_vpu_xx_dqnan)
begin
if(ex2_src0_snan && cp0_vpu_xx_dqnan)
  ex2_special_sel_1_a[8:0] = {4'b0, 1'b1, 4'b0};  // qnan_src0
else if(ex2_src1_snan && cp0_vpu_xx_dqnan)
  ex2_special_sel_1_a[8:0] = {3'b0, 1'b1, 5'b0};  // qnan_src1
else if(ex2_src0_qnan && ex2_src1_qnan && !ex2_src0_cnan && cp0_vpu_xx_dqnan)
  ex2_special_sel_1_a[8:0] = {4'b0, 1'b1, 4'b0};  // qnan_src0
else if(ex2_src0_snan || ex2_src1_snan || ex2_src0_qnan && ex2_src1_qnan)
  ex2_special_sel_1_a[8:0] = {5'b0, 1'b1, 3'b0};  // cnan
else if(ex2_src0_qnan)
  ex2_special_sel_1_a[8:0] = {1'b1, 1'b0, 7'b0};  // src1
else// if(ex2_src1_qnan)
  ex2_special_sel_1_a[8:0] = {1'b0, 1'b1, 7'b0};  // src0
// &CombEnd; @158
end

assign ex2_special_sign_1_a[2:0] = 3'b0;


// max inf
// 8      7   
// src1, src0, qnan_src1,qnan_src0,cnan,inf,zero,src2
// &CombBeg; @166
always @( ex2_orig_src0_s
       or ex2_src0_inf
       or ex2_orig_src1_s
       or ex2_src1_inf)
begin
if(ex2_src0_inf && !ex2_orig_src0_s)
  ex2_special_sel_2_a[8:0] = {6'b0, 1'b1, 2'b0}; // +inf
else if(ex2_src0_inf && ex2_orig_src0_s)
  ex2_special_sel_2_a[8:0] = {1'b1, 8'b0};       // src1
else if(ex2_src1_inf && !ex2_orig_src1_s)
  ex2_special_sel_2_a[8:0] = {6'b0, 1'b1, 2'b0}; // +inf
else //if(ex2_src1_inf && ex2_orig_src1_s)
  ex2_special_sel_2_a[8:0] = {1'b0, 1'b1, 7'b0}; // src0
// &CombEnd; @175
end
assign ex2_r_inf_sign_2_a        = ex2_orig_src0_s && ex2_orig_src1_s;
assign ex2_special_sign_2_a[2:0] = {ex2_r_inf_sign_2_a, 2'b0};

// min inf
// src1, src0, qnan_src1,qnan_src0,cnan,inf,zero,src2
// &CombBeg; @181
always @( ex2_orig_src0_s
       or ex2_src0_inf
       or ex2_orig_src1_s
       or ex2_src1_inf)
begin
if(ex2_src0_inf && !ex2_orig_src0_s)
  ex2_special_sel_2_b[8:0] = {1'b1, 8'b0};       // src1
else if(ex2_src0_inf && ex2_orig_src0_s)
  ex2_special_sel_2_b[8:0] = {6'b0, 1'b1, 2'b0}; // -inf
else if(ex2_src1_inf && !ex2_orig_src1_s)
  ex2_special_sel_2_b[8:0] = {1'b0, 1'b1, 7'b0}; // src0
else //if(ex2_src1_inf && ex2_orig_src1_s)
  ex2_special_sel_2_b[8:0] = {6'b0, 1'b1, 2'b0}; // -inf
// &CombEnd; @190
end
assign ex2_r_inf_sign_2_b        =  ex2_orig_src0_s || ex2_orig_src1_s;
assign ex2_special_sign_2_b[2:0] = {ex2_r_inf_sign_2_b, 2'b0};

//max result merge
assign ex2_special_sel_1[8:0]  = (ex2_src0_nan || ex2_src1_nan) ? ex2_special_sel_1_a[8:0]  : ex2_special_sel_2_a[8:0];
assign ex2_special_sign_1[2:0] = (ex2_src0_nan || ex2_src1_nan) ? ex2_special_sign_1_a[2:0] : ex2_special_sign_2_a[2:0];

//min result merge
assign ex2_special_sel_2[8:0]  = (ex2_src0_nan || ex2_src1_nan) ? ex2_special_sel_1_a[8:0]  : ex2_special_sel_2_b[8:0];
assign ex2_special_sign_2[2:0] = (ex2_src0_nan || ex2_src1_nan) ? ex2_special_sign_1_a[2:0] : ex2_special_sign_2_b[2:0];

//assign ex2_special_sel_final[7:0]   = {|ex2_special_sel_final_t[8:7], ex2_special_sel_final_t[6:0]};
assign ex2_special_sel_final_t[8:0] = {9{ex2_op_add_sub}} & {3'b0, ex2_special_sel_0[5:0]} |
                                      {9{ex2_op_max}}     & ex2_special_sel_1[8:0]         |
                                      {9{ex2_op_min}}     & ex2_special_sel_2[8:0];
assign ex2_special_sign_final[2:0]  = {3{ex2_op_add_sub}} & ex2_special_sign_0[2:0] |
                                      {3{ex2_op_max}}     & ex2_special_sign_1[2:0] |
                                      {3{ex2_op_min}}     & ex2_special_sign_2[2:0];

//src1, src0, qnan_src2,qnan_src1,qnan_src0,cnan,inf,zero,src2

assign ex2_special_sel[6:0] = {ex2_special_sel_final_t[8:7],ex2_special_sel_final_t[5:1]};
assign ex2_orig_src1_double[63:0] = ex2_src_chg ? ex2_src0_double[63:0] : ex2_src1_double[63:0];
assign ex2_orig_src0_double[63:0] = ex2_src_chg ? ex2_src1_double[63:0] : ex2_src0_double[63:0];
assign ex2_orig_src1_single[31:0] = ex2_src_chg ? ex2_src0_single[31:0] : ex2_src1_single[31:0];
assign ex2_orig_src0_single[31:0] = ex2_src_chg ? ex2_src1_single[31:0] : ex2_src0_single[31:0];
assign ex2_orig_src1_half[15:0]   = ex2_src_chg ? ex2_src0_half[15:0]   : ex2_src1_half[15:0];
assign ex2_orig_src0_half[15:0]   = ex2_src_chg ? ex2_src1_half[15:0]   : ex2_src0_half[15:0];
assign ex2_orig_src1_bhalf[15:0]  = ex2_src_chg ? ex2_src0_bhalf[15:0]  : ex2_src1_bhalf[15:0];
assign ex2_orig_src0_bhalf[15:0]  = ex2_src_chg ? ex2_src1_bhalf[15:0]  : ex2_src0_bhalf[15:0];
//src1, src0, qnan_src1,qnan_src0,cnan,inf,zero,
// &CombBeg; @222
always @( ex2_orig_src0_double[63:0]
       or ex2_orig_src1_double[63:0]
       or ex2_orig_src1_single[31:0]
       or ex2_orig_src0_half[15:0]
       or ex2_orig_src1_half[15:0]
       or ex2_special_sign_final[2]
       or ex2_orig_src0_bhalf[15:0]
       or ex2_orig_src0_single[31:0]
       or ex2_orig_src1_bhalf[15:0]
       or ex2_special_sel[6:0])
begin
case(ex2_special_sel[6:0])
7'h40: begin
        ex2_double_special_data_pre[63:0]   = ex2_orig_src1_double[63:0];
        ex2_single0_special_data_pre[31:0]  = ex2_orig_src1_single[31:0];
        ex2_half0_special_data_pre[15:0]    = ex2_orig_src1_half[15:0];
        ex2_bhalf0_special_data_pre[15:0]   = ex2_orig_src1_bhalf[15:0];
        end
7'h20: begin
        ex2_double_special_data_pre[63:0]   = ex2_orig_src0_double[63:0];
        ex2_single0_special_data_pre[31:0]  = ex2_orig_src0_single[31:0];
        ex2_half0_special_data_pre[15:0]    = ex2_orig_src0_half[15:0];
        ex2_bhalf0_special_data_pre[15:0]   = ex2_orig_src0_bhalf[15:0];
        end
7'h10: begin
        ex2_double_special_data_pre[63:0]   = {ex2_orig_src1_double[63],{11{1'b1}},1'b1,ex2_orig_src1_double[50:0]};
        ex2_single0_special_data_pre[31:0]  =  {ex2_orig_src1_single[31],{8{1'b1}},1'b1,ex2_orig_src1_single[21:0]}; 
        ex2_half0_special_data_pre[15:0]    =  {ex2_orig_src1_half[15],{5{1'b1}},1'b1,ex2_orig_src1_half[8:0]};
        ex2_bhalf0_special_data_pre[15:0]   =  {ex2_orig_src1_half[15],{8{1'b1}},1'b1,ex2_orig_src1_bhalf[5:0]};
        end 
7'h8: begin
        ex2_double_special_data_pre[63:0]   = {ex2_orig_src0_double[63],{11{1'b1}},1'b1,ex2_orig_src0_double[50:0]};
        ex2_single0_special_data_pre[31:0]  = {ex2_orig_src0_single[31],{8{1'b1}},1'b1,ex2_orig_src0_single[21:0]};
        ex2_half0_special_data_pre[15:0]    = {ex2_orig_src0_half[15],{5{1'b1}},1'b1,ex2_orig_src0_half[8:0]};
        ex2_bhalf0_special_data_pre[15:0]   = {ex2_orig_src0_bhalf[15],{8{1'b1}},1'b1,ex2_orig_src0_bhalf[5:0]};
        end        
7'h4: begin
        ex2_double_special_data_pre[63:0]   = { 1'b0, {11{1'b1}},1'b1, {51{1'b0}} };
        ex2_single0_special_data_pre[31:0]  = { 1'b0, {8{1'b1}},1'b1, {22{1'b0}} };
        ex2_half0_special_data_pre[15:0]   = { 1'b0, {5{1'b1}},1'b1, {9{1'b0}} };
        ex2_bhalf0_special_data_pre[15:0]   = { 1'b0, {8{1'b1}},1'b1, {6{1'b0}} };
        end        
7'h2: begin
        ex2_double_special_data_pre[63:0]   = {ex2_special_sign_final[2],{11{1'b1}},52'b0};
        ex2_single0_special_data_pre[31:0]  = {ex2_special_sign_final[2],{8{1'b1}},23'b0};
        ex2_half0_special_data_pre[15:0]    = {ex2_special_sign_final[2],{5{1'b1}},10'b0};
        ex2_bhalf0_special_data_pre[15:0]   = {ex2_special_sign_final[2],{8{1'b1}},7'b0};
        end        
default: begin
        ex2_double_special_data_pre[63:0]   = 64'h0;
        ex2_single0_special_data_pre[31:0]  = 32'h0;
        ex2_half0_special_data_pre[15:0]   = 16'h0;
        ex2_bhalf0_special_data_pre[15:0]   = 16'h0;
        end  
endcase
// &CombEnd; @267
end
assign ex2_double_special_data[63:0]     = ex2_double_special_data_pre[63:0];
assign ex2_single0_special_data[31:0]    = ex2_single0_special_data_pre[31:0];
assign ex2_half0_special_data[15:0]      = ex2_half0_special_data_pre[15:0];
assign ex2_bhalf0_special_data[15:0]     = ex2_bhalf0_special_data_pre[15:0];



//------------------------------------------------------------------------------
//                    EX2 compare special result:
//------------------------------------------------------------------------------
//cmp instruction
//if src0 or src1 is nan, rst is 0, so just need focus on inf

//flt
// &CombBeg; @282
always @( ex2_src0_inf
       or ex2_src1_inf
       or ex2_orig_src0_s
       or ex2_orig_src1_s)
begin
if(ex2_src0_inf && ex2_src1_inf)
  ex2_special_flt_rst = ex2_orig_src0_s && !ex2_orig_src1_s;
else if(ex2_src0_inf)
  ex2_special_flt_rst = ex2_orig_src0_s;
else//if (ex2_src1_inf)
  ex2_special_flt_rst = !ex2_orig_src1_s;
// &CombEnd; @289
end

//feq
// &CombBeg; @292
always @( ex2_src0_inf
       or ex2_src1_inf
       or ex2_orig_src0_s
       or ex2_orig_src1_s)
begin
if(ex2_src0_inf && ex2_src1_inf)
  ex2_special_feq_rst = ex2_orig_src0_s ^ ~ex2_orig_src1_s;
else //if only one inf
  ex2_special_feq_rst = 1'b0;
// &CombEnd; @297
end



//------------------------------------------------------------------------------
//                   the invalid operation 
//------------------------------------------------------------------------------
assign fadd_ex2_float_nv          = ex2_op_add_sub && ex2_nv_add_sub || ex2_op_sel && ex2_nv_sel;
assign fadd_ex2_dp_wb_vld         = (ex2_src0_inf || ex2_src1_inf) && !ex2_op_cmp;
assign fadd_ex2_rtu_wb_vld        = (ex2_src0_inf || ex2_src1_inf) && ex2_op_cmp;

assign ex2_cmp_nv                 = ex2_op_cmp && ex2_signal && (ex2_src0_snan || ex2_src1_snan);
assign ex2_nv                     = ex2_cmp_nv || fadd_ex2_float_nv;
assign ex2_special_value_vld      = fadd_ex2_dp_wb_vld || fadd_ex2_rtu_wb_vld;

// &ModuleEnd; @324
endmodule


