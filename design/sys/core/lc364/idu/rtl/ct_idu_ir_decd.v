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

// &ModuleBeg; @26
module ct_idu_ir_decd (
  // &Ports, @27
  input    wire          x_illegal,
  input    wire  [31:0]  x_opcode,
  input    wire          x_type_alu,
  input    wire          x_type_staddr,
  input    wire          x_type_vload,
  input    wire  [2 :0]  x_vsew,
  output   wire          x_alu_short,
  output   wire          x_bar,
  output   wire  [3 :0]  x_bar_type,
  output   wire          x_csr,
  output   wire          x_ecall,
  output   wire          x_fp,
  output   wire          x_load,
  output   wire          x_mfvr,
  output   wire          x_mtvr,
  output   wire          x_pcall,
  output   wire          x_pcfifo,
  output   wire          x_rts,
  output   wire          x_store,
  output   wire          x_str,
  output   wire          x_sync,
  output   wire          x_unit_stride,
  output   wire          x_vamo,
  output   wire          x_vdiv,
  output   wire          x_vec,
  output   wire          x_viq_srcv12_switch,
  output   wire          x_vmla_short,
  output   wire  [2 :0]  x_vmla_type,
  output   wire          x_vmul,
  output   wire          x_vmul_unsplit,
  output   wire          x_vsetvl,
  output   wire          x_vsetvli
); 



// &Regs; @28
// &Wires; @29
wire            decd_alu_short;        
wire            decd_bar;              
wire    [3 :0]  decd_bar_type;         
wire            decd_bar_type_sel;     
wire            decd_cmp_inst;         
wire            decd_csr;              
wire            decd_ecall;            
wire            decd_fmac_doub;        
wire            decd_fmac_half;        
wire            decd_fmac_sing;        
wire            decd_fp_inst;          
wire            decd_load;             
wire            decd_mfvr;             
wire            decd_mtvr;             
wire            decd_narr_vsft;        
wire            decd_opfvf;            
wire            decd_opfvv;            
wire            decd_opivi;            
wire            decd_opivv;            
wire            decd_opivx;            
wire            decd_opmvv;            
wire            decd_opmvx;            
wire            decd_pcall;            
wire            decd_pcfifo;           
wire            decd_permu;            
wire            decd_redu_vlgc;        
wire            decd_redu_vsum;        
wire            decd_return;           
wire            decd_rts;              
wire            decd_sca_fmac;         
wire            decd_sca_fmac_doub;    
wire            decd_sca_fmac_half;    
wire            decd_sca_fmac_sing;    
wire            decd_store;            
wire            decd_str;              
wire            decd_sub_call;         
wire            decd_sync;             
wire            decd_unit_stride;      
wire            decd_vamo;             
wire            decd_vdiv;             
wire            decd_vec_fmac;         
wire            decd_vec_fmac_doub;    
wire            decd_vec_fmac_half;    
wire            decd_vec_fmac_sing;    
wire            decd_vec_inst;         
wire            decd_vec_other;        
wire            decd_viq_srcv12_switch; 
wire            decd_vmac_norm;        
wire            decd_vmac_wide;        
wire            decd_vmla_short;       
wire    [2 :0]  decd_vmla_type;        
wire            decd_vmul;             
wire            decd_vmul_norm;        
wire            decd_vmul_unsplit;     
wire            decd_vmul_wide;        
wire            decd_vsetvl;           
wire            decd_vsetvli;          



