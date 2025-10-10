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

// &ModuleBeg; @27
module aq_mmu_utlb (
  // &Ports, @28
  input    wire          arb_utlb_grant,
  input    wire          cp0_mmu_icg_en,
  input    wire          cp0_mmu_lpmd_req,
  input    wire          cp0_mmu_mxr,
  input    wire          cp0_mmu_satp_wen,
  input    wire          cp0_mmu_sum,
  input    wire  [26:0]  cp0_mmu_tlb_va,
  input    wire  [63:0]  cp0_mmu_dmw0,
  input    wire  [63:0]  cp0_mmu_dmw1,
  input    wire  [63:0]  cp0_mmu_dmw2,
  input    wire  [63:0]  cp0_mmu_dmw3,
  input    wire  [1 :0]  cp0_yy_priv_mode,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          hpcp_mmu_cnt_en,
  input    wire          jtlb_utlb_acc_err,
  input    wire          jtlb_utlb_pgflt,
  input    wire          jtlb_utlb_ref_cmplt,
  input    wire          jtlb_utlb_ref_pavld,
  input    wire          jtlb_xx_mmu_on,
  input    wire          jtlb_xx_ref_g,
  input    wire  [14:0]  jtlb_xx_ref_flg,
  input    wire  [15:0]  jtlb_xx_ref_asid,
  input    wire  [2 :0]  jtlb_xx_ref_pgs,
  input    wire  [27:0]  jtlb_xx_ref_ppn,
  input    wire  [27:0]  jtlb_xx_ref_vpn,
  input    wire  [1 :0]  lsu_mmu_priv_mode,
  input    wire          mmu_top_clk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          regs_mmu_en,
  input    wire  [15:0]  regs_ptw_cur_asid,
  input    wire          tlboper_xx_clr,
  input    wire          tlboper_xx_inv_va_req,
  input    wire          xxu_mmu_fetch,
  input    wire          xxu_mmu_abort,
  input    wire          xxu_mmu_exec,
  input    wire          xxu_mmu_read,
  input    wire  [51:0]  xxu_mmu_va,
  input    wire          xxu_mmu_va_vld,
  output   wire          mmu_xxu_access_fault,
  output   wire          mmu_xxu_buf,
  output   wire          mmu_xxu_ca,
  output   wire  [27:0]  mmu_xxu_pa,
  output   wire          mmu_xxu_pa_vld,
  output   wire          mmu_xxu_page_fault,
  output   wire          mmu_xxu_sec,
  output   wire          mmu_xxu_sh,
  output   wire          mmu_xxu_so,
  output   wire  [15:0]  utlb_arb_asid,
  output   wire          utlb_arb_cmplt,
  output   wire          utlb_arb_mach,
  output   wire  [1 :0]  utlb_arb_mode,
  output   wire          utlb_arb_read,
  output   wire          utlb_arb_req,
  output   wire  [27:0]  utlb_arb_vpn,
  output   wire          utlb_hpcp_utlb_miss,
  output   wire  [1 :0]  utlb_top_ref_cur_st
); 



// &Regs; @29
reg     [15:0]  ref_asid;              
reg     [1 :0]  ref_cur_st;            
reg     [1 :0]  ref_mode;              
reg     [1 :0]  ref_nxt_st;            
reg             ref_read;              
reg     [27:0]  ref_vpn;               
reg             utlb_miss;             
reg     [9 :0]  utlb_plru_read_hit;    

