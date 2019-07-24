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


kku=aggregate(FI ~ animal+temps, mydata, function(x) max(cumsum(x)))


kku=ddply(mydata,FI~animal+temps,summarise,cumFI=cumsum(FI))



  cumsum(mydata$FI)


#mydata$temps=as.numeric(levels(mydata$temps))[mydata$temps]
#number animal

my1=mydata[,1:2]
my2=aggregate(my1, list(my1$animal), FUN=head, 1)
my2=arrange(my2,animal)



my2=arrange(my2,animal)






########################################################################################
# EBV for one records (mean of record)/ 3986 animals

EBV_all <- read.table("EBV_all.txt", quote="\"")



test<-melt(EBV_all,id.vars = 'animal')

test1=arrange(test,animal)
test1$EBV=test1$value

EBV_all1=test1[,c("animal","EBV")]

N_animal=length(unique(EBV_all1$animal))

EBV_all1$temps=c(rep(4:13,N_animal))






EBV_to <- read.table("total", quote="\"")



EBV_to1=EBV_to[2:4] # delete the first col


names(EBV_to1)[1]<-"animal"  
names(EBV_to1)[2]<-"EBVto" 
names(EBV_to1)[3]<-"SE_EBVto" 

EBV_to2=arrange(EBV_to1,animal)
















###############################
#G <- read.table("C:/Users/vhtran/Desktop/G.txt",quote="\"")
#matrix G of RROP
G <- read.table("G_RROP2",quote="\"") # old is G1
G=as.matrix(G)
###############################
#matrix G of SAD
G1 <- read.table("G_sad.txt",quote="\"") #old is G
G1=as.matrix(G1)
R=eigen(G, only.values = FALSE, EISPACK = FALSE)
R1=eigen(G1, only.values = FALSE, EISPACK = FALSE)
R$values
V=(R$vectors)
V1=(R1$vectors)
###############################

Ka=matrix(c(0.1627E-01,  0.2445E-02 ,  0.2489E-03,
            0.2445E-02,  0.2303E-01, -0.1748E-03,
            0.2489E-03, -0.1748E-03 ,  0.3318E-02),3,3)



Ka=t(Ka)
Kaei=eigen(Ka, only.values = F, EISPACK = FALSE)
Kaei


G_RROP <- read.table("sln_RROP", quote="\"") # old G_RROP
a=as.character(G_RROP$V2)
G_RROP$tPhi = substring(a,1,1) 
G_RROP$animal=substring(a,3)
GOP=G_RROP[,c("animal","V3","tPhi")]
GOP=arrange(GOP,animal,tPhi)
GOP$ei1=-rep(Kaei$vectors[,1],3986)
GOP$ei2=rep(Kaei$vectors[,2],3986) # add -
GOP$ei3=rep(Kaei$vectors[,3],3986)
mydata5=GOP
mydata6=arrange(mydata5,animal,tPhi)  
mydata7=ddply(mydata6, "animal", head, 3)
mydata7=arrange(mydata7,animal,tPhi)  


mydata7$E1=mydata7$V3*mydata7$ei1
mydata7$E2=mydata7$V3*mydata7$ei2
mydata7$E3=mydata7$V3*mydata7$ei3







#write.table(mydata7, "eigenK.xls", col=NA, sep="\t",dec=".")  #write data to a file
mydata8=ddply(mydata7,~animal,summarise,sum=sum(E1),mean=mean(E1),sd=sd(E1))
mydata9=ddply(mydata7,~animal,summarise,sum=sum(E2),mean=mean(E2),sd=sd(E2))
mydata10=ddply(mydata7,~animal,summarise,sum=sum(E3),mean=mean(E3),sd=sd(E3))

cor(mydata8$sum,mydata10$sum)





###############################

#file sln SAD
#read data SAD.sln , !!!attention drive
G_sad <- read.table("sln_sad1", quote="\"") #old is G_sad
View(G_sad)
names(G_sad)<-c("V1","code","value","SE")
a = G_sad$code
elems <- unlist( strsplit(as.character(a)  , "\\." ) )
m <- as.data.frame(matrix( elems , ncol = 2 , byrow = TRUE ))
Gsad=cbind(G_sad,m)
names(Gsad)<-c("V1","code","value","SE","temps","animal")
Gsad$temps=as.numeric(levels(Gsad$temps))[Gsad$temps]
Gsad=arrange(Gsad,animal,temps)
N_animal=length(unique(Gsad$animal))  #number animal from SAD.sln


cor(Gsad$value,EBV_all1$EBV,method="spearman")


