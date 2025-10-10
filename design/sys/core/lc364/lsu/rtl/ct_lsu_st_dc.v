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

// &ModuleBeg; @25
module ct_lsu_st_dc (
  // &Ports, @26
  input    wire          cp0_lsu_dcache_en,
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_lsu_l2_st_pref_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_st_clk,
  input    wire          dcache_arb_st_dc_borrow_icc,
  input    wire          dcache_arb_st_dc_borrow_snq,
  input    wire  [5 :0]  dcache_arb_st_dc_borrow_snq_id,
  input    wire          dcache_arb_st_dc_borrow_vld,
  input    wire          dcache_arb_st_dc_borrow_vld_gate,
  input    wire          dcache_arb_st_dc_dcache_replace,
  input    wire          dcache_arb_st_dc_dcache_sw,
  input    wire          dcache_dirty_gwen,
  input    wire  [8 :0]  dcache_idx,
  input    wire  [6 :0]  dcache_lsu_st_dirty_dout,
  input    wire  [51:0]  dcache_lsu_st_tag_dout,
  input    wire          forever_cpuclk,
  input    wire  [39:0]  had_yy_xx_bkpta_base,
  input    wire  [7 :0]  had_yy_xx_bkpta_mask,
  input    wire          had_yy_xx_bkpta_rc,
  input    wire  [39:0]  had_yy_xx_bkptb_base,
  input    wire  [7 :0]  had_yy_xx_bkptb_mask,
  input    wire          had_yy_xx_bkptb_rc,
  input    wire          lq_st_dc_spec_fail,
  input    wire          mmu_lsu_mmu_en,
  input    wire          mmu_lsu_tlb_busy,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [6 :0]  rtu_lsu_commit0_iid_updt_val,
  input    wire  [6 :0]  rtu_lsu_commit1_iid_updt_val,
  input    wire  [6 :0]  rtu_lsu_commit2_iid_updt_val,
  input    wire          rtu_yy_xx_flush,
  input    wire  [3 :0]  sd_rf_ex1_sdid,
  input    wire          sq_st_dc_full,
  input    wire          sq_st_dc_inst_hit,
  input    wire          st_ag_already_da,
  input    wire          st_ag_atomic,
  input    wire  [63:0]  st_ag_atomic_src1_data,
  input    wire  [15:0]  st_ag_atomic_func,
  input    wire          st_ag_boundary,
  input    wire  [2 :0]  st_ag_dc_access_size,
  input    wire  [39:0]  st_ag_dc_addr0,
  input    wire  [15:0]  st_ag_dc_bytes_vld,
  input    wire          st_ag_dc_inst_vld,
  input    wire          st_ag_dc_mmu_req,
  input    wire          st_ag_dc_page_share,
  input    wire  [3 :0]  st_ag_dc_rot_sel,
  input    wire          st_ag_expt_access_fault_with_page,
  input    wire          st_ag_expt_illegal_inst,
  input    wire          st_ag_expt_misalign_no_page,
  input    wire          st_ag_expt_misalign_with_page,
  input    wire          st_ag_expt_page_fault,
  input    wire          st_ag_expt_stamo_not_ca,
  input    wire          st_ag_bc_expt_misalign,
  input    wire          st_ag_bc_expt_check_fail,
  input    wire          st_ag_expt_vld,
  input    wire  [3 :0]  st_ag_fence_mode,
  input    wire          st_ag_icc,
  input    wire  [6 :0]  st_ag_iid,
  input    wire          st_ag_inst_flush,
  input    wire  [1 :0]  st_ag_inst_mode,
  input    wire  [1 :0]  st_ag_inst_type,
  input    wire          st_ag_inst_vld,
  input    wire          st_ag_lsfifo,
  input    wire  [11:0]  st_ag_lsid,
  input    wire          st_ag_lsiq_bkpta_data,
  input    wire          st_ag_lsiq_bkptb_data,
  input    wire          st_ag_lsiq_spec_fail,
  input    wire  [63:0]  st_ag_mt_value,
  input    wire          st_ag_no_spec,
  input    wire          st_ag_old,
  input    wire          st_ag_page_buf,
  input    wire          st_ag_page_ca,
  input    wire          st_ag_page_sec,
  input    wire          st_ag_page_so,
  input    wire          st_ag_page_wa,
  input    wire  [14:0]  st_ag_pc,
  input    wire  [11:0]  st_ag_sdid_oh,
  input    wire          st_ag_secd,
  input    wire          st_ag_split,
  input    wire          st_ag_st,
  input    wire          st_ag_staddr,
  input    wire          st_ag_sync_fence,
  input    wire          st_ag_utlb_miss,
  input    wire  [27:0]  st_ag_vpn,
  input    wire  [23:0]  st_ag_vpn_high,
  output   wire  [11:0]  lsu_idu_dc_sdiq_entry,
  output   wire          lsu_idu_dc_staddr1_vld,
  output   wire          lsu_idu_dc_staddr_unalign,
  output   wire          lsu_idu_dc_staddr_vld,
  output   wire  [27:0]  lsu_mmu_vabuf1,
  output   reg   [39:0]  st_dc_addr0,
  output   reg           st_dc_already_da,
  output   reg           st_dc_atomic,
  output   reg   [63:0]  st_dc_atomic_src1_data,
  output   reg   [15:0]  st_dc_atomic_func,
  output   wire          st_dc_bkpta_data,
  output   wire          st_dc_bkptb_data,
  output   reg           st_dc_borrow_dcache_replace,
  output   reg           st_dc_borrow_dcache_sw,
  output   reg           st_dc_borrow_icc,
  output   reg           st_dc_borrow_snq,
  output   reg   [5 :0]  st_dc_borrow_snq_id,
  output   reg           st_dc_borrow_vld,
  output   reg           st_dc_boundary,
  output   wire          st_dc_boundary_first,
  output   reg   [15:0]  st_dc_bytes_vld,
  output   wire          st_dc_chk_st_inst_vld,
  output   wire          st_dc_chk_statomic_inst_vld,
  output   wire          st_dc_cmit0_iid_crt_hit,
  output   wire          st_dc_cmit1_iid_crt_hit,
  output   wire          st_dc_cmit2_iid_crt_hit,
  output   wire  [6 :0]  st_dc_da_dcache_dirty_array,
  output   wire  [51:0]  st_dc_da_dcache_tag_array,
  output   wire          st_dc_da_expt_vld_gate_en,
  output   wire          st_dc_da_inst_vld,
  output   wire          st_dc_da_page_buf,
  output   wire          st_dc_da_page_ca,
  output   wire          st_dc_da_page_sec,
  output   wire          st_dc_da_page_share,
  output   wire          st_dc_da_page_so,
  output   wire          st_dc_da_page_wa,
  output   wire          st_dc_da_tag0_hit,
  output   wire          st_dc_da_tag1_hit,
  output   wire          st_dc_dcwp_hit_idx,
  output   wire          st_dc_expt_access_fault_extra,
  output   wire          st_dc_expt_access_fault_mask,
  output   reg   [14:0]  st_dc_expt_vec,
  output   reg           st_dc_expt_vld_except_access_err,
  output   reg   [3 :0]  st_dc_fence_mode,
  output   wire          st_dc_get_dcache_tag_dirty,
  output   reg           st_dc_icc,
  output   wire  [11:0]  st_dc_idu_sq_full,
  output   wire  [11:0]  st_dc_idu_tlb_busy,
  output   reg   [6 :0]  st_dc_iid,
  output   wire  [11:0]  st_dc_imme_wakeup,
  output   reg           st_dc_inst_flush,
  output   reg   [1 :0]  st_dc_inst_mode,
  output   reg   [2 :0]  st_dc_inst_size,
  output   reg   [1 :0]  st_dc_inst_type,
  output   reg           st_dc_inst_vld,
  output   reg   [11:0]  st_dc_lsid,
  output   reg           st_dc_mmu_req,
  output   reg   [63:0]  st_dc_mt_value,
  output   reg           st_dc_no_spec,
  output   reg           st_dc_old,
  output   reg   [14:0]  st_dc_pc,
  output   wire          st_dc_pf_inst,
  output   wire  [39:0]  st_dc_pfu_va,
  output   wire  [7 :0]  st_dc_rot_sel_rev,
  output   wire  [3 :0]  st_dc_sdid,
  output   wire          st_dc_sdid_hit,
  output   reg           st_dc_secd,
  output   wire          st_dc_spec_fail,
  output   reg           st_dc_split,
  output   wire          st_dc_sq_create_dp_vld,
  output   wire          st_dc_sq_create_gateclk_en,
  output   wire          st_dc_sq_create_vld,
  output   wire          st_dc_sq_data_vld,
  output   wire          st_dc_sq_full_gateclk_en,
  output   reg           st_dc_st,
  output   reg           st_dc_sync_fence,
  output   wire          st_dc_tlb_busy_gateclk_en,
  output   wire          st_dc_vector_nop,
  output   wire          st_dc_wo_st_inst
); 



