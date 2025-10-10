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

// &ModuleBeg; @24
module ct_idu_id_split_long (
  // &Ports, @25
  input    wire           cp0_idu_icg_en,
  input    wire  [6  :0]  cp0_idu_vstart,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           ctrl_split_long_id_inst_vld,
  input    wire           ctrl_split_long_id_stall,
  input    wire           dp_split_long_bkpta_inst,
  input    wire           dp_split_long_bkptb_inst,
  input    wire  [31 :0]  dp_split_long_inst,
  input    wire           dp_split_long_no_spec,
  input    wire  [14 :0]  dp_split_long_pc,
  input    wire  [9  :0]  dp_split_long_type,
  input    wire  [7  :0]  dp_split_long_vl,
  input    wire           dp_split_long_vl_pred,
  input    wire  [1  :0]  dp_split_long_vlmul,
  input    wire  [2  :0]  dp_split_long_vsew,
  input    wire           forever_cpuclk,
  input    wire           iu_yy_xx_cancel,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_idu_flush_fe,
  output   wire           split_long_ctrl_id_stall,
  output   wire  [3  :0]  split_long_ctrl_inst_vld,
  output   wire  [16 :0]  split_long_dp_dep_info,
  output   reg   [177:0]  split_long_dp_inst0_data,
  output   reg   [177:0]  split_long_dp_inst1_data,
  output   reg   [177:0]  split_long_dp_inst2_data,
  output   reg   [177:0]  split_long_dp_inst3_data
); 



// &Regs; @26
reg     [16 :0]  amo_012_dep_info;                   
reg     [16 :0]  amo_123_dep_info;                   
reg     [177:0]  amo_amoalu_inst_data;               
reg     [177:0]  amo_amoload_inst_data;              
reg     [177:0]  amo_amostore_inst_data;             
reg              amo_cur_state;                      
reg     [16 :0]  amo_dep_info;                       
reg     [177:0]  amo_fence_aq_inst_data;             
reg     [177:0]  amo_fence_rl_inst_data;             
reg     [177:0]  amo_inst0_data;                     
reg     [177:0]  amo_inst1_data;                     
reg     [177:0]  amo_inst2_data;                     
reg     [177:0]  amo_inst3_data;                     
reg     [177:0]  amo_lr_inst_data;                   
reg              amo_next_state;                     
reg     [177:0]  amo_sc_inst_data;                   
reg              fored_split_inst0_last;             
reg     [5  :0]  fored_split_inst0_split_cnt;        
reg              fored_split_inst1_last;             
reg     [5  :0]  fored_split_inst1_split_cnt;        
reg              fored_split_inst2_last;             
reg     [5  :0]  fored_split_inst2_split_cnt;        
reg              fored_split_inst3_last;             
reg     [5  :0]  fored_split_inst3_split_cnt;        
reg     [5  :0]  fored_w_split_inst0_split_cnt;      
reg     [31 :0]  fored_w_split_inst0_split_inst;     
reg              fored_w_split_inst1_last;           
reg     [5  :0]  fored_w_split_inst1_split_cnt;      
reg     [31 :0]  fored_w_split_inst1_split_inst;     
reg     [5  :0]  fored_w_split_inst2_split_cnt;      
reg     [31 :0]  fored_w_split_inst2_split_inst;     
reg              fored_w_split_inst3_last;           
reg     [5  :0]  fored_w_split_inst3_split_cnt;      
reg     [31 :0]  fored_w_split_inst3_split_inst;     
reg              funored_split_inst0_last;           
reg     [5  :0]  funored_split_inst0_split_cnt;      
reg              funored_split_inst1_last;           
reg     [5  :0]  funored_split_inst1_split_cnt;      
reg              funored_split_inst2_last;           
reg              funored_split_inst2_round_end;      
reg     [5  :0]  funored_split_inst2_split_cnt;      
reg              funored_split_inst3_last;           
reg     [5  :0]  funored_split_inst3_split_cnt;      
reg     [31 :0]  funored_w_split_inst0;              
reg              funored_w_split_inst0_last;         
reg     [5  :0]  funored_w_split_inst0_split_cnt;    
reg     [1  :0]  funored_w_split_inst0_vlmul;        
reg     [2  :0]  funored_w_split_inst0_vsew;         
reg     [31 :0]  funored_w_split_inst1;              
reg              funored_w_split_inst1_last;         
reg     [5  :0]  funored_w_split_inst1_split_cnt;    
reg     [1  :0]  funored_w_split_inst1_vlmul;        
reg     [2  :0]  funored_w_split_inst1_vsew;         
reg     [31 :0]  funored_w_split_inst2;              
reg              funored_w_split_inst2_last;         
reg     [5  :0]  funored_w_split_inst2_split_cnt;    
reg     [1  :0]  funored_w_split_inst2_vlmul;        
reg     [2  :0]  funored_w_split_inst2_vsew;         
reg     [31 :0]  funored_w_split_inst3;              
reg              funored_w_split_inst3_last;         
reg     [5  :0]  funored_w_split_inst3_split_cnt;    
reg     [1  :0]  funored_w_split_inst3_vlmul;        
reg     [2  :0]  funored_w_split_inst3_vsew;         
reg     [5  :0]  index_nf_reg_offset0;               
reg     [5  :0]  index_nf_reg_offset1;               
reg     [5  :0]  stride_nf_reg_offset0;              
reg     [5  :0]  stride_nf_reg_offset1;              
reg     [5  :0]  unit_nf_reg_offset0;                
reg     [5  :0]  unit_nf_reg_offset1;                
reg     [6  :0]  vec_amo_cnt;                        
reg     [1  :0]  vec_amo_cur_state;                  
reg     [1  :0]  vec_amo_next_state;                 
reg     [177:0]  vec_amo_split_inst0_data;           
reg     [177:0]  vec_amo_split_inst1_data;           
reg     [177:0]  vec_amo_split_inst2_data;           
reg     [2  :0]  vec_amo_vreg_offset;                
reg     [3  :0]  vec_fnorm_wf_cnt;                   
reg              vec_fnorm_wf_cur_state;             
reg              vec_fnorm_wf_next_state;            
reg     [177:0]  vec_fnorm_wf_split_inst0_data;      
reg     [177:0]  vec_fnorm_wf_split_inst1_data;      
reg     [177:0]  vec_fnorm_wf_split_inst2_data;      
reg     [177:0]  vec_fnorm_wf_split_inst3_data;      
reg     [3  :0]  vec_fnorm_wv_cnt;                   
reg              vec_fnorm_wv_cur_state;             
reg              vec_fnorm_wv_next_state;            
reg     [177:0]  vec_fnorm_wv_split_inst0_data;      
reg     [177:0]  vec_fnorm_wv_split_inst1_data;      
reg     [177:0]  vec_fnorm_wv_split_inst2_data;      
reg     [177:0]  vec_fnorm_wv_split_inst3_data;      
reg     [3  :0]  vec_fored_cnt;                      
reg              vec_fored_cur_state;                
reg              vec_fored_next_state;               
reg     [177:0]  vec_fored_split_inst0_data;         
reg     [177:0]  vec_fored_split_inst1_data;         
reg     [177:0]  vec_fored_split_inst2_data;         
reg     [177:0]  vec_fored_split_inst3_data;         
reg     [4  :0]  vec_fored_w_cnt;                    
reg              vec_fored_w_cur_state;              
reg              vec_fored_w_next_state;             
reg     [177:0]  vec_fored_w_split_inst0_data;       
reg     [177:0]  vec_fored_w_split_inst1_data;       
reg     [177:0]  vec_fored_w_split_inst2_data;       
reg     [177:0]  vec_fored_w_split_inst3_data;       
reg     [2  :0]  vec_funored_cnt;                    
reg              vec_funored_cur_state;              
reg              vec_funored_next_state;             
reg     [177:0]  vec_funored_split_inst0_data;       
reg     [177:0]  vec_funored_split_inst1_data;       
reg     [177:0]  vec_funored_split_inst2_data;       
reg     [177:0]  vec_funored_split_inst3_data;       
reg     [3  :0]  vec_funored_w_cnt;                  
reg              vec_funored_w_cur_state;            
reg              vec_funored_w_next_state;           
reg     [177:0]  vec_funored_w_split_inst0_data;     
reg     [177:0]  vec_funored_w_split_inst1_data;     
reg     [177:0]  vec_funored_w_split_inst2_data;     
reg     [177:0]  vec_funored_w_split_inst3_data;     
reg     [6  :0]  vec_index_cnt;                      
reg              vec_index_cur_state;                
reg              vec_index_next_state;               
reg     [177:0]  vec_index_split_inst0_data;         
reg     [177:0]  vec_index_split_inst1_data;         
reg     [177:0]  vec_index_split_inst2_data;         
reg     [177:0]  vec_index_split_inst3_data;         
reg     [2  :0]  vec_index_vreg_offset;              
reg     [2  :0]  vec_norm_cur_state;                 
reg     [16 :0]  vec_norm_dep_info;                  
reg     [177:0]  vec_norm_mtvr_data;                 
reg     [2  :0]  vec_norm_next_state;                
reg     [9  :0]  vec_norm_pipe;                      
reg     [177:0]  vec_norm_split_inst0_data;          
reg     [177:0]  vec_norm_split_inst1_data;          
reg     [177:0]  vec_norm_split_inst2_data;          
reg     [177:0]  vec_norm_split_inst3_data;          
reg     [177:0]  vec_perm_inst0_data_tmp;            
reg     [177:0]  vec_perm_inst1_data;                
reg     [177:0]  vec_perm_inst2_data;                
reg     [177:0]  vec_perm_inst3_data;                
reg     [3  :0]  vec_perm_inst_vld_tmp;              
reg     [177:0]  vec_perm_mtvr_data;                 
reg     [3  :0]  vec_perm_mtvr_fwd_inst;             
reg     [5  :0]  vec_stride_cnt;                     
reg              vec_stride_cur_state;               
reg              vec_stride_next_state;              
reg     [177:0]  vec_stride_split_inst0_data;        
reg     [177:0]  vec_stride_split_inst1_data;        
reg     [177:0]  vec_stride_split_inst2_data;        
reg     [177:0]  vec_stride_split_inst3_data;        
reg     [2  :0]  vec_stride_vreg_offset;             
reg     [1  :0]  vperm_cur_state;                    
reg     [3  :0]  vperm_idle_mtvr_fwd_inst;           
reg     [177:0]  vperm_inst0_data;                   
reg     [177:0]  vperm_inst1_data;                   
reg     [177:0]  vperm_inst2_data;                   
reg     [177:0]  vperm_inst3_data;                   
reg     [3  :0]  vperm_inst_vld;                     
reg     [3  :0]  vperm_mtvr_fwd_inst;                
reg     [1  :0]  vperm_next_state;                   
reg     [7  :0]  vperm_srcv0_index;                  
reg     [3  :0]  vpr_counter;                        
reg     [2  :0]  vrgather_cur_state;                 
reg     [177:0]  vrgather_inst0_data;                
reg     [177:0]  vrgather_inst1_data;                
reg     [177:0]  vrgather_inst2_data;                
reg     [177:0]  vrgather_inst3_data;                
reg     [3  :0]  vrgather_inst_split_last;           
reg     [3  :0]  vrgather_inst_vld;                  
reg     [3  :0]  vrgather_mtvr_fwd_inst;             
reg     [2  :0]  vrgather_next_state;                
reg     [2  :0]  vslide_cur_state;                   
reg     [177:0]  vslide_inst0_data;                  
reg     [177:0]  vslide_inst1_data;                  
reg     [177:0]  vslide_inst2_data;                  
reg     [177:0]  vslide_inst3_data;                  
reg     [3  :0]  vslide_inst_split_last;             
reg     [3  :0]  vslide_inst_vld;                    
reg     [3  :0]  vslide_mtvr_fwd_inst;               
reg     [2  :0]  vslide_next_state;                  
reg     [6  :0]  zvlsseg_index_cnt;                  
reg              zvlsseg_index_cur_state;            
reg              zvlsseg_index_next_state;           
reg     [1  :0]  zvlsseg_index_nf_cnt;               
reg     [177:0]  zvlsseg_index_split_inst0_data;     
reg     [177:0]  zvlsseg_index_split_inst1_data;     
reg     [177:0]  zvlsseg_index_split_inst2_data;     
reg     [177:0]  zvlsseg_index_split_inst3_data;     
reg     [2  :0]  zvlsseg_index_vreg_offset;          
reg     [6  :0]  zvlsseg_stride_cnt;                 
reg              zvlsseg_stride_cur_state;           
reg              zvlsseg_stride_next_state;          
reg     [1  :0]  zvlsseg_stride_nf_cnt;              
reg     [177:0]  zvlsseg_stride_split_inst0_data;    
reg     [177:0]  zvlsseg_stride_split_inst1_data;    
reg     [177:0]  zvlsseg_stride_split_inst2_data;    
reg     [177:0]  zvlsseg_stride_split_inst3_data;    
reg     [2  :0]  zvlsseg_stride_vreg_offset;         
reg     [6  :0]  zvlsseg_unit_cnt;                   
reg              zvlsseg_unit_cur_state;             
reg              zvlsseg_unit_next_state;            
reg     [1  :0]  zvlsseg_unit_nf_cnt;                
reg     [6  :0]  zvlsseg_unit_nf_offset_cnt;         
reg     [177:0]  zvlsseg_unit_split_inst0_data;      
reg     [177:0]  zvlsseg_unit_split_inst1_data;      
reg     [177:0]  zvlsseg_unit_split_inst2_data;      
reg     [2  :0]  zvlsseg_unit_vreg_offset;           

