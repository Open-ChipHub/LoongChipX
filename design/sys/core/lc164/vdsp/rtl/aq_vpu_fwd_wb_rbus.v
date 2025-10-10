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

// &ModuleBeg; @24
module aq_vpu_fwd_wb_rbus (
  // &Ports, @25
  input    wire          cp0_vpu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire  [4 :0]  cp0_vpu_fflags_enable,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          ifu_vpu_warm_up,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_vpu_gpr_wb_grnt,
  input    wire          rtu_yy_xx_async_flush,
  input    wire  [63:0]  vfalu_vpu_ex3_fpr_result,
  input    wire  [63:0]  vfcvt_vpu_ex3_fpr_result,
  input    wire  [4 :0]  vfdsu_rbus_fflags,
  input    wire          vfdsu_rbus_fflags_vld,
  input    wire  [63:0]  vfdsu_rbus_fpr_wb_data,
  input    wire  [4 :0]  vfdsu_rbus_fpr_wb_index,
  input    wire          vfdsu_rbus_fpr_wb_req,
  input    wire          vfdsu_vpu_busy,
  input    wire  [63:0]  vfmau_vpu_ex3_fpr_result,
  input    wire          vidu_vpu_vid_fp_inst_vld,
  input    wire  [5 :0]  viq0_rbus_ex3_fflags,
  input    wire          viq0_rbus_ex3_fflags_vld,
  input    wire          viq0_rbus_ex3_split_vld,
  input    wire  [63:0]  viq0_rbus_ex3_fpr_wb_data,
  input    wire  [4 :0]  viq0_rbus_ex3_fpr_wb_index,
  input    wire          viq0_rbus_ex3_fpr_wb_req,
  input    wire  [2 :0]  viq0_rbus_ex3_fpu_wb_sel,
  input    wire  [63:0]  viq0_rbus_ex3_gpr_wb_data,
  input    wire  [5 :0]  viq0_rbus_ex3_gpr_wb_index,
  input    wire          viq0_rbus_ex3_gpr_wb_req,
  input    wire          viq0_rbus_ex3_fcc_wb_data,
  input    wire  [2 :0]  viq0_rbus_ex3_fcc_wb_index,
  input    wire          viq0_rbus_ex3_fcc_wb_req,
  input    wire  [5 :0]  viq0_rbus_ex4_fflags,
  input    wire          viq0_rbus_ex4_fflags_vld,
  input    wire  [63:0]  viq0_rbus_ex4_fpr_wb_data,
  input    wire  [4 :0]  viq0_rbus_ex4_fpr_wb_index,
  input    wire          viq0_rbus_ex4_fpr_wb_req,
  input    wire  [5 :0]  viq0_rbus_ex5_fflags,
  input    wire          viq0_rbus_ex5_fflags_vld,
  input    wire  [63:0]  viq0_rbus_ex5_fpr_wb_data,
  input    wire  [4 :0]  viq0_rbus_ex5_fpr_wb_index,
  input    wire          viq0_rbus_ex5_fpr_wb_req,
  input    wire  [3 :0]  viq0_xx_ex1_gp_sel,
  input    wire          viq0_xx_ex1_lsu_inst_vld,
  input    wire          viq0_xx_ex1_srcv2_ready,
  input    wire          viq0_xx_ex1_stall,
  input    wire  [6 :0]  viq0_xx_ex1_vreg,
  input    wire          viq0_xx_ex5_stall,
  input    wire          viq0_xx_ex5_vld,
  input    wire          viq0_xx_no_op,
  input    wire          viq1_xx_ex5_stall,
  input    wire  [63:0]  vlsu_rbus_fpr_wb_data,
  input    wire  [4 :0]  vlsu_rbus_fpr_wb_index,
  input    wire          vlsu_rbus_fpr_wb_req,
  input    wire          vlsu_xx_ex1_fp_stall,
  input    wire  [9 :0]  vpu_group_3_xx_ex1_eu_sel,
  input    wire          vpu_group_3_xx_ex1_sel,
  output   wire          rbus_vfdsu_fpr_wb_grnt,
  output   wire          rbus_viq0_ex3_fpr_wb_grnt,
  output   wire          rbus_viq0_ex3_gpr_wb_grnt,
  output   wire          rbus_viq0_ex4_fpr_wb_grnt,
  output   wire          rbus_viq0_ex5_fpr_wb_grnt,
  output   wire  [28:0]  vpu_dtu_dbg_info,
  output   wire          vpu_group_0_xx_ex5_sel,
  output   wire          vpu_group_0_xx_ex5_stall,
  output   wire          vpu_group_3_xx_ex1_srcv2_ready,
  output   wire  [6 :0]  vpu_group_3_xx_ex1_vreg,
  output   wire  [5 :0]  vpu_rtu_fflag,
  output   wire          vpu_rtu_fflag_vld,
  output   wire  [1 :0]  vpu_rtu_fflag_num,
  output   wire          vpu_rtu_split_vld,
  output   wire  [63:0]  vpu_rtu_gpr_wb_data,
  output   wire  [5 :0]  vpu_rtu_gpr_wb_index,
  output   wire          vpu_rtu_gpr_wb_req,
  output   wire          vpu_rtu_fcc_wb_req,
  output   wire  [2 :0]  vpu_rtu_fcc_wb_index,
  output   wire          vpu_rtu_fcc_wb_data,
  output   wire          vpu_rtu_no_op,
  output   wire          vpu_rtu_inst_expt_vld,
  output   wire          vpu_vfdsu_ex1_sel,
  output   wire  [63:0]  vpu_vidu_fp_fwd_data,
  output   wire  [4 :0]  vpu_vidu_fp_fwd_reg,
  output   wire          vpu_vidu_fp_fwd_vld,
  output   wire  [63:0]  vpu_vidu_fp_wb_data,
  output   wire  [4 :0]  vpu_vidu_fp_wb_reg,
  output   wire          vpu_vidu_fp_wb_vld,
  output   wire          vpu_vidu_vex1_fp_stall,
  output   wire  [4 :0]  vpu_vidu_wbt_fp_wb0_reg,
  output   wire          vpu_vidu_wbt_fp_wb0_vld,
  output   wire  [4 :0]  vpu_vidu_wbt_fp_wb1_reg,
  output   wire          vpu_vidu_wbt_fp_wb1_vld,
  output   wire          vpu_vlsu_ex1_lsu_inst_vld,
  output   wire  [63:0]  vpu_vlsu_fp_wb_data,
  output   wire  [4 :0]  vpu_vlsu_fp_wb_reg,
  output   wire          vpu_vlsu_fp_wb_vld
); 



