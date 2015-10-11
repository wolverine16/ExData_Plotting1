plot4 <- function(){
  ## Read data
  filename <- "household_power_consumption.txt"
  linestoread <- 70000
  
  datacols <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric"
                , "numeric", "numeric")
  
  nachar <- c("?")
  
  powerdata <- read.table(filename, header = TRUE, sep = ";", nrows = linestoread, 
                          colClasses = datacols, na.strings = nachar, row.names = NULL)
  
  powerdata$fmtDateTime <- strptime(paste(powerdata$Date, powerdata$Time), 
                                    format = "%d/%m/%Y %H:%M:%S")
  
  ## Create subset from 2007-02-01 and 2007-02-02
  powersubset <- powerdata[((powerdata$fmtDateTime > "2007-01-31 23:59:00")&(powerdata$fmtDateTime < "2007-02-03 00:00:00")),]
  
  ## Create histogram and write to file
  meterplotfile <- "plot4.png"
  
  png(filename = meterplotfile, width = 480, height = 480, units = "px", pointsize = 12)
  
  par(mfrow = c(2,2))
  plot(powersubset$fmtDateTime, powersubset$Global_active_power, type = "l",
       ylab = "Global Active Power", xlab = "")
  plot(powersubset$fmtDateTime, powersubset$Voltage, type = "l",
       ylab = "Voltage", xlab = "datetime")
  
  plot(powersubset$fmtDateTime, powersubset$Sub_metering_1, type = "n",
       ylab = "Energy sub metering", xlab = "")
  lines(powersubset$fmtDateTime, powersubset$Sub_metering_1, type = "l")
  lines(powersubset$fmtDateTime, powersubset$Sub_metering_2, type = "l", col = c("red"))
  lines(powersubset$fmtDateTime, powersubset$Sub_metering_3, type = "l", col = c("blue"))
  legend("topright", col = c("black","red","blue"), pt.cex = 1, cex = 0.75, lwd = c(2,2,2),
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(powersubset$fmtDateTime, powersubset$Global_reactive_power, type = "l",
       ylab = "Global_reactive_power", xlab = "datetime")
  
  dev.off()
  
}