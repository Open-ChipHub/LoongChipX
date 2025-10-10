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

// &ModuleBeg; @28
module ct_iu_alu (
  // &Ports, @29
  input    wire           cp0_iu_icg_en,
  input    wire           cp0_yy_clk_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [63 :0]  had_idu_wbbr_data,
  input    wire           had_idu_wbbr_vld,
  input    wire  [31 :0]  idu_iu_rf_pipex_opcode,
  input    wire  [6 :0]   idu_iu_rf_pipex_iid,
  input    wire  [63 :0]  idu_iu_rf_pipex_inst_sel,
  input    wire           idu_iu_rf_pipex_alu_short,
  input    wire  [6  :0]  idu_iu_rf_pipex_dst_preg,
  input    wire           idu_iu_rf_pipex_dst_vld,
  input    wire  [6  :0]  idu_iu_rf_pipex_dst_vreg,
  input    wire           idu_iu_rf_pipex_dstv_vld,
  input    wire  [4  :0]  idu_iu_rf_pipex_func,
  input    wire           idu_iu_rf_pipex_gateclk_sel,
  input    wire  [5  :0]  idu_iu_rf_pipex_imm,
  input    wire  [20 :0]  idu_iu_rf_pipex_rslt_sel,
  input    wire           idu_iu_rf_pipex_sel,
  input    wire  [63 :0]  idu_iu_rf_pipex_src0,
  input    wire  [63 :0]  idu_iu_rf_pipex_src1,
  input    wire  [63 :0]  idu_iu_rf_pipex_src2,
  input    wire  [7  :0]  idu_iu_rf_pipex_vl,
  input    wire  [1  :0]  idu_iu_rf_pipex_vlmul,
  input    wire  [2  :0]  idu_iu_rf_pipex_vsew,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_yy_xx_flush,
  output   wire  [63 :0]  alu_rbus_ex1_pipex_data,
  output   wire           alu_rbus_ex1_pipex_data_vld,
  output   wire  [63 :0]  alu_rbus_ex1_pipex_fwd_data,
  output   wire           alu_rbus_ex1_pipex_fwd_vld,
  output   wire  [6  :0]  alu_rbus_ex1_pipex_preg,
  output   wire  [6  :0]  alu_rbus_ex1_pipex_iid,
  output   wire  [4  :0]  alu_rbus_ex1_pipex_dstreg,
  output   wire  [4  :0]  iu_vfpu_ex1_pipex_mtvr_inst,
  output   wire  [7  :0]  iu_vfpu_ex1_pipex_mtvr_vl,
  output   wire           iu_vfpu_ex1_pipex_mtvr_vld,
  output   wire  [1  :0]  iu_vfpu_ex1_pipex_mtvr_vlmul,
  output   wire  [6  :0]  iu_vfpu_ex1_pipex_mtvr_vreg,
  output   wire  [2  :0]  iu_vfpu_ex1_pipex_mtvr_vsew,
  output   wire  [63 :0]  iu_vfpu_ex2_pipex_mtvr_src0,
  output   wire           iu_vfpu_ex2_pipex_mtvr_vld
); 



// &Regs; @30
reg     [63 :0]  adder_addsl_src1;            
reg     [31 :0]  alu_ex1_opcode;          
reg     [63 :0]  alu_ex1_inst_sel;          
reg     [4  :0]  alu_ex1_adder_func;          
reg     [63 :0]  alu_ex1_adder_fwd_data;      
reg     [63 :0]  alu_ex1_adder_src0;          
reg     [63 :0]  alu_ex1_adder_src1;          
reg              alu_ex1_alu_short;           
reg     [6  :0]  alu_ex1_dst_preg;            
reg     [6  :0]  alu_ex1_iid;            
reg              alu_ex1_dst_vld;             
reg     [6  :0]  alu_ex1_dst_vreg;            
reg              alu_ex1_dstv_vld;            
reg     [2  :0]  alu_ex1_eu_sel;              
reg     [4  :0]  alu_ex1_func;                
reg     [63 :0]  alu_ex1_fwd_data;            
reg              alu_ex1_fwd_vld;             
reg     [5  :0]  alu_ex1_imm;                 
reg              alu_ex1_inst_vld;            
reg     [63 :0]  alu_ex1_long_data;           
reg     [63 :0]  alu_ex1_other_fwd_data;      
reg     [20 :0]  alu_ex1_rslt_sel;            
reg     [4  :0]  alu_ex1_shifter_func;        
reg     [63 :0]  alu_ex1_shifter_fwd_data;    
reg     [63 :0]  alu_ex1_shifter_src0;        
reg     [63 :0]  alu_ex1_shifter_src1;        
reg     [63 :0]  alu_ex1_src0;                
reg     [63 :0]  alu_ex1_src1;                
reg     [63 :0]  alu_ex1_src2;                
reg     [7  :0]  alu_ex1_vl;                  
reg     [1  :0]  alu_ex1_vlmul;               
reg     [2  :0]  alu_ex1_vsew;                
reg     [63 :0]  misc_ex2_mtvr_src0;          
reg              misc_ex2_mtvr_vld;           
reg     [63 :0]  misc_ff1_rslt;               
reg              misc_tst_rslt;               
reg              shifter_ext_sign;            
reg     [63 :0]  shifter_extu_mask;           

// &Wires; @31
wire    [63 :0]  adder_addsl_rslt;            
wire    [63 :0]  adder_data_out_add;          
wire    [31 :0]  adder_data_out_addw;         
wire    [63 :0]  adder_data_out_sub;          
wire    [31 :0]  adder_data_out_subw;         
wire             adder_inst_cmp_unsign;       
wire    [63 :0]  adder_rslt_max;              
wire    [31 :0]  adder_rslt_maxw;             
wire    [63 :0]  adder_rslt_min;              
wire    [31 :0]  adder_rslt_minw;             
wire             adder_rslt_slt;              
wire             adder_slts;                  
wire             adder_sltsw;                 
wire             adder_sltu;                  
wire             adder_sltuw;                 
wire             adder_sltw;                  
wire             alu_rf_fwd_vld;              
wire             ctrl_clk;                    
wire             ctrl_clk_en;                 
wire             ex1_inst_clk;                
wire             ex1_inst_clk_en;             
wire             ex2_inst_clk;                
wire             ex2_inst_clk_en;             
wire    [2  :0]  idu_iu_rf_pipex_eu_sel;      
wire    [63 :0]  logic_and_rslt;              
wire    [63 :0]  logic_cli_rslt;              
wire    [63 :0]  logic_lui_rslt;              
wire    [63 :0]  logic_or_rslt;               
wire    [63 :0]  logic_xor_rslt;              
wire             misc_ex1_mtvr_vld;           
wire    [63 :0]  misc_ff1_src;                
wire             misc_inst_ff0_sel;           
wire    [4  :0]  misc_inst_mtvr_inst;         
wire    [63 :0]  misc_mv_rslt;                
wire             misc_mv_sel;                 
wire    [63 :0]  misc_rev_rslt;               
wire    [31 :0]  misc_revw_rslt;              
wire             misc_src1_eq_0;              
wire    [63 :0]  misc_tstnbz_rslt;            
wire    [63 :0]  shifter_ext_and_mask;        
wire             shifter_ext_and_sel_mask;    
wire             shifter_ext_exts;            
wire    [63 :0]  shifter_ext_or_mask;         
wire             shifter_ext_or_sel_mask;     
wire    [63 :0]  shifter_ext_rslt;            
wire    [63 :0]  shifter_ext_shift;           
wire    [63 :0]  shifter_l_rslt;              
wire    [31 :0]  shifter_lw_rslt;             
wire    [127:0]  shifter_r_rslt;              
wire    [63 :0]  shifter_r_shift_in;          
wire    [63 :0]  shifter_rw_rslt;             
wire    [31 :0]  shifter_rw_shift_in;         



//==========================================================
//                   Define ALU result
//==========================================================
parameter ALU_SEL = 21;

parameter ADDER_ADD   = 21'h000001;
parameter ADDER_ADDW  = 21'h000002;
parameter ADDER_SUB   = 21'h000004;
parameter ADDER_SUBW  = 21'h000008;
parameter ADDER_SLT   = 21'h000010;
parameter SHIFTER_SL  = 21'h000020;
parameter SHIFTER_SR  = 21'h000040;
parameter SHIFTER_SLW = 21'h000080;
parameter SHIFTER_SRW = 21'h000100;
parameter SHIFTER_EXT = 21'h000200;
parameter LOGIC_AND   = 21'h000400;
parameter LOGIC_OR    = 21'h000800;
parameter LOGIC_XOR   = 21'h001000;
parameter LOGIC_LUI   = 21'h002000;
parameter LOGIC_CLI   = 21'h004000;
parameter MISC_MV     = 21'h008000;
parameter MISC_TSTNBZ = 21'h010000;
parameter MISC_TST    = 21'h020000;
parameter MISC_FF1    = 21'h040000;
parameter MISC_REV    = 21'h080000;
parameter MISC_REVW   = 21'h100000;

parameter ADDER_MAX   = 21'h01;
parameter ADDER_MAXW  = 21'h02;
parameter ADDER_MIN   = 21'h04;
parameter ADDER_MINW  = 21'h08;
parameter ADDER_ADDSL = 21'h20;


//==========================================================
//                 ALU Pipeline parameter
//==========================================================
parameter ALU_FN_SUBCODE_SEL_W  = 5'b000_00;
parameter ALU_FN_SUBCODE_SEL_WU = 5'b000_01;
parameter ALU_FN_SUBCODE_SEL_D  = 5'b000_10;
parameter ALU_FN_SUBCODE_SEL_B  = 5'b000_11;
parameter ALU_FN_SUBCODE_SEL_H  = 5'b001_00;

parameter ALU_OPCODE_NUM        = 64;
parameter ALU_OPCODE_ALSL       = 64'd0;
parameter ALU_OPCODE_BYTEPICK   = 64'd1;
parameter ALU_OPCODE_ADD        = 64'd2;
parameter ALU_OPCODE_SUB        = 64'd3;
parameter ALU_OPCODE_SLT        = 64'd4;
parameter ALU_OPCODE_SLTU       = 64'd5;
parameter ALU_OPCODE_MASKEQZ    = 64'd6;
parameter ALU_OPCODE_MASKNEZ    = 64'd7;
parameter ALU_OPCODE_NOR        = 64'd8;
parameter ALU_OPCODE_AND        = 64'd9;
parameter ALU_OPCODE_OR         = 64'd10;
parameter ALU_OPCODE_XOR        = 64'd11;
parameter ALU_OPCODE_ORN        = 64'd12;
parameter ALU_OPCODE_ANDN       = 64'd13;
parameter ALU_OPCODE_SLL        = 64'd14;
parameter ALU_OPCODE_SRL        = 64'd15;
parameter ALU_OPCODE_SRA        = 64'd16;
parameter ALU_OPCODE_ROTR       = 64'd17;
parameter ALU_OPCODE_ADC        = 64'd18;
parameter ALU_OPCODE_SBC        = 64'd19;
parameter ALU_OPCODE_CLO        = 64'd20;
parameter ALU_OPCODE_CLZ        = 64'd21;
parameter ALU_OPCODE_CTO        = 64'd22;
parameter ALU_OPCODE_CTZ        = 64'd23;
parameter ALU_OPCODE_REV        = 64'd24;
parameter ALU_OPCODE_BITREV     = 64'd25;
parameter ALU_OPCODE_EXT        = 64'd26;
parameter ALU_OPCODE_SLLI       = 64'd27;
parameter ALU_OPCODE_SRLI       = 64'd28;
parameter ALU_OPCODE_SRAI       = 64'd29;
parameter ALU_OPCODE_ROTRI      = 64'd30;
parameter ALU_OPCODE_BSTRINS    = 64'd31;
parameter ALU_OPCODE_BSTRPICK   = 64'd32;
parameter ALU_OPCODE_SLTI       = 64'd33;
parameter ALU_OPCODE_SLTUI      = 64'd34;
parameter ALU_OPCODE_ADDI       = 64'd35;
parameter ALU_OPCODE_LU52I      = 64'd36;
parameter ALU_OPCODE_ANDI       = 64'd37;
parameter ALU_OPCODE_ORI        = 64'd38;
parameter ALU_OPCODE_XORI       = 64'd39;
parameter ALU_OPCODE_ADDU16I    = 64'd40;
parameter ALU_OPCODE_LU12I      = 64'd41;
parameter ALU_OPCODE_LU32I      = 64'd42;
parameter ALU_OPCODE_ASRTLE     = 64'd43;
parameter ALU_OPCODE_ASRTGE     = 64'd44;
parameter ALU_OPCODE_CPUFG      = 64'd45;
parameter ALU_OPCODE_RDTIME     = 64'd46;
parameter ALU_OPCODE_PCADDI     = 64'd47;
parameter ALU_OPCODE_PCALAU12I  = 64'd48;
parameter ALU_OPCODE_PCADDU12I  = 64'd49;
parameter ALU_OPCODE_PCADDU18I  = 64'd50;
parameter ALU_OPCODE_CRC        = 64'd51;
parameter ALU_OPCODE_CRCC       = 64'd52;
parameter ALU_OPCODE_RCRI       = 64'd53;
parameter ALU_OPCODE_DIV        = 64'd54;
parameter ALU_OPCODE_MOD        = 64'd55;
parameter ALU_OPCODE_MULT       = 64'd56;
parameter ALU_OPCODE_SPECIAL    = 64'd57;

