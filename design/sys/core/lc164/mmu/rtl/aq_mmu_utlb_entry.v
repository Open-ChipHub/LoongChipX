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

// &ModuleBeg; @24
module aq_mmu_utlb_entry (
  // &Ports, @25
  input    wire          cp0_mach_mode,
  input    wire          cp0_mmu_icg_en,
  input    wire          cp0_mmu_satp_wen,
  input    wire  [26:0]  cp0_mmu_tlb_va,
  input    wire          cpurst_b,
  input    wire          mmu_top_clk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          regs_mmu_en,
  input    wire          tlboper_xx_clr,
  input    wire          tlboper_xx_inv_va_req,
  input    wire          utlb_entry_upd,
  input    wire          utlb_off,
  input    wire  [27:0]  utlb_req_vpn,
  input    wire  [15:0]  utlb_req_asid,
  input    wire  [14:0]  utlb_upd_flg,
  input    wire          utlb_upd_g,
  input    wire  [15:0]  utlb_upd_asid,
  input    wire          utlb_upd_mmu_on,
  input    wire  [2 :0]  utlb_upd_pgs,
  input    wire  [27:0]  utlb_upd_ppn,
  input    wire  [27:0]  utlb_upd_vpn,
  output   wire  [14:0]  utlb_entry_flg,
  output   wire          utlb_entry_hit,
  output   wire          utlb_entry_hit_dp,
  output   wire  [2 :0]  utlb_entry_pgs,
  output   wire  [27:0]  utlb_entry_ppn,
  output   wire          utlb_entry_vld
); 



// &Regs; @26
reg     [14:0]  utlb_flg;             
reg     [15:0]  utlb_asid;             
reg             utlb_g;          
reg             utlb_mmu_on;          
reg     [2 :0]  utlb_pgs;             
reg     [27:0]  utlb_ppn;             
reg             utlb_vld;             
reg     [27:0]  utlb_vpn;             
reg             vpn_hit;              

// &Wires; @27
wire            ctc_inv_va_hit_clr;   
wire            entry_clk_en;         
wire            mach_vpn_hit;         
wire            mode_hit;             
wire            utlb_entry_clk;       
wire            utlb_entry_clr;       
wire            utlb_entry_gating_clr; 
wire            vpn0_hit;             
wire            vpn1_hit;             
wire            vpn2_hit;             
wire            asid_hit;             

// &Force("bus","cp0_mmu_tlb_va",26,0); @28

parameter VPN_WIDTH  = 39-12;  // VPN
parameter PPN_WIDTH  = 40-12;  // PPN
parameter FLG_WIDTH  = 15;     // Flags
parameter PGS_WIDTH  = 3;      // Page Size
parameter ASID_WIDTH = 16;     // ASID
parameter PTE_LEVEL  = 3;      // Page Table Label

//============================================================
//                  MicroTLB Entry
//============================================================
//------------------------------------------------------------
// 1. ASID field are not included in uTLB entry
// 2. Each Data uTLB entry always matches the ASID in the SATP
//    register
// 3. The micro tlb entry layout is figured as following:
//    =========================================
//    |       |73   47|46      44|43 16|15   0|
//    |-------+-------+----------+-----+------+
//    | Valid |  VPN  | PageSize | PFN | Flag |
//    =========================================
//------------------------------------------------------------

// Gated Cell for utlb entry
assign entry_clk_en = utlb_entry_gating_clr
                   || utlb_entry_upd;
