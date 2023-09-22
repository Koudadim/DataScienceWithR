# USE CASE OF SUPPORT VECTOR MACHINE (SVM) OF TWO VARIABLES height AND weight 
## FOR HORSES AND MULES CLASSIFICATION

# STEPS

#1. IMPORT DATASET

df<- read.csv("weight-height.csv")
head(df)
data<- cbind(Height=df$Height, Weight=df$Weight)
View(data)
MyData<- as.data.frame(data)
str(MyData)

# create an is horse indicator variable
is.horse<- c(rep(-1,5000), rep(1,5000))
is.horse

MyData$animal<-is.horse
head(MyData, 20)

# plotting

plot(MyData[,-3])

#2. Importation of library e1071

library(e1071)

#3. Computing support vectors

svm.model<- svm(animal~.,
                data = MyData,
                type = 'C-classification',
                kernel = 'linear',
                scale = FALSE
                )

summary(svm.model)

# Show the support vector
points(MyData[svm.model$index, c(1,2)], col = 'orange', cex = 2)

#4. Plot hyperplane

# Parameters of the hyerplane
svm.model$coefs
svm.model$SV
w<- t(svm.model$coefs) %*% svm.model$SV
b<- -svm.model$rho
w; b

# In this 2D case, the hyperplane is : w[1,1]*1 + w[1,2]*2 + b =0
abline(a = -b/w[1,2], b = -w[1,1]/w[1,2], col = 'blue', lty = 3)


#5 Classify new values

plot(MyData[,-3], col = (is.horse+3)/2, pch = 19)

# new observations

new_obs<- data.frame(Height = c(88, 77, 57), Weight = c(145, 194, 120))
abline(h=0, v=0, lty=3)
points(new_obs[1,], col= "green", pch=17)
points(new_obs[2,], col= "blue", pch=17)
points(new_obs[3,], col= "dark orange", pch=17)

abline(a = -b/w[1,2], b = -w[1,1]/w[1,2], col = 'blue', lty = 3)

#5 Verify prediction

predict(svm.model, new_obs)



# APPLICATION OF SUPPORT VECTOR MACHINE

##1. Face detection
##2. Text categorization
##3. Image classification
##4. Bioinformatics




