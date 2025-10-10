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
module aq_ifu_ctrl (
  // &Ports, @24
  input    wire       cp0_ifu_in_lpmd,
  input    wire       cp0_ifu_lpmd_req,
  input    wire       ibuf_ctrl_inst_fetch,
  input    wire       icache_ctrl_stall,
  input    wire       icache_ctrl_inv_fsm_idle,
  input    wire       idu_ifu_id_stall,
  input    wire       pcgen_ctrl_chgflw_vld,
  input    wire       pred_ctrl_stall,
  input    wire       rtu_ifu_dbg_mask,
  input    wire       rtu_ifu_flush_fe,
  input    wire       vec_ctrl_reset_mask,
  output   wire       ctrl_btb_chgflw_vld,
  output   wire       ctrl_btb_inst_fetch,
  output   wire       ctrl_btb_stall,
  output   wire       ctrl_ibuf_pop_en,
  output   wire       ctrl_icache_abort,
  output   wire       ctrl_icache_req_vld,
  output   wire       ctrl_ipack_cancel
); 



// &Regs; @25
// &Wires; @26
wire         ctrl_if_cancel;       
wire         ctrl_if_stall;        
wire         ctrl_inst_fetch;      


//==========================================================
// IFU Control Module
// 1. Inst Fetch Requet Valid Signal
// 2. Inst Fetch Stage Stall Signal
// 3. Flush Signal for IFU modules
//==========================================================

//------------------------------------------------
// 1. Inst Fetch Requet Valid Signal
// a. Fetch inst when chgflw or I-buf fetch  
// b. Not fetch when lpmd or debug on
//------------------------------------------------
assign ctrl_inst_fetch = ibuf_ctrl_inst_fetch 
                      && !(cp0_ifu_in_lpmd || cp0_ifu_lpmd_req)
                      && icache_ctrl_inv_fsm_idle
                      && !rtu_ifu_dbg_mask
                      && !vec_ctrl_reset_mask;

//------------------------------------------------
// 2. Inst Fetch Stage Stall Signal
//------------------------------------------------
assign ctrl_if_stall = pred_ctrl_stall || icache_ctrl_stall;

//------------------------------------------------
// 3. Flush Signal for IFU modules
//------------------------------------------------
assign ctrl_if_cancel = rtu_ifu_flush_fe || pcgen_ctrl_chgflw_vld;

//==========================================================
// Rename for Output
//==========================================================

// Output to I-Buf
assign ctrl_ibuf_pop_en     = !idu_ifu_id_stall;
//assign ctrl_ibuf_chgflw_vld = ctrl_if_cancel;

// Output to ICache
assign ctrl_icache_req_vld  = ctrl_inst_fetch;
assign ctrl_icache_abort    = ctrl_if_cancel;

// Output to IPack
assign ctrl_ipack_cancel    = ctrl_if_cancel;

// Output to pcgen
//assign ctrl_pcgen_stall     = ctrl_if_stall;

// Output to BTB
assign ctrl_btb_stall       = ctrl_if_stall;
assign ctrl_btb_inst_fetch  = ctrl_inst_fetch;
assign ctrl_btb_chgflw_vld  = ctrl_if_cancel;

// &ModuleEnd; @78
endmodule


