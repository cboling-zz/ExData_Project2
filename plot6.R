################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 6
#
# Author: Chip Boling
#   Date: Jan 15, 2015
#
#################################################################################
#
# Task: This script helps to answer question 6 from the Project Description:
#
#   6. Compare emissions from motor vehicle sources in Baltimore City with emissions from
#      motor vehicle sources in Los Angeles County, California (fips == "06037").
#
#      Which city has seen greater changes over time in motor vehicle emissions?
#
#      The plotting output for this file will be named 'plot6.png'
#
#################################################################################
library(reshape2)
library(ggplot2)
library(grid)
library(gridExtra)
#################################################################################
plotFile <- './plot6.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

# Subset SCC codes down to all vehicle types
vehicleSCC   <- SCC[grep("[V|v]ehicle", SCC$Short.Name),]
vehicleCodes <- vehicleSCC$SCC

# Subset the data to Baltimore City (fips=24510) and Vehicle SCC
baltimoreNEI <- NEI[NEI$fips=="24510" & NEI$SCC %in% vehicleCodes,]

# Subset the data to Las Angelis County (fips=06037) and Vehicle SCC
losAngelesNEI <- NEI[NEI$fips=="06037" & NEI$SCC %in% vehicleCodes,]

# Melt the data so we can recast it to a simple object with the year and source type
# as the id and the emissions as the variable.  Then reshape these into a nice table
# that is easy to plot

moltenData_MD <- melt(baltimoreNEI, id=c('year'), measure.vars=c('Emissions'))
emissions_MD  <- dcast(moltenData_MD, year~variable, mean)
names(emissions_MD)[1] <- 'Year'
names(emissions_MD)[2] <- 'Emissions'
emissions_MD$Location  <- 'Baltimore City'
emissions_MD$NormalizedEmissions <- emissions_MD$Emissions/emissions_MD$Emissions[1]

moltenData_CA <- melt(losAngelesNEI, id=c('year'), measure.vars=c('Emissions'))
emissions_CA  <- dcast(moltenData_CA, year~variable, mean)
names(emissions_CA)[1] <- 'Year'
names(emissions_CA)[2] <- 'Emissions'
emissions_CA$Location  <- 'Los Angeles County'
emissions_CA$NormalizedEmissions <- emissions_CA$Emissions/emissions_CA$Emissions[1]

# Add rows of each to make our pivot table
emissions    <- rbind(emissions_MD, emissions_CA)

# Now plot the results
p1 <- ggplot(emissions, aes(x=Year, y=NormalizedEmissions, group=Location, color=Location))
p1 <- p1 + geom_point(size=3)
p1 <- p1 + geom_line()
p1 <- p1 + ylab('Average Emissions')
p1 <- p1 + ggtitle('Normalized Average Emissions by Year (Baltimore City vs Los Angeles County)')
print(p1)

dev.copy(png, file=plotFile, width=700, height=480)
dev.off()
