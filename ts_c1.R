# install package
#install.packages('fpp2')
# installs packages for 
library(fpp2)

# For our project, we need our own package
data("melsyd") 
# air traffic numbers 

help("melsyd")
str(melsyd)
head(melsyd)
#install.packages('forecast')

library(forecast)
autoplot(melsyd[, "Economy.Class"])+ 
  ggtitle("Economy Class")+
  xlab("Year")+
  ylab("Thousands")
  
# Visual: Downward spike in late 1989 

# autopilot is plotting function,
  # I want only economy class

# before doing ML, we need to plot the data 

# [strongly recommend: buy e-book]

# ============================================
# ==============Class II feb 11==================





