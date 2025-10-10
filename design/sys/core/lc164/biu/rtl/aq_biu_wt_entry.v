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
module aq_biu_wt_entry (
  // &Ports, @20
  input    wire  [39:0]  araddr,
  input    wire  [3 :0]  arcache,
  input    wire  [39:0]  awaddr,
  input    wire  [3 :0]  awcache,
  input    wire  [1 :0]  awlen,
  input    wire          cp0_biu_icg_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [9 :0]  wtable_create_addr,
  input    wire          wtable_create_burst,
  input    wire          wtable_create_en_x,
  input    wire          wtable_create_so,
  input    wire          wtable_pop_en_x,
  output   wire          ar_hit_wtable_addr_x,
  output   wire          ar_hit_wtable_so_x,
  output   wire          aw_hit_wtable_addr_x,
  output   wire          aw_hit_wtable_so_x,
  output   wire          wtable_entry_vld_x
); 



// &Regs; @21
reg     [9 :0]  wtable_addr;         
reg             wtable_burst;        
reg             wtable_so;           
reg             wtable_vld;          

// &Wires; @22
wire            burst_sel;           
wire            wtable_clk;          
wire            wtable_clk_en;       


parameter PADDR = 40;

always @(posedge wtable_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wtable_vld <= 1'b0;
  else if (wtable_create_en_x)
    wtable_vld <= 1'b1;
  else if (wtable_pop_en_x)
    wtable_vld <= 1'b0;
end

always @(posedge wtable_clk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    wtable_addr[9:0] <= 10'b0;
    wtable_so        <= 1'b0;
    wtable_burst     <= 1'b0;
  end
  else if (wtable_create_en_x) begin
    wtable_addr[9:0] <= wtable_create_addr[9:0];
    wtable_so        <= wtable_create_so;
    wtable_burst     <= wtable_create_burst;
  end
end

assign burst_sel            = wtable_burst | (awlen[1:0] == 2'b11);

assign wtable_entry_vld_x   = wtable_vld;
assign ar_hit_wtable_addr_x = araddr[13:6] == wtable_addr[9:2] & wtable_vld;
assign aw_hit_wtable_addr_x = (burst_sel & (awaddr[13:6] == wtable_addr[9:2]) |
                              !burst_sel & (awaddr[13:4] == wtable_addr[9:0])) & wtable_vld;
assign ar_hit_wtable_so_x   = !arcache[1] & wtable_so & wtable_vld;
assign aw_hit_wtable_so_x   = !awcache[1] & wtable_so & wtable_vld;

// &Force("bus", "araddr", PADDR-1,0); @59
// &Force("bus", "awaddr", PADDR-1,0); @60
// &Force("bus", "arcache",3,0); @61
// &Force("bus", "awcache",3,0); @62

assign wtable_clk_en = wtable_create_en_x | wtable_pop_en_x;
// &Instance("gated_clk_cell", "x_aq_biu_wtable_gated_clk"); @65
gated_clk_cell  x_aq_biu_wtable_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (wtable_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (wtable_clk_en     ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @66
//          .external_en (1'b0), @67
//          .global_en   (1'b1), @68
//          .module_en   (cp0_biu_icg_en), @69
//          .local_en    (wtable_clk_en), @70
//          .clk_out     (wtable_clk)); @71
// &ModuleEnd; @72
endmodule


