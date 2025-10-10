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

// &ModuleBeg; @31
module ct_iu_bju (
  // &Ports, @32
  input    wire          cp0_iu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cp0_iu_bju_chflw_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire  [2 :0]  idu_iu_is_pcfifo_inst_num,
  input    wire          idu_iu_is_pcfifo_inst_vld,
  input    wire          idu_iu_rf_bju_gateclk_sel,
  input    wire          idu_iu_rf_bju_sel,
  input    wire  [4 :0]  idu_iu_rf_pipe0_pid,
  input    wire  [31 :0] idu_iu_rf_pipe2_opcode,
  input    wire  [7 :0]  idu_iu_rf_pipe2_func,
  input    wire  [6 :0]  idu_iu_rf_pipe2_iid,
  input    wire          idu_iu_rf_pipe2_length,
  input    wire  [27:0]  idu_iu_rf_pipe2_offset,
  input    wire          idu_iu_rf_pipe2_pcall,
  input    wire  [4 :0]  idu_iu_rf_pipe2_pid,
  input    wire          idu_iu_rf_pipe2_rts,
  input    wire  [63:0]  idu_iu_rf_pipe2_src0,
  input    wire  [63:0]  idu_iu_rf_pipe2_src1,
  input    wire  [7 :0]  idu_iu_rf_pipe2_vl,
  input    wire  [1 :0]  idu_iu_rf_pipe2_vlmul,
  input    wire  [2 :0]  idu_iu_rf_pipe2_vsew,
  input    wire          ifu_iu_pcfifo_create0_bht_pred,
  input    wire  [24:0]  ifu_iu_pcfifo_create0_chk_idx,
  input    wire  [63:0]  ifu_iu_pcfifo_create0_cur_pc,
  input    wire          ifu_iu_pcfifo_create0_dst_vld,
  input    wire          ifu_iu_pcfifo_create0_en,
  input    wire          ifu_iu_pcfifo_create0_gateclk_en,
  input    wire          ifu_iu_pcfifo_create0_jal,
  input    wire          ifu_iu_pcfifo_create0_jalr,
  input    wire          ifu_iu_pcfifo_create0_jmp_mispred,
  input    wire  [63:0]  ifu_iu_pcfifo_create0_tar_pc,
  input    wire          ifu_iu_pcfifo_create1_bht_pred,
  input    wire  [24:0]  ifu_iu_pcfifo_create1_chk_idx,
  input    wire  [63:0]  ifu_iu_pcfifo_create1_cur_pc,
  input    wire          ifu_iu_pcfifo_create1_dst_vld,
  input    wire          ifu_iu_pcfifo_create1_en,
  input    wire          ifu_iu_pcfifo_create1_gateclk_en,
  input    wire          ifu_iu_pcfifo_create1_jal,
  input    wire          ifu_iu_pcfifo_create1_jalr,
  input    wire          ifu_iu_pcfifo_create1_jmp_mispred,
  input    wire  [63:0]  ifu_iu_pcfifo_create1_tar_pc,
  input    wire          mmu_xx_mmu_en,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_iu_flush_chgflw_mask,
  input    wire          rtu_iu_flush_fe,
  input    wire          rtu_iu_rob_read0_pcfifo_vld,
  input    wire          rtu_iu_rob_read1_pcfifo_vld,
  input    wire          rtu_iu_rob_read2_pcfifo_vld,
  input    wire          rtu_iu_rob_read_pcfifo_gateclk_vld,
  input    wire          rtu_yy_xx_flush,
  output   wire          bju_cbus_ex2_pipe2_abnormal,
  output   wire          bju_cbus_ex2_pipe2_bht_mispred,
  output   wire  [6 :0]  bju_cbus_ex2_pipe2_iid,
  output   wire          bju_cbus_ex2_pipe2_jmp_mispred,
  output   wire          bju_cbus_ex2_pipe2_sel,
  output   wire          bju_rbus_ex2_pipe2_vld,
  output   wire  [6 :0]  bju_rbus_ex2_pipe2_iid,
  output   wire  [4 :0]  bju_rbus_ex2_pipe2_dreg,
  output   wire  [63:0]  bju_rbus_ex2_pipe2_pc,
  output   wire  [63:0]  bju_special_pc,
  output   wire  [6 :0]  bju_top_mispred_iid,
  output   wire          bju_top_pcfifo_full,
  output   wire          iu_idu_mispred_stall,
  output   wire  [4 :0]  iu_idu_pcfifo_dis_inst0_pid,
  output   wire  [4 :0]  iu_idu_pcfifo_dis_inst1_pid,
  output   wire  [4 :0]  iu_idu_pcfifo_dis_inst2_pid,
  output   wire  [4 :0]  iu_idu_pcfifo_dis_inst3_pid,
  output   wire          iu_ifu_bht_check_vld,
  output   wire          iu_ifu_bht_condbr_taken,
  output   wire          iu_ifu_bht_pred,
  output   wire  [62:0]  iu_ifu_chgflw_pc,
  output   wire  [7 :0]  iu_ifu_chgflw_vl,
  output   wire          iu_ifu_chgflw_vld,
  output   wire  [1 :0]  iu_ifu_chgflw_vlmul,
  output   wire  [2 :0]  iu_ifu_chgflw_vsew,
  output   wire  [24:0]  iu_ifu_chk_idx,
  output   wire  [62:0]  iu_ifu_cur_pc,
  output   wire          iu_ifu_mispred_stall,
  output   wire          iu_ifu_pcfifo_full,
  output   wire  [71:0]  iu_rtu_pcfifo_pop0_data,
  output   wire  [71:0]  iu_rtu_pcfifo_pop1_data,
  output   wire  [71:0]  iu_rtu_pcfifo_pop2_data,
  output   wire          iu_yy_xx_cancel
); 



