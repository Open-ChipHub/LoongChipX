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

// &ModuleBeg; @28
module ct_lsu_ld_ag (
  // &Ports, @29
  input    wire          cp0_lsu_cb_aclr_dis,
  input    wire          cp0_lsu_da_fwd_dis,
  input    wire          cp0_lsu_dcache_en,
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_lsu_mm,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_ld_clk,
  input    wire          dcache_arb_ag_ld_sel,
  input    wire  [39:0]  dcache_arb_ld_ag_addr,
  input    wire          dcache_arb_ld_ag_borrow_addr_vld,
  input    wire          forever_cpuclk,
  input    wire  [31:0]  idu_lsu_rf_pipe3_inst_code,
  input    wire          idu_lsu_rf_pipe3_already_da,
  input    wire          idu_lsu_rf_pipe3_atomic,
  input    wire          idu_lsu_rf_pipe3_bkpta_data,
  input    wire          idu_lsu_rf_pipe3_bkptb_data,
  input    wire          idu_lsu_rf_pipe3_gateclk_sel,
  input    wire  [6 :0]  idu_lsu_rf_pipe3_iid,
  input    wire          idu_lsu_rf_pipe3_inst_fls,
  input    wire          idu_lsu_rf_pipe3_inst_ldr,
  input    wire  [1 :0]  idu_lsu_rf_pipe3_inst_size,
  input    wire  [1 :0]  idu_lsu_rf_pipe3_inst_type,
  input    wire  [11:0]  idu_lsu_rf_pipe3_lch_entry,
  input    wire          idu_lsu_rf_pipe3_lsfifo,
  input    wire          idu_lsu_rf_pipe3_no_spec,
  input    wire          idu_lsu_rf_pipe3_no_spec_exist,
  input    wire          idu_lsu_rf_pipe3_off_0_extend,
  input    wire  [13:0]  idu_lsu_rf_pipe3_offset,
  input    wire  [14:0]  idu_lsu_rf_pipe3_offset_plus,
  input    wire          idu_lsu_rf_pipe3_oldest,
  input    wire  [14:0]  idu_lsu_rf_pipe3_pc,
  input    wire  [6 :0]  idu_lsu_rf_pipe3_preg,
  input    wire          idu_lsu_rf_pipe3_sel,
  input    wire  [3 :0]  idu_lsu_rf_pipe3_shift,
  input    wire          idu_lsu_rf_pipe3_sign_extend,
  input    wire          idu_lsu_rf_pipe3_spec_fail,
  input    wire          idu_lsu_rf_pipe3_split,
  input    wire  [63:0]  idu_lsu_rf_pipe3_src0,
  input    wire  [63:0]  idu_lsu_rf_pipe3_src1,
  input    wire          idu_lsu_rf_pipe3_unalign_2nd,
  input    wire  [6 :0]  idu_lsu_rf_pipe3_vreg,
  input    wire          mmu_lsu_buf0,
  input    wire          mmu_lsu_ca0,
  input    wire  [27:0]  mmu_lsu_pa0,
  input    wire          mmu_lsu_pa0_vld,
  input    wire          mmu_lsu_page_fault0,
  input    wire          mmu_lsu_sec0,
  input    wire          mmu_lsu_sh0,
  input    wire          mmu_lsu_so0,
  input    wire          mmu_lsu_stall0,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_yy_xx_commit0,
  input    wire  [6 :0]  rtu_yy_xx_commit0_iid,
  input    wire          rtu_yy_xx_commit1,
  input    wire  [6 :0]  rtu_yy_xx_commit1_iid,
  input    wire          rtu_yy_xx_commit2,
  input    wire  [6 :0]  rtu_yy_xx_commit2_iid,
  input    wire          rtu_yy_xx_flush,
  input    wire  [6 :0]  st_ag_iid,
  output   wire  [7 :0]  ag_dcache_arb_ld_data_gateclk_en,
  output   wire  [10:0]  ag_dcache_arb_ld_data_high_idx,
  output   wire  [10:0]  ag_dcache_arb_ld_data_low_idx,
  output   wire  [7 :0]  ag_dcache_arb_ld_data_req,
  output   wire          ag_dcache_arb_ld_tag_gateclk_en,
  output   wire  [8 :0]  ag_dcache_arb_ld_tag_idx,
  output   wire          ag_dcache_arb_ld_tag_req,
  output   wire  [59:0]  ld_ag_addr1_to4,
  output   wire          ld_ag_ahead_predict,
  output   reg           ld_ag_already_da,
  output   reg           ld_ag_atomic,
  output   wire          ld_ag_boundary,
  output   reg   [2 :0]  ld_ag_dc_access_size,
  output   wire          ld_ag_dc_acclr_en,
  output   wire  [39:0]  ld_ag_dc_addr0,
  output   wire  [15:0]  ld_ag_dc_bytes_vld,
  output   wire  [15:0]  ld_ag_dc_bytes_vld1,
  output   wire          ld_ag_dc_fwd_bypass_en,
  output   wire          ld_ag_dc_inst_vld,
  output   wire          ld_ag_dc_load_ahead_inst_vld,
  output   wire          ld_ag_dc_load_inst_vld,
  output   wire          ld_ag_dc_mmu_req,
  output   wire  [3 :0]  ld_ag_dc_rot_sel,
  output   wire          ld_ag_dc_vload_ahead_inst_vld,
  output   wire          ld_ag_dc_vload_inst_vld,
  output   wire          ld_ag_expt_access_fault_with_page,
  output   wire          ld_ag_expt_ldamo_not_ca,
  output   wire          ld_ag_expt_misalign_no_page,
  output   wire          ld_ag_expt_misalign_with_page,
  output   wire          ld_ag_expt_page_fault,
  output   wire          ld_ag_bc_expt_misalign,
  output   wire          ld_ag_bc_expt_check_fail,
  output   wire          ld_ag_expt_vld,
  output   reg   [6 :0]  ld_ag_iid,
  output   reg   [1 :0]  ld_ag_inst_type,
  output   reg   [31:0]  ld_ag_inst_code,
  output   wire          ld_ag_inst_vfls,
  output   reg           ld_ag_inst_vld,
  output   reg   [14:0]  ld_ag_ldfifo_pc,
  output   wire          ld_ag_lm_init_vld,
  output   wire          ld_ag_lr_inst,
  output   reg   [11:0]  ld_ag_lsid,
  output   reg           ld_ag_lsiq_bkpta_data,
  output   reg           ld_ag_lsiq_bkptb_data,
  output   reg           ld_ag_lsiq_spec_fail,
  output   reg           ld_ag_no_spec,
  output   reg           ld_ag_no_spec_exist,
  output   reg           ld_ag_old,
  output   wire  [39:0]  ld_ag_pa,
  output   wire          ld_ag_page_buf,
  output   wire          ld_ag_page_ca,
  output   wire          ld_ag_page_sec,
  output   wire          ld_ag_page_share,
  output   wire          ld_ag_page_so,
  output   wire          ld_ag_pf_inst,
  output   reg   [6 :0]  ld_ag_preg,
  output   wire          ld_ag_raw_new,
  output   reg           ld_ag_secd,
  output   reg           ld_ag_sign_extend,
  output   reg           ld_ag_split,
  output   wire          ld_ag_stall_ori,
  output   wire  [11:0]  ld_ag_stall_restart_entry,
  output   wire          ld_ag_utlb_miss,
  output   wire  [27:0]  ld_ag_vpn,
  output   wire  [23:0]  ld_ag_vpn_high,
  output   reg   [5 :0]  ld_ag_vreg,
  output   wire          lsu_hpcp_ld_cross_4k_stall,
  output   wire          lsu_hpcp_ld_other_stall,
  output   wire          lsu_idu_ag_pipe3_load_inst_vld,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_preg_dup0,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_preg_dup1,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_preg_dup2,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_preg_dup3,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_preg_dup4,
  output   wire          lsu_idu_ag_pipe3_vload_inst_vld,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_vreg_dup0,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_vreg_dup1,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_vreg_dup2,
  output   wire  [6 :0]  lsu_idu_ag_pipe3_vreg_dup3,
  output   wire  [11:0]  lsu_idu_ld_ag_wait_old,
  output   wire          lsu_idu_ld_ag_wait_old_gateclk_en,
  output   wire  [63:0]  lsu_cp0_ld_va,
  output   wire  [39:0]  lsu_cp0_ld_pa,
  output   wire          lsu_cp0_ld_vld,
  output   wire          lsu_mmu_abort0,
  output   wire  [6 :0]  lsu_mmu_id0,
  output   wire          lsu_mmu_st_inst0,
  output   wire  [63:0]  lsu_mmu_va0,
  output   wire          lsu_mmu_va0_vld
); 



