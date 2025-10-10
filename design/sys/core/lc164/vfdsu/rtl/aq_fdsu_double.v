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
module aq_fdsu_double (
  // &Ports, @23
  input    wire  [6 :0]  bhalf0_denorm_shift_num,
  input    wire  [6 :0]  bhalf0_ex1_id_frac,
  input    wire  [6 :0]  bhalf0_ex1_id_frac_f,
  input    wire          bhalf0_ex1_op1_sel,
  input    wire  [7 :0]  bhalf0_ex4_qnan_f,
  input    wire          cp0_vpu_icg_en,
  input    wire          cp0_vpu_xx_dqnan,
  input    wire          cp0_yy_clk_en,
  input    wire  [51:0]  double0_denorm_shift_num,
  input    wire  [51:0]  double0_ex1_id_frac,
  input    wire  [51:0]  double0_ex1_id_frac_f,
  input    wire          double0_ex1_op1_sel,
  input    wire  [52:0]  double0_ex4_qnan_f,
  input    wire  [59:0]  double0_pipe_cur_rem_1,
  input    wire  [59:0]  double0_pipe_cur_rem_2,
  input    wire          double0_pipe_ex1_ff1_sel_op1,
  input    wire          double0_pipe_ex1_op0_cnan,
  input    wire  [12:0]  double0_pipe_ex1_op0_id_expnt_neg,
  input    wire          double0_pipe_ex1_op0_inf,
  input    wire          double0_pipe_ex1_op0_qnan,
  input    wire          double0_pipe_ex1_op0_snan,
  input    wire          double0_pipe_ex1_op0_zero,
  input    wire          double0_pipe_ex1_op1_cnan,
  input    wire  [12:0]  double0_pipe_ex1_op1_id_expnt_neg,
  input    wire          double0_pipe_ex1_op1_inf,
  input    wire          double0_pipe_ex1_op1_qnan,
  input    wire          double0_pipe_ex1_op1_snan,
  input    wire          double0_pipe_ex1_op1_zero,
  input    wire          double0_pipe_ex1_save_op0,
  input    wire  [12:0]  double0_pipe_ex2_expnt_adder_op1,
  input    wire  [52:0]  double0_pipe_ex3_result_denorm_round_add_num,
  input    wire  [54:0]  double0_pipe_fdsu_ex4_frac,
  input    wire  [54:0]  double0_pipe_frac_add1_rst,
  input    wire  [54:0]  double0_pipe_frac_sub1_rst,
  input    wire  [12:0]  double0_pipe_op0_ff1_cnt,
  input    wire  [63:0]  double0_pipe_oper0,
  input    wire  [63:0]  double0_pipe_oper1,
  input    wire  [57:0]  double0_pipe_qt_rt_const_shift_std,
  input    wire          double0_pipe_save_op0_neg_expnt,
  input    wire  [52:0]  double0_pipe_srt_divisor,
  input    wire  [59:0]  double0_pipe_srt_remainder,
  input    wire  [57:0]  double0_pipe_total_qt_rt,
  input    wire  [57:0]  double0_pipe_total_qt_rt_minus,
  input    wire  [59:0]  double0_srt_remainder,
  input    wire  [57:0]  double0_total_qt_rt,
  input    wire  [2 :0]  dp_xx_ex1_rm,
  input    wire          ex1_bhalf,
  input    wire          ex1_bhalf0_op0_id,
  input    wire          ex1_bhalf0_op1_id,
  input    wire          ex1_div,
  input    wire          ex1_double,
  input    wire          ex1_double0_op0_id,
  input    wire          ex1_double0_op1_id,
  input    wire          ex1_f16,
  input    wire          ex1_half,
  input    wire          ex1_half0_op0_id,
  input    wire          ex1_half0_op1_id,
  input    wire          ex1_pipe_clk,
  input    wire          ex1_pipedown,
  input    wire          ex1_single,
  input    wire          ex1_single0_op0_id,
  input    wire          ex1_single0_op1_id,
  input    wire          ex1_sqrt,
  input    wire          ex2_pipe_clk,
  input    wire          ex2_pipedown,
  input    wire          ex2_srt_first_round,
  input    wire          ex3_pipedown,
  input    wire          expnt_rst_clk,
  input    wire          fdsu_ex1_sel,
  input    wire          fdsu_ex2_bhalf,
  input    wire          fdsu_ex2_div,
  input    wire          fdsu_ex2_double,
  input    wire          fdsu_ex2_half,
  input    wire          fdsu_ex2_single,
  input    wire          fdsu_ex2_sqrt,
  input    wire          fdsu_ex3_bhalf,
  input    wire          fdsu_ex3_double,
  input    wire          fdsu_ex3_half,
  input    wire          fdsu_ex3_single,
  input    wire          fdsu_ex4_bhalf,
  input    wire          fdsu_ex4_double,
  input    wire          fdsu_ex4_half,
  input    wire          fdsu_ex4_single,
  input    wire  [2 :0]  fdsu_yy_rm,
  input    wire          forever_cpuclk,
  input    wire  [9 :0]  half0_denorm_shift_num,
  input    wire  [9 :0]  half0_ex1_id_frac,
  input    wire  [9 :0]  half0_ex1_id_frac_f,
  input    wire          half0_ex1_op1_sel,
  input    wire  [10:0]  half0_ex4_qnan_f,
  input    wire  [15:0]  half0_total_qt_rt,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [22:0]  single0_denorm_shift_num,
  input    wire  [22:0]  single0_ex1_id_frac,
  input    wire  [22:0]  single0_ex1_id_frac_f,
  input    wire          single0_ex1_op1_sel,
  input    wire  [23:0]  single0_ex4_qnan_f,
  input    wire  [27:0]  single0_total_qt_rt,
  output   wire  [6 :0]  bhalf0_denorm_shift_num_in,
  output   wire  [8 :0]  bhalf0_denorm_shift_val,
  output   wire          bhalf0_denorm_to_tiny_frac,
  output   wire  [7 :0]  bhalf0_ex1_divisor,
  output   wire  [6 :0]  bhalf0_ex1_ff1_frac,
  output   wire          bhalf0_ex1_op0_id_vld,
  output   wire          bhalf0_ex1_op1_id_vld,
  output   wire  [7 :0]  bhalf0_ex1_qnan_f,
  output   wire  [14:0]  bhalf0_ex1_remainder,
  output   wire  [7 :0]  bhalf0_ex2_result_denorm_round_add_num,
  output   wire  [9 :0]  bhalf0_ex3_frac_add1_op1,
  output   wire  [9 :0]  bhalf0_ex3_frac_final_rst,
  output   wire  [9 :0]  bhalf0_ex3_frac_sub1_op1,
  output   wire  [9 :0]  bhalf0_ex3_frac_sub1_op2,
  output   wire  [14:0]  bhalf0_remainder_nxt,
  output   wire  [51:0]  double0_denorm_shift_num_in,
  output   wire  [11:0]  double0_denorm_shift_val,
  output   wire          double0_denorm_to_tiny_frac,
  output   wire  [52:0]  double0_ex1_divisor,
  output   wire  [51:0]  double0_ex1_ff1_frac,
  output   wire          double0_ex1_op0_id_vld,
  output   wire          double0_ex1_op1_id_vld,
  output   wire  [52:0]  double0_ex1_qnan_f,
  output   wire  [59:0]  double0_ex1_remainder,
  output   wire  [52:0]  double0_ex2_result_denorm_round_add_num,
  output   wire  [54:0]  double0_ex3_frac_add1_op1,
  output   wire  [54:0]  double0_ex3_frac_final_rst,
  output   wire  [54:0]  double0_ex3_frac_sub1_op1,
  output   wire  [54:0]  double0_ex3_frac_sub1_op2,
  output   wire  [12:0]  double0_pipe_ex1_expnt_adder_op1,
  output   wire          double0_pipe_ex1_result_qnan,
  output   wire          double0_pipe_ex1_srt_skip,
  output   wire          double0_pipe_ex2_of,
  output   wire          double0_pipe_ex2_uf_srt_skip,
  output   wire  [4 :0]  double0_pipe_ex4_expt,
  output   wire  [63:0]  double0_pipe_ex4_result,
  output   wire  [12:0]  double0_pipe_op0_id_expnt,
  output   wire          double0_pipe_srt_remainder_zero,
  output   wire  [59:0]  double0_remainder_nxt,
  output   wire  [59:0]  double0_srt_remainder_add1_op1,
  output   wire  [59:0]  double0_srt_remainder_add1_op2,
  output   wire  [59:0]  double0_srt_remainder_add2_op1,
  output   wire  [59:0]  double0_srt_remainder_add2_op2,
  output   wire  [59:0]  double0_srt_remainder_shift,
  output   wire  [57:0]  double0_total_qt_rt_minus_next,
  output   wire  [57:0]  double0_total_qt_rt_next,
  output   wire  [9 :0]  half0_denorm_shift_num_in,
  output   wire  [5 :0]  half0_denorm_shift_val,
  output   wire          half0_denorm_to_tiny_frac,
  output   wire  [10:0]  half0_ex1_divisor,
  output   wire  [9 :0]  half0_ex1_ff1_frac,
  output   wire          half0_ex1_op0_id_vld,
  output   wire          half0_ex1_op1_id_vld,
  output   wire  [10:0]  half0_ex1_qnan_f,
  output   wire  [18:0]  half0_ex1_remainder,
  output   wire  [10:0]  half0_ex2_result_denorm_round_add_num,
  output   wire  [12:0]  half0_ex3_frac_add1_op1,
  output   wire  [12:0]  half0_ex3_frac_final_rst,
  output   wire  [12:0]  half0_ex3_frac_sub1_op1,
  output   wire  [12:0]  half0_ex3_frac_sub1_op2,
  output   wire  [18:0]  half0_remainder_nxt,
  output   wire  [15:0]  half0_total_qt_rt_minus_next,
  output   wire  [15:0]  half0_total_qt_rt_next,
  output   wire  [22:0]  single0_denorm_shift_num_in,
  output   wire  [8 :0]  single0_denorm_shift_val,
  output   wire          single0_denorm_to_tiny_frac,
  output   wire  [23:0]  single0_ex1_divisor,
  output   wire  [22:0]  single0_ex1_ff1_frac,
  output   wire          single0_ex1_op0_id_vld,
  output   wire          single0_ex1_op1_id_vld,
  output   wire  [23:0]  single0_ex1_qnan_f,
  output   wire  [30:0]  single0_ex1_remainder,
  output   wire  [23:0]  single0_ex2_result_denorm_round_add_num,
  output   wire  [25:0]  single0_ex3_frac_add1_op1,
  output   wire  [25:0]  single0_ex3_frac_final_rst,
  output   wire  [25:0]  single0_ex3_frac_sub1_op1,
  output   wire  [25:0]  single0_ex3_frac_sub1_op2,
  output   wire  [30:0]  single0_remainder_nxt,
  output   wire  [27:0]  single0_total_qt_rt_minus_next,
  output   wire  [27:0]  single0_total_qt_rt_next
); 



