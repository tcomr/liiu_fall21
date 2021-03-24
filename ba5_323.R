
# March 23
# Today:
  # Book: Business Data Science by Matt Taddy
    # chapter 8: text as Data 

# what is Big data? 
  # number of observation < number fo features
  # fat data: small rows(100 obs.) and a lot variables (1million feature)

# whenever you cannot save data in computer memory (RAM), 
  # that is big data - computer engineering 

# length of dataset - traditional def 
# rate at which we recieve data (eg. netflix) is big data - traditioanl def



# coding =======================================

# data gasoline.csv from bds 
rm(list = ls())
getwd()
 # data source:
  # https://github.com/TaddyLab/BDS/blob/master/examples/gasoline.csv
gas = read.csv("C:/Users/sts/Downloads/gasoline.csv")
str(gas) # 'data.frame':	60 obs. of  402 variables

# dependent variable in col 1 ; octane
octane = gas[, 1]

nir = as.matrix(gas[, -1]) # removed the octane variable 
# converting to matrix for it takes less memory space 
  # and we need the matrix form for later usagee 

phi = cor(nir, octane)/apply(nir, 2, sd)
# 2 because we want to use in all columns, if row use 1 

v = nir %*% phi # matrix multiplication 

# run final regression
fwd = glm(octane ~ v)
summary(fwd)

# further code in github link 
  # office hours 4-5pm 


# next class probably flash coding , be prepared 



getwd()














