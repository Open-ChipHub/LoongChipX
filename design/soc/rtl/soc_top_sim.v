
`include "board.h"

module soc_top #(
    parameter int unsigned AXI_ID_WIDTH      = 8,
    parameter int unsigned AXI_ADDR_WIDTH    = 40,
    parameter int unsigned AXI_DATA_WIDTH    = 128,
    parameter int unsigned AXI_USER_WIDTH    = 2
)();

wire                            axi_aw_valid;
wire                            axi_aw_ready;
wire   [AXI_ADDR_WIDTH-1:0]     axi_aw_addr;
wire   [AXI_ID_WIDTH-1  :0]     axi_aw_id;
wire   [7:0]                    axi_aw_len;
wire   [2:0]                    axi_aw_size;
wire   [1:0]                    axi_aw_burst;
wire   [3:0]                    axi_aw_cache;
wire   [2:0]                    axi_aw_prot;
wire                            axi_w_valid;
wire                            axi_w_ready;
wire   [AXI_ID_WIDTH-1  :0]     axi_w_id;
wire   [AXI_DATA_WIDTH-1:0]     axi_w_data;
wire   [15:0]                   axi_w_strb;
wire                            axi_w_last;
wire                            axi_b_valid;
wire                            axi_b_ready;
wire   [AXI_ID_WIDTH-1  :0]     axi_b_id;
wire   [1:0]                    axi_b_resp;
wire                            axi_ar_valid;
wire                            axi_ar_ready;
wire   [AXI_ADDR_WIDTH-1:0]     axi_ar_addr;
wire   [AXI_ID_WIDTH-1  :0]     axi_ar_id;
wire   [7:0]                    axi_ar_len;
wire   [2:0]                    axi_ar_size;
wire   [1:0]                    axi_ar_burst;
wire   [3:0]                    axi_ar_cache;
wire   [2:0]                    axi_ar_prot;
wire                            axi_r_valid;
wire                            axi_r_ready;
wire   [AXI_DATA_WIDTH-1:0]     axi_r_data;
wire   [AXI_ID_WIDTH-1  :0]     axi_r_id;
wire   [1:0]                    axi_r_resp;
wire                            axi_r_last;
wire   [7:0]                    ext_interrupt;

reg    gl_clk;
reg    reset;

reg    ext_int_0;

initial begin 
  gl_clk = 0;
  forever begin
    #(2) gl_clk = ~gl_clk;
  end
end


initial begin
  reset = 1;
  #10;
  reset = 1;
  #80;
  reset = 0;

  // #300000
  // ext_int_0 = 1;
  // #300010
  // ext_int_0 = 0;


  // #2000000
  // $finish;  
end

reg    jrst_b;
initial
begin
  jrst_b = 1;
  #400;
  jrst_b = 0;
  #400;
  jrst_b = 1;
end


`ifdef VERDI_DUMP
initial begin
      /// method 1: this will dump only ct_top module
      $fsdbDumpon;
      $fsdbDumpfile("soc_top.fsdb");
      $fsdbDumpvars(0, soc_top);

      /// method 2: this will dump all module
      // $fsdbDumpvars();
