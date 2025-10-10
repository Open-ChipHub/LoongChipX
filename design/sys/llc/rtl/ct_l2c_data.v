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
module ct_l2c_data #(
    parameter TAG_TAG_LENTH     = `L2C_TAG_DATA_WIDTH,
    parameter DATA_INDEX_LENTH  = `L2C_DATA_INDEX_WIDTH,
    parameter TAG_INDEX_WIDTH   = `L2C_TAG_INDEX_WIDTH
)(
  // &Ports, @22
  input    wire  [3  :0]  ciu_l2c_data_acc_cycle,
  input    wire           ciu_l2c_data_setup,
  input    wire  [511:0]  cmp_data_din,
  input    wire  [DATA_INDEX_LENTH-1 :0]  cmp_data_index,
  input    wire           cmp_data_req,
  input    wire           cmp_data_req_gate,
  input    wire           cmp_data_wen,
  input    wire  [32 :0]  cmp_stage_addr,
  input    wire  [3  :0]  cmp_stage_cp,
  input    wire  [4  :0]  cmp_stage_resp,
  input    wire  [4  :0]  cmp_stage_sid,
  input    wire  [1  :0]  cmp_stage_src,
  input    wire           cmp_stage_write,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire  [4  :0]  icc_data_cen,
  input    wire           icc_data_flop,
  input    wire  [DATA_INDEX_LENTH-1 :0]  icc_data_index,
  input    wire           icc_data_req,
  input    wire           l2c_clk,
  input    wire  [511:0]  l2c_data_dout,
  input    wire           l2c_icg_en,
  input    wire           pad_yy_icg_scan_en,
  output   wire           data_ecc_ram_cen,
  output   wire           data_ecc_wen,
  output   wire           data_icc_grant,
  output   reg   [3  :0]  data_stage_cp,
  output   reg   [6  :0]  data_stage_index,
  output   reg   [4  :0]  data_stage_resp,
  output   reg   [4  :0]  data_stage_sid,
  output   reg            data_stage_vld,
  output   wire           data_xx_idle,
  output   wire           data_yy_flop_vld,
  output   wire           data_yy_ram_idle,
  output   reg   [511:0]  l2c_data_din,
  output   reg   [511:0]  l2c_data_dout_flop,
  output   reg   [DATA_INDEX_LENTH-1 :0]  l2c_data_index0,
  output   reg   [DATA_INDEX_LENTH-1 :0]  l2c_data_index1,
  output   reg   [DATA_INDEX_LENTH-1 :0]  l2c_data_index2,
  output   reg   [DATA_INDEX_LENTH-1 :0]  l2c_data_index3,
  output   wire  [3  :0]  l2c_data_ram_cen,
  output   wire           l2c_data_ram_clk_en_x,
  output   wire  [3  :0]  l2c_data_wen
); 



// &Regs; @23
reg     [3  :0]  data_acc_cnt;          
reg     [4  :0]  data_ram_cen;          
reg              data_ram_next_state;   
reg              data_ram_state;        
reg     [4  :0]  data_ram_wen;          
reg     [1  :0]  data_stage_src;        
reg     [4  :0]  l2c_data_cen_flop;     
reg     [511:0]  l2c_data_din_flop;     
reg     [DATA_INDEX_LENTH-1 :0]  l2c_data_index0_flop;  
reg     [DATA_INDEX_LENTH-1 :0]  l2c_data_index1_flop;  
reg     [DATA_INDEX_LENTH-1 :0]  l2c_data_index2_flop;  
reg     [DATA_INDEX_LENTH-1 :0]  l2c_data_index3_flop;  
reg     [4  :0]  l2c_data_wen_flop;     

// &Wires; @24
wire             data_acc_cnt_en;       
wire             data_acc_cnt_init;     
wire             data_acc_cnt_zero;     
wire             data_cen_clk;          
wire             data_cen_clk_en;       
wire             data_cnt_clk;          
wire             data_cnt_clk_en;       
wire             data_dout_clk;         
wire             data_dp_clk;           
wire             data_dp_clk_en;        
wire             data_flop_clk;         
wire             data_flop_clk_en;      
wire             data_flop_vld;         
wire             data_ram_cen_gate;     
wire             data_ram_idle;         
wire             data_req_vld;          
wire             data_req_vld_gate;     
wire    [511:0]  l2c_data_din_pre;      
wire    [DATA_INDEX_LENTH-1 :0]  l2c_data_index_pre;    
wire    [4  :0]  l2c_data_ram_cen_pre;  
wire             l2c_data_wen_pre;      



parameter L2C_ADDRW        = 33;

// &Force("output","data_stage_vld"); @29

//==============================================================================
//                   control signals for DATA array
//==============================================================================
assign data_cen_clk_en = data_req_vld_gate && data_ram_idle && ciu_l2c_data_setup || !data_ram_idle;

// &Instance("gated_clk_cell", "x_l2c_data_cen_gated_clk"); @36
gated_clk_cell  x_l2c_data_cen_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (data_cen_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (data_cen_clk_en   ),
  .module_en          (l2c_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @37
//          .external_en   (1'b0               ), @38
//          .global_en     (1'b1               ), @39
//          .module_en     (l2c_icg_en     ), @40
//          .local_en      (data_cen_clk_en    ), @41
//          .clk_out       (data_cen_clk       ) @42
//         ); @43

assign data_cnt_clk_en = data_req_vld_gate && data_ram_idle || data_acc_cnt_en;
// &Instance("gated_clk_cell", "x_l2c_data_cnt_gated_clk"); @46
gated_clk_cell  x_l2c_data_cnt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (data_cnt_clk      ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (data_cnt_clk_en   ),
  .module_en          (l2c_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @47
//          .external_en   (1'b0               ), @48
//          .global_en     (1'b1               ), @49
//          .module_en (l2c_icg_en     ), @50
//          .local_en      (data_cnt_clk_en    ), @51
//          .clk_out       (data_cnt_clk       ) @52
//         ); @53

assign data_dp_clk_en = data_ram_cen_gate;
// &Instance("gated_clk_cell", "x_l2c_data_dp_gated_clk"); @56
gated_clk_cell  x_l2c_data_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (data_dp_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (data_dp_clk_en    ),
  .module_en          (l2c_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @57
//          .external_en   (1'b0               ), @58
//          .global_en     (1'b1               ), @59
//          .module_en (l2c_icg_en     ), @60
//          .local_en      (data_dp_clk_en    ), @61
//          .clk_out       (data_dp_clk       ) @62
//         ); @63

assign data_flop_clk_en = data_ram_cen_gate && ciu_l2c_data_setup;
// &Instance("gated_clk_cell", "x_l2c_data_flop_gated_clk"); @66
gated_clk_cell  x_l2c_data_flop_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (data_flop_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (data_flop_clk_en  ),
  .module_en          (l2c_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @67
//          .external_en   (1'b0               ), @68
//          .global_en     (1'b1               ), @69
//          .module_en (l2c_icg_en     ), @70
//          .local_en      (data_flop_clk_en   ), @71
//          .clk_out       (data_flop_clk      ) @72
//         ); @73

// &Instance("gated_clk_cell", "x_l2c_data_dout_gated_clk"); @75
gated_clk_cell  x_l2c_data_dout_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (data_dout_clk     ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (data_flop_vld     ),
  .module_en          (l2c_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @76
//          .external_en   (1'b0               ), @77
//          .global_en     (1'b1               ), @78
//          .module_en (l2c_icg_en     ), @79
//          .local_en      (data_flop_vld      ), @80
//          .clk_out       (data_dout_clk      ) @81
//         ); @82

//==============================================================================
//             interface with data array
//==============================================================================

assign data_req_vld = icc_data_req || cmp_data_req;
assign data_req_vld_gate = icc_data_req || cmp_data_req_gate;

//------------------------------------------------
//      data ram pre
//------------------------------------------------

assign data_ram_cen_gate         = data_req_vld_gate & data_ram_idle; 
assign l2c_data_ram_cen_pre[4:0] = (icc_data_cen[4:0] | {5{cmp_data_req}}) & {5{data_ram_idle}};

assign l2c_data_index_pre[DATA_INDEX_LENTH-1:0] 
                               = icc_data_req 
                               ? icc_data_index[DATA_INDEX_LENTH-1:0] 
                               : cmp_data_index[DATA_INDEX_LENTH-1:0];
assign l2c_data_wen_pre        = cmp_data_wen;
assign l2c_data_din_pre[511:0] = cmp_data_din[511:0];

//------------------------------------------------
//       data ram flop
//------------------------------------------------

always@(posedge data_cen_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    l2c_data_cen_flop[4:0] <= 5'b0;
  else if(data_req_vld && data_ram_idle && ciu_l2c_data_setup)
    l2c_data_cen_flop[4:0] <= l2c_data_ram_cen_pre[4:0];
  else 
    l2c_data_cen_flop[4:0] <= 5'b0;
end


always@(posedge data_flop_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    l2c_data_index0_flop[DATA_INDEX_LENTH-1:0] <= {DATA_INDEX_LENTH{1'b0}};
    l2c_data_index1_flop[DATA_INDEX_LENTH-1:0] <= {DATA_INDEX_LENTH{1'b0}};
    l2c_data_index2_flop[DATA_INDEX_LENTH-1:0] <= {DATA_INDEX_LENTH{1'b0}};
    l2c_data_index3_flop[DATA_INDEX_LENTH-1:0] <= {DATA_INDEX_LENTH{1'b0}};
    l2c_data_din_flop[511:0]                  <= 512'b0;
    l2c_data_wen_flop[4:0]                    <= 5'b0;
//    l2c_data_ram_clk_en_flop                  <= 1'b0;
  end
  else if(data_ram_cen_gate && ciu_l2c_data_setup)
  begin
    l2c_data_index0_flop[DATA_INDEX_LENTH-1:0] <= l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
    l2c_data_index1_flop[DATA_INDEX_LENTH-1:0] <= l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
    l2c_data_index2_flop[DATA_INDEX_LENTH-1:0] <= l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
    l2c_data_index3_flop[DATA_INDEX_LENTH-1:0] <= l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
    l2c_data_din_flop[511:0]                  <= l2c_data_din_pre[511:0];
    l2c_data_wen_flop[4:0]                    <= {5{l2c_data_wen_pre}};
//    l2c_data_ram_clk_en_flop                  <= data_ram_cen_gate;
  end
end

//------------------------------------------------
//         Data Ram select
//------------------------------------------------

// &CombBeg; @154
always @( l2c_data_index1_flop[12:0]
       or l2c_data_cen_flop[4:0]
       or l2c_data_ram_cen_pre[4:0]
       or l2c_data_din_flop[511:0]
       or l2c_data_index0_flop[12:0]
       or l2c_data_index_pre[12:0]
       or l2c_data_wen_flop[4:0]
       or ciu_l2c_data_setup
       or l2c_data_index3_flop[12:0]
       or l2c_data_din_pre[511:0]
       or l2c_data_wen_pre
       or l2c_data_index2_flop[12:0])
begin
if(ciu_l2c_data_setup)
begin
  l2c_data_index0[DATA_INDEX_LENTH-1:0] =  l2c_data_index0_flop[DATA_INDEX_LENTH-1:0];
  l2c_data_index1[DATA_INDEX_LENTH-1:0] =  l2c_data_index1_flop[DATA_INDEX_LENTH-1:0];
  l2c_data_index2[DATA_INDEX_LENTH-1:0] =  l2c_data_index2_flop[DATA_INDEX_LENTH-1:0];
  l2c_data_index3[DATA_INDEX_LENTH-1:0] =  l2c_data_index3_flop[DATA_INDEX_LENTH-1:0];
  data_ram_cen[4:0]                    = ~l2c_data_cen_flop[4:0];
  l2c_data_din[511:0]                  =  l2c_data_din_flop[511:0];
  data_ram_wen[4:0]                    = ~l2c_data_wen_flop[4:0];
//  l2c_data_ram_clk_en_x                =  l2c_data_ram_clk_en_flop;
end
else
begin
  l2c_data_index0[DATA_INDEX_LENTH-1:0] =  l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
  l2c_data_index1[DATA_INDEX_LENTH-1:0] =  l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
  l2c_data_index2[DATA_INDEX_LENTH-1:0] =  l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
  l2c_data_index3[DATA_INDEX_LENTH-1:0] =  l2c_data_index_pre[DATA_INDEX_LENTH-1:0];
  data_ram_cen[4:0]                    = ~l2c_data_ram_cen_pre[4:0];
  l2c_data_din[511:0]                  =  l2c_data_din_pre[511:0];
  data_ram_wen[4:0]                    = {5{~l2c_data_wen_pre}};
//  l2c_data_ram_clk_en_x                =  data_ram_cen_gate;
end
// &CombEnd; @183
end

// &Force("nonport", "l2c_data_src"); @186

assign l2c_data_ram_clk_en_x = |(~data_ram_cen[4:0]);

assign l2c_data_ram_cen[3:0] = data_ram_cen[3:0];
assign l2c_data_wen[3:0]     = data_ram_wen[3:0];
assign data_ecc_ram_cen      = data_ram_cen[4];
assign data_ecc_wen          = data_ram_wen[4];

//==============================================================================
//                    DATA STAGE
//==============================================================================
//from data stage, icc and cmp_rdl begin to update data_stage 
// &Force("bus","cmp_stage_addr",L2C_ADDRW-1,0); @205

always@(posedge l2c_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    data_stage_vld <= 1'b0;
  else if (cmp_data_req & !cmp_stage_write & data_ram_idle)
    data_stage_vld <= 1'b1;
  else if (data_acc_cnt_zero)
    data_stage_vld <= 1'b0;
end

// &Force("nonport", "data_stage_src"); @217
always@(posedge data_dp_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
  begin
    data_stage_sid[4:0]      <= 5'b0;
    data_stage_src[1:0]      <= 2'b0;
    data_stage_resp[4:0]     <= 5'b0;
    data_stage_cp[3:0]       <= 4'b0;
    data_stage_index[6:0]    <= 7'b0;
  end
  else if(cmp_data_req_gate && data_ram_idle)
  begin
    data_stage_sid[4:0]    <= cmp_stage_sid[4:0];
    data_stage_src[1:0]    <= cmp_stage_src[1:0];
    data_stage_resp[4:0]   <= cmp_stage_resp[4:0];
    data_stage_cp[3:0]     <= cmp_stage_cp[3:0];
    data_stage_index[6:0]  <= cmp_stage_addr[6:0];
  end
end

//==============================================================================
//                           DATA RAM STATE MACHINE CTRL
//==============================================================================
// IDLE -> BUSY
// A: request in compare stage has DATA RAM access requirement (!read miss)
// B: request is ready (read hit || write && write data is ready)
// BUSY -> BUSY
// A: access counter isn't 0 (is dealing with the current req)
// B: access counter is 0    (the current req is dealt)
//    compare stage has a DATA RAM access request
//    cmp request is ready (read hit || write && write data is ready)
//------------------------------------------------------------------------------

parameter DATA_IDLE = 1'b0;
parameter DATA_BUSY = 1'b1;

always@(posedge l2c_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    data_ram_state <= DATA_IDLE;
  else
    data_ram_state <= data_ram_next_state;
end

// &CombBeg; @272
always @( data_ram_state
       or data_req_vld
       or data_acc_cnt_zero)
begin
  data_ram_next_state = DATA_IDLE;
  case(data_ram_state)
    DATA_IDLE:
    begin
      if(data_req_vld)
        data_ram_next_state      = DATA_BUSY;
      else
        data_ram_next_state      = DATA_IDLE;
    end
    DATA_BUSY:
    begin
      if(!data_acc_cnt_zero || data_req_vld)
        data_ram_next_state      = DATA_BUSY;
      else
        data_ram_next_state      = DATA_IDLE;
    end
    default: data_ram_next_state = DATA_IDLE;
  endcase
// &CombEnd; @291
end

assign data_xx_idle      = data_ram_state == DATA_IDLE;
assign data_acc_cnt_zero = (data_acc_cnt[3:0] == 4'b0);
assign data_ram_idle     = (data_ram_state == DATA_IDLE) ||
                           (data_ram_state == DATA_BUSY) && data_acc_cnt_zero;
assign data_acc_cnt_init = data_ram_idle && data_req_vld;
assign data_acc_cnt_en   = data_ram_state && !data_acc_cnt_zero;

always@(posedge data_cnt_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    data_acc_cnt[3:0] <= 4'b0;
  else if(data_acc_cnt_init)
    data_acc_cnt[3:0] <= ciu_l2c_data_acc_cycle[3:0];
  else if(data_acc_cnt_en)
    data_acc_cnt[3:0] <= data_acc_cnt[3:0] - 4'b1;
  else
    data_acc_cnt[3:0] <= data_acc_cnt[3:0];
end

assign data_flop_vld = (data_stage_vld | icc_data_flop) & data_acc_cnt_zero;

assign data_yy_ram_idle  = data_ram_idle;
assign data_yy_flop_vld  = data_stage_vld & data_acc_cnt_zero;


always@(posedge data_dout_clk or negedge cpurst_b)
begin
  if(!cpurst_b)
    l2c_data_dout_flop[511:0] <= 512'b0;
  else if(data_flop_vld)
    l2c_data_dout_flop[511:0] <= l2c_data_dout[511:0];
end

assign data_icc_grant    = data_ram_idle;

// &ModuleEnd; @331
endmodule