//==========================================================
//                     Output Decode
//==========================================================
//CAUTION!!!
//illegal instruction keeps its opcode when pipedown from id stage
//ir decode should consider id stage illegal instruction
assign x_load              = !x_illegal && decd_load;
assign x_store             = !x_illegal && decd_store;
assign x_rts               = !x_illegal && decd_rts;
assign x_pcall             = !x_illegal && decd_pcall;
assign x_pcfifo            = !x_illegal && decd_pcfifo;
assign x_bar               = !x_illegal && decd_bar;
assign x_bar_type[3:0]     = {4{!x_illegal}} & decd_bar_type[3:0];
assign x_vdiv              = !x_illegal && decd_vdiv;
assign x_mfvr              = !x_illegal && decd_mfvr;
assign x_mtvr              = !x_illegal && decd_mtvr;
assign x_vmla_type[2:0]    = {3{!x_illegal}} & decd_vmla_type[2:0];
assign x_str               = !x_illegal && decd_str;
assign x_alu_short         = !x_illegal && decd_alu_short;
assign x_vmla_short        = !x_illegal && decd_vmla_short;
assign x_vmul_unsplit      = !x_illegal && decd_vmul_unsplit;
assign x_vmul              = !x_illegal && decd_vmul;
assign x_vsetvli           = !x_illegal && decd_vsetvli;
assign x_vsetvl            = !x_illegal && decd_vsetvl;
assign x_viq_srcv12_switch = !x_illegal && decd_viq_srcv12_switch;
assign x_unit_stride       = !x_illegal && decd_unit_stride;
assign x_vamo              = !x_illegal && decd_vamo;
assign x_vec               = !x_illegal && decd_vec_inst;
assign x_fp                = !x_illegal && decd_fp_inst;
assign x_csr               = !x_illegal && decd_csr;
assign x_sync              = !x_illegal && decd_sync;
assign x_ecall             = !x_illegal && decd_ecall;

//==========================================================
//                      Short ALU
//==========================================================
//Long ALU do not forward data in EX1
assign decd_alu_short =
  x_type_alu
  /// TODO: 
  && 1'b0 ;

//==========================================================
//                   Load and Store
//==========================================================

