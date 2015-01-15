################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 4
#
# Author: Chip Boling
#   Date: Jan 12, 2015
#
#################################################################################
#
# Task: This script helps to answer question 4 from the Project Description:
#
#   4. Across the United States, how have emissions from coal combustion-related sources
#      changed from 1999–2008?
#
#      The plotting output for this file will be named 'plot4.png'
#
#################################################################################
library(reshape)
#################################################################################
plotFile <- './plot4.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subset SCC codes down to all coal-types and then just combustible
SCC_coal <- SCC[grep("[C|c]oal", SCC$Short.Name),]
SCC_coal <- SCC_coal[grep("[C|c]omb", SCC_coal$Short.Name),]
coalCombustCodes <- SCC_coal$SCC

# Subset the NEI data to just the coal combustion SCC codes

# Subset the data for Baltimore (fips=24510)
coalNEI <- NEI[NEI$SCC %in% coalCombustCodes,]

# Melt the data so we can recast it to a simple object with the year and sum of the
# emissions from all sources
moltenData <- melt(coalNEI, id=c('year'), measure.vars=c('Emissions'))
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
mtext("PM2.5 Coal Combustion Emissions (Entire United States)",
      side=3, line=-1.3, outer=TRUE, cex=1.5)
dev.copy(png, file=plotFile, width=640, height=480)
dev.off()

