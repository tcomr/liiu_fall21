
rm(list = ls())

library(readr)

wdbc = read.csv("C:/Users/sts/Downloads/wdbc.data.csv", 
                stringsAsFactors = FALSE, header = TRUE)
attributes = c("read",
               "text",
               "peri",
               "area",
               "smoth",
               "compact",
               "concav",
               "points",
               "symm",
               "dim")

metric = c("m", "s", "w") # mean, sd: surface area, width 
# 10 attributes with 3 metrics gives 30 variables 


colnames(wdbc) = c("ID", "diag", paste0(rep(attributes, 3),
                                        "_", rep(metric, each = 10)))

# paste : concatenates 
paste0("I am", "_", "fine")

# target variable: diagnostic 
wdbc$diag = factor(wdbc$diag, 
                   levels = c("B", "M"), labels = c("Benign", "Malignant"))
# typeof(wdbc$diag)

# pre-processing, feature processing, data processing
# to know how data looks like based on features (attributes)

summary(wdbc[c("text_m", "area_m", "peri_m")])

  # float/float distance function: gives wrong classification

sqrt(4+4+6)
sqrt(4+1000+6) # 1000 is playing more role/contributing more than 6

# we need to put everything on same scale 
# one feature having more is bias 
# so use normalization 
library(dplyr)

# take off the ID column
wdbc = select(wdbc, -c(ID))

wdbc_norm = select(wdbc, c(2:31) )

# normalization function 
normal = function(a){
  return((a-min(a))/(max(a)-min(a)))
  
}

# normal(143.5) # error, may be we need a vector 

normal(wdbc[,2])

# need to normalize all the columns:
  # lapply
wdbc_norm = data.frame(lapply(wdbc_norm, normal))
  # lapply normal function to wbdc_norm df 

summary(wdbc[c("text_m", "area_m", "peri_m")])
    # range of original data 

summary(wdbc_norm[c("text_m", "area_m", "peri_m")])
    # range of 0 - 1 
# 1: 48min for train/test on productin env. 
dim(wdbc)
wdbc_train = slice(wdbc_norm, 1:426)
wdbc_test = slice(wdbc_norm, 427:569)

wdbc_tr_cat = wdbc[1:426, 1]
wdbc_te_cat = wdbc[427:569, 1]
# check
prop.table(table(wdbc_tr_cat))
prop.table(table(wdbc_te_cat))

# phase 2: Implementing KNN algo
# install.pckages("class") # for knn 
library(class)
sqrt(569) # 23 for k value 
pred = knn(train = wdbc_train, 
           test = wdbc_test, cl = wdbc_tr_cat, k = 23)
dim(wdbc_tr_cat)

# phase 3: performance 
# install.packages("gmodels")
library(gmodels)
CrossTable(wdbc_te_cat, y = pred, prop.chisq = FALSE)

# HW: practice coding 
    # prepare for the homework and flash coding 





                