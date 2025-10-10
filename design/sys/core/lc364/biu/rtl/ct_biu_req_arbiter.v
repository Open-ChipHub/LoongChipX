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
module ct_biu_req_arbiter (
  // &Ports, @23
  input    wire           arready,
  input    wire  [39 :0]  ifu_biu_rd_addr,
  input    wire  [1  :0]  ifu_biu_rd_burst,
  input    wire  [3  :0]  ifu_biu_rd_cache,
  input    wire  [1  :0]  ifu_biu_rd_domain,
  input    wire           ifu_biu_rd_id,
  input    wire  [1  :0]  ifu_biu_rd_len,
  input    wire  [2  :0]  ifu_biu_rd_prot,
  input    wire           ifu_biu_rd_req,
  input    wire           ifu_biu_rd_req_gate,
  input    wire  [2  :0]  ifu_biu_rd_size,
  input    wire  [3  :0]  ifu_biu_rd_snoop,
  input    wire  [1  :0]  ifu_biu_rd_user,
  input    wire  [39 :0]  lsu_biu_ar_addr,
  input    wire  [1  :0]  lsu_biu_ar_bar,
  input    wire  [1  :0]  lsu_biu_ar_burst,
  input    wire  [3  :0]  lsu_biu_ar_cache,
  input    wire  [1  :0]  lsu_biu_ar_domain,
  input    wire           lsu_biu_ar_dp_req,
  input    wire  [4  :0]  lsu_biu_ar_id,
  input    wire  [1  :0]  lsu_biu_ar_len,
  input    wire           lsu_biu_ar_lock,
  input    wire  [2  :0]  lsu_biu_ar_prot,
  input    wire           lsu_biu_ar_req,
  input    wire           lsu_biu_ar_req_gate,
  input    wire  [2  :0]  lsu_biu_ar_size,
  input    wire  [3  :0]  lsu_biu_ar_snoop,
  input    wire  [2  :0]  lsu_biu_ar_user,
  input    wire           lsu_biu_aw_req_gate,
  input    wire  [39 :0]  lsu_biu_aw_st_addr,
  input    wire  [1  :0]  lsu_biu_aw_st_bar,
  input    wire  [1  :0]  lsu_biu_aw_st_burst,
  input    wire  [3  :0]  lsu_biu_aw_st_cache,
  input    wire  [1  :0]  lsu_biu_aw_st_domain,
  input    wire           lsu_biu_aw_st_dp_req,
  input    wire  [4  :0]  lsu_biu_aw_st_id,
  input    wire  [1  :0]  lsu_biu_aw_st_len,
  input    wire           lsu_biu_aw_st_lock,
  input    wire  [2  :0]  lsu_biu_aw_st_prot,
  input    wire           lsu_biu_aw_st_req,
  input    wire  [2  :0]  lsu_biu_aw_st_size,
  input    wire  [2  :0]  lsu_biu_aw_st_snoop,
  input    wire           lsu_biu_aw_st_unique,
  input    wire           lsu_biu_aw_st_user,
  input    wire  [39 :0]  lsu_biu_aw_vict_addr,
  input    wire  [1  :0]  lsu_biu_aw_vict_bar,
  input    wire  [1  :0]  lsu_biu_aw_vict_burst,
  input    wire  [3  :0]  lsu_biu_aw_vict_cache,
  input    wire  [1  :0]  lsu_biu_aw_vict_domain,
  input    wire           lsu_biu_aw_vict_dp_req,
  input    wire  [4  :0]  lsu_biu_aw_vict_id,
  input    wire  [1  :0]  lsu_biu_aw_vict_len,
  input    wire           lsu_biu_aw_vict_lock,
  input    wire  [2  :0]  lsu_biu_aw_vict_prot,
  input    wire           lsu_biu_aw_vict_req,
  input    wire  [2  :0]  lsu_biu_aw_vict_size,
  input    wire  [2  :0]  lsu_biu_aw_vict_snoop,
  input    wire           lsu_biu_aw_vict_unique,
  input    wire           lsu_biu_aw_vict_user,
  input    wire  [127:0]  lsu_biu_w_st_data,
  input    wire           lsu_biu_w_st_last,
  input    wire  [15 :0]  lsu_biu_w_st_strb,
  input    wire           lsu_biu_w_st_vld,
  input    wire           lsu_biu_w_st_wns,
  input    wire  [127:0]  lsu_biu_w_vict_data,
  input    wire           lsu_biu_w_vict_last,
  input    wire  [15 :0]  lsu_biu_w_vict_strb,
  input    wire           lsu_biu_w_vict_vld,
  input    wire           lsu_biu_w_vict_wns,
  input    wire           st_awready,
  input    wire           st_wready,
  input    wire           vict_awready,
  input    wire           vict_wready,
  output   reg   [39 :0]  araddr,
  output   reg   [1  :0]  arbar,
  output   reg   [1  :0]  arburst,
  output   reg   [3  :0]  arcache,
  output   reg   [1  :0]  ardomain,
  output   reg   [4  :0]  arid,
  output   reg   [1  :0]  arlen,
  output   reg            arlock,
  output   reg   [2  :0]  arprot,
  output   reg   [2  :0]  arsize,
  output   reg   [3  :0]  arsnoop,
  output   reg   [2  :0]  aruser,
  output   wire           arvalid,
  output   wire           arvalid_gate,
  output   wire           biu_ifu_rd_grnt,
  output   wire           biu_lsu_ar_ready,
  output   wire           biu_lsu_aw_vb_grnt,
  output   wire           biu_lsu_aw_wmb_grnt,
  output   wire           biu_lsu_w_vb_grnt,
  output   wire           biu_lsu_w_wmb_grnt,
  output   wire  [39 :0]  st_awaddr,
  output   wire  [1  :0]  st_awbar,
  output   wire  [1  :0]  st_awburst,
  output   wire  [3  :0]  st_awcache,
  output   wire  [1  :0]  st_awdomain,
  output   wire  [4  :0]  st_awid,
  output   wire  [1  :0]  st_awlen,
  output   wire           st_awlock,
  output   wire  [2  :0]  st_awprot,
  output   wire  [2  :0]  st_awsize,
  output   wire  [2  :0]  st_awsnoop,
  output   wire           st_awunique,
  output   wire           st_awuser,
  output   wire           st_awvalid,
  output   wire           st_awvalid_gate,
  output   wire  [127:0]  st_wdata,
  output   wire           st_wlast,
  output   wire           st_wns,
  output   wire  [15 :0]  st_wstrb,
  output   wire           st_wvalid,
  output   wire  [39 :0]  vict_awaddr,
  output   wire  [1  :0]  vict_awbar,
  output   wire  [1  :0]  vict_awburst,
  output   wire  [3  :0]  vict_awcache,
  output   wire  [1  :0]  vict_awdomain,
  output   wire  [4  :0]  vict_awid,
  output   wire  [1  :0]  vict_awlen,
  output   wire           vict_awlock,
  output   wire  [2  :0]  vict_awprot,
  output   wire  [2  :0]  vict_awsize,
  output   wire  [2  :0]  vict_awsnoop,
  output   wire           vict_awunique,
  output   wire           vict_awuser,
  output   wire           vict_awvalid,
  output   wire           vict_awvalid_gate,
  output   wire  [127:0]  vict_wdata,
  output   wire           vict_wlast,
  output   wire           vict_wns,
  output   wire  [15 :0]  vict_wstrb,
  output   wire           vict_wvalid
); 



