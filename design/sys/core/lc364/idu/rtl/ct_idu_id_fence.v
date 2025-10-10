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

// &ModuleBeg; @27
module ct_idu_id_fence (
  // &Ports, @28
  input    wire           cp0_idu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           ctrl_fence_id_inst_vld,
  input    wire           ctrl_fence_id_stall,
  input    wire           ctrl_fence_ir_pipe_empty,
  input    wire           ctrl_fence_is_pipe_empty,
  input    wire           dp_fence_id_bkpta_inst,
  input    wire           dp_fence_id_bkptb_inst,
  input    wire  [2  :0]  dp_fence_id_fence_type,
  input    wire  [31 :0]  dp_fence_id_inst,
  input    wire  [14 :0]  dp_fence_id_pc,
  input    wire  [7  :0]  dp_fence_id_vl,
  input    wire           dp_fence_id_vl_pred,
  input    wire  [1  :0]  dp_fence_id_vlmul,
  input    wire  [2  :0]  dp_fence_id_vsew,
  input    wire           forever_cpuclk,
  input    wire           iu_idu_div_busy,
  input    wire           iu_yy_xx_cancel,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_idu_flush_fe,
  input    wire           rtu_idu_pst_empty,
  input    wire           rtu_idu_rob_empty,
  output   wire           fence_ctrl_id_stall,
  output   wire           fence_ctrl_inst0_vld,
  output   wire           fence_ctrl_inst1_vld,
  output   wire           fence_ctrl_inst2_vld,
  output   reg   [177:0]  fence_dp_inst0_data,
  output   reg   [177:0]  fence_dp_inst1_data,
  output   reg   [177:0]  fence_dp_inst2_data,
  output   wire  [2  :0]  fence_top_cur_state,
  output   wire           idu_had_pipeline_empty,
  output   wire           idu_hpcp_fence_sync_vld,
  output   wire           idu_rtu_fence_idle
); 



// &Regs; @29
reg     [2  :0]  fence_cur_state;              
reg     [177:0]  fence_inst0_cp0_data;         
reg     [177:0]  fence_inst0_cp0_csr_data;         
reg     [177:0]  fence_inst1_cp0_csr_data;         
reg     [177:0]  fence_inst2_cp0_csr_data;         
reg     [177:0]  fence_inst0_cp0_ret_data;         
reg     [177:0]  fence_inst0_cp0_cpucfg_data;         
reg     [177:0]  fence_inst0_cp0_iocsr_data;         
reg     [177:0]  fence_inst0_data;             
reg     [177:0]  fence_inst0_fence_data;       
reg     [177:0]  fence_inst0_sync_data;        
reg     [177:0]  fence_inst0_invtlb_data;        
reg     [177:0]  fence_inst0_tlbop_data;        
reg     [177:0]  fence_inst1_fence_data;       
reg     [177:0]  fence_inst2_sync_data;        
reg     [2  :0]  fence_next_state;             

// &Wires; @30
wire             fence_clk;                    
wire             fence_clk_en;                 
wire    [31 :0]  fence_inst0_bar_opcode;       
wire             fence_inst0_cp0_csr1r;         
wire             fence_inst0_cp0_csr2r;         
wire             fence_inst0_fence_fencei;     
wire             fence_inst0_fence_sfence_asid; 
wire             fence_inst0_fence_sfence_va;  
wire    [177:0]  fence_inst1_data;             
wire    [177:0]  fence_inst2_data;             
wire    [31 :0]  fence_inst2_sync_opcode;      
wire             fence_pipedown;               
wire             fence_pipeline_empty;         
wire             fence_sm_start;
wire             fence_and_cpucfg_inst;
wire             fence_invtlb_inst;               
wire             fence_tlbop_inst;               
wire    [4  :0]  invtlb_inst_opcode;
wire             invtlb_asid;
wire             invtlb_va;


//==========================================================
//                       Parameters
//==========================================================
//----------------------------------------------------------
//                 IR data path parameters
//----------------------------------------------------------
parameter IR_WIDTH            = 178;

