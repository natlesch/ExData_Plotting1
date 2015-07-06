#download, extract, etc. data files
if(!file.exists("data")){dir.create("data")}
if(!file.exists("data/household_power_consumption.zip"))
{
  fileURI <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURI,destfile="data/household_power_consumption.zip")
}
if(!file.exists("data/household_power_consumption.txt"))
{
  unzip("data/household_power_consumption.zip", exdir="data")
}

#read data and set column names
bulkDS <- read.table("data/household_power_consumption.txt", sep=";", header=FALSE, skip = 66637, nrows = 2880)
names(bulkDS)<- c("readDate","readTime","globalActivePower","globalReactivePower","Voltage","Global_intensity","SubMetering1","SubMetering2","SubMetering3")

#create vector for histogram
histogramDS <- bulkDS[,c(3)]

#open png device, create historam and save file
png(file = "plot1.png", width=480, height=480)
hist(histogramDS, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()