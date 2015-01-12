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
# set the working directory to match that of this script
setwd(dirname(parent.frame(2)$ofile))
plotFile <- './plot2.png'

# Read in the data file
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Subset the data for Baltimore (fips=24510)
baltimoreNEI <- NEI[NEI$fips=="24510",]

# Melt the data so we can recast it to a simple object with the year and sum of the
# emissions from all sources

moltenData <- melt(baltimoreNEI, id=c('year'), measure.vars=c('Emissions'))
emissionsByYear <- cast(moltenData, year~variable, sum)

# Use base plotting package barplot to show the results

barplot(emissionsByYear$Emissions, main='PM2.5 Total Emissions For Baltimore City, Maryland',
        xlab='Year', ylab='Total Emissions (tons)', names=emissionsByYear$year)

dev.copy(png, file=plotFile, width=480, height=480)
dev.off()
