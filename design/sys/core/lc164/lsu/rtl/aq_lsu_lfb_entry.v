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

// &Depend("cpu_cfig.h"); @17
// &Depend("aq_lsu_cfig.h"); @18

// &ModuleBeg; @20
module aq_lsu_lfb_entry (
  // &Ports, @21
  input    wire          bus_acc_err,
  input    wire          bus_cmplt_x,
  input    wire          bus_grant_x,
  input    wire          cp0_lsu_icg_en,
  input    wire          cpurst_b,
  input    wire  [5 :0]  dc_xx_dest_preg,
  input    wire  [39:0]  dc_xx_pa,
  input    wire          forever_cpuclk,
  input    wire          ifu_lsu_warm_up,
  input    wire          lfb_create_alias_hit,
  input    wire  [1 :0]  lfb_create_alias_idx,
  input    wire  [3 :0]  lfb_create_alias_way,
  input    wire  [4 :0]  lfb_create_amo_func,
  input    wire          lfb_create_amo_inst,
  input    wire  [2 :0]  lfb_create_attr,
  input    wire  [7 :0]  lfb_create_bytes_vld,
  input    wire          lfb_create_ca,
  input    wire  [5 :0]  lfb_create_dest_reg,
  input    wire  [1 :0]  lfb_create_ele_size,
  input    wire          lfb_create_en_gate_x,
  input    wire          lfb_create_en_x,
  input    wire          lfb_create_fls,
  input    wire          lfb_create_ld,
  input    wire          lfb_create_lock,
  input    wire  [39:0]  lfb_create_pa,
  input    wire          lfb_create_pf,
  input    wire  [4 :0]  lfb_create_pfb_id,
  input    wire  [1 :0]  lfb_create_priv_mode,
  input    wire          lfb_create_ptw,
  input    wire  [1 :0]  lfb_create_sew,
  input    wire  [3 :0]  lfb_create_shift,
  input    wire          lfb_create_sign_ext,
  input    wire  [1 :0]  lfb_create_size,
  input    wire          lfb_create_split,
  input    wire          lfb_create_split_last,
  input    wire  [1 :0]  lfb_create_stbid,
  input    wire  [7 :0]  lfb_create_vfunc,
  input    wire  [1 :0]  lfb_create_virt_idx,
  input    wire  [6 :0]  lfb_create_vl_val,
  input    wire          lfb_create_vls,
  input    wire          lfb_create_vsplit_last,
  input    wire          lfb_create_wb,
  input    wire          pad_yy_icg_scan_en,
  input    wire  [39:0]  pfb_xx_pa,
  input    wire          rdl_cmplt_x,
  input    wire          rdl_grant_x,
  input    wire          rdl_lfb_alias_hit,
  input    wire          rdl_lfb_cache_hit,
  input    wire  [3 :0]  rdl_lfb_ref_fifo,
  input    wire          rtu_yy_xx_async_flush,
  output   wire          dc_hit_lfb_addr_x,
  output   wire          dc_hit_lfb_idx_x,
  output   wire          dc_hit_lfb_preg_x,
  output   wire          dc_hit_lfb_so_x,
  output   wire          dc_hit_lfb_vreg_x,
  output   wire          lfb_entry_arvalid_x,
  output   wire          lfb_entry_bus_rdy_x,
  output   wire          lfb_entry_ld_wo_stall_x,
  output   wire          lfb_entry_pop_en_x,
  output   wire          lfb_entry_rdl_req_x,
  output   wire          lfb_entry_ref_done_x,
  output   wire          lfb_entry_vld_x,
  output   wire          lfb_entry_wb_en_x,
  output   wire  [54:0]  lfb_entryx_arbus,
  output   wire  [6 :0]  lfb_entryx_dbginfo,
  output   wire  [36:0]  lfb_entryx_ldbus,
  output   wire  [39:0]  lfb_entryx_mtval,
  output   wire  [50:0]  lfb_entryx_rdl_bus,
  output   wire  [44:0]  lfb_entryx_refbus,
  output   wire  [6 :0]  lfb_entryx_stbus,
  output   wire  [20:0]  lfb_entryx_vldbus,
  output   wire          pfb_hit_lfb_idx_x
); 