Gsad$e1=-rep(V1[,1],N_animal) # added -
Gsad$e2=-rep(V1[,2],N_animal)   #eigen G RROP/breeding values # added -
Gsad$e3=rep(V1[,3],N_animal)
Gsad$e4=rep(V1[,4],N_animal)

Gsad$E1=(Gsad$e1)*(Gsad$value) 
Gsad$E2=(Gsad$e2)*(Gsad$value) 
Gsad$E3=(Gsad$e3)*(Gsad$value)
Gsad$E4=(Gsad$e4)*(Gsad$value)


EBV_Gsad=ddply(Gsad,~animal,summarise,sum=sum(value),mean=mean(value),sd=sd(value))
EBV_Gsad1=ddply(Gsad,~animal,summarise,sum=sum(E1),mean=mean(E1),sd=sd(E1))
EBV_Gsad2=ddply(Gsad,~animal,summarise,sum=sum(E2),mean=mean(E2),sd=sd(E2))
EBV_Gsad3=ddply(Gsad,~animal,summarise,sum=sum(E3),mean=mean(E3),sd=sd(E3))
EBV_Gsad4=ddply(Gsad,~animal,summarise,sum=sum(E4),mean=mean(E4),sd=sd(E4))


################################################################################




EBV_all1$e1=rep(V[,1],N_animal) 
EBV_all1$e2=-rep(V[,2],N_animal)   #eigen G RROP/breeding values
EBV_all1$e3=rep(V[,3],N_animal)
EBV_all1$e4=rep(V[,4],N_animal)

EBV_all1$in1_all=(EBV_all1$e1)*(EBV_all1$EBV)
EBV_all1$in2_all=(EBV_all1$e2)*(EBV_all1$EBV)
EBV_all1$in3_all=(EBV_all1$e3)*(EBV_all1$EBV)
EBV_all1$in4_all=(EBV_all1$e4)*(EBV_all1$EBV)


Gsad_take=Gsad[,c("value","E1","E2","E3","E4")]


DF=data.frame(EBV_all1,Gsad_take)


EBV_all_single1=ddply(EBV_all1,~animal,summarise,sum=sum(EBV),mean=mean(EBV),sd=sd(EBV))
EBV_all_single2=ddply(EBV_all1,~animal,summarise,sum=sum(in1_all),mean=mean(in1_all),sd=sd(in1_all))
EBV_all_single3=ddply(EBV_all1,~animal,summarise,sum=sum(in2_all),mean=mean(in2_all),sd=sd(in2_all))
EBV_all_single4=ddply(EBV_all1,~animal,summarise,sum=sum(in3_all),mean=mean(in3_all),sd=sd(in3_all))
EBV_all_single5=ddply(EBV_all1,~animal,summarise,sum=sum(in4_all),mean=mean(in4_all),sd=sd(in4_all))



EBV_to2$EBV_OP=EBV_all_single1$sum
EBV_to2$in1_all=EBV_all_single2$sum
EBV_to2$in2_all=EBV_all_single3$sum
EBV_to2$in3_all=EBV_all_single4$sum
EBV_to2$in4_all=EBV_all_single5$sum


EBV_to2$EBV_SAD=EBV_Gsad$sum
EBV_to2$E1=EBV_Gsad1$sum
EBV_to2$E2=EBV_Gsad2$sum
EBV_to2$E3=EBV_Gsad3$sum
EBV_to2$E4=EBV_Gsad4$sum
EBV_to2$e1_all=mydata8$sum
EBV_to2$e2_all=mydata9$sum
EBV_to2$e3_all=mydata10$sum

names(EBV_to2)



#write.table(EBV_to2, "EBVperiod.txt", col=NA, sep="\t",dec=".")  #write data to a file

critere = c(names(my2),names(EBV_to2))  
critere=critere[duplicated(critere)]     #critere pour merge 2 tableaux#  
mydata0=arrange(my2,animal,identif)  
#merge data to obtain 1 line/animal for SAD
mydata1=merge(mydata0,EBV_to2,by=c(critere))  
#class the animal
mydata1=arrange(mydata1,animal)  


animal=(rep(mydata1$animal,10))
identif=(rep(mydata1$animal,10))
DF_1=data.frame(animal,identif)
DF_2=arrange(DF_1,animal)


DF_2$temps=c(rep(4:13,1186))
DF_2=arrange(DF_2,animal,temps)



DF_3=merge(DF_2,DF,by=c("animal","temps"))  

DF0=arrange(DF_3,animal,temps)

