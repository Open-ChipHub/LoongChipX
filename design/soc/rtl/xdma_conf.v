
`define XDMA_STALL_ADDR 12'h200
`define XDMA_RESET_ADDR 12'h000

module xdma_conf (
    input clk,
    input rstn,

    input  [ 63:0] CFG_AXI_araddr,
    input  [  1:0] CFG_AXI_arburst,
    input  [  3:0] CFG_AXI_arcache,
    input  [  3:0] CFG_AXI_arid,
    input  [  7:0] CFG_AXI_arlen,
    input  [  0:0] CFG_AXI_arlock,
    input  [  2:0] CFG_AXI_arprot,
    input  [  3:0] CFG_AXI_arqos,
    output [  0:0] CFG_AXI_arready,
    input  [  3:0] CFG_AXI_arregion,
    input  [  2:0] CFG_AXI_arsize,
    input  [  0:0] CFG_AXI_arvalid,
    input  [ 63:0] CFG_AXI_awaddr,
    input  [  1:0] CFG_AXI_awburst,
    input  [  3:0] CFG_AXI_awcache,
    input  [  3:0] CFG_AXI_awid,
    input  [  7:0] CFG_AXI_awlen,
    input  [  0:0] CFG_AXI_awlock,
    input  [  2:0] CFG_AXI_awprot,
    input  [  3:0] CFG_AXI_awqos,
    output [  0:0] CFG_AXI_awready,
    input  [  3:0] CFG_AXI_awregion,
    input  [  2:0] CFG_AXI_awsize,
    input  [  0:0] CFG_AXI_awvalid,
    output [  3:0] CFG_AXI_bid,
    input  [  0:0] CFG_AXI_bready,
    output [  1:0] CFG_AXI_bresp,
    output [  0:0] CFG_AXI_bvalid,
    output [511:0] CFG_AXI_rdata,
    output [  3:0] CFG_AXI_rid,
    output [  0:0] CFG_AXI_rlast,
    input  [  0:0] CFG_AXI_rready,
    output [  1:0] CFG_AXI_rresp,
    output [  0:0] CFG_AXI_rvalid,
    input  [511:0] CFG_AXI_wdata,
    input  [  0:0] CFG_AXI_wlast,
    output [  0:0] CFG_AXI_wready,
    input  [ 63:0] CFG_AXI_wstrb,
    input  [  0:0] CFG_AXI_wvalid,

    output dma_reset
);

    reg conf_reset;
    reg awstart;
    reg wstart;
    reg [11:0] cfg_addr;
    reg [3:0] bid;

    wire aw_hsk = CFG_AXI_awvalid & CFG_AXI_awready;
    wire w_hsk = CFG_AXI_wvalid & CFG_AXI_wready;
    wire b_hsk = CFG_AXI_bvalid & CFG_AXI_bready;

    always @(posedge clk) begin
        if (aw_hsk) begin
            cfg_addr[11:0] <= CFG_AXI_awaddr[11:0];
            bid[3:0] <= CFG_AXI_awid[3:0];
        end
    end

    assign CFG_AXI_awready = !awstart;
    assign CFG_AXI_wready = !wstart;
    assign CFG_AXI_bvalid = awstart & wstart;
    assign CFG_AXI_bid = bid;
    assign CFG_AXI_bresp = 0;
    assign CFG_AXI_arready = 1'b0;
    assign CFG_AXI_rvalid = 1'b0;
    assign CFG_AXI_rdata = 0;
    assign CFG_AXI_rresp = 0;
    assign CFG_AXI_rid = 0;
    assign CFG_AXI_rlast = 0;

    assign dma_reset = conf_reset;

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            conf_reset <= 1'b0;
            awstart <= 1'b0;
            wstart <= 1'b0;
        end else begin
            if (aw_hsk) begin
                awstart <= 1'b1;
            end
            if (awstart && w_hsk) begin
                wstart <= 1'b1;
            end
            if (b_hsk) begin
                awstart <= 1'b0;
                wstart  <= 1'b0;
            end

            if (awstart && w_hsk) begin
                if (cfg_addr == `XDMA_RESET_ADDR && CFG_AXI_wstrb[0]) begin
                    conf_reset <= CFG_AXI_wdata[0];
                end
            end
        end
    end



endmodule