// &Regs; @22
reg             lfb_alias_hit;          
reg     [1 :0]  lfb_alias_idx;          
reg     [3 :0]  lfb_alias_way;          
reg     [4 :0]  lfb_amo_func;           
reg             lfb_amo_inst;           
reg     [2 :0]  lfb_attr;               
reg     [7 :0]  lfb_byte_vld;           
reg             lfb_ca;                 
reg     [2 :0]  lfb_cur_state;          
reg     [5 :0]  lfb_dest_reg;           
reg     [1 :0]  lfb_ele_size;           
reg             lfb_fls;                
reg             lfb_ld;                 
reg             lfb_lock;               
reg     [2 :0]  lfb_next_state;         
reg     [39:0]  lfb_pa;                 
reg             lfb_pf;                 
reg     [4 :0]  lfb_pfb_id;             
reg     [1 :0]  lfb_priv_mode;          
reg             lfb_ptw;                
reg     [3 :0]  lfb_ref_fifo;           
reg     [1 :0]  lfb_sew;                
reg     [3 :0]  lfb_shift;              
reg             lfb_sign_ext;           
reg     [1 :0]  lfb_size;               
reg             lfb_split;              
reg             lfb_split_last;         
reg     [1 :0]  lfb_stbid;              
reg     [7 :0]  lfb_vfunc;              
reg     [1 :0]  lfb_virt_idx;           
reg     [6 :0]  lfb_vl_val;             
reg             lfb_vls;                
reg             lfb_vsplit_last;        
reg             lfb_wb;                 
reg             ref_err;                
reg             wb_en;                  

// &Wires; @23
wire            lfb_buf;                
wire    [3 :0]  lfb_cache;              
wire            lfb_cur_idle;           
wire            lfb_cur_rbus;           
wire            lfb_cur_rdl;            
wire            lfb_cur_ref;            
wire            lfb_cur_ref_1;          
wire            lfb_cur_wrdl;           
wire            lfb_dp_clk;             
wire            lfb_dp_clk_en;          
wire            lfb_entry_vld;          
wire            lfb_fsm_clk;            
wire            lfb_fsm_clk_en;         
wire            lfb_ld_inst;            
wire    [1 :0]  lfb_len;                
wire    [3 :0]  lfb_offset;             
wire    [2 :0]  lfb_prot;               
wire            lfb_ptw_for_flush;      
wire    [1 :0]  lfb_ref_cnt;            
wire            lfb_ref_en;             
wire    [7 :0]  lfb_ref_idx;            
wire    [1 :0]  lfb_ref_offset;         
wire    [27:0]  lfb_ref_tag;            
wire    [2 :0]  lfb_size_t;             
wire            lfb_so;                 
wire            lfb_st_err;             
wire            lfb_user;               
wire            lfb_wb_en;              
wire            refill_done;            


parameter PADDR = 40;
parameter CA    = 0;
parameter SO    = 1;
parameter BUF   = 2;

//================================================
//          LFB FSM
//================================================
parameter LFB_IDLE  = 3'b000;
parameter LFB_WRDL  = 3'b001;
parameter LFB_RDL   = 3'b010;
parameter LFB_RBUS  = 3'b011;
parameter LFB_REF_1 = 3'b100;
parameter LFB_REF_2 = 3'b101;
parameter LFB_REF_3 = 3'b110;
parameter LFB_REF_4 = 3'b111;

