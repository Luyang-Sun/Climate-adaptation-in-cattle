###################################################################
# File Name: bedtools.sh
# Author: Luyang Sun
# mail: sunluyang8869@nwafu.edu.cn
# Created Time: Mon 30 Dec 2024 03:30:02 PM CST
#=============================================================
#!/bin/bash
#bedtools intersect -a /storage/public/home/2019050383/03.GWAS/15.GEA/lfmm/gif/thr/gif_${1}.thr.txt -b /storage/public/home/2019050383/03.GWAS/15.GEA/gemma/thr/gemma-${1}.thr.txt -wa -wb|awk '!x[$0]++' > thr.gif-gemma.${1}.txt
#bedtools intersect -a /storage/public/home/2019050383/03.GWAS/15.GEA/lfmm/mad/thr/mad_${1}.thr.txt -b /storage/public/home/2019050383/03.GWAS/15.GEA/gemma/thr/gemma-${1}.thr.txt -wa -wb|awk '!x[$0]++' > thr.mad-gemma.${1}.txt
#perl -e 'open (IN1,"gunzip -c $ARGV[0] |");%hash;open (IN2,"$ARGV[1]");while(<IN1>){chomp;@tmp=split/\t/,$_,3;$hash{$tmp[0]}{$tmp[1]}=$tmp[2]};while(<IN2>){chomp;@F=split/\t/,$_,3;if (exists $hash{$F[0]}{$F[1]}){print "$F[0]\t$F[1]\t$F[2]\t$hash{$F[0]}{$F[1]}\n"}else{print "$F[0]\t$F[1]\t$F[2]\tNA\n";}}' /storage/public/home/2019050383/03.GWAS/10.28CVs/1169.header.eff.split.vcf.gz ./gif/thr/thr.gif-gemma.${1}.txt |grep -v 'NA' >> ./gif/gif-gemma_${1}.anno.txt
perl -e 'open (IN1,"gunzip -c $ARGV[0] |");%hash;open (IN2,"$ARGV[1]");while(<IN1>){chomp;@tmp=split/\t/,$_,3;$hash{$tmp[0]}{$tmp[1]}=$tmp[2]};while(<IN2>){chomp;@F=split/\t/,$_,3;if (exists $hash{$F[0]}{$F[1]}){print "$F[0]\t$F[1]\t$F[2]\t$hash{$F[0]}{$F[1]}\n"}else{print "$F[0]\t$F[1]\t$F[2]\tNA\n";}}' /storage/public/home/2019050383/03.GWAS/10.28CVs/1169.header.eff.split.vcf.gz ./${1}/thr/${1}_${2}.thr.txt |grep -v 'NA' >> ./${1}/thr/${1}_${2}.anno.txt
#awk '{print $1":"$2"\t"$15"\t"$13}' ./gif/gif-gemma_*.anno.txt >> gif-gemma.anno
#awk '{print $1":"$2"\t"$15"\t"$13}' ./mad/mad-gemma_*.anno.txt >> mad-gemma.anno