// &Regs; @30
reg     [3 :0]  bank_en_low_ori;                    
reg     [3 :0]  ld_ag_access_size_ori;              
reg             ld_ag_align;                        
reg             ld_ag_already_cross_page_ldr_imme;  
reg     [63:0]  ld_ag_base;                         
reg             ld_ag_bypass_en;                    
reg             ld_ag_inst_fls;                     
reg             ld_ag_inst_ldr;                     
reg     [1 :0]  ld_ag_inst_size;                    
reg     [15:0]  ld_ag_le_bytes_vld_high_bits_full;  
reg     [15:0]  ld_ag_le_bytes_vld_low_bits_full;   
reg             ld_ag_lsfifo;                       
reg     [63:0]  ld_ag_offset;                       
reg     [14:0]  ld_ag_offset_plus;                  
reg     [3 :0]  ld_ag_offset_shift;                 
reg     [6 :0]  ld_ag_preg_dup1;                    
reg     [6 :0]  ld_ag_preg_dup2;                    
reg     [6 :0]  ld_ag_preg_dup3;                    
reg     [6 :0]  ld_ag_preg_dup4;                    
reg     [5 :0]  ld_ag_vreg_dup1;                    
reg     [5 :0]  ld_ag_vreg_dup2;                    
reg     [5 :0]  ld_ag_vreg_dup3;                    

// &Wires; @31
wire            ag_dcache_arb_ld_gateclk_en;        
wire            ag_dcache_arb_ld_req;               
wire    [3 :0]  bank_en_low;                        
wire    [3 :0]  bank_en_low_gateclk;                
wire            ld_ag_4k_sum_12;                    
wire    [12:0]  ld_ag_4k_sum_ori;                   
wire    [12:0]  ld_ag_4k_sum_plus;                  
wire    [3 :0]  ld_ag_access_size;                  
wire            ld_ag_acclr_en;                     
wire    [39:0]  ld_ag_addr0;                        
wire            ld_ag_atomic_no_cmit_restart_arb;   
wire            ld_ag_atomic_no_cmit_restart_req;   
wire            ld_ag_boundary_stall;               
wire            ld_ag_boundary_unmask;              
wire    [15:0]  ld_ag_bytes_vld;                    
wire    [15:0]  ld_ag_bytes_vld1;                   
wire    [15:0]  ld_ag_bytes_vld_high_bits;          
wire    [15:0]  ld_ag_bytes_vld_low_cross_bits;     
wire            ld_ag_clk;                          
wire            ld_ag_clk_en;                       
wire            ld_ag_cmit;                         
wire            ld_ag_cmit_hit0;                    
wire            ld_ag_cmit_hit1;                    
wire            ld_ag_cmit_hit2;                    
wire            ld_ag_cross_4k;                     
wire            ld_ag_cross_page_ldr_imme_stall_arb; 
wire            ld_ag_cross_page_ldr_imme_stall_req; 
wire            ld_ag_dcache_stall_req;             
wire            ld_ag_dcache_stall_unmask;          
wire            ld_ag_inst_fof;                     
wire            ld_ag_inst_stall_gateclk_en;        
wire            ld_ag_inst_vls;                     
wire            ld_ag_ld_inst;                      
wire            ld_ag_ldamo_inst;                   
wire    [15:0]  ld_ag_le_bytes_vld_cross;           
wire    [15:0]  ld_ag_le_bytes_vld_high_bits;       
wire    [15:0]  ld_ag_le_bytes_vld_low_cross_bits;  
wire    [11:0]  ld_ag_mask_lsid;                    
wire            ld_ag_mmu_stall_req;                
wire            ld_ag_off_4k_high_bits_all_0_ori;   
wire            ld_ag_off_4k_high_bits_all_1_ori;   
wire            ld_ag_off_4k_high_bits_not_eq;      
wire    [63:0]  ld_ag_offset_aftershift;            
wire            ld_ag_page_fault;                   
wire    [27:0]  ld_ag_pn;                           
wire            ld_ag_secd_imme_stall;              
wire            ld_ag_stall_mask;                   
wire            ld_ag_stall_restart;                
wire            ld_ag_stall_vld;                    
wire            ld_ag_unalign;                      
wire            ld_ag_unalign_so;                   
wire    [63:0]  ld_ag_va;                           
wire    [4 :0]  ld_ag_va_add_access_size;           
wire    [63:0]  ld_ag_va_ori;                       
wire    [63:0]  ld_ag_va_plus;                      
wire            ld_ag_va_plus_sel;                  
wire            ld_ag_vmb_merge_vld;                
wire            ld_rf_inst_ldr;                     
wire            ld_rf_inst_vld;                     
wire            ld_rf_off_0_extend;                 
wire            rf_iid_older_than_ld_ag;            
wire    [63:0]  ld_ag_inst_bc_src0;
wire    [63:0]  ld_ag_inst_bc_src1;
wire            ld_ag_inst_bc_gt;
wire            ld_ag_inst_bc_le;
wire            ld_ag_bc_gt;
wire            ld_ag_bc_le;
wire    [17:0]  ld_ag_offset_shift_plus;
wire            ld_ag_preld_inst;


parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;

parameter LSIQ_ENTRY  = 12;
parameter VMB_ENTRY   = 8;
parameter PC_LEN      = 15;

//==========================================================
//                        RF signal
//==========================================================
assign ld_rf_inst_vld         = idu_lsu_rf_pipe3_gateclk_sel;
assign ld_rf_inst_ldr         = idu_lsu_rf_pipe3_inst_ldr;
assign ld_rf_off_0_extend     = idu_lsu_rf_pipe3_off_0_extend;
//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign ld_ag_clk_en = idu_lsu_rf_pipe3_gateclk_sel || ld_ag_inst_stall_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_ld_ag_gated_clk"); @52
gated_clk_cell  x_lsu_ld_ag_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ld_ag_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ld_ag_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @53
//          .external_en   (1'b0               ), @54
//          .global_en     (cp0_yy_clk_en      ), @55
//          .module_en     (cp0_lsu_icg_en     ), @56
//          .local_en      (ld_ag_clk_en       ), @57
//          .clk_out       (ld_ag_clk          )); @58

//==========================================================
//                 Pipeline Register
//==========================================================
//------------------control part----------------------------
//+----------+
//| inst_vld |
//+----------+
//if there is a stall in the AG stage ,the inst keep valid,
//elseif there is inst and no flush in RF stage,
//the inst goes to the AG stage next cycle

