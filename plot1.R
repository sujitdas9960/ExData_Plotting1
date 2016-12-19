## Plot 1 plots histogram of global active power for dates 2007-02-01 and
## 2007-02-02

setClass('myDate')
setAs("character","myDate", function(from) as.Date(from, format = "%d/%m/%Y"))

dataFile <- "../household_power_consumption.txt"
rawData <- read.table(dataFile, header = TRUE, sep = ";", na.strings = "?",
                        colClasses = c("myDate", "character",
                                       rep("numeric", 7)))
rawData <- rawData[with(rawData, rawData$Date == as.Date("2007-02-01") |
                                rawData$Date == as.Date("2007-02-02")),]
good <- complete.cases(rawData$Global_active_power)

png(file = "plot1.png")
hist(rawData$Global_active_power[good],
        col = "red", xlab = "Global Active Power (kilowatts)",
        main = "Global Active Power")

dev.off()
