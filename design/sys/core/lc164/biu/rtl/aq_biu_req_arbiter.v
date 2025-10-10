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
module aq_biu_req_arbiter (
  // &Ports, @20
  input    wire           apbif_arready,
  input    wire           apbif_awready,
  input    wire           apbif_idle,
  input    wire  [127:0]  apbif_rdata,
  input    wire  [3  :0]  apbif_rid,
  input    wire  [1  :0]  apbif_rresp,
  input    wire           apbif_rvalid,
  input    wire           apbif_wready,
  input    wire           ar_hit_wtable,
  input    wire           arready,
  input    wire           aw_hit_wtable,
  input    wire           awready,
  input    wire           cp0_biu_icg_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [39 :0]  ifu_biu_araddr,
  input    wire  [1  :0]  ifu_biu_arburst,
  input    wire  [3  :0]  ifu_biu_arcache,
  input    wire           ifu_biu_arid,
  input    wire  [1  :0]  ifu_biu_arlen,
  input    wire  [2  :0]  ifu_biu_arprot,
  input    wire  [2  :0]  ifu_biu_arsize,
  input    wire           ifu_biu_arvalid,
  input    wire  [39 :0]  lsu_biu_araddr,
  input    wire  [1  :0]  lsu_biu_arburst,
  input    wire  [3  :0]  lsu_biu_arcache,
  input    wire  [3  :0]  lsu_biu_arid,
  input    wire  [1  :0]  lsu_biu_arlen,
  input    wire  [2  :0]  lsu_biu_arprot,
  input    wire  [2  :0]  lsu_biu_arsize,
  input    wire           lsu_biu_aruser,
  input    wire           lsu_biu_arvalid,
  input    wire  [39 :0]  lsu_biu_stb_awaddr,
  input    wire  [1  :0]  lsu_biu_stb_awburst,
  input    wire  [3  :0]  lsu_biu_stb_awcache,
  input    wire  [1  :0]  lsu_biu_stb_awid,
  input    wire  [1  :0]  lsu_biu_stb_awlen,
  input    wire  [2  :0]  lsu_biu_stb_awprot,
  input    wire  [2  :0]  lsu_biu_stb_awsize,
  input    wire           lsu_biu_stb_awuser,
  input    wire           lsu_biu_stb_awvalid,
  input    wire  [127:0]  lsu_biu_stb_wdata,
  input    wire           lsu_biu_stb_wlast,
  input    wire  [15 :0]  lsu_biu_stb_wstrb,
  input    wire           lsu_biu_stb_wvalid,
  input    wire  [39 :0]  lsu_biu_vb_awaddr,
  input    wire  [1  :0]  lsu_biu_vb_awburst,
  input    wire  [3  :0]  lsu_biu_vb_awcache,
  input    wire  [3  :0]  lsu_biu_vb_awid,
  input    wire  [1  :0]  lsu_biu_vb_awlen,
  input    wire  [2  :0]  lsu_biu_vb_awprot,
  input    wire  [2  :0]  lsu_biu_vb_awsize,
  input    wire           lsu_biu_vb_awvalid,
  input    wire  [127:0]  lsu_biu_vb_wdata,
  input    wire           lsu_biu_vb_wlast,
  input    wire  [15 :0]  lsu_biu_vb_wstrb,
  input    wire           lsu_biu_vb_wvalid,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [127:0]  rdata,
  input    wire  [3  :0]  rid,
  input    wire           rlast,
  input    wire  [1  :0]  rresp,
  input    wire           rvalid,
  input    wire  [39 :0]  sysio_biu_apb_base,
  input    wire           wready,
  input    wire           wtable_no_op,
  output   wire  [39 :0]  apbif_araddr,
  output   wire  [3  :0]  apbif_arid,
  output   wire  [1  :0]  apbif_arprot,
  output   wire           apbif_arvalid,
  output   wire  [39 :0]  apbif_awaddr,
  output   wire  [3  :0]  apbif_awid,
  output   wire  [1  :0]  apbif_awprot,
  output   wire           apbif_awvalid,
  output   wire           apbif_rready,
  output   wire  [127:0]  apbif_wdata,
  output   wire           apbif_wvalid,
  output   wire  [39 :0]  araddr,
  output   wire  [1  :0]  arburst,
  output   wire  [3  :0]  arcache,
  output   wire  [3  :0]  arid,
  output   wire  [1  :0]  arlen,
  output   wire           arlock,
  output   wire  [2  :0]  arprot,
  output   wire  [2  :0]  arsize,
  output   wire           arvalid,
  output   wire  [39 :0]  awaddr,
  output   wire  [1  :0]  awburst,
  output   wire  [3  :0]  awcache,
  output   wire  [1  :0]  awlen,
  output   wire           awlock,
  output   wire  [2  :0]  awprot,
  output   wire  [2  :0]  awsize,
  output   wire           awvalid,
  output   wire           biu_ifu_arready,
  output   wire  [127:0]  biu_ifu_rdata,
  output   wire           biu_ifu_rid,
  output   wire           biu_ifu_rlast,
  output   wire  [1  :0]  biu_ifu_rresp,
  output   wire           biu_ifu_rvalid,
  output   wire           biu_lsu_arready,
  output   wire           biu_lsu_no_op,
  output   wire  [127:0]  biu_lsu_rdata,
  output   wire  [3  :0]  biu_lsu_rid,
  output   wire           biu_lsu_rlast,
  output   wire  [1  :0]  biu_lsu_rresp,
  output   wire           biu_lsu_rvalid,
  output   wire           biu_lsu_stb_awready,
  output   wire           biu_lsu_stb_wready,
  output   wire           biu_lsu_vb_awready,
  output   wire           biu_lsu_vb_wready,
  output   wire  [127:0]  wdata,
  output   wire           wlast,
  output   wire  [15 :0]  wstrb,
  output   wire           wvalid
); 



