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

// &ModuleBeg; @26
module aq_iu_alu (
  // &Ports, @27
  input    wire           idu_alu_ex1_gateclk_sel,
  input    wire  [31 :0]  idu_iu_ex1_alu_inst,
  input    wire           idu_iu_ex1_alu_dp_sel,
  input    wire           idu_iu_ex1_alu_sel,
  input    wire  [5  :0]  idu_iu_ex1_dst0_reg,
  input    wire  [19 :0]  idu_iu_ex1_func,
  input    wire           idu_iu_ex1_inst_len,
  input    wire           idu_iu_ex1_split,
  input    wire  [63 :0]  idu_iu_ex1_src0,
  input    wire  [63 :0]  idu_iu_ex1_src1,
  input    wire  [63 :0]  idu_iu_ex1_src2,
  output   wire           iu_rtu_ex1_alu_cmplt,
  output   wire           iu_rtu_ex1_alu_cmplt_dp,
  output   wire  [63 :0]  iu_rtu_ex1_alu_data,
  output   wire           iu_rtu_ex1_alu_inst_len,
  output   wire           iu_rtu_ex1_alu_inst_split,
  output   wire  [5  :0]  iu_rtu_ex1_alu_preg,
  output   wire           iu_rtu_ex1_alu_wb_dp,
  output   wire           iu_rtu_ex1_alu_wb_vld
); 



// &Regs; @28
reg     [64 :0]  alu_adder_rs0;             
reg     [64 :0]  alu_adder_rs1_raw;         
reg     [63 :0]  alu_adder_rst;             
reg     [63 :0]  alu_misc_ff1_rst;          
reg     [63 :0]  alu_misc_rst;              
reg              alu_misc_tst_bit;          
reg              alu_shift_ext_sign;        
reg     [63 :0]  alu_shift_input_127_64;    
reg     [63 :0]  alu_shift_input_63_0;      
reg     [63 :0]  alu_shifter_extu_mask;     

// &Wires; @29
wire    [31 :0]  alu_exe_opcode;         
wire    [64 :0]  alu_adder_add_rst;         
wire             alu_adder_cin;             
wire             alu_adder_op_addsl;        
wire             alu_adder_op_cmp;          
wire             alu_adder_op_lt;           
wire             alu_adder_op_sub;          
wire             alu_adder_op_word;         
wire    [4  :0]  alu_adder_rs0_sel_onehot;  
wire    [64 :0]  alu_adder_rs1;             
wire    [4  :0]  alu_adder_rs1_sel_onehot;  
wire             alu_adder_rst_lt;          
wire             alu_adder_rst_normal;      
wire             alu_adder_rst_word;        
wire             alu_adder_sel;             
wire    [63 :0]  alu_adder_src0;            
wire    [63 :0]  alu_adder_src1;            
wire    [63 :0]  alu_adder_src1_tmp;        
wire    [63 :0]  alu_adder_src2;            
wire    [19 :0]  alu_func;                  
wire    [63 :0]  alu_logic_and_rst;         
wire             alu_logic_op_and;          
wire             alu_logic_op_or;           
wire             alu_logic_op_xor;          
wire    [63 :0]  alu_logic_or_rst;          
wire    [63 :0]  alu_logic_rst;             
wire             alu_logic_sel;             
wire    [63 :0]  alu_logic_src0;            
wire    [63 :0]  alu_logic_src1;            
wire    [63 :0]  alu_logic_xor_rst;         
wire    [63 :0]  alu_misc_ff1_src;          
wire    [63 :0]  alu_misc_mov_rst;          
wire             alu_misc_op_ff;            
wire             alu_misc_op_ff0;           
wire             alu_misc_op_mov;           
wire             alu_misc_op_mveqz;         
wire             alu_misc_op_mvnez;         
wire             alu_misc_op_rev;           
wire             alu_misc_op_revw;          
wire             alu_misc_op_tst;           
wire             alu_misc_op_tstnbz;        
wire    [63 :0]  alu_misc_rev_rst;          
wire    [63 :0]  alu_misc_revw_rst;         
wire             alu_misc_rst_ff1;          
wire             alu_misc_rst_mov;          
wire             alu_misc_rst_rev;          
wire             alu_misc_rst_revw;         
wire             alu_misc_rst_tst;          
wire             alu_misc_rst_tstnbz;       
wire             alu_misc_sel;              
wire             alu_misc_sel_src2;         
wire    [63 :0]  alu_misc_src0;             
wire    [63 :0]  alu_misc_src1;             
wire    [63 :0]  alu_misc_src2;             
wire             alu_misc_src_not_zero;     
wire    [63 :0]  alu_misc_tst_rst;          
wire    [63 :0]  alu_misc_tstnbz_rst;       
wire    [63 :0]  alu_rst;                   
wire    [5  :0]  alu_shift_count;           
wire    [63 :0]  alu_shift_ext_and_mask;    
wire             alu_shift_ext_and_sel_mask; 
wire    [5  :0]  alu_shift_ext_count;       
wire    [63 :0]  alu_shift_ext_or_mask;     
wire             alu_shift_ext_or_sel_mask; 
wire    [63 :0]  alu_shift_ext_rst;         
wire             alu_shift_ext_sign_op;     
wire             alu_shift_high_zero;       
wire             alu_shift_left;            
wire    [63 :0]  alu_shift_left_rst_rev;    
wire             alu_shift_normal;          
wire             alu_shift_op_ar;           
wire             alu_shift_op_circle;       
wire             alu_shift_op_ext;          
wire             alu_shift_op_left;         
wire             alu_shift_op_sign;         
wire             alu_shift_op_word;         
wire    [63 :0]  alu_shift_rst;             
wire    [63 :0]  alu_shift_rst_raw0;        
wire    [63 :0]  alu_shift_rst_raw1;        
wire             alu_shift_sel;             
wire    [127:0]  alu_shift_shifter_rst;     
wire    [63 :0]  alu_shift_src0;            
wire    [63 :0]  alu_shift_src0_rev;        
wire    [63 :0]  alu_shift_src1;            
wire             alu_shift_word;            
wire             alu_shift_word_ar;         
wire             alu_shift_word_circle;     
wire             alu_shift_word_logic_right; 
wire             alu_exe_inst_sel_ALSL;
wire             alu_exe_inst_sel_BYTEPICK;
wire             alu_exe_inst_sel_ADD;
wire             alu_exe_inst_sel_SUB;
wire             alu_exe_inst_sel_SLT;
wire             alu_exe_inst_sel_SLTU;
wire             alu_exe_inst_sel_MASKEQZ;
wire             alu_exe_inst_sel_MASKNEZ;
wire             alu_exe_inst_sel_NOR;
wire             alu_exe_inst_sel_AND;
wire             alu_exe_inst_sel_OR;
wire             alu_exe_inst_sel_XOR;
wire             alu_exe_inst_sel_ORN;
wire             alu_exe_inst_sel_ANDN;
wire             alu_exe_inst_sel_SLL;
wire             alu_exe_inst_sel_SRL;
wire             alu_exe_inst_sel_SRA;
wire             alu_exe_inst_sel_ROTR;
wire             alu_exe_inst_sel_CLO;
wire             alu_exe_inst_sel_CLZ;
wire             alu_exe_inst_sel_CTO;
wire             alu_exe_inst_sel_CTZ;
wire             alu_exe_inst_sel_REV;
wire             alu_exe_inst_sel_REVB2H;
wire             alu_exe_inst_sel_REVB4H;
wire             alu_exe_inst_sel_REVB2W;
wire             alu_exe_inst_sel_REVBD;
wire             alu_exe_inst_sel_REVH2W;
wire             alu_exe_inst_sel_REVHD;
wire             alu_exe_inst_sel_BITREV;
wire             alu_exe_inst_sel_BITREV4B;
wire             alu_exe_inst_sel_BITREV8B;
wire             alu_exe_inst_sel_BITREVW;
wire             alu_exe_inst_sel_BITREVD;
wire             alu_exe_inst_sel_EXT;
wire             alu_exe_inst_sel_EXTWB;
wire             alu_exe_inst_sel_EXTWH;
wire             alu_exe_inst_sel_SLLI;
wire             alu_exe_inst_sel_SRLI;
wire             alu_exe_inst_sel_SRAI;
wire             alu_exe_inst_sel_ROTRI;
wire             alu_exe_inst_sel_BSTRINS;
wire             alu_exe_inst_sel_BSTRPICK;
wire             alu_exe_inst_sel_SLTI;
wire             alu_exe_inst_sel_SLTUI;
wire             alu_exe_inst_sel_ADDI;
wire             alu_exe_inst_sel_LU52I;
wire             alu_exe_inst_sel_ANDI;
wire             alu_exe_inst_sel_ORI;
wire             alu_exe_inst_sel_XORI;
wire             alu_exe_inst_sel_LU32I;
wire             alu_exe_inst_sel_LU12I;
wire             alu_exe_inst_sel_ADDU16I;
wire             alu_exe_inst_sel_MVGF;
wire             alu_exe_inst_sel_ASRTLE;
wire             alu_exe_inst_sel_ASRTGE;
wire             alu_exe_inst_sel_CRC;
wire    [63 :0]  alu_ex1_src0;
wire    [63 :0]  alu_ex1_src1;
wire    [63 :0]  alu_ex1_src2;
wire    [63 :0]  alu_exex_pipex_data;
wire    [63 :0]  adder_addsl_rslt;            
wire    [63 :0]  adder_data_out_add;          
wire    [31 :0]  adder_data_out_addw;         
wire    [63 :0]  adder_data_out_sub;          
wire    [31 :0]  adder_data_out_subw;  
wire    [63 :0]  logic_and_rslt;
wire    [63 :0]  logic_xor_rslt;
wire    [63 :0]  logic_or_rslt;
wire    [63 :0]  alu_exe_add_data;
wire    [63 :0]  alu_exe_lu12i_data;
wire    [63 :0]  alu_exe_alsl_data;
wire    [63 :0]  alu_exe_bytepick_data;
wire    [63 :0]  alu_exe_sub_data;
wire    [63 :0]  alu_exe_slt_data;
wire    [63 :0]  alu_exe_sltu_data;
wire    [63 :0]  alu_exe_maskeqz_data;
wire    [63 :0]  alu_exe_masknez_data;
wire    [63 :0]  alu_exe_nor_data;
wire    [63 :0]  alu_exe_and_data;
wire    [63 :0]  alu_exe_or_data;
wire    [63 :0]  alu_exe_xor_data;
wire    [63 :0]  alu_exe_orn_data;
wire    [63 :0]  alu_exe_andn_data;
wire    [63 :0]  alu_exe_sll_data;
wire    [63 :0]  alu_exe_srl_data;
wire    [63 :0]  alu_exe_sra_data;
wire    [63 :0]  alu_exe_rotr_data;
wire    [63 :0]  alu_exe_adc_data;
wire    [63 :0]  alu_exe_sbc_data;
wire    [63 :0]  alu_exe_clo_data;
wire    [63 :0]  alu_exe_clz_data;
wire    [63 :0]  alu_exe_cto_data;
wire    [63 :0]  alu_exe_ctz_data;
wire    [63 :0]  alu_exe_rev_data;
wire    [63 :0]  alu_exe_bitrev_data;
wire    [63 :0]  alu_exe_ext_data;
wire    [63 :0]  alu_exe_slli_data;
wire    [63 :0]  alu_exe_srli_data;
wire    [63 :0]  alu_exe_srai_data;
wire    [63 :0]  alu_exe_rotri_data;
wire    [63 :0]  alu_exe_bstrins_data;
wire    [63 :0]  alu_exe_bstrpick_data;
wire    [63 :0]  alu_exe_slti_data;
wire    [63 :0]  alu_exe_sltui_data;
wire    [63 :0]  alu_exe_addi_data;
wire    [63 :0]  alu_exe_lu52i_data;
wire    [63 :0]  alu_exe_andi_data;
wire    [63 :0]  alu_exe_ori_data;
wire    [63 :0]  alu_exe_xori_data;
wire    [63 :0]  alu_exe_lu32i_data;
wire    [63 :0]  alu_exe_addu16i_data;
wire    [63 :0]  alu_exe_movgf_data;
wire    [63 :0]  alu_exe_asrtle_data;
wire    [63 :0]  alu_exe_asrtge_data;
wire    [63 :0]  alu_exe_crc_data;
wire             alu_ex1_func_bitwidth_sel_b;
wire             alu_ex1_func_bitwidth_sel_bu;
wire             alu_ex1_func_bitwidth_sel_h;
wire             alu_ex1_func_bitwidth_sel_hu;
wire             alu_ex1_func_bitwidth_sel_w;
wire             alu_ex1_func_bitwidth_sel_wu;
wire             alu_ex1_func_bitwidth_sel_d;
wire             alu_ex1_func_bitwidth_sel_du;


