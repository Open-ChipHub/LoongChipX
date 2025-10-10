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

// &Depend("aq_dtu_cfig.h"); @23
// &Depend("cpu_cfig.h"); @24
// &ModuleBeg; @25
module aq_rtu_dp (
  // &Ports, @27
  input    wire          cp0_rtu_ex1_chgflw,
  input    wire  [63:0]  cp0_rtu_ex1_chgflw_pc,
  input    wire          cp0_rtu_ex1_cmplt_dp,
  input    wire  [63:0]  cp0_rtu_ex1_expt_tval,
  input    wire  [14:0]  cp0_rtu_ex1_expt_vec,
  input    wire          cp0_rtu_ex1_expt_vld,
  input    wire          cp0_rtu_ex1_flush,
  input    wire  [21:0]  cp0_rtu_ex1_halt_info,
  input    wire          cp0_rtu_ex1_inst_dret,
  input    wire          cp0_rtu_ex1_inst_ebreak,
  input    wire          cp0_rtu_ex1_inst_len,
  input    wire          cp0_rtu_ex1_inst_ertn,
  input    wire          cp0_rtu_ex1_inst_mret,
  input    wire          cp0_rtu_ex1_inst_split,
  input    wire          cp0_rtu_ex1_inst_sret,
  input    wire          cp0_rtu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          ctrl_dp_ex1_cmplt_dp,
  input    wire          dp_misc_clk,
  input    wire          forever_cpuclk,
  input    wire          ifu_rtu_warm_up,
  input    wire          iu_rtu_depd_lsu_chgflow_vld,
  input    wire  [63:0]  iu_rtu_depd_lsu_next_pc,
  input    wire          iu_rtu_ex1_alu_cmplt_dp,
  input    wire          iu_rtu_ex1_alu_inst_len,
  input    wire          iu_rtu_ex1_alu_inst_split,
  input    wire          iu_rtu_ex1_bju_cmplt_dp,
  input    wire          iu_rtu_ex1_bju_inst_len,
  input    wire          iu_rtu_ex1_branch_inst,
  input    wire  [63:0]  iu_rtu_ex1_cur_pc,
  input    wire          iu_rtu_ex1_div_cmplt_dp,
  input    wire          iu_rtu_ex1_mul_cmplt_dp,
  input    wire  [63:0]  iu_rtu_ex1_next_pc,
  input    wire          lsu_rtu_ex1_cmplt_dp,
  input    wire  [39:0]  lsu_rtu_ex1_expt_tval,
  input    wire  [14:0]  lsu_rtu_ex1_expt_vec,
  input    wire          lsu_rtu_ex1_expt_vld,
  input    wire          lsu_rtu_ex1_fs_dirty,
  input    wire  [21:0]  lsu_rtu_ex1_halt_info,
  input    wire          lsu_rtu_ex1_inst_len,
  input    wire          lsu_rtu_ex1_inst_split,
  input    wire          lsu_rtu_ex1_tval2_vld,
  input    wire          lsu_rtu_ex1_vs_dirty,
  input    wire  [6 :0]  lsu_rtu_ex1_vstart,
  input    wire          lsu_rtu_ex1_vstart_vld,
  input    wire  [39:0]  lsu_rtu_ex2_tval2,
  input    wire          vpu_rtu_inst_expt_vld,
  input    wire          pad_yy_icg_scan_en,
  input    wire          vpu_rtu_ex1_cmplt_dp,
  input    wire          vpu_rtu_ex1_inst_split,
  output   wire          dp_ctrl_ex1_cmplt_dp,
  output   wire          dp_int_ex2_inst_split,
  output   wire  [63:0]  dp_retire_ex2_cur_pc,
  output   wire          dp_retire_ex2_fs_dirty,
  output   wire  [21:0]  dp_retire_ex2_halt_info,
  output   wire          dp_retire_ex2_inst_branch,
  output   wire          dp_retire_ex2_inst_chgflw,
  output   wire          dp_retire_ex2_inst_dret,
  output   wire          dp_retire_ex2_inst_ebreak,
  output   wire          dp_retire_ex2_inst_expt,
  output   wire          dp_retire_ex2_inst_flush,
  output   wire          dp_retire_ex2_inst_ertn,
  output   wire          dp_retire_ex2_inst_mret,
  output   wire          dp_retire_ex2_inst_split,
  output   wire          dp_retire_ex2_inst_sret,
  output   wire          dp_retire_ex2_inst_vstart,
  output   wire  [63:0]  dp_retire_ex2_next_pc,
  output   wire  [63:0]  dp_retire_ex2_tval,
  output   wire  [14:0]  dp_retire_ex2_vec,
  output   wire          dp_retire_ex2_vs_dirty,
  output   wire  [6 :0]  dp_retire_ex2_vstart,
  output   wire  [2 :0]  dp_top_dbg_info,
  output   wire          rtu_iu_ex1_inst_len,
  output   wire          rtu_iu_ex1_inst_split,
  output   wire  [63:0]  rtu_iu_ex2_cur_pc,
  output   wire  [63:0]  rtu_iu_ex2_next_pc
); 



