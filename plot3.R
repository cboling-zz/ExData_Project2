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
library(grid)
library(gridExtra)
#################################################################################
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

# Note: Also can get average emission count per year (in case # data sources different
#       each year with the formula:

avgEmissionsByYear <- as.data.frame(as.table(cast(moltenData, year~type~variable, mean)))
names(avgEmissionsByYear)[1]<-'Year'
names(avgEmissionsByYear)[2]<-'Type'
names(avgEmissionsByYear)[4]<-'Emissions'

# First and last year value so we can plot overall trend line (dots)
first    <- head(emissions$Year,1)
last     <- tail(emissions$Year,1)

# Now plot the results
p1 <- ggplot(emissions, aes(x=Year, y=Emissions, group=Type, color=Type))
p1 <- p1 + geom_point(size=3)
p1 <- p1 + geom_line()
p1 <- p1 + geom_line(linetype='dotted',data=subset(emissions, Year==first | Year==last),
                     aes(x=Year, y=Emissions,group=Type, color=Type))
p1 <- p1 + theme(legend.position="none")
p1 <- p1 + ylab('PM2.5 Total Emissions (tons)')
p1 <- p1 + ggtitle('Total Emissions by Type')

p2 <- ggplot(avgEmissionsByYear, aes(x=Year, y=Emissions, group=Type, color=Type))
p2 <- p2 + geom_point(size=3)
p2 <- p2 + geom_line()
p2 <- p2 + geom_line(linetype='dotted',data=subset(avgEmissionsByYear, Year==first | Year==last),
                     aes(x=Year, y=Emissions,group=Type, color=Type))
p2 <- p2 + ylab('PM2.5 Avg Emissions (tons)')
p2 <- p2 + ggtitle('Average Emissions by Type')

grid.arrange(p1, p2, ncol = 2, main = "PM2.5 Emissions By Type for Baltimore City, MD")

dev.copy(png, file=plotFile, width=980, height=640)
dev.off()