// &Regs; @24
// &Wires; @25
wire            double0_pipe_ex1_dz;                         
wire    [12:0]  double0_pipe_ex1_expnt_adder_op0;            
wire    [12:0]  double0_pipe_ex1_id_expnt_f;                 
wire            double0_pipe_ex1_nv;                         
wire            double0_pipe_ex1_of_result_lfn;              
wire            double0_pipe_ex1_op0_norm;                   
wire            double0_pipe_ex1_op1_norm;                   
wire            double0_pipe_ex1_result_inf;                 
wire            double0_pipe_ex1_result_lfn;                 
wire            double0_pipe_ex1_result_sign;                
wire            double0_pipe_ex1_result_zero;                
wire    [12:0]  double0_pipe_ex2_expnt_adder_op0;            
wire            double0_pipe_ex2_of_rm_lfn;                  
wire            double0_pipe_ex2_op0_norm;                   
wire            double0_pipe_ex2_op1_norm;                   
wire            double0_pipe_ex2_potnt_of;                   
wire            double0_pipe_ex2_potnt_uf;                   
wire            double0_pipe_ex2_result_inf;                 
wire            double0_pipe_ex2_result_lfn;                 
wire            double0_pipe_ex2_rslt_denorm;                
wire    [12:0]  double0_pipe_ex2_srt_expnt_rst;              
wire            double0_pipe_ex2_uf;                         
wire    [12:0]  double0_pipe_ex3_expnt_adjust_result;        
wire    [12:0]  double0_pipe_ex3_expnt_rst;                  
wire            double0_pipe_ex3_potnt_uf;                   
wire            double0_pipe_ex3_result_inf;                 
wire            double0_pipe_ex3_result_lfn;                 
wire            double0_pipe_ex3_result_qnan;                
wire            double0_pipe_ex3_result_sign;                
wire            double0_pipe_ex3_result_zero;                
wire            double0_pipe_ex3_rslt_denorm;                
wire            double0_pipe_ex3_rslt_denorm_in;             
wire            double0_pipe_ex4_denorm_to_tiny_frac;        
wire            double0_pipe_ex4_dz;                         
wire    [12:0]  double0_pipe_ex4_expnt_rst;                  
wire            double0_pipe_ex4_nv;                         
wire            double0_pipe_ex4_nx;                         
wire            double0_pipe_ex4_of;                         
wire            double0_pipe_ex4_of_rm_lfn;                  
wire    [1 :0]  double0_pipe_ex4_potnt_norm;                 
wire            double0_pipe_ex4_potnt_of;                   
wire            double0_pipe_ex4_potnt_uf;                   
wire            double0_pipe_ex4_result_inf;                 
wire            double0_pipe_ex4_result_lfn;                 
wire            double0_pipe_ex4_result_nor;                 
wire            double0_pipe_ex4_result_qnan;                
wire            double0_pipe_ex4_result_sign;                
wire            double0_pipe_ex4_result_zero;                
wire            double0_pipe_ex4_rslt_denorm;                
wire            double0_pipe_ex4_uf;                         
wire            ex1_op0_sign;                                
wire    [63:0]  ex1_oper0;                                   
wire    [63:0]  ex1_oper1;                                   
wire            fdsu_ex3_id_srt_skip;                        
wire            fdsu_ex3_rem_sign;                           
wire            fdsu_ex3_rem_zero;                           

