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
module aq_fdsu_scalar_ctrl (
  // &Ports, @24
  input    wire         bhalf0_ex1_op0_id_vld,
  input    wire         bhalf0_ex1_op1_id_vld,
  input    wire         cp0_vpu_icg_en,
  input    wire         cp0_yy_clk_en,
  input    wire         cpurst_b,
  input    wire         double0_ex1_op0_id_vld,
  input    wire         double0_ex1_op1_id_vld,
  input    wire         double_pipe0_ex1_srt_skip,
  input    wire         double_pipe0_ex2_of,
  input    wire         double_pipe0_ex2_uf_srt_skip,
  input    wire         double_pipe0_srt_remainder_zero,
  input    wire         dp_ctrl_ex1_bhalf,
  input    wire         dp_ctrl_ex1_div,
  input    wire         dp_ctrl_ex1_double,
  input    wire         dp_ctrl_ex1_half,
  input    wire         dp_ctrl_ex1_single,
  input    wire         ex1_bhalf,
  input    wire         ex1_double,
  input    wire         ex1_half,
  input    wire         ex1_single,
  input    wire         forever_cpuclk,
  input    wire         half0_ex1_op0_id_vld,
  input    wire         half0_ex1_op1_id_vld,
  input    wire         ifu_vpu_warm_up,
  input    wire         pad_yy_icg_scan_en,
  input    wire         rbus_vfdsu_fpr_wb_grnt,
  input    wire         rtu_yy_xx_async_flush,
  input    wire         rtu_yy_xx_flush,
  input    wire         single0_ex1_op0_id_vld,
  input    wire         single0_ex1_op1_id_vld,
  input    wire         vpu_vfdsu_ex1_sel,
  output   wire         bhalf0_ex1_op1_sel,
  output   wire         ctrl_dp_ex1_save_op0,
  output   wire         ctrl_dp_ex1_save_op0_gate,
  output   wire         double0_ex1_op1_sel,
  output   wire         double_pipe0_ex1_ff1_sel_op1,
  output   wire         double_pipe0_ex1_op1_sel,
  output   wire         double_pipe0_ex1_save_op0,
  output   wire         double_pipe0_save_op0_neg_expnt,
  output   wire         ex1_pipe_clk,
  output   wire         ex1_pipedown,
  output   wire         ex1_pipedown_gate,
  output   wire         ex1_save_ff1_op1_id,
  output   wire         ex2_pipe_clk,
  output   wire         ex2_pipedown,
  output   reg          ex2_srt_first_round,
  output   wire         ex3_pipedown,
  output   wire         ex4_pipe_clk,
  output   wire         ex4_pipedown,
  output   wire         expnt_rst_clk,
  output   wire         fdsu_ex1_sel,
  output   wire         half0_ex1_op1_sel,
  output   wire         single0_ex1_op1_sel,
  output   wire         srt_sm_on,
  output   wire         vfdsu_rbus_fflags_vld,
  output   wire         vfdsu_rbus_fpr_wb_req,
  output   wire         vfdsu_vpu_busy,
  output   wire         vfdsu_vpu_ex1_denormal_stall,
  output   wire         vfdsu_vpu_state_idle
); 



// &Regs; @25
reg            ex2_special_skip;               
reg     [2:0]  fdsu_cur_state;                 
reg     [2:0]  fdsu_next_state;                
reg     [4:0]  srt_cnt;                        

// &Wires; @26
wire           ctrl_fdsu_ex1_stall;            
wire           ctrl_id0;                       
wire           ctrl_id1;                       
wire           ctrl_iter_start;                
wire           ctrl_iter_start_gate;           
wire           ctrl_pack;                      
wire           ctrl_result_vld;                
wire           ctrl_round;                     
wire           ctrl_sm_cmplt;                  
wire           ctrl_sm_idle;                   
wire           ctrl_sm_start;                  
wire           ctrl_srt_idle;                  
wire           ctrl_srt_itering;               
wire           ctrl_wfi2;                      
wire           ctrl_wfwb;                      
wire           double_pipe0_ex1_op0_id;        
wire           double_pipe0_ex1_op1_id;        
wire           double_srt_skip;                
wire           ex1_pipe_clk_en;                
wire           ex1_save_op0;                   
wire           ex1_save_op0_gate;              
wire           ex1_srt_skip;                   
wire           ex2_pipe_clk_en;                
wire           ex4_pipe_clk_en;                
wire           expnt_rst_clk_en;               
wire           fdsu_busy;                      
wire           fdsu_clk;                       
wire           fdsu_clk_en;                    
wire           fdsu_dn_op0_id;                 
wire           fdsu_dn_op1_id;                 
wire           fdsu_dn_stall;                  
wire           fdsu_ex1_inst_vld;              
wire           fdsu_flush;                     
wire           fdsu_wb_grant;                  
wire    [4:0]  srt_cnt_ini;                    
wire           srt_cnt_zero;                   
wire           srt_last_round;                 
wire           srt_remainder_zero;             
wire           srt_skip;                       


