###################################################################
# File Name: cmd.sh
# Author: Fuwen Wang
# mail: wangfuwen2016@nwafu.edu.cn
# Created Time: Wed 16 Aug 2023 06:38:15 PM CST
#=============================================================
#!/bin/bash
#les 731fst.matrix|sed '1d' | sed -E 's/^ +//; s/ +/ /g' > pca.fst
Rscript pca_fst_heatmap.R pca.fst XNpca.fst.pdf
