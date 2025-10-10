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
module ct_idu_id_decd (
  // &Ports, @28
  input    wire          cp0_idu_cskyee,
  input    wire  [2 :0]  cp0_idu_frm,
  input    wire  [1 :0]  cp0_idu_fs,
  input    wire          cp0_idu_vill,
  input    wire  [1 :0]  cp0_idu_vs,
  input    wire  [6 :0]  cp0_idu_vstart,
  input    wire          cp0_idu_zero_delay_move_disable,
  input    wire          cp0_yy_hyper,
  input    wire  [31:0]  x_inst,
  input    wire  [7 :0]  x_vl,
  input    wire  [1 :0]  x_vlmul,
  input    wire  [1 :0]  x_vsew,
  output   wire  [4 :0]  x_dst_reg,
  output   reg           x_dst_vld,
  output   wire          x_dst_x0,
  output   reg           x_dste_vld,
  output   wire  [4 :0]  x_dstf_reg,
  output   reg           x_dstf_vld,
  output   wire  [4 :0]  x_dstv_reg,
  output   reg           x_dstv_vld,
  output   wire  [2 :0]  x_fence_type,
  output   wire          x_fmla,
  output   wire          x_fmov,
  output   wire          x_illegal,
  output   reg   [9 :0]  x_inst_type,
  output   wire          x_length,
  output   wire          x_mla,
  output   wire          x_mov,
  output   wire  [9 :0]  x_split_long_type,
  output   wire  [6 :0]  x_split_short_type,
  output   wire  [4 :0]  x_src0_reg,
  output   reg           x_src0_vld,
  output   wire  [4 :0]  x_src1_reg,
  output   reg           x_src1_vld,
  output   reg           x_src2_vld,
  output   wire  [4 :0]  x_srcf0_reg,
  output   reg           x_srcf0_vld,
  output   wire  [4 :0]  x_srcf1_reg,
  output   reg           x_srcf1_vld,
  output   wire  [4 :0]  x_srcf2_reg,
  output   reg           x_srcf2_vld,
  output   wire  [4 :0]  x_srcv0_reg,
  output   reg           x_srcv0_vld,
  output   wire  [4 :0]  x_srcv1_reg,
  output   reg           x_srcv1_vld,
  output   reg           x_srcv2_vld,
  output   wire          x_srcvm_vld,
  output   wire          x_vmb,
  output   wire          x_vmla
); 



// &Regs; @29
reg             decd_16_dst_vld;                
reg             decd_16_dstf_vld;               
reg             decd_16_illegal;                
reg     [9 :0]  decd_16_inst_type;              
reg             decd_16_src0_vld;               
reg             decd_16_src1_vld;               
reg             decd_16_srcf1_vld;              
reg             decd_16_srcf2_vld;              
reg             decd_32_dst_vld;                
reg             decd_32_dste_vld;               
reg             decd_32_dstf_vld;               
reg             decd_32_dstv_vld;               
reg             decd_32_illegal;                
reg     [9 :0]  decd_32_inst_type;              
reg             decd_32_src0_vld;               
reg             decd_32_src1_vld;               
reg             decd_32_src2_vld;               
reg             decd_32_srcf0_vld;              
reg             decd_32_srcf1_vld;              
reg             decd_32_srcf2_vld;              
reg             decd_32_srcv0_vld;              
reg             decd_32_srcv2_vld;              
reg             decd_cache_illegal;             
reg     [9 :0]  decd_cache_inst_type;           
reg             decd_cache_src1_vld;            
reg             decd_code_illegal;              
reg             decd_fp0_dst_vld;               
reg             decd_fp0_dste_vld;              
reg             decd_fp0_dstf_vld;              
reg             decd_fp0_illegal;               
reg     [9 :0]  decd_fp0_inst_type;             
reg             decd_fp0_src0_vld;              
reg             decd_fp0_srcf0_vld;             
reg             decd_fp0_srcf1_vld;             
reg             decd_fp1_dst_vld;               
reg             decd_fp1_dste_vld;              
reg             decd_fp1_dstf_vld;              
reg             decd_fp1_illegal;               
reg     [9 :0]  decd_fp1_inst_type;             
reg             decd_fp1_src0_vld;              
reg             decd_fp1_srcf0_vld;             
reg             decd_fp1_srcf1_vld;             
reg             decd_fp1_srcf2_vld;             
reg             decd_fp_dst_vld;                
reg             decd_fp_dste_vld;               
reg             decd_fp_dstf_vld;               
reg             decd_fp_inst_illegal;           
reg     [9 :0]  decd_fp_inst_type;              
reg             decd_fp_src0_vld;               
reg             decd_fp_src1_vld;               
reg             decd_fp_srcf0_vld;              
reg             decd_fp_srcf1_vld;              
reg             decd_fp_srcf2_vld;              
reg             decd_perf_dst_vld;              
reg             decd_perf_dstf_vld;             
reg             decd_perf_illegal;              
reg     [9 :0]  decd_perf_inst_type;            
reg             decd_perf_src0_vld;             
reg             decd_perf_src1_vld;             
reg             decd_perf_src2_vld;             
reg             decd_perf_srcf1_vld;            
reg             decd_perf_srcf2_vld;            
reg             decd_v_dst_vld;                 
reg             decd_v_dste_vld;                
reg             decd_v_dstf_vld;                
reg             decd_v_dstv_vld;                
reg     [9 :0]  decd_v_inst_type;               
reg             decd_v_src0_vld;                
reg             decd_v_src1_vld;                
reg             decd_v_src2_vld;                
reg             decd_v_srcf0_vld;               
reg             decd_v_srcf1_vld;               
reg             decd_v_srcf2_vld;               
reg             decd_v_srcv0_vld;               
reg             decd_v_srcv1_vld;               
reg             decd_v_srcv2_vld;               
reg             decd_vec_dst_vld;               
reg             decd_vec_dste_vld;              
reg             decd_vec_dstf_vld;              
reg             decd_vec_dstv_vld;              
reg             decd_vec_illegal;               
reg     [9 :0]  decd_vec_inst_type;             
reg             decd_vec_src0_vld;              
reg             decd_vec_src1_vld;              
reg             decd_vec_src2_vld;              
reg             decd_vec_srcf0_vld;             
reg             decd_vec_srcf1_vld;             
reg             decd_vec_srcf2_vld;             
reg             decd_vec_srcv0_vld;             
reg             decd_vec_srcv1_vld;             
reg             decd_vec_srcv2_vld;             

