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

// &ModuleBeg; @24
module ct_had_sync_3flop (
  // &Ports, @25
  input    wire       clk1,
  input    wire       clk2,
  input    wire       rst1_b,
  input    wire       rst2_b,
  input    wire       sync_in,
  output   wire       sync_out
); 



// &Regs; @26
reg          sync_ff1_clk1; 
reg          sync_ff2_clk1; 
reg          sync_ff3_clk1; 
reg          sync_ff4_clk1; 
reg          sync_ff_clk2; 

// &Wires; @27


//==============================================================================
// sync logic from clk2 to clk1
// step 1. flop once in clk2 domain
// step 2. flop twice in clk1 domain
// result: a pulse signal in clk1 domain
// constraint: slow clock --> fast clock
//==============================================================================

always @(posedge clk2 or negedge rst2_b)
begin
  if (!rst2_b)
    sync_ff_clk2 <= 1'b0;
  else
    sync_ff_clk2 <= sync_in;
end

always @(posedge clk1 or negedge rst1_b)
begin
  if (!rst1_b) begin
    sync_ff1_clk1 <= 1'b0;
    sync_ff2_clk1 <= 1'b0;
    sync_ff3_clk1 <= 1'b0;
  end
  else begin
    sync_ff1_clk1 <= sync_ff_clk2;
    sync_ff2_clk1 <= sync_ff1_clk1;
    sync_ff3_clk1 <= sync_ff2_clk1;
  end   
end

// generates a pulse signal in clk1 domain
always @(posedge clk1 or negedge rst1_b)
begin
  if (!rst1_b)
    sync_ff4_clk1 <= 1'b0;
  else
    sync_ff4_clk1 <= sync_ff3_clk1;
end

assign sync_out = !sync_ff4_clk1 && sync_ff3_clk1;

// &ModuleEnd; @70
endmodule



