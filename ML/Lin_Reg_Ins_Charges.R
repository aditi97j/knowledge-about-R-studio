
library(dplyr)
library(ggplot2)
library(corrplot)

install.packages('cowplot')
install.packages('Hmisc')
install.packages('WVPlots')

library(Hmisc)
library(cowplot)
library(WVPlots)


df <- read.csv("C:\\Users\\Dell\\Downloads\\R_Programming\\ML\\Lin_Reg\\insurance_charges.csv")

View(df)

# display top 5 rows
head(df,5)

# check shape
dim(df)  # 1338,7

# check null values
colSums(is.na(df))
# No null values

str(df)

# value counts
table(df$sex)     # 2 (female,male)
table(df$smoker)  # 2 (no yes)
table(df$region)  # 4 (NE,NW,SE,SW)

# display summary
summary(df)

# EDA
# Univariate

# countplot
ggplot(df,aes(x=region)) + geom_bar(fill='blue')
ggplot(df,aes(x=sex)) + geom_bar(fill='orange')
ggplot(df,aes(x=smoker)) + geom_bar(fill='red')

# Boxplot
ggplot(df,aes(x=bmi)) + geom_boxplot()
ggplot(df,aes(x=age)) + geom_boxplot()
ggplot(df,aes(x=charges)) + geom_boxplot()

# hist / density plot
ggplot(df, aes(x=charges)) + geom_density(fill='lightgreen')
# conclusion => positively skewed => not normally distributed

ggplot(df,aes(x=charges)) +  geom_histogram(binwidth=30)


# Bivariate Anlysis
w1 <- ggplot(df, aes(x=age, y=charges)) + geom_point(color='blue')
# age and charges are positively corr
w2 <- ggplot(df, aes(x=bmi, y=charges)) + geom_point(color='green')

ggplot(data = df,aes(region,charges)) + geom_boxplot(fill=c(1:4))

ggplot(data = df,aes(smoker,charges)) + geom_boxplot(fill = c(4:5))
ggplot(data = df,aes(sex,charges)) + geom_boxplot(fill = c(2:3))

ggplot(data = df,aes(as.factor(children),charges)) + geom_boxplot(fill = c(2:7))


ggplot(data = df,aes(region,charges)) + geom_boxplot(fill = c(2:5)) +
  theme_classic() + ggtitle("Boxplot of Medical Charges per Region")


corr <- cor(df[c(1,3,4,7)])
corr

corrplot(corr,method='number')

df %>%
  group_by(smoker) %>%
  summarise(
    count = n(),
    min = min(charges),
    median = median(charges),
    max = max(charges),
    IQR = IQR(charges)
  ) %>%
  arrange(desc(median))

df %>%
  group_by(region) %>%
  summarise(
    count = n(),
    min = min(charges),
    median = median(charges),
    max = max(charges),
    IQR = IQR(charges)
  ) %>%
  arrange(desc(median))

df %>%
  group_by(children) %>%
  summarise(
    count = n(),
    min = min(charges),
    median = median(charges),
    max = max(charges),
    IQR = IQR(charges)
  ) %>%
  arrange(desc(median))



# Split the data
n_train <- round(0.75 * nrow(df))
n_train  # 1004
train_idx <- sample(1:nrow(df), n_train)
train_idx  # generates 1004 sample indexes 
length(train_idx)  

train <- df[train_idx, ]
test <- df[-train_idx, ]

dim(train)  # 1004 7
dim(test)   # 334 7


# Model - 1

m1 <- lm(charges ~ age+sex+bmi+children+smoker+region, data = train)
# OR
m1 <- lm(charges ~., data = train)
summary(m1)

coef(m1)

library(car)
vif(m1)

# R2 score
r2s <- summary(m1)$r.squared
r2s

dim(test)

# Predictions
ypred_m1 <- predict(m1,test)
length(ypred_m1)

# Errors (Residual) - MSE,RMSE
res <- ypred_m1 - test$charges
res
sse = sum(res**2)
mse = mean(res**2)
rmse = sqrt(mse)
paste('SSE',sse,'MSE',mse,'RMSE',rmse)


# Outlier treatment

q_age <- quantile(df$age, probs = c(0, 0.01,0.02,0.05,0.96,0.97,0.98,0.99,1))
q_age

q_bmi <- quantile(df$bmi, probs = c(0, 0.01,0.02,0.05,0.96,0.97,0.98,0.99,1))
q_bmi

q_children <- quantile(df$children, probs = c(0, 0.01,0.02,0.05,0.96,0.97,0.98,0.99,1))
q_children

q_charges <- quantile(df$charges, probs = c(0, 0.01,0.02,0.05,0.95,0.96,0.97,0.98,0.99,1))
q_charges

# BMI and Charges contain Outliers
# Handling outliers

df$bmi <- ifelse(df$bmi>42,42,df$bmi)
df$charges <- ifelse(df$charges>44492.863,44492.863,df$charges)


# Label Encoder

# Model - 2

n_train2 <- round(0.75 * nrow(df))
n_train2  # 1004
train_idx2 <- sample(1:nrow(df), n_train)
train_idx2  # generates 1004 sample indexes 
length(train_idx2)  

train2 <- df[train_idx2, ]
test2 <- df[-train_idx2, ]

dim(train2)  # 1004 7
dim(test2)   # 334 7

m2 <- lm(charges ~ age+sex+bmi+children+smoker+region, data = train2)
summary(m2)

# Selecting significant features based on p-value
# sig_features => age,bmi,children,smokeryes

m3 <- lm(charges ~ age+bmi+children+smoker, data = train2)
summary(m3)

coef_m3 <- coef(m3)
coef_m3

ypred_m3 <- predict(m3,test)
length(ypred_m3)

# Errors (Residual) - MSE,RMSE
r2s_m3 <- summary(m3)$r.squared
paste('R2_score_m3',r2s_m3)

res3 <- ypred_m3 - test$charges
# res3
sse3 = sum(res3**2)
mse3 = mean(res3**2)
rmse3 = sqrt(mse3)
paste('SSE_m3',sse3,'MSE_m3',mse3,'RMSE_m3',rmse3,'R2_score_m3',r2s_m3)


test2_df <- data.frame(test2)
dim(test2_df)


test2_df$pred <- predict(m3, test2_df)

ggplot(test2_df, aes(x = pred, y = charges)) + 
  geom_point(color = "blue", alpha = 0.7) + 
  geom_abline(color = "red") +
  ggtitle("Prediction vs. Real values")

test2_df$res <- test2_df$charges - pred



# Custom prediction
# m3 <- lm(charges ~ age+bmi+children+smoker, data = train2)
d1 <- data.frame(age=19,bmi=27.9, children=0,smoker='yes') 
d1

d1$pred <- predict(m3, d1)
d1

d2 <- data.frame(age = 40,bmi = 50,children = 2,smoker = "no") 
d2

d2$pred <- predict(m3, d2)
d2




























