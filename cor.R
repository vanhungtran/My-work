
setwd("C:/Users/vhtran/Google Drive/these/sujet2")
library(plyr)

library(corrplot)
FCRm <- spl_corG <- read.table("C:/Users/vhtran/Google Drive/these/sujet2/spl_corG.txt", quote="\"")

length(FCRm$V1)/10
FCRm$n = rep(1:10,length(FCRm$V1)/10)
FCRm =arrange(FCRm,n)

FCRm = aggregate(FCRm[,1:10], list(FCRm$n), mean)
FCRm=round(FCRm, 4)
a=FCRm[,2:11]

a1 <- as.matrix(a)
a2 <- matrix(a1, ncol = ncol(a1), dimnames = NULL)

a2[lower.tri(a2)]<-NA

print(a2,na.print = "")


corrplot(a1, type="upper")

#corrplot.mixed(a1, title='matrix correlation variances')







a<- read.table("C:/Users/tranh/Google Drive/these/sujet2/G_test.txt", quote="\"")
colnames(a2) <- c("wk1","wk2","wk3","wk4","wk5","wk6","wk7","wk8","wk9","wk10")



corrplot(a2, method="circle", tl.pos="lt",       
         tl.col="black", tl.cex=1.2, tl.srt=45, addshade="positive",type="full",diag= FALSE,
         addCoef.col="black", addCoefasPercent = TRUE,
         #addshade="positive",
         #addgrid.col=FALSE,
         #addCoef.col = rgb(0,0,0, alpha =0.6),
         
         sig.level=0.50, insig = "blank")  


