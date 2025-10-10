
`timescale 1 ps / 1 ps

// define declaration here
// `define USE_BD_NET 0
`define BOARD_AXVU13P 1

module soc_top_xlnx (
`ifdef BOARD_VCU118
  input    wire           reset,
  output   wire           c0_ddr4_act_n,
  output   wire  [16:0]   c0_ddr4_adr,
  output   wire  [1 :0]   c0_ddr4_ba,
  output   wire           c0_ddr4_bg,
  output   wire           c0_ddr4_ck_c,
  output   wire           c0_ddr4_ck_t,
  output   wire           c0_ddr4_cke,
  output   wire           c0_ddr4_cs_n,
  inout    wire  [7 :0]   c0_ddr4_dm_n,
  inout    wire  [63:0]   c0_ddr4_dq,
  inout    wire  [7 :0]   c0_ddr4_dqs_c,
  inout    wire  [7 :0]   c0_ddr4_dqs_t,
  output   wire           c0_ddr4_odt,
  output   wire           c0_ddr4_reset_n,
  input    wire           c0_sys_clk_n,
  input    wire           c0_sys_clk_p,
`elsif BOARD_AXVU13P
  input    wire           sys_rst_n,
  output   wire           c0_ddr4_act_n,
  output   wire  [16:0]   c0_ddr4_adr,
  output   wire  [1 :0]   c0_ddr4_ba,
  output   wire  [1 :0]   c0_ddr4_bg,
  output   wire  [1 :0]   c0_ddr4_ck_c,
  output   wire  [1 :0]   c0_ddr4_ck_t,
  output   wire  [1 :0]   c0_ddr4_cke,
  output   wire  [1 :0]   c0_ddr4_cs_n,
  inout    wire  [7 :0]   c0_ddr4_dm_n,
  inout    wire  [63:0]   c0_ddr4_dq,
  inout    wire  [7 :0]   c0_ddr4_dqs_c,
  inout    wire  [7 :0]   c0_ddr4_dqs_t,
  output   wire  [1 :0]   c0_ddr4_odt,
  output   wire           c0_ddr4_reset_n,
  input    wire           c0_sys_clk_n,
  input    wire           c0_sys_clk_p,
`else 
  input    wire           reset,
  output   wire           c0_ddr4_act_n,
  output   wire  [16:0]   c0_ddr4_adr,
  output   wire  [1 :0]   c0_ddr4_ba,
  output   wire           c0_ddr4_bg,
  output   wire           c0_ddr4_ck_c,
  output   wire           c0_ddr4_ck_t,
  output   wire           c0_ddr4_cke,
  output   wire           c0_ddr4_cs_n,
  inout    wire  [7 :0]   c0_ddr4_dm_n,
  inout    wire  [63:0]   c0_ddr4_dq,
  inout    wire  [7 :0]   c0_ddr4_dqs_c,
  inout    wire  [7 :0]   c0_ddr4_dqs_t,
  output   wire           c0_ddr4_odt,
  output   wire           c0_ddr4_reset_n,
  input    wire           c0_sys_clk_n,
  input    wire           c0_sys_clk_p,
`endif

`ifdef USE_BD_NET
  input    wire           sgmii_phyclk_clk_n,
  input    wire           sgmii_phyclk_clk_p,
  output   wire           phy_reset_out,
  output   wire           mdio_mdc_mdc,
  inout    wire           mdio_mdc_mdio_io,
  input    wire           sgmii_lvds_rxn,
  input    wire           sgmii_lvds_rxp,
  output   wire           sgmii_lvds_txn,
  output   wire           sgmii_lvds_txp,
