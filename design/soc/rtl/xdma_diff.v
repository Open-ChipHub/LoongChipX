`include "cpu_cfig.h"

module xdma_diff (
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

    localparam TLB_EVT_NUM = 2;

    `InstrCommit_reg(axi_clk, 0, _s1,)
    `CSRRegState_reg(axi_clk, _s1,)
    `GRegState_reg(axi_clk, _s1,)
    `TLBEvent_reg(axi_clk, 0, _s1,)
    `TLBEvent_reg(axi_clk, 1, _s1,)
    `LoadEvent_reg(axi_clk, 0, _s1,)
    `StoreEvent_reg(axi_clk, 0, _s1,)
    `ExcpEvent_reg(axi_clk, _s1,)
    `FPRegState_reg(axi_clk, _s1,)

    wire dma_InstrCommit_valid = dma_InstrCommit_valid_0_s1;
    wire [63:0] dma_InstrCommit_pc = dma_InstrCommit_pc_0_s1;
    wire [31:0] dma_InstrCommit_instr = dma_InstrCommit_instr_0_s1;
    wire dma_InstrCommit_skip = dma_InstrCommit_skip_0_s1;
    wire dma_InstrCommit_is_TLBFILL = dma_InstrCommit_is_TLBFILL_0_s1;
    wire [7:0] dma_InstrCommit_TLBFILL_index = dma_InstrCommit_TLBFILL_index_0_s1;
    wire dma_InstrCommit_is_CNTinst = dma_InstrCommit_is_CNTinst_0_s1;
    wire [63:0] dma_InstrCommit_timer_64_value = dma_InstrCommit_timer_64_value_0_s1;
    wire dma_InstrCommit_wen = dma_InstrCommit_wen_0_s1;
    wire [7:0] dma_InstrCommit_wdest = dma_InstrCommit_wdest_0_s1;
    wire [63:0] dma_InstrCommit_wdata = dma_InstrCommit_wdata_0_s1;
    wire dma_InstrCommit_csr_rstat = dma_InstrCommit_csr_rstat_0_s1;
    wire [31:0] dma_InstrCommit_csr_data = dma_InstrCommit_csr_data_0_s1;

    wire dma_TrapEvent_valid = 0;
    wire [7:0] dma_TrapEvent_code = 0;
    wire [63:0] dma_TrapEvent_pc = 0;
    wire [63:0] dma_TrapEvent_cycleCnt = 0;
    wire [63:0] dma_TrapEvent_instrCnt = 0;

    wire [7:0] dma_StoreEvent_valid = dma_StoreEvent_valid_0_s1;
    wire [63:0] dma_StoreEvent_storePAddr = dma_StoreEvent_storePAddr_0_s1;
    wire [63:0] dma_StoreEvent_storeData = dma_StoreEvent_storeData_0_s1;
    wire [7:0] dma_StoreEvent_storeMask = dma_StoreEvent_storeMask_0_s1;

    wire [7:0] dma_LoadEvent_valid = dma_LoadEvent_valid_0_s1;
    wire [63:0] dma_LoadEvent_paddr = dma_LoadEvent_paddr_0_s1;
    wire [63:0] dma_LoadEvent_vaddr = dma_LoadEvent_vaddr_0_s1;

    wire [TLB_EVT_NUM-1:0] dma_TLBEvent_valid = {dma_TLBEvent_valid_1_s1, dma_TLBEvent_valid_0_s1};
    wire [TLB_EVT_NUM*8-1:0] dma_TLBEvent_source = {
        dma_TLBEvent_source_1_s1, dma_TLBEvent_source_0_s1
    };
    wire [TLB_EVT_NUM*64-1:0] dma_TLBEvent_vpn = {dma_TLBEvent_vpn_1_s1, dma_TLBEvent_vpn_0_s1};
    wire [TLB_EVT_NUM*64-1:0] dma_TLBEvent_ppn = {dma_TLBEvent_ppn_1_s1, dma_TLBEvent_ppn_0_s1};
    wire [TLB_EVT_NUM*32-1:0] dma_TLBEvent_exception = {
        dma_TLBEvent_exception_1_s1, dma_TLBEvent_exception_0_s1
    };

    reg [63:0] dma_InstrCommit_pc_r;
    reg [31:0] dma_InstrCommit_instr_r;
    reg dma_InstrCommit_skip_r;
    reg dma_InstrCommit_is_TLBFILL_r;
    reg [7:0] dma_InstrCommit_TLBFILL_index_r;
    reg dma_InstrCommit_is_CNTinst_r;
    reg [63:0] dma_InstrCommit_timer_64_value_r;
    reg dma_InstrCommit_wen_r;
    reg [7:0] dma_InstrCommit_wdest_r;
    reg [63:0] dma_InstrCommit_wdata_r;
    reg dma_InstrCommit_csr_rstat_r;
    reg [31:0] dma_InstrCommit_csr_data_r;
    reg dma_ExcpEvent_eret_r;
    reg [31:0] dma_ExcpEvent_intrNo_r;
    reg [31:0] dma_ExcpEvent_cause_r;
    reg [63:0] dma_ExcpEvent_exceptionPC_r;
    reg [31:0] dma_ExcpEvent_exceptionInst_r;
    reg [7:0] dma_TrapEvent_code_r;
    reg [63:0] dma_TrapEvent_pc_r;
    reg [63:0] dma_TrapEvent_cycleCnt_r;
    reg [63:0] dma_TrapEvent_instrCnt_r;
    reg [63:0] dma_StoreEvent_storePAddr_r;
    reg [63:0] dma_StoreEvent_storeData_r;
    reg [7:0] dma_StoreEvent_storeMask_r;
    reg [63:0] dma_LoadEvent_paddr_r;
    reg [63:0] dma_LoadEvent_vaddr_r;
    reg [63:0] dma_CSRRegState_crmd_r;
    reg [63:0] dma_CSRRegState_prmd_r;
    reg [63:0] dma_CSRRegState_euen_r;
    reg [63:0] dma_CSRRegState_ecfg_r;
    reg [63:0] dma_CSRRegState_estat_r;
    reg [63:0] dma_CSRRegState_era_r;
    reg [63:0] dma_CSRRegState_badv_r;
    reg [63:0] dma_CSRRegState_eentry_r;
    reg [63:0] dma_CSRRegState_tlbidx_r;
    reg [63:0] dma_CSRRegState_tlbehi_r;
    reg [63:0] dma_CSRRegState_tlbelo0_r;
    reg [63:0] dma_CSRRegState_tlbelo1_r;
    reg [63:0] dma_CSRRegState_asid_r;
    reg [63:0] dma_CSRRegState_pgdl_r;
    reg [63:0] dma_CSRRegState_pgdh_r;
    reg [63:0] dma_CSRRegState_save0_r;
    reg [63:0] dma_CSRRegState_save1_r;
    reg [63:0] dma_CSRRegState_save2_r;
    reg [63:0] dma_CSRRegState_save3_r;
    reg [63:0] dma_CSRRegState_tid_r;
    reg [63:0] dma_CSRRegState_tcfg_r;
    reg [63:0] dma_CSRRegState_tval_r;
    reg [63:0] dma_CSRRegState_ticlr_r;
    reg [63:0] dma_CSRRegState_llbctl_r;
    reg [63:0] dma_CSRRegState_tlbrentry_r;
    reg [63:0] dma_CSRRegState_dmw0_r;
    reg [63:0] dma_CSRRegState_dmw1_r;
    reg [63:0] dma_GRegState_gpr_0_r;
    reg [63:0] dma_GRegState_gpr_1_r;
    reg [63:0] dma_GRegState_gpr_2_r;
    reg [63:0] dma_GRegState_gpr_3_r;
    reg [63:0] dma_GRegState_gpr_4_r;
    reg [63:0] dma_GRegState_gpr_5_r;
    reg [63:0] dma_GRegState_gpr_6_r;
    reg [63:0] dma_GRegState_gpr_7_r;
    reg [63:0] dma_GRegState_gpr_8_r;
    reg [63:0] dma_GRegState_gpr_9_r;
    reg [63:0] dma_GRegState_gpr_10_r;
    reg [63:0] dma_GRegState_gpr_11_r;
    reg [63:0] dma_GRegState_gpr_12_r;
    reg [63:0] dma_GRegState_gpr_13_r;
    reg [63:0] dma_GRegState_gpr_14_r;
    reg [63:0] dma_GRegState_gpr_15_r;
    reg [63:0] dma_GRegState_gpr_16_r;
    reg [63:0] dma_GRegState_gpr_17_r;
    reg [63:0] dma_GRegState_gpr_18_r;
    reg [63:0] dma_GRegState_gpr_19_r;
    reg [63:0] dma_GRegState_gpr_20_r;
    reg [63:0] dma_GRegState_gpr_21_r;
    reg [63:0] dma_GRegState_gpr_22_r;
    reg [63:0] dma_GRegState_gpr_23_r;
    reg [63:0] dma_GRegState_gpr_24_r;
    reg [63:0] dma_GRegState_gpr_25_r;
    reg [63:0] dma_GRegState_gpr_26_r;
    reg [63:0] dma_GRegState_gpr_27_r;
    reg [63:0] dma_GRegState_gpr_28_r;
    reg [63:0] dma_GRegState_gpr_29_r;
    reg [63:0] dma_GRegState_gpr_30_r;
    reg [63:0] dma_GRegState_gpr_31_r;
    reg [63:0] dma_FPRegState_fpr_0_r;
    reg [63:0] dma_FPRegState_fpr_1_r;
    reg [63:0] dma_FPRegState_fpr_2_r;
    reg [63:0] dma_FPRegState_fpr_3_r;
    reg [63:0] dma_FPRegState_fpr_4_r;
    reg [63:0] dma_FPRegState_fpr_5_r;
    reg [63:0] dma_FPRegState_fpr_6_r;
    reg [63:0] dma_FPRegState_fpr_7_r;
    reg [63:0] dma_FPRegState_fpr_8_r;
    reg [63:0] dma_FPRegState_fpr_9_r;
    reg [63:0] dma_FPRegState_fpr_10_r;
    reg [63:0] dma_FPRegState_fpr_11_r;
    reg [63:0] dma_FPRegState_fpr_12_r;
    reg [63:0] dma_FPRegState_fpr_13_r;
    reg [63:0] dma_FPRegState_fpr_14_r;
    reg [63:0] dma_FPRegState_fpr_15_r;
    reg [63:0] dma_FPRegState_fpr_16_r;
    reg [63:0] dma_FPRegState_fpr_17_r;
    reg [63:0] dma_FPRegState_fpr_18_r;
    reg [63:0] dma_FPRegState_fpr_19_r;
    reg [63:0] dma_FPRegState_fpr_20_r;
    reg [63:0] dma_FPRegState_fpr_21_r;
    reg [63:0] dma_FPRegState_fpr_22_r;
    reg [63:0] dma_FPRegState_fpr_23_r;
    reg [63:0] dma_FPRegState_fpr_24_r;
    reg [63:0] dma_FPRegState_fpr_25_r;
    reg [63:0] dma_FPRegState_fpr_26_r;
    reg [63:0] dma_FPRegState_fpr_27_r;
    reg [63:0] dma_FPRegState_fpr_28_r;
    reg [63:0] dma_FPRegState_fpr_29_r;
    reg [63:0] dma_FPRegState_fpr_30_r;
    reg [63:0] dma_FPRegState_fpr_31_r;
    reg [7:0] dma_FPRegState_fccr_r;
    reg [31:0] dma_FPRegState_fcsr0_r;
    reg [TLB_EVT_NUM*8-1:0] dma_TLBEvent_source_r;
    reg [TLB_EVT_NUM*64-1:0] dma_TLBEvent_vpn_r;
    reg [TLB_EVT_NUM*64-1:0] dma_TLBEvent_ppn_r;
    reg [TLB_EVT_NUM*32-1:0] dma_TLBEvent_exception_r;

    reg init;

    wire [15:0] diff_valids;
    wire [7:0] trap_valids;
    wire [7:0] excp_valids;
    wire [15:0] commit_valids;
    wire [31:0] greg_valids;
    wire [33:0] fpreg_valids;
    wire [26:0] csr_valids;
    wire [7:0] store_valids;
    wire [7:0] load_valids;
    wire [15:0] tlb_valids;

    reg [15:0] diff_valids_s1;
    reg [7:0] trap_valids_s1;
    reg [7:0] excp_valids_s1;
    reg [15:0] commit_valids_s1;
    reg [31:0] greg_valids_s1;
    reg [33:0] fpreg_valids_s1;
    reg [26:0] csr_valids_s1;
    reg [7:0] store_valids_s1;
    reg [7:0] load_valids_s1;
    reg [15:0] tlb_valids_s1;

    reg [15:0] diff_valids_s2;
    reg [7:0] trap_valids_s2;
    reg [7:0] excp_valids_s2;
    reg [15:0] commit_valids_s2;
    reg [31:0] greg_valids_s2;
    reg [33:0] fpreg_valids_s2;
    reg [26:0] csr_valids_s2;
    reg [7:0] store_valids_s2;
    reg [7:0] load_valids_s2;
    reg [15:0] tlb_valids_s2;

    reg [7:0] diff_valids_s3;
    reg [15:0] commit_valids_s3;

    reg [7:0] diff_valids_s4;
    reg [7:0] diff_valids_s5;
    genvar i;

    reg [2:0] num_rom[15:0];

    initial begin
        num_rom[0]  = 0;
        num_rom[1]  = 1;
        num_rom[2]  = 1;
        num_rom[3]  = 2;
        num_rom[4]  = 1;
        num_rom[5]  = 2;
        num_rom[6]  = 2;
        num_rom[7]  = 3;
        num_rom[8]  = 1;
        num_rom[9]  = 2;
        num_rom[10] = 2;
        num_rom[11] = 3;
        num_rom[12] = 2;
        num_rom[13] = 3;
        num_rom[14] = 3;
        num_rom[15] = 4;
    end


    always @(posedge axi_clk or negedge axi_resetn) begin
        if (!axi_resetn) begin
            init <= 1'b0;
        end else begin
            if (dma_InstrCommit_valid) begin
                init <= 1'b1;
            end
        end
    end

    always @(posedge axi_clk) begin
        if (!init || diff_valids[2]) begin
            dma_InstrCommit_pc_r <= dma_InstrCommit_pc;
            dma_InstrCommit_instr_r <= dma_InstrCommit_instr;
            dma_InstrCommit_skip_r <= dma_InstrCommit_skip;
            dma_InstrCommit_is_TLBFILL_r <= dma_InstrCommit_is_TLBFILL;
            dma_InstrCommit_TLBFILL_index_r <= dma_InstrCommit_TLBFILL_index;
            dma_InstrCommit_is_CNTinst_r <= dma_InstrCommit_is_CNTinst;
            dma_InstrCommit_timer_64_value_r <= dma_InstrCommit_timer_64_value;
            dma_InstrCommit_wen_r <= dma_InstrCommit_wen;
            dma_InstrCommit_wdest_r <= dma_InstrCommit_wdest;
            dma_InstrCommit_wdata_r <= dma_InstrCommit_wdata;
            dma_InstrCommit_csr_rstat_r <= dma_InstrCommit_csr_rstat;
            dma_InstrCommit_csr_data_r <= dma_InstrCommit_csr_data;
        end
        if (!init || diff_valids[1]) begin
            dma_ExcpEvent_eret_r <= dma_ExcpEvent_eret_s1;
            dma_ExcpEvent_intrNo_r <= dma_ExcpEvent_intrNo_s1;
            dma_ExcpEvent_cause_r <= dma_ExcpEvent_cause_s1;
            dma_ExcpEvent_exceptionPC_r <= dma_ExcpEvent_exceptionPC_s1;
            dma_ExcpEvent_exceptionInst_r <= dma_ExcpEvent_exceptionInst_s1;
        end
        if (!init || diff_valids[0]) begin
            dma_TrapEvent_code_r <= dma_TrapEvent_code;
            dma_TrapEvent_pc_r <= dma_TrapEvent_pc;
            dma_TrapEvent_cycleCnt_r <= dma_TrapEvent_cycleCnt;
            dma_TrapEvent_instrCnt_r <= dma_TrapEvent_instrCnt;
        end
        if (!init || diff_valids[6]) begin
            dma_StoreEvent_storePAddr_r <= dma_StoreEvent_storePAddr;
            dma_StoreEvent_storeData_r  <= dma_StoreEvent_storeData;
            dma_StoreEvent_storeMask_r  <= dma_StoreEvent_storeMask;
        end
        if (!init || diff_valids[7]) begin
            dma_LoadEvent_paddr_r <= dma_LoadEvent_paddr;
            dma_LoadEvent_vaddr_r <= dma_LoadEvent_vaddr;
        end
        if (!init || diff_valids[5]) begin
            dma_CSRRegState_crmd_r <= dma_CSRRegState_crmd_s1;
            dma_CSRRegState_prmd_r <= dma_CSRRegState_prmd_s1;
            dma_CSRRegState_euen_r <= dma_CSRRegState_euen_s1;
            dma_CSRRegState_ecfg_r <= dma_CSRRegState_ecfg_s1;
            dma_CSRRegState_estat_r <= dma_CSRRegState_estat_s1;
            dma_CSRRegState_era_r <= dma_CSRRegState_era_s1;
            dma_CSRRegState_badv_r <= dma_CSRRegState_badv_s1;
            dma_CSRRegState_eentry_r <= dma_CSRRegState_eentry_s1;
            dma_CSRRegState_tlbidx_r <= dma_CSRRegState_tlbidx_s1;
            dma_CSRRegState_tlbehi_r <= dma_CSRRegState_tlbehi_s1;
            dma_CSRRegState_tlbelo0_r <= dma_CSRRegState_tlbelo0_s1;
            dma_CSRRegState_tlbelo1_r <= dma_CSRRegState_tlbelo1_s1;
            dma_CSRRegState_asid_r <= dma_CSRRegState_asid_s1;
            dma_CSRRegState_pgdl_r <= dma_CSRRegState_pgdl_s1;
            dma_CSRRegState_pgdh_r <= dma_CSRRegState_pgdh_s1;
            dma_CSRRegState_save0_r <= dma_CSRRegState_save0_s1;
            dma_CSRRegState_save1_r <= dma_CSRRegState_save1_s1;
            dma_CSRRegState_save2_r <= dma_CSRRegState_save2_s1;
            dma_CSRRegState_save3_r <= dma_CSRRegState_save3_s1;
            dma_CSRRegState_tid_r <= dma_CSRRegState_tid_s1;
            dma_CSRRegState_tcfg_r <= dma_CSRRegState_tcfg_s1;
            dma_CSRRegState_tval_r <= dma_CSRRegState_tval_s1;
            dma_CSRRegState_ticlr_r <= dma_CSRRegState_ticlr_s1;
            dma_CSRRegState_llbctl_r <= dma_CSRRegState_llbctl_s1;
            dma_CSRRegState_tlbrentry_r <= dma_CSRRegState_tlbrentry_s1;
            dma_CSRRegState_dmw0_r <= dma_CSRRegState_dmw0_s1;
            dma_CSRRegState_dmw1_r <= dma_CSRRegState_dmw1_s1;
        end
        if (!init || diff_valids[3]) begin
            dma_GRegState_gpr_0_r  <= dma_GRegState_gpr_0_s1;
            dma_GRegState_gpr_1_r  <= dma_GRegState_gpr_1_s1;
            dma_GRegState_gpr_2_r  <= dma_GRegState_gpr_2_s1;
            dma_GRegState_gpr_3_r  <= dma_GRegState_gpr_3_s1;
            dma_GRegState_gpr_4_r  <= dma_GRegState_gpr_4_s1;
            dma_GRegState_gpr_5_r  <= dma_GRegState_gpr_5_s1;
            dma_GRegState_gpr_6_r  <= dma_GRegState_gpr_6_s1;
            dma_GRegState_gpr_7_r  <= dma_GRegState_gpr_7_s1;
            dma_GRegState_gpr_8_r  <= dma_GRegState_gpr_8_s1;
            dma_GRegState_gpr_9_r  <= dma_GRegState_gpr_9_s1;
            dma_GRegState_gpr_10_r <= dma_GRegState_gpr_10_s1;
            dma_GRegState_gpr_11_r <= dma_GRegState_gpr_11_s1;
            dma_GRegState_gpr_12_r <= dma_GRegState_gpr_12_s1;
            dma_GRegState_gpr_13_r <= dma_GRegState_gpr_13_s1;
            dma_GRegState_gpr_14_r <= dma_GRegState_gpr_14_s1;
            dma_GRegState_gpr_15_r <= dma_GRegState_gpr_15_s1;
            dma_GRegState_gpr_16_r <= dma_GRegState_gpr_16_s1;
            dma_GRegState_gpr_17_r <= dma_GRegState_gpr_17_s1;
            dma_GRegState_gpr_18_r <= dma_GRegState_gpr_18_s1;
            dma_GRegState_gpr_19_r <= dma_GRegState_gpr_19_s1;
            dma_GRegState_gpr_20_r <= dma_GRegState_gpr_20_s1;
            dma_GRegState_gpr_21_r <= dma_GRegState_gpr_21_s1;
            dma_GRegState_gpr_22_r <= dma_GRegState_gpr_22_s1;
            dma_GRegState_gpr_23_r <= dma_GRegState_gpr_23_s1;
            dma_GRegState_gpr_24_r <= dma_GRegState_gpr_24_s1;
            dma_GRegState_gpr_25_r <= dma_GRegState_gpr_25_s1;
            dma_GRegState_gpr_26_r <= dma_GRegState_gpr_26_s1;
            dma_GRegState_gpr_27_r <= dma_GRegState_gpr_27_s1;
            dma_GRegState_gpr_28_r <= dma_GRegState_gpr_28_s1;
            dma_GRegState_gpr_29_r <= dma_GRegState_gpr_29_s1;
            dma_GRegState_gpr_30_r <= dma_GRegState_gpr_30_s1;
            dma_GRegState_gpr_31_r <= dma_GRegState_gpr_31_s1;
        end
        if (!init || diff_valids[4]) begin
            dma_FPRegState_fpr_0_r  <= dma_FPRegState_fpr_0_s1;
            dma_FPRegState_fpr_1_r  <= dma_FPRegState_fpr_1_s1;
            dma_FPRegState_fpr_2_r  <= dma_FPRegState_fpr_2_s1;
            dma_FPRegState_fpr_3_r  <= dma_FPRegState_fpr_3_s1;
            dma_FPRegState_fpr_4_r  <= dma_FPRegState_fpr_4_s1;
            dma_FPRegState_fpr_5_r  <= dma_FPRegState_fpr_5_s1;
            dma_FPRegState_fpr_6_r  <= dma_FPRegState_fpr_6_s1;
            dma_FPRegState_fpr_7_r  <= dma_FPRegState_fpr_7_s1;
            dma_FPRegState_fpr_8_r  <= dma_FPRegState_fpr_8_s1;
            dma_FPRegState_fpr_9_r  <= dma_FPRegState_fpr_9_s1;
            dma_FPRegState_fpr_10_r <= dma_FPRegState_fpr_10_s1;
            dma_FPRegState_fpr_11_r <= dma_FPRegState_fpr_11_s1;
            dma_FPRegState_fpr_12_r <= dma_FPRegState_fpr_12_s1;
            dma_FPRegState_fpr_13_r <= dma_FPRegState_fpr_13_s1;
            dma_FPRegState_fpr_14_r <= dma_FPRegState_fpr_14_s1;
            dma_FPRegState_fpr_15_r <= dma_FPRegState_fpr_15_s1;
            dma_FPRegState_fpr_16_r <= dma_FPRegState_fpr_16_s1;
            dma_FPRegState_fpr_17_r <= dma_FPRegState_fpr_17_s1;
            dma_FPRegState_fpr_18_r <= dma_FPRegState_fpr_18_s1;
            dma_FPRegState_fpr_19_r <= dma_FPRegState_fpr_19_s1;
            dma_FPRegState_fpr_20_r <= dma_FPRegState_fpr_20_s1;
            dma_FPRegState_fpr_21_r <= dma_FPRegState_fpr_21_s1;
            dma_FPRegState_fpr_22_r <= dma_FPRegState_fpr_22_s1;
            dma_FPRegState_fpr_23_r <= dma_FPRegState_fpr_23_s1;
            dma_FPRegState_fpr_24_r <= dma_FPRegState_fpr_24_s1;
            dma_FPRegState_fpr_25_r <= dma_FPRegState_fpr_25_s1;
            dma_FPRegState_fpr_26_r <= dma_FPRegState_fpr_26_s1;
            dma_FPRegState_fpr_27_r <= dma_FPRegState_fpr_27_s1;
            dma_FPRegState_fpr_28_r <= dma_FPRegState_fpr_28_s1;
            dma_FPRegState_fpr_29_r <= dma_FPRegState_fpr_29_s1;
            dma_FPRegState_fpr_30_r <= dma_FPRegState_fpr_30_s1;
            dma_FPRegState_fpr_31_r <= dma_FPRegState_fpr_31_s1;
            dma_FPRegState_fccr_r   <= dma_FPRegState_fccr_s1;
            dma_FPRegState_fcsr0_r  <= dma_FPRegState_fcsr0_s1;
        end
        if (!init || diff_valids[8]) begin
            dma_TLBEvent_source_r[0+:8] <= dma_TLBEvent_source[0+:8];
            dma_TLBEvent_vpn_r[0+:64] <= dma_TLBEvent_vpn[0+:64];
            dma_TLBEvent_ppn_r[0+:64] <= dma_TLBEvent_ppn[0+:64];
            dma_TLBEvent_exception_r[0+:32] <= dma_TLBEvent_exception[0+:32];
        end
        if (!init || diff_valids[9]) begin
            dma_TLBEvent_source_r[8+:8] <= dma_TLBEvent_source[8+:8];
            dma_TLBEvent_vpn_r[64+:64] <= dma_TLBEvent_vpn[64+:64];
            dma_TLBEvent_ppn_r[64+:64] <= dma_TLBEvent_ppn[64+:64];
            dma_TLBEvent_exception_r[32+:32] <= dma_TLBEvent_exception[32+:32];
        end
    end

    assign diff_valids = {
        6'b0,
        // dma_TLBEvent_valid,
        1'b0,
        dma_LoadEvent_valid[0],
        dma_StoreEvent_valid[0],
        (|csr_valids) & dma_InstrCommit_valid,
        (|fpreg_valids) & dma_InstrCommit_valid,
        (|greg_valids) & dma_InstrCommit_valid,
        dma_InstrCommit_valid,
        dma_ExcpEvent_excp_valid,
        dma_TrapEvent_valid
    };


    assign trap_valids[0] = |(dma_TrapEvent_code ^ dma_TrapEvent_code_r);
    assign trap_valids[1] = |(dma_TrapEvent_pc ^ dma_TrapEvent_pc_r);
    assign trap_valids[2] = |(dma_TrapEvent_cycleCnt ^ dma_TrapEvent_cycleCnt_r);
    assign trap_valids[3] = |(dma_TrapEvent_instrCnt ^ dma_TrapEvent_instrCnt_r);
    assign trap_valids[7:4] = 4'b0;

    assign excp_valids[0] = |(dma_ExcpEvent_eret_s1 ^ dma_ExcpEvent_eret_r);
    assign excp_valids[1] = |(dma_ExcpEvent_intrNo_s1 ^ dma_ExcpEvent_intrNo_r);
    assign excp_valids[2] = |(dma_ExcpEvent_cause_s1 ^ dma_ExcpEvent_cause_r);
    assign excp_valids[3] = |(dma_ExcpEvent_exceptionPC_s1 ^ dma_ExcpEvent_exceptionPC_r);
    assign excp_valids[4] = |(dma_ExcpEvent_exceptionInst_s1 ^ dma_ExcpEvent_exceptionInst_r);
    assign excp_valids[7:5] = 3'b0;

    assign commit_valids[0] = |(dma_InstrCommit_pc ^ dma_InstrCommit_pc_r);
    assign commit_valids[1] = |(dma_InstrCommit_instr ^ dma_InstrCommit_instr_r);
    assign commit_valids[2] = |(dma_InstrCommit_skip ^ dma_InstrCommit_skip_r);
    assign commit_valids[3] = |(dma_InstrCommit_is_TLBFILL ^ dma_InstrCommit_is_TLBFILL_r);
    assign commit_valids[4] = |(dma_InstrCommit_TLBFILL_index ^ dma_InstrCommit_TLBFILL_index_r);
    assign commit_valids[5] = |(dma_InstrCommit_is_CNTinst ^ dma_InstrCommit_is_CNTinst_r);
    assign commit_valids[6] = |(dma_InstrCommit_timer_64_value ^ dma_InstrCommit_timer_64_value_r);
    assign commit_valids[7] = |(dma_InstrCommit_wen ^ dma_InstrCommit_wen_r);
    assign commit_valids[8] = |(dma_InstrCommit_wdest ^ dma_InstrCommit_wdest_r);
    assign commit_valids[9] = |(dma_InstrCommit_wdata ^ dma_InstrCommit_wdata_r);
    assign commit_valids[10] = |(dma_InstrCommit_csr_rstat ^ dma_InstrCommit_csr_rstat_r);
    assign commit_valids[11] = |(dma_InstrCommit_csr_data ^ dma_InstrCommit_csr_data_r);
    assign commit_valids[15:12] = 4'b0;

    assign greg_valids[0] = |(dma_GRegState_gpr_0_s1 ^ dma_GRegState_gpr_0_r);
    assign greg_valids[1] = |(dma_GRegState_gpr_1_s1 ^ dma_GRegState_gpr_1_r);
    assign greg_valids[2] = |(dma_GRegState_gpr_2_s1 ^ dma_GRegState_gpr_2_r);
    assign greg_valids[3] = |(dma_GRegState_gpr_3_s1 ^ dma_GRegState_gpr_3_r);
    assign greg_valids[4] = |(dma_GRegState_gpr_4_s1 ^ dma_GRegState_gpr_4_r);
    assign greg_valids[5] = |(dma_GRegState_gpr_5_s1 ^ dma_GRegState_gpr_5_r);
    assign greg_valids[6] = |(dma_GRegState_gpr_6_s1 ^ dma_GRegState_gpr_6_r);
    assign greg_valids[7] = |(dma_GRegState_gpr_7_s1 ^ dma_GRegState_gpr_7_r);
    assign greg_valids[8] = |(dma_GRegState_gpr_8_s1 ^ dma_GRegState_gpr_8_r);
    assign greg_valids[9] = |(dma_GRegState_gpr_9_s1 ^ dma_GRegState_gpr_9_r);
    assign greg_valids[10] = |(dma_GRegState_gpr_10_s1 ^ dma_GRegState_gpr_10_r);
    assign greg_valids[11] = |(dma_GRegState_gpr_11_s1 ^ dma_GRegState_gpr_11_r);
    assign greg_valids[12] = |(dma_GRegState_gpr_12_s1 ^ dma_GRegState_gpr_12_r);
    assign greg_valids[13] = |(dma_GRegState_gpr_13_s1 ^ dma_GRegState_gpr_13_r);
    assign greg_valids[14] = |(dma_GRegState_gpr_14_s1 ^ dma_GRegState_gpr_14_r);
    assign greg_valids[15] = |(dma_GRegState_gpr_15_s1 ^ dma_GRegState_gpr_15_r);
    assign greg_valids[16] = |(dma_GRegState_gpr_16_s1 ^ dma_GRegState_gpr_16_r);
    assign greg_valids[17] = |(dma_GRegState_gpr_17_s1 ^ dma_GRegState_gpr_17_r);
    assign greg_valids[18] = |(dma_GRegState_gpr_18_s1 ^ dma_GRegState_gpr_18_r);
    assign greg_valids[19] = |(dma_GRegState_gpr_19_s1 ^ dma_GRegState_gpr_19_r);
    assign greg_valids[20] = |(dma_GRegState_gpr_20_s1 ^ dma_GRegState_gpr_20_r);
    assign greg_valids[21] = |(dma_GRegState_gpr_21_s1 ^ dma_GRegState_gpr_21_r);
    assign greg_valids[22] = |(dma_GRegState_gpr_22_s1 ^ dma_GRegState_gpr_22_r);
    assign greg_valids[23] = |(dma_GRegState_gpr_23_s1 ^ dma_GRegState_gpr_23_r);
    assign greg_valids[24] = |(dma_GRegState_gpr_24_s1 ^ dma_GRegState_gpr_24_r);
    assign greg_valids[25] = |(dma_GRegState_gpr_25_s1 ^ dma_GRegState_gpr_25_r);
    assign greg_valids[26] = |(dma_GRegState_gpr_26_s1 ^ dma_GRegState_gpr_26_r);
    assign greg_valids[27] = |(dma_GRegState_gpr_27_s1 ^ dma_GRegState_gpr_27_r);
    assign greg_valids[28] = |(dma_GRegState_gpr_28_s1 ^ dma_GRegState_gpr_28_r);
    assign greg_valids[29] = |(dma_GRegState_gpr_29_s1 ^ dma_GRegState_gpr_29_r);
    assign greg_valids[30] = |(dma_GRegState_gpr_30_s1 ^ dma_GRegState_gpr_30_r);
    assign greg_valids[31] = |(dma_GRegState_gpr_31_s1 ^ dma_GRegState_gpr_31_r);

    assign fpreg_valids[0] = |(dma_FPRegState_fpr_0_s1 ^ dma_FPRegState_fpr_0_r);
    assign fpreg_valids[1] = |(dma_FPRegState_fpr_1_s1 ^ dma_FPRegState_fpr_1_r);
    assign fpreg_valids[2] = |(dma_FPRegState_fpr_2_s1 ^ dma_FPRegState_fpr_2_r);
    assign fpreg_valids[3] = |(dma_FPRegState_fpr_3_s1 ^ dma_FPRegState_fpr_3_r);
    assign fpreg_valids[4] = |(dma_FPRegState_fpr_4_s1 ^ dma_FPRegState_fpr_4_r);
    assign fpreg_valids[5] = |(dma_FPRegState_fpr_5_s1 ^ dma_FPRegState_fpr_5_r);
    assign fpreg_valids[6] = |(dma_FPRegState_fpr_6_s1 ^ dma_FPRegState_fpr_6_r);
    assign fpreg_valids[7] = |(dma_FPRegState_fpr_7_s1 ^ dma_FPRegState_fpr_7_r);
    assign fpreg_valids[8] = |(dma_FPRegState_fpr_8_s1 ^ dma_FPRegState_fpr_8_r);
    assign fpreg_valids[9] = |(dma_FPRegState_fpr_9_s1 ^ dma_FPRegState_fpr_9_r);
    assign fpreg_valids[10] = |(dma_FPRegState_fpr_10_s1 ^ dma_FPRegState_fpr_10_r);
    assign fpreg_valids[11] = |(dma_FPRegState_fpr_11_s1 ^ dma_FPRegState_fpr_11_r);
    assign fpreg_valids[12] = |(dma_FPRegState_fpr_12_s1 ^ dma_FPRegState_fpr_12_r);
    assign fpreg_valids[13] = |(dma_FPRegState_fpr_13_s1 ^ dma_FPRegState_fpr_13_r);
    assign fpreg_valids[14] = |(dma_FPRegState_fpr_14_s1 ^ dma_FPRegState_fpr_14_r);
    assign fpreg_valids[15] = |(dma_FPRegState_fpr_15_s1 ^ dma_FPRegState_fpr_15_r);
    assign fpreg_valids[16] = |(dma_FPRegState_fpr_16_s1 ^ dma_FPRegState_fpr_16_r);
    assign fpreg_valids[17] = |(dma_FPRegState_fpr_17_s1 ^ dma_FPRegState_fpr_17_r);
    assign fpreg_valids[18] = |(dma_FPRegState_fpr_18_s1 ^ dma_FPRegState_fpr_18_r);
    assign fpreg_valids[19] = |(dma_FPRegState_fpr_19_s1 ^ dma_FPRegState_fpr_19_r);
    assign fpreg_valids[20] = |(dma_FPRegState_fpr_20_s1 ^ dma_FPRegState_fpr_20_r);
    assign fpreg_valids[21] = |(dma_FPRegState_fpr_21_s1 ^ dma_FPRegState_fpr_21_r);
    assign fpreg_valids[22] = |(dma_FPRegState_fpr_22_s1 ^ dma_FPRegState_fpr_22_r);
    assign fpreg_valids[23] = |(dma_FPRegState_fpr_23_s1 ^ dma_FPRegState_fpr_23_r);
    assign fpreg_valids[24] = |(dma_FPRegState_fpr_24_s1 ^ dma_FPRegState_fpr_24_r);
    assign fpreg_valids[25] = |(dma_FPRegState_fpr_25_s1 ^ dma_FPRegState_fpr_25_r);
    assign fpreg_valids[26] = |(dma_FPRegState_fpr_26_s1 ^ dma_FPRegState_fpr_26_r);
    assign fpreg_valids[27] = |(dma_FPRegState_fpr_27_s1 ^ dma_FPRegState_fpr_27_r);
    assign fpreg_valids[28] = |(dma_FPRegState_fpr_28_s1 ^ dma_FPRegState_fpr_28_r);
    assign fpreg_valids[29] = |(dma_FPRegState_fpr_29_s1 ^ dma_FPRegState_fpr_29_r);
    assign fpreg_valids[30] = |(dma_FPRegState_fpr_30_s1 ^ dma_FPRegState_fpr_30_r);
    assign fpreg_valids[31] = |(dma_FPRegState_fpr_31_s1 ^ dma_FPRegState_fpr_31_r);
    assign fpreg_valids[32] = |(dma_FPRegState_fccr_s1 ^ dma_FPRegState_fccr_r);
    assign fpreg_valids[33] = |(dma_FPRegState_fcsr0_s1 ^ dma_FPRegState_fcsr0_r);

    assign csr_valids[0] = |(dma_CSRRegState_crmd_s1 ^ dma_CSRRegState_crmd_r);
    assign csr_valids[1] = |(dma_CSRRegState_prmd_s1 ^ dma_CSRRegState_prmd_r);
    assign csr_valids[2] = |(dma_CSRRegState_euen_s1 ^ dma_CSRRegState_euen_r);
    assign csr_valids[3] = |(dma_CSRRegState_ecfg_s1 ^ dma_CSRRegState_ecfg_r);
    assign csr_valids[4] = |(dma_CSRRegState_estat_s1 ^ dma_CSRRegState_estat_r);
    assign csr_valids[5] = |(dma_CSRRegState_era_s1 ^ dma_CSRRegState_era_r);
    assign csr_valids[6] = |(dma_CSRRegState_badv_s1 ^ dma_CSRRegState_badv_r);
    assign csr_valids[7] = |(dma_CSRRegState_eentry_s1 ^ dma_CSRRegState_eentry_r);
    assign csr_valids[8] = |(dma_CSRRegState_tlbidx_s1 ^ dma_CSRRegState_tlbidx_r);
    assign csr_valids[9] = |(dma_CSRRegState_tlbehi_s1 ^ dma_CSRRegState_tlbehi_r);
    assign csr_valids[10] = |(dma_CSRRegState_tlbelo0_s1 ^ dma_CSRRegState_tlbelo0_r);
    assign csr_valids[11] = |(dma_CSRRegState_tlbelo1_s1 ^ dma_CSRRegState_tlbelo1_r);
    assign csr_valids[12] = |(dma_CSRRegState_asid_s1 ^ dma_CSRRegState_asid_r);
    assign csr_valids[13] = |(dma_CSRRegState_pgdl_s1 ^ dma_CSRRegState_pgdl_r);
    assign csr_valids[14] = |(dma_CSRRegState_pgdh_s1 ^ dma_CSRRegState_pgdh_r);
    assign csr_valids[15] = |(dma_CSRRegState_save0_s1 ^ dma_CSRRegState_save0_r);
    assign csr_valids[16] = |(dma_CSRRegState_save1_s1 ^ dma_CSRRegState_save1_r);
    assign csr_valids[17] = |(dma_CSRRegState_save2_s1 ^ dma_CSRRegState_save2_r);
    assign csr_valids[18] = |(dma_CSRRegState_save3_s1 ^ dma_CSRRegState_save3_r);
    assign csr_valids[19] = |(dma_CSRRegState_tid_s1 ^ dma_CSRRegState_tid_r);
    assign csr_valids[20] = |(dma_CSRRegState_tcfg_s1 ^ dma_CSRRegState_tcfg_r);
    assign csr_valids[21] = |(dma_CSRRegState_tval_s1 ^ dma_CSRRegState_tval_r);
    assign csr_valids[22] = |(dma_CSRRegState_ticlr_s1 ^ dma_CSRRegState_ticlr_r);
    assign csr_valids[23] = |(dma_CSRRegState_llbctl_s1 ^ dma_CSRRegState_llbctl_r);
    assign csr_valids[24] = |(dma_CSRRegState_tlbrentry_s1 ^ dma_CSRRegState_tlbrentry_r);
    assign csr_valids[25] = |(dma_CSRRegState_dmw0_s1 ^ dma_CSRRegState_dmw0_r);
    assign csr_valids[26] = |(dma_CSRRegState_dmw1_s1 ^ dma_CSRRegState_dmw1_r);

    assign store_valids[0] = |(dma_StoreEvent_storePAddr ^ dma_StoreEvent_storePAddr_r);
    assign store_valids[1] = |(dma_StoreEvent_storeData ^ dma_StoreEvent_storeData_r);
    assign store_valids[2] = |(dma_StoreEvent_storeMask ^ dma_StoreEvent_storeMask_r);
    assign store_valids[7:3] = 5'b0;

    assign load_valids[0] = |(dma_LoadEvent_paddr ^ dma_LoadEvent_paddr_r);
    assign load_valids[1] = |(dma_LoadEvent_vaddr ^ dma_LoadEvent_vaddr_r);
    assign load_valids[7:2] = 6'b0;


    generate
        for (i = 0; i < TLB_EVT_NUM; i = i + 1) begin
            assign tlb_valids[i*8+0] = |(dma_TLBEvent_source ^ dma_TLBEvent_source_r);
            assign tlb_valids[i*8+1] = |(dma_TLBEvent_vpn ^ dma_TLBEvent_vpn_r);
            assign tlb_valids[i*8+2] = |(dma_TLBEvent_ppn ^ dma_TLBEvent_ppn_r);
            assign tlb_valids[i*8+3] = |(dma_TLBEvent_exception ^ dma_TLBEvent_exception_r);
            assign tlb_valids[i*8+4+:4] = 4'b0;
        end
    endgenerate

    always @(posedge axi_clk) begin
        diff_valids_s1   <= diff_valids;
        trap_valids_s1   <= trap_valids & {8{diff_valids[0]}};
        excp_valids_s1   <= excp_valids & {8{diff_valids[1]}};
        commit_valids_s1 <= commit_valids & {16{diff_valids[2]}};
        greg_valids_s1   <= greg_valids & {32{diff_valids[3]}};
        fpreg_valids_s1  <= fpreg_valids & {34{diff_valids[4]}};
        csr_valids_s1    <= csr_valids & {27{diff_valids[5]}};
        store_valids_s1  <= store_valids & {8{diff_valids[6]}};
        load_valids_s1   <= load_valids & {8{diff_valids[7]}};
        tlb_valids_s1    <= tlb_valids & {{8{diff_valids[9]}}, {8{diff_valids[8]}}};

        diff_valids_s2   <= diff_valids_s1;
        trap_valids_s2   <= trap_valids_s1;
        excp_valids_s2   <= excp_valids_s1;
        commit_valids_s2 <= commit_valids_s1;
        greg_valids_s2   <= greg_valids_s1;
        fpreg_valids_s2  <= fpreg_valids_s1;
        csr_valids_s2    <= csr_valids_s1;
        store_valids_s2  <= store_valids_s1;
        load_valids_s2   <= load_valids_s1;
        tlb_valids_s2    <= tlb_valids_s1;

        diff_valids_s3 <= {
            diff_valids_s2[9:6],
            |diff_valids_s2[5:3],
            diff_valids_s2[2:0]
        };
        commit_valids_s3 <= commit_valids_s2;

        diff_valids_s4 <= diff_valids_s3;
        diff_valids_s5 <= diff_valids_s4;
    end

    /********** compress *******************/
    reg [8 * 25 - 1:0] trap_data;
    reg [8 * 25 - 1:0] trap_data_s2;
    reg [4:0] trap_data_size;
    reg [7:0] trap_data_size_s2;

    always @(*) begin
        if (diff_valids_s1[0]) begin
            case (trap_valids_s1[3:0])
                4'b0000: trap_data_size = 5'd1;
                4'b0001: trap_data_size = 5'd2;
                4'b0010: trap_data_size = 5'd9;
                4'b0011: trap_data_size = 5'd10;
                4'b0100: trap_data_size = 5'd9;
                4'b0101: trap_data_size = 5'd10;
                4'b0110: trap_data_size = 5'd17;
                4'b0111: trap_data_size = 5'd18;
                4'b1000: trap_data_size = 5'd9;
                4'b1001: trap_data_size = 5'd10;
                4'b1010: trap_data_size = 5'd17;
                4'b1011: trap_data_size = 5'd18;
                4'b1100: trap_data_size = 5'd17;
                4'b1101: trap_data_size = 5'd18;
                4'b1110: trap_data_size = 5'd25;
                4'b1111: trap_data_size = 5'd26;
            endcase
        end else begin
            trap_data_size = 0;
        end
    end

    always @(*) begin
        case (trap_valids_s1[3:0])
            4'b0000: trap_data = 200'b0;
            4'b0001: trap_data = {192'b0, dma_TrapEvent_code_r};
            4'b0010: trap_data = {136'b0, dma_TrapEvent_pc_r};
            4'b0011: trap_data = {128'b0, dma_TrapEvent_pc_r, dma_TrapEvent_code_r};
            4'b0100: trap_data = {136'b0, dma_TrapEvent_cycleCnt_r};
            4'b0101: trap_data = {128'b0, dma_TrapEvent_cycleCnt_r, dma_TrapEvent_code_r};
            4'b0110: trap_data = {72'b0, dma_TrapEvent_cycleCnt_r, dma_TrapEvent_pc_r};
            4'b0111:
            trap_data = {64'b0, dma_TrapEvent_cycleCnt_r, dma_TrapEvent_pc_r, dma_TrapEvent_code_r};
            4'b1000: trap_data = {136'b0, dma_TrapEvent_instrCnt_r};
            4'b1001: trap_data = {128'b0, dma_TrapEvent_instrCnt_r, dma_TrapEvent_code_r};
            4'b1010: trap_data = {72'b0, dma_TrapEvent_instrCnt_r, dma_TrapEvent_pc_r};
            4'b1011:
            trap_data = {64'b0, dma_TrapEvent_instrCnt_r, dma_TrapEvent_pc_r, dma_TrapEvent_code_r};
            4'b1100: trap_data = {72'b0, dma_TrapEvent_instrCnt_r, dma_TrapEvent_cycleCnt_r};
            4'b1101:
            trap_data = {
                64'b0, dma_TrapEvent_instrCnt_r, dma_TrapEvent_cycleCnt_r, dma_TrapEvent_code_r
            };
            4'b1110:
            trap_data = {
                8'b0, dma_TrapEvent_instrCnt_r, dma_TrapEvent_cycleCnt_r, dma_TrapEvent_pc_r
            };
            4'b1111:
            trap_data = {
                dma_TrapEvent_instrCnt_r,
                dma_TrapEvent_cycleCnt_r,
                dma_TrapEvent_pc_r,
                dma_TrapEvent_code_r
            };
        endcase
    end
    always @(posedge axi_clk) begin
        trap_data_s2 <= trap_data;
        trap_data_size_s2 <= {trap_data_size, 3'b0};
    end


    reg [8 * 21 - 1:0] excp_data;
    reg [8 * 21 - 1:0] excp_data_s2;
    reg [4:0] excp_data_size;
    reg [7:0] excp_data_size_s2;

    always @(*) begin
        if (diff_valids_s1[1]) begin
            case (excp_valids_s1[4:0])
                5'b00000: excp_data_size = 5'd1;
                5'b00001: excp_data_size = 5'd2;
                5'b00010: excp_data_size = 5'd5;
                5'b00011: excp_data_size = 5'd6;
                5'b00100: excp_data_size = 5'd5;
                5'b00101: excp_data_size = 5'd6;
                5'b00110: excp_data_size = 5'd9;
                5'b00111: excp_data_size = 5'd10;
                5'b01000: excp_data_size = 5'd9;
                5'b01001: excp_data_size = 5'd10;
                5'b01010: excp_data_size = 5'd13;
                5'b01011: excp_data_size = 5'd14;
                5'b01100: excp_data_size = 5'd13;
                5'b01101: excp_data_size = 5'd14;
                5'b01110: excp_data_size = 5'd17;
                5'b01111: excp_data_size = 5'd18;
                5'b10000: excp_data_size = 5'd5;
                5'b10001: excp_data_size = 5'd6;
                5'b10010: excp_data_size = 5'd9;
                5'b10011: excp_data_size = 5'd10;
                5'b10100: excp_data_size = 5'd9;
                5'b10101: excp_data_size = 5'd10;
                5'b10110: excp_data_size = 5'd13;
                5'b10111: excp_data_size = 5'd14;
                5'b11000: excp_data_size = 5'd13;
                5'b11001: excp_data_size = 5'd14;
                5'b11010: excp_data_size = 5'd17;
                5'b11011: excp_data_size = 5'd18;
                5'b11100: excp_data_size = 5'd17;
                5'b11101: excp_data_size = 5'd18;
                5'b11110: excp_data_size = 5'd21;
                5'b11111: excp_data_size = 5'd22;
            endcase
        end else begin
            excp_data_size = 0;
        end
    end
    always @(*) begin
        case (excp_valids_s1[4:0])
            5'b00000: excp_data = 168'b0;
            5'b00001: excp_data = {160'b0, {7'b0, dma_ExcpEvent_eret_r}};
            5'b00010: excp_data = {136'b0, dma_ExcpEvent_intrNo_r};
            5'b00011: excp_data = {128'b0, dma_ExcpEvent_intrNo_r, {7'b0, dma_ExcpEvent_eret_r}};
            5'b00100: excp_data = {136'b0, dma_ExcpEvent_cause_r};
            5'b00101: excp_data = {128'b0, dma_ExcpEvent_cause_r, {7'b0, dma_ExcpEvent_eret_r}};
            5'b00110: excp_data = {104'b0, dma_ExcpEvent_cause_r, dma_ExcpEvent_intrNo_r};
            5'b00111:
            excp_data = {
                96'b0, dma_ExcpEvent_cause_r, dma_ExcpEvent_intrNo_r, {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b01000: excp_data = {104'b0, dma_ExcpEvent_exceptionPC_r};
            5'b01001:
            excp_data = {96'b0, dma_ExcpEvent_exceptionPC_r, {7'b0, dma_ExcpEvent_eret_r}};
            5'b01010: excp_data = {72'b0, dma_ExcpEvent_exceptionPC_r, dma_ExcpEvent_intrNo_r};
            5'b01011:
            excp_data = {
                64'b0,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_intrNo_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b01100: excp_data = {72'b0, dma_ExcpEvent_exceptionPC_r, dma_ExcpEvent_cause_r};
            5'b01101:
            excp_data = {
                64'b0,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_cause_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b01110:
            excp_data = {
                40'b0, dma_ExcpEvent_exceptionPC_r, dma_ExcpEvent_cause_r, dma_ExcpEvent_intrNo_r
            };
            5'b01111:
            excp_data = {
                32'b0,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_cause_r,
                dma_ExcpEvent_intrNo_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b10000: excp_data = {136'b0, dma_ExcpEvent_exceptionInst_r};
            5'b10001:
            excp_data = {128'b0, dma_ExcpEvent_exceptionInst_r, {7'b0, dma_ExcpEvent_eret_r}};
            5'b10010: excp_data = {104'b0, dma_ExcpEvent_exceptionInst_r, dma_ExcpEvent_intrNo_r};
            5'b10011:
            excp_data = {
                96'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_intrNo_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b10100: excp_data = {104'b0, dma_ExcpEvent_exceptionInst_r, dma_ExcpEvent_cause_r};
            5'b10101:
            excp_data = {
                96'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_cause_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b10110:
            excp_data = {
                72'b0, dma_ExcpEvent_exceptionInst_r, dma_ExcpEvent_cause_r, dma_ExcpEvent_intrNo_r
            };
            5'b10111:
            excp_data = {
                64'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_cause_r,
                dma_ExcpEvent_intrNo_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b11000:
            excp_data = {72'b0, dma_ExcpEvent_exceptionInst_r, dma_ExcpEvent_exceptionPC_r};
            5'b11001:
            excp_data = {
                64'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b11010:
            excp_data = {
                40'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_intrNo_r
            };
            5'b11011:
            excp_data = {
                32'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_intrNo_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b11100:
            excp_data = {
                40'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_cause_r
            };
            5'b11101:
            excp_data = {
                32'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_cause_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
            5'b11110:
            excp_data = {
                8'b0,
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_cause_r,
                dma_ExcpEvent_intrNo_r
            };
            5'b11111:
            excp_data = {
                dma_ExcpEvent_exceptionInst_r,
                dma_ExcpEvent_exceptionPC_r,
                dma_ExcpEvent_cause_r,
                dma_ExcpEvent_intrNo_r,
                {7'b0, dma_ExcpEvent_eret_r}
            };
        endcase
    end
    always @(posedge axi_clk) begin
        excp_data_s2 <= excp_data;
        excp_data_size_s2 <= {excp_data_size[4:0], 3'b0};
    end

    wire [8 * 39 - 1:0] commit_data_s2;
    wire [5:0] commit_data_size;
    reg [8:0] commit_data_size_s2;

    wire [63:0] commit_mask_pc;
    wire [31:0] commit_mask_inst;
    wire [7:0] commit_mask_skip;
    wire [7:0] commit_mask_is_TLBFILL;
    wire [7:0] commit_mask_TLBFILL_index;
    wire [7:0] commit_mask_is_CNTinst;
    wire [63:0] commit_mask_timer64_value;
    wire [7:0] commit_mask_wen;
    wire [7:0] commit_mask_wdest;
    wire [63:0] commit_mask_wdata;
    wire [7:0] commit_mask_csr_rstat;
    wire [31:0] commit_mask_csr_data;

    wire [5:0] commit_pc_idx;
    wire [5:0] commit_inst_idx;
    wire [5:0] commit_skip_idx;
    wire [5:0] commit_is_TLBFILL_idx;
    wire [5:0] commit_TLBFILL_index_idx;
    wire [5:0] commit_is_CNTinst_idx;
    wire [5:0] commit_timer64_value_idx;
    wire [5:0] commit_wen_idx;
    wire [5:0] commit_wdest_idx;
    wire [5:0] commit_wdata_idx;
    wire [5:0] commit_csr_rstat_idx;
    wire [5:0] commit_csr_data_idx;

    reg [63:0] commit_mask_pc_s2;
    reg [31:0] commit_mask_inst_s2;
    reg [7:0] commit_mask_skip_s2;
    reg [7:0] commit_mask_is_TLBFILL_s2;
    reg [7:0] commit_mask_TLBFILL_index_s2;
    reg [7:0] commit_mask_is_CNTinst_s2;
    reg [63:0] commit_mask_timer64_value_s2;
    reg [7:0] commit_mask_wen_s2;
    reg [7:0] commit_mask_wdest_s2;
    reg [63:0] commit_mask_wdata_s2;
    reg [7:0] commit_mask_csr_rstat_s2;
    reg [31:0] commit_mask_csr_data_s2;

    reg [5:0] commit_pc_idx_s2;
    reg [5:0] commit_inst_idx_s2;
    reg [5:0] commit_skip_idx_s2;
    reg [5:0] commit_is_TLBFILL_idx_s2;
    reg [5:0] commit_TLBFILL_index_idx_s2;
    reg [5:0] commit_is_CNTinst_idx_s2;
    reg [5:0] commit_timer64_value_idx_s2;
    reg [5:0] commit_wen_idx_s2;
    reg [5:0] commit_wdest_idx_s2;
    reg [5:0] commit_wdata_idx_s2;
    reg [5:0] commit_csr_rstat_idx_s2;
    reg [5:0] commit_csr_data_idx_s2;

    wire [311:0] commit_pc_vec;
    wire [311:0] commit_inst_vec;
    wire [311:0] commit_skip_vec;
    wire [311:0] commit_is_TLBFILL_vec;
    wire [311:0] commit_TLBFILL_index_vec;
    wire [311:0] commit_is_CNTinst_vec;
    wire [311:0] commit_timer64_value_vec;
    wire [311:0] commit_wen_vec;
    wire [311:0] commit_wdest_vec;
    wire [311:0] commit_wdata_vec;
    wire [311:0] commit_csr_rstat_vec;
    wire [311:0] commit_csr_data_vec;

    assign commit_mask_pc = {64{commit_valids_s1[0]}} & dma_InstrCommit_pc_r;
    assign commit_mask_inst = {32{commit_valids_s1[1]}} & dma_InstrCommit_instr_r;
    assign commit_mask_skip = {8{commit_valids_s1[2]}} & {7'b0, dma_InstrCommit_skip_r};
    assign commit_mask_is_TLBFILL = {8{commit_valids_s1[3]}} & {7'b0, dma_InstrCommit_is_TLBFILL_r};
    assign commit_mask_TLBFILL_index = {8{commit_valids_s1[4]}} & dma_InstrCommit_TLBFILL_index_r;
    assign commit_mask_is_CNTinst = {8{commit_valids_s1[5]}} & {7'b0, dma_InstrCommit_is_CNTinst_r};
    assign commit_mask_timer64_value = {64{commit_valids_s1[6]}} & dma_InstrCommit_timer_64_value_r;
    assign commit_mask_wen = {8{commit_valids_s1[7]}} & {7'b0, dma_InstrCommit_wen_r};
    assign commit_mask_wdest = {8{commit_valids_s1[8]}} & dma_InstrCommit_wdest_r;
    assign commit_mask_wdata = {64{commit_valids_s1[9]}} & dma_InstrCommit_wdata_r;
    assign commit_mask_csr_rstat = {8{commit_valids_s1[10]}} & {7'b0, dma_InstrCommit_csr_rstat_r};
    assign commit_mask_csr_data = {32{commit_valids_s1[11]}} & dma_InstrCommit_csr_data_r;

    assign commit_pc_idx = 0;
    assign commit_inst_idx = {4{commit_valids_s1[0]}} & 6'h8;
    assign commit_skip_idx = commit_inst_idx + ({4{commit_valids_s1[1]}} & 6'h4);
    assign commit_is_TLBFILL_idx = commit_skip_idx + commit_valids_s1[2];
    assign commit_TLBFILL_index_idx = commit_is_TLBFILL_idx + commit_valids_s1[3];
    assign commit_is_CNTinst_idx = commit_TLBFILL_index_idx + commit_valids_s1[4];
    assign commit_timer64_value_idx = commit_is_CNTinst_idx + commit_valids_s1[5];
    assign commit_wen_idx = commit_timer64_value_idx + ({4{commit_valids_s1[6]}} & 6'h8);
    assign commit_wdest_idx = commit_wen_idx + commit_valids_s1[7];
    assign commit_wdata_idx = commit_wdest_idx + commit_valids_s1[8];
    assign commit_csr_rstat_idx = commit_wdata_idx + ({4{commit_valids_s1[9]}} & 6'h8);
    assign commit_csr_data_idx = commit_csr_rstat_idx + commit_valids_s1[10];
    assign commit_data_size = {6{diff_valids_s1[2]}} & (commit_csr_data_idx + ({6{commit_valids_s1[11]}} & 6'h4) + 6'd2);

    always @(posedge axi_clk) begin
        commit_mask_pc_s2 <= commit_mask_pc;
        commit_mask_inst_s2 <= commit_mask_inst;
        commit_mask_skip_s2 <= commit_mask_skip;
        commit_mask_is_TLBFILL_s2 <= commit_mask_is_TLBFILL;
        commit_mask_TLBFILL_index_s2 <= commit_mask_TLBFILL_index;
        commit_mask_is_CNTinst_s2 <= commit_mask_is_CNTinst;
        commit_mask_timer64_value_s2 <= commit_mask_timer64_value;
        commit_mask_wen_s2 <= commit_mask_wen;
        commit_mask_wdest_s2 <= commit_mask_wdest;
        commit_mask_wdata_s2 <= commit_mask_wdata;
        commit_mask_csr_rstat_s2 <= commit_mask_csr_rstat;
        commit_mask_csr_data_s2 <= commit_mask_csr_data;

        commit_pc_idx_s2 <= commit_pc_idx;
        commit_inst_idx_s2 <= commit_inst_idx;
        commit_skip_idx_s2 <= commit_skip_idx;
        commit_is_TLBFILL_idx_s2 <= commit_is_TLBFILL_idx;
        commit_TLBFILL_index_idx_s2 <= commit_TLBFILL_index_idx;
        commit_is_CNTinst_idx_s2 <= commit_is_CNTinst_idx;
        commit_timer64_value_idx_s2 <= commit_timer64_value_idx;
        commit_wen_idx_s2 <= commit_wen_idx;
        commit_wdest_idx_s2 <= commit_wdest_idx;
        commit_wdata_idx_s2 <= commit_wdata_idx;
        commit_csr_rstat_idx_s2 <= commit_csr_rstat_idx;
        commit_csr_data_idx_s2 <= commit_csr_data_idx;
        commit_data_size_s2 <= {commit_data_size, 3'b0};
    end

    assign commit_pc_vec = commit_mask_pc_s2 << {commit_pc_idx_s2, 3'b0};
    assign commit_inst_vec = commit_mask_inst_s2 << {commit_inst_idx_s2, 3'b0};
    assign commit_skip_vec = commit_mask_skip_s2 << {commit_skip_idx_s2, 3'b0};
    assign commit_is_TLBFILL_vec = commit_mask_is_TLBFILL_s2 << {commit_is_TLBFILL_idx_s2, 3'b0};
    assign commit_TLBFILL_index_vec = commit_mask_TLBFILL_index_s2 << {commit_TLBFILL_index_idx_s2, 3'b0};
    assign commit_is_CNTinst_vec = commit_mask_is_CNTinst_s2 << {commit_is_CNTinst_idx_s2, 3'b0};
    assign commit_timer64_value_vec = commit_mask_timer64_value_s2 << {commit_timer64_value_idx_s2, 3'b0};
    assign commit_wen_vec = commit_mask_wen_s2 << {commit_wen_idx_s2, 3'b0};
    assign commit_wdest_vec = commit_mask_wdest_s2 << {commit_wdest_idx_s2, 3'b0};
    assign commit_wdata_vec = commit_mask_wdata_s2 << {commit_wdata_idx_s2, 3'b0};
    assign commit_csr_rstat_vec = commit_mask_csr_rstat_s2 << {commit_csr_rstat_idx_s2, 3'b0};
    assign commit_csr_data_vec = commit_mask_csr_data_s2 << {commit_csr_data_idx_s2, 3'b0};

    assign commit_data_s2 = commit_pc_vec | commit_inst_vec | commit_skip_vec |
                            commit_is_TLBFILL_vec | commit_TLBFILL_index_vec | commit_is_CNTinst_vec |
                            commit_timer64_value_vec | commit_wen_vec | commit_wdest_vec |
                            commit_wdata_vec | commit_csr_rstat_vec | commit_csr_data_vec;

    wire [72*32-1:0] greg_data_s1;
    reg [72*32-1:0] greg_data_s2_lvl1;
    wire [72*32-1:0] greg_data_s2_lvl2;
    wire [72*32-1:0] greg_data_s2_lvl3;
    wire [72*32-1:0] greg_data_s2;
    wire [3*8-1:0] greg_idx_lvl1;
    wire [4*4-1:0] greg_idx_lvl2;
    wire [5*2-1:0] greg_idx_lvl3;
    wire [5:0] greg_data_num;
    reg [3*8-1:0] greg_idx_lvl1_s2;
    reg [4*4-1:0] greg_idx_lvl2_s2;
    reg [5*2-1:0] greg_idx_lvl3_s2;
    reg [5:0] greg_data_num_s2;
    wire [11:0] greg_data_size_s2;

    generate
        for (i = 0; i < 8; i = i + 1) begin
            assign greg_idx_lvl1[i*3+:3] = num_rom[greg_valids_s1[i*4+:4]];
        end
        for (i = 0; i < 4; i = i + 1) begin
            assign greg_idx_lvl2[i*4+:4] = greg_idx_lvl1[i*6+:3] + greg_idx_lvl1[i*6+3+:3];
        end
    endgenerate
    assign greg_idx_lvl3[4:0] = greg_idx_lvl2[3:0] + greg_idx_lvl2[7:4];
    assign greg_idx_lvl3[9:5] = greg_idx_lvl2[11:8] + greg_idx_lvl2[15:12];
    assign greg_data_num = greg_idx_lvl3[4:0] + greg_idx_lvl3[9:5];
    assign greg_data_size_s2 = {12{diff_valids_s2[3]}} & ({greg_data_num_s2, 3'b0} + {greg_data_num_s2, 6'b0});

    compress_data4 compress_greg4_0 (
        .en(greg_valids_s1[0+:4]),
        .di({
            {dma_GRegState_gpr_3_r, 8'd3},
            {dma_GRegState_gpr_2_r, 8'd2},
            {dma_GRegState_gpr_1_r, 8'd1},
            {dma_GRegState_gpr_0_r, 8'd0}
        }),
        .d_o(greg_data_s1[0+:72*4])
    );
    compress_data4 compress_greg7_4 (
        .en(greg_valids_s1[4+:4]),
        .di({
            {dma_GRegState_gpr_7_r, 8'd7},
            {dma_GRegState_gpr_6_r, 8'd6},
            {dma_GRegState_gpr_5_r, 8'd5},
            {dma_GRegState_gpr_4_r, 8'd4}
        }),
        .d_o(greg_data_s1[72*4+:72*4])
    );
    compress_data4 compress_greg11_8 (
        .en(greg_valids_s1[8+:4]),
        .di({
            {dma_GRegState_gpr_11_r, 8'd11},
            {dma_GRegState_gpr_10_r, 8'd10},
            {dma_GRegState_gpr_9_r, 8'd9},
            {dma_GRegState_gpr_8_r, 8'd8}
        }),
        .d_o(greg_data_s1[72*8+:72*4])
    );
    compress_data4 compress_greg15_12 (
        .en(greg_valids_s1[12+:4]),
        .di({
            {dma_GRegState_gpr_15_r, 8'd15},
            {dma_GRegState_gpr_14_r, 8'd14},
            {dma_GRegState_gpr_13_r, 8'd13},
            {dma_GRegState_gpr_12_r, 8'd12}
        }),
        .d_o(greg_data_s1[72*12+:72*4])
    );
    compress_data4 compress_greg19_16 (
        .en(greg_valids_s1[16+:4]),
        .di({
            {dma_GRegState_gpr_19_r, 8'd19},
            {dma_GRegState_gpr_18_r, 8'd18},
            {dma_GRegState_gpr_17_r, 8'd17},
            {dma_GRegState_gpr_16_r, 8'd16}
        }),
        .d_o(greg_data_s1[72*16+:72*4])
    );
    compress_data4 compress_greg23_20 (
        .en(greg_valids_s1[20+:4]),
        .di({
            {dma_GRegState_gpr_23_r, 8'd23},
            {dma_GRegState_gpr_22_r, 8'd22},
            {dma_GRegState_gpr_21_r, 8'd21},
            {dma_GRegState_gpr_20_r, 8'd20}
        }),
        .d_o(greg_data_s1[72*20+:72*4])
    );
    compress_data4 compress_greg27_24 (
        .en(greg_valids_s1[24+:4]),
        .di({
            {dma_GRegState_gpr_27_r, 8'd27},
            {dma_GRegState_gpr_26_r, 8'd26},
            {dma_GRegState_gpr_25_r, 8'd25},
            {dma_GRegState_gpr_24_r, 8'd24}
        }),
        .d_o(greg_data_s1[72*24+:72*4])
    );
    compress_data4 compress_greg31_28 (
        .en(greg_valids_s1[28+:4]),
        .di({
            {dma_GRegState_gpr_31_r, 8'd31},
            {dma_GRegState_gpr_30_r, 8'd30},
            {dma_GRegState_gpr_29_r, 8'd29},
            {dma_GRegState_gpr_28_r, 8'd28}
        }),
        .d_o(greg_data_s1[72*28+:72*4])
    );
    compress_data_num4 compress_greg7_0 (
        .num(greg_idx_lvl1_s2[2:0]),
        .di0(greg_data_s2_lvl1[0+:72*4]),
        .di1(greg_data_s2_lvl1[72*4+:72*4]),
        .d_o(greg_data_s2_lvl2[0+:72*8])
    );
    compress_data_num4 compress_greg15_8 (
        .num(greg_idx_lvl1_s2[8:6]),
        .di0(greg_data_s2_lvl1[72*8+:72*4]),
        .di1(greg_data_s2_lvl1[72*12+:72*4]),
        .d_o(greg_data_s2_lvl2[72*8+:72*8])
    );
    compress_data_num4 compress_greg23_16 (
        .num(greg_idx_lvl1_s2[14:12]),
        .di0(greg_data_s2_lvl1[72*16+:72*4]),
        .di1(greg_data_s2_lvl1[72*20+:72*4]),
        .d_o(greg_data_s2_lvl2[72*16+:72*8])
    );
    compress_data_num4 compress_greg31_24 (
        .num(greg_idx_lvl1_s2[20:18]),
        .di0(greg_data_s2_lvl1[72*24+:72*4]),
        .di1(greg_data_s2_lvl1[72*28+:72*4]),
        .d_o(greg_data_s2_lvl2[72*24+:72*8])
    );
    compress_data_num8 compress_greg15_0 (
        .num(greg_idx_lvl2_s2[3:0]),
        .di0(greg_data_s2_lvl2[0+:72*8]),
        .di1(greg_data_s2_lvl2[72*8+:72*8]),
        .d_o(greg_data_s2_lvl3[0+:72*16])
    );
    compress_data_num8 compress_greg31_16 (
        .num(greg_idx_lvl2_s2[11:8]),
        .di0(greg_data_s2_lvl2[72*16+:72*8]),
        .di1(greg_data_s2_lvl2[72*24+:72*8]),
        .d_o(greg_data_s2_lvl3[72*16+:72*16])
    );
    compress_data_num16 compress_greg31_0 (
        .num(greg_idx_lvl3_s2[4:0]),
        .di0(greg_data_s2_lvl3[0+:72*16]),
        .di1(greg_data_s2_lvl3[72*16+:72*16]),
        .d_o(greg_data_s2)
    );
    always @(posedge axi_clk) begin
        greg_data_num_s2  <= greg_data_num;
        greg_data_s2_lvl1 <= greg_data_s1;
        greg_idx_lvl1_s2  <= greg_idx_lvl1;
        greg_idx_lvl2_s2  <= greg_idx_lvl2;
        greg_idx_lvl3_s2  <= greg_idx_lvl3;
    end

    wire [72*34-1:0] fpreg_data_s1;
    reg [72*34-1:0] fpreg_data_s2_lvl1;
    wire [72*34-1:0] fpreg_data_s2_lvl2;
    wire [72*34-1:0] fpreg_data_s2_lvl3;
    wire [72*34-1:0] fpreg_data_s2;
    wire [3*8-1:0] fpreg_idx_lvl1;
    wire [4*4-1:0] fpreg_idx_lvl2;
    wire [5*2-1:0] fpreg_idx_lvl3;

    wire [4:0] fpreg_idx[31:0];
    wire [5:0] fccr_idx;
    wire [5:0] fcsr0_idx;
    wire [5:0] fpreg_data_num;
    reg [5:0] fpreg_data_num_s2;
    reg [3*8-1:0] fpreg_idx_lvl1_s2;
    reg [4*4-1:0] fpreg_idx_lvl2_s2;
    reg [5*2-1:0] fpreg_idx_lvl3_s2;
    wire [11:0] fpreg_data_size_s2;

    assign fpreg_idx[0] = 0;
    generate
        for (i = 0; i < 7; i = i + 1) begin
            assign fpreg_idx_lvl1[i*3+:3] = num_rom[fpreg_valids_s1[i*4+:4]];
        end
        assign fpreg_idx_lvl1[21+:3] = fpreg_valids_s1[28] + fpreg_valids_s1[29] + fpreg_valids_s1[30] +
                                       fpreg_valids_s1[31] + fpreg_valids_s1[32] + fpreg_valids_s1[33];
        for (i = 0; i < 4; i = i + 1) begin
            assign fpreg_idx_lvl2[i*4+:4] = fpreg_idx_lvl1[i*6+:3] + fpreg_idx_lvl1[i*6+3+:3];
        end
    endgenerate
    assign fpreg_idx_lvl3[4:0] = fpreg_idx_lvl2[3:0] + fpreg_idx_lvl2[7:4];
    assign fpreg_idx_lvl3[9:5] = fpreg_idx_lvl2[11:8] + fpreg_idx_lvl2[15:12];
    assign fpreg_data_num = fpreg_idx_lvl3[4:0] + fpreg_idx_lvl3[9:5];
    assign fpreg_data_size_s2 = {12{diff_valids_s2[4]}} & ({fpreg_data_num_s2, 3'b0} + {fpreg_data_num_s2, 6'b0});

    // fpreg compress_data implementation
    compress_data4 compress_fpreg3_0 (
        .en(fpreg_valids_s1[0+:4]),
        .di({
            {dma_FPRegState_fpr_3_r, 8'd35},
            {dma_FPRegState_fpr_2_r, 8'd34},
            {dma_FPRegState_fpr_1_r, 8'd33},
            {dma_FPRegState_fpr_0_r, 8'd32}
        }),
        .d_o(fpreg_data_s1[0+:72*4])
    );
    compress_data4 compress_fpreg7_4 (
        .en(fpreg_valids_s1[4+:4]),
        .di({
            {dma_FPRegState_fpr_7_r, 8'd39},
            {dma_FPRegState_fpr_6_r, 8'd38},
            {dma_FPRegState_fpr_5_r, 8'd37},
            {dma_FPRegState_fpr_4_r, 8'd36}
        }),
        .d_o(fpreg_data_s1[72*4+:72*4])
    );
    compress_data4 compress_fpreg11_8 (
        .en(fpreg_valids_s1[8+:4]),
        .di({
            {dma_FPRegState_fpr_11_r, 8'd43},
            {dma_FPRegState_fpr_10_r, 8'd42},
            {dma_FPRegState_fpr_9_r, 8'd41},
            {dma_FPRegState_fpr_8_r, 8'd40}
        }),
        .d_o(fpreg_data_s1[72*8+:72*4])
    );
    compress_data4 compress_fpreg15_12 (
        .en(fpreg_valids_s1[12+:4]),
        .di({
            {dma_FPRegState_fpr_15_r, 8'd47},
            {dma_FPRegState_fpr_14_r, 8'd46},
            {dma_FPRegState_fpr_13_r, 8'd45},
            {dma_FPRegState_fpr_12_r, 8'd44}
        }),
        .d_o(fpreg_data_s1[72*12+:72*4])
    );
    compress_data4 compress_fpreg19_16 (
        .en(fpreg_valids_s1[16+:4]),
        .di({
            {dma_FPRegState_fpr_19_r, 8'd51},
            {dma_FPRegState_fpr_18_r, 8'd50},
            {dma_FPRegState_fpr_17_r, 8'd49},
            {dma_FPRegState_fpr_16_r, 8'd48}
        }),
        .d_o(fpreg_data_s1[72*16+:72*4])
    );
    compress_data4 compress_fpreg23_20 (
        .en(fpreg_valids_s1[20+:4]),
        .di({
            {dma_FPRegState_fpr_23_r, 8'd55},
            {dma_FPRegState_fpr_22_r, 8'd54},
            {dma_FPRegState_fpr_21_r, 8'd53},
            {dma_FPRegState_fpr_20_r, 8'd52}
        }),
        .d_o(fpreg_data_s1[72*20+:72*4])
    );
    compress_data4 compress_fpreg27_24 (
        .en(fpreg_valids_s1[24+:4]),
        .di({
            {dma_FPRegState_fpr_27_r, 8'd59},
            {dma_FPRegState_fpr_26_r, 8'd58},
            {dma_FPRegState_fpr_25_r, 8'd57},
            {dma_FPRegState_fpr_24_r, 8'd56}
        }),
        .d_o(fpreg_data_s1[72*24+:72*4])
    );
    compress_data6 compress_fpreg31_28_fccr_fcsr0 (
        .en(fpreg_valids_s1[28+:6]),
        .di({
            {{56'd0, dma_FPRegState_fccr_r}, 8'd65},
            {{32'd0, dma_FPRegState_fcsr0_r}, 8'd64},
            {dma_FPRegState_fpr_31_r, 8'd63},
            {dma_FPRegState_fpr_30_r, 8'd62},
            {dma_FPRegState_fpr_29_r, 8'd61},
            {dma_FPRegState_fpr_28_r, 8'd60}
        }),
        .d_o(fpreg_data_s1[72*28+:72*6])
    );
    compress_data_num4 compress_fpreg_7_0 (
        .num(fpreg_idx_lvl1_s2[2:0]),
        .di0(fpreg_data_s2_lvl1[0+:72*4]),
        .di1(fpreg_data_s2_lvl1[72*4+:72*4]),
        .d_o(fpreg_data_s2_lvl2[0+:72*8])
    );
    compress_data_num4 compress_fpreg_15_8 (
        .num(fpreg_idx_lvl1_s2[8:6]),
        .di0(fpreg_data_s2_lvl1[72*8+:72*4]),
        .di1(fpreg_data_s2_lvl1[72*12+:72*4]),
        .d_o(fpreg_data_s2_lvl2[72*8+:72*8])
    );
    compress_data_num4 compress_fpreg_23_16 (
        .num(fpreg_idx_lvl1_s2[14:12]),
        .di0(fpreg_data_s2_lvl1[72*16+:72*4]),
        .di1(fpreg_data_s2_lvl1[72*20+:72*4]),
        .d_o(fpreg_data_s2_lvl2[72*16+:72*8])
    );
    compress_data_num4 #(72, 6) compress_fpreg_33_24 (
        .num(fpreg_idx_lvl1_s2[20:18]),
        .di0(fpreg_data_s2_lvl1[72*24+:72*4]),
        .di1(fpreg_data_s2_lvl1[72*28+:72*6]),
        .d_o(fpreg_data_s2_lvl2[72*24+:72*10])
    );
    compress_data_num8 compress_fpreg_15_0 (
        .num(fpreg_idx_lvl2_s2[3:0]),
        .di0(fpreg_data_s2_lvl2[0+:72*8]),
        .di1(fpreg_data_s2_lvl2[72*8+:72*8]),
        .d_o(fpreg_data_s2_lvl3[0+:72*16])
    );
    compress_data_num8 #(72, 10) compress_fpreg_33_16 (
        .num(fpreg_idx_lvl2_s2[11:8]),
        .di0(fpreg_data_s2_lvl2[72*16+:72*8]),
        .di1(fpreg_data_s2_lvl2[72*24+:72*10]),
        .d_o(fpreg_data_s2_lvl3[72*16+:72*18])
    );
    compress_data_num16 #(72, 18) compress_fpreg_33_0 (
        .num(fpreg_idx_lvl3_s2[4:0]),
        .di0(fpreg_data_s2_lvl3[0+:72*16]),
        .di1(fpreg_data_s2_lvl3[72*16+:72*18]),
        .d_o(fpreg_data_s2)
    );
    always @(posedge axi_clk) begin
        fpreg_data_num_s2  <= fpreg_data_num;
        fpreg_data_s2_lvl1 <= fpreg_data_s1;
        fpreg_idx_lvl1_s2  <= fpreg_idx_lvl1;
        fpreg_idx_lvl2_s2  <= fpreg_idx_lvl2;
        fpreg_idx_lvl3_s2  <= fpreg_idx_lvl3;
    end
    wire [72*27-1:0] csr_data_s1;
    reg [72*27-1:0] csr_data_s2_lvl1;
    wire [72*27-1:0] csr_data_s2_lvl2;
    wire [72*27-1:0] csr_data_s2_lvl3;
    wire [72*27-1:0] csr_data_s2;
    wire [3*7-1:0] csr_idx_lvl1;
    wire [4*4-1:0] csr_idx_lvl2;
    wire [5*2-1:0] csr_idx_lvl3;
    wire [4:0] csr_data_num;
    reg [4:0] csr_data_num_s2;
    wire [11:0] csr_data_size_s2;
    reg [3*7-1:0] csr_idx_lvl1_s2;
    reg [4*4-1:0] csr_idx_lvl2_s2;
    reg [5*2-1:0] csr_idx_lvl3_s2;

    generate
        for (i = 0; i < 6; i = i + 1) begin
            assign csr_idx_lvl1[i*3+:3] = num_rom[csr_valids_s1[i*4+:4]];
        end
    endgenerate
    assign csr_idx_lvl1[18+:3] = csr_valids_s1[24] + csr_valids_s1[25] + csr_valids_s1[26];
    assign csr_idx_lvl2[3:0] = csr_idx_lvl1[2:0] + csr_idx_lvl1[5:3];
    assign csr_idx_lvl2[7:4] = csr_idx_lvl1[8:6] + csr_idx_lvl1[11:9];
    assign csr_idx_lvl2[11:8] = csr_idx_lvl1[14:12] + csr_idx_lvl1[17:15];
    assign csr_idx_lvl2[15:12] = {1'b0, csr_idx_lvl1[20:18]};
    assign csr_idx_lvl3[4:0] = csr_idx_lvl2[3:0] + csr_idx_lvl2[7:4];
    assign csr_idx_lvl3[9:5] = csr_idx_lvl2[11:8] + csr_idx_lvl2[15:12];
    assign csr_data_num = csr_idx_lvl3[4:0] + csr_idx_lvl3[9:5];
    assign csr_data_size_s2 = {12{diff_valids_s2[5]}} & ({csr_data_num_s2, 3'b0} + {csr_data_num_s2, 6'b0});

    compress_data4 compress_csr_3_0 (
        .en(csr_valids_s1[3:0]),
        .di({
            {dma_CSRRegState_ecfg_r, 8'd69},
            {dma_CSRRegState_euen_r, 8'd68},
            {dma_CSRRegState_prmd_r, 8'd67},
            {dma_CSRRegState_crmd_r, 8'd66}
        }),
        .d_o(csr_data_s1[0+:72*4])
    );
    compress_data4 compress_csr_7_4 (
        .en(csr_valids_s1[7:4]),
        .di({
            {dma_CSRRegState_eentry_r, 8'd73},
            {dma_CSRRegState_badv_r, 8'd72},
            {dma_CSRRegState_era_r, 8'd71},
            {dma_CSRRegState_estat_r, 8'd70}
        }),
        .d_o(csr_data_s1[72*4+:72*4])
    );
    compress_data4 compress_csr_11_8 (
        .en(csr_valids_s1[11:8]),
        .di({
            {dma_CSRRegState_tlbelo1_r, 8'd77},
            {dma_CSRRegState_tlbelo0_r, 8'd76},
            {dma_CSRRegState_tlbehi_r, 8'd75},
            {dma_CSRRegState_tlbidx_r, 8'd74}
        }),
        .d_o(csr_data_s1[72*8+:72*4])
    );
    compress_data4 compress_csr_15_12 (
        .en(csr_valids_s1[15:12]),
        .di({
            {dma_CSRRegState_save0_r, 8'd81},
            {dma_CSRRegState_pgdh_r, 8'd80},
            {dma_CSRRegState_pgdl_r, 8'd79},
            {dma_CSRRegState_asid_r, 8'd78}
        }),
        .d_o(csr_data_s1[72*12+:72*4])
    );
    compress_data4 compress_csr_19_16 (
        .en(csr_valids_s1[19:16]),
        .di({
            {dma_CSRRegState_tid_r, 8'd85},
            {dma_CSRRegState_save3_r, 8'd84},
            {dma_CSRRegState_save2_r, 8'd83},
            {dma_CSRRegState_save1_r, 8'd82}
        }),
        .d_o(csr_data_s1[72*16+:72*4])
    );
    compress_data4 compress_csr_23_20 (
        .en(csr_valids_s1[23:20]),
        .di({
            {dma_CSRRegState_llbctl_r, 8'd89},
            {dma_CSRRegState_ticlr_r, 8'd88},
            {dma_CSRRegState_tval_r, 8'd87},
            {dma_CSRRegState_tcfg_r, 8'd86}
        }),
        .d_o(csr_data_s1[72*20+:72*4])
    );
    compress_data3 compress_csr_26_24 (
        .en(csr_valids_s1[26:24]),
        .di({
            {dma_CSRRegState_dmw1_r, 8'd92},
            {dma_CSRRegState_dmw0_r, 8'd91},
            {dma_CSRRegState_tlbrentry_r, 8'd90}
        }),
        .d_o(csr_data_s1[72*24+:72*3])
    );

    // CSR多级压缩实现
    compress_data_num4 compress_csr_7_0 (
        .num(csr_idx_lvl1_s2[2:0]),
        .di0(csr_data_s2_lvl1[0+:72*4]),
        .di1(csr_data_s2_lvl1[72*4+:72*4]),
        .d_o(csr_data_s2_lvl2[0+:72*8])
    );
    compress_data_num4 compress_csr_15_8 (
        .num(csr_idx_lvl1_s2[8:6]),
        .di0(csr_data_s2_lvl1[72*8+:72*4]),
        .di1(csr_data_s2_lvl1[72*12+:72*4]),
        .d_o(csr_data_s2_lvl2[72*8+:72*8])
    );
    compress_data_num4 compress_csr_23_16 (
        .num(csr_idx_lvl1_s2[14:12]),
        .di0(csr_data_s2_lvl1[72*16+:72*4]),
        .di1(csr_data_s2_lvl1[72*20+:72*4]),
        .d_o(csr_data_s2_lvl2[72*16+:72*8])
    );
    assign csr_data_s2_lvl2[72*24+:72*3] = csr_data_s2_lvl1[72*24+:72*3];
    compress_data_num8 compress_csr_15_0 (
        .num(csr_idx_lvl2_s2[3:0]),
        .di0(csr_data_s2_lvl2[0+:72*8]),
        .di1(csr_data_s2_lvl2[72*8+:72*8]),
        .d_o(csr_data_s2_lvl3[0+:72*16])
    );
    compress_data_num8 #(72, 3) compress_csr_26_16 (
        .num(csr_idx_lvl2_s2[11:8]),
        .di0(csr_data_s2_lvl2[72*16+:72*8]),
        .di1(csr_data_s2_lvl2[72*24+:72*3]),
        .d_o(csr_data_s2_lvl3[72*16+:72*11])
    );

    compress_data_num16 #(72, 11) compress_csr_26_0 (
        .num(csr_idx_lvl3_s2[4:0]),
        .di0(csr_data_s2_lvl3[0+:72*16]),
        .di1(csr_data_s2_lvl3[72*16+:72*11]),
        .d_o(csr_data_s2)
    );

    always @(posedge axi_clk) begin
        csr_data_num_s2  <= csr_data_num;
        csr_data_s2_lvl1 <= csr_data_s1;
        csr_idx_lvl1_s2  <= csr_idx_lvl1;
        csr_idx_lvl2_s2  <= csr_idx_lvl2;
        csr_idx_lvl3_s2  <= csr_idx_lvl3;
    end

    reg [8 * 17 -1:0] store_data_s2;
    reg [4:0] store_data_size;
    reg [7:0] store_data_size_s2;

    always @(*) begin
        if (diff_valids_s1[6]) begin
            case (store_valids_s1[2:0])
                3'b000: store_data_size = 5'd1;
                3'b001: store_data_size = 5'd9;
                3'b010: store_data_size = 5'd9;
                3'b011: store_data_size = 5'd17;
                3'b100: store_data_size = 5'd2;
                3'b101: store_data_size = 5'd10;
                3'b110: store_data_size = 5'd10;
                3'b111: store_data_size = 5'd18;
            endcase
        end else begin
            store_data_size = 0;
        end
    end

    always @(posedge axi_clk) begin
        store_data_size_s2 <= {store_data_size, 3'b0};
        case (store_valids_s1[2:0])
            3'b000: store_data_s2 <= 136'b0;
            3'b001: store_data_s2 <= {{136 - 64{1'b0}}, dma_StoreEvent_storePAddr_r};
            3'b010: store_data_s2 <= {{136 - 64{1'b0}}, dma_StoreEvent_storeData_r};
            3'b011:
            store_data_s2 <= {
                {136 - 128{1'b0}}, dma_StoreEvent_storeData_r, dma_StoreEvent_storePAddr_r
            };
            3'b100: store_data_s2 <= {{136 - 8{1'b0}}, dma_StoreEvent_storeMask_r};
            3'b101:
            store_data_s2 <= {
                {136 - 72{1'b0}}, dma_StoreEvent_storeMask_r, dma_StoreEvent_storePAddr_r
            };
            3'b110:
            store_data_s2 <= {
                {136 - 72{1'b0}}, dma_StoreEvent_storeMask_r, dma_StoreEvent_storeData_r
            };
            3'b111:
            store_data_s2 <= {
                dma_StoreEvent_storeMask_r, dma_StoreEvent_storeData_r, dma_StoreEvent_storePAddr_r
            };
        endcase
    end

    reg [8 * 16 - 1:0] load_data_s2;
    reg [4:0] load_data_size;
    reg [7:0] load_data_size_s2;

    always @(*) begin
        if (diff_valids_s1[7]) begin
            case (load_valids_s1[1:0])
                2'b00: load_data_size = 5'd1;
                2'b01: load_data_size = 5'd9;
                2'b10: load_data_size = 5'd9;
                2'b11: load_data_size = 5'd17;
            endcase
        end else begin
            load_data_size = 0;
        end
    end

    always @(posedge axi_clk) begin
        load_data_size_s2 <= {load_data_size, 3'b0};
        case (load_valids_s1[1:0])
            2'b00: load_data_s2 <= 128'b0;
            2'b01: load_data_s2 <= {{128 - 64{1'b0}}, dma_LoadEvent_paddr_r};
            2'b10: load_data_s2 <= {{128 - 64{1'b0}}, dma_LoadEvent_vaddr_r};
            2'b11: load_data_s2 <= {dma_LoadEvent_vaddr_r, dma_LoadEvent_paddr_r};
        endcase
    end

    reg [TLB_EVT_NUM * 8 * 21 - 1:0] tlb_data_s2;
    reg [TLB_EVT_NUM * 5 - 1:0] tlb_data_size;
    reg [TLB_EVT_NUM * 8 - 1:0] tlb_data_size_s2;

    generate
        for (i = 0; i < TLB_EVT_NUM; i = i + 1) begin
            always @(*) begin
                if (diff_valids_s1[8+i]) begin
                    case (tlb_valids_s1[i*8+3 : i*8])
                        4'b0000: tlb_data_size[i*5+:5] = 5'd1;
                        4'b0001: tlb_data_size[i*5+:5] = 5'd2;
                        4'b0010: tlb_data_size[i*5+:5] = 5'd9;
                        4'b0011: tlb_data_size[i*5+:5] = 5'd10;
                        4'b0100: tlb_data_size[i*5+:5] = 5'd9;
                        4'b0101: tlb_data_size[i*5+:5] = 5'd10;
                        4'b0110: tlb_data_size[i*5+:5] = 5'd17;
                        4'b0111: tlb_data_size[i*5+:5] = 5'd18;
                        4'b1000: tlb_data_size[i*5+:5] = 5'd5;
                        4'b1001: tlb_data_size[i*5+:5] = 5'd6;
                        4'b1010: tlb_data_size[i*5+:5] = 5'd13;
                        4'b1011: tlb_data_size[i*5+:5] = 5'd14;
                        4'b1100: tlb_data_size[i*5+:5] = 5'd13;
                        4'b1101: tlb_data_size[i*5+:5] = 5'd14;
                        4'b1110: tlb_data_size[i*5+:5] = 5'd21;
                        4'b1111: tlb_data_size[i*5+:5] = 5'd22;
                    endcase
                end else begin
                    tlb_data_size[i*5+:5] = 5'd0;
                end
            end
            always @(posedge axi_clk) begin
                tlb_data_size_s2[i*8+:8] <= {tlb_data_size[i*5+:5], 3'b0};
                case (tlb_valids_s1[i*8+3 : i*8])
                    4'b0000: tlb_data_s2[i*168+:168] <= 168'b0;
                    4'b0001:
                    tlb_data_s2[i*168+:168] <= {{168 - 8{1'b0}}, dma_TLBEvent_source_r[i*8+:8]};
                    4'b0010:
                    tlb_data_s2[i*168+:168] <= {{168 - 64{1'b0}}, dma_TLBEvent_vpn_r[i*64+:64]};
                    4'b0011:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 72{1'b0}},
                        dma_TLBEvent_vpn_r[i*64+:64],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                    4'b0100:
                    tlb_data_s2[i*168+:168] <= {{168 - 64{1'b0}}, dma_TLBEvent_ppn_r[i*64+:64]};
                    4'b0101:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 72{1'b0}},
                        dma_TLBEvent_ppn_r[i*64+:64],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                    4'b0110:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 128{1'b0}},
                        dma_TLBEvent_ppn_r[i*64+:64],
                        dma_TLBEvent_vpn_r[i*64+:64]
                    };
                    4'b0111:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 136{1'b0}},
                        dma_TLBEvent_ppn_r[i*64+:64],
                        dma_TLBEvent_vpn_r[i*64+:64],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                    4'b1000:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 32{1'b0}}, dma_TLBEvent_exception_r[i*32+:32]
                    };
                    4'b1001:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 40{1'b0}},
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                    4'b1010:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 96{1'b0}},
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_vpn_r[i*64+:64]
                    };
                    4'b1011:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 104{1'b0}},
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_vpn_r[i*64+:64],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                    4'b1100:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 96{1'b0}},
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_ppn_r[i*64+:64]
                    };
                    4'b1101:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 104{1'b0}},
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_ppn_r[i*64+:64],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                    4'b1110:
                    tlb_data_s2[i*168+:168] <= {
                        {168 - 160{1'b0}},
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_ppn_r[i*64+:64],
                        dma_TLBEvent_vpn_r[i*64+:64]
                    };
                    4'b1111:
                    tlb_data_s2[i*168+:168] <= {
                        dma_TLBEvent_exception_r[i*32+:32],
                        dma_TLBEvent_ppn_r[i*64+:64],
                        dma_TLBEvent_vpn_r[i*64+:64],
                        dma_TLBEvent_source_r[i*8+:8]
                    };
                endcase
            end
        end
    endgenerate

    // combine
    wire [8 * 48 - 1:0] trap_excp_data_s2;
    wire [8:0] trap_excp_data_size_s2;
    wire [8 * 35 - 1:0] store_load_data_s2;
    wire [8:0] store_load_data_size_s2;
    wire [TLB_EVT_NUM * 8 * 22 - 1:0] tlb_data_cmb_s2;
    wire [8:0] tlb_data_cmb_size_s2;

    reg [8 * 48 - 1:0] trap_excp_data_s3;
    reg [8:0] trap_excp_data_size_s3;
    reg [8 * 35 - 1:0] store_load_data_s3;
    reg [8:0] store_load_data_size_s3;
    reg [TLB_EVT_NUM * 8 * 22 - 1:0] tlb_data_cmb_s3;
    reg [8:0] tlb_data_cmb_size_s3;
    reg [8 * 39 - 1:0] commit_data_s3;
    reg [72 * 32 -1:0] greg_data_s3;
    reg [72 * 34 -1:0] fpreg_data_s3;
    reg [72 * 27 -1:0] csr_data_s3;
    reg [5:0] greg_data_num_s3;
    reg [5:0] fpreg_data_num_s3;
    reg [5:0] csr_data_num_s3;
    reg [8:0] commit_data_size_s3;
    reg [11:0] greg_data_size_s3;
    reg [11:0] fpreg_data_size_s3;
    reg [11:0] csr_data_size_s3;

    wire [8 * 89 - 1:0] tec_data_s3;
    wire [9:0] tec_data_size_s3;
    wire [72 * 66 -1:0] gfreg_data_s3;
    wire [12:0] gfreg_data_size_s3;
    wire [6:0] gfreg_data_num_s3;
    wire [72 * 93 -1:0] gfc_data_s3;
    wire [12:0] gfc_data_size_s3;
    wire [7:0] gfc_data_num_s3;
    wire [8 * (35 + TLB_EVT_NUM * 22) - 1:0] slt_data_s3;
    wire [9:0] slt_data_size_s3;

    reg [8 * 89 - 1:0] tec_data_s4;
    reg [9:0] tec_data_size_s4;
    reg [72 * 93 + 8 - 1:0] gfc_data_s4;
    reg [12:0] gfc_data_size_s4;
    reg [8 * (35 + TLB_EVT_NUM * 22) - 1:0] slt_data_s4;
    reg [9:0] slt_data_size_s4;

    wire [8 * 90 + 72 * 93 - 1:0] tec_gfc_data_s4;
    wire [12:0] tec_gfc_data_size_s4;
    reg [8047:0] slt_data_shift_s4;

    reg [8 * (125 + TLB_EVT_NUM * 22) + 72 * 93 - 1:0] tec_gfc_data_s5;
    reg [12:0] tec_gfc_data_size_s5;
    reg [8047:0] slt_data_shift_s5;
    reg [9:0] slt_data_size_s5;

    wire [8047:0] diff_package;
    wire [12:0] diff_package_size;

    assign trap_excp_data_s2 = {trap_data_s2, trap_valids_s2} | ({excp_data_s2, excp_valids_s2} << trap_data_size_s2);
    assign trap_excp_data_size_s2 = trap_data_size_s2 + excp_data_size_s2;
    assign store_load_data_s2 = {store_data_s2, store_valids_s2} | ({load_data_s2, load_valids_s2} << store_data_size_s2);
    assign store_load_data_size_s2 = store_data_size_s2 + load_data_size_s2;
    assign tlb_data_cmb_s2 = {tlb_data_s2[0+:168], tlb_valids_s2[0+:8]} | 
                            ({tlb_data_s2[168+:168], tlb_valids_s2[8+:8]} << tlb_data_size_s2[0+:8]);
    assign tlb_data_cmb_size_s2 = tlb_data_size_s2[0+:8] + tlb_data_size_s2[8+:8];

    always @(posedge axi_clk) begin
        trap_excp_data_s3 <= trap_excp_data_s2;
        trap_excp_data_size_s3 <= trap_excp_data_size_s2;
        store_load_data_s3 <= store_load_data_s2;
        store_load_data_size_s3 <= store_load_data_size_s2;
        tlb_data_cmb_s3 <= tlb_data_cmb_s2;
        tlb_data_cmb_size_s3 <= tlb_data_cmb_size_s2;
        commit_data_s3 <= commit_data_s2;
        greg_data_s3 <= greg_data_s2;
        fpreg_data_s3 <= fpreg_data_s2;
        csr_data_s3 <= csr_data_s2;
        greg_data_num_s3 <= greg_data_num_s2;
        fpreg_data_num_s3 <= fpreg_data_num_s2;
        csr_data_num_s3 <= csr_data_num_s2;
        commit_data_size_s3 <= commit_data_size_s2;
        greg_data_size_s3 <= greg_data_size_s2;
        fpreg_data_size_s3 <= fpreg_data_size_s2;
        csr_data_size_s3 <= csr_data_size_s2;
    end

    assign tec_data_s3 = trap_excp_data_s3 | ({commit_data_s3, commit_valids_s3} << trap_excp_data_size_s3);
    assign tec_data_size_s3 = trap_excp_data_size_s3 + commit_data_size_s3;
    compress_data_num32 #(72, 34) compres_gfreg_data_s3 (
        .num(greg_data_num_s3),
        .di0(greg_data_s3),
        .di1(fpreg_data_s3),
        .d_o(gfreg_data_s3)
    );
    assign gfreg_data_size_s3 = greg_data_size_s3 + fpreg_data_size_s3;
    assign gfreg_data_num_s3  = greg_data_num_s3 + fpreg_data_num_s3;
    compress_data_num66 #(72, 27) compress_gfc_data_s3 (
        .num(gfreg_data_num_s3),
        .di0(gfreg_data_s3),
        .di1(csr_data_s3),
        .d_o(gfc_data_s3)
    );
    assign gfc_data_size_s3 = {13{diff_valids_s3[3]}} & (gfreg_data_size_s3 + csr_data_size_s3 + 13'd8);
    assign gfc_data_num_s3 = greg_data_num_s3 + fpreg_data_num_s3 + csr_data_num_s3;

    assign slt_data_s3 = store_load_data_s3 | (tlb_data_cmb_s3 << store_load_data_size_s3);
    assign slt_data_size_s3 = store_load_data_size_s3 + tlb_data_cmb_size_s3;

    always @(posedge axi_clk) begin
        tec_data_s4 <= tec_data_s3;
        tec_data_size_s4 <= tec_data_size_s3;
        gfc_data_s4 <= {gfc_data_s3, gfc_data_num_s3};
        gfc_data_size_s4 <= gfc_data_size_s3;
        slt_data_s4 <= slt_data_s3;
        slt_data_size_s4 <= slt_data_size_s3;
    end

    assign tec_gfc_data_s4 = tec_data_s4 | (gfc_data_s4 << tec_data_size_s4);
    assign tec_gfc_data_size_s4 = tec_data_size_s4 + gfc_data_size_s4;

    always @(*) begin
        case (tec_gfc_data_size_s4[12:9])
            4'b0000: slt_data_shift_s4 = {7416'b0, slt_data_s4};
            4'b0001: slt_data_shift_s4 = {6904'b0, slt_data_s4, 512'b0};
            4'b0010: slt_data_shift_s4 = {6392'b0, slt_data_s4, 1024'b0};
            4'b0011: slt_data_shift_s4 = {5880'b0, slt_data_s4, 1536'b0};
            4'b0100: slt_data_shift_s4 = {5368'b0, slt_data_s4, 2048'b0};
            4'b0101: slt_data_shift_s4 = {4856'b0, slt_data_s4, 2560'b0};
            4'b0110: slt_data_shift_s4 = {4344'b0, slt_data_s4, 3072'b0};
            4'b0111: slt_data_shift_s4 = {3832'b0, slt_data_s4, 3584'b0};
            4'b1000: slt_data_shift_s4 = {3320'b0, slt_data_s4, 4096'b0};
            4'b1001: slt_data_shift_s4 = {2808'b0, slt_data_s4, 4608'b0};
            4'b1010: slt_data_shift_s4 = {2296'b0, slt_data_s4, 5120'b0};
            4'b1011: slt_data_shift_s4 = {1784'b0, slt_data_s4, 5632'b0};
            4'b1100: slt_data_shift_s4 = {1272'b0, slt_data_s4, 6144'b0};
            4'b1101: slt_data_shift_s4 = {760'b0, slt_data_s4, 6656'b0};
            4'b1110: slt_data_shift_s4 = {248'b0, slt_data_s4, 7168'b0};
            4'b1111: slt_data_shift_s4 = {slt_data_s4, 7416'b0};
        endcase
    end

    always @(posedge axi_clk) begin
        tec_gfc_data_s5 <= {632'b0, tec_gfc_data_s4};
        tec_gfc_data_size_s5 <= tec_gfc_data_size_s4;
        slt_data_shift_s5 <= slt_data_shift_s4;
        slt_data_size_s5 <= slt_data_size_s4;
    end

    assign diff_package = tec_gfc_data_s5 | (slt_data_shift_s5 << tec_gfc_data_size_s5[8:0]);
    assign diff_package_size = {13{|diff_valids_s5}} & (tec_gfc_data_size_s5 + slt_data_size_s5 + 13'd24);

    // write to buffer

    wire [8703:0] diff_package_expand;
    reg [8703:0] diff_package_shift;
    wire [8703:0] diff_package_shift_rlt;
    reg [13:0] diff_package_shift_idx;
    wire [14:0] diff_package_shift_idx_n;
    wire [13:0] diff_package_shift_idx_i;
    reg [8:0] diff_buffer_num;
    wire [13:0] diff_buffer_num_i;
    reg [16:0] diff_buffer_vec;
    reg [16:0] diff_buffer_vec_shift;
    reg [8703:0] diff_buffer_remain_vec;

    reg [8703:0] diff_package_fifo_i;
    reg [16:0] diff_buffer_en;

    assign diff_package_expand = {
        632'b0, diff_package, 6'b0, diff_package_size[12:3], diff_valids_s5
    };
    assign diff_package_shift_idx_n = diff_package_shift_idx + diff_package_size;
    assign diff_buffer_num_i = diff_buffer_num + diff_package_size;
    assign diff_package_shift_idx_i = diff_package_shift_idx_n > 14'd8703 ? 
                                      diff_package_shift_idx_n - 14'd8704 : diff_package_shift_idx_n[13:0];

    always @(*) begin
        case (diff_package_shift_idx[13:9])
            5'b00000: diff_package_shift = diff_package_expand;
            5'b00001:
            diff_package_shift = {diff_package_expand[8191:0], diff_package_expand[8703:8192]};
            5'b00010:
            diff_package_shift = {diff_package_expand[7679:0], diff_package_expand[8703:7680]};
            5'b00011:
            diff_package_shift = {diff_package_expand[7167:0], diff_package_expand[8703:7168]};
            5'b00100:
            diff_package_shift = {diff_package_expand[6655:0], diff_package_expand[8703:6656]};
            5'b00101:
            diff_package_shift = {diff_package_expand[6143:0], diff_package_expand[8703:6144]};
            5'b00110:
            diff_package_shift = {diff_package_expand[5631:0], diff_package_expand[8703:5632]};
            5'b00111:
            diff_package_shift = {diff_package_expand[5119:0], diff_package_expand[8703:5120]};
            5'b01000:
            diff_package_shift = {diff_package_expand[4607:0], diff_package_expand[8703:4608]};
            5'b01001:
            diff_package_shift = {diff_package_expand[4095:0], diff_package_expand[8703:4096]};
            5'b01010:
            diff_package_shift = {diff_package_expand[3583:0], diff_package_expand[8703:3584]};
            5'b01011:
            diff_package_shift = {diff_package_expand[3071:0], diff_package_expand[8703:3072]};
            5'b01100:
            diff_package_shift = {diff_package_expand[2559:0], diff_package_expand[8703:2560]};
            5'b01101:
            diff_package_shift = {diff_package_expand[2047:0], diff_package_expand[8703:2048]};
            5'b01110:
            diff_package_shift = {diff_package_expand[1535:0], diff_package_expand[8703:1536]};
            5'b01111:
            diff_package_shift = {diff_package_expand[1023:0], diff_package_expand[8703:1024]};
            5'b10000:
            diff_package_shift = {diff_package_expand[511:0], diff_package_expand[8703:512]};
            default: diff_package_shift = diff_package_expand;
        endcase
        case (diff_buffer_num_i[13:9])
            5'h0: diff_buffer_vec = 17'h0;
            5'h1: diff_buffer_vec = 17'h1;
            5'h2: diff_buffer_vec = 17'h3;
            5'h3: diff_buffer_vec = 17'h7;
            5'h4: diff_buffer_vec = 17'hf;
            5'h5: diff_buffer_vec = 17'h1f;
            5'h6: diff_buffer_vec = 17'h3f;
            5'h7: diff_buffer_vec = 17'h7f;
            5'h8: diff_buffer_vec = 17'hff;
            5'h9: diff_buffer_vec = 17'h1ff;
            5'ha: diff_buffer_vec = 17'h3ff;
            5'hb: diff_buffer_vec = 17'h7ff;
            5'hc: diff_buffer_vec = 17'hfff;
            5'hd: diff_buffer_vec = 17'h1fff;
            5'he: diff_buffer_vec = 17'h3fff;
            5'hf: diff_buffer_vec = 17'h7fff;
            5'h10: diff_buffer_vec = 17'hffff;
            5'h11: diff_buffer_vec = 17'h1ffff;
            default: diff_buffer_vec = 0;
        endcase
        case (diff_package_shift_idx[13:9])
            5'b00000: diff_buffer_remain_vec = {8192'b0, diff_package_fifo_i[511:0]};
            5'b00001: diff_buffer_remain_vec = {7680'b0, diff_package_fifo_i[1023:512], 512'b0};
            5'b00010: diff_buffer_remain_vec = {7168'b0, diff_package_fifo_i[1535:1024], 1024'b0};
            5'b00011: diff_buffer_remain_vec = {6656'b0, diff_package_fifo_i[2047:1536], 1536'b0};
            5'b00100: diff_buffer_remain_vec = {6144'b0, diff_package_fifo_i[2559:2048], 2048'b0};
            5'b00101: diff_buffer_remain_vec = {5632'b0, diff_package_fifo_i[3071:2560], 2560'b0};
            5'b00110: diff_buffer_remain_vec = {5120'b0, diff_package_fifo_i[3583:3072], 3072'b0};
            5'b00111: diff_buffer_remain_vec = {4608'b0, diff_package_fifo_i[4095:3584], 3584'b0};
            5'b01000: diff_buffer_remain_vec = {4096'b0, diff_package_fifo_i[4607:4096], 4096'b0};
            5'b01001: diff_buffer_remain_vec = {3584'b0, diff_package_fifo_i[5119:4608], 4608'b0};
            5'b01010: diff_buffer_remain_vec = {3072'b0, diff_package_fifo_i[5631:5120], 5120'b0};
            5'b01011: diff_buffer_remain_vec = {2560'b0, diff_package_fifo_i[6143:5632], 5632'b0};
            5'b01100: diff_buffer_remain_vec = {2048'b0, diff_package_fifo_i[6655:6144], 6144'b0};
            5'b01101: diff_buffer_remain_vec = {1536'b0, diff_package_fifo_i[7167:6656], 6656'b0};
            5'b01110: diff_buffer_remain_vec = {1024'b0, diff_package_fifo_i[7679:7168], 7168'b0};
            5'b01111: diff_buffer_remain_vec = {512'b0, diff_package_fifo_i[8191:7680], 7680'b0};
            5'b10000: diff_buffer_remain_vec = {diff_package_fifo_i[8703:8192], 8192'b0};
            default:  diff_buffer_remain_vec = 0;
        endcase
        case (diff_package_shift_idx[13:9])
            5'b00000: diff_buffer_vec_shift = diff_buffer_vec;
            5'b00001: diff_buffer_vec_shift = {diff_buffer_vec[15:0], diff_buffer_vec[16]};
            5'b00010: diff_buffer_vec_shift = {diff_buffer_vec[14:0], diff_buffer_vec[16:15]};
            5'b00011: diff_buffer_vec_shift = {diff_buffer_vec[13:0], diff_buffer_vec[16:14]};
            5'b00100: diff_buffer_vec_shift = {diff_buffer_vec[12:0], diff_buffer_vec[16:13]};
            5'b00101: diff_buffer_vec_shift = {diff_buffer_vec[11:0], diff_buffer_vec[16:12]};
            5'b00110: diff_buffer_vec_shift = {diff_buffer_vec[10:0], diff_buffer_vec[16:11]};
            5'b00111: diff_buffer_vec_shift = {diff_buffer_vec[9:0], diff_buffer_vec[16:10]};
            5'b01000: diff_buffer_vec_shift = {diff_buffer_vec[8:0], diff_buffer_vec[16:9]};
            5'b01001: diff_buffer_vec_shift = {diff_buffer_vec[7:0], diff_buffer_vec[16:8]};
            5'b01010: diff_buffer_vec_shift = {diff_buffer_vec[6:0], diff_buffer_vec[16:7]};
            5'b01011: diff_buffer_vec_shift = {diff_buffer_vec[5:0], diff_buffer_vec[16:6]};
            5'b01100: diff_buffer_vec_shift = {diff_buffer_vec[4:0], diff_buffer_vec[16:5]};
            5'b01101: diff_buffer_vec_shift = {diff_buffer_vec[3:0], diff_buffer_vec[16:4]};
            5'b01110: diff_buffer_vec_shift = {diff_buffer_vec[2:0], diff_buffer_vec[16:3]};
            5'b01111: diff_buffer_vec_shift = {diff_buffer_vec[1:0], diff_buffer_vec[16:2]};
            5'b10000: diff_buffer_vec_shift = {diff_buffer_vec[0], diff_buffer_vec[16:1]};
            default: diff_buffer_vec_shift = 0;
        endcase
    end

    wire [8703:0] diff_package_shift_left;
    wire [8703:0] diff_package_shift_right;

    assign diff_package_shift_left = diff_package_shift[8703:0] << diff_package_shift_idx[8:0];
    assign diff_package_shift_right = diff_package_shift[8703:8192] >> (10'd512 - diff_package_shift_idx[8:0]);
    assign diff_package_shift_rlt = diff_package_shift_left | diff_package_shift_right | diff_buffer_remain_vec;

    always @(posedge axi_clk or negedge axi_resetn) begin
        if (!axi_resetn) begin
            diff_package_shift_idx <= 0;
            diff_buffer_num <= 0;
            diff_package_fifo_i <= 0;
            diff_buffer_en <= 0;
        end else begin
            if (|diff_valids_s5) begin
                diff_package_shift_idx <= diff_package_shift_idx_i;
                diff_buffer_num <= diff_buffer_num_i[8:0];
                diff_package_fifo_i <= diff_package_shift_rlt;
            end
            diff_buffer_en <= diff_buffer_vec_shift & {17{|diff_valids_s5}};
        end
    end

    // fifo output
    wire [8703:0] fifo_o;
    reg [8703:0] fifo_o_s1;
    reg [16:0] fifo_rd_vec;
    reg [16:0] fifo_rd_vec_dup;
    reg [16:0] fifo_rd_vec_s1;
    reg [16:0] fifo_rd_vec_s2;
    reg [16:0] fifo_rd_vec_s3;
    wire [16:0] fifo_rd_en;
    reg [16:0] fifo_rd_en_s1;
    wire [16:0] fifo_empty;
    wire [16:0] fifo_full;

    reg reading;
    reg [8:0] arlen;
    reg [3:0] rid;
    reg rvalid;
    reg rlast;
    reg fifo_last;
    reg [16:0] fifo_valid;
    reg [511:0] rdata;
    reg [3:0] stall_s1;
    reg stall_s2;
    reg stall_cdc;
    reg stall_s3;
    reg stall_s4;
    reg [3:0] stall_cnt;
    reg rvalid_s1;
    reg rlast_s1;
    reg rvalid_s2;
    reg rlast_s2;
    reg [511:0] rdata_s3;
    reg [16:0] fifo_full_s1;
    reg rvalid_s3;
    reg rlast_s3;

    wire ar_hsk = DIFF_AXI_arvalid & DIFF_AXI_arready;
    wire r_hsk = DIFF_AXI_rvalid & DIFF_AXI_rready & DIFF_AXI_rlast;
    wire r_pending = DIFF_AXI_rvalid & ~DIFF_AXI_rready;

    // TODO: use axi_resetn to replace dma_aresetn, need set_false_path between dma_clk and axi_resetn
    always @(posedge dma_clk or negedge dma_aresetn) begin
        if (!dma_aresetn) begin
            fifo_rd_vec <= 1;
            fifo_rd_vec_dup <= 1;
        end else begin
            if ((|fifo_rd_en)) begin
                fifo_rd_vec <= {fifo_rd_vec[15:0], fifo_rd_vec[16]};
                fifo_rd_vec_dup <= {fifo_rd_vec_dup[15:0], fifo_rd_vec_dup[16]};
            end
        end
    end

    assign fifo_rd_en = fifo_rd_vec & ~fifo_empty & fifo_valid & {17{!r_pending}};

    generate
        for (i = 0; i < 17; i = i + 1) begin
            xlnx_xdma_fifo fifo (
                .wr_clk(axi_clk),
                .rd_clk(dma_clk),
                .srst(!axi_resetn),
                .din(diff_package_fifo_i[i*512+:512]),
                .wr_en(diff_buffer_en[i]),
                .full(),
                .dout(fifo_o[i*512+:512]),
                .rd_en(fifo_rd_en_s1[i]),
                .empty(fifo_empty[i]),
                .prog_full(fifo_full[i]),
                .wr_rst_busy(),
                .rd_rst_busy()
            );
        end
    endgenerate

    always @(posedge dma_clk or negedge dma_aresetn) begin
        if (!dma_aresetn) begin
            reading <= 1'b0;
            arlen <= 0;
            fifo_last <= 1'b0;
            fifo_valid <= 1'b0;
        end else begin
            if (ar_hsk) begin
                reading <= 1'b1;
                arlen <= DIFF_AXI_arlen + 1;
                fifo_last <= DIFF_AXI_arlen == 0;
                fifo_valid <= {17{1'b1}};
            end
            if (|fifo_rd_en) begin
                arlen <= arlen - 1;
                fifo_last <= arlen == 2;
                fifo_valid <= {17{arlen != 0 && arlen != 1}};
            end
            if (r_hsk) begin
                reading <= 1'b0;
            end
        end
    end

    always @(posedge dma_clk or negedge dma_aresetn) begin
        if (!dma_aresetn) begin
            rvalid <= 0;
            rvalid_s1 <= 0;
            rvalid_s2 <= 0;
            rvalid_s3 <= 0;
        end else if (!r_pending) begin
            rvalid <= |fifo_rd_en;
            rvalid_s1 <= rvalid;
            rvalid_s2 <= rvalid_s1;
            rvalid_s3 <= rvalid_s2;
        end
    end

    always @(posedge dma_clk) begin
        if (!r_pending) begin
            fifo_rd_en_s1 <= fifo_rd_en;
            fifo_rd_vec_s1 <= fifo_rd_vec_dup;
            fifo_rd_vec_s2 <= fifo_rd_vec_s1;
            fifo_rd_vec_s3 <= fifo_rd_vec_s2;

            rlast <= (|fifo_rd_en) && fifo_last;
            rlast_s1 <= rlast;  // read
            rlast_s2 <= rlast_s1;  // rdata
            rlast_s3 <= rlast_s2;  // fifo_o_s1
            rdata_s3 <= rdata;
            fifo_o_s1 <= fifo_o;
        end
        fifo_full_s1 <= fifo_full;
        stall_s1[0] <= |fifo_full_s1[3:0];
        stall_s1[1] <= |fifo_full_s1[7:4];
        stall_s1[2] <= |fifo_full_s1[11:8];
        stall_s1[3] <= |fifo_full_s1[16:12];
        stall_s2 <= |stall_s1;
        if (ar_hsk) begin
            rid <= DIFF_AXI_arid;
        end
    end

    always @(posedge dma_clk or negedge dma_aresetn) begin
        if (!dma_aresetn) begin
            stall_cnt <= 0;
            stall_cdc <= 0;
        end else begin
            if (stall_s2) begin
                stall_cnt <= 10;
            end else if (stall_cnt != 0) begin
                stall_cnt <= stall_cnt - 1;
            end
            stall_cdc <= stall_cnt != 0;
        end
    end

    always @(posedge axi_clk) begin
        stall_s3 <= stall_cdc;
        stall_s4 <= stall_s3;
    end

    always @(*) begin
        case (fifo_rd_vec_s3)
            17'b00000000000000001: rdata = fifo_o_s1[511:0];
            17'b00000000000000010: rdata = fifo_o_s1[1023:512];
            17'b00000000000000100: rdata = fifo_o_s1[1535:1024];
            17'b00000000000001000: rdata = fifo_o_s1[2047:1536];
            17'b00000000000010000: rdata = fifo_o_s1[2559:2048];
            17'b00000000000100000: rdata = fifo_o_s1[3071:2560];
            17'b00000000001000000: rdata = fifo_o_s1[3583:3072];
            17'b00000000010000000: rdata = fifo_o_s1[4095:3584];
            17'b00000000100000000: rdata = fifo_o_s1[4607:4096];
            17'b00000001000000000: rdata = fifo_o_s1[5119:4608];
            17'b00000010000000000: rdata = fifo_o_s1[5631:5120];
            17'b00000100000000000: rdata = fifo_o_s1[6143:5632];
            17'b00001000000000000: rdata = fifo_o_s1[6655:6144];
            17'b00010000000000000: rdata = fifo_o_s1[7167:6656];
            17'b00100000000000000: rdata = fifo_o_s1[7679:7168];
            17'b01000000000000000: rdata = fifo_o_s1[8191:7680];
            17'b10000000000000000: rdata = fifo_o_s1[8703:8192];
            default: rdata = 0;
        endcase
    end

    assign DIFF_AXI_arready = !reading;
    assign DIFF_AXI_rvalid = rvalid_s3;
    assign DIFF_AXI_rdata  = rdata_s3;
    assign DIFF_AXI_rlast  = rlast_s3;
    assign DIFF_AXI_rid    = rid;
    assign DIFF_AXI_rresp  = 0;
    assign DIFF_AXI_wready = 0;
    assign DIFF_AXI_awready = 0;
    assign DIFF_AXI_bvalid = 0;
    assign DIFF_AXI_bresp = 0;
    assign DIFF_AXI_bid = 0;

    assign stall = stall_s4;


endmodule


module compress_data3 #(
    parameter DW = 72
) (
    input  wire [     2:0] en,
    input  wire [DW*3-1:0] di,
    output reg  [DW*3-1:0] d_o
);
    always @(*) begin
        case (en)
            3'b000: d_o = 0;
            3'b001: d_o = {{DW * 2{1'b0}}, di[0+:DW]};
            3'b010: d_o = {{DW * 2{1'b0}}, di[DW+:DW]};
            3'b011: d_o = {{DW * 1{1'b0}}, di[0+:2*DW]};
            3'b100: d_o = {{DW * 2{1'b0}}, di[2*DW+:DW]};
            3'b101: d_o = {{DW * 1{1'b0}}, di[2*DW+:DW], di[0+:DW]};
            3'b110: d_o = {{DW * 1{1'b0}}, di[DW+:2*DW]};
            3'b111: d_o = di;
        endcase
    end
endmodule

module compress_data4 #(
    parameter DW = 72
) (
    input  wire [     3:0] en,
    input  wire [DW*4-1:0] di,
    output reg  [DW*4-1:0] d_o
);
    always @(*) begin
        case (en)
            4'b0000: d_o = 0;
            4'b0001: d_o = {{DW * 3{1'b0}}, di[0+:DW]};
            4'b0010: d_o = {{DW * 3{1'b0}}, di[DW+:DW]};
            4'b0011: d_o = {{DW * 2{1'b0}}, di[0+:2*DW]};
            4'b0100: d_o = {{DW * 3{1'b0}}, di[2*DW+:DW]};
            4'b0101: d_o = {{DW * 2{1'b0}}, di[2*DW+:DW], di[0+:DW]};
            4'b0110: d_o = {{DW * 2{1'b0}}, di[DW+:2*DW]};
            4'b0111: d_o = {{DW * 1{1'b0}}, di[0+:3*DW]};
            4'b1000: d_o = {{DW * 3{1'b0}}, di[3*DW+:DW]};
            4'b1001: d_o = {{DW * 2{1'b0}}, di[3*DW+:DW], di[0+:DW]};
            4'b1010: d_o = {{DW * 2{1'b0}}, di[3*DW+:DW], di[DW+:DW]};
            4'b1011: d_o = {{DW * 1{1'b0}}, di[3*DW+:DW], di[0+:2*DW]};
            4'b1100: d_o = {{DW * 2{1'b0}}, di[2*DW+:2*DW]};
            4'b1101: d_o = {{DW * 2{1'b0}}, di[2*DW+:2*DW], di[0+:DW]};
            4'b1110: d_o = {{DW * 1{1'b0}}, di[DW+:3*DW]};
            4'b1111: d_o = di;
        endcase
    end
endmodule

module compress_data6 #(
    parameter DW = 72
) (
    input  wire [     5:0] en,
    input  wire [DW*6-1:0] di,
    output reg  [DW*6-1:0] d_o
);
    // 根据en信号将di压缩为连续的数据，确保di的低位在do的低位
    always @(*) begin
        case (en)
            // 0个有效位
            6'b000000: d_o = 0;
            // 1个有效位
            6'b000001: d_o = {{DW * 5{1'b0}}, di[0+:DW]};  // 位0有效
            6'b000010: d_o = {{DW * 5{1'b0}}, di[DW+:DW]};  // 位1有效
            6'b000100: d_o = {{DW * 5{1'b0}}, di[2*DW+:DW]};  // 位2有效
            6'b001000: d_o = {{DW * 5{1'b0}}, di[3*DW+:DW]};  // 位3有效
            6'b010000: d_o = {{DW * 5{1'b0}}, di[4*DW+:DW]};  // 位4有效
            6'b100000: d_o = {{DW * 5{1'b0}}, di[5*DW+:DW]};  // 位5有效
            // 2个有效位
            6'b000011: d_o = {{DW * 4{1'b0}}, di[0+:2*DW]};  // 位0-1有效
            6'b000101: d_o = {{DW * 4{1'b0}}, di[2*DW+:DW], di[0+:DW]};  // 位0,2有效
            6'b001001: d_o = {{DW * 4{1'b0}}, di[3*DW+:DW], di[0+:DW]};  // 位0,3有效
            6'b010001: d_o = {{DW * 4{1'b0}}, di[4*DW+:DW], di[0+:DW]};  // 位0,4有效
            6'b100001: d_o = {{DW * 4{1'b0}}, di[5*DW+:DW], di[0+:DW]};  // 位0,5有效
            6'b000110: d_o = {{DW * 4{1'b0}}, di[DW+:2*DW]};  // 位1-2有效
            6'b001010: d_o = {{DW * 4{1'b0}}, di[3*DW+:DW], di[DW+:DW]};  // 位1,3有效
            6'b010010: d_o = {{DW * 4{1'b0}}, di[4*DW+:DW], di[DW+:DW]};  // 位1,4有效
            6'b100010: d_o = {{DW * 4{1'b0}}, di[5*DW+:DW], di[DW+:DW]};  // 位1,5有效
            6'b001100: d_o = {{DW * 4{1'b0}}, di[2*DW+:2*DW]};  // 位2-3有效
            6'b010100: d_o = {{DW * 4{1'b0}}, di[4*DW+:DW], di[2*DW+:DW]};  // 位2,4有效
            6'b100100: d_o = {{DW * 4{1'b0}}, di[5*DW+:DW], di[2*DW+:DW]};  // 位2,5有效
            6'b011000: d_o = {{DW * 4{1'b0}}, di[3*DW+:2*DW]};  // 位3-4有效
            6'b101000: d_o = {{DW * 4{1'b0}}, di[5*DW+:DW], di[3*DW+:DW]};  // 位3,5有效
            6'b110000: d_o = {{DW * 4{1'b0}}, di[4*DW+:2*DW]};  // 位4-5有效
            // 3个有效位
            6'b000111: d_o = {{DW * 3{1'b0}}, di[0+:3*DW]};  // 位0-2有效
            6'b001011: d_o = {{DW * 3{1'b0}}, di[3*DW+:DW], di[0+:2*DW]};  // 位0-1,3有效
            6'b001101: d_o = {{DW * 3{1'b0}}, di[2*DW+:2*DW], di[0+:DW]};  // 位0,2-3有效
            6'b001110: d_o = {{DW * 3{1'b0}}, di[DW+:3*DW]};
            6'b010011: d_o = {{DW * 3{1'b0}}, di[4*DW+:DW], di[0+:2*DW]};  // 位0-1,4有效
            6'b010101:
            d_o = {{DW * 3{1'b0}}, di[4*DW+:DW], di[2*DW+:DW], di[0+:DW]};  // 位0,2,4有效
            6'b010110: d_o = {{DW * 3{1'b0}}, di[4*DW+:DW], di[DW+:2*DW]};
            6'b011001:
            d_o = {{DW * 3{1'b0}}, di[4*DW+:DW], di[3*DW+:DW], di[0+:DW]};  // 位0-1,3-4有效
            6'b011010: d_o = {{DW * 3{1'b0}}, di[3*DW+:2*DW], di[DW+:DW]};
            6'b011100: d_o = {{DW * 3{1'b0}}, di[2*DW+:3*DW]};
            6'b100011: d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[0+:2*DW]};  // 位0-1,5有效
            6'b100101:
            d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[2*DW+:DW], di[0+:DW]};  // 位0,2,5有效
            6'b101001:
            d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[3*DW+:DW], di[0+:DW]};  // 位0,3,5有效
            6'b110001:
            d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[4*DW+:DW], di[0+:DW]};  // 位0,4-5有效
            6'b100110: d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[DW+:2*DW]};  // 位1-2,5有效
            6'b101010:
            d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[3*DW+:DW], di[DW+:DW]};  // 位1,3,5有效
            6'b110010:
            d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[4*DW+:DW], di[DW+:DW]};  // 位1,4-5有效
            6'b101100: d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[2*DW+:2*DW]};  // 位2-3,5有效
            6'b110100:
            d_o = {{DW * 3{1'b0}}, di[5*DW+:DW], di[4*DW+:DW], di[2*DW+:DW]};  // 位2,4-5有效
            6'b111000: d_o = {{DW * 3{1'b0}}, di[3*DW+:3*DW]};  // 位3-5有效
            // 4个有效位
            6'b001111: d_o = {{DW * 2{1'b0}}, di[0+:4*DW]};  // 位0-3有效
            6'b010111: d_o = {{DW * 2{1'b0}}, di[4*DW+:DW], di[0+:3*DW]};  // 位0-2,4有效
            6'b011011: d_o = {{DW * 2{1'b0}}, di[3*DW+:2*DW], di[0+:2*DW]};  // 位0-1,3-4有效
            6'b011101: d_o = {{DW * 2{1'b0}}, di[2*DW+:3*DW], di[0+:DW]};  // 位0,2-4有效
            6'b011110: d_o = {{DW * 2{1'b0}}, di[DW+:4*DW]};  // 位1-4有效
            6'b100111: d_o = {{DW * 2{1'b0}}, di[5*DW+:DW], di[0+:3*DW]};  // 位0-2,5有效
            6'b101011:
            d_o = {{DW * 2{1'b0}}, di[5*DW+:DW], di[3*DW+:DW], di[0+:2*DW]};  // 位0-1,3,5有效
            6'b101101:
            d_o = {{DW * 2{1'b0}}, di[5*DW+:DW], di[2*DW+:2*DW], di[0+:DW]};  // 位0,2-3,5有效
            6'b101110: d_o = {{DW * 2{1'b0}}, di[5*DW+:DW], di[DW+:3*DW]};  // 位1-3,5有效
            6'b110011:
            d_o = {{DW * 2{1'b0}}, di[5*DW+:DW], di[4*DW+:DW], di[0+:2*DW]};  // 位0-1,4-5有效
            6'b110101:
            d_o = {
                {DW * 2{1'b0}}, di[5*DW+:DW], di[4*DW+:DW], di[2*DW+:DW], di[0+:DW]
            };  // 位0,2,4-5有效
            6'b110110: d_o = {{DW * 2{1'b0}}, di[4*DW+:2*DW], di[DW+:2*DW]};
            6'b111001: d_o = {{DW * 2{1'b0}}, di[3*DW+:3*DW], di[0+:DW]};  // 位0,3-5有效
            6'b111010: d_o = {{DW * 2{1'b0}}, di[3*DW+:3*DW], di[DW+:DW]};  // 位1,3-5有效
            6'b111100: d_o = {{DW * 2{1'b0}}, di[2*DW+:4*DW]};  // 位2-5有效
            // 5个有效位
            6'b011111: d_o = {{DW * 1{1'b0}}, di[0+:5*DW]};  // 位0-4有效
            6'b101111: d_o = {{DW * 1{1'b0}}, di[5*DW+:DW], di[0+:4*DW]};  // 位0-3,5有效
            6'b110111:
            d_o = {{DW * 1{1'b0}}, di[5*DW+:DW], di[4*DW+:DW], di[0+:3*DW]};  // 位0-2,4-5有效
            6'b111011: d_o = {{DW * 1{1'b0}}, di[3*DW+:3*DW], di[0+:2*DW]};  // 位0-1,3-5有效
            6'b111101: d_o = {{DW * 1{1'b0}}, di[2*DW+:4*DW], di[0+:DW]};  // 位0,2-5有效
            6'b111110: d_o = {{DW * 1{1'b0}}, di[DW+:5*DW]};  // 位1-5有效
            // 6个有效位
            6'b111111: d_o = di;  // 所有位有效
        endcase
    end