// &Force("output","ld_ag_inst_vld"); @71
always @(posedge ctrl_ld_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_ag_inst_vld  <=  1'b0;
  else if(rtu_yy_xx_flush)
    ld_ag_inst_vld  <=  1'b0;
  else if(ld_ag_stall_vld ||  idu_lsu_rf_pipe3_sel)
    ld_ag_inst_vld  <=  1'b1;
  else
    ld_ag_inst_vld  <=  1'b0;
end

//------------------data part-------------------------------
//+-----------+-----------+------+------------+----------------+
//| inst_type | inst_size | secd | already_da | lsiq_spec_fail |
//+-----------+-----------+------+------------+----------------+
//+-------------+----+-----+------+-----+------+
//| sign_extend | ex | iid | lsid | old | preg |
//+-------------+----+-----+------+-----+------+
//+-----------+----------------+-------+
//| ldfifo_pc | unalign_permit | split |
//+-----------+----------------+-------+
//+-------+-------+
//| bkpta | bkptb |
//+-------+-------+
//if there is a stall in the AG stage ,the inst info keep unchanged,
//elseif there is inst in RF stage, the inst goes to the AG stage next cycle

// &Force("bus","idu_lsu_rf_pipe3_vreg",6,0); @100
// &Force("output","ld_ag_split"); @101
// &Force("output","ld_ag_inst_type"); @102
// &Force("output","ld_ag_secd"); @103
// &Force("output","ld_ag_already_da"); @104
// &Force("output","ld_ag_lsiq_spec_fail"); @105
// &Force("output","ld_ag_lsiq_bkpta_data"); @106
// &Force("output","ld_ag_lsiq_bkptb_data"); @107
// &Force("output","ld_ag_sign_extend"); @108
// &Force("output","ld_ag_atomic"); @109
// &Force("output","ld_ag_iid"); @110
// &Force("output","ld_ag_lsid"); @111
// &Force("output","ld_ag_old"); @112
// &Force("output","ld_ag_preg"); @113
// &Force("output","ld_ag_vreg"); @114
// &Force("output","ld_ag_ldfifo_pc"); @115
always @(posedge ld_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ld_ag_split                 <=  1'b0;
    ld_ag_inst_type[1:0]        <=  2'b0;
    ld_ag_inst_size[1:0]        <=  2'b0;
    ld_ag_inst_code[31:0]       <=  32'b0;
    ld_ag_secd                  <=  1'b0;
    ld_ag_already_da            <=  1'b0;
    ld_ag_lsiq_spec_fail        <=  1'b0;
    ld_ag_lsiq_bkpta_data       <=  1'b0;
    ld_ag_lsiq_bkptb_data       <=  1'b0;
    ld_ag_sign_extend           <=  1'b0;
    ld_ag_atomic                <=  1'b0;
    ld_ag_iid[6:0]              <=  7'b0;
    ld_ag_lsid[LSIQ_ENTRY-1:0]  <=  {LSIQ_ENTRY{1'b0}};
    ld_ag_old                   <=  1'b0;
    ld_ag_preg[6:0]             <=  7'b0;
    ld_ag_preg_dup1[6:0]        <=  7'b0;
    ld_ag_preg_dup2[6:0]        <=  7'b0;
    ld_ag_preg_dup3[6:0]        <=  7'b0;
    ld_ag_preg_dup4[6:0]        <=  7'b0;
    ld_ag_ldfifo_pc[PC_LEN-1:0] <=  {PC_LEN{1'b0}};
    ld_ag_vreg[5:0]             <=  6'b0;
    ld_ag_vreg_dup1[5:0]        <=  6'b0;
    ld_ag_vreg_dup2[5:0]        <=  6'b0;
    ld_ag_vreg_dup3[5:0]        <=  6'b0;
    ld_ag_inst_ldr              <=  1'b0;
    ld_ag_inst_fls              <=  1'b0;
    ld_ag_lsfifo                <=  1'b0;
    ld_ag_no_spec               <=  1'b0;
    ld_ag_no_spec_exist         <=  1'b0;
  end
  else if(!ld_ag_stall_vld  &&  ld_rf_inst_vld)
  begin
    ld_ag_split                 <=  idu_lsu_rf_pipe3_split;
    ld_ag_inst_type[1:0]        <=  idu_lsu_rf_pipe3_inst_type[1:0];
    ld_ag_inst_size[1:0]        <=  idu_lsu_rf_pipe3_inst_size[1:0];
    ld_ag_inst_code[31:0]       <=  idu_lsu_rf_pipe3_inst_code[31:0];
    ld_ag_secd                  <=  idu_lsu_rf_pipe3_unalign_2nd;
    ld_ag_already_da            <=  idu_lsu_rf_pipe3_already_da;
    ld_ag_lsiq_spec_fail        <=  idu_lsu_rf_pipe3_spec_fail;
    ld_ag_lsiq_bkpta_data       <=  idu_lsu_rf_pipe3_bkpta_data;
    ld_ag_lsiq_bkptb_data       <=  idu_lsu_rf_pipe3_bkptb_data;
    ld_ag_sign_extend           <=  idu_lsu_rf_pipe3_sign_extend;
    ld_ag_atomic                <=  idu_lsu_rf_pipe3_atomic;
    ld_ag_iid[6:0]              <=  idu_lsu_rf_pipe3_iid[6:0];
    ld_ag_lsid[LSIQ_ENTRY-1:0]  <=  idu_lsu_rf_pipe3_lch_entry[LSIQ_ENTRY-1:0];
    ld_ag_old                   <=  idu_lsu_rf_pipe3_oldest;
    ld_ag_preg[6:0]             <=  idu_lsu_rf_pipe3_preg[6:0];
    ld_ag_preg_dup1[6:0]        <=  idu_lsu_rf_pipe3_preg[6:0];
    ld_ag_preg_dup2[6:0]        <=  idu_lsu_rf_pipe3_preg[6:0];
    ld_ag_preg_dup3[6:0]        <=  idu_lsu_rf_pipe3_preg[6:0];
    ld_ag_preg_dup4[6:0]        <=  idu_lsu_rf_pipe3_preg[6:0];
    ld_ag_ldfifo_pc[PC_LEN-1:0] <=  idu_lsu_rf_pipe3_pc[PC_LEN-1:0];
    ld_ag_vreg[5:0]             <=  idu_lsu_rf_pipe3_vreg[5:0];
    ld_ag_vreg_dup1[5:0]        <=  idu_lsu_rf_pipe3_vreg[5:0];
    ld_ag_vreg_dup2[5:0]        <=  idu_lsu_rf_pipe3_vreg[5:0];
    ld_ag_vreg_dup3[5:0]        <=  idu_lsu_rf_pipe3_vreg[5:0];
    ld_ag_inst_ldr              <=  idu_lsu_rf_pipe3_inst_ldr;
    ld_ag_inst_fls              <=  idu_lsu_rf_pipe3_inst_fls;
    ld_ag_lsfifo                <=  idu_lsu_rf_pipe3_lsfifo;
    ld_ag_no_spec               <=  idu_lsu_rf_pipe3_no_spec;
    ld_ag_no_spec_exist         <=  idu_lsu_rf_pipe3_no_spec_exist;
  end
end

wire [15:0] load_ag_pc;
assign load_ag_pc[15:0] = {ld_ag_ldfifo_pc[PC_LEN-1:0], 1'b0};

//+------------------+
//| already_cross_4k |
//+------------------+
//already cross 4k means addr1 is wrong, and mustn't merge from cache buffer
always @(posedge ld_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_ag_already_cross_page_ldr_imme  <=  1'b0;
  else if (!ld_ag_stall_vld)
    ld_ag_already_cross_page_ldr_imme  <=  1'b0;
  else if(ld_ag_stall_vld &&  ld_ag_cross_page_ldr_imme_stall_req)
    ld_ag_already_cross_page_ldr_imme  <=  1'b1;
end

//+--------------+
//| offset_shift |
//+--------------+
//if there is a stall in the AG stage ,offset_shift is reset to 0
//cache stall will not change shift
always @(posedge ld_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_ag_offset_shift[3:0] <=  4'b1;
  else if (!ld_ag_stall_vld &&  idu_lsu_rf_pipe3_sel)
    ld_ag_offset_shift[3:0] <=  idu_lsu_rf_pipe3_shift[3:0];
  else if(ld_ag_stall_vld && ld_ag_cross_page_ldr_imme_stall_req)
    ld_ag_offset_shift[3:0] <=  4'b1;
end

//+--------+
//| offset |
//+--------+
//if the 1st time boundary 2nd instruction stall, the offset set 16 for bias, else
//if stall, it set to 0, cache stall will not change offset
always @(posedge ld_ag_clk)
begin
  if(ld_ag_cross_page_ldr_imme_stall_arb)
    ld_ag_offset[63:32]  <=  32'h0;
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld  &&  !ld_rf_inst_ldr)
    ld_ag_offset[63:32]  <=  {32{idu_lsu_rf_pipe3_offset[13]}};
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld  &&  ld_rf_inst_ldr  &&  ld_rf_off_0_extend)
    ld_ag_offset[63:32]  <=  32'h0;
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld)
    ld_ag_offset[63:32]  <=  idu_lsu_rf_pipe3_src1[63:32];
end


always @(posedge ld_ag_clk)
begin
  if(ld_ag_cross_page_ldr_imme_stall_arb  &&  ld_ag_secd_imme_stall)
    ld_ag_offset[31:0]  <=  32'h10;
  else if(ld_ag_cross_page_ldr_imme_stall_arb)
    ld_ag_offset[31:0]  <=  32'h0;
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld  &&  !ld_rf_inst_ldr)
    ld_ag_offset[31:0]  <=  {{18{idu_lsu_rf_pipe3_offset[13]}},idu_lsu_rf_pipe3_offset[13:0]};
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld)
    ld_ag_offset[31:0]  <=  idu_lsu_rf_pipe3_src1[31:0];
end

//+-------------+
//| offset_plus |
//+-------------+
//use this imm as offset when the ld/st inst need split and !secd
always @(posedge ld_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ld_ag_offset_plus[14:0]  <=  15'h0;
  else if(ld_ag_cross_page_ldr_imme_stall_arb)
    ld_ag_offset_plus[14:0]  <=  15'h0;
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld)
    ld_ag_offset_plus[14:0]  <=  idu_lsu_rf_pipe3_offset_plus[14:0];
end

//+------+
//| base |
//+------+
//the base addr, if stall, the base is set the result from the adder
always @(posedge ld_ag_clk)
begin
  if(ld_ag_cross_page_ldr_imme_stall_arb)
    ld_ag_base[63:0]  <=  ld_ag_va[63:0];
  else if (!ld_ag_stall_vld &&  ld_rf_inst_vld)
    ld_ag_base[63:0]  <=  idu_lsu_rf_pipe3_src0[63:0];
end

//==========================================================
//                      AG gateclk
//==========================================================
assign ld_ag_inst_stall_gateclk_en  = ld_ag_inst_vld;

//==========================================================
//               Generate virtual address
//==========================================================
// for first boundary inst, use addr+offset+128 as va instead of addr+offset
//for secd boundary,use addr+offset as va

wire  ld_ag_preldx = (ld_ag_inst_code[31:15] == 17'b00111000001011000);

wire [63:0] ld_ag_offset_rp = ld_ag_preldx ? {48'b0, ld_ag_offset[15:0]}
                                           : ld_ag_offset[63:0];

assign ld_ag_offset_aftershift[63:0]  = {64{ld_ag_offset_shift[0]}} & ld_ag_offset_rp[63:0]
                                        | {64{ld_ag_offset_shift[1]}} & {ld_ag_offset_rp[62:0],1'b0}
                                        | {64{ld_ag_offset_shift[2]}} & {ld_ag_offset_rp[61:0],2'b0}
                                        | {64{ld_ag_offset_shift[3]}} & {ld_ag_offset_rp[60:0],3'b0};


assign ld_ag_va_ori[63:0]           = ld_ag_base[63:0]
                                      + ld_ag_offset_aftershift[63:0];

assign ld_ag_offset_shift_plus[17:0] =    {18{ld_ag_offset_shift[0]}} & {{3{ld_ag_offset_plus[14]}}, ld_ag_offset_plus[14:0]}
                                        | {18{ld_ag_offset_shift[1]}} & {{2{ld_ag_offset_plus[14]}}, ld_ag_offset_plus[14:0],1'b0}
                                        | {18{ld_ag_offset_shift[2]}} & {{1{ld_ag_offset_plus[14]}}, ld_ag_offset_plus[14:0],2'b0}
                                        | {18{ld_ag_offset_shift[3]}} & {ld_ag_offset_plus[14:0],3'b0};


assign ld_ag_va_plus[63:0]           = ld_ag_base[63:0]
                                       + {{46{ld_ag_offset_shift_plus[17]}},ld_ag_offset_shift_plus[17:0]};

//if misalign without page, then select ori va
assign ld_ag_va_plus_sel            = ld_ag_boundary_unmask
                                      &&  ld_ag_ld_inst 
                                      &&  !ld_ag_secd
                                      &&  !ld_ag_inst_ldr;

assign ld_ag_va[63:0]               = ld_ag_va_plus_sel
                                      ? ld_ag_va_plus[63:0]
                                      : ld_ag_va_ori[63:0]; 

assign ld_ag_vpn[`PA_WIDTH-13:0]    = ld_ag_va[`PA_WIDTH-1:12];
assign ld_ag_vpn_high[23:0]         = ld_ag_va[63:40];

// for debug
assign lsu_cp0_ld_va[63:0]          = ld_ag_va[63:0];
assign lsu_cp0_ld_pa[39:0]          = ld_ag_pa[39:0];
assign lsu_cp0_ld_vld               = ld_ag_inst_vld;

//==========================================================
//                Generate inst type
//==========================================================
//ld/ldr/lrw/pop/lrs is treated as ld inst
assign ld_ag_ld_inst      = !ld_ag_atomic
                            &&  (ld_ag_inst_type[1:0]  == 2'b00);
// &Force("output","ld_ag_lr_inst"); @344
assign ld_ag_lr_inst      = ld_ag_atomic
                            &&  (ld_ag_inst_type[1:0]  == 2'b01);
assign ld_ag_ldamo_inst   = ld_ag_atomic
                            &&  (ld_ag_inst_type[1:0]  == 2'b00);

assign ld_ag_preld_inst   =    (ld_ag_inst_code[31:15] == 17'b00111000001011000) // preldx
                            || (ld_ag_inst_code[31:22] == 10'b0010101011);       // preld

//-------------need to prefetch inst------------------------
assign ld_ag_pf_inst  = ld_ag_ld_inst
                        &&  !ld_ag_split
                        &&  ld_ag_lsfifo
                        &&  !ld_ag_secd;          //only 1st inst

// &Force("output", "ld_ag_vmb_merge_vld"); @357
// &Force("output", "ld_ag_inst_fof"); @358
assign ld_ag_inst_vls   = 1'b0;
assign ld_ag_inst_fof   = 1'b0;
assign ld_ag_inst_vfls  = ld_ag_inst_fls;
assign ld_ag_vmb_merge_vld = 1'b0;
//==========================================================
//            Generate unalign, bytes_vld
//==========================================================
//---------------inst access size---------------
// access size is used to select bytes_vld and boundary judge
// &CombBeg; @371
always @( ld_ag_inst_size[1:0])
begin
case(ld_ag_inst_size[1:0])
  BYTE: ld_ag_access_size_ori[3:0] = 4'b0000;
  HALF: ld_ag_access_size_ori[3:0] = 4'b0001;
  WORD: ld_ag_access_size_ori[3:0] = 4'b0011;
  DWORD:ld_ag_access_size_ori[3:0] = 4'b0111;
  default:ld_ag_access_size_ori[3:0] = 4'b0;
endcase
// &CombEnd; @379
end
assign ld_ag_access_size[3:0] = ld_ag_access_size_ori[3:0]; 

// access_size pipedown to dc, used for biu req_size(strong order)
// &CombBeg; @388
always @( ld_ag_access_size[3:0])
begin
case(ld_ag_access_size[3:0])
  4'b0000: ld_ag_dc_access_size[2:0] = 3'b000;  //byte
  4'b0001: ld_ag_dc_access_size[2:0] = 3'b001;  //half
  4'b0011: ld_ag_dc_access_size[2:0] = 3'b010;  //word
  4'b0111: ld_ag_dc_access_size[2:0] = 3'b011;  //dword
  4'b1111: ld_ag_dc_access_size[2:0] = 3'b100;  //qword
  default: ld_ag_dc_access_size[2:0] = 3'b0;
endcase
// &CombEnd; @397
end
//----------------generate unalign--------------------------
//-----------unalign--------------------
// &CombBeg; @400
always @( ld_ag_inst_size[1:0]
       or ld_ag_va_ori[2:0])
begin
casez({ld_ag_inst_size[1:0],ld_ag_va_ori[2:0]})
  {BYTE,3'b???}:ld_ag_align = 1'b1;
  {HALF,3'b??0}:ld_ag_align = 1'b1;
  {WORD,3'b?00}:ld_ag_align = 1'b1;
  {DWORD,3'b000}:ld_ag_align = 1'b1;//NOTE:in risc-v isa, double inst misalign is set
                                    //     when double not align,
                                    //     but in csky, double misalign is set
                                    //     when word not align
  default:ld_ag_align  = 1'b0;
endcase
// &CombEnd; @411
end
assign ld_ag_unalign = !ld_ag_align;

// for strong order,only support access size aligned address
//&CombBeg;
//casez({ld_ag_access_size[3:0],ld_ag_va_ori[3:0]})
//  {4'b0000,4'b????}:ld_ag_align_so = 1'b1;       //byte
//  {4'b0001,4'b???0}:ld_ag_align_so = 1'b1;       //half
//  {4'b0011,4'b??00}:ld_ag_align_so = 1'b1;       //word
//  {4'b0111,4'b?000}:ld_ag_align_so = 1'b1;       //dword
//  {4'b1111,4'b0000}:ld_ag_align_so = 1'b1;       //qword
//  default:ld_ag_align_so  = 1'b0;
//endcase
//&CombEnd;
assign ld_ag_unalign_so = !ld_ag_align;

//---------------boundary---------------
assign ld_ag_va_add_access_size[4:0]  = {1'b0,ld_ag_va_ori[3:0]} + {1'b0,ld_ag_access_size[3:0]};
assign ld_ag_boundary_unmask  = ld_ag_va_add_access_size[4];

// &Force("output", "ld_ag_boundary"); @431
assign ld_ag_boundary = (ld_ag_boundary_unmask
                            ||  ld_ag_secd)
                        &&  ld_ag_ld_inst;

//----------------generate bytes_vld------------------------
//-----------in le/bev2-----------------
//the 2nd half boundary inst will +128, so va[3:0] of 2nd inst will not change
// &CombBeg; @439
always @( ld_ag_va_ori[3:0])
begin
case(ld_ag_va_ori[3:0])
  4'b0000:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hffff;
  4'b0001:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfffe;
  4'b0010:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfffc;
  4'b0011:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfff8;
  4'b0100:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfff0;
  4'b0101:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hffe0;
  4'b0110:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hffc0;
  4'b0111:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hff80;
  4'b1000:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hff00;
  4'b1001:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfe00;
  4'b1010:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfc00;
  4'b1011:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hf800;
  4'b1100:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hf000;
  4'b1101:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'he000;
  4'b1110:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'hc000;
  4'b1111:ld_ag_le_bytes_vld_high_bits_full[15:0] = 16'h8000;
  default:ld_ag_le_bytes_vld_high_bits_full[15:0] = {16{1'bx}};
endcase
// &CombEnd; @459
end

// &CombBeg; @461
always @( ld_ag_va_add_access_size[3:0])
begin
case(ld_ag_va_add_access_size[3:0])
  4'b0000:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0001;
  4'b0001:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0003;
  4'b0010:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0007;
  4'b0011:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h000f;
  4'b0100:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h001f;
  4'b0101:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h003f;
  4'b0110:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h007f;
  4'b0111:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h00ff;
  4'b1000:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h01ff;
  4'b1001:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h03ff;
  4'b1010:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h07ff;
  4'b1011:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0fff;
  4'b1100:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h1fff;
  4'b1101:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h3fff;
  4'b1110:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'h7fff;
  4'b1111:ld_ag_le_bytes_vld_low_bits_full[15:0] = 16'hffff;
  default:ld_ag_le_bytes_vld_low_bits_full[15:0] = {16{1'bx}};
endcase
// &CombEnd; @481
end

assign ld_ag_le_bytes_vld_cross[15:0]       = ld_ag_le_bytes_vld_high_bits_full[15:0]
                                                & ld_ag_le_bytes_vld_low_bits_full[15:0];

assign ld_ag_le_bytes_vld_low_cross_bits[15:0]  = ld_ag_boundary_unmask
                                                  ? ld_ag_le_bytes_vld_low_bits_full[15:0]
                                                  : ld_ag_le_bytes_vld_cross[15:0]; 

assign ld_ag_le_bytes_vld_high_bits[15:0]   = ld_ag_le_bytes_vld_high_bits_full[15:0];
//-----------select bytes_vld-----------
assign ld_ag_bytes_vld_low_cross_bits[15:0] = ld_ag_le_bytes_vld_low_cross_bits[15:0];

assign ld_ag_bytes_vld_high_bits[15:0]  = ld_ag_le_bytes_vld_high_bits[15:0];

//used for 
//1.lq create
//2.da data_merge when acclr_en
//bytes_vld1 is the bytes_vld of lower addr when there is a first(bigger) boundary ld inst
assign ld_ag_bytes_vld1[15:0] =  ld_ag_bytes_vld_high_bits[15:0];

assign ld_ag_bytes_vld[15:0]  =  ld_ag_secd
                                 ? ld_ag_bytes_vld_high_bits[15:0]
                                 : ld_ag_bytes_vld_low_cross_bits[15:0];
//==========================================================
//        vector mask
//==========================================================
// &CombBeg; @513
// &CombEnd; @521
// &Force("output","ld_ag_element_cnt"); @523
// &CombBeg; @530
// &CombEnd; @542
// &CombBeg; @547
// &CombEnd; @555
// &CombBeg; @640
// &CombEnd; @651
// &CombBeg; @655
// &CombEnd; @675
// &CombBeg; @684
// &CombEnd; @704
// &CombBeg; @721
// &CombEnd; @741
// &CombBeg; @743
// &CombEnd; @763
// &CombBeg; @765
// &CombEnd; @771
// &CombBeg; @773
// &CombEnd; @779
// &CombBeg; @786
// &CombEnd; @805
// &CombBeg; @808
// &CombEnd; @828
// &CombBeg; @844
// &CombEnd; @852
// &CombBeg; @854
// &CombEnd; @866
// &CombBeg; @874
// &CombEnd; @893
// &CombBeg; @898
// &CombEnd; @906
// &CombBeg; @913
// &CombEnd; @920
// &CombBeg; @927
// &CombEnd; @935
// &Force("output","ld_ag_vsew"); @938
// &Force("output","ld_ag_inst_vls"); @939
assign ld_ag_dc_bytes_vld[15:0]  = ld_ag_bytes_vld[15:0];
assign ld_ag_dc_bytes_vld1[15:0] = ld_ag_bytes_vld1[15:0];
assign ld_ag_dc_rot_sel[3:0]     = ld_ag_va_ori[3:0];
//==========================================================
//        MMU interface
//==========================================================
//-----------mmu input--------------------------------------
assign lsu_mmu_va0_vld              = ld_ag_inst_vld;
assign lsu_mmu_va0[63:0]            = ld_ag_base[63:0];
// &Force("output","lsu_mmu_abort0"); @960
assign lsu_mmu_abort0               = ld_ag_cross_page_ldr_imme_stall_req
                                      ||  ld_ag_atomic_no_cmit_restart_req
                                      ||  ld_ag_dcache_stall_req
                                      ||  ld_ag_expt_misalign_no_page
                                      ||  rtu_yy_xx_flush;
assign lsu_mmu_id0[6:0]             = ld_ag_iid[6:0];
assign lsu_mmu_st_inst0             = ld_ag_ldamo_inst;

//-----------mmu output-------------------------------------
assign ld_ag_pn[`PA_WIDTH-13:0]     = mmu_lsu_pa0[`PA_WIDTH-13:0];
// &Force("output", "ld_ag_page_so"); @971
assign ld_ag_page_so        = mmu_lsu_so0 && mmu_lsu_pa0_vld;
// &Force("output", "ld_ag_page_ca"); @973
assign ld_ag_page_ca        = mmu_lsu_ca0 && mmu_lsu_pa0_vld;
assign ld_ag_page_buf       = mmu_lsu_buf0;
assign ld_ag_page_sec       = mmu_lsu_sec0;
assign ld_ag_page_share     = mmu_lsu_sh0;
// &Force("output","ld_ag_utlb_miss"); @978
assign ld_ag_utlb_miss      = !mmu_lsu_pa0_vld;

assign ld_ag_page_fault     = mmu_lsu_page_fault0;
//assign ld_ag_access_fault   = mmu_lsu_access_fault0;

//==========================================================
//        Generate physical address
//==========================================================
// &Force("output","ld_ag_pa"); @987
assign ld_ag_pa[`PA_WIDTH-1:0]     = {ld_ag_pn[`PA_WIDTH-13:0],ld_ag_va[11:0]};

//grs inst use va, rather than pa
assign ld_ag_addr0[`PA_WIDTH-1:0]  = ld_ag_pa[`PA_WIDTH-1:0];

// used for boundary inst acceleration
assign ld_ag_addr1_to4[59:0]  = ld_ag_va_ori[63:4];
assign ld_ag_acclr_en         = ld_ag_boundary
                                &&  !ld_ag_4k_sum_ori[12]
                                &&  !cp0_lsu_cb_aclr_dis
                                &&  !ld_ag_secd
                                &&  !ld_ag_inst_fof
                                &&  cp0_lsu_dcache_en
                                &&  !ld_ag_already_cross_page_ldr_imme;

// &Force("output","ld_ag_dc_acclr_en");  @1003
assign ld_ag_dc_acclr_en     = ld_ag_acclr_en
                               && mmu_lsu_pa0_vld
                               && ld_ag_page_ca;

//fwd bypass is bypass data from pipe5 EX1 stage when ld is at AG stage
// used for ld fwd bypass what means
//only support byte,half,word,double word
// &CombBeg; @1011
always @( ld_ag_access_size[3:0])
begin
case(ld_ag_access_size[3:0])
  4'b0000: ld_ag_bypass_en = 1'b1;  //byte
  4'b0001: ld_ag_bypass_en = 1'b1;  //half
  4'b0011: ld_ag_bypass_en = 1'b1;  //word
  4'b0111: ld_ag_bypass_en = 1'b1;  //dword
  4'b1111: ld_ag_bypass_en = 1'b1;  //qword
  default: ld_ag_bypass_en = 1'b0;
endcase
// &CombEnd; @1020
end

assign ld_ag_dc_fwd_bypass_en = ld_ag_bypass_en
                                && !ld_ag_inst_vls
                                && !ld_ag_boundary;

//==========================================================
//        Generage commit signal
//==========================================================
assign ld_ag_cmit_hit0  = {rtu_yy_xx_commit0,rtu_yy_xx_commit0_iid[6:0]}
                          ==  {1'b1,ld_ag_iid[6:0]};
assign ld_ag_cmit_hit1  = {rtu_yy_xx_commit1,rtu_yy_xx_commit1_iid[6:0]}
                          ==  {1'b1,ld_ag_iid[6:0]};
assign ld_ag_cmit_hit2  = {rtu_yy_xx_commit2,rtu_yy_xx_commit2_iid[6:0]}
                          ==  {1'b1,ld_ag_iid[6:0]};

// //&Force("output","ld_ag_cmit"); @1036
assign ld_ag_cmit       = ld_ag_cmit_hit0
                          ||  ld_ag_cmit_hit1
                          ||  ld_ag_cmit_hit2;

//==========================================================
//        Generage dcache request information
//==========================================================
assign ag_dcache_arb_ld_gateclk_en  = ld_ag_inst_vld
                                      &&  cp0_lsu_dcache_en;

//for timing, delete mmu signal
assign ag_dcache_arb_ld_req = ld_ag_inst_vld
                              &&  cp0_lsu_dcache_en;
//                              &&  !ld_ag_expt_vld
//                              &&  !ld_ag_prior_stall_restart;
//                              &&  ld_ag_page_ca
//                              &&  mmu_lsu_pa0_vld;

//-----------tag array-------------------------------------
assign ag_dcache_arb_ld_tag_gateclk_en  = ag_dcache_arb_ld_gateclk_en;
assign ag_dcache_arb_ld_tag_req         = ag_dcache_arb_ld_req;
assign ag_dcache_arb_ld_tag_idx[8:0]    = ld_ag_pa[14:6];
//assign ag_dcache_arb_ld_tag_din[35:0] = 36'b0;
//assign ag_dcache_arb_ld_tag_wen[1:0]  = 2'b0;

//-----------data array------------------------------------
//------------data req signal-----------
// &CombBeg; @1064
always @( ld_ag_va_add_access_size[3:2]
       or ld_ag_va_ori[3:2]
       or ld_ag_boundary
       or ld_ag_secd)
begin
casez({ld_ag_boundary,ld_ag_secd,ld_ag_va_ori[3:2],ld_ag_va_add_access_size[3:2]})
  {1'b0,1'b?,2'b00,2'b00}:bank_en_low_ori[3:0] = 4'b0001;
  {1'b0,1'b?,2'b00,2'b01}:bank_en_low_ori[3:0] = 4'b0011;
  {1'b0,1'b?,2'b00,2'b10}:bank_en_low_ori[3:0] = 4'b0111;
  {1'b0,1'b?,2'b00,2'b11}:bank_en_low_ori[3:0] = 4'b1111;
  {1'b0,1'b?,2'b01,2'b01}:bank_en_low_ori[3:0] = 4'b0010;
  {1'b0,1'b?,2'b01,2'b10}:bank_en_low_ori[3:0] = 4'b0110;
  {1'b0,1'b?,2'b01,2'b11}:bank_en_low_ori[3:0] = 4'b1110;
  {1'b0,1'b?,2'b10,2'b10}:bank_en_low_ori[3:0] = 4'b0100;
  {1'b0,1'b?,2'b10,2'b11}:bank_en_low_ori[3:0] = 4'b1100;
  {1'b0,1'b?,2'b11,2'b11}:bank_en_low_ori[3:0] = 4'b1000;
  {1'b1,1'b0,2'b??,2'b00}:bank_en_low_ori[3:0] = 4'b0001;
  {1'b1,1'b0,2'b??,2'b01}:bank_en_low_ori[3:0] = 4'b0011;
  {1'b1,1'b0,2'b??,2'b10}:bank_en_low_ori[3:0] = 4'b0111;
  {1'b1,1'b0,2'b??,2'b11}:bank_en_low_ori[3:0] = 4'b1111;
  {1'b1,1'b1,2'b00,2'b??}:bank_en_low_ori[3:0] = 4'b1111;
  {1'b1,1'b1,2'b01,2'b??}:bank_en_low_ori[3:0] = 4'b1110;
  {1'b1,1'b1,2'b10,2'b??}:bank_en_low_ori[3:0] = 4'b1100;
  {1'b1,1'b1,2'b11,2'b??}:bank_en_low_ori[3:0] = 4'b1000;
  default:bank_en_low_ori[3:0]  = 4'b0;
endcase
// &CombEnd; @1086
end

//if accelate, it must access all banks for 128 bits
assign bank_en_low[3:0] = ld_ag_acclr_en ? 4'b1111
                                         : bank_en_low_ori[3:0];
//-------------for gateclk--------------

assign bank_en_low_gateclk[3:0]   = bank_en_low[3:0];

assign ag_dcache_arb_ld_data_gateclk_en[7:0]  = {bank_en_low_gateclk[3:0],bank_en_low_gateclk[3:0]}
                                                & {8{ag_dcache_arb_ld_gateclk_en}};

//--------------for req-----------------
assign ag_dcache_arb_ld_data_req[7:0] = {bank_en_low[3:0],bank_en_low[3:0]}
                                        & {8{ag_dcache_arb_ld_req}};

//-----------data idx-------------------
assign ag_dcache_arb_ld_data_low_idx[10:0]  = ld_ag_pa[14:4];
assign ag_dcache_arb_ld_data_high_idx[10:0] = {ld_ag_pa[14:5],~ld_ag_pa[4]};

//low/high din
//assign ag_dcache_arb_ld_data_low_din[127:0]   = 128'b0;
//assign ag_dcache_arb_ld_data_high_din[127:0]  = 128'b0;

//assign ag_dcache_arb_ld_data_wen[31:0] = 32'b0;

//==========================================================
//        Generage exception signal
//==========================================================
//if the 1st boundary instruction is weak order and 2nd is strong order, then treat
//this instruction as weak order
// &Force("output", "ld_ag_expt_misalign_no_page"); @1117
assign ld_ag_expt_misalign_no_page  = ld_ag_unalign
                                      &&  (ld_ag_atomic
                                          ||  ld_ag_inst_vls
                                          ||  ld_ag_ld_inst
                                              &&  !cp0_lsu_mm)
                                      &&  !ld_ag_preld_inst;

// &Force("output","ld_ag_expt_misalign_with_page"); @1124
assign ld_ag_expt_misalign_with_page  = ld_ag_unalign_so
                                        &&  ld_ag_page_so
                                        &&  mmu_lsu_pa0_vld
                                        &&  ld_ag_ld_inst
                                        &&  !ld_ag_preld_inst;

// &Force("output", "ld_ag_expt_page_fault"); @1130
assign ld_ag_expt_page_fault       = mmu_lsu_pa0_vld
                                    &&  ld_ag_page_fault
                                    &&  !ld_ag_preld_inst;

// &Force("output","ld_ag_expt_ldamo_not_ca"); @1134
assign ld_ag_expt_ldamo_not_ca    = mmu_lsu_pa0_vld
                                    &&  ld_ag_ldamo_inst
                                    &&  !ld_ag_page_ca
                                    &&  !ld_ag_preld_inst;

// //&Force("output", "ld_ag_expt_access_fault"); @1139
//assign ld_ag_expt_access_fault    = mmu_lsu_pa0_vld
//                                    &&  (ld_ag_access_fault
//                                        ||  ld_ag_ldamo_inst
//                                            &&  !ld_ag_page_ca);

//for vector strong order
// &Force("output", "ld_ag_expt_access_fault_with_page"); @1146
assign ld_ag_expt_access_fault_with_page = mmu_lsu_pa0_vld
                                           &&  ld_ag_page_so
                                           &&  ld_ag_ld_inst
                                           &&  ld_ag_inst_vls
                                           &&  !ld_ag_preld_inst;

assign ld_ag_expt_vld         = ld_ag_expt_misalign_no_page
                                ||  ld_ag_expt_misalign_with_page
                                ||  ld_ag_expt_access_fault_with_page
                                ||  ld_ag_bc_expt_misalign
                                ||  ld_ag_bc_expt_check_fail
                                ||  ld_ag_expt_page_fault;

//==========================================================
//        Generage Bound Check Instruction Signal
//==========================================================
assign ld_ag_inst_bc_src0[63:0] = ld_ag_base[63:0];

assign ld_ag_inst_bc_src1[63:0] = ld_ag_offset[63:0];

assign ld_ag_bc_gt = ld_ag_inst_bc_src0[63:0] > ld_ag_inst_bc_src1[63:0];

assign ld_ag_bc_le = !ld_ag_bc_gt;

assign ld_ag_inst_bc_gt = (ld_ag_inst_code[31:15] == 17'b00111000011101000) || //fldgt.s
                          (ld_ag_inst_code[31:15] == 17'b00111000011101001) || //fldgt.d
                          (ld_ag_inst_code[31:15] == 17'b00111000011110000) || //ldgt.b
                          (ld_ag_inst_code[31:15] == 17'b00111000011110001) || //ldgt.h
                          (ld_ag_inst_code[31:15] == 17'b00111000011110010) || //ldgt.w
                          (ld_ag_inst_code[31:15] == 17'b00111000011110011);   //ldgt.d

assign ld_ag_inst_bc_le = (ld_ag_inst_code[31:15] == 17'b00111000011101010) || //fldle.s
                          (ld_ag_inst_code[31:15] == 17'b00111000011101011) || //fldle.d
                          (ld_ag_inst_code[31:15] == 17'b00111000011110100) || //ldle.b
                          (ld_ag_inst_code[31:15] == 17'b00111000011110101) || //ldle.h
                          (ld_ag_inst_code[31:15] == 17'b00111000011110110) || //ldle.w
                          (ld_ag_inst_code[31:15] == 17'b00111000011110111);   //ldle.d

assign ld_ag_bc_expt_misalign = ld_ag_inst_vld
                                && ld_ag_unalign
                                && (ld_ag_inst_bc_gt
                                    || ld_ag_inst_bc_le
                                    );

assign ld_ag_bc_expt_check_fail = ld_ag_inst_vld
                                && !ld_ag_unalign
                                && (ld_ag_inst_bc_gt && ld_ag_bc_le
                                    || ld_ag_inst_bc_le && ld_ag_bc_gt
                                    );

//==========================================================
//        Generage stall/restart signal
//==========================================================
//-----------restart----------------------------------------
assign ld_ag_atomic_no_cmit_restart_req = ld_ag_inst_vld
                                          &&  ld_ag_atomic
                                          &&  !ld_ag_cmit;

//-----------stall------------------------------------------
//get the stall signal if virtual address cross 4k address
//for timing, if there is a carry adding last 12 bits, or there is '1' in high
//bits, it will stall
//---------------------cross 4k-----------------------------
assign ld_ag_4k_sum_ori[12:0]   = {1'b0,ld_ag_base[11:0]} 
                                  + {ld_ag_offset_rp[63], ld_ag_offset_aftershift[11:0]};

assign ld_ag_4k_sum_plus[12:0]   = {1'b0,ld_ag_base[11:0]} 
                                  + ld_ag_offset_shift_plus[12:0];

assign ld_ag_off_4k_high_bits_all_0_ori = !(|ld_ag_offset_aftershift[63:12]);
assign ld_ag_off_4k_high_bits_all_1_ori = &ld_ag_offset_aftershift[63:12];
assign ld_ag_off_4k_high_bits_not_eq    = !ld_ag_off_4k_high_bits_all_0_ori
                                          &&  !ld_ag_off_4k_high_bits_all_1_ori;

assign ld_ag_4k_sum_12  = ld_ag_va_plus_sel ? ld_ag_4k_sum_plus[12]
                                            : ld_ag_4k_sum_ori[12];

assign ld_ag_cross_4k   = ld_ag_4k_sum_12
                          ||  ld_ag_off_4k_high_bits_not_eq;

//only ldr will trigger secd stall, and will stall at the first split
assign ld_ag_boundary_stall = ld_ag_inst_ldr && ld_ag_boundary && !ld_ag_secd;
assign ld_ag_secd_imme_stall  = ld_ag_boundary_stall  &&  !ld_ag_already_cross_page_ldr_imme;

assign ld_ag_dcache_stall_unmask    = !dcache_arb_ag_ld_sel;
//because corss_4k to mmu, so there doesn't exist prior stall
assign ld_ag_cross_page_ldr_imme_stall_req =  (ld_ag_cross_4k
                                                  ||  ld_ag_secd_imme_stall)
                                              &&  !ld_ag_expt_misalign_no_page
                                              &&  ld_ag_inst_vld;
assign ld_ag_dcache_stall_req   = ld_ag_dcache_stall_unmask
                                  &&  ld_ag_inst_vld;
assign ld_ag_mmu_stall_req      = mmu_lsu_stall0;

//-----------arbiter----------------------------------------
//prioritize:
//  1. prior_restart  : ldex_no_cmit
//  2. cross_page_ldr_imme_stall    : cross_4k, secd_imme
//  3. dcache_stall    : cache
//  other restart flop to dc stage
//  other_restart  : utlb_miss, tlb_busy

//assign ld_ag_prior_stall_restart  = ld_ag_atomic_no_cmit_restart_req
//                                    ||  ld_ag_cross_page_ldr_imme_stall_req;

assign ld_ag_stall_restart        = ld_ag_atomic_no_cmit_restart_req
                                    ||  ld_ag_cross_page_ldr_imme_stall_req
                                    ||  ld_ag_dcache_stall_req
                                    ||  ld_ag_mmu_stall_req;

assign ld_ag_atomic_no_cmit_restart_arb = ld_ag_atomic_no_cmit_restart_req;
assign ld_ag_cross_page_ldr_imme_stall_arb  = !ld_ag_atomic_no_cmit_restart_req
                                              &&  ld_ag_cross_page_ldr_imme_stall_req
                                              &&  !ld_ag_stall_mask;

//-----------generate total siangl--------------------------
// &Force("output","ld_ag_stall_ori"); @1223
assign ld_ag_stall_ori            = (ld_ag_cross_page_ldr_imme_stall_req
                                        ||  ld_ag_dcache_stall_req
                                        ||  ld_ag_mmu_stall_req)
                                    &&  !ld_ag_atomic_no_cmit_restart_req;

assign ld_ag_stall_vld            = ld_ag_stall_ori
                                    && !ld_ag_stall_mask;

//for performance,when ag stall,let oldest inst go

// &Instance("ct_rtu_compare_iid","x_lsu_rf_compare_ld_ag_iid"); @1234
ct_rtu_compare_iid  x_lsu_rf_compare_ld_ag_iid (
  .x_iid0                    (idu_lsu_rf_pipe3_iid[6:0]),
  .x_iid0_older              (rf_iid_older_than_ld_ag  ),
  .x_iid1                    (ld_ag_iid[6:0]           )
);

// &Connect( .x_iid0         (idu_lsu_rf_pipe3_iid[6:0]), @1235
//           .x_iid1         (ld_ag_iid[6:0]           ), @1236
//           .x_iid0_older   (rf_iid_older_than_ld_ag )); @1237

assign ld_ag_stall_mask = idu_lsu_rf_pipe3_sel
                          && rf_iid_older_than_ld_ag;

assign ld_ag_stall_restart_entry[LSIQ_ENTRY-1:0] = ld_ag_stall_mask
                                                   ? ld_ag_lsid[LSIQ_ENTRY-1:0]
                                                   : idu_lsu_rf_pipe3_lch_entry[LSIQ_ENTRY-1:0];

//==========================================================
//        Generage to DC stage signal
//==========================================================
// &Force("output", "ld_ag_dc_inst_vld"); @1249
assign ld_ag_dc_inst_vld          = ld_ag_inst_vld
                                    &&  !ld_ag_stall_restart;

assign ld_ag_dc_mmu_req           = !lsu_mmu_abort0;

//this logic may be redundant
assign ld_ag_dc_addr0[`PA_WIDTH-1:0] = dcache_arb_ld_ag_borrow_addr_vld
                                      ? dcache_arb_ld_ag_addr[`PA_WIDTH-1:0]
                                      : ld_ag_addr0[`PA_WIDTH-1:0];

//for idu timing
// &Force("output","ld_ag_inst_vfls");  @1261
// &Force("output","ld_ag_dc_load_inst_vld"); @1262
//TODO ld_ag_ahead_predict is the predict result for 3 write back
// &Force("output","ld_ag_ahead_predict"); @1264
assign ld_ag_ahead_predict        = 1'b1;
assign ld_ag_dc_load_inst_vld       = ld_ag_inst_vld
                                      &&  !ld_ag_inst_vfls
                                      &&  !(ld_ag_boundary
                                          && !ld_ag_acclr_en);
//if boundary and acclr en, then set load_inst_vld and clr
//load_ahead_inst_vld, because boundary don't write back in 3 cycles
assign ld_ag_dc_load_ahead_inst_vld = ld_ag_inst_vld
                                      &&  !ld_ag_inst_vfls
                                      &&  !ld_ag_boundary
                                      &&  !cp0_lsu_da_fwd_dis
                                      &&  ld_ag_ahead_predict;

// &Force("output","ld_ag_dc_vload_inst_vld"); @1278
assign ld_ag_dc_vload_inst_vld        = ld_ag_inst_vld
                                        &&  ld_ag_inst_vfls
                                        &&  !ld_ag_vmb_merge_vld
                                        &&  !(ld_ag_boundary
                                              && !ld_ag_acclr_en);
//assign ld_ag_dc_vload_ahead_inst_vld  = ld_ag_inst_vld
//                                        &&  ld_ag_inst_vfls
//                                        &&  !ld_ag_inst_vls
//                                        &&  !ld_ag_boundary
//                                        &&  !cp0_lsu_da_fwd_dis
//                                        &&  ld_ag_ahead_predict;
assign ld_ag_dc_vload_ahead_inst_vld = 1'b0; 

//-----------for timing--------------------------
//compare iid ahead for dc restart timing
//compare the instruction in the entry is newer or older
// &Instance("ct_rtu_compare_iid","x_lsu_ld_ag_compare_st_ag_iid"); @1295
ct_rtu_compare_iid  x_lsu_ld_ag_compare_st_ag_iid (
  .x_iid0         (st_ag_iid[6:0]),
  .x_iid0_older   (ld_ag_raw_new ),
  .x_iid1         (ld_ag_iid[6:0])
);

// &Connect( .x_iid0         (st_ag_iid[6:0]         ), @1296
//           .x_iid1         (ld_ag_iid[6:0]         ), @1297
//           .x_iid0_older   (ld_ag_raw_new          )); @1298

//==========================================================
//              Interface to other module
//==========================================================
//-----------interface to cmit monitor----------------------
//assign ld_ag_inst_wait_cmit_vld = ld_ag_inst_vld
//                                  &&  ld_ag_atomic;
//-----------interface to local monitor---------------------
assign ld_ag_lm_init_vld  = ld_ag_inst_vld
                            &&  ld_ag_atomic
                            &&  ld_ag_cmit;

//==========================================================
//        Generate restart/lsiq signal
//==========================================================
//-----------lsiq signal----------------
assign ld_ag_mask_lsid[LSIQ_ENTRY-1:0]    = {LSIQ_ENTRY{ld_ag_inst_vld}}
                                            &  ld_ag_lsid[LSIQ_ENTRY-1:0];

assign lsu_idu_ld_ag_wait_old_gateclk_en = ld_ag_atomic_no_cmit_restart_arb;
assign lsu_idu_ld_ag_wait_old[LSIQ_ENTRY-1:0]  = ld_ag_mask_lsid[LSIQ_ENTRY-1:0]
                                                 & {LSIQ_ENTRY{ld_ag_atomic_no_cmit_restart_arb}};

//==========================================================
//        for idu timing
//==========================================================
assign lsu_idu_ag_pipe3_load_inst_vld  = ld_ag_inst_vld
                                         && !ld_ag_inst_vfls
                                         && !cp0_lsu_da_fwd_dis
                                         && ld_ag_ahead_predict;

assign lsu_idu_ag_pipe3_preg_dup0[6:0] = ld_ag_preg[6:0];
assign lsu_idu_ag_pipe3_preg_dup1[6:0] = ld_ag_preg_dup1[6:0];
assign lsu_idu_ag_pipe3_preg_dup2[6:0] = ld_ag_preg_dup2[6:0];
assign lsu_idu_ag_pipe3_preg_dup3[6:0] = ld_ag_preg_dup3[6:0];
assign lsu_idu_ag_pipe3_preg_dup4[6:0] = ld_ag_preg_dup4[6:0];

assign lsu_idu_ag_pipe3_vload_inst_vld = ld_ag_inst_vld
                                         && ld_ag_inst_vfls
                                         && !ld_ag_inst_vls
                                         && !cp0_lsu_da_fwd_dis
                                         && ld_ag_ahead_predict;

assign lsu_idu_ag_pipe3_vreg_dup0[6:0]      = {1'b0,ld_ag_vreg[5:0]};
assign lsu_idu_ag_pipe3_vreg_dup1[6:0]      = {1'b0,ld_ag_vreg_dup1[5:0]};
assign lsu_idu_ag_pipe3_vreg_dup2[6:0]      = {1'b0,ld_ag_vreg_dup2[5:0]};
assign lsu_idu_ag_pipe3_vreg_dup3[6:0]      = {1'b0,ld_ag_vreg_dup3[5:0]};
//==========================================================
//        interface to hpcp
//==========================================================
assign lsu_hpcp_ld_cross_4k_stall  = ld_ag_inst_vld
                                     &&  ld_ag_already_cross_page_ldr_imme
                                     &&  !ld_ag_stall_vld
                                     &&  !ld_ag_utlb_miss
                                     &&  !ld_ag_already_da;
assign lsu_hpcp_ld_other_stall     = ld_ag_inst_vld
                                     &&  !ld_ag_cross_4k
                                     &&  ld_ag_stall_vld
                                     &&  !ld_ag_utlb_miss
                                     &&  !ld_ag_already_da;


// &ModuleEnd; @1363
endmodule


