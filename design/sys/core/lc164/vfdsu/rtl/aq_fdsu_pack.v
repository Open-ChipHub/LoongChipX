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
module aq_fdsu_pack (
  // &Ports, @24
  input    wire  [6 :0]  bhalf0_denorm_shift_num,
  input    wire  [7 :0]  bhalf0_ex4_qnan_f,
  input    wire  [51:0]  double_denorm_shift_num,
  input    wire  [52:0]  double_ex4_qnan_f,
  input    wire          double_pipe_ex4_denorm_to_tiny_frac,
  input    wire          double_pipe_ex4_dz,
  input    wire  [12:0]  double_pipe_ex4_expnt_rst,
  input    wire          double_pipe_ex4_nv,
  input    wire          double_pipe_ex4_nx,
  input    wire          double_pipe_ex4_of,
  input    wire          double_pipe_ex4_of_rm_lfn,
  input    wire  [1 :0]  double_pipe_ex4_potnt_norm,
  input    wire          double_pipe_ex4_potnt_of,
  input    wire          double_pipe_ex4_potnt_uf,
  input    wire          double_pipe_ex4_result_inf,
  input    wire          double_pipe_ex4_result_lfn,
  input    wire          double_pipe_ex4_result_nor,
  input    wire          double_pipe_ex4_result_qnan,
  input    wire          double_pipe_ex4_result_sign,
  input    wire          double_pipe_ex4_result_zero,
  input    wire          double_pipe_ex4_rslt_denorm,
  input    wire          double_pipe_ex4_uf,
  input    wire  [54:0]  double_pipe_fdsu_ex4_frac,
  input    wire          fdsu_ex4_bhalf,
  input    wire          fdsu_ex4_double,
  input    wire          fdsu_ex4_half,
  input    wire          fdsu_ex4_single,
  input    wire  [9 :0]  half0_denorm_shift_num,
  input    wire  [10:0]  half0_ex4_qnan_f,
  input    wire  [22:0]  single0_denorm_shift_num,
  input    wire  [23:0]  single0_ex4_qnan_f,
  output   wire  [6 :0]  bhalf0_denorm_shift_num_in,
  output   wire  [8 :0]  bhalf0_denorm_shift_val,
  output   wire          bhalf0_denorm_to_tiny_frac,
  output   wire  [51:0]  double_denorm_shift_num_in,
  output   wire  [11:0]  double_denorm_shift_val,
  output   wire          double_denorm_to_tiny_frac,
  output   wire  [4 :0]  double_pipe_ex4_expt,
  output   wire  [63:0]  double_pipe_ex4_result,
  output   wire  [9 :0]  half0_denorm_shift_num_in,
  output   wire  [5 :0]  half0_denorm_shift_val,
  output   wire          half0_denorm_to_tiny_frac,
  output   wire  [22:0]  single0_denorm_shift_num_in,
  output   wire  [8 :0]  single0_denorm_shift_val,
  output   wire          single0_denorm_to_tiny_frac
); 



// &Regs; @25
reg     [6 :0]  bhalf_denorm_frac;                  
reg     [51:0]  double_denorm_frac;                 
reg     [51:0]  ex4_frac_52;                        
reg     [63:0]  ex4_result;                         
reg     [12:0]  expnt_add_op1;                      
reg     [9 :0]  half_denorm_frac;                   
reg     [22:0]  single_denorm_frac;                 

