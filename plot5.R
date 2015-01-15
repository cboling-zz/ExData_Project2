################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 5
#
# Author: Chip Boling
#   Date: Jan 15, 2015
#
#################################################################################
#
# Task: This script helps to answer question 5 from the Project Description:
#
#   5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#
#      The plotting output for this file will be named 'plot4.png'
#
#################################################################################
library(reshape)
#################################################################################
plotFile <- './plot5.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subset SCC codes down to all vehicle types
vehicleSCC   <- SCC[grep("[V|v]ehicle", SCC$Short.Name),]
vehicleCodes <- vehicleSCC$SCC

# Subset the data to Baltimore City (fips=24510) and Vehicle SCC
baltimoreNEI <- NEI[NEI$fips=="24510" & NEI$SCC %in% vehicleCodes,]

# Melt the data so we can recast it to a simple object with the year and sum of the
# emissions from all sources
moltenData      <- melt(baltimoreNEI, id=c('year'), measure.vars=c('Emissions'))
emissionsByYear <- cast(moltenData, year~variable, sum)

# Also can get average emission count per year (in case # data sources different each year)
avgEmissionsByYear <- cast(moltenData, year ~ variable, mean)

#######################################################
# Use base plotting package barplot to show the results

par(mfrow=c(1,2))
par(mar=c(5.1,4.1,6.1,2.1))
barplot(emissionsByYear$Emissions, main='Total Emissions by year', xlab='Year',
        ylab='Total Emissions (tons)', names=emissionsByYear$year)
barplot(avgEmissionsByYear$Emissions, main='Average Emissions by Year', xlab='Year',
        ylab='Avg Emissions (tons)', names=avgEmissionsByYear$year)
mtext("PM2.5 Vehicle Emissions (Baltimore City, MD)",
      side=3, line=-1.3, outer=TRUE, cex=1.5)
dev.copy(png, file=plotFile, width=640, height=480)
dev.off()
