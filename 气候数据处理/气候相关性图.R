install.packages("RColorBrewer")
library(RColorBrewer)
library(ggcorrplot)
library(corrplot)
library(viridis)
x
options(stringsAsFactors=F)# R中环境变量设置，防止字符型变量转换为因子#读入环境因子数据表
ENV2=read.csv("clipboard",header = T,row.names = 1,sep = "\t",comment.char = "",stringsAsFactors = F,colClasses = c(rep("character",1),rep("numeric",28)))
head(ENV2) # 查看数据前几行
dim(ENV) # 查看数据行、列数
str(ENV) # 查看数据表每列的数据形式
# 解决数据中存在ties的警告，选用"pearson"fan方法计算相关性系数，不用运行此命令
ENV1[2:113] = rank(ENV[2:113], ties.method = "random") # 使用 "kendall"或 "spearman"方法计算相关性系数，可能会遇到此报错
# 环境因子相关性分析，根据自己的数据选择相关性计算方法："pearson", "kendall", or "spearman"
env.cor <- round(cor(ENV2[1:28], method = "spearman"),3) # round(),对输出结果取小数点前三位
env.cor

# 使用ggcorrplot包的cor_pmat函数计算相关性p值，图2
env.g1 <-round(cor_pmat(ENV2[1:28],method = "spearman"),3)
env.P 
# 绘制相关性热图
?corrplot # 查看各参数含义
env.cor<-as.matrix(read.table("clipboard",header = T) )
c1=viridis(10, alpha = 1, begin = 0, end = 1, direction = 1,option = "F"); c1
cor.plot<-corrplot(corr =env.cor,type="upper", method="number", tl.pos="tp",tl.col="black", col=c1,insig = "label_sig", sig.level = c(.01, .05),pch.cex=1,pch.col =brewer.pal(11,"RdYlGn")[11:2],order = "FPC")
cor.plot<-corrplot(corr = env.cor,type="lower", method="number",add=TRUE,p.mat = env.p,insig = "label_sig",
                   tl.pos="n",tl.col="black",
                   col=c1,tl.cex=1.2,diag=FALSE, cl.pos="n",pch.col =brewer.pal(11,"RdYlGn")[11:2],
                   number.cex = 0.8,order = "FPC")
cor.plot<-corrplot(corr = env.cor,type="lower",add=TRUE,method="pie",p.mat = env.p,insig = "label_sig", sig.level = c(.01, .05),
                   tl.pos="n",tl.col="black",
                   col="black",tl.cex=1.2,diag=FALSE, cl.pos="n",pch.col = "black",number.digits =3 ,
                   number.cex = 0.6,order = "FPC")
   nameMat <-c("STR-MIN","tmin-2m-distance","tmin-2m-distance","STR-MIN") # 设置矩形框的左、下、右和上侧的变量名称，即从左侧逆时针设置位置参数。

if(getRversion() >= "4.1.0"){
  cor.plot<-corrplot(corr =env.cor,type="upper",tl.pos="tp",tl.col="black", col=brewer.pal(11,"RdYlGn")[11:2],insig = "label_sig", sig.level = c(.01, .05),pch.cex=1,pch.col =brewer.pal(11,"RdYlGn")[11:2])#,order = "FPC"
  cor.plot<-corrplot(corr = env.cor,type="lower",add=TRUE,method="color",
                     tl.pos="n",tl.col="black",
                     col=brewer.pal(11,"RdYlGn")[11:2],tl.cex=1.2,diag=FALSE, cl.pos="n",pch.col =brewer.pal(11,"RdYlGn")[11:2],
                     number.cex = 0.8)#,order = "FPC" |> 
    corrRect(namesMat = nameMat,col = "red") 
}
library(corrplot)
corrplot(aaa, method="circle")
corrplot(aaa, method="pie",type="upper",order = "FPC",tl.pos="tp",tl.col="black", col=c1,insig = "label_sig", sig.level = c(.01, .05),pch.cex=1,pch.col =brewer.pal(11,"RdYlGn")[11:2])
corrplot(env.cor, method="number",type="lower",order = "FPC",tl.pos="tp",tl.col="black", col=c1,insig = "label_sig", sig.level = c(.01, .05),pch.cex=1,pch.col =brewer.pal(11,"RdYlGn")[11:2])
corrplot(env.cor, method="color")

corrplot(env.cor, type="upper")
corrplot(env.cor, type="lower")
#colors = c("#6D9EC1", "white", "#E46726")
#colors<- colorRampPalette(c("green", "white", "red"))
#corrplot(env.cor, type="upper", order="hclust",
#         col=brewer.pal(n=10, name="RdBu"))
#corrplot(env.cor, type="upper", order="hclust",
#         col=brewer.pal(11,"RdYlGn")[11:2])
res <- abs(env.cor)
cor.plot<-corrplot(corr =result,type="upper", method="pie", tl.pos="tp",tl.col="black", col=c1,insig = "label_sig", sig.level = c(.01, .05),pch.cex=1,pch.col =brewer.pal(20,"RdYlGn")[2:11],order = "FPC",col.lim =c(0,1))
cor.plot<-corrplot(corr =result,type="lower", method="number",add=TRUE,
                   tl.pos="n",tl.col="black",
                   col=c1,tl.cex=1.2,diag=FALSE, cl.pos="n",pch.col =brewer.pal(11,"RdYlGn")[11:2],
                   number.cex = 0.55,order = "FPC",col.lim =c(0,1))
cor.plot<-corrplot(corr = aaa,type="lower",add=TRUE,method="pie",p.mat = env.p,insig = "pch", sig.level = c(.01, .05),
                   tl.pos="n",tl.col="black",
                   col="black",tl.cex=1.2,diag=FALSE, cl.pos="n",pch.col = "black",number.digits =3 ,
                   number.cex = 0.6,order = "FPC")

#xintu
corrplot(corr =res,type="upper", method="pie", tl.pos="tp",tl.col="black", col=colorRampPalette(c("blue","green","#faeee3", "#ef3a50","#2c1c36"))(500),insig = "label_sig", sig.level = c(.01, .05),pch.cex=1,order = "FPC",col.lim =c(0,1))
cor.plot<-corrplot(corr =res,type="lower", method="number",add=TRUE,
                                tl.pos="n",tl.col="black",
                                      col=colorRampPalette(c("blue","green","#faeee3", "#ef3a50","#2c1c36"))(1000),tl.cex=1.2,diag=FALSE, cl.pos="n",pch.col =brewer.pal(11,"RdYlGn")[11:2],
                                      number.cex = 0.55,order = "FPC",col.lim =c(0,1))


