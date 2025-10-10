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
module ct_biu_top (
  // &Ports, @23
  input    wire           coreclk,
  input    wire           cp0_biu_icg_en,
  input    wire  [1  :0]  cp0_biu_lpmd_b,
  input    wire  [15 :0]  cp0_biu_op,
  input    wire           cp0_biu_sel,
  input    wire  [63 :0]  cp0_biu_wdata,
  input    wire           cpurst_b,
  input    wire           forever_coreclk,
  input    wire  [1  :0]  had_biu_jdb_pm,
  input    wire  [3  :0]  hpcp_biu_cnt_en,
  input    wire  [15 :0]  hpcp_biu_op,
  input    wire           hpcp_biu_sel,
  input    wire  [63 :0]  hpcp_biu_wdata,
  input    wire           ifu_biu_r_ready,
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
  input    wire           lsu_biu_ac_empty,
  input    wire           lsu_biu_ac_ready,
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
  input    wire  [127:0]  lsu_biu_cd_data,
  input    wire           lsu_biu_cd_last,
  input    wire           lsu_biu_cd_valid,
  input    wire  [4  :0]  lsu_biu_cr_resp,
  input    wire           lsu_biu_cr_valid,
  input    wire           lsu_biu_r_linefill_ready,
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
  input    wire  [39 :0]  pad_biu_acaddr,
  input    wire  [2  :0]  pad_biu_acprot,
  input    wire  [3  :0]  pad_biu_acsnoop,
  input    wire           pad_biu_acvalid,
  input    wire           pad_biu_arready,
  input    wire           pad_biu_awready,
  input    wire  [4  :0]  pad_biu_bid,
  input    wire  [1  :0]  pad_biu_bresp,
  input    wire           pad_biu_bvalid,
  input    wire           pad_biu_cdready,
  input    wire           pad_biu_crready,
  input    wire           pad_biu_csr_cmplt,
  input    wire  [127:0]  pad_biu_csr_rdata,
  input    wire           pad_biu_dbgrq_b,
  input    wire  [3  :0]  pad_biu_hpcp_l2of_int,
  input    wire           pad_biu_me_int,
  input    wire           pad_biu_ms_int,
  input    wire           pad_biu_mt_int,
  input    wire  [127:0]  pad_biu_rdata,
  input    wire  [4  :0]  pad_biu_rid,
  input    wire           pad_biu_rlast,
  input    wire  [3  :0]  pad_biu_rresp,
  input    wire           pad_biu_rvalid,
  input    wire           pad_biu_se_int,
  input    wire           pad_biu_ss_int,
  input    wire           pad_biu_st_int,
  input    wire           pad_biu_wns_awready,
  input    wire           pad_biu_wns_wready,
  input    wire           pad_biu_wready,
  input    wire           pad_biu_ws_awready,
  input    wire           pad_biu_ws_wready,
  input    wire  [2  :0]  pad_core_hartid,
  input    wire  [39 :0]  pad_core_rvba,
  input    wire  [39 :0]  pad_xx_apb_base,
  input    wire  [63 :0]  pad_xx_time,
  input    wire           pad_yy_icg_scan_en,
  output   wire  [39 :0]  biu_cp0_apb_base,
  output   wire           biu_cp0_cmplt,
  output   wire  [2  :0]  biu_cp0_coreid,
  output   wire           biu_cp0_me_int,
  output   wire           biu_cp0_ms_int,
  output   wire           biu_cp0_mt_int,
  output   wire  [127:0]  biu_cp0_rdata,
  output   wire  [39 :0]  biu_cp0_rvba,
  output   wire           biu_cp0_se_int,
  output   wire           biu_cp0_ss_int,
  output   wire           biu_cp0_st_int,
  output   wire  [1  :0]  biu_had_coreid,
  output   wire           biu_had_sdb_req_b,
  output   wire           biu_hpcp_cmplt,
  output   wire  [3  :0]  biu_hpcp_l2of_int,
  output   wire  [127:0]  biu_hpcp_rdata,
  output   wire  [63 :0]  biu_hpcp_time,
  output   wire  [127:0]  biu_ifu_rd_data,
  output   wire           biu_ifu_rd_data_vld,
  output   wire           biu_ifu_rd_grnt,
  output   wire           biu_ifu_rd_id,
  output   wire           biu_ifu_rd_last,
  output   wire  [1  :0]  biu_ifu_rd_resp,
  output   wire  [39 :0]  biu_lsu_ac_addr,
  output   wire  [2  :0]  biu_lsu_ac_prot,
  output   wire           biu_lsu_ac_req,
  output   wire  [3  :0]  biu_lsu_ac_snoop,
  output   wire           biu_lsu_ar_ready,
  output   wire           biu_lsu_aw_vb_grnt,
  output   wire           biu_lsu_aw_wmb_grnt,
  output   wire  [4  :0]  biu_lsu_b_id,
  output   wire  [1  :0]  biu_lsu_b_resp,
  output   wire           biu_lsu_b_vld,
  output   wire           biu_lsu_cd_ready,
  output   wire           biu_lsu_cr_ready,
  output   wire  [127:0]  biu_lsu_r_data,
  output   wire  [4  :0]  biu_lsu_r_id,
  output   wire           biu_lsu_r_last,
  output   wire  [3  :0]  biu_lsu_r_resp,
  output   wire           biu_lsu_r_vld,
  output   wire           biu_lsu_w_vb_grnt,
  output   wire           biu_lsu_w_wmb_grnt,
  output   wire           biu_mmu_smp_disable,
  output   wire           biu_pad_acready,
  output   wire  [39 :0]  biu_pad_araddr,
  output   wire  [1  :0]  biu_pad_arbar,
  output   wire  [1  :0]  biu_pad_arburst,
  output   wire  [3  :0]  biu_pad_arcache,
  output   wire  [1  :0]  biu_pad_ardomain,
  output   wire  [4  :0]  biu_pad_arid,
  output   wire  [1  :0]  biu_pad_arlen,
  output   wire           biu_pad_arlock,
  output   wire  [2  :0]  biu_pad_arprot,
  output   wire  [2  :0]  biu_pad_arsize,
  output   wire  [3  :0]  biu_pad_arsnoop,
  output   wire  [2  :0]  biu_pad_aruser,
  output   wire           biu_pad_arvalid,
  output   wire  [39 :0]  biu_pad_awaddr,
  output   wire  [1  :0]  biu_pad_awbar,
  output   wire  [1  :0]  biu_pad_awburst,
  output   wire  [3  :0]  biu_pad_awcache,
  output   wire  [1  :0]  biu_pad_awdomain,
  output   wire  [4  :0]  biu_pad_awid,
  output   wire  [1  :0]  biu_pad_awlen,
  output   wire           biu_pad_awlock,
  output   wire  [2  :0]  biu_pad_awprot,
  output   wire  [2  :0]  biu_pad_awsize,
  output   wire  [2  :0]  biu_pad_awsnoop,
  output   wire           biu_pad_awunique,
  output   wire           biu_pad_awuser,
  output   wire           biu_pad_awvalid,
  output   wire           biu_pad_back,
  output   wire           biu_pad_bready,
  output   wire  [127:0]  biu_pad_cddata,
  output   wire           biu_pad_cderr,
  output   wire           biu_pad_cdlast,
  output   wire           biu_pad_cdvalid,
  output   wire  [3  :0]  biu_pad_cnt_en,
  output   wire  [4  :0]  biu_pad_crresp,
  output   wire           biu_pad_crvalid,
  output   wire           biu_pad_csr_sel,
  output   wire  [79 :0]  biu_pad_csr_wdata,
  output   wire           biu_pad_jdb_pm,
  output   wire           biu_pad_lpmd_b,
  output   wire           biu_pad_rack,
  output   wire           biu_pad_rready,
  output   wire  [127:0]  biu_pad_wdata,
  output   wire           biu_pad_werr,
  output   wire           biu_pad_wlast,
  output   wire           biu_pad_wns,
  output   wire  [15 :0]  biu_pad_wstrb,
  output   wire           biu_pad_wvalid,
  output   wire           biu_xx_dbg_wakeup,
  output   wire           biu_xx_int_wakeup,
  output   wire           biu_xx_normal_work,
  output   wire           biu_xx_pmp_sel,
  output   wire           biu_xx_snoop_vld,
  output   wire           biu_yy_xx_no_op
); 



