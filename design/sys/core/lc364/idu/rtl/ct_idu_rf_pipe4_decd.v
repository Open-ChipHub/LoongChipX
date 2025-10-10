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
module ct_idu_rf_pipe4_decd (
  // &Ports, @28
  input    wire          cp0_lsu_fencei_broad_dis,
  input    wire          cp0_lsu_fencerw_broad_dis,
  input    wire          cp0_lsu_tlb_broad_dis,
  input    wire  [6 :0]  pipe4_decd_dst_preg,
  input    wire  [31:0]  pipe4_decd_opcode,
  output   reg           pipe4_decd_atomic,
  output   reg   [3 :0]  pipe4_decd_fence_mode,
  output   reg           pipe4_decd_icc,
  output   reg           pipe4_decd_inst_fls,
  output   reg           pipe4_decd_inst_flush,
  output   reg   [1 :0]  pipe4_decd_inst_mode,
  output   reg           pipe4_decd_inst_share,
  output   reg   [1 :0]  pipe4_decd_inst_size,
  output   reg           pipe4_decd_inst_str,
  output   reg   [1 :0]  pipe4_decd_inst_type,
  output   reg           pipe4_decd_lsfifo,
  output   reg           pipe4_decd_mmu_req,
  output   reg           pipe4_decd_off_0_extend,
  output   reg   [13:0]  pipe4_decd_offset,
  output   wire  [14:0]  pipe4_decd_offset_plus,
  output   reg   [3 :0]  pipe4_decd_shift,
  output   reg           pipe4_decd_st,
  output   reg           pipe4_decd_sync_fence
); 



// &Regs; @29
reg             pipe4_decd_inst_vls;      
reg     [1 :0]  sfence_inst_mode;         
reg     [1 :0]  invtlb_inst_mode;         
reg     [3 :0]  str_shift;                

// &Wires; @30
wire    [31:0]  decd_op;                  
wire    [3 :0]  fence_mode_sel;           
wire            rs1_is_zero;              
wire            rs2_is_zero;              
wire    [14:0]  decd_plus_value;


parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;

//==========================================================
//                    Rename Input
//==========================================================
assign decd_op[31:0] = pipe4_decd_opcode[31:0];

//==========================================================
//              Decode for offset shift
//==========================================================
// &CombBeg; @45
always @( decd_op[26:25])
begin
str_shift[3:0] = 4'b0;
case(decd_op[26:25])
  2'b00:str_shift[0] = 1'b1;
  2'b01:str_shift[1] = 1'b1;
  2'b10:str_shift[2] = 1'b1;
  2'b11:str_shift[3] = 1'b1;
  default:str_shift[3:0] = 4'b0;
endcase
// &CombEnd; @54
end

//==========================================================
//                Decode for specail inst
//==========================================================
//-----------------------fence------------------------------
assign fence_mode_sel[3:0]  = (decd_op[27]
                                ||  decd_op[25]
                                ||  decd_op[23]
                                ||  decd_op[21])
                              ? 4'b1111
                              : 4'b1100;
//---------------------sfence.vma----------------------------
assign rs1_is_zero  = decd_op[19:15]  ==  5'b0;
assign rs2_is_zero  = decd_op[24:20]  ==  5'b0;

// &CombBeg; @70
always @( rs1_is_zero
       or rs2_is_zero)
begin
if(rs1_is_zero  &&  rs2_is_zero)
  sfence_inst_mode[1:0]  = 2'b00;
else if(rs1_is_zero)
  sfence_inst_mode[1:0]  = 2'b01;
else if(rs2_is_zero)
  sfence_inst_mode[1:0]  = 2'b10;
else
  sfence_inst_mode[1:0]  = 2'b11;
// &CombEnd; @79
end

/// 00:inv all; 01: inv pid=rs2; 10:inv va=rs1, 11: inv va=rs1, pid=rs2
// &CombBeg; @70
always @( rs1_is_zero
       or rs2_is_zero)
begin
if(rs1_is_zero  &&  rs2_is_zero)
  invtlb_inst_mode[1:0]  = 2'b00;
else if(rs1_is_zero)
  invtlb_inst_mode[1:0]  = 2'b00;
else if(rs2_is_zero)
  invtlb_inst_mode[1:0]  = 2'b00;
else
  invtlb_inst_mode[1:0]  = 2'b00;
// &CombEnd; @79
end


//==========================================================
//                       Decode
//==========================================================
// &CombBeg; @93
always @( decd_op[31:0]
       or cp0_lsu_tlb_broad_dis
       or str_shift[3:0]
       or cp0_lsu_fencerw_broad_dis
       or pipe4_decd_dst_preg[6:0]
       or sfence_inst_mode[1:0]
       or invtlb_inst_mode[1:0]
       or cp0_lsu_fencei_broad_dis
       or fence_mode_sel[3:0])
