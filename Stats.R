
# Stats

# install.packages('corrplot')
library(corrplot)

View(mtcars)

# Descriptive stats

mean(mtcars$mpg)
median(mtcars$mpg)
var(mtcars$mpg)
sd(mtcars$mpg)

# Covariance
covariance <- cov(mtcars)
View(covariance)

cov(mtcars$mpg, mtcars$disp)

# Correlation

corr <- cor(mtcars)
View(corr)

corrplot(corr)
corrplot(corr,method='number')

cor(mtcars$mpg, mtcars$disp)

# Z-Test

# Ex - IQ in a certain population is normally distributed with a mean 
# of μ = 100 and standard deviation of σ = 15. A scientist wants to 
# know if a new medication affects IQ levels, so she recruits 20 
# patients to use it for one month and records their IQ levels
# at the end of the month.

# Ho(Null): µ = x (the mean height is x)
# H1(Alternate): µ ≠ x (the mean height is not x)
# if p_val>0.05 => Ho is accepted
# if p_val<0.05 => H1 is accepted

install.packages("BSDA")
library(BSDA)  # basic Statistics and Data Analysis


d1 <- c(88, 92, 94, 94, 96, 97, 97, 97, 99, 99,
         105, 109, 109, 109, 110, 112, 112, 113, 114, 115)

z.test(d1, mu=100, sigma.x=15)
help(z.test)

mean(d1)

# pval = 0.3632 >0.05 => Ho accepted


# Two Sample Z-test
cityA = c(82, 84, 85, 89, 91, 91, 92, 94, 99, 99,
          105, 109, 109, 109, 110, 112, 112, 113, 114, 114)

cityB = c(90, 91, 91, 91, 95, 95, 99, 99, 108, 109,
          109, 114, 115, 116, 117, 117, 128, 129, 130, 133)

z.test(x=cityA, y=cityB, mu=0, sigma.x=15, sigma.y=15)

# pval = 0.085 > 0.05 => Ho is accepted



# T-Test

# One Sample T-test - 
# 1) Used to determine whether or not the mean of a population 
# is equal to some value.
# 2) Rules
# Ho: µ = x (the mean height is x)
# H1: µ ≠ x (the mean height is not x)
# if p_val>0.05 => Ho is accepted
# if p_val<0.05 => H1 is accepted

# Ex - A botanist wants to know if the mean height of a certain species 
# of plant is equal to 15 inches. 
# Ho: µ = 15 (the mean height for this species of plant is 15 inches)
# H1: µ ≠ 15 (the mean height is not 15 inches)
# if p_val>0.05 => Ho is accepted
# if p_val<0.05 => H1 is accepted

# height of random sample of 12 plants 
d1 <- c(14, 14, 16, 13, 12, 17, 15, 14, 15, 13, 15, 14)
print(length(d1)) # 12

mean_d1 <- mean(d1)
std_d1 <- sd(d1)
paste('Mean',mean_d1,'Std_Dev',std_d1)

# One sample t-test
t.test(d1, mu=15)

# test_stat = (x – μ) / (s√n) = (14.333-15)/(1.370689/√12) = -1.6848.
# if pval=0.1201 => p_val>0.05 => Ho is accepted

# Two Sample T-Test
# 1) It is used to test whether or not the means of two populations are equal.
# 2) Rules
# Ho: µ1 = µ2 (the two population means are equal)
# H1: µ1 ≠ µ2 (the two population means are not equal)
# if p_val>0.05 => Ho is accepted
# if p_val<0.05 => H1 is accepted

g1 <- c(8, 8, 9, 9, 9, 11, 12, 13, 13, 14, 15, 19)
g2 <- c(11, 12, 13, 13, 14, 14, 14, 15, 16, 18, 18, 19)
paste(length(g1),length(g2))

paste('Mean g1',mean(g1),'Mean g2',mean(g2))
paste('Std g1',sd(g1),'Std g2',sd(g2))
paste('Var g1',var(g1),'Var g2',var(g2))

# Two sample t-test
t.test(g1, g2)

help(t.test)  # Stats

# dof = n1+n2 - 2 = 12+12-2 = 22


# Ex2
marks = c(82,83, 97,83, 78, 68, 38, 59, 55)
schools = c(rep("A", 3), rep("B", 3), rep("C", 3))
df = data.frame(schools, marks)
df

a = df$marks[df$schools=="A"]
b = df$marks[df$schools=="B"]
c = df$marks[df$schools=="C"]
a
b
c
t.test(a,b)
# p_val = 0.168 >0.05 => Ho accepted
t.test(a,c)
# p_val = 0.0125 <0.05 => H1 accepted
t.test(b,c)
# p_val = 0.03624 <0.05 => H1 accepted



# ANOVA

help(aov)  # stats

model = aov(formula = df$marks~df$schools)
model
summary(model)

# Ho: As my school changes from A to B to C, the mean marks don't vary
# H1: As my school changes from A to B to C, the mean marks vary
# Mean(A) != Mean(B)
# Mean(A)!= Mean(C)
# Mean(B)!= Mean(C)



# Chi Square - Test of Independence
# 1) Used to determine whether or not there is a significant association
#    between two categorical variables
# 2) Rules
# Ho: (null hypothesis) The two variables are independent.
# H1: (alternative hypothesis) The two variables are not independent.

# Ex - we want to know whether or not gender is associated with
# political party preference.We take a simple random sample of 500 
# voters and survey them on their political party preference.

data <- matrix(c(120, 90, 40, 110, 95, 45), ncol=3, byrow=TRUE)
colnames(data) <- c("Rep","Dem","Ind")
rownames(data) <- c("Male","Female")
data

data <- as.table(data)
data

chisq.test(data)

help(chisq.test)  # stats

# dof = (row-1)*(col-1) = (2-1)*(3-1) = 1*2 = 2
# test_stat = 0.86404

# Skewness and Kurtosis
install.packages('moments')
library(moments)

install.packages('e1071')

help(rnorm)
x <- rnorm(50, 10, 10)  # n=50 mean=10,sd=10
paste('Skew',skewness(x),'Kurt',kurtosis(x))
hist(x)


help(skewness)
x1 <- c(10, 11, 21, 22, 23, 25)
paste('Skew',skewness(x1),'Kurt',kurtosis(x1))
hist(x1)

# Jarquee Bera Test
# Jarque-Bera test is a goodness-of-fit test that determines whether 
# or not sample data have skewness and kurtosis that matches a normal
# distribution.

# Ho:  Data is Normally Distributed
# H1:  Data is not Normally Distributed
# if p_val>0.05 => Ho is accepted
# if p_val<0.05 => H1 is accepted

install.packages('tseries')
library(tseries)

help(jarque.bera.test)

d3 <- rnorm(100) # mean=0,sd=1
d3
jarque.bera.test(d3)

# p-value of the test is 0.7137 > 0.05 => Ho is accepted  

