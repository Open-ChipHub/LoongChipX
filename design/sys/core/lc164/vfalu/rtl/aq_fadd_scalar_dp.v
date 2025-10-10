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
module aq_fadd_scalar_dp (
  // &Ports, @27
  input    wire          cp0_vpu_icg_en,
  input    wire          cp0_vpu_xx_bf16,
  input    wire          cp0_yy_clk_en,
  input    wire          double_pipe_ex2_cmp_r,
  input    wire  [4 :0]  double_pipe_ex3_expt,
  input    wire  [8 :0]  ex1_bhalf0_adder_a_final,
  input    wire  [15:0]  ex1_bhalf0_special_data,
  input    wire  [53:0]  ex1_double_adder_a_final,
  input    wire  [63:0]  ex1_double_special_data,
  input    wire  [11:0]  ex1_half0_adder_a_final,
  input    wire  [15:0]  ex1_half0_special_data,
  input    wire  [24:0]  ex1_single0_adder_a_final,
  input    wire  [31:0]  ex1_single0_special_data,
  input    wire  [8 :0]  ex2_bhalf0_rslt,
  input    wire  [53:0]  ex2_double_rslt,
  input    wire  [11:0]  ex2_half0_rslt,
  input    wire  [24:0]  ex2_single0_rslt,
  input    wire          fadd_ex1_pipe_clk,
  input    wire          fadd_ex1_pipedown,
  input    wire          fadd_ex2_pipe_clk,
  input    wire          fadd_ex2_pipedown,
  input    wire  [63:0]  fadd_ex3_bhalf0_rslt,
  input    wire  [63:0]  fadd_ex3_double_rslt,
  input    wire  [63:0]  fadd_ex3_half0_rslt,
  input    wire          fadd_ex3_pipedown,
  input    wire  [63:0]  fadd_ex3_single0_rslt,
  input    wire          forever_cpuclk,
  input    wire          ifu_vpu_warm_up,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [19:0]  vpu_group_1_xx_ex1_func,
  input    wire  [2 :0]  vpu_group_1_xx_ex1_rm,
  input    wire  [63:0]  vpu_group_1_xx_ex1_srcv0,
  input    wire  [47:0]  vpu_group_1_xx_ex1_srcv0_type,
  input    wire  [63:0]  vpu_group_1_xx_ex1_srcv1,
  input    wire  [47:0]  vpu_group_1_xx_ex1_srcv1_type,
  input    wire  [2 :0]  vpu_group_1_xx_ex2_rm,
  output   wire          double_pipe_ex1_src0_cnan,
  output   wire          double_pipe_ex1_src0_id,
  output   wire          double_pipe_ex1_src0_inf,
  output   wire          double_pipe_ex1_src0_qnan,
  output   wire          double_pipe_ex1_src0_snan,
  output   wire          double_pipe_ex1_src0_zero,
  output   wire          double_pipe_ex1_src1_cnan,
  output   wire          double_pipe_ex1_src1_id,
  output   wire          double_pipe_ex1_src1_inf,
  output   wire          double_pipe_ex1_src1_qnan,
  output   wire          double_pipe_ex1_src1_snan,
  output   wire          double_pipe_ex1_src1_zero,
  output   wire  [63:0]  double_pipe_ex2_special_result,
  output   wire          ex1_bhalf,
  output   wire          ex1_double,
  output   wire          ex1_f16,
  output   wire          ex1_half,
  output   wire          ex1_op_add,
  output   wire          ex1_op_add_sub,
  output   wire          ex1_op_cmp,
  output   wire          ex1_op_sel,
  output   wire          ex1_op_sub,
  output   wire          ex1_op_sela,
  output   wire          ex1_rdn,
  output   wire          ex1_single,
  output   reg           ex2_bhalf,
  output   reg           ex2_double,
  output   wire  [53:0]  ex2_double_adder_a,
  output   reg           ex2_half,
  output   reg           ex2_op_add_sub,
  output   reg           ex2_op_cmp,
  output   reg           ex2_op_feq,
  output   reg           ex2_op_fle,
  output   reg           ex2_op_flt,
  output   reg           ex2_op_fne,
  output   reg           ex2_op_faf,
  output   reg           ex2_op_fueq,
  output   reg           ex2_op_fult,
  output   reg           ex2_op_fule,
  output   reg           ex2_op_fune,
  output   reg           ex2_op_fuord, // UN
  output   reg           ex2_op_ford, // OR
  output   reg           ex2_signal,
  output   reg           ex2_op_max,
  output   reg           ex2_op_min,
  output   reg           ex2_op_sel,
  output   reg           ex2_op_sela,
  output   reg           ex2_op_sub,
  output   wire          ex2_rdn,
  output   wire          ex2_rmm,
  output   wire          ex2_rne,
  output   wire          ex2_rtz,
  output   wire          ex2_rup,
  output   reg           ex2_single,
  output   reg           ex3_bhalf,
  output   wire  [8 :0]  ex3_bhalf0_result,
  output   reg           ex3_double,
  output   wire  [53:0]  ex3_double_result,
  output   reg           ex3_half,
  output   wire  [11:0]  ex3_half0_result,
  output   reg           ex3_op_cmp,
  output   reg           ex3_op_sel,
  output   reg           ex3_rdn,
  output   reg           ex3_rtz,
  output   reg           ex3_rup,
  output   reg           ex3_single,
  output   wire  [24:0]  ex3_single0_result,
  output   wire  [63:0]  fadd_double_src0,
  output   wire  [63:0]  fadd_double_src1,
  output   wire          fadd_ex2_nocmp,
  output   wire  [15:0]  fadd_half0_src0,
  output   wire  [15:0]  fadd_half0_src1,
  output   wire  [31:0]  fadd_single0_src0,
  output   wire  [31:0]  fadd_single0_src1,
  output   wire  [63:0]  vfalu_vpu_ex2_gpr_result,
  output   wire          vfalu_vpu_ex2_result_ready_in_ex3,
  output   wire  [4 :0]  vfalu_vpu_ex3_fflags,
  output   wire  [63:0]  vfalu_vpu_ex3_fpr_result,
  output   wire          vfalu_vpu_ex3_result_ready_in_ex4,
  output   wire  [4 :0]  vfalu_vpu_ex4_fflags,
  output   wire  [63:0]  vfalu_vpu_ex4_fpr_result
); 



