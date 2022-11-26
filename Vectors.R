# R Data Structure
# 1) Vector (1D)
# 2) Array  (nD)
# 3) List
# 4) Factor
# 5) Matrix (2D)
# 6) Data Frame

# Homogeneous Data Types - Vector, Matrix, Array
# Hetrogeneous Data Type - List, DataFrame 


# Vectors
# 1) They are 1D array.
# 2) They can hold numeric, character, boolean, integers etc data types
# 3) All the elements must be of same data type
# 4) We use c i.e. combine function to create a vector
# 5) It is just like a column in a dataframe.
# 6) Vector is mutable.

v1 <- c(10,14,15,17)
print(class(v1))   # returns data type of elements of v1
print(length(v1))

v2 <- c("Python",'R','Tableau','ML',"data sceince",'DL','Power BI')
print(v2)
print(class(v2))

v1a <- c('Python',45,6.7)
print(class(v1a))
v1a

v1b <- c(23,'Python',45,6.7)
print(class(v1b))
v1b

# TRUE = 1, FALSE = 0
v1c <- c(23,FALSE,45,6.7,TRUE)
print(class(v1c))
v1c

v1d <- c(23,FALSE,45,6.7,TRUE,34L)
print(class(v1d))
v1d

v1e <- c(23L,FALSE,45L,TRUE,34L)
print(class(v1e))
v1e

# order of precedence -> character, numeric, integer, logical

v3 <- c(1,2,3,"Welcome","Hello",6,7)
print(v3)
print(class(v3))
print(length(v3))

v4 <- c(F,4,78,TRUE)
print(v4)
print(class(v4))

# Indexing and slicing
# Positive Indexes starts from 1 from left to right
# Negative indexes Start from -1 from left to right
# Excludes the element passed with negative indexes

v5 <-  c(5,7,3,4,9,12,15,10,6,8,17)
print(v5)
print(length(v5))

# Positive indexing - Indexing one element at a time
cat(v5[1],v5[2],v5[3],v5[4])
cat(v5[length(v5)]) # finds what number is at that length

# Positive Indexing/Slicing - Indexing multiple elements at a time
print(v5[c(1,7,4,10)])

# Negative Indexing - Indexing one element at a time
print(v5)
print(v5[-2])
print(v5[-5])
# Negative Indexing/Slicing - Indexing multiple elements at a time
print(v5[c(-2,-9,-5)])

# Slicing in Vectors - positive indexes
# v[start:end] -> inclusive of start and end, step +1 in ascending order
# v[start:end] -> inclusive of start and end, step -1 in descending order
print(v5)
print(v5[3:7]) # start=3,end=7, inclusive of 3 and 7
print(v5[2:5]) # start=2,end=5, inclusive of 2 and 5
print(v5[5:1]) # start=5,end=1, inclusive of 5 and 1
print(v5[8:3]) # start=8,end=3, inclusive of 5 and 1
print(v5[2:7]) # start=2,end=7, inclusive of 2 and 7   
print(v5[7:3]) # start=7,end=3, inclusive of 15 and 3  

# Slicing in Vectors - Negative indexes
# v[start:end]
# Only of the negative values can be used in this slicing syntax 
# and the other has to be 0
# if start is -ive, end=0,  slicing direction is from left to right
# if start is 0, end=-ive,  slicing direction is from left to right

print(v5)
print(v5[5:-2])  # err
print(v5[5:-7])  # err
print(v5[-5:2])  # err
print(v5[-5:7])  # err
print(v5[-1:0])  # starting from -2 till right end 
print(v5[-7:0])  # starting from -8 till right end 
print(v5[-4:0])  # starting from -5 till right end
print(v5[0:-5])  # starting from -6 till right end
print(v5[0:-8])  # starting from -9 till right end


# Iterating in vectors
# Method-1, i corresponds to each and every element of vector v5
for (i in v5) {
  print(i)
} 
a <- 3:1
a

