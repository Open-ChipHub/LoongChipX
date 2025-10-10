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

// &ModuleBeg; @25
module ct_lsu_mcic (
  // &Ports, @26
  input    wire  [127:0]  biu_lsu_r_data,
  input    wire  [4  :0]  biu_lsu_r_id,
  input    wire  [3  :0]  biu_lsu_r_resp,
  input    wire           biu_lsu_r_vld,
  input    wire           cp0_lsu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           dcache_arb_mcic_ld_grnt,
  input    wire           forever_cpuclk,
  input    wire           ld_da_dcache_hit,
  input    wire           ld_da_mcic_borrow_mmu_req,
  input    wire  [63 :0]  ld_da_mcic_bypass_data,
  input    wire           ld_da_mcic_data_err,
  input    wire           ld_da_mcic_rb_full,
  input    wire           ld_da_mcic_wakeup,
  input    wire           lfb_mcic_wakeup,
  input    wire           mmu_lsu_data_req,
  input    wire  [39 :0]  mmu_lsu_data_req_addr,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [4  :0]  rb_mcic_ar_id,
  input    wire           rb_mcic_biu_req_success,
  input    wire           rb_mcic_ecc_err,
  input    wire           rb_mcic_not_full,
  output   wire           lsu_had_mcic_data_req,
  output   wire           lsu_had_mcic_frz,
  output   wire           lsu_mmu_bus_error,
  output   wire  [63 :0]  lsu_mmu_data,
  output   wire           lsu_mmu_data_vld,
  output   wire  [7  :0]  mcic_dcache_arb_ld_data_gateclk_en,
  output   wire  [10 :0]  mcic_dcache_arb_ld_data_high_idx,
  output   wire  [10 :0]  mcic_dcache_arb_ld_data_low_idx,
  output   wire  [7  :0]  mcic_dcache_arb_ld_data_req,
  output   wire           mcic_dcache_arb_ld_req,
  output   wire           mcic_dcache_arb_ld_tag_gateclk_en,
  output   wire  [8  :0]  mcic_dcache_arb_ld_tag_idx,
  output   wire  [39 :0]  mcic_dcache_arb_req_addr
); 



// &Regs; @27
reg     [4  :0]  mcic_ar_id;                        
reg              mcic_ar_id_vld;                    
reg              mcic_frz;                          
reg              mcic_rb_full;                      

// &Wires; @28
wire    [63 :0]  mcic_bus_bypass_data;              
wire    [63 :0]  mcic_bus_bypass_data_ori;          
wire             mcic_clk;                          
wire             mcic_clk_en;                       
wire    [63 :0]  mcic_data;                         
wire             mcic_data_vld;                     
wire    [3  :0]  mcic_dcache_data_req;              
wire             mcic_r_bus_error;                  
wire             mcic_r_id_hit;                     
wire             mcic_rb_full_wakeup;               
wire    [39 :0]  mcic_req_addr;                     


parameter OKAY    = 2'b00,
          EXOKAY  = 2'b01,
          SLVERR  = 2'b10,
          DECERR  = 2'b11;
parameter BYTE    = 2'b00,
          HALF    = 2'b01,
          WORD    = 2'b10;


