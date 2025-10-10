#!/usr/bin/env python3

import os.path
import sys
import argparse
from string import Template

scriptpath = os.path.dirname(sys.argv[0])
project_home = os.path.abspath(os.path.join(scriptpath, os.pardir))

context = """\
#ifndef DPI_SIM_CONFIG_H
#define DPI_SIM_CONFIG_H

/// Size of system memory (default 8GB)
uint64_t SYS_RAM_SIZE = $ram_size;


/// Bios
char *kernel_elf_bios = "$bios_name";

/// Kenel 
char *kernel_elf = "$kernel_name";

/// ramdisk.img
bool load_bin = $is_load_binary;

/// binary entry
uint64_t bin_addr = $binary_entry;

/// binary name 
char * bin_name = "$binary_name";


#endif //DPI_SIM_CONFIG_H
"""


def Usage():
    print("Usage: gen_sim_config kernel_name is_bin [ binary_name, binary_entry ]")


if len(sys.argv) < 2:
    Usage()
    sys.exit(1)

parser = argparse.ArgumentParser(description='Generate sim config header')

parser.add_argument('-ram-size', type=int, default=8589934592,
                    help='entry of binary')

parser.add_argument('-kernel-elf', type=str, default="",
                    help='entry of binary')

parser.add_argument('-bios-elf', type=str, default="",
                    help='entry of binary')

parser.add_argument('-b', type=bool, default=False,
                    help='if we need an input binary')

parser.add_argument('-binary-name', type=str, default="",
                    help='binary name')

parser.add_argument('-binary-entry', type=int, default=0x0,
                    help='entry of binary')

parser.add_argument('-o', type=str, default="sim_config.h",
                    help='file name')

args = parser.parse_args()

# Variables
ram_size = args.ram_size
kernel_name = args.kernel_elf
bios_name = args.bios_elf

if args.b:
    is_load_binary = "true"
else:
    is_load_binary = "false"

binary_entry = args.binary_entry
binary_name = args.binary_name

Filename = args.o

with open('{}/{}'.format(project_home, Filename), "w") as config:
    ctxt = Template(context)
    config.write(ctxt.substitute(
        ram_size=ram_size,
        bios_name=bios_name,
        kernel_name=kernel_name,
        is_load_binary=is_load_binary,
        binary_entry=binary_entry,
        binary_name=binary_name,
        )
    )
