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
module ct_lsu_st_ag (
  // &Ports, @29
  input    wire          cp0_lsu_dcache_en,
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_lsu_mm,
  input    wire          cp0_lsu_tvm,
  input    wire          cp0_lsu_ucme,
  input    wire          cp0_lsu_wa,
  input    wire          cp0_yy_clk_en,
  input    wire  [1 :0]  cp0_yy_priv_mode,
  input    wire          cp0_yy_virtual_mode,
  input    wire          cpurst_b,
  input    wire          ctrl_st_clk,
  input    wire          dcache_arb_ag_st_sel,
  input    wire  [39:0]  dcache_arb_st_ag_addr,
  input    wire          dcache_arb_st_ag_borrow_addr_vld,
  input    wire          forever_cpuclk,
  input    wire          idu_lsu_rf_pipe4_already_da,
  input    wire          idu_lsu_rf_pipe4_atomic,
  input    wire          idu_lsu_rf_pipe4_bkpta_data,
  input    wire          idu_lsu_rf_pipe4_bkptb_data,
  input    wire  [3 :0]  idu_lsu_rf_pipe4_fence_mode,
  input    wire          idu_lsu_rf_pipe4_gateclk_sel,
  input    wire          idu_lsu_rf_pipe4_icc,
  input    wire  [6 :0]  idu_lsu_rf_pipe4_iid,
  input    wire  [31:0]  idu_lsu_rf_pipe4_inst_code,
  input    wire          idu_lsu_rf_pipe4_inst_fls,
  input    wire          idu_lsu_rf_pipe4_inst_flush,
  input    wire  [1 :0]  idu_lsu_rf_pipe4_inst_mode,
  input    wire          idu_lsu_rf_pipe4_inst_share,
  input    wire  [1 :0]  idu_lsu_rf_pipe4_inst_size,
  input    wire          idu_lsu_rf_pipe4_inst_str,
  input    wire  [1 :0]  idu_lsu_rf_pipe4_inst_type,
  input    wire  [11:0]  idu_lsu_rf_pipe4_lch_entry,
  input    wire          idu_lsu_rf_pipe4_lsfifo,
  input    wire          idu_lsu_rf_pipe4_mmu_req,
  input    wire          idu_lsu_rf_pipe4_no_spec,
  input    wire          idu_lsu_rf_pipe4_off_0_extend,
  input    wire  [13:0]  idu_lsu_rf_pipe4_offset,
  input    wire  [14:0]  idu_lsu_rf_pipe4_offset_plus,
  input    wire          idu_lsu_rf_pipe4_oldest,
  input    wire  [14:0]  idu_lsu_rf_pipe4_pc,
  input    wire  [11:0]  idu_lsu_rf_pipe4_sdiq_entry,
  input    wire          idu_lsu_rf_pipe4_sel,
  input    wire  [3 :0]  idu_lsu_rf_pipe4_shift,
  input    wire          idu_lsu_rf_pipe4_spec_fail,
  input    wire          idu_lsu_rf_pipe4_split,
  input    wire  [63:0]  idu_lsu_rf_pipe4_src0,
  input    wire  [63:0]  idu_lsu_rf_pipe4_src1,
  input    wire          idu_lsu_rf_pipe4_st,
  input    wire          idu_lsu_rf_pipe4_staddr,
  input    wire          idu_lsu_rf_pipe4_sync_fence,
  input    wire          idu_lsu_rf_pipe4_unalign_2nd,
  input    wire  [27:0]  lm_addr_pa,
  input    wire          lm_page_buf,
  input    wire          lm_page_ca,
  input    wire          lm_page_sec,
  input    wire          lm_page_share,
  input    wire          lm_page_so,
  input    wire          mmu_lsu_buf1,
  input    wire          mmu_lsu_ca1,
  input    wire  [27:0]  mmu_lsu_pa1,
  input    wire          mmu_lsu_pa1_vld,
  input    wire          mmu_lsu_page_fault1,
  input    wire          mmu_lsu_sec1,
  input    wire          mmu_lsu_sh1,
  input    wire          mmu_lsu_so1,
  input    wire          mmu_lsu_stall1,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_yy_xx_commit0,
  input    wire  [6 :0]  rtu_yy_xx_commit0_iid,
  input    wire          rtu_yy_xx_commit1,
  input    wire  [6 :0]  rtu_yy_xx_commit1_iid,
  input    wire          rtu_yy_xx_commit2,
  input    wire  [6 :0]  rtu_yy_xx_commit2_iid,
  input    wire          rtu_yy_xx_dbgon,
  input    wire          rtu_yy_xx_flush,
  output   wire          ag_dcache_arb_st_dirty_gateclk_en,
  output   wire  [8 :0]  ag_dcache_arb_st_dirty_idx,
  output   wire          ag_dcache_arb_st_dirty_req,
  output   wire          ag_dcache_arb_st_tag_gateclk_en,
  output   wire  [8 :0]  ag_dcache_arb_st_tag_idx,
  output   wire          ag_dcache_arb_st_tag_req,
  output   wire          lsu_hpcp_st_cross_4k_stall,
  output   wire          lsu_hpcp_st_other_stall,
  output   wire  [11:0]  lsu_idu_st_ag_wait_old,
  output   wire          lsu_idu_st_ag_wait_old_gateclk_en,
  output   wire          lsu_mmu_abort1,
  output   wire  [6 :0]  lsu_mmu_id1,
  output   wire          lsu_mmu_st_inst1,
  output   wire  [27:0]  lsu_mmu_stamo_pa,
  output   wire          lsu_mmu_stamo_vld,
  output   wire  [63:0]  lsu_mmu_va1,
  output   wire          lsu_mmu_va1_vld,
  output   reg           st_ag_already_da,
  output   reg           st_ag_atomic,
  output   reg   [63:0]  st_ag_atomic_src1_data,
  output   wire  [15:0]  st_ag_atomic_func,
  output   wire          st_ag_boundary,
  output   reg   [2 :0]  st_ag_dc_access_size,
  output   wire  [39:0]  st_ag_dc_addr0,
  output   wire  [15:0]  st_ag_dc_bytes_vld,
  output   wire          st_ag_dc_inst_vld,
  output   wire          st_ag_dc_mmu_req,
  output   wire          st_ag_dc_page_share,
  output   wire  [3 :0]  st_ag_dc_rot_sel,
  output   wire          st_ag_expt_access_fault_with_page,
  output   wire          st_ag_expt_illegal_inst,
  output   wire          st_ag_expt_misalign_no_page,
  output   wire          st_ag_expt_misalign_with_page,
  output   wire          st_ag_expt_page_fault,
  output   wire          st_ag_expt_stamo_not_ca,
  output   wire          st_ag_bc_expt_misalign,
  output   wire          st_ag_bc_expt_check_fail,
  output   wire          st_ag_expt_vld,
  output   reg   [3 :0]  st_ag_fence_mode,
  output   reg           st_ag_icc,
  output   reg   [6 :0]  st_ag_iid,
  output   reg           st_ag_inst_flush,
  output   reg   [1 :0]  st_ag_inst_mode,
  output   reg   [1 :0]  st_ag_inst_type,
  output   reg           st_ag_inst_vld,
  output   reg           st_ag_lsfifo,
  output   reg   [11:0]  st_ag_lsid,
  output   reg           st_ag_lsiq_bkpta_data,
  output   reg           st_ag_lsiq_bkptb_data,
  output   reg           st_ag_lsiq_spec_fail,
  output   reg   [63:0]  st_ag_mt_value,
  output   reg           st_ag_no_spec,
  output   reg           st_ag_old,
  output   wire          st_ag_page_buf,
  output   wire          st_ag_page_ca,
  output   wire          st_ag_page_sec,
  output   wire          st_ag_page_so,
  output   wire          st_ag_page_wa,
  output   reg   [14:0]  st_ag_pc,
  output   reg   [11:0]  st_ag_sdid_oh,
  output   reg           st_ag_secd,
  output   reg           st_ag_split,
  output   reg           st_ag_st,
  output   reg           st_ag_staddr,
  output   wire          st_ag_stall_ori,
  output   wire  [11:0]  st_ag_stall_restart_entry,
  output   reg           st_ag_sync_fence,
  output   wire          st_ag_utlb_miss,
  output   wire  [27:0]  st_ag_vpn,
  output   wire  [23:0]  st_ag_vpn_high,
  output   wire          st_rf_inst_vld
); 



