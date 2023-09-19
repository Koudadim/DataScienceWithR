# Clusterring

#1. Hierarchical clustering
#1.1. Agglomerative
#1.2. Divisive

#2. Partial clustering
#2.1. K-means
#2.2. Fuzzy C-means

# APPLICATIONS
#1. Customer segmentation
#2. Social network analysis
#3. City planning


# HIERARCHIAL CLUSTERING

  #1. Import the dataset
getwd()

data<-read.csv("moon.csv")
str(data)
View(data)
pairs(data)

set.seed(100)
#install.packages("caTools")
library(caTools)
#split_df<- sample.split(data, SplitRatio = 0.1)
#split_df

#mydata<-subset(data, split_df="TRUE")
library('nycflights13')
library(dplyr)
mydata<-sample_n(data, 30)
str(mydata)
head(mydata)

  #2. Create a satter plot

plot(Y~X, mydata)

with(mydata, text(Y~X, labels = index, pos = 4, cex = .3))


  #3. Normalize the dataset

m <- apply(mydata, 2, mean)
s <-apply(mydata, 2, sd)  
data.normalized <- scale(mydata, m, s)  
  
  
  #4. Calculate the euclidean distance

distance <- dist(data.normalized)
distance
print(distance, digits = 3)

  #5.Create a dendrogram

ch.l <- hclust(distance)
plot(ch.l)

plot(ch.l, labels = mydata$index, hang = -1)

  # Clustering dendrogram (average)

ch.l <- hclust(distance, method = "average")
plot(ch.l)
plot(ch.l, labels = mydata$index, hang = -1)

  # Clustering membership

member.1 <- cutree(ch.l, 3)
aggregate(data.normalized, list(member.1), mean)
plot(member.1)
  
  # Actuel values

aggregate(mydata, list(member.1), mean)







