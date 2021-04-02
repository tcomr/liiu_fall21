

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


summary(fc)






















