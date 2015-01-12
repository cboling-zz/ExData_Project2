################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 3
#
# Author: Chip Boling
#   Date: Jan 12, 2015
#
#################################################################################
#
# Task: This script helps to answer question 3 from the Project Description:
#
#   3. Of the four types of sources indicated by the type (point, nonpoint, onroad,
#      nonroad) variable, which of these four sources have seen decreases in emissions from
#      1999–2008 for Baltimore City?
#
#      Which have seen increases in emissions from 1999–2008?
#
#      Use the ggplot2 plotting system to make a plot answer this question.
#
#      The plotting output for this file will be named 'plot3.png'
#
#################################################################################
library(reshape)
library(ggplot2)
#################################################################################
# set the working directory to match that of this script
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
plotFile <- './plot3.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")

# Subset the data for Baltimore (fips=24510)
baltimoreNEI <- NEI[NEI$fips=="24510",]

# Also convert type to a factor
baltimoreNEI$type <- as.factor(baltimoreNEI$type)

# Melt the data so we can recast it to a simple object with the year and source type
# as the id and the emissions as the variable.  Then reshape these into a nice table
# that is easy to plot

moltenData <- melt(baltimoreNEI, id=c('year','type'), measure.vars=c('Emissions'))
emissions  <- as.data.frame(as.table(cast(moltenData, year~type~variable, sum)))
names(emissions)[1]<-'Year'
names(emissions)[2]<-'Type'
names(emissions)[4]<-'Emissions'

# Now plot the results

p <- ggplot(emissions, aes(x=Year, y=Emissions, group=Type, color=Type))
p <- p + geom_point(size=3)
p <- p + geom_line(linetype='longdash')
p <- p + ylab('Total Emissions (tons)')
p <- p + ggtitle('PM2.5 Total Emissions by Type (for Baltimore City, Maryland)')
print(p)

dev.copy(png, file=plotFile, width=480, height=480)
dev.off()
