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
module ct_lsu_st_da (
  // &Ports, @27
  input    wire          amr_wa_cancel,
  input    wire          cp0_lsu_dcache_en,
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_lsu_l2_st_pref_en,
  input    wire          cp0_lsu_nsfe,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_st_clk,
  input    wire  [6 :0]  dcache_dirty_din,
  input    wire          dcache_dirty_gwen,
  input    wire  [6 :0]  dcache_dirty_wen,
  input    wire  [8 :0]  dcache_idx,
  input    wire  [51:0]  dcache_tag_din,
  input    wire          dcache_tag_gwen,
  input    wire  [1 :0]  dcache_tag_wen,
  input    wire          forever_cpuclk,
  input    wire          ld_da_st_da_hit_idx,
  input    wire          lfb_st_da_hit_idx,
  input    wire          lm_st_da_hit_idx,
  input    wire          lsu_has_fence,
  input    wire          mmu_lsu_access_fault1,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [39:0]  pfu_biu_req_addr,
  input    wire          rb_st_da_full,
  input    wire          rb_st_da_hit_idx,
  input    wire          rtu_yy_xx_commit0,
  input    wire  [6 :0]  rtu_yy_xx_commit0_iid,
  input    wire          rtu_yy_xx_commit1,
  input    wire  [6 :0]  rtu_yy_xx_commit1_iid,
  input    wire          rtu_yy_xx_commit2,
  input    wire  [6 :0]  rtu_yy_xx_commit2_iid,
  input    wire          rtu_yy_xx_flush,
  input    wire  [39:0]  st_dc_addr0,
  input    wire          st_dc_already_da,
  input    wire          st_dc_atomic,
  input    wire          st_dc_bkpta_data,
  input    wire          st_dc_bkptb_data,
  input    wire          st_dc_borrow_dcache_replace,
  input    wire          st_dc_borrow_dcache_sw,
  input    wire          st_dc_borrow_icc,
  input    wire          st_dc_borrow_snq,
  input    wire  [5 :0]  st_dc_borrow_snq_id,
  input    wire          st_dc_borrow_vld,
  input    wire          st_dc_boundary,
  input    wire  [15:0]  st_dc_bytes_vld,
  input    wire  [6 :0]  st_dc_da_dcache_dirty_array,
  input    wire  [51:0]  st_dc_da_dcache_tag_array,
  input    wire          st_dc_da_expt_vld_gate_en,
  input    wire          st_dc_da_inst_vld,
  input    wire          st_dc_da_page_buf,
  input    wire          st_dc_da_page_ca,
  input    wire          st_dc_da_page_sec,
  input    wire          st_dc_da_page_share,
  input    wire          st_dc_da_page_so,
  input    wire          st_dc_da_page_wa,
  input    wire          st_dc_da_tag0_hit,
  input    wire          st_dc_da_tag1_hit,
  input    wire          st_dc_dcwp_hit_idx,
  input    wire          st_dc_expt_access_fault_extra,
  input    wire          st_dc_expt_access_fault_mask,
  input    wire  [14:0]  st_dc_expt_vec,
  input    wire          st_dc_expt_vld_except_access_err,
  input    wire  [3 :0]  st_dc_fence_mode,
  input    wire          st_dc_get_dcache_tag_dirty,
  input    wire          st_dc_icc,
  input    wire  [6 :0]  st_dc_iid,
  input    wire  [1 :0]  st_dc_inst_mode,
  input    wire  [2 :0]  st_dc_inst_size,
  input    wire  [1 :0]  st_dc_inst_type,
  input    wire          st_dc_inst_vld,
  input    wire  [11:0]  st_dc_lsid,
  input    wire          st_dc_mmu_req,
  input    wire  [63:0]  st_dc_mt_value,
  input    wire          st_dc_no_spec,
  input    wire          st_dc_old,
  input    wire  [14:0]  st_dc_pc,
  input    wire          st_dc_pf_inst,
  input    wire  [39:0]  st_dc_pfu_va,
  input    wire          st_dc_secd,
  input    wire          st_dc_spec_fail,
  input    wire          st_dc_split,
  input    wire          st_dc_st,
  input    wire          st_dc_sync_fence,
  input    wire          st_dc_vector_nop,
  output   wire          lsu_hpcp_st_cache_access,
  output   wire          lsu_hpcp_st_cache_miss,
  output   wire          lsu_hpcp_st_unalign_inst,
  output   wire  [6 :0]  lsu_rtu_da_pipe4_split_spec_fail_iid,
  output   wire          lsu_rtu_da_pipe4_split_spec_fail_vld,
  output   wire  [39:0]  st_da_addr,
  output   reg           st_da_bkpta_data,
  output   reg           st_da_bkptb_data,
  output   wire          st_da_borrow_icc_vld,
  output   reg           st_da_borrow_vld,
  output   wire          st_da_dcache_dirty,
  output   wire          st_da_dcache_hit,
  output   wire          st_da_dcache_miss,
  output   wire          st_da_dcache_replace_dirty,
  output   wire          st_da_dcache_replace_valid,
  output   wire          st_da_dcache_replace_way,
  output   wire          st_da_dcache_way,
  output   wire  [11:0]  st_da_ecc_wakeup,
  output   wire          st_da_fence_inst,
  output   reg   [3 :0]  st_da_fence_mode,
  output   wire  [2 :0]  st_da_icc_dirty_info,
  output   wire  [25:0]  st_da_icc_tag_info,
  output   wire  [11:0]  st_da_idu_already_da,
  output   wire  [11:0]  st_da_idu_bkpta_data,
  output   wire  [11:0]  st_da_idu_bkptb_data,
  output   wire  [11:0]  st_da_idu_boundary_gateclk_en,
  output   wire  [11:0]  st_da_idu_pop_entry,
  output   wire          st_da_idu_pop_vld,
  output   wire  [11:0]  st_da_idu_rb_full,
  output   wire  [11:0]  st_da_idu_secd,
  output   wire  [11:0]  st_da_idu_spec_fail,
  output   wire  [11:0]  st_da_idu_wait_fence,
  output   reg   [6 :0]  st_da_iid,
  output   reg   [2 :0]  st_da_inst_size,
  output   reg           st_da_inst_vld,
  output   reg           st_da_old,
  output   reg           st_da_page_buf,
  output   reg           st_da_page_ca,
  output   reg           st_da_page_sec,
  output   reg           st_da_page_sec_ff,
  output   reg           st_da_page_share,
  output   reg           st_da_page_share_ff,
  output   reg           st_da_page_so,
  output   reg   [14:0]  st_da_pc,
  output   wire          st_da_pfu_act_dp_vld,
  output   wire          st_da_pfu_act_vld,
  output   wire          st_da_pfu_biu_req_hit_idx,
  output   wire          st_da_pfu_evict_cnt_vld,
  output   wire          st_da_pfu_pf_inst_vld,
  output   wire  [39:0]  st_da_ppfu_va,
  output   reg   [27:0]  st_da_ppn_ff,
  output   wire          st_da_rb_cmit,
  output   wire          st_da_rb_create_dp_vld,
  output   wire          st_da_rb_create_gateclk_en,
  output   wire          st_da_rb_create_lfb,
  output   wire          st_da_rb_create_vld,
  output   wire          st_da_rb_full_gateclk_en,
  output   reg           st_da_secd,
  output   wire  [35:0]  st_da_sf_addr_tto4,
  output   wire  [15:0]  st_da_sf_bytes_vld,
  output   wire  [6 :0]  st_da_sf_iid,
  output   wire          st_da_sf_no_spec_miss,
  output   wire          st_da_sf_no_spec_miss_gate,
  output   wire          st_da_sf_spec_chk,
  output   wire          st_da_sf_spec_chk_gate,
  output   wire  [5 :0]  st_da_snq_borrow_snq,
  output   wire          st_da_snq_dcache_dirty,
  output   wire          st_da_snq_dcache_share,
  output   wire          st_da_snq_dcache_valid,
  output   wire          st_da_snq_dcache_way,
  output   wire          st_da_snq_ecc_err,
  output   wire          st_da_sq_dcache_dirty,
  output   wire          st_da_sq_dcache_share,
  output   wire          st_da_sq_dcache_valid,
  output   wire          st_da_sq_dcache_way,
  output   wire          st_da_sq_ecc_stall,
  output   wire          st_da_sq_no_restart,
  output   reg           st_da_sync_fence,
  output   wire          st_da_sync_inst,
  output   wire          st_da_vb_ecc_err,
  output   wire          st_da_vb_ecc_stall,
  output   reg   [25:0]  st_da_vb_feedback_addr_tto14,
  output   wire          st_da_vb_tag_reissue,
  output   wire          st_da_wait_fence_gateclk_en,
  output   wire          st_da_wb_cmplt_req,
  output   reg   [14:0]  st_da_wb_expt_vec,
  output   wire          st_da_wb_expt_vld,
  output   reg   [63:0]  st_da_wb_mt_value,
  output   wire          st_da_wb_no_spec_hit,
  output   wire          st_da_wb_no_spec_mispred,
  output   wire          st_da_wb_no_spec_miss,
  output   wire          st_da_wb_spec_fail,
  output   wire          st_da_wb_vstart_vld
); 



