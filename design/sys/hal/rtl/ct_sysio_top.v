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

// &ModuleBeg; @24
module ct_sysio_top (
  // &Ports, @25
  input    wire          apb_clk_en,
  input    wire          axim_clk_en,
  input    wire          ciu_sysio_icg_en,
  input    wire          ciu_xx_no_op,
  input    wire  [7 :0]  ext_interrupt,
  input    wire          clint_core0_ms_int,
  input    wire          clint_core0_mt_int,
  input    wire          clint_core0_ss_int,
  input    wire          clint_core0_st_int,
  input    wire          clint_core1_ms_int,
  input    wire          clint_core1_mt_int,
  input    wire          clint_core1_ss_int,
  input    wire          clint_core1_st_int,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          l2c_sysio_flush_done,
  input    wire          l2c_sysio_flush_idle,
  input    wire          pad_core0_dbg_mask,
  input    wire          pad_core0_dbgrq_b,
  input    wire          pad_core1_dbg_mask,
  input    wire          pad_core1_dbgrq_b,
  input    wire  [39:0]  pad_cpu_apb_base,
  input    wire          pad_cpu_l2cache_flush_req,
  input    wire  [63:0]  pad_cpu_sys_cnt,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [1 :0]  piu0_sysio_jdb_pm,
  input    wire  [1 :0]  piu0_sysio_lpmd_b,
  input    wire  [1 :0]  piu1_sysio_jdb_pm,
  input    wire  [1 :0]  piu1_sysio_lpmd_b,
  input    wire          plic_core0_me_int,
  input    wire          plic_core0_se_int,
  input    wire          plic_core1_me_int,
  input    wire          plic_core1_se_int,
  
  input    wire          core0_sysio_wr_req,
  input    wire  [3 :0]  core0_sysio_wr_sel,
  input    wire  [31:0]  core0_sysio_wr_ipi_send_data,
  input    wire  [63:0]  core0_sysio_wr_mail_box_send_data,
  input    wire  [63:0]  core0_sysio_mailbox0_data,
  input    wire          core0_sysio_restart_grnt,
  input    wire          core1_sysio_wr_req,
  input    wire  [3 :0]  core1_sysio_wr_sel,
  input    wire  [31:0]  core1_sysio_wr_ipi_send_data,
  input    wire  [63:0]  core1_sysio_wr_mail_box_send_data,
  input    wire  [63:0]  core1_sysio_mailbox0_data,
  input    wire          core1_sysio_restart_grnt,
  input    wire          core2_sysio_wr_req,
  input    wire  [3 :0]  core2_sysio_wr_sel,
  input    wire  [31:0]  core2_sysio_wr_ipi_send_data,
  input    wire  [63:0]  core2_sysio_wr_mail_box_send_data,
  input    wire  [63:0]  core2_sysio_mailbox0_data,
  input    wire          core2_sysio_restart_grnt,
  input    wire          core3_sysio_wr_req,
  input    wire  [3 :0]  core3_sysio_wr_sel,
  input    wire  [31:0]  core3_sysio_wr_ipi_send_data,
  input    wire  [63:0]  core3_sysio_wr_mail_box_send_data,
  input    wire  [63:0]  core3_sysio_mailbox0_data,
  input    wire          core3_sysio_restart_grnt,
  output   wire  [1 :0]  core0_pad_jdb_pm,
  output   wire  [1 :0]  core0_pad_lpmd_b,
  output   wire  [1 :0]  core1_pad_jdb_pm,
  output   wire  [1 :0]  core1_pad_lpmd_b,
  output   wire  [1 :0]  core2_pad_jdb_pm,
  output   wire  [1 :0]  core2_pad_lpmd_b,
  output   wire  [1 :0]  core3_pad_jdb_pm,
  output   wire  [1 :0]  core3_pad_lpmd_b,
  output   reg           cpu_pad_l2cache_flush_done,
  output   reg           cpu_pad_no_op,
  output   wire  [39:0]  sysio_ciu_apb_base,
  output   wire  [63:0]  sysio_clint_mtime,
  output   wire  [3 :0]  sysio_had_dbg_mask,
  output   reg           sysio_l2c_flush_req,
  output   wire  [63:0]  sysio_core0_restart_entry,
  output   wire          sysio_core0_restart_vld,
  output   wire          sysio_core0_cp0_update_ipi_status_en,
  output   wire  [31:0]  sysio_core0_cp0_update_ipi_status_src,
  output   wire          sysio_core0_cp0_update_mailbox0_en,
  output   wire          sysio_core0_cp0_update_mailbox1_en,
  output   wire          sysio_core0_cp0_update_mailbox2_en,
  output   wire          sysio_core0_cp0_update_mailbox3_en,
  output   wire          sysio_core0_cp0_req_grnt,
  output   wire  [3 :0]  sysio_core0_cp0_update_bit_sel,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_src0,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_src1,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_src2,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_src3,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_mask0,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_mask1,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_mask2,
  output   wire  [31:0]  sysio_core0_cp0_update_mailbox_mask3,
  output   wire          sysio_core1_cp0_update_ipi_status_en,
  output   wire  [31:0]  sysio_core1_cp0_update_ipi_status_src,
  output   wire          sysio_core1_cp0_update_mailbox0_en,
  output   wire          sysio_core1_cp0_update_mailbox1_en,
  output   wire          sysio_core1_cp0_update_mailbox2_en,
  output   wire          sysio_core1_cp0_update_mailbox3_en,
  output   wire          sysio_core1_cp0_req_grnt,
  output   wire  [3 :0]  sysio_core1_cp0_update_bit_sel,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_src0,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_src1,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_src2,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_src3,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_mask0,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_mask1,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_mask2,
  output   wire  [31:0]  sysio_core1_cp0_update_mailbox_mask3,
  output   wire  [63:0]  sysio_core1_restart_entry,
  output   wire          sysio_core1_restart_vld,
  output   wire  [63:0]  sysio_core2_restart_entry,
  output   wire          sysio_core2_restart_vld,
  output   wire          sysio_core2_cp0_update_ipi_status_en,
  output   wire  [31:0]  sysio_core2_cp0_update_ipi_status_src,
  output   wire          sysio_core2_cp0_update_mailbox0_en,
  output   wire          sysio_core2_cp0_update_mailbox1_en,
  output   wire          sysio_core2_cp0_update_mailbox2_en,
  output   wire          sysio_core2_cp0_update_mailbox3_en,
  output   wire          sysio_core2_cp0_req_grnt,
  output   wire  [3 :0]  sysio_core2_cp0_update_bit_sel,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_src0,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_src1,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_src2,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_src3,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_mask0,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_mask1,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_mask2,
  output   wire  [31:0]  sysio_core2_cp0_update_mailbox_mask3,
  output   wire          sysio_core3_cp0_update_ipi_status_en,
  output   wire  [31:0]  sysio_core3_cp0_update_ipi_status_src,
  output   wire          sysio_core3_cp0_update_mailbox0_en,
  output   wire          sysio_core3_cp0_update_mailbox1_en,
  output   wire          sysio_core3_cp0_update_mailbox2_en,
  output   wire          sysio_core3_cp0_update_mailbox3_en,
  output   wire          sysio_core3_cp0_req_grnt,
  output   wire  [3 :0]  sysio_core3_cp0_update_bit_sel,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_src0,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_src1,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_src2,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_src3,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_mask0,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_mask1,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_mask2,
  output   wire  [31:0]  sysio_core3_cp0_update_mailbox_mask3,
  output   wire  [63:0]  sysio_core3_restart_entry,
  output   wire          sysio_core3_restart_vld,
  output   wire  [63:0]  sysio_core_gl_stable_timer,
  output   wire          sysio_piu0_dbgrq_b,
  output   wire  [7 :0]  sysio_piu0_ex_int,
  output   wire          sysio_piu0_me_int,
  output   wire          sysio_piu0_ms_int,
  output   wire          sysio_piu0_mt_int,
  output   wire          sysio_piu0_se_int,
  output   wire          sysio_piu0_ss_int,
  output   wire          sysio_piu0_st_int,
  output   wire          sysio_piu1_dbgrq_b,
  output   wire  [7 :0]  sysio_piu1_ex_int,
  output   wire          sysio_piu1_me_int,
  output   wire          sysio_piu1_ms_int,
  output   wire          sysio_piu1_mt_int,
  output   wire          sysio_piu1_se_int,
  output   wire          sysio_piu1_ss_int,
  output   wire          sysio_piu1_st_int,
  output   wire          sysio_piu2_dbgrq_b,
  output   wire  [7 :0]  sysio_piu2_ex_int,
  output   wire          sysio_piu2_me_int,
  output   wire          sysio_piu2_ms_int,
  output   wire          sysio_piu2_mt_int,
  output   wire          sysio_piu2_se_int,
  output   wire          sysio_piu2_ss_int,
  output   wire          sysio_piu2_st_int,
  output   wire          sysio_piu3_dbgrq_b,
  output   wire  [7 :0]  sysio_piu3_ex_int,
  output   wire          sysio_piu3_me_int,
  output   wire          sysio_piu3_ms_int,
  output   wire          sysio_piu3_mt_int,
  output   wire          sysio_piu3_se_int,
  output   wire          sysio_piu3_ss_int,
  output   wire          sysio_piu3_st_int,
  output   wire  [39:0]  sysio_xx_apb_base,
  output   wire  [63:0]  sysio_xx_time
); 



// &Regs; @26
reg     [12:0]  apb_base;                  
reg     [63:0]  ccvr;                      
reg             core0_wr_req_ff;
reg     [3 :0]  core0_wr_sel_ff;
reg     [31:0]  core0_wr_ipi_send_data_ff;
reg     [63:0]  core0_wr_mail_box_send_data_ff;
reg             core1_wr_req_ff;
reg     [3 :0]  core1_wr_sel_ff;
reg     [31:0]  core1_wr_ipi_send_data_ff;
reg     [63:0]  core1_wr_mail_box_send_data_ff;
reg             core2_wr_req_ff;
reg     [3 :0]  core2_wr_sel_ff;
reg     [31:0]  core2_wr_ipi_send_data_ff;
reg     [63:0]  core2_wr_mail_box_send_data_ff;
reg             core3_wr_req_ff;
reg     [3 :0]  core3_wr_sel_ff;
reg     [31:0]  core3_wr_ipi_send_data_ff;
reg     [63:0]  core3_wr_mail_box_send_data_ff;
reg     [3 :0]  core_wr_req_sel;
reg             save_core0_restart_req;
reg     [63:0]  save_core0_restart_entry;
reg             save_core1_restart_req;
reg     [63:0]  save_core1_restart_entry;
reg             save_core2_restart_req;
reg     [63:0]  save_core2_restart_entry;
reg             save_core3_restart_req;
reg     [63:0]  save_core3_restart_entry;

