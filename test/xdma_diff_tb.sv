
// iverilog -g2012 test/xdma_diff_tb.sv test/xlnx_xdma_fifo.v design/soc/rtl/xdma_diff.v  -I design/sys/core/lc164/cpu/rtl/ -s xdma_diff_tb -o test/sim.out
// vvp -n test/sim.out
`include "cpu_cfig.h"
module xdma_diff_tb();

    logic dma_clk;
    logic dma_aresetn;
    logic axi_clk;
    logic axi_resetn;

    logic [ 63:0] DIFF_AXI_araddr;
    logic [  1:0] DIFF_AXI_arburst;
    logic [  3:0] DIFF_AXI_arcache;
    logic [  3:0] DIFF_AXI_arid;
    logic [  7:0] DIFF_AXI_arlen;
    logic [  0:0] DIFF_AXI_arlock;
    logic [  2:0] DIFF_AXI_arprot;
    logic [  3:0] DIFF_AXI_arqos;
    logic [  0:0] DIFF_AXI_arready;
    logic [  3:0] DIFF_AXI_arregion;
    logic [  2:0] DIFF_AXI_arsize;
    logic [  0:0] DIFF_AXI_arvalid;
    logic [ 63:0] DIFF_AXI_awaddr;
    logic [  1:0] DIFF_AXI_awburst;
    logic [  3:0] DIFF_AXI_awcache;
    logic [  3:0] DIFF_AXI_awid;
    logic [  7:0] DIFF_AXI_awlen;
    logic [  0:0] DIFF_AXI_awlock;
    logic [  2:0] DIFF_AXI_awprot;
    logic [  3:0] DIFF_AXI_awqos;
    logic [  0:0] DIFF_AXI_awready;
    logic [  3:0] DIFF_AXI_awregion;
    logic [  2:0] DIFF_AXI_awsize;
    logic [  0:0] DIFF_AXI_awvalid;
    logic [  3:0] DIFF_AXI_bid;
    logic [  0:0] DIFF_AXI_bready;
    logic [  1:0] DIFF_AXI_bresp;
    logic [  0:0] DIFF_AXI_bvalid;
    logic [511:0] DIFF_AXI_rdata;
    logic [  3:0] DIFF_AXI_rid;
    logic [  0:0] DIFF_AXI_rlast;
    logic [  0:0] DIFF_AXI_rready;
    logic [  1:0] DIFF_AXI_rresp;
    logic [  0:0] DIFF_AXI_rvalid;
    logic [511:0] DIFF_AXI_wdata;
    logic [  0:0] DIFF_AXI_wlast;
    logic [  0:0] DIFF_AXI_wready;
    logic [ 63:0] DIFF_AXI_wstrb;
    logic [  0:0] DIFF_AXI_wvalid;

    logic stall;
    logic                      dma_InstrCommit_valid_0;
    logic [              63:0] dma_InstrCommit_pc_0;
    logic [              31:0] dma_InstrCommit_instr_0;
    logic                      dma_InstrCommit_skip_0;
    logic                      dma_InstrCommit_is_TLBFILL_0;
    logic [               7:0] dma_InstrCommit_TLBFILL_index_0;
    logic                      dma_InstrCommit_is_CNTinst_0;
    logic [              63:0] dma_InstrCommit_timer_64_value_0;
    logic                      dma_InstrCommit_wen_0;
    logic [               7:0] dma_InstrCommit_wdest_0;
    logic [              63:0] dma_InstrCommit_wdata_0;
    logic                      dma_InstrCommit_csr_rstat_0;
    logic [              31:0] dma_InstrCommit_csr_data_0;
    logic                      dma_ExcpEvent_excp_valid;
    logic                      dma_ExcpEvent_eret;
    logic [              31:0] dma_ExcpEvent_intrNo;
    logic [              31:0] dma_ExcpEvent_cause;
    logic [              63:0] dma_ExcpEvent_exceptionPC;
    logic [              31:0] dma_ExcpEvent_exceptionInst; 
    logic                      dma_TrapEvent_valid;
    logic [               7:0] dma_TrapEvent_code;
    logic [              63:0] dma_TrapEvent_pc;
    logic [              63:0] dma_TrapEvent_cycleCnt;
    logic [              63:0] dma_TrapEvent_instrCnt; 
    logic  dma_StoreEvent_valid_0;
    logic [              63:0] dma_StoreEvent_storePAddr_0;
    logic [              63:0] dma_StoreEvent_storeData_0;
    logic [               7:0] dma_StoreEvent_storeMask_0; 
    logic  dma_LoadEvent_valid_0;
    logic [              63:0] dma_LoadEvent_paddr_0;
    logic [              63:0] dma_LoadEvent_vaddr_0; 
    logic [              63:0] dma_CSRRegState_crmd;
    logic [              63:0] dma_CSRRegState_prmd;
    logic [              63:0] dma_CSRRegState_euen;
    logic [              63:0] dma_CSRRegState_ecfg;
    logic [              63:0] dma_CSRRegState_estat;
    logic [              63:0] dma_CSRRegState_era;
    logic [              63:0] dma_CSRRegState_badv;
    logic [              63:0] dma_CSRRegState_eentry;
    logic [              63:0] dma_CSRRegState_tlbidx;
    logic [              63:0] dma_CSRRegState_tlbehi;
    logic [              63:0] dma_CSRRegState_tlbelo0;
    logic [              63:0] dma_CSRRegState_tlbelo1;
    logic [              63:0] dma_CSRRegState_asid;
    logic [              63:0] dma_CSRRegState_pgdl;
    logic [              63:0] dma_CSRRegState_pgdh;
    logic [              63:0] dma_CSRRegState_save0;
    logic [              63:0] dma_CSRRegState_save1;
    logic [              63:0] dma_CSRRegState_save2;
    logic [              63:0] dma_CSRRegState_save3;
    logic [              63:0] dma_CSRRegState_tid;
    logic [              63:0] dma_CSRRegState_tcfg;
    logic [              63:0] dma_CSRRegState_tval;
    logic [              63:0] dma_CSRRegState_ticlr;
    logic [              63:0] dma_CSRRegState_llbctl;
    logic [              63:0] dma_CSRRegState_tlbrentry;
    logic [              63:0] dma_CSRRegState_dmw0;
    logic [              63:0] dma_CSRRegState_dmw1; 
    logic [              63:0] dma_GRegState_gpr_0;
    logic [              63:0] dma_GRegState_gpr_1;
    logic [              63:0] dma_GRegState_gpr_2;
    logic [              63:0] dma_GRegState_gpr_3;
    logic [              63:0] dma_GRegState_gpr_4;
    logic [              63:0] dma_GRegState_gpr_5;
    logic [              63:0] dma_GRegState_gpr_6;
    logic [              63:0] dma_GRegState_gpr_7;
    logic [              63:0] dma_GRegState_gpr_8;
    logic [              63:0] dma_GRegState_gpr_9;
    logic [              63:0] dma_GRegState_gpr_10;
    logic [              63:0] dma_GRegState_gpr_11;
    logic [              63:0] dma_GRegState_gpr_12;
    logic [              63:0] dma_GRegState_gpr_13;
    logic [              63:0] dma_GRegState_gpr_14;
    logic [              63:0] dma_GRegState_gpr_15;
    logic [              63:0] dma_GRegState_gpr_16;
    logic [              63:0] dma_GRegState_gpr_17;
    logic [              63:0] dma_GRegState_gpr_18;
    logic [              63:0] dma_GRegState_gpr_19;
    logic [              63:0] dma_GRegState_gpr_20;
    logic [              63:0] dma_GRegState_gpr_21;
    logic [              63:0] dma_GRegState_gpr_22;
    logic [              63:0] dma_GRegState_gpr_23;
    logic [              63:0] dma_GRegState_gpr_24;
    logic [              63:0] dma_GRegState_gpr_25;
    logic [              63:0] dma_GRegState_gpr_26;
    logic [              63:0] dma_GRegState_gpr_27;
    logic [              63:0] dma_GRegState_gpr_28;
    logic [              63:0] dma_GRegState_gpr_29;
    logic [              63:0] dma_GRegState_gpr_30;
    logic [              63:0] dma_GRegState_gpr_31; 
    logic [              63:0] dma_FPRegState_fpr_0;
    logic [              63:0] dma_FPRegState_fpr_1;
    logic [              63:0] dma_FPRegState_fpr_2;
    logic [              63:0] dma_FPRegState_fpr_3;
    logic [              63:0] dma_FPRegState_fpr_4;
    logic [              63:0] dma_FPRegState_fpr_5;
    logic [              63:0] dma_FPRegState_fpr_6;
    logic [              63:0] dma_FPRegState_fpr_7;
    logic [              63:0] dma_FPRegState_fpr_8;
    logic [              63:0] dma_FPRegState_fpr_9;
    logic [              63:0] dma_FPRegState_fpr_10;
    logic [              63:0] dma_FPRegState_fpr_11;
    logic [              63:0] dma_FPRegState_fpr_12;
    logic [              63:0] dma_FPRegState_fpr_13;
    logic [              63:0] dma_FPRegState_fpr_14;
    logic [              63:0] dma_FPRegState_fpr_15;
    logic [              63:0] dma_FPRegState_fpr_16;
    logic [              63:0] dma_FPRegState_fpr_17;
    logic [              63:0] dma_FPRegState_fpr_18;
    logic [              63:0] dma_FPRegState_fpr_19;
    logic [              63:0] dma_FPRegState_fpr_20;
    logic [              63:0] dma_FPRegState_fpr_21;
    logic [              63:0] dma_FPRegState_fpr_22;
    logic [              63:0] dma_FPRegState_fpr_23;
    logic [              63:0] dma_FPRegState_fpr_24;
    logic [              63:0] dma_FPRegState_fpr_25;
    logic [              63:0] dma_FPRegState_fpr_26;
    logic [              63:0] dma_FPRegState_fpr_27;
    logic [              63:0] dma_FPRegState_fpr_28;
    logic [              63:0] dma_FPRegState_fpr_29;
    logic [              63:0] dma_FPRegState_fpr_30;
    logic [              63:0] dma_FPRegState_fpr_31;
    logic [               7:0] dma_FPRegState_fccr;
    logic [              31:0] dma_FPRegState_fcsr0; 
    logic  dma_TLBEvent_valid_0;
    logic [8-1:0] dma_TLBEvent_source_0;
    logic [64-1:0] dma_TLBEvent_vpn_0;
    logic [64-1:0] dma_TLBEvent_ppn_0;
    logic [32-1:0] dma_TLBEvent_exception_0; 
    logic  dma_TLBEvent_valid_1;
    logic [8-1:0] dma_TLBEvent_source_1;
    logic [64-1:0] dma_TLBEvent_vpn_1;
    logic [64-1:0] dma_TLBEvent_ppn_1;
    logic [32-1:0] dma_TLBEvent_exception_1;

    always #5 axi_clk = ~axi_clk;
    always #2 dma_clk = ~dma_clk;

    initial begin
        $dumpfile("test/tb.vcd");
        $dumpvars(0, xdma_diff_tb);
    end

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

    initial begin
        axi_clk = 1;
        dma_clk = 1;
        axi_resetn = 0;
        dma_aresetn = 0;
        dma_InstrCommit_valid_0 = 0;
        dma_InstrCommit_pc_0 = 0;
        dma_InstrCommit_instr_0 = 0;
        dma_InstrCommit_skip_0 = 0;
        dma_InstrCommit_is_TLBFILL_0 = 0;
        dma_InstrCommit_TLBFILL_index_0 = 0;
        dma_InstrCommit_is_CNTinst_0 = 0;
        dma_InstrCommit_timer_64_value_0 = 0;
        dma_InstrCommit_wen_0 = 0;
        dma_InstrCommit_wdest_0 = 0;
        dma_InstrCommit_wdata_0 = 0;
        dma_InstrCommit_csr_rstat_0 = 0;
        dma_InstrCommit_csr_data_0 = 0;
        dma_CSRRegState_crmd = 0;
        dma_CSRRegState_prmd = 0;
        dma_CSRRegState_euen = 0;
        dma_CSRRegState_ecfg = 0;
        dma_CSRRegState_estat = 0;
        dma_CSRRegState_era = 0;
        dma_CSRRegState_badv = 0;
        dma_CSRRegState_eentry = 0;
        dma_CSRRegState_tlbidx = 0;
        dma_CSRRegState_tlbehi = 0;
        dma_CSRRegState_tlbelo0 = 0;
        dma_CSRRegState_tlbelo1 = 0;
        dma_CSRRegState_asid = 0;
        dma_CSRRegState_pgdl = 0;
        dma_CSRRegState_pgdh = 0;
        dma_CSRRegState_save0 = 0;
        dma_CSRRegState_save1 = 0;
        dma_CSRRegState_save2 = 0;
        dma_CSRRegState_save3 = 0;
        dma_CSRRegState_tid = 0;
        dma_CSRRegState_tcfg = 0;
        dma_CSRRegState_tval = 0;
        dma_CSRRegState_ticlr = 0;
        dma_CSRRegState_llbctl = 0;
        dma_CSRRegState_tlbrentry = 0;
        dma_CSRRegState_dmw0 = 0;
        dma_CSRRegState_dmw1 = 0;
        dma_ExcpEvent_excp_valid = 0;
        dma_ExcpEvent_eret = 0;
        dma_ExcpEvent_intrNo = 0;
        dma_ExcpEvent_cause = 0;
        dma_ExcpEvent_exceptionPC = 0;
        dma_ExcpEvent_exceptionInst = 0;
        dma_TrapEvent_valid = 0;
        dma_TrapEvent_code = 0;
        dma_TrapEvent_pc = 0;
        dma_TrapEvent_cycleCnt = 0;
        dma_TrapEvent_instrCnt = 0;
        dma_StoreEvent_valid_0 = 0;
        dma_StoreEvent_storePAddr_0 = 0;
        dma_StoreEvent_storeData_0 = 0;
        dma_StoreEvent_storeMask_0 = 0;
        dma_LoadEvent_valid_0 = 0;
        dma_LoadEvent_paddr_0 = 0;
        dma_LoadEvent_vaddr_0 = 0;
        dma_GRegState_gpr_0 = 0;
        dma_GRegState_gpr_1 = 0;
        dma_GRegState_gpr_2 = 0;
        dma_GRegState_gpr_3 = 0;
        dma_GRegState_gpr_4 = 0;
        dma_GRegState_gpr_5 = 0;
        dma_GRegState_gpr_6 = 0;
        dma_GRegState_gpr_7 = 0;
        dma_GRegState_gpr_8 = 0;
        dma_GRegState_gpr_9 = 0;
        dma_GRegState_gpr_10 = 0;
        dma_GRegState_gpr_11 = 0;
        dma_GRegState_gpr_12 = 0;
        dma_GRegState_gpr_13 = 0;
        dma_GRegState_gpr_14 = 0;
        dma_GRegState_gpr_15 = 0;
        dma_GRegState_gpr_16 = 0;
        dma_GRegState_gpr_17 = 0;
        dma_GRegState_gpr_18 = 0;
        dma_GRegState_gpr_19 = 0;
        dma_GRegState_gpr_20 = 0;
        dma_GRegState_gpr_21 = 0;
        dma_GRegState_gpr_22 = 0;
        dma_GRegState_gpr_23 = 0;
        dma_GRegState_gpr_24 = 0;
        dma_GRegState_gpr_25 = 0;
        dma_GRegState_gpr_26 = 0;
        dma_GRegState_gpr_27 = 0;
        dma_GRegState_gpr_28 = 0;
        dma_GRegState_gpr_29 = 0;
        dma_GRegState_gpr_30 = 0;
        dma_GRegState_gpr_31 = 0;
        dma_FPRegState_fpr_0 = 0;
        dma_FPRegState_fpr_1 = 0;
        dma_FPRegState_fpr_2 = 0;
        dma_FPRegState_fpr_3 = 0;
        dma_FPRegState_fpr_4 = 0;
        dma_FPRegState_fpr_5 = 0;
        dma_FPRegState_fpr_6 = 0;
        dma_FPRegState_fpr_7 = 0;
        dma_FPRegState_fpr_8 = 0;
        dma_FPRegState_fpr_9 = 0;
        dma_FPRegState_fpr_10 = 0;
        dma_FPRegState_fpr_11 = 0;
        dma_FPRegState_fpr_12 = 0;
        dma_FPRegState_fpr_13 = 0;
        dma_FPRegState_fpr_14 = 0;
        dma_FPRegState_fpr_15 = 0;
        dma_FPRegState_fpr_16 = 0;
        dma_FPRegState_fpr_17 = 0;
        dma_FPRegState_fpr_18 = 0;
        dma_FPRegState_fpr_19 = 0;
        dma_FPRegState_fpr_20 = 0;
        dma_FPRegState_fpr_21 = 0;
        dma_FPRegState_fpr_22 = 0;
        dma_FPRegState_fpr_23 = 0;
        dma_FPRegState_fpr_24 = 0;
        dma_FPRegState_fpr_25 = 0;
        dma_FPRegState_fpr_26 = 0;
        dma_FPRegState_fpr_27 = 0;
        dma_FPRegState_fpr_28 = 0;
        dma_FPRegState_fpr_29 = 0;
        dma_FPRegState_fpr_30 = 0;
        dma_FPRegState_fpr_31 = 0;
        dma_FPRegState_fccr = 0;
        dma_FPRegState_fcsr0 = 0;
        dma_TLBEvent_valid_0 = 0;
        dma_TLBEvent_source_0 = 0;
        dma_TLBEvent_vpn_0 = 0;
        dma_TLBEvent_ppn_0 = 0;
        dma_TLBEvent_exception_0 = 0;
        dma_TLBEvent_valid_1 = 0;
        dma_TLBEvent_source_1 = 0;
        dma_TLBEvent_vpn_1 = 0;
        dma_TLBEvent_ppn_1 = 0;
        dma_TLBEvent_exception_1 = 0;
        #10;
        axi_resetn = 1;
        dma_aresetn = 1;
        #50;
        dma_InstrCommit_valid_0 = 1;
        dma_InstrCommit_pc_0 = 64'h1c000000;
        dma_InstrCommit_wen_0 = 1;
        dma_InstrCommit_wdest_0 = 5'd10;
        dma_InstrCommit_wdata_0 = 64'h4347fda;
        dma_GRegState_gpr_10 = 64'h4347fda;
        #10;
        dma_CSRRegState_save0 = 64'h834f;
        dma_GRegState_gpr_2 = 64'h3419;
        dma_InstrCommit_valid_0 = 0;
        #10;
        dma_InstrCommit_valid_0 = 1;
        dma_InstrCommit_wdest_0 = 5'd2;
        dma_InstrCommit_wdata_0 = 64'h3419;
        #10;
        dma_ExcpEvent_excp_valid = 1;
        dma_ExcpEvent_cause = 3;
        dma_ExcpEvent_exceptionPC = 64'h12345678;
        #10;
        dma_ExcpEvent_excp_valid = 0;
        dma_InstrCommit_wdest_0 = 5'd3;
        dma_InstrCommit_wdata_0 = 64'h8432142;
        dma_GRegState_gpr_3 = 64'h8432142;
        dma_FPRegState_fpr_10 = 64'hfabcde;
        dma_CSRRegState_badv = 64'h1c000004;
        #10;
        dma_InstrCommit_valid_0 = 0;
        dma_LoadEvent_valid_0 = 1;
        dma_LoadEvent_vaddr_0 = 64'h9000fabc;
        dma_LoadEvent_paddr_0 = 64'h1fff00000;
        #10;
        dma_StoreEvent_valid_0 = 1;
        dma_StoreEvent_storeData_0 = 64'hfedcba;
        dma_StoreEvent_storeMask_0 = 64'hffffffffffffffff;
        dma_StoreEvent_storePAddr_0 = 64'h1faf0000;
        #1000;
        $finish;
    end

    typedef enum {IDLE, READ} state_t;
    state_t state;
    integer fh;

    wire ar_hsk = DIFF_AXI_arvalid & DIFF_AXI_arready;
    wire r_hsk = DIFF_AXI_rvalid & DIFF_AXI_rready & DIFF_AXI_rlast;
    wire r_valid = DIFF_AXI_rvalid & DIFF_AXI_rready;

    assign DIFF_AXI_arvalid = state == IDLE;
    assign DIFF_AXI_araddr = 64'h13ff00000;
    assign DIFF_AXI_arid = 0;
    assign DIFF_AXI_arsize = 3'b110;
    assign DIFF_AXI_arburst = 2'b01;
    assign DIFF_AXI_arcache = 0;
    assign DIFF_AXI_arlock = 0;
    assign DIFF_AXI_arprot = 0;
    assign DIFF_AXI_arqos = 0;
    assign DIFF_AXI_arregion = 0;
    assign DIFF_AXI_rready = state == READ;
    assign DIFF_AXI_awvalid = 0;
    assign DIFF_AXI_awaddr = 0;
    assign DIFF_AXI_awburst = 0;
    assign DIFF_AXI_awcache = 0;
    assign DIFF_AXI_awid = 0;
    assign DIFF_AXI_awlen = 0;
    assign DIFF_AXI_awlock = 0;
    assign DIFF_AXI_awprot = 0;
    assign DIFF_AXI_awqos = 0;
    assign DIFF_AXI_awregion = 0;
    assign DIFF_AXI_wvalid = 0;
    assign DIFF_AXI_wlast = 0;
    assign DIFF_AXI_wstrb = 0;
    assign DIFF_AXI_wdata = 0;
    assign DIFF_AXI_bready = 0;

    initial begin
        fh = $fopen("test/log.txt", "w"); 
    end

    always @(posedge dma_clk)begin
        if (r_valid) begin
            $fwrite(fh, "%h", DIFF_AXI_rdata);
        end
    end

    always_ff @(posedge dma_clk or negedge dma_aresetn)begin
        if(!dma_aresetn)begin
            state <= IDLE;
            DIFF_AXI_arlen <= 8'h1;
        end
        else begin
            case(state)
            IDLE:begin
                if(ar_hsk) state <= READ;
            end
            READ:begin
                if(r_hsk) state <= IDLE;
            end
            endcase
        end
    end
endmodule