plot2 <- function(){
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
  lineplotfile <- "plot2.png"
  
  png(filename = lineplotfile, width = 480, height = 480, units = "px", pointsize = 12)
  
  plot(powersubset$fmtDateTime, powersubset$Global_active_power, type = "l",
       ylab = "Global Active Power (kilowatts)", xlab = "")
  
  dev.off()
  
}