// &Regs; @24
// &Wires; @25
wire             accpuclk;                
wire    [39 :0]  araddr;                  
wire    [1  :0]  arbar;                   
wire    [1  :0]  arburst;                 
wire    [3  :0]  arcache;                 
wire             arcpuclk;                
wire    [1  :0]  ardomain;                
wire    [4  :0]  arid;                    
wire    [1  :0]  arlen;                   
wire             arlock;                  
wire    [2  :0]  arprot;                  
wire             arready;                 
wire    [2  :0]  arsize;                  
wire    [3  :0]  arsnoop;                 
wire    [2  :0]  aruser;                  
wire             arvalid;                 
wire             arvalid_gate;            
wire             bcpuclk;                 
wire             biu_csr_cmplt;           
wire    [15 :0]  biu_csr_op;              
wire    [127:0]  biu_csr_rdata;           
wire             biu_csr_sel;             
wire    [63 :0]  biu_csr_wdata;           
wire             bus_arb_w_fifo_clk;      
wire             bus_arb_w_fifo_clk_en;   
wire             cdcpuclk;                
wire             crcpuclk;                
wire             pad_biu_back_ready;      
wire             pad_biu_rack_ready;      
wire             rcpuclk;                 
wire             read_ar_clk_en;          
wire             read_busy;               
wire             read_r_clk_en;           
wire             round_w_clk_en;          
wire             round_wcpuclk;           
wire             snoop_ac_clk_en;         
wire             snoop_cd_clk_en;         
wire             snoop_cr_clk_en;         
wire             st_aw_clk_en;            
wire    [39 :0]  st_awaddr;               
wire    [1  :0]  st_awbar;                
wire    [1  :0]  st_awburst;              
wire    [3  :0]  st_awcache;              
wire             st_awcpuclk;             
wire    [1  :0]  st_awdomain;             
wire    [4  :0]  st_awid;                 
wire    [1  :0]  st_awlen;                
wire             st_awlock;               
wire    [2  :0]  st_awprot;               
wire             st_awready;              
wire    [2  :0]  st_awsize;               
wire    [2  :0]  st_awsnoop;              
wire             st_awunique;             
wire             st_awuser;               
wire             st_awvalid;              
wire             st_awvalid_gate;         
wire             st_w_clk_en;             
wire             st_wcpuclk;              
wire    [127:0]  st_wdata;                
wire             st_wlast;                
wire             st_wns;                  
wire             st_wready;               
wire    [15 :0]  st_wstrb;                
wire             st_wvalid;               
wire             vict_aw_clk_en;          
wire    [39 :0]  vict_awaddr;             
wire    [1  :0]  vict_awbar;              
wire    [1  :0]  vict_awburst;            
wire    [3  :0]  vict_awcache;            
wire             vict_awcpuclk;           
wire    [1  :0]  vict_awdomain;           
wire    [4  :0]  vict_awid;               
wire    [1  :0]  vict_awlen;              
wire             vict_awlock;             
wire    [2  :0]  vict_awprot;             
wire             vict_awready;            
wire    [2  :0]  vict_awsize;             
wire    [2  :0]  vict_awsnoop;            
wire             vict_awunique;           
wire             vict_awuser;             
wire             vict_awvalid;            
wire             vict_awvalid_gate;       
wire             vict_w_clk_en;           
wire             vict_wcpuclk;            
wire    [127:0]  vict_wdata;              
wire             vict_wlast;              
wire             vict_wns;                
wire             vict_wready;             
wire    [15 :0]  vict_wstrb;              
wire             vict_wvalid;             
wire             write_b_clk_en;          
wire             write_busy;              


