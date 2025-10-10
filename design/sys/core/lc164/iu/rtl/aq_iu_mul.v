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

// &ModuleBeg; @23
module aq_iu_mul (
  // &Ports, @24
  input    wire           cp0_iu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [5  :0]  idu_iu_ex1_dst_preg,
  input    wire  [19 :0]  idu_iu_ex1_func,
  input    wire           idu_iu_ex1_mult_dp_sel,
  input    wire           idu_iu_ex1_mult_sel,
  input    wire  [63 :0]  idu_iu_ex1_src0,
  input    wire  [63 :0]  idu_iu_ex1_src1,
  input    wire  [63 :0]  idu_iu_ex1_src2,
  input    wire  [31 :0]  idu_iu_ex1_inst,
  input    wire           idu_mult_ex1_gateclk_sel,
  input    wire           ifu_iu_warm_up,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_iu_mul_wb_grant,
  input    wire           rtu_iu_mul_wb_grant_for_full,
  input    wire           rtu_yy_xx_flush_fe,
  output   wire           iu_idu_mult_full,
  output   wire           iu_idu_mult_issue_stall,
  output   wire           iu_rtu_ex1_mul_cmplt,
  output   wire           iu_rtu_ex1_mul_cmplt_dp,
  output   reg	 [63 :0]  iu_rtu_ex3_mul_data,
  output   wire  [5  :0]  iu_rtu_ex3_mul_preg,
  output   wire           iu_rtu_ex3_mul_wb_vld,
  output   wire           mul_ctrl_no_op,
  output   wire  [1  :0]  mul_dbginfo
); 


// &Regs; @27
reg     [5  :0]  mult_ex1_dst_preg;                  
reg              mult_ex1_inst_vld;                  
reg     [64 :0]  mult_ex1_pipedown_src2;             
reg     [1  :0]  mult_ex1_rslt_sel;                  
reg     [64 :0]  mult_ex1_src0;                      
reg     [64 :0]  mult_ex1_src1;                      
reg     [64 :0]  mult_ex1_src2;                      
reg              mult_ex1_src2_ex2_sel_ex3;          
reg              mult_ex1_src2_h;                    
reg     [5  :0]  mult_ex2_dst_preg;                  
reg              mult_ex2_inst_vld;                  
reg     [4  :0]  mult_ex2_inst_vld_dup;              
reg     [1  :0]  mult_ex2_rslt_sel;                  
reg     [64 :0]  mult_ex2_src2;                      
reg              mult_ex2_src2_ex2_sel_ex3;          
reg     [5  :0]  mult_ex3_dst_preg;                  
reg              mult_ex3_inst_vld;  
reg     [1  :0]  mult_ex3_rslt_sel;                  
reg     [5  :0]  mult_ex4_dst_preg;                  
reg              mult_ex4_inst_vld;                  
reg     [127:0]  mult_ex4_result;                    
reg     [1  :0]  mult_ex4_rslt_sel;  

// &Wires; @28
wire             ex1_inst_clk;                       
wire             ex1_inst_clk_en;                    
wire             ex2_inst_clk;                       
wire             ex2_inst_clk_en;                    
wire             ex3_inst_clk;                       
wire             ex3_inst_clk_en;                    
wire             ex4_inst_clk;                       
wire             ex4_inst_clk_en;                    
wire             mult_clk;                           
wire             mult_clk_en;                        
wire             mult_ex1_src2_ex1_sel_ex1;          
wire    [64 :0]  mult_ex2_src2_data;                 
wire    [64 :0]  mult_ex2_src2_fwd_data;             
wire    [64 :0]  mult_ex3_src2_fwd_data;             
wire    [64 :0]  mult_ex4_src2_fwd_data;             
wire    [129:0]  mult_multiplier_result;             
wire             mult_rf_mla_match_ex1;              
wire             mult_rf_mla_match_ex2;              
wire             mult_rf_mla_match_ex3;              
wire    [64 :0]  mult_rf_src0;                       
wire    [64 :0]  mult_rf_src1;                       
wire    [64 :0]  mult_rf_src2;                       
wire    [31 :0]  decd_op;

// &Depend("compressor_32.v"); @30
// &Depend("compressor_42.v"); @31
// &Depend("booth_code.v"); @32

//==========================================================
//                 RF/EX1 Pipeline Register
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign mult_clk_en = idu_mult_ex1_gateclk_sel
                     || mult_ex1_inst_vld
                     || mult_ex2_inst_vld
                     || mult_ex3_inst_vld
                     || mult_ex4_inst_vld;
