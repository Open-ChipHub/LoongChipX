#! /usr/bin/python

import sys, os
           
scriptpath = os.path.dirname(sys.argv[0])        
project_home = os.path.abspath(os.path.join(scriptpath, os.pardir))

def read_filelist(filename):
    with open(filename, 'r') as reader:
        read_verilog_files = ""
        parse_file = ""
        parse_filename = ""
        for line in reader.readlines():
            line = line.replace("\n", "")
            line = line.replace("${LCX_HOME}", project_home)

            if line.startswith("#"):
                continue
            elif line.startswith("-f"):
                parse_filename = line.split()[1]
                parse_file = read_filelist(parse_filename)
                read_verilog_files += parse_file
            elif line.endswith(".v") or line.endswith(".sv") or line.endswith(".h"):
                read_verilog_files += "       " + line + ' \\\n'
    return read_verilog_files

def main():
    newline = "read_verilog -sv { \\\n"
    verilog_file_list = read_filelist("{}/design/filelists/impl_fpga_files.lst".format(project_home))
    newline += verilog_file_list
    newline += "  }"

    with open('{}/impl/work-xlnx/add_loongchipx_filelists.tcl'.format(project_home), 'w') as writer:
        writer.writelines(newline)

# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    main()

