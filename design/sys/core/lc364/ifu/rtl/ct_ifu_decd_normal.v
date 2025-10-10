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

// &ModuleBeg; @25
module ct_ifu_decd_normal (
  // &Ports, @26
  input    wire  [7 :0]  cp0_ifu_vl,
  input    wire          cp0_ifu_vsetvli_pred_disable,
  input    wire          x_br,
  input    wire  [31:0]  x_inst,
  output   wire          x_auipc,
  output   wire          x_branch,
  output   wire          x_chgflw,
  output   wire          x_con_br,
  output   wire          x_dst_vld,
  output   wire          x_ind_br,
  output   wire          x_jal,
  output   wire          x_jalr,
  output   wire          x_ld,
  output   wire  [27:0]  x_offset,
  output   wire          x_pc_oper,
  output   wire          x_pcall,
  output   wire          x_preturn,
  output   wire          x_st,
  output   wire  [7 :0]  x_vlmax,
  output   wire  [1 :0]  x_vlmul,
  output   wire          x_vsetvli,
  output   wire  [2 :0]  x_vsew
); 



// &Regs; @27
// &Wires; @28
wire            x_ab_br;                     

wire    [27:0]  x_offset_21_ab_br;           
wire            x_offset_21_ab_br_vld;      
wire    [27:0]  x_offset_26_ab_br;           
wire            x_offset_26_ab_br_vld;       
    
wire    [27:0]  x_offset_21_con_br;          
wire            x_offset_21_con_br_vld;      
wire    [27:0]  x_offset_16_con_br;           
wire            x_offset_16_con_br_vld;   
wire    [27:0]  x_offset_16_ab_br;           
wire            x_offset_16_ab_br_vld;



//==========================================================
//                   Decode Normal Type
//==========================================================
// &Force("bus","x_inst",31,0); @34