end
`endif

wire             had_pad_jtg_tdo;      
wire             had_pad_jtg_tdo_en;  
wire             pad_cpu_rst_b;
wire    [1:0]    biu_pad_lpmd_b;
wire             pad_had_jtg_tclk;
wire             pad_had_jtg_tdi;   
wire             pad_had_jtg_trst_b;

wire    [39:0]   core_in_interrupt;

assign  pad_had_jtg_tclk  = gl_clk;
assign	pad_cpu_rst_b = ~reset;
assign  pad_had_jtg_tdi   = '0;

assign  core_in_interrupt[39:0] = {40'b0};
assign  ext_interrupt[7:0] = {1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, ext_int_0};


//----------------------------------------------------------
//                     Module Instance
//----------------------------------------------------------
cpu_subsystem  cpu_subsystem (
  // AR
  .biu_pad_araddr        (axi_ar_addr       ),
  .biu_pad_arburst       (axi_ar_burst      ),
  .biu_pad_arcache       (axi_ar_cache      ),
  .biu_pad_arid          (axi_ar_id         ),
  .biu_pad_arlen         (axi_ar_len        ),
  .biu_pad_arlock        (axi_ar_lock       ),
  .biu_pad_arprot        (axi_ar_prot       ),
  .biu_pad_arsize        (axi_ar_size       ),
  .biu_pad_arvalid       (axi_ar_valid      ),
  .pad_biu_arready       (axi_ar_ready      ),
  
  // AW
  .biu_pad_awaddr        (axi_aw_addr       ),
  .biu_pad_awburst       (axi_aw_burst      ),
  .biu_pad_awcache       (axi_aw_cache      ),
  .biu_pad_awid          (axi_aw_id         ),
  .biu_pad_awlen         (axi_aw_len        ),
  .biu_pad_awlock        (axi_aw_lock       ),
  .biu_pad_awprot        (axi_aw_prot       ),
  .biu_pad_awsize        (axi_aw_size       ),
  .biu_pad_awvalid       (axi_aw_valid      ),
  .pad_biu_awready       (axi_aw_ready      ),
  
  // W
  .biu_pad_wdata         (axi_w_data        ),
  .biu_pad_wid           (axi_w_id          ),
  .biu_pad_wlast         (axi_w_last        ),
  .biu_pad_wstrb         (axi_w_strb        ),
  .biu_pad_wvalid        (axi_w_valid       ),
  .pad_biu_wready        (axi_w_ready       ),
  
  // B
  .biu_pad_bready        (axi_b_ready       ),
  .pad_biu_bid           (axi_b_id          ),
  .pad_biu_bresp         (axi_b_resp        ),
  .pad_biu_bvalid        (axi_b_valid       ),
  
  // R
  .biu_pad_rready        (axi_r_ready       ),
  .pad_biu_rdata         (axi_r_data        ),
  .pad_biu_rid           (axi_r_id          ),
  .pad_biu_rlast         (axi_r_last        ),
  .pad_biu_rresp         ({2'b0,axi_r_resp} ),
  .pad_biu_rvalid        (axi_r_valid       ),

  /// MISC
  .axim_clk_en           (1'b1              ),
  .biu_pad_lpmd_b        (biu_pad_lpmd_b    ),
  .had_pad_jtg_tdo       (                  ),
  .had_pad_jtg_tdo_en    (                  ),
  .i_pad_jtg_tms         (                  ),  /// No Input
  .pad_cpu_rst_b         (pad_cpu_rst_b     ),
  .pad_yy_dft_clk_rst_b  (pad_cpu_rst_b     ),
  .pad_had_jtg_tclk      (pad_had_jtg_tclk  ),
  .pad_had_jtg_tdi       ('0      			    ),
  .pad_had_jtg_trst_b    (jrst_b            ),
  .pll_cpu_clk           (gl_clk        	  ),
  .ext_interrupt         (ext_interrupt     ),
  .xx_intc_vld           (core_in_interrupt )
);


logic                        req;
logic                        we;
logic [AXI_ADDR_WIDTH-1:0]   addr;
logic [AXI_DATA_WIDTH/8-1:0] be;
logic [AXI_DATA_WIDTH-1:0]   rdata;
logic [AXI_DATA_WIDTH-1:0]   wdata;

axi_mem_if #(
    .AXI_ID_WIDTH    (AXI_ID_WIDTH),
    .AXI_ADDR_WIDTH  (AXI_ADDR_WIDTH),
    .AXI_DATA_WIDTH  (AXI_DATA_WIDTH),
    .AXI_USER_WIDTH  (AXI_USER_WIDTH)
) mem_if (
    .clk_i            (gl_clk),
    .rst_ni           (~reset),
    .aw_valid         (axi_aw_valid), 
    .aw_ready         (axi_aw_ready), 
    .aw_addr          (axi_aw_addr), 
    .aw_id            (axi_aw_id), 
    .aw_len           (axi_aw_len), 
    .aw_size          (axi_aw_size), 
    .aw_burst         (axi_aw_burst), 
    .aw_cache         (axi_aw_cache), 
    .aw_prot          (axi_aw_prot),
    .w_valid          (axi_w_valid), 
    .w_ready          (axi_w_ready), 
    .w_data           (axi_w_data), 
    .w_strb           (axi_w_strb), 
    .w_last           (axi_w_last),
    .b_valid          (axi_b_valid), 
    .b_ready          (axi_b_ready),
    .b_id             (axi_b_id),
    .b_resp           (axi_b_resp),
    .ar_valid         (axi_ar_valid), 
    .ar_ready         (axi_ar_ready), 
    .ar_addr          (axi_ar_addr), 
    .ar_id            (axi_ar_id), 
    .ar_len           (axi_ar_len), 
    .ar_size          (axi_ar_size), 
    .ar_burst         (axi_ar_burst), 
    .ar_cache         (axi_ar_cache), 
    .ar_prot          (axi_ar_prot),
    .r_valid          (axi_r_valid), 
    .r_ready          (axi_r_ready), 
    .r_data           (axi_r_data), 
    .r_id             (axi_r_id), 
    .r_resp           (axi_r_resp), 
    .r_last           (axi_r_last),

    .req_o            (req),
    .we_o             (we),
    .addr_o           (addr),
    .be_o             (be),
    .data_o           (wdata),
    .data_i           (rdata)
);


slave_ram #(
    .AXI_ID_WIDTH    (AXI_ID_WIDTH),
    .AXI_ADDR_WIDTH  (AXI_ADDR_WIDTH),
    .AXI_DATA_WIDTH  (AXI_DATA_WIDTH),
    .AXI_USER_WIDTH  (AXI_USER_WIDTH)
) sys_ram(
    .clk              (gl_clk),
    .reset            (reset),
    .req_i            (req),
    .we_i             (we),
    .addr_i           (addr),
    .be_i             (be),
    .data_i           (wdata),
    .data_o           (rdata)
);

//----------------------------------------------------------
//                Interrupt generation Logic
//----------------------------------------------------------

reg [63:0] sim_cycles;
always @(posedge gl_clk) begin
  if(~pad_cpu_rst_b) begin
      sim_cycles <= 0;
  end else begin
      sim_cycles <= sim_cycles + 1'b1;
  end
end


always @(posedge gl_clk) begin
  if(~pad_cpu_rst_b) begin
      ext_int_0 <= 0;
  end else if (sim_cycles == 64'h13600) begin
      ext_int_0 <= 1'b1;
  end else if (sim_cycles == 64'h1360f) begin
      ext_int_0 <= 1'b0;
  end else if (sim_cycles == 64'h3f000) begin
      ext_int_0 <= 1'b1;
  end else if (sim_cycles == 64'h3f00f) begin
      ext_int_0 <= 1'b0;
  end else begin
      ext_int_0 <= ext_int_0;
  end

end

//----------------------------------------------------------
//                   Dump Trace Logic
//----------------------------------------------------------
wire [63:0] retire0_pc;
wire        retire0_vld;
wire [63:0] retire1_pc;
wire        retire1_vld;
wire [63:0] retire2_pc;
wire        retire2_vld;

wire debug_dump_on = 1'b1;


// `define HETE_ARCH_LITTLE 1
// `define HETE_ARCH_BIG    1
// `define HETE_ARCH_HYBRID 1


