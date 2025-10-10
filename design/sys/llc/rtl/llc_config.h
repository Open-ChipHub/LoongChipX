
`define FPGA

`define L2_CACHE_16WAY
`define L2_CACHE_4M

`ifdef L2_CACHE_8WAY
  `ifdef L2_CACHE_128K
    `define L2C_TAG_INDEX_WIDTH   7
    `define L2C_TAG_DATA_WIDTH    26  
    `define L2C_DATA_INDEX_WIDTH  10
  `endif
  
  `ifdef L2_CACHE_256K
    `define L2C_TAG_INDEX_WIDTH   8
    `define L2C_TAG_DATA_WIDTH    25  
    `define L2C_DATA_INDEX_WIDTH  11
  `endif
  
  `ifdef L2_CACHE_512K
    `define L2C_TAG_INDEX_WIDTH   9
    `define L2C_TAG_DATA_WIDTH    24  
    `define L2C_DATA_INDEX_WIDTH  12
  `endif
  
  `ifdef L2_CACHE_1M
    `define L2C_TAG_INDEX_WIDTH   10
    `define L2C_TAG_DATA_WIDTH    23  
    `define L2C_DATA_INDEX_WIDTH  13
  `endif

  `ifdef L2_CACHE_2M
    `define L2C_TAG_INDEX_WIDTH   11
    `define L2C_TAG_DATA_WIDTH    22
    `define L2C_DATA_INDEX_WIDTH  14
  `endif

  `ifdef L2_CACHE_4M
    `define L2C_TAG_INDEX_WIDTH   12
    `define L2C_TAG_DATA_WIDTH    21
    `define L2C_DATA_INDEX_WIDTH  15
  `endif

  `ifdef L2_CACHE_8M
    `define L2C_TAG_INDEX_WIDTH   13
    `define L2C_TAG_DATA_WIDTH    20
    `define L2C_DATA_INDEX_WIDTH  16
  `endif
`endif

`ifdef L2_CACHE_16WAY
  `ifdef L2_CACHE_128K
    `define L2C_TAG_INDEX_WIDTH   6
    `define L2C_TAG_DATA_WIDTH    27   
    `define L2C_DATA_INDEX_WIDTH  10
  `endif
  
  `ifdef L2_CACHE_256K
    `define L2C_TAG_INDEX_WIDTH   7 
    `define L2C_TAG_DATA_WIDTH    26   
    `define L2C_DATA_INDEX_WIDTH  11 
  `endif
  
  `ifdef L2_CACHE_512K
    `define L2C_TAG_INDEX_WIDTH   8
    `define L2C_TAG_DATA_WIDTH    25   
    `define L2C_DATA_INDEX_WIDTH  12
  `endif
  
  `ifdef L2_CACHE_1M
    `define L2C_TAG_INDEX_WIDTH   9
    `define L2C_TAG_DATA_WIDTH    24    
    `define L2C_DATA_INDEX_WIDTH  13
  `endif

  `ifdef L2_CACHE_2M
    `define L2C_TAG_INDEX_WIDTH   10
    `define L2C_TAG_DATA_WIDTH    23
    `define L2C_DATA_INDEX_WIDTH  14
  `endif

  `ifdef L2_CACHE_4M
    `define L2C_TAG_INDEX_WIDTH   11
    `define L2C_TAG_DATA_WIDTH    22
    `define L2C_DATA_INDEX_WIDTH  15
  `endif

  `ifdef L2_CACHE_8M
    `define L2C_TAG_INDEX_WIDTH   12
    `define L2C_TAG_DATA_WIDTH    21
    `define L2C_DATA_INDEX_WIDTH  16
  `endif
`endif
