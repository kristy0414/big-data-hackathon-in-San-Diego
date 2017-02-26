mcrime<-read.csv("mood_crime.csv",header = T)

my.control<-rpart.control(cp=0,xval=10)
Male.c<-(mcrime$Male_Cases/mcrime$Male_Rate)
Female.c<-(mcrime$Female_Cases/mcrime$Female_Rate)
white.c<-mcrime$White_Cases/mcrime$White_Rate
black.c<-mcrime$Black_Cases/mcrime$Black_Rate
Hispanic.c<-mcrime$Hispanic_Cases/mcrime$Hispanic_Rate
APIC.c<-mcrime$Asian_Pacific_Islander_Cases/mcrime$Asian_Pacific_Islander_Rate
OREC.c<-mcrime$Other_Race_Ethnicity_Cases/mcrime$Other_Race_Ethnicity_Rate
A1.c<-mcrime$Age_Group_0_to_14_Cases/mcrime$Age_Group_0_to_14_Rate
A2.c<-mcrime$Age_Group_15_to_24_Cases/mcrime$Age_Group_15_to_24_Rate
A3.c<-mcrime$Age_Group_25_to_44_Cases/mcrime$Age_Group_25_to_44_Rate
A4.c<-mcrime$Age_Group_65Plus_Cases/mcrime$Age_Group_65Plus_Rate
fit3<-rpart(total_Rate~rate+dof_population+UrbanicitySort+SESSort
            +Male.c+Female.c+white.c+black.c+Hispanic.c+APIC.c+OREC.c
            +A1.c+A2.c+A3.c+A4.c,data=mcrime,control=my.control)
fit3.cp<-printcp(fit3)
plot(fit3,uniform = T,margin = 0.05)

text(fit3,use.n=T)
min(fit3.cp[,4])

tree.pr<-prune(fit3,cp=(fit3$cptable[9,1]+fit3$cptable[10,1])/2)
plot(tree.pr,uniform=T,margin=0.05)
text(tree.pr,use.n=T)


park<-read.csv("mood_prak2.csv",header = T)
fit2<-rpart(total_Rate~p_parkacc,data=final,control=my.control)
printcp(fit2)
plot(fit2,uniform = T,margin = 0.2)
text(fit2,use.n=T)