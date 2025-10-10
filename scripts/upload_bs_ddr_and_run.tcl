
# work_path

set work_path [lindex $argv 0]

puts "work_path:"
puts $work_path

set impl_top [lindex $argv 1]

set bit_path $work_path/$impl_top.bit
set ltx_path $work_path/$impl_top.ltx

puts "bit_path:"
puts $bit_path
puts "ltx_path:"
puts $ltx_path


set_param xicom.use_bitstream_version_check false
open_hw_manager
catch {disconnect_hw_server localhost:3121}
connect_hw_server -url localhost:3121
current_hw_target [get_hw_targets */xilinx_tcf/Digilent/*]
set_property PARAM.FREQUENCY 15000000 [get_hw_targets */xilinx_tcf/Digilent/*]
open_hw_target
# current_hw_device [lindex [get_hw_devices xcvu9p_0] 0]
# refresh_hw_device -update_hw_probes false [lindex [get_hw_devices xcvu9p_0] 0]
set_property PROBES.FILE $ltx_path [get_hw_devices xcvu9p_0]
set_property FULL_PROBES.FILE $ltx_path [get_hw_devices xcvu9p_0]
set_property PROGRAM.FILE $bit_path [get_hw_devices xcvu9p_0]
program_hw_devices [get_hw_devices xcvu9p_0]
refresh_hw_device [lindex [get_hw_devices xcvu9p_0] 0]

# set_param messaging.defaultLimit 100000
set_param messaging.defaultLimit 2

startgroup
set_property OUTPUT_VALUE 0 [get_hw_probes vio_cpu_reset -of_objects [get_hw_vios -of_objects [get_hw_devices xcvu9p_0] -filter {CELL_NAME=~"xlnx_vio"}]]
commit_hw_vio [get_hw_probes {vio_cpu_reset} -of_objects [get_hw_vios -of_objects [get_hw_devices xcvu9p_0] -filter {CELL_NAME=~"xlnx_vio"}]]
endgroup
after 500


after 500

puts "Workload Path:"
puts [lindex $argv 2]
set payload_file [lindex $argv 2]
proc write_to_ddr {rd_file} {
  set r_handler [open $rd_file r]
  while {[eof $r_handler] != 1} {
    gets $r_handler aline
    set waddr [lindex $aline 0] 
    gets $r_handler dline
    set wdata [lindex $dline 0] 
    # create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address $waddr -data $wdata -len 256 -burst INCR -size 64 -type write
    create_hw_axi_txn wr_txn [get_hw_axis hw_axi_1] -address $waddr -data $wdata -len 128 -burst INCR -type write
    run_hw_axi wr_txn
    delete_hw_axi_txn wr_txn
  }
  close $r_handler
}

if {[catch {[write_to_ddr $payload_file]} errmsg]} {
  puts "ErrorMsg: $errmsg"
}

proc read_from_ddr {wr_file from_addr to_addr} {
  set w_handler [open $wr_file w]
  for { set addr $from_addr}  {$addr <= $to_addr} {incr addr 1024} {
    set raddr [format %x $addr]
    create_hw_axi_txn rd_txn [get_hw_axis hw_axi_1] -address $raddr -len 128 -burst INCR -type read
    run_hw_axi rd_txn
    set read_data [report_hw_axi_txn rd_txn -w 1024 -t x4]
    delete_hw_axi_txn rd_txn
    # Addr
    puts $w_handler [lindex $read_data 0] 
    # Value
    for { set index 256 }  { $index > 0 }  { incr index -1} {
      puts -nonewline $w_handler [lindex $read_data $index] 
    }
    puts $w_handler ""
  }
  close $w_handler
}

proc Twrite_to_ddr {addr data} {
  create_hw_axi_txn twr_txn [get_hw_axis hw_axi_1] -address $addr -data $data -len 128 -burst INCR -type write
  run_hw_axi twr_txn
  delete_hw_axi_txn twr_txn
}

proc Tread_from_ddr {addr} {
  create_hw_axi_txn t_rd_txn [get_hw_axis hw_axi_1] -address $addr -len 1 -burst INCR -type read
  run_hw_axi t_rd_txn
  report_hw_axi_txn t_rd_txn
  delete_hw_axi_txn t_rd_txn
}


startgroup
set_property OUTPUT_VALUE 1 [get_hw_probes vio_cpu_reset -of_objects [get_hw_vios -of_objects [get_hw_devices xcvu9p_0] -filter {CELL_NAME=~"xlnx_vio"}]]
commit_hw_vio [get_hw_probes {vio_cpu_reset} -of_objects [get_hw_vios -of_objects [get_hw_devices xcvu9p_0] -filter {CELL_NAME=~"xlnx_vio"}]]
endgroup
after 500


startgroup
set_property OUTPUT_VALUE 0 [get_hw_probes vio_cpu_reset -of_objects [get_hw_vios -of_objects [get_hw_devices xcvu9p_0] -filter {CELL_NAME=~"xlnx_vio"}]]
commit_hw_vio [get_hw_probes {vio_cpu_reset} -of_objects [get_hw_vios -of_objects [get_hw_devices xcvu9p_0] -filter {CELL_NAME=~"xlnx_vio"}]]
endgroup
after 500

