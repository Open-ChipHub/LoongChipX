/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/


`define REVISION    4'd2
`define SUB_VERSION 6'd1
`define PATCH       6'd7


`define PRODUCT_ID 12'h000

`define FPGA

`define DFT_AT_SPEED

`define JTLB_ENTRY_128

`define PMP
`ifdef PMP
`define PMP_REGION_8
`endif

`define BHT_16K
`define ICACHE_32K
`define DCACHE_32K
`define FPU
`define HPCP

`ifdef HPCP
  //`define HPCP_CNT_NUM_4
  `define HPCP_CNT_NUM_8
  //`define HPCP_CNT_NUM_16
  //`define HPCP_CNT_NUM_29
`endif  

`define PLIC
`ifdef PLIC
  `define PLIC_INT_NUM   240   //NOTE: step of 32, min value:16; max value:1008
  `define PLIC_ID_NUM    10    //NOTE: it means the length of int number:128=7,256=8,BUT 
                               //      in order eliminate the lint err ,we FIX it to 10 
  `define PLIC_PRIO_BIT  5     //NOTE: Priority level bits, depends on timing
  `define MAX_HART_NUM   32    //NOTE: the hart number cannot be larger than MAX_HART_NUM
                               //      unless you changge this parameter, but it may affect
                               //      the maximum frequency                  
`endif

`define THEAD_IP

`define TDT_DM_SBA

`ifdef TDT_DM_SBA
  `define TDT_DM_SBA_AXI

`endif

`define TDT_DM_PB_EN
`ifdef TDT_DM_PB_EN
  `define TDT_DM_IEBREAK                  
  `define TDT_DM_PB_SIZE                    4
`endif

`define TDT_DM_NEXTDM_BA                    32'h00000000
`define TDT_TM_MCONTROL_TRI_NUM_8
`define TDT_TM_OTHER_TRI_NUM_2

`define TDT_DEBUG_PCFIFO
`ifdef TDT_DEBUG_PCFIFO
  //`define TDT_DEBUG_PCFIFO_8_ENTRY
  `define TDT_DEBUG_PCFIFO_16_ENTRY
`endif

`define TDT_DEBUG_INFO

`define TDT_SYSAPB_ASYNC_CLK

`define PROCESSOR_0

`define MULTI_PROCESSING

`ifdef MULTI_PROCESSING

`endif


`ifdef HPCP_CNT_NUM_4
  `define HPCP_CNT_GROUP0
`endif 

`ifdef HPCP_CNT_NUM_8
  `define HPCP_CNT_GROUP0
  `define HPCP_CNT_GROUP1
`endif 

`ifdef HPCP_CNT_NUM_16
  `define HPCP_CNT_GROUP0
  `define HPCP_CNT_GROUP1
  `define HPCP_CNT_GROUP2
`endif 


`ifdef HPCP_CNT_NUM_29
  `define HPCP_CNT_GROUP0 
  `define HPCP_CNT_GROUP1 
  `define HPCP_CNT_GROUP2 
  `define HPCP_CNT_GROUP3 
`endif

`ifdef BHT_2K
  `define BHT_INDEX_WIDTH 7
`endif

`ifdef BHT_4K
  `define BHT_INDEX_WIDTH 8
`endif

`ifdef BHT_8K
  `define BHT_INDEX_WIDTH 9
`endif

`ifdef BHT_16K
  `define BHT_INDEX_WIDTH 10
`endif


`ifdef ICACHE_8K
  `define I_TAG_INDEX_WIDTH 6
  `define I_DATA_INDEX_WIDTH 9
`endif

`ifdef ICACHE_16K
  `define I_TAG_INDEX_WIDTH 7
  `define I_DATA_INDEX_WIDTH 10
`endif

`ifdef ICACHE_32K
  `define I_TAG_INDEX_WIDTH 8
  `define I_DATA_INDEX_WIDTH 11
`endif

`ifdef ICACHE_64K
  `define I_TAG_INDEX_WIDTH 9
  `define I_DATA_INDEX_WIDTH 12
`endif


`ifdef DCACHE_8K
  `define D_TAG_INDEX_WIDTH 5
  `define D_TAG_TAG_WIDTH   29
  `define D_DATA_INDEX_WIDTH 8
`endif

`ifdef DCACHE_16K
  `define D_TAG_INDEX_WIDTH 6
  `define D_TAG_TAG_WIDTH   28
  `define D_DATA_INDEX_WIDTH 9
`endif

`ifdef DCACHE_32K
  `define D_TAG_INDEX_WIDTH 6
  `define D_TAG_TAG_WIDTH   28
  `define D_DATA_INDEX_WIDTH 10
`endif

`ifdef DCACHE_64K
  `define D_TAG_INDEX_WIDTH 6
  `define D_TAG_TAG_WIDTH   28
  `define D_DATA_INDEX_WIDTH 11
`endif


`ifdef PROCESSOR_3
  `define PLIC_HART_NUM  5'h4
`else
  `ifdef PROCESSOR_2
    `define PLIC_HART_NUM  5'h3
  `else
    `ifdef PROCESSOR_1
      `define PLIC_HART_NUM  5'h2
    `else
      `ifdef PROCESSOR_0
          `define PLIC_HART_NUM  5'h1
      `endif
    `endif
  `endif
`endif

`define PA_WIDTH 40
`define VA_WIDTH 39

`define INDEPENDENT_AXI_SLAVE_ENV

`define TDT_DM_CORE_RV64

`define TDT_DM_CORE_NSCRATCH            4'h2


`ifdef TDT_DM_SBA
    `define TDT_DM_SBA_DW_128
    //`define TDT_DM_SBA_DW_64
    //`define TDT_DM_SBA_DW_32
    `ifdef TDT_DM_SBA_AHB
        `define TDT_DM_SBAW                   `PA_WIDTH
    `else
        `define TDT_DM_SBAW                   `PA_WIDTH
    `endif
`endif

`ifdef TDT_TM_MCONTROL_TRI_NUM_0
  `define TDT_TM_MCONTROL_TRI_NUM         0
`else
  `ifdef TDT_TM_MCONTROL_TRI_NUM_2
     `define TDT_TM_MCONTROL_TRI_NUM 2
   `else
     `ifdef TDT_TM_MCONTROL_TRI_NUM_4
       `define TDT_TM_MCONTROL_TRI_NUM    4
     `else
        `ifdef TDT_TM_MCONTROL_TRI_NUM_8
          `define TDT_TM_MCONTROL_TRI_NUM 8
        `endif
     `endif
   `endif
`endif

`ifdef TDT_TM_OTHER_TRI_NUM_0
  `define TDT_TM_OTHER_TRI_NUM            0
`else
   `ifdef TDT_TM_OTHER_TRI_NUM_2
       `define TDT_TM_OTHER_TRI_NUM       2
    `endif
`endif
  
`define InstrCommit_wire(index) \
`ifdef DIFF_HARDWARE \
    wire                      dma_InstrCommit_valid_``index``; \
    wire [              63:0] dma_InstrCommit_pc_``index``; \
    wire [              31:0] dma_InstrCommit_instr_``index``; \
    wire                      dma_InstrCommit_skip_``index``; \
    wire                      dma_InstrCommit_is_TLBFILL_``index``; \
    wire [               7:0] dma_InstrCommit_TLBFILL_index_``index``; \
    wire                      dma_InstrCommit_is_CNTinst_``index``; \
    wire [              63:0] dma_InstrCommit_timer_64_value_``index``; \
    wire                      dma_InstrCommit_wen_``index``; \
    wire [               7:0] dma_InstrCommit_wdest_``index``; \
    wire [              63:0] dma_InstrCommit_wdata_``index``; \
    wire                      dma_InstrCommit_csr_rstat_``index``; \
    wire [              31:0] dma_InstrCommit_csr_data_``index``; \
