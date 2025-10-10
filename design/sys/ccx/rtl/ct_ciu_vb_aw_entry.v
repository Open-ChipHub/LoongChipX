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
module ct_ciu_vb_aw_entry (
  // &Ports, @24
  input    wire           ciu_icg_en,
  input    wire           cpurst_b,
  input    wire  [7  :0]  ebiuif_vb_index,
  input    wire           forever_cpuclk,
  input    wire  [534:0]  l2c0_vb_wbus,
  input    wire           l2c0_wvalid_x,
  input    wire  [534:0]  l2c1_vb_wbus,
  input    wire           l2c1_wvalid_x,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [534:0]  snb0_vb_wbus,
  input    wire           snb0_wvalid_x,
  input    wire  [7  :0]  snb0_yy_snpext_index,
  input    wire  [534:0]  snb1_vb_wbus,
  input    wire           snb1_wvalid_x,
  input    wire  [7  :0]  snb1_yy_snpext_index,
  input    wire  [67 :0]  vb_aw_create_bus,
  input    wire  [2  :0]  vb_aw_create_mid,
  input    wire           vb_aw_create_sel_x,
  input    wire           vb_aw_req_sel_x,
  input    wire           vb_ctrl_clk,
  input    wire           vb_w_pop_sel_x,
  output   wire           snb0_snpext_addr_hit_x,
  output   wire           snb1_snpext_addr_hit_x,
  output   wire           vb_aw_en_x,
  output   wire           vb_aw_vld_x,
  output   wire  [67 :0]  vb_entryx_awbus,
  output   wire  [2  :0]  vb_entryx_mid,
  output   wire  [1  :0]  vb_entryx_offset,
  output   wire  [534:0]  vb_entryx_wbus,
  output   wire           vb_snb_addr_hit_x,
  output   wire           vb_w_vld_x
); 



// &Regs; @25
reg     [67 :0]  vb_aw_bus;             
reg              vb_aw_en;              
reg     [2  :0]  vb_aw_mid;             
reg              vb_aw_vld;             
reg     [534:0]  vb_w_bus;              
reg              vb_w_vld;              

// &Wires; @26
wire             vb_entry_awclk;        
wire             vb_entry_wclk;         
wire    [534:0]  vb_w_create_bus;       
wire             vb_w_create_sel;       


//======================================
//     CA Write Table CA_WT(WT)
//1. CA_WT : non-cacheable write
//entry content:
//| vld | addr 
//======================================
//CA_WT vld
parameter ADDR_4  = 4;
parameter ADDR_5  = 5;
parameter ADDR_6  = 6;
parameter ADDR_13 = 13;
parameter WIDTH   = 68;
parameter DWIDTH  = 535;

always @(posedge vb_ctrl_clk or negedge cpurst_b)
begin
  if(~cpurst_b)
    vb_aw_vld   <= 1'b0;
  else if(vb_aw_create_sel_x)
    vb_aw_vld <= 1'b1;
  else if(vb_w_pop_sel_x)
    vb_aw_vld <= 1'b0;
end

always @(posedge vb_ctrl_clk or negedge cpurst_b)
begin
  if(~cpurst_b)
    vb_aw_en <= 1'b0;
  else if(vb_aw_create_sel_x)
    vb_aw_en <= 1'b1;
  else if(vb_aw_req_sel_x)
    vb_aw_en <= 1'b0;
end