// &Wires; @27
wire             amo_add;                            
wire    [31 :0]  amo_amoalu_inst_op;                 
wire             amo_and;                            
wire             amo_aq;                             
wire             amo_dep_info_bit;                   
wire    [31 :0]  amo_fence_aq_inst_opcode;           
wire    [31 :0]  amo_fence_rl_inst_opcode;           
wire             amo_inst;                           
wire    [3  :0]  amo_inst_vld;                       
wire             amo_lr_or_sc;                       
wire             amo_max;                            
wire             amo_maxu;                           
wire             amo_min;                            
wire             amo_minu;                           
wire             amo_more_than_4;                    
wire             amo_or;                             
wire    [4  :0]  amo_rd;                             
wire             amo_rd_is_x0;                       
wire             amo_rl;                             
wire    [4  :0]  amo_rs1;                            
wire    [4  :0]  amo_rs2;                            
wire             amo_sm_start;                       
wire             amo_split_inst;                     
wire             amo_split_stall;                    
wire             amo_swap;                           
wire             amo_word;                           
wire             amo_xor;                            
wire             dp_split_fnorm_wf_vld;              
wire             dp_split_fnorm_wv_vld;              
wire             dp_split_fored_vld;                 
wire             dp_split_fored_w_vld;               
wire             dp_split_unfored_vld;               
wire             dp_split_unfored_w_vld;             
wire    [2  :0]  dp_split_w_vlmul;                   
wire    [2  :0]  dp_split_w_vsew;                    
wire    [31 :0]  fcvtw_inst;                         
wire             fnorm_wf_cnt_en;                    
wire             fnorm_wf_cnt_end;                   
wire             fnorm_wf_fst_round;                 
wire    [3  :0]  fnorm_wf_total_cnt_num;             
wire             fnorm_wv_cnt_en;                    
wire             fnorm_wv_cnt_end;                   
wire    [3  :0]  fnorm_wv_total_cnt_num;             
wire             fored_cnt_en;                       
wire             fored_cnt_end;                      
wire             fored_fst_round;                    
wire    [31 :0]  fored_inst;                         
wire    [2  :0]  fored_split_inst0_sew16_dy_lmul;    
wire    [2  :0]  fored_split_inst0_sew16_dy_splcnt;  
wire             fored_split_inst0_sew16_last;       
wire    [2  :0]  fored_split_inst0_sew32_dy_lmul;    
wire    [2  :0]  fored_split_inst0_sew32_dy_splcnt;  
wire             fored_split_inst0_sew32_last;       
wire    [2  :0]  fored_split_inst0_sew64_dy_lmul;    
wire    [2  :0]  fored_split_inst0_sew64_dy_splcnt;  
wire             fored_split_inst0_sew64_last;       
wire    [2  :0]  fored_split_inst1_sew16_dy_lmul;    
wire    [2  :0]  fored_split_inst1_sew16_dy_splcnt;  
wire             fored_split_inst1_sew16_last;       
wire    [2  :0]  fored_split_inst1_sew32_dy_lmul;    
wire    [2  :0]  fored_split_inst1_sew32_dy_splcnt;  
wire             fored_split_inst1_sew32_last;       
wire    [2  :0]  fored_split_inst1_sew64_dy_lmul;    
wire    [2  :0]  fored_split_inst1_sew64_dy_splcnt;  
wire             fored_split_inst1_sew64_last;       
wire    [2  :0]  fored_split_inst2_sew16_dy_lmul;    
wire    [2  :0]  fored_split_inst2_sew16_dy_splcnt;  
wire             fored_split_inst2_sew16_last;       
wire    [2  :0]  fored_split_inst2_sew32_dy_lmul;    
wire    [2  :0]  fored_split_inst2_sew32_dy_splcnt;  
wire             fored_split_inst2_sew32_last;       
wire    [2  :0]  fored_split_inst2_sew64_dy_lmul;    
wire    [2  :0]  fored_split_inst2_sew64_dy_splcnt;  
wire             fored_split_inst2_sew64_last;       
wire    [2  :0]  fored_split_inst3_sew16_dy_lmul;    
wire    [2  :0]  fored_split_inst3_sew16_dy_splcnt;  
wire             fored_split_inst3_sew16_last;       
wire    [2  :0]  fored_split_inst3_sew32_dy_lmul;    
wire    [2  :0]  fored_split_inst3_sew32_dy_splcnt;  
wire             fored_split_inst3_sew32_last;       
wire    [2  :0]  fored_split_inst3_sew64_dy_lmul;    
wire    [2  :0]  fored_split_inst3_sew64_dy_splcnt;  
wire             fored_split_inst3_sew64_last;       
wire    [5  :0]  fored_total_cnt_num;                
wire             fored_w_cnt_en;                     
wire             fored_w_cnt_end;                    
wire             fored_w_fst_round;                  
wire    [31 :0]  fored_w_split_inst0_sew16;          
wire    [2  :0]  fored_w_split_inst0_sew16_dy_lmul;  
wire    [2  :0]  fored_w_split_inst0_sew16_dy_splcnt; 
wire    [31 :0]  fored_w_split_inst0_sew32;          
wire    [2  :0]  fored_w_split_inst0_sew32_dy_lmul;  
wire    [2  :0]  fored_w_split_inst0_sew32_dy_splcnt; 
wire    [31 :0]  fored_w_split_inst1_sew16;          
wire    [2  :0]  fored_w_split_inst1_sew16_dy_lmul;  
wire    [2  :0]  fored_w_split_inst1_sew16_dy_splcnt; 
wire             fored_w_split_inst1_sew16_last;     
wire    [31 :0]  fored_w_split_inst1_sew32;          
wire    [2  :0]  fored_w_split_inst1_sew32_dy_lmul;  
wire    [2  :0]  fored_w_split_inst1_sew32_dy_splcnt; 
wire             fored_w_split_inst1_sew32_last;     
wire    [31 :0]  fored_w_split_inst2_sew16;          
wire    [2  :0]  fored_w_split_inst2_sew16_dy_lmul;  
wire    [2  :0]  fored_w_split_inst2_sew16_dy_splcnt; 
wire    [31 :0]  fored_w_split_inst2_sew32;          
wire    [2  :0]  fored_w_split_inst2_sew32_dy_lmul;  
wire    [2  :0]  fored_w_split_inst2_sew32_dy_splcnt; 
wire    [31 :0]  fored_w_split_inst3_sew16;          
wire    [2  :0]  fored_w_split_inst3_sew16_dy_lmul;  
wire    [2  :0]  fored_w_split_inst3_sew16_dy_splcnt; 
wire             fored_w_split_inst3_sew16_last;     
wire    [31 :0]  fored_w_split_inst3_sew32;          
wire    [2  :0]  fored_w_split_inst3_sew32_dy_lmul;  
wire    [2  :0]  fored_w_split_inst3_sew32_dy_splcnt; 
wire             fored_w_split_inst3_sew32_last;     
wire    [4  :0]  fored_w_total_cnt_num;              
wire    [5  :0]  funct6;                             
wire             funored_cnt_en;                     
wire             funored_cnt_end;                    
wire             funored_fst_round;                  
wire    [2  :0]  funored_split_inst0_sew16_dy_lmul;  
wire    [2  :0]  funored_split_inst0_sew16_dy_splcnt; 
wire             funored_split_inst0_sew16_last;     
wire    [2  :0]  funored_split_inst0_sew32_dy_lmul;  
wire    [2  :0]  funored_split_inst0_sew32_dy_splcnt; 
wire             funored_split_inst0_sew32_last;     
wire    [2  :0]  funored_split_inst0_sew64_dy_lmul;  
wire    [2  :0]  funored_split_inst0_sew64_dy_splcnt; 
wire             funored_split_inst0_sew64_last;     
wire    [2  :0]  funored_split_inst1_sew16_dy_lmul;  
wire    [2  :0]  funored_split_inst1_sew16_dy_splcnt; 
wire             funored_split_inst1_sew16_last;     
wire    [2  :0]  funored_split_inst1_sew32_dy_lmul;  
wire    [2  :0]  funored_split_inst1_sew32_dy_splcnt; 
wire             funored_split_inst1_sew32_last;     
wire    [2  :0]  funored_split_inst1_sew64_dy_lmul;  
wire    [2  :0]  funored_split_inst1_sew64_dy_splcnt; 
wire             funored_split_inst1_sew64_last;     
wire    [2  :0]  funored_split_inst2_sew16_dy_lmul;  
wire    [2  :0]  funored_split_inst2_sew16_dy_splcnt; 
wire             funored_split_inst2_sew16_last;     
wire             funored_split_inst2_sew16_round_end; 
wire    [2  :0]  funored_split_inst2_sew32_dy_lmul;  
wire    [2  :0]  funored_split_inst2_sew32_dy_splcnt; 
wire             funored_split_inst2_sew32_last;     
wire             funored_split_inst2_sew32_round_end; 
wire    [2  :0]  funored_split_inst2_sew64_dy_lmul;  
wire    [2  :0]  funored_split_inst2_sew64_dy_splcnt; 
wire             funored_split_inst2_sew64_last;     
wire             funored_split_inst2_sew64_round_end; 
wire    [2  :0]  funored_split_inst3_sew16_dy_lmul;  
wire    [2  :0]  funored_split_inst3_sew16_dy_splcnt; 
wire             funored_split_inst3_sew16_last;     
wire    [2  :0]  funored_split_inst3_sew32_dy_lmul;  
wire    [2  :0]  funored_split_inst3_sew32_dy_splcnt; 
wire             funored_split_inst3_sew32_last;     
wire    [2  :0]  funored_split_inst3_sew64_dy_lmul;  
wire    [2  :0]  funored_split_inst3_sew64_dy_splcnt; 
wire             funored_split_inst3_sew64_last;     
wire    [2  :0]  funored_total_cnt_num;              
wire             funored_w_cnt_en;                   
wire             funored_w_cnt_end;                  
wire             funored_w_fst_round;                
wire    [3  :0]  funored_w_total_cnt_num;            
wire             lr_inst;                            
wire    [31 :0]  perm_mtvr_inst_op;                  
wire             perm_split_clk;                     
wire             sc_inst;                            
wire             split_clk;                          
wire             split_clk_en;                       
wire    [177:0]  split_long_inst0_data;              
wire    [177:0]  split_long_inst1_data;              
wire    [177:0]  split_long_inst2_data;              
wire    [177:0]  split_long_inst3_data;              
wire             vcompress;                          
wire    [31 :0]  vec_amo_add_inst;                   
wire    [16 :0]  vec_amo_dep_info;                   
wire             vec_amo_dst_v0;                     
wire    [31 :0]  vec_amo_ext_inst;                   
wire    [177:0]  vec_amo_inst0_data;                 
wire    [177:0]  vec_amo_inst1_data;                 
wire    [177:0]  vec_amo_inst2_data;                 
wire    [177:0]  vec_amo_inst3_data;                 
wire    [3  :0]  vec_amo_inst_vld;                   
wire             vec_amo_sm_start;                   
wire             vec_amo_split_clk;                  
wire             vec_amo_split_clk_en;               
wire    [177:0]  vec_amo_split_inst3_data;           
wire             vec_amo_split_last;                 
wire             vec_amo_split_stall;                
wire    [31 :0]  vec_amo_valu_inst;                  
wire    [31 :0]  vec_amo_vmv_inst;                   
wire             vec_amo_vreg_begin;                 
wire             vec_amo_vreg_end;                   
wire             vec_dstv_ovlp_vs2;                  
wire    [2  :0]  vec_fnorm_wf_base_cnt;              
wire    [16 :0]  vec_fnorm_wf_dep_info;              
wire    [4  :0]  vec_fnorm_wf_dest_vreg_1;           
wire    [4  :0]  vec_fnorm_wf_dest_vreg_3;           
wire    [177:0]  vec_fnorm_wf_inst0_data;            
wire    [177:0]  vec_fnorm_wf_inst1_data;            
wire    [177:0]  vec_fnorm_wf_inst2_data;            
wire    [177:0]  vec_fnorm_wf_inst3_data;            
wire    [3  :0]  vec_fnorm_wf_inst_vld;              
wire             vec_fnorm_wf_sm_start;              
wire             vec_fnorm_wf_split_busy;            
wire             vec_fnorm_wf_split_clk;             
wire             vec_fnorm_wf_split_clk_en;          
wire    [1  :0]  vec_fnorm_wf_split_inst0_lmul;      
wire    [2  :0]  vec_fnorm_wf_split_inst0_sew;       
wire    [1  :0]  vec_fnorm_wf_split_inst1_lmul;      
wire    [2  :0]  vec_fnorm_wf_split_inst1_sew;       
wire    [1  :0]  vec_fnorm_wf_split_inst2_lmul;      
wire    [2  :0]  vec_fnorm_wf_split_inst2_sew;       
wire    [1  :0]  vec_fnorm_wf_split_inst3_lmul;      
wire    [2  :0]  vec_fnorm_wf_split_inst3_sew;       
wire             vec_fnorm_wf_split_stall;           
wire    [4  :0]  vec_fnorm_wf_srcv0_vreg_1;          
wire    [4  :0]  vec_fnorm_wf_srcv0_vreg_3;          
wire    [4  :0]  vec_fnorm_wf_srcv1_vreg;            
wire    [16 :0]  vec_fnorm_wv_dep_info;              
wire    [4  :0]  vec_fnorm_wv_dest_vreg_1;           
wire    [4  :0]  vec_fnorm_wv_dest_vreg_3;           
wire    [177:0]  vec_fnorm_wv_inst0_data;            
wire    [177:0]  vec_fnorm_wv_inst1_data;            
wire    [177:0]  vec_fnorm_wv_inst2_data;            
wire    [177:0]  vec_fnorm_wv_inst3_data;            
wire    [3  :0]  vec_fnorm_wv_inst_vld;              
wire             vec_fnorm_wv_sm_start;              
wire             vec_fnorm_wv_split_busy;            
wire             vec_fnorm_wv_split_clk;             
wire             vec_fnorm_wv_split_clk_en;          
wire    [1  :0]  vec_fnorm_wv_split_inst0_lmul;      
wire    [2  :0]  vec_fnorm_wv_split_inst0_sew;       
wire    [1  :0]  vec_fnorm_wv_split_inst1_lmul;      
wire    [2  :0]  vec_fnorm_wv_split_inst1_sew;       
wire    [1  :0]  vec_fnorm_wv_split_inst2_lmul;      
wire    [2  :0]  vec_fnorm_wv_split_inst2_sew;       
wire    [1  :0]  vec_fnorm_wv_split_inst3_lmul;      
wire    [2  :0]  vec_fnorm_wv_split_inst3_sew;       
wire             vec_fnorm_wv_split_stall;           
wire    [4  :0]  vec_fnorm_wv_srcv0_vreg_1;          
wire    [4  :0]  vec_fnorm_wv_srcv0_vreg_3;          
wire    [4  :0]  vec_fnorm_wv_srcv1_vreg;            
wire    [16 :0]  vec_fored_dep_info;                 
wire    [4  :0]  vec_fored_destv_vreg;               
wire    [177:0]  vec_fored_inst0_data;               
wire    [177:0]  vec_fored_inst1_data;               
wire    [177:0]  vec_fored_inst2_data;               
wire    [177:0]  vec_fored_inst3_data;               
wire    [3  :0]  vec_fored_inst_vld;                 
wire             vec_fored_sm_start;                 
wire             vec_fored_split_busy;               
wire             vec_fored_split_clk;                
wire             vec_fored_split_clk_en;             
wire    [5  :0]  vec_fored_split_inst0_src0;         
wire    [5  :0]  vec_fored_split_inst0_src1;         
wire    [5  :0]  vec_fored_split_inst1_src0;         
wire    [5  :0]  vec_fored_split_inst1_src1;         
wire    [5  :0]  vec_fored_split_inst2_src0;         
wire    [5  :0]  vec_fored_split_inst2_src1;         
wire    [5  :0]  vec_fored_split_inst3_src0;         
wire    [5  :0]  vec_fored_split_inst3_src1;         
wire             vec_fored_split_stall;              
wire    [4  :0]  vec_fored_srcv0_vreg_0;             
wire    [4  :0]  vec_fored_srcv0_vreg_1;             
wire    [4  :0]  vec_fored_srcv0_vreg_2;             
wire    [4  :0]  vec_fored_srcv0_vreg_3;             
wire    [4  :0]  vec_fored_srcv1_vreg;               
wire             vec_fored_w_cnt_h;                  
wire    [2  :0]  vec_fored_w_cnt_l;                  
wire    [16 :0]  vec_fored_w_dep_info;               
wire    [4  :0]  vec_fored_w_destv_vreg;             
wire    [177:0]  vec_fored_w_inst0_data;             
wire             vec_fored_w_inst0_mul8;             
wire    [177:0]  vec_fored_w_inst1_data;             
wire    [177:0]  vec_fored_w_inst2_data;             
wire    [177:0]  vec_fored_w_inst3_data;             
wire    [3  :0]  vec_fored_w_inst_vld;               
wire             vec_fored_w_sm_start;               
wire             vec_fored_w_split_busy;             
wire             vec_fored_w_split_clk;              
wire             vec_fored_w_split_clk_en;           
wire    [1  :0]  vec_fored_w_split_inst0_lmul;       
wire    [2  :0]  vec_fored_w_split_inst0_sew;        
wire    [5  :0]  vec_fored_w_split_inst0_src0;       
wire    [5  :0]  vec_fored_w_split_inst0_src1;       
wire    [5  :0]  vec_fored_w_split_inst1_dest;       
wire    [1  :0]  vec_fored_w_split_inst1_lmul;       
wire    [2  :0]  vec_fored_w_split_inst1_sew;        
wire    [5  :0]  vec_fored_w_split_inst1_src0;       
wire    [5  :0]  vec_fored_w_split_inst1_src1;       
wire    [1  :0]  vec_fored_w_split_inst2_lmul;       
wire    [2  :0]  vec_fored_w_split_inst2_sew;        
wire    [1  :0]  vec_fored_w_split_inst3_lmul;       
wire    [2  :0]  vec_fored_w_split_inst3_sew;        
wire    [5  :0]  vec_fored_w_split_inst3_src0;       
wire    [5  :0]  vec_fored_w_split_inst3_src1;       
wire             vec_fored_w_split_stall;            
wire    [4  :0]  vec_fored_w_srcv0_vreg_0;           
wire    [4  :0]  vec_fored_w_srcv1_vreg;             
wire    [16 :0]  vec_fred_dep_info;                  
wire    [177:0]  vec_fred_inst0_data;                
wire    [177:0]  vec_fred_inst1_data;                
wire    [177:0]  vec_fred_inst2_data;                
wire    [177:0]  vec_fred_inst3_data;                
wire    [3  :0]  vec_fred_inst_vld;                  
wire             vec_fred_split_stall;               
wire             vec_fred_w_mul8;                    
wire    [16 :0]  vec_funored_dep_info;               
wire    [4  :0]  vec_funored_destv_vreg;             
wire    [177:0]  vec_funored_inst0_data;             
wire    [177:0]  vec_funored_inst1_data;             
wire    [177:0]  vec_funored_inst2_data;             
wire    [177:0]  vec_funored_inst3_data;             
wire    [3  :0]  vec_funored_inst_vld;               
wire             vec_funored_sm_start;               
wire             vec_funored_split_busy;             
wire             vec_funored_split_clk;              
wire             vec_funored_split_clk_en;           
wire    [5  :0]  vec_funored_split_inst1_dest;       
wire             vec_funored_split_stall;            
wire    [4  :0]  vec_funored_srcv0_vreg_0;           
wire    [4  :0]  vec_funored_srcv0_vreg_2;           
wire    [4  :0]  vec_funored_srcv1_vreg;             
wire             vec_funored_w_cnt_h;                
wire    [2  :0]  vec_funored_w_cnt_l;                
wire    [16 :0]  vec_funored_w_dep_info;             
wire    [4  :0]  vec_funored_w_destv_vreg;           
wire    [177:0]  vec_funored_w_inst0_data;           
wire    [177:0]  vec_funored_w_inst1_data;           
wire    [177:0]  vec_funored_w_inst2_data;           
wire    [177:0]  vec_funored_w_inst3_data;           
wire    [3  :0]  vec_funored_w_inst_vld;             
wire             vec_funored_w_sm_start;             
wire             vec_funored_w_split_busy;           
wire             vec_funored_w_split_clk;            
wire             vec_funored_w_split_clk_en;         
wire    [1  :0]  vec_funored_w_split_inst0_lmul;     
wire    [2  :0]  vec_funored_w_split_inst0_sew;      
wire    [1  :0]  vec_funored_w_split_inst1_lmul;     
wire    [2  :0]  vec_funored_w_split_inst1_sew;      
wire    [1  :0]  vec_funored_w_split_inst2_lmul;     
wire    [2  :0]  vec_funored_w_split_inst2_sew;      
wire    [1  :0]  vec_funored_w_split_inst3_lmul;     
wire    [2  :0]  vec_funored_w_split_inst3_sew;      
wire             vec_funored_w_split_stall;          
wire    [4  :0]  vec_funored_w_srcv0_vreg_0;         
wire    [4  :0]  vec_funored_w_srcv1_vreg;           
wire             vec_gpr_vld;                        
wire             vec_imm_vld;                        
wire    [31 :0]  vec_index_add_inst;                 
wire    [16 :0]  vec_index_dep_info;                 
wire    [31 :0]  vec_index_ext_inst;                 
wire    [177:0]  vec_index_inst0_data;               
wire    [177:0]  vec_index_inst1_data;               
wire    [177:0]  vec_index_inst2_data;               
wire    [177:0]  vec_index_inst3_data;               
wire    [3  :0]  vec_index_inst_vld;                 
wire             vec_index_sm_start;                 
wire             vec_index_split_clk;                
wire             vec_index_split_clk_en;             
wire             vec_index_split_last;               
wire             vec_index_split_stall;              
wire    [31 :0]  vec_index_vmv_inst;                 
wire             vec_index_vreg_begin;               
wire             vec_index_vreg_end;                 
wire    [31 :0]  vec_inst;                           
wire             vec_inst_adc;                       
wire             vec_inst_cmp;                       
wire             vec_inst_div;                       
wire             vec_inst_ereg;                      
wire             vec_inst_fmv;                       
wire             vec_inst_mac;                       
wire             vec_inst_madd;                      
wire             vec_inst_red;                       
wire             vec_inst_sat;                       
wire             vec_inst_sht;                       
wire             vec_ld;                             
wire             vec_ld_srcv2_vld;                   
wire             vec_ldst;                           
wire    [1  :0]  vec_lmul;                           
wire    [31 :0]  vec_mtvr_inst_op;                   
wire    [4  :0]  vec_mvvf_inst_cnt;                  
wire             vec_narr_sat;                       
wire             vec_narr_sht;                       
wire             vec_norm_cur_1st;                   
wire             vec_norm_cur_2nd;                   
wire             vec_norm_cur_mtvr;                  
wire    [11 :0]  vec_norm_destv_offset;              
wire    [11 :0]  vec_norm_destv_offset_tmp;          
wire    [4  :0]  vec_norm_destv_vreg_0;              
wire    [4  :0]  vec_norm_destv_vreg_1;              
wire    [4  :0]  vec_norm_destv_vreg_2;              
wire    [4  :0]  vec_norm_destv_vreg_3;              
wire             vec_norm_div;                       
wire    [177:0]  vec_norm_inst0_data;                
wire    [177:0]  vec_norm_inst1_data;                
wire    [177:0]  vec_norm_inst2_data;                
wire    [177:0]  vec_norm_inst3_data;                
wire             vec_norm_inst_0_finish;             
wire             vec_norm_inst_1_finish;             
wire             vec_norm_inst_3_finish;             
wire    [3  :0]  vec_norm_inst_vld;                  
wire             vec_norm_inst_vmla;                 
wire             vec_norm_mac;                       
wire             vec_norm_mul;                       
wire    [3  :0]  vec_norm_pipe_sel;                  
wire             vec_norm_require_2nd;               
wire             vec_norm_sat;                       
wire             vec_norm_sht;                       
wire             vec_norm_sm_start;                  
wire             vec_norm_split_clk;                 
wire             vec_norm_split_clk_en;              
wire    [3  :0]  vec_norm_split_num;                 
wire             vec_norm_split_slow_0;              
wire             vec_norm_split_slow_1;              
wire             vec_norm_split_stall;               
wire    [11 :0]  vec_norm_srcv0_offset;              
wire    [11 :0]  vec_norm_srcv0_offset_tmp;          
wire             vec_norm_srcv0_tmp;                 
wire             vec_norm_srcv0_vld;                 
wire    [4  :0]  vec_norm_srcv0_vreg_0;              
wire    [4  :0]  vec_norm_srcv0_vreg_0_tmp;          
wire    [4  :0]  vec_norm_srcv0_vreg_1;              
wire    [4  :0]  vec_norm_srcv0_vreg_1_tmp;          
wire    [4  :0]  vec_norm_srcv0_vreg_2;              
wire    [4  :0]  vec_norm_srcv0_vreg_2_tmp;          
wire    [4  :0]  vec_norm_srcv0_vreg_3;              
wire    [4  :0]  vec_norm_srcv0_vreg_3_tmp;          
wire    [11 :0]  vec_norm_srcv1_offset;              
wire             vec_norm_srcv1_tmp;                 
wire             vec_norm_srcv1_vld;                 
wire    [4  :0]  vec_norm_srcv1_vreg_0;              
wire    [4  :0]  vec_norm_srcv1_vreg_0_tmp;          
wire    [4  :0]  vec_norm_srcv1_vreg_1;              
wire    [4  :0]  vec_norm_srcv1_vreg_1_tmp;          
wire    [4  :0]  vec_norm_srcv1_vreg_2;              
wire    [4  :0]  vec_norm_srcv1_vreg_2_tmp;          
wire    [4  :0]  vec_norm_srcv1_vreg_3;              
wire    [4  :0]  vec_norm_srcv1_vreg_3_tmp;          
wire             vec_norm_srcv2_vld;                 
wire             vec_norm_srcvm_vld;                 
wire             vec_opfvf;                          
wire             vec_opfvv;                          
wire             vec_opivi;                          
wire             vec_opivv;                          
wire             vec_opivx;                          
wire             vec_opmvv;                          
wire             vec_opmvx;                          
wire    [16 :0]  vec_perm_dep_info;                  
wire    [177:0]  vec_perm_inst0_data;                
wire    [3  :0]  vec_perm_inst_vld;                  
wire             vec_perm_mtvr_sel;                  
wire             vec_perm_split_stall;               
wire    [1  :0]  vec_sew;                            
wire             vec_src_switch;                     
wire             vec_st;                             
wire    [31 :0]  vec_stride_add_inst;                
wire    [16 :0]  vec_stride_dep_info;                
wire             vec_stride_dst_v0;                  
wire             vec_stride_dstv0_ovlp;              
wire    [177:0]  vec_stride_inst0_data;              
wire    [177:0]  vec_stride_inst1_data;              
wire    [177:0]  vec_stride_inst2_data;              
wire    [177:0]  vec_stride_inst3_data;              
wire    [3  :0]  vec_stride_inst_vld;                
wire             vec_stride_sm_start;                
wire             vec_stride_split_clk;               
wire             vec_stride_split_clk_en;            
wire             vec_stride_split_last;              
wire             vec_stride_split_last_normal;       
wire             vec_stride_split_secd_to_last;      
wire             vec_stride_split_stall;             
wire             vec_stride_v0_begin;                
wire             vec_stride_v0_split_last;           
wire             vec_stride_vreg_begin;              
wire             vec_stride_vreg_end;                
wire             vec_type_cmp;                       
wire             vec_type_fcvt;                      
wire             vec_type_fcvt_narr;                 
wire             vec_type_fcvt_norm;                 
wire             vec_type_fcvt_wide;                 
wire             vec_type_fdiv;                      
wire             vec_type_fmac;                      
wire             vec_type_narr;                      
wire             vec_type_narr_0;                    
wire             vec_type_narr_1;                    
wire             vec_type_narr_2;                    
wire             vec_type_norm_0_2;                  
wire             vec_type_norm_0_3;                  
wire             vec_type_norm_0_4;                  
wire             vec_type_norm_0_5;                  
wire             vec_type_norm_0_7;                  
wire             vec_type_norm_0_9;                  
wire             vec_type_norm_0_a;                  
wire             vec_type_norm_0_b;                  
wire             vec_type_norm_1_0;                  
wire             vec_type_norm_1_1;                  
wire             vec_type_norm_1_2;                  
wire             vec_type_norm_1_3;                  
wire             vec_type_norm_2_1;                  
wire             vec_type_norm_2_2;                  
wire             vec_type_norm_2_3;                  
wire             vec_type_norm_2_4;                  
wire             vec_type_norm_2_5;                  
wire             vec_type_norm_2_6;                  
wire             vec_type_norm_2_7;                  
wire             vec_type_norm_2_9;                  
wire             vec_type_norm_2_a;                  
wire             vec_type_norm_2_b;                  
wire             vec_type_norm_2_c;                  
wire             vec_type_redu;                      
wire             vec_type_wide;                      
wire             vec_type_wide_0;                    
wire             vec_type_wide_1;                    
wire             vec_type_wide_2;                    
wire             vec_type_wide_3;                    
wire             vec_type_wide_4;                    
wire             vec_type_wide_5;                    
wire             vec_type_wide_6;                    
wire             vec_type_wide_7;                    
wire             vec_type_wide_8;                    
wire             vec_type_wide_9;                    
wire             vec_type_wide_narr;                 
wire             vec_wide_mac;                       
wire             vec_wide_mul;                       
wire             vec_wide_sat;                       
wire    [31 :0]  vfmvvf_inst;                        
wire             vperm_cur_idle;                     
wire             vperm_cur_mtvr;                     
wire    [6  :0]  vperm_inst1_not_vld;                
wire    [6  :0]  vperm_inst2_not_vld;                
wire    [4  :0]  vperm_inst3_not_vld;                
wire    [3  :0]  vperm_inst_split_last;              
wire    [1  :0]  vperm_require_mtvr;                 
wire             vperm_sm_start;                     
wire             vperm_split_clk_en;                 
wire             vperm_split_mtvr_vld;               
wire             vperm_split_stall;                  
wire    [2  :0]  vperm_srcv0_inc;                    
wire    [2  :0]  vperm_srcv0_inst0_count;            
wire    [2  :0]  vperm_srcv0_inst1_count;            
wire    [2  :0]  vperm_srcv0_inst2_count;            
wire    [2  :0]  vperm_srcv0_inst3_count;            
wire    [4  :0]  vperm_srcv1_reg;                    
wire             vpr_cnt_over;                       
wire             vpr_idle_inc;                       
wire    [3  :0]  vpr_inc_1;                          
wire    [3  :0]  vpr_inc_2;                          
wire             vrgather;                           
wire             vrgather_clk_en;                    
wire             vrgather_cur_idle;                  
wire    [31 :0]  vrgather_inst;                      
wire    [3  :0]  vrgather_inst0_fwd_inst;            
wire    [5  :0]  vrgather_inst0_split_num;           
wire    [4  :0]  vrgather_inst0_srcv0_reg;           
wire    [4  :0]  vrgather_inst0_vdst_offset;         
wire    [4  :0]  vrgather_inst0_vdst_reg;            
wire    [3  :0]  vrgather_inst1_fwd_inst;            
wire    [5  :0]  vrgather_inst1_split_num;           
wire    [4  :0]  vrgather_inst1_srcv0_reg;           
wire    [4  :0]  vrgather_inst1_vdst_offset;         
wire    [4  :0]  vrgather_inst1_vdst_reg;            
wire    [3  :0]  vrgather_inst2_fwd_inst;            
wire    [5  :0]  vrgather_inst2_split_num;           
wire    [4  :0]  vrgather_inst2_srcv0_reg;           
wire    [4  :0]  vrgather_inst2_vdst_offset;         
wire    [4  :0]  vrgather_inst2_vdst_reg;            
wire    [3  :0]  vrgather_inst3_fwd_inst;            
wire    [5  :0]  vrgather_inst3_split_num;           
wire    [4  :0]  vrgather_inst3_srcv0_reg;           
wire    [4  :0]  vrgather_inst3_vdst_offset;         
wire    [4  :0]  vrgather_inst3_vdst_reg;            
wire    [31 :0]  vrgather_inst_0;                    
wire    [31 :0]  vrgather_inst_1;                    
wire    [4  :0]  vrgather_inst_srcv1_reg;            
wire    [3  :0]  vrgather_inst_srcv1_tmp;            
wire    [3  :0]  vrgather_inst_vdst_tmp;             
wire             vrgather_split_clk;                 
wire             vrgather_split_stall;               
wire    [4  :0]  vrgather_srcv0_base;                
wire    [19 :0]  vrgather_srcv0_offset;              
wire             vrgather_start;                     
wire    [19 :0]  vrgather_vdst_offset;               
wire             vrgather_xi;                        
wire             vslide1_stride;                     
wire             vslide_clk_en;                      
wire             vslide_cur_idle;                    
wire    [3  :0]  vslide_inst0_srcv1_tmp;             
wire    [1  :0]  vslide_inst1_srcv1_tmp;             
wire             vslide_inst2_srcv1_tmp;             
wire    [1  :0]  vslide_inst3_srcv1_tmp;             
wire             vslide_one_start;                   
wire             vslide_split_clk;                   
wire             vslide_split_stall;                 
wire    [4  :0]  vslide_srcv0_base;                  
wire    [11 :0]  vslide_srcv0_offset;                
wire    [11 :0]  vslide_srcv1_offset;                
wire    [11 :0]  vslide_srcv1_slidedown_offset;      
wire    [11 :0]  vslide_srcv1_slideup_offset;        
wire             vslidedown;                         
wire             vslideup;                           
wire    [1  :0]  widden_split_inst0_vlmul;           
wire    [2  :0]  widden_split_inst0_vsew;            
wire    [1  :0]  widden_split_inst1_vlmul;           
wire    [2  :0]  widden_split_inst1_vsew;            
wire    [1  :0]  widden_split_inst2_vlmul;           
wire    [2  :0]  widden_split_inst2_vsew;            
wire    [1  :0]  widden_split_inst3_vlmul;           
wire    [2  :0]  widden_split_inst3_vsew;            
wire             widden_split_inst_vld;              
wire             x_vfunary0_vld_narr;                
wire             x_vfunary0_vld_norm;                
wire             x_vfunary0_vld_wide;                
wire    [3  :0]  zvlsseg_index_add_iid_plus;         
wire    [31 :0]  zvlsseg_index_add_inst;             
wire    [16 :0]  zvlsseg_index_dep_info;             
wire    [31 :0]  zvlsseg_index_ext_inst;             
wire    [177:0]  zvlsseg_index_inst0_data;           
wire    [177:0]  zvlsseg_index_inst1_data;           
wire    [177:0]  zvlsseg_index_inst2_data;           
wire    [177:0]  zvlsseg_index_inst3_data;           
wire    [3  :0]  zvlsseg_index_inst_vld;             
wire             zvlsseg_index_nf_first;             
wire             zvlsseg_index_nf_last;              
wire             zvlsseg_index_sm_start;             
wire             zvlsseg_index_split_clk;            
wire             zvlsseg_index_split_clk_en;         
wire    [5  :0]  zvlsseg_index_split_dstv_reg0;      
wire    [5  :0]  zvlsseg_index_split_dstv_reg1;      
wire             zvlsseg_index_split_last;           
wire             zvlsseg_index_split_stall;          
wire             zvlsseg_index_vreg_end;             
wire    [31 :0]  zvlsseg_stride_add_inst;            
wire    [3  :0]  zvlsseg_stride_add_interval;        
wire    [16 :0]  zvlsseg_stride_dep_info;            
wire    [177:0]  zvlsseg_stride_inst0_data;          
wire    [177:0]  zvlsseg_stride_inst1_data;          
wire    [177:0]  zvlsseg_stride_inst2_data;          
wire    [177:0]  zvlsseg_stride_inst3_data;          
wire    [3  :0]  zvlsseg_stride_inst_vld;            
wire    [1  :0]  zvlsseg_stride_nf_cycle;            
wire             zvlsseg_stride_nf_last;             
wire             zvlsseg_stride_sm_start;            
wire             zvlsseg_stride_split_clk;           
wire             zvlsseg_stride_split_clk_en;        
wire    [5  :0]  zvlsseg_stride_split_dstv_reg0;     
wire    [5  :0]  zvlsseg_stride_split_dstv_reg1;     
wire             zvlsseg_stride_split_last;          
wire             zvlsseg_stride_split_secd_to_last;  
wire             zvlsseg_stride_split_stall;         
wire    [31 :0]  zvlsseg_stride_vmv_inst;            
wire             zvlsseg_stride_vreg_end;            
wire             zvlsseg_stride_vreg_secd_to_end;    
wire    [16 :0]  zvlsseg_unit_dep_info;              
wire    [177:0]  zvlsseg_unit_inst0_data;            
wire    [177:0]  zvlsseg_unit_inst1_data;            
wire    [177:0]  zvlsseg_unit_inst2_data;            
wire    [177:0]  zvlsseg_unit_inst3_data;            
wire    [3  :0]  zvlsseg_unit_inst_vld;              
wire             zvlsseg_unit_nf_last;               
wire    [6  :0]  zvlsseg_unit_nf_offset_cnt1;        
wire             zvlsseg_unit_sm_start;              
wire             zvlsseg_unit_split_clk;             
wire             zvlsseg_unit_split_clk_en;          
wire    [5  :0]  zvlsseg_unit_split_dstv_reg0;       
wire    [5  :0]  zvlsseg_unit_split_dstv_reg1;       
wire    [177:0]  zvlsseg_unit_split_inst3_data;      
wire             zvlsseg_unit_split_last;            
wire             zvlsseg_unit_split_stall;           
wire    [31 :0]  zvlsseg_unit_vmv_inst;              
wire             zvlsseg_unit_vreg_end;              
wire             inst_ll;
wire             inst_sc;
wire             inst_ll_sc;
wire             amo_inst_no_bar;
wire             amo_inst_bar;
wire    [31 :0]  x_inst;


