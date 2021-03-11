
# 
rm(list = ls())
library(fpp2)


beer2 = window(ausbeer, start = 1992, end = c(2007, 4))

# View(beer2)
autoplot(beer2) + 
  autolayer(meanf(beer2, h = 11), 
            series = "Mean", PI = FALSE) +
  autolayer(naive(beer2, h = 11), 
            series = 'Naive', PI = FALSE) +
  autolayer(snaive(beer2, h = 11), 
            series = 'Seasonal naive', PI = FALSE) +
  autolayer(rwf(beer2, drift = TRUE, h = 11), 
            series = 'Drift', PI = FALSE) + 
  ggtitle("Forecats") + 
  xlab("Year") + ylab("Beer in liters") +
  guides(colour = guide_legend(title = 'Simple Methods'))

  # rwf: random walk = no pattern, 
# looks like: Seasonal naive performs better because the data has 
  # a very strong seasonality 


###====homework ====
# create a table or df with forcasted values for differet methods 
# naive | seasonal naive | Drift | 
# 11 values for each of the methods 
#====================================================

# break 5 min: RNN next 




































