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

module aq_vfmau_dp (
  input    wire          cp0_vpu_icg_en,
  input    wire          cp0_vpu_xx_bf16,
  input    wire          cp0_vpu_xx_dqnan,
  input    wire          cp0_yy_clk_en,
  input    wire          ctrl_dp_ex1_inst_pipe_down,
  input    wire          ctrl_dp_ex1_inst_vld,
  input    wire          ctrl_dp_ex2_inst_pipe_down,
  input    wire          ctrl_dp_ex2_inst_vld,
  input    wire          ctrl_dp_ex3_inst_pipe_down,
  input    wire          ctrl_dp_ex3_inst_vld,
  input    wire          ctrl_dp_ex4_inst_pipe_down,
  input    wire          ctrl_dp_ex4_inst_vld,
  input    wire          forever_cpuclk,
  input    wire          ifu_vpu_warm_up,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [19:0]  vpu_group_0_xx_ex1_func,
  input    wire  [1 :0]  vpu_group_0_xx_ex1_id_reg,
  input    wire  [2 :0]  vpu_group_0_xx_ex1_rm,
  input    wire  [63:0]  vpu_group_0_xx_ex1_srcv0,
  input    wire  [47:0]  vpu_group_0_xx_ex1_srcv0_type,
  input    wire  [63:0]  vpu_group_0_xx_ex1_srcv1,
  input    wire  [47:0]  vpu_group_0_xx_ex1_srcv1_type,
  input    wire  [63:0]  vpu_group_0_xx_ex1_srcv2,
  input    wire  [47:0]  vpu_group_0_xx_ex1_srcv2_type,
  output   wire          ex2_dst_double,
  output   reg           ex2_mac,
  output   wire          ex2_simd,
  output   wire  [5 :0]  ex2_special_sel,
  output   wire          ex3_dst_double,
  output   reg           ex3_mac,
  output   wire          ex3_special_cmplt,
  output   wire          ex4_dst_double,
  output   reg           ex4_mac,
  output   wire  [4 :0]  vfmau_vpu_ex3_fflags,
  output   wire  [63:0]  vfmau_vpu_ex3_fpr_result,
  output   wire  [4 :0]  vfmau_vpu_ex4_fflags,
  output   wire  [63:0]  vfmau_vpu_ex4_fpr_result,
  output   wire  [4 :0]  vfmau_vpu_ex5_fflags,
  output   wire  [63:0]  vfmau_vpu_ex5_fpr_result
); 


parameter DATA_WIDTH   = 64;

parameter DOUBLE_WIDTH = 64;
parameter DOUBLE_FRAC  = 52;
parameter DOUBLE_EXPN  = 11;

parameter SINGLE_WIDTH = 32;
parameter SINGLE_FRAC  = 23;
parameter SINGLE_EXPN  =  8;

parameter FUNC_WIDTH   = 20;

reg             ex2_bf16;
reg             ex2_double;                            
reg             ex2_f16;                      
reg             ex2_half; 
reg     [2 :0]  ex2_rm;                       
reg             ex2_single;                   
reg             ex3_bf16;                     
reg             ex3_double;                   
reg             ex3_f16;                      
reg             ex3_half;                     
reg     [2 :0]  ex3_rm;                       
reg             ex3_single;                   
reg             ex4_bf16;                     
reg             ex4_double;                   
reg             ex4_f16;                      
reg             ex4_half;                     
reg     [2 :0]  ex4_rm;                       
reg             ex4_single;                   

