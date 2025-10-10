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

// &Depend("cpu_cfig.h"); @27
// &Depend("aq_idu_cfig.h"); @28
// &ModuleBeg; @29
module aq_idu_id_decd (
  // &Ports, @30
  input    wire           cp0_idu_cskyee,
  input    wire  [2  :0]  cp0_idu_frm,
  input    wire  [1  :0]  cp0_idu_fs,
  input    wire           cp0_idu_ucme,
  input    wire           cp0_idu_vill,
  input    wire           cp0_idu_vl_zero,
  input    wire  [1  :0]  cp0_idu_vs,
  input    wire  [6  :0]  cp0_idu_vstart,
  input    wire  [1  :0]  cp0_yy_priv_mode,
  input    wire  [31 :0]  dp_decd_inst,
  input    wire  [1  :0]  dp_decd_vlmul,
  input    wire  [1  :0]  dp_decd_vsew,
  input    wire           rtu_yy_xx_dbgon,
  output   reg   [273:0]  decd_dp_inst_data
); 



// &Regs; @31
reg              decd_16_dst0_vld;               
reg              decd_16_dstf_vld;               
reg     [9  :0]  decd_16_eu;                     
reg     [19 :0]  decd_16_func;                   
reg              decd_16_illegal;                
reg              decd_16_src0_vld;               
reg              decd_16_src1_imm_vld;           
reg              decd_16_src1_vld;               
reg              decd_16_src2_imm_vld;           
reg              decd_16_src2_vld;               
reg              decd_16_srcf1_vld;              
reg              decd_16_srcf2_vld;              
reg              decd_32_dst0_vld;               
reg              decd_32_dste_vld;               
reg              decd_32_dstf_vld;               
reg              decd_32_dstv_vld;               
reg     [9  :0]  decd_32_eu;                     
reg     [19 :0]  decd_32_func;                   
reg              decd_32_illegal;                
reg              decd_32_src0_vld;               
reg              decd_32_src1_imm_vld;           
reg              decd_32_src1_vld;               
reg              decd_32_src2_imm_vld;           
reg              decd_32_src2_vld;               
reg              decd_32_srcc_vld;               
reg              decd_32_srcf0_vld;              
reg              decd_32_srcf1_vld;              
reg              decd_32_srcf2_vld;              
reg              decd_32_srcv0_vld;              
reg              decd_32_srcv1_vld;              
reg              decd_32_srcv2_vld;              
reg     [9  :0]  decd_cache_eu;                  
reg     [19 :0]  decd_cache_func;                
reg              decd_cache_illegal;             
reg              decd_cache_src0_vld;            
reg              decd_code_illegal;              
reg              decd_fp0_dst0_vld;              
reg              decd_fp0_dstc_vld;              
reg              decd_fp0_dste_vld;              
reg              decd_fp0_dstf_vld;              
reg     [9  :0]  decd_fp0_eu;                    
reg     [19 :0]  decd_fp0_func;                  
reg              decd_fp0_illegal;               
reg              decd_fp0_src0_vld;              
reg              decd_fp0_src1_vld;              
reg              decd_fp0_srcf0_vld;             
reg              decd_fp0_srcf1_vld;             
reg              decd_fp1_dst0_vld;              
reg              decd_fp1_dstc_vld;              
reg              decd_fp1_dste_vld;              
reg              decd_fp1_dstf_vld;              
reg     [9  :0]  decd_fp1_eu;                    
reg     [19 :0]  decd_fp1_func;                  
reg              decd_fp1_illegal;               
reg              decd_fp1_src0_vld;              
reg              decd_fp1_srcf0_vld;             
reg              decd_fp1_srcf1_vld;             
reg              decd_fp1_srcf2_vld;             
reg              decd_fp_dst0_vld;               
reg              decd_fp_dstc_vld;               
reg              decd_fp_dste_vld;               
reg              decd_fp_dstf_vld;               
reg     [9  :0]  decd_fp_eu;                     
reg     [19 :0]  decd_fp_func;                   
reg              decd_fp_inst_illegal;           
reg              decd_fp_src0_vld;               
reg              decd_fp_src1_vld;               
reg              decd_fp_srcf0_vld;              
reg              decd_fp_srcf1_vld;              
reg              decd_fp_srcf2_vld;    
reg              decd_fp0_srcc_vld;          
reg              decd_perf_dst0_vld;             
reg              decd_perf_dst1_vld;             
reg              decd_perf_dstf_vld;             
reg     [9  :0]  decd_perf_eu;                   
reg     [19 :0]  decd_perf_func;                 
reg              decd_perf_illegal;              
reg              decd_perf_src0_vld;             
reg              decd_perf_src1_imm_vld;         
reg              decd_perf_src1_vld;             
reg              decd_perf_src2_imm_vld;         
reg              decd_perf_src2_vld;             
reg              decd_perf_srcf1_vld;            
reg              decd_perf_srcf2_vld;            
reg              decd_v_dst0_vld;                
reg              decd_v_dste_vld;                
reg              decd_v_dstf_vld;                
reg              decd_v_dstv_late_vld;           
reg              decd_v_dstv_vld;                
reg     [9  :0]  decd_v_eu;                      
reg     [19 :0]  decd_v_func;                    
reg              decd_v_src0_vld;                
reg              decd_v_src1_vld;                
reg              decd_v_src2_vld;                
reg              decd_v_srcf0_vld;               
reg              decd_v_srcf1_vld;               
reg              decd_v_srcf2_vld;               
reg              decd_v_srcv0_vld;               
reg              decd_v_srcv1_vld;               
reg              decd_v_srcv2_vld;               
reg              decd_vec_dst0_vld;              
reg              decd_vec_dste_vld;              
reg              decd_vec_dstf_vld;              
reg              decd_vec_dstv_late_vld;         
reg              decd_vec_dstv_vld;              
reg     [9  :0]  decd_vec_eu;                    
reg     [19 :0]  decd_vec_func;                  
reg              decd_vec_illegal;               
reg              decd_vec_src0_vld;              
reg              decd_vec_src1_vld;              
reg              decd_vec_src2_vld;              
reg              decd_vec_srcf0_vld;             
reg              decd_vec_srcf1_vld;             
reg              decd_vec_srcf2_vld;             
reg              decd_vec_srcv0_vld;             
reg              decd_vec_srcv1_vld;             
reg              decd_vec_srcv2_vld;             
reg              x_decd_dstc_vld;                
reg              x_decd_dst0_vld;                
reg              x_decd_dst1_vld;                
reg              x_decd_dste_vld;                
reg              x_decd_dstf_vld;                
reg              x_decd_dstv_late_vld;           
reg              x_decd_dstv_vld;                
reg     [9  :0]  x_decd_eu;                      
reg     [19 :0]  x_decd_func;                    
reg              x_decd_src0_vld;                
reg     [63 :0]  x_decd_src1_imm;                
reg              x_decd_src1_imm_vld;            
reg              x_decd_src1_vld;                
reg     [63 :0]  x_decd_src2_imm;                
reg              x_decd_src2_imm_vld;            
reg              x_decd_src2_vld;                
reg              x_decd_srcc_vld;                
reg              x_decd_srcf0_vld;               
reg              x_decd_srcf1_vld;               
reg     [4  :0]  x_decd_srcf2_reg;               
reg              x_decd_srcf2_vld;               
reg     [4  :0]  x_decd_srcv0_reg;               
reg              x_decd_srcv0_vld;               
reg     [4  :0]  x_decd_srcv1_reg;               
reg              x_decd_srcv1_vld;               
reg     [4  :0]  x_decd_srcv2_reg;               
reg              x_decd_srcv2_vld;               

// &Wires; @32
wire             decd_c_illegal;                 
wire    [9  :0]  decd_caddi4spn_src1_imm;        
wire    [9  :0]  decd_caddisp_src1_imm;          
wire             decd_debug_illegal;             
wire    [4  :0]  decd_dst0_reg;                  
wire    [4  :0]  decd_dst1_reg;                  
wire             decd_flsu_illegal;              
wire             decd_fp0_sel;                   
wire             decd_fp1_sel;                   
wire             decd_fp_illegal;                
wire             decd_fp_rounding_illegal;       
wire             decd_fp_sel;                    
wire             decd_fs_illegal;                
wire             decd_i_illegal;                 
wire             decd_inst_cls;                  
wire             decd_inst_cls_sp;               
wire             decd_inst_dst0_reg_16bit_3_high; 
wire             decd_inst_dst0_reg_16bit_3_low; 
wire             decd_inst_dst0_reg_16bit_5;     
wire             decd_inst_dst0_reg_16bit_x1;    
wire             decd_inst_dst0_reg_32bit;       
wire             decd_inst_dstf_reg_16bit;       
wire             decd_inst_dstf_reg_16bit_high;  
wire             decd_inst_dstf_reg_16bit_low;   
wire             decd_inst_dstf_reg_32bit;       
wire             decd_inst_dstf_reg_32bit_low;   
wire             decd_inst_fcvtfx;               
wire             decd_inst_fls;                  
wire             decd_inst_fmv;                  
wire             decd_inst_branch_link;
wire             decd_inst_src0_reg_16bit_3;     
wire             decd_inst_src0_reg_16bit_5;     
wire             decd_inst_src0_reg_32bit;       
wire             decd_inst_src0_reg_cmv;         
wire             decd_inst_src0_reg_r2;          
wire             decd_inst_src1_reg_16bit_3;     
wire             decd_inst_src1_reg_16bit_5;     
wire             decd_inst_src1_reg_32bit;       
wire             decd_inst_src2_reg_16bit_3;     
wire             decd_inst_src2_reg_16bit_5;     
wire             decd_inst_src2_reg_32bit_11_7;  
wire             decd_inst_src2_reg_32bit_24_20; 
wire             decd_inst_srcf1_reg_16bit;      
wire             decd_inst_srcf1_reg_16bit_low;  
wire             decd_inst_srcf1_reg_32bit;      
wire             decd_inst_srcf1_reg_32bit_low;  
wire             decd_inst_vec;                  
wire             decd_inst_vls;                  
wire             decd_length;                    
wire    [1  :0]  decd_lsr_src3_imm;              
wire             decd_lsr_src3_imm_vld;          
wire             decd_lsu_illegal;               
wire    [8  :0]  decd_ovlp_ill;                  
wire             decd_ovlp_illegal;              
wire    [2  :0]  decd_ovlp_illegal_type;         
wire    [5  :0]  decd_sel;                       
wire    [3  :0]  decd_size_ill_case;             
wire             decd_size_illegal;              
wire    [4  :0]  decd_src0_reg;                  
wire             decd_src1_imm_c_branch_mask;    
wire    [13 :0]  decd_src1_imm_sel;              
wire    [4  :0]  decd_src1_reg;                  
wire             decd_src2_16bit_mask;           
wire    [10 :0]  decd_src2_imm_sel;              
wire    [63 :0]  decd_src2_inst16_c_j_imm;       
wire    [63 :0]  decd_src2_inst16_cbranch_imm;   
wire    [63 :0]  decd_src2_inst32_branch_imm;    
wire    [63 :0]  decd_src2_inst32_jal_imm;       
wire    [4  :0]  decd_src2_reg;                  
wire             decd_srcv0_srcv1_switch;        
wire             decd_srcv1_srcv2_switch;        
wire             decd_start_illegal;             
wire             decd_v_illegal;                 
wire             decd_vec_fp_ac_fcsr;            
wire             decd_vec_inst;                  
wire             decd_vec_inst_ac_fcsr;          
wire             decd_vec_inst_adc;              
wire             decd_vec_inst_comp;             
wire             decd_vec_inst_funary;           
wire             decd_vec_inst_mask;             
wire             decd_vec_inst_narr;             
wire             decd_vec_inst_scalar;           
wire             decd_vec_inst_slidedown;        
wire             decd_vec_inst_slideup;          
wire             decd_vec_inst_vcompress;        
wire             decd_vec_inst_vid;              
wire             decd_vec_inst_viota;            
wire             decd_vec_inst_vred;             
wire             decd_vec_inst_vred_n;           
wire             decd_vec_inst_vred_w;           
wire             decd_vec_inst_vrgather;         
wire             decd_vec_inst_wide;             
wire             decd_vec_inst_wide_w;           
wire    [3  :0]  decd_vec_ls_func;               
wire             decd_vec_lsu;                   
wire             decd_vec_nop;                   
wire             decd_vec_opcfg;                 
wire             decd_vec_opfv;                  
wire             decd_vec_opfvf;                 
wire             decd_vec_opfvv;                 
wire             decd_vec_opiv;                  
wire             decd_vec_opivi;                 
wire             decd_vec_opivv;                 
wire             decd_vec_opivx;                 
wire             decd_vec_opmv;                  
wire             decd_vec_opmvv;                 
wire             decd_vec_opmvx;                 
wire             decd_vec_opvx;                  
wire    [4  :0]  decd_vec_special_func;          
wire             decd_vec_vfunary0;              
wire             decd_vec_vfunary1;              
wire             decd_vec_vmunary0;              
wire             decd_vfunary0_vld;              
wire             decd_vfunary0_vld_narr;         
wire             decd_vfunary0_vld_norm;         
wire             decd_vfunary0_vld_wide;         
wire             decd_vill_illegal;              
wire             decd_vlsu_illegal;              
wire             decd_vmunary0_vld;              
wire             decd_vreg_dst_norm;             
wire    [4  :0]  decd_vreg_ill;                  
wire             decd_vreg_illegal;              
wire    [2  :0]  decd_vreg_illegal_type;         
wire             decd_vreg_src0_norm;            
wire             decd_vreg_src1_norm;            
wire             decd_vs_illegal;                
wire             decd_cp0_inst_csrwrite;
wire             decd_bju_inst_bcond;
wire             fcvt_f_x_narrow_il;             
wire             fcvt_f_x_widden;                
wire             fp_dynamic_rounding_illegal;    
wire             fp_fs_illegal;                  
wire             fp_static_rounding_illegal;     
wire             vec_mfvr_inst;                  
wire    [19 :0]  vfcvt_func;                     
wire    [5  :0]  x_decd_dst0_reg;                
wire    [5  :0]  x_decd_dst1_reg;                
wire    [2  :0]  x_decd_dstc_reg;                
wire    [4  :0]  x_decd_dstf_reg;                
wire    [4  :0]  x_decd_dstv_reg;                
wire             x_decd_illegal;                 
wire             x_decd_length;                  
wire    [31 :0]  x_decd_opcode;                  
wire    [5  :0]  x_decd_src0_reg;                
wire    [5  :0]  x_decd_src1_reg;                
wire    [5  :0]  x_decd_src2_reg;                
wire    [2  :0]  x_decd_srcc_reg;                
wire    [4  :0]  x_decd_srcf0_reg;               
wire    [4  :0]  x_decd_srcf1_reg;               
wire             x_decd_srcvm_vld;               
wire    [3  :0]  x_decd_vec_split_type;          
wire    [31 :0]  x_inst;                         
wire    [1  :0]  x_vlmul;                        
wire    [1  :0]  x_vsew;                
wire             src_reg_is_rd;         
wire decd_inst_vfpu_round_mode_rm;
wire decd_inst_vfpu_round_mode_rp;
wire decd_inst_vfpu_round_mode_rz;
wire decd_inst_vfpu_round_mode_rne;
wire decd_inst_vfpu_round_mode_vld;
wire [2:0] decd_inst_vfpu_round_mode;
wire [2:0] decd_fp_rm;

//==========================================================
//                      Input Data
//==========================================================
assign x_inst[31:0] = dp_decd_inst[31:0];
assign x_vsew[1:0]  = dp_decd_vsew[1:0];
assign x_vlmul[1:0] = dp_decd_vlmul[1:0];

