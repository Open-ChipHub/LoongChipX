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

// &Depend("cpu_cfig.h"); @22
// &ModuleBeg; @23
module ct_vfdsu_scalar_dp (
  // &Ports, @24
  input    wire          cp0_vfpu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [4 :0]  dp_vfdsu_ex1_pipex_dst_ereg,
  input    wire  [6 :0]  dp_vfdsu_ex1_pipex_dst_vreg,
  input    wire  [6 :0]  dp_vfdsu_ex1_pipex_iid,
  input    wire  [2 :0]  dp_vfdsu_ex1_pipex_imm0,
  input    wire  [63:0]  dp_vfdsu_ex1_pipex_srcf0,
  input    wire  [63:0]  dp_vfdsu_ex1_pipex_srcf1,
  input    wire          ex1_data_clk,
  input    wire          ex1_pipedown,
  input    wire          ex2_data_clk,
  input    wire          ex2_pipedown,
  input    wire          ex3_data_clk,
  input    wire          ex3_pipedown,
  input    wire  [4 :0]  ex4_out_expt,
  input    wire  [63:0]  ex4_out_result,
  input    wire          forever_cpuclk,
  input    wire  [19:0]  idu_vfpu_rf_pipex_func,
  input    wire          idu_vfpu_rf_pipex_gateclk_sel,
  input    wire          pad_yy_icg_scan_en,
  output   reg           ex1_div,
  output   reg           ex1_double,
  output   wire          ex1_scalar,
  output   reg           ex1_single,
  output   reg           ex1_sqrt,
  output   wire  [63:0]  ex1_src0,
  output   wire  [63:0]  ex1_src1,
  output   wire  [2 :0]  ex1_static_rm,
  output   wire  [4 :0]  pipex_dp_vfdsu_ereg,
  output   wire  [4 :0]  pipex_dp_vfdsu_ereg_data,
  output   wire  [63:0]  pipex_dp_vfdsu_freg_data,
  output   wire  [6 :0]  pipex_dp_vfdsu_vreg,
  output   reg           vfdsu_ex2_double,
  output   reg           vfdsu_ex2_single
); 



// &Regs; @25
reg             vfdsu_ex2_div;                
reg     [4 :0]  vfdsu_ex2_dst_ereg;           
reg     [6 :0]  vfdsu_ex2_dst_vreg;           
reg     [6 :0]  vfdsu_ex2_iid;                
reg             vfdsu_ex2_sqrt;               
reg     [4 :0]  vfdsu_ex3_dst_ereg;           
reg     [6 :0]  vfdsu_ex3_dst_vreg;           
reg     [6 :0]  vfdsu_ex3_iid;                
reg     [4 :0]  vfdsu_ex4_dst_ereg;           
reg     [6 :0]  vfdsu_ex4_dst_vreg;           
reg     [6 :0]  vfdsu_ex4_iid;                

reg             ex1_recip;

// &Wires; @26
wire            vfdsu_sew_clk;                
wire            vfdsu_sew_clk_en;             


