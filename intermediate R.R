

# conditional, if else, else if 
#March 12
# Source:
# https://campus.datacamp.com/courses/intermediate-r/chapter-1-conditionals-and-control-flow?ex=2
  
  
# ==, <=, !=, 
  
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)
views == 14
views >= 8
views != 17

# and or | & 

ln <- c(16, 9, 13, 5, 2, 17, 14)
last <- tail(linkedin, 2) # gives last two values 
last

# last under 5 or above 10?
last < 5 | last > 10

# last between 15 (exclusive) and 20 (inclusive)
last > 15 & last <= 20 

((last > 15) & (last <= 20)) # False 


# & | works same in vector as well 

linkedin > 10 & facebook < 10 

linkedin >= 12 | facebook >= 12

views > 11 & views <= 14


# if, else , else if ===================================

md <- "LinkedIn"
num <- 14

if (md == "LinkedIn") {
  print("Showing LinkedIn information")
}


if (num > 11) {
  print("You're popular!")
} else {
  print("Try to be more visible!")
}


if (md == "LinkedIn") {
  print("Showing LinkedIn information")
  
} else if (md == "Facebook") {
    print("Showing Facebook information")
  
} else {
  print("Unknown medium")
  
}



# control flow construct 
li <- 4
fb <- 19

if (li >= 15 & fb >= 15) {
  sms <- 2 * (li + fb)
  
} else if  (li < 10 & fb < 10) {
  sms <- 0.5 * (li + fb)
  
} else {
  sms <- li + fb
}

# Print sms to the console
print(sms)

# ==========================ifelse =====================================================
for (i in ln) {
  ifelse(i > 5, 'large', 'small')
  print(i)
}

#======================while loop ====================================================

sd <- 76

# while loop
while (sd > 40 ) {
  print("Slow down!")
  sd <- sd - 5
}

# Print sd variable
sd # prints 36 fails condition and exits teh loop 



# Initialize the speed variable
sd <- 64

# Extended  while loop
while (sd > 20) {
  print(paste("Your speed is",sd))
  
  if (sd > 40 ) {
    print("Slow down!")
    sd <- sd - 11 
    
  } else {
    print("OK!")
    sd <- sd - 6
  }
}


# Initialize the speed variable
speed <- 88

while (speed > 30) {
  print(paste("Your speed is", speed))
  
  # Break the while loop when speed exceeds 80
  if (speed > 80 ) {
    break # it breaks for speed is 88 > 80 
  }
  
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# write a while loop so that it:
# prints out the triple of i, so 3 * i, at each run.
# is abandoned with a break if the triple of i is divisible by 8, but still prints out this triple before breaking.


# Initialize i as 1 
i <- 1

# while loop
while (i <= 10) {
  print(3 * i)
  if ( 3 * i %% 8 == 0 ) {
    print(3 * i)
    break
  }
  i <- i + 1
}


############====For loop ============================================================

nums <- c(16, 9, 13, 5, 2, 17, 14)

# Loop version 1
for ( l in nums){
  print(l)
}



# Loop version 2
for (i in 1:length(nums)){
  print(nums[i])
}


# Loop over a list 

nyc <- list(pop = 8405837, 
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"), 
            capital = FALSE)
?list

# Loop version 1
for (bor in nyc){
  print(bor)
}

# Loop version 2
for (i in 1: length(nyc)){
  print(nyc[[i]])
}

# loop over a matrix 
m = c('x', 'na','0', '0', 'x', 'na', 'o', 'na', 'x', 'x', 'na', '0')
t = matrix(m, nrow = 3)
t

# define the double for loop
for (i in 1:nrow(t)) {
  for (j in 1:ncol(t)) {
    print(paste("On row ",i," and column ", j, " the board contains ", t[i, j]))
  }
}

ncol(t) # 4
nrow(t) # 3

# mixed for and if else

my_num <- c(16, 9, 13, 5, 2, 17, 14)

# for loop with conditionals
for (i in my_num) {
  if (i > 9) {
    print(i)
    print("Large number with double digit!")
    
  } else {
    print("single digit!")
    
  }
  print(i)
}

# break: statement abandons the activeloop 
# next: skips the remainder of the code in the loop, but continues to the next iteration 


# The linkedin vector has already been defined for you
linkedin <- c(16, 9, 13, 5, 2, 17, 14)

# Adapt/extend the for loop
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  }
  
  if (li > 16) {
    print("This is ridiculous, I'm outta here!")
    break
  }
  
  if (li < 5) {
    print("This is too embarrassing!")
    next 
  }
  
  print(li)
}