// &Regs; @33
reg             ex1_pipe2_bht_pred;                
reg     [24:0]  ex1_pipe2_chk_idx;                 
reg     [7 :0]  ex1_pipe2_func;                    
reg     [6 :0]  ex1_pipe2_iid;                     
reg             ex1_pipe2_iid_oldest;              
reg             ex1_pipe2_inst_vld;                
reg             ex1_pipe2_jmp_mispred;             
reg             ex1_pipe2_length;                  
reg     [27:0]  ex1_pipe2_offset;                  
reg     [63:0]  ex1_pipe2_pc;                      
reg             ex1_pipe2_pcall;                   
reg     [4 :0]  ex1_pipe2_pid;                     
reg             ex1_pipe2_rts;                     
reg     [63:0]  ex1_pipe2_src0;                    
reg     [63:0]  ex1_pipe2_src1;                    
reg     [7 :0]  ex1_pipe2_vl;                      
reg     [1 :0]  ex1_pipe2_vlmul;                   
reg     [2 :0]  ex1_pipe2_vsew;  
reg     [31:0]  ex1_pipe2_opcode; 
reg     [7 :0]  ex2_pipe2_func;                  
reg             ex2_pipe2_abnormal;                
reg             ex2_pipe2_bht_mispred;             
reg             ex2_pipe2_bht_pred;                
reg             ex2_pipe2_chgflw_vld;              
reg     [24:0]  ex2_pipe2_chk_idx;                 
reg             ex2_pipe2_conbr_taken;             
reg             ex2_pipe2_conbr_vld;               
reg     [62:0]  ex2_pipe2_cur_pc;                  
reg     [6 :0]  ex2_pipe2_iid;                     
reg             ex2_pipe2_inst_vld;                
reg             ex2_pipe2_jmp;                     
reg             ex2_pipe2_jmp_mispred;             
reg             ex2_pipe2_length;                  
reg             ex2_pipe2_pcall;                   
reg     [4 :0]  ex2_pipe2_pid;                     
reg     [31:0]  ex2_pipe2_pid_expand;              
reg     [31:0]  ex2_pipe2_opcode;              
reg             ex2_pipe2_pret;                    
reg     [62:0]  ex2_pipe2_tar_pc;                  
reg     [23:0]  ex2_pipe2_tar_pc_msb;              
reg     [7 :0]  ex2_pipe2_vl;                      
reg     [1 :0]  ex2_pipe2_vlmul;                   
reg     [2 :0]  ex2_pipe2_vsew;                    
reg             ex3_pipe2_bht_mispred;             
reg             ex3_pipe2_bht_pred;                
reg             ex3_pipe2_conbr_vld;               
reg     [6 :0]  ex3_pipe2_iid;                     
reg             ex3_pipe2_inst_vld;                
reg             ex3_pipe2_jmp;                     
reg             ex3_pipe2_length;                  
reg             ex3_pipe2_pcall;                   
reg     [4 :0]  ex3_pipe2_pid;                     
reg             ex3_pipe2_pret;                    
reg     [62:0]  ex3_pipe2_tar_pc;                  
reg             idu_mispred_stall;                 
reg             ifu_mispred_stall;                 
reg     [6 :0]  mispred_iid;                       

// &Wires; @34
wire            bju_bht_mispred;                   
wire            bju_bht_mispred_vld;               
wire            bju_br_page_fault;                 
wire            bju_br_taken;                      
wire    [62:0]  bju_br_taken_tarpc;                
wire    [62:0]  bju_br_tarpc;                      
wire    [23:0]  bju_br_tarpc_msb;                  
wire    [62:0]  bju_br_untaken_tarpc;              
wire            bju_chgflw_vld;                    
wire            bju_condbr_vld;                    
wire            bju_inst_br;                       
wire            bju_inst_condbr;                   
wire            bju_inst_jmp;                      
wire            bju_inst_jump;                     
wire            bju_inst_uncondbr;                 
wire            bju_jmp_mispred;                   
wire            bju_jmp_mispred_vld;               
wire            bju_jump_page_fault;               
wire            bju_jump_src0_msb_0;               
wire            bju_jump_src0_msb_1;               
wire            bju_jump_src0_msb_ffffffe;         
wire            bju_jump_src0_msb_fffffff;         
wire    [63:0]  bju_jump_tarpc;                    
wire    [63:0]  bju_jump_tarpc_full;               
wire    [23:0]  bju_jump_tarpc_msb;                
wire            bju_jump_tarpc_no_overflow;        
wire            bju_mispred;                       
wire            bju_older_inst_vld;                
wire            bju_pcfifo_ex2_bht_mispred;        
wire            bju_pcfifo_ex2_bht_pred;           
wire            bju_pcfifo_ex2_condbr;             
wire            bju_pcfifo_ex2_inst_vld;           
wire            bju_pcfifo_ex2_jmp;                
wire            bju_pcfifo_ex2_length;             
wire    [63:0]  bju_pcfifo_ex2_pc;                 
wire            bju_pcfifo_ex2_pcall;              
wire    [4 :0]  bju_pcfifo_ex2_pid;                
wire    [31:0]  bju_pcfifo_ex2_pid_expand;         
wire            bju_pcfifo_ex2_pret;               
wire            bju_pcfifo_ex3_bht_mispred;        
wire            bju_pcfifo_ex3_bht_pred;           
wire            bju_pcfifo_ex3_condbr;             
wire            bju_pcfifo_ex3_inst_vld;           
wire            bju_pcfifo_ex3_jmp;                
wire            bju_pcfifo_ex3_length;             
wire    [63:0]  bju_pcfifo_ex3_pc;                 
wire            bju_pcfifo_ex3_pcall;              
wire    [4 :0]  bju_pcfifo_ex3_pid;                
wire            bju_pcfifo_ex3_pret;               
wire            bju_rf_iid_oldest;                 
wire            bju_rf_older_ex1;                  
wire            bju_rf_older_mispred;              
wire    [62:0]  bju_tar_pc;                        
wire    [23:0]  bju_tar_pc_msb;                    
wire            bju_tarpc_cmp_fail;                
wire            branch_beq_taken;                  
wire            branch_bge_taken;                  
wire            branch_bgeu_taken;                 
wire            branch_blt_taken;                  
wire            branch_bltu_taken;                 
wire            branch_bne_taken;                  
wire            branch_bcnez_taken;                  
wire            branch_bceqz_taken;                  
wire            branch_bnez_taken;
wire            branch_beqz_taken;
wire            condbr_taken;                      
wire            ex1_inst_clk;                      
wire            ex1_inst_clk_en;                   
wire    [31:0]  ex1_pipe2_pid_expand;              
wire            ex2_inst_clk;                      
wire            ex2_inst_clk_en;                   
wire            ex3_inst_clk;                      
wire            ex3_inst_clk_en;                   
wire    [63:0]  iu_ifu_branch_pc;                  
wire            mispred_clk;                       
wire            mispred_clk_en;                    
wire            pcfifo_bju_bht_pred;               
wire    [24:0]  pcfifo_bju_chk_idx;                
wire            pcfifo_bju_jmp_mispred;            
wire    [63:0]  pcfifo_bju_pc;                     



parameter  BJU_OP_JIRL         =  8'b10000001;            
parameter  BJU_OP_BEQ          =  8'b00010001;            
parameter  BJU_OP_BNE          =  8'b00010010;            
parameter  BJU_OP_BLT          =  8'b00010011;            
parameter  BJU_OP_BGE          =  8'b00010100;            
parameter  BJU_OP_BLTU         =  8'b00010101;            
parameter  BJU_OP_BGEU         =  8'b00010110;            
parameter  BJU_OP_BEQZ         =  8'b00010111;            
parameter  BJU_OP_BNEZ         =  8'b00011000;            
parameter  BJU_OP_BCEQZ        =  8'b00011001;            
parameter  BJU_OP_BCNEZ        =  8'b00011010;            
parameter  BJU_OP_B            =  8'b01000000;            
parameter  BJU_OP_BL           =  8'b01000001;   