// &Wires; @27
wire            sysio_clk;                 
wire            sysio_clk_en;              
wire            core0_wr_req_pipe_down_vld;
wire            core1_wr_req_pipe_down_vld;
wire            core2_wr_req_pipe_down_vld;
wire            core3_wr_req_pipe_down_vld;
wire            core0_wr_req_grnt;
wire            core1_wr_req_grnt;
wire            core2_wr_req_grnt;
wire            core3_wr_req_grnt;
wire    [3 :0]  core0_req_ipi_core_sel;
wire    [3 :0]  core1_req_ipi_core_sel;
wire    [3 :0]  core2_req_ipi_core_sel;
wire    [3 :0]  core3_req_ipi_core_sel;
wire    [3 :0]  core0_req_mail_core_sel;
wire    [3 :0]  core1_req_mail_core_sel;
wire    [3 :0]  core2_req_mail_core_sel;
wire    [3 :0]  core3_req_mail_core_sel;
wire            core0_ipi_action_boot;
wire            core1_ipi_action_boot;
wire            core2_ipi_action_boot;
wire            core3_ipi_action_boot;
wire    [63:0]  sysio_req_boot_core0_entry;
wire    [63:0]  core0_restart_entry;
wire            core0_restart_vld;
wire    [63:0]  sysio_req_boot_core1_entry;
wire    [63:0]  core1_restart_entry;
wire            core1_restart_vld;
wire    [63:0]  sysio_req_boot_core2_entry;
wire            core2_restart_vld;
wire    [63:0]  core2_restart_entry;
wire    [63:0]  sysio_req_boot_core3_entry;
wire            core3_restart_vld;
wire    [63:0]  core3_restart_entry;
wire            core0_boot_cpu_vld;
wire            core1_boot_cpu_vld;
wire            core2_boot_cpu_vld;
wire            core3_boot_cpu_vld;
wire            core0_req_grnt_sel_core0_mail0;
wire            core1_req_grnt_sel_core0_mail0;
wire            core2_req_grnt_sel_core0_mail0;
wire            core3_req_grnt_sel_core0_mail0;
wire            core0_req_grnt_sel_core0_mail1;
wire            core1_req_grnt_sel_core0_mail1;
wire            core2_req_grnt_sel_core0_mail1;
wire            core3_req_grnt_sel_core0_mail1;
wire            core0_req_grnt_sel_core0_mail2;
wire            core1_req_grnt_sel_core0_mail2;
wire            core2_req_grnt_sel_core0_mail2;
wire            core3_req_grnt_sel_core0_mail2;
wire            core0_req_grnt_sel_core0_mail3;
wire            core1_req_grnt_sel_core0_mail3;
wire            core2_req_grnt_sel_core0_mail3;
wire            core3_req_grnt_sel_core0_mail3;
wire            core0_req_grnt_sel_core1_mail0;
wire            core1_req_grnt_sel_core1_mail0;
wire            core2_req_grnt_sel_core1_mail0;
wire            core3_req_grnt_sel_core1_mail0;
wire            core0_req_grnt_sel_core1_mail1;
wire            core1_req_grnt_sel_core1_mail1;
wire            core2_req_grnt_sel_core1_mail1;
wire            core3_req_grnt_sel_core1_mail1;
wire            core0_req_grnt_sel_core1_mail2;
wire            core1_req_grnt_sel_core1_mail2;
wire            core2_req_grnt_sel_core1_mail2;
wire            core3_req_grnt_sel_core1_mail2;
wire            core0_req_grnt_sel_core1_mail3;
wire            core1_req_grnt_sel_core1_mail3;
wire            core2_req_grnt_sel_core1_mail3;
wire            core3_req_grnt_sel_core1_mail3;
wire            core0_req_grnt_sel_core2_mail0;
wire            core1_req_grnt_sel_core2_mail0;
wire            core2_req_grnt_sel_core2_mail0;
wire            core3_req_grnt_sel_core2_mail0;
wire            core0_req_grnt_sel_core2_mail1;
wire            core1_req_grnt_sel_core2_mail1;
wire            core2_req_grnt_sel_core2_mail1;
wire            core3_req_grnt_sel_core2_mail1;
wire            core0_req_grnt_sel_core2_mail2;
wire            core1_req_grnt_sel_core2_mail2;
wire            core2_req_grnt_sel_core2_mail2;
wire            core3_req_grnt_sel_core2_mail2;
wire            core0_req_grnt_sel_core2_mail3;
wire            core1_req_grnt_sel_core2_mail3;
wire            core2_req_grnt_sel_core2_mail3;
wire            core3_req_grnt_sel_core2_mail3;
wire            core0_req_grnt_sel_core3_mail0;
wire            core1_req_grnt_sel_core3_mail0;
wire            core2_req_grnt_sel_core3_mail0;
wire            core3_req_grnt_sel_core3_mail0;
wire            core0_req_grnt_sel_core3_mail1;
wire            core1_req_grnt_sel_core3_mail1;
wire            core2_req_grnt_sel_core3_mail1;
wire            core3_req_grnt_sel_core3_mail1;
wire            core0_req_grnt_sel_core3_mail2;
wire            core1_req_grnt_sel_core3_mail2;
wire            core2_req_grnt_sel_core3_mail2;
wire            core3_req_grnt_sel_core3_mail2;
wire            core0_req_grnt_sel_core3_mail3;
wire            core1_req_grnt_sel_core3_mail3;
wire            core2_req_grnt_sel_core3_mail3;
wire            core3_req_grnt_sel_core3_mail3;
wire            core0_update_ipi_status_en;
wire            core0_update_ipi_status_mask;
wire            core1_update_ipi_status_en;
wire            core1_update_ipi_status_mask;
wire            core2_update_ipi_status_en;
wire            core2_update_ipi_status_mask;
wire            core3_update_ipi_status_en;
wire            core3_update_ipi_status_mask;
wire            core0_req_grnt_sel_core0_ipi;
wire            core1_req_grnt_sel_core0_ipi;
wire            core2_req_grnt_sel_core0_ipi;
wire            core3_req_grnt_sel_core0_ipi;
wire            core0_req_grnt_sel_core1_ipi;
wire            core1_req_grnt_sel_core1_ipi;
wire            core2_req_grnt_sel_core1_ipi;
wire            core3_req_grnt_sel_core1_ipi;
wire            core0_req_grnt_sel_core2_ipi;
wire            core1_req_grnt_sel_core2_ipi;
wire            core2_req_grnt_sel_core2_ipi;
wire            core3_req_grnt_sel_core2_ipi;
wire            core0_req_grnt_sel_core3_ipi;
wire            core1_req_grnt_sel_core3_ipi;
wire            core2_req_grnt_sel_core3_ipi;
wire            core3_req_grnt_sel_core3_ipi;


//================================================
//                  IOCSR logic 
//================================================

assign core0_wr_req_pipe_down_vld = !core0_wr_req_ff || core_wr_req_sel[0];

// for timing, save one cycle
always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
     core0_wr_req_ff                      <= 1'b0;
     core0_wr_sel_ff[3:0]                 <= 4'b0;
     core0_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core0_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core_wr_req_sel[0]) begin
     core0_wr_req_ff                      <= 1'b0;
     core0_wr_sel_ff[3:0]                 <= 4'b0;
     core0_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core0_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core0_wr_req_pipe_down_vld) begin
     core0_wr_req_ff                      <= core0_sysio_wr_req;
     core0_wr_sel_ff[3:0]                 <= core0_sysio_wr_sel[3:0];
     core0_wr_ipi_send_data_ff[31:0]      <= core0_sysio_wr_ipi_send_data[31:0];
     core0_wr_mail_box_send_data_ff[63:0] <= core0_sysio_wr_mail_box_send_data[63:0];
  end
  else begin
     core0_wr_req_ff                      <= core0_wr_req_ff;
     core0_wr_sel_ff[3:0]                 <= core0_wr_sel_ff[3:0];
     core0_wr_ipi_send_data_ff[31:0]      <= core0_wr_ipi_send_data_ff[31:0];
     core0_wr_mail_box_send_data_ff[63:0] <= core0_wr_mail_box_send_data_ff[63:0];
  end
end

assign core1_wr_req_pipe_down_vld = !core1_wr_req_ff || core_wr_req_sel[1];

always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
     core1_wr_req_ff                      <= 1'b0;
     core1_wr_sel_ff[3:0]                 <= 4'b0;
     core1_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core1_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core_wr_req_sel[1]) begin
     core1_wr_req_ff                      <= 1'b0;
     core1_wr_sel_ff[3:0]                 <= 4'b0;
     core1_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core1_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core1_wr_req_pipe_down_vld) begin
     core1_wr_req_ff                      <= core1_sysio_wr_req;
     core1_wr_sel_ff[3:0]                 <= core1_sysio_wr_sel[3:0];
     core1_wr_ipi_send_data_ff[31:0]      <= core1_sysio_wr_ipi_send_data[31:0];
     core1_wr_mail_box_send_data_ff[63:0] <= core1_sysio_wr_mail_box_send_data[63:0];
  end
  else begin
     core1_wr_req_ff                      <= core1_wr_req_ff;
     core1_wr_sel_ff[3:0]                 <= core1_wr_sel_ff[3:0];
     core1_wr_ipi_send_data_ff[31:0]      <= core1_wr_ipi_send_data_ff[31:0];
     core1_wr_mail_box_send_data_ff[63:0] <= core1_wr_mail_box_send_data_ff[63:0];
  end
end


assign core2_wr_req_pipe_down_vld = !core2_wr_req_ff || core_wr_req_sel[2];

always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
     core2_wr_req_ff                      <= 1'b0;
     core2_wr_sel_ff[3:0]                 <= 4'b0;
     core2_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core2_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core_wr_req_sel[2]) begin
     core2_wr_req_ff                      <= 1'b0;
     core2_wr_sel_ff[3:0]                 <= 4'b0;
     core2_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core2_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core2_wr_req_pipe_down_vld) begin
     core2_wr_req_ff                      <= core2_sysio_wr_req;
     core2_wr_sel_ff[3:0]                 <= core2_sysio_wr_sel[3:0];
     core2_wr_ipi_send_data_ff[31:0]      <= core2_sysio_wr_ipi_send_data[31:0];
     core2_wr_mail_box_send_data_ff[63:0] <= core2_sysio_wr_mail_box_send_data[63:0];
  end
  else begin
     core2_wr_req_ff                      <= core2_wr_req_ff;
     core2_wr_sel_ff[3:0]                 <= core2_wr_sel_ff[3:0];
     core2_wr_ipi_send_data_ff[31:0]      <= core2_wr_ipi_send_data_ff[31:0];
     core2_wr_mail_box_send_data_ff[63:0] <= core2_wr_mail_box_send_data_ff[63:0];
  end
end


assign core3_wr_req_pipe_down_vld = !core3_wr_req_ff || core_wr_req_sel[3];

