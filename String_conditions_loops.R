# Strings

s1 <- "Hello World"
paste(nchar(s1))

install.packages("dplyr")
install.packages("tidyverse")

library(stringr)
str_length(s1)

# String Indexing
# Positive Indexes start from 1 from left to right
# Negative Indexes start from -1 from left to right
# In negative indexes, for any given value it will start at -1 only
# str has to be positive to get an output, otherwise no output

substr(s1,start=1,stop=5)
substr(s1,2,4)
substr(s1,4,2)  # no output
substr(s1,4,7)
substr(s1,-1,2)  # Hello World
substr(s1,-3,5)
substr(s1,-5,7)
substr(s1,-5,-3) # no output
substr(s1,-5,3)
substr(s1,-1,-6) # no output
substr(s1,-7,4)

help(substr)

# Replace substring using substr

substr(s1,1,5) <- "Numpy"
print(s1)

substr(s1,1,5) <- "Welcome"
print(s1)

q1 <- "Python program"
q2 <- "InDiA"
print(toupper(q1))
print(tolower(q2))

# String concatenation
s1 <- "Welcome to"
s2 <- "R programming"
s3 <- "ML with R"
r1 <- paste(s1,s2,s3,sep=' ')
r1
cat(s1,s2,s3,sep=' ')

# Accept User Input
# return type of readline() function is character

x1 <- readline("Enter your name: ")
paste(x1,class(x1))

x2 <- as.numeric(readline("Enter a num: "))
x2

x2 <- as.integer(x2)
print(paste(x2,class(x2)))

# Conditional Statements - if-elif-else

n1 <- 33
n2 <- 35
n3 <- 30
paste(n1,n2,n3)

# 1) if
if (n2 > n1) {
  paste(n2, "is greater than", n1)
} 

# 2) if-else
if (n2 > n1) {
  paste(n2, "is greater than", n1)
} else {
  paste(n1, "is greater than", n2)
}

# 3) if - else if - else

if (n1>n2 && n1>n3) {
  paste("Greatest is :", n1)
} else if (n2>n3 && n2>n1) {
  paste("Greatest is :", n2)
} else{
  paste("Greatest is :", n3)
}

# 4) Nested -if
var1 <- 7
var2 <- 5
var3 <- -4

if(var1 > 10 || var2 < 5){
  print("condition1")
}else{
  if(var1 <4 ){
    print("condition2")
  }else{
    if(var2>10){
      print("condition3")
    } else{
      print("condition4")
    }
  }
}

x <- as.integer(readline(prompt = "Enter first number :"))
y <- as.integer(readline(prompt = "Enter second number :"))
z <- as.integer(readline(prompt = "Enter third number :"))

if (x > y) {
  if (x > z)
    print(paste("Greatest is :", x))
  else
    print(paste("Greatest is :", z))
} else  {
  if (y > z)
    print(paste("Greatest is :", y))
  else{
    print(paste("Greatest is :", z))
  }
}

# For loop
# seq(start,end,step) - 
# Inclusive of start and end in both ascending and descending order
# in descending order, default step size is -1
# in ascending order, default step size is +1

a <- seq(5,9)
for (i in a){
  print(i)
}

a1 <- seq(10,5)
for (i in a1){
  print(i)
}

a2 <- seq(8,19,3)
for (i in a2){
  print(i)
}

a3 <- seq(20,5,-4)
for (i in a3){
  print(i)
}

a4 <- seq(-5,17,3)
for (i in a4){print(i)}


a5 <- 10:15
for (i in a5){
  print(i)
}

a6 <- 18:14
for (i in a6){
  print(i)
}

a5 <- 5:12:2
paste(a5)

for (i in a5){
  print(i)
}

a6 <- letters
for (i in a6){
  print(i)
}

a7 <- LETTERS[5:10]
for (i in a7){
  print(i)
}

# for with break
a5 <- seq(20,27)
for (i in a5){
  print(i)
  if (i==24){
    break
  }
}

# for with next (continue)

a5 <- seq(10,16)
for (i in a5){
  if (i==13){
    next
  }
  print(i)
}

# While loop
# Ex1 - post increment

i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
} 

# pre increment
i <- 1
while (i < 6) {
  i <- i + 1
  print(i)
} 

# Ex2 - post decrement
i <- 14
while (i > 5) {
  print(i)
  i <- i - 2
} 

# Ex3 - while with break
i <- 1
while (i < 6) {
  print(i)
  i <- i + 1
  if (i == 4) {
    break
  }
}

# Ex3 - while with next
i <- 0
while (i < 6) {
  i <- i + 1
  if (i == 3) {
    next
  }
  print(i)
} 

# Switch statement 

val1 = 6  
val2 = 7
val3 = "r"  
result = switch(  
  val3,  
  "a"= cat("Addition =", val1 + val2),  
  "d"= cat("Subtraction =", val1 - val2),  
  "r"= cat("Division = ", val1 / val2),  
  "s"= cat("Multiplication =", val1 * val2),
  "m"= cat("Modulus =", val1 %% val2),
  "p"= cat("Power =", val1 ^ val2)
)  
