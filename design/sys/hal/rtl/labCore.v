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

// &ModuleBeg; @41
module labCore (
  input    wire           axim_clk_en,
  input    wire           pad_biu_arready,
  input    wire           pad_biu_awready,
  input    wire  [7  :0]  pad_biu_bid,
  input    wire  [1  :0]  pad_biu_bresp,
  input    wire           pad_biu_bvalid,
  input    wire           pad_biu_csysreq,
  input    wire  [127:0]  pad_biu_rdata,
  input    wire  [7  :0]  pad_biu_rid,
  input    wire           pad_biu_rlast,
  input    wire  [1  :0]  pad_biu_rresp,
  input    wire           pad_biu_rvalid,
  input    wire           pad_biu_wready,
  input    wire           pad_core0_dbg_mask,
  input    wire           pad_core0_dbgrq_b,
  input    wire  [2  :0]  pad_core0_hartid,
  input    wire           pad_core0_rst_b,
  input    wire  [39 :0]  pad_core0_rvba,
  input    wire           pad_core1_dbg_mask,
  input    wire           pad_core1_dbgrq_b,
  input    wire  [2  :0]  pad_core1_hartid,
  input    wire           pad_core1_rst_b,
  input    wire  [39 :0]  pad_core1_rvba,
`ifdef TRIPLE_CORE
  input    wire           pad_core2_dbg_mask,
  input    wire           pad_core2_dbgrq_b,
  input    wire  [2  :0]  pad_core2_hartid,
  input    wire           pad_core2_rst_b,
  input    wire  [39 :0]  pad_core2_rvba,
`endif
`ifdef QUAD_CORE
  input    wire           pad_core3_dbg_mask,
  input    wire           pad_core3_dbgrq_b,
  input    wire  [2  :0]  pad_core3_hartid,
  input    wire           pad_core3_rst_b,
  input    wire  [39 :0]  pad_core3_rvba,
`endif
  input    wire  [39 :0]  pad_cpu_apb_base,
  input    wire           pad_cpu_l2cache_flush_req,
  input    wire           pad_cpu_rst_b,
  input    wire  [63 :0]  pad_cpu_sys_cnt,
  input    wire           pad_had_jtg_tclk,
  input    wire           pad_had_jtg_tdi,
  input    wire           pad_had_jtg_tms,
  input    wire           pad_had_jtg_trst_b,
  input    wire  [2  :0]  pad_l2c_data_mbist_clk_ratio,
  input    wire  [2  :0]  pad_l2c_tag_mbist_clk_ratio,
  input    wire  [143:0]  pad_plic_int_cfg,
  input    wire  [143:0]  pad_plic_int_vld,
  input    wire           pad_yy_dft_clk_rst_b,
  input    wire           pad_yy_icg_scan_en,
  input    wire           pad_yy_mbist_mode,
  input    wire           pad_yy_scan_enable,
  input    wire           pad_yy_scan_mode,
  input    wire           pad_yy_scan_rst_b,
  input    wire           pll_cpu_clk,
  input    wire  [7  :0]  ext_interrupt,
  output   wire  [39 :0]  biu_pad_araddr,
  output   wire  [1  :0]  biu_pad_arburst,
  output   wire  [3  :0]  biu_pad_arcache,
  output   wire  [7  :0]  biu_pad_arid,
  output   wire  [7  :0]  biu_pad_arlen,
  output   wire           biu_pad_arlock,
  output   wire  [2  :0]  biu_pad_arprot,
  output   wire  [2  :0]  biu_pad_arsize,
  output   wire           biu_pad_arvalid,
  output   wire  [39 :0]  biu_pad_awaddr,
  output   wire  [1  :0]  biu_pad_awburst,
  output   wire  [3  :0]  biu_pad_awcache,
  output   wire  [7  :0]  biu_pad_awid,
  output   wire  [7  :0]  biu_pad_awlen,
  output   wire           biu_pad_awlock,
  output   wire  [2  :0]  biu_pad_awprot,
  output   wire  [2  :0]  biu_pad_awsize,
  output   wire           biu_pad_awvalid,
  output   wire           biu_pad_bready,
  output   wire           biu_pad_cactive,
  output   wire           biu_pad_csysack,
  output   wire           biu_pad_rready,
  output   wire  [127:0]  biu_pad_wdata,
  output   wire           biu_pad_wlast,
  output   wire  [15 :0]  biu_pad_wstrb,
  output   wire           biu_pad_wvalid,
  output   wire  [1  :0]  core0_pad_jdb_pm,
  output   wire  [1  :0]  core0_pad_lpmd_b,
  output   wire  [63 :0]  core0_pad_mstatus,
  output   wire           core0_pad_retire0,
  output   wire  [63 :0]  core0_pad_retire0_pc,
  output   wire           core0_pad_retire1,
  output   wire  [63 :0]  core0_pad_retire1_pc,
  output   wire           core0_pad_retire2,
  output   wire  [63 :0]  core0_pad_retire2_pc,
  output   wire  [1  :0]  core1_pad_jdb_pm,
  output   wire  [1  :0]  core1_pad_lpmd_b,
  output   wire  [63 :0]  core1_pad_mstatus,
  output   wire           core1_pad_retire0,
  output   wire  [63 :0]  core1_pad_retire0_pc,
  output   wire           core1_pad_retire1,
  output   wire  [63 :0]  core1_pad_retire1_pc,
  output   wire           core1_pad_retire2,
  output   wire  [63 :0]  core1_pad_retire2_pc,
  output   wire           cpu_debug_port,
  output   wire           cpu_pad_l2cache_flush_done,
  output   wire           cpu_pad_no_op,
  output   wire           had_pad_jtg_tdo,
  output   wire           had_pad_jtg_tdo_en
); 



//&Ports;
// &Regs; @44
// &Wires; @45
wire             apb_clk;                       
wire             apb_clk_en;                    
wire             apbif_had_pctrace_inv;         
wire             apbrst_b;                      
wire             axim_clk_en_f;                 
wire             ciu_clint_icg_en;              
wire    [292:0]  ciu_had_dbg_info;              
wire    [32 :0]  ciu_l2c_addr_bank_0;           
wire    [32 :0]  ciu_l2c_addr_bank_1;           
wire             ciu_l2c_addr_vld_bank_0;       
wire             ciu_l2c_addr_vld_bank_1;       
wire    [3  :0]  ciu_l2c_clr_cp_bank_0;         
wire    [3  :0]  ciu_l2c_clr_cp_bank_1;         
wire             ciu_l2c_ctcq_req_bank_0;       
wire             ciu_l2c_ctcq_req_bank_1;       
wire    [2  :0]  ciu_l2c_data_latency;          
wire             ciu_l2c_data_setup;            
wire             ciu_l2c_data_vld_bank_0;       
wire             ciu_l2c_data_vld_bank_1;       
wire    [32 :0]  ciu_l2c_dca_addr_bank_0;       
wire    [32 :0]  ciu_l2c_dca_addr_bank_1;       
wire             ciu_l2c_dca_req_bank_0;        
wire             ciu_l2c_dca_req_bank_1;        
wire    [2  :0]  ciu_l2c_hpcp_bus_bank_0;       
wire    [2  :0]  ciu_l2c_hpcp_bus_bank_1;       
wire    [2  :0]  ciu_l2c_icc_mid_bank_0;        
wire    [2  :0]  ciu_l2c_icc_mid_bank_1;        
wire    [1  :0]  ciu_l2c_icc_type_bank_0;       
wire    [1  :0]  ciu_l2c_icc_type_bank_1;       
wire    [1  :0]  ciu_l2c_iprf;                  
wire    [2  :0]  ciu_l2c_mid_bank_0;            
wire    [2  :0]  ciu_l2c_mid_bank_1;            
wire             ciu_l2c_prf_ready;             
wire             ciu_l2c_rdl_ready_bank_0;      
wire             ciu_l2c_rdl_ready_bank_1;      
wire             ciu_l2c_rst_req;               
wire    [3  :0]  ciu_l2c_set_cp_bank_0;         
wire    [3  :0]  ciu_l2c_set_cp_bank_1;         
wire    [4  :0]  ciu_l2c_sid_bank_0;            
wire    [4  :0]  ciu_l2c_sid_bank_1;            
wire             ciu_l2c_snpl2_ready_bank_0;    
wire             ciu_l2c_snpl2_ready_bank_1;    
wire    [1  :0]  ciu_l2c_src_bank_0;            
wire    [1  :0]  ciu_l2c_src_bank_1;            
wire    [2  :0]  ciu_l2c_tag_latency;           
wire             ciu_l2c_tag_setup;             
wire             ciu_l2c_tprf;                  
wire    [12 :0]  ciu_l2c_type_bank_0;           
wire    [12 :0]  ciu_l2c_type_bank_1;           
wire    [511:0]  ciu_l2c_wdata_bank_0;          
wire    [511:0]  ciu_l2c_wdata_bank_1;          
wire             ciu_plic_icg_en;               
wire             ciu_sysio_icg_en;              
wire             ciu_top_clk;                   
wire             ciu_xx_no_op;                  
wire             clint_core0_ms_int;            
wire             clint_core0_mt_int;            
wire             clint_core0_ss_int;            
wire             clint_core0_st_int;            
wire             clint_core1_ms_int;            
wire             clint_core1_mt_int;            
wire             clint_core1_ss_int;            
wire             clint_core1_st_int;            
wire             core0_cpu_no_retire;           
wire             core0_dbg_ack_pc;              
wire             core0_enter_dbg_req_i;         
wire             core0_enter_dbg_req_o;         
wire             core0_exit_dbg_req_i;          
wire             core0_exit_dbg_req_o;          
wire             core0_fifo_rst_b;              
wire             core0_had_dbg_mask;            
wire    [63 :0]  core0_regs_serial_data;        
wire             core0_rst_b;                   
wire             core1_cpu_no_retire;           
wire             core1_dbg_ack_pc;              
wire             core1_enter_dbg_req_i;         
wire             core1_enter_dbg_req_o;         
wire             core1_exit_dbg_req_i;          
wire             core1_exit_dbg_req_o;          
wire             core1_fifo_rst_b;              
wire             core2_cpu_no_retire;           
wire             core2_dbg_ack_pc;              
wire             core2_enter_dbg_req_i;         
wire             core2_enter_dbg_req_o;         
wire             core2_exit_dbg_req_i;          
wire             core2_exit_dbg_req_o;          
wire             core2_fifo_rst_b;              
wire             core3_cpu_no_retire;           
wire             core3_dbg_ack_pc;              
wire             core3_enter_dbg_req_i;         
wire             core3_enter_dbg_req_o;         
wire             core3_exit_dbg_req_i;          
wire             core3_exit_dbg_req_o;          
wire             core3_fifo_rst_b;              
wire             core1_had_dbg_mask;            
wire    [63 :0]  core1_regs_serial_data;        
wire    [63 :0]  core2_regs_serial_data;        
wire    [63 :0]  core3_regs_serial_data;        
wire             core1_rst_b;                   
wire             core2_rst_b;                   
wire             core3_rst_b;                              
wire             cpurst_b;                      
wire             forever_core0_clk;             
wire             forever_core1_clk;             
wire             forever_core2_clk;             
wire             forever_core3_clk;             
wire             forever_cpuclk;                
wire             forever_jtgclk;                
wire             ibiu0_pad_acready;             
wire    [39 :0]  ibiu0_pad_araddr;              
wire    [1  :0]  ibiu0_pad_arbar;               
wire    [1  :0]  ibiu0_pad_arburst;             
wire    [3  :0]  ibiu0_pad_arcache;             
wire    [1  :0]  ibiu0_pad_ardomain;            
wire    [4  :0]  ibiu0_pad_arid;                
wire    [1  :0]  ibiu0_pad_arlen;               
wire             ibiu0_pad_arlock;              
wire    [2  :0]  ibiu0_pad_arprot;              
wire    [2  :0]  ibiu0_pad_arsize;              
wire    [3  :0]  ibiu0_pad_arsnoop;             
wire    [2  :0]  ibiu0_pad_aruser;              
wire             ibiu0_pad_arvalid;             
wire    [39 :0]  ibiu0_pad_awaddr;              
wire    [1  :0]  ibiu0_pad_awbar;               
wire    [1  :0]  ibiu0_pad_awburst;             
wire    [3  :0]  ibiu0_pad_awcache;             
wire    [1  :0]  ibiu0_pad_awdomain;            
wire    [4  :0]  ibiu0_pad_awid;                
wire    [1  :0]  ibiu0_pad_awlen;               
wire             ibiu0_pad_awlock;              
wire    [2  :0]  ibiu0_pad_awprot;              
wire    [2  :0]  ibiu0_pad_awsize;              
wire    [2  :0]  ibiu0_pad_awsnoop;             
wire             ibiu0_pad_awunique;            
wire             ibiu0_pad_awuser;              
wire             ibiu0_pad_awvalid;             
wire             ibiu0_pad_back;                
wire             ibiu0_pad_bready;              
wire    [127:0]  ibiu0_pad_cddata;              
wire             ibiu0_pad_cderr;               
wire             ibiu0_pad_cdlast;              
wire             ibiu0_pad_cdvalid;             
wire    [3  :0]  ibiu0_pad_cnt_en;              
wire    [4  :0]  ibiu0_pad_crresp;              
wire             ibiu0_pad_crvalid;             
wire             ibiu0_pad_csr_sel;             
wire    [79 :0]  ibiu0_pad_csr_wdata;           
wire             ibiu0_pad_jdb_pm;              
wire             ibiu0_pad_lpmd_b;              
wire             ibiu0_pad_rack;                
wire             ibiu0_pad_rready;              
wire    [127:0]  ibiu0_pad_wdata;               
wire             ibiu0_pad_werr;                
wire             ibiu0_pad_wlast;               
wire             ibiu0_pad_wns;                 
wire    [15 :0]  ibiu0_pad_wstrb;               
wire             ibiu0_pad_wvalid;              
wire             ibiu1_pad_acready;             
wire    [39 :0]  ibiu1_pad_araddr;              
wire    [1  :0]  ibiu1_pad_arbar;               
wire    [1  :0]  ibiu1_pad_arburst;             
wire    [3  :0]  ibiu1_pad_arcache;             
wire    [1  :0]  ibiu1_pad_ardomain;            
wire    [4  :0]  ibiu1_pad_arid;                
wire    [1  :0]  ibiu1_pad_arlen;               
wire             ibiu1_pad_arlock;              
wire    [2  :0]  ibiu1_pad_arprot;              
wire    [2  :0]  ibiu1_pad_arsize;              
wire    [3  :0]  ibiu1_pad_arsnoop;             
wire    [2  :0]  ibiu1_pad_aruser;              
wire             ibiu1_pad_arvalid;             
wire    [39 :0]  ibiu1_pad_awaddr;              
wire    [1  :0]  ibiu1_pad_awbar;               
wire    [1  :0]  ibiu1_pad_awburst;             
wire    [3  :0]  ibiu1_pad_awcache;             
wire    [1  :0]  ibiu1_pad_awdomain;            
wire    [4  :0]  ibiu1_pad_awid;                
wire    [1  :0]  ibiu1_pad_awlen;               
wire             ibiu1_pad_awlock;              
wire    [2  :0]  ibiu1_pad_awprot;              
wire    [2  :0]  ibiu1_pad_awsize;              
wire    [2  :0]  ibiu1_pad_awsnoop;             
wire             ibiu1_pad_awunique;            
wire             ibiu1_pad_awuser;              
wire             ibiu1_pad_awvalid;             
wire             ibiu1_pad_back;                
wire             ibiu1_pad_bready;              
wire    [127:0]  ibiu1_pad_cddata;              
wire             ibiu1_pad_cderr;               
wire             ibiu1_pad_cdlast;              
wire             ibiu1_pad_cdvalid;             
wire    [3  :0]  ibiu1_pad_cnt_en;              
wire    [4  :0]  ibiu1_pad_crresp;              
wire             ibiu1_pad_crvalid;             
wire             ibiu1_pad_csr_sel;             
wire    [79 :0]  ibiu1_pad_csr_wdata;           
wire             ibiu1_pad_jdb_pm;              
wire             ibiu1_pad_lpmd_b;              
wire             ibiu1_pad_rack;                
wire             ibiu1_pad_rready;              
wire    [127:0]  ibiu1_pad_wdata;               
wire             ibiu1_pad_werr;                
wire             ibiu1_pad_wlast;               
wire             ibiu1_pad_wns;                 
wire    [15 :0]  ibiu1_pad_wstrb;               
wire             ibiu1_pad_wvalid;              
wire             ibiu2_pad_acready;             
wire    [39 :0]  ibiu2_pad_araddr;              
wire    [1  :0]  ibiu2_pad_arbar;               
wire    [1  :0]  ibiu2_pad_arburst;             
wire    [3  :0]  ibiu2_pad_arcache;             
wire    [1  :0]  ibiu2_pad_ardomain;            
wire    [4  :0]  ibiu2_pad_arid;                
wire    [1  :0]  ibiu2_pad_arlen;               
wire             ibiu2_pad_arlock;              
wire    [2  :0]  ibiu2_pad_arprot;              
wire    [2  :0]  ibiu2_pad_arsize;              
wire    [3  :0]  ibiu2_pad_arsnoop;             
wire    [2  :0]  ibiu2_pad_aruser;              
wire             ibiu2_pad_arvalid;             
wire    [39 :0]  ibiu2_pad_awaddr;              
wire    [1  :0]  ibiu2_pad_awbar;               
wire    [1  :0]  ibiu2_pad_awburst;             
wire    [3  :0]  ibiu2_pad_awcache;             
wire    [1  :0]  ibiu2_pad_awdomain;            
wire    [4  :0]  ibiu2_pad_awid;                
wire    [1  :0]  ibiu2_pad_awlen;               
wire             ibiu2_pad_awlock;              
wire    [2  :0]  ibiu2_pad_awprot;              
wire    [2  :0]  ibiu2_pad_awsize;              
wire    [2  :0]  ibiu2_pad_awsnoop;             
wire             ibiu2_pad_awunique;            
wire             ibiu2_pad_awuser;              
wire             ibiu2_pad_awvalid;             
wire             ibiu2_pad_back;                
wire             ibiu2_pad_bready;              
wire    [127:0]  ibiu2_pad_cddata;              
wire             ibiu2_pad_cderr;               
wire             ibiu2_pad_cdlast;              
wire             ibiu2_pad_cdvalid;             
wire    [3  :0]  ibiu2_pad_cnt_en;              
wire    [4  :0]  ibiu2_pad_crresp;              
wire             ibiu2_pad_crvalid;             
wire             ibiu2_pad_csr_sel;             
wire    [79 :0]  ibiu2_pad_csr_wdata;           
wire             ibiu2_pad_jdb_pm;              
wire             ibiu2_pad_lpmd_b;              
wire             ibiu2_pad_rack;                
wire             ibiu2_pad_rready;              
wire    [127:0]  ibiu2_pad_wdata;               
wire             ibiu2_pad_werr;                
wire             ibiu2_pad_wlast;               
wire             ibiu2_pad_wns;                 
wire    [15 :0]  ibiu2_pad_wstrb;               
wire             ibiu2_pad_wvalid;              
wire             ibiu3_pad_acready;             
wire    [39 :0]  ibiu3_pad_araddr;              
wire    [1  :0]  ibiu3_pad_arbar;               
wire    [1  :0]  ibiu3_pad_arburst;             
wire    [3  :0]  ibiu3_pad_arcache;             
wire    [1  :0]  ibiu3_pad_ardomain;            
wire    [4  :0]  ibiu3_pad_arid;                
wire    [1  :0]  ibiu3_pad_arlen;               
wire             ibiu3_pad_arlock;              
wire    [2  :0]  ibiu3_pad_arprot;              
wire    [2  :0]  ibiu3_pad_arsize;              
wire    [3  :0]  ibiu3_pad_arsnoop;             
wire    [2  :0]  ibiu3_pad_aruser;              
wire             ibiu3_pad_arvalid;             
wire    [39 :0]  ibiu3_pad_awaddr;              
wire    [1  :0]  ibiu3_pad_awbar;               
wire    [1  :0]  ibiu3_pad_awburst;             
wire    [3  :0]  ibiu3_pad_awcache;             
wire    [1  :0]  ibiu3_pad_awdomain;            
wire    [4  :0]  ibiu3_pad_awid;                
wire    [1  :0]  ibiu3_pad_awlen;               
wire             ibiu3_pad_awlock;              
wire    [2  :0]  ibiu3_pad_awprot;              
wire    [2  :0]  ibiu3_pad_awsize;              
wire    [2  :0]  ibiu3_pad_awsnoop;             
wire             ibiu3_pad_awunique;            
wire             ibiu3_pad_awuser;              
wire             ibiu3_pad_awvalid;             
wire             ibiu3_pad_back;                
wire             ibiu3_pad_bready;              
wire    [127:0]  ibiu3_pad_cddata;              
wire             ibiu3_pad_cderr;               
wire             ibiu3_pad_cdlast;              
wire             ibiu3_pad_cdvalid;             
wire    [3  :0]  ibiu3_pad_cnt_en;              
wire    [4  :0]  ibiu3_pad_crresp;              
wire             ibiu3_pad_crvalid;             
wire             ibiu3_pad_csr_sel;             
wire    [79 :0]  ibiu3_pad_csr_wdata;           
wire             ibiu3_pad_jdb_pm;              
wire             ibiu3_pad_lpmd_b;              
wire             ibiu3_pad_rack;                
wire             ibiu3_pad_rready;              
wire    [127:0]  ibiu3_pad_wdata;               
wire             ibiu3_pad_werr;                
wire             ibiu3_pad_wlast;               
wire             ibiu3_pad_wns;                 
wire    [15 :0]  ibiu3_pad_wstrb;               
wire             ibiu3_pad_wvalid;              
wire    [63 :0]  ir_corex_wdata;                
wire             l2c_ciu_addr_ready_bank_0;     
wire             l2c_ciu_addr_ready_bank_1;     
wire             l2c_ciu_cmplt_bank_0;          
wire             l2c_ciu_cmplt_bank_1;          
wire    [3  :0]  l2c_ciu_cp_bank_0;             
wire    [3  :0]  l2c_ciu_cp_bank_1;             
wire             l2c_ciu_ctcq_cmplt_bank_0;     
wire             l2c_ciu_ctcq_cmplt_bank_1;     
wire             l2c_ciu_ctcq_ready_bank_0;     
wire             l2c_ciu_ctcq_ready_bank_1;     
wire    [511:0]  l2c_ciu_data_bank_0;           
wire    [511:0]  l2c_ciu_data_bank_1;           
wire             l2c_ciu_data_ready_bank_0;     
wire             l2c_ciu_data_ready_bank_1;     
wire             l2c_ciu_data_ready_gate_bank_0; 
wire             l2c_ciu_data_ready_gate_bank_1; 
wire    [43 :0]  l2c_ciu_dbg_info;              
wire             l2c_ciu_dca_cmplt_bank_0;      
wire             l2c_ciu_dca_cmplt_bank_1;      
wire    [127:0]  l2c_ciu_dca_data_bank_0;       
wire    [127:0]  l2c_ciu_dca_data_bank_1;       
wire             l2c_ciu_dca_ready_bank_0;      
wire             l2c_ciu_dca_ready_bank_1;      
wire    [1  :0]  l2c_ciu_hpcp_acc_inc_bank_0;   
wire    [1  :0]  l2c_ciu_hpcp_acc_inc_bank_1;   
wire    [2  :0]  l2c_ciu_hpcp_mid_bank_0;       
wire    [2  :0]  l2c_ciu_hpcp_mid_bank_1;       
wire    [1  :0]  l2c_ciu_hpcp_miss_inc_bank_0;  
wire    [1  :0]  l2c_ciu_hpcp_miss_inc_bank_1;  
wire    [33 :0]  l2c_ciu_prf_addr;              
wire    [2  :0]  l2c_ciu_prf_prot;              
wire             l2c_ciu_prf_vld;               
wire    [32 :0]  l2c_ciu_rdl_addr_bank_0;       
wire    [32 :0]  l2c_ciu_rdl_addr_bank_1;       
wire             l2c_ciu_rdl_dvld_bank_0;       
wire             l2c_ciu_rdl_dvld_bank_1;       
wire    [2  :0]  l2c_ciu_rdl_mid_bank_0;        
wire    [2  :0]  l2c_ciu_rdl_mid_bank_1;        
wire    [2  :0]  l2c_ciu_rdl_prot_bank_0;       
wire    [2  :0]  l2c_ciu_rdl_prot_bank_1;       
wire             l2c_ciu_rdl_rvld_bank_0;       
wire             l2c_ciu_rdl_rvld_bank_1;       
wire    [4  :0]  l2c_ciu_resp_bank_0;           
wire    [4  :0]  l2c_ciu_resp_bank_1;           
wire    [4  :0]  l2c_ciu_sid_bank_0;            
wire    [4  :0]  l2c_ciu_sid_bank_1;            
wire    [32 :0]  l2c_ciu_snpl2_addr_bank_0;     
wire    [32 :0]  l2c_ciu_snpl2_addr_bank_1;     
wire    [4  :0]  l2c_ciu_snpl2_ini_sid_bank_0;  
wire    [4  :0]  l2c_ciu_snpl2_ini_sid_bank_1;  
wire             l2c_ciu_snpl2_vld_bank_0;      
wire             l2c_ciu_snpl2_vld_bank_1;      
wire             l2c_data_clk_bank_0;           
wire             l2c_data_clk_bank_1;           
wire             l2c_data_ram_clk_en_bank_0;    
wire             l2c_data_ram_clk_en_bank_1;    
wire    [43 :0]  l2c_had_dbg_info;              
wire             l2c_icg_en;                    
wire             l2c_plic_ecc_int_vld;          
wire             l2c_sysio_flush_done;          
wire             l2c_sysio_flush_idle;          
wire             l2c_tag_clk_bank_0;            
wire             l2c_tag_clk_bank_1;            
wire             l2c_tag_ram_clk_en_bank_0;     
wire             l2c_tag_ram_clk_en_bank_1;     
wire             l2c_xx_no_op;                  
wire    [39 :0]  pad_ibiu0_acaddr;              
wire    [2  :0]  pad_ibiu0_acprot;              
wire    [3  :0]  pad_ibiu0_acsnoop;             
wire             pad_ibiu0_acvalid;             
wire             pad_ibiu0_arready;             
wire             pad_ibiu0_awready;             
wire    [4  :0]  pad_ibiu0_bid;                 
wire    [1  :0]  pad_ibiu0_bresp;               
wire             pad_ibiu0_bvalid;              
wire             pad_ibiu0_cdready;             
wire             pad_ibiu0_crready;             
wire             pad_ibiu0_csr_cmplt;           
wire    [127:0]  pad_ibiu0_csr_rdata;           
wire             pad_ibiu0_dbgrq_b;             
wire    [3  :0]  pad_ibiu0_hpcp_l2of_int;       
wire    [7  :0]  sysio_piu0_ex_int;              
wire             pad_ibiu0_me_int;              
wire             pad_ibiu0_ms_int;              
wire             pad_ibiu0_mt_int;              
wire    [127:0]  pad_ibiu0_rdata;               
wire    [4  :0]  pad_ibiu0_rid;                 
wire             pad_ibiu0_rlast;               
wire    [3  :0]  pad_ibiu0_rresp;               
wire             pad_ibiu0_rvalid;              
wire             pad_ibiu0_se_int;              
wire             pad_ibiu0_ss_int;              
wire             pad_ibiu0_st_int;              
wire             pad_ibiu0_wns_awready;         
wire             pad_ibiu0_wns_wready;          
wire             pad_ibiu0_wready;              
wire             pad_ibiu0_ws_awready;          
wire             pad_ibiu0_ws_wready;           
wire    [39 :0]  pad_ibiu1_acaddr;              
wire    [2  :0]  pad_ibiu1_acprot;              
wire    [3  :0]  pad_ibiu1_acsnoop;             
wire             pad_ibiu1_acvalid;             
wire             pad_ibiu1_arready;             
wire             pad_ibiu1_awready;             
wire    [4  :0]  pad_ibiu1_bid;                 
wire    [1  :0]  pad_ibiu1_bresp;               
wire             pad_ibiu1_bvalid;              
wire             pad_ibiu1_cdready;             
wire             pad_ibiu1_crready;             
wire             pad_ibiu1_csr_cmplt;           
wire    [127:0]  pad_ibiu1_csr_rdata;           
wire             pad_ibiu1_dbgrq_b;             
wire    [3  :0]  pad_ibiu1_hpcp_l2of_int;       
wire    [7  :0]  sysio_piu1_ex_int;              
wire             pad_ibiu1_me_int;              
wire             pad_ibiu1_ms_int;              
wire             pad_ibiu1_mt_int;              
wire    [127:0]  pad_ibiu1_rdata;               
wire    [4  :0]  pad_ibiu1_rid;                 
wire             pad_ibiu1_rlast;               
wire    [3  :0]  pad_ibiu1_rresp;               
wire             pad_ibiu1_rvalid;              
wire             pad_ibiu1_se_int;              
wire             pad_ibiu1_ss_int;              
wire             pad_ibiu1_st_int;              
wire             pad_ibiu1_wns_awready;         
wire             pad_ibiu1_wns_wready;          
wire             pad_ibiu1_wready;              
wire             pad_ibiu1_ws_awready;          
wire             pad_ibiu1_ws_wready;           
wire    [39 :0]  pad_ibiu2_acaddr;              
wire    [2  :0]  pad_ibiu2_acprot;              
wire    [3  :0]  pad_ibiu2_acsnoop;             
wire             pad_ibiu2_acvalid;             
wire             pad_ibiu2_arready;             
wire             pad_ibiu2_awready;             
wire    [4  :0]  pad_ibiu2_bid;                 
wire    [1  :0]  pad_ibiu2_bresp;               
wire             pad_ibiu2_bvalid;              
wire             pad_ibiu2_cdready;             
wire             pad_ibiu2_crready;             
wire             pad_ibiu2_csr_cmplt;           
wire    [127:0]  pad_ibiu2_csr_rdata;           
wire             pad_ibiu2_dbgrq_b;             
wire    [3  :0]  pad_ibiu2_hpcp_l2of_int;       
wire    [7  :0]  sysio_piu2_ex_int;              
wire             pad_ibiu2_me_int;              
wire             pad_ibiu2_ms_int;              
wire             pad_ibiu2_mt_int;              
wire    [127:0]  pad_ibiu2_rdata;               
wire    [4  :0]  pad_ibiu2_rid;                 
wire             pad_ibiu2_rlast;               
wire    [3  :0]  pad_ibiu2_rresp;               
wire             pad_ibiu2_rvalid;              
wire             pad_ibiu2_se_int;              
wire             pad_ibiu2_ss_int;              
wire             pad_ibiu2_st_int;              
wire             pad_ibiu2_wns_awready;         
wire             pad_ibiu2_wns_wready;          
wire             pad_ibiu2_wready;              
wire             pad_ibiu2_ws_awready;          
wire             pad_ibiu2_ws_wready;           
wire    [39 :0]  pad_ibiu3_acaddr;              
wire    [2  :0]  pad_ibiu3_acprot;              
wire    [3  :0]  pad_ibiu3_acsnoop;             
wire             pad_ibiu3_acvalid;             
wire             pad_ibiu3_arready;             
wire             pad_ibiu3_awready;             
wire    [4  :0]  pad_ibiu3_bid;                 
wire    [1  :0]  pad_ibiu3_bresp;               
wire             pad_ibiu3_bvalid;              
wire             pad_ibiu3_cdready;             
wire             pad_ibiu3_crready;             
wire             pad_ibiu3_csr_cmplt;           
wire    [127:0]  pad_ibiu3_csr_rdata;           
wire             pad_ibiu3_dbgrq_b;             
wire    [3  :0]  pad_ibiu3_hpcp_l2of_int;       
wire    [7  :0]  sysio_piu3_ex_int;              
wire             pad_ibiu3_me_int;              
wire             pad_ibiu3_ms_int;              
wire             pad_ibiu3_mt_int;              
wire    [127:0]  pad_ibiu3_rdata;               
wire    [4  :0]  pad_ibiu3_rid;                 
wire             pad_ibiu3_rlast;               
wire    [3  :0]  pad_ibiu3_rresp;               
wire             pad_ibiu3_rvalid;              
wire             pad_ibiu3_se_int;              
wire             pad_ibiu3_ss_int;              
wire             pad_ibiu3_st_int;              
wire             pad_ibiu3_wns_awready;         
wire             pad_ibiu3_wns_wready;          
wire             pad_ibiu3_wready;              
wire             pad_ibiu3_ws_awready;          
wire             pad_ibiu3_ws_wready;           
wire    [31 :0]  paddr;                         
wire             penable;                       
wire             perr_clint;                    
wire             perr_had;                      
wire             perr_plic;                     
wire             perr_rmr;                      
wire             phl_rst_b;                     
wire    [1  :0]  piu0_sysio_jdb_pm;             
wire    [1  :0]  piu0_sysio_lpmd_b;             
wire    [1  :0]  piu1_sysio_jdb_pm;             
wire    [1  :0]  piu1_sysio_lpmd_b;             
wire             plic_core0_me_int;             
wire             plic_core0_se_int;             
wire             plic_core1_me_int;             
wire             plic_core1_se_int;             
wire    [1  :0]  plic_hartx_mint_req;           
wire    [1  :0]  plic_hartx_sint_req;           
wire    [159:0]  plic_int_cfg;                  
wire    [159:0]  plic_int_vld;                  
wire    [1  :0]  pprot;                         
wire    [31 :0]  prdata_clint;                  
wire    [31 :0]  prdata_had;                    
wire    [31 :0]  prdata_plic;                   
wire    [31 :0]  prdata_rmr;                    
wire             pready_clint;                  
wire             pready_had;                    
wire             pready_plic;                   
wire             pready_rmr;                    
wire             psel_clint;                    
wire             psel_had;                      
wire             psel_plic;                     
wire             psel_rmr;                      
wire    [31 :0]  pwdata;                        
wire             pwrite;                        
wire             sm_update_dr;                  
wire             sm_update_ir;                  
wire    [39 :0]  sysio_ciu_apb_base;            
wire    [63 :0]  sysio_clint_mtime;             
wire    [3  :0]  sysio_had_dbg_mask;            
wire             sysio_l2c_flush_req;           
wire             sysio_piu0_dbgrq_b;            
wire             sysio_piu0_me_int;             
wire             sysio_piu0_ms_int;             
wire             sysio_piu0_mt_int;             
wire             sysio_piu0_se_int;             
wire             sysio_piu0_ss_int;             
wire             sysio_piu0_st_int;             
wire             sysio_piu1_dbgrq_b;            
wire             sysio_piu1_me_int;             
wire             sysio_piu1_ms_int;             
wire             sysio_piu1_mt_int;             
wire             sysio_piu1_se_int;             
wire             sysio_piu1_ss_int;             
wire             sysio_piu1_st_int;             
wire    [39 :0]  sysio_xx_apb_base;             
wire    [63 :0]  sysio_xx_time;                 
wire             trst_b;                        
wire    [1  :0]  core2_pad_jdb_pm;
wire    [1  :0]  core2_pad_lpmd_b;
wire    [63 :0]  core2_pad_mstatus;
wire             core2_pad_retire0;
wire    [63 :0]  core2_pad_retire0_pc;
wire             core2_pad_retire1;
wire    [63 :0]  core2_pad_retire1_pc;
wire             core2_pad_retire2;
wire    [63 :0]  core2_pad_retire2_pc;
wire    [1  :0]  core3_pad_jdb_pm;
wire    [1  :0]  core3_pad_lpmd_b;
wire    [63 :0]  core3_pad_mstatus;
wire             core3_pad_retire0;
wire    [63 :0]  core3_pad_retire0_pc;
wire             core3_pad_retire1;
wire    [63 :0]  core3_pad_retire1_pc;
wire             core3_pad_retire2;
wire    [63 :0]  core3_pad_retire2_pc;
wire    [63 :0]  sysio_core_gl_stable_timer;
wire    [63 :0]  sysio_core0_restart_entry;
wire             sysio_core0_restart_vld;
wire             core0_sysio_restart_grnt;
wire    [63 :0]  sysio_core1_restart_entry;
wire             sysio_core1_restart_vld;
wire             core1_sysio_restart_grnt;
wire             sysio_core0_cp0_update_ipi_status_en;
wire    [31 :0]  sysio_core0_cp0_update_ipi_status_src;
wire             sysio_core0_cp0_update_mailbox0_en;
wire             sysio_core0_cp0_update_mailbox1_en;
wire             sysio_core0_cp0_update_mailbox2_en;
wire             sysio_core0_cp0_update_mailbox3_en;
wire             sysio_core0_cp0_req_grnt;
wire    [3  :0]  sysio_core0_cp0_update_bit_sel;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_src0;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_src1;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_src2;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_src3;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_mask0;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_mask1;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_mask2;
wire    [31 :0]  sysio_core0_cp0_update_mailbox_mask3;
wire             sysio_core1_cp0_update_ipi_status_en;
wire    [31 :0]  sysio_core1_cp0_update_ipi_status_src;
wire             sysio_core1_cp0_update_mailbox0_en;
wire             sysio_core1_cp0_update_mailbox1_en;
wire             sysio_core1_cp0_update_mailbox2_en;
wire             sysio_core1_cp0_update_mailbox3_en;
wire             sysio_core1_cp0_req_grnt;
wire    [3  :0]  sysio_core1_cp0_update_bit_sel;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_src0;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_src1;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_src2;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_src3;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_mask0;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_mask1;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_mask2;
wire    [31 :0]  sysio_core1_cp0_update_mailbox_mask3;
wire             core0_sysio_wr_req;
wire    [3  :0]  core0_sysio_wr_sel;
wire    [31 :0]  core0_sysio_wr_ipi_send_data;
wire    [63 :0]  core0_sysio_wr_mail_box_send_data;
wire    [63 :0]  core0_sysio_mailbox0_data;
wire             core1_sysio_wr_req;
wire    [3  :0]  core1_sysio_wr_sel;
wire    [31 :0]  core1_sysio_wr_ipi_send_data;
wire    [63 :0]  core1_sysio_wr_mail_box_send_data;
wire    [63 :0]  core1_sysio_mailbox0_data;
wire    [63 :0]  sysio_core2_restart_entry;
wire             sysio_core2_restart_vld;
wire             core2_sysio_restart_grnt;
wire    [63 :0]  sysio_core3_restart_entry;
wire             sysio_core3_restart_vld;
wire             core3_sysio_restart_grnt;
wire             sysio_core2_cp0_update_ipi_status_en;
wire    [31 :0]  sysio_core2_cp0_update_ipi_status_src;
wire             sysio_core2_cp0_update_mailbox0_en;
wire             sysio_core2_cp0_update_mailbox1_en;
wire             sysio_core2_cp0_update_mailbox2_en;
wire             sysio_core2_cp0_update_mailbox3_en;
wire             sysio_core2_cp0_req_grnt;
wire    [3  :0]  sysio_core2_cp0_update_bit_sel;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_src0;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_src1;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_src2;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_src3;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_mask0;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_mask1;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_mask2;
wire    [31 :0]  sysio_core2_cp0_update_mailbox_mask3;
wire             sysio_core3_cp0_update_ipi_status_en;
wire    [31 :0]  sysio_core3_cp0_update_ipi_status_src;
wire             sysio_core3_cp0_update_mailbox0_en;
wire             sysio_core3_cp0_update_mailbox1_en;
wire             sysio_core3_cp0_update_mailbox2_en;
wire             sysio_core3_cp0_update_mailbox3_en;
wire             sysio_core3_cp0_req_grnt;
wire    [3  :0]  sysio_core3_cp0_update_bit_sel;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_src0;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_src1;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_src2;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_src3;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_mask0;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_mask1;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_mask2;
wire    [31 :0]  sysio_core3_cp0_update_mailbox_mask3;
wire             core2_sysio_wr_req;
wire    [3  :0]  core2_sysio_wr_sel;
wire    [31 :0]  core2_sysio_wr_ipi_send_data;
wire    [63 :0]  core2_sysio_wr_mail_box_send_data;
wire    [63 :0]  core2_sysio_mailbox0_data;
wire             core3_sysio_wr_req;
wire    [3  :0]  core3_sysio_wr_sel;
wire    [31 :0]  core3_sysio_wr_ipi_send_data;
wire    [63 :0]  core3_sysio_wr_mail_box_send_data;
wire    [63 :0]  core3_sysio_mailbox0_data;