// &Regs; @28
reg     [53:0]  ex2_adder_a;                      
reg     [63:0]  ex2_special_result;               
reg     [53:0]  ex3_final_rslt;                   
reg     [4 :0]  ex4_expt;                         
reg     [63:0]  ex4_result;                       

// &Wires; @29
wire    [2 :0]  dp_xx_ex1_rm;                     
wire            ex1_bhalf0_src0_id;               
wire            ex1_bhalf0_src1_id;               
wire            ex1_double_src0_id;               
wire            ex1_double_src1_id;               
wire            ex1_half0_src0_id;                
wire            ex1_half0_src1_id;                
wire    [63:0]  ex1_norm_src0;                    
wire    [63:0]  ex1_norm_src1;                    
wire            ex1_op_feq;                       
wire            ex1_op_fle;                       
wire            ex1_op_flt;                       
wire            ex1_op_fne;     
wire            ex1_op_faf;
wire            ex1_op_fueq;
wire            ex1_op_fult;
wire            ex1_op_fule;
wire            ex1_op_fune;
wire            ex1_op_fuord;
wire            ex1_op_ford;
wire            ex1_signal;
wire            ex1_op_max;                       
wire            ex1_op_min;               
wire            ex1_org_f16;                      
wire            ex1_single0_src0_id;              
wire            ex1_single0_src1_id;              
wire            ex1_special_maxmin_pipe_down;     
wire    [63:0]  ex1_special_result_pack;          
wire    [53:0]  ex2_adder_a_pre;                  
wire    [53:0]  ex2_final_rslt_pack;              
wire    [53:0]  ex2_no_cmp_result_pack;           
wire    [53:0]  ex2_nor_final_rslt_pack;          
wire            ex3_ex4_clk;                      
wire            ex3_ex4_clk_en;                   
wire            ex3_ex4_pipe_vld;                 
wire    [4 :0]  ex4_expt_pre;                     
wire    [63:0]  ex4_result_pre;                   
wire            fadd_half0_src0_cnan;             
wire            fadd_half0_src0_id;               
wire            fadd_half0_src0_inf;              
wire            fadd_half0_src0_qnan;             
wire            fadd_half0_src0_snan;             
wire            fadd_half0_src0_zero;             
wire            fadd_half0_src1_cnan;             
wire            fadd_half0_src1_id;               
wire            fadd_half0_src1_inf;              
wire            fadd_half0_src1_qnan;             
wire            fadd_half0_src1_snan;             
wire            fadd_half0_src1_zero;             
wire            fadd_single0_src0_cnan;           
wire            fadd_single0_src0_id;             
wire            fadd_single0_src0_inf;            
wire            fadd_single0_src0_qnan;           
wire            fadd_single0_src0_snan;           
wire            fadd_single0_src0_zero;           
wire            fadd_single0_src1_cnan;           
wire            fadd_single0_src1_id;             
wire            fadd_single0_src1_inf;            
wire            fadd_single0_src1_qnan;           
wire            fadd_single0_src1_snan;           
wire            fadd_single0_src1_zero;           
wire            src0_double_id;                   
wire            src0_double_inf;                  
wire            src0_double_qnan;                 
wire            src0_double_snan;                 
wire            src0_double_zero;                 
wire            src0_half0_cnan;                  
wire            src0_half0_id;                    
wire            src0_half0_inf;                   
wire            src0_half0_qnan;                  
wire            src0_half0_snan;                  
wire            src0_half0_zero;                  
wire            src0_single0_cnan;                
wire            src0_single0_id;                  
wire            src0_single0_inf;                 
wire            src0_single0_qnan;                
wire            src0_single0_snan;                
wire            src0_single0_zero;                
wire            src1_double_id;                   
wire            src1_double_inf;                  
wire            src1_double_qnan;                 
wire            src1_double_snan;                 
wire            src1_double_zero;                 
wire            src1_half0_cnan;                  
wire            src1_half0_id;                    
wire            src1_half0_inf;                   
wire            src1_half0_qnan;                  
wire            src1_half0_snan;                  
wire            src1_half0_zero;                  
wire            src1_single0_cnan;                
wire            src1_single0_id;                  
wire            src1_single0_inf;                 
wire            src1_single0_qnan;                
wire            src1_single0_snan;                
wire            src1_single0_zero;                
wire    [47:0]  srcv0_type;                       
wire    [47:0]  srcv1_type;                       
wire    [2 :0]  vpu_group_0_xx_ex2_rm;            