endmodule

module compress_data_num4 #(
    parameter DW   = 72,
    parameter NUM2 = 4
) (
    input [2:0] num,
    input wire [DW*4-1:0] di0,
    input wire [DW*NUM2-1:0] di1,
    output reg [DW*(4+NUM2)-1:0] d_o
);
    always @(*) begin
        case (num)
            3'b000:  d_o = di1;
            3'b001:  d_o = {di1, di0[0+:DW]};
            3'b010:  d_o = {di1, di0[0+:2*DW]};
            3'b011:  d_o = {di1, di0[0+:3*DW]};
            default: d_o = {di1, di0};
        endcase
    end
endmodule

module compress_data_num8 #(
    parameter DW   = 72,
    parameter NUM2 = 8
) (
    input [3:0] num,
    input wire [DW*8-1:0] di0,
    input wire [DW*NUM2-1:0] di1,
    output reg [DW*(8+NUM2)-1:0] d_o
);
    always @(*) begin
        case (num)
            4'b0000: d_o = di1;
            4'b0001: d_o = {di1, di0[0+:DW]};
            4'b0010: d_o = {di1, di0[0+:2*DW]};
            4'b0011: d_o = {di1, di0[0+:3*DW]};
            4'b0100: d_o = {di1, di0[0+:4*DW]};
            4'b0101: d_o = {di1, di0[0+:5*DW]};
            4'b0110: d_o = {di1, di0[0+:6*DW]};
            4'b0111: d_o = {di1, di0[0+:7*DW]};
            default: d_o = {di1, di0};
        endcase
    end