//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign mcic_clk_en  = mmu_lsu_data_req;
// &Instance("gated_clk_cell", "x_lsu_mcic_gated_clk"); @43
gated_clk_cell  x_lsu_mcic_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (mcic_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (mcic_clk_en       ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @44
//          .external_en   (1'b0               ), @45
//          .global_en     (cp0_yy_clk_en      ), @46
//          .module_en     (cp0_lsu_icg_en     ), @47
//          .local_en      (mcic_clk_en        ), @48
//          .clk_out       (mcic_clk           )); @49

//==========================================================
//                 Register
//==========================================================
//+-----+
//| frz |
//+-----+
always @(posedge mcic_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mcic_frz         <=  1'b0;
  else if(mcic_rb_full_wakeup ||  mcic_data_vld ||  lfb_mcic_wakeup ||  ld_da_mcic_wakeup)
    mcic_frz         <=  1'b0;
  else if(dcache_arb_mcic_ld_grnt)
    mcic_frz         <=  1'b1;
end

//+---------+
//| rb_full |
//+---------+
always @(posedge mcic_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mcic_rb_full     <=  1'b0;
  else if(mcic_rb_full_wakeup)
    mcic_rb_full     <=  1'b0;
  else if(ld_da_mcic_rb_full)
    mcic_rb_full     <=  1'b1;
end

//+-----------+
//| ar_id_vld |
//+-----------+
always @(posedge mcic_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mcic_ar_id_vld  <=  1'b0;
  else if(mcic_data_vld)
    mcic_ar_id_vld  <=  1'b0;
  else if(rb_mcic_biu_req_success)
    mcic_ar_id_vld  <=  1'b1;
end

//+-------+
//| ar_id |
//+-------+
always @(posedge mcic_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    mcic_ar_id[4:0] <=  5'b0;
  else if(rb_mcic_biu_req_success)
    mcic_ar_id[4:0] <=  rb_mcic_ar_id[4:0];
end

//==========================================================
//                 Dcache request
//==========================================================
assign mcic_req_addr[39:0]              = mmu_lsu_data_req_addr[39:0];
//-----------dcache req-------------------------------------
// &Force("output", "mcic_dcache_arb_ld_req"); @109
assign mcic_dcache_arb_ld_req           = mmu_lsu_data_req  &&  !mcic_frz;
//-----------tag array------------------
assign mcic_dcache_arb_ld_tag_gateclk_en= mcic_dcache_arb_ld_req;
assign mcic_dcache_arb_ld_tag_idx[8:0]  = mmu_lsu_data_req_addr[14:6];
//-----------data array-----------------
assign mcic_dcache_data_req[3:0]              = mcic_req_addr[3]
                                                ? 4'b1100
                                                : 4'b0011;
// &Force("output","mcic_dcache_arb_ld_data_req"); @118
assign mcic_dcache_arb_ld_data_req[7:0]       = {mcic_dcache_data_req[3:0],mcic_dcache_data_req[3:0]};
assign mcic_dcache_arb_ld_data_gateclk_en[7:0]= mcic_dcache_arb_ld_data_req[7:0]
                                                & {8{mcic_dcache_arb_ld_req}};
assign mcic_dcache_arb_ld_data_low_idx[10:0]  = mcic_req_addr[14:4];
assign mcic_dcache_arb_ld_data_high_idx[10:0] = {mcic_req_addr[14:5],~mcic_req_addr[4]};
//assign mcic_dcache_arb_ld_data_wen[31:0]      = 32'b0;
//-----------borrow signal----------------------------------
assign mcic_dcache_arb_req_addr[39:0] = mcic_req_addr[39:0];

//==========================================================
//                 Restart
//==========================================================
assign mcic_rb_full_wakeup  = mcic_rb_full  &&  rb_mcic_not_full;

//==========================================================
//                 Bypass data
//==========================================================
//----------------------get data----------------------------
//get data from bus
assign mcic_bus_bypass_data_ori[63:0] = mcic_req_addr[3]
                                        ? biu_lsu_r_data[127:64]
                                        : biu_lsu_r_data[63:0];

assign mcic_bus_bypass_data[63:0]     = rb_mcic_ecc_err
                                        ? 64'b0
                                        : mcic_bus_bypass_data_ori[63:0];
//get data unsettle
assign mcic_data[63:0]            = mcic_ar_id_vld
                                    ? mcic_bus_bypass_data[63:0]
                                    : ld_da_mcic_bypass_data[63:0];


//==========================================================
//                 judge biu r info
//==========================================================
assign mcic_data_vld      = (ld_da_mcic_borrow_mmu_req  &&  ld_da_dcache_hit)
                            ||  ld_da_mcic_data_err
                            ||  mcic_r_id_hit;
assign mcic_r_id_hit      = (mcic_ar_id[4:0] ==  biu_lsu_r_id[4:0])
                            &&  mcic_ar_id_vld
                            &&  biu_lsu_r_vld;

// &Force("bus","biu_lsu_r_resp",3,0); @161
assign mcic_r_bus_error   = biu_lsu_r_resp[1:0]  != OKAY;

//==========================================================
//                 Interface to mmu
//==========================================================
assign lsu_mmu_data_vld   = mcic_data_vld;
assign lsu_mmu_data[63:0] = mcic_data[63:0];
assign lsu_mmu_bus_error  = mcic_r_id_hit &&  mcic_r_bus_error;

//==========================================================
//              interface to other module
//==========================================================
assign lsu_had_mcic_data_req  = mmu_lsu_data_req;
assign lsu_had_mcic_frz       = mcic_frz;

// &ModuleEnd; @177
endmodule