// &Regs; @26
reg     [63:0]  fpr_data;                      
reg     [4 :0]  fpr_index;                     
reg     [63:0]  fpr_wb_data;                   
reg     [4 :0]  fpr_wb_index;                  
reg             fpr_wb_vld;                    
reg             fpr_wbt_wb0_vld;               
reg     [63:0]  viq_ex3_fpr_wb_data;           

// &Wires; @27
wire    [2 :0]  ex3_fpr_wb_sel;                
wire            fpr_wb_clk;                    
wire            fpr_wb_clk_en;                 
wire    [5 :0]  fpr_wb_sel;                    
wire    [4 :0]  h_bank_wb_index;               
wire            h_bank_wb_vld;                 
wire    [4 :0]  l_bank_wb_index;               
wire            l_bank_wb_vld;                 
wire            vdivu_vpu_busy;                
wire            vidu_vpu_vid_vec0_inst_vld;    
wire            vidu_vpu_vid_vec1_inst_vld;    
wire    [5 :0]  viq1_rbus_ex3_fflags;          
wire            viq1_rbus_ex3_fflags_vld;      
wire    [63:0]  viq1_rbus_ex3_fpr_wb_data;     
wire    [4 :0]  viq1_rbus_ex3_fpr_wb_index;    
wire            viq1_rbus_ex3_fpr_wb_req;      
wire    [2 :0]  viq1_rbus_ex3_fpu_wb_sel;      
wire    [63:0]  viq1_rbus_ex3_gpr_wb_data;     
wire    [5 :0]  viq1_rbus_ex3_gpr_wb_index;    
wire            viq1_rbus_ex3_gpr_wb_req;      
wire    [5 :0]  viq1_rbus_ex4_fflags;          
wire            viq1_rbus_ex4_fflags_vld;      
wire    [5 :0]  viq1_rbus_ex5_fflags;          
wire            viq1_rbus_ex5_fflags_vld;      
wire            viq1_xx_ex1_srcv2_ready;       
wire            viq1_xx_ex1_stall;             
wire    [6 :0]  viq1_xx_ex1_vreg;              
wire            viq1_xx_no_op;                 


