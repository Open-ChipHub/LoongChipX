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
module ct_lsu_wmb_ce (
  // &Ports, @25
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          lm_sq_sc_fail,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rb_wmb_ce_hit_idx,
  input    wire          rtu_lsu_async_flush,
  input    wire  [39:0]  sq_pop_addr,
  input    wire          sq_pop_atomic,
  input    wire  [15:0]  sq_pop_bytes_vld,
  input    wire          sq_pop_icc,
  input    wire          sq_pop_inst_flush,
  input    wire  [1 :0]  sq_pop_inst_mode,
  input    wire  [2 :0]  sq_pop_inst_size,
  input    wire  [1 :0]  sq_pop_inst_type,
  input    wire          sq_pop_page_buf,
  input    wire          sq_pop_page_ca,
  input    wire          sq_pop_page_sec,
  input    wire          sq_pop_page_share,
  input    wire          sq_pop_page_so,
  input    wire          sq_pop_page_wa,
  input    wire  [1 :0]  sq_pop_priv_mode,
  input    wire  [11:0]  sq_pop_ptr,
  input    wire          sq_pop_sync_fence,
  input    wire          sq_pop_wo_st,
  input    wire          wmb_ce_create_dp_vld,
  input    wire          wmb_ce_create_gateclk_en,
  input    wire          wmb_ce_create_hit_rb_idx,
  input    wire          wmb_ce_create_merge,
  input    wire  [7 :0]  wmb_ce_create_merge_ptr,
  input    wire  [7 :0]  wmb_ce_create_same_dcache_line,
  input    wire          wmb_ce_create_stall,
  input    wire          wmb_ce_create_vld,
  input    wire          wmb_ce_dcache_share,
  input    wire          wmb_ce_dcache_valid,
  input    wire          wmb_ce_pop_vld,
  input    wire          wmb_clk,
  input    wire  [7 :0]  wmb_entry_vld,
  output   reg   [39:0]  wmb_ce_addr,
  output   reg           wmb_ce_atomic,
  output   reg   [15:0]  wmb_ce_bytes_vld,
  output   wire          wmb_ce_bytes_vld_full,
  output   wire          wmb_ce_ca_st_inst,
  output   wire          wmb_ce_create_wmb_data_req,
  output   wire          wmb_ce_create_wmb_dp_req,
  output   wire          wmb_ce_create_wmb_gateclk_en,
  output   wire          wmb_ce_create_wmb_req,
  output   wire  [3 :0]  wmb_ce_data_vld,
  output   wire          wmb_ce_dcache_inst,
  output   wire          wmb_ce_dcache_sw_inst,
  output   wire          wmb_ce_hit_sq_pop_dcache_line,
  output   reg           wmb_ce_icc,
  output   reg           wmb_ce_inst_flush,
  output   reg   [1 :0]  wmb_ce_inst_mode,
  output   reg   [2 :0]  wmb_ce_inst_size,
  output   reg   [1 :0]  wmb_ce_inst_type,
  output   wire          wmb_ce_merge_data_addr_hit,
  output   wire          wmb_ce_merge_data_stall,
  output   wire          wmb_ce_merge_en,
  output   reg   [7 :0]  wmb_ce_merge_ptr,
  output   wire          wmb_ce_merge_wmb_req,
  output   wire          wmb_ce_merge_wmb_wait_not_vld_req,
  output   reg           wmb_ce_page_buf,
  output   reg           wmb_ce_page_ca,
  output   reg           wmb_ce_page_sec,
  output   reg           wmb_ce_page_share,
  output   reg           wmb_ce_page_so,
  output   reg           wmb_ce_page_wa,
  output   reg   [1 :0]  wmb_ce_priv_mode,
  output   wire          wmb_ce_read_dp_req,
  output   reg   [7 :0]  wmb_ce_same_dcache_line,
  output   wire          wmb_ce_sc_wb_vld,
  output   reg   [11:0]  wmb_ce_sq_ptr,
  output   reg           wmb_ce_sync_fence,
  output   reg           wmb_ce_vld,
  output   wire          wmb_ce_wb_cmplt_success,
  output   wire          wmb_ce_wb_data_success,
  output   wire          wmb_ce_write_biu_dp_req,
  output   wire          wmb_ce_write_imme
); 



// &Regs; @26
reg             wmb_ce_hit_rb_idx;                
reg             wmb_ce_hit_rb_idx_ff;             
reg             wmb_ce_merge;                     
reg             wmb_ce_stall;                     
reg             wmb_ce_wo_st;                     