// &Instance("ct_biu_req_arbiter"); @27
ct_biu_req_arbiter  x_ct_biu_req_arbiter (
  .araddr                 (araddr                ),
  .arbar                  (arbar                 ),
  .arburst                (arburst               ),
  .arcache                (arcache               ),
  .ardomain               (ardomain              ),
  .arid                   (arid                  ),
  .arlen                  (arlen                 ),
  .arlock                 (arlock                ),
  .arprot                 (arprot                ),
  .arready                (arready               ),
  .arsize                 (arsize                ),
  .arsnoop                (arsnoop               ),
  .aruser                 (aruser                ),
  .arvalid                (arvalid               ),
  .arvalid_gate           (arvalid_gate          ),
  .biu_ifu_rd_grnt        (biu_ifu_rd_grnt       ),
  .biu_lsu_ar_ready       (biu_lsu_ar_ready      ),
  .biu_lsu_aw_vb_grnt     (biu_lsu_aw_vb_grnt    ),
  .biu_lsu_aw_wmb_grnt    (biu_lsu_aw_wmb_grnt   ),
  .biu_lsu_w_vb_grnt      (biu_lsu_w_vb_grnt     ),
  .biu_lsu_w_wmb_grnt     (biu_lsu_w_wmb_grnt    ),
  .ifu_biu_rd_addr        (ifu_biu_rd_addr       ),
  .ifu_biu_rd_burst       (ifu_biu_rd_burst      ),
  .ifu_biu_rd_cache       (ifu_biu_rd_cache      ),
  .ifu_biu_rd_domain      (ifu_biu_rd_domain     ),
  .ifu_biu_rd_id          (ifu_biu_rd_id         ),
  .ifu_biu_rd_len         (ifu_biu_rd_len        ),
  .ifu_biu_rd_prot        (ifu_biu_rd_prot       ),
  .ifu_biu_rd_req         (ifu_biu_rd_req        ),
  .ifu_biu_rd_req_gate    (ifu_biu_rd_req_gate   ),
  .ifu_biu_rd_size        (ifu_biu_rd_size       ),
  .ifu_biu_rd_snoop       (ifu_biu_rd_snoop      ),
  .ifu_biu_rd_user        (ifu_biu_rd_user       ),
  .lsu_biu_ar_addr        (lsu_biu_ar_addr       ),
  .lsu_biu_ar_bar         (lsu_biu_ar_bar        ),
  .lsu_biu_ar_burst       (lsu_biu_ar_burst      ),
  .lsu_biu_ar_cache       (lsu_biu_ar_cache      ),
  .lsu_biu_ar_domain      (lsu_biu_ar_domain     ),
  .lsu_biu_ar_dp_req      (lsu_biu_ar_dp_req     ),
  .lsu_biu_ar_id          (lsu_biu_ar_id         ),
  .lsu_biu_ar_len         (lsu_biu_ar_len        ),
  .lsu_biu_ar_lock        (lsu_biu_ar_lock       ),
  .lsu_biu_ar_prot        (lsu_biu_ar_prot       ),
  .lsu_biu_ar_req         (lsu_biu_ar_req        ),
  .lsu_biu_ar_req_gate    (lsu_biu_ar_req_gate   ),
  .lsu_biu_ar_size        (lsu_biu_ar_size       ),
  .lsu_biu_ar_snoop       (lsu_biu_ar_snoop      ),
  .lsu_biu_ar_user        (lsu_biu_ar_user       ),
  .lsu_biu_aw_req_gate    (lsu_biu_aw_req_gate   ),
  .lsu_biu_aw_st_addr     (lsu_biu_aw_st_addr    ),
  .lsu_biu_aw_st_bar      (lsu_biu_aw_st_bar     ),
  .lsu_biu_aw_st_burst    (lsu_biu_aw_st_burst   ),
  .lsu_biu_aw_st_cache    (lsu_biu_aw_st_cache   ),
  .lsu_biu_aw_st_domain   (lsu_biu_aw_st_domain  ),
  .lsu_biu_aw_st_dp_req   (lsu_biu_aw_st_dp_req  ),
  .lsu_biu_aw_st_id       (lsu_biu_aw_st_id      ),
  .lsu_biu_aw_st_len      (lsu_biu_aw_st_len     ),
  .lsu_biu_aw_st_lock     (lsu_biu_aw_st_lock    ),
  .lsu_biu_aw_st_prot     (lsu_biu_aw_st_prot    ),
  .lsu_biu_aw_st_req      (lsu_biu_aw_st_req     ),
  .lsu_biu_aw_st_size     (lsu_biu_aw_st_size    ),
  .lsu_biu_aw_st_snoop    (lsu_biu_aw_st_snoop   ),
  .lsu_biu_aw_st_unique   (lsu_biu_aw_st_unique  ),
  .lsu_biu_aw_st_user     (lsu_biu_aw_st_user    ),
  .lsu_biu_aw_vict_addr   (lsu_biu_aw_vict_addr  ),
  .lsu_biu_aw_vict_bar    (lsu_biu_aw_vict_bar   ),
  .lsu_biu_aw_vict_burst  (lsu_biu_aw_vict_burst ),
  .lsu_biu_aw_vict_cache  (lsu_biu_aw_vict_cache ),
  .lsu_biu_aw_vict_domain (lsu_biu_aw_vict_domain),
  .lsu_biu_aw_vict_dp_req (lsu_biu_aw_vict_dp_req),
  .lsu_biu_aw_vict_id     (lsu_biu_aw_vict_id    ),
  .lsu_biu_aw_vict_len    (lsu_biu_aw_vict_len   ),
  .lsu_biu_aw_vict_lock   (lsu_biu_aw_vict_lock  ),
  .lsu_biu_aw_vict_prot   (lsu_biu_aw_vict_prot  ),
  .lsu_biu_aw_vict_req    (lsu_biu_aw_vict_req   ),
  .lsu_biu_aw_vict_size   (lsu_biu_aw_vict_size  ),
  .lsu_biu_aw_vict_snoop  (lsu_biu_aw_vict_snoop ),
  .lsu_biu_aw_vict_unique (lsu_biu_aw_vict_unique),
  .lsu_biu_aw_vict_user   (lsu_biu_aw_vict_user  ),
  .lsu_biu_w_st_data      (lsu_biu_w_st_data     ),
  .lsu_biu_w_st_last      (lsu_biu_w_st_last     ),
  .lsu_biu_w_st_strb      (lsu_biu_w_st_strb     ),
  .lsu_biu_w_st_vld       (lsu_biu_w_st_vld      ),
  .lsu_biu_w_st_wns       (lsu_biu_w_st_wns      ),
  .lsu_biu_w_vict_data    (lsu_biu_w_vict_data   ),
  .lsu_biu_w_vict_last    (lsu_biu_w_vict_last   ),
  .lsu_biu_w_vict_strb    (lsu_biu_w_vict_strb   ),
  .lsu_biu_w_vict_vld     (lsu_biu_w_vict_vld    ),
  .lsu_biu_w_vict_wns     (lsu_biu_w_vict_wns    ),
  .st_awaddr              (st_awaddr             ),
  .st_awbar               (st_awbar              ),
  .st_awburst             (st_awburst            ),
  .st_awcache             (st_awcache            ),
  .st_awdomain            (st_awdomain           ),
  .st_awid                (st_awid               ),
  .st_awlen               (st_awlen              ),
  .st_awlock              (st_awlock             ),
  .st_awprot              (st_awprot             ),
  .st_awready             (st_awready            ),
  .st_awsize              (st_awsize             ),
  .st_awsnoop             (st_awsnoop            ),
  .st_awunique            (st_awunique           ),
  .st_awuser              (st_awuser             ),
  .st_awvalid             (st_awvalid            ),
  .st_awvalid_gate        (st_awvalid_gate       ),
  .st_wdata               (st_wdata              ),
  .st_wlast               (st_wlast              ),
  .st_wns                 (st_wns                ),
  .st_wready              (st_wready             ),
  .st_wstrb               (st_wstrb              ),
  .st_wvalid              (st_wvalid             ),
  .vict_awaddr            (vict_awaddr           ),
  .vict_awbar             (vict_awbar            ),
  .vict_awburst           (vict_awburst          ),
  .vict_awcache           (vict_awcache          ),
  .vict_awdomain          (vict_awdomain         ),
  .vict_awid              (vict_awid             ),
  .vict_awlen             (vict_awlen            ),
  .vict_awlock            (vict_awlock           ),
  .vict_awprot            (vict_awprot           ),
  .vict_awready           (vict_awready          ),
  .vict_awsize            (vict_awsize           ),
  .vict_awsnoop           (vict_awsnoop          ),
  .vict_awunique          (vict_awunique         ),
  .vict_awuser            (vict_awuser           ),
  .vict_awvalid           (vict_awvalid          ),
  .vict_awvalid_gate      (vict_awvalid_gate     ),
  .vict_wdata             (vict_wdata            ),
  .vict_wlast             (vict_wlast            ),
  .vict_wns               (vict_wns              ),
  .vict_wready            (vict_wready           ),
  .vict_wstrb             (vict_wstrb            ),
  .vict_wvalid            (vict_wvalid           )
);


