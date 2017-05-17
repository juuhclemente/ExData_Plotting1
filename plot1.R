# CHANGE HERE TO THE FOLDER WHERE "household_power_consumption.txt" IS LOCATED IN YOUR COMPUTER
setwd("C:/R")

# Read the text file with the data to be treated
dat <- read.table(file = "household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character")

# Define the class of Global_active_power column
dat$Global_active_power <- as.numeric(dat$Global_active_power)

# Filter the ocurrences with the Dates of interest
dat_f <- dat[which(dat$Date == "2/2/2007" | dat$Date == "1/2/2007"),]



### Create plot1 ###


## Open png file

png("plot1.png", width = 480, height = 480)
## Create the graphic with histogram function
hist(dat_f$Global_active_power,  # use Global_active_power column
     main = "Global Active Power", # set the graph title
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", # define x and y axis labels
     col = "red") # set the color of the graph content
## Close and generate the png file
dev.off()


