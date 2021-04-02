

getwd()

rm(list = ls())

library(fpp2)

oildata = window(oil, start = 1996)

fc = ses(oildata, h = 5)

autoplot(fc) + 
  ylab("Oil(million tonnes") + 
  xlab("Year")
# blue line: point forecast
# dark shared area: 80% prediction interval 
  # 80% probability that the area will include the prediction 

# smaller range: less certain, more uncertain 
# wider range: high certain, less uncertain 
# The range gets wider as we move along the time 

# The closer the forecasting horizon is, the better teh forecasting is 

# use ses when:
  # no clear trend and seasonality 

summary(fc)

fc$lower
# lower range of prediction interval 
# prediction interval also tells confidence interval 

fc$upper
# 

# how to get the proint predictoin from ses model 
fc$mean # easiest to get mean forecast 

pred = predict(fc)
# pred[, 'Forecast'] # error 

mode(pred)
typeof(pred)
p_df = data.frame(pred)  
str(p_df)
p_df[, "Point.Forecast"] # gives point forecast /prediction value


# =========================Holt's Linear Trend Method ============================
# allows for the trends in exponential 
# extends exponential modal but adds trend to ti 

# Main chalange for project: 
  #  convert data to time series object 


air = window(ausair, start = 1990)
fc = ses(air, h = 5)

fc_h = holt(air, h = 5)

autoplot(fc_h)
# strong 
# you have to plateau after some time, how we catch that?
# it i snot here, 
# can you catch the plaetau as well, in addition to trend and seasonality?
# yes, damped = TRUE arguement 


# convert data into time series, then apply holt 
# noise level of data is very hard to catch, not only 
# having a trend or no trend, however haing a trend is a factor 



fc_hd = holt(air, damped = TRUE, phi = 0.9, h = 15)
autoplot(fc_hd)

# on project:
  # add different layes together 

autoplot(air) + 
  autolayer(fc, series = "Simple Exponential Smoothing", PI = FALSE) + 
  autolayer(fc_h, series = "Holt's Method", PI = FALSE) + 
  autolayer(fc_hd, series = "Dampled holt's Method", PI = FALSE) + 
  xlab("Year")

# eventhoug, the visualization is appealing, use accuracy to choose best model 
# look at forecasting accuraciy by dividing data into train/test

# exponenential smooting don't catch trend, use holt's damped = TRUE



aust = window(austourists, start = 2005)
autoplot(aust)
# if constant seasonality, use additive/multiplicative 
# if variation in sesonal patternn is constant, 
# additive/multiplicative 

fit1 = hw(aust, seasonal = "additive")
fit2 = hw(aust, seasonal = "multiplicative")

autoplot(aust) + 
  autolayer(fit1, series = "Additive", PI = FALSE) + 
  autolayer(fit2, series = "Multiplicative", PI = FALSE) + 
  xlab("Year")

# Provide stockholders:
# give forecasts and upper/lower ranges 
# if it is too wide; this is best we got 

mean(fit1$upper)
mean(fit2$upper)

# don't work with daily data:
# the more noise you have on data, the worse the forecast is 
# if possible collapse at least weekly data (collapse to lower frequency)







