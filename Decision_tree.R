# We will use a decision tree to predict the class of flower

##install.packages("rpart")
##install.packages("rpart.plot")
##install.packages("xlsx")

library(rpart)
library(rpart.plot)
library(xlsx)

# loading the data

data("iris")
df<-iris
View(df)

str(df)

set.seed(9850)

# Generating random numbers with runif()

g<- runif(nrow(iris))
iris_ran<-iris[order(g),]

head(iris_ran)

# MODEL BUILDING

model<- rpart(Species ~., data = iris_ran[1:100, ], method = 'class')
model

rpart.plot(model, type=4, fallen.leaves = T, extra = 104)

# TESTING THE MODEL: model validation

model_predict<- predict(model, iris_ran[101:150,], type = 'class')
model_predict

# Installation of packages required to use ConfusionMatrix

##install.packages("caret")
##install.packages("e1071")
library(caret)
library(e1071)

confusionMatrix(iris_ran[101:150,5], reference = model_predict)





