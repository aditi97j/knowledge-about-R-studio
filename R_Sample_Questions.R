

# R Sample Questions

library(ggplot2)

# Q1) Create a list containing a vector,a matrix, and a list.
# Add an element to the end of the list

c1 <- c('Guava','Grapes','Apple','Orange')
m1 <- matrix(c(10,20,30,40,50,60),nrow=2)
l1 <- list('Vector','Array','Matrix')

res <- list(c1,m1,l1)
res

# Add a new element to the lsit res
# method-1
res1 <- c(res,'Hello')
res1

# method-2
res2 <- append(res,"Welcome")
res2

# Q2) Merge 2 lists

w1 <- list('IT','HR','Operations')
w2 <- list('Google','Meta','Netflix')

w3 <- c(w1,w2)
w3


# Q3) Convert a Dataframe to list by Rows
names <- c('Ankit','Shreya','Jatin','Vipin')
age <- c(23,24,22,25)
city <- c('Delhi','Mumbai','Pune','Delhi')

df <- data.frame(names,age,city)
df

r1 <- split(df,seq(nrow(df))) 
r1

# Q4) Rotate a matrix by 90 degrees
s1 <- matrix(1:16,nrow=4)
s1

# rotate by 90 degree
t(s1)


# Q4) Scale the features in Cars dataset. Then perform kmeans clustering
# Print the cluster number for each observation and cluster size

df_cars <- cars
View(df_cars)

df_cars_sc <- scale(df_cars)
View(df_cars_sc)
colnames(df_cars_sc)


library(factoextra)
library(cluster)  # kmeans


fviz_nbclust(df_cars_sc, kmeans, method = "wss")
# optimal num of clusters = 3 or 4 or 5

km5 <- kmeans(df_cars_sc,center=5)

# Cluster number of each observation
km5$cluster

# Number of cluster for each observation (Cluster size)
table(km5$cluster)

df_cars$cls5 <- km5$cluster
View(df_cars)

# Plot result of Kmeans cluster
ggplot(df_cars,aes(x=speed,y=dist, color=cls5)) + geom_point()

