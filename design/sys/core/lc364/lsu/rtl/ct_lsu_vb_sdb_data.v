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
module ct_lsu_vb_sdb_data (
  // &Ports, @26
  input    wire           cp0_lsu_icg_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [255:0]  ld_da_data256,
  input    wire  [2  :0]  ld_da_vb_borrow_vb,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [1  :0]  sdb_create_data_order,
  input    wire  [2  :0]  sdb_create_en,
  input    wire  [3  :0]  sdb_entry_data_index,
  input    wire  [2  :0]  sdb_inv_en,
  input    wire  [2  :0]  snq_data_bypass_hit,
  input    wire  [2  :0]  snq_vb_bypass_invalid,
  input    wire           snq_vb_bypass_readonce,
  input    wire  [2  :0]  snq_vb_bypass_start,
  input    wire  [2  :0]  vb_data_entry_biu_req_success,
  input    wire  [2  :0]  vb_data_entry_create_dp_vld,
  input    wire  [2  :0]  vb_data_entry_create_gateclk_en,
  input    wire  [2  :0]  vb_data_entry_create_vld,
  input    wire  [2  :0]  vb_data_entry_wd_sm_grnt,
  input    wire  [1  :0]  vb_rcl_sm_addr_id,
  input    wire           vb_rcl_sm_data_dcache_dirty,
  input    wire  [2  :0]  vb_rcl_sm_data_set_data_done,
  input    wire           vb_rcl_sm_inv,
  input    wire           vb_rcl_sm_lfb_create,
  input    wire  [3  :0]  vb_wd_sm_data_bias,
  input    wire  [2  :0]  vb_wd_sm_data_pop_req,
  output   wire  [2  :0]  sdb_data_vld,
  output   wire  [2  :0]  sdb_entry_avail,
  output   wire  [127:0]  sdb_entry_data_0,
  output   wire  [127:0]  sdb_entry_data_1,
  output   wire  [127:0]  sdb_entry_data_2,
  output   wire  [2  :0]  sdb_vld,
  output   wire  [1  :0]  vb_data_entry_addr_id_0,
  output   wire  [1  :0]  vb_data_entry_addr_id_1,
  output   wire  [1  :0]  vb_data_entry_addr_id_2,
  output   wire  [2  :0]  vb_data_entry_biu_req,
  output   wire  [2  :0]  vb_data_entry_bypass_pop,
  output   wire  [2  :0]  vb_data_entry_dirty,
  output   wire  [2  :0]  vb_data_entry_inv,
  output   wire  [2  :0]  vb_data_entry_lfb_create,
  output   wire  [2  :0]  vb_data_entry_normal_pop,
  output   wire  [2  :0]  vb_data_entry_req_success,
  output   wire  [2  :0]  vb_data_entry_vld,
  output   wire  [2  :0]  vb_data_entry_wd_sm_req,
  output   wire  [127:0]  vb_data_entry_write_data128_0,
  output   wire  [127:0]  vb_data_entry_write_data128_1,
  output   wire  [127:0]  vb_data_entry_write_data128_2,
  output   wire  [2  :0]  vb_sdb_data_entry_vld
); 



// &Regs; @27
// &Wires; @28


parameter DATA_ENTRY       = 3;

