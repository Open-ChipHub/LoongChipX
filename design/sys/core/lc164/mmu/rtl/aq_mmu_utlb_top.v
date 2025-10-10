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
module aq_mmu_utlb_top (
  // &Ports, @23
  input    wire          arb_dutlb_grant,
  input    wire          arb_iutlb_grant,
  input    wire          cp0_mmu_icg_en,
  input    wire          cp0_mmu_lpmd_req,
  input    wire          cp0_mmu_mxr,
  input    wire          cp0_mmu_satp_wen,
  input    wire          cp0_mmu_sum,
  input    wire  [26:0]  cp0_mmu_tlb_va,
  input    wire  [63:0]  cp0_mmu_dmw0,
  input    wire  [63:0]  cp0_mmu_dmw1,
  input    wire  [63:0]  cp0_mmu_dmw2,
  input    wire  [63:0]  cp0_mmu_dmw3,
  input    wire  [1 :0]  cp0_yy_priv_mode,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          hpcp_mmu_cnt_en,
  input    wire          ifu_mmu_abort,
  input    wire  [51:0]  ifu_mmu_va,
  input    wire          ifu_mmu_va_vld,
  input    wire          jtlb_dutlb_acc_err,
  input    wire          jtlb_dutlb_pgflt,
  input    wire          jtlb_dutlb_ref_cmplt,
  input    wire          jtlb_dutlb_ref_pavld,
  input    wire          jtlb_iutlb_acc_err,
  input    wire          jtlb_iutlb_pgflt,
  input    wire          jtlb_iutlb_ref_cmplt,
  input    wire          jtlb_iutlb_ref_pavld,
  input    wire          jtlb_xx_mmu_on,
  input    wire          jtlb_xx_ref_g,
  input    wire  [14:0]  jtlb_xx_ref_flg,
  input    wire  [15:0]  jtlb_xx_ref_asid,
  input    wire  [2 :0]  jtlb_xx_ref_pgs,
  input    wire  [27:0]  jtlb_xx_ref_ppn,
  input    wire  [27:0]  jtlb_xx_ref_vpn,
  input    wire          lsu_mmu_abort,
  input    wire  [1 :0]  lsu_mmu_priv_mode,
  input    wire          lsu_mmu_st_inst,
  input    wire  [51:0]  lsu_mmu_va,
  input    wire          lsu_mmu_va_vld,
  input    wire          mmu_top_clk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          regs_mmu_en,
  input    wire  [15:0]  regs_ptw_cur_asid,
  input    wire          tlboper_xx_clr,
  input    wire          tlboper_xx_inv_va_req,
  output   wire  [15:0]  dutlb_arb_asid,
  output   wire          dutlb_arb_cmplt,
  output   wire          dutlb_arb_mach,
  output   wire  [1 :0]  dutlb_arb_mode,
  output   wire          dutlb_arb_read,
  output   wire          dutlb_arb_req,
  output   wire  [27:0]  dutlb_arb_vpn,
  output   wire  [1 :0]  dutlb_top_ref_cur_st,
  output   wire  [15:0]  iutlb_arb_asid,
  output   wire          iutlb_arb_cmplt,
  output   wire          iutlb_arb_mach,
  output   wire  [1 :0]  iutlb_arb_mode,
  output   wire          iutlb_arb_req,
  output   wire  [27:0]  iutlb_arb_vpn,
  output   wire  [1 :0]  iutlb_top_ref_cur_st,
  output   wire          mmu_hpcp_dutlb_miss,
  output   wire          mmu_hpcp_iutlb_miss,
  output   wire          mmu_ifu_access_fault,
  output   wire  [27:0]  mmu_ifu_pa,
  output   wire          mmu_ifu_pa_vld,
  output   wire  [4 :0]  mmu_ifu_prot,
  output   wire          mmu_lsu_access_fault,
  output   wire          mmu_lsu_buf,
  output   wire          mmu_lsu_ca,
  output   wire  [27:0]  mmu_lsu_pa,
  output   wire          mmu_lsu_pa_vld,
  output   wire          mmu_lsu_page_fault,
  output   wire          mmu_lsu_sec,
  output   wire          mmu_lsu_sh,
  output   wire          mmu_lsu_so
); 



// &Regs; @24
// &Wires; @25
wire            dutlb_hpcp_utlb_miss; 
wire            ifu_mmu_exec;         
wire            ifu_mmu_read;         
wire            iutlb_arb_read;       
wire            iutlb_hpcp_utlb_miss; 
wire            lsu_mmu_exec;         
wire            lsu_mmu_read;         
wire            mmu_ifu_buf;          
wire            mmu_ifu_ca;           
wire            mmu_ifu_page_fault;   
wire            mmu_ifu_sec;          
wire            mmu_ifu_sh;           
wire            mmu_ifu_so;           


