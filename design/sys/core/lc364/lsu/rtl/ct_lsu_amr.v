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
module ct_lsu_amr (
  // &Ports, @25
  input    wire          cp0_lsu_amr,
  input    wire          cp0_lsu_amr2,
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_lsu_no_op_req,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          forever_cpuclk,
  input    wire          icc_idle,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [39:0]  wmb_ce_addr,
  input    wire  [15:0]  wmb_ce_bytes_vld,
  input    wire          wmb_ce_ca_st_inst,
  input    wire          wmb_ce_pop_vld,
  input    wire          wmb_ce_vld,
  output   wire          amr_l2_mem_set,
  output   wire          amr_wa_cancel,
  output   wire  [2 :0]  lsu_had_amr_state
); 



// &Regs; @26
reg     [35:0]  amr_addr_tto4;             
reg     [15:0]  amr_bytes_vld;             
reg     [5 :0]  amr_cnt;                   
reg     [2 :0]  amr_next_state;            
reg     [2 :0]  amr_state;                 

// &Wires; @27
wire    [35:0]  amr_addr_distance;         
wire            amr_addr_hit;              
wire            amr_addr_hit_eq;           
wire            amr_addr_hit_normal_update; 
wire            amr_bytes_vld_cross;       
wire            amr_bytes_vld_full;        
wire    [15:0]  amr_bytes_vld_next;        
wire            amr_clk;                   
wire            amr_clk_en;                
wire            amr_cnt_met_set;           
wire    [39:0]  amr_from_wmb_ce_addr;      
wire            amr_judge_cancel;          
wire            amr_judge_fail;            
wire            amr_judge_flush;           
wire            amr_not_idle;              
wire            amr_update_clk;            
wire            amr_update_clk_en;         
wire            amr_update_vld;            


parameter JUDGE     = 3'b000,
          MEM_SET_0 = 3'b001,//0 means write 1 dcache line
          MEM_SET_1 = 3'b011,//1 add cancel write allocate
          MEM_SET_2 = 3'b111;//2 add cancel l2 write allocate
//==========================================================
//                 Instance of Gated Cell  
//==========================================================
//amr pop clk is for addr and bytes_vld when sq pops a entry
assign amr_clk_en     = cp0_lsu_amr
                        ? (wmb_ce_vld
                          ||  amr_cnt_met_set
                          ||  amr_not_idle)
//                              &&  (!icc_idle
//                                  ||  amr_cnt_met_set_1
//                                  ||  amr_cnt_met_set_2
//                                  ||  cp0_lsu_no_op_req))
//                                  ||  wmb_amr_cancel_gateclk))
                        : amr_not_idle;