//==========================================================
//              EX1 Stage Control Signal
//==========================================================
// &Force("bus","idu_vfpu_rf_pipex_func",19,0); @31
//assign func[19:0]         = dp_vfdsu_ex1_pipex_func[19:0];
// &Instance("gated_clk_cell","x_vfdsu_sew_clk"); @33
gated_clk_cell  x_vfdsu_sew_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (vfdsu_sew_clk     ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (vfdsu_sew_clk_en  ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @34
//           .clk_out        (vfdsu_sew_clk),//Out Clock @35
//           .external_en    (1'b0), @36
//           .global_en      (cp0_yy_clk_en), @37
//           .local_en       (vfdsu_sew_clk_en),//Local Condition @38
//           .module_en      (cp0_vfpu_icg_en) @39
//         ); @40
assign  vfdsu_sew_clk_en = idu_vfpu_rf_pipex_gateclk_sel;       
always @(posedge vfdsu_sew_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    ex1_div            <= 1'b0;
    ex1_sqrt           <= 1'b0;
    ex1_recip          <= 1'b0;
    ex1_double         <= 1'b0;
    ex1_single         <= 1'b0;
  end
  else if(idu_vfpu_rf_pipex_gateclk_sel)
  begin
    ex1_div            <= idu_vfpu_rf_pipex_func[0];
    ex1_sqrt           <= idu_vfpu_rf_pipex_func[1];
    ex1_recip          <= idu_vfpu_rf_pipex_func[2];
    ex1_double         <= idu_vfpu_rf_pipex_func[16];
    ex1_single         <= idu_vfpu_rf_pipex_func[15];
  end
end
assign ex1_scalar         = 1'b1;
assign ex1_static_rm[2:0] = dp_vfdsu_ex1_pipex_imm0[2:0]; 
// &Force("output","ex1_div"); @61
// &Force("output","ex1_sqrt"); @62
// &Force("output","ex1_double"); @63
// &Force("output","ex1_single"); @64

// assign ex1_src0[63:0]    = dp_vfdsu_ex1_pipex_srcf0[63:0];
// assign ex1_src1[63:0]    = dp_vfdsu_ex1_pipex_srcf1[63:0];

//// 1.0 (single)
// 0 011_1111_1 000_0000_0000_0000_0000_0000
//   3    f    8   

//// 1.0 (double)
// 0 011_1111_1111 0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000_0000
//   3    f    f    

// wire is_arch_la = 1'b1;

// assign ex1_src0[63:0]    = ex1_recip ? 
//                              (ex1_single ? 64'hffffffff_3f800000 : 64'h3ff00000_00000000)
//                            : (is_arch_la && ex1_single) ? 
//                                  {32'hffffffff, dp_vfdsu_ex1_pipex_srcf0[63:0]}
//                                : dp_vfdsu_ex1_pipex_srcf0[63:0];
// assign ex1_src1[63:0]    = ex1_recip ?
//                              (is_arch_la && ex1_single) ? 
//                                  {32'hffffffff, dp_vfdsu_ex1_pipex_srcf0[63:0]}
//                                : dp_vfdsu_ex1_pipex_srcf0[63:0]
//                            : (is_arch_la && ex1_single) ? 
//                                  {32'hffffffff, dp_vfdsu_ex1_pipex_srcf1[63:0]}
//                                : dp_vfdsu_ex1_pipex_srcf1[63:0];

assign ex1_src0[63:0]    = ex1_recip ? 
                             (ex1_double ? 64'h3ff00000_00000000 
                                         : 64'hffffffff_3f800000)
                           : dp_vfdsu_ex1_pipex_srcf0[63:0];
assign ex1_src1[63:0]    = ex1_recip ?
                             dp_vfdsu_ex1_pipex_srcf0[63:0]
                           : dp_vfdsu_ex1_pipex_srcf1[63:0];


always @(posedge ex1_data_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    vfdsu_ex2_dst_ereg[4:0] <= 5'b0;
    vfdsu_ex2_dst_vreg[6:0] <= 7'b0;
    vfdsu_ex2_iid[6:0]      <= 7'b0;
    vfdsu_ex2_double        <= 1'b0;
    vfdsu_ex2_single        <= 1'b0;
    vfdsu_ex2_div           <= 1'b0;
    vfdsu_ex2_sqrt          <= 1'b0;
  end
  else if(ex1_pipedown)
  begin
    vfdsu_ex2_dst_ereg[4:0] <= dp_vfdsu_ex1_pipex_dst_ereg[4:0];
    vfdsu_ex2_dst_vreg[6:0] <= dp_vfdsu_ex1_pipex_dst_vreg[6:0];
    vfdsu_ex2_iid[6:0]      <= dp_vfdsu_ex1_pipex_iid[6:0];
    vfdsu_ex2_double        <= ex1_double;
    vfdsu_ex2_single        <= ex1_single;
    vfdsu_ex2_div           <= ex1_div;
    vfdsu_ex2_sqrt          <= ex1_sqrt;
  end
  else
  begin
    vfdsu_ex2_dst_ereg[4:0] <= vfdsu_ex2_dst_ereg[4:0];
    vfdsu_ex2_dst_vreg[6:0] <= vfdsu_ex2_dst_vreg[6:0];
    vfdsu_ex2_iid[6:0]      <= vfdsu_ex2_iid[6:0];
    vfdsu_ex2_double        <= vfdsu_ex2_double;
    vfdsu_ex2_single        <= vfdsu_ex2_single;
    vfdsu_ex2_div           <= vfdsu_ex2_div;
    vfdsu_ex2_sqrt          <= vfdsu_ex2_sqrt;
  end
end
// &Force("output","vfdsu_ex2_double"); @103
// &Force("output","vfdsu_ex2_single"); @104
// //&Force("output","vfdsu_ex2_div"); @105
// //&Force("output","vfdsu_ex2_sqrt"); @106


always @(posedge ex2_data_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    vfdsu_ex3_dst_ereg[4:0] <= 5'b0;
    vfdsu_ex3_dst_vreg[6:0] <= 7'b0;
    vfdsu_ex3_iid[6:0]      <= 7'b0;
//    vfdsu_ex3_double        <= 1'b0;
//    vfdsu_ex3_single        <= 1'b0;    
//    vfdsu_ex3_div           <= 1'b0;
//    vfdsu_ex3_sqrt          <= 1'b0;
  end
  else if(ex2_pipedown)
  begin
    vfdsu_ex3_dst_ereg[4:0] <= vfdsu_ex2_dst_ereg[4:0];
    vfdsu_ex3_dst_vreg[6:0] <= vfdsu_ex2_dst_vreg[6:0];
    vfdsu_ex3_iid[6:0]      <= vfdsu_ex2_iid[6:0];
 //   vfdsu_ex3_double        <= vfdsu_ex2_double;
//    vfdsu_ex3_single        <= vfdsu_ex2_single;
//    vfdsu_ex3_div           <= vfdsu_ex2_div;
//    vfdsu_ex3_sqrt          <= vfdsu_ex2_sqrt;
  end
  else
  begin
    vfdsu_ex3_dst_ereg[4:0] <= vfdsu_ex3_dst_ereg[4:0];
    vfdsu_ex3_dst_vreg[6:0] <= vfdsu_ex3_dst_vreg[6:0];
    vfdsu_ex3_iid[6:0]      <= vfdsu_ex3_iid[6:0];
//    vfdsu_ex3_double        <= vfdsu_ex3_double;
//    vfdsu_ex3_single        <= vfdsu_ex3_single;
//    vfdsu_ex3_div           <= vfdsu_ex3_div;
//    vfdsu_ex3_sqrt          <= vfdsu_ex3_sqrt;
  end
end
// //&Force("output","vfdsu_ex3_double"); @142
// //&Force("output","vfdsu_ex3_single"); @143

always @(posedge ex3_data_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    vfdsu_ex4_dst_ereg[4:0] <= 5'b0;
    vfdsu_ex4_dst_vreg[6:0] <= 7'b0;
    vfdsu_ex4_iid[6:0]      <= 7'b0;
//    vfdsu_ex4_double        <= 1'b0;
//    vfdsu_ex4_single        <= 1'b0;
//    vfdsu_ex4_div           <= 1'b0;
//    vfdsu_ex4_sqrt          <= 1'b0;
  end
  else if(ex3_pipedown)
  begin
    vfdsu_ex4_dst_ereg[4:0] <= vfdsu_ex3_dst_ereg[4:0];
    vfdsu_ex4_dst_vreg[6:0] <= vfdsu_ex3_dst_vreg[6:0];
    vfdsu_ex4_iid[6:0]      <= vfdsu_ex3_iid[6:0];
//    vfdsu_ex4_double        <= vfdsu_ex3_double;
//    vfdsu_ex4_single        <= vfdsu_ex3_single;
//    vfdsu_ex4_div           <= vfdsu_ex3_div;
//    vfdsu_ex4_sqrt          <= vfdsu_ex3_sqrt;
  end
  else
  begin
    vfdsu_ex4_dst_ereg[4:0] <= vfdsu_ex4_dst_ereg[4:0];
    vfdsu_ex4_dst_vreg[6:0] <= vfdsu_ex4_dst_vreg[6:0];
    vfdsu_ex4_iid[6:0]      <= vfdsu_ex4_iid[6:0];
//    vfdsu_ex4_double        <= vfdsu_ex4_double;
//    vfdsu_ex4_single        <= vfdsu_ex4_single;
//    vfdsu_ex4_div           <= vfdsu_ex4_div;
//    vfdsu_ex4_sqrt          <= vfdsu_ex4_sqrt;
  end
end
// //&Force("output","vfdsu_ex4_double"); @178
// //&Force("output","vfdsu_ex4_single"); @179


assign pipex_dp_vfdsu_ereg_data[4:0]   = ex4_out_expt[4:0];
assign pipex_dp_vfdsu_freg_data[63:0]  = ex4_out_result[63:0];
assign pipex_dp_vfdsu_ereg[4:0]        = vfdsu_ex4_dst_ereg[4:0];
assign pipex_dp_vfdsu_vreg[6:0]        = vfdsu_ex4_dst_vreg[6:0];






// &ModuleEnd; @192
endmodule


