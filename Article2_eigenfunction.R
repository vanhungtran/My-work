#K=matrix(c(0.01729, 0.06725, -0.05178, 0.001413, 0.02553, -0.2159, -0.0003917, -0.001984, 0.00331),3,3)






# K=matrix(c(0.1627E-01,  0.2445E-02 ,  0.2489E-03,
#            0.2445E-02,  0.2303E-01, -0.1748E-03,
#            0.2489E-03, -0.1748E-03 ,  0.3318E-02),3,3)
# 



K=matrix(c(  0.1592E-01 , 0.2335E-02 ,    0.2383E-03,
             0.2335E-02 , 0.2555E-01,  0.1425E-02 ,  
             0.2383E-03 , 0.1425E-02 , 0.4075E-02),3,3)




# K=matrix(c(67.15 ,    25.54    ,   3.811,
# 25.54 ,      94.39  ,    3.317,
# 3.811  ,     3.317  ,    22.79),3,3)





# K=matrix(c(0.1652E-01, 0.1905E-02, -0.6185E-03,
#             0.1905E-02,  0.2197E-01, -0.2209E-02  ,
#             -0.6185E-03 ,-0.2209E-02 , 0.3119E-02),3,3)


eigen(K)

E=(eigen(K))$vectors



M=t(matrix(c(1, -1, 1, 1, 0, 0, 1, 1, 1),3,3))
M
hat=t(matrix(c(0.7071, 0, -0.7906,0, 1.2247, 0,0, 0, 2.3717),3,3))
hat
Phi=M%*%hat
Phi





eifun=Phi%*%E

week=4:13
t=-1+2*(week-4)/(13-4)


Eigenvalue=0.024
0.015
0.003

E1=eifun[1,1]+t*eifun[2,1]+t^2*(eifun[3,1])
E2=eifun[1,2]+t*eifun[2,2]+t^2*(eifun[3,2])
E3=eifun[1,3]+t*eifun[2,3]+t^2*(eifun[3,3])

group=c(rep("EV=0.024",10),rep("EV=0.015",10),rep("EV=0.003",10))

plot(t,E1)
plot(t,E2,add=TRUE)
plot(t,E3,add=T)

matplot(week, cbind(E1,E2,E3),type="l",col=c("red","green","blue"),lty=c(1,1,1))

dfa=data.frame(week,E1,E2,E3)


ggplot(dfa, aes(t)) +                    # basic graphical object
  geom_line(aes(y=E1), colour="red") +  # first layer
  geom_line(aes(y=E2), colour="green")+  # second layer
  geom_line(aes(y=E3), colour="blue")



library(reshape2)

aql <- melt(dfa, id.vars = c("week"))
aql$group=group

aql=subset(aql,variable!="E3")

aql$week = as.vector(c(rep(1:10,2)))

aql$group=ifelse(aql$variable=="E1","First eigenfunction","Second eigenfunction")
library(ggplot2)


png(file="eigenfunction.png",width=2600,height=1200,res=150)


ggplot(aql, aes(x=week, y=value, colour=group, group=group)) +
  
  #geom_ribbon(aes(ymin=lower.2.5., ymax=upper.97.5., fill=group), alpha=0.2) +
  
  
  
  #geom_ribbon(aes(ymin=Heritability-sd, ymax=Heritability+sd, fill=group), alpha=0.2) +
  
  
  geom_line(aes(linetype=group,color=group),size=2) +
  
  #geom_errorbar(aes(ymin=min, ymax=max, colour=group,linetype=group), width=.4,
  # position=position_dodge(0.05))+
  
  
  
  
  
  geom_point(aes(fill = group,shape = group))+
  
  
  #scale_colour_manual(name="Error Bars",values=cols, guide = guide_legend(fill = NULL,colour = NULL)) + 
  #scale_fill_manual(values=cols, guide="none") +
  
  
  scale_x_continuous(breaks=1:10) +
  
  labs(list(y="Eigenfunction values", x="Week"),size=16) +
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
  theme(legend.text = element_text(colour="blue", size = 20))+  
  theme(legend.key.size = unit(2, 'lines'))+
  theme(plot.title = element_text(lineheight=5, face="bold", color="black", size=24))



dev.off()

#ggtitle("Heritability over time")  + 
#theme(legend.title=element_blank())+  #remove legend
#theme(legend.text = element_text(colour="blue", size = 20, face = "bold"))+
#theme(plot.title = element_text(lineheight=3, face="bold", color="black", size=20))



