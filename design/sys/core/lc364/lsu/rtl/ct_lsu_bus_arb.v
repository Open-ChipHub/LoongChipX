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

// &ModuleBeg; @23
module ct_lsu_bus_arb (
  // &Ports, @24
  input    wire           biu_lsu_ar_ready,
  input    wire           biu_lsu_aw_vb_grnt,
  input    wire           biu_lsu_aw_wmb_grnt,
  input    wire           biu_lsu_w_vb_grnt,
  input    wire           biu_lsu_w_wmb_grnt,
  input    wire           cp0_lsu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [39 :0]  pfu_biu_ar_addr,
  input    wire  [1  :0]  pfu_biu_ar_bar,
  input    wire  [1  :0]  pfu_biu_ar_burst,
  input    wire  [3  :0]  pfu_biu_ar_cache,
  input    wire  [1  :0]  pfu_biu_ar_domain,
  input    wire           pfu_biu_ar_dp_req,
  input    wire  [4  :0]  pfu_biu_ar_id,
  input    wire  [1  :0]  pfu_biu_ar_len,
  input    wire           pfu_biu_ar_lock,
  input    wire  [2  :0]  pfu_biu_ar_prot,
  input    wire           pfu_biu_ar_req,
  input    wire           pfu_biu_ar_req_gateclk_en,
  input    wire  [2  :0]  pfu_biu_ar_size,
  input    wire  [3  :0]  pfu_biu_ar_snoop,
  input    wire  [2  :0]  pfu_biu_ar_user,
  input    wire  [39 :0]  rb_biu_ar_addr,
  input    wire  [1  :0]  rb_biu_ar_bar,
  input    wire  [1  :0]  rb_biu_ar_burst,
  input    wire  [3  :0]  rb_biu_ar_cache,
  input    wire  [1  :0]  rb_biu_ar_domain,
  input    wire           rb_biu_ar_dp_req,
  input    wire  [4  :0]  rb_biu_ar_id,
  input    wire  [1  :0]  rb_biu_ar_len,
  input    wire           rb_biu_ar_lock,
  input    wire  [2  :0]  rb_biu_ar_prot,
  input    wire           rb_biu_ar_req,
  input    wire           rb_biu_ar_req_gateclk_en,
  input    wire  [2  :0]  rb_biu_ar_size,
  input    wire  [3  :0]  rb_biu_ar_snoop,
  input    wire  [2  :0]  rb_biu_ar_user,
  input    wire  [39 :0]  vb_biu_aw_addr,
  input    wire  [1  :0]  vb_biu_aw_bar,
  input    wire  [1  :0]  vb_biu_aw_burst,
  input    wire  [3  :0]  vb_biu_aw_cache,
  input    wire  [1  :0]  vb_biu_aw_domain,
  input    wire           vb_biu_aw_dp_req,
  input    wire  [4  :0]  vb_biu_aw_id,
  input    wire  [1  :0]  vb_biu_aw_len,
  input    wire           vb_biu_aw_lock,
  input    wire  [2  :0]  vb_biu_aw_prot,
  input    wire           vb_biu_aw_req,
  input    wire           vb_biu_aw_req_gateclk_en,
  input    wire  [2  :0]  vb_biu_aw_size,
  input    wire  [2  :0]  vb_biu_aw_snoop,
  input    wire           vb_biu_aw_unique,
  input    wire           vb_biu_aw_user,
  input    wire  [127:0]  vb_biu_w_data,
  input    wire  [4  :0]  vb_biu_w_id,
  input    wire           vb_biu_w_last,
  input    wire           vb_biu_w_req,
  input    wire  [15 :0]  vb_biu_w_strb,
  input    wire           vb_biu_w_vld,
  input    wire  [39 :0]  wmb_biu_ar_addr,
  input    wire  [1  :0]  wmb_biu_ar_bar,
  input    wire  [1  :0]  wmb_biu_ar_burst,
  input    wire  [3  :0]  wmb_biu_ar_cache,
  input    wire  [1  :0]  wmb_biu_ar_domain,
  input    wire           wmb_biu_ar_dp_req,
  input    wire  [4  :0]  wmb_biu_ar_id,
  input    wire  [1  :0]  wmb_biu_ar_len,
  input    wire           wmb_biu_ar_lock,
  input    wire  [2  :0]  wmb_biu_ar_prot,
  input    wire           wmb_biu_ar_req,
  input    wire           wmb_biu_ar_req_gateclk_en,
  input    wire  [2  :0]  wmb_biu_ar_size,
  input    wire  [3  :0]  wmb_biu_ar_snoop,
  input    wire  [2  :0]  wmb_biu_ar_user,
  input    wire  [39 :0]  wmb_biu_aw_addr,
  input    wire  [1  :0]  wmb_biu_aw_bar,
  input    wire  [1  :0]  wmb_biu_aw_burst,
  input    wire  [3  :0]  wmb_biu_aw_cache,
  input    wire  [1  :0]  wmb_biu_aw_domain,
  input    wire           wmb_biu_aw_dp_req,
  input    wire  [4  :0]  wmb_biu_aw_id,
  input    wire  [1  :0]  wmb_biu_aw_len,
  input    wire           wmb_biu_aw_lock,
  input    wire  [2  :0]  wmb_biu_aw_prot,
  input    wire           wmb_biu_aw_req,
  input    wire           wmb_biu_aw_req_gateclk_en,
  input    wire  [2  :0]  wmb_biu_aw_size,
  input    wire  [2  :0]  wmb_biu_aw_snoop,
  input    wire           wmb_biu_aw_user,
  input    wire  [127:0]  wmb_biu_w_data,
  input    wire  [4  :0]  wmb_biu_w_id,
  input    wire           wmb_biu_w_last,
  input    wire           wmb_biu_w_req,
  input    wire  [15 :0]  wmb_biu_w_strb,
  input    wire           wmb_biu_w_vld,
  input    wire           wmb_biu_w_wns,
  output   wire           bus_arb_pfu_ar_grnt,
  output   wire           bus_arb_pfu_ar_ready,
  output   wire           bus_arb_pfu_ar_sel,
  output   wire           bus_arb_rb_ar_grnt,
  output   wire           bus_arb_rb_ar_sel,
  output   wire           bus_arb_vb_aw_grnt,
  output   wire           bus_arb_vb_w_grnt,
  output   wire           bus_arb_wmb_ar_grnt,
  output   wire           bus_arb_wmb_aw_grnt,
  output   wire           bus_arb_wmb_w_grnt,
  output   wire  [39 :0]  lsu_biu_ar_addr,
  output   wire  [1  :0]  lsu_biu_ar_bar,
  output   wire  [1  :0]  lsu_biu_ar_burst,
  output   wire  [3  :0]  lsu_biu_ar_cache,
  output   wire  [1  :0]  lsu_biu_ar_domain,
  output   wire           lsu_biu_ar_dp_req,
  output   wire  [4  :0]  lsu_biu_ar_id,
  output   wire  [1  :0]  lsu_biu_ar_len,
  output   wire           lsu_biu_ar_lock,
  output   wire  [2  :0]  lsu_biu_ar_prot,
  output   wire           lsu_biu_ar_req,
  output   wire           lsu_biu_ar_req_gate,
  output   wire  [2  :0]  lsu_biu_ar_size,
  output   wire  [3  :0]  lsu_biu_ar_snoop,
  output   wire  [2  :0]  lsu_biu_ar_user,
  output   wire           lsu_biu_aw_req_gate,
  output   wire  [39 :0]  lsu_biu_aw_st_addr,
  output   wire  [1  :0]  lsu_biu_aw_st_bar,
  output   wire  [1  :0]  lsu_biu_aw_st_burst,
  output   wire  [3  :0]  lsu_biu_aw_st_cache,
  output   wire  [1  :0]  lsu_biu_aw_st_domain,
  output   wire           lsu_biu_aw_st_dp_req,
  output   wire  [4  :0]  lsu_biu_aw_st_id,
  output   wire  [1  :0]  lsu_biu_aw_st_len,
  output   wire           lsu_biu_aw_st_lock,
  output   wire  [2  :0]  lsu_biu_aw_st_prot,
  output   wire           lsu_biu_aw_st_req,
  output   wire  [2  :0]  lsu_biu_aw_st_size,
  output   wire  [2  :0]  lsu_biu_aw_st_snoop,
  output   wire           lsu_biu_aw_st_unique,
  output   wire           lsu_biu_aw_st_user,
  output   wire  [39 :0]  lsu_biu_aw_vict_addr,
  output   wire  [1  :0]  lsu_biu_aw_vict_bar,
  output   wire  [1  :0]  lsu_biu_aw_vict_burst,
  output   wire  [3  :0]  lsu_biu_aw_vict_cache,
  output   wire  [1  :0]  lsu_biu_aw_vict_domain,
  output   wire           lsu_biu_aw_vict_dp_req,
  output   wire  [4  :0]  lsu_biu_aw_vict_id,
  output   wire  [1  :0]  lsu_biu_aw_vict_len,
  output   wire           lsu_biu_aw_vict_lock,
  output   wire  [2  :0]  lsu_biu_aw_vict_prot,
  output   wire           lsu_biu_aw_vict_req,
  output   wire  [2  :0]  lsu_biu_aw_vict_size,
  output   wire  [2  :0]  lsu_biu_aw_vict_snoop,
  output   wire           lsu_biu_aw_vict_unique,
  output   wire           lsu_biu_aw_vict_user,
  output   wire  [127:0]  lsu_biu_w_st_data,
  output   wire           lsu_biu_w_st_last,
  output   wire  [15 :0]  lsu_biu_w_st_strb,
  output   wire           lsu_biu_w_st_vld,
  output   wire           lsu_biu_w_st_wns,
  output   wire  [127:0]  lsu_biu_w_vict_data,
  output   wire           lsu_biu_w_vict_last,
  output   wire  [15 :0]  lsu_biu_w_vict_strb,
  output   wire           lsu_biu_w_vict_vld,
  output   wire           lsu_biu_w_vict_wns
); 



