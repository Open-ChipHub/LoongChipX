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
module ct_lsu_lfb_addr_entry (
  // &Ports, @27
  input    wire          cp0_lsu_dcache_en,
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [7 :0]  ld_da_idx,
  input    wire          ld_da_lfb_discard_grnt,
  input    wire          lfb_addr_entry_create_gateclk_en_x,
  input    wire          lfb_addr_entry_pfu_create_dp_vld_x,
  input    wire          lfb_addr_entry_pfu_create_vld_x,
  input    wire          lfb_addr_entry_rb_create_dp_vld_x,
  input    wire          lfb_addr_entry_rb_create_vld_x,
  input    wire          lfb_addr_entry_resp_set_x,
  input    wire          lfb_addr_entry_vb_pe_req_grnt_x,
  input    wire          lfb_data_addr_pop_req_x,
  input    wire          lfb_lf_sm_addr_pop_req_x,
  input    wire          lfb_vb_pe_req,
  input    wire          lfb_vb_pe_req_permit,
  input    wire          lm_already_snoop,
  input    wire          lsu_special_clk,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [39:0]  pfu_biu_req_addr,
  input    wire  [3 :0]  pfu_lfb_id,
  input    wire  [39:0]  rb_biu_req_addr,
  input    wire  [35:0]  rb_lfb_addr_tto4,
  input    wire          rb_lfb_atomic,
  input    wire          rb_lfb_depd,
  input    wire          rb_lfb_ldamo,
  input    wire  [33:0]  snq_bypass_addr_tto6,
  input    wire  [39:0]  st_da_addr,
  input    wire          vb_lfb_addr_entry_rcl_done_x,
  input    wire          vb_lfb_dcache_dirty,
  input    wire          vb_lfb_dcache_hit,
  input    wire          vb_lfb_dcache_way,
  input    wire  [39:0]  wmb_read_req_addr,
  input    wire  [39:0]  wmb_write_req_addr,
  output   wire          ld_hit_prefetch_first_x,
  output   wire  [35:0]  lfb_addr_entry_addr_tto4_v,
  output   wire          lfb_addr_entry_dcache_hit_x,
  output   wire          lfb_addr_entry_depd_x,
  output   wire          lfb_addr_entry_discard_vld_x,
  output   wire          lfb_addr_entry_ld_da_hit_idx_x,
  output   wire          lfb_addr_entry_ldamo_x,
  output   wire          lfb_addr_entry_linefill_abort_x,
  output   wire          lfb_addr_entry_linefill_permit_x,
  output   wire          lfb_addr_entry_not_resp_x,
  output   wire          lfb_addr_entry_pfu_biu_req_hit_idx_x,
  output   wire  [8 :0]  lfb_addr_entry_pfu_dcache_hit_v,
  output   wire  [8 :0]  lfb_addr_entry_pfu_dcache_miss_v,
  output   wire          lfb_addr_entry_pop_vld_x,
  output   wire          lfb_addr_entry_rb_biu_req_hit_idx_x,
  output   wire          lfb_addr_entry_rcl_done_x,
  output   wire          lfb_addr_entry_refill_way_x,
  output   wire          lfb_addr_entry_snq_bypass_hit_x,
  output   wire          lfb_addr_entry_st_da_hit_idx_x,
  output   wire          lfb_addr_entry_vb_pe_req_x,
  output   wire          lfb_addr_entry_vld_x,
  output   wire          lfb_addr_entry_wmb_read_req_hit_idx_x,
  output   wire          lfb_addr_entry_wmb_write_req_hit_idx_x
); 



// &Regs; @28
reg     [35:0]  lfb_addr_entry_addr_tto4;               
reg             lfb_addr_entry_already_reply;           
reg             lfb_addr_entry_atomic;                  
reg             lfb_addr_entry_dcache_dirty;            
reg             lfb_addr_entry_dcache_hit;              
reg             lfb_addr_entry_depd;                    
reg             lfb_addr_entry_ldamo;                   
reg             lfb_addr_entry_pfu_create;              
reg     [3 :0]  lfb_addr_entry_pfu_id;                  
reg             lfb_addr_entry_rcl_done;                
reg             lfb_addr_entry_refill_way;              
reg             lfb_addr_entry_resp;                    
reg             lfb_addr_entry_vb_pe_req_success;       
reg             lfb_addr_entry_vld;                     

