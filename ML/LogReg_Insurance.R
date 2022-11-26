

# basis data types - numeric, char, logical., int, bool, complex
# R data str - vector,matrix,array,list,factor, DataFrame
# R basic plots, ggplot
# ML - LinReg, LogReg, DT, RF, KMeans

# 2Hr - 20Q - 100 Marks

library(dplyr)
library(ggplot2)
library(readxl) # excel files

df <- read_excel('C:\\Users\\Dell\\Downloads\\R_Programming\\ML\\Lin_Reg\\insurance_data.xlsx')
View(df)

# read.csv('Path')

colnames(df)
dim(df)  # rows=27, cols=2

colnames(df) <- c('Age','Ins')
colnames(df)

str(df)

# Dividing data into Train and test
n_train <- round(0.75 * nrow(df))
n_train
train_idx <- sample(1:nrow(df), n_train)

# train_idx  # generates 1004 sample indexes
length(train_idx)

train <- df[train_idx, ]
test <- df[-train_idx, ]

dim(train)  # rows=20 cols=2
dim(test)   # rows=7, cols=2

# Logistic Regression - GLM(Generalized Linear Model)
# glm(Target~.,train,family='binomial')

# help(glm)
# ??glm

m1 <- glm(Ins~Age,train,family='binomial')
summary(m1)

# prediction prob
ypred_m1 <- predict(m1,test,type="response")
ypred_m1

# prob converetd to 0 and 1
ypred_m1 <- ifelse(ypred_m1>0.5,1,0)
ypred_m1

test$Ins

# Confusion matrix and Classification Report

cm <- table(test$Ins,ypred_m1)
cm

cm1 <- data.frame(cm)
cm1

tp <- cm1[1,"Freq"]
fp <- cm1[2,"Freq"]
fn <- cm1[3,"Freq"]
tn <- cm1[4,"Freq"]

# Classification Report
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

# Function call
cr(tp,fn,fp,tn)

# CM using library
# install.packages('caret')

library(caret) # confusionMatrix

cm_m1 <- confusionMatrix(factor(ypred_m1),factor(test$Ins))
cm_m1


# ROC AUC

# install.packages('pROC')
library(pROC)

roc_m1 <- roc(test$Ins, ypred_m1)
roc_m1
auc(roc_m1)

plot(roc_m1 ,main = "ROC curve -- Logistic Regression ")

# Decision Tree

# install.packages('rpart')
# install.packages('rpart.plot')

library(rpart)
library(rpart.plot)

help(rpart)

# DT with Entoropy
m2 <- rpart(Ins~Age,train,method='class',
            parms = list(split='information'),
            minsplit=4, maxdepth=2)
m2

plot(m2)
text(m2,cex=0.3)  # cex = font-size

rpart.plot(m2)

# DT with gini
m3 <- rpart(Ins~Age,train,method='class',
            parms = list(split='gini'),
            minsplit=4, maxdepth=2)
m3

rpart.plot(m3)

ypred_m2 <- predict(m2,test,type='class')
ypred_m2  # factor

test$Ins

# CM and CR
cm_m2 <- confusionMatrix(factor(ypred_m2),factor(test$Ins))
cm_m2

roc_m2 <- roc(test$Ins, as.numeric(ypred_m2))
roc_m2
auc(roc_m2)

plot(roc_m2 ,main ="ROC curve - DT ")




library(randomForest)
help(randomForest)


# Naive bayes
# install.packages("e1071")
library(e1071)

m3 <- naiveBayes(Ins ~ ., data = train)
m3

ypred_m3 <- predict(m3,test)
ypred_m3

cm_m3 <- confusionMatrix(factor(ypred_m3),factor(test$Ins))
cm_m3


