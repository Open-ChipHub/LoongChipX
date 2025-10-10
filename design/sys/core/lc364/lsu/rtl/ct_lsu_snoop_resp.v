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
module ct_lsu_snoop_resp (
  // &Ports, @23
  input    wire           biu_lsu_cd_ready,
  input    wire           biu_lsu_cr_ready,
  input    wire  [4  :0]  ctcq_biu_cr_resp,
  input    wire           ctcq_biu_cr_valid,
  input    wire  [127:0]  sdb_biu_cd_data,
  input    wire           sdb_biu_cd_last,
  input    wire           sdb_biu_cd_valid,
  input    wire  [4  :0]  snq_biu_cr_resp,
  input    wire           snq_biu_cr_valid,
  output   wire           biu_ctcq_cr_ready,
  output   wire           biu_lsu_cr_resp_acept,
  output   wire           biu_sdb_cd_ready,
  output   wire           biu_snq_cr_ready,
  output   wire  [127:0]  lsu_biu_cd_data,
  output   wire           lsu_biu_cd_last,
  output   wire           lsu_biu_cd_valid,
  output   wire  [4  :0]  lsu_biu_cr_resp,
  output   wire           lsu_biu_cr_valid
); 



// &Regs; @24
// &Wires; @25


//cr channel
// &Force("output","lsu_biu_cr_valid"); @28
assign lsu_biu_cr_valid     = snq_biu_cr_valid || ctcq_biu_cr_valid;
assign lsu_biu_cr_resp[4:0] = (snq_biu_cr_resp[4:0]  & {5{snq_biu_cr_valid}})
                            | (ctcq_biu_cr_resp[4:0] & {5{ctcq_biu_cr_valid}});

assign biu_snq_cr_ready  = biu_lsu_cr_ready;
assign biu_ctcq_cr_ready = biu_lsu_cr_ready;

assign biu_lsu_cr_resp_acept  = lsu_biu_cr_valid && biu_lsu_cr_ready;

//cd channel
assign lsu_biu_cd_valid       = sdb_biu_cd_valid;
assign lsu_biu_cd_data[127:0] = sdb_biu_cd_data[127:0];
assign lsu_biu_cd_last        = sdb_biu_cd_last;

assign biu_sdb_cd_ready = biu_lsu_cd_ready;


// &ModuleEnd; @49
endmodule


