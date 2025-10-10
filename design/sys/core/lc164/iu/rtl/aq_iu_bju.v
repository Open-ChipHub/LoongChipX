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


// &ModuleBeg; @24
module aq_iu_bju (
  // &Ports, @25
  input    wire  [63:0]  ag_bju_pc,
  input    wire          cp0_iu_icg_en,
  input    wire  [63:0]  cp0_xx_mrvbr,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [63:0]  da_xx_fwd_data,
  input    wire  [5 :0]  da_xx_fwd_dst_reg,
  input    wire          da_xx_fwd_vld,
  input    wire          forever_cpuclk,
  input    wire          hpcp_iu_cnt_en,
  input    wire          idu_bju_ex1_gateclk_sel,
  input    wire  [31:0]  idu_iu_ex1_inst,
  input    wire  [1 :0]  idu_iu_ex1_bht_pred,
  input    wire          idu_iu_ex1_bju_br_sel,
  input    wire          idu_iu_ex1_bju_dp_sel,
  input    wire          idu_iu_ex1_bju_sel,
  input    wire  [5 :0]  idu_iu_ex1_dst_preg,
  input    wire  [19:0]  idu_iu_ex1_func,
  input    wire          idu_iu_ex1_inst_len,
  input    wire          idu_iu_ex1_inst_vld,
  input    wire          idu_iu_ex1_pipedown_vld,
  input    wire          idu_iu_ex1_split,
  input    wire  [63:0]  idu_iu_ex1_src0,
  input    wire          idu_iu_ex1_src0_ready,
  input    wire  [5 :0]  idu_iu_ex1_src0_reg,
  input    wire  [63:0]  idu_iu_ex1_src1,
  input    wire          idu_iu_ex1_src1_ready,
  input    wire  [5 :0]  idu_iu_ex1_src1_reg,
  input    wire  [63:0]  idu_iu_ex1_src2,
  input    wire  [2 :0]  idu_iu_ex1_srcc_reg,
  input    wire          idu_iu_ex1_srcc,
  input    wire  [63:0]  ifu_iu_chgflw_pc,
  input    wire          ifu_iu_chgflw_vld,
  input    wire  [63:0]  ifu_iu_ex1_pc_pred,
  input    wire          ifu_iu_reset_vld,
  input    wire          ifu_iu_warm_up,
  input    wire  [63:0]  lsu_iu_ex2_data,
  input    wire          lsu_iu_ex2_data_vld,
  input    wire  [4 :0]  lsu_iu_ex2_dest_reg,
  input    wire          mmu_xx_mmu_en,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_iu_ex1_cmplt,
  input    wire          rtu_iu_ex1_cmplt_dp,
  input    wire          rtu_iu_ex1_inst_len,
  input    wire          rtu_iu_ex1_inst_split,
  input    wire  [63:0]  rtu_iu_ex2_cur_pc,
  input    wire  [63:0]  rtu_iu_ex2_next_pc,
  output   wire  [63:0]  bju_ag_cur_pc,
  output   wire  [63:0]  bju_ag_offset,
  output   wire          bju_ag_offset_sel,
  output   wire          bju_ag_use_pc,
  output   wire  [3 :0]  bju_deginfo,
  output   wire          bju_entry_no_vld,
  output   wire          bju_ras_not_vld,
  output   wire  [63:0]  iu_cp0_ex1_cur_pc,
  output   wire          iu_hpcp_inst_bht_mispred,
  output   wire          iu_hpcp_inst_condbr,
  output   wire          iu_hpcp_jump_8m,
  output   wire          iu_idu_bju_full,
  output   wire          iu_idu_bju_global_full,
  output   wire  [63:0]  iu_ifu_bht_cur_pc,
  output   wire          iu_ifu_bht_mispred,
  output   wire          iu_ifu_bht_mispred_gate,
  output   wire  [1 :0]  iu_ifu_bht_pred,
  output   wire          iu_ifu_bht_taken,
  output   wire          iu_ifu_br_vld,
  output   wire          iu_ifu_br_vld_gate,
  output   wire          iu_ifu_link_vld,
  output   wire          iu_ifu_link_vld_gate,
  output   wire          iu_ifu_pc_mispred,
  output   wire          iu_ifu_pc_mispred_gate,
  output   wire          iu_ifu_ret_vld,
  output   wire          iu_ifu_ret_vld_gate,
  output   wire  [63:0]  iu_ifu_tar_pc,
  output   wire          iu_ifu_tar_pc_vld,
  output   wire          iu_ifu_tar_pc_vld_gate,
  output   wire  [15:0]  iu_lsu_ex1_cur_pc,
  output   wire          iu_rtu_depd_lsu_chgflow_vld,
  output   wire  [63:0]  iu_rtu_depd_lsu_next_pc,
  output   wire          iu_rtu_ex1_bju_cmplt,
  output   wire          iu_rtu_ex1_bju_cmplt_dp,
  output   wire  [63:0]  iu_rtu_ex1_bju_data,
  output   wire          iu_rtu_ex1_bju_inst_len,
  output   wire  [5 :0]  iu_rtu_ex1_bju_preg,
  output   wire          iu_rtu_ex1_bju_wb_dp,
  output   wire          iu_rtu_ex1_bju_wb_vld,
  output   wire          iu_rtu_ex1_branch_inst,
  output   wire  [63:0]  iu_rtu_ex1_cur_pc,
  output   wire  [63:0]  iu_rtu_ex1_next_pc,
  output   wire          iu_rtu_ex2_bju_ras_mispred,
  output   wire          iu_yy_xx_cancel
); 



