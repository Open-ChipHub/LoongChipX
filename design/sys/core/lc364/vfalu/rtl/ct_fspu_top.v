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
module ct_fspu_top (
  // &Ports, @24
  input    wire          cp0_vfpu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [19:0]  dp_vfalu_ex1_pipex_func,
  input    wire  [63:0]  dp_vfalu_ex1_pipex_mtvr_src0,
  input    wire  [2 :0]  dp_vfalu_ex1_pipex_sel,
  input    wire  [63:0]  dp_vfalu_ex1_pipex_srcf0,
  input    wire  [63:0]  dp_vfalu_ex1_pipex_srcf1,
  input    wire  [63:0]  dp_vfalu_ex1_pipex_srcf2,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  output   wire          fspu_forward_r_vld,
  output   wire  [63:0]  fspu_forward_result,
  output   wire  [63:0]  fspu_mfvr_data
); 



// &Regs; @25
// &Wires; @26
wire            ex1_pipedown;                
wire            ex2_pipedown;                
wire            ex3_pipedown;                


// &Instance("ct_fspu_ctrl"); @28
ct_fspu_ctrl  x_ct_fspu_ctrl (
  .cp0_vfpu_icg_en        (cp0_vfpu_icg_en       ),
  .cp0_yy_clk_en          (cp0_yy_clk_en         ),
  .cpurst_b               (cpurst_b              ),
  .dp_vfalu_ex1_pipex_sel (dp_vfalu_ex1_pipex_sel),
  .ex1_pipedown           (ex1_pipedown          ),
  .ex2_pipedown           (ex2_pipedown          ),
  .ex3_pipedown           (ex3_pipedown          ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    )
);

// &Instance("ct_fspu_dp"); @29
ct_fspu_dp  x_ct_fspu_dp (
  .cp0_vfpu_icg_en              (cp0_vfpu_icg_en             ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .dp_vfalu_ex1_pipex_func      (dp_vfalu_ex1_pipex_func     ),
  .dp_vfalu_ex1_pipex_mtvr_src0 (dp_vfalu_ex1_pipex_mtvr_src0),
  .dp_vfalu_ex1_pipex_srcf0     (dp_vfalu_ex1_pipex_srcf0    ),
  .dp_vfalu_ex1_pipex_srcf1     (dp_vfalu_ex1_pipex_srcf1    ),
  .dp_vfalu_ex1_pipex_srcf2     (dp_vfalu_ex1_pipex_srcf2    ),
  .ex1_pipedown                 (ex1_pipedown                ),
  .ex2_pipedown                 (ex2_pipedown                ),
  .ex3_pipedown                 (ex3_pipedown                ),
  .forever_cpuclk               (forever_cpuclk              ),
  .fspu_forward_r_vld           (fspu_forward_r_vld          ),
  .fspu_forward_result          (fspu_forward_result         ),
  .fspu_mfvr_data               (fspu_mfvr_data              ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          )
);


// &ModuleEnd; @31
endmodule