// &ConnRule(s/double_/double0_/); @26
// &Instance("aq_fdsu_special"); @27
aq_fdsu_special  x_aq_fdsu_special (
  .bhalf0_ex1_qnan_f            (bhalf0_ex1_qnan_f           ),
  .cp0_vpu_xx_dqnan             (cp0_vpu_xx_dqnan            ),
  .double_ex1_qnan_f            (double0_ex1_qnan_f          ),
  .double_pipe_ex1_dz           (double0_pipe_ex1_dz         ),
  .double_pipe_ex1_nv           (double0_pipe_ex1_nv         ),
  .double_pipe_ex1_op0_cnan     (double0_pipe_ex1_op0_cnan   ),
  .double_pipe_ex1_op0_inf      (double0_pipe_ex1_op0_inf    ),
  .double_pipe_ex1_op0_norm     (double0_pipe_ex1_op0_norm   ),
  .double_pipe_ex1_op0_qnan     (double0_pipe_ex1_op0_qnan   ),
  .double_pipe_ex1_op0_snan     (double0_pipe_ex1_op0_snan   ),
  .double_pipe_ex1_op0_zero     (double0_pipe_ex1_op0_zero   ),
  .double_pipe_ex1_op1_cnan     (double0_pipe_ex1_op1_cnan   ),
  .double_pipe_ex1_op1_inf      (double0_pipe_ex1_op1_inf    ),
  .double_pipe_ex1_op1_norm     (double0_pipe_ex1_op1_norm   ),
  .double_pipe_ex1_op1_qnan     (double0_pipe_ex1_op1_qnan   ),
  .double_pipe_ex1_op1_snan     (double0_pipe_ex1_op1_snan   ),
  .double_pipe_ex1_op1_zero     (double0_pipe_ex1_op1_zero   ),
  .double_pipe_ex1_result_inf   (double0_pipe_ex1_result_inf ),
  .double_pipe_ex1_result_lfn   (double0_pipe_ex1_result_lfn ),
  .double_pipe_ex1_result_qnan  (double0_pipe_ex1_result_qnan),
  .double_pipe_ex1_result_zero  (double0_pipe_ex1_result_zero),
  .double_pipe_ex1_srt_skip     (double0_pipe_ex1_srt_skip   ),
  .ex1_div                      (ex1_div                     ),
  .ex1_op0_sign                 (ex1_op0_sign                ),
  .ex1_oper0                    (ex1_oper0                   ),
  .ex1_oper1                    (ex1_oper1                   ),
  .ex1_sqrt                     (ex1_sqrt                    ),
  .half0_ex1_qnan_f             (half0_ex1_qnan_f            ),
  .single0_ex1_qnan_f           (single0_ex1_qnan_f          )
);

