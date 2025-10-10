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

//==========================================================
//                  IDU Config Macros
//==========================================================
`ifdef VLEN_64
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VEC_1_BANK
    `define BANK_NUM 1
  `endif //VEC_DP_64
`endif //VLEN_64

`ifdef VLEN_128
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define BANK_NUM 2
  `endif //VEC_DP_64

  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define BANK_NUM 2
  `endif //VEC_DP_128
`endif //VLEN_128

`ifdef VLEN_256
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
    `define BANK_NUM 4
  `endif //VEC_DP_64

  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
  `endif //VEC_DP_256
`endif //VLEN_256

`ifdef VLEN_512
  `ifdef VEC_DP_64
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
    `define VLEN_BANK4
    `define VLEN_BANK5
    `define VLEN_BANK6
    `define VLEN_BANK7
  `endif //VEC_DP_64

  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
  `endif //VEC_DP_512
`endif //VLEN_512

`ifdef VLEN_1024
  `ifdef VEC_DP_128
    `define VLEN_BANK0
    `define VLEN_BANK1
    `define VLEN_BANK2
    `define VLEN_BANK3
    `define VLEN_BANK4
    `define VLEN_BANK5
    `define VLEN_BANK6
    `define VLEN_BANK7
  `endif //VEC_DP_128
`endif //VLEN_1024

//==========================================================
//                     Execute Units
//==========================================================
//1.the EU_xxx_SEL bit should be one hot within int/fp/vec
//2.[MSB:MSB-1] should be used for FP and VEC one hot sel
//3.int/fp/vec could use same [MSB-2:0] encodings
//4.LSU/VLSU/FLSU should use same one hot bit
//5.[MSB-2:MSB-3] should be used to indicate vec eu groups
//----------------------------------------------------------
//                      EU WIDTH
//----------------------------------------------------------
`define EU_WIDTH           10

//----------------------------------------------------------
//                     Integer EU
//----------------------------------------------------------
`define EU_ALU             10'b0000000001
`define EU_BJU             10'b0000000010
`define EU_MULT            10'b0000000100
`define EU_DIV             10'b0000001000
`define EU_CP0             10'b0000010000
`define EU_LSU             10'b0000100000

`define EU_ALU_SEL         0
`define EU_BJU_SEL         1
`define EU_MULT_SEL        2
`define EU_DIV_SEL         3
`define EU_CP0_SEL         4
`define EU_LSU_SEL         5

//----------------------------------------------------------
//                       FP EU
//----------------------------------------------------------
`define EU_FP_SEL          8

`define EU_FMAU            10'b0100000001
`define EU_FALU            10'b0101000001
`define EU_FCVT            10'b0110000001
`define EU_FSPU            10'b0110000010
`define EU_FDSU            10'b0111000001
`define EU_FLSU            10'b0111100000

`define EU_FLSU_SEL        5

//----------------------------------------------------------
//                     Vector EU
//----------------------------------------------------------
`define EU_VEC_SEL         9
`define EU_VGROUP_SEL      7

`define EU_VFMAU           10'b1000000001
`define EU_VMULU           10'b1000000010
`define EU_VFALU           10'b1001000001
`define EU_VALU            10'b1001000010
`define EU_VREDU           10'b1001000100
`define EU_VFCVT           10'b1010000001
`define EU_VFSPU           10'b1010000010
`define EU_VMISC           10'b1010000100
`define EU_VSHIFT          10'b1010001000
`define EU_VPERMU          10'b1010010000
`define EU_VFDSU           10'b1011000001
`define EU_VDIVU           10'b1011000010
`define EU_VLSU            10'b1011100000

`define EU_VLSU_SEL        5

//==========================================================
//                 Write Back Table Type
//==========================================================
//----------------------------------------------------------
//               Integer Write Back Table
//----------------------------------------------------------
`define WB_INT_WIDTH       `WB_INT_WB_CNT2     + 1

`define WB_INT_WB_CNT2     `WB_INT_CNT         + 1
`define WB_INT_CNT         `WB_INT_TYPE        + 2
`define WB_INT_TYPE        `WB_INT_VLD         + 3
`define WB_INT_VLD                               0

`define WB_INT_TYPE_OTHER                        3'd0
`define WB_INT_TYPE_ALU                          3'd1
`define WB_INT_TYPE_BJU                          3'd2
`define WB_INT_TYPE_MULT                         3'd3
`define WB_INT_TYPE_LSU                          3'd4
`define WB_INT_TYPE_FPU                          3'd5

//----------------------------------------------------------
//                Vector Write Back Table
//----------------------------------------------------------
`define WB_VEC_WIDTH       `WB_VEC_CNT         + 1

`define WB_VEC_CNT         `WB_VEC_TYPE        + 1
`define WB_VEC_TYPE        `WB_VEC_VLD         + 1
`define WB_VEC_VLD                               0

`define WB_VEC_TYPE_OTHER                        1'd0
`define WB_VEC_TYPE_VLSU                         1'd1

//==========================================================
//                   Vector Split Type
//==========================================================
`define VEC_SPLIT_NON                            4'b0
`define VEC_SPLIT_VLD                            4'b1

//==========================================================
//                    ID data path
//==========================================================
`define IDU_WIDTH              `IDU_FUNC                + 1

`define IDU_FUNC               `IDU_EU                  + 20
`define IDU_EU                 `IDU_OPCODE              + 10
`define IDU_OPCODE             `IDU_VEC_SPLIT_TYPE      + 32
`define IDU_VEC_SPLIT_TYPE     `IDU_SPLIT               + 4
`define IDU_SPLIT              `IDU_ILLEGAL_FP          + 1
`define IDU_ILLEGAL_FP         `IDU_ILLEGAL             + 1
`define IDU_ILLEGAL            `IDU_LENGTH              + 1
`define IDU_LENGTH             `IDU_SRC2_IMM            + 1
`define IDU_SRC2_IMM           `IDU_SRC1_IMM            + 64
`define IDU_SRC1_IMM           `IDU_SRC2_IMM_VLD        + 64
`define IDU_SRC2_IMM_VLD       `IDU_SRC1_IMM_VLD        + 1
`define IDU_SRC1_IMM_VLD       `IDU_DSTV_REG            + 1
`define IDU_DSTV_REG           `IDU_SRCV2_REG           + 5
`define IDU_SRCV2_REG          `IDU_SRCV1_REG           + 5
`define IDU_SRCV1_REG          `IDU_SRCV0_REG           + 5
`define IDU_SRCV0_REG          `IDU_DSTC_REG            + 5
`define IDU_DSTC_REG           `IDU_DST1_REG            + 3
`define IDU_DST1_REG           `IDU_DST0_REG            + 6
`define IDU_DST0_REG           `IDU_SRCC_REG            + 6
`define IDU_SRCC_REG           `IDU_SRC2_REG            + 3
`define IDU_SRC2_REG           `IDU_SRC1_REG            + 6
`define IDU_SRC1_REG           `IDU_SRC0_REG            + 6
`define IDU_SRC0_REG           `IDU_DSTV_LATE_VLD       + 6
`define IDU_DSTV_LATE_VLD      `IDU_DSTV_VLD            + 1
`define IDU_DSTV_VLD           `IDU_SRCVM_VLD           + 1
`define IDU_SRCVM_VLD          `IDU_SRCV2_VLD           + 1
`define IDU_SRCV2_VLD          `IDU_SRCV1_VLD           + 1
`define IDU_SRCV1_VLD          `IDU_SRCV0_VLD           + 1
`define IDU_SRCV0_VLD          `IDU_DSTE_VLD            + 1
`define IDU_DSTE_VLD           `IDU_DSTF_VLD            + 1
`define IDU_DSTF_VLD           `IDU_SRCF2_VLD           + 1
`define IDU_SRCF2_VLD          `IDU_SRCF1_VLD           + 1
`define IDU_SRCF1_VLD          `IDU_SRCF0_VLD           + 1
`define IDU_SRCF0_VLD          `IDU_DSTC_VLD            + 1
`define IDU_DSTC_VLD           `IDU_DST1_VLD            + 1
`define IDU_DST1_VLD           `IDU_DST0_VLD            + 1
`define IDU_DST0_VLD           `IDU_SRCC_VLD            + 1
`define IDU_SRCC_VLD           `IDU_SRC2_VLD            + 1
`define IDU_SRC2_VLD           `IDU_SRC1_VLD            + 1
`define IDU_SRC1_VLD           `IDU_SRC0_VLD            + 1
`define IDU_SRC0_VLD                                      0