`ifdef HETE_ARCH_LITTLE
`define NO_CYCLE_DEBUG1  1
`define CORE             cpu_subsystem.core0_subsystem.x_aq_top_0.x_aq_core
`define CPU_RTU         `CORE.x_aq_rtu_top

assign retire0_pc[63:0]  = `CPU_RTU.rtu_pad_retire_pc[63:0];
assign retire0_vld       = `CPU_RTU.rtu_pad_retire;
assign retire1_pc[63:0]  = 64'b0;
assign retire1_vld       = 1'b0;
assign retire2_pc[63:0]  = 64'b0;
assign retire2_vld       = 1'b0;


`elsif HETE_ARCH_BIG
`define NO_CYCLE_DEBUG1  1
`define CORE             cpu_subsystem.core0_subsystem.core_top_0.x_ct_core
`define CPU_RTU         `CORE.x_ct_rtu_top

assign retire0_pc[63:0]  = `CPU_RTU.rtu_pad_retire0_pc[63:0];
assign retire0_vld       = `CPU_RTU.rtu_pad_retire0;
assign retire1_pc[63:0]  = `CPU_RTU.rtu_pad_retire1_pc[63:0];
assign retire1_vld       = `CPU_RTU.rtu_pad_retire1;
assign retire2_pc[63:0]  = `CPU_RTU.rtu_pad_retire2_pc[63:0];
assign retire2_vld       = `CPU_RTU.rtu_pad_retire2;


`else

`endif




