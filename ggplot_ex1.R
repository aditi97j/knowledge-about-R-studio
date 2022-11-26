
library(dplyr)
library(ggplot2)
# R ggplot
# Link Used -> https://r-graph-gallery.com/218-basic-barplots-with-ggplot2.html


name=c("A","B","C","D","E")
value=c(3,12,5,18,45)
d1 <- data.frame(name,value)
d1

str(d1)


View(mtcars)

str(mtcars)
# Bar plot
ggplot(d1, aes(x=name, y=value,fill=name)) + geom_bar(stat = "identity")

# Barh plot
ggplot(d1, aes(x=name, y=value)) + geom_bar(stat = "identity") + 
      coord_flip()

table(mtcars$cyl)

# Countplot
ggplot(mtcars, aes(x=as.factor(cyl) )) +
  geom_bar(color="blue",fill='orange')  # border color

ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) + 
  geom_bar() + ggtitle('Cylinder Count') +
  xlab('Cylinder') + ylab('Count')

ggplot(mtcars, aes(x=as.factor(cyl), fill=as.factor(cyl) )) +  
  geom_bar( ) +
  scale_fill_manual(values = c("red", "green", "blue") ) +
  theme(legend.position="none")

# Histogram
ggplot(mtcars, aes(x=mpg)) + geom_histogram() + ggtitle('Density Distribution')

ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth=3, fill="blue") + 
  ggtitle('Density Distribution')


# Density Plot
ggplot(mtcars, aes(x=disp)) + geom_density(fill='lightgreen')
ggplot(mtcars, aes(x=mpg)) + geom_density(fill='tan')

# Scatter Plot
View(iris)
str(iris)

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) + geom_point()

ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width, 
                 color=Species, shape=Species)) + 
  geom_point(size=3)


# Line Chart

ggplot(data=mtcars,aes(x=disp,y=mpg)) + geom_line() + geom_point()

d1
str(name)

ggplot(d1, aes(x=as.factor(name), y=value)) +
  geom_line(color="maroon", size=2) + geom_point(size=4)

ggplot(d1, aes(x=c(1,2,3,4,5), y=value)) +
  geom_line(color="maroon", size=2) + geom_point(size=4)


# Pie Chart
ggplot(d1, aes(x="", y=value, fill=name)) +
  geom_bar(stat="identity", width=1) +
  coord_polar("y", start=0)


# Boxplot
ggplot(mtcars,aes(x=disp)) + geom_boxplot()

ggplot(iris, aes(Species, Sepal.Length)) +
  geom_boxplot() + theme(axis.text.x = element_text(angle = 45))

# Area Chart
ggplot(data=mtcars,aes(x=disp,y=mpg)) + geom_area() 