// &Regs; @25
reg              bus_arb_pfu_mask;          
reg              bus_arb_rb_mask;           
reg              bus_arb_wmb_mask;          

// &Wires; @26
wire             bus_arb_mask_clk;          
wire             bus_arb_mask_clk_en;       
wire             bus_arb_pfu_ar_dp_req_real; 
wire             bus_arb_rb_ar_dp_req_real; 
wire             bus_arb_wmb_ar_dp_req_real; 
wire             bus_arb_wmb_ar_sel;        


parameter W_FIFO_ENTRY  = 12;
parameter WU            = 3'b000;
parameter WLU           = 3'b001;
//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign bus_arb_mask_clk_en  = rb_biu_ar_req_gateclk_en
                              ||  wmb_biu_ar_req_gateclk_en
															||	pfu_biu_ar_req_gateclk_en
                              ||  bus_arb_wmb_mask
                              ||  bus_arb_rb_mask
                              ||  bus_arb_pfu_mask;
// &Instance("gated_clk_cell", "x_lsu_bus_arb_mask_gated_clk"); @40
gated_clk_cell  x_lsu_bus_arb_mask_gated_clk (
  .clk_in              (forever_cpuclk     ),
  .clk_out             (bus_arb_mask_clk   ),
  .external_en         (1'b0               ),
  .global_en           (cp0_yy_clk_en      ),
  .local_en            (bus_arb_mask_clk_en),
  .module_en           (cp0_lsu_icg_en     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en )
);

// &Connect(.clk_in        (forever_cpuclk     ), @41
//          .external_en   (1'b0               ), @42
//          .global_en     (cp0_yy_clk_en      ), @43
//          .module_en     (cp0_lsu_icg_en     ), @44
//          .local_en      (bus_arb_mask_clk_en), @45
//          .clk_out       (bus_arb_mask_clk   )); @46

//==========================================================
//                    Mask Register
//==========================================================
always @(posedge bus_arb_mask_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bus_arb_wmb_mask    <=  1'b0;
  else if(wmb_biu_ar_dp_req &&  !wmb_biu_ar_req)
    bus_arb_wmb_mask    <=  1'b1;
  else
    bus_arb_wmb_mask    <=  1'b0;
end

always @(posedge bus_arb_mask_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bus_arb_rb_mask    <=  1'b0;
  else if(rb_biu_ar_dp_req &&  !rb_biu_ar_req)
    bus_arb_rb_mask    <=  1'b1;
  else
    bus_arb_rb_mask    <=  1'b0;
end

always @(posedge bus_arb_mask_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    bus_arb_pfu_mask    <=  1'b0;
  else if(pfu_biu_ar_dp_req &&  !pfu_biu_ar_req)
    bus_arb_pfu_mask    <=  1'b1;
  else
    bus_arb_pfu_mask    <=  1'b0;
end

//==========================================================
//                      AR channel
//==========================================================
//priority: WMB > RB > pfu
//-----------------generate grnt signal---------------------
assign bus_arb_wmb_ar_dp_req_real = wmb_biu_ar_dp_req
                                    &&  !bus_arb_wmb_mask;
assign bus_arb_rb_ar_dp_req_real  = rb_biu_ar_dp_req
                                    &&  !bus_arb_rb_mask;
assign bus_arb_pfu_ar_dp_req_real = pfu_biu_ar_dp_req
                                    &&  !bus_arb_pfu_mask;

assign bus_arb_wmb_ar_sel   = bus_arb_wmb_ar_dp_req_real;
assign bus_arb_wmb_ar_grnt  = biu_lsu_ar_ready
                              &&  bus_arb_wmb_ar_sel
                              &&  wmb_biu_ar_req;

// &Force("output","bus_arb_rb_ar_sel"); @98
assign bus_arb_rb_ar_sel    = !bus_arb_wmb_ar_dp_req_real
                              &&  bus_arb_rb_ar_dp_req_real;
assign bus_arb_rb_ar_grnt   = biu_lsu_ar_ready
                              &&  bus_arb_rb_ar_sel
                              &&  rb_biu_ar_req;

// &Force("output","bus_arb_pfu_ar_sel"); @105
assign bus_arb_pfu_ar_sel   = !bus_arb_wmb_ar_dp_req_real
                              &&  !bus_arb_rb_ar_dp_req_real
                              &&  bus_arb_pfu_ar_dp_req_real;
assign bus_arb_pfu_ar_grnt  = biu_lsu_ar_ready
                              &&  bus_arb_pfu_ar_sel
                              &&  pfu_biu_ar_req;
assign bus_arb_pfu_ar_ready = biu_lsu_ar_ready
                              &&  bus_arb_pfu_ar_sel;
//-----------------biu ar signal----------------------------
assign lsu_biu_ar_id[4:0]     = {5{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_id[4:0]
                                | {5{bus_arb_rb_ar_sel}}    & rb_biu_ar_id[4:0]
                                | {5{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_id[4:0];

assign lsu_biu_ar_addr[`PA_WIDTH-1:0]  = {`PA_WIDTH{bus_arb_wmb_ar_sel}}    & wmb_biu_ar_addr[`PA_WIDTH-1:0]
                                | {`PA_WIDTH{bus_arb_rb_ar_sel}}   & rb_biu_ar_addr[`PA_WIDTH-1:0]
                                | {`PA_WIDTH{bus_arb_pfu_ar_sel}}  & pfu_biu_ar_addr[`PA_WIDTH-1:0];

assign lsu_biu_ar_len[1:0]    = {2{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_len[1:0]
                                | {2{bus_arb_rb_ar_sel}}    & rb_biu_ar_len[1:0]
                                | {2{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_len[1:0];

assign lsu_biu_ar_size[2:0]   = {3{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_size[2:0]
                                | {3{bus_arb_rb_ar_sel}}    & rb_biu_ar_size[2:0]
                                | {3{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_size[2:0];

assign lsu_biu_ar_burst[1:0]  = {2{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_burst[1:0]
                                | {2{bus_arb_rb_ar_sel}}    & rb_biu_ar_burst[1:0]
                                | {2{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_burst[1:0];

assign lsu_biu_ar_lock        = bus_arb_wmb_ar_sel        &&  wmb_biu_ar_lock
                                ||  bus_arb_rb_ar_sel     &&  rb_biu_ar_lock
                                ||  bus_arb_pfu_ar_sel    &&  pfu_biu_ar_lock;

assign lsu_biu_ar_cache[3:0]  = {4{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_cache[3:0]
                                | {4{bus_arb_rb_ar_sel}}    & rb_biu_ar_cache[3:0]
                                | {4{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_cache[3:0];

assign lsu_biu_ar_prot[2:0]   = {3{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_prot[2:0]
                                | {3{bus_arb_rb_ar_sel}}    & rb_biu_ar_prot[2:0]
                                | {3{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_prot[2:0];

assign lsu_biu_ar_req         = bus_arb_wmb_ar_sel  &&  wmb_biu_ar_req
                                ||  bus_arb_rb_ar_sel &&  rb_biu_ar_req
                                ||  bus_arb_pfu_ar_sel  &&  pfu_biu_ar_req;

assign lsu_biu_ar_dp_req      = bus_arb_wmb_ar_dp_req_real
                                ||  bus_arb_rb_ar_dp_req_real
                                ||  bus_arb_pfu_ar_dp_req_real;

assign lsu_biu_ar_req_gate    = wmb_biu_ar_req_gateclk_en
                                ||  rb_biu_ar_req_gateclk_en
                                ||  pfu_biu_ar_req_gateclk_en;

assign lsu_biu_ar_user[2:0]   = {3{bus_arb_wmb_ar_sel}}  & wmb_biu_ar_user[2:0]
                                | {3{bus_arb_rb_ar_sel}}  & rb_biu_ar_user[2:0]
                                | {3{bus_arb_pfu_ar_sel}}  & pfu_biu_ar_user[2:0];

assign lsu_biu_ar_snoop[3:0]  = {4{bus_arb_wmb_ar_sel}}     & wmb_biu_ar_snoop[3:0]
                                | {4{bus_arb_rb_ar_sel}}    & rb_biu_ar_snoop[3:0]
                                | {4{bus_arb_pfu_ar_sel}}   & pfu_biu_ar_snoop[3:0];

assign lsu_biu_ar_domain[1:0] = {2{bus_arb_wmb_ar_sel}}     &  wmb_biu_ar_domain[1:0]
                                | {2{bus_arb_rb_ar_sel}}    &  rb_biu_ar_domain[1:0]
                                | {2{bus_arb_pfu_ar_sel}}   &  pfu_biu_ar_domain[1:0];

assign lsu_biu_ar_bar[1:0]    = {2{bus_arb_wmb_ar_sel}}     &  wmb_biu_ar_bar[1:0]
                                | {2{bus_arb_rb_ar_sel}}    &  rb_biu_ar_bar[1:0]
                                | {2{bus_arb_pfu_ar_sel}}   &  pfu_biu_ar_bar[1:0];

//==========================================================
//                      AW channel
//==========================================================
//priority: VB>WMB
//-----------------generate grnt signal---------------------
//for timing,generate total grnt here
//assign aw_ws = bus_arb_wmb_aw_sel
//               && (((wmb_biu_aw_snoop[2:0] == WU)
//                        || (wmb_biu_aw_snoop[2:0] == WLU))
//                     && (wmb_biu_aw_domain[1:0] == 2'b01)
//                   || wmb_biu_aw_bar[0]);

//assign biu_lsu_aw_grnt      = aw_ws & pad_biu_ws_awready | !aw_ws & pad_biu_wns_awready;

//assign bus_arb_vb_aw_sel    = vb_biu_aw_dp_req;
// &Force("output","bus_arb_vb_aw_grnt"); @190
assign bus_arb_vb_aw_grnt   = biu_lsu_aw_vb_grnt
                              &&  vb_biu_aw_req;

//assign bus_arb_wmb_aw_sel   = !vb_biu_aw_dp_req
//                              &&  wmb_biu_aw_dp_req;
// &Force("output","bus_arb_wmb_aw_grnt"); @196
assign bus_arb_wmb_aw_grnt  = biu_lsu_aw_wmb_grnt
                              &&  wmb_biu_aw_req;
//-----------------biu aw signal----------------------------
assign lsu_biu_aw_vict_req                 = vb_biu_aw_req;
assign lsu_biu_aw_vict_dp_req              = vb_biu_aw_dp_req;
assign lsu_biu_aw_vict_id[4:0]             = vb_biu_aw_id[4:0];
assign lsu_biu_aw_vict_addr[`PA_WIDTH-1:0] = vb_biu_aw_addr[`PA_WIDTH-1:0]; 
assign lsu_biu_aw_vict_len[1:0]            = vb_biu_aw_len[1:0];
assign lsu_biu_aw_vict_size[2:0]           = vb_biu_aw_size[2:0];
assign lsu_biu_aw_vict_burst[1:0]          = vb_biu_aw_burst[1:0];
assign lsu_biu_aw_vict_lock                = vb_biu_aw_lock;
assign lsu_biu_aw_vict_cache[3:0]          = vb_biu_aw_cache[3:0];
assign lsu_biu_aw_vict_prot[2:0]           = vb_biu_aw_prot[2:0];
assign lsu_biu_aw_vict_user                = vb_biu_aw_user;
assign lsu_biu_aw_vict_snoop[2:0]          = vb_biu_aw_snoop[2:0];
assign lsu_biu_aw_vict_domain[1:0]         = vb_biu_aw_domain[1:0];
assign lsu_biu_aw_vict_bar[1:0]            = vb_biu_aw_bar[1:0];
assign lsu_biu_aw_vict_unique              = vb_biu_aw_unique;

assign lsu_biu_aw_st_req                   = wmb_biu_aw_req;
assign lsu_biu_aw_st_dp_req                = wmb_biu_aw_dp_req;
assign lsu_biu_aw_st_id[4:0]               = wmb_biu_aw_id[4:0];
assign lsu_biu_aw_st_addr[`PA_WIDTH-1:0]   = wmb_biu_aw_addr[`PA_WIDTH-1:0]; 
assign lsu_biu_aw_st_len[1:0]              = wmb_biu_aw_len[1:0];
assign lsu_biu_aw_st_size[2:0]             = wmb_biu_aw_size[2:0];
assign lsu_biu_aw_st_burst[1:0]            = wmb_biu_aw_burst[1:0];
assign lsu_biu_aw_st_lock                  = wmb_biu_aw_lock;
assign lsu_biu_aw_st_cache[3:0]            = wmb_biu_aw_cache[3:0];
assign lsu_biu_aw_st_prot[2:0]             = wmb_biu_aw_prot[2:0];
assign lsu_biu_aw_st_user                  = wmb_biu_aw_user;
assign lsu_biu_aw_st_snoop[2:0]            = wmb_biu_aw_snoop[2:0];
assign lsu_biu_aw_st_domain[1:0]           = wmb_biu_aw_domain[1:0];
assign lsu_biu_aw_st_bar[1:0]              = wmb_biu_aw_bar[1:0];
assign lsu_biu_aw_st_unique                = 1'b0;


assign lsu_biu_aw_req_gate    = vb_biu_aw_req_gateclk_en
                                ||  wmb_biu_aw_req_gateclk_en;

//==========================================================
//                        W channel
//==========================================================
//assign bus_arb_vb_w_sel   = bus_arb_w_fifo[0]
//                            &&  !bus_arb_w_fifo_empty;
//assign bus_arb_wmb_w_sel  = !bus_arb_w_fifo[0]
//                            &&  !bus_arb_w_fifo_empty;

assign bus_arb_vb_w_grnt  = biu_lsu_w_vb_grnt
                            &&  vb_biu_w_req;
assign bus_arb_wmb_w_grnt = biu_lsu_w_wmb_grnt
                            &&  wmb_biu_w_req;

assign lsu_biu_w_vict_vld         = vb_biu_w_vld;
assign lsu_biu_w_vict_data[127:0] = vb_biu_w_data[127:0];
assign lsu_biu_w_vict_strb[15:0]  = vb_biu_w_strb[15:0];
assign lsu_biu_w_vict_last        = vb_biu_w_last;
assign lsu_biu_w_vict_wns         = 1'b1;

assign lsu_biu_w_st_vld           = wmb_biu_w_vld;
assign lsu_biu_w_st_data[127:0]   = wmb_biu_w_data[127:0];
assign lsu_biu_w_st_strb[15:0]    = wmb_biu_w_strb[15:0];
assign lsu_biu_w_st_last          = wmb_biu_w_last;
assign lsu_biu_w_st_wns           = wmb_biu_w_wns;


// &Force("input","vb_biu_w_id"); @266
// &Force("input","wmb_biu_w_id"); @267
// &Force("bus","vb_biu_w_id",4,0); @268
// &Force("bus","wmb_biu_w_id",4,0); @269


// &Force("output","lsu_biu_ar_dp_req"); @273
// &ModuleEnd; @277
endmodule


