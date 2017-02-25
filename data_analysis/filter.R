require(openxlsx)
require(dplyr)
require(plyr)

# university coastal = la jolla
# palomar-julian?
# mid-city = san diego
# anza borrego springs
# laguna pine valley
# north sd = rancho santa fe
mood_dis <- read.csv("data/Mood_Disorders_Hospitalization_2010-2013.csv", header=T)
mood_dis.edit <- mood_dis[mood_dis$YEAR == 2010, ]
mood_dis.edit <- mood_dis.edit[mood_dis.edit$UrbanicitySort != 99, ]
mood_dis.edit$Geography <- as.character(mood_dis.edit$Geography)
mood_dis.edit$Geography[mood_dis.edit$Geography == "San Dieguito"] <- "Encinitas"
mood_dis.edit$Geography[mood_dis.edit$Geography == "Del Mar-Mira Mesa"] <- "Del Mar"
mood_dis.edit$Geography[mood_dis.edit$Geography == "Palomar-Julian"] <- "Julian"
mood_dis.edit$Geography[mood_dis.edit$Geography == "University Coastal"] <- "La Jolla"
mood_dis.edit$Geography[mood_dis.edit$Geography == "Anza-Borrego Springs"] <- "Borrego Springs"
mood_dis.edit$Geography[mood_dis.edit$Geography == "Laguna-Pine Valley"] <- "Pine Valley"
mood_dis.edit$Geography[mood_dis.edit$Geography == "North San Diego"] <- "Rancho Santa Fe"
sd <- data.frame(mood_dis.edit[sapply("San Diego", grepl, mood_dis.edit$Geography),])
sd <- rbind(sd, mood_dis.edit[mood_dis.edit$Geography == "Mid-City",])
mood_dis.edit <- rbind.fill(mood_dis.edit, data.frame(Geography="San Diego", Age_Adjusted_Rate=mean(sd$Age_Adjusted_Rate)))
#write.csv(mood_dis.edit, "js/data/mood_disorders.csv")

parks <- read.xlsx("data/HCI_PovertyRate_754_CT_PL_CO_RE_CA_1-22-14.xlsx", 1)
parks <- parks[parks$race_eth_code == 9 & parks$geotype == "PL" & !is.na(parks$rate) & parks$county_name=="San Diego",]
parks$Geography <- gsub("\\s*\\w*$", "", parks$geoname)
#write.csv(parks, "js/data/parks_filtered.csv")
final <- merge(parks, mood_dis, by="Geography")

fit <- cor(final$Age_Adjusted_Rate, final$rate)
fit
#write.csv(final, "data_analysis/mood_poverty.csv")
