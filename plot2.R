# CHANGE HERE TO THE FOLDER WHERE "household_power_consumption.txt" IS LOCATED IN YOUR COMPUTER
setwd("C:/R")

# Read the text file with the data to be treated
dat <- read.table(file = "household_power_consumption.txt", header=TRUE, sep=";", colClasses = "character")

# Define the classes of the columns imported
for(i in colnames(dat)){ # for each column of the dataset
  # set Date to date format
  if (i == "Date") dat$Date <- as.Date(dat$Date, format='%d/%m/%Y')
  # create a new column "datetime" with Date and Time concatenated, in a time format
  else if (i == "Time"){
    aux <- paste(dat$Date, dat$Time)
    dat$datetime <- strptime(aux, format="%Y-%m-%d %H:%M:%S")
  }
  # set the other columns to numeric class
  else dat[, i] <- as.numeric(dat[, i] )
}

# Filter the ocurrences with the Dates of interest
dat_f <- dat[which(dat$Date == "2007-02-02" | dat$Date == "2007-02-01"),]


### Create plot2 ###


## Open png file
png("plot2.png",  width = 480, height = 480)

## Create the graphic with plot function
with(dat_f, plot(datetime, Global_active_power, # use datetime and Global_active_power columns
                 type = "l", # use a line graph
                 ylab = "Global Active Power (kilowatts)", xlab = "")) # define x and y axis labels

## x axis values are in portuguese, where Qui = Thu, Sex = Fri, Sab = Sat

## Close and generate the png file
dev.off() 