// &Regs; @26
reg             bht_mispred;                 
reg     [1 :0]  bju_bht_pred_flop;           
reg     [27:0]  bju_branch_imm_flop;         
reg             bju_entry_src0_vld;          
reg             bju_entry_src1_vld;          
reg             bju_entry_vld;               
reg     [3 :0]  bju_func_flop;               
reg             bju_inst_j;                  
reg             bju_inst_len_flop;           
reg             bju_j_8m;                    
reg     [63:0]  bju_not_pred_pc_flop;        
reg     [62:0]  bju_pcgen_pc_39_1;           
reg             bju_ras_mispred_vld;         
reg     [63:0]  bju_src0_flop;               
reg     [4 :0]  bju_src0_reg_flop;           
reg     [63:0]  bju_src1_flop;               
reg     [4 :0]  bju_src1_reg_flop;           
reg             bju_srcc_flop;               
reg     [31:0]  bju_exe_inst;           
reg             inst_condbr;                 

// &Wires; @27
wire    [63:0]  bju_ag_tar_pc;               
wire            bju_ag_tar_pc_sel;           
wire            bju_auipc_sel;               
wire            bju_beq_taken;               
wire            bju_beqz_taken;               
wire    [63:0]  bju_bht_cur_pc;              
wire            bju_bht_mispred;             
wire            bju_bht_mispred_entry;       
wire            bju_bht_mispred_no_entry;    
wire    [1 :0]  bju_bht_pred;                
wire            bju_bht_taken;               
wire            bju_blt_taken;               
wire            bju_br_vld;                  
wire            bju_br_vld_gate;             
wire            bju_clk;                     
wire            bju_clk_en;                  
wire            bju_cond_br_taken;           
wire            bju_cond_br_taken_raw;       
wire            bju_cond_sel;                
wire            bju_cond_sel_ex1;            
wire    [63:0]  bju_cur_pc_ext;              
wire            bju_depend_lsu;              
wire            bju_depend_lsu_cmplt;        
wire            bju_depend_lsu_src0;         
wire            bju_depend_lsu_src0_raw;     
wire            bju_depend_lsu_src1;         
wire            bju_depend_lsu_src1_raw;     
wire            bju_entry_clk;               
wire            bju_entry_clk_en;            
wire            bju_entry_pop;               
wire            bju_entry_src0_vld_initial;  
wire            bju_entry_src1_vld_initial;  
wire            bju_entry_vld_set;           
wire            bju_ex1_inst_cmplt_no_depend; 
wire            bju_ex1_inst_no_depd;        
wire            bju_ex1_use_pc;              
wire    [19:0]  bju_func;                    
wire    [4 :0]  bju_fwd_src0_reg;            
wire    [4 :0]  bju_fwd_src1_reg;            
wire    [40:0]  bju_hpcp_adder_src0;         
wire    [40:0]  bju_hpcp_adder_src1;         
wire    [63:0]  bju_hpcp_cur_pc;             
wire    [40:0]  bju_hpcp_jump_pc;            
wire    [63:0]  bju_hpcp_next_pc;            
wire    [62:0]  bju_inc_pc_63_1_wb;          
wire    [63:0]  bju_inc_pc_adder0;           
wire    [63:0]  bju_inc_pc_adder1;           
wire    [63:0]  bju_inc_pc_ext;              
wire    [62:0]  bju_inc_pc_ext_63_1;         
wire    [62:0]  bju_inc_pc_ext_63_1_16bit;   
wire    [62:0]  bju_inc_pc_ext_63_1_32bit;   
wire    [63:0]  bju_inc_pc_wb_data;          
wire            bju_inst_cmplt;              
wire            bju_inst_cmplt_dp;           
wire            bju_inst_j_set;              
wire            bju_inst_jalr;               
wire    [40:0]  bju_j_8m_cmp_neg;            
wire    [40:0]  bju_j_8m_cmp_pos;            
wire            bju_j_8m_judge_rst;          
wire            bju_j_8m_neg_judge;          
wire            bju_j_8m_pos_judge;          
wire            bju_j_8m_update;             
wire            bju_link_vld;                
wire            bju_link_vld_raw;            
wire            bju_lsu_wb_fwd_src0_vld;     
wire            bju_lsu_wb_fwd_src1_vld;     
wire    [63:0]  bju_next_pc;                 
wire    [62:0]  bju_next_pc_update;          
wire            bju_not_ex1_chgflw;          
wire    [63:0]  bju_not_ex1_tar_pc;          
wire    [63:0]  bju_not_ex1_tar_pc_raw;      
wire    [63:0]  bju_not_pred_pc;             
wire    [4 :0]  bju_op_func;                 
wire            bju_pc_cmp_fail;             
wire            bju_pc_cmp_gate;             
wire            bju_pc_cmp_set;              
wire            bju_pc_reg_mispred;          
wire    [63:0]  bju_pcgen_pc;                
wire            bju_ras_pc_mispred_set;      
wire            bju_ret_vld;                 
wire            bju_ret_vld_raw;             
wire    [63:0]  bju_src0;                    
wire            bju_src0_fwd_vld;            
wire            bju_src0_lt_src1;            
wire            bju_src0_lt_src1_signed;     
wire    [63:0]  bju_src0_raw;                
wire    [4 :0]  bju_src0_reg;                
wire    [63:0]  bju_src0_tmp;                
wire    [63:0]  bju_src1;                    
wire            bju_srcc;            
wire            bju_src1_fwd_vld;            
wire    [63:0]  bju_src1_raw;                
wire    [4 :0]  bju_src1_reg;                
wire    [63:0]  bju_src1_tmp;                
wire    [63:0]  bju_src2_raw;                
wire            bju_src_dst_reg_equal;       
wire            bju_tar_pc_vld;              
wire            bju_tar_pc_vld_gate;         
wire            bju_tar_pc_vld_raw;          
wire            bju_uncond_sel;              
wire            idu_iu_ex1_bju_depd_lsu_src0; 
wire            idu_iu_ex1_bju_depd_lsu_src1; 
wire            iu_hpcp_inst_bht_mispred_set; 
wire            iu_hpcp_inst_condbr_set;     
wire            iu_hpcp_j_inst_en;           
wire            bju_br_inst_beq;
wire            bju_br_inst_bne;
wire            bju_br_inst_blt;
wire            bju_br_inst_bltu;
wire            bju_br_inst_bge;
wire            bju_br_inst_bgeu;
wire            bju_br_inst_beqz;
wire            bju_br_inst_bnez;
wire            bju_br_inst_bceqz;
wire            bju_br_inst_bcnez;
wire            bju_br_unsigned;
wire    [63:0]  ag_bju_pc_rebuild;
wire            bju_func_pcadd;
wire            bju_can_wb_inst;
wire            bju_bceqz_taken;