//==========================================================
//                       Input Signal
//==========================================================
assign fdsu_ex1_inst_vld = vpu_vfdsu_ex1_sel;
assign fdsu_ex1_sel      = vpu_vfdsu_ex1_sel;
// &Force("bus", "vpu_group_1_xx_ex1_eu_sel", 9, 0); @33

//==========================================================
//                 FDSU Main State Machine
//==========================================================
assign ex1_srt_skip      = double_pipe0_ex1_srt_skip ;
always @(posedge fdsu_clk)
begin
    if(ex1_pipedown)
      ex2_special_skip <= ex1_srt_skip;
end

//assign fdsu_ex1_res_vld  = 1'b0;//fdsu_ex1_inst_vld && ex1_srt_skip;
//assign ex2_uf_srt_skip   = double_pipe0_ex2_uf_srt_skip && single_pipe_ex2_uf_srt_skip && 
//                           half_pipe0_ex2_uf_srt_skip &&  half_pipe1_ex2_uf_srt_skip;
assign srt_remainder_zero = double_pipe0_srt_remainder_zero;
assign fdsu_wb_grant      = rbus_vfdsu_fpr_wb_grnt;

assign ctrl_iter_start      = ctrl_sm_start && !fdsu_dn_op0_id && !fdsu_dn_op1_id
                              || ctrl_id0 && !fdsu_dn_op1_id
                              || ctrl_id1;
assign ctrl_iter_start_gate = ctrl_sm_start && !fdsu_dn_stall
                              || ctrl_id0 && !fdsu_dn_op1_id
                              || ctrl_id1;
assign vfdsu_vpu_state_idle   = ctrl_srt_idle;
assign ctrl_sm_start         = fdsu_ex1_inst_vld && ctrl_srt_idle;
//assign ctrl_sm_start_gate    = fdsu_ex1_inst_vld && ctrl_srt_idle;

assign srt_last_round = (srt_skip ||
                         srt_remainder_zero ||
                         srt_cnt_zero)      &&
                         ctrl_srt_itering;
assign double_srt_skip   = (double_pipe0_ex2_of || double_pipe0_ex2_uf_srt_skip);
assign srt_skip       =  double_srt_skip || ex2_special_skip;
assign srt_cnt_zero   = ~|srt_cnt[4:0];
// part of the stall signal is handled in vpu dp
assign fdsu_dn_stall =  ctrl_wfi2 
                       || ctrl_id0 && fdsu_dn_op1_id
                       || ctrl_sm_start && (fdsu_dn_op0_id || fdsu_dn_op1_id);

assign fdsu_dn_op0_id   = fdsu_ex1_inst_vld && 
                        (dp_ctrl_ex1_double && (double0_ex1_op0_id_vld)  ||
                         dp_ctrl_ex1_single && (single0_ex1_op0_id_vld) ||
                         dp_ctrl_ex1_half   && (half0_ex1_op0_id_vld) || 
                         dp_ctrl_ex1_bhalf  && (bhalf0_ex1_op0_id_vld));
assign fdsu_dn_op1_id   = fdsu_ex1_inst_vld && dp_ctrl_ex1_div &&  
                        (dp_ctrl_ex1_double && (double0_ex1_op1_id_vld)  ||
                         dp_ctrl_ex1_single && (single0_ex1_op1_id_vld ) ||
                         dp_ctrl_ex1_half   && (half0_ex1_op1_id_vld) || 
                         dp_ctrl_ex1_bhalf  && (bhalf0_ex1_op1_id_vld));

parameter IDLE  = 3'b000;
parameter WFI2  = 3'b001;
parameter ITER  = 3'b010;
parameter RND   = 3'b011;
parameter PACK  = 3'b100;
parameter WFWB  = 3'b101;
parameter ID0   = 3'b110;
parameter ID1   = 3'b111;

