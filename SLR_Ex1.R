

# Linear Regression Ex -1

library(ggplot2)
library(corrplot)

x <- c(151, 174, 138, 186, 128, 136, 179, 163, 152, 131)
y <- c(63, 81, 56, 91, 47, 57, 76, 72, 62, 48)

paste(length(x),length(y))


m1 <- lm(formula = y~x)
summary(m1)

# coef
coef(m1)
# r-squared
summary(m1)$r.squared

# y = 0.6746x + (-38.4551)

plot(x,y)
df <- data.frame(x,y)
df



corr <- cor(df)
corrplot(corr,method='number')

ggplot(df,aes(x=x,y=y)) + geom_point(color='maroon')

summary(m1)

# Custom Prediction

test1 <- data.frame(x=170)
test1

predict(m1,test1)

df <- data.frame(x,y)
df

df$pred <- predict(m1,data.frame(x))
df

ggplot(df,aes(x=x,y=y)) + geom_point(color='blue')
ggplot(df,aes(x=x,y=pred)) + geom_point() + geom_line(color='maroon')

p <- abline(lm(y~x))
p

ggplot(df,aes(x=x,y=y)) + geom_point(color='blue') + abline(lm(y~x))

# Plot Linear Regression
plot(y~x)
abline(m1)

# Plot Linear Regression using ggplot
ggplot(df,aes(x=x,y=y))  + 
  geom_point() +
  stat_smooth(method = "lm", col = "red")



res <- df$pred - df$y
sse = sum(res**2)
mse = mean(res**2)
rmse = sqrt(mse)
paste('SSE',sse,'MSE',mse,'RMSE',rmse)

