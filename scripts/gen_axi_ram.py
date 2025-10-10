#!/usr/bin/env python3

from string import Template
import argparse
import os.path
import sys
import binascii


scriptpath = os.path.dirname(sys.argv[0])        
project_home = os.path.abspath(os.path.join(scriptpath, os.pardir))

parser = argparse.ArgumentParser(description='Convert binary file to verilog rom')

parser.add_argument('kernel', nargs=1,
                   help='filename of input binary')

args = parser.parse_args()
file_kernel = args.kernel[0];

# check that file exists
if not os.path.isfile(file_kernel):
    print("File {} does not exist.".format(file_kernel))
    sys.exit(1)

# filename = os.path.splitext(file_kernel)[0]

module = """\
module $moduleName #(
    parameter int unsigned AXI_ID_WIDTH      = 7,
    parameter int unsigned AXI_ADDR_WIDTH    = 48,
    parameter int unsigned AXI_DATA_WIDTH    = 128,
    parameter int unsigned AXI_USER_WIDTH    = 2
)(
    input   logic                        clk,
    input   logic                        reset,

    input   logic                        req_i,
    input   logic                        we_i,
    input   logic [AXI_ADDR_WIDTH-1:0]   addr_i,
    input   logic [AXI_DATA_WIDTH/8-1:0] be_i,
    input   logic [AXI_DATA_WIDTH-1:0]   data_i,
    output  logic [AXI_DATA_WIDTH-1:0]   data_o
);


/// --------------------------- RAM --------------------------- ///
localparam int RamSize = 32'h400_0000 / 16;//$size;
logic [RamSize-1:0][127:0] ram_mem = {
$content_ram
};

/// read 
logic ram_cs;
// assign ram_cs = addr_i >= 64'h0000_0000 && addr_i < 64'h1FF0_0000;
assign ram_cs = addr_i[23:0] >= 24'h000000 && addr_i[23:0] < 24'hFFFFFF;
logic [AXI_ADDR_WIDTH-1:0] ram_raddr_q;
logic [AXI_DATA_WIDTH-1:0] ram_rdata_o;
always_ff @(posedge clk) begin
    if (ram_cs && req_i && ~ we_i) begin
        ram_raddr_q <= addr_i;
    end
end


logic [AXI_ADDR_WIDTH-1:0] ram_raddr; 

assign ram_raddr = ram_raddr_q[$$clog2(RamSize)+3:4];
assign ram_rdata_o = reset ? '0 : ram_mem[ram_raddr];


/// write
logic [AXI_DATA_WIDTH-1:0] ram_rdata_i;

always_comb begin
    ram_rdata_i = ram_mem[addr_i[$$clog2(RamSize)+3:4]];
    for (int i = 0; i < $$bits(be_i); i++) begin
        if (be_i[i]) begin
            ram_rdata_i[i*8+:8] = data_i[i*8+:8];
        end
    end
end

always @(posedge clk) begin 
    if (ram_cs && req_i && we_i) begin
        ram_mem[addr_i[$$clog2(RamSize)+3:4]] <= ram_rdata_i;
    end
end


/// --------------------------- UART --------------------------- ///

localparam int UARTSize = 1000;
logic [UARTSize-1:0][127:0] uart_map_mem = {
       128'h00000000_00000000_00000000_00000000,
       128'h00000000_00000000_00000000_00000000,
       128'h00000000_00000000_00000000_00000000,
       128'h00000000_00000000_00000000_00000000,
       128'h00000000_00000000_00000000_00000000,
       128'h00000000_00000000_00000000_00000000
};

/// read 
logic UART_cs;
assign UART_cs = addr_i >= 64'h1FF1_0000 && addr_i < 64'h1FF1_FFFF;
logic [AXI_ADDR_WIDTH-1:0] UART_raddr_q;
logic [AXI_DATA_WIDTH-1:0] UART_rdata_o;
always_ff @(posedge clk) begin
    if (UART_cs && req_i && ~ we_i) begin
        UART_raddr_q <= addr_i;
    end
end
assign UART_rdata_o = (UART_raddr_q[AXI_ADDR_WIDTH-1:4] == 36'h1FF1_001) ? 128'h20_00000000 :
                      uart_map_mem[UART_raddr_q[$$clog2(UARTSize)+3:4]];


/// write registers
logic [AXI_DATA_WIDTH-1:0] uart_rdata_i;

always_comb begin
    uart_rdata_i = uart_map_mem[addr_i[$$clog2(RamSize)+3:4]];
    for (int i = 0; i < $$bits(be_i); i++) begin
        if (be_i[i]) begin
            uart_rdata_i[i*8+:8] = data_i[i*8+:8];
        end
    end
end

always @(posedge clk) begin 
    if (UART_cs && req_i && we_i) begin
        uart_map_mem[addr_i[$$clog2(RamSize)+3:4]] <= uart_rdata_i;
    end
end

/// write, print
always @(posedge clk) begin
     if (UART_cs && req_i && we_i) 
     begin
        if(be_i[15:0] == 16'h01) /// write 8-bit
           begin
              $$write("%c", data_i[7:0]);
           end
        else if(be_i[15:0] == 16'hf) /// write 32-bit
           begin
              $$write("%c", data_i[7:0]);
           end
        else if(be_i[15:0] == 16'hff) /// write 64-bit
           begin
              $$write("%c", data_i[7:0]);
           end   
        else if(be_i[15:0] == 16'hf0)
           begin
              $$write("%c", data_i[39:32]);
           end
        else if(be_i[15:0] == 16'hf00)
           begin
              $$write("%c", data_i[71:64]);
           end
        else if(be_i[15:0] == 16'hf000)
           begin
              $$write("%c", data_i[103:96]);
           end
    end
end

/// Read Data Output
always @(*) begin 
    if (ram_cs) begin
        data_o = ram_rdata_o;
    end
    else if (UART_cs) begin
        data_o = UART_rdata_o;
    end
    else begin
        data_o = '0;
    end
end

endmodule
"""