parameter IR_VL_PRED          = 177;
parameter IR_VL               = 176;
parameter IR_VMB              = 168;
parameter IR_PC               = 167;
parameter IR_VSEW             = 152;
parameter IR_VLMUL            = 149;
parameter IR_FMLA             = 147;
parameter IR_SPLIT_NUM        = 146;
parameter IR_NO_SPEC          = 139;
parameter IR_MLA              = 138;
parameter IR_DST_X0           = 137;
parameter IR_ILLEGAL          = 136;
parameter IR_SPLIT_LAST       = 135;
parameter IR_VMLA             = 134;
parameter IR_IID_PLUS         = 133;
parameter IR_BKPTB_INST       = 129;
parameter IR_BKPTA_INST       = 128;
parameter IR_FMOV             = 127;
parameter IR_MOV              = 126;
parameter IR_EXPT             = 125;
parameter IR_LENGTH           = 118;
parameter IR_INTMASK          = 117;
parameter IR_SPLIT            = 116;
parameter IR_INST_TYPE        = 115;
parameter IR_DSTV_REG         = 105;
parameter IR_DSTV_VLD         = 99;
parameter IR_SRCVM_VLD        = 98;
parameter IR_SRCV2_VLD        = 97;
parameter IR_SRCV1_REG        = 96;
parameter IR_SRCV1_VLD        = 90;
parameter IR_SRCV0_REG        = 89;
parameter IR_SRCV0_VLD        = 83;
parameter IR_DSTE_VLD         = 82;
parameter IR_DSTF_REG         = 81;
parameter IR_DSTF_VLD         = 75;
parameter IR_SRCF2_REG        = 74;
parameter IR_SRCF2_VLD        = 68;
parameter IR_SRCF1_REG        = 67;
parameter IR_SRCF1_VLD        = 61;
parameter IR_SRCF0_REG        = 60;
parameter IR_SRCF0_VLD        = 54;
parameter IR_DST_REG          = 53;
parameter IR_DST_VLD          = 47;
parameter IR_SRC2_VLD         = 46;
parameter IR_SRC1_REG         = 45;
parameter IR_SRC1_VLD         = 39;
parameter IR_SRC0_REG         = 38;
parameter IR_SRC0_VLD         = 32;
parameter IR_OPCODE           = 31;

//----------------------------------------------------------
//                 Type parameters
//----------------------------------------------------------
parameter ALU      = 10'b0000000001;
parameter BJU      = 10'b0000000010;
parameter MULT     = 10'b0000000100;
parameter DIV      = 10'b0000001000;
parameter LSU_P5   = 10'b0000110000;
parameter LSU      = 10'b0000010000;
parameter PIPE67   = 10'b0001000000;
parameter PIPE6    = 10'b0010000000;
parameter PIPE7    = 10'b0100000000;
parameter SPECIAL  = 10'b1000000000;

//==========================================================
//                    Fence instructions 
//==========================================================
parameter IDLE        = 3'b000;
parameter WAIT_ISSUE  = 3'b001;
parameter ISSUE       = 3'b010;
parameter WAIT_CMPLT  = 3'b011;
parameter POP_INST    = 3'b100;

//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign fence_clk_en = fence_sm_start
                      || (fence_cur_state[2:0] != IDLE);
// &Instance("gated_clk_cell", "x_fence_gated_clk"); @119
gated_clk_cell  x_fence_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fence_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fence_clk_en      ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @120
//          .external_en (1'b0), @121
//          .global_en   (cp0_yy_clk_en), @122
//          .module_en   (cp0_idu_icg_en), @123
//          .local_en    (fence_clk_en), @124
//          .clk_out     (fence_clk)); @125

//----------------------------------------------------------
//              control signal for fence FSM
//----------------------------------------------------------
assign fence_sm_start         = ctrl_fence_id_inst_vld
                                && !ctrl_fence_id_stall;
assign fence_pipeline_empty   = ctrl_fence_ir_pipe_empty
                                && ctrl_fence_is_pipe_empty
                                && rtu_idu_rob_empty
                                && !iu_idu_div_busy
                                && rtu_idu_pst_empty;