//==========================================================
//                       Parameters
//==========================================================
//----------------------------------------------------------
//                 IR data path parameters
//----------------------------------------------------------
parameter IR_WIDTH            = 178;

parameter IR_VL_PRED          = 177;
parameter IR_VL               = 176;
parameter IR_VMB              = 168;
parameter IR_PC               = 167;
parameter IR_VSEW             = 152;
parameter IR_VLMUL            = 149;
parameter IR_FMLA             = 147;
parameter IR_SPLIT_NUM        = 146;
parameter IR_NO_SPEC          = 139;
parameter IR_MLA              = 138;
parameter IR_DST_X0           = 137;
parameter IR_ILLEGAL          = 136;
parameter IR_SPLIT_LAST       = 135;
parameter IR_VMLA             = 134;
parameter IR_IID_PLUS         = 133;
parameter IR_BKPTB_INST       = 129;
parameter IR_BKPTA_INST       = 128;
parameter IR_FMOV             = 127;
parameter IR_MOV              = 126;
parameter IR_EXPT             = 125;
parameter IR_LENGTH           = 118;
parameter IR_INTMASK          = 117;
parameter IR_SPLIT            = 116;
parameter IR_INST_TYPE        = 115;
parameter IR_DSTV_REG         = 105;
parameter IR_DSTV_VLD         = 99;
parameter IR_SRCVM_VLD        = 98;
parameter IR_SRCV2_VLD        = 97;
parameter IR_SRCV1_REG        = 96;
parameter IR_SRCV1_VLD        = 90;
parameter IR_SRCV0_REG        = 89;
parameter IR_SRCV0_VLD        = 83;
parameter IR_DSTE_VLD         = 82;
parameter IR_DSTF_REG         = 81;
parameter IR_DSTF_VLD         = 75;
parameter IR_SRCF2_REG        = 74;
parameter IR_SRCF2_VLD        = 68;
parameter IR_SRCF1_REG        = 67;
parameter IR_SRCF1_VLD        = 61;
parameter IR_SRCF0_REG        = 60;
parameter IR_SRCF0_VLD        = 54;
parameter IR_DST_REG          = 53;
parameter IR_DST_VLD          = 47;
parameter IR_SRC2_VLD         = 46;
parameter IR_SRC1_REG         = 45;
parameter IR_SRC1_VLD         = 39;
parameter IR_SRC0_REG         = 38;
parameter IR_SRC0_VLD         = 32;
parameter IR_OPCODE           = 31;

