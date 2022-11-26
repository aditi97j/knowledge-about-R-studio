
# Plot in R using graphics

# 1) Barplot
# barplot(height, names.arg,col,xlab,ylab,main)

x <- seq(1,7)  
sales <- c(10,12,9,14,11,16,15)
wnames <- c('Mon','Tue','Wed','Thu','Fri','Sat','Sun')

barplot(sales,names.arg=x,xlab='Weekday Names',ylab='Sales',col='blue',
        main='Weekday wise Sales -  Bar chart')
legend('topleft','Sales',fill='blue')

# 2) Clustered Bar Chart - Side by Side Bars
s1 <- matrix(c(7,12,10,9,11,6,8,4,12),c(3,3))
s1
colors = c("green", "orange", "brown")
months <- c("Mar", "Apr", "May")
regions <- c("A", "B", "C")

barplot(s1, main = "Total Revenue", names.arg = months, 
        xlab = "Month", ylab = "Revenue", 
        col = colors, beside = TRUE)
legend("topleft", regions, fill = colors)


# 3) Stacked Bar Chart
barplot(s1, main = "Total Revenue", names.arg = months, 
        xlab = "Month", ylab = "Revenue", col = colors)
legend("topleft", regions, fill = colors)

# 4) Line Chart
# plot(val,type='o',xlab,ylab,main)
# lines(val, type = "o", col)

sales <- c(10,12,9,14,11,16,15)
plot(sales,type='o',col='maroon')
plot(sales,col='maroon')

help(plot)

# lines(sales, type = "o", col = "blue")


# 5) Plot multiple lines
a1 <- c(17, 25, 38, 13, 41)
a2 <- c(22, 19, 36, 19, 23)
a3 <- c(25, 14, 16, 34, 29)

# Plot the bar chart.
plot(a1, type = "o", col = "red",
     xlab = "Month", ylab = "Article Written ",
     main = "Article Written chart")

lines(a2, type = "o", col = "blue")
lines(a3, type = "o", col = "green")


# 6) Scatter Chart
View(mtcars)

plot(x=mtcars$mpg,y=mtcars$disp,col='blue',
     xlab = "MPG",
     ylab = "Displacement", main = "MPG VS Disp")

# 7) Boxplot
n1 <- c(2,4,5,2,3,1,7,6,5,6,7,9,4,3,5,6,3,2,1,4,5,6,3,2,2,4,4,5)
boxplot(n1, col='orange',xlab = "x",ylab = "Frequency", 
        main = "Boxplot")


# 8) Histogram
n1 <- c(2,4,5,2,3,1,7,6,5,6,7,9,4,3,5,6,3,2,1,4,5,6,3,2,2,4,7,5,8)
hist(n1)


# 9) Pie Chart
scores = c(56,67,78,89,93)
sub = c('Python','DS','R','DL','ML')
help(pie)
pie(scores, labels = sub, 
    main = "Percentage of Marks", radius = -1,
    col.main = "darkgreen")

pie(scores, labels = paste0(scores, "%"))

pie_lab <- paste0(sub,"=",round(100*scores/sum(scores),2),"%")
pie(scores,labels=pie_lab, col = "white",
    main = "Percentage of Marks", radius = -1,
    col.main = "darkgreen")


install.packages('plotrix')
library(plotrix)
pie3D(scores, labels = sub,
      main = "Percentage of Marks", radius = -1,
      col.main = "darkgreen")



# R Plots using dataframe

df = read.csv('C:\\Users\\Dell\\Downloads\\R_Programming\\StudentsPerformance.csv')
View(df)

colnames(df) <- c('Gender','RE','PLE','Lunch','TPC','Math','Reading','Writing')
colnames(df)


# a) Plot Count of RE on a BarPlot
r1 <- table(df$RE)
class(r1)

barplot(r1,xlab='RE',ylab='Count',col='blue',
        main='RE Count -  Bar chart')
legend('topleft','value',fill='blue')

# b) Plot Count of PLE on a PieChart
r2 <- data.frame(table(df$PLE))
r2
colnames(r2) <- c('PLE','Count')
r2
sum(r2[,2])

col1 = c("Blue", "Red", "Green", "Orange",'Brown','white','tan')

pie(r2[,2],labels=r2[,1],col=col1)

pie_lab <- paste0(r2[,1],"=",round(100*r2[,2]/sum(r2[,2]),2),"%")
pie(r2[,2],labels=pie_lab,col=col1)


# c) Plot Scatter Chart between Math and Reading scores
plot(x=df$Math,y=df$Reading,col='red',xlab='Math',ylab='Reading')


# d) Plot frequency distribution for Math Scores

hist(df$Math)

# e) Plot Line Chart for Mean of Math score based on PLE

r4 <- df %>% group_by(RE) %>% summarise(Score = mean(Reading))
r4

class(r4)

plot(r4$Score,type='o')

# f) Plot Boxplot for Writing Score

boxplot(df$Writing)

# g) Gender wise Mean of Math Score

r5 <- df %>% group_by(Gender) %>% summarise(Score = mean(Math))
r5

v1 <- as.matrix(r5)
v1
barplot(v1)

