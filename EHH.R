install.packages("vcfR")
install.packages("rehh")
install.packages("tidyverse")
library(ggplot2)
library(vcfR)
library(rehh)
library(tidyverse)
ref1 <- data2haplohh(hap_file = "D:/R/GWAS/EHH/HIGH-18.1.vcf",
                    polarize_vcf = FALSE,
                    vcf_reader = "data.table")
ref2 <- data2haplohh(hap_file = "D:/R/GWAS/EHH/708-2-ALPL.vcf",
                     polarize_vcf = FALSE,
                     vcf_reader = "data.table")

target <- data2haplohh(hap_file = "D:/R/GWAS/EHH/LOW-18.1.vcf",
                       polarize_vcf = FALSE,
                       vcf_reader = "data.table")
snp <-"18:14534221"
snp <-"18:14587987"
snp <-"18:14679666"

res_ref1 <- calc_ehhs(ref1,
                     mrk = snp,
                     include_nhaplo = TRUE,
                     discard_integration_at_border = FALSE,
                     include_zero_values = TRUE)
res_ref2 <- calc_ehhs(ref2,
                      mrk = snp,
                      include_nhaplo = TRUE,
                      discard_integration_at_border = FALSE,
                      include_zero_values = TRUE)
#print(res_ref)
res_target <- calc_ehhs(target,
                        mrk = snp,
                        include_nhaplo = TRUE,
                        discard_integration_at_border = FALSE,
                        include_zero_values = TRUE)
print(res_target)
plot(res_ref1)#, nehhs=TRUE)
dev.new()
plot(res_target)#, nehhs= TRUE)
data_ref1 <- res_ref1$ehhs %>%
  mutate(pos = POSITION / 1000000) %>%
  mutate(type = "HIGH")
data_ref2 <- res_ref2$ehhs %>%
  mutate(pos = POSITION / 1000000) %>%
  mutate(type = "EUT")
data_target <- res_target$ehhs %>%
  mutate(pos = POSITION / 1000000) %>%
  mutate(type = "LOW")
data_all <- rbind(data_ref1, data_target)
p <- ggplot(data_all, aes(pos,NEHHS,color=type))+
  geom_line(size=1.0)+
  theme_classic()+
  theme(legend.title = element_blank())+#, legend.position = c(0.75,0.85))+
  scale_color_manual(values = c("blue","red"))+
  labs(x="Position (Mb)", y="EHHS")
print(p)


tar <- data2haplohh(hap_file = "D:/R/GWAS/EHH/hap-5.vcf",
                       polarize_vcf = FALSE,
                       vcf_reader = "data.table")
snp <-"18:14598635"
res_target <- calc_ehhs(target,
                        mrk = snp,
                        include_nhaplo = TRUE,
                        discard_integration_at_border = FALSE,
                        include_zero_values = TRUE)

furcation <- calc_furcation(target,mrk=snp)
ref_furcation <- calc_furcation(ref1,mrk=snp)

plot(furcation,
     xlim=c(14400000,14700000),
     lwd=0.01,
     hap.names=hap.names(target),cex.lab=0.3,
     ann=FALSE)
plot(ref_furcation,
     xlim=c(14400000,14700000),
     lwd=0.01,
     hap.names=hap.names(ref1),cex.lab=0.3,
     ann=FALSE)
house_haplen <- calc_haplen(furcation)
bac_haplen <- calc_haplen(ref_furcation)

# see how haplotype structure differs between our two populations.

plot(house_haplen)
plot(bac_haplen)
