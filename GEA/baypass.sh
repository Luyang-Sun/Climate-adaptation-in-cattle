###################################################################
# File Name: baypass.sh
# Author: Luyang Sun
# mail: sunluyang8869@nwafu.edu.cn
# Created Time: Mon 23 Dec 2024 10:23:25 AM CST
#=============================================================
#!/bin/bash
#plink --bed /storage/public/home/2019050383/03.GWAS/15.GEA/pop/730.imp.phase.hwe.bed --bim /storage/public/home/2019050383/03.GWAS/15.GEA/pop/730.imp.phase.hwe.bim --fam /storage/public/home/2019050383/03.GWAS/15.GEA/pop/730.imp.phase.hwe.fam --chr-set 29 --recode A --out 730.imp.phase.hwe_gen
#split -l 1000000 730.imp.phase.hwe_gen.raw part_
#find . -type f -name "part_*" | /storage/public/apps/software/parallel/bin/parallel 'awk "{for(i=7;i<=NF;i++) if(\$i != 0 && \$i != 1) \$i=0}1" {} > {}.processed'
#cat part_*.processed > processed_genotype_data.raw
#rm -f part_*
#rm -f part_*.processed
#awk 'NR>1 { $1=""; print substr($0,2) }' /storage/public/home/2019050383/03.GWAS/15.GEA/phase.raw/${1}_breed.haplotype_True.txt > ./gfile/${1}_breed.haplotype_True_modified.txt
#/storage/public/home/2019050383/Software/baypass_public-master/sources/g_baypass -gfile /storage/public/home/2019050383/03.GWAS/15.GEA/pop/${1} -outprefix ./anacore11/${1}.anacore -nthreads 20 -seed 5001
#/storage/public/home/2019050383/Software/baypass_public-master/sources/g_baypass -gfile /storage/public/home/2019050383/03.GWAS/15.GEA/pop/${1} -efile env.txt  -outprefix ./anacore11/${1}_baypass -npilot 15 -burnin 2500 -nthreads 20 -auxmodel  -omegafile ./anacore11/${1}.anacore_mat_omega.out -seed 5001
#module add R-4.3.0-gcc831
#/storage/public/apps/software/R/R-4.3.0/bin/Rscript median.R ./anacore11/${1}_baypass_summary_betai.out ./anacore22/${1}_baypass_summary_betai.out ./anacore33/${1}_baypass_summary_betai.out ./BF_median/${1}_median_BF.txt
#/storage/public/apps/software/R/R-4.3.0/bin/Rscript run_analysis.R ./anacore11/${1}_baypass_summary_betai.out ./anacore11/${1}_baypass_summary_pi_xtx.out ./betai-pi/ ${1}_plot.png
#/storage/public/apps/software/R/R-4.3.0/bin/Rscript volcano_with_lines.R ./anacore11/${1}_baypass_summary_betai.out  ./volcano/ plot_${1}
##/storage/public/home/2019050383/Software/baypass_public-master/sources/g_baypass -gfile /storage/public/home/2019050383/03.GWAS/15.GEA/pop/${1} -efile env.txt -npilot 20 -nval 5000 -thin 10 -auxPbetaprior 0.01 1.99 -outprefix ./anacore11/zz${1}_baypass  -burnin 10000 -nthreads 20 -auxmodel  -omegafile ./anacore11/${1}.anacore_mat_omega.out -seed 5001
