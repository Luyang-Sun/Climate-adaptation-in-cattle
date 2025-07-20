###################################################################
# File Name: 01.PCA_FST_pipline.sh
# Author: Fuwen Wang
# mail: wangfuwen2016@nwafu.edu.cn
# Created Time: Wed 16 Aug 2023 02:26:17 AM CST
#=============================================================
#i!/bin/bash
#for i in {1..29}
#do
#vcftools --gzvcf /storage/public/home/2019050383/04.Hubei/06.eff/phase/chr${i}.imp.phase.vcf.gz --recode --recode-INFO-all --stdout | bgzip > ${i}.imp.phase.vcf.gz
#done
#for i in {1..29}
#do
#bcftools index -t ../${i}.imp.phase.vcf.gz
#done
#find /storage/public/home/2019050383/03.GWAS/14.POP/di/fst/ -name "*.imp.phase.vcf.gz"| sort -V > filelist
#bcftools concat -f filelist -o merge.vcf.gz
#/storage/public/apps/software/conda/Miniconda3-py310_23.3.1-0/envs/python-2.7.5_py27/bin/python2.7 /storage/public/home/2022060229/script/vcf2eigenstrat.py -v merge.vcf.gz -o 731
/storage/public/home/2022060229/software/EIG-master/bin/smartpca -p parfile > logfile
