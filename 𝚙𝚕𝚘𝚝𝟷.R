library(dplyr)

##LOAD DATA AND SUBSET
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
day1 <- subset(data, (as.character(data$Date) == "1/2/2007"))
day2 <- subset(data, (as.character(data$Date) == "2/2/2007"))
twodaydata <- rbind(day1, day2)

##TRANSFORM DATE AND TIME -> DATETIME
twodaydata <- mutate(twodaydata, datetime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S"))
twodaydata <- select(twodaydata, -Date, -Time)

##PLOT & WRITE TO FILE
png(filename = "plot1.png",width = 480, height = 480)
hist(twodaydata$Global_active_power, col="red", main="Global Active Power", ylab="Frequency", xlab="Global Active Power (kilowatts)")
dev.off()