
setwd("C:/Users/tranh/Google Drive/these/ADG/figure")
#save data
#save.image(file="18012017.RData")
#remove object
#rm(list=ls())
######################################################################################
#required packages
library(corrplot)
library(psych)
library(plyr)
library(stringr)
library(kml)
library(kml3d)
library(reshape)
library(SDMTools)
library(fmsb)
library(dplyr)
library(lsa)



ADG_mtA <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/ADG_mtA.txt", quote="\"", comment.char="")
ADG_mtH <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/ADG_mtH.txt", quote="\"", comment.char="")


ADG_mtA=as.matrix(ADG_mtA)
ADG_mtH=as.matrix(ADG_mtH)


GMT=lowerUpper(ADG_mtA,ADG_mtH)

colnames(GMT) <- c("wk 1-3","wk 4-5","wk 6-7","wk 8-10")
rownames(GMT)<- c("wk 1-3","wk 4-5","wk 6-7","wk 8-10")



corrplot(GMT, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=2,diag= FALSE,
        sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")

text(0, y = 1.5, labels = "A",offset = 1, 
     cex = 3, col = "red")
text(5, y = 3.5, labels = "H",offset = 1, 
     cex = 3, col = "red")

text(3, y = 5, labels = "MT",offset = 1, 
     cex = 3, col = "black")





ADG_RR <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/ADG_RR.txt", quote="\"", comment.char="")


ADG_RRA=as.matrix(ADG_RR[1:10,])
ADG_RRH=as.matrix(ADG_RR[11:20,])


GRR=lowerUpper(ADG_RRA,ADG_RRH)

colnames(GRR) <- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
rownames(GRR)<- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")


corrplot(GRR, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=1.4,diag= FALSE,
         sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")

text(-0.5, y = 1.5, labels = "A",offset = 1, 
     cex = 2, col = "red")
text(11.5, y = 9, labels = "H",offset = 1, 
     cex = 2, col = "red")

text(5, y = 11.5, labels = "RR",offset = 1, 
     cex = 2, col = "black")




ADG_SAD <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/ADG_SAD.txt", quote="\"", comment.char="")


ADG_SADA=as.matrix(ADG_SAD[1:10,])
ADG_SADH=as.matrix(ADG_SAD[11:20,])


GSAD=lowerUpper(ADG_SADA,ADG_SADH)

colnames(GSAD) <- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
rownames(GSAD)<- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")


corrplot(GSAD, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=1.4,diag= FALSE,
         sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")

text(-0.5, y = 1.5, labels = "A",offset = 1, 
     cex = 2, col = "red")
text(11.5, y = 9, labels = "H",offset = 1, 
     cex = 2, col = "red")

text(5, y = 11.5, labels = "SAD",offset = 1, 
     cex = 2, col = "black")










######################################################################################################################################


RFI_mtA <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/RFI_mtA.txt", quote="\"", comment.char="")


RFI_mtH <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/RFI_mtH.txt", quote="\"", comment.char="")


RFI_mtA=as.matrix(RFI_mtA)
RFI_mtH=as.matrix(RFI_mtH)


GMT=lowerUpper(RFI_mtA,RFI_mtH)

colnames(GMT) <- c("wk 1-3","wk 4-5","wk 6-7","wk 8-10")
rownames(GMT)<- c("wk 1-3","wk 4-5","wk 6-7","wk 8-10")



corrplot(GMT, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=2,diag= FALSE,
         sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")

text(0, y = 1.5, labels = "A",offset = 1, 
     cex = 3, col = "red")
text(5, y = 3.5, labels = "H",offset = 1, 
     cex = 3, col = "red")

text(3, y = 5, labels = "MT",offset = 1, 
     cex = 3, col = "black")






RFI_RR <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/RFI_RR.txt", quote="\"", comment.char="")





RFI_RRA=as.matrix(RFI_RR[1:10,])
RFI_RRH=as.matrix(RFI_RR[11:20,])


GRR=lowerUpper(RFI_RRA,RFI_RRH)

colnames(GRR) <- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
rownames(GRR)<- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")


corrplot(GRR, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=1.4,diag= FALSE,
         sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")

text(-0.5, y = 1.5, labels = "A",offset = 1, 
     cex = 2, col = "red")
text(11.5, y = 9, labels = "H",offset = 1, 
     cex = 2, col = "red")

text(5, y = 11.5, labels = "RR",offset = 1, 
     cex = 2, col = "black")




RFI_SAD <- read.table("C:/Users/tranh/Google Drive/these/ADG/figure/RFI_SAD.txt", quote="\"", comment.char="")


RFI_SADA=as.matrix(RFI_SAD[1:10,])
RFI_SADH=as.matrix(RFI_SAD[11:20,])


GSAD=lowerUpper(RFI_SADA,RFI_SADH)

colnames(GSAD) <- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
rownames(GSAD)<- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")


corrplot(GSAD, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=1.4,diag= FALSE,
         sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")

text(-0.5, y = 1.5, labels = "A",offset = 1, 
     cex = 2, col = "red")
text(11.5, y = 9, labels = "H",offset = 1, 
     cex = 2, col = "red")

text(5, y = 11.5, labels = "SAD",offset = 1, 
     cex = 2, col = "black")






