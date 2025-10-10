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
module ct_ciu_apbif (
  // &Ports, @23
  input    wire           apb_clk_en,
  input    wire           ciu_apbif_had_pctrace_inv,
  input    wire           ciu_icg_en,
  input    wire  [31 :0]  core0_prdata_l2pmp,
  input    wire  [31 :0]  core1_prdata_l2pmp,
  input    wire  [31 :0]  core2_prdata_l2pmp,
  input    wire  [31 :0]  core3_prdata_l2pmp,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire           ncq_apbif_arvalid,
  input    wire           ncq_apbif_awvalid,
  input    wire           ncq_apbif_b_grant,
  input    wire           ncq_apbif_r_grant,
  input    wire           ncq_apbif_wvalid,
  input    wire  [39 :0]  ncq_xx_araddr,
  input    wire  [7  :0]  ncq_xx_arid,
  input    wire  [2  :0]  ncq_xx_arprot,
  input    wire           ncq_xx_aruser,
  input    wire           ncq_xx_aw_needissue,
  input    wire  [39 :0]  ncq_xx_awaddr,
  input    wire  [7  :0]  ncq_xx_awid,
  input    wire  [2  :0]  ncq_xx_awprot,
  input    wire           ncq_xx_awuser,
  input    wire  [127:0]  ncq_xx_wdata,
  input    wire           pad_yy_icg_scan_en,
  input    wire           perr_clint,
  input    wire           perr_had,
  input    wire  [3  :0]  perr_l2pmp,
  input    wire           perr_plic,
  input    wire           perr_rmr,
  input    wire  [31 :0]  prdata_clint,
  input    wire  [31 :0]  prdata_had,
  input    wire  [31 :0]  prdata_plic,
  input    wire  [31 :0]  prdata_rmr,
  input    wire           pready_clint,
  input    wire           pready_had,
  input    wire  [3  :0]  pready_l2pmp,
  input    wire           pready_plic,
  input    wire           pready_rmr,
  input    wire           regs_apbif_icg_en,
  output   wire           apbif_had_pctrace_inv,
  output   wire           apbif_ncq_ar_grant,
  output   wire           apbif_ncq_aw_grant,
  output   wire  [7  :0]  apbif_ncq_bid,
  output   wire  [1  :0]  apbif_ncq_bresp,
  output   wire           apbif_ncq_bvalid,
  output   wire  [127:0]  apbif_ncq_rdata,
  output   wire  [7  :0]  apbif_ncq_rid,
  output   wire           apbif_ncq_rlast,
  output   wire  [1  :0]  apbif_ncq_rresp,
  output   wire           apbif_ncq_rvalid,
  output   wire           apbif_ncq_w_grant,
  output   wire           ciu_clint_icg_en,
  output   wire           ciu_plic_icg_en,
  output   wire  [31 :0]  paddr,
  output   wire           penable,
  output   wire  [1  :0]  pprot,
  output   wire           psel_clint,
  output   wire           psel_had,
  output   wire  [3  :0]  psel_l2pmp,
  output   wire           psel_plic,
  output   wire           psel_rmr,
  output   wire  [31 :0]  pwdata,
  output   wire           pwrite
); 



// &Regs; @24
reg     [1  :0]  apb_cur_state;            
reg              apb_icg_en;               
reg     [1  :0]  apb_next_state;           
reg     [39 :0]  apbif_addr;               
reg     [7  :0]  apbif_id;                 
reg              apbif_needissue;          
reg     [1  :0]  apbif_prot;               
reg     [31 :0]  apbif_wdata;              
reg              apbif_write;              
reg     [31 :0]  rdata;                    
reg              resp_err;                 
reg     [7  :0]  resp_id;                  
reg              resp_vld;                 
reg              resp_wt;                  
reg     [7  :0]  sel;                      

// &Wires; @25
wire             apb_fsm_idle;             
wire             apb_fsm_pend;             
wire             apb_fsm_req;              
wire             apb_fsm_waddr;            
wire             apbif_clk;                
wire             apbif_clk_en;             
wire             apbif_req;                
wire             cmplt;                    
wire             l2pmp_sel;                
wire             perr;                     
wire    [31 :0]  prdata;                   
wire    [31 :0]  prdata_l2pmp;             
wire             pready;                   
wire             psel_none;                
wire             sel_clint;                
wire    [3  :0]  sel_core;                 
wire             sel_had;                  
wire             sel_l2pmp;                
wire             sel_plic;                 
wire             sel_rmr;                  


