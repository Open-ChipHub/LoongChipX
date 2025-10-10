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

// &ModuleBeg; @26
module aq_fadd_double_round (
  // &Ports, @27
  input    wire          ex2_act_s,
  input    wire  [53:0]  ex2_adder_sub_r,
  input    wire  [8 :0]  ex2_bhalf0_sub000xx_rslt,
  input    wire          ex2_both_dn_no_widden,
  input    wire  [56:0]  ex2_double_add_inc1_r,
  input    wire  [56:0]  ex2_double_add_inc2_r,
  input    wire  [56:0]  ex2_double_add_r,
  input    wire  [53:0]  ex2_double_sub000xx_rslt,
  input    wire  [56:0]  ex2_double_sub_inc1_r,
  input    wire  [56:0]  ex2_double_sub_inc2_r,
  input    wire  [56:0]  ex2_double_sub_r,
  input    wire  [11:0]  ex2_half0_sub000xx_rslt,
  input    wire          ex2_r_add01xxx,
  input    wire          ex2_r_add1xxxx,
  input    wire          ex2_r_sel000xx,
  input    wire          ex2_r_sub000xx,
  input    wire          ex2_r_sub001xx,
  input    wire          ex2_r_sub01xxx,
  input    wire          ex2_rdn,
  input    wire          ex2_rmm,
  input    wire          ex2_rne,
  input    wire          ex2_rtz,
  input    wire          ex2_rup,
  input    wire  [24:0]  ex2_single0_sub000xx_rslt,
  input    wire          ex2_special_value_vld,
  output   wire  [8 :0]  ex2_bhalf0_addsub_rslt,
  output   wire  [53:0]  ex2_double_addsub_rslt,
  output   wire  [11:0]  ex2_half0_addsub_rslt,
  output   wire          ex2_nx,
  output   wire  [24:0]  ex2_single0_addsub_rslt
); 



// &Regs; @28
// &Wires; @29
wire            ex2_add01xxx_rdn_inc1;    
wire            ex2_add01xxx_rmm_inc1;    
wire            ex2_add01xxx_rne_inc1;    
wire            ex2_add01xxx_round_g;     
wire            ex2_add01xxx_round_inc1;  
wire            ex2_add01xxx_round_l;     
wire            ex2_add01xxx_round_r;     
wire            ex2_add01xxx_round_s;     
wire    [53:0]  ex2_add01xxx_rslt;        
wire            ex2_add01xxx_rtz_inc1;    
wire            ex2_add01xxx_rup_inc1;    
wire            ex2_add1xxxx_rdn_inc1;    
wire            ex2_add1xxxx_rmm_inc1;    
wire            ex2_add1xxxx_rne_inc1;    
wire            ex2_add1xxxx_round_g;     
wire            ex2_add1xxxx_round_inc1;  
wire            ex2_add1xxxx_round_l;     
wire            ex2_add1xxxx_round_r;     
wire            ex2_add1xxxx_round_s;     
wire    [53:0]  ex2_add1xxxx_rslt;        
wire            ex2_add1xxxx_rtz_inc1;    
wire            ex2_add1xxxx_rup_inc1;    
wire            ex2_sub001xx_rdn_inc1;    
wire            ex2_sub001xx_rmm_inc1;    
wire            ex2_sub001xx_rne_inc1;    
wire            ex2_sub001xx_round_g;     
wire            ex2_sub001xx_round_inc1;  
wire            ex2_sub001xx_round_l;     
wire            ex2_sub001xx_round_r;     
wire            ex2_sub001xx_round_s;     
wire    [53:0]  ex2_sub001xx_rslt;        
wire            ex2_sub001xx_rtz_inc1;    
wire            ex2_sub001xx_rup_inc1;    
wire            ex2_sub01xxx_rdn_inc1;    
wire            ex2_sub01xxx_rmm_inc1;    
wire            ex2_sub01xxx_rne_inc1;    
wire            ex2_sub01xxx_round_g;     
wire            ex2_sub01xxx_round_inc1;  
wire            ex2_sub01xxx_round_l;     
wire            ex2_sub01xxx_round_r;     
wire            ex2_sub01xxx_round_s;     
wire    [53:0]  ex2_sub01xxx_rslt;        
wire            ex2_sub01xxx_rtz_inc1;    
wire            ex2_sub01xxx_rup_inc1;    
wire    [53:0]  tmp_rnd_path_rslt;        



// &Force("bus","ex2_double_add_inc1_r",56,0); @32
// &Force("bus","ex2_double_add_inc2_r",56,0); @33
// &Force("bus","ex2_double_sub_inc1_r",56,0); @34
// &Force("bus","ex2_double_sub_inc2_r",56,0); @35
// &Force("bus","ex2_double_sub_r",56,0); @36
assign ex2_add1xxxx_round_g  = ex2_double_add_r[3]; 
assign ex2_sub001xx_round_g  = ex2_double_sub_r[1]; 
assign ex2_add01xxx_round_g  = ex2_double_add_r[2];
assign ex2_sub01xxx_round_g  = ex2_double_sub_r[2];

