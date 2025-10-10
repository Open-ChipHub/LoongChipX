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

// &Depend("aq_dtu_cfig.h"); @23
// &ModuleBeg; @24
module aq_ifu_pred (
  // &Ports, @25
  input    wire  [63:0]  btb_pred_tar_pc,
  input    wire          btb_pred_tar_vld,
  input    wire          cp0_ifu_bht_en,
  input    wire          cp0_ifu_bht_inv,
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_ifu_ras_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [21:0]  dtu_ifu_halt_info0,
  input    wire  [21:0]  dtu_ifu_halt_info1,
  input    wire          forever_cpuclk,
  input    wire          ibuf_ipack_stall,
  input    wire          ibuf_pred_hungry,
  input    wire          ibuf_pred_stall,
  input    wire          icache_pred_inst_vld,
  input    wire          icache_pred_inst_vld_gate,
  input    wire  [31:0]  ipack_pred_inst0,
  input    wire          ipack_pred_inst0_expt,
  input    wire          ipack_pred_inst0_vld,
  input    wire  [63:0]  iu_ifu_bht_cur_pc,
  input    wire          iu_ifu_bht_mispred,
  input    wire          iu_ifu_bht_mispred_gate,
  input    wire  [1 :0]  iu_ifu_bht_pred,
  input    wire          iu_ifu_bht_taken,
  input    wire          iu_ifu_br_vld,
  input    wire          iu_ifu_br_vld_gate,
  input    wire          iu_ifu_link_vld,
  input    wire          iu_ifu_link_vld_gate,
  input    wire          iu_ifu_pc_mispred,
  input    wire          iu_ifu_pc_mispred_gate,
  input    wire          iu_ifu_ret_vld,
  input    wire          iu_ifu_ret_vld_gate,
  input    wire          pad_yy_icg_scan_en,
  input    wire          pcgen_pred_flush_vld,
  input    wire  [63:0]  pcgen_pred_ifpc,
  input    wire          rtu_ifu_flush_fe,
  output   wire  [1 :0]  bht_top_cur_st,
  output   wire          ifu_cp0_bht_inv_done,
  output   wire          ifu_dtu_addr_vld0,
  output   wire          ifu_dtu_addr_vld1,
  output   wire          ifu_dtu_data_vld0,
  output   wire          ifu_dtu_data_vld1,
  output   wire  [63:0]  ifu_dtu_exe_addr0,
  output   wire  [63:0]  ifu_dtu_exe_addr1,
  output   wire  [31:0]  ifu_dtu_exe_data0,
  output   wire  [31:0]  ifu_dtu_exe_data1,
  output   wire  [63:0]  ifu_iu_ex1_pc_pred,
  output   wire          pred_btb_chgflw_vld,
  output   wire  [63:0]  pred_btb_cur_pc,
  output   wire          pred_btb_inst_vld,
  output   wire          pred_btb_mis_pred,
  output   wire          pred_btb_mis_predg,
  output   wire          pred_btb_stall,
  output   wire  [63:0]  pred_btb_tar_pc,
  output   wire          pred_btb_upd_vld,
  output   wire          pred_btb_upd_vldg,
  output   wire          pred_ctrl_stall,
  output   wire  [1 :0]  pred_ibuf_br_taken0,
  output   wire          pred_ibuf_chgflw_vld0,
  output   wire  [21:0]  pred_ibuf_halt_info0,
  output   wire  [21:0]  pred_ibuf_halt_info1,
  output   wire          pred_ipack_chgflw_vld0,
  output   wire          pred_ipack_delay_stall,
  output   wire          pred_ipack_mask,
  output   wire          pred_ipack_ret_stall,
  output   wire  [63:0]  pred_pcgen_chgflw_pc,
  output   wire          pred_pcgen_chgflw_vld,
  output   wire          pred_pcgen_chgflw_vld_gate,
  output   wire  [63:0]  pred_pcgen_curflw_pc,
  output   wire          pred_pcgen_curflw_vld,
  output   wire          pred_pcgen_curflw_vld_gate,
  output   wire          pred_top_delay_chgflw,
  output   wire          pred_top_ras_st
); 



