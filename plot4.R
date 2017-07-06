library(dplyr)
##Set Working directory
setwd("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Exploratory Data Analysis/Week1/CourseProject")
path2file <- "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Exploratory Data Analysis/Week1/CourseProject/data/household_power_consumption.txt"

rawData <- read.csv(path2file, sep = ";")
##Subset the original file
rawDf <- tbl_df(rawData)
##Delete de raw variable
rm("rawData")

##Subset the data
dataDf <- rawDf %>% filter(Date == '1/2/2007' | Date== '2/2/2007')
rm("rawDf")

##Mutate the colums
dataDf <- dataDf %>% mutate(
    Date = as.Date(Date, format = "%d/%m/%Y"), Global_active_power = as.numeric(Global_active_power),
    Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage),
    Global_intensity = as.numeric(Global_intensity),    Sub_metering_1 = as.numeric(Sub_metering_1),
    Sub_metering_2 = as.numeric(Sub_metering_2),Sub_metering_3 = as.numeric(Sub_metering_3),
    completeDate = as.POSIXct(paste(Date,Time)))

##Open the PNG Device
png(filename = "plot4.png", width = 480, height = 480, units = "px")
##Plot
par(mfrow=c(2,2))
##Active power Plot
plot(dataDf$completeDate, dataDf$Global_active_power,lty=1,type="l", xlab = "", ylab = "Global Active Power(kilowatts)")
##Voltage Plot
plot(dataDf$completeDate, dataDf$Voltage,lty=1,type="l", xlab = "datetime", ylab = "Voltage")
##Combine Plot
plot(dataDf$completeDate, dataDf$Sub_metering_1, lty=1, type="l", xlab = "", ylab = "Energy sub metering")
lines(dataDf$completeDate, dataDf$Sub_metering_2, lty=1, type="l", col = "red")
lines(dataDf$completeDate, dataDf$Sub_metering_3, lty=1, type="l", col = "#8E44AD")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_1"), lty = c (1,1,1), lwd = c(2,2,2), col = c("black", "red", "#8E44AD"))
##Global reactive Plot
plot(dataDf$completeDate, dataDf$Global_reactive_power,lty=1,type="l", xlab = "datetime", ylab = "Global_reactive_power")
##Close the device
dev.off()

