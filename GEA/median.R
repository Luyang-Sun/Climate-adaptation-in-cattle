# 从命令行参数中获取文件路径和输出文件路径
args <- commandArgs(trailingOnly = TRUE)

# 确保提供了足够的文件路径参数
if (length(args) < 4) {
  stop("请提供三个输入文件路径和一个输出文件路径: file1.txt, file2.txt, file3.txt, output.txt")
}

# 获取文件路径
file1 <- args[1]
file2 <- args[2]
file3 <- args[3]
output_file <- args[4]

# 读取文件
data1 <- read.table(file1, header = TRUE)
data2 <- read.table(file2, header = TRUE)
data3 <- read.table(file3, header = TRUE)

# 合并三个文件的数据
data_merged <- merge(data1, data2, by = c("COVARIABLE", "MRK"), suffixes = c("_1", "_2"))
data_merged <- merge(data_merged, data3, by = c("COVARIABLE", "MRK"))

# 处理 NA 值，避免中位数为 NA
data_merged$BF_median <- apply(data_merged, 1, function(row) {
 bf_values <- c(row["BF.dB._1"], row["BF.dB._2"], row["BF.dB."])
  # 打印每行的 BF(dB) 值，以帮助调试
  print(bf_values)  # 可选，用于调试
  median(bf_values, na.rm = TRUE)  # 计算中位数，忽略 NA 值
})

# 显示结果
print(data_merged[, c("COVARIABLE", "MRK", "BF_median")])

# 将结果保存到指定的输出文件路径
write.table(data_merged[, c("COVARIABLE", "MRK", "BF_median")], output_file, row.names = FALSE, quote = FALSE)