// &ConnRule(s/double_/double0_/); @28
// &Instance("aq_fdsu_prepare"); @29
aq_fdsu_prepare  x_aq_fdsu_prepare (
  .bhalf0_ex1_divisor                (bhalf0_ex1_divisor               ),
  .bhalf0_ex1_ff1_frac               (bhalf0_ex1_ff1_frac              ),
  .bhalf0_ex1_id_frac                (bhalf0_ex1_id_frac               ),
  .bhalf0_ex1_id_frac_f              (bhalf0_ex1_id_frac_f             ),
  .bhalf0_ex1_op0_id_vld             (bhalf0_ex1_op0_id_vld            ),
  .bhalf0_ex1_op1_id_vld             (bhalf0_ex1_op1_id_vld            ),
  .bhalf0_ex1_op1_sel                (bhalf0_ex1_op1_sel               ),
  .bhalf0_ex1_remainder              (bhalf0_ex1_remainder             ),
  .double_ex1_divisor                (double0_ex1_divisor              ),
  .double_ex1_ff1_frac               (double0_ex1_ff1_frac             ),
  .double_ex1_id_frac                (double0_ex1_id_frac              ),
  .double_ex1_id_frac_f              (double0_ex1_id_frac_f            ),
  .double_ex1_op0_id_vld             (double0_ex1_op0_id_vld           ),
  .double_ex1_op1_id_vld             (double0_ex1_op1_id_vld           ),
  .double_ex1_op1_sel                (double0_ex1_op1_sel              ),
  .double_ex1_remainder              (double0_ex1_remainder            ),
  .double_pipe_ex1_expnt_adder_op0   (double0_pipe_ex1_expnt_adder_op0 ),
  .double_pipe_ex1_expnt_adder_op1   (double0_pipe_ex1_expnt_adder_op1 ),
  .double_pipe_ex1_ff1_sel_op1       (double0_pipe_ex1_ff1_sel_op1     ),
  .double_pipe_ex1_id_expnt_f        (double0_pipe_ex1_id_expnt_f      ),
  .double_pipe_ex1_of_result_lfn     (double0_pipe_ex1_of_result_lfn   ),
  .double_pipe_ex1_op0_id_expnt_neg  (double0_pipe_ex1_op0_id_expnt_neg),
  .double_pipe_ex1_op1_id_expnt_neg  (double0_pipe_ex1_op1_id_expnt_neg),
  .double_pipe_ex1_result_sign       (double0_pipe_ex1_result_sign     ),
  .double_pipe_oper0                 (double0_pipe_oper0               ),
  .double_pipe_oper1                 (double0_pipe_oper1               ),
  .dp_xx_ex1_rm                      (dp_xx_ex1_rm                     ),
  .ex1_bhalf                         (ex1_bhalf                        ),
  .ex1_bhalf0_op0_id                 (ex1_bhalf0_op0_id                ),
  .ex1_bhalf0_op1_id                 (ex1_bhalf0_op1_id                ),
  .ex1_div                           (ex1_div                          ),
  .ex1_double                        (ex1_double                       ),
  .ex1_double_op0_id                 (ex1_double0_op0_id               ),
  .ex1_double_op1_id                 (ex1_double0_op1_id               ),
  .ex1_f16                           (ex1_f16                          ),
  .ex1_half                          (ex1_half                         ),
  .ex1_half0_op0_id                  (ex1_half0_op0_id                 ),
  .ex1_half0_op1_id                  (ex1_half0_op1_id                 ),
  .ex1_op0_sign                      (ex1_op0_sign                     ),
  .ex1_oper0                         (ex1_oper0                        ),
  .ex1_oper1                         (ex1_oper1                        ),
  .ex1_single                        (ex1_single                       ),
  .ex1_single0_op0_id                (ex1_single0_op0_id               ),
  .ex1_single0_op1_id                (ex1_single0_op1_id               ),
  .ex1_sqrt                          (ex1_sqrt                         ),
  .fdsu_ex1_sel                      (fdsu_ex1_sel                     ),
  .half0_ex1_divisor                 (half0_ex1_divisor                ),
  .half0_ex1_ff1_frac                (half0_ex1_ff1_frac               ),
  .half0_ex1_id_frac                 (half0_ex1_id_frac                ),
  .half0_ex1_id_frac_f               (half0_ex1_id_frac_f              ),
  .half0_ex1_op0_id_vld              (half0_ex1_op0_id_vld             ),
  .half0_ex1_op1_id_vld              (half0_ex1_op1_id_vld             ),
  .half0_ex1_op1_sel                 (half0_ex1_op1_sel                ),
  .half0_ex1_remainder               (half0_ex1_remainder              ),
  .single0_ex1_divisor               (single0_ex1_divisor              ),
  .single0_ex1_ff1_frac              (single0_ex1_ff1_frac             ),
  .single0_ex1_id_frac               (single0_ex1_id_frac              ),
  .single0_ex1_id_frac_f             (single0_ex1_id_frac_f            ),
  .single0_ex1_op0_id_vld            (single0_ex1_op0_id_vld           ),
  .single0_ex1_op1_id_vld            (single0_ex1_op1_id_vld           ),
  .single0_ex1_op1_sel               (single0_ex1_op1_sel              ),
  .single0_ex1_remainder             (single0_ex1_remainder            )
);

