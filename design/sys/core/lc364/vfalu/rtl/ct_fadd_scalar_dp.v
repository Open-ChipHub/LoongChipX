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

// &ModuleBeg; @22
module ct_fadd_scalar_dp (
  // &Ports, @23
  input    wire          cp0_vfpu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire  [19:0]  dp_vfalu_ex1_pipex_func,
  input    wire  [2 :0]  dp_vfalu_ex1_pipex_imm0,
  input    wire  [63:0]  dp_vfalu_ex1_pipex_srcf0,
  input    wire  [63:0]  dp_vfalu_ex1_pipex_srcf1,
  input    wire          ex1_doub_cmp_result,
  input    wire          ex1_doub_half_cmp_result,
  input    wire          ex1_pipe_clk,
  input    wire          ex1_pipedown,
  input    wire          ex2_pipedown,
  input    wire  [4 :0]  ex3_expt,
  input    wire          ex3_pipedown,
  input    wire  [63:0]  ex3_result,
  input    wire          forever_cpuclk,
  input    wire  [4 :0]  half_expt,
  input    wire  [15:0]  half_result,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [2 :0]  vfpu_yy_xx_rm,
  output   wire          ex1_double,
  output   wire          ex1_op_add,
  output   wire          ex1_op_cmp,
  output   wire          ex1_op_faf,
  output   wire          ex1_op_feq,
  output   wire          ex1_op_fle,
  output   wire          ex1_op_flt,
  output   wire          ex1_op_fne,
  output   wire          ex1_op_fueq,
  output   wire          ex1_op_fule,
  output   wire          ex1_op_fult,
  output   wire          ex1_op_fune,
  output   wire          ex1_op_ford,
  output   wire          ex1_op_fuord,
  output   wire          ex1_op_mmabs,
  output   wire          ex1_op_maxnm,
  output   wire          ex1_op_minnm,
  output   wire          ex1_op_sub,
  output   wire          ex1_single,
  output   wire          ex2_double,
  output   wire          ex2_op_add,
  output   wire          ex2_op_cmp,
  output   wire          ex2_op_fle,
  output   wire          ex2_op_flt,
  output   wire          ex2_op_signal,
  output   wire          ex2_op_mmabs,
  output   wire          ex2_op_maxnm,
  output   wire          ex2_op_minnm,
  output   wire          ex2_op_sub,
  output   wire          ex2_rm_rdn,
  output   wire          ex2_rm_rmm,
  output   wire          ex2_rm_rne,
  output   wire          ex2_rm_rtz,
  output   wire          ex2_rm_rup,
  output   wire          ex2_single,
  output   wire  [63:0]  fadd_ctrl_src0,
  output   wire  [63:0]  fadd_ctrl_src1,
  output   wire          fadd_ereg_ex3_forward_r_vld,
  output   wire  [4 :0]  fadd_ereg_ex3_result,
  output   wire          fadd_forward_r_vld,
  output   wire  [63:0]  fadd_forward_result,
  output   wire  [63:0]  fadd_mfvr_cmp_result
); 



// &Regs; @24
reg     [4 :0]  fadd_ex2_cmp_op;            
reg             fadd_ex2_double;            
reg     [5 :0]  fadd_ex2_op;                
reg             fadd_ex2_rm_rdn;            
reg             fadd_ex2_rm_rmm;            
reg             fadd_ex2_rm_rne;            
reg             fadd_ex2_rm_rtz;            
reg             fadd_ex2_rm_rup;            
reg             fadd_ex2_single;            
reg             fadd_ex2_signal;            
reg             fadd_ex3_half;              
reg             fadd_ex3_op_cmp;            

// &Wires; @25
wire    [4 :0]  ex1_cmp_op;                 
wire            ex1_cmp_result;             
wire    [5 :0]  ex1_op;
wire            ex1_signal;                  
wire            ex1_rm_rdn;                 
wire            ex1_rm_rmm;                 
wire            ex1_rm_rne;                 
wire            ex1_rm_rtz;                 
wire            ex1_rm_rup;                 
wire            ex2_pipe_clk;               
wire            ex2_pipe_clk_en;            
wire            fadd_ex2_half;              
wire    [19:0]  func;                       
wire    [2 :0]  vfalu_rm;                   
wire    [2 :0]  vfalu_static_rm;            


