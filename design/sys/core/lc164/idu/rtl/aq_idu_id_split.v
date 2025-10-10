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

// &Depend("aq_idu_cfig.h"); @24
// &ModuleBeg; @25
module aq_idu_id_split (
  // &Ports, @26
  input    wire           cp0_idu_cskyee,
  input    wire           cp0_idu_icg_en,
  input    wire           cp0_idu_ucme,
  input    wire           cp0_yy_clk_en,
  input    wire  [1  :0]  cp0_yy_priv_mode,
  input    wire           cpurst_b,
  input    wire           ctrl_xx_dis_stall,
  input    wire  [31 :0]  dp_split_inst,
  input    wire           forever_cpuclk,
  input    wire           ifu_idu_id_inst_vld,
  input    wire           iu_yy_xx_cancel,
  input    wire           pad_yy_icg_scan_en,
  input    wire           rtu_idu_flush_fe,
  input    wire           rtu_yy_xx_dbgon,
  output   wire           split_ctrl_id_stall,
  output   wire           split_ctrl_inst_vld,
  output   reg   [273:0]  split_dp_inst_data,
  output   wire           split_dp_inst_sel,
  output   wire  [4  :0]  split_top_cur_state_no_idle
); 



// &Regs; @27
reg     [273:0]  amo_amo_inst_data;          
reg     [2  :0]  amo_cur_state;              
reg     [273:0]  amo_fence_aq_inst_data;     
reg     [273:0]  amo_fence_rl_inst_data;     
reg     [273:0]  amo_inst_data;              
reg     [273:0]  amo_lr_inst_data;           
reg     [2  :0]  amo_next_state;             
reg     [273:0]  amo_sc_inst_data;           
reg              che_cur_state;              
reg     [273:0]  che_inst_dcache_data;       
reg     [273:0]  che_inst_icache_data;       
reg              che_next_state;             
reg              fnc_cur_state;              
reg     [273:0]  fnc_inst_sfence_data;       
reg     [273:0]  fnc_inst_sync_data;         
reg              fnc_next_state;             
reg              fri_cur_state;              
reg     [273:0]  fri_inst_ffint_data;       
reg     [273:0]  fri_inst_ftint_data;         
reg              fri_next_state;             
reg              frs_cur_state;              
reg     [273:0]  frs_inst_fsqrt_data;       
reg     [273:0]  frs_inst_frecip_data;         
reg              frs_next_state;      
reg              lsd_cur_state;              
reg     [273:0]  lsd_inst_load_data;         
reg     [273:0]  lsd_inst_store_data;        
reg              lsd_next_state;             

// &Wires; @28
wire             amo_aq_inst;                
wire             amo_fence_aq_inst_length;   
wire             amo_fence_rl_inst_length;   
wire             amo_inst;                   
wire             amo_inst_vld;               
wire    [4  :0]  amo_rd;                     
wire             amo_rl_inst;                
wire    [4  :0]  amo_rs1;                    
wire    [4  :0]  amo_rs2;                    
wire             amo_sm_start;               
wire             amo_split_stall;            
wire             amo_split_type;             
wire             amo_word;                   
wire             dp_split_inst_swapw;
wire             dp_split_inst_swapd;
wire             dp_split_inst_addw;
wire             dp_split_inst_addd;
wire             dp_split_inst_andw;
wire             dp_split_inst_andd;
wire             dp_split_inst_orw;
wire             dp_split_inst_ord;
wire             dp_split_inst_xorw;
wire             dp_split_inst_xord;
wire             dp_split_inst_maxw;
wire             dp_split_inst_maxd;
wire             dp_split_inst_minw;
wire             dp_split_inst_mind;
wire             dp_split_inst_maxuw;
wire             dp_split_inst_maxud;
wire             dp_split_inst_minuw;
wire             dp_split_inst_minud;
wire    [20 :0]  dp_split_inst_func;
wire    [273:0]  che_inst_data;              
wire             che_inst_vld;               
wire             che_sm_start;               
wire             che_split_stall;            
wire             che_split_type;             
wire             che_va;                     
wire    [273:0]  fnc_inst_data;              
wire             fnc_inst_vld;               
wire             fnc_sm_start;               
wire             fnc_split_stall;            
wire             fnc_split_type;             
wire    [273:0]  fri_inst_data;              
wire             fri_inst_vld;               
wire             fri_sm_start;               
wire             fri_split_stall;            
wire             fri_split_type;       
wire    [273:0]  frs_inst_data;              
wire             frs_inst_vld;               
wire             frs_sm_start;               
wire             frs_split_stall;            
wire             frs_split_type;             
wire             lr_inst;                    
wire    [11 :0]  lsd_inst0_offset;           
wire    [11 :0]  lsd_inst1_offset;           
wire             lsd_inst1_sel;              
wire    [273:0]  lsd_inst_data;              
wire             lsd_inst_vld;               
wire             lsd_load;                   
wire             lsd_sm_start;               
wire             lsd_split_stall;            
wire             lsd_split_type;             
wire             lsd_word;                   
wire             sc_inst;                    
wire             split_clk;                  
wire             split_clk_en;               
wire    [273:0]  split_inst_data;            
wire    [19 :0]  zvamo_func;                 
wire             zvamo_inst;                 


//==========================================================
//            Load store double (lsd) instructions
//==========================================================
//----------------------------------------------------------
//                   lsd split inst
//----------------------------------------------------------
//full decode split type
assign lsd_split_type = cp0_idu_cskyee && 1'b0;

//----------------------------------------------------------
//           lsd split variables initial value
//----------------------------------------------------------
assign lsd_sm_start           = ifu_idu_id_inst_vld
                                && lsd_split_type;