// &ConnRule(s/double_/double0_/); @30
// &Instance("aq_fdsu_srt"); @31
aq_fdsu_srt  x_aq_fdsu_srt (
  .bhalf0_ex2_result_denorm_round_add_num  (bhalf0_ex2_result_denorm_round_add_num ),
  .bhalf0_remainder_nxt                    (bhalf0_remainder_nxt                   ),
  .double_ex2_result_denorm_round_add_num  (double0_ex2_result_denorm_round_add_num),
  .double_pipe_cur_rem_1                   (double0_pipe_cur_rem_1                 ),
  .double_pipe_cur_rem_2                   (double0_pipe_cur_rem_2                 ),
  .double_pipe_ex2_expnt_adder_op0         (double0_pipe_ex2_expnt_adder_op0       ),
  .double_pipe_ex2_expnt_adder_op1         (double0_pipe_ex2_expnt_adder_op1       ),
  .double_pipe_ex2_of                      (double0_pipe_ex2_of                    ),
  .double_pipe_ex2_of_rm_lfn               (double0_pipe_ex2_of_rm_lfn             ),
  .double_pipe_ex2_op0_norm                (double0_pipe_ex2_op0_norm              ),
  .double_pipe_ex2_op1_norm                (double0_pipe_ex2_op1_norm              ),
  .double_pipe_ex2_potnt_of                (double0_pipe_ex2_potnt_of              ),
  .double_pipe_ex2_potnt_uf                (double0_pipe_ex2_potnt_uf              ),
  .double_pipe_ex2_result_inf              (double0_pipe_ex2_result_inf            ),
  .double_pipe_ex2_result_lfn              (double0_pipe_ex2_result_lfn            ),
  .double_pipe_ex2_rslt_denorm             (double0_pipe_ex2_rslt_denorm           ),
  .double_pipe_ex2_srt_expnt_rst           (double0_pipe_ex2_srt_expnt_rst         ),
  .double_pipe_ex2_uf                      (double0_pipe_ex2_uf                    ),
  .double_pipe_ex2_uf_srt_skip             (double0_pipe_ex2_uf_srt_skip           ),
  .double_pipe_qt_rt_const_shift_std       (double0_pipe_qt_rt_const_shift_std     ),
  .double_pipe_srt_divisor                 (double0_pipe_srt_divisor               ),
  .double_pipe_srt_remainder               (double0_pipe_srt_remainder             ),
  .double_pipe_srt_remainder_zero          (double0_pipe_srt_remainder_zero        ),
  .double_pipe_total_qt_rt                 (double0_pipe_total_qt_rt               ),
  .double_pipe_total_qt_rt_minus           (double0_pipe_total_qt_rt_minus         ),
  .double_remainder_nxt                    (double0_remainder_nxt                  ),
  .double_srt_remainder                    (double0_srt_remainder                  ),
  .double_srt_remainder_add1_op1           (double0_srt_remainder_add1_op1         ),
  .double_srt_remainder_add1_op2           (double0_srt_remainder_add1_op2         ),
  .double_srt_remainder_add2_op1           (double0_srt_remainder_add2_op1         ),
  .double_srt_remainder_add2_op2           (double0_srt_remainder_add2_op2         ),
  .double_srt_remainder_shift              (double0_srt_remainder_shift            ),
  .double_total_qt_rt_minus_next           (double0_total_qt_rt_minus_next         ),
  .double_total_qt_rt_next                 (double0_total_qt_rt_next               ),
  .ex2_pipe_clk                            (ex2_pipe_clk                           ),
  .ex2_pipedown                            (ex2_pipedown                           ),
  .ex2_srt_first_round                     (ex2_srt_first_round                    ),
  .fdsu_ex2_bhalf                          (fdsu_ex2_bhalf                         ),
  .fdsu_ex2_div                            (fdsu_ex2_div                           ),
  .fdsu_ex2_double                         (fdsu_ex2_double                        ),
  .fdsu_ex2_half                           (fdsu_ex2_half                          ),
  .fdsu_ex2_single                         (fdsu_ex2_single                        ),
  .fdsu_ex2_sqrt                           (fdsu_ex2_sqrt                          ),
  .fdsu_ex3_id_srt_skip                    (fdsu_ex3_id_srt_skip                   ),
  .fdsu_ex3_rem_sign                       (fdsu_ex3_rem_sign                      ),
  .fdsu_ex3_rem_zero                       (fdsu_ex3_rem_zero                      ),
  .half0_ex2_result_denorm_round_add_num   (half0_ex2_result_denorm_round_add_num  ),
  .half0_remainder_nxt                     (half0_remainder_nxt                    ),
  .half0_total_qt_rt_minus_next            (half0_total_qt_rt_minus_next           ),
  .half0_total_qt_rt_next                  (half0_total_qt_rt_next                 ),
  .single0_ex2_result_denorm_round_add_num (single0_ex2_result_denorm_round_add_num),
  .single0_remainder_nxt                   (single0_remainder_nxt                  ),
  .single0_total_qt_rt_minus_next          (single0_total_qt_rt_minus_next         ),
  .single0_total_qt_rt_next                (single0_total_qt_rt_next               )
);

