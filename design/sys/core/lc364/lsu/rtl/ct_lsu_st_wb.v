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

// &ModuleBeg; @25
module ct_lsu_st_wb (
  // &Ports, @26
  input    wire          cp0_lsu_icg_en,
  input    wire          cp0_yy_clk_en,
  input    wire          cpurst_b,
  input    wire          ctrl_st_clk,
  input    wire          forever_cpuclk,
  input    wire          pad_yy_icg_scan_en,
  input    wire          rtu_yy_xx_flush,
  input    wire          st_da_bkpta_data,
  input    wire          st_da_bkptb_data,
  input    wire  [6 :0]  st_da_iid,
  input    wire          st_da_inst_vld,
  input    wire          st_da_wb_cmplt_req,
  input    wire  [14:0]  st_da_wb_expt_vec,
  input    wire          st_da_wb_expt_vld,
  input    wire  [63:0]  st_da_wb_mt_value,
  input    wire          st_da_wb_no_spec_hit,
  input    wire          st_da_wb_no_spec_mispred,
  input    wire          st_da_wb_no_spec_miss,
  input    wire          st_da_wb_spec_fail,
  input    wire          wmb_st_wb_bkpta_data,
  input    wire          wmb_st_wb_bkptb_data,
  input    wire          wmb_st_wb_cmplt_req,
  input    wire  [6 :0]  wmb_st_wb_iid,
  input    wire          wmb_st_wb_inst_flush,
  input    wire          wmb_st_wb_spec_fail,
  input    wire  [63:0]  sq_st_wb_search_data,
  output   wire  [6 :0]  lsu_iu_wb_pipe4_wb_iid,
  output   wire  [6 :0]  lsu_iu_wb_pipe4_wb_preg,
  output   wire  [63:0]  lsu_iu_wb_pipe4_wb_preg_data,
  output   wire          lsu_iu_wb_pipe4_wb_preg_vld,
  output   wire          lsu_rtu_wb_pipe4_abnormal,
  output   wire          lsu_rtu_wb_pipe4_bkpta_data,
  output   wire          lsu_rtu_wb_pipe4_bkptb_data,
  output   wire          lsu_rtu_wb_pipe4_cmplt,
  output   wire  [14:0]  lsu_rtu_wb_pipe4_expt_vec,
  output   wire          lsu_rtu_wb_pipe4_expt_vld,
  output   wire          lsu_rtu_wb_pipe4_flush,
  output   wire  [6 :0]  lsu_rtu_wb_pipe4_iid,
  output   wire  [63:0]  lsu_rtu_wb_pipe4_mtval,
  output   wire          lsu_rtu_wb_pipe4_no_spec_hit,
  output   wire          lsu_rtu_wb_pipe4_no_spec_mispred,
  output   wire          lsu_rtu_wb_pipe4_no_spec_miss,
  output   wire          lsu_rtu_wb_pipe4_spec_fail,
  output   reg           st_wb_inst_vld,
  output   wire          st_wb_wmb_cmplt_grnt,
  output   wire  [6 :0]  st_wb_sq_search_iid
); 



// &Regs; @27
reg             st_wb_bkpta_data;                
reg             st_wb_bkptb_data;                
reg     [14:0]  st_wb_expt_vec;                  
reg             st_wb_expt_vld;                  
reg             st_wb_flush;                     
reg     [6 :0]  st_wb_iid;                       
reg     [63:0]  st_wb_mt_value;                  
reg             st_wb_no_spec_hit;               
reg             st_wb_no_spec_mispred;           
reg             st_wb_no_spec_miss;              
reg             st_wb_spec_fail;                 

// &Wires; @28
wire            st_wb_cmplt_clk;                 
wire            st_wb_cmplt_clk_en;              
wire            st_wb_da_cmplt_grnt;             
wire            st_wb_expt_clk;                  
wire            st_wb_expt_clk_en;               
wire            st_wb_pre_bkpta_data;            
wire            st_wb_pre_bkptb_data;            
wire            st_wb_pre_expt_vld;              
wire            st_wb_pre_flush;                 
wire    [6 :0]  st_wb_pre_iid;                   
wire            st_wb_pre_inst_flush;            
wire            st_wb_pre_inst_vld;              
wire            st_wb_pre_no_spec_hit;           
wire            st_wb_pre_no_spec_mispred;       
wire            st_wb_pre_no_spec_miss;          
wire            st_wb_pre_spec_fail;             
wire            st_wb_pre_vstart_vld;            


