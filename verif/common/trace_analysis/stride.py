#!/usr/bin/python

import os
import sys

input_file_name = sys.argv[1]
output_file_name = sys.argv[1]+".output"

input_file = open(input_file_name)
output_file = open(output_file_name, "w")

first_line = input_file.readline()
last_vaddr = int(first_line.split(",")[-1].split(":")[-1], base=16)
output_file.write(first_line)

for line in input_file.readlines():
    cur_vaddr = int(line.split(",")[-1].split(":")[-1], base=16)
    delta = cur_vaddr - last_vaddr
    last_vaddr = cur_vaddr
    output_file.write(line[0:-1] + ", delta : " + hex(delta) + "\n")

input_file.close()
output_file.close()