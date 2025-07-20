"""
Created on Sun May 15 20:29:23 2022

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
        with open(str(i+1)+'.genotype.sh','w') as f:
            f.write('''#!/bin/sh
export ref=/storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.fa
export Genotype=/storage/public/home/2019050383/07.Bohai_black/04.ALL_genotype
''')

            f.write('''
/usr/bin/java -Djava.io.tmpdir=/storage/public/home/2019050383/temp -Xmx100g -jar /storage/public/home/2021060194/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \\
        -R $ref \\
        -T GenotypeGVCFs \\
        --variant %s.list \\
		-o $Genotype/%s.vcf.gz \\
		--disable_auto_index_creation_and_locking_when_reading_rods \\
		--includeNonVariantSites \\
		-nt 2 \\
		-stand_call_conf 10 
'''%(nameList[i],nameList[i]))


def main():
    import sys
    nameList = load_name_list(sys.argv[1])
    produce(nameList)
main()
