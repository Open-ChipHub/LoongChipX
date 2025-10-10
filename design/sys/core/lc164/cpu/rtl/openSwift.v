/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

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

// &ModuleBeg; @50
module openSwift (
  input    wire           axim_clk_en,
  input    wire           pad_biu_arready,
  input    wire           pad_biu_awready,
  input    wire  [7  :0]  pad_biu_bid,
  input    wire  [1  :0]  pad_biu_bresp,
  input    wire           pad_biu_bvalid,
  input    wire  [127:0]  pad_biu_rdata,
  input    wire  [7  :0]  pad_biu_rid,
  input    wire           pad_biu_rlast,
  input    wire  [1  :0]  pad_biu_rresp,
  input    wire           pad_biu_rvalid,
  input    wire           pad_biu_wready,
  input    wire  [63 :0]  pad_cpu_apb_base,
  input    wire           pad_cpu_rst_b,
  input    wire  [63 :0]  pad_cpu_rvba,
  input    wire  [63 :0]  pad_cpu_sys_cnt,
  input    wire  [239:0]  pad_plic_int_cfg,
  input    wire  [239:0]  pad_plic_int_vld,
  input    wire           pad_yy_dft_clk_rst_b,
  input    wire           pad_yy_icg_scan_en,
  input    wire           pad_yy_mbist_mode,
  input    wire           pad_yy_scan_enable,
  input    wire           pad_yy_scan_mode,
  input    wire           pad_yy_scan_rst_b,
  input    wire           pll_core_cpuclk,
  input    wire           sys_apb_clk,
  input    wire           sys_apb_rst_b,
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
  output   wire           biu_pad_rready,
  output   wire  [127:0]  biu_pad_wdata,
  output   wire           biu_pad_wlast,
  output   wire  [15 :0]  biu_pad_wstrb,
  output   wire           biu_pad_wvalid,
  output   wire           core0_pad_halted,
  output   wire  [1  :0]  core0_pad_lpmd_b,
  output   wire           core0_pad_retire,
  output   wire  [63 :0]  core0_pad_retire_pc,
  output   wire           cpu_debug_port
); 



