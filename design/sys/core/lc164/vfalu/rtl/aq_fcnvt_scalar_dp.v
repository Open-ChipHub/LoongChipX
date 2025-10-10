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
module aq_fcnvt_scalar_dp (
  // &Ports, @27
  input    wire  [15:0]  bhalf0_final_frac,
  input    wire          cp0_vpu_xx_bf16,
  input    wire  [63:0]  double_final_frac,
  input    wire          double_pipe_ex1_special_vld,
  input    wire  [3 :0]  double_pipe_ex2_expt,
  input    wire  [63:0]  double_pipe_ftoi_int,
  input    wire  [63:0]  ex2_int16_0_result,
  input    wire  [63:0]  ex2_int32_0_result,
  input    wire  [63:0]  ex2_int64_result,
  input    wire  [63:0]  ex2_l16_0_result,
  input    wire  [63:0]  ex2_l32_0_result,
  input    wire  [7 :0]  ex2_l8_0_result,
  input    wire  [63:0]  ex3_double_result,
  input    wire          fcnvt_ex1_pipe_clk,
  input    wire          fcnvt_ex1_pipedown,
  input    wire          fcnvt_ex2_pipe_clk,
  input    wire          fcnvt_ex2_pipedown,
  input    wire  [15:0]  half0_final_frac,
  input    wire          ifu_vpu_warm_up,
  input    wire  [31:0]  single0_final_frac,
  input    wire  [19:0]  vpu_group_1_xx_ex1_func,
  input    wire  [63:0]  vpu_group_1_xx_ex1_srcv0,
  input    wire  [47:0]  vpu_group_1_xx_ex1_srcv0_type,
  input    wire  [63:0]  vpu_group_1_xx_ex1_srcv1,
  output   wire  [5 :0]  double_pipe_bhtod_value,
  output   wire  [4 :0]  double_pipe_bhtox_expnt,
  output   wire          double_pipe_ex1_src_cnan,
  output   wire          double_pipe_ex1_src_inf,
  output   wire          double_pipe_ex1_src_qnan,
  output   wire          double_pipe_ex1_src_snan,
  output   wire          double_pipe_ex1_src_zero,
  output   wire  [63:0]  double_pipe_ex2_frac,
  output   wire  [63:0]  double_pipe_ex2_int,
  output   wire  [5 :0]  double_pipe_ex2_widden_dn_itof_expnt,
  output   wire  [4 :0]  double_pipe_htox_expnt,
  output   wire  [8 :0]  double_pipe_htox_value,
  output   wire  [63:0]  double_pipe_special_value,
  output   wire          double_pipe_src_dn,
  output   wire  [4 :0]  double_pipe_stod_expnt,
  output   wire  [21:0]  double_pipe_stod_value,
  output   wire          ex1_dest_bhalf,
  output   wire          ex1_dest_float,
  output   wire          ex1_dest_half,
  output   wire          ex1_dest_si,
  output   wire          ex1_dest_single,
  output   wire  [63:0]  ex1_double_src,
  output   wire  [15:0]  ex1_half0_src,
  output   wire  [7 :0]  ex1_l8_0_src,
  output   wire          ex1_op_bhtod,
  output   wire          ex1_op_bhtos,
  output   wire          ex1_op_dtobh,
  output   wire          ex1_op_dtoh,
  output   wire          ex1_op_dtos,
  output   wire          ex1_op_ftoi,
  output   wire          ex1_op_htod,
  output   wire          ex1_op_htos,
  output   wire          ex1_op_stobh,
  output   wire          ex1_op_stod,
  output   wire          ex1_op_stoh,
  output   wire  [31:0]  ex1_single0_src,
  output   wire          ex1_src_bhalf,
  output   wire          ex1_src_double,
  output   wire          ex1_src_float,
  output   wire          ex1_src_half,
  output   wire          ex1_src_i,
  output   wire          ex1_src_l16,
  output   wire          ex1_src_l32,
  output   wire          ex1_src_l64,
  output   wire          ex1_src_l8,
  output   wire          ex1_src_si,
  output   wire          ex1_src_single,
  output   reg           ex2_bh_quod_up,
  output   wire  [6 :0]  ex2_bhalf0_orig_frac,
  output   wire          ex2_dest_bhalf,
  output   wire          ex2_dest_double,
  output   reg           ex2_dest_float,
  output   wire          ex2_dest_half,
  output   reg           ex2_dest_l16,
  output   reg           ex2_dest_l32,
  output   reg           ex2_dest_l64,
  output   reg           ex2_dest_l8,
  output   reg           ex2_dest_si,
  output   wire          ex2_dest_single,
  output   wire  [51:0]  ex2_double_orig_frac,
  output   reg           ex2_h_quod_up,
  output   wire  [9 :0]  ex2_half0_orig_frac,
  output   reg           ex2_narrow,
  output   reg           ex2_op_itof,
  output   reg           ex2_quod_dn,
  output   wire  [22:0]  ex2_single0_orig_frac,
  output   reg           ex2_src_l16,
  output   reg           ex2_src_l32,
  output   reg           ex2_src_l64,
  output   reg           ex2_widden,
  output   wire  [15:0]  l16_0_itof_value,
  output   wire  [31:0]  l32_0_itof_value,
  output   wire  [63:0]  l64_itof_value,
  output   wire  [63:0]  vfcvt_vpu_ex2_gpr_result,
  output   wire  [4 :0]  vfcvt_vpu_ex3_fflags,
  output   wire  [63:0]  vfcvt_vpu_ex3_fpr_result
); 