// &Regs; @27
reg     [7 :0]  st_dc_data_rot_sel;               
reg             st_dc_expt_access_fault_with_page; 
reg             st_dc_expt_illegal_inst;          
reg             st_dc_expt_misalign_no_page;      
reg             st_dc_bc_expt_misalign;
reg             st_dc_bc_expt_check_fail;
reg             st_dc_expt_misalign_with_page;    
reg             st_dc_expt_page_fault;            
reg             st_dc_expt_stamo_not_ca;          
reg             st_dc_lsfifo;                     
reg             st_dc_lsiq_bkpta_data;            
reg             st_dc_lsiq_bkptb_data;            
reg             st_dc_lsiq_spec_fail;             
reg     [63:0]  st_dc_mt_value_ori;               
reg             st_dc_page_buf;                   
reg             st_dc_page_ca;                    
reg             st_dc_page_sec;                   
reg             st_dc_page_share;                 
reg             st_dc_page_so;                    
reg             st_dc_page_wa;                    
reg     [3 :0]  st_dc_rot_sel;                    
reg     [11:0]  st_dc_sdid_oh;                    
reg             st_dc_staddr;                     
reg             st_dc_tlb_busy;                   
reg             st_dc_utlb_miss;                  
reg     [27:0]  st_dc_vpn;                        
reg     [24:0]  st_dc_vpn_high;                        

// &Wires; @28
wire    [38:0]  st_dc_bkpta_addr;                 
wire            st_dc_bkpta_trap;                 
wire    [38:0]  st_dc_bkptb_addr;                 
wire            st_dc_bkptb_trap;                 
wire            st_dc_borrow_clk;                 
wire            st_dc_borrow_clk_en;              
wire            st_dc_clk;                        
wire            st_dc_clk_en;                     
wire            st_dc_dcache_1line_inst;          
wire            st_dc_dcache_all_inst;            
wire            st_dc_dcache_inst;                
wire            st_dc_dcache_pa_sw_inst;          
wire            st_dc_dcache_pa_sw_page_ca;       
wire            st_dc_default_page;               
wire            st_dc_expt_access_fault_short;    
wire            st_dc_expt_illegal_inst_clk;      
wire            st_dc_expt_illegal_inst_clk_en;   
wire            st_dc_fence_inst;                 
wire    [39:0]  st_dc_had_bkpta_addr;             
wire    [39:0]  st_dc_had_bkptb_addr;             
wire            st_dc_icache_all_inst;            
wire            st_dc_icache_inst;                
wire            st_dc_icc_inst;                   
wire            st_dc_imme_restart_vld;           
wire            st_dc_inst_clk;                   
wire            st_dc_inst_clk_en;                
wire            st_dc_l2cache_inst;               
wire    [11:0]  st_dc_mask_lsid;                  
wire    [7 :0]  st_dc_pfu_va_11to4;               
wire            st_dc_pipe_bkpta_data;            
wire            st_dc_pipe_bkptb_data;            
wire            st_dc_restart_vld;                
wire            st_dc_sq_full_vld;                
wire            st_dc_st_inst;                    
wire            st_dc_sync_inst;                  
wire            st_dc_tlb_busy_restart_vld;       
wire            st_dc_tlbi_inst;                  
wire            st_dc_utlb_miss_vld;              
wire    [63:0]  st_dc_va;                         


parameter BYTE        = 3'b000,
          HALF        = 3'b001,
          WORD        = 3'b010,
          DWORD       = 3'b011;

