###################################################################
# File Name: gemma.sh
# Author: Luyang Sun
# mail: sunluyang8869@nwafu.edu.cn
# Created Time: Wed 18 Dec 2024 10:26:39 PM CST
#=============================================================
#!/bin/bash
#plink -bfile /storage/public/home/2019050383/03.GWAS/15.GEA/pop/730.imp.phase --pca --chr-set 29 --out 730.pca
#sed 's/ /\t/g' 730.pca.eigenvec |cut -f 3- -d $'\t' |awk '{print "1""\t"$0}' >pca.list
#for i in  {3..114}
#do
#	echo "#!/bin/bash" > gemma.$i.sh
#      	echo "gemma -bfile /storage/public/home/2019050383/03.GWAS/15.GEA/pop/730.imp.phase -p /storage/public/home/2019050383/03.GWAS/15.GEA/keep/keep-$i.list -n 1 -gk 2 -o kin.$i" >> gemma.$i.sh
#	echo "cp ./output/kin.$i.sXX.txt ./ " >> gemma.$i.sh
#	echo "gemma -bfile /storage/public/home/2019050383/03.GWAS/15.GEA/pop/730.imp.phase -k kin.$i.sXX.txt -p /storage/public/home/2019050383/03.GWAS/15.GEA/keep/keep-$i.list -n 1 -lmm 1 -c pca.list -o gemma-$i.hwe " >> gemma.$i.sh
#	chmod 755 gemma.$i.sh
#done
module add R-4.3.0-gcc831
#awk '{print $3"\t"$1"\t"$3"\t"$12}' ./output/gemma-${1}.hwe.assoc.txt > ./ps/gemma-${1}.hwe.ps
/storage/public/apps/software/R/R-4.3.0/bin/Rscript gemma_plot.R ./ps/gemma-${1}.hwe.ps ${1}.m ${1}.p
#awk '$12<=0.00000000155' ./output/gemma-${1}.hwe.assoc.txt  >> ./thr/gemma-${1}.hwe.thr.txt
#awk '{print  $1"\t"$3"\t"$3"\t"$7"\t"$12 }' ./thr/gemma-${1}.hwe.thr.txt  >> ./thr/gemma-${1}.thr.txt
#rm -f ./thr/gemma-${1}.hwe.thr.txt

