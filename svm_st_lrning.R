

#  Support vector machine 
# An Introduction to Statistical learnng Ed. 2
  # chapter 9.6 page 359

library(e1071)

set.seed(1)
x = matrix(rnorm(20*2), ncol  = 2)
y = c(rep(-1,10), rep(1,10))
x[y==1,] = x[y==1,] + 1
plot(x, col = (3-y))

# svm
dat = data.frame(x = x, y =as.factor(y))
svmfit = svm(y~., data = dat, kernel = 'linear', cost = 10, scale = FALSE)
plot(svmfit, dat)

# index
svmfit$index

summary(svmfit)

# change cost 
svmfit = svm(y~., data = dat, kernel = 'linear', cost = 0.1, scale = FALSE)
plot(svmfit, dat)

# index
svmfit$index

















