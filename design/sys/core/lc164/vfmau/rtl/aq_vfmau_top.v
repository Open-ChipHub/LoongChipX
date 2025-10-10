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
module aq_vfmau_top (
  // &Ports, @25
  input    wire          cp0_vpu_icg_en,
  input    wire          cp0_vpu_xx_bf16,
  input    wire          cp0_vpu_xx_dqnan,
  input    wire          cp0_yy_clk_en,
  input    wire          forever_cpuclk,
  input    wire          ifu_vpu_warm_up,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [9 :0]  vpu_group_0_xx_ex1_eu_sel,
  input    wire  [19:0]  vpu_group_0_xx_ex1_func,
  input    wire  [1 :0]  vpu_group_0_xx_ex1_id_reg,
  input    wire  [2 :0]  vpu_group_0_xx_ex1_rm,
  input    wire          vpu_group_0_xx_ex1_sel,
  input    wire  [63:0]  vpu_group_0_xx_ex1_srcv0,
  input    wire  [47:0]  vpu_group_0_xx_ex1_srcv0_type,
  input    wire  [63:0]  vpu_group_0_xx_ex1_srcv1,
  input    wire  [47:0]  vpu_group_0_xx_ex1_srcv1_type,
  input    wire  [63:0]  vpu_group_0_xx_ex1_srcv2,
  input    wire  [47:0]  vpu_group_0_xx_ex1_srcv2_type,
  input    wire  [9 :0]  vpu_group_0_xx_ex2_eu_sel,
  input    wire          vpu_group_0_xx_ex2_sel,
  input    wire          vpu_group_0_xx_ex2_stall,
  input    wire  [9 :0]  vpu_group_0_xx_ex3_eu_sel,
  input    wire          vpu_group_0_xx_ex3_sel,
  input    wire          vpu_group_0_xx_ex3_stall,
  input    wire  [9 :0]  vpu_group_0_xx_ex4_eu_sel,
  input    wire          vpu_group_0_xx_ex4_sel,
  input    wire          vpu_group_0_xx_ex4_stall,
  input    wire          vpu_group_0_xx_ex5_stall,
  output   wire          vfmau_vpu_ex2_result_ready_in_ex3,
  output   wire  [4 :0]  vfmau_vpu_ex3_fflags,
  output   wire  [63:0]  vfmau_vpu_ex3_fpr_result,
  output   wire          vfmau_vpu_ex3_result_ready_in_ex4,
  output   wire  [4 :0]  vfmau_vpu_ex4_fflags,
  output   wire  [63:0]  vfmau_vpu_ex4_fpr_result,
  output   wire  [4 :0]  vfmau_vpu_ex5_fflags,
  output   wire  [63:0]  vfmau_vpu_ex5_fpr_result
); 



// &Regs; @26
// &Wires; @27
wire            ctrl_dp_ex1_inst_pipe_down;       
wire            ctrl_dp_ex1_inst_vld;             
wire            ctrl_dp_ex2_inst_pipe_down;       
wire            ctrl_dp_ex2_inst_vld;             
wire            ctrl_dp_ex3_inst_pipe_down;       
wire            ctrl_dp_ex3_inst_vld;             
wire            ctrl_dp_ex4_inst_pipe_down;       
wire            ctrl_dp_ex4_inst_vld;             
wire            ex2_dst_double;                   
wire            ex2_mac;                          
wire            ex2_simd;                         
wire    [5 :0]  ex2_special_sel;                  
wire            ex3_dst_double;                   
wire            ex3_mac;                          
wire            ex3_special_cmplt;                
wire            ex4_dst_double;                   
wire            ex4_mac;                          


// &Depend("cpu_cfig.h"); @29

