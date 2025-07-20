###################################################################
# File Name: 731.sh
# Author: Luyang Sun
# mail: sunluyang8869@nwafu.edu.cn
# Created Time: Thu 12 Dec 2024 10:22:06 PM CST
#=============================================================
#!/bin/bash
vcftools --gzvcf /storage/public/home/2019050383/03.GWAS/00.filter/744/chr${1}.imp.phase.vcf.gz --keep 731.list --recode --recode-INFO-all --stdout | bgzip > ${1}.imp.phase.vcf.gz
bcftools index -t ${1}.imp.phase.vcf.gz
  
