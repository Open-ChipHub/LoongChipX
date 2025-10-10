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

// &ModuleBeg; @27
module ct_iu_bju_pcfifo_read_entry (
  // &Ports, @28
  input    wire          cp0_iu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          iu_yy_xx_cancel,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_iu_flush_fe,
  input    wire          rtu_yy_xx_flush,
  input    wire  [74:0]  x_create_data,
  input    wire          x_create_en,
  input    wire          x_create_gateclk_en,
  output   wire  [74:0]  x_rt_read_data
); 



// &Regs; @29
reg             bht_mispred;         
reg             bht_pred;            
reg             bju;                 
reg             cmplt;               
reg             condbr;              
reg             flush;               
reg             jmp;                 
reg             length;              
reg     [63:0]  pc;                  
reg             pcall;               
reg             pret;                
reg             vld;                 

// &Wires; @30
wire            cmplt_clk;           
wire            cmplt_clk_en;        
wire            entry_clk;           
wire            entry_clk_en;        
wire            flush_with_create;   
wire            vld_with_create;     
wire            x_create_bht_mispred; 
wire            x_create_bht_pred;   
wire            x_create_bju;        
wire            x_create_cmplt;      
wire            x_create_condbr;     
wire            x_create_flush;      
wire            x_create_jmp;        
wire            x_create_length;     
wire    [63:0]  x_create_pc;         
wire            x_create_pcall;      
wire            x_create_pret;       
wire            x_create_vld;        
wire            x_read_bht_mispred;  
wire            x_read_bht_pred;     
wire            x_read_bju;          
wire            x_read_cmplt;        
wire            x_read_condbr;       
wire            x_read_flush;        
wire            x_read_jmp;          
wire            x_read_length;       
wire    [63:0]  x_read_pc;           
wire            x_read_pcall;        
wire            x_read_pret;         
wire            x_read_vld;          



//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign entry_clk_en = x_create_gateclk_en
                      || rtu_yy_xx_flush
                      || iu_yy_xx_cancel
                      || rtu_iu_flush_fe;
