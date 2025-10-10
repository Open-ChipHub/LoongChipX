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
module ct_mmu_dutlb_read (
  // &Ports, @24
  input    wire          biu_mmu_smp_disable,
  input    wire          cp0_mach_mode,
  input    wire          cp0_mmu_icg_en,
  input    wire          cp0_mmu_mxr,
  input    wire          cp0_mmu_sum,
  input    wire          cp0_supv_mode,
  input    wire          cp0_user_mode,
  input    wire  [1 :0]  cp0_yy_priv_mode,
  input    wire          cpurst_b,
  input    wire          dplru_clk,
  input    wire          dutlb_clk,
  input    wire          dutlb_expt_for_taken,
  input    wire          dutlb_off_hit,
  input    wire          dmw_hit,
  input    wire  [1 :0]  dmw_mat,
  input    wire          dutlb_ori_read_x,
  input    wire          dutlb_read_type_x,
  input    wire          dutlb_ref_acflt,
  input    wire          dutlb_ref_pgflt,
  input    wire          dutlb_refill_on_x,
  input    wire  [13:0]  entry0_flg,
  input    wire  [ 2:0]  entry0_pgs,
  input    wire          entry0_hit_x,
  input    wire  [27:0]  entry0_ppn,
  input    wire          entry0_vld,
  input    wire  [13:0]  entry10_flg,
  input    wire  [ 2:0]  entry10_pgs,
  input    wire          entry10_hit_x,
  input    wire  [27:0]  entry10_ppn,
  input    wire          entry10_vld,
  input    wire  [13:0]  entry11_flg,
  input    wire  [ 2:0]  entry11_pgs,
  input    wire          entry11_hit_x,
  input    wire  [27:0]  entry11_ppn,
  input    wire          entry11_vld,
  input    wire  [13:0]  entry12_flg,
  input    wire  [ 2:0]  entry12_pgs,
  input    wire          entry12_hit_x,
  input    wire  [27:0]  entry12_ppn,
  input    wire          entry12_vld,
  input    wire  [13:0]  entry13_flg,
  input    wire  [ 2:0]  entry13_pgs,
  input    wire          entry13_hit_x,
  input    wire  [27:0]  entry13_ppn,
  input    wire          entry13_vld,
  input    wire  [13:0]  entry14_flg,
  input    wire  [ 2:0]  entry14_pgs,
  input    wire          entry14_hit_x,
  input    wire  [27:0]  entry14_ppn,
  input    wire          entry14_vld,
  input    wire  [13:0]  entry15_flg,
  input    wire  [ 2:0]  entry15_pgs,
  input    wire          entry15_hit_x,
  input    wire  [27:0]  entry15_ppn,
  input    wire          entry15_vld,
  input    wire  [13:0]  entry1_flg,
  input    wire  [ 2:0]  entry1_pgs,
  input    wire          entry1_hit_x,
  input    wire  [27:0]  entry1_ppn,
  input    wire          entry1_vld,
  input    wire  [13:0]  entry2_flg,
  input    wire  [ 2:0]  entry2_pgs,
  input    wire          entry2_hit_x,
  input    wire  [27:0]  entry2_ppn,
  input    wire          entry2_vld,
  input    wire  [13:0]  entry3_flg,
  input    wire  [ 2:0]  entry3_pgs,
  input    wire          entry3_hit_x,
  input    wire  [27:0]  entry3_ppn,
  input    wire          entry3_vld,
  input    wire  [13:0]  entry4_flg,
  input    wire  [ 2:0]  entry4_pgs,
  input    wire          entry4_hit_x,
  input    wire  [27:0]  entry4_ppn,
  input    wire          entry4_vld,
  input    wire  [13:0]  entry5_flg,
  input    wire  [ 2:0]  entry5_pgs,
  input    wire          entry5_hit_x,
  input    wire  [27:0]  entry5_ppn,
  input    wire          entry5_vld,
  input    wire  [13:0]  entry6_flg,
  input    wire  [ 2:0]  entry6_pgs,
  input    wire          entry6_hit_x,
  input    wire  [27:0]  entry6_ppn,
  input    wire          entry6_vld,
  input    wire  [13:0]  entry7_flg,
  input    wire  [ 2:0]  entry7_pgs,
  input    wire          entry7_hit_x,
  input    wire  [27:0]  entry7_ppn,
  input    wire          entry7_vld,
  input    wire  [13:0]  entry8_flg,
  input    wire  [ 2:0]  entry8_pgs,
  input    wire          entry8_hit_x,
  input    wire  [27:0]  entry8_ppn,
  input    wire          entry8_vld,
  input    wire  [13:0]  entry9_flg,
  input    wire  [ 2:0]  entry9_pgs,
  input    wire          entry9_hit_x,
  input    wire  [27:0]  entry9_ppn,
  input    wire          entry9_vld,
  input    wire          forever_cpuclk,
  input    wire          lsu_mmu_abort_x,
  input    wire  [6 :0]  lsu_mmu_id_x,
  input    wire  [27:0]  lsu_mmu_stamo_pa_x,
  input    wire          lsu_mmu_stamo_vld_x,
  input    wire          lsu_mmu_va_vld_x,
  input    wire  [63:0]  lsu_mmu_va_x,
  input    wire  [27:0]  lsu_mmu_vabuf_x,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [3 :0]  pmp_mmu_flg_x,
  input    wire  [6 :0]  refill_id_flop,
  output   wire          dutlb_acc_flt_x,
  output   wire          dutlb_inst_id_match_x,
  output   wire          dutlb_inst_id_older_x,
  output   wire          dutlb_miss_vld_short_x,
  output   wire          dutlb_miss_vld_x,
  output   wire          dutlb_plru_read_hit_vld_x,
  output   reg   [15:0]  dutlb_plru_read_hit_x,
  output   wire          dutlb_va_chg_x,
  output   wire          mmu_lsu_access_fault_x,
  output   wire          mmu_lsu_buf_x,
  output   wire          mmu_lsu_ca_x,
  output   wire          mmu_lsu_pa_vld_x,
  output   wire  [27:0]  mmu_lsu_pa_x,
  output   wire          mmu_lsu_page_fault_x,
  output   wire          mmu_lsu_sec_x,
  output   wire          mmu_lsu_sh_x,
  output   wire          mmu_lsu_so_x,
  output   wire          mmu_lsu_stall_x,
  output   wire  [27:0]  mmu_pmp_pa_x,
  output   wire  [27:0]  mmu_sysmap_pa_x,
  output   wire  [27:0]  utlb_req_vpn_x
); 



