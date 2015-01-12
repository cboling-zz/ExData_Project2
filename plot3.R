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
# set the working directory to match that of this script
this.dir <- dirname(parent.frame(2)$ofile)
setwd(this.dir)
plotFile <- './plot3.png'

# Read in the data files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")