//==========================================================
//  reset management unit
//==========================================================
// &Instance("ct_rmu_top","x_rmu_top"); @66
// &Instance("ct_rmu_top_dummy", "x_rmu_top"); @68
ct_rmu_top_dummy  x_rmu_top (
  .apb_clk    (apb_clk   ),
  .apbrst_b   (apbrst_b  ),
  .penable    (penable   ),
  .perr_rmr   (perr_rmr  ),
  .prdata_rmr (prdata_rmr),
  .pready_rmr (pready_rmr),
  .psel_rmr   (psel_rmr  )
);

//==========================================================
//  PMU port
//==========================================================
// &Force("input", "pad_cpu_sleep_in"); @74
// &Force("output", "cpu_pad_sleep_out"); @75
// &Force("input","pad_core0_iso_en"); @77
// &Force("input","pad_core1_iso_en"); @80
// &Force("input","pad_core2_iso_en"); @83
// &Force("input","pad_core3_iso_en"); @86
//==========================================================
//  Instance top module
//==========================================================
// &ConnRule(s/biu_/ibiu0_/); @92
// &ConnRule(s/rtu_/core0_/); @93
// &ConnRule(s/idu_/core0_/); @94
// &ConnRule(s/cp0_/core0_/); @95
// &ConnRule(s/^x_/core0_/); @96
// &Instance("ct_top", "x_ct_top_0"); @97
ct_top core_top_0 (
  .biu_pad_acready                       (ibiu0_pad_acready                     ),
  .biu_pad_araddr                        (ibiu0_pad_araddr                      ),
  .biu_pad_arbar                         (ibiu0_pad_arbar                       ),
  .biu_pad_arburst                       (ibiu0_pad_arburst                     ),
  .biu_pad_arcache                       (ibiu0_pad_arcache                     ),
  .biu_pad_ardomain                      (ibiu0_pad_ardomain                    ),
  .biu_pad_arid                          (ibiu0_pad_arid                        ),
  .biu_pad_arlen                         (ibiu0_pad_arlen                       ),
  .biu_pad_arlock                        (ibiu0_pad_arlock                      ),
  .biu_pad_arprot                        (ibiu0_pad_arprot                      ),
  .biu_pad_arsize                        (ibiu0_pad_arsize                      ),
  .biu_pad_arsnoop                       (ibiu0_pad_arsnoop                     ),
  .biu_pad_aruser                        (ibiu0_pad_aruser                      ),
  .biu_pad_arvalid                       (ibiu0_pad_arvalid                     ),
  .biu_pad_awaddr                        (ibiu0_pad_awaddr                      ),
  .biu_pad_awbar                         (ibiu0_pad_awbar                       ),
  .biu_pad_awburst                       (ibiu0_pad_awburst                     ),
  .biu_pad_awcache                       (ibiu0_pad_awcache                     ),
  .biu_pad_awdomain                      (ibiu0_pad_awdomain                    ),
  .biu_pad_awid                          (ibiu0_pad_awid                        ),
  .biu_pad_awlen                         (ibiu0_pad_awlen                       ),
  .biu_pad_awlock                        (ibiu0_pad_awlock                      ),
  .biu_pad_awprot                        (ibiu0_pad_awprot                      ),
  .biu_pad_awsize                        (ibiu0_pad_awsize                      ),
  .biu_pad_awsnoop                       (ibiu0_pad_awsnoop                     ),
  .biu_pad_awunique                      (ibiu0_pad_awunique                    ),
  .biu_pad_awuser                        (ibiu0_pad_awuser                      ),
  .biu_pad_awvalid                       (ibiu0_pad_awvalid                     ),
  .biu_pad_back                          (ibiu0_pad_back                        ),
  .biu_pad_bready                        (ibiu0_pad_bready                      ),
  .biu_pad_cddata                        (ibiu0_pad_cddata                      ),
  .biu_pad_cderr                         (ibiu0_pad_cderr                       ),
  .biu_pad_cdlast                        (ibiu0_pad_cdlast                      ),
  .biu_pad_cdvalid                       (ibiu0_pad_cdvalid                     ),
  .biu_pad_cnt_en                        (ibiu0_pad_cnt_en                      ),
  .biu_pad_crresp                        (ibiu0_pad_crresp                      ),
  .biu_pad_crvalid                       (ibiu0_pad_crvalid                     ),
  .biu_pad_csr_sel                       (ibiu0_pad_csr_sel                     ),
  .biu_pad_csr_wdata                     (ibiu0_pad_csr_wdata                   ),
  .biu_pad_jdb_pm                        (ibiu0_pad_jdb_pm                      ),
  .biu_pad_lpmd_b                        (ibiu0_pad_lpmd_b                      ),
  .biu_pad_rack                          (ibiu0_pad_rack                        ),
  .biu_pad_rready                        (ibiu0_pad_rready                      ),
  .biu_pad_wdata                         (ibiu0_pad_wdata                       ),
  .biu_pad_werr                          (ibiu0_pad_werr                        ),
  .biu_pad_wlast                         (ibiu0_pad_wlast                       ),
  .biu_pad_wns                           (ibiu0_pad_wns                         ),
  .biu_pad_wstrb                         (ibiu0_pad_wstrb                       ),
  .biu_pad_wvalid                        (ibiu0_pad_wvalid                      ),
  .cp0_pad_mstatus                       (core0_pad_mstatus                     ),
  .ir_corex_wdata                        (ir_corex_wdata                        ),
  .pad_biu_acaddr                        (pad_ibiu0_acaddr                      ),
  .pad_biu_acprot                        (pad_ibiu0_acprot                      ),
  .pad_biu_acsnoop                       (pad_ibiu0_acsnoop                     ),
  .pad_biu_acvalid                       (pad_ibiu0_acvalid                     ),
  .pad_biu_arready                       (pad_ibiu0_arready                     ),
  .pad_biu_awready                       (pad_ibiu0_awready                     ),
  .pad_biu_bid                           (pad_ibiu0_bid                         ),
  .pad_biu_bresp                         (pad_ibiu0_bresp                       ),
  .pad_biu_bvalid                        (pad_ibiu0_bvalid                      ),
  .pad_biu_cdready                       (pad_ibiu0_cdready                     ),
  .pad_biu_crready                       (pad_ibiu0_crready                     ),
  .pad_biu_csr_cmplt                     (pad_ibiu0_csr_cmplt                   ),
  .pad_biu_csr_rdata                     (pad_ibiu0_csr_rdata                   ),
  .pad_biu_dbgrq_b                       (pad_ibiu0_dbgrq_b                     ),
  .pad_biu_hpcp_l2of_int                 (pad_ibiu0_hpcp_l2of_int               ),
  // external
  .ext_interrupt                         (sysio_piu0_ex_int                     ),
  .pad_biu_me_int                        (pad_ibiu0_me_int                      ),
  .pad_biu_ms_int                        (pad_ibiu0_ms_int                      ),
  .pad_biu_mt_int                        (pad_ibiu0_mt_int                      ),
  .pad_biu_rdata                         (pad_ibiu0_rdata                       ),
  .pad_biu_rid                           (pad_ibiu0_rid                         ),
  .pad_biu_rlast                         (pad_ibiu0_rlast                       ),
  .pad_biu_rresp                         (pad_ibiu0_rresp                       ),
  .pad_biu_rvalid                        (pad_ibiu0_rvalid                      ),
  .pad_biu_se_int                        (pad_ibiu0_se_int                      ),
  .pad_biu_ss_int                        (pad_ibiu0_ss_int                      ),
  .pad_biu_st_int                        (pad_ibiu0_st_int                      ),
  .pad_biu_wns_awready                   (pad_ibiu0_wns_awready                 ),
  .pad_biu_wns_wready                    (pad_ibiu0_wns_wready                  ),
  .pad_biu_wready                        (pad_ibiu0_wready                      ),
  .pad_biu_ws_awready                    (pad_ibiu0_ws_awready                  ),
  .pad_biu_ws_wready                     (pad_ibiu0_ws_wready                   ),
  .sysio_core_restart_entry              (sysio_core0_restart_entry             ),
  .sysio_core_restart_vld                (sysio_core0_restart_vld               ),
  .core_sysio_restart_grnt               (core0_sysio_restart_grnt              ),
  .sysio_core_gl_stable_timer            (sysio_core_gl_stable_timer            ),
  .core_sysio_wr_req                     (core0_sysio_wr_req                    ),
  .core_sysio_wr_sel                     (core0_sysio_wr_sel                    ),
  .core_sysio_wr_ipi_send_data           (core0_sysio_wr_ipi_send_data          ),
  .core_sysio_wr_mail_box_send_data      (core0_sysio_wr_mail_box_send_data     ),
  .core_sysio_mailbox0_data              (core0_sysio_mailbox0_data             ),
  .sysio_core_cp0_update_ipi_status_en   (sysio_core0_cp0_update_ipi_status_en  ),
  .sysio_core_cp0_update_ipi_status_src  (sysio_core0_cp0_update_ipi_status_src ),
  .sysio_core_cp0_update_mailbox0_en     (sysio_core0_cp0_update_mailbox0_en    ),
  .sysio_core_cp0_update_mailbox1_en     (sysio_core0_cp0_update_mailbox1_en    ),
  .sysio_core_cp0_update_mailbox2_en     (sysio_core0_cp0_update_mailbox2_en    ),
  .sysio_core_cp0_update_mailbox3_en     (sysio_core0_cp0_update_mailbox3_en    ),
  .sysio_core_cp0_req_grnt               (sysio_core0_cp0_req_grnt              ),
  .sysio_core_cp0_update_bit_sel         (sysio_core0_cp0_update_bit_sel        ),
  .sysio_core_cp0_update_mailbox_src0    (sysio_core0_cp0_update_mailbox_src0   ),
  .sysio_core_cp0_update_mailbox_src1    (sysio_core0_cp0_update_mailbox_src1   ),
  .sysio_core_cp0_update_mailbox_src2    (sysio_core0_cp0_update_mailbox_src2   ),
  .sysio_core_cp0_update_mailbox_src3    (sysio_core0_cp0_update_mailbox_src3   ),
  .sysio_core_cp0_update_mailbox_mask0   (sysio_core0_cp0_update_mailbox_mask0  ),
  .sysio_core_cp0_update_mailbox_mask1   (sysio_core0_cp0_update_mailbox_mask1  ),
  .sysio_core_cp0_update_mailbox_mask2   (sysio_core0_cp0_update_mailbox_mask2  ),
  .sysio_core_cp0_update_mailbox_mask3   (sysio_core0_cp0_update_mailbox_mask3  ),
  .pad_core_hartid                       (pad_core0_hartid                      ),
  .pad_core_rst_b                        (core0_rst_b                           ),
  .pad_core_rvba                         (pad_core0_rvba                        ),
  .pad_cpu_rst_b                         (cpurst_b                              ),
  .pad_xx_apb_base                       (sysio_xx_apb_base                     ),
  .pad_xx_time                           (sysio_xx_time                         ),
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                    ),
  .pad_yy_mbist_mode                     (pad_yy_mbist_mode                     ),
  .pad_yy_scan_mode                      (pad_yy_scan_mode                      ),
  .pad_yy_scan_rst_b                     (pad_yy_scan_rst_b                     ),
  .pll_core_clk                          (forever_core0_clk                     ),
  .rtu_cpu_no_retire                     (core0_cpu_no_retire                   ),
  .rtu_pad_retire0                       (core0_pad_retire0                     ),
  .rtu_pad_retire0_pc                    (core0_pad_retire0_pc                  ),
  .rtu_pad_retire1                       (core0_pad_retire1                     ),
  .rtu_pad_retire1_pc                    (core0_pad_retire1_pc                  ),
  .rtu_pad_retire2                       (core0_pad_retire2                     ),
  .rtu_pad_retire2_pc                    (core0_pad_retire2_pc                  ),
  .sm_update_dr                          (sm_update_dr                          ),
  .sm_update_ir                          (sm_update_ir                          ),
  .x_dbg_ack_pc                          (core0_dbg_ack_pc                      ),
  .x_enter_dbg_req_i                     (core0_enter_dbg_req_i                 ),
  .x_enter_dbg_req_o                     (core0_enter_dbg_req_o                 ),
  .x_exit_dbg_req_i                      (core0_exit_dbg_req_i                  ),
  .x_exit_dbg_req_o                      (core0_exit_dbg_req_o                  ),
  .x_had_dbg_mask                        (core0_had_dbg_mask                    ),
  .x_regs_serial_data                    (core0_regs_serial_data                )
);

