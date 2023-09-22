# Create a dataframe from a dataset

getwd()
df <- read.csv('opsd_germany_daily.csv') # github.com

head(df)
tail(df)
str(df)

# a dataframe were Date is the index column

data<- read.csv("opsd_germany_daily.csv", header = TRUE, row.names = "Date")

View(data) # View the data in a tabular format

dim(data)

str(data) # the data structure

head(data$Date) # looking at Date column
row.names(data) # looking at row names (indexes)

# Accessing specific rows

data["2008-08-13",]
data[c("2012-05-23","2014-10-07"),]

# Statistical values

summary(data)

# Conversion of a factor to date format
head(df$Date)
str(df$Date)
class(df$Date)

x<- as.Date(df$Date)
head(x)
class(x)
str(x)

# Create year, month and day columns from x

Year <- as.numeric(format(x,'%Y'))
head(Year)

Month <- as.numeric(format(x,'%m'))
head(Month)

Day <- as.numeric(format(x,'%d'))
head(Day)

# Add columns to the existing dataframe

df <- cbind(df, Year, Month, Day)
head(df)

head(sample(df, 8))

# Let's create a line plot of the ful time series of the Germany's
# daily electricity consumption using the dataframe's plot() methods

  # using plot()

    # Option 1

ts1 <- plot(df$Year, df$Consumption, type = 'l', xlab = "Years", 
            ylab = "Consumption")

    # Option 2

ts2 <- plot(df$Year, df$Consumption, type = 'l', xlab = "Years", 
            ylab = "Consumption", lty = 1, xlim = c(2006, 2018), 
            ylim = c(800, 1800))

    # Better options

    # Option 3 (for one plot/window)

par(mfrow = c(1,1))

plot(df[,2])

    # Option 4

plot(df[,2], xlab = 'Years', ylab = "Consumption")
plot(df[,2], xlab = 'Years', ylab = "Consumption", 
     type = 'l', lwd = 2, col = 'blue')
plot(df[,2], xlab = 'Years', ylab = "Consumption", 
     type = 'l', lwd = 2, xlim = c(0, 2018))
plot(df[,2], xlab = 'Years', ylab = "Consumption", 
     type = 'l', lwd = 2, xlim = c(2006, 2018))
plot(df[,2], xlab = 'Years', ylab = "Consumption", type = 'l', lwd = 2, 
     xlim = c(2006, 2018), ylim = c(800, 2000), main = "Electricity Consumption")

# Taking log values

plot(log(df[,2]), xlab = 'Years', ylab = "Consumption", type = 'l', lwd = 2, 
    ylim = c(-5, 5), main = "Electricity Consumption", col = "orange")

# USING ggplot()

library(ggplot2)
  
  # Option 1

ggplot(df, type = "o")+
  geom_line(aes(x = Year, y = Consumption ))

  # Option 2

ggplot(data = df, aes(x = Year, y = Consumption))+
  geom_line()+
  geom_point()

  # Option 3

ggplot(data = df, aes(x = Year, y = Consumption), group = 1)+
  geom_line(linetype = "dashed")+
  geom_point()

ggplot(data = df, mapping = aes(x = Year, y = Consumption, col = 'red'))+
  geom_point()

  # We can see that the plot() method has chosen pretty good locations
  # (every two years) and labels (the years) for the x-axis which is helpful
  # However, with so many points the line plot is cowded and hard to read.
  # Thus, we can go with plot


# Plot the data considering the Solar and Wind time series too

head(df)

# Consumption column
min(df[,2], na.rm = T)
max(df[,2], na.rm = T)

# Wind column
min(df[,3], na.rm = T)
max(df[,3], na.rm = T)

# Solar column
min(df[,4], na.rm = T)
max(df[,4], na.rm = T)

# Wind.Solar column
min(df[,5], na.rm = T)
max(df[,5], na.rm = T)

# Multiple plot per window
par(mfrow = c(3,1))

plot1<- plot(df[,2], xlab = 'Years', ylab = 'Daily total (Gwh)', type = 'l',
             lwd = 2, main = 'Consumption', col = 'orange')

plot1<- plot(as.Date(df[,1]), df[,2], xlab = 'Years', ylab = 'Daily total (Gwh)', 
             type = 'l',lwd = 2, main = 'Consumption', col = 'orange',
             ylim = c(840, 1750))

# Wind

