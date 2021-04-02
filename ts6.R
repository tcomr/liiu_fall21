

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