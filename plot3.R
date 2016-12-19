## Plot 3 plots line graph of energy sub metering for dates 2007-02-01 and
## 2007-02-02

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format = "%d/%m/%Y"))

dataFile <- "../household_power_consumption.txt"
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c("myDate", "character", rep("numeric", 7)))
rawData <- rawData[with(rawData, rawData$Date == as.Date("2007-02-01") |
                                rawData$Date == as.Date("2007-02-02")),]
good <- complete.cases(rawData$Date, rawData$Time, rawData$Sub_metering_1,
                       rawData$Sub_metering_2, rawData$Sub_metering_3)
png(file = "plot3.png")
dateTime = as.POSIXct(paste(rawData$Date[good], rawData$Time[good]),
                      format = "%Y-%m-%d %H:%M:%S")
plot(dateTime, rawData$Sub_metering_1[good], type = "l",
                ylab = "Energy sub metering", xlab = "")
lines(dateTime, rawData$Sub_metering_2[good], type = "l", col = "red")
lines(dateTime, rawData$Sub_metering_3[good], type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