// &Regs; @28
reg     [63:0]  ex2_comb_frac;                       
reg     [63:0]  ex2_combin_src;                      
reg             ex2_dest_bhalf_flop;                 
reg     [5 :0]  ex2_left_shift_bit;                  
reg             ex2_src_l8;                          
reg             ex3_dest_l64;                        
reg     [3 :0]  ex3_expt;                            
reg     [63:0]  ex3_result;                          

// &Wires; @29
wire    [63:0]  bhalf0_for_ff1;                      
wire    [15:0]  bhalf0_frac_for_shift;               
wire    [5 :0]  bhtod_shift_bit;                     
wire            cnvt_src0_half0_id;                  
wire            cnvt_src0_half0_inf;                 
wire            cnvt_src0_half0_qnan;                
wire            cnvt_src0_half0_snan;                
wire            cnvt_src0_half0_zero;                
wire            cur_l16;                             
wire            cur_l32;                             
wire            cur_l64;                             
wire            cur_l8;                              
wire    [5 :0]  double_pipe_ex2_itof_expnt;          
wire    [5 :0]  double_pipe_ex2_xtod_expnt;          
wire            ex1_bh_quod_up;                      
wire    [63:0]  ex1_combined_src;                    
wire            ex1_dest_double;                     
wire            ex1_dest_l16;                        
wire            ex1_dest_l32;                        
wire            ex1_dest_l64;                        
wire            ex1_dest_l8;                         
wire            ex1_dest_widden;                     
wire    [63:0]  ex1_final_norm_frac;                 
wire    [5 :0]  ex1_float_shift_bit;                 
wire    [63:0]  ex1_float_src_tail;                  
wire    [63:0]  ex1_ftoi_int;                        
wire            ex1_h_quod_up;                       
wire    [5 :0]  ex1_itof_shift_bit;                  
wire            ex1_l16_0_src_neg;                   
wire            ex1_l32_0_src_neg;                   
wire            ex1_l64_0_src_neg;                   
wire    [5 :0]  ex1_left_shift_bit;                  
wire            ex1_narrow;                          
wire    [63:0]  ex1_norm_neg_src;                    
wire    [63:0]  ex1_norm_src;                        
wire            ex1_op_itof;                         
wire            ex1_quod_dn;                         
wire            ex1_quod_up;                         
wire            ex1_same;                            
wire            ex1_sign;                            
wire    [3 :0]  ex1_size;                            
wire            ex1_special_vld;                     
wire            ex1_src_neg;                         
wire            ex1_widden;                          
wire    [3 :0]  ex2_expt;                            
wire    [63:0]  ex2_frac;                            
wire    [63:0]  ex2_int_r;                           
wire    [63:0]  ex2_scalar_int_result;               
wire    [63:0]  ex2_scalar_total_result;             
wire    [63:0]  ex2_shift_src;                       
wire    [63:0]  ex2_total_result;               
wire    [23:0]  ff1_16_bit;             
wire    [13:0]  ff1_32_bit;                          
wire    [7 :0]  ff1_64_bit;                          
wire    [39:0]  ff1_8_bit;                           
wire    [63:0]  ff1_src_in;                          
wire    [63:0]  half0_for_ff1;                       
wire    [15:0]  half0_frac_for_shift;                
wire    [5 :0]  htox_shift_bit;                      
wire    [5 :0]  i16tof_shift_bit;                    
wire    [5 :0]  i32tof_shift_bit;                    
wire    [5 :0]  i64tof_shift_bit;                    
wire    [63:0]  int_src_for_shift;                   
wire    [15:0]  l16_0_shift_out_val;                 
wire    [15:0]  l16_1_shift_out_val;                 
wire    [15:0]  l16_2_shift_out_val;                 
wire    [15:0]  l16_3_shift_out_val;                 
wire    [31:0]  l32_0_shift_out_val;                 
wire    [31:0]  l32_1_shift_out_val;                 
wire    [63:0]  l64_int_abs_val;                     
wire    [63:0]  l64_shift_out_val;                   
wire    [63:0]  neg_adder_op0;                       
wire    [63:0]  neg_adder_op1;                       
wire    [63:0]  neg_result;                          
wire            shift_16;                            
wire    [2 :0]  shift_src_size;                      
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
wire    [47:0]  srcv0_type;                          
wire    [5 :0]  stod_shift_bit;                      

