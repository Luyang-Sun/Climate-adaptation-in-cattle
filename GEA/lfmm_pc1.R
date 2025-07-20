library(lfmm)

# Get input file and output PDF paths from command line arguments
input_file <- commandArgs(trailingOnly = TRUE)[1]
output_pdf <- commandArgs(trailingOnly = TRUE)[2]

# Read data file
Y <- read.table(input_file, header = TRUE)
Y <- Y[, -c(1:6)]  # Remove first 6 columns

# Perform principal component analysis
pc <- prcomp(Y)

# Set up PDF output
pdf(output_pdf, width = 10, height = 10)

# Plot principal components
plot(pc$sdev[1:20]^2, xlab = 'PC', ylab = "Variance explained")
points(6, pc$sdev[6]^2, type = "h", lwd = 3, col = "blue")

# Close PDF device
dev.off()
