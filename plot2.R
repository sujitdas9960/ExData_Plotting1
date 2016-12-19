## Plot 2 plots line graph of global active power for dates 2007-02-01 and
## 2007-02-02

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format = "%d/%m/%Y"))

dataFile <- "../household_power_consumption.txt"
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c("myDate", "character", rep("numeric", 7)))
rawData <- rawData[with(rawData, rawData$Date == as.Date("2007-02-01") |
                                rawData$Date == as.Date("2007-02-02")),]
good <- complete.cases(rawData$Date, rawData$Time, rawData$Global_active_power)
png(file = "plot2.png")
plot(as.POSIXct(paste(rawData$Date[good], rawData$Time[good]),
                                                format = "%Y-%m-%d %H:%M:%S"),
                rawData$Global_active_power[good], type = "l",
                ylab = "Global Active Power (kilowatts)", xlab = "")

dev.off()
