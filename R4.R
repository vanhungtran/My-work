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
library(weights)
library(wCorr)

pheno <- read.table("DATA_corrected.txt", header=TRUE, quote="\"")

#l==1 , corrected missing phenotype,l==2 corrected phenotypes


pheno %>%
  group_by(week) %>%
  summarize(COR=cor(y_RR,y_RRH,method="spearman"))

pheno=arrange(pheno,gener,animal)

pheno$cd=as.numeric(pheno$gener)


pheno=subset(pheno,pheno$cd>=6)



#Here ,if RFI+ put "+" else "-"

pheno=subset(pheno,lignee=="+")


sln <- read.table("sln_RRHp",quote="\"") 





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
#mydf4= mydata_all1 # SS _predict G7
#mydf3= mydata_all1 # ss single step all
#mydf2= mydata_all1  # predict G7 A
#mydf1= mydata_all1  # A (all animals)

# mydf1$EBVp = mydf2$EBV
# mydf1$EBVss= mydf3$EBV
# mydf1$EBVssp= mydf4$EBV
 

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


for (i in (1:10)){
  
  ll =subset(mydf3H, week == i)
  #out = with(ll,wtd.cor(EBV,y_RRH,w))/sqrt(h2_RRH[i])
  out = with(ll,wtd.cor(EBV,y_RRH,w))
  cat("----week----",i,"------", '\n')
  print(var(ll$EBV))
  # print(out/sqrt(h2_RRH[i]) )
  
}


mydf3H1=aggregate(mydf3H1,list(mydf3H1$animal,mydf3H1$week),tail,1)
 mydf3H1$y_RR=aggregate(mydf3H$y_RR,list(mydf3H$animal,mydf3H$week),mean)[,3]
 mydf3H1$y_RRH=aggregate(mydf3H$y_RRH,list(mydf3H$animal,mydf3H$week),mean)[,3]

mydf3H=mydf3H1






# with(mydf3H,lm(y_RRH~EBV))


with(mydf3H,lm(y_RRH~EBV,weight=w))


 
#  mydf3H %>%
#    group_by(week) %>%
#   summarize(COR=cor(y_RRH,EBV,method="pearson"))
# 
# 
# mydf3H %>%  
#   summarize(COR=cor(y_RRH,EBV,method="pearson"))

mydf3H %>%
  group_by(week) %>%
  summarize(COR=weightedCorr(EBV,y_RRH,method="pearson",w))

mydf3H %>%
  #group_by(week) %>%
  summarize(COR=weightedCorr(EBV,y_RRH,method="pearson",w))

with(mydf3H,wtd.cor(EBV,y_RRH,w))




summary(with(mydf3H,lm(y_RRH~EBV,weight=w)))

# 
# h2_RRH = c( 0.4470476 ,0.4002327, 0.2758607, 0.2486211, 0.2523407, 0.2417117 ,0.2905586,
#              0.2898197, 0.2390147, 0.1839432)
h2_RRH = c(0.4001438 ,0.3927265, 0.3343047, 0.3675312, 0.3956908, 0.3402111, 0.3981840
, 0.3947751, 0.3641717 ,0.3625449)


a <- h2_RRH
b <- h2_RRH*10/(4+9*h2_RRH)
c<-(a+b-2*a*b)/(1-a*b)






for (i in (1:10)){
  
  ll =subset(mydf3H, week == i)
  out = with(ll,wtd.cor(EBV,y_RRH,w))/sqrt(c[i])
  #out = with(ll,wtd.cor(EBV,y_RRH,w))
  cat("----week----",i,"------", '\n')
  print(out)
 # print(out/sqrt(h2_RRH[i]) )
  
}




for (i in (1:10)){
  
  mydf4H=subset(mydf3H,week==i)
  out = summary(with(mydf4H,lm(y_RRH~EBV,weight=w)))$coefficients 
  
  
  
  cat("----week----",i,"------", '\n')
  print (out[2,1]-0.5)
  print(out[2,])
  
}





mydf3H$GEBV = mydf3H$EBV
library(lattice)
mydf3H$week=  paste0("w ",mydf3H$week)
xyplot(y_RRH~GEBV|as.factor(week), data = mydf3H, type = c("p","r"), auto.key = TRUE)


 
