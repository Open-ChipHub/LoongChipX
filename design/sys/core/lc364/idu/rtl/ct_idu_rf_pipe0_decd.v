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
module ct_idu_rf_pipe0_decd (
  // &Ports, @28
  input    wire          pipe0_decd_expt_vld,
  input    wire  [31:0]  pipe0_decd_opcode,
  output   reg   [3 :0]  pipe0_decd_eu_sel,
  output   reg   [4 :0]  pipe0_decd_func,
  output   wire  [5 :0]  pipe0_decd_imm,
  output   reg   [20:0]  pipe0_decd_sel,
  output   reg   [63:0]  pipe0_decd_src1_imm,
  output   reg   [63:0]  pipe0_decd_inst_sel
); 



// &Regs; @29
reg     [3 :0]  decd_16_eu_sel;     
reg     [4 :0]  decd_16_func;       
reg     [20:0]  decd_16_sel;        
reg     [3 :0]  decd_32_eu_sel;     
reg     [4 :0]  decd_32_func;       
reg     [20:0]  decd_32_sel;        
reg     [63:0]  decd_32_inst_sel; 

// &Wires; @30
wire    [9 :0]  decd_caddi4spn_imm; 
wire    [9 :0]  decd_caddisp_imm;   
wire            decd_expt_vld;      
wire    [5 :0]  decd_ext_offset;    
wire    [4 :0]  decd_imm_sel;       
wire    [31:0]  decd_op;            



//==========================================================
//                    Rename Input
//==========================================================
assign decd_op[31:0] = pipe0_decd_opcode[31:0];
assign decd_expt_vld = pipe0_decd_expt_vld;