plot2 <- plot(df[,3], xlab = "Years", ylab = "Daily total (Gwh)", type = "l",
              lwd = 2, main = "Wind", ylim = c(0, 900), col = "blue")
plot2 <- plot( as.Date(df[,1]), df[,3], xlab = "Years", ylab = "Daily total (Gwh)", type = "l",
              lwd = 2, main = "Wind", ylim = c(0, 900), col = "blue")

# Solar

plot3 <- plot(df[,4], xlab = "Years", ylab = "Daily total (Gwh)", type = "l",
              lwd = 2, main = "Solar", ylim = c(0, 500), col = "red")
plot3 <- plot( as.Date(df[,1]), df[,4], xlab = "Years", ylab = "Daily total (Gwh)", type = "l",
               lwd = 2, main = "Solar", ylim = c(0, 500), col = "red")

# One plot per window
par(mfrow = c(1,1))

# Let's plot the times series in a single year to investigate more

str(df)
x
str(x)

  # Conversion of Date column into Date format

date <- as.Date(x, format = "%Y%m%d")
head(date)

df1 <- cbind(date, df)
head(df1)
str(df1)

df2 <- subset(df1, subset = df1$date >= '2017-01-01' & df1$date <= '2017-12-31')
head(df2)

plot4 <- plot(df2[,1], df2[,3], xlab = "Dates", ylab = "Daily total (Gwh)", 
              type = "l",lwd = 2, main = "Consumption", col = "orange")


# Zooming in further

df3 <- subset(df1, subset = df1$date >= '2017-01-01' & df1$date <= '2017-02-28')
head(df3)

xmin <- min(df3[,1], na.rm = T)
xmax <- max(df3[,1], na.rm = T)
  xmin
  xmax

ymin <- min(df3[,3], na.rm = T)  
ymax <- max(df3[,3], na.rm = T)
  ymin
  ymax 

# Plot 
  
plot5 <- plot(df3[,1], df3[,3], xlab = "Dates", ylab = "Daily total (Gwh)", 
              type = "l",lwd = 2, main = "Consumption", col = "orange", 
              xlim = c(xmin, xmax), ylim = c(ymin, ymax))
grid()  

# Add horizontal lines
abline(h = c(1300, 1500, 1600))
# Add vertical lines
abline(v = seq(xmin, xmax, 7), lty = 2, col = "blue")

#==========================================================================

# Yearly seasonality determined by boxplots...

boxplot(df1$Consumption, main = 'Consumption')
boxplot(df1$Wind, main = 'Wind')
boxplot(df1$Solar, main = 'Solar')

  # A boxplot is a visual display of 5 numbers summary

quantile(df1$Consumption, probs = c(0.0, 0.25, 0.5, 0.75, 1))

boxplot(df1$Consumption, main = 'Consumption', ylab = 'Consumption',
        ylim = c(600, 1800))
  
  # Yearly
boxplot(df1$Consumption ~ df1$Year, main = 'Consumption', 
        ylab = 'Consumption', xlab = 'Years', ylim = c(600, 1800))  
        
boxplot(df1$Consumption ~ df1$Year, main = 'Consumption', 
        ylab = 'Consumption', xlab = 'Years', ylim = c(600, 1800), las = 1)

  # Monthly

boxplot(df1$Consumption ~ df1$Month, main = 'Consumption', 
        ylab = 'Consumption', xlab = 'Months', ylim = c(600, 1800), las = 1)

# Multiple plots
par(mfrow = c(3,1))

boxplot(df1$Consumption ~ df1$Month, main = 'Consumption', 
        ylab = 'Consumption', xlab = 'Months', ylim = c(600, 1800), 
        las = 1, col = 'red')

boxplot(df1$Wind ~ df1$Month, main = 'Wind', 
        ylab = 'Consumption', xlab = 'Months', ylim = c(0, 900), 
        las = 1, col = 'blue')

boxplot(df1$Solar ~ df1$Month, main = 'Solar', 
        ylab = 'Consumption', xlab = 'Months', ylim = c(0, 250), 
        las = 1, col = 'green')

# Monthly seasonality with daily boxplots

par(mfrow = c(1,1))

boxplot(df1$Consumption ~ df1$Day, main = 'Consumption', 
        ylab = 'Consumption', xlab = 'Months', ylim = c(600, 1800), 
        las = 1, col = 'red')

