# Load required libraries
library(data.table)
library(CMplot)

# Read command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Parse command line arguments
input_file <- args[1]     # Input data file
man_output <- args[2]     # Output file for Manhattan plot  
qq_output <- args[3]      # Output file for QQ plot

# Read input data
a <- fread(input_file, header = F)

# Generate Manhattan plot
CMplot(a, plot.type = "m", LOG10 = TRUE, threshold = c(1.55e-9), threshold.col = c("red"),
       col = c("grey", "skyblue"), signal.col = NULL, amplify = FALSE, highlight = NULL, 
       chr.den.col = NULL, file = "png", 
       dpi = 300, file.output = TRUE, verbose = TRUE, file.name = man_output)

# Generate QQ plot
CMplot(a, plot.type = "q", conf.int.col = NULL, box = TRUE, file = "png", dpi = 300, file.output = TRUE, 
       verbose = FALSE, main = "QQ-plot", file.name = qq_output)

