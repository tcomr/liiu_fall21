
# flash code ML 610

# Visualization 

rm(list = ls())


library(arules)
library(arulesViz)

patterns <- random.patterns(nItems = 20)

summary(patterns)

df = random.transactions(nItems = 20, nTrans = 10000,
                                method = 'agrawal', patterns = patterns)


summary(df)

# Question/answers 


# 10000 transactions
# 20 Unique items

total_cells  = 10000 * 20
density = 0.448075
total_items = total_cells * density
total_items
# total items purchased = 89615
# Average items : 8.96
# 75% : 11 

inspect(df[1:5])


str(df)
typeof(df)

# itemFrequency
itemFrequency(df[, 1:15]) # gives support 
# number of times iteam appears / toal transactions 

# visualize

itemFrequencyPlot(df, topN = 15)


# algorithm 

rule_default = apriori(df)
summary(rule_default)

myrules = apriori(df, parameter = list(sup = 0.2, conf = .8, minlen = 2))



summary(myrules)

plot(myrules)


inspect(head(myrules))

# subset of rules with conf. 
subRules<-myrules[quality(myrules)$confidence>0.8]

plot(subRules)
plot(subRules,method="two-key plot")



# myrules_df = as(df, 'data.frame')


top10subRules <- head(subRules, n = 10, by = "confidence")

plot(top10subRules, method = "graph",  engine = "htmlwidget")

# Filter top 20 rules with highest lift
subRules2<-head(subRules, n=20, by="lift")
plot(subRules2, method="paracoord")














