// &Instance("aq_vfmau_ctrl","x_aq_vfmau_ctrl"); @31
aq_vfmau_ctrl  x_aq_vfmau_ctrl (
  .ctrl_dp_ex1_inst_pipe_down        (ctrl_dp_ex1_inst_pipe_down       ),
  .ctrl_dp_ex1_inst_vld              (ctrl_dp_ex1_inst_vld             ),
  .ctrl_dp_ex2_inst_pipe_down        (ctrl_dp_ex2_inst_pipe_down       ),
  .ctrl_dp_ex2_inst_vld              (ctrl_dp_ex2_inst_vld             ),
  .ctrl_dp_ex3_inst_pipe_down        (ctrl_dp_ex3_inst_pipe_down       ),
  .ctrl_dp_ex3_inst_vld              (ctrl_dp_ex3_inst_vld             ),
  .ctrl_dp_ex4_inst_pipe_down        (ctrl_dp_ex4_inst_pipe_down       ),
  .ctrl_dp_ex4_inst_vld              (ctrl_dp_ex4_inst_vld             ),
  .ex2_dst_double                    (ex2_dst_double                   ),
  .ex2_mac                           (ex2_mac                          ),
  .ex2_simd                          (ex2_simd                         ),
  .ex2_special_sel                   (ex2_special_sel                  ),
  .ex3_dst_double                    (ex3_dst_double                   ),
  .ex3_mac                           (ex3_mac                          ),
  .ex3_special_cmplt                 (ex3_special_cmplt                ),
  .ex4_dst_double                    (ex4_dst_double                   ),
  .ex4_mac                           (ex4_mac                          ),
  .vfmau_vpu_ex2_result_ready_in_ex3 (vfmau_vpu_ex2_result_ready_in_ex3),
  .vfmau_vpu_ex3_result_ready_in_ex4 (vfmau_vpu_ex3_result_ready_in_ex4),
  .vpu_group_0_xx_ex1_eu_sel         (vpu_group_0_xx_ex1_eu_sel        ),
  .vpu_group_0_xx_ex1_sel            (vpu_group_0_xx_ex1_sel           ),
  .vpu_group_0_xx_ex2_eu_sel         (vpu_group_0_xx_ex2_eu_sel        ),
  .vpu_group_0_xx_ex2_sel            (vpu_group_0_xx_ex2_sel           ),
  .vpu_group_0_xx_ex2_stall          (vpu_group_0_xx_ex2_stall         ),
  .vpu_group_0_xx_ex3_eu_sel         (vpu_group_0_xx_ex3_eu_sel        ),
  .vpu_group_0_xx_ex3_sel            (vpu_group_0_xx_ex3_sel           ),
  .vpu_group_0_xx_ex3_stall          (vpu_group_0_xx_ex3_stall         ),
  .vpu_group_0_xx_ex4_eu_sel         (vpu_group_0_xx_ex4_eu_sel        ),
  .vpu_group_0_xx_ex4_sel            (vpu_group_0_xx_ex4_sel           ),
  .vpu_group_0_xx_ex4_stall          (vpu_group_0_xx_ex4_stall         ),
  .vpu_group_0_xx_ex5_stall          (vpu_group_0_xx_ex5_stall         )
);

// &Instance("aq_vfmau_dp","x_aq_vfmau_dp"); @32
aq_vfmau_dp  x_aq_vfmau_dp (
  .cp0_vpu_icg_en                (cp0_vpu_icg_en               ),
  .cp0_vpu_xx_bf16               (cp0_vpu_xx_bf16              ),
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .cp0_yy_clk_en                 (cp0_yy_clk_en                ),
  .ctrl_dp_ex1_inst_pipe_down    (ctrl_dp_ex1_inst_pipe_down   ),
  .ctrl_dp_ex1_inst_vld          (ctrl_dp_ex1_inst_vld         ),
  .ctrl_dp_ex2_inst_pipe_down    (ctrl_dp_ex2_inst_pipe_down   ),
  .ctrl_dp_ex2_inst_vld          (ctrl_dp_ex2_inst_vld         ),
  .ctrl_dp_ex3_inst_pipe_down    (ctrl_dp_ex3_inst_pipe_down   ),
  .ctrl_dp_ex3_inst_vld          (ctrl_dp_ex3_inst_vld         ),
  .ctrl_dp_ex4_inst_pipe_down    (ctrl_dp_ex4_inst_pipe_down   ),
  .ctrl_dp_ex4_inst_vld          (ctrl_dp_ex4_inst_vld         ),
  .ex2_dst_double                (ex2_dst_double               ),
  .ex2_mac                       (ex2_mac                      ),
  .ex2_simd                      (ex2_simd                     ),
  .ex2_special_sel               (ex2_special_sel              ),
  .ex3_dst_double                (ex3_dst_double               ),
  .ex3_mac                       (ex3_mac                      ),
  .ex3_special_cmplt             (ex3_special_cmplt            ),
  .ex4_dst_double                (ex4_dst_double               ),
  .ex4_mac                       (ex4_mac                      ),
  .forever_cpuclk                (forever_cpuclk               ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .pad_yy_icg_scan_en            (pad_yy_icg_scan_en           ),
  .vfmau_vpu_ex3_fflags          (vfmau_vpu_ex3_fflags         ),
  .vfmau_vpu_ex3_fpr_result      (vfmau_vpu_ex3_fpr_result     ),
  .vfmau_vpu_ex4_fflags          (vfmau_vpu_ex4_fflags         ),
  .vfmau_vpu_ex4_fpr_result      (vfmau_vpu_ex4_fpr_result     ),
  .vfmau_vpu_ex5_fflags          (vfmau_vpu_ex5_fflags         ),
  .vfmau_vpu_ex5_fpr_result      (vfmau_vpu_ex5_fpr_result     ),
  .vpu_group_0_xx_ex1_func       (vpu_group_0_xx_ex1_func      ),
  .vpu_group_0_xx_ex1_id_reg     (vpu_group_0_xx_ex1_id_reg    ),
  .vpu_group_0_xx_ex1_rm         (vpu_group_0_xx_ex1_rm        ),
  .vpu_group_0_xx_ex1_srcv0      (vpu_group_0_xx_ex1_srcv0     ),
  .vpu_group_0_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_0_xx_ex1_srcv1      (vpu_group_0_xx_ex1_srcv1     ),
  .vpu_group_0_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type),
  .vpu_group_0_xx_ex1_srcv2      (vpu_group_0_xx_ex1_srcv2     ),
  .vpu_group_0_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type)
);




// &ModuleEnd; @43
endmodule


