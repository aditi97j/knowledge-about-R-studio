w1 <- 10
print(w1)
a1 <- 10
print(a1)
print('a1 is',a1)
print(paste('a1 is',a1))

# R-Basics

# Built In Functions to print
# 1) print() - can be used to print only one entity.
# 2) paste() - can be used to print multiple comma separated entities.
# 3) cat() - has the option of sep parameter and fill =TRUE/FALSE
#            fill = TRUE (is same as end="\n" in print)

# Variables
# 1) Containers to hold data

# Variable declaration
# 1) can be done using = or <- or -> operators
# 2) Same values can be assigned to multiple variables in the same line

a1 <- 10
print(a1)
print('a1 is',a1)
print(paste('a1 is',a1))

a2 = 20
25 -> a3
paste(a2)
paste(a3)

paste('a2 is',a2)
paste("a2 is",a2)
print('a2 is',a2)
cat(a1,a2,sep="***",fill=TRUE)
cat(a1,a2,sep="__")
paste(a1,a2,sep="__")

cat(a1,a2,sep="__",fill=FALSE)

# Function definition
help(paste)
help(cat)

q1,q2 <- 5,10  # Error

w1 <- w2 <- 18
paste(w1,w2)

# Note
# class() function is used to check data type

# Data Types
# Basic Data Types
# numeric(int and float), character(alphanumeric or str), logical
# complex ,integer

b1 <- 8
paste(b1,class(b1))
cat(b1,class(b1))

b2 <- 4.5
paste(b2,class(b2))

# character is enclosed in  '' or ""
b3 <- "Hello 123"
b4 <- 'World@ Google 234$&^'
b5 <- "ML and Data 
Science with R"
paste(b3,class(b3))
paste(b4,class(b4))
paste(b5,class(b5))

b6 <- TRUE
b7 <- FALSE
paste(b6,class(b6))
paste(b7,class(b7))

b8 <- F
paste(b8,class(b8))

b9 <- 5+7i
paste(b9,class(b9))

b10 <- 5234L
paste(b10,class(b10))

# Typecasting
# changing from one data type to another data type

w1 <- "754"
paste(w1,class(w1))

w2 <- as.numeric(w1)
paste(w2,class(w2))

w3 <- as.integer(w1)
paste(w3,class(w3))

# Operators
# 1) Arithmetic Operators

a1 <- 12
a2 <- 4
a3 <- 2
print(a1+a2)  # addition
print(a1-a2)  # subtraction
print(a1*a2)  # mutliplication
print(a1/a2)  # division - returns integer if operands are int otherwise in decimal
print(a1^a3)  # exponent
print(a1**a3) # exponent
print(a1%%a3) # remainder (%%)
print(7%%3)   # 
print(7/3)
a <- 5
b <- 2
print(a%/%b)  # integer division (%/%)
print(a%%b)

# 2) Relational Operators - Return TRUE or FALSE
a1 <- 5
a2 <- 2
a3 <- 5
print(a1>a2)   
print(a1>=a2)  
print(a1<a2)  
print(a1<=a2)   
print(a1!=a2)  
print(a1==a3) 

# 3) Logical Operators (&& &(and) || |(or)) and not(!)
w1 <- 5
w2 <- 10
w3 <- 7
print(w1<w2 && w2<w3)  # and
print(w1<w2 & w2<w3)   # and
print(w1<w2 && w2>w3)  # and
print(w1<w2 || w2<w3)  # or
print(w1<w2 | w2<w3)   # or
print(w1>w2 || w2<w3)  # or 
print(!T)
print(!F)
