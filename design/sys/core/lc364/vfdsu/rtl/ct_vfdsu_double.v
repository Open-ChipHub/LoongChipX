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

// &Depend("cpu_cfig.h"); @22
// &ModuleBeg; @23
module ct_vfdsu_double (
  // &Ports, @24
  input    wire          cp0_vfpu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ex1_div,
  input    wire          ex1_double,
  input    wire          ex1_pipedown,
  input    wire          ex1_scalar,
  input    wire          ex1_single,
  input    wire          ex1_sqrt,
  input    wire  [63:0]  ex1_src0,
  input    wire  [63:0]  ex1_src1,
  input    wire  [2 :0]  ex1_static_rm,
  input    wire          ex2_pipedown,
  input    wire          ex2_srt_first_round,
  input    wire          ex3_pipedown,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          srt_secd_round,
  input    wire          srt_sm_on,
  input    wire          vfpu_yy_xx_dqnan,
  input    wire  [2 :0]  vfpu_yy_xx_rm,
  output   wire  [4 :0]  ex4_out_expt,
  output   wire  [63:0]  ex4_out_result,
  output   wire          srt_ctrl_rem_zero,
  output   wire          srt_ctrl_skip_srt
); 



// &Regs; @25
// &Wires; @26
wire    [52:0]  ex1_divisor;                          
wire    [59:0]  ex1_remainder;                        
wire    [57:0]  total_qt_rt_58;                       
wire            vfdsu_ex2_div;                        
wire            vfdsu_ex2_double;                     
wire            vfdsu_ex2_dz;                         
wire    [12:0]  vfdsu_ex2_expnt_add0;                 
wire    [12:0]  vfdsu_ex2_expnt_add1;                 
wire            vfdsu_ex2_nv;                         
wire            vfdsu_ex2_of_rm_lfn;                  
wire            vfdsu_ex2_op0_norm;                   
wire            vfdsu_ex2_op1_norm;                   
wire    [51:0]  vfdsu_ex2_qnan_f;                     
wire            vfdsu_ex2_qnan_sign;                  
wire            vfdsu_ex2_result_inf;                 
wire            vfdsu_ex2_result_qnan;                
wire            vfdsu_ex2_result_sign;                
wire            vfdsu_ex2_result_zero;                
wire    [2 :0]  vfdsu_ex2_rm;                         
wire            vfdsu_ex2_single;                     
wire            vfdsu_ex2_sqrt;                       
wire            vfdsu_ex2_srt_skip;                   
wire    [12:0]  vfdsu_ex3_doub_expnt_rst;             
wire            vfdsu_ex3_double;                     
wire            vfdsu_ex3_dz;                         
wire    [12:0]  vfdsu_ex3_half_expnt_rst;             
wire            vfdsu_ex3_id_srt_skip;                
wire            vfdsu_ex3_nv;                         
wire            vfdsu_ex3_of;                         
wire            vfdsu_ex3_potnt_of;                   
wire            vfdsu_ex3_potnt_uf;                   
wire    [51:0]  vfdsu_ex3_qnan_f;                     
wire            vfdsu_ex3_qnan_sign;                  
wire            vfdsu_ex3_rem_sign;                   
wire            vfdsu_ex3_rem_zero;                   
wire    [52:0]  vfdsu_ex3_result_denorm_round_add_num; 
wire            vfdsu_ex3_result_inf;                 
wire            vfdsu_ex3_result_lfn;                 
wire            vfdsu_ex3_result_qnan;                
wire            vfdsu_ex3_result_sign;                
wire            vfdsu_ex3_result_zero;                
wire    [2 :0]  vfdsu_ex3_rm;                         
wire            vfdsu_ex3_rslt_denorm;                
wire    [8 :0]  vfdsu_ex3_sing_expnt_rst;             
wire            vfdsu_ex3_single;                     
wire            vfdsu_ex3_uf;                         
wire            vfdsu_ex4_denorm_to_tiny_frac;        
wire            vfdsu_ex4_double;                     
wire            vfdsu_ex4_dz;                         
wire    [12:0]  vfdsu_ex4_expnt_rst;                  
wire    [54:0]  vfdsu_ex4_frac;                       
wire            vfdsu_ex4_nv;                         
wire            vfdsu_ex4_nx;                         
wire            vfdsu_ex4_of;                         
wire            vfdsu_ex4_of_rst_lfn;                 
wire    [1 :0]  vfdsu_ex4_potnt_norm;                 
wire            vfdsu_ex4_potnt_of;                   
wire            vfdsu_ex4_potnt_uf;                   
wire    [51:0]  vfdsu_ex4_qnan_f;                     
wire            vfdsu_ex4_qnan_sign;                  
wire            vfdsu_ex4_result_inf;                 
wire            vfdsu_ex4_result_lfn;                 
wire            vfdsu_ex4_result_nor;                 
wire            vfdsu_ex4_result_qnan;                
wire            vfdsu_ex4_result_sign;                
wire            vfdsu_ex4_result_zero;                
wire            vfdsu_ex4_rslt_denorm;                
wire            vfdsu_ex4_single;                     
wire            vfdsu_ex4_uf;                         


