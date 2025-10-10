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

// &ModuleBeg; @22
module aq_falu_top (
  // &Ports, @23
  input    wire          cp0_vpu_icg_en,
  input    wire          cp0_vpu_xx_bf16,
  input    wire          cpurst_b,
  input    wire          cp0_vpu_xx_dqnan,
  input    wire          cp0_yy_clk_en,
  input    wire          forever_cpuclk,
  input    wire          ifu_vpu_warm_up,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [9 :0]  vpu_group_1_xx_ex1_eu_sel,
  input    wire  [19:0]  vpu_group_1_xx_ex1_func,
  input    wire  [2 :0]  vpu_group_1_xx_ex1_rm,
  input    wire          vpu_group_1_xx_ex1_sel,
  input    wire  [63:0]  vpu_group_1_xx_ex1_srcv0,
  input    wire  [47:0]  vpu_group_1_xx_ex1_srcv0_type,
  input    wire  [63:0]  vpu_group_1_xx_ex1_srcv1,
  input    wire  [47:0]  vpu_group_1_xx_ex1_srcv1_type,
  input    wire  [9 :0]  vpu_group_1_xx_ex2_eu_sel,
  input    wire  [2 :0]  vpu_group_1_xx_ex2_rm,
  input    wire          vpu_group_1_xx_ex2_sel,
  input    wire          vpu_group_1_xx_ex2_stall,
  input    wire  [9 :0]  vpu_group_1_xx_ex3_eu_sel,
  input    wire          vpu_group_1_xx_ex3_sel,
  input    wire          vpu_group_1_xx_ex3_stall,
  input    wire          vpu_group_1_xx_ex4_stall,
  output   wire          vfalu_vpu_ex1_denormal_stall,
  output   wire  [63:0]  vfalu_vpu_ex2_gpr_result,
  output   wire          vfalu_vpu_ex2_result_ready_in_ex3, // ex2结果有效, cmp操作
  output   wire  [4 :0]  vfalu_vpu_ex3_fflags,
  output   wire  [63:0]  vfalu_vpu_ex3_fpr_result,
  output   wire          vfalu_vpu_ex3_result_ready_in_ex4, // ex3结果有效
  output   wire  [4 :0]  vfalu_vpu_ex4_fflags,
  output   wire  [63:0]  vfalu_vpu_ex4_fpr_result
); 