//==========================================================
//                       Immediate
//==========================================================
//----------------------------------------------------------
//                   Immediate Selection
//----------------------------------------------------------
// imm12
assign decd_imm_sel[0] = (decd_op[31:25] == 7'b0000001);

// imm16 
assign decd_imm_sel[1] = (decd_op[31:26] == 6'b000100); // addu16i.d

// imm20 
assign decd_imm_sel[2] = (decd_op[31:25] == 7'b0001010) || // lu12i.w
                         (decd_op[31:25] == 7'b0001011) || // lu32i.d
                         (decd_op[31:25] == 7'b0001100) || // pcaddi
                         (decd_op[31:25] == 7'b0001101) || // pcalau12i
                         (decd_op[31:25] == 7'b0001110) || // pcaddu12i
                         (decd_op[31:25] == 7'b0001111);   // pcaddu18i

// reserved
assign decd_imm_sel[3]   = 1'b0;
//16 bit caddi4spn
assign decd_imm_sel[4]   = 1'b0;

//----------------------------------------------------------
//                   Source 1 immediate
//----------------------------------------------------------

// &CombBeg; @72
always @( decd_op[31:0]
       or decd_imm_sel[4:0])
begin
  case(decd_imm_sel[4:0])
    5'h01  : pipe0_decd_src1_imm[63:0] = {52'b0, decd_op[21:10]};
    5'h02  : pipe0_decd_src1_imm[63:0] = {48'b0, decd_op[25:10]};
    5'h04  : pipe0_decd_src1_imm[63:0] = {44'b0, decd_op[24:5]};
    default: pipe0_decd_src1_imm[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @83
end

//----------------------------------------------------------
//                     Source immediate
//----------------------------------------------------------
assign decd_ext_offset[5:0] = decd_op[31:26] - decd_op[25:20];

assign pipe0_decd_imm[5:0]  = decd_op[13] ? decd_ext_offset[5:0]
                                          : {4'b0,decd_op[26:25]};

//==========================================================
//      Full Decoder for function and operand prepare
//==========================================================
//----------------------------------------------------------
//                Execution Units Define
//----------------------------------------------------------
parameter EU_WIDTH              = 4;

parameter ALU                   = 4'b0001;
parameter DIV                   = 4'b0010;
parameter SPECIAL               = 4'b0100;
parameter CP0                   = 4'b1000;

parameter ALU_SEL               = 21;

parameter NON_ALU               = 21'h0;

parameter ADDER_ADD             = 21'h000001;
parameter ADDER_ADDW            = 21'h000002;
parameter ADDER_SUB             = 21'h000004;
parameter ADDER_SUBW            = 21'h000008;
parameter ADDER_SLT             = 21'h000010;
parameter SHIFTER_SL            = 21'h000020;
parameter SHIFTER_SR            = 21'h000040;
parameter SHIFTER_SLW           = 21'h000080;
parameter SHIFTER_SRW           = 21'h000100;
parameter SHIFTER_EXT           = 21'h000200;

parameter LOGIC_AND             = 21'h000400;
parameter LOGIC_OR              = 21'h000800;
parameter LOGIC_XOR             = 21'h001000;
parameter LOGIC_LUI             = 21'h002000;
parameter LOGIC_CLI             = 21'h004000;

parameter MISC_MV               = 21'h008000;

parameter MISC_BPICK            = 21'h008001;
parameter MISC_SLT              = 21'h008002;
parameter MISC_MASK             = 21'h008004;
parameter MISC_MV0              = 21'h008008;
parameter MISC_MV1              = 21'h008010;
parameter MISC_MV2              = 21'h008020;
parameter MISC_MV3              = 21'h008040;

parameter MISC_RESERVERD        = 21'h008080;
parameter MISC_FPU              = 21'h008100;

parameter MISC_TSTNBZ           = 21'h010000;
parameter MISC_TST              = 21'h020000;
parameter MISC_FF1              = 21'h040000;
parameter MISC_REV              = 21'h080000;
parameter MISC_REVW             = 21'h100000;

parameter ADDER_MAX             = 21'h01;
parameter ADDER_MAXW            = 21'h02;
parameter ADDER_MIN             = 21'h04;
parameter ADDER_MINW            = 21'h08;
parameter ADDER_ADDSL           = 21'h20;

parameter SPECIAL_ECALL         = 5'b00010;
parameter SPECIAL_EBREAK        = 5'b00011;
parameter SPECIAL_AUIPC         = 5'b00100;
parameter SPECIAL_PSEUDO_AUIPC  = 5'b00101;
parameter SPECIAL_VSETVLI       = 5'b00110;
parameter SPECIAL_VSETVL        = 5'b00111;

parameter ALU_FN_SUBCODE_SEL_W  = 5'b000_00;
parameter ALU_FN_SUBCODE_SEL_WU = 5'b000_01;
parameter ALU_FN_SUBCODE_SEL_D  = 5'b000_10;
parameter ALU_FN_SUBCODE_SEL_B  = 5'b000_11;
parameter ALU_FN_SUBCODE_SEL_H  = 5'b001_00;

parameter ALU_OPCODE_NUM        = 64;
parameter ALU_OPCODE_ALSL       = 64'd0;
parameter ALU_OPCODE_BYTEPICK   = 64'd1;
parameter ALU_OPCODE_ADD        = 64'd2;
parameter ALU_OPCODE_SUB        = 64'd3;
parameter ALU_OPCODE_SLT        = 64'd4;
parameter ALU_OPCODE_SLTU       = 64'd5;
parameter ALU_OPCODE_MASKEQZ    = 64'd6;
parameter ALU_OPCODE_MASKNEZ    = 64'd7;
parameter ALU_OPCODE_NOR        = 64'd8;
parameter ALU_OPCODE_AND        = 64'd9;
parameter ALU_OPCODE_OR         = 64'd10;
parameter ALU_OPCODE_XOR        = 64'd11;
parameter ALU_OPCODE_ORN        = 64'd12;
parameter ALU_OPCODE_ANDN       = 64'd13;
parameter ALU_OPCODE_SLL        = 64'd14;
parameter ALU_OPCODE_SRL        = 64'd15;
parameter ALU_OPCODE_SRA        = 64'd16;
parameter ALU_OPCODE_ROTR       = 64'd17;
parameter ALU_OPCODE_ADC        = 64'd18;
parameter ALU_OPCODE_SBC        = 64'd19;
parameter ALU_OPCODE_CLO        = 64'd20;
parameter ALU_OPCODE_CLZ        = 64'd21;
parameter ALU_OPCODE_CTO        = 64'd22;
parameter ALU_OPCODE_CTZ        = 64'd23;
parameter ALU_OPCODE_REV        = 64'd24;
parameter ALU_OPCODE_BITREV     = 64'd25;
parameter ALU_OPCODE_EXT        = 64'd26;
parameter ALU_OPCODE_SLLI       = 64'd27;
parameter ALU_OPCODE_SRLI       = 64'd28;
parameter ALU_OPCODE_SRAI       = 64'd29;
parameter ALU_OPCODE_ROTRI      = 64'd30;
parameter ALU_OPCODE_BSTRINS    = 64'd31;
parameter ALU_OPCODE_BSTRPICK   = 64'd32;
parameter ALU_OPCODE_SLTI       = 64'd33;
parameter ALU_OPCODE_SLTUI      = 64'd34;
parameter ALU_OPCODE_ADDI       = 64'd35;
parameter ALU_OPCODE_LU52I      = 64'd36;
parameter ALU_OPCODE_ANDI       = 64'd37;
parameter ALU_OPCODE_ORI        = 64'd38;
parameter ALU_OPCODE_XORI       = 64'd39;
parameter ALU_OPCODE_ADDU16I    = 64'd40;
parameter ALU_OPCODE_LU12I      = 64'd41;
parameter ALU_OPCODE_LU32I      = 64'd42;
parameter ALU_OPCODE_ASRTLE     = 64'd43;
parameter ALU_OPCODE_ASRTGE     = 64'd44;
parameter ALU_OPCODE_CPUFG      = 64'd45;
parameter ALU_OPCODE_RDTIME     = 64'd46;
parameter ALU_OPCODE_PCADDI     = 64'd47;
parameter ALU_OPCODE_PCALAU12I  = 64'd48;
parameter ALU_OPCODE_PCADDU12I  = 64'd49;
parameter ALU_OPCODE_PCADDU18I  = 64'd50;
parameter ALU_OPCODE_CRC        = 64'd51;
parameter ALU_OPCODE_CRCC       = 64'd52;
parameter ALU_OPCODE_RCRI       = 64'd53;
parameter ALU_OPCODE_DIV        = 64'd54;
parameter ALU_OPCODE_MOD        = 64'd55;
parameter ALU_OPCODE_MULT       = 64'd56;
parameter ALU_OPCODE_SPECIAL    = 64'd57;

parameter ALU_OPCODE_MVW        = 64'd58;
parameter ALU_OPCODE_MVD        = 64'd59;
parameter ALU_OPCODE_MVGF       = 64'd60;


parameter SPECIAL_NOP           = 5'b00000;
parameter SPECIAL_CPUFG         = 5'b00010;
parameter SPECIAL_RDTIMEL       = 5'b00011;
parameter SPECIAL_RDTIMEH       = 5'b00100;
parameter SPECIAL_RDTIMED       = 5'b00101;
parameter SPECIAL_PCADDI        = 5'b00110;
parameter SPECIAL_PCALAU12I     = 5'b00111;
parameter SPECIAL_PCADDU12I     = 5'b01000;
parameter SPECIAL_PCADDU18I     = 5'b01001;
parameter SPECIAL_BREAK         = 5'b01010;
parameter SPECIAL_DBGCALL       = 5'b01011;
parameter SPECIAL_SYSCALL       = 5'b01100;
parameter SPECIAL_HYPCALL       = 5'b01101;
parameter SPECIAL_ASRTLE        = 5'b01110;
parameter SPECIAL_ASRTGT        = 5'b01111;


//----------------------------------------------------------
//                  Rename for Output
//----------------------------------------------------------
// &CombBeg; @149
always @( decd_32_eu_sel[EU_WIDTH-1:0]
       or decd_32_func[4:0]
       or decd_expt_vld
       or decd_32_sel[ALU_SEL-1:0]
       or decd_32_inst_sel[ALU_OPCODE_NUM-1:0])
begin
  if(decd_expt_vld) begin
    pipe0_decd_eu_sel[EU_WIDTH-1:0] = SPECIAL;
    pipe0_decd_func[4:0]            = SPECIAL_NOP;
    pipe0_decd_sel[ALU_SEL-1:0]     = NON_ALU;
    pipe0_decd_inst_sel[ALU_OPCODE_NUM-1:0] = 64'b0;
  end
  else begin
    pipe0_decd_eu_sel[EU_WIDTH-1:0] = decd_32_eu_sel[EU_WIDTH-1:0];
    pipe0_decd_func[4:0]            = decd_32_func[4:0];
    pipe0_decd_sel[ALU_SEL-1:0]     = decd_32_sel[ALU_SEL-1:0];
    pipe0_decd_inst_sel[ALU_OPCODE_NUM-1:0] = decd_32_inst_sel[ALU_OPCODE_NUM-1:0];
  end
// &CombEnd; @165
end


//----------------------------------------------------------
//                   32 bits Full Decoder
//----------------------------------------------------------
// &CombBeg; @276
always @( decd_op[31:15]
       or decd_op[14:10]
       or decd_op[9 :5])
begin
  //initialize decoded information value
  decd_32_eu_sel[EU_WIDTH-1:0]           = 4'b0;
  decd_32_func[4:0]                      = 5'b0;
  decd_32_sel[ALU_SEL-1:0]               = 21'b0;
  decd_32_inst_sel[ALU_OPCODE_NUM-1 : 0] = 64'b0;
  casez({decd_op[31:15], decd_op[14:10]})
    22'b000000000000010??_????? :begin //alsl.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_ADD;
      decd_32_inst_sel[ALU_OPCODE_ALSL]  = 1'b1; 
      end
    22'b000000000000011??_????? :begin //alsl.wu
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_WU;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_ADD;
      decd_32_inst_sel[ALU_OPCODE_ALSL]  = 1'b1;
      end
    22'b000000000010110??_????? :begin //alsl.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_ADD;
      decd_32_inst_sel[ALU_OPCODE_ALSL]  = 1'b1;
      end
    22'b000000000000100??_????? :begin //bytepick.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_BPICK;
      decd_32_inst_sel[ALU_OPCODE_BYTEPICK]  = 1'b1;
      end
    22'b00000000000011???_????? :begin //bytepick.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_BPICK;
      decd_32_inst_sel[ALU_OPCODE_BYTEPICK]  = 1'b1;
      end
    22'b00000000000100000_????? :begin //add.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_ADD;
      decd_32_inst_sel[ALU_OPCODE_ADD]  = 1'b1;
      end
    22'b00000000000100001_????? :begin //add.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_ADD;
      decd_32_inst_sel[ALU_OPCODE_ADD]  = 1'b1;
      end
    22'b00000000000100010_????? :begin //sub.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_SUB;
      decd_32_inst_sel[ALU_OPCODE_SUB]  = 1'b1;
      end
    22'b00000000000100011_????? :begin //sub.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = ADDER_SUB;
      decd_32_inst_sel[ALU_OPCODE_SUB]  = 1'b1;
      end
    22'b00000000000100100_????? :begin //slt
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_SLT;
      decd_32_inst_sel[ALU_OPCODE_SLT]  = 1'b1;
      end
    22'b00000000000100101_????? :begin //sltu
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_SLT;
      decd_32_inst_sel[ALU_OPCODE_SLTU]  = 1'b1;
      end
    22'b00000000000100110_????? :begin //maskeqz
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_MASK;
      decd_32_inst_sel[ALU_OPCODE_MASKEQZ]  = 1'b1;
      end
    22'b00000000000100111_????? :begin //masknez
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_MASK;
      decd_32_inst_sel[ALU_OPCODE_MASKNEZ]  = 1'b1;
      end
    22'b00000000000101000_????? :begin //nor
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = LOGIC_OR;
      decd_32_inst_sel[ALU_OPCODE_NOR]  = 1'b1;
      end
    22'b00000000000101001_????? :begin //and
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = LOGIC_AND;
      decd_32_inst_sel[ALU_OPCODE_AND]  = 1'b1;
      end
    22'b00000000000101010_????? :begin //or
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_OR]  = 1'b1;
      end
    22'b00000000000101011_????? :begin //xor
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_XOR]  = 1'b1;
      end
    22'b00000000000101100_????? :begin //orn
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ORN]  = 1'b1;
      end
    22'b00000000000101101_????? :begin //andn
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ANDN]  = 1'b1;
      end
    22'b00000000000101110_????? :begin //sll.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SLL]  = 1'b1;
      end
    22'b00000000000101111_????? :begin //srl.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRL]  = 1'b1;
      end
    22'b00000000000110000_????? :begin //sra.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRA]  = 1'b1;
      end
    22'b00000000000110001_????? :begin //sll.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SLL]  = 1'b1;
      end
    22'b00000000000110010_????? :begin //srl.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRL]  = 1'b1;
      end
    22'b00000000000110011_????? :begin //sra.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRA]  = 1'b1;
      end
    22'b00000000000110110_????? :begin //rotr.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ROTR]  = 1'b1;
      end
    22'b00000000000110111_????? :begin //rotr.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ROTR]  = 1'b1;
      end
    22'b00000000000000000_00100 :begin //clo.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CLO]  = 1'b1;
      end
    22'b00000000000000000_00101 :begin //clz.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CLZ]  = 1'b1;
      end
    22'b00000000000000000_00110 :begin //cto.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CTO]  = 1'b1;
      end
    22'b00000000000000000_00111 :begin //ctz.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CTZ]  = 1'b1;
      end
    22'b00000000000000000_01000 :begin //clo.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CLO]  = 1'b1;
      end
    22'b00000000000000000_01001 :begin //clz.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CLZ]  = 1'b1;
      end
    22'b00000000000000000_01010 :begin //cto.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CTO]  = 1'b1;
      end
    22'b00000000000000000_01011 :begin //ctz.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CTZ]  = 1'b1;
      end
    22'b00000000000000000_01100 :begin //revb.2h
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_REV]  = 1'b1;
      end
    22'b00000000000000000_01101 :begin //revb.4h
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_REV]  = 1'b1;
      end
    22'b00000000000000000_01110 :begin //revb.2w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_REV]  = 1'b1;
      end
    22'b00000000000000000_01111 :begin //revb.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00011;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_REV]  = 1'b1;
      end
    22'b00000000000000000_10000 :begin //revh.2w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00110;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_REV]  = 1'b1;
      end
    22'b00000000000000000_10001 :begin //revh.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00111;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_REV]  = 1'b1;
      end
    22'b00000000000000000_10010 :begin //bitrev.4b
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BITREV]  = 1'b1;
      end
    22'b00000000000000000_10011 :begin //bitrev.8b
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BITREV]  = 1'b1;
      end
    22'b00000000000000000_10100 :begin //bitrev.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00100;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BITREV]  = 1'b1;
      end
    22'b00000000000000000_10101 :begin //bitrev.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b01000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BITREV]  = 1'b1;
      end
    22'b00000000000000000_10110 :begin //ext.w.h
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_EXT]  = 1'b1;
      end
    22'b00000000000000000_10111 :begin //ext.w.b
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_EXT]  = 1'b1;
      end
    22'b00000000010000001_????? :begin //slli.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SLLI]  = 1'b1;
      end
    22'b0000000001000001?_????? :begin //slli.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SLLI]  = 1'b1;
      end
    22'b00000000010001001_????? :begin //srli.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRLI]  = 1'b1;
      end
    22'b0000000001000101?_????? :begin //srli.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRLI]  = 1'b1;
      end
    22'b00000000010010001_????? :begin //srai.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRAI]  = 1'b1;
      end
    22'b0000000001001001?_????? :begin //srai.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SRAI]  = 1'b1;
      end
    22'b00000000010011001_????? :begin //rotri.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ROTRI]  = 1'b1;
      end
    22'b0000000001001101?_????? :begin //rotri.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ROTRI]  = 1'b1;
      end
    // rd is as src0
    22'b00000000011_?????0_????? :begin //bstrins.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BSTRINS]  = 1'b1;
      end
    22'b00000000011_?????1_????? :begin //bstrpick.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BSTRPICK]  = 1'b1;
      end
    // rd is as src0
    22'b0000000010?_??????_????? :begin //bstrins.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BSTRINS]  = 1'b1;
      end
    22'b0000000011?_??????_????? :begin //bstrpick.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_BSTRPICK]  = 1'b1;
      end

    // 12-offset
    22'b0000001000_???????_????? :begin //slti
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SLTI]  = 1'b1;
      end
    22'b0000001001_???????_????? :begin //sltui
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SLTUI]  = 1'b1;
      end
    22'b0000001010_???????_????? :begin //addi.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ADDI]  = 1'b1;
      end
    22'b0000001011_???????_????? :begin //addi.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ADDI]  = 1'b1;
      end
    22'b0000001100_???????_????? :begin //lu52i.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_LU52I]  = 1'b1;
      end
    22'b0000001101_???????_????? :begin //andi
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ANDI]  = 1'b1;
      end
    22'b0000001110_???????_????? :begin //ori
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ORI]  = 1'b1;
      end
    22'b0000001111_???????_????? :begin //xori
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_XORI]  = 1'b1;
      end
    22'b000100_????_???????_????? :begin //addu16i.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ADDU16I]  = 1'b1;
      end
    22'b0001010_???_???????_????? :begin //lu12i.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_W;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_LU12I]  = 1'b1;
      end
    22'b0001011_???_???????_????? :begin //lu32i.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = ALU_FN_SUBCODE_SEL_D;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_LU32I]  = 1'b1;
      end


