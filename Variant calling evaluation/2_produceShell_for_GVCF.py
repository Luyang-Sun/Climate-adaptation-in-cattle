"""
"""

def load_name_list(name_file):
    nameList = []
    with open(name_file) as f:
        for name in f:
            nameList.append(name.strip())
    return nameList


def produce(nameList):
    for n,i in enumerate(nameList):
        for chrom in (list(range(1,30))+['X']+['Y']):
                print(i, chrom)
                with open('%s.%s.GVCF.sh' % (i, chrom),'w') as f:
                    f.write('''#!/bin/sh
        export ref=/storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.fa
		export BAM=/storage/public/home/2019050383/01.mapping
		export GVCF=/storage/public/home/2019050383/02.gvcf
        ''')
                    f.write('''
        /usr/bin/java -Djava.io.tmpdir=/storage/public/home/2019050383/temp -Xmx40g -jar /storage/public/home/2021060194/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \\
		-T HaplotypeCaller \\
		-R $ref \\
		-ERC GVCF \\
		-variant_index_type LINEAR \\
		-variant_index_parameter 128000 \\
		-nct 20 \\
		-L {chrom} \\
		-I $BAM/{ID}.sort.dedup.bam \\
		-o $GVCF/{ID}/{chrom}_{ID}.g.vcf.gz 
        '''.format(ID=i, chrom=chrom))

def main():
    import sys
    print(sys.argv)
    nameList = load_name_list(sys.argv[1])
    produce(nameList)
main()
