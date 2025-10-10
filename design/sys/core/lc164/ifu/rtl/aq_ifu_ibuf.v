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
// &ModuleBeg; @24
module aq_ifu_ibuf (
  // &Ports, @25
  input    wire          cp0_ifu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_ibuf_pop_en,
  input    wire  [31:0]  dtu_ifu_debug_inst,
  input    wire          dtu_ifu_debug_inst_vld,
  input    wire          dtu_ifu_halt_info_vld,
  input    wire          forever_cpuclk,
  input    wire          idu_ifu_id_stall,
  input    wire          ipack_ibuf_acc_err,
  input    wire  [31:0]  ipack_ibuf_inst,
  input    wire          ipack_ibuf_inst_vld,
  input    wire          ipack_ibuf_inst_vld_raw,
  input    wire          ipack_ibuf_pgflt,
  input    wire          pad_yy_icg_scan_en,
  input    wire          pcgen_ibuf_chgflw_vld,
  input    wire  [1 :0]  pred_ibuf_br_taken0,
  input    wire          pred_ibuf_chgflw_vld0,
  input    wire  [21:0]  pred_ibuf_halt_info0,
  input    wire  [21:0]  pred_ibuf_halt_info1,
  input    wire          rtu_ifu_flush_fe,
  input    wire          rtu_yy_xx_dbgon,
  input    wire          vec_ibuf_warm_up,
  output   wire          ibuf_ctrl_inst_fetch,
  output   wire          ibuf_ipack_stall,
  output   wire          ibuf_pred_hungry,
  output   wire          ibuf_pred_stall,
  output   wire          ibuf_top_id_stall,
  output   wire          ibuf_top_pop_entry_vld,
  output   wire  [2 :0]  ibuf_top_vld_num,
  output   wire  [1 :0]  ifu_idu_id_bht_pred,
  output   wire          ifu_idu_id_expt_acc_error,
  output   wire          ifu_idu_id_expt_high,
  output   wire          ifu_idu_id_expt_page_fault,
  output   wire  [21:0]  ifu_idu_id_halt_info,
  output   wire  [31:0]  ifu_idu_id_inst,
  output   wire          ifu_idu_id_inst_vld
); 



// &Regs; @26
reg     [5 :0]  pop0;                        
reg             pop0_acc_err;                
reg     [21:0]  pop0_halt_info;              
reg     [31:0]  pop0_inst;                   
reg             pop0_pgflt;                  
reg     [1 :0]  pop0_pred_taken;             
reg             pop0_vld;                    
reg             pop1_acc_err;                
reg     [21:0]  pop1_halt_info;              
reg     [31:0]  pop1_inst;                   
reg             pop1_pgflt;                  
reg     [1 :0]  pop1_pred_taken;             
reg             pop1_vld;                    
reg     [5 :0]  push0;                       
                 