//----------------------------------------------------------
//                        ALU (SPECIAL)
//----------------------------------------------------------        
    22'b00000000000000000_11000 :begin //rdtimel.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_RDTIMEL;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_RDTIME]  = 1'b1;
      end
    22'b00000000000000000_11001 :begin //rdtimeh.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_RDTIMEH;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_RDTIME]  = 1'b1;
      end
    22'b00000000000000000_11010 :begin //rdtime.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_RDTIMED;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_RDTIME]  = 1'b1;
      end

    22'b00000000000000010_????? :begin //asrtle.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_ASRTLE;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ASRTLE]  = 1'b1;
      end
    22'b00000000000000011_????? :begin //asrtgt.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_ASRTGT;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_ASRTGE]  = 1'b1;
      end

    22'b0001100_??????????????? :begin //pcaddi
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_PCADDI;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_PCADDI]  = 1'b1;
      end
    22'b0001101_??????????????? :begin //pcalau12i
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_PCALAU12I;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_PCALAU12I]  = 1'b1;
      end
    22'b0001110_??????????????? :begin //pcaddu12i
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_PCADDU12I;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_PCADDU12I]  = 1'b1;
      end
    22'b0001111_??????????????? :begin //pcaddu18i
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_PCADDU18I;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_PCADDU18I]  = 1'b1;
      end

    22'b00000000001010100_????? :begin // break
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_BREAK;
      decd_32_inst_sel[ALU_OPCODE_PCADDU18I]  = 1'b1;
      end
    22'b00000000001010101_????? :begin // decl
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_DBGCALL;
      decd_32_inst_sel[ALU_OPCODE_PCADDU18I]  = 1'b1;
      end
    22'b00000000001010110_????? :begin //syscall
      decd_32_eu_sel[EU_WIDTH-1:0]    = SPECIAL;
      decd_32_func[4:0]               = SPECIAL_SYSCALL;
      decd_32_inst_sel[ALU_OPCODE_PCADDU18I]  = 1'b1;
      end

