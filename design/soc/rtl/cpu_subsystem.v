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

`ifdef CPU_CHECKPOINT
`define CORE_RESET_BASE     40'hC01C000000
`elsif CPU_RANDOM_TEST
`define CORE_RESET_BASE     40'h8000000
`else 
`define CORE_RESET_BASE     40'h1C000000
`endif

`define APB_BASE_ADDR       40'h2_0000_0000

module cpu_subsystem  (
  input    wire                 axim_clk_en,
  input    wire                 pad_biu_arready,
  input    wire                 pad_biu_awready,
  input    wire     [7   :0]    pad_biu_bid,
  input    wire     [1   :0]    pad_biu_bresp,
  input    wire                 pad_biu_bvalid,
  input    wire     [127 :0]    pad_biu_rdata,
  input    wire     [7   :0]    pad_biu_rid,
  input    wire                 pad_biu_rlast,
  input    wire     [3   :0]    pad_biu_rresp,
  input    wire                 pad_biu_rvalid,
  input    wire                 pad_biu_wready,
  input    wire                 pad_cpu_rst_b,
  input    wire                 pad_had_jtg_tclk,
  input    wire                 pad_had_jtg_tdi,
  input    wire                 pad_had_jtg_trst_b,
  input    wire                 pad_yy_dft_clk_rst_b,
  input    wire                 pll_cpu_clk,
  input    wire     [39  :0]    xx_intc_vld,
  input    wire                 i_pad_jtg_tms,
  input    wire     [7   :0]    ext_interrupt,
  output   wire     [39  :0]    biu_pad_araddr,
  output   wire     [1   :0]    biu_pad_arburst,
  output   wire     [3   :0]    biu_pad_arcache,
  output   wire     [7   :0]    biu_pad_arid,
  output   wire     [7   :0]    biu_pad_arlen,
  output   wire                 biu_pad_arlock,
  output   wire     [2   :0]    biu_pad_arprot,
  output   wire     [2   :0]    biu_pad_arsize,
  output   wire                 biu_pad_arvalid,
  output   wire     [39  :0]    biu_pad_awaddr,
  output   wire     [1   :0]    biu_pad_awburst,
  output   wire     [3   :0]    biu_pad_awcache,
  output   wire     [7   :0]    biu_pad_awid,
  output   wire     [7   :0]    biu_pad_awlen,
  output   wire                 biu_pad_awlock,
  output   wire     [2   :0]    biu_pad_awprot,
  output   wire     [2   :0]    biu_pad_awsize,
  output   wire                 biu_pad_awvalid,
  output   wire                 biu_pad_bready,
  output   wire                 biu_pad_rready,
  output   wire     [127 :0]    biu_pad_wdata,
  output   wire                 biu_pad_wlast,
  output   wire     [15  :0]    biu_pad_wstrb,
  output   wire                 biu_pad_wvalid,
  output   wire                 had_pad_jtg_tdo,
  output   wire                 had_pad_jtg_tdo_en,
  output   wire     [7   :0]    biu_pad_wid,
  output   wire     [1   :0]    biu_pad_lpmd_b
); 



//-------------------------------------------------
//                Wire Declarations
//-------------------------------------------------
wire     [143 :0]    pad_plic_int_cfg;
wire     [143 :0]    pad_plic_int_vld;
wire     [7   :0]    tmp_biu_pad_awid;            
wire                 tmp_biu_pad_awvalid;
wire                 tmp_biu_pad_wvalid;
wire                 tmp_biu_pad_wlast; 
wire                 tmp_pad_biu_awready;
wire                 tmp_pad_biu_wready;
wire     [1   :0]    core0_pad_lpmd_b;
wire     [63  :0]    xx_intc_int;            
wire                 per_clk;


reg      [63 : 0]    pad_cpu_sys_cnt;