// &Regs; @25
reg     [13:0]  dutlb_entry_flg;          
reg     [ 2:0]  dutlb_entry_pgs;          
reg     [27:0]  dutlb_entry_pa;           
reg     [27:0]  dutlb_pa_buf;             
reg             jtlb_acc_fault_flop;      
reg             pmp_flg_vld;              
reg             pmp_read_type;            

// &Wires; @26
wire            dutlb_addr_hit;           
wire            dutlb_disable_vld;        
wire    [15:0]  dutlb_entry_hit;          
wire            dutlb_entry_hit_vld;      
wire            dutlb_expt_match;         
wire    [13:0]  dutlb_fin_flg;            
wire    [27:0]  dutlb_fin_pa;             
wire    [2 :0]  dutlb_fin_pgs;            
wire            dutlb_hit_vld;            
wire            dutlb_inst_id_hit;        
wire    [13:0]  dutlb_off_flg;            
wire    [27:0]  dutlb_off_pa;             
wire    [2 :0]  dutlb_off_pgs;            
wire            dutlb_page_fault;         
wire            dutlb_pmp_chk_vld;        
wire    [13:0]  dutlb_pre_flg;            
wire    [27:0]  dutlb_pre_pa;             
wire    [2 :0]  dutlb_pre_pgs;            
wire            dutlb_pre_sel;            
wire            dutlb_req_id_older;       
wire            dutlb_va_illegal;         
wire            jtlb_acc_fault;           
wire            lsu_va_chg;                     
wire    [17:0]  pa_offset;                
wire            pabuf_clk;                
wire            pabuf_clk_en;             
wire    [15:0]  vpn_hit;                  
wire    [15:0]  vpn_vld;                  
wire    [27:0]  dutlb_entry_mix_pa;