always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
     core3_wr_req_ff                      <= 1'b0;
     core3_wr_sel_ff[3:0]                 <= 4'b0;
     core3_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core3_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core_wr_req_sel[3]) begin
     core3_wr_req_ff                      <= 1'b0;
     core3_wr_sel_ff[3:0]                 <= 4'b0;
     core3_wr_ipi_send_data_ff[31:0]      <= 32'b0;
     core3_wr_mail_box_send_data_ff[63:0] <= 64'b0;
  end 
  else if(core3_wr_req_pipe_down_vld) begin
     core3_wr_req_ff                      <= core3_sysio_wr_req;
     core3_wr_sel_ff[3:0]                 <= core3_sysio_wr_sel[3:0];
     core3_wr_ipi_send_data_ff[31:0]      <= core3_sysio_wr_ipi_send_data[31:0];
     core3_wr_mail_box_send_data_ff[63:0] <= core3_sysio_wr_mail_box_send_data[63:0];
  end
  else begin
     core3_wr_req_ff                      <= core3_wr_req_ff;
     core3_wr_sel_ff[3:0]                 <= core3_wr_sel_ff[3:0];
     core3_wr_ipi_send_data_ff[31:0]      <= core3_wr_ipi_send_data_ff[31:0];
     core3_wr_mail_box_send_data_ff[63:0] <= core3_wr_mail_box_send_data_ff[63:0];
  end
end


always @(core0_wr_req_ff
      or core1_wr_req_ff
      or core2_wr_req_ff
      or core3_wr_req_ff) 
begin
  core_wr_req_sel[3:0] = 4'b00;
casez ({core0_wr_req_ff, core1_wr_req_ff, core2_wr_req_ff, core3_wr_req_ff})
  4'b1??? : core_wr_req_sel[3:0] = 4'b0001;
  4'b01?? : core_wr_req_sel[3:0] = 4'b0010;
  4'b001? : core_wr_req_sel[3:0] = 4'b0100;
  4'b0001 : core_wr_req_sel[3:0] = 4'b1000;
  default : core_wr_req_sel[3:0] = 4'b0000;
endcase
end


/// interface
assign core0_ipi_action_boot = core0_wr_ipi_send_data_ff[4:0] == 4'b0;
assign core1_ipi_action_boot = core1_wr_ipi_send_data_ff[4:0] == 4'b0;
assign core2_ipi_action_boot = core2_wr_ipi_send_data_ff[4:0] == 4'b0;
assign core3_ipi_action_boot = core3_wr_ipi_send_data_ff[4:0] == 4'b0;

assign core0_wr_req_grnt = core_wr_req_sel[0];
assign core1_wr_req_grnt = core_wr_req_sel[1];
assign core2_wr_req_grnt = core_wr_req_sel[2];
assign core3_wr_req_grnt = core_wr_req_sel[3];

assign core0_req_ipi_core_sel[3:0] = { core0_wr_ipi_send_data_ff[17] && core0_wr_ipi_send_data_ff[16],
                                       core0_wr_ipi_send_data_ff[17] && !core0_wr_ipi_send_data_ff[16],
                                      !core0_wr_ipi_send_data_ff[17] && core0_wr_ipi_send_data_ff[16],
                                      !core0_wr_ipi_send_data_ff[17] && !core0_wr_ipi_send_data_ff[16]
                                      };

assign core0_req_mail_core_sel[3:0] = {core0_wr_mail_box_send_data_ff[17] && core0_wr_mail_box_send_data_ff[16],
                                       core0_wr_mail_box_send_data_ff[17] && !core0_wr_mail_box_send_data_ff[16],
                                      !core0_wr_mail_box_send_data_ff[17] && core0_wr_mail_box_send_data_ff[16],
                                      !core0_wr_mail_box_send_data_ff[17] && !core0_wr_mail_box_send_data_ff[16]
                                      };

assign core1_req_ipi_core_sel[3:0] = { core1_wr_ipi_send_data_ff[17] && core1_wr_ipi_send_data_ff[16],
                                       core1_wr_ipi_send_data_ff[17] && !core1_wr_ipi_send_data_ff[16],
                                      !core1_wr_ipi_send_data_ff[17] && core1_wr_ipi_send_data_ff[16],
                                      !core1_wr_ipi_send_data_ff[17] && !core1_wr_ipi_send_data_ff[16]
                                      };

assign core1_req_mail_core_sel[3:0] = {core1_wr_mail_box_send_data_ff[17] && core1_wr_mail_box_send_data_ff[16],
                                       core1_wr_mail_box_send_data_ff[17] && !core1_wr_mail_box_send_data_ff[16],
                                      !core1_wr_mail_box_send_data_ff[17] && core1_wr_mail_box_send_data_ff[16],
                                      !core1_wr_mail_box_send_data_ff[17] && !core1_wr_mail_box_send_data_ff[16]
                                      };

assign core2_req_ipi_core_sel[3:0] = { core2_wr_ipi_send_data_ff[17] && core2_wr_ipi_send_data_ff[16],
                                       core2_wr_ipi_send_data_ff[17] && !core2_wr_ipi_send_data_ff[16],
                                      !core2_wr_ipi_send_data_ff[17] && core2_wr_ipi_send_data_ff[16],
                                      !core2_wr_ipi_send_data_ff[17] && !core2_wr_ipi_send_data_ff[16]
                                      };

assign core2_req_mail_core_sel[3:0] = {core2_wr_mail_box_send_data_ff[17] && core2_wr_mail_box_send_data_ff[16],
                                       core2_wr_mail_box_send_data_ff[17] && !core2_wr_mail_box_send_data_ff[16],
                                      !core2_wr_mail_box_send_data_ff[17] && core2_wr_mail_box_send_data_ff[16],
                                      !core2_wr_mail_box_send_data_ff[17] && !core2_wr_mail_box_send_data_ff[16]
                                      };

assign core3_req_ipi_core_sel[3:0] = { core3_wr_ipi_send_data_ff[17] && core3_wr_ipi_send_data_ff[16],
                                       core3_wr_ipi_send_data_ff[17] && !core3_wr_ipi_send_data_ff[16],
                                      !core3_wr_ipi_send_data_ff[17] && core3_wr_ipi_send_data_ff[16],
                                      !core3_wr_ipi_send_data_ff[17] && !core3_wr_ipi_send_data_ff[16]
                                      };

assign core3_req_mail_core_sel[3:0] = {core3_wr_mail_box_send_data_ff[17] && core3_wr_mail_box_send_data_ff[16],
                                       core3_wr_mail_box_send_data_ff[17] && !core3_wr_mail_box_send_data_ff[16],
                                      !core3_wr_mail_box_send_data_ff[17] && core3_wr_mail_box_send_data_ff[16],
                                      !core3_wr_mail_box_send_data_ff[17] && !core3_wr_mail_box_send_data_ff[16]
                                      };

assign sysio_core0_cp0_req_grnt = core_wr_req_sel[0];
assign sysio_core1_cp0_req_grnt = core_wr_req_sel[1];
assign sysio_core2_cp0_req_grnt = core_wr_req_sel[2];
assign sysio_core3_cp0_req_grnt = core_wr_req_sel[3];


reg [31:0] core0_ipi_status_ctx;
reg [31:0] core1_ipi_status_ctx;
reg [31:0] core2_ipi_status_ctx;
reg [31:0] core3_ipi_status_ctx;

always @(core0_wr_ipi_send_data_ff[4:0]) 
begin
  core0_ipi_status_ctx[31:0] = 32'b0;
case (core0_wr_ipi_send_data_ff[4:0])
  5'd0    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000001;
  5'd1    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000010;
  5'd2    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000100;
  5'd3    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000001000;
  5'd4    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000010000;
  5'd5    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000100000;
  5'd6    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000001000000;
  5'd7    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000010000000;
  5'd8    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000000100000000;
  5'd9    : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000001000000000;
  5'd10   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000010000000000;
  5'd11   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000000100000000000;
  5'd12   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000001000000000000;
  5'd13   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000010000000000000;
  5'd14   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000000100000000000000;
  5'd15   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000001000000000000000;
  5'd16   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000010000000000000000;
  5'd17   : core0_ipi_status_ctx[31:0]  = 32'b00000000000000100000000000000000;
  5'd18   : core0_ipi_status_ctx[31:0]  = 32'b00000000000001000000000000000000;
  5'd19   : core0_ipi_status_ctx[31:0]  = 32'b00000000000010000000000000000000;
  5'd20   : core0_ipi_status_ctx[31:0]  = 32'b00000000000100000000000000000000;
  5'd21   : core0_ipi_status_ctx[31:0]  = 32'b00000000001000000000000000000000;
  5'd22   : core0_ipi_status_ctx[31:0]  = 32'b00000000010000000000000000000000;
  5'd23   : core0_ipi_status_ctx[31:0]  = 32'b00000000100000000000000000000000;
  5'd24   : core0_ipi_status_ctx[31:0]  = 32'b00000001000000000000000000000000;
  5'd25   : core0_ipi_status_ctx[31:0]  = 32'b00000010000000000000000000000000;
  5'd26   : core0_ipi_status_ctx[31:0]  = 32'b00000100000000000000000000000000;
  5'd27   : core0_ipi_status_ctx[31:0]  = 32'b00001000000000000000000000000000;
  5'd28   : core0_ipi_status_ctx[31:0]  = 32'b00010000000000000000000000000000;
  5'd29   : core0_ipi_status_ctx[31:0]  = 32'b00100000000000000000000000000000;
  5'd30   : core0_ipi_status_ctx[31:0]  = 32'b01000000000000000000000000000000;
  5'd31   : core0_ipi_status_ctx[31:0]  = 32'b10000000000000000000000000000000;
  default : core0_ipi_status_ctx[31:0]  = 32'b0;
endcase
end

always @(core1_wr_ipi_send_data_ff[4:0]) 
begin
  core1_ipi_status_ctx[31:0] = 32'b0;
case (core1_wr_ipi_send_data_ff[4:0])
  5'd0    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000001;
  5'd1    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000010;
  5'd2    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000100;
  5'd3    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000001000;
  5'd4    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000010000;
  5'd5    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000100000;
  5'd6    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000001000000;
  5'd7    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000010000000;
  5'd8    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000000100000000;
  5'd9    : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000001000000000;
  5'd10   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000010000000000;
  5'd11   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000000100000000000;
  5'd12   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000001000000000000;
  5'd13   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000010000000000000;
  5'd14   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000000100000000000000;
  5'd15   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000001000000000000000;
  5'd16   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000010000000000000000;
  5'd17   : core1_ipi_status_ctx[31:0]  = 32'b00000000000000100000000000000000;
  5'd18   : core1_ipi_status_ctx[31:0]  = 32'b00000000000001000000000000000000;
  5'd19   : core1_ipi_status_ctx[31:0]  = 32'b00000000000010000000000000000000;
  5'd20   : core1_ipi_status_ctx[31:0]  = 32'b00000000000100000000000000000000;
  5'd21   : core1_ipi_status_ctx[31:0]  = 32'b00000000001000000000000000000000;
  5'd22   : core1_ipi_status_ctx[31:0]  = 32'b00000000010000000000000000000000;
  5'd23   : core1_ipi_status_ctx[31:0]  = 32'b00000000100000000000000000000000;
  5'd24   : core1_ipi_status_ctx[31:0]  = 32'b00000001000000000000000000000000;
  5'd25   : core1_ipi_status_ctx[31:0]  = 32'b00000010000000000000000000000000;
  5'd26   : core1_ipi_status_ctx[31:0]  = 32'b00000100000000000000000000000000;
  5'd27   : core1_ipi_status_ctx[31:0]  = 32'b00001000000000000000000000000000;
  5'd28   : core1_ipi_status_ctx[31:0]  = 32'b00010000000000000000000000000000;
  5'd29   : core1_ipi_status_ctx[31:0]  = 32'b00100000000000000000000000000000;
  5'd30   : core1_ipi_status_ctx[31:0]  = 32'b01000000000000000000000000000000;
  5'd31   : core1_ipi_status_ctx[31:0]  = 32'b10000000000000000000000000000000;
  default : core1_ipi_status_ctx[31:0]  = 32'b0;