parameter ADDRW = `PA_WIDTH;
parameter IDLE  = 2'b00;
parameter WADDR = 2'b01;
parameter REQ   = 2'b10;
parameter PEND  = 2'b11;

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if(~cpurst_b)
    apb_cur_state[1:0] <= IDLE;
  else if (apb_clk_en)
    apb_cur_state[1:0] <= apb_next_state[1:0];
end

// &CombBeg; @41
always @( resp_vld
       or ncq_apbif_wvalid
       or cmplt
       or ncq_apbif_awvalid
       or apb_cur_state
       or ncq_apbif_arvalid)
begin
  case (apb_cur_state)
  IDLE: begin
    if (ncq_apbif_arvalid && !resp_vld)
      apb_next_state = REQ;
    else if (ncq_apbif_awvalid && !resp_vld)
      apb_next_state = WADDR;
    else
      apb_next_state = IDLE;
  end
  WADDR: begin
    if (ncq_apbif_wvalid)
      apb_next_state = REQ;
    else
      apb_next_state = WADDR;
  end
  REQ: begin
    apb_next_state = PEND;
  end
  PEND: begin
    if (cmplt)
      apb_next_state = IDLE;
    else
      apb_next_state = PEND;
  end
  default: apb_next_state = IDLE;
  endcase
// &CombEnd; @68
end

assign apb_fsm_idle  = (apb_cur_state == IDLE);
assign apb_fsm_waddr = (apb_cur_state == WADDR);
assign apb_fsm_req   = (apb_cur_state == REQ);
assign apb_fsm_pend  = (apb_cur_state == PEND);

assign apbif_ncq_aw_grant = ncq_apbif_awvalid && apb_fsm_idle && !ncq_apbif_arvalid && apb_clk_en && !resp_vld;
assign apbif_ncq_ar_grant = ncq_apbif_arvalid && apb_fsm_idle && apb_clk_en && !resp_vld;
assign apbif_ncq_w_grant  = ncq_apbif_wvalid  && apb_fsm_waddr && apb_clk_en;

assign apbif_req   = (apb_fsm_req || apb_fsm_pend) && apbif_needissue;

// &Force("bus", "ncq_xx_arprot",2,0); @81
// &Force("bus", "ncq_xx_awprot",2,0); @82

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)begin
    apbif_addr[ADDRW-1:0] <= {ADDRW{1'b0}}; 
    apbif_id[7:0]         <= 8'b0; 
    apbif_prot[1:0]       <= 2'b0; 
    apbif_needissue       <= 1'b0; 
    apbif_write           <= 1'b0;
  end
  else if (apb_clk_en && apb_fsm_idle)begin
    if (ncq_apbif_arvalid)
    begin
      apbif_addr[ADDRW-1:0] <= ncq_xx_araddr[ADDRW-1:0];
      apbif_id[7:0]         <= ncq_xx_arid[7:0];
      apbif_prot[1:0]       <= {ncq_xx_aruser,ncq_xx_arprot[0]};
      apbif_needissue       <= 1'b1;
      apbif_write           <= 1'b0;
    end
    else if (ncq_apbif_awvalid)
    begin
      apbif_addr[ADDRW-1:0] <= ncq_xx_awaddr[ADDRW-1:0];
      apbif_id[7:0]         <= ncq_xx_awid[7:0];
      apbif_prot[1:0]       <= {ncq_xx_awuser,ncq_xx_awprot[0]};
      apbif_needissue       <= ncq_xx_aw_needissue;
      apbif_write           <= 1'b1;
    end
  end
end

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    apbif_wdata[31:0] <= 32'b0;
  else if (ncq_apbif_wvalid && apb_fsm_waddr && apb_clk_en) 
  begin
    if (apbif_addr[3:2] == 2'b00)
      apbif_wdata[31:0] <= ncq_xx_wdata[31:0];
    else if (apbif_addr[3:2] == 2'b01)
      apbif_wdata[31:0] <= ncq_xx_wdata[63:32];
    else if (apbif_addr[3:2] == 2'b10)
      apbif_wdata[31:0] <= ncq_xx_wdata[95:64];
    else if (apbif_addr[3:2] == 2'b11)
      apbif_wdata[31:0] <= ncq_xx_wdata[127:96];
  end
end

//====================================================================
//      APB Bridge
//====================================================================
`define PLIC_BASE_START  1'b0
`define CLINT_BASE_START 11'h400
`define HAD_BASE_START   11'h401
`define L2PMP_BASE_START 11'h402
`define RMR_BASE_START   11'h403

assign apbif_had_pctrace_inv = ciu_apbif_had_pctrace_inv;