parameter ALU_OPCODE_MVW        = 64'd58;
parameter ALU_OPCODE_MVD        = 64'd59;
parameter ALU_OPCODE_MVGF       = 64'd60;

//==========================================================
//                 RF/EX1 Pipeline Register
//==========================================================
//----------------------------------------------------------
//                 Instance of Gated Cell  
//----------------------------------------------------------
assign ctrl_clk_en = idu_iu_rf_pipex_gateclk_sel
                     || alu_ex1_inst_vld
                     || misc_ex2_mtvr_vld;
// &Instance("gated_clk_cell", "x_ctrl_gated_clk"); @76
gated_clk_cell  x_ctrl_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ctrl_clk          ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ctrl_clk_en       ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @77
//          .external_en (1'b0), @78
//          .global_en   (cp0_yy_clk_en), @79
//          .module_en   (cp0_iu_icg_en), @80
//          .local_en    (ctrl_clk_en), @81
//          .clk_out     (ctrl_clk)); @82

assign ex1_inst_clk_en = idu_iu_rf_pipex_gateclk_sel;
// &Instance("gated_clk_cell", "x_ex1_inst_gated_clk"); @85
gated_clk_cell  x_ex1_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex1_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex1_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @86
//          .external_en (1'b0), @87
//          .global_en   (cp0_yy_clk_en), @88
//          .module_en   (cp0_iu_icg_en), @89
//          .local_en    (ex1_inst_clk_en), @90
//          .clk_out     (ex1_inst_clk)); @91

assign ex2_inst_clk_en = misc_ex1_mtvr_vld;
// &Instance("gated_clk_cell", "x_ex2_inst_gated_clk"); @94
gated_clk_cell  x_ex2_inst_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ex2_inst_clk      ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ex2_inst_clk_en   ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @95
//          .external_en (1'b0), @96
//          .global_en   (cp0_yy_clk_en), @97
//          .module_en   (cp0_iu_icg_en), @98
//          .local_en    (ex2_inst_clk_en), @99
//          .clk_out     (ex2_inst_clk)); @100

//----------------------------------------------------------
//              Pipe2 EX1 Instruction valid
//----------------------------------------------------------
assign alu_rf_fwd_vld = idu_iu_rf_pipex_sel
                        && idu_iu_rf_pipex_dst_vld
                        && idu_iu_rf_pipex_alu_short;

