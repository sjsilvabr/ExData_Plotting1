# Data Science Specialization - Johns Hopkins University on Coursera
# Course 4 - Exploratory Data Analysis
# Course Project 1 by Sidclay da Silva
# Plot 4
# October 2016

# Function to download the dataset, prepare the data, and plot in a PNG file
plot4 <- function(){
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
      png('./plot4.png', width=480, height=480, units='px')
      
      # Set the output to 2x2 graphs
      par(mfcol=c(2,2))
      
      # Plot on top left
      with(vDatasetData, plot(Time, Global_active_power, type='l', 
                              xlab='', ylab='Global Active Power'))

      # Plot on bottom left
      # Initiate the plot with the black line (1)
      with(vDatasetData, plot(Time, Sub_metering_1, type='l', 
                              xlab='', ylab='Energy sub metering'))

      # Annotate the graph adding the read (2) and blue (3) lines
      with(vDatasetData, points(Time, Sub_metering_2, type='l', col='red'))
      with(vDatasetData, points(Time, Sub_metering_3, type='l', col='blue'))

      # Annotate the graph adding the legend
      legend('topright', pch='_', col=c('black','red','blue'), 
             legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
             bty = 'n')

      # Plot on top right
      with(vDatasetData, plot(Time, Voltage, type='l', 
                              xlab='datetime', ylab='Voltage'))
      
      # Plot on bottom right
      with(vDatasetData, plot(Time, Global_reactive_power, type='l', 
                              xlab='datetime', ylab='Global_reactive_power'))
      
      # Close graphics device
      dev.off()
      
}