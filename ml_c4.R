
# association rule: arules 
  # in 720 new topic: def and def in last class
  # today partial least method: PCR 
    # built on PCA 
# last class:
  # support, 
# confidence 
    # measure of how often the rule happens to be true 
# NDA agreement, 

rm(list = ls())

library(arules)


# groceries = read.csv("C:/Users/sts/Downloads/groceries.csv")
# str(groceries)
# if imported with read.csv
  # this is wrong, it is faulty, not correct 
  # That's whay we have to use read.transactions
# data source:
  #  https://github.com/PacktPublishing/Machine-Learning-with-R-Third-Edition/blob/master/Chapter08/groceries.csv


groceries = read.transactions("C:/Users/sts/Downloads/groceries.csv",
                              sep = ',')
  # Be careful of sep arguement, default value might not work

  
# each row is a gransactins, with differnt length 
# s4 is like list that sits on 
summary(groceries)
# summary works, but a lot of other functions don't work 
  # we have sparce matrices, and 2.6% have value of 1.
      # are non zero items 
total_cells  = 9835 * 169 
density = 0.02609146
total_one_s = total_cells * density
total_one_s
# 2159 items appeared 1 time 
# density: if 0.00005, too low, it might be problem
  # else, we don't care 

inspect(groceries[1:5])


str(groceries)
typeof(groceries)
# S3 and s4 

# itemFrequency
itemFrequency(groceries[, 1:15]) # gives support 
# number of times iteam appears / toal transactions 

# visualize
itemFrequencyPlot(groceries, support = 0.1)

itemFrequencyPlot(groceries, topN = 20)

image(sample(groceries, 100))
# we want vertical line with many dots
# solid vertical lines meaning item appeared in 
# many transactions; very popular item
# frequently baught item: good money 
# find high association between items