begin
casez({decd_op[31:15], decd_op[14:10]})
//------------------------normal----------------------------
  /// pipe4_decd_inst_type[1:0] == 00 atomic inst
  ///                           == 01 icache inst
  ///                           == 10 dcache inst
  ///                           == 11 l2dcache inst
  ///
  ///
  /// pipe4_decd_inst_mode[1:0] == 00;
  ///
  /// pipe4_decd_lsfifo         == 1 pfu enable (prefetch)
  ///                           == 0 pfu disable
  ///
  /// pipe4_decd_inst_share     == 0 single core
  ///                           == 1 multi core (coherence) 
  ///
  ///
  /// pipe4_decd_shift          == 4'b0000 : clear offset
  ///                           == 4'b0001 : == imm
  ///                           == 4'b0010 : == imm << 1
  ///                           == 4'b0100 : == imm << 2
  ///                           == 4'b1000 : == imm << 3
  ///
  /// NOTE: We Must set pipe4_decd_shift as 4'b0001 (don't need shift)
  ///       When unaligned access keep correct st_ag_offset
  ///
  
  22'b00100001_?????????_????? : //sc.w
  begin
    pipe4_decd_atomic         = 1'b1;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = pipe4_decd_dst_preg[6];;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b01;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = pipe4_decd_dst_preg[5:4];
    pipe4_decd_fence_mode[3:0]= pipe4_decd_dst_preg[3:0];
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0100;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  22'b00100011_?????????_????? : //sc.d
  begin
    pipe4_decd_atomic         = 1'b1;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = pipe4_decd_dst_preg[6];
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b01;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = pipe4_decd_dst_preg[5:4];
    pipe4_decd_fence_mode[3:0]= pipe4_decd_dst_preg[3:0];
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0100;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  22'b00100101?????????_????? : //stptr.w
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0100;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00100111?????????_????? : //stptr.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {decd_op[23:22], decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0100;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b0010100100???????_????? : //st.b
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b0010100101???????_????? : //st.h
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b01;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b0010100110???????_????? : //st.w
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b0010100111???????_????? : //st.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b0010101101???????_????? : //fst.s
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b0010101111???????_????? : //fst.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = {{2{decd_op[21]}}, decd_op[21:10]};
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000001110000_?????:  //fstx.s
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000001111000_?????:  //fstx.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101100_?????:  //fstgt.s
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101101_?????:  //fstgt.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101110_?????:  //fstle.s
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011101111_?????:  //fstle.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b1;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000000100000_????? : //stx.b
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000000101000_????? : //stx.h
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b01;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

   22'b00111000000110000_????? : //stx.w
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000000111000_????? : //stx.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b1;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111000_????? : //stgt.b
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111001_????? : //stgt.h
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b01;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111010_????? : //stgt.w
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111011_????? : //stgt.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111100_????? : //stle.b
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111101_????? : //stle.h
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b01;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111110_????? : //stle.w
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
  end

  22'b00111000011111111_????? : //stle.d
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b1;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b1;
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
    pipe4_decd_atomic         = 1'b1;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b0;
    pipe4_decd_fence_mode[3:0]= 4'b0;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
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
    pipe4_decd_atomic         = 1'b1;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b0;
    pipe4_decd_fence_mode[3:0]= 4'b0;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  // amo db
  22'b00111000011010010_?????, //amswap_db.w
  22'b00111000011010100_?????, //amadd_db.w
  22'b00111000011010110_?????, //amand_db.w
  22'b00111000011011000_?????, //amor_db.w
  22'b00111000011011010_?????, //amxor_db.w
  22'b00111000011011100_?????, //ammax_db.w
  22'b00111000011011110_?????, //ammin_db.w
  22'b00111000011100000_?????, //ammax_db.wu
  22'b00111000011100010_?????: //ammin_db.wu
  begin
    pipe4_decd_atomic         = 1'b1;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b10;
    pipe4_decd_inst_mode[1:0] = 2'b0;
    pipe4_decd_fence_mode[3:0]= 4'b0;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
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
    pipe4_decd_atomic         = 1'b1;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b1;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b0;
    pipe4_decd_fence_mode[3:0]= 4'b0;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  22'b00111000011100101_????? : //ibar
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b1;
    pipe4_decd_icc            = 1'b1;
    pipe4_decd_st             = 1'b0;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b01;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  22'b00111000011100100_????? : //dbar
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b1;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b1;
    pipe4_decd_icc            = 1'b0;
    pipe4_decd_st             = 1'b0;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b01;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b1111;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  // 22'b0000011000???????_????? : // cacop (cache) (write into L1 Cache)
  // begin
  //   pipe4_decd_atomic         = 1'b0;
  //   pipe4_decd_sync_fence     = 1'b1;
  //   pipe4_decd_inst_flush     = 1'b0;
  //   pipe4_decd_inst_share     = 1'b0;
  //   pipe4_decd_icc            = 1'b1;
  //   pipe4_decd_st             = 1'b0;
  //   pipe4_decd_mmu_req        = 1'b0;
  //   pipe4_decd_inst_type[1:0] = 2'b10;
  //   pipe4_decd_inst_size[1:0] = 2'b01;
  //   pipe4_decd_inst_mode[1:0] = 2'b00;
  //   pipe4_decd_fence_mode[3:0]= 4'b0000;
  //   pipe4_decd_inst_fls       = 1'b0;
  //   pipe4_decd_inst_vls       = 1'b0;
  //   pipe4_decd_offset[13:0]   = 14'b0;
  //   pipe4_decd_shift[3:0]     = 4'b0001;
  //   pipe4_decd_inst_str       = 1'b0;
  //   pipe4_decd_off_0_extend   = 1'b0;
  //   pipe4_decd_lsfifo         = 1'b0;
  // end

  22'b0000011000???????_????? : // cacop (cache) // write into Cache, And Clear, invalidate L1 DCache 
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b1;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b0;
    pipe4_decd_icc            = 1'b1;
    pipe4_decd_st             = 1'b0;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b10;
    pipe4_decd_inst_size[1:0] = 2'b11;
    pipe4_decd_inst_mode[1:0] = 2'b00;
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end

  22'b00000110010010011_????? : // invtlb
  begin
    pipe4_decd_atomic         = 1'b0;
    pipe4_decd_sync_fence     = 1'b0;
    pipe4_decd_inst_flush     = 1'b0;
    pipe4_decd_inst_share     = 1'b1;
    pipe4_decd_icc            = 1'b1;
    pipe4_decd_st             = 1'b0;
    pipe4_decd_mmu_req        = 1'b0;
    pipe4_decd_inst_type[1:0] = 2'b00;
    pipe4_decd_inst_size[1:0] = 2'b00;
    pipe4_decd_inst_mode[1:0] = invtlb_inst_mode[1:0];
    pipe4_decd_fence_mode[3:0]= 4'b0000;
    pipe4_decd_inst_fls       = 1'b0;
    pipe4_decd_inst_vls       = 1'b0;
    pipe4_decd_offset[13:0]   = 14'b0;
    pipe4_decd_shift[3:0]     = 4'b0001;
    pipe4_decd_inst_str       = 1'b0;
    pipe4_decd_off_0_extend   = 1'b0;
    pipe4_decd_lsfifo         = 1'b0;
  end


  
  default:
  begin
    pipe4_decd_atomic         = 1'bx;
    pipe4_decd_sync_fence     = 1'bx;
    pipe4_decd_inst_flush     = 1'bx;
    pipe4_decd_inst_share     = 1'bx;
    pipe4_decd_icc            = 1'bx;
    pipe4_decd_st             = 1'bx;
    pipe4_decd_mmu_req        = 1'bx;
    pipe4_decd_inst_type[1:0] = {2{1'bx}};
    pipe4_decd_inst_size[1:0] = {2{1'bx}};
    pipe4_decd_inst_mode[1:0] = {2{1'bx}};
    pipe4_decd_fence_mode[3:0]= {4{1'bx}};
    pipe4_decd_inst_fls       = 1'bx;
    pipe4_decd_inst_vls       = 1'bx;
    pipe4_decd_offset[13:0]   = {14{1'bx}};
    pipe4_decd_shift[3:0]     = {4{1'bx}};
    pipe4_decd_inst_str       = 1'bx;
    pipe4_decd_off_0_extend   = 1'bx;
    pipe4_decd_lsfifo         = 1'bx;
  end
endcase
// &CombEnd; @1756
end

// &Force("output","pipe4_decd_offset"); @1758
// assign pipe4_decd_offset_plus[12:0] = 13'b0;
assign decd_plus_value[14:0] = (pipe4_decd_shift[3:0] == 4'b0100) ? 15'h4 : 15'h10;

assign pipe4_decd_offset_plus[14:0] = {pipe4_decd_offset[13],pipe4_decd_offset[13:0]}
                                      + decd_plus_value[14:0];

//for vector decode
// &Force("output","pipe4_decd_inst_vls"); @1764
// &Force("output","pipe4_decd_atomic"); @1765
// &Force("output","pipe4_decd_unit_stride"); @1766
// &Force("output","pipe4_decd_vmask_vld"); @1767
// &CombBeg; @1783
// &CombEnd; @1793
// &CombBeg; @1799
// &CombEnd; @1807
// &CombBeg; @1816
// &CombEnd; @1824
// &CombBeg; @1830
// &CombEnd; @1844
// &CombBeg; @1846
// &CombEnd; @1866
// &Force("nonport","pipe4_decd_inst_vls"); @1872
// &ModuleEnd; @1874
endmodule