// &ConnRule(s/double_/double0_/); @32
// &Instance("aq_fdsu_round"); @33
aq_fdsu_round  x_aq_fdsu_round (
  .bhalf0_ex3_frac_add1_op1                     (bhalf0_ex3_frac_add1_op1                    ),
  .bhalf0_ex3_frac_final_rst                    (bhalf0_ex3_frac_final_rst                   ),
  .bhalf0_ex3_frac_sub1_op1                     (bhalf0_ex3_frac_sub1_op1                    ),
  .bhalf0_ex3_frac_sub1_op2                     (bhalf0_ex3_frac_sub1_op2                    ),
  .cp0_vpu_icg_en                               (cp0_vpu_icg_en                              ),
  .cp0_yy_clk_en                                (cp0_yy_clk_en                               ),
  .double_ex3_frac_add1_op1                     (double0_ex3_frac_add1_op1                   ),
  .double_ex3_frac_final_rst                    (double0_ex3_frac_final_rst                  ),
  .double_ex3_frac_sub1_op1                     (double0_ex3_frac_sub1_op1                   ),
  .double_ex3_frac_sub1_op2                     (double0_ex3_frac_sub1_op2                   ),
  .double_pipe_ex3_expnt_adjust_result          (double0_pipe_ex3_expnt_adjust_result        ),
  .double_pipe_ex3_expnt_rst                    (double0_pipe_ex3_expnt_rst                  ),
  .double_pipe_ex3_potnt_uf                     (double0_pipe_ex3_potnt_uf                   ),
  .double_pipe_ex3_result_denorm_round_add_num  (double0_pipe_ex3_result_denorm_round_add_num),
  .double_pipe_ex3_result_inf                   (double0_pipe_ex3_result_inf                 ),
  .double_pipe_ex3_result_lfn                   (double0_pipe_ex3_result_lfn                 ),
  .double_pipe_ex3_result_qnan                  (double0_pipe_ex3_result_qnan                ),
  .double_pipe_ex3_result_sign                  (double0_pipe_ex3_result_sign                ),
  .double_pipe_ex3_result_zero                  (double0_pipe_ex3_result_zero                ),
  .double_pipe_ex3_rslt_denorm                  (double0_pipe_ex3_rslt_denorm                ),
  .double_pipe_ex3_rslt_denorm_in               (double0_pipe_ex3_rslt_denorm_in             ),
  .double_pipe_ex4_denorm_to_tiny_frac          (double0_pipe_ex4_denorm_to_tiny_frac        ),
  .double_pipe_ex4_nx                           (double0_pipe_ex4_nx                         ),
  .double_pipe_ex4_potnt_norm                   (double0_pipe_ex4_potnt_norm                 ),
  .double_pipe_ex4_result_nor                   (double0_pipe_ex4_result_nor                 ),
  .double_pipe_frac_add1_rst                    (double0_pipe_frac_add1_rst                  ),
  .double_pipe_frac_sub1_rst                    (double0_pipe_frac_sub1_rst                  ),
  .double_pipe_total_qt_rt                      (double0_pipe_total_qt_rt                    ),
  .double_total_qt_rt                           (double0_total_qt_rt                         ),
  .ex3_pipedown                                 (ex3_pipedown                                ),
  .fdsu_ex3_bhalf                               (fdsu_ex3_bhalf                              ),
  .fdsu_ex3_double                              (fdsu_ex3_double                             ),
  .fdsu_ex3_half                                (fdsu_ex3_half                               ),
  .fdsu_ex3_id_srt_skip                         (fdsu_ex3_id_srt_skip                        ),
  .fdsu_ex3_rem_sign                            (fdsu_ex3_rem_sign                           ),
  .fdsu_ex3_rem_zero                            (fdsu_ex3_rem_zero                           ),
  .fdsu_ex3_single                              (fdsu_ex3_single                             ),
  .fdsu_yy_rm                                   (fdsu_yy_rm                                  ),
  .forever_cpuclk                               (forever_cpuclk                              ),
  .half0_ex3_frac_add1_op1                      (half0_ex3_frac_add1_op1                     ),
  .half0_ex3_frac_final_rst                     (half0_ex3_frac_final_rst                    ),
  .half0_ex3_frac_sub1_op1                      (half0_ex3_frac_sub1_op1                     ),
  .half0_ex3_frac_sub1_op2                      (half0_ex3_frac_sub1_op2                     ),
  .half0_total_qt_rt                            (half0_total_qt_rt                           ),
  .pad_yy_icg_scan_en                           (pad_yy_icg_scan_en                          ),
  .single0_ex3_frac_add1_op1                    (single0_ex3_frac_add1_op1                   ),
  .single0_ex3_frac_final_rst                   (single0_ex3_frac_final_rst                  ),
  .single0_ex3_frac_sub1_op1                    (single0_ex3_frac_sub1_op1                   ),
  .single0_ex3_frac_sub1_op2                    (single0_ex3_frac_sub1_op2                   ),
  .single0_total_qt_rt                          (single0_total_qt_rt                         )
);

