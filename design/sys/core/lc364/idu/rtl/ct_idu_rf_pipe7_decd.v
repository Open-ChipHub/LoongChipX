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
module ct_idu_rf_pipe7_decd (
  // &Ports, @28
  input    wire  [31:0]  pipe7_decd_opcode,
  input    wire  [1 :0]  pipe7_decd_vsew,
  output   wire  [11:0]  pipe7_decd_eu_sel,
  output   wire  [19:0]  pipe7_decd_func,
  output   wire  [2 :0]  pipe7_decd_imm0,
  output   wire  [5 :0]  pipe7_decd_inst_type,
  output   wire  [2 :0]  pipe7_decd_oper_size,
  output   wire  [2 :0]  pipe7_decd_ready_stage,
  output   wire  [4 :0]  pipe7_decd_vimm
); 



// &Regs; @29
reg     [4 :0]  decd_eu_sel;           
reg     [4 :0]  decd_fmau_eu_sel;      
reg     [19:0]  decd_fmau_func;        
reg     [2 :0]  decd_fmau_ready_stage; 
reg     [19:0]  decd_func;             
reg     [2 :0]  decd_ready_stage;      
reg     [11:0]  decd_vec_eu_sel;       
reg     [11:0]  decd_vec_eu_sel_0;     
reg     [11:0]  decd_vec_eu_sel_1;     
reg     [11:0]  decd_vec_eu_sel_2;     
reg     [19:0]  decd_vec_func;         
reg     [19:0]  decd_vec_func_0;       
reg     [19:0]  decd_vec_func_1;       
reg     [19:0]  decd_vec_func_2;       
reg     [2 :0]  decd_vec_ready_stage;  
reg     [2 :0]  decd_vec_ready_stage_0; 
reg     [2 :0]  decd_vec_ready_stage_1; 
reg     [2 :0]  decd_vec_ready_stage_2; 

// &Wires; @30
wire    [4 :0]  decd_fpu_eu_sel;       
wire    [19:0]  decd_fpu_func;         
wire    [2 :0]  decd_fpu_ready_stage;  
wire    [31:0]  decd_op;               
wire    [2 :0]  decd_scalar_size;      
wire    [1 :0]  decd_sew;              
wire            decd_vec_inst;         
wire            decd_vec_opi;          
wire            decd_vec_opm;     
wire            decd_inst_vfpu_half; 
wire            decd_inst_vfpu_single; 
wire            decd_inst_vfpu_double;   
wire  [2:0]     decd_inst_vfpu_round_mode;
wire            decd_inst_vfpu_round_mode_vld;
wire            decd_inst_vfpu_round_mode_rm;
wire            decd_inst_vfpu_round_mode_rp;
wire            decd_inst_vfpu_round_mode_rz;
wire            decd_inst_vfpu_round_mode_rne;  
wire    [19:0]  vfcvt_func;            
wire    [2 :0]  vfmadd_ready_stage;    
wire    [19:0]  vfmau_func_mask;       
wire    [2 :0]  vfmau_inst_size;       
wire    [2 :0]  vfmul_ready_stage;     


//==========================================================
//                    Rename Input
//==========================================================
assign decd_op[31:0] = pipe7_decd_opcode[31:0];

//==========================================================
//                       Immediate
//==========================================================
//----------------------------------------------------------
//                   Source 1 immediate
//----------------------------------------------------------
//3-bit rounding mode
wire is_arch_la = 1'b1;

