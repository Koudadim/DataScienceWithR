
data<- read.csv("Real estate.csv")
View(data)

summary(data)

df<-data[,c("X2.house.age", "X3.distance.to.the.nearest.MRT.station",
            "X4.number.of.convenience.stores", "X5.latitude", "X6.longitude",
            "Y.house.price.of.unit.area")]
df

plot(df)

# Splitting the data into training and test data

set.seed(2)
#install.packages("caTools")
library(caTools)
split_df<- sample.split(df, SplitRatio = 0.75)
split_df

train<- subset(df, split_df="TRUE")
head(train)
test<- subset(df, split_df="FALSE")
View(test)

# Create a model

Model<- lm(Y.house.price.of.unit.area ~., data = train)

summary(Model)

# Prediction

pred<- predict(Model, test)
pred

# Comparing predicted vs actual values

plot(test$Y.house.price.of.unit.area, type = "l", lty = 1.8, col = "red")

lines(pred, type = "l", col = "blue")

plot(pred, type = "l", lty = 1.8, col = "black")



# Finding accuracy

 rmse<-sqrt(mean(pred-df$Y.house.price.of.unit.area)^2)
rmse


#--------------------------USE CASE--------------------------

head(cars)
str(cars)

plot(cars)

plot(cars$wt,  cars$hp)

# Correlation between the different variable

cor(cars$wt, cars$hp)


model<- lm(cars$hp ~cars$wt, data = cars)
summary(model)

# Splitting the data set


data<-cars[, c("wt", "hp")]
data

set.seed(100)
training_row_index<- sample(1:nrow(data), 0.8*nrow(data) )
training_data <- data[training_row_index,]
test_data <- data[-training_row_index,]

LM<- lm(hp~wt, data = training_data)
LM

hp_pred<-predict(LM, test_data)
hp_pred

summary(LM)

# Prediction Accuracy and Error rates

actuals_predicts <- data.frame(cbind(actuals= test_data$hp,
                                     predicteds= hp_pred))
head(actuals_predicts)

correlation_accuracy <- cor(actuals_predicts)
correlation_accuracy

install.packages("DMwR")
library(DMwR)