parameter VPN_WIDTH = 39-12;  // VPN
parameter PPN_WIDTH = 40-12;  // PPN
parameter FLG_WIDTH = 14;     // Flags
parameter PGS_WIDTH = 3;      // Page Size
parameter VPN_PERLEL = 9;

//==========================================================
//                  Tranlation Related Signal
//==========================================================
//----------------------------------------------------------
//                  Addr Translation Cmplt
//----------------------------------------------------------
// 1. when utlb hit, return pvald to LSU
// 2. later utlb hit can bypass the previous utlb miss, but
//    later utlb miss must be blocking
assign dutlb_hit_vld = lsu_mmu_va_vld_x && dutlb_addr_hit;

// D-uTLB trans cmplt without addr match in utlb:
// 1. when mmu is not enabled
// 2. when cpu is in machine mode 
assign dutlb_disable_vld = lsu_mmu_va_vld_x && dutlb_off_hit;

//----------------------------------------------------------
//                  Interface to LSU
//----------------------------------------------------------
// Paddr is valid when:
// 1. utlb hit
// 2. mmu is disabled
// 4. expt happened when utlb refill and inst id match
assign mmu_lsu_pa_vld_x = dutlb_hit_vld
                     || dutlb_disable_vld
                     || dutlb_va_illegal
                     || dutlb_expt_match;
assign mmu_lsu_stall_x  = 1'b0;
assign mmu_lsu_pa_x[PPN_WIDTH-1:0] = dutlb_fin_pa[PPN_WIDTH-1:0]; 

// flags judgement
// pmas to lsu: bufferable, security, cacheable
wire fetch_strong_order = dmw_hit ? dmw_mat[1:0]==2'b0 : (dutlb_fin_flg[5:4] == 2'b00);

///  [0]: Strong Order, 0=mem, 1=device  
///  [1]: Cacheable,    0=Uncache, 1=cache  
///  [2]: Bufferable,   0=NO, 1=Can  
///  [3]: Shareable,    0=NO, 1=Can  
///  [4]: Security,     Dont Care  

