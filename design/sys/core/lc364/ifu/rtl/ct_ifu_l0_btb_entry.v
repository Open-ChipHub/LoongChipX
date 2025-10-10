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

// &ModuleBeg; @22
module ct_ifu_l0_btb_entry (
  // &Ports, @23
  input    wire          cp0_ifu_btb_en,
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_ifu_l0btb_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          entry_inv,
  input    wire          entry_update,
  input    wire          entry_update_cnt,
  input    wire  [36:0]  entry_update_data,
  input    wire          entry_update_ras,
  input    wire          entry_update_vld,
  input    wire  [3 :0]  entry_wen,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  output   reg           entry_cnt,
  output   reg           entry_ras,
  output   reg   [14:0]  entry_tag,
  output   reg   [19:0]  entry_target,
  output   reg           entry_vld,
  output   reg   [1 :0]  entry_way_pred
); 



// &Regs; @24

// &Wires; @25
wire            entry_clk;         
wire            entry_clk_en;      
wire            entry_update_en;   


// &Instance("gated_clk_cell", "x_l0_btb_entry_gatedclk"); @27
gated_clk_cell  x_l0_btb_entry_gatedclk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_clk_en      ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @28
//          .external_en (1'b0          ), @29
//          .global_en   (cp0_yy_clk_en ), @30
//          .module_en   (cp0_ifu_icg_en), @31
//          .local_en    (entry_clk_en  ), @32
//          .clk_out     (entry_clk     ) @33
//         ); @34
assign entry_clk_en     = entry_update_en;
assign entry_update_en = entry_update 
                       && cp0_ifu_btb_en
                       && cp0_ifu_l0btb_en; 

//=========================================================
// contents of one L0 BTB entry 
//=========================================================
// +-----------+-----------+---------------+--------------+
// | entry_vld | tag[10:0] | way_pred[1:0] | target[19:0] |
// +-----------+-----------+---------------+--------------+
always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_vld           <= 1'b0;
  else if(entry_inv)
    entry_vld           <= 1'b0;
  else if(entry_wen[3] && entry_update_en)
    entry_vld           <= entry_update_vld;
  else
    entry_vld           <= entry_vld;
end

always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_cnt           <= 1'b0;
  else if(entry_inv)
    entry_cnt           <= 1'b0;
  else if(entry_wen[2] && entry_update_en)
    entry_cnt           <= entry_update_cnt;
  else
    entry_cnt           <= entry_cnt;
end

always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    entry_ras           <= 1'b0;
  else if(entry_inv)
    entry_ras           <= 1'b0;
  else if(entry_wen[1] && entry_update_en)
    entry_ras           <= entry_update_ras;
  else
    entry_ras           <= entry_ras;
end

always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    entry_tag[14:0]     <= 15'b0;
    entry_way_pred[1:0] <= 2'b0;
    entry_target[19:0]  <= 20'b0;
  end
  else if(entry_inv)
  begin
    entry_tag[14:0]     <= 15'b0;
    entry_way_pred[1:0] <= 2'b0;
    entry_target[19:0]  <= 20'b0;
  end
  else if(entry_wen[0] && entry_update_en)
  begin
    entry_tag[14:0]     <= entry_update_data[36:22];
    entry_way_pred[1:0] <= entry_update_data[21:20];
    entry_target[19:0]  <= entry_update_data[19:0];
  end
  else
  begin
    entry_tag[14:0]     <= entry_tag[14:0]; 
    entry_way_pred[1:0] <= entry_way_pred[1:0];
    entry_target[19:0]  <= entry_target[19:0];
  end
end


// &Force("output","entry_vld"); @111
// &Force("output","entry_cnt"); @112
// &Force("output","entry_ras"); @113
// &Force("output","entry_tag"); @114
// &Force("output","entry_way_pred"); @115
// &Force("output","entry_target"); @116

// &ModuleEnd; @118
endmodule