endcase
end

always @(core2_wr_ipi_send_data_ff[4:0]) 
begin
  core2_ipi_status_ctx[31:0] = 32'b0;
case (core2_wr_ipi_send_data_ff[4:0])
  5'd0    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000001;
  5'd1    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000010;
  5'd2    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000100;
  5'd3    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000001000;
  5'd4    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000010000;
  5'd5    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000100000;
  5'd6    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000001000000;
  5'd7    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000010000000;
  5'd8    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000000100000000;
  5'd9    : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000001000000000;
  5'd10   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000010000000000;
  5'd11   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000000100000000000;
  5'd12   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000001000000000000;
  5'd13   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000010000000000000;
  5'd14   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000000100000000000000;
  5'd15   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000001000000000000000;
  5'd16   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000010000000000000000;
  5'd17   : core2_ipi_status_ctx[31:0]  = 32'b00000000000000100000000000000000;
  5'd18   : core2_ipi_status_ctx[31:0]  = 32'b00000000000001000000000000000000;
  5'd19   : core2_ipi_status_ctx[31:0]  = 32'b00000000000010000000000000000000;
  5'd20   : core2_ipi_status_ctx[31:0]  = 32'b00000000000100000000000000000000;
  5'd21   : core2_ipi_status_ctx[31:0]  = 32'b00000000001000000000000000000000;
  5'd22   : core2_ipi_status_ctx[31:0]  = 32'b00000000010000000000000000000000;
  5'd23   : core2_ipi_status_ctx[31:0]  = 32'b00000000100000000000000000000000;
  5'd24   : core2_ipi_status_ctx[31:0]  = 32'b00000001000000000000000000000000;
  5'd25   : core2_ipi_status_ctx[31:0]  = 32'b00000010000000000000000000000000;
  5'd26   : core2_ipi_status_ctx[31:0]  = 32'b00000100000000000000000000000000;
  5'd27   : core2_ipi_status_ctx[31:0]  = 32'b00001000000000000000000000000000;
  5'd28   : core2_ipi_status_ctx[31:0]  = 32'b00010000000000000000000000000000;
  5'd29   : core2_ipi_status_ctx[31:0]  = 32'b00100000000000000000000000000000;
  5'd30   : core2_ipi_status_ctx[31:0]  = 32'b01000000000000000000000000000000;
  5'd31   : core2_ipi_status_ctx[31:0]  = 32'b10000000000000000000000000000000;
  default : core2_ipi_status_ctx[31:0]  = 32'b0;
endcase
end

always @(core3_wr_ipi_send_data_ff[4:0]) 
begin
  core3_ipi_status_ctx[31:0] = 32'b0;
case (core3_wr_ipi_send_data_ff[4:0])
  5'd0    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000001;
  5'd1    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000010;
  5'd2    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000000100;
  5'd3    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000001000;
  5'd4    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000010000;
  5'd5    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000000100000;
  5'd6    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000001000000;
  5'd7    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000010000000;
  5'd8    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000000100000000;
  5'd9    : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000001000000000;
  5'd10   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000010000000000;
  5'd11   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000000100000000000;
  5'd12   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000001000000000000;
  5'd13   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000010000000000000;
  5'd14   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000000100000000000000;
  5'd15   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000001000000000000000;
  5'd16   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000010000000000000000;
  5'd17   : core3_ipi_status_ctx[31:0]  = 32'b00000000000000100000000000000000;
  5'd18   : core3_ipi_status_ctx[31:0]  = 32'b00000000000001000000000000000000;
  5'd19   : core3_ipi_status_ctx[31:0]  = 32'b00000000000010000000000000000000;
  5'd20   : core3_ipi_status_ctx[31:0]  = 32'b00000000000100000000000000000000;
  5'd21   : core3_ipi_status_ctx[31:0]  = 32'b00000000001000000000000000000000;
  5'd22   : core3_ipi_status_ctx[31:0]  = 32'b00000000010000000000000000000000;
  5'd23   : core3_ipi_status_ctx[31:0]  = 32'b00000000100000000000000000000000;
  5'd24   : core3_ipi_status_ctx[31:0]  = 32'b00000001000000000000000000000000;
  5'd25   : core3_ipi_status_ctx[31:0]  = 32'b00000010000000000000000000000000;
  5'd26   : core3_ipi_status_ctx[31:0]  = 32'b00000100000000000000000000000000;
  5'd27   : core3_ipi_status_ctx[31:0]  = 32'b00001000000000000000000000000000;
  5'd28   : core3_ipi_status_ctx[31:0]  = 32'b00010000000000000000000000000000;
  5'd29   : core3_ipi_status_ctx[31:0]  = 32'b00100000000000000000000000000000;
  5'd30   : core3_ipi_status_ctx[31:0]  = 32'b01000000000000000000000000000000;
  5'd31   : core3_ipi_status_ctx[31:0]  = 32'b10000000000000000000000000000000;
  default : core3_ipi_status_ctx[31:0]  = 32'b0;
endcase
end

assign core0_req_grnt_sel_core0_ipi = core0_wr_req_grnt && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[0];
assign core1_req_grnt_sel_core0_ipi = core1_wr_req_grnt && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[0];
assign core2_req_grnt_sel_core0_ipi = core2_wr_req_grnt && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[0];
assign core3_req_grnt_sel_core0_ipi = core3_wr_req_grnt && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[0];

assign core0_update_ipi_status_en = core0_req_grnt_sel_core0_ipi 
                                    || core1_req_grnt_sel_core0_ipi
                                    || core2_req_grnt_sel_core0_ipi
                                    || core3_req_grnt_sel_core0_ipi; 

assign core0_update_ipi_status_mask         = sysio_core0_cp0_update_ipi_status_src[0];
assign sysio_core0_cp0_update_ipi_status_en = core0_update_ipi_status_en && !core0_update_ipi_status_mask;


assign sysio_core0_cp0_update_ipi_status_src[31:0] =  {32{core0_req_grnt_sel_core0_ipi}} & core0_ipi_status_ctx[31:0]
                                                    | {32{core1_req_grnt_sel_core0_ipi}} & core1_ipi_status_ctx[31:0]
                                                    | {32{core2_req_grnt_sel_core0_ipi}} & core2_ipi_status_ctx[31:0]
                                                    | {32{core3_req_grnt_sel_core0_ipi}} & core3_ipi_status_ctx[31:0];


assign core0_req_grnt_sel_core1_ipi = core0_wr_req_grnt && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[1];
assign core1_req_grnt_sel_core1_ipi = core1_wr_req_grnt && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[1];
assign core2_req_grnt_sel_core1_ipi = core2_wr_req_grnt && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[1];
assign core3_req_grnt_sel_core1_ipi = core3_wr_req_grnt && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[1];

assign core1_update_ipi_status_en           = core0_req_grnt_sel_core1_ipi 
                                             || core1_req_grnt_sel_core1_ipi
                                             || core2_req_grnt_sel_core1_ipi
                                             || core3_req_grnt_sel_core1_ipi;
assign core1_update_ipi_status_mask         = sysio_core1_cp0_update_ipi_status_src[0];
assign sysio_core1_cp0_update_ipi_status_en = core1_update_ipi_status_en && !core1_update_ipi_status_mask;


assign sysio_core1_cp0_update_ipi_status_src[31:0] =  {32{core0_req_grnt_sel_core1_ipi}} & core0_ipi_status_ctx[31:0]
                                                    | {32{core1_req_grnt_sel_core1_ipi}} & core1_ipi_status_ctx[31:0]
                                                    | {32{core2_req_grnt_sel_core1_ipi}} & core2_ipi_status_ctx[31:0]
                                                    | {32{core3_req_grnt_sel_core1_ipi}} & core3_ipi_status_ctx[31:0];


assign core0_req_grnt_sel_core2_ipi = core0_wr_req_grnt && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[2];
assign core1_req_grnt_sel_core2_ipi = core1_wr_req_grnt && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[2];
assign core2_req_grnt_sel_core2_ipi = core2_wr_req_grnt && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[2];
assign core3_req_grnt_sel_core2_ipi = core3_wr_req_grnt && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[2];

assign core2_update_ipi_status_en           =   core0_req_grnt_sel_core2_ipi 
                                             || core1_req_grnt_sel_core2_ipi
                                             || core2_req_grnt_sel_core2_ipi
                                             || core3_req_grnt_sel_core2_ipi;

assign core2_update_ipi_status_mask         = sysio_core2_cp0_update_ipi_status_src[0];
assign sysio_core2_cp0_update_ipi_status_en = core2_update_ipi_status_en && !core2_update_ipi_status_mask;


assign sysio_core2_cp0_update_ipi_status_src[31:0] =  {32{core0_req_grnt_sel_core2_ipi}} & core0_ipi_status_ctx[31:0]
                                                    | {32{core1_req_grnt_sel_core2_ipi}} & core1_ipi_status_ctx[31:0]
                                                    | {32{core2_req_grnt_sel_core2_ipi}} & core2_ipi_status_ctx[31:0]
                                                    | {32{core3_req_grnt_sel_core2_ipi}} & core3_ipi_status_ctx[31:0];


assign core0_req_grnt_sel_core3_ipi = core0_wr_req_grnt && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[3];
assign core1_req_grnt_sel_core3_ipi = core1_wr_req_grnt && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[3];
assign core2_req_grnt_sel_core3_ipi = core2_wr_req_grnt && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[3];
assign core3_req_grnt_sel_core3_ipi = core3_wr_req_grnt && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[3];

assign core3_update_ipi_status_en           =   core0_req_grnt_sel_core3_ipi 
                                             || core1_req_grnt_sel_core3_ipi
                                             || core2_req_grnt_sel_core3_ipi
                                             || core3_req_grnt_sel_core3_ipi;