//==========================================================
//                    Instance PCFIFO
//==========================================================
// &Instance("ct_iu_bju_pcfifo", "x_ct_iu_bju_pcfifo"); @40
ct_iu_bju_pcfifo  x_ct_iu_bju_pcfifo (
  .bju_pcfifo_ex2_bht_mispred         (bju_pcfifo_ex2_bht_mispred        ),
  .bju_pcfifo_ex2_bht_pred            (bju_pcfifo_ex2_bht_pred           ),
  .bju_pcfifo_ex2_condbr              (bju_pcfifo_ex2_condbr             ),
  .bju_pcfifo_ex2_inst_vld            (bju_pcfifo_ex2_inst_vld           ),
  .bju_pcfifo_ex2_jmp                 (bju_pcfifo_ex2_jmp                ),
  .bju_pcfifo_ex2_length              (bju_pcfifo_ex2_length             ),
  .bju_pcfifo_ex2_pc                  (bju_pcfifo_ex2_pc                 ),
  .bju_pcfifo_ex2_pcall               (bju_pcfifo_ex2_pcall              ),
  .bju_pcfifo_ex2_pid                 (bju_pcfifo_ex2_pid                ),
  .bju_pcfifo_ex2_pid_expand          (bju_pcfifo_ex2_pid_expand         ),
  .bju_pcfifo_ex2_pret                (bju_pcfifo_ex2_pret               ),
  .bju_pcfifo_ex3_bht_mispred         (bju_pcfifo_ex3_bht_mispred        ),
  .bju_pcfifo_ex3_bht_pred            (bju_pcfifo_ex3_bht_pred           ),
  .bju_pcfifo_ex3_condbr              (bju_pcfifo_ex3_condbr             ),
  .bju_pcfifo_ex3_inst_vld            (bju_pcfifo_ex3_inst_vld           ),
  .bju_pcfifo_ex3_jmp                 (bju_pcfifo_ex3_jmp                ),
  .bju_pcfifo_ex3_length              (bju_pcfifo_ex3_length             ),
  .bju_pcfifo_ex3_pc                  (bju_pcfifo_ex3_pc                 ),
  .bju_pcfifo_ex3_pcall               (bju_pcfifo_ex3_pcall              ),
  .bju_pcfifo_ex3_pid                 (bju_pcfifo_ex3_pid                ),
  .bju_pcfifo_ex3_pret                (bju_pcfifo_ex3_pret               ),
  .bju_special_pc                     (bju_special_pc                    ),
  .bju_top_pcfifo_full                (bju_top_pcfifo_full               ),
  .cp0_iu_icg_en                      (cp0_iu_icg_en                     ),
  .cp0_yy_clk_en                      (cp0_yy_clk_en                     ),
  .cpurst_b                           (cpurst_b                          ),
  .forever_cpuclk                     (forever_cpuclk                    ),
  .idu_iu_is_pcfifo_inst_num          (idu_iu_is_pcfifo_inst_num         ),
  .idu_iu_is_pcfifo_inst_vld          (idu_iu_is_pcfifo_inst_vld         ),
  .idu_iu_rf_pipe0_pid                (idu_iu_rf_pipe0_pid               ),
  .idu_iu_rf_pipe2_pid                (idu_iu_rf_pipe2_pid               ),
  .ifu_iu_pcfifo_create0_bht_pred     (ifu_iu_pcfifo_create0_bht_pred    ),
  .ifu_iu_pcfifo_create0_chk_idx      (ifu_iu_pcfifo_create0_chk_idx     ),
  .ifu_iu_pcfifo_create0_cur_pc       (ifu_iu_pcfifo_create0_cur_pc      ),
  .ifu_iu_pcfifo_create0_dst_vld      (ifu_iu_pcfifo_create0_dst_vld     ),
  .ifu_iu_pcfifo_create0_en           (ifu_iu_pcfifo_create0_en          ),
  .ifu_iu_pcfifo_create0_gateclk_en   (ifu_iu_pcfifo_create0_gateclk_en  ),
  .ifu_iu_pcfifo_create0_jal          (ifu_iu_pcfifo_create0_jal         ),
  .ifu_iu_pcfifo_create0_jalr         (ifu_iu_pcfifo_create0_jalr        ),
  .ifu_iu_pcfifo_create0_jmp_mispred  (ifu_iu_pcfifo_create0_jmp_mispred ),
  .ifu_iu_pcfifo_create0_tar_pc       (ifu_iu_pcfifo_create0_tar_pc      ),
  .ifu_iu_pcfifo_create1_bht_pred     (ifu_iu_pcfifo_create1_bht_pred    ),
  .ifu_iu_pcfifo_create1_chk_idx      (ifu_iu_pcfifo_create1_chk_idx     ),
  .ifu_iu_pcfifo_create1_cur_pc       (ifu_iu_pcfifo_create1_cur_pc      ),
  .ifu_iu_pcfifo_create1_dst_vld      (ifu_iu_pcfifo_create1_dst_vld     ),
  .ifu_iu_pcfifo_create1_en           (ifu_iu_pcfifo_create1_en          ),
  .ifu_iu_pcfifo_create1_gateclk_en   (ifu_iu_pcfifo_create1_gateclk_en  ),
  .ifu_iu_pcfifo_create1_jal          (ifu_iu_pcfifo_create1_jal         ),
  .ifu_iu_pcfifo_create1_jalr         (ifu_iu_pcfifo_create1_jalr        ),
  .ifu_iu_pcfifo_create1_jmp_mispred  (ifu_iu_pcfifo_create1_jmp_mispred ),
  .ifu_iu_pcfifo_create1_tar_pc       (ifu_iu_pcfifo_create1_tar_pc      ),
  .iu_idu_pcfifo_dis_inst0_pid        (iu_idu_pcfifo_dis_inst0_pid       ),
  .iu_idu_pcfifo_dis_inst1_pid        (iu_idu_pcfifo_dis_inst1_pid       ),
  .iu_idu_pcfifo_dis_inst2_pid        (iu_idu_pcfifo_dis_inst2_pid       ),
  .iu_idu_pcfifo_dis_inst3_pid        (iu_idu_pcfifo_dis_inst3_pid       ),
  .iu_ifu_pcfifo_full                 (iu_ifu_pcfifo_full                ),
  .iu_rtu_pcfifo_pop0_data            (iu_rtu_pcfifo_pop0_data           ),
  .iu_rtu_pcfifo_pop1_data            (iu_rtu_pcfifo_pop1_data           ),
  .iu_rtu_pcfifo_pop2_data            (iu_rtu_pcfifo_pop2_data           ),
  .iu_yy_xx_cancel                    (iu_yy_xx_cancel                   ),
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
  .pcfifo_bju_bht_pred                (pcfifo_bju_bht_pred               ),
  .pcfifo_bju_chk_idx                 (pcfifo_bju_chk_idx                ),
  .pcfifo_bju_jmp_mispred             (pcfifo_bju_jmp_mispred            ),
  .pcfifo_bju_pc                      (pcfifo_bju_pc                     ),
  .rtu_iu_flush_fe                    (rtu_iu_flush_fe                   ),
  .rtu_iu_rob_read0_pcfifo_vld        (rtu_iu_rob_read0_pcfifo_vld       ),
  .rtu_iu_rob_read1_pcfifo_vld        (rtu_iu_rob_read1_pcfifo_vld       ),
  .rtu_iu_rob_read2_pcfifo_vld        (rtu_iu_rob_read2_pcfifo_vld       ),
  .rtu_iu_rob_read_pcfifo_gateclk_vld (rtu_iu_rob_read_pcfifo_gateclk_vld),
  .rtu_yy_xx_flush                    (rtu_yy_xx_flush                   )
);


