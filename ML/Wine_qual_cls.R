
library(dplyr)
library(ggplot2)
library(corrplot)
library(dplyr)
library(corrplot)
library(caret)
library(ROCR)
library(caTools)
library(randomForest)

df <- read.csv('C:\\Users\\Dell\\Downloads\\R_Programming\\ML\\DT_RF\\winequality-red.csv')
View(df)

dim(df) # 1599,12

colSums(is.na(df))  
sum(duplicated(df)) # 240

duplicated(df)

# Remove duplicates
df <- df[!duplicated(df),] 
dim(df)  # 1359, 12

# copy of df
df1 <- data.frame(df)
# df2 <- data.frame(df)

table(df$quality)

barplot(table(df$quality))

# qual -> df$quality<=5 => poor
# qual -> df$quality=6 => normal
# qual -> df$quality>6 => good

table(df$quality)

df$quality[df$quality %in% c(3,4,5)] <- "poor"
table(df$quality)
df$quality[df$quality == 6] <- "normal"
table(df$quality)
df$quality[df$quality %in% c(7,8)] <- "good"
table(df$quality)

barplot(table(df$quality))

str(df)

# Convert quality to factor
df$quality <- as.factor(df$quality)
str(df)

colnames(df)

dim(df)

head(df[,1:11],2)

cor(df)  # Err

corr <- cor(df[,1:11])
corrplot(corr,method='number')

# outlier treatment
View(df)
cn <- colnames(df)
cn

boxplot(df$fixed.acidity)

q_fa <- quantile(df$fixed.acidity,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_fa

df$fixed.acidity <- ifelse(df$fixed.acidity>12.6,12.6,df$fixed.acidity)

boxplot(df$volatile.acidity)
q_va <- quantile(df$volatile.acidity,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_va

df$volatile.acidity <- ifelse(df$volatile.acidity>1.0292 ,1.0292 ,df$volatile.acidity)

cn

boxplot(df$citric.acid)
# q_ca <- quantile(df$citric.acid,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
# q_ca
# 
# df$citric.acid <- ifelse(df$citric.acid>0.7042 ,0.7042 ,df$citric.acid)

boxplot(df$residual.sugar)
q_rs <- quantile(df$residual.sugar,probs=c(0.90,0.91,0.92,0.93,0.95,0.97,0.98,0.99,1))
q_rs

df$residual.sugar <- ifelse(df$residual.sugar>3.4, 3.4 ,df$residual.sugar)

boxplot(df$chlorides)
q_chl <- quantile(df$chlorides,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_chl

df$chlorides <- ifelse(df$chlorides>0.13760 ,0.13760 ,df$chlorides)

boxplot(df$free.sulfur.dioxide)
q_fsd <- quantile(df$free.sulfur.dioxide,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_fsd

df$free.sulfur.dioxide <- ifelse(df$free.sulfur.dioxide>42,42,df$free.sulfur.dioxide)

cn
boxplot(df$total.sulfur.dioxide)
q_tsd <- quantile(df$total.sulfur.dioxide,probs=c(0.95,0.96,0.97,0.98,0.99,1))
q_tsd

df$total.sulfur.dioxide <- ifelse(df$total.sulfur.dioxide>135.84,135.84,df$total.sulfur.dioxide)


cn
boxplot(df$density)
q_den <- quantile(df$density,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_den

df$density <- ifelse(df$density>1.0002426, 1.0002426,df$density)
df$density <- ifelse(df$density<0.9931748, 0.9931748,df$density)

View(df)

boxplot(df$pH)
q_ph <- quantile(df$pH,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_ph

df$pH <- ifelse(df$pH>3.7042, 3.7042,df$pH)
df$pH <- ifelse(df$pH<2.94, 2.94,df$pH)

boxplot(df$sulphates)
q_sul <- quantile(df$sulphates,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.96,0.97,0.98,0.99,1))
q_sul

df$sulphates <- ifelse(df$sulphates>0.9968, 0.9968,df$sulphates)

cn
boxplot(df$alcohol)

dim(df)

# df <- df[-12]
# colnames(df)
set.seed(42)
samp <- sample(nrow(df), 0.75 * nrow(df))
train <- df[samp, ]
test <- df[-samp, ]

dim(train)  # 1019 12
dim(test)   # 340  12

head(train,3)
head(test,3)

colnames(train)

table(train$quality)
table(test$quality)

View(train)
View(test)

# DT
library(rpart)
library(rpart.plot)

help(rpart)

dt1 <- rpart(quality~., train,parms = list(split='gini'),
             minsplit=10, maxdepth=10,method='class')
dt1

# dim(train)  # 1019 12
# dim(test)   # 340 12

ypred_dt1 <- predict(dt1, new=test, type="class") 
ypred_dt1[1:6]
length(ypred_dt1)

cm_dt <- table(test$quality,ypred_dt1)
cm_dt

cm_dt1 <- confusionMatrix(factor(test$quality),factor(ypred_dt1))
cm_dt1    

library(pROC)

roc_dt <- roc(test$quality, as.integer(ypred_dt1))
roc_dt
auc(roc_dt)

plot(roc_dt ,main ="ROC curve -- DT")


library(randomForest)
table(df$quality)

rf1 <- randomForest(quality~.,train,ntree=100,mtry=4)
rf1

ypred_rf1 <- predict(rf1,test)
ypred_rf1[1:7]

cm_rf <- table(test$quality,ypred_rf1)
cm_rf

cm_rf1 <- confusionMatrix(factor(test$quality),factor(ypred_rf1))
cm_rf1

importance(rf1)

varImpPlot(rf1,main="Feature Importance")

library(pROC)

roc_rf <- multiclass.roc(test$quality, as.integer(ypred_rf1))
roc_rf
auc(roc_rf)

# plot(roc_rf ,main ="ROC curve -- RF ")
