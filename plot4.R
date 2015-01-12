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
# set the working directory to match that of this script
setwd(dirname(parent.frame(2)$ofile))
plotFile <- './plot4.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
