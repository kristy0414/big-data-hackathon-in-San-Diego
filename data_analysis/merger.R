mood <- read.csv("data_analysis/mood_crime.csv")
essential <- c("Geography", "Age_Adjusted_Rate", "rate")
mood_essential <- mood[,essential]

mood2 <- read.csv("data_analysis/mood_food.csv")
essential <-  c("Geography", "Age_Adjusted_Rate", "affordability_ratio")
mood_essential <- merge(mood_essential, mood2[,essential], all=T)

mood3 <- read.csv("data_analysis/mood_ozone.csv")
essential <-  c("Geography", "Age_Adjusted_Rate", "O3_unhealthy_days")
mood_essential <- merge(mood_essential, mood3[,essential], all=T)

mood4 <- read.csv("data_analysis/mood_parks.csv")
essential <-  c("Geography", "Age_Adjusted_Rate", "Parks")
mood_essential$Geography <- toupper(mood_essential$Geography)
mood_essential <- merge(mood_essential, mood4[,essential], all=T)

mood5 <- read.csv("data_analysis/mood_poverty.csv")
essential <- c("Geography", "Age_Adjusted_Rate", "Poverty")
mood_essential <- merge(mood_essential, mood5[,essential], all=T)

mood6 <- read.csv("data_analysis/mood_unemployment.csv")
essential <- c("Geography", "Age_Adjusted_Rate", "UnemploymentRate")
mood_essential <- merge(mood_essential, mood6[,essential], all=T)

mood_essential$Geography <- as.character(mood_essential$Geography)
mood_essential$Geography[mood_essential$Geography == "SAN DIEGUITO"] <- "ENCINITAS"
mood_essential$Geography[mood_essential$Geography == "DEL MAR-MIRA MESA"] <- "DEL MAR"
mood_essential$Geography[mood_essential$Geography == "PALOMAR-JULIAN"] <- "JULIAN"
mood_essential$Geography[mood_essential$Geography == "UNIVERSITY COASTAL"] <- "LA JOLLA"
mood_essential$Geography[mood_essential$Geography == "ANZA-BORREGO SPRINGS"] <- "BORREGO SPRINGS"
mood_essential$Geography[mood_essential$Geography == "LAGUNA-PINE VALLEY"] <- "PINE VALLEY"
mood_essential$Geography[mood_essential$Geography == "NORTH SAN DIEGO"] <- "RANCHO SANTA FE"
sd <- data.frame(mood_essential[sapply("SAN DIEGO", grepl, mood_essential$Geography),])
sd <- rbind(sd, mood_essential[mood_essential$Geography == "MID-CITY",])
san_diego_main <- sd[sd$Geography=="SAN DIEGO",]
sd <- sd[!sd$Geography=="SAN DIEGO",]
mood_essential <- rbind.fill(mood_essential, data.frame(Geography="SAN DIEGO", Age_Adjusted_Rate=mean(sd$Age_Adjusted_Rate),
                                                                               Parks=mean(sd$Parks),
                                                                               Poverty=mean(sd$Poverty),
                                                                               UnemploymentRate=mean(sd$UnemploymentRate)))

moodx <- aggregate(mood_essential, list(mood_essential$Geography), min, na.rm=T, na.action="NA")
moodx$Geography <- moodx$Group.1
write.csv(moodx[-1], "data_analysis/mood_disorder_pred.csv")
