################################################################################

#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 1
#
# Author: Chip Boling
#   Date: Jan 8, 2015
#
#################################################################################
#
# Task: This script helps to answer question 1 from the Project Description:
#
#   1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
#
#      Using the base plotting system, make a plot showing the total PM2.5 emission from all
#      sources for each of the years 1999, 2002, 2005, and 2008.
#
#      The plotting output for this file will be named 'plot1.png'
#
#################################################################################
library(reshape)
#################################################################################
plotFile <- './plot1.png'

# Read in the data file
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Melt the data so we can recast it to a simple object with the year and sum of the
# emissions from all sources

moltenData <- melt(NEI, id=c('year'), measure.vars=c('Emissions'))
emissionsByYear <- cast(moltenData, year~variable, sum)

# Note: Also can get average emission count per year (in case # data sources different
#       each year with the formula:

avgEmissionsByYear <- cast(moltenData, year ~ variable, mean)

#######################################################
# Use base plotting package barplot to show the results

par(mfrow=c(1,2))

barplot(emissionsByYear$Emissions, main='PM2.5 Total Emissions', xlab='Year',
        ylab='Total Emissions (tons)', names=emissionsByYear$year)
barplot(avgEmissionsByYear$Emissions, main='Average Emissions by Year', xlab='Year',
        ylab='Avg Emissions (tons)', names=avgEmissionsByYear$year)

dev.copy(png, file=plotFile, width=640, height=480)
dev.off()

