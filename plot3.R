## Function plot3 generates a line graph for Sub_metering_1,
## Sub_metering_2 and Sub_metering_3
## from 02/01/2007 and 02/02/2007 and overlays the graphs
##
##  Assumptions - 
##  - The file household_power_consumption.txt stores the data and is in the working directory
##  - First 70000 lines of the file cover the time window of 02/01/2007 and 02/02/2007
##  - Acceptable to save plot file to the working directory
plot3 <- function(){
  ## Read only 70000 lines of data from file
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
  powersubset <- powerdata[((powerdata$fmtDateTime > "2007-01-31 23:59:59")&(powerdata$fmtDateTime < "2007-02-03 00:00:00")),]
  
  ## Create png and write line graphs to file
  meterplotfile <- "plot3.png"
  
  png(filename = meterplotfile, width = 480, height = 480, units = "px", pointsize = 12)
  
  plot(powersubset$fmtDateTime, powersubset$Sub_metering_1, type = "n",
       ylab = "Energy sub metering", xlab = "")
  lines(powersubset$fmtDateTime, powersubset$Sub_metering_1, type = "l")
  lines(powersubset$fmtDateTime, powersubset$Sub_metering_2, type = "l", col = c("red"))
  lines(powersubset$fmtDateTime, powersubset$Sub_metering_3, type = "l", col = c("blue"))
  legend("topright", col = c("black","red","blue"), pt.cex = 1, cex = 0.75, lwd = c(1,1,1),
         legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  dev.off()
  
}