// &Connect(.pad_cpu_rst_b      (cpurst_b)); @98
// &Connect(.pad_core_rst_b     (core0_rst_b)); @99
// &Connect(.pll_core_clk       (forever_core0_clk)); @100
// &Connect(.pad_core_hartid    (pad_core0_hartid)); @101
// &Connect(.pad_core_rvba      (pad_core0_rvba)); @102
// &Connect(.pad_xx_time        (sysio_xx_time)); @103
// &Connect(.pad_xx_apb_base    (sysio_xx_apb_base)); @104
// &Connect(.pad_core_async_mode(pad_core0_async_mode)); @106
// &Connect(.pad_core_sleep_in  (pad_core0_sleep_in)); @107
// &Connect(.core_pad_sleep_out (core0_pad_sleep_out)); @108
// &Connect(.mem_cfg_in         (pad_core0_mem_cfg_in)); @111

// &ConnRule(s/ciu_pbiu/pad_ibiu1/); @119
// &ConnRule(s/pbiu_ciu/ibiu1_pad/); @120
// &ConnRule(s/idu_/core1_/); @121
// &ConnRule(s/rtu_/core1_/); @122
// &ConnRule(s/cp0_/core1_/); @123
// &ConnRule(s/^ptim_/ptim1_/); @124
// &ConnRule(s/^hpcp_/hpcp1_/); @125
// &ConnRule(s/^x_/core1_/); @126
// &Instance("ct_top_uvc1", "x_ct_top_1"); @127
// &Connect(.ciu_pbiu_axid  (pad_ibiu1_ac_verf_bus)); @128
// &Connect(.core1_cpuclk  (forever_core1_clk)); @129
// &Connect(.pad_core1_rst_b  (core1_rst_b)); @130
// &ConnRule(s/biu_/ibiu1_/); @135
// &ConnRule(s/rtu_/core1_/); @136
// &ConnRule(s/idu_/core1_/); @137
// &ConnRule(s/cp0_/core1_/); @138
// &ConnRule(s/^x_/core1_/); @139
// &Instance("ct_top", "x_ct_top_1"); @140


`ifdef DUAL_CORE 
ct_top core_top_1 (
  .biu_pad_acready                       (ibiu1_pad_acready                      ),
  .biu_pad_araddr                        (ibiu1_pad_araddr                       ),
  .biu_pad_arbar                         (ibiu1_pad_arbar                        ),
  .biu_pad_arburst                       (ibiu1_pad_arburst                      ),
  .biu_pad_arcache                       (ibiu1_pad_arcache                      ),
  .biu_pad_ardomain                      (ibiu1_pad_ardomain                     ),
  .biu_pad_arid                          (ibiu1_pad_arid                         ),
  .biu_pad_arlen                         (ibiu1_pad_arlen                        ),
  .biu_pad_arlock                        (ibiu1_pad_arlock                       ),
  .biu_pad_arprot                        (ibiu1_pad_arprot                       ),
  .biu_pad_arsize                        (ibiu1_pad_arsize                       ),
  .biu_pad_arsnoop                       (ibiu1_pad_arsnoop                      ),
  .biu_pad_aruser                        (ibiu1_pad_aruser                       ),
  .biu_pad_arvalid                       (ibiu1_pad_arvalid                      ),
  .biu_pad_awaddr                        (ibiu1_pad_awaddr                       ),
  .biu_pad_awbar                         (ibiu1_pad_awbar                        ),
  .biu_pad_awburst                       (ibiu1_pad_awburst                      ),
  .biu_pad_awcache                       (ibiu1_pad_awcache                      ),
  .biu_pad_awdomain                      (ibiu1_pad_awdomain                     ),
  .biu_pad_awid                          (ibiu1_pad_awid                         ),
  .biu_pad_awlen                         (ibiu1_pad_awlen                        ),
  .biu_pad_awlock                        (ibiu1_pad_awlock                       ),
  .biu_pad_awprot                        (ibiu1_pad_awprot                       ),
  .biu_pad_awsize                        (ibiu1_pad_awsize                       ),
  .biu_pad_awsnoop                       (ibiu1_pad_awsnoop                      ),
  .biu_pad_awunique                      (ibiu1_pad_awunique                     ),
  .biu_pad_awuser                        (ibiu1_pad_awuser                       ),
  .biu_pad_awvalid                       (ibiu1_pad_awvalid                      ),
  .biu_pad_back                          (ibiu1_pad_back                         ),
  .biu_pad_bready                        (ibiu1_pad_bready                       ),
  .biu_pad_cddata                        (ibiu1_pad_cddata                       ),
  .biu_pad_cderr                         (ibiu1_pad_cderr                        ),
  .biu_pad_cdlast                        (ibiu1_pad_cdlast                       ),
  .biu_pad_cdvalid                       (ibiu1_pad_cdvalid                      ),
  .biu_pad_cnt_en                        (ibiu1_pad_cnt_en                       ),
  .biu_pad_crresp                        (ibiu1_pad_crresp                       ),
  .biu_pad_crvalid                       (ibiu1_pad_crvalid                      ),
  .biu_pad_csr_sel                       (ibiu1_pad_csr_sel                      ),
  .biu_pad_csr_wdata                     (ibiu1_pad_csr_wdata                    ),
  .biu_pad_jdb_pm                        (ibiu1_pad_jdb_pm                       ),
  .biu_pad_lpmd_b                        (ibiu1_pad_lpmd_b                       ),
  .biu_pad_rack                          (ibiu1_pad_rack                         ),
  .biu_pad_rready                        (ibiu1_pad_rready                       ),
  .biu_pad_wdata                         (ibiu1_pad_wdata                        ),
  .biu_pad_werr                          (ibiu1_pad_werr                         ),
  .biu_pad_wlast                         (ibiu1_pad_wlast                        ),
  .biu_pad_wns                           (ibiu1_pad_wns                          ),
  .biu_pad_wstrb                         (ibiu1_pad_wstrb                        ),
  .biu_pad_wvalid                        (ibiu1_pad_wvalid                       ),
  .cp0_pad_mstatus                       (core1_pad_mstatus                      ),
  .ir_corex_wdata                        (ir_corex_wdata                         ),
  .pad_biu_acaddr                        (pad_ibiu1_acaddr                       ),
  .pad_biu_acprot                        (pad_ibiu1_acprot                       ),
  .pad_biu_acsnoop                       (pad_ibiu1_acsnoop                      ),
  .pad_biu_acvalid                       (pad_ibiu1_acvalid                      ),
  .pad_biu_arready                       (pad_ibiu1_arready                      ),
  .pad_biu_awready                       (pad_ibiu1_awready                      ),
  .pad_biu_bid                           (pad_ibiu1_bid                          ),
  .pad_biu_bresp                         (pad_ibiu1_bresp                        ),
  .pad_biu_bvalid                        (pad_ibiu1_bvalid                       ),
  .pad_biu_cdready                       (pad_ibiu1_cdready                      ),
  .pad_biu_crready                       (pad_ibiu1_crready                      ),
  .pad_biu_csr_cmplt                     (pad_ibiu1_csr_cmplt                    ),
  .pad_biu_csr_rdata                     (pad_ibiu1_csr_rdata                    ),
  .pad_biu_dbgrq_b                       (pad_ibiu1_dbgrq_b                      ),
  .pad_biu_hpcp_l2of_int                 (pad_ibiu1_hpcp_l2of_int                ),
  .ext_interrupt                         (sysio_piu1_ex_int                      ),
  .pad_biu_me_int                        (pad_ibiu1_me_int                       ),
  .pad_biu_ms_int                        (pad_ibiu1_ms_int                       ),
  .pad_biu_mt_int                        (pad_ibiu1_mt_int                       ),
  .pad_biu_rdata                         (pad_ibiu1_rdata                        ),
  .pad_biu_rid                           (pad_ibiu1_rid                          ),
  .pad_biu_rlast                         (pad_ibiu1_rlast                        ),
  .pad_biu_rresp                         (pad_ibiu1_rresp                        ),
  .pad_biu_rvalid                        (pad_ibiu1_rvalid                       ),
  .pad_biu_se_int                        (pad_ibiu1_se_int                       ),
  .pad_biu_ss_int                        (pad_ibiu1_ss_int                       ),
  .pad_biu_st_int                        (pad_ibiu1_st_int                       ),
  .pad_biu_wns_awready                   (pad_ibiu1_wns_awready                  ),
  .pad_biu_wns_wready                    (pad_ibiu1_wns_wready                   ),
  .pad_biu_wready                        (pad_ibiu1_wready                       ),
  .pad_biu_ws_awready                    (pad_ibiu1_ws_awready                   ),
  .pad_biu_ws_wready                     (pad_ibiu1_ws_wready                    ),
  .sysio_core_restart_entry              (sysio_core1_restart_entry              ),
  .sysio_core_restart_vld                (sysio_core1_restart_vld                ),
  .core_sysio_restart_grnt               (core1_sysio_restart_grnt               ),
  .sysio_core_gl_stable_timer            (sysio_core_gl_stable_timer             ),
  .core_sysio_wr_req                     (core1_sysio_wr_req                     ),
  .core_sysio_wr_sel                     (core1_sysio_wr_sel                     ),
  .core_sysio_wr_ipi_send_data           (core1_sysio_wr_ipi_send_data           ),
  .core_sysio_wr_mail_box_send_data      (core1_sysio_wr_mail_box_send_data      ),
  .core_sysio_mailbox0_data              (core1_sysio_mailbox0_data              ),
  .sysio_core_cp0_update_ipi_status_en   (sysio_core1_cp0_update_ipi_status_en   ),
  .sysio_core_cp0_update_ipi_status_src  (sysio_core1_cp0_update_ipi_status_src  ),
  .sysio_core_cp0_update_mailbox0_en     (sysio_core1_cp0_update_mailbox0_en     ),
  .sysio_core_cp0_update_mailbox1_en     (sysio_core1_cp0_update_mailbox1_en     ),
  .sysio_core_cp0_update_mailbox2_en     (sysio_core1_cp0_update_mailbox2_en     ),
  .sysio_core_cp0_update_mailbox3_en     (sysio_core1_cp0_update_mailbox3_en     ),
  .sysio_core_cp0_req_grnt               (sysio_core1_cp0_req_grnt               ),
  .sysio_core_cp0_update_bit_sel         (sysio_core1_cp0_update_bit_sel         ),
  .sysio_core_cp0_update_mailbox_src0    (sysio_core1_cp0_update_mailbox_src0    ),
  .sysio_core_cp0_update_mailbox_src1    (sysio_core1_cp0_update_mailbox_src1    ),
  .sysio_core_cp0_update_mailbox_src2    (sysio_core1_cp0_update_mailbox_src2    ),
  .sysio_core_cp0_update_mailbox_src3    (sysio_core1_cp0_update_mailbox_src3    ),
  .sysio_core_cp0_update_mailbox_mask0   (sysio_core1_cp0_update_mailbox_mask0   ),
  .sysio_core_cp0_update_mailbox_mask1   (sysio_core1_cp0_update_mailbox_mask1   ),
  .sysio_core_cp0_update_mailbox_mask2   (sysio_core1_cp0_update_mailbox_mask2   ),
  .sysio_core_cp0_update_mailbox_mask3   (sysio_core1_cp0_update_mailbox_mask3   ),
  .pad_core_hartid                       (pad_core1_hartid                       ),
  .pad_core_rst_b                        (core1_rst_b                            ),
  .pad_core_rvba                         (pad_core1_rvba                         ),
  .pad_cpu_rst_b                         (cpurst_b                               ),
  .pad_xx_apb_base                       (sysio_xx_apb_base                      ),
  .pad_xx_time                           (sysio_xx_time                          ),
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                     ),
  .pad_yy_mbist_mode                     (pad_yy_mbist_mode                      ),
  .pad_yy_scan_mode                      (pad_yy_scan_mode                       ),
  .pad_yy_scan_rst_b                     (pad_yy_scan_rst_b                      ),
  .pll_core_clk                          (forever_core1_clk                      ),
  .rtu_cpu_no_retire                     (core1_cpu_no_retire                    ),
  .rtu_pad_retire0                       (core1_pad_retire0                      ),
  .rtu_pad_retire0_pc                    (core1_pad_retire0_pc                   ),
  .rtu_pad_retire1                       (core1_pad_retire1                      ),
  .rtu_pad_retire1_pc                    (core1_pad_retire1_pc                   ),
  .rtu_pad_retire2                       (core1_pad_retire2                      ),
  .rtu_pad_retire2_pc                    (core1_pad_retire2_pc                   ),
  .sm_update_dr                          (sm_update_dr                           ),
  .sm_update_ir                          (sm_update_ir                           ),
  .x_dbg_ack_pc                          (core1_dbg_ack_pc                       ),
  .x_enter_dbg_req_i                     (core1_enter_dbg_req_i                  ),
  .x_enter_dbg_req_o                     (core1_enter_dbg_req_o                  ),
  .x_exit_dbg_req_i                      (core1_exit_dbg_req_i                   ),
  .x_exit_dbg_req_o                      (core1_exit_dbg_req_o                   ),
  .x_had_dbg_mask                        (core1_had_dbg_mask                     ),
  .x_regs_serial_data                    (core1_regs_serial_data                 )
);

`else 
  /// BIU -> Core 1 (IN)
  assign  ibiu1_pad_arbar      =  '0;
  assign  ibiu1_pad_arburst    =  '0;
  assign  ibiu1_pad_arcache    =  '0;
  assign  ibiu1_pad_ardomain   =  '0;
  assign  ibiu1_pad_arid       =  '0;
  assign  ibiu1_pad_arlen      =  '0;
  assign  ibiu1_pad_arlock     =  '0;
  assign  ibiu1_pad_arprot     =  '0;
  assign  ibiu1_pad_arsize     =  '0;
  assign  ibiu1_pad_arsnoop    =  '0;
  assign  ibiu1_pad_aruser     =  '0;
  assign  ibiu1_pad_arvalid    =  '0;
  assign  ibiu1_pad_awaddr     =  '0;
  assign  ibiu1_pad_awbar      =  '0;
  assign  ibiu1_pad_awburst    =  '0;
  assign  ibiu1_pad_awcache    =  '0;
  assign  ibiu1_pad_awdomain   =  '0;
  assign  ibiu1_pad_awid       =  '0;
  assign  ibiu1_pad_awlen      =  '0;
  assign  ibiu1_pad_awlock     =  '0;
  assign  ibiu1_pad_awprot     =  '0;
  assign  ibiu1_pad_awsize     =  '0;
  assign  ibiu1_pad_awsnoop    =  '0;
  assign  ibiu1_pad_awunique   =  '0;
  assign  ibiu1_pad_awuser     =  '0;
  assign  ibiu1_pad_awvalid    =  '0;
  assign  ibiu1_pad_back       =  '0;
  assign  ibiu1_pad_bready     =  '0;
  assign  ibiu1_pad_cddata     =  '0;
  assign  ibiu1_pad_cderr      =  '0;
  assign  ibiu1_pad_cdlast     =  '0;
  assign  ibiu1_pad_cdvalid    =  '0;
  assign  ibiu1_pad_cnt_en     =  '0;
  assign  ibiu1_pad_crresp     =  '0;
  assign  ibiu1_pad_crvalid    =  '0;
  assign  ibiu1_pad_csr_sel    =  '0;
  assign  ibiu1_pad_csr_wdata  =  '0;
  assign  ibiu1_pad_jdb_pm     =  '0;
  assign  ibiu1_pad_lpmd_b     =  '0;
  assign  ibiu1_pad_rack       =  '0;
  assign  ibiu1_pad_rready     =  '0;
  assign  ibiu1_pad_wdata      =  '0;
  assign  ibiu1_pad_werr       =  '0;
  assign  ibiu1_pad_wlast      =  '0;
  assign  ibiu1_pad_wns        =  '0;
  assign  ibiu1_pad_wstrb      =  '0;
  assign  ibiu1_pad_wvalid     =  '0;
