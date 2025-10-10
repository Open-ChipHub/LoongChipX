
`timescale 1ns/1ps 

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
`define CPU_CORE cpu_subsystem.core0_subsystem

`ifdef MMU_ON
`define HALT_PC  40'h1800018000
`else 
`define HALT_PC  40'h1c018000
`endif

always @(posedge clk) begin
    if ((`CPU_CORE.core0_pad_retire0_pc == `HALT_PC)
        && `CPU_CORE.core0_pad_retire0
    || (`CPU_CORE.core0_pad_retire1_pc == `HALT_PC)
        && `CPU_CORE.core0_pad_retire1
    || (`CPU_CORE.core0_pad_retire2_pc == `HALT_PC)
        && `CPU_CORE.core0_pad_retire2
        ) begin
        $finish;
    end
end


//----------------------------------------------------------
//                   Debug Dump Wave Logic
//----------------------------------------------------------
`define CPU_CP0_REGS cpu_subsystem.core0_subsystem.core_top_0.x_ct_core.x_ct_cp0_top.x_ct_cp0_regs

always @(posedge clk) begin
    if (debug_wave_dump_on[63:0] == 64'h11) begin
       $display("debug_wave_dump_on!");
    end else if (debug_wave_dump_on[63:0] == 64'hff) begin
       $display("debug_wave_dump_off!");
    end 
end


`define U_DUMP_PC  64'hffffffffffffffff
// `define U_DUMP_PC  64'h0000000120003d60
// `define U_DUMP_PC  64'h00000001200412e0
// `define U_DUMP_PC  64'h0000000008000000
`define U_DUMP_PC  64'h000000C01C000000
// `define U_DUMP_PC  64'h000000001C000000
// `define U_DUMP_PC  64'h00000001201f6140
// `define U_DUMP_PC  64'h00000001201f5c20
// `define U_DUMP_PC  64'h00000001201f36c0
// `define U_DUMP_PC  64'h0000000120001380
// `define U_DUMP_PC  64'h0000000120008c18
// `define U_DUMP_PC  64'h90000000009e0ee8
// `define U_DUMP_PC  64'h9000000000315a58
// `define U_DUMP_PC  64'h9000000000a0e090 // devtmpfs_init


reg [7:0] debug_num;

