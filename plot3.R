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


#convert date and time factors to date and time classes
bulkDS$readDate <- as.Date(bulkDS$readDate, format = "%d/%m/%Y")
bulkDS$combinedDateTime <- with(bulkDS, (paste(readDate,readTime)))
bulkDS$combinedDateTime <- strptime(bulkDS$combinedDateTime, format="%Y-%m-%d %H:%M:%S")

#initiate graphics device, plot and save
png(file="plot3.png", width=480, height=480)

with(bulkDS, plot(combinedDateTime, SubMetering1, type="l", xlab=NA, ylab="Energy Sub Metering"))
with(bulkDS, points(combinedDateTime, SubMetering2, type="l", col="red"))
with(bulkDS, points(combinedDateTime, SubMetering3, type="l", col="blue"))
legend("topright", lty=c(1,1,1),col=c("black","red","blue"), legend=c("subMetering1","subMetering2","subMetering3"))

dev.off()


