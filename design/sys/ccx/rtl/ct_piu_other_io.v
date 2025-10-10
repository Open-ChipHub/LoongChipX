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
module ct_piu_other_io (
  // &Ports, @24
  input    wire           ciu_icg_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [3  :0]  ibiu_ciu_cnt_en,
  input    wire           ibiu_ciu_csr_sel,
  input    wire  [79 :0]  ibiu_ciu_csr_wdata,
  input    wire           ibiu_ciu_jdb_pm,
  input    wire           ibiu_ciu_lpmd_b,
  input    wire           l2cif_piu_read_data_vld,
  input    wire  [127:0]  l2cif_piux_read_data,
  input    wire           pad_yy_icg_scan_en,
  input    wire           psel_l2pmp_x,
  input    wire           regs_piu_cmplt,
  input    wire  [3  :0]  regs_piu_hpcp_l2of_int,
  input    wire  [63 :0]  regs_piux_rdata,
  input    wire           sysio_piu_dbgrq_b,
  input    wire           sysio_piu_me_int,
  input    wire           sysio_piu_ms_int,
  input    wire           sysio_piu_mt_int,
  input    wire           sysio_piu_se_int,
  input    wire           sysio_piu_ss_int,
  input    wire           sysio_piu_st_int,
  output   wire           ciu_ibiu_csr_cmplt,
  output   wire  [127:0]  ciu_ibiu_csr_rdata,
  output   wire           ciu_ibiu_dbgrq_b,
  output   wire  [3  :0]  ciu_ibiu_hpcp_l2of_int,
  output   wire           ciu_ibiu_me_int,
  output   wire           ciu_ibiu_ms_int,
  output   wire           ciu_ibiu_mt_int,
  output   wire           ciu_ibiu_se_int,
  output   wire           ciu_ibiu_ss_int,
  output   wire           ciu_ibiu_st_int,
  output   wire           perr_l2pmp_x,
  output   wire           piu_csr_sel,
  output   wire           piu_l2cif_read_data,
  output   wire           piu_l2cif_read_data_ecc,
  output   wire  [20 :0]  piu_l2cif_read_index,
  output   wire           piu_l2cif_read_req,
  output   wire           piu_l2cif_read_tag,
  output   wire           piu_l2cif_read_tag_ecc,
  output   wire  [3  :0]  piu_l2cif_read_way,
  output   wire  [3  :0]  piu_regs_hpcp_cnt_en,
  output   wire  [15 :0]  piu_regs_op,
  output   wire           piu_regs_sel,
  output   wire  [63 :0]  piu_regs_wdata,
  output   wire  [1  :0]  piu_sysio_jdb_pm,
  output   wire  [1  :0]  piu_sysio_lpmd_b,
  output   wire           piu_xx_regs_no_op,
  output   wire           pready_l2pmp_x,
  output   wire  [31 :0]  x_prdata_l2pmp
); 



// &Regs; @25
// &Wires; @26


// &Instance("ct_piu_other_io_async", "x_ct_piu_other_io_async"); @29
// &Instance("ct_piu_other_io_sync", "x_ct_piu_other_io_sync"); @31
ct_piu_other_io_sync  x_ct_piu_other_io_sync (
  .ciu_ibiu_csr_cmplt      (ciu_ibiu_csr_cmplt     ),
  .ciu_ibiu_csr_rdata      (ciu_ibiu_csr_rdata     ),
  .ciu_ibiu_dbgrq_b        (ciu_ibiu_dbgrq_b       ),
  .ciu_ibiu_hpcp_l2of_int  (ciu_ibiu_hpcp_l2of_int ),
  .ciu_ibiu_me_int         (ciu_ibiu_me_int        ),
  .ciu_ibiu_ms_int         (ciu_ibiu_ms_int        ),
  .ciu_ibiu_mt_int         (ciu_ibiu_mt_int        ),
  .ciu_ibiu_se_int         (ciu_ibiu_se_int        ),
  .ciu_ibiu_ss_int         (ciu_ibiu_ss_int        ),
  .ciu_ibiu_st_int         (ciu_ibiu_st_int        ),
  .ciu_icg_en              (ciu_icg_en             ),
  .cpurst_b                (cpurst_b               ),
  .forever_cpuclk          (forever_cpuclk         ),
  .ibiu_ciu_cnt_en         (ibiu_ciu_cnt_en        ),
  .ibiu_ciu_csr_sel        (ibiu_ciu_csr_sel       ),
  .ibiu_ciu_csr_wdata      (ibiu_ciu_csr_wdata     ),
  .ibiu_ciu_jdb_pm         (ibiu_ciu_jdb_pm        ),
  .ibiu_ciu_lpmd_b         (ibiu_ciu_lpmd_b        ),
  .l2cif_piu_read_data_vld (l2cif_piu_read_data_vld),
  .l2cif_piux_read_data    (l2cif_piux_read_data   ),
  .pad_yy_icg_scan_en      (pad_yy_icg_scan_en     ),
  .perr_l2pmp_x            (perr_l2pmp_x           ),
  .piu_csr_sel             (piu_csr_sel            ),
  .piu_l2cif_read_data     (piu_l2cif_read_data    ),
  .piu_l2cif_read_data_ecc (piu_l2cif_read_data_ecc),
  .piu_l2cif_read_index    (piu_l2cif_read_index   ),
  .piu_l2cif_read_req      (piu_l2cif_read_req     ),
  .piu_l2cif_read_tag      (piu_l2cif_read_tag     ),
  .piu_l2cif_read_tag_ecc  (piu_l2cif_read_tag_ecc ),
  .piu_l2cif_read_way      (piu_l2cif_read_way     ),
  .piu_regs_hpcp_cnt_en    (piu_regs_hpcp_cnt_en   ),
  .piu_regs_op             (piu_regs_op            ),
  .piu_regs_sel            (piu_regs_sel           ),
  .piu_regs_wdata          (piu_regs_wdata         ),
  .piu_sysio_jdb_pm        (piu_sysio_jdb_pm       ),
  .piu_sysio_lpmd_b        (piu_sysio_lpmd_b       ),
  .piu_xx_regs_no_op       (piu_xx_regs_no_op      ),
  .pready_l2pmp_x          (pready_l2pmp_x         ),
  .psel_l2pmp_x            (psel_l2pmp_x           ),
  .regs_piu_cmplt          (regs_piu_cmplt         ),
  .regs_piu_hpcp_l2of_int  (regs_piu_hpcp_l2of_int ),
  .regs_piux_rdata         (regs_piux_rdata        ),
  .sysio_piu_dbgrq_b       (sysio_piu_dbgrq_b      ),
  .sysio_piu_me_int        (sysio_piu_me_int       ),
  .sysio_piu_ms_int        (sysio_piu_ms_int       ),
  .sysio_piu_mt_int        (sysio_piu_mt_int       ),
  .sysio_piu_se_int        (sysio_piu_se_int       ),
  .sysio_piu_ss_int        (sysio_piu_ss_int       ),
  .sysio_piu_st_int        (sysio_piu_st_int       ),
  .x_prdata_l2pmp          (x_prdata_l2pmp         )
);


// &ModuleEnd; @34
endmodule


