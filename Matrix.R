
# Matrix
# 1) A matrix is a two dimensional data set with columns and rows. 
# 2) A column is a vertical representation of data, while a row is a 
#   horizontal representation of data.
# 3) A matrix can be created with the matrix() function. 
#  Specify the nrow and ncol parameters to get the amount of rows and columns:
# 4) It is homogeneous
# 5) It is mutable

m1 <- matrix(c(1,2,3,4,5,6), nrow = 3, ncol = 2)
print(class(m1))
m1

# m2 <- matrix(seq(1,8), nrow = 2)
m2 <- matrix(seq(1,8), nrow = 4)
# print(class(m2))
m2


# m3 <- matrix(seq(1,8), ncol = 4)
m3 <- matrix(seq(1,8), ncol = 6)
m3
# m3 <- matrix(seq(1,8), ncol = 2)



m4 <- matrix(seq(1,9), nrow = 3,byrow=T)
m4

m5 <- matrix(seq(1,9), nrow = 3,byrow=F)
m5

# Fetching elements from matrix
n1 <- matrix(seq(1,12),nrow=4)
n1

# Syntax - matrix_name[row_idx,col_idx]
n1[1,]  # extract row 1
n1[,2]  # extract col 2
n1[-1,]  # extract all rows except 1
n1[,-3]  # extract all cols except 3
n1[2,3]  # row =2, col=3
n1[4,1]
n1[c(2,3),2]
n1[c(1,4),c(1,3)]
n1
n1[2:4,1:2]
n1[-1,-2]  # exclude row index -1 and exclude col index -2

n1[c(-1,-4),-2]
n1[-3,c(-1,-2)]  


# Creating matrix using different vectors

names <- c('Ankit','Raj','Hitesh','Shubham')
age <-  c(20,22,21,13)
city <- c('Delhi','Noida','Pune','Kanpur')

data <- matrix(c(names,age,city),nrow=4)
data

rownames(data) = c("a", "b", "c","d")
colnames(data) = c("Names","Age","City")

data
data["a","Names"]
data[c("a","d"),c("Names","Age")]


# Modifying matrix elements
data["b","Age"] <- 45
data

# Matrix Functions
# rbind(), cbind(), solve(), t(), 
# dim, dimnames

# Add a new row
d1 <- c("Sandhya",20,"Mumbai")
d1

data1 <- rbind(data,d1)
data1

rownames(data1) = c("a", "b", "c","d","e")
data1

# Add a new column
course <- c('BCA','BTech','BCOM','BA','MCA')
course

data2 <- cbind(data1,course)
data2

data2[,"Age"]

# data type of column cant be changed using matrix 
data2[,"Age"] <- as.numeric(data2[,"Age"])
data2[,"Age"] <- as.integer(data2[,"Age"])
data2[,"Age"]

age_in_int <- as.integer(data2[,"Age"])
class(age_in_int)


x <- matrix(seq(1,6),c(3,2))
y <- matrix(seq(5,12),c(2,4))
z <- matrix(c(1,2,5,6,8,4,12,16,15),c(3,3))
# matrix multiplication
x
y

x%*%y

# inverse of a matrix - solve(matrix)
z
z1 <- solve(z)
z1

z%*%z1 

# transpose of matrix
z
t(z)


# dim and dimnames
data2
print(dim(data2))
print(dimnames(data2))


# create diagonal matrix with only diagonal elements, other elements are 0
c1 <- diag(c(1,3,8,10))
c1

# determinant of a matrix
det(z)

# sum(), colSums,rowSums
z
sum(z)
rowSums(z)
colSums(z)

mean(z)
colMeans(z)
rowMeans(z)

# convert matrix to vector
class(z)

z2 <- as.vector(z)
z2
print(class(z2))