// &Force("input", "idu_alu_ex1_gateclk_sel"); @31
assign alu_func[19:0] = idu_iu_ex1_func[19:0] & {20{idu_alu_ex1_gateclk_sel}};

assign alu_exe_opcode[31:0] = idu_iu_ex1_alu_inst[31:0]; 

assign alu_ex1_src0[63 :0] = idu_iu_ex1_src0[63 :0];
assign alu_ex1_src1[63 :0] = idu_iu_ex1_src1[63 :0];
assign alu_ex1_src2[63 :0] = idu_iu_ex1_src2[63 :0];

assign alu_ex1_func_bitwidth_sel_b  = idu_iu_ex1_func[11:9] == 3'b000;
assign alu_ex1_func_bitwidth_sel_bu = idu_iu_ex1_func[11:9] == 3'b100;
assign alu_ex1_func_bitwidth_sel_h  = idu_iu_ex1_func[11:9] == 3'b001;
assign alu_ex1_func_bitwidth_sel_hu = idu_iu_ex1_func[11:9] == 3'b101;
assign alu_ex1_func_bitwidth_sel_w  = idu_iu_ex1_func[11:9] == 3'b010;
assign alu_ex1_func_bitwidth_sel_wu = idu_iu_ex1_func[11:9] == 3'b110;
assign alu_ex1_func_bitwidth_sel_d  = idu_iu_ex1_func[11:9] == 3'b011;
assign alu_ex1_func_bitwidth_sel_du = idu_iu_ex1_func[11:9] == 3'b111;

//==========================================================
//                     LACore EXE
//==========================================================

// idu_iu_ex1_func [19:0] == `FUNC_PCADDI      
// idu_iu_ex1_func [19:0] == `FUNC_PCADDU12I   
// idu_iu_ex1_func [19:0] == `FUNC_PCADDU18I   
// idu_iu_ex1_func [19:0] == `FUNC_PCALAU12I   

// idu_iu_ex1_func [19:0] == `FUNC_MULW        
// idu_iu_ex1_func [19:0] == `FUNC_MULHW       
// idu_iu_ex1_func [19:0] == `FUNC_MULHWU      
// idu_iu_ex1_func [19:0] == `FUNC_MULD        
// idu_iu_ex1_func [19:0] == `FUNC_MULHD       
// idu_iu_ex1_func [19:0] == `FUNC_MULHDU      
// idu_iu_ex1_func [19:0] == `FUNC_MULWDW      
// idu_iu_ex1_func [19:0] == `FUNC_MULWDWU     
// idu_iu_ex1_func [19:0] == `FUNC_DIVW        
// idu_iu_ex1_func [19:0] == `FUNC_DIVWU       
// idu_iu_ex1_func [19:0] == `FUNC_DIVD        
// idu_iu_ex1_func [19:0] == `FUNC_DIVDU       
// idu_iu_ex1_func [19:0] == `FUNC_MODW        
// idu_iu_ex1_func [19:0] == `FUNC_MODWU       
// idu_iu_ex1_func [19:0] == `FUNC_MODD        
// idu_iu_ex1_func [19:0] == `FUNC_MODDU  


//----------------------------------------------------------
//                ALU signals for decode 
//----------------------------------------------------------
assign alu_exe_inst_sel_ALSL    = idu_iu_ex1_func [19:0] == `FUNC_ALSLW
                                  || idu_iu_ex1_func [19:0] == `FUNC_ALSLWU
                                  || idu_iu_ex1_func [19:0] == `FUNC_ALSLD; 

assign alu_exe_inst_sel_BYTEPICK = idu_iu_ex1_func [19:0] == `FUNC_BYTEPICKW
                                   || idu_iu_ex1_func [19:0] == `FUNC_BYTEPICKD;

assign alu_exe_inst_sel_ADD     = idu_iu_ex1_func [19:0] == `FUNC_ADDW
                                  || idu_iu_ex1_func [19:0] == `FUNC_ADDD;

assign alu_exe_inst_sel_SUB     = idu_iu_ex1_func [19:0] == `FUNC_SUBW
                                  || idu_iu_ex1_func [19:0] == `FUNC_SUBD;

assign alu_exe_inst_sel_SLT     = idu_iu_ex1_func [19:0] == `FUNC_SLT;

assign alu_exe_inst_sel_SLTU    = idu_iu_ex1_func [19:0] == `FUNC_SLTU;

assign alu_exe_inst_sel_MASKEQZ = idu_iu_ex1_func [19:0] == `FUNC_MASKEQZ;

assign alu_exe_inst_sel_MASKNEZ = idu_iu_ex1_func [19:0] == `FUNC_MASKNEZ;

assign alu_exe_inst_sel_NOR     = idu_iu_ex1_func [19:0] == `FUNC_NOR;

assign alu_exe_inst_sel_AND     = idu_iu_ex1_func [19:0] == `FUNC_AND;

assign alu_exe_inst_sel_OR      = idu_iu_ex1_func [19:0] == `FUNC_OR;

assign alu_exe_inst_sel_XOR     = idu_iu_ex1_func [19:0] == `FUNC_XOR;

assign alu_exe_inst_sel_ORN     = idu_iu_ex1_func [19:0] == `FUNC_ORN;

assign alu_exe_inst_sel_ANDN    = idu_iu_ex1_func [19:0] == `FUNC_ANDN;

assign alu_exe_inst_sel_SLL     = idu_iu_ex1_func [19:0] == `FUNC_SLLW
                                  || idu_iu_ex1_func [19:0] == `FUNC_SLLD;

assign alu_exe_inst_sel_SRL     = idu_iu_ex1_func [19:0] == `FUNC_SRLW
                                  || idu_iu_ex1_func [19:0] == `FUNC_SRLD;

assign alu_exe_inst_sel_SRA     = idu_iu_ex1_func [19:0] == `FUNC_SRAW
                                  || idu_iu_ex1_func [19:0] == `FUNC_SRAD;

assign alu_exe_inst_sel_ROTR    = idu_iu_ex1_func [19:0] == `FUNC_ROTRW
                                  || idu_iu_ex1_func [19:0] == `FUNC_ROTRD;

assign alu_exe_inst_sel_CLO     = idu_iu_ex1_func [19:0] == `FUNC_CLOW        
                                  || idu_iu_ex1_func [19:0] == `FUNC_CLOD;

assign alu_exe_inst_sel_CLZ     = idu_iu_ex1_func [19:0] == `FUNC_CLZW        
                                  || idu_iu_ex1_func [19:0] == `FUNC_CLZD;

assign alu_exe_inst_sel_CTO     = idu_iu_ex1_func [19:0] == `FUNC_CTOW        
                                  || idu_iu_ex1_func [19:0] == `FUNC_CTOD;

assign alu_exe_inst_sel_CTZ     = idu_iu_ex1_func [19:0] == `FUNC_CTZW        
                                  || idu_iu_ex1_func [19:0] == `FUNC_CTZD;

assign alu_exe_inst_sel_REV = alu_exe_inst_sel_REVB2H
                             || alu_exe_inst_sel_REVB4H
                             || alu_exe_inst_sel_REVB2W
                             || alu_exe_inst_sel_REVBD
                             || alu_exe_inst_sel_REVH2W
                             || alu_exe_inst_sel_REVHD;

assign alu_exe_inst_sel_REVB2H = idu_iu_ex1_func [19:0] == `FUNC_REVB2H;

assign alu_exe_inst_sel_REVB4H = idu_iu_ex1_func [19:0] == `FUNC_REVB4H;

assign alu_exe_inst_sel_REVB2W = idu_iu_ex1_func [19:0] == `FUNC_REVB2W;

assign alu_exe_inst_sel_REVBD  = idu_iu_ex1_func [19:0] == `FUNC_REVBD;

assign alu_exe_inst_sel_REVH2W = idu_iu_ex1_func [19:0] == `FUNC_REVH2W;

assign alu_exe_inst_sel_REVHD  = idu_iu_ex1_func [19:0] == `FUNC_REVHD;

assign alu_exe_inst_sel_BITREV =   alu_exe_inst_sel_BITREV4B
                                || alu_exe_inst_sel_BITREV8B
                                || alu_exe_inst_sel_BITREVW
                                || alu_exe_inst_sel_BITREVD;

assign alu_exe_inst_sel_BITREV4B = idu_iu_ex1_func [19:0] == `FUNC_BITREV4B;

