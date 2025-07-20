###################################################################
# File Name: FMD.sh
# Author: Luyang Sun
# mail: sunluyang8869@nwafu.edu.cn
# Created Time: Wed 19 Feb 2025 04:04:51 PM CST
#=============================================================
#!/bin/bash
for i in `cat /storage/public/home/2019050383/03.GWAS/15.GEA/pop/breed.haplotype_True_part/subset`
do
/storage/public/apps/software/R/R-4.3.0/bin/Rscript FMD.R ./anacore22/${i}.anacore_mat_omega.out ./anacore33/${i}.anacore_mat_omega.out ./FMD/2-3.${i}
paste ./FMD/1-2.${i} ./FMD/1-3.${i} ./FMD/2-3.${i}  >${i}
done
for i in `cat /storage/public/home/2019050383/03.GWAS/15.GEA/pop/breed.haplotype_True_part/subset`
do
cat ${i} >>./FMD/730.imp.phase.no_hwe.breed.haplotype_True.txt
done