labCore  core0_subsystem (
  .axim_clk_en                     (axim_clk_en          ),
  .pad_biu_arready                 (pad_biu_arready      ),
  .pad_biu_awready                 (pad_biu_awready      ),
  .pad_biu_bid                     (pad_biu_bid          ),
  .pad_biu_bresp                   (pad_biu_bresp        ),
  .pad_biu_bvalid                  (pad_biu_bvalid       ),
  .pad_biu_csysreq                 (1'b0                 ),
  .pad_biu_rdata                   (pad_biu_rdata        ),
  .pad_biu_rid                     (pad_biu_rid          ),
  .pad_biu_rlast                   (pad_biu_rlast        ),
  .pad_biu_rresp                   (pad_biu_rresp[1:0]   ),
  .pad_biu_rvalid                  (pad_biu_rvalid       ),
  .pad_biu_wready                  (pad_biu_wready       ),
  .pad_core0_dbg_mask              (1'b0                 ),
  .pad_core0_dbgrq_b               (1'b1                 ),
  .pad_core0_rst_b                 (pad_cpu_rst_b        ),
  .pad_core0_hartid                (3'h0                 ),
  .pad_cpu_apb_base                (`APB_BASE_ADDR       ),
  .pad_cpu_l2cache_flush_req       (1'b0                 ),
  .pad_cpu_rst_b                   (pad_cpu_rst_b        ),
  .pad_core0_rvba                  (`CORE_RESET_BASE     ),
  .pad_cpu_sys_cnt                 (pad_cpu_sys_cnt      ),
  .pad_had_jtg_tclk                (pad_had_jtg_tclk     ),
  .pad_had_jtg_tdi                 (pad_had_jtg_tdi      ),
  .pad_had_jtg_tms                 (pad_had_jtg_tms      ),
  .pad_had_jtg_trst_b              (pad_had_jtg_trst_b   ),
  .pad_l2c_data_mbist_clk_ratio    (3'b0                 ),
  .pad_l2c_tag_mbist_clk_ratio     (3'b0                 ),
  .pad_plic_int_cfg                (pad_plic_int_cfg     ),
  .pad_plic_int_vld                (pad_plic_int_vld     ),
  .pad_yy_dft_clk_rst_b            (pad_yy_dft_clk_rst_b ),
  .pad_yy_icg_scan_en              (1'b0                 ),
  .pad_yy_mbist_mode               (1'b0                 ),
  .pad_yy_scan_enable              (1'b0                 ),
  .pad_yy_scan_mode                (1'b0                 ),
  .pad_yy_scan_rst_b               (1'b1                 ),
  .pll_cpu_clk                     (pll_cpu_clk          ),
  .ext_interrupt                   (ext_interrupt        ),
  .biu_pad_araddr                  (biu_pad_araddr       ),
  .biu_pad_arburst                 (biu_pad_arburst      ),
  .biu_pad_arcache                 (biu_pad_arcache      ),
  .biu_pad_arid                    (biu_pad_arid         ),
  .biu_pad_arlen                   (biu_pad_arlen        ),
  .biu_pad_arlock                  (biu_pad_arlock       ),
  .biu_pad_arprot                  (biu_pad_arprot       ),
  .biu_pad_arsize                  (biu_pad_arsize       ),
  .biu_pad_arvalid                 (biu_pad_arvalid      ),
  .biu_pad_awaddr                  (biu_pad_awaddr       ),
  .biu_pad_awburst                 (biu_pad_awburst      ),
  .biu_pad_awcache                 (biu_pad_awcache      ),
  .biu_pad_awid                    (biu_pad_awid         ),
  .biu_pad_awlen                   (biu_pad_awlen        ),
  .biu_pad_awlock                  (biu_pad_awlock       ),
  .biu_pad_awprot                  (biu_pad_awprot       ),
  .biu_pad_awsize                  (biu_pad_awsize       ),
  .biu_pad_awvalid                 (biu_pad_awvalid      ),
  .biu_pad_bready                  (biu_pad_bready       ),
  .biu_pad_cactive                 (                     ),
  .biu_pad_csysack                 (                     ),
  .biu_pad_rready                  (biu_pad_rready       ),
  .biu_pad_wdata                   (biu_pad_wdata        ),
  .biu_pad_wlast                   (biu_pad_wlast        ),
  .biu_pad_wstrb                   (biu_pad_wstrb        ),
  .biu_pad_wvalid                  (biu_pad_wvalid       ),
  .core0_pad_jdb_pm                (                     ),
  .core0_pad_lpmd_b                (core0_pad_lpmd_b     ),
  .core0_pad_mstatus               (                     ),
  .core0_pad_retire0               (                     ),
  .core0_pad_retire0_pc            (                     ),
  .core0_pad_retire1               (                     ),
  .core0_pad_retire1_pc            (                     ),
  .core0_pad_retire2               (                     ),
  .core0_pad_retire2_pc            (                     ),
  .cpu_debug_port                  (                     ),
  .pad_core1_dbg_mask              (1'b0                 ),
  .pad_core1_dbgrq_b               (1'b1                 ),
  .pad_core1_rst_b                 (pad_cpu_rst_b        ),
  .pad_core1_hartid                (3'h1                 ),
  .pad_core1_rvba                  (40'h0                ),
  .core1_pad_jdb_pm                (                     ),
  .core1_pad_lpmd_b                (                     ),
  .core1_pad_mstatus               (                     ),
  .core1_pad_retire0               (                     ),
  .core1_pad_retire0_pc            (                     ),
  .core1_pad_retire1               (                     ),
  .core1_pad_retire1_pc            (                     ),
  .core1_pad_retire2               (                     ),
  .core1_pad_retire2_pc            (                     ),
`ifdef TRIPLE_CORE
  .pad_core2_dbg_mask              (1'b0                 ),
  .pad_core2_dbgrq_b               (1'b1                 ),
  .pad_core2_rst_b                 (pad_cpu_rst_b        ),
  .pad_core2_hartid                (3'h2                 ),
  .pad_core2_rvba                  (40'h0                ),
`endif
`ifdef QUAD_CORE
  .pad_core3_dbg_mask              (1'b0                 ),
  .pad_core3_dbgrq_b               (1'b1                 ),
  .pad_core3_rst_b                 (pad_cpu_rst_b        ),
  .pad_core3_hartid                (3'h3                 ),
  .pad_core3_rvba                  (40'h0                ),
`endif
  .cpu_pad_l2cache_flush_done      (                     ),
  .cpu_pad_no_op                   (                     ),
  .had_pad_jtg_tdo                 (had_pad_jtg_tdo      ),
  .had_pad_jtg_tdo_en              (had_pad_jtg_tdo_en   )
);


assign pad_had_jtg_tms     = i_pad_jtg_tms;
assign biu_pad_lpmd_b[1:0] = core0_pad_lpmd_b;

// system timer simple model
always@(posedge pll_cpu_clk or negedge pad_cpu_rst_b)
begin
  if (!pad_cpu_rst_b)
    pad_cpu_sys_cnt <= 64'b0;
  else
    pad_cpu_sys_cnt <= pad_cpu_sys_cnt + 1'b1;
end

// External Interrupts
// assign xx_intc_int[63:0] = {24'b0,xx_intc_vld[39:0]};
// assign pad_plic_int_vld  = {{ 144 - 40{1'b0}}, xx_intc_vld[39:0]};
assign pad_plic_int_vld[ 39 : 0] = xx_intc_vld[ 39 : 0];

assign pad_plic_int_vld[143 : 40] = '0;

assign pad_plic_int_cfg  = '0;


// for fiting AXI3 system bus 
assign  tmp_biu_pad_awid    = biu_pad_awid; 
assign  tmp_biu_pad_awvalid = biu_pad_awvalid;
assign  tmp_biu_pad_wvalid  = biu_pad_wvalid;
assign  tmp_biu_pad_wlast   = biu_pad_wlast;
assign  tmp_pad_biu_awready = pad_biu_awready;
assign  tmp_pad_biu_wready  = pad_biu_wready;

assign  per_clk = pll_cpu_clk;

wid_for_axi4 wid_for_axi4 (
  .biu_pad_awid         (tmp_biu_pad_awid),
  .biu_pad_awvalid      (tmp_biu_pad_awvalid), 
  .biu_pad_wvalid       (tmp_biu_pad_wvalid),
  .biu_pad_wlast        (tmp_biu_pad_wlast),
  .pad_biu_awready      (tmp_pad_biu_awready),
  .pad_biu_wready       (tmp_pad_biu_wready),
  .pad_cpu_rst_b        (pad_cpu_rst_b),
  .biu_pad_wid          (biu_pad_wid),
  .per_clk              (per_clk)
);

endmodule

