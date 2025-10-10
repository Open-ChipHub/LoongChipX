/*Copyright 2019-2021 T-Head Semiconductor Co., Ltd.

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

// &ModuleBeg; @22
module ct_ifu_vector (
  // &Ports, @23
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_ifu_rst_inv_done,
  input    wire  [39:0]  cp0_ifu_rvbr,
  input    wire  [39:0]  cp0_ifu_vbr,
  input    wire  [2 :0]  cp0_ifu_ecfg_vs,
  input    wire  [63:0]  cp0_ifu_eentry,
  input    wire  [63:0]  sysio_core_restart_entry,
  input    wire          sysio_core_restart_vld,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_ifu_xx_dbgon,
  input    wire  [15:0]  rtu_ifu_xx_expt_vec,
  input    wire          rtu_ifu_xx_expt_vld,
  output   wire          ifu_cp0_rst_inv_req,
  output   wire          ifu_xx_sync_reset,
  output   wire          core_sysio_restart_grnt,
  output   wire  [9 :0]  vector_debug_cur_st,
  output   wire          vector_debug_reset_on,
  output   wire          vector_ifctrl_reset_on,
  output   wire          vector_ifctrl_sm_on,
  output   wire          vector_ifctrl_sm_start,
  output   wire  [62:0]  vector_pcgen_pc,
  output   wire          vector_pcgen_pcload,
  output   wire          vector_pcgen_reset_on
); 


parameter PC_WIDTH = 64;

// &Regs; @24
reg     [62:0]  nonvec_pc;              
reg     [9 :0]  vec_cur_state;          
reg     [9 :0]  vec_next_state;         
reg             vector_rst_inv_ff;      

// &Wires; @25
wire    [2 :0]  expt_mode;              
wire    [62:0]  expt_virtual_pc;                 
wire            pc_load;                
wire            reset_expt;             
wire    [62:0]  reset_virtual_pc;       
wire            vec_sm_clk;             
wire            vec_sm_clk_en;          
wire            vector_pc_update_clk;   
wire            vector_pc_update_clk_en; 
wire            vector_reset_on;        
wire            vector_sm_on;           
wire    [62:0]  virtual_pc;             
wire    [15:0]  expt_tmp_off;
wire    [17:0]  expt_page_offset;
wire    [PC_WIDTH-3:0] expt_pc_plus_offset;

// &Force("bus","cp0_ifu_rvbr",39,0); @28

//==========================================================
//                 Vector State Machine
//==========================================================
//-----------------parameter definition---------------------
parameter IDLE   = 10'b0000000001;
//parameter PHYADD = 10'b0000000010;
//parameter WAIT1  = 10'b0000000100;
//parameter CACHE  = 10'b0000001000;
//parameter CMP    = 10'b0000010000;
//parameter WAIT2  = 10'b0000100000;
//parameter MISS   = 10'b0001000000;
//parameter EXP    = 10'b0010000000;
parameter RESET  = 10'b0100000000;
parameter PCLOAD = 10'b1000000000;

//---------------------Gate Clock---------------------------
// &Instance("gated_clk_cell","x_vec_sm_clk"); @46
gated_clk_cell  x_vec_sm_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vec_sm_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (vec_sm_clk_en     ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @47
//           .clk_out        (vec_sm_clk),//Out Clock @48
//           .external_en    (1'b0), @49
//           .global_en      (cp0_yy_clk_en), @50
//           .local_en       (vec_sm_clk_en),//Local Condition @51
//           .module_en      (cp0_ifu_icg_en) @52
//         ); @53
assign vec_sm_clk_en = rtu_ifu_xx_expt_vld || 
                       (vec_cur_state[9:0] != IDLE);

//---------------------FSM of Vector------------------------
//State Description:
//IDLE   : Wait for rtu expt signal & send physical address req
//RESET  : One cycle to form reset logic
//PHYADD : Wait for mmu information ready
//WAIT1  : Wait Refill not on and send read req
//         support hit under miss
//CACHE  : The cycle after icache read
//CMP    : compare and judge if cache hit request
//WAIT2  : wait Refill on IDLE state and send vec miss refill req out
//         WAIT1 refill not on do not means on IDLE state
//MISS   : icache miss and wait data from refill
//EXP    : Deal with expt occur on vec sm on
//PCLOAD : Deal with non-vec expt

//!cpurst_b should be treated as expt
//when !cpurst_b , vec_cur_state turn to PHYADD
always @(posedge vec_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    vec_cur_state[9:0] <= RESET;
  else if(rtu_ifu_xx_dbgon)
    vec_cur_state[9:0] <= IDLE;
  else
    vec_cur_state[9:0] <= vec_next_state[9:0];
end

// &CombBeg; @84
always @( vec_cur_state[9:0]
       or cp0_ifu_rst_inv_done
       or sysio_core_restart_vld
       or rtu_ifu_xx_expt_vld)
begin
case(vec_cur_state[9:0])
  IDLE    : if(sysio_core_restart_vld)
              vec_next_state[9:0] = PCLOAD;
            else if(rtu_ifu_xx_expt_vld)
              vec_next_state[9:0] = PCLOAD;
            else
              vec_next_state[9:0] = IDLE;
  RESET   : if(cp0_ifu_rst_inv_done)
              vec_next_state[9:0] = IDLE;
            else
              vec_next_state[9:0] = RESET;
  PCLOAD  : vec_next_state[9:0] = IDLE;
  default : vec_next_state[9:0] = IDLE;
endcase
// &CombEnd; @97
end
          
//-------------------Control Signal-------------------------
always @(posedge vec_sm_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    vector_rst_inv_ff     <= 1'b0;
  end
  else begin
    vector_rst_inv_ff     <= vec_cur_state[8];
  end
end

assign ifu_xx_sync_reset     = vec_cur_state[8];
assign ifu_cp0_rst_inv_req   = vec_cur_state[8]  && !vector_rst_inv_ff;
assign vector_reset_on       = vec_cur_state[8];
assign vector_sm_on          = !(vec_cur_state[0]); //IDLE
assign pc_load               = (!rtu_ifu_xx_dbgon) &&
                               (
                                 (vec_cur_state[8]) &&  //RESET
                                 cp0_ifu_rst_inv_done  ||
                                 (vec_cur_state[9])  //PCLOAD
                               );

//==========================================================
//                    Virtual PC
//==========================================================
//supprt multi_core different rst vbr
//rvbr is 20 bit and the following 2 bit of it must be 2'b00
// &Force("bus","cp0_ifu_vbr",39,0); @126
assign reset_expt             = (rtu_ifu_xx_expt_vec[15:0] == 16'b0);
assign expt_mode[2:0]         = cp0_ifu_ecfg_vs[2:0];

// page_offset = 2^(ecfg.vs+2)
assign expt_tmp_off[15:0] = ({8'b0, rtu_ifu_xx_expt_vec[7:0]}) << cp0_ifu_ecfg_vs[2:0];
assign expt_page_offset[17:0] =  {expt_tmp_off[15:0], 2'b0};


assign expt_pc_plus_offset[PC_WIDTH-3:0] = cp0_ifu_eentry[PC_WIDTH-1:2] | {{PC_WIDTH-18{1'b0}}, expt_page_offset[17:2]};

assign expt_virtual_pc[PC_WIDTH-2:0]  = (expt_mode[2:0] != 3'b0) 
                                      ? {expt_pc_plus_offset[PC_WIDTH-3:0], 1'b0}                                       
                                      : {cp0_ifu_eentry[PC_WIDTH-1:2], 1'b0};

assign reset_virtual_pc[PC_WIDTH-2:0] = {24'b0, cp0_ifu_rvbr[39:1]};
assign virtual_pc[PC_WIDTH-2:0]       = (reset_expt)
                                      ? reset_virtual_pc[PC_WIDTH-2:0]
                                      : expt_virtual_pc[PC_WIDTH-2:0];

assign core_sysio_restart_grnt  =  vec_cur_state[0];

always @(posedge vector_pc_update_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    nonvec_pc[PC_WIDTH-2:0] <= {PC_WIDTH-1{1'b0}};
  else if(sysio_core_restart_vld)
    nonvec_pc[PC_WIDTH-2:0] <= sysio_core_restart_entry[PC_WIDTH-1:1];
  else if(rtu_ifu_xx_expt_vld || reset_expt)
    nonvec_pc[PC_WIDTH-2:0] <= virtual_pc[PC_WIDTH-2:0];
  else
    nonvec_pc[PC_WIDTH-2:0] <= nonvec_pc[PC_WIDTH-2:0];
end

//Gate Clk
// &Instance("gated_clk_cell","x_vector_pc_update_clk"); @151
gated_clk_cell  x_vector_pc_update_clk (
  .clk_in                  (forever_cpuclk         ),
  .clk_out                 (vector_pc_update_clk   ),
  .external_en             (1'b0                   ),
  .global_en               (cp0_yy_clk_en          ),
  .local_en                (vector_pc_update_clk_en),
  .module_en               (cp0_ifu_icg_en         ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     )
);

// &Connect( .clk_in         (forever_cpuclk), @152
//           .clk_out        (vector_pc_update_clk),//Out Clock @153
//           .external_en    (1'b0), @154
//           .global_en      (cp0_yy_clk_en), @155
//           .local_en       (vector_pc_update_clk_en),//Local Condition @156
//           .module_en      (cp0_ifu_icg_en) @157
//         ); @158
assign vector_pc_update_clk_en = rtu_ifu_xx_expt_vld 
                              || reset_expt && vec_cur_state[8];


//==========================================================
//             Interface to PC Generator
//==========================================================
assign vector_pcgen_pcload   = pc_load;
assign vector_pcgen_reset_on = vector_reset_on;
assign vector_pcgen_pc[PC_WIDTH-2:0] = nonvec_pc[PC_WIDTH-2:0];


//==========================================================
//               Interface to ifctrl
//==========================================================
assign vector_ifctrl_sm_on    = vector_sm_on;
assign vector_ifctrl_reset_on = vector_reset_on;
//when vector is on RESET mode,we can not stop icache inv operation,
//or it will cause deadlock for vector state is waiting invalid complete
//but vector state stop icache invalid operation
assign vector_ifctrl_sm_start = vector_sm_on && !vec_cur_state[8] || 
                                rtu_ifu_xx_expt_vld;

//Debug Infor
assign vector_debug_cur_st[9:0] = vec_cur_state[9:0];
assign vector_debug_reset_on    = vector_reset_on;
// &ModuleEnd; @185
endmodule