// &Wires; @30
wire            cp0_mach_mode;         
wire    [1 :0]  cp0_priv_mode;         
wire            cp0_supv_mode;         
wire            cp0_user_mode;         
wire    [14:0]  entry0_flg;            
wire            entry0_hit;            
wire            entry0_hit_dp;         
wire    [2 :0]  entry0_pgs;            
wire    [27:0]  entry0_ppn;            
wire            entry0_upd;            
wire            entry0_vld;            
wire    [14:0]  entry1_flg;            
wire            entry1_hit;            
wire            entry1_hit_dp;         
wire    [2 :0]  entry1_pgs;            
wire    [27:0]  entry1_ppn;            
wire            entry1_upd;            
wire            entry1_vld;            
wire    [14:0]  entry2_flg;            
wire            entry2_hit;            
wire            entry2_hit_dp;         
wire    [2 :0]  entry2_pgs;            
wire    [27:0]  entry2_ppn;            
wire            entry2_upd;            
wire            entry2_vld;            
wire    [14:0]  entry3_flg;            
wire            entry3_hit;            
wire            entry3_hit_dp;         
wire    [2 :0]  entry3_pgs;            
wire    [27:0]  entry3_ppn;            
wire            entry3_upd;            
wire            entry3_vld;            
wire    [14:0]  entry4_flg;            
wire            entry4_hit;            
wire            entry4_hit_dp;         
wire    [2 :0]  entry4_pgs;            
wire    [27:0]  entry4_ppn;            
wire            entry4_upd;            
wire            entry4_vld;            
wire    [14:0]  entry5_flg;            
wire            entry5_hit;            
wire            entry5_hit_dp;         
wire    [2 :0]  entry5_pgs;            
wire    [27:0]  entry5_ppn;            
wire            entry5_upd;            
wire            entry5_vld;            
wire    [14:0]  entry6_flg;            
wire            entry6_hit;            
wire            entry6_hit_dp;         
wire    [2 :0]  entry6_pgs;            
wire    [27:0]  entry6_ppn;            
wire            entry6_upd;            
wire            entry6_vld;            
wire    [14:0]  entry7_flg;            
wire            entry7_hit;            
wire            entry7_hit_dp;         
wire    [2 :0]  entry7_pgs;            
wire    [27:0]  entry7_ppn;            
wire            entry7_upd;            
wire            entry7_vld;            
wire    [14:0]  entry8_flg;            
wire            entry8_hit;            
wire            entry8_hit_dp;         
wire    [2 :0]  entry8_pgs;            
wire    [27:0]  entry8_ppn;            
wire            entry8_upd;            
wire            entry8_vld;            
wire    [14:0]  entry9_flg;            
wire            entry9_hit;            
wire            entry9_hit_dp;         
wire    [2 :0]  entry9_pgs;            
wire    [27:0]  entry9_ppn;            
wire            entry9_upd;            
wire            entry9_vld;            
wire    [9 :0]  entry_hit;             
wire    [9 :0]  entry_hit_dp;          
wire            plru_clk;              
wire            plru_upd_en;           
wire    [9 :0]  plru_utlb_ref_num;     
wire            utlb_buf;              
wire            utlb_ca;               
wire            utlb_clk_en;           
wire            utlb_deny;             
wire    [27:0]  utlb_entry_pa;         
wire    [14:0]  utlb_hit_flg;          
wire    [27:0]  utlb_hit_pa;           
wire    [2 :0]  utlb_hit_pgs;          
wire            utlb_hit_vld;          
wire    [27:0]  utlb_acc_pa;           
wire            utlb_miss_clk;         
wire            utlb_miss_cnt;         
wire            utlb_miss_req;         
wire            utlb_miss_vld;         
wire    [27:0]  utlb_miss_vpn;         
wire            utlb_off;              
wire            utlb_page_fault;       
wire            utlb_pavld;            
wire            utlb_plru_read_hit_vld; 
wire            utlb_plru_refill_on;   
wire            utlb_plru_refill_vld;  
wire            utlb_ref_abt;          
wire            utlb_ref_acflt;        
wire            utlb_ref_cmplt;        
wire            utlb_ref_idle;         
wire            utlb_ref_pavld;        
wire            utlb_ref_pgflt;        
wire            utlb_ref_wfc;          
wire            utlb_ref_wfg;          
wire    [27:0]  utlb_req_vpn;          
wire    [15:0]  utlb_req_asid;          
wire            utlb_sec;              
wire            utlb_sh;               
wire            utlb_so;               
wire            utlb_upd_g;               
wire    [14:0]  utlb_upd_flg;          
wire    [15:0]  utlb_upd_asid;          
wire            utlb_upd_mmu_on;       
wire    [2 :0]  utlb_upd_pgs;          
wire    [27:0]  utlb_upd_ppn;          
wire    [27:0]  utlb_upd_vpn;          
wire            utlb_va_illegal;       
wire            dutlb_so;
wire            dutlb_ca;
wire            dutlb_buf;
wire            dutlb_sh;
wire            dutlb_sec;
wire            iutlb_so;
wire            iutlb_ca;
wire            iutlb_buf;
wire            iutlb_sh;
wire            iutlb_sec;
wire            off_utlb_so;
wire            off_utlb_ca;
wire            off_utlb_buf;
wire            off_utlb_sh;
wire            off_utlb_sec;
wire            on_utlb_so;
wire            on_utlb_ca;
wire            on_utlb_buf;
wire            on_utlb_sh;
wire            on_utlb_sec;


//==========================================================
// parameters for value width
//==========================================================
parameter VPN_WIDTH  = 39-12;  // VPN
parameter PPN_WIDTH  = 40-12;  // PPN
parameter FLG_WIDTH  = 15;     // Flags
parameter PGS_WIDTH  = 3;      // Page Size
parameter ASID_WIDTH = 16;     // ASID
parameter VPN_PERLEL = 9;
parameter ENTRY_NUM  = 10;