#================strsplit(x, split = ")==================================

# Pre-defined variables
rquote <- "r's internals are irrefutably intriguing"

chars <- strsplit(rquote, split = "")[[1]] # charactre  

chars_all <- strsplit(rquote, split = "") # list 
chars_all
chars

chars == chars_all # all FALSE! Why? how? 
mode(chars) # charactr 
mode(chars_all) # list 
length(chars_all) # 1
length(chars) # 40 

for (ch in chars_all){
  print(ch)
}  # gives a single line 

for (chr in chars){
  print(chr)
} # gives several lines with single character 


# counts the number of r's that come before the first u in rquote?

counts = 0
for (ch in chars){
  if (ch == 'r'){
    counts = counts + 1
    print(counts)
  }
  if (ch == 'u'){
    break 
  }
}
print(counts)

# ================number of letters before u===============
count = 0

for (ch in chars){
  
  if (ch != 'u'){
    count = count + 1 
    print(count)
  }else{
    break 
  }
}
print(count)

length(chars)

# ==============================function =================================================

# ====== args(median): gives arguments of function 

# function arguments by position or by name, can have default values 
# required and optional arguments of a function 

# base, ggvis,  list(), mean(), sample(), abs()

args(median)
median
args(sample) # function (x, size, replace = FALSE, prob = NULL)


n <- c(16, 9, 13, 5, 2, 17, 14)
na <- c(16, 9, 13, 5, 2, 17, 14, NA)
mean(na) # NA
mean(na, na.rm = TRUE, trim = .2) # 11.4
mean(n) # 10.857

# install.packages("ggvis")
library(ggvis)
ggvis(mtcars, ~wt, ~hp) # scatter plot 

?search() # list of attached packages 

# require(), library(): load packages 

l_res = library(data.table)
l_res # Error 

res = require(data.table)
res # gives TRUE or FALSE
# data.table

# =============== function scoping=====================================================

pow_two <- function(arg1){
  return(arg1^2)
}


# Use the function
pow_two(12)

sum_abs <- function(n_1, n_2){
  return(abs(n_1) + abs(n_2))
}

sum_abs(-4, -12)

# Define function hello()
no_arg <- function(){
  print("Hi there!")
  return(FALSE)
}
# Call the function ()
no_arg()


pow_two <- function(x, print_info = TRUE) {
  y <- x ^ 2
  if (print_info == TRUE){
    print(paste(x, "to the power two equals", y))
  }
  return(y)
}
a = 12
pow_two(a, FALSE)
pow_two(a, TRUE)

# R passes argument by value: a remains 12, only  pow-two 144

# function with control flow 
interpret <- function(num_views){
  if (num_views > 15){
    print("You're popular!")
    return(num_views)
    
  } else {
    print("Try to be more visible!")
    return(0)
  }
}


ln <- c(16, 99, 13, 5, 2, 17, 14)
fb <- c(17, 7, 5, 16, 8, 13, 14)


# Call the interpret function twice
interpret(ln[1])
interpret(fb[2])



# The interpret() can be used inside interpret_all()


# Define the interpret_all() function
# views: vector with data to interpret
# return_sum: return total number of views 

interpret_all <- function(views, return_sum = TRUE) {
  count <- 0
  
  for (v in views) {
    count <- count + interpret(v)
    
  }
  
# If return_sum is TRUE, return count, else return NULL
  if (return_sum) {
    return(count)
    
  } else {
    return(NULL)
    
  }
}

# Call the interpret_all() function on both linkedin and facebook
interpret_all(ln)
interpret_all(fb)

# install.packages("qplot")
# install.packages("ggplot2")

# library(qplot)
library(ggplot2)
qplot(mtcars$wt, mtcars$hp) # 

search()


