// &Instance("gated_clk_cell", "x_mult_gated_clk"); @45
gated_clk_cell  x_mult_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (mult_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (mult_clk_en       ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @46
//          .external_en (1'b0), @47
//          .global_en   (cp0_yy_clk_en), @48
//          .module_en   (cp0_iu_icg_en), @49
//          .local_en    (mult_clk_en), @50
//          .clk_out     (mult_clk)); @51

assign ex1_inst_clk_en = idu_mult_ex1_gateclk_sel;
// &Instance("gated_clk_cell", "x_ex1_inst_gated_clk"); @54
gated_clk_cell  x_ex1_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @55
//          .external_en (1'b0), @56
//          .global_en   (cp0_yy_clk_en), @57
//          .module_en   (cp0_iu_icg_en), @58
//          .local_en    (ex1_inst_clk_en), @59
//          .clk_out     (ex1_inst_clk)); @60

assign ex2_inst_clk_en = mult_ex1_inst_vld;
// &Instance("gated_clk_cell", "x_ex2_inst_gated_clk"); @63
gated_clk_cell  x_ex2_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @64
//          .external_en (1'b0), @65
//          .global_en   (cp0_yy_clk_en), @66
//          .module_en   (cp0_iu_icg_en), @67
//          .local_en    (ex2_inst_clk_en), @68
//          .clk_out     (ex2_inst_clk)); @69

assign ex3_inst_clk_en = mult_ex2_inst_vld;
// &Instance("gated_clk_cell", "x_ex3_inst_gated_clk"); @72
gated_clk_cell  x_ex3_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex3_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex3_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @73
//          .external_en (1'b0), @74
//          .global_en   (cp0_yy_clk_en), @75
//          .module_en   (cp0_iu_icg_en), @76
//          .local_en    (ex3_inst_clk_en), @77
//          .clk_out     (ex3_inst_clk)); @78

assign ex4_inst_clk_en = mult_ex3_inst_vld;
// &Instance("gated_clk_cell", "x_ex4_inst_gated_clk"); @81
gated_clk_cell  x_ex4_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex4_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex4_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @82
//          .external_en (1'b0), @83
//          .global_en   (cp0_yy_clk_en), @84
//          .module_en   (cp0_iu_icg_en), @85
//          .local_en    (ex4_inst_clk_en), @86
//          .clk_out     (ex4_inst_clk)); @87

//----------------------------------------------------------
//               Pipe1 RF Operand Prepare
//----------------------------------------------------------
//mul    : rz = (rx * ry)[63:0]
//mulh   : rz = (rx * ry)[127:64]
//mulhu  : rz = (unsign_rx * unsign_ry)[127:64]
//mulhsu : rz = (rx * unsign_ry)[127:64]
//mulw   : rz = sign_extend(rx[31:0] * ry[31:0])[31:0]

assign  decd_op[31 :0] = idu_iu_ex1_inst;

assign  is_mul_w       = decd_op[31:15] == 17'b00000000000111000; //mul.w
assign  is_mulh_w      = decd_op[31:15] == 17'b00000000000111001; //mulh.w
assign  is_mulh_wu     = decd_op[31:15] == 17'b00000000000111010; //mulh.wu
assign  is_mul_d       = decd_op[31:15] == 17'b00000000000111011; //mul.d
assign  is_mulh_d      = decd_op[31:15] == 17'b00000000000111100; //mulh.d
assign  is_mulh_du     = decd_op[31:15] == 17'b00000000000111101; //mulh.du
assign  is_mulw_d_w    = decd_op[31:15] == 17'b00000000000111110; //mulw.d.w
assign  is_mulw_d_wu   = decd_op[31:15] == 17'b00000000000111111; //mulw.d.wu

// source oprand 0
assign mult_rf_src0[64]    = {1{is_mul_w    }} & idu_iu_ex1_src0[63] |
                             {1{is_mulh_w   }} & idu_iu_ex1_src0[31] |
                             {1{is_mulh_wu  }} & 1'b0 |
                             {1{is_mulw_d_w }} & idu_iu_ex1_src0[31] |
                             {1{is_mulw_d_wu}} & 1'b0 |
                             {1{is_mul_d    }} & idu_iu_ex1_src0[63] |
                             {1{is_mulh_d   }} & idu_iu_ex1_src0[63] |
                             {1{is_mulh_du  }} & 1'b0;
assign mult_rf_src0[63:32] = 
                            {32{is_mul_w    }} & 32'b0 |
                            {32{is_mulh_w   }} & {32{idu_iu_ex1_src0[31]}} |
                            {32{is_mulh_wu  }} & 32'b0 |
                            {32{is_mulw_d_w }} & {32{idu_iu_ex1_src0[31]}} |
                            {32{is_mulw_d_wu}} & 32'b0 |
                            {32{is_mul_d    }} & idu_iu_ex1_src0[63:32] |
                            {32{is_mulh_d   }} & idu_iu_ex1_src0[63:32] |
                            {32{is_mulh_du  }} & idu_iu_ex1_src0[63:32];

assign mult_rf_src0[31:0]  = idu_iu_ex1_src0[31:0];


// source oprand 1
assign mult_rf_src1[64]    = {1{is_mul_w    }} & idu_iu_ex1_src1[63] |
                             {1{is_mulh_w   }} & idu_iu_ex1_src1[31] |
                             {1{is_mulh_wu  }} & 1'b0 |
                             {1{is_mulw_d_w }} & idu_iu_ex1_src1[31] |
                             {1{is_mulw_d_wu}} & 1'b0 |
                             {1{is_mul_d    }} & idu_iu_ex1_src1[63] |
                             {1{is_mulh_d   }} & idu_iu_ex1_src1[63] |
                             {1{is_mulh_du  }} & 1'b0;

assign mult_rf_src1[63:32] = {32{is_mul_w    }} & 32'b0 |
                             {32{is_mulh_w   }} & {32{idu_iu_ex1_src1[31]}} |
                             {32{is_mulh_wu  }} & 32'b0 |
                             {32{is_mulw_d_w }} & {32{idu_iu_ex1_src1[31]}} |
                             {32{is_mulw_d_wu}} & 32'b0 |
                             {32{is_mul_d    }} & idu_iu_ex1_src1[63:32] |
                             {32{is_mulh_d   }} & idu_iu_ex1_src1[63:32] |
                             {32{is_mulh_du  }} & idu_iu_ex1_src1[63:32];

assign mult_rf_src1[31:0]  = idu_iu_ex1_src1[31:0];


assign mult_rf_src2[64:32] = 33'b0;
assign mult_rf_src2[31:0]  = 32'b0;


wire [1:0] idu_mult_func_sel = {2{is_mul_w    }} & 2'b10 |
                               {2{is_mulh_w   }} & 2'b11 |
                               {2{is_mulh_wu  }} & 2'b11 |
                               {2{is_mulw_d_w }} & 2'b00 |
                               {2{is_mulw_d_wu}} & 2'b00 |
                               {2{is_mul_d    }} & 2'b00 |
                               {2{is_mulh_d   }} & 2'b01 |
                               {2{is_mulh_du  }} & 2'b01;


//----------------------------------------------------------
//               Indicate Internal Forward
//----------------------------------------------------------
assign mult_rf_mla_match_ex1 = 1'b0;
assign mult_rf_mla_match_ex2 = 1'b0;
assign mult_rf_mla_match_ex3 = 1'b0;

//----------------------------------------------------------
//              Pipe1 EX1 Instruction valid
//----------------------------------------------------------
always @(posedge mult_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mult_ex1_inst_vld <= 1'b0;
  else if(rtu_yy_xx_flush_fe)
    mult_ex1_inst_vld <= 1'b0;
  else
    mult_ex1_inst_vld <= idu_iu_ex1_mult_sel;
end

//stop issue alu inst
assign iu_idu_mult_issue_stall        = !mul_ctrl_no_op;

// TODO: if we have one better?
assign iu_idu_mult_full               = !mul_ctrl_no_op;

//----------------------------------------------------------
//               Pipe1 EX1 Instruction Data
//----------------------------------------------------------
always @(posedge ex1_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    mult_ex1_dst_preg[5:0]        <= 6'b0;
    mult_ex1_rslt_sel[1:0]        <= 2'b0;
    mult_ex1_src0[64:0]           <= 65'b0;
    mult_ex1_src1[64:0]           <= 65'b0;
    mult_ex1_src2[64:0]           <= 65'b0;
  end
  else if(idu_mult_ex1_gateclk_sel) begin
    mult_ex1_dst_preg[5:0]        <= idu_iu_ex1_dst_preg[5:0];
    mult_ex1_rslt_sel[1:0]        <= idu_mult_func_sel[1:0];
    mult_ex1_src0[64:0]           <= mult_rf_src0[64:0];
    mult_ex1_src1[64:0]           <= mult_rf_src1[64:0];
    mult_ex1_src2[64:0]           <= mult_rf_src2[64:0];
  end
  else begin
    mult_ex1_dst_preg[5:0]        <= mult_ex1_dst_preg[5:0];
    mult_ex1_rslt_sel[1:0]        <= mult_ex1_rslt_sel[1:0];
    mult_ex1_src0[64:0]           <= mult_ex1_src0[64:0];
    mult_ex1_src1[64:0]           <= mult_ex1_src1[64:0];
    mult_ex1_src2[64:0]           <= mult_ex1_src2[64:0];
  end
end

//----------------------------------------------------------
//               Pipe1 EX1 Internal Forward
//----------------------------------------------------------

//----------------------------------------------------------
//              Pipe1 EX2 Instruction valid
//----------------------------------------------------------
always @(posedge mult_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    mult_ex2_inst_vld          <= 1'b0;
    mult_ex2_inst_vld_dup[4:0] <= 5'b0;
  end
  else if(rtu_yy_xx_flush_fe) begin
    mult_ex2_inst_vld          <= 1'b0;
    mult_ex2_inst_vld_dup[4:0] <= 5'b0;
  end
  else begin
    mult_ex2_inst_vld          <= mult_ex1_inst_vld;
    mult_ex2_inst_vld_dup[4:0] <= {5{mult_ex1_inst_vld}};
  end
end

//----------------------------------------------------------
//               Pipe1 EX2 Instruction Data
//----------------------------------------------------------
always @(posedge ex2_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    mult_ex2_dst_preg[5:0]        <= 6'b0;
    mult_ex2_rslt_sel[1:0]        <= 2'b0;
    mult_ex2_src2[64:0]           <= 65'b0;
  end
  else if(mult_ex1_inst_vld) begin
    mult_ex2_dst_preg[5:0]        <= mult_ex1_dst_preg[5:0];
    mult_ex2_rslt_sel[1:0]        <= mult_ex1_rslt_sel[1:0];
    mult_ex2_src2[64:0]           <= mult_ex1_pipedown_src2[64:0];
  end
  else begin
    mult_ex2_dst_preg[5:0]        <= mult_ex2_dst_preg[5:0];
    mult_ex2_rslt_sel[1:0]        <= mult_ex2_rslt_sel[1:0];
    mult_ex2_src2[64:0]           <= mult_ex2_src2[64:0];
  end
end

//----------------------------------------------------------
//               Pipe1 EX2 Internal Forward
//----------------------------------------------------------
assign mult_ex2_src2_fwd_data[64:0] =  mult_ex2_src2[64:0];

assign mult_ex2_src2_data[64:32]    = 33'b0;
assign mult_ex2_src2_data[31:0]     = 32'b0;

//----------------------------------------------------------
//              Pipe1 EX3 Instruction valid
//----------------------------------------------------------
always @(posedge mult_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mult_ex3_inst_vld <= 1'b0;
  else if(rtu_yy_xx_flush_fe)
    mult_ex3_inst_vld <= 1'b0;
  else
    mult_ex3_inst_vld <= mult_ex2_inst_vld;
end

//----------------------------------------------------------
//               Pipe1 EX3 Instruction Data
//----------------------------------------------------------
always @(posedge ex3_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    mult_ex3_dst_preg[5:0]        <= 6'b0;
    mult_ex3_rslt_sel[1:0]        <= 2'b0;
  end
  else if(mult_ex2_inst_vld) begin
    mult_ex3_dst_preg[5:0]        <= mult_ex2_dst_preg[5:0];
    mult_ex3_rslt_sel[1:0]        <= mult_ex2_rslt_sel[1:0];
  end
  else begin
    mult_ex3_dst_preg[5:0]        <= mult_ex3_dst_preg[5:0];
    mult_ex3_rslt_sel[1:0]        <= mult_ex3_rslt_sel[1:0];
  end
end

//----------------------------------------------------------
//              Pipe1 EX4 Instruction valid
//----------------------------------------------------------
always @(posedge mult_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    mult_ex4_inst_vld <= 1'b0;
  else if(rtu_yy_xx_flush_fe)
    mult_ex4_inst_vld <= 1'b0;
  else
    mult_ex4_inst_vld <= mult_ex3_inst_vld;
end

assign iu_rtu_ex3_mul_wb_vld = mult_ex4_inst_vld;

//----------------------------------------------------------
//               Pipe1 EX4 Instruction Data
//----------------------------------------------------------
always @(posedge ex4_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    mult_ex4_dst_preg[5:0]        <= 6'b0;
    mult_ex4_rslt_sel[1:0]        <= 2'b0;
  end
  else if(mult_ex3_inst_vld) begin
    mult_ex4_dst_preg[5:0]        <= mult_ex3_dst_preg[5:0];
    mult_ex4_rslt_sel[1:0]        <= mult_ex3_rslt_sel[1:0];
  end
  else begin
    mult_ex4_dst_preg[5:0]        <= mult_ex4_dst_preg[5:0];
    mult_ex4_rslt_sel[1:0]        <= mult_ex4_rslt_sel[1:0];
  end
end

//----------------------------------------------------------
//               Pipe1 EX4 Instruction Data
//----------------------------------------------------------
always @(posedge ex4_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    mult_ex4_result[127:0]        <= 128'b0;
  end
  else if(mult_ex3_inst_vld) begin
    mult_ex4_result[127:0]        <= mult_multiplier_result[127:0];
  end
  else begin
    mult_ex4_result[127:0]        <= mult_ex4_result[127:0];
  end
end

assign mult_ex4_src2_fwd_data[64:0] = {mult_ex4_result[63],
                                       mult_ex4_result[63:0]};

//==========================================================
//           EX1~EX3 Design Ware 65x65 multiplier
//    this multiplier cross from ex1 stage to ex3 stage
//==========================================================
// &Force("nonport", "mult_multiplier_result"); @410
// &Force("bus","mult_multiplier_result",129,0); @411

// &Instance("multiplier_65x65_3_stage", "x_ct_iu_mult_multiplier_65x65_3_stage"); @413
multiplier_65x65_3_stage  x_ct_iu_mult_multiplier_65x65_3_stage (
  .addend                        (mult_ex2_src2_data[64:0]     ),
  .cpurst_b                      (cpurst_b                     ),
  .multiplicand                  (mult_ex1_src0[64:0]          ),
  .multiplier                    (mult_ex1_src1[64:0]          ),
  .pipe1_clk                     (ex2_inst_clk                 ),
  .pipe1_down                    (mult_ex1_inst_vld            ),
  .pipe2_clk                     (ex3_inst_clk                 ),
  .pipe2_down                    (mult_ex2_inst_vld            ),
  .product                       (mult_multiplier_result[129:0]),
  .sub_vld                       (1'b0												 )
);

// &Connect(.pipe1_clk    (ex2_inst_clk), @414
//          .pipe2_clk    (ex3_inst_clk), @415
//          .pipe1_down   (mult_ex1_inst_vld), @416
//          .pipe2_down   (mult_ex2_inst_vld), @417
//          .sub_vld      (mult_ex1_sub), @418
//          .multiplicand (mult_ex1_src0[64:0]), @419
//          .multiplier   (mult_ex1_src1[64:0]), @420
//          .addend       (mult_ex2_src2_data[64:0]), @421
//          .product      (mult_multiplier_result[129:0]) @422
//         ); @423

assign mult_ex3_src2_fwd_data[64:0] = {mult_multiplier_result[63],
                                       mult_multiplier_result[63:0]};

//==========================================================
//                 EX4 Result Selection
//==========================================================
// &CombBeg; @431
always @( mult_ex4_result[127:0]
       or mult_ex4_result[31:0]
       or mult_ex4_rslt_sel[1:0])
begin
  case (mult_ex4_rslt_sel[1:0])
    2'b00  : iu_rtu_ex3_mul_data[63:0] = mult_ex4_result[63:0];
    2'b01  : iu_rtu_ex3_mul_data[63:0] = mult_ex4_result[127:64];
    2'b10  : iu_rtu_ex3_mul_data[63:0] = {{32{mult_ex4_result[31]}},
                                             mult_ex4_result[31:0]};
    2'b11  : iu_rtu_ex3_mul_data[63:0] = {{32{mult_ex4_result[63]}},
                                             mult_ex4_result[63:32]};                                         
  endcase
// &CombEnd; @439
end

assign iu_rtu_ex3_mul_preg[5:0] = mult_ex4_dst_preg[5:0];

assign mul_ctrl_no_op = !(mult_ex4_inst_vld 
                          || mult_ex3_inst_vld 
                          || mult_ex2_inst_vld 
                          || mult_ex1_inst_vld);


// 
// Bugs: when exception raise, *iu_rtu_ex1_mul_cmplt* has become
//       effective, but signal *mult_ex1_inst_vld* has been invalidated
//       by *rtu_yy_xx_flush_fe*.
// 

// assign iu_rtu_ex1_mul_cmplt    = mult_ex1_inst_vld;
// assign iu_rtu_ex1_mul_cmplt_dp = idu_iu_ex1_mult_dp_sel;

assign iu_rtu_ex1_mul_cmplt    = mult_ex4_inst_vld;
assign iu_rtu_ex1_mul_cmplt_dp = mult_ex4_inst_vld;

// &ModuleEnd; @481
endmodule