`ifdef NO_CYCLE_DEBUG1
static integer FILE1;
initial
begin
FILE1 = $fopen("dbg.exe.report","w");
end

always @(posedge gl_clk) begin
  if (retire0_vld && debug_dump_on) begin
    $fwrite(FILE1, "Cycle: %x -> %x\n", sim_cycles, retire0_pc);
  end
  if (retire1_vld && debug_dump_on) begin
    $fwrite(FILE1, "Cycle: %x -> %x\n", sim_cycles, retire1_pc);
  end
  if (retire2_vld && debug_dump_on) begin
    $fwrite(FILE1, "Cycle: %x -> %x\n", sim_cycles, retire2_pc);
  end
  `ifndef CPU_RANDOM_TEST_RETIRE
   if ((retire0_pc == 64'h0) && retire0_vld ||
      (retire1_pc == 64'h0) && retire1_vld ||
      (retire2_pc == 64'h0) && retire2_vld
      ) begin
    `ifndef VCS_SIM
        $display("Retire PC: 0x%x. Cycles: %x", retire0_pc[63:0], sim_cycles[63:0]);
    `endif
    $fclose(FILE1);
    $finish;
   end
  `endif
end



static integer FILE_PC;
initial
begin
FILE_PC = $fopen("dbg.exe.report.pc","w");
end

always @(posedge gl_clk) begin
  if (retire0_vld && debug_dump_on) begin
    $fwrite(FILE_PC, "%x\n", retire0_pc);
  end
  if (retire1_vld && debug_dump_on) begin
    $fwrite(FILE_PC, "%x\n", retire1_pc);
  end
  if (retire2_vld && debug_dump_on) begin
    $fwrite(FILE_PC, "%x\n", retire2_pc);
  end
  `ifndef CPU_RANDOM_TEST_RETIRE
   if ((retire0_pc == 64'h0) && retire0_vld ||
      (retire1_pc == 64'h0) && retire1_vld ||
      (retire2_pc == 64'h0) && retire2_vld
      ) begin
    `ifndef VCS_SIM
        $display("Retire PC: 0x%x. Cycles: %x", retire0_pc[63:0], sim_cycles[63:0]);
    `endif
    $fclose(FILE_PC);
    $finish;
   end
  `endif
end
`endif // END NO_CYCLE_DEBUG1













// //----------------------------------------------------------
// //                   Retire Logic
// //----------------------------------------------------------
// `define CPU_CORE cpu_subsystem.core0_subsystem

// `ifdef MMU_ON
// `define HALT_PC  40'h1800018000
// `else 
// `define HALT_PC  40'h1c018000
// `endif

// always @(posedge gl_clk) begin
//     if ((`CPU_CORE.core0_pad_retire0_pc == `HALT_PC)
//         && `CPU_CORE.core0_pad_retire0
//     || (`CPU_CORE.core0_pad_retire1_pc == `HALT_PC)
//         && `CPU_CORE.core0_pad_retire1
//     || (`CPU_CORE.core0_pad_retire2_pc == `HALT_PC)
//         && `CPU_CORE.core0_pad_retire2
//         ) begin
//         $finish;
//     end
// end

// reg [63 :0] debug_wave_dump_on; 

// always @(posedge gl_clk) begin
//     if (debug_wave_dump_on[63:0] == 64'h11) begin
//        $display("debug_wave_dump_on!");
//     end else if (debug_wave_dump_on[63:0] == 64'hff) begin
//        $display("debug_wave_dump_off!");
//     end 
// end


// `define CPU_CP0_REGS cpu_subsystem.core0_subsystem.core_top_0.x_ct_core.x_ct_cp0_top.x_ct_cp0_regs

// always @(posedge gl_clk) begin
//     debug_wave_dump_on <= `CPU_CP0_REGS.debug_wave_dump_value[63:0];
// end

///NOTE: The following way is too too slow. Deprecated!
/// --------------------- Initial --------------------------- ///
// string binary = "vmlinux";

// for faster simulation we can directly preload the ELF
// Note that we are loosing the capabilities to use risc-fesvr though
// initial begin
//     automatic logic [15:0][7:0] mem_row;
//     longint address, len;
//     byte buffer[];
//     int percent = 0;
//     if (binary != "") begin
//         $display("Preloading ELF: %s", binary);
//         void'(read_elf(binary));
//         // wait with preloading, otherwise randomization will overwrite the existing value
//         wait(gl_clk);
//         // while there are more sections to process
//         while (get_section(address, len)) begin
//             automatic int num_words = (len+15)/16;
//             automatic int per_tmp = num_words / 100 ;
//             automatic int ii = 0;
//             automatic int iii = 0;
//             $display("Loading Address: %x, Length: %x", address, len);
//             $display("Length num_words: %x", num_words);
//             buffer = new [num_words*16];
//             void'(read_section(address, buffer));
//             // preload memories
//             // 128-bit
//             for ( int i = 0; i < num_words; i++) begin
//                 mem_row = '0;
//                 iii++;
//                 for (int j = 0; j < 16; j++) begin
//                     mem_row[j] = buffer[i*16 + j];
//                 end
//                 if (per_tmp == iii) begin
//                     iii = 0;
//                     ii ++;
//                     $display("Length num_words percent: %d", ii);
//                 end
//                 sys_ram.ram_mem[address[47:0]>>4 + i][127:0] = mem_row;

//             end
//         end
//         $display("Loading ELF Successfully!");
//     end
// end

endmodule