// &Regs; @28
reg             dp_ex1_inst_len;            
reg             dp_ex1_inst_split;          
reg     [63:0]  dp_ex2_cur_pc;              
reg     [14:0]  dp_ex2_expt_vec;            
reg             dp_ex2_fs_dirty;            
reg     [21:0]  dp_ex2_halt_info;           
reg             dp_ex2_inst_branch;         
reg             dp_ex2_inst_chgflw;         
reg             dp_ex2_inst_dret;           
reg             dp_ex2_inst_ebreak;         
reg             dp_ex2_inst_expt;           
reg             dp_ex2_inst_flush;          
reg             dp_ex2_inst_ertn;           
reg             dp_ex2_inst_mret;           
reg             dp_ex2_inst_split;          
reg             dp_ex2_inst_sret;           
reg             dp_ex2_inst_vstart;         
reg     [63:0]  dp_ex2_next_pc;             
reg     [63:0]  dp_ex2_tval;                
reg             dp_ex2_tval2_vld;           
reg             dp_ex2_vs_dirty;            
reg     [6 :0]  dp_ex2_vstart;              

// &Wires; @29
wire    [6 :0]  dp_cmplt_source;            
wire            dp_ex1_alu_cmplt_dp;        
wire            dp_ex1_bju_cmplt_dp;        
wire            dp_ex1_cmplt;               
wire            dp_ex1_cmplt_dp;            
wire    [63:0]  dp_ex1_cp0_chgflw_pc;       
wire            dp_ex1_cp0_cmplt_dp;        
wire    [63:0]  dp_ex1_cur_pc;              
wire            dp_ex1_div_cmplt_dp;        
wire    [14:0]  dp_ex1_expt_vec;            
wire            dp_ex1_fs_dirty;            
wire    [21:0]  dp_ex1_halt_info;           
wire            dp_ex1_inst_branch;         
wire            dp_ex1_inst_chgflw;         
wire            dp_ex1_inst_dret;           
wire            dp_ex1_inst_ebreak;         
wire            dp_ex1_inst_expt;           
wire            dp_ex1_inst_flush;          
wire            dp_ex1_inst_ertn;           
wire            dp_ex1_inst_mret;           
wire            dp_ex1_inst_sret;           
wire            dp_ex1_inst_vstart;         
wire            dp_ex1_lsu_cmplt_dp;        
wire            dp_ex1_mul_cmplt_dp;        
wire    [63:0]  dp_ex1_next_pc;             
wire            dp_ex1_trap_updt;           
wire    [63:0]  dp_ex1_tval;                
wire            dp_ex1_tval2_vld;           
wire            dp_ex1_vec_cmplt_dp;        
wire            dp_ex1_vs_dirty;            
wire    [6 :0]  dp_ex1_vstart;              
wire            dp_trap_clk;                
wire            dp_trap_clk_en;             


//==========================================================
//                        Inst Info
//==========================================================
assign dp_ex1_alu_cmplt_dp = iu_rtu_ex1_alu_cmplt_dp || ifu_rtu_warm_up;
assign dp_ex1_mul_cmplt_dp = iu_rtu_ex1_mul_cmplt_dp;
assign dp_ex1_bju_cmplt_dp = iu_rtu_ex1_bju_cmplt_dp;
assign dp_ex1_div_cmplt_dp = iu_rtu_ex1_div_cmplt_dp;
assign dp_ex1_lsu_cmplt_dp = lsu_rtu_ex1_cmplt_dp;
assign dp_ex1_cp0_cmplt_dp = cp0_rtu_ex1_cmplt_dp;
assign dp_ex1_vec_cmplt_dp = vpu_rtu_ex1_cmplt_dp;