// &Regs; @21
reg     [7  :0]  apbif_sel;           
reg     [7  :0]  wsel_fifo;           
reg     [3  :0]  wsel_fifo_create_ptr; 
reg     [3  :0]  wsel_fifo_pop_ptr;   

// &Wires; @22
wire             apb_ar_hit;          
wire             apb_aw_hit;          
wire    [39 :0]  arb_araddr;          
wire    [1  :0]  arb_arburst;         
wire    [3  :0]  arb_arcache;         
wire    [3  :0]  arb_arid;            
wire    [1  :0]  arb_arlen;           
wire    [2  :0]  arb_arprot;          
wire             arb_arready;         
wire    [2  :0]  arb_arsize;          
wire             arb_aruser;          
wire             arb_arvalid;         
wire    [39 :0]  arb_awaddr;          
wire    [1  :0]  arb_awburst;         
wire    [3  :0]  arb_awcache;         
wire    [3  :0]  arb_awid;            
wire    [1  :0]  arb_awlen;           
wire    [2  :0]  arb_awprot;          
wire    [2  :0]  arb_awsize;          
wire             arb_awuser;          
wire             arb_awvalid;         
wire             arb_clk;             
wire             arb_clk_en;          
wire    [127:0]  arb_wdata;           
wire             arb_wlast;           
wire    [15 :0]  arb_wstrb;           
wire             arb_wvalid;          
wire             awready_final;       
wire             axi_arready;         
wire             axi_awready;         
wire             axi_lsu_rvalid;      
wire             lsu_sel;             
wire             r_ifu_sel;           
wire             vb_sel;              
wire             wready_final;        
wire             wsel_apbif;          
wire             wsel_full;           
wire             wsel_vb;             


parameter PADDR = 40;

assign biu_lsu_no_op = wtable_no_op & apbif_idle;