parameter PC_WIDTH      = 64;

//==========================================================
//                 arbitrate WB stage request
//==========================================================
//------------------complete part---------------------------
//-----------grant signal---------------
assign st_wb_da_cmplt_grnt   = st_da_wb_cmplt_req;
// &Force("output","st_wb_wmb_cmplt_grnt"); @36
assign st_wb_wmb_cmplt_grnt     = !st_da_wb_cmplt_req
                                  &&  wmb_st_wb_cmplt_req;
//-----------signal select--------------
assign st_wb_pre_inst_vld       = st_da_wb_cmplt_req
                                  ||  wmb_st_wb_cmplt_req;

assign st_wb_pre_inst_flush     = st_wb_wmb_cmplt_grnt  &&  wmb_st_wb_inst_flush;
assign st_wb_pre_spec_fail      = st_wb_da_cmplt_grnt &&  st_da_wb_spec_fail
                                  ||  st_wb_wmb_cmplt_grnt  &&  wmb_st_wb_spec_fail;
assign st_wb_pre_bkpta_data     = st_wb_da_cmplt_grnt &&  st_da_bkpta_data
                                  ||  st_wb_wmb_cmplt_grnt  &&  wmb_st_wb_bkpta_data;
assign st_wb_pre_bkptb_data     = st_wb_da_cmplt_grnt &&  st_da_bkptb_data
                                  ||  st_wb_wmb_cmplt_grnt  &&  wmb_st_wb_bkptb_data;
assign st_wb_pre_flush          = st_wb_pre_inst_flush  
                                  ||  st_wb_pre_spec_fail
                                  ||  st_wb_pre_vstart_vld
                                      && !st_wb_pre_expt_vld;

assign st_wb_pre_expt_vld       = st_wb_da_cmplt_grnt   &&  st_da_wb_expt_vld;

assign st_wb_pre_iid[6:0]       = {7{st_wb_da_cmplt_grnt}}  & st_da_iid[6:0]
                                  | {7{st_wb_wmb_cmplt_grnt}}  & wmb_st_wb_iid[6:0];

//for spec fail prediction
assign st_wb_pre_no_spec_miss    = st_wb_da_cmplt_grnt &&  st_da_wb_no_spec_miss; 
assign st_wb_pre_no_spec_hit     = st_wb_da_cmplt_grnt &&  st_da_wb_no_spec_hit; 
assign st_wb_pre_no_spec_mispred = st_wb_da_cmplt_grnt &&  st_da_wb_no_spec_mispred;

assign st_wb_pre_vstart_vld       = 1'b0;


//==========================================================
//                 Instance of Gated Cell  
//==========================================================
assign st_wb_cmplt_clk_en =   st_da_inst_vld
                              ||  wmb_st_wb_cmplt_req;
// &Instance("gated_clk_cell", "x_lsu_st_wb_cmplt_gated_clk"); @84
gated_clk_cell  x_lsu_st_wb_cmplt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_wb_cmplt_clk   ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (st_wb_cmplt_clk_en),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @85
//          .external_en   (1'b0               ), @86
//          .global_en     (cp0_yy_clk_en      ), @87
//          .module_en     (cp0_lsu_icg_en     ), @88
//          .local_en      (st_wb_cmplt_clk_en ), @89
//          .clk_out       (st_wb_cmplt_clk    )); @90

assign st_wb_expt_clk_en  =   st_da_inst_vld
                              &&  st_da_wb_expt_vld;
