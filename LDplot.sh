#!/bin/bash
#vcftools --gzvcf /storage/public/home/2019050383/03.GWAS/00.filter/744/chr18.imp.phase.vcf.gz --chr 18 --from-bp 14400000	--to-bp	14700000 	--keep /storage/public/home/2019050383/03.GWAS/16.new-gene/list/ind.list --max-missing 0.95 --maf 0.01 --recode --stdout | gzip -c  > HIGH.vcf.gz
#vcftools --gzvcf /storage/public/home/2019050383/03.GWAS/00.filter/744/chr18.imp.phase.vcf.gz --chr 18 --from-bp 14400000       --to-bp 14700000        --keep /storage/public/home/2019050383/03.GWAS/16.new-gene/list/tur.list --max-missing 0.95 --maf 0.01 --recode --stdout | gzip -c  > LOW.vcf.gz
LDBlockShow -InVCF HIGH.vcf.gz	-OutPut HIGH.haplo -InGFF /storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.gff -Region 18:14400000-14700000	-NoGeneName -OutPdf
LDBlockShow -InVCF LOW.vcf.gz  -OutPut LOW.haplo -InGFF /storage/public/home/2022060229/reference/01.ARS-UCD1.2_Btau5.0.1Y/ARS-UCD1.2_Btau5.0.1Y.gff -Region 18:14400000-14700000  -NoGeneName -OutPdf
