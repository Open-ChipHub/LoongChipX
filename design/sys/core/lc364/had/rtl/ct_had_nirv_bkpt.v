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

// &ModuleBeg; @23
module ct_had_nirv_bkpt (
  // &Ports, @24
  input    wire         cpuclk,
  input    wire         cpurst_b,
  input    wire         ctrl_bkpta_en,
  input    wire         ctrl_bkptb_en,
  input    wire         regs_xx_nirven,
  input    wire  [3:0]  rtu_had_inst0_non_irv_bkpt,
  input    wire  [3:0]  rtu_had_inst1_non_irv_bkpt,
  input    wire  [3:0]  rtu_had_inst2_non_irv_bkpt,
  input    wire         rtu_had_xx_split_inst,
  input    wire         rtu_yy_xx_dbgon,
  input    wire         rtu_yy_xx_flush,
  input    wire         rtu_yy_xx_retire0_normal,
  input    wire         rtu_yy_xx_retire1,
  input    wire         rtu_yy_xx_retire2,
  output   reg          nirv_bkpta,
  output   reg          non_irv_bkpt_vld
); 



// &Regs; @25
reg            nirv_bkpt_pending;         
reg            nirv_bkpta_pending;        

// &Wires; @26
wire    [3:0]  inst0_non_irv_bkpt;        
wire    [3:0]  inst1_non_irv_bkpt;        
wire    [3:0]  inst2_non_irv_bkpt;        
wire           kbpt_occur;                
wire           nirv_bkpt_occur_raw;       
wire           nirv_bkpta_occur;          
wire           nirv_bkpta_sel;            
wire           nirv_bkptb_occur;          


assign inst0_non_irv_bkpt[3:0] = rtu_had_inst0_non_irv_bkpt[3:0] & {4{rtu_yy_xx_retire0_normal}};
assign inst1_non_irv_bkpt[3:0] = rtu_had_inst1_non_irv_bkpt[3:0] & {4{rtu_yy_xx_retire1}};
assign inst2_non_irv_bkpt[3:0] = rtu_had_inst2_non_irv_bkpt[3:0] & {4{rtu_yy_xx_retire2}};

assign nirv_bkpta_occur = inst0_non_irv_bkpt[1] || inst0_non_irv_bkpt[2] ||
                          inst1_non_irv_bkpt[1] || inst1_non_irv_bkpt[2] ||
                          inst2_non_irv_bkpt[1] || inst2_non_irv_bkpt[2];

assign nirv_bkptb_occur = inst0_non_irv_bkpt[0] || inst0_non_irv_bkpt[3] ||
                          inst1_non_irv_bkpt[0] || inst1_non_irv_bkpt[3] ||
                          inst2_non_irv_bkpt[0] || inst2_non_irv_bkpt[3];

assign kbpt_occur = regs_xx_nirven && 
                    (nirv_bkpta_occur && ctrl_bkpta_en || nirv_bkptb_occur && ctrl_bkptb_en) ;

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nirv_bkpt_pending <= 1'b0;
  else if (rtu_yy_xx_flush)
    nirv_bkpt_pending <= 1'b0;
  else if (kbpt_occur && rtu_had_xx_split_inst)
    nirv_bkpt_pending <= 1'b1;
  else if (rtu_yy_xx_dbgon)
    nirv_bkpt_pending <= 1'b0;
end

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nirv_bkpta_pending <= 1'b0;
  else if (kbpt_occur && rtu_had_xx_split_inst && !nirv_bkpt_pending)
    nirv_bkpta_pending <= nirv_bkpta_occur;
  else if (rtu_yy_xx_dbgon)
    nirv_bkpta_pending <= 1'b0;
end

assign nirv_bkpt_occur_raw = kbpt_occur && !rtu_had_xx_split_inst ||
                             nirv_bkpt_pending && !rtu_had_xx_split_inst && rtu_yy_xx_retire0_normal;

// &Force("output","non_irv_bkpt_vld"); @68
always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    non_irv_bkpt_vld <= 1'b0;
  else if (rtu_yy_xx_flush)
    non_irv_bkpt_vld <= 1'b0;
  else if (nirv_bkpt_occur_raw)
    non_irv_bkpt_vld <= 1'b1;
  else if (rtu_yy_xx_dbgon)
    non_irv_bkpt_vld <= 1'b0;
end

assign nirv_bkpta_sel = nirv_bkpt_pending ? nirv_bkpta_pending : nirv_bkpta_occur;

always @(posedge cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nirv_bkpta <= 1'b0;
  else if (nirv_bkpt_occur_raw && !non_irv_bkpt_vld)
    nirv_bkpta <= nirv_bkpta_sel;
  else if (rtu_yy_xx_dbgon)
    nirv_bkpta <= 1'b0;
end

// &ModuleEnd; @93
endmodule


