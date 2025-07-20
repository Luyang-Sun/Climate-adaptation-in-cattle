# -*- encoding: utf-8 -*-
"""
@File:fiter_impfile_DR2.py
@Time:2023/1/28 17:02
@Note:This is a script 4 根据INFO的DR2列对imp文件进行过滤，要求生成文件DR2大于0.9。用法python3 fiter_impfile_DR2.py chr23.imp.vcf.gz chr23.imp_DR2filter.vcf.gz

"""
import gzip
import sys
f1=gzip.open(sys.argv[1],'rb')
f2=open(sys.argv[2],'w')
for s in f1.readlines():
    line = s.decode()
    if line.startswith("##"):
        f2.writelines(line)
    elif line.startswith("#CHROM"):
        f2.writelines(line)
    else:
        line1 = line.strip().split()
        filter_line = line1[7].strip().split(";")
        filter_line_DR2 = filter_line[1].strip().split("=")
        #print(filter_line_DR2[1])
        DR2 = float(filter_line_DR2[1])
        if DR2 < float(0.9):
            continue
        if DR2 >= float(0.9):
            f2.writelines(line)
