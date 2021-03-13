

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
















