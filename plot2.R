## Electric Power Consumption Exploratory Graphs

##  Overall goal is to examine how household energy usage varies over a 2 day
##  period in February, 2007

## plot2 goal: graph global active power vs thu, fri, and sat

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


## Adding columns that separates the column "Date" by dotw, mth, yr, day
library(lubridate)
dataset$wday <- wday(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$month <- month(dmy(dataset$Date), label = TRUE, abbr = TRUE)
dataset$year <- year(dmy(dataset$Date))
dataset$day <- day(dmy(dataset$Date))
head(dataset)

## creating new set with only data from Feb 2007
feb <- subset(dataset, month == "Feb" & year == 2007)
head(feb)
summary(feb)

## Creating new dataset with first 3 days of Feb

feb2 <- subset(feb, day <= 3)
summary(feb2)
feb2$Global_active_power <- as.numeric(feb2$Global_active_power)
feb2$hour <- strptime(paste(feb2$Date, feb2$Time, sep = " "), "%d/%m/%Y %H:%M:%S")
head(feb2)

with(feb2, plot(hour, Global_active_power, type = "l",
                ylab = "Global Active Power (kilowatts)",
                xlab = "",
                main = "Global Active Power"))
dev.copy(png, file = "plot2.png")
dev.off()