# Method-2, i corresponds to index of vector v5
for (i in 1:length(v5)) { # i=1,2,3,....,11
  print(v5[i])
}

# print vector in reverse
for (i in length(v5):1) {
  print(v5[i])
}


for (i in v5[2:5]) {
  print(i)
}

# Print all even numbers from v5
for (i in 1:length(v5)){ 
  if (v5[i]%%2==0) {
    print(v5[i])  
  }
}

# Print all odd placed(indexed) numbers from v5
for (i in 1:length(v5)){ 
  if (i%%2!=0) {
    print(v5[i])  
  }
}

# Iterating over vector using index
i <- 1
while (i < length(v5)) {
  print(v5[i])
  i <- i + 1
} 

# Iterating over vectors in reverse order
i <- length(v5)
while (i >=1 ) {
  print(v5[i])
  i <- i - 1
} 


w <- c(12,14,16,18,19,20)
for (i in 1:length(w)){
  if (i%%2==0){
    print(w[i])
  }
}

# rev a vector - reversing the order of elements from right to left
v6 <- rev(v5)
v6

# Vector Operations
# addition,multiplication,subtraction,division
# vector length should be same

print(8/4)

z1 <- c(4,5,7,3)
z2 <- c(8,15,28,15)

r1 <- z2/z1
paste(r1,class(r1))

print(z1+z2)
print(z2-z1)
print(z1*z2)
print(z2/z1)
print(z2%%z1)
print(z2%/%z1)

# if length of vectors is changed
z1 <- c(4,5,7,3,17)
z2 <- c(8,15,28,15)
print(z1+z2)

z1 <- c(4,5,7,3,17,40,56)
z2 <- c(8,15,28,15)
print(z1+z2) # additional element is added to the first element
print(z2-z1) # 
print(z1*z2) # 

print(z2/z1)  # 8/17, 15/40, 56/28 and so on
print(z1/z2)

z1 <- c(4,5,7,3)
z2 <- c(8,15,28,15,30)
print(z1+z2)
print(z2+z1)

# Functions to be applied on Vectors

f1 <- c(9,5,7,3,6)
print(f1)
print(max(f1))
print(min(f1))
print(sum(f1))
print(mean(f1))
print(median(f1))
print(var(f1))
print(sd(f1))

print(sort(f1))
print(sort(f1,decreasing=TRUE))


f1 <- c(9,5,7,3,6)
#idx -  1 2 3 4 5
#       4 2 5 3 1 - index in ascending order   
print(f1)
print(order(f1))  # ascending order
print(f1[order(f1)])
print(order(f1,decreasing=TRUE))
print(f1[order(f1,decreasing=TRUE)])

# vector comparison
r1 <- c(5,4,7,6,9,3,8) 
print(r1<5)
print(r1>=6)


# Giving labels to vectors
v1 <- c(10,20,30,40,50)
print(v1)
names(v1) <- c('Mon','Tue','Wed','Thu','Fri')
print(v1)
print(v1['Mon'])
print(v1[1])
print(v1[2:4])

# Fetching Vectors using conditions
v1[v1>20]


# Vector is mutable
g1 <- c('Python','R','DS','ML','DL')
print(g1)
g1[4] <- "Tableau"
print(g1)
g1[2] <- 500
print(g1)

# Append a vector
b1 <- c(5,6,7,8)
b1[5] <-22
b1
b1[8] <- "Hello"
b1


# Vector Functions
# rep(),seq(), is.vector(),any(),all()
help(rep)

e1 <- c(8,9,7)
e2 <- rep(e1,3)
e2

is.vector(e1)
any(e1>8)
any(e1<5)
all(e1>=7)
all(e1<9)

# lapply - it returns a list as its output

emp <- c('Arun','Vipul','Arjun','Mayank')
emp1 <- lapply(emp,tolower)
emp1
print(class(emp1))

# sapply - it returns a vector as its output
emp2 <- sapply(emp,toupper)
emp2
print(class(emp2))



