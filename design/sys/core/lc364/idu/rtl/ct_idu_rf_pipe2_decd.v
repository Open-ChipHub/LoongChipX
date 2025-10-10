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
module ct_idu_rf_pipe2_decd (
  // &Ports, @28
  input    wire  [31:0]  pipe2_decd_opcode,
  output   wire  [7 :0]  pipe2_decd_func,
  output   reg   [27:0]  pipe2_decd_offset,
  output   wire  [63:0]  pipe2_decd_src1_imm
); 



// &Regs; @29
reg     [7 :0]  decd_16_func;       
reg     [7 :0]  decd_32_func;       

// &Wires; @30
wire    [5 :0]  decd_imm_sel;       
wire    [31:0]  decd_op;            



//==========================================================
//                    Rename Input
//==========================================================
assign decd_op[31:0] = pipe2_decd_opcode[31:0];

//==========================================================
//                       Immediate
//==========================================================
//----------------------------------------------------------
//                   Source 1 immediate
//----------------------------------------------------------
assign pipe2_decd_src1_imm[63:0] = 64'b0;


//----------------------------------------------------------
//                    Offset Selection
//----------------------------------------------------------
//32 bit imm16
assign decd_imm_sel[0]   = (decd_op[31:26] == 6'b010011) || // jirl
                           (decd_op[31:26] == 6'b010110) || // beq
                           (decd_op[31:26] == 6'b010111) || // bne
                           (decd_op[31:26] == 6'b011000) || // blt
                           (decd_op[31:26] == 6'b011001) || // bgt
                           (decd_op[31:26] == 6'b011010) || // bltu
                           (decd_op[31:26] == 6'b011011);   // bgeu
//32 bit imm21
assign decd_imm_sel[1]   = (decd_op[31:26] == 6'b010000) || // beqz
                           (decd_op[31:26] == 6'b010001) || // bnez
                           ({decd_op[31:26], decd_op[9:8]} == 8'b010010_00) || // bceqz
                           ({decd_op[31:26], decd_op[9:8]} == 8'b010010_01);   // bcnez

//32 bit imm25
assign decd_imm_sel[2]   = (decd_op[31:26] == 6'b010100) || // b
                           (decd_op[31:26] == 6'b010101);   // bl

assign decd_imm_sel[3]   = 1'b0;
assign decd_imm_sel[4]   = 1'b0;
assign decd_imm_sel[5]   = 1'b0;
//----------------------------------------------------------
//                     Offset immediate
//----------------------------------------------------------
// &CombBeg; @65
always @( decd_op[31:0]
       or decd_imm_sel[5:0])
begin
  case(decd_imm_sel[5:0])
    6'h01  : pipe2_decd_offset[27:0] = {{10{decd_op[25]}}, decd_op[25:10], 2'b0};
    6'h02  : pipe2_decd_offset[27:0] = {{5 {decd_op[4] }}, decd_op[4:0], decd_op[25:10], 2'b0};
    6'h04  : pipe2_decd_offset[27:0] = {decd_op[9:0], decd_op[25:10], 2'b0};
    default: pipe2_decd_offset[27:0] = {28 {1'b0}};
  endcase
// &CombEnd; @84
end

//==========================================================
//      Full Decoder for function and operand prepare
//==========================================================
//----------------------------------------------------------
//                  Rename for Output
//----------------------------------------------------------
assign pipe2_decd_func[7:0]            = decd_32_func[7:0];

parameter  BJU_OP_JIRL         =  8'b10000001;            
parameter  BJU_OP_BEQ          =  8'b00010001;            
parameter  BJU_OP_BNE          =  8'b00010010;            
parameter  BJU_OP_BLT          =  8'b00010011;            
parameter  BJU_OP_BGE          =  8'b00010100;            
parameter  BJU_OP_BLTU         =  8'b00010101;            
parameter  BJU_OP_BGEU         =  8'b00010110;            
parameter  BJU_OP_BEQZ         =  8'b00010111;            
parameter  BJU_OP_BNEZ         =  8'b00011000;            
parameter  BJU_OP_BCEQZ        =  8'b00011001;            
parameter  BJU_OP_BCNEZ        =  8'b00011010;            
parameter  BJU_OP_B            =  8'b01000000;            
parameter  BJU_OP_BL           =  8'b01000001;            
//----------------------------------------------------------
//                   32 bits Full Decoder
//----------------------------------------------------------
// &CombBeg; @121
always @( decd_op[31:15]
       or decd_op[14:10]
       or decd_op[9:8])
begin
  //initialize decoded information value
  casez({decd_op[31:15], decd_op[14:10]})
    //32-bits instructions decode logic
    22'b010110_???????????????? :begin //beq
      decd_32_func[7:0]    = BJU_OP_BEQ;
      end
    22'b010111_???????????????? :begin //bne
      decd_32_func[7:0]    = BJU_OP_BNE;
      end
    22'b011000_???????????????? :begin //blt
      decd_32_func[7:0]    = BJU_OP_BLT;
      end
    22'b011001_???????????????? :begin //bge
      decd_32_func[7:0]    = BJU_OP_BGE;
      end
    22'b011010_???????????????? :begin //bltu
      decd_32_func[7:0]    = BJU_OP_BLTU;
      end
    22'b011011_???????????????? :begin //bgeu
      decd_32_func[7:0]    = BJU_OP_BGEU;
      end
    22'b010000_???????????????? :begin //beqz
      decd_32_func[7:0]    = BJU_OP_BEQZ;
      end
    22'b010001_???????????????? :begin //bnez
      decd_32_func[7:0]    = BJU_OP_BNEZ;
      end
    22'b010010_???????????????? :begin 
      if (decd_op[9:8] == 2'b00) begin //bceqz
        decd_32_func[7:0]  = BJU_OP_BCEQZ;
      end
      else if (decd_op[9:8] == 2'b01) begin //bcnez
        decd_32_func[7:0]  = BJU_OP_BCNEZ;
      end
    end
    22'b010100_???????????????? :begin //b
      decd_32_func[7:0]    = BJU_OP_B;
      end
    22'b010101_???????????????? :begin //bl
      decd_32_func[7:0]    = BJU_OP_BL;
      end
    22'b010011_???????????????? :begin //jirl
      decd_32_func[7:0]    = BJU_OP_JIRL;
      end
    default:               //invalid instruction
      decd_32_func[7:0]    = 8'b0;
  endcase
// &CombEnd; @144
end

// &ModuleEnd; @146
endmodule


