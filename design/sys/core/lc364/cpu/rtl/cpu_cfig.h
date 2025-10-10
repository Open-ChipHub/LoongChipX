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


`define YEAR1 4'b0010    
`define YEAR0 4'b0001    
`define MONTH 4'b1010    

`define REVISION    4'd1
`define SUB_VERSION 6'd4
`define PATCH       6'd3

`define PRODUCT_ID 12'h000

`define SCAN_CHAIN_8
`define SMBIST
`define DFT_AT_SPEED
`define JTLB_ENTRY_1024


`ifdef PMP
  `define PMP_REGION_8
`endif



`define BTB

`ifdef BTB
  `define BTB_1024
`endif


`define IBP

`ifdef IBP
  `define IBP_PRO
`endif


`define LBUF
  

// `define ICACHE_64K_128
`define ICACHE_64K
`define DCACHE_64K



`define PROCESSOR_0

`define MULTI_PROCESSING

`ifdef MULTI_PROCESSING
  `define PROCESSOR_1
`endif


`define PLIC
`ifdef PLIC
  `define PLIC_INT_NUM   144   
  `define PLIC_ID_NUM    10    
                               
  `define PLIC_PRIO_BIT  5     
  `define MAX_HART_NUM   32    
`endif


`define PMP

`define HPCP
`ifdef HPCP
  `define HPCP_CNT_NUM_16
`endif  

`ifdef HPCP_CNT_NUM_4
  `define HPCP_CNT_GROUP0
`endif 

`ifdef HPCP_CNT_NUM_8
  `define HPCP_CNT_GROUP0
  `define HPCP_CNT_GROUP1
`endif 

`ifdef HPCP_CNT_NUM_16
  `define HPCP_CNT_GROUP0
  `define HPCP_CNT_GROUP1
  `define HPCP_CNT_GROUP2
`endif 


`ifdef HPCP_CNT_NUM_29
  `define HPCP_CNT_GROUP0 
  `define HPCP_CNT_GROUP1 
  `define HPCP_CNT_GROUP2 
  `define HPCP_CNT_GROUP3 
`endif 

`define FPR_WIDTH 63
`define VEC_WIDTH 63

`ifdef JTLB_ENTRY_1024
  `define JTLB_ADDR_WIDTH 8
`endif
`ifdef JTLB_ENTRY_2048
  `define JTLB_ADDR_WIDTH 9
`endif



`ifdef PROCESSOR_3
  `define PLIC_HART_NUM  5'h4
`else
  `ifdef PROCESSOR_2
    `define PLIC_HART_NUM  5'h3
  `else
    `ifdef PROCESSOR_1
      `define PLIC_HART_NUM  5'h2
    `else
      `ifdef PROCESSOR_0
          `define PLIC_HART_NUM  5'h1
      `endif
    `endif
  `endif
`endif

`ifdef PROCESSOR_1
  `define LSU_SHAREABLE
`endif

`define PA_WIDTH 40
`define VA_WIDTH 39

`define SAB_DEPTH  24
`define SAB_RDEPTH 16
`define SAB_WDEPTH 8