//==========================================================
// I-uTLB:
// 1. 10-entry utlb 
// 2. translate Va to PA
// 3. visit jTLB when uTLB miss
// 4. refill uTLB with PLRU algorithm
//==========================================================

//==========================================================
//                  Gate Cell
//==========================================================
// TODO: Power Warning
assign utlb_clk_en = xxu_mmu_va_vld //&& !utlb_hit_vld
                  || !utlb_ref_idle
                  || utlb_miss;
// &Instance("gated_clk_cell", "x_utlb_gateclk"); @57
gated_clk_cell  x_utlb_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (utlb_miss_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (utlb_clk_en       ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @58
//           .external_en(1'b0          ), @59
//           .global_en  (1'b1          ), @60
//           .module_en  (cp0_mmu_icg_en), @61
//           .local_en   (utlb_clk_en   ), @62
//           .clk_out    (utlb_miss_clk ) @63
//          ); @64

//==========================================================
// 1. 10-entry utlb 
//==========================================================
assign utlb_req_vpn[PPN_WIDTH-1:0]   = xxu_mmu_va[PPN_WIDTH-1:0];
assign utlb_req_asid[ASID_WIDTH-1:0] = regs_ptw_cur_asid[ASID_WIDTH-1:0];

// &ConnRule(s/utlb_entry/entry0/); @71
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry0"); @72
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry0 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry0_flg           ),
  .utlb_entry_hit        (entry0_hit           ),
  .utlb_entry_hit_dp     (entry0_hit_dp        ),
  .utlb_entry_pgs        (entry0_pgs           ),
  .utlb_entry_ppn        (entry0_ppn           ),
  .utlb_entry_upd        (entry0_upd           ),
  .utlb_entry_vld        (entry0_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry1/); @74
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry1"); @75
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry1 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry1_flg           ),
  .utlb_entry_hit        (entry1_hit           ),
  .utlb_entry_hit_dp     (entry1_hit_dp        ),
  .utlb_entry_pgs        (entry1_pgs           ),
  .utlb_entry_ppn        (entry1_ppn           ),
  .utlb_entry_upd        (entry1_upd           ),
  .utlb_entry_vld        (entry1_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry2/); @77
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry2"); @78
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry2 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry2_flg           ),
  .utlb_entry_hit        (entry2_hit           ),
  .utlb_entry_hit_dp     (entry2_hit_dp        ),
  .utlb_entry_pgs        (entry2_pgs           ),
  .utlb_entry_ppn        (entry2_ppn           ),
  .utlb_entry_upd        (entry2_upd           ),
  .utlb_entry_vld        (entry2_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry3/); @80
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry3"); @81
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry3 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry3_flg           ),
  .utlb_entry_hit        (entry3_hit           ),
  .utlb_entry_hit_dp     (entry3_hit_dp        ),
  .utlb_entry_pgs        (entry3_pgs           ),
  .utlb_entry_ppn        (entry3_ppn           ),
  .utlb_entry_upd        (entry3_upd           ),
  .utlb_entry_vld        (entry3_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry4/); @83
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry4"); @84
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry4 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry4_flg           ),
  .utlb_entry_hit        (entry4_hit           ),
  .utlb_entry_hit_dp     (entry4_hit_dp        ),
  .utlb_entry_pgs        (entry4_pgs           ),
  .utlb_entry_ppn        (entry4_ppn           ),
  .utlb_entry_upd        (entry4_upd           ),
  .utlb_entry_vld        (entry4_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry5/); @86
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry5"); @87
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry5 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry5_flg           ),
  .utlb_entry_hit        (entry5_hit           ),
  .utlb_entry_hit_dp     (entry5_hit_dp        ),
  .utlb_entry_pgs        (entry5_pgs           ),
  .utlb_entry_ppn        (entry5_ppn           ),
  .utlb_entry_upd        (entry5_upd           ),
  .utlb_entry_vld        (entry5_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry6/); @89
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry6"); @90
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry6 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry6_flg           ),
  .utlb_entry_hit        (entry6_hit           ),
  .utlb_entry_hit_dp     (entry6_hit_dp        ),
  .utlb_entry_pgs        (entry6_pgs           ),
  .utlb_entry_ppn        (entry6_ppn           ),
  .utlb_entry_upd        (entry6_upd           ),
  .utlb_entry_vld        (entry6_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry7/); @92
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry7"); @93
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry7 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry7_flg           ),
  .utlb_entry_hit        (entry7_hit           ),
  .utlb_entry_hit_dp     (entry7_hit_dp        ),
  .utlb_entry_pgs        (entry7_pgs           ),
  .utlb_entry_ppn        (entry7_ppn           ),
  .utlb_entry_upd        (entry7_upd           ),
  .utlb_entry_vld        (entry7_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry8/); @95
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry8"); @96
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry8 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry8_flg           ),
  .utlb_entry_hit        (entry8_hit           ),
  .utlb_entry_hit_dp     (entry8_hit_dp        ),
  .utlb_entry_pgs        (entry8_pgs           ),
  .utlb_entry_ppn        (entry8_ppn           ),
  .utlb_entry_upd        (entry8_upd           ),
  .utlb_entry_vld        (entry8_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


// &ConnRule(s/utlb_entry/entry9/); @98
// &Instance("aq_mmu_utlb_entry","x_aq_mmu_utlb_entry9"); @99
aq_mmu_utlb_entry  x_aq_mmu_utlb_entry9 (
  .cp0_mach_mode         (cp0_mach_mode        ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cpurst_b              (cpurst_b             ),
  .mmu_top_clk           (mmu_top_clk          ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_entry_flg        (entry9_flg           ),
  .utlb_entry_hit        (entry9_hit           ),
  .utlb_entry_hit_dp     (entry9_hit_dp        ),
  .utlb_entry_pgs        (entry9_pgs           ),
  .utlb_entry_ppn        (entry9_ppn           ),
  .utlb_entry_upd        (entry9_upd           ),
  .utlb_entry_vld        (entry9_vld           ),
  .utlb_off              (utlb_off             ),
  .utlb_req_vpn          (utlb_req_vpn         ),
  .utlb_req_asid         (utlb_req_asid        ),
  .utlb_upd_flg          (utlb_upd_flg         ),
  .utlb_upd_g            (utlb_upd_g           ),
  .utlb_upd_asid         (utlb_upd_asid        ),
  .utlb_upd_mmu_on       (utlb_upd_mmu_on      ),
  .utlb_upd_pgs          (utlb_upd_pgs         ),
  .utlb_upd_ppn          (utlb_upd_ppn         ),
  .utlb_upd_vpn          (utlb_upd_vpn         )
);


//==========================================================
// 2. Access uTLB
// a. Read  Port: Entry hit infor
// b. Write Port: JTLB refill infor
// c. PLRU update for every access
//==========================================================

//==========================================================
// a. Read Port: entry hit infor
//==========================================================
assign entry_hit[9:0] = {entry9_hit, entry8_hit,
                         entry7_hit, entry6_hit, entry5_hit, entry4_hit,
                         entry3_hit, entry2_hit, entry1_hit, entry0_hit};

assign entry_hit_dp[9:0] = {entry9_hit_dp, entry8_hit_dp,
                            entry7_hit_dp, entry6_hit_dp, entry5_hit_dp, entry4_hit_dp,
                            entry3_hit_dp, entry2_hit_dp, entry1_hit_dp, entry0_hit_dp};

assign utlb_hit_vld  = |entry_hit[9:0];

//----------------------------------------------------------
// Physical Addr
//----------------------------------------------------------
assign utlb_entry_pa[PPN_WIDTH-1:0] = 
                  {PPN_WIDTH{entry_hit_dp[0]}} & entry0_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[1]}} & entry1_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[2]}} & entry2_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[3]}} & entry3_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[4]}} & entry4_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[5]}} & entry5_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[6]}} & entry6_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[7]}} & entry7_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[8]}} & entry8_ppn[PPN_WIDTH-1:0]
                | {PPN_WIDTH{entry_hit_dp[9]}} & entry9_ppn[PPN_WIDTH-1:0];

