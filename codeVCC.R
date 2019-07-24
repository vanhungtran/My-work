library(ggplot2)




library(readxl)

# dataVCC$group=dataVCC$model
# 
# dataVCC=subset(dataVCC,week<13)
# dataVCC=subset(dataVCC,week>7)
# dataVCC=subset(dataVCC,group=="RROP"|group=="SAD")
# dataVCC$group=ifelse(dataVCC$group=="RROP","RR",dataVCC$group)


# dataVCC <- read_delim("C:/Users/vhtran/Google Drive/these/sujet2/VCC1212.csv", 
#                  ";", escape_double = FALSE, trim_ws = TRUE)

dataVCC <- read.csv2("C:/Users/tranh/Google Drive/these/sujet2/VCC30072018.csv")


dataVCC$group=dataVCC$model
dataVCC=subset(dataVCC,model!="DIAGH")
# 
#dataVCC=subset(dataVCC,week<13)
# dataVCC=subset(dataVCC,week>7)


dataVCC$week=dataVCC$week-3


dataVCC = subset(dataVCC,week>4)
dataVCC = subset(dataVCC,week<10)


#ggplot(dataVCC, aes(x=week, y=VCC, colour=group, group= group)) +
ggplot(dataVCC, aes(x=week, y=VCC, colour=group, group= group)) +


  
  #geom_ribbon(aes(ymin=lower.2.5., ymax=upper.97.5., fill=group), alpha=0.2) +
  
  
  
 # geom_ribbon(aes(ymin=meanFCR-SDFCR, ymax=meanFCR+SDFCR, fill=group), alpha=0.2) +
  
  
  geom_line(aes(linetype=group,color=group),size=2) +
  
# geom_errorbar(aes(ymin=meanFCR-SDFCR, ymax=meanFCR+SDFCR, colour=group,linetype=group), width=.4,
#  position=position_dodge(0.05))+
  
  
  
  
  
  geom_point(aes(fill = group,shape = group))+
  
  
  scale_colour_manual(name="Error Bars",values=cols, guide = guide_legend(fill = NULL,colour = NULL)) + 
  scale_fill_manual(values=cols, guide="none") +
  
  ylim(0,0.5)+
  scale_x_continuous(breaks=5:9) +
  
  labs(list(y="VCC", x="week"),size=20) +
  #"Prediction error variation"
   #Mean Squared Error
   #"Sum of Squared Errors"
  
  #???labs(list(y="R2 (Pearson correlation coefficient)", x="week"),size=20) +
  theme_bw() + 
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))+
  
  theme(axis.text.x=element_text(angle=0, hjust=1,size=20),axis.text.y=element_text(angle=0, hjust=1,size=20)) +
  scale_fill_brewer(type="qual", palette=2) +
  scale_color_brewer(type="qual", palette=2) +
  theme(axis.title.x = element_text( size=22))+
  theme(axis.title.y = element_text(size=22))+
  
  #ggtitle("VCC over time")+
  #ggtitle("correlation over time")+
  theme(legend.title=element_blank())+
  guides(color = guide_legend(nrow=3))+
  theme(legend.text = element_text(colour="blue", size = 24))+  
  theme(legend.key.size = unit(2, 'lines'))+
  theme(plot.title = element_text(lineheight=5, face="bold", color="black", size=24))





#ggtitle("Heritability over time")  + 
#theme(legend.title=element_blank())+  #remove legend
#theme(legend.text = element_text(colour="blue", size = 20, face = "bold"))+
#theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))









FCR=c(2.24,2.22,2.40,2.39,2.39,2.50,2.53,2.56,2.71,2.72)
SD=c(0.45,0.42,0.43,0.42,0.37,0.37,0.43,0.43,0.50,0.52)
min=FCR-SD
max=FCR+SD
group=c(rep("FCR±SD",10))
week=c(1:10)
mydataHe=as.data.frame(week, FCR,SD,max,min,group)



ggplot(mydataHe, aes(x=week, y=FCR, colour=group, group= group)) +
  
  #geom_ribbon(aes(ymin=lower.2.5., ymax=upper.97.5., fill=group), alpha=0.2) +
  
  
  
  #geom_ribbon(aes(ymin=Heritability-sd, ymax=Heritability+sd, fill=group), alpha=0.2) +
  
  
  geom_line(aes(linetype=group,color=group),size=2) +
  
  geom_errorbar(aes(ymin=min, ymax=max, colour=group,linetype=group), width=.4,
                position=position_dodge(0.05))+
  
  
  
  
  
  geom_point(aes(fill = group,shape = group))+
  
  
  scale_colour_manual(name="Error Bars",values=cols, guide = guide_legend(fill = NULL,colour = NULL)) + 
  scale_fill_manual(values=cols, guide="none") +
  
  ylim(0,3.5)+
  scale_x_continuous(breaks=1:10) +
  
  labs(list(y="Feed conversion ratio ± SD (kg feed /kg gain) ", x="Week"),size=20) +
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


























