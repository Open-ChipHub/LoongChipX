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
module ct_idu_rf_pipe3_decd (
  // &Ports, @28
  input    wire  [31:0]  pipe3_decd_opcode,
  output   reg           pipe3_decd_atomic,
  output   reg           pipe3_decd_inst_fls,
  output   reg           pipe3_decd_inst_ldr,
  output   reg   [1 :0]  pipe3_decd_inst_size,
  output   reg   [1 :0]  pipe3_decd_inst_type,
  output   reg           pipe3_decd_lsfifo,
  output   reg           pipe3_decd_off_0_extend,
  output   reg   [13:0]  pipe3_decd_offset,
  output   wire  [14:0]  pipe3_decd_offset_plus,
  output   reg   [3 :0]  pipe3_decd_shift,
  output   reg           pipe3_decd_sign_extend
); 



// &Regs; @29
reg     [3 :0]  ldr_shift;              
reg             pipe3_decd_inst_vls;    

// &Wires; @30
wire    [31:0]  decd_op;                
wire    [14:0]  decd_plus_value;


parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;

//==========================================================
//                    Rename Input
//==========================================================
assign decd_op[31:0] = pipe3_decd_opcode[31:0];

//==========================================================
//              Decode for offset shift
//==========================================================
// &CombBeg; @45
always @( decd_op[26:25])
begin
ldr_shift[3:0] = 4'b0;
case(decd_op[26:25])
  2'b00:ldr_shift[0] = 1'b1;
  2'b01:ldr_shift[1] = 1'b1;
  2'b10:ldr_shift[2] = 1'b1;
  2'b11:ldr_shift[3] = 1'b1;
  default:ldr_shift[3:0] = 4'b0;
endcase
// &CombEnd; @54
end

//==========================================================
//                       Decode
//==========================================================
// &CombBeg; @59
always @( decd_op[31:0]
       or ldr_shift[3:0])
begin
casez({decd_op[31:15], decd_op[14:10]})  
  /// 
  /// pipe3_decd_shift          == 4'b0000 : clear offset
  ///                           == 4'b0001 : == imm
  ///                           == 4'b0010 : == imm << 1
  ///                           == 4'b0100 : == imm << 2
  ///                           == 4'b1000 : == imm << 3
  ///
  ///
  ///       when pipe3_decd_inst_ldr   == 1'b1;
  ///          MUST BE: pipe3_decd_shift[3:0] == 4'b0001;
  ///  
  /// NOTE: We Must set pipe3_decd_shift as 4'b0001 (don't need shift)
  ///       When unaligned access keep correct st_ag_offset 
  ///

//------------------------normal----------------------------
  //  ..28..24..20..16..12...8...4...0
  22'b00100000_?????????_????? : //ll.w
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b01;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0100;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end

  22'b00100010_?????????_????? : //ll.d
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b01;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0100;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end

  22'b00100100?????????_????? : //ldptr.w
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0100;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00100110?????????_????? : //ldptr.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0100;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010100000???????_????? : //ld.b
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010100001???????_????? : //ld.h
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b01;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010100010???????_????? : //ld.w
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010100011???????_????? : //ld.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010101000???????_????? : //ld.bu
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010101001???????_????? : //ld.hu
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b01;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010101010???????_????? : //ld.wu
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010101011???????_????? : //preld
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010101100???????_????? : //fld.s
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b0010101110???????_????? : //fld.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000001100000_?????:  //fldx.s
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000001101000_?????:  //fldx.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

