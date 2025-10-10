
module ct_iu_crc (
	input    wire  [63:0]  crc_a,
	input    wire  [63:0]  crc_msg,
	input    wire  [31:0]  crc_poly,
	input    wire  [ 1:0]  crc_type,
	output   wire  [63:0]  crc_check_sum
);

wire [63:0] chksum_value;
wire [1 :0] size_type;
wire [31:0] crc_chksum_mask_63;
wire [31:0] crc_chksum_mask_63_shift;
wire [31:0] crc_chksum_mask_62;
wire [31:0] crc_chksum_mask_62_shift;
wire [31:0] crc_chksum_mask_61;
wire [31:0] crc_chksum_mask_61_shift;
wire [31:0] crc_chksum_mask_60;
wire [31:0] crc_chksum_mask_60_shift;
wire [31:0] crc_chksum_mask_59;
wire [31:0] crc_chksum_mask_59_shift;
wire [31:0] crc_chksum_mask_58;
wire [31:0] crc_chksum_mask_58_shift;
wire [31:0] crc_chksum_mask_57;
wire [31:0] crc_chksum_mask_57_shift;
wire [31:0] crc_chksum_mask_56;
wire [31:0] crc_chksum_mask_56_shift;
wire [31:0] crc_chksum_mask_55;
wire [31:0] crc_chksum_mask_55_shift;
wire [31:0] crc_chksum_mask_54;
wire [31:0] crc_chksum_mask_54_shift;
wire [31:0] crc_chksum_mask_53;
wire [31:0] crc_chksum_mask_53_shift;
wire [31:0] crc_chksum_mask_52;
wire [31:0] crc_chksum_mask_52_shift;
wire [31:0] crc_chksum_mask_51;
wire [31:0] crc_chksum_mask_51_shift;
wire [31:0] crc_chksum_mask_50;
wire [31:0] crc_chksum_mask_50_shift;
wire [31:0] crc_chksum_mask_49;
wire [31:0] crc_chksum_mask_49_shift;
wire [31:0] crc_chksum_mask_48;
wire [31:0] crc_chksum_mask_48_shift;
wire [31:0] crc_chksum_mask_47;
wire [31:0] crc_chksum_mask_47_shift;
wire [31:0] crc_chksum_mask_46;
wire [31:0] crc_chksum_mask_46_shift;
wire [31:0] crc_chksum_mask_45;
wire [31:0] crc_chksum_mask_45_shift;
wire [31:0] crc_chksum_mask_44;
wire [31:0] crc_chksum_mask_44_shift;
wire [31:0] crc_chksum_mask_43;
wire [31:0] crc_chksum_mask_43_shift;
wire [31:0] crc_chksum_mask_42;
wire [31:0] crc_chksum_mask_42_shift;
wire [31:0] crc_chksum_mask_41;
wire [31:0] crc_chksum_mask_41_shift;
wire [31:0] crc_chksum_mask_40;
wire [31:0] crc_chksum_mask_40_shift;
wire [31:0] crc_chksum_mask_39;
wire [31:0] crc_chksum_mask_39_shift;
wire [31:0] crc_chksum_mask_38;
wire [31:0] crc_chksum_mask_38_shift;
wire [31:0] crc_chksum_mask_37;
wire [31:0] crc_chksum_mask_37_shift;
wire [31:0] crc_chksum_mask_36;
wire [31:0] crc_chksum_mask_36_shift;
wire [31:0] crc_chksum_mask_35;
wire [31:0] crc_chksum_mask_35_shift;
wire [31:0] crc_chksum_mask_34;
wire [31:0] crc_chksum_mask_34_shift;
wire [31:0] crc_chksum_mask_33;
wire [31:0] crc_chksum_mask_33_shift;
wire [31:0] crc_chksum_mask_32;
wire [31:0] crc_chksum_mask_32_shift;
wire [31:0] crc_chksum_mask_31;
wire [31:0] crc_chksum_mask_31_shift;
wire [31:0] crc_chksum_mask_30;
wire [31:0] crc_chksum_mask_30_shift;
wire [31:0] crc_chksum_mask_29;
wire [31:0] crc_chksum_mask_29_shift;
wire [31:0] crc_chksum_mask_28;
wire [31:0] crc_chksum_mask_28_shift;
wire [31:0] crc_chksum_mask_27;
wire [31:0] crc_chksum_mask_27_shift;
wire [31:0] crc_chksum_mask_26;
wire [31:0] crc_chksum_mask_26_shift;
wire [31:0] crc_chksum_mask_25;
wire [31:0] crc_chksum_mask_25_shift;
wire [31:0] crc_chksum_mask_24;
wire [31:0] crc_chksum_mask_24_shift;
wire [31:0] crc_chksum_mask_23;
wire [31:0] crc_chksum_mask_23_shift;
wire [31:0] crc_chksum_mask_22;
wire [31:0] crc_chksum_mask_22_shift;
wire [31:0] crc_chksum_mask_21;
wire [31:0] crc_chksum_mask_21_shift;
wire [31:0] crc_chksum_mask_20;
wire [31:0] crc_chksum_mask_20_shift;
wire [31:0] crc_chksum_mask_19;
wire [31:0] crc_chksum_mask_19_shift;
wire [31:0] crc_chksum_mask_18;
wire [31:0] crc_chksum_mask_18_shift;
wire [31:0] crc_chksum_mask_17;
wire [31:0] crc_chksum_mask_17_shift;
wire [31:0] crc_chksum_mask_16;
wire [31:0] crc_chksum_mask_16_shift;
wire [31:0] crc_chksum_mask_15;
wire [31:0] crc_chksum_mask_15_shift;
wire [31:0] crc_chksum_mask_14;
wire [31:0] crc_chksum_mask_14_shift;
wire [31:0] crc_chksum_mask_13;
wire [31:0] crc_chksum_mask_13_shift;
wire [31:0] crc_chksum_mask_12;
wire [31:0] crc_chksum_mask_12_shift;
wire [31:0] crc_chksum_mask_11;
wire [31:0] crc_chksum_mask_11_shift;
wire [31:0] crc_chksum_mask_10;
wire [31:0] crc_chksum_mask_10_shift;
wire [31:0] crc_chksum_mask_9;
wire [31:0] crc_chksum_mask_9_shift;
wire [31:0] crc_chksum_mask_8;
wire [31:0] crc_chksum_mask_8_shift;
wire [31:0] crc_chksum_mask_7;
wire [31:0] crc_chksum_mask_7_shift;
wire [31:0] crc_chksum_mask_6;
wire [31:0] crc_chksum_mask_6_shift;
wire [31:0] crc_chksum_mask_5;
wire [31:0] crc_chksum_mask_5_shift;
wire [31:0] crc_chksum_mask_4;
wire [31:0] crc_chksum_mask_4_shift;
wire [31:0] crc_chksum_mask_3;
wire [31:0] crc_chksum_mask_3_shift;
wire [31:0] crc_chksum_mask_2;
wire [31:0] crc_chksum_mask_2_shift;
wire [31:0] crc_chksum_mask_1;
wire [31:0] crc_chksum_mask_1_shift;
wire [31:0] crc_chksum_mask_0;

