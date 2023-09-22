# USE CASE OF A RANDOM FOREST: WINE QUALITY PREDICTION

# installation et chargement des packages

##install.packages("randomForest")
library(randomForest)

data<- read.csv("WineQT.csv")
View(data)

# Transforming a numerical variable into a factor

data$quality = as.factor(data$quality)
View(data)
# Splitting the data

data_set_size <- floor(nrow(data)*0.80) # Selection of 80% of the data
data_set_size
index <- sample(1:nrow(data), size = data_set_size)

training <- data[index,]
testing <- data[-index,]

# CREATING A MODEL

model_rf <- randomForest(quality~., data= training, mtry=4, ntree=2001, importance=TRUE)
#??randomForest
model_rf

# Plotting
plot(model_rf)

# Prediction

result<- data.frame(testing$quality, predict(model_rf, testing[, 1:11], type = "response"))
result

plot(result)