//==========================================================
//              Instance data entry
//==========================================================
//3 data entry(share with sdb)
// &ConnRule(s/_x$/[0]/); @36
// &ConnRule(s/_v$/_0/); @37
// &Instance("ct_lsu_vb_sdb_data_entry","x_ct_lsu_vb_sdb_data_entry_0"); @38
ct_lsu_vb_sdb_data_entry  x_ct_lsu_vb_sdb_data_entry_0 (
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
  .cpurst_b                           (cpurst_b                          ),
  .forever_cpuclk                     (forever_cpuclk                    ),
  .ld_da_data256                      (ld_da_data256                     ),
  .ld_da_vb_borrow_vb_x               (ld_da_vb_borrow_vb[0]             ),
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
  .sdb_create_data_order              (sdb_create_data_order             ),
  .sdb_create_en_x                    (sdb_create_en[0]                  ),
  .sdb_data_vld_x                     (sdb_data_vld[0]                   ),
  .sdb_entry_avail_x                  (sdb_entry_avail[0]                ),
  .sdb_entry_data_index               (sdb_entry_data_index              ),
  .sdb_entry_data_v                   (sdb_entry_data_0                  ),
  .sdb_inv_en_x                       (sdb_inv_en[0]                     ),
  .sdb_vld_x                          (sdb_vld[0]                        ),
  .snq_data_bypass_hit_x              (snq_data_bypass_hit[0]            ),
  .snq_vb_bypass_invalid_x            (snq_vb_bypass_invalid[0]          ),
  .snq_vb_bypass_readonce             (snq_vb_bypass_readonce            ),
  .snq_vb_bypass_start_x              (snq_vb_bypass_start[0]            ),
  .vb_data_entry_addr_id_v            (vb_data_entry_addr_id_0           ),
  .vb_data_entry_biu_req_success_x    (vb_data_entry_biu_req_success[0]  ),
  .vb_data_entry_biu_req_x            (vb_data_entry_biu_req[0]          ),
  .vb_data_entry_bypass_pop_x         (vb_data_entry_bypass_pop[0]       ),
  .vb_data_entry_create_dp_vld_x      (vb_data_entry_create_dp_vld[0]    ),
  .vb_data_entry_create_gateclk_en_x  (vb_data_entry_create_gateclk_en[0]),
  .vb_data_entry_create_vld_x         (vb_data_entry_create_vld[0]       ),
  .vb_data_entry_dirty_x              (vb_data_entry_dirty[0]            ),
  .vb_data_entry_inv_x                (vb_data_entry_inv[0]              ),
  .vb_data_entry_lfb_create_x         (vb_data_entry_lfb_create[0]       ),
  .vb_data_entry_normal_pop_x         (vb_data_entry_normal_pop[0]       ),
  .vb_data_entry_req_success_x        (vb_data_entry_req_success[0]      ),
  .vb_data_entry_vld_x                (vb_data_entry_vld[0]              ),
  .vb_data_entry_wd_sm_grnt_x         (vb_data_entry_wd_sm_grnt[0]       ),
  .vb_data_entry_wd_sm_req_x          (vb_data_entry_wd_sm_req[0]        ),
  .vb_data_entry_write_data128_v      (vb_data_entry_write_data128_0     ),
  .vb_rcl_sm_addr_id                  (vb_rcl_sm_addr_id                 ),
  .vb_rcl_sm_data_dcache_dirty        (vb_rcl_sm_data_dcache_dirty       ),
  .vb_rcl_sm_data_set_data_done_x     (vb_rcl_sm_data_set_data_done[0]   ),
  .vb_rcl_sm_inv                      (vb_rcl_sm_inv                     ),
  .vb_rcl_sm_lfb_create               (vb_rcl_sm_lfb_create              ),
  .vb_sdb_data_entry_vld_x            (vb_sdb_data_entry_vld[0]          ),
  .vb_wd_sm_data_bias                 (vb_wd_sm_data_bias                ),
  .vb_wd_sm_data_pop_req_x            (vb_wd_sm_data_pop_req[0]          )
);