assign decd_inst_vfpu_round_mode_rm = 
                (decd_op[31:10] == 22'b0000000100011010000001) || // ftintrm.w.s
                (decd_op[31:10] == 22'b0000000100011010000010) || // ftintrm.w.d
                (decd_op[31:10] == 22'b0000000100011010001001) || // ftintrm.l.s
                (decd_op[31:10] == 22'b0000000100011010001010);   // ftintrm.l.d

assign decd_inst_vfpu_round_mode_rp = 
                (decd_op[31:10] == 22'b0000000100011010010001) || // ftintrp.w.s
                (decd_op[31:10] == 22'b0000000100011010010010) || // ftintrp.w.d
                (decd_op[31:10] == 22'b0000000100011010011001) || // ftintrp.l.s
                (decd_op[31:10] == 22'b0000000100011010011010);   // ftintrp.l.d

assign decd_inst_vfpu_round_mode_rz = 
                (decd_op[31:10] == 22'b0000000100011010100001) || // ftintrz.w.s
                (decd_op[31:10] == 22'b0000000100011010100010) || // ftintrz.w.d
                (decd_op[31:10] == 22'b0000000100011010101001) || // ftintrz.l.s
                (decd_op[31:10] == 22'b0000000100011010101010);   // ftintrz.l.d 
  
assign decd_inst_vfpu_round_mode_rne = 
                (decd_op[31:10] == 22'b0000000100011010110001) || // ftintrne.w.s
                (decd_op[31:10] == 22'b0000000100011010110010) || // ftintrne.w.d
                (decd_op[31:10] == 22'b0000000100011010111001) || // ftintrne.l.s
                (decd_op[31:10] == 22'b0000000100011010111010);   // ftintrne.l.d

assign decd_inst_vfpu_round_mode_vld = decd_inst_vfpu_round_mode_rm ||
                                       decd_inst_vfpu_round_mode_rp ||
                                       decd_inst_vfpu_round_mode_rz ||
                                       decd_inst_vfpu_round_mode_rne;

assign decd_inst_vfpu_round_mode[2:0] = {3{decd_inst_vfpu_round_mode_rm}} & 3'b010 | // round minus infinity (negative)
                                        {3{decd_inst_vfpu_round_mode_rp}} & 3'b011 | // round positive
                                        {3{decd_inst_vfpu_round_mode_rz}} & 3'b001 | // round zero
                                        {3{decd_inst_vfpu_round_mode_rne}} & 3'b000; // round even

assign pipe7_decd_imm0[2:0]  = is_arch_la 
                                    ? decd_inst_vfpu_round_mode_vld ?  
                                        decd_inst_vfpu_round_mode[2:0]
                                      : 3'b111  // select fcsr round mode
                                    : decd_op[14:12];
//==========================================================
//                      Other Decode
//==========================================================
assign decd_inst_vfpu_half   = 1'b0;

assign decd_inst_vfpu_single = (decd_op[31:15] == 17'b00000001000001001) || // fmul.s
                               (decd_op[31:20] == 12'b000010000001)      || // fmadd.s
                               (decd_op[31:20] == 12'b000010000101)      || // fmsub.s
                               (decd_op[31:20] == 12'b000010001001)      || // fnmadd.s
                               (decd_op[31:20] == 12'b000010001101);        // fnmsub.s

assign decd_inst_vfpu_double = (decd_op[31:15] == 17'b00000001000001010) || // fmul.d
                               (decd_op[31:20] == 12'b000010000010)      || // fmadd.d
                               (decd_op[31:20] == 12'b000010000110)      || // fmsub.d
                               (decd_op[31:20] == 12'b000010001010)      || // fnmadd.d
                               (decd_op[31:20] == 12'b000010001110);        // fnmsub.d

assign decd_scalar_size[2:0]     = {decd_inst_vfpu_half,   //half
                                    decd_inst_vfpu_single, //single
                                    decd_inst_vfpu_double  //double
                                   };

assign pipe7_decd_inst_type[5:0] = {3'b0, decd_scalar_size[2:0]};
assign pipe7_decd_oper_size[2:0] = decd_scalar_size[2:0];

//==========================================================
//      Full Decoder for function and operand prepare
//==========================================================
//----------------------------------------------------------
//                Execution Units Define
//----------------------------------------------------------
parameter EU_WIDTH              = 5;
parameter FUNC_WIDTH            = 20;
parameter SRC_FUNC_WIDTH        = 12;
parameter READY_WIDTH           = 3;

parameter VEC_EU_WIDTH          = 12;
parameter VEC_FUNC_WIDTH        = 20;
parameter VEC_READY_WIDTH       = 3;


parameter FSPU                  = 5'b00001;
parameter FADD                  = 5'b00010;
parameter FCNVT                 = 5'b00100;
parameter FDSU                  = 5'b01000;
parameter FMAU                  = 5'b10000;

//----------------------------------------------------------
//             Execution Units Inst Func Macro
//----------------------------------------------------------
//VFDSU Func
//  19       18      17       16                                         10
//+-------+------+--------+--------+---------------------------------------+
//|  SIMD | HALF | SINGLE | DOUBLE |        RESERVED                       |
//+-------+------+--------+--------+---------------------------------------+

// 9                                                          1       0
//+--------------------------------------------------------+-------+-------+
//|                  RESERVED                              | FSQRT |  DIV  |
//+--------------------------------------------------------+-------+-------+
// Just Use Simple onehot
// Single
parameter FDIVS  = 20'b0010_00000000000000_01;
parameter FDIVRS = 20'b0010_10000000000001_01;
parameter FSQRTS = 20'b0010_00000000000000_10;
// Double
parameter FDIVD  = 20'b0001_00000000000000_01;
parameter FDIVRD = 20'b0001_00000000000001_01;
parameter FSQRTD = 20'b0001_00000000000000_10;


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
//|             |     | mv              |  xf  |  vf   |    fx |
//+------+------+-----+-----+----+------+------+-------+-------+

parameter VFSGNJ         = 20'b0000_0000_0000_0100_0001;
parameter VFSGNJX        = 20'b0000_0000_0000_0100_0100;
parameter VFSGNJN        = 20'b0000_0000_0000_0100_0010;
parameter VFCLASS        = 20'b0100_0000_0000_0000_0000;
parameter VFMERG         = 20'b0000_0000_0000_0010_0010;
parameter VFMVSF         = 20'b0000_0000_0000_0010_1000;
parameter VFMVFS         = 20'b0000_0000_0000_0011_0000;


//convert
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|      | cnvt |                    d_s | d_f  | s_f   |  s_s  |
//+------+------+-----+--+--------+------+------+-------+-------+
parameter VFCVTXUF          = 20'b0000_0000_0000_1000_0010;
parameter VFCVTXF           = 20'b0000_0000_0000_1000_1010;
parameter VFCVTFXU          = 20'b0000_0000_0000_1000_0100;
parameter VFCVTFX           = 20'b0000_0000_0000_1000_0101;
parameter VFWCVTXUF         = 20'b0000_0100_0000_1000_0010;
parameter VFWCVTXF          = 20'b0000_0100_0000_1000_1010;
parameter VFWCVTFXU         = 20'b0000_0100_0000_1000_0100;
parameter VFWCVTFX          = 20'b0000_0100_0000_1000_0101;
parameter VFWCVTFF          = 20'b0000_0100_0000_1000_0110;
parameter VFNCVTXUF         = 20'b0000_0010_0000_1000_0010;
parameter VFNCVTXF          = 20'b0000_0010_0000_1000_1010;
parameter VFNCVTFXU         = 20'b0000_0010_0000_1000_0100;
parameter VFNCVTFX          = 20'b0000_0010_0000_1000_0101;
parameter VFNCVTFF          = 20'b0000_0010_0000_1000_0110;


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

parameter VFADD        = 20'b0000_0001_0000_0000_0000;
parameter VFSUB        = 20'b0000_0000_1000_0000_0000;
parameter VFWADD       = 20'b0000_0111_0000_0000_0000;
parameter VFWSUB       = 20'b0000_0110_1000_0000_0000;
parameter VFWADDW      = 20'b0000_0001_0000_0000_0000;
parameter VFWSUBW      = 20'b0000_0000_1000_0000_0000;
parameter VFMIN        = 20'b0000_0000_0001_0000_0000;
parameter VFMAX        = 20'b0000_0000_0010_0000_0000;
parameter VFEQ         = 20'b0000_0000_0100_0000_0001;
parameter VFNE         = 20'b0000_0000_0100_0001_0000;
parameter VFLT         = 20'b0000_0000_0100_0000_0010;
parameter VFLE         = 20'b0000_0000_0100_0000_0100;
parameter VFORD        = 20'b0000_0000_0100_0000_1000;
parameter VFREDSUM     = 20'b0000_0001_0000_0000_0010;
parameter VFREDSUM64   = 20'b0000_0001_0000_0000_0011;
parameter VFOREDSUM    = 20'b0000_0001_0000_0000_0011;
parameter VFWREDSUM    = 20'b0000_0001_0000_0000_0010;
parameter VFWREDSUM64  = 20'b0000_0001_0000_0000_0011;
parameter VFWOREDSUM   = 20'b0000_0001_0000_0000_0011;
parameter VFREDMAX     = 20'b0000_0000_0010_0000_0010;
parameter VFREDMAX64   = 20'b0000_0000_0010_0000_0011;
parameter VFREDMIN     = 20'b0000_0000_0001_0000_0010;
parameter VFREDMIN64   = 20'b0000_0000_0001_0000_0011;

//Single
//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
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
//half
parameter FMV_SI16_F16 = 20'b0010_0000_0000_0010_0100;
parameter FMV_F16_SI16 = 20'b0010_0000_0000_0010_0001;
parameter FSGNJH       = 20'b0010_0000_0000_0100_0001;
parameter FSGNJNH      = 20'b0010_0000_0000_0100_0010;
parameter FSGNJXH      = 20'b0010_0000_0000_0100_0100;
parameter FCLASSH      = 20'b0110_0000_0000_0000_0000;

//single
parameter FMV_SI32_F32 = 20'b0010_1000_0000_0010_0100;
parameter FMV_F32_SI32 = 20'b0010_1000_0000_0010_0001;
parameter FMV_F32_F32  = 20'b0010_1000_0000_1000_0001;
parameter FSGNJS       = 20'b0010_1000_0000_0100_0001;
parameter FSGNJNS      = 20'b0010_1000_0000_0100_0010;
parameter FSGNJXS      = 20'b0010_1000_0000_0100_0100;
parameter FCLASSS      = 20'b0110_1000_0000_0000_0000;

parameter FLOGS        = 20'b0010_1000_0001_0000_0000;

//Double
parameter FMV_SI64_F64 = 20'b0011_0000_0000_0010_0100;
parameter FMV_F64_SI64 = 20'b0011_0000_0000_0010_0001;
parameter FMV_F64_F64  = 20'b0011_0000_0000_1000_0001;
parameter FMV_FH32_F64 = 20'b0011_0000_0000_0010_0010;
parameter FMV_F64_FH32 = 20'b0011_0000_0000_0010_1000;
parameter FSELD        = 20'b0011_0000_0000_0011_0000;
parameter FSGNJD       = 20'b0011_0000_0000_0100_0001;
parameter FSGNJND      = 20'b0011_0000_0000_0100_0010;
parameter FSGNJXD      = 20'b0011_0000_0000_0100_0100;
parameter FCLASSD      = 20'b0111_0000_0000_0000_0000;

parameter FLOGD        = 20'b0011_0000_0001_0000_0000;

//parameter VFCLASS      = 20'b0000_000000_001_0000_000;
//Scalar FADD

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
//half 
parameter FADDH = 20'b0010_0001_0000_0000_0000;     
parameter FSUBH = 20'b0010_0000_1000_0000_0000;
                                    
parameter FMAXH = 20'b0010_0000_0010_0000_0000;
parameter FMINH = 20'b0010_0000_0001_0000_0000;
                                    
parameter FEQH  = 20'b0010_0000_0100_0000_0001;
parameter FLTH  = 20'b0010_0000_0100_0000_0010;
parameter FLEH  = 20'b0010_0000_0100_0000_0100;



//Single
parameter FADDS = 20'b0010_1001_0000_0000_0000;     
parameter FSUBS = 20'b0010_1000_1000_0000_0000;
                                     
parameter FMAXS = 20'b0010_1000_0010_0000_0000;
parameter FMINS = 20'b0010_1000_0001_0000_0000;

parameter FMAXAS = 20'b0010_1000_0010_0000_0001;
parameter FMINAS = 20'b0010_1000_0001_0000_0001;
                                     
parameter FEQS  = 20'b0010_1000_0100_0000_0001;
parameter FLTS  = 20'b0010_1000_0100_0000_0010;
parameter FLES  = 20'b0010_1000_0100_0000_0100;

parameter FCMP_S_C_AF  = 20'b0010_1000_0100_0000_0000; 
parameter FCMP_S_C_UN  = 20'b0010_1000_0100_0000_0001; 
parameter FCMP_S_C_EQ  = 20'b0010_1000_0100_0000_0010; 
parameter FCMP_S_C_UEQ = 20'b0010_1000_0100_0000_0011; 
parameter FCMP_S_C_LT  = 20'b0010_1000_0100_0000_0100; 
parameter FCMP_S_C_ULT = 20'b0010_1000_0100_0000_0101; 
parameter FCMP_S_C_LE  = 20'b0010_1000_0100_0000_0110; 
parameter FCMP_S_C_ULE = 20'b0010_1000_0100_0000_0111; 
parameter FCMP_S_C_NE  = 20'b0010_1000_0100_0000_1000; 
parameter FCMP_S_C_OR  = 20'b0010_1000_0100_0000_1001; 
parameter FCMP_S_C_UNE = 20'b0010_1000_0100_0000_1010; 


parameter FCMP_S_S_AF  = 20'b0010_1000_0100_0001_0000; 
parameter FCMP_S_S_UN  = 20'b0010_1000_0100_0001_0001; 
parameter FCMP_S_S_EQ  = 20'b0010_1000_0100_0001_0010; 
parameter FCMP_S_S_UEQ = 20'b0010_1000_0100_0001_0011; 
parameter FCMP_S_S_LT  = 20'b0010_1000_0100_0001_0100; 
parameter FCMP_S_S_ULT = 20'b0010_1000_0100_0001_0101; 
parameter FCMP_S_S_LE  = 20'b0010_1000_0100_0001_0110; 
parameter FCMP_S_S_ULE = 20'b0010_1000_0100_0001_0111; 
parameter FCMP_S_S_NE  = 20'b0010_1000_0100_0001_1000; 
parameter FCMP_S_S_OR  = 20'b0010_1000_0100_0001_1001; 
parameter FCMP_S_S_UNE = 20'b0010_1000_0100_0001_1010; 
                                      
//Double                              
parameter FADDD = 20'b0011_0001_0000_0000_0000;     
parameter FSUBD = 20'b0011_0000_1000_0000_0000;
                                     
parameter FMAXD = 20'b0011_0000_0010_0000_0000;
parameter FMIND = 20'b0011_0000_0001_0000_0000;

parameter FMAXAD = 20'b0011_0000_0010_0000_0001;
parameter FMINAD = 20'b0011_0000_0001_0000_0001;
                                     
parameter FEQD  = 20'b0011_0000_0100_0000_0001;
parameter FLTD  = 20'b0011_0000_0100_0000_0010;
parameter FLED  = 20'b0011_0000_0100_0000_0100;

parameter FCMP_D_C_AF  = 20'b0011_0000_0100_0000_0000; 
parameter FCMP_D_C_UN  = 20'b0011_0000_0100_0000_0001; 
parameter FCMP_D_C_EQ  = 20'b0011_0000_0100_0000_0010; 
parameter FCMP_D_C_UEQ = 20'b0011_0000_0100_0000_0011; 
parameter FCMP_D_C_LT  = 20'b0011_0000_0100_0000_0100; 
parameter FCMP_D_C_ULT = 20'b0011_0000_0100_0000_0101; 
parameter FCMP_D_C_LE  = 20'b0011_0000_0100_0000_0110; 
parameter FCMP_D_C_ULE = 20'b0011_0000_0100_0000_0111; 
parameter FCMP_D_C_NE  = 20'b0011_0000_0100_0000_1000; 
parameter FCMP_D_C_OR  = 20'b0011_0000_0100_0000_1001; 
parameter FCMP_D_C_UNE = 20'b0011_0000_0100_0000_1010; 

parameter FCMP_D_S_AF  = 20'b0011_0000_0100_0001_0000; 
parameter FCMP_D_S_UN  = 20'b0011_0000_0100_0001_0001; 
parameter FCMP_D_S_EQ  = 20'b0011_0000_0100_0001_0010; 
parameter FCMP_D_S_UEQ = 20'b0011_0000_0100_0001_0011; 
parameter FCMP_D_S_LT  = 20'b0011_0000_0100_0001_0100; 
parameter FCMP_D_S_ULT = 20'b0011_0000_0100_0001_0101; 
parameter FCMP_D_S_LE  = 20'b0011_0000_0100_0001_0110; 
parameter FCMP_D_S_ULE = 20'b0011_0000_0100_0001_0111; 
parameter FCMP_D_S_NE  = 20'b0011_0000_0100_0001_1000; 
parameter FCMP_D_S_OR  = 20'b0011_0000_0100_0001_1001; 
parameter FCMP_D_S_UNE = 20'b0011_0000_0100_0001_1010; 


//Scalar FCNVT Func
//  19       18      17       16                                         10
//+-------+------+--------+--------+---------------------------------------+
//|  SIMD | HALF | SINGLE | DOUBLE |        RESERVED                       |
//+-------+------+--------+--------+---------------------------------------+

//    9                                  5     4      3     2     1     0
//+----------------------------------+------+------+-----+-----+-----+-----+
//|  ITOF |      RESERVED            |   D  |  S   | LU  |  L  |  WU |  W  |
//+----------------------------------+------+------+-----+-----+-----+-----+
//ITOF: 1: covert integer to floating-point
//      0: covert floating-point to intege
//
//  19  18   17      16       15      14     13   12  11  10    9  
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//|   clas|SCAlAR| DOUBLE |SINGLE|WIDDEN|WIDDEN2|ADD|sub|cmp| max | 
//+---+---+------+--------+------+------+-------+---+---+---+-----+-------+
//  8       7      6    5     4 
//+------+------+-----+--+--------+------+------+-------+-----------------+
//|  min | cnvt | sgn | mv |  |
//+------+------+-----+--+--------+------+------+-------+-----------------+
//convert
//  8       7      6    5     4      3      2        1       0
//+------+------+-----+--+--------+------+------+-------+-------+
//|      | cnvt |                    d_s | d_f  | s_f   |  s_s  |
//+------+------+-----+--+--------+------+------+-------+-------+
//half
parameter FCVT_SI16_F16  = 20'b0010_0000_0000_1000_1010;
parameter FCVT_UI16_F16  = 20'b0010_0000_0000_1000_0010;
parameter FCVT_SI32_F16  = 20'b0010_0100_0000_1000_1010;
parameter FCVT_UI32_F16  = 20'b0010_0100_0000_1000_0010;
parameter FCVT_F16_SI16  = 20'b0010_0000_0010_1000_0101;
parameter FCVT_F16_UI16  = 20'b0010_0000_0010_1000_0100;
parameter FCVT_F16_SI32  = 20'b0010_0010_0010_1000_0101;
parameter FCVT_F16_UI32  = 20'b0010_0010_0010_1000_0100;
parameter FCVT_F16_F32   = 20'b0010_0010_0000_1000_0110;
parameter FCVT_F32_F16   = 20'b0010_0100_0000_1000_0110;

parameter FCVT_SI64_F16  = 20'b0010_0110_0000_1000_1010;
parameter FCVT_UI64_F16  = 20'b0010_0110_0000_1000_0010;
parameter FCVT_F16_SI64  = 20'b0011_0110_0000_1000_0101;
parameter FCVT_F16_UI64  = 20'b0011_0110_0000_1000_0100;
parameter FCVT_F16_F64   = 20'b0011_0110_0000_1000_0110;
parameter FCVT_F64_F16   = 20'b0010_0110_0000_1000_0110;
//single
parameter FCVT_SI32_F32  = 20'b0010_1000_0000_1000_1010;
parameter FCVT_UI32_F32  = 20'b0010_1000_0000_1000_0010;
parameter FCVT_SI64_F32  = 20'b0010_1100_0000_1000_1010;
parameter FCVT_UI64_F32  = 20'b0010_1100_0000_1000_0010;
parameter FCVT_F32_SI32  = 20'b0010_1000_0010_1000_0101;
parameter FCVT_F32_UI32  = 20'b0010_1000_0010_1000_0100;
parameter FCVT_F32_SI64  = 20'b0010_1010_0010_1000_0101;
parameter FCVT_F32_UI64  = 20'b0010_1010_0010_1000_0100;

//Double
parameter FCVT_SI32_F64  = 20'b0010_1010_0000_1000_1010;
parameter FCVT_UI32_F64  = 20'b0010_1010_0000_1000_0010;
parameter FCVT_SI64_F64  = 20'b0011_0000_0000_1000_1010;
parameter FCVT_UI64_F64  = 20'b0011_0000_0000_1000_0010;
parameter FCVT_F64_SI32  = 20'b0010_1100_0010_1000_0101;
parameter FCVT_F64_UI32  = 20'b0010_1100_0010_1000_0100;
parameter FCVT_F64_SI64  = 20'b0011_0000_0010_1000_0101;
parameter FCVT_F64_UI64  = 20'b0011_0000_0010_1000_0100;
parameter FCVT_F32_F64   = 20'b0010_1010_0000_1000_0110;
parameter FCVT_F64_F32   = 20'b0010_1100_0000_1000_0110;


//VFMAU
//  19       18      17       16                                         10
//+-------+------+--------+--------+---------------------------------------+
//|  SIMD | HALF | SINGLE | DOUBLE |        RESERVED                       |
//+-------+------+--------+--------+---------------------------------------+

// 9                                 4        3        2       1       0
//+-----------------------------+--------+---------+-------+-------+-------+
//|                  RESERVED   | CHANGE |  WIDEN  |  NEG  |  SUB  | FUSED |
//+-----------------------------+--------+---------+-------+-------+-------+

//VFMAU  scalar
//1. single
parameter FMULS   = 20'b0010_0000000000000_000;
// pseudo fscaleb.s
parameter FSCALEBS = 20'b0010_0000000000100_000;

parameter FMADDS  = 20'b0010_0000000000000_001;
parameter FMSUBS  = 20'b0010_0000000000000_011;
parameter FNMSUBS = 20'b0010_0000000000000_111;
parameter FNMADDS = 20'b0010_0000000000000_101;

//2. double
parameter FMULD   = 20'b0001_0000000000000_000;
// pseudo fscaleb.d
parameter FSCALEBD = 20'b0001_0000000000100_000;

parameter FMADDD  = 20'b0001_0000000000000_001;
parameter FMSUBD  = 20'b0001_0000000000000_011;
parameter FNMSUBD = 20'b0001_0000000000000_111;
parameter FNMADDD = 20'b0001_0000000000000_101;

//3. half
parameter FMULH    = 20'b0100_0000000000000_000;

parameter FMADDH   = 20'b0100_0000000000000_001;
parameter FMSUBH   = 20'b0100_0000000000000_011;
parameter FNMSUBH  = 20'b0100_0000000000000_111;
parameter FNMADDH  = 20'b0100_0000000000000_101;

//VFMAU simd
parameter VFMUL    = 20'b1000_0000000000000_000;
parameter VFWMUL   = 20'b1000_0000000000001_000;

parameter VFMACC   = 20'b1000_0000000000000_001;
parameter VFNMACC  = 20'b1000_0000000000000_101;
parameter VFMSAC   = 20'b1000_0000000000000_011;
parameter VFNMSAC  = 20'b1000_0000000000000_111;
parameter VFMADD   = 20'b1000_0000000000010_001;
parameter VFNMADD  = 20'b1000_0000000000010_101;
parameter VFMSUB   = 20'b1000_0000000000010_011;
parameter VFNMSUB  = 20'b1000_0000000000010_111;

parameter VFWMACC  = 20'b1000_0000000000001_001;
parameter VFWNMACC = 20'b1000_0000000000001_101;
parameter VFWMSAC  = 20'b1000_0000000000001_011;
parameter VFWNMSAC = 20'b1000_0000000000001_111;

//----------------------------------------------------------
//                  Rename for Output
//----------------------------------------------------------
assign decd_fpu_eu_sel[EU_WIDTH-1:0] = (decd_op[31:24] == 8'b00001000)
                                      ? decd_fmau_eu_sel[EU_WIDTH-1:0]                                       
                                      : decd_eu_sel[EU_WIDTH-1:0];

assign decd_fpu_func[FUNC_WIDTH-1:0] = (decd_op[31:24] == 8'b00001000)
                                      ? decd_fmau_func[FUNC_WIDTH-1:0]
                                      : decd_func[FUNC_WIDTH-1:0];

assign decd_fpu_ready_stage[2:0] = (decd_op[31:24] == 8'b00001000)
                                  ? decd_fmau_ready_stage[2:0]
                                  : decd_ready_stage[2:0];

assign decd_vec_inst = 1'b0;

assign decd_sew[1:0] = pipe7_decd_vsew[1:0];

assign pipe7_decd_eu_sel[VEC_EU_WIDTH-1:0] = decd_vec_inst ? decd_vec_eu_sel[VEC_EU_WIDTH-1:0]
                                                           : { {7{1'b0}},decd_fpu_eu_sel[EU_WIDTH-1:0] };

assign pipe7_decd_func[FUNC_WIDTH-1:0]  = decd_vec_inst ? decd_vec_func[FUNC_WIDTH-1:0]
                                                        : decd_fpu_func[FUNC_WIDTH-1:0];

assign pipe7_decd_ready_stage[2:0]      = decd_vec_inst ? decd_vec_ready_stage[2:0]
                                                        : decd_fpu_ready_stage[2:0]; 

assign pipe7_decd_vimm[4:0] = decd_op[19:15];
//----------------------------------------------------------
//        Full Decoder(Except fused multiply add)
//----------------------------------------------------------
// &CombBeg; @459
always @(  decd_op[31:15]
        or decd_op[14:10])
begin
  //initialize decoded information value
decd_eu_sel[EU_WIDTH-1:0]          = {EU_WIDTH{1'b0}};
decd_func[FUNC_WIDTH-1:0]          = 20'b0;
decd_ready_stage[READY_WIDTH-1:0]  = 3'b0;


casez({decd_op[31:15], decd_op[14:10]})
  22'b0000000100010100100101: begin   // fmov.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_F32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end
  22'b0000000100010100100110: begin   // fmov.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_F64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end
  22'b0000000100010100101101: begin   // movfr2gr.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_SI32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end
  22'b0000000100010100101110: begin   // movfr2gr.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end
  22'b0000000100010100101011: begin   // movgr2frh.w
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_FH32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end
  22'b0000000100010100101111: begin   // movfrh2gr.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_F64_FH32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end
  22'b0000000100010100110100: begin   // movfr2cf
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FMV_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
  end

  //------------------- single --------------------//
  22'b000011000001_00000_?????: begin // fcmp.caf.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_AF;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01000_?????: begin // fcmp.cun.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_UN;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_00100_?????: begin // fcmp.ceq.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_EQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01100_?????: begin // fcmp.cueq.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_UEQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_00010_?????: begin // fcmp.clt.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_LT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01010_?????: begin // fcmp.cult.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_ULT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_00110_?????: begin // fcmp.cle.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_LE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01110_?????: begin // fcmp.cule.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_ULE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_10000_?????: begin // fcmp.cne.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_NE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_10100_?????: begin // fcmp.cor.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_OR;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_11000_?????: begin // fcmp.cune.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_C_UNE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  //------------------- double --------------------//
  22'b000011000010_00000_?????: begin // fcmp.caf.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_AF;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01000_?????: begin // fcmp.cun.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_UN;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_00100_?????: begin // fcmp.ceq.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_EQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01100_?????: begin // fcmp.cueq.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_UEQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_00010_?????: begin // fcmp.clt.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_LT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01010_?????: begin // fcmp.cult.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_ULT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_00110_?????: begin // fcmp.cle.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_LE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01110_?????: begin // fcmp.cule.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_ULE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_10000_?????: begin // fcmp.cne.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_NE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_10100_?????: begin // fcmp.cor.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_OR;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_11000_?????: begin // fcmp.cune.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_C_UNE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  //------------------- single --------------------//
  22'b000011000001_00001_?????: begin // fcmp.saf.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_AF;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01001_?????: begin // fcmp.sun.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_UN;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_00101_?????: begin // fcmp.seq.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_EQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01101_?????: begin // fcmp.sueq.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_UEQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_00011_?????: begin // fcmp.slt.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_LT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01011_?????: begin // fcmp.sult.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_ULT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_00111_?????: begin // fcmp.sle.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_LE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_01111_?????: begin // fcmp.sule.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_ULE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_10001_?????: begin // fcmp.sne.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_NE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_10101_?????: begin // fcmp.sor.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_OR;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000001_11001_?????: begin // fcmp.sune.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_S_S_UNE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  //------------------- double --------------------//
  22'b000011000010_00001_?????: begin // fcmp.saf.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_AF;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01001_?????: begin // fcmp.sun.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_UN;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_00101_?????: begin // fcmp.seq.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_EQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01101_?????: begin // fcmp.sueq.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_UEQ;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_00011_?????: begin // fcmp.slt.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_LT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01011_?????: begin // fcmp.sult.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_ULT;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_00111_?????: begin // fcmp.sle.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_LE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_01111_?????: begin // fcmp.sule.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_ULE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_10001_?????: begin // fcmp.sne.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_NE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_10101_?????: begin // fcmp.sor.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_OR;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b000011000010_11001_?????: begin // fcmp.sune.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FCMP_D_S_UNE;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  
  //---------------------------------------------------//
  22'b00000001000000001_?????: begin //fadd.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FADDS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000000010_?????: begin //fadd.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FADDD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000000101_?????: begin //fsub.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FSUBS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000000110_?????: begin //fsub.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FSUBD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000001001_?????: begin //fmul.s
    decd_eu_sel[EU_WIDTH-1:0]         = FMAU;
    decd_func[FUNC_WIDTH-1:0]         = FMULS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b010;
  end
  22'b00000001000001010_?????: begin //fmul.d
    decd_eu_sel[EU_WIDTH-1:0]         = FMAU;
    decd_func[FUNC_WIDTH-1:0]         = FMULD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b010;
  end
  22'b00000001000010001_?????: begin //fmax.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMAXS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000010010_?????: begin //fmax.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMAXD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000010101_?????: begin //fmin.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMINS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000010110_?????: begin //fmin.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMIND;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b00000001000011001_?????: begin //fmaxa.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMAXAS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000011010_?????: begin //fmaxa.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMAXAD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000011101_?????: begin //fmina.s
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMINAS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b00000001000011110_?????: begin //fmina.d
    decd_eu_sel[EU_WIDTH-1:0]         = FADD;
    decd_func[FUNC_WIDTH-1:0]         = FMINAD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b000011010000_00???_?????: begin // fsel
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSELD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
    end

  22'b00000001000100001_?????: begin //fscaleb.s
    decd_eu_sel[EU_WIDTH-1:0]         = FMAU;
    decd_func[FUNC_WIDTH-1:0]         = FSCALEBS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b010;
    end
  22'b00000001000100010_?????: begin //fscaleb.d
    decd_eu_sel[EU_WIDTH-1:0]         = FMAU;
    decd_func[FUNC_WIDTH-1:0]         = FSCALEBD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b010;
    end

  22'b00000001000100101_?????: begin //copysign.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSGNJS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b00000001000100110_?????: begin //copysign.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSGNJD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100000001: begin //fabs.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSGNJXS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100000010: begin //fabs.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSGNJXD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100000101: begin //fneg.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSGNJNS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100000110: begin //fneg.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FSGNJND;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100001001: begin //flogb.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FLOGS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100001010: begin //flogb.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FLOGD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
    end
  22'b0000000100010100001101: begin //fclass.s
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FCLASSS;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
    end
  22'b0000000100010100001110: begin //fclass.d
    decd_eu_sel[EU_WIDTH-1:0]         = FSPU;
    decd_func[FUNC_WIDTH-1:0]         = FCLASSD;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b0;
    end

  //-------------------------------------------------------//
  22'b0000000100011001000110: begin   //fcvt.s.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_F32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011001001001: begin   //fcvt.d.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_F64_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b0000000100011101000100: begin   //pseudo_fcvt.s.w / ffint.s.w
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_F32_SI32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011101000110: begin   //pseudo fcvt.s.l / ffint.s.l
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_F32_SI64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011101001000: begin   //pseudo fcvt.d.w / ffint.d.w
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_F64_SI32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011101001010: begin   //pseudo fcvt.d.l / ffint.d.l
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_F64_SI64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b0000000100011011000001: begin   //pseudo_fcvt.w.s / ftint.w.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011011000010: begin   //pseudo fcvt.w.d / ftint.w.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011011001001: begin   //pseudo fcvt.l.s / ftint.l.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011011001010: begin   //pseudo fcvt.l.d / ftint.l.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b0000000100011010000001: begin   // ftintrm.w.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010000010: begin   // ftintrm.w.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010001001: begin   // ftintrm.l.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010001010: begin   // ftintrm.l.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b0000000100011010010001: begin   // ftintrp.w.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010010010: begin   // ftintrp.w.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010011001: begin   // ftintrp.l.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010011010: begin   // ftintrp.l.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b0000000100011010100001: begin   // ftintrz.w.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010100010: begin   // ftintrz.w.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010101001: begin   // ftintrz.l.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010101010: begin   // ftintrz.l.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  22'b0000000100011010110001: begin   // ftintrne.w.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010110010: begin   // ftintrne.w.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI32_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010111001: begin   // ftintrne.l.s
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F32;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end
  22'b0000000100011010111010: begin   // ftintrne.l.d
    decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
    decd_func[FUNC_WIDTH-1:0]         = FCVT_SI64_F64;
    decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  end

  //// unsigned 
  // 11'b110000001?? : begin   //pseudo_fcvt.wu.s
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_UI32_F32;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110100001?? : begin   //pseudo_fcvt.s.wu
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_F32_UI32;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110000011?? : begin   //pseudo fcvt.lu.s
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_UI64_F32;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110100011?? : begin   //pseudo fcvt.s.lu
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_F32_UI64;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110000101?? : begin   //pseudo fcvt.wu.d
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_UI32_F64;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110100101?? : begin   //pseudo fcvt.d.wu
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_F64_UI32;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110000111?? : begin   //pseudo fcvt.lu.d
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_UI64_F64;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end
  // 11'b110100111?? : begin   //pseudo fcvt.d.lu
  //   decd_eu_sel[EU_WIDTH-1:0]         = FCNVT;
  //   decd_func[FUNC_WIDTH-1:0]         = FCVT_F64_UI64;
  //   decd_ready_stage[READY_WIDTH-1:0] = 3'b001;
  // end

  default           : begin   
  end
endcase
// &CombEnd @799
end



//----------------------------------------------------------
//        Full Decoder(fused multiply add)
//----------------------------------------------------------
// &CombBeg; @863
always @(decd_op[31:20])
begin
  //initialize decoded information value
decd_fmau_eu_sel[EU_WIDTH-1:0]          = {EU_WIDTH{1'b0}};
decd_fmau_func[FUNC_WIDTH-1:0]          = 20'b0;
decd_fmau_ready_stage[READY_WIDTH-1:0]  = 3'b0;

casez({decd_op[31:20]})
    12'b000010000001: begin //fmadd.s
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FMADDS;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010000010: begin //fmadd.d
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FMADDD;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010000101: begin //fmsub.s
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FMSUBS;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010000110: begin //fmsub.d
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FMSUBD;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010001001: begin //fnmadd.s
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FNMADDS;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010001010: begin //fnmadd.d
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FNMADDD;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010001101: begin //fnmsub.s
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FNMSUBS;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
    12'b000010001110: begin //fnmsub.d
      decd_fmau_eu_sel[EU_WIDTH-1:0]         = FMAU;
      decd_fmau_func[FUNC_WIDTH-1:0]         = FNMSUBD;
      decd_fmau_ready_stage[READY_WIDTH-1:0] = 3'b100;
      end
  default           : begin   
  end
endcase
// &CombEnd @874
end

//==========================================================
//      Full Decoder for function and operand prepare
//==========================================================
//----------------------------------------------------------
//                Execution Units Define
//----------------------------------------------------------
parameter VALU                  = 12'b0000001_00000;
parameter VPERM                 = 12'b0000010_00000;
parameter VMISC                 = 12'b0000100_00000;
parameter VREDU                 = 12'b0001000_00000;
parameter VSHIFT                = 12'b0010000_00000;
parameter VMULU                 = 12'b0100000_00000;
parameter VDIRU                 = 12'b1000000_00000;

parameter EX3_READY             = 3'b001;
parameter EX4_READY             = 3'b010;
parameter EX5_READY             = 3'b100;
parameter DIV_READY             = 3'b000;
//----------------------------------------------------------
//             Execution Units Inst Func Macro
//----------------------------------------------------------
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//| VMV  | VMG  | DSTW |SRC2W |      | CMP  | ADD  | C_IN |C_OUT | SIGN |ROUND | SAT  |
//-------------------------------------------------------------------------------------
parameter VADD    = 20'b0000_0000_0000_0010_0000;
parameter VSUB    = 20'b0000_0000_0000_0000_0000;
parameter VRSUB   = 20'b0000_0000_0000_0000_0000;
parameter VWADDU  = 20'b0000_0000_0010_0010_0000;
parameter VWADD   = 20'b0000_0000_0010_0010_0100;
parameter VWSUBU  = 20'b0000_0000_0010_0000_0000;
parameter VWSUB   = 20'b0000_0000_0010_0000_0100;
parameter VWADDUW = 20'b0000_0000_0011_0010_0000;
parameter VWADDW  = 20'b0000_0000_0011_0010_0100;
parameter VWSUBUW = 20'b0000_0000_0011_0000_0000;
parameter VWSUBW  = 20'b0000_0000_0011_0000_0100;
parameter VADC    = 20'b0000_0000_0000_0011_0000;
parameter VMADC   = 20'b0000_0000_0000_0011_1000;
parameter VSBC    = 20'b0000_0000_0000_0001_0000;
parameter VMSBC   = 20'b0000_0000_0000_0001_1000;
parameter VAADD   = 20'b0000_0000_0000_0010_0110;
parameter VASUB   = 20'b0000_0000_0000_0000_0110;
parameter VSADDU  = 20'b0000_0000_0000_0010_0001;
parameter VSADD   = 20'b0000_0000_0000_0010_0101;
parameter VSSUBU  = 20'b0000_0000_0000_0000_0001;
parameter VSSUB   = 20'b0000_0000_0000_0000_0101;

parameter VMSEQ   = 20'b0000_0000_0000_0100_1100;
parameter VMSNE   = 20'b0000_0000_0000_0100_0100;
parameter VMSLTU  = 20'b0000_0000_0000_0101_0000;
parameter VMSLT   = 20'b0000_0000_0000_0101_0100;
parameter VMSLEU  = 20'b0000_0000_0000_0101_1000;
parameter VMSLE   = 20'b0000_0000_0000_0101_1100;
parameter VMSGTU  = 20'b0000_0000_0000_0101_0000;
parameter VMSGT   = 20'b0000_0000_0000_0101_0100;

parameter VMINU   = 20'b0000_0000_0100_0110_0000;
parameter VMIN    = 20'b0000_0000_0100_0110_0100;
parameter VMAXU   = 20'b0000_0000_0000_0110_0000;
parameter VMAX    = 20'b0000_0000_0000_0110_0100;

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |      | SLUP |SLDOWN|STRID1|GATHER|VIOTA |      | VEXT |
//-------------------------------------------------------------------------------------
parameter VEXT        = 20'b0000_0000_0000_0000_0001;
parameter VSLIDEUP    = 20'b0000_0000_0000_0100_1000;
parameter VSLIDEDOWN  = 20'b0000_0000_0000_0010_1000;
parameter VSLIDE1UP   = 20'b0000_0000_0000_0101_0000;
parameter VSLIDE1DOWN = 20'b0000_0000_0000_0011_0000;
parameter VRGATHERVV  = 20'b0000_0000_0000_0000_1000;
parameter VRGATHERVK  = 20'b0000_0000_0100_0000_1000;
parameter VCOMPRESS   = 20'b0000_0000_0000_0000_1100;
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//| VMV  | VMG  | XOR  |  OR  | AND  |      |      |      |      |LOGIC |      |      |
//-------------------------------------------------------------------------------------
parameter VAND    = 20'b0000_0000_0000_1000_0100;               
parameter VORR    = 20'b0000_0000_0001_0000_0100;               
parameter VXOR    = 20'b0000_0000_0010_0000_0100;               
parameter VMGE    = 20'b0000_0000_0100_0000_0100;               
parameter VMOV    = 20'b0000_0000_1000_0000_0100;               
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//| NOTB | NOTA | XOR  |  OR  | AND  | AND  |      |      | MLG  |      |      |      |
//-------------------------------------------------------------------------------------
parameter VMAND    = 20'b0000_0000_0000_1000_1000;               
parameter VMNAND   = 20'b0000_0000_0100_1000_1000;               
parameter VMANDN   = 20'b0000_0000_1000_1000_1000;               
parameter VMXOR    = 20'b0000_0000_0010_0000_1000;               
parameter VMNXOR   = 20'b0000_0000_0110_0000_1000;               
parameter VMORR    = 20'b0000_0000_0001_0000_1000;               
parameter VMNORR   = 20'b0000_0000_0101_0000_1000;               
parameter VMORRN   = 20'b0000_0000_1001_0000_1000;               
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |MUNARY|FIRST | POPC | MSK  |      |      |      |      |
//-------------------------------------------------------------------------------------
parameter VMPOP    = 20'b0000_0000_0000_0011_0000;               
parameter VMFIRST  = 20'b0000_0000_0000_0101_0000;               
parameter VMUNARY0 = 20'b0000_0000_0000_1001_0000;      
//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|WIDEN | SIGN | MIN  | MAX  | SUM  | XOR  |  OR  | AND  |LOGIC |      |      |      |
//-------------------------------------------------------------------------------------
parameter VREDAND    = 20'b0000_0000_0000_0001_1000;
parameter VREDORR    = 20'b0000_0000_0000_0010_1000;
parameter VREDXOR    = 20'b0000_0000_0000_0100_1000;
parameter VREDSUM    = 20'b0000_0000_0000_1000_0000;
parameter VREDMAXU   = 20'b0000_0000_0001_0000_0000;
parameter VREDMAX    = 20'b0000_0000_0101_0000_0000;
parameter VREDMINU   = 20'b0000_0000_0010_0000_0000;
parameter VREDMIN    = 20'b0000_0000_0110_0000_0000;
parameter VWREDSUMU  = 20'b0000_0000_1000_1000_0000;
parameter VWREDSUM   = 20'b0000_0000_1100_1000_0000;

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |      |      |      |      |ARITH |NARROW|ROUND | LEFT |
//-------------------------------------------------------------------------------------
parameter VSLL       = 20'b0000_0000_0000_0000_0001;
parameter VSRL       = 20'b0000_0000_0000_0000_0000;
parameter VSRA       = 20'b0000_0000_0000_0000_1000;
parameter VSSRL      = 20'b0000_0000_0000_0000_0100;
parameter VSSRA      = 20'b0000_0000_0000_0000_1100;
parameter VNSRL      = 20'b0000_0000_0000_0000_0010;
parameter VNSLA      = 20'b0000_0000_0000_0000_1010;
parameter VNCLIPU    = 20'b0000_0000_0000_0000_0110;
parameter VNCLIP     = 20'b0000_0000_0000_0000_1110;

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|SEW/2 |SEW-1 |RECUR | SUB  | ACC  | SAT  |ROUND | WIDE | LOW  | HIGH |SIGN1 |SIGN0 |
//-------------------------------------------------------------------------------------
parameter VMUL       = 20'b0000_0000_0000_0000_1000;
parameter VMULH      = 20'b0000_0000_0000_0000_0111;
parameter VMULHU     = 20'b0000_0000_0000_0000_0100;
parameter VMULHSU    = 20'b0000_0000_0000_0000_0101;
parameter VMACC      = 20'b0000_0000_0000_1000_1000;
parameter VNMSAC     = 20'b0000_0000_0001_1000_1000;
parameter VMADD      = 20'b0000_0000_0010_1000_1000;
parameter VNMSUB     = 20'b0000_0000_0011_1000_1000;
parameter VSMUL      = 20'b0000_0000_0100_0110_0111;
parameter VWMUL      = 20'b0000_0000_0000_0001_0011;
parameter VWMULU     = 20'b0000_0000_0000_0001_0000;
parameter VWMULSU    = 20'b0000_0000_0000_0001_0001;
parameter VWMACCU    = 20'b0000_0000_0000_1001_0000;
parameter VWMACC     = 20'b0000_0000_0000_1001_0011;
parameter VWMACCSU   = 20'b0000_0000_0000_1001_0010;
parameter VWMACCUS   = 20'b0000_0000_0000_1001_0001;
parameter VWSMACCU   = 20'b0000_0000_1000_1111_0000;
parameter VWSMACC    = 20'b0000_0000_1000_1111_0011;
parameter VWSMACCSU  = 20'b0000_0000_1001_1111_0010;
parameter VWSMACCUS  = 20'b0000_0000_1001_1111_0001;

//-------------------------------------------------------------------------------------
//|  11  |  10  |  9   |  8   |  7   |  6   |  5   |  4   |  3   |  2   |  1   |  0   |
//-------------------------------------------------------------------------------------
//|      |      |      |      |      | SIGN | REM  | DIV  |      |      |      |      |
//-------------------------------------------------------------------------------------
parameter VDIVU  = 20'b0000_0000_0000_0001_0000;
parameter VDIV   = 20'b0000_0000_0000_0101_0000;
parameter VREMU  = 20'b0000_0000_0000_0010_0000;
parameter VREM   = 20'b0000_0000_0000_0110_0000;

//----------------------------------------------------------
//                  Rename for Output
//----------------------------------------------------------
// &CombBeg; @1111
always @( decd_op[31:25]
       or decd_sew[1]
       or decd_op[14:12])
begin
  //initialize decoded information value
decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = {VEC_EU_WIDTH{1'b0}};
decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = {VEC_FUNC_WIDTH{1'b0}};
decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = {VEC_READY_WIDTH{1'b0}};
  casez({decd_op[31:26]})
    6'b000000:begin //vadd.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VADD;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b000010:begin //vsub.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSUB;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b000011:begin //vrsub.vx always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VRSUB;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b000100:begin //vminu.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMINU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b000101:begin //vmin.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMIN;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b000110:begin //vmaxu.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMAXU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b000111:begin //vmax.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMAX;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b001001:begin //vand.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VAND;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b001010:begin //vor.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VORR;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b001011:begin //vxor.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VXOR;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b001100:begin //vrgather.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = !(|decd_op[14:12]) ? VRGATHERVV : VRGATHERVK;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b001110:begin //vslideup.vx always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSLIDEUP;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b001111:begin //vslidedown.vx always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSLIDEDOWN;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010000:begin //vadc.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VADC;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010001:begin //vmadc.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMADC;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010010:begin //vsbc.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSBC;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010011:begin //vmsbc.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSBC;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010111:begin //vmerge/vmv.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = decd_op[25] ? VMOV : VMGE;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011000:begin //vmseq.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSEQ;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011001:begin //vmsne.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSNE;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011010:begin //vmsltu.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSLTU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011011:begin //vmslt.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSLT;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011100:begin //vmsleu.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSLEU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011101:begin //vmsle.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSLE;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011110:begin //vmsgtu.vx always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSGTU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011111:begin //vmsgt.vx always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VMSGT;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100000:begin //vsaddu.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSADDU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100001:begin //vsadd.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSADD;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100010:begin //vssubu.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSSUBU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100011:begin //vssub.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSSUB;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100100:begin //vaadd.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VAADD;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
//    6'b100101:begin //vsll.vv
//      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VSHIFT;
//      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSLL;
//      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
//      end
    6'b100110:begin //vasub.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VASUB;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100111:begin //vsmul.vv
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VSMUL;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = decd_sew[1] ? EX4_READY : EX3_READY;
      end
    6'b111100:begin //vwsmaccu.vv always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VWSMACCU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b111101:begin //vwsmacc.vv always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VWSMACC;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b111110:begin //vwsmaccsu.vv always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VWSMACCSU;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b111111:begin //vwsmaccus.vv always split
      decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_0[VEC_FUNC_WIDTH-1:0]          = VWSMACCUS;
      decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    default: begin   
      end
endcase
// &CombEnd; @1360
end


// &CombBeg; @1363
always @( decd_sew[1]
       or decd_op[31:26])
begin
  //initialize decoded information value
decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = {VEC_EU_WIDTH{1'b0}};
decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = {VEC_FUNC_WIDTH{1'b0}};
decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = {VEC_READY_WIDTH{1'b0}};
  casez({decd_op[31:26]})
    6'b001100:begin //vext.x.v(mfvr) only rs1==x0
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VEXT;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = 3'b0;
      end
    6'b001110:begin //vslide1up.vx
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VSLIDE1UP;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
       end
    6'b001111:begin //vslide1down.vx
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VSLIDE1DOWN;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010100:begin //vmpopc  always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMPOP;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010101:begin //vmfirst always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMFIRST;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010110:begin //VMUNARY0;vmsbf vmsif vmsof viota vid
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMUNARY0;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b010111:begin //vcompress
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VPERM;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VCOMPRESS;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011000:begin //vmandnot
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMANDN;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011001:begin //vmand
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMAND;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011010:begin //vmor
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMORR;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011011:begin //vmxor
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMXOR;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011100:begin //vmornot
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMORRN;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011101:begin //vmnand
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMNAND;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011110:begin //vmnor
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMNORR;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b011111:begin //vmxnor
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMISC;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMNXOR;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b100100:begin //vmulhu.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMULHU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b100101:begin //vmul.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMUL;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b100110:begin //vmulhsu.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMULHSU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b100111:begin //vmulh.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMULH;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b101001:begin //vmadd.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMADD;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b101011:begin //vnmsub.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VNMSUB;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b101101:begin //vmacc.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VMACC;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b101111:begin //vnmsac.vv
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VNMSAC;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b110000:begin //vwaddu.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWADDU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110001:begin //vwadd.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWADD;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110010:begin //vwsubu.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWSUBU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110011:begin //vwsub.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWSUB;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110100:begin //vwaddu.w.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWADDUW;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110101:begin //vwadd.w.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWADDW;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110110:begin //vwsubu.w.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWSUBUW;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b110111:begin //vwsub.w.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VALU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWSUBW;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX3_READY;
      end
    6'b111000:begin //vwmulu.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMULU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b111010:begin //vwmulsu.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMULSU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b111011:begin //vwmul.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMUL;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = decd_sew[1]? EX4_READY : EX3_READY;
      end
    6'b111100:begin //vwmaccu.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMACCU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b111101:begin //vwmacc.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMACC;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b111110:begin //vwmaccsu.vv always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMACCSU;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    6'b111111:begin //vwmaccus.vx always split
      decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0]          = VMULU;
      decd_vec_func_1[VEC_FUNC_WIDTH-1:0]          = VWMACCUS;
      decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0]  = EX4_READY;
      end
    default: begin   
      end
endcase
// &CombEnd; @1624
end

// &CombBeg; @1626
always @( vfmadd_ready_stage[2:0]
       or vfmul_ready_stage[2:0]
       or decd_sew[1:0]
       or decd_op[31:26]
       or vfmau_func_mask[19:0]
       or vfcvt_func[19:0])
begin
  //initialize decoded information value
decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {VEC_EU_WIDTH{1'b0}};
decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = {VEC_FUNC_WIDTH{1'b0}};
decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = {VEC_READY_WIDTH{1'b0}};
  casez({decd_op[31:26]})
    6'b000000:begin //vfadd.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFADD;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b000010:begin //vfsub.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFSUB;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b100111:begin //vfrsub.vf
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFSUB;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b110000:begin //vfwadd.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWADD;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end
    6'b110010:begin //vfwsub.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWSUB;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end
    6'b110100:begin //vfwadd.wv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWADDW;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b110110:begin //vfwsub.wv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWSUBW;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b000100:begin //vfmin.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMIN;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b000110:begin //vfmax.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMAX;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b001000:begin //vfsgnj.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFSGNJ;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b001001:begin //vfsgnjn.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFSGNJN;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b001010:begin //vfsgnjx.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFSGNJX;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b001100:begin //vfmv.f.s
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMVFS;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b001101:begin //vfmv.s.f
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMVSF;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end
    6'b011000:begin //vfeq.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFEQ;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b011100:begin //vfne.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFNE;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b011011:begin //vflt.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFLT;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b011001:begin //vfle.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD};
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFLE;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b011101:begin //vfgt.vf
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFLT;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b011111:begin //vfge.vf
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFLE;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b011010:begin //vford.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFORD;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b100011:begin //vfclass.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFCLASS;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b010111:begin //vfmerge.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FSPU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMERG;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b100010:begin //vfcvt.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FCNVT}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = vfcvt_func[VEC_FUNC_WIDTH-1:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX3_READY;
    end

    6'b000011:begin //vfredosum.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFOREDSUM;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end

    6'b000001:begin //vfredsum.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = decd_sew[1:0] == 2'b11 ? VFREDSUM64 : VFREDSUM;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end

    6'b000111:begin //vfredmax.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = decd_sew[1:0] == 2'b11 ? VFREDMAX64 : VFREDMAX;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end

    6'b000101:begin //vfredmin.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = decd_sew[1:0] == 2'b11 ? VFREDMIN64 : VFREDMIN;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end

    6'b110011:begin //vfwredosum.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWOREDSUM;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end
    
    6'b110001:begin //vfwredsum.vv
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FADD}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = decd_sew[1:0] == 2'b11 ? VFWREDSUM64 : VFWREDSUM;
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end
    6'b100100:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMUL | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmul_ready_stage[2:0];
    end     
    6'b111000:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWMUL | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX4_READY;
    end     
    6'b101100:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMACC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101101:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFNMACC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101110:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMSAC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101111:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFNMSAC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101000:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMADD | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101001:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFNMADD | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101010:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFMSUB | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b101011:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFNMSUB | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = vfmadd_ready_stage[2:0];
    end     
    6'b111100:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWMACC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX5_READY;
    end     
    6'b111101:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWNMACC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX5_READY;
    end     
    6'b111110:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWMSAC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX5_READY;
    end     
    6'b111111:begin
      decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0]          = {7'b0,FMAU}; 
      decd_vec_func_2[VEC_FUNC_WIDTH-1:0]          = VFWNMSAC | vfmau_func_mask[19:0];
      decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0]  = EX5_READY;
    end     
    default: begin   
      end
endcase
// &CombEnd; @1889
end
assign vfmul_ready_stage[2:0]  = (pipe7_decd_vsew[1:0] == 2'b01)
                               ? EX3_READY
                               : EX4_READY;
assign vfmadd_ready_stage[2:0] = (pipe7_decd_vsew[1:0] == 2'b01)
                               ? EX4_READY
                               : EX5_READY;                                
                               
assign vfmau_inst_size[0]    = pipe7_decd_vsew[1:0] == 2'b11; //double
assign vfmau_inst_size[1]    = pipe7_decd_vsew[1:0] == 2'b10; //single
assign vfmau_inst_size[2]    = pipe7_decd_vsew[1:0] == 2'b01; //half
assign vfmau_func_mask[19:0] = {1'b0,vfmau_inst_size[2:0],16'b0};

assign vfcvt_func[VEC_FUNC_WIDTH-1:0] = {20{(decd_op[19:15] == 5'b00000)}} & VFCVTXUF  |
                                        {20{(decd_op[19:15] == 5'b00001)}} & VFCVTXF   |
                                        {20{(decd_op[19:15] == 5'b00010)}} & VFCVTFXU  |
                                        {20{(decd_op[19:15] == 5'b00011)}} & VFCVTFX   |
                                        {20{(decd_op[19:15] == 5'b01000)}} & VFWCVTXUF |
                                        {20{(decd_op[19:15] == 5'b01001)}} & VFWCVTXF  |
                                        {20{(decd_op[19:15] == 5'b01010)}} & VFWCVTFXU |
                                        {20{(decd_op[19:15] == 5'b01011)}} & VFWCVTFX  |
                                        {20{(decd_op[19:15] == 5'b01100)}} & VFWCVTFF  |
                                        {20{(decd_op[19:15] == 5'b10000)}} & VFNCVTXUF |
                                        {20{(decd_op[19:15] == 5'b10001)}} & VFNCVTXF  |
                                        {20{(decd_op[19:15] == 5'b10010)}} & VFNCVTFXU |
                                        {20{(decd_op[19:15] == 5'b10011)}} & VFNCVTFX  |
                                        {20{(decd_op[19:15] == 5'b10100)}} & VFNCVTFF;

assign decd_vec_opi = (decd_op[14:12] == 3'b000) ||
                      (decd_op[14:12] == 3'b011) ||  
                      (decd_op[14:12] == 3'b100); 

assign decd_vec_opm = (decd_op[14:12] == 3'b010) ||  
                      (decd_op[14:12] == 3'b110);

// &CombBeg; @1924
always @( decd_vec_eu_sel_2[11:0]
       or decd_vec_eu_sel_0[11:0]
       or decd_vec_eu_sel_1[11:0]
       or decd_vec_opi
       or decd_vec_opm)
begin
case({decd_vec_opi,decd_vec_opm})
  2'b10:   decd_vec_eu_sel[VEC_EU_WIDTH-1:0] = decd_vec_eu_sel_0[VEC_EU_WIDTH-1:0];
  2'b01:   decd_vec_eu_sel[VEC_EU_WIDTH-1:0] = decd_vec_eu_sel_1[VEC_EU_WIDTH-1:0];
  default: decd_vec_eu_sel[VEC_EU_WIDTH-1:0] = decd_vec_eu_sel_2[VEC_EU_WIDTH-1:0];
endcase
// &CombEnd; @1930
end

// &CombBeg; @1932
always @( decd_vec_func_0[19:0]
       or decd_vec_func_1[19:0]
       or decd_vec_func_2[19:0]
       or decd_vec_opi
       or decd_vec_opm)
begin
case({decd_vec_opi,decd_vec_opm})
  2'b10:   decd_vec_func[VEC_FUNC_WIDTH-1:0] = decd_vec_func_0[VEC_FUNC_WIDTH-1:0];
  2'b01:   decd_vec_func[VEC_FUNC_WIDTH-1:0] = decd_vec_func_1[VEC_FUNC_WIDTH-1:0];
  default: decd_vec_func[VEC_FUNC_WIDTH-1:0] = decd_vec_func_2[VEC_FUNC_WIDTH-1:0];
endcase
// &CombEnd; @1938
end

// &CombBeg; @1940
always @( decd_vec_ready_stage_2[2:0]
       or decd_vec_ready_stage_0[2:0]
       or decd_vec_opi
       or decd_vec_opm
       or decd_vec_ready_stage_1[2:0])
begin
case({decd_vec_opi,decd_vec_opm})
  2'b10:   decd_vec_ready_stage[VEC_READY_WIDTH-1:0] = decd_vec_ready_stage_0[VEC_READY_WIDTH-1:0];
  2'b01:   decd_vec_ready_stage[VEC_READY_WIDTH-1:0] = decd_vec_ready_stage_1[VEC_READY_WIDTH-1:0];
  default: decd_vec_ready_stage[VEC_READY_WIDTH-1:0] = decd_vec_ready_stage_2[VEC_READY_WIDTH-1:0];
endcase
// &CombEnd; @1946
end



// &ModuleEnd; @1950
endmodule



