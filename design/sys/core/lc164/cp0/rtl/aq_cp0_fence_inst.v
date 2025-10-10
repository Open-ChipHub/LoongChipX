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

// &ModuleBeg; @23
module aq_cp0_fence_inst (
  // &Ports, @25
  input    wire         cpurst_b,
  input    wire         fence_clk,
  input    wire         iui_special_fence,
  input    wire         iui_special_fencei,
  input    wire         iui_special_rs1_x0,
  input    wire         iui_special_rs2_x0,
  input    wire         iui_special_sfence,
  input    wire         iui_special_sync,
  input    wire         iui_special_synci,
  input    wire         lsu_cp0_fence_ack,
  input    wire         lsu_cp0_sync_ack,
  input    wire         special_dcacheop_req,
  input    wire         special_icacheop_req,
  input    wire         special_op_done,
  output   wire         fence_clk_en,
  output   wire  [2:0]  fence_top_cur_state,
  output   wire         sfence_clr_asid_all,
  output   wire         sfence_clr_va_all,
  output   wire         sfence_clr_va_asid,
  output   wire         special_fence_dcache_req,
  output   wire         special_fence_icache_req,
  output   wire         special_fence_mmu_req,
  output   wire         special_fence_stall,
  output   wire         special_inst_fence_req,
  output   wire         special_inst_sync_req
); 



// &Regs; @26
reg     [2:0]  fence_cur_state;         
reg     [2:0]  fence_next_state;        

// &Wires; @27
wire           fence_inst_vld;          
wire           special_dcache_op;       
wire           special_icache_inv;      
wire           special_mmu_clean;       
wire           special_sm_fence;        
wire           mmu_tlb_clr_va_all;
wire           mmu_tlb_clr_asid_all;
wire           mmu_tlb_clr_va_asid;


assign fence_inst_vld = iui_special_fencei
                     // || iui_special_fence
                     || iui_special_sfence
                     || iui_special_sync
                     || iui_special_synci
                     || special_dcacheop_req
                     || special_icacheop_req;

parameter FNC_IDLE  = 3'b000;
parameter FNC_FENC  = 3'b001;
parameter FNC_CDCA  = 3'b010;
parameter FNC_CMMU  = 3'b011;
parameter FNC_IICA  = 3'b100;
parameter FNC_CMPLT = 3'b101;

always @ (posedge fence_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    fence_cur_state[2:0] <= 3'b0;
  else
    fence_cur_state[2:0] <= fence_next_state[2:0];
end

// &CombBeg; @52
always @( fence_inst_vld
       or iui_special_fencei
       or fence_cur_state
       or special_dcacheop_req
       or special_op_done
       or iui_special_sync
       or lsu_cp0_fence_ack
       or special_icacheop_req
       or iui_special_sfence
       or lsu_cp0_sync_ack
       or iui_special_synci)
begin
case(fence_cur_state)
  FNC_IDLE:
    if (fence_inst_vld)
      if (special_icacheop_req)
        fence_next_state = FNC_IICA;
      else if (special_dcacheop_req || iui_special_fencei)
        fence_next_state = FNC_CDCA;
      else if (iui_special_sfence)
        fence_next_state = FNC_CMMU;
      else
        fence_next_state = FNC_FENC; // synci, sync, fence
    else
      fence_next_state = FNC_IDLE;
  FNC_FENC:
    if (iui_special_sync || iui_special_synci)
      if (lsu_cp0_sync_ack)
        fence_next_state = FNC_CMPLT;
      else
        fence_next_state = FNC_FENC;
    else
      if (lsu_cp0_fence_ack)
        fence_next_state = FNC_CMPLT;
      else
        fence_next_state = FNC_FENC;
  FNC_CDCA:
    if (special_op_done)
      if (special_dcacheop_req)
        fence_next_state = FNC_CMPLT;
      else
        fence_next_state = FNC_IICA;
    else
      fence_next_state = FNC_CDCA;
  FNC_CMMU:
    if (special_op_done)
      fence_next_state = FNC_IICA;
    else
      fence_next_state = FNC_CMMU;
  FNC_IICA:
    if (special_op_done)
      fence_next_state = FNC_CMPLT;
    else
      fence_next_state = FNC_IICA;
  FNC_CMPLT:
    fence_next_state = FNC_IDLE;
  default:
    fence_next_state = FNC_IDLE;
endcase
// &CombEnd; @100
end

assign special_sm_fence   = fence_cur_state == FNC_FENC;
assign special_dcache_op  = fence_cur_state == FNC_CDCA;
assign special_mmu_clean  = fence_cur_state == FNC_CMMU;
assign special_icache_inv = fence_cur_state == FNC_IICA;

assign special_fence_stall = fence_cur_state == FNC_IDLE && fence_inst_vld
                          || special_sm_fence
                          || special_dcache_op
                          || special_mmu_clean
                          || special_icache_inv
                          || iui_special_fence && !lsu_cp0_fence_ack;

assign special_inst_sync_req = (iui_special_sync
                             || iui_special_synci)
                             && special_sm_fence;
// &Force("output", "special_inst_sync_req"); @117
assign special_inst_fence_req = fence_inst_vld
                             && special_sm_fence
                             && !special_inst_sync_req
                             || iui_special_fence;

assign fence_clk_en = fence_cur_state != FNC_IDLE
                   || fence_inst_vld
                   || iui_special_fence; // For hpcp flop.

//==========================================================
//                          SFENCE
//==========================================================
// assign sfence_clr_va_all   = !iui_special_rs1_x0 &&  iui_special_rs2_x0 && special_mmu_clean;
// assign sfence_clr_asid_all =  iui_special_rs1_x0 && !iui_special_rs2_x0 && special_mmu_clean;
// assign sfence_clr_va_asid  = !iui_special_rs1_x0 && !iui_special_rs2_x0 && special_mmu_clean;

// TODO: FIXME
// mmu_tlb_clr_va_all   : clear all match va entry
// mmu_tlb_clr_asid_all : clear all match asid entry
// mmu_tlb_clr_va_asid  : clear all match asid && va entry 
// If all are not valid, clear all entry

assign mmu_tlb_clr_va_all   = 1'b0;
assign mmu_tlb_clr_va_asid  = 1'b0;
assign mmu_tlb_clr_asid_all = 1'b0;

assign sfence_clr_va_all    = mmu_tlb_clr_va_all && special_mmu_clean;
assign sfence_clr_asid_all  = mmu_tlb_clr_asid_all && special_mmu_clean;
assign sfence_clr_va_asid   = mmu_tlb_clr_va_asid && special_mmu_clean;


//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For CP0
//----------------------------------------------------------
assign special_fence_icache_req = special_icache_inv;
assign special_fence_dcache_req = special_dcache_op;
assign special_fence_mmu_req    = special_mmu_clean;

assign fence_top_cur_state[2:0] = fence_cur_state[2:0];


// &ModuleEnd; @157
endmodule