// &ConnRule(s/double_/double0_/); @34
// &Instance("aq_fdsu_pack"); @35
aq_fdsu_pack  x_aq_fdsu_pack (
  .bhalf0_denorm_shift_num              (bhalf0_denorm_shift_num             ),
  .bhalf0_denorm_shift_num_in           (bhalf0_denorm_shift_num_in          ),
  .bhalf0_denorm_shift_val              (bhalf0_denorm_shift_val             ),
  .bhalf0_denorm_to_tiny_frac           (bhalf0_denorm_to_tiny_frac          ),
  .bhalf0_ex4_qnan_f                    (bhalf0_ex4_qnan_f                   ),
  .double_denorm_shift_num              (double0_denorm_shift_num            ),
  .double_denorm_shift_num_in           (double0_denorm_shift_num_in         ),
  .double_denorm_shift_val              (double0_denorm_shift_val            ),
  .double_denorm_to_tiny_frac           (double0_denorm_to_tiny_frac         ),
  .double_ex4_qnan_f                    (double0_ex4_qnan_f                  ),
  .double_pipe_ex4_denorm_to_tiny_frac  (double0_pipe_ex4_denorm_to_tiny_frac),
  .double_pipe_ex4_dz                   (double0_pipe_ex4_dz                 ),
  .double_pipe_ex4_expnt_rst            (double0_pipe_ex4_expnt_rst          ),
  .double_pipe_ex4_expt                 (double0_pipe_ex4_expt               ),
  .double_pipe_ex4_nv                   (double0_pipe_ex4_nv                 ),
  .double_pipe_ex4_nx                   (double0_pipe_ex4_nx                 ),
  .double_pipe_ex4_of                   (double0_pipe_ex4_of                 ),
  .double_pipe_ex4_of_rm_lfn            (double0_pipe_ex4_of_rm_lfn          ),
  .double_pipe_ex4_potnt_norm           (double0_pipe_ex4_potnt_norm         ),
  .double_pipe_ex4_potnt_of             (double0_pipe_ex4_potnt_of           ),
  .double_pipe_ex4_potnt_uf             (double0_pipe_ex4_potnt_uf           ),
  .double_pipe_ex4_result               (double0_pipe_ex4_result             ),
  .double_pipe_ex4_result_inf           (double0_pipe_ex4_result_inf         ),
  .double_pipe_ex4_result_lfn           (double0_pipe_ex4_result_lfn         ),
  .double_pipe_ex4_result_nor           (double0_pipe_ex4_result_nor         ),
  .double_pipe_ex4_result_qnan          (double0_pipe_ex4_result_qnan        ),
  .double_pipe_ex4_result_sign          (double0_pipe_ex4_result_sign        ),
  .double_pipe_ex4_result_zero          (double0_pipe_ex4_result_zero        ),
  .double_pipe_ex4_rslt_denorm          (double0_pipe_ex4_rslt_denorm        ),
  .double_pipe_ex4_uf                   (double0_pipe_ex4_uf                 ),
  .double_pipe_fdsu_ex4_frac            (double0_pipe_fdsu_ex4_frac          ),
  .fdsu_ex4_bhalf                       (fdsu_ex4_bhalf                      ),
  .fdsu_ex4_double                      (fdsu_ex4_double                     ),
  .fdsu_ex4_half                        (fdsu_ex4_half                       ),
  .fdsu_ex4_single                      (fdsu_ex4_single                     ),
  .half0_denorm_shift_num               (half0_denorm_shift_num              ),
  .half0_denorm_shift_num_in            (half0_denorm_shift_num_in           ),
  .half0_denorm_shift_val               (half0_denorm_shift_val              ),
  .half0_denorm_to_tiny_frac            (half0_denorm_to_tiny_frac           ),
  .half0_ex4_qnan_f                     (half0_ex4_qnan_f                    ),
  .single0_denorm_shift_num             (single0_denorm_shift_num            ),
  .single0_denorm_shift_num_in          (single0_denorm_shift_num_in         ),
  .single0_denorm_shift_val             (single0_denorm_shift_val            ),
  .single0_denorm_to_tiny_frac          (single0_denorm_to_tiny_frac         ),
  .single0_ex4_qnan_f                   (single0_ex4_qnan_f                  )
);

