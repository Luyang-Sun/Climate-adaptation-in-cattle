library(lfmm)

# Get input and output file paths from command line arguments
input_file <- commandArgs(trailingOnly = TRUE)[1]        # Input genotype data file
input_keep_file <- commandArgs(trailingOnly = TRUE)[2]   # Input covariate file 
output_gif_file <- commandArgs(trailingOnly = TRUE)[3]   # Output file for GIF-corrected p-values
output_mad_file <- commandArgs(trailingOnly = TRUE)[4]   # Output file for MAD-corrected p-values

# Read genotype data file
Y <- read.table(input_file, header = TRUE)
Y <- Y[,-c(1:6)]  # Remove first 6 columns (non-genotype metadata)

# Read covariate data file 
X <- read.csv(input_keep_file, header = F, stringsAsFactors = F)

# Perform LFMM ridge regression with K=6 latent factors
mod.lfmm <- lfmm_ridge(Y = Y, X = X, K = 6)

# Calculate calibrated p-values using GIF method
pv_gif <- lfmm_test(Y = Y, 
                    X = X, 
                    lfmm = mod.lfmm, 
                    calibrate = "gif")
pvalues_gif <- pv_gif$calibrated.pvalue

# (Commented out) Calculate calibrated p-values using median+MAD method
#pv_mad <- lfmm_test(Y = Y, 
#                    X = X, 
#                    lfmm = mod.lfmm, 
#                    calibrate = "median+MAD")
#pvalues_mad <- pv_mad$calibrated.pvalue

# Save GIF-corrected p-values to output file
write.table(pvalues_gif, 
            file = output_gif_file, 
            col.names = F, 
            row.names = T, 
            quote = F, 
            sep = "\t")

# (Commented out) Save MAD-corrected p-values to output file
#write.table(pvalues_mad, 
#            file = output_mad_file, 
#            col.names = F, 
#            row.names = T, 
#            quote = F, 
#            sep = "\t")