// &Instance("gated_clk_cell", "x_lsu_st_wb_expt_gated_clk"); @94
gated_clk_cell  x_lsu_st_wb_expt_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (st_wb_expt_clk    ),
  .external_en        (1'b0              ),
  .global_en          (cp0_yy_clk_en     ),
  .local_en           (st_wb_expt_clk_en ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in        (forever_cpuclk     ), @95
//          .external_en   (1'b0               ), @96
//          .global_en     (cp0_yy_clk_en      ), @97
//          .module_en     (cp0_lsu_icg_en     ), @98
//          .local_en      (st_wb_expt_clk_en  ), @99
//          .clk_out       (st_wb_expt_clk     )); @100

//==========================================================
//                 Pipeline Register
//==========================================================
//------------------complete part---------------------------
//+----------+----------+
//| inst_vld | expt_vld |
//+----------+----------+
// &Force("output","st_wb_inst_vld"); @109
always @(posedge ctrl_st_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    st_wb_inst_vld      <=  1'b0;
  else if(rtu_yy_xx_flush)
    st_wb_inst_vld      <=  1'b0;
  else if(st_wb_pre_inst_vld)
    st_wb_inst_vld      <=  1'b1;
  else
    st_wb_inst_vld      <=  1'b0;
end

//+-----+-------+-----------+-----------+
//| iid | flush | spec_fail | bkpt_data |
//+-----+-------+-----------+-----------+
always @(posedge st_wb_cmplt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_wb_expt_vld        <=  1'b0;
    st_wb_iid[6:0]        <=  7'b0;
    st_wb_spec_fail       <=  1'b0;
    st_wb_flush           <=  1'b0;
    st_wb_bkpta_data      <=  1'b0;
    st_wb_bkptb_data      <=  1'b0;
    st_wb_no_spec_miss    <=  1'b0;
    st_wb_no_spec_hit     <=  1'b0;
    st_wb_no_spec_mispred <=  1'b0;
  end
  else if(st_wb_pre_inst_vld)
  begin
    st_wb_expt_vld        <=  st_wb_pre_expt_vld;
    st_wb_iid[6:0]        <=  st_wb_pre_iid[6:0];
    st_wb_spec_fail       <=  st_wb_pre_spec_fail;
    st_wb_flush           <=  st_wb_pre_flush;
    st_wb_bkpta_data      <=  st_wb_pre_bkpta_data;
    st_wb_bkptb_data      <=  st_wb_pre_bkptb_data;
    st_wb_no_spec_miss    <=  st_wb_pre_no_spec_miss;
    st_wb_no_spec_hit     <=  st_wb_pre_no_spec_hit;
    st_wb_no_spec_mispred <=  st_wb_pre_no_spec_mispred;
  end
end



//+----------+----------+
//| expt_vec | mt_value |
//+----------+----------+
always @(posedge st_wb_expt_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
  begin
    st_wb_expt_vec[14:0]          <=  15'b0;
    st_wb_mt_value[PC_WIDTH-1:0] <=  {PC_WIDTH{1'b0}};
  end
  else if(st_da_inst_vld  &&  st_da_wb_expt_vld)
  begin
    st_wb_expt_vec[14:0]          <=  st_da_wb_expt_vec[14:0];
    st_wb_mt_value[PC_WIDTH-1:0] <=  st_da_wb_mt_value[PC_WIDTH-1:0];
  end
end

//==========================================================
//                 Generate interface to rtu
//==========================================================
//------------------complete part---------------------------
assign lsu_rtu_wb_pipe4_cmplt         = st_wb_inst_vld;
assign lsu_rtu_wb_pipe4_iid[6:0]      = st_wb_iid[6:0]; 
assign lsu_rtu_wb_pipe4_expt_vld      = st_wb_expt_vld;
assign lsu_rtu_wb_pipe4_expt_vec[14:0]= st_wb_expt_vec[14:0];
assign lsu_rtu_wb_pipe4_spec_fail     = st_wb_spec_fail;
assign lsu_rtu_wb_pipe4_flush         = st_wb_flush;
assign lsu_rtu_wb_pipe4_abnormal      = st_wb_expt_vld
                                        ||  st_wb_flush;
assign lsu_rtu_wb_pipe4_mtval[PC_WIDTH-1:0]   = st_wb_mt_value[PC_WIDTH-1:0];
assign lsu_rtu_wb_pipe4_bkpta_data    = st_wb_bkpta_data;
assign lsu_rtu_wb_pipe4_bkptb_data    = st_wb_bkptb_data;

assign lsu_rtu_wb_pipe4_no_spec_miss    = st_wb_no_spec_miss;
assign lsu_rtu_wb_pipe4_no_spec_hit     = st_wb_no_spec_hit;
assign lsu_rtu_wb_pipe4_no_spec_mispred = st_wb_no_spec_mispred;

assign lsu_iu_wb_pipe4_wb_iid[6:0]         = st_wb_iid[6:0]; 
assign lsu_iu_wb_pipe4_wb_preg_vld         = st_wb_inst_vld; 
assign lsu_iu_wb_pipe4_wb_preg[6:0]        = 7'b0; 
assign lsu_iu_wb_pipe4_wb_preg_data[63:0]  = sq_st_wb_search_data[63:0]; 


assign st_wb_sq_search_iid[6:0] = st_wb_iid[6:0];           


// &ModuleEnd; @220
endmodule


