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
module ct_mp_clk_top (
  // &Ports, @23
  input    wire         axim_clk_en,
  input    wire         l2c_data_ram_clk_en_bank_0,
  input    wire         l2c_data_ram_clk_en_bank_1,
  input    wire         l2c_tag_ram_clk_en_bank_0,
  input    wire         l2c_tag_ram_clk_en_bank_1,
  input    wire         pad_had_jtg_tclk,
  input    wire  [2:0]  pad_l2c_data_mbist_clk_ratio,
  input    wire  [2:0]  pad_l2c_tag_mbist_clk_ratio,
  input    wire         pad_yy_dft_clk_rst_b,
  input    wire         pad_yy_icg_scan_en,
  input    wire         pad_yy_mbist_mode,
  input    wire         pad_yy_scan_mode,
  input    wire         phl_rst_b,
  input    wire         pll_cpu_clk,
  output   wire         apb_clk,
  output   wire         apb_clk_en,
  output   reg          axim_clk_en_f,
  output   wire         forever_core0_clk,
  output   wire         forever_core1_clk,
  output   wire         forever_core2_clk,
  output   wire         forever_core3_clk,
  output   wire         forever_cpuclk,
  output   wire         forever_jtgclk,
  output   wire         l2c_data_clk_bank_0,
  output   wire         l2c_data_clk_bank_1,
  output   wire         l2c_tag_clk_bank_0,
  output   wire         l2c_tag_clk_bank_1
); 



// &Regs; @24
reg            apb_clk_en_f;                  
reg     [2:0]  l2c_data_ram_bist_clk_ratio;   
reg     [2:0]  l2c_tag_ram_bist_clk_ratio;    
reg            peripheral_clk_en;             

// &Wires; @25
wire           bist_clk;                      
wire           bist_clk_en;                   
wire           data_ram_bist_cnt_idle;        
wire           data_ram_clk_en_bank_0;        
wire           data_ram_clk_en_bank_1;        
wire           l2c_data_clk_bank_0_before_occ; 
wire           l2c_data_clk_bank_1_before_occ; 
wire           l2c_tag_clk_bank_0_before_occ; 
wire           l2c_tag_clk_bank_1_before_occ; 
wire           tag_ram_bist_cnt_idle;         
wire           tag_ram_clk_en_bank_0;         
wire           tag_ram_clk_en_bank_1;         


// //&Depend("BUFGCE.v"); @27
//================================================
//            CPU_CLOCK
//================================================
// &Force("output", "forever_cpuclk"); @31
assign forever_cpuclk = pll_cpu_clk;
// &Instance("clk_buf_cell", "x_ct_mp_top_clk_buf"); @35
// &Connect(.buf_in   (pll_cpu_clk), @36
//          .buf_out  (forever_cpuclk)); @37

assign forever_core0_clk = forever_cpuclk;

assign forever_core1_clk = forever_cpuclk;

assign forever_core2_clk = forever_cpuclk;

assign forever_core3_clk = forever_cpuclk;

//================================================
//            JTAG_CLOCK
//================================================

assign forever_jtgclk = pad_had_jtg_tclk;

//================================================
//            APB CLOCK
//================================================
// &Force("output", "apb_clk_en"); @81
// &Force("input",  "phl_rst_b"); @82

always@(posedge pll_cpu_clk or negedge phl_rst_b)
begin
  if (!phl_rst_b)
    peripheral_clk_en <= 1'b0;
  else
    peripheral_clk_en <= ~peripheral_clk_en;
end

always@(posedge pll_cpu_clk)
begin
  apb_clk_en_f <= peripheral_clk_en;
end

assign apb_clk_en = pad_yy_scan_mode ? 1'b1 : apb_clk_en_f;

// &Force("output","apb_clk"); @104
assign apb_clk = pll_cpu_clk;

//================================================
//            SLVIF CLK_EN
//================================================
// &Force("output", "slvif_clk_en_f"); @134

//================================================
//           AXIM CLK_EN
//================================================
// &Force("output", "axim_clk_en_f"); @145

always@(posedge forever_cpuclk)
begin
  axim_clk_en_f <= axim_clk_en;
end