`endif

// &Connect(.pad_cpu_rst_b      (cpurst_b)); @141
// &Connect(.pad_core_rst_b     (core1_rst_b)); @142
// &Connect(.pll_core_clk       (forever_core1_clk)); @143
// &Connect(.pad_core_hartid    (pad_core1_hartid)); @144
// &Connect(.pad_core_rvba      (pad_core1_rvba)); @145
// &Connect(.pad_xx_time        (sysio_xx_time)); @146
// &Connect(.pad_xx_apb_base    (sysio_xx_apb_base)); @147
// &Connect(.pad_core_async_mode(pad_core1_async_mode)); @149
// &Connect(.pad_core_sleep_in  (pad_core1_sleep_in)); @150
// &Connect(.core_pad_sleep_out (core1_pad_sleep_out)); @151
// &Connect(.mem_cfg_in         (pad_core1_mem_cfg_in)); @154

// &ConnRule(s/ciu_pbiu/pad_ibiu2/); @164
// &ConnRule(s/pbiu_ciu/ibiu2_pad/); @165
// &ConnRule(s/idu_/core2_/); @166
// &ConnRule(s/rtu_/core2_/); @167
// &ConnRule(s/cp0_/core2_/); @168
// &ConnRule(s/^ptim_/ptim2_/); @169
// &ConnRule(s/^hpcp_/hpcp2_/); @170
// &ConnRule(s/^x_/core2_/); @171
// &Instance("ct_top_uvc2", "x_ct_top_2"); @172
// &Connect(.ciu_pbiu_axid  (pad_ibiu2_ac_verf_bus)); @173
// &Connect(.core2_cpuclk  (forever_core2_clk)); @174
// &Connect(.pad_core2_rst_b  (core2_rst_b)); @175
// &ConnRule(s/biu_/ibiu2_/); @180
// &ConnRule(s/rtu_/core2_/); @181
// &ConnRule(s/idu_/core2_/); @182
// &ConnRule(s/cp0_/core2_/); @183
// &ConnRule(s/^x_/core2_/); @184
// &Instance("ct_top", "x_ct_top_2"); @185
// &Connect(.pad_cpu_rst_b      (cpurst_b)); @186
// &Connect(.pad_core_rst_b     (core2_rst_b)); @187
// &Connect(.pll_core_clk       (forever_core2_clk)); @188
// &Connect(.pad_core_hartid    (pad_core2_hartid)); @189
// &Connect(.pad_core_rvba      (pad_core2_rvba)); @190
// &Connect(.pad_xx_time        (sysio_xx_time)); @191
// &Connect(.pad_xx_apb_base    (sysio_xx_apb_base)); @192
// &Connect(.pad_core_async_mode(pad_core2_async_mode)); @194
// &Connect(.pad_core_sleep_in  (pad_core2_sleep_in)); @195
// &Connect(.core_pad_sleep_out (core2_pad_sleep_out)); @196
// &Connect(.mem_cfg_in         (pad_core2_mem_cfg_in)); @199


`ifdef TRIPLE_CORE 
ct_top core_top_2 (
  .biu_pad_acready                       (ibiu2_pad_acready                      ),
  .biu_pad_araddr                        (ibiu2_pad_araddr                       ),
  .biu_pad_arbar                         (ibiu2_pad_arbar                        ),
  .biu_pad_arburst                       (ibiu2_pad_arburst                      ),
  .biu_pad_arcache                       (ibiu2_pad_arcache                      ),
  .biu_pad_ardomain                      (ibiu2_pad_ardomain                     ),
  .biu_pad_arid                          (ibiu2_pad_arid                         ),
  .biu_pad_arlen                         (ibiu2_pad_arlen                        ),
  .biu_pad_arlock                        (ibiu2_pad_arlock                       ),
  .biu_pad_arprot                        (ibiu2_pad_arprot                       ),
  .biu_pad_arsize                        (ibiu2_pad_arsize                       ),
  .biu_pad_arsnoop                       (ibiu2_pad_arsnoop                      ),
  .biu_pad_aruser                        (ibiu2_pad_aruser                       ),
  .biu_pad_arvalid                       (ibiu2_pad_arvalid                      ),
  .biu_pad_awaddr                        (ibiu2_pad_awaddr                       ),
  .biu_pad_awbar                         (ibiu2_pad_awbar                        ),
  .biu_pad_awburst                       (ibiu2_pad_awburst                      ),
  .biu_pad_awcache                       (ibiu2_pad_awcache                      ),
  .biu_pad_awdomain                      (ibiu2_pad_awdomain                     ),
  .biu_pad_awid                          (ibiu2_pad_awid                         ),
  .biu_pad_awlen                         (ibiu2_pad_awlen                        ),
  .biu_pad_awlock                        (ibiu2_pad_awlock                       ),
  .biu_pad_awprot                        (ibiu2_pad_awprot                       ),
  .biu_pad_awsize                        (ibiu2_pad_awsize                       ),
  .biu_pad_awsnoop                       (ibiu2_pad_awsnoop                      ),
  .biu_pad_awunique                      (ibiu2_pad_awunique                     ),
  .biu_pad_awuser                        (ibiu2_pad_awuser                       ),
  .biu_pad_awvalid                       (ibiu2_pad_awvalid                      ),
  .biu_pad_back                          (ibiu2_pad_back                         ),
  .biu_pad_bready                        (ibiu2_pad_bready                       ),
  .biu_pad_cddata                        (ibiu2_pad_cddata                       ),
  .biu_pad_cderr                         (ibiu2_pad_cderr                        ),
  .biu_pad_cdlast                        (ibiu2_pad_cdlast                       ),
  .biu_pad_cdvalid                       (ibiu2_pad_cdvalid                      ),
  .biu_pad_cnt_en                        (ibiu2_pad_cnt_en                       ),
  .biu_pad_crresp                        (ibiu2_pad_crresp                       ),
  .biu_pad_crvalid                       (ibiu2_pad_crvalid                      ),
  .biu_pad_csr_sel                       (ibiu2_pad_csr_sel                      ),
  .biu_pad_csr_wdata                     (ibiu2_pad_csr_wdata                    ),
  .biu_pad_jdb_pm                        (ibiu2_pad_jdb_pm                       ),
  .biu_pad_lpmd_b                        (ibiu2_pad_lpmd_b                       ),
  .biu_pad_rack                          (ibiu2_pad_rack                         ),
  .biu_pad_rready                        (ibiu2_pad_rready                       ),
  .biu_pad_wdata                         (ibiu2_pad_wdata                        ),
  .biu_pad_werr                          (ibiu2_pad_werr                         ),
  .biu_pad_wlast                         (ibiu2_pad_wlast                        ),
  .biu_pad_wns                           (ibiu2_pad_wns                          ),
  .biu_pad_wstrb                         (ibiu2_pad_wstrb                        ),
  .biu_pad_wvalid                        (ibiu2_pad_wvalid                       ),
  .cp0_pad_mstatus                       (core2_pad_mstatus                      ),
  .ir_corex_wdata                        (ir_corex_wdata                         ),
  .pad_biu_acaddr                        (pad_ibiu2_acaddr                       ),
  .pad_biu_acprot                        (pad_ibiu2_acprot                       ),
  .pad_biu_acsnoop                       (pad_ibiu2_acsnoop                      ),
  .pad_biu_acvalid                       (pad_ibiu2_acvalid                      ),
  .pad_biu_arready                       (pad_ibiu2_arready                      ),
  .pad_biu_awready                       (pad_ibiu2_awready                      ),
  .pad_biu_bid                           (pad_ibiu2_bid                          ),
  .pad_biu_bresp                         (pad_ibiu2_bresp                        ),
  .pad_biu_bvalid                        (pad_ibiu2_bvalid                       ),
  .pad_biu_cdready                       (pad_ibiu2_cdready                      ),
  .pad_biu_crready                       (pad_ibiu2_crready                      ),
  .pad_biu_csr_cmplt                     (pad_ibiu2_csr_cmplt                    ),
  .pad_biu_csr_rdata                     (pad_ibiu2_csr_rdata                    ),
  .pad_biu_dbgrq_b                       (pad_ibiu2_dbgrq_b                      ),
  .pad_biu_hpcp_l2of_int                 (pad_ibiu2_hpcp_l2of_int                ),
  .ext_interrupt                         (sysio_piu2_ex_int                      ),
  .pad_biu_me_int                        (pad_ibiu2_me_int                       ),
  .pad_biu_ms_int                        (pad_ibiu2_ms_int                       ),
  .pad_biu_mt_int                        (pad_ibiu2_mt_int                       ),
  .pad_biu_rdata                         (pad_ibiu2_rdata                        ),
  .pad_biu_rid                           (pad_ibiu2_rid                          ),
  .pad_biu_rlast                         (pad_ibiu2_rlast                        ),
  .pad_biu_rresp                         (pad_ibiu2_rresp                        ),
  .pad_biu_rvalid                        (pad_ibiu2_rvalid                       ),
  .pad_biu_se_int                        (pad_ibiu2_se_int                       ),
  .pad_biu_ss_int                        (pad_ibiu2_ss_int                       ),
  .pad_biu_st_int                        (pad_ibiu2_st_int                       ),
  .pad_biu_wns_awready                   (pad_ibiu2_wns_awready                  ),
  .pad_biu_wns_wready                    (pad_ibiu2_wns_wready                   ),
  .pad_biu_wready                        (pad_ibiu2_wready                       ),
  .pad_biu_ws_awready                    (pad_ibiu2_ws_awready                   ),
  .pad_biu_ws_wready                     (pad_ibiu2_ws_wready                    ),
  .sysio_core_restart_entry              (sysio_core2_restart_entry              ),
  .sysio_core_restart_vld                (sysio_core2_restart_vld                ),
  .core_sysio_restart_grnt               (core2_sysio_restart_grnt               ),
  .sysio_core_gl_stable_timer            (sysio_core_gl_stable_timer             ),
  .core_sysio_wr_req                     (core2_sysio_wr_req                     ),
  .core_sysio_wr_sel                     (core2_sysio_wr_sel                     ),
  .core_sysio_wr_ipi_send_data           (core2_sysio_wr_ipi_send_data           ),
  .core_sysio_wr_mail_box_send_data      (core2_sysio_wr_mail_box_send_data      ),
  .core_sysio_mailbox0_data              (core2_sysio_mailbox0_data              ),
  .sysio_core_cp0_update_ipi_status_en   (sysio_core2_cp0_update_ipi_status_en   ),
  .sysio_core_cp0_update_ipi_status_src  (sysio_core2_cp0_update_ipi_status_src  ),
  .sysio_core_cp0_update_mailbox0_en     (sysio_core2_cp0_update_mailbox0_en     ),
  .sysio_core_cp0_update_mailbox1_en     (sysio_core2_cp0_update_mailbox1_en     ),
  .sysio_core_cp0_update_mailbox2_en     (sysio_core2_cp0_update_mailbox2_en     ),
  .sysio_core_cp0_update_mailbox3_en     (sysio_core2_cp0_update_mailbox3_en     ),
  .sysio_core_cp0_req_grnt               (sysio_core2_cp0_req_grnt               ),
  .sysio_core_cp0_update_bit_sel         (sysio_core2_cp0_update_bit_sel         ),
  .sysio_core_cp0_update_mailbox_src0    (sysio_core2_cp0_update_mailbox_src0    ),
  .sysio_core_cp0_update_mailbox_src1    (sysio_core2_cp0_update_mailbox_src1    ),
  .sysio_core_cp0_update_mailbox_src2    (sysio_core2_cp0_update_mailbox_src2    ),
  .sysio_core_cp0_update_mailbox_src3    (sysio_core2_cp0_update_mailbox_src3    ),
  .sysio_core_cp0_update_mailbox_mask0   (sysio_core2_cp0_update_mailbox_mask0   ),
  .sysio_core_cp0_update_mailbox_mask1   (sysio_core2_cp0_update_mailbox_mask1   ),
  .sysio_core_cp0_update_mailbox_mask2   (sysio_core2_cp0_update_mailbox_mask2   ),
  .sysio_core_cp0_update_mailbox_mask3   (sysio_core2_cp0_update_mailbox_mask3   ),
  .pad_core_hartid                       (pad_core2_hartid                       ),
  .pad_core_rst_b                        (core2_rst_b                            ),
  .pad_core_rvba                         (pad_core2_rvba                         ),
  .pad_cpu_rst_b                         (cpurst_b                               ),
  .pad_xx_apb_base                       (sysio_xx_apb_base                      ),
  .pad_xx_time                           (sysio_xx_time                          ),
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                     ),
  .pad_yy_mbist_mode                     (pad_yy_mbist_mode                      ),
  .pad_yy_scan_mode                      (pad_yy_scan_mode                       ),
  .pad_yy_scan_rst_b                     (pad_yy_scan_rst_b                      ),
  .pll_core_clk                          (forever_core2_clk                      ),
  .rtu_cpu_no_retire                     (core2_cpu_no_retire                    ),
  .rtu_pad_retire0                       (core2_pad_retire0                      ),
  .rtu_pad_retire0_pc                    (core2_pad_retire0_pc                   ),
  .rtu_pad_retire1                       (core2_pad_retire1                      ),
  .rtu_pad_retire1_pc                    (core2_pad_retire1_pc                   ),
  .rtu_pad_retire2                       (core2_pad_retire2                      ),
  .rtu_pad_retire2_pc                    (core2_pad_retire2_pc                   ),
  .sm_update_dr                          (sm_update_dr                           ),
  .sm_update_ir                          (sm_update_ir                           ),
  .x_dbg_ack_pc                          (core2_dbg_ack_pc                       ),
  .x_enter_dbg_req_i                     (core2_enter_dbg_req_i                  ),
  .x_enter_dbg_req_o                     (core2_enter_dbg_req_o                  ),
  .x_exit_dbg_req_i                      (core2_exit_dbg_req_i                   ),
  .x_exit_dbg_req_o                      (core2_exit_dbg_req_o                   ),
  .x_had_dbg_mask                        (core2_had_dbg_mask                     ),
  .x_regs_serial_data                    (core2_regs_serial_data                 )
);

`else 
  assign  ibiu2_pad_arbar      =  '0;
  assign  ibiu2_pad_arburst    =  '0;
  assign  ibiu2_pad_arcache    =  '0;
  assign  ibiu2_pad_ardomain   =  '0;
  assign  ibiu2_pad_arid       =  '0;
  assign  ibiu2_pad_arlen      =  '0;
  assign  ibiu2_pad_arlock     =  '0;
  assign  ibiu2_pad_arprot     =  '0;
  assign  ibiu2_pad_arsize     =  '0;
  assign  ibiu2_pad_arsnoop    =  '0;
  assign  ibiu2_pad_aruser     =  '0;
  assign  ibiu2_pad_arvalid    =  '0;
  assign  ibiu2_pad_awaddr     =  '0;
  assign  ibiu2_pad_awbar      =  '0;
  assign  ibiu2_pad_awburst    =  '0;
  assign  ibiu2_pad_awcache    =  '0;
  assign  ibiu2_pad_awdomain   =  '0;
  assign  ibiu2_pad_awid       =  '0;
  assign  ibiu2_pad_awlen      =  '0;
  assign  ibiu2_pad_awlock     =  '0;
  assign  ibiu2_pad_awprot     =  '0;
  assign  ibiu2_pad_awsize     =  '0;
  assign  ibiu2_pad_awsnoop    =  '0;
  assign  ibiu2_pad_awunique   =  '0;
  assign  ibiu2_pad_awuser     =  '0;
  assign  ibiu2_pad_awvalid    =  '0;
  assign  ibiu2_pad_back       =  '0;
  assign  ibiu2_pad_bready     =  '0;
  assign  ibiu2_pad_cddata     =  '0;
  assign  ibiu2_pad_cderr      =  '0;
  assign  ibiu2_pad_cdlast     =  '0;
  assign  ibiu2_pad_cdvalid    =  '0;
  assign  ibiu2_pad_cnt_en     =  '0;
  assign  ibiu2_pad_crresp     =  '0;
  assign  ibiu2_pad_crvalid    =  '0;
  assign  ibiu2_pad_csr_sel    =  '0;
  assign  ibiu2_pad_csr_wdata  =  '0;
  assign  ibiu2_pad_jdb_pm     =  '0;
  assign  ibiu2_pad_lpmd_b     =  '0;
  assign  ibiu2_pad_rack       =  '0;
  assign  ibiu2_pad_rready     =  '0;
  assign  ibiu2_pad_wdata      =  '0;
  assign  ibiu2_pad_werr       =  '0;
  assign  ibiu2_pad_wlast      =  '0;
  assign  ibiu2_pad_wns        =  '0;
  assign  ibiu2_pad_wstrb      =  '0;
  assign  ibiu2_pad_wvalid     =  '0;
  assign  core2_sysio_wr_req                        = 1'b0;
  assign  core2_sysio_wr_sel[3 :0]                  = 4'b0;
  assign  core2_sysio_wr_ipi_send_data[31:0]        = 32'b0;
  assign  core2_sysio_wr_mail_box_send_data[63:0]   = 64'b0;
  assign  core2_sysio_mailbox0_data[63:0]           = 64'b0;
  assign  core2_sysio_restart_grnt                  = 1'b0;
`endif


// &ConnRule(s/ciu_pbiu/pad_ibiu3/); @209
// &ConnRule(s/pbiu_ciu/ibiu3_pad/); @210
// &ConnRule(s/idu_/core3_/); @211
// &ConnRule(s/rtu_/core3_/); @212
// &ConnRule(s/cp0_/core3_/); @213
// &ConnRule(s/^ptim_/ptim3_/); @214
// &ConnRule(s/^hpcp_/hpcp3_/); @215
// &ConnRule(s/^x_/core3_/); @216
// &Instance("ct_top_uvc3", "x_ct_top_3"); @217
// &Connect(.ciu_pbiu_axid  (pad_ibiu3_ac_verf_bus)); @218
// &Connect(.core3_cpuclk  (forever_core3_clk)); @219
// &Connect(.pad_core3_rst_b  (core3_rst_b)); @220
// &ConnRule(s/biu_/ibiu3_/); @224
// &ConnRule(s/rtu_/core3_/); @225
// &ConnRule(s/idu_/core3_/); @226
// &ConnRule(s/cp0_/core3_/); @227
// &ConnRule(s/^x_/core3_/); @228
// &Instance("ct_top", "x_ct_top_3"); @229
// &Connect(.pad_cpu_rst_b      (cpurst_b)); @230
// &Connect(.pad_core_rst_b     (core3_rst_b)); @231
// &Connect(.pll_core_clk       (forever_core3_clk)); @232
// &Connect(.pad_core_hartid    (pad_core3_hartid)); @233
// &Connect(.pad_core_rvba      (pad_core3_rvba)); @234
// &Connect(.pad_xx_time        (sysio_xx_time)); @235
// &Connect(.pad_xx_apb_base    (sysio_xx_apb_base)); @236
// &Connect(.pad_core_async_mode(pad_core3_async_mode)); @238
// &Connect(.pad_core_sleep_in  (pad_core3_sleep_in)); @239
// &Connect(.core_pad_sleep_out (core3_pad_sleep_out)); @240
// &Connect(.mem_cfg_in         (pad_core3_mem_cfg_in)); @243