//==============================================================================
//                     EX1 Operation
//==============================================================================
//------------------------------------------------------------------------------
//                    Interface with idu :
//------------------------------------------------------------------------------



//add and sub
//  a                                       11      10       9
//+------+------+-----+--+--------+------+------+-------+-------+
//|                           fmt   fmt  |scalar | reduc | unord |
//+------+------+-----+--+--------+------+------+-------+-------+

//   8      7           5     4      3      2        1       0
//+------+------+-----+----+------+------+------+-------+-------+
//|rever | add  |      max | add  |      |      | src1_w|       |
//+------+------+-----+----+------+------+------+-------+-------+


//   8      7           5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|rever | add/s |           add  | sub  | dst_w| src1_w|  f    |
//+------+------+-----+--+--------+------+------+-------+-------+





//convert
//  10                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| max |      |      max   max  | min | 
//+------+------+-----+--+--------+------+------+-------+-------+


//compare
//                 6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |  cmp         fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+


//cnvt

// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+

//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|        clas    |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+


//add and sub
//  a                                       11      10       9
//+------+------+-----+--+--------+------+------+-------+-------+
//|                           fmt   fmt  |scalar | reduc | unord |
//+------+------+-----+--+--------+------+------+-------+-------+

//   8      7           5     4      3      2        1       0
//+------+------+-----+----+------+------+------+-------+-------+
//|rever | add  |      max | add  |      |      | src1_w|       |
//+------+------+-----+----+------+------+------+-------+-------+