//==========================================================
//                      RF stage logic
//==========================================================
//----------------------------------------------------------
//                   RF IID Age compare
//----------------------------------------------------------
//during the mispred changeflow and retire, BJU exe inst may
//older or newer than the previous mispred inst.
//BJU will save and compare age by IID: new mispred could be generated
//only when it is older
//timing optimization: move ex1 iid age compare to rf stage
// &Instance("ct_rtu_compare_iid","x_ct_iu_bju_compare_iid_rf_older_ex1"); @53
ct_rtu_compare_iid  x_ct_iu_bju_compare_iid_rf_older_ex1 (
  .x_iid0                   (idu_iu_rf_pipe2_iid[6:0]),
  .x_iid0_older             (bju_rf_older_ex1        ),
  .x_iid1                   (ex1_pipe2_iid[6:0]      )
);

// &Connect(.x_iid0       (idu_iu_rf_pipe2_iid[6:0]), @54
//          .x_iid1       (ex1_pipe2_iid[6:0]), @55
//          .x_iid0_older (bju_rf_older_ex1)); @56
// &Instance("ct_rtu_compare_iid","x_ct_iu_bju_compare_iid_rf_older_mispred"); @57
ct_rtu_compare_iid  x_ct_iu_bju_compare_iid_rf_older_mispred (
  .x_iid0                   (idu_iu_rf_pipe2_iid[6:0]),
  .x_iid0_older             (bju_rf_older_mispred    ),
  .x_iid1                   (mispred_iid[6:0]        )
);

// &Connect(.x_iid0       (idu_iu_rf_pipe2_iid[6:0]), @58
//          .x_iid1       (mispred_iid[6:0]), @59
//          .x_iid0_older (bju_rf_older_mispred)); @60

assign bju_rf_iid_oldest = (!bju_chgflw_vld || bju_rf_older_ex1)
                           && (!idu_mispred_stall || bju_rf_older_mispred);

//==========================================================
//                 RF/EX1 Pipeline Register
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ex1_inst_clk_en = idu_iu_rf_bju_gateclk_sel
                         || ex1_pipe2_inst_vld;
// &Instance("gated_clk_cell", "x_ex1_inst_gated_clk"); @73
gated_clk_cell  x_ex1_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @74
//          .external_en (1'b0), @75
//          .global_en   (cp0_yy_clk_en), @76
//          .module_en   (cp0_iu_icg_en), @77
//          .local_en    (ex1_inst_clk_en), @78
//          .clk_out     (ex1_inst_clk)); @79