always @(posedge clk) begin
    if(reset) begin
      debug_num <= '0;
    end
    else if (((`CPU_CORE.core0_pad_retire0_pc == dump_pc[63:0]) && `CPU_CORE.core0_pad_retire0
          || (`CPU_CORE.core0_pad_retire1_pc == dump_pc[63:0]) && `CPU_CORE.core0_pad_retire1
          || (`CPU_CORE.core0_pad_retire2_pc == dump_pc[63:0]) && `CPU_CORE.core0_pad_retire2
             ) && (debug_wave_dump_on[63:0] != 64'h11))begin
        debug_num[7:0] <= debug_num[7:0] + 1'b1;
        $display("Dump Hit %d", debug_num[7:0]);
    end
    else  begin
        debug_num[7:0] <= debug_num[7:0];
    end
end

always @(posedge clk) begin
    if(reset) begin
      debug_wave_dump_on <= '0;
    end
    else if (((`CPU_CORE.core0_pad_retire0_pc == dump_pc[63:0]) && `CPU_CORE.core0_pad_retire0
          || (`CPU_CORE.core0_pad_retire1_pc == dump_pc[63:0]) && `CPU_CORE.core0_pad_retire1
          || (`CPU_CORE.core0_pad_retire2_pc == dump_pc[63:0]) && `CPU_CORE.core0_pad_retire2
             ) && (debug_wave_dump_on[63:0] != 64'h11))begin
        debug_wave_dump_on <= 64'h11;
    end
    else if(|debug_wave_dump_on[63:0]) begin
        debug_wave_dump_on <= 64'h0;
    end
end

//----------------------------------------------------------
//                   Diff Commit PC
//----------------------------------------------------------
`ifdef DBG_GOLD_TRACE
static integer TRACE_FILE;
static integer SCAN_FILE;
initial begin
  TRACE_FILE = $fopen(`DIFF_GD_FILE, "r");
  if (TRACE_FILE == 0) begin
    $display("gold_trace handle was NULL");
    $finish;
  end
end

`define CPU_ROB_RT_EXPT_VLD cpu_subsystem.core0_subsystem.core_top_0.x_ct_core.x_ct_rtu_top.x_ct_rtu_retire.retire_ifu_expt_vld

`define CPU_ROB_RT_EXPT_VEC cpu_subsystem.core0_subsystem.core_top_0.x_ct_core.x_ct_rtu_top.x_ct_rtu_retire.retire_ifu_expt_vec[15:0]


logic unsigned [63:0] captured_pc;

wire       retire_dump_vld;
wire       retire_inst_expt_pagefalut;
wire       user_space_retire_inst;
wire       dump_start_retire_next;

reg [63:0] last_captured_pc;
reg [63:0] retire_inst_num;
reg        retire_last_inst_expt_pagefalut;
reg        dump_start_retire_state;

// `define DUMP_START_PC 64'h1200007e0
// `define DUMP_START_PC 64'h1200006cc
`define DUMP_START_PC 64'h90000000009be000
// `define DUMP_START_PC 64'h120008c1c

assign dump_start_retire_next = (`CPU_CORE.core0_pad_retire0_pc[63:0] == `DUMP_START_PC)
                                && `CPU_CORE.core0_pad_retire0;

always @(posedge clk) begin
    if(reset) begin
        dump_start_retire_state <= 1'b0;
    end else if(!dump_start_retire_state && dump_start_retire_next) begin
        dump_start_retire_state <= 1'b1;
    end
end

assign retire_dump_vld = ((last_captured_pc[63:0] != `CPU_CORE.core0_pad_retire0_pc[63:0]) 
                           || retire_last_inst_expt_pagefalut)
                          // user space 
                          && (`CPU_CORE.core0_pad_retire0_pc[63:0] < 64'h130000000)
                          && `CPU_CORE.core0_pad_retire0
                          && !retire_inst_expt_pagefalut
                          && (dump_start_retire_state);

assign retire_inst_expt_pagefalut = (`CPU_ROB_RT_EXPT_VLD 
                                       && (`CPU_ROB_RT_EXPT_VEC == 16'h1
                                           || `CPU_ROB_RT_EXPT_VEC == 16'h2 
                                           )
                                    );

assign user_space_retire_inst = (`CPU_CORE.core0_pad_retire0_pc[63:0] < 64'h130000000)
                                 && `CPU_CORE.core0_pad_retire0;

always @(posedge clk) begin
  if(reset) begin
     retire_last_inst_expt_pagefalut <= 0;
  end else if(retire_inst_expt_pagefalut) begin
     retire_last_inst_expt_pagefalut <= 1'b1;
  end else if(user_space_retire_inst) begin
     retire_last_inst_expt_pagefalut <= 1'b0; 
  end
end

always @(posedge clk) begin
  if(reset) begin
     retire_inst_num <= 0;
     last_captured_pc[63:0] <= 0;
  end else if(`CPU_CORE.core0_pad_retire0) begin
     retire_inst_num <= retire_inst_num + 1'b1;
  end

  if (retire_dump_vld) begin
        SCAN_FILE = $fscanf(TRACE_FILE, "%x\n", captured_pc); 
        // last_captured_pc[63:0] <= captured_pc[63:0];
        last_captured_pc[63:0] <= `CPU_CORE.core0_pad_retire0_pc[63:0];
        if (!$feof(TRACE_FILE)) begin
            if (captured_pc[63:0] != `CPU_CORE.core0_pad_retire0_pc[63:0]) begin
                $display("------------------ ERROR ------------------");
                $display("Error  At  C:%x, I:%d", sim_cycles, retire_inst_num);
                $display("Retire PC: 0x%x!", `CPU_CORE.core0_pad_retire0_pc[63:0]);
                $display("Golden PC: 0x%x!", captured_pc[63:0]);
                $finish;
            end
        end
  end
end

`endif

//----------------------------------------------------------
//                Trace Load And Store
//----------------------------------------------------------
`define LSU_LOAD_AG   `CORE.x_ct_lsu_top.x_ct_lsu_ld_ag
`define LSU_LOAD_WB   `CORE.x_ct_lsu_top.x_ct_lsu_ld_wb
`define LSU_STORE_AG  `CORE.x_ct_lsu_top.x_ct_lsu_st_ag
`define LSU_STORE_WB  `CORE.x_ct_lsu_top.x_ct_lsu_st_wb
`define LSU_STORE_SQ  `CORE.x_ct_lsu_top.x_ct_lsu_sq
`define LSU_STORE_WCE `CORE.x_ct_lsu_top.x_ct_lsu_wmb_ce

`ifdef DBG_TRACE_LSU

`define LSU_TRACE_ST_VADDR_U  40'h123fcf9ec
`define LSU_TRACE_ST_VADDR_D  40'h123fce000

static integer LSU_FILE;

wire       lsu_trace_store_vld;
wire       lsu_retire_st_inst;
wire       lsu_retire_inst_icc;
wire       lsu_retire_inst_atomic;
wire       lsu_retire_inst_sync_fence;
wire [1:0] lsu_retire_inst_type;
wire [2:0] lsu_retire_inst_size;
wire [1:0] lsu_retire_inst_mode;

initial
begin
    LSU_FILE = $fopen("lsu.load_store.txt","w");
end

assign lsu_retire_inst_icc         = `LSU_STORE_SQ.sq_pop_icc;
assign lsu_retire_inst_atomic      = `LSU_STORE_SQ.sq_pop_atomic;
assign lsu_retire_inst_sync_fence  = `LSU_STORE_SQ.sq_pop_sync_fence;
assign lsu_retire_inst_type[1:0]   = `LSU_STORE_SQ.sq_pop_inst_type[1:0];
assign lsu_retire_inst_size[2:0]   = `LSU_STORE_SQ.sq_pop_inst_size[2:0];
assign lsu_retire_inst_mode[1:0]   = `LSU_STORE_SQ.sq_pop_inst_mode[1:0];

assign lsu_retire_st_inst  =   !lsu_retire_inst_icc
                           &&  !lsu_retire_inst_atomic
                           &&  !lsu_retire_inst_sync_fence
                           &&  (lsu_retire_inst_type[1:0]  ==  2'b00);

assign lsu_trace_store_vld = (`LSU_STORE_SQ.sq_pop_dva[63:0] <= `LSU_TRACE_ST_VADDR_U)
                             && (`LSU_STORE_SQ.sq_pop_dva[63:0] >= `LSU_TRACE_ST_VADDR_D)
                             && lsu_retire_st_inst;

always @(posedge clk) begin
  if (!reset) begin
      
  end
  if (!reset && `LSU_STORE_WCE.wmb_ce_create_dp_vld && lsu_trace_store_vld) begin
    $fwrite(LSU_FILE, "Cyc: %x, Va: %x, %x\n", sim_cycles, `LSU_STORE_SQ.sq_pop_dva[63:0], `LSU_STORE_SQ.sq_pop_data[63:0]);
  end
end

`endif


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
    if(`CPU_CORE.core0_pad_retire0) begin
      last_commit_0_pc[63 :0] <= `CPU_CORE.core0_pad_retire0_pc[63:0];  
    end
    if(`CPU_CORE.core0_pad_retire1) begin
      last_commit_1_pc[63 :0] <= `CPU_CORE.core0_pad_retire1_pc[63:0];  
    end
    if(`CPU_CORE.core0_pad_retire2) begin
      last_commit_2_pc[63 :0] <= `CPU_CORE.core0_pad_retire2_pc[63:0];  
    end
    // core 1
    if(`CPU_CORE.core1_pad_retire0) begin
      last_commit_0_pc[63 :0] <= `CPU_CORE.core1_pad_retire0_pc[63:0];  
    end
    if(`CPU_CORE.core1_pad_retire1) begin
      last_commit_1_pc[63 :0] <= `CPU_CORE.core1_pad_retire1_pc[63:0];  
    end
    if(`CPU_CORE.core1_pad_retire2) begin
      last_commit_2_pc[63 :0] <= `CPU_CORE.core1_pad_retire2_pc[63:0];  
    end
    // core 2
    if(`CPU_CORE.core2_pad_retire0) begin
      last_commit_0_pc[63 :0] <= `CPU_CORE.core2_pad_retire0_pc[63:0];  
    end
    if(`CPU_CORE.core2_pad_retire1) begin
      last_commit_1_pc[63 :0] <= `CPU_CORE.core2_pad_retire1_pc[63:0];  
    end
    if(`CPU_CORE.core2_pad_retire2) begin
      last_commit_2_pc[63 :0] <= `CPU_CORE.core2_pad_retire2_pc[63:0];  
    end
    // core 3
    if(`CPU_CORE.core3_pad_retire0) begin
      last_commit_0_pc[63 :0] <= `CPU_CORE.core3_pad_retire0_pc[63:0];  
    end
    if(`CPU_CORE.core3_pad_retire1) begin
      last_commit_1_pc[63 :0] <= `CPU_CORE.core3_pad_retire1_pc[63:0];  
    end
    if(`CPU_CORE.core3_pad_retire2) begin
      last_commit_2_pc[63 :0] <= `CPU_CORE.core3_pad_retire2_pc[63:0];  
    end
end



wire commit_vld;

assign commit_vld =    `CPU_CORE.core0_pad_retire0 || `CPU_CORE.core0_pad_retire1 || `CPU_CORE.core0_pad_retire2
                    || `CPU_CORE.core1_pad_retire0 || `CPU_CORE.core1_pad_retire1 || `CPU_CORE.core1_pad_retire2
                    || `CPU_CORE.core2_pad_retire0 || `CPU_CORE.core2_pad_retire1 || `CPU_CORE.core2_pad_retire2
                    || `CPU_CORE.core3_pad_retire0 || `CPU_CORE.core3_pad_retire1 || `CPU_CORE.core3_pad_retire2;

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
    if ((`CPU_CORE.core0_pad_retire0_pc[31:0] == `RESTORE_PC)
        && `CPU_CORE.core0_pad_retire0
    || (`CPU_CORE.core0_pad_retire1_pc[31:0] == `RESTORE_PC)
        && `CPU_CORE.core0_pad_retire1
    || (`CPU_CORE.core0_pad_retire2_pc[31:0] == `RESTORE_PC)
        && `CPU_CORE.core0_pad_retire2
        ) begin
        $display("CheckPoint Restore Success!");
        $display("###########################");
    end
end

endmodule



