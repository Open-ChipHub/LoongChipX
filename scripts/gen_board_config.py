#!/usr/bin/env python3

import os.path
import sys
import argparse
from string import Template

scriptpath = os.path.dirname(sys.argv[0])
project_home = os.path.abspath(os.path.join(scriptpath, os.pardir))

context = """\

// Board Config for Verilog

`define $board_name  1

`define DUAL_CORE    2
`define TRIPLE_CORE  3
// `define QUAD_CORE    4

// for SpinalHDL generate debug info.
`define SYNTHESIS 1

"""


def Usage():
    print("Usage: gen_board_config board_name")


if len(sys.argv) < 1:
    Usage()
    sys.exit(1)

parser = argparse.ArgumentParser(description='Generate board config header')

parser.add_argument('-board-name', type=str, default="BOARD_VCU129",
                    help='Board Name')

parser.add_argument('-o', type=str, default="board.h",
                    help='file name')

args = parser.parse_args()

# Variables
board_name = args.board_name

if args.board_name == "vcu129":
    board_name = "BOARD_VCU129"
elif args.board_name == "vcu118":
    board_name = "BOARD_VCU118"
else:
    print("Error: gen_board_config board_name")
    sys.exit(1)


Filename = args.o

with open('{}/design/sys/cpu/rtl/{}'.format(project_home, Filename), "w") as config:
    ctxt = Template(context)
    config.write(ctxt.substitute(
        board_name=board_name,
        )
    )