
// xlnx_xdma_fifo: Asynchronous FIFO with depth 1024, width 512
// prog_full asserts when FIFO has 900 or more entries
module xlnx_xdma_fifo (
    input wire wr_clk,
    input wire rd_clk,
    input wire srst,
    input wire [511:0] din,
    input wire wr_en,
    output wire full,
    output reg [511:0] dout,
    input wire rd_en,
    output wire empty,
    output wire prog_full,
    output wire wr_rst_busy,
    output wire rd_rst_busy
);
    // FIFO parameters
    parameter DEPTH = 1024;
    parameter WIDTH = 512;
    parameter PROG_FULL_THRESH = 900;
    parameter ADDR_WIDTH = 10;  // 2^10 = 1024

    // FIFO memory
    reg [WIDTH-1:0] fifo_mem[0:DEPTH-1];

    // Write and read pointers (gray coded)
    reg [ADDR_WIDTH:0] wr_ptr;
    reg [ADDR_WIDTH:0] rd_ptr;
    reg [ADDR_WIDTH:0] wr_ptr_gray;
    reg [ADDR_WIDTH:0] rd_ptr_gray;
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync1;
    reg [ADDR_WIDTH:0] wr_ptr_gray_sync2;
    reg [ADDR_WIDTH:0] rd_ptr_gray_sync1;
    reg [ADDR_WIDTH:0] rd_ptr_gray_sync2;

    // Binary pointers for comparison
    reg [ADDR_WIDTH:0] wr_ptr_bin;
    reg [ADDR_WIDTH:0] rd_ptr_bin;
    reg [ADDR_WIDTH:0] wr_ptr_bin_sync;
    reg [ADDR_WIDTH:0] rd_ptr_bin_sync;

    // Internal signals
    reg [ADDR_WIDTH:0] fifo_count;
    reg full_int;
    reg empty_int;
    reg prog_full_int;
    reg wr_rst_busy_int;
    reg rd_rst_busy_int;

    // Reset logic
    reg [3:0] wr_rst_cnt;
    reg [3:0] rd_rst_cnt;

    // Write domain: reset handling
    always @(posedge wr_clk or posedge srst) begin
        if (srst) begin
            wr_rst_cnt <= 4'h0;
            wr_rst_busy_int <= 1'b0;
            wr_ptr <= 0;
            wr_ptr_gray <= 0;
            wr_ptr_bin <= 0;
        end else begin
            if (wr_rst_cnt < 4'h1) begin
                wr_rst_cnt <= wr_rst_cnt + 1;
                wr_rst_busy_int <= 1'b0;
            end else begin
                wr_rst_busy_int <= 1'b0;
            end
        end
    end

    // Read domain: reset handling
    always @(posedge rd_clk or posedge srst) begin
        if (srst) begin
            rd_rst_cnt <= 4'h0;
            rd_rst_busy_int <= 1'b0;
            rd_ptr <= 0;
            rd_ptr_gray <= 0;
            rd_ptr_bin <= 0;
        end else begin
            if (rd_rst_cnt < 4'h1) begin
                rd_rst_cnt <= rd_rst_cnt + 1;
                rd_rst_busy_int <= 1'b0;
            end else begin
                rd_rst_busy_int <= 1'b0;
            end
        end
    end

    // Write pointer increment and gray coding
    always @(posedge wr_clk or posedge srst) begin
        if (srst) begin
            wr_ptr_bin  <= 0;
            wr_ptr_gray <= 0;
        end else if (wr_en && !full_int && !wr_rst_busy_int) begin
            wr_ptr_bin  <= wr_ptr_bin + 1;
            wr_ptr_gray <= (wr_ptr_bin + 1) ^ ((wr_ptr_bin + 1) >> 1);
        end
    end

    // Read pointer increment and gray coding
    always @(posedge rd_clk or posedge srst) begin
        if (srst) begin
            rd_ptr_bin  <= 0;
            rd_ptr_gray <= 0;
        end else if (rd_en && !empty_int && !rd_rst_busy_int) begin
            rd_ptr_bin  <= rd_ptr_bin + 1;
            rd_ptr_gray <= (rd_ptr_bin + 1) ^ ((rd_ptr_bin + 1) >> 1);
        end
    end

    // Write memory
    always @(posedge wr_clk) begin
        if (wr_en && !full_int && !wr_rst_busy_int) begin
            fifo_mem[wr_ptr_bin[ADDR_WIDTH-1:0]] <= din;
        end
    end

    // Read memory
    always @(posedge rd_clk) begin
        if (rd_en && !empty_int && !rd_rst_busy_int)
            dout <= fifo_mem[rd_ptr_bin[ADDR_WIDTH-1:0]];
    end

    // Synchronize gray pointers
    // Write domain to read domain
    always @(posedge rd_clk or posedge srst) begin
        if (srst) begin
            wr_ptr_gray_sync1 <= 0;
            wr_ptr_gray_sync2 <= 0;
        end else begin
            wr_ptr_gray_sync1 <= wr_ptr_gray;
            wr_ptr_gray_sync2 <= wr_ptr_gray_sync1;
        end
    end

    // Read domain to write domain
    always @(posedge wr_clk or posedge srst) begin
        if (srst) begin
            rd_ptr_gray_sync1 <= 0;
            rd_ptr_gray_sync2 <= 0;
        end else begin
            rd_ptr_gray_sync1 <= rd_ptr_gray;
            rd_ptr_gray_sync2 <= rd_ptr_gray_sync1;
        end
    end

    // Convert gray to binary for write domain
    integer i;
    always @* begin
        wr_ptr_bin_sync[ADDR_WIDTH] = wr_ptr_gray_sync2[ADDR_WIDTH];
        for (i = ADDR_WIDTH - 1; i >= 0; i = i - 1) begin
            wr_ptr_bin_sync[i] = wr_ptr_bin_sync[i+1] ^ wr_ptr_gray_sync2[i];
        end
    end

    // Convert gray to binary for read domain
    always @* begin
        rd_ptr_bin_sync[ADDR_WIDTH] = rd_ptr_gray_sync2[ADDR_WIDTH];
        for (i = ADDR_WIDTH - 1; i >= 0; i = i - 1) begin
            rd_ptr_bin_sync[i] = rd_ptr_bin_sync[i+1] ^ rd_ptr_gray_sync2[i];
        end
    end

    // Calculate FIFO count in write domain
    always @* begin
        if (wr_ptr_bin[ADDR_WIDTH] == rd_ptr_bin_sync[ADDR_WIDTH]) begin
            fifo_count = wr_ptr_bin - rd_ptr_bin_sync;
        end else begin
            fifo_count = (wr_ptr_bin & ((1 << ADDR_WIDTH) - 1)) + ((1 << ADDR_WIDTH) - (rd_ptr_bin_sync & ((1 << ADDR_WIDTH) - 1)));
        end
    end

    // Full, empty, and prog_full logic
    always @* begin
        // Full condition: write pointer gray equals read pointer gray with MSB inverted
        full_int = (wr_ptr_gray == {~rd_ptr_gray_sync2[ADDR_WIDTH], rd_ptr_gray_sync2[ADDR_WIDTH-1:0]}) && !wr_rst_busy_int;
        // Empty condition: read pointer gray equals write pointer gray
        empty_int = (rd_ptr_gray == wr_ptr_gray_sync2) && !rd_rst_busy_int;
        // prog_full when count >= PROG_FULL_THRESH
        prog_full_int = (fifo_count >= PROG_FULL_THRESH) && !wr_rst_busy_int;
    end

    // Assign outputs
    assign full = full_int;
    assign empty = empty_int;
    assign prog_full = prog_full_int;
    assign wr_rst_busy = wr_rst_busy_int;
    assign rd_rst_busy = rd_rst_busy_int;

endmodule