//   8      7           5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|rever | add/s |           add  | sub  | dst_w| src1_w|  f    |
//+------+------+-----+--+--------+------+------+-------+-------+

//compare
//                 6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |  cmp        fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+

// TBD 
wire [19:0] func       = vpu_group_1_xx_ex1_func[19:0];
assign ex1_op_add_sub  = func[12] | func[11];
assign ex1_op_add      = func[12];
assign ex1_op_sub      = func[11];
// &Force("output","ex1_op_sub"); @129
assign ex1_op_fle      = ex1_op_cmp && func[3:0] == 4'b0110;
assign ex1_op_feq      = ex1_op_cmp && func[3:0] == 4'b0010;
assign ex1_op_flt      = ex1_op_cmp && func[3:0] == 4'b0100;
assign ex1_op_fne      = ex1_op_cmp && func[3:0] == 4'b1000;
assign ex1_op_faf      = ex1_op_cmp && func[3:0] == 4'b0000;
assign ex1_op_fueq     = ex1_op_cmp && func[3:0] == 4'b0011;
assign ex1_op_fult     = ex1_op_cmp && func[3:0] == 4'b0101;
assign ex1_op_fule     = ex1_op_cmp && func[3:0] == 4'b0111;
assign ex1_op_fune     = ex1_op_cmp && func[3:0] == 4'b1010;
assign ex1_op_fuord    = ex1_op_cmp && func[3:0] == 4'b0001;
assign ex1_op_ford     = ex1_op_cmp && func[3:0] == 4'b1001;
assign ex1_signal      = ex1_op_cmp && func[4]; // 是否触发异常
// //&Force("output","ex1_op_ford"); @135
assign ex1_op_max      = func[9];
assign ex1_op_min      = func[8];
assign ex1_op_sela     = func[0];
assign ex1_op_sel      = func[9] | func[8];

assign ex1_op_cmp      = func[10];



assign ex1_single      = func[15];
assign ex1_double      = func[16];
assign ex1_half        = 1'b0 ;
assign ex1_bhalf       = 1'b0;
assign ex1_org_f16     = 1'b0;
assign ex1_f16         = ex1_org_f16;


assign ex1_rdn         = dp_xx_ex1_rm[2:0] == 3'b010;

//------------------------------------------------------------------------------
//                    common special information
//------------------------------------------------------------------------------
//TBD, there will be the inner forward path 
assign  ex1_double_src0_id  = src0_double_id;
assign  ex1_double_src1_id  = src1_double_id;
assign  ex1_single0_src0_id = fadd_single0_src0_id;
assign  ex1_single0_src1_id = fadd_single0_src1_id;
assign  ex1_half0_src0_id = fadd_half0_src0_id;
assign  ex1_half0_src1_id = fadd_half0_src1_id;
assign  ex1_bhalf0_src0_id = fadd_half0_src0_id;
assign  ex1_bhalf0_src1_id = fadd_half0_src1_id;


assign double_pipe_ex1_src0_id = ex1_double  && ex1_double_src0_id  || 
                                 ex1_single  && ex1_single0_src0_id ||
                                (ex1_half)   && ex1_half0_src0_id   ||
                                (ex1_bhalf)  && ex1_bhalf0_src0_id;
assign double_pipe_ex1_src1_id = ex1_double   && ex1_double_src1_id  || 
                                 ex1_single   && ex1_single0_src1_id ||
                                 (ex1_half)   && ex1_half0_src1_id   ||
                                 (ex1_bhalf)  && ex1_bhalf0_src1_id;

