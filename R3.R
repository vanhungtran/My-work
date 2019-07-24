
path <- "C:/Users/HP/OneDrive/ADG_all1/"
rm(list = ls())
path=getwd()

setwd(path)

library(corrplot)
library(psych)
library(plyr)
library(stringr)
library(kml)
library(reshape)
library(dplyr)
library(wCorr)
library(weights)

pheno <- read.table("DATA_corrected.txt", header=TRUE, quote="\"")

#l==1 , corrected missing phenotype,l==2 corrected phenotypes

# 
# pheno %>%
#   group_by(week) %>%
#   summarize(COR=cor(y_RR,y_RRH,method="spearman"))

pheno=arrange(pheno,gener,animal)

pheno$cd=as.numeric(pheno$gener)


pheno=subset(pheno,pheno$cd>5)



#Here ,if RFI+ put "+" else "-"

pheno=subset(pheno,lignee=="-")


sln <- read.table("sln_RRAp",quote="\"") 





names(sln)[1]<-"kk"  
names(sln)[2]<-"a"  
names(sln)[3]<-"para"  
names(sln)[4]<-"sdpara"  



a = sln$a
elems <- unlist( strsplit(as.character(a)  , "\\." ) )
m <- as.data.frame(matrix( elems , ncol = 2 , byrow = TRUE ))
sln=cbind(sln,m)
names(sln)<-c("kk","a","para","SE","gr","animal")







sln$para1=ifelse(sln$gr==1,sln$para,0)  
sln$para2=ifelse(sln$gr==2,sln$para,0) 
sln$para3=ifelse(sln$gr==3,sln$para,0)  
sln=arrange(sln,animal,gr)  


# taking all animals 2993


# sln1=merge(sln,my2,by="animal")
sln1=sln

sln1=arrange(sln1,animal,gr)


tatemp <- read.table("OP.txt",quote="\"") 
names(tatemp)[1]<-"week"  
names(tatemp)[2]<-"f1"  
names(tatemp)[3]<-"f2"  
names(tatemp)[4]<-"f3"  

T=t(as.matrix(tatemp[2:4]))

SLN=sln1[,c("animal","gr","para")]
SLN1=arrange(SLN,animal,gr)

SLN2=reshape(SLN1,varying = NULL, timevar = "gr",idvar = "animal",direction="wide",sep="")
SLN3=arrange(SLN2,animal)

SLN4=SLN3[,2:4]

SLN5=as.matrix(SLN4)

SLN5=SLN5

EBV_all=as.data.frame((SLN5)%*%(T))

colnames(EBV_all) <- c("V1","V2","V3","V4","V5","V6",
                       "V7","V8","V9","V10")

EBV_all$animal=SLN2$animal

EBV_all1=melt(EBV_all, id = "animal",measure.vars = c("V1","V2","V3","V4","V5","V6",
                                                      "V7","V8","V9","V10"))
EBV_all2=arrange(EBV_all1,animal,variable)
EBV_all2$EBV=EBV_all2$value

#EBV_all2$week=rep(c(1:10),81)
#EBV_all2$week=rep(c(1:10),2993)
EBV_all2$week=rep(c(1:10),3986)


mydata_all = EBV_all2
mydata_all$week=rep(c(1:10),length(mydata_all$animal)/10)

#mydata_all= merge(EBV_all2,my2,by=c("animal"))

mydata_all1=arrange(mydata_all,animal,week)

filename<-paste("EBV_all",".txt", sep="")  
write.table(mydata_all1,filename)  

#mydf=merge(mydata_all1,pheno3,by=c("animal","week","gener","lignee"))

mydf=merge(mydata_all1,pheno,by=c("animal","week"))
mydf1=arrange(mydf,animal,week)

for (i in (1:10)){
  
  ll =subset(mydf1, week == i )
  
  # out = wtd.cor(ll$EBV,ll$y_RR,ll$w)/sqrt(h2_A[i])
  out = wtd.cor(ll$EBV,ll$y_RR)
  print(var(ll$EBV))
  #print(out)
  # print(out/sqrt(h2_A[i]))
}







 
list_g <- read.table("list", quote="\"")
names(list_g)= c("N","animal") 
# 
 mydf2=merge(mydf1,list_g,c("animal"))