parameter FLEN       = 64;
parameter XLEN       = 64;
parameter VREG       = 7;

// &CombBeg; @124
// &CombEnd; @131
// &CombBeg; @133
// &CombEnd; @140
// &CombBeg; @143
// &CombEnd; @150
// &Instance("gated_clk_cell", "x_vpu_rbus_vpr_h_bank_wb_gated_clk"); @162
// &Connect(.clk_in      (forever_cpuclk), @163
//          .external_en (1'b0), @164
//          .global_en   (cp0_yy_clk_en), @165
//          .module_en   (cp0_vpu_icg_en), @166
//          .local_en    (h_bank_wb_clk_en), @167
//          .clk_out     (h_bank_wb_clk)); @168
// &CombBeg; @249
// &CombEnd; @256
// &CombBeg; @258
// &CombEnd; @265
// &Instance("gated_clk_cell", "x_vpu_rbus_vpr_l_bank_wb_gated_clk"); @277
// &Connect(.clk_in      (forever_cpuclk), @278
//          .external_en (1'b0), @279
//          .global_en   (cp0_yy_clk_en), @280
//          .module_en   (cp0_vpu_icg_en), @281
//          .local_en    (l_bank_wb_clk_en), @282
//          .clk_out     (l_bank_wb_clk)); @283
//=========================================================================
//      GPR WRITE BACK REQ
//=========================================================================
assign viq1_rbus_ex3_gpr_wb_data[FLEN-1:0] = {FLEN{1'b0}};
assign viq1_rbus_ex3_gpr_wb_index[5:0]     = {6{1'b0}};
assign viq1_rbus_ex3_gpr_wb_req            = 1'b0;

assign vpu_rtu_gpr_wb_req            = viq0_rbus_ex3_gpr_wb_req || viq1_rbus_ex3_gpr_wb_req;
assign vpu_rtu_gpr_wb_index[5:0]     = viq0_rbus_ex3_gpr_wb_req 
                                     ? viq0_rbus_ex3_gpr_wb_index[5:0]
                                     : viq1_rbus_ex3_gpr_wb_index[5:0];
assign vpu_rtu_gpr_wb_data[XLEN-1:0] = viq0_rbus_ex3_gpr_wb_req 
                                     ? viq0_rbus_ex3_gpr_wb_data[XLEN-1:0] 
                                     : viq1_rbus_ex3_gpr_wb_data[XLEN-1:0]; 

assign rbus_viq0_ex3_gpr_wb_grnt = rtu_vpu_gpr_wb_grnt;

//=========================================================================
//      FCC WRITE BACK REQ
//=========================================================================

assign vpu_rtu_fcc_wb_req            = viq0_rbus_ex3_fcc_wb_req;
assign vpu_rtu_fcc_wb_index[2:0]     = viq0_rbus_ex3_fcc_wb_index;
assign vpu_rtu_fcc_wb_data           = viq0_rbus_ex3_fcc_wb_data;

//=========================================================================
//      FFLAGS WRITE BACK REQ
//=========================================================================

assign viq1_rbus_ex3_fflags_vld = 1'b0;
assign viq1_rbus_ex4_fflags_vld = 1'b0;
assign viq1_rbus_ex5_fflags_vld = 1'b0;
assign viq1_rbus_ex3_fflags[5:0]= {6{1'b0}};
assign viq1_rbus_ex4_fflags[5:0]= {6{1'b0}};
assign viq1_rbus_ex5_fflags[5:0]= {6{1'b0}};

assign vpu_rtu_fflag_vld = (viq0_rbus_ex3_fflags_vld && rbus_viq0_ex3_fpr_wb_grnt ||
                           viq0_rbus_ex4_fflags_vld && rbus_viq0_ex4_fpr_wb_grnt ||
                           viq0_rbus_ex5_fflags_vld && rbus_viq0_ex5_fpr_wb_grnt || 
                           vfdsu_rbus_fflags_vld && rbus_vfdsu_fpr_wb_grnt);
wire add_cmp                = viq0_rbus_ex3_fflags_vld && viq0_rbus_ex3_fcc_wb_req
                          &&  viq0_rbus_ex4_fflags_vld && rbus_viq0_ex4_fpr_wb_grnt;
assign vpu_rtu_fflag_num[1] = add_cmp;
assign vpu_rtu_fflag_num[0] = !add_cmp;
assign vpu_rtu_split_vld = viq0_rbus_ex3_split_vld;

assign vpu_rtu_fflag[5:0]= viq0_rbus_ex3_fflags[5:0] & {6{viq0_rbus_ex3_fflags_vld && rbus_viq0_ex3_fpr_wb_grnt}} 
                         | viq0_rbus_ex4_fflags[5:0] & {6{viq0_rbus_ex4_fflags_vld && rbus_viq0_ex4_fpr_wb_grnt}}
                         | viq0_rbus_ex5_fflags[5:0] & {6{viq0_rbus_ex5_fflags_vld && rbus_viq0_ex5_fpr_wb_grnt}}
                       |{1'b0,vfdsu_rbus_fflags[4:0]}& {6{   vfdsu_rbus_fflags_vld && rbus_vfdsu_fpr_wb_grnt}};

assign vpu_rtu_inst_expt_vld = vpu_rtu_fflag_vld & (|(vpu_rtu_fflag[4:0] & cp0_vpu_fflags_enable[4:0]));
//=========================================================================
//      VIQ0 FPR  EX3 EX4 EX5  VIQ1 FPR EX3  FDSU FLSU SELECT
//=========================================================================
assign viq1_rbus_ex3_fpr_wb_data[FLEN-1:0] = {FLEN{1'b0}};
assign viq1_rbus_ex3_fpr_wb_index[4:0]     = {5{1'b0}};
assign viq1_rbus_ex3_fpr_wb_req            = 1'b0;
assign viq1_rbus_ex3_fpu_wb_sel[2:0]       = {3{1'b0}};
assign rbus_vfdsu_fpr_wb_grnt = !fpr_wb_sel[5];
assign rbus_viq0_ex5_fpr_wb_grnt = !(|fpr_wb_sel[5:4]);
assign rbus_viq0_ex4_fpr_wb_grnt = !(|fpr_wb_sel[5:3]);
assign rbus_viq0_ex3_fpr_wb_grnt = !(|fpr_wb_sel[5:2]);

assign ex3_fpr_wb_sel[2:0] = viq0_rbus_ex3_fpr_wb_req ? viq0_rbus_ex3_fpu_wb_sel[2:0] : viq1_rbus_ex3_fpu_wb_sel[2:0];

// &CombBeg; @419
always @( viq1_rbus_ex3_fpr_wb_data[63:0]
       or vfalu_vpu_ex3_fpr_result[63:0]
       or vfmau_vpu_ex3_fpr_result[63:0]
       or viq0_rbus_ex3_fpr_wb_req
       or viq0_rbus_ex3_fpr_wb_data[63:0]
       or ex3_fpr_wb_sel[2:0]
       or vfcvt_vpu_ex3_fpr_result[63:0])
begin
case(ex3_fpr_wb_sel[2:0])
   3'b001:viq_ex3_fpr_wb_data[FLEN-1:0] =  vfmau_vpu_ex3_fpr_result[FLEN-1:0]; 
   3'b010:viq_ex3_fpr_wb_data[FLEN-1:0] =  vfalu_vpu_ex3_fpr_result[FLEN-1:0]; 
   3'b100:viq_ex3_fpr_wb_data[FLEN-1:0] =  vfcvt_vpu_ex3_fpr_result[FLEN-1:0]; 
  default:viq_ex3_fpr_wb_data[FLEN-1:0] =  viq0_rbus_ex3_fpr_wb_req ? viq0_rbus_ex3_fpr_wb_data[FLEN-1:0]: viq1_rbus_ex3_fpr_wb_data[FLEN-1:0];
endcase
// &CombEnd; @426
end

assign fpr_wb_sel[5:0] = {vlsu_rbus_fpr_wb_req, 
                         vfdsu_rbus_fpr_wb_req, 
                      viq0_rbus_ex5_fpr_wb_req, 
                      viq0_rbus_ex4_fpr_wb_req,
                      viq0_rbus_ex3_fpr_wb_req,
                      viq1_rbus_ex3_fpr_wb_req};
// &CombBeg; @434
always @( vlsu_rbus_fpr_wb_data[63:0]
       or fpr_wb_sel[5:2]
       or vfdsu_rbus_fpr_wb_data[63:0]
       or viq0_rbus_ex4_fpr_wb_data[63:0]
       or viq0_rbus_ex5_fpr_wb_data[63:0]
       or viq_ex3_fpr_wb_data[63:0])
begin
casez(fpr_wb_sel[5:2])
  4'b1???: fpr_data[FLEN-1:0]  =  vlsu_rbus_fpr_wb_data[FLEN-1:0];
  4'b01??: fpr_data[FLEN-1:0]  =  vfdsu_rbus_fpr_wb_data[FLEN-1:0];
  4'b001?: fpr_data[FLEN-1:0]  =  viq0_rbus_ex5_fpr_wb_data[FLEN-1:0];
  4'b0001: fpr_data[FLEN-1:0]  =  viq0_rbus_ex4_fpr_wb_data[FLEN-1:0];
  default: fpr_data[FLEN-1:0]  =  viq_ex3_fpr_wb_data[FLEN-1:0];
endcase
// &CombEnd; @442
end

// &CombBeg; @444
always @( viq0_rbus_ex5_fpr_wb_index[4:0]
       or fpr_wb_sel[5:0]
       or viq0_rbus_ex3_fpr_wb_index[4:0]
       or viq1_rbus_ex3_fpr_wb_index[4:0]
       or vlsu_rbus_fpr_wb_index[4:0]
       or viq0_rbus_ex4_fpr_wb_index[4:0]
       or vfdsu_rbus_fpr_wb_index[4:0])
begin
casez(fpr_wb_sel[5:0])
  6'b1?????: fpr_index[4:0] =     vlsu_rbus_fpr_wb_index[4:0];
  6'b01????: fpr_index[4:0] =    vfdsu_rbus_fpr_wb_index[4:0];
  6'b001???: fpr_index[4:0] = viq0_rbus_ex5_fpr_wb_index[4:0];
  6'b0001??: fpr_index[4:0] = viq0_rbus_ex4_fpr_wb_index[4:0];
  6'b00001?: fpr_index[4:0] = viq0_rbus_ex3_fpr_wb_index[4:0];
  6'b000001: fpr_index[4:0] = viq1_rbus_ex3_fpr_wb_index[4:0];
    default: fpr_index[4:0] = {5{1'bx}};
endcase
// &CombEnd; @454
end

assign vpu_vidu_fp_fwd_vld             = |fpr_wb_sel[5:0];
assign vpu_vidu_fp_fwd_data[FLEN-1:0]  = fpr_data[FLEN-1:0];
assign vpu_vidu_fp_fwd_reg[4:0]        = fpr_index[4:0];

assign vpu_vidu_wbt_fp_wb1_vld      = fpr_wb_sel[5];
assign vpu_vidu_wbt_fp_wb1_reg[4:0] = vlsu_rbus_fpr_wb_index[4:0];
//=========================================================================
//      VREG LOW BANK FLOPDOWN
//=========================================================================
assign fpr_wb_clk_en = |fpr_wb_sel[5:0] || fpr_wb_vld || ifu_vpu_warm_up;
// &Instance("gated_clk_cell", "x_vpu_rbus_fpr_wb_gated_clk"); @466
gated_clk_cell  x_vpu_rbus_fpr_wb_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (fpr_wb_clk        ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (fpr_wb_clk_en     ),
  .module_en          (cp0_vpu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @467
//          .external_en (1'b0), @468
//          .global_en   (cp0_yy_clk_en), @469
//          .module_en   (cp0_vpu_icg_en), @470
//          .local_en    (fpr_wb_clk_en), @471
//          .clk_out     (fpr_wb_clk)); @472

always @(posedge fpr_wb_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    fpr_wb_vld      <= 1'b0;
    fpr_wbt_wb0_vld <= 1'b0;
  end
  else if(rtu_yy_xx_async_flush) begin
    fpr_wb_vld      <= 1'b0;
    fpr_wbt_wb0_vld <= 1'b0;
  end
  else begin
    fpr_wb_vld      <= |fpr_wb_sel[5:0];
    fpr_wbt_wb0_vld <= |fpr_wb_sel[4:0] && !fpr_wb_sel[5];
  end
end

always @(posedge fpr_wb_clk)
begin
  if(|fpr_wb_sel[5:0] || ifu_vpu_warm_up) begin
    fpr_wb_index[4:0]       <= fpr_index[4:0];
    fpr_wb_data[FLEN-1:0]   <= fpr_data[FLEN-1:0];
  end
end

assign vpu_vidu_fp_wb_vld             = fpr_wb_vld;
assign vpu_vidu_fp_wb_data[FLEN-1:0]  = fpr_wb_data[FLEN-1:0];
assign vpu_vidu_fp_wb_reg[4:0]        = fpr_wb_index[4:0];

assign vpu_vlsu_fp_wb_vld             = fpr_wb_vld;
assign vpu_vlsu_fp_wb_data[FLEN-1:0]  = fpr_wb_data[FLEN-1:0];
assign vpu_vlsu_fp_wb_reg[4:0]        = fpr_wb_index[4:0];

assign vpu_vidu_wbt_fp_wb0_vld        = fpr_wbt_wb0_vld;
assign vpu_vidu_wbt_fp_wb0_reg[4:0]   = fpr_wb_index[4:0];
//=========================================================================
//      ONLY VFMAU DOUBLE REQUIRES EX5 INFORM
//=========================================================================
assign vpu_group_0_xx_ex5_stall = viq0_xx_ex5_stall || viq1_xx_ex5_stall;
assign vpu_group_0_xx_ex5_sel   = viq0_xx_ex5_vld;

assign vpu_rtu_no_op            = viq0_xx_no_op && viq1_xx_no_op && !vdivu_vpu_busy && !vfdsu_vpu_busy;

assign vpu_vidu_vex1_fp_stall   =  viq0_xx_ex1_stall || viq1_xx_ex1_stall || vlsu_xx_ex1_fp_stall;

// &Force("bus","viq0_xx_ex1_gp_sel",3,0); @524
// &Force("bus","viq0_xx_ex2_gp_sel",3,0); @525
// &Force("bus","viq0_xx_ex3_gp_sel",3,0); @526
// &Force("bus","vpu_group_3_xx_ex1_eu_sel",9,0); @527
// &Force("bus","viq0_xx_ex1_gp_sel",3,0); @553
// &Force("bus","vpu_group_3_xx_ex1_eu_sel",9,0); @554
assign vpu_vfdsu_ex1_sel          = vpu_group_3_xx_ex1_sel && vpu_group_3_xx_ex1_eu_sel == `EU_FDSU;

assign vpu_vlsu_ex1_lsu_inst_vld  = viq0_xx_ex1_lsu_inst_vld;

assign viq1_xx_no_op     = 1'b1;
assign vdivu_vpu_busy    = 1'b0;
assign viq1_xx_ex1_stall = 1'b0;
assign viq1_xx_ex1_srcv2_ready = 1'b0;
assign viq1_xx_ex1_vreg[VREG-1:0] = {VREG{1'b0}};


assign vpu_group_3_xx_ex1_srcv2_ready   = viq0_xx_ex1_gp_sel[3]
                                        ? viq0_xx_ex1_srcv2_ready :viq1_xx_ex1_srcv2_ready;

assign vpu_group_3_xx_ex1_vreg[VREG-1:0]= viq0_xx_ex1_gp_sel[3] 
                                        ? viq0_xx_ex1_vreg[VREG-1:0]:viq1_xx_ex1_vreg[VREG-1:0];
assign vidu_vpu_vid_vec0_inst_vld = 1'b0;
assign vidu_vpu_vid_vec1_inst_vld = 1'b0;
assign l_bank_wb_vld              = 1'b0;
assign h_bank_wb_vld              = 1'b0;
assign l_bank_wb_index[4:0]       = {5{1'b0}};
assign h_bank_wb_index[4:0]       = {5{1'b0}};

assign vpu_dtu_dbg_info[28:0] = { vidu_vpu_vid_fp_inst_vld,   //28
                                  vidu_vpu_vid_vec0_inst_vld, //27                                               
                                  vidu_vpu_vid_vec1_inst_vld, //26
                                  l_bank_wb_vld,              //25
                                  l_bank_wb_index[4:0],       //20-24
                                  h_bank_wb_vld,              //19
                                  h_bank_wb_index[4:0],       //14-18
                                  viq0_rbus_ex3_gpr_wb_req,   //13
                                  viq1_rbus_ex3_gpr_wb_req,   //12
                                  fpr_wb_vld,                 //11
                                  fpr_wb_index[4:0],          //6-10
                                  viq0_xx_no_op,              //5
                                  viq1_xx_no_op,              //4
                                  vdivu_vpu_busy,             //3
                                  vfdsu_vpu_busy,             //2
                                  viq0_xx_ex1_stall,          //1
                                  viq1_xx_ex1_stall};         //0
                                                                              

// &CombBeg; @651
// &CombEnd; @659
// &CombBeg; @669
// &CombEnd; @677
// &CombBeg; @692
// &CombEnd; @702

// &CombBeg; @779
// &CombEnd; @786
// &CombBeg; @788
// &CombEnd; @795
// &Force("input","vidu_vpu_vid_vec0_inst_eu"); @815
// &Force("input","vidu_vpu_vid_vec1_inst_eu"); @816
// &Force("input","viq0_xx_ex3_eu_sel"); @817
// &Force("input","viq1_xx_ex3_eu_sel"); @818
// &Force("input","viq0_xx_ex4_eu_sel"); @819
// &Force("input","viq1_xx_ex4_eu_sel"); @820
// &Force("nonport","vec0_vid_vint_inst"); @821
// &Force("nonport","vec1_vid_vint_inst"); @822
// &Force("nonport","vec0_ex3_vint_inst"); @823
// &Force("nonport","vec1_ex3_vint_inst"); @824
// &Force("nonport","vec0_ex4_vint_inst"); @825
// &Force("nonport","vec1_ex4_vint_inst"); @826
// &Force("nonport","l_bank_vint_wb_req"); @827
// &Force("nonport","h_bank_vint_wb_req"); @828
// &Force("nonport","viq0_wb_vint_req"); @829
// &Force("nonport","viq1_wb_vint_req"); @830
// &Force("nonport","l_bank_full_index"); @831
// &Force("nonport","h_bank_full_index"); @832
// &Force("nonport","after_warm_up"); @833
// &Force("nonport","flop_ifu_vpu_warm_up"); @834
// &ModuleEnd; @871
endmodule




