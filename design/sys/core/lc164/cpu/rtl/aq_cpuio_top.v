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

// &Depend("cpu_cfig.h"); @17

// &ModuleBeg; @19
module aq_cpuio_top (
  // &Ports, @20
  input    wire  [63:0]  clint_cpuio_time,
  input    wire  [1 :0]  cp0_biu_lpmd_b,
  input    wire  [2 :0]  pad_biu_coreid,
  input    wire          sysio_cpuio_me_int,
  input    wire          sysio_cpuio_ms_int,
  input    wire          sysio_cpuio_mt_int,
  input    wire          sysio_cpuio_se_int,
  input    wire          sysio_cpuio_ss_int,
  input    wire          sysio_cpuio_st_int,
  input    wire  [63:0]  sysio_xx_rvba,
  output   wire  [2 :0]  biu_cp0_coreid,
  output   wire          biu_cp0_me_int,
  output   wire          biu_cp0_ms_int,
  output   wire          biu_cp0_mt_int,
  output   wire  [63:0]  biu_cp0_rvba,
  output   wire          biu_cp0_se_int,
  output   wire          biu_cp0_ss_int,
  output   wire          biu_cp0_st_int,
  output   wire  [63:0]  biu_hpcp_time,
  output   wire  [1 :0]  cpuio_sysio_lpmd_b
); 



// &Regs; @21
// &Wires; @22


assign biu_cp0_coreid[2:0] = pad_biu_coreid[2:0];
assign biu_cp0_me_int      = sysio_cpuio_me_int;
assign biu_cp0_ms_int      = sysio_cpuio_ms_int;  
assign biu_cp0_mt_int      = sysio_cpuio_mt_int;
assign biu_cp0_se_int      = sysio_cpuio_se_int;
assign biu_cp0_ss_int      = sysio_cpuio_ss_int;
assign biu_cp0_st_int      = sysio_cpuio_st_int;
assign biu_hpcp_time[63:0] = clint_cpuio_time[63:0];
assign biu_cp0_rvba[63:0]  = sysio_xx_rvba[63:0];
assign cpuio_sysio_lpmd_b[1:0] = cp0_biu_lpmd_b[1:0];
// &ModuleEnd; @37
endmodule