assign fence_pipedown         = fence_pipeline_empty;
assign idu_had_pipeline_empty = fence_pipeline_empty;

//----------------------------------------------------------
//             FSM of inst fence ctrl logic
//----------------------------------------------------------
// State Description:
// IDLE       : id stage instruction 0 is not fence instruction
//              or the first cycle to start fence FSM
// WAIT_ISSUE : wait backend pipeline empty
// ISSUE      : start to pipedown
// WAIT_CMPLT : wait this fence instruction complete
// POP_INST   : pop fence inst from id stage pipeline register

always @(posedge fence_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fence_cur_state[2:0] <= IDLE;
  else if(rtu_idu_flush_fe)
    fence_cur_state[2:0] <= IDLE;
  else if(iu_yy_xx_cancel)
    fence_cur_state[2:0] <= IDLE;
  else
    fence_cur_state[2:0] <= fence_next_state[2:0];
end

// &CombBeg; @163
always @( fence_pipeline_empty
       or fence_pipedown
       or fence_cur_state[2:0]
       or fence_sm_start)
begin
  case(fence_cur_state[2:0])
  IDLE       : if(fence_sm_start)
                 fence_next_state[2:0] = WAIT_ISSUE;
               else
                fence_next_state[2:0] = IDLE;
  WAIT_ISSUE : if(fence_pipedown)
                 fence_next_state[2:0] = ISSUE;
               else
                 fence_next_state[2:0] = WAIT_ISSUE;
  ISSUE      :   fence_next_state[2:0] = WAIT_CMPLT;
  WAIT_CMPLT : if(fence_pipeline_empty)
                 fence_next_state[2:0] = POP_INST;
               else
                 fence_next_state[2:0] = WAIT_CMPLT;
  POP_INST   :   fence_next_state[2:0] = IDLE;
  default    :   fence_next_state[2:0] = IDLE;
  endcase
// &CombEnd; @181
end

//----------------------------------------------------------
//                   control signals
//----------------------------------------------------------
assign fence_ctrl_id_stall      = ctrl_fence_id_inst_vld
                                  && !fence_cur_state[2]; //POP_INST

assign fence_ctrl_inst0_vld     = (fence_cur_state[2:0] == ISSUE); 

/// here csrxchg is as one instruction
/// only one is valid.
/// for future, extend.
assign fence_ctrl_inst1_vld     = (fence_cur_state[2:0] == ISSUE)
                                  && !(|dp_fence_id_fence_type);  

assign fence_ctrl_inst2_vld     = (fence_cur_state[2:0] == ISSUE)
                                  && !(|dp_fence_id_fence_type);  

assign fence_top_cur_state[2:0] = fence_cur_state[2:0];

assign idu_rtu_fence_idle       = (fence_cur_state[2:0] == IDLE)
                               || (fence_cur_state[2:0] != IDLE)
                                  && dp_fence_id_fence_type[1]
                                  && !(dp_fence_id_inst[31:15] == 17'b00000110010010001); //wait

assign idu_hpcp_fence_sync_vld  = (fence_cur_state[2:0] == POP_INST)
                                  && (dp_fence_id_fence_type[0]);

//----------------------------------------------------------
//          Sync Instuction: sync(dbar), cache
//----------------------------------------------------------
// &CombBeg; @213
always @( dp_fence_id_inst[31:0])
begin
  fence_inst0_sync_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_sync_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];

  /// we handle fence instruction in ir_decd, so ignore IR_INST_TYPE, dont care
  fence_inst0_sync_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU;
  fence_inst0_sync_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @220
end

//----------------------------------------------------------
//          Sync Instuction: invtlb
//----------------------------------------------------------

assign fence_invtlb_inst       = (dp_fence_id_inst[31:15] == 17'b00000110010010011); // invtlb

assign invtlb_inst_opcode[4:0] = dp_fence_id_inst[4:0];

assign invtlb_asid  =  (invtlb_inst_opcode[4:0] == 5'd4)
                    || (invtlb_inst_opcode[4:0] == 5'd5)
                    || (invtlb_inst_opcode[4:0] == 5'd6);

assign invtlb_va    =  (invtlb_inst_opcode[4:0] == 5'd5)
                    || (invtlb_inst_opcode[4:0] == 5'd6);

// &CombBeg; @213
always @( dp_fence_id_inst[31:0]
         or invtlb_asid
         or invtlb_va
         )
begin
  fence_inst0_invtlb_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_invtlb_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];

  fence_inst0_invtlb_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU_P5;
  fence_inst0_invtlb_data[IR_SRC0_VLD]                 = invtlb_va;
  fence_inst0_invtlb_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0,dp_fence_id_inst[14:10]};
  fence_inst0_invtlb_data[IR_SRC1_VLD]                 = invtlb_asid;
  fence_inst0_invtlb_data[IR_SRC1_REG:IR_SRC1_REG-5]   = {1'b0,dp_fence_id_inst[9:5]};
  fence_inst0_invtlb_data[IR_LENGTH]                   = 1'b1;

  end
// &CombEnd; @220
end


//----------------------------------------------------------
//          Sync Fence Instuction: TLB Operation
//----------------------------------------------------------
assign fence_tlbop_inst  = (dp_fence_id_inst[31:10] == 22'b00000110010010000_01000) ||  // tlbclr
                           (dp_fence_id_inst[31:10] == 22'b00000110010010000_01001) ||  // tlbflush
                           (dp_fence_id_inst[31:10] == 22'b00000110010010000_01010) ||  // tlbsrch
                           (dp_fence_id_inst[31:10] == 22'b00000110010010000_01011) ||  // tlbrd
                           (dp_fence_id_inst[31:10] == 22'b00000110010010000_01100) ||  // tlbwr
                           (dp_fence_id_inst[31:10] == 22'b00000110010010000_01101);    // tlbfill
// &CombBeg; @213
always @( dp_fence_id_inst[31:0])
begin
  fence_inst0_tlbop_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_tlbop_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];

  /// we handle fence instruction in ir_decd, so ignore IR_INST_TYPE, dont care
  fence_inst0_tlbop_data[IR_INST_TYPE:IR_INST_TYPE-9] = SPECIAL;
  fence_inst0_tlbop_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @220
end


//----------------------------------------------------------
//                 CSR Instuction: csrrd,csrwr
//----------------------------------------------------------
wire fence_inst0_cp0_csr1r_rd = ({dp_fence_id_inst[31:24], dp_fence_id_inst[9:5]} == 13'b00000100_00000); //csrrd
wire fence_inst0_cp0_csr1r_wr = ({dp_fence_id_inst[31:24], dp_fence_id_inst[9:5]} == 13'b00000100_00001); //csrwr

wire fence_inst0_cp0_mvfcsr2gr_rd = (dp_fence_id_inst[31:10] == 22'b0000000100010100110010); // movfcsr2gr 
wire fence_inst0_cp0_mvgr2fcsr_wr = (dp_fence_id_inst[31:10] == 22'b0000000100010100110000); // movgr2fcsr

assign fence_inst0_cp0_csr1r = fence_inst0_cp0_csr1r_rd 
                            || fence_inst0_cp0_csr1r_wr
                            || fence_inst0_cp0_mvfcsr2gr_rd
                            || fence_inst0_cp0_mvgr2fcsr_wr; 
                               

wire [4:0] dp_fence_id_inst_src0;

assign dp_fence_id_inst_src0[4:0] =  {5{fence_inst0_cp0_csr1r_wr}} & dp_fence_id_inst[4:0]
                                   | {5{fence_inst0_cp0_mvgr2fcsr_wr}} & dp_fence_id_inst[9:5];

wire  csr_rd_wr_update_dest_reg;

assign csr_rd_wr_update_dest_reg = fence_inst0_cp0_csr1r_rd || fence_inst0_cp0_csr1r_wr;

// &CombBeg; @250
always @( dp_fence_id_inst[31:0]
       or dp_fence_id_inst_src0[4:0]
       or fence_inst0_cp0_csr1r
       or fence_inst0_cp0_csr1r_wr
       or fence_inst0_cp0_csr1r_rd
       or csr_rd_wr_update_dest_reg
       or fence_inst0_cp0_mvfcsr2gr_rd
       or fence_inst0_cp0_mvgr2fcsr_wr)
begin
  fence_inst0_cp0_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_cp0_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];
  fence_inst0_cp0_data[IR_INST_TYPE:IR_INST_TYPE-9] = SPECIAL;
  fence_inst0_cp0_data[IR_SRC0_VLD]                 = (fence_inst0_cp0_csr1r_wr || fence_inst0_cp0_mvgr2fcsr_wr);
  fence_inst0_cp0_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0, dp_fence_id_inst_src0[4:0]};
  fence_inst0_cp0_data[IR_DST_VLD]                  = (csr_rd_wr_update_dest_reg || fence_inst0_cp0_mvfcsr2gr_rd);
  fence_inst0_cp0_data[IR_DST_REG:IR_DST_REG-5]     = {1'b0,dp_fence_id_inst[4:0]};
  fence_inst0_cp0_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @261
end


//----------------------------------------------------------
//                  Split Instruction csrxchg
//----------------------------------------------------------
wire [4 :0] fence_inst_csr2r_rj;
wire [4 :0] fence_inst_csr2r_rd;
wire [13:0] fence_inst_csr2r_csr;

assign fence_inst0_cp0_csr2r = ({dp_fence_id_inst[31:24]} == 8'b00000100) 
                                && (dp_fence_id_inst[9:5] != 5'b00000)
                                && (dp_fence_id_inst[9:5] != 5'b00001); //csrxchg
                               
assign fence_inst_csr2r_rj[4:0] = dp_fence_id_inst[9:5];
assign fence_inst_csr2r_rd[4:0] = dp_fence_id_inst[4:0];
assign fence_inst_csr2r_csr[13:0] = dp_fence_id_inst[23:10];

//----------------------------------------------------------
//     Split Instruction csrxchg -> csrrd, only one
//----------------------------------------------------------
wire [31:0] fence_inst0_csrrd_opcode;

assign fence_inst0_csrrd_opcode[31:24] = 8'b00000100;
assign fence_inst0_csrrd_opcode[23:10] = fence_inst_csr2r_csr[13:0];
assign fence_inst0_csrrd_opcode[ 9: 5] = 5'b00000;
assign fence_inst0_csrrd_opcode[ 4: 0] = fence_inst_csr2r_rd[4:0];

always @(dp_fence_id_inst[31:0]
        or fence_inst0_cp0_csr2r)
begin
  fence_inst0_cp0_csr_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_cp0_csr_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];
  fence_inst0_cp0_csr_data[IR_INST_TYPE:IR_INST_TYPE-9] = SPECIAL;
  fence_inst0_cp0_csr_data[IR_SRC0_VLD]                 = 1'b1;
  fence_inst0_cp0_csr_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0, dp_fence_id_inst[9:5]};
  fence_inst0_cp0_csr_data[IR_SRC1_VLD]                 = 1'b1;
  fence_inst0_cp0_csr_data[IR_SRC1_REG:IR_SRC1_REG-5]   = {1'b0, dp_fence_id_inst[4:0]};
  fence_inst0_cp0_csr_data[IR_DST_VLD]                  = fence_inst0_cp0_csr2r;
  fence_inst0_cp0_csr_data[IR_DST_REG:IR_DST_REG-5]     = {1'b0, dp_fence_id_inst[4:0]};
  fence_inst0_cp0_csr_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @261
end


wire fence_inst_ibar = (dp_fence_id_inst[31:15] == 17'b00111000011100101);
assign fence_inst0_bar_opcode[31:0] = 32'h38720000; //dbar

// &CombBeg; @268
always @( fence_inst0_bar_opcode[31:0])
begin
  fence_inst0_fence_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_fence_data[IR_OPCODE:IR_OPCODE-31]      = fence_inst0_bar_opcode[31:0];
  fence_inst0_fence_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU;
  fence_inst0_fence_data[IR_LENGTH]                   = 1'b1;
  fence_inst0_fence_data[IR_SPLIT]                    = 1'b1;
  end
// &CombEnd; @276
end


// &CombBeg; @284
always @( dp_fence_id_inst[31:0])
begin
  fence_inst1_fence_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst1_fence_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];
  fence_inst1_fence_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU;
  fence_inst1_fence_data[IR_SRC0_VLD]                 = 1'b0;
  fence_inst1_fence_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0,dp_fence_id_inst[9:5]};
  fence_inst1_fence_data[IR_SRC1_VLD]                 = 1'b0;
  fence_inst1_fence_data[IR_SRC1_REG:IR_SRC1_REG-5]   = {1'b0,dp_fence_id_inst[4:0]};
  fence_inst1_fence_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @297
end

//----------------------------------------------------------
//                  ertn/idle Instuction
//----------------------------------------------------------
// &CombBeg; @213
always @( dp_fence_id_inst[31:0])
begin
  fence_inst0_cp0_ret_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_cp0_ret_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];
  fence_inst0_cp0_ret_data[IR_INST_TYPE:IR_INST_TYPE-9] = SPECIAL;
  fence_inst0_cp0_ret_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @220
end

//----------------------------------------------------------
//                  cpucfg Instuction
//----------------------------------------------------------
// &CombBeg; @213

wire fence_inst_cp0_cpucfg;

assign fence_inst_cp0_cpucfg = (dp_fence_id_inst[31:10] == 22'b00000000000000000_11011);

always @( dp_fence_id_inst[31:0])
begin
  fence_inst0_cp0_cpucfg_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_cp0_cpucfg_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];
  fence_inst0_cp0_cpucfg_data[IR_INST_TYPE:IR_INST_TYPE-9] = SPECIAL;
  fence_inst0_cp0_cpucfg_data[IR_SRC0_VLD]                 = 1'b1;
  fence_inst0_cp0_cpucfg_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0, dp_fence_id_inst[9:5]};
  fence_inst0_cp0_cpucfg_data[IR_DST_VLD]                  = 1'b1;
  fence_inst0_cp0_cpucfg_data[IR_DST_REG:IR_DST_REG-5]     = {1'b0, dp_fence_id_inst[4:0]};
  fence_inst0_cp0_cpucfg_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @220
end


//----------------------------------------------------------
//                  iocsr Instuction
//----------------------------------------------------------
// &CombBeg; @213

wire fence_inst_cp0_iocsr;
wire fence_inst_cp0_iocsrrd;
wire fence_inst_cp0_iocsrwr;

assign fence_inst_cp0_iocsrrd = (dp_fence_id_inst[31:12] == 20'b00000110010010000_000);
assign fence_inst_cp0_iocsrwr = (dp_fence_id_inst[31:12] == 20'b00000110010010000_001);
assign fence_inst_cp0_iocsr = fence_inst_cp0_iocsrrd || fence_inst_cp0_iocsrwr;

always @( dp_fence_id_inst[31:0])
begin
  fence_inst0_cp0_iocsr_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  fence_inst0_cp0_iocsr_data[IR_OPCODE:IR_OPCODE-31]      = dp_fence_id_inst[31:0];
  fence_inst0_cp0_iocsr_data[IR_INST_TYPE:IR_INST_TYPE-9] = SPECIAL;
  fence_inst0_cp0_iocsr_data[IR_SRC0_VLD]                 = 1'b1;
  fence_inst0_cp0_iocsr_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0, dp_fence_id_inst[9:5]};
  fence_inst0_cp0_iocsr_data[IR_SRC1_VLD]                 = fence_inst_cp0_iocsrwr;
  fence_inst0_cp0_iocsr_data[IR_SRC1_REG:IR_SRC1_REG-5]   = {1'b0, dp_fence_id_inst[4:0]};
  fence_inst0_cp0_iocsr_data[IR_DST_VLD]                  = fence_inst_cp0_iocsrrd;
  fence_inst0_cp0_iocsr_data[IR_DST_REG:IR_DST_REG-5]     = {1'b0, dp_fence_id_inst[4:0]};
  fence_inst0_cp0_iocsr_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @220
end


assign fence_and_cpucfg_inst = fence_inst_cp0_cpucfg || 
                               fence_invtlb_inst || 
                               fence_tlbop_inst || 
                               fence_inst_cp0_iocsr;


//==========================================================
//               Fence Instructions Selection
//==========================================================
//----------------------------------------------------------
//              MUX between fence instructions
//----------------------------------------------------------
// &CombBeg; @305
always @( fence_inst0_cp0_data[177:0]
       or fence_inst0_sync_data[177:0]
       or fence_inst0_invtlb_data[177:0]
       or fence_inst0_tlbop_data[177:0]
       or fence_inst0_fence_data[177:0]
       or fence_inst0_cp0_ret_data[177:0]
       or fence_inst0_cp0_csr_data[177:0]
       or fence_inst0_cp0_cpucfg_data[177:0]
       or fence_inst0_cp0_iocsr_data[177:0]
       or dp_fence_id_fence_type[2:0]
       or fence_invtlb_inst
       or fence_inst0_cp0_csr1r
       or fence_inst0_cp0_csr2r
       or fence_and_cpucfg_inst
       or fence_inst_cp0_iocsr
       )
begin
  case({dp_fence_id_fence_type[2:0], fence_inst0_cp0_csr1r, fence_inst0_cp0_csr2r, fence_and_cpucfg_inst})
    /// ibar, dbar, dcache
    6'b001000 : fence_inst0_data[IR_WIDTH-1:0] = fence_inst0_sync_data[IR_WIDTH-1:0];
    
    /// invtlb
    6'b001001 : fence_inst0_data[IR_WIDTH-1:0] = fence_invtlb_inst
                                                 ? fence_inst0_invtlb_data[IR_WIDTH-1:0]
                                                 : fence_inst0_tlbop_data[IR_WIDTH-1:0];
    
    /// csr
    6'b010100 : fence_inst0_data[IR_WIDTH-1:0] = fence_inst0_cp0_csr1r 
                                                  ? fence_inst0_cp0_data[IR_WIDTH-1:0]
                                                  : fence_inst0_cp0_ret_data[IR_WIDTH-1:0];
    /// cpucfg
    6'b010001 : fence_inst0_data[IR_WIDTH-1:0] = fence_inst_cp0_iocsr
                                                  ? fence_inst0_cp0_iocsr_data[IR_WIDTH-1:0]
                                                  : fence_inst0_cp0_cpucfg_data[IR_WIDTH-1:0];
    
    /// ertn/idle
    6'b010000 : fence_inst0_data[IR_WIDTH-1:0] = fence_inst0_cp0_ret_data[IR_WIDTH-1:0];
    
    /// csr xchg                                          
    6'b100010 : fence_inst0_data[IR_WIDTH-1:0] = fence_inst0_cp0_csr2r 
                                                  ? fence_inst0_cp0_csr_data[IR_WIDTH-1:0]
                                                  : {IR_WIDTH{1'b0}};
    default: fence_inst0_data[IR_WIDTH-1:0]    = {IR_WIDTH{1'bx}};
  endcase
// &CombEnd; @312
end

// TODO:
assign fence_inst1_data[IR_WIDTH-1:0] = fence_inst1_fence_data[IR_WIDTH-1:0];

// TODO:
assign fence_inst2_data[IR_WIDTH-1:0] = fence_inst2_cp0_csr_data[IR_WIDTH-1:0];
//fence no inst2/3

//----------------------------------------------------------
//             Re-Pack into IR data path form
//----------------------------------------------------------
// &CombBeg; @322
always @( dp_fence_id_pc[14:0]
       or dp_fence_id_bkpta_inst
       or dp_fence_id_vl_pred
       or dp_fence_id_bkptb_inst
       or dp_fence_id_vl[7:0]
       or dp_fence_id_vlmul[1:0]
       or dp_fence_id_vsew[2:0]
       or fence_inst0_data[177:0])
begin
  fence_dp_inst0_data[IR_WIDTH-1:0]              = fence_inst0_data[IR_WIDTH-1:0];
  if(1'b1) begin
  fence_dp_inst0_data[IR_DST_X0]                 = (fence_inst0_data[IR_DST_REG:IR_DST_REG-5]
                                                   == 6'd0);
  fence_dp_inst0_data[IR_BKPTB_INST]             = dp_fence_id_bkptb_inst;
  fence_dp_inst0_data[IR_BKPTA_INST]             = dp_fence_id_bkpta_inst;
  fence_dp_inst0_data[IR_VLMUL:IR_VLMUL-1]       = dp_fence_id_vlmul[1:0];
  fence_dp_inst0_data[IR_VSEW:IR_VSEW-2]         = dp_fence_id_vsew[2:0];
  fence_dp_inst0_data[IR_VL:IR_VL-7]             = dp_fence_id_vl[7:0];
  fence_dp_inst0_data[IR_VL_PRED]                = dp_fence_id_vl_pred;
  fence_dp_inst0_data[IR_PC:IR_PC-14]            = dp_fence_id_pc[14:0];
  end
// &CombEnd; @335
end

// &CombBeg; @337
always @( fence_inst1_data[177:0]
       or dp_fence_id_pc[14:0]
       or dp_fence_id_vl_pred
       or dp_fence_id_bkpta_inst
       or dp_fence_id_bkptb_inst
       or dp_fence_id_vlmul[1:0]
       or dp_fence_id_vl[7:0]
       or dp_fence_id_vsew[2:0])
begin
  fence_dp_inst1_data[IR_WIDTH-1:0]              = fence_inst1_data[IR_WIDTH-1:0];
  if(1'b1) begin
  fence_dp_inst1_data[IR_DST_X0]                 = (fence_inst1_data[IR_DST_REG:IR_DST_REG-5]
                                                   == 6'd0);
  fence_dp_inst1_data[IR_BKPTB_INST]             = dp_fence_id_bkptb_inst;
  fence_dp_inst1_data[IR_BKPTA_INST]             = dp_fence_id_bkpta_inst;
  fence_dp_inst1_data[IR_VLMUL:IR_VLMUL-1]       = dp_fence_id_vlmul[1:0];
  fence_dp_inst1_data[IR_VSEW:IR_VSEW-2]         = dp_fence_id_vsew[2:0];
  fence_dp_inst1_data[IR_VL:IR_VL-7]             = dp_fence_id_vl[7:0];
  fence_dp_inst1_data[IR_VL_PRED]                = dp_fence_id_vl_pred;
  fence_dp_inst1_data[IR_PC:IR_PC-14]            = dp_fence_id_pc[14:0];
  end
// &CombEnd; @350
end

// &CombBeg; @352
always @( fence_inst2_data[177:0]
       or dp_fence_id_pc[14:0]
       or dp_fence_id_vl_pred
       or dp_fence_id_bkpta_inst
       or dp_fence_id_bkptb_inst
       or dp_fence_id_vlmul[1:0]
       or dp_fence_id_vl[7:0]
       or dp_fence_id_vsew[2:0])
begin
  fence_dp_inst2_data[IR_WIDTH-1:0]              = fence_inst2_data[IR_WIDTH-1:0];
  if(1'b1) begin
  fence_dp_inst2_data[IR_DST_X0]                 = (fence_inst2_data[IR_DST_REG:IR_DST_REG-5]
                                                   == 6'd0);
  fence_dp_inst2_data[IR_BKPTB_INST]             = dp_fence_id_bkptb_inst;
  fence_dp_inst2_data[IR_BKPTA_INST]             = dp_fence_id_bkpta_inst;
  fence_dp_inst2_data[IR_VLMUL:IR_VLMUL-1]       = dp_fence_id_vlmul[1:0];
  fence_dp_inst2_data[IR_VSEW:IR_VSEW-2]         = dp_fence_id_vsew[2:0];
  fence_dp_inst2_data[IR_VL:IR_VL-7]             = dp_fence_id_vl[7:0];
  fence_dp_inst2_data[IR_VL_PRED]                = dp_fence_id_vl_pred;
  fence_dp_inst2_data[IR_PC:IR_PC-14]            = dp_fence_id_pc[14:0];
  end
// &CombEnd; @365
end


// &ModuleEnd; @368
endmodule