// &Wires; @27
wire            wmb_ce_create_clk;                
wire            wmb_ce_create_clk_en;             
wire            wmb_ce_ctc_inst;                  
wire            wmb_ce_dcache_1line_inst;         
wire            wmb_ce_dcache_addr_inst;          
wire            wmb_ce_dcache_addr_not_l1_inst;   
wire            wmb_ce_dcache_all_inst;           
wire            wmb_ce_hit_rb_idx_set;            
wire            wmb_ce_hit_sq_pop_addr_5to4;      
wire            wmb_ce_hit_sq_pop_addr_tto4;      
wire            wmb_ce_hit_sq_pop_addr_tto6;      
wire            wmb_ce_merge_data_permit;         
wire            wmb_ce_merge_not_vld;             
wire    [7 :0]  wmb_ce_merge_ptr_and_not_vld;     
wire            wmb_ce_sc_inst;                   
wire            wmb_ce_so_st_inst;                
wire            wmb_ce_st_inst;                   
wire            wmb_ce_stamo_inst;                
wire            wmb_ce_sync_fence_inst;           
wire            wmb_ce_tlbi_asid_inst;            
wire            wmb_ce_tlbi_inst;                 
wire            wmb_ce_wo_st_inst;                
wire            wmb_ce_write_data_inst;           


parameter SQ_ENTRY    = 12,
          WMB_ENTRY   = 8;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//--------create update gateclk---------