assign ex2_add1xxxx_round_r  = ex2_double_add_r[2];
assign ex2_sub001xx_round_r  = ex2_double_sub_r[0];
assign ex2_add01xxx_round_r  = ex2_double_add_r[1];
assign ex2_sub01xxx_round_r  = ex2_double_sub_r[1];

assign ex2_add1xxxx_round_s  = (ex2_double_add_r[1]  
                                | ex2_double_add_r[0]);
assign ex2_sub001xx_round_s  = 1'b0;
assign ex2_add01xxx_round_s  = ex2_double_add_r[0];
assign ex2_sub01xxx_round_s  = ex2_double_sub_r[0];

assign ex2_add1xxxx_round_l  = ex2_r_add1xxxx & ex2_double_add_r[4]; 
assign ex2_sub001xx_round_l  = ex2_r_sub001xx & ex2_double_sub_r[2];
assign ex2_add01xxx_round_l  = ex2_r_add01xxx & ex2_double_add_r[3]; 
assign ex2_sub01xxx_round_l  = ex2_r_sub01xxx & ex2_double_sub_r[3];



assign ex2_add1xxxx_rne_inc1   = ex2_add1xxxx_round_g && 
                                (ex2_add1xxxx_round_l 
                                 || !ex2_add1xxxx_round_l && 
                                    (ex2_add1xxxx_round_s || ex2_add1xxxx_round_r));
assign ex2_add1xxxx_rtz_inc1   = 1'b0;
assign ex2_add1xxxx_rdn_inc1   = ex2_act_s  && (ex2_add1xxxx_round_g || ex2_add1xxxx_round_r || ex2_add1xxxx_round_s);
assign ex2_add1xxxx_rup_inc1   = !ex2_act_s && (ex2_add1xxxx_round_g || ex2_add1xxxx_round_r || ex2_add1xxxx_round_s);
assign ex2_add1xxxx_rmm_inc1   = ex2_add1xxxx_round_g;
assign ex2_add1xxxx_round_inc1 = ex2_rne && ex2_add1xxxx_rne_inc1 ||
                                 ex2_rtz && ex2_add1xxxx_rtz_inc1 ||
                                 ex2_rdn && ex2_add1xxxx_rdn_inc1 ||
                                 ex2_rup && ex2_add1xxxx_rup_inc1 ||
                                 ex2_rmm && ex2_add1xxxx_rmm_inc1;
//add 1.xxxx round 
assign ex2_add01xxx_rne_inc1 = ex2_add01xxx_round_g && 
                              (ex2_add01xxx_round_l 
                               || !ex2_add01xxx_round_l && 
                                  (ex2_add01xxx_round_s || ex2_add01xxx_round_r));
assign ex2_add01xxx_rtz_inc1 = 1'b0;
assign ex2_add01xxx_rdn_inc1 = ex2_act_s  && (ex2_add01xxx_round_g || ex2_add01xxx_round_r || ex2_add01xxx_round_s);
assign ex2_add01xxx_rup_inc1 = !ex2_act_s && (ex2_add01xxx_round_g || ex2_add01xxx_round_r || ex2_add01xxx_round_s);
assign ex2_add01xxx_rmm_inc1 = ex2_add01xxx_round_g;
assign ex2_add01xxx_round_inc1 = ex2_rne && ex2_add01xxx_rne_inc1 ||
                                 ex2_rtz && ex2_add01xxx_rtz_inc1 ||
                                 ex2_rdn && ex2_add01xxx_rdn_inc1 ||
                                 ex2_rup && ex2_add01xxx_rup_inc1 ||
                                 ex2_rmm && ex2_add01xxx_rmm_inc1;
// add sub1.xxxx round                        
assign ex2_sub01xxx_rne_inc1 = ex2_sub01xxx_round_g && 
                              (ex2_sub01xxx_round_l 
                               || !ex2_sub01xxx_round_l && 
                                  (ex2_sub01xxx_round_s || ex2_sub01xxx_round_r));
assign ex2_sub01xxx_rtz_inc1 = 1'b0;
assign ex2_sub01xxx_rdn_inc1 = ex2_act_s  && (ex2_sub01xxx_round_g || ex2_sub01xxx_round_r || ex2_sub01xxx_round_s);
assign ex2_sub01xxx_rup_inc1 = !ex2_act_s && (ex2_sub01xxx_round_g || ex2_sub01xxx_round_r || ex2_sub01xxx_round_s);
assign ex2_sub01xxx_rmm_inc1 = ex2_sub01xxx_round_g;
assign ex2_sub01xxx_round_inc1 = ex2_rne && ex2_sub01xxx_rne_inc1 ||
                        ex2_rtz && ex2_sub01xxx_rtz_inc1 ||
                        ex2_rdn && ex2_sub01xxx_rdn_inc1 ||
                        ex2_rup && ex2_sub01xxx_rup_inc1 ||
                        ex2_rmm && ex2_sub01xxx_rmm_inc1;