// &Wires; @27
wire            dtu_create0_en;              
wire            dtu_create1_en;              
wire            entry0_acc_err;              
wire            entry0_create0_data_en;      
wire            entry0_create0_en;           
wire            entry0_create1_data_en;      
wire            entry0_create1_en;           
wire            entry0_create2_data_en;      
wire            entry0_create2_en;           
wire    [21:0]  entry0_halt_info;            
wire    [31:0]  entry0_inst;                 
wire            entry0_pgflt;                
wire    [1 :0]  entry0_pred_taken;           
wire            entry0_retire0_en;           
wire            entry0_retire1_en;           
wire            entry0_vld;                  
wire            entry1_acc_err;              
wire            entry1_create0_data_en;      
wire            entry1_create0_en;           
wire            entry1_create1_data_en;      
wire            entry1_create1_en;           
wire            entry1_create2_data_en;      
wire            entry1_create2_en;           
wire    [21:0]  entry1_halt_info;            
wire    [31:0]  entry1_inst;                 
wire            entry1_pgflt;                
wire    [1 :0]  entry1_pred_taken;           
wire            entry1_retire0_en;           
wire            entry1_retire1_en;           
wire            entry1_vld;                  
wire            entry2_acc_err;              
wire            entry2_create0_data_en;      
wire            entry2_create0_en;           
wire            entry2_create1_data_en;      
wire            entry2_create1_en;           
wire            entry2_create2_data_en;      
wire            entry2_create2_en;           
wire    [21:0]  entry2_halt_info;            
wire    [31:0]  entry2_inst;                 
wire            entry2_pgflt;                
wire    [1 :0]  entry2_pred_taken;           
wire            entry2_retire0_en;           
wire            entry2_retire1_en;           
wire            entry2_vld;                  
wire            entry3_acc_err;              
wire            entry3_create0_data_en;      
wire            entry3_create0_en;           
wire            entry3_create1_data_en;      
wire            entry3_create1_en;           
wire            entry3_create2_data_en;      
wire            entry3_create2_en;           
wire    [21:0]  entry3_halt_info;            
wire    [31:0]  entry3_inst;                 
wire            entry3_pgflt;                
wire    [1 :0]  entry3_pred_taken;           
wire            entry3_retire0_en;           
wire            entry3_retire1_en;           
wire            entry3_vld;                  
wire            entry4_acc_err;              
wire            entry4_create0_data_en;      
wire            entry4_create0_en;           
wire            entry4_create1_data_en;      
wire            entry4_create1_en;           
wire            entry4_create2_data_en;      
wire            entry4_create2_en;           
wire    [21:0]  entry4_halt_info;            
wire    [31:0]  entry4_inst;                 
wire            entry4_pgflt;                
wire    [1 :0]  entry4_pred_taken;           
wire            entry4_retire0_en;           
wire            entry4_retire1_en;           
wire            entry4_vld;                  
wire            entry5_acc_err;              
wire            entry5_create0_data_en;      
wire            entry5_create0_en;           
wire            entry5_create1_data_en;      
wire            entry5_create1_en;           
wire            entry5_create2_data_en;      
wire            entry5_create2_en;           
wire    [21:0]  entry5_halt_info;            
wire    [31:0]  entry5_inst;                 
wire            entry5_pgflt;                
wire    [1 :0]  entry5_pred_taken;           
wire            entry5_retire0_en;           
wire            entry5_retire1_en;           
wire            entry5_vld;                  
wire            ibuf_cpuclk;                 
wire            ibuf_create0_acc_err;        
wire            ibuf_create0_data_en;        
wire            ibuf_create0_en;             
wire    [21:0]  ibuf_create0_halt_info;      
wire    [31:0]  ibuf_create0_inst;           
wire            ibuf_create0_pgflt;          
wire    [1 :0]  ibuf_create0_pred_taken;     
wire            ibuf_empty;                  
wire            ibuf_entry_stall;            
wire            ibuf_five_avalbe;            
wire            ibuf_flush_en;               
wire            ibuf_four_avalbe;            
wire            ibuf_full;                   
wire            ibuf_icg_en;                 
wire            ibuf_inst32;                 
wire            ibuf_inst_32_vld;            
wire            ibuf_inst_fetch;             
wire            ibuf_one_avalbe;             
wire            ibuf_retire0_en;             
wire            ibuf_retire0_en_vld;         
wire            ibuf_retire1_en;             
wire            ibuf_stall;                  
wire            ibuf_two_avalbe;             
wire    [2 :0]  ibuf_vld_num;                
wire            ipack_bypass_vld;            
wire            ipack_create0_data_en;       
wire            ipack_create0_en;            
wire            ipack_create1_data_en;       
wire            ipack_create1_en;            
wire            ipack_expt_high;             
wire            ipack_inst_32;               
wire            pop0_inst_32;                
wire    [5 :0]  pop1;                        
wire            pop_entry0_acc_err;          
wire            pop_entry0_create_acc_err;   
wire            pop_entry0_create_data_en;   
wire            pop_entry0_create_en;        
wire    [21:0]  pop_entry0_create_halt_info; 
wire    [31:0]  pop_entry0_create_inst;      
wire            pop_entry0_create_pgflt;     
wire    [1 :0]  pop_entry0_create_pred_taken; 
wire    [21:0]  pop_entry0_halt_info;        
wire    [31:0]  pop_entry0_inst;             
wire            pop_entry0_pgflt;            
wire    [1 :0]  pop_entry0_pred_taken;       
wire            pop_entry0_retire_en;        
wire            pop_entry0_vld;              
wire            pop_entry_acc_err;           
wire            pop_entry_expt_high;         
wire    [21:0]  pop_entry_halt_info;         
wire    [31:0]  pop_entry_inst;              
wire            pop_entry_pgflt;             
wire    [1 :0]  pop_entry_pred_taken;        
wire            pop_entry_vld;               
wire    [5 :0]  push0_bypass;                
wire    [5 :0]  push0_shift;
wire    [5 :0]  pop0_shift;                  


