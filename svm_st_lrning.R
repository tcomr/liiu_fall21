

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


# tune for ten-fold (default) cross validation 


tune.out = tune(svm, y~., data = dat, kernel = 'linear',
                ranges = list(cost = c(0.001, 0.01, 0.1, 1, 5, 10, 100)))



summary(tune.out)
# Parameter tuning of 'svm':
#   
#   - sampling method: 10-fold cross validation 
# 
# - best parameters:
#   cost
# 5
# 
# - best performance: 0.1 
# 
# - Detailed performance results:
#   cost error dispersion
# 1 1e-03  0.65  0.4743416
# 2 1e-02  0.65  0.4743416
# 3 1e-01  0.15  0.3374743
# 4 1e+00  0.15  0.2415229
# 5 5e+00  0.10  0.2108185
# 6 1e+01  0.10  0.2108185
# 7 1e+02  0.15  0.2415229

# best.model 

bestmod = tune.out$best.model
summary(bestmod)

# create a test data 
xtest = matrix(rnorm(20*2), ncol = 2)
ytest = sample(c(-1, 1), 20, rep = TRUE)
ytest

xtest[ytest == 1, ] = xtest[ytest ==1, ] + 1 
testdat = data.frame(x = xtest, y = as.factor(ytest))

# predict
ypred = predict(bestmod, testdat)
ypred
summary(ypred)

table(predict = ypred, truth = testdat$y)
