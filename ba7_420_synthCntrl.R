# April 20
# Final project on this algorithm 

# Synthetic control 
rm(list = ls())

# Synth package, also can be used in python 

library(tidyverse)
library(haven)
# install.packages("Synth")
library(Synth)
library(devtools) # for placebo effect?? 
install_github("bcastanho/SCtools")

if(!require(SCtools)) devtools::install_github("bcastanho/SCtools")
  # if sc tools not required, install 
library(SCtools)

read_data <- function(df)
{
  full_path <- paste("https://raw.github.com/scunning1975/mixtape/master/", 
                     df, sep = "")
  df <- read_dta(full_path)
  return(df)
}
# texas is treatment state 
texas <- read_data("texas.dta") %>% as.data.frame(.)

# need to tell pre-treatmnet periods 
# 
dataprep_out <- dataprep(
  foo = texas,
  predictors = c("poverty", "income"),
  predictors.op = "mean",
  time.predictors.prior = 1985:1993,
  special.predictors = list(
    list("bmprison", c(1988, 1990:1992), "mean"),
    list("alcohol", 1990, "mean"),
    list("aidscapita", 1990:1991, "mean"),
    list("black", 1990:1992, "mean"),
    list("perc1519", 1990, "mean")),
  dependent = "bmprison",
  unit.variable = "statefip",
  unit.names.variable = "state",
  time.variable = "year",
  treatment.identifier = 48,
  controls.identifier = c(1,2,4:6,8:13,15:42,44:47,49:51,53:56),
  time.optimize.ssr = 1985:1993,
  time.plot = 1985:2000
)
# foo name of data set
# predictors: synthetic control is created in pre-treatment period
# need to provide predicotor variables to create weights 
# minimize the pred. variable 
# Cherry picking special dates for some predictors 



# 1 in subscript is texas,
# m = {poverty, income ....}

# X_1m: proverty rate in texas 

synth_out = synth(dataprep_out)

path.plot(synth_out, dataprep_out,
          tr.intake = 1993)

# gap between synthetic control and treated 
gaps.plot(synth_out, dataprep_out, tr.intake = 1993)

# Talk about p-value, significant, statistical significance
  # placebo effect, etc.. 

# did we get the result(plot) right?
# placebo test? 

# placebo test: fake the test for other staets 

placebo = generate.placebos(dataprep_out, synth_out,
                             Sigf.ipop = 3 )

# placebos = generate.placebos(dataprep_out, synth_out, Sigf.ipop = 3)

plot_placebos(placebo)

mspe.plot(placebos, discard.extreme = TRUE, mspe.limit = 1, plot.hist = TRUE)

# No other state show the effect as TX shows on graph 

# get weights individually 
mytable = synth.tab(
  dataprep.res = dataprep_out,
  synth.res = synth.out)
print(mytable) # weight calcuated for each state 
# a lot of state dropped out with 0.00
# Lusiana got .36 which is imporant 

  
Placebos.df # gives real data and TX 

# Final project idea: 
# we might want to do something like this diff-n-diff and 
  # synthetic control

