hhold_pwr_cons <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", header = T)

hhold_pwr_cons$Date <- as.Date(hhold_pwr_cons$Date, format = "%d/%m/%Y")
hhold_pwr_cons$Date_time <- with(hhold_pwr_cons, strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))
hhold_pwr_cons <- tbl_df(hhold_pwr_cons)
hhold_pwr_cons <- filter(hhold_pwr_cons, Date == "2007-02-01" | Date == "2007-02-02")
hhold_pwr_cons <- hhold_pwr_cons %>% mutate_each_(funs(as.numeric), 
                                                  3:ncol(hhold_pwr_cons))

#plot4
png("plot4.png")
par(mfrow = c(2, 2))

with(hhold_pwr_cons, plot(Date_time, Global_active_power,
                          main = NULL, type = "l",
                          ylab = "Global Active Power"))

with(hhold_pwr_cons, plot(Date_time, Voltage,
                          main = NULL, type = "l",
                          ylab = "Voltage", xlab = "datetime"))

with(hhold_pwr_cons, plot(Date_time, Sub_metering_1, main = NULL, type = "l",
                          ylab = "Energy sub metering",xlab = ""))
with(hhold_pwr_cons, lines(Date_time, Sub_metering_2, col = "red"))
with(hhold_pwr_cons, lines(Date_time, Sub_metering_3, col = "blue"))
legend("topright", legend = paste0("Sub_metering_",1:3), 
       col = c("black", "red", "blue"), lwd = 1, bty = "n", cex = 1)

with(hhold_pwr_cons, plot(Date_time, Global_reactive_power,
                          main = NULL, type = "l", xlab = "datetime"))

dev.off()