assign alu_exe_inst_sel_BITREV8B = idu_iu_ex1_func [19:0] == `FUNC_BITREV8B;

assign alu_exe_inst_sel_BITREVW  = idu_iu_ex1_func [19:0] == `FUNC_BITREVW;

assign alu_exe_inst_sel_BITREVD  = idu_iu_ex1_func [19:0] == `FUNC_BITREVD;

assign alu_exe_inst_sel_EXT =  alu_exe_inst_sel_EXTWB
                            || alu_exe_inst_sel_EXTWH;

assign alu_exe_inst_sel_EXTWB = idu_iu_ex1_func [19:0] == `FUNC_EXTWB;

assign alu_exe_inst_sel_EXTWH = idu_iu_ex1_func [19:0] == `FUNC_EXTWH;

assign alu_exe_inst_sel_SLLI  = idu_iu_ex1_func [19:0] == `FUNC_SLLIW
                                || idu_iu_ex1_func [19:0] == `FUNC_SLLID;

assign alu_exe_inst_sel_SRLI  = idu_iu_ex1_func [19:0] == `FUNC_SRLIW
                                || idu_iu_ex1_func [19:0] == `FUNC_SRLID;

assign alu_exe_inst_sel_SRAI  = idu_iu_ex1_func [19:0] == `FUNC_SRAIW
                                || idu_iu_ex1_func [19:0] == `FUNC_SRAID;

assign alu_exe_inst_sel_ROTRI = idu_iu_ex1_func [19:0] == `FUNC_ROTRIW
                                || idu_iu_ex1_func [19:0] == `FUNC_ROTRID;

assign alu_exe_inst_sel_BSTRINS  = idu_iu_ex1_func [19:0] == `FUNC_BSTRINSW
                                   || idu_iu_ex1_func [19:0] == `FUNC_BSTRINSD;

assign alu_exe_inst_sel_BSTRPICK = idu_iu_ex1_func [19:0] == `FUNC_BSTRPICKW   
                                   || idu_iu_ex1_func [19:0] == `FUNC_BSTRPICKD; 

assign alu_exe_inst_sel_SLTI  = idu_iu_ex1_func [19:0] == `FUNC_SLTI;

assign alu_exe_inst_sel_SLTUI = idu_iu_ex1_func [19:0] == `FUNC_SLTUI;

assign alu_exe_inst_sel_ADDI  = idu_iu_ex1_func [19:0] == `FUNC_ADDIW       
                                || idu_iu_ex1_func [19:0] == `FUNC_ADDID;

assign alu_exe_inst_sel_LU52I = idu_iu_ex1_func [19:0] == `FUNC_LU52ID;

assign alu_exe_inst_sel_ANDI  = idu_iu_ex1_func [19:0] == `FUNC_ANDI;

assign alu_exe_inst_sel_ORI   = idu_iu_ex1_func [19:0] == `FUNC_ORI;

assign alu_exe_inst_sel_XORI  = idu_iu_ex1_func [19:0] == `FUNC_XORI;

assign alu_exe_inst_sel_LU32I = idu_iu_ex1_func [19:0] == `FUNC_LU32ID;

assign alu_exe_inst_sel_LU12I = idu_iu_ex1_func [19:0] == `FUNC_LU12IW; 

assign alu_exe_inst_sel_ADDU16I = idu_iu_ex1_func [19:0] == `FUNC_ADDU16ID;

assign alu_exe_inst_sel_ASRTLE  = idu_iu_ex1_func [19:0] == `FUNC_ASRTLED;

assign alu_exe_inst_sel_ASRTGE  = idu_iu_ex1_func [19:0] == `FUNC_ASRTGTD;

assign alu_exe_inst_sel_CRC = idu_iu_ex1_func [19:0] == `FUNC_CRCWBW      
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCWHW      
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCWWW      
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCWDW      
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCCWBW     
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCCWHW     
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCCWWW     
                           || idu_iu_ex1_func [19:0] == `FUNC_CRCCWDW;


