library(lfmm)
# Get input file and output PDF paths from command line arguments
input_file <- commandArgs(trailingOnly = TRUE)[1]
input_keep_file <- commandArgs(trailingOnly = TRUE)[2]
output_gif_file <- commandArgs(trailingOnly = TRUE)[3]
output_mad_file <- commandArgs(trailingOnly = TRUE)[4]

# Read data file
Y <- read.table(input_file, header = TRUE)
#Y <- fread("/storage/public/home/2019050383/03.GWAS/15.GEA/phase.raw/8.imp.phase.raw", header = T)
Y <- Y[,-c(1:6)]  # Remove first 6 columns

# Process multiple covariate sets in loop
#for (i in 3:114) {
  # Read covariate data
  # X <- read.csv(paste("/storage/public/home/2019050383/03.GWAS/15.GEA/keep/keep-", i, ".txt", sep=""), header = F, stringsAsFactors = F)
X <- read.csv(input_keep_file, header = F, stringsAsFactors = F)

  # Perform lfmm regression analysis
  mod.lfmm <- lfmm_ridge(Y = Y, X = X, K = 6)

  # Calculate p-values using "gif" calibration method
  pv_gif <- lfmm_test(Y = Y, 
                      X = X, 
                      lfmm = mod.lfmm, 
                      calibrate = "gif")
  pvalues_gif <- pv_gif$calibrated.pvalue
  
  # Calculate p-values using "median+MAD" calibration method
  pv_mad <- lfmm_test(Y = Y, 
                      X = X, 
                      lfmm = mod.lfmm, 
                      calibrate = "median+MAD")
  pvalues_mad <- pv_mad$calibrated.pvalue
  
  # Write p-values to output files
  # write.table(pvalues_gif, paste("/storage/public/home/2019050383/03.GWAS/15.GEA/lfmm/",i,"_gif.txt", sep=""), col.names = F, row.names = T, quote = F, sep = "\t")
  write.table(pvalues_gif, paste(output_gif_file, col.names = F, row.names = T, quote = F, sep = "\t") 
  
  # write.table(pvalues_mad, paste("/storage/public/home/2019050383/03.GWAS/15.GEA/lfmm/",i,"_mad.txt", sep=""), col.names = F, row.names = T, quote = F, sep = "\t")
  write.table(pvalues_mad, paste(output_mad_file, col.names = F, row.names = T, quote = F, sep = "\t") 
#}
 write.table(pvalues_mad, paste(output_mad_file, col.names = F, row.names = T, quote = F, sep = "\t") 
#}