// &Wires; @26
wire    [63:0]  ex4_bhalf_lfn;                      
wire    [63:0]  ex4_bhalf_rst_inf;                  
wire    [63:0]  ex4_bhalf_rst_norm;                 
wire            ex4_cor_nx;                         
wire            ex4_cor_uf;                         
wire            ex4_denorm_potnt_norm;              
wire    [63:0]  ex4_denorm_result;                  
wire    [63:0]  ex4_doub_lfn;                       
wire    [63:0]  ex4_doub_rst_inf;                   
wire    [63:0]  ex4_doub_rst_norm;                  
wire    [12:0]  ex4_expnt_rst;                      
wire    [4 :0]  ex4_expt;                           
wire            ex4_final_rst_norm;                 
wire    [54:0]  ex4_frac;                           
wire    [63:0]  ex4_half_lfn;                       
wire    [63:0]  ex4_half_rst_inf;                   
wire    [63:0]  ex4_half_rst_norm;                  
wire            ex4_of_plus;                        
wire            ex4_result_inf;                     
wire            ex4_result_lfn;                     
wire            ex4_result_zero;                    
wire            ex4_rslt_denorm;                    
wire            ex4_rslt_qnan;                      
wire    [63:0]  ex4_rst_inf;                        
wire    [63:0]  ex4_rst_lfn;                        
wire            ex4_rst_nor;                        
wire    [63:0]  ex4_rst_norm;                       
wire    [63:0]  ex4_rst_qnan;                       
wire    [63:0]  ex4_rst_zero;                       
wire    [63:0]  ex4_sing_lfn;                       
wire    [63:0]  ex4_sing_rst_inf;                   
wire    [63:0]  ex4_sing_rst_norm;                  
wire            ex4_uf_plus;                        
wire            fdsu_ex4_dz;                        
wire    [12:0]  fdsu_ex4_expnt_rst;                 
wire            fdsu_ex4_nv;                        
wire            fdsu_ex4_nx;                        
wire            fdsu_ex4_of;                        
wire            fdsu_ex4_of_rst_lfn;                
wire    [1 :0]  fdsu_ex4_potnt_norm;                
wire            fdsu_ex4_potnt_of;                  
wire            fdsu_ex4_potnt_uf;                  
wire            fdsu_ex4_result_inf;                
wire            fdsu_ex4_result_lfn;                
wire            fdsu_ex4_result_nor;                
wire            fdsu_ex4_result_sign;               
wire            fdsu_ex4_rslt_denorm;               
wire            fdsu_ex4_uf;                        


assign fdsu_ex4_result_sign     = double_pipe_ex4_result_sign;
assign fdsu_ex4_of_rst_lfn      = double_pipe_ex4_of_rm_lfn;
//assign fdsu_ex4_double          = fdsu_yy_double;
//assign fdsu_ex4_single          
assign fdsu_ex4_result_inf      = double_pipe_ex4_result_inf;
assign fdsu_ex4_result_lfn      = double_pipe_ex4_result_lfn;
assign fdsu_ex4_of              = double_pipe_ex4_of;
assign fdsu_ex4_uf              = double_pipe_ex4_uf;
assign fdsu_ex4_nx              = double_pipe_ex4_nx;
assign fdsu_ex4_potnt_norm[1:0]      = double_pipe_ex4_potnt_norm[1:0];
assign fdsu_ex4_result_nor     = double_pipe_ex4_result_nor;
assign fdsu_ex4_potnt_of        = double_pipe_ex4_potnt_of;
assign fdsu_ex4_potnt_uf        = double_pipe_ex4_potnt_uf;
assign fdsu_ex4_nv              = double_pipe_ex4_nv;
assign fdsu_ex4_dz              = double_pipe_ex4_dz;
assign fdsu_ex4_expnt_rst[12:0] = double_pipe_ex4_expnt_rst[12:0];
assign fdsu_ex4_rslt_denorm     = double_pipe_ex4_rslt_denorm;
assign ex4_rslt_qnan            = double_pipe_ex4_result_qnan;
assign ex4_result_zero          = double_pipe_ex4_result_zero;

//============================EX4 STAGE=====================
assign ex4_frac[54:0] = double_pipe_fdsu_ex4_frac[54:0];
//exponent adder
// &CombBeg; @51
always @( ex4_frac[54:53])
begin
casez(ex4_frac[54:53])
  2'b00   : expnt_add_op1[12:0] = 13'h0fff;  //the expnt sub 1
  2'b01   : expnt_add_op1[12:0] = 13'h0;    //the expnt stay the origi
  2'b1?   : expnt_add_op1[12:0] = 13'h1;    // the exptn add 1
  default : expnt_add_op1[12:0] = 13'b0;  
endcase
// &CombEnd; @58
end
assign ex4_expnt_rst[12:0] = fdsu_ex4_expnt_rst[12:0] + 
                             expnt_add_op1[12:0];