// &Wires; @29
wire            ld_hit_prefetch_first;                  
wire            lfb_addr_entry_atomic_abort;            
wire            lfb_addr_entry_clk;                     
wire            lfb_addr_entry_clk_en;                  
wire    [39:0]  lfb_addr_entry_cmp_pfu_biu_req_addr;    
wire    [39:0]  lfb_addr_entry_cmp_rb_biu_req_addr;     
wire    [33:0]  lfb_addr_entry_cmp_snq_bypass_addr_tto6; 
wire    [39:0]  lfb_addr_entry_cmp_st_da_addr;          
wire    [39:0]  lfb_addr_entry_cmp_wmb_read_req_addr;   
wire    [39:0]  lfb_addr_entry_cmp_wmb_write_req_addr;  
wire            lfb_addr_entry_create_clk;              
wire            lfb_addr_entry_create_clk_en;           
wire            lfb_addr_entry_create_dp_vld;           
wire            lfb_addr_entry_create_gateclk_en;       
wire            lfb_addr_entry_discard_vld;             
wire            lfb_addr_entry_ld_da_hit_idx;           
wire            lfb_addr_entry_linefill_abort;          
wire            lfb_addr_entry_linefill_permit;         
wire            lfb_addr_entry_not_resp;                
wire            lfb_addr_entry_pfu_biu_req_hit_idx;     
wire            lfb_addr_entry_pfu_create_dp_vld;       
wire            lfb_addr_entry_pfu_create_vld;          
wire    [8 :0]  lfb_addr_entry_pfu_dcache_hit;          
wire            lfb_addr_entry_pfu_dcache_hit_vld;      
wire    [8 :0]  lfb_addr_entry_pfu_dcache_miss;         
wire            lfb_addr_entry_pfu_dcache_miss_vld;     
wire    [8 :0]  lfb_addr_entry_pfu_id_oh;               
wire            lfb_addr_entry_pfu_reply_vld;           
wire            lfb_addr_entry_pop_vld;                 
wire            lfb_addr_entry_rb_biu_req_hit_idx;      
wire            lfb_addr_entry_rb_create_dp_vld;        
wire            lfb_addr_entry_rb_create_vld;           
wire            lfb_addr_entry_resp_set;                
wire            lfb_addr_entry_snq_bypass_hit;          
wire            lfb_addr_entry_st_da_hit_idx;           
wire            lfb_addr_entry_vb_pe_req;               
wire            lfb_addr_entry_vb_pe_req_grnt;          
wire            lfb_addr_entry_vb_pe_req_success_set;   
wire            lfb_addr_entry_wmb_read_req_hit_idx;    
wire            lfb_addr_entry_wmb_write_req_hit_idx;   
wire            lfb_data_addr_pop_req;                  
wire            lfb_lf_sm_addr_pop_req;                 
wire            vb_lfb_addr_entry_rcl_done;             



//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//-----------entry gateclk--------------
//normal gateclk ,open when create || entry_vld
assign lfb_addr_entry_clk_en  = lfb_addr_entry_vld
                                ||  lfb_addr_entry_create_clk_en;