def read_bin(file_kernel):
    with open(file_kernel, 'rb') as f:
        rom = binascii.hexlify(f.read())
    return rom


""" Generate SystemVerilog bootcode for FPGA and ASIC
"""
def reserve( ints ):
    s1 = "".join(ints[0:2])[::-1]
    s2 = "".join(ints[2:4])[::-1]
    s3 = "".join(ints[4:6])[::-1]
    s4 = "".join(ints[6:8])[::-1]
    a = "".join(s1 + s2 + s3 + s4) # little
    return a


def generate_context(ram):
    size = 0
    context_str = ""
    str0 = str(ram.decode('utf-8'))

    # process in junks of 128 bit (16 byte)
    orign_len = len(str0)
    align = (int((len(str0) + 31) / 32)) * 32;
    for i in range(len(str0), align):
        str0 += "0"
    str0_r = str0[::-1]
    size = int(len(str0_r)/32)
    for i in range(int(len(str0_r) / 32)):
        context_str += "       128'h" + reserve("".join(str0_r[i * 32 + 0:i * 32 + 8])) + "_" \
                                      + reserve("".join(str0_r[i * 32 + 8:i * 32 + 16])) + "_" \
                                      + reserve("".join(str0_r[i * 32 + 16:i * 32 + 24])) + "_" \
                                      + reserve("".join(str0_r[i * 32 + 24:i * 32 + 32])) + ",\n"
    # remove the trailing comma
    context_str = context_str[:-2]
    return context_str, size

def write_verilog(ram, ram_size):
    with open('{}/verif/common/vsrc/{}.v'.format(project_home, VERILOG_FILE_NAME), "w") as f:
        s = Template(module)
        f.write(s.substitute(moduleName=VERILOG_MODULE_NAME,
            size=ram_size,
            content_ram=ram))



VERILOG_FILE_NAME = "axi_slave_ram"
VERILOG_MODULE_NAME = "slave_ram"


if __name__ == '__main__':
    ram_size = 0
    sys_ram  = read_bin(file_kernel)
    sys_ram_str, ram_size = generate_context(sys_ram);
    write_verilog(sys_ram_str, ram_size)
