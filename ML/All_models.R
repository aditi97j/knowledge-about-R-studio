

library(ggplot2)  # plots
library(dplyr)
library(corrplot) # corr
library(caret) # confusion matrix
library(pROC) # ROC_AUC
library(caTools)  # sample.split
library(rpart)  # DT

# install.packages('randomForest')

library(randomForest)  # RF


# install.packages('dplyr')
# library(dplyr)

# Log_Reg - Titanic dataset

df <- read.csv("C:\\Users\\Dell\\Downloads\\R_Programming\\ML\\titanic.csv")
View(df)

colnames(df)
dim(df)  # rows=1257,cols=9

summary(df)

# check null values
colSums(is.na(df))

sum(is.na(df))

# Handle null values
hist(df$age)

# Method - 1
df$age[is.na(df$age)] = mean(df$age,na.rm=TRUE)

colSums(is.na(df))

str(df)

# Binary Label Encoder
table(df$sex)
df$sex <- ifelse(df$sex == "female",1,0)

# Multi-categorical label encoder
table(df$embarked)

df$embarked <- as.integer(as.factor(df$embarked))
colnames(df)

str(df)

View(df)
# Removing name column from DataFrame
df <- df[-3]

colnames(df)

# Outlier Handling

# 1) Handling Age Outliers
bx = boxplot(df$age)

q_age <- quantile(df$age,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_age

df$age <- ifelse(df$age>54.00,54.00,df$age)
df$age <- ifelse(df$age<=4,4,df$age)


# 2) Handling Fare Outliers

bfare = boxplot(df$fare)

q_fare <- quantile(df$fare,probs=c(0,0.01,0.02,0.03,0.5,0.9,0.92,0.93,0.95,0.97,0.98,0.99,1))
q_fare

# clipping at 92% tile
df$fare <- ifelse(df$fare>=83.1538,83.1538,df$fare)


# Bivariate Analysis
# countplot - sex, survived

table(df$survived)

ggplot(df,aes(x=as.factor(survived),fill=as.factor(sex))) + geom_bar()

corr <- cor(df)
corrplot(corr,method='number')

dim(df)  # 1257
# divide data into train and test

# Method-1
t = sample(1:nrow(df),0.7*nrow(df))
length(t)
train = df[t,]
test = df[-t,]

# Method-2
# library(caTools)
# set.seed(42)  # random state
# sample = sample.split(df, SplitRatio=0.75)
# train = subset(df, sample==TRUE)
# test = subset(df, sample==FALSE)

dim(train)
dim(test)
colnames(train)
colnames(test)

# Log Reg
lr <- glm(survived~.,data=train,family='binomial')
summary(lr)
# significant feat: pclass,gender,age,sibsp,embarked

ypred_lr <- predict(lr,test,type='response')
ypred_lr[1:5]

ypred_lr <- ifelse(ypred_lr>0.5,1,0)
ypred_lr[1:7]

cm_lr <- table(test$survived,ypred_lr)
cm_lr

# Confusion matrix and Classification Report
cm_lr1 <- confusionMatrix(factor(test$survived),factor(ypred_lr))
cm_lr1

roc_lr <- roc(test$survived, ypred_lr)
roc_lr
auc(roc_lr)

plot(roc_lr ,main ="ROC curve -- Logistic Regression ")

# Decision Tree
library(rpart)
library(rpart.plot)

help(rpart)

dt1 <- rpart(survived~., train,parms = list(split='gini'),
             minsplit=10, maxdepth=10,method='class')
dt1

# Method-1
rpart.plot(dt1)

# Method-2
plot(dt1,uniform=T)
text(dt1,cex=0.5) # cex=font size

ypred_dt1 <- predict(dt1, new=test, type="class") 
length(ypred_dt1)
length(test$survived)

ypred_dt1[1:10]

colnames(test)
cm_dt <- confusionMatrix(factor(ypred_dt1),factor(test$survived))
cm_dt

cm1 <- table(test$survived,ypred_dt1)
cm1

cm1 <- data.frame(cm1)
cm1

tp <- cm1[1,"Freq"]
fp <- cm1[2,"Freq"]
fn <- cm1[3,"Freq"]
tn <- cm1[4,"Freq"]

cr <-  function(tp,fn,fp,tn){
  pre0 <- tp/(tp+fp)
  pre1 <- tn/(tn+fn)
  rec0 <- tp/(tp+fn)
  rec1 <- tn/(tn+fp)
  f1s0 <- 2*pre0*rec0/(pre0+rec0)
  f1s1 <- 2*pre1*rec1/(pre1+rec1)
  acc <- (tp+tn)/(tp+fn+fp+tn)
  print(paste('Pre0',pre0,'Pre1',pre1))
  print(paste('Rec0',rec0,'Rec1',rec1))
  print(paste('F1s0',f1s0,'F1S1',f1s1))
  print(paste('Acc',acc))
}

cr(tp,fn,fp,tn)

# install.packages('vip')
library(vip)  # variable importance

vip(dt1)

library(pROC)

class(ypred_dt1)
class(test$survived)

roc_dt <- roc(test$survived, as.integer(ypred_dt1))
roc_dt
auc(roc_dt)

plot(roc_dt ,main ="ROC curve -- DT ")


### Random Forest
library(randomForest)

help(randomForest)

# mtry = no of features to select
# ntree = no of trees in RF
# replace = T/F, Bootstrap
dim(train)
64/(64+478)

rf1 <- randomForest(as.factor(survived)~.,train,ntree=80,mtry=4)
rf1

plot(rf1)


ypred_rf1 <- predict(rf1,test)
length(ypred_rf1)

ypred_rf1[1:10]

cm_rf <- confusionMatrix(factor(ypred_rf1),factor(test$survived))
cm_rf

# variable importance
importance(rf1)

varImpPlot(rf1)


roc_rf <- roc(test$survived, as.integer(ypred_rf1))
roc_rf
auc(roc_rf)

plot(roc_rf ,main ="ROC curve -- RF ")