assign core3_update_ipi_status_mask         = sysio_core3_cp0_update_ipi_status_src[0];
assign sysio_core3_cp0_update_ipi_status_en = core3_update_ipi_status_en && !core3_update_ipi_status_mask;


assign sysio_core3_cp0_update_ipi_status_src[31:0] =  {32{core0_req_grnt_sel_core3_ipi}} & core0_ipi_status_ctx[31:0]
                                                    | {32{core1_req_grnt_sel_core3_ipi}} & core1_ipi_status_ctx[31:0]
                                                    | {32{core2_req_grnt_sel_core3_ipi}} & core2_ipi_status_ctx[31:0]
                                                    | {32{core3_req_grnt_sel_core3_ipi}} & core3_ipi_status_ctx[31:0];


//==========================================================
//             Generate Restart to IFU 
//==========================================================
assign sysio_req_boot_core0_entry[63:0]  =   core0_sysio_mailbox0_data[63:0];
assign sysio_req_boot_core1_entry[63:0]  =   core1_sysio_mailbox0_data[63:0];
assign sysio_req_boot_core2_entry[63:0]  =   core2_sysio_mailbox0_data[63:0];
assign sysio_req_boot_core3_entry[63:0]  =   core3_sysio_mailbox0_data[63:0];

assign core0_restart_entry[63:0] = sysio_req_boot_core0_entry[63:0];
assign core0_restart_vld         =    core_wr_req_sel[0] && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[0]
                                   || core_wr_req_sel[1] && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[0]
                                   || core_wr_req_sel[2] && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[0]
                                   || core_wr_req_sel[3] && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[0];

assign core1_restart_entry[63:0] = sysio_req_boot_core1_entry[63:0];
assign core1_restart_vld         =    core_wr_req_sel[0] && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[1]
                                   || core_wr_req_sel[1] && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[1]
                                   || core_wr_req_sel[2] && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[1]
                                   || core_wr_req_sel[3] && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[1];

assign core2_restart_entry[63:0] = sysio_req_boot_core2_entry[63:0];
assign core2_restart_vld         =    core_wr_req_sel[0] && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[2]
                                   || core_wr_req_sel[1] && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[2]
                                   || core_wr_req_sel[2] && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[2]
                                   || core_wr_req_sel[3] && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[2];

assign core3_restart_entry[63:0] = sysio_req_boot_core3_entry[63:0];
assign core3_restart_vld         =    core_wr_req_sel[0] && core0_wr_sel_ff[0] && core0_req_ipi_core_sel[3]
                                   || core_wr_req_sel[1] && core1_wr_sel_ff[0] && core1_req_ipi_core_sel[3]
                                   || core_wr_req_sel[2] && core2_wr_sel_ff[0] && core2_req_ipi_core_sel[3]
                                   || core_wr_req_sel[3] && core3_wr_sel_ff[0] && core3_req_ipi_core_sel[3];

assign core0_boot_cpu_vld = core0_update_ipi_status_en && core0_update_ipi_status_mask; // boot cpu
assign core1_boot_cpu_vld = core1_update_ipi_status_en && core1_update_ipi_status_mask; // boot cpu
assign core2_boot_cpu_vld = core2_update_ipi_status_en && core2_update_ipi_status_mask; // boot cpu
assign core3_boot_cpu_vld = core3_update_ipi_status_en && core3_update_ipi_status_mask; // boot cpu


always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
    save_core0_restart_req   <= 1'b0;
    save_core0_restart_entry <= 64'b0;
  end 
  else if (core0_sysio_restart_grnt) begin
    save_core0_restart_req   <= 1'b0;
    save_core0_restart_entry <= 64'b0;
  end
  else if (core0_boot_cpu_vld && !core0_sysio_restart_grnt) begin
    save_core0_restart_req   <= 1'b1;
    save_core0_restart_entry <= core0_restart_entry[63:0];
  end
  else begin
    save_core0_restart_req   <= save_core0_restart_req;
    save_core0_restart_entry <= save_core0_restart_entry;
  end
end


always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
    save_core1_restart_req   <= 1'b0;
    save_core1_restart_entry <= 64'b0;
  end 
  else if (core1_sysio_restart_grnt) begin
    save_core1_restart_req   <= 1'b0;
    save_core1_restart_entry <= 64'b0;
  end
  else if (core1_boot_cpu_vld && !core1_sysio_restart_grnt) begin
    save_core1_restart_req   <= 1'b1;
    save_core1_restart_entry <= core1_restart_entry[63:0];
  end
  else begin
    save_core1_restart_req   <= save_core1_restart_req;
    save_core1_restart_entry <= save_core1_restart_entry;
  end
end

always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
    save_core2_restart_req   <= 1'b0;
    save_core2_restart_entry <= 64'b0;
  end 
  else if (core2_sysio_restart_grnt) begin
    save_core2_restart_req   <= 1'b0;
    save_core2_restart_entry <= 64'b0;
  end
  else if (core2_boot_cpu_vld && !core2_sysio_restart_grnt) begin
    save_core2_restart_req   <= 1'b1;
    save_core2_restart_entry <= core2_restart_entry[63:0];
  end
  else begin
    save_core2_restart_req   <= save_core2_restart_req;
    save_core2_restart_entry <= save_core2_restart_entry;
  end
end

always @(posedge sysio_clk or negedge cpurst_b) begin
  if(~cpurst_b) begin
    save_core3_restart_req   <= 1'b0;
    save_core3_restart_entry <= 64'b0;
  end 
  else if (core3_sysio_restart_grnt) begin
    save_core3_restart_req   <= 1'b0;
    save_core3_restart_entry <= 64'b0;
  end
  else if (core3_boot_cpu_vld && !core3_sysio_restart_grnt) begin
    save_core3_restart_req   <= 1'b1;
    save_core3_restart_entry <= core3_restart_entry[63:0];
  end
  else begin
    save_core3_restart_req   <= save_core3_restart_req;
    save_core3_restart_entry <= save_core3_restart_entry;
  end
end

assign sysio_core0_restart_entry =    {64{core0_boot_cpu_vld}} & core0_restart_entry[63:0]
                                    | {64{save_core0_restart_req}} & save_core0_restart_entry[63:0];
assign sysio_core0_restart_vld   =    core0_boot_cpu_vld
                                   || save_core0_restart_req;

assign sysio_core1_restart_entry =    {64{core1_boot_cpu_vld}} & core1_restart_entry[63:0]
                                    | {64{save_core1_restart_req}} & save_core1_restart_entry[63:0];
assign sysio_core1_restart_vld   =    core1_boot_cpu_vld
                                   || save_core1_restart_req;

assign sysio_core2_restart_entry =    {64{core2_boot_cpu_vld}} & core2_restart_entry[63:0]
                                    | {64{save_core2_restart_req}} & save_core2_restart_entry[63:0];
assign sysio_core2_restart_vld   =    core2_boot_cpu_vld
                                   || save_core2_restart_req;

assign sysio_core3_restart_entry =    {64{core3_boot_cpu_vld}} & core3_restart_entry[63:0]
                                    | {64{save_core3_restart_req}} & save_core3_restart_entry[63:0];
assign sysio_core3_restart_vld   =    core3_boot_cpu_vld
                                   || save_core3_restart_req;

//==========================================================
//             Generate Signals for Mail Box 
//==========================================================
wire[3:0] core0_req_grnt_sel_mail;
wire[3:0] core1_req_grnt_sel_mail;
wire[3:0] core2_req_grnt_sel_mail;
wire[3:0] core3_req_grnt_sel_mail;

assign core0_req_grnt_sel_mail[3:0] = { core0_wr_mail_box_send_data_ff[4] && core0_wr_mail_box_send_data_ff[3],
                                        core0_wr_mail_box_send_data_ff[4] && !core0_wr_mail_box_send_data_ff[3],
                                       !core0_wr_mail_box_send_data_ff[4] && core0_wr_mail_box_send_data_ff[3],
                                       !core0_wr_mail_box_send_data_ff[4] && !core0_wr_mail_box_send_data_ff[3]};

assign core1_req_grnt_sel_mail[3:0] = { core1_wr_mail_box_send_data_ff[4] && core1_wr_mail_box_send_data_ff[3],
                                        core1_wr_mail_box_send_data_ff[4] && !core1_wr_mail_box_send_data_ff[3],
                                       !core1_wr_mail_box_send_data_ff[4] && core1_wr_mail_box_send_data_ff[3],
                                       !core1_wr_mail_box_send_data_ff[4] && !core1_wr_mail_box_send_data_ff[3]};

assign core2_req_grnt_sel_mail[3:0] = { core2_wr_mail_box_send_data_ff[4] && core2_wr_mail_box_send_data_ff[3],
                                        core2_wr_mail_box_send_data_ff[4] && !core2_wr_mail_box_send_data_ff[3],
                                       !core2_wr_mail_box_send_data_ff[4] && core2_wr_mail_box_send_data_ff[3],
                                       !core2_wr_mail_box_send_data_ff[4] && !core2_wr_mail_box_send_data_ff[3]};

assign core3_req_grnt_sel_mail[3:0] = { core3_wr_mail_box_send_data_ff[4] && core3_wr_mail_box_send_data_ff[3],
                                        core3_wr_mail_box_send_data_ff[4] && !core3_wr_mail_box_send_data_ff[3],
                                       !core3_wr_mail_box_send_data_ff[4] && core3_wr_mail_box_send_data_ff[3],
                                       !core3_wr_mail_box_send_data_ff[4] && !core3_wr_mail_box_send_data_ff[3]};


assign core0_req_grnt_sel_core0_mail0 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[0] && core0_req_grnt_sel_mail[0];
assign core1_req_grnt_sel_core0_mail0 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[0] && core1_req_grnt_sel_mail[0];
assign core2_req_grnt_sel_core0_mail0 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[0] && core2_req_grnt_sel_mail[0];
assign core3_req_grnt_sel_core0_mail0 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[0] && core3_req_grnt_sel_mail[0];


assign sysio_core0_cp0_update_mailbox0_en         =  core0_req_grnt_sel_core0_mail0 
                                                  || core1_req_grnt_sel_core0_mail0
                                                  || core2_req_grnt_sel_core0_mail0
                                                  || core3_req_grnt_sel_core0_mail0;

assign sysio_core0_cp0_update_mailbox_src0[31:0]  =  {32{core0_req_grnt_sel_core0_mail0}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core0_mail0}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core0_mail0}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core0_mail0}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core0_cp0_update_mailbox_mask0[31:0] =  {32{core0_req_grnt_sel_core0_mail0}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core0_mail0}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core0_mail0}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core0_mail0}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core0_cp0_update_bit_sel[0]          =  core0_req_grnt_sel_core0_mail0 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core0_mail0 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core0_mail0 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core0_mail0 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core0_mail1 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[0] && core0_req_grnt_sel_mail[1];
assign core1_req_grnt_sel_core0_mail1 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[0] && core1_req_grnt_sel_mail[1];
assign core2_req_grnt_sel_core0_mail1 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[0] && core2_req_grnt_sel_mail[1];
assign core3_req_grnt_sel_core0_mail1 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[0] && core3_req_grnt_sel_mail[1];