//==========================================================
//                      Output Data
//==========================================================
// &CombBeg; @44
always @( x_decd_eu[9:0]
       or x_decd_srcvm_vld
       or x_decd_dstf_vld
       or x_decd_srcf2_vld
       or x_decd_dst0_vld
       or x_decd_vec_split_type[3:0]
       or x_decd_src1_imm[63:0]
       or x_decd_dstv_reg[4:0]
       or x_decd_dstc_vld
       or x_decd_dst1_vld
       or x_decd_src1_imm_vld
       or x_decd_dst0_reg[5:0]
       or x_decd_srcv1_vld
       or x_decd_srcv1_reg[4:0]
       or x_decd_srcc_vld
       or x_decd_src2_vld
       or x_decd_src0_vld
       or x_decd_src2_imm_vld
       or x_decd_srcv0_reg[4:0]
       or x_decd_src2_imm[63:0]
       or x_decd_srcv2_reg[4:0]
       or x_decd_srcf1_vld
       or x_decd_illegal
       or x_decd_func[19:0]
       or x_decd_dstv_late_vld
       or x_decd_dste_vld
       or x_decd_srcf0_vld
       or x_decd_src1_reg[5:0]
       or x_decd_srcv0_vld
       or x_decd_src1_vld
       or x_decd_dstv_vld
       or x_decd_length
       or x_decd_src0_reg[5:0]
       or x_decd_srcv2_vld
       or x_decd_opcode[31:0]
       or x_decd_srcc_reg[2:0]
       or x_decd_src2_reg[5:0]
       or x_decd_dstc_reg[2:0]
       or x_decd_dst1_reg[5:0]
       or fp_fs_illegal)
begin
  decd_dp_inst_data[`IDU_WIDTH-1:0]                            = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  decd_dp_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]         = x_decd_func[`FUNC_WIDTH-1:0];
  decd_dp_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]               = x_decd_eu[`EU_WIDTH-1:0];
  decd_dp_inst_data[`IDU_OPCODE:`IDU_OPCODE-31]                = x_decd_opcode[31:0];
  decd_dp_inst_data[`IDU_VEC_SPLIT_TYPE:`IDU_VEC_SPLIT_TYPE-3] = x_decd_vec_split_type[3:0];
  decd_dp_inst_data[`IDU_ILLEGAL]                              = x_decd_illegal;
  decd_dp_inst_data[`IDU_ILLEGAL_FP]                           = fp_fs_illegal;
  decd_dp_inst_data[`IDU_LENGTH]                               = x_decd_length;
  decd_dp_inst_data[`IDU_SRC2_IMM:`IDU_SRC2_IMM-63]            = x_decd_src2_imm[63:0];
  decd_dp_inst_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]            = x_decd_src1_imm[63:0];
  decd_dp_inst_data[`IDU_SRC2_IMM_VLD]                         = x_decd_src2_imm_vld;
  decd_dp_inst_data[`IDU_SRC1_IMM_VLD]                         = x_decd_src1_imm_vld;
  decd_dp_inst_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]             = x_decd_dstv_reg[4:0];
  decd_dp_inst_data[`IDU_SRCV2_REG:`IDU_SRCV2_REG-4]           = x_decd_srcv2_reg[4:0];
  decd_dp_inst_data[`IDU_SRCV1_REG:`IDU_SRCV1_REG-4]           = x_decd_srcv1_reg[4:0];
  decd_dp_inst_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]           = x_decd_srcv0_reg[4:0];
  decd_dp_inst_data[`IDU_DSTC_REG:`IDU_DSTC_REG-2]             = x_decd_dstc_reg[2:0];
  decd_dp_inst_data[`IDU_DST1_REG:`IDU_DST1_REG-5]             = x_decd_dst1_reg[5:0];
  decd_dp_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]             = x_decd_dst0_reg[5:0];
  decd_dp_inst_data[`IDU_SRCC_REG:`IDU_SRCC_REG-2]             = x_decd_srcc_reg[2:0];
  decd_dp_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]             = x_decd_src2_reg[5:0];
  decd_dp_inst_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]             = x_decd_src1_reg[5:0];
  decd_dp_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]             = x_decd_src0_reg[5:0];
  decd_dp_inst_data[`IDU_DSTV_LATE_VLD]                        = x_decd_dstv_late_vld;
  decd_dp_inst_data[`IDU_DSTV_VLD]                             = x_decd_dstv_vld;
  decd_dp_inst_data[`IDU_SRCVM_VLD]                            = x_decd_srcvm_vld;
  decd_dp_inst_data[`IDU_SRCV2_VLD]                            = x_decd_srcv2_vld;
  decd_dp_inst_data[`IDU_SRCV1_VLD]                            = x_decd_srcv1_vld;
  decd_dp_inst_data[`IDU_SRCV0_VLD]                            = x_decd_srcv0_vld;
  decd_dp_inst_data[`IDU_DSTE_VLD]                             = x_decd_dste_vld;
  decd_dp_inst_data[`IDU_DSTF_VLD]                             = x_decd_dstf_vld;
  decd_dp_inst_data[`IDU_SRCF2_VLD]                            = x_decd_srcf2_vld;
  decd_dp_inst_data[`IDU_SRCF1_VLD]                            = x_decd_srcf1_vld;
  decd_dp_inst_data[`IDU_SRCF0_VLD]                            = x_decd_srcf0_vld;
  decd_dp_inst_data[`IDU_DSTC_VLD]                             = x_decd_dstc_vld;
  decd_dp_inst_data[`IDU_DST1_VLD]                             = x_decd_dst1_vld;
  decd_dp_inst_data[`IDU_DST0_VLD]                             = x_decd_dst0_vld;
  decd_dp_inst_data[`IDU_SRCC_VLD]                             = x_decd_srcc_vld;
  decd_dp_inst_data[`IDU_SRC2_VLD]                             = x_decd_src2_vld;
  decd_dp_inst_data[`IDU_SRC1_VLD]                             = x_decd_src1_vld;
  decd_dp_inst_data[`IDU_SRC0_VLD]                             = x_decd_src0_vld;
 end
// &CombEnd; @83
end

//==========================================================
//               Decode Instruction Length
//==========================================================
assign decd_length         = 1'b1;