wire            double_pipe_ex1_src0_cnan;        
wire            double_pipe_ex1_src0_id;          
wire            double_pipe_ex1_src0_inf;         
wire            double_pipe_ex1_src0_qnan;        
wire            double_pipe_ex1_src0_snan;        
wire            double_pipe_ex1_src0_zero;        
wire            double_pipe_ex1_src1_cnan;        
wire            double_pipe_ex1_src1_id;          
wire            double_pipe_ex1_src1_inf;         
wire            double_pipe_ex1_src1_qnan;        
wire            double_pipe_ex1_src1_snan;        
wire            double_pipe_ex1_src1_zero;        
wire            double_pipe_ex2_cmp_r;            
wire    [63:0]  double_pipe_ex2_special_result;   
wire    [4 :0]  double_pipe_ex3_expt;             
wire            ex1_bhalf;                        
wire    [8 :0]  ex1_bhalf0_adder_a_final;         
wire    [15:0]  ex1_bhalf0_special_data;          
wire            ex1_double;                       
wire    [53:0]  ex1_double_adder_a_final;         
wire    [63:0]  ex1_double_special_data;          
wire            ex1_f16;                          
wire            ex1_half;                         
wire    [11:0]  ex1_half0_adder_a_final;          
wire    [15:0]  ex1_half0_special_data;           
wire            ex1_op_add;                       
wire            ex1_op_add_sub;                   
wire            ex1_op_cmp;                       
wire            ex1_op_sel;          
wire            ex1_op_sela;             
wire            ex1_op_sub;                       
wire            ex1_rdn;                          
wire            ex1_single;                       
wire    [24:0]  ex1_single0_adder_a_final;        
wire    [31:0]  ex1_single0_special_data;         
wire            ex2_bhalf;                        
wire    [8 :0]  ex2_bhalf0_rslt;                  
wire            ex2_double;                       
wire    [53:0]  ex2_double_adder_a;               
wire    [53:0]  ex2_double_rslt;                  
wire            ex2_half;                         
wire    [11:0]  ex2_half0_rslt;                   
wire            ex2_op_add_sub;                   
wire            ex2_op_cmp;                       
wire            ex2_op_feq;                       
wire            ex2_op_fle;                       
wire            ex2_op_flt;                       
wire            ex2_op_fne;       
wire            ex2_op_faf;
wire            ex2_op_fueq;
wire            ex2_op_fult;
wire            ex2_op_fule;
wire            ex2_op_fune;
wire            ex2_op_fuord;
wire            ex2_op_ford;
wire            ex2_signal;               
wire            ex2_op_max;                       
wire            ex2_op_min;                       
wire            ex2_op_sel;         
wire            ex2_op_sela;              
wire            ex2_op_sub;                       
wire            ex2_rdn;                          
wire            ex2_rmm;                          
wire            ex2_rne;                          
wire            ex2_rtz;                          
wire            ex2_rup;                          
wire            ex2_single;                       
wire    [24:0]  ex2_single0_rslt;                 
wire            ex3_bhalf;                        
wire    [8 :0]  ex3_bhalf0_result;                
wire            ex3_double;                       
wire    [53:0]  ex3_double_result;                
wire            ex3_half;                         
wire    [11:0]  ex3_half0_result;                 
wire            ex3_op_cmp;                       
wire            ex3_op_sel;                       
wire            ex3_rdn;                          
wire            ex3_rtz;                          
wire            ex3_rup;                          
wire            ex3_single;                       
wire    [24:0]  ex3_single0_result;               
wire    [63:0]  fadd_double_src0;                 
wire    [63:0]  fadd_double_src1;                 
wire            fadd_ex1_pipe_clk;                
wire            fadd_ex1_pipedown;                
wire            fadd_ex2_nocmp;                   
wire            fadd_ex2_nocmp_pipe_clk;          
wire            fadd_ex2_nocmp_pipedown;          
wire            fadd_ex2_pipe_clk;                
wire            fadd_ex2_pipedown;                
wire    [63:0]  fadd_ex3_bhalf0_rslt;             
wire    [63:0]  fadd_ex3_double_rslt;             
wire    [63:0]  fadd_ex3_half0_rslt;              
wire            fadd_ex3_pipedown;                
wire    [63:0]  fadd_ex3_single0_rslt;            
wire    [15:0]  fadd_half0_src0;                  
wire    [15:0]  fadd_half0_src1;                  
wire    [31:0]  fadd_single0_src0;                
wire    [31:0]  fadd_single0_src1;                

