"""
Created on Sun May 15 20:29:23 2021

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
        with open(str(i+1)+'SMD.sh','w') as f:
            f.write('''#!/bin/sh
export ref=/storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.fa
export fastq=/storage/public/home/2020050452/
export BAM=/storage/public/home/2019050383/01.mapping
export trim=/storage/public/home/2019050383/01.mapping
''')

            f.write('''
java -Xmx25g -Djava.io.tmpdir=/storage/public/home/2019050383/temp -jar /storage/public/home/2022060229/software/Trimmomatic/trimmomatic-0.38.jar  PE -threads 12 \\
-summary $trim/%s.summary \\
$fastq/%s/%s_1.fq.gz \\
$fastq/%s/%s_2.fq.gz \\
$trim/%s_1_trimmed.fq.gz \\
$trim/%s_1_singleton.fq.gz \\
$trim/%s_2_trimmed.fq.gz \\
$trim/%s_2_singleton.fq.gz \\
LEADING:20 TRAILING:20 SLIDINGWINDOW:3:15 AVGQUAL:20 MINLEN:35 TOPHRED33
echo "trim is Done!"

rm -rf $trim/%s_1_singleton.fq.gz $trim/%s_2_singleton.fq.gz 
'''%(nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i]))

            f.write('''
/storage/public/home/2022060229/software/bwa-0.7.17/bwa mem -t 20  -M -R '@RG\\tID:%s\\tLB:%s\\tPL:ILLUMINA\\tSM:%s' $ref $trim/%s_1_trimmed.fq.gz $trim/%s_2_trimmed.fq.gz | samtools view -bS -@20 - >$BAM/%s.bam
echo "mapping is Done!"'''%(nameList[i],nameList[i],nameList[i],nameList[i],nameList[i],nameList[i]))
            f.write('''
java -Djava.io.tmpdir=/storage/public/home/2019050383/temp -Xmx20g -jar /storage/public/home/2022060229/software/jar-pkg/picard.jar  SortSam I=$BAM/%s.bam O=$BAM/%s.sort.bam SORT_ORDER=coordinate
echo "sort is Done!"
java -Djava.io.tmpdir=/storage/public/home/2019050383/temp -Xmx20g -jar /storage/public/home/2022060229/software/jar-pkg/picard.jar  MarkDuplicates I=$BAM/%s.sort.bam O=$BAM/%s.sort.dedup.bam M=$BAM/%s.marked_dup_metrics.txt REMOVE_DUPLICATES=true CREATE_INDEX=true VALIDATION_STRINGENCY=LENIENT
echo "DeDup is Done!"
'''%(nameList[i],nameList[i],nameList[i],nameList[i],nameList[i]))
def main():
    import sys
    nameList = load_name_list(sys.argv[1])
    produce(nameList)
main()

