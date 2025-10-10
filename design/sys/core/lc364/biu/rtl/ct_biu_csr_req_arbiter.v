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
module ct_biu_csr_req_arbiter (
  // &Ports, @23
  input    wire           biu_csr_cmplt,
  input    wire  [127:0]  biu_csr_rdata,
  input    wire  [15 :0]  cp0_biu_op,
  input    wire           cp0_biu_sel,
  input    wire  [63 :0]  cp0_biu_wdata,
  input    wire  [15 :0]  hpcp_biu_op,
  input    wire           hpcp_biu_sel,
  input    wire  [63 :0]  hpcp_biu_wdata,
  output   wire           biu_cp0_cmplt,
  output   wire  [127:0]  biu_cp0_rdata,
  output   reg   [15 :0]  biu_csr_op,
  output   reg            biu_csr_sel,
  output   reg   [63 :0]  biu_csr_wdata,
  output   wire           biu_hpcp_cmplt,
  output   wire  [127:0]  biu_hpcp_rdata
); 



// &Regs; @24

// &Wires; @25


// &CombBeg; @27
always @( hpcp_biu_op[15:0]
       or hpcp_biu_wdata[63:0]
       or cp0_biu_wdata[63:0]
       or cp0_biu_op[15:0]
       or cp0_biu_sel
       or hpcp_biu_sel)
begin
  if(cp0_biu_sel)
  begin
    biu_csr_sel         = 1'b1;
    biu_csr_op[15:0]    = cp0_biu_op[15:0];
    biu_csr_wdata[63:0] = cp0_biu_wdata[63:0];
  end
  else
  begin
    biu_csr_sel         = hpcp_biu_sel;
    biu_csr_op[15:0]    = hpcp_biu_op[15:0];
    biu_csr_wdata[63:0] = hpcp_biu_wdata[63:0];
  end
// &CombEnd; @40
end

assign biu_cp0_cmplt         = biu_csr_cmplt && cp0_biu_sel;
assign biu_cp0_rdata[127:0]  = biu_csr_rdata[127:0];
assign biu_hpcp_cmplt        = biu_csr_cmplt;
assign biu_hpcp_rdata[127:0] = biu_csr_rdata[127:0];

// &ModuleEnd; @47
endmodule


