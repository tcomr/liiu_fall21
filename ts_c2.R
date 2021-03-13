
rm(list = ls())
# install package
#install.packages('fpp2')
# installs packages for 
library(fpp2)
    # package for book: forecasting principles and practice 2nd ed. 

help(fpp)
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

# autoplot is ploting function,
# I want only economy class

# before doing ML, we need toplot the data 

# [strognly reccomed: buy book ]

# ============================================
# ==============Class II feb 11==================

# Takeaways from the line graph 

# interpretation from the visualization 
# If it is one time thing(spike down), the model should be able to predict that. 

# pattern of downward spike in the end of each year 

# ======================
data(a10)
str(a10)

autoplot(a10)+ 
  ggtitle("Just plot")+
  xlab("year")+
  ylab("sales")
# positive trend upward, and 
# seasonality: sudden drop at the start of each year, we see a drop 

# cyclical pattern is different from seasonal pattern 



autoplot(hsales)+
  ggtitle("Sales of new one-family houses, ") +
  xlab("Year") +
  ylab("thtal sales")
# no trend, 
# yes, seasonality
# yes, cyclic pattern 

# ==========================================


autoplot(ustreas)
autoplot(window(elec, start=1980))
  # window creates a subset of data 
?window



ggseasonplot(a10, year.labels = TRUE, year.labels.left = TRUE) +
  ylab("Million dollar") +
  xlab("Month") +
  ggtitle("Seanonality Check")

# 2008: no seasonal pattern, everywhere else seasonality pattern 

ggseasonplot(a10, polar = T) +
  ylab("Million dollar") +
  xlab("Month") +
  ggtitle("Seanonality Check")


# if constant circle: sell is constant; 
# squeeze in Feb every year except 2008 
# Picture is so helpful to stockholders 



# Now little bit technical: 
# Autocorrolation and more 
# Scatterplot helps to visualize 


# =================================
# two time series electricity demand and temperature

str(elecdemand)

autoplot(elecdemand[, c("Demand", "Temperature")]) +
  xlab("Year: 2014 - 2015") +
  ggtitle("Scatterplot")
  
# above doesn't look good, so change sth 
autoplot(elecdemand[, c("Demand", "Temperature")], facets = TRUE) +
  xlab("Year: 2014 - 2015") +
  ylab(" ")+
  ggtitle("Scatterplot")


#OR
data = data.frame(elecdemand)
dta = data[1:5, ]
str(dta)

autoplot(dta[, c("Demand", "Temperature")])
# Error: ? 

rm(data)
rm(dta)

# ===================qplot

qplot(data = elecdemand, "Temperature", "Demand")

?qplot 
# data should be a dataframe, but our data is Time-series, so create a dataframe
qplot(data = data.frame(elecdemand), Temperature, Demand)

# demand for electricity is contingent upon the temperature
# the relationship is non linear
# for up to 20 negative relation, for 20 and up positive correlation 


#===================== autocorrelation ====


ggAcf(beer)

?ggAcf




















