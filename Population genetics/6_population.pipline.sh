#!/bin/bash 

#####  Vcf to  plink format

#vcftools \
#--gzvcf /storage/public/home/2019050383/03.GWAS/14.POP/01.744/744.vcf.gz \
#--plink \
#--chrom-map ./chrID \
#--out 744
#
##### make bed

#plink --bfile ./744  --make-bed --chr-set 29 --out 744

##SNP-NJ
#plink -bfile ./744 --chr-set 29 --distance-matrix --out 744
#perl plink.distance.matrix.to.mega.pl 744.mdist.id 744.mdist 744 744.NJtree

##### Remove LD sites
#plink -bfile ./744 --indep-pairwise 300 5 0.15 --chr-set 29 --out 744

#### extract non_LD sites
#plink -bfile ./744 --extract 744.prune.in --make-bed --chr-set 29 --out 744.snp.prune

##### PCA
/stor9000/apps/users/NWSUAF/2008114353/software/EIG-6.1.4/bin/smartpca -p bos_eigensoft_smartpca.par
#
## Admxture
#for i in {2..10}
#do
#	/stor9000/apps/users/NWSUAF/2016060159/software/admixture --cv ./744.snp.prune.bed $i -j24 | tee log${i}.out
#done

#for i in {2..10}
#do
#	/stor9000/apps/users/NWSUAF/2016060159/software/admixture ./744.snp.prune.bed $i -j24
#done

#grep -h CV log*.out > CV.value