// //&Force("output","ex1_half0_src1_id"); @193


 
assign srcv0_type[47:0]          = vpu_group_1_xx_ex1_srcv0_type[47:0];
assign srcv1_type[47:0]          = vpu_group_1_xx_ex1_srcv1_type[47:0];
assign src0_double_snan          = srcv0_type[47];
assign src0_double_qnan          = srcv0_type[46];
assign src0_double_inf           = srcv0_type[45];
assign src0_double_zero          = srcv0_type[44];
assign src0_double_id            = srcv0_type[43];
//assign src0_double_norm        = srcv0_type[42];
assign src0_single0_cnan         = srcv0_type[41];
assign src0_single0_snan         = srcv0_type[40];
assign src0_single0_qnan         = srcv0_type[39];
assign src0_single0_inf          = srcv0_type[38];
assign src0_single0_zero         = srcv0_type[37];
assign src0_single0_id           = srcv0_type[36];
//assign src0_single0_norm         : srcv0_type[35];

assign src0_half0_cnan           = srcv0_type[27];
assign src0_half0_snan           = srcv0_type[26];
assign src0_half0_qnan           = srcv0_type[25];
assign src0_half0_inf            = srcv0_type[24];
assign src0_half0_zero           = srcv0_type[23];
assign src0_half0_id             = srcv0_type[22];
//assign src0_half0_norm           : srcv0_type[21];


assign src1_double_snan          = srcv1_type[47];
assign src1_double_qnan          = srcv1_type[46];
assign src1_double_inf           = srcv1_type[45];
assign src1_double_zero          = srcv1_type[44];
assign src1_double_id            = srcv1_type[43];
//assign src1_double_norm          : srcv1_type[42];
assign src1_single0_cnan         = srcv1_type[41];
assign src1_single0_snan         = srcv1_type[40];
assign src1_single0_qnan         = srcv1_type[39];
assign src1_single0_inf          = srcv1_type[38];
assign src1_single0_zero         = srcv1_type[37];
assign src1_single0_id           = srcv1_type[36];
//assign src1_single0_norm         : srcv1_type[35];
assign src1_half0_cnan           = srcv1_type[27];
assign src1_half0_snan           = srcv1_type[26];
assign src1_half0_qnan           = srcv1_type[25];
assign src1_half0_inf            = srcv1_type[24];
assign src1_half0_zero           = srcv1_type[23];
assign src1_half0_id             = srcv1_type[22];
//assign src1_half0_norm           : srcv1_type[21];



assign fadd_single0_src0_cnan     = src0_single0_cnan;
assign fadd_single0_src1_cnan     = src1_single0_cnan;
assign fadd_half0_src0_cnan       = src0_half0_cnan;
assign fadd_half0_src1_cnan       = src1_half0_cnan;


assign fadd_single0_src0_snan     = src0_single0_snan;
assign fadd_single0_src1_snan     = src1_single0_snan;
assign fadd_half0_src0_snan       = src0_half0_snan;
assign fadd_half0_src1_snan       = src1_half0_snan;

assign fadd_single0_src0_qnan     = src0_single0_qnan;
assign fadd_single0_src1_qnan     = src1_single0_qnan;
assign fadd_half0_src0_qnan       = src0_half0_qnan;
assign fadd_half0_src1_qnan       = src1_half0_qnan;


assign fadd_single0_src0_inf     = src0_single0_inf;
assign fadd_single0_src1_inf     = src1_single0_inf;
assign fadd_half0_src0_inf       = src0_half0_inf;
assign fadd_half0_src1_inf       = src1_half0_inf;

assign fadd_single0_src0_zero     = src0_single0_zero;
assign fadd_single0_src1_zero     = src1_single0_zero;
assign fadd_half0_src0_zero       = src0_half0_zero;
assign fadd_half0_src1_zero       = src1_half0_zero;

assign fadd_single0_src0_id     = src0_single0_id;
assign fadd_single0_src1_id     = src1_single0_id;
assign fadd_half0_src0_id       = src0_half0_id;
assign fadd_half0_src1_id       = src1_half0_id;