// add sub0.1xxxx round                        
assign ex2_sub001xx_rne_inc1 = ex2_sub001xx_round_g && 
                              (ex2_sub001xx_round_l 
                               || !ex2_sub001xx_round_l && 
                                  (ex2_sub001xx_round_s || ex2_sub001xx_round_r));
assign ex2_sub001xx_rtz_inc1 = 1'b0;
assign ex2_sub001xx_rdn_inc1 = ex2_act_s  && (ex2_sub001xx_round_g || ex2_sub001xx_round_r || ex2_sub001xx_round_s);
assign ex2_sub001xx_rup_inc1 = !ex2_act_s && (ex2_sub001xx_round_g || ex2_sub001xx_round_r || ex2_sub001xx_round_s);
assign ex2_sub001xx_rmm_inc1 = ex2_sub001xx_round_g;
assign ex2_sub001xx_round_inc1 = ex2_rne && ex2_sub001xx_rne_inc1 ||
                                 ex2_rtz && ex2_sub001xx_rtz_inc1 ||
                                 ex2_rdn && ex2_sub001xx_rdn_inc1 ||
                                 ex2_rup && ex2_sub001xx_rup_inc1 ||
                                 ex2_rmm && ex2_sub001xx_rmm_inc1;


assign ex2_add1xxxx_rslt[53:0]  = ex2_add1xxxx_round_inc1 ? ex2_double_add_inc2_r[56:3]
                                                          : ex2_double_add_r[56:3];
assign ex2_add01xxx_rslt[53:0]  = ex2_add01xxx_round_inc1 ? ex2_double_add_inc1_r[56:3]
                                                          : ex2_double_add_r[56:3];

assign ex2_sub01xxx_rslt[53:0]  = ex2_both_dn_no_widden   ? ex2_adder_sub_r[53:0] : 
                                  ex2_sub01xxx_round_inc1 ? ex2_double_sub_inc2_r[55:2]  
                                                          : ex2_double_sub_r[55:2];
assign ex2_sub001xx_rslt[53:0]  = ex2_sub001xx_round_inc1 ? ex2_double_sub_inc1_r[55:2]
                                                          : ex2_double_sub_r[55:2];

assign tmp_rnd_path_rslt[53:0]  = {54{ex2_r_add1xxxx}} & ex2_add1xxxx_rslt[53:0] |
                                  {54{ex2_r_add01xxx}} & ex2_add01xxx_rslt[53:0] |
                                  {54{ex2_r_sub01xxx}} & ex2_sub01xxx_rslt[53:0] |
                                  {54{ex2_r_sub001xx}} & ex2_sub001xx_rslt[53:0];

assign ex2_double_addsub_rslt[53:0]  = ex2_r_sel000xx ? ex2_double_sub000xx_rslt[53:0]
                                                      : tmp_rnd_path_rslt[53:0];
assign ex2_single0_addsub_rslt[24:0] = tmp_rnd_path_rslt[24:0] |
                                      {25{ex2_r_sel000xx}} & ex2_single0_sub000xx_rslt[24:0];
assign ex2_half0_addsub_rslt[11:0]   = tmp_rnd_path_rslt[11:0] |
                                      {12{ex2_r_sub000xx}} & ex2_half0_sub000xx_rslt[11:0];
assign ex2_bhalf0_addsub_rslt[8:0]  = tmp_rnd_path_rslt[8:0] |
                                      {9{ex2_r_sub000xx}} & ex2_bhalf0_sub000xx_rslt[8:0];  

assign ex2_nx      = (ex2_r_add1xxxx && !ex2_both_dn_no_widden && (ex2_add1xxxx_round_g || ex2_add1xxxx_round_r || ex2_add1xxxx_round_s) || 
                      ex2_r_add01xxx && (ex2_add01xxx_round_g || ex2_add01xxx_round_r || ex2_add01xxx_round_s) || 
                      ex2_r_sub01xxx && !ex2_both_dn_no_widden && (ex2_sub01xxx_round_g || ex2_sub01xxx_round_r || ex2_sub01xxx_round_s) || 
                      ex2_r_sub001xx && (ex2_sub001xx_round_g || ex2_sub001xx_round_r || ex2_sub001xx_round_s)) && !ex2_special_value_vld;


// &ModuleEnd; @149
endmodule