assign utlb_hit_pa[PPN_WIDTH-1:0] =  
     {PPN_WIDTH{utlb_hit_pgs[2]}} & {utlb_entry_pa[PPN_WIDTH-1:VPN_PERLEL*2], xxu_mmu_va[VPN_PERLEL*2-1:0]}
   | {PPN_WIDTH{utlb_hit_pgs[1]}} & {utlb_entry_pa[PPN_WIDTH-1:VPN_PERLEL*1], xxu_mmu_va[VPN_PERLEL*1-1:0]}
   | {PPN_WIDTH{utlb_hit_pgs[0]}} &  utlb_entry_pa[PPN_WIDTH-1:0];

//----------------------------------------------------------
// Page Size
//----------------------------------------------------------
assign utlb_hit_pgs[PGS_WIDTH-1:0] =  
                  {PGS_WIDTH{entry_hit_dp[0]}} & entry0_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[1]}} & entry1_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[2]}} & entry2_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[3]}} & entry3_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[4]}} & entry4_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[5]}} & entry5_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[6]}} & entry6_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[7]}} & entry7_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[8]}} & entry8_pgs[PGS_WIDTH-1:0]
                | {PGS_WIDTH{entry_hit_dp[9]}} & entry9_pgs[PGS_WIDTH-1:0];