//-----------------------------------------------
  22'b00111000011101000_?????:  //fldgt.s
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101001_?????:  //fldgt.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101010_?????:  //fldle.s
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101011_?????:  //fldle.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b1;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000000000000_????? : //ldx.b
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000000001000_????? : //ldx.h
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b01;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000000010000_????? : //ldx.w
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000000011000_????? : //ldx.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000001000000_????? : //ldx.bu
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000001001000_????? : //ldx.hu
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b01;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000001010000_????? : //ldx.wu
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000001011000_????? : //preldx
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110000_????? : //ldgt.b
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110001_????? : //ldgt.h
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b01;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110010_????? : //ldgt.w
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110011_????? : //ldgt.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110100_????? : //ldle.b
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b00;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110101_????? : //ldle.h
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b01;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110110_????? : //ldle.w
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  22'b00111000011110111_????? : //ldle.d
  begin
    pipe3_decd_atomic         = 1'b0;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b1;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b1;
  end

  
  // amo
  22'b00111000011000000_?????, //amswap.w
  22'b00111000011000010_?????, //amadd.w
  22'b00111000011000100_?????, //amand.w
  22'b00111000011000110_?????, //amor.w
  22'b00111000011001000_?????, //amxor.w
  22'b00111000011001010_?????, //ammax.w
  22'b00111000011001100_?????, //ammin.w
  22'b00111000011001110_?????, //ammax.wu
  22'b00111000011010000_?????: //ammin.wu
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end

  22'b00111000011000001_?????, //amswap.d
  22'b00111000011000011_?????, //amadd.d
  22'b00111000011000101_?????, //amand.d
  22'b00111000011000111_?????, //amor.d
  22'b00111000011001001_?????, //amxor.d
  22'b00111000011001011_?????, //ammax.d
  22'b00111000011001101_?????, //ammin.d
  22'b00111000011001111_?????, //ammax.du
  22'b00111000011010001_?????: //ammin.du
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end

  // amo db
  22'b00111000011010010_?????, //amswap_db.w
  22'b00111000011010100_?????, //amadd_db.w
  22'b00111000011010110_?????, //amand_db.w
  22'b00111000011011000_?????, //amor_db.w
  22'b00111000011011010_?????, //amxor_db.w
  22'b00111000011011100_?????, //ammax_db.w
  22'b00111000011011110_?????: //ammin_db.w
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b1;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end

  22'b00111000011100000_?????, //ammax_db.wu
  22'b00111000011100010_?????: //ammin_db.wu
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b10;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end

  22'b00111000011010011_?????, //amswap_db.d
  22'b00111000011010101_?????, //amadd_db.d
  22'b00111000011010111_?????, //amand_db.d
  22'b00111000011011001_?????, //amor_db.d
  22'b00111000011011011_?????, //amxor_db.d
  22'b00111000011011101_?????, //ammax_db.d
  22'b00111000011011111_?????, //ammin_db.d
  22'b00111000011100001_?????, //ammax_db.du
  22'b00111000011100011_?????: //ammin_db.du
  begin
    pipe3_decd_atomic         = 1'b1;
    pipe3_decd_sign_extend    = 1'b0;
    pipe3_decd_inst_type[1:0] = 2'b00;
    pipe3_decd_inst_size[1:0] = 2'b11;
    pipe3_decd_inst_fls       = 1'b0;
    pipe3_decd_inst_vls       = 1'b0;
    pipe3_decd_offset[13:0]   = 14'b0;
    pipe3_decd_shift[3:0]     = 4'b0001;
    pipe3_decd_inst_ldr       = 1'b0;
    pipe3_decd_off_0_extend   = 1'b0;
    pipe3_decd_lsfifo         = 1'b0;
  end


  
  default:
  begin
    pipe3_decd_atomic         = 1'bx;
    pipe3_decd_sign_extend    = 1'bx;
    pipe3_decd_inst_type[1:0] = {2{1'bx}};
    pipe3_decd_inst_size[1:0] = {2{1'bx}};
    pipe3_decd_inst_fls       = 1'bx;
    pipe3_decd_inst_vls       = 1'bx;
    pipe3_decd_offset[13:0]   = {14{1'bx}};
    pipe3_decd_shift[3:0]     = {4{1'bx}};
    pipe3_decd_inst_ldr       = 1'bx;
    pipe3_decd_off_0_extend   = 1'bx;
    pipe3_decd_lsfifo         = 1'bx;
  end
endcase
// &CombEnd; @1045
end

// &Force("output","pipe3_decd_offset"); @1047
assign decd_plus_value[14:0] = (pipe3_decd_shift[3:0] == 4'b0100) ? 15'h4 : 15'h10;

assign pipe3_decd_offset_plus[14:0] = {pipe3_decd_offset[13],pipe3_decd_offset[13:0]}
                                      + decd_plus_value[14:0];

//for vector decode
// &Force("output","pipe3_decd_inst_vls"); @1053
// &Force("output","pipe3_decd_atomic"); @1054
// &Force("output","pipe3_decd_unit_stride"); @1055
// &Force("output","pipe3_decd_inst_fof"); @1056
// &Force("output","pipe3_decd_vmask_vld"); @1057
// &CombBeg; @1082
// &CombEnd; @1092
// &CombBeg; @1098
// &CombEnd; @1106
// &CombBeg; @1115
// &CombEnd; @1123
// &CombBeg; @1129
// &CombEnd; @1143
// &CombBeg; @1145
// &CombEnd; @1165
// &Force("nonport","pipe3_decd_inst_vls"); @1167


// &ModuleEnd; @1171
endmodule