assign sysio_core0_cp0_update_mailbox1_en         = core0_req_grnt_sel_core0_mail1 
                                                 || core1_req_grnt_sel_core0_mail1
                                                 || core2_req_grnt_sel_core0_mail1
                                                 || core3_req_grnt_sel_core0_mail1;

assign sysio_core0_cp0_update_mailbox_src1[31:0]  =  {32{core0_req_grnt_sel_core0_mail1}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core0_mail1}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core0_mail1}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core0_mail1}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core0_cp0_update_mailbox_mask1[31:0] =  {32{core0_req_grnt_sel_core0_mail1}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core0_mail1}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}} 
                                                   | {32{core2_req_grnt_sel_core0_mail1}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core0_mail1}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}};

assign sysio_core0_cp0_update_bit_sel[1]          =  core0_req_grnt_sel_core0_mail1 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core0_mail1 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core0_mail1 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core0_mail1 & core3_wr_mail_box_send_data_ff[2];

assign core0_req_grnt_sel_core0_mail2 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[0] && core0_req_grnt_sel_mail[2];
assign core1_req_grnt_sel_core0_mail2 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[0] && core1_req_grnt_sel_mail[2];
assign core2_req_grnt_sel_core0_mail2 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[0] && core2_req_grnt_sel_mail[2];
assign core3_req_grnt_sel_core0_mail2 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[0] && core3_req_grnt_sel_mail[2];


assign sysio_core0_cp0_update_mailbox2_en         = core0_req_grnt_sel_core0_mail2 
                                                 || core1_req_grnt_sel_core0_mail2
                                                 || core2_req_grnt_sel_core0_mail2
                                                 || core3_req_grnt_sel_core0_mail2;

assign sysio_core0_cp0_update_mailbox_src2[31:0]  =  {32{core0_req_grnt_sel_core0_mail2}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core0_mail2}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core0_mail2}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core0_mail2}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core0_cp0_update_mailbox_mask2[31:0] =  {32{core0_req_grnt_sel_core0_mail2}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core0_mail2}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core0_mail2}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core0_mail2}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}};


assign sysio_core0_cp0_update_bit_sel[2]          =  core0_req_grnt_sel_core0_mail2 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core0_mail2 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core0_mail2 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core0_mail2 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core0_mail3 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[0] && core0_req_grnt_sel_mail[3];
assign core1_req_grnt_sel_core0_mail3 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[0] && core1_req_grnt_sel_mail[3];
assign core2_req_grnt_sel_core0_mail3 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[0] && core2_req_grnt_sel_mail[3];
assign core3_req_grnt_sel_core0_mail3 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[0] && core3_req_grnt_sel_mail[3];

assign sysio_core0_cp0_update_mailbox3_en         = core0_req_grnt_sel_core0_mail3 
                                                 || core1_req_grnt_sel_core0_mail3
                                                 || core2_req_grnt_sel_core0_mail3
                                                 || core3_req_grnt_sel_core0_mail3;

assign sysio_core0_cp0_update_mailbox_src3[31:0]  =  {32{core0_req_grnt_sel_core0_mail3}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core0_mail3}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core0_mail3}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core0_mail3}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core0_cp0_update_mailbox_mask3[31:0] =  {32{core0_req_grnt_sel_core0_mail3}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core0_mail3}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core0_mail3}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core0_mail3}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}};

assign sysio_core0_cp0_update_bit_sel[3]          =  core0_req_grnt_sel_core0_mail3 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core0_mail3 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core0_mail3 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core0_mail3 & core3_wr_mail_box_send_data_ff[2];


// core 1
assign core0_req_grnt_sel_core1_mail0 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[1] && core0_req_grnt_sel_mail[0];
assign core1_req_grnt_sel_core1_mail0 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[1] && core1_req_grnt_sel_mail[0];
assign core2_req_grnt_sel_core1_mail0 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[1] && core2_req_grnt_sel_mail[0];
assign core3_req_grnt_sel_core1_mail0 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[1] && core3_req_grnt_sel_mail[0];

assign sysio_core1_cp0_update_mailbox0_en         = core0_req_grnt_sel_core1_mail0 
                                                 || core1_req_grnt_sel_core1_mail0
                                                 || core2_req_grnt_sel_core1_mail0
                                                 || core3_req_grnt_sel_core1_mail0;

assign sysio_core1_cp0_update_mailbox_src0[31:0]  =  {32{core0_req_grnt_sel_core1_mail0}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core1_mail0}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core1_mail0}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core1_mail0}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core1_cp0_update_mailbox_mask0[31:0] =  {32{core0_req_grnt_sel_core1_mail0}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core1_mail0}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core1_mail0}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core1_mail0}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core1_cp0_update_bit_sel[0]          =  core0_req_grnt_sel_core1_mail0 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core1_mail0 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core1_mail0 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core1_mail0 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core1_mail1 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[1] && core0_req_grnt_sel_mail[1];
assign core1_req_grnt_sel_core1_mail1 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[1] && core1_req_grnt_sel_mail[1];
assign core2_req_grnt_sel_core1_mail1 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[1] && core2_req_grnt_sel_mail[1];
assign core3_req_grnt_sel_core1_mail1 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[1] && core3_req_grnt_sel_mail[1];

assign sysio_core1_cp0_update_mailbox1_en         = core0_req_grnt_sel_core1_mail1 
                                                 || core1_req_grnt_sel_core1_mail1
                                                 || core2_req_grnt_sel_core1_mail1
                                                 || core3_req_grnt_sel_core1_mail1;

assign sysio_core1_cp0_update_mailbox_src1[31:0]  =  {32{core0_req_grnt_sel_core1_mail1}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core1_mail1}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core1_mail1}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core1_mail1}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core1_cp0_update_mailbox_mask1[31:0] =  {32{core0_req_grnt_sel_core1_mail1}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core1_mail1}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core1_mail1}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core1_mail1}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core1_cp0_update_bit_sel[1]          =  core0_req_grnt_sel_core1_mail1 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core1_mail1 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core1_mail1 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core1_mail1 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core1_mail2 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[1] && core0_req_grnt_sel_mail[2];
assign core1_req_grnt_sel_core1_mail2 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[1] && core1_req_grnt_sel_mail[2];
assign core2_req_grnt_sel_core1_mail2 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[1] && core2_req_grnt_sel_mail[2];
assign core3_req_grnt_sel_core1_mail2 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[1] && core3_req_grnt_sel_mail[2];

assign sysio_core1_cp0_update_mailbox2_en         = core0_req_grnt_sel_core1_mail2 
                                                 || core1_req_grnt_sel_core1_mail2
                                                 || core2_req_grnt_sel_core1_mail2
                                                 || core3_req_grnt_sel_core1_mail2;

assign sysio_core1_cp0_update_mailbox_src2[31:0]  =  {32{core0_req_grnt_sel_core1_mail2}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core1_mail2}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core1_mail2}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core1_mail2}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core1_cp0_update_mailbox_mask2[31:0] =  {32{core0_req_grnt_sel_core1_mail2}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core1_mail2}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core1_mail2}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core1_mail2}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core1_cp0_update_bit_sel[2]          =  core0_req_grnt_sel_core1_mail2 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core1_mail2 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core1_mail2 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core1_mail2 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core1_mail3 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[1] && core0_req_grnt_sel_mail[3];
assign core1_req_grnt_sel_core1_mail3 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[1] && core1_req_grnt_sel_mail[3];
assign core2_req_grnt_sel_core1_mail3 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[1] && core2_req_grnt_sel_mail[3];
assign core3_req_grnt_sel_core1_mail3 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[1] && core3_req_grnt_sel_mail[3];

assign sysio_core1_cp0_update_mailbox3_en         = core0_req_grnt_sel_core1_mail3 
                                                 || core1_req_grnt_sel_core1_mail3
                                                 || core2_req_grnt_sel_core1_mail3
                                                 || core3_req_grnt_sel_core1_mail3;

assign sysio_core1_cp0_update_mailbox_src3[31:0]  =  {32{core0_req_grnt_sel_core1_mail3}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core1_mail3}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core1_mail3}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core1_mail3}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core1_cp0_update_mailbox_mask3[31:0] =  {32{core0_req_grnt_sel_core1_mail3}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core1_mail3}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core1_mail3}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core1_mail3}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core1_cp0_update_bit_sel[3]          =  core0_req_grnt_sel_core1_mail3 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core1_mail3 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core1_mail3 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core1_mail3 & core3_wr_mail_box_send_data_ff[2];


// core 2
assign core0_req_grnt_sel_core2_mail0 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[2] && core0_req_grnt_sel_mail[0];
assign core1_req_grnt_sel_core2_mail0 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[2] && core1_req_grnt_sel_mail[0];
assign core2_req_grnt_sel_core2_mail0 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[2] && core2_req_grnt_sel_mail[0];
assign core3_req_grnt_sel_core2_mail0 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[2] && core3_req_grnt_sel_mail[0];

assign sysio_core2_cp0_update_mailbox0_en         = core0_req_grnt_sel_core2_mail0 
                                                 || core1_req_grnt_sel_core2_mail0
                                                 || core2_req_grnt_sel_core2_mail0
                                                 || core3_req_grnt_sel_core2_mail0;

assign sysio_core2_cp0_update_mailbox_src0[31:0]  =  {32{core0_req_grnt_sel_core2_mail0}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core2_mail0}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core2_mail0}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core2_mail0}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core2_cp0_update_mailbox_mask0[31:0] =  {32{core0_req_grnt_sel_core2_mail0}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core2_mail0}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core2_mail0}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core2_mail0}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core2_cp0_update_bit_sel[0]          =  core0_req_grnt_sel_core2_mail0 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core2_mail0 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core2_mail0 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core2_mail0 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core2_mail1 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[2] && core0_req_grnt_sel_mail[1];
assign core1_req_grnt_sel_core2_mail1 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[2] && core1_req_grnt_sel_mail[1];
assign core2_req_grnt_sel_core2_mail1 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[2] && core2_req_grnt_sel_mail[1];
assign core3_req_grnt_sel_core2_mail1 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[2] && core3_req_grnt_sel_mail[1];

assign sysio_core2_cp0_update_mailbox1_en         = core0_req_grnt_sel_core2_mail1 
                                                 || core1_req_grnt_sel_core2_mail1
                                                 || core2_req_grnt_sel_core2_mail1
                                                 || core3_req_grnt_sel_core2_mail1;

