
# ex. 2.10  1-6 ; 30 min 
library(fpp2)

#1.

help("gold")
help("woolyrnq")

autoplot(gold)
autoplot(woolyrnq)

str(gold)
frequency(gold)#4
frequency(woolyrnq)
frequency(gas)

# 2. 
tute1 <- readr::read_csv("C:/Users/sts/Downloads/tute1.csv")


library(dplyr)

mytimeseries <- ts(tute1[,-1], start=1981, frequency=4)

autoplot(mytimeseries, facets=TRUE)

autoplot(mytimeseries, facets=FALSE)
ggAcf(mytimeseries)

# 3. 
retaildata <- readxl::read_excel("C:/Users/sts/Downloads/retail.xlsx", skip=1)


myts <- ts(retaildata[,"A3349396W"],
           frequency=12, start=c(1982,4))

# summary(retaildata)

autoplot(myts)
ggseasonplot(myts)

?ggsubseriesplot

ggsubseriesplot(myts)
gglagplot(myts)
ggAcf(myts)

# 4. 
help(bicoal)
help("chicken")
help("dole")
help("usdeaths")
help("lynx")
help("goog")
help(writing)
help(fancy)
help(a10)
help(h02)

str(goog)
# View(goog)
autoplot(goog) +
  xlab("stock price: 2/2013 - 2/2017") +
  ylab("Stock Price") +
  ggtitle("Closing stock price of Google")
ggAcf(goog)

# 5. 

ggseasonplot(writing)
ggsubseriesplot(writing)


ggseasonplot(fancy)
ggsubseriesplot(fancy)


ggseasonplot(a10)
ggsubseriesplot(a10)


ggseasonplot(h02)
ggsubseriesplot(ho2)


# 6. 

autoplot(hsales)
ggseasonplot(hsales)
ggsubseriesplot(hsales)
gglagplot(hsales)
ggAcf(hsales)


autoplot(usdeaths)
ggseasonplot(usdeaths)
ggsubseriesplot(usdeaths)
gglagplot(usdeaths)
ggAcf(usdeaths)

autoplot(bricksq)
ggseasonplot(bricksq)
ggsubseriesplot(bricksq)
gglagplot(bricksq)
ggAcf(bricksq)

autoplot(sunspotarea)
ggseasonplot(sunspotarea)
ggsubseriesplot(sunspotarea)
gglagplot(sunspotarea)
ggAcf(sunspotarea)

autoplot(gasoline)
ggseasonplot(gasoline)
ggsubseriesplot(gasoline)
gglagplot(gasoline)
ggAcf(gasoline)











