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

parks <- read.xlsx("data/ParkBeachOpen10_output4-12-13.xlsx", 1)
parks <- parks[parks$race_eth_code == 9 & parks$geotype == "CT" & parks$county_name=="San Diego",]
parks$TRACT <- as.numeric(lapply(strsplit(parks$geoname, " "), '[', 3))

regions <- read.xlsx("data/assist_tables/census_subregion.xlsx", 1)
parks$region <- merge(parks, regions, all.x=T)[,"NAME"]
ppark <- aggregate(parks$p_parkacc, list(parks$region), mean)
colnames(ppark) <- c("Geography", "Parks")
final <- merge(ppark, mood_dis.edit)

fit <- cor(final$Age_Adjusted_Rate, final$Parks)
fit
write.csv(final, "data_analysis/mood_parks.csv")