wire [31:0] cond_value;
wire [31:0] select_value;
wire [31:0] select_value_0;
wire [31:0] select_value_1;
wire [31:0] select_value_2;
wire [31:0] select_value_3;
wire [31:0] select_value_4;
wire [31:0] select_value_5;
wire [31:0] select_value_6;
wire [31:0] select_value_7;
wire [31:0] select_value_8;
wire [31:0] select_value_9;
wire [31:0] select_value_10;
wire [31:0] select_value_11;
wire [31:0] select_value_12;
wire [31:0] select_value_13;
wire [31:0] select_value_14;
wire [31:0] select_value_15;
wire [31:0] select_value_16;
wire [31:0] select_value_17;
wire [31:0] select_value_18;
wire [31:0] select_value_19;
wire [31:0] select_value_20;
wire [31:0] select_value_21;
wire [31:0] select_value_22;
wire [31:0] select_value_23;
wire [31:0] select_value_24;
wire [31:0] select_value_25;
wire [31:0] select_value_26;
wire [31:0] select_value_27;
wire [31:0] select_value_28;
wire [31:0] select_value_29;
wire [31:0] select_value_30;
wire [31:0] select_value_31;
wire [31:0] select_value_32;
wire [31:0] select_value_33;
wire [31:0] select_value_34;
wire [31:0] select_value_35;
wire [31:0] select_value_36;
wire [31:0] select_value_37;
wire [31:0] select_value_38;
wire [31:0] select_value_39;
wire [31:0] select_value_40;
wire [31:0] select_value_41;
wire [31:0] select_value_42;
wire [31:0] select_value_43;
wire [31:0] select_value_44;
wire [31:0] select_value_45;
wire [31:0] select_value_46;
wire [31:0] select_value_47;
wire [31:0] select_value_48;
wire [31:0] select_value_49;
wire [31:0] select_value_50;
wire [31:0] select_value_51;
wire [31:0] select_value_52;
wire [31:0] select_value_53;
wire [31:0] select_value_54;
wire [31:0] select_value_55;
wire [31:0] select_value_56;
wire [31:0] select_value_57;
wire [31:0] select_value_58;
wire [31:0] select_value_59;
wire [31:0] select_value_60;
wire [31:0] select_value_61;
wire [31:0] select_value_62;


assign size_type_b = size_type[1:0] == 2'b00;
assign size_type_h = size_type[1:0] == 2'b01;
assign size_type_w = size_type[1:0] == 2'b10;
assign size_type_d = size_type[1:0] == 2'b11;

