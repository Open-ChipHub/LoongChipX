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

// &ModuleBeg; @24
module aq_vfmau_mult (
  // &Ports, @25
  input    wire           cp0_vpu_xx_dqnan,
  input    wire           ctrl_dp_ex1_inst_pipe_down,
  input    wire           ctrl_dp_ex2_inst_pipe_down,
  input    wire           ctrl_dp_ex3_inst_pipe_down,
  input    wire           ctrl_dp_ex4_inst_pipe_down,
  input    wire           ex1_bf16,
  input    wire           ex1_double,
  input    wire           ex1_dst_bf16,
  input    wire           ex1_dst_double,
  input    wire           ex1_dst_f16,
  input    wire           ex1_dst_half,
  input    wire           ex1_dst_single,
  input    wire           ex1_f16,
  input    wire           ex1_half,
  input    wire  [1  :0]  ex1_id_reg,
  input    wire           ex1_mac,
  input    wire           ex1_neg,
  input    wire  [2  :0]  ex1_rm,
  input    wire           ex1_single,
  input    wire  [63 :0]  ex1_srcv0,
  input    wire  [63 :0]  ex1_srcv1,
  input    wire  [63 :0]  ex1_srcv2,
  input    wire           ex1_sub,
  input    wire           ex1_widen,
  input    wire           ex2_bf16,
  input    wire           ex2_double,
  input    wire           ex2_dst_bf16,
  input    wire           ex2_dst_double,
  input    wire           ex2_dst_f16,
  input    wire           ex2_dst_half,
  input    wire           ex2_dst_single,
  input    wire           ex2_mac,
  input    wire           ex2_single,
  input    wire           ex3_bf16,
  input    wire           ex3_dst_bf16,
  input    wire           ex3_dst_double,
  input    wire           ex3_dst_f16,
  input    wire           ex3_dst_single,
  input    wire           ex3_f16,
  input    wire  [2  :0]  ex3_rm,
  input    wire           ex3_simd,
  input    wire           ex3_single,
  input    wire           ex4_bf16,
  input    wire           ex4_dst_bf16,
  input    wire           ex4_dst_double,
  input    wire           ex4_dst_f16,
  input    wire           ex4_dst_half,
  input    wire           ex4_dst_single,
  input    wire           ex4_f16,
  input    wire  [2  :0]  ex4_rm,
  input    wire           ex4_single,
  input    wire           fmau_ex2_data_clk,
  input    wire           fmau_ex3_data_clk,
  input    wire           fmau_ex4_data_clk,
  input    wire           fmau_ex5_data_clk,
  input    wire           ifu_vpu_warm_up,
  input    wire  [47 :0]  vpu_group_0_xx_ex1_srcv0_type,
  input    wire  [47 :0]  vpu_group_0_xx_ex1_srcv1_type,
  input    wire  [47 :0]  vpu_group_0_xx_ex1_srcv2_type,
  output   wire           ex1_double_expnt_near_of,
  output   wire           ex1_double_expnt_near_uf,
  output   wire  [5  :0]  ex2_special_sel,
  output   wire           ex3_special_cmplt,
  output   wire  [4  :0]  vfmau_vpu_ex3_fflags,
  output   wire  [63 :0]  vfmau_vpu_ex3_fpr_result,
  output   wire  [4  :0]  vfmau_vpu_ex4_fflags,
  output   wire  [63 :0]  vfmau_vpu_ex4_fpr_result,
  output   wire  [4  :0]  vfmau_vpu_ex5_fflags,
  output   wire  [63 :0]  vfmau_vpu_ex5_fpr_result
); 



// &Regs; @26
// &Wires; @27
wire    [105:0]  ex2_mult_data;                



// &Instance("aq_vfmau_frac_mult","x_aq_vfmau_frac_mult"); @30
aq_vfmau_frac_mult  x_aq_vfmau_frac_mult (
  .ctrl_dp_ex1_inst_pipe_down (ctrl_dp_ex1_inst_pipe_down),
  .ex1_bf16                   (ex1_bf16                  ),
  .ex1_double                 (ex1_double                ),
  .ex1_f16                    (ex1_f16                   ),
  .ex1_id_reg                 (ex1_id_reg                ),
  .ex1_single                 (ex1_single                ),
  .ex1_srcv0                  (ex1_srcv0                 ),
  .ex1_srcv1                  (ex1_srcv1                 ),
  .ex2_mult_data              (ex2_mult_data             ),
  .fmau_ex2_data_clk          (fmau_ex2_data_clk         ),
  .ifu_vpu_warm_up            (ifu_vpu_warm_up           )
);