// &Instance("gated_clk_cell", "x_lsu_amr_gated_clk"); @47
gated_clk_cell  x_lsu_amr_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (amr_clk           ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (amr_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @48
//          .external_en   (1'b0               ), @49
//          .global_en     (cp0_yy_clk_en      ), @50
//          .module_en     (cp0_lsu_icg_en     ), @51
//          .local_en      (amr_clk_en         ), @52
//          .clk_out       (amr_clk            )); @53


assign amr_update_clk_en  = amr_update_vld;
// &Instance("gated_clk_cell", "x_lsu_amr_update_gated_clk"); @57
gated_clk_cell  x_lsu_amr_update_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (amr_update_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (amr_update_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @58
//          .external_en   (1'b0               ), @59
//          .global_en     (cp0_yy_clk_en      ), @60
//          .module_en     (cp0_lsu_icg_en     ), @61
//          .local_en      (amr_update_clk_en  ), @62
//          .clk_out       (amr_update_clk     )); @63

//==========================================================
//                      Registers
//==========================================================
//+-------+
//| state |
//+-------+
always @(posedge amr_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    amr_state[2:0]        <=  JUDGE;
  else
    amr_state[2:0]        <=  amr_next_state[2:0];
end
//assign amr_mem_set    = amr_state[0];
assign amr_wa_cancel  = amr_state[0];
assign amr_l2_mem_set = amr_state[2]
                        &&  cp0_lsu_amr2;

//+------+-----------+-----+-----+
//| addr | bytes_vld | cnt | neg |
//+------+-----------+-----+-----+
always @(posedge amr_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    amr_cnt[5:0]          <=  6'b0;
  else if(amr_judge_cancel)
    amr_cnt[5:0]          <=  6'b0;
  else if(amr_judge_fail)
    amr_cnt[5:0]          <=  6'b0;
  else if(amr_update_vld &&  amr_bytes_vld_full)
    amr_cnt[5:0]          <=  amr_cnt[5:0]+6'b1;
  else if(amr_update_vld)
    amr_cnt[5:0]          <=  amr_cnt[5:0];
end

assign amr_from_wmb_ce_addr[`PA_WIDTH-1:0] = wmb_ce_addr[`PA_WIDTH-1:0];
always @(posedge amr_update_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    amr_bytes_vld[15:0]   <=  16'b0;
//  else if(amr_judge_fail && wmb_ce_bytes_vld_full)
//    amr_bytes_vld[15:0]   <=  16'b0;
  else if(amr_judge_fail || amr_update_vld && amr_bytes_vld_full)
    amr_bytes_vld[15:0]   <=  wmb_ce_bytes_vld[15:0];
//  else if(amr_update_vld &&  amr_bytes_vld_next_full)
//    amr_bytes_vld[15:0]   <=  16'b0;
  else if(amr_update_vld)
    amr_bytes_vld[15:0]   <=  amr_bytes_vld_next[15:0];
end

always @(posedge amr_update_clk)
begin
//  if(amr_judge_fail && wmb_ce_bytes_vld_full)
//    amr_addr_tto4[`PA_WIDTH-5:0]   <=  amr_from_wmb_ce_addr_tto4_cal[`PA_WIDTH-5:0];
  if(amr_update_vld)
    amr_addr_tto4[`PA_WIDTH-5:0]   <=  amr_from_wmb_ce_addr[`PA_WIDTH-1:4];
//  else if(amr_update_vld &&  amr_bytes_vld_next_full)
//    amr_addr_tto4[`PA_WIDTH-5:0]   <=  amr_addr_tto4_cal[`PA_WIDTH-5:0];
end

// //&Force("output","amr_neg"); @125
//always @(posedge amr_update_clk or negedge cpurst_b)
//begin
//  if (!cpurst_b)
//    amr_neg       <=  1'b0;
//  else if(amr_update_vld  &&  !amr_addr_hit)
//    amr_neg       <=  !amr_neg;
//end

//==========================================================
//                 Generate next state
//==========================================================
// &CombBeg; @137
always @( amr_cnt[5:0]
       or amr_cnt_met_set
       or amr_state[2:0]
       or amr_judge_flush)
begin
amr_next_state[2:0] = JUDGE;
case(amr_state[2:0])
  JUDGE:
    if(amr_cnt_met_set)
      amr_next_state[2:0] = MEM_SET_0;
    else
      amr_next_state[2:0] = JUDGE;
  MEM_SET_0:
    if(amr_judge_flush)
      amr_next_state[2:0] = JUDGE;
    else if(amr_cnt[5:0] ==  6'd16)
      amr_next_state[2:0] = MEM_SET_1;
    else
      amr_next_state[2:0] = MEM_SET_0;
  MEM_SET_1:
    if(amr_judge_flush)
      amr_next_state[2:0] = MEM_SET_0;
    else if(amr_cnt[5:0] ==  6'd48)
      amr_next_state[2:0] = MEM_SET_2;
    else
      amr_next_state[2:0] = MEM_SET_1;
  MEM_SET_2:
    if(amr_judge_flush)
      amr_next_state[2:0] = MEM_SET_1;
    else
      amr_next_state[2:0] = MEM_SET_2;
  default:amr_next_state[2:0] = JUDGE;
endcase
// &CombEnd; @166
end

//==========================================================
//                        Wires
//==========================================================
//---------------------amr cnt state change-----------------
assign amr_cnt_met_set = (amr_cnt[5:0] ==  6'd8);
//---------------------pop_judge_vld------------------------
assign amr_update_vld = wmb_ce_pop_vld;
//------------------------addr hit--------------------------
assign amr_addr_hit    = amr_bytes_vld_full
                         ? amr_addr_hit_normal_update
                         : amr_addr_hit_eq;

assign amr_addr_distance[`PA_WIDTH-5:0] = amr_from_wmb_ce_addr[`PA_WIDTH-1:4] - amr_addr_tto4[`PA_WIDTH-5:0];

//distance equal to 0
assign amr_addr_hit_eq = !(|amr_addr_distance[`PA_WIDTH-5:0]); 

//distance equal to +1 or -1 means normal update
assign amr_addr_hit_normal_update = amr_addr_distance[0]
                                    && (&amr_addr_distance[`PA_WIDTH-5:1]
                                        || !(|amr_addr_distance[`PA_WIDTH-5:1]));
//---------------------next bytes_vld-----------------------
assign amr_bytes_vld_next[15:0] = amr_bytes_vld[15:0] | wmb_ce_bytes_vld[15:0];
//assign amr_bytes_vld_next_full  = &amr_bytes_vld_next[15:0];
assign amr_bytes_vld_full       = &amr_bytes_vld[15:0];
//assign wmb_ce_bytes_vld_full    = &wmb_ce_bytes_vld[15:0];

//---------------------next addr----------------------------
//assign amr_from_wmb_ce_addr_tto4_cal[`PA_WIDTH-5:0] =
//                amr_neg
//                ? amr_from_wmb_ce_addr[`PA_WIDTH-1:4]
//                  + {{`PA_WIDTH-5{1'b0}},1'b1}
//                : amr_from_wmb_ce_addr[`PA_WIDTH-1:4]
//                  - {{`PA_WIDTH-5{1'b0}},1'b1};
//assign amr_addr_tto4_cal[`PA_WIDTH-5:0]  =
//                amr_neg
//                ? amr_addr_tto4[`PA_WIDTH-5:0]
//                  - {{`PA_WIDTH-5{1'b0}},1'b1}
//                : amr_addr_tto4[`PA_WIDTH-5:0]
//                  + {{`PA_WIDTH-5{1'b0}},1'b1};

//cross hit means there is a common bit 1 both in 
//amr_bytes_vld and wmb_ce_bytes_vld 
assign amr_bytes_vld_cross  = |(amr_bytes_vld[15:0] & wmb_ce_bytes_vld[15:0]);

//---------------------judge flush--------------------------
//cancel means it need to clear all the tags
assign amr_judge_cancel = !icc_idle
                          ||  !cp0_lsu_amr
                          ||  amr_update_vld &&  !wmb_ce_ca_st_inst
                          ||  cp0_lsu_no_op_req;

//fail means it need to set all the tags to the pop st inst
assign amr_judge_fail   = amr_update_vld
                          &&  (!amr_addr_hit
                              ||  amr_bytes_vld_cross
                                  && !amr_bytes_vld_full);

assign amr_judge_flush  = amr_judge_cancel  ||  amr_judge_fail;

assign amr_not_idle     = (amr_state[2:0] !=  JUDGE)
                          ||  (amr_cnt[5:0] !=  6'b0);

//==========================================================
//              Interface to other module
//==========================================================
assign lsu_had_amr_state[2:0] = amr_state[2:0];

// &ModuleEnd; @236
endmodule