# 
# EBV_to3=mydata1[,c("animal", "E1",      "E2"  ,"E3", "EBV_SAD","e1_all","e2_all","e3_all", "EBV_OP",
#                    "in1_all",  "in2_all","in3_all" ,"EBVto")]        
# 
# names(EBV_to3) <- c("animal", "SBV_SAD1", "SBV_SAD2","SBV_SAD3", "sEBV_SAD","SBV_RRK1","SBV_RRK2","SBV_RRK3","sEBV_RR","SBV_RR1","SBV_RR2","SBV_RR3","cEBV")





# EBV_to3=mydata1[,c("animal", "E1",      "E2"  , "EBV_SAD","e1_all","e2_all","EBV_OP",
#                    "in1_all",  "in2_all","EBVto")]        
# 
# names(EBV_to3) <- c("animal", "SBV_SAD1", "SBV_SAD2", "sEBV_SAD","SBV_RRK1","SBV_RRK2","sEBV_RR","SBV_RR1","SBV_RR2","cEBV")
# 


EBV_to3=mydata1[,c("animal", "E1",      "E2"  , "EBV_SAD","e1_all","e2_all","EBV_OP",
                   "in1_all",  "in2_all","in3_all",  "in4_all","EBVto")]        


names(EBV_to3) <- c("animal", "SBV_SAD1", "SBV_SAD2", "sEBV_SAD","SBV_RRK1","SBV_RRK2","sEBV_RR","SBV_RR1","SBV_RR2","SBV_RR3","SBV_RR4","cEBV")





################################################################################
#1186
#sbv=EBV_to3







corr.test(EBV_to3[,2:10])


#res1 <- read.table("corrindex.txt",quote="\"") 
res3 <- read.table("corr_index.txt",quote="\"") 

res4=as.matrix(res3)

corrplot(res4, type = "upper", order = "hclust", 
         tl.col = "black", tl.srt = 45)


library(PerformanceAnalytics)
mydataplot=EBV_to3[,2:10]

#names(mydataplot)[1]<-"SBV_SAD1"     
# names(mydataplot)[2]<-"SBV_SAD2"     
# names(mydataplot)[3]<-"EBV_SAD"     
# names(mydataplot)[4]<-"SBV_RRK1"     
# names(mydataplot)[5]<-"SBV_RRK2"     
# names(mydataplot)[6]<-"EBV_RR"     
# names(mydataplot)[7]<-"SBV_RR1"     
# names(mydataplot)[8]<-"SBV_RR2"     
# names(mydataplot)[9]<-"cEBV"     
# 

chart.Correlation(mydataplot, histogram=TRUE, pch=".",method =("spearman"),label=" ",smooth=F)
legend(0, 1, as.vector(unique(mydataplot$colnams)))



library(psych)


png(file = "out.png", width = 1200, height = 1200)


pairs.panels(mydataplot,scale = FALSE,method="spearman",rug=FALSE, ellipses=FALSE, show.points=TRUE,
             smoother=FALSE,
             jitter=FALSE,
             pch=".",
             smooth=FALSE,label=" ",
             breaks = "Sturges",
             lm=T,col.lm=NULL)

#legend(0, 1, as.vector(unique(mydataplot$colnams)))


dev.off()



mydataplot=mydataplot[,1:3]
pairs.panels(mydataplot,scale = FALSE,method="spearman",rug=FALSE, ellipses=FALSE, show.points=TRUE,
             smoother=FALSE,
             jitter=TRUE,
             #pch=".",
             smooth=FALSE,
             breaks = "Sturges",
             lm=T,col.lm=NULL)





























col<- colorRampPalette(c("blue", "white", "red"))(20)
heatmap(res4, col = col, symm = TRUE)






######################################################################################

#classification DF

DF1=DF0[,c("animal","temps","EBV")]
DF2=reshape(DF1, varying = NULL, timevar = "temps", idvar = "animal", direction="wide", sep = "")



#predict the missing data using Linear interpolation/matrix
DF3=imputation(as.matrix(DF2[, 2:11]), method = "linearInterpol")

#prepared data for kml

cldDF3 <- cld(DF3, timeInData = 1:10)
#cld1

#kml with 3 groups, show only trajectories

kml(cldDF3, nbRedraw = 20,nbClusters=3, toPlot = "both")

kml(cldDF3)

kml(cldDF3, 3, parAlgo = parALGO(distance = function(x, y)
  cor(x, y), saveFreq = 10))

choice(cldDF3)

DF2$grEBV <- getClusters(cldDF3, 3)


#######################################################

DF4=DF0[,c("animal","temps","value")]
DF5=reshape(DF4, varying = NULL, timevar = "temps", idvar = "animal", direction="wide", sep = "")



