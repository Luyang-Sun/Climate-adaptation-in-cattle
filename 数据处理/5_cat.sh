#!/bin/sh
source /storage/public/home/2022060229/.bashrc
export ref=/storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.fa
export GVCF=/storage/public/home/2019050383/05.filter

/usr/bin/java -Djava.io.tmpdir=/storage/public/home/2019050383/temp -Xmx100g -cp $GATK3_8 org.broadinstitute.gatk.tools.CatVariants \
						-R $ref \
						--variant $GVCF/1.snp.vcf.gz \
						--variant $GVCF/2.snp.vcf.gz \
						--variant $GVCF/3.snp.vcf.gz \
						--variant $GVCF/4.snp.vcf.gz \
						--variant $GVCF/5.snp.vcf.gz \
						--variant $GVCF/6.snp.vcf.gz \
						--variant $GVCF/7.snp.vcf.gz \
						--variant $GVCF/8.snp.vcf.gz \
						--variant $GVCF/9.snp.vcf.gz \
						--variant $GVCF/10.snp.vcf.gz \
						--variant $GVCF/11.snp.vcf.gz \
						--variant $GVCF/12.snp.vcf.gz \
						--variant $GVCF/13.snp.vcf.gz \
						--variant $GVCF/14.snp.vcf.gz \
						--variant $GVCF/15.snp.vcf.gz \
						--variant $GVCF/16.snp.vcf.gz \
						--variant $GVCF/17.snp.vcf.gz \
						--variant $GVCF/18.snp.vcf.gz \
						--variant $GVCF/19.snp.vcf.gz \
						--variant $GVCF/20.snp.vcf.gz \
						--variant $GVCF/21.snp.vcf.gz \
						--variant $GVCF/22.snp.vcf.gz \
						--variant $GVCF/23.snp.vcf.gz \
						--variant $GVCF/24.snp.vcf.gz \
						--variant $GVCF/25.snp.vcf.gz \
						--variant $GVCF/26.snp.vcf.gz \
						--variant $GVCF/27.snp.vcf.gz \
						--variant $GVCF/28.snp.vcf.gz \
						--variant $GVCF/29.snp.vcf.gz \
						-out ./744.SNP.vcf.gz \
						-assumeSorted	