assign lsd_load               = !dp_split_inst[12];
assign lsd_word               = !dp_split_inst[27];

assign lsd_inst0_offset[11:0] = lsd_word ? {7'b0,dp_split_inst[26:25],3'b0}
                                         : {6'b0,dp_split_inst[26:25],4'b0};
assign lsd_inst1_offset[11:0] = lsd_word ? lsd_inst0_offset[11:0] + {8'b0,4'd4}
                                         : lsd_inst0_offset[11:0] + {8'b0,4'd8};

//----------------------------------------------------------
//              FSM of inst lsd ctrl logic
//----------------------------------------------------------
// State Description:
// LSD_IDLE  : id stage instruction 0 is not multi load store
//            (lsd) or the first cycle to start lsd FSM
// LSD_SPLIT : the lsd instruction is spliting
parameter LSD_IDLE  = 1'b0;
parameter LSD_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    lsd_cur_state <= LSD_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    lsd_cur_state <= LSD_IDLE;
  else if(!ctrl_xx_dis_stall)
    lsd_cur_state <= lsd_next_state;
  else
    lsd_cur_state <= lsd_cur_state;
end

// &CombBeg; @81
always @( lsd_sm_start
       or lsd_cur_state)
begin
  case(lsd_cur_state)
  LSD_IDLE  : if(lsd_sm_start)
                lsd_next_state = LSD_SPLIT;
              else
                lsd_next_state = LSD_IDLE;
  LSD_SPLIT :   lsd_next_state = LSD_IDLE;
  default   :   lsd_next_state = LSD_IDLE;
  endcase
// &CombEnd; @90
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign lsd_inst_vld    = 1'b1;

assign lsd_split_stall = (lsd_next_state != LSD_IDLE);

assign lsd_inst1_sel   = (lsd_cur_state == LSD_SPLIT);

//----------------------------------------------------------
//               Split Instruction : load
//----------------------------------------------------------
//split inst 0: lw/ld/lwu rd,(rs1),sign_ext(imm5<<imm2)
//split inst 1: lw/ld/lwu rd+1,(rs1),sign_ext(imm5<<imm2+4/8)
// &CombBeg; @106
always @( dp_split_inst[11:7]
       or lsd_inst0_offset[11:0]
       or lsd_inst1_offset[11:0]
       or dp_split_inst[24:15]
       or dp_split_inst[28:27]
       or lsd_inst1_sel)
begin
  lsd_inst_load_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  lsd_inst_load_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_LSU;
  lsd_inst_load_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = dp_split_inst[27]
                                                         ? `FUNC_LD
                                                         : dp_split_inst[28]
                                                           ? `FUNC_LWU
                                                           : `FUNC_LW;
  lsd_inst_load_data[`IDU_SRC0_VLD]                     = 1'b1;
  lsd_inst_load_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,dp_split_inst[19:15]};
  lsd_inst_load_data[`IDU_SRC1_IMM_VLD]                 = 1'b1;
  lsd_inst_load_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]     = lsd_inst1_sel
                                                         ? {{52{lsd_inst1_offset[11]}},
                                                                lsd_inst1_offset[11:0]}
                                                         : {{52{lsd_inst0_offset[11]}},
                                                                lsd_inst0_offset[11:0]};
  lsd_inst_load_data[`IDU_DST0_VLD]                     = 1'b1;
  lsd_inst_load_data[`IDU_DST0_REG:`IDU_DST0_REG-5]      = lsd_inst1_sel
                                                         ? {1'b0,dp_split_inst[24:20]}
                                                         : {1'b0,dp_split_inst[11:7]};
  lsd_inst_load_data[`IDU_SPLIT]                        = !lsd_inst1_sel;
  lsd_inst_load_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @130
end

//----------------------------------------------------------
//               Split Instruction: store
//----------------------------------------------------------
//split inst 0: sw/sd/swu rs2,(rs1),sign_ext(imm5<<imm2)
//split inst 1: sw/sd/swu rs2+1,(rs1),sign_ext(imm5<<imm2+4/8)
// &CombBeg; @137
always @( dp_split_inst[11:7]
       or lsd_inst0_offset[11:0]
       or lsd_inst1_offset[11:0]
       or dp_split_inst[24:15]
       or dp_split_inst[27]
       or lsd_inst1_sel)
begin
  lsd_inst_store_data[`IDU_WIDTH-1:0]                   = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  lsd_inst_store_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_LSU;
  lsd_inst_store_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = dp_split_inst[27]
                                                         ? `FUNC_SD
                                                         : `FUNC_SW; 
  lsd_inst_store_data[`IDU_SRC0_VLD]                    = 1'b1;
  lsd_inst_store_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]     = {1'b0,dp_split_inst[19:15]};
  lsd_inst_store_data[`IDU_SRC1_IMM_VLD]                = 1'b1;
  lsd_inst_store_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]    = lsd_inst1_sel
                                                         ? {{52{lsd_inst1_offset[11]}},
                                                                lsd_inst1_offset[11:0]}
                                                         : {{52{lsd_inst0_offset[11]}},
                                                                lsd_inst0_offset[11:0]};
  lsd_inst_store_data[`IDU_SRC2_VLD]                    = 1'b1;
  lsd_inst_store_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]     = lsd_inst1_sel
                                                         ? {1'b0,dp_split_inst[24:20]}
                                                         : {1'b0,dp_split_inst[11:7]};
  lsd_inst_store_data[`IDU_SPLIT]                       = !lsd_inst1_sel;
  lsd_inst_store_data[`IDU_LENGTH]                      = 1'b1;
  end 
// &CombEnd; @159
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign lsd_inst_data[`IDU_WIDTH-1:0] = lsd_load
                                      ? lsd_inst_load_data[`IDU_WIDTH-1:0]
                                      : lsd_inst_store_data[`IDU_WIDTH-1:0];

//==========================================================
//                 Atomic (amo) instructions
//==========================================================
//----------------------------------------------------------
//                   amo split inst
//----------------------------------------------------------
//full decode split type
assign amo_split_type =
      (dp_split_inst[31:21] == 11'b00111000011)
      && ((dp_split_inst[20:15] == 6'b010010)   //amswap_db.w
       || (dp_split_inst[20:15] == 6'b010011)   //amswap_db.d
       || (dp_split_inst[20:15] == 6'b010100)   //amadd_db.w
       || (dp_split_inst[20:15] == 6'b010101)   //amadd_db.d
       || (dp_split_inst[20:15] == 6'b010110)   //amand_db.w
       || (dp_split_inst[20:15] == 6'b010111)   //amand_db.d
       || (dp_split_inst[20:15] == 6'b011000)   //amor_db.w
       || (dp_split_inst[20:15] == 6'b011001)   //amor_db.d
       || (dp_split_inst[20:15] == 6'b011010)   //amxor_db.w
       || (dp_split_inst[20:15] == 6'b011011)   //amxor_db.d
       || (dp_split_inst[20:15] == 6'b011100)   //ammax_db.w
       || (dp_split_inst[20:15] == 6'b011101)   //ammax_db.d
       || (dp_split_inst[20:15] == 6'b011110)   //ammin_db.w
       || (dp_split_inst[20:15] == 6'b011111)   //ammin_db.d
       || (dp_split_inst[20:15] == 6'b100000)   //ammax_db.wu
       || (dp_split_inst[20:15] == 6'b100001)   //ammax_db.du
       || (dp_split_inst[20:15] == 6'b100010)   //ammin_db.wu
       || (dp_split_inst[20:15] == 6'b100011)); //ammin_db.du


wire dp_split_inst_amo  = (dp_split_inst[31:21] == 11'b00111000011);



assign dp_split_inst_swapw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b010010));//amswap_db.w

assign dp_split_inst_swapd = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b010011));//amswap_db.d

assign dp_split_inst_addw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b010100));//amadd_db.w

assign dp_split_inst_addd = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b010101));//amadd_db.d

assign dp_split_inst_andw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b010110));//amand_db.w

assign dp_split_inst_andd = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b010111));//amand_db.d

assign dp_split_inst_orw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011000));//amor_db.w

assign dp_split_inst_ord = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011001));//amor_db.d

assign dp_split_inst_xorw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011010));//amxor_db.w

assign dp_split_inst_xord = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011011));//amxor_db.d

assign dp_split_inst_maxw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011100));//ammax_db.w

