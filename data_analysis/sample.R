parks <- read.xlsx("data/ParkBeachOpen10_output4-12-13.xlsx", 1)
parks <- parks[parks$race_eth_code == 9 & parks$geotype == "CT" & parks$county_name=="San Diego",]
parks$TRACT <- as.numeric(lapply(strsplit(parks$geoname, " "), '[', 3))

regions <- read.xlsx("data/assist_tables/census_subregion.xlsx", 1)
parks$region <- merge(parks, regions, all.x=T)[,"NAME"]
ppark <- aggregate(parks$p_parkacc, list(parks$region), mean)
colnames(ppark) <- c("Geography", "Parks")
final <- merge(ppark, mood_dis.edit)