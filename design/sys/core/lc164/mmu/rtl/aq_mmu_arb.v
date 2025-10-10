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

// &ModuleBeg; @28
module aq_mmu_arb (
  // &Ports, @29
  input    wire          cp0_mmu_icg_en,
  input    wire          cp0_mmu_lpmd_req,
  input    wire          cpurst_b,
  input    wire  [15:0]  dutlb_arb_asid,
  input    wire          dutlb_arb_cmplt,
  input    wire          dutlb_arb_mach,
  input    wire  [1 :0]  dutlb_arb_mode,
  input    wire          dutlb_arb_read,
  input    wire          dutlb_arb_req,
  input    wire  [27:0]  dutlb_arb_vpn,
  input    wire          forever_cpuclk,
  input    wire  [15:0]  iutlb_arb_asid,
  input    wire          iutlb_arb_cmplt,
  input    wire          iutlb_arb_mach,
  input    wire  [1 :0]  iutlb_arb_mode,
  input    wire          iutlb_arb_req,
  input    wire  [27:0]  iutlb_arb_vpn,
  input    wire          jtlb_arb_mach,
  input    wire          jtlb_arb_tc_miss,
  input    wire          jtlb_arb_tc_vld,
  input    wire  [27:0]  jtlb_arb_vpn,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [1 :0]  ptw_arb_bank_sel,
  input    wire  [43:0]  ptw_arb_data_din,
  input    wire  [1 :0]  ptw_arb_fifo_din,
  input    wire  [2 :0]  ptw_arb_pgs,
  input    wire          ptw_arb_req,
  input    wire  [47:0]  ptw_arb_tag_din,
  input    wire  [26:0]  ptw_arb_vpn,
  input    wire  [1 :0]  tlboper_arb_bank_sel,
  input    wire          tlboper_arb_cmp_va,
  input    wire  [43:0]  tlboper_arb_data_din,
  input    wire  [1 :0]  tlboper_arb_fifo_din,
  input    wire          tlboper_arb_fifo_write,
  input    wire  [8 :0]  tlboper_arb_idx,
  input    wire          tlboper_arb_idx_not_va,
  input    wire          tlboper_arb_req,
  input    wire  [47:0]  tlboper_arb_tag_din,
  input    wire  [26:0]  tlboper_arb_vpn,
  input    wire          tlboper_arb_write,
  input    wire          tlboper_xx_cmplt,
  input    wire  [2 :0]  tlboper_xx_pgs,
  output   wire          arb_dutlb_grant,
  output   wire          arb_iutlb_grant,
  output   wire          arb_jtlb_cmp_va,
  output   wire  [43:0]  arb_jtlb_data_din,
  output   wire          arb_jtlb_dutlb_on,
  output   wire  [1 :0]  arb_jtlb_fifo_din,
  output   wire          arb_jtlb_fifo_write,
  output   wire  [8 :0]  arb_jtlb_idx,
  output   wire          arb_jtlb_iutlb_on,
  output   wire          arb_jtlb_mach,
  output   wire          arb_jtlb_oper_on,
  output   wire  [2 :0]  arb_jtlb_pgs,
  output   wire          arb_jtlb_ptw_req,
  output   wire          arb_jtlb_req,
  output   wire  [47:0]  arb_jtlb_tag_din,
  output   wire  [27:0]  arb_jtlb_vpn,
  output   wire  [1 :0]  arb_jtlb_way_sel,
  output   wire          arb_jtlb_write,
  output   wire  [15:0]  arb_ptw_asid,
  output   wire          arb_ptw_dutlb_rd,
  output   wire          arb_ptw_dutlb_wr,
  output   wire          arb_ptw_grant,
  output   wire          arb_ptw_iutlb_on,
  output   wire  [1 :0]  arb_ptw_priv_mode,
  output   wire          arb_tlboper_grant,
  output   wire          arb_tlboper_read_idle,
  output   wire  [1 :0]  arb_top_cur_st,
  output   wire  [1 :0]  arb_top_read_st,
  output   wire          arb_top_tlboper_on,
  output   wire          mmu_yy_xx_no_op
); 