#predict the missing data using Linear interpolation/matrix
DF6=imputation(as.matrix(DF5[, 2:11]), method = "linearInterpol")

#prepared data for kml

cldDF6 <- cld(DF6, timeInData = 1:10)
#cld1

#kml with 3 groups, show only trajectories

kml(cldDF6, nbRedraw = 20,nbClusters=3, toPlot = "traj")






kml(cldDF6)

kml(cldDF6, 3, parAlgo = parALGO(distance = function(x, y)
  cor(x, y), saveFreq = 10))

choice(cldDF6)

DF2$grEBV_SAD <- getClusters(cldDF6, 3)


###############################################################################

DF7=DF0[,c("animal","temps","E2")]
DF8=reshape(DF7, varying = NULL, timevar = "temps", idvar = "animal", direction="wide", sep = "")



#predict the missing data using Linear interpolation/matrix
DF9=imputation(as.matrix(DF8[, 2:11]), method = "linearInterpol")

#prepared data for kml

cldDF9 <- cld(DF9, timeInData = 1:10)
#cld1

#kml with 3 groups, show only trajectories

kml(cldDF9, nbRedraw = 20,nbClusters=3, toPlot = "traj")

kml(cldDF9)

kml(cldDF9, 3, parAlgo = parALGO(distance = function(x, y)
  cor(x, y), saveFreq = 10))

choice(cldDF9)

DF2$grE2 <- getClusters(cldDF9, 3)

######################################################################################

DF10=DF0[,c("animal","temps","E1")]
DF11=reshape(DF10, varying = NULL, timevar = "temps", idvar = "animal", direction="wide", sep = "")



#predict the missing data using Linear interpolation/matrix
DF12=imputation(as.matrix(DF11[, 2:11]), method = "linearInterpol")

#prepared data for kml

cldDF12 <- cld(DF12, timeInData = 1:10)
#cld1

#kml with 3 groups, show only trajectories

kml(cldDF12, nbRedraw = 20,nbClusters=3, toPlot = "traj")

kml(cldDF12)

kml(cldDF12, 3, parAlgo = parALGO(distance = function(x, y)
  cor(x, y), saveFreq = 10))

choice(cldDF12)

DF2$grE1 <- getClusters(cldDF12, 3)

####################################################################################

DF13=DF0[,c("animal","temps","in1_all")]
DF14=reshape(DF13, varying = NULL, timevar = "temps", idvar = "animal", direction="wide", sep = "")



#predict the missing data using Linear interpolation/matrix
DF15=imputation(as.matrix(DF14[, 2:11]), method = "linearInterpol")

#prepared data for kml

cldDF15 <- cld(DF15, timeInData = 1:10)
#cld1

#kml with 3 groups, show only trajectories

kml(cldDF15, nbRedraw = 20,nbClusters=3, toPlot = "traj")

kml(cldDF15)

kml(cldDF15, 3, parAlgo = parALGO(distance = function(x, y)
  cor(x, y), saveFreq = 10))

choice(cldDF15)

DF2$gr_in1 <- getClusters(cldDF15, 3)


###################################################################

DF16=DF0[,c("animal","temps","in2_all")]
DF17=reshape(DF16, varying = NULL, timevar = "temps", idvar = "animal", direction="wide", sep = "")



#predict the missing data using Linear interpolation/matrix
DF18=imputation(as.matrix(DF17[, 2:11]), method = "linearInterpol")

#prepared data for kml

cldDF18 <- cld(DF18, timeInData = 1:10)
#cld1

#kml with 3 groups, show only trajectories

kml(cldDF18, nbRedraw = 20,nbClusters=3, toPlot = "traj")

kml(cldDF18)

kml(cldDF18, 3, parAlgo = parALGO(distance = function(x, y)
  cor(x, y), saveFreq = 10))

choice(cldDF18)

DF2$gr_in2 <- getClusters(cldDF18, 3)




with(DF2,table(gr_in2,grEBV))
with(DF2,table(gr_in1,grEBV))
with(DF2,table(grEBV_SAD,grEBV))
with(DF2,table(grE2,grEBV_SAD))

with(DF2,table(grE1,grEBV_SAD))
with(DF2,table(grE1,grEBV_SAD))
with(DF2,table(grE1,grE2,grEBV_SAD))
with(DF2,table(grE1,grEBV_SAD,grEBV))


with(DF2,table(grE1,grE2,grEBV_SAD))

