
module Top(
    input dma_clk,
    input dma_aresetn,
    input axi_clk,
    input axi_resetn,

    input  [ 63:0] DIFF_AXI_araddr,
    input  [  1:0] DIFF_AXI_arburst,
    input  [  3:0] DIFF_AXI_arcache,
    input  [  3:0] DIFF_AXI_arid,
    input  [  7:0] DIFF_AXI_arlen,
    input  [  0:0] DIFF_AXI_arlock,
    input  [  2:0] DIFF_AXI_arprot,
    input  [  3:0] DIFF_AXI_arqos,
    output [  0:0] DIFF_AXI_arready,
    input  [  3:0] DIFF_AXI_arregion,
    input  [  2:0] DIFF_AXI_arsize,
    input  [  0:0] DIFF_AXI_arvalid,
    input  [ 63:0] DIFF_AXI_awaddr,
    input  [  1:0] DIFF_AXI_awburst,
    input  [  3:0] DIFF_AXI_awcache,
    input  [  3:0] DIFF_AXI_awid,
    input  [  7:0] DIFF_AXI_awlen,
    input  [  0:0] DIFF_AXI_awlock,
    input  [  2:0] DIFF_AXI_awprot,
    input  [  3:0] DIFF_AXI_awqos,
    output [  0:0] DIFF_AXI_awready,
    input  [  3:0] DIFF_AXI_awregion,
    input  [  2:0] DIFF_AXI_awsize,
    input  [  0:0] DIFF_AXI_awvalid,
    output [  3:0] DIFF_AXI_bid,
    input  [  0:0] DIFF_AXI_bready,
    output [  1:0] DIFF_AXI_bresp,
    output [  0:0] DIFF_AXI_bvalid,
    output [511:0] DIFF_AXI_rdata,
    output [  3:0] DIFF_AXI_rid,
    output [  0:0] DIFF_AXI_rlast,
    input  [  0:0] DIFF_AXI_rready,
    output [  1:0] DIFF_AXI_rresp,
    output [  0:0] DIFF_AXI_rvalid,
    input  [511:0] DIFF_AXI_wdata,
    input  [  0:0] DIFF_AXI_wlast,
    output [  0:0] DIFF_AXI_wready,
    input  [ 63:0] DIFF_AXI_wstrb,
    input  [  0:0] DIFF_AXI_wvalid,
    `CSRRegState_in
    `GRegState_in
    `TLBEvent_in(0)
    `TLBEvent_in(1)
    `LoadEvent_in(0)
    `StoreEvent_in(0)
    `InstrCommit_in(0)
    `ExcpEvent_in
    `FPRegState_in

    output stall
);

    xdma_diff xdma_diff(
        .axi_clk(axi_clk),
        .axi_resetn(axi_resetn),
        .dma_clk(dma_clk),
        .dma_aresetn(dma_aresetn),
        `CSRRegState_connect
        `GRegState_connect
        `TLBEvent_connect(0)
        `TLBEvent_connect(1)
        `LoadEvent_connect(0)
        `StoreEvent_connect(0)
        `InstrCommit_connect(0)
        `ExcpEvent_connect
        `FPRegState_connect
        .DIFF_AXI_araddr(DIFF_AXI_araddr),
        .DIFF_AXI_arburst(DIFF_AXI_arburst),
        .DIFF_AXI_arcache(DIFF_AXI_arcache),
        .DIFF_AXI_arid(DIFF_AXI_arid),
        .DIFF_AXI_arlen(DIFF_AXI_arlen),
        .DIFF_AXI_arlock(DIFF_AXI_arlock),
        .DIFF_AXI_arprot(DIFF_AXI_arprot),
        .DIFF_AXI_arqos(DIFF_AXI_arqos),
        .DIFF_AXI_arready(DIFF_AXI_arready),
        .DIFF_AXI_arregion(DIFF_AXI_arregion),
        .DIFF_AXI_arsize(DIFF_AXI_arsize),
        .DIFF_AXI_arvalid(DIFF_AXI_arvalid),
        .DIFF_AXI_awaddr(DIFF_AXI_awaddr),
        .DIFF_AXI_awburst(DIFF_AXI_awburst),
        .DIFF_AXI_awcache(DIFF_AXI_awcache),
        .DIFF_AXI_awid(DIFF_AXI_awid),
        .DIFF_AXI_awlen(DIFF_AXI_awlen),
        .DIFF_AXI_awlock(DIFF_AXI_awlock),
        .DIFF_AXI_awprot(DIFF_AXI_awprot),
        .DIFF_AXI_awqos(DIFF_AXI_awqos),
        .DIFF_AXI_awready(DIFF_AXI_awready),
        .DIFF_AXI_awregion(DIFF_AXI_awregion),
        .DIFF_AXI_awsize(DIFF_AXI_awsize),
        .DIFF_AXI_awvalid(DIFF_AXI_awvalid),
        .DIFF_AXI_bid(DIFF_AXI_bid),
        .DIFF_AXI_bready(DIFF_AXI_bready),
        .DIFF_AXI_bresp(DIFF_AXI_bresp),
        .DIFF_AXI_bvalid(DIFF_AXI_bvalid),
        .DIFF_AXI_rdata(DIFF_AXI_rdata),
        .DIFF_AXI_rid(DIFF_AXI_rid),
        .DIFF_AXI_rlast(DIFF_AXI_rlast),
        .DIFF_AXI_rready(DIFF_AXI_rready),
        .DIFF_AXI_rresp(DIFF_AXI_rresp),
        .DIFF_AXI_rvalid(DIFF_AXI_rvalid),
        .DIFF_AXI_wdata(DIFF_AXI_wdata),
        .DIFF_AXI_wlast(DIFF_AXI_wlast),
        .DIFF_AXI_wready(DIFF_AXI_wready),
        .DIFF_AXI_wstrb(DIFF_AXI_wstrb),
        .DIFF_AXI_wvalid(DIFF_AXI_wvalid),
        .stall(stall)
    );
endmodule