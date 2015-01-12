################################################################################
#
#      Coursera 'Exploratory Data Analysis' Class Project 2 - Plot 5
#
# Author: Chip Boling
#   Date: Jan 12, 2015
#
#################################################################################
#
# Task: This script helps to answer question 5 from the Project Description:
#
#   5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
#
#      The plotting output for this file will be named 'plot4.png'
#
#################################################################################
# set the working directory to match that of this script
setwd(dirname(parent.frame(2)$ofile))
plotFile <- './plot5.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
