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
module ct_hpcp_cnten_reg (
  // &Ports, @23
  input    wire         cntinten_wen_x,
  input    wire         cpurst_b,
  input    wire         hpcp_clk,
  input    wire  [1:0]  cp0_yy_priv_mode,
  input    wire  [3:0]  hpcp_wdata_x,
  output   wire         cntinten_x
); 


// &Regs; @24
reg       plv0;
reg       plv1;
reg       plv2;
reg       plv3;
// &Wires @25


always @(posedge hpcp_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
      plv0 <= 1'b0;
      plv1 <= 1'b0;
      plv2 <= 1'b0;
      plv3 <= 1'b0;
  end
  else if(cntinten_wen_x) begin 
      plv0 <= hpcp_wdata_x[0];
      plv1 <= hpcp_wdata_x[1];
      plv2 <= hpcp_wdata_x[2];
      plv3 <= hpcp_wdata_x[3];
  end
  else begin
      plv0 <= plv0;
      plv1 <= plv1;
      plv2 <= plv2;
      plv3 <= plv3;
  end
end

assign  cntinten_x = ( plv0 && (cp0_yy_priv_mode==2'b00)
                    || plv1 && (cp0_yy_priv_mode==2'b01)
                    || plv2 && (cp0_yy_priv_mode==2'b10)
                    || plv3 && (cp0_yy_priv_mode==2'b11)
                    );

// &Force("output","cntinten_x"); @37
// &ModuleEnd; @38
endmodule