// &Instance("ct_vfdsu_prepare"); @28
ct_vfdsu_prepare  x_ct_vfdsu_prepare (
  .cp0_vfpu_icg_en       (cp0_vfpu_icg_en      ),
  .cp0_yy_clk_en         (cp0_yy_clk_en        ),
  .cpurst_b              (cpurst_b             ),
  .ex1_div               (ex1_div              ),
  .ex1_divisor           (ex1_divisor          ),
  .ex1_double            (ex1_double           ),
  .ex1_pipedown          (ex1_pipedown         ),
  .ex1_remainder         (ex1_remainder        ),
  .ex1_scalar            (ex1_scalar           ),
  .ex1_single            (ex1_single           ),
  .ex1_sqrt              (ex1_sqrt             ),
  .ex1_src0              (ex1_src0             ),
  .ex1_src1              (ex1_src1             ),
  .ex1_static_rm         (ex1_static_rm        ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .vfdsu_ex2_div         (vfdsu_ex2_div        ),
  .vfdsu_ex2_double      (vfdsu_ex2_double     ),
  .vfdsu_ex2_dz          (vfdsu_ex2_dz         ),
  .vfdsu_ex2_expnt_add0  (vfdsu_ex2_expnt_add0 ),
  .vfdsu_ex2_expnt_add1  (vfdsu_ex2_expnt_add1 ),
  .vfdsu_ex2_nv          (vfdsu_ex2_nv         ),
  .vfdsu_ex2_of_rm_lfn   (vfdsu_ex2_of_rm_lfn  ),
  .vfdsu_ex2_op0_norm    (vfdsu_ex2_op0_norm   ),
  .vfdsu_ex2_op1_norm    (vfdsu_ex2_op1_norm   ),
  .vfdsu_ex2_qnan_f      (vfdsu_ex2_qnan_f     ),
  .vfdsu_ex2_qnan_sign   (vfdsu_ex2_qnan_sign  ),
  .vfdsu_ex2_result_inf  (vfdsu_ex2_result_inf ),
  .vfdsu_ex2_result_qnan (vfdsu_ex2_result_qnan),
  .vfdsu_ex2_result_sign (vfdsu_ex2_result_sign),
  .vfdsu_ex2_result_zero (vfdsu_ex2_result_zero),
  .vfdsu_ex2_rm          (vfdsu_ex2_rm         ),
  .vfdsu_ex2_single      (vfdsu_ex2_single     ),
  .vfdsu_ex2_sqrt        (vfdsu_ex2_sqrt       ),
  .vfdsu_ex2_srt_skip    (vfdsu_ex2_srt_skip   ),
  .vfpu_yy_xx_dqnan      (vfpu_yy_xx_dqnan     ),
  .vfpu_yy_xx_rm         (vfpu_yy_xx_rm        )
);

// &Instance("ct_vfdsu_srt"); @29
ct_vfdsu_srt  x_ct_vfdsu_srt (
  .cp0_vfpu_icg_en                       (cp0_vfpu_icg_en                      ),
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),
  .cpurst_b                              (cpurst_b                             ),
  .ex1_div                               (ex1_div                              ),
  .ex1_divisor                           (ex1_divisor                          ),
  .ex1_pipedown                          (ex1_pipedown                         ),
  .ex1_remainder                         (ex1_remainder                        ),
  .ex1_sqrt                              (ex1_sqrt                             ),
  .ex2_pipedown                          (ex2_pipedown                         ),
  .ex2_srt_first_round                   (ex2_srt_first_round                  ),
  .forever_cpuclk                        (forever_cpuclk                       ),
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),
  .srt_ctrl_rem_zero                     (srt_ctrl_rem_zero                    ),
  .srt_ctrl_skip_srt                     (srt_ctrl_skip_srt                    ),
  .srt_secd_round                        (srt_secd_round                       ),
  .srt_sm_on                             (srt_sm_on                            ),
  .total_qt_rt_58                        (total_qt_rt_58                       ),
  .vfdsu_ex2_div                         (vfdsu_ex2_div                        ),
  .vfdsu_ex2_double                      (vfdsu_ex2_double                     ),
  .vfdsu_ex2_dz                          (vfdsu_ex2_dz                         ),
  .vfdsu_ex2_expnt_add0                  (vfdsu_ex2_expnt_add0                 ),
  .vfdsu_ex2_expnt_add1                  (vfdsu_ex2_expnt_add1                 ),
  .vfdsu_ex2_nv                          (vfdsu_ex2_nv                         ),
  .vfdsu_ex2_of_rm_lfn                   (vfdsu_ex2_of_rm_lfn                  ),
  .vfdsu_ex2_op0_norm                    (vfdsu_ex2_op0_norm                   ),
  .vfdsu_ex2_op1_norm                    (vfdsu_ex2_op1_norm                   ),
  .vfdsu_ex2_qnan_f                      (vfdsu_ex2_qnan_f                     ),
  .vfdsu_ex2_qnan_sign                   (vfdsu_ex2_qnan_sign                  ),
  .vfdsu_ex2_result_inf                  (vfdsu_ex2_result_inf                 ),
  .vfdsu_ex2_result_qnan                 (vfdsu_ex2_result_qnan                ),
  .vfdsu_ex2_result_sign                 (vfdsu_ex2_result_sign                ),
  .vfdsu_ex2_result_zero                 (vfdsu_ex2_result_zero                ),
  .vfdsu_ex2_rm                          (vfdsu_ex2_rm                         ),
  .vfdsu_ex2_single                      (vfdsu_ex2_single                     ),
  .vfdsu_ex2_sqrt                        (vfdsu_ex2_sqrt                       ),
  .vfdsu_ex2_srt_skip                    (vfdsu_ex2_srt_skip                   ),
  .vfdsu_ex3_doub_expnt_rst              (vfdsu_ex3_doub_expnt_rst             ),
  .vfdsu_ex3_double                      (vfdsu_ex3_double                     ),
  .vfdsu_ex3_dz                          (vfdsu_ex3_dz                         ),
  .vfdsu_ex3_half_expnt_rst              (vfdsu_ex3_half_expnt_rst             ),
  .vfdsu_ex3_id_srt_skip                 (vfdsu_ex3_id_srt_skip                ),
  .vfdsu_ex3_nv                          (vfdsu_ex3_nv                         ),
  .vfdsu_ex3_of                          (vfdsu_ex3_of                         ),
  .vfdsu_ex3_potnt_of                    (vfdsu_ex3_potnt_of                   ),
  .vfdsu_ex3_potnt_uf                    (vfdsu_ex3_potnt_uf                   ),
  .vfdsu_ex3_qnan_f                      (vfdsu_ex3_qnan_f                     ),
  .vfdsu_ex3_qnan_sign                   (vfdsu_ex3_qnan_sign                  ),
  .vfdsu_ex3_rem_sign                    (vfdsu_ex3_rem_sign                   ),
  .vfdsu_ex3_rem_zero                    (vfdsu_ex3_rem_zero                   ),
  .vfdsu_ex3_result_denorm_round_add_num (vfdsu_ex3_result_denorm_round_add_num),
  .vfdsu_ex3_result_inf                  (vfdsu_ex3_result_inf                 ),
  .vfdsu_ex3_result_lfn                  (vfdsu_ex3_result_lfn                 ),
  .vfdsu_ex3_result_qnan                 (vfdsu_ex3_result_qnan                ),
  .vfdsu_ex3_result_sign                 (vfdsu_ex3_result_sign                ),
  .vfdsu_ex3_result_zero                 (vfdsu_ex3_result_zero                ),
  .vfdsu_ex3_rm                          (vfdsu_ex3_rm                         ),
  .vfdsu_ex3_rslt_denorm                 (vfdsu_ex3_rslt_denorm                ),
  .vfdsu_ex3_sing_expnt_rst              (vfdsu_ex3_sing_expnt_rst             ),
  .vfdsu_ex3_single                      (vfdsu_ex3_single                     ),
  .vfdsu_ex3_uf                          (vfdsu_ex3_uf                         )
);

