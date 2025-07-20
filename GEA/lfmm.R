library(lfmm)
# 从命令行获取输入文件和输出PDF文件路径
input_file <- commandArgs(trailingOnly = TRUE)[1]
input_keep_file <- commandArgs(trailingOnly = TRUE)[2]
output_gif_file <- commandArgs(trailingOnly = TRUE)[3]
output_mad_file <- commandArgs(trailingOnly = TRUE)[4]
# 读取数据文件
Y <- read.table(input_file, header = TRUE)
#Y <- fread("/storage/public/home/2019050383/03.GWAS/15.GEA/phase.raw/8.imp.phase.hwe.raw", header = T)
Y <- Y[,-c(1:6)]  # 去除前6列

# 循环处理多个协变量集
#for (i in 3:114) {
  # 读取协变量数据
 # X <- read.csv(paste("/storage/public/home/2019050383/03.GWAS/15.GEA/keep/keep-", i, ".txt", sep=""), header = F, stringsAsFactors = F)
X <- read.csv(input_keep_file, header = F, stringsAsFactors = F)
  # 进行lfmm回归分析
  mod.lfmm <- lfmm_ridge(Y = Y, X = X, K = 6)

  # 使用"gif"方法进行p值校正
  pv_gif <- lfmm_test(Y = Y, 
                      X = X, 
                      lfmm = mod.lfmm, 
                      calibrate = "gif")
  pvalues_gif <- pv_gif$calibrated.pvalue
  
  # 使用"median+MAD"方法进行p值校正
  pv_mad <- lfmm_test(Y = Y, 
                      X = X, 
                      lfmm = mod.lfmm, 
                      calibrate = "median+MAD")
  pvalues_mad <- pv_mad$calibrated.pvalue
  
  # 将p值写入文件
#  write.table(pvalues_gif, paste("/storage/public/home/2019050383/03.GWAS/15.GEA/lfmm/",i,"_gif.txt", sep=""), col.names = F, row.names = T, quote = F, sep = "\t")
 write.table(pvalues_gif, paste(output_gif_file, col.names = F, row.names = T, quote = F, sep = "\t") 
#  write.table(pvalues_mad, paste("/storage/public/home/2019050383/03.GWAS/15.GEA/lfmm/",i,"_mad.txt", sep=""), col.names = F, row.names = T, quote = F, sep = "\t")
 write.table(pvalues_mad, paste(output_mad_file, col.names = F, row.names = T, quote = F, sep = "\t") 
#}