assign double_pipe_ex1_src0_cnan = ex1_single  && fadd_single0_src0_cnan || (ex1_half || ex1_bhalf ) && fadd_half0_src0_cnan;
assign double_pipe_ex1_src1_cnan = ex1_single  && fadd_single0_src1_cnan || (ex1_half || ex1_bhalf ) && fadd_half0_src1_cnan;
assign double_pipe_ex1_src0_snan = ex1_double && src0_double_snan || ex1_single && fadd_single0_src0_snan || (ex1_half || ex1_bhalf) && fadd_half0_src0_snan ;
assign double_pipe_ex1_src1_snan = ex1_double && src1_double_snan || ex1_single && fadd_single0_src1_snan || (ex1_half || ex1_bhalf) && fadd_half0_src1_snan ;
assign double_pipe_ex1_src0_qnan = ex1_double && src0_double_qnan || ex1_single &&  fadd_single0_src0_qnan || (ex1_half || ex1_bhalf) && fadd_half0_src0_qnan ;
assign double_pipe_ex1_src1_qnan = ex1_double && src1_double_qnan || ex1_single && fadd_single0_src1_qnan || (ex1_half || ex1_bhalf) && fadd_half0_src1_qnan ;
assign double_pipe_ex1_src0_inf  = ex1_double && src0_double_inf || ex1_single && fadd_single0_src0_inf || (ex1_half || ex1_bhalf) && fadd_half0_src0_inf  ;
assign double_pipe_ex1_src1_inf  = ex1_double && src1_double_inf || ex1_single && fadd_single0_src1_inf || (ex1_half || ex1_bhalf) && fadd_half0_src1_inf  ;
assign double_pipe_ex1_src0_zero = ex1_double && src0_double_zero || ex1_single && fadd_single0_src0_zero || (ex1_half || ex1_bhalf) && fadd_half0_src0_zero ;
assign double_pipe_ex1_src1_zero = ex1_double && src1_double_zero || ex1_single && fadd_single0_src1_zero || (ex1_half || ex1_bhalf) && fadd_half0_src1_zero ;


//================================
//
//  ex1 operand prepare
//
//================================
// the operand will encounter the inner forward data

assign ex1_norm_src0[63:0]         = vpu_group_1_xx_ex1_srcv0[63:0];
assign ex1_norm_src1[63:0]         = vpu_group_1_xx_ex1_srcv1[63:0];

assign fadd_double_src0[63:0]      = vpu_group_1_xx_ex1_srcv0[63:0];
assign fadd_double_src1[63:0]      = vpu_group_1_xx_ex1_srcv1[63:0];

assign fadd_single0_src0[31:0]     = ex1_norm_src0[31:0];
                                                   
assign fadd_single0_src1[31:0]     = ex1_norm_src1[31:0];

                                                     
assign fadd_half0_src0[15:0]       = ex1_norm_src0[15:0];
assign fadd_half0_src1[15:0]       = ex1_norm_src1[15:0];





assign ex2_adder_a_pre[53:0] = {54{ex1_double}} &  ex1_double_adder_a_final[53:0]         |
                               {54{ex1_single}} & {5'b0,24'b0,ex1_single0_adder_a_final[24:0]} |
                               {54{ex1_half}}   & {7'b0,11'b0,
                                                        11'b0,2'b0,
                                                        11'b0,
                                                        ex1_half0_adder_a_final[11:0]} |
                               {54{ex1_bhalf}}  & {10'b0,8'b0,3'b0,
                                                         8'b0,3'b0,2'b0,
                                                         8'b0,3'b0,
                                                         ex1_bhalf0_adder_a_final[8:0]};
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown) begin
    ex2_adder_a[53:0]   <= ex2_adder_a_pre[53:0];
//    ex2_adder_b[127:0]  <= ex2_adder_b_pre[127:0];
//    ex2_ed              <= double_pipe_ed[5];
  end
end