endmodule

module compress_data_num16 #(
    parameter DW   = 72,
    parameter NUM2 = 16
) (
    input [4:0] num,
    input wire [DW*16-1:0] di0,
    input wire [DW*NUM2-1:0] di1,
    output reg [DW*(16+NUM2)-1:0] d_o
);
    always @(*) begin
        case (num)
            5'b00000: d_o = di1;
            5'b00001: d_o = {di1, di0[0+:DW]};
            5'b00010: d_o = {di1, di0[0+:2*DW]};
            5'b00011: d_o = {di1, di0[0+:3*DW]};
            5'b00100: d_o = {di1, di0[0+:4*DW]};
            5'b00101: d_o = {di1, di0[0+:5*DW]};
            5'b00110: d_o = {di1, di0[0+:6*DW]};
            5'b00111: d_o = {di1, di0[0+:7*DW]};
            5'b01000: d_o = {di1, di0[0+:8*DW]};
            5'b01001: d_o = {di1, di0[0+:9*DW]};
            5'b01010: d_o = {di1, di0[0+:10*DW]};
            5'b01011: d_o = {di1, di0[0+:11*DW]};
            5'b01100: d_o = {di1, di0[0+:12*DW]};
            5'b01101: d_o = {di1, di0[0+:13*DW]};
            5'b01110: d_o = {di1, di0[0+:14*DW]};
            5'b01111: d_o = {di1, di0[0+:15*DW]};
            default:  d_o = {di1, di0};
        endcase
    end