parameter CBUS_ALU_SEL = 7'b100_0000;
parameter CBUS_MUL_SEL = 7'b010_0000;
parameter CBUS_BJU_SEL = 7'b001_0000;
parameter CBUS_DIV_SEL = 7'b000_1000;
parameter CBUS_LSU_SEL = 7'b000_0100;
parameter CBUS_CP0_SEL = 7'b000_0010;
parameter CBUS_VEC_SEL = 7'b000_0001;
// only eliminate xxx signals value
parameter CBUS_NOP_SEL = 7'b000_0000;

assign dp_cmplt_source[6:0] = {dp_ex1_alu_cmplt_dp,
                               dp_ex1_mul_cmplt_dp,
                               dp_ex1_bju_cmplt_dp,
                               dp_ex1_div_cmplt_dp,
                               dp_ex1_lsu_cmplt_dp,
                               dp_ex1_cp0_cmplt_dp,
                               dp_ex1_vec_cmplt_dp};
assign dp_ex1_cmplt_dp = |dp_cmplt_source[6:0];
// TODO add assertion here: cmplt_dp is onehot.

//----------------------------------------------------------
//                            PC
//----------------------------------------------------------
assign dp_ex1_cur_pc[63:0]  = iu_rtu_ex1_cur_pc[63:0];
assign dp_ex1_next_pc[63:0] = dp_ex1_inst_chgflw ? dp_ex1_cp0_chgflw_pc[63:0]
                                                   : iu_rtu_ex1_next_pc[63:0];

//----------------------------------------------------------
//                           MISC
//----------------------------------------------------------
// &CombBeg; @70
always @( iu_rtu_ex1_bju_inst_len
       or cp0_rtu_ex1_inst_split
       or iu_rtu_ex1_alu_inst_split
       or lsu_rtu_ex1_inst_len
       or cp0_rtu_ex1_inst_len
       or lsu_rtu_ex1_inst_split
       or dp_cmplt_source[6:0]
       or iu_rtu_ex1_alu_inst_len
       or vpu_rtu_ex1_inst_split)
begin
case(dp_cmplt_source[6:0])
  CBUS_ALU_SEL: begin
    dp_ex1_inst_len   = iu_rtu_ex1_alu_inst_len;
    dp_ex1_inst_split = iu_rtu_ex1_alu_inst_split;
  end
  CBUS_MUL_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = 1'b0;
  end
  CBUS_BJU_SEL: begin
    dp_ex1_inst_len   = iu_rtu_ex1_bju_inst_len;
    dp_ex1_inst_split = 1'b0;
  end
  CBUS_DIV_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = 1'b0;
  end
  CBUS_LSU_SEL: begin
    dp_ex1_inst_len   = lsu_rtu_ex1_inst_len;
    dp_ex1_inst_split = lsu_rtu_ex1_inst_split;
  end
  CBUS_CP0_SEL: begin
    dp_ex1_inst_len   = cp0_rtu_ex1_inst_len;
    dp_ex1_inst_split = cp0_rtu_ex1_inst_split;
  end
  CBUS_VEC_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = vpu_rtu_ex1_inst_split;
  end
  CBUS_NOP_SEL: begin
    dp_ex1_inst_len   = 1'b1;
    dp_ex1_inst_split = 1'b0;
  end
  default: begin
    dp_ex1_inst_len   = 1'bx;
    dp_ex1_inst_split = 1'bx;
  end
endcase
// &CombEnd; @105
end

assign dp_ex1_inst_branch = dp_ex1_bju_cmplt_dp && iu_rtu_ex1_branch_inst;
assign dp_ex1_inst_ertn   = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_inst_ertn;
assign dp_ex1_inst_mret   = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_inst_mret;
assign dp_ex1_inst_sret   = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_inst_sret;
assign dp_ex1_inst_flush  = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_flush;

//----------------------------------------------------------
//                        Changeflow
//----------------------------------------------------------
assign dp_ex1_inst_chgflw         = dp_ex1_cp0_cmplt_dp && cp0_rtu_ex1_chgflw;
assign dp_ex1_cp0_chgflw_pc[63:0] = cp0_rtu_ex1_chgflw_pc[63:0];