// &Instance("ct_biu_read_channel"); @29
ct_biu_read_channel  x_ct_biu_read_channel (
  .araddr                   (araddr                  ),
  .arbar                    (arbar                   ),
  .arburst                  (arburst                 ),
  .arcache                  (arcache                 ),
  .arcpuclk                 (arcpuclk                ),
  .ardomain                 (ardomain                ),
  .arid                     (arid                    ),
  .arlen                    (arlen                   ),
  .arlock                   (arlock                  ),
  .arprot                   (arprot                  ),
  .arready                  (arready                 ),
  .arsize                   (arsize                  ),
  .arsnoop                  (arsnoop                 ),
  .aruser                   (aruser                  ),
  .arvalid                  (arvalid                 ),
  .arvalid_gate             (arvalid_gate            ),
  .biu_ifu_rd_data          (biu_ifu_rd_data         ),
  .biu_ifu_rd_data_vld      (biu_ifu_rd_data_vld     ),
  .biu_ifu_rd_id            (biu_ifu_rd_id           ),
  .biu_ifu_rd_last          (biu_ifu_rd_last         ),
  .biu_ifu_rd_resp          (biu_ifu_rd_resp         ),
  .biu_lsu_r_data           (biu_lsu_r_data          ),
  .biu_lsu_r_id             (biu_lsu_r_id            ),
  .biu_lsu_r_last           (biu_lsu_r_last          ),
  .biu_lsu_r_resp           (biu_lsu_r_resp          ),
  .biu_lsu_r_vld            (biu_lsu_r_vld           ),
  .biu_pad_araddr           (biu_pad_araddr          ),
  .biu_pad_arbar            (biu_pad_arbar           ),
  .biu_pad_arburst          (biu_pad_arburst         ),
  .biu_pad_arcache          (biu_pad_arcache         ),
  .biu_pad_ardomain         (biu_pad_ardomain        ),
  .biu_pad_arid             (biu_pad_arid            ),
  .biu_pad_arlen            (biu_pad_arlen           ),
  .biu_pad_arlock           (biu_pad_arlock          ),
  .biu_pad_arprot           (biu_pad_arprot          ),
  .biu_pad_arsize           (biu_pad_arsize          ),
  .biu_pad_arsnoop          (biu_pad_arsnoop         ),
  .biu_pad_aruser           (biu_pad_aruser          ),
  .biu_pad_arvalid          (biu_pad_arvalid         ),
  .biu_pad_rack             (biu_pad_rack            ),
  .biu_pad_rready           (biu_pad_rready          ),
  .coreclk                  (coreclk                 ),
  .cpurst_b                 (cpurst_b                ),
  .ifu_biu_r_ready          (ifu_biu_r_ready         ),
  .lsu_biu_r_linefill_ready (lsu_biu_r_linefill_ready),
  .pad_biu_arready          (pad_biu_arready         ),
  .pad_biu_rack_ready       (pad_biu_rack_ready      ),
  .pad_biu_rdata            (pad_biu_rdata           ),
  .pad_biu_rid              (pad_biu_rid             ),
  .pad_biu_rlast            (pad_biu_rlast           ),
  .pad_biu_rresp            (pad_biu_rresp           ),
  .pad_biu_rvalid           (pad_biu_rvalid          ),
  .rcpuclk                  (rcpuclk                 ),
  .read_ar_clk_en           (read_ar_clk_en          ),
  .read_busy                (read_busy               ),
  .read_r_clk_en            (read_r_clk_en           )
);