// &ConnRule(s/double_/double0_/); @36
// &ConnRule(s/fdsu/double0_pipe/); @37
// &Instance("aq_fdsu_double_dp"); @38
aq_fdsu_double_dp  x_aq_fdsu_double_dp (
  .ex1_pipe_clk                         (ex1_pipe_clk                        ),
  .ex1_pipedown                         (ex1_pipedown                        ),
  .ex2_pipe_clk                         (ex2_pipe_clk                        ),
  .ex2_pipedown                         (ex2_pipedown                        ),
  .ex3_pipedown                         (ex3_pipedown                        ),
  .expnt_rst_clk                        (expnt_rst_clk                       ),
  .fdsu_ex1_dz                          (double0_pipe_ex1_dz                 ),
  .fdsu_ex1_expnt_adder_op0             (double0_pipe_ex1_expnt_adder_op0    ),
  .fdsu_ex1_id_expnt_f                  (double0_pipe_ex1_id_expnt_f         ),
  .fdsu_ex1_nv                          (double0_pipe_ex1_nv                 ),
  .fdsu_ex1_of_result_lfn               (double0_pipe_ex1_of_result_lfn      ),
  .fdsu_ex1_op0_id_expnt_neg            (double0_pipe_ex1_op0_id_expnt_neg   ),
  .fdsu_ex1_op0_norm                    (double0_pipe_ex1_op0_norm           ),
  .fdsu_ex1_op1_norm                    (double0_pipe_ex1_op1_norm           ),
  .fdsu_ex1_result_inf                  (double0_pipe_ex1_result_inf         ),
  .fdsu_ex1_result_lfn                  (double0_pipe_ex1_result_lfn         ),
  .fdsu_ex1_result_qnan                 (double0_pipe_ex1_result_qnan        ),
  .fdsu_ex1_result_sign                 (double0_pipe_ex1_result_sign        ),
  .fdsu_ex1_result_zero                 (double0_pipe_ex1_result_zero        ),
  .fdsu_ex1_save_op0                    (double0_pipe_ex1_save_op0           ),
  .fdsu_ex2_expnt_adder_op0             (double0_pipe_ex2_expnt_adder_op0    ),
  .fdsu_ex2_of                          (double0_pipe_ex2_of                 ),
  .fdsu_ex2_of_rm_lfn                   (double0_pipe_ex2_of_rm_lfn          ),
  .fdsu_ex2_op0_norm                    (double0_pipe_ex2_op0_norm           ),
  .fdsu_ex2_op1_norm                    (double0_pipe_ex2_op1_norm           ),
  .fdsu_ex2_potnt_of                    (double0_pipe_ex2_potnt_of           ),
  .fdsu_ex2_potnt_uf                    (double0_pipe_ex2_potnt_uf           ),
  .fdsu_ex2_result_inf                  (double0_pipe_ex2_result_inf         ),
  .fdsu_ex2_result_lfn                  (double0_pipe_ex2_result_lfn         ),
  .fdsu_ex2_rslt_denorm                 (double0_pipe_ex2_rslt_denorm        ),
  .fdsu_ex2_srt_expnt_rst               (double0_pipe_ex2_srt_expnt_rst      ),
  .fdsu_ex2_uf                          (double0_pipe_ex2_uf                 ),
  .fdsu_ex3_expnt_adjust_result         (double0_pipe_ex3_expnt_adjust_result),
  .fdsu_ex3_expnt_rst                   (double0_pipe_ex3_expnt_rst          ),
  .fdsu_ex3_potnt_uf                    (double0_pipe_ex3_potnt_uf           ),
  .fdsu_ex3_result_inf                  (double0_pipe_ex3_result_inf         ),
  .fdsu_ex3_result_lfn                  (double0_pipe_ex3_result_lfn         ),
  .fdsu_ex3_result_qnan                 (double0_pipe_ex3_result_qnan        ),
  .fdsu_ex3_result_sign                 (double0_pipe_ex3_result_sign        ),
  .fdsu_ex3_result_zero                 (double0_pipe_ex3_result_zero        ),
  .fdsu_ex3_rslt_denorm                 (double0_pipe_ex3_rslt_denorm        ),
  .fdsu_ex3_rslt_denorm_in              (double0_pipe_ex3_rslt_denorm_in     ),
  .fdsu_ex4_dz                          (double0_pipe_ex4_dz                 ),
  .fdsu_ex4_expnt_rst                   (double0_pipe_ex4_expnt_rst          ),
  .fdsu_ex4_nv                          (double0_pipe_ex4_nv                 ),
  .fdsu_ex4_of                          (double0_pipe_ex4_of                 ),
  .fdsu_ex4_of_rm_lfn                   (double0_pipe_ex4_of_rm_lfn          ),
  .fdsu_ex4_potnt_of                    (double0_pipe_ex4_potnt_of           ),
  .fdsu_ex4_potnt_uf                    (double0_pipe_ex4_potnt_uf           ),
  .fdsu_ex4_result_inf                  (double0_pipe_ex4_result_inf         ),
  .fdsu_ex4_result_lfn                  (double0_pipe_ex4_result_lfn         ),
  .fdsu_ex4_result_qnan                 (double0_pipe_ex4_result_qnan        ),
  .fdsu_ex4_result_sign                 (double0_pipe_ex4_result_sign        ),
  .fdsu_ex4_result_zero                 (double0_pipe_ex4_result_zero        ),
  .fdsu_ex4_rslt_denorm                 (double0_pipe_ex4_rslt_denorm        ),
  .fdsu_ex4_uf                          (double0_pipe_ex4_uf                 ),
  .fdsu_op0_ff1_cnt                     (double0_pipe_op0_ff1_cnt            ),
  .fdsu_op0_id_expnt                    (double0_pipe_op0_id_expnt           ),
  .fdsu_save_op0_neg_expnt              (double0_pipe_save_op0_neg_expnt     )
);


endmodule