//cnvt

// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+


//--------------------------------------------
//                    Interface with idu :
//--------------------------------------------
// &Force("output","ex1_dest_si"); @41
// &Force("output","ex1_src_l64"); @42
// &Force("output","ex1_src_l32"); @43
// &Force("output","ex1_src_l16"); @44
// &Force("output","ex1_src_l8"); @45
// //&Force("output","ex1_dest_double"); @46
// &Force("output","ex1_dest_single"); @47
// &Force("output","ex1_dest_float"); @48
// &Force("output","ex1_op_ftoi"); @49
// &Force("bus","vpu_group_1_xx_ex1_func",19,0); @50

wire [19:0] func      = vpu_group_1_xx_ex1_func[19:0];

assign ex1_op_ftoi    = !func[2] && func[1] && !func[0];
assign ex1_op_stod    = func[2] && func[1] && ex1_src_l32;
assign ex1_op_dtos    = func[2] && func[1] && ex1_src_l64;    
assign ex1_op_htos    = 1'b0;
assign ex1_op_bhtos   = 1'b0;
assign ex1_op_stoh    = 1'b0;
assign ex1_op_stobh   = 1'b0;
assign ex1_op_itof    = func[2] && !func[1];
assign ex1_op_bhtod   = 1'b0;
assign ex1_op_htod    = 1'b0;
assign ex1_op_dtoh    = 1'b0;
assign ex1_op_dtobh   = 1'b0;

// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+
assign ex1_narrow     = !func[14] && func[13];
assign ex1_same       = !func[13] && !func[14];
assign ex1_quod_up    = 1'b0;
assign ex1_quod_dn    = 1'b0;

assign ex1_dest_si    = func[3];
assign ex1_dest_widden= func[14] && func[13];
//assign ex1_dest_quod  = vpu_group_1_xx_ex1_func[8];
assign ex1_src_l64    = func[16];
assign ex1_src_l32    = func[15];
assign ex1_src_l16    = 1'b0;
assign ex1_src_l8     = 1'b0;

assign ex1_src_double = ex1_src_l64 && ex1_src_float;
assign ex1_src_single = ex1_src_l32 && ex1_src_float;
assign ex1_src_half   = 1'b0;
assign ex1_src_bhalf  = 1'b0;
assign ex1_h_quod_up  = 1'b0;
assign ex1_bh_quod_up = 1'b0;

assign ex1_src_float  = func[1];
assign ex1_dest_float = func[2];

assign ex1_src_si     = func[0];
assign ex1_src_i      = ~func[1];

assign ex1_dest_l64    = ex1_src_l64 && ex1_same   ||
                         ex1_src_l32 && ex1_widden;
assign ex1_dest_l32    = ex1_src_l32 && ex1_same || 
                         ex1_src_l64 && ex1_narrow;
assign ex1_dest_l16    = 1'b0;
assign ex1_dest_l8     = 1'b0;

assign ex1_dest_double  = ex1_dest_l64 && ex1_dest_float;
assign ex1_dest_single  = ex1_dest_l32 && ex1_dest_float;
assign ex1_dest_half    = 1'b0;
assign ex1_dest_bhalf   = 1'b0;

