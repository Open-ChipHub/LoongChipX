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

// &ModuleBeg; @23
module ct_lsu_dcache_arb (
  // &Ports, @24
  input    wire  [7  :0]  ag_dcache_arb_ld_data_gateclk_en,
  input    wire  [10 :0]  ag_dcache_arb_ld_data_high_idx,
  input    wire  [10 :0]  ag_dcache_arb_ld_data_low_idx,
  input    wire  [7  :0]  ag_dcache_arb_ld_data_req,
  input    wire           ag_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  ag_dcache_arb_ld_tag_idx,
  input    wire           ag_dcache_arb_ld_tag_req,
  input    wire           ag_dcache_arb_st_dirty_gateclk_en,
  input    wire  [8  :0]  ag_dcache_arb_st_dirty_idx,
  input    wire           ag_dcache_arb_st_dirty_req,
  input    wire           ag_dcache_arb_st_tag_gateclk_en,
  input    wire  [8  :0]  ag_dcache_arb_st_tag_idx,
  input    wire           ag_dcache_arb_st_tag_req,
  input    wire           cp0_lsu_icg_en,
  input    wire           cpurst_b,
  input    wire           forever_cpuclk,
  input    wire           icc_dcache_arb_data_way,
  input    wire           icc_dcache_arb_ld_borrow_req,
  input    wire  [7  :0]  icc_dcache_arb_ld_data_gateclk_en,
  input    wire  [10 :0]  icc_dcache_arb_ld_data_high_idx,
  input    wire  [10 :0]  icc_dcache_arb_ld_data_low_idx,
  input    wire  [7  :0]  icc_dcache_arb_ld_data_req,
  input    wire           icc_dcache_arb_ld_req,
  input    wire           icc_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  icc_dcache_arb_ld_tag_idx,
  input    wire           icc_dcache_arb_ld_tag_read,
  input    wire           icc_dcache_arb_ld_tag_req,
  input    wire           icc_dcache_arb_st_borrow_req,
  input    wire  [6  :0]  icc_dcache_arb_st_dirty_din,
  input    wire           icc_dcache_arb_st_dirty_gateclk_en,
  input    wire           icc_dcache_arb_st_dirty_gwen,
  input    wire  [8  :0]  icc_dcache_arb_st_dirty_idx,
  input    wire           icc_dcache_arb_st_dirty_req,
  input    wire  [6  :0]  icc_dcache_arb_st_dirty_wen,
  input    wire           icc_dcache_arb_st_req,
  input    wire           icc_dcache_arb_st_tag_gateclk_en,
  input    wire  [8  :0]  icc_dcache_arb_st_tag_idx,
  input    wire           icc_dcache_arb_st_tag_req,
  input    wire           icc_dcache_arb_way,
  input    wire  [7  :0]  lfb_dcache_arb_ld_data_gateclk_en,
  input    wire  [127:0]  lfb_dcache_arb_ld_data_high_din,
  input    wire  [10 :0]  lfb_dcache_arb_ld_data_idx,
  input    wire  [127:0]  lfb_dcache_arb_ld_data_low_din,
  input    wire           lfb_dcache_arb_ld_req,
  input    wire  [53 :0]  lfb_dcache_arb_ld_tag_din,
  input    wire           lfb_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  lfb_dcache_arb_ld_tag_idx,
  input    wire           lfb_dcache_arb_ld_tag_req,
  input    wire  [1  :0]  lfb_dcache_arb_ld_tag_wen,
  input    wire           lfb_dcache_arb_serial_req,
  input    wire  [6  :0]  lfb_dcache_arb_st_dirty_din,
  input    wire           lfb_dcache_arb_st_dirty_gateclk_en,
  input    wire  [8  :0]  lfb_dcache_arb_st_dirty_idx,
  input    wire           lfb_dcache_arb_st_dirty_req,
  input    wire  [6  :0]  lfb_dcache_arb_st_dirty_wen,
  input    wire           lfb_dcache_arb_st_req,
  input    wire  [51 :0]  lfb_dcache_arb_st_tag_din,
  input    wire           lfb_dcache_arb_st_tag_gateclk_en,
  input    wire  [8  :0]  lfb_dcache_arb_st_tag_idx,
  input    wire           lfb_dcache_arb_st_tag_req,
  input    wire  [1  :0]  lfb_dcache_arb_st_tag_wen,
  input    wire  [7  :0]  mcic_dcache_arb_ld_data_gateclk_en,
  input    wire  [10 :0]  mcic_dcache_arb_ld_data_high_idx,
  input    wire  [10 :0]  mcic_dcache_arb_ld_data_low_idx,
  input    wire  [7  :0]  mcic_dcache_arb_ld_data_req,
  input    wire           mcic_dcache_arb_ld_req,
  input    wire           mcic_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  mcic_dcache_arb_ld_tag_idx,
  input    wire  [39 :0]  mcic_dcache_arb_req_addr,
  input    wire           pad_yy_icg_scan_en,
  input    wire  [39 :0]  snq_dcache_arb_borrow_addr,
  input    wire           snq_dcache_arb_data_way,
  input    wire           snq_dcache_arb_ld_borrow_req,
  input    wire           snq_dcache_arb_ld_borrow_req_gate,
  input    wire  [7  :0]  snq_dcache_arb_ld_data_gateclk_en,
  input    wire  [10 :0]  snq_dcache_arb_ld_data_idx,
  input    wire           snq_dcache_arb_ld_req,
  input    wire           snq_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  snq_dcache_arb_ld_tag_idx,
  input    wire           snq_dcache_arb_ld_tag_req,
  input    wire  [1  :0]  snq_dcache_arb_ld_tag_wen,
  input    wire           snq_dcache_arb_serial_req,
  input    wire           snq_dcache_arb_st_borrow_req,
  input    wire  [6  :0]  snq_dcache_arb_st_dirty_din,
  input    wire           snq_dcache_arb_st_dirty_gateclk_en,
  input    wire           snq_dcache_arb_st_dirty_gwen,
  input    wire  [8  :0]  snq_dcache_arb_st_dirty_idx,
  input    wire           snq_dcache_arb_st_dirty_req,
  input    wire  [6  :0]  snq_dcache_arb_st_dirty_wen,
  input    wire  [5  :0]  snq_dcache_arb_st_id,
  input    wire           snq_dcache_arb_st_req,
  input    wire           snq_dcache_arb_st_tag_gateclk_en,
  input    wire  [8  :0]  snq_dcache_arb_st_tag_idx,
  input    wire           snq_dcache_arb_st_tag_req,
  input    wire  [2  :0]  snq_dcache_sdb_id,
  input    wire  [39 :0]  vb_dcache_arb_borrow_addr,
  input    wire           vb_dcache_arb_data_way,
  input    wire           vb_dcache_arb_dcache_replace,
  input    wire           vb_dcache_arb_ld_borrow_req,
  input    wire           vb_dcache_arb_ld_borrow_req_gate,
  input    wire  [7  :0]  vb_dcache_arb_ld_data_gateclk_en,
  input    wire  [10 :0]  vb_dcache_arb_ld_data_idx,
  input    wire           vb_dcache_arb_ld_req,
  input    wire           vb_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  vb_dcache_arb_ld_tag_idx,
  input    wire           vb_dcache_arb_ld_tag_req,
  input    wire  [1  :0]  vb_dcache_arb_ld_tag_wen,
  input    wire           vb_dcache_arb_serial_req,
  input    wire           vb_dcache_arb_set_way_mode,
  input    wire           vb_dcache_arb_st_borrow_req,
  input    wire  [6  :0]  vb_dcache_arb_st_dirty_din,
  input    wire           vb_dcache_arb_st_dirty_gateclk_en,
  input    wire           vb_dcache_arb_st_dirty_gwen,
  input    wire  [8  :0]  vb_dcache_arb_st_dirty_idx,
  input    wire           vb_dcache_arb_st_dirty_req,
  input    wire  [6  :0]  vb_dcache_arb_st_dirty_wen,
  input    wire           vb_dcache_arb_st_req,
  input    wire           vb_dcache_arb_st_tag_gateclk_en,
  input    wire  [8  :0]  vb_dcache_arb_st_tag_idx,
  input    wire           vb_dcache_arb_st_tag_req,
  input    wire  [2  :0]  vb_rcl_sm_data_id,
  input    wire           wmb_dcache_arb_data_way,
  input    wire           wmb_dcache_arb_ld_borrow_req,
  input    wire  [7  :0]  wmb_dcache_arb_ld_data_gateclk_en,
  input    wire  [7  :0]  wmb_dcache_arb_ld_data_gwen,
  input    wire  [127:0]  wmb_dcache_arb_ld_data_high_din,
  input    wire  [10 :0]  wmb_dcache_arb_ld_data_idx,
  input    wire  [127:0]  wmb_dcache_arb_ld_data_low_din,
  input    wire  [7  :0]  wmb_dcache_arb_ld_data_req,
  input    wire  [31 :0]  wmb_dcache_arb_ld_data_wen,
  input    wire           wmb_dcache_arb_ld_req,
  input    wire           wmb_dcache_arb_ld_tag_gateclk_en,
  input    wire  [8  :0]  wmb_dcache_arb_ld_tag_idx,
  input    wire           wmb_dcache_arb_ld_tag_req,
  input    wire  [1  :0]  wmb_dcache_arb_ld_tag_wen,
  input    wire  [6  :0]  wmb_dcache_arb_st_dirty_din,
  input    wire           wmb_dcache_arb_st_dirty_gateclk_en,
  input    wire  [8  :0]  wmb_dcache_arb_st_dirty_idx,
  input    wire           wmb_dcache_arb_st_dirty_req,
  input    wire  [6  :0]  wmb_dcache_arb_st_dirty_wen,
  input    wire           wmb_dcache_arb_st_req,
  output   wire           dcache_arb_ag_ld_sel,
  output   wire           dcache_arb_ag_st_sel,
  output   wire           dcache_arb_icc_ld_grnt,
  output   wire  [39 :0]  dcache_arb_ld_ag_addr,
  output   wire           dcache_arb_ld_ag_borrow_addr_vld,
  output   wire  [2  :0]  dcache_arb_ld_dc_borrow_db,
  output   wire           dcache_arb_ld_dc_borrow_icc,
  output   wire           dcache_arb_ld_dc_borrow_mmu,
  output   wire           dcache_arb_ld_dc_borrow_sndb,
  output   wire           dcache_arb_ld_dc_borrow_vb,
  output   wire           dcache_arb_ld_dc_borrow_vld,
  output   wire           dcache_arb_ld_dc_borrow_vld_gate,
  output   wire           dcache_arb_ld_dc_settle_way,
  output   wire           dcache_arb_lfb_ld_grnt,
  output   wire           dcache_arb_mcic_ld_grnt,
  output   wire           dcache_arb_snq_ld_grnt,
  output   wire           dcache_arb_snq_st_grnt,
  output   wire  [39 :0]  dcache_arb_st_ag_addr,
  output   wire           dcache_arb_st_ag_borrow_addr_vld,
  output   wire           dcache_arb_st_dc_borrow_icc,
  output   wire           dcache_arb_st_dc_borrow_snq,
  output   wire  [5  :0]  dcache_arb_st_dc_borrow_snq_id,
  output   wire           dcache_arb_st_dc_borrow_vld,
  output   wire           dcache_arb_st_dc_borrow_vld_gate,
  output   wire           dcache_arb_st_dc_dcache_replace,
  output   wire           dcache_arb_st_dc_dcache_sw,
  output   wire           dcache_arb_vb_ld_grnt,
  output   wire           dcache_arb_vb_st_grnt,
  output   wire           dcache_arb_wmb_ld_grnt,
  output   reg   [6  :0]  dcache_dirty_din,
  output   wire           dcache_dirty_gwen,
  output   reg   [6  :0]  dcache_dirty_wen,
  output   reg   [8  :0]  dcache_idx,
  output   wire           dcache_snq_st_sel,
  output   wire  [51 :0]  dcache_tag_din,
  output   wire           dcache_tag_gwen,
  output   wire  [1  :0]  dcache_tag_wen,
  output   wire           dcache_vb_snq_gwen,
  output   wire  [7  :0]  lsu_dcache_ld_data_gateclk_en,
  output   wire  [7  :0]  lsu_dcache_ld_data_gwen_b,
  output   wire  [127:0]  lsu_dcache_ld_data_high_din,
  output   reg   [10 :0]  lsu_dcache_ld_data_high_idx,
  output   wire  [127:0]  lsu_dcache_ld_data_low_din,
  output   reg   [10 :0]  lsu_dcache_ld_data_low_idx,
  output   wire  [7  :0]  lsu_dcache_ld_data_sel_b,
  output   wire  [31 :0]  lsu_dcache_ld_data_wen_b,
  output   wire  [53 :0]  lsu_dcache_ld_tag_din,
  output   wire           lsu_dcache_ld_tag_gateclk_en,
  output   wire           lsu_dcache_ld_tag_gwen_b,
  output   reg   [8  :0]  lsu_dcache_ld_tag_idx,
  output   wire           lsu_dcache_ld_tag_sel_b,
  output   wire  [1  :0]  lsu_dcache_ld_tag_wen_b,
  output   wire           lsu_dcache_ld_xx_gwen,
  output   wire  [6  :0]  lsu_dcache_st_dirty_din,
  output   wire           lsu_dcache_st_dirty_gateclk_en,
  output   wire           lsu_dcache_st_dirty_gwen_b,
  output   reg   [8  :0]  lsu_dcache_st_dirty_idx,
  output   wire           lsu_dcache_st_dirty_sel_b,
  output   wire  [6  :0]  lsu_dcache_st_dirty_wen_b,
  output   wire  [51 :0]  lsu_dcache_st_tag_din,
  output   wire           lsu_dcache_st_tag_gateclk_en,
  output   wire           lsu_dcache_st_tag_gwen_b,
  output   reg   [8  :0]  lsu_dcache_st_tag_idx,
  output   wire           lsu_dcache_st_tag_sel_b,
  output   wire  [1  :0]  lsu_dcache_st_tag_wen_b
); 



