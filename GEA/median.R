# Get file paths from command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Verify that sufficient file path arguments were provided
if (length(args) < 4) {
  stop("Please provide three input file paths and one output file path: file1.txt, file2.txt, file3.txt, output.txt")
}

# Extract file paths from arguments
file1 <- args[1]  # First input file path
file2 <- args[2]  # Second input file path 
file3 <- args[3]  # Third input file path
output_file <- args[4]  # Output file path

# Read input files
data1 <- read.table(file1, header = TRUE)  # Read first input file
data2 <- read.table(file2, header = TRUE)  # Read second input file
data3 <- read.table(file3, header = TRUE)  # Read third input file

# Merge the three data files by COVARIABLE and MRK columns
data_merged <- merge(data1, data2, by = c("COVARIABLE", "MRK"), suffixes = c("_1", "_2"))
data_merged <- merge(data_merged, data3, by = c("COVARIABLE", "MRK"))

# Calculate median BF values while handling NA values
data_merged$BF_median <- apply(data_merged, 1, function(row) {
  # Extract BF.dB values from each source
  bf_values <- c(row["BF.dB._1"], row["BF.dB._2"], row["BF.dB."])
  
  # Print BF values for debugging (optional)
  print(bf_values)  
  
  # Calculate median while ignoring NA values
  median(bf_values, na.rm = TRUE)  
})

# Display results (COVARIABLE, MRK and calculated median)
print(data_merged[, c("COVARIABLE", "MRK", "BF_median")])

# Save results to output file
write.table(data_merged[, c("COVARIABLE", "MRK", "BF_median")], 
            output_file, 
            row.names = FALSE, 
            quote = FALSE)