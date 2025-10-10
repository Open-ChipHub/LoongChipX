/*Copyright 2020-2021 T-Head Semiconductor Co., Ltd.

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

// ADDR is 28-bit, 4K address
// Flag includes: Strong Order, Cacheable, Bufferable, Shareable, Security

/**
 * //// IFU
 * iutlb_flg_aft_bypass[13:9] = SYSMAP_FLG[4:0]
 * 
 * assign mmu_ifu_buf      = iutlb_flg_aft_bypass[11]
 *                       || !iutlb_flg_aft_bypass[13]; //when !so, always buf
 * 
 * assign mmu_ifu_sec      = iutlb_flg_aft_bypass[9];
 * assign mmu_ifu_ca       = iutlb_flg_aft_bypass[12];
 * 
 * 
 * //// LSU 
 * 
 * dutlb_fin_flg[13:9] = SYSMAP_FLG[4:0]
 * 
 * |strong|cache|buffer|share|security|
 *    0      1     0      0       0     /// load/store
 *    1      0     0      0       0     /// device
 * 
 * assign mmu_lsu_sh_x  = dutlb_fin_flg[10] && !biu_mmu_smp_disable;
 * assign mmu_lsu_buf_x = dutlb_fin_flg[11]
 *                    || !dutlb_fin_flg[13]; //when !so, always buf
 * assign mmu_lsu_so_x  = dutlb_fin_flg[13];
 * assign mmu_lsu_sec_x = dutlb_fin_flg[9];
 * assign mmu_lsu_ca_x  = dutlb_fin_flg[12] && !dutlb_fin_flg[13];
 *  
 */


`define SYSMAP_BASE_ADDR0  28'h01000
`define SYSMAP_FLG0        5'b01111

`define SYSMAP_BASE_ADDR1  28'h02000
`define SYSMAP_FLG1        5'b01111

`define SYSMAP_BASE_ADDR2  28'hd0000
`define SYSMAP_FLG2        5'b01111

`define SYSMAP_BASE_ADDR3  28'heffff
`define SYSMAP_FLG3        5'b01111

`define SYSMAP_BASE_ADDR4  28'hfffff
`define SYSMAP_FLG4        5'b01111

`define SYSMAP_BASE_ADDR5  28'h4000000
`define SYSMAP_FLG5        5'b10000

`define SYSMAP_BASE_ADDR6  28'h8000000 
`define SYSMAP_FLG6        5'b10000

`define SYSMAP_BASE_ADDR7  28'hfffffff 
`define SYSMAP_FLG7        5'b10000


//End ct_mmu_sysmap

