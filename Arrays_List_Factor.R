

# Arrays
# 1) Compared to matrices, arrays can have more than two dimensions.
# 2) It is homogeneous, all elements must be of same type
# 3) An Array is a data structure which can store data of the same type in more than two dimensions.
# 4) Created using array() function
# 5) It is mutable
# 6) Syntax
# array(vector, dim = c(nrow, ncol, nmat))

# vector - the data items of same type
# nrow - number of rows
# ncol - number of columns
# nmat - the number of matrices of nrow * ncol dimension


a1 <- array(c(1:18),dim=c(2,3,3))  # row,col,3rd dim
print(class(a1))
print(length(a1))
print(a1)

print(a1[2,1,3]) # row,col,3rd dim
print(a1[1,2,1])

print(a1[,c(2),1])  
print(a1[c(1), ,2])


v1 <- c(3,2,1)
v2 <- c(8,7,6,5,4,3)
v3 <- c(10,20,30)

a1 <- array(c(v1,v2,v3),dim = c(3,2,2))
a1


rn <- c("r1", "r2")
cn <- c("c1", "c2", "c3")
mn <- c("m1", "m2")

d1 <- array(2:14, dim = c(2, 3, 2), dimnames = list(rn, cn, mn))
print(d1)

d1[1,2,2]
d1[1,,]
d1["r1","c3","m1"]
d1["r2",,"m2"]


d1[d1%%2==0]

# Modification
d1["r2","c1","m1"] <- 50
d1

d1[c(2,3,2)] <- 75
d1

# List
# 1) A list in R is a generic object consisting of an ordered 
# collection of objects. 
# 2) Lists are one-dimensional, heterogeneous data structures. 
# 3) The list can be a list of vectors, a list of matrices, a list of characters 
# and a list of functions, and so on. 
# 4) A list is a vector but with heterogeneous data elements. A list in R is 
#   created with the use of list() function.
# 5) It is mutable


# Ex1
r1 <- list("Red", "White", c(1,2,3), TRUE, 22.4)
print(r1)
print(length(r1))


# Ex2
v1 <- c(1,2,3)
v2 <- c("Python", "R", "DS", "ML")
v3 <- c(TRUE, FALSE, TRUE, FALSE,T)
r2 <- list(v1,v2,v3)
r2

# Ex3
rno <- seq(10,15)
ename <- c('Ankit','Ujjwal','Prattek','Mohit','Shreya')
marks <- c(78,84,92,56,87)
r3 <- list(rno,ename,marks)
names(r3) <- c("Rno",'Names',"Marks")
r3

# Accessing elements of a list
r3["Rno"]
r3[[2]]
r3[[3]][1]
r3[[3]][c(2,4)]

# Modifying elements of a list

r3

# Modify Prateek's Marks to 81
r3[[3]][3] <- 81
r3

### Add another element/vector to the list
city <- c('Delhi','Noida','Pune','Mumbai','Kolkata')
citylist <- list(city)
names(citylist) <- "City"

citylist

# combine r3 and citylist
students <- c(r3,citylist)
students

students[-2]

students[[4]][-3]



# Merging 2 lists
b1 <- list(1,2,3)
b2 <- list("Sun","Mon","Tue")

b3 <- c(b1,b2)
print(b3)


# Converting list to vector
t1 <- list("Python","R","ML","DL")
t1
class(t1)

t2 <- unlist(t1)
t2
class(t2)

# List to Matrix

v1 <- c(50,55,65,70,75,80)
v2 <- c(10,12,14,16,18,20)
w1 <- list(v1,v2)


m1 <- matrix(unlist(w1), nrow = 3, byrow = TRUE)
m1


# Factors
# 1) A Factor is a data structure that is used to categorize the data.
# 2) Created using the factor()
# 3) All the unique values in factors are represented by levels
# 4) levels(factor) returns unique values from a factor
# 5) Exaples :
# temp(low,med,high)
# state(up,mp,ap,kerala)


f1 <- factor(c('Thriller','Comedy','Suspense','SciFI','Biography','Suspense'))
print(class(f1))
print(length(f1))
f1

f1[1]
f1[3]


f1[3] <- "Comedy"
f1

f1[4] <- "Biography"
f1