// &Force("input", "idu_iu_ex1_split"); @29
// &Force("input", "idu_iu_ex1_pipedown_vld"); @30
// &Force("input", "idu_iu_ex1_inst_vld"); @31
// &Force("bus", "cp0_xx_mrvbr", 39, 0); @32
// &Force("bus", "ifu_iu_chgflw_pc", 39, 0); @33
// &Force("bus", "idu_iu_ex1_src0_reg", 5, 0); @34
// &Force("bus", "idu_iu_ex1_src1_reg", 5, 0); @35
// &Force("bus", "idu_iu_ex1_dst_preg", 5, 0); @36
// &Force("bus", "da_xx_fwd_dst_reg", 5, 0); @37

//==========================================================
//                   Operand  Prepare
//==========================================================
assign bju_func[19:0] = idu_iu_ex1_func[19:0] & {20{idu_iu_ex1_bju_dp_sel}};
assign bju_depend_lsu_src0_raw = idu_iu_ex1_bju_depd_lsu_src0 && bju_func[8]; // func[6] : cond branch inst
assign bju_depend_lsu_src1_raw = idu_iu_ex1_bju_depd_lsu_src1 && bju_func[6];
assign idu_iu_ex1_bju_depd_lsu_src0 = !idu_iu_ex1_src0_ready;
assign idu_iu_ex1_bju_depd_lsu_src1 = !idu_iu_ex1_src1_ready;

// lsu da fwd
assign bju_lsu_wb_fwd_src0_vld = da_xx_fwd_vld && da_xx_fwd_dst_reg[4:0] == bju_fwd_src0_reg[4:0] && bju_depend_lsu_src0_raw;
assign bju_lsu_wb_fwd_src1_vld = da_xx_fwd_vld && da_xx_fwd_dst_reg[4:0] == bju_fwd_src1_reg[4:0] && bju_depend_lsu_src1_raw;

assign bju_depend_lsu_src0 = idu_iu_ex1_bju_depd_lsu_src0 && bju_func[8] && !bju_lsu_wb_fwd_src0_vld;
assign bju_depend_lsu_src1 = idu_iu_ex1_bju_depd_lsu_src1 && bju_func[6] && !bju_lsu_wb_fwd_src1_vld;
// bju_depend lsu : 1. src not ready
//                  2. cond branch inst
//                  3. no lsu da fwd or after fwd still depend
assign bju_depend_lsu      = bju_depend_lsu_src0 || bju_depend_lsu_src1;

// operand mux
assign bju_src0_tmp[63:0] = idu_iu_ex1_src0[63:0] & {64{idu_bju_ex1_gateclk_sel}};
assign bju_src1_tmp[63:0] = idu_iu_ex1_src1[63:0] & {64{idu_bju_ex1_gateclk_sel}};
assign bju_src2_raw[63:0] = idu_iu_ex1_src2[63:0] & {64{idu_bju_ex1_gateclk_sel}};

// if da fwd vld, this cond branch inst not depend lsu
assign bju_src0_raw[63:0] = bju_lsu_wb_fwd_src0_vld ? da_xx_fwd_data[63:0] : bju_src0_tmp[63:0];
assign bju_src1_raw[63:0] = bju_lsu_wb_fwd_src1_vld ? da_xx_fwd_data[63:0] : bju_src1_tmp[63:0];
assign bju_srcc_raw       = idu_iu_ex1_srcc & idu_bju_ex1_gateclk_sel;

assign bju_src0_reg[4:0] = idu_iu_ex1_src0_reg[4:0];
assign bju_src1_reg[4:0] = idu_iu_ex1_src1_reg[4:0];

// lsu dc fwd
assign bju_src0_fwd_vld = lsu_iu_ex2_data_vld && lsu_iu_ex2_dest_reg[4:0] == bju_fwd_src0_reg[4:0] &&
                         (bju_depend_lsu_src0 && !bju_entry_vld || !bju_entry_src0_vld && bju_entry_vld);
assign bju_src1_fwd_vld = lsu_iu_ex2_data_vld && lsu_iu_ex2_dest_reg[4:0] == bju_fwd_src1_reg[4:0] &&
                         (bju_depend_lsu_src1 && !bju_entry_vld || !bju_entry_src1_vld && bju_entry_vld);