wire            ex1_bf16;                     
wire            ex1_double;                   
wire            ex1_double_expnt_near_of;     
wire            ex1_double_expnt_near_uf;     
wire            ex1_dst_bf16;                 
wire            ex1_dst_double;               
wire            ex1_dst_f16;                  
wire            ex1_dst_half;                 
wire            ex1_dst_single;               
wire            ex1_f16;                      
wire    [19:0]  ex1_func;                     
wire            ex1_half;                     
wire    [1 :0]  ex1_id_reg;                   
wire            ex1_mac;                      
wire            ex1_mac_update;               
wire            ex1_neg;                 
wire            ex1_scaleb;     
wire    [2 :0]  ex1_rm;                       
wire            ex1_single;                   
wire    [63:0]  ex1_srcv0;                    
wire    [63:0]  ex1_srcv1;                    
wire    [63:0]  ex1_srcv2;            
wire [DATA_WIDTH-1:0] scaleb_srcv1;
wire [DOUBLE_EXPN-1:0]  scaleb_doub_exp;
wire [SINGLE_EXPN-1:0]  scaleb_sing_exp;        
wire            ex1_sub;                      
wire            ex1_widen;                    
wire            ex2_dst_bf16;                 
wire            ex2_dst_f16;                  
wire            ex2_dst_half;                 
wire            ex2_dst_single;               
wire            ex2_widen;                    
wire            ex3_dst_bf16;                 
wire            ex3_dst_f16;                  
wire            ex3_dst_single;               
wire            ex3_simd;                     
wire            ex3_widen;                    
wire            ex4_dst_bf16;                 
wire            ex4_dst_f16;                  
wire            ex4_dst_half;                 
wire            ex4_dst_single;               
wire            ex4_widen;                    
wire            fmau_ex2_data_clk;            
wire            fmau_ex2_data_clk_en;         
wire            fmau_ex3_data_clk;            
wire            fmau_ex3_data_clk_en;         
wire            fmau_ex4_data_clk;            
wire            fmau_ex4_data_clk_en;         
wire            fmau_ex5_data_clk;            
wire            fmau_ex5_data_clk_en;         


aq_vfmau_mult  x_aq_vfmau_mult (
  .cp0_vpu_xx_dqnan              (cp0_vpu_xx_dqnan             ),
  .ctrl_dp_ex1_inst_pipe_down    (ctrl_dp_ex1_inst_pipe_down   ),
  .ctrl_dp_ex2_inst_pipe_down    (ctrl_dp_ex2_inst_pipe_down   ),
  .ctrl_dp_ex3_inst_pipe_down    (ctrl_dp_ex3_inst_pipe_down   ),
  .ctrl_dp_ex4_inst_pipe_down    (ctrl_dp_ex4_inst_pipe_down   ),
  .ex1_bf16                      (ex1_bf16                     ),
  .ex1_double                    (ex1_double                   ),
  .ex1_double_expnt_near_of      (ex1_double_expnt_near_of     ),
  .ex1_double_expnt_near_uf      (ex1_double_expnt_near_uf     ),
  .ex1_dst_bf16                  (ex1_dst_bf16                 ),
  .ex1_dst_double                (ex1_dst_double               ),
  .ex1_dst_f16                   (ex1_dst_f16                  ),
  .ex1_dst_half                  (ex1_dst_half                 ),
  .ex1_dst_single                (ex1_dst_single               ),
  .ex1_f16                       (ex1_f16                      ),
  .ex1_half                      (ex1_half                     ),
  .ex1_id_reg                    (ex1_id_reg                   ),
  .ex1_mac                       (ex1_mac                      ),
  .ex1_neg                       (ex1_neg                      ),
  .ex1_rm                        (ex1_rm                       ),
  .ex1_single                    (ex1_single                   ),
  .ex1_srcv0                     (ex1_srcv0                    ),
  .ex1_srcv1                     (ex1_srcv1                    ),
  .ex1_srcv2                     (ex1_srcv2                    ),
  .ex1_sub                       (ex1_sub                      ),
  .ex1_widen                     (ex1_widen                    ),
  .ex2_bf16                      (ex2_bf16                     ),
  .ex2_double                    (ex2_double                   ),
  .ex2_dst_bf16                  (ex2_dst_bf16                 ),
  .ex2_dst_double                (ex2_dst_double               ),
  .ex2_dst_f16                   (ex2_dst_f16                  ),
  .ex2_dst_half                  (ex2_dst_half                 ),
  .ex2_dst_single                (ex2_dst_single               ),
  .ex2_mac                       (ex2_mac                      ),
  .ex2_single                    (ex2_single                   ),
  .ex2_special_sel               (ex2_special_sel              ),
  .ex3_bf16                      (ex3_bf16                     ),
  .ex3_dst_bf16                  (ex3_dst_bf16                 ),
  .ex3_dst_double                (ex3_dst_double               ),
  .ex3_dst_f16                   (ex3_dst_f16                  ),
  .ex3_dst_single                (ex3_dst_single               ),
  .ex3_f16                       (ex3_f16                      ),
  .ex3_rm                        (ex3_rm                       ),
  .ex3_simd                      (ex3_simd                     ),
  .ex3_single                    (ex3_single                   ),
  .ex3_special_cmplt             (ex3_special_cmplt            ),
  .ex4_bf16                      (ex4_bf16                     ),
  .ex4_dst_bf16                  (ex4_dst_bf16                 ),
  .ex4_dst_double                (ex4_dst_double               ),
  .ex4_dst_f16                   (ex4_dst_f16                  ),
  .ex4_dst_half                  (ex4_dst_half                 ),
  .ex4_dst_single                (ex4_dst_single               ),
  .ex4_f16                       (ex4_f16                      ),
  .ex4_rm                        (ex4_rm                       ),
  .ex4_single                    (ex4_single                   ),
  .fmau_ex2_data_clk             (fmau_ex2_data_clk            ),
  .fmau_ex3_data_clk             (fmau_ex3_data_clk            ),
  .fmau_ex4_data_clk             (fmau_ex4_data_clk            ),
  .fmau_ex5_data_clk             (fmau_ex5_data_clk            ),
  .ifu_vpu_warm_up               (ifu_vpu_warm_up              ),
  .vfmau_vpu_ex3_fflags          (vfmau_vpu_ex3_fflags         ),
  .vfmau_vpu_ex3_fpr_result      (vfmau_vpu_ex3_fpr_result     ),
  .vfmau_vpu_ex4_fflags          (vfmau_vpu_ex4_fflags         ),
  .vfmau_vpu_ex4_fpr_result      (vfmau_vpu_ex4_fpr_result     ),
  .vfmau_vpu_ex5_fflags          (vfmau_vpu_ex5_fflags         ),
  .vfmau_vpu_ex5_fpr_result      (vfmau_vpu_ex5_fpr_result     ),
  .vpu_group_0_xx_ex1_srcv0_type (vpu_group_0_xx_ex1_srcv0_type),
  .vpu_group_0_xx_ex1_srcv1_type (vpu_group_0_xx_ex1_srcv1_type & {20{~ex1_scaleb}}),
  .vpu_group_0_xx_ex1_srcv2_type (vpu_group_0_xx_ex1_srcv2_type)
);