always @(posedge ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    alu_ex1_inst_vld <= 1'b0;
    alu_ex1_fwd_vld  <= 1'b0;
  end
  else if(rtu_yy_xx_flush) begin
    alu_ex1_inst_vld <= 1'b0;
    alu_ex1_fwd_vld  <= 1'b0;
  end
  else begin
    alu_ex1_inst_vld <= idu_iu_rf_pipex_sel;
    alu_ex1_fwd_vld  <= alu_rf_fwd_vld;
  end
end

//----------------------------------------------------------
//               Pipe2 EX1 Instruction Data
//----------------------------------------------------------
assign idu_iu_rf_pipex_eu_sel[0] = |idu_iu_rf_pipex_rslt_sel[4:0];
assign idu_iu_rf_pipex_eu_sel[1] = |idu_iu_rf_pipex_rslt_sel[9:5];
assign idu_iu_rf_pipex_eu_sel[2] = |idu_iu_rf_pipex_rslt_sel[ALU_SEL-1:10];

always @(posedge ex1_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    alu_ex1_dst_vld               <= 1'b0;
    alu_ex1_opcode[31:0]          <= 32'b0;
    alu_ex1_inst_sel[63:0]        <= 64'b0;
    alu_ex1_dst_preg[6:0]         <= 7'b0;
    alu_ex1_iid[6:0]              <= 7'b0;
    alu_ex1_dstv_vld              <= 1'b0;
    alu_ex1_dst_vreg[6:0]         <= 7'b0;
    alu_ex1_func[4:0]             <= 5'b0;
    alu_ex1_adder_func[4:0]       <= 5'b0;
    alu_ex1_shifter_func[4:0]     <= 5'b0;
    alu_ex1_src0[63:0]            <= 64'b0;
    alu_ex1_src1[63:0]            <= 64'b0;
    alu_ex1_adder_src0[63:0]      <= 64'b0;
    alu_ex1_adder_src1[63:0]      <= 64'b0;
    alu_ex1_shifter_src0[63:0]    <= 64'b0;
    alu_ex1_shifter_src1[63:0]    <= 64'b0;
    alu_ex1_src2[63:0]            <= 64'b0;
    alu_ex1_imm[5:0]              <= 6'b0;
    alu_ex1_alu_short             <= 1'b0;
    alu_ex1_rslt_sel[ALU_SEL-1:0] <= {ALU_SEL{1'b0}};
    alu_ex1_eu_sel[2:0]           <= 3'b0;
    alu_ex1_vlmul[1:0]            <= 2'b0;
    alu_ex1_vsew[2:0]             <= 3'b0;
    alu_ex1_vl[7:0]               <= 8'b0;
  end
  else if(idu_iu_rf_pipex_gateclk_sel) begin
    alu_ex1_dst_vld               <= idu_iu_rf_pipex_dst_vld;
    alu_ex1_opcode[31:0]          <= idu_iu_rf_pipex_opcode[31:0];
    alu_ex1_inst_sel[63:0]        <= idu_iu_rf_pipex_inst_sel[63:0];
    alu_ex1_dst_preg[6:0]         <= idu_iu_rf_pipex_dst_preg[6:0];
    alu_ex1_iid[6:0]              <= idu_iu_rf_pipex_iid[6:0];
    alu_ex1_dstv_vld              <= idu_iu_rf_pipex_dstv_vld;
    alu_ex1_dst_vreg[6:0]         <= idu_iu_rf_pipex_dst_vreg[6:0];
    alu_ex1_func[4:0]             <= idu_iu_rf_pipex_func[4:0];
    alu_ex1_adder_func[4:0]       <= idu_iu_rf_pipex_func[4:0];
    alu_ex1_shifter_func[4:0]     <= idu_iu_rf_pipex_func[4:0];
    alu_ex1_src0[63:0]            <= idu_iu_rf_pipex_src0[63:0];
    alu_ex1_src1[63:0]            <= idu_iu_rf_pipex_src1[63:0];
    alu_ex1_adder_src0[63:0]      <= idu_iu_rf_pipex_src0[63:0];
    alu_ex1_adder_src1[63:0]      <= idu_iu_rf_pipex_src1[63:0];
    alu_ex1_shifter_src0[63:0]    <= idu_iu_rf_pipex_src0[63:0];
    alu_ex1_shifter_src1[63:0]    <= idu_iu_rf_pipex_src1[63:0];
    alu_ex1_src2[63:0]            <= idu_iu_rf_pipex_src2[63:0];
    alu_ex1_imm[5:0]              <= idu_iu_rf_pipex_imm[5:0];
    alu_ex1_alu_short             <= idu_iu_rf_pipex_alu_short;
    alu_ex1_rslt_sel[ALU_SEL-1:0] <= idu_iu_rf_pipex_rslt_sel[ALU_SEL-1:0];
    alu_ex1_eu_sel[2:0]           <= idu_iu_rf_pipex_eu_sel[2:0];
    alu_ex1_vlmul[1:0]            <= idu_iu_rf_pipex_vlmul[1:0];
    alu_ex1_vsew[2:0]             <= idu_iu_rf_pipex_vsew[2:0];
    alu_ex1_vl[7:0]               <= idu_iu_rf_pipex_vl[7:0];
  end
  else begin
    alu_ex1_dst_vld               <= alu_ex1_dst_vld;
    alu_ex1_opcode[31:0]          <= alu_ex1_opcode[31:0];
    alu_ex1_inst_sel[63:0]        <= alu_ex1_inst_sel[63:0];
    alu_ex1_dst_preg[6:0]         <= alu_ex1_dst_preg[6:0];
    alu_ex1_iid[6:0]              <= alu_ex1_iid[6:0];
    alu_ex1_dstv_vld              <= alu_ex1_dstv_vld;
    alu_ex1_dst_vreg[6:0]         <= alu_ex1_dst_vreg[6:0];
    alu_ex1_func[4:0]             <= alu_ex1_func[4:0];
    alu_ex1_adder_func[4:0]       <= alu_ex1_adder_func[4:0];
    alu_ex1_shifter_func[4:0]     <= alu_ex1_shifter_func[4:0];
    alu_ex1_src0[63:0]            <= alu_ex1_src0[63:0];
    alu_ex1_src1[63:0]            <= alu_ex1_src1[63:0];
    alu_ex1_src2[63:0]            <= alu_ex1_src2[63:0];
    alu_ex1_adder_src0[63:0]      <= alu_ex1_adder_src0[63:0];
    alu_ex1_adder_src1[63:0]      <= alu_ex1_adder_src1[63:0];
    alu_ex1_shifter_src0[63:0]    <= alu_ex1_shifter_src0[63:0];
    alu_ex1_shifter_src1[63:0]    <= alu_ex1_shifter_src1[63:0];
    alu_ex1_imm[5:0]              <= alu_ex1_imm[5:0];
    alu_ex1_alu_short             <= alu_ex1_alu_short;
    alu_ex1_rslt_sel[ALU_SEL-1:0] <= alu_ex1_rslt_sel[ALU_SEL-1:0];
    alu_ex1_eu_sel[2:0]           <= alu_ex1_eu_sel[2:0];
    alu_ex1_vlmul[1:0]            <= alu_ex1_vlmul[1:0];
    alu_ex1_vsew[2:0]             <= alu_ex1_vsew[2:0];
    alu_ex1_vl[7:0]               <= alu_ex1_vl[7:0];
  end
end

//==========================================================
//                         Debug only
//==========================================================
`define ALU_DEBUG  1
`ifdef ALU_DEBUG
wire   alu_ex1_inst_sel_ALU_OPCODE_BYTEPICK;
wire   alu_ex1_inst_sel_ALU_OPCODE_ADD;
wire   alu_ex1_inst_sel_ALU_OPCODE_SUB;
wire   alu_ex1_inst_sel_ALU_OPCODE_SLT;
wire   alu_ex1_inst_sel_ALU_OPCODE_SLTU;
wire   alu_ex1_inst_sel_ALU_OPCODE_MASKEQZ;
wire   alu_ex1_inst_sel_ALU_OPCODE_MASKNEZ;
wire   alu_ex1_inst_sel_ALU_OPCODE_NOR;
wire   alu_ex1_inst_sel_ALU_OPCODE_AND;
wire   alu_ex1_inst_sel_ALU_OPCODE_OR;
wire   alu_ex1_inst_sel_ALU_OPCODE_XOR;
wire   alu_ex1_inst_sel_ALU_OPCODE_ORN;
wire   alu_ex1_inst_sel_ALU_OPCODE_ANDN;
wire   alu_ex1_inst_sel_ALU_OPCODE_SLL;
wire   alu_ex1_inst_sel_ALU_OPCODE_SRL;
wire   alu_ex1_inst_sel_ALU_OPCODE_SRA;
wire   alu_ex1_inst_sel_ALU_OPCODE_ROTR;
wire   alu_ex1_inst_sel_ALU_OPCODE_ADC;
wire   alu_ex1_inst_sel_ALU_OPCODE_SBC;
wire   alu_ex1_inst_sel_ALU_OPCODE_CLO;
wire   alu_ex1_inst_sel_ALU_OPCODE_CLZ;
wire   alu_ex1_inst_sel_ALU_OPCODE_CTO;
wire   alu_ex1_inst_sel_ALU_OPCODE_CTZ;
wire   alu_ex1_inst_sel_ALU_OPCODE_REV;
wire   alu_ex1_inst_sel_ALU_OPCODE_BITREV;
wire   alu_ex1_inst_sel_ALU_OPCODE_EXT;
wire   alu_ex1_inst_sel_ALU_OPCODE_SLLI;
wire   alu_ex1_inst_sel_ALU_OPCODE_SRLI;
wire   alu_ex1_inst_sel_ALU_OPCODE_SRAI;
wire   alu_ex1_inst_sel_ALU_OPCODE_ROTRI;
wire   alu_ex1_inst_sel_ALU_OPCODE_BSTRINS;
wire   alu_ex1_inst_sel_ALU_OPCODE_BSTRPICK;
wire   alu_ex1_inst_sel_ALU_OPCODE_SLTI;
wire   alu_ex1_inst_sel_ALU_OPCODE_SLTUI;
wire   alu_ex1_inst_sel_ALU_OPCODE_ADDI;
wire   alu_ex1_inst_sel_ALU_OPCODE_LU52I;
wire   alu_ex1_inst_sel_ALU_OPCODE_ANDI;
wire   alu_ex1_inst_sel_ALU_OPCODE_ORI;
wire   alu_ex1_inst_sel_ALU_OPCODE_XORI;
wire   alu_ex1_inst_sel_ALU_OPCODE_ADDU16I;
wire   alu_ex1_inst_sel_ALU_OPCODE_ASRTLE;
wire   alu_ex1_inst_sel_ALU_OPCODE_CRC;
wire   alu_ex1_inst_sel_ALU_OPCODE_RCR;
wire   alu_ex1_inst_sel_ALU_OPCODE_RCRI;

assign  alu_ex1_inst_sel_ALU_OPCODE_ALSL  =  alu_ex1_inst_sel[ALU_OPCODE_ALSL]          ;
assign  alu_ex1_inst_sel_ALU_OPCODE_BYTEPICK   =  alu_ex1_inst_sel[ALU_OPCODE_BYTEPICK] ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ADD   =  alu_ex1_inst_sel[ALU_OPCODE_ADD]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SUB   =  alu_ex1_inst_sel[ALU_OPCODE_SUB]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SLT   =  alu_ex1_inst_sel[ALU_OPCODE_SLT]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SLTU   =  alu_ex1_inst_sel[ALU_OPCODE_SLTU]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_MASKEQZ   =  alu_ex1_inst_sel[ALU_OPCODE_MASKEQZ]   ;
assign  alu_ex1_inst_sel_ALU_OPCODE_MASKNEZ   =  alu_ex1_inst_sel[ALU_OPCODE_MASKNEZ]   ;
assign  alu_ex1_inst_sel_ALU_OPCODE_NOR   =  alu_ex1_inst_sel[ALU_OPCODE_NOR]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_AND   =  alu_ex1_inst_sel[ALU_OPCODE_AND]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_OR   =  alu_ex1_inst_sel[ALU_OPCODE_OR]             ;
assign  alu_ex1_inst_sel_ALU_OPCODE_XOR   =  alu_ex1_inst_sel[ALU_OPCODE_XOR]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ORN   =  alu_ex1_inst_sel[ALU_OPCODE_ORN]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ANDN   =  alu_ex1_inst_sel[ALU_OPCODE_ANDN]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SLL   =  alu_ex1_inst_sel[ALU_OPCODE_SLL]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SRL   =  alu_ex1_inst_sel[ALU_OPCODE_SRL]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SRA   =  alu_ex1_inst_sel[ALU_OPCODE_SRA]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ROTR   =  alu_ex1_inst_sel[ALU_OPCODE_ROTR]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ADC   =  alu_ex1_inst_sel[ALU_OPCODE_ADC]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SBC   =  alu_ex1_inst_sel[ALU_OPCODE_SBC]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_CLO   =  alu_ex1_inst_sel[ALU_OPCODE_CLO]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_CLZ   =  alu_ex1_inst_sel[ALU_OPCODE_CLZ]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_CTO   =  alu_ex1_inst_sel[ALU_OPCODE_CTO]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_CTZ   =  alu_ex1_inst_sel[ALU_OPCODE_CTZ]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_REV   =  alu_ex1_inst_sel[ALU_OPCODE_REV]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_BITREV   =  alu_ex1_inst_sel[ALU_OPCODE_BITREV]     ;
assign  alu_ex1_inst_sel_ALU_OPCODE_EXT   =  alu_ex1_inst_sel[ALU_OPCODE_EXT]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SLLI   =  alu_ex1_inst_sel[ALU_OPCODE_SLLI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SRLI   =  alu_ex1_inst_sel[ALU_OPCODE_SRLI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SRAI   =  alu_ex1_inst_sel[ALU_OPCODE_SRAI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ROTRI   =  alu_ex1_inst_sel[ALU_OPCODE_ROTRI]       ;
assign  alu_ex1_inst_sel_ALU_OPCODE_BSTRINS   =  alu_ex1_inst_sel[ALU_OPCODE_BSTRINS]   ;
assign  alu_ex1_inst_sel_ALU_OPCODE_BSTRPICK   =  alu_ex1_inst_sel[ALU_OPCODE_BSTRPICK] ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SLTI   =  alu_ex1_inst_sel[ALU_OPCODE_SLTI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_SLTUI   =  alu_ex1_inst_sel[ALU_OPCODE_SLTUI]       ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ADDI   =  alu_ex1_inst_sel[ALU_OPCODE_ADDI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_LU52I   =  alu_ex1_inst_sel[ALU_OPCODE_LU52I]       ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ANDI   =  alu_ex1_inst_sel[ALU_OPCODE_ANDI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ORI   =  alu_ex1_inst_sel[ALU_OPCODE_ORI]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_XORI   =  alu_ex1_inst_sel[ALU_OPCODE_XORI]         ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ADDU16I   =  alu_ex1_inst_sel[ALU_OPCODE_ADDU16I]   ;
assign  alu_ex1_inst_sel_ALU_OPCODE_ASRTLE   =  alu_ex1_inst_sel[ALU_OPCODE_ASRTLE]     ;
assign  alu_ex1_inst_sel_ALU_OPCODE_CRC   =  alu_ex1_inst_sel[ALU_OPCODE_CRC]           ;
assign  alu_ex1_inst_sel_ALU_OPCODE_CRCC   =  alu_ex1_inst_sel[ALU_OPCODE_CRCC]         ;

`endif

// The following code will be removed and rewrite in pipe0/1_decd.v
//==========================================================
//                         Decode
//==========================================================

wire  [63 :0] alu_exex_pipex_data;
wire  [63 :0] alu_exe_default_data;

assign alu_exe_default_data = 64'b0;

wire  [63 :0] alu_exe_add_data;
wire  [63 :0] alu_exe_lu12i_data;
wire  [63 :0] alu_exe_alsl_data;
wire  [63 :0] alu_exe_bytepick_data;
wire  [63 :0] alu_exe_sub_data;
wire  [63 :0] alu_exe_slt_data;
wire  [63 :0] alu_exe_sltu_data;
wire  [63 :0] alu_exe_maskeqz_data;
wire  [63 :0] alu_exe_masknez_data;
wire  [63 :0] alu_exe_nor_data;
wire  [63 :0] alu_exe_and_data;
wire  [63 :0] alu_exe_or_data;
wire  [63 :0] alu_exe_xor_data;
wire  [63 :0] alu_exe_orn_data;
wire  [63 :0] alu_exe_andn_data;
wire  [63 :0] alu_exe_sll_data;
wire  [63 :0] alu_exe_srl_data;
wire  [63 :0] alu_exe_sra_data;
wire  [63 :0] alu_exe_rotr_data;
wire  [63 :0] alu_exe_adc_data;
wire  [63 :0] alu_exe_sbc_data;
wire  [63 :0] alu_exe_clo_data;
wire  [63 :0] alu_exe_clz_data;
wire  [63 :0] alu_exe_cto_data;
wire  [63 :0] alu_exe_ctz_data;
wire  [63 :0] alu_exe_rev_data;
wire  [63 :0] alu_exe_bitrev_data;
wire  [63 :0] alu_exe_ext_data;
wire  [63 :0] alu_exe_slli_data;
wire  [63 :0] alu_exe_srli_data;
wire  [63 :0] alu_exe_srai_data;
wire  [63 :0] alu_exe_rotri_data;
wire  [63 :0] alu_exe_bstrins_data;
wire  [63 :0] alu_exe_bstrpick_data;
wire  [63 :0] alu_exe_slti_data;
wire  [63 :0] alu_exe_sltui_data;
wire  [63 :0] alu_exe_addi_data;
wire  [63 :0] alu_exe_lu52i_data;
wire  [63 :0] alu_exe_andi_data;
wire  [63 :0] alu_exe_ori_data;
wire  [63 :0] alu_exe_xori_data;
wire  [63 :0] alu_exe_lu32i_data;
wire  [63 :0] alu_exe_addu16i_data;
wire  [63 :0] alu_exe_movgf_data;
wire  [63 :0] alu_exe_asrtle_data;
wire  [63 :0] alu_exe_asrtge_data;
wire  [63 :0] alu_exe_crc_data;
wire  [63 :0] alu_exe_crcc_data;

assign alu_exex_pipex_data[63:0] = 
                {64{alu_ex1_inst_sel[ALU_OPCODE_ALSL]      }} & alu_exe_alsl_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_BYTEPICK]  }} & alu_exe_bytepick_data  |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ADD]       }} & alu_exe_add_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SUB]       }} & alu_exe_sub_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SLT]       }} & alu_exe_slt_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SLTU]      }} & alu_exe_sltu_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_MASKEQZ]   }} & alu_exe_maskeqz_data   |
                {64{alu_ex1_inst_sel[ALU_OPCODE_MASKNEZ]   }} & alu_exe_masknez_data   |
                {64{alu_ex1_inst_sel[ALU_OPCODE_NOR]       }} & alu_exe_nor_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_AND]       }} & alu_exe_and_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_OR]        }} & alu_exe_or_data        |
                {64{alu_ex1_inst_sel[ALU_OPCODE_XOR]       }} & alu_exe_xor_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ORN]       }} & alu_exe_orn_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ANDN]      }} & alu_exe_andn_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SLL]       }} & alu_exe_sll_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SRL]       }} & alu_exe_srl_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SRA]       }} & alu_exe_sra_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ROTR]      }} & alu_exe_rotr_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_CLO]       }} & alu_exe_clo_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_CLZ]       }} & alu_exe_clz_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_CTO]       }} & alu_exe_cto_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_CTZ]       }} & alu_exe_ctz_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_REV]       }} & alu_exe_rev_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_BITREV]    }} & alu_exe_bitrev_data    |
                {64{alu_ex1_inst_sel[ALU_OPCODE_EXT]       }} & alu_exe_ext_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SLLI]      }} & alu_exe_slli_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SRLI]      }} & alu_exe_srli_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SRAI]      }} & alu_exe_srai_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ROTRI]     }} & alu_exe_rotri_data     |
                {64{alu_ex1_inst_sel[ALU_OPCODE_BSTRINS]   }} & alu_exe_bstrins_data   |
                {64{alu_ex1_inst_sel[ALU_OPCODE_BSTRPICK]  }} & alu_exe_bstrpick_data  |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SLTI]      }} & alu_exe_slti_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_SLTUI]     }} & alu_exe_sltui_data     |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ADDI]      }} & alu_exe_addi_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_LU52I]     }} & alu_exe_lu52i_data     |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ANDI]      }} & alu_exe_andi_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ORI]       }} & alu_exe_ori_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_XORI]      }} & alu_exe_xori_data      |
                {64{alu_ex1_inst_sel[ALU_OPCODE_LU32I]     }} & alu_exe_lu32i_data     |
                {64{alu_ex1_inst_sel[ALU_OPCODE_LU12I]     }} & alu_exe_lu12i_data     |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ADDU16I]   }} & alu_exe_addu16i_data   |
                {64{alu_ex1_inst_sel[ALU_OPCODE_MVGF]      }} & alu_exe_movgf_data     |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ASRTLE]    }} & alu_exe_asrtle_data    |
                {64{alu_ex1_inst_sel[ALU_OPCODE_ASRTGE]    }} & alu_exe_asrtge_data    |
                {64{alu_ex1_inst_sel[ALU_OPCODE_CRC]       }} & alu_exe_crc_data       |
                {64{alu_ex1_inst_sel[ALU_OPCODE_CRCC]      }} & alu_exe_crcc_data;



//==========================================================
//                     LACore EXE
//==========================================================

/// xor, and
assign logic_and_rslt[63:0]    = alu_ex1_src0[63:0] & alu_ex1_src1[63:0];

assign logic_xor_rslt[63:0]    = alu_ex1_src0[63:0] ^ alu_ex1_src1[63:0];

assign alu_exe_and_data = logic_and_rslt;
assign alu_exe_xor_data = logic_xor_rslt;


/// add ori
assign adder_data_out_add[63:0] = alu_ex1_adder_src0[63:0] + alu_ex1_adder_src1[63:0];

assign adder_data_out_addw[31:0] = alu_ex1_adder_src0[31:0] + alu_ex1_adder_src1[31:0];

assign alu_exe_add_data[63:0] = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D) ? 
                                  adder_data_out_add[63:0]
                                : (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W) ?
                                  {{32{adder_data_out_addw[31]}}, adder_data_out_addw[31:0]}
                                : {64{1'b0}};

/// or ori
assign logic_or_rslt[63:0]    = alu_ex1_src0[63:0] | alu_ex1_src1[63:0];
assign alu_exe_or_data[63:0]  = logic_or_rslt[63:0];
assign alu_exe_ori_data[63:0] = alu_ex1_src0[63:0] | {{52{1'b0}},alu_ex1_opcode[21:10]};



/// addiu/w addu16i.d
wire [31:0] alu_addi_w_data = alu_ex1_src0[31:0] + {{20{alu_ex1_opcode[21]}}, alu_ex1_opcode[21:10]};

assign alu_exe_addi_data[63:0] = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D) ? 
                                  alu_ex1_src0[63:0] + {{52{alu_ex1_opcode[21]}}, alu_ex1_opcode[21:10]}
                                : (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W) ?
                                  {{32{alu_addi_w_data[31]}}, alu_addi_w_data[31:0]}
                                : {64{1'b0}};


assign alu_exe_addu16i_data[63:0] = alu_ex1_src0[63:0] + {{32{alu_ex1_opcode[25]}}, alu_ex1_opcode[25:10], 16'b0};




/// maskeqz/masknez
wire mask_cmp_rst = (alu_ex1_src1[63:0] != 64'b0);

assign alu_exe_maskeqz_data[63:0] = mask_cmp_rst ? 
                                    alu_ex1_src0[63:0]
                                    : 64'b0;

assign alu_exe_masknez_data[63:0] = mask_cmp_rst ? 
                                    64'b0
                                    : alu_ex1_src0[63:0];



/// lu32i.d lu52i.d lu12i.w

// rj = src0
// rk = src1
// rd = src2

assign alu_exe_lu12i_data[63:0] = {{32{alu_ex1_opcode[24]}}, alu_ex1_opcode[24:5], 12'b0};

assign alu_exe_lu32i_data[63:0] = {{12{alu_ex1_opcode[24]}}, alu_ex1_opcode[24:5], 
                                    alu_ex1_src2[31:0]};

assign alu_exe_lu52i_data[63:0] = {alu_ex1_opcode[21:10], alu_ex1_src0[51:0]};



/// slt/slti
wire sltu; 
wire slts; 
wire [63:0] alu_ex1_slt_cmp_src1 = (alu_ex1_inst_sel[ALU_OPCODE_SLTI]
                                  || alu_ex1_inst_sel[ALU_OPCODE_SLTUI] )
                                  ? {{52{alu_ex1_opcode[21]}}, alu_ex1_opcode[21:10]}
                                  : alu_ex1_adder_src1[63:0];

assign sltu  =  alu_ex1_adder_src0[63:0] < alu_ex1_slt_cmp_src1[63:0];
assign slts  =  $signed(alu_ex1_adder_src0[63:0]) < $signed(alu_ex1_slt_cmp_src1[63:0]);

assign alu_exe_slt_data  [63:0] = {{63{1'b0}}, slts};
assign alu_exe_sltu_data [63:0] = {{63{1'b0}}, sltu};

assign alu_exe_slti_data  [63:0] =  {{63{1'b0}}, slts};
assign alu_exe_sltui_data [63:0] =  {{63{1'b0}}, sltu};


/// bstrpick.w/d

wire [4:0] msbw;
wire [4:0] lsbw;

wire [5:0] msbd;
wire [5:0] lsbd;

assign msbw[4:0] = alu_ex1_opcode[20:16];
assign lsbw[4:0] = alu_ex1_opcode[14:10];

assign msbd[5:0] = alu_ex1_opcode[21:16];
assign lsbd[5:0] = alu_ex1_opcode[15:10];


reg [31:0] lsbw_mask;

always @(*) begin
casez({lsbw[4:0]})
    5'd0:  lsbw_mask[31:0] = 32'b11111111111111111111111111111111;
    5'd1:  lsbw_mask[31:0] = 32'b11111111111111111111111111111110;
    5'd2:  lsbw_mask[31:0] = 32'b11111111111111111111111111111100;
    5'd3:  lsbw_mask[31:0] = 32'b11111111111111111111111111111000;
    5'd4:  lsbw_mask[31:0] = 32'b11111111111111111111111111110000;
    5'd5:  lsbw_mask[31:0] = 32'b11111111111111111111111111100000;
    5'd6:  lsbw_mask[31:0] = 32'b11111111111111111111111111000000;
    5'd7:  lsbw_mask[31:0] = 32'b11111111111111111111111110000000;
    5'd8:  lsbw_mask[31:0] = 32'b11111111111111111111111100000000;
    5'd9:  lsbw_mask[31:0] = 32'b11111111111111111111111000000000;
    5'd10: lsbw_mask[31:0] = 32'b11111111111111111111110000000000;
    5'd11: lsbw_mask[31:0] = 32'b11111111111111111111100000000000;
    5'd12: lsbw_mask[31:0] = 32'b11111111111111111111000000000000;
    5'd13: lsbw_mask[31:0] = 32'b11111111111111111110000000000000;
    5'd14: lsbw_mask[31:0] = 32'b11111111111111111100000000000000;
    5'd15: lsbw_mask[31:0] = 32'b11111111111111111000000000000000;
    5'd16: lsbw_mask[31:0] = 32'b11111111111111110000000000000000;
    5'd17: lsbw_mask[31:0] = 32'b11111111111111100000000000000000;
    5'd18: lsbw_mask[31:0] = 32'b11111111111111000000000000000000;
    5'd19: lsbw_mask[31:0] = 32'b11111111111110000000000000000000;
    5'd20: lsbw_mask[31:0] = 32'b11111111111100000000000000000000;
    5'd21: lsbw_mask[31:0] = 32'b11111111111000000000000000000000;
    5'd22: lsbw_mask[31:0] = 32'b11111111110000000000000000000000;
    5'd23: lsbw_mask[31:0] = 32'b11111111100000000000000000000000;
    5'd24: lsbw_mask[31:0] = 32'b11111111000000000000000000000000;
    5'd25: lsbw_mask[31:0] = 32'b11111110000000000000000000000000;
    5'd26: lsbw_mask[31:0] = 32'b11111100000000000000000000000000;
    5'd27: lsbw_mask[31:0] = 32'b11111000000000000000000000000000;
    5'd28: lsbw_mask[31:0] = 32'b11110000000000000000000000000000;
    5'd29: lsbw_mask[31:0] = 32'b11100000000000000000000000000000;
    5'd30: lsbw_mask[31:0] = 32'b11000000000000000000000000000000;
    5'd31: lsbw_mask[31:0] = 32'b10000000000000000000000000000000;
default: lsbw_mask[31:0] = {32{1'b0}};
endcase
end


reg [31:0] msbw_mask;
always @(*) begin
casez({msbw[4:0]})
    5'd0:  msbw_mask[31:0] = 32'b00000000000000000000000000000001;
    5'd1:  msbw_mask[31:0] = 32'b00000000000000000000000000000011;
    5'd2:  msbw_mask[31:0] = 32'b00000000000000000000000000000111;
    5'd3:  msbw_mask[31:0] = 32'b00000000000000000000000000001111;
    5'd4:  msbw_mask[31:0] = 32'b00000000000000000000000000011111;
    5'd5:  msbw_mask[31:0] = 32'b00000000000000000000000000111111;
    5'd6:  msbw_mask[31:0] = 32'b00000000000000000000000001111111;
    5'd7:  msbw_mask[31:0] = 32'b00000000000000000000000011111111;
    5'd8:  msbw_mask[31:0] = 32'b00000000000000000000000111111111;
    5'd9:  msbw_mask[31:0] = 32'b00000000000000000000001111111111;
    5'd10: msbw_mask[31:0] = 32'b00000000000000000000011111111111;
    5'd11: msbw_mask[31:0] = 32'b00000000000000000000111111111111;
    5'd12: msbw_mask[31:0] = 32'b00000000000000000001111111111111;
    5'd13: msbw_mask[31:0] = 32'b00000000000000000011111111111111;
    5'd14: msbw_mask[31:0] = 32'b00000000000000000111111111111111;
    5'd15: msbw_mask[31:0] = 32'b00000000000000001111111111111111;
    5'd16: msbw_mask[31:0] = 32'b00000000000000011111111111111111;
    5'd17: msbw_mask[31:0] = 32'b00000000000000111111111111111111;
    5'd18: msbw_mask[31:0] = 32'b00000000000001111111111111111111;
    5'd19: msbw_mask[31:0] = 32'b00000000000011111111111111111111;
    5'd20: msbw_mask[31:0] = 32'b00000000000111111111111111111111;
    5'd21: msbw_mask[31:0] = 32'b00000000001111111111111111111111;
    5'd22: msbw_mask[31:0] = 32'b00000000011111111111111111111111;
    5'd23: msbw_mask[31:0] = 32'b00000000111111111111111111111111;
    5'd24: msbw_mask[31:0] = 32'b00000001111111111111111111111111;
    5'd25: msbw_mask[31:0] = 32'b00000011111111111111111111111111;
    5'd26: msbw_mask[31:0] = 32'b00000111111111111111111111111111;
    5'd27: msbw_mask[31:0] = 32'b00001111111111111111111111111111;
    5'd28: msbw_mask[31:0] = 32'b00011111111111111111111111111111;
    5'd29: msbw_mask[31:0] = 32'b00111111111111111111111111111111;
    5'd30: msbw_mask[31:0] = 32'b01111111111111111111111111111111;
    5'd31: msbw_mask[31:0] = 32'b11111111111111111111111111111111;
default: msbw_mask[31:0] = {32{1'b0}};
endcase
end


wire [31:0]alu_exe_bstrpick_data_32;
wire [63:0]alu_exe_bstrpick_data_w;

assign alu_exe_bstrpick_data_32[31:0] = (alu_ex1_src0[31:0] & (msbw_mask & lsbw_mask)) >> lsbw;

assign alu_exe_bstrpick_data_w[63:0] = {{32{alu_exe_bstrpick_data_32[31]}}, alu_exe_bstrpick_data_32[31:0]};

// dword
reg [63:0] lsbd_mask;
always @(*) begin
casez({lsbd[5:0]})
    6'd0:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
    6'd1:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111110;
    6'd2:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111100;
    6'd3:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111000;
    6'd4:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111110000;
    6'd5:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111100000;
    6'd6:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111000000;
    6'd7:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111110000000;
    6'd8:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111100000000;
    6'd9:  lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111000000000;
    6'd10: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111110000000000;
    6'd11: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111100000000000;
    6'd12: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111000000000000;
    6'd13: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111110000000000000;
    6'd14: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111100000000000000;
    6'd15: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111000000000000000;
    6'd16: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111110000000000000000;
    6'd17: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111100000000000000000;
    6'd18: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111000000000000000000;
    6'd19: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111110000000000000000000;
    6'd20: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111100000000000000000000;
    6'd21: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111000000000000000000000;
    6'd22: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111110000000000000000000000;
    6'd23: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111100000000000000000000000;
    6'd24: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111111000000000000000000000000;
    6'd25: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111110000000000000000000000000;
    6'd26: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111100000000000000000000000000;
    6'd27: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111111000000000000000000000000000;
    6'd28: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111110000000000000000000000000000;
    6'd29: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111100000000000000000000000000000;
    6'd30: lsbd_mask[63:0] = 64'b1111111111111111111111111111111111000000000000000000000000000000;
    6'd31: lsbd_mask[63:0] = 64'b1111111111111111111111111111111110000000000000000000000000000000;
    6'd32: lsbd_mask[63:0] = 64'b1111111111111111111111111111111100000000000000000000000000000000;
    6'd33: lsbd_mask[63:0] = 64'b1111111111111111111111111111111000000000000000000000000000000000;
    6'd34: lsbd_mask[63:0] = 64'b1111111111111111111111111111110000000000000000000000000000000000;
    6'd35: lsbd_mask[63:0] = 64'b1111111111111111111111111111100000000000000000000000000000000000;
    6'd36: lsbd_mask[63:0] = 64'b1111111111111111111111111111000000000000000000000000000000000000;
    6'd37: lsbd_mask[63:0] = 64'b1111111111111111111111111110000000000000000000000000000000000000;
    6'd38: lsbd_mask[63:0] = 64'b1111111111111111111111111100000000000000000000000000000000000000;
    6'd39: lsbd_mask[63:0] = 64'b1111111111111111111111111000000000000000000000000000000000000000;
    6'd40: lsbd_mask[63:0] = 64'b1111111111111111111111110000000000000000000000000000000000000000;
    6'd41: lsbd_mask[63:0] = 64'b1111111111111111111111100000000000000000000000000000000000000000;
    6'd42: lsbd_mask[63:0] = 64'b1111111111111111111111000000000000000000000000000000000000000000;
    6'd43: lsbd_mask[63:0] = 64'b1111111111111111111110000000000000000000000000000000000000000000;
    6'd44: lsbd_mask[63:0] = 64'b1111111111111111111100000000000000000000000000000000000000000000;
    6'd45: lsbd_mask[63:0] = 64'b1111111111111111111000000000000000000000000000000000000000000000;
    6'd46: lsbd_mask[63:0] = 64'b1111111111111111110000000000000000000000000000000000000000000000;
    6'd47: lsbd_mask[63:0] = 64'b1111111111111111100000000000000000000000000000000000000000000000;
    6'd48: lsbd_mask[63:0] = 64'b1111111111111111000000000000000000000000000000000000000000000000;
    6'd49: lsbd_mask[63:0] = 64'b1111111111111110000000000000000000000000000000000000000000000000;
    6'd50: lsbd_mask[63:0] = 64'b1111111111111100000000000000000000000000000000000000000000000000;
    6'd51: lsbd_mask[63:0] = 64'b1111111111111000000000000000000000000000000000000000000000000000;
    6'd52: lsbd_mask[63:0] = 64'b1111111111110000000000000000000000000000000000000000000000000000;
    6'd53: lsbd_mask[63:0] = 64'b1111111111100000000000000000000000000000000000000000000000000000;
    6'd54: lsbd_mask[63:0] = 64'b1111111111000000000000000000000000000000000000000000000000000000;
    6'd55: lsbd_mask[63:0] = 64'b1111111110000000000000000000000000000000000000000000000000000000;
    6'd56: lsbd_mask[63:0] = 64'b1111111100000000000000000000000000000000000000000000000000000000;
    6'd57: lsbd_mask[63:0] = 64'b1111111000000000000000000000000000000000000000000000000000000000;
    6'd58: lsbd_mask[63:0] = 64'b1111110000000000000000000000000000000000000000000000000000000000;
    6'd59: lsbd_mask[63:0] = 64'b1111100000000000000000000000000000000000000000000000000000000000;
    6'd60: lsbd_mask[63:0] = 64'b1111000000000000000000000000000000000000000000000000000000000000;
    6'd61: lsbd_mask[63:0] = 64'b1110000000000000000000000000000000000000000000000000000000000000;
    6'd62: lsbd_mask[63:0] = 64'b1100000000000000000000000000000000000000000000000000000000000000;
    6'd63: lsbd_mask[63:0] = 64'b1000000000000000000000000000000000000000000000000000000000000000;
default: lsbd_mask[63:0] = {64{1'b0}};
endcase
end


reg [63:0] msbd_mask;
always @(*) begin
casez({msbd[5:0]})
    6'd0:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000000001;
    6'd1:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000000011;
    6'd2:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000000111;
    6'd3:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000001111;
    6'd4:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000011111;
    6'd5:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000000111111;
    6'd6:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000001111111;
    6'd7:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000011111111;
    6'd8:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000000111111111;
    6'd9:  msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000001111111111;
    6'd10: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000011111111111;
    6'd11: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000000111111111111;
    6'd12: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000001111111111111;
    6'd13: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000011111111111111;
    6'd14: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000000111111111111111;
    6'd15: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000001111111111111111;
    6'd16: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000011111111111111111;
    6'd17: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000000111111111111111111;
    6'd18: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000001111111111111111111;
    6'd19: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000011111111111111111111;
    6'd20: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000000111111111111111111111;
    6'd21: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000001111111111111111111111;
    6'd22: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000011111111111111111111111;
    6'd23: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000000111111111111111111111111;
    6'd24: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000001111111111111111111111111;
    6'd25: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000011111111111111111111111111;
    6'd26: msbd_mask[63:0] = 64'b0000000000000000000000000000000000000111111111111111111111111111;
    6'd27: msbd_mask[63:0] = 64'b0000000000000000000000000000000000001111111111111111111111111111;
    6'd28: msbd_mask[63:0] = 64'b0000000000000000000000000000000000011111111111111111111111111111;
    6'd29: msbd_mask[63:0] = 64'b0000000000000000000000000000000000111111111111111111111111111111;
    6'd30: msbd_mask[63:0] = 64'b0000000000000000000000000000000001111111111111111111111111111111;
    6'd31: msbd_mask[63:0] = 64'b0000000000000000000000000000000011111111111111111111111111111111;
    6'd32: msbd_mask[63:0] = 64'b0000000000000000000000000000000111111111111111111111111111111111;
    6'd33: msbd_mask[63:0] = 64'b0000000000000000000000000000001111111111111111111111111111111111;
    6'd34: msbd_mask[63:0] = 64'b0000000000000000000000000000011111111111111111111111111111111111;
    6'd35: msbd_mask[63:0] = 64'b0000000000000000000000000000111111111111111111111111111111111111;
    6'd36: msbd_mask[63:0] = 64'b0000000000000000000000000001111111111111111111111111111111111111;
    6'd37: msbd_mask[63:0] = 64'b0000000000000000000000000011111111111111111111111111111111111111;
    6'd38: msbd_mask[63:0] = 64'b0000000000000000000000000111111111111111111111111111111111111111;
    6'd39: msbd_mask[63:0] = 64'b0000000000000000000000001111111111111111111111111111111111111111;
    6'd40: msbd_mask[63:0] = 64'b0000000000000000000000011111111111111111111111111111111111111111;
    6'd41: msbd_mask[63:0] = 64'b0000000000000000000000111111111111111111111111111111111111111111;
    6'd42: msbd_mask[63:0] = 64'b0000000000000000000001111111111111111111111111111111111111111111;
    6'd43: msbd_mask[63:0] = 64'b0000000000000000000011111111111111111111111111111111111111111111;
    6'd44: msbd_mask[63:0] = 64'b0000000000000000000111111111111111111111111111111111111111111111;
    6'd45: msbd_mask[63:0] = 64'b0000000000000000001111111111111111111111111111111111111111111111;
    6'd46: msbd_mask[63:0] = 64'b0000000000000000011111111111111111111111111111111111111111111111;
    6'd47: msbd_mask[63:0] = 64'b0000000000000000111111111111111111111111111111111111111111111111;
    6'd48: msbd_mask[63:0] = 64'b0000000000000001111111111111111111111111111111111111111111111111;
    6'd49: msbd_mask[63:0] = 64'b0000000000000011111111111111111111111111111111111111111111111111;
    6'd50: msbd_mask[63:0] = 64'b0000000000000111111111111111111111111111111111111111111111111111;
    6'd51: msbd_mask[63:0] = 64'b0000000000001111111111111111111111111111111111111111111111111111;
    6'd52: msbd_mask[63:0] = 64'b0000000000011111111111111111111111111111111111111111111111111111;
    6'd53: msbd_mask[63:0] = 64'b0000000000111111111111111111111111111111111111111111111111111111;
    6'd54: msbd_mask[63:0] = 64'b0000000001111111111111111111111111111111111111111111111111111111;
    6'd55: msbd_mask[63:0] = 64'b0000000011111111111111111111111111111111111111111111111111111111;
    6'd56: msbd_mask[63:0] = 64'b0000000111111111111111111111111111111111111111111111111111111111;
    6'd57: msbd_mask[63:0] = 64'b0000001111111111111111111111111111111111111111111111111111111111;
    6'd58: msbd_mask[63:0] = 64'b0000011111111111111111111111111111111111111111111111111111111111;
    6'd59: msbd_mask[63:0] = 64'b0000111111111111111111111111111111111111111111111111111111111111;
    6'd60: msbd_mask[63:0] = 64'b0001111111111111111111111111111111111111111111111111111111111111;
    6'd61: msbd_mask[63:0] = 64'b0011111111111111111111111111111111111111111111111111111111111111;
    6'd62: msbd_mask[63:0] = 64'b0111111111111111111111111111111111111111111111111111111111111111;
    6'd63: msbd_mask[63:0] = 64'b1111111111111111111111111111111111111111111111111111111111111111;
default: msbd_mask[63:0] = {64{1'b0}};
endcase
end

wire [63:0]alu_exe_bstrpick_data_d;

assign alu_exe_bstrpick_data_d[63:0] = (alu_ex1_src0[63:0] & (msbd_mask & lsbd_mask)) >> lsbd;


wire is_bstrpick_w  = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_bstrpick_d  = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

assign alu_exe_bstrpick_data[63:0] = {64{is_bstrpick_w}} & alu_exe_bstrpick_data_w |
                                     {64{is_bstrpick_d}} & alu_exe_bstrpick_data_d;

/// alsl.w/d

wire [63:0]alu_exe_alsl_data_w;
wire [63:0]alu_exe_alsl_data_wu;
wire [31:0]alu_exe_alsl_data_w_32;
wire [63:0]alu_exe_alsl_data_d;

wire [2:0] al_sa2 = alu_ex1_opcode[16:15] + 1'b1;

assign alu_exe_alsl_data_w_32[31:0] = {alu_ex1_src0[31:0] << al_sa2[2:0]} + alu_ex1_src1[31:0];
assign alu_exe_alsl_data_w = {{32{alu_exe_alsl_data_w_32[31]}}, alu_exe_alsl_data_w_32[31:0]};
assign alu_exe_alsl_data_wu = {{32{1'b0}}, alu_exe_alsl_data_w_32[31:0]};

assign alu_exe_alsl_data_d = {alu_ex1_src0[63:0] << al_sa2} + alu_ex1_src1[63:0];


wire is_alsl_w;
wire is_alsl_wu;
wire is_alsl_d;

assign is_alsl_w  = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
assign is_alsl_wu = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_WU);
assign is_alsl_d  = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

assign alu_exe_alsl_data[63:0] = 
              {64{is_alsl_w }} & alu_exe_alsl_data_w  |
              {64{is_alsl_wu}} & alu_exe_alsl_data_wu |
              {64{is_alsl_d }} & alu_exe_alsl_data_d;



/// slli.w/d
/// sll.w/d

wire [4:0] ui5 = alu_ex1_opcode[14:10]; 
wire [5:0] ui6 = alu_ex1_opcode[15:10];


wire is_sll_w  = alu_ex1_inst_sel[ALU_OPCODE_SLL] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_sll_d  = alu_ex1_inst_sel[ALU_OPCODE_SLL] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);
wire is_slli_w = alu_ex1_inst_sel[ALU_OPCODE_SLLI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_slli_d = alu_ex1_inst_sel[ALU_OPCODE_SLLI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [31:0] is_slli_w_data_32 = alu_ex1_src0[31:0] << ui5;
wire [63:0] is_slli_w_data = {{32{is_slli_w_data_32[31]}}, is_slli_w_data_32[31:0]};
wire [63:0] is_slli_d_data = {alu_ex1_src0[63:0] << ui6};

wire [31:0] is_sll_w_data_32 = alu_ex1_src0[31:0] << alu_ex1_src1[4:0];
wire [63:0] is_sll_w_data = {{32{is_sll_w_data_32[31]}}, is_sll_w_data_32[31:0]};
wire [63:0] is_sll_d_data = {alu_ex1_src0[63:0] << alu_ex1_src1[5:0]};

assign alu_exe_sll_data[63:0] = 
                {64{is_sll_w}} & is_sll_w_data | 
                {64{is_sll_d}} & is_sll_d_data;

assign alu_exe_slli_data[63:0] = 
                {64{is_slli_w}} & is_slli_w_data | 
                {64{is_slli_d}} & is_slli_d_data;



/// andi ori xori
wire [63:0] imm12_add_data =  {{52{1'b0}}, alu_ex1_opcode[21:10]};

assign alu_exe_andi_data[63:0] = alu_ex1_src0[63:0] & imm12_add_data;
assign alu_exe_ori_data [63:0] = alu_ex1_src0[63:0] | imm12_add_data;
assign alu_exe_xori_data[63:0] = alu_ex1_src0[63:0] ^ imm12_add_data;




/// srl
wire is_srl_w  = alu_ex1_inst_sel[ALU_OPCODE_SRL] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_srl_d  = alu_ex1_inst_sel[ALU_OPCODE_SRL] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);
wire is_srli_w = alu_ex1_inst_sel[ALU_OPCODE_SRLI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_srli_d = alu_ex1_inst_sel[ALU_OPCODE_SRLI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [31:0] is_srli_w_data_32 = alu_ex1_src0[31:0] >> ui5;
wire [63:0] is_srli_w_data = {{32{is_srli_w_data_32[31]}}, is_srli_w_data_32[31:0]};
wire [63:0] is_srli_d_data = {alu_ex1_src0[63:0] >> ui6};

wire [31:0] is_srl_w_data_32 = alu_ex1_src0[31:0] >> alu_ex1_src1[4:0];
wire [63:0] is_srl_w_data = {{32{is_srl_w_data_32[31]}}, is_srl_w_data_32[31:0]};
wire [63:0] is_srl_d_data = {alu_ex1_src0[63:0] >> alu_ex1_src1[5:0]};

assign alu_exe_srl_data[63:0] = 
                {64{is_srl_w}} & is_srl_w_data | 
                {64{is_srl_d}} & is_srl_d_data;

assign alu_exe_srli_data[63:0] = 
                {64{is_srli_w}} & is_srli_w_data | 
                {64{is_srli_d}} & is_srli_d_data;


/// sra.w/d srai.w/d 

wire is_sra_w =  alu_ex1_inst_sel[ALU_OPCODE_SRA] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_sra_d =  alu_ex1_inst_sel[ALU_OPCODE_SRA] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);
wire is_srai_w = alu_ex1_inst_sel[ALU_OPCODE_SRAI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_srai_d = alu_ex1_inst_sel[ALU_OPCODE_SRAI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [63:0] srai_w_data = {{32{alu_ex1_src0[31]}}, alu_ex1_src0[31:0]}; 

wire [63:0] is_srai_w_data_32 = srai_w_data[63:0] >> ui5;
wire [63:0] is_srai_w_data = {{32{is_srai_w_data_32[31]}}, is_srai_w_data_32[31:0]};

wire [127:0] srai_d_data = {{64{alu_ex1_src0[63]}}, alu_ex1_src0[63:0]};
wire [127:0] is_srai_d_data_t = {srai_d_data[127:0] >> ui6};
wire [63:0] is_srai_d_data = is_srai_d_data_t[63:0];

wire [63:0] is_sra_w_data_32 = srai_w_data[63:0] >> alu_ex1_src1[4:0];
wire [63:0] is_sra_w_data = {{32{is_sra_w_data_32[31]}}, is_sra_w_data_32[31:0]};

wire [127:0] is_sra_d_data_t = {srai_d_data[127:0] >> alu_ex1_src1[5:0]};
wire [63:0] is_sra_d_data = is_sra_d_data_t[63:0];

assign alu_exe_sra_data[63:0] = 
                {64{is_sra_w}} & is_sra_w_data | 
                {64{is_sra_d}} & is_sra_d_data;

assign alu_exe_srai_data[63:0] = 
                {64{is_srai_w}} & is_srai_w_data | 
                {64{is_srai_d}} & is_srai_d_data;


/// rotr.w/d rotri.w/d
wire is_rotr_w  = alu_ex1_inst_sel[ALU_OPCODE_ROTR] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_rotr_d  = alu_ex1_inst_sel[ALU_OPCODE_ROTR] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);
wire is_rotri_w = alu_ex1_inst_sel[ALU_OPCODE_ROTRI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_rotri_d = alu_ex1_inst_sel[ALU_OPCODE_ROTRI] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [63:0] is_rotri_w_data_64 = {alu_ex1_src0[31:0], alu_ex1_src0[31:0]} >> ui5;
wire [63:0] is_rotri_w_data = {{32{is_rotri_w_data_64[31]}}, is_rotri_w_data_64[31:0]};

wire [127:0] is_rotri_d_data_128 = {alu_ex1_src0[63:0], alu_ex1_src0[63:0]} >> ui6;
wire [63:0]  is_rotri_d_data = is_rotri_d_data_128[63:0];

wire [63:0] is_rotr_w_data_64 = {alu_ex1_src0[31:0], alu_ex1_src0[31:0]} >> alu_ex1_src1[4:0];
wire [63:0] is_rotr_w_data = {{32{is_rotr_w_data_64[31]}}, is_rotr_w_data_64[31:0]};

wire [127:0] is_rotr_d_data_128 = {alu_ex1_src0[63:0], alu_ex1_src0[63:0]} >> alu_ex1_src1[5:0];
wire [63:0] is_rotr_d_data = is_rotr_d_data_128[63:0];

assign alu_exe_rotr_data[63:0] = 
                {64{is_rotr_w}} & is_rotr_w_data | 
                {64{is_rotr_d}} & is_rotr_d_data;

assign alu_exe_rotri_data[63:0] = 
                {64{is_rotri_w}} & is_rotri_w_data | 
                {64{is_rotri_d}} & is_rotri_d_data;


/// sub.w/d
wire is_sub_w = alu_ex1_inst_sel[ALU_OPCODE_SUB] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_sub_d = alu_ex1_inst_sel[ALU_OPCODE_SUB] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [31:0] is_sub_w_data_32 = alu_ex1_src0[31:0] - alu_ex1_src1[31:0];
wire [63:0] is_sub_w_data = {{32{is_sub_w_data_32[31]}}, is_sub_w_data_32[31:0]};
wire [63:0] is_sub_d_data = {alu_ex1_src0[63:0] - alu_ex1_src1[63:0]}; 


assign alu_exe_sub_data[63:0] = 
                {64{is_sub_w}} & is_sub_w_data | 
                {64{is_sub_d}} & is_sub_d_data;


/// ext.w.b/h
wire is_extw_b = alu_ex1_inst_sel[ALU_OPCODE_EXT] && (alu_ex1_func[4:0] == 5'b00001);
wire is_extw_h = alu_ex1_inst_sel[ALU_OPCODE_EXT] && (alu_ex1_func[4:0] == 5'b00010);


wire [63:0] is_extw_b_data = {{56{alu_ex1_src0[7]}}, alu_ex1_src0[7:0]};
wire [63:0] is_extw_h_data = {{48{alu_ex1_src0[15]}}, alu_ex1_src0[15:0]};

assign alu_exe_ext_data[63:0] = 
                {64{is_extw_b}} & is_extw_b_data | 
                {64{is_extw_h}} & is_extw_h_data;



/// bytepick.w/d
wire is_bytepick_w = alu_ex1_inst_sel[ALU_OPCODE_BYTEPICK] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_bytepick_d = alu_ex1_inst_sel[ALU_OPCODE_BYTEPICK] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [1:0] bytepick_sa2 = alu_ex1_opcode[16:15];
wire [2:0] bytepick_sa3 = alu_ex1_opcode[17:15];

wire [63:0] is_bytepick_w_data_64   = {alu_ex1_src1[31:0], alu_ex1_src0[31:0]};
wire [127:0] is_bytepick_d_data_128 = {alu_ex1_src1[63:0], alu_ex1_src0[63:0]};

reg [31:0] is_bytepick_w_data_r;
reg [63:0] is_bytepick_d_data_r;


always @(is_bytepick_w_data_64[63:0]
        or bytepick_sa2[1:0]) begin
casez({bytepick_sa2[1:0]})
    2'b00 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[63:32];
    2'b01 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[55:24];
    2'b10 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[47:16];
    2'b11 : is_bytepick_w_data_r[31:0] = is_bytepick_w_data_64[39: 8];
endcase
end
wire [63:0] is_bytepick_w_data = {{32{is_bytepick_w_data_r[31]}}, is_bytepick_w_data_r[31:0]};


always @(is_bytepick_d_data_128[127:0]
         or bytepick_sa3[2:0]) begin
casez({bytepick_sa3[2:0]})
    3'b000 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[127:64];
    3'b001 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[119:56];
    3'b010 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[111:48];
    3'b011 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[103:40];
    3'b100 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 95:32];
    3'b101 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 87:24];
    3'b110 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 79:16];
    3'b111 : is_bytepick_d_data_r[63:0] = is_bytepick_d_data_128[ 71: 8];
endcase
end
wire [63:0] is_bytepick_d_data = is_bytepick_d_data_r[63:0];

assign alu_exe_bytepick_data[63:0] = 
                                    {64{is_bytepick_w}} & is_bytepick_w_data | 
                                    {64{is_bytepick_d}} & is_bytepick_d_data;


/// nor 
wire [63:0] logic_nor_rslt;
assign logic_nor_rslt[63:0]   = ~(alu_ex1_src0[63:0] | alu_ex1_src1[63:0]);
assign alu_exe_nor_data[63:0] = logic_nor_rslt[63:0];


/// orn/ andn
assign alu_exe_orn_data[63:0]  = alu_ex1_src0[63:0] | (~alu_ex1_src1[63:0]);
assign alu_exe_andn_data[63:0] = alu_ex1_src0[63:0] & (~alu_ex1_src1[63:0]);



/// bstrins.w/d
wire is_bstrins_w = alu_ex1_inst_sel[ALU_OPCODE_BSTRINS] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_bstrins_d = alu_ex1_inst_sel[ALU_OPCODE_BSTRINS] && (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [31:0] bstrins_w_mask       = msbw_mask & lsbw_mask;
wire [31:0] bstrins_w_mask_shift = bstrins_w_mask >> lsbw;
wire [63:0] bstrins_d_mask       = msbd_mask & lsbd_mask;
wire [63:0] bstrins_d_mask_shift = bstrins_d_mask >> lsbd;

wire [31:0] is_bstrins_w_data_32 = ((alu_ex1_src0[31:0] &  bstrins_w_mask_shift) << lsbw) |  
                                     alu_ex1_src2[31:0] & ~bstrins_w_mask;

wire [63:0] is_bstrins_w_data = {{32{is_bstrins_w_data_32[31]}}, is_bstrins_w_data_32[31:0]};

wire [63:0] is_bstrins_d_data = ((alu_ex1_src0[63:0] & bstrins_d_mask_shift) << lsbd)  |  
                                  alu_ex1_src2[63:0] & ~bstrins_d_mask;

assign alu_exe_bstrins_data[63:0] = 
                                    {64{is_bstrins_w}} & is_bstrins_w_data | 
                                    {64{is_bstrins_d}} & is_bstrins_d_data;



/// bitrev.4b/8b
wire is_bitrev4b = alu_ex1_inst_sel[ALU_OPCODE_BITREV] && (alu_ex1_func[4:0] == 5'b00001);
wire is_bitrev8b = alu_ex1_inst_sel[ALU_OPCODE_BITREV] && (alu_ex1_func[4:0] == 5'b00010);
wire is_bitrevw  = alu_ex1_inst_sel[ALU_OPCODE_BITREV] && (alu_ex1_func[4:0] == 5'b00100);
wire is_bitrevd  = alu_ex1_inst_sel[ALU_OPCODE_BITREV] && (alu_ex1_func[4:0] == 5'b01000);

wire [63:0] bitrev_src0 = alu_ex1_src0[63:0];

wire [7:0] bitrev_7 = {bitrev_src0[56], bitrev_src0[57], bitrev_src0[58], bitrev_src0[59], bitrev_src0[60], bitrev_src0[61], bitrev_src0[62], bitrev_src0[63]};
wire [7:0] bitrev_6 = {bitrev_src0[48], bitrev_src0[49], bitrev_src0[50], bitrev_src0[51], bitrev_src0[52], bitrev_src0[53], bitrev_src0[54], bitrev_src0[55]};
wire [7:0] bitrev_5 = {bitrev_src0[40], bitrev_src0[41], bitrev_src0[42], bitrev_src0[43], bitrev_src0[44], bitrev_src0[45], bitrev_src0[46], bitrev_src0[47]};
wire [7:0] bitrev_4 = {bitrev_src0[32], bitrev_src0[33], bitrev_src0[34], bitrev_src0[35], bitrev_src0[36], bitrev_src0[37], bitrev_src0[38], bitrev_src0[39]};

wire [7:0] bitrev_3 = {bitrev_src0[24], bitrev_src0[25], bitrev_src0[26], bitrev_src0[27], bitrev_src0[28], bitrev_src0[29], bitrev_src0[30], bitrev_src0[31]};
wire [7:0] bitrev_2 = {bitrev_src0[16], bitrev_src0[17], bitrev_src0[18], bitrev_src0[19], bitrev_src0[20], bitrev_src0[21], bitrev_src0[22], bitrev_src0[23]};
wire [7:0] bitrev_1 = {bitrev_src0[ 8], bitrev_src0[ 9], bitrev_src0[10], bitrev_src0[11], bitrev_src0[12], bitrev_src0[13], bitrev_src0[14], bitrev_src0[15]};
wire [7:0] bitrev_0 = {bitrev_src0[ 0], bitrev_src0[ 1], bitrev_src0[ 2], bitrev_src0[ 3], bitrev_src0[ 4], bitrev_src0[ 5], bitrev_src0[ 6], bitrev_src0[ 7]};

wire [63:0] is_bitrev4b_data = {{32{bitrev_3[7]}}, bitrev_3, bitrev_2, bitrev_1, bitrev_0};
wire [63:0] is_bitrev8b_data = {bitrev_7, bitrev_6, bitrev_5, bitrev_4, bitrev_3, bitrev_2, bitrev_1, bitrev_0};

wire [31:0] bitrev32_0 = {
                          bitrev_src0[ 0], bitrev_src0[ 1], bitrev_src0[ 2], bitrev_src0[ 3], bitrev_src0[ 4], bitrev_src0[ 5], bitrev_src0[ 6], bitrev_src0[ 7],
                          bitrev_src0[ 8], bitrev_src0[ 9], bitrev_src0[10], bitrev_src0[11], bitrev_src0[12], bitrev_src0[13], bitrev_src0[14], bitrev_src0[15],
                          bitrev_src0[16], bitrev_src0[17], bitrev_src0[18], bitrev_src0[19], bitrev_src0[20], bitrev_src0[21], bitrev_src0[22], bitrev_src0[23],
                          bitrev_src0[24], bitrev_src0[25], bitrev_src0[26], bitrev_src0[27], bitrev_src0[28], bitrev_src0[29], bitrev_src0[30], bitrev_src0[31]};

wire [63:0] is_bitrevw_data = {{32{bitrev32_0[31]}}, bitrev32_0};

wire [63:0] bitrev64_0 = {
                          bitrev_src0[ 0], bitrev_src0[ 1], bitrev_src0[ 2], bitrev_src0[ 3], bitrev_src0[ 4], bitrev_src0[ 5], bitrev_src0[ 6], bitrev_src0[ 7],
                          bitrev_src0[ 8], bitrev_src0[ 9], bitrev_src0[10], bitrev_src0[11], bitrev_src0[12], bitrev_src0[13], bitrev_src0[14], bitrev_src0[15],
                          bitrev_src0[16], bitrev_src0[17], bitrev_src0[18], bitrev_src0[19], bitrev_src0[20], bitrev_src0[21], bitrev_src0[22], bitrev_src0[23],
                          bitrev_src0[24], bitrev_src0[25], bitrev_src0[26], bitrev_src0[27], bitrev_src0[28], bitrev_src0[29], bitrev_src0[30], bitrev_src0[31],
                          bitrev_src0[32], bitrev_src0[33], bitrev_src0[34], bitrev_src0[35], bitrev_src0[36], bitrev_src0[37], bitrev_src0[38], bitrev_src0[39],
                          bitrev_src0[40], bitrev_src0[41], bitrev_src0[42], bitrev_src0[43], bitrev_src0[44], bitrev_src0[45], bitrev_src0[46], bitrev_src0[47],
                          bitrev_src0[48], bitrev_src0[49], bitrev_src0[50], bitrev_src0[51], bitrev_src0[52], bitrev_src0[53], bitrev_src0[54], bitrev_src0[55],
                          bitrev_src0[56], bitrev_src0[57], bitrev_src0[58], bitrev_src0[59], bitrev_src0[60], bitrev_src0[61], bitrev_src0[62], bitrev_src0[63]};

wire [63:0] is_bitrevd_data = bitrev64_0;

assign alu_exe_bitrev_data[63:0] = 
                              {64{is_bitrev4b}} & is_bitrev4b_data[63:0] |
                              {64{is_bitrev8b}} & is_bitrev8b_data[63:0] |
                              {64{is_bitrevw }} & is_bitrevw_data[63:0]  |
                              {64{is_bitrevd }} & is_bitrevd_data[63:0];



/// revb, revh
wire is_revb_2h = alu_ex1_inst_sel[ALU_OPCODE_REV] && (alu_ex1_func[4:0] == 5'b00000);
wire is_revb_4h = alu_ex1_inst_sel[ALU_OPCODE_REV] && (alu_ex1_func[4:0] == 5'b00001);
wire is_revb_2w = alu_ex1_inst_sel[ALU_OPCODE_REV] && (alu_ex1_func[4:0] == 5'b00010);
wire is_revb_d  = alu_ex1_inst_sel[ALU_OPCODE_REV] && (alu_ex1_func[4:0] == 5'b00011);
wire is_revh_2w = alu_ex1_inst_sel[ALU_OPCODE_REV] && (alu_ex1_func[4:0] == 5'b00110);
wire is_revh_d  = alu_ex1_inst_sel[ALU_OPCODE_REV] && (alu_ex1_func[4:0] == 5'b00111);

wire [63:0] revb_src0 = alu_ex1_src0[63:0];

wire [7:0] revb_0 = revb_src0[7:0];
wire [7:0] revb_1 = revb_src0[15:8];
wire [7:0] revb_2 = revb_src0[23:16];
wire [7:0] revb_3 = revb_src0[31:24];

wire [7:0] revb_4 = revb_src0[39:32];
wire [7:0] revb_5 = revb_src0[47:40];
wire [7:0] revb_6 = revb_src0[55:48];
wire [7:0] revb_7 = revb_src0[63:56];

wire [63:0] is_revb_2h_data = {{32{revb_2[7]}}, revb_2, revb_3, revb_0, revb_1};
wire [63:0] is_revb_4h_data = {revb_6, revb_7, revb_4, revb_5, revb_2, revb_3, revb_0, revb_1};
wire [63:0] is_revb_2w_data = {revb_4, revb_5, revb_6, revb_7, revb_0, revb_1, revb_2, revb_3};
wire [63:0] is_revb_d_data  = {revb_0, revb_1, revb_2, revb_3, revb_4, revb_5, revb_6, revb_7};


wire [15:0] revh_0 = revb_src0[15:0];
wire [15:0] revh_1 = revb_src0[31:16];

wire [15:0] revh_2 = revb_src0[47:32];
wire [15:0] revh_3 = revb_src0[63:48];

wire [63:0] is_revh_2w_data = {revh_2, revh_3, revh_0, revh_1};
wire [63:0] is_revh_d_data  = {revh_0, revh_1, revh_2, revh_3};

assign alu_exe_rev_data[63:0] = 
                              {64{is_revb_2h}} & is_revb_2h_data[63:0] |
                              {64{is_revb_4h}} & is_revb_4h_data[63:0] |
                              {64{is_revb_2w}} & is_revb_2w_data[63:0] |
                              {64{is_revb_d }} & is_revb_d_data[63:0]  |
                              {64{is_revh_2w}} & is_revh_2w_data[63:0] |
                              {64{is_revh_d }} & is_revh_d_data[63:0];


/// clo
wire is_count_w = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_W);
wire is_count_d = (alu_ex1_func[4:0] == ALU_FN_SUBCODE_SEL_D);

wire [63:0] count_src     = alu_ex1_src0[63:0];
wire [63:0] count_rev_src = bitrev64_0[63:0];


wire is_count_one  = alu_ex1_inst_sel[ALU_OPCODE_CLO] || alu_ex1_inst_sel[ALU_OPCODE_CTO];
wire is_count_zero = alu_ex1_inst_sel[ALU_OPCODE_CLZ] || alu_ex1_inst_sel[ALU_OPCODE_CTZ];

wire is_right_left = alu_ex1_inst_sel[ALU_OPCODE_CLO] || alu_ex1_inst_sel[ALU_OPCODE_CLZ];
wire is_left_right = alu_ex1_inst_sel[ALU_OPCODE_CTO] || alu_ex1_inst_sel[ALU_OPCODE_CTZ];


wire [63:0] count_ffx_src;

assign count_ffx_src[63:0] = 
                            {64{is_count_one   & is_right_left & is_count_d }} & (~count_src[63:0])     |
                            {64{is_count_one   & is_right_left & is_count_w }} & (~{{32{1'b1}}, count_src[31:0]})     |
                            {64{is_count_one   & is_left_right & is_count_d }} & (~count_rev_src[63:0]) |
                            {64{is_count_one   & is_left_right & is_count_w }} & (~count_rev_src[63:0]) |
                            {64{is_count_zero  & is_right_left & is_count_d }} &  count_src[63:0]       |
                            {64{is_count_zero  & is_right_left & is_count_w }} &  {{32{1'b0}}, count_src[31:0]}       |
                            {64{is_count_zero  & is_left_right & is_count_d }} &  count_rev_src[63:0]   |
                            {64{is_count_zero  & is_left_right & is_count_w }} &  count_rev_src[63:0];

reg [63:0] count_ff0_rslt;
always @( count_ffx_src[63:0])
begin
  casez(count_ffx_src[63:0])
    64'b1???????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd0;
    64'b01??????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd1;
    64'b001?????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd2;
    64'b0001????????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd3;
    64'b00001???????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd4;
    64'b000001??????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd5;
    64'b0000001?????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd6;
    64'b00000001????????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd7;
    64'b000000001???????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd8;
    64'b0000000001??????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd9;
    64'b00000000001?????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd10;
    64'b000000000001????????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd11;
    64'b0000000000001???????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd12;
    64'b00000000000001??????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd13;
    64'b000000000000001?????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd14;
    64'b0000000000000001????????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd15;
    64'b00000000000000001???????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd16;
    64'b000000000000000001??????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd17;
    64'b0000000000000000001?????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd18;
    64'b00000000000000000001????????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd19;
    64'b000000000000000000001???????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd20;
    64'b0000000000000000000001??????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd21;
    64'b00000000000000000000001?????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd22;
    64'b000000000000000000000001????????????????????????????????????????: count_ff0_rslt[63:0] = 64'd23;
    64'b0000000000000000000000001???????????????????????????????????????: count_ff0_rslt[63:0] = 64'd24;
    64'b00000000000000000000000001??????????????????????????????????????: count_ff0_rslt[63:0] = 64'd25;
    64'b000000000000000000000000001?????????????????????????????????????: count_ff0_rslt[63:0] = 64'd26;
    64'b0000000000000000000000000001????????????????????????????????????: count_ff0_rslt[63:0] = 64'd27;
    64'b00000000000000000000000000001???????????????????????????????????: count_ff0_rslt[63:0] = 64'd28;
    64'b000000000000000000000000000001??????????????????????????????????: count_ff0_rslt[63:0] = 64'd29;
    64'b0000000000000000000000000000001?????????????????????????????????: count_ff0_rslt[63:0] = 64'd30;
    64'b00000000000000000000000000000001????????????????????????????????: count_ff0_rslt[63:0] = 64'd31;
    64'b000000000000000000000000000000001???????????????????????????????: count_ff0_rslt[63:0] = 64'd32;
    64'b0000000000000000000000000000000001??????????????????????????????: count_ff0_rslt[63:0] = 64'd33;
    64'b00000000000000000000000000000000001?????????????????????????????: count_ff0_rslt[63:0] = 64'd34;
    64'b000000000000000000000000000000000001????????????????????????????: count_ff0_rslt[63:0] = 64'd35;
    64'b0000000000000000000000000000000000001???????????????????????????: count_ff0_rslt[63:0] = 64'd36;
    64'b00000000000000000000000000000000000001??????????????????????????: count_ff0_rslt[63:0] = 64'd37;
    64'b000000000000000000000000000000000000001?????????????????????????: count_ff0_rslt[63:0] = 64'd38;
    64'b0000000000000000000000000000000000000001????????????????????????: count_ff0_rslt[63:0] = 64'd39;
    64'b00000000000000000000000000000000000000001???????????????????????: count_ff0_rslt[63:0] = 64'd40;
    64'b000000000000000000000000000000000000000001??????????????????????: count_ff0_rslt[63:0] = 64'd41;
    64'b0000000000000000000000000000000000000000001?????????????????????: count_ff0_rslt[63:0] = 64'd42;
    64'b00000000000000000000000000000000000000000001????????????????????: count_ff0_rslt[63:0] = 64'd43;
    64'b000000000000000000000000000000000000000000001???????????????????: count_ff0_rslt[63:0] = 64'd44;
    64'b0000000000000000000000000000000000000000000001??????????????????: count_ff0_rslt[63:0] = 64'd45;
    64'b00000000000000000000000000000000000000000000001?????????????????: count_ff0_rslt[63:0] = 64'd46;
    64'b000000000000000000000000000000000000000000000001????????????????: count_ff0_rslt[63:0] = 64'd47;
    64'b0000000000000000000000000000000000000000000000001???????????????: count_ff0_rslt[63:0] = 64'd48;
    64'b00000000000000000000000000000000000000000000000001??????????????: count_ff0_rslt[63:0] = 64'd49;
    64'b000000000000000000000000000000000000000000000000001?????????????: count_ff0_rslt[63:0] = 64'd50;
    64'b0000000000000000000000000000000000000000000000000001????????????: count_ff0_rslt[63:0] = 64'd51;
    64'b00000000000000000000000000000000000000000000000000001???????????: count_ff0_rslt[63:0] = 64'd52;
    64'b000000000000000000000000000000000000000000000000000001??????????: count_ff0_rslt[63:0] = 64'd53;
    64'b0000000000000000000000000000000000000000000000000000001?????????: count_ff0_rslt[63:0] = 64'd54;
    64'b00000000000000000000000000000000000000000000000000000001????????: count_ff0_rslt[63:0] = 64'd55;
    64'b000000000000000000000000000000000000000000000000000000001???????: count_ff0_rslt[63:0] = 64'd56;
    64'b0000000000000000000000000000000000000000000000000000000001??????: count_ff0_rslt[63:0] = 64'd57;
    64'b00000000000000000000000000000000000000000000000000000000001?????: count_ff0_rslt[63:0] = 64'd58;
    64'b000000000000000000000000000000000000000000000000000000000001????: count_ff0_rslt[63:0] = 64'd59;
    64'b0000000000000000000000000000000000000000000000000000000000001???: count_ff0_rslt[63:0] = 64'd60;
    64'b00000000000000000000000000000000000000000000000000000000000001??: count_ff0_rslt[63:0] = 64'd61;
    64'b000000000000000000000000000000000000000000000000000000000000001?: count_ff0_rslt[63:0] = 64'd62;
    64'b0000000000000000000000000000000000000000000000000000000000000001: count_ff0_rslt[63:0] = 64'd63;
    64'b0000000000000000000000000000000000000000000000000000000000000000: count_ff0_rslt[63:0] = 64'd64;
    default:                                                              count_ff0_rslt[63:0] = {64{1'bx}};
  endcase
// &CombEnd; @643
end

wire [63:0] clo_w_data = (count_ff0_rslt <= 0) ? 64'd0   :  count_ff0_rslt - 8'd32;
wire [63:0] clo_d_data = count_ff0_rslt;
wire [63:0] cto_w_data = (count_ff0_rslt >= 32) ? 64'd32 :  count_ff0_rslt;
wire [63:0] cto_d_data = count_ff0_rslt;

assign alu_exe_clo_data[63:0] = 
                            {64{is_count_one & is_right_left & is_count_w }} & clo_w_data  |
                            {64{is_count_one & is_right_left & is_count_d }} & clo_d_data;

assign alu_exe_cto_data[63:0] =                            
                            {64{is_count_one & is_left_right & is_count_w }} & cto_w_data  |
                            {64{is_count_one & is_left_right & is_count_d }} & cto_d_data;



wire [63:0] clz_w_data = (count_ff0_rslt <= 0) ? 64'd0   :  count_ff0_rslt - 8'd32;
wire [63:0] clz_d_data = count_ff0_rslt;
wire [63:0] ctz_w_data = (count_ff0_rslt >= 32) ? 64'd32 :  count_ff0_rslt;
wire [63:0] ctz_d_data = count_ff0_rslt;

assign alu_exe_clz_data[63:0] = 
                            {64{is_count_zero & is_right_left & is_count_w }} & clz_w_data  |
                            {64{is_count_zero & is_right_left & is_count_d }} & clz_d_data;

assign alu_exe_ctz_data[63:0] = 
                            {64{is_count_zero & is_left_right & is_count_w }} & ctz_w_data  |
                            {64{is_count_zero & is_left_right & is_count_d }} & ctz_d_data;



// movgr2cf
assign alu_exe_movgf_data[63:0] = alu_ex1_src0[63:0];



/// TODO: CRC and CRCC inst

ct_iu_crc    crc_chksum (
  .crc_a                (alu_ex1_src0[63:0]),
  .crc_msg              (alu_ex1_src1[63:0]),
  .crc_poly             (32'hEDB88320),
  .crc_type             (alu_ex1_func[1:0]),
  .crc_check_sum        (alu_exe_crc_data[63:0])
  );

ct_iu_crc    crcc_chksum (
  .crc_a                (alu_ex1_src0[63:0]),
  .crc_msg              (alu_ex1_src1[63:0]),
  .crc_poly             (32'h82F63B78),
  .crc_type             (alu_ex1_func[1:0]),
  .crc_check_sum        (alu_exe_crcc_data[63:0])
  );


//----------------------------------------------------------
//                    Register Result
//----------------------------------------------------------
assign alu_rbus_ex1_pipex_data_vld       = alu_ex1_inst_vld && alu_ex1_dst_vld;

assign alu_rbus_ex1_pipex_fwd_vld        = alu_ex1_fwd_vld;

// assign alu_rbus_ex1_pipex_fwd_data[63:0] = alu_ex1_fwd_data[63:0];

assign alu_rbus_ex1_pipex_preg[6:0]      = alu_ex1_dst_preg[6:0];

// assign alu_rbus_ex1_pipex_data[63:0]     = alu_ex1_alu_short ? alu_ex1_fwd_data[63:0]
//                                                              : alu_ex1_long_data[63:0];

assign alu_rbus_ex1_pipex_dstreg[4:0] = alu_ex1_opcode[4:0];

assign alu_rbus_ex1_pipex_fwd_data[63:0] = alu_exex_pipex_data[63:0];
assign alu_rbus_ex1_pipex_data[63:0]     = alu_exex_pipex_data[63:0];

assign alu_rbus_ex1_pipex_iid[6:0]       = alu_ex1_iid[6:0];

//----------------------------------------------------------
//            MOVE TO VECTOR REGISTER(NO IMPL)
// TODO:
//----------------------------------------------------------

// wire [63:0] fmv_data;

// assign fmv_data[63:0] = {64{alu_ex1_inst_sel[ALU_OPCODE_MVD]}} &  alu_ex1_src0[63:0]
//                        | {64{alu_ex1_inst_sel[ALU_OPCODE_MVW]}} &  {32'b0, alu_ex1_src0[31:0]};


//==========================================================
//                  Send MTVR result
//==========================================================
assign misc_inst_mtvr_inst[4:0] = alu_ex1_func[4:0];

assign misc_ex1_mtvr_vld  = alu_ex1_inst_vld && alu_ex1_dstv_vld;

//----------------------------------------------------------
//                   EX2 mtvr valid
//----------------------------------------------------------
always @(posedge ctrl_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    misc_ex2_mtvr_vld <= 1'b0;
  else if(rtu_yy_xx_flush)
    misc_ex2_mtvr_vld <= 1'b0;
  else
    misc_ex2_mtvr_vld <= misc_ex1_mtvr_vld;
end

assign iu_vfpu_ex1_pipex_mtvr_vld        = misc_ex1_mtvr_vld;
assign iu_vfpu_ex1_pipex_mtvr_inst[4:0]  = misc_inst_mtvr_inst[4:0];
assign iu_vfpu_ex1_pipex_mtvr_vreg[6:0]  = alu_ex1_dst_vreg[6:0];
assign iu_vfpu_ex1_pipex_mtvr_vlmul[1:0] = alu_ex1_vlmul[1:0];
assign iu_vfpu_ex1_pipex_mtvr_vsew[2:0]  = alu_ex1_vsew[2:0];
assign iu_vfpu_ex1_pipex_mtvr_vl[7:0]    = alu_ex1_vl[7:0];

//----------------------------------------------------------
//                   EX2 mtvr data
//----------------------------------------------------------
always @(posedge ex2_inst_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    misc_ex2_mtvr_src0[63:0]     <= 64'b0;
  end
  else if(misc_ex1_mtvr_vld) begin
    misc_ex2_mtvr_src0[63:0]     <= (had_idu_wbbr_vld)
                                    ? had_idu_wbbr_data[63:0]
                                    : alu_ex1_src0[63:0];
  end
  else begin
    misc_ex2_mtvr_src0[63:0]     <= misc_ex2_mtvr_src0[63:0];
  end
end

assign iu_vfpu_ex2_pipex_mtvr_vld        = misc_ex2_mtvr_vld;
assign iu_vfpu_ex2_pipex_mtvr_src0[63:0] = misc_ex2_mtvr_src0[63:0];

// &ModuleEnd; @797
endmodule

