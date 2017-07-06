library(dplyr)
##Set Working directory
setwd("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Exploratory Data Analysis/Week1")
path2file <- "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Exploratory Data Analysis/Week1/data/household_power_consumption.txt"

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
png(filename = "plot1.png", width = 480, height = 480, units = "px")
##Plot the histogram for Global_active_power
hist(dataDf$Global_active_power, main = "Global Active Power", xlab = "Global Active Power(kilowatts)", col = "red")
##Close the device
dev.off()