//==========================================================
//                     EX1 Interface
//==========================================================
assign ex1_func[8:0] = {vpu_group_0_xx_ex1_func[19:16], vpu_group_0_xx_ex1_func[4:0]};

//function decode
assign ex1_double               = ex1_func[5];
assign ex1_single               = ex1_func[6];
assign ex1_half                 = 1'b0;
assign ex1_bf16                 = 1'b0;
assign ex1_f16                  = 1'b0;
assign ex1_neg                  = ex1_func[2];
assign ex1_sub                  = ex1_func[1];
assign ex1_mac                  = ex1_func[0];
assign ex1_scaleb               = vpu_group_0_xx_ex1_func[5];
assign ex1_rm[2:0]              = vpu_group_0_xx_ex1_rm[2:0];
assign ex1_id_reg[1:0]          = vpu_group_0_xx_ex1_id_reg[1:0] & {~ex1_scaleb, 1'b1};
assign ex1_widen                = 1'b0;
assign ex1_dst_bf16             = 1'b0;
assign ex1_dst_f16              = 1'b0;
assign ex1_dst_half             = 1'b0;
assign ex1_dst_single = (ex1_widen) ? ex1_half   : ex1_single;
assign ex1_dst_double = (ex1_widen) ? ex1_single : ex1_double;


//==========================================================
//                     EX1 Srcvx path
//==========================================================

assign scaleb_doub_exp = vpu_group_0_xx_ex1_srcv1[10:0] + 11'h3ff;
assign scaleb_sing_exp = vpu_group_0_xx_ex1_srcv1[7:0] + 8'h7f;

assign scaleb_srcv1 = ex1_double ? {1'b0, scaleb_doub_exp, 52'b0} : 
                              {32'hffffffff, 1'b0, scaleb_sing_exp[7:0], 23'b0};

assign ex1_srcv0[DATA_WIDTH-1:0] = vpu_group_0_xx_ex1_srcv0[DATA_WIDTH-1:0];
assign ex1_srcv1[DATA_WIDTH-1:0] = ex1_scaleb ? scaleb_srcv1 : vpu_group_0_xx_ex1_srcv1[DATA_WIDTH-1:0];
assign ex1_srcv2[DATA_WIDTH-1:0] = (ex1_mac) ? vpu_group_0_xx_ex1_srcv2[DATA_WIDTH-1:0]
                                             : {DATA_WIDTH{1'b0}};

//==========================================================
//                     EX1 Fraction data path
//==========================================================
assign ex1_mac_update    = ex1_mac || |ex1_id_reg[1:0] || ex1_double_expnt_near_uf || ex1_double_expnt_near_of;
//==========================================================
//                    EX2 Stage
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign fmau_ex2_data_clk_en = ctrl_dp_ex1_inst_vld || ifu_vpu_warm_up;

gated_clk_cell  x_fmau_ex2_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex2_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex2_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

always @(posedge fmau_ex2_data_clk)
begin
 if(ctrl_dp_ex1_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex2_f16       <= ex1_f16;
    ex2_bf16      <= ex1_bf16;
    ex2_half      <= ex1_half;
    ex2_single    <= ex1_single;
    ex2_double    <= ex1_double;
    ex2_rm[2:0]   <= ex1_rm[2:0]; 
    ex2_mac       <= ex1_mac_update;
  end
end

assign ex2_widen      = 1'b0;
assign ex2_simd       = 1'b0;
assign ex2_dst_f16    = ex2_f16 && !ex2_widen;
assign ex2_dst_bf16   = ex2_bf16 && !ex2_widen;
assign ex2_dst_half   = ex2_half && !ex2_widen;
assign ex2_dst_single = (ex2_widen) ? ex2_half   : ex2_single;
assign ex2_dst_double = (ex2_widen) ? ex2_single : ex2_double;

//==========================================================
//                    EX3  Stage
//==========================================================
assign fmau_ex3_data_clk_en = ctrl_dp_ex2_inst_vld || ifu_vpu_warm_up;

gated_clk_cell  x_fmau_ex3_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex3_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex3_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);

always @(posedge fmau_ex3_data_clk)
begin
 if(ctrl_dp_ex2_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex3_f16                   <= ex2_f16;
    ex3_bf16                  <= ex2_bf16;
    ex3_half                  <= ex2_half;
    ex3_single                <= ex2_single;
    ex3_double                <= ex2_double;
    ex3_mac                   <= ex2_mac;
    ex3_rm[2:0]               <= ex2_rm[2:0];
  end
end

assign ex3_widen      = 1'b0;
assign ex3_simd       = 1'b0;
assign ex3_dst_bf16   = ex3_bf16 && !ex3_widen;
assign ex3_dst_f16    = ex3_f16  && !ex3_widen;
assign ex3_dst_single = (ex3_widen) ? ex3_half   : ex3_single;
assign ex3_dst_double = (ex3_widen) ? ex3_single : ex3_double;

//==========================================================
//                    EX4  Stage
//==========================================================
assign fmau_ex4_data_clk_en = ctrl_dp_ex3_inst_vld || ifu_vpu_warm_up;

gated_clk_cell  x_fmau_ex4_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex4_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex4_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


always @(posedge fmau_ex4_data_clk)
begin
 if(ctrl_dp_ex3_inst_pipe_down || ifu_vpu_warm_up) 
 begin
    ex4_f16                   <= ex3_f16;
    ex4_bf16                  <= ex3_bf16;
    ex4_half                  <= ex3_half;
    ex4_single                <= ex3_single;
    ex4_double                <= ex3_double;
    ex4_mac                   <= ex3_mac;
    ex4_rm[2:0]               <= ex3_rm[2:0];
  end
end

assign ex4_widen      = 1'b0;
assign ex4_dst_bf16   = ex4_bf16 && !ex4_widen;
assign ex4_dst_f16    = ex4_f16  && !ex4_widen;
assign ex4_dst_half   = ex4_half && !ex4_widen;
assign ex4_dst_single = (ex4_widen) ? ex4_half   : ex4_single;
assign ex4_dst_double = (ex4_widen) ? ex4_single : ex4_double;


assign fmau_ex5_data_clk_en = ctrl_dp_ex4_inst_vld || ifu_vpu_warm_up;

gated_clk_cell  x_fmau_ex5_data_gated_clk (
  .clk_in               (forever_cpuclk      ),
  .clk_out              (fmau_ex5_data_clk   ),
  .external_en          (1'b0                ),
  .global_en            (cp0_yy_clk_en       ),
  .local_en             (fmau_ex5_data_clk_en),
  .module_en            (cp0_vpu_icg_en      ),
  .pad_yy_icg_scan_en   (pad_yy_icg_scan_en  )
);


endmodule