###############################################
data_class=cbind(DF2,EBV_to3)
data_class$EBV=with(data_class,EBV4+EBV5+EBV6+EBV7+EBV8+EBV9+EBV10+EBV11+EBV12+EBV13)

summaryBy(EBVto  ~ grEBV_SAD, data = data_class, 
          FUN = function(x) { c(median=median(x),mean=mean(x), sd=sd(x),min=min(x),max=max(x)) } )

boxplot(E1   ~ grEBV_SAD, data = data_class,
        notch = TRUE, col = "blue",lwd = 1,xlab="group EBV_sad",ylab='value EBVto')
stripchart(E1   ~ grEBV_SAD, vertical = TRUE, data = data_class, 
           method = "jitter", add = TRUE, pch = 20, col = 'blue')
#Tukey test
summary(fm2 <- aov(EBVto  ~ grEBV_SAD, data_class))
TukeyHSD(fm2, "grEBV_SAD", ordered = TRUE)
plot(TukeyHSD(fm2, "grEBV_SAD"))








summaryBy(E1 ~ grEBV_SAD, data = data_class, 
          FUN = function(x) { c(median=median(x),mean=mean(x), sd=sd(x),min=min(x),max=max(x)) } )

summaryBy(E2 ~ grEBV_SAD, data = data_class, 
          FUN = function(x) { c(median=median(x),mean=mean(x), sd=sd(x),min=min(x),max=max(x)) } )

summaryBy(E3 ~ grEBV_SAD, data = data_class, 
          FUN = function(x) { c(median=median(x),mean=mean(x), sd=sd(x),min=min(x),max=max(x)) } )

















######################################################################

test=merge(DF2,DF,by=c("animal"))

#library(dplyr)
#grouped <- group_by(test, grEBV, temps)
#kk=summarise(grouped, mean=mean(EBV), sd=sd(EBV))

test1=arrange(test,animal,grEBV_SAD)
test1$EBV=with(test1,EBV4+EBV5+EBV6+EBV7+EBV8+EBV9+EBV10+EBV11+EBV12+EBV13)
library(doBy)
summaryBy(EBV  ~ grEBV_SAD, data = test1, 
          FUN = function(x) { c(median=median(x),mean=mean(x), sd=sd(x),min=min(x),max=max(x)) } )


#Tukey test
summary(fm2 <- aov(EBV  ~ grEBV_SAD, data = test1))
TukeyHSD(fm2, "grEBV_SAD", ordered = TRUE)
plot(TukeyHSD(fm2, "grEBV_SAD"))



#xyplot(EBV  ~ grEBV_SAD | animal,test1, as.table=T,main="EBV RROP")


#xyplot(BV ~ temps, groups = animal, 
#  data = dataBV,cex=2,
## type = "l" ,xlab=list(label="time (week)",cex=2),ylab=list(label="EBV RROP",cex=2),main =list(label= "    ",cex=2),
#    scales =list(x=list(at=c(2:17),cex=1.7),y = list(cex=1.7)))


#save.image(file="0302.RData")



list_gene=read.table("list_genera.txt",header=T)
#list_gene$group =ifelse(list_gene$group == "G0 n", "G0",list_gene$group)
# 
data_class$group_ligne=list_gene$group
data_class$gener=list_gene$gener
data_class$lignee=list_gene$lignee


  #data_class$group_ligne=ifelse(as.character(data_class$group_ligne) == "G0 n", "G0",data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne == "G1 -", "LRFI-G1",data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne == "G1 +", "HRFI-G1",data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G2 -", "LRFI-G2",data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G2 +", "HRFI-G2",data_class$group_ligne)
# #
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G3 -", 'LRFI-G3',data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G3 +", 'HRFI-G3',data_class$group_ligne)
# #
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G4 -", 'LRFI-G4',data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G4 +", 'HRFI-G4',data_class$group_ligne)
# #
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G5 -", 'LRFI-G5',data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G5 +", 'HRFI-G5',data_class$group_ligne)
# #
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G6 -", 'LRFI-G6',data_class$group_ligne)
# #
# data_class$group_ligne=ifelse(data_class$group_ligne=="G6 +", 'HRFI-G6',data_class$group_ligne)
# #
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G7 -", 'LRFI-G7',data_class$group_ligne)
# #
#  data_class$group_ligne=ifelse(data_class$group_ligne=="G7 +", 'HRFI-G7',data_class$group_ligne)
# #



model = svm(group_ligne ~ SBV_RR1 + SBV_RR2, data = data_class, kernel = "linear",
            gamma = 0.5)