// &Regs; @24

// &Wires; @25
wire             ifu_ar_req;            
wire             lsu_ar_req;            


//==========================================================
// condition to create accept req from ifu/lsu
// Current_rd/wr_req_buffer empty or bus ready
// lsu rd has higher priority than ifu rd
// note:
// ifu req id: 1'b1-> 5'b10001:prefetch; 
//             1'b0-> 5'b10000:refill;
//==========================================================
//Read

assign ifu_ar_req = ifu_biu_rd_req && !lsu_biu_ar_dp_req;
assign lsu_ar_req = lsu_biu_ar_req  &&  lsu_biu_ar_dp_req;
assign arvalid    = ifu_ar_req || lsu_ar_req;
assign arvalid_gate = ifu_ar_req || lsu_biu_ar_dp_req;

// &CombBeg; @42
always @( lsu_biu_ar_lock
       or ifu_biu_rd_domain[1:0]
       or ifu_biu_rd_burst[1:0]
       or lsu_biu_ar_len[1:0]
       or lsu_biu_ar_size[2:0]
       or lsu_biu_ar_addr[39:0]
       or ifu_biu_rd_len[1:0]
       or ifu_biu_rd_addr[39:0]
       or ifu_biu_rd_cache[3:0]
       or lsu_biu_ar_dp_req
       or lsu_biu_ar_cache[3:0]
       or lsu_biu_ar_burst[1:0]
       or ifu_biu_rd_user[1:0]
       or lsu_biu_ar_user[2:0]
       or lsu_biu_ar_prot[2:0]
       or ifu_biu_rd_snoop[3:0]
       or lsu_biu_ar_bar[1:0]
       or ifu_biu_rd_prot[2:0]
       or lsu_biu_ar_domain[1:0]
       or ifu_biu_rd_size[2:0]
       or lsu_biu_ar_id[4:0]
       or ifu_biu_rd_id
       or lsu_biu_ar_snoop[3:0])