assign wmb_ce_create_clk_en  = wmb_ce_create_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_wmb_ce_create_gated_clk"); @37
gated_clk_cell  x_lsu_wmb_ce_create_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (wmb_ce_create_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (wmb_ce_create_clk_en),
  .module_en            (cp0_lsu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

// &Connect(.clk_in        (forever_cpuclk     ), @38
//          .external_en   (1'b0               ), @39
//          .global_en     (cp0_yy_clk_en      ), @40
//          .module_en     (cp0_lsu_icg_en     ), @41
//          .local_en      (wmb_ce_create_clk_en), @42
//          .clk_out       (wmb_ce_create_clk)); @43

//==========================================================
//                 Register
//==========================================================
//+-----+
//| vld |
//+-----+
// &Force("output","wmb_ce_vld"); @51
always @(posedge wmb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wmb_ce_vld              <=  1'b0;
  else if(rtu_lsu_async_flush)
    wmb_ce_vld              <=  1'b0;
  else if(wmb_ce_create_vld)
    wmb_ce_vld              <=  1'b1;
  else if(wmb_ce_pop_vld)
    wmb_ce_vld              <=  1'b0;
end

//+------------+
//| hit rb idx |
//+------------+
always @(posedge wmb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wmb_ce_hit_rb_idx       <=  1'b0;
  else if(wmb_ce_create_dp_vld)
    wmb_ce_hit_rb_idx       <=  wmb_ce_create_hit_rb_idx;
  else if(wmb_ce_vld)
    wmb_ce_hit_rb_idx       <=  wmb_ce_hit_rb_idx_set;
end

//+---------------+
//| hit rb idx ff |
//+---------------+
always @(posedge wmb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wmb_ce_hit_rb_idx_ff    <=  1'b0;
  else if(wmb_ce_create_dp_vld)
    wmb_ce_hit_rb_idx_ff    <=  wmb_ce_create_hit_rb_idx;
  else if(wmb_ce_vld)
    wmb_ce_hit_rb_idx_ff    <=  wmb_ce_hit_rb_idx;
end

//+-------------------------+
//| instruction information |
//+-------------------------+
// &Force("output","wmb_ce_addr"); @93
// &Force("output","wmb_ce_page_ca"); @94
// &Force("output","wmb_ce_page_so"); @95
// &Force("output","wmb_ce_page_share"); @96
// &Force("output","wmb_ce_atomic"); @97
// &Force("output","wmb_ce_sync_fence"); @98
// &Force("output","wmb_ce_icc"); @99
// &Force("output","wmb_ce_inst_type"); @100
// &Force("output","wmb_ce_inst_size"); @101
// &Force("output","wmb_ce_inst_mode"); @102
// &Force("output","wmb_ce_bytes_vld"); @103
// &Force("output","wmb_ce_priv_mode"); @104
always @(posedge wmb_ce_create_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    wmb_ce_addr[`PA_WIDTH-1:0]  <=  {`PA_WIDTH{1'b0}};
    wmb_ce_page_ca              <=  1'b0;
    wmb_ce_page_wa              <=  1'b0;
    wmb_ce_page_so              <=  1'b0;
    wmb_ce_page_sec             <=  1'b0;
    wmb_ce_page_buf             <=  1'b0;
    wmb_ce_page_share           <=  1'b0;
    wmb_ce_atomic               <=  1'b0;
    wmb_ce_icc                  <=  1'b0;
    wmb_ce_wo_st                <=  1'b0;
    wmb_ce_sync_fence           <=  1'b0;
    wmb_ce_inst_flush           <=  1'b0;
    wmb_ce_inst_type[1:0]       <=  2'b0;
    wmb_ce_inst_size[2:0]       <=  3'b0;
    wmb_ce_inst_mode[1:0]       <=  2'b0;
    wmb_ce_bytes_vld[15:0]      <=  16'b0;
    wmb_ce_priv_mode[1:0]       <=  2'b0;
    wmb_ce_sq_ptr[SQ_ENTRY-1:0] <=  {SQ_ENTRY{1'b0}};
  end
  else if(wmb_ce_create_dp_vld)
  begin
    wmb_ce_addr[`PA_WIDTH-1:0]  <=  sq_pop_addr[`PA_WIDTH-1:0];
    wmb_ce_page_ca              <=  sq_pop_page_ca;
    wmb_ce_page_wa              <=  sq_pop_page_wa;
    wmb_ce_page_so              <=  sq_pop_page_so;
    wmb_ce_page_sec             <=  sq_pop_page_sec;
    wmb_ce_page_buf             <=  sq_pop_page_buf;
    wmb_ce_page_share           <=  sq_pop_page_share;
    wmb_ce_atomic               <=  sq_pop_atomic;
    wmb_ce_icc                  <=  sq_pop_icc;
    wmb_ce_wo_st                <=  sq_pop_wo_st;
    wmb_ce_sync_fence           <=  sq_pop_sync_fence;
    wmb_ce_inst_flush           <=  sq_pop_inst_flush;
    wmb_ce_inst_type[1:0]       <=  sq_pop_inst_type[1:0];
    wmb_ce_inst_size[2:0]       <=  sq_pop_inst_size[2:0];
    wmb_ce_inst_mode[1:0]       <=  sq_pop_inst_mode[1:0];
    wmb_ce_bytes_vld[15:0]      <=  sq_pop_bytes_vld[15:0];
    wmb_ce_priv_mode[1:0]       <=  sq_pop_priv_mode[1:0];
    wmb_ce_sq_ptr[SQ_ENTRY-1:0] <=  sq_pop_ptr[SQ_ENTRY-1:0];
  end
end

//+---------------------------+
//| create/merge/stall signal |
//+---------------------------+
// &Force("output","wmb_ce_merge_ptr"); @154
//stall means merge stall
always @(posedge wmb_ce_create_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    wmb_ce_merge                    <=  1'b0;
    wmb_ce_stall                    <=  1'b0;
    wmb_ce_merge_ptr[WMB_ENTRY-1:0] <=  {WMB_ENTRY{1'b0}};
  end
  else if(wmb_ce_create_dp_vld)
  begin
    wmb_ce_merge                    <=  wmb_ce_create_merge;
    wmb_ce_stall                    <=  wmb_ce_create_stall;
    wmb_ce_merge_ptr[WMB_ENTRY-1:0] <=  wmb_ce_create_merge_ptr[WMB_ENTRY-1:0];
  end
end

always @(posedge wmb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wmb_ce_same_dcache_line[WMB_ENTRY-1:0] <=  {WMB_ENTRY{1'b0}};
  else if(wmb_ce_create_dp_vld)
    wmb_ce_same_dcache_line[WMB_ENTRY-1:0] <=  wmb_ce_create_same_dcache_line[WMB_ENTRY-1:0];
end
//==========================================================
//                      Set Wires
//==========================================================
assign wmb_ce_hit_rb_idx_set  = wmb_ce_hit_rb_idx
                                &&  rb_wmb_ce_hit_idx
                                &&  (wmb_ce_wo_st
                                    ||  wmb_ce_atomic
                                    ||  wmb_ce_dcache_1line_inst);

//==========================================================
//                    Request Wires
//==========================================================
//-----------------------pop req wires----------------------
assign wmb_ce_merge_ptr_and_not_vld[WMB_ENTRY-1:0]  =
                wmb_ce_merge_ptr[WMB_ENTRY-1:0]
                & (~wmb_entry_vld[WMB_ENTRY-1:0]);
assign wmb_ce_merge_not_vld = |wmb_ce_merge_ptr_and_not_vld[WMB_ENTRY-1:0];

//if not stall, then not hit rb idx
assign wmb_ce_merge_wmb_req       = wmb_ce_vld
                                    &&  wmb_ce_merge
                                    &&  !wmb_ce_stall;

assign wmb_ce_merge_wmb_wait_not_vld_req  = wmb_ce_vld
                                            &&  wmb_ce_merge
                                            &&  wmb_ce_stall;

// &Force("output","wmb_ce_create_wmb_req"); @206
assign wmb_ce_create_wmb_req      = wmb_ce_vld
                                    &&  !wmb_ce_hit_rb_idx_ff
                                    &&  (!wmb_ce_merge
                                        ||  wmb_ce_merge_not_vld);

// &Force("output","wmb_ce_create_wmb_dp_req"); @212
assign wmb_ce_create_wmb_dp_req   = wmb_ce_vld
                                    &&  (!wmb_ce_merge
                                        ||  wmb_ce_stall);
assign wmb_ce_create_wmb_data_req = wmb_ce_create_wmb_dp_req
                                    &&  wmb_ce_write_data_inst;
assign wmb_ce_create_wmb_gateclk_en = wmb_ce_create_wmb_dp_req;

//==========================================================
//                    Data Wires
//==========================================================
//------------------inst type-------------------------------
assign wmb_ce_write_data_inst   = wmb_ce_atomic
                                  ||  wmb_ce_st_inst
                                  ||  wmb_ce_tlbi_asid_inst;
assign wmb_ce_st_inst           = !wmb_ce_atomic
                                  &&  !wmb_ce_icc
                                  &&  !wmb_ce_sync_fence;
assign wmb_ce_stamo_inst        = wmb_ce_atomic
                                  &&  (wmb_ce_inst_type[1:0] ==  2'b00);
assign wmb_ce_sc_inst           = wmb_ce_atomic
                                  &&  (wmb_ce_inst_type[1:0] ==  2'b01);
assign wmb_ce_ca_st_inst        = wmb_ce_st_inst
                                  &&  wmb_ce_page_ca;
assign wmb_ce_so_st_inst        = wmb_ce_st_inst
                                  &&  wmb_ce_page_so;
assign wmb_ce_wo_st_inst        = wmb_ce_st_inst
                                  &&  !wmb_ce_page_so;
assign wmb_ce_sync_fence_inst   = !wmb_ce_atomic
                                  &&  wmb_ce_sync_fence;
assign wmb_ce_tlbi_inst         = !wmb_ce_atomic
                                  &&  wmb_ce_icc
                                  &&  (wmb_ce_inst_type[1:0] ==  2'b00);
assign wmb_ce_tlbi_asid_inst    = wmb_ce_tlbi_inst
                                  &&  wmb_ce_inst_mode[0];
// &Force("output","wmb_ce_dcache_inst"); @247
assign wmb_ce_dcache_inst       = !wmb_ce_atomic
                                  &&  wmb_ce_icc
                                  &&  (wmb_ce_inst_type[1:0] ==  2'b10);

assign wmb_ce_dcache_1line_inst = wmb_ce_dcache_inst
                                  &&  (wmb_ce_inst_mode[1:0] !=  2'b00);

assign wmb_ce_dcache_sw_inst    = wmb_ce_dcache_inst
                                  &&  (wmb_ce_inst_mode[1:0] ==  2'b10);
assign wmb_ce_dcache_addr_inst  = wmb_ce_dcache_inst
                                  &&  wmb_ce_inst_mode[0];
assign wmb_ce_dcache_addr_not_l1_inst = wmb_ce_dcache_addr_inst
                                        &&  (wmb_ce_inst_size[1:0] !=  2'b00);
                                  
assign wmb_ce_ctc_inst          = !wmb_ce_atomic
                                  &&  wmb_ce_icc
                                  &&  (wmb_ce_inst_type[1:0] !=  2'b10);
//dcache all request pass to icc for gate_clk
assign wmb_ce_dcache_all_inst   = wmb_ce_dcache_inst
                                  &&  (wmb_ce_inst_mode[1:0] ==  2'b00);

//------------------pop info for wmb------------------------
// &Force("output","wmb_ce_merge_en"); @270
assign wmb_ce_merge_en  = wmb_ce_wo_st;
assign wmb_ce_wb_cmplt_success  = wmb_ce_wo_st
                                  ||  wmb_ce_ctc_inst
                                  ||  wmb_ce_dcache_inst  &&  !wmb_ce_dcache_all_inst;
assign wmb_ce_wb_data_success   = !wmb_ce_sc_inst;
//------------------data request----------------------------
//----------get data_vld signal---------
//data_vld is used for wmb data gateclk
assign wmb_ce_data_vld[0] = |wmb_ce_bytes_vld[3:0];
assign wmb_ce_data_vld[1] = |wmb_ce_bytes_vld[7:4];
assign wmb_ce_data_vld[2] = |wmb_ce_bytes_vld[11:8];
assign wmb_ce_data_vld[3] = |wmb_ce_bytes_vld[15:12];
assign wmb_ce_bytes_vld_full = &wmb_ce_bytes_vld[15:0];

//-----------sc signal----------------
// &Force("output","wmb_ce_sc_wb_vld"); @286
assign wmb_ce_sc_wb_vld             = lm_sq_sc_fail;

//-------------------wmb status signal----------------------
assign wmb_ce_write_imme  = !wmb_ce_wo_st;

assign wmb_ce_read_dp_req         = wmb_ce_st_inst
                                          &&  wmb_ce_page_ca
                                          &&  wmb_ce_page_share
                                          &&  (wmb_ce_dcache_share
                                              ||  !wmb_ce_dcache_valid)
                                    ||  wmb_ce_ctc_inst
                                    ||  wmb_ce_dcache_addr_inst
                                        &&  wmb_ce_page_ca
                                        &&  (wmb_ce_dcache_addr_not_l1_inst
                                            ||  wmb_ce_page_share)
                                        &&  wmb_ce_page_ca
                                    ||  wmb_ce_sc_inst
                                        &&  wmb_ce_page_ca
                                        &&  wmb_ce_page_share;

//for write gateclk
assign wmb_ce_write_biu_dp_req    = wmb_ce_so_st_inst
                                    ||  wmb_ce_wo_st_inst
                                        &&  !(wmb_ce_page_ca
                                              &&  wmb_ce_dcache_valid)
                                    ||  wmb_ce_sync_fence_inst
                                    ||  wmb_ce_stamo_inst
                                        &&  !(wmb_ce_page_ca
                                              &&  wmb_ce_dcache_valid)
                                    ||  wmb_ce_sc_inst
                                        &&  !(wmb_ce_page_ca
                                              &&  wmb_ce_dcache_valid)
                                        &&  !wmb_ce_sc_wb_vld;

//==========================================================
//                  Compare with sq pop
//==========================================================
//wmb_ce_hit_sq_pop_cache_line is used for same_dcache_line
// &Force("bus","sq_pop_addr","39","0"); @325
assign wmb_ce_hit_sq_pop_addr_tto6    = wmb_ce_addr[`PA_WIDTH-1:6]  ==  sq_pop_addr[`PA_WIDTH-1:6];
assign wmb_ce_hit_sq_pop_addr_5to4    = wmb_ce_addr[5:4]   ==  sq_pop_addr[5:4];
assign wmb_ce_hit_sq_pop_addr_tto4    = wmb_ce_hit_sq_pop_addr_tto6
                                        &&  wmb_ce_hit_sq_pop_addr_5to4;

assign wmb_ce_hit_sq_pop_dcache_line  = wmb_ce_hit_sq_pop_addr_tto6
                                        &&  wmb_ce_st_inst
                                        &&  wmb_ce_vld;

//if supv mode or page info is not hit, then set write_imme and donot grnt
//signal to sq
// &Force("output","wmb_ce_merge_data_addr_hit"); @337
assign wmb_ce_merge_data_addr_hit     = wmb_ce_hit_sq_pop_addr_tto4
                                        &&  wmb_ce_merge_en
                                        &&  wmb_ce_vld;

assign wmb_ce_merge_data_permit       = wmb_ce_priv_mode[1:0]  ==  sq_pop_priv_mode[1:0];

assign wmb_ce_merge_data_stall        = wmb_ce_merge_data_addr_hit
                                        &&  !wmb_ce_merge_data_permit;

// &ModuleEnd; @347
endmodule