//==========================================================
//                  Dispatch data path
//==========================================================
//----------------------------------------------------------
//                   Integer Dispatch
//----------------------------------------------------------
`define DIS_INT_WIDTH          `DIS_INT_HINFO_MSB      + 1

`define DIS_INT_HINFO_MSB      `DIS_INT_OPCODE         + `TDT_HINFO_WIDTH
`define DIS_INT_HINFO_LSB      `DIS_INT_OPCODE         + 1
`define DIS_INT_OPCODE         `DIS_INT_FUNC           + 32
`define DIS_INT_FUNC           `DIS_INT_VSEW           + 20
`define DIS_INT_VSEW           `DIS_INT_VLMUL          + 2
`define DIS_INT_VLMUL          `DIS_INT_BHT_PRED       + 2
`define DIS_INT_BHT_PRED       `DIS_INT_EXPT_ILLE_FP   + 2
`define DIS_INT_EXPT_ILLE_FP   `DIS_INT_EXPT_ILLE      + 1
`define DIS_INT_EXPT_ILLE      `DIS_INT_EXPT_HIGH      + 1
`define DIS_INT_EXPT_HIGH      `DIS_INT_EXPT_PAGE      + 1
`define DIS_INT_EXPT_PAGE      `DIS_INT_EXPT_ACC       + 1
`define DIS_INT_EXPT_ACC       `DIS_INT_SPLIT          + 1
`define DIS_INT_SPLIT          `DIS_INT_LENGTH         + 1
`define DIS_INT_LENGTH         `DIS_INT_DST1_REG       + 1
`define DIS_INT_DST1_REG       `DIS_INT_DST0_REG       + 6
`define DIS_INT_DST0_REG       `DIS_INT_SRCC_RDY       + 6
`define DIS_INT_SRCC_RDY       `DIS_INT_SRC2_RDY       + 1
`define DIS_INT_SRC2_RDY       `DIS_INT_SRC1_RDY       + 1
`define DIS_INT_SRC1_RDY       `DIS_INT_SRC0_RDY       + 1
`define DIS_INT_SRC0_RDY       `DIS_INT_SRCC_REG       + 1
`define DIS_INT_SRCC_REG       `DIS_INT_SRC2_REG       + 3
`define DIS_INT_SRC2_REG       `DIS_INT_SRC1_REG       + 6
`define DIS_INT_SRC1_REG       `DIS_INT_SRC0_REG       + 6
`define DIS_INT_SRC0_REG       `DIS_INT_SRCC_DATA      + 6
`define DIS_INT_SRCC_DATA      `DIS_INT_SRC2_DATA      + 1
`define DIS_INT_SRC2_DATA      `DIS_INT_SRC1_DATA      + 64
`define DIS_INT_SRC1_DATA      `DIS_INT_SRC0_DATA      + 64
`define DIS_INT_SRC0_DATA                                63

//----------------------------------------------------------
//                   Vector Dispatch
//----------------------------------------------------------
`define DIS_VEC_WIDTH          `DIS_VEC_FUNC           + 1

`define DIS_VEC_FUNC           `DIS_VEC_EU             + 20
`define DIS_VEC_EU             `DIS_VEC_VSEW           + 10
`define DIS_VEC_VSEW           `DIS_VEC_VLMUL          + 2
`define DIS_VEC_VLMUL          `DIS_VEC_SPLIT_TYPE     + 2
`define DIS_VEC_SPLIT_TYPE     `DIS_VEC_SPLIT          + 4
`define DIS_VEC_SPLIT          `DIS_VEC_DSTV_REG       + 1
`define DIS_VEC_DSTV_REG       `DIS_VEC_SRCVM_REG      + 13
`define DIS_VEC_SRCVM_REG      `DIS_VEC_SRCV2_REG      + 8
`define DIS_VEC_SRCV2_REG      `DIS_VEC_SRCV1_REG      + 13
`define DIS_VEC_SRCV1_REG      `DIS_VEC_SRCV0_REG      + 13
`define DIS_VEC_SRCV0_REG      `DIS_VEC_DSTC_REG       + 13
`define DIS_VEC_DSTC_REG       `DIS_VEC_DSTC_VLD       + 3
`define DIS_VEC_DSTC_VLD       `DIS_VEC_DST0_REG       + 1
`define DIS_VEC_DST0_REG       `DIS_VEC_DST0_VLD       + 6
`define DIS_VEC_DST0_VLD       `DIS_VEC_DSTV_LATE_VLD  + 1
`define DIS_VEC_DSTV_LATE_VLD  `DIS_VEC_DSTV_VLD       + 1
`define DIS_VEC_DSTV_VLD       `DIS_VEC_SRCVM_VLD      + 1
`define DIS_VEC_SRCVM_VLD      `DIS_VEC_SRCV2_VLD      + 1
`define DIS_VEC_SRCV2_VLD      `DIS_VEC_SRCV1_VLD      + 1
`define DIS_VEC_SRCV1_VLD      `DIS_VEC_SRCV0_VLD      + 1
`define DIS_VEC_SRCV0_VLD      `DIS_VEC_DSTE_VLD       + 1
`define DIS_VEC_DSTE_VLD       `DIS_VEC_DSTF_VLD       + 1
`define DIS_VEC_DSTF_VLD       `DIS_VEC_SRCF2_VLD      + 1
`define DIS_VEC_SRCF2_VLD      `DIS_VEC_SRCF1_VLD      + 1
`define DIS_VEC_SRCF1_VLD      `DIS_VEC_SRCF0_VLD      + 1
`define DIS_VEC_SRCF0_VLD      `DIS_VEC_SRC1_DATA      + 1
`define DIS_VEC_SRC1_DATA                                63

//==========================================================
//                      Function
//==========================================================
//----------------------------------------------------------
//                    Width Define
//----------------------------------------------------------
`define FUNC_WIDTH             20

//----------------------------------------------------------
//                   Function Selection
//----------------------------------------------------------
//follow bits are used in IDU to directly select certain bit
//in functions, so these bits should be one hot in its eu
//function encodings
`define FUNC_STORE_SEL         0
`define FUNC_NO_FENCE_SEL      3
`define FUNC_CONDBR_SEL        6
`define FUNC_AUIPC_SEL         7

//----------------------------------------------------------
//                   IU 32 bit Full Decoder
//----------------------------------------------------------
//----------------------------------------------------------
//                   ALU ADDER Decoder
//----------------------------------------------------------
//   FU: 8bit WSEL:3bit  ISEL:9bit  

`define FN_ADDER         8'b0000_0001
`define FN_SHIFT         8'b0000_0010
`define FN_BITOP         8'b0000_0100
`define FN_MUL           8'b0000_0101
`define FN_DIV           8'b0000_0110
`define FN_BJU           8'b0000_1000
`define FN_LSU           8'b0001_0000
`define FN_LSU_A         8'b0001_0001
`define FN_LSU_F         8'b0001_0010
`define FN_LSU_V         8'b0001_0100
`define FN_MISC          8'b0010_0000
`define FN_FPU           8'b0100_0000

`define FWD_B            3'b000
`define FWD_BU           3'b100
`define FWD_H            3'b001
`define FWD_HU           3'b101
`define FWD_W            3'b010
`define FWD_WU           3'b110
`define FWD_D            3'b011
`define FWD_DU           3'b111


//----------------------------------------------------------
//                      ALU Decoder 
//----------------------------------------------------------