aq_fadd_double_top  x_aq_fadd_double_top (
  .cp0_vpu_xx_dqnan               (cp0_vpu_xx_dqnan              ),
  .double_pipe_ex1_src0_cnan      (double_pipe_ex1_src0_cnan     ),
  .double_pipe_ex1_src0_id        (double_pipe_ex1_src0_id       ),
  .double_pipe_ex1_src0_inf       (double_pipe_ex1_src0_inf      ),
  .double_pipe_ex1_src0_qnan      (double_pipe_ex1_src0_qnan     ),
  .double_pipe_ex1_src0_snan      (double_pipe_ex1_src0_snan     ),
  .double_pipe_ex1_src0_zero      (double_pipe_ex1_src0_zero     ),
  .double_pipe_ex1_src1_cnan      (double_pipe_ex1_src1_cnan     ),
  .double_pipe_ex1_src1_id        (double_pipe_ex1_src1_id       ),
  .double_pipe_ex1_src1_inf       (double_pipe_ex1_src1_inf      ),
  .double_pipe_ex1_src1_qnan      (double_pipe_ex1_src1_qnan     ),
  .double_pipe_ex1_src1_snan      (double_pipe_ex1_src1_snan     ),
  .double_pipe_ex1_src1_zero      (double_pipe_ex1_src1_zero     ),
  .double_pipe_ex2_cmp_r          (double_pipe_ex2_cmp_r         ),
  .double_pipe_ex2_special_result (double_pipe_ex2_special_result),
  .double_pipe_ex3_expt           (double_pipe_ex3_expt          ),
  .ex1_bhalf                      (ex1_bhalf                     ),
  .ex1_bhalf0_adder_a_final       (ex1_bhalf0_adder_a_final      ),
  .ex1_bhalf0_special_data        (ex1_bhalf0_special_data       ),
  .ex1_double                     (ex1_double                    ),
  .ex1_double_adder_a_final       (ex1_double_adder_a_final      ),
  .ex1_double_special_data        (ex1_double_special_data       ),
  .ex1_f16                        (ex1_f16                       ),
  .ex1_half                       (ex1_half                      ),
  .ex1_half0_adder_a_final        (ex1_half0_adder_a_final       ),
  .ex1_half0_special_data         (ex1_half0_special_data        ),
  .ex1_op_add                     (ex1_op_add                    ),
  .ex1_op_add_sub                 (ex1_op_add_sub                ),
  .ex1_op_cmp                     (ex1_op_cmp                    ),
  .ex1_op_sel                     (ex1_op_sel                    ),
  .ex1_op_sela                    (ex1_op_sela                   ),
  .ex1_op_sub                     (ex1_op_sub                    ),
  .ex1_rdn                        (ex1_rdn                       ),
  .ex1_single                     (ex1_single                    ),
  .ex1_single0_adder_a_final      (ex1_single0_adder_a_final     ),
  .ex1_single0_special_data       (ex1_single0_special_data      ),
  .ex2_bhalf                      (ex2_bhalf                     ),
  .ex2_bhalf0_rslt                (ex2_bhalf0_rslt               ),
  .ex2_double                     (ex2_double                    ),
  .ex2_double_adder_a             (ex2_double_adder_a            ),
  .ex2_double_rslt                (ex2_double_rslt               ),
  .ex2_half                       (ex2_half                      ),
  .ex2_half0_rslt                 (ex2_half0_rslt                ),
  .ex2_op_add_sub                 (ex2_op_add_sub                ),
  .ex2_op_cmp                     (ex2_op_cmp                    ),
  .ex2_op_feq                     (ex2_op_feq                    ),
  .ex2_op_fle                     (ex2_op_fle                    ),
  .ex2_op_flt                     (ex2_op_flt                    ),
  .ex2_op_fne                     (ex2_op_fne                    ),
  .ex2_op_faf                     (ex2_op_faf                    ),
  .ex2_op_fueq                    (ex2_op_fueq                   ),
  .ex2_op_fult                    (ex2_op_fult                   ),
  .ex2_op_fule                    (ex2_op_fule                   ),
  .ex2_op_fune                    (ex2_op_fune                   ),
  .ex2_op_fuord                   (ex2_op_fuord                  ),
  .ex2_op_ford                    (ex2_op_ford                   ),
  .ex2_signal                     (ex2_signal                    ),
  .ex2_op_max                     (ex2_op_max                    ),
  .ex2_op_min                     (ex2_op_min                    ),
  .ex2_op_sel                     (ex2_op_sel                    ),
  .ex2_op_sela                    (ex2_op_sela                   ),
  .ex2_op_sub                     (ex2_op_sub                    ),
  .ex2_rdn                        (ex2_rdn                       ),
  .ex2_rmm                        (ex2_rmm                       ),
  .ex2_rne                        (ex2_rne                       ),
  .ex2_rtz                        (ex2_rtz                       ),
  .ex2_rup                        (ex2_rup                       ),
  .ex2_single                     (ex2_single                    ),
  .ex2_single0_rslt               (ex2_single0_rslt              ),
  .ex3_bhalf                      (ex3_bhalf                     ),
  .ex3_bhalf0_result              (ex3_bhalf0_result             ),
  .ex3_double                     (ex3_double                    ),
  .ex3_double_result              (ex3_double_result             ),
  .ex3_half                       (ex3_half                      ),
  .ex3_half0_result               (ex3_half0_result              ),
  .ex3_op_cmp                     (ex3_op_cmp                    ),
  .ex3_op_sel                     (ex3_op_sel                    ),
  .ex3_rdn                        (ex3_rdn                       ),
  .ex3_rtz                        (ex3_rtz                       ),
  .ex3_rup                        (ex3_rup                       ),
  .ex3_single                     (ex3_single                    ),
  .ex3_single0_result             (ex3_single0_result            ),
  .fadd_double_src0               (fadd_double_src0              ),
  .fadd_double_src1               (fadd_double_src1              ),
  .fadd_ex1_pipe_clk              (fadd_ex1_pipe_clk             ),
  .fadd_ex1_pipedown              (fadd_ex1_pipedown             ),
  .fadd_ex2_nocmp_pipe_clk        (fadd_ex2_nocmp_pipe_clk       ),
  .fadd_ex2_nocmp_pipedown        (fadd_ex2_nocmp_pipedown       ),
  .fadd_ex2_pipe_clk              (fadd_ex2_pipe_clk             ),
  .fadd_ex2_pipedown              (fadd_ex2_pipedown             ),
  .fadd_ex3_bhalf0_rslt           (fadd_ex3_bhalf0_rslt          ),
  .fadd_ex3_double_rslt           (fadd_ex3_double_rslt          ),
  .fadd_ex3_half0_rslt            (fadd_ex3_half0_rslt           ),
  .fadd_ex3_single0_rslt          (fadd_ex3_single0_rslt         ),
  .fadd_half0_src0                (fadd_half0_src0               ),
  .fadd_half0_src1                (fadd_half0_src1               ),
  .fadd_single0_src0              (fadd_single0_src0             ),
  .fadd_single0_src1              (fadd_single0_src1             ),
  .ifu_vpu_warm_up                (ifu_vpu_warm_up               )
);