always @(posedge vb_entry_awclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    vb_aw_bus[WIDTH-1:0] <= {WIDTH{1'b0}};
  else if(vb_aw_create_sel_x)
    vb_aw_bus[WIDTH-1:0] <= vb_aw_create_bus[WIDTH-1:0];
  else
    vb_aw_bus[WIDTH-1:0] <= vb_aw_bus[WIDTH-1:0];
end

always @(posedge vb_entry_awclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    vb_aw_mid[2:0] <= 3'b0;
  else if(vb_aw_create_sel_x)
    vb_aw_mid[2:0] <= vb_aw_create_mid[2:0];
  else
    vb_aw_mid[2:0] <= vb_aw_mid[2:0];
end


assign vb_w_create_sel = l2c0_wvalid_x | 
                         l2c1_wvalid_x | 
                         snb0_wvalid_x | 
                         snb1_wvalid_x;

always @(posedge vb_ctrl_clk or negedge cpurst_b)
begin
  if(~cpurst_b)
    vb_w_vld <= 1'b0;
  else if(vb_w_create_sel)
    vb_w_vld <= 1'b1;
  else if(vb_w_pop_sel_x)
    vb_w_vld <= 1'b0;
end

assign vb_w_create_bus[DWIDTH-1:0] =
      {DWIDTH{l2c0_wvalid_x}} & l2c0_vb_wbus[DWIDTH-1:0] |
      {DWIDTH{l2c1_wvalid_x}} & l2c1_vb_wbus[DWIDTH-1:0] |
      {DWIDTH{snb0_wvalid_x}} & snb0_vb_wbus[DWIDTH-1:0] |
      {DWIDTH{snb1_wvalid_x}} & snb1_vb_wbus[DWIDTH-1:0];

always @(posedge vb_entry_wclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    vb_w_bus[DWIDTH-1:0] <= {DWIDTH{1'b0}};
  else if(vb_w_create_sel)
    vb_w_bus[DWIDTH-1:0] <= vb_w_create_bus[DWIDTH-1:0];
  else
    vb_w_bus[DWIDTH-1:0] <= vb_w_bus[DWIDTH-1:0];
end

assign vb_aw_vld_x = vb_aw_vld;
assign vb_aw_en_x  = vb_aw_en;
assign vb_w_vld_x  = vb_w_vld;
assign vb_entryx_offset[1:0] = vb_aw_bus[ADDR_5:ADDR_4];
assign vb_entryx_awbus[WIDTH-1:0] = vb_aw_bus[WIDTH-1:0];
assign vb_entryx_wbus[DWIDTH-1:0] = vb_w_bus[DWIDTH-1:0];
assign vb_entryx_mid[2:0]         = vb_aw_mid[2:0];

assign vb_snb_addr_hit_x = vb_aw_vld && (ebiuif_vb_index[7:0] == vb_aw_bus[ADDR_13:ADDR_6]);
//assign vb_snb1_addr_hit_x = vb_aw_vld && (snb1_vb_araddr[7:0] == vb_aw_bus[ADDR_13:ADDR_6]);
assign snb0_snpext_addr_hit_x = vb_aw_vld && (snb0_yy_snpext_index[7:0] == vb_aw_bus[ADDR_13:ADDR_6]);
assign snb1_snpext_addr_hit_x = vb_aw_vld && (snb1_yy_snpext_index[7:0] == vb_aw_bus[ADDR_13:ADDR_6]);

// &Instance("gated_clk_cell", "x_vb_entry_aw_gated_clk"); @139
gated_clk_cell  x_vb_entry_aw_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_entry_awclk    ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_aw_create_sel_x),
  .module_en          (ciu_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @140
//          .external_en (1'b0), @141
//          .global_en   (1'b1), @142
//          .module_en (ciu_icg_en       ), @143
//          .local_en    (vb_aw_create_sel_x), @144
//          .clk_out     (vb_entry_awclk)); @145


// &Instance("gated_clk_cell", "x_vb_entry_w_gated_clk"); @148
gated_clk_cell  x_vb_entry_w_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vb_entry_wclk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (vb_w_create_sel   ),
  .module_en          (ciu_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @149
//          .external_en (1'b0), @150
//          .global_en   (1'b1), @151
//          .module_en (ciu_icg_en       ), @152
//          .local_en    (vb_w_create_sel), @153
//          .clk_out     (vb_entry_wclk)); @154

// &ModuleEnd; @156
endmodule