// &Instance("ct_biu_write_channel"); @31
ct_biu_write_channel  x_ct_biu_write_channel (
  .bcpuclk               (bcpuclk              ),
  .biu_lsu_b_id          (biu_lsu_b_id         ),
  .biu_lsu_b_resp        (biu_lsu_b_resp       ),
  .biu_lsu_b_vld         (biu_lsu_b_vld        ),
  .biu_pad_awaddr        (biu_pad_awaddr       ),
  .biu_pad_awbar         (biu_pad_awbar        ),
  .biu_pad_awburst       (biu_pad_awburst      ),
  .biu_pad_awcache       (biu_pad_awcache      ),
  .biu_pad_awdomain      (biu_pad_awdomain     ),
  .biu_pad_awid          (biu_pad_awid         ),
  .biu_pad_awlen         (biu_pad_awlen        ),
  .biu_pad_awlock        (biu_pad_awlock       ),
  .biu_pad_awprot        (biu_pad_awprot       ),
  .biu_pad_awsize        (biu_pad_awsize       ),
  .biu_pad_awsnoop       (biu_pad_awsnoop      ),
  .biu_pad_awunique      (biu_pad_awunique     ),
  .biu_pad_awuser        (biu_pad_awuser       ),
  .biu_pad_awvalid       (biu_pad_awvalid      ),
  .biu_pad_back          (biu_pad_back         ),
  .biu_pad_bready        (biu_pad_bready       ),
  .biu_pad_wdata         (biu_pad_wdata        ),
  .biu_pad_werr          (biu_pad_werr         ),
  .biu_pad_wlast         (biu_pad_wlast        ),
  .biu_pad_wns           (biu_pad_wns          ),
  .biu_pad_wstrb         (biu_pad_wstrb        ),
  .biu_pad_wvalid        (biu_pad_wvalid       ),
  .bus_arb_w_fifo_clk    (bus_arb_w_fifo_clk   ),
  .bus_arb_w_fifo_clk_en (bus_arb_w_fifo_clk_en),
  .coreclk               (coreclk              ),
  .cpurst_b              (cpurst_b             ),
  .pad_biu_awready       (pad_biu_awready      ),
  .pad_biu_back_ready    (pad_biu_back_ready   ),
  .pad_biu_bid           (pad_biu_bid          ),
  .pad_biu_bresp         (pad_biu_bresp        ),
  .pad_biu_bvalid        (pad_biu_bvalid       ),
  .pad_biu_wns_awready   (pad_biu_wns_awready  ),
  .pad_biu_wns_wready    (pad_biu_wns_wready   ),
  .pad_biu_wready        (pad_biu_wready       ),
  .pad_biu_ws_awready    (pad_biu_ws_awready   ),
  .pad_biu_ws_wready     (pad_biu_ws_wready    ),
  .round_w_clk_en        (round_w_clk_en       ),
  .round_wcpuclk         (round_wcpuclk        ),
  .st_aw_clk_en          (st_aw_clk_en         ),
  .st_awaddr             (st_awaddr            ),
  .st_awbar              (st_awbar             ),
  .st_awburst            (st_awburst           ),
  .st_awcache            (st_awcache           ),
  .st_awcpuclk           (st_awcpuclk          ),
  .st_awdomain           (st_awdomain          ),
  .st_awid               (st_awid              ),
  .st_awlen              (st_awlen             ),
  .st_awlock             (st_awlock            ),
  .st_awprot             (st_awprot            ),
  .st_awready            (st_awready           ),
  .st_awsize             (st_awsize            ),
  .st_awsnoop            (st_awsnoop           ),
  .st_awunique           (st_awunique          ),
  .st_awuser             (st_awuser            ),
  .st_awvalid            (st_awvalid           ),
  .st_awvalid_gate       (st_awvalid_gate      ),
  .st_w_clk_en           (st_w_clk_en          ),
  .st_wcpuclk            (st_wcpuclk           ),
  .st_wdata              (st_wdata             ),
  .st_wlast              (st_wlast             ),
  .st_wns                (st_wns               ),
  .st_wready             (st_wready            ),
  .st_wstrb              (st_wstrb             ),
  .st_wvalid             (st_wvalid            ),
  .vict_aw_clk_en        (vict_aw_clk_en       ),
  .vict_awaddr           (vict_awaddr          ),
  .vict_awbar            (vict_awbar           ),
  .vict_awburst          (vict_awburst         ),
  .vict_awcache          (vict_awcache         ),
  .vict_awcpuclk         (vict_awcpuclk        ),
  .vict_awdomain         (vict_awdomain        ),
  .vict_awid             (vict_awid            ),
  .vict_awlen            (vict_awlen           ),
  .vict_awlock           (vict_awlock          ),
  .vict_awprot           (vict_awprot          ),
  .vict_awready          (vict_awready         ),
  .vict_awsize           (vict_awsize          ),
  .vict_awsnoop          (vict_awsnoop         ),
  .vict_awunique         (vict_awunique        ),
  .vict_awuser           (vict_awuser          ),
  .vict_awvalid          (vict_awvalid         ),
  .vict_awvalid_gate     (vict_awvalid_gate    ),
  .vict_w_clk_en         (vict_w_clk_en        ),
  .vict_wcpuclk          (vict_wcpuclk         ),
  .vict_wdata            (vict_wdata           ),
  .vict_wlast            (vict_wlast           ),
  .vict_wns              (vict_wns             ),
  .vict_wready           (vict_wready          ),
  .vict_wstrb            (vict_wstrb           ),
  .vict_wvalid           (vict_wvalid          ),
  .write_b_clk_en        (write_b_clk_en       ),
  .write_busy            (write_busy           )
);