`define FUNC_ADDW         {`FN_ADDER, `FWD_W,  9'b000000001}
`define FUNC_ADDD         {`FN_ADDER, `FWD_D,  9'b000000010}
`define FUNC_SUBW         {`FN_ADDER, `FWD_W,  9'b000000011}
`define FUNC_SUBD         {`FN_ADDER, `FWD_D,  9'b000000100}
`define FUNC_ADDIW        {`FN_ADDER, `FWD_W,  9'b000000101}
`define FUNC_ADDID        {`FN_ADDER, `FWD_D,  9'b000000110}
`define FUNC_ADDU16ID     {`FN_ADDER, `FWD_D,  9'b000000111}
`define FUNC_ALSLW        {`FN_ADDER, `FWD_W,  9'b000001000}
`define FUNC_ALSLWU       {`FN_ADDER, `FWD_WU, 9'b000001001}
`define FUNC_ALSLD        {`FN_ADDER, `FWD_D,  9'b000001010}
`define FUNC_LU12IW       {`FN_ADDER, `FWD_W,  9'b000001011}
`define FUNC_LU32ID       {`FN_ADDER, `FWD_D,  9'b000001100}
`define FUNC_LU52ID       {`FN_ADDER, `FWD_D,  9'b000001101}
`define FUNC_SLT          {`FN_ADDER, `FWD_D,  9'b000001110}
`define FUNC_SLTU         {`FN_ADDER, `FWD_DU, 9'b000001111}
`define FUNC_SLTI         {`FN_ADDER, `FWD_D,  9'b000010000}
`define FUNC_SLTUI        {`FN_ADDER, `FWD_DU, 9'b000010001}

`define FUNC_AND          {`FN_ADDER, `FWD_D,  9'b000010110}
`define FUNC_OR           {`FN_ADDER, `FWD_D,  9'b000010111}
`define FUNC_NOR          {`FN_ADDER, `FWD_D,  9'b000011000}
`define FUNC_XOR          {`FN_ADDER, `FWD_D,  9'b000011001}
`define FUNC_ANDN         {`FN_ADDER, `FWD_D,  9'b000011010}
`define FUNC_ORN          {`FN_ADDER, `FWD_D,  9'b000011011}
`define FUNC_ANDI         {`FN_ADDER, `FWD_D,  9'b000011100}
`define FUNC_ORI          {`FN_ADDER, `FWD_D,  9'b000011101}
`define FUNC_XORI         {`FN_ADDER, `FWD_D,  9'b000011110}

`define FUNC_SLLW         {`FN_SHIFT, `FWD_W,  9'b001000001}
`define FUNC_SRLW         {`FN_SHIFT, `FWD_W,  9'b001000010}
`define FUNC_SRAW         {`FN_SHIFT, `FWD_W,  9'b001000011}
`define FUNC_ROTRW        {`FN_SHIFT, `FWD_W,  9'b001000100}
`define FUNC_SLLIW        {`FN_SHIFT, `FWD_W,  9'b001000101}
`define FUNC_SRLIW        {`FN_SHIFT, `FWD_W,  9'b001000110}
`define FUNC_SRAIW        {`FN_SHIFT, `FWD_W,  9'b001000111}
`define FUNC_ROTRIW       {`FN_SHIFT, `FWD_W,  9'b001001000}
`define FUNC_SLLD         {`FN_SHIFT, `FWD_D,  9'b001001001}
`define FUNC_SRLD         {`FN_SHIFT, `FWD_D,  9'b001001010}
`define FUNC_SRAD         {`FN_SHIFT, `FWD_D,  9'b001001011}
`define FUNC_ROTRD        {`FN_SHIFT, `FWD_D,  9'b001001100}
`define FUNC_SLLID        {`FN_SHIFT, `FWD_D,  9'b001001101}
`define FUNC_SRLID        {`FN_SHIFT, `FWD_D,  9'b001001110}
`define FUNC_SRAID        {`FN_SHIFT, `FWD_D,  9'b001001111}
`define FUNC_ROTRID       {`FN_SHIFT, `FWD_D,  9'b001010000}

`define FUNC_EXTWB        {`FN_BITOP, `FWD_B,  9'b001100001}
`define FUNC_EXTWH        {`FN_BITOP, `FWD_H,  9'b001100010}
`define FUNC_CLOW         {`FN_BITOP, `FWD_W,  9'b001100011}
`define FUNC_CLOD         {`FN_BITOP, `FWD_D,  9'b001100100}
`define FUNC_CLZW         {`FN_BITOP, `FWD_W,  9'b001100101}
`define FUNC_CLZD         {`FN_BITOP, `FWD_D,  9'b001100110}
`define FUNC_CTOW         {`FN_BITOP, `FWD_W,  9'b001100111}
`define FUNC_CTOD         {`FN_BITOP, `FWD_D,  9'b001101000}
`define FUNC_CTZW         {`FN_BITOP, `FWD_W,  9'b001101001}
`define FUNC_CTZD         {`FN_BITOP, `FWD_D,  9'b001101010}
`define FUNC_BYTEPICKW    {`FN_BITOP, `FWD_W,  9'b001101011}
`define FUNC_BYTEPICKD    {`FN_BITOP, `FWD_D,  9'b001101100}
`define FUNC_REVB2H       {`FN_BITOP, `FWD_H,  9'b001101101}
`define FUNC_REVB4H       {`FN_BITOP, `FWD_HU, 9'b001101110}
`define FUNC_REVB2W       {`FN_BITOP, `FWD_W,  9'b001101111}
`define FUNC_REVBD        {`FN_BITOP, `FWD_D,  9'b001110000}
`define FUNC_REVH2W       {`FN_BITOP, `FWD_H,  9'b001110001}
`define FUNC_REVHD        {`FN_BITOP, `FWD_HU, 9'b001110010}
`define FUNC_BITREV4B     {`FN_BITOP, `FWD_W,  9'b001110011}
`define FUNC_BITREV8B     {`FN_BITOP, `FWD_D,  9'b001110100}
`define FUNC_BITREVW      {`FN_BITOP, `FWD_W,  9'b001110101}
`define FUNC_BITREVD      {`FN_BITOP, `FWD_D,  9'b001110110}
`define FUNC_BSTRINSW     {`FN_BITOP, `FWD_W,  9'b001110111}
`define FUNC_BSTRINSD     {`FN_BITOP, `FWD_D,  9'b001111000}
`define FUNC_BSTRPICKW    {`FN_BITOP, `FWD_W,  9'b001111001}
`define FUNC_BSTRPICKD    {`FN_BITOP, `FWD_D,  9'b001111010}
`define FUNC_MASKEQZ      {`FN_BITOP, `FWD_D,  9'b001111011}
`define FUNC_MASKNEZ      {`FN_BITOP, `FWD_D,  9'b001111100}

//----------------------------------------------------------
//                      MULT Decoder
//----------------------------------------------------------
`define FUNC_MULW         {`FN_MUL,  `FWD_W,   9'b000100010}
`define FUNC_MULHW        {`FN_MUL,  `FWD_W,   9'b000100110}
`define FUNC_MULHWU       {`FN_MUL,  `FWD_WU,  9'b010000110}
`define FUNC_MULD         {`FN_MUL,  `FWD_D,   9'b000100001}
`define FUNC_MULHD        {`FN_MUL,  `FWD_D,   9'b000101101}
`define FUNC_MULHDU       {`FN_MUL,  `FWD_DU,  9'b010001101}
`define FUNC_MULWDW       {`FN_MUL,  `FWD_W,   9'b100000010}
`define FUNC_MULWDWU      {`FN_MUL,  `FWD_WU,  9'b110000010}

//----------------------------------------------------------
//                      DIV Decoder
//----------------------------------------------------------
`define FUNC_DIVW         {`FN_DIV,  `FWD_W ,  9'b000000111}
`define FUNC_DIVWU        {`FN_DIV,  `FWD_WU,  9'b000000011}
`define FUNC_DIVD         {`FN_DIV,  `FWD_D ,  9'b000000110}
`define FUNC_DIVDU        {`FN_DIV,  `FWD_DU,  9'b000000010}
`define FUNC_MODW         {`FN_DIV,  `FWD_W ,  9'b000000101}
`define FUNC_MODWU        {`FN_DIV,  `FWD_WU,  9'b000000001}
`define FUNC_MODD         {`FN_DIV,  `FWD_D ,  9'b000000100}
`define FUNC_MODDU        {`FN_DIV,  `FWD_DU,  9'b000000000}

//----------------------------------------------------------
//                      CRC Decoder
//----------------------------------------------------------
`define FUNC_CRCWBW       {`FN_ADDER, `FWD_D,  9'b000110001}
`define FUNC_CRCWHW       {`FN_ADDER, `FWD_D,  9'b000110011}
`define FUNC_CRCWWW       {`FN_ADDER, `FWD_D,  9'b000110100}
`define FUNC_CRCWDW       {`FN_ADDER, `FWD_D,  9'b000110101}
`define FUNC_CRCCWBW      {`FN_ADDER, `FWD_D,  9'b000110110}
`define FUNC_CRCCWHW      {`FN_ADDER, `FWD_D,  9'b000110111}
`define FUNC_CRCCWWW      {`FN_ADDER, `FWD_D,  9'b000111000}
`define FUNC_CRCCWDW      {`FN_ADDER, `FWD_D,  9'b000111001}

//----------------------------------------------------------
//                      ALU FP Decoder
//----------------------------------------------------------
`define FUNC_MVGF         {`FN_MISC,  `FWD_D,  9'b000111010}



//----------------------------------------------------------
//                      BJU Decoder 
//----------------------------------------------------------

`define FUNC_BEQ          {`FN_BJU,   3'b000,  9'b101000000}
`define FUNC_BNE          {`FN_BJU,   3'b000,  9'b101000010}
`define FUNC_BLT          {`FN_BJU,   3'b000,  9'b101000100}
`define FUNC_BLTU         {`FN_BJU,   3'b000,  9'b101000110}
`define FUNC_BGE          {`FN_BJU,   3'b000,  9'b101001000}
`define FUNC_BGEU         {`FN_BJU,   3'b000,  9'b101001010}
`define FUNC_BEQZ         {`FN_BJU,   3'b000,  9'b100001100}
`define FUNC_BNEZ         {`FN_BJU,   3'b000,  9'b100001110}
`define FUNC_BCEQZ        {`FN_BJU,   3'b000,  9'b100010000}
`define FUNC_BCNEZ        {`FN_BJU,   3'b000,  9'b100010010}
`define FUNC_B            {`FN_BJU,   3'b000,  9'b000100100}
`define FUNC_BL           {`FN_BJU,   3'b001,  9'b000100110}
`define FUNC_JIRL         {`FN_BJU,   3'b001,  9'b000111001}
`define FUNC_PCADDI       {`FN_BJU,   3'b001,  9'b010001010}
`define FUNC_PCADDU12I    {`FN_BJU,   3'b001,  9'b010011100}
`define FUNC_PCADDU18I    {`FN_BJU,   3'b001,  9'b010001110}
`define FUNC_PCALAU12I    {`FN_BJU,   3'b001,  9'b010001100}



//----------------------------------------------------------
//                   LSU INT Decoder 
//----------------------------------------------------------

// BIT 0: LOAD,STORE; 0 = LOAD
// BIT 1: UNSIGN OR SIGNED
// BIT 2:
// BIT 3:
// BIT 4:
// BIT 5:
// BIT 6: IF TWO REGISTER OR ONE REGISTER ONE IMME
//{BIT 6:5} : IF NEED SHIFT OFFSET(LDPTR, STPTR, 2'b01) 
// BIT 7: 1 = BOUND INST
// BIT 8: L1 CACHE INST
// 
`define FUNC_LDB          {`FN_LSU,   `FWD_B,  9'b000000010}
`define FUNC_LDBU         {`FN_LSU,   `FWD_BU, 9'b000000000}
`define FUNC_LDH          {`FN_LSU,   `FWD_H,  9'b000000010}
`define FUNC_LDHU         {`FN_LSU,   `FWD_HU, 9'b000000000}
`define FUNC_LDW          {`FN_LSU,   `FWD_W,  9'b000000010}
`define FUNC_LDWU         {`FN_LSU,   `FWD_WU, 9'b000000000}
`define FUNC_LDD          {`FN_LSU,   `FWD_D,  9'b000000010}
`define FUNC_LDPTRW       {`FN_LSU,   `FWD_W,  9'b000000110}
`define FUNC_LDPTRD       {`FN_LSU,   `FWD_D,  9'b000000110}
`define FUNC_PRELD        {`FN_LSU,   `FWD_D,  9'b001000110}
`define FUNC_PRELDX       {`FN_LSU,   `FWD_D,  9'b001001010}
`define FUNC_LDXB         {`FN_LSU,   `FWD_B,  9'b001001110}
`define FUNC_LDXBU        {`FN_LSU,   `FWD_BU, 9'b001001100}
`define FUNC_LDXH         {`FN_LSU,   `FWD_H,  9'b001001110}
`define FUNC_LDXHU        {`FN_LSU,   `FWD_HU, 9'b001001100}
`define FUNC_LDXW         {`FN_LSU,   `FWD_W,  9'b001001110}
`define FUNC_LDXWU        {`FN_LSU,   `FWD_WU, 9'b001001100}
`define FUNC_LDXD         {`FN_LSU,   `FWD_D,  9'b001001110}
`define FUNC_LDGTB        {`FN_LSU,   `FWD_B,  9'b011010000}
`define FUNC_LDGTH        {`FN_LSU,   `FWD_H,  9'b011010000}
`define FUNC_LDGTW        {`FN_LSU,   `FWD_W,  9'b011010000}
`define FUNC_LDGTD        {`FN_LSU,   `FWD_D,  9'b011010000}
`define FUNC_LDLEB        {`FN_LSU,   `FWD_B,  9'b011010100}
`define FUNC_LDLEH        {`FN_LSU,   `FWD_H,  9'b011010100}
`define FUNC_LDLEW        {`FN_LSU,   `FWD_W,  9'b011010100}
`define FUNC_LDLED        {`FN_LSU,   `FWD_D,  9'b011010100}


`define FUNC_STB          {`FN_LSU,   `FWD_B,  9'b000000001}
`define FUNC_STH          {`FN_LSU,   `FWD_H,  9'b000000001}
`define FUNC_STW          {`FN_LSU,   `FWD_W,  9'b000000001}
`define FUNC_STD          {`FN_LSU,   `FWD_D,  9'b000000001}
`define FUNC_STPTRW       {`FN_LSU,   `FWD_W,  9'b000000101}
`define FUNC_STPTRD       {`FN_LSU,   `FWD_D,  9'b000000101}
`define FUNC_STXB         {`FN_LSU,   `FWD_B,  9'b001001001}
`define FUNC_STXH         {`FN_LSU,   `FWD_H,  9'b001001001}
`define FUNC_STXW         {`FN_LSU,   `FWD_W,  9'b001001001}
`define FUNC_STXD         {`FN_LSU,   `FWD_D,  9'b001001001}
`define FUNC_STGTB        {`FN_LSU,   `FWD_B,  9'b011001101}
`define FUNC_STGTH        {`FN_LSU,   `FWD_H,  9'b011001101}
`define FUNC_STGTW        {`FN_LSU,   `FWD_W,  9'b011001101}
`define FUNC_STGTD        {`FN_LSU,   `FWD_D,  9'b011001101}
`define FUNC_STLEB        {`FN_LSU,   `FWD_B,  9'b011010001}
`define FUNC_STLEH        {`FN_LSU,   `FWD_H,  9'b011010001}
`define FUNC_STLEW        {`FN_LSU,   `FWD_W,  9'b011010001}
`define FUNC_STLED        {`FN_LSU,   `FWD_D,  9'b011010001}


//----------------------------------------------------------
//                   LSU FPU Decoder 
//----------------------------------------------------------
// FPU LOAD/STORE
`define FUNC_FLDS         {`FN_LSU_F, `FWD_W,  9'b000000100}
`define FUNC_FLDD         {`FN_LSU_F, `FWD_D,  9'b000000100}
`define FUNC_FLDXS        {`FN_LSU_F, `FWD_W,  9'b001001000}
`define FUNC_FLDXD        {`FN_LSU_F, `FWD_D,  9'b001001000}
`define FUNC_FLDGTS       {`FN_LSU_F, `FWD_W,  9'b011001100}
`define FUNC_FLDGTD       {`FN_LSU_F, `FWD_D,  9'b011001100}
`define FUNC_FLDLES       {`FN_LSU_F, `FWD_W,  9'b011001100}
`define FUNC_FLDLED       {`FN_LSU_F, `FWD_D,  9'b011001100}
`define FUNC_FSTS         {`FN_LSU_F, `FWD_W,  9'b000000101}
`define FUNC_FSTD         {`FN_LSU_F, `FWD_D,  9'b000000101}
`define FUNC_FSTXS        {`FN_LSU_F, `FWD_W,  9'b001001001}
`define FUNC_FSTXD        {`FN_LSU_F, `FWD_D,  9'b001001001}
`define FUNC_FSTGTS       {`FN_LSU_F, `FWD_W,  9'b011001101}
`define FUNC_FSTGTD       {`FN_LSU_F, `FWD_D,  9'b011001101}
`define FUNC_FSTLES       {`FN_LSU_F, `FWD_W,  9'b011001101}
`define FUNC_FSTLED       {`FN_LSU_F, `FWD_D,  9'b011001101}

//----------------------------------------------------------
//                   LSU ATOMIC Decoder 
//----------------------------------------------------------
// ATOMIC INST
`define FUNC_AMSWAPW      {`FN_LSU_A, `FWD_W,  9'b100000010}
`define FUNC_AMSWAPD      {`FN_LSU_A, `FWD_D,  9'b100000011}
`define FUNC_AMADDW       {`FN_LSU_A, `FWD_W,  9'b100000110}
`define FUNC_AMADDD       {`FN_LSU_A, `FWD_D,  9'b100000111}
`define FUNC_AMANDW       {`FN_LSU_A, `FWD_W,  9'b100001010}
`define FUNC_AMANDD       {`FN_LSU_A, `FWD_D,  9'b100001011}
`define FUNC_AMORW        {`FN_LSU_A, `FWD_W,  9'b100001110}
`define FUNC_AMORD        {`FN_LSU_A, `FWD_D,  9'b100001111}
`define FUNC_AMXORW       {`FN_LSU_A, `FWD_W,  9'b100010010}
`define FUNC_AMXORD       {`FN_LSU_A, `FWD_D,  9'b100010011}
`define FUNC_AMMAXW       {`FN_LSU_A, `FWD_W,  9'b100010110}
`define FUNC_AMMAXD       {`FN_LSU_A, `FWD_D,  9'b100010111}
`define FUNC_AMMINW       {`FN_LSU_A, `FWD_W,  9'b100011010}
`define FUNC_AMMIND       {`FN_LSU_A, `FWD_D,  9'b100011011}
`define FUNC_AMMAXWU      {`FN_LSU_A, `FWD_WU, 9'b100011100}
`define FUNC_AMMAXDU      {`FN_LSU_A, `FWD_DU, 9'b100011101}
`define FUNC_AMMINWU      {`FN_LSU_A, `FWD_WU, 9'b100100000}
`define FUNC_AMMINDU      {`FN_LSU_A, `FWD_DU, 9'b100100001}

`define FUNC_LLW          {`FN_LSU_A, `FWD_W,  9'b011000011}
`define FUNC_LLD          {`FN_LSU_A, `FWD_D,  9'b011000010}
`define FUNC_SCW          {`FN_LSU_A, `FWD_W,  9'b001100111}
`define FUNC_SCD          {`FN_LSU_A, `FWD_D,  9'b001100110}


//----------------------------------------------------------
//                   CP0 MISC Decoder 
//----------------------------------------------------------
`define FUNC_SYSCALL      {`FN_MISC,  `FWD_D,  9'b101001001}
`define FUNC_BREAK        {`FN_MISC,  `FWD_D,  9'b101001010}
`define FUNC_ASRTLED      {`FN_MISC,  `FWD_D,  9'b101001011}
`define FUNC_ASRTGTD      {`FN_MISC,  `FWD_D,  9'b101001100}
`define FUNC_RDTIMELW     {`FN_MISC,  `FWD_W,  9'b101001101}
`define FUNC_RDTIMEHW     {`FN_MISC,  `FWD_WU, 9'b101001110}
`define FUNC_RDTIMED      {`FN_MISC,  `FWD_D,  9'b101001111}
`define FUNC_CPUCFG       {`FN_MISC,  `FWD_D,  9'b101001000}

`define FUNC_IBAR         {`FN_MISC,  `FWD_D,  9'b101000011}
`define FUNC_DBAR         {`FN_MISC,  `FWD_D,  9'b101000111}
`define FUNC_INVTLB       {`FN_MISC,  `FWD_D,  9'b100101001}

//----------------------------------------------------------
//                   LSU CACOP Decoder 
//----------------------------------------------------------

//`define FN_MISC          8'b0010_0000
//`define FWD_D            3'b011

`define FUNC_L1ICACOP     {`FN_MISC,  `FWD_D,  9'b101110001}
`define FUNC_L1DCACOP     {`FN_MISC,  `FWD_D,  9'b101111001}
`define FUNC_L2CACOP      {`FN_MISC,  `FWD_D,  9'b100101101} // L2 Cache INST

`define FUNC_ERTN         {`FN_MISC,  `FWD_D,  9'b100101010}
`define FUNC_CPRS         {`FN_MISC,  `FWD_D,  9'b100101011}

`define FUNC_CSRRD        {`FN_MISC,  `FWD_D,  9'b101101100}
`define FUNC_CSRWR        {`FN_MISC,  `FWD_D,  9'b101101101}
`define FUNC_CSRXCHG      {`FN_MISC,  `FWD_D,  9'b101101110}

`define FUNC_IOCSRRDB     {`FN_MISC,  `FWD_B,  9'b101111110}
`define FUNC_IOCSRRDH     {`FN_MISC,  `FWD_H,  9'b101111110}
`define FUNC_IOCSRRDW     {`FN_MISC,  `FWD_W,  9'b101111110}
`define FUNC_IOCSRRDD     {`FN_MISC,  `FWD_D,  9'b101111110}
`define FUNC_IOCSRWRB     {`FN_MISC,  `FWD_B,  9'b101111111}
`define FUNC_IOCSRWRH     {`FN_MISC,  `FWD_H,  9'b101111111}
`define FUNC_IOCSRWRW     {`FN_MISC,  `FWD_W,  9'b101111111}
`define FUNC_IOCSRWRD     {`FN_MISC,  `FWD_D,  9'b101111111}


// //----------------------------------------------------------
// //                      CP0 Decoder 
// //----------------------------------------------------------
`define FUNC_ECALL       {{`FUNC_WIDTH-10{1'b0}}, 10'b000001_0010}
`define FUNC_EBREAK      {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_0010}
`define FUNC_MRET        {{`FUNC_WIDTH-10{1'b0}}, 10'b000100_0010}
`define FUNC_SRET        {{`FUNC_WIDTH-10{1'b0}}, 10'b001000_0010}
`define FUNC_WFI         {{`FUNC_WIDTH-10{1'b0}}, 10'b010000_0010}
`define FUNC_DRET        {{`FUNC_WIDTH-10{1'b0}}, 10'b100000_0010}
`define FUNC_FENCE       {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_1000}
`define FUNC_FENCEI      {{`FUNC_WIDTH-10{1'b0}}, 10'b000010_0100}
`define FUNC_SFENCE      {{`FUNC_WIDTH-10{1'b0}}, 10'b000100_0100}
`define FUNC_SYNC        {{`FUNC_WIDTH-10{1'b0}}, 10'b001000_0100}
`define FUNC_SYNCI       {{`FUNC_WIDTH-10{1'b0}}, 10'b010000_0100}
`define FUNC_CACHE       {{`FUNC_WIDTH-10{1'b0}}, 10'b100000_0100}


`define FUNC_DCACHE_IALL       {{`FUNC_WIDTH-16{1'b0}}, 6'b00_01_01, 10'b100000_0100}
`define FUNC_DCACHE_CALL       {{`FUNC_WIDTH-16{1'b0}}, 6'b00_10_01, 10'b100000_0100}
`define FUNC_DCACHE_CIALL      {{`FUNC_WIDTH-16{1'b0}}, 6'b00_11_01, 10'b100000_0100}
`define FUNC_DCACHE_ISW        {{`FUNC_WIDTH-16{1'b0}}, 6'b01_01_01, 10'b100000_0100}
`define FUNC_DCACHE_CSW        {{`FUNC_WIDTH-16{1'b0}}, 6'b01_10_01, 10'b100000_0100}
`define FUNC_DCACHE_CISW       {{`FUNC_WIDTH-16{1'b0}}, 6'b01_11_01, 10'b100000_0100}
`define FUNC_ICACHE_IVA        {{`FUNC_WIDTH-16{1'b0}}, 6'b10_01_10, 10'b100000_0100}
`define FUNC_ICACHE_IPA        {{`FUNC_WIDTH-16{1'b0}}, 6'b11_01_10, 10'b100000_0100}

//----------------------------------------------------------
//                   LSU 32 Bits Decoder 
//----------------------------------------------------------
`define FUNC_LB    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0010}
`define FUNC_LH    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0110}
`define FUNC_LW    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1010}
`define FUNC_LD    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1110}
`define FUNC_LBU   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0000}
`define FUNC_LHU   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0100}
`define FUNC_LWU   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1000}
`define FUNC_FLH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_0100}
`define FUNC_FLW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1000}
`define FUNC_FLD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1100}
`define FUNC_SB    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0001}
`define FUNC_SH    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0101}
`define FUNC_SW    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1001}
`define FUNC_SD    {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1101}
`define FUNC_FSH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_0101}
`define FUNC_FSW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1001}
`define FUNC_FSD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1101}
`define FUNC_LR_W  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1010}
`define FUNC_SC_W  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1001}
`define FUNC_LR_D  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1100}
`define FUNC_SC_D  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0010_1101}

`define FUNC_AMO_W {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0011_1011}
`define FUNC_AMO_D {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0011_1111}

//----------------------------------------------------------
//                   LSU Vector Decoder 
//----------------------------------------------------------
`define FUNC_VLH   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0110}
`define FUNC_VLB   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0010}
`define FUNC_VLW   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1010}
`define FUNC_VLHU  {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0100}
`define FUNC_VLBU  {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0000}
`define FUNC_VLWU  {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1000}
`define FUNC_VLE   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1100}
`define FUNC_VLSB  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0010}
`define FUNC_VLSH  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0110}
`define FUNC_VLSW  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1010}
`define FUNC_VLSBU {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0000}
`define FUNC_VLSHU {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0100}
`define FUNC_VLSWU {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1000}
`define FUNC_VLSE  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1100}
`define FUNC_VLXB  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0010}
`define FUNC_VLXH  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0110}
`define FUNC_VLXW  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1010}
`define FUNC_VLXBU {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0000}
`define FUNC_VLXHU {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0100}
`define FUNC_VLXWU {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1000}
`define FUNC_VLXE  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1100}
`define FUNC_VSB   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0001}
`define FUNC_VSH   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_0101}
`define FUNC_VSW   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1001}
`define FUNC_VSE   {{`FUNC_WIDTH-15{1'b0}},3'b000,12'b1000_0000_1101}
`define FUNC_VSSB  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0001}
`define FUNC_VSSH  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_0101}
`define FUNC_VSSW  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1001}
`define FUNC_VSSE  {{`FUNC_WIDTH-15{1'b0}},3'b001,12'b1000_0000_1101}
`define FUNC_VSXB  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0001}
`define FUNC_VSXH  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_0101}
`define FUNC_VXSW  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1001}
`define FUNC_VXSE  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0000_1101}

`define FUNC_VLHFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0110}
`define FUNC_VLBFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0010}
`define FUNC_VLWFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_1010}
`define FUNC_VLHUFF {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0100}
`define FUNC_VLBUFF {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_0000}
`define FUNC_VLWUFF {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_1000}
`define FUNC_VLEFF  {{`FUNC_WIDTH-15{1'b0}},3'b100,12'b1000_0000_1100}

`define FUNC_ZVAMO  {{`FUNC_WIDTH-15{1'b0}},3'b010,12'b1000_0011_0011}
//----------------------------------------------------------
//                   LSU Dcache Decoder 
//----------------------------------------------------------
`define FUNC_DCACHE_IVA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_0010}
`define FUNC_DCACHE_CVA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_0100}
`define FUNC_DCACHE_CVAL1  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0101_0100}
`define FUNC_DCACHE_CIVA   {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_0110}
`define FUNC_DCACHE_IPA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_1010}
`define FUNC_DCACHE_CPA    {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_1100}
`define FUNC_DCACHE_CPAL1  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0101_1100}
`define FUNC_DCACHE_CIPA   {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_0100_1110}

//----------------------------------------------------------
//                   LSU Performance  Decoder 
//----------------------------------------------------------
`define FUNC_LRB   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0010}
`define FUNC_LRH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0110}
`define FUNC_LRW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1010}
`define FUNC_LRD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1110}
`define FUNC_LRBU  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0000}
`define FUNC_LRHU  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0100}
`define FUNC_LRWU  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1000}
`define FUNC_LURB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0010}
`define FUNC_LURH  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0110}
`define FUNC_LURW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1010}
`define FUNC_LURD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1110}
`define FUNC_LURBU {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0000}
`define FUNC_LURHU {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0100}
`define FUNC_LURWU {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1000}
`define FUNC_LBIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0010}
`define FUNC_LBIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0010}
`define FUNC_LHIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0110}
`define FUNC_LHIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0110}
`define FUNC_LWIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1010}
`define FUNC_LWIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1010}
`define FUNC_LDIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1110}
`define FUNC_LDIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1110}
`define FUNC_LBUIB {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0000}
`define FUNC_LBUIA {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0000}
`define FUNC_LHUIB {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0100}
`define FUNC_LHUIA {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0100}
`define FUNC_LWUIB {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1000}
`define FUNC_LWUIA {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1000}
`define FUNC_LDIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1110}
`define FUNC_LDIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1110}
`define FUNC_SRB   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0011}
`define FUNC_SRH   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_0111}
`define FUNC_SRW   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1011}
`define FUNC_SRD   {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_0000_1111}
`define FUNC_SURB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0011}
`define FUNC_SURH  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_0111}
`define FUNC_SURW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1011}
`define FUNC_SURD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0001_0000_1111}
`define FUNC_FLRW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1010}
`define FUNC_FLRD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1110}
`define FUNC_FLURW {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1010}
`define FUNC_FLURD {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1110}
`define FUNC_FSRW  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1011}
`define FUNC_FSRD  {{`FUNC_WIDTH-12{1'b0}}, 12'b0111_0000_1111}
`define FUNC_FSURW {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1011}
`define FUNC_FSURD {{`FUNC_WIDTH-12{1'b0}}, 12'b0101_0000_1111}
`define FUNC_SBIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0011}
`define FUNC_SBIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0011}
`define FUNC_SHIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_0111}
`define FUNC_SHIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_0111}
`define FUNC_SWIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1011}
`define FUNC_SWIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1011}
`define FUNC_SDIB  {{`FUNC_WIDTH-12{1'b0}}, 12'b0011_1000_1111}
`define FUNC_SDIA  {{`FUNC_WIDTH-12{1'b0}}, 12'b0000_1000_1111}

//----------------------------------------------------------
//                   FPU 
//----------------------------------------------------------

`define FUNC_FDIVH  20'b0010_00000000000000_01
`define FUNC_FSQRTH 20'b0010_00000000000000_10
`define FUNC_FDIVS  20'b0010_10000000000000_01
`define FUNC_FDIVRS 20'b0010_10000000000001_01
`define FUNC_FSQRTS 20'b0010_10000000000000_10
`define FUNC_FDIVD  20'b0011_00000000000000_01
`define FUNC_FDIVRD 20'b0011_00000000000001_01
`define FUNC_FSQRTD 20'b0011_00000000000000_10
`define FUNC_FMV_SI32_F32 20'b0010_1000_0000_0010_0100
`define FUNC_FMV_F32_SI32 20'b0010_1000_0000_0010_0001
`define FUNC_FMV_F32_F32  20'b0010_1000_0000_1000_0001
`define FUNC_FSGNJS       20'b0010_1000_0000_0100_0001
`define FUNC_FSGNJNS      20'b0010_1000_0000_0100_0010
`define FUNC_FSGNJXS      20'b0010_1000_0000_0100_0100
`define FUNC_FCLASSS      20'b0110_1000_0000_0000_0000
`define FUNC_FLOGS        20'b0010_1000_0001_0000_0000
`define FUNC_FMV_SI64_F64 20'b0011_0000_0000_0010_0100
`define FUNC_FMV_F64_SI64 20'b0011_0000_0000_0010_0001
`define FUNC_FMV_F64_F64  20'b0011_0000_0000_1000_0001
`define FUNC_FMV_FH32_F64 20'b0011_0000_0000_0010_0010
`define FUNC_FMV_F64_FH32 20'b0011_0000_0000_0010_1000
`define FUNC_FSELD        20'b0011_0000_0000_0011_0000
`define FUNC_FSGNJD       20'b0011_0000_0000_0100_0001
`define FUNC_FSGNJND      20'b0011_0000_0000_0100_0010
`define FUNC_FSGNJXD      20'b0011_0000_0000_0100_0100
`define FUNC_FCLASSD      20'b0111_0000_0000_0000_0000
`define FUNC_FLOGD        20'b0011_0000_0001_0000_0000
`define FUNC_FADDS 20'b0010_1001_0000_0000_0000   
`define FUNC_FSUBS 20'b0010_1000_1000_0000_0000
`define FUNC_FMAXS 20'b0010_1000_0010_0000_0000
`define FUNC_FMINS 20'b0010_1000_0001_0000_0000
`define FUNC_FMAXAS 20'b0010_1000_0010_0000_0001
`define FUNC_FMINAS 20'b0010_1000_0001_0000_0001
`define FUNC_FEQS  20'b0010_1000_0100_0000_0001
`define FUNC_FLTS  20'b0010_1000_0100_0000_0010
`define FUNC_FLES  20'b0010_1000_0100_0000_0100
`define FUNC_FCMP_S_C_AF  20'b0010_1000_0100_0000_0000
`define FUNC_FCMP_S_C_UN  20'b0010_1000_0100_0000_0001
`define FUNC_FCMP_S_C_EQ  20'b0010_1000_0100_0000_0010
`define FUNC_FCMP_S_C_UEQ 20'b0010_1000_0100_0000_0011
`define FUNC_FCMP_S_C_LT  20'b0010_1000_0100_0000_0100
`define FUNC_FCMP_S_C_ULT 20'b0010_1000_0100_0000_0101
`define FUNC_FCMP_S_C_LE  20'b0010_1000_0100_0000_0110
`define FUNC_FCMP_S_C_ULE 20'b0010_1000_0100_0000_0111
`define FUNC_FCMP_S_C_NE  20'b0010_1000_0100_0000_1000
`define FUNC_FCMP_S_C_OR  20'b0010_1000_0100_0000_1001
`define FUNC_FCMP_S_C_UNE 20'b0010_1000_0100_0000_1010
`define FUNC_FCMP_S_S_AF  20'b0010_1000_0100_0001_0000
`define FUNC_FCMP_S_S_UN  20'b0010_1000_0100_0001_0001
`define FUNC_FCMP_S_S_EQ  20'b0010_1000_0100_0001_0010
`define FUNC_FCMP_S_S_UEQ 20'b0010_1000_0100_0001_0011
`define FUNC_FCMP_S_S_LT  20'b0010_1000_0100_0001_0100
`define FUNC_FCMP_S_S_ULT 20'b0010_1000_0100_0001_0101
`define FUNC_FCMP_S_S_LE  20'b0010_1000_0100_0001_0110
`define FUNC_FCMP_S_S_ULE 20'b0010_1000_0100_0001_0111
`define FUNC_FCMP_S_S_NE  20'b0010_1000_0100_0001_1000
`define FUNC_FCMP_S_S_OR  20'b0010_1000_0100_0001_1001
`define FUNC_FCMP_S_S_UNE 20'b0010_1000_0100_0001_1010
`define FUNC_FADDD 20'b0011_0001_0000_0000_0000  
`define FUNC_FSUBD 20'b0011_0000_1000_0000_0000
`define FUNC_FMAXD 20'b0011_0000_0010_0000_0000
`define FUNC_FMIND 20'b0011_0000_0001_0000_0000
`define FUNC_FMAXAD 20'b0011_0000_0010_0000_0001
`define FUNC_FMINAD 20'b0011_0000_0001_0000_0001
`define FUNC_FEQD  20'b0011_0000_0100_0000_0001
`define FUNC_FLTD  20'b0011_0000_0100_0000_0010
`define FUNC_FLED  20'b0011_0000_0100_0000_0100
`define FUNC_FCMP_D_C_AF  20'b0011_0000_0100_0000_0000
`define FUNC_FCMP_D_C_UN  20'b0011_0000_0100_0000_0001
`define FUNC_FCMP_D_C_EQ  20'b0011_0000_0100_0000_0010
`define FUNC_FCMP_D_C_UEQ 20'b0011_0000_0100_0000_0011
`define FUNC_FCMP_D_C_LT  20'b0011_0000_0100_0000_0100
`define FUNC_FCMP_D_C_ULT 20'b0011_0000_0100_0000_0101
`define FUNC_FCMP_D_C_LE  20'b0011_0000_0100_0000_0110
`define FUNC_FCMP_D_C_ULE 20'b0011_0000_0100_0000_0111
`define FUNC_FCMP_D_C_NE  20'b0011_0000_0100_0000_1000
`define FUNC_FCMP_D_C_OR  20'b0011_0000_0100_0000_1001
`define FUNC_FCMP_D_C_UNE 20'b0011_0000_0100_0000_1010
`define FUNC_FCMP_D_S_AF  20'b0011_0000_0100_0001_0000
`define FUNC_FCMP_D_S_UN  20'b0011_0000_0100_0001_0001
`define FUNC_FCMP_D_S_EQ  20'b0011_0000_0100_0001_0010
`define FUNC_FCMP_D_S_UEQ 20'b0011_0000_0100_0001_0011
`define FUNC_FCMP_D_S_LT  20'b0011_0000_0100_0001_0100
`define FUNC_FCMP_D_S_ULT 20'b0011_0000_0100_0001_0101
`define FUNC_FCMP_D_S_LE  20'b0011_0000_0100_0001_0110
`define FUNC_FCMP_D_S_ULE 20'b0011_0000_0100_0001_0111
`define FUNC_FCMP_D_S_NE  20'b0011_0000_0100_0001_1000
`define FUNC_FCMP_D_S_OR  20'b0011_0000_0100_0001_1001
`define FUNC_FCMP_D_S_UNE 20'b0011_0000_0100_0001_1010
`define FUNC_FCVT_SI32_F32  20'b0010_1000_0000_1000_1010
`define FUNC_FCVT_UI32_F32  20'b0010_1000_0000_1000_0010
`define FUNC_FCVT_SI64_F32  20'b0010_1110_0000_1000_1010
`define FUNC_FCVT_UI64_F32  20'b0010_1110_0000_1000_0010
`define FUNC_FCVT_F32_SI32  20'b0010_1000_0010_1000_0101
`define FUNC_FCVT_F32_UI32  20'b0010_1000_0010_1000_0100
`define FUNC_FCVT_F32_SI64  20'b0011_0010_0010_1000_0101
`define FUNC_FCVT_F32_UI64  20'b0011_0010_0010_1000_0100
`define FUNC_FCVT_SI32_F64  20'b0011_0010_0000_1000_1010
`define FUNC_FCVT_UI32_F64  20'b0011_0010_0000_1000_0010
`define FUNC_FCVT_SI64_F64  20'b0011_0000_0000_1000_1010
`define FUNC_FCVT_UI64_F64  20'b0011_0000_0000_1000_0010
`define FUNC_FCVT_F64_SI32  20'b0010_1110_0010_1000_0101
`define FUNC_FCVT_F64_UI32  20'b0010_1110_0010_1000_0100
`define FUNC_FCVT_F64_SI64  20'b0011_0000_0010_1000_0101
`define FUNC_FCVT_F64_UI64  20'b0011_0000_0010_1000_0100
`define FUNC_FCVT_F32_F64   20'b0011_0010_0000_1000_0110
`define FUNC_FCVT_F64_F32   20'b0010_1110_0000_1000_0110
`define FUNC_FMULS    20'b0010_0000000000000_000
`define FUNC_FSCALEBS 20'b0010_0000000000100_000
`define FUNC_FMADDS   20'b0010_0000000000000_001
`define FUNC_FMSUBS   20'b0010_0000000000000_011
`define FUNC_FNMSUBS  20'b0010_0000000000000_111
`define FUNC_FNMADDS  20'b0010_0000000000000_101
`define FUNC_FMULD    20'b0001_0000000000000_000
`define FUNC_FSCALEBD 20'b0001_0000000000100_000
`define FUNC_FMADDD   20'b0001_0000000000000_001
`define FUNC_FMSUBD   20'b0001_0000000000000_011
`define FUNC_FNMSUBD  20'b0001_0000000000000_111
`define FUNC_FNMADDD  20'b0001_0000000000000_101
`define FUNC_FMULH    20'b0100_0000000000000_000
`define FUNC_FMADDH   20'b0100_0000000000000_001
`define FUNC_FMSUBH   20'b0100_0000000000000_011
`define FUNC_FNMSUBH  20'b0100_0000000000000_111
`define FUNC_FNMADDH  20'b0100_0000000000000_101

//  Just use simple Onehot
//  19       17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   |   |SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv | clas |
//+------+------+-----+--+--------+------+------+-------+-----------------+

//VFSPU
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|             | sgn |                  |   x  |   n   |  none |
//+------+------+-----+--+--------+------+------+-------+-------+
//  8       7      6    5     4      3      2      1       0
//+------+------+-----+-----+----+------+------+-------+-------+
//|             |     | mv   fs  |   sf |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+

`define FUNC_VFSGNJ         20'b0000_0000_1000_0100_0001
`define FUNC_VFSGNJX        20'b0000_0000_1000_0100_0100
`define FUNC_VFSGNJN        20'b0000_0000_1000_0100_0010
`define FUNC_VFCLASS        20'b0000_0000_1000_1000_0000
`define FUNC_VFMERG         20'b0000_0000_1000_0010_0010
`define FUNC_VFMVSF         20'b0000_0000_1000_0010_1000
`define FUNC_VFMVFS         20'b0000_0000_1000_0011_0000


//convert
// 8       7       6        5     4      3      2        1       0
//+-----+-----+--------+-------+------+------+------+-------+-------+
//|qup  | qdn | widden | narow | same | srcf | srcu | destf | destu 
//+-----+-----+--------+-------+------+------+------+-------+-------+
`define FUNC_VFCVTXUF        20'b0000_0000_1000_0001_1001
`define FUNC_VFCVTXF         20'b0000_0000_1000_0001_1000
`define FUNC_VFCVTFXU        20'b0000_0000_1000_0001_0110
`define FUNC_VFCVTFX         20'b0000_0000_1000_0001_0010
`define FUNC_VFWCVTXUF       20'b0000_0000_1000_0100_1001
`define FUNC_VFWCVTXF        20'b0000_0000_1000_0100_1000
`define FUNC_VFWCVTFXU       20'b0000_0000_1000_0100_0110
`define FUNC_VFWCVTFX        20'b0000_0000_1000_0100_0010
`define FUNC_VFWCVTFF        20'b0000_0000_1000_0100_1010
`define FUNC_VFNCVTXUF       20'b0000_0000_1000_0010_1001
`define FUNC_VFNCVTXF        20'b0000_0000_1000_0010_1000
`define FUNC_VFNCVTFXU       20'b0000_0000_1000_0010_0110
`define FUNC_VFNCVTFX        20'b0000_0000_1000_0010_0010
`define FUNC_VFNCVTFF        20'b0000_0000_1000_0010_1010


//VFADD
//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
//+------+------+-----+--+--------+------+------+-------+-----------------+

//convert
//  10                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| cmp |      |             fne  | ford |   le |  lt   |  feq  |
//+------+------+-----+--+--------+------+------+-------+-------+

//  12                 5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//| add |      |                         |      |   red | order |
//+------+------+-----+--+--------+------+------+-------+-------+
//add and sub
//  a                                       11      10       9
//+------+------+-----+--+--------+------+------+-------+-------+
//|                           fmt   fmt  |scalar | reduc | unord |
//+------+------+-----+--+--------+------+------+-------+-------+

//   8      7           5     4      3      2        1       0
//+------+------+-----+----+------+------+------+-------+-------+
//|rever | add  |      max | add  |      |      | src1_w|       |
//+------+------+-----+----+------+------+------+-------+-------+


//   8      7           5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|rever | add/s |           add  | sub  | dst_w| src1_w|  f    |
//+------+------+-----+--+--------+------+------+-------+-------+
`define FUNC_VFADD        20'b0000_0000_1000_1001_0000
`define FUNC_VFSUB        20'b0000_0000_1000_1000_1000
`define FUNC_VFWADD       20'b0000_0000_1000_1001_0100
`define FUNC_VFWSUB       20'b0000_0000_1000_1000_1100
`define FUNC_VFWADDW      20'b0000_0000_1000_1001_0010
`define FUNC_VFWSUBW      20'b0000_0000_1000_1000_1010
`define FUNC_VFMIN        20'b0000_0000_1000_0010_1000
`define FUNC_VFMAX        20'b0000_0000_1000_0011_0000
`define FUNC_VFEQ         20'b0000_0000_1000_0100_0001
`define FUNC_VFNE         20'b0000_0000_1000_0101_0000
`define FUNC_VFLT         20'b0000_0000_1000_0100_0010
`define FUNC_VFLE         20'b0000_0000_1000_0100_0100
`define FUNC_VFORD        20'b0000_0000_1000_0100_1000
`define FUNC_VFREDSUM     20'b0000_0000_1110_1001_0000
`define FUNC_VFREDSUM64   20'b0000_0000_1100_1001_0000
`define FUNC_VFOREDSUM    20'b0000_0000_1100_1001_0000
`define FUNC_VFWREDSUM    20'b0000_0000_1100_1001_0010
`define FUNC_VFWREDSUM64  20'b0000_0000_1100_1001_0010
`define FUNC_VFWOREDSUM   20'b0000_0000_1100_1001_0010
`define FUNC_VFREDMAX     20'b0000_0000_1110_0011_0000
`define FUNC_VFREDMAX64   20'b0000_0000_1100_0011_0000
`define FUNC_VFREDMIN     20'b0000_0000_1110_0010_1000
`define FUNC_VFREDMIN64   20'b0000_0000_1100_0010_1000
