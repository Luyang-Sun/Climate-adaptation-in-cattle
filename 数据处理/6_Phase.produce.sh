#!/bin/bash 
for i in {1..29}
do
	echo $i
	echo "#!/bin/bash" > $i.imput.sh
	echo "export beagle=/storage/public/home/2017050429/software/beagle.27Jan18.7e1.jar" >> $i.imput.sh
	echo "export Finalsnp=/storage/public/home/2019050383//05.filter" >> $i.imput.sh
	echo "java -Xmx100g -Xss128m -jar \$beagle chrom=$i gtgl=\$Finalsnp/$i.clean.SNP.vcf.gz out=chr$i.imp gprobs=true niterations=10 nthreads=48" >> $i.imput.sh
	echo "python ./fiter_impfile_DR2.py ./chr${i}.imp.vcf.gz chr${i}.imp_DR2.vcf" >> $i.imput.sh
	echo "bgzip -f chr${i}.imp_DR2.vcf > chr${i}.imp_DR2.vcf.gz" >> $i.imput.sh
	echo "java -Xmx100g -Xss128m -jar \$beagle gt=chr${i}.imp_DR2.vcf.gz out=chr${i}.imp.phase gprobs=true niterations=10 nthreads=48 " >> $i.imput.sh
done