// &Wires; @30
wire            decd_c_illegal;                 
wire    [4 :0]  decd_dst_reg;   
wire            decd_flsu_illegal;              
wire            decd_fp0_sel;                   
wire            decd_fp1_sel;                   
wire            decd_fp_illegal;                
wire            decd_fp_rounding_illegal;       
wire            decd_fp_sel;                    
wire            decd_fs_illegal;                
wire            decd_i_illegal;                 
wire            decd_inst_cls;                  
wire            decd_inst_cls_sp;               
wire            decd_inst_dst_reg_16bit_3_high; 
wire            decd_inst_dst_reg_16bit_3_low;  
wire            decd_inst_dst_reg_16bit_5;      
wire            decd_inst_dst_reg_32bit;        
wire            decd_inst_dstf_reg_16bit_low;   
wire            decd_inst_dstf_reg_32bit;       
wire            decd_inst_fls;                  
wire            decd_inst_src0_reg_16bit_3;     
wire            decd_inst_src0_reg_16bit_5;     
wire            decd_inst_src0_reg_32bit;       
wire            decd_inst_src0_reg_cmv;         
wire            decd_inst_src0_reg_r2;          
wire            decd_inst_src1_reg_16bit_3;     
wire            decd_inst_src1_reg_16bit_5;     
wire            decd_inst_src1_reg_32bit;       
wire            decd_inst_srcf1_reg_16bit;      
wire            decd_inst_srcf1_reg_16bit_low;  
wire            decd_inst_srcf1_reg_32bit;      
wire            decd_inst_srcf1_reg_32bit_low;  
wire            decd_inst_vec;                  
wire            decd_inst_vls;                  
wire            decd_length;                    
wire            decd_lsu_illegal;               
wire            decd_ovlp_illegal;              
wire    [5 :0]  decd_sel;                       
wire            decd_size_illegal;              
wire    [4 :0]  decd_src0_reg;                  
wire    [4 :0]  decd_src1_reg;                  
wire            decd_start_illegal;             
wire            decd_v_illegal;                 
wire            decd_vec_nop;                   
wire            decd_vill_illegal;              
wire            decd_vlsu_illegal;              
wire            decd_vreg_illegal;              
wire            decd_vs_illegal;                
wire            fcvt_f_x_narrow_il;             
wire            fcvt_f_x_widden;                
wire            fp_dynamic_rounding_illegal;    
wire            fp_fs_illegal;                  
wire            fp_static_rounding_illegal;     
wire            vec_mfvr_inst;                  
wire            vlsu_ld_srcv2_vld;              
wire            x_fence;                        
wire    [8 :0]  x_ovlp_ill;                     
wire    [2 :0]  x_ovlp_illegal;                 
wire    [3 :0]  x_size_ill_case;                
wire            x_split;                        
wire    [2 :0]  x_split_potnt;                  
wire            x_split_short;                  
wire    [2 :0]  x_split_short_potnt;            
wire            x_srcv0_srcv1_switch;           
wire            x_srcv1_srcv2_switch;           
wire            x_vec_fp_ac_fcsr;               
wire            x_vec_inst;                     
wire            x_vec_inst_ac_fcsr;             
wire            x_vec_inst_adc;                 
wire            x_vec_inst_comp;                
wire            x_vec_inst_funary;              
wire            x_vec_inst_mask;                
wire            x_vec_inst_narr;                
wire            x_vec_inst_scalar;              
wire            x_vec_inst_slidedown;           
wire            x_vec_inst_slideup;             
wire            x_vec_inst_vcompress;           
wire            x_vec_inst_vid;                 
wire            x_vec_inst_viota;               
wire            x_vec_inst_vred;                
wire            x_vec_inst_vred_n;              
wire            x_vec_inst_vred_w;              
wire            x_vec_inst_vrgather;            
wire            x_vec_inst_wide;                
wire            x_vec_inst_wide_w;              
wire            x_vec_opcfg;                    
wire            x_vec_opfvf;                    
wire            x_vec_opfvv;                    
wire            x_vec_opivi;                    
wire            x_vec_opivv;                    
wire            x_vec_opivx;                    
wire            x_vec_opmvv;                    
wire            x_vec_opmvx;                    
wire            x_vec_vfunary0;                 
wire            x_vec_vfunary1;                 
wire            x_vec_vmunary0;                 
wire            x_vfunary0_vld;                 
wire            x_vfunary0_vld_narr;            
wire            x_vfunary0_vld_norm;            
wire            x_vfunary0_vld_wide;            
wire            x_vmunary0_vld;                 
wire            x_vreg_dst_norm;                
wire    [4 :0]  x_vreg_ill;                     
wire    [2 :0]  x_vreg_illegal;                 
wire            x_vreg_src0_norm;               
wire            x_vreg_src1_norm;               

wire            fp_st_inst;
wire            is_fp_inst_fcmpx;
wire            is_fp_inst_movxx2cf;

// &Force("bus","x_inst",31,0); @33
//==========================================================
//                   Decode Split Type
//==========================================================
// &Force ("nonport","x_split"); @37
// &Force ("nonport","x_split_short"); @38
// &Force ("nonport","x_fence"); @39
// &Force ("nonport","x_split_potnt"); @40
// &Force ("nonport","x_split_short_potnt"); @41

// &Instance("ct_idu_id_decd_special", "x_ct_idu_id_decd_special"); @43
ct_idu_id_decd_special  x_ct_idu_id_decd_special (
  .cp0_idu_cskyee      (cp0_idu_cskyee     ),
  .cp0_idu_frm         (cp0_idu_frm        ),
  .cp0_idu_fs          (cp0_idu_fs         ),
  .x_fence             (x_fence            ),
  .x_fence_type        (x_fence_type       ),
  .x_inst              (x_inst             ),
  .x_split             (x_split            ),
  .x_split_long_type   (x_split_long_type  ),
  .x_split_potnt       (x_split_potnt      ),
  .x_split_short       (x_split_short      ),
  .x_split_short_potnt (x_split_short_potnt),
  .x_split_short_type  (x_split_short_type )
);


//==========================================================
//               Decode Instruction Length
//==========================================================
assign decd_length  = 1'b1;
assign x_length     = decd_length;

