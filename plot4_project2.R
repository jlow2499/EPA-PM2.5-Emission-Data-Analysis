###Read the NEI and SCC data sets into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC<-readRDS("Source_Classification_Code.rds")
###Merge the SCC & NEI Data Sets
NEI_SCC <- merge(NEI,SCC,by="SCC")
###Find all matches with coal in the short.name variable
coal<-grep("coal",NEI_SCC$Short.Name,ignore.case=TRUE)
###subset the coal matches from the NEI_SCC data frame
NEI_SCC_coal <- NEI_SCC[coal,]
###Find the aggregate sum of emissions for coal by year
totalstres <- aggregate(Emissions~year,NEI_SCC_coal,sum)
###Set the plot width and height & create the PNG file
png("plot4_project2.png",width=480,height=480)
###Draw a bar plot with the new totalstres data frame
###Color the plot for fun, coal theme? :-)
barplot(totalstres$"Emissions"/1000,
        names.arg=totalstres$"year",
        xlab="Year",
        ylab="PM2.5 Emissions - Thousands of Tons",
        main="Total PM2.5 Coal Emissions by Year",
        sub="Emissions have decreased since 1999",
        col="grey41",
        col.main="grey6",
        col.sub="grey6",
        col.lab="grey6",
        ylim=c(0,800))
###draw a regression line to show the trend
###create a regression model
model3<- lm(totalstres$"Emissions"/1000~totalstres$"year")
###predict the model to show the trend
prediction3 <- predict(model3)
###draw the regression line on the plot
lines(prediction3,col="grey6",lwd=4)

dev.off()