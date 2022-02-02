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

png(file = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
with(hpc, {
        plot(DateTime, Global_active_power, 
             xlab = "", ylab = "Global Active Power (kilowatt)", type = "l")
        plot(DateTime, Voltage, xlab = 'datetime', ylab = 'Voltage', type = 'l')
        plot(DateTime, Sub_metering_1, 
             xlab = '', ylab = 'Energy sub metering', type = 'l')
        lines(DateTime, Sub_metering_2, col = 'red')
        lines(DateTime, Sub_metering_3, col = 'blue')
        legend('topright', col = c('black', 'red', 'blue'), 
               legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
               lwd = 1)
        plot(DateTime, Global_reactive_power,
             xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l')
}
     )
dev.off()
