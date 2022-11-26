

install.packages("factoextra")

library(factoextra)
library(cluster)  # kmeans

age <- c(18, 21, 22, 24, 26, 26, 27, 30, 31, 35, 39, 40, 41, 42, 44, 46, 47, 48, 49, 54)
spend <- c(10, 11, 22, 15, 12, 13, 14, 33, 39, 37, 44, 27, 29, 20, 28, 21, 30, 31, 23, 24)

paste(length(age),length(spend))

df <- data.frame(age, spend)
head(df,4)

plot(df$age,df$spend)

ggplot(df,aes(x=age,y=spend)) + geom_point()

# Applying KMeans
km3 <- kmeans(df,center=3)
km3

ypred3 <- km3$cluster
ypred3

df$Cls3 <- km3$cluster
head(df,4)
View(df)

km3$withinss  # WCSS for each cluster
km3$tot.withinss # Sum of WCSS for all clusters


# Plot the clusters
ggplot(df,aes(x=age,y=spend, color=Cls3)) + geom_point()


km_wcss <- function(data,k) {
  cluster <- kmeans(data, k)
  return (cluster$tot.withinss)  # Total WCSS (Sum of WCSS)
}

for (i in 1:12){
  print(paste('i',i,'WCSS',km_wcss(df,i)))  
}

wcss <- function(k) {
  cluster <- kmeans(df, k)
  return (cluster$tot.withinss)
}

max_k = 12
wss <- sapply(2:max_k, wcss)
elbow <- data.frame(2:max_k, wss)


ggplot(elbow, aes(x = X2.max_k, y = wss)) +
  geom_point() +
  geom_line() +
  scale_x_continuous(breaks = seq(1, 12, by = 1))



### KMeans - customers dataset

df <- read.csv("C:\\Users\\Dell\\Downloads\\R_Programming\\ML\\KMeans\\customers.csv")
View(df)

df <- df[,c(4,5)]
colnames(df)

colnames(df) <- c('AnnIn','SScr')
colnames(df)


plot(df$AnnIn,df$SScr)

ggplot(df,aes(x=AnnIn,y=SScr)) + geom_point()

colnames(df)

# Elbow Method
fviz_nbclust(df, kmeans, method = "wss")

# Kmeans at k = 5
km5 <- kmeans(df,center=5)

km5$cluster

df1 <- data.frame(df)

df1$Cls5 <- km5$cluster
head(df1,4)
View(df1)










# Ex2

df <- USArrests
View(df)

colnames(df)
dim(df)
# null value
colSums(is.na(df))
# duplicates
sum(duplicated(df))

# scale the data
df <- scale(df)
head(df,5)


# Elbow Method
help(fviz_cluster)
fviz_nbclust(df, kmeans, method = "wss")

# optimal num of clusters = 4

set.seed(42)
# centers = numer of cluster centers
# nstart = 
km <- kmeans(df, centers = 4, nstart = 25)
km

help(kmeans)

cent4 <- km$centers
cent4

ypred4 <- km$cluster
ypred4

table(ypred4)

fviz_cluster(km, data = df)

km$withinss



