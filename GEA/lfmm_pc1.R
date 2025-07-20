library(lfmm)
# 从命令行获取输入文件和输出PDF文件路径
input_file <- commandArgs(trailingOnly = TRUE)[1]
output_pdf <- commandArgs(trailingOnly = TRUE)[2]

# 读取数据文件
Y <- read.table(input_file, header = TRUE)
Y <- Y[, -c(1:6)]

# 主成分分析
pc <- prcomp(Y)

# 设置PDF输出
pdf(output_pdf, width = 10, height = 10)

# 绘制主成分图
plot(pc$sdev[1:20]^2, xlab = 'PC', ylab = "Variance explained")
points(6, pc$sdev[6]^2, type = "h", lwd = 3, col = "blue")

# 关闭PDF设备
dev.off()