//Hn_ab_br
assign x_ab_br = x_br && 
                 (
                  (x_inst[31:26] == 6'b010100) || // b
                  (x_inst[31:26] == 6'b010101)    // bl
                 );
//Hn_con_br
assign x_con_br = x_br && 
                  (
                    (x_inst[31:26] == 6'b010000) || // beqz
                    (x_inst[31:26] == 6'b010001) || // bnez
                    ({x_inst[31:26], x_inst[9:8]} == 8'b010010_00) || // bceqz
                    ({x_inst[31:26], x_inst[9:8]} == 8'b010010_01) || // bcnez
                    (x_inst[31:26] == 6'b010110) || // beq
                    (x_inst[31:26] == 6'b010111) || // bne
                    (x_inst[31:26] == 6'b011000) || // blt
                    (x_inst[31:26] == 6'b011001) || // bgt
                    (x_inst[31:26] == 6'b011010) || // bltu
                    (x_inst[31:26] == 6'b011011)    // bgeu
                  );
// &Force("output","x_con_br"); @48

//Hn_auipc
assign x_auipc = (x_inst[31:25] == 7'b0001100) || // pcaddi
                 (x_inst[31:25] == 7'b0001101) || // pcalau12i
                 (x_inst[31:25] == 7'b0001110) || // pcaddu12i
                 (x_inst[31:25] == 7'b0001111);   // pcaddu18i
// &Force("output","x_auipc"); @52

//Hn_pc_oper
assign x_pc_oper = x_br ||
                 (x_inst[31:26] == 6'b010011) ||  // jirl
                 (x_inst[31:25] == 7'b0001100) || // pcaddi
                 (x_inst[31:25] == 7'b0001101) || // pcalau12i
                 (x_inst[31:25] == 7'b0001110) || // pcaddu12i
                 (x_inst[31:25] == 7'b0001111) ;  // pcaddu18i

// &Force("output","x_pc_oper"); @59
                  
//Hn_chgflw_not_br
//contain all the chgflw inst except con_br
assign x_chgflw = (x_inst[31:26] == 6'b010011) ||  // jirl
                  x_ab_br;
// &Force("output","x_chgflw"); @66

//Hn_branch
//contain all the branch inst include con_br
assign x_branch = (x_inst[31:26] == 6'b010011) ||  // jirl
                  x_br;
// &Force("output","x_branch"); @73
                
//Hn_jal
assign x_jal = (x_inst[31:26] == 6'b010100) || // b
               (x_inst[31:26] == 6'b010101);   // bl
// &Force("output","x_jal"); @78

//Hn_jalr
assign x_jalr = (x_inst[31:26] == 6'b010011); // jirl
// &Force("output","x_jalr"); @83

//Hn_dst_vld
// Inst: jirl rd, rj, offset16
//       when rd !=0, dest is valid

// FIXME: if rd != ra && rd != 0, how to do?
assign x_dst_vld = (x_inst[31:26] == 6'b010101) ||  // bl
                   (x_inst[31:26] == 6'b010011)     // jirl && dest != 0
                      && (x_inst[4:0] != 5'b0);

//==========================================================
//                   Decode Indirect Branch
//==========================================================
//Pcall and Preturn judgement
//      +-------+-------+--------+--------------+
//      |   rd  |  rs1  | rs1=rd | RAS action   |
//      +-------+-------+--------+--------------+
//      | !link | !link |    -   | none         |
//      +-------+-------+--------+--------------+
//      | !link | link  |    -   | pop          |
//      +-------+-------+--------+--------------+
//      | link  | !link |    -   | push         |
//      +-------+-------+--------+--------------+
//      | link  | link  |    0   | push and pop |
//      +-------+-------+--------+--------------+
//      | link  | link  |    1   | push         |
//      +-------+-------+--------+--------------+


//Hn_pcall 
//1. jalr: rd == x1 or rd == x5
//2. jal : rd == x1 or rd == x5
//3. c.jalr
//  x_inst[9:5] = rj
//  x_inst[4:0] = rd
assign x_pcall = (
                  (x_inst[31:26] == 6'b010011) && //jirl
                  (
                   (x_inst[4:0] == 5'b00001)
                  )
                 ) || 
                 (
                  (x_inst[31:26] == 6'b010101)    //bl  //hint rd = r1
                 ); 

//Hn_preturn
//1. jalr: when rs1 == x1 or rs1 == x5 and rs1!=rd
//2. c.jr: when rs1 ==x1 or rs1 == x5
//3. c.jalr: when rs1 == x5(c.jalr use x1 as default rd) 

// jirl ra
assign x_preturn = (
                    (x_inst[31:26] == 6'b010011) && //jirl
                    (
                     (x_inst[9:5] == 5'b00001) 
                    ) && (x_inst[25:10] == 16'b0) 
                   ); 


//Hn_ind_jmp
assign x_ind_br  = (
                    (x_inst[31:26] == 6'b010011) && //jirl
                    (
                     (x_inst[9 : 5] != 5'b00001) ||
                     (x_inst[25:10] != 16'b0) ||
                     (x_inst[9 : 5] == x_inst[4:0])
                    )
                   ); 
                

//==========================================================
//                   Decode Store Inst
//==========================================================
// &Force("bus","x_inst",31,0); @187
assign x_st = (x_inst[31:24] == 8'b00100101) || //stptr.w
              (x_inst[31:24] == 8'b00100111) || //stptr.d
              (x_inst[31:22] == 10'b0010100100) || //st.b
              (x_inst[31:22] == 10'b0010100101) || //st.h
              (x_inst[31:22] == 10'b0010100110) || //st.w
              (x_inst[31:22] == 10'b0010100111) || //st.d
              (x_inst[31:22] == 10'b0010101101) || //fst.s
              (x_inst[31:22] == 10'b0010101111) || //fst.d
              (x_inst[31:22] == 10'b0010111100) || //stl.w
              (x_inst[31:22] == 10'b0010111101) || //str.w
              (x_inst[31:22] == 10'b0010111110) || //stl.d
              (x_inst[31:22] == 10'b0010111111) || //str.d
              (x_inst[31:15] == 17'b00111000000100_000) || //stx.b
              (x_inst[31:15] == 17'b00111000000101_000) || //stx.h
              (x_inst[31:15] == 17'b00111000000110_000) || //stx.w
              (x_inst[31:15] == 17'b00111000000111_000) || //stx.d
              (x_inst[31:15] == 17'b00111000001110_000) || //fstx.s
              (x_inst[31:15] == 17'b00111000001111_000) || //fstx.d
              (x_inst[31:15] == 17'b00111000011101100) || //fstgt.s
              (x_inst[31:15] == 17'b00111000011101101) || //fstgt.d
              (x_inst[31:15] == 17'b00111000011101110) || //fstle.s
              (x_inst[31:15] == 17'b00111000011101111) || //fstle.d
              (x_inst[31:15] == 17'b00111000011111000) || //stgt.b
              (x_inst[31:15] == 17'b00111000011111001) || //stgt.h
              (x_inst[31:15] == 17'b00111000011111010) || //stgt.w
              (x_inst[31:15] == 17'b00111000011111011) || //stgt.d
              (x_inst[31:15] == 17'b00111000011111100) || //stle.b
              (x_inst[31:15] == 17'b00111000011111101) || //stle.h
              (x_inst[31:15] == 17'b00111000011111110) || //stle.w
              (x_inst[31:15] == 17'b00111000011111111);   //stle.d



//==========================================================
//                 Decode lsfifo Instruction
//==========================================================
assign x_ld = (x_inst[31:24] == 8'b00100100) || //ldptr.w
              (x_inst[31:24] == 8'b00100110) || //ldptr.d
              (x_inst[31:22] == 10'b0010100000) || //ld.b
              (x_inst[31:22] == 10'b0010100001) || //ld.h
              (x_inst[31:22] == 10'b0010100010) || //ld.w
              (x_inst[31:22] == 10'b0010100011) || //ld.d
              (x_inst[31:22] == 10'b0010101000) || //ld.bu
              (x_inst[31:22] == 10'b0010101001) || //ld.hu
              (x_inst[31:22] == 10'b0010101010) || //ld.wu
              (x_inst[31:22] == 10'b0010101011) || //preld
              (x_inst[31:22] == 10'b0010101100) || //fld.s
              (x_inst[31:22] == 10'b0010101110) || //fld.d
              (x_inst[31:22] == 10'b0010111000) || //ldl.w
              (x_inst[31:22] == 10'b0010111001) || //ldr.w
              (x_inst[31:22] == 10'b0010111010) || //ldl.d
              (x_inst[31:22] == 10'b0010111011) || //ldr.d
              (x_inst[31:15] == 17'b00111000000000_000) || //ldx.b
              (x_inst[31:15] == 17'b00111000000001_000) || //ldx.h
              (x_inst[31:15] == 17'b00111000000010_000) || //ldx.w
              (x_inst[31:15] == 17'b00111000000011_000) || //ldx.d
              (x_inst[31:15] == 17'b00111000001000_000) || //ldx.bu
              (x_inst[31:15] == 17'b00111000001001_000) || //ldx.hu
              (x_inst[31:15] == 17'b00111000001010_000) || //ldx.wu
//---------   (x_inst[31:15] == 17'b00111000001011_000) || //preldx
              (x_inst[31:15] == 17'b00111000001100_000) || //fldx.s
              (x_inst[31:15] == 17'b00111000001101_000) || //fldx.d
              (x_inst[31:15] == 17'b00111000011101000) || //fldgt.s
              (x_inst[31:15] == 17'b00111000011101001) || //fldgt.d
              (x_inst[31:15] == 17'b00111000011101010) || //fldle.s
              (x_inst[31:15] == 17'b00111000011101011) || //fldle.d
              (x_inst[31:15] == 17'b00111000011110000) || //ldgt.b
              (x_inst[31:15] == 17'b00111000011110001) || //ldgt.h
              (x_inst[31:15] == 17'b00111000011110010) || //ldgt.w
              (x_inst[31:15] == 17'b00111000011110011) || //ldgt.d
              (x_inst[31:15] == 17'b00111000011110100) || //ldle.b
              (x_inst[31:15] == 17'b00111000011110101) || //ldle.h
              (x_inst[31:15] == 17'b00111000011110110) || //ldle.w
              (x_inst[31:15] == 17'b00111000011110111) ;  //ldle.d

//==========================================================
//                   Decode Vtype Inst
//==========================================================
//vsetvli inst :
//-----+----------------+---------+-------+-------+---------------+
//  31 |30            20|19     15|14   12|11    7|6            0 |
//   1 |   zimm[10:0]   |   rs1   | 1 1 1 |   rd  | 1 0 1 0 1 1 1 |
//-----+----------------+---------+-------+-------+---------------+
assign x_vsetvli = 1'b0;

//vlmul & vsew
//zimm[10:0]:
//10:7:  Reserverd
// 6:5:  vediv, Used for EDIV extention,reserved for xuantie910
// 4:2:  vsew,standard element width setting
// 1:0:  vlmul,vector register group multiplier setting
assign x_vsew[2:0]  = '0;
assign x_vlmul[1:0] = '0; 
assign x_vlmax[7:0] = '0;

//==========================================================
//                 Decode Immediate Offset
//==========================================================
// assign x_offset_21_ab_br_vld = ({x_inst[31:26], x_inst[9:5]} == 11'b010010_10000) || // jisrc0
//                                ({x_inst[31:26], x_inst[9:5]} == 11'b010010_11000);   // jisrc1
assign x_offset_21_ab_br_vld = 0;

assign x_offset_21_ab_br = { {5{x_inst[4]}},
                                x_inst[4:0],
                                x_inst[25:10],
                                2'b00
                            };          

assign x_offset_26_ab_br_vld = (x_inst[31:26] == 6'b010100) || // b
                               (x_inst[31:26] == 6'b010101);   // bl

assign x_offset_26_ab_br = {   x_inst[9:0],
                               x_inst[25:10],
                               2'b00
                            };           

assign x_offset_21_con_br_vld = (x_inst[31:26] == 6'b010000) || // beqz
                                (x_inst[31:26] == 6'b010001) || // bnez
                                ({x_inst[31:26], x_inst[9:8]} == 8'b010010_00) || // bceqz
                                ({x_inst[31:26], x_inst[9:8]} == 8'b010010_01);   // bcnez  

assign x_offset_21_con_br = { {5{x_inst[4]}},
                                 x_inst[4:0],
                                 x_inst[25:10],
                                 2'b00
                            };          

assign x_offset_16_ab_br_vld  = (x_inst[31:26] == 6'b010011); // jirl

assign x_offset_16_ab_br      = { {10{x_inst[25]}    },
                                  x_inst[25:10],
                                  2'b00
                                };

assign x_offset_16_con_br_vld = (x_inst[31:26] == 6'b010110) || // beq
                                (x_inst[31:26] == 6'b010111) || // bne
                                (x_inst[31:26] == 6'b011000) || // blt
                                (x_inst[31:26] == 6'b011001) || // bgt
                                (x_inst[31:26] == 6'b011010) || // bltu
                                (x_inst[31:26] == 6'b011011);   // bgeu

assign x_offset_16_con_br = { {10{x_inst[25]}},
                                  x_inst[25:10],
                                  2'b00
                            };          

//default will choose 0 as C.J/C.JARL result                                        
assign x_offset[27:0] = 
    {28{x_offset_21_ab_br_vld}}  & x_offset_21_ab_br[27:0]
  | {28{x_offset_26_ab_br_vld}}  & x_offset_26_ab_br[27:0]
  | {28{x_offset_21_con_br_vld}} & x_offset_21_con_br[27:0]
  | {28{x_offset_16_ab_br_vld}}  & x_offset_16_ab_br[27:0]
  | {28{x_offset_16_con_br_vld}} & x_offset_16_con_br[27:0];


// &ModuleEnd; @361
endmodule