assign srcv0_type[47:0]          = vpu_group_1_xx_ex1_srcv0_type[47:0];
assign src0_double_snan    = srcv0_type[47];
assign src0_double_qnan    = srcv0_type[46];
assign src0_double_inf    = srcv0_type[45];
assign src0_double_zero    = srcv0_type[44];
assign src0_double_id    = srcv0_type[43];
//assign src0_double_norm    = srcv0_type[42];
assign src0_single0_cnan    = srcv0_type[41];
assign src0_single0_snan    = srcv0_type[40];
assign src0_single0_qnan    = srcv0_type[39];
assign src0_single0_inf    = srcv0_type[38];
assign src0_single0_zero    = srcv0_type[37];
assign src0_single0_id    = srcv0_type[36];
//assign src0_single0_norm    = srcv0_type[35];
assign src0_half0_cnan    = srcv0_type[27];
assign src0_half0_snan    = srcv0_type[26];
assign src0_half0_qnan    = srcv0_type[25];
assign src0_half0_inf     = srcv0_type[24];
assign src0_half0_zero    = srcv0_type[23];
assign src0_half0_id    = srcv0_type[22];
//assign src0_half0_norm    = srcv0_type[21];

assign cnvt_src0_half0_inf   = src0_half0_inf;
assign cnvt_src0_half0_snan  = src0_half0_snan;
assign cnvt_src0_half0_qnan  = src0_half0_qnan;
assign cnvt_src0_half0_zero  = src0_half0_zero;
assign cnvt_src0_half0_id    = src0_half0_id;


assign double_pipe_ex1_src_inf      = ex1_src_double && src0_double_inf 
                                      || ex1_src_single && src0_single0_inf 
                                      || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_inf;
assign double_pipe_ex1_src_qnan     = ex1_src_double && src0_double_qnan 
                                      || ex1_src_single && src0_single0_qnan 
                                      || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_qnan;


assign double_pipe_ex1_src_cnan     = ex1_src_single && src0_single0_cnan || (ex1_src_half || ex1_src_bhalf) && src0_half0_cnan;
assign double_pipe_ex1_src_snan     = ex1_src_double && src0_double_snan || ex1_src_single && src0_single0_snan || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_snan;
assign double_pipe_ex1_src_zero     = ex1_src_double && src0_double_zero || ex1_src_single && src0_single0_zero || (ex1_src_half || ex1_src_bhalf) && cnvt_src0_half0_zero;


assign double_pipe_src_dn            = ex1_src_double && src0_double_id  || 
                                       ex1_src_single && src0_single0_id ||
                                       (ex1_src_half||ex1_src_bhalf)   && cnvt_src0_half0_id; 


assign ex1_norm_src[63:0]            = vpu_group_1_xx_ex1_srcv0[63:0];

assign ex1_double_src[63:0]     = ex1_norm_src[63:0];
assign ex1_single0_src[31:0]    = ex1_norm_src[31:0];
assign ex1_half0_src[15:0]      = ex1_norm_src[15:0];
                                                                 

//================================================
//  mask prepare
//================================================
assign ex1_widden                  = ex1_dest_widden;
//================================================
// ff1 logic
//================================================

assign ex1_sign                 =   ex1_op_itof && ex1_src_si;
assign ex1_size                 =  {ex1_src_l64,ex1_src_l32,ex1_src_l16,ex1_src_l8};
assign ff1_src_in[63:0]         =   ex1_op_itof ? ex1_norm_src[63:0]
                                                : ex1_float_src_tail[63:0];       
