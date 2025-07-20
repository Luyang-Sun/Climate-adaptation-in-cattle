library(data.table)
library(CMplot)

# 读取命令行参数
args <- commandArgs(trailingOnly = TRUE)

# 获取命令行传入的参数
input_file <- args[1]     # 输入文件
man_output <- args[2]     # Manhattan 图的输出文件
qq_output <- args[3]      # QQ 图的输出文件

# 读取输入数据
a <- fread(input_file, header = T)

# 绘制 Manhattan 图
CMplot(a, plot.type = "m", LOG10 = TRUE, threshold = c(2.94e-9), threshold.col = c("red"),
       col = c("grey", "skyblue"), signal.col = NULL, amplify = FALSE, highlight = NULL, 
       chr.den.col = NULL, file = "png", 
       dpi = 300, file.output = TRUE, verbose = TRUE, file.name = man_output)
# 绘制 QQ 图
CMplot(a, plot.type = "q", conf.int.col = NULL, box = TRUE, file = "png", dpi = 300, file.output = TRUE, 
       verbose = FALSE, main = "QQ-plot", file.name = qq_output)

