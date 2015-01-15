################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 2
#
# Author: Chip Boling
#   Date: Jan 12, 2015
#
#################################################################################
#
# Task: This script helps to answer question 2 from the Project Description:
#
#   2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#      (fips == "24510") from 1999 to 2008?
#
#      Use the base plotting system to make a plot answering this question.
#
#      The plotting output for this file will be named 'plot2.png'
#
#################################################################################
library(reshape)
#################################################################################
plotFile <- './plot2.png'

# Read in the data file
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Subset the data for Baltimore (fips=24510)
baltimoreNEI <- NEI[NEI$fips=="24510",]

# Melt the data so we can recast it to a simple object with the year and sum of the
# emissions from all sources

moltenData <- melt(baltimoreNEI, id=c('year'), measure.vars=c('Emissions'))
emissionsByYear <- cast(moltenData, year~variable, sum)

# Note: Also can get average emission count per year (in case # data sources different
#       each year with the formula:

avgEmissionsByYear <- cast(moltenData, year ~ variable, mean)

#######################################################
# Use base plotting package barplot to show the results

par(mfrow=c(1,2))

barplot(emissionsByYear$Emissions, main='Total Emissions For Baltimore City, MD',
        xlab='Year', ylab='PM2.5 Total Emissions (tons)', names=emissionsByYear$year)
barplot(avgEmissionsByYear$Emissions, main='Avg. Emissions (Baltimore City, MD)', xlab='Year',
        ylab='PM2.5 Avg Emissions (tons)', names=avgEmissionsByYear$year)

dev.copy(png, file=plotFile, width=980, height=640)
dev.off()
