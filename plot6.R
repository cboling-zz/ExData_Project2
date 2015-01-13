################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 6
#
# Author: Chip Boling
#   Date: Jan 12, 2015
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
plotFile <- './plot6.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