// &Instance("gated_clk_cell", "x_lsu_lfb_addr_entry_gated_clk"); @39
gated_clk_cell  x_lsu_lfb_addr_entry_gated_clk (
  .clk_in                (lsu_special_clk      ),
  .clk_out               (lfb_addr_entry_clk   ),
  .external_en           (1'b0                 ),
  .global_en             (cp0_yy_clk_en        ),
  .local_en              (lfb_addr_entry_clk_en),
  .module_en             (cp0_lsu_icg_en       ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);

// &Connect(.clk_in        (lsu_special_clk     ), @40
//          .external_en   (1'b0               ), @41
//          .global_en     (cp0_yy_clk_en      ), @42
//          .module_en     (cp0_lsu_icg_en     ), @43
//          .local_en      (lfb_addr_entry_clk_en), @44
//          .clk_out       (lfb_addr_entry_clk )); @45

//-----------create gateclk-------------
assign lfb_addr_entry_create_clk_en = lfb_addr_entry_create_gateclk_en;
// &Instance("gated_clk_cell", "x_lsu_lfb_addr_entry_create_gated_clk"); @49
gated_clk_cell  x_lsu_lfb_addr_entry_create_gated_clk (
  .clk_in                       (lsu_special_clk             ),
  .clk_out                      (lfb_addr_entry_create_clk   ),
  .external_en                  (1'b0                        ),
  .global_en                    (cp0_yy_clk_en               ),
  .local_en                     (lfb_addr_entry_create_clk_en),
  .module_en                    (cp0_lsu_icg_en              ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          )
);

// &Connect(.clk_in        (lsu_special_clk     ), @50
//          .external_en   (1'b0               ), @51
//          .global_en     (cp0_yy_clk_en      ), @52
//          .module_en     (cp0_lsu_icg_en     ), @53
//          .local_en      (lfb_addr_entry_create_clk_en), @54
//          .clk_out       (lfb_addr_entry_create_clk)); @55

//==========================================================
//                 Register
//==========================================================
//+-----------+
//| entry_vld |
//+-----------+
always @(posedge lfb_addr_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_addr_entry_vld              <=  1'b0;
  else if(lfb_addr_entry_pop_vld)
    lfb_addr_entry_vld              <=  1'b0;
  else if(lfb_addr_entry_rb_create_vld  ||  lfb_addr_entry_pfu_create_vld)
    lfb_addr_entry_vld              <=  1'b1;
end

//+------+--------+
//| addr | pfu_id |
//+------+--------+
always @(posedge lfb_addr_entry_create_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    lfb_addr_entry_pfu_create       <=  1'b0;
    lfb_addr_entry_atomic           <=  1'b0;
    lfb_addr_entry_ldamo            <=  1'b0;
    lfb_addr_entry_pfu_id[3:0]      <=  4'b0;
    lfb_addr_entry_addr_tto4[`PA_WIDTH-5:0]  <=  {`PA_WIDTH-4{1'b0}};
  end
  else if(lfb_addr_entry_rb_create_dp_vld)
  begin
    lfb_addr_entry_pfu_create       <=  1'b0;
    lfb_addr_entry_atomic           <=  rb_lfb_atomic;
    lfb_addr_entry_ldamo            <=  rb_lfb_ldamo;
    lfb_addr_entry_pfu_id[3:0]      <=  4'b0;
    lfb_addr_entry_addr_tto4[`PA_WIDTH-5:0]  <=  rb_lfb_addr_tto4[`PA_WIDTH-5:0];
  end
  else if(lfb_addr_entry_pfu_create_dp_vld)
  begin
    lfb_addr_entry_pfu_create       <=  1'b1;
    lfb_addr_entry_atomic           <=  1'b0;
    lfb_addr_entry_ldamo            <=  1'b0;
    lfb_addr_entry_pfu_id[3:0]      <=  pfu_lfb_id[3:0];
    lfb_addr_entry_addr_tto4[`PA_WIDTH-5:0]  <=  pfu_biu_req_addr[39:4];
  end
end

//+--------------------+
//| vb_pe_req_success |
//+--------------------+
always @(posedge lfb_addr_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_addr_entry_vb_pe_req_success    <=  1'b0;
  else if(lfb_addr_entry_vb_pe_req_success_set)
    lfb_addr_entry_vb_pe_req_success    <=  1'b1;
  else if(lfb_addr_entry_create_dp_vld)
    lfb_addr_entry_vb_pe_req_success    <=  !cp0_lsu_dcache_en;
end

//+-----------------+
//| cache line info |
//+-----------------+
always @(posedge lfb_addr_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    lfb_addr_entry_rcl_done     <=  1'b0;
    lfb_addr_entry_refill_way   <=  1'b0;
    lfb_addr_entry_dcache_hit   <=  1'b0;
    lfb_addr_entry_dcache_dirty <=  1'b0;
  end
  else if(lfb_addr_entry_create_dp_vld)
  begin
    lfb_addr_entry_rcl_done     <=  !cp0_lsu_dcache_en;
    lfb_addr_entry_refill_way   <=  1'b0;
    lfb_addr_entry_dcache_hit   <=  1'b0;
    lfb_addr_entry_dcache_dirty <=  1'b0;
  end
  else if(vb_lfb_addr_entry_rcl_done)
  begin
    lfb_addr_entry_rcl_done     <=  1'b1;
    lfb_addr_entry_refill_way   <=  vb_lfb_dcache_way;
    lfb_addr_entry_dcache_hit   <=  vb_lfb_dcache_hit;
    lfb_addr_entry_dcache_dirty <=  vb_lfb_dcache_dirty;
  end
end

//+---------------+
//| already_reply |
//+---------------+
//if pfu create dcache hit, then reply dcache hit signal to prb
always @(posedge lfb_addr_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_addr_entry_already_reply  <=  1'b0;
  else if(lfb_addr_entry_create_dp_vld)
    lfb_addr_entry_already_reply  <=  1'b0;
  else if(lfb_addr_entry_rcl_done)
    lfb_addr_entry_already_reply  <=  1'b1;
end

//+------+
//| depd |
//+------+
always @(posedge lfb_addr_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_addr_entry_depd         <=  1'b0;
  else if(lfb_addr_entry_rb_create_dp_vld)
    lfb_addr_entry_depd         <=  rb_lfb_depd;
  else if(lfb_addr_entry_pfu_create_dp_vld)
    lfb_addr_entry_depd         <=  1'b0;
  else if(lfb_addr_entry_discard_vld)
    lfb_addr_entry_depd         <=  1'b1;
end

//+------+
//| resp |
//+------+
always @(posedge lfb_addr_entry_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_addr_entry_resp         <=  1'b0;
  else if(lfb_addr_entry_create_dp_vld)
    lfb_addr_entry_resp         <=  1'b0;
  else if(lfb_addr_entry_resp_set)
    lfb_addr_entry_resp         <=  1'b1;
end


//==========================================================
//                 Generate create signal
//==========================================================
assign lfb_addr_entry_create_dp_vld = lfb_addr_entry_rb_create_dp_vld
                                      ||  lfb_addr_entry_pfu_create_dp_vld;
//==========================================================
//                 Generate vb req siganl
//==========================================================
assign lfb_addr_entry_vb_pe_req    = lfb_addr_entry_vld
                                      &&  !lfb_addr_entry_vb_pe_req_success;

assign lfb_addr_entry_vb_pe_req_success_set   = lfb_addr_entry_create_dp_vld
                                                    &&  lfb_vb_pe_req_permit
                                                    &&  !lfb_vb_pe_req
                                                ||  lfb_addr_entry_vb_pe_req
                                                    &&  lfb_addr_entry_vb_pe_req_grnt;

//==========================================================
//            Linefill permit
//==========================================================
// &Force("nonport","lfb_addr_entry_dcache_dirty"); @208
assign lfb_addr_entry_atomic_abort  = !lm_already_snoop
                                      &&  lfb_addr_entry_dcache_hit;
//                                      &&  lfb_addr_entry_dcache_dirty;
assign lfb_addr_entry_linefill_permit = lfb_addr_entry_rcl_done
                                        &&  (!lfb_addr_entry_dcache_hit
                                            ||  lfb_addr_entry_atomic
                                                &&  !lfb_addr_entry_atomic_abort);
assign lfb_addr_entry_linefill_abort  = lfb_addr_entry_rcl_done
                                        &&  lfb_addr_entry_dcache_hit
                                        &&  (lfb_addr_entry_pfu_create
                                            ||  lfb_addr_entry_atomic
                                                &&  lfb_addr_entry_atomic_abort);

//for rready
assign lfb_addr_entry_not_resp  = lfb_addr_entry_vld
                                  &&  !lfb_addr_entry_resp; 
//==========================================================
//            Reply dcache hit signal to pfu
//==========================================================
//decode
assign lfb_addr_entry_pfu_id_oh[0]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd0;
assign lfb_addr_entry_pfu_id_oh[1]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd1;
assign lfb_addr_entry_pfu_id_oh[2]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd2;
assign lfb_addr_entry_pfu_id_oh[3]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd3;
assign lfb_addr_entry_pfu_id_oh[4]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd4;
assign lfb_addr_entry_pfu_id_oh[5]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd5;
assign lfb_addr_entry_pfu_id_oh[6]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd6;
assign lfb_addr_entry_pfu_id_oh[7]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd7;
assign lfb_addr_entry_pfu_id_oh[8]  = lfb_addr_entry_pfu_id[3:0]  ==  4'd8;

assign lfb_addr_entry_pfu_reply_vld       = lfb_addr_entry_vld
                                            &&  lfb_addr_entry_pfu_create
                                            &&  lfb_addr_entry_rcl_done
                                            &&  !lfb_addr_entry_already_reply;

assign lfb_addr_entry_pfu_dcache_hit_vld  = lfb_addr_entry_pfu_reply_vld
                                            &&  lfb_addr_entry_dcache_hit;
assign lfb_addr_entry_pfu_dcache_miss_vld = lfb_addr_entry_pfu_reply_vld
                                            &&  !lfb_addr_entry_dcache_hit;

assign lfb_addr_entry_pfu_dcache_hit[8:0] = {9{lfb_addr_entry_pfu_dcache_hit_vld}}
                                            & lfb_addr_entry_pfu_id_oh[8:0];

assign lfb_addr_entry_pfu_dcache_miss[8:0]= {9{lfb_addr_entry_pfu_dcache_miss_vld}}
                                            & lfb_addr_entry_pfu_id_oh[8:0];

//==========================================================
//                 Generate pop signal
//==========================================================
assign lfb_addr_entry_pop_vld       = lfb_lf_sm_addr_pop_req
                                      ||  lfb_data_addr_pop_req;

//==========================================================
//                    Compare index
//==========================================================
//------------------compare ld_da stage---------------------
assign lfb_addr_entry_ld_da_hit_idx   = lfb_addr_entry_vld
                                        &&  (lfb_addr_entry_addr_tto4[9:2]
                                            ==  ld_da_idx[7:0]);
//------------------compare st_da stage---------------------
assign lfb_addr_entry_cmp_st_da_addr[`PA_WIDTH-1:0]  = st_da_addr[`PA_WIDTH-1:0];
assign lfb_addr_entry_st_da_hit_idx   = lfb_addr_entry_vld
                                        &&  (lfb_addr_entry_addr_tto4[9:2]
                                            ==  lfb_addr_entry_cmp_st_da_addr[13:6]);
//------------------depd_vld--------------------------------
assign lfb_addr_entry_discard_vld = ld_da_lfb_discard_grnt
                                    &&  lfb_addr_entry_ld_da_hit_idx;

//----------------compare rb biu req entry------------------
assign lfb_addr_entry_cmp_rb_biu_req_addr[`PA_WIDTH-1:0] = rb_biu_req_addr[`PA_WIDTH-1:0];
assign lfb_addr_entry_rb_biu_req_hit_idx  = lfb_addr_entry_vld
                                            &&  (lfb_addr_entry_addr_tto4[9:2]
                                                ==  lfb_addr_entry_cmp_rb_biu_req_addr[13:6]);
//------------------compare pfu pop entry-------------------
assign lfb_addr_entry_cmp_pfu_biu_req_addr[`PA_WIDTH-1:0]  = pfu_biu_req_addr[`PA_WIDTH-1:0];
assign lfb_addr_entry_pfu_biu_req_hit_idx = lfb_addr_entry_vld
                                            &&  (lfb_addr_entry_addr_tto4[9:2]
                                                ==  lfb_addr_entry_cmp_pfu_biu_req_addr[13:6]);
//------------------compare wmb read req--------------------
assign lfb_addr_entry_cmp_wmb_read_req_addr[`PA_WIDTH-1:0] = wmb_read_req_addr[`PA_WIDTH-1:0];
assign lfb_addr_entry_wmb_read_req_hit_idx  = lfb_addr_entry_vld
                                              &&  (lfb_addr_entry_addr_tto4[9:2]
                                                  ==  lfb_addr_entry_cmp_wmb_read_req_addr[13:6]);
//------------------compare wmb write req-------------------
assign lfb_addr_entry_cmp_wmb_write_req_addr[`PA_WIDTH-1:0] = wmb_write_req_addr[`PA_WIDTH-1:0];
assign lfb_addr_entry_wmb_write_req_hit_idx = lfb_addr_entry_vld
                                              &&  (lfb_addr_entry_addr_tto4[9:2]
                                                  ==  lfb_addr_entry_cmp_wmb_write_req_addr[13:6]);
//------------------compare snq create port-----------------
//snq only compare with addr with already received response
//assign lfb_addr_entry_cmp_snq_create_addr[`PA_WIDTH-1:0] = snq_create_addr[`PA_WIDTH-1:0];
//assign lfb_addr_entry_snq_create_hit_idx    = lfb_addr_entry_vld
//                                              &&  lfb_addr_entry_resp
//                                              &&  (lfb_addr_entry_addr_tto4[9:2]
//                                                  ==  lfb_addr_entry_cmp_snq_create_addr[13:6]);
//---------------compare snq bypass req addr----------------
assign lfb_addr_entry_cmp_snq_bypass_addr_tto6[`PA_WIDTH-7:0]  = snq_bypass_addr_tto6[`PA_WIDTH-7:0];
assign lfb_addr_entry_snq_bypass_hit          = lfb_addr_entry_vld
                                                &&  lfb_addr_entry_resp
                                                &&  !lfb_addr_entry_rcl_done
                                                &&  (lfb_addr_entry_addr_tto4[`PA_WIDTH-5:2]
                                                    ==  lfb_addr_entry_cmp_snq_bypass_addr_tto6[`PA_WIDTH-7:0]);
//==========================================================
//                 Generate interface
//==========================================================
//------------------input-----------------------------------
//-----------create signal--------------
assign lfb_addr_entry_rb_create_vld           = lfb_addr_entry_rb_create_vld_x;
assign lfb_addr_entry_rb_create_dp_vld        = lfb_addr_entry_rb_create_dp_vld_x;
assign lfb_addr_entry_pfu_create_vld          = lfb_addr_entry_pfu_create_vld_x;
assign lfb_addr_entry_pfu_create_dp_vld       = lfb_addr_entry_pfu_create_dp_vld_x;
assign lfb_addr_entry_create_gateclk_en       = lfb_addr_entry_create_gateclk_en_x;
//-----------grnt signal----------------
assign lfb_addr_entry_vb_pe_req_grnt         = lfb_addr_entry_vb_pe_req_grnt_x;
//-----------other signal---------------
assign vb_lfb_addr_entry_rcl_done             = vb_lfb_addr_entry_rcl_done_x;
assign lfb_data_addr_pop_req                  = lfb_data_addr_pop_req_x;
assign lfb_lf_sm_addr_pop_req                 = lfb_lf_sm_addr_pop_req_x;
assign lfb_addr_entry_resp_set                = lfb_addr_entry_resp_set_x;
//------------------output----------------------------------
//-----------entry signal---------------
assign lfb_addr_entry_vld_x                   = lfb_addr_entry_vld;
assign lfb_addr_entry_addr_tto4_v[`PA_WIDTH-5:0]  = lfb_addr_entry_addr_tto4[`PA_WIDTH-5:0];
assign lfb_addr_entry_refill_way_x            = lfb_addr_entry_refill_way;
assign lfb_addr_entry_depd_x                  = lfb_addr_entry_depd;
//assign lfb_addr_entry_resp_x                  = lfb_addr_entry_resp;
assign lfb_addr_entry_rcl_done_x              = lfb_addr_entry_rcl_done;
assign lfb_addr_entry_dcache_hit_x            = lfb_addr_entry_dcache_hit;
assign lfb_addr_entry_ldamo_x                 = lfb_addr_entry_ldamo;
assign lfb_addr_entry_not_resp_x              = lfb_addr_entry_not_resp;
//-----------request--------------------
assign lfb_addr_entry_vb_pe_req_x             = lfb_addr_entry_vb_pe_req;
assign lfb_addr_entry_pop_vld_x               = lfb_addr_entry_pop_vld;
assign lfb_addr_entry_discard_vld_x           = lfb_addr_entry_discard_vld;
assign lfb_addr_entry_pfu_dcache_hit_v[8:0]   = lfb_addr_entry_pfu_dcache_hit[8:0];
assign lfb_addr_entry_pfu_dcache_miss_v[8:0]  = lfb_addr_entry_pfu_dcache_miss[8:0];
//---------linefill info----------------
assign lfb_addr_entry_linefill_permit_x       = lfb_addr_entry_linefill_permit;
assign lfb_addr_entry_linefill_abort_x        = lfb_addr_entry_linefill_abort;
//-----------hit idx--------------------
assign lfb_addr_entry_ld_da_hit_idx_x         = lfb_addr_entry_ld_da_hit_idx;
assign lfb_addr_entry_st_da_hit_idx_x         = lfb_addr_entry_st_da_hit_idx;
assign lfb_addr_entry_rb_biu_req_hit_idx_x    = lfb_addr_entry_rb_biu_req_hit_idx;
assign lfb_addr_entry_pfu_biu_req_hit_idx_x   = lfb_addr_entry_pfu_biu_req_hit_idx;
assign lfb_addr_entry_wmb_read_req_hit_idx_x  = lfb_addr_entry_wmb_read_req_hit_idx;
assign lfb_addr_entry_wmb_write_req_hit_idx_x = lfb_addr_entry_wmb_write_req_hit_idx;
//assign lfb_addr_entry_snq_create_hit_idx_x    = lfb_addr_entry_snq_create_hit_idx;
assign lfb_addr_entry_snq_bypass_hit_x        = lfb_addr_entry_snq_bypass_hit;

//==========================================================
//        interface to hpcp
//==========================================================
assign ld_hit_prefetch_first   = lfb_addr_entry_ld_da_hit_idx 
                                 && lfb_addr_entry_pfu_create 
                                 && !lfb_addr_entry_depd; 

assign ld_hit_prefetch_first_x = ld_hit_prefetch_first;
// &ModuleEnd; @368
endmodule


