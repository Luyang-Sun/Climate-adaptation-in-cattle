"""
Creat on 2022/5/7
SLY

"""
def load_name_list(name_file):
    nameList = []
    with open(name_file) as f:
        for name in f:
            nameList.append(name.strip())
    return nameList


def produce(nameList):
    name_num = len(nameList)
    for i in range(name_num):
        with open(str(i+1)+'.BAMQC.sh','w') as f:
            f.write('''#!/bin/sh
a=`date +%s`
date -d @$a +"%Y-%m-%d %H:%M:%S"
###############################################

export ref=/storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.fa
export BAM=/storage/public/home/2019050383/01.mapping
export BAMQC=/storage/public/home/2019050383/03.bamqc
''')
            f.write('''
/storage/public/home/2022060229/software/qualimap_v2.3/qualimap bamqc -bam $BAM/%s.sort.dedup.bam -outdir $BAMQC/%s.sort.dedup.bam -outformat HTML --java-mem-size=60G

'''%(nameList[i],nameList[i]))
            f.write(r'''
###############################################
b=`date +%s`
date -d @$b +"%Y-%m-%d %H:%M:%S"
c=`echo $b-$a|bc`
echo "running time is "$c" seconds"
m=`echo $c/60|bc`
h=`echo $c/60/60|bc`
echo "running time is "$m" minutes"
echo "running time is "$h" hours"
''')
def main():
    import sys
    nameList = load_name_list(sys.argv[1])
    produce(nameList)
main()