// &Regs; @30
reg     [3 :0]  st_ag_access_size_ori;              
reg             st_ag_align;                        
reg             st_ag_already_cross_page_str_imme;  
reg     [63:0]  st_ag_base;                         
reg     [31:0]  st_ag_inst_code;                    
reg             st_ag_inst_fls;                     
reg             st_ag_inst_share;                   
reg     [1 :0]  st_ag_inst_size;                    
reg             st_ag_inst_str;                     
reg     [15:0]  st_ag_le_bytes_vld_high_bits_full;  
reg     [15:0]  st_ag_le_bytes_vld_low_bits_full;   
reg             st_ag_mmu_req;                      
reg     [63:0]  st_ag_offset;                       
reg     [14:0]  st_ag_offset_plus;                  
reg     [3 :0]  st_ag_offset_shift;                 

// &Wires; @31
wire            ag_dcache_arb_st_gateclk_en;        
wire            ag_dcache_arb_st_req;               
wire            rf_iid_older_than_st_ag;            
wire            st_ag_4k_sum_12;                    
wire    [12:0]  st_ag_4k_sum_ori;                   
wire    [12:0]  st_ag_4k_sum_plus;                  
wire    [3 :0]  st_ag_access_size;                  
wire    [39:0]  st_ag_addr;                         
wire            st_ag_atomic_no_cmit_restart_arb;   
wire            st_ag_atomic_no_cmit_restart_req;   
wire            st_ag_boundary_stall;               
wire            st_ag_boundary_unmask;              
wire    [15:0]  st_ag_bytes_vld;                    
wire    [15:0]  st_ag_bytes_vld_high_cross_bits;    
wire    [15:0]  st_ag_bytes_vld_low_bits;           
wire            st_ag_clk;                          
wire            st_ag_clk_en;                       
wire            st_ag_cmit;                         
wire            st_ag_cmit_hit0;                    
wire            st_ag_cmit_hit1;                    
wire            st_ag_cmit_hit2;                    
wire            st_ag_cross_4k;                     
wire            st_ag_cross_page_str_imme_stall_arb; 
wire            st_ag_cross_page_str_imme_stall_req; 
wire            st_ag_dcache_1line_inst;            
wire            st_ag_dcache_all_inst;              
wire            st_ag_dcache_inst;                  
wire            st_ag_dcache_pa_sw_inst;            
wire            st_ag_dcache_stall_req;             
wire            st_ag_dcache_stall_unmask;          
wire            st_ag_dcache_user_allow_inst;       
wire            st_ag_fence_i_icache_all_inst;      
wire            st_ag_icache_all_inst;              
wire            st_ag_icache_inst;                  
wire            st_ag_icache_inv_va_inst;           
wire            st_ag_icc_inst;                     
wire            st_ag_inst_stall_gateclk_en;        
wire            st_ag_inst_vls;                     
wire            st_ag_l2cache_inst;                 
wire    [15:0]  st_ag_le_bytes_vld_cross;           
wire    [15:0]  st_ag_le_bytes_vld_high_cross_bits; 
wire    [11:0]  st_ag_mask_lsid;                    
wire            st_ag_mmu_stall_req;                
wire            st_ag_off_high_bits_all_0_ori;      
wire            st_ag_off_high_bits_all_1_ori;      
wire            st_ag_off_high_bits_not_eq;         
wire    [63:0]  st_ag_offset_aftershift;            
wire    [39:0]  st_ag_pa;                           
wire            st_ag_page_fault;                   
wire            st_ag_page_share;                   
wire    [27:0]  st_ag_pn;                           
wire            st_ag_prvlg_obey;                   
wire    [15:0]  st_ag_st_bytes_vld;                 
wire            st_ag_st_inst;                      
wire            st_ag_stall_mask;                   
wire            st_ag_stall_restart;                
wire            st_ag_stall_vld;                    
wire            st_ag_stamo_inst;                   
wire            st_ag_statomic_inst;                
wire            st_ag_str_imme_stall;               
wire            st_ag_tlbi_all_inst;                
wire            st_ag_tlbi_inst;                    
wire            st_ag_unalign;                      
wire            st_ag_unalign_so;                   
wire    [63:0]  st_ag_va;                           
wire    [4 :0]  st_ag_va_add_access_size;           
wire    [39:0]  st_ag_va_am;                        
wire    [63:0]  st_ag_va_ori;                       
wire    [63:0]  st_ag_va_plus;                      
wire            st_ag_va_plus_sel;                  
wire            st_rf_inst_str;                     
wire            st_rf_off_0_extend;                 
wire            tcore_vld;                          
wire    [63:0]  st_ag_inst_bc_src0;
wire    [63:0]  st_ag_inst_bc_src1;
wire            st_ag_inst_bc_gt;
wire            st_ag_inst_bc_le;
wire            st_ag_bc_gt;
wire            st_ag_bc_le;
wire    [17:0]  st_ag_offset_shift_plus;

parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;

parameter LSIQ_ENTRY  = 12;
parameter PC_LEN      = 15;
parameter PC_WIDTH    = 64;

