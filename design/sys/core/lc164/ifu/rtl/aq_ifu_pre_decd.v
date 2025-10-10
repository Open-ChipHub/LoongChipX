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
module aq_ifu_pre_decd (
  // &Ports, @24
  input    wire  [31:0]  ipack_pred_inst0,
  input    wire          ipack_pred_inst0_vld,
  output   wire          pred_br_vld0,
  output   wire  [39:0]  pred_imm0,
  output   wire          pred_inst0_32,
  output   wire          pred_jmp_vld0,
  output   wire          pred_link_vld0,
  output   wire          pred_ret_vld0
); 



// &Regs; @25
// &Wires; @26
wire    [39:0]  btype_imm;           
wire            btype_vld;           
wire    [39:0]  cbtype_imm0;         
wire            cbtype_vld0;         
wire            cjlrtype_vld0;       
wire            cjltype_vld0;        
wire            cjrtype_vld0;        
wire    [39:0]  cjtype_imm0;         
wire            cjtype_vld0;         
wire    [31:0]  inst0;               
wire    [39:0]  inst0_imm;           
wire            jlrtype_vld;         
wire            jltype_vld;          
wire            jrtype_vld;          
wire    [39:0]  jtype_imm;           
wire            jtype_vld;           


//==========================================================
// Pre-Decode Module
// 1. First Inst Decode
// 2. Second Inst Decode
//==========================================================

//------------------------------------------------
// 1. First Inst Decode
// a. 32-bit Decode, Branch, Jal and Jalr X1
// b. 16-bit Decode, Branch, Jal and Jalr X1
//------------------------------------------------

assign inst0[31:0] = ipack_pred_inst0[31:0];

// a. 32-bit Decode, Jal, Branch and Jalr X1

// B-Type: BEQ BNE BLT BGE BLTU BGEU

wire  br_bz            = (inst0[31:26] == 6'b010000) || // beqz
                         (inst0[31:26] == 6'b010001) || // bnez
                         ({inst0[31:26], inst0[9:8]} == 8'b010010_00) || // bceqz
                         ({inst0[31:26], inst0[9:8]} == 8'b010010_01) || // bcnez
                         (inst0[31:26] == 6'b010000) || // beqz
                         (inst0[31:26] == 6'b010001);   // bnez

wire br_n_bz           = (inst0[31:26] == 6'b010110) || // beq
                         (inst0[31:26] == 6'b010111) || // bne
                         (inst0[31:26] == 6'b011000) || // blt
                         (inst0[31:26] == 6'b011001) || // bgt
                         (inst0[31:26] == 6'b011010) || // bltu
                         (inst0[31:26] == 6'b011011);   // bgeu

assign btype_vld       = br_bz || br_n_bz;

assign btype_imm[39:0] = {40{br_bz  }} & {{17{inst0[4]}}, inst0[4:0], inst0[25:10], 2'b0} |
                         {40{br_n_bz}} & {{22{inst0[25]}}, inst0[25:10], 2'b0};


wire jump_jir          = (inst0[31:26] == 6'b010011)  && (inst0[4:0] != 5'b00001);
wire jump_call         = (inst0[31:26] == 6'b010011) && (inst0[4:0] == 5'b00001);
wire jump_b            = (inst0[31:26] == 6'b010100); // b
wire jump_bl           = (inst0[31:26] == 6'b010101); // bl
wire jump_ret          = (inst0[31:26] == 6'b010011) && (inst0[9:5] == 5'b00001)
                         && (inst0[4:0] != 5'b00001); // ret

// J-Type: JAL
assign jtype_vld       = jump_b  || // b
                         jump_bl;   // bl

assign jtype_imm[39:0] = {{12{inst0[9]}}, inst0[9:0], inst0[25:10], 2'b0};


// Jr-Type: JALR X1
assign jrtype_vld      = jump_ret;

// TODO: JALR JL
assign jltype_vld      = jump_bl;

assign jlrtype_vld     = jump_call;

// b. 16-bit Decode, Branch, Jal and Jalr X1

// CB-Type: C.BEQZ C.BNEZ
assign cbtype_vld0       = 1'b0;
assign cbtype_imm0[39:0] = '0; 

// CJ-Type: C.J ///C.JAL removed
assign cjtype_vld0       = 1'b0;
assign cjtype_imm0[39:0] = '0;

// CJr-Type: 
assign cjrtype_vld0      = 1'b0;

// Imm for Inst0
assign inst0_imm[39:0]   = {40{btype_vld}} & btype_imm[39:0] |
                           {40{jtype_vld}} & jtype_imm[39:0];

// TODO
assign cjltype_vld0      = 1'b0;
assign cjlrtype_vld0     = 1'b0;


//==========================================================
// Rename for Output
//==========================================================

// Output to id prediction
assign pred_br_vld0    = ipack_pred_inst0_vld && (btype_vld || cbtype_vld0);
assign pred_jmp_vld0   = ipack_pred_inst0_vld && (jtype_vld || cjtype_vld0);
assign pred_link_vld0  = ipack_pred_inst0_vld && (jltype_vld || jlrtype_vld || cjltype_vld0 || cjlrtype_vld0);
assign pred_ret_vld0   = ipack_pred_inst0_vld && (jrtype_vld || cjrtype_vld0);
assign pred_imm0[39:0] = inst0_imm[39:0];
assign pred_inst0_32   = 1'b1;

// &ModuleEnd; @146
endmodule


