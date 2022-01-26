## Electric Power Consumption Exploratory Graphs

##  Overall goal is to examine how household energy usage varies over a 2 day
##  period in February 2007. Since it was unspecified as to which days, 
##  I chose the first two days

## plot1: Create histogram of global active power

## Import file
file_name <- "Electric Power Consumption.zip"
if (!file.exists(file_name)) {
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   download.file(url, file_name, method = "curl") 
}
if (!file.exists("household_power_consumption.txt")) {
    unzip(file_name)
}

dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)
head(dataset)
summary(dataset)

dataset$Global_active_power <- as.numeric(dataset$Global_active_power)
summary(dataset)


## Adding columns that separates the column "Date" by dotw, mth, yr, day
library(lubridate)
dataset$wday <- wday(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$month <- month(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$year <- year(dmy(dataset$Date))
dataset$day <- day(dmy(dataset$Date))
head(dataset)

## Creating new set with only data from the first two days of Feb 2007
feb <- subset(dataset, month == "Feb" & year == 2007 & day <= 2)
summary(feb)

## Create histogram and make into .png
hist(feb$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png")
dev.off()




