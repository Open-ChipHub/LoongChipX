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
module ct_piu_top_dummy_device (
  // &Ports, @2
  input    wire           snb0_piu_ar_grant,
  input    wire           snb0_piu_aw_grant,
  input    wire           snb0_piu_bvalid,
  input    wire           snb0_piu_rvalid,
  input    wire           snb0_piu_wcd_grant,
  input    wire  [13 :0]  snb0_piux_bbus,
  input    wire  [534:0]  snb0_piux_rbus,
  input    wire           snb1_piu_ar_grant,
  input    wire           snb1_piu_aw_grant,
  input    wire           snb1_piu_bvalid,
  input    wire           snb1_piu_rvalid,
  input    wire           snb1_piu_wcd_grant,
  input    wire  [13 :0]  snb1_piux_bbus,
  input    wire  [534:0]  snb1_piux_rbus,
  output   wire  [70 :0]  piu_snb0_ar_bus,
  output   wire           piu_snb0_ar_req,
  output   wire           piu_snb0_aw_req,
  output   wire           piu_snb0_b_grant,
  output   wire           piu_snb0_back,
  output   wire           piu_snb0_r_grant,
  output   wire           piu_snb0_rack,
  output   wire           piu_snb0_wcd_req,
  output   wire  [70 :0]  piu_snb1_ar_bus,
  output   wire           piu_snb1_ar_req,
  output   wire           piu_snb1_aw_req,
  output   wire           piu_snb1_b_grant,
  output   wire           piu_snb1_back,
  output   wire           piu_snb1_r_grant,
  output   wire           piu_snb1_rack,
  output   wire           piu_snb1_wcd_req,
  output   wire  [4  :0]  piu_snbx_back_sid,
  output   wire  [4  :0]  piu_snbx_rack_sid,
  output   wire  [70 :0]  piu_xx_aw_bus,
  output   wire           piu_xx_no_op,
  output   wire  [534:0]  piu_xx_wcd_bus
); 



// &Regs; @3
// &Wires; @4


parameter UPKB_WIDTH = 535;
parameter B_WIDTH    = 14;
parameter ARWIDTH    = 71;
parameter AWWIDTH    = 71;
parameter WCD_WIDTH  = 535;

// &Force("input", "snb0_piu_ar_grant"); @12
// &Force("input", "snb1_piu_ar_grant"); @13

// &Force("input", "snb0_piu_aw_grant"); @15
// &Force("input", "snb1_piu_aw_grant"); @16
// &Force("input", "snb0_piu_wcd_grant"); @17
// &Force("input", "snb1_piu_wcd_grant"); @18

// &Force("input", "snb0_piu_rvalid"); @20
// &Force("input", "snb1_piu_rvalid"); @21
// &Force("input", "snb0_piux_rbus");  &Force("bus", "snb0_piux_rbus",(UPKB_WIDTH-1),0); @22
// &Force("input", "snb1_piux_rbus");  &Force("bus", "snb1_piux_rbus",(UPKB_WIDTH-1),0); @23

// &Force("input", "snb0_piu_bvalid"); @25
// &Force("input", "snb1_piu_bvalid"); @26
// &Force("input", "snb0_piux_bbus");  &Force("bus", "snb0_piux_bbus", (B_WIDTH-1),0); @27
// &Force("input", "snb1_piux_bbus");  &Force("bus", "snb1_piux_bbus", (B_WIDTH-1),0); @28

assign piu_snb0_ar_req = 1'b0;
assign piu_snb1_ar_req = 1'b0;
assign piu_snb0_ar_bus[ARWIDTH-1:0] = {ARWIDTH{1'b0}};
assign piu_snb1_ar_bus[ARWIDTH-1:0] = {ARWIDTH{1'b0}};

assign piu_snb0_aw_req = 1'b0;
assign piu_snb1_aw_req = 1'b0;
assign piu_xx_aw_bus[AWWIDTH-1:0] = {AWWIDTH{1'b0}};
assign piu_snb0_wcd_req = 1'b0;
assign piu_snb1_wcd_req = 1'b0;
assign piu_xx_wcd_bus[WCD_WIDTH-1:0] = {WCD_WIDTH{1'b0}};

assign piu_snb0_r_grant  = 1'b0;
assign piu_snb1_r_grant  = 1'b0;
assign piu_snb0_b_grant  = 1'b0;
assign piu_snb1_b_grant  = 1'b0;

assign piu_snb0_rack          = 1'b0;
assign piu_snb1_rack          = 1'b0;
assign piu_snbx_rack_sid[4:0] = 5'b0;
assign piu_snb0_back          = 1'b0;
assign piu_snb1_back          = 1'b0;
assign piu_snbx_back_sid[4:0] = 5'b0;

assign piu_xx_no_op = 1'b1;


// &ModuleEnd; @57
endmodule



