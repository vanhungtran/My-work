
setwd("C:/Users/vhtran/Google Drive/these/Figure")

#set wd
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
library(gclus)


G <- read.table("G_RROP2",quote="\"") # old is G1
G=as.matrix(G)

G1 <- read.table("G_sad.txt",quote="\"") #old is G
G1=as.matrix(G1)

G=cov2cor(G)
G1=cov2cor(G1)
b1 <-G
b2 <- G1
b12 <- lowerUpper(b1,b2)


colnames(b12) <- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
rownames(b12)<- c("wk 1","wk 2","wk 3","wk 4","wk 5","wk 6","wk 7","wk 8","wk 9","wk 10")
#cor.plot(b12)

b13=b12
diag(b13)<-NA
# corrplot(t(b13), method = "circle")
# 
# 
# 
# 
# 
# 
# 
# 
# 
# 
# cor.plot(t(b13),numbers=TRUE)
# 
# 






diag(b13)<-0


#png(file="corr1509.png",width=2000,height=1500,res=200)


corrplot(b13, method="circle", tl.pos="lt",       
         tl.col="black", tl.cex=1.6, tl.srt=45, addshade="positive",type="full",diag= FALSE,
         addCoef.col="black", #addCoefasPercent = TRUE,
         #addshade="positive",
         #addgrid.col=FALSE,
         #addCoef.col = rgb(0,0,0, alpha =0.6),
         
         number.cex=1.4,

         
         sig.level=0.50, insig = "blank")  


text(-1.3, y = 4, labels = "RR-OP",offset = 1, 
     cex = 2, col = "red")
text(12, y = 8, labels = "SAD",offset = 1, 
     cex = 2, col = "red")




#dev.off()









diff12 <- lowerUpper(b1,b2,diff=TRUE)

cor.plot(t(diff12),numbers=TRUE)


corrplot(t(b13), method = "circle")


text(7, y = 8, labels = "RR",offset = 1, 
     cex = 2, col = "red")
text(2, y = 2, labels = "SAD",offset = 1, 
     cex = 2, col = "red")

















library(plotrix)
correlation=c(0.9,0.95,0.97,0.99)
performance=c(0.68,0.74,0.76,0.86)
pyramid.plot(correlation,performance, 
             labels=c("SAD15","SAD16","SAD17","SAD18")
)

period=c("wk1-5","wk1-6","wk1-7","wk1-8")
# Grouped Bar Plot
counts <- table( performance,period)
barplot(counts, main="Car Distribution by Gears and VS",
        xlab="Number of Gears", col=c("darkblue","red"),
        legend = rownames(counts), beside=TRUE)

z=data.frame(period,correlation,performance)

y=as.matrix(sapply(z, as.numeric))
barplot(y, <strong>beside=T</strong>, main="Rainfall in 2013-14", col=c("blue","red"))






library(corrplot)
png(height=1200, width=1200, file="overlap.png")
col1 <-rainbow(100, s = 1, v = 1, start = 0, end = 0.9, alpha = 1)
test <- matrix(data=col1(20:60),nrow=7,ncol=7)
corrplot(test,tl.cex=3,title="Overlaps Between methods",
         method="circle",is.corr=FALSE,type="full",
         cl.lim=c(10,100),cl.cex=2,addgrid.col=
           "red",addshade="positive",col=col1, addCoef.col = rgb(0,0,0, alpha =
                                                                   0.6),diag= FALSE) 
dev.off()








