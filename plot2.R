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
# set the working directory to match that of this script
setwd(dirname(parent.frame(2)$ofile))
plotFile <- './plot2.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