//----------------------------------------------------------
//                   Type parameters
//----------------------------------------------------------
parameter DEP_WIDTH             = 17;

parameter DEP_INST01_SRC0_MASK  = 0;
parameter DEP_INST01_SRC1_MASK  = 1;
parameter DEP_INST12_SRC0_MASK  = 2;
parameter DEP_INST12_SRC1_MASK  = 3;
parameter DEP_INST23_SRC0_MASK  = 4;
parameter DEP_INST23_SRC1_MASK  = 5;
parameter DEP_INST02_PREG_MASK  = 6;
parameter DEP_INST13_PREG_MASK  = 7;
parameter DEP_INST01_VREG_MASK  = 8;
parameter DEP_INST12_VREG_MASK  = 9;
parameter DEP_INST23_VREG_MASK  = 10;
parameter DEP_INST13_VREG_MASK  = 11;
parameter DEP_INST02_VREG_MASK  = 12;
parameter DEP_INST03_VREG_MASK  = 13;
parameter DEP_INST01_SRCV1_MASK = 14;
parameter DEP_INST12_SRCV1_MASK = 15;
parameter DEP_INST23_SRCV1_MASK = 16;

//----------------------------------------------------------
//                   Type parameters
//----------------------------------------------------------
parameter ALU      = 10'b0000000001;
parameter BJU      = 10'b0000000010;
parameter MULT     = 10'b0000000100;
parameter DIV      = 10'b0000001000;
parameter LSU_P5   = 10'b0000110000;
parameter LSU      = 10'b0000010000;
parameter PIPE67   = 10'b0001000000;
parameter PIPE6    = 10'b0010000000;
parameter PIPE7    = 10'b0100000000;
parameter SPECIAL  = 10'b1000000000;