// &Regs; @28
reg     [39:0]  st_da_addr0;                         
reg             st_da_already_da;                    
reg             st_da_atomic;                        
reg             st_da_borrow_dcache_replace;         
reg             st_da_borrow_dcache_sw;              
reg             st_da_borrow_icc;                    
reg             st_da_borrow_snq;                    
reg     [5 :0]  st_da_borrow_snq_id;                 
reg             st_da_boundary;                      
reg     [15:0]  st_da_bytes_vld;                     
reg     [6 :0]  st_da_dcache_dirty_array;            
reg     [51:0]  st_da_dcache_tag_array;              
reg     [6 :0]  st_da_dcwp_dc_dirty_din;             
reg     [6 :0]  st_da_dcwp_dc_dirty_wen;             
reg             st_da_dcwp_dc_hit_idx;               
reg             st_da_expt_access_fault_extra;       
reg             st_da_expt_access_fault_mask;        
reg             st_da_expt_access_fault_mmu;         
reg     [14:0]  st_da_expt_vec;                      
reg             st_da_expt_vld_except_access_err;    
reg             st_da_icc;                           
reg     [1 :0]  st_da_inst_mode;                     
reg     [1 :0]  st_da_inst_type;                     
reg     [11:0]  st_da_lsid;                          
reg             st_da_mmu_req;                       
reg     [63:0]  st_da_mt_value;                      
reg             st_da_no_spec;                       
reg             st_da_page_wa;                       
reg             st_da_pf_inst;                       
reg     [39:0]  st_da_pfu_va;                        
reg             st_da_spec_fail;                     
reg             st_da_split;                         
reg             st_da_split_miss_ff;                 
reg             st_da_st;                            
reg             st_da_tag0_hit;                      
reg             st_da_tag1_hit;                      
reg             st_da_vector_nop;                    

// &Wires; @29
wire            st_da_borrow_clk;                    
wire            st_da_borrow_clk_en;                 
wire            st_da_borrow_snq_vld;                
wire            st_da_boundary_cross_2k;             
wire            st_da_boundary_first;                
wire            st_da_clk;                           
wire            st_da_clk_en;                        
wire            st_da_cmit_hit0;                     
wire            st_da_cmit_hit1;                     
wire            st_da_cmit_hit2;                     
wire    [39:0]  st_da_cmp_pfu_biu_req_addr;          
wire            st_da_ctc_inst;                      
wire            st_da_dcache_1line_inst;             
wire            st_da_dcache_dc_up_dirty;            
wire            st_da_dcache_dc_up_share;            
wire            st_da_dcache_dc_up_valid;            
wire            st_da_dcache_dc_up_way;              
wire    [2 :0]  st_da_dcache_dirty_dc_up_hit_info;   
wire    [2 :0]  st_da_dcache_dirty_hit_info;         
wire            st_da_dcache_hit_idx;                
wire            st_da_dcache_info_vld;               
wire            st_da_dcache_inst;                   
wire            st_da_dcache_pa_inst;                
wire            st_da_dcache_sw_inst;                
wire            st_da_dcache_sw_sel;                 
wire            st_da_dcache_sw_way1;                
wire            st_da_dcache_update_vld;             
wire            st_da_dcache_va_inst;                
wire            st_da_dcache_valid0;                 
wire            st_da_dcache_valid1;                 
wire    [6 :0]  st_da_dirty_dc_update;               
wire    [6 :0]  st_da_dirty_dc_update_dout;          
wire            st_da_ecc_stall;                     
wire            st_da_ecc_stall_already;             
wire            st_da_ecc_stall_dcache_update;       
wire            st_da_ecc_stall_fatal;               
wire            st_da_expt_access_fault;             
wire            st_da_expt_clk;                      
wire            st_da_expt_clk_en;                   
wire            st_da_expt_vld;                      
wire            st_da_feedback_sel_tag;              
wire            st_da_feedback_sel_tag_way1;         
wire            st_da_ff_clk;                        
wire            st_da_ff_clk_en;                     
wire            st_da_hit_way0;                      
wire            st_da_hit_way1;                      
wire            st_da_idu_boundary_gateclk_vld;      
wire            st_da_idu_secd_vld;                  
wire            st_da_inst_clk;                      
wire            st_da_inst_clk_en;                   
wire            st_da_l2cache_inst;                  
wire    [11:0]  st_da_mask_lsid;                     
wire            st_da_no_spec_hit;                   
wire            st_da_no_spec_mispred;               
wire            st_da_no_spec_miss;                  
wire            st_da_page_ca_dcache_en;             
wire            st_da_rb_create_vld_unmask;          
wire            st_da_rb_full_vld;                   
wire            st_da_rb_page_wa;                    
wire            st_da_restart_vld;                   
wire    [2 :0]  st_da_snq_dcache_dirty_hit_info;     
wire            st_da_split_last;                    
wire            st_da_split_miss;                    
wire            st_da_st_inst;                       
wire            st_da_tag_dirty_clk;                 
wire            st_da_tag_dirty_clk_en;              
wire            st_da_tag_ecc_stall;                 
wire            st_da_tag_ecc_stall_gate;            
wire            st_da_wait_fence_vld;                


parameter BYTE          = 2'b00,
          HALF          = 2'b01,
          WORD          = 2'b10;
parameter LSIQ_ENTRY    = 12,
          SNQ_ENTRY     = 6;
parameter PC_LEN        = 15;
parameter PC_WIDTH      = 64;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//------------------normal reg------------------------------
assign st_da_clk_en = st_dc_inst_vld
                      ||  st_dc_borrow_vld;
