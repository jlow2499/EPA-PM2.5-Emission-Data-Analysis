###Read the data frame into R
df <- read.csv("household_power_consumption.txt", sep=";",stringsAsFactors=FALSE,dec=".")

###subset the data for the dates of 2/1/2007$ & 2/2/2007
df2 <- df[which(df$"Date" %in% c("1/2/2007","2/2/2007")),]

###subset the global active power vector for the plot
globalactivepower<-as.numeric(df2$"Global_active_power")

###set the plot width and height & create the PNG file
png("plot1.png",width=480,height=480)

###draw the histogram without the y axis
hist(globalactivepower,col="red",main="Global Active Power",xlab="Global Active Power (kilowats)",yaxt="n")

###label the y axis to match the required plot
axis(2, at =seq(0,1200,by=200),las=2)