`endif

  input    wire           rs232_uart_rxd,
  output   wire           rs232_uart_txd
);



// parameter
parameter int unsigned AXI_ID_WIDTH      = 8;
parameter int unsigned AXI_ADDR_WIDTH    = 48;
parameter int unsigned AXI_DATA_WIDTH    = 128;
parameter int unsigned AXI_USER_WIDTH    = 2;

// declaration wire

`ifdef BOARD_AXVU13P
wire               reset;
assign reset  =   ~sys_rst_n;
`endif

wire               clk_300M;
wire               clk_200M;
wire               clk_100M;
wire               clk_50M;
wire               clk_20M;
wire               clk_10M;
wire               bd_soc_clk;
wire               core_reset;
wire               core_reset_b;
wire               peripheral_aresetn;


wire   [AXI_ADDR_WIDTH-1 :0]   s_axi_araddr;
wire   [1 :0]      s_axi_arburst;
wire   [3 :0]      s_axi_arcache;
wire   [AXI_ID_WIDTH-1 :0]     s_axi_arid;
wire   [7 :0]      s_axi_arlen;
wire   [0 :0]      s_axi_arlock;
wire   [2 :0]      s_axi_arprot;
wire   [3 :0]      s_axi_arqos;
wire               s_axi_arready;
wire   [3 :0]      s_axi_arregion;
wire   [2 :0]      s_axi_arsize;
wire               s_axi_arvalid;
wire   [AXI_ADDR_WIDTH-1 :0]   s_axi_awaddr;
wire   [1 :0]      s_axi_awburst;
wire   [3 :0]      s_axi_awcache;
wire   [AXI_ID_WIDTH-1:0]      s_axi_awid;
wire   [7 :0]      s_axi_awlen;
wire   [0 :0]      s_axi_awlock;
wire   [2 :0]      s_axi_awprot;
wire   [3 :0]      s_axi_awqos;
wire               s_axi_awready;
wire   [3 :0]      s_axi_awregion;
wire   [2 :0]      s_axi_awsize;
wire               s_axi_awvalid;
wire   [AXI_ID_WIDTH-1:0]      s_axi_bid;
wire               s_axi_bready;
wire   [1 :0]      s_axi_bresp;
wire               s_axi_bvalid;
wire   [AXI_DATA_WIDTH-1 :0]   s_axi_rdata;
wire   [AXI_ID_WIDTH-1:0]      s_axi_rid;
wire               s_axi_rlast;
wire               s_axi_rready;
wire   [1 :0]      s_axi_rresp;
wire               s_axi_rvalid;
wire   [AXI_ID_WIDTH-1:0]      s_axi_wid;
wire   [AXI_DATA_WIDTH-1:0]    s_axi_wdata;
wire               s_axi_wlast;
wire               s_axi_wready;
wire   [15 :0]     s_axi_wstrb;
wire               s_axi_wvalid;

wire               vio_cpu_reset;
wire               vio_system_reset;
wire               vio_ddr_reset;

wire   [1  :0]     core_in_core_id;
wire   [39 :0]     core_in_interrupt;
wire               core_in_ipi;
wire               uart_int;
wire               eth_interrupt;
wire               mac_irq;
wire               mm2s_introut;
wire               s2mm_introut;

wire               pll_cpu_clk;
wire               had_pad_jtg_tdo;      
wire               had_pad_jtg_tdo_en;  
wire               pad_cpu_rst_b;
wire   [1 :0]      biu_pad_lpmd_b;
wire               pad_had_jtg_tclk;
wire               pad_had_jtg_tdi;   
wire               pad_had_jtg_trst_b;
wire   [7 :0]      ext_interrupt;

assign core_reset_b       = ~core_reset;

assign  pad_had_jtg_tclk  = pll_cpu_clk;
assign  pad_cpu_rst_b     = core_reset_b;
assign  pad_had_jtg_tdi   = '0;

`ifdef USE_BD_NET
assign  ext_interrupt[7:0] = {3'b0, mac_irq, eth_interrupt, s2mm_introut, mm2s_introut, uart_int};
`else 
assign  ext_interrupt[7:0] = {6'b0, 1'b0, uart_int};
`endif


cpu_subsystem  cpu_subsystem (
  // AR
  .biu_pad_araddr        (s_axi_araddr[39:0] ),
  .biu_pad_arburst       (s_axi_arburst      ),
  .biu_pad_arcache       (s_axi_arcache      ),
  .biu_pad_arid          (s_axi_arid         ),
  .biu_pad_arlen         (s_axi_arlen        ),
  .biu_pad_arlock        (s_axi_arlock       ),
  .biu_pad_arprot        (s_axi_arprot       ),
  .biu_pad_arsize        (s_axi_arsize       ),
  .biu_pad_arvalid       (s_axi_arvalid      ),
  .pad_biu_arready       (s_axi_arready      ),
  
  // AW
  .biu_pad_awaddr        (s_axi_awaddr[39:0] ),
  .biu_pad_awburst       (s_axi_awburst      ),
  .biu_pad_awcache       (s_axi_awcache      ),
  .biu_pad_awid          (s_axi_awid         ),
  .biu_pad_awlen         (s_axi_awlen        ),
  .biu_pad_awlock        (s_axi_awlock       ),
  .biu_pad_awprot        (s_axi_awprot       ),
  .biu_pad_awsize        (s_axi_awsize       ),
  .biu_pad_awvalid       (s_axi_awvalid      ),
  .pad_biu_awready       (s_axi_awready      ),
  
  // W
  .biu_pad_wdata         (s_axi_wdata        ),
  .biu_pad_wid           (s_axi_wid          ),
  .biu_pad_wlast         (s_axi_wlast        ),
  .biu_pad_wstrb         (s_axi_wstrb        ),
  .biu_pad_wvalid        (s_axi_wvalid       ),
  .pad_biu_wready        (s_axi_wready       ),
  
  // B
  .biu_pad_bready        (s_axi_bready       ),
  .pad_biu_bid           (s_axi_bid          ),
  .pad_biu_bresp         (s_axi_bresp        ),
  .pad_biu_bvalid        (s_axi_bvalid       ),
  
  // R
  .biu_pad_rready        (s_axi_rready       ),
  .pad_biu_rdata         (s_axi_rdata        ),
  .pad_biu_rid           (s_axi_rid          ),
  .pad_biu_rlast         (s_axi_rlast        ),
  .pad_biu_rresp         ({2'b0,s_axi_rresp} ),
  .pad_biu_rvalid        (s_axi_rvalid       ),

  /// MISC
  .axim_clk_en           (1'b1               ),
  .biu_pad_lpmd_b        (biu_pad_lpmd_b     ),
  .had_pad_jtg_tdo       (                   ),
  .had_pad_jtg_tdo_en    (                   ),
  .i_pad_jtg_tms         (                   ),  /// No Input
  .pad_cpu_rst_b         (pad_cpu_rst_b      ),
  .pad_yy_dft_clk_rst_b  (pad_cpu_rst_b      ),
  .pad_had_jtg_tclk      (pad_had_jtg_tclk   ),
  .pad_had_jtg_tdi       ('0                 ),
  .pad_had_jtg_trst_b    (pad_cpu_rst_b      ),
  .pll_cpu_clk           (pll_cpu_clk        ),
  .ext_interrupt         (ext_interrupt      ),
  .xx_intc_vld           (core_in_interrupt  )
);

assign  s_axi_awqos    = '0;
assign  s_axi_awregion = '0;
assign  s_axi_arqos    = '0;
assign  s_axi_arregion = '0;

wire [47:0]        bd_axi_araddr;
wire [1:0]         bd_axi_arburst;
wire [3:0]         bd_axi_arcache;
wire [AXI_ID_WIDTH-1:0]      bd_axi_arid;
wire [7:0]         bd_axi_arlen;
wire [0:0]         bd_axi_arlock;
wire [2:0]         bd_axi_arprot;
wire [3:0]         bd_axi_arqos;
wire               bd_axi_arready;
wire [3:0]         bd_axi_arregion;
wire [2:0]         bd_axi_arsize;
wire               bd_axi_arvalid;
wire [47:0]        bd_axi_awaddr;
wire [1:0]         bd_axi_awburst;
wire [3:0]         bd_axi_awcache;
wire [AXI_ID_WIDTH-1:0]      bd_axi_awid;
wire [7:0]         bd_axi_awlen;
wire [0:0]         bd_axi_awlock;
wire [2:0]         bd_axi_awprot;
wire [3:0]         bd_axi_awqos;
wire               bd_axi_awready;
wire [3:0]         bd_axi_awregion;
wire [2:0]         bd_axi_awsize;
wire               bd_axi_awvalid;
wire [AXI_ID_WIDTH-1:0]      bd_axi_bid;
wire               bd_axi_bready;
wire [1:0]         bd_axi_bresp;
wire               bd_axi_bvalid;
wire [127:0]       bd_axi_rdata;
wire [AXI_ID_WIDTH-1:0]      bd_axi_rid;
wire               bd_axi_rlast;
wire               bd_axi_rready;
wire [1:0]         bd_axi_rresp;
wire               bd_axi_rvalid;
wire [127:0]       bd_axi_wdata;
wire               bd_axi_wlast;
wire               bd_axi_wready;
wire [15:0]        bd_axi_wstrb;
wire               bd_axi_wvalid;


// USE_XLNX_CC is that we use xilinx clock_converter for 50MHz->100MHz

// `define USE_XLNX_CC
`ifdef USE_XLNX_CC

// Set up Clock
assign  pll_cpu_clk = clk_50M;
assign  bd_soc_clk  = clk_100M;

xlnx_cpu_cconvt     cpu_converter (
  .s_axi_aclk        (pll_cpu_clk),       
  .s_axi_aresetn     (peripheral_aresetn),
  .s_axi_awid        (s_axi_awid),
  .s_axi_awaddr      ({8'b0, s_axi_awaddr[39:0]}),
  .s_axi_awlen       (s_axi_awlen),
  .s_axi_awsize      (s_axi_awsize),
  .s_axi_awburst     (s_axi_awburst),
  .s_axi_awlock      (s_axi_awlock),
  .s_axi_awcache     (s_axi_awcache),
  .s_axi_awprot      (s_axi_awprot),
  .s_axi_awregion    (s_axi_awregion),
  .s_axi_awqos       (s_axi_awqos),
  .s_axi_awvalid     (s_axi_awvalid),
  .s_axi_awready     (s_axi_awready),
  .s_axi_wdata       (s_axi_wdata),
  .s_axi_wstrb       (s_axi_wstrb),
  .s_axi_wlast       (s_axi_wlast),
  .s_axi_wvalid      (s_axi_wvalid),
  .s_axi_wready      (s_axi_wready),
  .s_axi_bid         (s_axi_bid),
  .s_axi_bresp       (s_axi_bresp),
  .s_axi_bvalid      (s_axi_bvalid),
  .s_axi_bready      (s_axi_bready),
  .s_axi_arid        (s_axi_arid),
  .s_axi_araddr      ({8'b0, s_axi_araddr[39:0]}),
  .s_axi_arlen       (s_axi_arlen),
  .s_axi_arsize      (s_axi_arsize),
  .s_axi_arburst     (s_axi_arburst),
  .s_axi_arlock      (s_axi_arlock),
  .s_axi_arcache     (s_axi_arcache),
  .s_axi_arprot      (s_axi_arprot),
  .s_axi_arregion    (s_axi_arregion),
  .s_axi_arqos       (s_axi_arqos),
  .s_axi_arvalid     (s_axi_arvalid),
  .s_axi_arready     (s_axi_arready),
  .s_axi_rid         (s_axi_rid),
  .s_axi_rdata       (s_axi_rdata),
  .s_axi_rresp       (s_axi_rresp),
  .s_axi_rlast       (s_axi_rlast),
  .s_axi_rvalid      (s_axi_rvalid),
  .s_axi_rready      (s_axi_rready),
  
  .m_axi_aclk        (bd_soc_clk),        
  .m_axi_aresetn     (peripheral_aresetn),
  .m_axi_awid        (bd_axi_awid),
  .m_axi_awaddr      (bd_axi_awaddr),
  .m_axi_awlen       (bd_axi_awlen),
  .m_axi_awsize      (bd_axi_awsize),
  .m_axi_awburst     (bd_axi_awburst),
  .m_axi_awlock      (bd_axi_awlock),
  .m_axi_awcache     (bd_axi_awcache),
  .m_axi_awprot      (bd_axi_awprot),
  .m_axi_awregion    (bd_axi_awregion),
  .m_axi_awqos       (bd_axi_awqos),
  .m_axi_awvalid     (bd_axi_awvalid),
  .m_axi_awready     (bd_axi_awready),
  .m_axi_wdata       (bd_axi_wdata),
  .m_axi_wstrb       (bd_axi_wstrb),
  .m_axi_wlast       (bd_axi_wlast),
  .m_axi_wvalid      (bd_axi_wvalid),
  .m_axi_wready      (bd_axi_wready),
  .m_axi_bid         (bd_axi_bid),
  .m_axi_bresp       (bd_axi_bresp),
  .m_axi_bvalid      (bd_axi_bvalid),
  .m_axi_bready      (bd_axi_bready),
  .m_axi_arid        (bd_axi_arid),
  .m_axi_araddr      (bd_axi_araddr),
  .m_axi_arlen       (bd_axi_arlen),
  .m_axi_arsize      (bd_axi_arsize),
  .m_axi_arburst     (bd_axi_arburst),
  .m_axi_arlock      (bd_axi_arlock),
  .m_axi_arcache     (bd_axi_arcache),
  .m_axi_arprot      (bd_axi_arprot),
  .m_axi_arregion    (bd_axi_arregion),
  .m_axi_arqos       (bd_axi_arqos),
  .m_axi_arvalid     (bd_axi_arvalid),
  .m_axi_arready     (bd_axi_arready),
  .m_axi_rid         (bd_axi_rid),
  .m_axi_rdata       (bd_axi_rdata),
  .m_axi_rresp       (bd_axi_rresp),
  .m_axi_rlast       (bd_axi_rlast),
  .m_axi_rvalid      (bd_axi_rvalid),
  .m_axi_rready      (bd_axi_rready)
);

`else 

// Set up Clock
assign  pll_cpu_clk = clk_100M;
assign  bd_soc_clk  = clk_100M;

assign  bd_axi_arid[AXI_ID_WIDTH-1:0]   =   s_axi_arid[AXI_ID_WIDTH-1:0];
assign  bd_axi_araddr[47:0]   =   {8'b0, s_axi_araddr[39:0]};
assign  bd_axi_arlen[7:0]     =   s_axi_arlen[7:0];
assign  bd_axi_arsize[2:0]    =   s_axi_arsize[2:0];
assign  bd_axi_arburst[1:0]   =   s_axi_arburst[1:0];
assign  bd_axi_arlock[0:0]    =   s_axi_arlock[0:0];
assign  bd_axi_arcache[3:0]   =   s_axi_arcache[3:0];
assign  bd_axi_arprot[2:0]    =   s_axi_arprot[2:0];
assign  bd_axi_arregion[3:0]  =   s_axi_arregion[3:0];
assign  bd_axi_arqos[3:0]     =   s_axi_arqos[3:0];
assign  bd_axi_arvalid        =   s_axi_arvalid;
assign  bd_axi_arready        =   s_axi_arready;
assign  bd_axi_rid[AXI_ID_WIDTH-1:0]    =   s_axi_rid[AXI_ID_WIDTH-1:0];
assign  bd_axi_rdata[127:0]   =   s_axi_rdata[127:0];
assign  bd_axi_rresp[1:0]     =   s_axi_rresp[1:0];
assign  bd_axi_rlast          =   s_axi_rlast;
assign  bd_axi_rready         =   s_axi_rready;
assign  bd_axi_rvalid         =   s_axi_rvalid;
assign  bd_axi_awid[AXI_ID_WIDTH-1:0]   =   s_axi_awid[AXI_ID_WIDTH-1:0];
assign  bd_axi_awaddr[47:0]   =   {8'b0, s_axi_awaddr[39:0]};
assign  bd_axi_awlen[7:0]     =   s_axi_awlen[7:0];
assign  bd_axi_awsize[2:0]    =   s_axi_awsize[2:0];
assign  bd_axi_awburst[1:0]   =   s_axi_awburst[1:0];
assign  bd_axi_awlock[0:0]    =   s_axi_awlock[0:0];
assign  bd_axi_awcache[3:0]   =   s_axi_awcache[3:0];
assign  bd_axi_awprot[2:0]    =   s_axi_awprot[2:0];
assign  bd_axi_awregion[3:0]  =   s_axi_awregion[3:0];
assign  bd_axi_awqos[3:0]     =   s_axi_awqos[3:0];
assign  bd_axi_awvalid        =   s_axi_awvalid;
assign  bd_axi_awready        =   s_axi_awready;
assign  bd_axi_wdata[127:0]   =   s_axi_wdata[127:0];
assign  bd_axi_wstrb[15:0]    =   s_axi_wstrb[15:0];
assign  bd_axi_wlast          =   s_axi_wlast;
assign  bd_axi_wvalid         =   s_axi_wvalid;
assign  bd_axi_wready         =   s_axi_wready;
assign  bd_axi_bid[AXI_ID_WIDTH-1:0]    =   s_axi_bid[AXI_ID_WIDTH-1:0];
assign  bd_axi_bresp[1:0]     =   s_axi_bresp[1:0];
assign  bd_axi_bvalid         =   s_axi_bvalid;
assign  bd_axi_bready         =   s_axi_bready;
`endif


wire   [63: 0]    DDR4_AXI_araddr;
wire   [1 : 0]    DDR4_AXI_arburst;
wire   [3 : 0]    DDR4_AXI_arcache;
wire   [0 : 0]    DDR4_AXI_arid;
wire   [7 : 0]    DDR4_AXI_arlen;
wire   [0 : 0]    DDR4_AXI_arlock;
wire   [2 : 0]    DDR4_AXI_arprot;
wire   [3 : 0]    DDR4_AXI_arqos;
wire   [0 : 0]    DDR4_AXI_arready;
wire   [3 : 0]    DDR4_AXI_arregion;
wire   [2 : 0]    DDR4_AXI_arsize;
wire   [0 : 0]    DDR4_AXI_arvalid;
wire   [63 :0]    DDR4_AXI_awaddr;
wire   [1  :0]    DDR4_AXI_awburst;
wire   [3  :0]    DDR4_AXI_awcache;
wire   [0  :0]    DDR4_AXI_awid;
wire   [7  :0]    DDR4_AXI_awlen;
wire   [0  :0]    DDR4_AXI_awlock;
wire   [2  :0]    DDR4_AXI_awprot;
wire   [3  :0]    DDR4_AXI_awqos;
wire   [0  :0]    DDR4_AXI_awready;
wire   [3  :0]    DDR4_AXI_awregion;
wire   [2  :0]    DDR4_AXI_awsize;
wire   [0  :0]    DDR4_AXI_awvalid;
wire   [0  :0]    DDR4_AXI_bid;
wire   [0  :0]    DDR4_AXI_bready;
wire   [1  :0]    DDR4_AXI_bresp;
wire   [0  :0]    DDR4_AXI_bvalid;
wire   [511:0]    DDR4_AXI_rdata;
wire   [0  :0]    DDR4_AXI_rid;
wire   [0  :0]    DDR4_AXI_rlast;
wire   [0  :0]    DDR4_AXI_rready;
wire   [1  :0]    DDR4_AXI_rresp;
wire   [0  :0]    DDR4_AXI_rvalid;
wire   [511:0]    DDR4_AXI_wdata;
wire   [0  :0]    DDR4_AXI_wlast;
wire   [0  :0]    DDR4_AXI_wready;
wire   [63 :0]    DDR4_AXI_wstrb;
wire   [0  :0]    DDR4_AXI_wvalid;

wire              ddr4_axi_aresetn;
wire   [0 : 0]    ddr4_axi_awid;
wire   [63: 0]    ddr4_axi_awaddr;
wire   [7 : 0]    ddr4_axi_awlen;
wire   [2 : 0]    ddr4_axi_awsize;
wire   [1 : 0]    ddr4_axi_awburst;
wire   [0 : 0]    ddr4_axi_awlock;
wire   [3 : 0]    ddr4_axi_awcache;
wire   [2 : 0]    ddr4_axi_awprot;
wire   [3 : 0]    ddr4_axi_awqos;
wire              ddr4_axi_awvalid;
wire              ddr4_axi_awready;
wire   [511:0]    ddr4_axi_wdata;
wire   [63: 0]    ddr4_axi_wstrb;
wire              ddr4_axi_wlast;
wire              ddr4_axi_wvalid;
wire              ddr4_axi_wready;
wire              ddr4_axi_bready;
wire   [0 : 0]    ddr4_axi_bid;
wire   [1 : 0]    ddr4_axi_bresp;
wire              ddr4_axi_bvalid;
wire   [0 : 0]    ddr4_axi_arid;
wire   [63: 0]    ddr4_axi_araddr;
wire   [7 : 0]    ddr4_axi_arlen;
wire   [2 : 0]    ddr4_axi_arsize;
wire   [1 : 0]    ddr4_axi_arburst;
wire   [0 : 0]    ddr4_axi_arlock;
wire   [3 : 0]    ddr4_axi_arcache;
wire   [2 : 0]    ddr4_axi_arprot;
wire   [3 : 0]    ddr4_axi_arqos;
wire              ddr4_axi_arvalid;
wire              ddr4_axi_arready;
wire              ddr4_axi_rready;
wire              ddr4_axi_rlast;
wire              ddr4_axi_rvalid;
wire   [1 : 0]    ddr4_axi_rresp;
wire   [0 : 0]    ddr4_axi_rid;
wire   [511:0]    ddr4_axi_rdata;

wire              DDR4_axi_aresetn;
wire   [0 : 0]    DDR4_axi_awid;
wire   [63: 0]    DDR4_axi_awaddr;
wire   [7 : 0]    DDR4_axi_awlen;
wire   [2 : 0]    DDR4_axi_awsize;
wire   [1 : 0]    DDR4_axi_awburst;
wire   [0 : 0]    DDR4_axi_awlock;
wire   [3 : 0]    DDR4_axi_awcache;
wire   [2 : 0]    DDR4_axi_awprot;
wire   [3 : 0]    DDR4_axi_awqos;
wire              DDR4_axi_awvalid;
wire              DDR4_axi_awready;
wire   [511:0]    DDR4_axi_wdata;
wire   [63: 0]    DDR4_axi_wstrb;
wire              DDR4_axi_wlast;
wire              DDR4_axi_wvalid;
wire              DDR4_axi_wready;
wire              DDR4_axi_bready;
wire   [4 : 0]    DDR4_axi_bid;
wire   [1 : 0]    DDR4_axi_bresp;
wire              DDR4_axi_bvalid;
wire   [0 : 0]    DDR4_axi_arid;
wire   [63: 0]    DDR4_axi_araddr;
wire   [7 : 0]    DDR4_axi_arlen;
wire   [2 : 0]    DDR4_axi_arsize;
wire   [1 : 0]    DDR4_axi_arburst;
wire   [0 : 0]    DDR4_axi_arlock;
wire   [3 : 0]    DDR4_axi_arcache;
wire   [2 : 0]    DDR4_axi_arprot;
wire   [3 : 0]    DDR4_axi_arqos;
wire              DDR4_axi_arvalid;
wire              DDR4_axi_arready;
wire              DDR4_axi_rready;
wire              DDR4_axi_rlast;
wire              DDR4_axi_rvalid;
wire   [1 : 0]    DDR4_axi_rresp;
wire   [4 : 0]    DDR4_axi_rid;
wire   [511:0]    DDR4_axi_rdata;

wire              bd_soc_ddr_reset;
wire              c0_init_calib_complete;
wire              ddr4_300M_clk;
wire              ddr4_ui_clk_sync_rst;


`ifdef USE_BD_NET

assign ddr4_axi_arid     = '0;
assign ddr4_axi_awid     = '0;
assign ddr4_axi_arregion = '0;
assign ddr4_axi_awregion = '0;

xlnx_bd_soc_net_wrapper  bd_soc (
  .DDR4_AXI_araddr               (ddr4_axi_araddr),
  .DDR4_AXI_arburst              (ddr4_axi_arburst),
  .DDR4_AXI_arcache              (ddr4_axi_arcache),
  .DDR4_AXI_arlen                (ddr4_axi_arlen),
  .DDR4_AXI_arlock               (ddr4_axi_arlock),
  .DDR4_AXI_arprot               (ddr4_axi_arprot),
  .DDR4_AXI_arqos                (ddr4_axi_arqos),
  .DDR4_AXI_arready              (ddr4_axi_arready),
  .DDR4_AXI_arsize               (ddr4_axi_arsize),
  .DDR4_AXI_arvalid              (ddr4_axi_arvalid),
  .DDR4_AXI_awaddr               (ddr4_axi_awaddr),
  .DDR4_AXI_awburst              (ddr4_axi_awburst),
  .DDR4_AXI_awcache              (ddr4_axi_awcache),
  .DDR4_AXI_awlen                (ddr4_axi_awlen),
  .DDR4_AXI_awlock               (ddr4_axi_awlock),
  .DDR4_AXI_awprot               (ddr4_axi_awprot),
  .DDR4_AXI_awqos                (ddr4_axi_awqos),
  .DDR4_AXI_awready              (ddr4_axi_awready),
  .DDR4_AXI_awsize               (ddr4_axi_awsize),
  .DDR4_AXI_awvalid              (ddr4_axi_awvalid),
  .DDR4_AXI_bready               (ddr4_axi_bready),
  .DDR4_AXI_bresp                (ddr4_axi_bresp),
  .DDR4_AXI_bvalid               (ddr4_axi_bvalid),
  .DDR4_AXI_rdata                (ddr4_axi_rdata),
  .DDR4_AXI_rlast                (ddr4_axi_rlast),
  .DDR4_AXI_rready               (ddr4_axi_rready),
  .DDR4_AXI_rresp                (ddr4_axi_rresp),
  .DDR4_AXI_rvalid               (ddr4_axi_rvalid),
  .DDR4_AXI_wdata                (ddr4_axi_wdata),
  .DDR4_AXI_wlast                (ddr4_axi_wlast),
  .DDR4_AXI_wready               (ddr4_axi_wready),
  .DDR4_AXI_wstrb                (ddr4_axi_wstrb),
  .DDR4_AXI_wvalid               (ddr4_axi_wvalid),
  
  .bd_soc_clk                    (clk_100M),
  .bd_soc_ddr_reset              (bd_soc_ddr_reset),
  .vio_cpu_reset                 (vio_cpu_reset),
  .core_reset                    (core_reset),
  .peripheral_aresetn            (peripheral_aresetn),

  // UART
  .rs232_uart_baudoutn           (              ),
  .rs232_uart_ctsn               (1'b1          ),
  .rs232_uart_dcdn               (1'b1          ),
  .rs232_uart_ddis               (              ),
  .rs232_uart_dsrn               (1'b1          ),
  .rs232_uart_dtrn               (              ),
  .rs232_uart_out1n              (              ),
  .rs232_uart_out2n              (              ),
  .rs232_uart_ri                 (1'b1          ),
  .rs232_uart_rtsn               (              ),
  .rs232_uart_rxrdyn             (              ),
  .rs232_uart_txrdyn             (              ),
  .rs232_uart_rxd                (rs232_uart_rxd),
  .rs232_uart_txd                (rs232_uart_txd),
  .uart_int                      (uart_int      ),

  .eth_interrupt                 (eth_interrupt),
  .mac_irq                       (mac_irq),
  .mm2s_introut                  (mm2s_introut),
  .s2mm_introut                  (s2mm_introut),
  .sgmii_phyclk_clk_n            (sgmii_phyclk_clk_n),
  .sgmii_phyclk_clk_p            (sgmii_phyclk_clk_p),
  .phy_reset_out                 (phy_reset_out),
  .mdio_mdc_mdc                  (mdio_mdc_mdc),
  .mdio_mdc_mdio_io              (mdio_mdc_mdio_io),
  .sgmii_lvds_rxn                (sgmii_lvds_rxn),
  .sgmii_lvds_rxp                (sgmii_lvds_rxp),
  .sgmii_lvds_txn                (sgmii_lvds_txn),
  .sgmii_lvds_txp                (sgmii_lvds_txp),
  
  // CPU AXI
  .s_axi_araddr                  (bd_axi_araddr),
  .s_axi_arburst                 (bd_axi_arburst),
  .s_axi_arcache                 (bd_axi_arcache),
  .s_axi_arid                    (bd_axi_arid),
  .s_axi_arlen                   (bd_axi_arlen),
  .s_axi_arlock                  (bd_axi_arlock),
  .s_axi_arprot                  (bd_axi_arprot),
  .s_axi_arqos                   (bd_axi_arqos),
  .s_axi_arready                 (bd_axi_arready),
  .s_axi_arsize                  (bd_axi_arsize),
  .s_axi_arvalid                 (bd_axi_arvalid),
  .s_axi_awaddr                  (bd_axi_awaddr),
  .s_axi_awburst                 (bd_axi_awburst),
  .s_axi_awcache                 (bd_axi_awcache),
  .s_axi_awid                    (bd_axi_awid),
  .s_axi_awlen                   (bd_axi_awlen),
  .s_axi_awlock                  (bd_axi_awlock),
  .s_axi_awprot                  (bd_axi_awprot),
  .s_axi_awqos                   (bd_axi_awqos),
  .s_axi_awready                 (bd_axi_awready),
  .s_axi_awsize                  (bd_axi_awsize),
  .s_axi_awvalid                 (bd_axi_awvalid),
  .s_axi_bid                     (bd_axi_bid),
  .s_axi_bready                  (bd_axi_bready),
  .s_axi_bresp                   (bd_axi_bresp),
  .s_axi_bvalid                  (bd_axi_bvalid),
  .s_axi_rdata                   (bd_axi_rdata),
  .s_axi_rid                     (bd_axi_rid),
  .s_axi_rlast                   (bd_axi_rlast),
  .s_axi_rready                  (bd_axi_rready),
  .s_axi_rresp                   (bd_axi_rresp),
  .s_axi_rvalid                  (bd_axi_rvalid),
  .s_axi_wdata                   (bd_axi_wdata),
  .s_axi_wlast                   (bd_axi_wlast),
  .s_axi_wready                  (bd_axi_wready),
  .s_axi_wstrb                   (bd_axi_wstrb),
  .s_axi_wvalid                  (bd_axi_wvalid)
);

`else // don't use ethernet
xlnx_bd_soc_wrapper  bd_soc (
  .DDR4_AXI_araddr               (ddr4_axi_araddr),
  .DDR4_AXI_arburst              (ddr4_axi_arburst),
  .DDR4_AXI_arcache              (ddr4_axi_arcache),
  .DDR4_AXI_arid                 (ddr4_axi_arid),
  .DDR4_AXI_arlen                (ddr4_axi_arlen),
  .DDR4_AXI_arlock               (ddr4_axi_arlock),
  .DDR4_AXI_arprot               (ddr4_axi_arprot),
  .DDR4_AXI_arqos                (ddr4_axi_arqos),
  .DDR4_AXI_arready              (ddr4_axi_arready),
  .DDR4_AXI_arregion             (ddr4_axi_arregion),
  .DDR4_AXI_arsize               (ddr4_axi_arsize),
  .DDR4_AXI_arvalid              (ddr4_axi_arvalid),
  .DDR4_AXI_awaddr               (ddr4_axi_awaddr),
  .DDR4_AXI_awburst              (ddr4_axi_awburst),
  .DDR4_AXI_awcache              (ddr4_axi_awcache),
  .DDR4_AXI_awid                 (ddr4_axi_awid),
  .DDR4_AXI_awlen                (ddr4_axi_awlen),
  .DDR4_AXI_awlock               (ddr4_axi_awlock),
  .DDR4_AXI_awprot               (ddr4_axi_awprot),
  .DDR4_AXI_awqos                (ddr4_axi_awqos),
  .DDR4_AXI_awready              (ddr4_axi_awready),
  .DDR4_AXI_awregion             (ddr4_axi_awregion),
  .DDR4_AXI_awsize               (ddr4_axi_awsize),
  .DDR4_AXI_awvalid              (ddr4_axi_awvalid),
  .DDR4_AXI_bid                  (ddr4_axi_bid),
  .DDR4_AXI_bready               (ddr4_axi_bready),
  .DDR4_AXI_bresp                (ddr4_axi_bresp),
  .DDR4_AXI_bvalid               (ddr4_axi_bvalid),
  .DDR4_AXI_rdata                (ddr4_axi_rdata),
  .DDR4_AXI_rid                  (ddr4_axi_rid),
  .DDR4_AXI_rlast                (ddr4_axi_rlast),
  .DDR4_AXI_rready               (ddr4_axi_rready),
  .DDR4_AXI_rresp                (ddr4_axi_rresp),
  .DDR4_AXI_rvalid               (ddr4_axi_rvalid),
  .DDR4_AXI_wdata                (ddr4_axi_wdata),
  .DDR4_AXI_wlast                (ddr4_axi_wlast),
  .DDR4_AXI_wready               (ddr4_axi_wready),
  .DDR4_AXI_wstrb                (ddr4_axi_wstrb),
  .DDR4_AXI_wvalid               (ddr4_axi_wvalid),
  
  .bd_soc_clk                    (clk_100M),
  .bd_soc_ddr_reset              (bd_soc_ddr_reset),
  .vio_cpu_reset                 (vio_cpu_reset),
  .core_reset                    (core_reset),
  .peripheral_aresetn            (peripheral_aresetn),

  // UART
  .rs232_uart_baudoutn           (              ),
  .rs232_uart_ctsn               (1'b1          ),
  .rs232_uart_dcdn               (1'b1          ),
  .rs232_uart_ddis               (              ),
  .rs232_uart_dsrn               (1'b1          ),
  .rs232_uart_dtrn               (              ),
  .rs232_uart_out1n              (              ),
  .rs232_uart_out2n              (              ),
  .rs232_uart_ri                 (1'b1          ),
  .rs232_uart_rtsn               (              ),
  .rs232_uart_rxrdyn             (              ),
  .rs232_uart_txrdyn             (              ),
  .rs232_uart_rxd                (rs232_uart_rxd),
  .rs232_uart_txd                (rs232_uart_txd),
  .uart_int                      (uart_int      ),
  
  // CPU AXI
  .s_axi_araddr                  (bd_axi_araddr),
  .s_axi_arburst                 (bd_axi_arburst),
  .s_axi_arcache                 (bd_axi_arcache),
  .s_axi_arid                    (bd_axi_arid),
  .s_axi_arlen                   (bd_axi_arlen),
  .s_axi_arlock                  (bd_axi_arlock),
  .s_axi_arprot                  (bd_axi_arprot),
  .s_axi_arqos                   (bd_axi_arqos),
  .s_axi_arready                 (bd_axi_arready),
  .s_axi_arsize                  (bd_axi_arsize),
  .s_axi_arvalid                 (bd_axi_arvalid),
  .s_axi_awaddr                  (bd_axi_awaddr),
  .s_axi_awburst                 (bd_axi_awburst),
  .s_axi_awcache                 (bd_axi_awcache),
  .s_axi_awid                    (bd_axi_awid),
  .s_axi_awlen                   (bd_axi_awlen),
  .s_axi_awlock                  (bd_axi_awlock),
  .s_axi_awprot                  (bd_axi_awprot),
  .s_axi_awqos                   (bd_axi_awqos),
  .s_axi_awready                 (bd_axi_awready),
  .s_axi_awsize                  (bd_axi_awsize),
  .s_axi_awvalid                 (bd_axi_awvalid),
  .s_axi_bid                     (bd_axi_bid),
  .s_axi_bready                  (bd_axi_bready),
  .s_axi_bresp                   (bd_axi_bresp),
  .s_axi_bvalid                  (bd_axi_bvalid),
  .s_axi_rdata                   (bd_axi_rdata),
  .s_axi_rid                     (bd_axi_rid),
  .s_axi_rlast                   (bd_axi_rlast),
  .s_axi_rready                  (bd_axi_rready),
  .s_axi_rresp                   (bd_axi_rresp),
  .s_axi_rvalid                  (bd_axi_rvalid),
  .s_axi_wdata                   (bd_axi_wdata),
  .s_axi_wlast                   (bd_axi_wlast),
  .s_axi_wready                  (bd_axi_wready),
  .s_axi_wstrb                   (bd_axi_wstrb),
  .s_axi_wvalid                  (bd_axi_wvalid)
);
`endif


xlnx_ddr4_cconvt ddr4_clock_converter (
  .s_axi_aclk                    (clk_100M),       
  .s_axi_aresetn                 (peripheral_aresetn),
  .s_axi_awid                    (ddr4_axi_awid),
  .s_axi_awaddr                  (ddr4_axi_awaddr),
  .s_axi_awlen                   (ddr4_axi_awlen),
  .s_axi_awsize                  (ddr4_axi_awsize),
  .s_axi_awburst                 (ddr4_axi_awburst),
  .s_axi_awlock                  (ddr4_axi_awlock),
  .s_axi_awcache                 (ddr4_axi_awcache),
  .s_axi_awprot                  (ddr4_axi_awprot),
  .s_axi_awregion                (ddr4_axi_awregion),
  .s_axi_awqos                   (ddr4_axi_awqos),
  .s_axi_awvalid                 (ddr4_axi_awvalid),
  .s_axi_awready                 (ddr4_axi_awready),
  .s_axi_wdata                   (ddr4_axi_wdata),
  .s_axi_wstrb                   (ddr4_axi_wstrb),
  .s_axi_wlast                   (ddr4_axi_wlast),
  .s_axi_wvalid                  (ddr4_axi_wvalid),
  .s_axi_wready                  (ddr4_axi_wready),
  .s_axi_bid                     (ddr4_axi_bid),
  .s_axi_bresp                   (ddr4_axi_bresp),
  .s_axi_bvalid                  (ddr4_axi_bvalid),
  .s_axi_bready                  (ddr4_axi_bready),
  .s_axi_arid                    (ddr4_axi_arid),
  .s_axi_araddr                  (ddr4_axi_araddr),
  .s_axi_arlen                   (ddr4_axi_arlen),
  .s_axi_arsize                  (ddr4_axi_arsize),
  .s_axi_arburst                 (ddr4_axi_arburst),
  .s_axi_arlock                  (ddr4_axi_arlock),
  .s_axi_arcache                 (ddr4_axi_arcache),
  .s_axi_arprot                  (ddr4_axi_arprot),
  .s_axi_arregion                (ddr4_axi_arregion),
  .s_axi_arqos                   (ddr4_axi_arqos),
  .s_axi_arvalid                 (ddr4_axi_arvalid),
  .s_axi_arready                 (ddr4_axi_arready),
  .s_axi_rid                     (ddr4_axi_rid),
  .s_axi_rdata                   (ddr4_axi_rdata),
  .s_axi_rresp                   (ddr4_axi_rresp),
  .s_axi_rlast                   (ddr4_axi_rlast),
  .s_axi_rvalid                  (ddr4_axi_rvalid),
  .s_axi_rready                  (ddr4_axi_rready),
  
  .m_axi_aclk                    (ddr4_300M_clk),        
  .m_axi_aresetn                 (DDR4_axi_aresetn),
  .m_axi_awid                    (DDR4_axi_awid),
  .m_axi_awaddr                  (DDR4_axi_awaddr),
  .m_axi_awlen                   (DDR4_axi_awlen),
  .m_axi_awsize                  (DDR4_axi_awsize),
  .m_axi_awburst                 (DDR4_axi_awburst),
  .m_axi_awlock                  (DDR4_axi_awlock),
  .m_axi_awcache                 (DDR4_axi_awcache),
  .m_axi_awprot                  (DDR4_axi_awprot),
  .m_axi_awregion                (DDR4_axi_awregion),
  .m_axi_awqos                   (DDR4_axi_awqos),
  .m_axi_awvalid                 (DDR4_axi_awvalid),
  .m_axi_awready                 (DDR4_axi_awready),
  .m_axi_wdata                   (DDR4_axi_wdata),
  .m_axi_wstrb                   (DDR4_axi_wstrb),
  .m_axi_wlast                   (DDR4_axi_wlast),
  .m_axi_wvalid                  (DDR4_axi_wvalid),
  .m_axi_wready                  (DDR4_axi_wready),
  .m_axi_bid                     (DDR4_axi_bid[0]),
  .m_axi_bresp                   (DDR4_axi_bresp),
  .m_axi_bvalid                  (DDR4_axi_bvalid),
  .m_axi_bready                  (DDR4_axi_bready),
  .m_axi_arid                    (DDR4_axi_arid),
  .m_axi_araddr                  (DDR4_axi_araddr),
  .m_axi_arlen                   (DDR4_axi_arlen),
  .m_axi_arsize                  (DDR4_axi_arsize),
  .m_axi_arburst                 (DDR4_axi_arburst),
  .m_axi_arlock                  (DDR4_axi_arlock),
  .m_axi_arcache                 (DDR4_axi_arcache),
  .m_axi_arprot                  (DDR4_axi_arprot),
  .m_axi_arregion                (DDR4_axi_arregion),
  .m_axi_arqos                   (DDR4_axi_arqos),
  .m_axi_arvalid                 (DDR4_axi_arvalid),
  .m_axi_arready                 (DDR4_axi_arready),
  .m_axi_rid                     (DDR4_axi_rid[0]),
  .m_axi_rdata                   (DDR4_axi_rdata),
  .m_axi_rresp                   (DDR4_axi_rresp),
  .m_axi_rlast                   (DDR4_axi_rlast),
  .m_axi_rvalid                  (DDR4_axi_rvalid),
  .m_axi_rready                  (DDR4_axi_rready)
);


xlnx_ddr4_reset  ddr4_reset (
  .slowest_sync_clk              (ddr4_300M_clk   ),
  .ext_reset_in                  (bd_soc_ddr_reset),
  .aux_reset_in                  (1'b0            ),
  .mb_debug_sys_rst              (1'b0            ),
  .dcm_locked                    (1'b1            ),
  // output
  .mb_reset                      (                ),
  .bus_struct_reset              (                ),
  .peripheral_reset              (                ),
  .interconnect_aresetn          (                ),
  .peripheral_aresetn            (DDR4_axi_aresetn)
);

xlnx_ddr4  ddr4 (
  .sys_rst                       (reset           ),
  .dbg_clk                       (                ),
  .addn_ui_clkout1               (clk_100M        ),
  .addn_ui_clkout2               (clk_50M         ),
  .c0_init_calib_complete        (c0_init_calib_complete),
  .c0_sys_clk_p                  (c0_sys_clk_p    ),
  .c0_sys_clk_n                  (c0_sys_clk_n    ),
  .dbg_bus                       (                ),
  .c0_ddr4_adr                   (c0_ddr4_adr     ),
  .c0_ddr4_ba                    (c0_ddr4_ba      ),
  .c0_ddr4_cke                   (c0_ddr4_cke     ),
  .c0_ddr4_cs_n                  (c0_ddr4_cs_n    ),
  .c0_ddr4_dm_dbi_n              (c0_ddr4_dm_n    ),
  .c0_ddr4_dq                    (c0_ddr4_dq      ),
  .c0_ddr4_dqs_c                 (c0_ddr4_dqs_c   ),
  .c0_ddr4_dqs_t                 (c0_ddr4_dqs_t   ),
  .c0_ddr4_odt                   (c0_ddr4_odt     ),
  .c0_ddr4_bg                    (c0_ddr4_bg      ),
  .c0_ddr4_reset_n               (c0_ddr4_reset_n ),
  .c0_ddr4_act_n                 (c0_ddr4_act_n   ),
  .c0_ddr4_ck_c                  (c0_ddr4_ck_c    ),
  .c0_ddr4_ck_t                  (c0_ddr4_ck_t    ),
  .c0_ddr4_ui_clk                (ddr4_300M_clk   ),
  .c0_ddr4_ui_clk_sync_rst       (bd_soc_ddr_reset),
  .c0_ddr4_aresetn               (DDR4_axi_aresetn),
  .c0_ddr4_s_axi_awid            ({4'b0, DDR4_axi_awid}),
  .c0_ddr4_s_axi_awaddr          (DDR4_axi_awaddr[33:0]),
  .c0_ddr4_s_axi_awlen           (DDR4_axi_awlen  ),
  .c0_ddr4_s_axi_awsize          (DDR4_axi_awsize ),
  .c0_ddr4_s_axi_awburst         (DDR4_axi_awburst),
  .c0_ddr4_s_axi_awlock          (DDR4_axi_awlock ),
  .c0_ddr4_s_axi_awcache         (DDR4_axi_awcache),
  .c0_ddr4_s_axi_awprot          (DDR4_axi_awprot ),
  .c0_ddr4_s_axi_awqos           (DDR4_axi_awqos  ),
  .c0_ddr4_s_axi_awvalid         (DDR4_axi_awvalid),
  .c0_ddr4_s_axi_awready         (DDR4_axi_awready),
  .c0_ddr4_s_axi_wdata           (DDR4_axi_wdata  ),
  .c0_ddr4_s_axi_wstrb           (DDR4_axi_wstrb  ),
  .c0_ddr4_s_axi_wlast           (DDR4_axi_wlast  ),
  .c0_ddr4_s_axi_wvalid          (DDR4_axi_wvalid ),
  .c0_ddr4_s_axi_wready          (DDR4_axi_wready ),
  .c0_ddr4_s_axi_bready          (DDR4_axi_bready ),
  .c0_ddr4_s_axi_bid             (DDR4_axi_bid    ),
  .c0_ddr4_s_axi_bresp           (DDR4_axi_bresp  ),
  .c0_ddr4_s_axi_bvalid          (DDR4_axi_bvalid ),
  .c0_ddr4_s_axi_arid            ({4'b0, DDR4_axi_arid}),
  .c0_ddr4_s_axi_araddr          (DDR4_axi_araddr[33:0]),
  .c0_ddr4_s_axi_arlen           (DDR4_axi_arlen  ),
  .c0_ddr4_s_axi_arsize          (DDR4_axi_arsize ),
  .c0_ddr4_s_axi_arburst         (DDR4_axi_arburst),
  .c0_ddr4_s_axi_arlock          (DDR4_axi_arlock ),
  .c0_ddr4_s_axi_arcache         (DDR4_axi_arcache),
  .c0_ddr4_s_axi_arprot          (DDR4_axi_arprot ),
  .c0_ddr4_s_axi_arqos           (DDR4_axi_arqos  ),
  .c0_ddr4_s_axi_arvalid         (DDR4_axi_arvalid),
  .c0_ddr4_s_axi_arready         (DDR4_axi_arready),
  .c0_ddr4_s_axi_rready          (DDR4_axi_rready ),
  .c0_ddr4_s_axi_rlast           (DDR4_axi_rlast  ),
  .c0_ddr4_s_axi_rvalid          (DDR4_axi_rvalid ),
  .c0_ddr4_s_axi_rresp           (DDR4_axi_rresp  ),
  .c0_ddr4_s_axi_rid             (DDR4_axi_rid    ),
  .c0_ddr4_s_axi_rdata           (DDR4_axi_rdata  )
);


// for upload kernel to ddr memory.
xlnx_vio xlnx_vio(
   .clk                          (clk_100M        ),
   .probe_out0                   (vio_cpu_reset   ),
   .probe_out1                   (vio_system_reset),
   .probe_out2                   (vio_ddr_reset   )
);

endmodule
