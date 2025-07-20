# heatmap_script.R

library(pheatmap)

input_file <- commandArgs(trailingOnly = TRUE)[1]
output_pdf <- commandArgs(trailingOnly = TRUE)[2]

data <- read.table(input_file, header = FALSE, row.names = 1, check.names = FALSE, sep = "")
data <- as.matrix(data)
data[data < 0] <- 0
colnames(data) <- rownames(data)

# Set up PDF output
pdf(output_pdf, width = 10, height = 10)

pheatmap(data, fontsize = 6,
         color = colorRampPalette(c("#3882B9", "#F8FAB3", "#CD374D"))(100),
         cluster_rows = TRUE, cluster_cols = TRUE,
         show_colnames = TRUE, legend = TRUE,
         show_rownames = TRUE,
         scale = "none", fontsize_row = 10, fontsize_col = 10, display_numbers = TRUE)

# Close PDF device
dev.off()