`endif

`define InstrCommit_reg(clk, index, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg                      dma_InstrCommit_valid_``index````cur``; \
    reg [              63:0] dma_InstrCommit_pc_``index````cur``; \
    reg [              31:0] dma_InstrCommit_instr_``index````cur``; \
    reg                      dma_InstrCommit_skip_``index````cur``; \
    reg                      dma_InstrCommit_is_TLBFILL_``index````cur``; \
    reg [               7:0] dma_InstrCommit_TLBFILL_index_``index````cur``; \
    reg                      dma_InstrCommit_is_CNTinst_``index````cur``; \
    reg [              63:0] dma_InstrCommit_timer_64_value_``index````cur``; \
    reg                      dma_InstrCommit_wen_``index````cur``; \
    reg [               7:0] dma_InstrCommit_wdest_``index````cur``; \
    reg [              63:0] dma_InstrCommit_wdata_``index````cur``; \
    reg                      dma_InstrCommit_csr_rstat_``index````cur``; \
    reg [              31:0] dma_InstrCommit_csr_data_``index````cur``; \
    always @(posedge clk)begin \
        dma_InstrCommit_valid_``index````cur`` <= dma_InstrCommit_valid_``index````pre``; \
        dma_InstrCommit_pc_``index````cur`` <= dma_InstrCommit_pc_``index````pre``; \
        dma_InstrCommit_instr_``index````cur`` <= dma_InstrCommit_instr_``index````pre``; \
        dma_InstrCommit_skip_``index````cur`` <= dma_InstrCommit_skip_``index````pre``; \
        dma_InstrCommit_is_TLBFILL_``index````cur`` <= dma_InstrCommit_is_TLBFILL_``index````pre``; \
        dma_InstrCommit_TLBFILL_index_``index````cur`` <= dma_InstrCommit_TLBFILL_index_``index````pre``; \
        dma_InstrCommit_is_CNTinst_``index````cur`` <= dma_InstrCommit_is_CNTinst_``index````pre``; \
        dma_InstrCommit_timer_64_value_``index````cur`` <= dma_InstrCommit_timer_64_value_``index````pre``; \
        dma_InstrCommit_wen_``index````cur`` <= dma_InstrCommit_wen_``index````pre``; \
        dma_InstrCommit_wdest_``index````cur`` <= dma_InstrCommit_wdest_``index````pre``; \
        dma_InstrCommit_wdata_``index````cur`` <= dma_InstrCommit_wdata_``index````pre``; \
        dma_InstrCommit_csr_rstat_``index````cur`` <= dma_InstrCommit_csr_rstat_``index````pre``; \
        dma_InstrCommit_csr_data_``index````cur`` <= dma_InstrCommit_csr_data_``index````pre``; \
    end \
`endif

`define InstrCommit_out(index) \
`ifdef DIFF_HARDWARE \
    output                      dma_InstrCommit_valid_``index``, \
    output [              63:0] dma_InstrCommit_pc_``index``, \
    output [              31:0] dma_InstrCommit_instr_``index``, \
    output                      dma_InstrCommit_skip_``index``, \
    output                      dma_InstrCommit_is_TLBFILL_``index``, \
    output [               7:0] dma_InstrCommit_TLBFILL_index_``index``, \
    output                      dma_InstrCommit_is_CNTinst_``index``, \
    output [              63:0] dma_InstrCommit_timer_64_value_``index``, \
    output                      dma_InstrCommit_wen_``index``, \
    output [               7:0] dma_InstrCommit_wdest_``index``, \
    output [              63:0] dma_InstrCommit_wdata_``index``, \
    output                      dma_InstrCommit_csr_rstat_``index``, \
    output [              31:0] dma_InstrCommit_csr_data_``index``, \
`endif

`define InstrCommit_in(index) \
`ifdef DIFF_HARDWARE \
    input                      dma_InstrCommit_valid_``index``, \
    input [              63:0] dma_InstrCommit_pc_``index``, \
    input [              31:0] dma_InstrCommit_instr_``index``, \
    input                      dma_InstrCommit_skip_``index``, \
    input                      dma_InstrCommit_is_TLBFILL_``index``, \
    input [               7:0] dma_InstrCommit_TLBFILL_index_``index``, \
    input                      dma_InstrCommit_is_CNTinst_``index``, \
    input [              63:0] dma_InstrCommit_timer_64_value_``index``, \
    input                      dma_InstrCommit_wen_``index``, \
    input [               7:0] dma_InstrCommit_wdest_``index``, \
    input [              63:0] dma_InstrCommit_wdata_``index``, \
    input                      dma_InstrCommit_csr_rstat_``index``, \
    input [              31:0] dma_InstrCommit_csr_data_``index``, \
`endif

`define InstrCommit_connect(index) \
`ifdef DIFF_HARDWARE \
    .dma_InstrCommit_valid_``index``(dma_InstrCommit_valid_``index``), \
    .dma_InstrCommit_pc_``index``(dma_InstrCommit_pc_``index``), \
    .dma_InstrCommit_instr_``index``(dma_InstrCommit_instr_``index``), \
    .dma_InstrCommit_skip_``index``(dma_InstrCommit_skip_``index``), \
    .dma_InstrCommit_is_TLBFILL_``index``(dma_InstrCommit_is_TLBFILL_``index``), \
    .dma_InstrCommit_TLBFILL_index_``index``(dma_InstrCommit_TLBFILL_index_``index``), \
    .dma_InstrCommit_is_CNTinst_``index``(dma_InstrCommit_is_CNTinst_``index``), \
    .dma_InstrCommit_timer_64_value_``index``(dma_InstrCommit_timer_64_value_``index``), \
    .dma_InstrCommit_wen_``index``(dma_InstrCommit_wen_``index``), \
    .dma_InstrCommit_wdest_``index``(dma_InstrCommit_wdest_``index``), \
    .dma_InstrCommit_wdata_``index``(dma_InstrCommit_wdata_``index``), \
    .dma_InstrCommit_csr_rstat_``index``(dma_InstrCommit_csr_rstat_``index``), \
    .dma_InstrCommit_csr_data_``index``(dma_InstrCommit_csr_data_``index``), \
`endif

`define ExcpEvent_wire \
`ifdef DIFF_HARDWARE \
    wire                      dma_ExcpEvent_excp_valid; \
    wire                      dma_ExcpEvent_eret; \
    wire [              31:0] dma_ExcpEvent_intrNo; \
    wire [              31:0] dma_ExcpEvent_cause; \
    wire [              63:0] dma_ExcpEvent_exceptionPC; \
    wire [              31:0] dma_ExcpEvent_exceptionInst; \
`endif

`define ExcpEvent_reg(clk, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg                      dma_ExcpEvent_excp_valid``cur``; \
    reg                      dma_ExcpEvent_eret``cur``; \
    reg [              31:0] dma_ExcpEvent_intrNo``cur``; \
    reg [              31:0] dma_ExcpEvent_cause``cur``; \
    reg [              63:0] dma_ExcpEvent_exceptionPC``cur``; \
    reg [              31:0] dma_ExcpEvent_exceptionInst``cur``; \
    always @(posedge clk)begin \
        dma_ExcpEvent_excp_valid``cur`` <= dma_ExcpEvent_excp_valid``pre``; \
        dma_ExcpEvent_eret``cur`` <= dma_ExcpEvent_eret``pre``; \
        dma_ExcpEvent_intrNo``cur`` <= dma_ExcpEvent_intrNo``pre``; \
        dma_ExcpEvent_cause``cur`` <= dma_ExcpEvent_cause``pre``; \
        dma_ExcpEvent_exceptionPC``cur`` <= dma_ExcpEvent_exceptionPC``pre``; \
        dma_ExcpEvent_exceptionInst``cur`` <= dma_ExcpEvent_exceptionInst``pre``; \
    end \
`endif

`define ExcpEvent_out \
`ifdef DIFF_HARDWARE \
    output                      dma_ExcpEvent_excp_valid, \
    output                      dma_ExcpEvent_eret, \
    output [              31:0] dma_ExcpEvent_intrNo, \
    output [              31:0] dma_ExcpEvent_cause, \
    output [              63:0] dma_ExcpEvent_exceptionPC, \
    output [              31:0] dma_ExcpEvent_exceptionInst, \
`endif

`define ExcpEvent_in \
`ifdef DIFF_HARDWARE \
    input                      dma_ExcpEvent_excp_valid, \
    input                      dma_ExcpEvent_eret, \
    input [              31:0] dma_ExcpEvent_intrNo, \
    input [              31:0] dma_ExcpEvent_cause, \
    input [              63:0] dma_ExcpEvent_exceptionPC, \
    input [              31:0] dma_ExcpEvent_exceptionInst, \
`endif

`define ExcpEvent_connect \
`ifdef DIFF_HARDWARE \
    .dma_ExcpEvent_excp_valid(dma_ExcpEvent_excp_valid), \
    .dma_ExcpEvent_eret(dma_ExcpEvent_eret), \
    .dma_ExcpEvent_intrNo(dma_ExcpEvent_intrNo), \
    .dma_ExcpEvent_cause(dma_ExcpEvent_cause), \
    .dma_ExcpEvent_exceptionPC(dma_ExcpEvent_exceptionPC), \
    .dma_ExcpEvent_exceptionInst(dma_ExcpEvent_exceptionInst), \
`endif

`define TrapEvent_wire \
`ifdef DIFF_HARDWARE \
    wire                      dma_TrapEvent_valid; \
    wire [               7:0] dma_TrapEvent_code; \
    wire [              63:0] dma_TrapEvent_pc; \
    wire [              63:0] dma_TrapEvent_cycleCnt; \
    wire [              63:0] dma_TrapEvent_instrCnt; \
`endif

`define TrapEvent_reg(clk, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg                      dma_TrapEvent_valid``cur``; \
    reg [               7:0] dma_TrapEvent_code``cur``; \
    reg [              63:0] dma_TrapEvent_pc``cur``; \
    reg [              63:0] dma_TrapEvent_cycleCnt``cur``; \
    reg [              63:0] dma_TrapEvent_instrCnt``cur``; \
    always @(posedge clk)begin \
        dma_TrapEvent_valid``cur`` <= dma_TrapEvent_valid``pre``; \
        dma_TrapEvent_code``cur`` <= dma_TrapEvent_code``pre``; \
        dma_TrapEvent_pc``cur`` <= dma_TrapEvent_pc``pre``; \
        dma_TrapEvent_cycleCnt``cur`` <= dma_TrapEvent_cycleCnt``pre``; \
        dma_TrapEvent_instrCnt``cur`` <= dma_TrapEvent_instrCnt``pre``; \
    end \
`endif

`define TrapEvent_out \
`ifdef DIFF_HARDWARE \
    output                      dma_TrapEvent_valid, \
    output [               7:0] dma_TrapEvent_code, \
    output [              63:0] dma_TrapEvent_pc, \
    output [              63:0] dma_TrapEvent_cycleCnt, \
    output [              63:0] dma_TrapEvent_instrCnt, \
`endif

`define TrapEvent_in \
`ifdef DIFF_HARDWARE \
    input                      dma_TrapEvent_valid, \
    input [               7:0] dma_TrapEvent_code, \
    input [              63:0] dma_TrapEvent_pc, \
    input [              63:0] dma_TrapEvent_cycleCnt, \
    input [              63:0] dma_TrapEvent_instrCnt, \
`endif

`define TrapEvent_connect \
`ifdef DIFF_HARDWARE \
    .dma_TrapEvent_valid(dma_TrapEvent_valid), \
    .dma_TrapEvent_code(dma_TrapEvent_code), \
    .dma_TrapEvent_pc(dma_TrapEvent_pc), \
    .dma_TrapEvent_cycleCnt(dma_TrapEvent_cycleCnt), \
    .dma_TrapEvent_instrCnt(dma_TrapEvent_instrCnt), \
`endif

`define StoreEvent_wire(index) \
`ifdef DIFF_HARDWARE \
    wire [               7:0] dma_StoreEvent_valid_``index``; \
    wire [              63:0] dma_StoreEvent_storePAddr_``index``; \
    wire [              63:0] dma_StoreEvent_storeData_``index``; \
    wire [               7:0] dma_StoreEvent_storeMask_``index``; \
`endif

`define StoreEvent_reg(clk, index, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg                      dma_StoreEvent_valid_``index````cur``; \
    reg [              63:0] dma_StoreEvent_storePAddr_``index````cur``; \
    reg [              63:0] dma_StoreEvent_storeData_``index````cur``; \
    reg [               7:0] dma_StoreEvent_storeMask_``index````cur``; \
    always @(posedge clk)begin \
        dma_StoreEvent_valid_``index````cur`` <= dma_StoreEvent_valid_``index````pre``; \
        dma_StoreEvent_storePAddr_``index````cur`` <= dma_StoreEvent_storePAddr_``index````pre``; \
        dma_StoreEvent_storeData_``index````cur`` <= dma_StoreEvent_storeData_``index````pre``; \
        dma_StoreEvent_storeMask_``index````cur`` <= dma_StoreEvent_storeMask_``index````pre``; \
    end \
`endif

`define StoreEvent_out(index) \
`ifdef DIFF_HARDWARE \
    output                      dma_StoreEvent_valid_``index``, \
    output [              63:0] dma_StoreEvent_storePAddr_``index``, \
    output [              63:0] dma_StoreEvent_storeData_``index``, \
    output [               7:0] dma_StoreEvent_storeMask_``index``, \
`endif

`define StoreEvent_in(index) \
`ifdef DIFF_HARDWARE \
    input                      dma_StoreEvent_valid_``index``, \
    input [              63:0] dma_StoreEvent_storePAddr_``index``, \
    input [              63:0] dma_StoreEvent_storeData_``index``, \
    input [               7:0] dma_StoreEvent_storeMask_``index``, \
`endif

`define StoreEvent_connect(index) \
`ifdef DIFF_HARDWARE \
    .dma_StoreEvent_valid_``index``(dma_StoreEvent_valid_``index``), \
    .dma_StoreEvent_storePAddr_``index``(dma_StoreEvent_storePAddr_``index``), \
    .dma_StoreEvent_storeData_``index``(dma_StoreEvent_storeData_``index``), \
    .dma_StoreEvent_storeMask_``index``(dma_StoreEvent_storeMask_``index``), \
`endif

`define LoadEvent_wire(index) \
`ifdef DIFF_HARDWARE \
    wire [               7:0] dma_LoadEvent_valid_``index``; \
    wire [              63:0] dma_LoadEvent_paddr_``index``; \
    wire [              63:0] dma_LoadEvent_vaddr_``index``; \
`endif  


`define LoadEvent_reg(clk, index, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg                      dma_LoadEvent_valid_``index````cur``; \
    reg [              63:0] dma_LoadEvent_paddr_``index````cur``; \
    reg [              63:0] dma_LoadEvent_vaddr_``index````cur``; \
    always @(posedge clk)begin \
        dma_LoadEvent_valid_``index````cur`` <= dma_LoadEvent_valid_``index````pre``; \
        dma_LoadEvent_paddr_``index````cur`` <= dma_LoadEvent_paddr_``index````pre``; \
        dma_LoadEvent_vaddr_``index````cur`` <= dma_LoadEvent_vaddr_``index````pre``; \
    end \
`endif

`define LoadEvent_out(index) \
`ifdef DIFF_HARDWARE \
    output                      dma_LoadEvent_valid_``index``, \
    output [              63:0] dma_LoadEvent_paddr_``index``, \
    output [              63:0] dma_LoadEvent_vaddr_``index``, \
`endif

`define LoadEvent_in(index) \
`ifdef DIFF_HARDWARE \
    input                      dma_LoadEvent_valid_``index``, \
    input [              63:0] dma_LoadEvent_paddr_``index``, \
    input [              63:0] dma_LoadEvent_vaddr_``index``, \
`endif

`define LoadEvent_connect(index) \
`ifdef DIFF_HARDWARE \
    .dma_LoadEvent_valid_``index``(dma_LoadEvent_valid_``index``), \
    .dma_LoadEvent_paddr_``index``(dma_LoadEvent_paddr_``index``), \
    .dma_LoadEvent_vaddr_``index``(dma_LoadEvent_vaddr_``index``), \
`endif

`define CSRRegState_wire \
`ifdef DIFF_HARDWARE \
    wire [              63:0] dma_CSRRegState_crmd; \
    wire [              63:0] dma_CSRRegState_prmd; \
    wire [              63:0] dma_CSRRegState_euen; \
    wire [              63:0] dma_CSRRegState_ecfg; \
    wire [              63:0] dma_CSRRegState_estat; \
    wire [              63:0] dma_CSRRegState_era; \
    wire [              63:0] dma_CSRRegState_badv; \
    wire [              63:0] dma_CSRRegState_eentry; \
    wire [              63:0] dma_CSRRegState_tlbidx; \
    wire [              63:0] dma_CSRRegState_tlbehi; \
    wire [              63:0] dma_CSRRegState_tlbelo0; \
    wire [              63:0] dma_CSRRegState_tlbelo1; \
    wire [              63:0] dma_CSRRegState_asid; \
    wire [              63:0] dma_CSRRegState_pgdl; \
    wire [              63:0] dma_CSRRegState_pgdh; \
    wire [              63:0] dma_CSRRegState_save0; \
    wire [              63:0] dma_CSRRegState_save1; \
    wire [              63:0] dma_CSRRegState_save2; \
    wire [              63:0] dma_CSRRegState_save3; \
    wire [              63:0] dma_CSRRegState_tid; \
    wire [              63:0] dma_CSRRegState_tcfg; \
    wire [              63:0] dma_CSRRegState_tval; \
    wire [              63:0] dma_CSRRegState_ticlr; \
    wire [              63:0] dma_CSRRegState_llbctl; \
    wire [              63:0] dma_CSRRegState_tlbrentry; \
    wire [              63:0] dma_CSRRegState_dmw0; \
    wire [              63:0] dma_CSRRegState_dmw1; \
`endif

`define CSRRegState_reg(clk, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg [              63:0] dma_CSRRegState_crmd``cur``; \
    reg [              63:0] dma_CSRRegState_prmd``cur``; \
    reg [              63:0] dma_CSRRegState_euen``cur``; \
    reg [              63:0] dma_CSRRegState_ecfg``cur``; \
    reg [              63:0] dma_CSRRegState_estat``cur``; \
    reg [              63:0] dma_CSRRegState_era``cur``; \
    reg [              63:0] dma_CSRRegState_badv``cur``; \
    reg [              63:0] dma_CSRRegState_eentry``cur``; \
    reg [              63:0] dma_CSRRegState_tlbidx``cur``; \
    reg [              63:0] dma_CSRRegState_tlbehi``cur``; \
    reg [              63:0] dma_CSRRegState_tlbelo0``cur``; \
    reg [              63:0] dma_CSRRegState_tlbelo1``cur``; \
    reg [              63:0] dma_CSRRegState_asid``cur``; \
    reg [              63:0] dma_CSRRegState_pgdl``cur``; \
    reg [              63:0] dma_CSRRegState_pgdh``cur``; \
    reg [              63:0] dma_CSRRegState_save0``cur``; \
    reg [              63:0] dma_CSRRegState_save1``cur``; \
    reg [              63:0] dma_CSRRegState_save2``cur``; \
    reg [              63:0] dma_CSRRegState_save3``cur``; \
    reg [              63:0] dma_CSRRegState_tid``cur``; \
    reg [              63:0] dma_CSRRegState_tcfg``cur``; \
    reg [              63:0] dma_CSRRegState_tval``cur``; \
    reg [              63:0] dma_CSRRegState_ticlr``cur``; \
    reg [              63:0] dma_CSRRegState_llbctl``cur``; \
    reg [              63:0] dma_CSRRegState_tlbrentry``cur``; \
    reg [              63:0] dma_CSRRegState_dmw0``cur``; \
    reg [              63:0] dma_CSRRegState_dmw1``cur``; \
    always @(posedge clk)begin \
        dma_CSRRegState_crmd``cur`` <= dma_CSRRegState_crmd``pre``; \
        dma_CSRRegState_prmd``cur`` <= dma_CSRRegState_prmd``pre``; \
        dma_CSRRegState_euen``cur`` <= dma_CSRRegState_euen``pre``; \
        dma_CSRRegState_ecfg``cur`` <= dma_CSRRegState_ecfg``pre``; \
        dma_CSRRegState_estat``cur`` <= dma_CSRRegState_estat``pre``; \
        dma_CSRRegState_era``cur`` <= dma_CSRRegState_era``pre``; \
        dma_CSRRegState_badv``cur`` <= dma_CSRRegState_badv``pre``; \
        dma_CSRRegState_eentry``cur`` <= dma_CSRRegState_eentry``pre``; \
        dma_CSRRegState_tlbidx``cur`` <= dma_CSRRegState_tlbidx``pre``; \
        dma_CSRRegState_tlbehi``cur`` <= dma_CSRRegState_tlbehi``pre``; \
        dma_CSRRegState_tlbelo0``cur`` <= dma_CSRRegState_tlbelo0``pre``; \
        dma_CSRRegState_tlbelo1``cur`` <= dma_CSRRegState_tlbelo1``pre``; \
        dma_CSRRegState_asid``cur`` <= dma_CSRRegState_asid``pre``; \
        dma_CSRRegState_pgdl``cur`` <= dma_CSRRegState_pgdl``pre``; \
        dma_CSRRegState_pgdh``cur`` <= dma_CSRRegState_pgdh``pre``; \
        dma_CSRRegState_save0``cur`` <= dma_CSRRegState_save0``pre``; \
        dma_CSRRegState_save1``cur`` <= dma_CSRRegState_save1``pre``; \
        dma_CSRRegState_save2``cur`` <= dma_CSRRegState_save2``pre``; \
        dma_CSRRegState_save3``cur`` <= dma_CSRRegState_save3``pre``; \
        dma_CSRRegState_tid``cur`` <= dma_CSRRegState_tid``pre``; \
        dma_CSRRegState_tcfg``cur`` <= dma_CSRRegState_tcfg``pre``; \
        dma_CSRRegState_tval``cur`` <= dma_CSRRegState_tval``pre``; \
        dma_CSRRegState_ticlr``cur`` <= dma_CSRRegState_ticlr``pre``; \
        dma_CSRRegState_llbctl``cur`` <= dma_CSRRegState_llbctl``pre``; \
        dma_CSRRegState_tlbrentry``cur`` <= dma_CSRRegState_tlbrentry``pre``; \
        dma_CSRRegState_dmw0``cur`` <= dma_CSRRegState_dmw0``pre``; \
        dma_CSRRegState_dmw1``cur`` <= dma_CSRRegState_dmw1``pre``; \
    end \
`endif

`define CSRRegState_out \
`ifdef DIFF_HARDWARE \
    output [              63:0] dma_CSRRegState_crmd, \
    output [              63:0] dma_CSRRegState_prmd, \
    output [              63:0] dma_CSRRegState_euen, \
    output [              63:0] dma_CSRRegState_ecfg, \
    output [              63:0] dma_CSRRegState_estat, \
    output [              63:0] dma_CSRRegState_era, \
    output [              63:0] dma_CSRRegState_badv, \
    output [              63:0] dma_CSRRegState_eentry, \
    output [              63:0] dma_CSRRegState_tlbidx, \
    output [              63:0] dma_CSRRegState_tlbehi, \
    output [              63:0] dma_CSRRegState_tlbelo0, \
    output [              63:0] dma_CSRRegState_tlbelo1, \
    output [              63:0] dma_CSRRegState_asid, \
    output [              63:0] dma_CSRRegState_pgdl, \
    output [              63:0] dma_CSRRegState_pgdh, \
    output [              63:0] dma_CSRRegState_save0, \
    output [              63:0] dma_CSRRegState_save1, \
    output [              63:0] dma_CSRRegState_save2, \
    output [              63:0] dma_CSRRegState_save3, \
    output [              63:0] dma_CSRRegState_tid, \
    output [              63:0] dma_CSRRegState_tcfg, \
    output [              63:0] dma_CSRRegState_tval, \
    output [              63:0] dma_CSRRegState_ticlr, \
    output [              63:0] dma_CSRRegState_llbctl, \
    output [              63:0] dma_CSRRegState_tlbrentry, \
    output [              63:0] dma_CSRRegState_dmw0, \
    output [              63:0] dma_CSRRegState_dmw1, \
`endif

`define CSRRegState_in \
`ifdef DIFF_HARDWARE \
    input [              63:0] dma_CSRRegState_crmd, \
    input [              63:0] dma_CSRRegState_prmd, \
    input [              63:0] dma_CSRRegState_euen, \
    input [              63:0] dma_CSRRegState_ecfg, \
    input [              63:0] dma_CSRRegState_estat, \
    input [              63:0] dma_CSRRegState_era, \
    input [              63:0] dma_CSRRegState_badv, \
    input [              63:0] dma_CSRRegState_eentry, \
    input [              63:0] dma_CSRRegState_tlbidx, \
    input [              63:0] dma_CSRRegState_tlbehi, \
    input [              63:0] dma_CSRRegState_tlbelo0, \
    input [              63:0] dma_CSRRegState_tlbelo1, \
    input [              63:0] dma_CSRRegState_asid, \
    input [              63:0] dma_CSRRegState_pgdl, \
    input [              63:0] dma_CSRRegState_pgdh, \
    input [              63:0] dma_CSRRegState_save0, \
    input [              63:0] dma_CSRRegState_save1, \
    input [              63:0] dma_CSRRegState_save2, \
    input [              63:0] dma_CSRRegState_save3, \
    input [              63:0] dma_CSRRegState_tid, \
    input [              63:0] dma_CSRRegState_tcfg, \
    input [              63:0] dma_CSRRegState_tval, \
    input [              63:0] dma_CSRRegState_ticlr, \
    input [              63:0] dma_CSRRegState_llbctl, \
    input [              63:0] dma_CSRRegState_tlbrentry, \
    input [              63:0] dma_CSRRegState_dmw0, \
    input [              63:0] dma_CSRRegState_dmw1, \
`endif

`define CSRRegState_connect \
`ifdef DIFF_HARDWARE \
    .dma_CSRRegState_crmd(dma_CSRRegState_crmd), \
    .dma_CSRRegState_prmd(dma_CSRRegState_prmd), \
    .dma_CSRRegState_euen(dma_CSRRegState_euen), \
    .dma_CSRRegState_ecfg(dma_CSRRegState_ecfg), \
    .dma_CSRRegState_estat(dma_CSRRegState_estat), \
    .dma_CSRRegState_era(dma_CSRRegState_era), \
    .dma_CSRRegState_badv(dma_CSRRegState_badv), \
    .dma_CSRRegState_eentry(dma_CSRRegState_eentry), \
    .dma_CSRRegState_tlbidx(dma_CSRRegState_tlbidx), \
    .dma_CSRRegState_tlbehi(dma_CSRRegState_tlbehi), \
    .dma_CSRRegState_tlbelo0(dma_CSRRegState_tlbelo0), \
    .dma_CSRRegState_tlbelo1(dma_CSRRegState_tlbelo1), \
    .dma_CSRRegState_asid(dma_CSRRegState_asid), \
    .dma_CSRRegState_pgdl(dma_CSRRegState_pgdl), \
    .dma_CSRRegState_pgdh(dma_CSRRegState_pgdh), \
    .dma_CSRRegState_save0(dma_CSRRegState_save0), \
    .dma_CSRRegState_save1(dma_CSRRegState_save1), \
    .dma_CSRRegState_save2(dma_CSRRegState_save2), \
    .dma_CSRRegState_save3(dma_CSRRegState_save3), \
    .dma_CSRRegState_tid(dma_CSRRegState_tid), \
    .dma_CSRRegState_tcfg(dma_CSRRegState_tcfg), \
    .dma_CSRRegState_tval(dma_CSRRegState_tval), \
    .dma_CSRRegState_ticlr(dma_CSRRegState_ticlr), \
    .dma_CSRRegState_llbctl(dma_CSRRegState_llbctl), \
    .dma_CSRRegState_tlbrentry(dma_CSRRegState_tlbrentry), \
    .dma_CSRRegState_dmw0(dma_CSRRegState_dmw0), \
    .dma_CSRRegState_dmw1(dma_CSRRegState_dmw1), \
`endif

`define GRegState_wire \
`ifdef DIFF_HARDWARE \
    wire [              63:0] dma_GRegState_gpr_0; \
    wire [              63:0] dma_GRegState_gpr_1; \
    wire [              63:0] dma_GRegState_gpr_2; \
    wire [              63:0] dma_GRegState_gpr_3; \
    wire [              63:0] dma_GRegState_gpr_4; \
    wire [              63:0] dma_GRegState_gpr_5; \
    wire [              63:0] dma_GRegState_gpr_6; \
    wire [              63:0] dma_GRegState_gpr_7; \
    wire [              63:0] dma_GRegState_gpr_8; \
    wire [              63:0] dma_GRegState_gpr_9; \
    wire [              63:0] dma_GRegState_gpr_10; \
    wire [              63:0] dma_GRegState_gpr_11; \
    wire [              63:0] dma_GRegState_gpr_12; \
    wire [              63:0] dma_GRegState_gpr_13; \
    wire [              63:0] dma_GRegState_gpr_14; \
    wire [              63:0] dma_GRegState_gpr_15; \
    wire [              63:0] dma_GRegState_gpr_16; \
    wire [              63:0] dma_GRegState_gpr_17; \
    wire [              63:0] dma_GRegState_gpr_18; \
    wire [              63:0] dma_GRegState_gpr_19; \
    wire [              63:0] dma_GRegState_gpr_20; \
    wire [              63:0] dma_GRegState_gpr_21; \
    wire [              63:0] dma_GRegState_gpr_22; \
    wire [              63:0] dma_GRegState_gpr_23; \
    wire [              63:0] dma_GRegState_gpr_24; \
    wire [              63:0] dma_GRegState_gpr_25; \
    wire [              63:0] dma_GRegState_gpr_26; \
    wire [              63:0] dma_GRegState_gpr_27; \
    wire [              63:0] dma_GRegState_gpr_28; \
    wire [              63:0] dma_GRegState_gpr_29; \
    wire [              63:0] dma_GRegState_gpr_30; \
    wire [              63:0] dma_GRegState_gpr_31; \
`endif

`define GRegState_reg(clk, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg [              63:0] dma_GRegState_gpr_0``cur``; \
    reg [              63:0] dma_GRegState_gpr_1``cur``; \
    reg [              63:0] dma_GRegState_gpr_2``cur``; \
    reg [              63:0] dma_GRegState_gpr_3``cur``; \
    reg [              63:0] dma_GRegState_gpr_4``cur``; \
    reg [              63:0] dma_GRegState_gpr_5``cur``; \
    reg [              63:0] dma_GRegState_gpr_6``cur``; \
    reg [              63:0] dma_GRegState_gpr_7``cur``; \
    reg [              63:0] dma_GRegState_gpr_8``cur``; \
    reg [              63:0] dma_GRegState_gpr_9``cur``; \
    reg [              63:0] dma_GRegState_gpr_10``cur``; \
    reg [              63:0] dma_GRegState_gpr_11``cur``; \
    reg [              63:0] dma_GRegState_gpr_12``cur``; \
    reg [              63:0] dma_GRegState_gpr_13``cur``; \
    reg [              63:0] dma_GRegState_gpr_14``cur``; \
    reg [              63:0] dma_GRegState_gpr_15``cur``; \
    reg [              63:0] dma_GRegState_gpr_16``cur``; \
    reg [              63:0] dma_GRegState_gpr_17``cur``; \
    reg [              63:0] dma_GRegState_gpr_18``cur``; \
    reg [              63:0] dma_GRegState_gpr_19``cur``; \
    reg [              63:0] dma_GRegState_gpr_20``cur``; \
    reg [              63:0] dma_GRegState_gpr_21``cur``; \
    reg [              63:0] dma_GRegState_gpr_22``cur``; \
    reg [              63:0] dma_GRegState_gpr_23``cur``; \
    reg [              63:0] dma_GRegState_gpr_24``cur``; \
    reg [              63:0] dma_GRegState_gpr_25``cur``; \
    reg [              63:0] dma_GRegState_gpr_26``cur``; \
    reg [              63:0] dma_GRegState_gpr_27``cur``; \
    reg [              63:0] dma_GRegState_gpr_28``cur``; \
    reg [              63:0] dma_GRegState_gpr_29``cur``; \
    reg [              63:0] dma_GRegState_gpr_30``cur``; \
    reg [              63:0] dma_GRegState_gpr_31``cur``; \
    always @(posedge clk)begin \
        dma_GRegState_gpr_0``cur`` <= dma_GRegState_gpr_0``pre``; \
        dma_GRegState_gpr_1``cur`` <= dma_GRegState_gpr_1``pre``; \
        dma_GRegState_gpr_2``cur`` <= dma_GRegState_gpr_2``pre``; \
        dma_GRegState_gpr_3``cur`` <= dma_GRegState_gpr_3``pre``; \
        dma_GRegState_gpr_4``cur`` <= dma_GRegState_gpr_4``pre``; \
        dma_GRegState_gpr_5``cur`` <= dma_GRegState_gpr_5``pre``; \
        dma_GRegState_gpr_6``cur`` <= dma_GRegState_gpr_6``pre``; \
        dma_GRegState_gpr_7``cur`` <= dma_GRegState_gpr_7``pre``; \
        dma_GRegState_gpr_8``cur`` <= dma_GRegState_gpr_8``pre``; \
        dma_GRegState_gpr_9``cur`` <= dma_GRegState_gpr_9``pre``; \
        dma_GRegState_gpr_10``cur`` <= dma_GRegState_gpr_10``pre``; \
        dma_GRegState_gpr_11``cur`` <= dma_GRegState_gpr_11``pre``; \
        dma_GRegState_gpr_12``cur`` <= dma_GRegState_gpr_12``pre``; \
        dma_GRegState_gpr_13``cur`` <= dma_GRegState_gpr_13``pre``; \
        dma_GRegState_gpr_14``cur`` <= dma_GRegState_gpr_14``pre``; \
        dma_GRegState_gpr_15``cur`` <= dma_GRegState_gpr_15``pre``; \
        dma_GRegState_gpr_16``cur`` <= dma_GRegState_gpr_16``pre``; \
        dma_GRegState_gpr_17``cur`` <= dma_GRegState_gpr_17``pre``; \
        dma_GRegState_gpr_18``cur`` <= dma_GRegState_gpr_18``pre``; \
        dma_GRegState_gpr_19``cur`` <= dma_GRegState_gpr_19``pre``; \
        dma_GRegState_gpr_20``cur`` <= dma_GRegState_gpr_20``pre``; \
        dma_GRegState_gpr_21``cur`` <= dma_GRegState_gpr_21``pre``; \
        dma_GRegState_gpr_22``cur`` <= dma_GRegState_gpr_22``pre``; \
        dma_GRegState_gpr_23``cur`` <= dma_GRegState_gpr_23``pre``; \
        dma_GRegState_gpr_24``cur`` <= dma_GRegState_gpr_24``pre``; \
        dma_GRegState_gpr_25``cur`` <= dma_GRegState_gpr_25``pre``; \
        dma_GRegState_gpr_26``cur`` <= dma_GRegState_gpr_26``pre``; \
        dma_GRegState_gpr_27``cur`` <= dma_GRegState_gpr_27``pre``; \
        dma_GRegState_gpr_28``cur`` <= dma_GRegState_gpr_28``pre``; \
        dma_GRegState_gpr_29``cur`` <= dma_GRegState_gpr_29``pre``; \
        dma_GRegState_gpr_30``cur`` <= dma_GRegState_gpr_30``pre``; \
        dma_GRegState_gpr_31``cur`` <= dma_GRegState_gpr_31``pre``; \
    end \
`endif



`define GRegState_out \
`ifdef DIFF_HARDWARE \
    output [              63:0] dma_GRegState_gpr_0, \
    output [              63:0] dma_GRegState_gpr_1, \
    output [              63:0] dma_GRegState_gpr_2, \
    output [              63:0] dma_GRegState_gpr_3, \
    output [              63:0] dma_GRegState_gpr_4, \
    output [              63:0] dma_GRegState_gpr_5, \
    output [              63:0] dma_GRegState_gpr_6, \
    output [              63:0] dma_GRegState_gpr_7, \
    output [              63:0] dma_GRegState_gpr_8, \
    output [              63:0] dma_GRegState_gpr_9, \
    output [              63:0] dma_GRegState_gpr_10, \
    output [              63:0] dma_GRegState_gpr_11, \
    output [              63:0] dma_GRegState_gpr_12, \
    output [              63:0] dma_GRegState_gpr_13, \
    output [              63:0] dma_GRegState_gpr_14, \
    output [              63:0] dma_GRegState_gpr_15, \
    output [              63:0] dma_GRegState_gpr_16, \
    output [              63:0] dma_GRegState_gpr_17, \
    output [              63:0] dma_GRegState_gpr_18, \
    output [              63:0] dma_GRegState_gpr_19, \
    output [              63:0] dma_GRegState_gpr_20, \
    output [              63:0] dma_GRegState_gpr_21, \
    output [              63:0] dma_GRegState_gpr_22, \
    output [              63:0] dma_GRegState_gpr_23, \
    output [              63:0] dma_GRegState_gpr_24, \
    output [              63:0] dma_GRegState_gpr_25, \
    output [              63:0] dma_GRegState_gpr_26, \
    output [              63:0] dma_GRegState_gpr_27, \
    output [              63:0] dma_GRegState_gpr_28, \
    output [              63:0] dma_GRegState_gpr_29, \
    output [              63:0] dma_GRegState_gpr_30, \
    output [              63:0] dma_GRegState_gpr_31, \
`endif



`define GRegState_in \
`ifdef DIFF_HARDWARE \
    input [              63:0] dma_GRegState_gpr_0, \
    input [              63:0] dma_GRegState_gpr_1, \
    input [              63:0] dma_GRegState_gpr_2, \
    input [              63:0] dma_GRegState_gpr_3, \
    input [              63:0] dma_GRegState_gpr_4, \
    input [              63:0] dma_GRegState_gpr_5, \
    input [              63:0] dma_GRegState_gpr_6, \
    input [              63:0] dma_GRegState_gpr_7, \
    input [              63:0] dma_GRegState_gpr_8, \
    input [              63:0] dma_GRegState_gpr_9, \
    input [              63:0] dma_GRegState_gpr_10, \
    input [              63:0] dma_GRegState_gpr_11, \
    input [              63:0] dma_GRegState_gpr_12, \
    input [              63:0] dma_GRegState_gpr_13, \
    input [              63:0] dma_GRegState_gpr_14, \
    input [              63:0] dma_GRegState_gpr_15, \
    input [              63:0] dma_GRegState_gpr_16, \
    input [              63:0] dma_GRegState_gpr_17, \
    input [              63:0] dma_GRegState_gpr_18, \
    input [              63:0] dma_GRegState_gpr_19, \
    input [              63:0] dma_GRegState_gpr_20, \
    input [              63:0] dma_GRegState_gpr_21, \
    input [              63:0] dma_GRegState_gpr_22, \
    input [              63:0] dma_GRegState_gpr_23, \
    input [              63:0] dma_GRegState_gpr_24, \
    input [              63:0] dma_GRegState_gpr_25, \
    input [              63:0] dma_GRegState_gpr_26, \
    input [              63:0] dma_GRegState_gpr_27, \
    input [              63:0] dma_GRegState_gpr_28, \
    input [              63:0] dma_GRegState_gpr_29, \
    input [              63:0] dma_GRegState_gpr_30, \
    input [              63:0] dma_GRegState_gpr_31, \
`endif



`define GRegState_connect \
`ifdef DIFF_HARDWARE \
    .dma_GRegState_gpr_0(dma_GRegState_gpr_0), \
    .dma_GRegState_gpr_1(dma_GRegState_gpr_1), \
    .dma_GRegState_gpr_2(dma_GRegState_gpr_2), \
    .dma_GRegState_gpr_3(dma_GRegState_gpr_3), \
    .dma_GRegState_gpr_4(dma_GRegState_gpr_4), \
    .dma_GRegState_gpr_5(dma_GRegState_gpr_5), \
    .dma_GRegState_gpr_6(dma_GRegState_gpr_6), \
    .dma_GRegState_gpr_7(dma_GRegState_gpr_7), \
    .dma_GRegState_gpr_8(dma_GRegState_gpr_8), \
    .dma_GRegState_gpr_9(dma_GRegState_gpr_9), \
    .dma_GRegState_gpr_10(dma_GRegState_gpr_10), \
    .dma_GRegState_gpr_11(dma_GRegState_gpr_11), \
    .dma_GRegState_gpr_12(dma_GRegState_gpr_12), \
    .dma_GRegState_gpr_13(dma_GRegState_gpr_13), \
    .dma_GRegState_gpr_14(dma_GRegState_gpr_14), \
    .dma_GRegState_gpr_15(dma_GRegState_gpr_15), \
    .dma_GRegState_gpr_16(dma_GRegState_gpr_16), \
    .dma_GRegState_gpr_17(dma_GRegState_gpr_17), \
    .dma_GRegState_gpr_18(dma_GRegState_gpr_18), \
    .dma_GRegState_gpr_19(dma_GRegState_gpr_19), \
    .dma_GRegState_gpr_20(dma_GRegState_gpr_20), \
    .dma_GRegState_gpr_21(dma_GRegState_gpr_21), \
    .dma_GRegState_gpr_22(dma_GRegState_gpr_22), \
    .dma_GRegState_gpr_23(dma_GRegState_gpr_23), \
    .dma_GRegState_gpr_24(dma_GRegState_gpr_24), \
    .dma_GRegState_gpr_25(dma_GRegState_gpr_25), \
    .dma_GRegState_gpr_26(dma_GRegState_gpr_26), \
    .dma_GRegState_gpr_27(dma_GRegState_gpr_27), \
    .dma_GRegState_gpr_28(dma_GRegState_gpr_28), \
    .dma_GRegState_gpr_29(dma_GRegState_gpr_29), \
    .dma_GRegState_gpr_30(dma_GRegState_gpr_30), \
    .dma_GRegState_gpr_31(dma_GRegState_gpr_31), \
`endif



`define FPRegState_wire \
`ifdef DIFF_HARDWARE \
    wire [              63:0] dma_FPRegState_fpr_0; \
    wire [              63:0] dma_FPRegState_fpr_1; \
    wire [              63:0] dma_FPRegState_fpr_2; \
    wire [              63:0] dma_FPRegState_fpr_3; \
    wire [              63:0] dma_FPRegState_fpr_4; \
    wire [              63:0] dma_FPRegState_fpr_5; \
    wire [              63:0] dma_FPRegState_fpr_6; \
    wire [              63:0] dma_FPRegState_fpr_7; \
    wire [              63:0] dma_FPRegState_fpr_8; \
    wire [              63:0] dma_FPRegState_fpr_9; \
    wire [              63:0] dma_FPRegState_fpr_10; \
    wire [              63:0] dma_FPRegState_fpr_11; \
    wire [              63:0] dma_FPRegState_fpr_12; \
    wire [              63:0] dma_FPRegState_fpr_13; \
    wire [              63:0] dma_FPRegState_fpr_14; \
    wire [              63:0] dma_FPRegState_fpr_15; \
    wire [              63:0] dma_FPRegState_fpr_16; \
    wire [              63:0] dma_FPRegState_fpr_17; \
    wire [              63:0] dma_FPRegState_fpr_18; \
    wire [              63:0] dma_FPRegState_fpr_19; \
    wire [              63:0] dma_FPRegState_fpr_20; \
    wire [              63:0] dma_FPRegState_fpr_21; \
    wire [              63:0] dma_FPRegState_fpr_22; \
    wire [              63:0] dma_FPRegState_fpr_23; \
    wire [              63:0] dma_FPRegState_fpr_24; \
    wire [              63:0] dma_FPRegState_fpr_25; \
    wire [              63:0] dma_FPRegState_fpr_26; \
    wire [              63:0] dma_FPRegState_fpr_27; \
    wire [              63:0] dma_FPRegState_fpr_28; \
    wire [              63:0] dma_FPRegState_fpr_29; \
    wire [              63:0] dma_FPRegState_fpr_30; \
    wire [              63:0] dma_FPRegState_fpr_31; \
    wire [               7:0] dma_FPRegState_fccr; \
    wire [              31:0] dma_FPRegState_fcsr0; \
`endif



`define FPRegState_reg(clk, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg [              63:0] dma_FPRegState_fpr_0``cur``; \
    reg [              63:0] dma_FPRegState_fpr_1``cur``; \
    reg [              63:0] dma_FPRegState_fpr_2``cur``; \
    reg [              63:0] dma_FPRegState_fpr_3``cur``; \
    reg [              63:0] dma_FPRegState_fpr_4``cur``; \
    reg [              63:0] dma_FPRegState_fpr_5``cur``; \
    reg [              63:0] dma_FPRegState_fpr_6``cur``; \
    reg [              63:0] dma_FPRegState_fpr_7``cur``; \
    reg [              63:0] dma_FPRegState_fpr_8``cur``; \
    reg [              63:0] dma_FPRegState_fpr_9``cur``; \
    reg [              63:0] dma_FPRegState_fpr_10``cur``; \
    reg [              63:0] dma_FPRegState_fpr_11``cur``; \
    reg [              63:0] dma_FPRegState_fpr_12``cur``; \
    reg [              63:0] dma_FPRegState_fpr_13``cur``; \
    reg [              63:0] dma_FPRegState_fpr_14``cur``; \
    reg [              63:0] dma_FPRegState_fpr_15``cur``; \
    reg [              63:0] dma_FPRegState_fpr_16``cur``; \
    reg [              63:0] dma_FPRegState_fpr_17``cur``; \
    reg [              63:0] dma_FPRegState_fpr_18``cur``; \
    reg [              63:0] dma_FPRegState_fpr_19``cur``; \
    reg [              63:0] dma_FPRegState_fpr_20``cur``; \
    reg [              63:0] dma_FPRegState_fpr_21``cur``; \
    reg [              63:0] dma_FPRegState_fpr_22``cur``; \
    reg [              63:0] dma_FPRegState_fpr_23``cur``; \
    reg [              63:0] dma_FPRegState_fpr_24``cur``; \
    reg [              63:0] dma_FPRegState_fpr_25``cur``; \
    reg [              63:0] dma_FPRegState_fpr_26``cur``; \
    reg [              63:0] dma_FPRegState_fpr_27``cur``; \
    reg [              63:0] dma_FPRegState_fpr_28``cur``; \
    reg [              63:0] dma_FPRegState_fpr_29``cur``; \
    reg [              63:0] dma_FPRegState_fpr_30``cur``; \
    reg [              63:0] dma_FPRegState_fpr_31``cur``; \
    reg [               7:0] dma_FPRegState_fccr``cur``; \
    reg [              31:0] dma_FPRegState_fcsr0``cur``; \
    always @(posedge clk)begin \
        dma_FPRegState_fpr_0``cur`` <= dma_FPRegState_fpr_0``pre``; \
        dma_FPRegState_fpr_1``cur`` <= dma_FPRegState_fpr_1``pre``; \
        dma_FPRegState_fpr_2``cur`` <= dma_FPRegState_fpr_2``pre``; \
        dma_FPRegState_fpr_3``cur`` <= dma_FPRegState_fpr_3``pre``; \
        dma_FPRegState_fpr_4``cur`` <= dma_FPRegState_fpr_4``pre``; \
        dma_FPRegState_fpr_5``cur`` <= dma_FPRegState_fpr_5``pre``; \
        dma_FPRegState_fpr_6``cur`` <= dma_FPRegState_fpr_6``pre``; \
        dma_FPRegState_fpr_7``cur`` <= dma_FPRegState_fpr_7``pre``; \
        dma_FPRegState_fpr_8``cur`` <= dma_FPRegState_fpr_8``pre``; \
        dma_FPRegState_fpr_9``cur`` <= dma_FPRegState_fpr_9``pre``; \
        dma_FPRegState_fpr_10``cur`` <= dma_FPRegState_fpr_10``pre``; \
        dma_FPRegState_fpr_11``cur`` <= dma_FPRegState_fpr_11``pre``; \
        dma_FPRegState_fpr_12``cur`` <= dma_FPRegState_fpr_12``pre``; \
        dma_FPRegState_fpr_13``cur`` <= dma_FPRegState_fpr_13``pre``; \
        dma_FPRegState_fpr_14``cur`` <= dma_FPRegState_fpr_14``pre``; \
        dma_FPRegState_fpr_15``cur`` <= dma_FPRegState_fpr_15``pre``; \
        dma_FPRegState_fpr_16``cur`` <= dma_FPRegState_fpr_16``pre``; \
        dma_FPRegState_fpr_17``cur`` <= dma_FPRegState_fpr_17``pre``; \
        dma_FPRegState_fpr_18``cur`` <= dma_FPRegState_fpr_18``pre``; \
        dma_FPRegState_fpr_19``cur`` <= dma_FPRegState_fpr_19``pre``; \
        dma_FPRegState_fpr_20``cur`` <= dma_FPRegState_fpr_20``pre``; \
        dma_FPRegState_fpr_21``cur`` <= dma_FPRegState_fpr_21``pre``; \
        dma_FPRegState_fpr_22``cur`` <= dma_FPRegState_fpr_22``pre``; \
        dma_FPRegState_fpr_23``cur`` <= dma_FPRegState_fpr_23``pre``; \
        dma_FPRegState_fpr_24``cur`` <= dma_FPRegState_fpr_24``pre``; \
        dma_FPRegState_fpr_25``cur`` <= dma_FPRegState_fpr_25``pre``; \
        dma_FPRegState_fpr_26``cur`` <= dma_FPRegState_fpr_26``pre``; \
        dma_FPRegState_fpr_27``cur`` <= dma_FPRegState_fpr_27``pre``; \
        dma_FPRegState_fpr_28``cur`` <= dma_FPRegState_fpr_28``pre``; \
        dma_FPRegState_fpr_29``cur`` <= dma_FPRegState_fpr_29``pre``; \
        dma_FPRegState_fpr_30``cur`` <= dma_FPRegState_fpr_30``pre``; \
        dma_FPRegState_fpr_31``cur`` <= dma_FPRegState_fpr_31``pre``; \
        dma_FPRegState_fccr``cur`` <= dma_FPRegState_fccr``pre``; \
        dma_FPRegState_fcsr0``cur`` <= dma_FPRegState_fcsr0``pre``; \
    end \
`endif



`define FPRegState_out \
`ifdef DIFF_HARDWARE \
    output [              63:0] dma_FPRegState_fpr_0, \
    output [              63:0] dma_FPRegState_fpr_1, \
    output [              63:0] dma_FPRegState_fpr_2, \
    output [              63:0] dma_FPRegState_fpr_3, \
    output [              63:0] dma_FPRegState_fpr_4, \
    output [              63:0] dma_FPRegState_fpr_5, \
    output [              63:0] dma_FPRegState_fpr_6, \
    output [              63:0] dma_FPRegState_fpr_7, \
    output [              63:0] dma_FPRegState_fpr_8, \
    output [              63:0] dma_FPRegState_fpr_9, \
    output [              63:0] dma_FPRegState_fpr_10, \
    output [              63:0] dma_FPRegState_fpr_11, \
    output [              63:0] dma_FPRegState_fpr_12, \
    output [              63:0] dma_FPRegState_fpr_13, \
    output [              63:0] dma_FPRegState_fpr_14, \
    output [              63:0] dma_FPRegState_fpr_15, \
    output [              63:0] dma_FPRegState_fpr_16, \
    output [              63:0] dma_FPRegState_fpr_17, \
    output [              63:0] dma_FPRegState_fpr_18, \
    output [              63:0] dma_FPRegState_fpr_19, \
    output [              63:0] dma_FPRegState_fpr_20, \
    output [              63:0] dma_FPRegState_fpr_21, \
    output [              63:0] dma_FPRegState_fpr_22, \
    output [              63:0] dma_FPRegState_fpr_23, \
    output [              63:0] dma_FPRegState_fpr_24, \
    output [              63:0] dma_FPRegState_fpr_25, \
    output [              63:0] dma_FPRegState_fpr_26, \
    output [              63:0] dma_FPRegState_fpr_27, \
    output [              63:0] dma_FPRegState_fpr_28, \
    output [              63:0] dma_FPRegState_fpr_29, \
    output [              63:0] dma_FPRegState_fpr_30, \
    output [              63:0] dma_FPRegState_fpr_31, \
    output [               7:0] dma_FPRegState_fccr, \
    output [              31:0] dma_FPRegState_fcsr0, \
`endif



`define FPRegState_in \
`ifdef DIFF_HARDWARE \
    input [              63:0] dma_FPRegState_fpr_0, \
    input [              63:0] dma_FPRegState_fpr_1, \
    input [              63:0] dma_FPRegState_fpr_2, \
    input [              63:0] dma_FPRegState_fpr_3, \
    input [              63:0] dma_FPRegState_fpr_4, \
    input [              63:0] dma_FPRegState_fpr_5, \
    input [              63:0] dma_FPRegState_fpr_6, \
    input [              63:0] dma_FPRegState_fpr_7, \
    input [              63:0] dma_FPRegState_fpr_8, \
    input [              63:0] dma_FPRegState_fpr_9, \
    input [              63:0] dma_FPRegState_fpr_10, \
    input [              63:0] dma_FPRegState_fpr_11, \
    input [              63:0] dma_FPRegState_fpr_12, \
    input [              63:0] dma_FPRegState_fpr_13, \
    input [              63:0] dma_FPRegState_fpr_14, \
    input [              63:0] dma_FPRegState_fpr_15, \
    input [              63:0] dma_FPRegState_fpr_16, \
    input [              63:0] dma_FPRegState_fpr_17, \
    input [              63:0] dma_FPRegState_fpr_18, \
    input [              63:0] dma_FPRegState_fpr_19, \
    input [              63:0] dma_FPRegState_fpr_20, \
    input [              63:0] dma_FPRegState_fpr_21, \
    input [              63:0] dma_FPRegState_fpr_22, \
    input [              63:0] dma_FPRegState_fpr_23, \
    input [              63:0] dma_FPRegState_fpr_24, \
    input [              63:0] dma_FPRegState_fpr_25, \
    input [              63:0] dma_FPRegState_fpr_26, \
    input [              63:0] dma_FPRegState_fpr_27, \
    input [              63:0] dma_FPRegState_fpr_28, \
    input [              63:0] dma_FPRegState_fpr_29, \
    input [              63:0] dma_FPRegState_fpr_30, \
    input [              63:0] dma_FPRegState_fpr_31, \
    input [               7:0] dma_FPRegState_fccr, \
    input [              31:0] dma_FPRegState_fcsr0, \
`endif



`define FPRegState_connect \
`ifdef DIFF_HARDWARE \
    .dma_FPRegState_fpr_0(dma_FPRegState_fpr_0), \
    .dma_FPRegState_fpr_1(dma_FPRegState_fpr_1), \
    .dma_FPRegState_fpr_2(dma_FPRegState_fpr_2), \
    .dma_FPRegState_fpr_3(dma_FPRegState_fpr_3), \
    .dma_FPRegState_fpr_4(dma_FPRegState_fpr_4), \
    .dma_FPRegState_fpr_5(dma_FPRegState_fpr_5), \
    .dma_FPRegState_fpr_6(dma_FPRegState_fpr_6), \
    .dma_FPRegState_fpr_7(dma_FPRegState_fpr_7), \
    .dma_FPRegState_fpr_8(dma_FPRegState_fpr_8), \
    .dma_FPRegState_fpr_9(dma_FPRegState_fpr_9), \
    .dma_FPRegState_fpr_10(dma_FPRegState_fpr_10), \
    .dma_FPRegState_fpr_11(dma_FPRegState_fpr_11), \
    .dma_FPRegState_fpr_12(dma_FPRegState_fpr_12), \
    .dma_FPRegState_fpr_13(dma_FPRegState_fpr_13), \
    .dma_FPRegState_fpr_14(dma_FPRegState_fpr_14), \
    .dma_FPRegState_fpr_15(dma_FPRegState_fpr_15), \
    .dma_FPRegState_fpr_16(dma_FPRegState_fpr_16), \
    .dma_FPRegState_fpr_17(dma_FPRegState_fpr_17), \
    .dma_FPRegState_fpr_18(dma_FPRegState_fpr_18), \
    .dma_FPRegState_fpr_19(dma_FPRegState_fpr_19), \
    .dma_FPRegState_fpr_20(dma_FPRegState_fpr_20), \
    .dma_FPRegState_fpr_21(dma_FPRegState_fpr_21), \
    .dma_FPRegState_fpr_22(dma_FPRegState_fpr_22), \
    .dma_FPRegState_fpr_23(dma_FPRegState_fpr_23), \
    .dma_FPRegState_fpr_24(dma_FPRegState_fpr_24), \
    .dma_FPRegState_fpr_25(dma_FPRegState_fpr_25), \
    .dma_FPRegState_fpr_26(dma_FPRegState_fpr_26), \
    .dma_FPRegState_fpr_27(dma_FPRegState_fpr_27), \
    .dma_FPRegState_fpr_28(dma_FPRegState_fpr_28), \
    .dma_FPRegState_fpr_29(dma_FPRegState_fpr_29), \
    .dma_FPRegState_fpr_30(dma_FPRegState_fpr_30), \
    .dma_FPRegState_fpr_31(dma_FPRegState_fpr_31), \
    .dma_FPRegState_fccr(dma_FPRegState_fccr), \
    .dma_FPRegState_fcsr0(dma_FPRegState_fcsr0), \
`endif



`define TLBEvent_wire(index) \
`ifdef DIFF_HARDWARE \
    wire  dma_TLBEvent_valid_``index``; \
    wire [8-1:0] dma_TLBEvent_source_``index``; \
    wire [64-1:0] dma_TLBEvent_vpn_``index``; \
    wire [64-1:0] dma_TLBEvent_ppn_``index``; \
    wire [32-1:0] dma_TLBEvent_exception_``index``; \
`endif



`define TLBEvent_reg(clk, index, cur, pre) \
`ifdef DIFF_HARDWARE \
    reg  dma_TLBEvent_valid_``index````cur``; \
    reg [8-1:0] dma_TLBEvent_source_``index````cur``; \
    reg [64-1:0] dma_TLBEvent_vpn_``index````cur``; \
    reg [64-1:0] dma_TLBEvent_ppn_``index````cur``; \
    reg [32-1:0] dma_TLBEvent_exception_``index````cur``; \
    always @(posedge clk) begin \
        dma_TLBEvent_valid_``index````cur`` <= dma_TLBEvent_valid_``index````pre``; \
        dma_TLBEvent_source_``index````cur`` <= dma_TLBEvent_source_``index````pre``; \
        dma_TLBEvent_vpn_``index````cur`` <= dma_TLBEvent_vpn_``index````pre``; \
        dma_TLBEvent_ppn_``index````cur`` <= dma_TLBEvent_ppn_``index````pre``; \
        dma_TLBEvent_exception_``index````cur`` <= dma_TLBEvent_exception_``index````pre``; \
    end \
`endif



`define TLBEvent_out(index) \
`ifdef DIFF_HARDWARE \
    output  dma_TLBEvent_valid_``index``, \
    output [8-1:0] dma_TLBEvent_source_``index``, \
    output [64-1:0] dma_TLBEvent_vpn_``index``, \
    output [64-1:0] dma_TLBEvent_ppn_``index``, \
    output [32-1:0] dma_TLBEvent_exception_``index``, \
`endif



`define TLBEvent_in(index) \
`ifdef DIFF_HARDWARE \
    input  dma_TLBEvent_valid_``index``, \
    input [8-1:0] dma_TLBEvent_source_``index``, \
    input [64-1:0] dma_TLBEvent_vpn_``index``, \
    input [64-1:0] dma_TLBEvent_ppn_``index``, \
    input [32-1:0] dma_TLBEvent_exception_``index``, \
`endif

`define TLBEvent_connect(index) \
`ifdef DIFF_HARDWARE \
    .dma_TLBEvent_valid_``index``(dma_TLBEvent_valid_``index``), \
    .dma_TLBEvent_source_``index``(dma_TLBEvent_source_``index``), \
    .dma_TLBEvent_vpn_``index``(dma_TLBEvent_vpn_``index``), \
    .dma_TLBEvent_ppn_``index``(dma_TLBEvent_ppn_``index``), \
    .dma_TLBEvent_exception_``index``(dma_TLBEvent_exception_``index``), \
`endif