// &Instance("gated_clk_cell", "x_entry_gated_clk"); @40
gated_clk_cell  x_entry_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (entry_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (entry_clk_en      ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @41
//          .external_en (1'b0), @42
//          .global_en   (cp0_yy_clk_en), @43
//          .module_en   (cp0_iu_icg_en), @44
//          .local_en    (entry_clk_en), @45
//          .clk_out     (entry_clk)); @46

assign cmplt_clk_en = x_create_gateclk_en;
// &Instance("gated_clk_cell", "x_cmplt_gated_clk"); @49
gated_clk_cell  x_cmplt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (cmplt_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (cmplt_clk_en      ),
  .module_en          (cp0_iu_icg_en     ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @50
//          .external_en (1'b0), @51
//          .global_en   (cp0_yy_clk_en), @52
//          .module_en   (cp0_iu_icg_en), @53
//          .local_en    (cmplt_clk_en), @54
//          .clk_out     (cmplt_clk)); @55

//==========================================================
//                  Create and Read Bus
//==========================================================
assign x_create_cmplt         = x_create_data[74];
assign x_create_flush         = x_create_data[73];
assign x_create_vld           = x_create_data[72];
assign x_create_length        = x_create_data[71];
assign x_create_bht_pred      = x_create_data[70];
assign x_create_bju           = x_create_data[69];
assign x_create_bht_mispred   = x_create_data[68];
assign x_create_jmp           = x_create_data[67];
assign x_create_pret          = x_create_data[66];
assign x_create_pcall         = x_create_data[65];
assign x_create_condbr        = x_create_data[64];
assign x_create_pc[63:0]      = x_create_data[63:0];

//assign x_cmplt_length         = bju_pcfifo_ex2_length;
//assign x_cmplt_bht_mispred    = bju_pcfifo_ex2_bht_mispred;
//assign x_cmplt_jmp            = bju_pcfifo_ex2_jmp;
//assign x_cmplt_pret           = bju_pcfifo_ex2_pret;
//assign x_cmplt_pcall          = bju_pcfifo_ex2_pcall;
//assign x_cmplt_condbr         = bju_pcfifo_ex2_condbr;
//assign x_cmplt_pc[63:0]       = bju_pcfifo_ex2_pc[63:0];

assign x_rt_read_data[74]     = x_read_cmplt;
assign x_rt_read_data[73]     = x_read_flush;
assign x_rt_read_data[72]     = x_read_vld;
assign x_rt_read_data[71]     = x_read_length;
assign x_rt_read_data[70]     = x_read_bht_pred;
assign x_rt_read_data[69]     = x_read_bju;
assign x_rt_read_data[68]     = x_read_bht_mispred;
assign x_rt_read_data[67]     = x_read_jmp;
assign x_rt_read_data[66]     = x_read_pret;
assign x_rt_read_data[65]     = x_read_pcall;
assign x_rt_read_data[64]     = x_read_condbr;
assign x_rt_read_data[63:0]   = x_read_pc[63:0];

//==========================================================
//                      Entry Valid
//==========================================================
assign vld_with_create = x_create_en ? x_create_vld : vld;
always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    vld <= 1'b0;
  else if(vld_with_create && rtu_yy_xx_flush
          && (flush_with_create || iu_yy_xx_cancel || rtu_iu_flush_fe))
    vld <= 1'b0;
  else if(x_create_en)
    vld <= x_create_vld;
  else
    vld <= vld;
end

assign x_read_vld = vld;

//==========================================================
//                      Entry Cmplt
//==========================================================
always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    cmplt <= 1'b0;
  else if(vld_with_create && rtu_yy_xx_flush
          && (flush_with_create || iu_yy_xx_cancel || rtu_iu_flush_fe))
    cmplt <= 1'b0;
  else if(x_create_en)
    cmplt <= x_create_cmplt;
  else
    cmplt <= cmplt;
end

assign x_read_cmplt = cmplt;

//==========================================================
//                        Flush
//==========================================================
assign flush_with_create = x_create_en ? x_create_flush : flush;
always @(posedge entry_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    flush <= 1'b0;
  else if(vld_with_create && (iu_yy_xx_cancel || rtu_iu_flush_fe)
                          && !rtu_yy_xx_flush)
    flush <= 1'b1;
  else if(x_create_en)
    flush <= x_create_flush;
  else
    flush <= flush;
end

assign x_read_flush = flush;

//==========================================================
//                     Information
//==========================================================
always @(posedge cmplt_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    bht_pred      <= 1'b0;
  else if(x_create_en)
    bht_pred      <= x_create_bht_pred;
  else
    bht_pred      <= bht_pred;
end

always @(posedge cmplt_clk or negedge cpurst_b)
begin
  if(!cpurst_b) begin
    pc[63:0]      <= 40'b0;
    bju           <= 1'b0;
    condbr        <= 1'b0;
    pcall         <= 1'b0;
    pret          <= 1'b0;
    jmp           <= 1'b0;
    bht_mispred   <= 1'b0;
    length        <= 1'b0;
  end
  else if(x_create_en) begin
    pc[63:0]      <= x_create_pc[63:0];
    bju           <= x_create_bju;
    condbr        <= x_create_condbr;
    pcall         <= x_create_pcall;
    pret          <= x_create_pret;
    jmp           <= x_create_jmp;
    bht_mispred   <= x_create_bht_mispred;
    length        <= x_create_length;
  end
  else begin
    pc[63:0]      <= pc[63:0];
    bju           <= bju;
    condbr        <= condbr;
    pcall         <= pcall;
    pret          <= pret;
    jmp           <= jmp;
    bht_mispred   <= bht_mispred;
    length        <= length;
  end
end

//rename for read output
assign x_read_pc[63:0]      = pc[63:0];
assign x_read_bju           = bju;
assign x_read_condbr        = condbr;
assign x_read_pcall         = pcall;
assign x_read_pret          = pret;
assign x_read_jmp           = jmp;
assign x_read_bht_mispred   = bht_mispred; 
assign x_read_bht_pred      = bht_pred;
assign x_read_length        = length;

// &ModuleEnd; @208
endmodule