//----------------------------------------------------------
//                          Debug
//----------------------------------------------------------
assign dp_ex1_halt_info[`TDT_HINFO_WIDTH-1:0] = 
    {`TDT_HINFO_WIDTH{lsu_rtu_ex1_cmplt_dp}} & lsu_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0]
  | {`TDT_HINFO_WIDTH{cp0_rtu_ex1_cmplt_dp}} & cp0_rtu_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];

assign dp_ex1_inst_ebreak = cp0_rtu_ex1_cmplt_dp && cp0_rtu_ex1_inst_ebreak;
assign dp_ex1_inst_dret   = cp0_rtu_ex1_cmplt_dp && cp0_rtu_ex1_inst_dret;

//----------------------------------------------------------
//                           Trap
//----------------------------------------------------------
assign dp_ex1_inst_expt     = cp0_rtu_ex1_expt_vld
                           || lsu_rtu_ex1_expt_vld && lsu_rtu_ex1_cmplt_dp;
assign dp_ex1_tval2_vld     = lsu_rtu_ex1_tval2_vld && lsu_rtu_ex1_cmplt_dp;
assign dp_ex1_expt_vec[14:0] = cp0_rtu_ex1_cmplt_dp ? cp0_rtu_ex1_expt_vec[14:0]
                                                    : lsu_rtu_ex1_expt_vec[14:0];
assign dp_ex1_tval[`PA_WIDTH-1:0] = cp0_rtu_ex1_cmplt_dp ? cp0_rtu_ex1_expt_tval[`PA_WIDTH-1:0]
                                                         : lsu_rtu_ex1_expt_tval[`PA_WIDTH-1:0];

//----------------------------------------------------------
//                          VSTART
//----------------------------------------------------------
assign dp_ex1_inst_vstart = dp_ex1_lsu_cmplt_dp && lsu_rtu_ex1_vstart_vld;
assign dp_ex1_vstart[6:0] = lsu_rtu_ex1_vstart[6:0];

//----------------------------------------------------------
//                       FS VS DIRTY
//----------------------------------------------------------
assign dp_ex1_fs_dirty = dp_ex1_lsu_cmplt_dp && lsu_rtu_ex1_fs_dirty;
assign dp_ex1_vs_dirty = dp_ex1_lsu_cmplt_dp && lsu_rtu_ex1_vs_dirty;

//==========================================================
//                         Pipedown
//==========================================================
assign dp_ex1_cmplt = ctrl_dp_ex1_cmplt_dp;

always @ (posedge dp_misc_clk)
begin
  if (dp_ex1_cmplt || ifu_rtu_warm_up) begin
    dp_ex2_inst_split             <= dp_ex1_inst_split;
    dp_ex2_inst_branch            <= dp_ex1_inst_branch;
    dp_ex2_inst_ertn              <= dp_ex1_inst_ertn;
    dp_ex2_inst_mret              <= dp_ex1_inst_mret;
    dp_ex2_inst_sret              <= dp_ex1_inst_sret;
    dp_ex2_inst_flush             <= dp_ex1_inst_flush;
    dp_ex2_inst_chgflw            <= dp_ex1_inst_chgflw;
    dp_ex2_halt_info[`TDT_HINFO_WIDTH-1:0]
                                  <= dp_ex1_halt_info[`TDT_HINFO_WIDTH-1:0];
    dp_ex2_inst_ebreak            <= dp_ex1_inst_ebreak;
    dp_ex2_inst_dret              <= dp_ex1_inst_dret;
    dp_ex2_inst_expt              <= dp_ex1_inst_expt;
    dp_ex2_cur_pc[63:0]           <= dp_ex1_cur_pc[63:0];
    dp_ex2_next_pc[63:0]          <= dp_ex1_next_pc[63:0];
    dp_ex2_inst_vstart            <= dp_ex1_inst_vstart;
    dp_ex2_fs_dirty               <= dp_ex1_fs_dirty;
    dp_ex2_vs_dirty               <= dp_ex1_vs_dirty;
  end
end

// inst_expt timing is bad. use lsu_cmplt_dp instead.
// so trap_clk can also use for lsu info.
assign dp_ex1_trap_updt = cp0_rtu_ex1_cmplt_dp
                       || lsu_rtu_ex1_cmplt_dp;
