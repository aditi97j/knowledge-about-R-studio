
# Log Reg - diabetes

library(ggplot2)  # plots
library(dplyr)
library(corrplot) # corr
library(caret) # confusion matrix
library(pROC) # ROC_AUC
library(caTools)  # sample.split
library(rpart)  # DT

df <- read.csv('C:\\Users\\Dell\\Downloads\\R_Programming\\diabetes.csv')
View(df)

colnames(df)

dim(df)  # rows=768, col=9

# Null values
colSums(is.na(df))
sum(is.na(df))

# Sum of duplicate rows
sum(duplicated(df))

str(df)

summary(df)

# Target Variable - Value Counts
table(df$Outcome)  # 0(500), 1(268)

# Univariate EDA
ggplot(df,aes(x=Age)) + geom_boxplot()
ggplot(df,aes(x=BMI)) + geom_boxplot()
ggplot(df,aes(x=Insulin)) +geom_boxplot()
ggplot(df,aes(x=BloodPressure)) +geom_boxplot()
ggplot(df,aes(x=DiabetesPedigreeFunction)) +geom_boxplot()
ggplot(df,aes(x=Glucose)) +geom_boxplot()
ggplot(df,aes(x=SkinThickness)) +geom_boxplot()


for (i in c('Age','Insulin')){
  ggplot(df,aes(x=df[i])) + geom_boxplot()
}

colnames(df)

for (i in 1:8){
  boxplot(df[[i]])
}



df['Age']

ggplot(df,aes(x=df[Age])) + geom_boxplot()




# Outliers
cn <- colnames(df)
cn

q_gl <- quantile(df$Glucose,probs=c(0,0.01,0.02,0.03,0.5,0.95,0.97,0.98,0.99,1))
q_gl

df$Glucose <- ifelse(df$Glucose<57.00,57.00,df$Glucose)

q_bp <- quantile(df$BloodPressure,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_bp

df$BloodPressure <- ifelse(df$BloodPressure<38.7,38.7,df$BloodPressure)
df$BloodPressure <- ifelse(df$BloodPressure>99.32,99.32,df$BloodPressure)

q_st <- quantile(df$SkinThickness,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_st

df$SkinThickness <- ifelse(df$SkinThickness>51.33,51.33,df$SkinThickness)

q_in <- quantile(df$Insulin,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_in


boxplot(df$Insulin)
df$Insulin <- ifelse(df$Insulin>369.90,369.90,df$Insulin)

boxplot(df$BMI)
q_bmi <- quantile(df$BMI,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_bmi

df$BMI <- ifelse(df$BMI<19.168,19.168,df$BMI)
df$BMI <- ifelse(df$BMI>50.759,50.759,df$BMI)

colnames(df)
boxplot(df$DiabetesPedigreeFunction)

q_dpf <- quantile(df$DiabetesPedigreeFunction,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_dpf

df$DiabetesPedigreeFunction <- ifelse(df$DiabetesPedigreeFunction>1.25793,1.25793,df$DiabetesPedigreeFunction)

boxplot(df$Age)
q_age <- quantile(df$Age,probs=c(0,0.01,0.02,0.03,0.05,0.95,0.97,0.98,0.99,1))
q_age

df$Age <- ifelse(df$Age>64.6,64,df$Age)

ggplot(df,aes(x=Age)) + geom_boxplot()

# Creating Age Bin
df1 <- data.frame(df)
df1$Age_Cat <- ifelse(df1$Age < 21, "<21", 
                      ifelse((df1$Age>=21) & (df1$Age<=25), "21-25", 
                             ifelse((df1$Age>25) & (df1$Age<=30), "25-30",
                                    ifelse((df1$Age>30) & (df1$Age<=35), "30-35",
                                           ifelse((df1$Age>35) & (df1$Age<=40), "35-40",
                                                  ifelse((df1$Age>40) & (df1$Age<=50), "40-50",
                                                         ifelse((df1$Age>50) & (df1$Age<=60), "50-60",">60")))))))


View(df1)


df1$Age_Cat <- factor(df1$Age_Cat, levels = c('<21','21-25','25-30','30-35','35-40','40-50','50-60','>60'))
table(df1$Age_Cat)


ggplot(aes(x = Age), data=df1) +
  geom_histogram(binwidth=1, color='black', fill = "#F79420") +
  scale_x_continuous(limits=c(20,90), breaks=seq(20,90,5)) +
  xlab("Age") +
  ylab("No of people by age")

ggplot(aes(x = Age_Cat), data = df1) +
  geom_bar(fill='steelblue')

ggplot(aes(x=Age_Cat, y = BMI), data = df1) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0,70))


# by(df1$BMI, df1$Age_Cat, summary)

View(df)
colnames(df)

# Correlation
corr <- cor(df)
corr

corrplot(corr,method='number')

# Split the data into train and test

library(caTools)  # sample.split
# ??sample.split

set.seed(42)  # random state
sample = sample.split(df, SplitRatio=0.75)
train = subset(df, sample==TRUE)
test = subset(df, sample==FALSE)

dim(train)
dim(test)

head(train,5)

# sample = sample.split(df$Outcome, SplitRatio=0.75)
# train = subset(df, sample==TRUE)
# test = subset(df, sample==FALSE)

#n_train <- round(0.75 * nrow(df))
#n_train 
#train_idx <- sample(1:nrow(df), n_train)
#train_idx  # generates 1004 sample indexes 
#length(train_idx)  

# train <- df[train_idx, ]
# test <- df[-train_idx, ]

colnames(train)
colnames(test)
dim(train)
dim(test)

# model- 1
m1 <- glm(Outcome ~ ., data = train, family = "binomial")
summary(m1)

# selecting significant cols

m2 <- glm(Outcome ~ Pregnancies+Glucose+BMI+DiabetesPedigreeFunction, data = train, family = "binomial")
summary(m2)

ypred_m2 <- predict(m2, test, type="response")
ypred_m2[1:10]

range(ypred)

ypred_m2 <- ifelse(ypred_m2>0.5,1,0)
ypred_m2

summary(ypred_m2)

length(ypred_m2)
length(test$Outcome)

# confusion_Matrix
cm <- table(test$Outcome,ypred_m2)
cm

cm1 <- data.frame(cm)
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

cm2 <- confusionMatrix(factor(ypred_m2),factor(test$Outcome))
cm2

# ROC and AUC
library(pROC)


roc_m2 <- roc(test$Outcome, ypred_m2)
roc_m2
auc(roc_m2)

plot(roc_m2 ,main ="ROC curve -- Logistic Regression ")
