# Data Science Specialization - Johns Hopkins University on Coursera
# Course 4 - Exploratory Data Analysis
# Course Project 1 by Sidclay da Silva
# Plot 1
# October 2016

# Function to download the dataset, prepare the data, and plot in PNG file
plot1 <- function(){
      # Load required packages
      library(dplyr)
      library(lubridate)
      
      # Define the path and name to download the ZIP file
      vZipPath <- './EletricPowerConsumption.zip'
      
      # Check if the required file already exists, if not download it
      if (!file.exists(vZipPath)){
            # Download the data set from the provided URL
            vURL1 <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
            download.file(vURL1, vZipPath, method = 'curl')
      }
      
      # Load the dataset from the ZIP file
      vDatasetFile <- unz(vZipPath, 'household_power_consumption.txt')
      vDatasetData <- read.table(vDatasetFile, header=TRUE, sep=';', 
                                 row.names=NULL, na.strings='?', 
                                 colClasses=c('character','character',rep('numeric',7)), 
                                 nrows=2075259, comment.char='')
      
      # Subset the Dataset to take only required dates
      vDatasetData <- subset(vDatasetData, Date=='1/2/2007' | Date=='2/2/2007')
      
      # Coerce the variable Time from character to POSIXct POSIXt
      vDatasetData <- mutate(vDatasetData, Time = dmy_hms(paste(Date, Time, sep=' ')))
      
      # Coerce the variable Date from character to date
      vDatasetData <- mutate(vDatasetData, Date = dmy(Date))
      
      # Set the graphics devide to PNG file
      png('./plot1.png', width=480, height=480, units='px')
      
      # Plot the data
      hist(pcData2$Global_active_power, col='red', main='Global Active Power', 
           xlab='Global Active Power (kilowatts)')
      
      # Close graphics device
      dev.off()
      
}