always @ (posedge dp_trap_clk)
begin
  if (dp_ex1_cmplt && dp_ex1_trap_updt || ifu_rtu_warm_up) begin
    // lsu info
    dp_ex2_vstart[6:0]            <= dp_ex1_vstart[6:0];
    // trap info
    dp_ex2_tval2_vld           <= dp_ex1_tval2_vld;
    dp_ex2_expt_vec[14:0]      <= dp_ex1_expt_vec[14:0];
    dp_ex2_tval[`PA_WIDTH-1:0] <= dp_ex1_tval[`PA_WIDTH-1:0];
  end
end

//==========================================================
//                           ICG
//==========================================================
assign dp_trap_clk_en = dp_ex1_cmplt && dp_ex1_trap_updt
                     || ifu_rtu_warm_up;
// &Instance("gated_clk_cell", "x_dp_trap_clk"); @199
gated_clk_cell  x_dp_trap_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (dp_trap_clk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (dp_trap_clk_en    ),
  .module_en          (cp0_rtu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @200
//          .external_en (1'b0), @201
//          .global_en   (cp0_yy_clk_en), @202
//          .module_en   (cp0_rtu_icg_en), @203
//          .local_en    (dp_trap_clk_en), @204
//          .clk_out     (dp_trap_clk)); @205

//==========================================================
//                          Output
//==========================================================
//----------------------------------------------------------
//                         For RTU
//----------------------------------------------------------
assign dp_ctrl_ex1_cmplt_dp = dp_ex1_cmplt_dp;

assign dp_int_ex2_inst_split = dp_ex2_inst_split;

assign dp_retire_ex2_inst_split             = dp_ex2_inst_split;
assign dp_retire_ex2_inst_branch            = dp_ex2_inst_branch;
assign dp_retire_ex2_inst_ertn              = dp_ex2_inst_ertn;
assign dp_retire_ex2_inst_mret              = dp_ex2_inst_mret;
assign dp_retire_ex2_inst_sret              = dp_ex2_inst_sret;
assign dp_retire_ex2_inst_flush             = dp_ex2_inst_flush;
assign dp_retire_ex2_inst_chgflw            = dp_ex2_inst_chgflw;
assign dp_retire_ex2_halt_info[`TDT_HINFO_WIDTH-1:0]
                                            = dp_ex2_halt_info[`TDT_HINFO_WIDTH-1:0];
assign dp_retire_ex2_inst_ebreak            = dp_ex2_inst_ebreak;
assign dp_retire_ex2_inst_dret              = dp_ex2_inst_dret;
assign dp_retire_ex2_inst_expt              = dp_ex2_inst_expt;
assign dp_retire_ex2_cur_pc[63:0]           = dp_ex2_cur_pc[63:0];
assign dp_retire_ex2_next_pc[63:0]          = iu_rtu_depd_lsu_chgflow_vld ?
                                                      iu_rtu_depd_lsu_next_pc[63:0]
                                                    : dp_ex2_next_pc[63:0];
assign dp_retire_ex2_vec[14:0]              = dp_ex2_expt_vec[14:0];
assign dp_retire_ex2_tval[`PA_WIDTH-1:0]    = dp_ex2_tval2_vld ? lsu_rtu_ex2_tval2[`PA_WIDTH-1:0]
                                                               : dp_ex2_tval[`PA_WIDTH-1:0];

assign dp_retire_ex2_inst_vstart            = dp_ex2_inst_vstart;
assign dp_retire_ex2_vstart[6:0]            = dp_ex2_vstart[6:0];

assign dp_retire_ex2_fs_dirty               = dp_ex2_fs_dirty;
assign dp_retire_ex2_vs_dirty               = dp_ex2_vs_dirty;

assign dp_top_dbg_info[2:0] = {dp_ex2_inst_expt,
                               dp_ex2_inst_chgflw,
                               dp_ex2_inst_flush};

//----------------------------------------------------------
//                          For IU
//----------------------------------------------------------
assign rtu_iu_ex1_inst_split    = dp_ex1_inst_split;
assign rtu_iu_ex1_inst_len      = dp_ex1_inst_len;
assign rtu_iu_ex2_cur_pc[63:0]  = dp_ex2_cur_pc[63:0];
assign rtu_iu_ex2_next_pc[63:0] = dp_ex2_next_pc[63:0];


// &ModuleEnd; @265
endmodule