mydf3H=arrange(mydf2,animal,week)

#Here, if calculate for dam, put the below line, else then hide it

#mydf3H=subset(mydf3H,l==1) # if dam

mydf3H1=mydf3H



 mydf3H1=aggregate(mydf3H1,list(mydf3H1$animal,mydf3H1$week),tail,1)
 mydf3H1$y_RR=aggregate(mydf3H$y_RR,list(mydf3H$animal,mydf3H$week),mean)[,3]
 mydf3H1$y_RRH=aggregate(mydf3H$y_RRH,list(mydf3H$animal,mydf3H$week),mean)[,3]

mydf3H=mydf3H1





# 
# with(mydf3H,lm(y_RR~EBV,weight=w))
# 
# 
#  
# mydf3H %>%
#   group_by(week) %>%
#   summarize(COR=weightedCorr(EBV,y_RR,method="pearson",w))
# 
# mydf3H %>%
#   #group_by(week) %>%
#   summarize(COR=weightedCorr(EBV,y_RR,method="pearson",w))
# 
# 





h2_A = c(0.4575742, 0.4126198 ,0.2986740 ,0.2846904 ,0.2932399 ,0.2746641, 0.3154642,
        0.2989615 ,0.2364688, 0.1808632
)

a <- h2_A
b <- h2_A*10/(4+9*h2_A)
c<-(a+b-2*a*b)/(1-a*b)



#sink("RFI_low line.txt")

with(mydf3H,wtd.cor(EBV,y_RR,w))



summary(with(mydf3H,lm(y_RR~EBV,weight=w)))


print(h2_A)

for (i in (1:10)){
  
  ll =subset(mydf3H, week == i)
 out = wtd.cor(ll$EBV,ll$y_RR,ll$w)/sqrt(c[i])
 # out = wtd.cor(ll$EBV,ll$y_RR,ll$w)
  print(out)
 #print(out)
 # print(out/sqrt(h2_A[i]))
}




for (i in (1:10)){
  
  mydf4H=subset(mydf3H,week==i)
  out = summary(with(mydf4H,lm(y_RR~EBV,weight=w)))$coefficients
  
  cat("####################### week ", i)
  print(out[2,1]-0.5)
  print(out[2,])
}

#sink()

# 
# 
# library(wCorr)
# 
# h2_A = c(0.19831238 ,0.12573177, 0.06854276, 0.06487875, 0.07596792, 0.08953578
#  0.09016391, 0.14022587, 0.17514397, 0.23679283)


library(lattice)

mydf3H$week=  reorder(paste0("w_ ",mydf3H$week))
xyplot(y_RR~EBV|as.factor(week), data = mydf3H, type = c("p","r"), auto.key = FALSE)



sigma_A <- c(88.46754836,53.48619989,39.53730065,37.73293991, 41.36938234 ,
             45.92925603 ,49.08109162,50.67792860,52.76036731,59.55260773)


sigma_H <- c(86.66853139,51.97661058,36.37718130,32.63627892, 35.15838092 ,39.98833679,
             44.81114522 ,48.95048136,53.37166998  , 60.67781799 )


K_A = matrix(c( 62.64   ,   0.1253 ,    -0.3624,
                5.284  ,     28.41  ,   -0.4438,
                -7.389  ,    -6.096    ,   6.639),3,3)
K_H <- matrix(c(58.07    ,  0.1482  ,   -0.2798,
                6.032    ,   28.55   ,  -0.5076,
                -4.758    ,  -6.053   ,    4.981),3,3)



diag(K_A)
sln$sigma <- c(rep(diag(K_A), dim(sln)[1]/3))
sln$CD <- round((sln$SE)^2,2)/(sln$sigma)

D1 <- sln %>% select(animal, gr, CD)
D2 <- aggregate(D1[, c(1,3)], list(D1$animal), mean)

D2$animal <- D2$Group.1

D3 <- D2 %>% select(animal, CD)

D4 <- merge(mydf3H[,-1], D3, by = "animal")



mydf3H_test <- aggregate(mydf3H[, c("EBV")], list(mydf3H$animal), var)

mydf3H_test$cd <- ((mydf3H_test$x)^2)/ mean(sigma_A)

