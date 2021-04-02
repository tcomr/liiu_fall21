

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
# allows for the trends
# extends exponential modal but adds trend to ti 
