assign ex1_special_result_pack[63:0]  = {64{ex1_double}} & ex1_double_special_data[63:0]    |
                                        {64{ex1_single}} & {32'b0,ex1_single0_special_data[31:0]} |
                                        {64{ex1_half}} & {48'b0,
                                                          ex1_half0_special_data[15:0]}     |
                                        {64{ex1_bhalf}} & {48'b0,
                                                           ex1_bhalf0_special_data[15:0]};                 
assign ex1_special_maxmin_pipe_down = fadd_ex1_pipedown; 
always @(posedge fadd_ex1_pipe_clk)
begin
  if(ex1_special_maxmin_pipe_down) begin
    ex2_special_result[63:0]   <= ex1_special_result_pack[63:0];
  end
end
always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown) begin
    ex2_op_add_sub    <= ex1_op_add_sub;
    ex2_op_sub        <= ex1_op_sub;
    ex2_op_cmp        <= ex1_op_cmp;
    ex2_op_sel        <= ex1_op_sel;
    ex2_op_max        <= ex1_op_max;
    ex2_op_min        <= ex1_op_min;
    ex2_op_sela       <= ex1_op_sela;
    ex2_single        <= ex1_single;
    ex2_double        <= ex1_double;
    ex2_half          <= ex1_half;
    ex2_bhalf         <= ex1_bhalf;
  end
end

assign fadd_ex2_nocmp  = !ex2_op_cmp;

always @(posedge fadd_ex1_pipe_clk)
begin
  if(fadd_ex1_pipedown && ex1_op_cmp || ifu_vpu_warm_up) begin
    ex2_op_fle    <= ex1_op_fle;
    ex2_op_feq    <= ex1_op_feq;
    ex2_op_flt    <= ex1_op_flt;
    ex2_op_fne    <= ex1_op_fne;
    ex2_op_faf    <= ex1_op_faf;
    ex2_op_fueq   <= ex1_op_fueq;
    ex2_op_fult   <= ex1_op_fult;
    ex2_op_fule   <= ex1_op_fule;
    ex2_op_fune   <= ex1_op_fune;
    ex2_op_fuord  <= ex1_op_fuord;
    ex2_op_ford   <= ex1_op_ford;
    ex2_signal    <= ex1_signal;
  end
end

assign ex2_rne      = vpu_group_0_xx_ex2_rm[2:0] == 3'b000;
assign ex2_rtz      = vpu_group_0_xx_ex2_rm[2:0] == 3'b001;
assign ex2_rup      = vpu_group_0_xx_ex2_rm[2:0] == 3'b011;
assign ex2_rdn      = vpu_group_0_xx_ex2_rm[2:0] == 3'b010;
assign ex2_rmm      = vpu_group_0_xx_ex2_rm[2:0] == 3'b100;





//=============================================
//
//  
//  EX2 Stage operation
//
//
//=============================================
assign double_pipe_ex2_special_result[63:0] = ex2_special_result[63:0];


assign ex2_double_adder_a[53:0]  = ex2_adder_a[53:0];



//============================================
//
// the srcv2 merging in, and reduction merging
//
//=============================================
// for the order reduction, the src1 will always been selected
// for unorder, src0/1 will be in exe mask
// for normal exe, the exe mask is maskoff the org resut, using the src2




assign dp_xx_ex1_rm[2:0]   = vpu_group_1_xx_ex1_rm[2:0];
assign vpu_group_0_xx_ex2_rm[2:0]   = vpu_group_1_xx_ex2_rm[2:0];
//assign dp_xx_ex3_rm[2:0]   = vpu_group_1_xx_ex3_rm[2:0];
//============================================
//
// the compare result operation
//
//=============================================
// the compare result will be reserved by 
// the dp,

//compare result    