//----------------------------------------------------------
//                        ALU(CRC)
//---------------------------------------------------------- 
    22'b00000000001001000_????? :begin //crc.w.b.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRC]  = 1'b1;
      end
    22'b00000000001001001_????? :begin //crc.w.h.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRC]  = 1'b1;
      end
    22'b00000000001001010_????? :begin //crc.w.w.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRC]  = 1'b1;
      end
    22'b00000000001001011_????? :begin //crc.w.d.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00011;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRC]  = 1'b1;
      end
    22'b00000000001001100_????? :begin //crcc.w.b.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00100;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRCC]  = 1'b1;
      end
    22'b00000000001001101_????? :begin //crcc.w.h.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00101;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRCC]  = 1'b1;
      end
    22'b00000000001001110_????? :begin //crcc.w.w.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00110;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRCC]  = 1'b1;
      end
    22'b00000000001001111_????? :begin //crcc.w.d.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00111;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_CRCC]  = 1'b1;
      end 

//----------------------------------------------------------
//                        DIV
//---------------------------------------------------------- 
    22'b00000000001000000_????? :begin //div.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b00111;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_DIV]  = 1'b1;
      end
    22'b00000000001000001_????? :begin //mod.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b01011;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_MOD]  = 1'b1;
      end
    22'b00000000001000010_????? :begin //div.wu
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b00110;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_DIV]  = 1'b1;
      end
    22'b00000000001000011_????? :begin //mod.wu
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b01010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_MOD]  = 1'b1;
      end
    22'b00000000001000100_????? :begin //div.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b00101;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_DIV]  = 1'b1;
      end
    22'b00000000001000101_????? :begin //mod.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b01001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_MOD]  = 1'b1;
      end
    22'b00000000001000110_????? :begin //div.du
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b00100;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_DIV]  = 1'b1;
      end
    22'b00000000001000111_????? :begin //mod.du
      decd_32_eu_sel[EU_WIDTH-1:0]    = DIV;
      decd_32_func[4:0]               = 5'b01000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_MOD]  = 1'b1;
      end