//==========================================================
// Instruction Buffer Module
// 1. Instance ICG cells
// 2. Instance I-Buffer Entries
// 3. I-Buffer Read Port
// 4. I-Buffer Write Port
// 5. Valid Instruction Generation
// 6. I-Buffer Pop Entry
//==========================================================

//------------------------------------------------
// 1. Instance ICG cells
//------------------------------------------------
assign ibuf_icg_en = !ibuf_empty
                   || pop0_vld
                   || pop_entry_vld
                   || ipack_ibuf_inst_vld
                   || dtu_create0_en;
// &Instance("gated_clk_cell", "x_ifu_ibuf_icg_cell"); @47
gated_clk_cell  x_ifu_ibuf_icg_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ibuf_cpuclk       ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (ibuf_icg_en       ),
  .module_en          (cp0_ifu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @48
//          .external_en (1'b0), @49
//          .global_en   (cp0_yy_clk_en), @50
//          .module_en   (cp0_ifu_icg_en), @51
//          .local_en    (ibuf_icg_en), @52
//          .clk_out     (ibuf_cpuclk) @53
//         ); @54

//------------------------------------------------
// 2. Instance I-Buffer Entries
//------------------------------------------------
parameter ENTRY_NUM = 6;

// &ConnRule(s/ibuf_entry/entry0/); @61
// &Instance("aq_ifu_ibuf_entry","x_aq_ifu_ibuf_entry0"); @62
aq_ifu_ibuf_entry  x_aq_ifu_ibuf_entry0 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pgflt         (ibuf_create0_pgflt        ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_entry_acc_err         (entry0_acc_err            ),
  .ibuf_entry_create0_data_en (entry0_create0_data_en    ),
  .ibuf_entry_create0_en      (entry0_create0_en         ),
  .ibuf_entry_halt_info       (entry0_halt_info          ),
  .ibuf_entry_inst            (entry0_inst               ),
  .ibuf_entry_pgflt           (entry0_pgflt              ),
  .ibuf_entry_pred_taken      (entry0_pred_taken         ),
  .ibuf_entry_retire0_en      (entry0_retire0_en         ),
  .ibuf_entry_vld             (entry0_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry1/); @64
// &Instance("aq_ifu_ibuf_entry","x_aq_ifu_ibuf_entry1"); @65
aq_ifu_ibuf_entry  x_aq_ifu_ibuf_entry1 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pgflt         (ibuf_create0_pgflt        ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_entry_acc_err         (entry1_acc_err            ),
  .ibuf_entry_create0_data_en (entry1_create0_data_en    ),
  .ibuf_entry_create0_en      (entry1_create0_en         ),
  .ibuf_entry_halt_info       (entry1_halt_info          ),
  .ibuf_entry_inst            (entry1_inst               ),
  .ibuf_entry_pgflt           (entry1_pgflt              ),
  .ibuf_entry_pred_taken      (entry1_pred_taken         ),
  .ibuf_entry_retire0_en      (entry1_retire0_en         ),
  .ibuf_entry_vld             (entry1_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry2/); @67
// &Instance("aq_ifu_ibuf_entry","x_aq_ifu_ibuf_entry2"); @68
aq_ifu_ibuf_entry  x_aq_ifu_ibuf_entry2 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pgflt         (ibuf_create0_pgflt        ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_entry_acc_err         (entry2_acc_err            ),
  .ibuf_entry_create0_data_en (entry2_create0_data_en    ),
  .ibuf_entry_create0_en      (entry2_create0_en         ),
  .ibuf_entry_halt_info       (entry2_halt_info          ),
  .ibuf_entry_inst            (entry2_inst               ),
  .ibuf_entry_pgflt           (entry2_pgflt              ),
  .ibuf_entry_pred_taken      (entry2_pred_taken         ),
  .ibuf_entry_retire0_en      (entry2_retire0_en         ),
  .ibuf_entry_vld             (entry2_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry3/); @70
// &Instance("aq_ifu_ibuf_entry","x_aq_ifu_ibuf_entry3"); @71
aq_ifu_ibuf_entry  x_aq_ifu_ibuf_entry3 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pgflt         (ibuf_create0_pgflt        ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_entry_acc_err         (entry3_acc_err            ),
  .ibuf_entry_create0_data_en (entry3_create0_data_en    ),
  .ibuf_entry_create0_en      (entry3_create0_en         ),
  .ibuf_entry_halt_info       (entry3_halt_info          ),
  .ibuf_entry_inst            (entry3_inst               ),
  .ibuf_entry_pgflt           (entry3_pgflt              ),
  .ibuf_entry_pred_taken      (entry3_pred_taken         ),
  .ibuf_entry_retire0_en      (entry3_retire0_en         ),
  .ibuf_entry_vld             (entry3_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry4/); @73
// &Instance("aq_ifu_ibuf_entry","x_aq_ifu_ibuf_entry4"); @74
aq_ifu_ibuf_entry  x_aq_ifu_ibuf_entry4 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pgflt         (ibuf_create0_pgflt        ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_entry_acc_err         (entry4_acc_err            ),
  .ibuf_entry_create0_data_en (entry4_create0_data_en    ),
  .ibuf_entry_create0_en      (entry4_create0_en         ),
  .ibuf_entry_halt_info       (entry4_halt_info          ),
  .ibuf_entry_inst            (entry4_inst               ),
  .ibuf_entry_pgflt           (entry4_pgflt              ),
  .ibuf_entry_pred_taken      (entry4_pred_taken         ),
  .ibuf_entry_retire0_en      (entry4_retire0_en         ),
  .ibuf_entry_vld             (entry4_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


// &ConnRule(s/ibuf_entry/entry5/); @76
// &Instance("aq_ifu_ibuf_entry","x_aq_ifu_ibuf_entry5"); @77
aq_ifu_ibuf_entry  x_aq_ifu_ibuf_entry5 (
  .cp0_ifu_icg_en             (cp0_ifu_icg_en            ),
  .cp0_yy_clk_en              (cp0_yy_clk_en             ),
  .cpurst_b                   (cpurst_b                  ),
  .forever_cpuclk             (forever_cpuclk            ),
  .ibuf_cpuclk                (ibuf_cpuclk               ),
  .ibuf_create0_acc_err       (ibuf_create0_acc_err      ),
  .ibuf_create0_halt_info     (ibuf_create0_halt_info    ),
  .ibuf_create0_inst          (ibuf_create0_inst         ),
  .ibuf_create0_pgflt         (ibuf_create0_pgflt        ),
  .ibuf_create0_pred_taken    (ibuf_create0_pred_taken   ),
  .ibuf_entry_acc_err         (entry5_acc_err            ),
  .ibuf_entry_create0_data_en (entry5_create0_data_en    ),
  .ibuf_entry_create0_en      (entry5_create0_en         ),
  .ibuf_entry_halt_info       (entry5_halt_info          ),
  .ibuf_entry_inst            (entry5_inst               ),
  .ibuf_entry_pgflt           (entry5_pgflt              ),
  .ibuf_entry_pred_taken      (entry5_pred_taken         ),
  .ibuf_entry_retire0_en      (entry5_retire0_en         ),
  .ibuf_entry_vld             (entry5_vld                ),
  .ibuf_flush_en              (ibuf_flush_en             ),
  .pad_yy_icg_scan_en         (pad_yy_icg_scan_en        ),
  .vec_ibuf_warm_up           (vec_ibuf_warm_up          )
);


//------------------------------------------------
// 3. I-Buffer Read Port
// a. Retire Information out of Instruction Buffer
//------------------------------------------------
// a. Retire Information out of Instruction Buffer
// The instruction will be retired in inst buf when
// it can be piped down to ID stage
assign ibuf_retire0_en = pop0_vld && ctrl_ibuf_pop_en;

assign ibuf_retire0_en_vld = ibuf_retire0_en;

assign ibuf_flush_en   = rtu_ifu_flush_fe || pcgen_ibuf_chgflw_vld;

//pop0
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    pop0[ENTRY_NUM-1:0] <= {{(ENTRY_NUM-1){1'b0}}, 1'b1};
  else if(ibuf_flush_en)
    pop0[ENTRY_NUM-1:0] <= pop0[ENTRY_NUM-1:0];
  else if(ibuf_retire0_en_vld)
    pop0[ENTRY_NUM-1:0] <= pop0_shift[ENTRY_NUM-1:0];
  //else if(ipack_bypass_vld && !idu_ifu_id_stall)
  //  pop0[ENTRY_NUM-1:0] <= pop0_bypass[ENTRY_NUM-1:0];
end

assign pop0_shift[ENTRY_NUM-1:0] = {pop0[ENTRY_NUM-2:0], pop0[ENTRY_NUM-1]};


//retire0
assign {entry5_retire0_en,
        entry4_retire0_en,
        entry3_retire0_en,
        entry2_retire0_en,
        entry1_retire0_en,
        entry0_retire0_en} = pop0[ENTRY_NUM-1:0] & {ENTRY_NUM{ibuf_retire0_en}};


// &CombBeg; @146
always @( entry1_acc_err
       or entry2_inst[31:0]
       or entry1_pgflt
       or entry5_inst[31:0]
       or entry4_halt_info[21:0]
       or entry0_acc_err
       or entry2_pgflt
       or entry0_pgflt
       or entry5_vld
       or entry5_pgflt
       or entry0_vld
       or entry1_inst[31:0]
       or entry2_acc_err
       or entry2_halt_info[21:0]
       or pop0[5:0]
       or entry3_pred_taken[1:0]
       or entry3_acc_err
       or entry3_pgflt
       or entry1_vld
       or entry4_pgflt
       or entry0_halt_info[21:0]
       or entry3_halt_info[21:0]
       or entry4_acc_err
       or entry4_pred_taken[1:0]
       or entry0_pred_taken[1:0]
       or entry5_acc_err
       or entry1_halt_info[21:0]
       or entry4_inst[31:0]
       or entry2_vld
       or entry3_vld
       or entry5_pred_taken[1:0]
       or entry4_vld
       or entry5_halt_info[21:0]
       or entry3_inst[31:0]
       or entry2_pred_taken[1:0]
       or entry1_pred_taken[1:0]
       or entry0_inst[31:0])
begin
  case(pop0[ENTRY_NUM-1:0])
  6'b0001:
  begin
    pop0_vld          = entry0_vld;
    pop0_inst[31:0]   = entry0_inst[31:0];
    pop0_pred_taken[1:0] = entry0_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry0_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry0_acc_err;
    pop0_pgflt        = entry0_pgflt;
  end
  6'b0010:
  begin
    pop0_vld          = entry1_vld;
    pop0_inst[31:0]   = entry1_inst[31:0];
    pop0_pred_taken[1:0] = entry1_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry1_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry1_acc_err;
    pop0_pgflt        = entry1_pgflt;
  end
  6'b0100:
  begin
    pop0_vld          = entry2_vld;
    pop0_inst[31:0]   = entry2_inst[31:0];
    pop0_pred_taken[1:0] = entry2_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry2_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry2_acc_err;
    pop0_pgflt        = entry2_pgflt;
  end
  6'b1000:
  begin
    pop0_vld          = entry3_vld;
    pop0_inst[31:0]   = entry3_inst[31:0];
    pop0_pred_taken[1:0] = entry3_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry3_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry3_acc_err;
    pop0_pgflt        = entry3_pgflt;
  end
  6'b10000:
  begin
    pop0_vld          = entry4_vld;
    pop0_inst[31:0]   = entry4_inst[31:0];
    pop0_pred_taken[1:0] = entry4_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry4_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry4_acc_err;
    pop0_pgflt        = entry4_pgflt;
  end
  6'b100000:
  begin
    pop0_vld          = entry5_vld;
    pop0_inst[31:0]   = entry5_inst[31:0];
    pop0_pred_taken[1:0] = entry5_pred_taken[1:0];
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0]  = entry5_halt_info[`TDT_HINFO_WIDTH-1:0];
    pop0_acc_err      = entry5_acc_err;
    pop0_pgflt        = entry5_pgflt;
  end
  default:
  begin
    pop0_vld          = 1'bx;
    pop0_inst[31:0]   = 32'bx;
    pop0_pred_taken[1:0] = 2'bx;
    pop0_halt_info[`TDT_HINFO_WIDTH-1:0] = {`TDT_HINFO_WIDTH{1'bx}};
    pop0_acc_err      = 1'bx;
    pop0_pgflt        = 1'bx;
  end
  endcase
// &CombEnd; @212
end


//------------------------------------------------
// 4. I-Buffer Write Port
// a. Create Information into I-Buffer
// b. Generate Entry Create Signal for Each Entry 
// c. Generate Entry Create Instruction
//------------------------------------------------
// a. Create Information into I-Buffer
// the create0 signal
assign ipack_bypass_vld = ibuf_empty && ipack_ibuf_inst_vld;

assign ipack_create0_en = ipack_ibuf_inst_vld
                           && !ibuf_full
                           && (!ibuf_empty || pop_entry_vld && idu_ifu_id_stall);

assign ipack_create0_data_en = ipack_create0_en;

assign dtu_create0_en        = rtu_yy_xx_dbgon && dtu_ifu_debug_inst_vld;

assign ibuf_create0_en       = ipack_create0_en || dtu_create0_en;
assign ibuf_create0_data_en  = ipack_create0_data_en || dtu_create0_en;


// b. Generate Entry Create Signal for Each Entry 
//push0
always @(posedge ibuf_cpuclk or negedge cpurst_b)
begin
  if(!cpurst_b)
    push0[ENTRY_NUM-1:0] <= {{(ENTRY_NUM-1){1'b0}}, 1'b1};
  else if(ibuf_flush_en)
    push0[ENTRY_NUM-1:0] <= pop0[ENTRY_NUM-1:0];
  else if(ibuf_create0_en)
    push0[ENTRY_NUM-1:0] <= push0_shift[ENTRY_NUM-1:0];
end

assign push0_shift[ENTRY_NUM-1:0] = {push0[ENTRY_NUM-2:0], push0[ENTRY_NUM-1]};

assign push0_bypass[ENTRY_NUM-1:0] = push0[ENTRY_NUM-1:0];

//create0
assign {entry5_create0_en,
        entry4_create0_en,
        entry3_create0_en,
        entry2_create0_en,
        entry1_create0_en,
        entry0_create0_en} = push0_bypass[ENTRY_NUM-1:0] & {ENTRY_NUM{ibuf_create0_en}};

assign {entry5_create0_data_en,
        entry4_create0_data_en,
        entry3_create0_data_en,
        entry2_create0_data_en,
        entry1_create0_data_en,
        entry0_create0_data_en} = push0[ENTRY_NUM-1:0] & {ENTRY_NUM{ibuf_create0_data_en}};


// c. Generate Entry Create Instruction
assign ipack_inst_32 = 1'b1; //ipack_ibuf_inst[1:0] == 2'b11;
assign ibuf_create0_inst[31:0] = // create dtu low inst when dbg on
                                  rtu_yy_xx_dbgon ? dtu_ifu_debug_inst[31:0]
                                 // create ipack up inst when pop entry
                                 // empty and ipack full
                               : ipack_ibuf_inst[31:0];

assign ibuf_create0_pred_taken[1:0] = pred_ibuf_br_taken0[1:0];
assign ibuf_create0_halt_info[`TDT_HINFO_WIDTH-1:0]  = pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign ibuf_create0_acc_err    = ipack_ibuf_acc_err;
assign ibuf_create0_pgflt      = ipack_ibuf_pgflt;

//------------------------------------------------
// 5. Valid Instruction Generation
// a. The I-Buffer status signal
// b. The Valid Instruction
//------------------------------------------------
// a. The I-Buffer status signal
//------------------------------------------------
assign ibuf_vld_num[2:0] = {2'b0, entry0_vld}
                         + {2'b0, entry1_vld}
                         + {2'b0, entry2_vld}
                         + {2'b0, entry3_vld}
                         + {2'b0, entry4_vld}
                         + {2'b0, entry5_vld};

assign ibuf_full         = ibuf_vld_num[2:0] == 3'b110; 
assign ibuf_one_avalbe   = ibuf_vld_num[2:0] == 3'b101;      
assign ibuf_four_avalbe  = ibuf_vld_num[2:0] == 3'b010;       
assign ibuf_five_avalbe  = ibuf_vld_num[2:0] == 3'b001;       

assign ibuf_empty        = !(entry0_vld || entry1_vld || entry2_vld
                          || entry3_vld || entry4_vld || entry5_vld);

//------------------------------------------------
// b. The Valid Instruction
//------------------------------------------------
assign ibuf_entry_stall = ibuf_full && ipack_ibuf_inst_vld_raw;
assign ibuf_stall       = ibuf_entry_stall || !dtu_ifu_halt_info_vld && ipack_ibuf_inst_vld_raw;

//------------------------------------------------
// a. entry instance
//------------------------------------------------
// &ConnRule(s/ibuf_entry/pop_entry0/); @548
// &Instance("aq_ifu_ibuf_pop_entry","x_aq_ifu_ibuf_pop_entry0"); @549
aq_ifu_ibuf_pop_entry  x_aq_ifu_ibuf_pop_entry0 (
  .cp0_ifu_icg_en               (cp0_ifu_icg_en              ),
  .cp0_yy_clk_en                (cp0_yy_clk_en               ),
  .cpurst_b                     (cpurst_b                    ),
  .forever_cpuclk               (forever_cpuclk              ),
  .ibuf_cpuclk                  (ibuf_cpuclk                 ),
  .ibuf_entry_acc_err           (pop_entry0_acc_err          ),
  .ibuf_entry_create_acc_err    (pop_entry0_create_acc_err   ),
  .ibuf_entry_create_data_en    (pop_entry0_create_data_en   ),
  .ibuf_entry_create_en         (pop_entry0_create_en        ),
  .ibuf_entry_create_halt_info  (pop_entry0_create_halt_info ),
  .ibuf_entry_create_inst       (pop_entry0_create_inst      ),
  .ibuf_entry_create_pgflt      (pop_entry0_create_pgflt     ),
  .ibuf_entry_create_pred_taken (pop_entry0_create_pred_taken),
  .ibuf_entry_halt_info         (pop_entry0_halt_info        ),
  .ibuf_entry_inst              (pop_entry0_inst             ),
  .ibuf_entry_pgflt             (pop_entry0_pgflt            ),
  .ibuf_entry_pred_taken        (pop_entry0_pred_taken       ),
  .ibuf_entry_retire_en         (pop_entry0_retire_en        ),
  .ibuf_entry_vld               (pop_entry0_vld              ),
  .ibuf_flush_en                (ibuf_flush_en               ),
  .pad_yy_icg_scan_en           (pad_yy_icg_scan_en          ),
  .vec_ibuf_warm_up             (vec_ibuf_warm_up            )
);

//------------------------------------------------
// b. entry create
//------------------------------------------------
// create entry 0 when:
// 1. ibuf retire0 vld
// 2. ipack bypass vld and id stall
// 3. ipack bypass vld and pop entry inst vld
// 4. ipack bypass vld and ipack two inst vld
assign pop_entry0_create_en = ibuf_retire0_en
                           || ipack_bypass_vld && !pop_entry_vld && idu_ifu_id_stall
                           || ipack_bypass_vld && pop_entry_vld && !idu_ifu_id_stall;

assign pop_entry0_create_data_en = pop0_vld || ipack_bypass_vld;

// create content
// inst code
assign pop_entry0_create_inst[31:0] = pop0_vld ? pop0_inst[31:0]
                                               : ipack_ibuf_inst[31:0];
// pred taken
assign pop_entry0_create_pred_taken[1:0] = pop0_vld ? pop0_pred_taken[1:0]
                                    : idu_ifu_id_stall || pop_entry_vld ? pred_ibuf_br_taken0[1:0]
                                    : 2'b0;

// inst bkpt
assign pop_entry0_create_halt_info[`TDT_HINFO_WIDTH-1:0] = pop0_vld ? pop0_halt_info[`TDT_HINFO_WIDTH-1:0]
                                    : idu_ifu_id_stall || pop_entry_vld ? pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0]
                                    : pred_ibuf_halt_info1[`TDT_HINFO_WIDTH-1:0];

// acc err
assign pop_entry0_create_acc_err = pop0_vld ? pop0_acc_err
                                 : idu_ifu_id_stall || pop_entry_vld ? ipack_ibuf_acc_err
                                 : 1'b0;

// page fault
assign pop_entry0_create_pgflt = pop0_vld ? pop0_pgflt
                               : idu_ifu_id_stall || pop_entry_vld ? ipack_ibuf_pgflt
                               : 1'b0;

assign ipack_expt_high          = 1'b0;

//------------------------------------------------
// c. entry retire
//------------------------------------------------
assign pop_entry0_retire_en = ctrl_ibuf_pop_en;

//------------------------------------------------
// d. entry output
//------------------------------------------------
assign pop_entry_vld             = pop_entry0_vld;
assign pop_entry_inst[31:0]      = pop_entry0_inst[31:0];
assign pop_entry_pred_taken[1:0] = pop_entry0_pred_taken[1:0]; 
assign pop_entry_halt_info[`TDT_HINFO_WIDTH-1:0]  = pop_entry0_halt_info[`TDT_HINFO_WIDTH-1:0]; 
assign pop_entry_acc_err         = pop_entry0_acc_err;
assign pop_entry_pgflt           = pop_entry0_pgflt;
assign pop_entry_expt_high       = 1'b0;

//==========================================================
// Rename for Output
//==========================================================

// Output to ctrl
assign ibuf_ctrl_inst_fetch = !ibuf_stall;

// Output to ipack
assign ibuf_ipack_stall = ibuf_stall;

//assign ibuf_ctrl_stall = 1'b0;

// Output to ipack
assign ibuf_pred_stall  = ibuf_stall;
assign ibuf_pred_hungry = ibuf_empty || ibuf_five_avalbe || ibuf_four_avalbe;

// Output to top
assign ibuf_top_vld_num[2:0]  = ibuf_vld_num[2:0];
assign ibuf_top_id_stall      = idu_ifu_id_stall;
assign ibuf_top_pop_entry_vld = pop_entry_vld;

// Output to IDU
assign ifu_idu_id_inst_vld   = pop_entry_vld || ipack_ibuf_inst_vld && dtu_ifu_halt_info_vld; 
assign ifu_idu_id_inst[31:0] = pop_entry_vld ? pop_entry_inst[31:0]
                                          : ipack_ibuf_inst[31:0];
assign ifu_idu_id_bht_pred[1:0]   = pop_entry_vld ? pop_entry_pred_taken[1:0]
                                                  : pred_ibuf_br_taken0[1:0];
assign ifu_idu_id_halt_info[`TDT_HINFO_WIDTH-1:0]  = pop_entry_vld ? pop_entry_halt_info[`TDT_HINFO_WIDTH-1:0]
                                                  : pred_ibuf_halt_info0[`TDT_HINFO_WIDTH-1:0];
assign ifu_idu_id_expt_acc_error  = pop_entry_vld ? pop_entry_acc_err
                                                  : ipack_ibuf_acc_err;
assign ifu_idu_id_expt_page_fault = pop_entry_vld ? pop_entry_pgflt
                                                  : ipack_ibuf_pgflt;
assign ifu_idu_id_expt_high       = pop_entry_vld ? pop_entry_expt_high
                                                  : ipack_expt_high;
// &Force("outout", "ifu_idu_id_inst"); @672
// &Force("outout", "ifu_idu_id_inst_vld"); @673

// &ModuleEnd; @700
endmodule