// &Regs; @30
reg     [1 :0]  arb_cur_st;            
reg     [1 :0]  arb_nxt_st;            
reg     [1 :0]  read_cur_st;           
reg     [1 :0]  read_nxt_st;           
reg             tlboper_on;            

// &Wires; @31
wire            arb_clk;               
wire            arb_clk_en;            
wire            arb_cmp_va;            
wire    [43:0]  arb_data_din;          
wire            arb_dutlb_st;          
wire    [1 :0]  arb_fifo_din;          
wire            arb_fifo_write;        
wire            arb_idle_st;           
wire    [8 :0]  arb_idx;               
wire            arb_iutlb_st;          
wire            arb_mach;              
wire    [2 :0]  arb_pgs;               
wire            arb_read_huge;         
wire            arb_req;               
wire            arb_sel_1g;            
wire            arb_sel_2m;            
wire            arb_sel_4k;            
wire    [47:0]  arb_tag_din;           
wire    [8 :0]  arb_va_index;          
wire    [27:0]  arb_vpn;               
wire    [1 :0]  arb_way_sel;           
wire            arb_write;             
wire            read_cur_2m;           
wire            read_cur_4k;           
wire            read_cur_idle;         
wire            tlboper_idx_not_va_sel; 
wire            utlb_mask;             


parameter VPN_WIDTH  = 39-12;  // VPN
parameter PPN_WIDTH  = 40-12;  // PPN
parameter FLG_WIDTH  = 16;     // Flags
parameter PGS_WIDTH  = 3;      // Page Size
parameter ASID_WIDTH = 16;     // Flags

// Valid + VPN + ASID + PageSize + Global
parameter TAG_WIDTH  = 1+VPN_WIDTH+ASID_WIDTH+PGS_WIDTH+1;  
parameter DATA_WIDTH = PPN_WIDTH+FLG_WIDTH;

//==========================================================
//                  Gate Cell
//==========================================================
assign arb_clk_en = iutlb_arb_req 
                 || dutlb_arb_req
                 || tlboper_arb_req
                 || !read_cur_idle
                 || utlb_mask;