assign sel_plic  = (apbif_addr[26] == `PLIC_BASE_START);
assign sel_clint = (apbif_addr[26:16] == `CLINT_BASE_START);
assign sel_had   = (apbif_addr[26:16] == `HAD_BASE_START);
assign sel_l2pmp = (apbif_addr[26:16] == `L2PMP_BASE_START);
assign sel_rmr   = (apbif_addr[26:16] == `RMR_BASE_START);

assign psel_plic    = apbif_req && sel_plic;
assign psel_clint   = apbif_req && sel_clint;
assign psel_had     = apbif_req && sel_had;
assign pwrite       = apbif_write;
assign paddr[31:0]  = apbif_addr[31:0];
assign pwdata[31:0] = apbif_wdata[31:0];
assign penable      = apb_fsm_pend;
assign pprot[1:0]   = apbif_prot[1:0];


assign sel_core[3:0]   = (4'b1 << apbif_addr[15:14]) & {4{sel_l2pmp}};
assign psel_l2pmp[3:0] = {4{apbif_req}} & sel_core[3:0];
assign psel_rmr  = apbif_req && sel_rmr;

always @(posedge forever_cpuclk or negedge cpurst_b)
begin
  if (!cpurst_b)
    apb_icg_en <= 1'b0;
  else if (apb_clk_en)
    apb_icg_en <= regs_apbif_icg_en;
  else 
    apb_icg_en <= apb_icg_en;
end

assign ciu_plic_icg_en  = apb_icg_en;
assign ciu_clint_icg_en = apb_icg_en;

//--------------------------------------
//   input from apb
//--------------------------------------
always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    sel[7:0] <= 8'b0;
  else if (apb_fsm_req)
    sel[7:0] <= {sel_rmr,sel_core[3:0],sel_had,sel_clint,sel_plic};
end

assign prdata_l2pmp[31:0] = {32{sel[3]}} & core0_prdata_l2pmp[31:0] |
                            {32{sel[4]}} & core1_prdata_l2pmp[31:0] |
                            {32{sel[5]}} & core2_prdata_l2pmp[31:0] |
                            {32{sel[6]}} & core3_prdata_l2pmp[31:0];

assign prdata[31:0] = {32{sel[0]}}    & prdata_plic[31:0] |
                      {32{sel[1]}}    & prdata_clint[31:0] |
                      {32{sel[2]}}    & prdata_had[31:0] | 
                      {32{l2pmp_sel}} & prdata_l2pmp[31:0] |
                      {32{sel[7]}}    & prdata_rmr[31:0];

assign l2pmp_sel = |sel[6:3];

//assign pready = apbif_req && |(sel[2:0] & {pready_had,pready_clint,pready_plic});
assign pready = |(sel[7:0] & {pready_rmr,pready_l2pmp[3:0],pready_had,pready_clint,pready_plic});

assign perr   = |(sel[7:0] & {perr_rmr,perr_l2pmp[3:0],perr_had,perr_clint,perr_plic} ) || !(|sel[7:0]);

assign psel_none =  apb_fsm_pend && (!(|sel[7:0]) || !apbif_needissue);

assign cmplt = apb_fsm_pend && pready || psel_none;

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    resp_vld <= 1'b0;
  else if (cmplt && apb_clk_en)
    resp_vld <= 1'b1;
  else if (ncq_apbif_r_grant || ncq_apbif_b_grant)
    resp_vld <= 1'b0;
end

always @(posedge apbif_clk or negedge cpurst_b)
begin
  if (!cpurst_b)begin
    rdata[31:0]  <= 32'b0;
    resp_err     <= 1'b0;
    resp_id[7:0] <= 8'b0;
    resp_wt      <= 1'b0;
  end
  else if (cmplt && apb_clk_en)
  begin
    rdata[31:0]  <= prdata[31:0];
    resp_err     <= perr;
    resp_id[7:0] <= apbif_id[7:0];
    resp_wt      <= apbif_write;
  end
end

assign apbif_ncq_rvalid       = !resp_wt && resp_vld; 
assign apbif_ncq_rdata[127:0] = {4{rdata[31:0]}};
assign apbif_ncq_rresp[1:0]   = {resp_err,1'b0};
assign apbif_ncq_rid[7:0]     = resp_id[7:0];
assign apbif_ncq_rlast        = 1'b1;

assign apbif_ncq_bvalid       = resp_wt && resp_vld; 
assign apbif_ncq_bid[7:0]     = resp_id[7:0];
assign apbif_ncq_bresp[1:0]   = {resp_err,1'b0};

//==========================================================
//     ICG
//==========================================================
assign apbif_clk_en = ncq_apbif_r_grant | ncq_apbif_b_grant | 
                      apb_clk_en & apb_fsm_idle & (ncq_apbif_arvalid | ncq_apbif_awvalid) |
                      apb_clk_en & !apb_fsm_idle;

// &Instance("gated_clk_cell", "x_apbif_gated_clk"); @258
gated_clk_cell  x_apbif_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (apbif_clk         ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (apbif_clk_en      ),
  .module_en          (ciu_icg_en        ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @259
//          .external_en (1'b0), @260
//          .global_en   (1'b1), @261
//          .module_en (ciu_icg_en       ), @262
//          .local_en    (apbif_clk_en), @263
//          .clk_out     (apbif_clk)); @264

// &ModuleEnd; @266
endmodule



