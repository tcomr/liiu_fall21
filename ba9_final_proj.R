rm(list = ls())
library(Synth)
library(fpp2)
library(dplyr)
library(tidyverse)
library(haven)
library(Synth)
library(devtools)
if(!require(SCtools)) devtools::install_github("bcastanho/SCtools")
library(SCtools)

data("basque")

?basque
?dataprep


just_basque <- basque %>% 
  select(2:4) %>% 
  filter(basque$regionname == "Basque Country (Pais Vasco)")

basque_ts <- ts(just_basque[,3], start = 1955, frequency = 1)
autoplot(basque_ts)

dataprep_mod <- dataprep(
  foo = basque,
  predictors = c("school.illit", "school.prim", "school.med",
                 "school.high", "school.post.high", "invest"),
  predictors.op = "mean",
  special.predictors = list(
    list("gdpcap", 1960:1969 ,"mean"),
    list("sec.agriculture", seq(1961, 1969, 2), "mean"),
    list("sec.energy", seq(1961, 1969, 2), "mean"),
    list("sec.industry", seq(1961, 1969, 2), "mean"),
    list("sec.construction", seq(1961, 1969, 2), "mean"),
    list("sec.services.venta", seq(1961, 1969, 2), "mean"),
    list("sec.services.nonventa", seq(1961, 1969, 2), "mean"),
    list("popdens",               1969,               "mean")),
  time.predictors.prior = 1955:1967,
  dependent = "gdpcap",
  unit.variable = "regionno",
  unit.names.variable = "regionname",
  time.variable = "year",
  treatment.identifier = 17,
  controls.identifier = c(2:16,18),
  time.optimize.ssr = 1955:1968,
  time.plot = 1955:1997
)

synth_out <- synth(data.prep.obj = dataprep_mod)

path.plot(synth_outcome, dataprep_mod, tr.intake = 1968, 
          Ylab = c("GDP(1986 $)"), Main = "Actual vs. Synthetic GDP in Basque")

# gap between synthetic control and treated 
gaps.plot(synth_outcome, dataprep_mod, tr.intake = 1968, 
          Ylab = c("GDP(1986 $)"), title)


# Talk about p-value, significant, statistical significance
# placebo effect, etc.. 

# did we get the result(plot) right?
# placebo test

# placebo test: fake the test for other states 

placebo = generate.placebos(dataprep_mod, synth_out,
                            Sigf.ipop = 3 )

plot_placebos(placebo)

plot_placebos(placebo, ylab = "gap in GDP per Capita", )


mspe.plot(placebo, discard.extreme = TRUE, mspe.limit = 1, plot.hist = TRUE)

# No other state show the effect as TX shows on graph 

# get weights of state individually 
# not in the book, but in R documentation 
mytable = synth.tab(
  dataprep.res = dataprep_mod,
  synth.res = synth_out)
print(mytable) # weight calculated for each state 
# a lot of state dropped out with 0.00
# Louisiana got .36 which is important, so is CA 


placebo$df # gives real data and TX 

# Final project on synthetic control  

# ML 710: no final Project: homework, Datacamp course 