// &Instance("gated_clk_cell", "x_utlb_entry_gateclk"); @54
gated_clk_cell  x_utlb_entry_gateclk (
  .clk_in             (mmu_top_clk       ),
  .clk_out            (utlb_entry_clk    ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (entry_clk_en      ),
  .module_en          (cp0_mmu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in     (mmu_top_clk   ), @55
//           .external_en(1'b0          ), @56
//           .global_en  (1'b1          ), @57
//           .module_en  (cp0_mmu_icg_en), @58
//           .local_en   (entry_clk_en  ), @59
//           .clk_out    (utlb_entry_clk) @60
//          ); @61

//------------------------------------------------------------
//                  Valid bit generating
//------------------------------------------------------------
assign utlb_entry_clr = cp0_mmu_satp_wen
                     || tlboper_xx_clr 
                     || ctc_inv_va_hit_clr;
assign utlb_entry_gating_clr = cp0_mmu_satp_wen
                     || tlboper_xx_clr 
                     || tlboper_xx_inv_va_req;
assign ctc_inv_va_hit_clr = tlboper_xx_inv_va_req
                     && (cp0_mmu_tlb_va[7:0] == utlb_vpn[7:0]);

always @(posedge utlb_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    utlb_vld <= 1'b0;
  else if(utlb_entry_clr) 
    utlb_vld <= 1'b0;
  else if(utlb_entry_upd)
    utlb_vld <= 1'b1;
end


//------------------------------------------------------------
//                  VPN Information
//------------------------------------------------------------
always @(posedge utlb_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    utlb_vpn[PPN_WIDTH-1:0] <= {PPN_WIDTH{1'b0}};
  else if(utlb_entry_upd)
    utlb_vpn[PPN_WIDTH-1:0] <= utlb_upd_vpn[PPN_WIDTH-1:0];
end


//------------------------------------------------------------
//                  PFN and Flag information
// Flag 6:0: D, A, U, X, W, R, V
//------------------------------------------------------------
always @(posedge utlb_entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    utlb_pgs[PGS_WIDTH-1:0]   <= {PGS_WIDTH{1'b0}};
    utlb_ppn[PPN_WIDTH-1:0]   <= {PPN_WIDTH{1'b0}};
    utlb_flg[FLG_WIDTH-1:0]   <= {FLG_WIDTH{1'b0}};
    utlb_asid[ASID_WIDTH-1:0] <= {ASID_WIDTH{1'b0}};
    utlb_g                    <= 1'b0;
    utlb_mmu_on               <= 1'b0;
  end
  else if(utlb_entry_upd)
  begin
    utlb_pgs[PGS_WIDTH-1:0]   <= utlb_upd_pgs[PGS_WIDTH-1:0];
    utlb_ppn[PPN_WIDTH-1:0]   <= utlb_upd_ppn[PPN_WIDTH-1:0];
    utlb_flg[FLG_WIDTH-1:0]   <= utlb_upd_flg[FLG_WIDTH-1:0];
    utlb_asid[ASID_WIDTH-1:0] <= utlb_upd_asid[ASID_WIDTH-1:0];
    utlb_g                    <= utlb_upd_g;
    utlb_mmu_on               <= utlb_upd_mmu_on;
  end
end


//------------------------------------------------------------
//                  Entry Hit
//------------------------------------------------------------
assign vpn2_hit = utlb_req_vpn[VPN_WIDTH-1:VPN_WIDTH-9] 
                   == utlb_vpn[VPN_WIDTH-1:VPN_WIDTH-9];
assign vpn1_hit = utlb_req_vpn[VPN_WIDTH-1-9:VPN_WIDTH-2*9] 
                   == utlb_vpn[VPN_WIDTH-1-9:VPN_WIDTH-2*9];
assign vpn0_hit = utlb_req_vpn[VPN_WIDTH-1-2*9:0] 
                   == utlb_vpn[VPN_WIDTH-1-2*9:0];
assign asid_hit = (utlb_req_asid[ASID_WIDTH-1:0] == utlb_asid[ASID_WIDTH-1:0]) 
                  || utlb_g;

// &CombBeg; @130
always @( utlb_pgs[2:0]
       or vpn1_hit
       or vpn2_hit
       or vpn0_hit)
begin
case(utlb_pgs[2:0])
  3'b001:  vpn_hit = vpn2_hit && vpn1_hit && vpn0_hit;
  3'b010:  vpn_hit = vpn2_hit && vpn1_hit;
  3'b100:  vpn_hit = vpn2_hit;
  default: vpn_hit = 1'bx;
endcase
// &CombEnd; @137
end

//assign vpn_hit  = utlb_pgs[0] && vpn2_hit && vpn1_hit && vpn0_hit
//               || utlb_pgs[1] && vpn2_hit && vpn1_hit
//               || utlb_pgs[2] && vpn2_hit;

// assign mode_hit = (cp0_mach_mode == utlb_flg[10])
//                && (cp0_mach_mode || utlb_mmu_on == regs_mmu_en);

// On LA64, we always mode int
assign mode_hit = 1'b1;
assign mach_vpn_hit = utlb_off
                    ? (utlb_req_vpn[PPN_WIDTH-1] == utlb_vpn[PPN_WIDTH-1])
                    : 1'b1;

//------------------------------------------------------------
//                  Output
//------------------------------------------------------------
assign utlb_entry_vld    = utlb_vld;
assign utlb_entry_hit_dp = utlb_vld && vpn_hit && asid_hit && mode_hit && mach_vpn_hit;
assign utlb_entry_hit    = utlb_vld && vpn_hit && asid_hit && mode_hit && mach_vpn_hit;

//assign utlb_entry_vpn[VPN_WIDTH-1:0] = utlb_vpn[VPN_WIDTH-1:0];
assign utlb_entry_pgs[PGS_WIDTH-1:0] = utlb_pgs[PGS_WIDTH-1:0];

assign utlb_entry_ppn[PPN_WIDTH-1:0] = utlb_ppn[PPN_WIDTH-1:0];
assign utlb_entry_flg[FLG_WIDTH-1:0] = utlb_flg[FLG_WIDTH-1:0];


// &ModuleEnd; @162
endmodule