assign mmu_lsu_so_x  = fetch_strong_order; // device = 1, other = 0(mem) 
assign mmu_lsu_ca_x  = (dutlb_fin_flg[5:4] != 2'b00) & ~fetch_strong_order;
assign mmu_lsu_buf_x = fetch_strong_order ? !fetch_strong_order : 1'b0;
assign mmu_lsu_sh_x  = 1'b1;
assign mmu_lsu_sec_x = 1'b0;

// R W X judgement, R and W are not used in I-uTLB
// page fault when not valid
// page fault when writeable but not readable
// page fault when load/store not match R/W
// page fault when supv access user region and vise versa
// page fault when A/D bit violation
// page fault when tfatal and tmiss from jTLB
// page fault when virtual address not legal
// &Force("bus", "lsu_mmu_va_x", 63, 0); @84

// assign dutlb_va_illegal = (lsu_mmu_va_x[VPN_WIDTH+11] && !(&lsu_mmu_va_x[63:VPN_WIDTH+12])
//                       ||  !lsu_mmu_va_x[VPN_WIDTH+11] &&  (|lsu_mmu_va_x[63:VPN_WIDTH+12]))
//                           && !dutlb_off_hit && lsu_mmu_va_vld_x;

assign dutlb_va_illegal = 1'b0;

///  ptw flag info (Except G(Global))
///  ptw_flg[13]   = RPLV
///  ptw_flg[12]   = NX
///  ptw_flg[11]   = NR
///  ptw_flg[10]   = M (Modify)
///  ptw_flg[9]    = S (Special)
///  ptw_flg[8]    = W
///  ptw_flg[7]    = P
///  ptw_flg[6]    = H
///  ptw_flg[5:4]  = MAT
///  ptw_flg[3:2]  = PLV
///  ptw_flg[1]    = D
///  ptw_flg[0]    = V

/// load/store page fault
assign dutlb_page_fault = ( !dutlb_fin_flg[0]
                          // || dutlb_fin_flg[11] && dutlb_fin_flg[8]     // NX & W
                          // || dutlb_fin_flg[11] && dutlb_read_type_x    // NX & Load
                          || !dutlb_fin_flg[8] && !dutlb_read_type_x   // !W & Store
                          // || (!(dutlb_fin_flg[5] && dutlb_fin_flg[4]) && cp0_user_mode) // User Mode
                          ) && dutlb_addr_hit
                        ||  dutlb_ref_pgflt && dutlb_refill_on_x
                           && dutlb_inst_id_hit
                        ||  dutlb_va_illegal;

assign mmu_lsu_page_fault_x = dutlb_page_fault && !dutlb_off_hit;

assign mmu_lsu_access_fault_x = 1'b0;

assign dutlb_acc_flt_x = jtlb_acc_fault_flop;


always @(posedge dplru_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    dutlb_plru_read_hit_x[15:0] <= 16'b0;
  else if(lsu_mmu_va_vld_x)
    dutlb_plru_read_hit_x[15:0] <= dutlb_entry_hit[15:0];
end

// &Force("output", "dutlb_plru_read_hit_x"); @124
assign dutlb_plru_read_hit_vld_x = |dutlb_plru_read_hit_x[15:0];

assign dutlb_miss_vld_x = lsu_mmu_va_vld_x
                     && !dutlb_entry_hit_vld
                     && !dutlb_va_illegal
                     && !lsu_mmu_abort_x
                     && !dutlb_off_hit;
assign dutlb_miss_vld_short_x = lsu_mmu_va_vld_x
                     && !dutlb_entry_hit_vld
                     && !dutlb_va_illegal
                     && !dutlb_off_hit;

// &Force("output", "dutlb_inst_id_match_x"); @137
assign dutlb_inst_id_hit     = (refill_id_flop[6:0] == lsu_mmu_id_x[6:0])
                                && lsu_mmu_va_vld_x;
assign dutlb_inst_id_match_x = dutlb_inst_id_hit && !lsu_mmu_abort_x;

// &Instance("ct_rtu_compare_iid","x_mmu_dutlb_read_compare_req_iid"); @142
ct_rtu_compare_iid  x_mmu_dutlb_read_compare_req_iid (
  .x_iid0              (lsu_mmu_id_x[6:0]  ),
  .x_iid0_older        (dutlb_req_id_older ),
  .x_iid1              (refill_id_flop[6:0])
);

// &Connect( .x_iid0         (lsu_mmu_id_x[6:0]), @143
//           .x_iid1         (refill_id_flop[6:0]), @144
//           .x_iid0_older   (dutlb_req_id_older)); @145
assign dutlb_inst_id_older_x = dutlb_req_id_older && lsu_mmu_va_vld_x
                            && !lsu_mmu_abort_x;

assign dutlb_expt_match = dutlb_expt_for_taken && dutlb_inst_id_hit;

//==============================================================================
//                  Data Path
//==============================================================================
//==========================================================
//                  VA Matching
//==========================================================
//----------------------------------------------------------
//                  uTLB Entry Matching
//----------------------------------------------------------
assign vpn_vld[15:0] = {entry15_vld, entry14_vld, entry13_vld, entry12_vld,
                        entry11_vld, entry10_vld, entry9_vld,  entry8_vld,
                        entry7_vld,  entry6_vld,  entry5_vld,  entry4_vld,
                        entry3_vld,  entry2_vld,  entry1_vld,  entry0_vld};

assign vpn_hit[15:0] ={entry15_hit_x, entry14_hit_x, entry13_hit_x, entry12_hit_x,
                       entry11_hit_x, entry10_hit_x, entry9_hit_x,  entry8_hit_x,
                       entry7_hit_x,  entry6_hit_x,  entry5_hit_x,  entry4_hit_x,
                       entry3_hit_x,  entry2_hit_x,  entry1_hit_x,  entry0_hit_x};

assign dutlb_entry_hit[15:0] = vpn_vld[15:0] & vpn_hit[15:0];

assign dutlb_entry_hit_vld   = |dutlb_entry_hit[15:0];

assign dutlb_addr_hit     = |dutlb_entry_hit[15:0];
//assign dutlb_entry_hit_x[15:0] = dutlb_entry_hit[15:0];


//==========================================================
//                  VA Matching
//==========================================================
//----------------------------------------------------------
//                  Selecting Info from uTLB
//----------------------------------------------------------
// &CombBeg; @185
always @( entry4_ppn[27:0]
       or entry1_ppn[27:0]
       or entry8_ppn[27:0]
       or dutlb_entry_hit[15:0]
       or entry13_ppn[27:0]
       or entry7_ppn[27:0]
       or entry10_ppn[27:0]
       or entry11_ppn[27:0]
       or entry0_ppn[27:0]
       or entry2_ppn[27:0]
       or entry3_ppn[27:0]
       or entry6_ppn[27:0]
       or entry5_ppn[27:0]
       or entry14_ppn[27:0]
       or entry15_ppn[27:0]
       or entry9_ppn[27:0]
       or entry12_ppn[27:0])
begin
case(dutlb_entry_hit[15:0])
  16'b0000000000000001: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry0_ppn[PPN_WIDTH-1:0];
  16'b0000000000000010: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry1_ppn[PPN_WIDTH-1:0];
  16'b0000000000000100: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry2_ppn[PPN_WIDTH-1:0];
  16'b0000000000001000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry3_ppn[PPN_WIDTH-1:0];
  16'b0000000000010000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry4_ppn[PPN_WIDTH-1:0];
  16'b0000000000100000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry5_ppn[PPN_WIDTH-1:0];
  16'b0000000001000000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry6_ppn[PPN_WIDTH-1:0];
  16'b0000000010000000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry7_ppn[PPN_WIDTH-1:0];
  16'b0000000100000000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry8_ppn[PPN_WIDTH-1:0];
  16'b0000001000000000: dutlb_entry_pa[PPN_WIDTH-1:0] =  entry9_ppn[PPN_WIDTH-1:0];
  16'b0000010000000000: dutlb_entry_pa[PPN_WIDTH-1:0] = entry10_ppn[PPN_WIDTH-1:0];
  16'b0000100000000000: dutlb_entry_pa[PPN_WIDTH-1:0] = entry11_ppn[PPN_WIDTH-1:0];
  16'b0001000000000000: dutlb_entry_pa[PPN_WIDTH-1:0] = entry12_ppn[PPN_WIDTH-1:0];
  16'b0010000000000000: dutlb_entry_pa[PPN_WIDTH-1:0] = entry13_ppn[PPN_WIDTH-1:0];
  16'b0100000000000000: dutlb_entry_pa[PPN_WIDTH-1:0] = entry14_ppn[PPN_WIDTH-1:0];
  16'b1000000000000000: dutlb_entry_pa[PPN_WIDTH-1:0] = entry15_ppn[PPN_WIDTH-1:0];
  default:              dutlb_entry_pa[PPN_WIDTH-1:0] = {PPN_WIDTH{1'b0}};
endcase
// &CombEnd; @205
end
// &CombBeg; @206
always @( entry5_flg[13:0]
       or entry2_flg[13:0]
       or dutlb_entry_hit[15:0]
       or entry9_flg[13:0]
       or entry14_flg[13:0]
       or entry12_flg[13:0]
       or entry13_flg[13:0]
       or entry6_flg[13:0]
       or entry1_flg[13:0]
       or entry10_flg[13:0]
       or entry11_flg[13:0]
       or entry7_flg[13:0]
       or entry15_flg[13:0]
       or entry0_flg[13:0]
       or entry4_flg[13:0]
       or entry3_flg[13:0]
       or entry8_flg[13:0])
begin
case(dutlb_entry_hit[15:0])
  16'b0000000000000001: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry0_flg[FLG_WIDTH-1:0];
  16'b0000000000000010: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry1_flg[FLG_WIDTH-1:0];
  16'b0000000000000100: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry2_flg[FLG_WIDTH-1:0];
  16'b0000000000001000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry3_flg[FLG_WIDTH-1:0];
  16'b0000000000010000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry4_flg[FLG_WIDTH-1:0];
  16'b0000000000100000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry5_flg[FLG_WIDTH-1:0];
  16'b0000000001000000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry6_flg[FLG_WIDTH-1:0];
  16'b0000000010000000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry7_flg[FLG_WIDTH-1:0];
  16'b0000000100000000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry8_flg[FLG_WIDTH-1:0];
  16'b0000001000000000: dutlb_entry_flg[FLG_WIDTH-1:0] =  entry9_flg[FLG_WIDTH-1:0];
  16'b0000010000000000: dutlb_entry_flg[FLG_WIDTH-1:0] = entry10_flg[FLG_WIDTH-1:0];
  16'b0000100000000000: dutlb_entry_flg[FLG_WIDTH-1:0] = entry11_flg[FLG_WIDTH-1:0];
  16'b0001000000000000: dutlb_entry_flg[FLG_WIDTH-1:0] = entry12_flg[FLG_WIDTH-1:0];
  16'b0010000000000000: dutlb_entry_flg[FLG_WIDTH-1:0] = entry13_flg[FLG_WIDTH-1:0];
  16'b0100000000000000: dutlb_entry_flg[FLG_WIDTH-1:0] = entry14_flg[FLG_WIDTH-1:0];
  16'b1000000000000000: dutlb_entry_flg[FLG_WIDTH-1:0] = entry15_flg[FLG_WIDTH-1:0];
  default:              dutlb_entry_flg[FLG_WIDTH-1:0] = {FLG_WIDTH{1'bx}};
endcase
// &CombEnd; @226
end

// &CombBeg; @207
always @( entry5_pgs[2:0]
       or entry2_pgs[2:0]
       or dutlb_entry_hit[15:0]
       or entry9_pgs[2:0]
       or entry14_pgs[2:0]
       or entry12_pgs[2:0]
       or entry13_pgs[2:0]
       or entry6_pgs[2:0]
       or entry1_pgs[2:0]
       or entry10_pgs[2:0]
       or entry11_pgs[2:0]
       or entry7_pgs[2:0]
       or entry15_pgs[2:0]
       or entry0_pgs[2:0]
       or entry4_pgs[2:0]
       or entry3_pgs[2:0]
       or entry8_pgs[2:0])
begin
case(dutlb_entry_hit[15:0])
  16'b0000000000000001: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry0_pgs[PGS_WIDTH-1:0];
  16'b0000000000000010: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry1_pgs[PGS_WIDTH-1:0];
  16'b0000000000000100: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry2_pgs[PGS_WIDTH-1:0];
  16'b0000000000001000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry3_pgs[PGS_WIDTH-1:0];
  16'b0000000000010000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry4_pgs[PGS_WIDTH-1:0];
  16'b0000000000100000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry5_pgs[PGS_WIDTH-1:0];
  16'b0000000001000000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry6_pgs[PGS_WIDTH-1:0];
  16'b0000000010000000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry7_pgs[PGS_WIDTH-1:0];
  16'b0000000100000000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry8_pgs[PGS_WIDTH-1:0];
  16'b0000001000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] =  entry9_pgs[PGS_WIDTH-1:0];
  16'b0000010000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] = entry10_pgs[PGS_WIDTH-1:0];
  16'b0000100000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] = entry11_pgs[PGS_WIDTH-1:0];
  16'b0001000000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] = entry12_pgs[PGS_WIDTH-1:0];
  16'b0010000000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] = entry13_pgs[PGS_WIDTH-1:0];
  16'b0100000000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] = entry14_pgs[PGS_WIDTH-1:0];
  16'b1000000000000000: dutlb_entry_pgs[PGS_WIDTH-1:0] = entry15_pgs[PGS_WIDTH-1:0];
  default:              dutlb_entry_pgs[PGS_WIDTH-1:0] = {PGS_WIDTH{1'bx}};
endcase
// &CombEnd; @227
end


// &Force("bus", "entry16_ppn", 27, 0); @228
assign pa_offset[VPN_PERLEL*2-1:0]  = lsu_mmu_va_x[VPN_PERLEL*2+11:12];
assign dutlb_pre_pa[PPN_WIDTH-1:0]  = lsu_mmu_stamo_vld_x ? lsu_mmu_stamo_pa_x[PPN_WIDTH-1:0]
                                      : dutlb_off_hit || !lsu_mmu_va_vld_x
                                         ? dutlb_off_pa[PPN_WIDTH-1:0]
                                         : {PPN_WIDTH{1'b0}};
assign dutlb_pre_flg[FLG_WIDTH-1:0] = dutlb_off_hit || !lsu_mmu_va_vld_x
                                      ? dutlb_off_flg[FLG_WIDTH-1:0]
                                      : {FLG_WIDTH{1'b0}};

// off sel
assign dutlb_pre_sel = dutlb_off_hit || !lsu_mmu_va_vld_x
                     || dutlb_va_illegal || dutlb_expt_match || lsu_mmu_stamo_vld_x;
// pa and flag when mmu is off

// In LoongArch, va[38]=1, stand for kernel space,
// when translating, set that as 0 
                                  // {2'b0, va[37:12]} 
assign dutlb_off_pa[PPN_WIDTH-1:0] = {2'b0, lsu_mmu_va_x[VPN_WIDTH+10:12]};
                                     

//    00, NX, XR, W, P, G, MAT, PLV, D, V
// assign iutlb_off_flg[FLG_WIDTH-1:0] = {2'b00, 2'b00, 3'b110, dmw_mat[1:0], 4'b0};
assign dutlb_off_flg[FLG_WIDTH-1:0] = {2'b00, 2'b00, 3'b110, dmw_mat[1:0],  cp0_yy_priv_mode[1:0], 2'b0};

// page size 4K when mmu is off
assign dutlb_off_pgs[PGS_WIDTH-1:0] = 3'b0;

assign dutlb_entry_mix_pa[PPN_WIDTH-1:0] =  
     {PPN_WIDTH{dutlb_entry_pgs[2]}} & {dutlb_entry_pa[PPN_WIDTH-1:VPN_PERLEL*2], pa_offset[VPN_PERLEL*2-1:0]}
   | {PPN_WIDTH{dutlb_entry_pgs[1]}} & {dutlb_entry_pa[PPN_WIDTH-1:VPN_PERLEL*1], pa_offset[VPN_PERLEL*1-1:0]}
   | {PPN_WIDTH{dutlb_entry_pgs[0]}} &  dutlb_entry_pa[PPN_WIDTH-1:0];

// off sel
assign dutlb_fin_pa[PPN_WIDTH-1:0]  = dutlb_pre_sel ? dutlb_pre_pa[PPN_WIDTH-1:0]
                                                    : dutlb_entry_mix_pa[PPN_WIDTH-1:0];
assign dutlb_fin_flg[FLG_WIDTH-1:0] = dutlb_pre_sel ? dutlb_pre_flg[FLG_WIDTH-1:0]
                                                    : dutlb_entry_flg[FLG_WIDTH-1:0];

//----------------------------------------------------------
//                  JTLB Access Fault
//----------------------------------------------------------
// to cut off the timing from dutlb abort to access fault
// assign jtlb_acc_fault = dutlb_ref_acflt && dutlb_refill_on_x && dutlb_inst_id_match_x; 
assign jtlb_acc_fault = 1'b0; 

always @(posedge dutlb_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    jtlb_acc_fault_flop <= 1'b0;
  else if(jtlb_acc_fault)
    jtlb_acc_fault_flop <= 1'b1;
  else
    jtlb_acc_fault_flop <= 1'b0;
end

//----------------------------------------------------------
//                  PMP Check
//----------------------------------------------------------
// to cut off the timing from final-pa to pmp check
// pa buffer clock
// va change signal
// &Force("input", "lsu_mmu_vabuf_x"); @285
// &Force("bus", "lsu_mmu_vabuf_x", 27,0); @286
assign lsu_va_chg = lsu_mmu_va_vld_x;
               // && (lsu_mmu_va_x[PPN_WIDTH+11:12] != lsu_mmu_vabuf_x[PPN_WIDTH-1:0]);
assign pabuf_clk_en = lsu_va_chg
                  || lsu_mmu_va_vld_x // && (pmp_read_type ^ dutlb_read_type_x)
                  || pmp_flg_vld ^ lsu_mmu_va_vld_x;
// &Instance("gated_clk_cell", "x_dutlb_pabuf_gateclk"); @292
gated_clk_cell  x_dutlb_pabuf_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (pabuf_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (pabuf_clk_en      ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk), @293
//           .external_en(1'b0          ), @294
//           .global_en  (1'b1          ), @295
//           .module_en  (cp0_mmu_icg_en), @296
//           .local_en   (pabuf_clk_en  ), @297
//           .clk_out    (pabuf_clk     ) @298
//          ); @299

assign dutlb_pmp_chk_vld = (dutlb_hit_vld || dutlb_disable_vld)
                        && !dutlb_page_fault;

always @(posedge pabuf_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pmp_flg_vld <= 1'b0;
  else if(dutlb_pmp_chk_vld)
    pmp_flg_vld <= 1'b1;
  else
    pmp_flg_vld <= 1'b0;
end
//assign pmp_flg_vld = 1'b1;

always @(posedge pabuf_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pmp_read_type <= 1'b0;
  else if(dutlb_pmp_chk_vld)
    pmp_read_type <= dutlb_read_type_x;
end

always @(posedge pabuf_clk)
begin
  if(dutlb_pmp_chk_vld)
    dutlb_pa_buf[PPN_WIDTH-1:0] <= dutlb_fin_pa[PPN_WIDTH-1:0];
end

assign dutlb_va_chg_x = lsu_va_chg;

assign mmu_pmp_pa_x[PPN_WIDTH-1:0] = dutlb_pa_buf[PPN_WIDTH-1:0];

/// select PGD, 48-bit virt addr
/// use lsu_mmu_va[47] judge if PGDH or PGDL
assign utlb_req_vpn_x[VPN_WIDTH:0] = {lsu_mmu_va_x[47], lsu_mmu_va_x[VPN_WIDTH+11:12]};

assign mmu_sysmap_pa_x[PPN_WIDTH-1:0] = lsu_mmu_va_x[VPN_WIDTH+12:12];

// &ModuleEnd; @337
endmodule


