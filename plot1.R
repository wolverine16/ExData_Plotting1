## Function plot1 generates a histogram for Global active power
## from 02/01/2007 and 02/02/2007
##
##  Assumptions - 
##  - The file household_power_consumption.txt stores the data and is in the working directory
##  - First 70000 lines of the file cover the time window of 02/01/2007 and 02/02/2007
##  - Acceptable to save plot file to the working directory
plot1 <- function(){
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
  
  ## Create png file and write histogram to it
  histplotfile <- "plot1.png"
  
  png(filename = histplotfile, width = 480, height = 480, units = "px", pointsize = 12)
  hist(powersubset$Global_active_power, main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)", col = c("red"))
  dev.off()
  
}