//==========================================================
//                 Atomic (amo) instructions
//==========================================================
parameter AMO_IDLE  = 1'b0;
parameter AMO_SPLIT = 1'b1;
//----------------------------------------------------------
//                 Instance of Gated Cell
//----------------------------------------------------------

assign split_clk_en = ctrl_split_long_id_inst_vld
                      && (dp_split_long_type[0])
                      || (amo_cur_state != AMO_IDLE);
// &Instance("gated_clk_cell", "x_split_gated_clk"); @137
gated_clk_cell  x_split_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (split_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (split_clk_en      ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @138
//          .external_en (1'b0), @139
//          .global_en   (cp0_yy_clk_en), @140
//          .module_en   (cp0_idu_icg_en), @141
//          .local_en    (split_clk_en), @142
//          .clk_out     (split_clk)); @143

//----------------------------------------------------------
//           amo split variables initial value
//----------------------------------------------------------
assign amo_sm_start       = ctrl_split_long_id_inst_vld
                            && dp_split_long_type[0]
                            && !ctrl_split_long_id_stall
                            && amo_more_than_4;

assign x_inst[31:0] = dp_split_long_inst[31:0];


assign amo_inst_no_bar = (x_inst[31:15] == 17'b00111000011000000) || //amswap.w
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
                         (x_inst[31:15] == 17'b00111000011010001);   //ammin.du

assign amo_inst_bar =  (x_inst[31:15] == 17'b00111000011010010) || //amswap_db.w
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



assign amo_inst           = amo_inst_no_bar || 
                            amo_inst_bar;

assign amo_aq             = amo_inst_bar;

assign amo_rl             = 1'b0;

assign lr_inst            = inst_ll;

assign sc_inst            = inst_sc;

assign amo_swap           = (x_inst[31:15] == 17'b00111000011000001) ||  //amswap.d
                            (x_inst[31:15] == 17'b00111000011000000) ||  //amswap.w
                            (x_inst[31:15] == 17'b00111000011010010) ||  //amswap_db.w
                            (x_inst[31:15] == 17'b00111000011010011);    //amswap_db.d

assign amo_add            = (x_inst[31:15] == 17'b00111000011000010) || //amadd.w
                            (x_inst[31:15] == 17'b00111000011000011) || //amadd.d
                            (x_inst[31:15] == 17'b00111000011010100) || //amadd_db.w
                            (x_inst[31:15] == 17'b00111000011010101);   //amadd_db.d;

assign amo_xor            = (x_inst[31:15] == 17'b00111000011001000) || //amxor.w
                            (x_inst[31:15] == 17'b00111000011001001) || //amxor.d
                            (x_inst[31:15] == 17'b00111000011011010) || //amxor_db.w
                            (x_inst[31:15] == 17'b00111000011011011);   //amxor_db.d;

assign amo_and            = (x_inst[31:15] == 17'b00111000011000100) || //amand.w
                            (x_inst[31:15] == 17'b00111000011000101) || //amand.d
                            (x_inst[31:15] == 17'b00111000011010110) || //amand_db.w
                            (x_inst[31:15] == 17'b00111000011010111);   //amand_db.d;

assign amo_or             = (x_inst[31:15] == 17'b00111000011000110) || //amor.w
                            (x_inst[31:15] == 17'b00111000011000111) || //amor.d
                            (x_inst[31:15] == 17'b00111000011011000) || //amor_db.w
                            (x_inst[31:15] == 17'b00111000011011001);   //amor_db.d;

assign amo_min            = (x_inst[31:15] == 17'b00111000011001100) || //ammin.w
                            (x_inst[31:15] == 17'b00111000011001101) || //ammin.d
                            (x_inst[31:15] == 17'b00111000011011110) || //ammin_db.w
                            (x_inst[31:15] == 17'b00111000011011111);   //ammin_db.d;

assign amo_minu           = (x_inst[31:15] == 17'b00111000011010000) || //ammin.wu
                            (x_inst[31:15] == 17'b00111000011010001) || //ammin.du
                            (x_inst[31:15] == 17'b00111000011100010) || //ammin_db.wu
                            (x_inst[31:15] == 17'b00111000011100011);   //ammin_db.du;

assign amo_max            = (x_inst[31:15] == 17'b00111000011001010) || //ammax.w
                            (x_inst[31:15] == 17'b00111000011001011) || //ammax.d
                            (x_inst[31:15] == 17'b00111000011011100) || //ammax_db.w
                            (x_inst[31:15] == 17'b00111000011011101);   //ammax_db.d;

assign amo_maxu           = (x_inst[31:15] == 17'b00111000011001110) || //ammax.wu
                            (x_inst[31:15] == 17'b00111000011001111) || //ammax.du
                            (x_inst[31:15] == 17'b00111000011100000) || //ammax_db.wu
                            (x_inst[31:15] == 17'b00111000011100001);   //ammax_db.du;

assign amo_split_inst     = amo_inst
                            && (amo_swap
                               ||  amo_add
                               ||  amo_xor
                               ||  amo_and
                               ||  amo_or
                               ||  amo_min
                               ||  amo_minu
                               ||  amo_max
                               ||  amo_maxu
                               );

assign amo_rs1[4:0]       = dp_split_long_inst[ 9: 5];  //rj
assign amo_rs2[4:0]       = dp_split_long_inst[14:10];  //rk
assign amo_rd[4:0]        = dp_split_long_inst[ 4: 0];  //rd
assign amo_rd_is_x0       = amo_rd[4:0] == 5'b0;
assign amo_more_than_4    = amo_split_inst
                            &&  amo_aq
                            &&  amo_rl;

//----------------------------------------------------------
//              FSM of inst amo ctrl logic
//----------------------------------------------------------
// State Description:
// AMO_IDLE  : id stage instruction 0 is not multi load store
//            (amo) or the first cycle to start amo FSM
// AMO_SPLIT : the amo instruction is spliting

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    amo_cur_state <= AMO_IDLE;
  else if(rtu_idu_flush_fe  ||  iu_yy_xx_cancel)
    amo_cur_state <= AMO_IDLE;
  else
    amo_cur_state <= amo_next_state;
end

// &CombBeg; @213
always @( amo_sm_start
       or ctrl_split_long_id_stall
       or amo_cur_state)
begin
  case(amo_cur_state)
  AMO_IDLE  : if(amo_sm_start)
                amo_next_state = AMO_SPLIT;
              else
                amo_next_state = AMO_IDLE;
  AMO_SPLIT : if(!ctrl_split_long_id_stall)
                amo_next_state = AMO_IDLE;
              else
                amo_next_state = AMO_SPLIT;
  default   :   amo_next_state = AMO_IDLE;
  endcase
// &CombEnd; @225
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
// assign amo_inst_vld[0]  = 1'b1;
// assign amo_inst_vld[1]  = (amo_cur_state  == AMO_IDLE)
//                           &&  (amo_aq ||  amo_rl  ||  amo_split_inst);
// assign amo_inst_vld[2]  = (amo_cur_state  == AMO_IDLE)
//                           &&  (amo_aq &&  amo_rl
//                               ||  amo_split_inst);
// assign amo_inst_vld[3]  = (amo_cur_state  == AMO_IDLE)
//                           &&  (amo_aq ||  amo_rl)
//                           &&  amo_split_inst;

assign amo_inst_vld[0]  = 1'b1;

assign amo_inst_vld[1]  = (amo_cur_state  == AMO_IDLE)
                          &&  (amo_aq || amo_rl || amo_split_inst);

assign amo_inst_vld[2]  = (amo_cur_state  == AMO_IDLE)
                          &&  amo_aq && amo_split_inst;

assign amo_inst_vld[3]  = (amo_cur_state  == AMO_IDLE)
                          &&  amo_aq && amo_split_inst;

//----------------------------------------------------------
//                  Split Instruction fence (dbar)
//----------------------------------------------------------

// dbar 0 = 0x38720000
// ibar 0 = 0x38728000

//split inst 0: fence iorw,iorw 
assign amo_fence_rl_inst_opcode[31:15]                = 17'b00111000011100100;
assign amo_fence_rl_inst_opcode[14:0]                 = 15'b000000000000000;

// &CombBeg; @249
always @( amo_fence_rl_inst_opcode[31:0])
begin
  amo_fence_rl_inst_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  amo_fence_rl_inst_data[IR_OPCODE:IR_OPCODE-31]      = amo_fence_rl_inst_opcode[31:0];
  amo_fence_rl_inst_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU;
  amo_fence_rl_inst_data[IR_SPLIT]                    = 1'b1;
  amo_fence_rl_inst_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @257
end

//split inst last: fence iorw,iorw
assign amo_fence_aq_inst_opcode[31:15]                = 17'b00111000011100100;
assign amo_fence_aq_inst_opcode[14:0]                 = 15'b000000000000000;

// &CombBeg; @265
always @( amo_fence_aq_inst_opcode[31:0])
begin
  amo_fence_aq_inst_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  amo_fence_aq_inst_data[IR_OPCODE:IR_OPCODE-31]      = amo_fence_aq_inst_opcode[31:0];
  amo_fence_aq_inst_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU;
  amo_fence_aq_inst_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @272
end

//----------------------------------------------------------
//                  Split Instruction amoload
//----------------------------------------------------------
// &CombBeg; @315
always @( amo_rs1[4:0]
       or amo_rs2[4:0]
       or amo_rd_is_x0
       or amo_rd[4:0]
       or dp_split_long_inst[31:0])
begin
  amo_amoload_inst_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  amo_amoload_inst_data[IR_OPCODE:IR_OPCODE-31]      = dp_split_long_inst[31:0];
  amo_amoload_inst_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU;
  amo_amoload_inst_data[IR_SRC0_VLD]                 = 1'b1;
  amo_amoload_inst_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0,amo_rs1[4:0]};
  amo_amoload_inst_data[IR_SRC1_VLD]                 = 1'b0;
  amo_amoload_inst_data[IR_SRC1_REG:IR_SRC1_REG-5]   = 6'd0;
  amo_amoload_inst_data[IR_DST_VLD]                  = 1'b1;
  amo_amoload_inst_data[IR_DST_REG:IR_DST_REG-5]     = amo_rd_is_x0
                                                       ? 6'd32 : {1'b0,amo_rd[4:0]};
  amo_amoload_inst_data[IR_SPLIT]                    = 1'b1;
  amo_amoload_inst_data[IR_LENGTH]                   = 1'b1;
  amo_amoload_inst_data[IR_IID_PLUS:IR_IID_PLUS-3]   = 4'd1;
  end
// &CombEnd; @331
end

//----------------------------------------------------------
//                  Split Instruction amostore
//----------------------------------------------------------
//split inst 0: amostore
// &CombBeg; @337
always @( amo_rs1[4:0]
       or amo_aq
       or dp_split_long_inst[31:0]
       or amo_rs2[4:0]
       or amo_rd_is_x0
       or amo_rd[4:0])
begin
  amo_amostore_inst_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  amo_amostore_inst_data[IR_OPCODE:IR_OPCODE-31]      = dp_split_long_inst[31:0];
  amo_amostore_inst_data[IR_INST_TYPE:IR_INST_TYPE-9] = LSU_P5;
  amo_amostore_inst_data[IR_SRC0_VLD]                 = 1'b1;
  amo_amostore_inst_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0, amo_rs1[4:0]}; // addr
  amo_amostore_inst_data[IR_SRC1_VLD]                 = 1'b1;
  amo_amostore_inst_data[IR_SRC1_REG:IR_SRC1_REG-5]   = {1'b0, amo_rs2[4:0]}; // data
  amo_amostore_inst_data[IR_SRC2_VLD]                 = 1'b1;
  amo_amostore_inst_data[IR_DST_VLD]                  = 1'b0;
  amo_amostore_inst_data[IR_DST_REG:IR_DST_REG-5]     = amo_rd_is_x0
                                                       ? 6'd32 : {1'b0,amo_rd[4:0]};
  amo_amostore_inst_data[IR_SPLIT]                    = amo_aq;
  amo_amostore_inst_data[IR_LENGTH]                   = 1'b1;
  end
// &CombEnd; @349
end

//----------------------------------------------------------
//                  Split Instruction amoalu
//----------------------------------------------------------
//split inst 0: lr
// TODO:
assign amo_amoalu_inst_op[31:15]      =   {17{amo_swap}} & 17'b00000010110000000      //addi
                                        | {17{amo_add }} & 17'b00000000000100001      //add
                                        | {17{amo_xor }} & 17'b00000000000101011      //xor
                                        | {17{amo_and }} & 17'b00000000000101001      //and
                                        | {17{amo_or  }} & 17'b00000000000101010      //or
                                        | {17{amo_min }} & 17'b00000010110000000      //min (lsu)
                                        | {17{amo_minu}} & 17'b00000010110000000      //minu (lsu)
                                        | {17{amo_max }} & 17'b00000010110000000      //max (lsu)
                                        | {17{amo_maxu}} & 17'b00000010110000000;     //maxu (lsu)

assign amo_amoalu_inst_op[14:10]      = 5'b0; //rk
assign amo_amoalu_inst_op[ 9: 5]      = 5'b0; //rj
assign amo_amoalu_inst_op[ 4: 0]      = 5'b0; //rd


// &CombBeg; @399
always @( amo_rs2[4:0]
       or amo_rd_is_x0
       or amo_rd[4:0]
       or amo_swap
       or amo_amoalu_inst_op[31:0])
begin
  amo_amoalu_inst_data[IR_WIDTH-1:0]                = {IR_WIDTH{1'b0}};
  if(1'b1) begin
  amo_amoalu_inst_data[IR_OPCODE:IR_OPCODE-31]      = amo_amoalu_inst_op[31:0];
  amo_amoalu_inst_data[IR_INST_TYPE:IR_INST_TYPE-9] = ALU;
  amo_amoalu_inst_data[IR_SRC0_VLD]                 = 1'b1;
  amo_amoalu_inst_data[IR_SRC0_REG:IR_SRC0_REG-5]   = {1'b0,amo_rs2[4:0]};
  amo_amoalu_inst_data[IR_SRC1_VLD]                 = !amo_swap;
  amo_amoalu_inst_data[IR_SRC1_REG:IR_SRC1_REG-5]   = amo_rd_is_x0
                                                      ? 6'd32 : {1'b0,amo_rd[4:0]};
  amo_amoalu_inst_data[IR_DST_VLD]                  = 1'b1;
  amo_amoalu_inst_data[IR_DST_REG:IR_DST_REG-5]     = 6'd32;  /// DEST = 32
  amo_amoalu_inst_data[IR_SPLIT]                    = 1'b1;
  amo_amoalu_inst_data[IR_LENGTH]                   = 1'b1;
  amo_amoalu_inst_data[IR_IID_PLUS:IR_IID_PLUS-3]   = 4'd1;
  end
// &CombEnd; @415
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign amo_split_stall  = (amo_cur_state  ==  AMO_IDLE)
                          &&  amo_split_inst
                          &&  amo_aq
                          &&  amo_rl;

//dep info
assign amo_lr_or_sc = lr_inst  ||  sc_inst;
//avoid empty sensitive list
assign amo_dep_info_bit = 1'b1;

// &CombBeg; @430
always @( amo_dep_info_bit)
begin
  amo_012_dep_info[DEP_WIDTH-1:0]        = {DEP_WIDTH{1'b0}};
  if(1'b1) begin
  amo_012_dep_info[DEP_INST01_SRC0_MASK] = amo_dep_info_bit;
  amo_012_dep_info[DEP_INST12_SRC0_MASK] = amo_dep_info_bit;
  amo_012_dep_info[DEP_INST02_PREG_MASK] = amo_dep_info_bit;
  end
// &CombEnd; @437
end

// &CombBeg; @439
always @( amo_dep_info_bit)
begin
  amo_123_dep_info[DEP_WIDTH-1:0]        = {DEP_WIDTH{1'b0}};
  if(1'b1) begin
  amo_123_dep_info[DEP_INST12_SRC0_MASK] = amo_dep_info_bit;
  amo_123_dep_info[DEP_INST23_SRC0_MASK] = amo_dep_info_bit;
  amo_123_dep_info[DEP_INST13_PREG_MASK] = amo_dep_info_bit;
  end
// &CombEnd; @446
end

// &CombBeg; @448
always @( amo_123_dep_info[16:0]
       or amo_012_dep_info[16:0]
       or amo_lr_or_sc
       or amo_rl)
begin
casez({amo_lr_or_sc,amo_rl})
  2'b1?:amo_dep_info[DEP_WIDTH-1:0] = {DEP_WIDTH{1'b0}};
  // 2'b00:amo_dep_info[DEP_WIDTH-1:0] = amo_012_dep_info[DEP_WIDTH-1:0];
  2'b00:amo_dep_info[DEP_WIDTH-1:0] = {DEP_WIDTH{1'b0}};
  2'b01:amo_dep_info[DEP_WIDTH-1:0] = {DEP_WIDTH{1'b0}};
  default:amo_dep_info[DEP_WIDTH-1:0] = {DEP_WIDTH{{1{1'bx}}}};
endcase
// &CombEnd; @455
end


always @( amo_amostore_inst_data[177:0]
       or amo_aq
       or amo_amoload_inst_data[177:0]
       or lr_inst
       or amo_lr_inst_data[177:0]
       or amo_cur_state
       or sc_inst
       or amo_sc_inst_data[177:0]
       or amo_fence_aq_inst_data[177:0]
       or amo_fence_rl_inst_data[177:0]
       or amo_amoalu_inst_data[177:0]
       or amo_rl)
begin
casez({amo_cur_state, amo_aq})
  {AMO_IDLE,1'b1}: //aq and rl split 1st,rl split
  begin
    amo_inst0_data[IR_WIDTH-1:0]  = amo_fence_rl_inst_data[IR_WIDTH-1:0];
    amo_inst1_data[IR_WIDTH-1:0]  = amo_amoload_inst_data[IR_WIDTH-1:0];
    amo_inst2_data[IR_WIDTH-1:0]  = amo_amostore_inst_data[IR_WIDTH-1:0];
    amo_inst3_data[IR_WIDTH-1:0]  = amo_fence_aq_inst_data[IR_WIDTH-1:0];
  end
  {AMO_IDLE,1'b0}: //only split
  begin
    amo_inst0_data[IR_WIDTH-1:0]  = amo_amoload_inst_data[IR_WIDTH-1:0];
    amo_inst1_data[IR_WIDTH-1:0]  = amo_amostore_inst_data[IR_WIDTH-1:0];
    amo_inst2_data[IR_WIDTH-1:0]  = {IR_WIDTH{1'b0}};
    amo_inst3_data[IR_WIDTH-1:0]  = {IR_WIDTH{1'b0}};
  end
  default:
  begin
    amo_inst0_data[IR_WIDTH-1:0]  = {IR_WIDTH{{1{1'bx}}}};
    amo_inst1_data[IR_WIDTH-1:0]  = {IR_WIDTH{{1{1'bx}}}};
    amo_inst2_data[IR_WIDTH-1:0]  = {IR_WIDTH{{1{1'bx}}}};
    amo_inst3_data[IR_WIDTH-1:0]  = {IR_WIDTH{{1{1'bx}}}};
  end
endcase
// &CombEnd; @554
end

//==========================================================
//                 FP fmaxa fmina instructions
//==========================================================


assign widden_split_inst_vld             = 1'b0;
assign vperm_split_mtvr_vld              = 1'b0;

assign split_long_ctrl_inst_vld[3:0] =
         {4{dp_split_long_type[0]}}  & amo_inst_vld[3:0]; 

assign split_long_ctrl_id_stall =
            dp_split_long_type[0]  &&  amo_split_stall;

assign split_long_dp_dep_info[DEP_WIDTH-1:0] =
         {DEP_WIDTH{dp_split_long_type[0]}}  &      amo_dep_info[DEP_WIDTH-1:0];

assign split_long_inst0_data[IR_WIDTH-1:0] =
         {IR_WIDTH{dp_split_long_type[0]}}  &      amo_inst0_data[IR_WIDTH-1:0];

assign split_long_inst1_data[IR_WIDTH-1:0] =
         {IR_WIDTH{dp_split_long_type[0]}}  &      amo_inst1_data[IR_WIDTH-1:0];

assign split_long_inst2_data[IR_WIDTH-1:0] =
         {IR_WIDTH{dp_split_long_type[0]}}  &      amo_inst2_data[IR_WIDTH-1:0];

assign split_long_inst3_data[IR_WIDTH-1:0] =
         {IR_WIDTH{dp_split_long_type[0]}}  &      amo_inst3_data[IR_WIDTH-1:0];


//----------------------------------------------------------
//             Re-Pack into IR data path form
//----------------------------------------------------------
// &CombBeg; @5304
always @( widden_split_inst0_vlmul[1:0]
       or split_long_inst0_data[177:0]
       or dp_split_long_bkpta_inst
       or dp_split_long_bkptb_inst
       or dp_split_long_vlmul[1:0]
       or dp_split_long_no_spec
       or vperm_split_mtvr_vld
       or dp_split_long_vl_pred
       or widden_split_inst_vld
       or widden_split_inst0_vsew[2:0]
       or dp_split_long_vsew[2:0]
       or dp_split_long_pc[14:0]
       or dp_split_long_vl[7:0])
begin
  split_long_dp_inst0_data[IR_WIDTH-1:0]              = split_long_inst0_data[IR_WIDTH-1:0];
  if(1'b1) begin
  split_long_dp_inst0_data[IR_DST_X0]                 = (split_long_inst0_data[IR_DST_REG:IR_DST_REG-5]
                                                        == 6'd0);
  split_long_dp_inst0_data[IR_SPLIT_LAST]             = !split_long_inst0_data[IR_SPLIT];
  split_long_dp_inst0_data[IR_BKPTB_INST]             = dp_split_long_bkptb_inst;
  split_long_dp_inst0_data[IR_BKPTA_INST]             = dp_split_long_bkpta_inst;
  split_long_dp_inst0_data[IR_NO_SPEC]                = dp_split_long_no_spec;
  split_long_dp_inst0_data[IR_VLMUL:IR_VLMUL-1]       = widden_split_inst_vld ? widden_split_inst0_vlmul[1:0] : dp_split_long_vlmul[1:0];
  split_long_dp_inst0_data[IR_VSEW:IR_VSEW-2]         = widden_split_inst_vld ? widden_split_inst0_vsew[2:0] : (vperm_split_mtvr_vld ? 3'b011 : dp_split_long_vsew[2:0]);
  split_long_dp_inst0_data[IR_VL:IR_VL-7]             = dp_split_long_vl[7:0];
  split_long_dp_inst0_data[IR_VL_PRED]                = dp_split_long_vl_pred;
  split_long_dp_inst0_data[IR_PC:IR_PC-14]            = dp_split_long_pc[14:0];
  end
// &CombEnd; @5319
end

// &CombBeg; @5321
always @( dp_split_long_bkpta_inst
       or dp_split_long_bkptb_inst
       or dp_split_long_vlmul[1:0]
       or dp_split_long_no_spec
       or dp_split_long_vl_pred
       or widden_split_inst1_vlmul[1:0]
       or widden_split_inst_vld
       or dp_split_long_vsew[2:0]
       or widden_split_inst1_vsew[2:0]
       or split_long_inst1_data[177:0]
       or dp_split_long_pc[14:0]
       or dp_split_long_vl[7:0])
begin
  split_long_dp_inst1_data[IR_WIDTH-1:0]              = split_long_inst1_data[IR_WIDTH-1:0];
  if(1'b1) begin
  split_long_dp_inst1_data[IR_DST_X0]                 = (split_long_inst1_data[IR_DST_REG:IR_DST_REG-5]
                                                        == 6'd0);
  split_long_dp_inst1_data[IR_SPLIT_LAST]             = !split_long_inst1_data[IR_SPLIT];
  split_long_dp_inst1_data[IR_BKPTB_INST]             = dp_split_long_bkptb_inst;
  split_long_dp_inst1_data[IR_BKPTA_INST]             = dp_split_long_bkpta_inst;
  split_long_dp_inst1_data[IR_NO_SPEC]                = dp_split_long_no_spec;
  split_long_dp_inst1_data[IR_VLMUL:IR_VLMUL-1]       = widden_split_inst_vld ? widden_split_inst1_vlmul[1:0] : dp_split_long_vlmul[1:0];
  split_long_dp_inst1_data[IR_VSEW:IR_VSEW-2]         = widden_split_inst_vld ? widden_split_inst1_vsew[2:0] : dp_split_long_vsew[2:0];
  split_long_dp_inst1_data[IR_VL:IR_VL-7]             = dp_split_long_vl[7:0];
  split_long_dp_inst1_data[IR_VL_PRED]                = dp_split_long_vl_pred;
  split_long_dp_inst1_data[IR_PC:IR_PC-14]            = dp_split_long_pc[14:0];
  end
// &CombEnd; @5336
end

// &CombBeg; @5338
always @( dp_split_long_bkpta_inst
       or dp_split_long_bkptb_inst
       or dp_split_long_vlmul[1:0]
       or dp_split_long_no_spec
       or dp_split_long_vl_pred
       or widden_split_inst_vld
       or widden_split_inst2_vsew[2:0]
       or widden_split_inst2_vlmul[1:0]
       or dp_split_long_vsew[2:0]
       or split_long_inst2_data[177:0]
       or dp_split_long_pc[14:0]
       or dp_split_long_vl[7:0])
begin
  split_long_dp_inst2_data[IR_WIDTH-1:0]              = split_long_inst2_data[IR_WIDTH-1:0];
  if(1'b1) begin
  split_long_dp_inst2_data[IR_DST_X0]                 = (split_long_inst2_data[IR_DST_REG:IR_DST_REG-5]
                                                        == 6'd0);
  split_long_dp_inst2_data[IR_SPLIT_LAST]             = !split_long_inst2_data[IR_SPLIT];
  split_long_dp_inst2_data[IR_BKPTB_INST]             = dp_split_long_bkptb_inst;
  split_long_dp_inst2_data[IR_BKPTA_INST]             = dp_split_long_bkpta_inst;
  split_long_dp_inst2_data[IR_NO_SPEC]                = dp_split_long_no_spec;
  split_long_dp_inst2_data[IR_VLMUL:IR_VLMUL-1]       = widden_split_inst_vld ? widden_split_inst2_vlmul[1:0] : dp_split_long_vlmul[1:0];
  split_long_dp_inst2_data[IR_VSEW:IR_VSEW-2]         = widden_split_inst_vld ? widden_split_inst2_vsew[2:0] : dp_split_long_vsew[2:0];
  split_long_dp_inst2_data[IR_VL:IR_VL-7]             = dp_split_long_vl[7:0];
  split_long_dp_inst2_data[IR_VL_PRED]                = dp_split_long_vl_pred;
  split_long_dp_inst2_data[IR_PC:IR_PC-14]            = dp_split_long_pc[14:0];
  end
// &CombEnd; @5353
end

// &CombBeg; @5355
always @( widden_split_inst3_vsew[2:0]
       or dp_split_long_bkpta_inst
       or dp_split_long_bkptb_inst
       or dp_split_long_vlmul[1:0]
       or dp_split_long_no_spec
       or dp_split_long_vl_pred
       or widden_split_inst_vld
       or dp_split_long_vsew[2:0]
       or widden_split_inst3_vlmul[1:0]
       or split_long_inst3_data[177:0]
       or dp_split_long_pc[14:0]
       or dp_split_long_vl[7:0])
begin
  split_long_dp_inst3_data[IR_WIDTH-1:0]              = split_long_inst3_data[IR_WIDTH-1:0];
  if(1'b1) begin
  split_long_dp_inst3_data[IR_DST_X0]                 = (split_long_inst3_data[IR_DST_REG:IR_DST_REG-5]
                                                        == 6'd0);
  split_long_dp_inst3_data[IR_SPLIT_LAST]             = !split_long_inst3_data[IR_SPLIT];
  split_long_dp_inst3_data[IR_BKPTB_INST]             = dp_split_long_bkptb_inst;
  split_long_dp_inst3_data[IR_BKPTA_INST]             = dp_split_long_bkpta_inst;
  split_long_dp_inst3_data[IR_NO_SPEC]                = dp_split_long_no_spec;
  split_long_dp_inst3_data[IR_VLMUL:IR_VLMUL-1]       = widden_split_inst_vld ? widden_split_inst3_vlmul[1:0] : dp_split_long_vlmul[1:0];
  split_long_dp_inst3_data[IR_VSEW:IR_VSEW-2]         = widden_split_inst_vld ? widden_split_inst3_vsew[2:0] : dp_split_long_vsew[2:0];
  split_long_dp_inst3_data[IR_VL:IR_VL-7]             = dp_split_long_vl[7:0];
  split_long_dp_inst3_data[IR_VL_PRED]                = dp_split_long_vl_pred;
  split_long_dp_inst3_data[IR_PC:IR_PC-14]            = dp_split_long_pc[14:0];
  end
// &CombEnd; @5370
end


// &ModuleEnd; @5373
endmodule


