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

// &Depend("cpu_cfig.h"); @18
// &Depend("aq_lsu_cfig.h"); @19

// &ModuleBeg; @21
module aq_lsu_mcic (
  // &Ports, @22
  input    wire          arb_mcic_grant,
  input    wire          cp0_lsu_icg_en,
  input    wire  [1 :0]  cp0_lsu_mpp,
  input    wire          cp0_lsu_mprv,
  input    wire  [1 :0]  cp0_yy_priv_mode,
  input    wire          cpurst_b,
  input    wire          dc_ag_stall,
  input    wire          dc_mcic_bus_err,
  input    wire  [63:0]  dc_mcic_data,
  input    wire          dc_mcic_data_vld,
  input    wire          dc_xx_dcache_req_mask,
  input    wire          forever_cpuclk,
  input    wire          icc_xx_idle,
  input    wire          mmu_lsu_data_req,
  input    wire  [39:0]  mmu_lsu_data_req_addr,
  input    wire          mmu_lsu_data_req_size,
  input    wire          pad_yy_icg_scan_en,
  output   wire          lsu_mmu_bus_error,
  output   wire  [63:0]  lsu_mmu_data,
  output   wire          lsu_mmu_data_vld,
  output   wire          mcic_ag_stall,
  output   wire  [13:0]  mcic_arb_data_idx,
  output   wire          mcic_arb_data_req,
  output   wire  [3 :0]  mcic_arb_data_way,
  output   wire  [11:0]  mcic_arb_tag_idx,
  output   wire          mcic_arb_tag_req,
  output   wire  [3 :0]  mcic_arb_tag_sel,
  output   wire  [3 :0]  mcic_arb_tag_way,
  output   wire  [39:0]  mcic_dc_addr,
  output   wire  [7 :0]  mcic_dc_bytes_vld,
  output   wire  [1 :0]  mcic_dc_priv_mode,
  output   wire          mcic_dc_req
); 



// &Regs; @23
reg     [7 :0]  mmu_bytes_vld;        
reg     [1 :0]  ptw_cur_state;        
reg     [1 :0]  ptw_next_state;       

// &Wires; @24
wire            dcache_req_mask;      
wire    [63:0]  mcic_data;            
wire            mcic_data_error;      
wire            mcic_data_vld;        
wire            mcic_dcache_grnt;     
wire    [39:0]  ptw_addr;             
wire            ptw_clk;              
wire            ptw_clk_en;           
wire            ptw_dcache_grant;     
wire            ptw_dcache_req;       
wire            ptw_frz;              
wire            ptw_req;              
wire            ptw_size;             


//================================================
//        input interface
//================================================
//from mmu
assign ptw_req  = mmu_lsu_data_req;
assign ptw_size = mmu_lsu_data_req_size;

assign ptw_addr[`PA_WIDTH-1:0] = mmu_lsu_data_req_addr[`PA_WIDTH-1:0];

//from dcache arb
assign mcic_dcache_grnt = arb_mcic_grant;

//from cache or bus
assign mcic_data_vld         = dc_mcic_data_vld;
assign mcic_data_error       = dc_mcic_bus_err;
assign mcic_data[63:0]       = dc_mcic_data[63:0];

//from others
assign dcache_req_mask = dc_xx_dcache_req_mask;

//================================================
//        FSM CTRL
//================================================
parameter PTW_IDLE       = 2'b00;
parameter PTW_REQ_DCACHE = 2'b01;
parameter PTW_WAIT_DATA  = 2'b10;

assign ptw_clk_en = ptw_req; 

// &Instance("gated_clk_cell", "x_aq_lsu_ptw_gated_clk"); @55
gated_clk_cell  x_aq_lsu_ptw_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (ptw_clk           ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (ptw_clk_en        ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @56
//          .external_en (1'b0), @57
//          .global_en   (1'b1), @58
//          .module_en   (cp0_lsu_icg_en), @59
//          .local_en    (ptw_clk_en), @60
//          .clk_out     (ptw_clk)); @61

always@(posedge ptw_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    ptw_cur_state[1:0] <= PTW_IDLE;
  else
    ptw_cur_state[1:0] <= ptw_next_state[1:0];
end
      
// &CombBeg; @71
always @( ptw_cur_state[1:0]
       or mcic_data_vld
       or ptw_req
       or mcic_data_error
       or ptw_dcache_grant)
begin
  case (ptw_cur_state[1:0])
    PTW_IDLE:begin
      if (ptw_dcache_grant)
        ptw_next_state[1:0] = PTW_WAIT_DATA;
      else if(ptw_req)
        ptw_next_state[1:0] = PTW_REQ_DCACHE;
      else
        ptw_next_state[1:0] = PTW_IDLE;
    end
    PTW_REQ_DCACHE:begin
      if (ptw_dcache_grant)
        ptw_next_state[1:0] = PTW_WAIT_DATA;
      else
        ptw_next_state[1:0] = PTW_REQ_DCACHE;
    end
    PTW_WAIT_DATA:begin
      if (mcic_data_vld || mcic_data_error)
        ptw_next_state[1:0] = PTW_IDLE;
      else
        ptw_next_state[1:0] = PTW_WAIT_DATA;
    end
    default: ptw_next_state[1:0] = PTW_IDLE;
  endcase
// &CombEnd; @95
end

assign ptw_frz = (ptw_cur_state[1:0] == PTW_WAIT_DATA);

assign ptw_dcache_req = ptw_req && !ptw_frz && !dcache_req_mask && icc_xx_idle;

assign ptw_dcache_grant = ptw_dcache_req && mcic_dcache_grnt && !dc_ag_stall;
//================================================
//        data path
//================================================
//----------bytes_vld--------------------------
// &CombBeg; @106
always @( ptw_size
       or ptw_addr[2])
begin
case({ptw_size,ptw_addr[2]})
  2'b00:mmu_bytes_vld[7:0]  = 8'h0f;
  2'b01:mmu_bytes_vld[7:0]  = 8'hf0;
  2'b10:mmu_bytes_vld[7:0]  = 8'hff;
  default:mmu_bytes_vld[7:0] = 8'h0;
endcase
// &CombEnd; @113
end

//----------return data--------------------------


//================================================
//        output interface
//================================================
//for mmu
assign lsu_mmu_data_vld   = mcic_data_vld;
assign lsu_mmu_data[63:0] = mcic_data[63:0];
assign lsu_mmu_bus_error  = mcic_data_error;
//----------dcache interface---------------------
assign mcic_arb_tag_req       = ptw_dcache_req; 
assign mcic_arb_tag_idx[11:0] = ptw_addr[11:0];
assign mcic_arb_tag_way[3:0]  = 4'b1111;
assign mcic_arb_tag_sel[3:0]  = 4'b1111;

assign mcic_arb_data_req       = ptw_dcache_req;
assign mcic_arb_data_way[3:0]  = 4'b1111;
assign mcic_arb_data_idx[13:0] = ptw_addr[13:0];
//----------pipedown to dc---------------------
assign mcic_dc_req                 = ptw_dcache_req && mcic_dcache_grnt;
assign mcic_dc_addr[`PA_WIDTH-1:0] = ptw_addr[`PA_WIDTH-1:0];
assign mcic_dc_bytes_vld[7:0]      = mmu_bytes_vld[7:0];
assign mcic_dc_priv_mode[1:0]      = cp0_lsu_mprv 
                                     ? cp0_lsu_mpp[1:0]
                                     : cp0_yy_priv_mode[1:0];
//----------others----------------------------
assign mcic_ag_stall = ptw_dcache_req;

// &ModuleEnd; @148
endmodule


