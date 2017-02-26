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
fit3<-rpart(Total_Rate~rate+dof_population+UrbanicitySort+SESSort
            +Male.c+Female.c+white.c+black.c+Hispanic.c+APIC.c+OREC.c
            +A1.c+A2.c+A3.c+A4.c,data=mcrime,control=my.control)
fit3.cp<-printcp(fit3)
plot(fit3,uniform = T,margin = 0.05)
text(fit3,use.n=T)


tree.pr<-prune(fit3,cp=(fit3$cptable[8,1]+fit3$cptable[9,1])/2)
plot(tree.pr,uniform=T,margin=0.05)
text(tree.pr,use.n=T)


park<-read.csv("mood_parks2.csv",header = T)
Male.c<-(park$Male_Cases/park$Male_Rate)
Female.c<-(park$Female_Cases/park$Female_Rate)
white.c<-park$White_Cases/park$White_Rate
black.c<-park$Black_Cases/park$Black_Rate
Hispanic.c<-park$Hispanic_Cases/park$Hispanic_Rate
APIC.c<-park$Asian_Pacific_Islander_Cases/park$Asian_Pacific_Islander_Rate
OREC.c<-park$Other_Race_Ethnicity_Cases/park$Other_Race_Ethnicity_Rate
A1.c<-park$Age_Group_0_to_14_Cases/park$Age_Group_0_to_14_Rate
A2.c<-park$Age_Group_15_to_24_Cases/park$Age_Group_15_to_24_Rate
A3.c<-park$Age_Group_25_to_44_Cases/park$Age_Group_25_to_44_Rate
A4.c<-park$Age_Group_65Plus_Cases/park$Age_Group_65Plus_Rate
fit2<-rpart(Total_Rate~p_parkacc+UrbanicitySort+SESSort
            +Male.c+Female.c+white.c+black.c+Hispanic.c+APIC.c+OREC.c
            +A1.c+A2.c+A3.c+A4.c,data=park,control=my.control)
printcp(fit2)
plot(fit2,uniform = T,margin = 0.2)
text(fit2,use.n=T)

tree.prp<-prune(fit2,cp=(fit3$cptable[8,1]+fit2$cptable[9,1])/2)
plot(tree.prp,uniform=T,margin=0.05)
text(tree.prp,use.n=T)

library("rpart")
mood<-read.csv("mood.csv",header = T)

my.control<-rpart.control(cp=0,xval=10)
Male.t<-(mood$Male_Cases/mood$Male_Rate)
Female.t<-(mood$Female_Cases/mood$Female_Rate)
white.t<-mood$White_Cases/mood$White_Rate
black.t<-mood$Black_Cases/mood$Black_Rate
Hispanic.t<-mood$Hispanic_Cases/mood$Hispanic_Rate
APIC.t<-mood$Asian_Pacific_Islander_Cases/mood$Asian_Pacific_Islander_Rate
OREC.t<-mood$Other_Race_Ethnicity_Cases/mood$Other_Race_Ethnicity_Rate
A1.t<-mood$Age_Group_0_to_14_Cases/mood$Age_Group_0_to_14_Rate
A2.t<-mood$Age_Group_15_to_24_Cases/mood$Age_Group_15_to_24_Rate
A3.t<-mood$Age_Group_25_to_44_Cases/mood$Age_Group_25_to_44_Rate
A4.t<-mood$Age_Group_65Plus_Cases/mood$Age_Group_65Plus_Rate
fit4<-rpart(Total_Rate~pop2010+UrbanicitySort+SESSort
            +Male.t+Female.t+white.t+black.t+Hispanic.t+APIC.t+OREC.t
            +A1.t+A2.t+A3.t+A4.t+percent+Unemployment_rate+p_parkacc,
            data=mood,control=my.control)
fit4.cp<-printcp(fit4)
plot(fit4,uniform = T,margin = 0.05)
text(fit4,use.n=T)


tree.prt<-prune(fit4,cp=(fit3$cptable[14,1]+fit4$cptable[15,1])/2)
plot(tree.prt,uniform=T,margin=0.02)
text(tree.prt,use.n=T)