// &Instance("ct_biu_snoop_channel"); @33
ct_biu_snoop_channel  x_ct_biu_snoop_channel (
  .accpuclk         (accpuclk        ),
  .biu_lsu_ac_addr  (biu_lsu_ac_addr ),
  .biu_lsu_ac_prot  (biu_lsu_ac_prot ),
  .biu_lsu_ac_req   (biu_lsu_ac_req  ),
  .biu_lsu_ac_snoop (biu_lsu_ac_snoop),
  .biu_lsu_cd_ready (biu_lsu_cd_ready),
  .biu_lsu_cr_ready (biu_lsu_cr_ready),
  .biu_pad_acready  (biu_pad_acready ),
  .biu_pad_cddata   (biu_pad_cddata  ),
  .biu_pad_cderr    (biu_pad_cderr   ),
  .biu_pad_cdlast   (biu_pad_cdlast  ),
  .biu_pad_cdvalid  (biu_pad_cdvalid ),
  .biu_pad_crresp   (biu_pad_crresp  ),
  .biu_pad_crvalid  (biu_pad_crvalid ),
  .biu_xx_snoop_vld (biu_xx_snoop_vld),
  .cdcpuclk         (cdcpuclk        ),
  .cpurst_b         (cpurst_b        ),
  .crcpuclk         (crcpuclk        ),
  .forever_coreclk  (forever_coreclk ),
  .lsu_biu_ac_empty (lsu_biu_ac_empty),
  .lsu_biu_ac_ready (lsu_biu_ac_ready),
  .lsu_biu_cd_data  (lsu_biu_cd_data ),
  .lsu_biu_cd_last  (lsu_biu_cd_last ),
  .lsu_biu_cd_valid (lsu_biu_cd_valid),
  .lsu_biu_cr_resp  (lsu_biu_cr_resp ),
  .lsu_biu_cr_valid (lsu_biu_cr_valid),
  .pad_biu_acaddr   (pad_biu_acaddr  ),
  .pad_biu_acprot   (pad_biu_acprot  ),
  .pad_biu_acsnoop  (pad_biu_acsnoop ),
  .pad_biu_acvalid  (pad_biu_acvalid ),
  .pad_biu_cdready  (pad_biu_cdready ),
  .pad_biu_crready  (pad_biu_crready ),
  .snoop_ac_clk_en  (snoop_ac_clk_en ),
  .snoop_cd_clk_en  (snoop_cd_clk_en ),
  .snoop_cr_clk_en  (snoop_cr_clk_en )
);


