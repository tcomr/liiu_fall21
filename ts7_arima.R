
library(fpp2)

autoplot(diff(goog200, 1))

autoplot(goog200)

Box.test(diff(goog200, type = 'L jung-Box'))

# Null Hypo: Google data is not stationarity 
  #  44 min: 
  # random / white noise: each values are not correlated

# p-value = 0.39, cannot reject the hypothesis 

# 
ggAcf(goog200)
# strong correlation, no stationarity
ggAcf(diff(goog200))
# white noise, now it is stationary 

autoplot(a10)

autoplot(log(a10))

autoplot(diff(log(a10), 12))
# 12 differencing last jan to this jan 
# variance constant 


autoplot(usmelec)
autoplot(log(usmelec)) # nothing much

# lets put diff
autoplot(diff(log(usmelec), 12)) # looks beter

# ry again 
autoplot(diff(diff(log(usmelec), 12))) # much beter

# unit root test, to check if difference is needed or not
  # KPSH test to see if we need differing or not
  # need to use the library URCA 
# installed.packages("urca")

library(urca)
summary(ur.kpss(goog))
  # data is not stationary in this case
  # null hypothesis is not rejected for p value = 10.72
  # H0: data is not stationarity 

summary(ur.kpss(diff(goog)))
  # p-value: 0.0324



# how many differences need I take?

ndiffs(goog)
# gives 1: so only 1 difference is good to make data stationary 

#=======================Next section ===========
# =========arima ========== mooving average 

autoplot(uschange[, "Consumption"]) +
  xlab("Year") + ylab("Quarterly percentage change")

fit = auto.arima(uschange[, "Consumption"], seasonal = FALSE)
fit %>% 

ggPacf(uschange[, "Consumption"])
         

