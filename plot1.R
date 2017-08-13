# Code for plot1
library(lubridate)
library(dplyr)
library(sqldf)
library(tidyr)
powerData <- 
    read.csv.sql(file = "household_power_consumption.txt",
                 sql = "select * from file where [Date] == '1/2/2007' or [Date] == '2/2/2007'", sep = ';')
# The two colums *Date* and *Time* would be better combined and converted to a date/time.
powerData <- unite(powerData, DateTime, c(Date, Time), remove = TRUE, sep =":")

# Now change the Date values into date types
powerData %<>% mutate(DateTime=dmy_hms(DateTime))

# Create an write out the plot
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 12, bg="white")
hist(powerData$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency", main = "Global Active Power")
dev.off()