// &ConnRule(s/_x$/[1]/); @40
// &ConnRule(s/_v$/_1/); @41
// &Instance("ct_lsu_vb_sdb_data_entry","x_ct_lsu_vb_sdb_data_entry_1"); @42
ct_lsu_vb_sdb_data_entry  x_ct_lsu_vb_sdb_data_entry_1 (
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
  .cpurst_b                           (cpurst_b                          ),
  .forever_cpuclk                     (forever_cpuclk                    ),
  .ld_da_data256                      (ld_da_data256                     ),
  .ld_da_vb_borrow_vb_x               (ld_da_vb_borrow_vb[1]             ),
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
  .sdb_create_data_order              (sdb_create_data_order             ),
  .sdb_create_en_x                    (sdb_create_en[1]                  ),
  .sdb_data_vld_x                     (sdb_data_vld[1]                   ),
  .sdb_entry_avail_x                  (sdb_entry_avail[1]                ),
  .sdb_entry_data_index               (sdb_entry_data_index              ),
  .sdb_entry_data_v                   (sdb_entry_data_1                  ),
  .sdb_inv_en_x                       (sdb_inv_en[1]                     ),
  .sdb_vld_x                          (sdb_vld[1]                        ),
  .snq_data_bypass_hit_x              (snq_data_bypass_hit[1]            ),
  .snq_vb_bypass_invalid_x            (snq_vb_bypass_invalid[1]          ),
  .snq_vb_bypass_readonce             (snq_vb_bypass_readonce            ),
  .snq_vb_bypass_start_x              (snq_vb_bypass_start[1]            ),
  .vb_data_entry_addr_id_v            (vb_data_entry_addr_id_1           ),
  .vb_data_entry_biu_req_success_x    (vb_data_entry_biu_req_success[1]  ),
  .vb_data_entry_biu_req_x            (vb_data_entry_biu_req[1]          ),
  .vb_data_entry_bypass_pop_x         (vb_data_entry_bypass_pop[1]       ),
  .vb_data_entry_create_dp_vld_x      (vb_data_entry_create_dp_vld[1]    ),
  .vb_data_entry_create_gateclk_en_x  (vb_data_entry_create_gateclk_en[1]),
  .vb_data_entry_create_vld_x         (vb_data_entry_create_vld[1]       ),
  .vb_data_entry_dirty_x              (vb_data_entry_dirty[1]            ),
  .vb_data_entry_inv_x                (vb_data_entry_inv[1]              ),
  .vb_data_entry_lfb_create_x         (vb_data_entry_lfb_create[1]       ),
  .vb_data_entry_normal_pop_x         (vb_data_entry_normal_pop[1]       ),
  .vb_data_entry_req_success_x        (vb_data_entry_req_success[1]      ),
  .vb_data_entry_vld_x                (vb_data_entry_vld[1]              ),
  .vb_data_entry_wd_sm_grnt_x         (vb_data_entry_wd_sm_grnt[1]       ),
  .vb_data_entry_wd_sm_req_x          (vb_data_entry_wd_sm_req[1]        ),
  .vb_data_entry_write_data128_v      (vb_data_entry_write_data128_1     ),
  .vb_rcl_sm_addr_id                  (vb_rcl_sm_addr_id                 ),
  .vb_rcl_sm_data_dcache_dirty        (vb_rcl_sm_data_dcache_dirty       ),
  .vb_rcl_sm_data_set_data_done_x     (vb_rcl_sm_data_set_data_done[1]   ),
  .vb_rcl_sm_inv                      (vb_rcl_sm_inv                     ),
  .vb_rcl_sm_lfb_create               (vb_rcl_sm_lfb_create              ),
  .vb_sdb_data_entry_vld_x            (vb_sdb_data_entry_vld[1]          ),
  .vb_wd_sm_data_bias                 (vb_wd_sm_data_bias                ),
  .vb_wd_sm_data_pop_req_x            (vb_wd_sm_data_pop_req[1]          )
);


