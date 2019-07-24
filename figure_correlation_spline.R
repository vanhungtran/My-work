
setwd("C:/Users/tranh/Google Drive/these/sujet2")
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





G1 <- read.table("G_PL.txt",quote="\"") # old is G1
G1=as.matrix(G1)
###############################
#matrix G of SAD
G <- read.table("E_PL.txt",quote="\"") #old is G
G=as.matrix(G)


# G=cov2cor(G)
# G1=cov2cor(G1)
b1 <-G
b2 <- G1
b12 <- lowerUpper(b1,b2)


# colnames(b12) <- c("wk4","wk5","wk6","wk7","wk8","wk9","wk10","wk11","wk12","wk13")
# rownames(b12)<- c("wk4","wk5","wk6","wk7","wk8","wk9","wk10","wk11","wk12","wk13")
# #cor.plot(b12)

colnames(b12) <- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
rownames(b12)<- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
#cor.plot(b12)









diag(b12)<-0

# corrplot(b13, method="circle", tl.pos="lt",       
#          tl.col="black", tl.cex=1.3, tl.srt=45, addshade="positive",type="full",diag= FALSE,
#          addCoef.col="black", addCoefasPercent = TRUE,
#          #addshade="positive",
#          #addgrid.col=FALSE,
#          #addCoef.col = rgb(0,0,0, alpha =0.6),
#          
#          sig.level=0.50, insig = "blank")  




corrplot(b12, tl.col = "black", bg = "White", tl.srt = 45, addshade="positive",tl.cex=1.5,diag= FALSE,
         sig.level=0.50, insig = "blank", tl.pos="lt",
         addCoef.col = "black", type = "full")



text(-1, y = 4, labels = "Pe",offset = 1, 
     cex = 2, col = "red")
text(12, y = 8, labels = "G",offset = 1, 
     cex = 2, col = "red")