assign half0_frac_for_shift[15:0]   = {ex1_norm_src[9:0],6'b0};                                             
assign bhalf0_frac_for_shift[15:0]  = {ex1_norm_src[6:0],9'b0};                                             
assign half0_for_ff1[63:0]          = {48'b0,half0_frac_for_shift[15:0]};
assign bhalf0_for_ff1[63:0]         = {48'b0,bhalf0_frac_for_shift[15:0]};
assign ex1_float_src_tail[63:0]     = {64{ex1_src_l32}}   & {32'b0,ex1_norm_src[22:0],9'b0} |
                                      {64{ex1_src_half}}  & {half0_for_ff1[63:0]}           |
                                      {64{ex1_src_bhalf}} & {bhalf0_for_ff1[63:0]};

// &Instance("aq_vdsp_64_bit_ff1"); @287
aq_vdsp_64_bit_ff1  x_aq_vdsp_64_bit_ff1 (
  .ex1_sign   (ex1_sign  ),
  .ex1_size   (ex1_size  ),
  .ex1_src    (ff1_src_in),
  .ff1_16_bit (ff1_16_bit),
  .ff1_32_bit (ff1_32_bit),
  .ff1_64_bit (ff1_64_bit),
  .ff1_8_bit  (ff1_8_bit )
);


assign  i16tof_shift_bit[5:0]        = {2'b0,ff1_16_bit[3:0]};
assign  i32tof_shift_bit[5:0]        = {1'b0,ff1_32_bit[4:0]};
// &Force("nonport","ff1_8_bit"); @295

assign  i64tof_shift_bit[5:0]        = {ff1_64_bit[5:0]};
assign  ex1_itof_shift_bit[5:0]      = {6{ex1_src_l64}} & i64tof_shift_bit[5:0] |
                                       {6{ex1_src_l32}} & i32tof_shift_bit[5:0] |
                                       {6{ex1_src_l16}} & i16tof_shift_bit[5:0];// |
//                                        {16{ex1_src_l8}}  & i8tof_shift_bit[15:0];
assign  stod_shift_bit[5:0]          = {1'b0,ff1_32_bit[4:0]};
assign double_pipe_stod_expnt[4:0]    = stod_shift_bit[4:0];
// for htox , it is widden or quod up 
assign  htox_shift_bit[5:0]          = {2'b0,ff1_16_bit[3:0]};

assign bhtod_shift_bit[5:0]          = {2'b0,ff1_16_bit[3:0]};
assign ex1_float_shift_bit[5:0]      = {6{ex1_op_stod}} & stod_shift_bit[5:0] |
                                       {6{ex1_op_htos||
                                          ex1_op_htod}}  & htox_shift_bit[5:0]   |
                                       {6{ex1_op_bhtod}} & bhtod_shift_bit[5:0];
assign double_pipe_bhtox_expnt[4:0]   = {1'b0,bhtod_shift_bit[3:0]};
assign double_pipe_htox_expnt[4:0]    = {1'b0,htox_shift_bit[3:0]};
//assign single_pipe_htos_expnt[4:0]    = {1'b0,htox_shift_bit[11:8]};
 // combin the shift and pipe to ex2 stage                                           
assign ex1_left_shift_bit[5:0]       = ex1_op_itof ? ex1_itof_shift_bit[5:0]
                                                   : ex1_float_shift_bit[5:0];
// for the itof negative num, the neg and add1
assign ex1_norm_neg_src[63:0]  = ~ex1_norm_src[63:0];
assign neg_adder_op0[63:0]     = {64{ex1_src_l64}} & {ex1_norm_neg_src[63:0]} | 
                                 {64{ex1_src_l32}} & {{32{ex1_norm_neg_src[31]}},ex1_norm_neg_src[31:0]} |
                                 {64{ex1_src_l16}} & {{48{ex1_norm_neg_src[15]}},ex1_norm_neg_src[15:0]};
assign neg_adder_op1[63:0]     = 64'b1;
// the negative adder 
assign neg_result[63:0]        = neg_adder_op0[63:0] + neg_adder_op1[63:0];

assign ex1_l64_0_src_neg       = ex1_norm_src[63] && ex1_src_si;
assign ex1_l32_0_src_neg       = ex1_norm_src[31] && ex1_src_si;
assign ex1_l16_0_src_neg       = ex1_norm_src[15] && ex1_src_si;
assign ex1_src_neg             = ex1_src_l64 && ex1_l64_0_src_neg ||
                                 ex1_src_l32 && ex1_l32_0_src_neg ||
                                 ex1_src_l16 && ex1_l16_0_src_neg;

assign l64_int_abs_val[63:0]   = ex1_src_neg ? neg_result[63:0]  : ex1_norm_src[63:0];

// the itof abs value
assign int_src_for_shift[63:0] = l64_int_abs_val[63:0];



assign ex1_ftoi_int[63:0]       = double_pipe_ftoi_int[63:0];
// the fraction, the normal f resutl and the value that need shift fraction
// will combined into this flop
assign ex1_final_norm_frac[63:0] = {64{ex1_dest_double}} & double_final_frac[63:0]   |
                                   {64{ex1_dest_single}} & {32'b0,single0_final_frac[31:0]} |
                                   {64{ex1_dest_half}}   & {48'b0,half0_final_frac[15:0]}   |
                                   {64{ex1_dest_bhalf}}  & {48'b0,bhalf0_final_frac[15:0]};

assign ex1_combined_src[63:0]   = ex1_op_itof ? {int_src_for_shift[63:0]} 
                                              : {ex1_final_norm_frac[63:0]};                                            
assign ex1_special_vld        = double_pipe_ex1_special_vld;
always @(posedge fcnvt_ex1_pipe_clk)
begin
  if(fcnvt_ex1_pipedown && ex1_op_ftoi || ifu_vpu_warm_up) begin
    //ex2_combin_src[67:0] <= ex1_combined_src[67:0];
    ex2_combin_src[63:0] <= ex1_ftoi_int[63:0];
  end
end
assign ex2_int_r[63:0]  = ex2_combin_src[63:0];
assign ex2_frac[63:0]   =  ex2_comb_frac[63:0];
assign ex2_shift_src[63:0] = ex2_comb_frac[63:0];


always @(posedge fcnvt_ex1_pipe_clk)
begin
  if(fcnvt_ex1_pipedown && (ex1_dest_float|| ex1_special_vld) || ifu_vpu_warm_up) begin
    //ex2_frac[63:0]           <= ex1_final_norm_frac[63:0];
   //ex2_shift_src[63:0]      <= int_src_for_shift[63:0];
    ex2_comb_frac[63:0]      <= ex1_combined_src[63:0];
    ex2_left_shift_bit[5:0] <= ex1_left_shift_bit[5:0];
  end
end
always @(posedge fcnvt_ex1_pipe_clk)
begin 
  if(fcnvt_ex1_pipedown || ifu_vpu_warm_up) begin
    ex2_narrow      <= ex1_narrow;
    ex2_widden      <= ex1_widden;
    ex2_quod_dn     <= ex1_quod_dn;
    ex2_h_quod_up   <= ex1_h_quod_up;
    ex2_bh_quod_up  <= ex1_bh_quod_up;
    ex2_op_itof     <= ex1_op_itof;
    ex2_src_l64     <= ex1_src_l64;
    ex2_src_l32     <= ex1_src_l32;
    ex2_src_l16     <= ex1_src_l16;
    ex2_src_l8      <= ex1_src_l8;
    ex2_dest_l64    <= ex1_dest_l64;
    ex2_dest_l32    <= ex1_dest_l32;
    ex2_dest_l16    <= ex1_dest_l16;
    ex2_dest_bhalf_flop  <= ex1_dest_bhalf;
    ex2_dest_l8     <= ex1_dest_l8;
    ex2_dest_float  <= ex1_dest_float;
    ex2_dest_si     <= ex1_dest_si;
  end
end

//=============================================
//
// ex2 stage
//=============================================
//ff1 itof expnt                                        
assign double_pipe_ex2_itof_expnt[5:0]= ex2_left_shift_bit[5:0];
assign double_pipe_ex2_xtod_expnt[5:0]= {1'b0,ex2_left_shift_bit[4:0]};
assign double_pipe_ex2_widden_dn_itof_expnt[5:0] = ex2_op_itof ? double_pipe_ex2_itof_expnt[5:0]
                                                               : double_pipe_ex2_xtod_expnt[5:0];
                                        

assign ex2_dest_double              =  ex2_dest_l64 && ex2_dest_float;
assign ex2_dest_single              =  ex2_dest_l32 && ex2_dest_float;
assign ex2_dest_half                =  ex2_dest_l16 && ex2_dest_float && !ex2_dest_bhalf;
assign ex2_dest_bhalf               =   ex2_dest_float && ex2_dest_bhalf_flop;


assign double_pipe_ex2_int[63:0]    = ex2_int_r[63:0];

assign double_pipe_ex2_frac[63:0]    = ex2_frac[63:0];

assign ex2_double_orig_frac[51:0]    = ex2_frac[51:0];
assign ex2_single0_orig_frac[22:0]   = ex2_frac[22:0];

assign ex2_half0_orig_frac[9:0]     = ex2_frac[9:0];
assign ex2_bhalf0_orig_frac[6:0]    = ex2_frac[6:0];

//=====================================================
// ex2 shift :
// itof shift
// stod shift
// htox shift
//=====================================================
assign shift_16             = ex2_src_l16||ex2_src_l8;
assign shift_src_size[2:0]  = {ex2_src_l64,ex2_src_l32,shift_16};
// &Force("output","ex2_src_l64"); @482
// &Force("output","ex2_src_l32"); @483
// &Force("output","ex2_src_l16"); @484

// &Instance("aq_left_shift_64"); @486
aq_left_shift_64  x_aq_left_shift_64 (
  .input_l16_0_shift_cnt   (ex2_left_shift_bit[3:0]),
  .input_l16_1_shift_cnt   (4'b0                   ),
  .input_l16_2_shift_cnt   (4'b0                   ),
  .input_l16_3_shift_cnt   (4'b0                   ),
  .input_l32_0_shift_cnt   (ex2_left_shift_bit[4:0]),
  .input_l32_1_shift_cnt   (5'b0                   ),
  .input_l64_shift_cnt     (ex2_left_shift_bit[5:0]),
  .input_org_src           (ex2_shift_src          ),
  .input_size              (shift_src_size[2:0]    ),
  .l16_0_shift_out_val     (l16_0_shift_out_val    ),
  .l16_1_shift_out_val     (l16_1_shift_out_val    ),
  .l16_2_shift_out_val     (l16_2_shift_out_val    ),
  .l16_3_shift_out_val     (l16_3_shift_out_val    ),
  .l32_0_shift_out_val     (l32_0_shift_out_val    ),
  .l32_1_shift_out_val     (l32_1_shift_out_val    ),
  .l64_shift_out_val       (l64_shift_out_val      )
);


assign l64_itof_value[63:0]   = l64_shift_out_val[63:0];
assign l32_0_itof_value[31:0] = l32_0_shift_out_val[31:0];
assign l16_0_itof_value[15:0] = l16_0_shift_out_val[15:0];
 
assign double_pipe_stod_value[21:0] = l32_0_shift_out_val[30:9];
assign double_pipe_htox_value[8:0]  = l16_0_shift_out_val[14:6];
assign double_pipe_bhtod_value[5:0] = l16_0_shift_out_val[14:9];


//ex2_round_adder



assign double_pipe_special_value[63:0]    =  ex2_frac[63:0];




// &Force("input","ex2_l8_0_result"); @545
// &Force("bus","ex2_l8_0_result",7,0); @546
assign ex2_scalar_total_result[63:0]    = //{64{ex2_dest_l64}} & ex2_l64_result[63:0]                |
                                          {64{ex2_dest_l32}} & {ex2_l32_0_result[63:0]} |
                                          {64{ex2_dest_l16}} & {ex2_l16_0_result[63:0]}; 
assign ex2_scalar_int_result[63:0]      = {64{ex2_dest_l64}} & ex2_int64_result[63:0]     |
                                          {64{ex2_dest_l32}} & {ex2_int32_0_result[63:0]} |
                                          {64{ex2_dest_l16}} & {ex2_int16_0_result[63:0]};       
assign vfcvt_vpu_ex2_gpr_result[63:0]   = ex2_scalar_int_result[63:0];
assign ex2_total_result[63:0]           = ex2_scalar_total_result[63:0];    

assign ex2_expt[3:0]                    = double_pipe_ex2_expt[3:0];
always @(posedge fcnvt_ex2_pipe_clk)
begin
  if(fcnvt_ex2_pipedown) begin
    ex3_result[63:0]     <= ex2_total_result[63:0];
  end
end
always @(posedge fcnvt_ex2_pipe_clk)
begin
  if(fcnvt_ex2_pipedown) begin
    ex3_expt[3:0]      <= ex2_expt[3:0];
    ex3_dest_l64       <= ex2_dest_l64;
  end
end

//------------------------------------------------------------------------------
//                                EX2 pipedown to EX3:
//------------------------------------------------------------------------------



assign vfcvt_vpu_ex3_fpr_result[63:0]             = ex3_dest_l64 ? ex3_double_result[63:0] : ex3_result[63:0];
assign vfcvt_vpu_ex3_fflags[4:0]                  = {ex3_expt[3],1'b0,ex3_expt[2:0]};






// &ModuleEnd; @585
endmodule