// &Instance("ct_biu_lowpower"); @35
ct_biu_lowpower  x_ct_biu_lowpower (
  .accpuclk              (accpuclk             ),
  .arcpuclk              (arcpuclk             ),
  .bcpuclk               (bcpuclk              ),
  .biu_yy_xx_no_op       (biu_yy_xx_no_op      ),
  .bus_arb_w_fifo_clk    (bus_arb_w_fifo_clk   ),
  .bus_arb_w_fifo_clk_en (bus_arb_w_fifo_clk_en),
  .cdcpuclk              (cdcpuclk             ),
  .coreclk               (coreclk              ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .crcpuclk              (crcpuclk             ),
  .forever_coreclk       (forever_coreclk      ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .rcpuclk               (rcpuclk              ),
  .read_ar_clk_en        (read_ar_clk_en       ),
  .read_busy             (read_busy            ),
  .read_r_clk_en         (read_r_clk_en        ),
  .round_w_clk_en        (round_w_clk_en       ),
  .round_wcpuclk         (round_wcpuclk        ),
  .snoop_ac_clk_en       (snoop_ac_clk_en      ),
  .snoop_cd_clk_en       (snoop_cd_clk_en      ),
  .snoop_cr_clk_en       (snoop_cr_clk_en      ),
  .st_aw_clk_en          (st_aw_clk_en         ),
  .st_awcpuclk           (st_awcpuclk          ),
  .st_w_clk_en           (st_w_clk_en          ),
  .st_wcpuclk            (st_wcpuclk           ),
  .vict_aw_clk_en        (vict_aw_clk_en       ),
  .vict_awcpuclk         (vict_awcpuclk        ),
  .vict_w_clk_en         (vict_w_clk_en        ),
  .vict_wcpuclk          (vict_wcpuclk         ),
  .write_b_clk_en        (write_b_clk_en       ),
  .write_busy            (write_busy           )
);


// &Instance("ct_biu_csr_req_arbiter"); @37
ct_biu_csr_req_arbiter  x_ct_biu_csr_req_arbiter (
  .biu_cp0_cmplt  (biu_cp0_cmplt ),
  .biu_cp0_rdata  (biu_cp0_rdata ),
  .biu_csr_cmplt  (biu_csr_cmplt ),
  .biu_csr_op     (biu_csr_op    ),
  .biu_csr_rdata  (biu_csr_rdata ),
  .biu_csr_sel    (biu_csr_sel   ),
  .biu_csr_wdata  (biu_csr_wdata ),
  .biu_hpcp_cmplt (biu_hpcp_cmplt),
  .biu_hpcp_rdata (biu_hpcp_rdata),
  .cp0_biu_op     (cp0_biu_op    ),
  .cp0_biu_sel    (cp0_biu_sel   ),
  .cp0_biu_wdata  (cp0_biu_wdata ),
  .hpcp_biu_op    (hpcp_biu_op   ),
  .hpcp_biu_sel   (hpcp_biu_sel  ),
  .hpcp_biu_wdata (hpcp_biu_wdata)
);


// &Instance("ct_biu_bus_io_async"); @40
// &Instance("ct_biu_other_io_async"); @41
assign pad_biu_rack_ready = 1'b1;
assign pad_biu_back_ready = 1'b1;
//&Instance("ct_biu_bus_io_sync");
// &Instance("ct_biu_other_io_sync"); @46
ct_biu_other_io_sync  x_ct_biu_other_io_sync (
  .biu_cp0_apb_base      (biu_cp0_apb_base     ),
  .biu_cp0_coreid        (biu_cp0_coreid       ),
  .biu_cp0_me_int        (biu_cp0_me_int       ),
  .biu_cp0_ms_int        (biu_cp0_ms_int       ),
  .biu_cp0_mt_int        (biu_cp0_mt_int       ),
  .biu_cp0_rvba          (biu_cp0_rvba         ),
  .biu_cp0_se_int        (biu_cp0_se_int       ),
  .biu_cp0_ss_int        (biu_cp0_ss_int       ),
  .biu_cp0_st_int        (biu_cp0_st_int       ),
  .biu_csr_cmplt         (biu_csr_cmplt        ),
  .biu_csr_op            (biu_csr_op           ),
  .biu_csr_rdata         (biu_csr_rdata        ),
  .biu_csr_sel           (biu_csr_sel          ),
  .biu_csr_wdata         (biu_csr_wdata        ),
  .biu_had_coreid        (biu_had_coreid       ),
  .biu_had_sdb_req_b     (biu_had_sdb_req_b    ),
  .biu_hpcp_l2of_int     (biu_hpcp_l2of_int    ),
  .biu_hpcp_time         (biu_hpcp_time        ),
  .biu_mmu_smp_disable   (biu_mmu_smp_disable  ),
  .biu_pad_cnt_en        (biu_pad_cnt_en       ),
  .biu_pad_csr_sel       (biu_pad_csr_sel      ),
  .biu_pad_csr_wdata     (biu_pad_csr_wdata    ),
  .biu_pad_jdb_pm        (biu_pad_jdb_pm       ),
  .biu_pad_lpmd_b        (biu_pad_lpmd_b       ),
  .biu_xx_dbg_wakeup     (biu_xx_dbg_wakeup    ),
  .biu_xx_int_wakeup     (biu_xx_int_wakeup    ),
  .biu_xx_normal_work    (biu_xx_normal_work   ),
  .biu_xx_pmp_sel        (biu_xx_pmp_sel       ),
  .coreclk               (coreclk              ),
  .cp0_biu_icg_en        (cp0_biu_icg_en       ),
  .cp0_biu_lpmd_b        (cp0_biu_lpmd_b       ),
  .cpurst_b              (cpurst_b             ),
  .forever_coreclk       (forever_coreclk      ),
  .had_biu_jdb_pm        (had_biu_jdb_pm       ),
  .hpcp_biu_cnt_en       (hpcp_biu_cnt_en      ),
  .pad_biu_csr_cmplt     (pad_biu_csr_cmplt    ),
  .pad_biu_csr_rdata     (pad_biu_csr_rdata    ),
  .pad_biu_dbgrq_b       (pad_biu_dbgrq_b      ),
  .pad_biu_hpcp_l2of_int (pad_biu_hpcp_l2of_int),
  .pad_biu_me_int        (pad_biu_me_int       ),
  .pad_biu_ms_int        (pad_biu_ms_int       ),
  .pad_biu_mt_int        (pad_biu_mt_int       ),
  .pad_biu_se_int        (pad_biu_se_int       ),
  .pad_biu_ss_int        (pad_biu_ss_int       ),
  .pad_biu_st_int        (pad_biu_st_int       ),
  .pad_core_hartid       (pad_core_hartid      ),
  .pad_core_rvba         (pad_core_rvba        ),
  .pad_xx_apb_base       (pad_xx_apb_base      ),
  .pad_xx_time           (pad_xx_time          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   )
);





// &ModuleEnd; @70
endmodule





