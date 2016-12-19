## Plot 4 plots 4 line graph of global active power, voltage, energy sub
## metering and global reactive power for dates 2007-02-01 and 2007-02-02

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format = "%d/%m/%Y"))

dataFile <- "../household_power_consumption.txt"
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c("myDate", "character", rep("numeric", 7)))
rawData <- rawData[with(rawData, rawData$Date == as.Date("2007-02-01") |
                                rawData$Date == as.Date("2007-02-02")),]
good <- complete.cases(rawData$Date, rawData$Time, rawData$Global_active_power,
                       rawData$Global_reactive_power, rawData$Voltage,
                       rawData$Sub_metering_1, rawData$Sub_metering_2,
                       rawData$Sub_metering_3)
png(file = "plot4.png")
dateTime = as.POSIXct(paste(rawData$Date[good], rawData$Time[good]),
                      format = "%Y-%m-%d %H:%M:%S")

par(mfrow = c(2, 2))

## Plot row 1 and column 1
plot(dateTime, rawData$Global_active_power[good], type = "l",
     ylab = "Global Active Power", xlab = "")

## Plot row 1 and column 2
plot(dateTime, rawData$Voltage[good], type = "l", ylab = "Voltage",
     xlab = "datetime")

## Plot row 2 and column 1
plot(dateTime, rawData$Sub_metering_1[good], type = "l",
                ylab = "Energy sub metering", xlab = "")
lines(dateTime, rawData$Sub_metering_2[good], type = "l", col = "red")
lines(dateTime, rawData$Sub_metering_3[good], type = "l", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot row 2 and column 2
plot(dateTime, rawData$Global_reactive_power[good], type = "l",
     ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