//==========================================================
//                        RF signal
//==========================================================
// &Force("output","st_rf_inst_vld"); @44
assign st_rf_inst_vld     = idu_lsu_rf_pipe4_gateclk_sel;
assign st_rf_inst_str     = idu_lsu_rf_pipe4_inst_str;
assign st_rf_off_0_extend = idu_lsu_rf_pipe4_off_0_extend;
//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign st_ag_clk_en = idu_lsu_rf_pipe4_gateclk_sel || st_ag_inst_stall_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_st_ag_gated_clk"); @52
gated_clk_cell  x_lsu_st_ag_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_ag_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (st_ag_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @53
//          .external_en   (1'b0               ), @54
//          .global_en     (cp0_yy_clk_en      ), @55
//          .module_en     (cp0_lsu_icg_en     ), @56
//          .local_en      (st_ag_clk_en       ), @57
//          .clk_out       (st_ag_clk          )); @58

//==========================================================
//                 Pipeline Register
//==========================================================
//------------------control part----------------------------
//+----------+
//| inst_vld |
//+----------+
//if there is a stall in the AG stage ,the inst keep valid,
//elseif there is inst in RF stage and no flush,
//the inst goes to the AG stage next cycle

// &Force("output","st_ag_inst_vld"); @71
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_ag_inst_vld  <=  1'b0;
  else if(rtu_yy_xx_flush)
    st_ag_inst_vld  <=  1'b0;
  else if (st_ag_stall_vld  ||  idu_lsu_rf_pipe4_sel)
    st_ag_inst_vld  <=  1'b1;
  else
    st_ag_inst_vld  <=  1'b0;
end

//------------------data part-------------------------------
//+-----------+-----------+-----------+------+------+------------+-----+-------+
//| inst_type | inst_size | inst_mode | sdid | secd | sync_fence | icc | share |
//+-----------+-----------+-----------+------+------+------------+-----+-------+
//+----------------+----+-----+------+---------+-----+-----------+------------+
//| unalign_permit | ex | iid | lsid | mmu_req | old | fdata_idx | already_da |
//+----------------+----+-----+------+---------+-----+-----------+------------+
//+----------------+------------+-------+
//| lsiq_spec_fail | inst_flush | split |
//+----------------+------------+-------+
//+-------+-------+
//| bkpta | bkptb |
//+-------+-------+
//if there is a stall in the AG stage ,the inst info keep unchanged,
//elseif there is inst in RF stage, the inst goes to the AG stage next cycle

// &Force("output","st_ag_split"); @100
// &Force("output","st_ag_inst_flush"); @101
// &Force("output","st_ag_inst_type"); @102
// //&Force("output","st_ag_inst_size"); @103
// &Force("output","st_ag_inst_mode"); @104
// &Force("output","st_ag_secd"); @105
// &Force("output","st_ag_sync_fence"); @106
// &Force("output","st_ag_icc"); @107
// &Force("output","st_ag_st"); @108
// &Force("output","st_ag_atomic"); @109
// &Force("output","st_ag_iid"); @110
// &Force("output","st_ag_lsid"); @111
// &Force("output","st_ag_sdid_oh"); @112
// &Force("output","st_ag_old"); @113
// &Force("output","st_ag_already_da"); @114
// &Force("output","st_ag_lsiq_spec_fail"); @115
// &Force("output","st_ag_lsiq_bkpta_data"); @116
// &Force("output","st_ag_lsiq_bkptb_data"); @117
// &Force("nonport","st_ag_inst_fls"); @118
// &Force("output","st_ag_pc"); @119
always @(posedge st_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_ag_split                   <=  1'b0;
    st_ag_inst_flush              <=  1'b0;
    st_ag_inst_code[31:0]         <=  32'b0;
    st_ag_inst_type[1:0]          <=  2'b0;
    st_ag_inst_size[1:0]          <=  2'b0;
    st_ag_inst_mode[1:0]          <=  2'b0;
    st_ag_sync_fence              <=  1'b0;
    st_ag_fence_mode[3:0]         <=  4'b0;
    st_ag_inst_share              <=  1'b0;
    st_ag_st                      <=  1'b0;
    st_ag_icc                     <=  1'b0;
    st_ag_atomic                  <=  1'b0;
    st_ag_secd                    <=  1'b0;
    st_ag_iid[6:0]                <=  7'b0;
    st_ag_lsid[LSIQ_ENTRY-1:0]    <=  {LSIQ_ENTRY{1'b0}};
    st_ag_sdid_oh[LSIQ_ENTRY-1:0] <=  {LSIQ_ENTRY{1'b0}};
    st_ag_mmu_req                 <=  1'b0;
    st_ag_old                     <=  1'b0;
    st_ag_inst_str                <=  1'b0;
    st_ag_already_da              <=  1'b0;
    st_ag_lsiq_spec_fail          <=  1'b0;
    st_ag_lsiq_bkpta_data         <=  1'b0;
    st_ag_lsiq_bkptb_data         <=  1'b0;
    st_ag_inst_fls                <=  1'b0;
    st_ag_no_spec                 <=  1'b0;
    st_ag_staddr                  <=  1'b0;
    st_ag_pc[PC_LEN-1:0]          <=  {PC_LEN{1'b0}};
    st_ag_lsfifo                  <=  1'b0;
  end
  else if(!st_ag_stall_vld  &&  st_rf_inst_vld)
  begin
    st_ag_split                   <=  idu_lsu_rf_pipe4_split;
    st_ag_inst_flush              <=  idu_lsu_rf_pipe4_inst_flush;
    st_ag_inst_code[31:0]         <=  idu_lsu_rf_pipe4_inst_code[31:0];
    st_ag_inst_type[1:0]          <=  idu_lsu_rf_pipe4_inst_type[1:0];
    st_ag_inst_size[1:0]          <=  idu_lsu_rf_pipe4_inst_size[1:0];
    st_ag_inst_mode[1:0]          <=  idu_lsu_rf_pipe4_inst_mode[1:0];
    st_ag_sync_fence              <=  idu_lsu_rf_pipe4_sync_fence;
    st_ag_fence_mode[3:0]         <=  idu_lsu_rf_pipe4_fence_mode[3:0];
    st_ag_st                      <=  idu_lsu_rf_pipe4_st;
    st_ag_icc                     <=  idu_lsu_rf_pipe4_icc;
    st_ag_inst_share              <=  idu_lsu_rf_pipe4_inst_share;
    st_ag_atomic                  <=  idu_lsu_rf_pipe4_atomic;
    st_ag_secd                    <=  idu_lsu_rf_pipe4_unalign_2nd;
    st_ag_iid[6:0]                <=  idu_lsu_rf_pipe4_iid[6:0];
    st_ag_lsid[LSIQ_ENTRY-1:0]    <=  idu_lsu_rf_pipe4_lch_entry[LSIQ_ENTRY-1:0];
    st_ag_sdid_oh[LSIQ_ENTRY-1:0] <=  idu_lsu_rf_pipe4_sdiq_entry[LSIQ_ENTRY-1:0];
    st_ag_mmu_req                 <=  idu_lsu_rf_pipe4_mmu_req;
    st_ag_old                     <=  idu_lsu_rf_pipe4_oldest;
    st_ag_inst_str                <=  idu_lsu_rf_pipe4_inst_str;
    st_ag_already_da              <=  idu_lsu_rf_pipe4_already_da;
    st_ag_lsiq_spec_fail          <=  idu_lsu_rf_pipe4_spec_fail;
    st_ag_lsiq_bkpta_data         <=  idu_lsu_rf_pipe4_bkpta_data;
    st_ag_lsiq_bkptb_data         <=  idu_lsu_rf_pipe4_bkptb_data;
    st_ag_inst_fls                <=  idu_lsu_rf_pipe4_inst_fls;
    st_ag_no_spec                 <=  idu_lsu_rf_pipe4_no_spec;
    st_ag_staddr                  <=  idu_lsu_rf_pipe4_staddr;
    st_ag_pc[PC_LEN-1:0]          <=  idu_lsu_rf_pipe4_pc[PC_LEN-1:0];
    st_ag_lsfifo                  <=  idu_lsu_rf_pipe4_lsfifo;
  end
end

wire [15:0] store_ag_pc;
assign store_ag_pc[15:0] = {st_ag_pc[PC_LEN-1:0], 1'b0};

//+------------------+
//| already_cross_4k |
//+------------------+
//already cross 4k means addr1 is wrong, and mustn't merge from cache buffer
always @(posedge st_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_ag_already_cross_page_str_imme  <=  1'b0;
  else if (!st_ag_stall_vld)
    st_ag_already_cross_page_str_imme  <=  1'b0;
  else if(st_ag_stall_vld &&  st_ag_cross_page_str_imme_stall_req)
    st_ag_already_cross_page_str_imme  <=  1'b1;
end

//+--------------+
//| offset_shift |
//+--------------+
//if there is a stall in the AG stage ,offset_shift is reset to 0
//cache stall will not change shift
always @(posedge st_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_ag_offset_shift[3:0] <=  4'b1;
  else if (!st_ag_stall_vld &&  idu_lsu_rf_pipe4_sel)
    st_ag_offset_shift[3:0] <=  idu_lsu_rf_pipe4_shift[3:0];
  else if(st_ag_stall_vld && st_ag_cross_page_str_imme_stall_req)
    st_ag_offset_shift[3:0] <=  4'b1;
end

//+--------+
//| offset |
//+--------+
//if the 1st time boundary 2nd instruction stall, the offset set 16 for bias, else
//if stall, it set to 0, cache stall will not change offset
always @(posedge st_ag_clk)
begin
  if(st_ag_cross_page_str_imme_stall_arb)
    st_ag_offset[63:32]  <=  32'h0;
  else if (!st_ag_stall_vld &&  st_rf_inst_vld  &&  !st_rf_inst_str)
    st_ag_offset[63:32]  <=  {32{idu_lsu_rf_pipe4_offset[13]}};
  else if (!st_ag_stall_vld &&  st_rf_inst_vld  &&  st_rf_inst_str  &&  st_rf_off_0_extend)
    st_ag_offset[63:32]  <=  32'h0;
  else if (!st_ag_stall_vld &&  st_rf_inst_vld)
    st_ag_offset[63:32]  <=  idu_lsu_rf_pipe4_src1[63:32];
end

always @(posedge st_ag_clk)
begin
  if(st_ag_cross_page_str_imme_stall_arb  &&  st_ag_str_imme_stall)
    st_ag_offset[31:0]  <=  32'h10;
  else if(st_ag_cross_page_str_imme_stall_arb)
    st_ag_offset[31:0]  <=  32'h0;
  else if (!st_ag_stall_vld &&  st_rf_inst_vld  &&  !st_rf_inst_str)
    st_ag_offset[31:0]  <=  {{18{idu_lsu_rf_pipe4_offset[13]}},idu_lsu_rf_pipe4_offset[13:0]};
  else if (!st_ag_stall_vld &&  st_rf_inst_vld)
    st_ag_offset[31:0]  <=  idu_lsu_rf_pipe4_src1[31:0];
end

//+-------------+
//| offset_plus |
//+-------------+
//use this imm as offset when the ld/st inst need split and !secd
always @(posedge st_ag_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_ag_offset_plus[14:0]  <=  15'h0;
  else if(st_ag_cross_page_str_imme_stall_arb)
    st_ag_offset_plus[14:0]  <=  15'h0;
  else if (!st_ag_stall_vld &&  st_rf_inst_vld)
    st_ag_offset_plus[14:0]  <=  idu_lsu_rf_pipe4_offset_plus[14:0];
end

//+------+
//| base |
//+------+
always @(posedge st_ag_clk)
begin
  if(st_ag_cross_page_str_imme_stall_arb)
    st_ag_base[63:0]  <=  st_ag_va[63:0];
  else if (!st_ag_stall_vld &&  st_rf_inst_vld)
    st_ag_base[63:0]  <=  idu_lsu_rf_pipe4_src0[63:0];
end


//+-----------+
//| src1 data |
//+-----------+
always @(posedge st_ag_clk)
begin
  if(!cpurst_b)
    st_ag_atomic_src1_data[63:0]  <=  64'b0;
  else if (!st_ag_stall_vld &&  st_rf_inst_vld)
    st_ag_atomic_src1_data[63:0]  <=  idu_lsu_rf_pipe4_src1[63:0];
  else 
    st_ag_atomic_src1_data[63:0]  <=  st_ag_atomic_src1_data[63:0];
end

//+-------------+
//| atomic func |
//+-------------+

assign st_ag_atomic_func[0] =                     
                    (st_ag_inst_code[31:15] == 17'b00111000011000000) || //amswap.w
                    (st_ag_inst_code[31:15] == 17'b00111000011000001) || //amswap.d
                    (st_ag_inst_code[31:15] == 17'b00111000011010010) || //amswap_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011010011);   //amswap_db.d

assign st_ag_atomic_func[1] =
                    (st_ag_inst_code[31:15] == 17'b00111000011000010) || //amadd.w
                    (st_ag_inst_code[31:15] == 17'b00111000011000011) || //amadd.d
                    (st_ag_inst_code[31:15] == 17'b00111000011010100) || //amadd_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011010101);   //amadd_db.d

assign st_ag_atomic_func[2] =
                    (st_ag_inst_code[31:15] == 17'b00111000011000100) || //amand.w
                    (st_ag_inst_code[31:15] == 17'b00111000011000101) || //amand.d
                    (st_ag_inst_code[31:15] == 17'b00111000011010110) || //amand_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011010111);   //amand_db.d

assign st_ag_atomic_func[3] =
                    (st_ag_inst_code[31:15] == 17'b00111000011000110) || //amor.w
                    (st_ag_inst_code[31:15] == 17'b00111000011000111) || //amor.d
                    (st_ag_inst_code[31:15] == 17'b00111000011011000) || //amor_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011011001);   //amor_db.d

assign st_ag_atomic_func[4] =
                    (st_ag_inst_code[31:15] == 17'b00111000011001000) || //amxor.w
                    (st_ag_inst_code[31:15] == 17'b00111000011001001) || //amxor.d
                    (st_ag_inst_code[31:15] == 17'b00111000011011010) || //amxor_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011011011);   //amxor_db.d

assign st_ag_atomic_func[5] =
                    (st_ag_inst_code[31:15] == 17'b00111000011001010) || //ammax.w
                    (st_ag_inst_code[31:15] == 17'b00111000011001011) || //ammax.d
                    (st_ag_inst_code[31:15] == 17'b00111000011011100) || //ammax_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011011101);   //ammax_db.d

assign st_ag_atomic_func[6] =
                    (st_ag_inst_code[31:15] == 17'b00111000011001100) || //ammin.w
                    (st_ag_inst_code[31:15] == 17'b00111000011001101) || //ammin.d
                    (st_ag_inst_code[31:15] == 17'b00111000011011110) || //ammin_db.w
                    (st_ag_inst_code[31:15] == 17'b00111000011011111);   //ammin_db.d

assign st_ag_atomic_func[7] =
                    (st_ag_inst_code[31:15] == 17'b00111000011001110) || //ammax.wu
                    (st_ag_inst_code[31:15] == 17'b00111000011001111) || //ammax.du
                    (st_ag_inst_code[31:15] == 17'b00111000011100000) || //ammax_db.wu
                    (st_ag_inst_code[31:15] == 17'b00111000011100001);   //ammax_db.du

assign st_ag_atomic_func[8] =
                    (st_ag_inst_code[31:15] == 17'b00111000011010000) || //ammin.wu
                    (st_ag_inst_code[31:15] == 17'b00111000011010001) || //ammin.du
                    (st_ag_inst_code[31:15] == 17'b00111000011100010) || //ammin_db.wu
                    (st_ag_inst_code[31:15] == 17'b00111000011100011);   //ammin_db.du


assign st_ag_atomic_func[15:9] = 5'b0;

//==========================================================
//                      AG gateclk
//==========================================================
assign st_ag_inst_stall_gateclk_en  = st_ag_inst_vld;

//==========================================================
//               Generate virtual address
//==========================================================
// for first boundary inst, use addr+offset+128 as va instead of addr+offset
//for secd boundary,use addr+offset as va
assign st_ag_offset_aftershift[63:0]  =   {64{st_ag_offset_shift[0]}} & st_ag_offset[63:0]
                                        | {64{st_ag_offset_shift[1]}} & {st_ag_offset[62:0],1'b0}
                                        | {64{st_ag_offset_shift[2]}} & {st_ag_offset[61:0],2'b0}
                                        | {64{st_ag_offset_shift[3]}} & {st_ag_offset[60:0],3'b0};

assign st_ag_va_ori[63:0]           = st_ag_base[63:0]
                                      + st_ag_offset_aftershift[63:0];

assign st_ag_offset_shift_plus[17:0] =    {18{st_ag_offset_shift[0]}} & {{3{st_ag_offset_plus[14]}}, st_ag_offset_plus[14:0]}
                                        | {18{st_ag_offset_shift[1]}} & {{2{st_ag_offset_plus[14]}}, st_ag_offset_plus[14:0],1'b0}
                                        | {18{st_ag_offset_shift[2]}} & {{1{st_ag_offset_plus[14]}}, st_ag_offset_plus[14:0],2'b0}
                                        | {18{st_ag_offset_shift[3]}} & {st_ag_offset_plus[14:0],3'b0};

assign st_ag_va_plus[63:0]          = st_ag_base[63:0]
                                      + {{46{st_ag_offset_shift_plus[17]}},st_ag_offset_shift_plus[17:0]};

assign st_ag_va_plus_sel            = st_ag_secd
                                      && !st_ag_inst_str;

assign st_ag_va[63:0]               = st_ag_va_plus_sel
                                      ? st_ag_va_plus[63:0]
                                      : st_ag_va_ori[63:0];

assign st_ag_vpn[`PA_WIDTH-13:0]     = st_ag_va[`PA_WIDTH-1:12];
assign st_ag_vpn_high[23:0]          = st_ag_va[63:40];
 
//==========================================================
//        Generate inst type
//==========================================================
assign st_ag_stamo_inst                 = st_ag_atomic
                                          &&  (st_ag_inst_type[1:0]  ==  2'b00);
assign st_ag_icc_inst                   = !st_ag_atomic
                                          &&  !st_ag_sync_fence
                                          &&  st_ag_icc;
assign st_ag_tlbi_inst                  = st_ag_icc_inst
                                          &&  (st_ag_inst_type[1:0]  ==  2'b00);
assign st_ag_tlbi_all_inst              = st_ag_tlbi_inst
                                          &&  (st_ag_inst_mode[1:0]  ==  2'b00);
assign st_ag_dcache_inst                = st_ag_icc_inst
                                          &&  (st_ag_inst_type[1:0]  ==  2'b10);
assign st_ag_dcache_all_inst            = st_ag_dcache_inst
                                          &&  (st_ag_inst_mode[1:0]  ==  2'b00);
assign st_ag_dcache_1line_inst          = st_ag_dcache_inst
                                          &&  (st_ag_inst_mode[1:0]  !=  2'b00);

assign st_ag_dcache_pa_sw_inst          = st_ag_dcache_inst
                                          &&  st_ag_inst_mode[1];

assign st_ag_dcache_user_allow_inst     = st_ag_dcache_inst   //dcache.cva/dcache.civa/dcache.cval1
                                          &&  !(st_ag_inst_size[1:0]  ==  2'b10)
                                          &&  (st_ag_inst_mode[1:0]  ==  2'b01);
assign st_ag_icache_inst                = st_ag_icc
                                          &&  !st_ag_atomic
                                          &&  (st_ag_inst_type[1:0]  ==  2'b01);
assign st_ag_icache_all_inst            = st_ag_icache_inst
                                          &&  (st_ag_inst_mode[1:0]  ==  2'b00);
assign st_ag_icache_inv_va_inst         = st_ag_icache_inst
                                          &&  (st_ag_inst_mode[1:0]  ==  2'b01);
assign st_ag_l2cache_inst               = st_ag_icc
                                          &&  !st_ag_atomic
                                          &&  (st_ag_inst_type[1:0]  ==  2'b11);
// assign st_ag_fence_i_icache_all_inst    = st_ag_split
//                                           &&  st_ag_icache_inst
//                                           &&  (st_ag_inst_mode[1:0]  ==  2'b00);
assign st_ag_fence_i_icache_all_inst    = st_ag_icache_inst
                                          &&  (st_ag_inst_mode[1:0]  ==  2'b00);

assign st_ag_st_inst                    = !st_ag_icc
                                          && !st_ag_atomic
                                          &&  !st_ag_sync_fence
                                          &&  (st_ag_inst_type[1:0]  ==  2'b00);
assign st_ag_statomic_inst              = st_ag_inst_vld
                                          &&  st_ag_atomic;

//==========================================================
//            Generate unalign, bytes_vld
//==========================================================
//---------------inst access size---------------
// access size is used to select bytes_vld and boundary judge
// &CombBeg; @379
always @( st_ag_inst_size[1:0])
begin
case(st_ag_inst_size[1:0])
  BYTE: st_ag_access_size_ori[3:0] = 4'b0000;
  HALF: st_ag_access_size_ori[3:0] = 4'b0001;
  WORD: st_ag_access_size_ori[3:0] = 4'b0011;
  DWORD:st_ag_access_size_ori[3:0] = 4'b0111;
  default:st_ag_access_size_ori[3:0] = 4'b0;
endcase
// &CombEnd; @387
end
assign st_ag_inst_vls         = 1'b0;
assign st_ag_access_size[3:0] = st_ag_access_size_ori[3:0]; 

// access_size pipedown to dc, used for biu req_size(strong order)
// &CombBeg; @397
always @( st_ag_access_size[3:0])
begin
case(st_ag_access_size[3:0])
  4'b0000: st_ag_dc_access_size[2:0] = 3'b000;  //byte
  4'b0001: st_ag_dc_access_size[2:0] = 3'b001;  //half
  4'b0011: st_ag_dc_access_size[2:0] = 3'b010;  //word
  4'b0111: st_ag_dc_access_size[2:0] = 3'b011;  //dword
  4'b1111: st_ag_dc_access_size[2:0] = 3'b100;  //qword
  default: st_ag_dc_access_size[2:0] = 3'b0;
endcase
// &CombEnd; @406
end
//----------------generate uanlign--------------------------
//-----------unalign--------------------
// &CombBeg; @409
always @( st_ag_inst_size[1:0]
       or st_ag_va_ori[2:0])
begin
casez({st_ag_inst_size[1:0],st_ag_va_ori[2:0]})
  {BYTE,3'b???}:st_ag_align = 1'b1;
  {HALF,3'b??0}:st_ag_align = 1'b1;
  {WORD,3'b?00}:st_ag_align = 1'b1;
  {DWORD,3'b000}:st_ag_align = 1'b1;//NOTE:in risc-v isa, double inst misalign is set
                                    //     when double not align,
                                    //     but in csky, double misalign is set
                                    //     when word not align
  default:st_ag_align  = 1'b0;
endcase
// &CombEnd; @420
end
assign st_ag_unalign = !st_ag_align;

// for strong order,only support access size aligned address
//&CombBeg;
//casez({st_ag_access_size[3:0],st_ag_va_ori[3:0]})
//  {4'b0000,4'b????}:st_ag_align_so = 1'b1;       //byte
//  {4'b0001,4'b???0}:st_ag_align_so = 1'b1;       //half
//  {4'b0011,4'b??00}:st_ag_align_so = 1'b1;       //word
//  {4'b0111,4'b?000}:st_ag_align_so = 1'b1;       //dword
//  {4'b1111,4'b0000}:st_ag_align_so = 1'b1;       //qword
//  default:st_ag_align_so  = 1'b0;
//endcase
//&CombEnd;
assign st_ag_unalign_so = !st_ag_align;

//---------------boundary---------------
assign st_ag_va_add_access_size[4:0] = {1'b0,st_ag_va_ori[3:0]} + {1'b0,st_ag_access_size[3:0]};
assign st_ag_boundary_unmask = st_ag_va_add_access_size[4];

// &Force("output", "st_ag_boundary"); @440
assign st_ag_boundary = (st_ag_boundary_unmask
                            ||  st_ag_secd)
                        &&  st_ag_st_inst;

//----------------generate bytes_vld------------------------
//-----------in le/bev2-----------------
//the 2nd half boundary inst will +128, so va[3:0] of 2nd inst will not change
// &CombBeg; @448
always @( st_ag_va_ori[3:0])
begin
case(st_ag_va_ori[3:0])
  4'b0000:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hffff;
  4'b0001:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfffe;
  4'b0010:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfffc;
  4'b0011:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfff8;
  4'b0100:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfff0;
  4'b0101:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hffe0;
  4'b0110:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hffc0;
  4'b0111:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hff80;
  4'b1000:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hff00;
  4'b1001:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfe00;
  4'b1010:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hfc00;
  4'b1011:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hf800;
  4'b1100:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hf000;
  4'b1101:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'he000;
  4'b1110:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'hc000;
  4'b1111:st_ag_le_bytes_vld_high_bits_full[15:0] = 16'h8000;
  default:st_ag_le_bytes_vld_high_bits_full[15:0] = {16{1'bx}};
endcase
// &CombEnd; @468
end

// &CombBeg; @470
always @( st_ag_va_add_access_size[3:0])
begin
case(st_ag_va_add_access_size[3:0])
  4'b0000:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0001;
  4'b0001:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0003;
  4'b0010:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0007;
  4'b0011:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h000f;
  4'b0100:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h001f;
  4'b0101:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h003f;
  4'b0110:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h007f;
  4'b0111:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h00ff;
  4'b1000:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h01ff;
  4'b1001:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h03ff;
  4'b1010:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h07ff;
  4'b1011:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h0fff;
  4'b1100:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h1fff;
  4'b1101:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h3fff;
  4'b1110:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'h7fff;
  4'b1111:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'hffff;
  default:st_ag_le_bytes_vld_low_bits_full[15:0] = 16'b0;
endcase
// &CombEnd; @490
end

assign st_ag_le_bytes_vld_cross[15:0]       = st_ag_le_bytes_vld_high_bits_full[15:0]
                                              & st_ag_le_bytes_vld_low_bits_full[15:0];

assign st_ag_le_bytes_vld_high_cross_bits[15:0] = st_ag_boundary_unmask
                                                  ? st_ag_le_bytes_vld_high_bits_full[15:0]
                                                  : st_ag_le_bytes_vld_cross[15:0];
//-----------select bytes_vld-----------
assign st_ag_bytes_vld_low_bits[15:0]   = st_ag_le_bytes_vld_low_bits_full[15:0];

assign st_ag_bytes_vld_high_cross_bits[15:0]  = st_ag_le_bytes_vld_high_cross_bits[15:0];

//used for st_dc_rot_sel when boundary split
//bytes_vld1 is the bytes_vld of lower addr when there is a first(smaller) boundary st inst,
//NOTE: it is different from ld pipe
//assign st_ag_bytes_vld1[15:0]   = st_ag_bytes_vld_high_cross_bits[15:0];

assign st_ag_st_bytes_vld[15:0] = st_ag_secd
                                  ? st_ag_bytes_vld_low_bits[15:0]
                                  : st_ag_bytes_vld_high_cross_bits[15:0];

assign st_ag_bytes_vld[15:0]    = st_ag_tlbi_inst
                                  ? 16'hffff
                                  : st_ag_st_bytes_vld[15:0];
//==========================================================
//        vector mask
//==========================================================
// &CombBeg; @523
// &CombEnd; @531
// &Force("output","st_ag_element_cnt"); @533
// &CombBeg; @540
// &CombEnd; @552
// &CombBeg; @557
// &CombEnd; @565
// &CombBeg; @650
// &CombEnd; @661
// &CombBeg; @665
// &CombEnd; @685
// &CombBeg; @694
// &CombEnd; @714
// &CombBeg; @731
// &CombEnd; @751
// &CombBeg; @753
// &CombEnd; @773
// &CombBeg; @775
// &CombEnd; @781
// &CombBeg; @783
// &CombEnd; @789
// &CombBeg; @796
// &CombEnd; @815
// &CombBeg; @818
// &CombEnd; @838
// &CombBeg; @846
// &CombEnd; @854
// &CombBeg; @858
// &CombEnd; @866
// &Force("output","st_ag_vsew"); @869
// &Force("output","st_ag_inst_vls"); @870
assign st_ag_dc_bytes_vld[15:0]  = st_ag_bytes_vld[15:0];
//assign st_ag_dc_bytes_vld1[15:0] = st_ag_bytes_vld1[15:0];
assign st_ag_dc_rot_sel[3:0]     = st_ag_tlbi_inst
                                   ? 4'h0
                                   : st_ag_va_ori[3:0];
//==========================================================
//        MMU interface
//==========================================================
//-----------mmu input--------------------------------------
assign lsu_mmu_va1_vld      = st_ag_mmu_req
                              &&  st_ag_inst_vld;
assign lsu_mmu_st_inst1     = st_ag_st;
assign lsu_mmu_va1[63:0]    = st_ag_base[63:0];
// &Force("output","lsu_mmu_abort1"); @894
assign lsu_mmu_abort1       = st_ag_cross_page_str_imme_stall_req
                              ||  st_ag_dcache_stall_req
                              ||  st_ag_expt_illegal_inst
                              ||  st_ag_expt_misalign_no_page
                              ||  rtu_yy_xx_flush;
assign lsu_mmu_id1[6:0]     = st_ag_iid[6:0];

//to avoid deadlock,stamo will not check tlb, use lm info instead
//for stamo timing
assign lsu_mmu_stamo_vld = st_ag_inst_vld
                           && st_ag_stamo_inst;

assign lsu_mmu_stamo_pa[`PA_WIDTH-13:0] = lm_addr_pa[`PA_WIDTH-13:0]; 
//-----------mmu output-------------------------------------
assign st_ag_pn[`PA_WIDTH-13:0] = mmu_lsu_pa1[`PA_WIDTH-13:0];
//0 means 4k
//1 means 2M
//2 means don't care
// &Force("output", "st_ag_page_so"); @913
assign st_ag_page_so        = st_ag_stamo_inst
                              ? lm_page_so
                              : mmu_lsu_so1 && mmu_lsu_pa1_vld;
// &Force("output","st_ag_page_ca"); @917
// &Force("output","st_ag_utlb_miss"); @918
assign st_ag_page_ca        = st_ag_stamo_inst
                              ? lm_page_ca
                              : mmu_lsu_ca1 && mmu_lsu_pa1_vld;
assign st_ag_page_wa        = st_ag_page_ca &&  cp0_lsu_wa;
assign st_ag_page_buf       = st_ag_stamo_inst
                              ? lm_page_buf
                              : mmu_lsu_buf1;
assign st_ag_page_sec       = st_ag_stamo_inst
                              ? lm_page_sec
                              : mmu_lsu_sec1;
assign st_ag_page_share     = st_ag_stamo_inst
                              ? lm_page_share
                              : mmu_lsu_sh1;

assign st_ag_utlb_miss      = !mmu_lsu_pa1_vld
                              &&  st_ag_mmu_req
                              &&  !st_ag_expt_illegal_inst;
assign st_ag_page_fault     = mmu_lsu_page_fault1;
//assign st_ag_access_fault   = mmu_lsu_access_fault1;

//==========================================================
//        Generate physical address
//==========================================================
assign st_ag_pa[`PA_WIDTH-1:0]    = {st_ag_pn[`PA_WIDTH-13:0],st_ag_va[11:0]};

assign st_ag_va_am[`PA_WIDTH-1:0] = (st_ag_sync_fence
                                        ||  st_ag_tlbi_all_inst
                                        ||  st_ag_dcache_all_inst
                                        ||  st_ag_icache_all_inst
                                        ||  st_ag_l2cache_inst)
                                    ? {`PA_WIDTH{1'b0}}
                                    : st_ag_va[`PA_WIDTH-1:0];

//mmu request use pa
assign st_ag_addr[`PA_WIDTH-1:12] = st_ag_mmu_req || st_ag_stamo_inst
                                    ? st_ag_pn[`PA_WIDTH-13:0] 
                                    : st_ag_va_am[`PA_WIDTH-1:12];

assign st_ag_addr[11:0]           = st_ag_tlbi_inst
                                    ? 12'b0
                                    : st_ag_va_am[11:0];

//==========================================================
//        Generage dcache request information
//==========================================================
assign ag_dcache_arb_st_gateclk_en  = st_ag_inst_vld
                                      &&  cp0_lsu_dcache_en
                                      &&  (st_ag_st_inst
                                          ||  st_ag_statomic_inst
                                          ||  st_ag_dcache_1line_inst);
//for timing, delete expt_vld
assign ag_dcache_arb_st_req = st_ag_inst_vld
                              &&  cp0_lsu_dcache_en
                              &&  (st_ag_st_inst
                                  ||  st_ag_statomic_inst
                                  ||  st_ag_dcache_1line_inst)
//                              &&  !st_ag_expt_vld
//                              &&  !st_ag_cross_page_str_imme_stall_arb

                              &&  (st_ag_mmu_req
                                  ||  st_ag_stamo_inst
                                  ||  st_ag_dcache_pa_sw_inst);
//                              &&  (st_ag_page_ca
//                                      &&  mmu_lsu_pa1_vld
//                                  ||  st_ag_dcache_pa_sw_inst);

//-----------tag array--------------------------------------
assign ag_dcache_arb_st_tag_gateclk_en  = ag_dcache_arb_st_gateclk_en;
assign ag_dcache_arb_st_tag_req         = ag_dcache_arb_st_req;
assign ag_dcache_arb_st_tag_idx[8:0]    = st_ag_pa[14:6];
//assign ag_dcache_arb_st_tag_din[35:0] = 36'b0;
//assign ag_dcache_arb_st_tag_wen[1:0]  = 2'b0;

//-----------dirty array------------------------------------
assign ag_dcache_arb_st_dirty_gateclk_en= ag_dcache_arb_st_gateclk_en;
assign ag_dcache_arb_st_dirty_req       = ag_dcache_arb_st_req;
assign ag_dcache_arb_st_dirty_idx[8:0]  = st_ag_pa[14:6];
//assign ag_dcache_arb_st_dirty_din[6:0]  = 7'b0;
//assign ag_dcache_arb_st_dirty_wen[6:0]  = 7'b0;

//==========================================================
//        Generage exception signal
//==========================================================
//for tee
assign tcore_vld = 1'b1;

// for debug
wire user_tlbi_inst_vld;
assign user_tlbi_inst_vld = 1'b1;
//----------illegal_inst----------------
assign st_ag_prvlg_obey     = (cp0_yy_priv_mode[1:0]  ==  2'b11)
                                  &&  (st_ag_dcache_inst
                                          &&  !(cp0_lsu_ucme
                                                &&  st_ag_dcache_user_allow_inst)
                                      ||  st_ag_icache_inst
                                          &&  !(cp0_lsu_ucme
                                                &&  st_ag_icache_inv_va_inst)
                                          &&  !st_ag_fence_i_icache_all_inst
                                      ||  st_ag_tlbi_inst && !user_tlbi_inst_vld 
                                      ||  st_ag_l2cache_inst)
                              ||  (cp0_yy_priv_mode[1:0]  ==  2'b01)
                                  &&  st_ag_tlbi_inst
                                  && (st_ag_inst_size[1:0] == 2'b00)
                                  &&  cp0_lsu_tvm
                              ||  (cp0_yy_priv_mode[1:0]  ==  2'b01)
                                  && (cp0_yy_virtual_mode || cp0_lsu_tvm)
                                  &&  st_ag_tlbi_inst
                                  && (st_ag_inst_size[1:0] == 2'b01)
                              ||  !tcore_vld
                                  && st_ag_l2cache_inst;

// &Force("output","st_ag_expt_illegal_inst"); @1031
assign st_ag_expt_illegal_inst  = st_ag_prvlg_obey
                                  && !rtu_yy_xx_dbgon;

// &CombBeg; @1035
always @( st_ag_va_ori[63:0]
       or st_ag_inst_code[31:0]
       or st_ag_expt_illegal_inst)
begin
if(st_ag_expt_illegal_inst)
  st_ag_mt_value[PC_WIDTH-1:0] = {{PC_WIDTH-32{1'b0}},st_ag_inst_code[31:0]};
else
  st_ag_mt_value[PC_WIDTH-1:0] = st_ag_va_ori[PC_WIDTH-1:0];  //for misalign
// &CombEnd; @1040
end

//if the 1st boundary instruction is weak order and 2nd is strong order, then treat
//this instruction as weak order
// &Force("output", "st_ag_expt_misalign_no_page"); @1044
assign st_ag_expt_misalign_no_page  = st_ag_unalign
                                      &&  (st_ag_st_inst
                                              &&  !cp0_lsu_mm
                                          ||  st_ag_inst_vls
                                          ||  st_ag_atomic);

// &Force("output","st_ag_expt_misalign_with_page"); @1051
assign st_ag_expt_misalign_with_page  = st_ag_unalign_so
                                        &&  st_ag_page_so
                                        &&  mmu_lsu_pa1_vld
                                        &&  st_ag_st_inst;

// &Force("output","st_ag_expt_page_fault"); @1057
assign st_ag_expt_page_fault          = st_ag_mmu_req
                                        &&  mmu_lsu_pa1_vld
                                        &&  st_ag_page_fault;

// &Force("output","st_ag_expt_stamo_not_ca"); @1062
assign st_ag_expt_stamo_not_ca    = mmu_lsu_pa1_vld
                                    &&  st_ag_stamo_inst
                                    &&  !st_ag_page_ca;

// //&Force("output","st_ag_expt_access_fault"); @1067
//assign st_ag_expt_access_fault        = mmu_lsu_pa1_vld
//                                        &&  st_ag_access_fault;

//for vector strong order
// &Force("output", "st_ag_expt_access_fault_with_page"); @1072
assign st_ag_expt_access_fault_with_page = mmu_lsu_pa1_vld
                                           &&  st_ag_page_so
                                           &&  st_ag_st_inst
                                           &&  st_ag_inst_vls;
                                      
assign st_ag_expt_vld       = st_ag_expt_misalign_no_page
                              ||  st_ag_expt_misalign_with_page
                              ||  st_ag_expt_access_fault_with_page
                              ||  st_ag_expt_illegal_inst
                              ||  st_ag_bc_expt_misalign
                              ||  st_ag_bc_expt_check_fail
                              ||  st_ag_expt_page_fault;


//==========================================================
//        Generage Bound Check Instruction Signal
//==========================================================
assign st_ag_inst_bc_src0[63:0] = st_ag_base[63:0];

assign st_ag_inst_bc_src1[63:0] = st_ag_offset[63:0];

assign st_ag_bc_gt = st_ag_inst_bc_src0[63:0] > st_ag_inst_bc_src1[63:0];

assign st_ag_bc_le = !st_ag_bc_gt;

assign st_ag_inst_bc_gt = (st_ag_inst_code[31:15] == 17'b00111000011101100) || //fstgt.s
                          (st_ag_inst_code[31:15] == 17'b00111000011101101) || //fstgt.d
                          (st_ag_inst_code[31:15] == 17'b00111000011111000) || //stgt.b
                          (st_ag_inst_code[31:15] == 17'b00111000011111001) || //stgt.h
                          (st_ag_inst_code[31:15] == 17'b00111000011111010) || //stgt.w
                          (st_ag_inst_code[31:15] == 17'b00111000011111011);   //stgt.d

assign st_ag_inst_bc_le = (st_ag_inst_code[31:15] == 17'b00111000011101110) || //fstle.s
                          (st_ag_inst_code[31:15] == 17'b00111000011101111) || //fstle.d
                          (st_ag_inst_code[31:15] == 17'b00111000011111100) || //stle.b
                          (st_ag_inst_code[31:15] == 17'b00111000011111101) || //stle.h
                          (st_ag_inst_code[31:15] == 17'b00111000011111110) || //stle.w
                          (st_ag_inst_code[31:15] == 17'b00111000011111111);   //stle.d

assign st_ag_bc_expt_misalign = st_ag_inst_vld
                                && st_ag_unalign
                                && (st_ag_inst_bc_gt
                                    || st_ag_inst_bc_le
                                    );

assign st_ag_bc_expt_check_fail = st_ag_inst_vld
                                && !st_ag_unalign
                                && (st_ag_inst_bc_gt && st_ag_bc_le
                                    || st_ag_inst_bc_le && st_ag_bc_gt
                                    );

//==========================================================
//        Generage stall/restart signal
//==========================================================
//-----------restart----------------------------------------
//generate commit signal
assign st_ag_cmit_hit0  = {rtu_yy_xx_commit0,rtu_yy_xx_commit0_iid[6:0]}
                          ==  {1'b1,st_ag_iid[6:0]};
assign st_ag_cmit_hit1  = {rtu_yy_xx_commit1,rtu_yy_xx_commit1_iid[6:0]}
                          ==  {1'b1,st_ag_iid[6:0]};
assign st_ag_cmit_hit2  = {rtu_yy_xx_commit2,rtu_yy_xx_commit2_iid[6:0]}
                          ==  {1'b1,st_ag_iid[6:0]};

// //&Force("output","st_ag_cmit"); @1096
assign st_ag_cmit       = st_ag_cmit_hit0
                          ||  st_ag_cmit_hit1
                          ||  st_ag_cmit_hit2;

assign st_ag_atomic_no_cmit_restart_req = st_ag_inst_vld
                                          &&  st_ag_stamo_inst
                                          &&  !st_ag_cmit;

//==========================================================
//        Generage stall/restart signal
//==========================================================
//-----------stall------------------------------------------
//get the stall signal if virtual address cross 4k address
//for timing, if there is a carry adding last 12 bits, or there is '1' in high
//bits, it will stall
//---------------------cross 4k-----------------------------
assign st_ag_4k_sum_ori[12:0]   = {1'b0,st_ag_base[11:0]} 
                                  + {st_ag_offset[63],st_ag_offset_aftershift[11:0]};

assign st_ag_off_high_bits_all_0_ori  = !(|st_ag_offset_aftershift[63:12]);
assign st_ag_off_high_bits_all_1_ori  = &st_ag_offset_aftershift[63:12];
assign st_ag_off_high_bits_not_eq     = !st_ag_off_high_bits_all_0_ori
                                        &&  !st_ag_off_high_bits_all_1_ori;

assign st_ag_4k_sum_plus[12:0]   = {1'b0,st_ag_base[11:0]} 
                                  + st_ag_offset_shift_plus[12:0];


assign st_ag_4k_sum_12  = st_ag_va_plus_sel ? st_ag_4k_sum_plus[12]
                                            : st_ag_4k_sum_ori[12];

assign st_ag_cross_4k   = st_ag_4k_sum_12
                          ||  st_ag_off_high_bits_not_eq;

//only str will trigger secd stall, and will stall at the first split
assign st_ag_boundary_stall = st_ag_inst_str && st_ag_secd;
assign st_ag_str_imme_stall  = st_ag_boundary_stall  &&  !st_ag_already_cross_page_str_imme;

assign st_ag_dcache_stall_unmask      = !dcache_arb_ag_st_sel;
//because cross 4k to MMU, there doesn't exist cross_4k stall
assign st_ag_cross_page_str_imme_stall_req  = (st_ag_cross_4k
                                                ||  st_ag_str_imme_stall)
                                            &&  !st_ag_expt_misalign_no_page
                                            &&  st_ag_inst_vld
                                            &&  st_ag_mmu_req;

assign st_ag_dcache_stall_req   = st_ag_dcache_stall_unmask
                                  &&  st_ag_inst_vld;
assign st_ag_mmu_stall_req      = mmu_lsu_stall1;

//-----------arbiter----------------------------------------
//prioritize:
//  1. cross_page_str_imme_stall    : cross_4k
//  2. dcache_stall    : cache
//  other restart flop to dc stage
//  other_restart  : utlb_miss, tlb_busy

assign st_ag_cross_page_str_imme_stall_arb  = !st_ag_atomic_no_cmit_restart_req
                                              && st_ag_cross_page_str_imme_stall_req
                                              && !st_ag_stall_mask;

assign st_ag_atomic_no_cmit_restart_arb = st_ag_atomic_no_cmit_restart_req;
//-----------generate total siangl--------------------------
// &Force("output","st_ag_stall_ori"); @1160
assign st_ag_stall_ori            = (st_ag_cross_page_str_imme_stall_req
                                     ||  st_ag_dcache_stall_req
                                     ||  st_ag_mmu_stall_req)
                                    && !st_ag_atomic_no_cmit_restart_req;

assign st_ag_stall_vld            = st_ag_stall_ori
                                    && !st_ag_stall_mask;

assign st_ag_stall_restart        = st_ag_cross_page_str_imme_stall_req
                                    || st_ag_dcache_stall_req
                                    || st_ag_mmu_stall_req
                                    || st_ag_atomic_no_cmit_restart_req;

//for performance,when ag stall,let oldest inst go

// &Instance("ct_rtu_compare_iid","x_lsu_rf_compare_st_ag_iid"); @1176
ct_rtu_compare_iid  x_lsu_rf_compare_st_ag_iid (
  .x_iid0                    (idu_lsu_rf_pipe4_iid[6:0]),
  .x_iid0_older              (rf_iid_older_than_st_ag  ),
  .x_iid1                    (st_ag_iid[6:0]           )
);

// &Connect( .x_iid0         (idu_lsu_rf_pipe4_iid[6:0]), @1177
//           .x_iid1         (st_ag_iid[6:0]           ), @1178
//           .x_iid0_older   (rf_iid_older_than_st_ag )); @1179

assign st_ag_stall_mask = idu_lsu_rf_pipe4_sel
                          && rf_iid_older_than_st_ag;

assign st_ag_stall_restart_entry[LSIQ_ENTRY-1:0] = st_ag_stall_mask
                                                   ? st_ag_lsid[LSIQ_ENTRY-1:0]
                                                   : idu_lsu_rf_pipe4_lch_entry[LSIQ_ENTRY-1:0];

//==========================================================
//        Generate restart/lsiq signal
//==========================================================
//-----------lsiq signal----------------
assign st_ag_mask_lsid[LSIQ_ENTRY-1:0]    = {LSIQ_ENTRY{st_ag_inst_vld}}
                                            &  st_ag_lsid[LSIQ_ENTRY-1:0];

assign lsu_idu_st_ag_wait_old_gateclk_en = st_ag_atomic_no_cmit_restart_arb;
assign lsu_idu_st_ag_wait_old[LSIQ_ENTRY-1:0]  = st_ag_mask_lsid[LSIQ_ENTRY-1:0]
                                                 & {LSIQ_ENTRY{st_ag_atomic_no_cmit_restart_arb}};

//==========================================================
//        Generage to DC stage signal
//==========================================================
// &Force("output", "st_ag_dc_inst_vld"); @1202
assign st_ag_dc_inst_vld      = st_ag_inst_vld
                                &&  !st_ag_stall_restart;

assign st_ag_dc_mmu_req       = st_ag_mmu_req
                                &&  !lsu_mmu_abort1;

assign st_ag_dc_page_share    = st_ag_inst_share
                                ||  st_ag_page_share
                                    && (st_ag_mmu_req || st_ag_stamo_inst);

//this logic may be redundant
assign st_ag_dc_addr0[`PA_WIDTH-1:0] = dcache_arb_st_ag_borrow_addr_vld
                                      ? dcache_arb_st_ag_addr[`PA_WIDTH-1:0]
                                      : st_ag_addr[`PA_WIDTH-1:0];

//==========================================================
//        interface to hpcp
//==========================================================
assign lsu_hpcp_st_cross_4k_stall  = st_ag_inst_vld
                                     &&  st_ag_already_cross_page_str_imme
                                     &&  !st_ag_stall_vld
                                     &&  !st_ag_utlb_miss
                                     &&  !st_ag_already_da;
assign lsu_hpcp_st_other_stall     = st_ag_inst_vld
                                     &&  !st_ag_cross_4k
                                     &&  st_ag_stall_vld
                                     &&  !st_ag_utlb_miss
                                     &&  !st_ag_already_da;

// &ModuleEnd; @1234
endmodule


