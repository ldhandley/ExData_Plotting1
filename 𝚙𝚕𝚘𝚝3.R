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
png(filename = "plot3.png",width = 480, height = 480)
with(twodaydata, plot(datetime,Sub_metering_1, type="n",xlab="", ylab="Energy sub metering"))
with(twodaydata, lines(datetime,Sub_metering_1, col="black"))
with(twodaydata, lines(datetime,Sub_metering_2, col="red"))
with(twodaydata, lines(datetime,Sub_metering_3, col="blue"))
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
dev.off()