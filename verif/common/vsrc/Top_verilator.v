
`timescale 1ns/1ps 

//`include "board.h"

module Top #(
    parameter int unsigned AXI_ID_WIDTH      = 8,
    parameter int unsigned AXI_ADDR_WIDTH    = 40,
    parameter int unsigned AXI_DATA_WIDTH    = 128,
    parameter int unsigned AXI_USER_WIDTH    = 2
)(
  output   wire                          axi_ar_valid,
  input    wire                          axi_ar_ready,
  output   wire   [AXI_ADDR_WIDTH-1:0]   axi_ar_addr,
  output   wire   [AXI_ID_WIDTH-1  :0]   axi_ar_id,
  output   wire   [7:0]                  axi_ar_len,
  output   wire   [2:0]                  axi_ar_size,
  output   wire   [1:0]                  axi_ar_burst,
  output   wire   [3:0]                  axi_ar_cache,
  output   wire   [2:0]                  axi_ar_prot,
  output   wire                          axi_aw_valid,
  input    wire                          axi_aw_ready,
  output   wire   [AXI_ADDR_WIDTH-1:0]   axi_aw_addr,
  output   wire   [AXI_ID_WIDTH-1  :0]   axi_aw_id,
  output   wire   [7:0]                  axi_aw_len,
  output   wire   [2:0]                  axi_aw_size,
  output   wire   [1:0]                  axi_aw_burst,
  output   wire   [3:0]                  axi_aw_cache,
  output   wire   [2:0]                  axi_aw_prot,
  output   wire   [AXI_ID_WIDTH-1  :0]   axi_w_id,
  output   wire                          axi_w_valid,
  input    wire                          axi_w_ready,
  output   wire   [AXI_DATA_WIDTH-1:0]   axi_w_data,
  output   wire   [15:0]                 axi_w_strb,
  output   wire                          axi_w_last,
  input    wire                          axi_b_valid,
  output   wire                          axi_b_ready,
  input    wire   [AXI_ID_WIDTH-1  :0]   axi_b_id,
  input    wire   [1:0]                  axi_b_resp,
  input    wire                          axi_r_valid,
  output   wire                          axi_r_ready,
  input    wire   [AXI_DATA_WIDTH-1:0]   axi_r_data,
  input    wire   [AXI_ID_WIDTH-1  :0]   axi_r_id,
  input    wire   [1:0]                  axi_r_resp,
  input    wire                          axi_r_last,
  input    wire   [63:0]                 dump_st_pc_up,
  input    wire   [63:0]                 dump_st_pc_dw,
  input    wire   [63:0]                 dump_pc,
  input    wire   [63:0]                 dump_cycles,
  input    wire   [7 :0]                 core_in_interrupt,
  output   reg    [63:0]                 debug_wave_dump_on,
  output   reg    [63:0]                 dbg_sim_cycles,
  input    wire                          debug_dump_on,
  output   wire   [63:0]                 dbg_retire0_pc,
  output   wire                          dbg_retire0_vld,
  input    wire                          reset,
  input    wire                          clk
);


`ifdef SIM_DUMP
initial begin
      /// method 1: this will dump only ct_top module
      // $fsdbDumpon;
      // $fsdbDumpfile("soc_top.fsdb");
      // $fsdbDumpvars(0, soc_top);

      $dumpfile("soc_top.vcd");
      $dumpvars;  

      /// method 2: this will dump all module
      // $fsdbDumpvars();
end
`endif


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
  .biu_pad_lpmd_b        (                  ),
  .had_pad_jtg_tdo       (                  ),
  .had_pad_jtg_tdo_en    (                  ),
  .i_pad_jtg_tms         (                  ),  /// No Input
  .pad_cpu_rst_b         (~reset            ),
  .pad_yy_dft_clk_rst_b  (~reset            ),
  .pad_had_jtg_tclk      (clk               ),
  .pad_had_jtg_tdi       ('0                ),
  .pad_had_jtg_trst_b    (~reset            ),
  .pll_cpu_clk           (clk               ),
  .ext_interrupt         (core_in_interrupt ),
  .xx_intc_vld           ('0                )
);


//----------------------------------------------------------
//                Debug sim_cycles
//----------------------------------------------------------
reg [63:0] sim_cycles;
always @(posedge clk) begin
  if(reset) begin
      sim_cycles <= 0;
  end else begin
      sim_cycles <= sim_cycles + 1'b1;
  end
end

assign dbg_sim_cycles[63:0] = sim_cycles[63:0];

//----------------------------------------------------------
//                   Retire Logic
//----------------------------------------------------------
wire [63:0] retire0_pc;
wire        retire0_vld;
wire [63:0] retire1_pc;
wire        retire1_vld;
wire [63:0] retire2_pc;
wire        retire2_vld;

// wire debug_dump_on = 1'b0;


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

always @(posedge clk) begin
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

always @(posedge clk) begin
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




//----------------------------------------------------------
//                   Debug Dump Wave Logic
//----------------------------------------------------------
assign dbg_retire0_pc[63:0] = retire0_pc[63:0];
assign dbg_retire0_vld      = retire0_vld;


//----------------------------------------------------------
//                   Save Commit PC
//----------------------------------------------------------
reg [63: 0] last_commit_0_pc;
reg [63: 0] last_commit_1_pc;
reg [63: 0] last_commit_2_pc;
always @(posedge clk) begin
    if(reset) begin
      last_commit_0_pc[63 :0] <= 64'b0;
      last_commit_1_pc[63 :0] <= 64'b0;
      last_commit_2_pc[63 :0] <= 64'b0;
    end
    if(retire0_vld) begin
      last_commit_0_pc[63 :0] <= retire0_pc[63:0];  
    end
    if(retire1_vld) begin
      last_commit_1_pc[63 :0] <= retire1_pc[63:0];  
    end
    if(retire2_vld) begin
      last_commit_2_pc[63 :0] <= retire2_pc[63:0];  
    end
end



wire commit_vld;

assign commit_vld =    retire0_vld || retire1_vld || retire2_vld;

reg start_stats_reg;
always @(posedge clk) begin
    if (reset) begin
       start_stats_reg  <= 1'b0;
    end else if(!start_stats_reg && commit_vld) begin
       start_stats_reg  <= 1'b1;
    end 
end


reg [31: 0] commit_idle_cnt;
always @(posedge clk) begin
    if (reset || commit_vld) begin
       commit_idle_cnt[31: 0] <= 32'b0;
    end else begin
       commit_idle_cnt[31: 0] <= commit_idle_cnt[31: 0] + 1'b1;
    end 
end

always @(posedge clk) begin
    if ((commit_idle_cnt[31: 0] >= 32'h8000) && start_stats_reg) begin
       $display("Too long time not retire inst!");
       $display("Last Commit PC 0: %x", last_commit_0_pc[63:0]);
       $display("Last Commit PC 1: %x", last_commit_1_pc[63:0]);
       $display("Last Commit PC 2: %x", last_commit_2_pc[63:0]);
       $finish;
    end 
end

//----------------------------------------------------------
//                   Display Restore PC
//----------------------------------------------------------
`define RESTORE_PC  32'h1c000830

always @(posedge clk) begin
    if ((retire0_pc[31:0] == `RESTORE_PC)
        && retire0_vld
    || (retire1_pc[31:0] == `RESTORE_PC)
        && retire1_vld
    || (retire2_pc[31:0] == `RESTORE_PC)
        && retire2_vld
        ) begin
        $display("CheckPoint Restore Success!");
        $display("###########################");
    end
end

endmodule