//assign ex2_cmp_mask[7:0]  = vpu_group_1_xx_ex2_vl_byte_mask[7:0] & vpu_group_1_xx_ex2_vm_byte_mask[7:0];
assign ex2_nor_final_rslt_pack[53:0]       = {54{ex2_double}} & ex2_double_rslt[53:0] | 
                                             {54{ex2_single}} & {4'b0,25'b0,ex2_single0_rslt[24:0]} |
                                             {54{ex2_half}}   & {5'b0,24'b0,
                                                                 1'b0,12'b0,ex2_half0_rslt[11:0]}   |
                                             {54{ex2_bhalf}}  & {8'b0,9'b0,
                                                                 3'b0,9'b0,
                                                            1'b0,3'b0,9'b0,
                                                                 3'b0,ex2_bhalf0_rslt[8:0]};
assign ex2_no_cmp_result_pack[53:0]    = {ex2_nor_final_rslt_pack[53:0]};
assign ex2_final_rslt_pack[53:0]       = ex2_no_cmp_result_pack[53:0];
assign vfalu_vpu_ex2_gpr_result[63:0]  = {63'b0,double_pipe_ex2_cmp_r};

assign vfalu_vpu_ex2_result_ready_in_ex3 = !(ex2_double && !ex2_op_cmp);
always @(posedge fadd_ex2_pipe_clk)
begin
    if(fadd_ex2_pipedown) begin
     ex3_final_rslt[53:0]  <= ex2_final_rslt_pack[53:0];
  end
end

always @(posedge fadd_ex2_pipe_clk)
begin
  if(fadd_ex2_pipedown) begin
    ex3_single  <= ex2_single;
    ex3_double  <= ex2_double;
    ex3_half    <= ex2_half;
    ex3_bhalf   <= ex2_bhalf;
    ex3_op_cmp  <= ex2_op_cmp;
    ex3_op_sel  <= ex2_op_sel;
    ex3_rtz     <= ex2_rtz;
    ex3_rup     <= ex2_rup;
    ex3_rdn     <= ex2_rdn;
  end
end

//============================================
//  ex3 compare result pack
//============================================




//============================================
//
//  ex 3 result
//============================================


assign ex3_double_result[53:0]  = ex3_final_rslt[53:0];
assign ex3_single0_result[24:0] = ex3_final_rslt[24:0];
assign ex3_half0_result[11:0]   = ex3_final_rslt[11:0];
assign ex3_bhalf0_result[8:0]   = ex3_final_rslt[8:0];



assign vfalu_vpu_ex3_fpr_result[63:0]             = {64{ex3_single}} & fadd_ex3_single0_rslt[63:0] |
                                                    {64{ex3_half}}   & fadd_ex3_half0_rslt[63:0]   |
                                                    {64{ex3_bhalf}}  & fadd_ex3_bhalf0_rslt[63:0];
// for the vector compare, the exception will update when the last split
// instruction 
assign vfalu_vpu_ex3_fflags[4:0]                  = double_pipe_ex3_expt[4:0];
assign vfalu_vpu_ex3_result_ready_in_ex4          = (ex3_double );



assign ex4_expt_pre[4:0]                  = double_pipe_ex3_expt[4:0];
assign ex4_result_pre[63:0]               = fadd_ex3_double_rslt[63:0]; 
// &Instance("gated_clk_cell", "x_widden_denorm_clk"); @629
gated_clk_cell  x_widden_denorm_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_ex4_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_ex4_clk_en    ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk         ), @630
//          .external_en (1'b0                   ), @631
//          .global_en   (cp0_yy_clk_en          ), @632
//          .module_en   (cp0_vpu_icg_en         ), @633
//          .local_en    (ex3_ex4_clk_en   ), @634
//          .clk_out     (ex3_ex4_clk      )); @635

assign ex3_ex4_pipe_vld = (ex3_double) && fadd_ex3_pipedown  || ifu_vpu_warm_up;
assign ex3_ex4_clk_en   = ex3_ex4_pipe_vld;


//the next expt generate for unorder reduction
//TBD
always @(posedge ex3_ex4_clk)
begin
    if(ex3_ex4_pipe_vld) begin
        ex4_result[63:0]        <= ex4_result_pre[63:0];
        ex4_expt[4:0]           <= ex4_expt_pre[4:0];
    end
end
assign vfalu_vpu_ex4_fflags[4:0]      = ex4_expt[4:0];
assign vfalu_vpu_ex4_fpr_result[63:0] = ex4_result[63:0];

// &ModuleEnd; @653
endmodule