assign alu_exe_inst_sel_MVGF  = idu_iu_ex1_func [19:0] == `FUNC_MVGF;


//==========================================================
//                     LACore EXE
//==========================================================

/// xor, and
assign logic_and_rslt[63:0]    = alu_ex1_src0[63:0] & alu_ex1_src1[63:0];
assign logic_xor_rslt[63:0]    = alu_ex1_src0[63:0] ^ alu_ex1_src1[63:0];

assign alu_exe_and_data[63:0]  = logic_and_rslt[63:0];
assign alu_exe_xor_data[63:0]  = logic_xor_rslt[63:0];


/// add ori
assign adder_data_out_add[63:0]  = alu_ex1_src0[63:0] + alu_ex1_src1[63:0];

assign adder_data_out_addw[31:0] = alu_ex1_src0[31:0] + alu_ex1_src1[31:0];

assign alu_exe_add_data[63:0] = alu_ex1_func_bitwidth_sel_d ? 
                                  adder_data_out_add[63:0]
                                : alu_ex1_func_bitwidth_sel_w ?
                                  {{32{adder_data_out_addw[31]}}, adder_data_out_addw[31:0]}
                                : {64{1'b0}};

/// or ori
assign logic_or_rslt[63:0]    = alu_ex1_src0[63:0] | alu_ex1_src1[63:0];
assign alu_exe_or_data[63:0]  = logic_or_rslt[63:0];
assign alu_exe_ori_data[63:0] = alu_ex1_src0[63:0] | {{52{1'b0}},alu_exe_opcode[21:10]};



/// addiu/w addu16i.d
wire [31:0] alu_addi_w_data = alu_ex1_src0[31:0] + {{20{alu_exe_opcode[21]}}, alu_exe_opcode[21:10]};

assign alu_exe_addi_data[63:0] = alu_ex1_func_bitwidth_sel_d ? 
                                  alu_ex1_src0[63:0] + {{52{alu_exe_opcode[21]}}, alu_exe_opcode[21:10]}
                                : alu_ex1_func_bitwidth_sel_w ?
                                  {{32{alu_addi_w_data[31]}}, alu_addi_w_data[31:0]}
                                : {64{1'b0}};


assign alu_exe_addu16i_data[63:0] = alu_ex1_src0[63:0] + {{32{alu_exe_opcode[25]}}, alu_exe_opcode[25:10], 16'b0};




/// maskeqz/masknez
wire mask_cmp_rst = (alu_ex1_src1[63:0] != 64'b0);

assign alu_exe_maskeqz_data[63:0] = mask_cmp_rst ? 
                                    alu_ex1_src0[63:0]
                                    : 64'b0;

assign alu_exe_masknez_data[63:0] = mask_cmp_rst ? 
                                    64'b0
                                    : alu_ex1_src0[63:0];



/// lu32i.d lu52i.d lu12i.w

// rj = src0
// rk = src1
// rd = src2

assign alu_exe_lu12i_data[63:0] = {{32{alu_exe_opcode[24]}}, alu_exe_opcode[24:5], 12'b0};

assign alu_exe_lu32i_data[63:0] = {{12{alu_exe_opcode[24]}}, alu_exe_opcode[24:5], 
                                    alu_ex1_src2[31:0]};

assign alu_exe_lu52i_data[63:0] = {alu_exe_opcode[21:10], alu_ex1_src0[51:0]};



/// slt/slti
wire sltu; 
wire slts; 
wire [63:0] alu_ex1_slt_cmp_src1 = (alu_exe_inst_sel_SLTI
                                  || alu_exe_inst_sel_SLTUI )
                                  ? {{52{alu_exe_opcode[21]}}, alu_exe_opcode[21:10]}
                                  : alu_ex1_src1[63:0];

assign sltu  =  alu_ex1_src0[63:0] < alu_ex1_slt_cmp_src1[63:0];
assign slts  =  $signed(alu_ex1_src0[63:0]) < $signed(alu_ex1_slt_cmp_src1[63:0]);

assign alu_exe_slt_data  [63:0] = {{63{1'b0}}, slts};
assign alu_exe_sltu_data [63:0] = {{63{1'b0}}, sltu};

assign alu_exe_slti_data  [63:0] =  {{63{1'b0}}, slts};
assign alu_exe_sltui_data [63:0] =  {{63{1'b0}}, sltu};


/// bstrpick.w/d

wire [4:0] msbw;
wire [4:0] lsbw;

wire [5:0] msbd;
wire [5:0] lsbd;

assign msbw[4:0] = alu_exe_opcode[20:16];
assign lsbw[4:0] = alu_exe_opcode[14:10];

assign msbd[5:0] = alu_exe_opcode[21:16];
assign lsbd[5:0] = alu_exe_opcode[15:10];


reg [31:0] lsbw_mask;

always @(lsbw[4:0]) begin
casez({lsbw[4:0]})
    5'd0:  lsbw_mask[31:0] = 32'b11111111111111111111111111111111;
    5'd1:  lsbw_mask[31:0] = 32'b11111111111111111111111111111110;
    5'd2:  lsbw_mask[31:0] = 32'b11111111111111111111111111111100;
    5'd3:  lsbw_mask[31:0] = 32'b11111111111111111111111111111000;
    5'd4:  lsbw_mask[31:0] = 32'b11111111111111111111111111110000;
    5'd5:  lsbw_mask[31:0] = 32'b11111111111111111111111111100000;
    5'd6:  lsbw_mask[31:0] = 32'b11111111111111111111111111000000;
    5'd7:  lsbw_mask[31:0] = 32'b11111111111111111111111110000000;
    5'd8:  lsbw_mask[31:0] = 32'b11111111111111111111111100000000;
    5'd9:  lsbw_mask[31:0] = 32'b11111111111111111111111000000000;
    5'd10: lsbw_mask[31:0] = 32'b11111111111111111111110000000000;
    5'd11: lsbw_mask[31:0] = 32'b11111111111111111111100000000000;
    5'd12: lsbw_mask[31:0] = 32'b11111111111111111111000000000000;
    5'd13: lsbw_mask[31:0] = 32'b11111111111111111110000000000000;
    5'd14: lsbw_mask[31:0] = 32'b11111111111111111100000000000000;
    5'd15: lsbw_mask[31:0] = 32'b11111111111111111000000000000000;
    5'd16: lsbw_mask[31:0] = 32'b11111111111111110000000000000000;
    5'd17: lsbw_mask[31:0] = 32'b11111111111111100000000000000000;
    5'd18: lsbw_mask[31:0] = 32'b11111111111111000000000000000000;
    5'd19: lsbw_mask[31:0] = 32'b11111111111110000000000000000000;
    5'd20: lsbw_mask[31:0] = 32'b11111111111100000000000000000000;
    5'd21: lsbw_mask[31:0] = 32'b11111111111000000000000000000000;
    5'd22: lsbw_mask[31:0] = 32'b11111111110000000000000000000000;
    5'd23: lsbw_mask[31:0] = 32'b11111111100000000000000000000000;
    5'd24: lsbw_mask[31:0] = 32'b11111111000000000000000000000000;
    5'd25: lsbw_mask[31:0] = 32'b11111110000000000000000000000000;
    5'd26: lsbw_mask[31:0] = 32'b11111100000000000000000000000000;
    5'd27: lsbw_mask[31:0] = 32'b11111000000000000000000000000000;
    5'd28: lsbw_mask[31:0] = 32'b11110000000000000000000000000000;
    5'd29: lsbw_mask[31:0] = 32'b11100000000000000000000000000000;
    5'd30: lsbw_mask[31:0] = 32'b11000000000000000000000000000000;
    5'd31: lsbw_mask[31:0] = 32'b10000000000000000000000000000000;
  default: lsbw_mask[31:0] = {32{1'b0}};
endcase
end


reg [31:0] msbw_mask;
always @(msbw[4:0]) begin
casez({msbw[4:0]})
    5'd0:  msbw_mask[31:0] = 32'b00000000000000000000000000000001;
    5'd1:  msbw_mask[31:0] = 32'b00000000000000000000000000000011;
    5'd2:  msbw_mask[31:0] = 32'b00000000000000000000000000000111;
    5'd3:  msbw_mask[31:0] = 32'b00000000000000000000000000001111;
    5'd4:  msbw_mask[31:0] = 32'b00000000000000000000000000011111;
    5'd5:  msbw_mask[31:0] = 32'b00000000000000000000000000111111;
    5'd6:  msbw_mask[31:0] = 32'b00000000000000000000000001111111;
    5'd7:  msbw_mask[31:0] = 32'b00000000000000000000000011111111;
    5'd8:  msbw_mask[31:0] = 32'b00000000000000000000000111111111;
    5'd9:  msbw_mask[31:0] = 32'b00000000000000000000001111111111;
    5'd10: msbw_mask[31:0] = 32'b00000000000000000000011111111111;
    5'd11: msbw_mask[31:0] = 32'b00000000000000000000111111111111;
    5'd12: msbw_mask[31:0] = 32'b00000000000000000001111111111111;
    5'd13: msbw_mask[31:0] = 32'b00000000000000000011111111111111;
    5'd14: msbw_mask[31:0] = 32'b00000000000000000111111111111111;
    5'd15: msbw_mask[31:0] = 32'b00000000000000001111111111111111;
    5'd16: msbw_mask[31:0] = 32'b00000000000000011111111111111111;
    5'd17: msbw_mask[31:0] = 32'b00000000000000111111111111111111;
    5'd18: msbw_mask[31:0] = 32'b00000000000001111111111111111111;
    5'd19: msbw_mask[31:0] = 32'b00000000000011111111111111111111;
    5'd20: msbw_mask[31:0] = 32'b00000000000111111111111111111111;
    5'd21: msbw_mask[31:0] = 32'b00000000001111111111111111111111;
    5'd22: msbw_mask[31:0] = 32'b00000000011111111111111111111111;
    5'd23: msbw_mask[31:0] = 32'b00000000111111111111111111111111;
    5'd24: msbw_mask[31:0] = 32'b00000001111111111111111111111111;
    5'd25: msbw_mask[31:0] = 32'b00000011111111111111111111111111;
    5'd26: msbw_mask[31:0] = 32'b00000111111111111111111111111111;
    5'd27: msbw_mask[31:0] = 32'b00001111111111111111111111111111;
    5'd28: msbw_mask[31:0] = 32'b00011111111111111111111111111111;
    5'd29: msbw_mask[31:0] = 32'b00111111111111111111111111111111;
    5'd30: msbw_mask[31:0] = 32'b01111111111111111111111111111111;
    5'd31: msbw_mask[31:0] = 32'b11111111111111111111111111111111;
  default: msbw_mask[31:0] = {32{1'b0}};
endcase
end


wire [31:0]alu_exe_bstrpick_data_32;
wire [63:0]alu_exe_bstrpick_data_w;

assign alu_exe_bstrpick_data_32[31:0] = (alu_ex1_src0[31:0] & (msbw_mask & lsbw_mask)) >> lsbw;

assign alu_exe_bstrpick_data_w[63:0] = {{32{alu_exe_bstrpick_data_32[31]}}, alu_exe_bstrpick_data_32[31:0]};

// dword
reg [63:0] lsbd_mask;
always @(lsbd[5:0]) begin
casez({lsbd[5:0]})
    6'd0:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
    6'd1:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111110;
    6'd2:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111100;
    6'd3:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111000;
    6'd4:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111110000;
    6'd5:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111100000;
    6'd6:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111000000;
    6'd7:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111110000000;
    6'd8:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111100000000;
    6'd9:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111000000000;
    6'd10: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111110000000000;
    6'd11: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111100000000000;
    6'd12: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111000000000000;
    6'd13: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111110000000000000;
    6'd14: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111100000000000000;
    6'd15: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111000000000000000;
    6'd16: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111110000000000000000;
    6'd17: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111100000000000000000;
    6'd18: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111000000000000000000;
    6'd19: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111110000000000000000000;
    6'd20: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111100000000000000000000;
    6'd21: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111000000000000000000000;
    6'd22: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111110000000000000000000000;
    6'd23: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111100000000000000000000000;
    6'd24: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111000000000000000000000000;
    6'd25: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111110000000000000000000000000;
    6'd26: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111100000000000000000000000000;
    6'd27: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111000000000000000000000000000;
    6'd28: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111110000000000000000000000000000;
    6'd29: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111100000000000000000000000000000;
    6'd30: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111000000000000000000000000000000;
    6'd31: lsbd_mask[63:0] = 64'b1111111111111111111111111111111110000000000000000000000000000000;
    6'd32: lsbd_mask[63:0] = 64'b1111111111111111111111111111111100000000000000000000000000000000;
    6'd33: lsbd_mask[63:0] = 64'b1111111111111111111111111111111000000000000000000000000000000000;
    6'd34: lsbd_mask[63:0] = 64'b1111111111111111111111111111110000000000000000000000000000000000;
    6'd35: lsbd_mask[63:0] = 64'b1111111111111111111111111111100000000000000000000000000000000000;
    6'd36: lsbd_mask[63:0] = 64'b1111111111111111111111111111000000000000000000000000000000000000;
    6'd37: lsbd_mask[63:0] = 64'b1111111111111111111111111110000000000000000000000000000000000000;
    6'd38: lsbd_mask[63:0] = 64'b1111111111111111111111111100000000000000000000000000000000000000;
    6'd39: lsbd_mask[63:0] = 64'b1111111111111111111111111000000000000000000000000000000000000000;
    6'd40: lsbd_mask[63:0] = 64'b1111111111111111111111110000000000000000000000000000000000000000;
    6'd41: lsbd_mask[63:0] = 64'b1111111111111111111111100000000000000000000000000000000000000000;
    6'd42: lsbd_mask[63:0] = 64'b1111111111111111111111000000000000000000000000000000000000000000;
    6'd43: lsbd_mask[63:0] = 64'b1111111111111111111110000000000000000000000000000000000000000000;
    6'd44: lsbd_mask[63:0] = 64'b1111111111111111111100000000000000000000000000000000000000000000;
    6'd45: lsbd_mask[63:0] = 64'b1111111111111111111000000000000000000000000000000000000000000000;
    6'd46: lsbd_mask[63:0] = 64'b1111111111111111110000000000000000000000000000000000000000000000;
    6'd47: lsbd_mask[63:0] = 64'b1111111111111111100000000000000000000000000000000000000000000000;
    6'd48: lsbd_mask[63:0] = 64'b1111111111111111000000000000000000000000000000000000000000000000;
    6'd49: lsbd_mask[63:0] = 64'b1111111111111110000000000000000000000000000000000000000000000000;
    6'd50: lsbd_mask[63:0] = 64'b1111111111111100000000000000000000000000000000000000000000000000;
    6'd51: lsbd_mask[63:0] = 64'b1111111111111000000000000000000000000000000000000000000000000000;
    6'd52: lsbd_mask[63:0] = 64'b1111111111110000000000000000000000000000000000000000000000000000;
    6'd53: lsbd_mask[63:0] = 64'b1111111111100000000000000000000000000000000000000000000000000000;
    6'd54: lsbd_mask[63:0] = 64'b1111111111000000000000000000000000000000000000000000000000000000;
    6'd55: lsbd_mask[63:0] = 64'b1111111110000000000000000000000000000000000000000000000000000000;
    6'd56: lsbd_mask[63:0] = 64'b1111111100000000000000000000000000000000000000000000000000000000;
    6'd57: lsbd_mask[63:0] = 64'b1111111000000000000000000000000000000000000000000000000000000000;
    6'd58: lsbd_mask[63:0] = 64'b1111110000000000000000000000000000000000000000000000000000000000;
    6'd59: lsbd_mask[63:0] = 64'b1111100000000000000000000000000000000000000000000000000000000000;
    6'd60: lsbd_mask[63:0] = 64'b1111000000000000000000000000000000000000000000000000000000000000;
    6'd61: lsbd_mask[63:0] = 64'b1110000000000000000000000000000000000000000000000000000000000000;
    6'd62: lsbd_mask[63:0] = 64'b1100000000000000000000000000000000000000000000000000000000000000;
    6'd63: lsbd_mask[63:0] = 64'b1000000000000000000000000000000000000000000000000000000000000000;
  default: lsbd_mask[63:0] = {64{1'b0}};
endcase
end


reg [63:0] msbd_mask;
always @(msbd[5:0]) begin
casez({msbd[5:0]})
    6'd0:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000000001;
    6'd1:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000000011;
    6'd2:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000000111;
    6'd3:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000001111;
    6'd4:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000011111;
    6'd5:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000111111;
    6'd6:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000001111111;
    6'd7:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000011111111;
    6'd8:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000111111111;
    6'd9:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000001111111111;
    6'd10: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000011111111111;
    6'd11: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000111111111111;
    6'd12: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000001111111111111;
    6'd13: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000011111111111111;
    6'd14: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000111111111111111;
    6'd15: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000001111111111111111;
    6'd16: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000011111111111111111;
    6'd17: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000111111111111111111;
    6'd18: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000001111111111111111111;
    6'd19: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000011111111111111111111;
    6'd20: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000111111111111111111111;
    6'd21: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000001111111111111111111111;
    6'd22: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000011111111111111111111111;
    6'd23: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000111111111111111111111111;
    6'd24: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000001111111111111111111111111;
    6'd25: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000011111111111111111111111111;
    6'd26: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000111111111111111111111111111;
    6'd27: msbd_mask[63:0] = 64'b0000000000000000000000000000000000001111111111111111111111111111;
    6'd28: msbd_mask[63:0] = 64'b0000000000000000000000000000000000011111111111111111111111111111;
    6'd29: msbd_mask[63:0] = 64'b0000000000000000000000000000000000111111111111111111111111111111;
    6'd30: msbd_mask[63:0] = 64'b0000000000000000000000000000000001111111111111111111111111111111;
    6'd31: msbd_mask[63:0] = 64'b0000000000000000000000000000000011111111111111111111111111111111;
    6'd32: msbd_mask[63:0] = 64'b0000000000000000000000000000000111111111111111111111111111111111;
    6'd33: msbd_mask[63:0] = 64'b0000000000000000000000000000001111111111111111111111111111111111;
    6'd34: msbd_mask[63:0] = 64'b0000000000000000000000000000011111111111111111111111111111111111;
    6'd35: msbd_mask[63:0] = 64'b0000000000000000000000000000111111111111111111111111111111111111;
    6'd36: msbd_mask[63:0] = 64'b0000000000000000000000000001111111111111111111111111111111111111;
    6'd37: msbd_mask[63:0] = 64'b0000000000000000000000000011111111111111111111111111111111111111;
    6'd38: msbd_mask[63:0] = 64'b0000000000000000000000000111111111111111111111111111111111111111;
    6'd39: msbd_mask[63:0] = 64'b0000000000000000000000001111111111111111111111111111111111111111;
    6'd40: msbd_mask[63:0] = 64'b0000000000000000000000011111111111111111111111111111111111111111;
    6'd41: msbd_mask[63:0] = 64'b0000000000000000000000111111111111111111111111111111111111111111;
    6'd42: msbd_mask[63:0] = 64'b0000000000000000000001111111111111111111111111111111111111111111;
    6'd43: msbd_mask[63:0] = 64'b0000000000000000000011111111111111111111111111111111111111111111;
    6'd44: msbd_mask[63:0] = 64'b0000000000000000000111111111111111111111111111111111111111111111;
    6'd45: msbd_mask[63:0] = 64'b0000000000000000001111111111111111111111111111111111111111111111;
    6'd46: msbd_mask[63:0] = 64'b0000000000000000011111111111111111111111111111111111111111111111;
    6'd47: msbd_mask[63:0] = 64'b0000000000000000111111111111111111111111111111111111111111111111;
    6'd48: msbd_mask[63:0] = 64'b0000000000000001111111111111111111111111111111111111111111111111;
    6'd49: msbd_mask[63:0] = 64'b0000000000000011111111111111111111111111111111111111111111111111;
    6'd50: msbd_mask[63:0] = 64'b0000000000000111111111111111111111111111111111111111111111111111;
    6'd51: msbd_mask[63:0] = 64'b0000000000001111111111111111111111111111111111111111111111111111;
    6'd52: msbd_mask[63:0] = 64'b0000000000011111111111111111111111111111111111111111111111111111;
    6'd53: msbd_mask[63:0] = 64'b0000000000111111111111111111111111111111111111111111111111111111;
    6'd54: msbd_mask[63:0] = 64'b0000000001111111111111111111111111111111111111111111111111111111;
    6'd55: msbd_mask[63:0] = 64'b0000000011111111111111111111111111111111111111111111111111111111;
    6'd56: msbd_mask[63:0] = 64'b0000000111111111111111111111111111111111111111111111111111111111;
    6'd57: msbd_mask[63:0] = 64'b0000001111111111111111111111111111111111111111111111111111111111;
    6'd58: msbd_mask[63:0] = 64'b0000011111111111111111111111111111111111111111111111111111111111;
    6'd59: msbd_mask[63:0] = 64'b0000111111111111111111111111111111111111111111111111111111111111;
    6'd60: msbd_mask[63:0] = 64'b0001111111111111111111111111111111111111111111111111111111111111;
    6'd61: msbd_mask[63:0] = 64'b0011111111111111111111111111111111111111111111111111111111111111;
    6'd62: msbd_mask[63:0] = 64'b0111111111111111111111111111111111111111111111111111111111111111;
    6'd63: msbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
  default: msbd_mask[63:0] = {64{1'b0}};
endcase
end

wire [63:0]alu_exe_bstrpick_data_d;

assign alu_exe_bstrpick_data_d[63:0] = (alu_ex1_src0[63:0] & (msbd_mask & lsbd_mask)) >> lsbd;


wire is_bstrpick_w  = alu_ex1_func_bitwidth_sel_w;
wire is_bstrpick_d  = alu_ex1_func_bitwidth_sel_d;

assign alu_exe_bstrpick_data[63:0] = {64{is_bstrpick_w}} & alu_exe_bstrpick_data_w |
                                     {64{is_bstrpick_d}} & alu_exe_bstrpick_data_d;

/// alsl.w/d

wire [63:0]alu_exe_alsl_data_w;
wire [63:0]alu_exe_alsl_data_wu;
wire [31:0]alu_exe_alsl_data_w_32;
wire [63:0]alu_exe_alsl_data_d;

wire [2:0] al_sa2 = alu_exe_opcode[16:15] + 1'b1;

assign alu_exe_alsl_data_w_32[31:0] = {alu_ex1_src0[31:0] << al_sa2[2:0]} + alu_ex1_src1[31:0];
assign alu_exe_alsl_data_w = {{32{alu_exe_alsl_data_w_32[31]}}, alu_exe_alsl_data_w_32[31:0]};
assign alu_exe_alsl_data_wu = {{32{1'b0}}, alu_exe_alsl_data_w_32[31:0]};

assign alu_exe_alsl_data_d = {alu_ex1_src0[63:0] << al_sa2} + alu_ex1_src1[63:0];


wire is_alsl_w;
wire is_alsl_wu;
wire is_alsl_d;

assign is_alsl_w  = alu_ex1_func_bitwidth_sel_w;
assign is_alsl_wu = alu_ex1_func_bitwidth_sel_wu;
assign is_alsl_d  = alu_ex1_func_bitwidth_sel_d;

assign alu_exe_alsl_data[63:0] = 
              {64{is_alsl_w }} & alu_exe_alsl_data_w  |
              {64{is_alsl_wu}} & alu_exe_alsl_data_wu |
              {64{is_alsl_d }} & alu_exe_alsl_data_d;



/// slli.w/d
/// sll.w/d

wire [4:0] ui5 = alu_exe_opcode[14:10]; 
wire [5:0] ui6 = alu_exe_opcode[15:10];


wire is_sll_w  = alu_exe_inst_sel_SLL && alu_ex1_func_bitwidth_sel_w;
wire is_sll_d  = alu_exe_inst_sel_SLL && alu_ex1_func_bitwidth_sel_d;
wire is_slli_w = alu_exe_inst_sel_SLLI && alu_ex1_func_bitwidth_sel_w;
wire is_slli_d = alu_exe_inst_sel_SLLI && alu_ex1_func_bitwidth_sel_d;

wire [31:0] is_slli_w_data_32 = alu_ex1_src0[31:0] << ui5;
wire [63:0] is_slli_w_data = {{32{is_slli_w_data_32[31]}}, is_slli_w_data_32[31:0]};
wire [63:0] is_slli_d_data = {alu_ex1_src0[63:0] << ui6};

wire [31:0] is_sll_w_data_32 = alu_ex1_src0[31:0] << alu_ex1_src1[4:0];
wire [63:0] is_sll_w_data = {{32{is_sll_w_data_32[31]}}, is_sll_w_data_32[31:0]};
wire [63:0] is_sll_d_data = {alu_ex1_src0[63:0] << alu_ex1_src1[5:0]};

assign alu_exe_sll_data[63:0] = 
                {64{is_sll_w}} & is_sll_w_data | 
                {64{is_sll_d}} & is_sll_d_data;

assign alu_exe_slli_data[63:0] = 
                {64{is_slli_w}} & is_slli_w_data | 
                {64{is_slli_d}} & is_slli_d_data;



/// andi ori xori
wire [63:0] imm12_add_data =  {{52{1'b0}}, alu_exe_opcode[21:10]};

assign alu_exe_andi_data[63:0] = alu_ex1_src0[63:0] & imm12_add_data;
assign alu_exe_ori_data [63:0] = alu_ex1_src0[63:0] | imm12_add_data;
assign alu_exe_xori_data[63:0] = alu_ex1_src0[63:0] ^ imm12_add_data;




/// srl
wire is_srl_w  = alu_exe_inst_sel_SRL && alu_ex1_func_bitwidth_sel_w;
wire is_srl_d  = alu_exe_inst_sel_SRL && alu_ex1_func_bitwidth_sel_d;
wire is_srli_w = alu_exe_inst_sel_SRLI && alu_ex1_func_bitwidth_sel_w;
wire is_srli_d = alu_exe_inst_sel_SRLI && alu_ex1_func_bitwidth_sel_d;

wire [31:0] is_srli_w_data_32 = alu_ex1_src0[31:0] >> ui5;
wire [63:0] is_srli_w_data = {{32{is_srli_w_data_32[31]}}, is_srli_w_data_32[31:0]};
wire [63:0] is_srli_d_data = {alu_ex1_src0[63:0] >> ui6};

wire [31:0] is_srl_w_data_32 = alu_ex1_src0[31:0] >> alu_ex1_src1[4:0];
wire [63:0] is_srl_w_data = {{32{is_srl_w_data_32[31]}}, is_srl_w_data_32[31:0]};
wire [63:0] is_srl_d_data = {alu_ex1_src0[63:0] >> alu_ex1_src1[5:0]};

assign alu_exe_srl_data[63:0] = 
                {64{is_srl_w}} & is_srl_w_data | 
                {64{is_srl_d}} & is_srl_d_data;

assign alu_exe_srli_data[63:0] = 
                {64{is_srli_w}} & is_srli_w_data | 
                {64{is_srli_d}} & is_srli_d_data;


/// sra.w/d srai.w/d 

wire is_sra_w =  alu_exe_inst_sel_SRA && alu_ex1_func_bitwidth_sel_w;
wire is_sra_d =  alu_exe_inst_sel_SRA && alu_ex1_func_bitwidth_sel_d;
wire is_srai_w = alu_exe_inst_sel_SRAI && alu_ex1_func_bitwidth_sel_w;
wire is_srai_d = alu_exe_inst_sel_SRAI && alu_ex1_func_bitwidth_sel_d;

wire [63:0] srai_w_data = {{32{alu_ex1_src0[31]}}, alu_ex1_src0[31:0]}; 

wire [63:0] is_srai_w_data_32 = srai_w_data[63:0] >> ui5;
wire [63:0] is_srai_w_data = {{32{is_srai_w_data_32[31]}}, is_srai_w_data_32[31:0]};

wire [127:0] srai_d_data = {{64{alu_ex1_src0[63]}}, alu_ex1_src0[63:0]};
wire [127:0] is_srai_d_data_t = {srai_d_data[127:0] >> ui6};
wire [63:0] is_srai_d_data = is_srai_d_data_t[63:0];

wire [63:0] is_sra_w_data_32 = srai_w_data[63:0] >> alu_ex1_src1[4:0];
wire [63:0] is_sra_w_data = {{32{is_sra_w_data_32[31]}}, is_sra_w_data_32[31:0]};

wire [127:0] is_sra_d_data_t = {srai_d_data[127:0] >> alu_ex1_src1[5:0]};
wire [63:0] is_sra_d_data = is_sra_d_data_t[63:0];

assign alu_exe_sra_data[63:0] = 
                {64{is_sra_w}} & is_sra_w_data | 
                {64{is_sra_d}} & is_sra_d_data;

assign alu_exe_srai_data[63:0] = 
                {64{is_srai_w}} & is_srai_w_data | 
                {64{is_srai_d}} & is_srai_d_data;


/// rotr.w/d rotri.w/d
wire is_rotr_w  = alu_exe_inst_sel_ROTR && alu_ex1_func_bitwidth_sel_w;
wire is_rotr_d  = alu_exe_inst_sel_ROTR && alu_ex1_func_bitwidth_sel_d;
wire is_rotri_w = alu_exe_inst_sel_ROTRI && alu_ex1_func_bitwidth_sel_w;
wire is_rotri_d = alu_exe_inst_sel_ROTRI && alu_ex1_func_bitwidth_sel_d;

wire [63:0] is_rotri_w_data_64 = {alu_ex1_src0[31:0], alu_ex1_src0[31:0]} >> ui5;
wire [63:0] is_rotri_w_data = {{32{is_rotri_w_data_64[31]}}, is_rotri_w_data_64[31:0]};

wire [127:0] is_rotri_d_data_128 = {alu_ex1_src0[63:0], alu_ex1_src0[63:0]} >> ui6;
wire [63:0]  is_rotri_d_data = is_rotri_d_data_128[63:0];

wire [63:0] is_rotr_w_data_64 = {alu_ex1_src0[31:0], alu_ex1_src0[31:0]} >> alu_ex1_src1[4:0];
wire [63:0] is_rotr_w_data = {{32{is_rotr_w_data_64[31]}}, is_rotr_w_data_64[31:0]};

wire [127:0] is_rotr_d_data_128 = {alu_ex1_src0[63:0], alu_ex1_src0[63:0]} >> alu_ex1_src1[5:0];
wire [63:0] is_rotr_d_data = is_rotr_d_data_128[63:0];

assign alu_exe_rotr_data[63:0] = 
                {64{is_rotr_w}} & is_rotr_w_data | 
                {64{is_rotr_d}} & is_rotr_d_data;

assign alu_exe_rotri_data[63:0] = 
                {64{is_rotri_w}} & is_rotri_w_data | 
                {64{is_rotri_d}} & is_rotri_d_data;


/// sub.w/d
wire is_sub_w = alu_exe_inst_sel_SUB && alu_ex1_func_bitwidth_sel_w;
wire is_sub_d = alu_exe_inst_sel_SUB && alu_ex1_func_bitwidth_sel_d;

wire [31:0] is_sub_w_data_32 = alu_ex1_src0[31:0] - alu_ex1_src1[31:0];
wire [63:0] is_sub_w_data = {{32{is_sub_w_data_32[31]}}, is_sub_w_data_32[31:0]};
wire [63:0] is_sub_d_data = {alu_ex1_src0[63:0] - alu_ex1_src1[63:0]}; 


assign alu_exe_sub_data[63:0] = 
                {64{is_sub_w}} & is_sub_w_data | 
                {64{is_sub_d}} & is_sub_d_data;


/// ext.w.b/h
wire is_extw_b = alu_exe_inst_sel_EXTWB;
wire is_extw_h = alu_exe_inst_sel_EXTWH;


wire [63:0] is_extw_b_data = {{56{alu_ex1_src0[7]}}, alu_ex1_src0[7:0]};
wire [63:0] is_extw_h_data = {{48{alu_ex1_src0[15]}}, alu_ex1_src0[15:0]};

assign alu_exe_ext_data[63:0] = 
                {64{is_extw_b}} & is_extw_b_data | 
                {64{is_extw_h}} & is_extw_h_data;


/// bytepick.w/d
wire is_bytepick_w = alu_exe_inst_sel_BYTEPICK && alu_ex1_func_bitwidth_sel_w;
wire is_bytepick_d = alu_exe_inst_sel_BYTEPICK && alu_ex1_func_bitwidth_sel_d;

wire [1:0] bytepick_sa2 = alu_exe_opcode[16:15];
wire [2:0] bytepick_sa3 = alu_exe_opcode[17:15];

wire [63:0] is_bytepick_w_data_64   = {alu_ex1_src1[31:0], alu_ex1_src0[31:0]};
wire [127:0] is_bytepick_d_data_128 = {alu_ex1_src1[63:0], alu_ex1_src0[63:0]};

reg [31:0] is_bytepick_w_data_r;
reg [63:0] is_bytepick_d_data_r;


always @(is_bytepick_w_data_64[63:0]
        or bytepick_sa2[1:0]) begin
casez({bytepick_sa2[1:0]})
    2'b00 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[63:32];
    2'b01 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[55:24];
    2'b10 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[47:16];
    2'b11 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[39: 8];
endcase
end
wire [63:0] is_bytepick_w_data = {{32{is_bytepick_w_data_r[31]}}, is_bytepick_w_data_r[31:0]};


always @(is_bytepick_d_data_128[127:0]
         or bytepick_sa3[2:0]) begin
casez({bytepick_sa3[2:0]})
    3'b000 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[127:64];
    3'b001 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[119:56];
    3'b010 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[111:48];
    3'b011 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[103:40];
    3'b100 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 95:32];
    3'b101 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 87:24];
    3'b110 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 79:16];
    3'b111 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 71: 8];
endcase
end
wire [63:0] is_bytepick_d_data = is_bytepick_d_data_r[63:0];

assign alu_exe_bytepick_data[63:0] = 
                                    {64{is_bytepick_w}} & is_bytepick_w_data | 
                                    {64{is_bytepick_d}} & is_bytepick_d_data;


/// nor 
wire [63:0] logic_nor_rslt;
assign logic_nor_rslt[63:0]   = ~(alu_ex1_src0[63:0] | alu_ex1_src1[63:0]);
assign alu_exe_nor_data[63:0] = logic_nor_rslt[63:0];


/// orn/ andn
assign alu_exe_orn_data[63:0]  = alu_ex1_src0[63:0] | (~alu_ex1_src1[63:0]);
assign alu_exe_andn_data[63:0] = alu_ex1_src0[63:0] & (~alu_ex1_src1[63:0]);



/// bstrins.w/d
wire is_bstrins_w = alu_exe_inst_sel_BSTRINS && alu_ex1_func_bitwidth_sel_w;
wire is_bstrins_d = alu_exe_inst_sel_BSTRINS && alu_ex1_func_bitwidth_sel_d;

wire [31:0] bstrins_w_mask       = msbw_mask & lsbw_mask;
wire [31:0] bstrins_w_mask_shift = bstrins_w_mask >> lsbw;
wire [63:0] bstrins_d_mask       = msbd_mask & lsbd_mask;
wire [63:0] bstrins_d_mask_shift = bstrins_d_mask >> lsbd;

wire [31:0] is_bstrins_w_data_32 = ((alu_ex1_src0[31:0] &  bstrins_w_mask_shift) << lsbw) |  
                                     alu_ex1_src2[31:0] & ~bstrins_w_mask;

wire [63:0] is_bstrins_w_data = {{32{is_bstrins_w_data_32[31]}}, is_bstrins_w_data_32[31:0]};

wire [63:0] is_bstrins_d_data = ((alu_ex1_src0[63:0] & bstrins_d_mask_shift) << lsbd)  |  
                                  alu_ex1_src2[63:0] & ~bstrins_d_mask;

assign alu_exe_bstrins_data[63:0] = 
                                    {64{is_bstrins_w}} & is_bstrins_w_data | 
                                    {64{is_bstrins_d}} & is_bstrins_d_data;



/// bitrev.4b/8b
wire is_bitrev4b = alu_exe_inst_sel_BITREV4B;
wire is_bitrev8b = alu_exe_inst_sel_BITREV8B;
wire is_bitrevw  = alu_exe_inst_sel_BITREVW;
wire is_bitrevd  = alu_exe_inst_sel_BITREVD;

wire [63:0] bitrev_src0 = alu_ex1_src0[63:0];

wire [7:0] bitrev_7 = {bitrev_src0[56], bitrev_src0[57], bitrev_src0[58], bitrev_src0[59], bitrev_src0[60], bitrev_src0[61], bitrev_src0[62], bitrev_src0[63]};
wire [7:0] bitrev_6 = {bitrev_src0[48], bitrev_src0[49], bitrev_src0[50], bitrev_src0[51], bitrev_src0[52], bitrev_src0[53], bitrev_src0[54], bitrev_src0[55]};
wire [7:0] bitrev_5 = {bitrev_src0[40], bitrev_src0[41], bitrev_src0[42], bitrev_src0[43], bitrev_src0[44], bitrev_src0[45], bitrev_src0[46], bitrev_src0[47]};
wire [7:0] bitrev_4 = {bitrev_src0[32], bitrev_src0[33], bitrev_src0[34], bitrev_src0[35], bitrev_src0[36], bitrev_src0[37], bitrev_src0[38], bitrev_src0[39]};

wire [7:0] bitrev_3 = {bitrev_src0[24], bitrev_src0[25], bitrev_src0[26], bitrev_src0[27], bitrev_src0[28], bitrev_src0[29], bitrev_src0[30], bitrev_src0[31]};
wire [7:0] bitrev_2 = {bitrev_src0[16], bitrev_src0[17], bitrev_src0[18], bitrev_src0[19], bitrev_src0[20], bitrev_src0[21], bitrev_src0[22], bitrev_src0[23]};
wire [7:0] bitrev_1 = {bitrev_src0[ 8], bitrev_src0[ 9], bitrev_src0[10], bitrev_src0[11], bitrev_src0[12], bitrev_src0[13], bitrev_src0[14], bitrev_src0[15]};
wire [7:0] bitrev_0 = {bitrev_src0[ 0], bitrev_src0[ 1], bitrev_src0[ 2], bitrev_src0[ 3], bitrev_src0[ 4], bitrev_src0[ 5], bitrev_src0[ 6], bitrev_src0[ 7]};

wire [63:0] is_bitrev4b_data = {{32{bitrev_3[7]}}, bitrev_3, bitrev_2, bitrev_1, bitrev_0};
wire [63:0] is_bitrev8b_data = {bitrev_7, bitrev_6, bitrev_5, bitrev_4, bitrev_3, bitrev_2, bitrev_1, bitrev_0};

wire [31:0] bitrev32_0 = {
                          bitrev_src0[ 0], bitrev_src0[ 1], bitrev_src0[ 2], bitrev_src0[ 3], bitrev_src0[ 4], bitrev_src0[ 5], bitrev_src0[ 6], bitrev_src0[ 7],
                          bitrev_src0[ 8], bitrev_src0[ 9], bitrev_src0[10], bitrev_src0[11], bitrev_src0[12], bitrev_src0[13], bitrev_src0[14], bitrev_src0[15],
                          bitrev_src0[16], bitrev_src0[17], bitrev_src0[18], bitrev_src0[19], bitrev_src0[20], bitrev_src0[21], bitrev_src0[22], bitrev_src0[23],
                          bitrev_src0[24], bitrev_src0[25], bitrev_src0[26], bitrev_src0[27], bitrev_src0[28], bitrev_src0[29], bitrev_src0[30], bitrev_src0[31]};

wire [63:0] is_bitrevw_data = {{32{bitrev32_0[31]}}, bitrev32_0};

wire [63:0] bitrev64_0 = {
                          bitrev_src0[ 0], bitrev_src0[ 1], bitrev_src0[ 2], bitrev_src0[ 3], bitrev_src0[ 4], bitrev_src0[ 5], bitrev_src0[ 6], bitrev_src0[ 7],
                          bitrev_src0[ 8], bitrev_src0[ 9], bitrev_src0[10], bitrev_src0[11], bitrev_src0[12], bitrev_src0[13], bitrev_src0[14], bitrev_src0[15],
                          bitrev_src0[16], bitrev_src0[17], bitrev_src0[18], bitrev_src0[19], bitrev_src0[20], bitrev_src0[21], bitrev_src0[22], bitrev_src0[23],
                          bitrev_src0[24], bitrev_src0[25], bitrev_src0[26], bitrev_src0[27], bitrev_src0[28], bitrev_src0[29], bitrev_src0[30], bitrev_src0[31],
                          bitrev_src0[32], bitrev_src0[33], bitrev_src0[34], bitrev_src0[35], bitrev_src0[36], bitrev_src0[37], bitrev_src0[38], bitrev_src0[39],
                          bitrev_src0[40], bitrev_src0[41], bitrev_src0[42], bitrev_src0[43], bitrev_src0[44], bitrev_src0[45], bitrev_src0[46], bitrev_src0[47],
                          bitrev_src0[48], bitrev_src0[49], bitrev_src0[50], bitrev_src0[51], bitrev_src0[52], bitrev_src0[53], bitrev_src0[54], bitrev_src0[55],
                          bitrev_src0[56], bitrev_src0[57], bitrev_src0[58], bitrev_src0[59], bitrev_src0[60], bitrev_src0[61], bitrev_src0[62], bitrev_src0[63]};

wire [63:0] is_bitrevd_data = bitrev64_0;

assign alu_exe_bitrev_data[63:0] = 
                              {64{is_bitrev4b}} & is_bitrev4b_data[63:0] |
                              {64{is_bitrev8b}} & is_bitrev8b_data[63:0] |
                              {64{is_bitrevw }} & is_bitrevw_data[63:0]  |
                              {64{is_bitrevd }} & is_bitrevd_data[63:0];



/// revb, revh
wire is_revb_2h = alu_exe_inst_sel_REVB2H;
wire is_revb_4h = alu_exe_inst_sel_REVB4H;
wire is_revb_2w = alu_exe_inst_sel_REVB2W;
wire is_revb_d  = alu_exe_inst_sel_REVBD;
wire is_revh_2w = alu_exe_inst_sel_REVH2W;
wire is_revh_d  = alu_exe_inst_sel_REVHD;

wire [63:0] revb_src0 = alu_ex1_src0[63:0];

wire [7:0] revb_0 = revb_src0[7:0];
wire [7:0] revb_1 = revb_src0[15:8];
wire [7:0] revb_2 = revb_src0[23:16];
wire [7:0] revb_3 = revb_src0[31:24];

wire [7:0] revb_4 = revb_src0[39:32];
wire [7:0] revb_5 = revb_src0[47:40];
wire [7:0] revb_6 = revb_src0[55:48];
wire [7:0] revb_7 = revb_src0[63:56];

wire [63:0] is_revb_2h_data = {{32{revb_2[7]}}, revb_2, revb_3, revb_0, revb_1};
wire [63:0] is_revb_4h_data = {revb_6, revb_7, revb_4, revb_5, revb_2, revb_3, revb_0, revb_1};
wire [63:0] is_revb_2w_data = {revb_4, revb_5, revb_6, revb_7, revb_0, revb_1, revb_2, revb_3};
wire [63:0] is_revb_d_data  = {revb_0, revb_1, revb_2, revb_3, revb_4, revb_5, revb_6, revb_7};


wire [15:0] revh_0 = revb_src0[15:0];
wire [15:0] revh_1 = revb_src0[31:16];

wire [15:0] revh_2 = revb_src0[47:32];
wire [15:0] revh_3 = revb_src0[63:48];

wire [63:0] is_revh_2w_data = {revh_2, revh_3, revh_0, revh_1};
wire [63:0] is_revh_d_data  = {revh_0, revh_1, revh_2, revh_3};

assign alu_exe_rev_data[63:0] = 
                              {64{is_revb_2h}} & is_revb_2h_data[63:0] |
                              {64{is_revb_4h}} & is_revb_4h_data[63:0] |
                              {64{is_revb_2w}} & is_revb_2w_data[63:0] |
                              {64{is_revb_d }} & is_revb_d_data[63:0]  |
                              {64{is_revh_2w}} & is_revh_2w_data[63:0] |
                              {64{is_revh_d }} & is_revh_d_data[63:0];


/// clo
wire is_count_w = alu_ex1_func_bitwidth_sel_w;
wire is_count_d = alu_ex1_func_bitwidth_sel_d;

wire [63:0] count_src     = alu_ex1_src0[63:0];
wire [63:0] count_rev_src = bitrev64_0[63:0];


wire is_count_one  = alu_exe_inst_sel_CLO || alu_exe_inst_sel_CTO;
wire is_count_zero = alu_exe_inst_sel_CLZ || alu_exe_inst_sel_CTZ;

wire is_right_left = alu_exe_inst_sel_CLO || alu_exe_inst_sel_CLZ;
wire is_left_right = alu_exe_inst_sel_CTO || alu_exe_inst_sel_CTZ;


wire [63:0] count_ffx_src;

assign count_ffx_src[63:0] = 
                            {64{is_count_one   & is_right_left & is_count_d }} & (~count_src[63:0])     |
                            {64{is_count_one   & is_right_left & is_count_w }} & (~{{32{1'b1}}, count_src[31:0]})     |
                            {64{is_count_one   & is_left_right & is_count_d }} & (~count_rev_src[63:0]) |
                            {64{is_count_one   & is_left_right & is_count_w }} & (~count_rev_src[63:0]) |
                            {64{is_count_zero  & is_right_left & is_count_d }} &  count_src[63:0]       |
                            {64{is_count_zero  & is_right_left & is_count_w }} &  {{32{1'b0}}, count_src[31:0]}       |
                            {64{is_count_zero  & is_left_right & is_count_d }} &  count_rev_src[63:0]   |
                            {64{is_count_zero  & is_left_right & is_count_w }} &  count_rev_src[63:0];

reg [63:0] count_ff0_rslt;
always @( count_ffx_src[63:0])
begin
  casez(count_ffx_src[63:0])
    64'b1???????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd0;
    64'b01??????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd1;
    64'b001?????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd2;
    64'b0001????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd3;
    64'b00001???????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd4;
    64'b000001??????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd5;
    64'b0000001?????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd6;
    64'b00000001????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd7;
    64'b000000001???????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd8;
    64'b0000000001??????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd9;
    64'b00000000001?????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd10;
    64'b000000000001????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd11;
    64'b0000000000001???????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd12;
    64'b00000000000001??????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd13;
    64'b000000000000001?????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd14;
    64'b0000000000000001????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd15;
    64'b00000000000000001???????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd16;
    64'b000000000000000001??????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd17;
    64'b0000000000000000001?????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd18;
    64'b00000000000000000001????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd19;
    64'b000000000000000000001???????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd20;
    64'b0000000000000000000001??????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd21;
    64'b00000000000000000000001?????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd22;
    64'b000000000000000000000001????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd23;
    64'b0000000000000000000000001???????????????????????????????????????: count_ff0_rslt[63:0] = 64'd24;
    64'b00000000000000000000000001??????????????????????????????????????: count_ff0_rslt[63:0] = 64'd25;
    64'b000000000000000000000000001?????????????????????????????????????: count_ff0_rslt[63:0] = 64'd26;
    64'b0000000000000000000000000001????????????????????????????????????: count_ff0_rslt[63:0] = 64'd27;
    64'b00000000000000000000000000001???????????????????????????????????: count_ff0_rslt[63:0] = 64'd28;
    64'b000000000000000000000000000001??????????????????????????????????: count_ff0_rslt[63:0] = 64'd29;
    64'b0000000000000000000000000000001?????????????????????????????????: count_ff0_rslt[63:0] = 64'd30;
    64'b00000000000000000000000000000001????????????????????????????????: count_ff0_rslt[63:0] = 64'd31;
    64'b000000000000000000000000000000001???????????????????????????????: count_ff0_rslt[63:0] = 64'd32;
    64'b0000000000000000000000000000000001??????????????????????????????: count_ff0_rslt[63:0] = 64'd33;
    64'b00000000000000000000000000000000001?????????????????????????????: count_ff0_rslt[63:0] = 64'd34;
    64'b000000000000000000000000000000000001????????????????????????????: count_ff0_rslt[63:0] = 64'd35;
    64'b0000000000000000000000000000000000001???????????????????????????: count_ff0_rslt[63:0] = 64'd36;
    64'b00000000000000000000000000000000000001??????????????????????????: count_ff0_rslt[63:0] = 64'd37;
    64'b000000000000000000000000000000000000001?????????????????????????: count_ff0_rslt[63:0] = 64'd38;
    64'b0000000000000000000000000000000000000001????????????????????????: count_ff0_rslt[63:0] = 64'd39;
    64'b00000000000000000000000000000000000000001???????????????????????: count_ff0_rslt[63:0] = 64'd40;
    64'b000000000000000000000000000000000000000001??????????????????????: count_ff0_rslt[63:0] = 64'd41;
    64'b0000000000000000000000000000000000000000001?????????????????????: count_ff0_rslt[63:0] = 64'd42;
    64'b00000000000000000000000000000000000000000001????????????????????: count_ff0_rslt[63:0] = 64'd43;
    64'b000000000000000000000000000000000000000000001???????????????????: count_ff0_rslt[63:0] = 64'd44;
    64'b0000000000000000000000000000000000000000000001??????????????????: count_ff0_rslt[63:0] = 64'd45;
    64'b00000000000000000000000000000000000000000000001?????????????????: count_ff0_rslt[63:0] = 64'd46;
    64'b000000000000000000000000000000000000000000000001????????????????: count_ff0_rslt[63:0] = 64'd47;
    64'b0000000000000000000000000000000000000000000000001???????????????: count_ff0_rslt[63:0] = 64'd48;
    64'b00000000000000000000000000000000000000000000000001??????????????: count_ff0_rslt[63:0] = 64'd49;
    64'b000000000000000000000000000000000000000000000000001?????????????: count_ff0_rslt[63:0] = 64'd50;
    64'b0000000000000000000000000000000000000000000000000001????????????: count_ff0_rslt[63:0] = 64'd51;
    64'b00000000000000000000000000000000000000000000000000001???????????: count_ff0_rslt[63:0] = 64'd52;
    64'b000000000000000000000000000000000000000000000000000001??????????: count_ff0_rslt[63:0] = 64'd53;
    64'b0000000000000000000000000000000000000000000000000000001?????????: count_ff0_rslt[63:0] = 64'd54;
    64'b00000000000000000000000000000000000000000000000000000001????????: count_ff0_rslt[63:0] = 64'd55;
    64'b000000000000000000000000000000000000000000000000000000001???????: count_ff0_rslt[63:0] = 64'd56;
    64'b0000000000000000000000000000000000000000000000000000000001??????: count_ff0_rslt[63:0] = 64'd57;
    64'b00000000000000000000000000000000000000000000000000000000001?????: count_ff0_rslt[63:0] = 64'd58;
    64'b000000000000000000000000000000000000000000000000000000000001????: count_ff0_rslt[63:0] = 64'd59;
    64'b0000000000000000000000000000000000000000000000000000000000001???: count_ff0_rslt[63:0] = 64'd60;
    64'b00000000000000000000000000000000000000000000000000000000000001??: count_ff0_rslt[63:0] = 64'd61;
    64'b000000000000000000000000000000000000000000000000000000000000001?: count_ff0_rslt[63:0] = 64'd62;
    64'b0000000000000000000000000000000000000000000000000000000000000001: count_ff0_rslt[63:0] = 64'd63;
    64'b0000000000000000000000000000000000000000000000000000000000000000: count_ff0_rslt[63:0] = 64'd64;
    default:                                                              count_ff0_rslt[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @643
end

wire [63:0] clo_w_data = (count_ff0_rslt <= 0) ? 64'd0   :  count_ff0_rslt - 8'd32;
wire [63:0] clo_d_data = count_ff0_rslt;
wire [63:0] cto_w_data = (count_ff0_rslt >= 32) ? 64'd32 :  count_ff0_rslt;
wire [63:0] cto_d_data = count_ff0_rslt;

assign alu_exe_clo_data[63:0] = 
                            {64{is_count_one & is_right_left & is_count_w }} & clo_w_data  |
                            {64{is_count_one & is_right_left & is_count_d }} & clo_d_data;

assign alu_exe_cto_data[63:0] =                            
                            {64{is_count_one & is_left_right & is_count_w }} & cto_w_data  |
                            {64{is_count_one & is_left_right & is_count_d }} & cto_d_data;



wire [63:0] clz_w_data = (count_ff0_rslt <= 0) ? 64'd0   :  count_ff0_rslt - 8'd32;
wire [63:0] clz_d_data = count_ff0_rslt;
wire [63:0] ctz_w_data = (count_ff0_rslt >= 32) ? 64'd32 :  count_ff0_rslt;
wire [63:0] ctz_d_data = count_ff0_rslt;

assign alu_exe_clz_data[63:0] = 
                            {64{is_count_zero & is_right_left & is_count_w }} & clz_w_data  |
                            {64{is_count_zero & is_right_left & is_count_d }} & clz_d_data;

assign alu_exe_ctz_data[63:0] = 
                            {64{is_count_zero & is_left_right & is_count_w }} & ctz_w_data  |
                            {64{is_count_zero & is_left_right & is_count_d }} & ctz_d_data;

// movgr2cf
assign alu_exe_movgf_data[63:0] = alu_ex1_src0[63:0];



//==========================================================
//                    ALU Result Merge
//==========================================================

assign alu_exex_pipex_data[63:0] = 
                {64{alu_exe_inst_sel_ALSL       }} & alu_exe_alsl_data      |
                {64{alu_exe_inst_sel_BYTEPICK   }} & alu_exe_bytepick_data  |
                {64{alu_exe_inst_sel_ADD        }} & alu_exe_add_data       |
                {64{alu_exe_inst_sel_SUB        }} & alu_exe_sub_data       |
                {64{alu_exe_inst_sel_SLT        }} & alu_exe_slt_data       |
                {64{alu_exe_inst_sel_SLTU       }} & alu_exe_sltu_data      |
                {64{alu_exe_inst_sel_MASKEQZ    }} & alu_exe_maskeqz_data   |
                {64{alu_exe_inst_sel_MASKNEZ    }} & alu_exe_masknez_data   |
                {64{alu_exe_inst_sel_NOR        }} & alu_exe_nor_data       |
                {64{alu_exe_inst_sel_AND        }} & alu_exe_and_data       |
                {64{alu_exe_inst_sel_OR         }} & alu_exe_or_data        |
                {64{alu_exe_inst_sel_XOR        }} & alu_exe_xor_data       |
                {64{alu_exe_inst_sel_ORN        }} & alu_exe_orn_data       |
                {64{alu_exe_inst_sel_ANDN       }} & alu_exe_andn_data      |
                {64{alu_exe_inst_sel_SLL        }} & alu_exe_sll_data       |
                {64{alu_exe_inst_sel_SRL        }} & alu_exe_srl_data       |
                {64{alu_exe_inst_sel_SRA        }} & alu_exe_sra_data       |
                {64{alu_exe_inst_sel_ROTR       }} & alu_exe_rotr_data      |
                {64{alu_exe_inst_sel_CLO        }} & alu_exe_clo_data       |
                {64{alu_exe_inst_sel_CLZ        }} & alu_exe_clz_data       |
                {64{alu_exe_inst_sel_CTO        }} & alu_exe_cto_data       |
                {64{alu_exe_inst_sel_CTZ        }} & alu_exe_ctz_data       |
                {64{alu_exe_inst_sel_REV        }} & alu_exe_rev_data       |
                {64{alu_exe_inst_sel_BITREV     }} & alu_exe_bitrev_data    |
                {64{alu_exe_inst_sel_EXT        }} & alu_exe_ext_data       |
                {64{alu_exe_inst_sel_SLLI       }} & alu_exe_slli_data      |
                {64{alu_exe_inst_sel_SRLI       }} & alu_exe_srli_data      |
                {64{alu_exe_inst_sel_SRAI       }} & alu_exe_srai_data      |
                {64{alu_exe_inst_sel_ROTRI      }} & alu_exe_rotri_data     |
                {64{alu_exe_inst_sel_BSTRINS    }} & alu_exe_bstrins_data   |
                {64{alu_exe_inst_sel_BSTRPICK   }} & alu_exe_bstrpick_data  |
                {64{alu_exe_inst_sel_SLTI       }} & alu_exe_slti_data      |
                {64{alu_exe_inst_sel_SLTUI      }} & alu_exe_sltui_data     |
                {64{alu_exe_inst_sel_ADDI       }} & alu_exe_addi_data      |
                {64{alu_exe_inst_sel_LU52I      }} & alu_exe_lu52i_data     |
                {64{alu_exe_inst_sel_ANDI       }} & alu_exe_andi_data      |
                {64{alu_exe_inst_sel_ORI        }} & alu_exe_ori_data       |
                {64{alu_exe_inst_sel_XORI       }} & alu_exe_xori_data      |
                {64{alu_exe_inst_sel_LU32I      }} & alu_exe_lu32i_data     |
                {64{alu_exe_inst_sel_LU12I      }} & alu_exe_lu12i_data     |
                {64{alu_exe_inst_sel_ADDU16I    }} & alu_exe_addu16i_data   |
                {64{alu_exe_inst_sel_MVGF       }} & alu_exe_movgf_data     |
                {64{alu_exe_inst_sel_ASRTLE     }} & alu_exe_asrtle_data    |
                {64{alu_exe_inst_sel_ASRTGE     }} & alu_exe_asrtge_data    |
                {64{alu_exe_inst_sel_CRC        }} & alu_exe_crc_data;

// ALU result
assign alu_rst[63:0] = alu_exex_pipex_data[63:0];


//==========================================================
//                   Output for RTU
//==========================================================
assign iu_rtu_ex1_alu_wb_vld     = idu_iu_ex1_alu_sel;
assign iu_rtu_ex1_alu_wb_dp      = idu_iu_ex1_alu_dp_sel;
assign iu_rtu_ex1_alu_cmplt      = idu_iu_ex1_alu_sel;
assign iu_rtu_ex1_alu_cmplt_dp   = idu_iu_ex1_alu_dp_sel;
assign iu_rtu_ex1_alu_inst_len   = idu_iu_ex1_inst_len;
assign iu_rtu_ex1_alu_inst_split = idu_iu_ex1_split;
assign iu_rtu_ex1_alu_data[63:0]     = alu_rst[63:0];
assign iu_rtu_ex1_alu_preg[5:0]      = idu_iu_ex1_dst0_reg[5:0];


// &Force("input", "forever_cpuclk") @640

// &ModuleEnd; @687
endmodule



