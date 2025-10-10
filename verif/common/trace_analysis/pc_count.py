import sys
import re

if len(sys.argv) != 2:
    print("usage: python pc_count.py path/to/file")
    sys.exit()
trace = sys.argv[1]

allpc = {}
sum = 0
with open(trace, 'r', encoding='utf-8') as file:
    for line in file:
        data_line = line.strip("\n").split(', ')
        pc = data_line[1].split(":")[1]
        if pc in allpc:
            allpc[pc] = allpc[pc] + 1
        else:
            allpc[pc] = 1
        sum = sum + 1   

sorted_allpc = sorted(allpc.items(), key=lambda x:x[1],reverse=True)

this_part = 0
top_num = 72
for i in range(top_num):
    print(sorted_allpc[i][0],':',sorted_allpc[i][1],'(', round(sorted_allpc[i][1]*100 / sum, 2),'%)')
    this_part = this_part + sorted_allpc[i][1]*100 / sum

print(f'\nTop{top_num} rate:',round(this_part, 2), '%')