//----------------------------------------------------------
//                        FPU
//---------------------------------------------------------- 
    22'b00000001000101001_01001: begin  //movgr2fr.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_FPU;
      decd_32_inst_sel[ALU_OPCODE_MVW]  = 1'b1;
      end
    22'b00000001000101001_01010: begin  //movgr2fr.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_FPU;
      decd_32_inst_sel[ALU_OPCODE_MVD]  = 1'b1;
      end
    22'b00000001000101001_10101: begin  //movcf2fr
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_FPU;
      decd_32_inst_sel[ALU_OPCODE_MVD]  = 1'b1;
    end
    22'b0000000100010100110110: begin //movgr2cf
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b01000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_FPU;
      decd_32_inst_sel[ALU_OPCODE_MVGF]  = 1'b1;
    end
    22'b0000000100010100110111: begin //movcf2gr
      decd_32_eu_sel[EU_WIDTH-1:0]    = ALU;
      decd_32_func[4:0]               = 5'b01000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_FPU;
      decd_32_inst_sel[ALU_OPCODE_MVGF]  = 1'b1;
    end


//----------------------------------------------------------
//                        CSR
//---------------------------------------------------------- 
    22'b00000100_?????????_????? :begin
      if (decd_op[9:5] == 5'b00000) begin          // csrrd
        decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
        decd_32_func[4:0]               = 5'b0001;
        decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
        decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
      else if (decd_op[9:5] == 5'b00001) begin     // csrwr
        decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
        decd_32_func[4:0]               = 5'b0010;
        decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
        decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
      else if (decd_op[9:5] != 5'b00000 || decd_op[9:5] != 5'b00001) begin // csrxchg
        decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
        decd_32_func[4:0]               = 5'b0100;
        decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
        decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
    end

    22'b00000001000101001_10000: begin //movgr2fcsr
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b1000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000001000101001_10010: begin //movfcsr2gr
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b1001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end

    22'b00000000000000000_11011 :begin //cpucfg
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end  

    22'b00000110010010001_????? :begin //idle
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end

    22'b00000110010010000_01110 :begin //ertn
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00100;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end

    22'b00000110010010010_????? :begin //cprs
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00100;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end

    22'b00000110010010000_00000 :begin  // iocsrrd.b
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000110010010000_00001 :begin  // iocsrrd.h
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000110010010000_00010 :begin  // iocsrrd.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000110010010000_00011 :begin  // iocsrrd.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00011;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end

    22'b00000110010010000_00100 :begin  // iocsrwr.b
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000110010010000_00101 :begin  // iocsrwr.h
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00001;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000110010010000_00110 :begin  // iocsrwr.w
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00010;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end
    22'b00000110010010000_00111 :begin  // iocsrwr.d
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00011;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
    end

    /// tlb operation
    22'b00000110010010000_01000 :begin  // tlbclr
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
    22'b00000110010010000_01001 :begin  // tlbflush
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
    22'b00000110010010000_01010 :begin  // tlbsrch
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
    22'b00000110010010000_01011 :begin  // tlbrd
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
    22'b00000110010010000_01100 :begin  // tlbwr
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end
    22'b00000110010010000_01101 :begin  // tlbfill
      decd_32_eu_sel[EU_WIDTH-1:0]    = CP0;
      decd_32_func[4:0]               = 5'b00000;
      decd_32_sel[ALU_SEL-1:0]        = MISC_RESERVERD;
      decd_32_inst_sel[ALU_OPCODE_SPECIAL]  = 1'b1;
      end

    default:begin                //invalid instruction
      decd_32_eu_sel[EU_WIDTH-1:0]         = SPECIAL;
      decd_32_func[4:0]                    = SPECIAL_NOP;
      decd_32_sel[ALU_SEL-1:0]             = NON_ALU;
      decd_32_inst_sel[ALU_OPCODE_NUM-1:0]  = '0;
    end
  endcase
// &CombEnd; @675
end

// &ModuleEnd; @677
endmodule