assign x_decd_opcode[31:0] = decd_length ? x_inst[31:0] : {16'b0,x_inst[15:0]}; 
assign x_decd_length       = decd_length;

//==========================================================
//               Other Decoded Information
//==========================================================
//----------------------------------------------------------
//                   Vector Split Type
//----------------------------------------------------------
assign x_decd_vec_split_type[3:0] = `VEC_SPLIT_NON;

//==========================================================
//                       Immediate
//==========================================================
//----------------------------------------------------------
//                   Immediate Selection
//----------------------------------------------------------
//uimm12
assign decd_src1_imm_sel[0]   =    (x_inst[31:22] == 10'b0000001101)  // andi
                                || (x_inst[31:22] == 10'b0000001110)  // ori
                                || (x_inst[31:22] == 10'b0000001111); // xori

//simm12
assign decd_src1_imm_sel[1]   =    (x_inst[31:24] == 8'b00000010)     // slti/slui/addi
                                || (x_inst[31:22] == 10'b0000001100)  // lu52i.d
                                || (x_inst[31:22] == 10'b0000011000)  // cacop
                                || (x_inst[31:26] == 6'b001010);      // load/store

//simm14
assign decd_src1_imm_sel[2]   =    (x_inst[31:26] == 6'b001000)       // ll/sc
                                || (x_inst[31:26] == 6'b001001);      // ldptr/stptr

//16 bit caddisp
assign decd_src1_imm_sel[3]   = 1'b0;
//16 bit caddi4spn
assign decd_src1_imm_sel[4]   = 1'b0;
//32 bit store
assign decd_src1_imm_sel[5]   = 1'b0;

//16 bit c.lwsp
assign decd_src1_imm_sel[6]   = 1'b0;

//16 bit c.lw/c.sw
assign decd_src1_imm_sel[7]   = 1'b0;

//16 bit c.swsp
assign decd_src1_imm_sel[8]   = 1'b0;

//16 bit c.fld/c.fsd/c.ld/c.sd
assign decd_src1_imm_sel[9]   = 1'b0;

//16 bit c.fldsp/c.ldsp
assign decd_src1_imm_sel[10]  = 1'b0;

//16 bit c.fsdsp/c.sdsp
assign decd_src1_imm_sel[11]  = 1'b0;

//lsi 
assign decd_src1_imm_sel[12]  = 1'b0;
// vector opivi
assign decd_src1_imm_sel[13]  = 1'b0;

//16 bit branch mask
assign decd_src1_imm_c_branch_mask = (x_inst[15:14] == 2'b11) ||
                                     (x_inst[15:12] == 4'b1000 && x_inst[6:2] != 5'b0 && x_inst[1:0] == 2'b10);

//----------------------------------------------------------
//                   Source 1 immediate
//----------------------------------------------------------
assign decd_caddisp_src1_imm[9:0]   = {x_inst[12],x_inst[4:3],
                                       x_inst[5], x_inst[2],
                                       x_inst[6], 4'b0};

assign decd_caddi4spn_src1_imm[9:0] = {x_inst[10:7],x_inst[12:11],
                                       x_inst[5], x_inst[6],2'b0};

// &CombBeg; @175
always @( x_inst[3:2]
       or decd_src1_imm_c_branch_mask
       or x_inst[31:2]
       or decd_caddisp_src1_imm[9:0]
       or decd_src1_imm_sel[13:0]
       or decd_caddi4spn_src1_imm[9:0])
begin
  case(decd_src1_imm_sel[13:0])
    14'h00  : x_decd_src1_imm[63:0] = 64'b0;
    14'h01  : x_decd_src1_imm[63:0] = {52'b0, x_inst[21:10]};
    14'h02  : x_decd_src1_imm[63:0] = {{52{x_inst[21]}}, x_inst[21:10]};
    14'h04  : x_decd_src1_imm[63:0] = {{48{x_inst[23]}}, x_inst[23:10], 2'b0};
    14'h08  : x_decd_src1_imm[63:0] = {{54{decd_caddisp_src1_imm[9]}}, decd_caddisp_src1_imm[9:0]};
    14'h10  : x_decd_src1_imm[63:0] = {54'b0, decd_caddi4spn_src1_imm[9:0]};
    14'h20  : x_decd_src1_imm[63:0] = {{53{x_inst[31]}}, x_inst[30:25], x_inst[11:7]};
    14'h40  : x_decd_src1_imm[63:0] = {56'b0, x_inst[3:2],x_inst[12],x_inst[6:4],2'b0};
    14'h80  : x_decd_src1_imm[63:0] = {57'b0, x_inst[5],x_inst[12:10],x_inst[6],2'b0};
    14'h100 : x_decd_src1_imm[63:0] = {56'b0, x_inst[8:7], x_inst[12:9], 2'b0};
    14'h200 : x_decd_src1_imm[63:0] = {56'b0, x_inst[6:5], x_inst[12:10], 3'b0};
    14'h400 : x_decd_src1_imm[63:0] = {55'b0, x_inst[4:2], x_inst[12], x_inst[6:5],3'b0};
    14'h800 : x_decd_src1_imm[63:0] = {55'b0, x_inst[9:7], x_inst[12:10], 3'b0};
    14'h1000: x_decd_src1_imm[63:0] = {{59{x_inst[24]}}, x_inst[24:20]} << x_inst[26:25];
    14'h2000: x_decd_src1_imm[63:0] = {59'b0, x_inst[19:15]};
    default : x_decd_src1_imm[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @195
end

//----------------------------------------------------------
//                   Immediate Selection
//----------------------------------------------------------
//uimm12
assign decd_src2_imm_sel[0]   =    (x_inst[31:22] == 10'b0000001101)  // andi
                                || (x_inst[31:22] == 10'b0000001110)  // ori
                                || (x_inst[31:22] == 10'b0000001111); // xori

//simm12
assign decd_src2_imm_sel[1]   =    (x_inst[31:24] == 8'b00000010)     // slti/slui/addi
                                || (x_inst[31:22] == 10'b0000001100)  // lu52i.d
                                || (x_inst[31:26] == 6'b001010);      // load/store

//simm14
assign decd_src2_imm_sel[2]   =    (x_inst[31:26] == 6'b001000)       // ll/sc
                                || (x_inst[31:26] == 6'b001001);      // ldptr/stptr


wire  decd_32_inst_pcaddi     =  (x_inst[31:25] == 7'b0001100);   // pcaddi
wire  decd_32_inst_pcalau12i  =  (x_inst[31:25] == 7'b0001101);   // pcalau12i
wire  decd_32_inst_pcaddu12i  =  (x_inst[31:25] == 7'b0001110);   // pcaddu12i
wire  decd_32_inst_pcaddu18i  =  (x_inst[31:25] == 7'b0001111);   // pcaddu18i

//simm20 
assign decd_src2_imm_sel[3]   =    decd_32_inst_pcaddi
                                || decd_32_inst_pcalau12i
                                || decd_32_inst_pcaddu12i
                                || decd_32_inst_pcaddu18i;

wire  decd_32_inst_jirl     =  (x_inst[31:26] == 6'b010011);  // jirl
wire  decd_32_inst_beq      =  (x_inst[31:26] == 6'b010110);  // beq
wire  decd_32_inst_bne      =  (x_inst[31:26] == 6'b010111);  // bne
wire  decd_32_inst_blt      =  (x_inst[31:26] == 6'b011000);  // blt
wire  decd_32_inst_bge      =  (x_inst[31:26] == 6'b011001);  // bge
wire  decd_32_inst_bltu     =  (x_inst[31:26] == 6'b011010);  // bltu
wire  decd_32_inst_bgeu     =  (x_inst[31:26] == 6'b011011);  // bgeu

// 32 bit jal imm16
assign decd_src2_imm_sel[4]   =   decd_32_inst_jirl
                               || decd_32_inst_beq   // beq
                               || decd_32_inst_bne   // bne
                               || decd_32_inst_blt   // blt
                               || decd_32_inst_bge   // bge
                               || decd_32_inst_bltu  // bltu
                               || decd_32_inst_bgeu; // bgeu

wire  decd_32_inst_beqz       =  (x_inst[31:26] == 6'b010000);  // beqz
wire  decd_32_inst_bnez       =  (x_inst[31:26] == 6'b010001);  // bnez
wire  decd_32_inst_bceqz      =  (x_inst[31:26] == 6'b010010) &&  x_inst[8];  // bceqz
wire  decd_32_inst_bcnez      =  (x_inst[31:26] == 6'b010010) && !x_inst[8];  // bcnez

// branch imm21
assign decd_src2_imm_sel[5]  =    decd_32_inst_beqz
                               || decd_32_inst_bnez   
                               || decd_32_inst_bceqz
                               || decd_32_inst_bcnez;


// branch imm26
assign decd_src2_imm_sel[6]   =   (x_inst[31:26] == 6'b010100)  // b
                               || (x_inst[31:26] == 6'b010101); // bl


assign decd_src2_imm_sel[7]   = (x_inst[31:15] == 17'b00000110010010011);  // invtlb

assign decd_src2_imm_sel[8]   = 1'b0;
assign decd_src2_imm_sel[9]   = 1'b0;
assign decd_src2_imm_sel[10]  = 1'b0;



// 16 bit c.jr/jalr mask
assign decd_src2_16bit_mask   = (x_inst[1:0] != 2'b11) && (x_inst[15:14] == 2'b10);

//----------------------------------------------------------
//                   Source 2 immediate
//----------------------------------------------------------
assign decd_src2_inst32_branch_imm[63:0]  = {{51{x_inst[31]}}, x_inst[31],
                                             x_inst[7], x_inst[30:25], x_inst[11:8],1'b0};
assign decd_src2_inst32_jal_imm[63:0]     = {{44{x_inst[31]}}, x_inst[19:12], x_inst[20],
                                             x_inst[30:21], 1'b0};
assign decd_src2_inst16_cbranch_imm[63:0] = {{55{x_inst[12]}}, x_inst[12], x_inst[6:5], x_inst[2],
                                             x_inst[11:10], x_inst[4:3], 1'b0};
assign decd_src2_inst16_c_j_imm[63:0]     = {{52{x_inst[12]}}, x_inst[12], x_inst[8], x_inst[10:9],
                                             x_inst[6], x_inst[7], x_inst[2], x_inst[11],
                                             x_inst[5:3],1'b0};

wire [63:0] decd_src2_inst_pcadd_imm;

assign decd_src2_inst_pcadd_imm[63:0] =  {64{decd_32_inst_pcaddi   }} & {{42{x_inst[24]}} ,x_inst[24:5], 2'b0}
                                       | {64{decd_32_inst_pcalau12i}} & {{32{x_inst[24]}} ,x_inst[24:5], 12'b0}
                                       | {64{decd_32_inst_pcaddu12i}} & {{32{x_inst[24]}} ,x_inst[24:5], 12'b0}
                                       | {64{decd_32_inst_pcaddu18i}} & {{26{x_inst[24]}} ,x_inst[24:5], 18'b0};


wire [63:0] decd_src2_inst_br_imm16;

assign decd_src2_inst_br_imm16[63:0] =   {64{decd_32_inst_jirl}} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0}
                                       | {64{decd_32_inst_beq }} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0}
                                       | {64{decd_32_inst_bne }} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0}
                                       | {64{decd_32_inst_blt }} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0}
                                       | {64{decd_32_inst_bge }} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0}
                                       | {64{decd_32_inst_bltu}} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0}
                                       | {64{decd_32_inst_bgeu}} & {{46{x_inst[25]}} ,x_inst[25:10], 2'b0};

wire [63:0] decd_src2_inst_br_imm21;
assign decd_src2_inst_br_imm21[63:0] =   {{41{x_inst[4]}}, x_inst[4:0] ,x_inst[25:10], 2'b0};



wire [63:0] decd_src2_inst_br_imm26;
assign decd_src2_inst_br_imm26[63:0] =   {{36{x_inst[9]}}, x_inst[9:0] ,x_inst[25:10], 2'b0};


// &CombBeg; @240
always @( decd_src2_inst_pcadd_imm[63:0]
       or decd_src2_inst_br_imm16[63:0]
       or decd_src2_imm_sel[10:0]
       or decd_src2_inst_br_imm21[63:0]
       or decd_src2_inst_br_imm26[63:0]
       or x_inst[31:0])
begin
  case(decd_src2_imm_sel[10:0])
    11'h00   : x_decd_src2_imm[63:0] = 64'b0;
    11'h01   : x_decd_src2_imm[63:0] = {52'b0, x_inst[21:10]};
    11'h02   : x_decd_src2_imm[63:0] = {{52{x_inst[21]}}, x_inst[21:10]};
    11'h04   : x_decd_src2_imm[63:0] = {{48{x_inst[23]}}, x_inst[23:10], 2'b0};
    11'h08   : x_decd_src2_imm[63:0] = decd_src2_inst_pcadd_imm[63:0];
    11'h10   : x_decd_src2_imm[63:0] = decd_src2_inst_br_imm16[63:0];
    11'h20   : x_decd_src2_imm[63:0] = decd_src2_inst_br_imm21[63:0];
    11'h40   : x_decd_src2_imm[63:0] = decd_src2_inst_br_imm26[63:0];
    11'h80   : x_decd_src2_imm[63:0] = {59'b0, x_inst[4:0]};
    default  : x_decd_src2_imm[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @252
end

//----------------------------------------------------------
//                   Source 3 immediate
//----------------------------------------------------------
//src3 immediate is only used by lsr inst
assign decd_lsr_src3_imm_vld  = (x_inst[6:0] == 7'b0001011) 
                             && x_inst[14] 
                             && !x_inst[27];
assign decd_lsr_src3_imm[1:0] = x_inst[26:25] & {2{decd_lsr_src3_imm_vld}};

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
assign decd_inst_src0_reg_16bit_5 = 1'b0;
assign decd_inst_src0_reg_cmv     = 1'b0;
assign decd_inst_src0_reg_16bit_3 = 1'b0;
assign decd_inst_src0_reg_r2      = 1'b0;
//index select
assign decd_src0_reg[4:0] =
           {5{decd_inst_src0_reg_32bit}}   & x_inst[9:5];

//output
assign x_decd_src0_reg[5:0] = decd_inst_vec ? {1'b0, x_inst[24:20]} : {1'b0, decd_src0_reg[4:0]};

//----------------------------------------------------------
//                  Source 1 Register Index
//----------------------------------------------------------
assign decd_inst_src1_reg_32bit     = 1'b1;
assign decd_inst_src1_reg_16bit_5   = 1'b0;
assign decd_inst_src1_reg_16bit_3   = 1'b0;
assign decd_inst_fmv                = 1'b0;  
assign decd_inst_fcvtfx             = 1'b0;  

assign decd_cp0_inst_csrwrite       = (x_inst[31:24] == 8'b00000100) && 
                                      (x_inst[9:5] != 5'b00000);  // csrwr/csrxchg

assign decd_bju_inst_bcond          =  decd_32_inst_beq   // beq
                                    || decd_32_inst_bne   // bne
                                    || decd_32_inst_blt   // blt
                                    || decd_32_inst_bge   // bge
                                    || decd_32_inst_bltu  // bltu
                                    || decd_32_inst_bgeu; // bgeu

//index select
assign decd_src1_reg[4:0] = (decd_cp0_inst_csrwrite 
                             || decd_bju_inst_bcond) ? x_inst[4:0] : x_inst[14:10];

//output
assign x_decd_src1_reg[5:0] = decd_inst_vec ? {1'b0,x_inst[19:15]} : {1'b0,decd_src1_reg[4:0]};

//----------------------------------------------------------
//                  Source 2 Register Index
//----------------------------------------------------------
assign decd_inst_src2_reg_32bit_24_20  = 1'b0;
assign decd_inst_src2_reg_32bit_11_7   = 1'b0;
assign decd_inst_src2_reg_16bit_3      = 1'b0;
assign decd_inst_src2_reg_16bit_5      = 1'b0;

assign decd_inst_amo_db = (x_inst[31:21] == 11'b00111000011)
                           && ((x_inst[20:15] == 6'b010010)   //amswap_db.w
                            || (x_inst[20:15] == 6'b010011)   //amswap_db.d
                            || (x_inst[20:15] == 6'b010100)   //amadd_db.w
                            || (x_inst[20:15] == 6'b010101)   //amadd_db.d
                            || (x_inst[20:15] == 6'b010110)   //amand_db.w
                            || (x_inst[20:15] == 6'b010111)   //amand_db.d
                            || (x_inst[20:15] == 6'b011000)   //amor_db.w
                            || (x_inst[20:15] == 6'b011001)   //amor_db.d
                            || (x_inst[20:15] == 6'b011010)   //amxor_db.w
                            || (x_inst[20:15] == 6'b011011)   //amxor_db.d
                            || (x_inst[20:15] == 6'b011100)   //ammax_db.w
                            || (x_inst[20:15] == 6'b011101)   //ammax_db.d
                            || (x_inst[20:15] == 6'b011110)   //ammin_db.w
                            || (x_inst[20:15] == 6'b011111)   //ammin_db.d
                            || (x_inst[20:15] == 6'b100000)   //ammax_db.wu
                            || (x_inst[20:15] == 6'b100001)   //ammax_db.du
                            || (x_inst[20:15] == 6'b100010)   //ammin_db.wu
                            || (x_inst[20:15] == 6'b100011)); //ammin_db.du

assign decd_inst_amo = (x_inst[31:21] == 11'b00111000011)
                           && ((x_inst[20:15] == 6'b000000)   //amswap.w
                            || (x_inst[20:15] == 6'b000001)   //amswap.d
                            || (x_inst[20:15] == 6'b000010)   //amadd.w
                            || (x_inst[20:15] == 6'b000011)   //amadd.d
                            || (x_inst[20:15] == 6'b000100)   //amand.w
                            || (x_inst[20:15] == 6'b000101)   //amand.d
                            || (x_inst[20:15] == 6'b000110)   //amor.w
                            || (x_inst[20:15] == 6'b000111)   //amor.d
                            || (x_inst[20:15] == 6'b001000)   //amxor.w
                            || (x_inst[20:15] == 6'b001001)   //amxor.d
                            || (x_inst[20:15] == 6'b001010)   //ammax.w
                            || (x_inst[20:15] == 6'b001011)   //ammax.d
                            || (x_inst[20:15] == 6'b001100)   //ammin.w
                            || (x_inst[20:15] == 6'b001101)   //ammin.d
                            || (x_inst[20:15] == 6'b001110)   //ammax.wu
                            || (x_inst[20:15] == 6'b001111)   //ammax.du
                            || (x_inst[20:15] == 6'b010000)   //ammin.wu
                            || (x_inst[20:15] == 6'b010001)); //ammin.du

//index select
assign decd_src2_reg[4:0] = (decd_inst_amo_db || decd_inst_amo) ? x_inst[14:10] 
                                                                : x_inst[4:0];

//output
assign x_decd_src2_reg[5:0] = {1'b0, decd_src2_reg[4:0]};

//----------------------------------------------------------
//                  Source fccr Register Index
//----------------------------------------------------------
wire decd_inst_fsel         = x_inst[31:18] == 14'b000011010000_00;
assign x_decd_srcc_reg[2:0] = decd_inst_fsel ? x_inst[17:15] : x_inst[7:5];

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic

//----------------------------------------------------------
//          Decode destination 0 register index
//----------------------------------------------------------
assign decd_inst_dst0_reg_32bit        =  (x_inst[1:0] == 2'b11);
assign decd_inst_dst0_reg_16bit_5      = ({x_inst[1:0],x_inst[15]} == 3'b01_0)
                                       || (x_inst[1:0] == 2'b10)
                                          && ({x_inst[15:12],x_inst[6:2]} != 9'b1001_00000);
assign decd_inst_dst0_reg_16bit_3_high = ({x_inst[1:0],x_inst[15]} == 3'b01_1);
assign decd_inst_dst0_reg_16bit_3_low  =  (x_inst[1:0] == 2'b00);
assign decd_inst_dst0_reg_16bit_x1     =  ({x_inst[15:12],x_inst[6:0]} == 11'b1001_00000_10);


assign decd_inst_branch_link =    (x_inst[31:26] == 6'b010101); // bl

//index select
assign decd_dst0_reg[4:0] = decd_inst_branch_link ?
                              5'b00001 // ra
                            : x_inst[4:0];


assign decd_inst_preld   =   (x_inst[31:22] == 10'b0010101011)         //preld
                          || (x_inst[31:15] == 17'b00111000001011000); //preldx

//output
assign x_decd_dst0_reg[5:0] = decd_inst_preld ? 6'b0 : {1'b0, decd_dst0_reg[4:0]};

//----------------------------------------------------------
//          Decode destination 1 register index
//----------------------------------------------------------
//index select
assign decd_dst1_reg[4:0] = x_inst[19:15];
//output
assign x_decd_dst1_reg[5:0] = {1'b0,decd_dst1_reg[4:0]};

//----------------------------------------------------------
//          Decode destination fcc register index
//----------------------------------------------------------
assign x_decd_dstc_reg[2:0] = x_inst[2:0];

//==========================================================
//            Decode Scalar FP Source Register Index
//==========================================================
//----------------------------------------------------------
//               Scalar FP Source 0 Register Index
//----------------------------------------------------------
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructio
//so add new instruction should carefully check these logic
assign x_decd_srcf0_reg[4:0] = src_reg_is_rd ? x_inst[4:0] : x_inst[9:5];

//----------------------------------------------------------
//               Scalar FP Source 1 Register Index
//----------------------------------------------------------
assign decd_inst_srcf1_reg_32bit     = (x_inst[1:0] == 2'b11)
                                       && (x_inst[6:0] != 7'b0001011)
                                       && !decd_inst_vec;
assign decd_inst_srcf1_reg_32bit_low = (x_inst[1:0] == 2'b11)
                                       && (x_inst[6:0] == 7'b0001011);
assign decd_inst_srcf1_reg_16bit     = (x_inst[1:0] == 2'b10);
assign decd_inst_srcf1_reg_16bit_low = (x_inst[1:0] == 2'b00);

assign x_decd_srcf1_reg[4:0] = x_inst[14:10];

//----------------------------------------------------------
//               Scalar FP Source 2 Register Index
//----------------------------------------------------------
//perf_inst 
assign decd_inst_vls       = 1'b0;

//// no other srcf2_vld inst except st
// c.fsd || c.fsdsp
assign decd_inst_cls_sp    = 1'b0;
assign decd_inst_cls       = 1'b0;
assign decd_inst_fls       = 1'b1;
// &CombBeg; @430
always @( x_inst[9:5]
       or x_inst[19:15]
       or x_inst[4:0]
       or decd_32_srcf2_vld
       or decd_inst_vls
       or decd_inst_fls)
begin
case({decd_inst_vls,decd_inst_fls})
  2'b10  : x_decd_srcf2_reg[4:0] = x_inst[9:5];
  2'b01  : x_decd_srcf2_reg[4:0] = decd_32_srcf2_vld ? x_inst[4:0] : x_inst[19:15]; 
  default: x_decd_srcf2_reg[4:0] = x_inst[19:15];
endcase

// &CombEnd; @439
end

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign decd_inst_dstf_reg_32bit      = (x_inst[6:0]==7'b0100111) && (!x_inst[14] && |x_inst[13:12]);
assign decd_inst_dstf_reg_32bit_low  = (x_inst[1:0] == 2'b11) && !decd_inst_dstf_reg_32bit;
assign decd_inst_dstf_reg_16bit_high = {x_inst[15],x_inst[1:0]} == 3'b010;
assign decd_inst_dstf_reg_16bit      = {x_inst[15],x_inst[13],x_inst[1:0]} == 4'b1110;
assign decd_inst_dstf_reg_16bit_low  = (x_inst[1:0] == 2'b00);

assign x_decd_dstf_reg[4:0] = x_inst[4:0];

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



assign decd_inst_vfpu_round_mode_rm = 
                (x_inst[31:10] == 22'b0000000100011010000001) || // ftintrm.w.s
                (x_inst[31:10] == 22'b0000000100011010000010) || // ftintrm.w.d
                (x_inst[31:10] == 22'b0000000100011010001001) || // ftintrm.l.s
                (x_inst[31:10] == 22'b0000000100011010001010);   // ftintrm.l.d

assign decd_inst_vfpu_round_mode_rp = 
                (x_inst[31:10] == 22'b0000000100011010010001) || // ftintrp.w.s
                (x_inst[31:10] == 22'b0000000100011010010010) || // ftintrp.w.d
                (x_inst[31:10] == 22'b0000000100011010011001) || // ftintrp.l.s
                (x_inst[31:10] == 22'b0000000100011010011010);   // ftintrp.l.d

assign decd_inst_vfpu_round_mode_rz = 
                (x_inst[31:10] == 22'b0000000100011010100001) || // ftintrz.w.s
                (x_inst[31:10] == 22'b0000000100011010100010) || // ftintrz.w.d
                (x_inst[31:10] == 22'b0000000100011010101001) || // ftintrz.l.s
                (x_inst[31:10] == 22'b0000000100011010101010);   // ftintrz.l.d 
  
assign decd_inst_vfpu_round_mode_rne = 
                (x_inst[31:10] == 22'b0000000100011010110001) || // ftintrne.w.s
                (x_inst[31:10] == 22'b0000000100011010110010) || // ftintrne.w.d
                (x_inst[31:10] == 22'b0000000100011010111001) || // ftintrne.l.s
                (x_inst[31:10] == 22'b0000000100011010111010);   // ftintrne.l.d

assign decd_inst_vfpu_round_mode_vld = decd_inst_vfpu_round_mode_rm ||
                                       decd_inst_vfpu_round_mode_rp ||
                                       decd_inst_vfpu_round_mode_rz ||
                                       decd_inst_vfpu_round_mode_rne;

assign decd_inst_vfpu_round_mode[2:0] = {3{decd_inst_vfpu_round_mode_rm}} & 3'b010 | // round minus infinity (negative)
                                        {3{decd_inst_vfpu_round_mode_rp}} & 3'b011 | // round positive
                                        {3{decd_inst_vfpu_round_mode_rz}} & 3'b001 | // round zero
                                        {3{decd_inst_vfpu_round_mode_rne}} & 3'b000; // round even

assign decd_fp_rm[2:0]                = decd_inst_vfpu_round_mode_vld ?  
                                        decd_inst_vfpu_round_mode[2:0] : 3'b111;

// &CombBeg; @562
// &CombEnd; @573
// &CombBeg; @575
// &CombEnd; @588
// &CombBeg; @593
// &CombEnd; @600
// &CombBeg; @602
// &CombEnd; @609
assign decd_vlsu_illegal = 1'b0;
assign decd_vec_lsu      = 1'b0;

//----------------------------------------------------------
//                 FP Illegal Instruction
//----------------------------------------------------------
//FP extension illegal
//1. rounding mode == 3'b101 or rounding mode = 3'b110
//2. rounding mode == 3'b111 and fcsr[7:5] == 3'b101~3'b111
//3. FS==0,execute RV64F/D inst or read/write fcsr/fflags/frm/fxcr
//   read/write fcsr/... will decode in `EU_CP0
assign fp_static_rounding_illegal  = (x_inst[14:12] == 3'b101)
                                  || (x_inst[14:12] == 3'b110);

assign fp_dynamic_rounding_illegal = (x_inst[14:12] == 3'b111)
                                  && ((cp0_idu_frm[2:0] == 3'b101)
                                      ||(cp0_idu_frm[2:0] == 3'b110)
                                      ||(cp0_idu_frm[2:0] == 3'b111));

// if cp0_idu_fs[1:0] != 00, fpu turn on!
assign fp_fs_illegal = (cp0_idu_fs[1:0] == 2'b00);

assign decd_fp_illegal =  decd_fp_inst_illegal
                       // || fp_static_rounding_illegal
                       // || fp_dynamic_rounding_illegal
                       || fp_fs_illegal;

//----------------------------------------------------------
//                Debug Illegal Instruction
//----------------------------------------------------------
//when in debug mode, inst with pc src or dest will be illegal
assign decd_debug_illegal = (x_decd_eu[`EU_WIDTH-1:0] == `EU_BJU);

//----------------------------------------------------------
//               Illegal Instruction Result
//----------------------------------------------------------
//output all illegal
assign x_decd_illegal = decd_32_illegal    && decd_sel[0]
                     || decd_16_illegal    && decd_sel[1]
                     || decd_i_illegal
                     || decd_c_illegal
                     || decd_lsu_illegal
                     || decd_fp_illegal    && decd_sel[2]
                     || decd_cache_illegal && decd_sel[3]
                     || decd_perf_illegal  && decd_sel[4]
                     || decd_vec_illegal   && decd_sel[5]
                     || decd_debug_illegal && rtu_yy_xx_dbgon;

//==========================================================
//          Full Decoder for valid and illegal inst
//==========================================================
//the destination and source valid signal and invalid
//instruction exception is hard to optimazied for timing,
//so here implement a full decoder for: type, dst0_vld, dst_c_vld
//src0_vld, src1_vld, srcc_vld, dstf_vld, dste_vld, srcf0_vld,
//srcf1_vld, srcf2_vld, inv_expt
//----------------------------------------------------------
//                  Decoder Result Selection
//----------------------------------------------------------

assign decd_fp_sel  = (x_inst[31:22] == 10'b0000000100) || // fp other
                      (x_inst[31:24] == 8'b00001000) ||    // fp fuse
                      (x_inst[31:24] == 8'b00001100) ||    // fcmp
                      (x_inst[31:24] == 8'b00001101);      // fsel

//32 bits
assign decd_sel[0] = decd_length
                     && !decd_fp_sel
                     && !decd_sel[3]
                     && !decd_sel[4]
                     && !decd_sel[5];
//16 bits
assign decd_sel[1] = !decd_length;
//fp
assign decd_sel[2] = decd_fp_sel;
//cache
assign decd_sel[3] = 1'b0;
//perf
assign decd_sel[4] = 1'b0;
//vector
assign decd_sel[5] = 1'b0;

// &CombBeg; @750
always @( decd_32_srcv2_vld
       or x_inst[14:12]
       or decd_32_srcv1_vld
       or decd_vec_srcf2_vld
       or decd_vec_dstf_vld
       or decd_perf_srcf1_vld
       or decd_vec_srcv2_vld
       or decd_cache_eu[9:0]
       or decd_vec_special_func[4:0]
       or decd_lsr_src3_imm[1:0]
       or decd_32_src0_vld
       or decd_32_func[19:0]
       or decd_perf_src2_vld
       or decd_vec_srcf0_vld
       or decd_vec_eu[9:0]
       or decd_32_dst0_vld
       or decd_perf_src1_imm_vld
       or decd_fp_dst0_vld
       or decd_fp_dstc_vld
       or decd_perf_dst1_vld
       or decd_fp_srcf0_vld
       or decd_vec_dste_vld
       or decd_vec_src0_vld
       or decd_32_dste_vld
       or decd_vec_srcv1_vld
       or decd_16_eu[9:0]
       or decd_fp_srcf1_vld
       or decd_fp_dste_vld
       or decd_perf_eu[9:0]
       or decd_16_src1_imm_vld
       or decd_sel[5:0]
       or decd_32_srcv0_vld
       or decd_cache_src0_vld
       or decd_16_src1_vld
       or decd_32_src2_vld
       or decd_32_srcc_vld
       or decd_16_dst0_vld
       or decd_perf_src0_vld
       or decd_32_srcf0_vld
       or decd_16_src2_imm_vld
       or decd_32_src2_imm_vld
       or decd_16_src2_vld
       or decd_16_srcf2_vld
       or decd_cache_func[19:0]
       or decd_32_eu[9:0]
       or decd_vec_dst0_vld
       or decd_vec_src2_vld
       or decd_fp_src1_vld
       or decd_vec_func[19:0]
       or decd_vec_srcv0_vld
       or decd_vec_ls_func[3:0]
       or decd_vec_src1_vld
       or decd_perf_src1_vld
       or decd_fp_func[19:0]
       or decd_32_dstf_vld
       or decd_fp_srcf2_vld
       or decd_vec_dstv_vld
       or decd_vec_srcf1_vld
       or decd_32_dstv_vld
       or decd_perf_func[19:0]
       or decd_fp_dstf_vld
       or decd_32_src1_imm_vld
       or decd_perf_dstf_vld
       or decd_perf_src2_imm_vld
       or decd_16_srcf1_vld
       or decd_perf_srcf2_vld
       or decd_16_func[19:0]
       or decd_16_dstf_vld
       or decd_fp_src0_vld
       or decd_fp0_srcc_vld
       or decd_vec_dstv_late_vld
       or decd_inst_vfpu_round_mode_vld
       or decd_fp_rm
       or decd_32_src1_vld
       or decd_32_srcf2_vld
       or decd_32_srcf1_vld
       or decd_vec_opivi
       or decd_fp_eu[9:0]
       or decd_perf_dst0_vld
       or decd_16_src0_vld)
begin
  case(decd_sel[5:0])
    6'h1: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_32_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_32_func[`FUNC_WIDTH-1:0]
                                   | {decd_vec_ls_func[3:0],{`FUNC_WIDTH-4{1'b0}}};
      x_decd_dstc_vld              = 1'b0;
      x_decd_dst0_vld              = decd_32_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_32_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = decd_32_dstv_vld;
      x_decd_dste_vld              = decd_32_dste_vld;
      x_decd_src0_vld              = decd_32_src0_vld;
      x_decd_src1_vld              = decd_32_src1_vld;
      x_decd_src1_imm_vld          = decd_32_src1_imm_vld;
      x_decd_src2_vld              = decd_32_src2_vld;
      x_decd_src2_imm_vld          = decd_32_src2_imm_vld;
      x_decd_srcc_vld              = decd_32_srcc_vld;
      x_decd_srcf0_vld             = decd_32_srcf0_vld;
      x_decd_srcf1_vld             = decd_32_srcf1_vld;
      x_decd_srcf2_vld             = decd_32_srcf2_vld;
      x_decd_srcv0_vld             = decd_32_srcv0_vld;
      x_decd_srcv1_vld             = decd_32_srcv1_vld;
      x_decd_srcv2_vld             = decd_32_srcv2_vld;
    end
    6'h4: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_fp_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_fp_func[`FUNC_WIDTH-1:0]
                                     | {13'b0, {3{decd_inst_vfpu_round_mode_vld}} & decd_fp_rm, 4'b0};
      x_decd_dstc_vld              = decd_fp_dstc_vld;
      x_decd_dst0_vld              = decd_fp_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_fp_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = decd_fp_dste_vld;
      x_decd_src0_vld              = decd_fp_src0_vld;
      x_decd_src1_vld              = decd_fp_src1_vld;
      x_decd_src1_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_src2_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_srcf0_vld             = decd_fp_srcf0_vld;
      x_decd_srcf1_vld             = decd_fp_srcf1_vld;
      x_decd_srcf2_vld             = decd_fp_srcf2_vld;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
      x_decd_srcc_vld              = decd_fp0_srcc_vld;
    end
    6'h8: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_cache_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_cache_func[`FUNC_WIDTH-1:0];
      x_decd_dstc_vld              = 1'b0;
      x_decd_dst0_vld              = 1'b0;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = 1'b0;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = 1'b0;
      x_decd_src0_vld              = decd_cache_src0_vld;
      x_decd_src1_vld              = 1'b0;
      x_decd_src1_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_src2_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_srcf0_vld             = 1'b0;
      x_decd_srcf1_vld             = 1'b0;
      x_decd_srcf2_vld             = 1'b0;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
      x_decd_srcc_vld              = 1'b0;
    end
    6'h10: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_perf_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_perf_func[`FUNC_WIDTH-1:0]
                                   | {{`FUNC_WIDTH-16{1'b0}},decd_lsr_src3_imm[1],10'b0,decd_lsr_src3_imm[0],{4{1'b0}}};
      x_decd_dstc_vld              = 1'b0;
      x_decd_dst0_vld              = decd_perf_dst0_vld;
      x_decd_dst1_vld              = decd_perf_dst1_vld;
      x_decd_dstf_vld              = decd_perf_dstf_vld;
      x_decd_dstv_late_vld         = 1'b0;
      x_decd_dstv_vld              = 1'b0;
      x_decd_dste_vld              = 1'b0;
      x_decd_src0_vld              = decd_perf_src0_vld;
      x_decd_src1_vld              = decd_perf_src1_vld;
      x_decd_src1_imm_vld          = decd_perf_src1_imm_vld;
      x_decd_src2_vld              = decd_perf_src2_vld;
      x_decd_src2_imm_vld          = decd_perf_src2_imm_vld;
      x_decd_src2_vld              = 1'b0;
      x_decd_srcf0_vld             = 1'b0;
      x_decd_srcf1_vld             = decd_perf_srcf1_vld;
      x_decd_srcf2_vld             = decd_perf_srcf2_vld;
      x_decd_srcv0_vld             = 1'b0;
      x_decd_srcv1_vld             = 1'b0;
      x_decd_srcv2_vld             = 1'b0;
      x_decd_srcc_vld              = 1'b0;
    end
    6'h20: begin
      x_decd_eu[`EU_WIDTH-1:0]     = decd_vec_eu[`EU_WIDTH-1:0];
      x_decd_func[`FUNC_WIDTH-1:0] = decd_vec_func[`FUNC_WIDTH-1:0] 
                                   | {decd_vec_special_func[4:0],{`FUNC_WIDTH-5{1'b0}}};
      x_decd_dstc_vld              = 1'b0;
      x_decd_dst0_vld              = decd_vec_dst0_vld;
      x_decd_dst1_vld              = 1'b0;
      x_decd_dstf_vld              = decd_vec_dstf_vld;
      x_decd_dstv_late_vld         = decd_vec_dstv_late_vld;
      x_decd_dstv_vld              = decd_vec_dstv_vld;
      x_decd_dste_vld              = decd_vec_dste_vld;
      x_decd_src0_vld              = decd_vec_src0_vld;
      x_decd_src1_vld              = decd_vec_src1_vld;
      x_decd_src1_imm_vld          = decd_vec_opivi;
      x_decd_src2_vld              = decd_vec_src2_vld;
      x_decd_src2_imm_vld          = 1'b0;
      x_decd_src2_vld              = 1'b0;
      x_decd_srcf0_vld             = decd_vec_srcf0_vld;
      x_decd_srcf1_vld             = decd_vec_srcf1_vld;
      x_decd_srcf2_vld             = decd_vec_srcf2_vld;
      x_decd_srcv0_vld             = decd_vec_srcv0_vld;
      x_decd_srcv1_vld             = decd_vec_srcv1_vld;
      x_decd_srcv2_vld             = decd_vec_srcv2_vld;
      x_decd_srcc_vld              = 1'b0;
    end
    default: begin
      x_decd_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'bx}};
      x_decd_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'bx}};
      x_decd_dstc_vld              = 1'bx;
      x_decd_dst0_vld              = 1'bx;
      x_decd_dst1_vld              = 1'bx;
      x_decd_dstf_vld              = 1'bx;
      x_decd_dstv_late_vld         = 1'bx;
      x_decd_dstv_vld              = 1'bx;
      x_decd_dste_vld              = 1'bx;
      x_decd_src0_vld              = 1'bx;
      x_decd_src1_vld              = 1'bx;
      x_decd_src1_imm_vld          = 1'bx;
      x_decd_src2_vld              = 1'bx;
      x_decd_src2_imm_vld          = 1'bx;
      x_decd_src2_vld              = 1'bx;
      x_decd_srcf0_vld             = 1'bx;
      x_decd_srcf1_vld             = 1'bx;
      x_decd_srcf2_vld             = 1'bx;
      x_decd_srcv0_vld             = 1'bx;
      x_decd_srcv1_vld             = 1'bx;
      x_decd_srcv2_vld             = 1'bx;
      x_decd_srcc_vld              = 1'bx;
    end
  endcase
// &CombEnd; @904
end


//----------------------------------------------------------
//                   32 bits Full Decoder
//----------------------------------------------------------
// &CombBeg; @1177
always @( x_inst[31:15]
       or x_inst[14:10]
       or x_inst[9:5]
       or x_inst[4:0])
begin
  //initialize decoded information value
  decd_32_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_32_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_32_dst0_vld              = 1'b0;
  decd_32_dstf_vld              = 1'b0;
  decd_32_dste_vld              = 1'b0;
  decd_32_src0_vld              = 1'b0;
  decd_32_src1_vld              = 1'b0;
  decd_32_src1_imm_vld          = 1'b0;
  decd_32_src2_vld              = 1'b0;
  decd_32_src2_imm_vld          = 1'b0;
  decd_32_srcc_vld              = 1'b0;
  decd_32_srcf0_vld             = 1'b0;
  decd_32_srcf1_vld             = 1'b0;
  decd_32_srcf2_vld             = 1'b0;
  decd_32_srcv0_vld             = 1'b0;
  decd_32_srcv1_vld             = 1'b0;
  decd_32_srcv2_vld             = 1'b0;
  decd_32_dstv_vld              = 1'b0;
  //illegal instruction
  decd_32_illegal               = 1'b0;

    casez({x_inst[31:15], x_inst[14:10]})
    //32-bits instructions decode logic
    22'b00000000000100000_????? :begin //add.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100001_????? :begin //add.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100010_????? :begin //sub.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SUBW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100011_????? :begin //sub.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SUBD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001010_???????_????? :begin //addi.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001011_???????_????? :begin //addi.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b000100_????_???????_????? :begin //addu16i.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDU16ID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b000000000000010??_????? :begin //alsl.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ALSLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b000000000000011??_????? :begin //alsl.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ALSLWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b000000000010110??_????? :begin //alsl.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ALSLD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0001010_???_???????_????? :begin //lu12i.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LU12IW;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0001011_???_???????_????? :begin //lu32i.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LU32ID;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001100_???????_????? :begin //lu52i.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LU52ID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100100_????? :begin //slt
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLT;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100101_????? :begin //sltu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLTU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    // 12-offset
    22'b0000001000_???????_????? :begin //slti
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLTI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001001_???????_????? :begin //sltui
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLTUI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0001100_??????????????? :begin //pcaddi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_PCADDI;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0001101_??????????????? :begin //pcalau12i
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_PCALAU12I;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0001110_??????????????? :begin //pcaddu12i
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_PCADDU12I;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0001111_??????????????? :begin //pcaddu18i
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_PCADDU18I;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101000_????? :begin //nor
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_NOR;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101001_????? :begin //and
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AND;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101010_????? :begin //or
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_OR;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101011_????? :begin //xor
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_XOR;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101100_????? :begin //orn
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ORN;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101101_????? :begin //andn
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ANDN;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001101_???????_????? :begin //andi
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ANDI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001110_???????_????? :begin //ori
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ORI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000001111_???????_????? :begin //xori
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_XORI;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end

    // mult
    22'b00000000000111000_????? :begin //mul.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111001_????? :begin //mulh.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULHW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111010_????? :begin //mulh.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULHWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111011_????? :begin //mul.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111100_????? :begin //mulh.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULHD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111101_????? :begin //mulh.du
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULHDU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111110_????? :begin //mulw.d.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULWDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000111111_????? :begin //mulw.d.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_MULT;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MULWDWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000000_????? :begin //div.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000001_????? :begin //mod.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MODW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000010_????? :begin //div.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000011_????? :begin //mod.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MODWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000100_????? :begin //div.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000101_????? :begin //mod.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MODD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000110_????? :begin //div.du
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DIVDU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001000111_????? :begin //mod.du
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_DIV;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MODDU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101110_????? :begin //sll.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000101111_????? :begin //srl.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000110000_????? :begin //sra.w
     decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000110001_????? :begin //sll.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000110010_????? :begin //srl.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000110011_????? :begin //sra.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000110110_????? :begin //rotr.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ROTRW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000110111_????? :begin //rotr.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ROTRD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000010000001_????? :begin //slli.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000000001000001?_????? :begin //slli.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SLLID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000010001001_????? :begin //srli.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000000001000101?_????? :begin //srli.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRLID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000010010001_????? :begin //srai.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000000001001001?_????? :begin //srai.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SRAID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000010011001_????? :begin //rotri.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ROTRIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000000001001101?_????? :begin //rotri.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ROTRID;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b000000000000100??_????? :begin //bytepick.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BYTEPICKW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000011???_????? :begin //bytepick.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BYTEPICKD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100110_????? :begin //maskeqz
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MASKEQZ;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000100111_????? :begin //masknez
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_MASKNEZ;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000010_????? :begin //asrtle.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ASRTLED;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b00000000000000011_????? :begin //asrtgt.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ASRTGTD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b00000000000000000_00100 :begin //clo.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CLOW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_00101 :begin //clz.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CLZW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_00110 :begin //cto.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CTOW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_00111 :begin //ctz.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CTZW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01000 :begin //clo.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CLOD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01001 :begin //clz.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CLZD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01010 :begin //cto.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CTOD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01011 :begin //ctz.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CTZD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01100 :begin //revb.2h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REVB2H;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01101 :begin //revb.4h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REVB4H;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01110 :begin //revb.2w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REVB2W;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_01111 :begin //revb.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REVBD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10000 :begin //revh.2w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REVH2W;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10001 :begin //revh.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_REVHD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10010 :begin //bitrev.4b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BITREV4B;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10011 :begin //bitrev.8b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BITREV8B;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10100 :begin //bitrev.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BITREVW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10101 :begin //bitrev.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BITREVD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10110 :begin //ext.w.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_EXTWH;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_10111 :begin //ext.w.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_EXTWB;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end

    22'b00000000000000000_11000 :begin //rdtimel.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_RDTIMELW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_11001 :begin //rdtimeh.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_RDTIMEHW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000000000000_11010 :begin //rdtime.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_RDTIMED;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    // rd is as src0
    22'b00000000011_?????0_????? :begin //bstrins.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BSTRINSW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000011_?????1_????? :begin //bstrpick.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BSTRPICKW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    // rd is as src0
    22'b0000000010?_??????_????? :begin //bstrins.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BSTRINSD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0000000011?_??????_????? :begin //bstrpick.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BSTRPICKD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    // amo
    22'b00111000011000000_????? :begin //amswap.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMSWAPW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;  
      end
    22'b00111000011000001_????? :begin //amswap.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMSWAPD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;  
      end
    22'b00111000011000010_????? :begin //amadd.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMADDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1; 
      end
    22'b00111000011000011_????? :begin //amadd.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMADDD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011000100_????? :begin //amand.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMANDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011000101_????? :begin //amand.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMANDD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011000110_????? :begin //amor.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMORW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011000111_????? :begin //amor.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMORD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001000_????? :begin //amxor.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMXORW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001001_????? :begin //amxor.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMXORD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001010_????? :begin //ammax.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMAXW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001011_????? :begin //ammax.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMAXD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001100_????? :begin //ammin.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMINW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001101_????? :begin //ammin.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMIND;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001110_????? :begin //ammax.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMAXWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011001111_????? :begin //ammax.du
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMAXDU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011010000_????? :begin //ammin.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMINWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011010001_????? :begin //ammin.du
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_AMMINDU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
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
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LLW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00100010_?????????_????? :begin //ll.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LLD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end

    22'b00100001_?????????_????? :begin //sc.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SCW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00100011_?????????_????? :begin //sc.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SCD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    // load
    22'b00100100?????????_????? :begin //ldptr.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDPTRW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00100101?????????_????? :begin //stptr.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STPTRW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00100110?????????_????? :begin //ldptr.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDPTRD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00100111?????????_????? :begin //stptr.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STPTRD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b0010100000???????_????? :begin //ld.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010100001???????_????? :begin //ld.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010100010???????_????? :begin //ld.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010100011???????_????? :begin //ld.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010100100???????_????? :begin //st.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b0010100101???????_????? :begin //st.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b0010100110???????_????? :begin //st.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b0010100111???????_????? :begin //st.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b0010101000???????_????? :begin //ld.bu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDBU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010101001???????_????? :begin //ld.hu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDHU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010101010???????_????? :begin //ld.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    // BUG preld have bugs
    22'b0010101011???????_????? :begin //preld
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000001011000_????? :begin //preldx
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ADDIW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b0010101100???????_????? :begin //fld.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b0010101101???????_????? :begin //fst.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b0010101110???????_????? :begin //fld.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b0010101111???????_????? :begin //fst.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_imm_vld          = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000001100000_?????: begin //fldx.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDXS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b00111000001101000_?????: begin //fldx.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDXD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b00111000001110000_?????: begin //fstx.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTXS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000001111000_?????: begin //fstx.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTXD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000011101000_?????: begin //fldgt.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDGTS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b00111000011101001_?????: begin //fldgt.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDGTD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b00111000011101010_?????: begin //fldle.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDLES;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b00111000011101011_?????: begin //fldle.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDLED;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dstf_vld              = 1'b1;
      end
    22'b00111000011101100_?????: begin //fstgt.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTGTS;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000011101101_?????: begin //fstgt.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTGTD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000011101110_?????: begin //fstle.s
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTLES;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000011101111_?????: begin //fstle.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_FLSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FSTLED;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_srcf2_vld             = 1'b1;
      end
    22'b00111000000000000_????? :begin //ldx.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000000001000_????? :begin //ldx.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000000010000_????? :begin //ldx.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000000011000_????? :begin //ldx.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000000100000_????? :begin //stx.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STXB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000000101000_????? :begin //stx.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STXH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000000110000_????? :begin //stx.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STXW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000000111000_????? :begin //stx.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STXD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000001000000_????? :begin //ldx.bu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXBU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000001001000_????? :begin //ldx.hu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXHU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000001010000_????? :begin //ldx.wu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDXWU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011110000_????? :begin //ldgt.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDGTB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011110001_????? :begin //ldgt.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDGTH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011110010_????? :begin //ldgt.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDGTW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011110011_????? :begin //ldgt.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDGTD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
    end
    22'b00111000011110100_????? :begin //ldle.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDLEB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011110101_????? :begin //ldle.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDLEH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
    end
    22'b00111000011110110_????? :begin //ldle.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_LDLEW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011110111_????? :begin //ldle.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_FLDLED;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00111000011111000_????? :begin //stgt.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STGTB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111001_????? :begin //stgt.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STGTH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111010_????? :begin //stgt.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STGTW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111011_????? :begin //stgt.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STGTD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111100_????? :begin //stle.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STLEB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111101_????? :begin //stle.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STLEH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111110_????? :begin //stle.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STLEW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00111000011111111_????? :begin //stle.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_LSU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_STLED;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00000000001010100_????? :begin //break
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BREAK;
      end
    22'b00000000001010110_????? :begin //syscall
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_SYSCALL;
      end
    // Branch 
    22'b010110_???????????????? :begin //beq
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BEQ;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b010111_???????????????? :begin //bne
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BNE;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b011000_???????????????? :begin //blt
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BLT;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b011001_???????????????? :begin //bge
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BGE;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b011010_???????????????? :begin //bltu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BLTU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b011011_???????????????? :begin //bgeu
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BGEU;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_src1_vld              = 1'b1;
      end
    22'b010100_???????????????? :begin //b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_B;
      decd_32_src2_imm_vld          = 1'b1;
      end
    22'b010011_???????????????? :begin //jirl
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_JIRL;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b010101_???????????????? :begin //bl 
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BL;
      decd_32_src2_imm_vld          = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b010000_???????????????? :begin //beqz
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BEQZ;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      end
    22'b010001_???????????????? :begin //bnez
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_BNEZ;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_imm_vld          = 1'b1;
      end

    22'b010010_???????????????? :begin //bceqz/bcnez
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_BJU;
      decd_32_func[`FUNC_WIDTH-1:0] = x_inst[8] ? `FUNC_BCNEZ : `FUNC_BCEQZ;
      decd_32_srcc_vld              = 1'b1;
      if (x_inst[9]) begin 
        decd_32_illegal             = 1'b1;
      end
      end
    22'b00111000011100100_????? :begin //dbar
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_DBAR;
      end
    22'b00111000011100101_????? :begin //ibar
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IBAR;
      end
    22'b00000110010010001_????? :begin  // wait
      //deal in fence
      end
    22'b00000110010010000_01110 :begin  // ertn
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_ERTN;
      end
    /// checkpoint restore pc inst
    22'b00000110010010010_????? :begin  // cprs (decode between idle and invtlb)
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CPRS;
      end
    22'b00000100_?????????_????? :begin // csrrd, csrwr, csrxchg
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
        if (x_inst[9:5] == 5'b00000) begin
            decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRRD;
            decd_32_dst0_vld              = 1'b1;
        end else if (x_inst[9:5] == 5'b00001) begin
            decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRWR;
            decd_32_src1_vld              = 1'b1;
            decd_32_dst0_vld              = 1'b1;
        end else begin
            decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CSRXCHG;
            decd_32_src0_vld              = 1'b1;
            decd_32_src1_vld              = 1'b1;
            decd_32_dst0_vld              = 1'b1;
        end
      end
    // TODO: IOCSR
    22'b00000110010010000_00000 :begin  // iocsrrd.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRRDB;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000110010010000_00001 :begin  // iocsrrd.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRRDH;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000110010010000_00010 :begin  // iocsrrd.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRRDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000110010010000_00011 :begin  // iocsrrd.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRRDD;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000110010010000_00100 :begin  // iocsrwr.b
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRWRB;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00000110010010000_00101 :begin  // iocsrwr.h
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRWRH;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00000110010010000_00110 :begin  // iocsrwr.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRWRW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00000110010010000_00111 :begin  // iocsrwr.d
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_IOCSRWRD;
      decd_32_src0_vld              = 1'b1;
      decd_32_src2_vld              = 1'b1;
      end
    22'b00000000000000000_11011 :begin //cpucfg
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CPUCFG;
      decd_32_src0_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end  
    22'b00000110010010011_????? :begin  // invtlb
      //deal in fence
      end
    22'b0000011000???????_????? :begin  // cacop (cache)
      decd_32_src0_vld                  = 1'b1;
      decd_32_src1_imm_vld              = 1'b1;
      if (x_inst[2:0] == 3'b000) begin
          decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
          decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_L1ICACOP;
      end else if (x_inst[2:0] == 3'b001) begin
          decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
          decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_L1DCACOP;
      end else if (x_inst[2:0] == 3'b010) begin
          decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
          decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_L2CACOP;
      end else if (x_inst[2:0] == 3'b011) begin
          decd_32_eu[`EU_WIDTH-1:0]     = `EU_CP0;
          decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_L1ICACOP;
      end
    end
    // crc
    22'b00000000001001000_????? :begin //crc.w.b.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCWBW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001001_????? :begin //crc.w.h.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCWHW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001010_????? :begin //crc.w.w.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCWWW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001011_????? :begin //crc.w.d.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCWDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001100_????? :begin //crcc.w.b.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCCWBW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001101_????? :begin //crcc.w.h.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCCWHW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001110_????? :begin //crcc.w.w.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCCWWW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    22'b00000000001001111_????? :begin //crcc.w.d.w
      decd_32_eu[`EU_WIDTH-1:0]     = `EU_ALU;
      decd_32_func[`FUNC_WIDTH-1:0] = `FUNC_CRCCWDW;
      decd_32_src0_vld              = 1'b1;
      decd_32_src1_vld              = 1'b1;
      decd_32_dst0_vld              = 1'b1;
      end
    default:begin                //invalid instruction
      //deal in fence
      decd_32_illegal            = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @1504
end

//----------------------------------------------------------
//       FP part0 Full Decoder(except fused multiply add)
//----------------------------------------------------------
// &CombBeg; @2155
assign src_reg_is_rd = {x_inst[31:15], x_inst[14:10]} == 22'b0000000100010100101011;
always @( x_inst[14:12]
       or x_inst[31:20])
begin
  //initialize decoded information value
  decd_fp0_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_fp0_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_fp0_dst0_vld              = 1'b0; // write to general reg
  decd_fp0_dstc_vld              = 1'b0; // write to fcc reg
  decd_fp0_dstf_vld              = 1'b0; // write to float reg
  decd_fp0_dste_vld              = 1'b0; // write to fflags reg
  decd_fp0_src0_vld              = 1'b0;
  decd_fp0_src1_vld              = 1'b0;
  decd_fp0_srcf0_vld             = 1'b0;
  decd_fp0_srcf1_vld             = 1'b0;
  decd_fp0_srcc_vld              = 1'b0;
  //illegal instruction
  decd_fp0_illegal               = 1'b0;


 // TODO 实现浮点例外
  casez({x_inst[31:15], x_inst[14:10]})
  22'b0000000100010100100101: begin  // fmov.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_F32_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100100110: begin  // fmov.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_F64_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100101001: begin  // movgr2fr.w
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_F32_SI32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
  end
  22'b0000000100010100101010: begin  // movgr2fr.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_F64_SI64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
  end

  22'b0000000100010100101101: begin  // movfr2gr.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_SI32_F32;
    decd_fp0_dst0_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100101110: begin  // movfr2gr.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_SI64_F64;
    decd_fp0_dst0_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100101011: begin  // movgr2frh.w
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_FH32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
  end
  22'b0000000100010100101111: begin  // movfrh2gr.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_F64_FH32;
    decd_fp0_dst0_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
  end
  22'b0000000100010100110100: begin //movfr2cf
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_SI64_F64;
    decd_fp0_dstc_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100110101: begin //movcf2fr
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_SI64_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcc_vld                     = 1'b1;
    end
  22'b0000000100010100110110: begin //movgr2cf
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_F64_SI64;
    decd_fp0_dstc_vld                     = 1'b1;
    decd_fp0_src0_vld                     = 1'b1;
    end
  22'b0000000100010100110111: begin //movcf2gr
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMV_SI64_F64;
    decd_fp0_dst0_vld                     = 1'b1;
    decd_fp0_srcc_vld                     = 1'b1;
    end
  22'b0000000100010100110000: begin  // movgr2fcsr
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_CP0;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_CSRWR;
    decd_fp0_src0_vld                     = 1'b1;
    decd_fp0_dst0_vld                     = 1'b1;
  end
  22'b0000000100010100110010: begin  // movfcsr2gr
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_CP0;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_CSRRD;
    decd_fp0_dst0_vld                     = 1'b1;
  end
  22'b00000001000000001_?????: begin //fadd.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FADDS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000000010_?????: begin //fadd.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FADDD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000000101_?????: begin //fsub.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSUBS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000000110_?????: begin //fsub.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSUBD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001001_?????: begin //fmul.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMULS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001010_?????: begin //fmul.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMULD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001101_?????: begin //fdiv.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FDSU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FDIVS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000001110_?????: begin //fdiv.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FDSU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FDIVD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010001_?????: begin //fmax.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMAXS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010010_?????: begin //fmax.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMAXD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010101_?????: begin //fmin.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMINS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000010110_?????: begin //fmin.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMIND;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
  end
  22'b00000001000011001_?????: begin //fmaxa.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMAXAS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000011010_?????: begin //fmaxa.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMAXAD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000011101_?????: begin //fmina.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMINAS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000011110_?????: begin //fmina.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FMINAD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100001_?????: begin //fscaleb.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSCALEBS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100010_?????: begin //fscaleb.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSCALEBD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100101_?????: begin //copysign.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSGNJS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b00000001000100110_?????: begin //copysign.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSGNJD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000001: begin //fabs.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSGNJXS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000010: begin //fabs.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSGNJXD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000101: begin //fneg.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSGNJNS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100000110: begin //fneg.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSGNJND;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b0000000100010100001001: begin //flogb.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FLOGS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100001010: begin //flogb.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FLOGD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100001101: begin //fclass.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCLASSS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100001110: begin //fclass.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCLASSD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010001: begin //fsqrt.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FDSU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSQRTS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010010: begin //fsqrt.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FDSU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSQRTD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010101: begin //frecip.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FDSU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FDIVRS;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100010100010110: begin //frecip.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FDSU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FDIVRD;
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
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    case(x_inst[19:15])
    5'b00000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_AF;
    5'b01000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_UN;
    5'b00100: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_EQ;
    5'b01100: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_UEQ;
    5'b00010: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_LT;
    5'b01010: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_ULT;
    5'b00110: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_LE;
    5'b01110: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_ULE;
    5'b10000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_NE;
    5'b10100: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_OR;
    5'b11000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_C_UNE;
    5'b00001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_AF;
    5'b01001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_UN;
    5'b00101: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_EQ;
    5'b01101: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_UEQ;
    5'b00011: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_LT;
    5'b01011: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_ULT;
    5'b00111: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_LE;
    5'b01111: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_ULE;
    5'b10001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_NE;
    5'b10101: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_OR;
    5'b11001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_S_S_UNE;
    default: decd_fp0_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'bx}};
    endcase
    if (x_inst[15]) begin
      decd_fp0_dste_vld                   = 1'b1;
    end
    decd_fp0_dstc_vld                     = 1'b1;
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
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FALU;
    case(x_inst[19:15])
    5'b00000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_AF;
    5'b01000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_UN;
    5'b00100: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_EQ;
    5'b01100: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_UEQ;
    5'b00010: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_LT;
    5'b01010: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_ULT;
    5'b00110: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_LE;
    5'b01110: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_ULE;
    5'b10000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_NE;
    5'b10100: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_OR;
    5'b11000: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_C_UNE;
    5'b00001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_AF;
    5'b01001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_UN;
    5'b00101: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_EQ;
    5'b01101: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_UEQ;
    5'b00011: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_LT;
    5'b01011: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_ULT;
    5'b00111: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_LE;
    5'b01111: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_ULE;
    5'b10001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_NE;
    5'b10101: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_OR;
    5'b11001: decd_fp0_func[`FUNC_WIDTH-1:0] = `FUNC_FCMP_D_S_UNE;
    default: decd_fp0_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'bx}};
    endcase
    decd_fp0_dstc_vld                     = 1'b1;
    if (x_inst[15]) begin
      decd_fp0_dste_vld                   = 1'b1;
    end
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    end
  22'b000011010000_00???_?????: begin // fsel
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FSPU;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FSELD;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b1;
    decd_fp0_srcc_vld                     = 1'b1;
    end  
  22'b0000000100011010000001: begin // ftintrm.w.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010000010: begin // ftintrm.w.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010001001: begin // ftintrm.l.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
     decd_fp0_func[`FUNC_WIDTH-1:0]       = `FUNC_FCVT_SI64_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010001010: begin // ftintrm.l.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end

  22'b0000000100011010010001: begin // ftintrp.w.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010010010: begin // ftintrp.w.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010011001: begin // ftintrp.l.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010011010: begin // ftintrp.l.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010100001: begin // ftintrz.w.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010100010: begin // ftintrz.w.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010101001: begin // ftintrz.l.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010101010: begin // ftintrz.l.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010110001: begin // ftintrne.w.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010110010: begin // ftintrne.w.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010111001: begin // ftintrne.l.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011010111010: begin // ftintrne.l.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011001000110: begin // fcvt.s.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_F32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011001001001: begin // fcvt.d.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_F64_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    decd_fp0_srcf1_vld                    = 1'b0;
    end
  22'b0000000100011101000100: begin // ffint.s.w
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_F32_SI32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011101000110: begin // ffint.s.l
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_F32_SI64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011101001000: begin // ffint.d.w
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_F64_SI32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011101001010: begin // ffint.d.l
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_F64_SI64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011000001: begin // ftint.w.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011000010: begin // ftint.w.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI32_F64;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011001001: begin // ftint.l.s
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F32;
    decd_fp0_dstf_vld                     = 1'b1;
    decd_fp0_dste_vld                     = 1'b1;
    decd_fp0_srcf0_vld                    = 1'b1;
    end
  22'b0000000100011011001010: begin // ftint.l.d
    decd_fp0_eu[`EU_WIDTH-1:0]            = `EU_FCVT;
    decd_fp0_func[`FUNC_WIDTH-1:0]        = `FUNC_FCVT_SI64_F64;
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
// &CombEnd; @2749
end

//----------------------------------------------------------
//       FP part1 Full Decoder(fused multiply add)
//----------------------------------------------------------
// &CombBeg; @2754
always @( x_inst[4:2]
       or x_inst[26:25])
begin
  //initialize decoded information value
  decd_fp1_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_fp1_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_fp1_dst0_vld              = 1'b0;
  decd_fp1_dstc_vld              = 1'b0;
  decd_fp1_dstf_vld              = 1'b0;
  decd_fp1_dste_vld              = 1'b0;
  decd_fp1_src0_vld              = 1'b0;
  decd_fp1_srcf0_vld             = 1'b0;
  decd_fp1_srcf1_vld             = 1'b0;
  decd_fp1_srcf2_vld             = 1'b0;
  //illegal instruction
  decd_fp1_illegal               = 1'b0;

  casez({x_inst[31:20]})
    12'b000010000001: begin //fmadd.s
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FMADDS;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010000010: begin //fmadd.d
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FMADDD;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010000101: begin //fmsub.s
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FMSUBS;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010000110: begin //fmsub.d
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FMSUBD;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001001: begin //fnmadd.s
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FNMADDS;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001010: begin //fnmadd.d
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FNMADDD;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001101: begin //fnmsub.s
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FNMSUBS;
      decd_fp1_dstf_vld                     = 1'b1;
      decd_fp1_dste_vld                     = 1'b1;
      decd_fp1_srcf0_vld                    = 1'b1;
      decd_fp1_srcf1_vld                    = 1'b1;
      decd_fp1_srcf2_vld                    = 1'b1;
      end
    12'b000010001110: begin //fnmsub.d
      decd_fp1_eu[`EU_WIDTH-1:0]            = `EU_FMAU;
      decd_fp1_func[`FUNC_WIDTH-1:0]        = `FUNC_FNMSUBD;
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
// &CombEnd; @2883
end

assign decd_fp0_sel = !decd_fp1_sel;
assign decd_fp1_sel = x_inst[31:24] == 8'b00001000;

// &CombBeg; @2888
always @( decd_fp1_eu[9:0]
       or decd_fp0_dst0_vld
       or decd_fp0_dstc_vld
       or decd_fp1_sel
       or decd_fp0_src1_vld
       or decd_fp0_srcf1_vld
       or decd_fp0_src0_vld
       or decd_fp0_func[19:0]
       or decd_fp0_illegal
       or decd_fp0_sel
       or decd_fp1_func[19:0]
       or decd_fp1_dste_vld
       or decd_fp1_illegal
       or decd_fp1_srcf2_vld
       or decd_fp0_dstf_vld
       or decd_fp1_dstf_vld
       or decd_fp0_srcf0_vld
       or decd_fp1_srcf1_vld
       or decd_fp0_eu[9:0]
       or decd_fp1_src0_vld
       or decd_fp1_dst0_vld
       or decd_fp1_dstc_vld
       or decd_fp0_dste_vld
       or decd_fp1_srcf0_vld)
begin
  case({decd_fp1_sel,decd_fp0_sel})
    2'h1: begin
      decd_fp_eu[`EU_WIDTH-1:0]     = decd_fp0_eu[`EU_WIDTH-1:0];
      decd_fp_func[`FUNC_WIDTH-1:0] = decd_fp0_func[`FUNC_WIDTH-1:0];
      decd_fp_dst0_vld              = decd_fp0_dst0_vld;
      decd_fp_dstc_vld              = decd_fp0_dstc_vld;
      decd_fp_dstf_vld              = decd_fp0_dstf_vld;
      decd_fp_dste_vld              = decd_fp0_dste_vld;
      decd_fp_src0_vld              = decd_fp0_src0_vld;
      decd_fp_src1_vld              = 1'b0;
      decd_fp_srcf0_vld             = decd_fp0_srcf0_vld;
      decd_fp_srcf1_vld             = decd_fp0_srcf1_vld;
      decd_fp_srcf2_vld             = 1'b0;
      decd_fp_inst_illegal          = decd_fp0_illegal;
    end
    2'h2: begin
      decd_fp_eu[`EU_WIDTH-1:0]     = decd_fp1_eu[`EU_WIDTH-1:0];
      decd_fp_func[`FUNC_WIDTH-1:0] = decd_fp1_func[`FUNC_WIDTH-1:0];
      decd_fp_dst0_vld              = decd_fp1_dst0_vld;
      decd_fp_dstc_vld              = decd_fp1_dstc_vld;
      decd_fp_dstf_vld              = decd_fp1_dstf_vld;
      decd_fp_dste_vld              = decd_fp1_dste_vld;
      decd_fp_src0_vld              = decd_fp1_src0_vld;
      decd_fp_src1_vld              = 1'b0;
      decd_fp_srcf0_vld             = decd_fp1_srcf0_vld;
      decd_fp_srcf1_vld             = decd_fp1_srcf1_vld;
      decd_fp_srcf2_vld             = decd_fp1_srcf2_vld;
      decd_fp_inst_illegal          = decd_fp1_illegal;
    end
    default: begin
      decd_fp_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'bx}};
      decd_fp_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'bx}};
      decd_fp_dst0_vld              = 1'bx;
      decd_fp_dstc_vld              = 1'bx;
      decd_fp_dstf_vld              = 1'bx;
      decd_fp_dste_vld              = 1'bx;
      decd_fp_src0_vld              = 1'bx;
      decd_fp_src1_vld              = 1'bx;
      decd_fp_srcf0_vld             = 1'bx;
      decd_fp_srcf1_vld             = 1'bx;
      decd_fp_srcf2_vld             = 1'bx;
      decd_fp_inst_illegal          = 1'bx;
    end
  endcase
// &CombEnd; @2930
end

//----------------------------------------------------------
//              Cache Extension Full Decoder
//----------------------------------------------------------
// &CombBeg; @2935
always @( cp0_idu_ucme
       or cp0_yy_priv_mode[1:0]
       or rtu_yy_xx_dbgon
       or x_inst[25:15])
begin
  //initialize decoded information value
  decd_cache_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_cache_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_cache_src0_vld              = 1'b0;
  //illegal instruction
  decd_cache_illegal               = 1'b0;

  casez({x_inst[25],x_inst[24:20],x_inst[19:15]})
    // TODO:
    default: begin                //invalid instruction
      //deal in fence
      decd_cache_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @3102
end

//----------------------------------------------------------
//           Performance Extension Full Decoder
//----------------------------------------------------------
// &CombBeg; @3107
always @( x_inst[14:12]
       or x_inst[31:25])
begin
  //initialize decoded information value
  decd_perf_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_perf_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_perf_src0_vld              = 1'b0;
  decd_perf_src1_vld              = 1'b0;
  decd_perf_src1_imm_vld          = 1'b0;
  decd_perf_src2_vld              = 1'b0;
  decd_perf_src2_imm_vld          = 1'b0;
  decd_perf_dst0_vld              = 1'b0;
  decd_perf_dst1_vld              = 1'b0;
  decd_perf_srcf1_vld             = 1'b0;
  decd_perf_srcf2_vld             = 1'b0;
  decd_perf_dstf_vld              = 1'b0;
  //illegal instruction
  decd_perf_illegal               = 1'b0;

  casez({x_inst[31:25],x_inst[14:12]})
    //32-bits instructions decode logic
    // TODO:
    default: begin                //invalid instruction
      //deal in fence
      decd_perf_illegal               = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @3673
end


//==========================================================
//                 Vector inst info
//==========================================================
assign decd_vec_inst = 1'b0;
assign decd_vec_opivv = (x_inst[14:12] == 3'b000);
assign decd_vec_opivx = (x_inst[14:12] == 3'b100);
assign decd_vec_opivi = (x_inst[14:12] == 3'b011);
assign decd_vec_opmvv = (x_inst[14:12] == 3'b010);
assign decd_vec_opmvx = (x_inst[14:12] == 3'b110);
assign decd_vec_opfvv = (x_inst[14:12] == 3'b001);
assign decd_vec_opfvf = (x_inst[14:12] == 3'b101);
assign decd_vec_opcfg = (x_inst[14:12] == 3'b111);
assign decd_vec_opiv  = decd_vec_opivv || decd_vec_opivx || decd_vec_opivi;
assign decd_vec_opmv  = decd_vec_opmvv || decd_vec_opmvx;
assign decd_vec_opfv  = decd_vec_opfvv || decd_vec_opfvf;
assign decd_vec_opvx  = decd_vec_opivx || decd_vec_opmvx;

assign decd_inst_vec = decd_vec_inst;

assign decd_vec_ls_func[3:0]      = {x_inst[25],x_inst[31:29]} & {4{decd_inst_vls}};
assign decd_vec_special_func[4:0] = {x_inst[25],      //vm
                                     decd_vec_opvx,   //vx
                                     decd_vec_opivi,  //vi
                                     decd_vec_opfvf,  //vf
                                     decd_srcv0_srcv1_switch}; //reverse

assign vec_mfvr_inst = (x_inst[31:26] == 6'b001100) && decd_vec_opmvv ||  //vext.x.v
                       (x_inst[31:26] == 6'b010100) && decd_vec_opmvv ||  //vmpopc
                       (x_inst[31:26] == 6'b010101) && decd_vec_opmvv ||  //vmfirst
                       (x_inst[31:26] == 6'b001100) && decd_vec_opfvv;    //vfmv.f.s

//==========================================================
//       Decode Vector Source Register Index(Including FP)
//==========================================================
//----------------------------------------------------------
//               Vector Source Register Index
//----------------------------------------------------------
// &CombBeg; @3717
always @( x_decd_srcf0_reg[4:0]
       or decd_inst_vec
       or decd_srcv0_srcv1_switch
       or x_inst[24:15])
begin
casez({decd_inst_vec,decd_srcv0_srcv1_switch})
  2'b0?  : x_decd_srcv0_reg[4:0] = x_decd_srcf0_reg[4:0];
  2'b10  : x_decd_srcv0_reg[4:0] = x_inst[24:20];
  2'b11  : x_decd_srcv0_reg[4:0] = x_inst[19:15];
  default: x_decd_srcv0_reg[4:0] = {5{1'bx}};
endcase
// &CombEnd; @3724
end


// &CombBeg; @3727
always @( x_decd_srcf1_reg[4:0]
       or decd_vec_lsu
       or x_inst[11:7]
       or x_vlmul[1:0]
       or decd_inst_vec
       or decd_srcv1_srcv2_switch
       or decd_srcv0_srcv1_switch
       or x_inst[24:15])
begin
casez({decd_vec_lsu,decd_inst_vec,decd_srcv0_srcv1_switch,decd_srcv1_srcv2_switch})
  4'b1??? : x_decd_srcv1_reg[4:0] = x_inst[11:7] + (5'b00001 << x_vlmul[1:0]); 
  4'b00?? : x_decd_srcv1_reg[4:0] = x_decd_srcf1_reg[4:0];
  4'b0100 : x_decd_srcv1_reg[4:0] = x_inst[19:15];
  4'b0101 : x_decd_srcv1_reg[4:0] = x_inst[11:7];
  4'b0110 : x_decd_srcv1_reg[4:0] = x_inst[24:20];
  4'b0111 : x_decd_srcv1_reg[4:0] = x_inst[11:7];
   default: x_decd_srcv1_reg[4:0] = {5{1'bx}};
endcase
// &CombEnd; @3737
end

// &CombBeg; @3739
always @( x_decd_srcf2_reg[4:0]
       or x_inst[11:7]
       or decd_inst_vec
       or decd_srcv1_srcv2_switch
       or decd_srcv0_srcv1_switch
       or x_inst[24:15])
begin
casez({decd_inst_vec,decd_srcv0_srcv1_switch,decd_srcv1_srcv2_switch})
  3'b0??  : x_decd_srcv2_reg[4:0] = x_decd_srcf2_reg[4:0];
  3'b100  : x_decd_srcv2_reg[4:0] = x_inst[11:7];
  3'b101  : x_decd_srcv2_reg[4:0] = x_inst[19:15];
  3'b110  : x_decd_srcv2_reg[4:0] = x_inst[11:7];
  3'b111  : x_decd_srcv2_reg[4:0] = x_inst[24:20];
  default: x_decd_srcv2_reg[4:0] = {5{1'bx}};
endcase
// &CombEnd; @3748
end

assign decd_srcv0_srcv1_switch = ((x_inst[31:26]==6'b000010)                    //vsub
                              || (x_inst[31:26]==6'b010010)                     //vsbc
                              || (x_inst[31:26]==6'b010011)                     //vmsbc
                              || (x_inst[31:26]==6'b011010)                     //vmsltu
                              || (x_inst[31:26]==6'b011011)                     //vmslt
                              || (x_inst[31:26]==6'b100010)                     //vssubu
                              || (x_inst[31:26]==6'b100011)                     //vssub
                              || (x_inst[31:26]==6'b100110))&& decd_vec_opiv    //vasub
                              ||((x_inst[31:26]==6'b101001)                     //vmadd
                              || (x_inst[31:26]==6'b101011)                     //vmsub
                              || (x_inst[31:26]==6'b110010)                     //vwsubu
                              || (x_inst[31:26]==6'b110011)                     //vwsub
                              || (x_inst[31:26]==6'b110110)                     //vwsubu.w
                              || (x_inst[31:26]==6'b110111))&& decd_vec_opmv    //vwsub.w
                              ||((x_inst[31:29]==3'b101   )                     //vfmacc
                              || (x_inst[31:28]==4'b1111  )                     //vfwmacc
                              || (x_inst[31:26]== 6'b100111))&& decd_vec_opfv   //vfrsub 
                              ||((x_inst[31:26]==6'b011101)                     //vmfgt
                              || (x_inst[31:26]==6'b011111)                     //vmfge
                              || (x_inst[31:26]== 6'b100001))&& decd_vec_opfvf  //vrfdiv
                              ||((x_inst[31:26]== 6'b110001)
                              || (x_inst[31:26]== 6'b110011))&& decd_vec_opfvv;

assign decd_srcv1_srcv2_switch = ((x_inst[31:26]== 6'b101001)
                               || (x_inst[31:26]== 6'b101011))&& decd_vec_opmv    
                               || (x_inst[31:28]== 4'b1010) && decd_vec_opfv
                               || (x_inst[31:27]== 5'b11000) && decd_vec_opivv//vwred 
                               || (x_inst[31:29]== 3'b000) && decd_vec_opmvv; //vred

//==========================================================
//            Decode Destination Register Index
//==========================================================
//same like instruction type, the register index has been
//optimazied for timing by ignoring invalid instructions
//so add new instruction should carefully check these logic
assign x_decd_dstv_reg[4:0]   = (decd_inst_vec) ? x_inst[11:7] : x_decd_dstf_reg[4:0];

//==========================================================
//                 Illegal inst Decoder
//==========================================================
assign decd_vec_vmunary0   =(x_inst[31:26]==6'b010110);
assign decd_vec_vfunary0   =(x_inst[31:26]==6'b100010);
assign decd_vec_vfunary1   =(x_inst[31:26]==6'b100011);

assign decd_vmunary0_vld = (x_inst[19:15] == 5'b00001) //vmbf
                      ||(x_inst[19:15] == 5'b00010) //vmif
                      ||(x_inst[19:15] == 5'b00011) //vmof
                      ||(x_inst[19:15] == 5'b10000) //viota
                      ||(x_inst[19:15] == 5'b10001);//vid

assign decd_vfunary0_vld_norm = (x_inst[19:17] == 3'b000);

assign decd_vfunary0_vld_wide = (x_inst[19:17] == 3'b010) 
                           ||(x_inst[19:15] == 5'b01100);

assign decd_vfunary0_vld_narr = (x_inst[19:17] == 3'b100) 
                           ||(x_inst[19:15] == 5'b10100);

assign decd_vfunary0_vld = decd_vfunary0_vld_norm || decd_vfunary0_vld_wide || decd_vfunary0_vld_narr;

assign decd_vec_inst_funary=(decd_vec_vfunary0 || decd_vec_vfunary1) && decd_vec_opfvv;

assign decd_vec_inst_narr  =(x_inst[31:28]==4'b1011) && (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi) //narrow shift
                      ||  decd_vec_vfunary0 && x_inst[19] && (decd_vec_opfvv);     //narrow fcvt

assign decd_vec_inst_wide_w=(x_inst[31:28]==4'b1101)                    //.w wide
                      && (decd_vec_opmvv || decd_vec_opmvx || decd_vec_opfvv || decd_vec_opfvf);

assign decd_vec_inst_wide  =(x_inst[31:30]==2'b11)                     //widen inst
                      && (decd_vec_opivv || decd_vec_opivx || decd_vec_opmvv 
                       || decd_vec_opmvx || decd_vec_opfvv || decd_vec_opfvf) 
                       || decd_vec_vfunary0 && (x_inst[19:18]==2'b01)  //widen fcnvt           
                      && (decd_vec_opfvv);

assign decd_vec_inst_mask  = (x_inst[31:30]==2'b01) && (decd_vec_opmvv);

assign decd_vec_inst_scalar= (x_inst[31:27]==5'b00110)
                       && (decd_vec_opmvv || decd_vec_opmvx || decd_vec_opfvv || decd_vec_opfvf);

assign decd_vec_inst_vred_n = (x_inst[31:29]==3'b000) && (decd_vec_opmvv)
                        || (x_inst[31:29]==3'b000) && x_inst[26] && (decd_vec_opfvv);

assign decd_vec_inst_vred_w = (x_inst[31:28]==4'b1100)&& (decd_vec_opivv)
                        || (x_inst[31:28]==4'b1100) && x_inst[26] && (decd_vec_opfvv);

assign decd_vec_inst_vred   = decd_vec_inst_vred_n || decd_vec_inst_vred_w;

assign decd_vec_inst_comp = (x_inst[31:28]==4'b0100) && x_inst[26]
                      && (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi)
                      || (x_inst[31:29]==3'b011) 
                      && (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi
                      ||  decd_vec_opfvv || decd_vec_opfvf); 
//----------------------------------------------------------
//              SRCV0 VREG ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_vreg_src0_norm  = !decd_vec_inst_narr && !decd_vec_inst_wide_w
                        &&!(decd_vec_inst_mask && !(x_inst[29:26]==4'b0111)) //not compress inst 
                        && !decd_vec_inst_scalar;

assign decd_vreg_illegal_type[0]= decd_vec_inst_narr   && decd_vreg_ill[3] 
                       || decd_vec_inst_wide_w && decd_vreg_ill[3]
                       || decd_vreg_src0_norm  && decd_vreg_ill[0];

//----------------------------------------------------------
//              SRCV1 VREG ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_vreg_src1_norm  = !decd_vec_inst_mask && !decd_vec_inst_vred
                        && !decd_vec_inst_scalar && !decd_vec_inst_funary
                        &&!(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx || decd_vec_opfvf);

assign decd_vreg_illegal_type[1] = decd_vreg_src1_norm && decd_vreg_ill[1];

//----------------------------------------------------------
//              DSTV VREG ILLEGAL JUDGE
//----------------------------------------------------------

assign decd_vreg_dst_norm = !decd_vec_inst_vred &&!decd_vec_inst_wide
                      &&(!decd_vec_inst_mask || decd_vec_inst_vcompress 
                       || decd_vec_inst_viota|| decd_vec_inst_vid)
                      && !decd_vec_inst_scalar
                      && !decd_vec_inst_comp;

assign decd_vreg_illegal_type[2]= decd_vec_inst_wide && !decd_vec_inst_vred_w && decd_vreg_ill[4]
                        ||decd_vreg_dst_norm && decd_vreg_ill[2];

assign decd_vreg_illegal = (|decd_vreg_illegal_type[2:0]) && !decd_vec_opcfg;
//----------------------------------------------------------
//               Vreg illegal corncerning LMUL
//----------------------------------------------------------
assign decd_vreg_ill[0] = (x_vlmul[1:0]==2'b01) &&  x_inst[20]    ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[21:20] ||
                       (x_vlmul[1:0]==2'b11) && |x_inst[22:20];  //normal src0 vreg misalgin

assign decd_vreg_ill[1] = (x_vlmul[1:0]==2'b01) &&  x_inst[15]    ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[16:15] ||
                       (x_vlmul[1:0]==2'b11) && |x_inst[17:15];  //normal src1 vreg misalgin

assign decd_vreg_ill[2] = (x_vlmul[1:0]==2'b01) &&  x_inst[7]     ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[8 : 7] ||
                       (x_vlmul[1:0]==2'b11) && |x_inst[9 : 7];  //normal dest vreg misalgin

assign decd_vreg_ill[3] = (x_vlmul[1:0]==2'b00) &&  x_inst[20]    ||
                       (x_vlmul[1:0]==2'b01) && |x_inst[21:20] ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[22:20];  //widen/narrow src0 vreg misalgin

assign decd_vreg_ill[4] = (x_vlmul[1:0]==2'b00) &&  x_inst[7]     ||
                       (x_vlmul[1:0]==2'b01) && |x_inst[8 : 7] ||
                       (x_vlmul[1:0]==2'b10) && |x_inst[9 : 7];  //widen/narrow dest vreg misalgin


assign decd_vec_inst_viota     = decd_vec_vmunary0 && decd_vec_opmvv && (x_inst[19:15]==5'b10000);
assign decd_vec_inst_vid       = decd_vec_vmunary0 && decd_vec_opmvv && (x_inst[19:15]==5'b10001);
assign decd_vec_inst_vcompress =(x_inst[31:26]==6'b010111) && decd_vec_opmvv;
assign decd_vec_inst_slideup   =(x_inst[31:26]==6'b001110) &&(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx);
assign decd_vec_inst_slidedown =(x_inst[31:26]==6'b001111) &&(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx);
assign decd_vec_inst_vrgather  =(x_inst[31:26]==6'b001100) &&(decd_vec_opivv || decd_vec_opivx || decd_vec_opivi);
assign decd_vec_inst_adc       =(x_inst[31:28]==4'b0100  ) &&(decd_vec_opivv || decd_vec_opivx || decd_vec_opivi);
//----------------------------------------------------------
//              SRCV0 OVERLAP ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_ovlp_illegal_type[0]= decd_vec_inst_narr  && decd_ovlp_ill[0] 
                       || decd_vec_inst_wide  && !decd_vec_inst_wide_w && !decd_vec_inst_vred && decd_ovlp_ill[0]
                       || decd_vec_inst_comp  && decd_ovlp_ill[2]
                       ||(decd_vec_inst_viota || decd_vec_inst_slideup 
                       || decd_vec_inst_vcompress|| decd_vec_inst_vrgather) && decd_ovlp_ill[4]; 

//----------------------------------------------------------
//              SRCV1 OVERLAP ILLEGAL JUDGE
//----------------------------------------------------------
assign decd_ovlp_illegal_type[1] =(decd_vec_inst_wide  && !decd_vec_inst_vred && !(decd_vec_vfunary0 && decd_vec_opfvv) && decd_ovlp_ill[1]
                        || decd_vec_inst_comp  && decd_ovlp_ill[3]
                        ||(decd_vec_inst_vcompress|| decd_vec_inst_vrgather) && decd_ovlp_ill[5])
                        &&!(decd_vec_opivx || decd_vec_opivi || decd_vec_opmvx || decd_vec_opfvf);

//----------------------------------------------------------
//              SRCVM OVERLAP ILLEGAL JUDGE
//----------------------------------------------------------

assign decd_ovlp_illegal_type[2]= decd_vec_inst_adc  &&  decd_ovlp_ill[6]
                       || decd_vec_inst_wide && !decd_vec_inst_vred && decd_ovlp_ill[7]
                       ||(decd_vec_inst_viota || decd_vec_inst_slideup 
                       || decd_vec_inst_slidedown || decd_vec_inst_vrgather) && decd_ovlp_ill[7]
                       || decd_vec_inst_vid  &&  decd_ovlp_ill[8]
                       || decd_ovlp_ill[8] && !decd_vec_opcfg && !decd_vec_inst_mask;

assign decd_ovlp_illegal = |decd_ovlp_illegal_type[2:0];

//----------------------------------------------------------
//               VREG ovrelap illegal
//----------------------------------------------------------
assign decd_ovlp_ill[0] = (x_vlmul[1:0]==2'b00) && (x_inst[24:21]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b01) && (x_inst[24:22]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[24:23]==x_inst[11:10]); //vsrc0 overlap with dest when narrow/widen

assign decd_ovlp_ill[1] = (x_vlmul[1:0]==2'b00) && (x_inst[19:16]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b01) && (x_inst[19:17]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[19:18]==x_inst[11:10]); //vsrc1 overlap with dest when narrow/widen

assign decd_ovlp_ill[2]  =(x_vlmul[1:0]==2'b01) && (x_inst[24:21]==x_inst[11: 8]) || //vsrc0 overlap width dest when lmul>1
                          (x_vlmul[1:0]==2'b10) && (x_inst[24:22]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[24:23]==x_inst[11:10]);

assign decd_ovlp_ill[3]  =(x_vlmul[1:0]==2'b01) && (x_inst[19:16]==x_inst[11: 8]) || //vsrc1 overlap width dest when lmul>1
                          (x_vlmul[1:0]==2'b10) && (x_inst[19:17]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[19:18]==x_inst[11:10]);

assign decd_ovlp_ill[4] = (x_vlmul[1:0]==2'b00) && (x_inst[24:20]==x_inst[11: 7]) || //vsrc0 overlap with dest in all case
                          (x_vlmul[1:0]==2'b01) && (x_inst[24:21]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[24:22]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[24:23]==x_inst[11:10]);

assign decd_ovlp_ill[5] = (x_vlmul[1:0]==2'b00) && (x_inst[19:15]==x_inst[11: 7]) || //vsrc1 overlap with dest in all case
                          (x_vlmul[1:0]==2'b01) && (x_inst[19:16]==x_inst[11: 8]) ||
                          (x_vlmul[1:0]==2'b10) && (x_inst[19:17]==x_inst[11: 9]) ||
                          (x_vlmul[1:0]==2'b11) && (x_inst[19:18]==x_inst[11:10]);

assign decd_ovlp_ill[6]  =(x_inst[11: 7]==5'b0) && !(x_vlmul[1:0]==2'b00);//src3 overlap with dest when LMUL>1
assign decd_ovlp_ill[7]  =(x_inst[11: 7]==5'b0) && !x_inst[25]; //src3 overlap with dest when masked
assign decd_ovlp_ill[8]  =(x_inst[11: 7]==5'b0) && !x_inst[25] && !(x_vlmul[1:0]==2'b00); //src3 overlap with dest when masked and LMUL>1

//----------------------------------------------------------
//               LMUL/SEW illegal for widen and narrow
//----------------------------------------------------------
assign decd_size_ill_case[0] = ((x_vlmul[1:0]==2'b11)||(x_vsew[1]==1'b1))
                           && decd_vec_inst_narr || fcvt_f_x_narrow_il; 

assign decd_size_ill_case[1] = ((x_vlmul[1:0]==2'b11)||(x_vsew[1]==1'b1)) 
                           && decd_vec_inst_wide && !decd_vec_inst_vred_w;

assign decd_size_ill_case[2] = ((x_vsew[1:0]==2'b11)||(x_vsew[1:0]==2'b10))
                           && decd_vec_inst_vred_w; 

assign decd_size_ill_case[3] = (x_vsew[1:0]==2'b00) && (decd_vec_opfvv&&!fcvt_f_x_widden || decd_vec_opfvf) || (x_vsew[1:0]== 2'b11);
assign fcvt_f_x_widden       = (x_inst[31:26] == 6'b100010) && ((x_inst[18])&&(x_inst[16]) ||
                                ((x_inst[19] && ~|x_inst[17:16])));
assign fcvt_f_x_narrow_il    = decd_vec_opfvv && (x_inst[31:26] == 6'b100010) && (x_inst[19]) && (x_vsew[1:0]==2'b00)&&(|x_inst[17:16]);
assign decd_size_illegal = |decd_size_ill_case[3:0];
//----------------------------------------------------------
//               vstart illegal for normal inst
//----------------------------------------------------------
assign decd_start_illegal = |cp0_idu_vstart[6:0] && !decd_vec_opcfg;

assign decd_vill_illegal  = cp0_idu_vill &&  !decd_vec_opcfg;  //VLSU inst should also consider this

assign decd_vs_illegal = (cp0_idu_vs[1:0]==2'b0);

assign decd_vec_inst_ac_fcsr =((x_inst[31:28]==4'b1000) //vsaddu vsadd vssubu vssub
                          ||(x_inst[31:28]==4'b1001) && !(x_inst[27:26]==2'b01)  //vaadd vasub vsmul
                          ||(x_inst[31:27]==5'b10101)  //vssrl vssra
                          ||(x_inst[31:27]==5'b10111)  //vnclip vnclipu
                          ||(x_inst[31:28]==4'b1111))  //vwsmaccu vwsmacc vwsmaccsu vwsmaccus
                          &&(decd_vec_opivv || decd_vec_opivx || decd_vec_opivi);

assign decd_vec_fp_ac_fcsr   = decd_vec_opfvf 
                         || ((x_inst[31:29] == 3'b000) //vfadd vfsub 
                             || (x_inst[31:30] == 2'b11) //vfwadd vfwsub vfwmul vfwmacc...
                             || (x_inst[31:28] == 4'b1001) //vfmul
                             || (x_inst[31:27] == 5'b10000) //vfdiv vfrdiv
                             || (x_inst[31:29] == 3'b101)   //vfmacc...
                             || (x_inst[31:29] == 3'b011)   //vfeq...
                             || (x_inst[31:26] == 6'b100011) && !x_inst[19] //vfsqrt
                             || (x_inst[31:26] == 6'b100010) //vfcvt
                             || (x_inst[31:27] == 5'b00110)) //vfmv
                            && decd_vec_opfvv;

assign decd_fs_illegal = (cp0_idu_fs[1:0]==2'b0) 
                      && (decd_vec_inst_ac_fcsr
                          || decd_vec_fp_ac_fcsr);

assign decd_fp_rounding_illegal = ((cp0_idu_frm[2:0] == 3'b101) ||
                                   (cp0_idu_frm[2:0] == 3'b110) ||
                                   (cp0_idu_frm[2:0] == 3'b111))
                               && (decd_vec_opfvv || decd_vec_opfvf);   
//----------------------------------------------------------
//               ALL type of VECTOR illegal instructions
//----------------------------------------------------------
assign decd_v_illegal = decd_code_illegal || decd_vreg_illegal ||
                        decd_ovlp_illegal || decd_size_illegal ||
                        decd_start_illegal|| decd_vill_illegal ||
                        decd_vs_illegal   || decd_fs_illegal   ||
                        decd_fp_rounding_illegal;

//----------------------------------------------------------
//                Decode vec mask Instruction
//----------------------------------------------------------
assign x_decd_srcvm_vld = decd_vec_inst &&  !x_inst[25] && !decd_vec_opcfg ||
                     decd_vec_inst &&  (x_inst[31:28]==4'b0100) &&  //vadc/vmadc/vsbc/vmsbc
                     (decd_vec_opivv || decd_vec_opivx || decd_vec_opivi) ||
                    ((x_inst[6:0]== 7'b0000111) || (x_inst[6:0]== 7'b0100111))  //vld/vst
                     && !x_inst[25] && ( (x_inst[14:12]==3'b000) || x_inst[14] && |x_inst[13:12]);

//----------------------------------------------------------
//                    Decode for vfcvt
//----------------------------------------------------------
assign vfcvt_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{(x_inst[19:15] == 5'b00000)}} & `FUNC_VFCVTXUF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b00001)}} & `FUNC_VFCVTXF   |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b00010)}} & `FUNC_VFCVTFXU  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b00011)}} & `FUNC_VFCVTFX   |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01000)}} & `FUNC_VFWCVTXUF |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01001)}} & `FUNC_VFWCVTXF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01010)}} & `FUNC_VFWCVTFXU |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01011)}} & `FUNC_VFWCVTFX  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b01100)}} & `FUNC_VFWCVTFF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10000)}} & `FUNC_VFNCVTXUF |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10001)}} & `FUNC_VFNCVTXF  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10010)}} & `FUNC_VFNCVTFXU |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10011)}} & `FUNC_VFNCVTFX  |
                                     {`FUNC_WIDTH{(x_inst[19:15] == 5'b10100)}} & `FUNC_VFNCVTFF;

//----------------------------------------------------------
//                  Vector Full Decoder
//----------------------------------------------------------
// &CombBeg; @4079
always @( x_inst[31:19]
       or x_vsew[1:0]
       or decd_vfunary0_vld
       or x_vlmul[1:0]
       or x_inst[19:12]
       or decd_vmunary0_vld
       or vfcvt_func[19:0])
begin
  //initialize decoded information value
  decd_v_eu[`EU_WIDTH-1:0]     = {`EU_WIDTH{1'b0}};
  decd_v_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
  //operand prepare information: valid, and types
  decd_v_src0_vld              = 1'b0;
  decd_v_src1_vld              = 1'b0;
  decd_v_src2_vld              = 1'b0;
  decd_v_dst0_vld              = 1'b0;
  decd_v_srcf0_vld             = 1'b0;
  decd_v_srcf1_vld             = 1'b0;
  decd_v_srcf2_vld             = 1'b0;
  decd_v_dstf_vld              = 1'b0;
  decd_v_dste_vld              = 1'b0;
  decd_v_srcv0_vld             = 1'b0;
  decd_v_srcv1_vld             = 1'b0;
  decd_v_srcv2_vld             = 1'b0;
  decd_v_dstv_vld              = 1'b0;
  decd_v_dstv_late_vld         = 1'b0;
  //illegal instruction
  decd_code_illegal            = 1'b0;
  casez({x_inst[31:26],x_inst[14:12]})
    // TODO:
    default: begin                //invalid instruction
      //deal in fence
      decd_code_illegal            = 1'b1;  //invalid instruction exception
    end
  endcase
// &CombEnd; @6545
end


//when vl is 0, signal dp to mask decoded inst into nop
//assign decd_vec_nop = (cp0_idu_vl[7:0]==8'b0) && !decd_vec_opcfg && !vec_mfvr_inst;
assign decd_vec_nop = (cp0_idu_vl_zero) && !decd_vec_opcfg && !vec_mfvr_inst;

// &CombBeg; @6552
always @( decd_v_illegal
       or decd_vec_nop
       or decd_v_eu[9:0]
       or decd_v_srcv0_vld
       or decd_v_src2_vld
       or decd_v_dstv_vld
       or decd_v_dste_vld
       or decd_v_srcf1_vld
       or decd_v_srcv2_vld
       or decd_v_func[19:0]
       or decd_v_dstv_late_vld
       or decd_v_srcf2_vld
       or decd_v_dstf_vld
       or decd_v_src1_vld
       or decd_v_src0_vld
       or decd_v_srcf0_vld
       or decd_v_dst0_vld
       or decd_v_srcv1_vld)
begin
  if(decd_vec_nop) begin
    //initialize decoded information value
    decd_vec_eu[`EU_WIDTH-1:0]     = `EU_CP0;
    decd_vec_func[`FUNC_WIDTH-1:0] = {`FUNC_WIDTH{1'b0}};
    //operand prepare information: valid, and types
    decd_vec_src0_vld              = decd_v_src0_vld;
    decd_vec_src1_vld              = decd_v_src1_vld;
    decd_vec_src2_vld              = decd_v_src2_vld;
    decd_vec_dst0_vld              = decd_v_dst0_vld;
    decd_vec_srcf0_vld             = decd_v_srcf0_vld;
    decd_vec_srcf1_vld             = decd_v_srcf1_vld;
    decd_vec_srcf2_vld             = decd_v_srcf2_vld;
    decd_vec_dstf_vld              = decd_v_dstf_vld;
    decd_vec_dste_vld              = decd_v_dste_vld;
    decd_vec_srcv0_vld             = decd_v_srcv0_vld;
    decd_vec_srcv1_vld             = decd_v_srcv1_vld;
    decd_vec_srcv2_vld             = decd_v_srcv2_vld;
    decd_vec_dstv_vld              = decd_v_dstv_vld;
    decd_vec_dstv_late_vld         = decd_v_dstv_late_vld;
    //illegal instruction
    decd_vec_illegal               = decd_v_illegal;
  end
  else begin
    decd_vec_eu[`EU_WIDTH-1:0]     = decd_v_eu[`EU_WIDTH-1:0];
    decd_vec_func[`FUNC_WIDTH-1:0] = decd_v_func[`FUNC_WIDTH-1:0];
    //operand prepare information: valid, and types
    decd_vec_src0_vld              = decd_v_src0_vld;
    decd_vec_src1_vld              = decd_v_src1_vld;
    decd_vec_src2_vld              = decd_v_src2_vld;
    decd_vec_dst0_vld              = decd_v_dst0_vld;
    decd_vec_srcf0_vld             = decd_v_srcf0_vld;
    decd_vec_srcf1_vld             = decd_v_srcf1_vld;
    decd_vec_srcf2_vld             = decd_v_srcf2_vld;
    decd_vec_dstf_vld              = decd_v_dstf_vld;
    decd_vec_dste_vld              = decd_v_dste_vld;
    decd_vec_srcv0_vld             = decd_v_srcv0_vld;
    decd_vec_srcv1_vld             = decd_v_srcv1_vld;
    decd_vec_srcv2_vld             = decd_v_srcv2_vld;
    decd_vec_dstv_vld              = decd_v_dstv_vld;
    decd_vec_dstv_late_vld         = decd_v_dstv_late_vld;
    //illegal instruction
    decd_vec_illegal               = decd_v_illegal;
  end
// &CombEnd; @6596
end


//================================================
//        assertion
//================================================
// &Force("nonport","flag"); @6612
// &Force("nonport","clk"); @6613
// &Force("nonport","rst"); @6614
// &Force("input","forever_cpuclk"); @6654
// &Force("input","ctrl_dis_inst_vld"); @6655
// &Force("input","ctrl_dp_ex1_stall"); @6656
// &Force("input","split_dp_inst_sel"); @6657
// &Force("input","ifu_idu_id_expt_acc_error"); @6658
// &Force("input","ifu_idu_id_expt_page_fault"); @6659
// &Force("input","idu_ex1_expt_illegal"); @6660
// &Force("input","cp0_rtu_ex1_expt_vec"); @6661
// &Force("bus","cp0_rtu_ex1_expt_vec",3,0); @6662


// &ModuleEnd; @6714
endmodule