//&Ports;
// &Regs; @53
// &Wires; @54
wire             apb_clk;                         
wire             apb_clk_en;                      
wire             axim_clk_en_f;                   
wire             biu_ifu_arready;                 
wire    [127:0]  biu_ifu_rdata;                   
wire             biu_ifu_rid;                     
wire             biu_ifu_rlast;                   
wire    [1  :0]  biu_ifu_rresp;                   
wire             biu_ifu_rvalid;                  
wire             biu_lsu_arready;                 
wire             biu_lsu_no_op;                   
wire    [127:0]  biu_lsu_rdata;                   
wire    [3  :0]  biu_lsu_rid;                     
wire             biu_lsu_rlast;                   
wire    [1  :0]  biu_lsu_rresp;                   
wire             biu_lsu_rvalid;                  
wire             biu_lsu_stb_awready;             
wire             biu_lsu_stb_wready;              
wire             biu_lsu_vb_awready;              
wire             biu_lsu_vb_wready;               
wire             ciu_rst_b;                       
wire             clint_core0_ms_int;              
wire             clint_core0_mt_int;              
wire             clint_core0_ss_int;              
wire             clint_core0_st_int;              
wire    [63 :0]  clint_core0_time;                
wire             clkgen_rst_b;                    
wire             core0_cpu_no_retire;             
wire             core0_rst_b;                     
wire    [1  :0]  core0_sysio_lpmd_b;              
wire             cp0_biu_icg_en;                  
wire             forever_cpuclk;                  
wire    [39 :0]  ifu_biu_araddr;                  
wire    [1  :0]  ifu_biu_arburst;                 
wire    [3  :0]  ifu_biu_arcache;                 
wire             ifu_biu_arid;                    
wire    [1  :0]  ifu_biu_arlen;                   
wire    [2  :0]  ifu_biu_arprot;                  
wire    [2  :0]  ifu_biu_arsize;                  
wire             ifu_biu_arvalid;                 
wire             l2c_plic_ecc_int_vld;            
wire    [39 :0]  lsu_biu_araddr;                  
wire    [1  :0]  lsu_biu_arburst;                 
wire    [3  :0]  lsu_biu_arcache;                 
wire    [3  :0]  lsu_biu_arid;                    
wire    [1  :0]  lsu_biu_arlen;                   
wire    [2  :0]  lsu_biu_arprot;                  
wire    [2  :0]  lsu_biu_arsize;                  
wire             lsu_biu_aruser;                  
wire             lsu_biu_arvalid;                 
wire    [39 :0]  lsu_biu_stb_awaddr;              
wire    [1  :0]  lsu_biu_stb_awburst;             
wire    [3  :0]  lsu_biu_stb_awcache;             
wire    [1  :0]  lsu_biu_stb_awid;                
wire    [1  :0]  lsu_biu_stb_awlen;               
wire    [2  :0]  lsu_biu_stb_awprot;              
wire    [2  :0]  lsu_biu_stb_awsize;              
wire             lsu_biu_stb_awuser;              
wire             lsu_biu_stb_awvalid;             
wire    [127:0]  lsu_biu_stb_wdata;               
wire             lsu_biu_stb_wlast;               
wire    [15 :0]  lsu_biu_stb_wstrb;               
wire             lsu_biu_stb_wvalid;              
wire    [39 :0]  lsu_biu_vb_awaddr;               
wire    [1  :0]  lsu_biu_vb_awburst;              
wire    [3  :0]  lsu_biu_vb_awcache;              
wire    [3  :0]  lsu_biu_vb_awid;                 
wire    [1  :0]  lsu_biu_vb_awlen;                
wire    [2  :0]  lsu_biu_vb_awprot;               
wire    [2  :0]  lsu_biu_vb_awsize;               
wire             lsu_biu_vb_awvalid;              
wire    [127:0]  lsu_biu_vb_wdata;                
wire             lsu_biu_vb_wlast;                
wire    [15 :0]  lsu_biu_vb_wstrb;                
wire             lsu_biu_vb_wvalid;               
wire    [31 :0]  paddr;                           
wire             penable;                         
wire             perr_clint;                      
wire             perr_plic;                       
wire             plic_core0_me_int;               
wire             plic_core0_se_int;               
wire    [0  :0]  plic_hartx_mint_req;             
wire    [0  :0]  plic_hartx_sint_req;             
wire    [255:0]  plic_int_cfg;                    
wire    [255:0]  plic_int_vld;                    
wire    [1  :0]  pprot;                           
wire    [31 :0]  prdata_clint;                    
wire    [31 :0]  prdata_plic;                     
wire             pready_clint;                    
wire             pready_plic;                     
wire             psel_clint;                      
wire             psel_plic;                       
wire    [31 :0]  pwdata;                          
wire             pwrite;                          
wire             sync_sys_apb_rst_b;              
wire    [39 :0]  sysio_biu_apb_base;              
wire    [63 :0]  sysio_clint_mtime;               
wire    [2  :0]  sysio_core0_hartid;              
wire             sysio_core0_me_int;              
wire             sysio_core0_ms_int;              
wire             sysio_core0_mt_int;              
wire             sysio_core0_se_int;              
wire             sysio_core0_ss_int;              
wire             sysio_core0_st_int;              
wire    [39 :0]  sysio_cp0_apb_base;              
wire    [63 :0]  sysio_xx_rvba;                                 