`ifdef QUAD_CORE 
ct_top core_top_3 (
  .biu_pad_acready                       (ibiu3_pad_acready                      ),
  .biu_pad_araddr                        (ibiu3_pad_araddr                       ),
  .biu_pad_arbar                         (ibiu3_pad_arbar                        ),
  .biu_pad_arburst                       (ibiu3_pad_arburst                      ),
  .biu_pad_arcache                       (ibiu3_pad_arcache                      ),
  .biu_pad_ardomain                      (ibiu3_pad_ardomain                     ),
  .biu_pad_arid                          (ibiu3_pad_arid                         ),
  .biu_pad_arlen                         (ibiu3_pad_arlen                        ),
  .biu_pad_arlock                        (ibiu3_pad_arlock                       ),
  .biu_pad_arprot                        (ibiu3_pad_arprot                       ),
  .biu_pad_arsize                        (ibiu3_pad_arsize                       ),
  .biu_pad_arsnoop                       (ibiu3_pad_arsnoop                      ),
  .biu_pad_aruser                        (ibiu3_pad_aruser                       ),
  .biu_pad_arvalid                       (ibiu3_pad_arvalid                      ),
  .biu_pad_awaddr                        (ibiu3_pad_awaddr                       ),
  .biu_pad_awbar                         (ibiu3_pad_awbar                        ),
  .biu_pad_awburst                       (ibiu3_pad_awburst                      ),
  .biu_pad_awcache                       (ibiu3_pad_awcache                      ),
  .biu_pad_awdomain                      (ibiu3_pad_awdomain                     ),
  .biu_pad_awid                          (ibiu3_pad_awid                         ),
  .biu_pad_awlen                         (ibiu3_pad_awlen                        ),
  .biu_pad_awlock                        (ibiu3_pad_awlock                       ),
  .biu_pad_awprot                        (ibiu3_pad_awprot                       ),
  .biu_pad_awsize                        (ibiu3_pad_awsize                       ),
  .biu_pad_awsnoop                       (ibiu3_pad_awsnoop                      ),
  .biu_pad_awunique                      (ibiu3_pad_awunique                     ),
  .biu_pad_awuser                        (ibiu3_pad_awuser                       ),
  .biu_pad_awvalid                       (ibiu3_pad_awvalid                      ),
  .biu_pad_back                          (ibiu3_pad_back                         ),
  .biu_pad_bready                        (ibiu3_pad_bready                       ),
  .biu_pad_cddata                        (ibiu3_pad_cddata                       ),
  .biu_pad_cderr                         (ibiu3_pad_cderr                        ),
  .biu_pad_cdlast                        (ibiu3_pad_cdlast                       ),
  .biu_pad_cdvalid                       (ibiu3_pad_cdvalid                      ),
  .biu_pad_cnt_en                        (ibiu3_pad_cnt_en                       ),
  .biu_pad_crresp                        (ibiu3_pad_crresp                       ),
  .biu_pad_crvalid                       (ibiu3_pad_crvalid                      ),
  .biu_pad_csr_sel                       (ibiu3_pad_csr_sel                      ),
  .biu_pad_csr_wdata                     (ibiu3_pad_csr_wdata                    ),
  .biu_pad_jdb_pm                        (ibiu3_pad_jdb_pm                       ),
  .biu_pad_lpmd_b                        (ibiu3_pad_lpmd_b                       ),
  .biu_pad_rack                          (ibiu3_pad_rack                         ),
  .biu_pad_rready                        (ibiu3_pad_rready                       ),
  .biu_pad_wdata                         (ibiu3_pad_wdata                        ),
  .biu_pad_werr                          (ibiu3_pad_werr                         ),
  .biu_pad_wlast                         (ibiu3_pad_wlast                        ),
  .biu_pad_wns                           (ibiu3_pad_wns                          ),
  .biu_pad_wstrb                         (ibiu3_pad_wstrb                        ),
  .biu_pad_wvalid                        (ibiu3_pad_wvalid                       ),
  .cp0_pad_mstatus                       (core3_pad_mstatus                      ),
  .ir_corex_wdata                        (ir_corex_wdata                         ),
  .pad_biu_acaddr                        (pad_ibiu3_acaddr                       ),
  .pad_biu_acprot                        (pad_ibiu3_acprot                       ),
  .pad_biu_acsnoop                       (pad_ibiu3_acsnoop                      ),
  .pad_biu_acvalid                       (pad_ibiu3_acvalid                      ),
  .pad_biu_arready                       (pad_ibiu3_arready                      ),
  .pad_biu_awready                       (pad_ibiu3_awready                      ),
  .pad_biu_bid                           (pad_ibiu3_bid                          ),
  .pad_biu_bresp                         (pad_ibiu3_bresp                        ),
  .pad_biu_bvalid                        (pad_ibiu3_bvalid                       ),
  .pad_biu_cdready                       (pad_ibiu3_cdready                      ),
  .pad_biu_crready                       (pad_ibiu3_crready                      ),
  .pad_biu_csr_cmplt                     (pad_ibiu3_csr_cmplt                    ),
  .pad_biu_csr_rdata                     (pad_ibiu3_csr_rdata                    ),
  .pad_biu_dbgrq_b                       (pad_ibiu3_dbgrq_b                      ),
  .pad_biu_hpcp_l2of_int                 (pad_ibiu3_hpcp_l2of_int                ),
  .ext_interrupt                         (sysio_piu3_ex_int                      ),
  .pad_biu_me_int                        (pad_ibiu3_me_int                       ),
  .pad_biu_ms_int                        (pad_ibiu3_ms_int                       ),
  .pad_biu_mt_int                        (pad_ibiu3_mt_int                       ),
  .pad_biu_rdata                         (pad_ibiu3_rdata                        ),
  .pad_biu_rid                           (pad_ibiu3_rid                          ),
  .pad_biu_rlast                         (pad_ibiu3_rlast                        ),
  .pad_biu_rresp                         (pad_ibiu3_rresp                        ),
  .pad_biu_rvalid                        (pad_ibiu3_rvalid                       ),
  .pad_biu_se_int                        (pad_ibiu3_se_int                       ),
  .pad_biu_ss_int                        (pad_ibiu3_ss_int                       ),
  .pad_biu_st_int                        (pad_ibiu3_st_int                       ),
  .pad_biu_wns_awready                   (pad_ibiu3_wns_awready                  ),
  .pad_biu_wns_wready                    (pad_ibiu3_wns_wready                   ),
  .pad_biu_wready                        (pad_ibiu3_wready                       ),
  .pad_biu_ws_awready                    (pad_ibiu3_ws_awready                   ),
  .pad_biu_ws_wready                     (pad_ibiu3_ws_wready                    ),
  .sysio_core_restart_entry              (sysio_core3_restart_entry              ),
  .sysio_core_restart_vld                (sysio_core3_restart_vld                ),
  .core_sysio_restart_grnt               (core3_sysio_restart_grnt               ),
  .sysio_core_gl_stable_timer            (sysio_core_gl_stable_timer             ),
  .core_sysio_wr_req                     (core3_sysio_wr_req                     ),
  .core_sysio_wr_sel                     (core3_sysio_wr_sel                     ),
  .core_sysio_wr_ipi_send_data           (core3_sysio_wr_ipi_send_data           ),
  .core_sysio_wr_mail_box_send_data      (core3_sysio_wr_mail_box_send_data      ),
  .core_sysio_mailbox0_data              (core3_sysio_mailbox0_data              ),
  .sysio_core_cp0_update_ipi_status_en   (sysio_core3_cp0_update_ipi_status_en   ),
  .sysio_core_cp0_update_ipi_status_src  (sysio_core3_cp0_update_ipi_status_src  ),
  .sysio_core_cp0_update_mailbox0_en     (sysio_core3_cp0_update_mailbox0_en     ),
  .sysio_core_cp0_update_mailbox1_en     (sysio_core3_cp0_update_mailbox1_en     ),
  .sysio_core_cp0_update_mailbox2_en     (sysio_core3_cp0_update_mailbox2_en     ),
  .sysio_core_cp0_update_mailbox3_en     (sysio_core3_cp0_update_mailbox3_en     ),
  .sysio_core_cp0_req_grnt               (sysio_core3_cp0_req_grnt               ),
  .sysio_core_cp0_update_bit_sel         (sysio_core3_cp0_update_bit_sel         ),
  .sysio_core_cp0_update_mailbox_src0    (sysio_core3_cp0_update_mailbox_src0    ),
  .sysio_core_cp0_update_mailbox_src1    (sysio_core3_cp0_update_mailbox_src1    ),
  .sysio_core_cp0_update_mailbox_src2    (sysio_core3_cp0_update_mailbox_src2    ),
  .sysio_core_cp0_update_mailbox_src3    (sysio_core3_cp0_update_mailbox_src3    ),
  .sysio_core_cp0_update_mailbox_mask0   (sysio_core3_cp0_update_mailbox_mask0   ),
  .sysio_core_cp0_update_mailbox_mask1   (sysio_core3_cp0_update_mailbox_mask1   ),
  .sysio_core_cp0_update_mailbox_mask2   (sysio_core3_cp0_update_mailbox_mask2   ),
  .sysio_core_cp0_update_mailbox_mask3   (sysio_core3_cp0_update_mailbox_mask3   ),
  .pad_core_hartid                       (pad_core3_hartid                       ),
  .pad_core_rst_b                        (core3_rst_b                            ),
  .pad_core_rvba                         (pad_core3_rvba                         ),
  .pad_cpu_rst_b                         (cpurst_b                               ),
  .pad_xx_apb_base                       (sysio_xx_apb_base                      ),
  .pad_xx_time                           (sysio_xx_time                          ),
  .pad_yy_icg_scan_en                    (pad_yy_icg_scan_en                     ),
  .pad_yy_mbist_mode                     (pad_yy_mbist_mode                      ),
  .pad_yy_scan_mode                      (pad_yy_scan_mode                       ),
  .pad_yy_scan_rst_b                     (pad_yy_scan_rst_b                      ),
  .pll_core_clk                          (forever_core3_clk                      ),
  .rtu_cpu_no_retire                     (core3_cpu_no_retire                    ),
  .rtu_pad_retire0                       (core3_pad_retire0                      ),
  .rtu_pad_retire0_pc                    (core3_pad_retire0_pc                   ),
  .rtu_pad_retire1                       (core3_pad_retire1                      ),
  .rtu_pad_retire1_pc                    (core3_pad_retire1_pc                   ),
  .rtu_pad_retire2                       (core3_pad_retire2                      ),
  .rtu_pad_retire2_pc                    (core3_pad_retire2_pc                   ),
  .sm_update_dr                          (sm_update_dr                           ),
  .sm_update_ir                          (sm_update_ir                           ),
  .x_dbg_ack_pc                          (core3_dbg_ack_pc                       ),
  .x_enter_dbg_req_i                     (core3_enter_dbg_req_i                  ),
  .x_enter_dbg_req_o                     (core3_enter_dbg_req_o                  ),
  .x_exit_dbg_req_i                      (core3_exit_dbg_req_i                   ),
  .x_exit_dbg_req_o                      (core3_exit_dbg_req_o                   ),
  .x_had_dbg_mask                        (core3_had_dbg_mask                     ),
  .x_regs_serial_data                    (core3_regs_serial_data                 )
);

`else 
  assign  ibiu3_pad_arbar      =  '0;
  assign  ibiu3_pad_arburst    =  '0;
  assign  ibiu3_pad_arcache    =  '0;
  assign  ibiu3_pad_ardomain   =  '0;
  assign  ibiu3_pad_arid       =  '0;
  assign  ibiu3_pad_arlen      =  '0;
  assign  ibiu3_pad_arlock     =  '0;
  assign  ibiu3_pad_arprot     =  '0;
  assign  ibiu3_pad_arsize     =  '0;
  assign  ibiu3_pad_arsnoop    =  '0;
  assign  ibiu3_pad_aruser     =  '0;
  assign  ibiu3_pad_arvalid    =  '0;
  assign  ibiu3_pad_awaddr     =  '0;
  assign  ibiu3_pad_awbar      =  '0;
  assign  ibiu3_pad_awburst    =  '0;
  assign  ibiu3_pad_awcache    =  '0;
  assign  ibiu3_pad_awdomain   =  '0;
  assign  ibiu3_pad_awid       =  '0;
  assign  ibiu3_pad_awlen      =  '0;
  assign  ibiu3_pad_awlock     =  '0;
  assign  ibiu3_pad_awprot     =  '0;
  assign  ibiu3_pad_awsize     =  '0;
  assign  ibiu3_pad_awsnoop    =  '0;
  assign  ibiu3_pad_awunique   =  '0;
  assign  ibiu3_pad_awuser     =  '0;
  assign  ibiu3_pad_awvalid    =  '0;
  assign  ibiu3_pad_back       =  '0;
  assign  ibiu3_pad_bready     =  '0;
  assign  ibiu3_pad_cddata     =  '0;
  assign  ibiu3_pad_cderr      =  '0;
  assign  ibiu3_pad_cdlast     =  '0;
  assign  ibiu3_pad_cdvalid    =  '0;
  assign  ibiu3_pad_cnt_en     =  '0;
  assign  ibiu3_pad_crresp     =  '0;
  assign  ibiu3_pad_crvalid    =  '0;
  assign  ibiu3_pad_csr_sel    =  '0;
  assign  ibiu3_pad_csr_wdata  =  '0;
  assign  ibiu3_pad_jdb_pm     =  '0;
  assign  ibiu3_pad_lpmd_b     =  '0;
  assign  ibiu3_pad_rack       =  '0;
  assign  ibiu3_pad_rready     =  '0;
  assign  ibiu3_pad_wdata      =  '0;
  assign  ibiu3_pad_werr       =  '0;
  assign  ibiu3_pad_wlast      =  '0;
  assign  ibiu3_pad_wns        =  '0;
  assign  ibiu3_pad_wstrb      =  '0;
  assign  ibiu3_pad_wvalid     =  '0;
  assign  core3_sysio_wr_req                        = 1'b0;
  assign  core3_sysio_wr_sel[3 :0]                  = 4'b0;
  assign  core3_sysio_wr_ipi_send_data[31:0]        = 32'b0;
  assign  core3_sysio_wr_mail_box_send_data[63:0]   = 64'b0;
  assign  core3_sysio_mailbox0_data[63:0]           = 64'b0;
  assign  core3_sysio_restart_grnt                  = 1'b0;
