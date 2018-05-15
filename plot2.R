hhold_pwr_cons <- read.table("household_power_consumption.txt", sep = ";", colClasses = "character", header = T)

hhold_pwr_cons$Date <- as.Date(hhold_pwr_cons$Date, format = "%d/%m/%Y")
hhold_pwr_cons$Date_time <- with(hhold_pwr_cons, strptime(paste(Date, Time), format = "%Y-%m-%d %H:%M:%S"))
hhold_pwr_cons <- tbl_df(hhold_pwr_cons)
hhold_pwr_cons <- filter(hhold_pwr_cons, Date == "2007-02-01" | Date == "2007-02-02")
hhold_pwr_cons <- hhold_pwr_cons %>% mutate_each_(funs(as.numeric), 
                                                  3:ncol(hhold_pwr_cons))

#plot2
png("plot2.png")
with(hhold_pwr_cons, plot(Date_time, Global_active_power,
                          main = NULL, type = "l",
                          ylab = "Global Active Power (kilowatts)"))
dev.off()