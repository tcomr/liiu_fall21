

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









