
library(dplyr)
library(ggplot2)
library(corrplot)
library(dplyr)
library(corrplot)
library(caret)
library(ROCR)
library(caTools)
library(randomForest)

df <- read.csv('C:\\Users\\Dell\\Downloads\\R_Programming\\ML\\DT_RF\\telecom_churn.csv')
View(df)

cn <- colnames(df)
cn

dim(df) # rows=3333,cols=11

# Null value check
colSums(is.na(df))

# check duplicated
sum(duplicated(df))

summary(df)

str(df)

# outliers - AccountWeeks, Datausage, DayMins,DayCalls,MonthlyCharge
#          - OverageFee, RoamMins

boxplot(df$AccountWeeks)
q_aw <- quantile(df$AccountWeeks,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_aw

df$AccountWeeks <- ifelse(df$AccountWeeks>195.00,195.00,df$AccountWeeks)

boxplot(df$DataUsage)
q_du <- quantile(df$DataUsage,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_du

df$DataUsage <- ifelse(df$DataUsage>4.1,4.1,df$DataUsage)


boxplot(df$DayMins)
q_dm <- quantile(df$DayMins,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_dm

df$DayMins <- ifelse(df$DayMins<51.832,51.832,df$DayMins)
df$DayMins <- ifelse(df$DayMins>305.168,305.168,df$DayMins)

boxplot(df$DayCalls)
q_dc <- quantile(df$DayCalls,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_dc

df$DayCalls <- ifelse(df$DayCalls<54,54,df$DayCalls)
df$DayCalls <- ifelse(df$DayCalls>146,146,df$DayCalls)


boxplot(df$MonthlyCharge)
q_mc <- quantile(df$MonthlyCharge,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_mc

df$MonthlyCharge <- ifelse(df$MonthlyCharge>98.28,98.28,df$MonthlyCharge)

boxplot(df$OverageFee)
q_af <- quantile(df$OverageFee,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_af

df$OverageFee <- ifelse(df$OverageFee<3.9796,3.9796,df$OverageFee)
df$OverageFee <- ifelse(df$OverageFee>15.9468,15.9468,df$OverageFee)

boxplot(df$OverageFee)
q_af <- quantile(df$OverageFee,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_af

df$OverageFee <- ifelse(df$OverageFee<3.9796,3.9796,df$OverageFee)
df$OverageFee <- ifelse(df$OverageFee>15.9468,15.9468,df$OverageFee)

boxplot(df$RoamMins)
q_rm <- quantile(df$RoamMins,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_rm

df$RoamMins <- ifelse(df$RoamMins<3.332,3.332,df$RoamMins)
df$RoamMins <- ifelse(df$RoamMins>16.668,16.668,df$RoamMins)


cn
help(sample.split)

??sample.split

# data split
# t = sample(1:nrow(df),0.75*nrow(df))
# length(t)
# train = df[t,]
# test = df[-t,]

corr <- cor(df)
corrplot(corr,method='number')


df <- df[-4]
colnames(df)


View(df)

# Inference
# Data Plan is highly correlated
# 3333*0.75
# 2333/3333

set.seed(42)
t = sample(1:nrow(df),0.75*nrow(df))
length(t)
train = df[t,]
test = df[-t,]

# train - 2609,2369,1177
head(train,3)

# sample = sample.split(df, SplitRatio=0.75)
# train = subset(df, sample==TRUE)
# test = subset(df, sample==FALSE)

dim(train) # 2499 10
dim(test)  # 834 10

head(train,3)

### Model Building
# LogReg
lr = glm(Churn~., data = train, family = "binomial")
summary(lr)

# select significant features
# ContractRenewal,DataUsage, CustServCalls,DayMins,
# MonthlyCharge, OverageFees, RoamMins

table(df$Churn)
# Imbalanced

ypred_lr <- predict(lr,test,type="response")
ypred_lr
ypred_lr <- ifelse(ypred_lr>0.5,1,0)
ypred_lr[1:10]

table(test$Churn,ypred_lr)

cm <- confusionMatrix(factor(ypred_lr),factor(test$Churn))
cm

library(pROC)

roc_lr <- roc(test$Churn, ypred_lr)
roc_lr
auc(roc_lr)
plot(roc_lr ,main ="ROC curve -- Logistic Regression ")


# Decision Tree
library(rpart)
library(rpart.plot)

dt1 <- rpart(Churn~., train,parms = list(split='gini'),
             minsplit=20, maxdepth=10,method='class')

rpart.plot(dt1)

ypred_dt <- predict(dt1,test,type='class')
ypred_dt[1:7]

length(test$Churn)
length(ypred_dt)

table(test$Churn,ypred_dt)

cm2 <- confusionMatrix(factor(ypred_dt),factor(test$Churn))
cm2

roc_dt <- roc(test$Churn, as.integer(ypred_dt))
roc_dt
auc(roc_dt)
plot(roc_dt ,main ="ROC curve -- DT ")


# Random Forest
library(randomForest)

help(randomForest)

# replace = T/F(set Bootstrap to T or F)
# 
rf <- randomForest(as.factor(Churn)~., train, ntree=80, mtry=2)

ypred_rf <- predict(rf,test,type="class")
ypred_rf[1:10]

table(test$Churn,ypred_rf)

importance(rf)

varImpPlot(rf)

cm3 <- confusionMatrix(factor(ypred_rf),factor(test$Churn))
cm3


roc_rf <- roc(test$Churn, as.integer(ypred_rf))
roc_rf
auc(roc_rf)
plot(roc_rf ,main ="ROC curve -- RF ")