endmodule


module compress_data_num32 #(
    parameter DW = 72,
    parameter NUM2 = 32,
    parameter EXTRA = 0,
    parameter EXTRA2 = 0
) (
    input [5:0] num,
    input wire [DW*32+EXTRA-1:0] di0,
    input wire [DW*NUM2+EXTRA2-1:0] di1,
    output reg [DW*(32+NUM2)+EXTRA+EXTRA2-1:0] d_o
);
    always @(*) begin
        case (num)
            6'b000000: d_o = di1;
            6'b000001: d_o = {di1, di0[0+:DW+EXTRA]};
            6'b000010: d_o = {di1, di0[0+:2*DW+EXTRA]};
            6'b000011: d_o = {di1, di0[0+:3*DW+EXTRA]};
            6'b000100: d_o = {di1, di0[0+:4*DW+EXTRA]};
            6'b000101: d_o = {di1, di0[0+:5*DW+EXTRA]};
            6'b000110: d_o = {di1, di0[0+:6*DW+EXTRA]};
            6'b000111: d_o = {di1, di0[0+:7*DW+EXTRA]};
            6'b001000: d_o = {di1, di0[0+:8*DW+EXTRA]};
            6'b001001: d_o = {di1, di0[0+:9*DW+EXTRA]};
            6'b001010: d_o = {di1, di0[0+:10*DW+EXTRA]};
            6'b001011: d_o = {di1, di0[0+:11*DW+EXTRA]};
            6'b001100: d_o = {di1, di0[0+:12*DW+EXTRA]};
            6'b001101: d_o = {di1, di0[0+:13*DW+EXTRA]};
            6'b001110: d_o = {di1, di0[0+:14*DW+EXTRA]};
            6'b001111: d_o = {di1, di0[0+:15*DW+EXTRA]};
            6'b010000: d_o = {di1, di0[0+:16*DW+EXTRA]};
            6'b010001: d_o = {di1, di0[0+:17*DW+EXTRA]};
            6'b010010: d_o = {di1, di0[0+:18*DW+EXTRA]};
            6'b010011: d_o = {di1, di0[0+:19*DW+EXTRA]};
            6'b010100: d_o = {di1, di0[0+:20*DW+EXTRA]};
            6'b010101: d_o = {di1, di0[0+:21*DW+EXTRA]};
            6'b010110: d_o = {di1, di0[0+:22*DW+EXTRA]};
            6'b010111: d_o = {di1, di0[0+:23*DW+EXTRA]};
            6'b011000: d_o = {di1, di0[0+:24*DW+EXTRA]};
            6'b011001: d_o = {di1, di0[0+:25*DW+EXTRA]};
            6'b011010: d_o = {di1, di0[0+:26*DW+EXTRA]};
            6'b011011: d_o = {di1, di0[0+:27*DW+EXTRA]};
            6'b011100: d_o = {di1, di0[0+:28*DW+EXTRA]};
            6'b011101: d_o = {di1, di0[0+:29*DW+EXTRA]};
            6'b011110: d_o = {di1, di0[0+:30*DW+EXTRA]};
            6'b011111: d_o = {di1, di0[0+:31*DW+EXTRA]};
            default:   d_o = {di1, di0};
        endcase
    end
