################################################################################
#
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
suppressPackageStartupMessages(library(data.table))
library(data.table)
#################################################################################
# Load the data, use read.table since fread has some issues with '?' as NA but the
# workaround below is still orders of magnitude faster that read.table
#
plotFile <- './plot1.png'

# Read in the data files

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#