assign sysio_core2_cp0_update_mailbox_src1[31:0]  =  {32{core0_req_grnt_sel_core2_mail1}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core2_mail1}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core2_mail1}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core2_mail1}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core2_cp0_update_mailbox_mask1[31:0] =  {32{core0_req_grnt_sel_core2_mail1}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core2_mail1}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core2_mail1}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core2_mail1}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core2_cp0_update_bit_sel[1]          =  core0_req_grnt_sel_core2_mail1 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core2_mail1 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core2_mail1 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core2_mail1 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core2_mail2 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[2] && core0_req_grnt_sel_mail[2];
assign core1_req_grnt_sel_core2_mail2 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[2] && core1_req_grnt_sel_mail[2];
assign core2_req_grnt_sel_core2_mail2 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[2] && core2_req_grnt_sel_mail[2];
assign core3_req_grnt_sel_core2_mail2 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[2] && core3_req_grnt_sel_mail[2];

assign sysio_core2_cp0_update_mailbox2_en         = core0_req_grnt_sel_core2_mail2 
                                                 || core1_req_grnt_sel_core2_mail2
                                                 || core2_req_grnt_sel_core2_mail2
                                                 || core3_req_grnt_sel_core2_mail2;

assign sysio_core2_cp0_update_mailbox_src2[31:0]  =  {32{core0_req_grnt_sel_core2_mail2}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core2_mail2}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core2_mail2}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core2_mail2}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core2_cp0_update_mailbox_mask2[31:0] =  {32{core0_req_grnt_sel_core2_mail2}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core2_mail2}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core2_mail2}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core2_mail2}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core2_cp0_update_bit_sel[2]          =  core0_req_grnt_sel_core2_mail2 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core2_mail2 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core2_mail2 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core2_mail2 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core2_mail3 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[2] && core0_req_grnt_sel_mail[3];
assign core1_req_grnt_sel_core2_mail3 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[2] && core1_req_grnt_sel_mail[3];
assign core2_req_grnt_sel_core2_mail3 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[2] && core2_req_grnt_sel_mail[3];
assign core3_req_grnt_sel_core2_mail3 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[2] && core3_req_grnt_sel_mail[3];

assign sysio_core2_cp0_update_mailbox3_en         = core0_req_grnt_sel_core2_mail3 
                                                 || core1_req_grnt_sel_core2_mail3
                                                 || core2_req_grnt_sel_core2_mail3
                                                 || core3_req_grnt_sel_core2_mail3;

assign sysio_core2_cp0_update_mailbox_src3[31:0]  =  {32{core0_req_grnt_sel_core2_mail3}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core2_mail3}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core2_mail3}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core2_mail3}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core2_cp0_update_mailbox_mask3[31:0] =  {32{core0_req_grnt_sel_core2_mail3}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core2_mail3}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core2_mail3}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core2_mail3}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core2_cp0_update_bit_sel[3]          =  core0_req_grnt_sel_core2_mail3 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core2_mail3 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core2_mail3 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core2_mail3 & core3_wr_mail_box_send_data_ff[2];


// core 3
assign core0_req_grnt_sel_core3_mail0 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[3] && core0_req_grnt_sel_mail[0];
assign core1_req_grnt_sel_core3_mail0 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[3] && core1_req_grnt_sel_mail[0];
assign core2_req_grnt_sel_core3_mail0 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[3] && core2_req_grnt_sel_mail[0];
assign core3_req_grnt_sel_core3_mail0 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[3] && core3_req_grnt_sel_mail[0];

assign sysio_core3_cp0_update_mailbox0_en         = core0_req_grnt_sel_core3_mail0 
                                                 || core1_req_grnt_sel_core3_mail0
                                                 || core2_req_grnt_sel_core3_mail0
                                                 || core3_req_grnt_sel_core3_mail0;

assign sysio_core3_cp0_update_mailbox_src0[31:0]  =  {32{core0_req_grnt_sel_core3_mail0}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core3_mail0}} & core1_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core2_req_grnt_sel_core3_mail0}} & core2_wr_mail_box_send_data_ff[63:32] 
                                                   | {32{core3_req_grnt_sel_core3_mail0}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core3_cp0_update_mailbox_mask0[31:0] =  {32{core0_req_grnt_sel_core3_mail0}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core3_mail0}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core3_mail0}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core3_mail0}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core3_cp0_update_bit_sel[0]          =  core0_req_grnt_sel_core3_mail0 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core3_mail0 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core3_mail0 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core3_mail0 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core3_mail1 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[3] && core0_req_grnt_sel_mail[1];
assign core1_req_grnt_sel_core3_mail1 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[3] && core1_req_grnt_sel_mail[1];
assign core2_req_grnt_sel_core3_mail1 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[3] && core2_req_grnt_sel_mail[1];
assign core3_req_grnt_sel_core3_mail1 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[3] && core3_req_grnt_sel_mail[1];

assign sysio_core3_cp0_update_mailbox1_en         = core0_req_grnt_sel_core3_mail1 
                                                 || core1_req_grnt_sel_core3_mail1
                                                 || core2_req_grnt_sel_core3_mail1
                                                 || core3_req_grnt_sel_core3_mail1;

assign sysio_core3_cp0_update_mailbox_src1[31:0]  =  {32{core0_req_grnt_sel_core3_mail1}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core3_mail1}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core3_mail1}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core3_mail1}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core3_cp0_update_mailbox_mask1[31:0] =  {32{core0_req_grnt_sel_core3_mail1}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core3_mail1}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core3_mail1}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core3_mail1}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core3_cp0_update_bit_sel[1]          =  core0_req_grnt_sel_core3_mail1 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core3_mail1 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core3_mail1 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core3_mail1 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core3_mail2 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[3] && core0_req_grnt_sel_mail[2];
assign core1_req_grnt_sel_core3_mail2 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[3] && core1_req_grnt_sel_mail[2];
assign core2_req_grnt_sel_core3_mail2 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[3] && core2_req_grnt_sel_mail[2];
assign core3_req_grnt_sel_core3_mail2 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[3] && core3_req_grnt_sel_mail[2];

assign sysio_core3_cp0_update_mailbox2_en         = core0_req_grnt_sel_core3_mail2 
                                                 || core1_req_grnt_sel_core3_mail2
                                                 || core2_req_grnt_sel_core3_mail2
                                                 || core3_req_grnt_sel_core3_mail2;

assign sysio_core3_cp0_update_mailbox_src2[31:0]  =  {32{core0_req_grnt_sel_core3_mail2}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core3_mail2}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core3_mail2}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core3_mail2}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core3_cp0_update_mailbox_mask2[31:0] =  {32{core0_req_grnt_sel_core3_mail2}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core3_mail2}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core3_mail2}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core3_mail2}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core3_cp0_update_bit_sel[2]          =  core0_req_grnt_sel_core3_mail2 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core3_mail2 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core3_mail2 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core3_mail2 & core3_wr_mail_box_send_data_ff[2];


assign core0_req_grnt_sel_core3_mail3 = core0_wr_req_grnt && core0_wr_sel_ff[1] 
                                        && core0_req_mail_core_sel[3] && core0_req_grnt_sel_mail[3];
assign core1_req_grnt_sel_core3_mail3 = core1_wr_req_grnt && core1_wr_sel_ff[1] 
                                        && core1_req_mail_core_sel[3] && core1_req_grnt_sel_mail[3];
assign core2_req_grnt_sel_core3_mail3 = core2_wr_req_grnt && core2_wr_sel_ff[1] 
                                        && core2_req_mail_core_sel[3] && core2_req_grnt_sel_mail[3];
assign core3_req_grnt_sel_core3_mail3 = core3_wr_req_grnt && core3_wr_sel_ff[1] 
                                        && core3_req_mail_core_sel[3] && core3_req_grnt_sel_mail[3];

assign sysio_core3_cp0_update_mailbox3_en         = core0_req_grnt_sel_core3_mail3 
                                                 || core1_req_grnt_sel_core3_mail3
                                                 || core2_req_grnt_sel_core3_mail3
                                                 || core3_req_grnt_sel_core3_mail3;

assign sysio_core3_cp0_update_mailbox_src3[31:0]  =  {32{core0_req_grnt_sel_core3_mail3}} & core0_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core1_req_grnt_sel_core3_mail3}} & core1_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core2_req_grnt_sel_core3_mail3}} & core2_wr_mail_box_send_data_ff[63:32]
                                                   | {32{core3_req_grnt_sel_core3_mail3}} & core3_wr_mail_box_send_data_ff[63:32]; 

