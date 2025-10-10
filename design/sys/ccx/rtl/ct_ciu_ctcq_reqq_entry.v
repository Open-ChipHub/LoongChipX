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
module ct_ciu_ctcq_reqq_entry (
  // &Ports, @23
  input    wire          ciu_icg_en,
  input    wire          cpurst_b,
  input    wire  [39:0]  ctc_dvm_addr,
  input    wire  [5 :0]  ctc_dvm_aim,
  input    wire  [4 :0]  ctc_dvm_id,
  input    wire  [2 :0]  ctc_dvm_mid,
  input    wire  [3 :0]  ctc_dvm_respq_id,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          reqq_create_en_x,
  input    wire          reqq_pop0_en_x,
  input    wire          reqq_pop1_en_x,
  input    wire          reqq_pop2_en_x,
  input    wire          reqq_pop3_en_x,
  input    wire          reqq_pop_ebiu_en_x,
  input    wire          reqq_popl2c_en_x,
  input    wire          reqq_resp_done_x,
  output   wire          reqq_ctc_x,
  output   wire          reqq_ebiu_aim_x,
  output   wire          reqq_ebiu_vld_x,
  output   wire  [39:0]  reqq_entryx_addr,
  output   wire  [1 :0]  reqq_entryx_l2ctype,
  output   wire  [2 :0]  reqq_entryx_mid,
  output   wire  [3 :0]  reqq_entryx_respq_id,
  output   wire  [4 :0]  reqq_entryx_rid,
  output   wire          reqq_l2c_aim_x,
  output   wire          reqq_l2c_vld_x,
  output   wire          reqq_piu0_aim_x,
  output   wire          reqq_piu0_vld_x,
  output   wire          reqq_piu1_aim_x,
  output   wire          reqq_piu1_vld_x,
  output   wire          reqq_piu2_aim_x,
  output   wire          reqq_piu2_vld_x,
  output   wire          reqq_piu3_aim_x,
  output   wire          reqq_piu3_vld_x,
  output   wire          reqq_resp_vld_x,
  output   wire          reqq_vld_x
); 



// &Regs; @24
reg     [39:0]  reqq_addr;           
reg     [5 :0]  reqq_aim;            
reg             reqq_ebiu_vld;       
reg             reqq_l2c_vld;        
reg     [2 :0]  reqq_mid;            
reg             reqq_piu0_vld;       
reg             reqq_piu1_vld;       
reg             reqq_piu2_vld;       
reg             reqq_piu3_vld;       
reg     [3 :0]  reqq_respq_id;       
reg     [4 :0]  reqq_rid;            
reg             reqq_vld;            
reg             resp_done;           

// &Wires; @25
wire            reqq_create_en;      
wire            reqq_entry_clk_en;   
wire            reqq_pop0_en;        
wire            reqq_pop1_en;        
wire            reqq_pop2_en;        
wire            reqq_pop3_en;        
wire            reqq_pop_ebiu_en;    
wire            reqq_pop_en;         
wire            reqq_popl2c_en;      
wire            reqq_resp_done;      
wire            reqqentyclk;         
wire            reqqentydpclk;       