parameter LSIQ_ENTRY  = 12,
          SNQ_ENTRY   = 6;
parameter PC_LEN      = 15;
parameter PC_WIDTH    = 64;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign st_dc_clk_en = st_ag_inst_vld
                      ||  dcache_arb_st_dc_borrow_vld_gate;
// &Instance("gated_clk_cell", "x_lsu_st_dc_gated_clk"); @44
gated_clk_cell  x_lsu_st_dc_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_dc_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (st_dc_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @45
//          .external_en   (1'b0               ), @46
//          .global_en     (1'b1               ), @47
//          .module_en     (cp0_lsu_icg_en     ), @48
//          .local_en      (st_dc_clk_en       ), @49
//          .clk_out       (st_dc_clk          )); @50

assign st_dc_inst_clk_en = st_ag_inst_vld;
// &Instance("gated_clk_cell", "x_lsu_st_dc_inst_gated_clk"); @53
gated_clk_cell  x_lsu_st_dc_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_dc_inst_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (st_dc_inst_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @54
//          .external_en   (1'b0               ), @55
//          .global_en     (cp0_yy_clk_en      ), @56
//          .module_en     (cp0_lsu_icg_en     ), @57
//          .local_en      (st_dc_inst_clk_en  ), @58
//          .clk_out       (st_dc_inst_clk     )); @59

//-----------------------borrow clk-------------------------
assign st_dc_borrow_clk_en = dcache_arb_st_dc_borrow_vld_gate;
// &Instance("gated_clk_cell", "x_lsu_st_dc_borrow_gated_clk"); @63
gated_clk_cell  x_lsu_st_dc_borrow_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (st_dc_borrow_clk   ),
  .external_en         (1'b0               ),
  .global_en           (1'b1               ),
  .local_en            (st_dc_borrow_clk_en),
  .module_en           (cp0_lsu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in        (forever_cpuclk     ), @64
//          .external_en   (1'b0               ), @65
//          .global_en     (1'b1               ), @66
//          .module_en     (cp0_lsu_icg_en     ), @67
//          .local_en      (st_dc_borrow_clk_en), @68
//          .clk_out       (st_dc_borrow_clk   )); @69

//-----------------------expt clk---------------------------
//for saving register,misalign and illegal have been selected in ag stage
assign st_dc_expt_illegal_inst_clk_en = st_ag_inst_vld
                                        &&  (st_ag_expt_illegal_inst
                                             || st_ag_expt_misalign_no_page);
// &Instance("gated_clk_cell", "x_lsu_st_dc_expt_illegal_inst_gated_clk"); @76
gated_clk_cell  x_lsu_st_dc_expt_illegal_inst_gated_clk (
  .clk_in                         (forever_cpuclk                ),
  .clk_out                        (st_dc_expt_illegal_inst_clk   ),
  .external_en                    (1'b0                          ),
  .global_en                      (1'b1                          ),
  .local_en                       (st_dc_expt_illegal_inst_clk_en),
  .module_en                      (cp0_lsu_icg_en                ),
  .pad_yy_icg_scan_en             (pad_yy_icg_scan_en            )
);

// &Connect(.clk_in        (forever_cpuclk     ), @77
//          .external_en   (1'b0               ), @78
//          .global_en     (1'b1               ), @79
//          .module_en     (cp0_lsu_icg_en     ), @80
//          .local_en      (st_dc_expt_illegal_inst_clk_en), @81
//          .clk_out       (st_dc_expt_illegal_inst_clk)); @82

//==========================================================
//                 Pipeline Register
//==========================================================
//------------------control part----------------------------
//+----------+------------+
//| inst_vld | borrow_vld |
//+----------+------------+
//inst vld is used for sq_entry pop sel signal
// &Force("output","st_dc_inst_vld"); @92
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_dc_inst_vld        <=  1'b0;
  else if(rtu_yy_xx_flush)
    st_dc_inst_vld        <=  1'b0;
  else if(st_ag_dc_inst_vld)
    st_dc_inst_vld        <=  1'b1;
  else
    st_dc_inst_vld        <=  1'b0;
end

// &Force("output","st_dc_borrow_vld"); @105
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_dc_borrow_vld      <=  1'b0;
  else if(dcache_arb_st_dc_borrow_vld)
    st_dc_borrow_vld      <=  1'b1;
  else
    st_dc_borrow_vld      <=  1'b0;
end

//------------------expt part-------------------------------
//+--------------+-------+----------+--------+------+------+---------+-----+
//| illegal_inst | tmiss | misalign | tfatal | tmod | deny | rd_tinv | vpn |
//+--------------+-------+----------+--------+------+------+---------+-----+
// &Force("output","st_dc_mmu_req"); @120
always @(posedge st_dc_inst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_dc_mmu_req                 <=  1'b0;
    st_dc_expt_illegal_inst       <=  1'b0;
    st_dc_expt_misalign_no_page   <=  1'b0;
    st_dc_bc_expt_misalign        <=  1'b0;
    st_dc_bc_expt_check_fail      <=  1'b0;
    //st_dc_expt_access_fault       <=  1'b0;
    st_dc_expt_page_fault         <=  1'b0;
    st_dc_expt_misalign_with_page <=  1'b0;
    st_dc_expt_access_fault_with_page <=  1'b0;
    st_dc_expt_stamo_not_ca       <=  1'b0;
  end
  else if(st_ag_inst_vld)
  begin
    st_dc_mmu_req                 <=  st_ag_dc_mmu_req;
    st_dc_expt_illegal_inst       <=  st_ag_expt_illegal_inst;
    st_dc_expt_misalign_no_page   <=  st_ag_expt_misalign_no_page;
    st_dc_bc_expt_misalign        <=  st_ag_bc_expt_misalign;
    st_dc_bc_expt_check_fail      <=  st_ag_bc_expt_check_fail;
    //st_dc_expt_access_fault       <=  st_ag_expt_access_fault;
    st_dc_expt_page_fault         <=  st_ag_expt_page_fault;
    st_dc_expt_misalign_with_page <=  st_ag_expt_misalign_with_page;
    st_dc_expt_access_fault_with_page <=  st_ag_expt_access_fault_with_page;
    st_dc_expt_stamo_not_ca       <=  st_ag_expt_stamo_not_ca;
  end
end

always @(posedge st_dc_expt_illegal_inst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_dc_mt_value_ori[PC_WIDTH-1:0]   <= {PC_WIDTH{1'b0}};
  else if(st_ag_inst_vld  &&  (st_ag_expt_illegal_inst || st_ag_expt_misalign_no_page))
    st_dc_mt_value_ori[PC_WIDTH-1:0]   <= st_ag_mt_value[PC_WIDTH-1:0];
end

//------------------borrow part-----------------------------
//+-----+------+-----+
//| rcl | sndb | mmu |
//+-----+------+-----+
always @(posedge st_dc_borrow_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_dc_borrow_dcache_replace         <=  1'b0;
    st_dc_borrow_dcache_sw              <=  1'b0;
    st_dc_borrow_snq                    <=  1'b0;
    st_dc_borrow_icc                    <=  1'b0;
    st_dc_borrow_snq_id[SNQ_ENTRY-1:0]  <=  {SNQ_ENTRY{1'b0}};
  end
  else if(dcache_arb_st_dc_borrow_vld)
  begin
    st_dc_borrow_dcache_replace         <=  dcache_arb_st_dc_dcache_replace;
    st_dc_borrow_dcache_sw              <=  dcache_arb_st_dc_dcache_sw;
    st_dc_borrow_snq                    <=  dcache_arb_st_dc_borrow_snq;
    st_dc_borrow_icc                    <=  dcache_arb_st_dc_borrow_icc;
    st_dc_borrow_snq_id[SNQ_ENTRY-1:0]  <=  dcache_arb_st_dc_borrow_snq_id[SNQ_ENTRY-1:0];
  end
end

//------------------inst part----------------------------
//+----------+-----+----+-----------+-----------+-----------+
//| sync_fence | icc | ex | inst_type | inst_size | inst_mode |
//+----------+-----+----+-----------+-----------+-----------+
//+------+------------+----------+-------+-------+------------+
//| secd | already_da | spec_fail| bkpta | bkptb | inst_flush |
//+------+------------+----------+-------+-------+------------+
//+----+-----+------+-----+------------+------------+
//| ex | iid | lsid | old | bytes_vld0 | bytes_vld1 |
//+----+-----+------+-----+------------+------------+
//+--------+----------+-------+
//| deform | boundary | split |
//+--------+----------+-------+
//+----+----+----+-----+-----+-------+
//| so | ca | wa | buf | sec | share |
//+----+----+----+-----+-----+-------+
// &Force("output","st_dc_sync_fence"); @195
// &Force("output","st_dc_icc"); @196
// &Force("output","st_dc_inst_type"); @197
// &Force("output","st_dc_inst_size"); @198
// &Force("output","st_dc_inst_mode"); @199
// &Force("output","st_dc_secd"); @200
// &Force("output","st_dc_already_da"); @201
// &Force("output","st_dc_atomic"); @202
// &Force("output","st_dc_iid"); @203
// &Force("output","st_dc_lsid"); @204
// &Force("output","st_dc_bytes_vld"); @205
// &Force("output","st_dc_st"); @206
// &Force("output","st_dc_boundary"); @207
// &Force("output","st_dc_expt_vld_except_access_err"); @208
// &Force("output","st_dc_split"); @209
// &Force("output","st_dc_pc"); @210
//boundary signal is not accurate if there is an exception
always @(posedge st_dc_inst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_dc_expt_vld_except_access_err  <=  1'b0;
    st_dc_vpn[`PA_WIDTH-13:0]         <=  {`PA_WIDTH-12{1'b0}};
    st_dc_vpn_high[23:0]              <=  24'b0;
    st_dc_split                       <=  1'b0;
    st_dc_sync_fence                  <=  1'b0;
    st_dc_fence_mode[3:0]             <=  4'b0;
    st_dc_icc                         <=  1'b0;
    st_dc_inst_flush                  <=  1'b0;
    st_dc_inst_type[1:0]              <=  2'b0;
    st_dc_inst_size[2:0]              <=  3'b0;
    st_dc_inst_mode[1:0]              <=  2'b0;
    st_dc_st                          <=  1'b0;
    st_dc_secd                        <=  1'b0;
    st_dc_already_da                  <=  1'b0;
    st_dc_lsiq_spec_fail              <=  1'b0;
    st_dc_lsiq_bkpta_data             <=  1'b0;
    st_dc_lsiq_bkptb_data             <=  1'b0;
    st_dc_atomic                      <=  1'b0;
    st_dc_atomic_src1_data[63:0]      <=  64'b0;
    st_dc_atomic_func[15:0]           <=  16'b0;
    st_dc_iid[6:0]                    <=  7'b0;
    st_dc_lsid[LSIQ_ENTRY-1:0]        <=  {LSIQ_ENTRY{1'b0}};
    st_dc_sdid_oh[LSIQ_ENTRY-1:0]     <=  {LSIQ_ENTRY{1'b0}};
    st_dc_old                         <=  1'b0;
    st_dc_bytes_vld[15:0]             <=  16'b0;
    st_dc_rot_sel[3:0]                <=  4'b0;
    st_dc_boundary                    <=  1'b0;
    st_dc_page_so                     <=  1'b0;
    st_dc_page_ca                     <=  1'b0;
    st_dc_page_wa                     <=  1'b0;
    st_dc_page_buf                    <=  1'b0;
    st_dc_page_sec                    <=  1'b0;
    st_dc_page_share                  <=  1'b0;
    st_dc_utlb_miss                   <=  1'b0;
    st_dc_tlb_busy                    <=  1'b0;
    st_dc_no_spec                     <=  1'b0;
    st_dc_staddr                      <=  1'b0;
    st_dc_pc[PC_LEN-1:0]              <=  {PC_LEN{1'b0}};
    st_dc_lsfifo                      <=  1'b0;
  end
  else if(st_ag_inst_vld)
  begin
    st_dc_expt_vld_except_access_err  <=  st_ag_expt_vld;
    st_dc_vpn[`PA_WIDTH-13:0]         <=  st_ag_vpn[`PA_WIDTH-13:0];
    st_dc_vpn_high[23:0]              <=  st_ag_vpn_high[23:0];
    st_dc_split                       <=  st_ag_split;
    st_dc_sync_fence                  <=  st_ag_sync_fence;
    st_dc_fence_mode[3:0]             <=  st_ag_fence_mode[3:0];
    st_dc_icc                         <=  st_ag_icc;
    st_dc_inst_flush                  <=  st_ag_inst_flush;
    st_dc_inst_type[1:0]              <=  st_ag_inst_type[1:0];
    st_dc_inst_size[2:0]              <=  st_ag_dc_access_size[2:0];
    st_dc_inst_mode[1:0]              <=  st_ag_inst_mode[1:0];
    st_dc_st                          <=  st_ag_st;
    st_dc_secd                        <=  st_ag_secd;
    st_dc_already_da                  <=  st_ag_already_da;
    st_dc_lsiq_spec_fail              <=  st_ag_lsiq_spec_fail;
    st_dc_lsiq_bkpta_data             <=  st_ag_lsiq_bkpta_data;
    st_dc_lsiq_bkptb_data             <=  st_ag_lsiq_bkptb_data;
    st_dc_atomic                      <=  st_ag_atomic;
    st_dc_atomic_src1_data[63:0]      <=  st_ag_atomic_src1_data[63:0];
    st_dc_atomic_func[15:0]           <=  st_ag_atomic_func[15:0];
    st_dc_iid[6:0]                    <=  st_ag_iid[6:0];
    st_dc_lsid[LSIQ_ENTRY-1:0]        <=  st_ag_lsid[LSIQ_ENTRY-1:0];
    st_dc_sdid_oh[LSIQ_ENTRY-1:0]     <=  st_ag_sdid_oh[LSIQ_ENTRY-1:0];
    st_dc_old                         <=  st_ag_old;
    st_dc_bytes_vld[15:0]             <=  st_ag_dc_bytes_vld[15:0];
    st_dc_rot_sel[3:0]                <=  st_ag_dc_rot_sel[3:0];
    st_dc_boundary                    <=  st_ag_boundary;
    st_dc_page_so                     <=  st_ag_page_so;
    st_dc_page_ca                     <=  st_ag_page_ca;
    st_dc_page_wa                     <=  st_ag_page_wa;
    st_dc_page_buf                    <=  st_ag_page_buf;
    st_dc_page_sec                    <=  st_ag_page_sec;
    st_dc_page_share                  <=  st_ag_dc_page_share;
    st_dc_utlb_miss                   <=  st_ag_utlb_miss;
    st_dc_tlb_busy                    <=  mmu_lsu_tlb_busy;
    st_dc_no_spec                     <=  st_ag_no_spec;
    st_dc_staddr                      <=  st_ag_staddr;
    st_dc_pc[PC_LEN-1:0]              <=  st_ag_pc[PC_LEN-1:0];
    st_dc_lsfifo                      <=  st_ag_lsfifo;
  end
end

//------------------inst/borrow share part------------------
//+-------+
//| addr0 |
//+-------+
// &Force("output","st_dc_addr0"); @318
always @(posedge st_dc_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_dc_addr0[`PA_WIDTH-1:0]     <=  {`PA_WIDTH{1'b0}};
  else if(st_ag_inst_vld  ||  dcache_arb_st_dc_borrow_vld)
    st_dc_addr0[`PA_WIDTH-1:0]     <=  st_ag_dc_addr0[`PA_WIDTH-1:0];
end

//==========================================================
//        Generate  va
//==========================================================
assign st_dc_va[63:40]          = st_dc_vpn_high[23:0];
assign st_dc_va[`PA_WIDTH-1:12] = st_dc_vpn[`PA_WIDTH-13:0];
assign st_dc_va[11:4]           = st_dc_addr0[11:4];
assign st_dc_va[3:0]            = st_dc_secd
                                  ? 4'b0
                                  : st_dc_addr0[3:0];

// for preload addr check
//assign st_dc_pfu_va_11to4[7:0]      = st_dc_boundary  &&  !st_dc_secd
//                                      ? st_dc_addr1_11to4[7:0]
//                                      : st_dc_addr0[11:4];
//first unalign st inst use small addr                                      
assign st_dc_pfu_va_11to4[7:0]      = st_dc_addr0[11:4];                                      
//if this inst cross 4k, this va is not accurate
assign st_dc_pfu_va[`PA_WIDTH-1:0]  = {st_dc_vpn[`PA_WIDTH-13:0],
                                      st_dc_pfu_va_11to4[7:0],
                                      st_dc_addr0[3:0]};

//Generage pfu signal
assign st_dc_pf_inst = st_dc_inst_vld
                       && st_dc_st_inst
                       && !st_dc_vector_nop
                       && st_dc_lsfifo
                       && st_dc_page_ca
                       && cp0_lsu_l2_st_pref_en
                       && !st_dc_split
                       && !st_dc_secd;
//==========================================================
//        Exception generate
//==========================================================
assign st_dc_expt_access_fault_mask   = st_dc_expt_misalign_no_page
                                        ||  st_dc_expt_page_fault
                                        ||  st_dc_expt_illegal_inst
                                        ||  st_dc_icc_inst;

assign st_dc_expt_access_fault_extra  = st_dc_mmu_req
                                        &&  st_dc_expt_stamo_not_ca;

assign st_dc_expt_access_fault_short  = st_dc_mmu_req;
//if utlb_miss and dmmu expt,
//then st_dc_expt_vld_except_access_err is 0,
//but st_dc_da_expt_vld is not certain
assign st_dc_da_expt_vld_gate_en  = st_dc_expt_vld_except_access_err
                                    ||  st_dc_expt_access_fault_short;

// &CombBeg; @374
always @( st_dc_expt_misalign_with_page
       or st_dc_expt_access_fault_with_page
       or st_dc_mt_value_ori[63:0]
       or st_dc_expt_page_fault
       or st_dc_st
       or st_dc_atomic
       or st_dc_expt_misalign_no_page
       or st_dc_bc_expt_misalign
       or st_dc_bc_expt_check_fail
       or st_dc_va[63:0]
       or st_dc_expt_illegal_inst)
begin
st_dc_expt_vec[14:0]   = 15'h0;
st_dc_mt_value[PC_WIDTH-1:0]  = {PC_WIDTH{1'b0}};
if(st_dc_expt_illegal_inst)
begin
  st_dc_expt_vec[14:0]   = 15'he;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_mt_value_ori[PC_WIDTH-1:0];
end
else if(st_dc_bc_expt_misalign)
begin
  st_dc_expt_vec[14:0]   = 15'h9;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_mt_value_ori[PC_WIDTH-1:0];
end
else if(st_dc_expt_misalign_no_page)
begin
  st_dc_expt_vec[14:0]   = 15'h9;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_mt_value_ori[PC_WIDTH-1:0];
end
else if(st_dc_bc_expt_check_fail)
begin
  st_dc_expt_vec[14:0]   = 15'ha;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_mt_value_ori[PC_WIDTH-1:0];
end
else if(st_dc_expt_page_fault && st_dc_atomic)
begin
  st_dc_expt_vec[14:0]   = 15'h2;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_va[PC_WIDTH-1:0];
end
else if(st_dc_expt_page_fault && st_dc_st)
begin
  st_dc_expt_vec[14:0]   = 15'h2;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_va[PC_WIDTH-1:0];
end
else if(st_dc_expt_misalign_with_page)
begin
  st_dc_expt_vec[14:0] = 15'h9;
  st_dc_mt_value[PC_WIDTH-1:0]  = st_dc_va[PC_WIDTH-1:0];
end
else if(st_dc_expt_access_fault_with_page)
begin
  st_dc_expt_vec[14:0] = 15'h108;
  st_dc_mt_value[PC_WIDTH-1:0]  = {PC_WIDTH{1'b0}};
end
// &CombEnd @407
end

//==========================================================
//                  get commit hit signal
//==========================================================
assign st_dc_cmit0_iid_crt_hit  = rtu_lsu_commit0_iid_updt_val[6:0] == st_dc_iid[6:0];
assign st_dc_cmit1_iid_crt_hit  = rtu_lsu_commit1_iid_updt_val[6:0] == st_dc_iid[6:0];
assign st_dc_cmit2_iid_crt_hit  = rtu_lsu_commit2_iid_updt_val[6:0] == st_dc_iid[6:0];

//==========================================================
//                      encode sdid
//==========================================================
//encode sdid to create lq signal
// &Force("output","st_dc_sdid"); @420
assign st_dc_sdid[3:0]  = {4{st_dc_sdid_oh[0]}} & 4'd0
                          | {4{st_dc_sdid_oh[1]}} & 4'd1
                          | {4{st_dc_sdid_oh[2]}} & 4'd2
                          | {4{st_dc_sdid_oh[3]}} & 4'd3
                          | {4{st_dc_sdid_oh[4]}} & 4'd4
                          | {4{st_dc_sdid_oh[5]}} & 4'd5
                          | {4{st_dc_sdid_oh[6]}} & 4'd6
                          | {4{st_dc_sdid_oh[7]}} & 4'd7
                          | {4{st_dc_sdid_oh[8]}} & 4'd8
                          | {4{st_dc_sdid_oh[9]}} & 4'd9
                          | {4{st_dc_sdid_oh[10]}} & 4'd10
                          | {4{st_dc_sdid_oh[11]}} & 4'd11;

assign st_dc_sdid_hit   = (st_dc_sdid[3:0] ==  sd_rf_ex1_sdid[3:0]);
//==========================================================
//        Generate inst type
//==========================================================
// &Force("output","st_dc_vector_nop"); @438
assign st_dc_vector_nop = 1'b0;
//st/str/push/srs is treated as st inst
assign st_dc_sync_inst          = st_dc_sync_fence
                                  &&  !st_dc_atomic
                                  &&  (st_dc_inst_type[1:0]  ==  2'b00);
assign st_dc_fence_inst         = st_dc_sync_fence
                                  &&  !st_dc_atomic
                                  &&  (st_dc_inst_type[1:0]  ==  2'b01);
assign st_dc_icc_inst           = st_dc_icc
                                  &&  !st_dc_atomic;
assign st_dc_tlbi_inst          = st_dc_icc_inst
                                  &&  (st_dc_inst_type[1:0]  ==  2'b00);
//assign st_dc_tlbi_has_asid_inst = st_dc_tlbi_inst
//                                  &&  st_dc_inst_mode[0];
assign st_dc_icache_inst        = st_dc_icc_inst
                                  &&  (st_dc_inst_type[1:0]  ==  2'b01);
assign st_dc_dcache_inst        = st_dc_icc_inst
                                  &&  (st_dc_inst_type[1:0]  ==  2'b10);
assign st_dc_l2cache_inst       = st_dc_icc_inst
                                  &&  (st_dc_inst_type[1:0]  ==  2'b11);
assign st_dc_st_inst            = !st_dc_icc
                                  &&  !st_dc_atomic
                                  &&  !st_dc_sync_fence
                                  &&  (st_dc_inst_type[1:0]  ==  2'b00);
assign st_dc_wo_st_inst         = st_dc_st_inst
                                  &&  !st_dc_page_so;

assign st_dc_dcache_all_inst    = st_dc_dcache_inst
                                  &&  (st_dc_inst_mode[1:0]  ==  2'b00);

assign st_dc_dcache_1line_inst  = st_dc_dcache_inst
                                  &&  (st_dc_inst_mode[1:0]  !=  2'b00);

assign st_dc_dcache_pa_sw_inst  = st_dc_dcache_inst
                                  &&  st_dc_inst_mode[1];

assign st_dc_icache_all_inst    = st_dc_icache_inst
                                  &&  (st_dc_inst_mode[1:0]  ==  2'b00);

//==========================================================
//                 Create load queue
//==========================================================
//lq_create_vld is not accurate, comparing iid is a must precedure to create lq
//----------------create signal-----------------------------
// &Force("output","st_dc_sq_create_vld"); @490
assign st_dc_sq_create_vld          = st_dc_inst_vld
                                      &&  !st_dc_vector_nop
                                      &&  !sq_st_dc_inst_hit
                                      &&  !st_dc_utlb_miss
                                      &&  !st_dc_expt_vld_except_access_err;
// &Force("output","st_dc_sq_create_dp_vld"); @496
assign st_dc_sq_create_dp_vld       = st_dc_sq_create_vld;
// &Force("output","st_dc_sq_create_gateclk_en"); @498
assign st_dc_sq_create_gateclk_en   = st_dc_sq_create_dp_vld;


// &Force("output","st_dc_sq_data_vld"); @502
assign st_dc_sq_data_vld            = st_dc_inst_vld
                                      &&  !st_dc_staddr;
//----------------success signal----------------------------
// &Force("output","st_dc_boundary_first"); @506
assign st_dc_boundary_first         = st_dc_boundary  &&  !st_dc_secd;
//==========================================================
//        Generate check signal to lq/ld_dc stage
//==========================================================
assign st_dc_chk_st_inst_vld        = st_dc_inst_vld
                                      &&  st_dc_st_inst
                                      &&  !st_dc_vector_nop
                                      &&  !st_dc_expt_vld_except_access_err
                                      &&  !st_dc_utlb_miss
                                      &&  !st_dc_page_so;
assign st_dc_chk_statomic_inst_vld  = st_dc_inst_vld
                                      &&  st_dc_atomic
                                      &&  !st_dc_vector_nop
                                      &&  !st_dc_expt_vld_except_access_err
                                      &&  !st_dc_utlb_miss
                                      &&  !st_dc_page_so;

//------------------data pre_select----------------
// &CombBeg;    @526
// &CombEnd; @546
// &CombBeg;    @564
always @( st_dc_rot_sel[2:0])
begin
casez(st_dc_rot_sel[2:0])
  3'h0:st_dc_data_rot_sel[7:0]  = 8'b00000001;
  3'h1:st_dc_data_rot_sel[7:0]  = 8'b00000010;
  3'h2:st_dc_data_rot_sel[7:0]  = 8'b00000100;
  3'h3:st_dc_data_rot_sel[7:0]  = 8'b00001000;
  3'h4:st_dc_data_rot_sel[7:0]  = 8'b00010000;
  3'h5:st_dc_data_rot_sel[7:0]  = 8'b00100000;
  3'h6:st_dc_data_rot_sel[7:0]  = 8'b01000000;
  3'h7:st_dc_data_rot_sel[7:0]  = 8'b10000000;
  default:st_dc_data_rot_sel[7:0]  = {8{1'bx}};
endcase
// &CombEnd; @576
end
assign st_dc_rot_sel_rev[7:0]  = {st_dc_data_rot_sel[1],
                                  st_dc_data_rot_sel[2],
                                  st_dc_data_rot_sel[3],
                                  st_dc_data_rot_sel[4],
                                  st_dc_data_rot_sel[5],
                                  st_dc_data_rot_sel[6],
                                  st_dc_data_rot_sel[7],
                                  st_dc_data_rot_sel[0]};


//==========================================================
//        Compare cache write port
//==========================================================
// &Force("output","st_dc_dcwp_hit_idx"); @591
// &Force("input","dcache_idx"); @592
// &Force("bus","dcache_idx","8","0"); @593
// &Force("input","dcache_dirty_gwen"); @594
//csky vperl_off
`ifdef DCACHE_32K
assign st_dc_dcwp_hit_idx = dcache_dirty_gwen
                            &&  (st_dc_addr0[13:6]  ==  dcache_idx[7:0]);
`endif //DCACHE_32K
`ifdef DCACHE_64K
assign st_dc_dcwp_hit_idx = dcache_dirty_gwen
                            &&  (st_dc_addr0[14:6]  ==  dcache_idx[8:0]);
`endif //DCACHE_64K
//csky vperl_on

//==========================================================
//                 Restart signal
//==========================================================
//-----------arbiter----------------------------------------
//prioritize:
//1. utlb_miss(include tlb_busy)
//2. sq_full

assign st_dc_utlb_miss_vld    = st_dc_inst_vld
                                &&  !st_dc_expt_vld_except_access_err
                                &&  st_dc_utlb_miss;
assign st_dc_sq_full_vld      = !st_dc_utlb_miss
                                &&  st_dc_sq_create_dp_vld &&  sq_st_dc_full;
assign st_dc_sq_full_gateclk_en = st_dc_sq_create_gateclk_en
                                  &&  sq_st_dc_full;

assign st_dc_restart_vld      = st_dc_sq_full_vld
                                ||  st_dc_utlb_miss_vld;

//---------------------restart kinds------------------------
assign st_dc_imme_restart_vld = st_dc_utlb_miss_vld
                                &&  !st_dc_tlb_busy;

assign st_dc_tlb_busy_restart_vld = st_dc_utlb_miss_vld
                                    &&  st_dc_tlb_busy;
assign st_dc_tlb_busy_gateclk_en  = st_dc_tlb_busy_restart_vld;

//==========================================================
//                Generage had signal
//==========================================================
assign st_dc_had_bkpta_addr[`PA_WIDTH-1:`VA_WIDTH]  = mmu_lsu_mmu_en
                ? {`PA_WIDTH-`VA_WIDTH{had_yy_xx_bkpta_base[`VA_WIDTH-1]}}
                : had_yy_xx_bkpta_base[`PA_WIDTH-1:`VA_WIDTH];

assign st_dc_had_bkpta_addr[`VA_WIDTH-1:0] = {had_yy_xx_bkpta_base[`VA_WIDTH-1:8],
                                    had_yy_xx_bkpta_base[7:0]
                                    & had_yy_xx_bkpta_mask[7:0]};

assign st_dc_had_bkptb_addr[`PA_WIDTH-1:`VA_WIDTH]  = mmu_lsu_mmu_en
                ? {`PA_WIDTH-`VA_WIDTH{had_yy_xx_bkptb_base[`VA_WIDTH-1]}}
                : had_yy_xx_bkptb_base[`PA_WIDTH-1:`VA_WIDTH];

assign st_dc_had_bkptb_addr[`VA_WIDTH-1:0] = {had_yy_xx_bkptb_base[`VA_WIDTH-1:8],
                                    had_yy_xx_bkptb_base[7:0]
                                    & had_yy_xx_bkptb_mask[7:0]};

assign st_dc_bkpta_addr[`VA_WIDTH-1:0]     = {st_dc_va[`VA_WIDTH-1:8],
                                    st_dc_va[7:0]
                                    & had_yy_xx_bkpta_mask[7:0]};

assign st_dc_bkptb_addr[`VA_WIDTH-1:0]     = {st_dc_va[`VA_WIDTH-1:8],
                                    st_dc_va[7:0]
                                    & had_yy_xx_bkptb_mask[7:0]};

assign st_dc_bkpta_trap           = had_yy_xx_bkpta_rc
                                    ^ (st_dc_had_bkpta_addr[`VA_WIDTH-1:0]
                                      ==  st_dc_bkpta_addr[`VA_WIDTH-1:0]);

assign st_dc_bkptb_trap           = had_yy_xx_bkptb_rc
                                    ^ (st_dc_had_bkptb_addr[`VA_WIDTH-1:0]
                                      ==  st_dc_bkptb_addr[`VA_WIDTH-1:0]);

assign st_dc_pipe_bkpta_data      = (st_dc_st_inst
                                        ||  st_dc_atomic)
                                    &&  !st_dc_vector_nop
                                    &&  st_dc_bkpta_trap;
assign st_dc_pipe_bkptb_data      = (st_dc_st_inst
                                        ||  st_dc_atomic)
                                    &&  !st_dc_vector_nop
                                    &&  st_dc_bkptb_trap;

//==========================================================
//        Combine signal of spec_fail/bkpt
//==========================================================
assign st_dc_spec_fail            = lq_st_dc_spec_fail
                                    ||  st_dc_lsiq_spec_fail;

assign st_dc_bkpta_data           = st_dc_lsiq_bkpta_data
                                    ||  st_dc_pipe_bkpta_data;

assign st_dc_bkptb_data           = st_dc_lsiq_bkptb_data
                                    ||  st_dc_pipe_bkptb_data;

//==========================================================
//            Generage get dcache signal
//==========================================================
assign st_dc_get_dcache_tag_dirty = st_dc_inst_vld
                                        &&  !st_dc_vector_nop
                                        &&  !st_dc_utlb_miss
                                        &&  (st_dc_st_inst
                                            ||  st_dc_atomic
                                            ||  st_dc_dcache_1line_inst)
                                        &&  (st_dc_page_ca
                                            ||  st_dc_dcache_pa_sw_inst)
                                        &&  cp0_lsu_dcache_en
                                        &&  !st_dc_expt_vld_except_access_err
                                    ||  st_dc_borrow_vld;
//==========================================================
//                 Forward to st_data
//==========================================================
assign lsu_idu_dc_staddr_vld      = (st_dc_sq_create_dp_vld
                                       && !sq_st_dc_full
                                    || st_dc_inst_vld
                                       && st_dc_vector_nop
                                       && !st_dc_utlb_miss_vld)
                                    &&  !st_dc_already_da
                                    &&  st_dc_staddr;
assign lsu_idu_dc_staddr_unalign  = st_dc_boundary_first;
assign lsu_idu_dc_staddr1_vld     = st_dc_secd;
assign lsu_idu_dc_sdiq_entry[LSIQ_ENTRY-1:0]  = st_dc_sdid_oh[LSIQ_ENTRY-1:0];

//==========================================================
//        Generage to DA stage signal
//==========================================================
assign st_dc_da_inst_vld          = st_dc_inst_vld
                                    &&  !st_dc_restart_vld;
//------------------page info sel if sync/bar req----------
assign st_dc_default_page         = st_dc_sync_inst
                                    ||  st_dc_fence_inst
                                    ||  st_dc_dcache_all_inst
                                    ||  st_dc_icache_all_inst
                                    ||  st_dc_tlbi_inst
                                    ||  st_dc_st_inst && !st_dc_staddr   //illege inst
                                    ||  st_dc_l2cache_inst;

assign st_dc_da_page_so           = st_dc_default_page
                                    ? 1'b0
                                    : st_dc_page_so;
assign st_dc_dcache_pa_sw_page_ca = st_dc_dcache_pa_sw_inst
                                    ? 1'b1
                                    : st_dc_page_ca;
assign st_dc_da_page_ca           = st_dc_default_page
                                    ? 1'b0
                                    : st_dc_dcache_pa_sw_page_ca;
assign st_dc_da_page_wa           = st_dc_default_page
                                    ? 1'b0
                                    : st_dc_page_wa;
assign st_dc_da_page_buf          = st_dc_default_page
                                    ? 1'b1
                                    : st_dc_page_buf;
assign st_dc_da_page_sec          = st_dc_default_page
                                    ? 1'b0
                                    : st_dc_page_sec;
assign st_dc_da_page_share        = st_dc_dcache_pa_sw_inst
                                    ? 1'b1
                                    : st_dc_page_share;

//------------------dcache tag pre_compare----------------
assign st_dc_da_dcache_tag_array[51:0]  = dcache_lsu_st_tag_dout[51:0];

// &Force("output","st_dc_da_inst_vld"); @758
// &Force("output","st_dc_da_page_ca"); @759
// &Force("output","st_dc_borrow_icc"); @760
assign st_dc_da_dcache_dirty_array[6:0] = dcache_lsu_st_dirty_dout[6:0];

assign st_dc_da_tag0_hit  = (st_dc_addr0[`PA_WIDTH-1:14] == dcache_lsu_st_tag_dout[25:0]);
assign st_dc_da_tag1_hit  = (st_dc_addr0[`PA_WIDTH-1:14] == dcache_lsu_st_tag_dout[51:26]);
//==========================================================
//        Generage lsiq signal
//==========================================================
assign st_dc_mask_lsid[LSIQ_ENTRY-1:0]    = {LSIQ_ENTRY{st_dc_inst_vld}}
                                            & st_dc_lsid[LSIQ_ENTRY-1:0];

assign st_dc_idu_sq_full[LSIQ_ENTRY-1:0]  = {LSIQ_ENTRY{st_dc_sq_full_vld}}
                                            & st_dc_mask_lsid[LSIQ_ENTRY-1:0];

assign st_dc_imme_wakeup[LSIQ_ENTRY-1:0]  = {LSIQ_ENTRY{st_dc_imme_restart_vld}}
                                            & st_dc_mask_lsid[LSIQ_ENTRY-1:0];

assign st_dc_idu_tlb_busy[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{st_dc_tlb_busy_restart_vld}}
                                            & st_dc_mask_lsid[LSIQ_ENTRY-1:0];
//==========================================================
//        for mmu power
//==========================================================
assign lsu_mmu_vabuf1[27:0] = st_dc_vpn[27:0];

// &ModuleEnd; @796
endmodule