// &Instance("aq_fadd_scalar_dp"); @63
aq_fadd_scalar_dp  x_aq_fadd_scalar_dp (
  .cp0_vpu_icg_en                    (cp0_vpu_icg_en                   ),
  .cp0_vpu_xx_bf16                   (cp0_vpu_xx_bf16                  ),
  .cp0_yy_clk_en                     (cp0_yy_clk_en                    ),
  .double_pipe_ex1_src0_cnan         (double_pipe_ex1_src0_cnan        ),
  .double_pipe_ex1_src0_id           (double_pipe_ex1_src0_id          ),
  .double_pipe_ex1_src0_inf          (double_pipe_ex1_src0_inf         ),
  .double_pipe_ex1_src0_qnan         (double_pipe_ex1_src0_qnan        ),
  .double_pipe_ex1_src0_snan         (double_pipe_ex1_src0_snan        ),
  .double_pipe_ex1_src0_zero         (double_pipe_ex1_src0_zero        ),
  .double_pipe_ex1_src1_cnan         (double_pipe_ex1_src1_cnan        ),
  .double_pipe_ex1_src1_id           (double_pipe_ex1_src1_id          ),
  .double_pipe_ex1_src1_inf          (double_pipe_ex1_src1_inf         ),
  .double_pipe_ex1_src1_qnan         (double_pipe_ex1_src1_qnan        ),
  .double_pipe_ex1_src1_snan         (double_pipe_ex1_src1_snan        ),
  .double_pipe_ex1_src1_zero         (double_pipe_ex1_src1_zero        ),
  .double_pipe_ex2_cmp_r             (double_pipe_ex2_cmp_r            ),
  .double_pipe_ex2_special_result    (double_pipe_ex2_special_result   ),
  .double_pipe_ex3_expt              (double_pipe_ex3_expt             ),
  .ex1_bhalf                         (ex1_bhalf                        ),
  .ex1_bhalf0_adder_a_final          (ex1_bhalf0_adder_a_final         ),
  .ex1_bhalf0_special_data           (ex1_bhalf0_special_data          ),
  .ex1_double                        (ex1_double                       ),
  .ex1_double_adder_a_final          (ex1_double_adder_a_final         ),
  .ex1_double_special_data           (ex1_double_special_data          ),
  .ex1_f16                           (ex1_f16                          ),
  .ex1_half                          (ex1_half                         ),
  .ex1_half0_adder_a_final           (ex1_half0_adder_a_final          ),
  .ex1_half0_special_data            (ex1_half0_special_data           ),
  .ex1_op_add                        (ex1_op_add                       ),
  .ex1_op_add_sub                    (ex1_op_add_sub                   ),
  .ex1_op_cmp                        (ex1_op_cmp                       ),
  .ex1_op_sel                        (ex1_op_sel                       ),
  .ex1_op_sela                       (ex1_op_sela                      ),
  .ex1_op_sub                        (ex1_op_sub                       ),
  .ex1_rdn                           (ex1_rdn                          ),
  .ex1_single                        (ex1_single                       ),
  .ex1_single0_adder_a_final         (ex1_single0_adder_a_final        ),
  .ex1_single0_special_data          (ex1_single0_special_data         ),
  .ex2_bhalf                         (ex2_bhalf                        ),
  .ex2_bhalf0_rslt                   (ex2_bhalf0_rslt                  ),
  .ex2_double                        (ex2_double                       ),
  .ex2_double_adder_a                (ex2_double_adder_a               ),
  .ex2_double_rslt                   (ex2_double_rslt                  ),
  .ex2_half                          (ex2_half                         ),
  .ex2_half0_rslt                    (ex2_half0_rslt                   ),
  .ex2_op_add_sub                    (ex2_op_add_sub                   ),
  .ex2_op_cmp                        (ex2_op_cmp                       ),
  .ex2_op_feq                        (ex2_op_feq                       ),
  .ex2_op_fle                        (ex2_op_fle                       ),
  .ex2_op_flt                        (ex2_op_flt                       ),
  .ex2_op_fne                        (ex2_op_fne                       ),
  .ex2_op_faf                        (ex2_op_faf                       ),
  .ex2_op_fueq                       (ex2_op_fueq                      ),
  .ex2_op_fult                       (ex2_op_fult                      ),
  .ex2_op_fule                       (ex2_op_fule                      ),
  .ex2_op_fune                       (ex2_op_fune                      ),
  .ex2_op_fuord                      (ex2_op_fuord                     ),
  .ex2_op_ford                       (ex2_op_ford                      ),
  .ex2_signal                        (ex2_signal                       ),
  .ex2_op_max                        (ex2_op_max                       ),
  .ex2_op_min                        (ex2_op_min                       ),
  .ex2_op_sel                        (ex2_op_sel                       ),
  .ex2_op_sela                       (ex2_op_sela                      ),
  .ex2_op_sub                        (ex2_op_sub                       ),
  .ex2_rdn                           (ex2_rdn                          ),
  .ex2_rmm                           (ex2_rmm                          ),
  .ex2_rne                           (ex2_rne                          ),
  .ex2_rtz                           (ex2_rtz                          ),
  .ex2_rup                           (ex2_rup                          ),
  .ex2_single                        (ex2_single                       ),
  .ex2_single0_rslt                  (ex2_single0_rslt                 ),
  .ex3_bhalf                         (ex3_bhalf                        ),
  .ex3_bhalf0_result                 (ex3_bhalf0_result                ),
  .ex3_double                        (ex3_double                       ),
  .ex3_double_result                 (ex3_double_result                ),
  .ex3_half                          (ex3_half                         ),
  .ex3_half0_result                  (ex3_half0_result                 ),
  .ex3_op_cmp                        (ex3_op_cmp                       ),
  .ex3_op_sel                        (ex3_op_sel                       ),
  .ex3_rdn                           (ex3_rdn                          ),
  .ex3_rtz                           (ex3_rtz                          ),
  .ex3_rup                           (ex3_rup                          ),
  .ex3_single                        (ex3_single                       ),
  .ex3_single0_result                (ex3_single0_result               ),
  .fadd_double_src0                  (fadd_double_src0                 ),
  .fadd_double_src1                  (fadd_double_src1                 ),
  .fadd_ex1_pipe_clk                 (fadd_ex1_pipe_clk                ),
  .fadd_ex1_pipedown                 (fadd_ex1_pipedown                ),
  .fadd_ex2_nocmp                    (fadd_ex2_nocmp                   ),
  .fadd_ex2_pipe_clk                 (fadd_ex2_pipe_clk                ),
  .fadd_ex2_pipedown                 (fadd_ex2_pipedown                ),
  .fadd_ex3_bhalf0_rslt              (fadd_ex3_bhalf0_rslt             ),
  .fadd_ex3_double_rslt              (fadd_ex3_double_rslt             ),
  .fadd_ex3_half0_rslt               (fadd_ex3_half0_rslt              ),
  .fadd_ex3_pipedown                 (fadd_ex3_pipedown                ),
  .fadd_ex3_single0_rslt             (fadd_ex3_single0_rslt            ),
  .fadd_half0_src0                   (fadd_half0_src0                  ),
  .fadd_half0_src1                   (fadd_half0_src1                  ),
  .fadd_single0_src0                 (fadd_single0_src0                ),
  .fadd_single0_src1                 (fadd_single0_src1                ),
  .forever_cpuclk                    (forever_cpuclk                   ),
  .ifu_vpu_warm_up                   (ifu_vpu_warm_up                  ),
  .pad_yy_icg_scan_en                (pad_yy_icg_scan_en               ),
  .vfalu_vpu_ex2_gpr_result          (vfalu_vpu_ex2_gpr_result         ),
  .vfalu_vpu_ex2_result_ready_in_ex3 (vfalu_vpu_ex2_result_ready_in_ex3),
  .vfalu_vpu_ex3_fflags              (vfalu_vpu_ex3_fflags             ),
  .vfalu_vpu_ex3_fpr_result          (vfalu_vpu_ex3_fpr_result         ),
  .vfalu_vpu_ex3_result_ready_in_ex4 (vfalu_vpu_ex3_result_ready_in_ex4),
  .vfalu_vpu_ex4_fflags              (vfalu_vpu_ex4_fflags             ),
  .vfalu_vpu_ex4_fpr_result          (vfalu_vpu_ex4_fpr_result         ),
  .vpu_group_1_xx_ex1_func           (vpu_group_1_xx_ex1_func          ),
  .vpu_group_1_xx_ex1_rm             (vpu_group_1_xx_ex1_rm            ),
  .vpu_group_1_xx_ex1_srcv0          (vpu_group_1_xx_ex1_srcv0         ),
  .vpu_group_1_xx_ex1_srcv0_type     (vpu_group_1_xx_ex1_srcv0_type    ),
  .vpu_group_1_xx_ex1_srcv1          (vpu_group_1_xx_ex1_srcv1         ),
  .vpu_group_1_xx_ex1_srcv1_type     (vpu_group_1_xx_ex1_srcv1_type    ),
  .vpu_group_1_xx_ex2_rm             (vpu_group_1_xx_ex2_rm            )
);


