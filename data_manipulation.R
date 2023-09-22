getwd()
setwd("C:/Users/asus/Desktop/Data Science with R")
getwd()

#install.packages("dplyr")
library(dplyr)

#install.packages('nycflights13')
library('nycflights13')

View(flights)
head(flights)

# Subset dataset using filter()

f1<-filter(flights, month==7)
View(f1)

f2<-filter(flights, month==7, day==3)
View(f2)

View(filter(flights, month==7, day==2, origin=='LGA'))

## Or

f3<-flights[flights$month==7 & flights$day==2 & flights$origin=='LGA',]
View(f3)

# Selection of rows by position using the function slice()

slice(flights, 1:10)
slice(flights, 13:20)

# Adding new columns using the function mutate()

over_delay<- mutate(flights, overall_delay=arr_delay-dep_delay)
View(over_delay)
head(over_delay)

# Showing only the new column : transmute()

OverDelay<- transmute(flights, overall_delay=arr_delay-dep_delay)
View(OverDelay)

# Finding descriptive statistic: summarise()

summarise(flights, avg_air_time=mean(air_time, na.rm=T))
summarise(flights, avg_air_time=mean(air_time, na.rm=T), tot_air_time=sum(air_time, na.rm=T), sd=sd(air_time, na.rm=T))

# Grouping by calculation using group_by()

## Example 1

View(mtcars)

### Grouping the dataset by gear column

by_gear<- mtcars %>% group_by(gear)
View(by_gear)
head(by_gear)
?? group_by

a<- summarise(by_gear, Total=sum(gear), Mean=mean(gear)); a

b<- by_gear %>% summarise(Total=sum(gear), Mean=mean(gear)); b

by_cyl<- group_by(mtcars, cyl) # or mtcars %>% group_by(cyl)
head(by_cyl)

summarise(by_cyl, Sum=sum(cyl), Mean=mean(cyl)) # or by_cyl %>% summarise(Sum=sum(cyl), Mean=mean(cyl))


## Example 2


by_cyl %>% summarise(
  Mean_gear=mean(gear),
  Mean_hp=mean(hp)
)

# Creating samples using sample_n() and sample_frac()

S1<- sample_n(flights, 10); S1 # gives 10 random samples

S2<- sample_frac(mtcars, 0.6) ; S2 # returns 60% of the total data

# arrange() used to sort dataset

data1<-arrange(flights, year, dep_time)
View(data1)
data2<- arrange(flights, desc(dep_time))
View(data2)

# Nesting

result1<- arrange(sample_n(filter(mtcars, mpg>20), size=5), desc(mpg))
View(result1)

## The same result with multiple assignment

op1<-filter(mtcars, mpg>20)
op2<-sample_n(op1, size=5)
result2<-arrange(op2, desc(mpg))
View(result2)

## The same result with the use of pipe operator %>%

### Syntax: result<- data %>% op1 %>% op2 %>% op3

result3<- mtcars %>% filter(mpg>20) %>% sample_n(5) %>% arrange(mpg)
View(result3)

# Selection of columns using select()

df<-mtcars
df1_mpg_hp_cyl<-select(df, mpg, hp, cyl); View(df1_mpg_hp_cyl)

##Or

df2_mpg_hp_cyl<-df[, c("mpg", "hp", "cyl")]; View(df2_mpg_hp_cyl)

## Or

df3_mpg_hp_cyl <- df %>% select(mpg, hp, cyl); View(df3_mpg_hp_cyl)

# *****************************************************************************

# ...................Data manipulation using tidyr.........................

# install.packages('tidyr')
library('tidyr')

n=10

wide<- data.frame(
  ID=c(1:n),
  Face.1= c(200,250,300,350,400,450,500,550,600,650),
  Face.2= c(225,275,325,375,425,475,525,575,625,675),
  Face.3= c(100,200,300,400,500,600,700,800,900,1000)
)
View(wide)

# gather(): reshapping data from wide format to long format

long<- wide %>% gather(Face, Response_time, Face.1:Face.3); View(long)

# separate() – its splits a single column into multiple columns

long_separate<- long %>% separate(Face, c("Target", "Number"))
View(long_separate)

# unite() – it combines multiple columns into a single column

long_unite<- long_separate %>% unite(Face, Target, Number, sep='.')
View(long_unite)

# spread(): it takes two columns (key & value) and spreads into multiple columns
# it makes long data wider

back_to_wide<- long_unite %>% spread(Face, Response_time)
View(back_to_wide)