endmodule

module compress_data_num66 #(
    parameter DW = 72,
    parameter NUM2 = 32,
    parameter EXTRA = 0,
    parameter EXTRA2 = 0
) (
    input [6:0] num,
    input wire [DW*66+EXTRA-1:0] di0,
    input wire [DW*NUM2+EXTRA2-1:0] di1,
    output reg [DW*(66+NUM2)+EXTRA+EXTRA2-1:0] d_o
);
    always @(*) begin
        case (num)
            7'b0000000: d_o = di1;
            7'b0000001: d_o = {di1, di0[0+:DW+EXTRA]};
            7'b0000010: d_o = {di1, di0[0+:2*DW+EXTRA]};
            7'b0000011: d_o = {di1, di0[0+:3*DW+EXTRA]};
            7'b0000100: d_o = {di1, di0[0+:4*DW+EXTRA]};
            7'b0000101: d_o = {di1, di0[0+:5*DW+EXTRA]};
            7'b0000110: d_o = {di1, di0[0+:6*DW+EXTRA]};
            7'b0000111: d_o = {di1, di0[0+:7*DW+EXTRA]};
            7'b0001000: d_o = {di1, di0[0+:8*DW+EXTRA]};
            7'b0001001: d_o = {di1, di0[0+:9*DW+EXTRA]};
            7'b0001010: d_o = {di1, di0[0+:10*DW+EXTRA]};
            7'b0001011: d_o = {di1, di0[0+:11*DW+EXTRA]};
            7'b0001100: d_o = {di1, di0[0+:12*DW+EXTRA]};
            7'b0001101: d_o = {di1, di0[0+:13*DW+EXTRA]};
            7'b0001110: d_o = {di1, di0[0+:14*DW+EXTRA]};
            7'b0001111: d_o = {di1, di0[0+:15*DW+EXTRA]};
            7'b0010000: d_o = {di1, di0[0+:16*DW+EXTRA]};
            7'b0010001: d_o = {di1, di0[0+:17*DW+EXTRA]};
            7'b0010010: d_o = {di1, di0[0+:18*DW+EXTRA]};
            7'b0010011: d_o = {di1, di0[0+:19*DW+EXTRA]};
            7'b0010100: d_o = {di1, di0[0+:20*DW+EXTRA]};
            7'b0010101: d_o = {di1, di0[0+:21*DW+EXTRA]};
            7'b0010110: d_o = {di1, di0[0+:22*DW+EXTRA]};
            7'b0010111: d_o = {di1, di0[0+:23*DW+EXTRA]};
            7'b0011000: d_o = {di1, di0[0+:24*DW+EXTRA]};
            7'b0011001: d_o = {di1, di0[0+:25*DW+EXTRA]};
            7'b0011010: d_o = {di1, di0[0+:26*DW+EXTRA]};
            7'b0011011: d_o = {di1, di0[0+:27*DW+EXTRA]};
            7'b0011100: d_o = {di1, di0[0+:28*DW+EXTRA]};
            7'b0011101: d_o = {di1, di0[0+:29*DW+EXTRA]};
            7'b0011110: d_o = {di1, di0[0+:30*DW+EXTRA]};
            7'b0011111: d_o = {di1, di0[0+:31*DW+EXTRA]};
            7'b0100000: d_o = {di1, di0[0+:32*DW+EXTRA]};
            7'b0100001: d_o = {di1, di0[0+:33*DW+EXTRA]};
            7'b0100010: d_o = {di1, di0[0+:34*DW+EXTRA]};
            7'b0100011: d_o = {di1, di0[0+:35*DW+EXTRA]};
            7'b0100100: d_o = {di1, di0[0+:36*DW+EXTRA]};
            7'b0100101: d_o = {di1, di0[0+:37*DW+EXTRA]};
            7'b0100110: d_o = {di1, di0[0+:38*DW+EXTRA]};
            7'b0100111: d_o = {di1, di0[0+:39*DW+EXTRA]};
            7'b0101000: d_o = {di1, di0[0+:40*DW+EXTRA]};
            7'b0101001: d_o = {di1, di0[0+:41*DW+EXTRA]};
            7'b0101010: d_o = {di1, di0[0+:42*DW+EXTRA]};
            7'b0101011: d_o = {di1, di0[0+:43*DW+EXTRA]};
            7'b0101100: d_o = {di1, di0[0+:44*DW+EXTRA]};
            7'b0101101: d_o = {di1, di0[0+:45*DW+EXTRA]};
            7'b0101110: d_o = {di1, di0[0+:46*DW+EXTRA]};
            7'b0101111: d_o = {di1, di0[0+:47*DW+EXTRA]};
            7'b0110000: d_o = {di1, di0[0+:48*DW+EXTRA]};
            7'b0110001: d_o = {di1, di0[0+:49*DW+EXTRA]};
            7'b0110010: d_o = {di1, di0[0+:50*DW+EXTRA]};
            7'b0110011: d_o = {di1, di0[0+:51*DW+EXTRA]};
            7'b0110100: d_o = {di1, di0[0+:52*DW+EXTRA]};
            7'b0110101: d_o = {di1, di0[0+:53*DW+EXTRA]};
            7'b0110110: d_o = {di1, di0[0+:54*DW+EXTRA]};
            7'b0110111: d_o = {di1, di0[0+:55*DW+EXTRA]};
            7'b0111000: d_o = {di1, di0[0+:56*DW+EXTRA]};
            7'b0111001: d_o = {di1, di0[0+:57*DW+EXTRA]};
            7'b0111010: d_o = {di1, di0[0+:58*DW+EXTRA]};
            7'b0111011: d_o = {di1, di0[0+:59*DW+EXTRA]};
            7'b0111100: d_o = {di1, di0[0+:60*DW+EXTRA]};
            7'b0111101: d_o = {di1, di0[0+:61*DW+EXTRA]};
            7'b0111110: d_o = {di1, di0[0+:62*DW+EXTRA]};
            7'b0111111: d_o = {di1, di0[0+:63*DW+EXTRA]};
            7'b1000000: d_o = {di1, di0[0+:64*DW+EXTRA]};
            7'b1000001: d_o = {di1, di0[0+:65*DW+EXTRA]};
            default: d_o = {di1, di0};
        endcase
    end
endmodule
