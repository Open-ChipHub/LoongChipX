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
module ct_piu_other_io_dummy (
  // &Ports, @2
  input    wire          l2cif_piu_read_data_vld,
  input    wire          psel_l2pmp_x,
  input    wire          regs_piu_cmplt,
  output   wire          perr_l2pmp_x,
  output   wire          piu_l2cif_read_data,
  output   wire          piu_l2cif_read_data_ecc,
  output   wire  [20:0]  piu_l2cif_read_index,
  output   wire          piu_l2cif_read_req,
  output   wire          piu_l2cif_read_tag,
  output   wire          piu_l2cif_read_tag_ecc,
  output   wire  [3 :0]  piu_l2cif_read_way,
  output   wire  [15:0]  piu_regs_op,
  output   wire          piu_regs_sel,
  output   wire  [63:0]  piu_regs_wdata,
  output   wire          piu_xx_regs_no_op,
  output   wire          pready_l2pmp_x,
  output   wire  [31:0]  x_prdata_l2pmp
); 



// &Regs; @3
// &Wires; @4


assign piu_regs_sel               = 1'b0;
assign piu_regs_op[15:0]          = 16'b0;
assign piu_regs_wdata[63:0]       = 64'b0;
assign piu_xx_regs_no_op          = 1'b1;

assign piu_l2cif_read_req         = 1'b0; 
assign piu_l2cif_read_tag         = 1'b0; 
assign piu_l2cif_read_data        = 1'b0; 
assign piu_l2cif_read_tag_ecc     = 1'b0;
assign piu_l2cif_read_data_ecc    = 1'b0;
assign piu_l2cif_read_way[3:0]    = 4'b0;
assign piu_l2cif_read_index[20:0] = 21'b0;

// &Force("input", "regs_piu_cmplt"); @19
// &Force("input", "l2cif_piu_read_data_vld"); @20

assign perr_l2pmp_x         = 1'b0;
assign pready_l2pmp_x       = 1'b1;
assign x_prdata_l2pmp[31:0] = 32'b0;

// &Force("input", "psel_l2pmp_x"); @26

// &ModuleEnd; @28
endmodule