//==========================Result Pack=====================
// result denormal pack 
// shift to the denormal number
assign double_denorm_shift_num_in[51:0]   = ex4_frac[54:3];
assign single0_denorm_shift_num_in[22:0]  = ex4_frac[54:32];
assign half0_denorm_shift_num_in[9:0]     = ex4_frac[54:45];
assign bhalf0_denorm_shift_num_in[6:0]    = ex4_frac[54:48];
assign double_denorm_shift_val[11:0]       = fdsu_ex4_expnt_rst[11:0];
assign single0_denorm_shift_val[8:0]      = fdsu_ex4_expnt_rst[8:0];
assign half0_denorm_shift_val[5:0]        = fdsu_ex4_expnt_rst[5:0];
assign bhalf0_denorm_shift_val[8:0]       = fdsu_ex4_expnt_rst[8:0];
assign double_denorm_to_tiny_frac  = double_pipe_ex4_denorm_to_tiny_frac;
assign single0_denorm_to_tiny_frac = double_pipe_ex4_denorm_to_tiny_frac;
assign half0_denorm_to_tiny_frac   = double_pipe_ex4_denorm_to_tiny_frac;
assign bhalf0_denorm_to_tiny_frac  = double_pipe_ex4_denorm_to_tiny_frac;


// &CombBeg; @79
always @( ex4_frac[53:1]
       or single0_denorm_shift_num[22:0]
       or half0_denorm_shift_num[9:0]
       or double_denorm_shift_num[51:0]
       or bhalf0_denorm_shift_num[6:0]
       or fdsu_ex4_expnt_rst[12:0])
begin
case(fdsu_ex4_expnt_rst[12:0])
  13'h1: begin double_denorm_frac[51:0] = ex4_frac[52:1];
               single_denorm_frac[22:0] = ex4_frac[52:30];
               half_denorm_frac[9:0]    = ex4_frac[52:43];
               bhalf_denorm_frac[6:0]   = ex4_frac[52:46];
         end
  13'h0: begin double_denorm_frac[51:0] = ex4_frac[53:2];
               single_denorm_frac[22:0] = ex4_frac[53:31];
               half_denorm_frac[9:0]    = ex4_frac[53:44];
               bhalf_denorm_frac[6:0]   = ex4_frac[53:47];
         end
  default:begin double_denorm_frac[51:0] = double_denorm_shift_num[51:0];
                single_denorm_frac[22:0] = single0_denorm_shift_num[22:0];
                half_denorm_frac[9:0]    = half0_denorm_shift_num[9:0];
                bhalf_denorm_frac[6:0]   = bhalf0_denorm_shift_num[6:0];
          end
endcase
// &CombEnd; @97
end
//here when denormal number round to add1, it will become normal number
assign ex4_denorm_potnt_norm    = (fdsu_ex4_potnt_norm[1] && ex4_frac[53]) || 
                                  (fdsu_ex4_potnt_norm[0] && ex4_frac[54]) ;
