## read the electricity data into memory
electricityData <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

electricityData$Date <- as.Date(electricityData$Date, format = "%d/%m/%Y")

## cut out any dates that are not Feb 1, 2007 or Feb 2, 2007
feb1 <- electricityData[(electricityData$Date == "2007-01-02"),]
feb2 <- electricityData[(electricityData$Date == "2007-02-02"),]
feb1to2 <- rbind(feb1,feb2)

## doublecheck that only feb 1 and feb 2 are in the feb1to2 dataframe
levels(as.factor(feb1to2$Date))

## convert the Time column to times using strptime()
feb1to2$Time <- strptime(paste(feb1to2$Date,feb1to2$Time), "%Y-%d-%m %H:%M:%OS")

## convert global active power column from factors to numbers
gap <- as.numeric(as.character(feb1to2$Global_active_power))

## flatten the list of lists to a list of numerics
gap <- unlist(gap)

## tell R that I want the plot to be generated in a png file
png(
    filename = "plot2.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12,
    bg = "transparent" )

## plot the line for plot 2 in the png file
## hist(gap, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power", breaks = 20)
plot(feb1to2$Time, gap, 
     type="l", 
     ylab = "Global Active Power (kilowatts)", 
     xlab = "" )

## close the png file
dev.off()

