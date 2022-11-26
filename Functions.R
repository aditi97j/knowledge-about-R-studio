

# Functions

# One Liner if-else
x <- 24
a <- ifelse(x%%2==0,'Even','Odd')
print(a)

# Label Encoding- For binary categorical column
# df$gender = ifelse(df$gender=='male',1,0)

# np.where(df['a']<25,25,df['a'])

# Ex-1
f1 <- function(name){
  print(paste('Hello',name))
}

f1('Ankit')

# User Input
n <- as.numeric(readline("Enter a num: "))
n

# Ex2
# print table of a number
f2 <- function(n){
  for (i in c(1:10)){
    print(paste(n," * ",i," = ",n*i))
    }
}

f2(7)


# Ex3 - check even or odd
f3 <- function(n){
  if (i%%2==0){
    print(paste(n,"is even"))
  }else{
    print(paste(n,"is odd"))
  }
}

f3(24)
f3(45)


# fact

fact <- function(n){
  f = 1
  for (i in 1:n){
    f <- f*i
  }
  print(paste('Fact of',n,'is',f))
}

fact(7)

# Return 
f6  = function(x,y) {  
  add=x+y
  return(add)
}

f6(2,3)
f6(8,7)

# pass the values to the function



# Factorial of a num

fact <- function(n){
  f <- 1
  for (i in 1:n){
    f <- f*i
  }
  print(paste(n,'factorial is',f))
}

fact(4)





# Check if a number is prime or not

prime_chk <- function(n){
  ifelse(sum(n %% (1:n) == 0) > 2, FALSE, TRUE)
}

prime_chk(16)


sum(12 %% (1:12) == 0)

for (i in c(1:15)){
  print(i)
  print(prime_chk(i))  
}


# Check if number is armstrong or not
# 153 = 1^3 + 5^3 + 3^3
# 1634 = 1^4 + 6^4 + 3^4 + 4^4



arm_chk <- function(){
  num = as.integer(readline("Enter a num: "))  # 153
  numlen <- nchar(as.character(num))
  print(numlen)  # 3
  sum = 0
  temp = num  # temp = 153
  while(temp > 0) {
    rem = temp %% 10            
    sum = sum + (rem ^ numlen)  #  
    temp = temp %/% 10
  }
  if(num == sum) {
    print(paste(num, "is an Armstrong number"))
  } else {
    print(paste(num, "is not an Armstrong number"))
  }  
}



# s1: rem=153%%10=3, sum= 0+3^3 = 27,temp= 153%/%10 = 15
# s2: rem=15%%10 =5, sum= 27+5^3 = 27+125=152, temp=15%%10 = 1
# s3: rem=1%%10 = 1, sum=152+ 1^3 = 153, temp= 1%%10 = 0




# Palindrome num

pal_chk <- function(){
  num = as.integer(readline("Enter a num: "))
  sum = 0
  temp = num
  while(temp > 0) {
    rem = temp %% 10
    sum = sum*10 + rem
    temp = temp %/% 10
  }
  if(num == sum) {
    print(paste(num, "is an Pal number"))
  } else {
    print(paste(num, "is not an Pal number"))
  }  
}

pal_chk()


# Print all even numbers from a vector passed as an argument

f1 <- function(m){
  for (i in 1:length(m)) {
    if (m[i]%%2==0) {
      print(m[i])
    }
  }
}

x <- c(10,11,14,15,17,18,19,20) 
f1(x)