#==========================================================================
# Frequency of the data

head(df1)
library(dplyr)

summary(df1)
colSums(! is.na(df1)) 
sum(is.na(df1$Consumption)) # Number of na values in that column 
sum(is.na(df1$Wind)) # Number of na values in that column 
sum(is.na(df1$Solar)) # Number of na values in that column

# Frequencies
xmin <- min(df1[,1], na.rm = T); xmin

freq1<- seq(from = xmin, by = 'day', length.out = 5); freq1
typeof(freq1)
class(freq1)

freq2<- seq(from = xmin, by = 'month', length.out = 5); freq2

freq3<- seq(from = xmin, by = 'year', length.out = 5); freq3

# Let's select data which has NA values for Wind

selWind1 <- df1[which(is.na(df1$Wind)),
                names(df1) %in% c("date", "Consumption", "Wind", "Solar")]
selWind1[1:10,]
View(selWind1)

# Let's select data which does not have NA values for Wind

selWind2 <- df1[which(! is.na(df1$Wind)),
                names(df1) %in% c("date", "Consumption", "Wind", "Solar")]
selWind2[1:10,]
View(selWind2)

# Relying on the two results above, we can say that there are NA value in 2011 for Wind

# Let's select data which has NA value for Wind

selWind3 <- df1[which(df1$Year == "2011"),
                names(df1) %in% c("date", "Consumption", "Wind", "Solar")]
class(selWind3)
View(selWind3)

# Number of rows in resultant dataframe

nrow(selWind3)

# Number of NA values in that dataframe for Wind

sum(is.na(df1$Wind[which(df1$Year == "2011")]))

# Number of non-NA value for Wind in 2011

sum(! is.na(df1$Wind[which(df1$Year == "2011")]))

selWind4 <- selWind3[which(is.na(selWind3$Wind)),
                names(selWind3) %in% c("date", "Consumption", "Wind", "Solar")]

View(selWind4)

# Let's select a data with NA and non-NA value for Wind

selWind5 <- selWind3[which(selWind3$date > "2011-12-12" & selWind3$date < "2011-12-16"),
                     names(selWind3) %in% c("date", "Consumption", "Wind", "Solar")]

View(selWind5)

library(tidyr)

# Filling the missing value in selWind5

test1 <- selWind5 %>% fill(Wind) # Filling with up value
test1


#==============================================================

# Trends analysis, looking at rolling mean

install.packages("zoo")
library(zoo)

head(df1)
test_03da = zoo::rollmean(df1$Consumption, k = 3, fill = NA)
test_03da

three_day_test <- df1 %>%
  dplyr::arrange(desc(Year)) %>%
  dplyr::group_by(Year) %>%
  dplyr::mutate(test_03da = zoo::rollmean(Consumption, k = 3, fill = NA),)%>%
  dplyr::ungroup()
  
head(three_day_test)

  # In the result an e.g of 3 days test is:
  # 1367 = mean(c(1130, 1441, 1530))

# Let's calculate a 7 days and 365 days rolling mean

data_test <- df1 %>%
  dplyr::arrange(desc(Year)) %>%
  dplyr::group_by(Year) %>%
  dplyr::mutate(test_07da = zoo::rollmean(Consumption, k = 7, fill = NA),
                test_365da = zoo::rollmean(Consumption, k = 365, fill = NA),)%>%
  dplyr::ungroup()
head(data_test)

# Checking the results

data_test %>%
  dplyr::arrange(date) %>%
  dplyr::filter(Year == 2017)%>%
  dplyr::select(date,
                Consumption,
                test_07da:test_365da) %>%
  utils::head(7)

# Plot the rolling mean

par(mfrow = c(1,1))

plot(data_test$Consumption, xlab = "Years", ylab = "Consumption", type = "l",
     lwd = 2, col = 'blue', main = "Consumption graph")
points(data_test$test_07da, type = "l", lwd = 2,
       xlim = c(2000, 2018), ylim = c(900, 2000), col = "orange")
lines(data_test$test_365da, type = "l", lwd = 5,
       xlim = c(2000, 2018), ylim = c(900, 2000), col = "black")
legend(2500, 1700, 
       legend = c("data_test$Conumption", "data_test$test_07da","data_test$test_365da"),
       col = c("blue", "orange", "black"),
       pch = c("o", "*", "+"), lty = c(1,2,3), ncol = 1)

       