//----------------------------------------------------------
// Flags
//----------------------------------------------------------
assign utlb_hit_flg[FLG_WIDTH-1:0] =  
                  {FLG_WIDTH{entry_hit_dp[0]}} & entry0_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[1]}} & entry1_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[2]}} & entry2_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[3]}} & entry3_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[4]}} & entry4_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[5]}} & entry5_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[6]}} & entry6_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[7]}} & entry7_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[8]}} & entry8_flg[FLG_WIDTH-1:0]
                | {FLG_WIDTH{entry_hit_dp[9]}} & entry9_flg[FLG_WIDTH-1:0];



assign on_utlb_so   = utlb_hit_flg[5:4] == 2'b00;
assign on_utlb_ca   = utlb_hit_flg[5:4] != 2'b00;
// assign on_utlb_buf  = on_utlb_so ? 1'b0 : on_utlb_ca ? 1'b1 : 1'b0;
assign on_utlb_buf  = 1'b0;
assign on_utlb_sh   = 1'b0;
assign on_utlb_sec  = 1'b1;

//----------------------------------------------------------
// Page Fault Check
//----------------------------------------------------------
// current privlidged mode
assign cp0_priv_mode[1:0] = xxu_mmu_exec ? cp0_yy_priv_mode[1:0]
                          : lsu_mmu_priv_mode[1:0];
assign cp0_user_mode      = cp0_priv_mode[1:0] == 2'b11;
assign cp0_supv_mode      = cp0_priv_mode[1:0] == 2'b01;
assign cp0_mach_mode      = cp0_priv_mode[1:0] == 2'b00;

// dmw0
wire dmw0_plv0 = cp0_mmu_dmw0[0];
wire dmw0_plv1 = cp0_mmu_dmw0[1];
wire dmw0_plv3 = cp0_mmu_dmw0[3];
wire [1:0] dmw0_mat = cp0_mmu_dmw0[5:4];

wire dmw0_pri_mode_hit = cp0_user_mode & dmw0_plv3
                         || cp0_supv_mode & dmw0_plv1
                         || cp0_mach_mode & dmw0_plv0;

wire dmw0_window_hit = xxu_mmu_va[51:48] == cp0_mmu_dmw0[63:60];

wire dmw0_hit = dmw0_pri_mode_hit && dmw0_window_hit;


// dmw1
wire dmw1_plv0 = cp0_mmu_dmw1[0];
wire dmw1_plv1 = cp0_mmu_dmw1[1];
wire dmw1_plv3 = cp0_mmu_dmw1[3];
wire [1:0] dmw1_mat = cp0_mmu_dmw1[5:4];

wire dmw1_pri_mode_hit =    cp0_user_mode & dmw1_plv3
                         || cp0_supv_mode & dmw1_plv1
                         || cp0_mach_mode & dmw1_plv0;

wire dmw1_window_hit = xxu_mmu_va[51:48] == cp0_mmu_dmw1[63:60];

wire dmw1_hit = dmw1_pri_mode_hit && dmw1_window_hit;

wire dmw_hit = dmw0_hit | dmw1_hit;

wire [1:0] dmw_mat = 
              {2{dmw0_hit           }} & dmw0_mat |
              {2{dmw1_hit &!dmw0_hit}} & dmw1_mat;

// utlb off when mmu off or machine mode
assign utlb_off  = !regs_mmu_en || dmw_hit;

// Check VA legal: VA[63:39] should be sign-extend of VA[38]
// assign utlb_va_illegal = (xxu_mmu_va[VPN_WIDTH-1] && !(&xxu_mmu_va[51:VPN_WIDTH])
//                      ||  !xxu_mmu_va[VPN_WIDTH-1] &&  (|xxu_mmu_va[51:VPN_WIDTH]))
//                           && !utlb_off && xxu_mmu_va_vld;

assign utlb_va_illegal = 1'b0;

// page fault when not valid
///  page flag info (Except G(Global))
///  page_flg[13]   = RPLV
///  page_flg[12]   = NX
///  page_flg[11]   = NR
///  page_flg[10]   = M (Modify)
///  page_flg[9]    = S (Special)
///  page_flg[8]    = W
///  page_flg[7]    = P
///  page_flg[6]    = H
///  page_flg[5:4]  = MAT
///  page_flg[3:2]  = PLV
///  page_flg[1]    = D
///  page_flg[0]    = V

assign utlb_page_fault = (!utlb_hit_flg[0]
// page fault when not writeable
                      || !utlb_hit_flg[8] && !xxu_mmu_read
// page fault when not executable
                      // || !utlb_hit_flg[3] && xxu_mmu_exec
// page fault when // User Mode
                      // || (!(utlb_hit_flg[5] && utlb_hit_flg[4]) && cp0_user_mode) 
                      ) && (utlb_hit_vld || utlb_off)