// &Instance("ct_vfdsu_round"); @30
ct_vfdsu_round  x_ct_vfdsu_round (
  .cp0_vfpu_icg_en                       (cp0_vfpu_icg_en                      ),
  .cp0_yy_clk_en                         (cp0_yy_clk_en                        ),
  .cpurst_b                              (cpurst_b                             ),
  .ex3_pipedown                          (ex3_pipedown                         ),
  .forever_cpuclk                        (forever_cpuclk                       ),
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                   ),
  .total_qt_rt_58                        (total_qt_rt_58                       ),
  .vfdsu_ex2_of_rm_lfn                   (vfdsu_ex2_of_rm_lfn                  ),
  .vfdsu_ex3_doub_expnt_rst              (vfdsu_ex3_doub_expnt_rst             ),
  .vfdsu_ex3_double                      (vfdsu_ex3_double                     ),
  .vfdsu_ex3_dz                          (vfdsu_ex3_dz                         ),
  .vfdsu_ex3_half_expnt_rst              (vfdsu_ex3_half_expnt_rst             ),
  .vfdsu_ex3_id_srt_skip                 (vfdsu_ex3_id_srt_skip                ),
  .vfdsu_ex3_nv                          (vfdsu_ex3_nv                         ),
  .vfdsu_ex3_of                          (vfdsu_ex3_of                         ),
  .vfdsu_ex3_potnt_of                    (vfdsu_ex3_potnt_of                   ),
  .vfdsu_ex3_potnt_uf                    (vfdsu_ex3_potnt_uf                   ),
  .vfdsu_ex3_qnan_f                      (vfdsu_ex3_qnan_f                     ),
  .vfdsu_ex3_qnan_sign                   (vfdsu_ex3_qnan_sign                  ),
  .vfdsu_ex3_rem_sign                    (vfdsu_ex3_rem_sign                   ),
  .vfdsu_ex3_rem_zero                    (vfdsu_ex3_rem_zero                   ),
  .vfdsu_ex3_result_denorm_round_add_num (vfdsu_ex3_result_denorm_round_add_num),
  .vfdsu_ex3_result_inf                  (vfdsu_ex3_result_inf                 ),
  .vfdsu_ex3_result_lfn                  (vfdsu_ex3_result_lfn                 ),
  .vfdsu_ex3_result_qnan                 (vfdsu_ex3_result_qnan                ),
  .vfdsu_ex3_result_sign                 (vfdsu_ex3_result_sign                ),
  .vfdsu_ex3_result_zero                 (vfdsu_ex3_result_zero                ),
  .vfdsu_ex3_rm                          (vfdsu_ex3_rm                         ),
  .vfdsu_ex3_rslt_denorm                 (vfdsu_ex3_rslt_denorm                ),
  .vfdsu_ex3_sing_expnt_rst              (vfdsu_ex3_sing_expnt_rst             ),
  .vfdsu_ex3_single                      (vfdsu_ex3_single                     ),
  .vfdsu_ex3_uf                          (vfdsu_ex3_uf                         ),
  .vfdsu_ex4_denorm_to_tiny_frac         (vfdsu_ex4_denorm_to_tiny_frac        ),
  .vfdsu_ex4_double                      (vfdsu_ex4_double                     ),
  .vfdsu_ex4_dz                          (vfdsu_ex4_dz                         ),
  .vfdsu_ex4_expnt_rst                   (vfdsu_ex4_expnt_rst                  ),
  .vfdsu_ex4_frac                        (vfdsu_ex4_frac                       ),
  .vfdsu_ex4_nv                          (vfdsu_ex4_nv                         ),
  .vfdsu_ex4_nx                          (vfdsu_ex4_nx                         ),
  .vfdsu_ex4_of                          (vfdsu_ex4_of                         ),
  .vfdsu_ex4_of_rst_lfn                  (vfdsu_ex4_of_rst_lfn                 ),
  .vfdsu_ex4_potnt_norm                  (vfdsu_ex4_potnt_norm                 ),
  .vfdsu_ex4_potnt_of                    (vfdsu_ex4_potnt_of                   ),
  .vfdsu_ex4_potnt_uf                    (vfdsu_ex4_potnt_uf                   ),
  .vfdsu_ex4_qnan_f                      (vfdsu_ex4_qnan_f                     ),
  .vfdsu_ex4_qnan_sign                   (vfdsu_ex4_qnan_sign                  ),
  .vfdsu_ex4_result_inf                  (vfdsu_ex4_result_inf                 ),
  .vfdsu_ex4_result_lfn                  (vfdsu_ex4_result_lfn                 ),
  .vfdsu_ex4_result_nor                  (vfdsu_ex4_result_nor                 ),
  .vfdsu_ex4_result_qnan                 (vfdsu_ex4_result_qnan                ),
  .vfdsu_ex4_result_sign                 (vfdsu_ex4_result_sign                ),
  .vfdsu_ex4_result_zero                 (vfdsu_ex4_result_zero                ),
  .vfdsu_ex4_rslt_denorm                 (vfdsu_ex4_rslt_denorm                ),
  .vfdsu_ex4_single                      (vfdsu_ex4_single                     ),
  .vfdsu_ex4_uf                          (vfdsu_ex4_uf                         )
);