// &Regs; @25
reg     [6  :0]  dcache_arb_ld_sel;                 
reg              dcache_arb_serial_lfb;             
reg              dcache_arb_serial_snq;             
reg              dcache_arb_serial_vb;              
reg              dcache_arb_serial_vld;             
reg     [5  :0]  dcache_arb_st_sel;                 

// &Wires; @26
wire             dcache_arb_ag_ld_dp_sel;           
wire             dcache_arb_ag_ld_sel_unmask;       
wire             dcache_arb_ag_st_dp_sel;           
wire             dcache_arb_ag_st_sel_unmask;       
wire             dcache_arb_icc_ld_dp_sel;          
wire             dcache_arb_icc_ld_sel;             
wire             dcache_arb_icc_ld_sel_unmask;      
wire             dcache_arb_icc_st_dp_sel;          
wire             dcache_arb_icc_st_sel;             
wire             dcache_arb_icc_st_sel_unmask;      
wire    [7  :0]  dcache_arb_ld_data_req;            
wire    [6  :0]  dcache_arb_ld_dp_sel_id;           
wire    [6  :0]  dcache_arb_ld_req;                 
wire             dcache_arb_ld_tag_req;             
wire             dcache_arb_lfb_ld_dp_sel;          
wire             dcache_arb_lfb_ld_sel;             
wire             dcache_arb_lfb_ld_sel_unmask;      
wire             dcache_arb_lfb_st_dp_sel;          
wire             dcache_arb_lfb_st_sel;             
wire             dcache_arb_lfb_st_sel_unmask;      
wire             dcache_arb_mcic_ld_dp_sel;         
wire             dcache_arb_mcic_ld_sel;            
wire             dcache_arb_mcic_ld_sel_unmask;     
wire             dcache_arb_serial_clk;             
wire             dcache_arb_serial_clk_en;          
wire             dcache_arb_serial_lfb_sel;         
wire             dcache_arb_serial_req;             
wire             dcache_arb_serial_snq_sel;         
wire             dcache_arb_serial_vb_sel;          
wire             dcache_arb_snq_ld_dp_sel;          
wire             dcache_arb_snq_ld_sel;             
wire             dcache_arb_snq_ld_sel_unmask;      
wire             dcache_arb_snq_st_dp_sel;          
wire             dcache_arb_snq_st_sel;             
wire             dcache_arb_snq_st_sel_unmask;      
wire             dcache_arb_st_dirty_req;           
wire    [5  :0]  dcache_arb_st_dp_sel_id;           
wire    [5  :0]  dcache_arb_st_req;                 
wire             dcache_arb_st_tag_req;             
wire             dcache_arb_vb_ld_dp_sel;           
wire             dcache_arb_vb_ld_sel;              
wire             dcache_arb_vb_ld_sel_unmask;       
wire             dcache_arb_vb_st_dp_sel;           
wire             dcache_arb_vb_st_sel;              
wire             dcache_arb_vb_st_sel_unmask;       
wire             dcache_arb_wmb_ld_dp_sel;          
wire             dcache_arb_wmb_ld_sel;             
wire             dcache_arb_wmb_ld_sel_unmask;      
wire             dcache_arb_wmb_st_dp_sel;          
wire             dcache_arb_wmb_st_sel;             
wire             dcache_arb_wmb_st_sel_unmask;      
wire    [7  :0]  lsu_dcache_ld_data_gwen;           
wire    [31 :0]  lsu_dcache_ld_data_wen;            
wire             lsu_dcache_ld_tag_gwen;            
wire    [1  :0]  lsu_dcache_ld_tag_wen;             
wire             lsu_dcache_st_dirty_gwen;          
wire    [6  :0]  lsu_dcache_st_dirty_wen;           
wire             lsu_dcache_st_tag_gwen;            
wire    [1  :0]  lsu_dcache_st_tag_wen;             