wire decd_amo;
assign decd_amo =   (x_opcode[31:15] == 17'b00111000011000000) || //amswap.w
                    (x_opcode[31:15] == 17'b00111000011000001) || //amswap.d
                    (x_opcode[31:15] == 17'b00111000011000010) || //amadd.w
                    (x_opcode[31:15] == 17'b00111000011000011) || //amadd.d
                    (x_opcode[31:15] == 17'b00111000011000100) || //amand.w
                    (x_opcode[31:15] == 17'b00111000011000101) || //amand.d
                    (x_opcode[31:15] == 17'b00111000011000110) || //amor.w
                    (x_opcode[31:15] == 17'b00111000011000111) || //amor.d
                    (x_opcode[31:15] == 17'b00111000011001000) || //amxor.w
                    (x_opcode[31:15] == 17'b00111000011001001) || //amxor.d
                    (x_opcode[31:15] == 17'b00111000011001010) || //ammax.w
                    (x_opcode[31:15] == 17'b00111000011001011) || //ammax.d
                    (x_opcode[31:15] == 17'b00111000011001100) || //ammin.w
                    (x_opcode[31:15] == 17'b00111000011001101) || //ammin.d
                    (x_opcode[31:15] == 17'b00111000011001110) || //ammax.wu
                    (x_opcode[31:15] == 17'b00111000011001111) || //ammax.du
                    (x_opcode[31:15] == 17'b00111000011010000) || //ammin.wu
                    (x_opcode[31:15] == 17'b00111000011010001); //ammin.du

wire decd_amo_sync;
assign decd_amo_sync =                       
                    (x_opcode[31:15] == 17'b00111000011010010) || //amswap_db.w
                    (x_opcode[31:15] == 17'b00111000011010011) || //amswap_db.d
                    (x_opcode[31:15] == 17'b00111000011010100) || //amadd_db.w
                    (x_opcode[31:15] == 17'b00111000011010101) || //amadd_db.d
                    (x_opcode[31:15] == 17'b00111000011010110) || //amand_db.w
                    (x_opcode[31:15] == 17'b00111000011010111) || //amand_db.d
                    (x_opcode[31:15] == 17'b00111000011011000) || //amor_db.w
                    (x_opcode[31:15] == 17'b00111000011011001) || //amor_db.d
                    (x_opcode[31:15] == 17'b00111000011011010) || //amxor_db.w
                    (x_opcode[31:15] == 17'b00111000011011011) || //amxor_db.d
                    (x_opcode[31:15] == 17'b00111000011011100) || //ammax_db.w
                    (x_opcode[31:15] == 17'b00111000011011101) || //ammax_db.d
                    (x_opcode[31:15] == 17'b00111000011011110) || //ammin_db.w
                    (x_opcode[31:15] == 17'b00111000011011111) || //ammin_db.d
                    (x_opcode[31:15] == 17'b00111000011100000) || //ammax_db.wu
                    (x_opcode[31:15] == 17'b00111000011100001) || //ammax_db.du
                    (x_opcode[31:15] == 17'b00111000011100010) || //ammin_db.wu
                    (x_opcode[31:15] == 17'b00111000011100011); //ammin_db.du


//----------------------------------------------------------
//                   Load Instruction
//----------------------------------------------------------
//control whether inst issue to pipe3 or pipe4
assign decd_load  =
        (x_opcode[31:24] == 8'b00100000) || //ll.w
        (x_opcode[31:24] == 8'b00100010) || //ll.d
        (x_opcode[31:24] == 8'b00100100) || //ldptr.w
        (x_opcode[31:24] == 8'b00100110) || //ldptr.d
        (x_opcode[31:22] == 10'b0010100000) || //ld.b
        (x_opcode[31:22] == 10'b0010100001) || //ld.h
        (x_opcode[31:22] == 10'b0010100010) || //ld.w
        (x_opcode[31:22] == 10'b0010100011) || //ld.d
        (x_opcode[31:22] == 10'b0010101000) || //ld.bu
        (x_opcode[31:22] == 10'b0010101001) || //ld.hu
        (x_opcode[31:22] == 10'b0010101010) || //ld.wu
        (x_opcode[31:22] == 10'b0010101011) || //preld
        (x_opcode[31:22] == 10'b0010101100) || //fld.s
        (x_opcode[31:22] == 10'b0010101110) || //fld.d
        (x_opcode[31:15] == 17'b00111000000000000) || //ldx.b
        (x_opcode[31:15] == 17'b00111000000001000) || //ldx.h
        (x_opcode[31:15] == 17'b00111000000010000) || //ldx.w
        (x_opcode[31:15] == 17'b00111000000011000) || //ldx.d
        (x_opcode[31:15] == 17'b00111000001000000) || //ldx.bu
        (x_opcode[31:15] == 17'b00111000001001000) || //ldx.hu
        (x_opcode[31:15] == 17'b00111000001010000) || //ldx.wu
        (x_opcode[31:15] == 17'b00111000001011000) || //preldx
        (x_opcode[31:15] == 17'b00111000001100000) || //fldx.s
        (x_opcode[31:15] == 17'b00111000001101000) || //fldx.d
        (x_opcode[31:15] == 17'b00111000011101000) || //fldgt.s
        (x_opcode[31:15] == 17'b00111000011101001) || //fldgt.d
        (x_opcode[31:15] == 17'b00111000011101010) || //fldle.s
        (x_opcode[31:15] == 17'b00111000011101011) || //fldle.d
        (x_opcode[31:15] == 17'b00111000011110000) || //ldgt.b
        (x_opcode[31:15] == 17'b00111000011110001) || //ldgt.h
        (x_opcode[31:15] == 17'b00111000011110010) || //ldgt.w
        (x_opcode[31:15] == 17'b00111000011110011) || //ldgt.d
        (x_opcode[31:15] == 17'b00111000011110100) || //ldle.b
        (x_opcode[31:15] == 17'b00111000011110101) || //ldle.h
        (x_opcode[31:15] == 17'b00111000011110110) || //ldle.w
        (x_opcode[31:15] == 17'b00111000011110111) || //ldle.d
        !x_type_staddr && decd_amo ||
        !x_type_staddr && decd_amo_sync ;


//----------------------------------------------------------
//                   Store Instruction
//----------------------------------------------------------
//control whether inst issue to pipe3 or pipe4

wire decd_3src_st_inst;
assign decd_3src_st_inst = decd_amo || // atomic need 3 src
                           decd_amo_sync || 
                        (x_opcode[31:15] == 17'b00111000000100000) || //stx.b
                        (x_opcode[31:15] == 17'b00111000000101000) || //stx.h
                        (x_opcode[31:15] == 17'b00111000000110000) || //stx.w
                        (x_opcode[31:15] == 17'b00111000000111000) || //stx.d
                        (x_opcode[31:15] == 17'b00111000001110000) || //fstx.s
                        (x_opcode[31:15] == 17'b00111000001111000) || //fstx.d
                        (x_opcode[31:15] == 17'b00111000011101100) || //fstgt.s
                        (x_opcode[31:15] == 17'b00111000011101101) || //fstgt.d
                        (x_opcode[31:15] == 17'b00111000011101110) || //fstle.s
                        (x_opcode[31:15] == 17'b00111000011101111) || //fstle.d
                        (x_opcode[31:15] == 17'b00111000011111000) || //stgt.b
                        (x_opcode[31:15] == 17'b00111000011111001) || //stgt.h
                        (x_opcode[31:15] == 17'b00111000011111010) || //stgt.w
                        (x_opcode[31:15] == 17'b00111000011111011) || //stgt.d
                        (x_opcode[31:15] == 17'b00111000011111100) || //stle.b
                        (x_opcode[31:15] == 17'b00111000011111101) || //stle.h
                        (x_opcode[31:15] == 17'b00111000011111110) || //stle.w
                        (x_opcode[31:15] == 17'b00111000011111111);   //stle.d

assign decd_store =
        (x_opcode[31:24] == 8'b00100001) || //sc.w
        (x_opcode[31:24] == 8'b00100011) || //sc.d
        (x_opcode[31:24] == 8'b00100101) || //stptr.w
        (x_opcode[31:24] == 8'b00100111) || //stptr.d
        (x_opcode[31:22] == 10'b0010100100) || //st.b
        (x_opcode[31:22] == 10'b0010100101) || //st.h
        (x_opcode[31:22] == 10'b0010100110) || //st.w
        (x_opcode[31:22] == 10'b0010100111) || //st.d
        (x_opcode[31:22] == 10'b0010101101) || //fst.s
        (x_opcode[31:22] == 10'b0010101111) || //fst.d
        (x_opcode[31:15] == 17'b00000110010010011) || //invtlb
        (x_opcode[31:22] == 10'b0000011000) || // cache
        x_type_staddr && decd_3src_st_inst || 
        x_type_staddr && decd_amo ||
        x_type_staddr && decd_amo_sync;

//----------------------------------------------------------
//               Reg Offset Store Instruction
//----------------------------------------------------------
// assign decd_str = 1'b0;
assign decd_str = decd_3src_st_inst;

//----------------------------------------------------------
//               Fence lr/sc amo Instruction
//----------------------------------------------------------
assign decd_sync =
        (x_opcode[31:15] == 17'b00111000011100100) || //dbar
        (x_opcode[31:15] == 17'b00111000011100101) || //ibar
        (x_opcode[31:15] == 17'b00000110010010011) || //invtlb
        (x_opcode[31:22] == 10'b0000011000) || // cache
        decd_amo_sync;

//==========================================================
//                   BJU Information
//==========================================================
//----------------------------------------------------------
//            Return Stack Related Instruction
//----------------------------------------------------------
assign decd_return = (x_opcode[31:26] == 6'b010011)     // jirl;
                     && (x_opcode[9:5] == 5'b00001);   

assign decd_sub_call = (x_opcode[31:26] == 6'b010011)   // jirl;
                         && (x_opcode[4:0] == 5'b00001) || 
                       (x_opcode[31:26] == 6'b010101);    // bl

assign decd_rts    = decd_return;

assign decd_pcall  = decd_sub_call;

//----------------------------------------------------------
//                    PCFIFO Instruction
//----------------------------------------------------------
assign decd_pcfifo = (x_opcode[31:26] == 6'b010000) || // beqz
                     (x_opcode[31:26] == 6'b010001) || // bnez
                     ({x_opcode[31:26], x_opcode[9:8]} == 8'b010010_00) || // bceqz
                     ({x_opcode[31:26], x_opcode[9:8]} == 8'b010010_01) || // bcnez
                     (x_opcode[31:26] == 6'b010011) || // jirl
                     (x_opcode[31:26] == 6'b010100) || // b
                     (x_opcode[31:26] == 6'b010101) || // bl
                     (x_opcode[31:26] == 6'b010110) || // beq
                     (x_opcode[31:26] == 6'b010111) || // bne
                     (x_opcode[31:26] == 6'b011000) || // blt
                     (x_opcode[31:26] == 6'b011001) || // bgt
                     (x_opcode[31:26] == 6'b011010) || // bltu
                     (x_opcode[31:26] == 6'b011011) || // bgeu
                     (x_opcode[31:25] == 7'b0001100) || // pcaddi
                     (x_opcode[31:25] == 7'b0001101) || // pcalau12i
                     (x_opcode[31:25] == 7'b0001110) || // pcaddu12i
                     (x_opcode[31:25] == 7'b0001111);   // pcaddu18i


//==========================================================
//                   Barrier Instruction
//==========================================================
assign decd_bar = (x_opcode[31:15] == 17'b00111000011100100) || //dbar
                  (x_opcode[31:15] == 17'b00111000011100101);   //ibar

//treat all bar_type as 1111 except 1010 to preven
//lsiq issue dead lock
assign decd_bar_type_sel  =  (x_opcode[26] || x_opcode[24])
                         && !(x_opcode[27] || x_opcode[25])
                         &&  (x_opcode[22] || x_opcode[20])
                         && !(x_opcode[23] || x_opcode[21]);

assign decd_bar_type[3:0] = (decd_bar_type_sel)
                            ? 4'b1010 : 4'b1111;

//==========================================================
//                  Special Instruction
//==========================================================
assign decd_csr = ({x_opcode[31:24], x_opcode[9:5]} == 13'b00000100_00000) || //csrrd
                  ({x_opcode[31:24], x_opcode[9:5]} == 13'b00000100_00001) || //csrwr
                  (x_opcode[31:10] == 22'b00000000000000000_11011) || // cpucfg
                  ({x_opcode[31:24]} == 8'b00000100) 
                   && (x_opcode[9:5] != 5'b00000)
                   && (x_opcode[9:5] != 5'b00001); //csrxchg

assign decd_ecall = (x_opcode[31:25] == 7'b0001010) || // break
                    (x_opcode[31:25] == 7'b0001011) || // dbgcall
                    (x_opcode[31:25] == 7'b0001100) || // syscall
                    (x_opcode[31:25] == 7'b0001101);   // hypcall;


//==========================================================//
//    The Following Code NOT USED!
//==========================================================//



//==========================================================
//                    Vector Instruction
//==========================================================
//CAUTION!!!
//illegal instruction keeps its opcode when pipedown from id stage
//ir decode should consider id stage illegal instruction
assign decd_vec_inst = 1'b0;

assign decd_fp_inst  = (x_opcode[31:22] == 10'b0000000100) || // fp other
                       (x_opcode[31:24] == 8'b00001000) ||    // fp fuse
                       (x_opcode[31:24] == 8'b00001100) ||    // fcmp
                       (x_opcode[31:24] == 8'b00001101);      // fsel 

assign decd_opivv    = 1'b0;
assign decd_opivx    = 1'b0;
assign decd_opivi    = 1'b0;
assign decd_opmvv    = 1'b0;
assign decd_opmvx    = 1'b0;
assign decd_opfvv    = 1'b0;
assign decd_opfvf    = 1'b0;

                        
// div, include sqrt,div and vector
assign decd_vdiv = (x_opcode[31:15] == 17'b00000001000001101) || // fdiv.s
                   (x_opcode[31:15] == 17'b00000001000001110) || // fdiv.d
                   (x_opcode[31:10] == 22'b0000000100010100010001) || // fsqrt.s
                   (x_opcode[31:10] == 22'b0000000100010100010010) || // fsqrt.d
                   (x_opcode[31:10] == 22'b0000000100010100010101) || // frecip.s
                   (x_opcode[31:10] == 22'b0000000100010100010110);   // frecip.d


assign decd_mfvr = (x_opcode[31:20] == 12'b000011000001)   // fcmp.s
                || (x_opcode[31:20] == 12'b000011000010)   // fcmp.d
                || (x_opcode[31:10] == 22'b0000000100010100101101)  // movfr2gr.s
                || (x_opcode[31:10] == 22'b0000000100010100101110)  // movfr2gr.d
                || (x_opcode[31:10] == 22'b0000000100010100110100)  // movfr2cf
                // || (x_opcode[31:10] == 22'b0000000100010100110010) // movfcsr2gr
                || (x_opcode[31:10] == 22'b0000000100010100101111); // movfrh2gr.s


assign decd_mtvr = (x_opcode[31:10] == 22'b0000000100010100101001)  // movgr2fr.w
                || (x_opcode[31:10] == 22'b0000000100010100101010)  // movgr2fr.d
                || (x_opcode[31:10] == 22'b0000000100010100110101); // movcf2fr
                // || (x_opcode[31:10] == 22'b0000000100010100110000) // movgr2fcsr
                // || (x_opcode[31:10] == 22'b0000000100010100101011) // movgr2frh.w


//type info for vfpu internal forward
assign decd_vmla_type[2:0] = {3{1'b0}};  //vmla_type[2]==1 is used specially for integer vmac inst

assign decd_redu_vsum = 1'b0;

assign decd_redu_vlgc = 1'b0;

assign decd_narr_vsft =  1'b0;

assign decd_cmp_inst  = 1'b0;

assign decd_permu = 1'b0;

assign decd_vec_other = 1'b0;

assign decd_vec_fmac  = 1'b0;
assign decd_sca_fmac  = (x_opcode[31:24] == 8'b00001000);

assign decd_vec_fmac_half = 1'b0; 
assign decd_vec_fmac_sing = 1'b0; 
assign decd_vec_fmac_doub = 1'b0;

assign decd_sca_fmac_half = 1'b0;
assign decd_sca_fmac_sing = (x_opcode[31:20] == 12'b000010000001)  //fmadd.s
                         || (x_opcode[31:20] == 12'b000010000101)  //fmsub.s
                         || (x_opcode[31:20] == 12'b000010001001)  //fnmadd.s
                         || (x_opcode[31:20] == 12'b000010001101); //fnmsub.s;

assign decd_sca_fmac_doub = (x_opcode[31:20] == 12'b000010000010)  //fmadd.d
                         || (x_opcode[31:20] == 12'b000010000110)  //fmsub.d
                         || (x_opcode[31:20] == 12'b000010001010)  //fnmadd.d
                         || (x_opcode[31:20] == 12'b000010001110); //fnmsub.d;



assign decd_fmac_half     = 1'b0;
assign decd_fmac_sing     = decd_sca_fmac_sing && decd_sca_fmac; 
assign decd_fmac_doub     = decd_sca_fmac_doub && decd_sca_fmac;

//vfpu back to back issue
assign decd_vmla_short = 1'b0;

//pipe7 vmul_unsplit will lch fail pipe6 vmul
assign decd_vmul_unsplit = 1'b0;

assign decd_vmul_norm = 1'b0;

assign decd_vmac_norm = 1'b0;

assign decd_vmul_wide = 1'b0;

assign decd_vmac_wide = 1'b0;

assign decd_vmul = 1'b0;

assign decd_vsetvli = 1'b0;

assign decd_vsetvl  = 1'b0;

assign decd_viq_srcv12_switch = 1'b0;

assign decd_unit_stride = 1'b0;

assign decd_vamo = 1'b0;  //zvlsseg also use this signal for vmb

// &ModuleEnd; @511
endmodule