// page fault when tfatal and tmiss from jTLB
                      ||  utlb_ref_pgflt && !utlb_off
// page fault when ifu high va not legal
                      ||  utlb_va_illegal;

//----------------------------------------------------------
// I-UTLB Read Result
//----------------------------------------------------------
// Physical addr is valid when:
// 1. u-TLB hit 
assign utlb_pavld = xxu_mmu_va_vld && utlb_hit_vld
// 2. When mmu off, current cycle get ppn   
                 || utlb_off
// 3. Refill Page fault
                 || utlb_ref_pgflt
// 4. Refill Access Fault
                 || utlb_ref_acflt
// 5. VA is illegal
                 || xxu_mmu_va_vld && utlb_va_illegal;


// so: strong order, device = 1, other = 0(mem)
assign dutlb_so    = dmw_hit ? (dmw_mat[1:0] == 2'b0) : (utlb_hit_flg[5:4] == 2'b00);
assign dutlb_ca    = dmw_hit ? (dmw_mat[1:0] != 2'b0) : (utlb_hit_flg[5:4] != 2'b00);
// assign dutlb_buf   = dutlb_so ? 1'b0 : dutlb_ca ? 1'b1 : 1'b0; //when !so, always buf
assign dutlb_buf   = 1'b0;
assign dutlb_sh    = 1'b0;
assign dutlb_sec   = 1'b0;


// assign iutlb_so    = 1'b0;
// assign iutlb_ca    = utlb_hit_flg[5:4] != 2'b00 ;
assign iutlb_so    = dmw_hit ? (dmw_mat[1:0] == 2'b0) : (utlb_hit_flg[5:4] == 2'b00);
assign iutlb_ca    = dmw_hit ? (dmw_mat[1:0] != 2'b0) : (utlb_hit_flg[5:4] != 2'b00);
assign iutlb_buf   = 1'b0;
assign iutlb_sh    = 1'b0;
assign iutlb_sec   = 1'b1;

// T-Head Extend Flags
// pmas: strong order, cacheable, bufferable, shareable, security

assign off_utlb_so    = xxu_mmu_fetch ? iutlb_so  : dutlb_so;
assign off_utlb_ca    = xxu_mmu_fetch ? iutlb_ca  : dutlb_ca;
assign off_utlb_buf   = xxu_mmu_fetch ? iutlb_buf : dutlb_buf;
assign off_utlb_sh    = xxu_mmu_fetch ? iutlb_sh  : dutlb_sh;
assign off_utlb_sec   = xxu_mmu_fetch ? iutlb_sec : dutlb_sec;

// access deny when pmp check fail
assign utlb_deny  = 1'b0;

assign utlb_so  = utlb_off ? off_utlb_so  : on_utlb_so;
assign utlb_ca  = utlb_off ? off_utlb_ca  : on_utlb_ca;
assign utlb_buf = utlb_off ? off_utlb_buf : on_utlb_buf;
assign utlb_sh  = utlb_off ? off_utlb_sh  : on_utlb_sh;
assign utlb_sec = utlb_off ? off_utlb_sec : on_utlb_sec;

assign utlb_acc_pa[PPN_WIDTH-1:0] = utlb_off ? xxu_mmu_va[PPN_WIDTH-1:0] 
                                             : utlb_hit_pa[PPN_WIDTH-1:0];

//==========================================================
// b. Write Port: JTLB refill infor
//==========================================================
//----------------------------------------------------------
// Update Info to Entry
//----------------------------------------------------------
// refill utlb entry when refill cmplt with no expt
assign {entry9_upd,  entry8_upd,
        entry7_upd,  entry6_upd,  entry5_upd,  entry4_upd,
        entry3_upd,  entry2_upd,  entry1_upd,  entry0_upd}
                           = plru_utlb_ref_num[9:0] & {10{utlb_ref_pavld}};

// entry updt info
assign utlb_upd_vpn[PPN_WIDTH-1:0]   = jtlb_xx_ref_vpn[PPN_WIDTH-1:0];
assign utlb_upd_pgs[PGS_WIDTH-1:0]   = jtlb_xx_ref_pgs[PGS_WIDTH-1:0];
assign utlb_upd_ppn[PPN_WIDTH-1:0]   = jtlb_xx_ref_ppn[PPN_WIDTH-1:0];
assign utlb_upd_flg[FLG_WIDTH-1:0]   = jtlb_xx_ref_flg[FLG_WIDTH-1:0];   // PMP
assign utlb_upd_asid[ASID_WIDTH-1:0] = jtlb_xx_ref_asid[ASID_WIDTH-1:0];
assign utlb_upd_g                    = jtlb_xx_ref_g;
assign utlb_upd_mmu_on               = jtlb_xx_mmu_on;
                                     