parameter VB_DATA_ENTRY = 3,
          SNQ_ENTRY     = 6;

//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign dcache_arb_serial_clk_en = dcache_arb_serial_vld
                                  ||  dcache_arb_serial_req;
// &Instance("gated_clk_cell", "x_lsu_dcache_serial_clk_en"); @36
gated_clk_cell  x_lsu_dcache_serial_clk_en (
  .clk_in                   (forever_cpuclk          ),
  .clk_out                  (dcache_arb_serial_clk   ),
  .external_en              (1'b0                    ),
  .global_en                (1'b1                    ),
  .local_en                 (dcache_arb_serial_clk_en),
  .module_en                (cp0_lsu_icg_en          ),
  .pad_yy_icg_scan_en       (pad_yy_icg_scan_en      )
);

// &Connect(.clk_in        (forever_cpuclk     ), @37
//          .external_en   (1'b0               ), @38
//          .global_en     (1'b1               ), @39
//          .module_en     (cp0_lsu_icg_en     ), @40
//          .local_en      (dcache_arb_serial_clk_en), @41
//          .clk_out       (dcache_arb_serial_clk)); @42

//==========================================================
//                 Serial request registers
//==========================================================
always @(posedge dcache_arb_serial_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    dcache_arb_serial_vld   <=  1'b0;
    dcache_arb_serial_lfb   <=  1'b0;
    dcache_arb_serial_vb    <=  1'b0;
    dcache_arb_serial_snq   <=  1'b0;
  end
  else if(dcache_arb_serial_req)
  begin
    dcache_arb_serial_vld   <=  1'b1;
    dcache_arb_serial_lfb   <=  dcache_arb_serial_lfb_sel;
    dcache_arb_serial_vb    <=  dcache_arb_serial_vb_sel;
    dcache_arb_serial_snq   <=  dcache_arb_serial_snq_sel;
  end
  else
  begin
    dcache_arb_serial_vld   <=  1'b0;
    dcache_arb_serial_lfb   <=  1'b0;
    dcache_arb_serial_vb    <=  1'b0;
    dcache_arb_serial_snq   <=  1'b0;
  end
end

//==========================================================
//                 Serial wires
//==========================================================
assign dcache_arb_serial_req      = dcache_arb_serial_lfb_sel
                                    ||  dcache_arb_serial_vb_sel
                                    ||  dcache_arb_serial_snq_sel;

assign dcache_arb_serial_lfb_sel  = dcache_arb_lfb_ld_sel &&  lfb_dcache_arb_serial_req;
assign dcache_arb_serial_vb_sel   = dcache_arb_vb_ld_sel &&  vb_dcache_arb_serial_req;
assign dcache_arb_serial_snq_sel  = dcache_arb_snq_ld_sel &&  snq_dcache_arb_serial_req;

//==========================================================
//              Sel/Grnt signal for LD part
//==========================================================
//1. lfb state machine
//2. vb state machine
//3. snq/sndb req
//4. mmu dcache issue controller
//5. wmb
//6. icc
//7. ld ag stage

//------------------unmask signal---------------------------

assign dcache_arb_ld_req[6:0] = {dcache_arb_serial_vld,
                                lfb_dcache_arb_ld_req,
                                vb_dcache_arb_ld_req,
                                snq_dcache_arb_ld_req,
                                icc_dcache_arb_ld_req,
                                wmb_dcache_arb_ld_req,
                                mcic_dcache_arb_ld_req};

//select signal send back to the source
// &CombBeg; @105
always @( dcache_arb_ld_req[6:0])
begin
dcache_arb_ld_sel[6:0] = 7'b0;
casez(dcache_arb_ld_req[6:0])
  7'b01?_????:dcache_arb_ld_sel[6]  = 1'b1;
  7'b001_????:dcache_arb_ld_sel[5]  = 1'b1;
  7'b000_1???:dcache_arb_ld_sel[4]  = 1'b1;
  7'b000_01??:dcache_arb_ld_sel[3]  = 1'b1;
  7'b000_001?:dcache_arb_ld_sel[2]  = 1'b1;
  7'b000_0001:dcache_arb_ld_sel[1]  = 1'b1;
  7'b000_0000:dcache_arb_ld_sel[0]  = 1'b1;
  default:dcache_arb_ld_sel[6:0] = 7'b0;
endcase
// &CombEnd; @117
end

assign dcache_arb_lfb_ld_sel_unmask   = dcache_arb_ld_sel[6];
assign dcache_arb_vb_ld_sel_unmask    = dcache_arb_ld_sel[5];
assign dcache_arb_snq_ld_sel_unmask   = dcache_arb_ld_sel[4];
assign dcache_arb_icc_ld_sel_unmask   = dcache_arb_ld_sel[3];
assign dcache_arb_wmb_ld_sel_unmask   = dcache_arb_ld_sel[2];
assign dcache_arb_mcic_ld_sel_unmask  = dcache_arb_ld_sel[1];
assign dcache_arb_ag_ld_sel_unmask    = dcache_arb_ld_sel[0];

//------------------masked signal---------------------------
//because lfb/vb/snq/icc may request ld and st pipeline once a time,
//to insure that they can get both sel signal simultaneously,
//if they request 2 pipeline and get 1 sel, then it must be clr to 0.
assign dcache_arb_lfb_ld_sel  = dcache_arb_lfb_ld_sel_unmask
                                    &&  (!lfb_dcache_arb_st_req
                                        ||  dcache_arb_lfb_st_sel_unmask)
                                ||  dcache_arb_serial_lfb;
assign dcache_arb_vb_ld_sel   = dcache_arb_vb_ld_sel_unmask
                                    &&  (!vb_dcache_arb_st_req
                                        ||  dcache_arb_vb_st_sel_unmask)
                                ||  dcache_arb_serial_vb;
assign dcache_arb_snq_ld_sel  = dcache_arb_snq_ld_sel_unmask
                                    &&  (!snq_dcache_arb_st_req
                                        ||  dcache_arb_snq_st_sel_unmask)
                                ||  dcache_arb_serial_snq;
assign dcache_arb_wmb_ld_sel  = dcache_arb_wmb_ld_sel_unmask
                                &&  dcache_arb_wmb_st_sel_unmask;
assign dcache_arb_icc_ld_sel  = dcache_arb_icc_ld_sel_unmask
                                &&  dcache_arb_icc_st_sel_unmask;
assign dcache_arb_mcic_ld_sel = dcache_arb_mcic_ld_sel_unmask;
// &Force("output", "dcache_arb_ag_ld_sel"); @148
assign dcache_arb_ag_ld_sel   = dcache_arb_ag_ld_sel_unmask;

//----------shorten signal to select signal-----------------
assign dcache_arb_lfb_ld_dp_sel  = dcache_arb_lfb_ld_sel_unmask  ||  dcache_arb_serial_lfb;
assign dcache_arb_vb_ld_dp_sel   = dcache_arb_vb_ld_sel_unmask   ||  dcache_arb_serial_vb;
assign dcache_arb_snq_ld_dp_sel  = dcache_arb_snq_ld_sel_unmask  ||  dcache_arb_serial_snq;
assign dcache_arb_wmb_ld_dp_sel  = dcache_arb_wmb_ld_sel_unmask;
assign dcache_arb_icc_ld_dp_sel  = dcache_arb_icc_ld_sel_unmask;
assign dcache_arb_mcic_ld_dp_sel = dcache_arb_mcic_ld_sel_unmask;
assign dcache_arb_ag_ld_dp_sel   = dcache_arb_ag_ld_sel_unmask;

assign dcache_arb_ld_dp_sel_id[6:0] = {dcache_arb_lfb_ld_dp_sel,
                                      dcache_arb_vb_ld_dp_sel,
                                      dcache_arb_snq_ld_dp_sel,
                                      dcache_arb_wmb_ld_dp_sel,
                                      dcache_arb_icc_ld_dp_sel,
                                      dcache_arb_mcic_ld_dp_sel,
                                      dcache_arb_ag_ld_dp_sel};

//------------------grnt   signal---------------------------
assign dcache_arb_lfb_ld_grnt = dcache_arb_lfb_ld_sel;
assign dcache_arb_vb_ld_grnt  = dcache_arb_vb_ld_sel;
assign dcache_arb_snq_ld_grnt = dcache_arb_snq_ld_sel;
assign dcache_arb_wmb_ld_grnt = dcache_arb_wmb_ld_sel;
assign dcache_arb_icc_ld_grnt = dcache_arb_icc_ld_sel;
assign dcache_arb_mcic_ld_grnt= dcache_arb_mcic_ld_sel;
//assign dcache_arb_ag_ld_grnt  = dcache_arb_ag_ld_sel  &&  ag_dcache_arb_ld_req;

//==========================================================
//        Borrow signal for LD part to DC stage
//==========================================================
//if vb request data, mmu request data, they will borrow ld dc/da stage
//-----------------------borrow addr------------------------
assign dcache_arb_ld_ag_borrow_addr_vld = dcache_arb_mcic_ld_sel;

// here, addr[39:38] we Set 2'b0, Addr[38] stand for 
// if it is kernel or user address space.
// so must set high most two bits as 0.
assign dcache_arb_ld_ag_addr[`PA_WIDTH-1:0]      = {2'b0, mcic_dcache_arb_req_addr[`PA_WIDTH-3:0]};

//---------------------borrow signal------------------------
assign dcache_arb_ld_dc_borrow_vld  = dcache_arb_vb_ld_sel  &&  vb_dcache_arb_ld_borrow_req
                                      ||  dcache_arb_snq_ld_sel  &&  snq_dcache_arb_ld_borrow_req
                                      ||  dcache_arb_icc_ld_sel  &&  icc_dcache_arb_ld_borrow_req
                                      ||  dcache_arb_wmb_ld_sel  &&  wmb_dcache_arb_ld_borrow_req
                                      ||  dcache_arb_mcic_ld_sel;

assign dcache_arb_ld_dc_borrow_vld_gate  = dcache_arb_vb_ld_sel  &&  vb_dcache_arb_ld_borrow_req_gate
                                           ||  dcache_arb_snq_ld_sel  &&  snq_dcache_arb_ld_borrow_req_gate
                                           ||  dcache_arb_icc_ld_sel  &&  icc_dcache_arb_ld_borrow_req
                                           ||  dcache_arb_wmb_ld_sel  &&  wmb_dcache_arb_ld_borrow_req
                                           ||  dcache_arb_mcic_ld_sel;

assign dcache_arb_ld_dc_borrow_db[VB_DATA_ENTRY-1:0]  = dcache_arb_vb_ld_sel
                                                        ? vb_rcl_sm_data_id[VB_DATA_ENTRY-1:0]
                                                        : snq_dcache_sdb_id[VB_DATA_ENTRY-1:0];
assign dcache_arb_ld_dc_borrow_vb   = dcache_arb_vb_ld_sel &&  vb_dcache_arb_ld_borrow_req;
assign dcache_arb_ld_dc_borrow_sndb = dcache_arb_snq_ld_sel  &&  snq_dcache_arb_ld_borrow_req;
assign dcache_arb_ld_dc_borrow_mmu  = dcache_arb_mcic_ld_sel;
assign dcache_arb_ld_dc_borrow_icc  = dcache_arb_icc_ld_sel  &&  icc_dcache_arb_ld_borrow_req;

//borrow way is used
assign dcache_arb_ld_dc_settle_way  = dcache_arb_vb_ld_sel  &&  vb_dcache_arb_data_way
                                      ||  dcache_arb_snq_ld_sel  &&  snq_dcache_arb_data_way
                                      ||  dcache_arb_icc_ld_sel  &&  icc_dcache_arb_data_way
                                      ||  dcache_arb_wmb_ld_sel  &&  wmb_dcache_arb_data_way;

//==========================================================
//        Input select for LD part
//==========================================================
//------------------tag   array-----------------------------
//-----------gateclk--------------------
assign lsu_dcache_ld_tag_gateclk_en = lfb_dcache_arb_ld_tag_gateclk_en
                                      ||  vb_dcache_arb_ld_tag_gateclk_en
                                      ||  snq_dcache_arb_ld_tag_gateclk_en
                                      ||  wmb_dcache_arb_ld_tag_gateclk_en
                                      ||  icc_dcache_arb_ld_tag_gateclk_en
                                      ||  mcic_dcache_arb_ld_tag_gateclk_en
                                      ||  ag_dcache_arb_ld_tag_gateclk_en;

//-----------interface------------------
assign dcache_arb_ld_tag_req  = dcache_arb_lfb_ld_sel  &&  lfb_dcache_arb_ld_tag_req
                                ||  dcache_arb_vb_ld_sel    &&  vb_dcache_arb_ld_tag_req
                                ||  dcache_arb_snq_ld_sel   &&  snq_dcache_arb_ld_tag_req
                                ||  dcache_arb_wmb_ld_sel   &&  wmb_dcache_arb_ld_tag_req
                                ||  dcache_arb_icc_ld_sel   &&  icc_dcache_arb_ld_tag_req
                                ||  dcache_arb_mcic_ld_sel
                                ||  dcache_arb_ag_ld_sel    &&  ag_dcache_arb_ld_tag_req;

assign lsu_dcache_ld_tag_sel_b    = !dcache_arb_ld_tag_req;

// &CombBeg; @247
always @( icc_dcache_arb_ld_tag_idx[8:0]
       or wmb_dcache_arb_ld_tag_idx[8:0]
       or ag_dcache_arb_ld_tag_idx[8:0]
       or snq_dcache_arb_ld_tag_idx[8:0]
       or vb_dcache_arb_ld_tag_idx[8:0]
       or lfb_dcache_arb_ld_tag_idx[8:0]
       or mcic_dcache_arb_ld_tag_idx[8:0]
       or dcache_arb_ld_dp_sel_id[6:0])
begin
case(dcache_arb_ld_dp_sel_id[6:0])
  7'b100_0000:lsu_dcache_ld_tag_idx[8:0]  = lfb_dcache_arb_ld_tag_idx[8:0];
  7'b010_0000:lsu_dcache_ld_tag_idx[8:0]  = vb_dcache_arb_ld_tag_idx[8:0];
  7'b001_0000:lsu_dcache_ld_tag_idx[8:0]  = snq_dcache_arb_ld_tag_idx[8:0];
  7'b000_1000:lsu_dcache_ld_tag_idx[8:0]  = wmb_dcache_arb_ld_tag_idx[8:0];
  7'b000_0100:lsu_dcache_ld_tag_idx[8:0]  = icc_dcache_arb_ld_tag_idx[8:0];
  7'b000_0010:lsu_dcache_ld_tag_idx[8:0]  = mcic_dcache_arb_ld_tag_idx[8:0];
  7'b000_0001:lsu_dcache_ld_tag_idx[8:0]  = ag_dcache_arb_ld_tag_idx[8:0];
  default:lsu_dcache_ld_tag_idx[8:0]  = {9{1'bx}};
endcase
// &CombEnd; @258
end
//assign lsu_dcache_ld_tag_idx[8:0] = {9{dcache_arb_lfb_ld_dp_sel}} & lfb_dcache_arb_ld_tag_idx[8:0]
//                                    | {9{dcache_arb_vb_ld_dp_sel}} & vb_dcache_arb_ld_tag_idx[8:0]
//                                    | {9{dcache_arb_snq_ld_dp_sel}} & snq_dcache_arb_ld_tag_idx[8:0]
//                                    | {9{dcache_arb_wmb_ld_dp_sel}} & wmb_dcache_arb_ld_tag_idx[8:0]
//                                    | {9{dcache_arb_icc_ld_dp_sel}} & icc_dcache_arb_ld_tag_idx[8:0]
//                                    | {9{dcache_arb_mcic_ld_dp_sel}} & mcic_dcache_arb_ld_tag_idx[8:0]
//                                    | {9{dcache_arb_ag_ld_dp_sel}} & ag_dcache_arb_ld_tag_idx[8:0];

//only lfb can write tag array
// &Force("output","lsu_dcache_ld_tag_din"); @268
assign lsu_dcache_ld_tag_din[53:0]  = {54{dcache_arb_lfb_ld_dp_sel}} & lfb_dcache_arb_ld_tag_din[53:0];

assign lsu_dcache_ld_tag_gwen     = dcache_arb_lfb_ld_dp_sel
                                    | dcache_arb_vb_ld_dp_sel
                                    | dcache_arb_snq_ld_dp_sel
                                    | dcache_arb_wmb_ld_dp_sel
                                    | dcache_arb_icc_ld_dp_sel && !icc_dcache_arb_ld_tag_read;
assign lsu_dcache_ld_tag_gwen_b   = !lsu_dcache_ld_tag_gwen;

assign lsu_dcache_ld_tag_wen[1:0] = {2{dcache_arb_lfb_ld_dp_sel}} & lfb_dcache_arb_ld_tag_wen[1:0]
                                    | {2{dcache_arb_vb_ld_dp_sel}}  & vb_dcache_arb_ld_tag_wen[1:0]
                                    | {2{dcache_arb_snq_ld_dp_sel}}  & snq_dcache_arb_ld_tag_wen[1:0]
                                    | {2{dcache_arb_wmb_ld_dp_sel}}  & wmb_dcache_arb_ld_tag_wen[1:0]
                                    | {2{dcache_arb_icc_ld_dp_sel}}  & 2'h3;
assign lsu_dcache_ld_tag_wen_b[1:0] = ~lsu_dcache_ld_tag_wen[1:0];

//------------------for cache buffer-----------------------------
assign lsu_dcache_ld_xx_gwen        = lsu_dcache_ld_tag_gwen;
//assign lsu_dcache_ld_xx_gwen_short  = dcache_arb_lfb_ld_dp_sel
//                                      ||  dcache_arb_vb_ld_dp_sel
//                                      ||  dcache_arb_snq_ld_dp_sel;

//------------------data  array-----------------------------
//-----------gateclk--------------------
assign lsu_dcache_ld_data_gateclk_en[7:0] = lfb_dcache_arb_ld_data_gateclk_en[7:0]
                                            | vb_dcache_arb_ld_data_gateclk_en[7:0]
                                            | snq_dcache_arb_ld_data_gateclk_en[7:0]
                                            | wmb_dcache_arb_ld_data_gateclk_en[7:0]
                                            | mcic_dcache_arb_ld_data_gateclk_en[7:0]
                                            | icc_dcache_arb_ld_data_gateclk_en[7:0]
                                            | ag_dcache_arb_ld_data_gateclk_en[7:0];

//-----------interface------------------
assign dcache_arb_ld_data_req[7:0]  = {8{dcache_arb_lfb_ld_sel}}
                                      | {8{dcache_arb_vb_ld_sel}}
                                      | {8{dcache_arb_snq_ld_sel}}
                                      | {8{dcache_arb_wmb_ld_sel}} & wmb_dcache_arb_ld_data_req[7:0]
                                      | {8{dcache_arb_mcic_ld_sel}} & mcic_dcache_arb_ld_data_req[7:0]
                                      | {8{dcache_arb_ag_ld_sel}} & ag_dcache_arb_ld_data_req[7:0]
                                      | {8{dcache_arb_icc_ld_sel}} & icc_dcache_arb_ld_data_req[7:0];

assign lsu_dcache_ld_data_sel_b[7:0]  = ~dcache_arb_ld_data_req[7:0];

// &CombBeg; @316
always @( snq_dcache_arb_ld_data_idx[10:0]
       or vb_dcache_arb_ld_data_idx[10:0]
       or icc_dcache_arb_ld_data_low_idx[10:0]
       or mcic_dcache_arb_ld_data_low_idx[10:0]
       or lfb_dcache_arb_ld_data_idx[10:0]
       or ag_dcache_arb_ld_data_low_idx[10:0]
       or wmb_dcache_arb_ld_data_idx[10:0]
       or dcache_arb_ld_dp_sel_id[6:0])
begin
case(dcache_arb_ld_dp_sel_id[6:0])
  7'b100_0000:lsu_dcache_ld_data_low_idx[10:0]  = lfb_dcache_arb_ld_data_idx[10:0];
  7'b010_0000:lsu_dcache_ld_data_low_idx[10:0]  = vb_dcache_arb_ld_data_idx[10:0];
  7'b001_0000:lsu_dcache_ld_data_low_idx[10:0]  = snq_dcache_arb_ld_data_idx[10:0];
  7'b000_1000:lsu_dcache_ld_data_low_idx[10:0]  = wmb_dcache_arb_ld_data_idx[10:0];
  7'b000_0100:lsu_dcache_ld_data_low_idx[10:0]  = icc_dcache_arb_ld_data_low_idx[10:0];
  7'b000_0010:lsu_dcache_ld_data_low_idx[10:0]  = mcic_dcache_arb_ld_data_low_idx[10:0];
  7'b000_0001:lsu_dcache_ld_data_low_idx[10:0]  = ag_dcache_arb_ld_data_low_idx[10:0];
  default:lsu_dcache_ld_data_low_idx[10:0]  = {11{1'bx}};
endcase
// &CombEnd; @327
end

//assign lsu_dcache_ld_data_low_idx[10:0]   = {11{dcache_arb_lfb_ld_dp_sel}} & lfb_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_vb_ld_dp_sel}}    & vb_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_snq_ld_dp_sel}}   & snq_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_wmb_ld_dp_sel}}   & wmb_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_mcic_ld_dp_sel}}  & mcic_dcache_arb_ld_data_low_idx[10:0]
//                                            | {11{dcache_arb_ag_ld_dp_sel}} & ag_dcache_arb_ld_data_low_idx[10:0]
//                                            | {11{dcache_arb_icc_ld_dp_sel}} & icc_dcache_arb_ld_data_low_idx[10:0];

// &CombBeg; @337
always @( snq_dcache_arb_ld_data_idx[10:0]
       or vb_dcache_arb_ld_data_idx[10:0]
       or lfb_dcache_arb_ld_data_idx[10:0]
       or mcic_dcache_arb_ld_data_high_idx[10:0]
       or wmb_dcache_arb_ld_data_idx[10:0]
       or ag_dcache_arb_ld_data_high_idx[10:0]
       or dcache_arb_ld_dp_sel_id[6:0]
       or icc_dcache_arb_ld_data_high_idx[10:0])
begin
case(dcache_arb_ld_dp_sel_id[6:0])
  7'b100_0000:lsu_dcache_ld_data_high_idx[10:0]  = lfb_dcache_arb_ld_data_idx[10:0];
  7'b010_0000:lsu_dcache_ld_data_high_idx[10:0]  = vb_dcache_arb_ld_data_idx[10:0];
  7'b001_0000:lsu_dcache_ld_data_high_idx[10:0]  = snq_dcache_arb_ld_data_idx[10:0];
  7'b000_1000:lsu_dcache_ld_data_high_idx[10:0]  = wmb_dcache_arb_ld_data_idx[10:0];
  7'b000_0100:lsu_dcache_ld_data_high_idx[10:0]  = icc_dcache_arb_ld_data_high_idx[10:0];
  7'b000_0010:lsu_dcache_ld_data_high_idx[10:0]  = mcic_dcache_arb_ld_data_high_idx[10:0];
  7'b000_0001:lsu_dcache_ld_data_high_idx[10:0]  = ag_dcache_arb_ld_data_high_idx[10:0];
  default:lsu_dcache_ld_data_high_idx[10:0]  = {11{1'bx}};
endcase
// &CombEnd; @348
end

//assign lsu_dcache_ld_data_high_idx[10:0]  = {11{dcache_arb_lfb_ld_dp_sel}} & lfb_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_vb_ld_dp_sel}}  & vb_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_snq_ld_dp_sel}} & snq_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_wmb_ld_dp_sel}} & wmb_dcache_arb_ld_data_idx[10:0]
//                                            | {11{dcache_arb_mcic_ld_dp_sel}} & mcic_dcache_arb_ld_data_high_idx[10:0]
//                                            | {11{dcache_arb_ag_ld_dp_sel}} & ag_dcache_arb_ld_data_high_idx[10:0]
//                                            | {11{dcache_arb_icc_ld_dp_sel}} & icc_dcache_arb_ld_data_high_idx[10:0];

assign lsu_dcache_ld_data_low_din[127:0]  = dcache_arb_lfb_ld_dp_sel
                                            ? lfb_dcache_arb_ld_data_low_din[127:0]
                                            : wmb_dcache_arb_ld_data_low_din[127:0];

assign lsu_dcache_ld_data_high_din[127:0] = dcache_arb_lfb_ld_dp_sel
                                            ? lfb_dcache_arb_ld_data_high_din[127:0]
                                            : wmb_dcache_arb_ld_data_high_din[127:0];

assign lsu_dcache_ld_data_gwen[7:0]   = {8{dcache_arb_lfb_ld_dp_sel}} & 8'hff
                                        | {8{dcache_arb_wmb_ld_dp_sel}} & wmb_dcache_arb_ld_data_gwen[7:0];
assign lsu_dcache_ld_data_gwen_b[7:0] = ~lsu_dcache_ld_data_gwen[7:0];

assign lsu_dcache_ld_data_wen[31:0]   = {32{dcache_arb_lfb_ld_dp_sel}} & 32'hffff_ffff
                                        | {32{dcache_arb_wmb_ld_dp_sel}} & wmb_dcache_arb_ld_data_wen[31:0];
assign lsu_dcache_ld_data_wen_b[31:0] = ~lsu_dcache_ld_data_wen[31:0];

//==========================================================
//        Sel/Grnt signal for ST part
//==========================================================
//1. lfb state machine
//2. vb state machine
//3. snq
//4. wmb
//5. icc
//6. st ag stage

//------------------unmask signal---------------------------

assign dcache_arb_st_req[5:0] = {dcache_arb_serial_vld,
                                lfb_dcache_arb_st_req,
                                vb_dcache_arb_st_req,
                                snq_dcache_arb_st_req,
                                icc_dcache_arb_st_req,
                                wmb_dcache_arb_st_req};

//sel signal send back to the source
// &CombBeg; @404
always @( dcache_arb_st_req[5:0])
begin
dcache_arb_st_sel[5:0] = 6'b0;
casez(dcache_arb_st_req[5:0])
  6'b01_????:dcache_arb_st_sel[5]  = 1'b1;
  6'b00_1???:dcache_arb_st_sel[4]  = 1'b1;
  6'b00_01??:dcache_arb_st_sel[3]  = 1'b1;
  6'b00_001?:dcache_arb_st_sel[2]  = 1'b1;
  6'b00_0001:dcache_arb_st_sel[1]  = 1'b1;
  6'b00_0000:dcache_arb_st_sel[0]  = 1'b1;
  default:dcache_arb_st_sel[5:0] = 6'b0;
endcase
// &CombEnd; @415
end

assign dcache_arb_lfb_st_sel_unmask   = dcache_arb_st_sel[5];
assign dcache_arb_vb_st_sel_unmask    = dcache_arb_st_sel[4];
assign dcache_arb_snq_st_sel_unmask   = dcache_arb_st_sel[3];
assign dcache_arb_icc_st_sel_unmask   = dcache_arb_st_sel[2];
assign dcache_arb_wmb_st_sel_unmask   = dcache_arb_st_sel[1];
assign dcache_arb_ag_st_sel_unmask    = dcache_arb_st_sel[0];

//------------------masked signal---------------------------
//because lfb/vb/snq/icc may request ld and st pipeline once a time,
//to insure that they can get both sel signal simultaneously,
//if they request 2 pipeline and get 1 sel, then it must be clr to 0.
assign dcache_arb_lfb_st_sel  = dcache_arb_lfb_st_sel_unmask
                                    &&  (!lfb_dcache_arb_ld_req
                                        ||  dcache_arb_lfb_ld_sel_unmask)
                                ||  dcache_arb_serial_lfb;
assign dcache_arb_vb_st_sel   = dcache_arb_vb_st_sel_unmask
                                    &&  (!vb_dcache_arb_ld_req
                                        ||  dcache_arb_vb_ld_sel_unmask)
                                ||  dcache_arb_serial_vb;
assign dcache_arb_snq_st_sel  = dcache_arb_snq_st_sel_unmask
                                    &&  (!snq_dcache_arb_ld_req
                                        ||  dcache_arb_snq_ld_sel_unmask)
                                ||  dcache_arb_serial_snq;
assign dcache_arb_wmb_st_sel  = dcache_arb_wmb_st_sel_unmask
                                &&  dcache_arb_wmb_ld_sel_unmask;
assign dcache_arb_icc_st_sel  = dcache_arb_icc_st_sel_unmask
                                &&  dcache_arb_icc_ld_sel_unmask;
// &Force("output", "dcache_arb_ag_st_sel"); @444
assign dcache_arb_ag_st_sel   = dcache_arb_ag_st_sel_unmask;

//----------shorten signal to select signal-----------------
assign dcache_arb_lfb_st_dp_sel  = dcache_arb_lfb_st_sel_unmask  ||  dcache_arb_serial_lfb;
assign dcache_arb_vb_st_dp_sel   = dcache_arb_vb_st_sel_unmask   ||  dcache_arb_serial_vb;
assign dcache_arb_snq_st_dp_sel  = dcache_arb_snq_st_sel_unmask  ||  dcache_arb_serial_snq;
assign dcache_arb_wmb_st_dp_sel  = dcache_arb_wmb_st_sel_unmask;
assign dcache_arb_icc_st_dp_sel  = dcache_arb_icc_st_sel_unmask;
assign dcache_arb_ag_st_dp_sel   = dcache_arb_ag_st_sel_unmask;

assign dcache_arb_st_dp_sel_id[5:0] = {dcache_arb_lfb_st_dp_sel,
                                      dcache_arb_vb_st_dp_sel,
                                      dcache_arb_snq_st_dp_sel,
                                      dcache_arb_wmb_st_dp_sel,
                                      dcache_arb_icc_st_dp_sel,
                                      dcache_arb_ag_st_dp_sel};
//------------------grnt   signal---------------------------
assign dcache_arb_vb_st_grnt  = dcache_arb_vb_st_sel;
assign dcache_arb_snq_st_grnt = dcache_arb_snq_st_sel;
//assign dcache_arb_ag_st_grnt  = dcache_arb_ag_st_sel  &&  ag_dcache_arb_st_req;

//==========================================================
//        Borrow signal for ST part to DC stage
//==========================================================
//if vb request tag/dirty, mmu request tag/dirty, they will borrow st dc/da stage
//---------------------borrow addr--------------------------
// &Force("output","dcache_arb_st_ag_borrow_addr_vld"); @471

/// if we should set PC[PA_WIDTH-1:PA_WIDTH-2] = 2'b0 ?
/// TODO: test for pc here
assign dcache_arb_st_ag_borrow_addr_vld = dcache_arb_vb_st_sel  &&  vb_dcache_arb_st_borrow_req
                                          ||  dcache_arb_snq_st_sel  &&  snq_dcache_arb_st_borrow_req;
assign dcache_arb_st_ag_addr[`PA_WIDTH-1:0]  = {`PA_WIDTH{dcache_arb_vb_st_sel}}
                                                & {2'b0, vb_dcache_arb_borrow_addr[`PA_WIDTH-3:0]}
                                              | {`PA_WIDTH{dcache_arb_snq_st_sel}}
                                                & {2'b0, snq_dcache_arb_borrow_addr[`PA_WIDTH-3:0]};

//---------------------borrow signal------------------------
// &Force("output", "dcache_arb_st_dc_borrow_vld"); @479
assign dcache_arb_st_dc_borrow_vld_gate = dcache_arb_st_ag_borrow_addr_vld
                                          || dcache_arb_icc_st_sel  &&  icc_dcache_arb_st_borrow_req;
assign dcache_arb_st_dc_borrow_vld      = dcache_arb_st_ag_borrow_addr_vld
                                          || dcache_arb_icc_st_sel  &&  icc_dcache_arb_st_borrow_req;
assign dcache_arb_st_dc_borrow_snq    = dcache_arb_snq_st_sel  &&  snq_dcache_arb_st_borrow_req;
assign dcache_arb_st_dc_borrow_snq_id[SNQ_ENTRY-1:0]  = snq_dcache_arb_st_id[SNQ_ENTRY-1:0];
assign dcache_arb_st_dc_borrow_icc    = dcache_arb_icc_st_sel  &&  icc_dcache_arb_st_borrow_req;
//------------------borrow other signal---------------------
assign dcache_arb_st_dc_dcache_replace  = dcache_arb_vb_st_sel  &&  vb_dcache_arb_dcache_replace;
assign dcache_arb_st_dc_dcache_sw       = dcache_arb_vb_st_sel  &&  vb_dcache_arb_set_way_mode
                                          || dcache_arb_icc_st_sel  &&  icc_dcache_arb_way;

//==========================================================
//        Input select for ST part
//==========================================================
//------------------tag   array-----------------------------
//-----------gateclk--------------------
assign lsu_dcache_st_tag_gateclk_en = lfb_dcache_arb_st_tag_gateclk_en
                                      ||  vb_dcache_arb_st_tag_gateclk_en
                                      ||  snq_dcache_arb_st_tag_gateclk_en
                                      ||  icc_dcache_arb_st_tag_gateclk_en
                                      ||  ag_dcache_arb_st_tag_gateclk_en;

//-----------interface------------------
assign dcache_arb_st_tag_req  = dcache_arb_lfb_st_sel  &&  lfb_dcache_arb_st_tag_req
                                ||  dcache_arb_vb_st_sel  &&  vb_dcache_arb_st_tag_req
                                ||  dcache_arb_snq_st_sel &&  snq_dcache_arb_st_tag_req
                                ||  dcache_arb_icc_st_sel &&  icc_dcache_arb_st_tag_req
                                ||  dcache_arb_ag_st_sel  &&  ag_dcache_arb_st_tag_req;

assign lsu_dcache_st_tag_sel_b  = !dcache_arb_st_tag_req;

// &CombBeg; @530
always @( lfb_dcache_arb_st_tag_idx[8:0]
       or dcache_arb_st_dp_sel_id[5:0]
       or icc_dcache_arb_st_tag_idx[8:0]
       or vb_dcache_arb_st_tag_idx[8:0]
       or ag_dcache_arb_st_tag_idx[8:0]
       or snq_dcache_arb_st_tag_idx[8:0])
begin
case(dcache_arb_st_dp_sel_id[5:0])
  6'b10_0000:lsu_dcache_st_tag_idx[8:0]  = lfb_dcache_arb_st_tag_idx[8:0];
  6'b01_0000:lsu_dcache_st_tag_idx[8:0]  = vb_dcache_arb_st_tag_idx[8:0];
  6'b00_1000:lsu_dcache_st_tag_idx[8:0]  = snq_dcache_arb_st_tag_idx[8:0];
  6'b00_0010:lsu_dcache_st_tag_idx[8:0]  = icc_dcache_arb_st_tag_idx[8:0];
  6'b00_0001:lsu_dcache_st_tag_idx[8:0]  = ag_dcache_arb_st_tag_idx[8:0];
  default:lsu_dcache_st_tag_idx[8:0]  = {9{1'bx}};
endcase
// &CombEnd; @542
end

//assign lsu_dcache_st_tag_idx[8:0] = {9{dcache_arb_lfb_st_dp_sel}}  & lfb_dcache_arb_st_tag_idx[8:0]
//                                    | {9{dcache_arb_vb_st_dp_sel}}   & vb_dcache_arb_st_tag_idx[8:0]
//                                    | {9{dcache_arb_snq_st_dp_sel}}  & snq_dcache_arb_st_tag_idx[8:0]
//                                    | {9{dcache_arb_icc_st_dp_sel}}  & icc_dcache_arb_st_tag_idx[8:0]
//                                    | {9{dcache_arb_ag_st_dp_sel}}   & ag_dcache_arb_st_tag_idx[8:0];

//only lfb can write tag array
// &Force("output","lsu_dcache_st_tag_din"); @551
assign lsu_dcache_st_tag_din[51:0] = lfb_dcache_arb_st_tag_din[51:0];
assign lsu_dcache_st_tag_gwen      = dcache_arb_lfb_st_dp_sel;
assign lsu_dcache_st_tag_wen[1:0]  = {2{dcache_arb_lfb_st_dp_sel}} & lfb_dcache_arb_st_tag_wen[1:0];

assign lsu_dcache_st_tag_gwen_b   = !lsu_dcache_st_tag_gwen;

assign lsu_dcache_st_tag_wen_b[1:0] = ~lsu_dcache_st_tag_wen[1:0];

//------------------dirty array-----------------------------
//-----------gateclk--------------------
assign lsu_dcache_st_dirty_gateclk_en = lfb_dcache_arb_st_dirty_gateclk_en
                                        ||  vb_dcache_arb_st_dirty_gateclk_en
                                        ||  snq_dcache_arb_st_dirty_gateclk_en
                                        ||  wmb_dcache_arb_st_dirty_gateclk_en
                                        ||  icc_dcache_arb_st_dirty_gateclk_en
                                        ||  ag_dcache_arb_st_dirty_gateclk_en;

//-----------interface------------------
assign dcache_arb_st_dirty_req  = dcache_arb_lfb_st_sel  &&  lfb_dcache_arb_st_dirty_req
                                  ||  dcache_arb_vb_st_sel  &&  vb_dcache_arb_st_dirty_req
                                  ||  dcache_arb_snq_st_sel &&  snq_dcache_arb_st_dirty_req
                                  ||  dcache_arb_wmb_st_sel &&  wmb_dcache_arb_st_dirty_req
                                  ||  dcache_arb_icc_st_sel &&  icc_dcache_arb_st_dirty_req
                                  ||  dcache_arb_ag_st_sel  &&  ag_dcache_arb_st_dirty_req;

assign lsu_dcache_st_dirty_sel_b  = !dcache_arb_st_dirty_req;

// &CombBeg; @592
always @( ag_dcache_arb_st_dirty_idx[8:0]
       or wmb_dcache_arb_st_dirty_idx[8:0]
       or icc_dcache_arb_st_dirty_idx[8:0]
       or dcache_arb_st_dp_sel_id[5:0]
       or lfb_dcache_arb_st_dirty_idx[8:0]
       or snq_dcache_arb_st_dirty_idx[8:0]
       or vb_dcache_arb_st_dirty_idx[8:0])
begin
case(dcache_arb_st_dp_sel_id[5:0])
  6'b10_0000:lsu_dcache_st_dirty_idx[8:0]  = lfb_dcache_arb_st_dirty_idx[8:0];
  6'b01_0000:lsu_dcache_st_dirty_idx[8:0]  = vb_dcache_arb_st_dirty_idx[8:0];
  6'b00_1000:lsu_dcache_st_dirty_idx[8:0]  = snq_dcache_arb_st_dirty_idx[8:0];
  6'b00_0100:lsu_dcache_st_dirty_idx[8:0]  = wmb_dcache_arb_st_dirty_idx[8:0];
  6'b00_0010:lsu_dcache_st_dirty_idx[8:0]  = icc_dcache_arb_st_dirty_idx[8:0];
  6'b00_0001:lsu_dcache_st_dirty_idx[8:0]  = ag_dcache_arb_st_dirty_idx[8:0];
  default:lsu_dcache_st_dirty_idx[8:0]  = {9{1'bx}};
endcase
// &CombEnd; @602
end

//assign lsu_dcache_st_dirty_idx[8:0] = {9{dcache_arb_lfb_st_dp_sel}}  & lfb_dcache_arb_st_dirty_idx[8:0]
//                                      | {9{dcache_arb_vb_st_dp_sel}} & vb_dcache_arb_st_dirty_idx[8:0]
//                                      | {9{dcache_arb_snq_st_dp_sel}}  & snq_dcache_arb_st_dirty_idx[8:0]
//                                      | {9{dcache_arb_wmb_st_dp_sel}}  & wmb_dcache_arb_st_dirty_idx[8:0]
//                                      | {9{dcache_arb_icc_st_dp_sel}}  & icc_dcache_arb_st_dirty_idx[8:0]
//                                      | {9{dcache_arb_ag_st_dp_sel}}   & ag_dcache_arb_st_dirty_idx[8:0];
assign lsu_dcache_st_dirty_din[6:0] = {7{dcache_arb_lfb_st_dp_sel}}    & lfb_dcache_arb_st_dirty_din[6:0]
                                      | {7{dcache_arb_vb_st_dp_sel}}   & vb_dcache_arb_st_dirty_din[6:0]
                                      | {7{dcache_arb_snq_st_dp_sel}}  & snq_dcache_arb_st_dirty_din[6:0]
                                      | {7{dcache_arb_wmb_st_dp_sel}}  & wmb_dcache_arb_st_dirty_din[6:0]
                                      | {7{dcache_arb_icc_st_dp_sel}}  & icc_dcache_arb_st_dirty_din[6:0];

assign lsu_dcache_st_dirty_gwen     = dcache_arb_lfb_st_dp_sel
                                      ||  dcache_arb_vb_st_dp_sel    &&  vb_dcache_arb_st_dirty_gwen
                                      ||  dcache_arb_snq_st_dp_sel   &&  snq_dcache_arb_st_dirty_gwen
                                      ||  dcache_arb_wmb_st_dp_sel
                                      ||  dcache_arb_icc_st_dp_sel   &&  icc_dcache_arb_st_dirty_gwen;
assign lsu_dcache_st_dirty_gwen_b   = !lsu_dcache_st_dirty_gwen;

assign lsu_dcache_st_dirty_wen[6:0] = {7{dcache_arb_lfb_st_dp_sel}}   & lfb_dcache_arb_st_dirty_wen[6:0]
                                      | {7{dcache_arb_vb_st_dp_sel}}  & vb_dcache_arb_st_dirty_wen[6:0]
                                      | {7{dcache_arb_snq_st_dp_sel}} & snq_dcache_arb_st_dirty_wen[6:0]
                                      | {7{dcache_arb_wmb_st_dp_sel}} & wmb_dcache_arb_st_dirty_wen[6:0]
                                      | {7{dcache_arb_icc_st_dp_sel}} & icc_dcache_arb_st_dirty_wen[6:0];
assign lsu_dcache_st_dirty_wen_b[6:0] = ~lsu_dcache_st_dirty_wen[6:0];
//==========================================================
//        Dcache write port information
//==========================================================
assign dcache_dirty_gwen        = dcache_arb_lfb_st_sel
                                      &&  lfb_dcache_arb_st_dirty_req
                                  ||  dcache_arb_vb_st_sel
                                      &&  vb_dcache_arb_st_dirty_req
                                      &&  vb_dcache_arb_st_dirty_gwen
                                  ||  dcache_arb_snq_st_sel
                                      &&  snq_dcache_arb_st_dirty_req
                                      &&  snq_dcache_arb_st_dirty_gwen
                                  ||  dcache_arb_wmb_st_sel
                                      &&  wmb_dcache_arb_st_dirty_req;

assign dcache_snq_st_sel        = dcache_arb_snq_st_sel;

assign dcache_vb_snq_gwen       = dcache_arb_vb_st_sel
                                      &&  vb_dcache_arb_st_dirty_req
                                      &&  vb_dcache_arb_st_dirty_gwen
                                  ||  dcache_arb_snq_st_sel
                                      &&  snq_dcache_arb_st_dirty_req
                                      &&  snq_dcache_arb_st_dirty_gwen;

assign dcache_tag_gwen          = dcache_arb_lfb_st_sel
                                  &&  lfb_dcache_arb_st_tag_req;

//ATTENTION:there are 9 bits idx in dcache 32K, for dcwp hit, it must compare
//only 8 bits in 32K and 9 bits in 64K
// &CombBeg; @671
always @( snq_dcache_arb_st_dirty_wen[6:0]
       or wmb_dcache_arb_st_dirty_idx[8:0]
       or dcache_arb_vb_st_dp_sel
       or lfb_dcache_arb_st_dirty_din[6:0]
       or lfb_dcache_arb_st_dirty_idx[8:0]
       or wmb_dcache_arb_st_dirty_wen[6:0]
       or vb_dcache_arb_st_dirty_wen[6:0]
       or wmb_dcache_arb_st_dirty_din[6:0]
       or dcache_arb_lfb_st_dp_sel
       or snq_dcache_arb_st_dirty_idx[8:0]
       or lfb_dcache_arb_st_dirty_wen[6:0]
       or snq_dcache_arb_st_dirty_din[6:0]
       or dcache_arb_snq_st_dp_sel
       or vb_dcache_arb_st_dirty_din[6:0]
       or vb_dcache_arb_st_dirty_idx[8:0])
begin
casez({dcache_arb_lfb_st_dp_sel,dcache_arb_vb_st_dp_sel,dcache_arb_snq_st_dp_sel})
  3'b1??:
  begin
    dcache_idx[8:0]       = lfb_dcache_arb_st_dirty_idx[8:0];
    dcache_dirty_din[6:0] = lfb_dcache_arb_st_dirty_din[6:0];
    dcache_dirty_wen[6:0] = lfb_dcache_arb_st_dirty_wen[6:0];
  end
  3'b01?:
  begin
    dcache_idx[8:0]       = vb_dcache_arb_st_dirty_idx[8:0];
    dcache_dirty_din[6:0] = vb_dcache_arb_st_dirty_din[6:0];
    dcache_dirty_wen[6:0] = vb_dcache_arb_st_dirty_wen[6:0];
  end
  3'b001:
  begin
    dcache_idx[8:0]       = snq_dcache_arb_st_dirty_idx[8:0];
    dcache_dirty_din[6:0] = snq_dcache_arb_st_dirty_din[6:0];
    dcache_dirty_wen[6:0] = snq_dcache_arb_st_dirty_wen[6:0];
  end
  default:
  begin
    dcache_idx[8:0]       = wmb_dcache_arb_st_dirty_idx[8:0];
    dcache_dirty_din[6:0] = wmb_dcache_arb_st_dirty_din[6:0];
    dcache_dirty_wen[6:0] = wmb_dcache_arb_st_dirty_wen[6:0];
  end
endcase
// &CombEnd; @714
end
assign dcache_tag_din[51:0]   = lsu_dcache_st_tag_din[51:0];
assign dcache_tag_wen[1:0]    = lsu_dcache_st_tag_wen[1:0];

// &ModuleEnd; @718
endmodule