// &Regs; @26
reg     [63:0]  chgflw_pc_ff;              
reg             delay_chgflw;              
reg             h0_br_vld;                 
reg     [63:0]  pred_h0_pc;                
reg     [63:0]  pred_idpc;                 
reg             ras_cur_st;                
reg             ras_nxt_st;                
reg     [63:0]  ras_pred_pc;               

// &Wires; @27
wire            bht_pred_mem_taken;        
wire    [1 :0]  bht_pred_rslt;             
wire            btb_mis_pred;              
wire    [63:0]  delay_tar;                 
wire            id_ras_clk;                
wire            id_ras_icg_en;             
wire            idpc_icg_en;               
wire            pred_bht_br_vld;           
wire    [2 :0]  pred_bht_pc;               
wire    [39:0]  pred_br_imm;               
wire    [1 :0]  pred_br_rslt0;             
wire    [1 :0]  pred_br_rslt1;             
wire            pred_br_taken;             
wire            pred_br_taken0;            
wire            pred_br_taken1;            
wire    [63:0]  pred_br_tar;               
wire            pred_br_vld0;              
wire            pred_chgflw;               
wire            pred_chgflw_fin;           
wire    [63:0]  pred_chgflw_fin_tar;       
wire            pred_chgflw_vld0;          
wire            pred_clk;                  
wire            pred_curflw;               
wire            pred_delay_br;             
wire            pred_delay_br1_taken;      
wire            pred_delay_br_raw;         
wire            pred_delay_reissue;        
wire            pred_delay_taken;          
wire            pred_icg_en;               
wire            pred_id_stall;             
wire            pred_idpc_clk;             
wire    [39:0]  pred_imm0;                 
wire    [39:0]  pred_imm1;                 
wire            pred_inst0_32;             
wire            pred_inst0_bjtype;         
wire    [63:0]  pred_inst0_bkpt_pc;        
wire            pred_inst0_taken;          
wire            pred_jmp_vld0;             
wire            pred_link_vld0;            
wire    [63:0]  pred_nxt_offset;           
wire    [63:0]  pred_nxt_pc;               
wire    [23:0]  pred_ras_link_pc;          
wire            pred_ras_link_vld;         
wire            pred_ras_link_vld0;        
wire            pred_ras_ret_chgflw;       
wire            pred_ras_ret_vld;          
wire            pred_ras_ret_vld0;         
wire    [63:0]  pred_ras_tar;              
wire            pred_ret_stall;            
wire            pred_ret_vld0;             
wire    [63:0]  pred_tar;                  
wire            ras_cur_idle;              
wire    [23:0]  ras_link_offset;           
wire    [23:0]  ras_pred_tar_pc;           
wire    [63:0]  pred_cur_pc;               

//==========================================================
// ID Stage Predication Module
// 1. Instance ICG Cell
// 2. ID Pre-decode for prediction
// 3. Current PC Generation
// 4. Branch Taken Result
// 5. RAS Target Result
// 6. ID Prediction Address Generation
// 7. Inst bkpt judgement
//==========================================================

//------------------------------------------------
// 1. Instance ICG Cell
//------------------------------------------------
assign pred_icg_en = h0_br_vld || pred_br_vld0 || delay_chgflw;