assign ex4_rslt_denorm          = fdsu_ex4_rslt_denorm && !ex4_denorm_potnt_norm  && !ex4_rslt_qnan && !ex4_result_zero;
assign ex4_denorm_result[63:0]  = {64{fdsu_ex4_double}}  &
                                  {fdsu_ex4_result_sign,11'h0,double_denorm_frac[51:0]}  |
                                  {64{fdsu_ex4_single}} & {32'hffffffff,fdsu_ex4_result_sign,
                                                          8'h0,single_denorm_frac[22:0]} |
                                  {64{fdsu_ex4_half}} & {{48{1'b1}},fdsu_ex4_result_sign,
                                                          5'h0,half_denorm_frac[9:0]}  |
                                  {64{fdsu_ex4_bhalf}}& {{48{1'b1}},fdsu_ex4_result_sign,
                                                          8'h0,bhalf_denorm_frac[6:0]};
                                   
                                                              
//ex4 overflow/underflow plus                                 
assign ex4_rst_nor = fdsu_ex4_result_nor;                    
assign ex4_of_plus = fdsu_ex4_potnt_of  && 
                     (|ex4_frac[54:53])  && 
                     ex4_rst_nor;
assign ex4_uf_plus = fdsu_ex4_potnt_uf  && 
                     (~|ex4_frac[54:53]) && 
                     ex4_rst_nor;
//ex4 overflow round result
assign ex4_result_lfn = (ex4_of_plus &&  fdsu_ex4_of_rst_lfn) ||
                        fdsu_ex4_result_lfn;
assign ex4_result_inf = (ex4_of_plus && !fdsu_ex4_of_rst_lfn) ||
                        fdsu_ex4_result_inf;
//Special Result Form
// result largest finity number
assign ex4_doub_lfn[63:0]      = {fdsu_ex4_result_sign,11'h7fe,{52{1'b1}}};
assign ex4_sing_lfn[63:0]      = {32'hffffffff,fdsu_ex4_result_sign,8'hfe,{23{1'b1}}};
assign ex4_half_lfn[63:0]      = {{48{1'b1}},fdsu_ex4_result_sign,5'h1e,{10{1'b1}}};
assign ex4_bhalf_lfn[63:0]      ={{48{1'b1}},fdsu_ex4_result_sign,8'hfe,{7{1'b1}}};
assign ex4_rst_lfn[63:0]       = {64{fdsu_ex4_double}} & ex4_doub_lfn[63:0] |
                                 {64{fdsu_ex4_single}} & ex4_sing_lfn[63:0] |
                                 {64{fdsu_ex4_half}} & ex4_half_lfn[63:0] |
                                 {64{fdsu_ex4_bhalf}} & ex4_bhalf_lfn[63:0];
//result infinity
assign ex4_doub_rst_inf[63:0]  = {fdsu_ex4_result_sign,11'h7ff,52'b0};
assign ex4_sing_rst_inf[63:0]  = {32'hffffffff,fdsu_ex4_result_sign,8'hff,23'b0};
assign ex4_half_rst_inf[63:0]  = {{48{1'b1}},fdsu_ex4_result_sign,5'h1f,10'b0};
assign ex4_bhalf_rst_inf[63:0] = {{48{1'b1}},fdsu_ex4_result_sign,8'hff,7'b0};
assign ex4_rst_inf[63:0]       = {64{fdsu_ex4_double}} & ex4_doub_rst_inf[63:0] | 
                                 {64{fdsu_ex4_single}} & ex4_sing_rst_inf[63:0] |
                                 {64{fdsu_ex4_half}}   & ex4_half_rst_inf[63:0] |
                                 {64{fdsu_ex4_bhalf}}  & ex4_bhalf_rst_inf[63:0];
//result normal
// &CombBeg; @232
always @( ex4_frac[54:0])
begin
casez(ex4_frac[54:53])
  2'b00   : ex4_frac_52[51:0]  = ex4_frac[51:0];
  2'b01   : ex4_frac_52[51:0]  = ex4_frac[52:1];
  2'b1?   : ex4_frac_52[51:0]  = ex4_frac[53:2];
  default : ex4_frac_52[51:0]  = 52'b0;
endcase
// &CombEnd; @239
end
assign ex4_doub_rst_norm[63:0] = {fdsu_ex4_result_sign,
                                  ex4_expnt_rst[10:0],
                                  ex4_frac_52[51:0]};
assign ex4_sing_rst_norm[63:0] = {32'hffffffff,fdsu_ex4_result_sign,
                                  ex4_expnt_rst[7:0],
                                  ex4_frac_52[51:29]};
assign ex4_half_rst_norm[63:0] = {{48{1'b1}},fdsu_ex4_result_sign,
                                  ex4_expnt_rst[4:0],
                                  ex4_frac_52[51:42]};
assign ex4_bhalf_rst_norm[63:0] = {{48{1'b1}},fdsu_ex4_result_sign,
                                  ex4_expnt_rst[7:0],
                                  ex4_frac_52[51:45]};                                

assign ex4_rst_norm[63:0]      = {64{fdsu_ex4_double}} & ex4_doub_rst_norm[63:0] | 
                                 {64{fdsu_ex4_single}} & ex4_sing_rst_norm[63:0] | 
                                 {64{fdsu_ex4_half}}   & ex4_half_rst_norm[63:0] |
                                 {64{fdsu_ex4_bhalf}}  & ex4_bhalf_rst_norm[63:0];
assign ex4_cor_uf            = (fdsu_ex4_uf && !ex4_denorm_potnt_norm || ex4_uf_plus)
                               && fdsu_ex4_nx;
assign ex4_cor_nx            =  fdsu_ex4_nx 
                                || fdsu_ex4_of 
                                || ex4_of_plus;
                                        
assign ex4_expt[4:0]           = {
                                  fdsu_ex4_nv,
                                  fdsu_ex4_dz,
                                  fdsu_ex4_of | ex4_of_plus,
                                  ex4_cor_uf,
                                  ex4_cor_nx};

assign ex4_final_rst_norm      = !ex4_result_inf        &&
                                 !ex4_result_lfn        && 
                                 !ex4_rslt_denorm       && !ex4_rslt_qnan && !ex4_result_zero; 
// the qnan result
assign ex4_rst_qnan[63:0] = {64{fdsu_ex4_double}} & {double_ex4_qnan_f[52],{11{1'b1}},double_ex4_qnan_f[51:0]}   |
                            {64{fdsu_ex4_single}} & {{32{1'b1}},single0_ex4_qnan_f[23],{8{1'b1}},single0_ex4_qnan_f[22:0]} |
                            {64{fdsu_ex4_half}}   & {{48{1'b1}},half0_ex4_qnan_f[10],{5{1'b1}},half0_ex4_qnan_f[9:0]}       |
                            {64{fdsu_ex4_bhalf}}  & {{48{1'b1}},bhalf0_ex4_qnan_f[7],{8{1'b1}},bhalf0_ex4_qnan_f[6:0]};
assign ex4_rst_zero[63:0] = {64{fdsu_ex4_double}} & {fdsu_ex4_result_sign,{11{1'b0}},52'b0}           |
                            {64{fdsu_ex4_single}} & {{32{1'b1}},fdsu_ex4_result_sign,{8{1'b0}},23'b0} |
                            {64{fdsu_ex4_half}}   & {{48{1'b1}},fdsu_ex4_result_sign,{5{1'b0}},10'b0} |
                            {64{fdsu_ex4_bhalf}}  & {{48{1'b1}},fdsu_ex4_result_sign,{8{1'b0}},7'b0};                          
// &CombBeg; @282
always @( ex4_rst_norm[63:0]
       or ex4_rst_qnan[63:0]
       or ex4_result_lfn
       or ex4_result_zero
       or ex4_rst_lfn[63:0]
       or ex4_denorm_result[63:0]
       or ex4_result_inf
       or ex4_rslt_qnan
       or ex4_rst_inf[63:0]
       or ex4_rst_zero[63:0]
       or ex4_rslt_denorm
       or ex4_final_rst_norm)
begin
case({ex4_result_zero,
      ex4_rslt_qnan,
      ex4_rslt_denorm,
      ex4_result_inf,
      ex4_result_lfn,
      ex4_final_rst_norm})
  6'b100000 : ex4_result[63:0]  = ex4_rst_zero[63:0];
  6'b010000 : ex4_result[63:0]  = ex4_rst_qnan[63:0];
  6'b001000 : ex4_result[63:0]  = ex4_denorm_result[63:0];
  6'b000100 : ex4_result[63:0]  = ex4_rst_inf[63:0];
  6'b000010 : ex4_result[63:0]  = ex4_rst_lfn[63:0];
  6'b000001 : ex4_result[63:0]  = ex4_rst_norm[63:0];
  default   : ex4_result[63:0]  = 64'b0;
endcase
// &CombEnd; @297
end

////==========================================================
////                     Result Generate
////==========================================================
assign double_pipe_ex4_result[63:0]  = ex4_result[63:0];
assign double_pipe_ex4_expt[4:0] = ex4_expt[4:0];
// &ModuleEnd; @308
endmodule