always@(posedge lfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_cur_state[2:0] <= LFB_IDLE;
  else
    lfb_cur_state[2:0] <= lfb_next_state[2:0];
end

// &CombBeg; @50
always @( lfb_create_en_x
       or bus_cmplt_x
       or rdl_cmplt_x
       or rdl_grant_x
       or lfb_pf
       or bus_grant_x
       or lfb_cur_state
       or rdl_lfb_cache_hit
       or lfb_ca)
begin
  case(lfb_cur_state)
    LFB_IDLE: begin
      if (lfb_create_en_x)
        lfb_next_state = LFB_WRDL;
      else
        lfb_next_state = LFB_IDLE;
    end
    LFB_WRDL: begin
      if (rdl_grant_x)
        lfb_next_state = LFB_RDL;
      else
        lfb_next_state = LFB_WRDL;
    end
    LFB_RDL: begin
      if (rdl_cmplt_x) begin
        if (lfb_pf & rdl_lfb_cache_hit)
          lfb_next_state = LFB_IDLE;
        else
          lfb_next_state = LFB_RBUS;
      end
      else
        lfb_next_state = LFB_RDL;
    end
    LFB_RBUS: begin
      if (bus_grant_x)
        lfb_next_state = LFB_REF_1;
      else
        lfb_next_state = LFB_RBUS;
    end
    LFB_REF_1: begin
      if (bus_cmplt_x)
        lfb_next_state = lfb_ca ? LFB_REF_2 : LFB_IDLE;
      else
        lfb_next_state = LFB_REF_1;
    end
    LFB_REF_2: begin
      if (bus_cmplt_x)
        lfb_next_state = LFB_REF_3;
      else
        lfb_next_state = LFB_REF_2;
    end
    LFB_REF_3: begin
      if (bus_cmplt_x)
        lfb_next_state = LFB_REF_4; 
      else
        lfb_next_state = LFB_REF_3;
    end
    LFB_REF_4: begin
      if (bus_cmplt_x)
        lfb_next_state = LFB_IDLE;
      else
        lfb_next_state = LFB_REF_4;
    end
    default: lfb_next_state = LFB_IDLE;
  endcase
// &CombEnd; @106
end

assign lfb_cur_idle = lfb_cur_state == LFB_IDLE;
assign lfb_cur_wrdl = lfb_cur_state == LFB_WRDL;
assign lfb_cur_rdl  = lfb_cur_state == LFB_RDL;
assign lfb_cur_rbus = lfb_cur_state == LFB_RBUS;
assign lfb_cur_ref_1 = lfb_cur_state == LFB_REF_1;
assign lfb_cur_ref  = lfb_cur_state[2];

assign lfb_entry_vld      = !lfb_cur_idle;
assign lfb_entry_vld_x    = lfb_entry_vld;
assign lfb_entry_pop_en_x = lfb_cur_rdl & rdl_cmplt_x & lfb_pf & rdl_lfb_cache_hit |
                            lfb_cur_ref_1 & bus_cmplt_x & !lfb_ca |
                            refill_done;

assign lfb_entry_bus_rdy_x = lfb_cur_rdl & rdl_cmplt_x & lfb_pf & rdl_lfb_cache_hit |
                             lfb_cur_rbus & bus_grant_x;

assign refill_done = lfb_cur_state == LFB_REF_4 & bus_cmplt_x;
                      
//================================================
// LFB entry content
//================================================
always@(posedge lfb_dp_clk)
begin
  if (lfb_create_en_gate_x | ifu_lsu_warm_up) begin
    lfb_pf                      <= lfb_create_pf;
    lfb_ld                      <= lfb_create_ld;
    lfb_ca                      <= lfb_create_ca;
    lfb_pa[PADDR-1:0]           <= lfb_create_pa[PADDR-1:0];
    lfb_virt_idx[1:0]           <= lfb_create_virt_idx[1:0];
    lfb_sign_ext                <= lfb_create_sign_ext;
    lfb_dest_reg[5:0]           <= lfb_create_dest_reg[5:0];
    lfb_vls                     <= lfb_create_vls;
    lfb_fls                     <= lfb_create_fls;
    lfb_lock                    <= lfb_create_lock;
    lfb_ptw                     <= lfb_create_ptw;
    lfb_split                   <= lfb_create_split;
    lfb_split_last              <= lfb_create_split_last;
    lfb_size[1:0]               <= lfb_create_size[1:0];
    lfb_attr[2:0]               <= lfb_create_attr[2:0];
    lfb_byte_vld[`LSU_BYTEW-1:0]<= lfb_create_bytes_vld[`LSU_BYTEW-1:0];
    lfb_shift[3:0]              <= lfb_create_shift[3:0];
    lfb_priv_mode[1:0]          <= lfb_create_priv_mode[1:0];
    lfb_wb                      <= lfb_create_wb;
    lfb_stbid[1:0]              <= lfb_create_stbid[1:0];
    lfb_amo_inst                <= lfb_create_amo_inst;
    lfb_amo_func[4:0]           <= lfb_create_amo_func[4:0];
    lfb_pfb_id[4:0]             <= lfb_create_pfb_id[4:0];
  end
end

always@(posedge lfb_dp_clk)
begin
  if (lfb_create_en_gate_x & lfb_create_vls | ifu_lsu_warm_up) begin
    lfb_ele_size[1:0] <= lfb_create_ele_size[1:0];
    lfb_sew[1:0]      <= lfb_create_sew[1:0];
    lfb_vfunc[7:0]    <= lfb_create_vfunc[7:0];
    lfb_vl_val[6:0]   <= lfb_create_vl_val[6:0];
    lfb_vsplit_last   <= lfb_create_vsplit_last;
  end
end

always@(posedge lfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    lfb_ref_fifo[3:0] <= 4'b0;
  else if (rdl_cmplt_x & lfb_cur_rdl)
    lfb_ref_fifo[3:0] <= rdl_lfb_ref_fifo[3:0];
end

always@(posedge lfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b) 
    lfb_alias_hit    <= 1'b0;
  else if (lfb_create_en_gate_x) 
    lfb_alias_hit    <= lfb_create_alias_hit;
  else if (rdl_cmplt_x & lfb_cur_rdl)
    lfb_alias_hit    <= rdl_lfb_alias_hit;
end

always@(posedge lfb_dp_clk)
begin
  if (lfb_create_en_gate_x | ifu_lsu_warm_up) begin
    lfb_alias_idx[1:0] <= lfb_create_alias_idx[1:0];
    lfb_alias_way[3:0] <= lfb_create_alias_way[3:0];
  end
end

//assign lfb_alias_hit_raw = lfb_pf & rdl_lfb_alias_hit | !lfb_pf & lfb_alias_hit;

//================================================
//  dependency check
//================================================
// &Force("bus","dc_xx_pa",PADDR-1,0); @200
// &Force("bus","pfb_xx_pa",PADDR-1,0); @201

assign dc_hit_lfb_idx_x   = (dc_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == lfb_pa[`D_TAG_INDEX_WIDTH+6-1:6]) & lfb_entry_vld;
assign dc_hit_lfb_addr_x  = (dc_xx_pa[21:6] == lfb_pa[21:6]) & lfb_entry_vld;
assign dc_hit_lfb_so_x    = lfb_entry_vld & lfb_ld & lfb_so;
assign dc_hit_lfb_preg_x  = lfb_entry_vld & lfb_ld & !lfb_vls & !lfb_pf &
                            (dc_xx_dest_preg[5:0] == lfb_dest_reg[5:0]);
assign dc_hit_lfb_vreg_x  = lfb_entry_vld & lfb_ld & lfb_vls & !lfb_pf;

assign pfb_hit_lfb_idx_x  = (pfb_xx_pa[`D_TAG_INDEX_WIDTH+6-1:6] == lfb_pa[`D_TAG_INDEX_WIDTH+6-1:6]) & lfb_ca & lfb_entry_vld;

//================================================
// request RDL for clear cache line
//================================================
parameter RDL_WIDTH = 51;
assign lfb_entry_rdl_req_x = lfb_cur_wrdl;

assign lfb_entryx_rdl_bus[RDL_WIDTH-1:0] 
                           = {lfb_pfb_id[4:0],
                              lfb_ca,
                              lfb_alias_way[3:0],
                              lfb_alias_hit,
                              lfb_pa[39:6],
                              lfb_virt_idx[1:0],
                              lfb_alias_idx[1:0],
                              lfb_ld,
                              lfb_pf};

//================================================
//  refill request 
//================================================
parameter REF_WIDTH  = 45;

always@(posedge lfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    ref_err <= 1'b0;
  else if (lfb_create_en_gate_x) 
    ref_err <= 1'b0;
  else if (bus_cmplt_x & bus_acc_err)
    ref_err <= 1'b1;
end

assign lfb_entryx_refbus[REF_WIDTH-1:0] 
                        = {lfb_ref_en,
                           lfb_ref_offset[1:0],
                           lfb_ref_cnt[1:0],
                           lfb_ref_fifo[3:0],
                           lfb_ref_tag[27:0],
                           lfb_ref_idx[7:0]};

assign lfb_ref_en          = lfb_ca & !ref_err;
assign lfb_ref_offset[1:0] = lfb_pa[5:4];
assign lfb_ref_cnt[1:0]    = lfb_cur_state[1:0];
assign lfb_ref_tag[27:0]   = lfb_pa[39:12];
assign lfb_ref_idx[7:0]    = {lfb_virt_idx[1:0],lfb_pa[11:6]};

//================================================
//  bus request
//================================================
parameter BUS_WIDTH = 55;
assign lfb_entry_arvalid_x = lfb_cur_rbus;

assign lfb_entryx_arbus[BUS_WIDTH-1:0] 
                           = {lfb_user,
                              lfb_alias_hit,
                              lfb_ld_inst,     
                              lfb_size_t[2:0],
                              lfb_len[1:0],
                              lfb_cache[3:0],
                              lfb_prot[2:0],
                              lfb_pa[PADDR-1:4],lfb_offset[3:0]};

assign lfb_ld_inst    = lfb_ld & !lfb_pf;
assign lfb_so         = lfb_attr[SO];
assign lfb_buf        = lfb_attr[CA] ? lfb_wb : lfb_attr[BUF];
assign lfb_cache[3:0] = {lfb_attr[CA],lfb_attr[CA],!lfb_so,lfb_buf};
assign lfb_prot[2:0]  = {1'b0,1'b1,lfb_priv_mode[0]};
assign lfb_len[1:0]   = lfb_ca ? 2'b11 : 2'b00;
assign lfb_user       = lfb_priv_mode[1];
assign lfb_offset[3:0]= lfb_so ? lfb_pa[3:0] : 4'b0;
assign lfb_size_t[2:0]= lfb_so ? {1'b0,lfb_size[1:0]} : 3'b100;

assign lfb_entry_ld_wo_stall_x = lfb_ld_inst & !lfb_so & (lfb_cur_rbus | lfb_cur_ref);

//================================================
// return data to DC
//================================================
assign lfb_ptw_for_flush = lfb_entry_vld & lfb_ptw | lfb_create_en_gate_x & lfb_create_ptw;

always@(posedge lfb_fsm_clk or negedge cpurst_b)
begin
  if (!cpurst_b)
    wb_en <= 1'b0;
  else if (!lfb_ptw_for_flush & rtu_yy_xx_async_flush)
    wb_en <= 1'b0;
  else if (lfb_create_en_gate_x)
    wb_en <= !lfb_create_pf & lfb_create_ld;
end

assign lfb_entry_wb_en_x = wb_en & lfb_ld_inst & !lfb_ptw;

assign lfb_wb_en = wb_en & (lfb_cur_state == LFB_REF_1);

parameter VLD_WIDTH = 21;

assign lfb_entryx_ldbus[`LSU_LD_WIDTH-1:0] 
                       = {lfb_amo_func[4:0],
                          lfb_amo_inst,
                          lfb_stbid[1:0],
                          lfb_shift[3:0],
                          lfb_lock,
                          lfb_ptw,
                          lfb_size[1:0],
                          lfb_wb_en,
                          lfb_pa[3],
                          lfb_sign_ext,
                          lfb_byte_vld[`LSU_BYTEW-1:0],
                          lfb_split,
                          lfb_split_last,
                          lfb_vls,
                          lfb_fls,
                          lfb_dest_reg[5:0]};
assign lfb_entryx_vldbus[VLD_WIDTH-1:0] 
                       = {lfb_vsplit_last,
                          lfb_vl_val[6:0],
                          1'b0,
                          lfb_vfunc[7:0],
                          lfb_ele_size[1:0], 
                          lfb_sew[1:0]};

assign lfb_entryx_mtval[PADDR-1:0] = lfb_pa[PADDR-1:0];
//assign lfb_entry_ld_inst_x = lfb_ld;

//================================================
//  return stb refill done
//================================================
parameter ST_WIDTH = 7;

assign lfb_entry_ref_done_x = refill_done & (!lfb_ld | lfb_amo_inst) & !lfb_pf;

assign lfb_st_err = ref_err | bus_acc_err;

assign lfb_entryx_stbus[ST_WIDTH-1:0] = {lfb_ref_fifo[3:0],lfb_st_err,lfb_stbid[1:0]};

//================================================
// ICG
//================================================
assign lfb_fsm_clk_en = lfb_create_en_gate_x | lfb_entry_vld;
// &Instance("gated_clk_cell", "x_pa_lsu_lfb_fsm_gated_clk"); @350
gated_clk_cell  x_pa_lsu_lfb_fsm_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lfb_fsm_clk       ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lfb_fsm_clk_en    ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @351
//          .external_en (1'b0), @352
//          .global_en   (1'b1), @353
//          .module_en   (cp0_lsu_icg_en), @354
//          .local_en    (lfb_fsm_clk_en), @355
//          .clk_out     (lfb_fsm_clk)); @356

assign lfb_dp_clk_en = lfb_create_en_gate_x | ifu_lsu_warm_up;
// &Instance("gated_clk_cell", "x_pa_lsu_lfb_dp_gated_clk"); @359
gated_clk_cell  x_pa_lsu_lfb_dp_gated_clk (
  .clk_in             (forever_cpuclk    ),
  .clk_out            (lfb_dp_clk        ),
  .external_en        (1'b0              ),
  .global_en          (1'b1              ),
  .local_en           (lfb_dp_clk_en     ),
  .module_en          (cp0_lsu_icg_en    ),
  .pad_yy_icg_scan_en (pad_yy_icg_scan_en)
);

// &Connect(.clk_in      (forever_cpuclk), @360
//          .external_en (1'b0), @361
//          .global_en   (1'b1), @362
//          .module_en   (cp0_lsu_icg_en), @363
//          .local_en    (lfb_dp_clk_en), @364
//          .clk_out     (lfb_dp_clk)); @365

//================================================
// DBG
//================================================
assign lfb_entryx_dbginfo[6:0] = {lfb_cur_state[2:0],lfb_pf,lfb_ld,lfb_ca,lfb_ptw};

// &ModuleEnd; @372
endmodule