assign chksum_value[63:0] =  {64{size_type_b}} & {{32'b0, crc_a[31:0]} ^ {56'b0, crc_msg[7 :0]}}
                           | {64{size_type_h}} & {{32'b0, crc_a[31:0]} ^ {48'b0, crc_msg[15:0]}}  
                           | {64{size_type_w}} & {{32'b0, crc_a[31:0]} ^ {32'b0, crc_msg[31:0]}}  
                           | {64{size_type_d}} & {{32'b0, crc_a[31:0]} ^ {       crc_msg[63:0]}};  


assign crc_chksum_mask_63[31:0] = chksum_value[31:0];

assign crc_chksum_mask_63_shift[31:0] = {1'b0, crc_chksum_mask_63[31:1]}; 
assign crc_chksum_mask_62[31:0]       = crc_chksum_mask_63[0] ? crc_chksum_mask_63_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_63_shift[31:0];

assign crc_chksum_mask_62_shift[31:0] = {1'b0, crc_chksum_mask_62[31:1]}; 
assign crc_chksum_mask_61[31:0]       = crc_chksum_mask_62[0] ? crc_chksum_mask_62_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_62_shift[31:0];

assign crc_chksum_mask_61_shift[31:0] = {1'b0, crc_chksum_mask_61[31:1]}; 
assign crc_chksum_mask_60[31:0]       = crc_chksum_mask_61[0] ? crc_chksum_mask_61_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_61_shift[31:0];

assign crc_chksum_mask_60_shift[31:0] = {1'b0, crc_chksum_mask_60[31:1]}; 
assign crc_chksum_mask_59[31:0]       = crc_chksum_mask_60[0] ? crc_chksum_mask_60_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_60_shift[31:0];

assign crc_chksum_mask_59_shift[31:0] = {1'b0, crc_chksum_mask_59[31:1]}; 
assign crc_chksum_mask_58[31:0]       = crc_chksum_mask_59[0] ? crc_chksum_mask_59_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_59_shift[31:0];

assign crc_chksum_mask_58_shift[31:0] = {1'b0, crc_chksum_mask_58[31:1]}; 
assign crc_chksum_mask_57[31:0]       = crc_chksum_mask_58[0] ? crc_chksum_mask_58_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_58_shift[31:0];

assign crc_chksum_mask_57_shift[31:0] = {1'b0, crc_chksum_mask_57[31:1]}; 
assign crc_chksum_mask_56[31:0]       = crc_chksum_mask_57[0] ? crc_chksum_mask_57_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_57_shift[31:0];

assign crc_chksum_mask_56_shift[31:0] = {1'b0, crc_chksum_mask_56[31:1]}; 
assign crc_chksum_mask_55[31:0]       = crc_chksum_mask_56[0] ? crc_chksum_mask_56_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_56_shift[31:0];

assign crc_chksum_mask_55_shift[31:0] = {1'b0, crc_chksum_mask_55[31:1]}; 
assign crc_chksum_mask_54[31:0]       = crc_chksum_mask_55[0] ? crc_chksum_mask_55_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_55_shift[31:0];

assign crc_chksum_mask_54_shift[31:0] = {1'b0, crc_chksum_mask_54[31:1]}; 
assign crc_chksum_mask_53[31:0]       = crc_chksum_mask_54[0] ? crc_chksum_mask_54_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_54_shift[31:0];

assign crc_chksum_mask_53_shift[31:0] = {1'b0, crc_chksum_mask_53[31:1]}; 
assign crc_chksum_mask_52[31:0]       = crc_chksum_mask_53[0] ? crc_chksum_mask_53_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_53_shift[31:0];

assign crc_chksum_mask_52_shift[31:0] = {1'b0, crc_chksum_mask_52[31:1]}; 
assign crc_chksum_mask_51[31:0]       = crc_chksum_mask_52[0] ? crc_chksum_mask_52_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_52_shift[31:0];

assign crc_chksum_mask_51_shift[31:0] = {1'b0, crc_chksum_mask_51[31:1]}; 
assign crc_chksum_mask_50[31:0]       = crc_chksum_mask_51[0] ? crc_chksum_mask_51_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_51_shift[31:0];

assign crc_chksum_mask_50_shift[31:0] = {1'b0, crc_chksum_mask_50[31:1]}; 
assign crc_chksum_mask_49[31:0]       = crc_chksum_mask_50[0] ? crc_chksum_mask_50_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_50_shift[31:0];

assign crc_chksum_mask_49_shift[31:0] = {1'b0, crc_chksum_mask_49[31:1]}; 
assign crc_chksum_mask_48[31:0]       = crc_chksum_mask_49[0] ? crc_chksum_mask_49_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_49_shift[31:0];

assign crc_chksum_mask_48_shift[31:0] = {1'b0, crc_chksum_mask_48[31:1]}; 
assign crc_chksum_mask_47[31:0]       = crc_chksum_mask_48[0] ? crc_chksum_mask_48_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_48_shift[31:0];

assign crc_chksum_mask_47_shift[31:0] = {1'b0, crc_chksum_mask_47[31:1]}; 
assign crc_chksum_mask_46[31:0]       = crc_chksum_mask_47[0] ? crc_chksum_mask_47_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_47_shift[31:0];

assign crc_chksum_mask_46_shift[31:0] = {1'b0, crc_chksum_mask_46[31:1]}; 
assign crc_chksum_mask_45[31:0]       = crc_chksum_mask_46[0] ? crc_chksum_mask_46_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_46_shift[31:0];

assign crc_chksum_mask_45_shift[31:0] = {1'b0, crc_chksum_mask_45[31:1]}; 
assign crc_chksum_mask_44[31:0]       = crc_chksum_mask_45[0] ? crc_chksum_mask_45_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_45_shift[31:0];

assign crc_chksum_mask_44_shift[31:0] = {1'b0, crc_chksum_mask_44[31:1]}; 
assign crc_chksum_mask_43[31:0]       = crc_chksum_mask_44[0] ? crc_chksum_mask_44_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_44_shift[31:0];

assign crc_chksum_mask_43_shift[31:0] = {1'b0, crc_chksum_mask_43[31:1]}; 
assign crc_chksum_mask_42[31:0]       = crc_chksum_mask_43[0] ? crc_chksum_mask_43_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_43_shift[31:0];

assign crc_chksum_mask_42_shift[31:0] = {1'b0, crc_chksum_mask_42[31:1]}; 
assign crc_chksum_mask_41[31:0]       = crc_chksum_mask_42[0] ? crc_chksum_mask_42_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_42_shift[31:0];

assign crc_chksum_mask_41_shift[31:0] = {1'b0, crc_chksum_mask_41[31:1]}; 
assign crc_chksum_mask_40[31:0]       = crc_chksum_mask_41[0] ? crc_chksum_mask_41_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_41_shift[31:0];

assign crc_chksum_mask_40_shift[31:0] = {1'b0, crc_chksum_mask_40[31:1]}; 
assign crc_chksum_mask_39[31:0]       = crc_chksum_mask_40[0] ? crc_chksum_mask_40_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_40_shift[31:0];

assign crc_chksum_mask_39_shift[31:0] = {1'b0, crc_chksum_mask_39[31:1]}; 
assign crc_chksum_mask_38[31:0]       = crc_chksum_mask_39[0] ? crc_chksum_mask_39_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_39_shift[31:0];

assign crc_chksum_mask_38_shift[31:0] = {1'b0, crc_chksum_mask_38[31:1]}; 
assign crc_chksum_mask_37[31:0]       = crc_chksum_mask_38[0] ? crc_chksum_mask_38_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_38_shift[31:0];

assign crc_chksum_mask_37_shift[31:0] = {1'b0, crc_chksum_mask_37[31:1]}; 
assign crc_chksum_mask_36[31:0]       = crc_chksum_mask_37[0] ? crc_chksum_mask_37_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_37_shift[31:0];

assign crc_chksum_mask_36_shift[31:0] = {1'b0, crc_chksum_mask_36[31:1]}; 
assign crc_chksum_mask_35[31:0]       = crc_chksum_mask_36[0] ? crc_chksum_mask_36_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_36_shift[31:0];

assign crc_chksum_mask_35_shift[31:0] = {1'b0, crc_chksum_mask_35[31:1]}; 
assign crc_chksum_mask_34[31:0]       = crc_chksum_mask_35[0] ? crc_chksum_mask_35_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_35_shift[31:0];

assign crc_chksum_mask_34_shift[31:0] = {1'b0, crc_chksum_mask_34[31:1]}; 
assign crc_chksum_mask_33[31:0]       = crc_chksum_mask_34[0] ? crc_chksum_mask_34_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_34_shift[31:0];

assign crc_chksum_mask_33_shift[31:0] = {1'b0, crc_chksum_mask_33[31:1]}; 
assign crc_chksum_mask_32[31:0]       = crc_chksum_mask_33[0] ? crc_chksum_mask_33_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_33_shift[31:0];

assign crc_chksum_mask_32_shift[31:0] = {1'b0, crc_chksum_mask_32[31:1]}; 
assign crc_chksum_mask_31[31:0]       = crc_chksum_mask_32[0] ? crc_chksum_mask_32_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_32_shift[31:0];

assign crc_chksum_mask_31_shift[31:0] = {1'b0, crc_chksum_mask_31[31:1]}; 
assign crc_chksum_mask_30[31:0]       = crc_chksum_mask_31[0] ? crc_chksum_mask_31_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_31_shift[31:0];

assign crc_chksum_mask_30_shift[31:0] = {1'b0, crc_chksum_mask_30[31:1]}; 
assign crc_chksum_mask_29[31:0]       = crc_chksum_mask_30[0] ? crc_chksum_mask_30_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_30_shift[31:0];

assign crc_chksum_mask_29_shift[31:0] = {1'b0, crc_chksum_mask_29[31:1]}; 
assign crc_chksum_mask_28[31:0]       = crc_chksum_mask_29[0] ? crc_chksum_mask_29_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_29_shift[31:0];

assign crc_chksum_mask_28_shift[31:0] = {1'b0, crc_chksum_mask_28[31:1]}; 
assign crc_chksum_mask_27[31:0]       = crc_chksum_mask_28[0] ? crc_chksum_mask_28_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_28_shift[31:0];

assign crc_chksum_mask_27_shift[31:0] = {1'b0, crc_chksum_mask_27[31:1]}; 
assign crc_chksum_mask_26[31:0]       = crc_chksum_mask_27[0] ? crc_chksum_mask_27_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_27_shift[31:0];

assign crc_chksum_mask_26_shift[31:0] = {1'b0, crc_chksum_mask_26[31:1]}; 
assign crc_chksum_mask_25[31:0]       = crc_chksum_mask_26[0] ? crc_chksum_mask_26_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_26_shift[31:0];

assign crc_chksum_mask_25_shift[31:0] = {1'b0, crc_chksum_mask_25[31:1]}; 
assign crc_chksum_mask_24[31:0]       = crc_chksum_mask_25[0] ? crc_chksum_mask_25_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_25_shift[31:0];

assign crc_chksum_mask_24_shift[31:0] = {1'b0, crc_chksum_mask_24[31:1]}; 
assign crc_chksum_mask_23[31:0]       = crc_chksum_mask_24[0] ? crc_chksum_mask_24_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_24_shift[31:0];

assign crc_chksum_mask_23_shift[31:0] = {1'b0, crc_chksum_mask_23[31:1]}; 
assign crc_chksum_mask_22[31:0]       = crc_chksum_mask_23[0] ? crc_chksum_mask_23_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_23_shift[31:0];

assign crc_chksum_mask_22_shift[31:0] = {1'b0, crc_chksum_mask_22[31:1]}; 
assign crc_chksum_mask_21[31:0]       = crc_chksum_mask_22[0] ? crc_chksum_mask_22_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_22_shift[31:0];

assign crc_chksum_mask_21_shift[31:0] = {1'b0, crc_chksum_mask_21[31:1]}; 
assign crc_chksum_mask_20[31:0]       = crc_chksum_mask_21[0] ? crc_chksum_mask_21_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_21_shift[31:0];

assign crc_chksum_mask_20_shift[31:0] = {1'b0, crc_chksum_mask_20[31:1]}; 
assign crc_chksum_mask_19[31:0]       = crc_chksum_mask_20[0] ? crc_chksum_mask_20_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_20_shift[31:0];

assign crc_chksum_mask_19_shift[31:0] = {1'b0, crc_chksum_mask_19[31:1]}; 
assign crc_chksum_mask_18[31:0]       = crc_chksum_mask_19[0] ? crc_chksum_mask_19_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_19_shift[31:0];

assign crc_chksum_mask_18_shift[31:0] = {1'b0, crc_chksum_mask_18[31:1]}; 
assign crc_chksum_mask_17[31:0]       = crc_chksum_mask_18[0] ? crc_chksum_mask_18_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_18_shift[31:0];

assign crc_chksum_mask_17_shift[31:0] = {1'b0, crc_chksum_mask_17[31:1]}; 
assign crc_chksum_mask_16[31:0]       = crc_chksum_mask_17[0] ? crc_chksum_mask_17_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_17_shift[31:0];

assign crc_chksum_mask_16_shift[31:0] = {1'b0, crc_chksum_mask_16[31:1]}; 
assign crc_chksum_mask_15[31:0]       = crc_chksum_mask_16[0] ? crc_chksum_mask_16_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_16_shift[31:0];

assign crc_chksum_mask_15_shift[31:0] = {1'b0, crc_chksum_mask_15[31:1]}; 
assign crc_chksum_mask_14[31:0]       = crc_chksum_mask_15[0] ? crc_chksum_mask_15_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_15_shift[31:0];

assign crc_chksum_mask_14_shift[31:0] = {1'b0, crc_chksum_mask_14[31:1]}; 
assign crc_chksum_mask_13[31:0]       = crc_chksum_mask_14[0] ? crc_chksum_mask_14_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_14_shift[31:0];

assign crc_chksum_mask_13_shift[31:0] = {1'b0, crc_chksum_mask_13[31:1]}; 
assign crc_chksum_mask_12[31:0]       = crc_chksum_mask_13[0] ? crc_chksum_mask_13_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_13_shift[31:0];

assign crc_chksum_mask_12_shift[31:0] = {1'b0, crc_chksum_mask_12[31:1]}; 
assign crc_chksum_mask_11[31:0]       = crc_chksum_mask_12[0] ? crc_chksum_mask_12_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_12_shift[31:0];

assign crc_chksum_mask_11_shift[31:0] = {1'b0, crc_chksum_mask_11[31:1]}; 
assign crc_chksum_mask_10[31:0]       = crc_chksum_mask_11[0] ? crc_chksum_mask_11_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_11_shift[31:0];

assign crc_chksum_mask_10_shift[31:0] = {1'b0, crc_chksum_mask_10[31:1]}; 
assign crc_chksum_mask_9[31:0]       = crc_chksum_mask_10[0] ? crc_chksum_mask_10_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_10_shift[31:0];

assign crc_chksum_mask_9_shift[31:0] = {1'b0, crc_chksum_mask_9[31:1]}; 
assign crc_chksum_mask_8[31:0]       = crc_chksum_mask_9[0] ? crc_chksum_mask_9_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_9_shift[31:0];

assign crc_chksum_mask_8_shift[31:0] = {1'b0, crc_chksum_mask_8[31:1]}; 
assign crc_chksum_mask_7[31:0]       = crc_chksum_mask_8[0] ? crc_chksum_mask_8_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_8_shift[31:0];

assign crc_chksum_mask_7_shift[31:0] = {1'b0, crc_chksum_mask_7[31:1]}; 
assign crc_chksum_mask_6[31:0]       = crc_chksum_mask_7[0] ? crc_chksum_mask_7_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_7_shift[31:0];

assign crc_chksum_mask_6_shift[31:0] = {1'b0, crc_chksum_mask_6[31:1]}; 
assign crc_chksum_mask_5[31:0]       = crc_chksum_mask_6[0] ? crc_chksum_mask_6_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_6_shift[31:0];

assign crc_chksum_mask_5_shift[31:0] = {1'b0, crc_chksum_mask_5[31:1]}; 
assign crc_chksum_mask_4[31:0]       = crc_chksum_mask_5[0] ? crc_chksum_mask_5_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_5_shift[31:0];

assign crc_chksum_mask_4_shift[31:0] = {1'b0, crc_chksum_mask_4[31:1]}; 
assign crc_chksum_mask_3[31:0]       = crc_chksum_mask_4[0] ? crc_chksum_mask_4_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_4_shift[31:0];

assign crc_chksum_mask_3_shift[31:0] = {1'b0, crc_chksum_mask_3[31:1]}; 
assign crc_chksum_mask_2[31:0]       = crc_chksum_mask_3[0] ? crc_chksum_mask_3_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_3_shift[31:0];

assign crc_chksum_mask_2_shift[31:0] = {1'b0, crc_chksum_mask_2[31:1]}; 
assign crc_chksum_mask_1[31:0]       = crc_chksum_mask_2[0] ? crc_chksum_mask_2_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_2_shift[31:0];

assign crc_chksum_mask_1_shift[31:0] = {1'b0, crc_chksum_mask_1[31:1]}; 
assign crc_chksum_mask_0[31:0]       = crc_chksum_mask_1[0] ? crc_chksum_mask_1_shift[31:0] ^ crc_poly[31:0] : crc_chksum_mask_1_shift[31:0];



assign crc_check_sum[63:0] = {{32{crc_chksum_mask_0[31]}}, crc_chksum_mask_0[31:0]};


endmodule




module ct_iu_crc_v2 (
	input    wire  [63:0]  crc_a,
	input    wire  [63:0]  crc_msg,
	input    wire  [31:0]  crc_poly,
	input    wire  [ 1:0]  crc_type,
	output   wire  [63:0]  crc_check_sum
);

wire [1 :0] size_type;

wire [31:0] crc_mask_63;
wire [31:0] crc_mask_63_shift;
wire [31:0] crc_mask_62;
wire [31:0] crc_mask_62_shift;
wire [31:0] crc_mask_61;
wire [31:0] crc_mask_61_shift;
wire [31:0] crc_mask_60;
wire [31:0] crc_mask_60_shift;
wire [31:0] crc_mask_59;
wire [31:0] crc_mask_59_shift;
wire [31:0] crc_mask_58;
wire [31:0] crc_mask_58_shift;
wire [31:0] crc_mask_57;
wire [31:0] crc_mask_57_shift;
wire [31:0] crc_mask_56;
wire [31:0] crc_mask_56_shift;
wire [31:0] crc_mask_55;
wire [31:0] crc_mask_55_shift;
wire [31:0] crc_mask_54;
wire [31:0] crc_mask_54_shift;
wire [31:0] crc_mask_53;
wire [31:0] crc_mask_53_shift;
wire [31:0] crc_mask_52;
wire [31:0] crc_mask_52_shift;
wire [31:0] crc_mask_51;
wire [31:0] crc_mask_51_shift;
wire [31:0] crc_mask_50;
wire [31:0] crc_mask_50_shift;
wire [31:0] crc_mask_49;
wire [31:0] crc_mask_49_shift;
wire [31:0] crc_mask_48;
wire [31:0] crc_mask_48_shift;
wire [31:0] crc_mask_47;
wire [31:0] crc_mask_47_shift;
wire [31:0] crc_mask_46;
wire [31:0] crc_mask_46_shift;
wire [31:0] crc_mask_45;
wire [31:0] crc_mask_45_shift;
wire [31:0] crc_mask_44;
wire [31:0] crc_mask_44_shift;
wire [31:0] crc_mask_43;
wire [31:0] crc_mask_43_shift;
wire [31:0] crc_mask_42;
wire [31:0] crc_mask_42_shift;
wire [31:0] crc_mask_41;
wire [31:0] crc_mask_41_shift;
wire [31:0] crc_mask_40;
wire [31:0] crc_mask_40_shift;
wire [31:0] crc_mask_39;
wire [31:0] crc_mask_39_shift;
wire [31:0] crc_mask_38;
wire [31:0] crc_mask_38_shift;
wire [31:0] crc_mask_37;
wire [31:0] crc_mask_37_shift;
wire [31:0] crc_mask_36;
wire [31:0] crc_mask_36_shift;
wire [31:0] crc_mask_35;
wire [31:0] crc_mask_35_shift;
wire [31:0] crc_mask_34;
wire [31:0] crc_mask_34_shift;
wire [31:0] crc_mask_33;
wire [31:0] crc_mask_33_shift;
wire [31:0] crc_mask_32;
wire [31:0] crc_mask_32_shift;
wire [31:0] crc_mask_31;
wire [31:0] crc_mask_31_shift;
wire [31:0] crc_mask_30;
wire [31:0] crc_mask_30_shift;
wire [31:0] crc_mask_29;
wire [31:0] crc_mask_29_shift;
wire [31:0] crc_mask_28;
wire [31:0] crc_mask_28_shift;
wire [31:0] crc_mask_27;
wire [31:0] crc_mask_27_shift;
wire [31:0] crc_mask_26;
wire [31:0] crc_mask_26_shift;
wire [31:0] crc_mask_25;
wire [31:0] crc_mask_25_shift;
wire [31:0] crc_mask_24;
wire [31:0] crc_mask_24_shift;
wire [31:0] crc_mask_23;
wire [31:0] crc_mask_23_shift;
wire [31:0] crc_mask_22;
wire [31:0] crc_mask_22_shift;
wire [31:0] crc_mask_21;
wire [31:0] crc_mask_21_shift;
wire [31:0] crc_mask_20;
wire [31:0] crc_mask_20_shift;
wire [31:0] crc_mask_19;
wire [31:0] crc_mask_19_shift;
wire [31:0] crc_mask_18;
wire [31:0] crc_mask_18_shift;
wire [31:0] crc_mask_17;
wire [31:0] crc_mask_17_shift;
wire [31:0] crc_mask_16;
wire [31:0] crc_mask_16_shift;
wire [31:0] crc_mask_15;
wire [31:0] crc_mask_15_shift;
wire [31:0] crc_mask_14;
wire [31:0] crc_mask_14_shift;
wire [31:0] crc_mask_13;
wire [31:0] crc_mask_13_shift;
wire [31:0] crc_mask_12;
wire [31:0] crc_mask_12_shift;
wire [31:0] crc_mask_11;
wire [31:0] crc_mask_11_shift;
wire [31:0] crc_mask_10;
wire [31:0] crc_mask_10_shift;
wire [31:0] crc_mask_9;
wire [31:0] crc_mask_9_shift;
wire [31:0] crc_mask_8;
wire [31:0] crc_mask_8_shift;
wire [31:0] crc_mask_7;
wire [31:0] crc_mask_7_shift;
wire [31:0] crc_mask_6;
wire [31:0] crc_mask_6_shift;
wire [31:0] crc_mask_5;
wire [31:0] crc_mask_5_shift;
wire [31:0] crc_mask_4;
wire [31:0] crc_mask_4_shift;
wire [31:0] crc_mask_3;
wire [31:0] crc_mask_3_shift;
wire [31:0] crc_mask_2;
wire [31:0] crc_mask_2_shift;
wire [31:0] crc_mask_1;
wire [31:0] crc_mask_1_shift;
wire [31:0] crc_mask_0;

wire [31:0] cond_value;
wire [31:0] select_value;
wire [31:0] select_value_0;
wire [31:0] select_value_1;
wire [31:0] select_value_2;
wire [31:0] select_value_3;
wire [31:0] select_value_4;
wire [31:0] select_value_5;
wire [31:0] select_value_6;
wire [31:0] select_value_7;
wire [31:0] select_value_8;
wire [31:0] select_value_9;
wire [31:0] select_value_10;
wire [31:0] select_value_11;
wire [31:0] select_value_12;
wire [31:0] select_value_13;
wire [31:0] select_value_14;
wire [31:0] select_value_15;
wire [31:0] select_value_16;
wire [31:0] select_value_17;
wire [31:0] select_value_18;
wire [31:0] select_value_19;
wire [31:0] select_value_20;
wire [31:0] select_value_21;
wire [31:0] select_value_22;
wire [31:0] select_value_23;
wire [31:0] select_value_24;
wire [31:0] select_value_25;
wire [31:0] select_value_26;
wire [31:0] select_value_27;
wire [31:0] select_value_28;
wire [31:0] select_value_29;
wire [31:0] select_value_30;
wire [31:0] select_value_31;
wire [31:0] select_value_32;
wire [31:0] select_value_33;
wire [31:0] select_value_34;
wire [31:0] select_value_35;
wire [31:0] select_value_36;
wire [31:0] select_value_37;
wire [31:0] select_value_38;
wire [31:0] select_value_39;
wire [31:0] select_value_40;
wire [31:0] select_value_41;
wire [31:0] select_value_42;
wire [31:0] select_value_43;
wire [31:0] select_value_44;
wire [31:0] select_value_45;
wire [31:0] select_value_46;
wire [31:0] select_value_47;
wire [31:0] select_value_48;
wire [31:0] select_value_49;
wire [31:0] select_value_50;
wire [31:0] select_value_51;
wire [31:0] select_value_52;
wire [31:0] select_value_53;
wire [31:0] select_value_54;
wire [31:0] select_value_55;
wire [31:0] select_value_56;
wire [31:0] select_value_57;
wire [31:0] select_value_58;
wire [31:0] select_value_59;
wire [31:0] select_value_60;
wire [31:0] select_value_61;
wire [31:0] select_value_62;
wire [31:0] select_value_63;


// assign crc_poly[31:0] = 32'hedb88320;

// assign crc_poly2[31:0] = 32'h82f63b78;

assign crc_mask_63[31:0] = crc_poly[31:0];

assign crc_mask_63_shift[31:0] = {1'b0, crc_mask_63[31:1]}; 
assign crc_mask_62[31:0]       = crc_mask_63[0] ? crc_mask_63_shift[31:0] ^ crc_poly[31:0] : crc_mask_63_shift[31:0];

assign crc_mask_62_shift[31:0] = {1'b0, crc_mask_62[31:1]}; 
assign crc_mask_61[31:0]       = crc_mask_62[0] ? crc_mask_62_shift[31:0] ^ crc_poly[31:0] : crc_mask_62_shift[31:0];

assign crc_mask_61_shift[31:0] = {1'b0, crc_mask_61[31:1]}; 
assign crc_mask_60[31:0]       = crc_mask_61[0] ? crc_mask_61_shift[31:0] ^ crc_poly[31:0] : crc_mask_61_shift[31:0];

assign crc_mask_60_shift[31:0] = {1'b0, crc_mask_60[31:1]}; 
assign crc_mask_59[31:0]       = crc_mask_60[0] ? crc_mask_60_shift[31:0] ^ crc_poly[31:0] : crc_mask_60_shift[31:0];

assign crc_mask_59_shift[31:0] = {1'b0, crc_mask_59[31:1]}; 
assign crc_mask_58[31:0]       = crc_mask_59[0] ? crc_mask_59_shift[31:0] ^ crc_poly[31:0] : crc_mask_59_shift[31:0];

assign crc_mask_58_shift[31:0] = {1'b0, crc_mask_58[31:1]}; 
assign crc_mask_57[31:0]       = crc_mask_58[0] ? crc_mask_58_shift[31:0] ^ crc_poly[31:0] : crc_mask_58_shift[31:0];

assign crc_mask_57_shift[31:0] = {1'b0, crc_mask_57[31:1]}; 
assign crc_mask_56[31:0]       = crc_mask_57[0] ? crc_mask_57_shift[31:0] ^ crc_poly[31:0] : crc_mask_57_shift[31:0];

assign crc_mask_56_shift[31:0] = {1'b0, crc_mask_56[31:1]}; 
assign crc_mask_55[31:0]       = crc_mask_56[0] ? crc_mask_56_shift[31:0] ^ crc_poly[31:0] : crc_mask_56_shift[31:0];

assign crc_mask_55_shift[31:0] = {1'b0, crc_mask_55[31:1]}; 
assign crc_mask_54[31:0]       = crc_mask_55[0] ? crc_mask_55_shift[31:0] ^ crc_poly[31:0] : crc_mask_55_shift[31:0];

assign crc_mask_54_shift[31:0] = {1'b0, crc_mask_54[31:1]}; 
assign crc_mask_53[31:0]       = crc_mask_54[0] ? crc_mask_54_shift[31:0] ^ crc_poly[31:0] : crc_mask_54_shift[31:0];

assign crc_mask_53_shift[31:0] = {1'b0, crc_mask_53[31:1]}; 
assign crc_mask_52[31:0]       = crc_mask_53[0] ? crc_mask_53_shift[31:0] ^ crc_poly[31:0] : crc_mask_53_shift[31:0];

assign crc_mask_52_shift[31:0] = {1'b0, crc_mask_52[31:1]}; 
assign crc_mask_51[31:0]       = crc_mask_52[0] ? crc_mask_52_shift[31:0] ^ crc_poly[31:0] : crc_mask_52_shift[31:0];

assign crc_mask_51_shift[31:0] = {1'b0, crc_mask_51[31:1]}; 
assign crc_mask_50[31:0]       = crc_mask_51[0] ? crc_mask_51_shift[31:0] ^ crc_poly[31:0] : crc_mask_51_shift[31:0];

assign crc_mask_50_shift[31:0] = {1'b0, crc_mask_50[31:1]}; 
assign crc_mask_49[31:0]       = crc_mask_50[0] ? crc_mask_50_shift[31:0] ^ crc_poly[31:0] : crc_mask_50_shift[31:0];

assign crc_mask_49_shift[31:0] = {1'b0, crc_mask_49[31:1]}; 
assign crc_mask_48[31:0]       = crc_mask_49[0] ? crc_mask_49_shift[31:0] ^ crc_poly[31:0] : crc_mask_49_shift[31:0];

assign crc_mask_48_shift[31:0] = {1'b0, crc_mask_48[31:1]}; 
assign crc_mask_47[31:0]       = crc_mask_48[0] ? crc_mask_48_shift[31:0] ^ crc_poly[31:0] : crc_mask_48_shift[31:0];

assign crc_mask_47_shift[31:0] = {1'b0, crc_mask_47[31:1]}; 
assign crc_mask_46[31:0]       = crc_mask_47[0] ? crc_mask_47_shift[31:0] ^ crc_poly[31:0] : crc_mask_47_shift[31:0];

assign crc_mask_46_shift[31:0] = {1'b0, crc_mask_46[31:1]}; 
assign crc_mask_45[31:0]       = crc_mask_46[0] ? crc_mask_46_shift[31:0] ^ crc_poly[31:0] : crc_mask_46_shift[31:0];

assign crc_mask_45_shift[31:0] = {1'b0, crc_mask_45[31:1]}; 
assign crc_mask_44[31:0]       = crc_mask_45[0] ? crc_mask_45_shift[31:0] ^ crc_poly[31:0] : crc_mask_45_shift[31:0];

assign crc_mask_44_shift[31:0] = {1'b0, crc_mask_44[31:1]}; 
assign crc_mask_43[31:0]       = crc_mask_44[0] ? crc_mask_44_shift[31:0] ^ crc_poly[31:0] : crc_mask_44_shift[31:0];

assign crc_mask_43_shift[31:0] = {1'b0, crc_mask_43[31:1]}; 
assign crc_mask_42[31:0]       = crc_mask_43[0] ? crc_mask_43_shift[31:0] ^ crc_poly[31:0] : crc_mask_43_shift[31:0];

assign crc_mask_42_shift[31:0] = {1'b0, crc_mask_42[31:1]}; 
assign crc_mask_41[31:0]       = crc_mask_42[0] ? crc_mask_42_shift[31:0] ^ crc_poly[31:0] : crc_mask_42_shift[31:0];

assign crc_mask_41_shift[31:0] = {1'b0, crc_mask_41[31:1]}; 
assign crc_mask_40[31:0]       = crc_mask_41[0] ? crc_mask_41_shift[31:0] ^ crc_poly[31:0] : crc_mask_41_shift[31:0];

assign crc_mask_40_shift[31:0] = {1'b0, crc_mask_40[31:1]}; 
assign crc_mask_39[31:0]       = crc_mask_40[0] ? crc_mask_40_shift[31:0] ^ crc_poly[31:0] : crc_mask_40_shift[31:0];

assign crc_mask_39_shift[31:0] = {1'b0, crc_mask_39[31:1]}; 
assign crc_mask_38[31:0]       = crc_mask_39[0] ? crc_mask_39_shift[31:0] ^ crc_poly[31:0] : crc_mask_39_shift[31:0];

assign crc_mask_38_shift[31:0] = {1'b0, crc_mask_38[31:1]}; 
assign crc_mask_37[31:0]       = crc_mask_38[0] ? crc_mask_38_shift[31:0] ^ crc_poly[31:0] : crc_mask_38_shift[31:0];

assign crc_mask_37_shift[31:0] = {1'b0, crc_mask_37[31:1]}; 
assign crc_mask_36[31:0]       = crc_mask_37[0] ? crc_mask_37_shift[31:0] ^ crc_poly[31:0] : crc_mask_37_shift[31:0];

assign crc_mask_36_shift[31:0] = {1'b0, crc_mask_36[31:1]}; 
assign crc_mask_35[31:0]       = crc_mask_36[0] ? crc_mask_36_shift[31:0] ^ crc_poly[31:0] : crc_mask_36_shift[31:0];

assign crc_mask_35_shift[31:0] = {1'b0, crc_mask_35[31:1]}; 
assign crc_mask_34[31:0]       = crc_mask_35[0] ? crc_mask_35_shift[31:0] ^ crc_poly[31:0] : crc_mask_35_shift[31:0];

assign crc_mask_34_shift[31:0] = {1'b0, crc_mask_34[31:1]}; 
assign crc_mask_33[31:0]       = crc_mask_34[0] ? crc_mask_34_shift[31:0] ^ crc_poly[31:0] : crc_mask_34_shift[31:0];

assign crc_mask_33_shift[31:0] = {1'b0, crc_mask_33[31:1]}; 
assign crc_mask_32[31:0]       = crc_mask_33[0] ? crc_mask_33_shift[31:0] ^ crc_poly[31:0] : crc_mask_33_shift[31:0];

assign crc_mask_32_shift[31:0] = {1'b0, crc_mask_32[31:1]}; 
assign crc_mask_31[31:0]       = crc_mask_32[0] ? crc_mask_32_shift[31:0] ^ crc_poly[31:0] : crc_mask_32_shift[31:0];

assign crc_mask_31_shift[31:0] = {1'b0, crc_mask_31[31:1]}; 
assign crc_mask_30[31:0]       = crc_mask_31[0] ? crc_mask_31_shift[31:0] ^ crc_poly[31:0] : crc_mask_31_shift[31:0];

assign crc_mask_30_shift[31:0] = {1'b0, crc_mask_30[31:1]}; 
assign crc_mask_29[31:0]       = crc_mask_30[0] ? crc_mask_30_shift[31:0] ^ crc_poly[31:0] : crc_mask_30_shift[31:0];

assign crc_mask_29_shift[31:0] = {1'b0, crc_mask_29[31:1]}; 
assign crc_mask_28[31:0]       = crc_mask_29[0] ? crc_mask_29_shift[31:0] ^ crc_poly[31:0] : crc_mask_29_shift[31:0];

assign crc_mask_28_shift[31:0] = {1'b0, crc_mask_28[31:1]}; 
assign crc_mask_27[31:0]       = crc_mask_28[0] ? crc_mask_28_shift[31:0] ^ crc_poly[31:0] : crc_mask_28_shift[31:0];

assign crc_mask_27_shift[31:0] = {1'b0, crc_mask_27[31:1]}; 
assign crc_mask_26[31:0]       = crc_mask_27[0] ? crc_mask_27_shift[31:0] ^ crc_poly[31:0] : crc_mask_27_shift[31:0];

assign crc_mask_26_shift[31:0] = {1'b0, crc_mask_26[31:1]}; 
assign crc_mask_25[31:0]       = crc_mask_26[0] ? crc_mask_26_shift[31:0] ^ crc_poly[31:0] : crc_mask_26_shift[31:0];

assign crc_mask_25_shift[31:0] = {1'b0, crc_mask_25[31:1]}; 
assign crc_mask_24[31:0]       = crc_mask_25[0] ? crc_mask_25_shift[31:0] ^ crc_poly[31:0] : crc_mask_25_shift[31:0];

assign crc_mask_24_shift[31:0] = {1'b0, crc_mask_24[31:1]}; 
assign crc_mask_23[31:0]       = crc_mask_24[0] ? crc_mask_24_shift[31:0] ^ crc_poly[31:0] : crc_mask_24_shift[31:0];

assign crc_mask_23_shift[31:0] = {1'b0, crc_mask_23[31:1]}; 
assign crc_mask_22[31:0]       = crc_mask_23[0] ? crc_mask_23_shift[31:0] ^ crc_poly[31:0] : crc_mask_23_shift[31:0];

assign crc_mask_22_shift[31:0] = {1'b0, crc_mask_22[31:1]}; 
assign crc_mask_21[31:0]       = crc_mask_22[0] ? crc_mask_22_shift[31:0] ^ crc_poly[31:0] : crc_mask_22_shift[31:0];

assign crc_mask_21_shift[31:0] = {1'b0, crc_mask_21[31:1]}; 
assign crc_mask_20[31:0]       = crc_mask_21[0] ? crc_mask_21_shift[31:0] ^ crc_poly[31:0] : crc_mask_21_shift[31:0];

assign crc_mask_20_shift[31:0] = {1'b0, crc_mask_20[31:1]}; 
assign crc_mask_19[31:0]       = crc_mask_20[0] ? crc_mask_20_shift[31:0] ^ crc_poly[31:0] : crc_mask_20_shift[31:0];

assign crc_mask_19_shift[31:0] = {1'b0, crc_mask_19[31:1]}; 
assign crc_mask_18[31:0]       = crc_mask_19[0] ? crc_mask_19_shift[31:0] ^ crc_poly[31:0] : crc_mask_19_shift[31:0];

assign crc_mask_18_shift[31:0] = {1'b0, crc_mask_18[31:1]}; 
assign crc_mask_17[31:0]       = crc_mask_18[0] ? crc_mask_18_shift[31:0] ^ crc_poly[31:0] : crc_mask_18_shift[31:0];

assign crc_mask_17_shift[31:0] = {1'b0, crc_mask_17[31:1]}; 
assign crc_mask_16[31:0]       = crc_mask_17[0] ? crc_mask_17_shift[31:0] ^ crc_poly[31:0] : crc_mask_17_shift[31:0];

assign crc_mask_16_shift[31:0] = {1'b0, crc_mask_16[31:1]}; 
assign crc_mask_15[31:0]       = crc_mask_16[0] ? crc_mask_16_shift[31:0] ^ crc_poly[31:0] : crc_mask_16_shift[31:0];

assign crc_mask_15_shift[31:0] = {1'b0, crc_mask_15[31:1]}; 
assign crc_mask_14[31:0]       = crc_mask_15[0] ? crc_mask_15_shift[31:0] ^ crc_poly[31:0] : crc_mask_15_shift[31:0];

assign crc_mask_14_shift[31:0] = {1'b0, crc_mask_14[31:1]}; 
assign crc_mask_13[31:0]       = crc_mask_14[0] ? crc_mask_14_shift[31:0] ^ crc_poly[31:0] : crc_mask_14_shift[31:0];

assign crc_mask_13_shift[31:0] = {1'b0, crc_mask_13[31:1]}; 
assign crc_mask_12[31:0]       = crc_mask_13[0] ? crc_mask_13_shift[31:0] ^ crc_poly[31:0] : crc_mask_13_shift[31:0];

assign crc_mask_12_shift[31:0] = {1'b0, crc_mask_12[31:1]}; 
assign crc_mask_11[31:0]       = crc_mask_12[0] ? crc_mask_12_shift[31:0] ^ crc_poly[31:0] : crc_mask_12_shift[31:0];

assign crc_mask_11_shift[31:0] = {1'b0, crc_mask_11[31:1]}; 
assign crc_mask_10[31:0]       = crc_mask_11[0] ? crc_mask_11_shift[31:0] ^ crc_poly[31:0] : crc_mask_11_shift[31:0];

assign crc_mask_10_shift[31:0] = {1'b0, crc_mask_10[31:1]}; 
assign crc_mask_9[31:0]       = crc_mask_10[0] ? crc_mask_10_shift[31:0] ^ crc_poly[31:0] : crc_mask_10_shift[31:0];

assign crc_mask_9_shift[31:0] = {1'b0, crc_mask_9[31:1]}; 
assign crc_mask_8[31:0]       = crc_mask_9[0] ? crc_mask_9_shift[31:0] ^ crc_poly[31:0] : crc_mask_9_shift[31:0];

assign crc_mask_8_shift[31:0] = {1'b0, crc_mask_8[31:1]}; 
assign crc_mask_7[31:0]       = crc_mask_8[0] ? crc_mask_8_shift[31:0] ^ crc_poly[31:0] : crc_mask_8_shift[31:0];

assign crc_mask_7_shift[31:0] = {1'b0, crc_mask_7[31:1]}; 
assign crc_mask_6[31:0]       = crc_mask_7[0] ? crc_mask_7_shift[31:0] ^ crc_poly[31:0] : crc_mask_7_shift[31:0];

assign crc_mask_6_shift[31:0] = {1'b0, crc_mask_6[31:1]}; 
assign crc_mask_5[31:0]       = crc_mask_6[0] ? crc_mask_6_shift[31:0] ^ crc_poly[31:0] : crc_mask_6_shift[31:0];

assign crc_mask_5_shift[31:0] = {1'b0, crc_mask_5[31:1]}; 
assign crc_mask_4[31:0]       = crc_mask_5[0] ? crc_mask_5_shift[31:0] ^ crc_poly[31:0] : crc_mask_5_shift[31:0];

assign crc_mask_4_shift[31:0] = {1'b0, crc_mask_4[31:1]}; 
assign crc_mask_3[31:0]       = crc_mask_4[0] ? crc_mask_4_shift[31:0] ^ crc_poly[31:0] : crc_mask_4_shift[31:0];

assign crc_mask_3_shift[31:0] = {1'b0, crc_mask_3[31:1]}; 
assign crc_mask_2[31:0]       = crc_mask_3[0] ? crc_mask_3_shift[31:0] ^ crc_poly[31:0] : crc_mask_3_shift[31:0];

assign crc_mask_2_shift[31:0] = {1'b0, crc_mask_2[31:1]}; 
assign crc_mask_1[31:0]       = crc_mask_2[0] ? crc_mask_2_shift[31:0] ^ crc_poly[31:0] : crc_mask_2_shift[31:0];

assign crc_mask_1_shift[31:0] = {1'b0, crc_mask_1[31:1]}; 
assign crc_mask_0[31:0]       = crc_mask_1[0] ? crc_mask_1_shift[31:0] ^ crc_poly[31:0] : crc_mask_1_shift[31:0];



assign size_type_b = size_type[1:0] == 2'b00;
assign size_type_h = size_type[1:0] == 2'b01;
assign size_type_w = size_type[1:0] == 2'b10;
assign size_type_d = size_type[1:0] == 2'b11;

assign cond_value[63:0] =  {64{size_type_b}} & {{32'b0, crc_a[31:0]} ^ {56'b0, crc_msg[7 :0]}}
                         | {64{size_type_h}} & {{32'b0, crc_a[31:0]} ^ {48'b0, crc_msg[15:0]}}  
                         | {64{size_type_w}} & {{32'b0, crc_a[31:0]} ^ {32'b0, crc_msg[31:0]}}  
                         | {64{size_type_d}} & {{32'b0, crc_a[31:0]} ^ {       crc_msg[63:0]}};  

assign select_value_63[31:0] = cond_value[63] ? crc_mask_63[31:0] : 32'b0;
assign select_value_62[31:0] = cond_value[62] ? crc_mask_62[31:0] : 32'b0;
assign select_value_61[31:0] = cond_value[61] ? crc_mask_61[31:0] : 32'b0;
assign select_value_60[31:0] = cond_value[60] ? crc_mask_60[31:0] : 32'b0;
assign select_value_59[31:0] = cond_value[59] ? crc_mask_59[31:0] : 32'b0;
assign select_value_58[31:0] = cond_value[58] ? crc_mask_58[31:0] : 32'b0;
assign select_value_57[31:0] = cond_value[57] ? crc_mask_57[31:0] : 32'b0;
assign select_value_56[31:0] = cond_value[56] ? crc_mask_56[31:0] : 32'b0;
assign select_value_55[31:0] = cond_value[55] ? crc_mask_55[31:0] : 32'b0;
assign select_value_54[31:0] = cond_value[54] ? crc_mask_54[31:0] : 32'b0;
assign select_value_53[31:0] = cond_value[53] ? crc_mask_53[31:0] : 32'b0;
assign select_value_52[31:0] = cond_value[52] ? crc_mask_52[31:0] : 32'b0;
assign select_value_51[31:0] = cond_value[51] ? crc_mask_51[31:0] : 32'b0;
assign select_value_50[31:0] = cond_value[50] ? crc_mask_50[31:0] : 32'b0;
assign select_value_49[31:0] = cond_value[49] ? crc_mask_49[31:0] : 32'b0;
assign select_value_48[31:0] = cond_value[48] ? crc_mask_48[31:0] : 32'b0;
assign select_value_47[31:0] = cond_value[47] ? crc_mask_47[31:0] : 32'b0;
assign select_value_46[31:0] = cond_value[46] ? crc_mask_46[31:0] : 32'b0;
assign select_value_45[31:0] = cond_value[45] ? crc_mask_45[31:0] : 32'b0;
assign select_value_44[31:0] = cond_value[44] ? crc_mask_44[31:0] : 32'b0;
assign select_value_43[31:0] = cond_value[43] ? crc_mask_43[31:0] : 32'b0;
assign select_value_42[31:0] = cond_value[42] ? crc_mask_42[31:0] : 32'b0;
assign select_value_41[31:0] = cond_value[41] ? crc_mask_41[31:0] : 32'b0;
assign select_value_40[31:0] = cond_value[40] ? crc_mask_40[31:0] : 32'b0;
assign select_value_39[31:0] = cond_value[39] ? crc_mask_39[31:0] : 32'b0;
assign select_value_38[31:0] = cond_value[38] ? crc_mask_38[31:0] : 32'b0;
assign select_value_37[31:0] = cond_value[37] ? crc_mask_37[31:0] : 32'b0;
assign select_value_36[31:0] = cond_value[36] ? crc_mask_36[31:0] : 32'b0;
assign select_value_35[31:0] = cond_value[35] ? crc_mask_35[31:0] : 32'b0;
assign select_value_34[31:0] = cond_value[34] ? crc_mask_34[31:0] : 32'b0;
assign select_value_33[31:0] = cond_value[33] ? crc_mask_33[31:0] : 32'b0;
assign select_value_32[31:0] = cond_value[32] ? crc_mask_32[31:0] : 32'b0;
assign select_value_31[31:0] = cond_value[31] ? crc_mask_31[31:0] : 32'b0;
assign select_value_30[31:0] = cond_value[30] ? crc_mask_30[31:0] : 32'b0;
assign select_value_29[31:0] = cond_value[29] ? crc_mask_29[31:0] : 32'b0;
assign select_value_28[31:0] = cond_value[28] ? crc_mask_28[31:0] : 32'b0;
assign select_value_27[31:0] = cond_value[27] ? crc_mask_27[31:0] : 32'b0;
assign select_value_26[31:0] = cond_value[26] ? crc_mask_26[31:0] : 32'b0;
assign select_value_25[31:0] = cond_value[25] ? crc_mask_25[31:0] : 32'b0;
assign select_value_24[31:0] = cond_value[24] ? crc_mask_24[31:0] : 32'b0;
assign select_value_23[31:0] = cond_value[23] ? crc_mask_23[31:0] : 32'b0;
assign select_value_22[31:0] = cond_value[22] ? crc_mask_22[31:0] : 32'b0;
assign select_value_21[31:0] = cond_value[21] ? crc_mask_21[31:0] : 32'b0;
assign select_value_20[31:0] = cond_value[20] ? crc_mask_20[31:0] : 32'b0;
assign select_value_19[31:0] = cond_value[19] ? crc_mask_19[31:0] : 32'b0;
assign select_value_18[31:0] = cond_value[18] ? crc_mask_18[31:0] : 32'b0;
assign select_value_17[31:0] = cond_value[17] ? crc_mask_17[31:0] : 32'b0;
assign select_value_16[31:0] = cond_value[16] ? crc_mask_16[31:0] : 32'b0;
assign select_value_15[31:0] = cond_value[15] ? crc_mask_15[31:0] : 32'b0;
assign select_value_14[31:0] = cond_value[14] ? crc_mask_14[31:0] : 32'b0;
assign select_value_13[31:0] = cond_value[13] ? crc_mask_13[31:0] : 32'b0;
assign select_value_12[31:0] = cond_value[12] ? crc_mask_12[31:0] : 32'b0;
assign select_value_11[31:0] = cond_value[11] ? crc_mask_11[31:0] : 32'b0;
assign select_value_10[31:0] = cond_value[10] ? crc_mask_10[31:0] : 32'b0;
assign select_value_9[31:0]  = cond_value[9]  ? crc_mask_9[31:0]  : 32'b0;
assign select_value_8[31:0]  = cond_value[8]  ? crc_mask_8[31:0]  : 32'b0;
assign select_value_7[31:0]  = cond_value[7]  ? crc_mask_7[31:0]  : 32'b0;
assign select_value_6[31:0]  = cond_value[6]  ? crc_mask_6[31:0]  : 32'b0;
assign select_value_5[31:0]  = cond_value[5]  ? crc_mask_5[31:0]  : 32'b0;
assign select_value_4[31:0]  = cond_value[4]  ? crc_mask_4[31:0]  : 32'b0;
assign select_value_3[31:0]  = cond_value[3]  ? crc_mask_3[31:0]  : 32'b0;
assign select_value_2[31:0]  = cond_value[2]  ? crc_mask_2[31:0]  : 32'b0;
assign select_value_1[31:0]  = cond_value[1]  ? crc_mask_1[31:0]  : 32'b0;
assign select_value_0[31:0]  = cond_value[0]  ? crc_mask_0[31:0]  : 32'b0;

assign select_value[31:0] =  select_value_0[31:0]
                          ^ select_value_1[31:0]
                          ^ select_value_2[31:0]
                          ^ select_value_3[31:0]
                          ^ select_value_4[31:0]
                          ^ select_value_5[31:0]
                          ^ select_value_6[31:0]
                          ^ select_value_7[31:0]
                          ^ select_value_8[31:0]
                          ^ select_value_9[31:0]
                          ^ select_value_10[31:0]
                          ^ select_value_11[31:0]
                          ^ select_value_12[31:0]
                          ^ select_value_13[31:0]
                          ^ select_value_14[31:0]
                          ^ select_value_15[31:0]
                          ^ select_value_16[31:0]
                          ^ select_value_17[31:0]
                          ^ select_value_18[31:0]
                          ^ select_value_19[31:0]
                          ^ select_value_20[31:0]
                          ^ select_value_21[31:0]
                          ^ select_value_22[31:0]
                          ^ select_value_23[31:0]
                          ^ select_value_24[31:0]
                          ^ select_value_25[31:0]
                          ^ select_value_26[31:0]
                          ^ select_value_27[31:0]
                          ^ select_value_28[31:0]
                          ^ select_value_29[31:0]
                          ^ select_value_30[31:0]
                          ^ select_value_31[31:0]
                          ^ select_value_32[31:0]
                          ^ select_value_33[31:0]
                          ^ select_value_34[31:0]
                          ^ select_value_35[31:0]
                          ^ select_value_36[31:0]
                          ^ select_value_37[31:0]
                          ^ select_value_38[31:0]
                          ^ select_value_39[31:0]
                          ^ select_value_40[31:0]
                          ^ select_value_41[31:0]
                          ^ select_value_42[31:0]
                          ^ select_value_43[31:0]
                          ^ select_value_44[31:0]
                          ^ select_value_45[31:0]
                          ^ select_value_46[31:0]
                          ^ select_value_47[31:0]
                          ^ select_value_48[31:0]
                          ^ select_value_49[31:0]
                          ^ select_value_50[31:0]
                          ^ select_value_51[31:0]
                          ^ select_value_52[31:0]
                          ^ select_value_53[31:0]
                          ^ select_value_54[31:0]
                          ^ select_value_55[31:0]
                          ^ select_value_56[31:0]
                          ^ select_value_57[31:0]
                          ^ select_value_58[31:0]
                          ^ select_value_59[31:0]
                          ^ select_value_60[31:0]
                          ^ select_value_61[31:0]
                          ^ select_value_62[31:0]
                          ^ 32'h00000020;

assign crc_check_sum[63:0] = {{32{select_value[31]}}, select_value[31:0]};

endmodule