//==========================================================
// c. PLRU update for every access
//==========================================================
//==========================================================
//                  uTLB Replacement Logic
//==========================================================
//----------------------------------------------------------
//                  uTLB Replacement Algorithm
//----------------------------------------------------------
// &ConnRule(s/^utlb/utlb/); @282
// &Instance("aq_mmu_plru","x_aq_mmu_plru"); @283
aq_mmu_plru  x_aq_mmu_plru (
  .cp0_mmu_icg_en         (cp0_mmu_icg_en        ),
  .cpurst_b               (cpurst_b              ),
  .entry0_vld             (entry0_vld            ),
  .entry1_vld             (entry1_vld            ),
  .entry2_vld             (entry2_vld            ),
  .entry3_vld             (entry3_vld            ),
  .entry4_vld             (entry4_vld            ),
  .entry5_vld             (entry5_vld            ),
  .entry6_vld             (entry6_vld            ),
  .entry7_vld             (entry7_vld            ),
  .entry8_vld             (entry8_vld            ),
  .entry9_vld             (entry9_vld            ),
  .forever_cpuclk         (forever_cpuclk        ),
  .pad_yy_icg_scan_en     (pad_yy_icg_scan_en    ),
  .plru_utlb_ref_num      (plru_utlb_ref_num     ),
  .utlb_plru_read_hit     (utlb_plru_read_hit    ),
  .utlb_plru_read_hit_vld (utlb_plru_read_hit_vld),
  .utlb_plru_refill_on    (utlb_plru_refill_on   ),
  .utlb_plru_refill_vld   (utlb_plru_refill_vld  )
);


assign utlb_plru_refill_on  = utlb_ref_wfc;
assign utlb_plru_refill_vld = utlb_ref_pavld;

