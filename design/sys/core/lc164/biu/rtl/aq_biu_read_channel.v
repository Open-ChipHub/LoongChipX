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
module aq_biu_read_channel (
  // &Ports, @20
  input    wire  [39 :0]  araddr,
  input    wire  [1  :0]  arburst,
  input    wire  [3  :0]  arcache,
  input    wire  [3  :0]  arid,
  input    wire  [1  :0]  arlen,
  input    wire           arlock,
  input    wire  [2  :0]  arprot,
  input    wire  [2  :0]  arsize,
  input    wire           arvalid,
  input    wire           axim_clk_en,
  input    wire           biu_clk,
  input    wire           cp0_biu_icg_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire           pad_biu_arready,
  input    wire  [127:0]  pad_biu_rdata,
  input    wire  [7  :0]  pad_biu_rid,
  input    wire           pad_biu_rlast,
  input    wire  [1  :0]  pad_biu_rresp,
  input    wire           pad_biu_rvalid,
  input    wire           pad_yy_icg_scan_en,
  output   wire           arready,
  output   reg   [39 :0]  biu_pad_araddr,
  output   reg   [1  :0]  biu_pad_arburst,
  output   reg   [3  :0]  biu_pad_arcache,
  output   reg   [7  :0]  biu_pad_arid,
  output   reg   [7  :0]  biu_pad_arlen,
  output   reg            biu_pad_arlock,
  output   reg   [2  :0]  biu_pad_arprot,
  output   reg   [2  :0]  biu_pad_arsize,
  output   wire           biu_pad_arvalid,
  output   wire           biu_pad_rready,
  output   reg   [127:0]  rdata,
  output   wire           read_channel_clk_en,
  output   reg   [3  :0]  rid,
  output   reg            rlast,
  output   reg   [1  :0]  rresp,
  output   wire           rvalid
); 



// &Regs; @21
reg              arbuf_vld;          
reg              rbuf_vld;           

// &Wires; @22
wire             arbuf_create_en;    
wire             arbuf_pop_en;       
wire             arclk;              
wire             rbuf_create_en;     
wire             rbuf_pop_en;        
wire             rclk;               


parameter PADDR = 40;

//==============================================================================
//     AR channel
//==============================================================================
assign arready         = (!arbuf_vld | pad_biu_arready) & axim_clk_en;

assign arbuf_create_en = arvalid & (!arbuf_vld | pad_biu_arready);
assign arbuf_pop_en    = arbuf_vld & pad_biu_arready & axim_clk_en;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    arbuf_vld <= 1'b0;
  else if (axim_clk_en) begin
    if (arbuf_create_en)
      arbuf_vld <= 1'b1;
    else if (arbuf_pop_en)
      arbuf_vld <= 1'b0;
    else
      arbuf_vld <= arbuf_vld;
  end
end

assign biu_pad_arvalid = arbuf_vld;

always @(posedge arclk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    biu_pad_arid[7:0]         <= 8'b0;
    biu_pad_araddr[PADDR-1:0] <= {PADDR{1'b0}};
    biu_pad_arsize[2:0]       <= 3'b0;
    biu_pad_arlen[7:0]        <= 8'b0;
    biu_pad_arburst[1:0]      <= 2'b0;
    biu_pad_arcache[3:0]      <= 4'b0;
    biu_pad_arprot[2:0]       <= 3'b0;
    biu_pad_arlock            <= 1'b0;
  end
  else if (arbuf_create_en & axim_clk_en) begin
    biu_pad_arid[7:0]         <= {4'b0,arid[3:0]};
    biu_pad_araddr[PADDR-1:0] <= araddr[PADDR-1:0];
    biu_pad_arsize[2:0]       <= arsize[2:0];
    biu_pad_arlen[7:0]        <= {6'b0, arlen[1:0]};
    biu_pad_arburst[1:0]      <= arburst[1:0];
    biu_pad_arcache[3:0]      <= arcache[3:0];
    biu_pad_arprot[2:0]       <= arprot[2:0];
    biu_pad_arlock            <= arlock;
  end
end

//==============================================================================
//     R channel
//==============================================================================
// &Force("bus", "pad_biu_rid",7,0); @77
// &Force("output", "rlast"); @78
// &Force("output", "rresp"); @79
// &Force("output", "rid"); @80

assign biu_pad_rready = 1'b1;

assign rbuf_create_en = axim_clk_en & pad_biu_rvalid;
assign rbuf_pop_en    = rbuf_vld;

always @(posedge biu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rbuf_vld <= 1'b0;
  else if (rbuf_create_en)
    rbuf_vld <= 1'b1;
  else if (rbuf_pop_en)
    rbuf_vld <= 1'b0;
end

assign rvalid = rbuf_vld;

always @(posedge rclk or negedge cpurst_b)
begin
  if (!cpurst_b) begin
    rid[3:0]     <= 4'b0;
    rdata[127:0] <= 128'b0;
    rlast        <= 1'b0;
    rresp[1:0]   <= 2'b0;
  end
  else if (rbuf_create_en) begin
    rid[3:0]     <= pad_biu_rid[3:0];
    rdata[127:0] <= pad_biu_rdata[127:0];
    rlast        <= pad_biu_rlast;
    rresp[1:0]   <= pad_biu_rresp[1:0];
  end
end

assign read_channel_clk_en = rbuf_create_en | rbuf_pop_en |
                             arbuf_create_en | arbuf_pop_en;

// &Instance("gated_clk_cell", "x_aq_biu_ar_gated_clk"); @118
gated_clk_cell  x_aq_biu_ar_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (arclk             ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (arbuf_create_en   ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @119
//          .external_en (1'b0), @120
//          .global_en   (1'b1), @121
//          .module_en   (cp0_biu_icg_en), @122
//          .local_en    (arbuf_create_en), @123
//          .clk_out     (arclk)); @124

// &Instance("gated_clk_cell", "x_aq_biu_r_gated_clk"); @126
gated_clk_cell  x_aq_biu_r_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (rclk              ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (rbuf_create_en    ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @127
//          .external_en (1'b0), @128
//          .global_en   (1'b1), @129
//          .module_en   (cp0_biu_icg_en), @130
//          .local_en    (rbuf_create_en), @131
//          .clk_out     (rclk)); @132

// &ModuleEnd; @134
endmodule