// &ConnRule(s/_x$/[2]/); @44
// &ConnRule(s/_v$/_2/); @45
// &Instance("ct_lsu_vb_sdb_data_entry","x_ct_lsu_vb_sdb_data_entry_2"); @46
ct_lsu_vb_sdb_data_entry  x_ct_lsu_vb_sdb_data_entry_2 (
  .cp0_lsu_icg_en                     (cp0_lsu_icg_en                    ),
  .cpurst_b                           (cpurst_b                          ),
  .forever_cpuclk                     (forever_cpuclk                    ),
  .ld_da_data256                      (ld_da_data256                     ),
  .ld_da_vb_borrow_vb_x               (ld_da_vb_borrow_vb[2]             ),
  .pad_yy_icg_scan_en                 (pad_yy_icg_scan_en                ),
  .sdb_create_data_order              (sdb_create_data_order             ),
  .sdb_create_en_x                    (sdb_create_en[2]                  ),
  .sdb_data_vld_x                     (sdb_data_vld[2]                   ),
  .sdb_entry_avail_x                  (sdb_entry_avail[2]                ),
  .sdb_entry_data_index               (sdb_entry_data_index              ),
  .sdb_entry_data_v                   (sdb_entry_data_2                  ),
  .sdb_inv_en_x                       (sdb_inv_en[2]                     ),
  .sdb_vld_x                          (sdb_vld[2]                        ),
  .snq_data_bypass_hit_x              (snq_data_bypass_hit[2]            ),
  .snq_vb_bypass_invalid_x            (snq_vb_bypass_invalid[2]          ),
  .snq_vb_bypass_readonce             (snq_vb_bypass_readonce            ),
  .snq_vb_bypass_start_x              (snq_vb_bypass_start[2]            ),
  .vb_data_entry_addr_id_v            (vb_data_entry_addr_id_2           ),
  .vb_data_entry_biu_req_success_x    (vb_data_entry_biu_req_success[2]  ),
  .vb_data_entry_biu_req_x            (vb_data_entry_biu_req[2]          ),
  .vb_data_entry_bypass_pop_x         (vb_data_entry_bypass_pop[2]       ),
  .vb_data_entry_create_dp_vld_x      (vb_data_entry_create_dp_vld[2]    ),
  .vb_data_entry_create_gateclk_en_x  (vb_data_entry_create_gateclk_en[2]),
  .vb_data_entry_create_vld_x         (vb_data_entry_create_vld[2]       ),
  .vb_data_entry_dirty_x              (vb_data_entry_dirty[2]            ),
  .vb_data_entry_inv_x                (vb_data_entry_inv[2]              ),
  .vb_data_entry_lfb_create_x         (vb_data_entry_lfb_create[2]       ),
  .vb_data_entry_normal_pop_x         (vb_data_entry_normal_pop[2]       ),
  .vb_data_entry_req_success_x        (vb_data_entry_req_success[2]      ),
  .vb_data_entry_vld_x                (vb_data_entry_vld[2]              ),
  .vb_data_entry_wd_sm_grnt_x         (vb_data_entry_wd_sm_grnt[2]       ),
  .vb_data_entry_wd_sm_req_x          (vb_data_entry_wd_sm_req[2]        ),
  .vb_data_entry_write_data128_v      (vb_data_entry_write_data128_2     ),
  .vb_rcl_sm_addr_id                  (vb_rcl_sm_addr_id                 ),
  .vb_rcl_sm_data_dcache_dirty        (vb_rcl_sm_data_dcache_dirty       ),
  .vb_rcl_sm_data_set_data_done_x     (vb_rcl_sm_data_set_data_done[2]   ),
  .vb_rcl_sm_inv                      (vb_rcl_sm_inv                     ),
  .vb_rcl_sm_lfb_create               (vb_rcl_sm_lfb_create              ),
  .vb_sdb_data_entry_vld_x            (vb_sdb_data_entry_vld[2]          ),
  .vb_wd_sm_data_bias                 (vb_wd_sm_data_bias                ),
  .vb_wd_sm_data_pop_req_x            (vb_wd_sm_data_pop_req[2]          )
);


//==========================================================
//              Interface with VB
//==========================================================
//input

//output

//==========================================================
//              Interface with SNQ
//==========================================================
//input

//output

// &ModuleEnd; @62
endmodule