plot(model,  data = data_class, SBV_RR2 ~ SBV_RR1, slice = list(sepal.width = 1,
                                                                  sepal.length = 2), 
     col = c("white","cadetblue1","goldenrod1","cyan1","coral","chartreuse1","chocolate","forestgreen",
             "deeppink","royalblue2","magenta","blue1","brown3","blue4","red"))
    
     
     
     
model = svm(group_ligne ~ SBV_SAD1 + SBV_SAD2, data = data_class, kernel = "RBF",
            gamma = 0.5)
plot(model,  data = data_class, SBV_SAD1 ~ SBV_SAD2, slice = list(sepal.width = 1,
                                                                sepal.length = 2), 
     col = c("white","cadetblue1","goldenrod1","cyan1","coral","chartreuse1","chocolate","forestgreen",
             "deeppink","royalblue2","magenta","blue1","brown3","blue4","red"))




citation(package = "e1071", lib.loc = NULL, auto = NULL)


#

#par(mfrow = c(2,2),
    
#    mar=c(5,5,0.5,0.5))
#par(mfrow = c(1,2))



model = svm(lignee ~ SBV_RR1 + SBV_RR2, data = data_class, kernel = "linear")
model


library(gbm)
        library(randomForest)


library(e1071)

model = svm(grEBV ~ SBV_RR1 + SBV_RR2, data = data_class,  kernel = "linear",
            gamma = 0.5)
plot(model,  data = data_class, SBV_RR2 ~ SBV_RR1, col = c("skyblue1","orchid1","white"),
     
     
     slice = list(sepal.width = 2, sepal.length = 1))







model = svm(grEBV_SAD ~ SBV_SAD1 + SBV_SAD2, data = data_class,  kernel = "linear",
             gamma = 0.5)
plot(model,  data = data_class, SBV_SAD1 ~ SBV_SAD2, col = c("skyblue1","orchid1","white"),
     
     
     slice = list(sepal.width = 2, sepal.length = 1))



model = svm(lignee ~ SBV_SAD1 + SBV_SAD2, data = data_class,  kernel = "linear",
            gamma = 0.5)
plot(model,  data = data_class, SBV_SAD2 ~ SBV_SAD1, col = c("skyblue1","orchid1","white"),
     
     
     slice = list(sepal.width = 2, sepal.length = 1))



model = svm(lignee ~ SBV_RR1 + SBV_RR2, data = data_class,  kernel = "linear",
            gamma = 0.5)
plot(model,  data = data_class, SBV_RR2 ~ SBV_RR1, col = c("skyblue1","orchid1","white"),
     
     
     slice = list(sepal.width = 2, sepal.length = 1))






png(file = "R.png",  width = 500, height = 500)

with(data_class, plot(SBV_RR3,SBV_RR4,xlab="SBV_RR3",ylab="SBV_RR4",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","green","blue")[data_class$grEBV],
                      pch=c(1, 15, 24)[data_class$grEBV]))


legend(
  "topright", 
  pch=c(1,15,24), 
  col=c("red","green","blue"),
  legend=c("A", "B","C")
)

dev.off()

















png(file = "K.png", width = 500, height = 500)
  
with(data_class, plot(SBV_RRK1,SBV_RRK2,xlab="SBV_RRK1",ylab="SBV_RRK2",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","green","blue")[data_class$grEBV],
                      pch=c(1, 15, 24)[data_class$grEBV]))
legend(
  "topright", 
  pch=c(1,15,24), 
  col=c("red","green","blue"),
  legend=c("A", "B","C")
)

dev.off()







png(file = "R.png",  width = 500, height = 500)

with(data_class, plot(SBV_RR1,SBV_RR2,xlab="SBV_RR1",ylab="SBV_RR2",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","green","blue")[data_class$grEBV],
                      pch=c(1, 15, 24)[data_class$grEBV]))


legend(
  "topright", 
  pch=c(1,15,24), 
  col=c("red","green","blue"),
  legend=c("A", "B","C")
)

dev.off()








png(file = "GSAD.png", width = 500, height = 500)
with(data_class, plot(SBV_SAD1,SBV_SAD2,xlab="SBV_SAD1",ylab="SBV_SAD2",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","green","blue")[data_class$grEBV_SAD], 
                      pch = c(1, 15, 24)[data_class$grEBV_SAD]))

# legend("topright",
#        legend=c("A", "B","C"),bty="n",cex = 1.5,  pt.cex = 1.5,horiz = TRUE,
#        inset=c(-0.2,0),title="group",
#        col=c("red","green","blue"),
#        pch=c(1,15,24) )

legend(
  "topright", 
  pch=c(1,15,24), 
  col=c("red","green","blue"),
  legend=c("A", "B","C")
)

