tmp <- file("household_power_consumption.txt")
hpc <- read.table(na.strings = "?", sep = ";",
                  text = grep("^[1,2]/2/2007", readLines(tmp), value = TRUE),
                  col.names = c("Date", "Time", 
                                "Global_active_power", "Global_reactive_power", 
                                "Voltage", "Global_intensity", "Sub_metering_1",
                                "Sub_metering_2", "Sub_metering_3"))

png(file = "plot1.png", width = 480, height = 480, units = "px")
hist(hpc$Global_active_power, col = "red",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency",
     main = "Global Active Power")
dev.off()