parameter ADDRW = `PA_WIDTH;

//======================================
//    CTC req queue(reqq)
//entry content:
//| vld   |
//| piu0_vld | piu1_vld | piu2_vld | piu3_vld |
//| addr  | prot | //addr: ctc trans content
//| aim      |  [4]: L2 all inv
//              [3]: cpu3 inv
//              [2]: cpu2 inv
//              [1]: cpu1 inv
//              [0]: cpu0 inv
//======================================
assign reqq_pop_en = reqq_vld
                   & resp_done 
                   & !reqq_piu0_vld
                   & !reqq_piu1_vld
                   & !reqq_piu2_vld
                   & !reqq_piu3_vld
                   & !reqq_ebiu_vld
                   & !reqq_l2c_vld;

always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_vld <= 1'b1;
    else if(reqq_pop_en)
      reqq_vld <= 1'b0;
    else
      reqq_vld <= reqq_vld;
  end
end
always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    resp_done <= 1'b0;
  else if (reqq_create_en)
    resp_done <= 1'b0;
  else if (reqq_resp_done)
    resp_done <= 1'b1;
  else
    resp_done <= resp_done;
end
always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_piu0_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_piu0_vld <= 1'b1;
    else if(reqq_pop0_en)
      reqq_piu0_vld <= 1'b0;
    else
      reqq_piu0_vld <= reqq_piu0_vld;
  end
end
always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_piu1_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_piu1_vld <= 1'b1;
    else if(reqq_pop1_en)
      reqq_piu1_vld <= 1'b0;
    else
      reqq_piu1_vld <= reqq_piu1_vld;
  end
end
always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_piu2_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_piu2_vld <= 1'b1;
    else if(reqq_pop2_en)
      reqq_piu2_vld <= 1'b0;
    else
      reqq_piu2_vld <= reqq_piu2_vld;
  end
end
always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_piu3_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_piu3_vld <= 1'b1;
    else if(reqq_pop3_en)
      reqq_piu3_vld <= 1'b0;
    else
      reqq_piu3_vld <= reqq_piu3_vld;
  end
end
always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_ebiu_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_ebiu_vld <= 1'b1;
    else if(reqq_pop_ebiu_en)
      reqq_ebiu_vld <= 1'b0;
    else
      reqq_ebiu_vld <= reqq_ebiu_vld;
  end
end

always @(posedge reqqentyclk or negedge cpurst_b)
begin
  if(~cpurst_b)
    reqq_l2c_vld <= 1'b0;
  else
  begin
    if(reqq_create_en)
      reqq_l2c_vld <= 1'b1;
    else if(reqq_popl2c_en)
      reqq_l2c_vld <= 1'b0;
    else
      reqq_l2c_vld <= reqq_l2c_vld;
  end
end
//content
//l2 type[3:2] : l2c inv/clean
//l2 type[1]   : clean
//l2 type[0]   : inv
always @(posedge reqqentydpclk or negedge cpurst_b)
begin
  if(~cpurst_b)
  begin
    reqq_addr[ADDRW-1:0] <= {ADDRW{1'b0}};
    reqq_aim[5:0]        <= 6'b0;
    reqq_respq_id[3:0]   <= 4'b0; //corresponding resp entry
    reqq_rid[4:0]        <= 5'b0;
    reqq_mid[2:0]        <= 3'b0;
  end
  else if(reqq_create_en)
  begin
    reqq_addr[ADDRW-1:0] <= ctc_dvm_addr[ADDRW-1:0];
    reqq_aim[5:0]        <= ctc_dvm_aim[5:0];
    reqq_respq_id[3:0]   <= ctc_dvm_respq_id[3:0];
    reqq_rid[4:0]        <= ctc_dvm_id[4:0];
    reqq_mid[2:0]        <= ctc_dvm_mid[2:0];
  end
end

//==========================================================
//                 Gated Clk EN
//==========================================================
assign reqq_entry_clk_en =  reqq_create_en
                         || reqq_resp_done
                         || reqq_pop_en
                         || reqq_pop0_en
                         || reqq_pop1_en
                         || reqq_pop2_en
                         || reqq_pop3_en
                         || reqq_pop_ebiu_en
                         || reqq_popl2c_en;

// &Instance("gated_clk_cell","x_reqq_entry_gated_cell"); @196
gated_clk_cell  x_reqq_entry_gated_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (reqqentyclk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (reqq_entry_clk_en ),
  .module_en          (ciu_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (forever_cpuclk         ), @197
//           .clk_out          (reqqentyclk            ), @198
//           .external_en      (1'b0                   ), @199
//           .global_en        (1'b1                   ), @200
//           .local_en         (reqq_entry_clk_en      ), @201
//           .module_en (ciu_icg_en       ) @202
//         ); @203

// &Instance("gated_clk_cell","x_reqq_entry_dp_gated_cell"); @205
gated_clk_cell  x_reqq_entry_dp_gated_cell (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (reqqentydpclk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (reqq_create_en    ),
  .module_en          (ciu_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect( .clk_in           (forever_cpuclk         ), @206
//           .clk_out          (reqqentydpclk          ), @207
//           .external_en      (1'b0                   ), @208
//           .global_en        (1'b1                   ), @209
//           .local_en         (reqq_create_en         ), @210
//           .module_en (ciu_icg_en       ) @211
//         ); @212
//==========================================================
//                    input/output
//==========================================================
//input
assign reqq_create_en   = reqq_create_en_x;
assign reqq_resp_done   = reqq_resp_done_x;
assign reqq_pop0_en     = reqq_pop0_en_x;
assign reqq_pop1_en     = reqq_pop1_en_x;
assign reqq_pop2_en     = reqq_pop2_en_x;
assign reqq_pop3_en     = reqq_pop3_en_x;
assign reqq_pop_ebiu_en = reqq_pop_ebiu_en_x;
assign reqq_popl2c_en   = reqq_popl2c_en_x;
//output
assign reqq_vld_x       = reqq_vld;
assign reqq_resp_vld_x  = reqq_vld & !resp_done;
assign reqq_piu0_vld_x  = reqq_vld & reqq_piu0_vld;
assign reqq_piu1_vld_x  = reqq_vld & reqq_piu1_vld;
assign reqq_piu2_vld_x  = reqq_vld & reqq_piu2_vld;
assign reqq_piu3_vld_x  = reqq_vld & reqq_piu3_vld;
assign reqq_ebiu_vld_x  = reqq_vld & reqq_ebiu_vld;
assign reqq_l2c_vld_x   = reqq_vld & reqq_l2c_vld;
assign reqq_piu0_aim_x  = reqq_aim[0];
assign reqq_piu1_aim_x  = reqq_aim[1];
assign reqq_piu2_aim_x  = reqq_aim[2];
assign reqq_piu3_aim_x  = reqq_aim[3];
assign reqq_ebiu_aim_x  = reqq_aim[4];
assign reqq_l2c_aim_x   = reqq_aim[5];
assign reqq_ctc_x       = !reqq_mid[2];

assign reqq_entryx_addr[ADDRW-1:0] = reqq_addr[ADDRW-1:0];
assign reqq_entryx_respq_id[3:0]   = reqq_respq_id[3:0];
assign reqq_entryx_l2ctype[1:0]    = reqq_addr[17:16];
assign reqq_entryx_mid[2:0]        = reqq_mid[2:0];
assign reqq_entryx_rid[4:0]        = reqq_rid[4:0];

// &ModuleEnd; @252
endmodule



