
lassign $argv mcsfile bitfile

# this is earlier than Rev.2.0 VCU118 boards
# write_cfgmem -format mcs \
# 			 -force \
# 			 -interface bpix16 \
# 			 -size 128 \
# 			 -loadbit "up 0x0 $bitfile" \
# 			 -file $mcsfile 

write_cfgmem -format MCS \
			 -force \
			 -interface SPIx8 \
			 -size 64 \
			 -loadbit "up 0x00000000 $bitfile" \
			 -file $mcsfile 