//Global Signals from FCR (set by user)
//Rounding Mode
assign vfalu_static_rm[2:0] = dp_vfalu_ex1_pipex_imm0[2:0];
assign vfalu_rm[2:0]        = (vfalu_static_rm[2:0] == 3'b111) 
                              ? vfpu_yy_xx_rm[2:0]
			                        : vfalu_static_rm[2:0]; 
assign ex1_rm_rne = (vfalu_rm[2:0] == 3'b000);
assign ex1_rm_rtz = (vfalu_rm[2:0] == 3'b001);
assign ex1_rm_rdn = (vfalu_rm[2:0] == 3'b010);
assign ex1_rm_rup = (vfalu_rm[2:0] == 3'b011);
assign ex1_rm_rmm = (vfalu_rm[2:0] == 3'b100);

// &Force("bus","dp_vfalu_ex1_pipex_func",19,0); @42
assign func[19:0]  = dp_vfalu_ex1_pipex_func[19:0];
assign ex1_double  = func[16];
assign ex1_single  = func[15];

// wire is_arch_la = 1'b1;
// assign fadd_ctrl_src0[63:0]  = is_arch_la ?
//                                  ex1_single ? {32'hffffffff, dp_vfalu_ex1_pipex_srcf0[31:0]} 
//                                       : dp_vfalu_ex1_pipex_srcf0[63:0]
//                                : dp_vfalu_ex1_pipex_srcf0[63:0];
// assign fadd_ctrl_src1[63:0]  = is_arch_la ?
//                                  ex1_single ? {32'hffffffff, dp_vfalu_ex1_pipex_srcf1[31:0]} 
//                                       : dp_vfalu_ex1_pipex_srcf1[63:0]
//                                : dp_vfalu_ex1_pipex_srcf1[63:0];

assign fadd_ctrl_src0[63:0]  = dp_vfalu_ex1_pipex_srcf0[63:0];

assign fadd_ctrl_src1[63:0]  = dp_vfalu_ex1_pipex_srcf1[63:0];


// &Force("output","ex1_double"); @46
// &Force("output","ex1_single"); @47
//====================Operation Type=======================
assign ex1_op_add      = func[12];
assign ex1_op_sub      = func[11];
assign ex1_op_cmp      = func[10];

assign ex1_op_maxnm    = func[9];
assign ex1_op_minnm    = func[8];

// assign ex1_op_maxnm    = func[9] && !func[0];
// assign ex1_op_minnm    = func[8] && !func[0];

assign ex1_op_maxanm   = func[9] && func[0];
assign ex1_op_minanm   = func[8] && func[0];

assign ex1_op_mmabs    = ex1_op_minanm || ex1_op_maxanm;

assign ex1_op[5:0]     = {ex1_op_mmabs,
                          ex1_op_maxnm,
                          ex1_op_minnm,
                          ex1_op_cmp,
                          ex1_op_sub,
                          ex1_op_add};
// &Force("output","ex1_op_add"); @59
// &Force("output","ex1_op_cmp"); @60
// &Force("output","ex1_op_maxnm"); @61
// &Force("output","ex1_op_minnm"); @62
// &Force("output","ex1_op_sub"); @63

// parameter FCMP_D_C_AF  = 20'b0011_1000_0100_0000_0000; 
// parameter FCMP_D_C_UN  = 20'b0011_1000_0100_0000_0001; 
// parameter FCMP_D_C_EQ  = 20'b0011_1000_0100_0000_0010; 
// parameter FCMP_D_C_UEQ = 20'b0011_1000_0100_0000_0011; 
// parameter FCMP_D_C_LT  = 20'b0011_1000_0100_0000_0100; 
// parameter FCMP_D_C_ULT = 20'b0011_1000_0100_0000_0101; 
// parameter FCMP_D_C_LE  = 20'b0011_1000_0100_0000_0110; 
// parameter FCMP_D_C_ULE = 20'b0011_1000_0100_0000_0111; 
// parameter FCMP_D_C_NE  = 20'b0011_1000_0100_0000_1000; 
// parameter FCMP_D_C_OR  = 20'b0011_1000_0100_0000_1001; 
// parameter FCMP_D_C_UNE = 20'b0011_1000_0100_0000_1010; 

wire is_af  = func[3:0] == 4'b0000;
wire is_un  = func[3:0] == 4'b0001; 
wire is_eq  = func[3:0] == 4'b0010; 
wire is_ueq = func[3:0] == 4'b0011; 
wire is_lt  = func[3:0] == 4'b0100; 
wire is_ult = func[3:0] == 4'b0101; 
wire is_le  = func[3:0] == 4'b0110; 
wire is_ule = func[3:0] == 4'b0111; 
wire is_ne  = func[3:0] == 4'b1000; 
wire is_or  = func[3:0] == 4'b1001; 
wire is_une = func[3:0] == 4'b1010; 

assign ex1_op_faf   = ex1_op_cmp && is_af;
assign ex1_op_feq   = ex1_op_cmp && is_eq; 
assign ex1_op_flt   = ex1_op_cmp && is_lt; 
assign ex1_op_fle   = ex1_op_cmp && is_le; 
assign ex1_op_fne   = ex1_op_cmp && is_ne;

assign ex1_op_fueq  = ex1_op_cmp && is_ueq; 
assign ex1_op_fult  = ex1_op_cmp && is_ult; 
assign ex1_op_fule  = ex1_op_cmp && is_ule; 
assign ex1_op_fune  = ex1_op_cmp && is_une;

assign ex1_op_fuord = ex1_op_cmp && is_un;
assign ex1_op_ford  = ex1_op_cmp && is_or;

assign ex1_signal   = ex1_op_cmp && func[4];

assign ex1_cmp_op[4:0] = {ex1_op_fne,
                          ex1_op_ford,
                          ex1_op_feq,
                          ex1_op_flt,
                          ex1_op_fle};
// &Force("output","ex1_op_fne"); @74
// &Force("output","ex1_op_ford"); @75
// &Force("output","ex1_op_feq"); @76
// &Force("output","ex1_op_flt"); @77
// &Force("output","ex1_op_fle"); @78


// handle the f compare result 
assign  ex1_cmp_result          =  ex1_double || ex1_single ? ex1_doub_cmp_result
                                                            : ex1_doub_half_cmp_result;
assign  fadd_mfvr_cmp_result[63:0] = {63'b0, ex1_cmp_result};

//======================Flop to EX2=========================

always @(posedge ex1_pipe_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    fadd_ex2_double                     <=  1'b0;
    fadd_ex2_single                     <=  1'b0;
    fadd_ex2_signal                     <=  1'b0;
    fadd_ex2_op[5:0]                    <=  6'b0;
    fadd_ex2_cmp_op[4:0]                <=  5'b0;
    fadd_ex2_rm_rne                     <=  1'b0;
    fadd_ex2_rm_rtz                     <=  1'b0;
    fadd_ex2_rm_rdn                     <=  1'b0;
    fadd_ex2_rm_rup                     <=  1'b0;
    fadd_ex2_rm_rmm                     <=  1'b0;
  end
  else if(ex1_pipedown)
  begin
    fadd_ex2_double                     <= ex1_double;
    fadd_ex2_single                     <= ex1_single;
    fadd_ex2_signal                     <= ex1_signal;
    fadd_ex2_op[5:0]                    <= ex1_op[5:0];
    fadd_ex2_cmp_op[4:0]                <= ex1_cmp_op[4:0];
    fadd_ex2_rm_rne                     <= ex1_rm_rne;
    fadd_ex2_rm_rtz                     <= ex1_rm_rtz;
    fadd_ex2_rm_rdn                     <= ex1_rm_rdn;
    fadd_ex2_rm_rup                     <= ex1_rm_rup;
    fadd_ex2_rm_rmm                     <= ex1_rm_rmm;
  end
  else
  begin
    fadd_ex2_double                     <= fadd_ex2_double;
    fadd_ex2_single                     <= fadd_ex2_single;
    fadd_ex2_signal                     <= fadd_ex2_signal;
    fadd_ex2_op[5:0]                    <= fadd_ex2_op[5:0];
    fadd_ex2_cmp_op[4:0]                <= fadd_ex2_cmp_op[4:0];
    fadd_ex2_rm_rne                     <= fadd_ex2_rm_rne;
    fadd_ex2_rm_rtz                     <= fadd_ex2_rm_rtz;
    fadd_ex2_rm_rdn                     <= fadd_ex2_rm_rdn;
    fadd_ex2_rm_rup                     <= fadd_ex2_rm_rup;
    fadd_ex2_rm_rmm                     <= fadd_ex2_rm_rmm;
  end
end
//EX2 Signal Prepare

assign ex2_double         = fadd_ex2_double;
assign ex2_single         = fadd_ex2_single;
assign fadd_ex2_half      = !fadd_ex2_double && !fadd_ex2_single;
// &Force("output","ex2_double"); @132
assign ex2_op_mmabs       = fadd_ex2_op[5];
assign ex2_op_maxnm       = fadd_ex2_op[4];
assign ex2_op_minnm       = fadd_ex2_op[3];
assign ex2_op_cmp         = fadd_ex2_op[2];
assign ex2_op_sub         = fadd_ex2_op[1];
assign ex2_op_add         = fadd_ex2_op[0];
// &Force("output","ex2_op_cmp"); @138
//assign ex2_op_feq       = fadd_ex2_cmp_op[2]; 
assign ex2_op_flt       = fadd_ex2_cmp_op[1]; 
assign ex2_op_fle       = fadd_ex2_cmp_op[0];
//assign ex2_op_ford      = fadd_ex2_cmp_op[3];
//assign ex2_op_fne       = fadd_ex2_cmp_op[4];
assign ex2_op_signal    = fadd_ex2_signal;

assign ex2_rm_rne       = fadd_ex2_rm_rne;
assign ex2_rm_rtz       = fadd_ex2_rm_rtz;
assign ex2_rm_rdn       = fadd_ex2_rm_rdn;
assign ex2_rm_rup       = fadd_ex2_rm_rup;
assign ex2_rm_rmm       = fadd_ex2_rm_rmm;
// &Instance("gated_clk_cell","x_ex2_pipe_clk"); @150
gated_clk_cell  x_ex2_pipe_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_pipe_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_pipe_clk_en   ),
  .module_en          (cp0_vfpu_icg_en   ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in         (forever_cpuclk), @151
//           .clk_out        (ex2_pipe_clk),//Out Clock @152
//           .external_en    (1'b0), @153
//           .global_en      (cp0_yy_clk_en), @154
//           .local_en       (ex2_pipe_clk_en),//Local Condition @155
//           .module_en      (cp0_vfpu_icg_en) @156
//         ); @157
assign ex2_pipe_clk_en = ex2_pipedown;

always @(posedge ex2_pipe_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    fadd_ex3_half                     <=  1'b0;
    fadd_ex3_op_cmp                   <=  1'b0;
  end
  else if(ex2_pipedown)
  begin
    fadd_ex3_half                     <=  fadd_ex2_half;
    fadd_ex3_op_cmp                   <= ex2_op_cmp;
  end
  else
  begin
    fadd_ex3_half                     <=  fadd_ex3_half;
    fadd_ex3_op_cmp                   <=  fadd_ex3_op_cmp;
  end
end
assign fadd_forward_result[63:0]   = fadd_ex3_half ? {{48{!fadd_ex3_op_cmp}},half_result[15:0]} : ex3_result[63:0];
assign fadd_ereg_ex3_result[4:0]   = fadd_ex3_half ? half_expt[4:0] : ex3_expt[4:0];
assign fadd_ereg_ex3_forward_r_vld = ex3_pipedown;
assign fadd_forward_r_vld          = ex3_pipedown;
//assign  fadd_vreg_ex4_forward_r_vld   = ex4_inst_vld;

// &ModuleEnd; @184
endmodule



