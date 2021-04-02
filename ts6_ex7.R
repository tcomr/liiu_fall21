
# exercise 7.8 : 1-7 
rm(list = ls())

library(fpp2)

# 1. 
str(pigs)
head(pigs)

pig = ses(pigs, h = 4)

autoplot(pig)

pig$upper[1, "95%"]
pig$lower[1, "95%"]

# 
s = sd(pig$residuals)
pig$mean[1] + 1.96*s
pig$mean[1] - 1.96*s

autoplot(pigs) + 
  autolayer(pig$fitted)


# 2. 

my_func = function(y, alpha, level_0){
  y_hat = level_0
  for(i in 1:length(y)){
    y_hat = alpha * y[i] + (1 -alpha) * y_hat
  }

  return(y_hat)
}


# 3. 

sse = function(y, alpha, level_0){
  y_hat = level_0
  for(i in 1:length(y)){
    y_hat = alpha * y[i] + (1 -alpha) * y_hat
  }
  
  return(sum(y_hat - y)**2)
}

# future flash coding exercise on 7.8 




