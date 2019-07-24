




he2601 <- read.csv("C:/Users/tranh/Google Drive/these/sujet2/momo_hete.csv", 
                         ";", escape_double = FALSE, trim_ws = TRUE)


mydataHe=subset(he2601,group=="RR-OP"|group=="SAD")
mydataHe$group=ifelse(mydataHe$group=="RR-OP","RR",mydataHe$group)
mydataHe$week=c(rep(1:10,2))


mydataHe=momo_hete
















library(ggplot2)


ggplot(mydataHe, aes(x=week, y=Heritability, colour=group, group= group)) +
  
  #geom_ribbon(aes(ymin=lower.2.5., ymax=upper.97.5., fill=group), alpha=0.2) +
  
  
  
  #geom_ribbon(aes(ymin=Heritability-sd, ymax=Heritability+sd, fill=group), alpha=0.2) +
  
  
  geom_line(aes(linetype=group,color=group),size=2) +
  
  #geom_errorbar(aes(ymin=min, ymax=max, colour=group,linetype=group), width=.4,
  #position=position_dodge(0.05))+
  
  
  
  
  
  geom_point(aes(fill = group,shape = group))+
  
  
  #scale_colour_manual(name="Error Bars",values=cols, guide = guide_legend(fill = NULL,colour = NULL)) + 
  #scale_fill_manual(values=cols, guide="none") +
  
  
  scale_x_continuous(breaks=1:10) +
  
    labs(list(y="Heritability", x="week"),size=20) +
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



##################################################################################################





library(reshape2)
qplot(x=var1, y=var2, data=, fill=value,geom="tile")



