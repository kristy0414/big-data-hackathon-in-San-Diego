require(openxlsx)
# university coastal = la jolla
# palomar-julian?
# mid-city = san diego
# anza borrego springs
# laguna pine valley
# north sd = rancho santa fe
mood_dis <- read.csv("data/Mood_Disorders_Hospitalization_2010-2013.csv", header=T)
mood_dis.edit <- mood_dis[mood_dis$YEAR == 2010, ]
mood_dis.edit <- mood_dis.edit[mood_dis.edit$UrbanicitySort != 99, ]
mood_dis.edit$Geography <- toupper(as.character(mood_dis.edit$Geography))

parks <- read.xlsx("data/HCI_PovertyRate_754_CT_PL_CO_RE_CA_1-22-14.xlsx", 1)
parks <- parks[parks$race_eth_code == 9 & parks$geotype == "CT" & !is.na(parks$percent) & parks$county_name=="San Diego",]
#parks$TRACT <- as.numeric(lapply(strsplit(parks$geoname, " "), '[', 3))
parks$TRACT <- as.numeric(parks$geoname)

regions <- read.xlsx("data/assist_tables/census_subregion.xlsx", 1)
parks$Geography <- merge(parks, regions, all.x=T)[,"NAME"]
#ppark <- aggregate(parks$Unemployment_rate, list(parks$region), mean)
#colnames(ppark) <- c("Geography", "UnemploymentRate")
final <- merge(parks, mood_dis.edit)

fit <- cor(final$Age_Adjusted_Rate, final$percent)
fit
write.csv(final, "data_analysis/mood_poverty2.csv")