// &Instance("aq_falu_ctrl"); @66
aq_falu_ctrl  x_aq_falu_ctrl (
  .cp0_vpu_icg_en               (cp0_vpu_icg_en              ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .fadd_ex1_pipe_clk            (fadd_ex1_pipe_clk           ),
  .fadd_ex1_pipedown            (fadd_ex1_pipedown           ),
  .fadd_ex2_nocmp               (fadd_ex2_nocmp              ),
  .fadd_ex2_nocmp_pipe_clk      (fadd_ex2_nocmp_pipe_clk     ),
  .fadd_ex2_nocmp_pipedown      (fadd_ex2_nocmp_pipedown     ),
  .fadd_ex2_pipe_clk            (fadd_ex2_pipe_clk           ),
  .fadd_ex2_pipedown            (fadd_ex2_pipedown           ),
  .fadd_ex3_pipedown            (fadd_ex3_pipedown           ),
  .forever_cpuclk               (forever_cpuclk              ),
  .ifu_vpu_warm_up              (ifu_vpu_warm_up             ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .vfalu_vpu_ex1_denormal_stall (vfalu_vpu_ex1_denormal_stall),
  .vpu_group_1_xx_ex1_eu_sel    (vpu_group_1_xx_ex1_eu_sel   ),
  .vpu_group_1_xx_ex1_sel       (vpu_group_1_xx_ex1_sel      ),
  .vpu_group_1_xx_ex2_eu_sel    (vpu_group_1_xx_ex2_eu_sel   ),
  .vpu_group_1_xx_ex2_sel       (vpu_group_1_xx_ex2_sel      ),
  .vpu_group_1_xx_ex2_stall     (vpu_group_1_xx_ex2_stall    ),
  .vpu_group_1_xx_ex3_eu_sel    (vpu_group_1_xx_ex3_eu_sel   ),
  .vpu_group_1_xx_ex3_sel       (vpu_group_1_xx_ex3_sel      ),
  .vpu_group_1_xx_ex3_stall     (vpu_group_1_xx_ex3_stall    ),
  .vpu_group_1_xx_ex4_stall     (vpu_group_1_xx_ex4_stall    )
);
endmodule