//==========================================================
//  Instance top module
//==========================================================
// &Force("output", "core0_pad_lpmd_b"); @60
// &ConnRule(s/cpuio_/core0_/); @61
// &ConnRule(s/rtu_/core0_/); @62
// &ConnRule(s/vpu_/core0_/); @63
// //&ConnRule(s/^hpcp_/hpcp0_/); @64
// &ConnRule(s/^x_/core0_/); @65
// &Instance("aq_top", "x_aq_top_0"); @66
aq_top  x_aq_top_0 (
  .biu_ifu_arready                  (biu_ifu_arready                 ),
  .biu_ifu_rdata                    (biu_ifu_rdata                   ),
  .biu_ifu_rid                      (biu_ifu_rid                     ),
  .biu_ifu_rlast                    (biu_ifu_rlast                   ),
  .biu_ifu_rresp                    (biu_ifu_rresp                   ),
  .biu_ifu_rvalid                   (biu_ifu_rvalid                  ),
  .biu_lsu_arready                  (biu_lsu_arready                 ),
  .biu_lsu_no_op                    (biu_lsu_no_op                   ),
  .biu_lsu_rdata                    (biu_lsu_rdata                   ),
  .biu_lsu_rid                      (biu_lsu_rid                     ),
  .biu_lsu_rlast                    (biu_lsu_rlast                   ),
  .biu_lsu_rresp                    (biu_lsu_rresp                   ),
  .biu_lsu_rvalid                   (biu_lsu_rvalid                  ),
  .biu_lsu_stb_awready              (biu_lsu_stb_awready             ),
  .biu_lsu_stb_wready               (biu_lsu_stb_wready              ),
  .biu_lsu_vb_awready               (biu_lsu_vb_awready              ),
  .biu_lsu_vb_wready                (biu_lsu_vb_wready               ),
  .clint_cpuio_time                 (clint_core0_time                ),
  .ext_interrupt                    (ext_interrupt                   ),
  .cp0_biu_icg_en                   (cp0_biu_icg_en                  ),
  .cpuio_sysio_lpmd_b               (core0_sysio_lpmd_b              ),
  .cpurst_b                         (core0_rst_b                     ),
  .dtu_tdt_dm_halted                (                                ),
  .dtu_tdt_dm_havereset             (                                ),
  .dtu_tdt_dm_itr_done              (                                ),
  .dtu_tdt_dm_retire_debug_expt_vld (                                ),
  .dtu_tdt_dm_rx_data               (                                ),
  .dtu_tdt_dm_wr_ready              (                                ),
  .forever_cpuclk                   (forever_cpuclk                  ),
  .ifu_biu_araddr                   (ifu_biu_araddr                  ),
  .ifu_biu_arburst                  (ifu_biu_arburst                 ),
  .ifu_biu_arcache                  (ifu_biu_arcache                 ),
  .ifu_biu_arid                     (ifu_biu_arid                    ),
  .ifu_biu_arlen                    (ifu_biu_arlen                   ),
  .ifu_biu_arprot                   (ifu_biu_arprot                  ),
  .ifu_biu_arsize                   (ifu_biu_arsize                  ),
  .ifu_biu_arvalid                  (ifu_biu_arvalid                 ),
  .lsu_biu_araddr                   (lsu_biu_araddr                  ),
  .lsu_biu_arburst                  (lsu_biu_arburst                 ),
  .lsu_biu_arcache                  (lsu_biu_arcache                 ),
  .lsu_biu_arid                     (lsu_biu_arid                    ),
  .lsu_biu_arlen                    (lsu_biu_arlen                   ),
  .lsu_biu_arprot                   (lsu_biu_arprot                  ),
  .lsu_biu_arsize                   (lsu_biu_arsize                  ),
  .lsu_biu_aruser                   (lsu_biu_aruser                  ),
  .lsu_biu_arvalid                  (lsu_biu_arvalid                 ),
  .lsu_biu_stb_awaddr               (lsu_biu_stb_awaddr              ),
  .lsu_biu_stb_awburst              (lsu_biu_stb_awburst             ),
  .lsu_biu_stb_awcache              (lsu_biu_stb_awcache             ),
  .lsu_biu_stb_awid                 (lsu_biu_stb_awid                ),
  .lsu_biu_stb_awlen                (lsu_biu_stb_awlen               ),
  .lsu_biu_stb_awprot               (lsu_biu_stb_awprot              ),
  .lsu_biu_stb_awsize               (lsu_biu_stb_awsize              ),
  .lsu_biu_stb_awuser               (lsu_biu_stb_awuser              ),
  .lsu_biu_stb_awvalid              (lsu_biu_stb_awvalid             ),
  .lsu_biu_stb_wdata                (lsu_biu_stb_wdata               ),
  .lsu_biu_stb_wlast                (lsu_biu_stb_wlast               ),
  .lsu_biu_stb_wstrb                (lsu_biu_stb_wstrb               ),
  .lsu_biu_stb_wvalid               (lsu_biu_stb_wvalid              ),
  .lsu_biu_vb_awaddr                (lsu_biu_vb_awaddr               ),
  .lsu_biu_vb_awburst               (lsu_biu_vb_awburst              ),
  .lsu_biu_vb_awcache               (lsu_biu_vb_awcache              ),
  .lsu_biu_vb_awid                  (lsu_biu_vb_awid                 ),
  .lsu_biu_vb_awlen                 (lsu_biu_vb_awlen                ),
  .lsu_biu_vb_awprot                (lsu_biu_vb_awprot               ),
  .lsu_biu_vb_awsize                (lsu_biu_vb_awsize               ),
  .lsu_biu_vb_awvalid               (lsu_biu_vb_awvalid              ),
  .lsu_biu_vb_wdata                 (lsu_biu_vb_wdata                ),
  .lsu_biu_vb_wlast                 (lsu_biu_vb_wlast                ),
  .lsu_biu_vb_wstrb                 (lsu_biu_vb_wstrb                ),
  .lsu_biu_vb_wvalid                (lsu_biu_vb_wvalid               ),
  .pad_biu_coreid                   (sysio_core0_hartid              ),
  .pad_yy_icg_scan_en               (pad_yy_icg_scan_en              ),
  .pad_yy_scan_mode                 (pad_yy_scan_mode                ),
  .rtu_cpu_no_retire                (core0_cpu_no_retire             ),
  .rtu_pad_halted                   (core0_pad_halted                ),
  .rtu_pad_retire                   (core0_pad_retire                ),
  .rtu_pad_retire_pc                (core0_pad_retire_pc             ),
  .sys_apb_clk                      (sys_apb_clk                     ),
  .sys_apb_rst_b                    (sync_sys_apb_rst_b              ),
  .sysio_cp0_apb_base               (sysio_cp0_apb_base              ),
  .sysio_cpuio_me_int               (sysio_core0_me_int              ),
  .sysio_cpuio_ms_int               (sysio_core0_ms_int              ),
  .sysio_cpuio_mt_int               (sysio_core0_mt_int              ),
  .sysio_cpuio_se_int               (sysio_core0_se_int              ),
  .sysio_cpuio_ss_int               (sysio_core0_ss_int              ),
  .sysio_cpuio_st_int               (sysio_core0_st_int              ),
  .sysio_xx_rvba                    (sysio_xx_rvba                   ),
  .tdt_dm_dtu_ack_havereset         ('0                              ),
  .tdt_dm_dtu_async_halt_req        ('0                              ),
  .tdt_dm_dtu_halt_on_reset         ('0                              ),
  .tdt_dm_dtu_halt_req              ('0                              ),
  .tdt_dm_dtu_itr                   ('0                              ),
  .tdt_dm_dtu_itr_vld               ('0                              ),
  .tdt_dm_dtu_resume_req            ('0                              ),
  .tdt_dm_dtu_wdata                 ('0                              ),
  .tdt_dm_dtu_wr_flg                ('0                              ),
  .tdt_dm_dtu_wr_vld                ('0                              )
);

// &Connect(.cpurst_b           (core0_rst_b )); @67
// &Connect(.sys_apb_rst_b      (sync_sys_apb_rst_b)); @68
// &Connect(.pad_biu_coreid     (sysio_core0_hartid)); @69
// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @70

//==========================================================
//  Instance biu_top
//==========================================================
// &Instance("aq_biu_top"); @75
aq_biu_top  x_aq_biu_top (
  .apb_clk_en          (apb_clk_en         ),
  .axim_clk_en         (axim_clk_en_f      ),
  .biu_ifu_arready     (biu_ifu_arready    ),
  .biu_ifu_rdata       (biu_ifu_rdata      ),
  .biu_ifu_rid         (biu_ifu_rid        ),
  .biu_ifu_rlast       (biu_ifu_rlast      ),
  .biu_ifu_rresp       (biu_ifu_rresp      ),
  .biu_ifu_rvalid      (biu_ifu_rvalid     ),
  .biu_lsu_arready     (biu_lsu_arready    ),
  .biu_lsu_no_op       (biu_lsu_no_op      ),
  .biu_lsu_rdata       (biu_lsu_rdata      ),
  .biu_lsu_rid         (biu_lsu_rid        ),
  .biu_lsu_rlast       (biu_lsu_rlast      ),
  .biu_lsu_rresp       (biu_lsu_rresp      ),
  .biu_lsu_rvalid      (biu_lsu_rvalid     ),
  .biu_lsu_stb_awready (biu_lsu_stb_awready),
  .biu_lsu_stb_wready  (biu_lsu_stb_wready ),
  .biu_lsu_vb_awready  (biu_lsu_vb_awready ),
  .biu_lsu_vb_wready   (biu_lsu_vb_wready  ),
  .biu_pad_araddr      (biu_pad_araddr     ),
  .biu_pad_arburst     (biu_pad_arburst    ),
  .biu_pad_arcache     (biu_pad_arcache    ),
  .biu_pad_arid        (biu_pad_arid       ),
  .biu_pad_arlen       (biu_pad_arlen      ),
  .biu_pad_arlock      (biu_pad_arlock     ),
  .biu_pad_arprot      (biu_pad_arprot     ),
  .biu_pad_arsize      (biu_pad_arsize     ),
  .biu_pad_arvalid     (biu_pad_arvalid    ),
  .biu_pad_awaddr      (biu_pad_awaddr     ),
  .biu_pad_awburst     (biu_pad_awburst    ),
  .biu_pad_awcache     (biu_pad_awcache    ),
  .biu_pad_awid        (biu_pad_awid       ),
  .biu_pad_awlen       (biu_pad_awlen      ),
  .biu_pad_awlock      (biu_pad_awlock     ),
  .biu_pad_awprot      (biu_pad_awprot     ),
  .biu_pad_awsize      (biu_pad_awsize     ),
  .biu_pad_awvalid     (biu_pad_awvalid    ),
  .biu_pad_bready      (biu_pad_bready     ),
  .biu_pad_rready      (biu_pad_rready     ),
  .biu_pad_wdata       (biu_pad_wdata      ),
  .biu_pad_wlast       (biu_pad_wlast      ),
  .biu_pad_wstrb       (biu_pad_wstrb      ),
  .biu_pad_wvalid      (biu_pad_wvalid     ),
  .cp0_biu_icg_en      (cp0_biu_icg_en     ),
  .cpurst_b            (ciu_rst_b          ),
  .forever_cpuclk      (forever_cpuclk     ),
  .ifu_biu_araddr      (ifu_biu_araddr     ),
  .ifu_biu_arburst     (ifu_biu_arburst    ),
  .ifu_biu_arcache     (ifu_biu_arcache    ),
  .ifu_biu_arid        (ifu_biu_arid       ),
  .ifu_biu_arlen       (ifu_biu_arlen      ),
  .ifu_biu_arprot      (ifu_biu_arprot     ),
  .ifu_biu_arsize      (ifu_biu_arsize     ),
  .ifu_biu_arvalid     (ifu_biu_arvalid    ),
  .lsu_biu_araddr      (lsu_biu_araddr     ),
  .lsu_biu_arburst     (lsu_biu_arburst    ),
  .lsu_biu_arcache     (lsu_biu_arcache    ),
  .lsu_biu_arid        (lsu_biu_arid       ),
  .lsu_biu_arlen       (lsu_biu_arlen      ),
  .lsu_biu_arprot      (lsu_biu_arprot     ),
  .lsu_biu_arsize      (lsu_biu_arsize     ),
  .lsu_biu_aruser      (lsu_biu_aruser     ),
  .lsu_biu_arvalid     (lsu_biu_arvalid    ),
  .lsu_biu_stb_awaddr  (lsu_biu_stb_awaddr ),
  .lsu_biu_stb_awburst (lsu_biu_stb_awburst),
  .lsu_biu_stb_awcache (lsu_biu_stb_awcache),
  .lsu_biu_stb_awid    (lsu_biu_stb_awid   ),
  .lsu_biu_stb_awlen   (lsu_biu_stb_awlen  ),
  .lsu_biu_stb_awprot  (lsu_biu_stb_awprot ),
  .lsu_biu_stb_awsize  (lsu_biu_stb_awsize ),
  .lsu_biu_stb_awuser  (lsu_biu_stb_awuser ),
  .lsu_biu_stb_awvalid (lsu_biu_stb_awvalid),
  .lsu_biu_stb_wdata   (lsu_biu_stb_wdata  ),
  .lsu_biu_stb_wlast   (lsu_biu_stb_wlast  ),
  .lsu_biu_stb_wstrb   (lsu_biu_stb_wstrb  ),
  .lsu_biu_stb_wvalid  (lsu_biu_stb_wvalid ),
  .lsu_biu_vb_awaddr   (lsu_biu_vb_awaddr  ),
  .lsu_biu_vb_awburst  (lsu_biu_vb_awburst ),
  .lsu_biu_vb_awcache  (lsu_biu_vb_awcache ),
  .lsu_biu_vb_awid     (lsu_biu_vb_awid    ),
  .lsu_biu_vb_awlen    (lsu_biu_vb_awlen   ),
  .lsu_biu_vb_awprot   (lsu_biu_vb_awprot  ),
  .lsu_biu_vb_awsize   (lsu_biu_vb_awsize  ),
  .lsu_biu_vb_awvalid  (lsu_biu_vb_awvalid ),
  .lsu_biu_vb_wdata    (lsu_biu_vb_wdata   ),
  .lsu_biu_vb_wlast    (lsu_biu_vb_wlast   ),
  .lsu_biu_vb_wstrb    (lsu_biu_vb_wstrb   ),
  .lsu_biu_vb_wvalid   (lsu_biu_vb_wvalid  ),
  .pad_biu_arready     (pad_biu_arready    ),
  .pad_biu_awready     (pad_biu_awready    ),
  .pad_biu_bid         (pad_biu_bid        ),
  .pad_biu_bresp       (pad_biu_bresp      ),
  .pad_biu_bvalid      (pad_biu_bvalid     ),
  .pad_biu_rdata       (pad_biu_rdata      ),
  .pad_biu_rid         (pad_biu_rid        ),
  .pad_biu_rlast       (pad_biu_rlast      ),
  .pad_biu_rresp       (pad_biu_rresp      ),
  .pad_biu_rvalid      (pad_biu_rvalid     ),
  .pad_biu_wready      (pad_biu_wready     ),
  .pad_yy_icg_scan_en  (pad_yy_icg_scan_en ),
  .paddr               (paddr              ),
  .penable             (penable            ),
  .perr_clint          ('0                 ),
  .perr_plic           ('0                 ),
  .pprot               (pprot              ),
  .prdata_clint        ('0                 ),
  .prdata_plic         ('0                 ),
  .pready_clint        (1'b1               ),
  .pready_plic         (1'b1               ),
  .psel_clint          (                   ),
  .psel_plic           (                   ),
  .pwdata              (pwdata             ),
  .pwrite              (pwrite             ),
  .sysio_biu_apb_base  (sysio_biu_apb_base )
);

// &Connect(.axim_clk_en    (axim_clk_en_f)); @76
// &Connect(.cpurst_b       (ciu_rst_b )); @77
// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @78

//==========================================================
//  Instance aq_reset_top sub module 
//==========================================================
// &Instance("aq_mp_rst_top"); @83
aq_mp_rst_top  x_aq_mp_rst_top (
  .ciu_rst_b            (ciu_rst_b           ),
  .clkgen_rst_b         (clkgen_rst_b        ),
  .core0_rst_b          (core0_rst_b         ),
  .forever_cpuclk       (forever_cpuclk      ),
  .pad_cpu_rst_b        (pad_cpu_rst_b       ),
  .pad_yy_dft_clk_rst_b (pad_yy_dft_clk_rst_b),
  .pad_yy_mbist_mode    (pad_yy_mbist_mode   ),
  .pad_yy_scan_mode     (pad_yy_scan_mode    ),
  .pad_yy_scan_rst_b    (pad_yy_scan_rst_b   ),
  .sync_sys_apb_rst_b   (sync_sys_apb_rst_b  ),
  .sys_apb_clk          (sys_apb_clk         ),
  .sys_apb_rst_b        (sys_apb_rst_b       )
);


//==========================================================
//  Instance aq_clk_top sub module 
//==========================================================
// &Instance("aq_mp_clk_top"); @88
aq_mp_clk_top  x_aq_mp_clk_top (
  .apb_clk            (apb_clk           ),
  .apb_clk_en         (apb_clk_en        ),
  .axim_clk_en        (axim_clk_en       ),
  .axim_clk_en_f      (axim_clk_en_f     ),
  .clkgen_rst_b       (clkgen_rst_b      ),
  .forever_cpuclk     (forever_cpuclk    ),
  .pad_yy_scan_mode   (pad_yy_scan_mode  ),
  .pll_core_cpuclk    (pll_core_cpuclk   )
);

// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @89

//==========================================================
//         sysio
//==========================================================
// &Instance("aq_sysio_top"); @94
aq_sysio_top  x_aq_sysio_top (
  .apb_clk_en           (apb_clk_en          ),
  .axim_clk_en          (axim_clk_en_f       ),
  .clint_core0_ms_int   ('0                  ),
  .clint_core0_mt_int   ('0                  ),
  .clint_core0_ss_int   ('0                  ),
  .clint_core0_st_int   ('0                  ),
  .core0_pad_lpmd_b     (core0_pad_lpmd_b    ),
  .core0_sysio_lpmd_b   (core0_sysio_lpmd_b  ),
  .cpurst_b             (ciu_rst_b           ),
  .forever_cpuclk       (forever_cpuclk      ),
  .l2c_plic_ecc_int_vld (l2c_plic_ecc_int_vld),
  .pad_cpu_apb_base     (pad_cpu_apb_base    ),
  .pad_cpu_rvba         (pad_cpu_rvba        ),
  .pad_cpu_sys_cnt      (pad_cpu_sys_cnt     ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  ),
  .plic_core0_me_int    (plic_core0_me_int   ),
  .plic_core0_se_int    (plic_core0_se_int   ),
  .sysio_biu_apb_base   (sysio_biu_apb_base  ),
  .sysio_clint_mtime    (sysio_clint_mtime   ),
  .sysio_core0_hartid   (sysio_core0_hartid  ),
  
  .sysio_core0_me_int   (sysio_core0_me_int  ),
  .sysio_core0_se_int   (sysio_core0_se_int  ),
  
  .sysio_core0_ms_int   (sysio_core0_ms_int  ),
  .sysio_core0_mt_int   (sysio_core0_mt_int  ),
  .sysio_core0_ss_int   (sysio_core0_ss_int  ),
  .sysio_core0_st_int   (sysio_core0_st_int  ),

  .sysio_cp0_apb_base   (sysio_cp0_apb_base  ),
  .sysio_xx_rvba        (sysio_xx_rvba       )
);

// &Connect(.axim_clk_en    (axim_clk_en_f)); @95
// &Connect(.cpurst_b       (ciu_rst_b )); @96
// &Connect(.pad_yy_gate_clk_en_b(pad_yy_icg_scan_en)); @97

assign plic_int_vld[`PLIC_INT_NUM+15:0] = {pad_plic_int_vld[`PLIC_INT_NUM-1:0],14'b0,l2c_plic_ecc_int_vld,1'b0};
assign plic_int_cfg[`PLIC_INT_NUM+15:0] = {pad_plic_int_cfg[`PLIC_INT_NUM-1:0],16'b0};
// &Depend("plic_top_dummy.v"); @162

assign plic_core0_me_int  = 1'b0;
assign plic_core0_se_int  = 1'b0;

//==========================================================
//          coverage
//==========================================================
// &Instance("aq_coverage"); @204


//assign core1_cpu_no_retire = 1'b0;
//assign core2_cpu_no_retire = 1'b0;
//assign core3_cpu_no_retire = 1'b0;
//assign cpu_debug_port = core0_cpu_no_retire
//                     || core1_cpu_no_retire
//                     || core2_cpu_no_retire
//                     || core3_cpu_no_retire;
assign cpu_debug_port = core0_cpu_no_retire;


// &ModuleEnd; @233
endmodule



