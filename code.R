





setwd("C:/Users/vhtran/Desktop/these/data")
library(dplyr)
library(leaps)
library(lme4)
library(BMA)
library(Amelia)
library(longitudinal)
library(glmmML)
library(pls) 
library(mice)
library(plyr)
library(lattice)
library(psych)
library(growthmodels)
library(foreign)
library(multiplex)

mydata <- read.table("C:/Users/vhtran/Desktop/these/data/mydata.dat", quote="\")
names(mydata)[1]<-"animal"
names(mydata)[2]<-"identif"
names(mydata)[3]<-"bande"
names(mydata)[4]<-"sexe"
names(mydata)[5]<-"lignee"
names(mydata)[6]<-"gener"
names(mydata)[7]<-"loge"
names(mydata)[8]<- "pds_dc"
names(mydata)[9]<-"pds_fc"
names(mydata)[10]<-"eleve"
names(mydata)[11]<-"age_dc"
names(mydata)[12]<-"sem_test"
names(mydata)[13]<-"temps"
names(mydata)[14]<-"consoheb"
names(mydata)[15]<-"FIRST_poidsheb"
names(mydata)[16]<-"poidsheb"
names(mydata)[17]<-"FIRST_age"
names(mydata)[18]<- "age"
names(mydata)[19]<- "consadj"
names(mydata)[20]<-"mean_consoheb"
names(mydata)[21]<-"ADG"
names(mydata)[22]<-"FCR"


mydata$poidsheb=as.numeric(as.character(mydata$poidsheb))

missmap(mydata, main = "Missing values vs observed")


sln <- read.table("C:/Users/vhtran/Desktop/ebv/sln", quote="\"")
sln[1]<-NULL
names(sln)[1]<-"animal"
names(sln)[2]<-"para"
names(sln)[3]<-"sdpara"




tatemp <- read.table("C:/Users/vhtran/Desktop/ebv/temps", quote="\"")
names(tatemp)[1]<-"temps"
names(tatemp)[2]<-"q1"
names(tatemp)[3]<-"q2"
names(tatemp)[2]<-"q3"
names(tatemp)[2]<-"q4"

















new0 = subset(mydata, sexe == 2)
new2 = new0

mimic=function(seta,p,t){
  a1= subset(seta, temps==t)$poidsheb
  
  n1=round(length(a1)*p)
  a11 = sample(a1,n1)
  set1= c(a11, rep(NA,(length(a1)-n1)))
  return(set1)  
}

set2 = mimic(new2,0.96,2)
set3 = mimic(new2,0.003,3)
set4 = mimic(new2,0.003,4)
set5 = mimic(new2,0.068,5)
set6 = mimic(new2,1,3)
set7 = mimic(new2,0.03,7)
set8 = mimic(new2,0.033,8)
set9 = mimic(new2,0.03,9)
set10 = mimic(new2,0.8,10)
set11 = mimic(new2,0.6,11)
set12 = mimic(new2,0.42,12)
set13 = mimic(new2,0.37,13)
set14 = mimic(new2,0.85,14)
set15 = mimic(new2,0.45,15)
set16 = mimic(new2,0.28,16)
set17 = mimic(new2,0.30,17)

set18 = subset(new2,temps == 18)










sampling <- function(x) {
  result1 = NULL
  set.seed(12345)  
  for ( i in 1: length(x$poidsheb)){
    if (x$temps[i] == 2) {
      result <- sample(set2, 1)
    }
    else if (x$temps[i] == 3) {
      result <- sample(set3, 1)
    }
    else if(x$temps[i] == 4) {
      result <- sample(set4, 1)
    }
    else if(x$temps[i] == 5) {
      result <- sample(set5, 1)
    }
    else if(x$temps[i] == 6) {
      result <- sample(set6, 1)
    }
    else if(x$temps[i] == 7) {
      result <- sample(set7, 1)
    }
    else if(x$temps[i] == 8) {
      result <- sample(set8, 1)
    }
    else if(x$temps[i] == 9) {
      result <- sample(set9, 1)
    }
    else if(x$temps[i] == 10) {
      result <- sample(set10, 1)
    }
    else if(x$temps[i] == 11) {
      result <- sample(set11, 1)
    }
    else if(x$temps[i] == 12) {
      result <- sample(set12, 1)
    }
    else if(x$temps[i] == 13) {
      result <- sample(set13, 1)
    }
    else if(x$temps[i] == 14) {
      result <- sample(set14, 1)
    }
    else if(x$temps[i] == 15) {
      result <- sample(set15, 1)
    }
    else if(x$temps[i] == 16) {
      result <- sample(set16, 1)
    }
    else if(x$temps[i] == 17) {
      result <- sample(set17, 1)
    }
    
    
    else {
      result <- sample(set18,1)
    }
    result1 = c(result1, result)
    
  }
  return(result1)
}


new2$mimic = sampling(new2)
new2$mimicpoids=ifelse(is.na(new2$mimic),NA,new2$poidsheb)
new2$mimic <- NULL
newdata1=new2





#creat the mimic data column 

#newdata1$mimicpoids = ifelse(is.na(newdata1$mimicpoids), 9999,newdata1$mimicpoids )
#newdata1$age = ifelse(is.na(newdata$age), 9999,newdata$age )
#newdata$poidsheb = ifelse(is.na(newdata$poidsheb), 9999,newdata$poidsheb )




#library(foreign)
#write.dbf(newdata,"newdata.dbf")




vcc=function(vraie,pred,mimic){
  a1= (vraie-pred)
  a11 = a1*a1
  k1=sum(a11, na.rm=T)
  
  
  a2=(vraie-mean(vraie,na.rm=T))
  a21=a2*a2
  k2=sum(a21, na.rm=T)
  
  
  a3=(pred-mean(pred,na.rm=T))
  a31=a3*a3
  k3=sum(a31, na.rm=T)
  
  a4=(mean(vraie,na.rm=T)-mean(pred,na.rm=T))
  a41=a4*a4
  k4=length(vraie)*a41
  
  
  vcc=1-k1/(k2+k3+k4)
  
  m= sum(is.na(mimic))
  n= length(vraie)
  a=cor(vraie,pred,"complete")
  print("vcc    correlation   2r^2/(r^2+1)  number of NA   total   pourcentmanquant ")
  
  results =c( vcc,    a,   (2*a)/(a+1)    , m , n, 100*m/n) #compute vonesh concordance correlation #
  
  return(results)
  
  
}




corre=function(vraie,pred){
  
  a=cor(vraie,pred,"complete")
  print("correlation   2r^2/(r^2+1)")
  
  results =c(a,   (2*a)/(a + 1)) #compute vonesh concordance correlation #
  
  return(results)
  
}




#*******************************************************************************************************
##model mixed#
#
#*****************************************************************************************************



lme1 <- lmer(mimicpoids ~ age+age*age+pds_dc + age*pds_dc + (1 | animal), data=newdata1)
summary(lme1)

newdata1$pred1 <- predict(lme1, newdata1)

#*******************************************************************************************************
#plot
#
#*****************************************************************************************************




xyplot(pred1 ~ age, groups = animal, 
       data = newdata1,
       type = "l" ,xlab="age in day",ylab="weight (kg)",main = "Distribution of predictive weight in function of age",
       scales =list(x=list(at=c(0,30,60,120,150,200))))


xyplot(poidsheb ~ age, groups = animal, 
       data = newdata1,
       type = "l" ,xlab="age in day",ylab="weight (kg)",main = "Distribution of weight in function of age/male",
       scales =list(x=list(at=c(0,30,60,120,150,200))))



dev.off()




# vcc + correlation #


test = subset(newdata1, is.na(mimicpoids))


vcc(newdata1$poidsheb, newdata1$pred1)

vcc(test$poidsheb, test$pred1)


corre(newdata1$poidsheb, newdata1$pred1)
corre(test$poidsheb, test$pred1)


#correlation mimic / poisheb #
a=cor(newdata1$poidsheb, newdata1$mimicpoids,"complete")


cor(test$poidsheb, test$mimicpoids,"complete")


#*******************************************************************************************************
# newdata1[is.na(newdata1)] <- 9999
# write.dbf(newdata1,"newdata.dbf")
#
#*****************************************************************************************************





























#attendre importer data "mydatatravail.dat" from SAS#
newdata1 <- read.csv("C:/Users/vhtran/Desktop/these/data/mydatatravail.dat")


newdata1$pred1 = ifelse(is.na(newdata1$mimicpoids),newdata1$pred1,newdata1$poidsheb)
newdata1$Pred = ifelse(is.na(newdata1$mimicpoids),newdata1$Pred,newdata1$poidsheb)
newdata1$poidpre2 = ifelse(is.na(newdata1$mimicpoids),newdata1$poidpre2,newdata1$poidsheb)




newdata1$first_pred1 = ave(newdata1$pred1, newdata1$animal, FUN = function(x) x[1])
newdata1$diff_age<-as.vector(unlist(tapply(newdata1$age,newdata1$animal,FUN=function(x){ return (c(NA,diff(x)))})))
newdata1$diffpred1<-as.vector(unlist(tapply(newdata1$pred1,newdata1$animal,FUN=function(x){ return (c(NA,diff(x)))})))


newdata1$FCR1 = with(newdata1, consoheb*(diff_age)/(diffpred1*1000))
newdata1$FCR1=ifelse(is.na(newdata1$FCR1),9999,newdata1$FCR1)




##d1 = newdata1$age-newdata1$FIRST_age
##d2= newdata1$pred1-newdata1$first_pred1
##newdata1$FCR1 = with(newdata1, consoheb*(age-FIRST_age)/((pred1-first_pred1)*1000))


test=subset(newdata1, is.na(mimicpoids))


vcc(test$poidsheb, test$Pred,test$mimicpoids)

vcc(test$poidsheb, test$poidpre2,test$mimicpoids)

vcc(newdata1$poidsheb,newdata1$pred,newdata1$mimicpoids)






#compute for predict values mixed models#



newdata1$first_pred2 = ave(newdata1$Pred, newdata1$animal, FUN = function(x) x[1])

newdata1$diffpred2<-as.vector(unlist(tapply(newdata1$Pred,newdata1$animal,FUN=function(x){ return (c(NA,diff(x)))})))

newdata1$FCR2 = with(newdata1, consoheb*(diff_age)/(diffpred2*1000))

#newdata1$FCR2=ifelse(is.na(newdata1$FCR1),9999,newdata1$FCR1)




#FCR for gompertz #
newdata1$first_pred3 = ave(newdata1$poidpre2, newdata1$animal, FUN = function(x) x[1])

newdata1$diffpred3<-as.vector(unlist(tapply(newdata1$poidpre2,newdata1$animal,FUN=function(x){ return (c(NA,diff(x)))})))

newdata1$FCR3 = with(newdata1, consoheb*(diff_age)/(diffpred3*1000))



#FCR for vraies valeurs #

newdata1$diffpoid<-as.vector(unlist(tapply(newdata1$poidsheb,newdata1$animal,FUN=function(x){ return (c(NA,diff(x)))})))

newdata1$FCRv = with(newdata1, consoheb*(diff_age)/(diffpoid*1000))








#creat a table #

#datapredict = newdata1[,c(1,8:19,24,25,3,2,27,7,28,34:40,26,43,46,49)]

datapredict = newdata1[,c("animal","identif","bande","sexe","lignee","gener","loge","eleve" ,"pds_dc","pds_fc", "age" ,"poidsheb","mimicpoids","poidpre2" , "Pred","pred1",      
"age_dc","temps","consoheb","mean_conso","ADG","FCR","FCR1","FCR2","FCR3" , "FCRv")]







#excluding the inf values by the replicated row #
datapredict1=subset(datapredict, !is.infinite(FCRv))
datapredict1=subset(datapredict1, !is.infinite(FCR1))
datapredict1=subset(datapredict1, !is.infinite(FCR2))
datapredict1=subset(datapredict1, !is.infinite(FCR3))
#datapredict1[(is.na(datapredict1))]<-9999




#write.dbf(datapredict1,"datapredictf.dbf")

#colnames(datapredict1) = NULL

#write.dat(datapredict1, "C:/Users/vhtran/Desktop/these/data")









FCR1=ifelse(datapre$tFCR1== 9999,NA, datapre$tFCR1)
FCR1=FCR1[FCR1>=0]

boxplot(tFCRv ~ temps, data = datapre,main="true FCR",xlab="time (week)",ylab="FCR",
        notch = TRUE, col = "blue")























library(zoo)


                     
                     
                     
                     m <- embed(mydatatravail$poidsheb, 4)
                     o <- embed(mydatatravail$poidpre2, 4)
                     p <- embed(mydatatravail$pred1, 4)
                     q <- embed(mydatatravail$Pred, 4)
                     u <- embed(mydatatravail$age, 4)
                     n <- embed(mydatatravail$consoheb, 4)
                     mopqun = cbind.data.frame(m,o,p,q,u,n)
                     
                     m1=mopqun[1:3,]
                     m2=rbind.data.frame(m1,mopqun)
                     
                     newdata1=data.frame(mydatatravail,m2)
                     newdata1$count1=unname(unlist(tapply(newdata1$animal,newdata1$animal,function(x)(1:length(x)))))
                     newdata11=subset(newdata1, count1>3)
                     newdata11$diffpoidsheb =with(newdata11, (X1-X4))
                     newdata11$diffpoidpre2 =with(newdata11, (X1.1-X4.1))
                     newdata11$diffpred1 =with(newdata11, (X1.2-X4.2))
                     newdata11$diffpred =with(newdata11, (X1.3-X4.3))
                     newdata11$diffage =with(newdata11, (X1.4-X4.4))
                     newdata11$meancons3 =with(newdata11, (X1.5+X2.5+X3.5+X4.5)/4)
                     
                     
                     newdata11$tADG=with(newdata11,diffpoidsheb/diffage)
                     newdata11$tADGgom=with(newdata11,diffpoidpre2/diffage)
                     newdata11$tADG2=with(newdata11,diffpred/diffage)
                     
                     newdata11$tFCR1 = with(newdata11, meancons3*(diffage)/(diffpred1*1000))
                     newdata11$tFCR2 = with(newdata11, meancons3*(diffage)/(diffpred*1000))
                     newdata11$tFCRv = with(newdata11, meancons3*(diffage)/(diffpoidsheb*1000))
                     newdata11$tFCRgom = with(newdata11, meancons3*(diffage)/(diffpoidpre2*1000))
                     
                     
                     
                     
                    #newdata11$tFCR1 = with(newdata11, consoheb*(diffage)/(diffpred1*1000))
                     #newdata11$tFCR2 = with(newdata11, consoheb*(diffage)/(diffpred*1000))
                    #newdata11$tFCRv = with(newdata11, consoheb*(diffage)/(diffpoidsheb*1000))
                     #newdata11$tFCRgom = with(newdata11, consoheb*(diffage)/(diffpoidpre2*1000))
                     
                     
                     
                     
                     
                     
                     datapredict = newdata11[,c("animal","identif","bande","sexe","lignee","gener","loge","eleve" ,"pds_dc","pds_fc", "age" ,"poidsheb","mimicpoids","poidpre2" , "Pred","pred1",      
                     "age_dc","temps","consoheb","mean_conso","tADG","tADGgom","tADG2","FCR","tFCR1","tFCR2","tFCRgom" , "tFCRv")]
                     



                     
                     
                     #excluding the inf values by the replicated row #
                     datapredict1=subset(datapredict, !is.infinite(tFCRv))
                     datapredict1=subset(datapredict1, !is.infinite(tFCR1))
                     datapredict1=subset(datapredict1, !is.infinite(tFCR2))
                     datapredict1=subset(datapredict1, !is.infinite(tFCRgom))
                     #datapredict1[(is.na(datapredict1))]<-9999
                     
                     
                     
                     
                     #write.dbf(datapredict1,"datapredict4.dbf")
                     













#################################################################################################


#library(zoo)


                     
                     
                     
                     m <- embed(mydatatravail$poidsheb, 4)
                     o <- embed(mydatatravail$poidpre2, 4)
                     p <- embed(mydatatravail$Pred, 4)
                     q <- embed(mydatatravail$age, 4)
                     u <- embed(mydatatravail$consoheb, 4)
                     mopqu = cbind.data.frame(m,o,p,q,u)
                     
                     m1=mopqu[1:3,]
                     m2=rbind.data.frame(m1,mopqu)
                     
                     newdata1=data.frame(mydatatravail,m2)
                     newdata1$count1=unname(unlist(tapply(newdata1$animal,newdata1$animal,function(x)(1:length(x)))))
                     

                     newdata11=subset(newdata1, count1>3)
                     newdata11$diffpoidsheb =with(newdata11, (X1-X4))
                     newdata11$diffpoidpre2 =with(newdata11, (X1.1-X4.1))
                     newdata11$diffpred =with(newdata11, (X1.2-X4.2))
                     newdata11$diffage =with(newdata11, (X1.3-X4.3))
                     newdata11$meancons3 =with(newdata11, (X1.4+X2.4+X3.4+X4.4)/4)
                     
                     newdata11$tADG=with(newdata11,diffpoidsheb/diffage)
                     newdata11$tADGgom=with(newdata11,diffpoidpre2/diffage)
                     newdata11$tADG2=with(newdata11,diffpred/diffage)
                     
                     
                     
                    
                     newdata11$tFCR2 = with(newdata11, meancons3*(diffage)/(diffpred*1000))
                     newdata11$tFCRv = with(newdata11, meancons3*(diffage)/(diffpoidsheb*1000))
                     newdata11$tFCRgom = with(newdata11, meancons3*(diffage)/(diffpoidpre2*1000))
                     
                     
                     
                     
                    
                     #newdata11$tFCR2 = with(newdata11, consoheb*(diffage)/(diffpred*1000))
                     #newdata11$tFCRv = with(newdata11, consoheb*(diffage)/(diffpoidsheb*1000))
                     #newdata11$tFCRgom = with(newdata11, consoheb*(diffage)/(diffpoidpre2*1000))
                     
                     
                     
                     
                     
                     
                     datapredict = newdata11[,c("animal","identif","bande","sexe","lignee","gener","loge","eleve" ,"pds_dc","pds_fc", "age" ,"poidsheb","mimicpoids","poidpre2" , "Pred","pred1",      
                     "age_dc","temps","consoheb","mean_conso","ADG","FCR","tFCR1","tFCR2","tFCRgom" , "tFCRv")]
                     
                     
                     
                     #excluding the inf values by the replicated row #
                     datapredict1=subset(datapredict, !is.infinite(tFCRv))
                     datapredict1=subset(datapredict1, !is.infinite(tFCR1))
                     datapredict1=subset(datapredict1, !is.infinite(tFCR2))
                     datapredict1=subset(datapredict1, !is.infinite(tFCRgom))
                     #datapredict1[(is.na(datapredict1))]<-9999
                     
                     
                     
                     
                     #write.dbf(datapredict1,"datapredict4.dbf")
                     
                     
                     #colnames(datapredict1) = NULL
                     
                     #write.dat(datapredict1, "C:/Users/vhtran/Desktop/these/data")
                     
                     





boxplot(V23 ~ V18, data = datapredict,main="ADG of Mixed model",xlab="time (week)",ylab="ADG",
        notch = TRUE, col = "blue")

==============================================================================================

  
library(plyr)

mydata <- read.table("C:/Users/tran/Google Drive/these/sujet2/datapredictT2.txt", quote="\"", comment.char="")
mydata=subset(mydata,V6=="G7")

mydata$V18 =ifelse((mydata$V18>6|mydata$V18<0),NA,mydata$V18)

counts <- ddply(mydata, "V15", summarize, missing=sum(is.na(c(V18))))
counts1 <- ddply(mydata, "V15", summarize, nonmissing=sum(!is.na(c(V18))))

counts
counts1

mydata1=subset(mydata,is.na(mydata$V18))



mydata1=subset(mydata,V15==8)

sln <- read.table("C:/Users/tran/Google Drive/these/sujet2/RROP.sln", quote="\"", comment.char="")

sln1=subset(sln,sln$V1=="mv_estimates")
length(sln1$V1)

#if (length(sln1$V2)==(239+195+100+259+1000))=2032
 

sln2=sln1[1033:2032,]


mydata5=merge(mydata1,sln2,all=T)





vcc=function(vraie,pred,mimic){
  a1= (vraie-pred)
  a11 = a1*a1
  k1=sum(a11, na.rm=T)
  
  
  a2=(vraie-mean(vraie,na.rm=T))
  a21=a2*a2
  k2=sum(a21, na.rm=T)
  
  
  a3=(pred-mean(pred,na.rm=T))
  a31=a3*a3
  k3=sum(a31, na.rm=T)
  
  a4=(mean(vraie,na.rm=T)-mean(pred,na.rm=T))
  a41=a4*a4
  k4=length(vraie)*a41
  
  
  vcc=1-k1/(k2+k3+k4)
  
  m= sum(is.na(mimic))
  n= length(vraie)
  a=cor(vraie,pred,"complete")
  print("vcc    correlation   2r^2/(r^2+1)  number of NA   total   pourcentmanquant ")
  
  results =c( vcc,    a,   (2*a)/(a+1)    , m , n, 100*m/n) #compute vonesh concordance correlation #
  
  return(results)
  
  
}




corre=function(vraie,pred){
  
  a=cor(vraie,pred,"complete")
  print("correlation   2r^2/(r^2+1)")
  
  results =c(a,   (2*a)/(a + 1)) #compute vonesh concordance correlation #
  
  return(results)
  
}