// &Instance("gated_clk_cell", "x_aq_ifu_pred_icg_cell"); @46
gated_clk_cell  x_aq_ifu_pred_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pred_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (pred_icg_en       ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @47
//          .external_en (1'b0), @48
//          .global_en   (cp0_yy_clk_en), @49
//          .module_en   (cp0_ifu_icg_en), @50
//          .local_en    (pred_icg_en), @51
//          .clk_out     (pred_clk)  @52
// ); @53

assign id_ras_icg_en = pred_ras_ret_vld
                    || !ras_cur_idle;
// &Instance("gated_clk_cell", "x_aq_ifu_id_ras_icg_cell"); @57
gated_clk_cell  x_aq_ifu_id_ras_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (id_ras_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (id_ras_icg_en     ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @58
//          .external_en (1'b0), @59
//          .global_en   (cp0_yy_clk_en), @60
//          .module_en   (cp0_ifu_icg_en), @61
//          .local_en    (id_ras_icg_en), @62
//          .clk_out     (id_ras_clk)  @63
// ); @64

assign idpc_icg_en = icache_pred_inst_vld_gate || pred_delay_br_raw;
// &Instance("gated_clk_cell", "x_ifu_pred_idpc_icg_cell"); @67
gated_clk_cell  x_ifu_pred_idpc_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pred_idpc_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (idpc_icg_en       ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @68
//          .external_en (1'b0), @69
//          .global_en   (cp0_yy_clk_en), @70
//          .module_en   (cp0_ifu_icg_en), @71
//          .local_en    (idpc_icg_en), @72
//          .clk_out     (pred_idpc_clk) @73
//        ); @74
//------------------------------------------------
// 2. ID Pre-decode for prediction
//------------------------------------------------
// &Instance("aq_ifu_pre_decd", "x_aq_ifu_pre_decd"); @78
aq_ifu_pre_decd  x_aq_ifu_pre_decd (
  .ipack_pred_inst0     (ipack_pred_inst0    ),
  .ipack_pred_inst0_vld (ipack_pred_inst0_vld),
  .pred_br_vld0         (pred_br_vld0        ),
  .pred_imm0            (pred_imm0           ),
  .pred_inst0_32        (pred_inst0_32       ),
  .pred_jmp_vld0        (pred_jmp_vld0       ),
  .pred_link_vld0       (pred_link_vld0      ),
  .pred_ret_vld0        (pred_ret_vld0       )
);


//------------------------------------------------
// 3. Current PC Generation
//------------------------------------------------
always @ (posedge pred_idpc_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pred_idpc[63:0] <= 40'b0;
  else if(icache_pred_inst_vld && !pred_id_stall)
    pred_idpc[63:0] <= pcgen_pred_ifpc[63:0];
  else if(pred_delay_br)
    pred_idpc[63:0] <= {pred_idpc[39:2], 2'b10};
  else
    pred_idpc[63:0] <= pred_idpc[63:0];
end

assign pred_cur_pc[63:0] = pred_idpc[63:0];

assign pred_nxt_offset[63:0] = 64'h4;
assign pred_nxt_pc[63:0]     = pred_cur_pc[63:0] + pred_nxt_offset[63:0];

//------------------------------------------------
// 4. Branch Taken Result
// a. BHT Access Signal
// b. Instance BHT
// c. BHT Result
//------------------------------------------------
// a. BHT Access Signal
assign pred_bht_br_vld   = pred_br_vld0 && !ibuf_ipack_stall;


assign pred_bht_pc[2:0]  =  !pred_br_vld0 ? {pred_idpc[3:2], 1'b1}
                            : pred_idpc[3:1];
                           
//assign pred_bht_mem_pc[2:0] = {pred_idpc[3:2], 1'b1};

// b. Instance BHT
// &Instance("aq_ifu_bht", "x_aq_ifu_bht"); @151
aq_ifu_bht  x_aq_ifu_bht (
  .bht_pred_mem_taken      (bht_pred_mem_taken     ),
  .bht_pred_rslt           (bht_pred_rslt          ),
  .bht_top_cur_st          (bht_top_cur_st         ),
  .cp0_ifu_bht_en          (cp0_ifu_bht_en         ),
  .cp0_ifu_bht_inv         (cp0_ifu_bht_inv        ),
  .cp0_ifu_icg_en          (cp0_ifu_icg_en         ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ifu_cp0_bht_inv_done    (ifu_cp0_bht_inv_done   ),
  .iu_ifu_bht_cur_pc       (iu_ifu_bht_cur_pc      ),
  .iu_ifu_bht_mispred      (iu_ifu_bht_mispred     ),
  .iu_ifu_bht_mispred_gate (iu_ifu_bht_mispred_gate),
  .iu_ifu_bht_pred         (iu_ifu_bht_pred        ),
  .iu_ifu_bht_taken        (iu_ifu_bht_taken       ),
  .iu_ifu_br_vld           (iu_ifu_br_vld          ),
  .iu_ifu_br_vld_gate      (iu_ifu_br_vld_gate     ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pred_bht_br_vld         (pred_bht_br_vld        ),
  .pred_bht_pc             (pred_bht_pc            )
);


assign pred_delay_br_raw = 1'b0 ;
assign pred_delay_br = 1'b0;
assign pred_delay_br1_taken = 1'b0;
assign pred_delay_reissue = 1'b0;
assign pred_delay_taken = pred_delay_br1_taken || pred_delay_reissue;

assign delay_tar[63:0] = pred_delay_br1_taken
                       ? pred_br_tar[63:0]
                       : pred_nxt_pc[63:0];

always @ (posedge pred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    delay_chgflw <= 1'b0;
  else if(pcgen_pred_flush_vld)
    delay_chgflw <= 1'b0;
  else if(pred_delay_taken)
    delay_chgflw <= 1'b1;
  else if(delay_chgflw && !ibuf_ipack_stall)
    delay_chgflw <= 1'b0;
  else
    delay_chgflw <= delay_chgflw;
end
always @ (posedge pred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    chgflw_pc_ff[63:0] <= 64'b0;
  else if(pred_delay_br)
    chgflw_pc_ff[63:0] <= delay_tar[63:0];
end

// c. BHT Result
// all branch and jump taken result
assign pred_inst0_bjtype = pred_br_vld0 || pred_jmp_vld0;
assign pred_inst0_taken  = pred_br_vld0 && bht_pred_rslt[1]
                           || pred_jmp_vld0;
assign pred_br_taken0    = pred_inst0_taken && !delay_chgflw;
assign pred_br_taken     = pred_br_taken0;

assign pred_br_imm[39:0]  = pred_inst0_taken ? pred_imm0[39:0]
                                              : 40'b0;
assign pred_br_tar[63:0]  = pred_cur_pc[63:0] + {{24{pred_br_imm[39]}}, pred_br_imm[39:0]};
assign pred_br_rslt0[1:0] = {2{pred_br_vld0}} & bht_pred_rslt[1:0];

//------------------------------------------------
// 5. RAS Target Result
// a. RAS Access Signal
// b. Instance RAS
// c. RAS Result
// d. RAS Stall FSM
//------------------------------------------------

// a. RAS Access Signal
assign pred_ras_link_vld0 = pred_link_vld0;
assign pred_ras_link_vld  = pred_ras_link_vld0
                            && cp0_ifu_ras_en
                            && !ibuf_ipack_stall;

assign pred_ras_ret_vld0  = pred_ret_vld0 && !delay_chgflw;
assign pred_ras_ret_chgflw = pred_ras_ret_vld0;

assign pred_ras_ret_vld = pred_ras_ret_chgflw && !ibuf_ipack_stall;

assign ras_link_offset[23:0] = pred_ras_link_vld0 && pred_inst0_32 
                             ? 24'h4 : 24'h2;

assign pred_ras_link_pc[23:0] = pred_cur_pc[23:0] + ras_link_offset[23:0];

// b. Instance RAS
// &Instance("aq_ifu_ras", "x_aq_ifu_ras"); @238
aq_ifu_ras  x_aq_ifu_ras (
  .cp0_ifu_icg_en          (cp0_ifu_icg_en         ),
  .cp0_yy_clk_en           (cp0_yy_clk_en          ),
  .cpurst_b                (cpurst_b               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .iu_ifu_bht_mispred      (iu_ifu_bht_mispred     ),
  .iu_ifu_bht_mispred_gate (iu_ifu_bht_mispred_gate),
  .iu_ifu_link_vld         (iu_ifu_link_vld        ),
  .iu_ifu_link_vld_gate    (iu_ifu_link_vld_gate   ),
  .iu_ifu_pc_mispred       (iu_ifu_pc_mispred      ),
  .iu_ifu_pc_mispred_gate  (iu_ifu_pc_mispred_gate ),
  .iu_ifu_ret_vld          (iu_ifu_ret_vld         ),
  .iu_ifu_ret_vld_gate     (iu_ifu_ret_vld_gate    ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .pred_ras_link_pc        (pred_ras_link_pc       ),
  .pred_ras_link_vld       (pred_ras_link_vld      ),
  .pred_ras_ret_vld        (pred_ras_ret_vld       ),
  .ras_cur_st              (ras_cur_st             ),
  .ras_pred_tar_pc         (ras_pred_tar_pc        ),
  .rtu_ifu_flush_fe        (rtu_ifu_flush_fe       )
);


// c. RAS Result
assign pred_ras_tar[63:0] = cp0_ifu_ras_en ? {pred_idpc[63:24], ras_pred_tar_pc[23:0]}
                                            : pred_idpc[63:0];

// d. RAS Stall FSM
parameter RAS_IDLE = 1'b0;
parameter RAS_WAIT = 1'b1;

always @ (posedge id_ras_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ras_cur_st <= RAS_IDLE;
  else if(pcgen_pred_flush_vld || rtu_ifu_flush_fe)
    ras_cur_st <= RAS_IDLE;
  else
    ras_cur_st <= ras_nxt_st;
end

// &CombBeg; @258
always @( iu_ifu_ret_vld
       or pred_ras_ret_vld
       or ras_cur_st)
begin
case(ras_cur_st)
  RAS_IDLE:
    if(pred_ras_ret_vld)
      ras_nxt_st = RAS_WAIT;
    else
      ras_nxt_st = RAS_IDLE;
  RAS_WAIT:
    if(iu_ifu_ret_vld)
      ras_nxt_st = RAS_IDLE;
    else
      ras_nxt_st = RAS_WAIT;
  default:
      ras_nxt_st = RAS_IDLE;
endcase
// &CombEnd; @273
end

assign ras_cur_idle   = ras_cur_st == RAS_IDLE;
assign pred_ret_stall = ras_cur_st == RAS_WAIT && pred_ras_ret_vld;

always @ (posedge id_ras_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ras_pred_pc[63:0] <= 64'b0;
  else if(pred_ras_ret_vld && ras_cur_st == RAS_IDLE)
    ras_pred_pc[63:0] <= pred_ras_tar[63:0];
  else
    ras_pred_pc[63:0] <= ras_pred_pc[63:0];
end

//------------------------------------------------
// 6. ID Prediction Address Generation
// a. ID Prediction Change Flow
// b. IF Miss-Prediction Judgement
//------------------------------------------------
assign pred_chgflw_vld0 = pred_br_taken0 || pred_ras_ret_vld0;
//assign pred_chgflw_vld1 = pred_br_taken1 || pred_ras_ret_req1;
//assign pred_chgflw_vld  = pred_chgflw_vld0 || pred_chgflw_vld1;
//assign pred_chgflw_tar[63:0] = pred_ras_ret_req ? pred_ras_tar[63:0]
//                                                : pred_br_tar[63:0];

// b. IF Miss-Prediction Judgement
assign btb_mis_pred = (pred_br_tar[63:0] 
                    != btb_pred_tar_pc[63:0]
                    || !pred_br_taken) && btb_pred_tar_vld
                      && ipack_pred_inst0_vld;

assign pred_chgflw  = btb_pred_tar_vld ? btb_mis_pred
                                       : pred_br_taken;
assign pred_tar[63:0] = pred_br_taken
                      ? pred_br_tar[63:0]
                      : pred_nxt_pc[63:0];

//assign pred_chgflw_fin   = pred_ras_ret_chgflw || pred_chgflw;
assign pred_chgflw_fin   = pred_chgflw && !pred_curflw;

assign pred_chgflw_fin_tar[63:0] = pred_tar[63:0];

// chgflw in cur cycle
assign pred_curflw           = pred_ras_ret_chgflw
                            || delay_chgflw;// && !ibuf_pred_stall;

assign pred_id_stall     = pred_ret_stall || pred_delay_br || ibuf_pred_stall;

//------------------------------------------------
// 7. Inst bkpt judgement
//------------------------------------------------
assign pred_inst0_bkpt_pc[63:0] = pred_idpc[63:0];

assign ifu_dtu_addr_vld0  = ipack_pred_inst0_vld;
assign ifu_dtu_data_vld0  = ipack_pred_inst0_vld && !ipack_pred_inst0_expt;
assign ifu_dtu_exe_addr0[63:0] = pred_inst0_bkpt_pc[63:0];
assign ifu_dtu_exe_data0[31:0] = ipack_pred_inst0[31:0];

// FIXME: TODO
assign ifu_dtu_addr_vld1  = 1'b0;
assign ifu_dtu_data_vld1  = 1'b0;
assign ifu_dtu_exe_addr1[63:0] = 64'b0;
assign ifu_dtu_exe_data1[31:0] = 32'b0;


//==========================================================
// Rename for Output
//==========================================================

// Output to Ctrl
assign pred_ctrl_stall = pred_id_stall;

// Output to pcgen
assign pred_pcgen_chgflw_vld      = pred_chgflw_fin;
assign pred_pcgen_chgflw_vld_gate = btb_pred_tar_vld
                                 || pred_inst0_bjtype;
assign pred_pcgen_chgflw_pc[63:0] = pred_chgflw_fin_tar[63:0];
assign pred_pcgen_curflw_vld      = pred_curflw;
assign pred_pcgen_curflw_vld_gate = delay_chgflw || pred_ret_vld0;
assign pred_pcgen_curflw_pc[63:0] = pred_ras_ret_chgflw ? pred_ras_tar[63:0]
                                                        : chgflw_pc_ff[63:0];

// Output to ipack
assign pred_ipack_chgflw_vld0 = pred_chgflw_vld0; 
assign pred_ipack_ret_stall   = pred_ret_stall;
assign pred_ipack_delay_stall = 1'b0;
assign pred_ipack_mask        = 1'b0;

// Output to ibuf
assign pred_ibuf_chgflw_vld0     = pred_chgflw_vld0;
assign pred_ibuf_br_taken0[1:0]  = pred_br_rslt0[1:0];
assign pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0] = dtu_ifu_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0] = dtu_ifu_halt_info1[`TDT_HINFO_WIDTH-1:0];


// Output to btb
assign pred_btb_chgflw_vld   = pred_chgflw_fin;
assign pred_btb_upd_vld      = pred_br_taken && !btb_mis_pred 
                               && ibuf_pred_hungry;
assign pred_btb_upd_vldg     = pred_br_taken  
                               && ibuf_pred_hungry;
assign pred_btb_mis_pred     = btb_mis_pred;
assign pred_btb_mis_predg    = btb_pred_tar_vld
                             && ipack_pred_inst0_vld;
assign pred_btb_inst_vld     = ipack_pred_inst0_vld;
assign pred_btb_cur_pc[63:0] = {pred_idpc[63:2], 2'b0};
assign pred_btb_tar_pc[63:0] = pred_br_tar[63:0];
assign pred_btb_stall        = pred_id_stall;

// Output to top
assign pred_top_delay_chgflw = delay_chgflw;
assign pred_top_ras_st       = ras_cur_st;

// Output to IU
assign ifu_iu_ex1_pc_pred[63:0] = ras_pred_pc[63:0];


// &ModuleEnd; @406
endmodule


