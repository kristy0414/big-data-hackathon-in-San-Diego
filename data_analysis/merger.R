require(xlsx)
require(dplyr)
require(plyr)

# university coastal = la jolla
# palomar-julian?
# mid-city = san diego
# anza borrego springs
# laguna pine valley
# north sd = rancho santa fe
mood_dis <- read.csv("data/mood_filtered.csv", header=T)
mood_dis.edit <- filter(mood_dis, YEAR==2010)
mood_dis.edit <- filter(mood_dis.edit, UrbanicitySort != 99)
mood_dis.edit$Geography <- as.character(mood_dis.edit$Geography)
mood_dis.edit$Geography[mood_dis.edit$Geography == "San Dieguito"] <- "Encinitas"
mood_dis.edit$Geography[mood_dis.edit$Geography == "Del Mar-Mira Mesa"] <- "Del Mar"
sd <- data.frame(mood_dis.edit[sapply("San Diego", grepl, mood_dis.edit$Geography),])
mood_dis.edit <- rbind.fill(mood_dis.edit, data.frame(Geography="San Diego", Age_Adjusted_Rate=mean(sd$Age_Adjusted_Rate)))
mood_dis <- mood_dis.edit

parks <- read.xlsx("data/park_data.xlsx", 1)
parks$Geography <- gsub("\\s*\\w*$", "", parks$geoname)

final <- merge(parks, mood_dis, by="Geography")

fit <- lm(Age_Adjusted_Rate ~ p_parkacc, data=final)
summary(fit)
