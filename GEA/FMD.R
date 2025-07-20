 #source the baypass R functions (check PATH)
source("/storage/public/home/2019050383/Software/baypass_public-master/utils/baypass_utils.R")
args <- commandArgs(trailingOnly = TRUE)

omega_file <- args[1]  
file <- args[2]
out_file <- args[3]
om.bta <- as.matrix(read.table(omega_file, header = F))
#create a dummy diagonal covariance matrix
#this might be obtained from a star-shaped phylogeny with
#branch length (Fst) equal to 0.1
#star.bta<-diag(0.1,nrow(om.bta))
star.bta<- as.matrix(read.table(file, header = F))
#compute the fmd.dist between the two matrices
fmd_value <- fmd.dist(om.bta,star.bta)   
#  FMD Distance
cat("FMD Distance:", fmd_value, "\n")

write.table(fmd_value, file = out_file, row.names = FALSE, col.names = FALSE)