assign bju_fwd_src0_reg[4:0] = bju_entry_vld ? bju_src0_reg_flop[4:0] : bju_src0_reg[4:0];
assign bju_fwd_src1_reg[4:0] = bju_entry_vld ? bju_src1_reg_flop[4:0] : bju_src1_reg[4:0];

assign bju_ex1_inst_no_depd = !bju_depend_lsu && idu_iu_ex1_bju_dp_sel;
assign bju_entry_vld_set    = bju_depend_lsu;
assign bju_entry_pop        = bju_entry_src0_vld && bju_entry_src1_vld && bju_entry_vld;

// this signal for bju no op
assign bju_entry_no_vld     = !bju_entry_vld;

assign bju_cond_sel_ex1         = bju_func[8];
assign bju_uncond_sel           = bju_func[5];
assign bju_auipc_sel            = bju_func[7];
assign bju_ag_cur_pc[63:0]      = bju_pcgen_pc[63:0];

// entry inst calculate jump tar pc
assign bju_ag_offset[63:0]      = {{35{bju_branch_imm_flop[27]}}, bju_branch_imm_flop[27:0], 1'b0};
assign bju_ag_offset_sel        = bju_entry_vld;

assign iu_idu_bju_full        = bju_entry_vld && bju_entry_src0_vld && bju_entry_src1_vld;
assign iu_idu_bju_global_full = bju_entry_vld && !(bju_entry_src0_vld && bju_entry_src1_vld);

assign bju_depend_lsu_cmplt = !bju_entry_vld && (!bju_depend_lsu_src0 || bju_src0_fwd_vld) &&
                             (!bju_depend_lsu_src1 || bju_src1_fwd_vld) && bju_depend_lsu  && idu_iu_ex1_bju_sel || // ex1 lsu fwd vld, cmplt in ex1
                               bju_entry_vld && !(bju_entry_src0_vld  && bju_entry_src1_vld)   &&
                             (!bju_entry_src0_vld  && bju_src0_fwd_vld  || bju_entry_src0_vld) &&
                             (!bju_entry_src1_vld  && bju_src1_fwd_vld  || bju_entry_src1_vld);  //cmplt in entry


//==========================================================
//                    BJU Inst Entry
//==========================================================
always @ (posedge bju_entry_clk)
begin
  if (bju_depend_lsu && !bju_entry_vld && idu_iu_ex1_bju_sel || ifu_iu_warm_up) begin
    bju_func_flop[3:0]          <= bju_func[4:1];                // inst func
    bju_exe_inst[31:0]          <= idu_iu_ex1_inst[31:0];
    bju_bht_pred_flop[1:0]      <= idu_iu_ex1_bht_pred[1:0];     // bht pred
    bju_not_pred_pc_flop[63:0]  <= bju_not_pred_pc[63:0];        // not pred pc: chgflow tar pc
    bju_src0_reg_flop[4:0]      <= bju_src0_reg[4:0];
    bju_src1_reg_flop[4:0]      <= bju_src1_reg[4:0];
    bju_inst_len_flop           <= idu_iu_ex1_inst_len;
    bju_branch_imm_flop[27:0]   <= bju_src2_raw[28:1];           // jump pc offset
  end
end

// if ex1 fwd vld, src_vld set 1
assign bju_entry_src0_vld_initial = !bju_depend_lsu_src0 || bju_src0_fwd_vld;
always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_entry_src0_vld <= 1'b0;
  else if(bju_entry_pop)
    bju_entry_src0_vld <= 1'b0;
  else if(bju_depend_lsu && !bju_entry_vld && idu_iu_ex1_bju_sel)
    bju_entry_src0_vld <= bju_entry_src0_vld_initial;
  else if(bju_src0_fwd_vld)
    bju_entry_src0_vld <= 1'b1;
end

assign bju_entry_src1_vld_initial = !bju_depend_lsu_src1 || bju_src1_fwd_vld;
always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_entry_src1_vld <= 1'b0;
  else if(bju_entry_pop)
    bju_entry_src1_vld <= 1'b0;
  else if(bju_depend_lsu && !bju_entry_vld && idu_iu_ex1_bju_sel)
    bju_entry_src1_vld <= bju_entry_src1_vld_initial;
  else if(bju_src1_fwd_vld)
    bju_entry_src1_vld <= 1'b1;
end

always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_entry_vld <= 1'b0;
  else if(bju_entry_vld_set && idu_iu_ex1_bju_sel)
    bju_entry_vld <= 1'b1;
  else if(bju_entry_pop)
    bju_entry_vld <= 1'b0;
end

always @ (posedge bju_entry_clk)
begin
  if (ifu_iu_warm_up || !bju_entry_vld && !bju_depend_lsu_src0 && bju_func[6])
    bju_src0_flop[63:0] <= bju_src0_raw[63:0];
  else if (bju_src0_fwd_vld)
    bju_src0_flop[63:0] <= lsu_iu_ex2_data[63:0];
  else if (bju_pc_cmp_set)   // ras mispred
    bju_src0_flop[63:0] <= bju_ag_tar_pc[63:0];
end

always @ (posedge bju_entry_clk)
begin
  if (ifu_iu_warm_up || !bju_entry_vld && !bju_depend_lsu_src0 && bju_func[6])
    bju_srcc_flop       <= bju_srcc_raw;
end

always @ (posedge bju_entry_clk)
begin
  if (ifu_iu_warm_up || !bju_entry_vld && !bju_depend_lsu_src1)
    bju_src1_flop[63:0] <= bju_src1_raw[63:0];
  else if (bju_src1_fwd_vld)
    bju_src1_flop[63:0] <= lsu_iu_ex2_data[63:0];
end


//==========================================================
//               Entry or Non-Entry Select
//==========================================================
assign bju_op_func[4:0]  = bju_entry_vld ? {bju_func_flop[3:0], 1'b0} : bju_func[4:0];
assign bju_bht_pred[1:0] = bju_entry_vld ? bju_bht_pred_flop[1:0]     : idu_iu_ex1_bht_pred[1:0];
assign bju_src0[63:0]    = bju_entry_vld ? bju_src0_flop[63:0]        : bju_src0_raw[63:0];
assign bju_src1[63:0]    = bju_entry_vld ? bju_src1_flop[63:0]        : bju_src1_raw[63:0];
assign bju_srcc          = bju_entry_vld ? bju_srcc_flop              : bju_srcc_raw;


//==========================================================
//                        Inc PC
//==========================================================
// before adder only extend 2 bit
assign bju_cur_pc_ext[63:0] = bju_pcgen_pc[63:0];
assign bju_inc_pc_ext[63:0] = {bju_inc_pc_ext_63_1[62:0], 1'b0};

// for timing, two adder: 32 bits and 16 bits
assign bju_inc_pc_adder0[63:0] = bju_cur_pc_ext[63:1] + {40'b0, 1'b1};
assign bju_inc_pc_adder1[63:0] = bju_cur_pc_ext[63:1] + {39'b0, 1'b1, 1'b0};

assign bju_inc_pc_ext_63_1_32bit[62:0] = bju_inc_pc_adder1[62:0];
assign bju_inc_pc_ext_63_1[62:0]       = bju_inc_pc_ext_63_1_32bit[62:0];
assign bju_inc_pc_63_1_wb[62:0]        = bju_inc_pc_ext_63_1_32bit[62:0];
assign bju_inc_pc_wb_data[63:0]        = {bju_inc_pc_63_1_wb[62:0], 1'b0};


//==========================================================
//                        AUIPC
//==========================================================
assign bju_ex1_use_pc      = !bju_func[0];
assign bju_ag_use_pc       = bju_ex1_use_pc || bju_entry_vld;


//==========================================================
//              Un-condition Branch & Jump
//==========================================================
assign bju_inst_jalr       =  bju_func[8:0] == 9'b000111001; // jirl
assign bju_ag_tar_pc[63:0] =  ag_bju_pc[63:0];


//==========================================================
//                  Condition Branch
//==========================================================
// `define FUNC_BLTU         {`FN_BJU,   `FWD_DU, 9'b0010 0011 0}
// `define FUNC_BGEU         {`FN_BJU,   `FWD_DU, 9'b0010 0101 0}

assign bju_br_unsigned = (bju_op_func[4:1] == 4'b0011) || // BLTU
                         (bju_op_func[4:1] == 4'b0101);   // BGEU

assign bju_cond_sel     = bju_cond_sel_ex1 || bju_entry_vld;
assign bju_beq_taken    = bju_src0[63:0] == bju_src1[63:0];
assign bju_beqz_taken   = bju_src0[63:0] == 64'b0;
assign bju_src0_lt_src1 = bju_src0[63:0] < bju_src1[63:0];
assign bju_src0_lt_src1_signed =  bju_src0[63] &&  bju_src1[63] && bju_src0_lt_src1
                               || bju_src0[63] && !bju_src1[63]
                               ||!bju_src0[63] && !bju_src1[63] && bju_src0_lt_src1;

assign bju_blt_taken           =  bju_br_unsigned ? bju_src0_lt_src1
                                                  : bju_src0_lt_src1_signed;

assign bju_br_inst_beq  = (bju_op_func[4:1] == 4'b0000);
assign bju_br_inst_bne  = (bju_op_func[4:1] == 4'b0001);
assign bju_br_inst_blt  = (bju_op_func[4:1] == 4'b0010);
assign bju_br_inst_bltu = (bju_op_func[4:1] == 4'b0011);
assign bju_br_inst_bge  = (bju_op_func[4:1] == 4'b0100);
assign bju_br_inst_bgeu = (bju_op_func[4:1] == 4'b0101);

assign bju_br_inst_beqz  = (bju_op_func[4:1] == 4'b0110);
assign bju_br_inst_bnez  = (bju_op_func[4:1] == 4'b0111);

// float point
assign bju_br_inst_bceqz = (bju_op_func[4:1] == 4'b1000);
assign bju_br_inst_bcnez = (bju_op_func[4:1] == 4'b1001);

assign bju_bceqz_taken   = bju_srcc == 1'b0;

assign bju_cond_br_taken_raw = ( bju_beq_taken & bju_br_inst_beq)  // beq and bne taken
                             | (!bju_beq_taken & bju_br_inst_bne)
                             | ( bju_blt_taken & bju_br_inst_blt)  // blt/bltu and bge/bgeu taken
                             | ( bju_blt_taken & bju_br_inst_bltu)
                             | (!bju_blt_taken & bju_br_inst_bge)
                             | (!bju_blt_taken & bju_br_inst_bgeu)
                             | ( bju_beqz_taken & bju_br_inst_beqz)
                             | (!bju_beqz_taken & bju_br_inst_bnez)  
                             | ( bju_bceqz_taken & bju_br_inst_bceqz)
                             | (!bju_bceqz_taken & bju_br_inst_bcnez);  

// When judge the real jump result, choose bju_cond_br_taken_raw
assign bju_cond_br_taken     = bju_ex1_inst_no_depd || bju_entry_pop ? bju_cond_br_taken_raw
                                                                     : bju_bht_pred[1];


//==========================================================
//                     Next PC
//==========================================================
assign bju_ag_tar_pc_sel = bju_cond_br_taken && (bju_cond_sel_ex1  || bju_entry_vld) && !bju_entry_pop
                        || bju_uncond_sel;
assign bju_next_pc[63:0] = bju_ag_tar_pc_sel ? bju_ag_tar_pc[63:0]
                                             : bju_inc_pc_ext[63:0];


//==========================================================
//               Branch & Jump Inst target PC
//==========================================================
// BHT predict result is in pred[1].
//   0-untaken, 1-taken.
assign bju_not_pred_pc[63:0] = bju_bht_pred[1] ? bju_inc_pc_ext[63:0]
                                               : bju_ag_tar_pc[63:0];

// BHT Predict Judge
assign bju_bht_mispred_no_entry  = bju_cond_sel && (bju_cond_br_taken ^ bju_bht_pred[1]) && bju_ex1_inst_no_depd; // ex1 inst
assign bju_bht_mispred_entry     = bju_cond_sel && (bju_cond_br_taken ^ bju_bht_pred[1]) && bju_entry_pop;        // entry inst
assign bju_br_vld      = bju_entry_vld ? bju_entry_pop : bju_cond_sel_ex1 && bju_ex1_inst_no_depd && idu_iu_ex1_bju_br_sel;
assign bju_br_vld_gate = bju_cond_sel_ex1 && bju_ex1_inst_no_depd && !bju_entry_vld || bju_entry_pop;
assign bju_bht_taken   = bju_cond_br_taken;

// PC Mispred
// bju_pc_cmp_fail will set ex2 chgflw because of timing.
// for inst like jalr x1, x1 , should force chgflow
assign bju_pc_cmp_gate     = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] == 5'b1;
assign bju_pc_cmp_set      = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] == 5'b1 && idu_iu_ex1_bju_sel;
assign bju_pc_cmp_fail     = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] == 5'b1 && (bju_src_dst_reg_equal || bju_ag_tar_pc[63:0] != ifu_iu_ex1_pc_pred[63:0]); // ras pc wrong
assign bju_pc_reg_mispred  = bju_inst_jalr && idu_iu_ex1_src0_reg[4:0] != 5'b1; // ras reg wrong

assign bju_bht_mispred     = bju_bht_mispred_no_entry && idu_iu_ex1_bju_sel || bju_bht_mispred_entry;
assign bju_tar_pc_vld_raw  = bju_entry_vld ? bju_bht_mispred_entry : (bju_bht_mispred_no_entry || bju_pc_reg_mispred) && idu_iu_ex1_bju_br_sel;
assign bju_tar_pc_vld      = bju_tar_pc_vld_raw || bju_ras_mispred_vld;
assign bju_tar_pc_vld_gate = bju_bht_mispred_no_entry || bju_pc_reg_mispred || bju_bht_mispred_entry || bju_ras_mispred_vld;

assign bju_src_dst_reg_equal = (idu_iu_ex1_src0_reg[4:0] == idu_iu_ex1_dst_preg[4:0]) && bju_func[9]; // link
assign bju_ret_vld_raw       = idu_iu_ex1_src0_reg[4:0] == 5'b1 && bju_inst_jalr && bju_ex1_inst_no_depd && !bju_src_dst_reg_equal;
assign bju_ret_vld           = bju_ret_vld_raw && idu_iu_ex1_bju_sel;
assign bju_link_vld_raw      = idu_iu_ex1_dst_preg[4:0] == 5'b1 && bju_uncond_sel && bju_ex1_inst_no_depd && bju_func[9]; // link
assign bju_link_vld          = bju_link_vld_raw && idu_iu_ex1_bju_sel;

assign bju_inst_cmplt         = idu_iu_ex1_bju_sel && !bju_depend_lsu || bju_depend_lsu_cmplt;
assign bju_inst_cmplt_dp      = idu_iu_ex1_bju_dp_sel || bju_entry_vld && !(bju_entry_src0_vld && bju_entry_src1_vld);

assign bju_ras_pc_mispred_set = bju_pc_cmp_fail && idu_iu_ex1_bju_sel;
assign bju_ras_not_vld        = !bju_ras_mispred_vld;
assign bju_ex1_inst_cmplt_no_depend = idu_iu_ex1_bju_sel && !bju_depend_lsu;

always @ (posedge bju_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bju_ras_mispred_vld <= 1'b0;
  else if (bju_ras_pc_mispred_set)
    bju_ras_mispred_vld <= 1'b1;
  else
    bju_ras_mispred_vld <= 1'b0;
end


//==========================================================
//                     PC Generator
//==========================================================
// PC update:
// 1. reset
// 2. ifu chgflow
// 3. bju entry chgflow(depend lsu branch and ras pc mispred)
// 4. inst cmplt pc(inc pc and ex1 chgflow pc)
always @ (posedge bju_clk)
begin
  if (ifu_iu_reset_vld)
    bju_pcgen_pc_39_1[62:0] <= cp0_xx_mrvbr[63:1];
  else if (ifu_iu_chgflw_vld)
    bju_pcgen_pc_39_1[62:0] <= ifu_iu_chgflw_pc[63:1];
  else if (bju_not_ex1_chgflw)
    bju_pcgen_pc_39_1[62:0] <= bju_not_ex1_tar_pc[63:1];
  else if (rtu_iu_ex1_cmplt && !rtu_iu_ex1_inst_split)
    bju_pcgen_pc_39_1[62:0] <= bju_next_pc_update[62:0];
end

assign bju_next_pc_update[62:0] = bju_next_pc[63:1];
assign bju_pcgen_pc[63:0]       = {bju_pcgen_pc_39_1[62:0], 1'b0};
assign bju_bht_cur_pc[63:0]     = bju_entry_vld ? rtu_iu_ex2_cur_pc[63:0]
                                                : bju_pcgen_pc[63:0];

assign bju_not_ex1_chgflw           = bju_ras_mispred_vld || bju_bht_mispred_entry;
assign bju_not_ex1_tar_pc_raw[63:0] = bju_ras_mispred_vld ? bju_src0_flop[63:0] : bju_not_pred_pc_flop[63:0];
assign bju_not_ex1_tar_pc[63:0]     = bju_not_ex1_tar_pc_raw[63:0];


//==========================================================
//                  BJU gateclk
//==========================================================
// bju_clk include:
//   1. bju_pcgen;
//   2. bju PMU counter;
//   3. tar_pc_vld_mask.

assign bju_clk_en = ifu_iu_chgflw_vld
                 || rtu_iu_ex1_cmplt_dp
                 || ifu_iu_warm_up
                 || ifu_iu_reset_vld
                 || inst_condbr
                 || bju_ras_mispred_vld
                 || bju_entry_pop
                 || bht_mispred
                 || bju_j_8m_update;

// &Instance("gated_clk_cell", "x_bju_clk"); @347
gated_clk_cell  x_bju_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bju_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bju_clk_en        ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @348
//          .external_en (1'b0), @349
//          .global_en   (cp0_yy_clk_en), @350
//          .module_en   (cp0_iu_icg_en), @351
//          .local_en    (bju_clk_en), @352
//          .clk_out     (bju_clk)); @353

assign bju_entry_clk_en = bju_depend_lsu && idu_bju_ex1_gateclk_sel
                     || ifu_iu_warm_up
                     || bju_entry_vld
                     || bju_pc_cmp_gate
                     || bju_ras_mispred_vld;

// &Instance("gated_clk_cell", "x_bju_entry_clk"); @361
gated_clk_cell  x_bju_entry_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (bju_entry_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (bju_entry_clk_en  ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @362
//          .external_en (1'b0), @363
//          .global_en   (cp0_yy_clk_en), @364
//          .module_en   (cp0_iu_icg_en), @365
//          .local_en    (bju_entry_clk_en), @366
//          .clk_out     (bju_entry_clk)); @367


//==========================================================
//                      OUTPUT SIGNAL
//==========================================================
//----------------------------------------------------------
//                        IFU SIGNAL
//----------------------------------------------------------
assign iu_ifu_tar_pc_vld      = bju_tar_pc_vld;
assign iu_ifu_tar_pc_vld_gate = bju_tar_pc_vld_gate;
assign iu_ifu_tar_pc[63:0] = bju_entry_vld ? bju_not_pred_pc_flop[63:0]
                                           : bju_ras_mispred_vld ? bju_src0_flop[63:0]
                                                                 : bju_next_pc[63:0];
// &Force("output", "iu_ifu_tar_pc_vld"); @381
assign iu_yy_xx_cancel     = iu_ifu_tar_pc_vld;
// BHT Singal
assign iu_ifu_br_vld           = bju_br_vld;
assign iu_ifu_br_vld_gate      = bju_br_vld_gate;
assign iu_ifu_bht_cur_pc[63:0] = bju_bht_cur_pc[63:0];
assign iu_ifu_bht_taken        = bju_bht_taken;
assign iu_ifu_bht_pred[1:0]    = bju_bht_pred[1:0];
assign iu_ifu_bht_mispred      = bju_bht_mispred;
assign iu_ifu_bht_mispred_gate = bju_bht_mispred_no_entry || bju_bht_mispred_entry;

// RAS Singal
assign iu_ifu_ret_vld          = bju_ret_vld;
assign iu_ifu_link_vld         = bju_link_vld;
assign iu_ifu_ret_vld_gate     = bju_ret_vld_raw;
assign iu_ifu_link_vld_gate    = bju_link_vld_raw;
assign iu_ifu_pc_mispred       = bju_pc_reg_mispred && idu_iu_ex1_bju_sel;
assign iu_ifu_pc_mispred_gate  = bju_pc_reg_mispred;

//----------------------------------------------------------
//                        RTU SIGNAL
//----------------------------------------------------------
assign bju_func_pcadd             =  (bju_func[8:0] == 9'b010001100);   // pcalau12i

assign ag_bju_pc_rebuild[63:0]    =  bju_func_pcadd ? {ag_bju_pc[63:12], 12'b0} : ag_bju_pc[63:0];         

assign bju_can_wb_inst            =  bju_func[9];        // pcadd and link

assign iu_rtu_ex1_bju_cmplt       = bju_inst_cmplt;
assign iu_rtu_ex1_bju_cmplt_dp    = bju_inst_cmplt_dp;
assign iu_rtu_ex1_bju_inst_len    = bju_entry_vld ? bju_inst_len_flop : idu_iu_ex1_inst_len;

assign iu_rtu_ex1_bju_wb_vld      = (bju_uncond_sel || bju_auipc_sel) && idu_iu_ex1_bju_sel && bju_can_wb_inst;
assign iu_rtu_ex1_bju_wb_dp       = (bju_uncond_sel || bju_auipc_sel) && idu_iu_ex1_bju_dp_sel && bju_can_wb_inst;
assign iu_rtu_ex1_bju_data[63:0]     = bju_uncond_sel ? bju_inc_pc_wb_data[63:0] : ag_bju_pc_rebuild[63:0];

assign iu_rtu_ex1_next_pc[63:0]      = {bju_next_pc_update[62:0], 1'b0};
assign iu_rtu_ex1_cur_pc[63:0]       = bju_pcgen_pc[63:0];
assign iu_rtu_ex1_branch_inst        = !bju_func[7] && idu_iu_ex1_bju_dp_sel || bju_entry_vld;
assign iu_rtu_ex1_bju_preg[5:0]      = {1'b0, idu_iu_ex1_dst_preg[4:0]};
assign iu_rtu_depd_lsu_chgflow_vld   = bju_bht_mispred_entry;
assign iu_rtu_depd_lsu_next_pc[63:0] = bju_not_pred_pc_flop[63:0];
assign iu_rtu_ex2_bju_ras_mispred    = bju_ras_mispred_vld;

// pctrace signals
//assign iu_rtu_ex1_condbr  = bju_cond_sel_ex1 && idu_iu_ex1_bju_sel || bju_entry_vld;
//assign iu_rtu_ex1_jmp     = bju_inst_jalr && idu_iu_ex1_bju_sel;
//assign iu_rtu_ex1_pcall   = bju_link_vld;
//assign iu_rtu_ex1_preturn = bju_ret_vld;
//assign iu_rtu_ex1_taken   = bju_cond_br_taken;

//----------------------------------------------------------
//                        CP0 SIGNAL
//----------------------------------------------------------
assign iu_cp0_ex1_cur_pc[63:0] = bju_pcgen_pc[63:0];

//----------------------------------------------------------
//                        LSU SIGNAL
//----------------------------------------------------------
assign iu_lsu_ex1_cur_pc[15:0] = bju_pcgen_pc[15:0];


//==========================================================
//                       HPCP Signal
//==========================================================
assign iu_hpcp_inst_condbr_set      = (bju_cond_sel_ex1 && bju_ex1_inst_cmplt_no_depend || bju_depend_lsu_cmplt) && hpcp_iu_cnt_en;
assign iu_hpcp_inst_bht_mispred_set = bju_bht_mispred  && hpcp_iu_cnt_en;
always @ (posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    inst_condbr <= 1'b0;
  else if(iu_hpcp_inst_condbr_set)
    inst_condbr <= 1'b1;
  else
    inst_condbr <= 1'b0;
end

always @ (posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_mispred <= 1'b0;
  else if(iu_hpcp_inst_bht_mispred_set)
    bht_mispred <= 1'b1;
  else
    bht_mispred <= 1'b0;
end

assign iu_hpcp_inst_condbr      = inst_condbr;
assign iu_hpcp_inst_bht_mispred = bht_mispred;
assign bju_deginfo[3:0] = {bju_entry_vld, bju_entry_src0_vld, bju_entry_src1_vld, bju_ras_mispred_vld};

assign bju_hpcp_cur_pc[63:0]  = rtu_iu_ex2_cur_pc[63:0];
assign bju_hpcp_next_pc[63:0] = rtu_iu_ex2_next_pc[63:0];
assign bju_hpcp_adder_src0[40:0] = {mmu_xx_mmu_en && bju_hpcp_next_pc[39], bju_hpcp_next_pc[63:0]} & {41{bju_inst_j}};
assign bju_hpcp_adder_src1[40:0] = {mmu_xx_mmu_en && bju_hpcp_cur_pc[39],  bju_hpcp_cur_pc[63:0]}  & {41{bju_inst_j}};
assign bju_hpcp_jump_pc[40:0]    = bju_hpcp_adder_src0[40:0] - bju_hpcp_adder_src1[40:0];

assign iu_hpcp_j_inst_en = hpcp_iu_cnt_en && (bju_uncond_sel || bju_inst_j);
assign bju_inst_j_set    = bju_uncond_sel && idu_iu_ex1_bju_sel && !bju_ret_vld_raw;

assign bju_j_8m_cmp_pos[40:0] = 41'h7fffff;
assign bju_j_8m_cmp_neg[40:0] = 41'h1ffff800001;
assign bju_j_8m_pos_judge = bju_hpcp_jump_pc[40:0] > bju_j_8m_cmp_pos[40:0];
assign bju_j_8m_neg_judge = bju_hpcp_jump_pc[40:0] < bju_j_8m_cmp_neg[40:0];
assign bju_j_8m_judge_rst = bju_hpcp_jump_pc[40] ? bju_j_8m_neg_judge : bju_j_8m_pos_judge;

always @(posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_inst_j <= 1'b0;
  else if(iu_hpcp_j_inst_en)
    bju_inst_j <= bju_inst_j_set;
end

assign bju_j_8m_update = hpcp_iu_cnt_en && (bju_j_8m_judge_rst || bju_j_8m);
always @(posedge bju_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bju_j_8m <= 1'b0;
  else if(bju_j_8m_update)
    bju_j_8m <= bju_j_8m_judge_rst;
end
assign iu_hpcp_jump_8m = bju_j_8m;







// &ModuleEnd; @521
endmodule