dev.off()








legend("topright",
       legend=c("A", "B","C"),bty="n",cex = 1.5,  pt.cex = 1.5,horiz = TRUE,
       inset=c(-0.2,0),title="group",
       col=c("red","blue","green"),
       pch=c(1,15,24) )


library(scatterplot3d)
scatterplot3d(sbv[,1:3], pch = 16, color=colors)






legend(1.05 ,6.5,
       legend=c("A", "B","C"),bty="n",cex = 1.5,  pt.cex = 1.5,horiz = TRUE,
       inset=c(-0.2,0),title="group",
       col=c("red","green","blue"),
       pch=c(1,15,24) )



library(Rcmdr)
attach(mtcars)
with(data_class, scatter3d(E1, E2, E3)

     #install.packages("scatterplot3d") # Install
     library("scatterplot3d") # load

     #colors <- c("red", "green", "blue")
    # colors <- colors[as.numeric(data_class$grEBV_SAD)]
     
     SBV_SAD1=data_class$SBV_SAD1
     SBV_SAD2=data_class$SBV_SAD2
     SBV_SAD3=data_class$SBV_SAD3
     sbv=data.frame(SBV_SAD1,SBV_SAD2,SBV_SAD3)
     
     
     SBV_RR1=data_class$SBV_RR1
     SBV_RR2=data_class$SBV_RR2
     SBV_RR3=data_class$SBV_RR3
     
     
     SBV_RRK1=data_class$SBV_RRK1
     SBV_RRK2=data_class$SBV_RRK2
     SBV_RRK3=data_class$SBV_RRK3
     
     sbv=data.frame(SBV_SAD1,SBV_SAD2,SBV_SAD3)
     sbv1=data.frame(SBV_RR1,SBV_RR2,SBV_RR3)
     sbv2=data.frame(SBV_RRK1,SBV_RRK2,SBV_RRK3)
     
     
     
     
     scatterplot3d(sbv2[,1:3], pch = 16, color=colors)


    
     
     
      library(scatterplot3d)
      
      
      frames <- 360
      
      rename <- function(x){
        if (x < 10) {
          return(name <- paste('000',i,'plot.png',sep=''))
        }
        if (x < 100 && i >= 10) {
          return(name <- paste('00',i,'plot.png', sep=''))
        }
        if (x >= 100) {
          return(name <- paste('0', i,'plot.png', sep=''))
        }
      }
      
      p <- prcomp(sbv1[,1:3])
      
     
      
     # my_col <- as.numeric(data_class$grEBV_SAD)
      
      #SAD
      
      #my_col <-ifelse(data_class$grEBV_SAD=="A","red",ifelse(data_class$grEBV_SAD=="B","green","blue"))
      
      #RR
      
      my_col <-ifelse(data_class$grEBV=="A","red",ifelse(data_class$grEBV=="B","green","blue"))
      #loop through plots
      
      
      #loop through plots
      for(i in 1:frames){
        name <- rename(i)
        
        #saves the plot as a .png file in the working directory
        png(name)
        
        
        #names(p$x) <- c("SBV_SAD1", "SBV_SAD2","SBV_SAD3") 
        
        
        scatterplot3d(sbv2[,1:3], pch = 16, color=colors,main=paste("Angle", i),
                      angle=i)
        
        
        dev.off()
      }
      
        
        
        
      #   scatterplot3d(p$x[,1:3],
      #                 main=paste("Angle", i),
      #                 angle=i,
      #                 pch=19,
      #                 cex.symbols=0.5,
      #                 color=my_col)
      #   dev.off()
      # }
      # 
     
      
     


      
      
      
      
      
      
      
      
      
      data_class1=subset(data_class,grEBV=="A")
      
      with(data_class, plot(SBV_RRK1,SBV_RRK2,xlab="SBV_RRK1",ylab="SBV_RRK2",
                             cex.axis=1.2,cex.lab=1.5,
                             col=data_class$group_ligne,
                             pch=data_class$group_ligne))
     
     
      boxplot(SBV_RR2~group_ligne,data=data_class,ylab="SBV_RR2",xlab="lignee")
      boxplot(SBV_RR1~group_ligne,data=data_class,ylab="SBV_RR1",xlab="lignee")
      boxplot(SBV_RRK1~group_ligne,data=data_class,ylab="SBV_RRK1",xlab="lignee")
      boxplot(SBV_RRK2~group_ligne,data=data_class,ylab="SBV_RRK2",xlab="lignee")
      boxplot(SBV_SAD2~group_ligne,data=data_class,ylab="SBV_SAD2",xlab="lignee")
      boxplot(SBV_SAD1~group_ligne,data=data_class,ylab="SBV_SAD1",xlab="lignee")
      
      
      
      
      
      
       plot(data_class$SBV_RR1, data_class$SBV_RR2, col=data_class$group_ligne)
 
      
       plot(data_class1$SBV_RR1, data_class1$SBV_RR2, col=data_class1$group_ligne)
       
       plot(data_class1$SBV_SAD1, data_class1$SBV_SAD2, col=data_class1$group_ligne)
       
       
       table(data_class$grEBV_SAD,data_class$group_ligne)
       
       
       
       
       
       
           
      
        legend(
        "topright", 
        pch=c(1,15,24), 
        col=c("red","green","blue"),
        legend=c("A", "B","C")
      )
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      










par(mfrow = c(1,2),
    
    mar=c(5,5,0.5,0.5))

with(data_class, plot(e1_all,e2_all,xlab="E1_K_RROP",ylab="E2_K_RROP",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","blue","green")[data_class$grEBV],
                      pch=c(1, 15, 24)[data_class$grEBV]))



with(data_class, plot(in1_all,in2_all,xlab="E1_G_RROP",ylab="E2_G_RROP",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","blue","green")[data_class$grEBV],
                      pch=c(1, 15, 24)[data_class$grEBV]))


with(data_class, plot(E1,E2,xlab="E1_G_SAD",ylab="E2_G_SAD",
                      cex.axis=1.2,cex.lab=1.5,
                      col=c("red","blue","green")[data_class$grEBV_SAD], 
                      pch = c(1, 15, 24)[data_class$grEBV_SAD]))


legend("topright",
       legend=c("A", "B","C"),bty="n",cex = 1.5,  pt.cex = 1.5,horiz = TRUE,
       inset=c(-0.2,0),title="group",
       col=c("red","blue","green"),
       pch=c(1,15,24) )



dev.off()




######################################################################################




gr_data=mydf2[,c(1,12:15)]
gr_data2=merge(gr_data,mydata,by=c("animal"))


library(ggplot2)








ggplot(gr_data2, aes(x=temps, y=poidsheb, colour=grBW, group=animal)) +
  
  #geom_ribbon(aes(fill=grBW), alpha=0.2) +
  
  
  
  #geom_ribbon(aes(ymin=Heritability-sd, ymax=Heritability+sd, fill=group), alpha=0.2) +
  
  
  geom_line(aes(color=grBW),size=2) +
  
  #???geom_errorbar(aes(ymin=min, ymax=max, colour=grBW,linetype=grBW), width=.4,
  #position=position_dodge(0.05))+
  
  
  
  
  
  #geom_point(aes(fill = grBW,shape = grBW))+
  
  
#scale_colour_manual(name="Error Bars",values=cols, guide = guide_legend(fill = NULL,colour = NULL)) + 
scale_fill_manual(values=cols, guide="none") +
  
  
  scale_x_continuous(breaks=4:13) +
  
  labs(list(y="BW (Kg)", x="week"),size=20) +
  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  
  theme(axis.text.x=element_text(angle=0, hjust=1,size=20),axis.text.y=element_text(angle=0, hjust=1,size=20)) +
  scale_fill_brewer(type="qual", palette=2) +
  scale_color_brewer(type="qual", palette=2) +
  theme(axis.title.x = element_text( size=22))+
  theme(axis.title.y = element_text(size=22))+
  
  #ggtitle("Heritability over time")+
  theme(legend.title=element_blank())+
  guides(color = guide_legend(nrow=3))+
  theme(legend.text = element_text(colour="blue", size = 24))+  
  theme(legend.key.size = unit(2, 'lines'))+
  theme(plot.title = element_text(lineheight=5, face="bold", color="black", size=24))





#ggtitle("Heritability over time")  + 
#theme(legend.title=element_blank())+  #remove legend
#theme(legend.text = element_text(colour="blue", size = 20, face = "bold"))+
#theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))
M=testdf
k <- ncol(M) #number of variables
n <- nrow(M) #number of subjects

#create means for each column



M_mean <- matrix(data=1, nrow=n) %*% cbind(mean(M$EBV4),mean((M$EBV5),mean(M$EBV6),mean(M$EBV7),mean(M$EBV8),mean(M$EBV9),mean(M$EBV10),mean(M$EBV11),mean(M$EBV12),mean(M$EBV13))) 

#creates a difference matrix
D <- M - M_mean

#creates the covariance matrix


C <- (D*t(D))/(n-1)



+xlab("week")
