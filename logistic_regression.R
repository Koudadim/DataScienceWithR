# Steps for logistic regression

# 1. importing the dataset
# 2. importing library
# 3. splitting the dataset into train & test data
# 4. Applying the regression model on the training data
# 5. Validating the model: accuracy, precision

setwd("C:/Users/asus/Desktop/Data Science with R")
# Load libraries

library(caTools)

data<-Titanic
View(data)

# Splitting the dataset

split<- sample.split(data, SplitRatio = 0.8)
split
train<- subset(data, split == "TRUE")
test<- subset(data, split == "FALSE")

# Munge data
## Conversion of the categorical variables into factors

data$Class=as.factor(data$Class)
data$Sex <- as.factor(data$Sex)
Class