// &Instance("aq_vfmau_mult_double","x_aq_vfmau_mult_double"); @31
aq_vfmau_mult_double  x_aq_vfmau_mult_double (
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .ctrl_dp_ex1_inst_pipe_down    (ctrl_dp_ex1_inst_pipe_down   ),
  .ctrl_dp_ex2_inst_pipe_down    (ctrl_dp_ex2_inst_pipe_down   ),
  .ctrl_dp_ex3_inst_pipe_down    (ctrl_dp_ex3_inst_pipe_down   ),
  .ctrl_dp_ex4_inst_pipe_down    (ctrl_dp_ex4_inst_pipe_down   ),
  .ex1_bf16                      (ex1_bf16                     ),
  .ex1_double                    (ex1_double                   ),
  .ex1_double_expnt_near_of      (ex1_double_expnt_near_of     ),
  .ex1_double_expnt_near_uf      (ex1_double_expnt_near_uf     ),
  .ex1_dst_bf16                  (ex1_dst_bf16                 ),
  .ex1_dst_double                (ex1_dst_double               ),
  .ex1_dst_f16                   (ex1_dst_f16                  ),
  .ex1_dst_half                  (ex1_dst_half                 ),
  .ex1_dst_single                (ex1_dst_single               ),
  .ex1_f16                       (ex1_f16                      ),
  .ex1_half                      (ex1_half                     ),
  .ex1_id_reg                    (ex1_id_reg                   ),
  .ex1_mac                       (ex1_mac                      ),
  .ex1_neg                       (ex1_neg                      ),
  .ex1_rm                        (ex1_rm                       ),
  .ex1_single                    (ex1_single                   ),
  .ex1_srcv0                     (ex1_srcv0                    ),
  .ex1_srcv1                     (ex1_srcv1                    ),
  .ex1_srcv2                     (ex1_srcv2                    ),
  .ex1_sub                       (ex1_sub                      ),
  .ex1_widen                     (ex1_widen                    ),
  .ex2_bf16                      (ex2_bf16                     ),
  .ex2_double                    (ex2_double                   ),
  .ex2_dst_bf16                  (ex2_dst_bf16                 ),
  .ex2_dst_double                (ex2_dst_double               ),
  .ex2_dst_f16                   (ex2_dst_f16                  ),
  .ex2_dst_half                  (ex2_dst_half                 ),
  .ex2_dst_single                (ex2_dst_single               ),
  .ex2_mac                       (ex2_mac                      ),
  .ex2_mult_data                 (ex2_mult_data                ),
  .ex2_single                    (ex2_single                   ),
  .ex2_special_sel               (ex2_special_sel              ),
  .ex3_bf16                      (ex3_bf16                     ),
  .ex3_dst_bf16                  (ex3_dst_bf16                 ),
  .ex3_dst_double                (ex3_dst_double               ),
  .ex3_dst_f16                   (ex3_dst_f16                  ),
  .ex3_dst_single                (ex3_dst_single               ),
  .ex3_f16                       (ex3_f16                      ),
  .ex3_rm                        (ex3_rm                       ),
  .ex3_simd                      (ex3_simd                     ),
  .ex3_single                    (ex3_single                   ),
  .ex3_special_cmplt             (ex3_special_cmplt            ),
  .ex4_bf16                      (ex4_bf16                     ),
  .ex4_dst_bf16                  (ex4_dst_bf16                 ),
  .ex4_dst_double                (ex4_dst_double               ),
  .ex4_dst_f16                   (ex4_dst_f16                  ),
  .ex4_dst_half                  (ex4_dst_half                 ),
  .ex4_dst_single                (ex4_dst_single               ),
  .ex4_f16                       (ex4_f16                      ),
  .ex4_rm                        (ex4_rm                       ),
  .ex4_single                    (ex4_single                   ),
  .fmau_ex2_data_clk             (fmau_ex2_data_clk            ),
  .fmau_ex3_data_clk             (fmau_ex3_data_clk            ),
  .fmau_ex4_data_clk             (fmau_ex4_data_clk            ),
  .fmau_ex5_data_clk             (fmau_ex5_data_clk            ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .vfmau_vpu_ex3_fflags          (vfmau_vpu_ex3_fflags         ),
  .vfmau_vpu_ex3_fpr_result      (vfmau_vpu_ex3_fpr_result     ),
  .vfmau_vpu_ex4_fflags          (vfmau_vpu_ex4_fflags         ),
  .vfmau_vpu_ex4_fpr_result      (vfmau_vpu_ex4_fpr_result     ),
  .vfmau_vpu_ex5_fflags          (vfmau_vpu_ex5_fflags         ),
  .vfmau_vpu_ex5_fpr_result      (vfmau_vpu_ex5_fpr_result     ),
  .vpu_group_0_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_0_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type),
  .vpu_group_0_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type)
);

endmodule


