my.data <- read.csv("activity.csv", stringsAsFactors = FALSE)
my.data[,"date"]<- as.Date(my.data[,"date"])
steps.day <- aggregate(steps ~ date, my.data, sum)
#ggplot(data = steps.day, aes(x=date, y=steps))+geom_bar(stat = "identity")

ggplot(steps.day, aes(x = steps)) + geom_histogram(binwidth = 1000)
mean(steps.day$steps)
median(steps.day$steps)

steps.interval <- aggregate(steps ~ interval, my.data, mean)
ggplot(steps.interval, aes(x=interval, y=steps)) + geom_line()

#Missing values
sum(is.na(my.data$steps))
#Non missing values
sum(!is.na(my.data$steps))

my.data.clean <- my.data
nas <-is.na(my.data.clean$steps)
my.data.mean <- join(my.data2, steps.interval, by="interval")
my.data.clean[nas,"steps"] <-my.data.mean[nas,4]
my.data.clean <- aggregate(steps ~ date, my.data.clean, sum)
ggplot(my.data.clean, aes(x = steps)) + geom_histogram(binwidth = 1000)

week <- mutate(my.data, day=ifelse(weekdays(date)=="Sunday" | weekdays(date)=="Saturday","Weekend","Weekday"))
steps.interval2 <- aggregate(steps ~ interval+day, week, mean)
ggplot(steps.interval2, aes(x=interval, y=steps, colour=day)) + geom_line()
