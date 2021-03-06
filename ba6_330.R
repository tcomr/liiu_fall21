# Partial least square 

rm(list = ls())

install.packages("textir")
  # it has built congress dataset 
  # what they said, and how they voted in 2004

library(textir)

data(congress109)

# count dataset: partial least square 
  # process the data in dtm 
  # everyword in a column 

# congress109ideology dataset: 529 

congress109Counts[c("Chris Cannon", "Michael Conaway"), 1:5]

congress109Counts[c("Chris Cannon", "Michael Conaway"), 935:940]


# we will PLS; we relate with repshare variaable
# can we predict the political affiliation to predict party
# create a slant index to predict party afffiliation 

# Create an index to find this person to that purchase 

# data provided by Matt Tady 

str(congress109Counts)

# can you predict his/her party affiliation 
  # from what he/she said 
# Average political ideology from their speech 

# create variable 
f = congress109Counts
y = congress109Ideology$repshare

# Partial Least Square / boosting 
  # mattady github repo


slant = pls(f, y, K = 3)
# k is how many iteration 
  # there is ML wasy of figuring out k 

summary(slant)

slant$loadings
# gives different coefficients of a word
  # three different coeffs. 
slant$directions

#
for (k in 1:3){
  plot(slant$y, slant$fitted[,k], ylim = c(-0.05, .85), 
       ylab = "", xlab = "", main = sprintf("PLS(%d)", k),
       pch = 20, col = c(4,3,2)[congress109Ideology$party], bty = "n")
}

mtext(side = 1, 'repshare', outer = TRUE,line = -1.25 )
mtext(side = 2, 'repshare', outer = TRUE,line = -1.25 )

# another example gasoline data to create an index 

# HW on blackboard, 
# project announced next week
  # may be data and questions gives 


