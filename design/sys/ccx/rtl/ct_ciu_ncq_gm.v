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
module ct_ciu_ncq_gm (
  // &Ports, @24
  input    wire          ciu_icg_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          gm_aw_req,
  input    wire          gm_ctrl_clk,
  input    wire          gm_set_vld_gate_x,
  input    wire          gm_set_vld_x,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [73:0]  raq_pop_bus,
  input    wire  [73:0]  waq_pop_bus,
  input    wire          waq_pop_en,
  output   wire          gm_success_x,
  output   wire          gm_vld_x
); 



// &Regs; @25
reg     [73:0]  gm_cont;           
reg             gm_exclusive;      

// &Wires; @26
wire            gm_clk;            
wire            gm_clr_vld;        


parameter ADDRW   = 40;
parameter LOCK    = 10;
parameter ADDR_0  = 34;
parameter ADDRH   = 73; //ADDRW -1 + ADDR_0;
parameter GMWIDTH = 74; //ADDRW + ADDR_0;

assign gm_clr_vld = gm_aw_req && waq_pop_en &&
                   (waq_pop_bus[ADDRH:ADDR_0] == gm_cont[ADDRH:ADDR_0]);

assign gm_success_x = gm_aw_req && waq_pop_bus[LOCK] &&
                      gm_exclusive &&
                     (gm_cont[GMWIDTH-1:0] == waq_pop_bus[GMWIDTH-1:0]);
                   

always @(posedge gm_ctrl_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    gm_exclusive <= 1'b0;
  else if (gm_clr_vld)
    gm_exclusive <= 1'b0;
  else if (gm_set_vld_x)
    gm_exclusive <= 1'b1;
end

assign gm_vld_x = gm_exclusive;

always @(posedge gm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    gm_cont[GMWIDTH-1:0] <= {GMWIDTH{1'b0}};
  else if (gm_set_vld_x)
    gm_cont[GMWIDTH-1:0] <= raq_pop_bus[GMWIDTH-1:0];
end

// &Instance("gated_clk_cell", "x_ncq_gm_gated_clk"); @62
gated_clk_cell  x_ncq_gm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (gm_clk            ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (gm_set_vld_gate_x ),
  .module_en          (ciu_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @63
//          .external_en (1'b0), @64
//          .global_en   (1'b1), @65
//          .module_en (ciu_icg_en       ), @66
//          .local_en    (gm_set_vld_gate_x), @67
//          .clk_out     (gm_clk)); @68

// &ModuleEnd; @70
endmodule


