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
module ct_lsu_rb_entry (
  // &Ports, @28
  input    wire  [4  :0]  biu_lsu_b_id,
  input    wire           biu_lsu_b_vld,
  input    wire  [127:0]  biu_lsu_r_data_mask,
  input    wire  [4  :0]  biu_lsu_r_id,
  input    wire           biu_lsu_r_vld,
  input    wire           cp0_lsu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire  [1  :0]  cp0_yy_priv_mode,
  input    wire           cpurst_b,
  input    wire  [39 :0]  ld_da_addr,
  input    wire           ld_da_bkpta_data,
  input    wire           ld_da_bkptb_data,
  input    wire           ld_da_boundary_after_mask,
  input    wire  [15 :0]  ld_da_bytes_vld,
  input    wire  [63 :0]  ld_da_data_ori,
  input    wire  [7  :0]  ld_da_data_rot_sel,
  input    wire           ld_da_dcache_hit,
  input    wire  [7  :0]  ld_da_idx,
  input    wire  [6  :0]  ld_da_iid,
  input    wire  [2  :0]  ld_da_inst_size,
  input    wire           ld_da_inst_vfls,
  input    wire           ld_da_mcic_borrow_mmu,
  input    wire           ld_da_page_buf,
  input    wire           ld_da_page_ca,
  input    wire           ld_da_page_sec,
  input    wire           ld_da_page_share,
  input    wire           ld_da_page_so,
  input    wire  [6  :0]  ld_da_preg,
  input    wire           ld_da_rb_atomic,
  input    wire           ld_da_rb_cmit,
  input    wire           ld_da_rb_cmplt_success,
  input    wire           ld_da_rb_create_lfb,
  input    wire           ld_da_rb_data_vld,
  input    wire           ld_da_rb_dest_vld,
  input    wire           ld_da_rb_discard_grnt,
  input    wire           ld_da_rb_ldamo,
  input    wire           ld_da_rb_merge_dp_vld,
  input    wire           ld_da_rb_merge_expt_vld,
  input    wire           ld_da_rb_merge_gateclk_en,
  input    wire           ld_da_rb_merge_vld,
  input    wire           ld_da_sign_extend,
  input    wire  [5  :0]  ld_da_vreg,
  input    wire           ld_da_vreg_sign_sel,
  input    wire           lm_already_snoop,
  input    wire           lsu_has_fence,
  input    wire           lsu_special_clk,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [39 :0]  pfu_biu_req_addr,
  input    wire  [4  :0]  rb_biu_ar_id,
  input    wire           rb_create_ptr0_x,
  input    wire           rb_entry_biu_id_gateclk_en_x,
  input    wire           rb_entry_biu_pe_req_grnt_x,
  input    wire           rb_entry_ld_create_dp_vld_x,
  input    wire           rb_entry_ld_create_gateclk_en_x,
  input    wire           rb_entry_ld_create_vld_x,
  input    wire           rb_entry_next_nc_bypass_x,
  input    wire           rb_entry_next_so_bypass_x,
  input    wire           rb_entry_read_req_grnt_x,
  input    wire           rb_entry_st_create_dp_vld_x,
  input    wire           rb_entry_st_create_gateclk_en_x,
  input    wire           rb_entry_st_create_vld_x,
  input    wire           rb_entry_wb_cmplt_grnt_x,
  input    wire           rb_entry_wb_data_grnt_x,
  input    wire           rb_fence_ld,
  input    wire           rb_ld_biu_pe_req_grnt,
  input    wire           rb_r_resp_err,
  input    wire           rb_r_resp_okay,
  input    wire           rb_ready_all_req_biu_success,
  input    wire           rb_ready_ld_req_biu_success,
  input    wire           rtu_lsu_async_flush,
  input    wire           rtu_yy_xx_commit0,
  input    wire  [6  :0]  rtu_yy_xx_commit0_iid,
  input    wire           rtu_yy_xx_commit1,
  input    wire  [6  :0]  rtu_yy_xx_commit1_iid,
  input    wire           rtu_yy_xx_commit2,
  input    wire  [6  :0]  rtu_yy_xx_commit2_iid,
  input    wire           rtu_yy_xx_flush,
  input    wire  [39 :0]  sq_pop_addr,
  input    wire           sq_pop_page_ca,
  input    wire           sq_pop_page_so,
  input    wire  [39 :0]  st_da_addr,
  input    wire           st_da_dcache_hit,
  input    wire           st_da_fence_inst,
  input    wire  [3  :0]  st_da_fence_mode,
  input    wire  [6  :0]  st_da_iid,
  input    wire  [2  :0]  st_da_inst_size,
  input    wire           st_da_page_buf,
  input    wire           st_da_page_ca,
  input    wire           st_da_page_sec,
  input    wire           st_da_page_share,
  input    wire           st_da_page_so,
  input    wire           st_da_rb_cmit,
  input    wire           st_da_rb_create_lfb,
  input    wire           st_da_sync_inst,
  input    wire  [39 :0]  wmb_ce_addr,
  input    wire           wmb_ce_page_ca,
  input    wire           wmb_ce_page_so,
  input    wire           wmb_rb_so_pending,
  input    wire           wmb_sync_fence_biu_req_success,
  output   wire  [39 :0]  rb_entry_addr_v,
  output   wire           rb_entry_atomic_next_resp_x,
  output   wire           rb_entry_atomic_x,
  output   wire           rb_entry_biu_pe_req_gateclk_en_x,
  output   wire           rb_entry_biu_pe_req_x,
  output   wire           rb_entry_biu_req_x,
  output   wire           rb_entry_bkpta_data_x,
  output   wire           rb_entry_bkptb_data_x,
  output   wire           rb_entry_boundary_wakeup_x,
  output   wire           rb_entry_bus_err_x,
  output   wire           rb_entry_cmit_data_vld_x,
  output   wire           rb_entry_create_lfb_x,
  output   wire  [63 :0]  rb_entry_data_v,
  output   wire           rb_entry_depd_x,
  output   wire           rb_entry_discard_vld_x,
  output   wire           rb_entry_fence_ld_vld_x,
  output   wire           rb_entry_fence_x,
  output   wire           rb_entry_flush_clear_x,
  output   wire  [6  :0]  rb_entry_iid_v,
  output   wire  [2  :0]  rb_entry_inst_size_v,
  output   wire           rb_entry_inst_vfls_x,
  output   wire           rb_entry_ld_da_hit_idx_x,
  output   wire           rb_entry_ldamo_x,
  output   wire           rb_entry_mcic_req_x,
  output   wire           rb_entry_merge_fail_x,
  output   wire           rb_entry_page_buf_x,
  output   wire           rb_entry_page_ca_x,
  output   wire           rb_entry_page_sec_x,
  output   wire           rb_entry_page_share_x,
  output   wire           rb_entry_page_so_x,
  output   wire           rb_entry_pfu_biu_req_hit_idx_x,
  output   wire  [6  :0]  rb_entry_preg_v,
  output   wire  [1  :0]  rb_entry_priv_mode_v,
  output   wire  [7  :0]  rb_entry_rot_sel_v,
  output   wire           rb_entry_sign_extend_x,
  output   wire           rb_entry_sq_pop_hit_idx_x,
  output   wire           rb_entry_st_da_hit_idx_x,
  output   wire           rb_entry_st_x,
  output   wire  [3  :0]  rb_entry_state_v,
  output   wire           rb_entry_sync_fence_x,
  output   wire           rb_entry_sync_x,
  output   wire           rb_entry_vld_x,
  output   wire           rb_entry_vreg_sign_sel_x,
  output   wire  [5  :0]  rb_entry_vreg_v,
  output   wire           rb_entry_wb_cmplt_req_x,
  output   wire           rb_entry_wb_data_pre_sel_x,
  output   wire           rb_entry_wb_data_req_x,
  output   wire           rb_entry_wmb_ce_hit_idx_x
); 