// &Instance("ct_vfdsu_pack"); @31
ct_vfdsu_pack  x_ct_vfdsu_pack (
  .ex4_out_expt                  (ex4_out_expt                 ),
  .ex4_out_result                (ex4_out_result               ),
  .vfdsu_ex4_denorm_to_tiny_frac (vfdsu_ex4_denorm_to_tiny_frac),
  .vfdsu_ex4_double              (vfdsu_ex4_double             ),
  .vfdsu_ex4_dz                  (vfdsu_ex4_dz                 ),
  .vfdsu_ex4_expnt_rst           (vfdsu_ex4_expnt_rst          ),
  .vfdsu_ex4_frac                (vfdsu_ex4_frac               ),
  .vfdsu_ex4_nv                  (vfdsu_ex4_nv                 ),
  .vfdsu_ex4_nx                  (vfdsu_ex4_nx                 ),
  .vfdsu_ex4_of                  (vfdsu_ex4_of                 ),
  .vfdsu_ex4_of_rst_lfn          (vfdsu_ex4_of_rst_lfn         ),
  .vfdsu_ex4_potnt_norm          (vfdsu_ex4_potnt_norm         ),
  .vfdsu_ex4_potnt_of            (vfdsu_ex4_potnt_of           ),
  .vfdsu_ex4_potnt_uf            (vfdsu_ex4_potnt_uf           ),
  .vfdsu_ex4_qnan_f              (vfdsu_ex4_qnan_f             ),
  .vfdsu_ex4_qnan_sign           (vfdsu_ex4_qnan_sign          ),
  .vfdsu_ex4_result_inf          (vfdsu_ex4_result_inf         ),
  .vfdsu_ex4_result_lfn          (vfdsu_ex4_result_lfn         ),
  .vfdsu_ex4_result_nor          (vfdsu_ex4_result_nor         ),
  .vfdsu_ex4_result_qnan         (vfdsu_ex4_result_qnan        ),
  .vfdsu_ex4_result_sign         (vfdsu_ex4_result_sign        ),
  .vfdsu_ex4_result_zero         (vfdsu_ex4_result_zero        ),
  .vfdsu_ex4_rslt_denorm         (vfdsu_ex4_rslt_denorm        ),
  .vfdsu_ex4_single              (vfdsu_ex4_single             ),
  .vfdsu_ex4_uf                  (vfdsu_ex4_uf                 )
);



// &ModuleEnd; @34
endmodule