// &Instance("gated_clk_cell", "x_jtlb_arb_gateclk"); @51
gated_clk_cell  x_jtlb_arb_gateclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (arb_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (arb_clk_en        ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (forever_cpuclk  ), @52
//           .external_en(1'b0            ), @53
//           .global_en  (1'b1            ), @54
//           .module_en  (cp0_mmu_icg_en  ), @55
//           .local_en   (arb_clk_en      ), @56
//           .clk_out    (arb_clk         ) @57
//          ); @58


//==============================================================================
//                  Control Path
//==============================================================================
//==========================================================
//                  Grant Siangl
//==========================================================
// &Force("output","arb_iutlb_grant"); @67
// &Force("output","arb_dutlb_grant"); @68
// &Force("output","arb_tlboper_grant"); @69
// &Force("output","arb_ptw_grant"); @70

assign arb_iutlb_grant = iutlb_arb_req
                     && !dutlb_arb_req
                     && !tlboper_arb_req
                     && !ptw_arb_req
                     && !utlb_mask;

assign arb_dutlb_grant = dutlb_arb_req
                     && !tlboper_arb_req
                     && !ptw_arb_req
                     && !utlb_mask;

assign arb_tlboper_grant = tlboper_arb_req
                     && !arb_ptw_grant
                     && arb_idle_st
                     && read_cur_idle;

assign arb_ptw_grant = ptw_arb_req 
                     && !tlboper_on;

assign arb_req       = arb_iutlb_grant
                    || arb_dutlb_grant
                    || arb_tlboper_grant
                    || arb_ptw_grant
                    || arb_read_huge && jtlb_arb_tc_vld && jtlb_arb_tc_miss;

//==========================================================
//                  Req Mask FSM
//==========================================================
parameter ARB_IDLE  = 2'b00,
          ARB_IUTLB = 2'b01,
          ARB_DUTLB = 2'b10;

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    arb_cur_st[1:0] <= ARB_IDLE;
  else
    arb_cur_st[1:0] <= arb_nxt_st[1:0];
end 

// &CombBeg; @112
always @( arb_cur_st[1:0]
       or arb_iutlb_grant
       or dutlb_arb_cmplt
       or iutlb_arb_cmplt
       or arb_dutlb_grant)
begin
case (arb_cur_st[1:0])
ARB_IDLE:
begin
  if(arb_iutlb_grant)
    arb_nxt_st[1:0] = ARB_IUTLB;
  else if(arb_dutlb_grant)
    arb_nxt_st[1:0] = ARB_DUTLB;
  else
    arb_nxt_st[1:0] = ARB_IDLE;
end
ARB_IUTLB:
begin
  if(iutlb_arb_cmplt)
    arb_nxt_st[1:0] = ARB_IDLE;
  else
    arb_nxt_st[1:0] = ARB_IUTLB;
end
ARB_DUTLB:
begin
  if(dutlb_arb_cmplt)
    arb_nxt_st[1:0] = ARB_IDLE;
  else
    arb_nxt_st[1:0] = ARB_DUTLB;
end
default:
begin
  arb_nxt_st[1:0] = ARB_IDLE;
end
endcase
// &CombEnd; @142
end

assign arb_idle_st  = arb_cur_st[1:0] == ARB_IDLE;
assign arb_iutlb_st = arb_cur_st[1:0] == ARB_IUTLB;
assign arb_dutlb_st = arb_cur_st[1:0] == ARB_DUTLB;

//==========================================================
// PTEs with different page sizes are mixed in JTLB.
// So the read of JTLB is split into three step:
// 1. Assume the requesting entry is 4K size
// 2. Assume the requesting entry is 2M size
// 3. Assume the requesting entry is 1G size
// After three steps, if still miss, there is a JTLB miss.
//==========================================================
//                  Read FSM
//==========================================================
parameter READ_IDLE = 2'b00,
          READ_4K   = 2'b01,
          READ_2M   = 2'b11,
          READ_1G   = 2'b10;

always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    read_cur_st[1:0] <= READ_IDLE;
  else
    read_cur_st[1:0] <= read_nxt_st[1:0];
end 

// &CombBeg; @171
always @( read_cur_st[1:0]
       or jtlb_arb_tc_miss
       or tlboper_arb_req
       or jtlb_arb_tc_vld
       or arb_cmp_va)
begin
case (read_cur_st[1:0])
  READ_IDLE:
  begin
    if(arb_cmp_va && !tlboper_arb_req)
      read_nxt_st[1:0] = READ_4K;
    else
      read_nxt_st[1:0] = READ_IDLE;
  end
  READ_4K:
  begin
    if(jtlb_arb_tc_vld)
      if(jtlb_arb_tc_miss)
        read_nxt_st[1:0] = READ_2M;
      else
        read_nxt_st[1:0] = READ_IDLE;
    else
      read_nxt_st[1:0] = READ_4K;
  end
  READ_2M:
  begin
    if(jtlb_arb_tc_vld)
      if(jtlb_arb_tc_miss)
        read_nxt_st[1:0] = READ_1G;
      else
        read_nxt_st[1:0] = READ_IDLE;
    else
      read_nxt_st[1:0] = READ_2M;
  end
  READ_1G:
  begin
    if(jtlb_arb_tc_vld)
      read_nxt_st[1:0] = READ_IDLE;
    else
      read_nxt_st[1:0] = READ_1G;
  end
  default: 
    read_nxt_st[1:0] = READ_IDLE;
endcase
// &CombEnd @210
end

assign read_cur_idle = read_cur_st[1:0] == READ_IDLE;
assign read_cur_4k   = read_cur_st[1:0] == READ_4K;
assign read_cur_2m   = read_cur_st[1:0] == READ_2M;
//assign read_cur_1g   = read_cur_st[1:0] == READ_1G;

// 1. tlboper(including ctc oper) req  only masked by ptw refill req
// 2. when tlboper started, it will stall all other req
always @(posedge arb_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    tlboper_on <= 1'b0;
  else if(tlboper_on && tlboper_xx_cmplt)
    tlboper_on <= 1'b0;
  else if(arb_tlboper_grant)
    tlboper_on <= 1'b1;
end

assign utlb_mask      = !arb_idle_st
                     || tlboper_on;

assign arb_read_huge  = read_cur_4k || read_cur_2m;
assign arb_sel_4k = arb_ptw_grant ? ptw_arb_pgs[0]
                  : arb_tlboper_grant ? tlboper_xx_pgs[0]
                  : !arb_read_huge;
assign arb_sel_2m = arb_ptw_grant ? ptw_arb_pgs[1]
                  : arb_read_huge ? read_cur_4k
                  : (tlboper_arb_req || tlboper_on) && tlboper_xx_pgs[1];
assign arb_sel_1g = arb_ptw_grant ? ptw_arb_pgs[2]
                  : arb_read_huge ? read_cur_2m
                  : (tlboper_arb_req || tlboper_on) && tlboper_xx_pgs[2];

//==============================================================================
//                  Data Path
//==============================================================================
//==========================================================
//                  jTLB Index & VPN(tag for cmp)
//==========================================================
// VPN select
assign arb_vpn[VPN_WIDTH-1:0] =
                {VPN_WIDTH{arb_iutlb_grant}}   & iutlb_arb_vpn[VPN_WIDTH-1:0]
              | {VPN_WIDTH{arb_read_huge}}     & jtlb_arb_vpn[VPN_WIDTH-1:0]
              | {VPN_WIDTH{arb_dutlb_grant}}   & dutlb_arb_vpn[VPN_WIDTH-1:0]
              | {VPN_WIDTH{arb_tlboper_grant}} & tlboper_arb_vpn[VPN_WIDTH-1:0]
              | {VPN_WIDTH{arb_ptw_grant}}     & ptw_arb_vpn[VPN_WIDTH-1:0];
assign arb_vpn[PPN_WIDTH-1] = arb_iutlb_grant && iutlb_arb_vpn[PPN_WIDTH-1]
                           || arb_dutlb_grant && dutlb_arb_vpn[PPN_WIDTH-1]
                           || arb_read_huge   && jtlb_arb_vpn[PPN_WIDTH-1];

// Index select
assign arb_va_index[8:0] = {9{arb_sel_4k}} & arb_vpn[8:0]
                         | {9{arb_sel_2m}} & arb_vpn[17:9]
                         | {9{arb_sel_1g}} & arb_vpn[26:18];

assign tlboper_idx_not_va_sel = !ptw_arb_req && tlboper_arb_idx_not_va && arb_tlboper_grant;
assign arb_idx[8:0] = tlboper_idx_not_va_sel ? tlboper_arb_idx[8:0]
                                             : arb_va_index[8:0];

// Way Select
assign arb_way_sel[1:0] = {2{arb_iutlb_grant}}   & 2'b11
                        | {2{arb_read_huge}}     & 2'b11
                        | {2{arb_dutlb_grant}}   & 2'b11
                        | {2{arb_tlboper_grant}} & tlboper_arb_bank_sel[1:0]
                        | {2{arb_ptw_grant}}     & ptw_arb_bank_sel[1:0];

// Page Size Select
assign arb_pgs[2:0] = {arb_sel_1g, arb_sel_2m, arb_sel_4k};

// Machine Mode
assign arb_mach    = arb_iutlb_grant && iutlb_arb_mach
                  || arb_read_huge   && jtlb_arb_mach
                  || arb_dutlb_grant && dutlb_arb_mach; 

//==========================================================
//                  jTLB Write and Read Infor
//==========================================================
// Write Enable
assign arb_write    = arb_tlboper_grant && tlboper_arb_write
                   || arb_ptw_grant;

// Fifo Write Enable
assign arb_fifo_write = arb_tlboper_grant && tlboper_arb_fifo_write
                     || arb_ptw_grant;

// Compare with va to judge hit
assign arb_cmp_va = arb_iutlb_grant
                 || arb_dutlb_grant
                 || arb_read_huge
                 || arb_tlboper_grant && tlboper_arb_cmp_va; 

//==========================================================
//                  jTLB Tag & Data Input
//==========================================================
assign arb_fifo_din[1:0] =  {2{arb_tlboper_grant}} & tlboper_arb_fifo_din[1:0]
                          | {2{arb_ptw_grant}}     & ptw_arb_fifo_din[1:0];

assign arb_tag_din[TAG_WIDTH-1:0]  = 
                {TAG_WIDTH{arb_tlboper_grant}} & tlboper_arb_tag_din[TAG_WIDTH-1:0]
              | {TAG_WIDTH{arb_ptw_grant}}     & ptw_arb_tag_din[TAG_WIDTH-1:0];

assign arb_data_din[DATA_WIDTH-1:0] = 
             {DATA_WIDTH{arb_tlboper_grant}} & tlboper_arb_data_din[DATA_WIDTH-1:0]
           | {DATA_WIDTH{arb_ptw_grant}}     & ptw_arb_data_din[DATA_WIDTH-1:0];

//==========================================================
//                  Output to JTLB
//==========================================================
assign arb_jtlb_req                = arb_req;

assign arb_jtlb_vpn[PPN_WIDTH-1:0] = arb_vpn[PPN_WIDTH-1:0];
assign arb_jtlb_idx[8:0]           = arb_idx[8:0];
assign arb_jtlb_way_sel[1:0]       = arb_way_sel[1:0];
assign arb_jtlb_pgs[2:0]           = arb_pgs[2:0];
assign arb_jtlb_mach               = arb_mach;

assign arb_jtlb_write              = arb_write;
assign arb_jtlb_fifo_write         = arb_fifo_write;
assign arb_jtlb_cmp_va             = arb_cmp_va;

assign arb_jtlb_fifo_din[1:0]            = arb_fifo_din[1:0];
assign arb_jtlb_tag_din[TAG_WIDTH-1:0]   = arb_tag_din[TAG_WIDTH-1:0];
assign arb_jtlb_data_din[DATA_WIDTH-1:0] = arb_data_din[DATA_WIDTH-1:0];

assign arb_jtlb_iutlb_on           = arb_iutlb_st;
assign arb_jtlb_dutlb_on           = arb_dutlb_st;
assign arb_jtlb_oper_on            = tlboper_on;
assign arb_jtlb_ptw_req            = arb_ptw_grant;

//==========================================================
//                  Output to PTW
//==========================================================
assign arb_ptw_iutlb_on           = arb_iutlb_st;
assign arb_ptw_dutlb_rd           = arb_dutlb_st &&  dutlb_arb_read;
assign arb_ptw_dutlb_wr           = arb_dutlb_st && !dutlb_arb_read;
assign arb_ptw_priv_mode[1:0]     = {2{arb_iutlb_st}} & iutlb_arb_mode[1:0]
                                  | {2{arb_dutlb_st}} & dutlb_arb_mode[1:0];
assign arb_ptw_asid[15:0]         = {16{arb_iutlb_st}} & iutlb_arb_asid[15:0]
                                  | {16{arb_dutlb_st}} & dutlb_arb_asid[15:0];

//==========================================================
//                  Output to TLBOPER
//==========================================================
assign arb_tlboper_read_idle       = read_cur_idle;

// for dbg
assign arb_top_cur_st[1:0]  = arb_cur_st[1:0];
assign arb_top_tlboper_on   = tlboper_on;
assign arb_top_read_st[1:0] = read_cur_st[1:0];

assign mmu_yy_xx_no_op = cp0_mmu_lpmd_req
                      && arb_idle_st;

// &Force("input", "ptw_arb_cur_st"); &Force("bus", "ptw_arb_cur_st", 4, 0); @365

// &ModuleEnd; @378
endmodule


