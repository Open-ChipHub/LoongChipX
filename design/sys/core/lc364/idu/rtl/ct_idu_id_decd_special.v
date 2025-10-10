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
module ct_idu_id_decd_special (
  // &Ports, @26
  input    wire          cp0_idu_cskyee,
  input    wire  [2 :0]  cp0_idu_frm,
  input    wire  [1 :0]  cp0_idu_fs,
  input    wire  [31:0]  x_inst,
  output   wire          x_fence,
  output   wire  [2 :0]  x_fence_type,
  output   wire          x_split,
  output   wire  [9 :0]  x_split_long_type,
  output   wire  [2 :0]  x_split_potnt,
  output   wire          x_split_short,
  output   wire  [2 :0]  x_split_short_potnt,
  output   wire  [6 :0]  x_split_short_type
); 



// &Regs; @27
// &Wires; @28



// &Force("bus","x_inst",31,0); @31
//==========================================================
//                 Decode Split Short Type
//==========================================================
// &Force("output","x_split_short_type"); @35
//----------------------------------------------------------
//                 Instruction Split Short
//----------------------------------------------------------
assign x_split_short   = |x_split_short_type[6:0];

//----------------------------------------------------------
//                      jal with dest
//----------------------------------------------------------
assign x_split_short_type[0] = (x_inst[31:26] == 6'b010101) // bl
                            || (x_inst[31:26] == 6'b010011) // jirl
                               && (x_inst[4:0] != 5'd0);

//----------------------------------------------------------
//                  FP compare and convert
//----------------------------------------------------------
assign x_split_short_type[1] = (x_inst[31:10] == 22'b0000000100010100101011)  // movgr2frh.w
                            || (x_inst[31:10] == 22'b0000000100011110010001)  // frint.s
                            || (x_inst[31:10] == 22'b0000000100011110010010)  // frint.d
                            || (x_inst[31:10] == 22'b0000000100010100011001)  // frsqrt.s
                            || (x_inst[31:10] == 22'b0000000100010100011010)  // frsqrt.d
                            || (x_inst[31:18] == 14'b000011010000_00);  // fsel
                            // || (x_inst[31:20] == 12'b000011000001)   // fcmp.s
                            // || (x_inst[31:20] == 12'b000011000010)   // fcmp.d                               
                            // || (x_inst[31:19] == 13'b0000000100011); // fcvt/ffint/ftint   

//----------------------------------------------------------
//                  Indexed Load and Store
//----------------------------------------------------------
assign x_split_short_type[2] = 1'b0;

//----------------------------------------------------------
//                  Indexed Load and Store
//----------------------------------------------------------
assign x_split_short_type[3] = 1'b0;

assign x_split_short_potnt[0]   = |x_split_short_type[3:0];
assign x_split_short_potnt[2:1] = 2'b0;
assign x_split_short_type[6:4]  = 3'b0;
//==========================================================
//                 Decode Split long Type
//==========================================================
// &Force("output","x_split_long_type"); @314
//----------------------------------------------------------
//                Instruction Split Long
//----------------------------------------------------------
assign x_split         = |x_split_long_type[9:0];

//----------------------------------------------------------
//               Atomic Load / Store / AMO
//----------------------------------------------------------
assign x_split_long_type[0] = 
                              (x_inst[31:15] == 17'b00111000011000000) || //amswap.w
                              (x_inst[31:15] == 17'b00111000011000001) || //amswap.d
                              (x_inst[31:15] == 17'b00111000011000010) || //amadd.w
                              (x_inst[31:15] == 17'b00111000011000011) || //amadd.d
                              (x_inst[31:15] == 17'b00111000011000100) || //amand.w
                              (x_inst[31:15] == 17'b00111000011000101) || //amand.d
                              (x_inst[31:15] == 17'b00111000011000110) || //amor.w
                              (x_inst[31:15] == 17'b00111000011000111) || //amor.d
                              (x_inst[31:15] == 17'b00111000011001000) || //amxor.w
                              (x_inst[31:15] == 17'b00111000011001001) || //amxor.d
                              (x_inst[31:15] == 17'b00111000011001010) || //ammax.w
                              (x_inst[31:15] == 17'b00111000011001011) || //ammax.d
                              (x_inst[31:15] == 17'b00111000011001100) || //ammin.w
                              (x_inst[31:15] == 17'b00111000011001101) || //ammin.d
                              (x_inst[31:15] == 17'b00111000011001110) || //ammax.wu
                              (x_inst[31:15] == 17'b00111000011001111) || //ammax.du
                              (x_inst[31:15] == 17'b00111000011010000) || //ammin.wu
                              (x_inst[31:15] == 17'b00111000011010001) || //ammin.du
                              (x_inst[31:15] == 17'b00111000011010010) || //amswap_db.w
                              (x_inst[31:15] == 17'b00111000011010011) || //amswap_db.d
                              (x_inst[31:15] == 17'b00111000011010100) || //amadd_db.w
                              (x_inst[31:15] == 17'b00111000011010101) || //amadd_db.d
                              (x_inst[31:15] == 17'b00111000011010110) || //amand_db.w
                              (x_inst[31:15] == 17'b00111000011010111) || //amand_db.d
                              (x_inst[31:15] == 17'b00111000011011000) || //amor_db.w
                              (x_inst[31:15] == 17'b00111000011011001) || //amor_db.d
                              (x_inst[31:15] == 17'b00111000011011010) || //amxor_db.w
                              (x_inst[31:15] == 17'b00111000011011011) || //amxor_db.d
                              (x_inst[31:15] == 17'b00111000011011100) || //ammax_db.w
                              (x_inst[31:15] == 17'b00111000011011101) || //ammax_db.d
                              (x_inst[31:15] == 17'b00111000011011110) || //ammin_db.w
                              (x_inst[31:15] == 17'b00111000011011111) || //ammin_db.d
                              (x_inst[31:15] == 17'b00111000011100000) || //ammax_db.wu
                              (x_inst[31:15] == 17'b00111000011100001) || //ammax_db.du
                              (x_inst[31:15] == 17'b00111000011100010) || //ammin_db.wu
                              (x_inst[31:15] == 17'b00111000011100011);   //ammin_db.du

assign x_split_potnt[0]     = x_split_long_type[0];
assign x_split_potnt[2:1]   = 2'b0;
assign x_split_long_type[1] = 1'b0;//normal vector inst
assign x_split_long_type[2] = 1'b0;//permute inst
assign x_split_long_type[3] = 1'b0;//vfreduction inst
assign x_split_long_type[4] = 1'b0;//stride vec load store inst
assign x_split_long_type[5] = 1'b0;//index vec load store inst
assign x_split_long_type[6] = 1'b0;//vector amo
assign x_split_long_type[7] = 1'b0;//zvlsseg unit
assign x_split_long_type[8] = 1'b0;//zvlsseg stride
assign x_split_long_type[9] = 1'b0;//zvlsseg index
//==========================================================
//                Decode Fence Instruction
//==========================================================
// &Force("output","x_fence_type"); @431
//----------------------------------------------------------
//                   Instruction Fence
//----------------------------------------------------------
assign x_fence         = |x_fence_type[2:0];

//----------------------------------------------------------
//                   Fence Instruction
//----------------------------------------------------------
assign x_fence_type[0] = (x_inst[31:15] == 17'b00111000011100100) || //dbar
                         (x_inst[31:15] == 17'b00111000011100101) || //ibar
                         (x_inst[31:15] == 17'b00000110010010011) || //invtlb
                         (x_inst[31:10] == 22'b00000110010010000_01000) ||  // tlbclr
                         (x_inst[31:10] == 22'b00000110010010000_01001) ||  // tlbflush
                         (x_inst[31:10] == 22'b00000110010010000_01010) ||  // tlbsrch
                         (x_inst[31:10] == 22'b00000110010010000_01011) ||  // tlbrd
                         (x_inst[31:10] == 22'b00000110010010000_01100) ||  // tlbwr
                         (x_inst[31:10] == 22'b00000110010010000_01101) ||  // tlbfill
                         (x_inst[31:22] == 10'b0000011000); // cache

//----------------------------------------------------------
//                    CP0 Instruction
//----------------------------------------------------------
assign x_fence_type[1] = ({x_inst[31:24], x_inst[9:5]} == 13'b00000100_00000) ||   //csrrd
                         ({x_inst[31:24], x_inst[9:5]} == 13'b00000100_00001) ||   //csrwr
                         (x_inst[31:10] == 22'b00000000000000000_11011) || // cpucfg
                         (x_inst[31:13] == 19'b00000110010010000_00) || // iocsr
                         (x_inst[31: 0] == 32'b00000110010010000011100000000000) || // ertn
                         (x_inst[31:10] == 22'b0000000100010100110000) || // movgr2fcsr  
                         (x_inst[31:10] == 22'b0000000100010100110010) || // movfcsr2gr  
                         (x_inst[31:15] == 17'b00000110010010010)  || // cprs
                         (x_inst[31:15] == 17'b00000110010010001);    // idle

//----------------------------------------------------------
//                   csrxchg Instruction
//----------------------------------------------------------
assign x_fence_type[2] = ({x_inst[31:24]} == 8'b00000100) 
                            && (x_inst[9:5] != 5'b00000)
                            && (x_inst[9:5] != 5'b00001);       //csrxchg


// &ModuleEnd; @484
endmodule


