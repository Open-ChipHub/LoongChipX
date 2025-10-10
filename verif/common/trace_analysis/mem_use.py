import sys
import re

if len(sys.argv) != 2:
    print("usage: python mem_use.py path/to/file")
    sys.exit()
trace = sys.argv[1]

allline = {}
allpage = {}
alladdr = {}
sum = 0
linesum = 0
pagesum = 0
addrsum = 0

with open(trace, 'r', encoding='utf-8') as file:
    for line in file:
        data_line = line.strip("\n").split(', ')
        # print(data_line)
        vaddr = int(data_line[4].split(":")[1], 16)
        cl = vaddr >> 6
        pg = vaddr >> 14
        if cl in allline:
            allline[cl] = allline[cl] + 1
        else:
            allline[cl] = 1
            linesum = linesum + 1
        sum = sum + 1

        if pg in allpage:
            allpage[pg] = allpage[pg] + 1
        else:
            allpage[pg] = 1
            pagesum = pagesum + 1

        if vaddr in alladdr:
            alladdr[vaddr] = alladdr[vaddr] + 1
        else:
            alladdr[vaddr] = 1
            addrsum = addrsum + 1
# sorted_allline = sorted(allline.items(), key=lambda x:x[0], reverse=False) #if focus on area releation
sorted_allline = sorted(allline.items(), key=lambda x:x[1], reverse=True) #if focus on times
sorted_allpage = sorted(allpage.items(), key=lambda x:x[1], reverse=True)
print('>>>>>>>>>>>cache line info:')
for item in sorted_allline:
    rate = round(item[1]*100 / sum, 2)
    if(rate > 0.1):
        print(hex(item[0]),':',item[1],'(',rate,'%)' )
    else:
        # print(hex(item[0]),':',item[1],'(',rate,'%)' )
        break
print('>>>>>>>>>>>page info:')
# for item in sorted_allpage:
#     print(hex(item[0]),':',item[1])
print('>>>>>>>>>>>sum info:')
print('access Different Vaddr:', addrsum)
print('access Cache Line Number:', linesum)
print('access Page Number:', pagesum)