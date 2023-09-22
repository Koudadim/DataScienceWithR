setwd("C:/Users/asus/Desktop/Data Science with R")

#install.packages('datasets')
plot(ChickWeight)
View(ChickWeight)

# Base graphics

library(MASS)

plot(UScereal$sugars, UScereal$calories, title('Plot 1'))

x<-UScereal$sugars
y<-UScereal$calories

# grid graphics

library(grid)

pushViewport(plotViewport())
pushViewport(dataViewport(x,y))
grid.rect()
grid.xaxis()
grid.yaxis()
grid.points(x,y)
grid.text("UScereal$calories", x=unit(-3, "lines"), rot = 90)
grid.text("UScereal$sugars", y=unit(-3, "lines"), rot = 0)

popViewport(2)

# Creating a bar chart using the aesthetics parameters in geom_bar function

library(ggplot2)
head(mpg, n=10)

str(mpg)
#??str

#install.packages("tidyverse")

library(tidyverse)

ggplot(mpg)+geom_bar(aes(x = class))
ggplot(mpg)+geom_bar(aes(x = class, fill="blue"))
ggplot(mpg)+geom_bar(aes(x = class, fill=drv))

View(mpg)

# Creatin side-by-side (dodged) bar plots using the position=position_dodge()

ggplot(mpg)+
  geom_bar(aes(x = class, fill=factor(cyl)),
           position = position_dodge(preserve = 'single'))


# Pie chart for different products and units sold

## Create data for graphs

x<- c(33, 45, 70, 110)
labels<- c("Soap", "Detergent", "Oil", "Shampoo")

## Plot the chart

pie(x, labels)
pie(x, labels, main='City pie chart', col=rainbow(length(x)))

piepercent<- round(100*x/sum(x), 1); piepercent

pie(x = x, labels = piepercent, main = "City pie chart", col=rainbow(length(x)))
#legend("Topright", c("Soap", "Shampoo", "Oil", "Grocery"), cex = 0.8, fill = rainbow(length(x)))


# 3D pie charts

#install.packages("plotrix")
library(plotrix)

lab<- c("Soap", "Detergent", "Oil", "Shampoo")
pie3D(x, labels=lab, explode=0.1, main="3D pie chart")

# Create a data for graph

v<-c(45, 12, 40, 18, 60, 55, 33, 36, 90, 24, 27)

# Create a histogram

hist(x = v, xlab = "Weight", col = "green", border = "red")

hist(x = v, xlab = "Weight", col = "green", border = "red", 
     xlim = c(0,70), ylim = c(0,5), breaks=5)

# Plotting a scatter plot

data("airquality")
View(airquality)

## Drawing a plot between Ozone and Wind

plot(x=airquality$Ozone, y=airquality$Wind)

plot(x=airquality$Ozone, y=airquality$Wind, type = 'h', col='blue') # Histogram

plot(airquality)

## Assign lables to a plot

plot(airquality$Ozone, xlab = "Ozone concentration", ylab = "No of Instancies", 
     main = "Ozone concentration in NY City")

hist(airquality$Solar.R, main = 'Solar radiation in air')

temperature<- airquality$Temp
hist(temperature)

## Histogram with labels

h<- hist(temperature, ylim = c(0,40))
text(h$mids, h$counts, labels=h$counts, adj = c(0.5, -0.5))

## Histogram with non-uniform width

hist(temperature, 
     main = "Maximum daily temperature at La Quardia Airport",
     xlab = "Temperature in degrees Fahrenheit",
     xlim = c(50,100),
     border = "brown",
     col = "chocolate",
     breaks = c(55, 60, 70, 75, 80, 100)
     )
# Boxplot

boxplot(airquality$Solar.R)

# Multiple boxplot

boxplot(airquality[,1:4], main="Multiple Box Plot")

# Using ggplot2 to analyse mtcars dataset

View(mtcars)

pl<-ggplot(mtcars, aes(factor(cyl), mpg))
pl+geom_boxplot()
pl+geom_boxplot()+coord_flip()
pl+geom_boxplot(aes(fill=factor(cyl)))

# Create factor with value labels

cars<-mtcars

cars$gear<-factor(cars$gear,
                  levels = c(3,4,5),
                  labels = c("3gears", "4gears", "5gears"))
cars$am<-factor(x = cars$am,
                levels = c(0,1),
                labels = c("Automaric", "Manual"))
cars$cyl<-factor(x = cars$cyl,
                 levels = c(4, 6, 8),
                 labels = c("4cyl", "6cyl", "8cyl"))
head(cars)
head(mtcars)

# Scatter plot

ggplot(data = cars, mapping = aes(x = wt, y = mpg))+geom_point()

# Scatter plot by factor

ggplot(data = cars, mapping = aes(x = wt, y = mpg, color = as.factor(cyl)))+geom_point()

ggplot(data = cars, mapping = aes(x = wt, y = mpg, col = "red"))+geom_point()

ggplot(data = cars, mapping = aes(x = wt, y = mpg, size= qsec, col = "red"))+geom_point()

# ---------------Visualization using mpg dataset---------------------

ggplot2::mpg
View(ggplot2::mpg)  # Or View(mpg)

# bar chart

ggplot(data = ggplot2::mpg, aes(class))+geom_bar()

# Stacked bar chart

ggplot(data = ggplot2::mpg, aes(class))+geom_bar(aes(fill=drv))
## Or
ggplot(data = ggplot2::mpg)+geom_bar(aes(class, fill=drv))

# Using dodge

ggplot(data = ggplot2::mpg, aes(class))+geom_bar(aes(fill=drv), position = "dodge")

# Scatter plot

ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ, y=hwy))

ggplot(data = mpg)+
  geom_point(mapping = aes(x=displ, y=hwy, color = class))

#----------------Uning library plotly--------------------------

install.packages("plotly")

library(plotly)

p<-plot_ly(data = mtcars, 
           x = ~hp,
           y = ~wt,
           marker = list(size = 10, color = 'rgba(255, 182, 193, .9)', 
                         line = list(color = 'rgba(152, 0, 0, .8)', width = 2)))

p

q<-plot_ly(data = mtcars, x=~hp, y=~wt, color = ~hp, size = ~hp)
q