//================================================
//            L2C DATA CLOCK
//================================================
assign bist_clk_en = pad_yy_mbist_mode | pad_yy_scan_mode;
// &Instance("gated_clk_cell", "x_data_bist_gated_clk"); @157
gated_clk_cell  x_data_bist_gated_clk (
  .clk_in             (pll_cpu_clk       ),
  .clk_out            (bist_clk          ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (bist_clk_en       ),
  .module_en          (1'b0              ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (pll_cpu_clk        ), @158
//          .external_en   (1'b0               ), @159
//          .global_en     (1'b1               ), @160
//          .module_en     (1'b0               ), @161
//          .local_en      (bist_clk_en        ), @162
//          .clk_out       (bist_clk           ) @163
//         ); @164

always@(posedge bist_clk or negedge pad_yy_dft_clk_rst_b) 
begin
  if (!pad_yy_dft_clk_rst_b)
    l2c_data_ram_bist_clk_ratio[2:0] <= 3'b0;
  else if (bist_clk_en) begin
    if (data_ram_bist_cnt_idle)
      l2c_data_ram_bist_clk_ratio[2:0] <= pad_l2c_data_mbist_clk_ratio[2:0];
    else
      l2c_data_ram_bist_clk_ratio[2:0] <= l2c_data_ram_bist_clk_ratio[2:0] - 3'b001;
  end
end

assign data_ram_bist_cnt_idle = l2c_data_ram_bist_clk_ratio[2:0] == 3'b000;

assign data_ram_clk_en_bank_0 = bist_clk_en ? data_ram_bist_cnt_idle : l2c_data_ram_clk_en_bank_0;
assign data_ram_clk_en_bank_1 = bist_clk_en ? data_ram_bist_cnt_idle : l2c_data_ram_clk_en_bank_1;

// &Force("nonport","l2c_data_clk_bank_0_before_occ"); @184
// &Force("nonport","l2c_data_clk_bank_1_before_occ"); @185
// &Force("nonport","data_ram_clk_en_bank_0"); @186
// &Force("nonport","data_ram_clk_en_bank_1"); @187

assign l2c_data_clk_bank_0_before_occ = pll_cpu_clk;
assign l2c_data_clk_bank_1_before_occ = pll_cpu_clk;


assign l2c_data_clk_bank_0 = l2c_data_clk_bank_0_before_occ;
assign l2c_data_clk_bank_1 = l2c_data_clk_bank_1_before_occ;
// &Instance("clk_buf_cell", "x_l2c_data_bank0_clk_buf"); @228
// &Connect(.buf_in   (l2c_data_clk_bank_0_before_occ), @229
//          .buf_out  (l2c_data_clk_bank_0)); @230
// &Instance("clk_buf_cell", "x_l2c_data_bank1_clk_buf"); @232
// &Connect(.buf_in   (l2c_data_clk_bank_1_before_occ), @233
//          .buf_out  (l2c_data_clk_bank_1)); @234
         
//================================================
//            L2C TAG CLOCK
//================================================
always@(posedge bist_clk or negedge pad_yy_dft_clk_rst_b)
begin
  if (!pad_yy_dft_clk_rst_b)
    l2c_tag_ram_bist_clk_ratio[2:0] <= 3'b0;
  else if (bist_clk_en) begin
    if (tag_ram_bist_cnt_idle)
      l2c_tag_ram_bist_clk_ratio[2:0] <= pad_l2c_tag_mbist_clk_ratio[2:0];
    else
      l2c_tag_ram_bist_clk_ratio[2:0] <= l2c_tag_ram_bist_clk_ratio[2:0] - 3'b001;
  end
end

assign tag_ram_bist_cnt_idle = l2c_tag_ram_bist_clk_ratio[2:0] == 3'b000;

assign tag_ram_clk_en_bank_0 = bist_clk_en ? tag_ram_bist_cnt_idle : l2c_tag_ram_clk_en_bank_0;
assign tag_ram_clk_en_bank_1 = bist_clk_en ? tag_ram_bist_cnt_idle : l2c_tag_ram_clk_en_bank_1;

// &Force("nonport","l2c_tag_clk_bank_0_before_occ"); @258
// &Force("nonport","l2c_tag_clk_bank_1_before_occ"); @259
// &Force("nonport","tag_ram_clk_en_bank_0"); @260
// &Force("nonport","tag_ram_clk_en_bank_1"); @261

assign l2c_tag_clk_bank_0_before_occ = pll_cpu_clk;
assign l2c_tag_clk_bank_1_before_occ = pll_cpu_clk;

assign l2c_tag_clk_bank_0 = l2c_tag_clk_bank_0_before_occ;
assign l2c_tag_clk_bank_1 = l2c_tag_clk_bank_1_before_occ;
// &Instance("clk_buf_cell", "x_l2c_tag_bank0_clk_buf"); @301
// &Connect(.buf_in   (l2c_tag_clk_bank_0_before_occ), @302
//          .buf_out  (l2c_tag_clk_bank_0)); @303
// &Instance("clk_buf_cell", "x_l2c_tag_bank1_clk_buf"); @305
// &Connect(.buf_in   (l2c_tag_clk_bank_1_before_occ), @306
//          .buf_out  (l2c_tag_clk_bank_1)); @307

// &ModuleEnd; @310
endmodule