// TODO for icg timing : NOTE hurt power
assign plru_upd_en = xxu_mmu_va_vld; // && (utlb_plru_read_hit[9:0] != entry_hit[9:0]);
// &Instance("gated_clk_cell", "x_utlb_plru_gateclk"); @290
gated_clk_cell  x_utlb_plru_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (plru_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (plru_upd_en       ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @291
//           .external_en(1'b0          ), @292
//           .global_en  (1'b1          ), @293
//           .module_en  (cp0_mmu_icg_en), @294
//           .local_en   (plru_upd_en   ), @295
//           .clk_out    (plru_clk      ) @296
//          ); @297

always @(posedge plru_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    utlb_plru_read_hit[9:0] <= 10'b0;
  else if(plru_upd_en)
    utlb_plru_read_hit[9:0] <= entry_hit[9:0];
end
assign utlb_plru_read_hit_vld = |utlb_plru_read_hit[9:0];


//==========================================================
// 3. Visit jTLB when uTLB miss
// a. Refill FSM
// b. uTLB Miss Req
// c. HPCP Counter
//==========================================================
//----------------------------------------------------------
// a. Refill FSM
//----------------------------------------------------------
// IDLE: default state
// WFC : wait utlb refill req to be granted
// WFC : wait utlb refill cmplt to refill utlb
// ABT : wait utlb refill cmplt when abort happened
parameter IDLE  = 2'b00,
          WFG   = 2'b01,
          WFC   = 2'b10,
          ABT   = 2'b11;

//  When utlb miss and mmu is enabled, utlb refill SM will
//  be started
assign utlb_miss_vld = xxu_mmu_va_vld && !utlb_hit_vld
                                      && !utlb_va_illegal
                                      && !utlb_off
                                      && !cp0_mmu_lpmd_req;

always @(posedge utlb_miss_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ref_cur_st[1:0] <= 2'b0;
  else
    ref_cur_st[1:0] <= ref_nxt_st[1:0];
end

// &CombBeg; @341
always @( ref_cur_st
       or utlb_miss_vld
       or xxu_mmu_abort
       or arb_utlb_grant
       or jtlb_utlb_ref_cmplt)
begin
case (ref_cur_st)
IDLE:
begin
  if(xxu_mmu_abort)
    ref_nxt_st[1:0] = IDLE;
  else if(utlb_miss_vld)
    ref_nxt_st[1:0] = WFG;
  else
    ref_nxt_st[1:0] = IDLE;
end
WFG:
begin
  if(arb_utlb_grant && xxu_mmu_abort)
    ref_nxt_st[1:0] = ABT;
  else if(xxu_mmu_abort)
    ref_nxt_st[1:0] = IDLE;
  else if(arb_utlb_grant)
    ref_nxt_st[1:0] = WFC;
  else
    ref_nxt_st[1:0] = WFG;
end
WFC:
begin
  if(jtlb_utlb_ref_cmplt)
    ref_nxt_st[1:0] = IDLE;
  else if(xxu_mmu_abort)
    ref_nxt_st[1:0] = ABT;
  else
    ref_nxt_st[1:0] = WFC;
end
ABT:
begin
  if(jtlb_utlb_ref_cmplt)
    ref_nxt_st[1:0] = IDLE;
  else
    ref_nxt_st[1:0] = ABT;
end
default:
begin
   ref_nxt_st[1:0] = IDLE;
end
endcase
// &CombEnd; @384
end

assign utlb_ref_idle   = ref_cur_st[1:0] == IDLE;
assign utlb_ref_wfg    = ref_cur_st[1:0] == WFG;
assign utlb_ref_wfc    = ref_cur_st[1:0] == WFC;
assign utlb_ref_abt    = ref_cur_st[1:0] == ABT;

assign utlb_ref_cmplt = utlb_ref_wfc && jtlb_utlb_ref_cmplt
                     || utlb_ref_abt && jtlb_utlb_ref_cmplt;
assign utlb_ref_pavld = utlb_ref_wfc && jtlb_utlb_ref_pavld;
assign utlb_ref_pgflt = utlb_ref_wfc && jtlb_utlb_pgflt;
assign utlb_ref_acflt = utlb_ref_wfc && jtlb_utlb_acc_err;

// miss vpn
always @(posedge utlb_miss_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    ref_vpn[PPN_WIDTH-1:0] <= {PPN_WIDTH{1'b0}};
    ref_read               <= 1'b0;
    ref_mode[1:0]          <= 2'b11;
    ref_asid[15:0]         <= 16'b0;
  end
  else if(utlb_miss_vld && utlb_ref_idle)
  begin
    /// xxu_mmu_va[35], va[47]
    ref_vpn[PPN_WIDTH-1:0] <= {xxu_mmu_va[35], xxu_mmu_va[PPN_WIDTH-2:0]};
    ref_read               <= !xxu_mmu_exec && xxu_mmu_read;
    /// use mmu enable, always access jtlb and ptw.
    // ref_mode[1:0]          <= cp0_priv_mode[1:0];
    ref_mode[1:0]          <= 2'b11;
    ref_asid[15:0]         <= regs_ptw_cur_asid[15:0];
  end
end

//----------------------------------------------------------
// b. uTLB Miss Req
//----------------------------------------------------------
// req only in IDLE, so utlb refill is blocking
assign utlb_miss_req                = utlb_ref_wfg;
assign utlb_miss_vpn[PPN_WIDTH-1:0] = ref_vpn[PPN_WIDTH-1:0];

//----------------------------------------------------------
// c. HPCP Counter
//----------------------------------------------------------
assign utlb_miss_cnt = utlb_ref_pavld && hpcp_mmu_cnt_en;

always @(posedge utlb_miss_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    utlb_miss <= 1'b0;
  else if(utlb_miss_cnt)
    utlb_miss <= 1'b1;
  else if(utlb_miss)
    utlb_miss <= 1'b0;
end

//==========================================================
// Rename for Output
//==========================================================

// Output to Arbiter
assign utlb_arb_req                = utlb_miss_req;
assign utlb_arb_vpn[PPN_WIDTH-1:0] = utlb_miss_vpn[PPN_WIDTH-1:0];
assign utlb_arb_cmplt              = utlb_ref_cmplt;
assign utlb_arb_read               = ref_read;


// assign utlb_arb_mach               = ref_mode[1:0] == 2'b11;
assign utlb_arb_mach               = 1'b0;
assign utlb_arb_mode[1:0]          = 2'b11;//ref_mode[1:0];
assign utlb_arb_asid[15:0]         = ref_asid[15:0];

// Output to top
assign utlb_top_ref_cur_st[1:0] = ref_cur_st[1:0];

// Output to XXU
assign mmu_xxu_pa_vld            = utlb_pavld;
assign mmu_xxu_pa[PPN_WIDTH-1:0] = utlb_acc_pa[PPN_WIDTH-1:0]; 
assign mmu_xxu_access_fault      = utlb_deny;
assign mmu_xxu_page_fault        = utlb_page_fault && !utlb_off;
assign mmu_xxu_so                = utlb_so;
assign mmu_xxu_ca                = utlb_ca;
assign mmu_xxu_buf               = utlb_buf; 
assign mmu_xxu_sh                = utlb_sh;
assign mmu_xxu_sec               = utlb_sec;

// Output to IFU
assign utlb_hpcp_utlb_miss = utlb_miss;


// &ModuleEnd; @483
endmodule


