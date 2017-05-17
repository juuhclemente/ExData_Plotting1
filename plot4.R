# CHANGE HERE TO THE FOLDER WHERE "household_power_consumption.txt" IS LOCATED IN YOUR COMPUTER
setwd("C:/R")
setwd("C:/Users/sb042583/Documents/R")
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



### Create plot4 ###


## Open png file
png("plot4.png", width = 480, height = 480)

## Define a 4x4 space to plot the graphics
par(mfrow=c(2,2))

### Plot the first graphic: Global Active Power
with(dat_f, plot(datetime, Global_active_power, # use datetime and Global_active_power columns
                 type = "l", # use a line graph
                 ylab = "Global Active Power", xlab = "")) # define x and y axis labels


### Plot the second graphic: Voltage
with(dat_f, plot(datetime, Voltage, # use datetime and Voltage columns
                 type = "l")) # use a line graph
      # no need to define x and y axis labels, they will have the same name of the columns


### Plot the third graphic: Sub_meterings
with(dat_f, plot(datetime, Sub_metering_1, # use datetime and Sub_metering_1 columns
                 type = "l", # use a line graph
                 xlab = "", ylab = "Energy sub metering"))  # define x and y axis labels

## Add a line graph of variable Sub_metering_2 to the plot graph
with(dat_f, lines(datetime, Sub_metering_2, # use datetime and Sub_metering_2 columns
                  col = "red")) # set the color of the new variable line 

## Add a line graph of variable Sub_metering_3 to the plot graph
with(dat_f, lines(datetime, Sub_metering_3, # use datetime and Sub_metering_3 columns
                  col = "blue")) # set the color of the new variable line 

## Include a legend in the graph
legend("topright", # Set the legend position
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), # Set the legend content
       lty=c(1,1,1), # Include a line indication in front of each legend
       col = c("black", "red", "blue")) # Set the line color of each legend


### Plot the fourth graphic: 
with(dat_f, plot(datetime, Global_reactive_power, # use datetime and Global_reactive_power columns
                 type = "l")) # use a line graph
        # no need to define x and y axis labels, they will have the same name of the columns

## x axis values are in portuguese, where Qui = Thu, Sex = Fri, Sab = Sat

## Close and generate the png file
dev.off()