// &Instance("gated_clk_cell", "x_lsu_st_da_gated_clk"); @44
gated_clk_cell  x_lsu_st_da_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_da_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (st_da_clk_en      ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @45
//          .external_en   (1'b0               ), @46
//          .global_en     (1'b1               ), @47
//          .module_en     (cp0_lsu_icg_en     ), @48
//          .local_en      (st_da_clk_en       ), @49
//          .clk_out       (st_da_clk          )); @50

assign st_da_inst_clk_en = st_dc_inst_vld;
// &Instance("gated_clk_cell", "x_lsu_st_da_inst_gated_clk"); @53
gated_clk_cell  x_lsu_st_da_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_da_inst_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (st_da_inst_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @54
//          .external_en   (1'b0               ), @55
//          .global_en     (cp0_yy_clk_en      ), @56
//          .module_en     (cp0_lsu_icg_en     ), @57
//          .local_en      (st_da_inst_clk_en  ), @58
//          .clk_out       (st_da_inst_clk     )); @59

assign st_da_borrow_clk_en = st_dc_borrow_vld;
// &Instance("gated_clk_cell", "x_lsu_st_da_borrow_gated_clk"); @62
gated_clk_cell  x_lsu_st_da_borrow_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (st_da_borrow_clk   ),
  .external_en         (1'b0               ),
  .global_en           (1'b1               ),
  .local_en            (st_da_borrow_clk_en),
  .module_en           (cp0_lsu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in        (forever_cpuclk     ), @63
//          .external_en   (1'b0               ), @64
//          .global_en     (1'b1               ), @65
//          .module_en     (cp0_lsu_icg_en     ), @66
//          .local_en      (st_da_borrow_clk_en), @67
//          .clk_out       (st_da_borrow_clk   )); @68

assign st_da_expt_clk_en  = st_dc_inst_vld
                            &&  st_dc_da_expt_vld_gate_en;
// &Instance("gated_clk_cell", "x_lsu_st_da_expt_gated_clk"); @72
gated_clk_cell  x_lsu_st_da_expt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_da_expt_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (st_da_expt_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @73
//          .external_en   (1'b0               ), @74
//          .global_en     (cp0_yy_clk_en      ), @75
//          .module_en     (cp0_lsu_icg_en     ), @76
//          .local_en      (st_da_expt_clk_en  ), @77
//          .clk_out       (st_da_expt_clk     )); @78

//------------------dcache reg------------------------------
assign st_da_tag_dirty_clk_en = st_dc_get_dcache_tag_dirty || st_da_tag_ecc_stall_gate;
// &Instance("gated_clk_cell", "x_lsu_st_da_tag_dirty_gated_clk"); @82
gated_clk_cell  x_lsu_st_da_tag_dirty_gated_clk (
  .clk_in                 (forever_cpuclk        ),
  .clk_out                (st_da_tag_dirty_clk   ),
  .external_en            (1'b0                  ),
  .global_en              (1'b1                  ),
  .local_en               (st_da_tag_dirty_clk_en),
  .module_en              (cp0_lsu_icg_en        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    )
);

// &Connect(.clk_in        (forever_cpuclk     ), @83
//          .external_en   (1'b0               ), @84
//          .global_en     (1'b1               ), @85
//          .module_en     (cp0_lsu_icg_en     ), @86
//          .local_en      (st_da_tag_dirty_clk_en), @87
//          .clk_out       (st_da_tag_dirty_clk)); @88

//==========================================================
//                 Pipeline Register
//==========================================================
//------------------control part----------------------------
//+----------+------------+
//| inst_vld | borrow_vld |
//+----------+------------+
// &Force("output","st_da_inst_vld"); @97
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_da_inst_vld        <=  1'b0;
  else if(rtu_yy_xx_flush)
    st_da_inst_vld        <=  1'b0;
  else if(st_dc_da_inst_vld)
    st_da_inst_vld        <=  1'b1;
  else
    st_da_inst_vld        <=  1'b0;
end

// &Force("output","st_da_borrow_vld"); @114
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_da_borrow_vld      <=  1'b0;
  else if(st_dc_borrow_vld)
    st_da_borrow_vld      <=  1'b1;
  else
    st_da_borrow_vld      <=  1'b0;
end

assign st_da_ecc_stall_already       = 1'b0;
assign st_da_ecc_stall_fatal         = 1'b0;
assign st_da_ecc_stall_dcache_update = 1'b0;
//------------------cache output part-----------------------
//+-----+-------+
//| tag | dirty |
//+-----+-------+
always @(posedge st_da_tag_dirty_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_da_dcache_tag_array[51:0]  <=  52'b0;
    st_da_dcache_dirty_array[6:0] <=  7'b0;
    st_da_tag0_hit                <=  1'b0;
    st_da_tag1_hit                <=  1'b0;
  end
  else if(st_dc_get_dcache_tag_dirty)
  begin
    st_da_dcache_tag_array[51:0]  <=  st_dc_da_dcache_tag_array[51:0];
    st_da_dcache_dirty_array[6:0] <=  st_dc_da_dcache_dirty_array[6:0];
    st_da_tag0_hit                <=  st_dc_da_tag0_hit;
    st_da_tag1_hit                <=  st_dc_da_tag1_hit;
  end
end

//------------------expt part-------------------------------
//+----------+-----+-----------+
//| expt_vec | vpn | dmmu_expt |
//+----------+-----+-----------+
always @(posedge st_da_expt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_da_expt_vec[14:0]          <=  15'b0;
    st_da_mt_value[PC_WIDTH-1:0] <=  {PC_WIDTH{1'b0}};
  end
  else if(st_dc_inst_vld  &&  st_dc_da_expt_vld_gate_en)
  begin
    st_da_expt_vec[14:0]          <=  st_dc_expt_vec[14:0];
    st_da_mt_value[PC_WIDTH-1:0] <=  st_dc_mt_value[PC_WIDTH-1:0];
  end
end

//------------------borrow part-----------------------------
//+-----+-----+
//| rcl | snq |
//+-----+-----+
always @(posedge st_da_borrow_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_da_borrow_dcache_replace         <=  1'b0;
    st_da_borrow_dcache_sw              <=  1'b0;
    st_da_borrow_snq                    <=  1'b0;
    st_da_borrow_icc                    <=  1'b0;
    st_da_borrow_snq_id[SNQ_ENTRY-1:0]  <=  {SNQ_ENTRY{1'b0}};
  end
  else if(st_dc_borrow_vld && !st_da_ecc_stall)
  begin
    st_da_borrow_dcache_replace         <=  st_dc_borrow_dcache_replace;
    st_da_borrow_dcache_sw              <=  st_dc_borrow_dcache_sw;
    st_da_borrow_snq                    <=  st_dc_borrow_snq;
    st_da_borrow_icc                    <=  st_dc_borrow_icc;
    st_da_borrow_snq_id[SNQ_ENTRY-1:0]  <=  st_dc_borrow_snq_id[SNQ_ENTRY-1:0];
  end
end

//------------------inst part----------------------------
//+----------+-----+----+-----------+-----------+-----------+
//| sync_fence | icc | ex | inst_type | inst_size | inst_mode |
//+----------+-----+----+-----------+-----------+-----------+
//+------+------------+-----------+-------+
//| secd | already_da | spec_fail | split |
//+------+------------+-----------+-------+
//+----+-----+------+-----+
//| ex | iid | lsid | old |
//+----+-----+------+-----+
//+----------+------+-------+-------+
//| boundary | preg | bkpta | bkptb |
//+----------+------+-------+-------+
//+------------+------------+
//| ldfifo_vld | ldfifo_idx |
//+------------+------------+
//+----+----+----+-----+-----+-------+
//| so | ca | wa | buf | sec | share |
//+----+----+----+-----+-----+-------+
// &Force("output","st_da_wb_expt_vld"); @300
// &Force("output","st_da_iid"); @301
// &Force("output","st_da_secd"); @302
// &Force("output","st_da_page_so"); @303
// &Force("output","st_da_page_ca"); @304
// &Force("output","st_da_bkpta_data"); @305
// &Force("output","st_da_bkptb_data"); @306
// &Force("output","st_da_sync_fence"); @307
// &Force("output","st_da_page_sec"); @308
// &Force("output","st_da_page_share"); @309
// &Force("output","st_da_pc"); @310
// &Force("nonport","st_da_nf_cnt"); @311
always @(posedge st_da_inst_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_da_mmu_req                     <=  1'b0;
    st_da_expt_vld_except_access_err  <=  1'b0;
    st_da_expt_access_fault_mask      <=  1'b0;
    st_da_expt_access_fault_extra     <=  1'b0;
    st_da_expt_access_fault_mmu       <=  1'b0;
    st_da_split                   <=  1'b0;
    st_da_sync_fence              <=  1'b0;
    st_da_icc                     <=  1'b0;
    st_da_inst_type[1:0]          <=  2'b0;
    st_da_inst_mode[1:0]          <=  2'b0;
    st_da_inst_size[2:0]          <=  3'b0;
    st_da_fence_mode[3:0]         <=  4'b0;
    st_da_st                      <=  1'b0;
    st_da_secd                    <=  1'b0;
    st_da_atomic                  <=  1'b0;
    st_da_iid[6:0]                <=  7'b0;
    st_da_lsid[LSIQ_ENTRY-1:0]    <=  {LSIQ_ENTRY{1'b0}};
    st_da_old                     <=  1'b0;
    st_da_boundary                <=  1'b0;
    st_da_spec_fail               <=  1'b0;
    st_da_bkpta_data              <=  1'b0;
    st_da_bkptb_data              <=  1'b0;
    st_da_page_so                 <=  1'b0;
    st_da_page_ca                 <=  1'b0;
    st_da_page_wa                 <=  1'b0;
    st_da_page_buf                <=  1'b0;
    st_da_page_sec                <=  1'b0;
    st_da_page_share              <=  1'b0;
    st_da_already_da              <=  1'b0;
    st_da_no_spec                 <=  1'b0;
    st_da_bytes_vld[15:0]         <=  16'b0;
    st_da_pc[PC_LEN-1:0]          <=  {PC_LEN{1'b0}};
    st_da_pfu_va[`PA_WIDTH-1:0]   <=  {`PA_WIDTH{1'b0}};
    st_da_pf_inst                 <=  1'b0;
    st_da_vector_nop              <=  1'b0;
  end
  else if(st_dc_inst_vld && !st_da_ecc_stall)
  begin
    st_da_mmu_req                     <=  st_dc_mmu_req;
    st_da_expt_vld_except_access_err  <=  st_dc_expt_vld_except_access_err;
    st_da_expt_access_fault_mask      <=  st_dc_expt_access_fault_mask;
    st_da_expt_access_fault_extra     <=  st_dc_expt_access_fault_extra;
    st_da_expt_access_fault_mmu       <=  mmu_lsu_access_fault1;
    st_da_split                   <=  st_dc_split;
    st_da_sync_fence              <=  st_dc_sync_fence;
    st_da_icc                     <=  st_dc_icc;
    st_da_inst_type[1:0]          <=  st_dc_inst_type[1:0];
    st_da_inst_mode[1:0]          <=  st_dc_inst_mode[1:0];
    st_da_inst_size[2:0]          <=  st_dc_inst_size[2:0];
    st_da_fence_mode[3:0]         <=  st_dc_fence_mode[3:0];
    st_da_st                      <=  st_dc_st;
    st_da_secd                    <=  st_dc_secd;
    st_da_atomic                  <=  st_dc_atomic;
    st_da_iid[6:0]                <=  st_dc_iid[6:0];
    st_da_lsid[LSIQ_ENTRY-1:0]    <=  st_dc_lsid[LSIQ_ENTRY-1:0];
    st_da_old                     <=  st_dc_old;
    st_da_boundary                <=  st_dc_boundary;
    st_da_spec_fail               <=  st_dc_spec_fail;
    st_da_bkpta_data              <=  st_dc_bkpta_data;
    st_da_bkptb_data              <=  st_dc_bkptb_data;
    st_da_page_so                 <=  st_dc_da_page_so;
    st_da_page_ca                 <=  st_dc_da_page_ca;
    st_da_page_wa                 <=  st_dc_da_page_wa;
    st_da_page_buf                <=  st_dc_da_page_buf;
    st_da_page_sec                <=  st_dc_da_page_sec;
    st_da_page_share              <=  st_dc_da_page_share;
    st_da_already_da              <=  st_dc_already_da;
    st_da_no_spec                 <=  st_dc_no_spec;
    st_da_bytes_vld[15:0]         <=  st_dc_bytes_vld[15:0];
    st_da_pc[PC_LEN-1:0]          <=  st_dc_pc[PC_LEN-1:0];
    st_da_pfu_va[`PA_WIDTH-1:0]   <=  st_dc_pfu_va[`PA_WIDTH-1:0];           
    st_da_pf_inst                 <=  st_dc_pf_inst;
    st_da_vector_nop              <=  st_dc_vector_nop;
  end
end

//------------------inst/borrow share part------------------
//+-------+
//| addr0 |
//+-------+
//+--------------+----------------+----------------+
//| dcwp_hit_idx | dcwp_dirty_din | dcwp_dirty_wen |
//+--------------+----------------+----------------+
always @(posedge st_da_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_da_addr0[`PA_WIDTH-1:0]    <=  {`PA_WIDTH{1'b0}};
    st_da_dcwp_dc_hit_idx         <=  1'b0;
    st_da_dcwp_dc_dirty_din[6:0]  <=  7'b0;
    st_da_dcwp_dc_dirty_wen[6:0]  <=  7'b0;
  end
  else if((st_dc_inst_vld  ||  st_dc_borrow_vld) && !st_da_ecc_stall)
  begin
    st_da_addr0[`PA_WIDTH-1:0]    <=  st_dc_addr0[`PA_WIDTH-1:0];
    st_da_dcwp_dc_hit_idx         <=  st_dc_dcwp_hit_idx;
    st_da_dcwp_dc_dirty_din[6:0]  <=  dcache_dirty_din[6:0];
    st_da_dcwp_dc_dirty_wen[6:0]  <=  dcache_dirty_wen[6:0];
  end
end

//==========================================================
//        Generate expt info
//==========================================================
assign st_da_expt_access_fault  = (st_da_mmu_req
                                          &&  st_da_expt_access_fault_mmu
                                      ||  st_da_expt_access_fault_extra)
                                  &&  !st_da_expt_access_fault_mask;

assign st_da_expt_vld = (st_da_expt_vld_except_access_err
                         ||  st_da_expt_access_fault
                         ||  st_da_ecc_stall_fatal)
                        && !st_da_vector_nop;

assign st_da_wb_expt_vld = (st_da_expt_vld_except_access_err
                               ||  st_da_expt_access_fault)
                           && !st_da_vector_nop;

// &CombBeg; @448
always @( st_da_expt_access_fault
       or st_da_mt_value[63:0]
       or st_da_st
       or st_da_expt_vec[14:0])
begin
st_da_wb_expt_vec[14:0]  = st_da_expt_vec[14:0];

st_da_wb_mt_value[PC_WIDTH-1:0]  = st_da_mt_value[PC_WIDTH-1:0];
if(st_da_expt_access_fault &&  !st_da_st)
begin
  st_da_wb_expt_vec[14:0]  = 15'd5;
  st_da_wb_mt_value[PC_WIDTH-1:0]  = {PC_WIDTH{1'b0}};
end
else if(st_da_expt_access_fault &&  st_da_st)
begin
  st_da_wb_expt_vec[14:0]  = 15'd7;
  st_da_wb_mt_value[PC_WIDTH-1:0]  = {PC_WIDTH{1'b0}};
end
// &CombEnd; @462
end

assign st_da_wb_vstart_vld = 1'b0;
//==========================================================
//        Generate inst type
//==========================================================
//st/str/push/srs is treated as st inst
// &Force("output","st_da_sync_inst"); @478
assign st_da_sync_inst    = st_da_sync_fence
                            &&  !st_da_atomic
                            &&  (st_da_inst_type[1:0] ==  2'b00);
// &Force("output","st_da_fence_inst"); @482
assign st_da_fence_inst   = st_da_sync_fence
                            &&  !st_da_atomic
                            &&  (st_da_inst_type[1:0] ==  2'b01);
assign st_da_ctc_inst     = st_da_icc
                            &&  !st_da_atomic
                            &&  (st_da_inst_type[1:0] !=  2'b10);
assign st_da_dcache_inst  = st_da_icc
                            &&  !st_da_atomic
                            &&  (st_da_inst_type[1:0] ==  2'b10);

assign st_da_l2cache_inst = st_da_icc
                            &&  !st_da_atomic
                            &&  (st_da_inst_type[1:0] ==  2'b11);
assign st_da_st_inst      = !st_da_icc
                            &&  !st_da_atomic
                            &&  !st_da_sync_fence
                            &&  (st_da_inst_type[1:0] ==  2'b00);
assign st_da_dcache_sw_inst     = st_da_dcache_inst
                                  &&  (st_da_inst_mode[1:0] ==  2'b10);
assign st_da_dcache_pa_inst     = st_da_dcache_inst
                                  &&  (st_da_inst_mode[1:0] ==  2'b11);
assign st_da_dcache_va_inst     = st_da_dcache_inst
                                  &&  (st_da_inst_mode[1:0] ==  2'b01);
assign st_da_dcache_1line_inst  = st_da_dcache_sw_inst
                                  ||  st_da_dcache_pa_inst
                                  ||  st_da_dcache_va_inst;

//assign st_da_stex_inst    = st_da_inst_vld
//                            &&  st_da_atomic;

//==========================================================
//              Compare tag and select data
//==========================================================
//------------------compare tag-----------------------------
assign st_da_dcache_sw_sel  = st_da_inst_vld
                                  &&  st_da_dcache_sw_inst
                              ||  st_da_borrow_vld
                                  &&  st_da_borrow_dcache_sw;

//if dcache sw inst, then hit_way is static as addr[31]
assign st_da_dcache_sw_way1 = st_da_addr0[31];

assign st_da_dcache_info_vld= st_da_inst_vld  &&  st_da_page_ca
                              ||  st_da_borrow_vld;

assign st_da_dcache_valid0  = st_da_dcache_dirty_array[0]
                              &&  cp0_lsu_dcache_en
                              &&  st_da_dcache_info_vld;
assign st_da_dcache_valid1  = st_da_dcache_dirty_array[3]
                              &&  cp0_lsu_dcache_en
                              &&  st_da_dcache_info_vld;

assign st_da_hit_way0       = st_da_dcache_valid0
                              &&  (!st_da_dcache_sw_sel
                                      &&  st_da_tag0_hit
                                  ||  st_da_dcache_sw_sel
                                      &&  !st_da_dcache_sw_way1);
assign st_da_hit_way1       = st_da_dcache_valid1
                              &&  (!st_da_dcache_sw_sel
                                      &&  st_da_tag1_hit
                                  ||  st_da_dcache_sw_sel
                                      &&  st_da_dcache_sw_way1);

// &Force("output","st_da_dcache_hit"); @546
assign st_da_dcache_hit     = st_da_hit_way0  ||  st_da_hit_way1;
// &Force("output","st_da_dcache_miss"); @548
assign st_da_dcache_miss    = !st_da_dcache_hit;

//select cache hit info
assign st_da_dcache_dirty_hit_info[2:0] = 
                {3{st_da_hit_way0}} & st_da_dcache_dirty_array[2:0]
                | {3{st_da_hit_way1}} & st_da_dcache_dirty_array[5:3];

//------output dcache info for inst/snq/vb rcl(inst/icc)-------
assign st_da_dcache_dirty         = st_da_dcache_dirty_hit_info[2];
// &Force("output","st_da_dcache_way"); @558
assign st_da_dcache_way           = st_da_dcache_sw_sel
                                    ? st_da_dcache_sw_way1
                                    : st_da_hit_way1;

//---------output dcache info for vb rcl line replace-------
// &Force("output","st_da_dcache_replace_way"); @564
//if dcache hit, then cover this dcache line in atomic instruction
assign st_da_dcache_replace_way   = st_da_dcache_hit
                                    ? st_da_hit_way1
                                    : st_da_dcache_dirty_array[6];
assign st_da_dcache_replace_dirty = st_da_dcache_replace_way
                                    ? st_da_dcache_dirty_array[5]
                                    : st_da_dcache_dirty_array[2];
//assign st_da_dcache_replace_share = st_da_dcache_replace_way
//                                    ? st_da_dcache_dirty_array[4]
//                                    : st_da_dcache_dirty_array[1];
assign st_da_dcache_replace_valid = st_da_dcache_replace_way
                                    ? st_da_dcache_dirty_array[3]
                                    : st_da_dcache_dirty_array[0];

//------------------feedback addr to vb---------------------
//if dcache_sw inst, it must give addr to vb to generate a write request
assign st_da_feedback_sel_tag_way1  =
                st_da_dcache_replace_way  &&  st_da_borrow_dcache_replace
                ||  st_da_dcache_sw_way1  &&  st_da_borrow_dcache_sw;

assign st_da_feedback_sel_tag       = st_da_borrow_dcache_replace
                                      ||  st_da_borrow_dcache_sw;
// &CombBeg; @587
always @( st_da_addr0[39:14]
       or st_da_feedback_sel_tag
       or st_da_dcache_tag_array[51:0]
       or st_da_feedback_sel_tag_way1)
begin
st_da_vb_feedback_addr_tto14[25:0]  = st_da_addr0[`PA_WIDTH-1:14];
case({st_da_feedback_sel_tag,st_da_feedback_sel_tag_way1})
  2'b10:st_da_vb_feedback_addr_tto14[25:0]  = st_da_dcache_tag_array[25:0];
  2'b11:st_da_vb_feedback_addr_tto14[25:0]  = st_da_dcache_tag_array[51:26];
  default:st_da_vb_feedback_addr_tto14[25:0]  = st_da_addr0[`PA_WIDTH-1:14];
endcase
// &CombEnd; @594
end

//---------------feedback dirty info to snq-----------------
assign st_da_snq_dcache_dirty_hit_info[2:0] = 
                {3{st_da_tag0_hit}} & st_da_dcache_dirty_array[2:0]
                | {3{st_da_tag1_hit}} & st_da_dcache_dirty_array[5:3];

assign st_da_snq_dcache_valid = st_da_snq_dcache_dirty_hit_info[0]
                                &&  cp0_lsu_dcache_en;
assign st_da_snq_dcache_share = st_da_snq_dcache_dirty_hit_info[1];
assign st_da_snq_dcache_dirty = st_da_snq_dcache_dirty_hit_info[2];
assign st_da_snq_dcache_way   = st_da_dcache_dirty_array[3]
                                &&  st_da_tag1_hit;

//==========================================================
//          Dirty array update da stage for sq
//==========================================================
//when inst is in dc stage, then only dcache dirty array may be changed
//when inst is in da stage, then tag & dirty array may be changed
//-------update dirty info if index hit in dc stage---------
assign st_da_dirty_dc_update[6:0]       = {7{st_da_dcwp_dc_hit_idx}}
                                          & st_da_dcwp_dc_dirty_wen[6:0];

assign st_da_dirty_dc_update_dout[6:0]  =
                st_da_dirty_dc_update[6:0] & st_da_dcwp_dc_dirty_din[6:0]
                | (~st_da_dirty_dc_update[6:0])  & st_da_dcache_dirty_array[6:0];

//select cache hit info
assign st_da_dcache_dirty_dc_up_hit_info[2:0] =
                {3{st_da_hit_way0}} & st_da_dirty_dc_update_dout[2:0]
                | {3{st_da_hit_way1}} & st_da_dirty_dc_update_dout[5:3];

assign st_da_dcache_dc_up_dirty         = st_da_dcache_dirty_dc_up_hit_info[2];
assign st_da_dcache_dc_up_share         = st_da_dcache_dirty_dc_up_hit_info[1];
assign st_da_dcache_dc_up_valid         = st_da_dcache_dirty_dc_up_hit_info[0];
assign st_da_dcache_dc_up_way           = st_da_dcache_way;

//-------------update dcache info in da stage---------------
// &Instance("ct_lsu_dcache_info_update","x_lsu_st_da_dcache_info_update"); @634
ct_lsu_dcache_info_update  x_lsu_st_da_dcache_info_update (
  .compare_dcwp_addr        (st_da_addr0[39:0]       ),
  .compare_dcwp_hit_idx     (st_da_dcache_hit_idx    ),
  .compare_dcwp_sw_inst     (st_da_dcache_sw_inst    ),
  .compare_dcwp_update_vld  (st_da_dcache_update_vld ),
  .dcache_dirty_din         (dcache_dirty_din        ),
  .dcache_dirty_gwen        (dcache_dirty_gwen       ),
  .dcache_dirty_wen         (dcache_dirty_wen        ),
  .dcache_idx               (dcache_idx              ),
  .dcache_tag_din           (dcache_tag_din          ),
  .dcache_tag_gwen          (dcache_tag_gwen         ),
  .dcache_tag_wen           (dcache_tag_wen          ),
  .origin_dcache_dirty      (st_da_dcache_dc_up_dirty),
  .origin_dcache_share      (st_da_dcache_dc_up_share),
  .origin_dcache_valid      (st_da_dcache_dc_up_valid),
  .origin_dcache_way        (st_da_dcache_dc_up_way  ),
  .update_dcache_dirty      (st_da_sq_dcache_dirty   ),
  .update_dcache_share      (st_da_sq_dcache_share   ),
  .update_dcache_valid      (st_da_sq_dcache_valid   ),
  .update_dcache_way        (st_da_sq_dcache_way     )
);

// &Connect( .compare_dcwp_addr          (st_da_addr0[`PA_WIDTH-1:0]   ), @635
//           .compare_dcwp_sw_inst       (st_da_dcache_sw_inst), @636
//           .origin_dcache_valid        (st_da_dcache_dc_up_valid ), @637
//           .origin_dcache_share        (st_da_dcache_dc_up_share ), @638
//           .origin_dcache_dirty        (st_da_dcache_dc_up_dirty ), @639
//           .origin_dcache_way          (st_da_dcache_dc_up_way   ), @640
//           .compare_dcwp_update_vld    (st_da_dcache_update_vld  ), @641
//           .compare_dcwp_hit_idx       (st_da_dcache_hit_idx     ), @642
//           .update_dcache_valid        (st_da_sq_dcache_valid    ), @643
//           .update_dcache_share        (st_da_sq_dcache_share    ), @644
//           .update_dcache_dirty        (st_da_sq_dcache_dirty    ), @645
//           .update_dcache_way          (st_da_sq_dcache_way      )); @646

// &Force("nonport","st_da_dcache_update_vld"); @648
// &Force("nonport","st_da_dcache_hit_idx"); @649
// &Force("output","st_da_sq_dcache_valid"); @650
// &Force("output","st_da_sq_dcache_share"); @651
// &Force("output","st_da_sq_dcache_dirty"); @652

//==========================================================
//        Generage commit signal
//==========================================================
assign st_da_cmit_hit0  = {rtu_yy_xx_commit0,rtu_yy_xx_commit0_iid[6:0]}
                          ==  {1'b1,st_da_iid[6:0]};
assign st_da_cmit_hit1  = {rtu_yy_xx_commit1,rtu_yy_xx_commit1_iid[6:0]}
                          ==  {1'b1,st_da_iid[6:0]};
assign st_da_cmit_hit2  = {rtu_yy_xx_commit2,rtu_yy_xx_commit2_iid[6:0]}
                          ==  {1'b1,st_da_iid[6:0]};

assign st_da_rb_cmit    = st_da_cmit_hit0
                          ||  st_da_cmit_hit1
                          ||  st_da_cmit_hit2;

//==========================================================
//        Request read buffer & Compare index & discard
//==========================================================
//----------in mem copy mode, then it won't request rb------
assign st_da_rb_page_wa = st_da_page_wa &&  !amr_wa_cancel;
//------------------origin create read buffer---------------
//-----------create 1-------------------
//st/push/srs: cache miss, cacheable

assign st_da_page_ca_dcache_en      = st_da_page_ca &&  cp0_lsu_dcache_en;

assign st_da_rb_create_vld_unmask   = st_da_inst_vld
                                      &&  !st_da_vector_nop
                                      &&  !st_da_expt_vld
                                      &&  !st_da_ecc_stall_already
                                      &&  (st_da_st_inst  
                                              &&  st_da_page_ca_dcache_en
                                              &&  st_da_rb_page_wa
                                              &&  st_da_dcache_miss
                                          ||  st_da_sync_fence
                                              &&  !st_da_atomic
                                              &&  !lsu_has_fence);

//------------------index hit/discard grnt signal-----------
//addr is used to compare index, so addr0 is enough
assign st_da_addr[`PA_WIDTH-1:0]  = st_da_addr0[`PA_WIDTH-1:0];

//------------------create read buffer info-----------------
// &Force("output","st_da_rb_create_vld"); @696
assign st_da_rb_create_vld          = st_da_rb_create_vld_unmask
                                      &&  !st_da_ecc_stall
                                      &&  (!ld_da_st_da_hit_idx
                                              &&  !rb_st_da_hit_idx
                                              &&  !lfb_st_da_hit_idx
                                              &&  !lm_st_da_hit_idx
                                          ||  st_da_sync_fence
                                              &&  !st_da_atomic);
// &Force("output","st_da_rb_create_dp_vld"); @705
assign st_da_rb_create_dp_vld       = st_da_rb_create_vld_unmask;
// &Force("output","st_da_rb_create_gateclk_en"); @707
assign st_da_rb_create_gateclk_en   = st_da_rb_create_vld_unmask;

//-----------rb create signal-----------
//this inst will request lfb addr entry in rb
assign st_da_rb_create_lfb          = st_da_st_inst;

//==========================================================
//        Compare index
//==========================================================
//------------------compare pfu-----------------------------
assign st_da_cmp_pfu_biu_req_addr[`PA_WIDTH-1:0]= pfu_biu_req_addr[`PA_WIDTH-1:0];
assign st_da_pfu_biu_req_hit_idx  = st_da_rb_create_vld_unmask
                                    &&  (st_da_addr0[13:6]
                                        ==  st_da_cmp_pfu_biu_req_addr[13:6]);

//==========================================================
//        Restart signal
//==========================================================
assign st_da_rb_full_vld          = st_da_rb_create_vld_unmask
                                    &&  !st_da_ecc_stall
                                    &&  rb_st_da_full;
assign st_da_rb_full_gateclk_en   = st_da_rb_create_gateclk_en
                                    &&  rb_st_da_full;
assign st_da_wait_fence_vld       = st_da_inst_vld
                                    &&  (st_da_fence_inst ||  st_da_sync_inst)
                                    &&  lsu_has_fence;
assign st_da_wait_fence_gateclk_en  = st_da_wait_fence_vld;
assign st_da_restart_vld          = st_da_rb_full_vld ||  st_da_wait_fence_vld;

//==========================================================
//                    ECC handling
//==========================================================
// &Force("bus","dcache_lsu_st_dirty_dout",20,0); @754
// &Instance("ct_lsu_29bit_2stage_ecc_decode","x_ct_lsu_29bit_2stage_ecc_decode_w0"); @762
// &Connect(.data_decode    (w0_tag_bf_ecc[35:0]        ),   @763
//          .stage_dp_clk   (st_da_clk                  ),  @764
//          .ecc_stage_vld  (tag_ecc_pipe_down          ),  @765
//          .ham_error      (w0_tag_ham_error           ),  @766
//          .parity_error   (w0_tag_parity_error        ),  @767
//          .corrected_data (w0_tag_corrected[28:0]     )  @768
//         ); @769
// &Instance("ct_lsu_29bit_2stage_ecc_decode","x_ct_lsu_29bit_2stage_ecc_decode_w1"); @771
// &Connect(.data_decode    (w1_tag_bf_ecc[35:0]        ),   @772
//          .stage_dp_clk   (st_da_clk                  ),  @773
//          .ecc_stage_vld  (tag_ecc_pipe_down          ),  @774
//          .ham_error      (w1_tag_ham_error           ),  @775
//          .parity_error   (w1_tag_parity_error        ),  @776
//          .corrected_data (w1_tag_corrected[28:0]     )  @777
//         ); @778
// //&Force("output","st_da_snq_tag_reissue"); @829
assign st_da_tag_ecc_stall      = 1'b0;
assign st_da_tag_ecc_stall_gate = 1'b0;
assign st_da_ecc_stall          = 1'b0;
assign st_da_vb_tag_reissue     = 1'b0;
//assign st_da_snq_tag_reissue    = 1'b0;
assign st_da_vb_ecc_stall       = 1'b0;
assign st_da_vb_ecc_err         = 1'b0;
assign st_da_snq_ecc_err        = 1'b0;

assign st_da_ecc_wakeup[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{1'b0}};

//==========================================================
//        Generage to SQ signal
//==========================================================
assign st_da_sq_ecc_stall         = st_da_ecc_stall || st_da_ecc_stall_dcache_update;

assign st_da_sq_no_restart        = st_da_inst_vld
                                    &&  !st_da_restart_vld;
//==========================================================
//        Generage interface to prefetch buffer
//==========================================================
// &Force("output","st_da_pfu_pf_inst_vld"); @909
assign st_da_pfu_pf_inst_vld      = st_da_inst_vld
                                    &&  st_da_pf_inst
                                    &&  !st_da_already_da
                                    &&  !st_da_expt_vld;

assign st_da_boundary_cross_2k    = st_da_pfu_va[11]
                                    !=  st_da_addr0[11];
//if cache miss and not hit idx, then it can create pmb
assign st_da_pfu_act_vld          = st_da_inst_vld
                                    &&  st_da_pf_inst
                                    &&  !st_da_expt_vld
                                    &&  (st_da_rb_create_vld || st_da_split_miss_ff)
                                    &&  st_da_rb_page_wa
                                    &&  st_da_dcache_miss
                                    &&  !st_da_boundary_cross_2k;//cross 4k condition will get wrong ppn

assign st_da_pfu_act_dp_vld       = st_da_inst_vld
                                    &&  st_da_pf_inst
                                    &&  !st_da_expt_vld
                                    &&  st_da_rb_page_wa
                                    &&  st_da_dcache_miss
                                    &&  !st_da_boundary_cross_2k;//cross 4k condition will get wrong ppn

//for evict count
assign st_da_pfu_evict_cnt_vld    = st_da_pfu_pf_inst_vld;

//st prefetch does not support gpfb
assign st_da_ppfu_va[`PA_WIDTH-1:0] = st_da_pfu_va[`PA_WIDTH-1:0];
//==========================================================
//                Flop for st_da
//==========================================================
assign st_da_ff_clk_en  = st_da_inst_vld
                          && st_da_st_inst
                          && cp0_lsu_l2_st_pref_en;
// &Instance("gated_clk_cell", "x_lsu_st_da_ff_gated_clk"); @944
gated_clk_cell  x_lsu_st_da_ff_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_da_ff_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (st_da_ff_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @945
//          .external_en   (1'b0               ), @946
//          .global_en     (1'b1               ), @947
//          .module_en     (cp0_lsu_icg_en     ), @948
//          .local_en      (st_da_ff_clk_en    ), @949
//          .clk_out       (st_da_ff_clk       )); @950

always @(posedge st_da_ff_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_da_ppn_ff[`PA_WIDTH-13:0]  <=  {`PA_WIDTH-12{1'b0}};
    st_da_page_sec_ff             <=  1'b0;
    st_da_page_share_ff           <=  1'b0;
  end
  else if(st_da_inst_vld && st_da_st_inst)
  begin
    st_da_ppn_ff[`PA_WIDTH-13:0]  <=  st_da_addr0[`PA_WIDTH-1:12];
    st_da_page_sec_ff             <=  st_da_page_sec;
    st_da_page_share_ff           <=  st_da_page_share;
  end
end

//for preload
//when split load cache miss,record
assign st_da_split_miss = st_da_inst_vld
                          && st_da_st_inst
                          && st_da_page_ca
                          && cp0_lsu_dcache_en
                          && st_da_split
                          && !st_da_secd
                          && !st_da_expt_vld
                          && st_da_rb_create_vld;

assign st_da_split_last = st_da_inst_vld
                          && st_da_st_inst
                          && !st_da_split;

always @(posedge st_da_ff_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_da_split_miss_ff           <=  1'b0;
  else if(st_da_split_miss)
    st_da_split_miss_ff           <=  1'b1;
  else if(st_da_split_last)
    st_da_split_miss_ff           <=  1'b0;
end

//==========================================================
//        Generage to WB stage signal
//==========================================================
//------------------write back cmplt part request-----------
assign st_da_wb_cmplt_req     = st_da_inst_vld
                                &&  !st_da_restart_vld
                                &&  !st_da_ecc_stall
                                &&  !st_da_ecc_stall_dcache_update
                                &&  !st_da_boundary_first
                                &&  (st_da_wb_expt_vld
                                    ||  st_da_vector_nop
                                    ||  (st_da_ctc_inst
                                        ||  st_da_dcache_1line_inst
                                        ||  st_da_l2cache_inst
                                        ||  st_da_st_inst &&  !st_da_page_so));
//------------------other signal---------------------------
assign st_da_wb_spec_fail     = st_da_spec_fail
                                &&  !st_da_split;

//==========================================================
//        Generate interface to borrow module
//==========================================================
assign st_da_borrow_snq_vld                 = st_da_borrow_vld
                                              &&  st_da_borrow_snq
                                              &&  !st_da_ecc_stall;
assign st_da_snq_borrow_snq[SNQ_ENTRY-1:0]  = {SNQ_ENTRY{st_da_borrow_snq_vld}}
                                              & st_da_borrow_snq_id[SNQ_ENTRY-1:0];

assign st_da_borrow_icc_vld                 = st_da_borrow_vld
                                              &&  st_da_borrow_icc;
assign st_da_icc_dirty_info[2:0]            = st_da_dcache_sw_sel
                                              ? st_da_dcache_dirty_array[5:3]
                                              : st_da_dcache_dirty_array[2:0];
assign st_da_icc_tag_info[25:0]             = st_da_dcache_sw_sel
                                              ? st_da_dcache_tag_array[51:26]
                                              : st_da_dcache_tag_array[25:0];

//==========================================================
//        Generate lsiq signal
//==========================================================
assign st_da_mask_lsid[LSIQ_ENTRY-1:0]      = {LSIQ_ENTRY{st_da_inst_vld}}
                                              & st_da_lsid[LSIQ_ENTRY-1:0];

assign st_da_boundary_first                 = st_da_boundary
                                              &&  !st_da_expt_vld
                                              &&  !st_da_secd;
//-----------lsiq signal----------------
// &Force("output","st_da_ecc_wakeup"); @1045
//for avoid dc vector nop from wakeup sdiq multiple times.use already_da as
//symbol signal, here set already_da ahead for dc replay inst by da ecc stall
//
//note already_da is only used for performance in da stage,hence not accurate
//here is fine
assign st_da_idu_already_da[LSIQ_ENTRY-1:0] = st_da_mask_lsid[LSIQ_ENTRY-1:0]
                                              | st_da_ecc_wakeup[LSIQ_ENTRY-1:0];

assign st_da_idu_rb_full[LSIQ_ENTRY-1:0]    = {LSIQ_ENTRY{st_da_rb_full_vld}}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];

assign st_da_idu_wait_fence[LSIQ_ENTRY-1:0]   = {LSIQ_ENTRY{st_da_wait_fence_vld}}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];

// &Force("output","st_da_idu_pop_vld"); @1060
assign st_da_idu_pop_vld                    = st_da_inst_vld
                                              &&  !st_da_boundary_first
                                              &&  !st_da_tag_ecc_stall
                                              &&  !st_da_ecc_stall_dcache_update
                                              &&  !st_da_restart_vld;
assign st_da_idu_pop_entry[LSIQ_ENTRY-1:0]  = {LSIQ_ENTRY{st_da_idu_pop_vld}}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];

assign st_da_idu_spec_fail[LSIQ_ENTRY-1:0]  = {LSIQ_ENTRY{st_da_spec_fail
                                                          &&  st_da_boundary_first }}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];
assign st_da_idu_bkpta_data[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{st_da_bkpta_data
                                                          &&  st_da_boundary_first}}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];
assign st_da_idu_bkptb_data[LSIQ_ENTRY-1:0] = {LSIQ_ENTRY{st_da_bkptb_data
                                                          &&  st_da_boundary_first}}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];
            
//---------boundary gateclk-------------
assign st_da_idu_boundary_gateclk_vld       = st_da_inst_vld
                                              &&  st_da_boundary_first;

assign st_da_idu_boundary_gateclk_en[LSIQ_ENTRY-1:0]  = 
                {LSIQ_ENTRY{st_da_idu_boundary_gateclk_vld}}
                & st_da_mask_lsid[LSIQ_ENTRY-1:0];

//-----------imme wakeup----------------
assign st_da_idu_secd_vld                   = st_da_inst_vld
                                              &&  st_da_boundary_first
                                              &&  !st_da_tag_ecc_stall
                                              &&  !st_da_ecc_stall_dcache_update
                                              &&  !st_da_restart_vld;

assign st_da_idu_secd[LSIQ_ENTRY-1:0]       = {LSIQ_ENTRY{st_da_idu_secd_vld}}
                                              & st_da_mask_lsid[LSIQ_ENTRY-1:0];
//==========================================================
//        interface for spec_fail prediction
//==========================================================
assign st_da_no_spec_miss = st_da_inst_vld
                            && cp0_lsu_nsfe
//                            && !st_da_no_spec 
                            && !st_da_atomic
                            && st_da_spec_fail; 

assign st_da_sf_no_spec_miss         = st_da_no_spec_miss
                                       && !st_da_restart_vld;
assign st_da_sf_no_spec_miss_gate    = st_da_no_spec_miss;
assign st_da_sf_iid[6:0]             = st_da_iid[6:0];

assign st_da_sf_addr_tto4[`PA_WIDTH-5:0]  = st_da_addr0[`PA_WIDTH-1:4];
assign st_da_sf_bytes_vld[15:0]           = st_da_bytes_vld[15:0];

assign st_da_no_spec_hit  = st_da_inst_vld
                            && cp0_lsu_nsfe
                            && st_da_no_spec 
                            && !st_da_spec_fail; 

assign st_da_no_spec_mispred = st_da_inst_vld
                               && cp0_lsu_nsfe
                               && st_da_no_spec 
                               && st_da_spec_fail; 

//wb_cmplt
assign st_da_wb_no_spec_miss     = st_da_no_spec_miss && !st_da_no_spec;
assign st_da_wb_no_spec_hit      = st_da_no_spec_hit;
assign st_da_wb_no_spec_mispred  = st_da_no_spec_mispred;


//for spec mispred check
assign st_da_sf_spec_chk  = st_da_inst_vld
                            && cp0_lsu_nsfe
                            && !st_da_restart_vld
                            && !st_da_spec_fail
                            && st_da_no_spec;

assign st_da_sf_spec_chk_gate = st_da_inst_vld
                                && cp0_lsu_nsfe
                                && st_da_no_spec;
//==========================================================
//        Generate interface to rtu
//==========================================================
assign lsu_rtu_da_pipe4_split_spec_fail_vld = st_da_inst_vld
                                              &&  !st_da_expt_vld
                                              &&  st_da_split
                                              &&  st_da_spec_fail;
assign lsu_rtu_da_pipe4_split_spec_fail_iid[6:0]  = st_da_iid[6:0];
//==========================================================
//        interface to hpcp
//==========================================================
assign lsu_hpcp_st_cache_access = st_da_inst_vld
                                  &&  st_da_st_inst
                                  && st_da_page_ca_dcache_en
                                  && !st_da_already_da;
assign lsu_hpcp_st_cache_miss   = st_da_inst_vld
                                  &&  st_da_st_inst
                                  &&  st_da_page_ca_dcache_en
                                  &&  st_da_dcache_miss
                                  &&  !st_da_restart_vld
                                  &&  st_da_rb_create_vld;
assign lsu_hpcp_st_unalign_inst = st_da_inst_vld
                                  &&  !st_da_already_da
                                  &&  st_da_secd;
// &Force("nonport","st_da_already_da"); @1165
// &ModuleEnd; @1167
endmodule


