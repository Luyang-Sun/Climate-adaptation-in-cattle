def load_name_list(name_file):
    nameList = []
    with open(name_file) as f:
        for name in f:
            nameList.append(name.strip())
    return nameList


def produce(nameList):
    name_num = len(nameList)
    for i in range(name_num):
        with open(str(i+1)+'.filter.sh','w') as f:
            f.write('''#!/bin/sh
a=`date +%s`
date -d @$a +"%Y-%m-%d %H:%M:%S"
###############################################


''')
            f.write('''

export ref=/storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.fa
export GATK4=/storage/public/home/2022060229/software/gatk-4.2.6.1/gatk
for i in %s

do

/usr/bin/java -Xmx25g -Djava.io.tmpdir=/storage/public/home/2019050383/temp -jar /storage/public/home/2021060194/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \\
		-T SelectVariants \\
		-R $ref \\
		-V /storage/public/home/2019050383/04.genotype/${i}.vcf.gz \\
		-nt 10 \\
		-selectType SNP \\
		--excludeNonVariants \\
		--removeUnusedAlternates \\
		-restrictAllelesTo BIALLELIC \\
		--logging_level ERROR \\
		-o ${i}.raw.SNP.vcf.gz
																																																																																											

/usr/bin/java -Xmx25g -Djava.io.tmpdir=/storage/public/home/2019050383/temp -jar /storage/public/home/2021060194/software/GenomeAnalysisTK-3.8-1-0-gf15c1c3ef/GenomeAnalysisTK.jar \\
		-T VariantFiltration \\
		-R $ref \\
		-V ./${i}.raw.SNP.vcf.gz \\
		--logging_level ERROR \\
		--filterExpression " DP < 2797 || DP > 25177 || QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0 || SOR > 3.0" \\
		--filterName filtered \\
		--clusterSize 3 \\
		--clusterWindowSize 10 \\
		-o ${i}.filter.SNP.vcf.gz 

$GATK4 --java-options "-Xmx200G" SelectVariants \\
		-R $ref \\
		--select-type-to-include SNP \\
		-restrict-alleles-to BIALLELIC \\
		--remove-unused-alternates \\
		--exclude-non-variants \\
		-exclude-filtered \\
		-V ${i}.filter.SNP.vcf.gz \\
		-O ${i}.clean.SNP.vcf.gz

done


'''%(nameList[i]))
            f.write(r'''
''')
def main():
    import sys
    nameList = load_name_list(sys.argv[1])
    produce(nameList)
main()
