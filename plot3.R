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

## convert the submetering factor columns to numeric format so it can be plotted
submeter1 <- as.numeric(as.character(feb1to2$Sub_metering_1))
submeter2 <- as.numeric(as.character(feb1to2$Sub_metering_2))
submeter3 <- feb1to2$Sub_metering_3

## tell R that I want the plot to be generated in a png file
png(
    filename = "plot3.png",
    width = 480,
    height = 480,
    units = "px",
    pointsize = 12,
    bg = "white" )

## plot the submetering 1 line in black and define the axis labels
plot(feb1to2$Time, submeter1, 
     type="l",
     col = "black",
     ylab = "Energy sub metering", 
     xlab = "")

## overlay the sub metering 2 line in red
lines(feb1to2$Time, submeter2, 
     col = "red")

## overlay the sub metering 3 line in blue
lines(feb1to2$Time, submeter3, 
     col = "blue")

## add a legend to the top right of the plot
legend("topright", col = c("black", "blue", "red"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1))

## close the png file
dev.off()