// &Regs; @29
reg     [39 :0]  rb_entry_addr;                   
reg              rb_entry_atomic;                 
reg              rb_entry_biu_b_resp;             
reg     [4  :0]  rb_entry_biu_id;                 
reg              rb_entry_biu_pe_req_success;     
reg              rb_entry_biu_r_resp;             
reg              rb_entry_bkpta_data;             
reg              rb_entry_bkptb_data;             
reg              rb_entry_boundary;               
reg              rb_entry_boundary_depd;          
reg              rb_entry_bus_err;                
reg     [15 :0]  rb_entry_bytes_vld;              
reg              rb_entry_cmit;                   
reg              rb_entry_create_lfb;             
reg     [63 :0]  rb_entry_data;                   
reg              rb_entry_dcache_hit;             
reg              rb_entry_depd;                   
reg              rb_entry_dest_vld;               
reg              rb_entry_fence;                  
reg     [3  :0]  rb_entry_fence_mode;             
reg     [6  :0]  rb_entry_iid;                    
reg     [2  :0]  rb_entry_inst_size;              
reg              rb_entry_inst_vfls;              
reg              rb_entry_ldamo;                  
reg              rb_entry_mcic_req;               
reg     [3  :0]  rb_entry_next_state;             
reg              rb_entry_page_buf;               
reg              rb_entry_page_ca;                
reg              rb_entry_page_sec;               
reg              rb_entry_page_share;             
reg              rb_entry_page_so;                
reg     [6  :0]  rb_entry_preg;                   
reg     [1  :0]  rb_entry_priv_mode;              
reg     [7  :0]  rb_entry_rot_sel;                
reg              rb_entry_secd;                   
reg              rb_entry_sign_extend;            
reg              rb_entry_st;                     
reg     [3  :0]  rb_entry_state;                  
reg              rb_entry_sync;                   
reg     [5  :0]  rb_entry_vreg;                   
reg              rb_entry_vreg_sign_sel;          
reg              rb_entry_wb_cmplt_success;       
reg              rb_entry_wb_data_success;        

// &Wires; @30
wire             rb_create_ptr0;                  
wire             rb_entry_atomic_next_resp;       
wire             rb_entry_b_id_hit;               
wire             rb_entry_biu_b_resp_set;         
wire    [127:0]  rb_entry_biu_data_ori;           
wire    [63 :0]  rb_entry_biu_data_update;        
wire             rb_entry_biu_id_clk;             
wire             rb_entry_biu_id_clk_en;          
wire             rb_entry_biu_id_gateclk_en;      
wire             rb_entry_biu_pe_req;             
wire             rb_entry_biu_pe_req_gateclk_en;  
wire             rb_entry_biu_pe_req_grnt;        
wire             rb_entry_biu_r_resp_set;         
wire             rb_entry_biu_req;                
wire             rb_entry_biu_req_success;        
wire             rb_entry_boundary_depd_set;      
wire             rb_entry_boundary_wakeup;        
wire             rb_entry_bus_err_set;            
wire             rb_entry_clk;                    
wire             rb_entry_clk_en;                 
wire             rb_entry_cmit_data_not_vld;      
wire             rb_entry_cmit_hit0;              
wire             rb_entry_cmit_hit1;              
wire             rb_entry_cmit_hit2;              
wire             rb_entry_cmit_set;               
wire    [39 :0]  rb_entry_cmp_pfu_biu_req_addr;   
wire    [39 :0]  rb_entry_cmp_sq_pop_addr;        
wire    [39 :0]  rb_entry_cmp_wmb_ce_addr;        
wire             rb_entry_create_dp_vld;          
wire             rb_entry_create_up_clk;          
wire             rb_entry_create_up_clk_en;       
wire             rb_entry_create_vld;             
wire             rb_entry_create_wait_rdy;        
wire             rb_entry_data_bypass_vld;        
wire             rb_entry_data_clk;               
wire             rb_entry_data_clk_en;            
wire             rb_entry_data_merge_vld;         
wire             rb_entry_data_vld;               
wire             rb_entry_discard_vld;            
wire             rb_entry_fence_ld_vld;           
wire             rb_entry_fence_ready;            
wire             rb_entry_fence_resp_success;     
wire             rb_entry_flush_clear;            
wire             rb_entry_fof_bus_err_expt;       
wire             rb_entry_fof_not_first;          
wire             rb_entry_hit_fence_ld;           
wire             rb_entry_iid_hit;                
wire             rb_entry_ld_create_dp_vld;       
wire             rb_entry_ld_create_gateclk_en;   
wire             rb_entry_ld_create_vld;          
wire             rb_entry_ld_da_hit_idx;          
wire             rb_entry_ld_merge_dp_vld;        
wire             rb_entry_ld_merge_expt_vld;      
wire             rb_entry_ld_merge_gateclk_en;    
wire             rb_entry_ld_merge_pre;           
wire             rb_entry_ld_merge_vld;           
wire    [7  :0]  rb_entry_merge_bytes_vld;        
wire    [63 :0]  rb_entry_merge_data;             
wire    [63 :0]  rb_entry_merge_data_ori;         
wire    [63 :0]  rb_entry_merge_data_sel;         
wire             rb_entry_merge_fail;             
wire             rb_entry_merge_sel;              
wire             rb_entry_next_nc_bypass;         
wire             rb_entry_next_so_bypass;         
wire             rb_entry_not_sync_fence;         
wire             rb_entry_not_sync_fence_ready;   
wire             rb_entry_pfu_biu_req_hit_idx;    
wire             rb_entry_r_id_hit;               
wire             rb_entry_read_req_grnt;          
wire             rb_entry_ready_to_biu_req;       
wire             rb_entry_req_wb_success;         
wire             rb_entry_sq_pop_cmp_vld;         
wire             rb_entry_sq_pop_hit_idx;         
wire             rb_entry_st_create_dp_vld;       
wire             rb_entry_st_create_gateclk_en;   
wire             rb_entry_st_create_vld;          
wire             rb_entry_st_da_hit_idx;          
wire             rb_entry_sync_fence;             
wire             rb_entry_sync_fence_resp_success; 
wire             rb_entry_sync_ready;             
wire             rb_entry_sync_resp_success;      
wire             rb_entry_vld;                    
wire             rb_entry_wait_resp_imme_idle;    
wire             rb_entry_wait_resp_to_req_merge; 
wire             rb_entry_wb_cmplt_grnt;          
wire             rb_entry_wb_cmplt_req;           
wire             rb_entry_wb_data_grnt;           
wire             rb_entry_wb_data_pre_sel;        
wire             rb_entry_wb_data_req;            
wire             rb_entry_wb_data_req_pre;        
wire             rb_entry_wmb_ce_cmp_vld;         
wire             rb_entry_wmb_ce_hit_idx;         


//the state machine is devided to 2 part:
//before request biu: state[2] = 0
//after request biu:  state[2] = 1
parameter IDLE        = 4'b0000,
          WAIT_RDY    = 4'b1000,
          REQ_BIU     = 4'b1001,
          WAIT_RESP   = 4'b1100,
          REQ_WB      = 4'b1101,
          WAIT_MERGE  = 4'b1110;

parameter VMB_ENTRY         = 8;

parameter BYTE        = 2'b00,
          HALF        = 2'b01,
          WORD        = 2'b10,
          DWORD       = 2'b11;
//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//-----------entry gateclk--------------
//normal gateclk ,open when create || entry_vld
assign rb_entry_clk_en  = rb_entry_vld
                          ||  rb_entry_st_create_gateclk_en
                          ||  rb_entry_ld_create_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_rb_entry_gated_clk"); @56
