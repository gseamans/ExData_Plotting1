# Code for plot3
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
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg="white")
plot(as.POSIXlt(powerData$DateTime), powerData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(as.POSIXlt(powerData$DateTime), powerData$Sub_metering_2, type="l", col = "red")
lines(as.POSIXlt(powerData$DateTime), powerData$Sub_metering_3, type="l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd=2.5, col=c("black", "red", "blue"))
dev.off()