// fp inst enable
assign decd_fp_sel  = (x_inst[31:22] == 10'b0000000100) || // fp other
                      (x_inst[31:24] == 8'b00001000) ||    // fp fuse
                      (x_inst[31:24] == 8'b00001100) ||    // fcmp
                      (x_inst[31:24] == 8'b00001101);      // fsel 

//==========================================================
//                Decode move Instruction
//==========================================================
//if mov has same dest and source, disable 0 delay move
//because mov may release its dest preg before its consumer
//get this preg value
assign x_mov  = !cp0_idu_zero_delay_move_disable
                // TODO:
                && 1'b0 ; //dest not equal to src

assign x_fmov = !cp0_idu_zero_delay_move_disable
                // TODO:
                && 1'b0; //dst not equal to src

//==========================================================
//                 Decode mla Instruction
//==========================================================
assign x_mla   = 1'b0;

//==========================================================
//                 Decode fmla Instruction
//==========================================================
assign x_fmla  = 1'b0;

//==========================================================
//                 Decode vmla Instruction
//==========================================================
assign x_vmla  = 1'b0; //vfmacc

//==========================================================
//                Decode vec mask Instruction
//==========================================================
assign x_srcvm_vld = 1'b0;

//==========================================================
//                 Decode vmb Instruction
//==========================================================
assign x_vmb   = 1'b0;

//==========================================================
//              Decode Source Register Index
//==========================================================
//----------------------------------------------------------
//                  Source 0 Register Index
//----------------------------------------------------------
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign decd_inst_src0_reg_32bit   = 1'b1;

wire  branch_b_inst_reg = (x_inst[31:26] == 6'b010110) || // beq
                          (x_inst[31:26] == 6'b010111) || // bne
                          (x_inst[31:26] == 6'b011000) || // blt
                          (x_inst[31:26] == 6'b011001) || // bgt
                          (x_inst[31:26] == 6'b011010) || // bltu
                          (x_inst[31:26] == 6'b011011);   // bgeu

wire bstrins_inst_reg = ({x_inst[31:21], x_inst[15]} == 12'b00000000011_0) ||  // bstrins.w
                        ({x_inst[31:22]} == 10'b0000000010);                   // bstrins.d


//index select
assign decd_src0_reg[4:0] = x_inst[9 :5];

//output
assign x_src0_reg[4:0] = decd_src0_reg[4:0];

//----------------------------------------------------------
//                  Source 1 Register Index
//----------------------------------------------------------
assign decd_inst_src1_reg_32bit     = 1'b1;
assign decd_inst_src1_reg_16bit_5   = (x_inst[1:0] == 2'b10);
assign decd_inst_src1_reg_16bit_3   = (x_inst[1:0] == 2'b00)
                                   || (x_inst[1:0] == 2'b01);

wire store_inst_data_reg = (x_inst[31:24] == 8'b00100001) || //sc.w
                           (x_inst[31:24] == 8'b00100011) || //sc.d
                           (x_inst[31:24] == 8'b00100101) || //stptr.w
                           (x_inst[31:24] == 8'b00100111) || //stptr.d
                           (x_inst[31:22] == 10'b0010100100) || //st.b
                           (x_inst[31:22] == 10'b0010100101) || //st.h
                           (x_inst[31:22] == 10'b0010100110) || //st.w
                           (x_inst[31:22] == 10'b0010100111);   //st.d


//index select
assign decd_src1_reg[4:0] =
                         ( branch_b_inst_reg
                            || bstrins_inst_reg
                            || store_inst_data_reg ) ?  
                           x_inst[4 :0] 
                         : x_inst[14:10];

//output
assign x_src1_reg[4:0] = decd_src1_reg[4:0];

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic

//----------------------------------------------------------
//          Decode destination register index
//----------------------------------------------------------
assign decd_inst_dst_reg_32bit        =  1'b1;
assign decd_inst_dst_reg_16bit_5      = ({x_inst[1:0],x_inst[15]} == 3'b01_0)
                                      || (x_inst[1:0] == 2'b10);
assign decd_inst_dst_reg_16bit_3_high = ({x_inst[1:0],x_inst[15]} == 3'b01_1);
assign decd_inst_dst_reg_16bit_3_low  =  (x_inst[1:0] == 2'b00);


wire branch_link_inst_reg = (x_inst[31:26] == 6'b010101);  // bl

//index select
assign decd_dst_reg[4:0] =
                   {5{decd_inst_dst_reg_32bit}} & x_inst[4:0];
//output
assign x_dst_reg[4:0] = branch_link_inst_reg ?
                          5'b00001 // ra register 
                        : decd_dst_reg[4:0];

assign is_fp_inst_fcmpx    = (x_inst[31:20] == 12'b000011000001) ||  // fcmp.s
                             (x_inst[31:20] == 12'b000011000010);    // fcmp.d

assign is_fp_inst_movxx2cf = (x_inst[31:10] == 22'b0000000100010100110100) || //movfr2cf
                             (x_inst[31:10] == 22'b0000000100010100110110);   //movgr2cf

assign x_dst_x0  = (is_fp_inst_fcmpx || is_fp_inst_movxx2cf) ? 
                     1'b0
                   : (x_dst_reg[4:0] == 5'd0);


//==========================================================
//            Decode Scalar FP Source Register Index
//==========================================================
//----------------------------------------------------------
//               Scalar FP Source 0 Register Index
//----------------------------------------------------------
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructio
//so add new instruction should carefully check these logic

assign x_srcf0_reg[4:0] = x_inst[9: 5];

//----------------------------------------------------------
//               Scalar FP Source 1 Register Index
//----------------------------------------------------------
assign decd_inst_srcf1_reg_32bit     = 1'b1;
assign decd_inst_srcf1_reg_32bit_low = (x_inst[1:0] == 2'b11)
                                       && (x_inst[6:0] == 7'b0001011);
assign decd_inst_srcf1_reg_16bit     = (x_inst[1:0] == 2'b10);
assign decd_inst_srcf1_reg_16bit_low = (x_inst[1:0] == 2'b00);

assign decd_inst_abs_neg_reg = (x_inst[31:10] == 22'b0000000100010100000001)     //fabs.s
                               || (x_inst[31:10] == 22'b0000000100010100000010)  //fabs.d
                               || (x_inst[31:10] == 22'b0000000100010100000101)  //fneg.s
                               || (x_inst[31:10] == 22'b0000000100010100000110); //fneg.d

assign x_srcf1_reg[4:0] =
                  {5{ decd_inst_abs_neg_reg}} & x_inst[9: 5] |
                  {5{!decd_inst_abs_neg_reg}} & x_inst[14: 10];

//----------------------------------------------------------
//               Scalar FP Source 2 Register Index
//----------------------------------------------------------
//perf_inst 

assign fp_st_inst = (x_inst[31:22] == 10'b0010101101) ||         //fst.s
                    (x_inst[31:22] == 10'b0010101111) ||         //fst.d
                    (x_inst[31:15] == 17'b00111000001110000) ||  //fstx.s
                    (x_inst[31:15] == 17'b00111000001111000) ||  //fstx.d
                    (x_inst[31:15] == 17'b00111000011101100) ||  //fstgt.s
                    (x_inst[31:15] == 17'b00111000011101101) ||  //fstgt.d
                    (x_inst[31:15] == 17'b00111000011101110) ||  //fstle.s
                    (x_inst[31:15] == 17'b00111000011101111);    //fstle.d

assign x_srcf2_reg[4:0] = fp_st_inst ? x_inst[4: 0] : x_inst[19: 15];
//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign decd_inst_dstf_reg_32bit     = 1'b1;
assign x_dstf_reg[4:0] =
                {5{decd_inst_dstf_reg_32bit}} & x_inst[4:0];

//==========================================================
//                 Illegal inst Decoder
//==========================================================
//32 bit decode instruction within inst[31:25],[14:12],[6:0]
//16 bit decode instruction within inst[15:10],[6:5],[1:0]
//decode illegal definition beyond main decoder scope here

//----------------------------------------------------------
//                Base Illegal Instruction
//----------------------------------------------------------
assign decd_i_illegal = (x_inst[31:28] == 6'b0111) ||
                        (x_inst[31] == 6'b1);

//----------------------------------------------------------
//                  C Illegal Instruction
//----------------------------------------------------------
assign decd_c_illegal = 1'b0;

//----------------------------------------------------------
//            FP load/store Illegal Instruction
//----------------------------------------------------------
//FP load/store illegal:
//when FS=0,execute RV64F/D inst will trigger illegal
assign decd_flsu_illegal = 1'b0;

assign decd_lsu_illegal = decd_flsu_illegal || decd_vlsu_illegal || 
                          (x_inst[31:21] == 11'b00111000010) ||
                          (x_inst[31:26] == 6'b001111) ||
                          (x_inst[31:26] == 6'b001011);


// &CombBeg; @369
// &CombEnd; @376
// &CombBeg; @378
// &CombEnd; @387
// &CombBeg; @392
// &CombEnd; @399
// &CombBeg; @401
// &CombEnd; @408
assign decd_vlsu_illegal = 1'b0;
assign vlsu_ld_srcv2_vld = 1'b0;

//----------------------------------------------------------
//                 FP Illegal Instruction
//----------------------------------------------------------
//FP extension illegal
//1. rounding mode == 3'b101 or rounding mode = 3'b110
//2. rounding mode == 3'b111 and fcsr[7:5] == 3'b101~3'b111
//3. FS==0,execute RV64F/D inst or read/write fcsr/fflags/frm/fxcr
//   read/write fcsr/... will decode in CP0
assign fp_static_rounding_illegal  = (x_inst[14:12] == 3'b101)
                                  || (x_inst[14:12] == 3'b110);

assign fp_dynamic_rounding_illegal = (x_inst[14:12] == 3'b111)
                                  && ((cp0_idu_frm[2:0] == 3'b101)
                                      ||(cp0_idu_frm[2:0] == 3'b110)
                                      ||(cp0_idu_frm[2:0] == 3'b111));

// if cp0_idu_fs[1:0] != 00, fpu turn on!
assign fp_fs_illegal = (cp0_idu_fs[1:0] == 2'b00); // on

assign decd_fp_illegal =  decd_fp_inst_illegal
                       // || fp_static_rounding_illegal
                       // || fp_dynamic_rounding_illegal
                       || fp_fs_illegal;



wire deret_illegal_mask;
assign deret_illegal_mask = (x_inst[31:0] == 32'b00000110010010000011100000000000); // eret


//----------------------------------------------------------
//               Illegal Instruction Result
//----------------------------------------------------------
//output all illegal
assign x_illegal = decd_32_illegal && decd_sel[0] & ~deret_illegal_mask
                || decd_16_illegal && decd_sel[1]
                || decd_i_illegal
                || decd_c_illegal
                || decd_lsu_illegal
                || decd_fp_illegal && decd_sel[2]
                || decd_cache_illegal && decd_sel[3]
                || decd_perf_illegal && decd_sel[4]
                || decd_vec_illegal && decd_sel[5];

//==========================================================
//          Full Decoder for valid and illegal inst
//==========================================================
//the destination and source valid signal and invalid
//instruction exception is hard to optimazied for timing,
//so here implement a full decoder for: type, dst_vld, dst_c_vld
//src0_vld, src1_vld, srcc_vld, dstf_vld, dste_vld, srcf0_vld,
//srcf1_vld, srcf2_vld, inv_expt
parameter TYPE_WIDTH            = 10;

parameter ALU                   = 10'b0000000001;
parameter BJU                   = 10'b0000000010;
parameter MULT                  = 10'b0000000100;
parameter DIV                   = 10'b0000001000;
parameter LSU_P5                = 10'b0000110000;
parameter LSU                   = 10'b0000010000;
parameter PIPE67                = 10'b0001000000;
parameter PIPE6                 = 10'b0010000000;
parameter PIPE7                 = 10'b0100000000;
parameter SPECIAL               = 10'b1000000000;

//----------------------------------------------------------
//                  Decoder Result Selection
//----------------------------------------------------------
//32 bits
assign decd_sel[0] = decd_length
                     && !decd_fp_sel
                     && !decd_sel[3]
                     && !decd_sel[4]
                     && !decd_sel[5];
//16 bits
assign decd_sel[1] = 1'b0;

//fp
assign decd_sel[2] = decd_fp_sel;

// cache
// current version, cache is implemented on LSU, we don't
// need special decode
assign decd_sel[3] = 1'b0;
                      // ((x_inst[31:22] == 10'b0000011000) || // cache
                      // (x_inst[31:10] == 32'b0000011001001000001000) || //tlbinv
                      // (x_inst[31:10] == 32'b0000011001001000001001) || //tlbflush
                      // (x_inst[31:10] == 32'b0000011001001000001010) || //tlbp
                      // (x_inst[31:10] == 32'b0000011001001000001011) || //tlbr
                      // (x_inst[31:10] == 32'b0000011001001000001100) || //tlbwi
                      // (x_inst[31:10] == 32'b0000011001001000001101) || //tlbwr
                      // )&& cp0_idu_cskyee;

//perf
assign decd_sel[4] = 1'b0 && cp0_idu_cskyee;

//vector
assign decd_sel[5] = 1'b0;

// &CombBeg; @546
always @( decd_32_srcv2_vld
       or decd_perf_src0_vld
       or decd_32_srcf0_vld
       or decd_vec_srcf2_vld
       or decd_cache_inst_type[9:0]
       or decd_vec_dstf_vld
       or decd_perf_srcf1_vld
       or decd_16_srcf2_vld
       or decd_vec_srcv2_vld
       or decd_32_dst_vld
       or decd_fp_inst_type[9:0]
       or decd_perf_dst_vld
       or decd_vec_inst_type[9:0]
       or decd_vec_src2_vld
       or decd_32_inst_type[9:0]
       or decd_fp_src1_vld
       or decd_perf_inst_type[9:0]
       or decd_vec_srcv0_vld
       or decd_32_src0_vld
       or decd_perf_src1_vld
       or decd_vec_src1_vld
       or decd_32_dstf_vld
       or decd_fp_srcf2_vld
       or decd_perf_src2_vld
       or decd_vec_dstv_vld
       or decd_vec_srcf0_vld
       or decd_vec_srcf1_vld
       or decd_fp_dst_vld
       or decd_32_dstv_vld
       or decd_16_inst_type[9:0]
       or decd_fp_dstf_vld
       or decd_fp_srcf0_vld
       or decd_perf_dstf_vld
       or decd_vec_dste_vld
       or decd_16_srcf1_vld
       or decd_vec_dst_vld
       or decd_vec_src0_vld
       or decd_32_dste_vld
       or decd_perf_srcf2_vld
       or decd_16_dst_vld
       or decd_vec_srcv1_vld
       or decd_16_dstf_vld
       or decd_fp_src0_vld
       or decd_fp_srcf1_vld
       or decd_fp_dste_vld
       or decd_32_src1_vld
       or decd_32_src2_vld
       or decd_32_srcf1_vld
       or decd_32_srcf2_vld
       or decd_sel[5:0]
       or decd_cache_src1_vld
       or decd_32_srcv0_vld
       or decd_16_src1_vld
       or decd_16_src0_vld)
begin
  case(decd_sel[5:0])
    6'h1: begin // 32-bit inst
      x_inst_type[TYPE_WIDTH-1:0] = decd_32_inst_type[TYPE_WIDTH-1:0];
      x_dst_vld                   = decd_32_dst_vld;
      x_dstf_vld                  = decd_32_dstf_vld;
      x_dstv_vld                  = decd_32_dstv_vld;
      x_dste_vld                  = decd_32_dste_vld;
      x_src0_vld                  = decd_32_src0_vld;
      x_src1_vld                  = decd_32_src1_vld;
      x_src2_vld                  = decd_32_src2_vld;
      x_srcf0_vld                 = decd_32_srcf0_vld;
      x_srcf1_vld                 = decd_32_srcf1_vld;
      x_srcf2_vld                 = decd_32_srcf2_vld;
      x_srcv0_vld                 = decd_32_srcv0_vld;
      x_srcv1_vld                 = 1'b0;
      x_srcv2_vld                 = decd_32_srcv2_vld;
    end
    6'h2: begin // 16-bit inst
      x_inst_type[TYPE_WIDTH-1:0] = decd_16_inst_type[TYPE_WIDTH-1:0];
      x_dst_vld                   = decd_16_dst_vld;
      x_dstf_vld                  = decd_16_dstf_vld;
      x_dstv_vld                  = 1'b0;
      x_dste_vld                  = 1'b0;
      x_src0_vld                  = decd_16_src0_vld;
      x_src1_vld                  = decd_16_src1_vld;
      x_src2_vld                  = 1'b0;
      x_srcf0_vld                 = 1'b0;
      x_srcf1_vld                 = decd_16_srcf1_vld;
      x_srcf2_vld                 = decd_16_srcf2_vld;
      x_srcv0_vld                 = 1'b0;
      x_srcv1_vld                 = 1'b0;
      x_srcv2_vld                 = 1'b0;
    end
    6'h4: begin // fp inst
      x_inst_type[TYPE_WIDTH-1:0] = decd_fp_inst_type[TYPE_WIDTH-1:0];
      x_dst_vld                   = decd_fp_dst_vld;
      x_dstf_vld                  = decd_fp_dstf_vld;
      x_dstv_vld                  = 1'b0;
      x_dste_vld                  = decd_fp_dste_vld;
      x_src0_vld                  = decd_fp_src0_vld;
      x_src1_vld                  = decd_fp_src1_vld;
      x_src2_vld                  = 1'b0;
      x_srcf0_vld                 = decd_fp_srcf0_vld;
      x_srcf1_vld                 = decd_fp_srcf1_vld;
      x_srcf2_vld                 = decd_fp_srcf2_vld;
      x_srcv0_vld                 = 1'b0;
      x_srcv1_vld                 = 1'b0;
      x_srcv2_vld                 = 1'b0;
    end
    6'h8: begin // cache inst
      x_inst_type[TYPE_WIDTH-1:0] = decd_cache_inst_type[TYPE_WIDTH-1:0];
      x_dst_vld                   = 1'b0;
      x_dstf_vld                  = 1'b0;
      x_dstv_vld                  = 1'b0;
      x_dste_vld                  = 1'b0;
      x_src0_vld                  = 1'b0;
      x_src1_vld                  = decd_cache_src1_vld;
      x_src2_vld                  = 1'b0;
      x_srcf0_vld                 = 1'b0;
      x_srcf1_vld                 = 1'b0;
      x_srcf2_vld                 = 1'b0;
      x_srcv0_vld                 = 1'b0;
      x_srcv1_vld                 = 1'b0;
      x_srcv2_vld                 = 1'b0;
    end
    6'h10: begin // perf inst
      x_inst_type[TYPE_WIDTH-1:0] = decd_perf_inst_type[TYPE_WIDTH-1:0];
      x_dst_vld                   = decd_perf_dst_vld;
      x_dstf_vld                  = decd_perf_dstf_vld;
      x_dstv_vld                  = 1'b0;
      x_dste_vld                  = 1'b0;
      x_src0_vld                  = decd_perf_src0_vld;
      x_src1_vld                  = decd_perf_src1_vld;
      x_src2_vld                  = decd_perf_src2_vld;
      x_srcf0_vld                 = 1'b0;
      x_srcf1_vld                 = decd_perf_srcf1_vld;
      x_srcf2_vld                 = decd_perf_srcf2_vld;
      x_srcv0_vld                 = 1'b0;
      x_srcv1_vld                 = 1'b0;
      x_srcv2_vld                 = 1'b0;
    end
    6'h20: begin // vector inst
      x_inst_type[TYPE_WIDTH-1:0] = decd_vec_inst_type[TYPE_WIDTH-1:0];
      x_dst_vld                   = decd_vec_dst_vld;
      x_dstf_vld                  = decd_vec_dstf_vld;
      x_dstv_vld                  = decd_vec_dstv_vld;
      x_dste_vld                  = decd_vec_dste_vld;
      x_src0_vld                  = decd_vec_src0_vld;
      x_src1_vld                  = decd_vec_src1_vld;
      x_src2_vld                  = decd_vec_src2_vld;
      x_srcf0_vld                 = decd_vec_srcf0_vld;
      x_srcf1_vld                 = decd_vec_srcf1_vld;
      x_srcf2_vld                 = decd_vec_srcf2_vld;
      x_srcv0_vld                 = decd_vec_srcv0_vld;
      x_srcv1_vld                 = decd_vec_srcv1_vld;
      x_srcv2_vld                 = decd_vec_srcv2_vld;
    end
    default: begin
      x_inst_type[TYPE_WIDTH-1:0] = {TYPE_WIDTH{1'b0}};
      x_dst_vld                   = 1'b0;
      x_dstf_vld                  = 1'b0;
      x_dstv_vld                  = 1'b0;
      x_dste_vld                  = 1'b0;
      x_src0_vld                  = 1'b0;
      x_src1_vld                  = 1'b0;
      x_src2_vld                  = 1'b0;
      x_srcf0_vld                 = 1'b0;
      x_srcf1_vld                 = 1'b0;
      x_srcf2_vld                 = 1'b0;
      x_srcv0_vld                 = 1'b0;
      x_srcv1_vld                 = 1'b0;
      x_srcv2_vld                 = 1'b0;
    end
  endcase
// &CombEnd; @661
end

//----------------------------------------------------------
//                   16 bits Full Decoder
//----------------------------------------------------------
// &CombBeg; @666
always @( x_inst[15:2]
       or x_inst[1:0])
begin
  //initialize decoded information value
  decd_16_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_16_dst_vld                      = 1'b0;
  decd_16_dstf_vld                     = 1'b0;
  decd_16_src0_vld                     = 1'b0;
  decd_16_src1_vld                     = 1'b0;
  decd_16_srcf1_vld                    = 1'b0;
  decd_16_srcf2_vld                    = 1'b0;
  //illegal instruction
  decd_16_illegal                      = 1'b0;
// &CombEnd; @864
end


//----------------------------------------------------------
//                   32 bits Full Decoder
//----------------------------------------------------------

// NOTING:
// 
// Inst rd, rs0, rs1
//      decd_32_src0_vld = rs0
//      decd_32_src1_vld = rs1
//
//      decd_32_src2_vld = rd
//      decd_32_dst_vld  = rd
// 
//      decd_32_srcf2_vld = fd
//      decd_32_dstf_vld  = fd
// 
//   Load: 
//       decd_32_src0_vld
//       decd_32_src1_vld (optional)
//       decd_32_dst_vld
// 
//   Store:
//       decd_32_src0_vld
//       decd_32_src1_vld
//       decd_32_src2_vld (optional)
// 

// &CombBeg; @870
always @( x_inst[14:10]
       or x_inst[31:15]
       or x_inst[9:8])
begin
  //initialize decoded information value
  decd_32_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_32_dst_vld                      = 1'b0;
  decd_32_dstf_vld                     = 1'b0;
  decd_32_dste_vld                     = 1'b0;
  decd_32_src0_vld                     = 1'b0;
  decd_32_src1_vld                     = 1'b0;
  decd_32_src2_vld                     = 1'b0;
  decd_32_srcf0_vld                    = 1'b0;
  decd_32_srcf1_vld                    = 1'b0;
  decd_32_srcf2_vld                    = 1'b0;
  decd_32_srcv0_vld                    = 1'b0;
  decd_32_srcv2_vld                    = 1'b0;
  decd_32_dstv_vld                     = 1'b0;
  //illegal instruction
  decd_32_illegal                      = 1'b0;

  casez({x_inst[31:15], x_inst[14:10]})
    //32-bits instructions decode logic
    22'b000000000000010??_????? :begin //alsl.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b000000000000011??_????? :begin //alsl.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b000000000010110??_????? :begin //alsl.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b000000000000100??_????? :begin //bytepick.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000011???_????? :begin //bytepick.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100000_????? :begin //add.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100001_????? :begin //add.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100010_????? :begin //sub.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100011_????? :begin //sub.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100100_????? :begin //slt
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100101_????? :begin //sltu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100110_????? :begin //maskeqz
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000100111_????? :begin //masknez
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101000_????? :begin //nor
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101001_????? :begin //and
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101010_????? :begin //or
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101011_????? :begin //xor
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101100_????? :begin //orn
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101101_????? :begin //andn
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101110_????? :begin //sll.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000101111_????? :begin //srl.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000110000_????? :begin //sra.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000110001_????? :begin //sll.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000110010_????? :begin //srl.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000110011_????? :begin //sra.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000110110_????? :begin //rotr.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000110111_????? :begin //rotr.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // crc
    22'b00000000001001000_????? :begin //crc.w.b.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001001_????? :begin //crc.w.h.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001010_????? :begin //crc.w.w.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001011_????? :begin //crc.w.d.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001100_????? :begin //crcc.w.b.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001101_????? :begin //crcc.w.h.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001110_????? :begin //crcc.w.w.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001001111_????? :begin //crcc.w.d.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // mult
    22'b00000000000111000_????? :begin //mul.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111001_????? :begin //mulh.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111010_????? :begin //mulh.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111011_????? :begin //mul.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111100_????? :begin //mulh.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111101_????? :begin //mulh.du
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111110_????? :begin //mulw.d.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000111111_????? :begin //mulw.d.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = MULT;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000000_????? :begin //div.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000001_????? :begin //mod.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000010_????? :begin //div.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000011_????? :begin //mod.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000100_????? :begin //div.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000101_????? :begin //mod.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000110_????? :begin //div.du
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000001000111_????? :begin //mod.du
      decd_32_inst_type[TYPE_WIDTH-1:0]    = DIV;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000010_????? :begin //asrtle.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b00000000000000011_????? :begin //asrtgt.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b00000000000000000_00100 :begin //clo.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_00101 :begin //clz.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_00110 :begin //cto.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_00111 :begin //ctz.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01000 :begin //clo.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01001 :begin //clz.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01010 :begin //cto.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01011 :begin //ctz.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01100 :begin //revb.2h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01101 :begin //revb.4h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01110 :begin //revb.2w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_01111 :begin //revb.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10000 :begin //revh.2w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10001 :begin //revh.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10010 :begin //bitrev.4b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10011 :begin //bitrev.8b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10100 :begin //bitrev.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10101 :begin //bitrev.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10110 :begin //ext.w.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_10111 :begin //ext.w.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_11000 :begin //rdtimel.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_11001 :begin //rdtimeh.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000000000000_11010 :begin //rdtime.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000010000001_????? :begin //slli.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000000001000001?_????? :begin //slli.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000010001001_????? :begin //srli.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000000001000101?_????? :begin //srli.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000010010001_????? :begin //srai.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000000001001001?_????? :begin //srai.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000010011001_????? :begin //rotri.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000000001001101?_????? :begin //rotri.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // rd is as src0
    22'b00000000011_?????0_????? :begin //bstrins.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00000000011_?????1_????? :begin //bstrpick.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // rd is as src0
    22'b0000000010?_??????_????? :begin //bstrins.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000000011?_??????_????? :begin //bstrpick.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // 12-offset
    22'b0000001000_???????_????? :begin //slti
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001001_???????_????? :begin //sltui
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001010_???????_????? :begin //addi.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001011_???????_????? :begin //addi.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001100_???????_????? :begin //lu52i.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001101_???????_????? :begin //andi
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001110_???????_????? :begin //ori
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0000001111_???????_????? :begin //xori
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b000100_????_???????_????? :begin //addu16i.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0001010_???_???????_????? :begin //lu12i.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0001011_???_???????_????? :begin //lu32i.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = ALU;
      decd_32_src2_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // amo
    22'b00111000011000000_????? :begin //amswap.w
      end
    22'b00111000011000001_????? :begin //amswap.d
      end
    22'b00111000011000010_????? :begin //amadd.w
      end
    22'b00111000011000011_????? :begin //amadd.d
      end
    22'b00111000011000100_????? :begin //amand.w
      end
    22'b00111000011000101_????? :begin //amand.d
      end
    22'b00111000011000110_????? :begin //amor.w
      end
    22'b00111000011000111_????? :begin //amor.d
      end
    22'b00111000011001000_????? :begin //amxor.w
      end
    22'b00111000011001001_????? :begin //amxor.d
      end
    22'b00111000011001010_????? :begin //ammax.w
      end
    22'b00111000011001011_????? :begin //ammax.d
      end
    22'b00111000011001100_????? :begin //ammin.w
      end
    22'b00111000011001101_????? :begin //ammin.d
      end
    22'b00111000011001110_????? :begin //ammax.wu
      end
    22'b00111000011001111_????? :begin //ammax.du
      end
    22'b00111000011010000_????? :begin //ammin.wu
      end
    22'b00111000011010001_????? :begin //ammin.du
      end

    // amo db
    22'b00111000011010010_????? :begin //amswap_db.w
      end
    22'b00111000011010011_????? :begin //amswap_db.d
      end
    22'b00111000011010100_????? :begin //amadd_db.w
      end
    22'b00111000011010101_????? :begin //amadd_db.d
      end
    22'b00111000011010110_????? :begin //amand_db.w
      end
    22'b00111000011010111_????? :begin //amand_db.d
      end
    22'b00111000011011000_????? :begin //amor_db.w
      end
    22'b00111000011011001_????? :begin //amor_db.d
      end
    22'b00111000011011010_????? :begin //amxor_db.w
      end
    22'b00111000011011011_????? :begin //amxor_db.d
      end
    22'b00111000011011100_????? :begin //ammax_db.w
      end
    22'b00111000011011101_????? :begin //ammax_db.d
      end
    22'b00111000011011110_????? :begin //ammin_db.w
      end
    22'b00111000011011111_????? :begin //ammin_db.d
      end
    22'b00111000011100000_????? :begin //ammax_db.wu
      end
    22'b00111000011100001_????? :begin //ammax_db.du
      end
    22'b00111000011100010_????? :begin //ammin_db.wu
      end
    22'b00111000011100011_????? :begin //ammin_db.du
      end


    22'b00100000_?????????_????? :begin //ll.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00100010_?????????_????? :begin //ll.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end

    22'b00100001_?????????_????? :begin //sc.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00100011_?????????_????? :begin //sc.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    // load / store
    22'b00100100?????????_????? :begin //ldptr.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00100101?????????_????? :begin //stptr.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b00100110?????????_????? :begin //ldptr.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00100111?????????_????? :begin //stptr.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b0010100000???????_????? :begin //ld.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010100001???????_????? :begin //ld.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010100010???????_????? :begin //ld.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010100011???????_????? :begin //ld.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010100100???????_????? :begin //st.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b0010100101???????_????? :begin //st.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b0010100110???????_????? :begin //st.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b0010100111???????_????? :begin //st.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b0010101000???????_????? :begin //ld.bu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010101001???????_????? :begin //ld.hu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010101010???????_????? :begin //ld.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0010101011???????_????? :begin //preld
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      end
    22'b0010101100???????_????? :begin //fld.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b0010101101???????_????? :begin //fst.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b0010101110???????_????? :begin //fld.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b0010101111???????_????? :begin //fst.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000001100000_?????: begin //fldx.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b00111000001101000_?????: begin //fldx.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b00111000001110000_?????: begin //fstx.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000001111000_?????: begin //fstx.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000011101000_?????: begin //fldgt.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b00111000011101001_?????: begin //fldgt.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b00111000011101010_?????: begin //fldle.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b00111000011101011_?????: begin //fldle.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dstf_vld                     = 1'b1;
      end
    22'b00111000011101100_?????: begin //fstgt.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000011101101_?????: begin //fstgt.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000011101110_?????: begin //fstle.s
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000011101111_?????: begin //fstle.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_srcf2_vld                    = 1'b1;
      end
    22'b00111000000000000_????? :begin //ldx.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000000001000_????? :begin //ldx.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000000010000_????? :begin //ldx.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000000011000_????? :begin //ldx.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000000100000_????? :begin //stx.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000000101000_????? :begin //stx.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000000110000_????? :begin //stx.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000000111000_????? :begin //stx.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000001000000_????? :begin //ldx.bu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000001001000_????? :begin //ldx.hu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000001010000_????? :begin //ldx.wu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000001011000_????? :begin //preldx
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011110000_????? :begin //ldgt.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011110001_????? :begin //ldgt.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011110010_????? :begin //ldgt.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011110011_????? :begin //ldgt.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
    end
    22'b00111000011110100_????? :begin //ldle.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011110101_????? :begin //ldle.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
    end
    22'b00111000011110110_????? :begin //ldle.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011110111_????? :begin //ldle.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b00111000011111000_????? :begin //stgt.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111001_????? :begin //stgt.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111010_????? :begin //stgt.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111011_????? :begin //stgt.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111100_????? :begin //stle.b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111101_????? :begin //stle.h
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111110_????? :begin //stle.w
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00111000011111111_????? :begin //stle.d
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      decd_32_src2_vld                     = 1'b1;
      end
    22'b00000000001010100_????? :begin //break
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      end
    22'b00000000001010101_????? :begin //decl
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      end
    22'b00000000001010110_????? :begin //syscall
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      end
    22'b0001100_??????????????? :begin //pcaddi
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0001101_??????????????? :begin //pcalau12i
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0001110_??????????????? :begin //pcaddu12i
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_dst_vld                      = 1'b1;
      end
    22'b0001111_??????????????? :begin //pcaddu18i
      decd_32_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
      decd_32_dst_vld                      = 1'b1;
      end
    // Branch 
    22'b010110_???????????????? :begin //beq
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b010111_???????????????? :begin //bne
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b011000_???????????????? :begin //blt
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b011001_???????????????? :begin //bge
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b011010_???????????????? :begin //bltu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b011011_???????????????? :begin //bgeu
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      decd_32_src1_vld                     = 1'b1;
      end
    22'b010100_???????????????? :begin //b
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      end

    // dst_vld will alloc preg if inst split, but not be released
    // will enter into decdlock!
    22'b010011_???????????????? :begin //jirl (dst_vld deal in split)
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      end
    22'b010101_???????????????? :begin //bl (dst_vld deal in split)
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      end

    22'b010000_???????????????? :begin //beqz
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      end
    22'b010001_???????????????? :begin //bnez
      decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
      decd_32_src0_vld                     = 1'b1;
      end
    22'b010010_???????????????? :begin //bceqz/bcnez
      // (x_inst[9:8] == 2'b00) bceqz
      // (x_inst[9:8] == 2'b01) bcnez
      if ((!x_inst[9])) begin 
        decd_32_inst_type[TYPE_WIDTH-1:0]    = BJU;
        decd_32_src0_vld                     = 1'b1;
      end else begin
        decd_32_illegal                      = 1'b1;
      end
      end
    22'b00111000011100100_????? :begin //dbar
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      end
    22'b00111000011100101_????? :begin //ibar
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      end

    22'b00000110010010001_????? :begin  // wait/idle
      //deal in fence
      end

    22'b00000110010010000_01110 :begin  // ertn
      //deal in fence
      end

    22'b00000100_?????????_????? :begin // csrrd, csrwr, csrxchg
      //deal in fence
      end

    22'b00000000000000000_11011 :begin //cpucfg
      //deal in fence
      end  

    22'b00000110010010011_????? :begin  // invtlb
      /// we handle instruction in ir_decd.v
      /// deal in fence
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      end
    22'b0000011000???????_????? :begin  // cacop (cache)
      /// we handle instruction in ir_decd.v
      /// deal in fence
      decd_32_inst_type[TYPE_WIDTH-1:0]    = LSU_P5;
      end

    /// checkpoint restore pc inst
    22'b00000110010010010_????? :begin  // cprs (decode between idle and invtlb)
      //deal in fence
      end


    // TODO: IOCSR
    22'b00000110010010000_00000 :begin  // iocsrrd.b
      //deal in fence
      end
    22'b00000110010010000_00001 :begin  // iocsrrd.h
      //deal in fence
      end
    22'b00000110010010000_00010 :begin  // iocsrrd.w
      //deal in fence
      end
    22'b00000110010010000_00011 :begin  // iocsrrd.d
      //deal in fence
      end

    22'b00000110010010000_00100 :begin  // iocsrwr.b
      //deal in fence
      end
    22'b00000110010010000_00101 :begin  // iocsrwr.h
      //deal in fence
      end
    22'b00000110010010000_00110 :begin  // iocsrwr.w
      //deal in fence
      end
    22'b00000110010010000_00111 :begin  // iocsrwr.d
      //deal in fence
      end

    /// tlb operation
    22'b00000110010010000_01000 :begin  // tlbclr
      //deal in fence
      end
    22'b00000110010010000_01001 :begin  // tlbflush
      //deal in fence
      end
    22'b00000110010010000_01010 :begin  // tlbsrch
      //deal in fence
      end
    22'b00000110010010000_01011 :begin  // tlbrd
      //deal in fence
      end
    22'b00000110010010000_01100 :begin  // tlbwr
      //deal in fence
      end
    22'b00000110010010000_01101 :begin  // tlbfill
      //deal in fence
      end

    default:begin                //invalid instruction
      //deal in fence
      decd_32_illegal                      = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @1504
end


//----------------------------------------------------------
//       FP part0 Full Decoder(except fused multiply add)
//----------------------------------------------------------
// &CombBeg; @1526
always @( x_inst[31:15]
       or x_inst[14:10])
begin
  //initialize decoded information value
  decd_fp0_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_fp0_dst_vld                      = 1'b0;
  decd_fp0_dstf_vld                     = 1'b0;
  decd_fp0_dste_vld                     = 1'b0;
  decd_fp0_src0_vld                     = 1'b0;
  decd_fp0_srcf0_vld                    = 1'b0;
  decd_fp0_srcf1_vld                    = 1'b0;
  //illegal instruction
  decd_fp0_illegal                      = 1'b0;

  casez({x_inst[31:15], x_inst[14:10]})
  22'b0000000100010100100101: begin  // fmov.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100100110: begin  // fmov.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100101001: begin  // movgr2fr.w
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = ALU;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
  end
  22'b0000000100010100101010: begin  // movgr2fr.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = ALU;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
  end

  22'b0000000100010100101101: begin  // movfr2gr.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dst_vld                      = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100101110: begin  // movfr2gr.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dst_vld                      = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100101011: begin  // movgr2frh.w
    // deal in split
  end
  22'b0000000100010100101111: begin  // movfrh2gr.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dst_vld                      = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100110100: begin //movfr2cf
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dst_vld                      = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100110101: begin //movcf2fr
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = ALU;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
    end
  22'b0000000100010100110110: begin //movgr2cf
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = ALU;
    decd_fp0_dst_vld                      = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
    end
  22'b0000000100010100110111: begin //movcf2gr
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = ALU;
    decd_fp0_dst_vld                      = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
    end
  22'b0000000100010100110000: begin  // movgr2fcsr
    //deal in fence
  end
  22'b0000000100010100110010: begin  // movfcsr2gr
    //deal in fence
  end
  22'b00000001000000001_?????: begin //fadd.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000000010_?????: begin //fadd.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000000101_?????: begin //fsub.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000000110_?????: begin //fsub.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001001_?????: begin //fmul.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001010_?????: begin //fmul.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001101_?????: begin //fdiv.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE6;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001110_?????: begin //fdiv.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE6;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010001_?????: begin //fmax.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010010_?????: begin //fmax.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010101_?????: begin //fmin.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010110_?????: begin //fmin.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000011001_?????: begin //fmaxa.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000011010_?????: begin //fmaxa.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000011101_?????: begin //fmina.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000011110_?????: begin //fmina.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100001_?????: begin //fscaleb.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100010_?????: begin //fscaleb.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100101_?????: begin //copysign.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100110_?????: begin //copysign.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000001: begin //fabs.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000010: begin //fabs.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000101: begin //fneg.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000110: begin //fneg.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100001001: begin //flogb.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100001010: begin //flogb.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100001101: begin //fclass.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100001110: begin //fclass.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010001: begin //fsqrt.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE6;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010010: begin //fsqrt.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE6;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010101: begin //frecip.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE6;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010110: begin //frecip.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE6;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100011001: begin //frsqrt.s
    // deal in split
    end
  22'b0000000100010100011010: begin //frsqrt.d
    // deal in split
    end

  // fp compare
  //------------------- single --------------------//
  // 22'b000011000001_00000_?????: begin // fcmp.caf.s
  //   end
  // 22'b000011000001_01000_?????: begin // fcmp.cun.s
  //   end
  // 22'b000011000001_00100_?????: begin // fcmp.ceq.s
  //   end
  // 22'b000011000001_01100_?????: begin // fcmp.cueq.s
  //   end
  // 22'b000011000001_00010_?????: begin // fcmp.clt.s
  //   end
  // 22'b000011000001_01010_?????: begin // fcmp.cult.s
  //   end
  // 22'b000011000001_00110_?????: begin // fcmp.cle.s
  //   end
  // 22'b000011000001_01110_?????: begin // fcmp.cule.s
  //   end
  // 22'b000011000001_10000_?????: begin // fcmp.cne.s
  //   end
  // 22'b000011000001_10100_?????: begin // fcmp.cor.s
  //   end
  // 22'b000011000001_11000_?????: begin // fcmp.cune.s
  //   end

  // 22'b000011000001_00001_?????: begin // fcmp.saf.s
  //   end
  // 22'b000011000001_01001_?????: begin // fcmp.sun.s
  //   end
  // 22'b000011000001_00101_?????: begin // fcmp.seq.s
  //   end
  // 22'b000011000001_01101_?????: begin // fcmp.sueq.s
  //   end
  // 22'b000011000001_00011_?????: begin // fcmp.slt.s
  //   end
  // 22'b000011000001_01011_?????: begin // fcmp.sult.s
  //   end
  // 22'b000011000001_00111_?????: begin // fcmp.sle.s
  //   end
  // 22'b000011000001_01111_?????: begin // fcmp.sule.s
  //   end
  // 22'b000011000001_10001_?????: begin // fcmp.sne.s
  //   end
  // 22'b000011000001_10101_?????: begin // fcmp.sor.s
  //   end
  // 22'b000011000001_11001_?????: begin // fcmp.sune.s
  //   end
  22'b000011000001_?????_?????: begin // fcmp.xxx.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dst_vld                      = 1'b1;
    if (x_inst[15]) begin
      decd_fp0_dste_vld                   = 1'b1;
    end
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end

  //------------------- double --------------------//
  // 22'b000011000010_00000_?????: begin // fcmp.caf.d
  //   end
  // 22'b000011000010_01000_?????: begin // fcmp.cun.d
  //   end
  // 22'b000011000010_00100_?????: begin // fcmp.ceq.d
  //   end
  // 22'b000011000010_01100_?????: begin // fcmp.cueq.d
  //   end
  // 22'b000011000010_00010_?????: begin // fcmp.clt.d
  //   end
  // 22'b000011000010_01010_?????: begin // fcmp.cult.d
  //   end
  // 22'b000011000010_00110_?????: begin // fcmp.cle.d
  //   end
  // 22'b000011000010_01110_?????: begin // fcmp.cule.d
  //   end
  // 22'b000011000010_10000_?????: begin // fcmp.cne.d
  //   end
  // 22'b000011000010_10100_?????: begin // fcmp.cor.d
  //   end
  // 22'b000011000010_11000_?????: begin // fcmp.cune.d
  //   end

  // 22'b000011000010_00001_?????: begin // fcmp.saf.d
  //   end
  // 22'b000011000010_01001_?????: begin // fcmp.sun.d
  //   end
  // 22'b000011000010_00101_?????: begin // fcmp.seq.d
  //   end
  // 22'b000011000010_01101_?????: begin // fcmp.sueq.d
  //   end
  // 22'b000011000010_00011_?????: begin // fcmp.slt.d
  //   end
  // 22'b000011000010_01011_?????: begin // fcmp.sult.d
  //   end
  // 22'b000011000010_00111_?????: begin // fcmp.sle.d
  //   end
  // 22'b000011000010_01111_?????: begin // fcmp.sule.d
  //   end
  // 22'b000011000010_10001_?????: begin // fcmp.sne.d
  //   end
  // 22'b000011000010_10101_?????: begin // fcmp.sor.d
  //   end
  // 22'b000011000010_11001_?????: begin // fcmp.sune.d
  //   end
  22'b000011000010_?????_?????: begin // fcmp.xxx.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
    decd_fp0_dst_vld                      = 1'b1;
    if (x_inst[15]) begin
      decd_fp0_dste_vld                   = 1'b1;
    end
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b000011010000_00???_?????: begin // fsel
    // deal in split
    end  
  22'b0000000100011010000001: begin // ftintrm.w.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010000010: begin // ftintrm.w.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010001001: begin // ftintrm.l.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010001010: begin // ftintrm.l.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end

  22'b0000000100011010010001: begin // ftintrp.w.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010010010: begin // ftintrp.w.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010011001: begin // ftintrp.l.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010011010: begin // ftintrp.l.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010100001: begin // ftintrz.w.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010100010: begin // ftintrz.w.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010101001: begin // ftintrz.l.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010101010: begin // ftintrz.l.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010110001: begin // ftintrne.w.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010110010: begin // ftintrne.w.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010111001: begin // ftintrne.l.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010111010: begin // ftintrne.l.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011001000110: begin // fcvt.s.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b0;
    end
  22'b0000000100011001001001: begin // fcvt.d.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b0;
    end
  22'b0000000100011101000100: begin // ffint.s.w
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011101000110: begin // ffint.s.l
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011101001000: begin // ffint.d.w
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011101001010: begin // ffint.d.l
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011000001: begin // ftint.w.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011000010: begin // ftint.w.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011001001: begin // ftint.l.s
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011001010: begin // ftint.l.d
    decd_fp0_inst_type[TYPE_WIDTH-1:0]    = PIPE7;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011110010001: begin // frint.s
    //deal in split
    end
  22'b0000000100011110010010: begin // frint.d
    //deal in split
    end

  default:             begin  //invalid instruction
    //deal in fence
    decd_fp0_illegal                      = 1'b1;  //invalid instruction exception
  end
  endcase
// &CombEnd; @1967
end


//----------------------------------------------------------
//       FP part1 Full Decoder(fused multiply add)
//----------------------------------------------------------
// &CombBeg; @1974
always @(x_inst[31:20])
begin
  //initialize decoded information value
  decd_fp1_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_fp1_dst_vld                      = 1'b0;
  decd_fp1_dstf_vld                     = 1'b0;
  decd_fp1_dste_vld                     = 1'b0;
  decd_fp1_src0_vld                     = 1'b0;
  decd_fp1_srcf0_vld                    = 1'b0;
  decd_fp1_srcf1_vld                    = 1'b0;
  decd_fp1_srcf2_vld                    = 1'b0;
  //illegal instruction
  decd_fp1_illegal                      = 1'b0;

  casez({x_inst[31:20]})
    12'b000010000001: begin //fmadd.s
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010000010: begin //fmadd.d
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010000101: begin //fmsub.s
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010000110: begin //fmsub.d
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001001: begin //fnmadd.s
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001010: begin //fnmadd.d
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001101: begin //fnmsub.s
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001110: begin //fnmsub.d
      decd_fp1_inst_type[TYPE_WIDTH-1:0]    = PIPE67;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    default:             begin  //invalid instruction
      //deal in fence
      decd_fp1_illegal                      = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @2090
end

assign decd_fp0_sel = !decd_fp1_sel;
assign decd_fp1_sel = x_inst[31:24] == 8'b00001000;

// &CombBeg; @2095
always @( decd_fp1_dst_vld
       or decd_fp1_dste_vld
       or decd_fp1_illegal
       or decd_fp1_sel
       or decd_fp1_srcf2_vld
       or decd_fp0_srcf1_vld
       or decd_fp0_inst_type[9:0]
       or decd_fp1_inst_type[9:0]
       or decd_fp0_src0_vld
       or decd_fp0_illegal
       or decd_fp0_dstf_vld
       or decd_fp0_sel
       or decd_fp1_dstf_vld
       or decd_fp0_dst_vld
       or decd_fp0_srcf0_vld
       or decd_fp1_srcf1_vld
       or decd_fp1_src0_vld
       or decd_fp1_srcf0_vld
       or decd_fp0_dste_vld)
begin
  case({decd_fp1_sel,decd_fp0_sel})
    2'h1: begin
      decd_fp_inst_type[TYPE_WIDTH-1:0] = decd_fp0_inst_type[TYPE_WIDTH-1:0];
      decd_fp_dst_vld                   = decd_fp0_dst_vld;
      decd_fp_dstf_vld                  = decd_fp0_dstf_vld;
      decd_fp_dste_vld                  = decd_fp0_dste_vld;
      decd_fp_src0_vld                  = decd_fp0_src0_vld;
      decd_fp_src1_vld                  = 1'b0;
      decd_fp_srcf0_vld                 = decd_fp0_srcf0_vld;
      decd_fp_srcf1_vld                 = decd_fp0_srcf1_vld;
      decd_fp_srcf2_vld                 = 1'b0;
      decd_fp_inst_illegal              = decd_fp0_illegal;
    end
    2'h2: begin
      decd_fp_inst_type[TYPE_WIDTH-1:0] = decd_fp1_inst_type[TYPE_WIDTH-1:0];
      decd_fp_dst_vld                   = decd_fp1_dst_vld;
      decd_fp_dstf_vld                  = decd_fp1_dstf_vld;
      decd_fp_dste_vld                  = decd_fp1_dste_vld;
      decd_fp_src0_vld                  = decd_fp1_src0_vld;
      decd_fp_src1_vld                  = 1'b0;
      decd_fp_srcf0_vld                 = decd_fp1_srcf0_vld;
      decd_fp_srcf1_vld                 = decd_fp1_srcf1_vld;
      decd_fp_srcf2_vld                 = decd_fp1_srcf2_vld;
      decd_fp_inst_illegal              = decd_fp1_illegal;
    end
    default: begin
      decd_fp_inst_type[TYPE_WIDTH-1:0] = {TYPE_WIDTH{1'b0}};
      decd_fp_dst_vld                   = 1'b0;
      decd_fp_dstf_vld                  = 1'b0;
      decd_fp_dste_vld                  = 1'b0;
      decd_fp_src0_vld                  = 1'b0;
      decd_fp_src1_vld                  = 1'b0;
      decd_fp_srcf0_vld                 = 1'b0;
      decd_fp_srcf1_vld                 = 1'b0;
      decd_fp_srcf2_vld                 = 1'b0;
      decd_fp_inst_illegal              = 1'b0;
    end
  endcase
// &CombEnd; @2134
end

//----------------------------------------------------------
//              Cache Extension Full Decoder
//----------------------------------------------------------
// &CombBeg; @2139
always @( x_inst[25:15])
begin
  //initialize decoded information value
  decd_cache_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  decd_cache_src1_vld                     = 1'b0;
  decd_cache_illegal                      = 1'b0;

  casez({x_inst[31:20], x_inst[19:10]})
    //32-bits instructions decode logic
    22'b0000011000??_??????????: begin //dcache.iall
      decd_cache_inst_type[TYPE_WIDTH-1:0]    = LSU;
      decd_cache_src1_vld                     = 1'b1;
      end
    default: begin                //invalid instruction
      //deal in fence
      decd_cache_illegal                      = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @2242
end

//----------------------------------------------------------
//           Performance Extension Full Decoder
//----------------------------------------------------------
// &CombBeg; @2247
always @( x_inst[14:12]
       or x_inst[31:25])
begin
  //initialize decoded information value
  decd_perf_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_perf_src0_vld                     = 1'b0;
  decd_perf_src1_vld                     = 1'b0;
  decd_perf_src2_vld                     = 1'b0;
  decd_perf_dst_vld                      = 1'b0;
  decd_perf_srcf1_vld                    = 1'b0;
  decd_perf_srcf2_vld                    = 1'b0;
  decd_perf_dstf_vld                     = 1'b0;
  //illegal instruction
  decd_perf_illegal                      = 1'b0;

  // TODO:

// &CombEnd; @2642
end


//==========================================================
//                 Vector inst info
//==========================================================

//----------------------------------------------------------
//               ALL type of VECTOR illegal instructions
//----------------------------------------------------------
assign decd_v_illegal = 1'b0;

//----------------------------------------------------------
//                  Vector Full Decoder
//----------------------------------------------------------
// &CombBeg; @2957
always @( x_inst[19:12]
       or x_inst[31:15]
       or x_vfunary0_vld
       or x_vmunary0_vld)
begin
  //initialize decoded information value
  decd_v_inst_type[TYPE_WIDTH-1:0]    = {TYPE_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_v_src0_vld                     = 1'b0;
  decd_v_src1_vld                     = 1'b0;
  decd_v_src2_vld                     = 1'b0;
  decd_v_dst_vld                      = 1'b0;
  decd_v_srcf0_vld                    = 1'b0;
  decd_v_srcf1_vld                    = 1'b0;
  decd_v_srcf2_vld                    = 1'b0;
  decd_v_dstf_vld                     = 1'b0;
  decd_v_dste_vld                     = 1'b0;
  decd_v_srcv0_vld                    = 1'b0;
  decd_v_srcv1_vld                    = 1'b0;
  decd_v_srcv2_vld                    = 1'b0;
  decd_v_dstv_vld                     = 1'b0;
  //illegal instruction
  decd_code_illegal                   = 1'b0;
  
  // TODO:

// &CombEnd; @4239
end


//when vl is 0, signal dp to mask decoded inst into nop
assign decd_vec_nop = (x_vl[7:0]==8'b0) && !x_vec_opcfg && !vec_mfvr_inst;

// &CombBeg; @4245
always @( decd_v_dst_vld
       or decd_v_illegal
       or decd_vec_nop
       or decd_v_inst_type[9:0]
       or decd_v_srcf2_vld
       or decd_v_dstf_vld
       or decd_v_srcv0_vld
       or decd_v_src2_vld
       or decd_v_src1_vld
       or decd_v_src0_vld
       or decd_v_srcf0_vld
       or decd_v_dstv_vld
       or decd_v_srcv1_vld
       or decd_v_dste_vld
       or decd_v_srcf1_vld
       or decd_v_srcv2_vld)
begin
  if(decd_vec_nop) begin
    //initialize decoded information value
    decd_vec_inst_type[TYPE_WIDTH-1:0]    = SPECIAL;
    //operand prepare information: valid, and types
    decd_vec_src0_vld                     = 1'b0; 
    decd_vec_src1_vld                     = 1'b0; 
    decd_vec_src2_vld                     = 1'b0; 
    decd_vec_dst_vld                      = 1'b0; 
    decd_vec_srcf0_vld                    = 1'b0;  
    decd_vec_srcf1_vld                    = 1'b0;  
    decd_vec_srcf2_vld                    = 1'b0;  
    decd_vec_dstf_vld                     = 1'b0; 
    decd_vec_dste_vld                     = 1'b0; 
    decd_vec_srcv0_vld                    = 1'b0;  
    decd_vec_srcv1_vld                    = 1'b0;  
    decd_vec_srcv2_vld                    = 1'b0;  
    decd_vec_dstv_vld                     = 1'b0; 
    //illegal instruction
    decd_vec_illegal                      = decd_v_illegal;
  end
  else begin
    decd_vec_inst_type[TYPE_WIDTH-1:0]    = decd_v_inst_type[TYPE_WIDTH-1:0];
    //operand prepare information: valid, and types
    decd_vec_src0_vld                     = decd_v_src0_vld;
    decd_vec_src1_vld                     = decd_v_src1_vld;
    decd_vec_src2_vld                     = decd_v_src2_vld;
    decd_vec_dst_vld                      = decd_v_dst_vld;
    decd_vec_srcf0_vld                    = decd_v_srcf0_vld;
    decd_vec_srcf1_vld                    = decd_v_srcf1_vld;
    decd_vec_srcf2_vld                    = decd_v_srcf2_vld;
    decd_vec_dstf_vld                     = decd_v_dstf_vld;
    decd_vec_dste_vld                     = decd_v_dste_vld;
    decd_vec_srcv0_vld                    = decd_v_srcv0_vld;
    decd_vec_srcv1_vld                    = decd_v_srcv1_vld;
    decd_vec_srcv2_vld                    = decd_v_srcv2_vld;
    decd_vec_dstv_vld                     = decd_v_dstv_vld;
    //illegal instruction
    decd_vec_illegal                      = decd_v_illegal;
  end
// &CombEnd; @4285
end


// &ModuleEnd; @4288
endmodule


