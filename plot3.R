tmp <- file("household_power_consumption.txt")
hpc <- read.table(na.strings = "?", sep = ";",
                  text = grep("^[1,2]/2/2007", readLines(tmp), value = TRUE),
                  col.names = c("Date", "Time", 
                                "Global_active_power", "Global_reactive_power", 
                                "Voltage", "Global_intensity", "Sub_metering_1",
                                "Sub_metering_2", "Sub_metering_3"))

Sys.setlocale("LC_TIME", "C")
hpc$Date <- strptime(hpc$Date, "%e/%m/%Y")
hpc$DateTime <- as.POSIXct(paste(hpc$Date, hpc$Time))

png(file = "plot3.png", width = 480, height = 480, units = "px")
plot(hpc$DateTime, hpc$Sub_metering_1,
     xlab = "", ylab = "Energy sub metering", type = "l")
lines(hpc$DateTime, hpc$Sub_metering_2, col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1)
dev.off()