gated_clk_cell  x_lsu_rb_entry_gated_clk (
  .clk_in             (lsu_special_clk   ),
  .clk_out            (rb_entry_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (rb_entry_clk_en   ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (lsu_special_clk     ), @57
//          .external_en   (1'b0               ), @58
//          .global_en     (cp0_yy_clk_en      ), @59
//          .module_en     (cp0_lsu_icg_en     ), @60
//          .local_en      (rb_entry_clk_en    ), @61
//          .clk_out       (rb_entry_clk       )); @62

//-----------create merge gateclk-------
assign rb_entry_create_up_clk_en  = rb_entry_ld_create_gateclk_en
                                    ||  rb_entry_st_create_gateclk_en
                                    ||  rb_entry_ld_merge_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_rb_entry_create_up_gated_clk"); @68
gated_clk_cell  x_lsu_rb_entry_create_up_gated_clk (
  .clk_in                    (lsu_special_clk          ),
  .clk_out                   (rb_entry_create_up_clk   ),
  .external_en               (1'b0                     ),
  .global_en                 (cp0_yy_clk_en            ),
  .local_en                  (rb_entry_create_up_clk_en),
  .module_en                 (cp0_lsu_icg_en           ),
  .pad_yy_icg_scan_en        (pad_yy_icg_scan_en       )
);

// &Connect(.clk_in        (lsu_special_clk     ), @69
//          .external_en   (1'b0               ), @70
//          .global_en     (cp0_yy_clk_en      ), @71
//          .module_en     (cp0_lsu_icg_en     ), @72
//          .local_en      (rb_entry_create_up_clk_en), @73
//          .clk_out       (rb_entry_create_up_clk)); @74

//-----------data gateclk---------------
//data gateclk, delete if the timing is bad
assign rb_entry_data_clk_en   = rb_entry_ld_create_gateclk_en
                                ||  rb_entry_ld_merge_gateclk_en
                                ||  rb_entry_data_bypass_vld;
// &Instance("gated_clk_cell", "x_lsu_rb_entry_data_gated_clk"); @81
gated_clk_cell  x_lsu_rb_entry_data_gated_clk (
  .clk_in               (lsu_special_clk     ),
  .clk_out              (rb_entry_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (rb_entry_data_clk_en),
  .module_en            (cp0_lsu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect(.clk_in        (lsu_special_clk     ), @82
//          .external_en   (1'b0               ), @83
//          .global_en     (cp0_yy_clk_en      ), @84
//          .module_en     (cp0_lsu_icg_en     ), @85
//          .local_en      (rb_entry_data_clk_en), @86
//          .clk_out       (rb_entry_data_clk)); @87

//----------biu_id gateclk--------------
assign rb_entry_biu_id_clk_en   = rb_entry_biu_id_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_rb_entry_biu_id_gated_clk"); @91
gated_clk_cell  x_lsu_rb_entry_biu_id_gated_clk (
  .clk_in                 (lsu_special_clk       ),
  .clk_out                (rb_entry_biu_id_clk   ),
  .external_en            (1'b0                  ),
  .global_en              (cp0_yy_clk_en         ),
  .local_en               (rb_entry_biu_id_clk_en),
  .module_en              (cp0_lsu_icg_en        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    )
);

// &Connect(.clk_in        (lsu_special_clk     ), @92
//          .external_en   (1'b0               ), @93
//          .global_en     (cp0_yy_clk_en      ), @94
//          .module_en     (cp0_lsu_icg_en     ), @95
//          .local_en      (rb_entry_biu_id_clk_en), @96
//          .clk_out       (rb_entry_biu_id_clk)); @97

//==========================================================
//                 Register
//==========================================================
//+-------+
//| state |
//+-------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_state[3:0]         <=  IDLE;
  else
    rb_entry_state[3:0]         <=  rb_entry_next_state[3:0];
end
assign rb_entry_vld             = rb_entry_state[3];
assign rb_entry_biu_req_success = rb_entry_state[2];

//+------+
//| cmit |
//+------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_cmit             <=  1'b0;
  else if(rb_entry_ld_create_dp_vld)
    rb_entry_cmit             <=  ld_da_rb_cmit;
  else if(rb_entry_st_create_dp_vld)
    rb_entry_cmit             <=  st_da_rb_cmit;
  else if(rb_entry_cmit_set)
    rb_entry_cmit             <=  1'b1;
end

//+-------------------------+
//| instruction information |
//+-------------------------+
always @(posedge rb_entry_create_up_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    rb_entry_mcic_req         <=  1'b0;
    rb_entry_addr[`PA_WIDTH-1:0]  <=  {`PA_WIDTH{1'b0}};
    rb_entry_bytes_vld[15:0]  <=  16'b0;
    rb_entry_iid[6:0]         <=  7'b0;
    rb_entry_fence_mode[3:0]  <=  4'b0;
    rb_entry_sign_extend      <=  1'b0;
    rb_entry_boundary         <=  1'b0;
    rb_entry_preg[6:0]        <=  7'b0;
    rb_entry_page_ca          <=  1'b0;
    rb_entry_page_so          <=  1'b0;
    rb_entry_page_sec         <=  1'b0;
    rb_entry_page_buf         <=  1'b0;
    rb_entry_page_share       <=  1'b0;
    rb_entry_sync             <=  1'b0;
    rb_entry_fence            <=  1'b0;
    rb_entry_atomic           <=  1'b0;
    rb_entry_ldamo            <=  1'b0;
    rb_entry_dcache_hit       <=  1'b0;
    rb_entry_st               <=  1'b0;
    rb_entry_inst_size[2:0]   <=  3'b0;
    rb_entry_create_lfb       <=  1'b0;
    rb_entry_bkpta_data       <=  1'b0;
    rb_entry_bkptb_data       <=  1'b0;
    rb_entry_vreg[5:0]        <=  6'b0;
    rb_entry_inst_vfls        <=  1'b0;
    rb_entry_vreg_sign_sel    <=  1'b0;
    rb_entry_priv_mode[1:0]   <=  2'b0;
  end
  else if(rb_entry_ld_merge_dp_vld)
  begin
    rb_entry_mcic_req         <=  1'b0;
    rb_entry_addr[`PA_WIDTH-1:0]  <=  ld_da_addr[`PA_WIDTH-1:0];
    rb_entry_bytes_vld[15:0]  <=  ld_da_bytes_vld[15:0];
    rb_entry_iid[6:0]         <=  ld_da_iid[6:0];
    rb_entry_fence_mode[3:0]  <=  4'b0;
    rb_entry_sign_extend      <=  ld_da_sign_extend;
    rb_entry_boundary         <=  ld_da_boundary_after_mask;
    rb_entry_preg[6:0]        <=  ld_da_preg[6:0];
    rb_entry_page_ca          <=  ld_da_page_ca;
    rb_entry_page_so          <=  ld_da_page_so;
    rb_entry_page_sec         <=  ld_da_page_sec;
    rb_entry_page_buf         <=  ld_da_page_buf;
    rb_entry_page_share       <=  ld_da_page_share;
    rb_entry_sync             <=  1'b0;
    rb_entry_fence            <=  1'b0;
    rb_entry_atomic           <=  1'b0;
    rb_entry_ldamo            <=  1'b0;
    rb_entry_dcache_hit       <=  ld_da_dcache_hit;
    rb_entry_st               <=  1'b0;
    rb_entry_inst_size[2:0]   <=  ld_da_inst_size[2:0];
    rb_entry_create_lfb       <=  ld_da_rb_create_lfb;
    rb_entry_bkpta_data       <=  ld_da_bkpta_data;
    rb_entry_bkptb_data       <=  ld_da_bkptb_data;
    rb_entry_vreg[5:0]        <=  ld_da_vreg[5:0];
    rb_entry_inst_vfls        <=  ld_da_inst_vfls;
    rb_entry_vreg_sign_sel    <=  ld_da_vreg_sign_sel;
    rb_entry_priv_mode[1:0]   <=  cp0_yy_priv_mode[1:0];
  end
  else if(rb_entry_ld_create_dp_vld)
  begin
    rb_entry_mcic_req         <=  ld_da_mcic_borrow_mmu;
    rb_entry_addr[`PA_WIDTH-1:0]  <=  ld_da_addr[`PA_WIDTH-1:0];
    rb_entry_bytes_vld[15:0]  <=  ld_da_bytes_vld[15:0];
    rb_entry_iid[6:0]         <=  ld_da_iid[6:0];
    rb_entry_fence_mode[3:0]  <=  4'b0;
    rb_entry_sign_extend      <=  ld_da_sign_extend;
    rb_entry_boundary         <=  ld_da_boundary_after_mask;
    rb_entry_preg[6:0]        <=  ld_da_preg[6:0];
    rb_entry_page_ca          <=  ld_da_page_ca;
    rb_entry_page_so          <=  ld_da_page_so;
    rb_entry_page_sec         <=  ld_da_page_sec;
    rb_entry_page_buf         <=  ld_da_page_buf;
    rb_entry_page_share       <=  ld_da_page_share;
    rb_entry_sync             <=  1'b0;
    rb_entry_fence            <=  1'b0;
    rb_entry_atomic           <=  ld_da_rb_atomic;
    rb_entry_ldamo            <=  ld_da_rb_ldamo;
    rb_entry_dcache_hit       <=  ld_da_dcache_hit;
    rb_entry_st               <=  1'b0;
    rb_entry_inst_size[2:0]   <=  ld_da_inst_size[2:0];
    rb_entry_create_lfb       <=  ld_da_rb_create_lfb;
    rb_entry_bkpta_data       <=  ld_da_bkpta_data;
    rb_entry_bkptb_data       <=  ld_da_bkptb_data;
    rb_entry_vreg[5:0]        <=  ld_da_vreg[5:0];
    rb_entry_inst_vfls        <=  ld_da_inst_vfls;
    rb_entry_vreg_sign_sel    <=  ld_da_vreg_sign_sel;
    rb_entry_priv_mode[1:0]   <=  cp0_yy_priv_mode[1:0];
  end
  else if(rb_entry_st_create_dp_vld)
  begin
    rb_entry_mcic_req         <=  1'b0;
    rb_entry_addr[`PA_WIDTH-1:0]  <=  st_da_addr[`PA_WIDTH-1:0];
    rb_entry_bytes_vld[15:0]  <=  16'b0;
    rb_entry_iid[6:0]         <=  st_da_iid[6:0];
    rb_entry_fence_mode[3:0]  <=  st_da_fence_mode[3:0];
    rb_entry_sign_extend      <=  1'b0;
    rb_entry_boundary         <=  1'b0;
    rb_entry_preg[6:0]        <=  7'b0;
    rb_entry_page_ca          <=  st_da_page_ca;
    rb_entry_page_so          <=  st_da_page_so;
    rb_entry_page_sec         <=  st_da_page_sec;
    rb_entry_page_buf         <=  st_da_page_buf;
    rb_entry_page_share       <=  st_da_page_share;
    rb_entry_sync             <=  st_da_sync_inst;
    rb_entry_fence            <=  st_da_fence_inst;
    rb_entry_atomic           <=  1'b0;
    rb_entry_ldamo            <=  1'b0;
    rb_entry_dcache_hit       <=  st_da_dcache_hit;
    rb_entry_st               <=  1'b1;
    rb_entry_inst_size[2:0]   <=  st_da_inst_size[2:0];
    rb_entry_create_lfb       <=  st_da_rb_create_lfb;
    rb_entry_bkpta_data       <=  1'b0;
    rb_entry_bkptb_data       <=  1'b0;
    rb_entry_vreg[5:0]        <=  6'b0;
    rb_entry_inst_vfls        <=  1'b0;
    rb_entry_vreg_sign_sel    <=  1'b0;
    rb_entry_priv_mode[1:0]   <=  cp0_yy_priv_mode[1:0];
  end
end

//+---------+
//| rot_sel |
//+---------+
//used for rot sel
always @(posedge rb_entry_create_up_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_rot_sel[7:0]     <=  8'b0;
  else if(rb_entry_ld_create_dp_vld)
    rb_entry_rot_sel[7:0]     <=  ld_da_data_rot_sel[7:0];
end

//+------+
//| secd |
//+------+
//secd must be accurate, so it use set signal
always @(posedge rb_entry_create_up_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_secd             <=  1'b0;
  else if(rb_entry_ld_merge_vld)
    rb_entry_secd             <=  1'b1;
  else if(rb_entry_ld_create_dp_vld ||  rb_entry_st_create_dp_vld)
    rb_entry_secd             <=  1'b0;
end

//+------+
//| depd |
//+------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_depd             <=  1'b0;
  else if(rb_entry_ld_merge_dp_vld ||  rb_entry_create_dp_vld)
    rb_entry_depd             <=  1'b0;
  else if(rb_entry_discard_vld)
    rb_entry_depd             <=  1'b1;
end

//+---------------+
//| boundary_depd |
//+---------------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_boundary_depd       <=  1'b0;
  else if(rb_entry_create_dp_vld  ||  rb_entry_boundary_wakeup)
    rb_entry_boundary_depd       <=  1'b0;
  else if(rb_entry_boundary_depd_set)
    rb_entry_boundary_depd       <=  1'b1;
end


//+----------+
//| dest_vld |
//+----------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_dest_vld         <=  1'b0;
  else if(rb_entry_ld_create_dp_vld)
    rb_entry_dest_vld         <=  ld_da_rb_dest_vld;
  else if(rb_entry_ld_merge_expt_vld
          ||  rb_entry_st_create_dp_vld
          ||  rb_entry_flush_clear)
    rb_entry_dest_vld         <=  1'b0;
end

//+------+
//| data |
//+------+
assign rb_entry_data_merge_vld = rb_entry_ld_merge_dp_vld &&  ld_da_rb_data_vld
                                 || rb_entry_data_bypass_vld && rb_entry_secd;

always @(posedge rb_entry_data_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_data[63:0]       <=  64'b0;
  else if(rb_entry_data_merge_vld)
    rb_entry_data[63:0]       <=  rb_entry_merge_data[63:0];
  else if(rb_entry_data_bypass_vld)
    rb_entry_data[63:0]       <=  rb_entry_biu_data_update[63:0];
  else if(rb_entry_ld_create_dp_vld &&  ld_da_rb_data_vld)
    rb_entry_data[63:0]       <=  ld_da_data_ori[63:0];
end
//+------------------+
//| wb_cmplt_success |
//+------------------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_wb_cmplt_success <=  1'b0;
  else if(rb_entry_ld_create_dp_vld)
    rb_entry_wb_cmplt_success <=  ld_da_rb_cmplt_success;
  else if(rb_entry_st_create_dp_vld)
    rb_entry_wb_cmplt_success <=  1'b1;
  else if(rb_entry_ld_merge_vld)
    rb_entry_wb_cmplt_success <=  ld_da_rb_cmplt_success;
  else if(rb_entry_wb_cmplt_grnt)
    rb_entry_wb_cmplt_success <=  1'b1;
end

//+-----------------+
//| wb_data_success |
//+-----------------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_wb_data_success  <=  1'b0;
  else if(rb_entry_ld_create_dp_vld)
    rb_entry_wb_data_success  <=  1'b0;
  else if(rb_entry_st_create_dp_vld)
    rb_entry_wb_data_success  <=  1'b1;
  else if(rb_entry_wb_data_grnt)
    rb_entry_wb_data_success  <=  1'b1;
  else if(rb_entry_fof_bus_err_expt)
    rb_entry_wb_data_success  <=  1'b1;
end

//+--------+
//| biu_id |
//+--------+
always @(posedge rb_entry_biu_id_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_biu_id[4:0]    <=  5'b0;
  else if(rb_entry_read_req_grnt)
    rb_entry_biu_id[4:0]    <=  rb_biu_ar_id[4:0];
end

//+------------+
//| biu_r_resp |
//+------------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_biu_r_resp     <=  1'b0;
  else if(rb_entry_create_dp_vld)
    rb_entry_biu_r_resp     <=  1'b0;
  else if(rb_entry_biu_r_resp_set)
    rb_entry_biu_r_resp     <=  1'b1;
end

//+------------+
//| biu_b_resp |
//+------------+
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_biu_b_resp     <=  1'b0;
  else if(rb_entry_create_dp_vld)
    rb_entry_biu_b_resp     <=  1'b0;
  else if(rb_entry_biu_b_resp_set)
    rb_entry_biu_b_resp     <=  1'b1;
end

//+---------+
//| bus_err |
//+---------+
//ecc err will not carry bus err expt
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    rb_entry_bus_err        <=  1'b0;
  end
  else if(rb_entry_create_dp_vld)
  begin
    rb_entry_bus_err        <=  1'b0;
  end
  else if(rb_entry_bus_err_set && !rb_entry_fof_not_first)
  begin
    rb_entry_bus_err        <=  1'b1;
  end
end

//+-----------------------+
//| biu_pop_entry_success |
//+-----------------------+
//this signal represents request biu_pop_entry successfully
always @(posedge rb_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    rb_entry_biu_pe_req_success   <=  1'b0;
  else if(rb_entry_ld_create_dp_vld &&  rb_ld_biu_pe_req_grnt)
    rb_entry_biu_pe_req_success   <=  1'b1;
  else if(rb_entry_create_vld  ||  rb_entry_ld_merge_vld)
    rb_entry_biu_pe_req_success   <=  1'b0;
  else if(rb_entry_biu_pe_req_grnt)
    rb_entry_biu_pe_req_success   <=  1'b1;
end

//==========================================================
//                 Generate create/cmit signal
//==========================================================
//------------------create read buffer signal---------------
assign rb_entry_create_dp_vld = rb_entry_ld_create_dp_vld
                                ||  rb_entry_st_create_dp_vld;

assign rb_entry_create_vld    = rb_entry_ld_create_vld
                                ||  rb_entry_st_create_vld;
//------------------commit set signal-----------------------
assign rb_entry_cmit_hit0       = {rtu_yy_xx_commit0,rtu_yy_xx_commit0_iid[6:0]}
                                  ==  {1'b1,rb_entry_iid[6:0]};
assign rb_entry_cmit_hit1       = {rtu_yy_xx_commit1,rtu_yy_xx_commit1_iid[6:0]}
                                  ==  {1'b1,rb_entry_iid[6:0]};
assign rb_entry_cmit_hit2       = {rtu_yy_xx_commit2,rtu_yy_xx_commit2_iid[6:0]}
                                  ==  {1'b1,rb_entry_iid[6:0]};

assign rb_entry_cmit_set  = (rb_entry_cmit_hit0
                                ||  rb_entry_cmit_hit1
                                ||  rb_entry_cmit_hit2)
                            &&  rb_entry_vld;

//==========================================================
//                 Generate inst type
//==========================================================
assign rb_entry_sync_fence      = rb_entry_sync ||  rb_entry_fence;
assign rb_entry_not_sync_fence  = !rb_entry_sync_fence;

//==========================================================
//                 Generate next state
//==========================================================
// &CombBeg; @579
always @( ld_da_rb_data_vld
       or rb_entry_flush_clear
       or rb_entry_state[3:0]
       or rb_entry_dest_vld
       or rb_entry_req_wb_success
       or rb_entry_ld_merge_vld
       or rb_entry_not_sync_fence
       or rb_entry_sync_fence_resp_success
       or ld_da_boundary_after_mask
       or rb_entry_biu_r_resp_set
       or rb_entry_create_wait_rdy
       or rb_entry_create_vld
       or rb_entry_read_req_grnt
       or rb_entry_wait_resp_to_req_merge
       or rb_entry_ld_create_vld
       or rb_entry_ready_to_biu_req
       or rb_entry_wait_resp_imme_idle
       or rtu_lsu_async_flush)
begin
rb_entry_next_state[3:0]  = IDLE;
case(rb_entry_state[3:0])
  IDLE:
    if(rb_entry_ld_create_vld &&  ld_da_boundary_after_mask &&  ld_da_rb_data_vld)
      rb_entry_next_state[3:0]  = WAIT_MERGE;
    else if(rb_entry_create_wait_rdy)
      rb_entry_next_state[3:0]  = WAIT_RDY;
    else if(rb_entry_create_vld)
      rb_entry_next_state[3:0]  = REQ_BIU;
    else
      rb_entry_next_state[3:0]  = IDLE;
  WAIT_RDY:
    if(rb_entry_flush_clear)
      rb_entry_next_state[3:0]  = IDLE;
    else if(rb_entry_ready_to_biu_req)
      rb_entry_next_state[3:0]  = REQ_BIU;
    else
      rb_entry_next_state[3:0]  = WAIT_RDY;
  REQ_BIU:
    if(rb_entry_flush_clear)
      rb_entry_next_state[3:0]  = IDLE;
    else if(rb_entry_read_req_grnt)
      rb_entry_next_state[3:0]  = WAIT_RESP;
    else
      rb_entry_next_state[3:0]  = REQ_BIU;
  WAIT_RESP:
    if(rb_entry_wait_resp_imme_idle
      ||  rb_entry_sync_fence_resp_success
      ||  rtu_lsu_async_flush)
      rb_entry_next_state[3:0]  = IDLE;
    else if(rb_entry_wait_resp_to_req_merge)
      rb_entry_next_state[3:0]  = WAIT_MERGE;
    else if(rb_entry_biu_r_resp_set &&  rb_entry_not_sync_fence)
      rb_entry_next_state[3:0]  = REQ_WB;
    else
      rb_entry_next_state[3:0]  = WAIT_RESP;
  REQ_WB:
    if(!rb_entry_dest_vld ||  rb_entry_req_wb_success ||  rtu_lsu_async_flush)
      rb_entry_next_state[3:0]  = IDLE;
    else
      rb_entry_next_state[3:0]  = REQ_WB;
  WAIT_MERGE:
    if(!rb_entry_dest_vld ||  rb_entry_flush_clear)
      rb_entry_next_state[3:0]  = IDLE;
    else if(rb_entry_ld_merge_vld &&  ld_da_rb_data_vld)
      rb_entry_next_state[3:0]  = REQ_WB;
    else if(rb_entry_ld_merge_vld)
      rb_entry_next_state[3:0]  = REQ_BIU;
    else
      rb_entry_next_state[3:0]  = WAIT_MERGE;
  default:rb_entry_next_state[3:0]  = IDLE;
endcase
// &CombEnd; @632
end

//==========================================================
//                 State 0 : idle
//==========================================================
//create ptr0 is used for ld pipe
//create ptr1 is used for st pipe
assign rb_entry_hit_fence_ld    = lsu_has_fence
                                  &&  rb_fence_ld
                                  &&  rb_create_ptr0;

//assign rb_entry_hit_fence_st      = lsu_has_fence
//                                  &&  rb_fence_st
//                                  &&  rb_create_ptr1;

assign rb_entry_create_wait_rdy = rb_entry_ld_create_vld
                                      &&  !ld_da_mcic_borrow_mmu
                                      &&  (ld_da_page_so
                                          ||  rb_entry_hit_fence_ld)
                                  ||  rb_entry_st_create_vld
                                      &&  (st_da_fence_inst
                                          ||  st_da_sync_inst);

//==========================================================
//                 State 1 : wait for ready
//==========================================================
//to make it easy, rb send bar/sync ar request must wait wmb has sent aw request
assign rb_entry_fence_ready   = rb_entry_fence
                              &&  wmb_sync_fence_biu_req_success
                              &&  (!rb_entry_fence_mode[0]
                                  ||  rb_ready_ld_req_biu_success);

assign rb_entry_sync_ready  = rb_entry_sync
                              &&  wmb_sync_fence_biu_req_success
                              &&  rb_ready_all_req_biu_success;

assign rb_entry_not_sync_fence_ready  = rb_entry_not_sync_fence
                                        &&  (rb_entry_page_so
                                                &&  rb_entry_cmit
                                                &&  !wmb_rb_so_pending
                                            || !rb_entry_page_so
                                                &&  !lsu_has_fence); 
                              
assign rb_entry_ready_to_biu_req  = rb_entry_vld
                                    &&  (rb_entry_fence_ready
                                        ||  rb_entry_sync_ready
                                        ||  rb_entry_not_sync_fence_ready);

assign rb_entry_biu_pe_req_gateclk_en = ((rb_entry_state[3:0]  ==  WAIT_RDY)
                                            ||  rb_entry_biu_req
                                                &&  !rb_entry_biu_pe_req_success)
                                        &&  !rb_entry_flush_clear;

assign rb_entry_biu_pe_req      = (rb_entry_ready_to_biu_req
                                          &&  (rb_entry_state[3:0]  ==  WAIT_RDY)
                                      ||  rb_entry_biu_req
                                          &&  !rb_entry_biu_pe_req_success)
                                  &&  !rb_entry_flush_clear;
//==========================================================
//                 State 2 : request biu/lfb
//==========================================================
//------------------biu/lfb req-----------------------------
assign rb_entry_biu_req         = rb_entry_state[3:0]  ==  REQ_BIU;

//if request both biu and lfb, then the rb_entry must get two grnt signal, else
//it will not request biu or lfb. it is realized in rb top module.

//rb_entry_read_req_grnt is an input signal and will not generate in the entry.
//==========================================================
//                 State 3 : wait data/resp
//==========================================================
//------------------biu response signal---------------------
assign rb_entry_r_id_hit    = biu_lsu_r_vld
                              &&  (rb_entry_biu_id[4:0]  ==  biu_lsu_r_id[4:0]);
assign rb_entry_b_id_hit    = biu_lsu_b_vld
                              &&  (rb_entry_biu_id[4:0]  ==  biu_lsu_b_id[4:0]);

//-----------biu response signal--------
assign rb_entry_biu_r_resp_set  = rb_entry_r_id_hit
                                  &&  (rb_entry_state[3:0] ==  WAIT_RESP)
                                  &&  (rb_entry_page_ca
                                      ||  rb_entry_atomic && !rb_entry_page_so
                                      ||  rb_entry_next_nc_bypass
                                      ||  rb_entry_next_so_bypass
                                      ||  rb_entry_sync_fence);
assign rb_entry_biu_b_resp_set  = rb_entry_b_id_hit;

assign rb_entry_atomic_next_resp  = rb_entry_vld
                                    &&  rb_entry_atomic
                                    &&  (rb_entry_next_so_bypass
                                        ||  !rb_entry_page_so);

//if non-cacheable ldex, response okay is regarded as bus error
assign rb_entry_bus_err_set     = rb_entry_biu_r_resp_set
                                  &&  (rb_r_resp_err
                                      ||  rb_entry_atomic
                                          &&  !rb_entry_page_ca
                                          &&  rb_r_resp_okay);

// &CombBeg; @743
// &CombEnd; @751
assign rb_entry_fof_bus_err_expt = 1'b0;
assign rb_entry_fof_not_first    = 1'b0;
//------------------data bypass signal----------------------
assign rb_entry_data_bypass_vld = rb_entry_biu_r_resp_set
                                  &&  rb_entry_dest_vld
                                  &&  (!rb_entry_atomic
                                      ||  lm_already_snoop
                                      ||  !rb_entry_dcache_hit);

//------------------settle data from biu--------------------

assign rb_entry_biu_data_ori[127:0]  =   {{{8{rb_entry_bytes_vld[15]}}  & biu_lsu_r_data_mask[127:120]}
                                         ,{{8{rb_entry_bytes_vld[14]}}  & biu_lsu_r_data_mask[119:112]}
                                         ,{{8{rb_entry_bytes_vld[13]}}  & biu_lsu_r_data_mask[111:104]}
                                         ,{{8{rb_entry_bytes_vld[12]}}  & biu_lsu_r_data_mask[103:96]}
                                         ,{{8{rb_entry_bytes_vld[11]}}  & biu_lsu_r_data_mask[95:88]}
                                         ,{{8{rb_entry_bytes_vld[10]}}  & biu_lsu_r_data_mask[87:80]}
                                         ,{{8{rb_entry_bytes_vld[9]}}   & biu_lsu_r_data_mask[79:72]}
                                         ,{{8{rb_entry_bytes_vld[8]}}   & biu_lsu_r_data_mask[71:64]}
                                         ,{{8{rb_entry_bytes_vld[7]}}   & biu_lsu_r_data_mask[63:56]}
                                         ,{{8{rb_entry_bytes_vld[6]}}   & biu_lsu_r_data_mask[55:48]}
                                         ,{{8{rb_entry_bytes_vld[5]}}   & biu_lsu_r_data_mask[47:40]}
                                         ,{{8{rb_entry_bytes_vld[4]}}   & biu_lsu_r_data_mask[`PA_WIDTH-1:32]}
                                         ,{{8{rb_entry_bytes_vld[3]}}   & biu_lsu_r_data_mask[31:24]}
                                         ,{{8{rb_entry_bytes_vld[2]}}   & biu_lsu_r_data_mask[23:16]}
                                         ,{{8{rb_entry_bytes_vld[1]}}   & biu_lsu_r_data_mask[15:8]}
                                         ,{{8{rb_entry_bytes_vld[0]}}   & biu_lsu_r_data_mask[7:0]}}; 

assign rb_entry_biu_data_update[63:0]  = rb_entry_biu_data_ori[127:64]
                                         | rb_entry_biu_data_ori[63:0];
//---------------------merge data---------------------------
assign rb_entry_merge_sel = (rb_entry_state[3:0] ==  WAIT_MERGE); 
assign rb_entry_merge_data_ori[63:0]  = rb_entry_merge_sel 
                                        ? ld_da_data_ori[63:0]
                                        : rb_entry_biu_data_update[63:0];

assign rb_entry_merge_bytes_vld[7:0]  = rb_entry_merge_sel
                                        ? ld_da_bytes_vld[15:8] | ld_da_bytes_vld[7:0]
                                        : rb_entry_bytes_vld[15:8] | rb_entry_bytes_vld[7:0];

assign rb_entry_merge_data_sel[63:0]  = {{8{rb_entry_merge_bytes_vld[7]}},
                                         {8{rb_entry_merge_bytes_vld[6]}},
                                         {8{rb_entry_merge_bytes_vld[5]}},
                                         {8{rb_entry_merge_bytes_vld[4]}},
                                         {8{rb_entry_merge_bytes_vld[3]}},
                                         {8{rb_entry_merge_bytes_vld[2]}},
                                         {8{rb_entry_merge_bytes_vld[1]}},
                                         {8{rb_entry_merge_bytes_vld[0]}}};
 
assign rb_entry_merge_data[63:0]  = rb_entry_data[63:0] & ~rb_entry_merge_data_sel[63:0] 
                                    | rb_entry_merge_data_ori[63:0];
//------------------resp success signal---------------------
// inst_type                      cmplt condition
// sync                           r&b resp
// fence                          r&b resp
// ld/atomic !boundary_first      -> REQ_WB
// ld boundary_first              -> WAIT_MERGE
assign rb_entry_sync_resp_success   = rb_entry_sync
                                      &&  rb_entry_biu_r_resp
                                      &&  rb_entry_biu_b_resp;
assign rb_entry_fence_resp_success  = rb_entry_fence
                                      &&  rb_entry_biu_r_resp
                                      &&  rb_entry_biu_b_resp;

//------------------generate next state signal--------------
assign rb_entry_wait_resp_imme_idle   = !rb_entry_dest_vld
                                        &&  rb_entry_page_ca
                                        &&  rb_entry_not_sync_fence;
                                        
assign rb_entry_sync_fence_resp_success = rb_entry_sync_resp_success
                                          ||  rb_entry_fence_resp_success;

assign rb_entry_wait_resp_to_req_merge  = rb_entry_biu_r_resp_set
                                          &&  rb_entry_boundary
                                          &&  !rb_entry_secd
                                          &&  rb_entry_not_sync_fence;


//==========================================================
//                 State 4 : req cmplt/data
//==========================================================
//------------------req cmplt signal------------------------
//so need to request wb cmplt part when grnt
//ldex need to request wb cmplt part when get data
//and only one entry will request cmplt part
assign rb_entry_wb_cmplt_req    = !rb_entry_wb_cmplt_success
                                  &&  rb_entry_dest_vld
                                  &&  (rb_entry_page_so
                                          &&  !rb_entry_atomic
                                          &&  (rb_entry_state[3:0] ==  WAIT_RESP)
                                      ||  (rb_entry_state[3:0] ==  REQ_WB));
//------------------req data signal-------------------------
//if get bus error, then it must commit and send bus_err signal
assign rb_entry_wb_data_req     = rb_entry_dest_vld
                                  &&  (rb_entry_state[3:0] ==  REQ_WB)
                                  &&  (!rb_entry_bus_err  ||  rb_entry_cmit)
                                  &&  rb_entry_wb_cmplt_success
                                  &&  !rb_entry_wb_data_success;

//for timing, select data_ptr one cycle ahead
assign rb_entry_wb_data_req_pre = rb_entry_biu_r_resp_set
                                  &&  (!rb_entry_boundary
                                      || rb_entry_secd)
                                  &&  rb_entry_wb_cmplt_success
                                  &&  rb_entry_not_sync_fence;
                                   
assign rb_entry_wb_data_pre_sel = rb_entry_wb_data_req 
                                  || rb_entry_wb_data_req_pre; 
//------------------generate next state signal--------------
assign rb_entry_req_wb_success     = rb_entry_vld
                                     &&  rb_entry_wb_cmplt_success
                                     &&  (rb_entry_wb_data_grnt || rb_entry_wb_data_success);

//get data_vld signal, if data_vld, then it will not hit idx on sq_pop
assign rb_entry_data_vld  = (rb_entry_state[3:0] == REQ_WB)
                            ||  (rb_entry_state[3:0] == WAIT_MERGE);

//==========================================================
//                 State 5 : wait for merge
//==========================================================
//------------------generate merge signal------------------
assign rb_entry_iid_hit         = rb_entry_iid[6:0] ==  ld_da_iid[6:0];
assign rb_entry_ld_merge_pre    = (rb_entry_state[3:0] ==  WAIT_MERGE)
                                  &&  rb_entry_iid_hit;

assign rb_entry_ld_merge_vld    = ld_da_rb_merge_vld
                                  &&  rb_entry_ld_merge_pre;

assign rb_entry_ld_merge_dp_vld = ld_da_rb_merge_dp_vld
                                  &&  rb_entry_ld_merge_pre;

//this signal is for cancel dest_vld and pop entry
assign rb_entry_ld_merge_expt_vld = ld_da_rb_merge_expt_vld
                                    &&  rb_entry_vld
                                    &&  rb_entry_boundary
                                    &&  !rb_entry_secd
                                    &&  rb_entry_iid_hit;

assign rb_entry_ld_merge_gateclk_en  = ld_da_rb_merge_gateclk_en
                                        &&  rb_entry_ld_merge_pre;

//------------------boundary depd vld-----------------------
assign rb_entry_merge_fail      = rb_entry_iid_hit
                                  &&  rb_entry_dest_vld
                                  &&  rb_entry_boundary
                                  &&  !rb_entry_secd
                                  &&  rb_entry_vld
                                  &&  (rb_entry_state[3:0] !=  WAIT_MERGE);

assign rb_entry_boundary_depd_set = rb_entry_merge_fail
                                    &&  ld_da_rb_discard_grnt
                                    &&  !rb_entry_ld_da_hit_idx;
//------------------boundary depd clr-----------------------
assign rb_entry_boundary_wakeup   = rb_entry_boundary_depd
                                    &&  (rb_entry_state[3:0] ==  WAIT_MERGE);

//==========================================================
//                 Barrier inst
//==========================================================
assign rb_entry_fence_ld_vld      = rb_entry_fence
                                    &&  rb_entry_vld
                                    &&  rb_entry_fence_mode[0];
//==========================================================
//                 Compare index
//==========================================================
//------------------compare ld_da stage---------------------
//if has requested biu, then it will not compare with ld_da/st_da
assign rb_entry_ld_da_hit_idx   = rb_entry_page_ca
                                  &&  rb_entry_vld
                                  &&  !rb_entry_sync_fence
                                  &&  !rb_entry_biu_req_success
                                  &&  (rb_entry_addr[13:6] ==  ld_da_idx[7:0]);
//------------------compare st_da stage---------------------
assign rb_entry_st_da_hit_idx   = rb_entry_page_ca
                                  &&  rb_entry_vld
                                  &&  !rb_entry_biu_req_success
                                  &&  !rb_entry_sync_fence
                                  &&  (rb_entry_addr[13:6]
                                      ==  st_da_addr[13:6]);
//------------------depd_vld--------------------------------
assign rb_entry_discard_vld = ld_da_rb_discard_grnt
                              &&  rb_entry_ld_da_hit_idx;

//------------------compare sq pop entry--------------------
//sq pop entry must compare index if:
//ca && !req_biu
//!ca && !so && !data_vld
assign rb_entry_cmp_sq_pop_addr[`PA_WIDTH-1:0] = sq_pop_addr[`PA_WIDTH-1:0];
assign rb_entry_sq_pop_cmp_vld  = rb_entry_page_ca  &&  sq_pop_page_ca  &&  !rb_entry_biu_req_success
                                  ||  !rb_entry_page_ca &&  !sq_pop_page_ca
                                      &&  !rb_entry_page_so &&  !sq_pop_page_so
                                      &&  !rb_entry_data_vld;
assign rb_entry_sq_pop_hit_idx  = rb_entry_sq_pop_cmp_vld
                                  &&  rb_entry_vld
                                  &&  !rb_entry_sync_fence
                                  &&  rb_entry_cmit
                                  &&  (rb_entry_addr[13:6]
                                      ==  rb_entry_cmp_sq_pop_addr[13:6]);
//------------------compare wmb ce entry---------------------
assign rb_entry_cmp_wmb_ce_addr[`PA_WIDTH-1:0] = wmb_ce_addr[`PA_WIDTH-1:0];
assign rb_entry_wmb_ce_cmp_vld  = rb_entry_page_ca  &&  wmb_ce_page_ca  &&  !rb_entry_biu_req_success
                                  ||  !rb_entry_page_ca &&  !wmb_ce_page_ca
                                      &&  !rb_entry_page_so &&  !wmb_ce_page_so
                                      &&  !rb_entry_data_vld;
assign rb_entry_wmb_ce_hit_idx  = rb_entry_wmb_ce_cmp_vld
                                  &&  rb_entry_vld
                                  &&  !rb_entry_sync_fence
                                  &&  rb_entry_cmit
                                  &&  (rb_entry_addr[13:6]
                                      ==  rb_entry_cmp_wmb_ce_addr[13:6]);

//------------------compare pfu pop entry--------------------
assign rb_entry_cmp_pfu_biu_req_addr[`PA_WIDTH-1:0]  = pfu_biu_req_addr[`PA_WIDTH-1:0];
assign rb_entry_pfu_biu_req_hit_idx = rb_entry_page_ca
                                      &&  rb_entry_vld
                                      &&  !rb_entry_sync_fence
                                      &&  (rb_entry_addr[13:6]
                                          ==  rb_entry_cmp_pfu_biu_req_addr[13:6]);
//==========================================================
//                 Flush dest_vld/Pop signal
//==========================================================
//req_biu_success && !cmit will cancel dest_vld
assign rb_entry_flush_clear   = rtu_yy_xx_flush
                                    &&  (!rb_entry_cmit
                                        ||  rb_entry_boundary &&  !rb_entry_secd)
                                    &&  !rb_entry_mcic_req
                                ||  rtu_lsu_async_flush
                                    &&  !rb_entry_mcic_req;
//==========================================================
//              Interface to other module
//==========================================================
//-----------------cmit data vld signal---------------------
//for rtu flush
assign rb_entry_cmit_data_not_vld = rb_entry_vld
                                    && rb_entry_cmit
                                    && rb_entry_dest_vld; 

//==========================================================
//                 Generate interface
//==========================================================
//------------------input-----------------------------------
//-----------create signal--------------
assign rb_create_ptr0                   = rb_create_ptr0_x;
assign rb_entry_ld_create_vld           = rb_entry_ld_create_vld_x;
assign rb_entry_ld_create_dp_vld        = rb_entry_ld_create_dp_vld_x;
assign rb_entry_st_create_vld           = rb_entry_st_create_vld_x;
assign rb_entry_st_create_dp_vld        = rb_entry_st_create_dp_vld_x;
assign rb_entry_ld_create_gateclk_en    = rb_entry_ld_create_gateclk_en_x;
assign rb_entry_st_create_gateclk_en    = rb_entry_st_create_gateclk_en_x;
//-----------grnt signal----------------
assign rb_entry_biu_pe_req_grnt         = rb_entry_biu_pe_req_grnt_x;
assign rb_entry_next_nc_bypass          = rb_entry_next_nc_bypass_x;
assign rb_entry_next_so_bypass          = rb_entry_next_so_bypass_x;
assign rb_entry_read_req_grnt           = rb_entry_read_req_grnt_x;
assign rb_entry_wb_cmplt_grnt           = rb_entry_wb_cmplt_grnt_x;
assign rb_entry_wb_data_grnt            = rb_entry_wb_data_grnt_x;
//----------gateclk signal--------------
assign rb_entry_biu_id_gateclk_en       = rb_entry_biu_id_gateclk_en_x;
//------------------output----------------------------------
//-----------rb entry signal------------
assign rb_entry_state_v[3:0]            = rb_entry_state[3:0];
assign rb_entry_vld_x                   = rb_entry_vld;
assign rb_entry_mcic_req_x              = rb_entry_mcic_req;
assign rb_entry_addr_v[`PA_WIDTH-1:0]   = rb_entry_addr[`PA_WIDTH-1:0];
assign rb_entry_iid_v[6:0]              = rb_entry_iid[6:0];
assign rb_entry_sign_extend_x           = rb_entry_sign_extend;
assign rb_entry_preg_v[6:0]             = rb_entry_preg[6:0];
assign rb_entry_page_ca_x               = rb_entry_page_ca;
assign rb_entry_page_so_x               = rb_entry_page_so;
assign rb_entry_page_sec_x              = rb_entry_page_sec;
assign rb_entry_page_buf_x              = rb_entry_page_buf;
assign rb_entry_page_share_x            = rb_entry_page_share;
assign rb_entry_sync_x                  = rb_entry_sync;
assign rb_entry_fence_x                 = rb_entry_fence;
assign rb_entry_sync_fence_x            = rb_entry_sync_fence;
assign rb_entry_atomic_x                = rb_entry_atomic;
assign rb_entry_ldamo_x                 = rb_entry_ldamo;
assign rb_entry_st_x                    = rb_entry_st;
assign rb_entry_bkpta_data_x            = rb_entry_bkpta_data;
assign rb_entry_bkptb_data_x            = rb_entry_bkptb_data;
assign rb_entry_inst_size_v[2:0]        = rb_entry_inst_size[2:0];
assign rb_entry_depd_x                  = rb_entry_depd;
assign rb_entry_vreg_v[5:0]             = rb_entry_vreg[5:0];
assign rb_entry_inst_vfls_x             = rb_entry_inst_vfls;
assign rb_entry_vreg_sign_sel_x         = rb_entry_vreg_sign_sel;
assign rb_entry_priv_mode_v[1:0]        = rb_entry_priv_mode[1:0];
assign rb_entry_data_v[63:0]            = rb_entry_data[63:0];
assign rb_entry_bus_err_x               = rb_entry_bus_err;
assign rb_entry_flush_clear_x           = rb_entry_flush_clear;
assign rb_entry_cmit_data_vld_x         = !rb_entry_cmit_data_not_vld;
//-----------request--------------------
assign rb_entry_biu_req_x               = rb_entry_biu_req;
assign rb_entry_create_lfb_x            = rb_entry_create_lfb;
assign rb_entry_wb_cmplt_req_x          = rb_entry_wb_cmplt_req;
assign rb_entry_wb_data_req_x           = rb_entry_wb_data_req;
assign rb_entry_boundary_wakeup_x       = rb_entry_boundary_wakeup;
assign rb_entry_merge_fail_x            = rb_entry_merge_fail;
assign rb_entry_biu_pe_req_x            = rb_entry_biu_pe_req;
assign rb_entry_biu_pe_req_gateclk_en_x = rb_entry_biu_pe_req_gateclk_en;
//-----------barrier inst---------------
assign rb_entry_fence_ld_vld_x          = rb_entry_fence_ld_vld;
//-----------hit idx--------------------
assign rb_entry_ld_da_hit_idx_x         = rb_entry_ld_da_hit_idx;
assign rb_entry_st_da_hit_idx_x         = rb_entry_st_da_hit_idx;
assign rb_entry_sq_pop_hit_idx_x        = rb_entry_sq_pop_hit_idx;
assign rb_entry_wmb_ce_hit_idx_x        = rb_entry_wmb_ce_hit_idx;
assign rb_entry_pfu_biu_req_hit_idx_x   = rb_entry_pfu_biu_req_hit_idx;
//-----------other signal---------------
assign rb_entry_discard_vld_x           = rb_entry_discard_vld;
assign rb_entry_rot_sel_v[7:0]          = rb_entry_rot_sel[7:0];
assign rb_entry_wb_data_pre_sel_x       = rb_entry_wb_data_pre_sel;
assign rb_entry_atomic_next_resp_x      = rb_entry_atomic_next_resp;

// &ModuleEnd; @1136
endmodule


