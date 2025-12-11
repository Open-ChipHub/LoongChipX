
module xdma_fifo_tb();

    logic dma_clk;
    logic axi_clk;
    logic srst;
    logic rd_en;
    logic [511:0] rdata;
    logic wr_en;
    logic [511:0] wdata;
    logic wr_rst_busy;
    logic rd_rst_busy;
    logic prog_full;
    logic full;
    logic empty;

    always #10 axi_clk = ~axi_clk;
    assign #2 dma_clk = ~dma_clk;

    xlnx_xdma_fifo fifo(
        .wr_clk(axi_clk),
        .rd_clk(dma_clk),
        .srst(srst),
        .din(wdata),
        .wr_en(wr_en),
        .full(full),
        .dout(rdata),
        .rd_en(rd_en),
        .empty(empty),
        .prog_full(prog_full),
        .wr_rst_busy(wr_rst_busy),
        .rd_rst_busy(rd_rst_busy)
    );

    initial begin
        axi_clk = 1;
        dma_clk = 1;
        srst = 1;
        wdata = 512'h12345678;
        rd_en = 0;
        wr_en = 0;
        #100;
        srst = 0;
        #100;
        wr_en = 1;
        #20000;
        rd_en = 1;
        wr_en = 0;
        #100;
        $finish;
    end

endmodule