//================================================
//   read address channel
//================================================ 
assign lsu_sel               = lsu_biu_arvalid;
assign arb_arvalid           = lsu_sel ? lsu_biu_arvalid           : ifu_biu_arvalid;
assign arb_arid[3:0]         = lsu_sel ? lsu_biu_arid[3:0]         : {3'b0,ifu_biu_arid};
assign arb_araddr[PADDR-1:0] = lsu_sel ? lsu_biu_araddr[PADDR-1:0] : ifu_biu_araddr[PADDR-1:0];
assign arb_arsize[2:0]       = lsu_sel ? lsu_biu_arsize[2:0]       : ifu_biu_arsize[2:0];
assign arb_arlen[1:0]        = lsu_sel ? lsu_biu_arlen[1:0]        : ifu_biu_arlen[1:0];
assign arb_arburst[1:0]      = lsu_sel ? lsu_biu_arburst[1:0]      : ifu_biu_arburst[1:0];
assign arb_arcache[3:0]      = lsu_sel ? lsu_biu_arcache[3:0]      : ifu_biu_arcache[3:0];
assign arb_arprot[2:0]       = lsu_sel ? lsu_biu_arprot[2:0]       : ifu_biu_arprot[2:0];
assign arb_aruser            = lsu_sel & lsu_biu_aruser;

//================================================
//  APB AR decode
//================================================
// &Force("bus", "sysio_biu_apb_base",PADDR-1,0); @45
assign apb_ar_hit = arb_araddr[PADDR-1:27] == sysio_biu_apb_base[PADDR-1:27];

assign apbif_arvalid           = arb_arvalid & apb_ar_hit;
assign apbif_araddr[PADDR-1:0] = arb_araddr[PADDR-1:0];
assign apbif_arprot[1:0]       = {arb_aruser,arb_arprot[0]};
assign apbif_arid[3:0]         =  arb_arid[3:0];

assign arvalid                 = arb_arvalid & !apb_ar_hit & !ar_hit_wtable;
assign arid[3:0]               = arb_arid[3:0];         
assign araddr[PADDR-1:0]       = arb_araddr[PADDR-1:0];
assign arsize[2:0]             = arb_arsize[2:0];       
assign arlen[1:0]              = arb_arlen[1:0];        
assign arburst[1:0]            = arb_arburst[1:0];      
assign arcache[3:0]            = arb_arcache[3:0];      
assign arprot[2:0]             = arb_arprot[2:0];       
assign arlock                  = 1'b0;

assign axi_arready             = arready & !ar_hit_wtable;
assign arb_arready             = apb_ar_hit ? apbif_arready : axi_arready;
assign biu_lsu_arready         = arb_arready;
assign biu_ifu_arready         = arb_arready & !lsu_sel;

//================================================
//   read data channel
//================================================ 
assign r_ifu_sel            = rid[3:1] == 3'b000;
assign biu_ifu_rvalid       = rvalid & r_ifu_sel;
assign biu_ifu_rdata[127:0] = rdata[127:0];
assign biu_ifu_rid          = rid[0];
assign biu_ifu_rresp[1:0]   = rresp[1:0];
assign biu_ifu_rlast        = rlast;

assign axi_lsu_rvalid       = rvalid & !r_ifu_sel;
assign biu_lsu_rvalid       = axi_lsu_rvalid | apbif_rvalid;
assign biu_lsu_rdata[127:0] = axi_lsu_rvalid ? rdata[127:0] : apbif_rdata[127:0];
assign biu_lsu_rid[3:0]     = axi_lsu_rvalid ? rid[3:0]     : apbif_rid[3:0];
assign biu_lsu_rlast        = axi_lsu_rvalid ? rlast        : 1'b1;
assign biu_lsu_rresp[1:0]   = axi_lsu_rvalid ? rresp[1:0]   : apbif_rresp[1:0];

assign apbif_rready         = !axi_lsu_rvalid;

//================================================
//  write address channel
//================================================
// &Force("output","awaddr"); @90
// &Force("output","awprot"); @91

assign vb_sel                = lsu_biu_vb_awvalid;
assign arb_awvalid           = vb_sel ? lsu_biu_vb_awvalid           : lsu_biu_stb_awvalid;
assign arb_awaddr[PADDR-1:0] = vb_sel ? lsu_biu_vb_awaddr[PADDR-1:0] : lsu_biu_stb_awaddr[PADDR-1:0];
assign arb_awid[3:0]         = vb_sel ? lsu_biu_vb_awid[3:0]         : {2'b00,lsu_biu_stb_awid[1:0]};
assign arb_awsize[2:0]       = vb_sel ? lsu_biu_vb_awsize[2:0]       : lsu_biu_stb_awsize[2:0];
assign arb_awlen[1:0]        = vb_sel ? lsu_biu_vb_awlen[1:0]        : lsu_biu_stb_awlen[1:0];
assign arb_awburst[1:0]      = vb_sel ? lsu_biu_vb_awburst[1:0]      : lsu_biu_stb_awburst[1:0];
assign arb_awcache[3:0]      = vb_sel ? lsu_biu_vb_awcache[3:0]      : lsu_biu_stb_awcache[3:0];
assign arb_awprot[2:0]       = vb_sel ? lsu_biu_vb_awprot[2:0]       : lsu_biu_stb_awprot[2:0];
assign arb_awuser            = !vb_sel & lsu_biu_stb_awuser;

//================================================
//  APB write decode
//================================================
assign apb_aw_hit = arb_awaddr[PADDR-1:27] == sysio_biu_apb_base[PADDR-1:27];

assign apbif_awvalid           = arb_awvalid & apb_aw_hit;
assign apbif_awaddr[PADDR-1:0] = arb_awaddr[PADDR-1:0];
assign apbif_awprot[1:0]       = {arb_awuser,arb_awprot[0]};
assign apbif_awid[3:0]         = arb_awid[3:0];

assign awvalid                 = arb_awvalid & !apb_aw_hit & !aw_hit_wtable & !wsel_full;
assign awaddr[PADDR-1:0]       = arb_awaddr[PADDR-1:0];
assign awsize[2:0]             = arb_awsize[2:0];      
assign awlen[1:0]              = arb_awlen[1:0];     
assign awburst[1:0]            = arb_awburst[1:0];     
assign awcache[3:0]            = arb_awcache[3:0];     
assign awprot[2:0]             = arb_awprot[2:0];    
assign awlock                  = 1'b0;

assign axi_awready             = awready & !aw_hit_wtable & !wsel_full;
assign awready_final           = apb_aw_hit ? apbif_awready : axi_awready;
assign biu_lsu_vb_awready      = awready_final;
assign biu_lsu_stb_awready     = awready_final & !vb_sel;

//================================================
//  write sel fifo
//================================================

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wsel_fifo_create_ptr[3:0] <= 4'b0;
  else if (arb_awvalid & awready_final)
    wsel_fifo_create_ptr[3:0] <= wsel_fifo_create_ptr[3:0] + 4'b1;
end

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wsel_fifo_pop_ptr[3:0] <= 4'b0;
  else if (arb_wvalid & wready_final & arb_wlast)
    wsel_fifo_pop_ptr[3:0] <= wsel_fifo_pop_ptr[3:0] + 4'b1;
end

integer i;
always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    for(i=0;i<8;i=i+1)
      wsel_fifo[i] <= 1'b0;
  else begin
    for(i=0;i<8;i=i+1) 
    begin
      if (arb_awvalid & awready_final & wsel_fifo_create_ptr[2:0] == i) 
        wsel_fifo[i] <= vb_sel;
      else
        wsel_fifo[i] <= wsel_fifo[i];
    end
  end
end

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    for(i=0;i<8;i=i+1)
      apbif_sel[i] <= 1'b0;
  else begin
    for(i=0;i<8;i=i+1) 
    begin
      if (arb_awvalid & awready_final & wsel_fifo_create_ptr[2:0] == i) 
        apbif_sel[i] <= apb_aw_hit;
      else
        apbif_sel[i] <= apbif_sel[i];
    end
  end
end

assign wsel_full     = (wsel_fifo_pop_ptr[2:0] == wsel_fifo_create_ptr[2:0]) & 
                       (wsel_fifo_pop_ptr[3] ^ wsel_fifo_create_ptr[3]);

//================================================
//  write data channel
//================================================
assign wsel_vb            = wsel_fifo[wsel_fifo_pop_ptr[2:0]];
assign arb_wvalid         = wsel_vb ? lsu_biu_vb_wvalid       : lsu_biu_stb_wvalid;
assign arb_wdata[127:0]   = wsel_vb ? lsu_biu_vb_wdata[127:0] : lsu_biu_stb_wdata[127:0];
assign arb_wstrb[15:0]    = wsel_vb ? lsu_biu_vb_wstrb[15:0]  : lsu_biu_stb_wstrb[15:0];
assign arb_wlast          = wsel_vb ? lsu_biu_vb_wlast        : lsu_biu_stb_wlast;

assign wsel_apbif         = apbif_sel[wsel_fifo_pop_ptr[2:0]];
assign apbif_wvalid       = arb_wvalid & wsel_apbif;
assign apbif_wdata[127:0] = arb_wdata[127:0];

assign wvalid             = arb_wvalid & !wsel_apbif;
assign wdata[127:0]       = arb_wdata[127:0]; 
assign wstrb[15:0]        = arb_wstrb[15:0];
assign wlast              = arb_wlast; 

assign wready_final       = wsel_apbif ? apbif_wready : wready;
assign biu_lsu_vb_wready  = wready_final & wsel_vb;
assign biu_lsu_stb_wready = wready_final & !wsel_vb;

assign arb_clk_en = arb_awvalid | arb_wvalid & arb_wlast;

// &Instance("gated_clk_cell", "x_aq_biu_arb_gated_clk"); @208
gated_clk_cell  x_aq_biu_arb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (arb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (arb_clk_en        ),
  .module_en          (cp0_biu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @209
//          .external_en (1'b0), @210
//          .global_en   (1'b1), @211
//          .module_en   (cp0_biu_icg_en), @212
//          .local_en    (arb_clk_en), @213
//          .clk_out     (arb_clk)); @214

// &ModuleEnd; @216
endmodule