assign sysio_core3_cp0_update_mailbox_mask3[31:0] =  {32{core0_req_grnt_sel_core3_mail3}} & {{8{core0_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core0_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core1_req_grnt_sel_core3_mail3}} & {{8{core1_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core1_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core2_req_grnt_sel_core3_mail3}} & {{8{core2_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core2_wr_mail_box_send_data_ff[27]}}}
                                                   | {32{core3_req_grnt_sel_core3_mail3}} & {{8{core3_wr_mail_box_send_data_ff[30]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[29]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[28]}},
                                                                                             {8{core3_wr_mail_box_send_data_ff[27]}}}; 

assign sysio_core3_cp0_update_bit_sel[3]          =  core0_req_grnt_sel_core3_mail3 & core0_wr_mail_box_send_data_ff[2]
                                                   | core1_req_grnt_sel_core3_mail3 & core1_wr_mail_box_send_data_ff[2]
                                                   | core2_req_grnt_sel_core3_mail3 & core2_wr_mail_box_send_data_ff[2]
                                                   | core3_req_grnt_sel_core3_mail3 & core3_wr_mail_box_send_data_ff[2];


// External Interrupt
assign sysio_piu0_ex_int[7:0] = ext_interrupt[7:0];
assign sysio_piu1_ex_int[7:0] = 8'b0;
assign sysio_piu2_ex_int[7:0] = 8'b0;
assign sysio_piu3_ex_int[7:0] = 8'b0;


//==========================================================
//               Define the TIMER register
//==========================================================
reg [63:0] g_timer;  
always @(posedge sysio_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    g_timer[63:0] <= 64'b0;
  else
    g_timer[63:0] <= g_timer[63:0] + 1'b1;
end

assign sysio_core_gl_stable_timer[63:0] = g_timer[63:0];

assign sysio_clk_en = axim_clk_en;

// &Instance("gated_clk_cell", "x_ct_sysio_in_gated_clk"); @31
gated_clk_cell  x_ct_sysio_in_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (sysio_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (sysio_clk_en      ),
  .module_en          (ciu_sysio_icg_en  ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk ), @32
//          .external_en (1'b0           ), @33
//          .global_en   (1'b1           ), @34
//          .module_en   (ciu_sysio_icg_en), @35
//          .local_en    (sysio_clk_en), @36
//          .clk_out     (sysio_clk   ) @37
//         ); @38


//================================================
//  debug disable
//================================================
always@(posedge sysio_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    sysio_l2c_flush_req <= 1'b0;
  else if (axim_clk_en)
    sysio_l2c_flush_req <= pad_cpu_l2cache_flush_req;
end

always@(posedge sysio_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    cpu_pad_l2cache_flush_done <= 1'b0;
  else if (axim_clk_en)
    cpu_pad_l2cache_flush_done <= l2c_sysio_flush_done;
end


//================================================
//      system counter value to PTIM
//================================================

always@(posedge sysio_clk)
begin
  if (axim_clk_en)
    ccvr[63:0] <= pad_cpu_sys_cnt[63:0];
  else
    ccvr[63:0] <= ccvr[63:0];
end

assign sysio_clint_mtime[63:0] = ccvr[63:0];

// &Force("nonport","ccvr_gray"); @100
// &Instance("gated_clk_cell", "x_ct_sysio_time_gated_clk"); @107
// &Connect(.clk_in      (forever_cpuclk ), @108
//          .external_en (1'b0           ), @109
//          .global_en   (1'b1           ), @110
//          .module_en   (ciu_sysio_icg_en). @111
//          .local_en    (time_updt_en   ), @112
//          .clk_out     (time_clk       ) @113
//         ); @114
assign sysio_xx_time[63:0] = ccvr[63:0];

//================================================
//apb base address
//================================================
// &Force("bus","pad_cpu_apb_base",39,0); @142

always @(posedge sysio_clk)
begin
  if (axim_clk_en)
   apb_base[12:0] <= pad_cpu_apb_base[39:27];
end

assign sysio_ciu_apb_base[39:0] = {apb_base[12:0], 27'b0};
assign sysio_xx_apb_base[39:0] = {apb_base[12:0], 27'b0};

//================================================
// cpu no op
//================================================
always @(posedge sysio_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    cpu_pad_no_op <= 1'b0;
  else if (axim_clk_en)
    cpu_pad_no_op <= ciu_xx_no_op && l2c_sysio_flush_idle;
end

//================================================
// cpu no op
//================================================
// &ConnRule(s/core_/core0_/); @167
// &ConnRule(s/piu_/piu0_/); @168
// &ConnRule(s/_x/[0]/); @169
// &Instance("ct_sysio_kid", "x_ct_sysio_core0"); @170
ct_sysio_kid  x_ct_sysio_core0 (
  .apb_clk_en            (apb_clk_en           ),
  .axim_clk_en           (axim_clk_en          ),
  .ciu_sysio_icg_en      (ciu_sysio_icg_en     ),
  .clint_core_ms_int     (clint_core0_ms_int   ),
  .clint_core_mt_int     (clint_core0_mt_int   ),
  .clint_core_ss_int     (clint_core0_ss_int   ),
  .clint_core_st_int     (clint_core0_st_int   ),
  .core_pad_jdb_pm       (core0_pad_jdb_pm     ),
  .core_pad_lpmd_b       (core0_pad_lpmd_b     ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_core_dbg_mask     (pad_core0_dbg_mask   ),
  .pad_core_dbgrq_b      (pad_core0_dbgrq_b    ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .piu_sysio_jdb_pm      (piu0_sysio_jdb_pm    ),
  .piu_sysio_lpmd_b      (piu0_sysio_lpmd_b    ),
  .plic_core_me_int      (plic_core0_me_int    ),
  .plic_core_se_int      (plic_core0_se_int    ),
  .sysio_clk             (sysio_clk            ),
  .sysio_had_dbg_mask_x  (sysio_had_dbg_mask[0]),
  .sysio_piu_dbgrq_b     (sysio_piu0_dbgrq_b   ),
  .sysio_piu_me_int      (sysio_piu0_me_int    ),
  .sysio_piu_ms_int      (sysio_piu0_ms_int    ),
  .sysio_piu_mt_int      (sysio_piu0_mt_int    ),
  .sysio_piu_se_int      (sysio_piu0_se_int    ),
  .sysio_piu_ss_int      (sysio_piu0_ss_int    ),
  .sysio_piu_st_int      (sysio_piu0_st_int    )
);


// &ConnRule(s/core_/core1_/); @173
// &ConnRule(s/piu_/piu1_/); @174
// &ConnRule(s/_x/[1]/); @175
// &Instance("ct_sysio_kid", "x_ct_sysio_core1"); @176
ct_sysio_kid  x_ct_sysio_core1 (
  .apb_clk_en            (apb_clk_en           ),
  .axim_clk_en           (axim_clk_en          ),
  .ciu_sysio_icg_en      (ciu_sysio_icg_en     ),
  .clint_core_ms_int     (clint_core1_ms_int   ),
  .clint_core_mt_int     (clint_core1_mt_int   ),
  .clint_core_ss_int     (clint_core1_ss_int   ),
  .clint_core_st_int     (clint_core1_st_int   ),
  .core_pad_jdb_pm       (core1_pad_jdb_pm     ),
  .core_pad_lpmd_b       (core1_pad_lpmd_b     ),
  .cpurst_b              (cpurst_b             ),
  .forever_cpuclk        (forever_cpuclk       ),
  .pad_core_dbg_mask     (pad_core1_dbg_mask   ),
  .pad_core_dbgrq_b      (pad_core1_dbgrq_b    ),
  .pad_yy_icg_scan_en    (pad_yy_icg_scan_en   ),
  .piu_sysio_jdb_pm      (piu1_sysio_jdb_pm    ),
  .piu_sysio_lpmd_b      (piu1_sysio_lpmd_b    ),
  .plic_core_me_int      (plic_core1_me_int    ),
  .plic_core_se_int      (plic_core1_se_int    ),
  .sysio_clk             (sysio_clk            ),
  .sysio_had_dbg_mask_x  (sysio_had_dbg_mask[1]),
  .sysio_piu_dbgrq_b     (sysio_piu1_dbgrq_b   ),
  .sysio_piu_me_int      (sysio_piu1_me_int    ),
  .sysio_piu_ms_int      (sysio_piu1_ms_int    ),
  .sysio_piu_mt_int      (sysio_piu1_mt_int    ),
  .sysio_piu_se_int      (sysio_piu1_se_int    ),
  .sysio_piu_ss_int      (sysio_piu1_ss_int    ),
  .sysio_piu_st_int      (sysio_piu1_st_int    )
);


// &ConnRule(s/core_/core2_/); @182
// &ConnRule(s/piu_/piu2_/); @183
// &ConnRule(s/_x/[2]/); @184
// &Instance("ct_sysio_kid", "x_ct_sysio_core2"); @185
assign sysio_had_dbg_mask[2] = 1'b0;

// &ConnRule(s/core_/core3_/); @191
// &ConnRule(s/piu_/piu3_/); @192
// &ConnRule(s/_x/[3]/); @193
// &Instance("ct_sysio_kid", "x_ct_sysio_core3"); @194
assign sysio_had_dbg_mask[3] = 1'b0;

// &ModuleEnd; @199
endmodule



module ct_sysio_kid (
  // &Ports, @23
  input    wire         apb_clk_en,
  input    wire         axim_clk_en,
  input    wire         ciu_sysio_icg_en,
  input    wire         clint_core_ms_int,
  input    wire         clint_core_mt_int,
  input    wire         clint_core_ss_int,
  input    wire         clint_core_st_int,
  input    wire         cpurst_b,
  input    wire         forever_cpuclk,
  input    wire         pad_core_dbg_mask,
  input    wire         pad_core_dbgrq_b,
  input    wire         pad_yy_icg_scan_en,
  input    wire  [1:0]  piu_sysio_jdb_pm,
  input    wire  [1:0]  piu_sysio_lpmd_b,
  input    wire         plic_core_me_int,
  input    wire         plic_core_se_int,
  input    wire         sysio_clk,
  output   reg   [1:0]  core_pad_jdb_pm,
  output   reg   [1:0]  core_pad_lpmd_b,
  output   reg          sysio_had_dbg_mask_x,
  output   reg          sysio_piu_dbgrq_b,
  output   wire         sysio_piu_me_int,
  output   wire         sysio_piu_ms_int,
  output   wire         sysio_piu_mt_int,
  output   wire         sysio_piu_se_int,
  output   wire         sysio_piu_ss_int,
  output   wire         sysio_piu_st_int
); 



// &Regs; @24
reg            clint_core_ms_int_cpu; 
reg            clint_core_mt_int_cpu; 
reg            clint_core_ss_int_cpu; 
reg            clint_core_st_int_cpu; 
reg            plic_core_me_int_cpu; 
reg            plic_core_se_int_cpu; 

// &Wires; @25
wire           kid_int_clk;          
wire           kid_int_clk_en;       


//==========================================================
//input
//==========================================================
always @(posedge sysio_clk)
begin
  if (axim_clk_en)
  begin
   sysio_piu_dbgrq_b <= pad_core_dbgrq_b;
  end
end

always @(posedge sysio_clk)
begin
  if (axim_clk_en)
  begin
   sysio_had_dbg_mask_x <= pad_core_dbg_mask;
  end
end

//==========================================================
//output
//==========================================================
always @(posedge sysio_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    core_pad_jdb_pm[1:0] <= 2'b0;
    core_pad_lpmd_b[1:0] <= 2'b11;
  end
  else if (axim_clk_en)
  begin
    core_pad_jdb_pm[1:0] <= piu_sysio_jdb_pm[1:0];
    core_pad_lpmd_b[1:0] <= piu_sysio_lpmd_b[1:0];
  end
end


//==========================================================
//PLIC and CLINT int
//==========================================================
assign kid_int_clk_en = apb_clk_en;

// &Instance("gated_clk_cell", "x_sysio_kid_int_gated_clk"); @86
gated_clk_cell  x_sysio_kid_int_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (kid_int_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (kid_int_clk_en    ),
  .module_en          (ciu_sysio_icg_en  ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @87
//          .external_en (1'b0          ), @88
//          .global_en   (1'b1          ), @89
//          .module_en   (ciu_sysio_icg_en). @90
//          .local_en    (kid_int_clk_en), @91
//          .clk_out     (kid_int_clk   ) @92
//         ); @93

always @(posedge kid_int_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    plic_core_me_int_cpu  <= 1'b0;
    plic_core_se_int_cpu  <= 1'b0;
    clint_core_ms_int_cpu <= 1'b0;
    clint_core_ss_int_cpu <= 1'b0;
    clint_core_mt_int_cpu <= 1'b0;
    clint_core_st_int_cpu <= 1'b0;
  end
  else if (apb_clk_en)
  begin
    plic_core_me_int_cpu  <=  plic_core_me_int;
    plic_core_se_int_cpu  <=  plic_core_se_int;
    clint_core_ms_int_cpu <= clint_core_ms_int;
    clint_core_ss_int_cpu <= clint_core_ss_int;
    clint_core_mt_int_cpu <= clint_core_mt_int;
    clint_core_st_int_cpu <= clint_core_st_int;
  end
end

assign sysio_piu_me_int =  plic_core_me_int_cpu;
assign sysio_piu_se_int =  plic_core_se_int_cpu;
assign sysio_piu_ms_int = clint_core_ms_int_cpu;
assign sysio_piu_ss_int = clint_core_ss_int_cpu;
assign sysio_piu_mt_int = clint_core_mt_int_cpu;
assign sysio_piu_st_int = clint_core_st_int_cpu;

// &ModuleEnd; @124
endmodule