assign dp_split_inst_maxd = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011101));//ammax_db.d

assign dp_split_inst_minw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011110));//ammin_db.w

assign dp_split_inst_mind = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b011111));//ammin_db.d

assign dp_split_inst_maxuw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b100000));//ammax_db.wu

assign dp_split_inst_maxud = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b100001));//ammax_db.du

assign dp_split_inst_minuw = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b100010));//ammin_db.wu

assign dp_split_inst_minud = dp_split_inst_amo && 
                           ((dp_split_inst[20:15] == 6'b100011));//ammin_db.du


assign dp_split_inst_func[19:0] = {20{dp_split_inst_swapw}} & `FUNC_AMSWAPW | 
                                  {20{dp_split_inst_swapd}} & `FUNC_AMSWAPD |
                                  {20{dp_split_inst_addw }} & `FUNC_AMADDW |
                                  {20{dp_split_inst_addd }} & `FUNC_AMADDD |
                                  {20{dp_split_inst_andw }} & `FUNC_AMANDW |
                                  {20{dp_split_inst_andd }} & `FUNC_AMANDD |
                                  {20{dp_split_inst_orw  }} & `FUNC_AMORW |
                                  {20{dp_split_inst_ord  }} & `FUNC_AMORD |
                                  {20{dp_split_inst_xorw }} & `FUNC_AMXORW |
                                  {20{dp_split_inst_xord }} & `FUNC_AMXORD |
                                  {20{dp_split_inst_maxw }} & `FUNC_AMMAXW |
                                  {20{dp_split_inst_maxd }} & `FUNC_AMMAXD |
                                  {20{dp_split_inst_minw }} & `FUNC_AMMINW |
                                  {20{dp_split_inst_mind }} & `FUNC_AMMIND |
                                  {20{dp_split_inst_maxuw}} & `FUNC_AMMAXWU |
                                  {20{dp_split_inst_maxud}} & `FUNC_AMMAXDU |
                                  {20{dp_split_inst_minuw}} & `FUNC_AMMINWU |
                                  {20{dp_split_inst_minud}} & `FUNC_AMMINDU;

//----------------------------------------------------------
//           amo split variables initial value
//----------------------------------------------------------
assign amo_sm_start       = ifu_idu_id_inst_vld
                            && amo_split_type;

assign amo_inst           = dp_split_inst[6:0]   == 7'b0101111;
assign amo_word           = !dp_split_inst[12];
assign amo_aq_inst        = 1'b1;
assign amo_rl_inst        = 1'b1;

// assign lr_inst            = amo_inst && (dp_split_inst[31:27] ==  5'b00010);
// assign sc_inst            = amo_inst && (dp_split_inst[31:27] ==  5'b00011);

assign lr_inst            = 1'b0;
assign sc_inst            = 1'b0;

//assign amo_swap           = dp_split_inst[31:27] ==  5'b00001;
//assign amo_add            = dp_split_inst[31:27] ==  5'b00000;
//assign amo_xor            = dp_split_inst[31:27] ==  5'b00100;
//assign amo_and            = dp_split_inst[31:27] ==  5'b01100;
//assign amo_or             = dp_split_inst[31:27] ==  5'b01000;
//assign amo_min            = dp_split_inst[31:27] ==  5'b10000;
//assign amo_minu           = dp_split_inst[31:27] ==  5'b11000;
//assign amo_max            = dp_split_inst[31:27] ==  5'b10100;
//assign amo_maxu           = dp_split_inst[31:27] ==  5'b11100;

assign amo_rs1[4:0]       = dp_split_inst[9:5];
assign amo_rs2[4:0]       = dp_split_inst[14:10];
assign amo_rd[4:0]        = dp_split_inst[4:0];

//for zvamo
assign zvamo_inst         = 1'b0;

assign zvamo_func[`FUNC_WIDTH-1:0] = `FUNC_ZVAMO
                                   | {dp_split_inst[25],{`FUNC_WIDTH-17{1'b0}},!dp_split_inst[26],11'b0,dp_split_inst[13:12],{2{1'b0}}};

//----------------------------------------------------------
//              FSM of inst amo ctrl logic
//----------------------------------------------------------
// State Description:
// AMO_IDLE  : id stage instruction 0 is not multi load store
//            (amo) or the first cycle to start amo FSM
// AMO_SPLIT : the amo instruction is spliting
// UPDATE: amo itself will not split anymore
parameter AMO_IDLE  = 3'd0;
parameter AMO_AMO   = 3'd1;
parameter AMO_LR    = 3'd4;
parameter AMO_SC    = 3'd5;
parameter AMO_AQ    = 3'd6;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    amo_cur_state[2:0] <= AMO_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    amo_cur_state[2:0] <= AMO_IDLE;
  else if(!ctrl_xx_dis_stall)
    amo_cur_state[2:0] <= amo_next_state[2:0];
  else
    amo_cur_state[2:0] <= amo_cur_state[2:0];
end

// &CombBeg; @249
always @( amo_cur_state[2:0]
       or lr_inst
       or sc_inst
       or amo_aq_inst
       or amo_rl_inst
       or amo_sm_start)
begin
  case(amo_cur_state[2:0])
  AMO_IDLE  : if(amo_sm_start && amo_rl_inst && lr_inst)
                amo_next_state[2:0] = AMO_LR;
              else if(amo_sm_start && amo_rl_inst && sc_inst)
                amo_next_state[2:0] = AMO_SC;
              else if(amo_sm_start && amo_rl_inst)
                amo_next_state[2:0] = AMO_AMO;
              else if(amo_sm_start && lr_inst && amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else if(amo_sm_start && lr_inst)
                amo_next_state[2:0] = AMO_IDLE;
              else if(amo_sm_start && sc_inst && amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else if(amo_sm_start && sc_inst)
                amo_next_state[2:0] = AMO_IDLE;
              else if(amo_sm_start && amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_AMO   : if(amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_LR    : if(amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_SC    : if(amo_aq_inst)
                amo_next_state[2:0] = AMO_AQ;
              else
                amo_next_state[2:0] = AMO_IDLE;
  AMO_AQ    :   amo_next_state[2:0] = AMO_IDLE;
  default   :   amo_next_state[2:0] = AMO_IDLE;
  endcase
// &CombEnd; @284
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign amo_inst_vld    = 1'b1;

assign amo_split_stall = (amo_next_state[2:0] != AMO_IDLE);

//----------------------------------------------------------
//                  Split Instruction fence
//----------------------------------------------------------
//split inst 0: fence iorw,iorw
assign amo_fence_rl_inst_length                           = 1'b1;
// &CombBeg; @298
always @( amo_fence_rl_inst_length)
begin
  amo_fence_rl_inst_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_fence_rl_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_CP0;
  amo_fence_rl_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = `FUNC_DBAR;
  amo_fence_rl_inst_data[`IDU_SPLIT]                        = 1'b1;
  amo_fence_rl_inst_data[`IDU_LENGTH]                       = 1'b1;
  end
// &CombEnd; @306
end

//split inst last: fence iorw,iorw
assign amo_fence_aq_inst_length                             = 1'b1;
// &CombBeg; @310
always @( amo_fence_aq_inst_length)
begin
  amo_fence_aq_inst_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_fence_aq_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_CP0;
  amo_fence_aq_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = `FUNC_DBAR;
  amo_fence_aq_inst_data[`IDU_LENGTH]                       = 1'b1;
  end
// &CombEnd; @317
end

//----------------------------------------------------------
//                  Split Instruction lr
//----------------------------------------------------------
//split inst 0: lr
// &CombBeg; @323
always @( amo_rd[4:0]
       or amo_rs1[4:0]
       or amo_aq_inst
       or amo_word)
begin
  amo_lr_inst_data[`IDU_WIDTH-1:0]                         = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_lr_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]             = `EU_LSU;
  amo_lr_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]       = amo_word
                                                            ? `FUNC_LR_W
                                                            : `FUNC_LR_D;
  amo_lr_inst_data[`IDU_SRC0_VLD]                          = 1'b1;
  amo_lr_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]           = {1'b0,amo_rs1[4:0]};
  amo_lr_inst_data[`IDU_DST0_VLD]                          = 1'b1;
  amo_lr_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]           = {1'b0,amo_rd[4:0]};
  amo_lr_inst_data[`IDU_SPLIT]                             = amo_aq_inst;
  amo_lr_inst_data[`IDU_LENGTH]                            = 1'b1;
  end
// &CombEnd; @337
end

//----------------------------------------------------------
//                  Split Instruction sc
//----------------------------------------------------------
//split inst 0: sc
// &CombBeg; @343
always @( amo_rs2[4:0]
       or amo_rd[4:0]
       or amo_rs1[4:0]
       or amo_aq_inst
       or amo_word)
begin
  amo_sc_inst_data[`IDU_WIDTH-1:0]                         = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_sc_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]             = `EU_LSU;
  amo_sc_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]       = amo_word
                                                            ? `FUNC_SC_W
                                                            : `FUNC_SC_D;
  amo_sc_inst_data[`IDU_SRC0_VLD]                          = 1'b1;
  amo_sc_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]           = {1'b0,amo_rs1[4:0]};
  amo_sc_inst_data[`IDU_SRC2_VLD]                          = 1'b1;
  amo_sc_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]           = {1'b0,amo_rs2[4:0]};
  amo_sc_inst_data[`IDU_DST0_VLD]                          = 1'b1;
  amo_sc_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]           = {1'b0,amo_rd[4:0]};
  amo_sc_inst_data[`IDU_SPLIT]                             = amo_aq_inst;
  amo_sc_inst_data[`IDU_LENGTH]                            = 1'b1;
  end
// &CombEnd; @359
end

//----------------------------------------------------------
//                  Split Instruction amo
//----------------------------------------------------------
// &CombBeg; @364
always @( amo_rs2[4:0]
       or zvamo_inst
       or amo_rd[4:0]
       or dp_split_inst[31:25]
       or amo_rs1[4:0]
       or amo_aq_inst
       or amo_word
       or dp_split_inst_func[19:0]
       or zvamo_func[19:0])
begin
  amo_amo_inst_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  amo_amo_inst_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_LSU;
  amo_amo_inst_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = dp_split_inst_func[19:0];
  amo_amo_inst_data[`IDU_SRC0_VLD]                      = 1'b1;
  amo_amo_inst_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,amo_rs1[4:0]};
  amo_amo_inst_data[`IDU_SRC2_VLD]                      = !zvamo_inst;
  amo_amo_inst_data[`IDU_SRC2_REG:`IDU_SRC2_REG-5]      = {1'b0,amo_rs2[4:0]};
  amo_amo_inst_data[`IDU_DST0_VLD]                      = !zvamo_inst;
  amo_amo_inst_data[`IDU_DST0_REG:`IDU_DST0_REG-5]      = {1'b0,amo_rd[4:0]};
  amo_amo_inst_data[`IDU_SPLIT]                         = amo_aq_inst;
  amo_amo_inst_data[`IDU_LENGTH]                        = 1'b1;
  amo_amo_inst_data[`IDU_SRC1_IMM_VLD]                  = 1'b0;
  amo_amo_inst_data[`IDU_SRC1_IMM:`IDU_SRC1_IMM-63]     = {64'b0};
  end
// &CombEnd; @394
end

//----------------------------------------------------------
//              Pipedown Instrction Selection
//----------------------------------------------------------
// &CombBeg; @399
always @( amo_amo_inst_data[264:0]
       or amo_cur_state[2:0]
       or amo_sc_inst_data[264:0]
       or amo_lr_inst_data[264:0]
       or lr_inst
       or amo_fence_aq_inst_data[264:0]
       or sc_inst
       or amo_rl_inst
       or amo_fence_rl_inst_data[264:0])
begin
  case(amo_cur_state[2:0])
  AMO_IDLE  : if(amo_rl_inst)
                amo_inst_data[`IDU_WIDTH-1:0] = amo_fence_rl_inst_data[`IDU_WIDTH-1:0];
              else if(lr_inst)
                amo_inst_data[`IDU_WIDTH-1:0] = amo_lr_inst_data[`IDU_WIDTH-1:0];
              else if(sc_inst)
                amo_inst_data[`IDU_WIDTH-1:0] = amo_sc_inst_data[`IDU_WIDTH-1:0];
              else
                amo_inst_data[`IDU_WIDTH-1:0] = amo_amo_inst_data[`IDU_WIDTH-1:0];
  AMO_AMO   :   amo_inst_data[`IDU_WIDTH-1:0] = amo_amo_inst_data[`IDU_WIDTH-1:0];
  AMO_LR    :   amo_inst_data[`IDU_WIDTH-1:0] = amo_lr_inst_data[`IDU_WIDTH-1:0];
  AMO_SC    :   amo_inst_data[`IDU_WIDTH-1:0] = amo_sc_inst_data[`IDU_WIDTH-1:0];
  AMO_AQ    :   amo_inst_data[`IDU_WIDTH-1:0] = amo_fence_aq_inst_data[`IDU_WIDTH-1:0];
  default   :   amo_inst_data[`IDU_WIDTH-1:0] = {`IDU_WIDTH{1'bx}};
  endcase
// &CombEnd; @415
end

//==========================================================
//                Cache (che) instructions
//==========================================================
//----------------------------------------------------------
//                   che split inst
//----------------------------------------------------------
//full decode split type
assign che_split_type = cp0_idu_cskyee && 1'b0;

//----------------------------------------------------------
//           che split variables initial value
//----------------------------------------------------------
assign che_sm_start           = ifu_idu_id_inst_vld
                                && che_split_type;

assign che_va                 = !dp_split_inst[23];

//----------------------------------------------------------
//              FSM of inst che ctrl logic
//----------------------------------------------------------
// State Description:
// CHE_IDLE  : id stage instruction 0 is not multi load store
//            (che) or the first cycle to start che FSM
// CHE_SPLIT : the che instruction is spliting
parameter CHE_IDLE  = 1'b0;
parameter CHE_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    che_cur_state <= CHE_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    che_cur_state <= CHE_IDLE;
  else if(!ctrl_xx_dis_stall)
    che_cur_state <= che_next_state;
  else
    che_cur_state <= che_cur_state;
end

// &CombBeg; @461
always @( che_sm_start
       or che_cur_state)
begin
  case(che_cur_state)
  CHE_IDLE  : if(che_sm_start)
                che_next_state = CHE_SPLIT;
              else
                che_next_state = CHE_IDLE;
  CHE_SPLIT :   che_next_state = CHE_IDLE;
  default   :   che_next_state = CHE_IDLE;
  endcase
// &CombEnd; @470
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign che_inst_vld    = 1'b1;

assign che_split_stall = (che_next_state != CHE_IDLE);

//----------------------------------------------------------
//               Split Instruction : dcache
//----------------------------------------------------------
//split inst 0: dcache cva/cpa
// &CombBeg; @483
always @( dp_split_inst[19:15]
       or che_va)
begin
  che_inst_dcache_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  che_inst_dcache_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_LSU;
  che_inst_dcache_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = che_va ? `FUNC_DCACHE_CVA : `FUNC_DCACHE_CPA;
  che_inst_dcache_data[`IDU_SRC0_VLD]                     = 1'b1;
  che_inst_dcache_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,dp_split_inst[19:15]};
  che_inst_dcache_data[`IDU_SPLIT]                        = 1'b1;
  che_inst_dcache_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @493
end

//----------------------------------------------------------
//               Split Instruction: icache
//----------------------------------------------------------
//split inst 1: icache ipa/iva
// &CombBeg; @499
always @( dp_split_inst[19:15]
       or che_va)
begin
  che_inst_icache_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  che_inst_icache_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_CP0;
  che_inst_icache_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = che_va ? `FUNC_ICACHE_IVA : `FUNC_ICACHE_IPA;
  che_inst_icache_data[`IDU_SRC0_VLD]                     = 1'b1;
  che_inst_icache_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]      = {1'b0,dp_split_inst[19:15]};
  che_inst_icache_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @508
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign che_inst_data[`IDU_WIDTH-1:0] = (che_cur_state == CHE_SPLIT)
                                      ? che_inst_icache_data[`IDU_WIDTH-1:0]
                                      : che_inst_dcache_data[`IDU_WIDTH-1:0];


//==========================================================
//                 Fence (fnc) Instructions
//==========================================================
//----------------------------------------------------------
//                      fnc split inst
//----------------------------------------------------------
//full decode split type
assign fnc_split_type = (dp_split_inst[31:15] == 17'b00000110010010011); // invtlb

//----------------------------------------------------------
//           fnc split variables initial value
//----------------------------------------------------------
assign fnc_sm_start           = ifu_idu_id_inst_vld
                                && fnc_split_type;

//----------------------------------------------------------
//              FSM of inst fnc ctrl logic
//----------------------------------------------------------
// State Description:
// FNC_IDLE  : id stage instruction 0 is not multi load store
//            (fnc) or the first cycle to start fnc FSM
// FNC_SPLIT : the fnc instruction is spliting
parameter FNC_IDLE  = 1'b0;
parameter FNC_SPLIT = 1'b1;

always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fnc_cur_state <= FNC_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    fnc_cur_state <= FNC_IDLE;
  else if(!ctrl_xx_dis_stall)
    fnc_cur_state <= fnc_next_state;
  else
    fnc_cur_state <= fnc_cur_state;
end

// &CombBeg; @556
always @( fnc_sm_start
       or fnc_cur_state)
begin
  case(fnc_cur_state)
  FNC_IDLE  : if(fnc_sm_start)
                fnc_next_state = FNC_SPLIT;
              else
                fnc_next_state = FNC_IDLE;
  FNC_SPLIT :   fnc_next_state = FNC_IDLE;
  default   :   fnc_next_state = FNC_IDLE;
  endcase
// &CombEnd; @565
end

//----------------------------------------------------------
//                     Contrl Signals
//----------------------------------------------------------
assign fnc_inst_vld    = 1'b1;

assign fnc_split_stall = (fnc_next_state != FNC_IDLE);

//----------------------------------------------------------
//               Split Instruction : sfence
//----------------------------------------------------------
//split inst 0: sfence
// &CombBeg; @578
always @( dp_split_inst[24:15])
begin
  fnc_inst_sfence_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  fnc_inst_sfence_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_CP0;
  fnc_inst_sfence_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = `FUNC_INVTLB;
  fnc_inst_sfence_data[`IDU_SRC0_VLD]                     = 1'b1;
  fnc_inst_sfence_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]     = {1'b0,dp_split_inst[19:15]};
  fnc_inst_sfence_data[`IDU_SRC1_VLD]                     = 1'b1;
  fnc_inst_sfence_data[`IDU_SRC1_REG:`IDU_SRC1_REG-5]     = {1'b0,dp_split_inst[24:20]};
  fnc_inst_sfence_data[`IDU_SPLIT]                        = 1'b1;
  fnc_inst_sfence_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @590
end

//----------------------------------------------------------
//               Split Instruction: sync
//----------------------------------------------------------
//split inst 1: sync
// &CombBeg; @596
always @( dp_split_inst[19:15])
begin
  fnc_inst_sync_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  fnc_inst_sync_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]        = `EU_CP0;
  fnc_inst_sync_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1]  = `FUNC_SYNCI;
  fnc_inst_sync_data[`IDU_SRC0_VLD]                     = 1'b1;
  fnc_inst_sync_data[`IDU_SRC0_REG:`IDU_SRC0_REG-5]     = {1'b0,dp_split_inst[19:15]};
  fnc_inst_sync_data[`IDU_LENGTH]                       = 1'b1;
  end 
// &CombEnd; @605
end

//----------------------------------------------------------
//                 Split Instruction Data
//----------------------------------------------------------
assign fnc_inst_data[`IDU_WIDTH-1:0] = (fnc_cur_state == FNC_SPLIT)
                                      ? fnc_inst_sync_data[`IDU_WIDTH-1:0]
                                      : fnc_inst_sfence_data[`IDU_WIDTH-1:0];

//----------------------------------------------------------
//                 frint 
//----------------------------------------------------------

assign fri_split_type = (dp_split_inst[31:12] == 20'b00000001000111100100) &&
                        (dp_split_inst[11] ^ dp_split_inst[10]); // frint.s | frint.d

assign fri_sm_start           = ifu_idu_id_inst_vld
                                && fri_split_type;

parameter FRI_IDLE  = 1'b0;
parameter FRI_SPLIT = 1'b1;
always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    fri_cur_state <= FRI_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    fri_cur_state <= FRI_IDLE;
  else if(!ctrl_xx_dis_stall)
    fri_cur_state <= fri_next_state;
  else
    fri_cur_state <= fri_cur_state;
end

always @( fri_sm_start or fri_cur_state)
begin
  case(fri_cur_state)
  FRI_IDLE  : if(fri_sm_start)
                fri_next_state = FRI_SPLIT;
              else
                fri_next_state = FRI_IDLE;
  FRI_SPLIT :   fri_next_state = FRI_IDLE;
  default   :   fri_next_state = FRI_IDLE;
  endcase
end

assign fri_inst_vld    = 1'b1;
assign fri_split_stall = (fri_next_state != FRI_IDLE);

always @(dp_split_inst[31:15] or dp_split_inst[14:10])begin
  fri_inst_ftint_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  fri_inst_ftint_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_FCVT;
  fri_inst_ftint_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = dp_split_inst[10] ? `FUNC_FCVT_SI32_F32 : `FUNC_FCVT_SI64_F64;
  fri_inst_ftint_data[`IDU_SRCF0_VLD]                    = 1'b1;
  fri_inst_ftint_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]   = dp_split_inst[9:5];
  fri_inst_ftint_data[`IDU_DSTF_VLD]                     = 1'b1;
  fri_inst_ftint_data[`IDU_DSTE_VLD]                     = 1'b1;
  fri_inst_ftint_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]     = dp_split_inst[4:0];
  fri_inst_ftint_data[`IDU_LENGTH]                       = 1'b1;

  end 
end

always @(dp_split_inst[31:15] or dp_split_inst[14:10])begin
  fri_inst_ffint_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  fri_inst_ffint_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_FCVT;
  fri_inst_ffint_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = dp_split_inst[10] ? `FUNC_FCVT_F32_SI32 : `FUNC_FCVT_F64_SI64;
  fri_inst_ffint_data[`IDU_SRCF0_VLD]                    = 1'b1;
  fri_inst_ffint_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]   = dp_split_inst[4:0];
  fri_inst_ffint_data[`IDU_DSTF_VLD]                     = 1'b1;
  fri_inst_ffint_data[`IDU_DSTE_VLD]                     = 1'b1;
  fri_inst_ffint_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]     = dp_split_inst[4:0];
  fri_inst_ffint_data[`IDU_LENGTH]                       = 1'b1;
  fri_inst_ffint_data[`IDU_SPLIT]                        = 1'b1;
  end 
end

assign fri_inst_data[`IDU_WIDTH-1:0] = (fri_cur_state == FRI_SPLIT)
                                      ? fri_inst_ffint_data[`IDU_WIDTH-1:0]
                                      : fri_inst_ftint_data[`IDU_WIDTH-1:0];

//----------------------------------------------------------
//                 frsqrt 
//----------------------------------------------------------

assign frs_split_type = (dp_split_inst[31:12] == 20'b00000001000101000110) &&
                        (dp_split_inst[11] ^ dp_split_inst[10]); // frsqrt.s | frsqrt.d

assign frs_sm_start           = ifu_idu_id_inst_vld
                                && frs_split_type;

parameter FRS_IDLE  = 1'b0;
parameter FRS_SPLIT = 1'b1;
always @(posedge split_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    frs_cur_state <= FRS_IDLE;
  else if(rtu_idu_flush_fe || iu_yy_xx_cancel)
    frs_cur_state <= FRS_IDLE;
  else if(!ctrl_xx_dis_stall)
    frs_cur_state <= frs_next_state;
  else
    frs_cur_state <= frs_cur_state;
end

always @( frs_sm_start or frs_cur_state)
begin
  case(frs_cur_state)
  FRS_IDLE  : if(frs_sm_start)
                frs_next_state = FRS_SPLIT;
              else
                frs_next_state = FRS_IDLE;
  FRS_SPLIT :   frs_next_state = FRS_IDLE;
  default   :   frs_next_state = FRS_IDLE;
  endcase
end

assign frs_inst_vld    = 1'b1;
assign frs_split_stall = (frs_next_state != FRS_IDLE);

always @(dp_split_inst[31:15] or dp_split_inst[14:10])begin
  frs_inst_fsqrt_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  frs_inst_fsqrt_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_FDSU;
  frs_inst_fsqrt_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = dp_split_inst[10] ? `FUNC_FSQRTS : `FUNC_FSQRTD;
  frs_inst_fsqrt_data[`IDU_SRCF0_VLD]                    = 1'b1;
  frs_inst_fsqrt_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]   = dp_split_inst[9:5];
  frs_inst_fsqrt_data[`IDU_DSTF_VLD]                     = 1'b1;
  frs_inst_fsqrt_data[`IDU_DSTE_VLD]                     = 1'b1;
  frs_inst_fsqrt_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]     = dp_split_inst[4:0];
  frs_inst_fsqrt_data[`IDU_LENGTH]                       = 1'b1;

  end 
end

always @(dp_split_inst[31:15] or dp_split_inst[14:10])begin
  frs_inst_frecip_data[`IDU_WIDTH-1:0]                    = {`IDU_WIDTH{1'b0}};
  if(1'b1) begin
  frs_inst_frecip_data[`IDU_EU:`IDU_EU-`EU_WIDTH+1]       = `EU_FDSU;
  frs_inst_frecip_data[`IDU_FUNC:`IDU_FUNC-`FUNC_WIDTH+1] = dp_split_inst[10] ? `FUNC_FDIVRS : `FUNC_FDIVRD;
  frs_inst_frecip_data[`IDU_SRCF0_VLD]                    = 1'b1;
  frs_inst_frecip_data[`IDU_SRCV0_REG:`IDU_SRCV0_REG-4]   = dp_split_inst[4:0];
  frs_inst_frecip_data[`IDU_DSTF_VLD]                     = 1'b1;
  frs_inst_frecip_data[`IDU_DSTE_VLD]                     = 1'b1;
  frs_inst_frecip_data[`IDU_DSTV_REG:`IDU_DSTV_REG-4]     = dp_split_inst[4:0];
  frs_inst_frecip_data[`IDU_LENGTH]                       = 1'b1;
  frs_inst_frecip_data[`IDU_SPLIT]                        = 1'b1;
  end 
end

assign frs_inst_data[`IDU_WIDTH-1:0] = (frs_cur_state == FRS_SPLIT)
                                      ? frs_inst_frecip_data[`IDU_WIDTH-1:0]
                                      : frs_inst_fsqrt_data[`IDU_WIDTH-1:0];

//==========================================================
//               Split Instructions Selection
//==========================================================
//----------------------------------------------------------
//              MUX between split instructions
//----------------------------------------------------------
assign split_ctrl_inst_vld =
            lsd_split_type && lsd_inst_vld
         || amo_split_type && amo_inst_vld
         || che_split_type && che_inst_vld
         || fnc_split_type && fnc_inst_vld
         || fri_split_type && fri_inst_vld
         || frs_split_type && frs_inst_vld;

assign split_ctrl_id_stall =
            lsd_split_type && lsd_split_stall
         || amo_split_type && amo_split_stall
         || che_split_type && che_split_stall
         || fnc_split_type && fnc_split_stall
         || fri_split_type && fri_split_stall
         || frs_split_type && frs_split_stall;

assign split_inst_data[`IDU_WIDTH-1:0] =
         {`IDU_WIDTH{lsd_split_type}} & lsd_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{amo_split_type}} & amo_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{che_split_type}} & che_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{fnc_split_type}} & fnc_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{fri_split_type}} & fri_inst_data[`IDU_WIDTH-1:0]
       | {`IDU_WIDTH{frs_split_type}} & frs_inst_data[`IDU_WIDTH-1:0];

assign split_dp_inst_sel =
            lsd_split_type
         || amo_split_type
         || che_split_type
         || fnc_split_type
         || fri_split_type
         || frs_split_type;

//----------------------------------------------------------
//                    Packet Inst data
//----------------------------------------------------------
// &CombBeg; @647
always @( split_inst_data[264:0]
       or dp_split_inst[31:0])
begin
  split_dp_inst_data[`IDU_WIDTH-1:0]                    = split_inst_data[`IDU_WIDTH-1:0];
  if(1'b1) begin
  split_dp_inst_data[`IDU_OPCODE:`IDU_OPCODE-31]        = dp_split_inst[31:0];
  end 
// &CombEnd; @654
end

//----------------------------------------------------------
//                      For Debug info
//----------------------------------------------------------
assign split_top_cur_state_no_idle[0] = (lsd_cur_state != LSD_IDLE);
assign split_top_cur_state_no_idle[1] = (amo_cur_state[2:0] != AMO_IDLE);
assign split_top_cur_state_no_idle[2] = (che_cur_state != CHE_IDLE);
assign split_top_cur_state_no_idle[3] = (fnc_cur_state != FNC_IDLE);
assign split_top_cur_state_no_idle[4] = (fri_cur_state != FRI_IDLE);

//==========================================================
//                 Instance of Gated Cell
//==========================================================
assign split_clk_en = ifu_idu_id_inst_vld
                      && (amo_split_type
                       || lsd_split_type
                       || che_split_type
                       || fnc_split_type
                       || fri_split_type)
                      || (lsd_cur_state != LSD_IDLE)
                      || (amo_cur_state[2:0] != AMO_IDLE)
                      || (che_cur_state != CHE_IDLE)
                      || (fnc_cur_state != FNC_IDLE)
                      || (fri_cur_state != FRI_IDLE)
                      || (frs_cur_state != FRS_IDLE);
// &Instance("gated_clk_cell", "x_split_clk_gated_clk_cell"); @676
gated_clk_cell  x_split_clk_gated_clk_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (split_clk         ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (split_clk_en      ),
  .module_en          (cp0_idu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);
endmodule