always @ (posedge fdsu_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    fdsu_cur_state[2:0] <= IDLE;
  else if (fdsu_flush)
    fdsu_cur_state[2:0] <= IDLE;
  else
    fdsu_cur_state[2:0] <= fdsu_next_state[2:0];
end
// add one state to inform the op0 id

// &CombBeg; @114
always @( fdsu_ex1_inst_vld
       or fdsu_dn_op0_id
       or srt_last_round
       or fdsu_cur_state
       or fdsu_dn_op1_id
       or fdsu_wb_grant)
begin
case (fdsu_cur_state)
  IDLE:
  begin
    if(fdsu_ex1_inst_vld)
      if (fdsu_dn_op0_id)
        fdsu_next_state = ID0;
      else if(fdsu_dn_op1_id)
        fdsu_next_state = WFI2;
    else
        fdsu_next_state = ITER;
    else 
      fdsu_next_state = IDLE;
  end
  ID0: 
  begin
    if(fdsu_dn_op1_id)
       fdsu_next_state = WFI2;
    else
       fdsu_next_state = ITER;
  end
  WFI2:fdsu_next_state = ID1;
  ID1: fdsu_next_state = ITER;
  ITER:
  begin
    if (srt_last_round)
      fdsu_next_state = RND;
    else
      fdsu_next_state = ITER;
  end
  RND:
    fdsu_next_state = PACK;
  PACK:
  begin
      fdsu_next_state = WFWB;
  end
  WFWB:
  begin
    if (fdsu_wb_grant)
       fdsu_next_state = IDLE;
    else
      fdsu_next_state = WFWB;
  end
  default:
    fdsu_next_state = IDLE;
endcase
// &CombEnd; @160
end

assign ctrl_sm_idle     = fdsu_cur_state == IDLE;
assign ctrl_wfi2        = fdsu_cur_state == WFI2;
assign ctrl_srt_itering = fdsu_cur_state == ITER;
assign ctrl_round       = fdsu_cur_state == RND;
assign ctrl_pack        = fdsu_cur_state == PACK;
assign ctrl_wfwb        = fdsu_cur_state == WFWB;
assign ctrl_id0         = fdsu_cur_state == ID0;
assign ctrl_id1         = fdsu_cur_state == ID1;

assign ctrl_sm_cmplt    = ctrl_wfwb;
assign ctrl_srt_idle    = ctrl_sm_idle;
//assign ctrl_sm_ex1      = ctrl_srt_idle || ctrl_wfi2;

//==========================================================
//                    Iteration Counter
//==========================================================
always @ (posedge fdsu_clk)
begin
  if (fdsu_flush)
    srt_cnt[4:0] <= 5'b0;
  else if (ctrl_iter_start)
    srt_cnt[4:0] <= srt_cnt_ini[4:0];
  else if (ctrl_srt_itering)
    srt_cnt[4:0] <= srt_cnt[4:0] - 5'b1;
  else
    srt_cnt[4:0] <= srt_cnt[4:0];
end

//srt_cnt_ini[4:0]
//For Double, initial is 5'b11100('d28), calculate 29 round
//For Single, initial is 5'b01110('d14), calculate 15 round
assign srt_cnt_ini[4:0] = {5{ex1_double}} & 5'b11100 |    // 28
                          {5{ex1_single}} & 5'b01101  |
                          {5{ex1_half}}   & 5'b00111  |
                          {5{ex1_bhalf}}  & 5'b00101;    // 14

//fdsu srt first round signal 
//For srt calculate special use
always @(posedge fdsu_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ex2_srt_first_round <= 1'b0;
  else if(fdsu_flush)
    ex2_srt_first_round <= 1'b0;
  else if(ex1_pipedown)
    ex2_srt_first_round <= 1'b1;
  else
    ex2_srt_first_round <= 1'b0;
end

//==========================================================
//                 Write Back State Machine
//==========================================================
parameter WB_IDLE  = 2'b00,
          WB_EX2   = 2'b10,
          WB_CMPLT = 2'b01;
//
assign ctrl_result_vld  = ctrl_sm_cmplt; //&& ctrl_wb_sm_cmplt;
//assign ctrl_fdsu_wb_vld = ctrl_result_vld && fdsu_wb_grant;

assign ctrl_fdsu_ex1_stall = fdsu_ex1_inst_vld && fdsu_dn_stall;
//assign ctrl_xx_ex1_stall   = ctrl_fdsu_ex1_stall;

//==========================================================
//                          Flush
//==========================================================
assign fdsu_flush =  ifu_vpu_warm_up
                 || rtu_yy_xx_async_flush;

//==========================================================
//                           ICG
//==========================================================
assign fdsu_busy =  !ctrl_sm_idle && !ctrl_wfi2 && !ctrl_id0 && !ctrl_id1;
assign vfdsu_vpu_busy = fdsu_busy;                
assign fdsu_clk_en = fdsu_ex1_inst_vld && ctrl_sm_idle
                  || fdsu_busy
                  || !ctrl_sm_idle
                  || rtu_yy_xx_flush;
// &Instance("gated_clk_cell", "x_fdsu_clk"); @291
gated_clk_cell  x_fdsu_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fdsu_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fdsu_clk_en       ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

assign ex1_pipe_clk_en = ex1_pipedown_gate;
gated_clk_cell  x_ex1_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

assign ex2_pipe_clk_en = ex2_pipedown;
gated_clk_cell  x_ex2_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


assign expnt_rst_clk_en = ex1_save_op0_gate
                       || ctrl_id0
                       || ex1_pipedown_gate
                       || ex2_pipedown
                       || ex3_pipedown;
gated_clk_cell  x_expnt_rst_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (expnt_rst_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (expnt_rst_clk_en  ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


assign ex4_pipe_clk_en = ex4_pipedown;
gated_clk_cell  x_ex4_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex4_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex4_pipe_clk_en   ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);


//==========================================================
//                      Output Signal
//==========================================================
//assign fdsu_yy_wb_freg[4:0]    = fdsu_wb_freg[4:0];


assign ex1_pipedown = ctrl_iter_start || ifu_vpu_warm_up;
assign ex1_pipedown_gate = ctrl_iter_start_gate || ifu_vpu_warm_up;
assign ex2_pipedown = ctrl_srt_itering && srt_last_round || ifu_vpu_warm_up;
assign ex3_pipedown = ctrl_round || ifu_vpu_warm_up;
assign ex4_pipedown = ctrl_pack || ifu_vpu_warm_up;

assign srt_sm_on = ctrl_srt_itering;

//assign fdsu_fpu_ex1_cmplt = fdsu_ex1_inst_vld;
//assign fdsu_fpu_ex1_stall = ctrl_fdsu_ex1_stall;
//assign fdsu_frbus_wb_vld  = ctrl_result_vld;
assign vfdsu_vpu_ex1_denormal_stall = ctrl_fdsu_ex1_stall;
assign vfdsu_rbus_fpr_wb_req      = ctrl_result_vld;
assign vfdsu_rbus_fflags_vld      = ctrl_result_vld;
//assign fdsu_fpu_no_op     = !fdsu_busy;

assign double0_ex1_op1_sel  = ctrl_wfi2 || ctrl_id1;
assign single0_ex1_op1_sel = ctrl_wfi2 || ctrl_id1;
assign half0_ex1_op1_sel   = ctrl_wfi2 || ctrl_id1;
assign bhalf0_ex1_op1_sel  = ctrl_wfi2 || ctrl_id1;
assign double_pipe0_ex1_op1_sel = ctrl_wfi2 || ctrl_id1;

assign double_pipe0_ex1_ff1_sel_op1 = ctrl_wfi2|| ctrl_id1;

assign double_pipe0_ex1_op0_id         = dp_ctrl_ex1_double && double0_ex1_op0_id_vld || 
                                                          dp_ctrl_ex1_single && single0_ex1_op0_id_vld ||
                                                          dp_ctrl_ex1_half  && half0_ex1_op0_id_vld    ||
                                                          dp_ctrl_ex1_bhalf && bhalf0_ex1_op0_id_vld;
assign double_pipe0_ex1_op1_id         = dp_ctrl_ex1_double && double0_ex1_op1_id_vld || 
                                                          dp_ctrl_ex1_single && single0_ex1_op1_id_vld ||
                                                          dp_ctrl_ex1_half  && half0_ex1_op1_id_vld    ||
                                                          dp_ctrl_ex1_bhalf && bhalf0_ex1_op1_id_vld;
assign ex1_save_ff1_op1_id            = ctrl_wfi2;

assign double_pipe0_ex1_save_op0       = ctrl_sm_start && double_pipe0_ex1_op0_id;
assign double_pipe0_save_op0_neg_expnt  = ctrl_id0 && fdsu_dn_op1_id;

assign ex1_save_op0              = ctrl_id0 && (double_pipe0_ex1_op1_id);
assign ex1_save_op0_gate         = ctrl_id0 || ctrl_sm_start;                                   
assign ctrl_dp_ex1_save_op0      = ex1_save_op0;
assign ctrl_dp_ex1_save_op0_gate      = ex1_save_op0_gate;
// &Force("output", "double_pipe0_ex1_save_op0"); @396


// &ModuleEnd; @402
endmodule