//----------------------------------------------------------
//               Pipe2 EX1 Instruction Valid
//----------------------------------------------------------
always @(posedge ex1_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ex1_pipe2_inst_vld <= 1'b0;
  else if(rtu_yy_xx_flush)
    ex1_pipe2_inst_vld <= 1'b0;
  else
    ex1_pipe2_inst_vld <= idu_iu_rf_bju_sel;
end

//----------------------------------------------------------
//               Pipe2 EX1 Instruction Data
//----------------------------------------------------------
always @(posedge ex1_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex1_pipe2_iid[6:0]               <= 7'b0;
    ex1_pipe2_func[7:0]              <= 8'b0;
    ex1_pipe2_opcode[31:0]           <= 32'b0;
    ex1_pipe2_src0[63:0]             <= 64'b0;
    ex1_pipe2_src1[63:0]             <= 64'b0;
    ex1_pipe2_offset[27:0]           <= 28'b0;
    ex1_pipe2_length                 <= 1'b0;
    ex1_pipe2_pcall                  <= 1'b0;
    ex1_pipe2_rts                    <= 1'b0;
    ex1_pipe2_pid[4:0]               <= 5'b0;
    ex1_pipe2_pc[63:0]               <= 64'b0;
    ex1_pipe2_bht_pred               <= 1'b0;
    ex1_pipe2_jmp_mispred            <= 1'b0;
    ex1_pipe2_chk_idx[24:0]          <= 25'b0;
    ex1_pipe2_iid_oldest             <= 1'b0;
    ex1_pipe2_vlmul[1:0]             <= 2'b0;
    ex1_pipe2_vsew[2:0]              <= 3'b0;
    ex1_pipe2_vl[7:0]                <= 8'b0;
  end
  else if(idu_iu_rf_bju_gateclk_sel) begin
    ex1_pipe2_iid[6:0]               <= idu_iu_rf_pipe2_iid[6:0];
    ex1_pipe2_func[7:0]              <= idu_iu_rf_pipe2_func[7:0];
    ex1_pipe2_opcode[31:0]           <= idu_iu_rf_pipe2_opcode[31:0];
    ex1_pipe2_src0[63:0]             <= idu_iu_rf_pipe2_src0[63:0];
    ex1_pipe2_src1[63:0]             <= idu_iu_rf_pipe2_src1[63:0];
    ex1_pipe2_offset[27:0]           <= idu_iu_rf_pipe2_offset[27:0];
    ex1_pipe2_length                 <= idu_iu_rf_pipe2_length;
    ex1_pipe2_pcall                  <= idu_iu_rf_pipe2_pcall;
    ex1_pipe2_rts                    <= idu_iu_rf_pipe2_rts;
    ex1_pipe2_pid[4:0]               <= idu_iu_rf_pipe2_pid[4:0];
    ex1_pipe2_pc[63:0]               <= pcfifo_bju_pc[63:0];
    ex1_pipe2_bht_pred               <= pcfifo_bju_bht_pred;
    ex1_pipe2_jmp_mispred            <= pcfifo_bju_jmp_mispred;
    ex1_pipe2_chk_idx[24:0]          <= pcfifo_bju_chk_idx[24:0];
    ex1_pipe2_iid_oldest             <= bju_rf_iid_oldest;
    ex1_pipe2_vlmul[1:0]             <= idu_iu_rf_pipe2_vlmul[1:0];
    ex1_pipe2_vsew[2:0]              <= idu_iu_rf_pipe2_vsew[2:0];
    ex1_pipe2_vl[7:0]                <= idu_iu_rf_pipe2_vl[7:0];
  end
  else begin
    ex1_pipe2_iid[6:0]               <= ex1_pipe2_iid[6:0];
    ex1_pipe2_func[7:0]              <= ex1_pipe2_func[7:0];
    ex1_pipe2_opcode[31:0]           <= ex1_pipe2_opcode[31:0];
    ex1_pipe2_src0[63:0]             <= ex1_pipe2_src0[63:0];
    ex1_pipe2_src1[63:0]             <= ex1_pipe2_src1[63:0];
    ex1_pipe2_offset[27:0]           <= ex1_pipe2_offset[27:0];
    ex1_pipe2_length                 <= ex1_pipe2_length;
    ex1_pipe2_pcall                  <= ex1_pipe2_pcall;
    ex1_pipe2_rts                    <= ex1_pipe2_rts;
    ex1_pipe2_pid[4:0]               <= ex1_pipe2_pid[4:0];
    ex1_pipe2_pc[63:0]               <= ex1_pipe2_pc[63:0];
    ex1_pipe2_bht_pred               <= ex1_pipe2_bht_pred;
    ex1_pipe2_jmp_mispred            <= ex1_pipe2_jmp_mispred;
    ex1_pipe2_chk_idx[24:0]          <= ex1_pipe2_chk_idx[24:0];
    ex1_pipe2_iid_oldest             <= ex1_pipe2_iid_oldest;
    ex1_pipe2_vlmul[1:0]             <= ex1_pipe2_vlmul[1:0];
    ex1_pipe2_vsew[2:0]              <= ex1_pipe2_vsew[2:0];
    ex1_pipe2_vl[7:0]                <= ex1_pipe2_vl[7:0];
  end
end

//==========================================================
//                  EX1 Execution Logic
//==========================================================
//----------------------------------------------------------
//               Prepare Instruction Type
//----------------------------------------------------------

wire bju_inst_is_beq   = ex1_pipe2_func[7:0] == BJU_OP_BEQ;
wire bju_inst_is_bne   = ex1_pipe2_func[7:0] == BJU_OP_BNE;
wire bju_inst_is_blt   = ex1_pipe2_func[7:0] == BJU_OP_BLT;
wire bju_inst_is_bge   = ex1_pipe2_func[7:0] == BJU_OP_BGE;

wire bju_inst_is_bltu  = ex1_pipe2_func[7:0] == BJU_OP_BLTU;
wire bju_inst_is_bgeu  = ex1_pipe2_func[7:0] == BJU_OP_BGEU;
wire bju_inst_is_beqz  = ex1_pipe2_func[7:0] == BJU_OP_BEQZ;
wire bju_inst_is_bnez  = ex1_pipe2_func[7:0] == BJU_OP_BNEZ;
wire bju_inst_is_bceqz = ex1_pipe2_func[7:0] == BJU_OP_BCEQZ;
wire bju_inst_is_bcnez = ex1_pipe2_func[7:0] == BJU_OP_BCNEZ;
wire bju_inst_is_b     = ex1_pipe2_func[7:0] == BJU_OP_B;
wire bju_inst_is_bl    = ex1_pipe2_func[7:0] == BJU_OP_BL;
wire bju_inst_is_jirl  = ex1_pipe2_func[7:0] == BJU_OP_JIRL;


//jal r0/rd, offset
assign bju_inst_br    = bju_inst_is_bl | bju_inst_is_b;
//jalr r0/rd, rs1, offset
assign bju_inst_jmp   = bju_inst_is_jirl;


//----------------------------------------------------------
//               Branch direction determination
//----------------------------------------------------------
//    | branch inst  |          taken condition
// 1  |     BEQ      |           src0 == src1
// 2  |     BNE      |           src0 != src1
// 3  |     BLT      | (src0 < src1) || src0[63] && !src1[63]
// 4  |     BLTU     |           src0 < src1
// 5  |     BGE      |!(src0 < src1) &&! (src0[63] && !src1[63])
// 6  |     BGEU     |          !(src0 < src1)
//----------------------------------------------------------

//Reduce logic consumption.
assign branch_beq_taken  = (ex1_pipe2_src0[63:0] == ex1_pipe2_src1[63:0]);

assign branch_bne_taken  = (ex1_pipe2_src0[63:0] != ex1_pipe2_src1[63:0]);

assign branch_blt_taken  = ex1_pipe2_src0[63] && !ex1_pipe2_src1[63]
                           || (ex1_pipe2_src0[63] ^~ ex1_pipe2_src1[63])
                              && (ex1_pipe2_src0[62:0] < ex1_pipe2_src1[62:0]);


assign branch_bltu_taken = (ex1_pipe2_src0[63:0] < ex1_pipe2_src1[63:0]);

assign branch_bge_taken  = !branch_blt_taken;

assign branch_bgeu_taken = !branch_bltu_taken;


assign branch_bnez_taken = ex1_pipe2_src0[63:0] != 64'b0;
assign branch_beqz_taken = ex1_pipe2_src0[63:0] == 64'b0;

assign branch_bceqz_taken = ex1_pipe2_src0[0] == 1'b0;
assign branch_bcnez_taken = ex1_pipe2_src0[0] != 1'b0;

// branch type is decded for prediction check in RF stage
// {BEQ, BNE, BLT, BLTU, BGE, BGEU}
assign bju_inst_condbr  =  bju_inst_is_beq
                          || bju_inst_is_bne
                          || bju_inst_is_blt
                          || bju_inst_is_bge
                          || bju_inst_is_bltu
                          || bju_inst_is_bgeu
                          || bju_inst_is_beqz
                          || bju_inst_is_bceqz
                          || bju_inst_is_bcnez
                          || bju_inst_is_bnez;

assign condbr_taken     =   bju_inst_is_bgeu  && branch_bgeu_taken
                          || bju_inst_is_bge   && branch_bge_taken
                          || bju_inst_is_bltu  && branch_bltu_taken
                          || bju_inst_is_blt   && branch_blt_taken
                          || bju_inst_is_bne   && branch_bne_taken
                          || bju_inst_is_beq   && branch_beq_taken
                          || bju_inst_is_bcnez && branch_bcnez_taken
                          || bju_inst_is_bceqz && branch_bceqz_taken
                          || bju_inst_is_bnez  && branch_bnez_taken
                          || bju_inst_is_beqz  && branch_beqz_taken;

//----------------------------------------------------------
//              branch address calculation
//----------------------------------------------------------
assign bju_inst_uncondbr = bju_inst_br;
// mux the taken and untaken tarpc
// two situations that result in selecting taken tarpc:
//   1. uncondbr inst
//   2. taken condbr inst
assign bju_br_taken       = condbr_taken || bju_inst_uncondbr;

assign bju_br_taken_tarpc[62:0] = ex1_pipe2_pc[63:1]
                                  + {{36{ex1_pipe2_offset[27]}},
                                     ex1_pipe2_offset[27:1]};

// untaken branch add 2 or 4 according to inst length
// corner case: cjalr is broken into lrw and jmp32, link reg shall use 
// the length of cjalr instead of jmp. this info is piped down from ID stage.
assign bju_br_untaken_tarpc[62:0] = ex1_pipe2_pc[63:1]
                                    + {61'b0, 1'b1, 1'b0};

assign bju_br_tarpc[62:0] = bju_br_taken ? bju_br_taken_tarpc[62:0]
                                         : bju_br_untaken_tarpc[62:0];

//if target address is not all 1 or 0, ifu should raise page fault
//branch msb can only be all 1 or 0
// assign bju_br_page_fault = mmu_xx_mmu_en && !(bju_br_tarpc[62] ^ bju_br_tarpc[61]);
assign bju_br_page_fault = cp0_iu_bju_chflw_en;

assign bju_br_tarpc_msb[23:0] = bju_br_tarpc[62:39];

//----------------------------------------------------------
//                jump address calculation
//----------------------------------------------------------
assign bju_inst_jump = bju_inst_jmp;

// jmp and jsr inst tar pc is located in oper0
assign bju_jump_tarpc[63:0] =  ex1_pipe2_src0[63:0] + 
                               {{36{ex1_pipe2_offset[27]}}, ex1_pipe2_offset[27:0]};

//if target address is not all 1 or 0, ifu should raise page fault
assign bju_jump_src0_msb_fffffff = (ex1_pipe2_src0[63:38] == {26{1'b1}});
assign bju_jump_src0_msb_ffffffe = (ex1_pipe2_src0[63:38] == {{25{1'b1}},1'b0});
assign bju_jump_src0_msb_1       = (ex1_pipe2_src0[63:38] == {{25{1'b0}},1'b1});
assign bju_jump_src0_msb_0       = (ex1_pipe2_src0[63:38] == 26'h0);

assign bju_jump_tarpc_no_overflow = !(~bju_jump_tarpc[63] && ex1_pipe2_src0[63]);

assign bju_jump_page_fault       = mmu_xx_mmu_en && !bju_jump_tarpc_no_overflow;

assign bju_jump_tarpc_full[63:0] = ex1_pipe2_src0[63:0] + 
                                   {{36{ex1_pipe2_offset[27]}}, ex1_pipe2_offset[27:0]};

assign bju_jump_tarpc_msb[23:0]  = bju_jump_tarpc_full[63:40];

//----------------------------------------------------------
//                  branch and jump mux
//----------------------------------------------------------
// jump and branch tarpc mux
assign bju_tar_pc[62:0]      = bju_inst_jump ? bju_jump_tarpc[63:1]
                                             : bju_br_tarpc[62:0];
assign bju_tar_pc_msb[23:0]  = bju_inst_jump ? bju_jump_tarpc_msb[23:0]
                                             : bju_br_tarpc_msb[23:0];

//----------------------------------------------------------
//                      BHT Check
//----------------------------------------------------------
assign bju_bht_mispred       = bju_inst_condbr
                               && (condbr_taken ^ ex1_pipe2_bht_pred)
                            || (bju_inst_condbr || bju_inst_uncondbr)
                               && bju_br_page_fault;

//----------------------------------------------------------
//                Indirect Jump / RAS Check
//----------------------------------------------------------
//pcfifo create pc of jalr is predict pc minus offset
//so only need compare to src0
assign bju_tarpc_cmp_fail    = (ex1_pipe2_pc[63:0] != ex1_pipe2_src0[63:0]);

assign bju_jmp_mispred       = bju_inst_jump && bju_tarpc_cmp_fail
                            || bju_inst_jump && !ex1_pipe2_rts
                               && ex1_pipe2_jmp_mispred
                            || bju_inst_jump && bju_jump_page_fault;

//----------------------------------------------------------
//                Change Flow (cancel) signal
//----------------------------------------------------------
assign bju_older_inst_vld    = ex1_pipe2_inst_vld
                               && ex1_pipe2_iid_oldest;

assign bju_bht_mispred_vld   = bju_older_inst_vld && bju_bht_mispred;

assign bju_jmp_mispred_vld   = bju_older_inst_vld && bju_jmp_mispred;

//mask iu change flow on wrong path during flush state machine
//when mispred iu will mask wrong path change flow by itself
assign bju_mispred           = bju_bht_mispred || bju_jmp_mispred;
assign bju_chgflw_vld        = bju_mispred
                               && !rtu_iu_flush_chgflw_mask
                               && bju_older_inst_vld;
assign bju_condbr_vld        = bju_older_inst_vld && bju_inst_condbr;

//==========================================================
//                     EX1 Cancel Logic
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell
//----------------------------------------------------------
assign mispred_clk_en = ex1_pipe2_inst_vld
                        || idu_mispred_stall
                        || ifu_mispred_stall;
// &Instance("gated_clk_cell", "x_mispred_gated_clk"); @323
gated_clk_cell  x_mispred_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (mispred_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (mispred_clk_en    ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @324
//          .external_en (1'b0), @325
//          .global_en   (cp0_yy_clk_en), @326
//          .module_en   (cp0_iu_icg_en), @327
//          .local_en    (mispred_clk_en), @328
//          .clk_out     (mispred_clk)); @329

//----------------------------------------------------------
//              Misprediction Stall and Mask
//----------------------------------------------------------
//stall ID stage until all frontend and backend pipeline empty
always @(posedge mispred_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    idu_mispred_stall <= 1'b0;
    mispred_iid[6:0]  <= 7'b0;
  end
  else if(rtu_yy_xx_flush) begin
    idu_mispred_stall <= 1'b0;
    mispred_iid[6:0]  <= mispred_iid[6:0];
  end
  else if(bju_chgflw_vld) begin
    idu_mispred_stall <= 1'b1;
    mispred_iid[6:0]  <= ex1_pipe2_iid[6:0];
  end
  else begin
    idu_mispred_stall <= idu_mispred_stall;
    mispred_iid[6:0]  <= mispred_iid[6:0];
  end
end

assign iu_idu_mispred_stall     = idu_mispred_stall;
assign bju_top_mispred_iid[6:0] = mispred_iid[6:0];

//stop IFU fetching RAS/JMP instruction before mispred inst retire
always @(posedge mispred_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ifu_mispred_stall <= 1'b0;
  else if(rtu_yy_xx_flush)
    ifu_mispred_stall <= 1'b0;
  //since no RAS/JMP inst retire after flush fe, IFU could fetch
  //new RAS/JMP instruction after flush fe, but IDU should not
  //still stall new inst pipedown at this time
  else if(rtu_iu_flush_fe)
    ifu_mispred_stall <= 1'b0;
  else if(bju_chgflw_vld)
    ifu_mispred_stall <= 1'b1;
  else
    ifu_mispred_stall <= ifu_mispred_stall;
end

assign iu_ifu_mispred_stall = ifu_mispred_stall;

//==========================================================
//              EX2 Cancel and Complete Logic
//==========================================================
//----------------------------------------------------------
//          Expand PID for BJU timing optimization
//----------------------------------------------------------
// &ConnRule(s/^x_num/ex1_pipe2_pid/); @384
// &Instance("ct_rtu_expand_32","x_ct_rtu_expand_32_ex1_pipe2_pid"); @385
ct_rtu_expand_32  x_ct_rtu_expand_32_ex1_pipe2_pid (
  .x_num                (ex1_pipe2_pid       ),
  .x_num_expand         (ex1_pipe2_pid_expand)
);


//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ex2_inst_clk_en = ex1_pipe2_inst_vld
                         || ex2_pipe2_inst_vld;
// &Instance("gated_clk_cell", "x_ex2_inst_gated_clk"); @392
gated_clk_cell  x_ex2_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @393
//          .external_en (1'b0), @394
//          .global_en   (cp0_yy_clk_en), @395
//          .module_en   (cp0_iu_icg_en), @396
//          .local_en    (ex2_inst_clk_en), @397
//          .clk_out     (ex2_inst_clk)); @398

//----------------------------------------------------------
//               Pipe2 EX2 Instruction Valid
//----------------------------------------------------------
always @(posedge ex2_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex2_pipe2_inst_vld   <= 1'b0;
    ex2_pipe2_chgflw_vld <= 1'b0;
    ex2_pipe2_conbr_vld  <= 1'b0;
  end
  else if(rtu_yy_xx_flush) begin
    ex2_pipe2_inst_vld   <= 1'b0;
    ex2_pipe2_chgflw_vld <= 1'b0;
    ex2_pipe2_conbr_vld  <= 1'b0;
  end
  else begin
    ex2_pipe2_inst_vld   <= ex1_pipe2_inst_vld;
    ex2_pipe2_chgflw_vld <= bju_chgflw_vld;
    ex2_pipe2_conbr_vld  <= bju_condbr_vld;
  end
end

//----------------------------------------------------------
//               Pipe2 EX2 Instruction Data
//----------------------------------------------------------
always @(posedge ex2_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex2_pipe2_iid[6:0]          <= 7'b0;
    ex2_pipe2_func[7:0]         <= 8'b0;
    ex2_pipe2_opcode[31:0]      <= 32'b0;
    ex2_pipe2_abnormal          <= 1'b0;
    ex2_pipe2_bht_mispred       <= 1'b0;
    ex2_pipe2_jmp_mispred       <= 1'b0;
    ex2_pipe2_tar_pc[62:0]      <= 63'b0;
    ex2_pipe2_tar_pc_msb[23:0]  <= 24'b0;
    ex2_pipe2_cur_pc[62:0]      <= 63'b0;
    ex2_pipe2_bht_pred          <= 1'b0;
    ex2_pipe2_chk_idx[24:0]     <= 25'b0;
    ex2_pipe2_pid_expand[31:0]  <= 32'b0;
    ex2_pipe2_pid[4:0]          <= 5'b0;
    ex2_pipe2_conbr_taken       <= 1'b0;
    ex2_pipe2_jmp               <= 1'b0;
    ex2_pipe2_pret              <= 1'b0;
    ex2_pipe2_pcall             <= 1'b0;
    ex2_pipe2_length            <= 1'b0;
    ex2_pipe2_vlmul[1:0]        <= 2'b0;
    ex2_pipe2_vsew[2:0]         <= 3'b0;
    ex2_pipe2_vl[7:0]           <= 8'b0;
  end
  else if(ex1_pipe2_inst_vld) begin
    ex2_pipe2_iid[6:0]          <= ex1_pipe2_iid[6:0];
    ex2_pipe2_func[7:0]         <= ex1_pipe2_func[7:0];
    ex2_pipe2_opcode[31:0]      <= ex1_pipe2_opcode[31:0];
    ex2_pipe2_abnormal          <= bju_bht_mispred_vld || bju_jmp_mispred_vld;
    ex2_pipe2_bht_mispred       <= bju_bht_mispred_vld;
    ex2_pipe2_jmp_mispred       <= bju_jmp_mispred_vld;
    ex2_pipe2_tar_pc[62:0]      <= bju_tar_pc[62:0];
    ex2_pipe2_tar_pc_msb[23:0]  <= bju_tar_pc_msb[23:0];
    ex2_pipe2_cur_pc[62:0]      <= ex1_pipe2_pc[63:1];
    ex2_pipe2_bht_pred          <= ex1_pipe2_bht_pred;
    ex2_pipe2_chk_idx[24:0]     <= ex1_pipe2_chk_idx[24:0];
    ex2_pipe2_pid_expand[31:0]  <= ex1_pipe2_pid_expand[31:0];
    ex2_pipe2_pid[4:0]          <= ex1_pipe2_pid[4:0];
    ex2_pipe2_conbr_taken       <= condbr_taken; 
    ex2_pipe2_jmp               <= bju_inst_jump;
    ex2_pipe2_pret              <= ex1_pipe2_rts;
    ex2_pipe2_pcall             <= ex1_pipe2_pcall;
    ex2_pipe2_length            <= ex1_pipe2_length;
    ex2_pipe2_vlmul[1:0]        <= ex1_pipe2_vlmul[1:0];
    ex2_pipe2_vsew[2:0]         <= ex1_pipe2_vsew[2:0];
    ex2_pipe2_vl[7:0]           <= ex1_pipe2_vl[7:0];
  end
  else begin
    ex2_pipe2_iid[6:0]          <= ex2_pipe2_iid[6:0];
    ex2_pipe2_func[7:0]         <= ex2_pipe2_func[7:0];
    ex2_pipe2_opcode[31:0]      <= ex2_pipe2_opcode[31:0];
    ex2_pipe2_abnormal          <= ex2_pipe2_abnormal;
    ex2_pipe2_bht_mispred       <= ex2_pipe2_bht_mispred;
    ex2_pipe2_jmp_mispred       <= ex2_pipe2_jmp_mispred;
    ex2_pipe2_tar_pc[62:0]      <= ex2_pipe2_tar_pc[62:0];
    ex2_pipe2_tar_pc_msb[23:0]  <= ex2_pipe2_tar_pc_msb[23:0];
    ex2_pipe2_cur_pc[62:0]      <= ex2_pipe2_cur_pc[62:0];
    ex2_pipe2_bht_pred          <= ex2_pipe2_bht_pred;
    ex2_pipe2_chk_idx[24:0]     <= ex2_pipe2_chk_idx[24:0];
    ex2_pipe2_pid_expand[31:0]  <= ex2_pipe2_pid_expand[31:0];
    ex2_pipe2_pid[4:0]          <= ex2_pipe2_pid[4:0];
    ex2_pipe2_conbr_taken       <= ex2_pipe2_conbr_taken; 
    ex2_pipe2_jmp               <= ex2_pipe2_jmp;
    ex2_pipe2_pret              <= ex2_pipe2_pret;
    ex2_pipe2_pcall             <= ex2_pipe2_pcall;
    ex2_pipe2_length            <= ex2_pipe2_length;
    ex2_pipe2_vlmul[1:0]        <= ex2_pipe2_vlmul[1:0];
    ex2_pipe2_vsew[2:0]         <= ex2_pipe2_vsew[2:0];
    ex2_pipe2_vl[7:0]           <= ex2_pipe2_vl[7:0];
  end
end

//----------------------------------------------------------
//                 Write Result to PCFIFO
//----------------------------------------------------------
//write result to PCFIFO at EX2 stage and bypass in pcfifo
assign bju_pcfifo_ex2_inst_vld         = ex2_pipe2_inst_vld;
assign bju_pcfifo_ex2_pid_expand[31:0] = ex2_pipe2_pid_expand[31:0];
assign bju_pcfifo_ex2_pid[4:0]         = ex2_pipe2_pid[4:0];
assign bju_pcfifo_ex2_bht_mispred      = ex2_pipe2_bht_mispred;
assign bju_pcfifo_ex2_jmp              = ex2_pipe2_jmp;
assign bju_pcfifo_ex2_pret             = ex2_pipe2_pret;
assign bju_pcfifo_ex2_pcall            = ex2_pipe2_pcall;
assign bju_pcfifo_ex2_condbr           = ex2_pipe2_conbr_vld;
assign bju_pcfifo_ex2_pc[63:0]         = {ex2_pipe2_tar_pc[62:0], 1'b0};
assign bju_pcfifo_ex2_length           = ex2_pipe2_length;
assign bju_pcfifo_ex2_bht_pred         = ex2_pipe2_bht_pred;

//----------------------------------------------------------
//               Interface to Complete Bus
//----------------------------------------------------------
assign bju_cbus_ex2_pipe2_sel         = ex2_pipe2_inst_vld;

assign bju_cbus_ex2_pipe2_iid[6:0]    = ex2_pipe2_iid[6:0];

assign bju_cbus_ex2_pipe2_abnormal    = ex2_pipe2_abnormal;

assign bju_cbus_ex2_pipe2_jmp_mispred = ex2_pipe2_jmp_mispred;

assign bju_cbus_ex2_pipe2_bht_mispred = ex2_pipe2_bht_mispred;

assign bju_rbus_ex2_pipe2_pc[63:0]    = iu_ifu_branch_pc[63:0];
assign bju_rbus_ex2_pipe2_vld         = ex2_pipe2_inst_vld;
assign bju_rbus_ex2_pipe2_iid[6:0]    = ex2_pipe2_iid[6:0];
assign bju_rbus_ex2_pipe2_dreg[4:0]   = (ex2_pipe2_func[7:0] == BJU_OP_BL) ?
                                      5'b00001 // ra
                                      : ex2_pipe2_opcode[4:0];

//----------------------------------------------------------
//                  Interface to IDU
//----------------------------------------------------------
// &Force("output","iu_yy_xx_cancel"); @524
assign iu_yy_xx_cancel                = ex2_pipe2_chgflw_vld;

//----------------------------------------------------------
//                  Interface to IFU
//----------------------------------------------------------
assign iu_ifu_chgflw_vld              = ex2_pipe2_chgflw_vld;

assign iu_ifu_chgflw_pc[62:0]         = {ex2_pipe2_tar_pc_msb[23:0],
                                         ex2_pipe2_tar_pc[62:0]};
assign iu_ifu_branch_pc[63:0]         = {iu_ifu_chgflw_pc[62:0], 1'b0};
assign iu_ifu_cur_pc[62:0]            = ex2_pipe2_cur_pc[62:0];
assign iu_ifu_bht_pred                = ex2_pipe2_bht_pred;
assign iu_ifu_chk_idx[24:0]           = ex2_pipe2_chk_idx[24:0];
assign iu_ifu_bht_check_vld           = ex2_pipe2_conbr_vld;
assign iu_ifu_bht_condbr_taken        = ex2_pipe2_conbr_taken;
assign iu_ifu_chgflw_vlmul[1:0]       = ex2_pipe2_vlmul[1:0];
assign iu_ifu_chgflw_vsew[2:0]        = ex2_pipe2_vsew[2:0];
assign iu_ifu_chgflw_vl[7:0]          = ex2_pipe2_vl[7:0];

//==========================================================
//              EX3 PCFIFO Bypass Pipeline
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ex3_inst_clk_en = ex2_pipe2_inst_vld
                         || ex3_pipe2_inst_vld;
// &Instance("gated_clk_cell", "x_ex3_inst_gated_clk"); @551
gated_clk_cell  x_ex3_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @552
//          .external_en (1'b0), @553
//          .global_en   (cp0_yy_clk_en), @554
//          .module_en   (cp0_iu_icg_en), @555
//          .local_en    (ex3_inst_clk_en), @556
//          .clk_out     (ex3_inst_clk)); @557

//----------------------------------------------------------
//               Pipe2 EX3 Instruction Valid
//----------------------------------------------------------
always @(posedge ex3_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    ex3_pipe2_inst_vld   <= 1'b0;
  else if(rtu_yy_xx_flush)
    ex3_pipe2_inst_vld   <= 1'b0;
  else
    ex3_pipe2_inst_vld   <= ex2_pipe2_inst_vld;
end

//----------------------------------------------------------
//               Pipe2 EX3 Instruction Data
//----------------------------------------------------------
always @(posedge ex3_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    ex3_pipe2_iid[6:0]          <= 7'b0;
    ex3_pipe2_bht_mispred       <= 1'b0;
    ex3_pipe2_tar_pc[62:0]      <= 39'b0;
    ex3_pipe2_bht_pred          <= 1'b0;
    ex3_pipe2_pid[4:0]          <= 5'b0;
    ex3_pipe2_conbr_vld         <= 1'b0;
    ex3_pipe2_jmp               <= 1'b0;
    ex3_pipe2_pret              <= 1'b0;
    ex3_pipe2_pcall             <= 1'b0;
    ex3_pipe2_length            <= 1'b0;
  end
  else if(ex2_pipe2_inst_vld) begin
    ex3_pipe2_iid[6:0]          <= ex2_pipe2_iid[6:0];
    ex3_pipe2_bht_mispred       <= ex2_pipe2_bht_mispred;
    ex3_pipe2_tar_pc[62:0]      <= ex2_pipe2_tar_pc[62:0];
    ex3_pipe2_bht_pred          <= ex2_pipe2_bht_pred;
    ex3_pipe2_pid[4:0]          <= ex2_pipe2_pid[4:0];
    ex3_pipe2_conbr_vld         <= ex2_pipe2_conbr_vld;
    ex3_pipe2_jmp               <= ex2_pipe2_jmp;
    ex3_pipe2_pret              <= ex2_pipe2_pret;
    ex3_pipe2_pcall             <= ex2_pipe2_pcall;
    ex3_pipe2_length            <= ex2_pipe2_length;
  end
  else begin
    ex3_pipe2_iid[6:0]          <= ex3_pipe2_iid[6:0];
    ex3_pipe2_bht_mispred       <= ex3_pipe2_bht_mispred;
    ex3_pipe2_tar_pc[62:0]      <= ex3_pipe2_tar_pc[62:0];
    ex3_pipe2_bht_pred          <= ex3_pipe2_bht_pred;
    ex3_pipe2_pid[4:0]          <= ex3_pipe2_pid[4:0];
    ex3_pipe2_conbr_vld         <= ex3_pipe2_conbr_vld;
    ex3_pipe2_jmp               <= ex3_pipe2_jmp;
    ex3_pipe2_pret              <= ex3_pipe2_pret;
    ex3_pipe2_pcall             <= ex3_pipe2_pcall;
    ex3_pipe2_length            <= ex3_pipe2_length;
  end
end

//----------------------------------------------------------
//                 Write Result to PCFIFO
//----------------------------------------------------------
//bypass in pcfifo
assign bju_pcfifo_ex3_inst_vld         = ex3_pipe2_inst_vld;
assign bju_pcfifo_ex3_pid[4:0]         = ex3_pipe2_pid[4:0];
assign bju_pcfifo_ex3_bht_mispred      = ex3_pipe2_bht_mispred;
assign bju_pcfifo_ex3_jmp              = ex3_pipe2_jmp;
assign bju_pcfifo_ex3_pret             = ex3_pipe2_pret;
assign bju_pcfifo_ex3_pcall            = ex3_pipe2_pcall;
assign bju_pcfifo_ex3_condbr           = ex3_pipe2_conbr_vld;
assign bju_pcfifo_ex3_pc[63:0]         = {ex3_pipe2_tar_pc[62:0], 1'b0};
assign bju_pcfifo_ex3_length           = ex3_pipe2_length;
assign bju_pcfifo_ex3_bht_pred         = ex3_pipe2_bht_pred;


// &ModuleEnd; @631
endmodule


