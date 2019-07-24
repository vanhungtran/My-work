#set wd
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




set.seed(1)


#############################################################################

mydata <- read.table("datapredictT21.txt",quote="\"") 
names(mydata)[1]<-"animal"  
names(mydata)[2]<-"identif" 
names(mydata)[3]<-"bande"  
names(mydata)[4]<-"sexe"  
names(mydata)[5]<-"lignee"  
names(mydata)[6]<-"gener"  
names(mydata)[7]<-"loge"  
names(mydata)[8]<-"eleve"  
names(mydata)[9]<- "pds_dc"  
names(mydata)[10]<-"pds_fc"  
names(mydata)[11]<-"age"  
names(mydata)[12]<-"poidsheb"  
names(mydata)[13]<-"poidpre2"  
names(mydata)[14]<-"age_dc"  
names(mydata)[15]<-"temps"  
names(mydata)[16]<-"FI"     
names(mydata)[17]<-"ADGv"  
names(mydata)[18]<-"FCRv"  
names(mydata)[19]<-"ADGg"  
names(mydata)[20]<-"FCRg"  
names(mydata)[21]<-"semaine"  
names(mydata)[22]<-"FCRnew" 
names(mydata)[23]<-"Nk"  


library(lattice)
mydata$week=mydata$semaine-3
mydata$FCR=ifelse(mydata$FCRv>3.5,NA,mydata$FCRv)
mydata$FCR=ifelse(mydata$FCR<1.5,NA,mydata$FCR)
xyplot(FCR~week,groups=animal,data=mydata, type='l',
       xlab=list(label="week", cex=1.5),
       ylab=list(label="Feed conversion ratio", cex=1.5),
       
      
       )



