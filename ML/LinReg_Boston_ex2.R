
# install.packages('MASS')
# install.packages('caTools')

library(MASS)     # BOSTON
library(dplyr)
library(ggplot2)
library(caTools)  # splitting
library(corrplot)



# CRIM - per capita crime rate by town
# ZN - proportion of residential land zoned for lots over 25,000 sq.ft.
# INDUS - proportion of non-retail business acres per town.
# CHAS - Charles River dummy variable (1 if tract bounds river; 0 otherwise)
# NOX - nitric oxides concentration (parts per 10 million)
# RM - average number of rooms per dwelling
# AGE - proportion of owner-occupied units built prior to 1940
# DIS - weighted distances to five Boston employment centres
# RAD - index of accessibility to radial highways
# TAX - full-value property-tax rate per $10,000
# PTRATIO - pupil-teacher ratio by town
# B - 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town
# LSTAT - % lower status of the population
# MEDV - Median value of owner-occupied homes in $1000's
# boston house data

df <- Boston
View(df)

dim(df)  # 506 14
colnames(df)

str(df)

summary(df)

table(df$rad) # 1,2,3,4,5,6,7,8,24
table(df$chas) # 0 1

# null value
colSums(is.na(df))

# sum of all null values
sum(is.na(df))

corr <- cor(df)
corrplot(corr,method='number')

View(corr)

dim(df)  # row=506,col=14
nrow(df) # row = 506
ncol(df) # col

# Split the data: 75 and 25%
n_train <- round(0.75 * nrow(df))
n_train  # 380
train_idx <- sample(1:nrow(df), n_train)
train_idx  # generates 380 sample indexes 
length(train_idx)  

train <- df[train_idx, ]
test <- df[-train_idx, ]

dim(train)
dim(test)


# set.seed(125)
# split <- sample.split(df,SplitRatio =0.75)
# train <- subset(df,split==TRUE)
# test <- subset(df,split==FALSE)

dim(train)
dim(test)
colnames(train)
colnames(test)

str(df)

# Univariate Model : model<−lm(y∼x,data)
# Multivariate Model : model<−lm(y∼.,data)

# lm(target~a+b+c+d, data=train)


m1 <- lm(medv~.,data=train)  # includes all cols except medv
summary(m1)

m1 <- lm(medv ~ crim + rm + tax + lstat , data = train)
# includes cols (crim + rm + tax + lstat) as independent variables
summary(m1)


# LinReg model - 1
lr1 <- lm(medv~.,data=train)  # includes all cols except medv
summary(lr1)

# sig cols: crim, zn, chas, nox, rm, dis, rad, 
#           tax, ptratio, black, lstat

colnames(train)

lr2 <- lm(medv~crim+zn+chas+nox+rm+dis+rad+tax+ptratio+black+lstat,
          data=train)  # excluding age, indus
summary(lr2)

# coef + intercept 
coef(lr2)
# R squared
summary(lr2)$r.squared

# Errors = Actual - Prediction
resid_lr2 <- residuals(lr2)
length(resid_lr2)

# res_m1 <- as.data.frame(resid_m1)
# ggplot(res_m1,aes(res_m1)) +  geom_histogram(fill='blue',alpha=0.5) 


test$ypred <- predict(lr2,test)
View(test)

error <- test$medv-test$ypred
sse = sum(error**2)
mse = mean(error**2)
rmse = sqrt(mse)
paste('SSE',sse,'MSE',mse,'RMSE',rmse)