begin
  if(!lsu_biu_ar_dp_req)
  begin
    arid[4:0]     = {4'b1000,ifu_biu_rd_id}; 
    araddr[`PA_WIDTH-1:0]  = ifu_biu_rd_addr[`PA_WIDTH-1:0];
    arlen[1:0]    = ifu_biu_rd_len[1:0];
    arsize[2:0]   = ifu_biu_rd_size[2:0];
    arburst[1:0]  = ifu_biu_rd_burst[1:0];
    arlock        = 1'b0;
    arcache[3:0]  = ifu_biu_rd_cache[3:0];
    arprot[2:0]   = ifu_biu_rd_prot[2:0];
    arsnoop[3:0]  = ifu_biu_rd_snoop[3:0]; //ReadNoSnoop
    ardomain[1:0] = ifu_biu_rd_domain[1:0];//non-shareable domain
    arbar[1:0]    = 2'b0;
    aruser[2:0]   = {1'b0,ifu_biu_rd_user[1:0]};//fot {mmode,mmu} read
  end
  else
  begin
    arid[4:0]     = lsu_biu_ar_id[4:0];
    araddr[`PA_WIDTH-1:0]  = lsu_biu_ar_addr[`PA_WIDTH-1:0];
    arlen[1:0]    = lsu_biu_ar_len[1:0];
    arsize[2:0]   = lsu_biu_ar_size[2:0];
    arburst[1:0]  = lsu_biu_ar_burst[1:0];
    arlock        = lsu_biu_ar_lock;
    arcache[3:0]  = lsu_biu_ar_cache[3:0];
    arprot[2:0]   = lsu_biu_ar_prot[2:0];
    arsnoop[3:0]  = lsu_biu_ar_snoop[3:0];
    ardomain[1:0] = lsu_biu_ar_domain[1:0];
    arbar[1:0]    = lsu_biu_ar_bar[1:0];
    aruser[2:0]   = lsu_biu_ar_user[2:0]; //for mmu read
  end
// &CombEnd; @73
end


assign biu_ifu_rd_grnt  = ifu_ar_req && arready;
assign biu_lsu_ar_ready = arready;


//Write, only one source: lsu
//write addr channel
assign vict_awvalid        = lsu_biu_aw_vict_req;
assign vict_awvalid_gate   = lsu_biu_aw_vict_dp_req;
assign vict_awid[4:0]      = lsu_biu_aw_vict_id[4:0];
assign vict_awaddr[`PA_WIDTH-1:0]   = lsu_biu_aw_vict_addr[`PA_WIDTH-1:0];
assign vict_awlen[1:0]     = lsu_biu_aw_vict_len[1:0];
assign vict_awsize[2:0]    = lsu_biu_aw_vict_size[2:0];
assign vict_awburst[1:0]   = lsu_biu_aw_vict_burst[1:0];
assign vict_awlock         = lsu_biu_aw_vict_lock;
assign vict_awcache[3:0]   = lsu_biu_aw_vict_cache[3:0];
assign vict_awprot[2:0]    = lsu_biu_aw_vict_prot[2:0];
assign vict_awuser         = lsu_biu_aw_vict_user;
assign vict_awsnoop[2:0]   = lsu_biu_aw_vict_snoop[2:0];
assign vict_awdomain[1:0]  = lsu_biu_aw_vict_domain[1:0];
assign vict_awbar[1:0]     = lsu_biu_aw_vict_bar[1:0];
assign vict_awunique       = lsu_biu_aw_vict_unique;

assign st_awvalid        = lsu_biu_aw_st_req;
assign st_awvalid_gate   = lsu_biu_aw_st_dp_req;
assign st_awid[4:0]      = lsu_biu_aw_st_id[4:0];
assign st_awaddr[`PA_WIDTH-1:0]   = lsu_biu_aw_st_addr[`PA_WIDTH-1:0];
assign st_awlen[1:0]     = lsu_biu_aw_st_len[1:0];
assign st_awsize[2:0]    = lsu_biu_aw_st_size[2:0];
assign st_awburst[1:0]   = lsu_biu_aw_st_burst[1:0];
assign st_awlock         = lsu_biu_aw_st_lock;
assign st_awcache[3:0]   = lsu_biu_aw_st_cache[3:0];
assign st_awprot[2:0]    = lsu_biu_aw_st_prot[2:0];
assign st_awuser         = lsu_biu_aw_st_user;
assign st_awsnoop[2:0]   = lsu_biu_aw_st_snoop[2:0];
assign st_awdomain[1:0]  = lsu_biu_aw_st_domain[1:0];
assign st_awbar[1:0]     = lsu_biu_aw_st_bar[1:0];
assign st_awunique       = lsu_biu_aw_st_unique;

assign biu_lsu_aw_vb_grnt  = vict_awready;
assign biu_lsu_aw_wmb_grnt = st_awready;


//write data channel
assign vict_wvalid         = lsu_biu_w_vict_vld;
assign vict_wdata[127:0]   = lsu_biu_w_vict_data[127:0];
assign vict_wstrb[15:0]    = lsu_biu_w_vict_strb[15:0];
assign vict_wlast          = lsu_biu_w_vict_last;
assign vict_wns            = lsu_biu_w_vict_wns;

assign st_wvalid         = lsu_biu_w_st_vld;
assign st_wdata[127:0]   = lsu_biu_w_st_data[127:0];
assign st_wstrb[15:0]    = lsu_biu_w_st_strb[15:0];
assign st_wlast          = lsu_biu_w_st_last;
assign st_wns            = lsu_biu_w_st_wns;

assign biu_lsu_w_vb_grnt  = vict_wready;
assign biu_lsu_w_wmb_grnt = st_wready;
//assign 

//assign biu_pad_arvalid_gate = lsu_biu_ar_req_gate || ifu_biu_rd_req_gate;
//assign biu_pad_awvalid_gate = lsu_biu_aw_req_gate;
// &Force("input", "lsu_biu_ar_req_gate"); @144
// &Force("input", "lsu_biu_aw_req_gate"); @145
// &Force("input", "ifu_biu_rd_req_gate"); @146

// &ModuleEnd; @148
endmodule