`endif


//==========================================================
//  Instance ct_ciu_top sub module 
//==========================================================
// &ConnRule(s/ibiu/ibiu0/); @253
// &Instance("ct_ciu_bus_io", "x_ct_ciu_bus_io_0"); @254
// &Connect(.forever_cpuclk   (forever_cpuclk)); @255
// &Connect(.cpurst_b         (cpurst_b      )); @256
// &Connect(.core_rst_b       (core0_fifo_rst_b   )); @257
// &Connect(.pad_core_async_mode(pad_core0_async_mode)); @258
// &ConnRule(s/ibiu/ibiu1/); @297
// &Instance("ct_ciu_bus_io", "x_ct_ciu_bus_io_1"); @298
// &Connect(.forever_cpuclk   (forever_cpuclk)); @299
// &Connect(.cpurst_b         (cpurst_b      )); @300
// &Connect(.core_rst_b       (core1_fifo_rst_b   )); @301
// &Connect(.pad_core_async_mode(pad_core1_async_mode)); @302
// &ConnRule(s/ibiu/ibiu2/); @342
// &Instance("ct_ciu_bus_io", "x_ct_ciu_bus_io_2"); @343
// &Connect(.forever_cpuclk   (forever_cpuclk)); @344
// &Connect(.cpurst_b         (cpurst_b      )); @345
// &Connect(.core_rst_b       (core2_fifo_rst_b   )); @346
// &Connect(.pad_core_async_mode(pad_core2_async_mode)); @347
// &ConnRule(s/ibiu/ibiu3/); @387
// &Instance("ct_ciu_bus_io", "x_ct_ciu_bus_io_3"); @388
// &Connect(.forever_cpuclk   (forever_cpuclk)); @389
// &Connect(.cpurst_b         (cpurst_b      )); @390
// &Connect(.core_rst_b       (core3_fifo_rst_b   )); @391
// &Connect(.pad_core_async_mode(pad_core3_async_mode)); @392

//==========================================================
//  Instance ct_ciu_top sub module 
//==========================================================
// &Instance("ct_ciu_top"); @434
ct_ciu_top  x_ct_ciu_top (
  .apb_clk_en                     (apb_clk_en                    ),
  .apbif_had_pctrace_inv          (apbif_had_pctrace_inv         ),
  .biu_pad_araddr                 (biu_pad_araddr                ),
  .biu_pad_arburst                (biu_pad_arburst               ),
  .biu_pad_arcache                (biu_pad_arcache               ),
  .biu_pad_arid                   (biu_pad_arid                  ),
  .biu_pad_arlen                  (biu_pad_arlen                 ),
  .biu_pad_arlock                 (biu_pad_arlock                ),
  .biu_pad_arprot                 (biu_pad_arprot                ),
  .biu_pad_arsize                 (biu_pad_arsize                ),
  .biu_pad_arvalid                (biu_pad_arvalid               ),
  .biu_pad_awaddr                 (biu_pad_awaddr                ),
  .biu_pad_awburst                (biu_pad_awburst               ),
  .biu_pad_awcache                (biu_pad_awcache               ),
  .biu_pad_awid                   (biu_pad_awid                  ),
  .biu_pad_awlen                  (biu_pad_awlen                 ),
  .biu_pad_awlock                 (biu_pad_awlock                ),
  .biu_pad_awprot                 (biu_pad_awprot                ),
  .biu_pad_awsize                 (biu_pad_awsize                ),
  .biu_pad_awvalid                (biu_pad_awvalid               ),
  .biu_pad_bready                 (biu_pad_bready                ),
  .biu_pad_cactive                (biu_pad_cactive               ),
  .biu_pad_csysack                (biu_pad_csysack               ),
  .biu_pad_rready                 (biu_pad_rready                ),
  .biu_pad_wdata                  (biu_pad_wdata                 ),
  .biu_pad_wlast                  (biu_pad_wlast                 ),
  .biu_pad_wstrb                  (biu_pad_wstrb                 ),
  .biu_pad_wvalid                 (biu_pad_wvalid                ),
  .ciu_clint_icg_en               (ciu_clint_icg_en              ),
  .ciu_had_dbg_info               (ciu_had_dbg_info              ),
  .ciu_l2c_addr_bank_0            (ciu_l2c_addr_bank_0           ),
  .ciu_l2c_addr_bank_1            (ciu_l2c_addr_bank_1           ),
  .ciu_l2c_addr_vld_bank_0        (ciu_l2c_addr_vld_bank_0       ),
  .ciu_l2c_addr_vld_bank_1        (ciu_l2c_addr_vld_bank_1       ),
  .ciu_l2c_clr_cp_bank_0          (ciu_l2c_clr_cp_bank_0         ),
  .ciu_l2c_clr_cp_bank_1          (ciu_l2c_clr_cp_bank_1         ),
  .ciu_l2c_ctcq_req_bank_0        (ciu_l2c_ctcq_req_bank_0       ),
  .ciu_l2c_ctcq_req_bank_1        (ciu_l2c_ctcq_req_bank_1       ),
  .ciu_l2c_data_latency           (ciu_l2c_data_latency          ),
  .ciu_l2c_data_setup             (ciu_l2c_data_setup            ),
  .ciu_l2c_data_vld_bank_0        (ciu_l2c_data_vld_bank_0       ),
  .ciu_l2c_data_vld_bank_1        (ciu_l2c_data_vld_bank_1       ),
  .ciu_l2c_dca_addr_bank_0        (ciu_l2c_dca_addr_bank_0       ),
  .ciu_l2c_dca_addr_bank_1        (ciu_l2c_dca_addr_bank_1       ),
  .ciu_l2c_dca_req_bank_0         (ciu_l2c_dca_req_bank_0        ),
  .ciu_l2c_dca_req_bank_1         (ciu_l2c_dca_req_bank_1        ),
  .ciu_l2c_hpcp_bus_bank_0        (ciu_l2c_hpcp_bus_bank_0       ),
  .ciu_l2c_hpcp_bus_bank_1        (ciu_l2c_hpcp_bus_bank_1       ),
  .ciu_l2c_icc_mid_bank_0         (ciu_l2c_icc_mid_bank_0        ),
  .ciu_l2c_icc_mid_bank_1         (ciu_l2c_icc_mid_bank_1        ),
  .ciu_l2c_icc_type_bank_0        (ciu_l2c_icc_type_bank_0       ),
  .ciu_l2c_icc_type_bank_1        (ciu_l2c_icc_type_bank_1       ),
  .ciu_l2c_iprf                   (ciu_l2c_iprf                  ),
  .ciu_l2c_mid_bank_0             (ciu_l2c_mid_bank_0            ),
  .ciu_l2c_mid_bank_1             (ciu_l2c_mid_bank_1            ),
  .ciu_l2c_prf_ready              (ciu_l2c_prf_ready             ),
  .ciu_l2c_rdl_ready_bank_0       (ciu_l2c_rdl_ready_bank_0      ),
  .ciu_l2c_rdl_ready_bank_1       (ciu_l2c_rdl_ready_bank_1      ),
  .ciu_l2c_rst_req                (ciu_l2c_rst_req               ),
  .ciu_l2c_set_cp_bank_0          (ciu_l2c_set_cp_bank_0         ),
  .ciu_l2c_set_cp_bank_1          (ciu_l2c_set_cp_bank_1         ),
  .ciu_l2c_sid_bank_0             (ciu_l2c_sid_bank_0            ),
  .ciu_l2c_sid_bank_1             (ciu_l2c_sid_bank_1            ),
  .ciu_l2c_snpl2_ready_bank_0     (ciu_l2c_snpl2_ready_bank_0    ),
  .ciu_l2c_snpl2_ready_bank_1     (ciu_l2c_snpl2_ready_bank_1    ),
  .ciu_l2c_src_bank_0             (ciu_l2c_src_bank_0            ),
  .ciu_l2c_src_bank_1             (ciu_l2c_src_bank_1            ),
  .ciu_l2c_tag_latency            (ciu_l2c_tag_latency           ),
  .ciu_l2c_tag_setup              (ciu_l2c_tag_setup             ),
  .ciu_l2c_tprf                   (ciu_l2c_tprf                  ),
  .ciu_l2c_type_bank_0            (ciu_l2c_type_bank_0           ),
  .ciu_l2c_type_bank_1            (ciu_l2c_type_bank_1           ),
  .ciu_l2c_wdata_bank_0           (ciu_l2c_wdata_bank_0          ),
  .ciu_l2c_wdata_bank_1           (ciu_l2c_wdata_bank_1          ),
  .ciu_plic_icg_en                (ciu_plic_icg_en               ),
  .ciu_sysio_icg_en               (ciu_sysio_icg_en              ),
  .ciu_top_clk                    (ciu_top_clk                   ),
  .ciu_xx_no_op                   (ciu_xx_no_op                  ),
  .clk_en                         (axim_clk_en_f                 ),
  .core0_fifo_rst_b               (core0_fifo_rst_b              ),
  .core1_fifo_rst_b               (core1_fifo_rst_b              ),
  .core2_fifo_rst_b               (core2_fifo_rst_b              ),
  .core3_fifo_rst_b               (core3_fifo_rst_b              ),
  .cpurst_b                       (cpurst_b                      ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .ibiu0_pad_acready              (ibiu0_pad_acready             ),
  .ibiu0_pad_araddr               (ibiu0_pad_araddr              ),
  .ibiu0_pad_arbar                (ibiu0_pad_arbar               ),
  .ibiu0_pad_arburst              (ibiu0_pad_arburst             ),
  .ibiu0_pad_arcache              (ibiu0_pad_arcache             ),
  .ibiu0_pad_ardomain             (ibiu0_pad_ardomain            ),
  .ibiu0_pad_arid                 (ibiu0_pad_arid                ),
  .ibiu0_pad_arlen                (ibiu0_pad_arlen               ),
  .ibiu0_pad_arlock               (ibiu0_pad_arlock              ),
  .ibiu0_pad_arprot               (ibiu0_pad_arprot              ),
  .ibiu0_pad_arsize               (ibiu0_pad_arsize              ),
  .ibiu0_pad_arsnoop              (ibiu0_pad_arsnoop             ),
  .ibiu0_pad_aruser               (ibiu0_pad_aruser              ),
  .ibiu0_pad_arvalid              (ibiu0_pad_arvalid             ),
  .ibiu0_pad_awaddr               (ibiu0_pad_awaddr              ),
  .ibiu0_pad_awbar                (ibiu0_pad_awbar               ),
  .ibiu0_pad_awburst              (ibiu0_pad_awburst             ),
  .ibiu0_pad_awcache              (ibiu0_pad_awcache             ),
  .ibiu0_pad_awdomain             (ibiu0_pad_awdomain            ),
  .ibiu0_pad_awid                 (ibiu0_pad_awid                ),
  .ibiu0_pad_awlen                (ibiu0_pad_awlen               ),
  .ibiu0_pad_awlock               (ibiu0_pad_awlock              ),
  .ibiu0_pad_awprot               (ibiu0_pad_awprot              ),
  .ibiu0_pad_awsize               (ibiu0_pad_awsize              ),
  .ibiu0_pad_awsnoop              (ibiu0_pad_awsnoop             ),
  .ibiu0_pad_awunique             (ibiu0_pad_awunique            ),
  .ibiu0_pad_awuser               (ibiu0_pad_awuser              ),
  .ibiu0_pad_awvalid              (ibiu0_pad_awvalid             ),
  .ibiu0_pad_back                 (ibiu0_pad_back                ),
  .ibiu0_pad_bready               (ibiu0_pad_bready              ),
  .ibiu0_pad_cddata               (ibiu0_pad_cddata              ),
  .ibiu0_pad_cderr                (ibiu0_pad_cderr               ),
  .ibiu0_pad_cdlast               (ibiu0_pad_cdlast              ),
  .ibiu0_pad_cdvalid              (ibiu0_pad_cdvalid             ),
  .ibiu0_pad_cnt_en               (ibiu0_pad_cnt_en              ),
  .ibiu0_pad_crresp               (ibiu0_pad_crresp              ),
  .ibiu0_pad_crvalid              (ibiu0_pad_crvalid             ),
  .ibiu0_pad_csr_sel              (ibiu0_pad_csr_sel             ),
  .ibiu0_pad_csr_wdata            (ibiu0_pad_csr_wdata           ),
  .ibiu0_pad_jdb_pm               (ibiu0_pad_jdb_pm              ),
  .ibiu0_pad_lpmd_b               (ibiu0_pad_lpmd_b              ),
  .ibiu0_pad_rack                 (ibiu0_pad_rack                ),
  .ibiu0_pad_rready               (ibiu0_pad_rready              ),
  .ibiu0_pad_wdata                (ibiu0_pad_wdata               ),
  .ibiu0_pad_werr                 (ibiu0_pad_werr                ),
  .ibiu0_pad_wlast                (ibiu0_pad_wlast               ),
  .ibiu0_pad_wns                  (ibiu0_pad_wns                 ),
  .ibiu0_pad_wstrb                (ibiu0_pad_wstrb               ),
  .ibiu0_pad_wvalid               (ibiu0_pad_wvalid              ),
  .ibiu1_pad_acready              (ibiu1_pad_acready             ),
  .ibiu1_pad_araddr               (ibiu1_pad_araddr              ),
  .ibiu1_pad_arbar                (ibiu1_pad_arbar               ),
  .ibiu1_pad_arburst              (ibiu1_pad_arburst             ),
  .ibiu1_pad_arcache              (ibiu1_pad_arcache             ),
  .ibiu1_pad_ardomain             (ibiu1_pad_ardomain            ),
  .ibiu1_pad_arid                 (ibiu1_pad_arid                ),
  .ibiu1_pad_arlen                (ibiu1_pad_arlen               ),
  .ibiu1_pad_arlock               (ibiu1_pad_arlock              ),
  .ibiu1_pad_arprot               (ibiu1_pad_arprot              ),
  .ibiu1_pad_arsize               (ibiu1_pad_arsize              ),
  .ibiu1_pad_arsnoop              (ibiu1_pad_arsnoop             ),
  .ibiu1_pad_aruser               (ibiu1_pad_aruser              ),
  .ibiu1_pad_arvalid              (ibiu1_pad_arvalid             ),
  .ibiu1_pad_awaddr               (ibiu1_pad_awaddr              ),
  .ibiu1_pad_awbar                (ibiu1_pad_awbar               ),
  .ibiu1_pad_awburst              (ibiu1_pad_awburst             ),
  .ibiu1_pad_awcache              (ibiu1_pad_awcache             ),
  .ibiu1_pad_awdomain             (ibiu1_pad_awdomain            ),
  .ibiu1_pad_awid                 (ibiu1_pad_awid                ),
  .ibiu1_pad_awlen                (ibiu1_pad_awlen               ),
  .ibiu1_pad_awlock               (ibiu1_pad_awlock              ),
  .ibiu1_pad_awprot               (ibiu1_pad_awprot              ),
  .ibiu1_pad_awsize               (ibiu1_pad_awsize              ),
  .ibiu1_pad_awsnoop              (ibiu1_pad_awsnoop             ),
  .ibiu1_pad_awunique             (ibiu1_pad_awunique            ),
  .ibiu1_pad_awuser               (ibiu1_pad_awuser              ),
  .ibiu1_pad_awvalid              (ibiu1_pad_awvalid             ),
  .ibiu1_pad_back                 (ibiu1_pad_back                ),
  .ibiu1_pad_bready               (ibiu1_pad_bready              ),
  .ibiu1_pad_cddata               (ibiu1_pad_cddata              ),
  .ibiu1_pad_cderr                (ibiu1_pad_cderr               ),
  .ibiu1_pad_cdlast               (ibiu1_pad_cdlast              ),
  .ibiu1_pad_cdvalid              (ibiu1_pad_cdvalid             ),
  .ibiu1_pad_cnt_en               (ibiu1_pad_cnt_en              ),
  .ibiu1_pad_crresp               (ibiu1_pad_crresp              ),
  .ibiu1_pad_crvalid              (ibiu1_pad_crvalid             ),
  .ibiu1_pad_csr_sel              (ibiu1_pad_csr_sel             ),
  .ibiu1_pad_csr_wdata            (ibiu1_pad_csr_wdata           ),
  .ibiu1_pad_jdb_pm               (ibiu1_pad_jdb_pm              ),
  .ibiu1_pad_lpmd_b               (ibiu1_pad_lpmd_b              ),
  .ibiu1_pad_rack                 (ibiu1_pad_rack                ),
  .ibiu1_pad_rready               (ibiu1_pad_rready              ),
  .ibiu1_pad_wdata                (ibiu1_pad_wdata               ),
  .ibiu1_pad_werr                 (ibiu1_pad_werr                ),
  .ibiu1_pad_wlast                (ibiu1_pad_wlast               ),
  .ibiu1_pad_wns                  (ibiu1_pad_wns                 ),
  .ibiu1_pad_wstrb                (ibiu1_pad_wstrb               ),
  .ibiu1_pad_wvalid               (ibiu1_pad_wvalid              ),
  .ibiu2_pad_acready              (ibiu2_pad_acready             ),
  .ibiu2_pad_araddr               (ibiu2_pad_araddr              ),
  .ibiu2_pad_arbar                (ibiu2_pad_arbar               ),
  .ibiu2_pad_arburst              (ibiu2_pad_arburst             ),
  .ibiu2_pad_arcache              (ibiu2_pad_arcache             ),
  .ibiu2_pad_ardomain             (ibiu2_pad_ardomain            ),
  .ibiu2_pad_arid                 (ibiu2_pad_arid                ),
  .ibiu2_pad_arlen                (ibiu2_pad_arlen               ),
  .ibiu2_pad_arlock               (ibiu2_pad_arlock              ),
  .ibiu2_pad_arprot               (ibiu2_pad_arprot              ),
  .ibiu2_pad_arsize               (ibiu2_pad_arsize              ),
  .ibiu2_pad_arsnoop              (ibiu2_pad_arsnoop             ),
  .ibiu2_pad_aruser               (ibiu2_pad_aruser              ),
  .ibiu2_pad_arvalid              (ibiu2_pad_arvalid             ),
  .ibiu2_pad_awaddr               (ibiu2_pad_awaddr              ),
  .ibiu2_pad_awbar                (ibiu2_pad_awbar               ),
  .ibiu2_pad_awburst              (ibiu2_pad_awburst             ),
  .ibiu2_pad_awcache              (ibiu2_pad_awcache             ),
  .ibiu2_pad_awdomain             (ibiu2_pad_awdomain            ),
  .ibiu2_pad_awid                 (ibiu2_pad_awid                ),
  .ibiu2_pad_awlen                (ibiu2_pad_awlen               ),
  .ibiu2_pad_awlock               (ibiu2_pad_awlock              ),
  .ibiu2_pad_awprot               (ibiu2_pad_awprot              ),
  .ibiu2_pad_awsize               (ibiu2_pad_awsize              ),
  .ibiu2_pad_awsnoop              (ibiu2_pad_awsnoop             ),
  .ibiu2_pad_awunique             (ibiu2_pad_awunique            ),
  .ibiu2_pad_awuser               (ibiu2_pad_awuser              ),
  .ibiu2_pad_awvalid              (ibiu2_pad_awvalid             ),
  .ibiu2_pad_back                 (ibiu2_pad_back                ),
  .ibiu2_pad_bready               (ibiu2_pad_bready              ),
  .ibiu2_pad_cddata               (ibiu2_pad_cddata              ),
  .ibiu2_pad_cderr                (ibiu2_pad_cderr               ),
  .ibiu2_pad_cdlast               (ibiu2_pad_cdlast              ),
  .ibiu2_pad_cdvalid              (ibiu2_pad_cdvalid             ),
  .ibiu2_pad_cnt_en               (ibiu2_pad_cnt_en              ),
  .ibiu2_pad_crresp               (ibiu2_pad_crresp              ),
  .ibiu2_pad_crvalid              (ibiu2_pad_crvalid             ),
  .ibiu2_pad_csr_sel              (ibiu2_pad_csr_sel             ),
  .ibiu2_pad_csr_wdata            (ibiu2_pad_csr_wdata           ),
  .ibiu2_pad_jdb_pm               (ibiu2_pad_jdb_pm              ),
  .ibiu2_pad_lpmd_b               (ibiu2_pad_lpmd_b              ),
  .ibiu2_pad_rack                 (ibiu2_pad_rack                ),
  .ibiu2_pad_rready               (ibiu2_pad_rready              ),
  .ibiu2_pad_wdata                (ibiu2_pad_wdata               ),
  .ibiu2_pad_werr                 (ibiu2_pad_werr                ),
  .ibiu2_pad_wlast                (ibiu2_pad_wlast               ),
  .ibiu2_pad_wns                  (ibiu2_pad_wns                 ),
  .ibiu2_pad_wstrb                (ibiu2_pad_wstrb               ),
  .ibiu2_pad_wvalid               (ibiu2_pad_wvalid              ),
  .ibiu3_pad_acready              (ibiu3_pad_acready             ),
  .ibiu3_pad_araddr               (ibiu3_pad_araddr              ),
  .ibiu3_pad_arbar                (ibiu3_pad_arbar               ),
  .ibiu3_pad_arburst              (ibiu3_pad_arburst             ),
  .ibiu3_pad_arcache              (ibiu3_pad_arcache             ),
  .ibiu3_pad_ardomain             (ibiu3_pad_ardomain            ),
  .ibiu3_pad_arid                 (ibiu3_pad_arid                ),
  .ibiu3_pad_arlen                (ibiu3_pad_arlen               ),
  .ibiu3_pad_arlock               (ibiu3_pad_arlock              ),
  .ibiu3_pad_arprot               (ibiu3_pad_arprot              ),
  .ibiu3_pad_arsize               (ibiu3_pad_arsize              ),
  .ibiu3_pad_arsnoop              (ibiu3_pad_arsnoop             ),
  .ibiu3_pad_aruser               (ibiu3_pad_aruser              ),
  .ibiu3_pad_arvalid              (ibiu3_pad_arvalid             ),
  .ibiu3_pad_awaddr               (ibiu3_pad_awaddr              ),
  .ibiu3_pad_awbar                (ibiu3_pad_awbar               ),
  .ibiu3_pad_awburst              (ibiu3_pad_awburst             ),
  .ibiu3_pad_awcache              (ibiu3_pad_awcache             ),
  .ibiu3_pad_awdomain             (ibiu3_pad_awdomain            ),
  .ibiu3_pad_awid                 (ibiu3_pad_awid                ),
  .ibiu3_pad_awlen                (ibiu3_pad_awlen               ),
  .ibiu3_pad_awlock               (ibiu3_pad_awlock              ),
  .ibiu3_pad_awprot               (ibiu3_pad_awprot              ),
  .ibiu3_pad_awsize               (ibiu3_pad_awsize              ),
  .ibiu3_pad_awsnoop              (ibiu3_pad_awsnoop             ),
  .ibiu3_pad_awunique             (ibiu3_pad_awunique            ),
  .ibiu3_pad_awuser               (ibiu3_pad_awuser              ),
  .ibiu3_pad_awvalid              (ibiu3_pad_awvalid             ),
  .ibiu3_pad_back                 (ibiu3_pad_back                ),
  .ibiu3_pad_bready               (ibiu3_pad_bready              ),
  .ibiu3_pad_cddata               (ibiu3_pad_cddata              ),
  .ibiu3_pad_cderr                (ibiu3_pad_cderr               ),
  .ibiu3_pad_cdlast               (ibiu3_pad_cdlast              ),
  .ibiu3_pad_cdvalid              (ibiu3_pad_cdvalid             ),
  .ibiu3_pad_cnt_en               (ibiu3_pad_cnt_en              ),
  .ibiu3_pad_crresp               (ibiu3_pad_crresp              ),
  .ibiu3_pad_crvalid              (ibiu3_pad_crvalid             ),
  .ibiu3_pad_csr_sel              (ibiu3_pad_csr_sel             ),
  .ibiu3_pad_csr_wdata            (ibiu3_pad_csr_wdata           ),
  .ibiu3_pad_jdb_pm               (ibiu3_pad_jdb_pm              ),
  .ibiu3_pad_lpmd_b               (ibiu3_pad_lpmd_b              ),
  .ibiu3_pad_rack                 (ibiu3_pad_rack                ),
  .ibiu3_pad_rready               (ibiu3_pad_rready              ),
  .ibiu3_pad_wdata                (ibiu3_pad_wdata               ),
  .ibiu3_pad_werr                 (ibiu3_pad_werr                ),
  .ibiu3_pad_wlast                (ibiu3_pad_wlast               ),
  .ibiu3_pad_wns                  (ibiu3_pad_wns                 ),
  .ibiu3_pad_wstrb                (ibiu3_pad_wstrb               ),
  .ibiu3_pad_wvalid               (ibiu3_pad_wvalid              ),
  .l2c_ciu_addr_ready_bank_0      (l2c_ciu_addr_ready_bank_0     ),
  .l2c_ciu_addr_ready_bank_1      (l2c_ciu_addr_ready_bank_1     ),
  .l2c_ciu_cmplt_bank_0           (l2c_ciu_cmplt_bank_0          ),
  .l2c_ciu_cmplt_bank_1           (l2c_ciu_cmplt_bank_1          ),
  .l2c_ciu_cp_bank_0              (l2c_ciu_cp_bank_0             ),
  .l2c_ciu_cp_bank_1              (l2c_ciu_cp_bank_1             ),
  .l2c_ciu_ctcq_cmplt_bank_0      (l2c_ciu_ctcq_cmplt_bank_0     ),
  .l2c_ciu_ctcq_cmplt_bank_1      (l2c_ciu_ctcq_cmplt_bank_1     ),
  .l2c_ciu_ctcq_ready_bank_0      (l2c_ciu_ctcq_ready_bank_0     ),
  .l2c_ciu_ctcq_ready_bank_1      (l2c_ciu_ctcq_ready_bank_1     ),
  .l2c_ciu_data_bank_0            (l2c_ciu_data_bank_0           ),
  .l2c_ciu_data_bank_1            (l2c_ciu_data_bank_1           ),
  .l2c_ciu_data_ready_bank_0      (l2c_ciu_data_ready_bank_0     ),
  .l2c_ciu_data_ready_bank_1      (l2c_ciu_data_ready_bank_1     ),
  .l2c_ciu_data_ready_gate_bank_0 (l2c_ciu_data_ready_gate_bank_0),
  .l2c_ciu_data_ready_gate_bank_1 (l2c_ciu_data_ready_gate_bank_1),
  .l2c_ciu_dbg_info               (l2c_ciu_dbg_info              ),
  .l2c_ciu_dca_cmplt_bank_0       (l2c_ciu_dca_cmplt_bank_0      ),
  .l2c_ciu_dca_cmplt_bank_1       (l2c_ciu_dca_cmplt_bank_1      ),
  .l2c_ciu_dca_data_bank_0        (l2c_ciu_dca_data_bank_0       ),
  .l2c_ciu_dca_data_bank_1        (l2c_ciu_dca_data_bank_1       ),
  .l2c_ciu_dca_ready_bank_0       (l2c_ciu_dca_ready_bank_0      ),
  .l2c_ciu_dca_ready_bank_1       (l2c_ciu_dca_ready_bank_1      ),
  .l2c_ciu_hpcp_acc_inc_bank_0    (l2c_ciu_hpcp_acc_inc_bank_0   ),
  .l2c_ciu_hpcp_acc_inc_bank_1    (l2c_ciu_hpcp_acc_inc_bank_1   ),
  .l2c_ciu_hpcp_mid_bank_0        (l2c_ciu_hpcp_mid_bank_0       ),
  .l2c_ciu_hpcp_mid_bank_1        (l2c_ciu_hpcp_mid_bank_1       ),
  .l2c_ciu_hpcp_miss_inc_bank_0   (l2c_ciu_hpcp_miss_inc_bank_0  ),
  .l2c_ciu_hpcp_miss_inc_bank_1   (l2c_ciu_hpcp_miss_inc_bank_1  ),
  .l2c_ciu_prf_addr               (l2c_ciu_prf_addr              ),
  .l2c_ciu_prf_prot               (l2c_ciu_prf_prot              ),
  .l2c_ciu_prf_vld                (l2c_ciu_prf_vld               ),
  .l2c_ciu_rdl_addr_bank_0        (l2c_ciu_rdl_addr_bank_0       ),
  .l2c_ciu_rdl_addr_bank_1        (l2c_ciu_rdl_addr_bank_1       ),
  .l2c_ciu_rdl_dvld_bank_0        (l2c_ciu_rdl_dvld_bank_0       ),
  .l2c_ciu_rdl_dvld_bank_1        (l2c_ciu_rdl_dvld_bank_1       ),
  .l2c_ciu_rdl_mid_bank_0         (l2c_ciu_rdl_mid_bank_0        ),
  .l2c_ciu_rdl_mid_bank_1         (l2c_ciu_rdl_mid_bank_1        ),
  .l2c_ciu_rdl_prot_bank_0        (l2c_ciu_rdl_prot_bank_0       ),
  .l2c_ciu_rdl_prot_bank_1        (l2c_ciu_rdl_prot_bank_1       ),
  .l2c_ciu_rdl_rvld_bank_0        (l2c_ciu_rdl_rvld_bank_0       ),
  .l2c_ciu_rdl_rvld_bank_1        (l2c_ciu_rdl_rvld_bank_1       ),
  .l2c_ciu_resp_bank_0            (l2c_ciu_resp_bank_0           ),
  .l2c_ciu_resp_bank_1            (l2c_ciu_resp_bank_1           ),
  .l2c_ciu_sid_bank_0             (l2c_ciu_sid_bank_0            ),
  .l2c_ciu_sid_bank_1             (l2c_ciu_sid_bank_1            ),
  .l2c_ciu_snpl2_addr_bank_0      (l2c_ciu_snpl2_addr_bank_0     ),
  .l2c_ciu_snpl2_addr_bank_1      (l2c_ciu_snpl2_addr_bank_1     ),
  .l2c_ciu_snpl2_ini_sid_bank_0   (l2c_ciu_snpl2_ini_sid_bank_0  ),
  .l2c_ciu_snpl2_ini_sid_bank_1   (l2c_ciu_snpl2_ini_sid_bank_1  ),
  .l2c_ciu_snpl2_vld_bank_0       (l2c_ciu_snpl2_vld_bank_0      ),
  .l2c_ciu_snpl2_vld_bank_1       (l2c_ciu_snpl2_vld_bank_1      ),
  .l2c_had_dbg_info               (l2c_had_dbg_info              ),
  .l2c_icg_en                     (l2c_icg_en                    ),
  .l2c_plic_ecc_int_vld           (l2c_plic_ecc_int_vld          ),
  .l2c_xx_no_op                   (l2c_xx_no_op                  ),
  .pad_biu_arready                (pad_biu_arready               ),
  .pad_biu_awready                (pad_biu_awready               ),
  .pad_biu_bid                    (pad_biu_bid                   ),
  .pad_biu_bresp                  (pad_biu_bresp                 ),
  .pad_biu_bvalid                 (pad_biu_bvalid                ),
  .pad_biu_csysreq                (pad_biu_csysreq               ),
  .pad_biu_rdata                  (pad_biu_rdata                 ),
  .pad_biu_rid                    (pad_biu_rid                   ),
  .pad_biu_rlast                  (pad_biu_rlast                 ),
  .pad_biu_rresp                  (pad_biu_rresp                 ),
  .pad_biu_rvalid                 (pad_biu_rvalid                ),
  .pad_biu_wready                 (pad_biu_wready                ),
  .pad_ibiu0_acaddr               (pad_ibiu0_acaddr              ),
  .pad_ibiu0_acprot               (pad_ibiu0_acprot              ),
  .pad_ibiu0_acsnoop              (pad_ibiu0_acsnoop             ),
  .pad_ibiu0_acvalid              (pad_ibiu0_acvalid             ),
  .pad_ibiu0_arready              (pad_ibiu0_arready             ),
  .pad_ibiu0_awready              (pad_ibiu0_awready             ),
  .pad_ibiu0_bid                  (pad_ibiu0_bid                 ),
  .pad_ibiu0_bresp                (pad_ibiu0_bresp               ),
  .pad_ibiu0_bvalid               (pad_ibiu0_bvalid              ),
  .pad_ibiu0_cdready              (pad_ibiu0_cdready             ),
  .pad_ibiu0_crready              (pad_ibiu0_crready             ),
  .pad_ibiu0_csr_cmplt            (pad_ibiu0_csr_cmplt           ),
  .pad_ibiu0_csr_rdata            (pad_ibiu0_csr_rdata           ),
  .pad_ibiu0_dbgrq_b              (pad_ibiu0_dbgrq_b             ),
  .pad_ibiu0_hpcp_l2of_int        (pad_ibiu0_hpcp_l2of_int       ),
  .pad_ibiu0_me_int               (pad_ibiu0_me_int              ),
  .pad_ibiu0_ms_int               (pad_ibiu0_ms_int              ),
  .pad_ibiu0_mt_int               (pad_ibiu0_mt_int              ),
  .pad_ibiu0_rdata                (pad_ibiu0_rdata               ),
  .pad_ibiu0_rid                  (pad_ibiu0_rid                 ),
  .pad_ibiu0_rlast                (pad_ibiu0_rlast               ),
  .pad_ibiu0_rresp                (pad_ibiu0_rresp               ),
  .pad_ibiu0_rvalid               (pad_ibiu0_rvalid              ),
  .pad_ibiu0_se_int               (pad_ibiu0_se_int              ),
  .pad_ibiu0_ss_int               (pad_ibiu0_ss_int              ),
  .pad_ibiu0_st_int               (pad_ibiu0_st_int              ),
  .pad_ibiu0_wns_awready          (pad_ibiu0_wns_awready         ),
  .pad_ibiu0_wns_wready           (pad_ibiu0_wns_wready          ),
  .pad_ibiu0_wready               (pad_ibiu0_wready              ),
  .pad_ibiu0_ws_awready           (pad_ibiu0_ws_awready          ),
  .pad_ibiu0_ws_wready            (pad_ibiu0_ws_wready           ),
  .pad_ibiu1_acaddr               (pad_ibiu1_acaddr              ),
  .pad_ibiu1_acprot               (pad_ibiu1_acprot              ),
  .pad_ibiu1_acsnoop              (pad_ibiu1_acsnoop             ),
  .pad_ibiu1_acvalid              (pad_ibiu1_acvalid             ),
  .pad_ibiu1_arready              (pad_ibiu1_arready             ),
  .pad_ibiu1_awready              (pad_ibiu1_awready             ),
  .pad_ibiu1_bid                  (pad_ibiu1_bid                 ),
  .pad_ibiu1_bresp                (pad_ibiu1_bresp               ),
  .pad_ibiu1_bvalid               (pad_ibiu1_bvalid              ),
  .pad_ibiu1_cdready              (pad_ibiu1_cdready             ),
  .pad_ibiu1_crready              (pad_ibiu1_crready             ),
  .pad_ibiu1_csr_cmplt            (pad_ibiu1_csr_cmplt           ),
  .pad_ibiu1_csr_rdata            (pad_ibiu1_csr_rdata           ),
  .pad_ibiu1_dbgrq_b              (pad_ibiu1_dbgrq_b             ),
  .pad_ibiu1_hpcp_l2of_int        (pad_ibiu1_hpcp_l2of_int       ),
  .pad_ibiu1_me_int               (pad_ibiu1_me_int              ),
  .pad_ibiu1_ms_int               (pad_ibiu1_ms_int              ),
  .pad_ibiu1_mt_int               (pad_ibiu1_mt_int              ),
  .pad_ibiu1_rdata                (pad_ibiu1_rdata               ),
  .pad_ibiu1_rid                  (pad_ibiu1_rid                 ),
  .pad_ibiu1_rlast                (pad_ibiu1_rlast               ),
  .pad_ibiu1_rresp                (pad_ibiu1_rresp               ),
  .pad_ibiu1_rvalid               (pad_ibiu1_rvalid              ),
  .pad_ibiu1_se_int               (pad_ibiu1_se_int              ),
  .pad_ibiu1_ss_int               (pad_ibiu1_ss_int              ),
  .pad_ibiu1_st_int               (pad_ibiu1_st_int              ),
  .pad_ibiu1_wns_awready          (pad_ibiu1_wns_awready         ),
  .pad_ibiu1_wns_wready           (pad_ibiu1_wns_wready          ),
  .pad_ibiu1_wready               (pad_ibiu1_wready              ),
  .pad_ibiu1_ws_awready           (pad_ibiu1_ws_awready          ),
  .pad_ibiu1_ws_wready            (pad_ibiu1_ws_wready           ),
  .pad_ibiu2_acaddr               (pad_ibiu2_acaddr              ),
  .pad_ibiu2_acprot               (pad_ibiu2_acprot              ),
  .pad_ibiu2_acsnoop              (pad_ibiu2_acsnoop             ),
  .pad_ibiu2_acvalid              (pad_ibiu2_acvalid             ),
  .pad_ibiu2_arready              (pad_ibiu2_arready             ),
  .pad_ibiu2_awready              (pad_ibiu2_awready             ),
  .pad_ibiu2_bid                  (pad_ibiu2_bid                 ),
  .pad_ibiu2_bresp                (pad_ibiu2_bresp               ),
  .pad_ibiu2_bvalid               (pad_ibiu2_bvalid              ),
  .pad_ibiu2_cdready              (pad_ibiu2_cdready             ),
  .pad_ibiu2_crready              (pad_ibiu2_crready             ),
  .pad_ibiu2_csr_cmplt            (pad_ibiu2_csr_cmplt           ),
  .pad_ibiu2_csr_rdata            (pad_ibiu2_csr_rdata           ),
  .pad_ibiu2_dbgrq_b              (pad_ibiu2_dbgrq_b             ),
  .pad_ibiu2_hpcp_l2of_int        (pad_ibiu2_hpcp_l2of_int       ),
  .pad_ibiu2_me_int               (pad_ibiu2_me_int              ),
  .pad_ibiu2_ms_int               (pad_ibiu2_ms_int              ),
  .pad_ibiu2_mt_int               (pad_ibiu2_mt_int              ),
  .pad_ibiu2_rdata                (pad_ibiu2_rdata               ),
  .pad_ibiu2_rid                  (pad_ibiu2_rid                 ),
  .pad_ibiu2_rlast                (pad_ibiu2_rlast               ),
  .pad_ibiu2_rresp                (pad_ibiu2_rresp               ),
  .pad_ibiu2_rvalid               (pad_ibiu2_rvalid              ),
  .pad_ibiu2_se_int               (pad_ibiu2_se_int              ),
  .pad_ibiu2_ss_int               (pad_ibiu2_ss_int              ),
  .pad_ibiu2_st_int               (pad_ibiu2_st_int              ),
  .pad_ibiu2_wns_awready          (pad_ibiu2_wns_awready         ),
  .pad_ibiu2_wns_wready           (pad_ibiu2_wns_wready          ),
  .pad_ibiu2_wready               (pad_ibiu2_wready              ),
  .pad_ibiu2_ws_awready           (pad_ibiu2_ws_awready          ),
  .pad_ibiu2_ws_wready            (pad_ibiu2_ws_wready           ),
  .pad_ibiu3_acaddr               (pad_ibiu3_acaddr              ),
  .pad_ibiu3_acprot               (pad_ibiu3_acprot              ),
  .pad_ibiu3_acsnoop              (pad_ibiu3_acsnoop             ),
  .pad_ibiu3_acvalid              (pad_ibiu3_acvalid             ),
  .pad_ibiu3_arready              (pad_ibiu3_arready             ),
  .pad_ibiu3_awready              (pad_ibiu3_awready             ),
  .pad_ibiu3_bid                  (pad_ibiu3_bid                 ),
  .pad_ibiu3_bresp                (pad_ibiu3_bresp               ),
  .pad_ibiu3_bvalid               (pad_ibiu3_bvalid              ),
  .pad_ibiu3_cdready              (pad_ibiu3_cdready             ),
  .pad_ibiu3_crready              (pad_ibiu3_crready             ),
  .pad_ibiu3_csr_cmplt            (pad_ibiu3_csr_cmplt           ),
  .pad_ibiu3_csr_rdata            (pad_ibiu3_csr_rdata           ),
  .pad_ibiu3_dbgrq_b              (pad_ibiu3_dbgrq_b             ),
  .pad_ibiu3_hpcp_l2of_int        (pad_ibiu3_hpcp_l2of_int       ),
  .pad_ibiu3_me_int               (pad_ibiu3_me_int              ),
  .pad_ibiu3_ms_int               (pad_ibiu3_ms_int              ),
  .pad_ibiu3_mt_int               (pad_ibiu3_mt_int              ),
  .pad_ibiu3_rdata                (pad_ibiu3_rdata               ),
  .pad_ibiu3_rid                  (pad_ibiu3_rid                 ),
  .pad_ibiu3_rlast                (pad_ibiu3_rlast               ),
  .pad_ibiu3_rresp                (pad_ibiu3_rresp               ),
  .pad_ibiu3_rvalid               (pad_ibiu3_rvalid              ),
  .pad_ibiu3_se_int               (pad_ibiu3_se_int              ),
  .pad_ibiu3_ss_int               (pad_ibiu3_ss_int              ),
  .pad_ibiu3_st_int               (pad_ibiu3_st_int              ),
  .pad_ibiu3_wns_awready          (pad_ibiu3_wns_awready         ),
  .pad_ibiu3_wns_wready           (pad_ibiu3_wns_wready          ),
  .pad_ibiu3_wready               (pad_ibiu3_wready              ),
  .pad_ibiu3_ws_awready           (pad_ibiu3_ws_awready          ),
  .pad_ibiu3_ws_wready            (pad_ibiu3_ws_wready           ),
  .pad_yy_icg_scan_en             (pad_yy_icg_scan_en            ),
  .paddr                          (paddr                         ),
  .penable                        (penable                       ),
  .perr_clint                     (perr_clint                    ),
  .perr_had                       (perr_had                      ),
  .perr_plic                      (perr_plic                     ),
  .perr_rmr                       (perr_rmr                      ),
  .piu0_sysio_jdb_pm              (piu0_sysio_jdb_pm             ),
  .piu0_sysio_lpmd_b              (piu0_sysio_lpmd_b             ),
  .piu1_sysio_jdb_pm              (piu1_sysio_jdb_pm             ),
  .piu1_sysio_lpmd_b              (piu1_sysio_lpmd_b             ),
  .pprot                          (pprot                         ),
  .prdata_clint                   (prdata_clint                  ),
  .prdata_had                     (prdata_had                    ),
  .prdata_plic                    (prdata_plic                   ),
  .prdata_rmr                     (prdata_rmr                    ),
  .pready_clint                   (pready_clint                  ),
  .pready_had                     (pready_had                    ),
  .pready_plic                    (pready_plic                   ),
  .pready_rmr                     (pready_rmr                    ),
  .psel_clint                     (psel_clint                    ),
  .psel_had                       (psel_had                      ),
  .psel_plic                      (psel_plic                     ),
  .psel_rmr                       (psel_rmr                      ),
  .pwdata                         (pwdata                        ),
  .pwrite                         (pwrite                        ),
  .sysio_ciu_apb_base             (sysio_ciu_apb_base            ),
  .sysio_l2c_flush_req            (sysio_l2c_flush_req           ),
  .sysio_piu0_dbgrq_b             (sysio_piu0_dbgrq_b            ),
  .sysio_piu0_me_int              (sysio_piu0_me_int             ),
  .sysio_piu0_ms_int              (sysio_piu0_ms_int             ),
  .sysio_piu0_mt_int              (sysio_piu0_mt_int             ),
  .sysio_piu0_se_int              (sysio_piu0_se_int             ),
  .sysio_piu0_ss_int              (sysio_piu0_ss_int             ),
  .sysio_piu0_st_int              (sysio_piu0_st_int             ),
  .sysio_piu1_dbgrq_b             (sysio_piu1_dbgrq_b            ),
  .sysio_piu1_me_int              (sysio_piu1_me_int             ),
  .sysio_piu1_ms_int              (sysio_piu1_ms_int             ),
  .sysio_piu1_mt_int              (sysio_piu1_mt_int             ),
  .sysio_piu1_se_int              (sysio_piu1_se_int             ),
  .sysio_piu1_ss_int              (sysio_piu1_ss_int             ),
  .sysio_piu1_st_int              (sysio_piu1_st_int             )
);

// &Connect(.forever_cpuclk   (forever_cpuclk)); @435
// &Connect(.cpurst_b         (cpurst_b      )); @436
// &Connect(.clk_en           (axim_clk_en_f )); @437
// &Connect(.apb_clk_en       (apb_clk_en    )); @438
// &Connect(.slvif_clk_en     (slvif_clk_en_f)); @439


// //&Force("nonport","pad_core0_acsid"); @1396
//==========================================================
//  Instance ct_l2c_top sub module 
//==========================================================
// &Instance("ct_l2c_top"); @1400
ct_l2c_top  x_ct_l2c_top (
  .ciu_l2c_addr_bank_0            (ciu_l2c_addr_bank_0           ),
  .ciu_l2c_addr_bank_1            (ciu_l2c_addr_bank_1           ),
  .ciu_l2c_addr_vld_bank_0        (ciu_l2c_addr_vld_bank_0       ),
  .ciu_l2c_addr_vld_bank_1        (ciu_l2c_addr_vld_bank_1       ),
  .ciu_l2c_clr_cp_bank_0          (ciu_l2c_clr_cp_bank_0         ),
  .ciu_l2c_clr_cp_bank_1          (ciu_l2c_clr_cp_bank_1         ),
  .ciu_l2c_ctcq_req_bank_0        (ciu_l2c_ctcq_req_bank_0       ),
  .ciu_l2c_ctcq_req_bank_1        (ciu_l2c_ctcq_req_bank_1       ),
  .ciu_l2c_data_latency           (ciu_l2c_data_latency          ),
  .ciu_l2c_data_setup             (ciu_l2c_data_setup            ),
  .ciu_l2c_data_vld_bank_0        (ciu_l2c_data_vld_bank_0       ),
  .ciu_l2c_data_vld_bank_1        (ciu_l2c_data_vld_bank_1       ),
  .ciu_l2c_dca_addr_bank_0        (ciu_l2c_dca_addr_bank_0       ),
  .ciu_l2c_dca_addr_bank_1        (ciu_l2c_dca_addr_bank_1       ),
  .ciu_l2c_dca_req_bank_0         (ciu_l2c_dca_req_bank_0        ),
  .ciu_l2c_dca_req_bank_1         (ciu_l2c_dca_req_bank_1        ),
  .ciu_l2c_hpcp_bus_bank_0        (ciu_l2c_hpcp_bus_bank_0       ),
  .ciu_l2c_hpcp_bus_bank_1        (ciu_l2c_hpcp_bus_bank_1       ),
  .ciu_l2c_icc_mid_bank_0         (ciu_l2c_icc_mid_bank_0        ),
  .ciu_l2c_icc_mid_bank_1         (ciu_l2c_icc_mid_bank_1        ),
  .ciu_l2c_icc_type_bank_0        (ciu_l2c_icc_type_bank_0       ),
  .ciu_l2c_icc_type_bank_1        (ciu_l2c_icc_type_bank_1       ),
  .ciu_l2c_iprf                   (ciu_l2c_iprf                  ),
  .ciu_l2c_mid_bank_0             (ciu_l2c_mid_bank_0            ),
  .ciu_l2c_mid_bank_1             (ciu_l2c_mid_bank_1            ),
  .ciu_l2c_prf_ready              (ciu_l2c_prf_ready             ),
  .ciu_l2c_rdl_ready_bank_0       (ciu_l2c_rdl_ready_bank_0      ),
  .ciu_l2c_rdl_ready_bank_1       (ciu_l2c_rdl_ready_bank_1      ),
  .ciu_l2c_rst_req                (ciu_l2c_rst_req               ),
  .ciu_l2c_set_cp_bank_0          (ciu_l2c_set_cp_bank_0         ),
  .ciu_l2c_set_cp_bank_1          (ciu_l2c_set_cp_bank_1         ),
  .ciu_l2c_sid_bank_0             (ciu_l2c_sid_bank_0            ),
  .ciu_l2c_sid_bank_1             (ciu_l2c_sid_bank_1            ),
  .ciu_l2c_snpl2_ready_bank_0     (ciu_l2c_snpl2_ready_bank_0    ),
  .ciu_l2c_snpl2_ready_bank_1     (ciu_l2c_snpl2_ready_bank_1    ),
  .ciu_l2c_src_bank_0             (ciu_l2c_src_bank_0            ),
  .ciu_l2c_src_bank_1             (ciu_l2c_src_bank_1            ),
  .ciu_l2c_tag_latency            (ciu_l2c_tag_latency           ),
  .ciu_l2c_tag_setup              (ciu_l2c_tag_setup             ),
  .ciu_l2c_tprf                   (ciu_l2c_tprf                  ),
  .ciu_l2c_type_bank_0            (ciu_l2c_type_bank_0           ),
  .ciu_l2c_type_bank_1            (ciu_l2c_type_bank_1           ),
  .ciu_l2c_wdata_bank_0           (ciu_l2c_wdata_bank_0          ),
  .ciu_l2c_wdata_bank_1           (ciu_l2c_wdata_bank_1          ),
  .ciu_top_clk                    (ciu_top_clk                   ),
  .ciu_xx_no_op                   (ciu_xx_no_op                  ),
  .cpurst_b                       (cpurst_b                      ),
  .forever_cpuclk                 (forever_cpuclk                ),
  .l2c_ciu_addr_ready_bank_0      (l2c_ciu_addr_ready_bank_0     ),
  .l2c_ciu_addr_ready_bank_1      (l2c_ciu_addr_ready_bank_1     ),
  .l2c_ciu_cmplt_bank_0           (l2c_ciu_cmplt_bank_0          ),
  .l2c_ciu_cmplt_bank_1           (l2c_ciu_cmplt_bank_1          ),
  .l2c_ciu_cp_bank_0              (l2c_ciu_cp_bank_0             ),
  .l2c_ciu_cp_bank_1              (l2c_ciu_cp_bank_1             ),
  .l2c_ciu_ctcq_cmplt_bank_0      (l2c_ciu_ctcq_cmplt_bank_0     ),
  .l2c_ciu_ctcq_cmplt_bank_1      (l2c_ciu_ctcq_cmplt_bank_1     ),
  .l2c_ciu_ctcq_ready_bank_0      (l2c_ciu_ctcq_ready_bank_0     ),
  .l2c_ciu_ctcq_ready_bank_1      (l2c_ciu_ctcq_ready_bank_1     ),
  .l2c_ciu_data_bank_0            (l2c_ciu_data_bank_0           ),
  .l2c_ciu_data_bank_1            (l2c_ciu_data_bank_1           ),
  .l2c_ciu_data_ready_bank_0      (l2c_ciu_data_ready_bank_0     ),
  .l2c_ciu_data_ready_bank_1      (l2c_ciu_data_ready_bank_1     ),
  .l2c_ciu_data_ready_gate_bank_0 (l2c_ciu_data_ready_gate_bank_0),
  .l2c_ciu_data_ready_gate_bank_1 (l2c_ciu_data_ready_gate_bank_1),
  .l2c_ciu_dbg_info               (l2c_ciu_dbg_info              ),
  .l2c_ciu_dca_cmplt_bank_0       (l2c_ciu_dca_cmplt_bank_0      ),
  .l2c_ciu_dca_cmplt_bank_1       (l2c_ciu_dca_cmplt_bank_1      ),
  .l2c_ciu_dca_data_bank_0        (l2c_ciu_dca_data_bank_0       ),
  .l2c_ciu_dca_data_bank_1        (l2c_ciu_dca_data_bank_1       ),
  .l2c_ciu_dca_ready_bank_0       (l2c_ciu_dca_ready_bank_0      ),
  .l2c_ciu_dca_ready_bank_1       (l2c_ciu_dca_ready_bank_1      ),
  .l2c_ciu_hpcp_acc_inc_bank_0    (l2c_ciu_hpcp_acc_inc_bank_0   ),
  .l2c_ciu_hpcp_acc_inc_bank_1    (l2c_ciu_hpcp_acc_inc_bank_1   ),
  .l2c_ciu_hpcp_mid_bank_0        (l2c_ciu_hpcp_mid_bank_0       ),
  .l2c_ciu_hpcp_mid_bank_1        (l2c_ciu_hpcp_mid_bank_1       ),
  .l2c_ciu_hpcp_miss_inc_bank_0   (l2c_ciu_hpcp_miss_inc_bank_0  ),
  .l2c_ciu_hpcp_miss_inc_bank_1   (l2c_ciu_hpcp_miss_inc_bank_1  ),
  .l2c_ciu_prf_addr               (l2c_ciu_prf_addr              ),
  .l2c_ciu_prf_prot               (l2c_ciu_prf_prot              ),
  .l2c_ciu_prf_vld                (l2c_ciu_prf_vld               ),
  .l2c_ciu_rdl_addr_bank_0        (l2c_ciu_rdl_addr_bank_0       ),
  .l2c_ciu_rdl_addr_bank_1        (l2c_ciu_rdl_addr_bank_1       ),
  .l2c_ciu_rdl_dvld_bank_0        (l2c_ciu_rdl_dvld_bank_0       ),
  .l2c_ciu_rdl_dvld_bank_1        (l2c_ciu_rdl_dvld_bank_1       ),
  .l2c_ciu_rdl_mid_bank_0         (l2c_ciu_rdl_mid_bank_0        ),
  .l2c_ciu_rdl_mid_bank_1         (l2c_ciu_rdl_mid_bank_1        ),
  .l2c_ciu_rdl_prot_bank_0        (l2c_ciu_rdl_prot_bank_0       ),
  .l2c_ciu_rdl_prot_bank_1        (l2c_ciu_rdl_prot_bank_1       ),
  .l2c_ciu_rdl_rvld_bank_0        (l2c_ciu_rdl_rvld_bank_0       ),
  .l2c_ciu_rdl_rvld_bank_1        (l2c_ciu_rdl_rvld_bank_1       ),
  .l2c_ciu_resp_bank_0            (l2c_ciu_resp_bank_0           ),
  .l2c_ciu_resp_bank_1            (l2c_ciu_resp_bank_1           ),
  .l2c_ciu_sid_bank_0             (l2c_ciu_sid_bank_0            ),
  .l2c_ciu_sid_bank_1             (l2c_ciu_sid_bank_1            ),
  .l2c_ciu_snpl2_addr_bank_0      (l2c_ciu_snpl2_addr_bank_0     ),
  .l2c_ciu_snpl2_addr_bank_1      (l2c_ciu_snpl2_addr_bank_1     ),
  .l2c_ciu_snpl2_ini_sid_bank_0   (l2c_ciu_snpl2_ini_sid_bank_0  ),
  .l2c_ciu_snpl2_ini_sid_bank_1   (l2c_ciu_snpl2_ini_sid_bank_1  ),
  .l2c_ciu_snpl2_vld_bank_0       (l2c_ciu_snpl2_vld_bank_0      ),
  .l2c_ciu_snpl2_vld_bank_1       (l2c_ciu_snpl2_vld_bank_1      ),
  .l2c_data_clk_bank_0            (l2c_data_clk_bank_0           ),
  .l2c_data_clk_bank_1            (l2c_data_clk_bank_1           ),
  .l2c_data_ram_clk_en_bank_0     (l2c_data_ram_clk_en_bank_0    ),
  .l2c_data_ram_clk_en_bank_1     (l2c_data_ram_clk_en_bank_1    ),
  .l2c_icg_en                     (l2c_icg_en                    ),
  .l2c_sysio_flush_done           (l2c_sysio_flush_done          ),
  .l2c_sysio_flush_idle           (l2c_sysio_flush_idle          ),
  .l2c_tag_clk_bank_0             (l2c_tag_clk_bank_0            ),
  .l2c_tag_clk_bank_1             (l2c_tag_clk_bank_1            ),
  .l2c_tag_ram_clk_en_bank_0      (l2c_tag_ram_clk_en_bank_0     ),
  .l2c_tag_ram_clk_en_bank_1      (l2c_tag_ram_clk_en_bank_1     ),
  .l2c_xx_no_op                   (l2c_xx_no_op                  ),
  .pad_yy_icg_scan_en             (pad_yy_icg_scan_en            ),
  .sysio_l2c_flush_req            (sysio_l2c_flush_req           )
);

// &Connect(.forever_cpuclk   (forever_cpuclk)); @1401
// &Connect(.cpurst_b         (cpurst_b )); @1402
// &Connect(.mem_cfg_in       (pad_cpu_mem_cfg_in)); @1404

//==========================================================
//  Instance clint_top
//==========================================================
assign clint_core0_ms_int        = 1'b0; 
assign clint_core0_mt_int        = 1'b0; 
assign clint_core0_ss_int        = 1'b0; 
assign clint_core0_st_int        = 1'b0; 
assign clint_core1_ms_int        = 1'b0; 
assign clint_core1_mt_int        = 1'b0; 
assign clint_core1_ss_int        = 1'b0; 
assign clint_core1_st_int        = 1'b0;
assign perr_clint                = 1'b0; 
assign prdata_clint[31:0]        = 32'b0; 
assign pready_clint              = 1'b0; 

// &Connect(.forever_cpuclk   (forever_cpuclk)); @1411
// &Connect(.forever_apbclk   (apb_clk )); @1412
// &Connect(.cpurst_b         (apbrst_b )); @1413

//==========================================================
//  Instance plic_top
//==========================================================
assign plic_hartx_mint_req[ 1:0] = 2'b00;
assign plic_hartx_sint_req[ 1:0] = 2'b00;
assign prdata_plic[31:0]         = 32'b0;
assign pready_plic               = 1'b1;
assign perr_plic                 = 1'b0;

// TODO: remove in the future.
parameter  PLIC_INT_NUM = 144;

// &Force("input","pad_plic_int_vld"); @1446
// &Force("bus","pad_plic_int_vld",`PLIC_INT_NUM-1,0); @1447
// &Force("input","pad_plic_int_cfg"); @1448
// &Force("bus","pad_plic_int_cfg",`PLIC_INT_NUM-1,0); @1449
// &Force("nonport","plic_hartx_mint_req"); @1450
// &Force("nonport","plic_hartx_sint_req"); @1451
// &Force("nonport","perr_plic"); @1452
// &Force("nonport","prdata_plic"); @1453
// &Force("nonport","pready_plic"); @1454
// &Force("nonport","psel_plic"); @1455
// &Force("nonport","ciu_plic_icg_en"); @1456
// &Force("nonport","plic_int_vld"); @1457
// &Force("nonport","plic_int_cfg"); @1458
// &Force("nonport","pcid"); @1459
// &Force("nonport","psec"); @1460
// &Force("nonport","ciu_plic_core_sec"); @1461
assign plic_int_vld[PLIC_INT_NUM+15:0] = {pad_plic_int_vld[PLIC_INT_NUM-1:0],14'b0,l2c_plic_ecc_int_vld,1'b0};
assign plic_int_cfg[PLIC_INT_NUM+15:0] = {pad_plic_int_cfg[PLIC_INT_NUM-1:0],16'b0};
// &Depend("ct_plic_top_dummy.v"); @1465

assign plic_core0_me_int  = plic_hartx_mint_req[0];
assign plic_core0_se_int  = plic_hartx_sint_req[0];
assign plic_core1_me_int  = plic_hartx_mint_req[1];
assign plic_core1_se_int  = plic_hartx_sint_req[1];
//==========================================================
//  Instance ct_reset_top sub module 
//==========================================================
// &Instance("ct_mp_rst_top"); @1504
ct_mp_rst_top  x_ct_mp_rst_top (
  .apbrst_b             (apbrst_b            ),
  .core0_fifo_rst_b     (core0_fifo_rst_b    ),
  .core0_rst_b          (core0_rst_b         ),
  .core1_fifo_rst_b     (core1_fifo_rst_b    ),
  .core1_rst_b          (core1_rst_b         ),
  .core2_fifo_rst_b     (core2_fifo_rst_b    ),
  .core2_rst_b          (core2_rst_b         ),
  .core3_fifo_rst_b     (core3_fifo_rst_b    ),
  .core3_rst_b          (core3_rst_b         ),
  .cpurst_b             (cpurst_b            ),
  .forever_cpuclk       (forever_cpuclk      ),
  .forever_jtgclk       (forever_jtgclk      ),
  .pad_core0_rst_b      (pad_core0_rst_b     ),
  .pad_core1_rst_b      (pad_core1_rst_b     ),
  .pad_cpu_rst_b        (pad_cpu_rst_b       ),
  .pad_had_jtg_trst_b   (pad_had_jtg_trst_b  ),
  .pad_yy_dft_clk_rst_b (pad_yy_dft_clk_rst_b),
  .pad_yy_mbist_mode    (pad_yy_mbist_mode   ),
  .pad_yy_scan_mode     (pad_yy_scan_mode    ),
  .pad_yy_scan_rst_b    (pad_yy_scan_rst_b   ),
  .phl_rst_b            (phl_rst_b           ),
  .trst_b               (trst_b              )
);

// &Connect(.forever_cpuclk  (forever_cpuclk   )); @1505

//==========================================================
//  Instance ct_clk_top sub module 
//==========================================================
// &Instance("ct_mp_clk_top"); @1510
ct_mp_clk_top  x_ct_mp_clk_top (
  .apb_clk                      (apb_clk                     ),
  .apb_clk_en                   (apb_clk_en                  ),
  .axim_clk_en                  (axim_clk_en                 ),
  .axim_clk_en_f                (axim_clk_en_f               ),
  .forever_core0_clk            (forever_core0_clk           ),
  .forever_core1_clk            (forever_core1_clk           ),
  .forever_core2_clk            (forever_core2_clk           ),
  .forever_core3_clk            (forever_core3_clk           ),
  .forever_cpuclk               (forever_cpuclk              ),
  .forever_jtgclk               (forever_jtgclk              ),
  .l2c_data_clk_bank_0          (l2c_data_clk_bank_0         ),
  .l2c_data_clk_bank_1          (l2c_data_clk_bank_1         ),
  .l2c_data_ram_clk_en_bank_0   (l2c_data_ram_clk_en_bank_0  ),
  .l2c_data_ram_clk_en_bank_1   (l2c_data_ram_clk_en_bank_1  ),
  .l2c_tag_clk_bank_0           (l2c_tag_clk_bank_0          ),
  .l2c_tag_clk_bank_1           (l2c_tag_clk_bank_1          ),
  .l2c_tag_ram_clk_en_bank_0    (l2c_tag_ram_clk_en_bank_0   ),
  .l2c_tag_ram_clk_en_bank_1    (l2c_tag_ram_clk_en_bank_1   ),
  .pad_had_jtg_tclk             (pad_had_jtg_tclk            ),
  .pad_l2c_data_mbist_clk_ratio (pad_l2c_data_mbist_clk_ratio),
  .pad_l2c_tag_mbist_clk_ratio  (pad_l2c_tag_mbist_clk_ratio ),
  .pad_yy_dft_clk_rst_b         (pad_yy_dft_clk_rst_b        ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .pad_yy_mbist_mode            (pad_yy_mbist_mode           ),
  .pad_yy_scan_mode             (pad_yy_scan_mode            ),
  .phl_rst_b                    (phl_rst_b                   ),
  .pll_cpu_clk                  (pll_cpu_clk                 )
);


//==========================================================
//         sysio
//==========================================================
// &Instance("ct_sysio_top"); @1515
ct_sysio_top x_ct_sysio_top (
  .apb_clk_en                             (apb_clk_en                             ),
  .axim_clk_en                            (axim_clk_en_f                          ),
  .ciu_sysio_icg_en                       (ciu_sysio_icg_en                       ),
  .ciu_xx_no_op                           (ciu_xx_no_op                           ),
  .sysio_core0_restart_entry              (sysio_core0_restart_entry              ),
  .sysio_core0_restart_vld                (sysio_core0_restart_vld                ),
  .core0_sysio_restart_grnt               (core0_sysio_restart_grnt               ),
  .sysio_core1_restart_entry              (sysio_core1_restart_entry              ),
  .sysio_core1_restart_vld                (sysio_core1_restart_vld                ),
  .core1_sysio_restart_grnt               (core1_sysio_restart_grnt               ),
  .sysio_core2_restart_entry              (sysio_core2_restart_entry              ),
  .sysio_core2_restart_vld                (sysio_core2_restart_vld                ),
  .core2_sysio_restart_grnt               (core2_sysio_restart_grnt               ),
  .sysio_core3_restart_entry              (sysio_core3_restart_entry              ),
  .sysio_core3_restart_vld                (sysio_core3_restart_vld                ),
  .core3_sysio_restart_grnt               (core3_sysio_restart_grnt               ),
  .sysio_core_gl_stable_timer             (sysio_core_gl_stable_timer             ),
  .core0_sysio_wr_req                     (core0_sysio_wr_req                     ),
  .core0_sysio_wr_sel                     (core0_sysio_wr_sel                     ),
  .core0_sysio_wr_ipi_send_data           (core0_sysio_wr_ipi_send_data           ),
  .core0_sysio_wr_mail_box_send_data      (core0_sysio_wr_mail_box_send_data      ),
  .core0_sysio_mailbox0_data              (core0_sysio_mailbox0_data              ),
  .sysio_core0_cp0_update_ipi_status_en   (sysio_core0_cp0_update_ipi_status_en   ),
  .sysio_core0_cp0_update_ipi_status_src  (sysio_core0_cp0_update_ipi_status_src  ),
  .sysio_core0_cp0_update_mailbox0_en     (sysio_core0_cp0_update_mailbox0_en     ),
  .sysio_core0_cp0_update_mailbox1_en     (sysio_core0_cp0_update_mailbox1_en     ),
  .sysio_core0_cp0_update_mailbox2_en     (sysio_core0_cp0_update_mailbox2_en     ),
  .sysio_core0_cp0_update_mailbox3_en     (sysio_core0_cp0_update_mailbox3_en     ),
  .sysio_core0_cp0_req_grnt               (sysio_core0_cp0_req_grnt               ),
  .sysio_core0_cp0_update_bit_sel         (sysio_core0_cp0_update_bit_sel         ),
  .sysio_core0_cp0_update_mailbox_src0    (sysio_core0_cp0_update_mailbox_src0    ),
  .sysio_core0_cp0_update_mailbox_src1    (sysio_core0_cp0_update_mailbox_src1    ),
  .sysio_core0_cp0_update_mailbox_src2    (sysio_core0_cp0_update_mailbox_src2    ),
  .sysio_core0_cp0_update_mailbox_src3    (sysio_core0_cp0_update_mailbox_src3    ),
  .sysio_core0_cp0_update_mailbox_mask0   (sysio_core0_cp0_update_mailbox_mask0   ),
  .sysio_core0_cp0_update_mailbox_mask1   (sysio_core0_cp0_update_mailbox_mask1   ),
  .sysio_core0_cp0_update_mailbox_mask2   (sysio_core0_cp0_update_mailbox_mask2   ),
  .sysio_core0_cp0_update_mailbox_mask3   (sysio_core0_cp0_update_mailbox_mask3   ),
  .core1_sysio_wr_req                     (core1_sysio_wr_req                     ),
  .core1_sysio_wr_sel                     (core1_sysio_wr_sel                     ),
  .core1_sysio_wr_ipi_send_data           (core1_sysio_wr_ipi_send_data           ),
  .core1_sysio_wr_mail_box_send_data      (core1_sysio_wr_mail_box_send_data      ),
  .core1_sysio_mailbox0_data              (core1_sysio_mailbox0_data              ),
  .sysio_core1_cp0_update_ipi_status_en   (sysio_core1_cp0_update_ipi_status_en   ),
  .sysio_core1_cp0_update_ipi_status_src  (sysio_core1_cp0_update_ipi_status_src  ),
  .sysio_core1_cp0_update_mailbox0_en     (sysio_core1_cp0_update_mailbox0_en     ),
  .sysio_core1_cp0_update_mailbox1_en     (sysio_core1_cp0_update_mailbox1_en     ),
  .sysio_core1_cp0_update_mailbox2_en     (sysio_core1_cp0_update_mailbox2_en     ),
  .sysio_core1_cp0_update_mailbox3_en     (sysio_core1_cp0_update_mailbox3_en     ),
  .sysio_core1_cp0_req_grnt               (sysio_core1_cp0_req_grnt               ),
  .sysio_core1_cp0_update_bit_sel         (sysio_core1_cp0_update_bit_sel         ),
  .sysio_core1_cp0_update_mailbox_src0    (sysio_core1_cp0_update_mailbox_src0    ),
  .sysio_core1_cp0_update_mailbox_src1    (sysio_core1_cp0_update_mailbox_src1    ),
  .sysio_core1_cp0_update_mailbox_src2    (sysio_core1_cp0_update_mailbox_src2    ),
  .sysio_core1_cp0_update_mailbox_src3    (sysio_core1_cp0_update_mailbox_src3    ),
  .sysio_core1_cp0_update_mailbox_mask0   (sysio_core1_cp0_update_mailbox_mask0   ),
  .sysio_core1_cp0_update_mailbox_mask1   (sysio_core1_cp0_update_mailbox_mask1   ),
  .sysio_core1_cp0_update_mailbox_mask2   (sysio_core1_cp0_update_mailbox_mask2   ),
  .sysio_core1_cp0_update_mailbox_mask3   (sysio_core1_cp0_update_mailbox_mask3   ),
  .core2_sysio_wr_req                     (core2_sysio_wr_req                     ),
  .core2_sysio_wr_sel                     (core2_sysio_wr_sel                     ),
  .core2_sysio_wr_ipi_send_data           (core2_sysio_wr_ipi_send_data           ),
  .core2_sysio_wr_mail_box_send_data      (core2_sysio_wr_mail_box_send_data      ),
  .core2_sysio_mailbox0_data              (core2_sysio_mailbox0_data              ),
  .sysio_core2_cp0_update_ipi_status_en   (sysio_core2_cp0_update_ipi_status_en   ),
  .sysio_core2_cp0_update_ipi_status_src  (sysio_core2_cp0_update_ipi_status_src  ),
  .sysio_core2_cp0_update_mailbox0_en     (sysio_core2_cp0_update_mailbox0_en     ),
  .sysio_core2_cp0_update_mailbox1_en     (sysio_core2_cp0_update_mailbox1_en     ),
  .sysio_core2_cp0_update_mailbox2_en     (sysio_core2_cp0_update_mailbox2_en     ),
  .sysio_core2_cp0_update_mailbox3_en     (sysio_core2_cp0_update_mailbox3_en     ),
  .sysio_core2_cp0_req_grnt               (sysio_core2_cp0_req_grnt               ),
  .sysio_core2_cp0_update_bit_sel         (sysio_core2_cp0_update_bit_sel         ),
  .sysio_core2_cp0_update_mailbox_src0    (sysio_core2_cp0_update_mailbox_src0    ),
  .sysio_core2_cp0_update_mailbox_src1    (sysio_core2_cp0_update_mailbox_src1    ),
  .sysio_core2_cp0_update_mailbox_src2    (sysio_core2_cp0_update_mailbox_src2    ),
  .sysio_core2_cp0_update_mailbox_src3    (sysio_core2_cp0_update_mailbox_src3    ),
  .sysio_core2_cp0_update_mailbox_mask0   (sysio_core2_cp0_update_mailbox_mask0   ),
  .sysio_core2_cp0_update_mailbox_mask1   (sysio_core2_cp0_update_mailbox_mask1   ),
  .sysio_core2_cp0_update_mailbox_mask2   (sysio_core2_cp0_update_mailbox_mask2   ),
  .sysio_core2_cp0_update_mailbox_mask3   (sysio_core2_cp0_update_mailbox_mask3   ),
  .core3_sysio_wr_req                     (core3_sysio_wr_req                     ),
  .core3_sysio_wr_sel                     (core3_sysio_wr_sel                     ),
  .core3_sysio_wr_ipi_send_data           (core3_sysio_wr_ipi_send_data           ),
  .core3_sysio_wr_mail_box_send_data      (core3_sysio_wr_mail_box_send_data      ),
  .core3_sysio_mailbox0_data              (core3_sysio_mailbox0_data              ),
  .sysio_core3_cp0_update_ipi_status_en   (sysio_core3_cp0_update_ipi_status_en   ),
  .sysio_core3_cp0_update_ipi_status_src  (sysio_core3_cp0_update_ipi_status_src  ),
  .sysio_core3_cp0_update_mailbox0_en     (sysio_core3_cp0_update_mailbox0_en     ),
  .sysio_core3_cp0_update_mailbox1_en     (sysio_core3_cp0_update_mailbox1_en     ),
  .sysio_core3_cp0_update_mailbox2_en     (sysio_core3_cp0_update_mailbox2_en     ),
  .sysio_core3_cp0_update_mailbox3_en     (sysio_core3_cp0_update_mailbox3_en     ),
  .sysio_core3_cp0_req_grnt               (sysio_core3_cp0_req_grnt               ),
  .sysio_core3_cp0_update_bit_sel         (sysio_core3_cp0_update_bit_sel         ),
  .sysio_core3_cp0_update_mailbox_src0    (sysio_core3_cp0_update_mailbox_src0    ),
  .sysio_core3_cp0_update_mailbox_src1    (sysio_core3_cp0_update_mailbox_src1    ),
  .sysio_core3_cp0_update_mailbox_src2    (sysio_core3_cp0_update_mailbox_src2    ),
  .sysio_core3_cp0_update_mailbox_src3    (sysio_core3_cp0_update_mailbox_src3    ),
  .sysio_core3_cp0_update_mailbox_mask0   (sysio_core3_cp0_update_mailbox_mask0   ),
  .sysio_core3_cp0_update_mailbox_mask1   (sysio_core3_cp0_update_mailbox_mask1   ),
  .sysio_core3_cp0_update_mailbox_mask2   (sysio_core3_cp0_update_mailbox_mask2   ),
  .sysio_core3_cp0_update_mailbox_mask3   (sysio_core3_cp0_update_mailbox_mask3   ),
  .ext_interrupt                          (ext_interrupt                          ),
  .clint_core0_ms_int                     (clint_core0_ms_int                     ),
  .clint_core0_mt_int                     (clint_core0_mt_int                     ),
  .clint_core0_ss_int                     (clint_core0_ss_int                     ),
  .clint_core0_st_int                     (clint_core0_st_int                     ),
  .clint_core1_ms_int                     (clint_core1_ms_int                     ),
  .clint_core1_mt_int                     (clint_core1_mt_int                     ),
  .clint_core1_ss_int                     (clint_core1_ss_int                     ),
  .clint_core1_st_int                     (clint_core1_st_int                     ),
  .core0_pad_jdb_pm                       (core0_pad_jdb_pm                       ),
  .core0_pad_lpmd_b                       (core0_pad_lpmd_b                       ),
  .core1_pad_jdb_pm                       (core1_pad_jdb_pm                       ),
  .core1_pad_lpmd_b                       (core1_pad_lpmd_b                       ),
  .core2_pad_jdb_pm                       (core2_pad_jdb_pm                       ),
  .core2_pad_lpmd_b                       (core2_pad_lpmd_b                       ),
  .core3_pad_jdb_pm                       (core3_pad_jdb_pm                       ),
  .core3_pad_lpmd_b                       (core3_pad_lpmd_b                       ),
  .cpu_pad_l2cache_flush_done             (cpu_pad_l2cache_flush_done             ),
  .cpu_pad_no_op                          (cpu_pad_no_op                          ),
  .cpurst_b                               (cpurst_b                               ),
  .forever_cpuclk                         (forever_cpuclk                         ),
  .l2c_sysio_flush_done                   (l2c_sysio_flush_done                   ),
  .l2c_sysio_flush_idle                   (l2c_sysio_flush_idle                   ),
  .pad_core0_dbg_mask                     (pad_core0_dbg_mask                     ),
  .pad_core0_dbgrq_b                      (pad_core0_dbgrq_b                      ),
  .pad_core1_dbg_mask                     (pad_core1_dbg_mask                     ),
  .pad_core1_dbgrq_b                      (pad_core1_dbgrq_b                      ),
  .pad_cpu_apb_base                       (pad_cpu_apb_base                       ),
  .pad_cpu_l2cache_flush_req              (pad_cpu_l2cache_flush_req              ),
  .pad_cpu_sys_cnt                        (pad_cpu_sys_cnt                        ),
  .pad_yy_icg_scan_en                     (pad_yy_icg_scan_en                     ),
  .piu0_sysio_jdb_pm                      (piu0_sysio_jdb_pm                      ),
  .piu0_sysio_lpmd_b                      (piu0_sysio_lpmd_b                      ),
  .piu1_sysio_jdb_pm                      (piu1_sysio_jdb_pm                      ),
  .piu1_sysio_lpmd_b                      (piu1_sysio_lpmd_b                      ),
  .plic_core0_me_int                      (plic_core0_me_int                      ),
  .plic_core0_se_int                      (plic_core0_se_int                      ),
  .plic_core1_me_int                      (plic_core1_me_int                      ),
  .plic_core1_se_int                      (plic_core1_se_int                      ),
  .sysio_ciu_apb_base                     (sysio_ciu_apb_base                     ),
  .sysio_clint_mtime                      (sysio_clint_mtime                      ),
  .sysio_had_dbg_mask                     (sysio_had_dbg_mask                     ),
  .sysio_l2c_flush_req                    (sysio_l2c_flush_req                    ),
  .sysio_piu0_dbgrq_b                     (sysio_piu0_dbgrq_b                     ),
  .sysio_piu0_ex_int                      (sysio_piu0_ex_int                      ),
  .sysio_piu0_me_int                      (sysio_piu0_me_int                      ),
  .sysio_piu0_ms_int                      (sysio_piu0_ms_int                      ),
  .sysio_piu0_mt_int                      (sysio_piu0_mt_int                      ),
  .sysio_piu0_se_int                      (sysio_piu0_se_int                      ),
  .sysio_piu0_ss_int                      (sysio_piu0_ss_int                      ),
  .sysio_piu0_st_int                      (sysio_piu0_st_int                      ),
  .sysio_piu1_dbgrq_b                     (sysio_piu1_dbgrq_b                     ),
  .sysio_piu1_ex_int                      (sysio_piu1_ex_int                      ),
  .sysio_piu1_me_int                      (sysio_piu1_me_int                      ),
  .sysio_piu1_ms_int                      (sysio_piu1_ms_int                      ),
  .sysio_piu1_mt_int                      (sysio_piu1_mt_int                      ),
  .sysio_piu1_se_int                      (sysio_piu1_se_int                      ),
  .sysio_piu1_ss_int                      (sysio_piu1_ss_int                      ),
  .sysio_piu1_st_int                      (sysio_piu1_st_int                      ),
  .sysio_piu2_dbgrq_b                     (sysio_piu2_dbgrq_b                     ),
  .sysio_piu2_ex_int                      (sysio_piu2_ex_int                      ),
  .sysio_piu2_me_int                      (sysio_piu2_me_int                      ),
  .sysio_piu2_ms_int                      (sysio_piu2_ms_int                      ),
  .sysio_piu2_mt_int                      (sysio_piu2_mt_int                      ),
  .sysio_piu2_se_int                      (sysio_piu2_se_int                      ),
  .sysio_piu2_ss_int                      (sysio_piu2_ss_int                      ),
  .sysio_piu2_st_int                      (sysio_piu2_st_int                      ),
  .sysio_piu3_dbgrq_b                     (sysio_piu3_dbgrq_b                     ),
  .sysio_piu3_ex_int                      (sysio_piu3_ex_int                      ),
  .sysio_piu3_me_int                      (sysio_piu3_me_int                      ),
  .sysio_piu3_ms_int                      (sysio_piu3_ms_int                      ),
  .sysio_piu3_mt_int                      (sysio_piu3_mt_int                      ),
  .sysio_piu3_se_int                      (sysio_piu3_se_int                      ),
  .sysio_piu3_ss_int                      (sysio_piu3_ss_int                      ),
  .sysio_piu3_st_int                      (sysio_piu3_st_int                      ),
  .sysio_xx_apb_base                      (sysio_xx_apb_base                      ),
  .sysio_xx_time                          (sysio_xx_time                          )
);

// &Connect(.axim_clk_en    (axim_clk_en_f)); @1516

//==========================================================
//          JTAG
//==========================================================

// &Instance("ct_had_common_top"); @1522
ct_had_common_top  x_ct_had_common_top (
  .apbif_had_pctrace_inv  (apbif_had_pctrace_inv ),
  .ciu_had_dbg_info       (ciu_had_dbg_info      ),
  .core0_dbg_ack_pc       (core0_dbg_ack_pc      ),
  .core0_enter_dbg_req_i  (core0_enter_dbg_req_i ),
  .core0_enter_dbg_req_o  (core0_enter_dbg_req_o ),
  .core0_exit_dbg_req_i   (core0_exit_dbg_req_i  ),
  .core0_exit_dbg_req_o   (core0_exit_dbg_req_o  ),
  .core0_had_dbg_mask     (core0_had_dbg_mask    ),
  .core0_regs_serial_data (core0_regs_serial_data),
  .core0_rst_b            (core0_rst_b           ),

  ///=======================================================///
  /// Core 1 (JTAG)
  .core1_dbg_ack_pc       (core1_dbg_ack_pc      ),
  .core1_enter_dbg_req_i  (core1_enter_dbg_req_i ),
  .core1_enter_dbg_req_o  (core1_enter_dbg_req_o ),
  .core1_exit_dbg_req_i   (core1_exit_dbg_req_i  ),
  .core1_exit_dbg_req_o   (core1_exit_dbg_req_o  ),
  .core1_had_dbg_mask     (core1_had_dbg_mask    ),
  .core1_regs_serial_data (core1_regs_serial_data),
  .core1_rst_b            (core1_rst_b           ),
  ///=======================================================///

  ///=======================================================///
  /// Core 2 (JTAG)
  .core2_dbg_ack_pc       (core2_dbg_ack_pc      ),
  .core2_enter_dbg_req_i  (core2_enter_dbg_req_i ),
  .core2_enter_dbg_req_o  (core2_enter_dbg_req_o ),
  .core2_exit_dbg_req_i   (core2_exit_dbg_req_i  ),
  .core2_exit_dbg_req_o   (core2_exit_dbg_req_o  ),
  .core2_had_dbg_mask     (core2_had_dbg_mask    ),
  .core2_regs_serial_data (core2_regs_serial_data),
  .core2_rst_b            (core2_rst_b           ),
  ///=======================================================///

  ///=======================================================///
  /// Core 3 (JTAG)
  .core3_dbg_ack_pc       (core3_dbg_ack_pc      ),
  .core3_enter_dbg_req_i  (core3_enter_dbg_req_i ),
  .core3_enter_dbg_req_o  (core3_enter_dbg_req_o ),
  .core3_exit_dbg_req_i   (core3_exit_dbg_req_i  ),
  .core3_exit_dbg_req_o   (core3_exit_dbg_req_o  ),
  .core3_had_dbg_mask     (core3_had_dbg_mask    ),
  .core3_regs_serial_data (core3_regs_serial_data),
  .core3_rst_b            (core3_rst_b           ),
  ///=======================================================///

  /// MISC
  .cpurst_b               (cpurst_b              ),
  .forever_cpuclk         (forever_cpuclk        ),
  .had_pad_jtg_tdo        (had_pad_jtg_tdo       ),
  .had_pad_jtg_tdo_en     (had_pad_jtg_tdo_en    ),
  .ir_corex_wdata         (ir_corex_wdata        ),
  .l2c_had_dbg_info       (l2c_had_dbg_info      ),
  .pad_had_jtg_tdi        (pad_had_jtg_tdi       ),
  .pad_had_jtg_tms        (pad_had_jtg_tms       ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .perr_had               (perr_had              ),
  .prdata_had             (prdata_had            ),
  .pready_had             (pready_had            ),
  .psel_had               (psel_had              ),
  .sm_update_dr           (sm_update_dr          ),
  .sm_update_ir           (sm_update_ir          ),
  .sysio_had_dbg_mask     (sysio_had_dbg_mask    ),
  .tclk                   (forever_jtgclk        ),
  .trst_b                 (trst_b                )
);

// &Connect(.forever_cpuclk(forever_cpuclk  ), @1523
//          .tclk          (forever_jtgclk  ), @1524
//          .cpurst_b      (cpurst_b        ), @1525
//          .trst_b        (trst_b          ) @1526
//         ); @1527

////scan chain
// &Force("input","pad_yy_scan_enable"); @1530
// //&Force("input","ct_top_si_1"); @1531
// //&Force("input","ct_top_si_2"); @1532
// //&Force("input","ct_top_si_3"); @1533
// //&Force("input","ct_top_si_4"); @1534
// //&Force("input","ct_top_si_5"); @1535
// //&Force("input","ct_top_si_6"); @1536
// //&Force("input","ct_top_si_7"); @1537
// //&Force("input","ct_top_si_8"); @1538
// //&Force("output","ct_top_so_1"); @1539
// //&Force("output","ct_top_so_2"); @1540
// //&Force("output","ct_top_so_3"); @1541
// //&Force("output","ct_top_so_4"); @1542
// //&Force("output","ct_top_so_5"); @1543
// //&Force("output","ct_top_so_6"); @1544
// //&Force("output","ct_top_so_7"); @1545
// //&Force("output","ct_top_so_8"); @1546
//
////occ signals 
// //  &Force("input", "ate_clock"); @1550
// //  &Force("input", "test_mode"); @1551
// //  &Force("input", "pll_bypass"); @1552
// //  &Force("input", "pll_reset"); @1553
// //  &Force("input", "scan_compression_enable"); @1554
// //  &Force("input", "wrp_si"); @1555
// //  &Force("input", "wrp_shift"); @1556
// //  &Force("input", "mode1"); @1557
// //  &Force("input", "mode2"); @1558
// //  &Force("input", "mode3"); @1559
// //  &Force("input", "wrp_clock"); @1560
// //  &Force("output", "wrp_so"); @1561
////&Shell("../../../tools/scripts/delt_top_port");

//==========================================================
//          coverage
//==========================================================
// &Instance("ct_coverage"); @1569


assign core2_cpu_no_retire = 1'b0;
assign core3_cpu_no_retire = 1'b0;
assign cpu_debug_port = core0_cpu_no_retire
                     || core1_cpu_no_retire
                     || core2_cpu_no_retire
                     || core3_cpu_no_retire;


// &ModuleEnd; @1597
endmodule



