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

// &Depend("ct_spsram_128x144.vp"); @23
// &Depend("ct_spsram_256x144.vp"); @24
// &Depend("ct_spsram_512x144.vp"); @25
// &Depend("ct_spsram_1024x144.vp"); @26
// &Depend("ct_spsram_2048x144.vp"); @27
// &Depend("ct_spsram_4096x144.vp"); @28

module ct_l2cache_dirty_array_16way #(
  parameter TAG_INDEX_WIDTH   = `L2C_TAG_INDEX_WIDTH
)(
  input    wire          dirty_cen,
  input    wire          dirty_clk,
  input    wire  [143:0] dirty_din,
  input    wire          dirty_gwen,
  input    wire  [TAG_INDEX_WIDTH-1:0]  dirty_idx,
  input    wire  [143:0] dirty_wen,
  output   wire  [143:0] dirty_dout
); 


//csky vperl_off
//==========================================================
//              Instance dcache array
//==========================================================
`ifdef L2_CACHE_256K
ct_spsram_128x144  x_ct_spsram_128x144 (
`endif
`ifdef L2_CACHE_512K
ct_spsram_256x144  x_ct_spsram_256x144 (
`endif
`ifdef L2_CACHE_1M
ct_spsram_512x144 x_ct_spsram_512x144 (
`endif
`ifdef L2_CACHE_2M
ct_spsram_1024x144 x_ct_spsram_1024x144 (
`endif
`ifdef L2_CACHE_4M
ct_spsram_2048x144 x_ct_spsram_2048x144 (
`endif
`ifdef L2_CACHE_8M
ct_spsram_4096x144 x_ct_spsram_4096x144 (
`endif
`ifdef MEM_CFG_IN
  .mem_cfg_in (mem_cfg_in),
`endif
  .A          (dirty_idx ),
  .CEN        (dirty_cen ),
  .CLK        (dirty_clk ),
  .D          (dirty_din ),
  .GWEN       (dirty_gwen),
  .Q          (dirty_dout),
  .WEN        (dirty_wen )
);
//csky vperl_on

endmodule