//==========================================================
// Instance utlbs
//==========================================================

// &ConnRule(s/xxu/ifu/); @31
// &ConnRule(s/utlb/iutlb/); @32
// &Instance("aq_mmu_utlb","x_aq_mmu_iutlb"); @33
aq_mmu_utlb  x_aq_mmu_iutlb (
  .arb_utlb_grant        (arb_iutlb_grant      ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_lpmd_req      (cp0_mmu_lpmd_req     ),
  .cp0_mmu_mxr           (cp0_mmu_mxr          ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_sum           (cp0_mmu_sum          ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cp0_mmu_dmw0          (cp0_mmu_dmw0         ),
  .cp0_mmu_dmw1          (cp0_mmu_dmw1         ),
  .cp0_mmu_dmw2          (cp0_mmu_dmw2         ),
  .cp0_mmu_dmw3          (cp0_mmu_dmw3         ),
  .cp0_yy_priv_mode      (cp0_yy_priv_mode     ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .hpcp_mmu_cnt_en       (hpcp_mmu_cnt_en      ),
  .jtlb_utlb_acc_err     (jtlb_iutlb_acc_err   ),
  .jtlb_utlb_pgflt       (jtlb_iutlb_pgflt     ),
  .jtlb_utlb_ref_cmplt   (jtlb_iutlb_ref_cmplt ),
  .jtlb_utlb_ref_pavld   (jtlb_iutlb_ref_pavld ),
  .jtlb_xx_mmu_on        (jtlb_xx_mmu_on       ),
  .jtlb_xx_ref_g         (jtlb_xx_ref_g        ),
  .jtlb_xx_ref_flg       (jtlb_xx_ref_flg      ),
  .jtlb_xx_ref_asid      (jtlb_xx_ref_asid     ),
  .jtlb_xx_ref_pgs       (jtlb_xx_ref_pgs      ),
  .jtlb_xx_ref_ppn       (jtlb_xx_ref_ppn      ),
  .jtlb_xx_ref_vpn       (jtlb_xx_ref_vpn      ),
  .lsu_mmu_priv_mode     (lsu_mmu_priv_mode    ),
  .mmu_top_clk           (mmu_top_clk          ),
  .mmu_xxu_access_fault  (mmu_ifu_access_fault ),
  .mmu_xxu_buf           (mmu_ifu_buf          ),
  .mmu_xxu_ca            (mmu_ifu_ca           ),
  .mmu_xxu_pa            (mmu_ifu_pa           ),
  .mmu_xxu_pa_vld        (mmu_ifu_pa_vld       ),
  .mmu_xxu_page_fault    (mmu_ifu_page_fault   ),
  .mmu_xxu_sec           (mmu_ifu_sec          ),
  .mmu_xxu_sh            (mmu_ifu_sh           ),
  .mmu_xxu_so            (mmu_ifu_so           ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .regs_ptw_cur_asid     (regs_ptw_cur_asid    ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_arb_asid         (iutlb_arb_asid       ),
  .utlb_arb_cmplt        (iutlb_arb_cmplt      ),
  .utlb_arb_mach         (iutlb_arb_mach       ),
  .utlb_arb_mode         (iutlb_arb_mode       ),
  .utlb_arb_read         (iutlb_arb_read       ),
  .utlb_arb_req          (iutlb_arb_req        ),
  .utlb_arb_vpn          (iutlb_arb_vpn        ),
  .utlb_hpcp_utlb_miss   (iutlb_hpcp_utlb_miss ),
  .utlb_top_ref_cur_st   (iutlb_top_ref_cur_st ),
  .xxu_mmu_fetch         (1'b1                 ),
  .xxu_mmu_abort         (ifu_mmu_abort        ),
  .xxu_mmu_exec          (ifu_mmu_exec         ),
  .xxu_mmu_read          (ifu_mmu_read         ),
  .xxu_mmu_va            (ifu_mmu_va           ),
  .xxu_mmu_va_vld        (ifu_mmu_va_vld       )
);


// &ConnRule(s/xxu/lsu/); @35
// &ConnRule(s/utlb/dutlb/); @36
// &Instance("aq_mmu_utlb","x_aq_mmu_dutlb"); @37
aq_mmu_utlb  x_aq_mmu_dutlb (
  .arb_utlb_grant        (arb_dutlb_grant      ),
  .cp0_mmu_icg_en        (cp0_mmu_icg_en       ),
  .cp0_mmu_lpmd_req      (cp0_mmu_lpmd_req     ),
  .cp0_mmu_mxr           (cp0_mmu_mxr          ),
  .cp0_mmu_satp_wen      (cp0_mmu_satp_wen     ),
  .cp0_mmu_sum           (cp0_mmu_sum          ),
  .cp0_mmu_tlb_va        (cp0_mmu_tlb_va       ),
  .cp0_mmu_dmw0          (cp0_mmu_dmw0         ),
  .cp0_mmu_dmw1          (cp0_mmu_dmw1         ),
  .cp0_mmu_dmw2          (cp0_mmu_dmw2         ),
  .cp0_mmu_dmw3          (cp0_mmu_dmw3         ),
  .cp0_yy_priv_mode      (cp0_yy_priv_mode     ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .hpcp_mmu_cnt_en       (hpcp_mmu_cnt_en      ),
  .jtlb_utlb_acc_err     (jtlb_dutlb_acc_err   ),
  .jtlb_utlb_pgflt       (jtlb_dutlb_pgflt     ),
  .jtlb_utlb_ref_cmplt   (jtlb_dutlb_ref_cmplt ),
  .jtlb_utlb_ref_pavld   (jtlb_dutlb_ref_pavld ),
  .jtlb_xx_mmu_on        (jtlb_xx_mmu_on       ),
  .jtlb_xx_ref_g         (jtlb_xx_ref_g        ),
  .jtlb_xx_ref_flg       (jtlb_xx_ref_flg      ),
  .jtlb_xx_ref_asid      (jtlb_xx_ref_asid     ),
  .jtlb_xx_ref_pgs       (jtlb_xx_ref_pgs      ),
  .jtlb_xx_ref_ppn       (jtlb_xx_ref_ppn      ),
  .jtlb_xx_ref_vpn       (jtlb_xx_ref_vpn      ),
  .lsu_mmu_priv_mode     (lsu_mmu_priv_mode    ),
  .mmu_top_clk           (mmu_top_clk          ),
  .mmu_xxu_access_fault  (mmu_lsu_access_fault ),
  .mmu_xxu_buf           (mmu_lsu_buf          ),
  .mmu_xxu_ca            (mmu_lsu_ca           ),
  .mmu_xxu_pa            (mmu_lsu_pa           ),
  .mmu_xxu_pa_vld        (mmu_lsu_pa_vld       ),
  .mmu_xxu_page_fault    (mmu_lsu_page_fault   ),
  .mmu_xxu_sec           (mmu_lsu_sec          ),
  .mmu_xxu_sh            (mmu_lsu_sh           ),
  .mmu_xxu_so            (mmu_lsu_so           ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .regs_mmu_en           (regs_mmu_en          ),
  .regs_ptw_cur_asid     (regs_ptw_cur_asid    ),
  .tlboper_xx_clr        (tlboper_xx_clr       ),
  .tlboper_xx_inv_va_req (tlboper_xx_inv_va_req),
  .utlb_arb_asid         (dutlb_arb_asid       ),
  .utlb_arb_cmplt        (dutlb_arb_cmplt      ),
  .utlb_arb_mach         (dutlb_arb_mach       ),
  .utlb_arb_mode         (dutlb_arb_mode       ),
  .utlb_arb_read         (dutlb_arb_read       ),
  .utlb_arb_req          (dutlb_arb_req        ),
  .utlb_arb_vpn          (dutlb_arb_vpn        ),
  .utlb_hpcp_utlb_miss   (dutlb_hpcp_utlb_miss ),
  .utlb_top_ref_cur_st   (dutlb_top_ref_cur_st ),
  .xxu_mmu_fetch         (1'b0                 ),
  .xxu_mmu_abort         (lsu_mmu_abort        ),
  .xxu_mmu_exec          (lsu_mmu_exec         ),
  .xxu_mmu_read          (lsu_mmu_read         ),
  .xxu_mmu_va            (lsu_mmu_va           ),
  .xxu_mmu_va_vld        (lsu_mmu_va_vld       )
);


// I-uTLB related ports
// &Force("nonport", "mmu_ifu_so"); @40
// &Force("nonport", "mmu_ifu_sh"); @41
// &Force("nonport", "iutlb_arb_read"); @42
assign ifu_mmu_exec = 1'b1;
assign ifu_mmu_read = 1'b1;
assign mmu_hpcp_iutlb_miss = iutlb_hpcp_utlb_miss;
assign mmu_ifu_prot[4:0] = {mmu_ifu_page_fault, 
                            cp0_yy_priv_mode[1:0] == 2'b01,
                            mmu_ifu_ca, mmu_ifu_buf, mmu_ifu_sec};

// D-uTLB related ports
assign lsu_mmu_exec = 1'b0;
assign lsu_mmu_read = !lsu_mmu_st_inst;
assign mmu_hpcp_dutlb_miss = dutlb_hpcp_utlb_miss;

// &ModuleEnd; @55
endmodule


