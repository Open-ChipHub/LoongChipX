#!/usr/bin/env python3

from string import Template
import argparse
import os.path
import sys
import binascii

ctx_align_width = 2048

parser = argparse.ArgumentParser(description='Convert binary file to DDR upload')

parser.add_argument('bios', nargs=1,
                    help='filename of bios binary')

parser.add_argument('boffset', nargs=1,
                    help='offset in DDR')

parser.add_argument('kinput', nargs=1,
                    help='filename of input binary')

parser.add_argument('koffset', nargs=1,
                    help='offset in DDR')

parser.add_argument('output', nargs=1,
                    help='filename of output binary')



args = parser.parse_args()
bios_file = args.bios[0]
input_file = args.kinput[0]
output_file = args.output[0]

bios_load_offset_str = args.boffset[0]
bios_load_offset = int(bios_load_offset_str, 16)

kernel_load_offset_str = args.koffset[0]
kernel_load_offset = int(kernel_load_offset_str, 16)

def read_bin(file_kernel):
    with open(file_kernel, 'rb') as f:
        ctx = binascii.hexlify(f.read())
    return ctx


def gen_inst(ints):
    s1 = "".join(ints[0:2])
    s2 = "".join(ints[2:4])
    s3 = "".join(ints[4:6])
    s4 = "".join(ints[6:8])
    # little
    new_inst = "".join(s4 + s3 + s2 + s1)
    return new_inst


def generate_context(ctx, load_offset, is_append):
    context_str = ""
    str0 = str(ctx.decode('utf-8'))

    orign_len = len(str0)

    align = (int((len(str0) + ctx_align_width - 1) / ctx_align_width)) * ctx_align_width
    for i in range(len(str0), align):
        str0 += "0"

    for i in range(int(len(str0) / ctx_align_width)):
        addr = load_offset + int((ctx_align_width / 2) * i)
        context_str += str(hex(addr))[2:]
        context_str += '\n'
        for ii in range(int(ctx_align_width / 16) - 1, -1, -1):
            context_str += gen_inst(str0[i * ctx_align_width + ii * 16 + 8: i * ctx_align_width + ii * 16 + 16])
            context_str += gen_inst(str0[i * ctx_align_width + ii * 16: i * ctx_align_width + ii * 16 + 8])
            # context_str += '_'
        context_str += '\n'

    if is_append:
        context_str += '\n'

    context_str = context_str[:-1]
    return context_str


def write_to_upload(out, strs, is_append):
    f_attr = "w"
    if is_append:
        f_attr = "a"
    with open(out, f_attr) as f:
        f.write(strs)


if __name__ == '__main__':
    # BIOS 
    bios_rom = read_bin(bios_file)
    contx_bios = generate_context(bios_rom, bios_load_offset, True)
    write_to_upload(output_file, contx_bios, False)

    # Kernel 
    kernel_ram = read_bin(input_file)
    contx = generate_context(kernel_ram, kernel_load_offset, False)
    write_to_upload(output_file, contx, True)
