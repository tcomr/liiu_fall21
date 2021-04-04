
# Time series mid-term project 

# time series forecasting 
rm(list = ls())
getwd()
library(fpp2)
library(tidyverse)
library(readxl)
library(lubridate)
df1 = read_excel("C:/Users/sts/Downloads/online_retail_II.xlsx")

str(df1) # tibble [525,461 x 8]

# Create new colum of total sales of the each items
my_df = df1 %>% mutate(total_price = Quantity * Price) %>% 
  select(InvoiceDate, total_price)
  
# group by day and calculate daily sales 
daily_df = my_df %>% mutate(date = date(InvoiceDate)) %>%
  group_by(date) %>% 
  summarize(Daily_sales = sum(total_price))

# read sheet_2 for 2010 - 2011 data 
df2 = read_excel("C:/Users/sts/Downloads/online_retail_II.xlsx", 
                sheet = 'sheet_2')

str(df2) # 541,910 x 8

# Create new colum of total sales of the each items
my_df2 = df2 %>% mutate(total_price = Quantity * Price) %>% 
  select(InvoiceDate, total_price)

# group by day and calculate daily sales 
daily_df2 = my_df2 %>% mutate(date = date(InvoiceDate)) %>%
  group_by(date) %>% 
  summarize(Daily_sales = sum(total_price))

# 2010-12-1 to 2010-12-9 on both dataframes, df1 and df2
# remove the duplicate values before joining the two data sets 

# remove last 9 rows from daily_df2 to remove duplicate dates 
unique_df2 = head(daily_df2, -9)
str(unique_df2)
str(daily_df)
# ================================================



# Now combine two datasets to 
combined_df = rbind(daily_df, unique_df2)

str(combined_df)

summary(combined_df)

# ==========================weekly trend=========================================

# This is sum of weekly total 
df1_weekly = daily_df %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = sum(Daily_sales)) %>% 
  select(week, weekly_sales)

df2_weekly = unique_df2 %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = sum(Daily_sales)) %>% 
  select(week, weekly_sales)


# Now combine two datasets to 
combined_df = rbind(df1_weekly, df2_weekly)
autoplot(naive(combined_df, h = 11), 
         series = 'Naive', PI = FALSE)

# what if average of weekly total 
avg_weekly = daily_df %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = mean(Daily_sales)) %>% 
  select(week, weekly_sales)

autoplot(naive(avg_weekly, h = 11), 
         series = 'Naive', PI = FALSE)




# weekly total time series 
ts
ts_df = ts(df_weekly$weekly_sales, start = c(2009, 12), end = c(2011, 11),
           frequency = 52)
ts_df
str(ts_df)

# weekly average time sereis 
  ts_df = ts(avg_weekly$weekly_sales, start = c(2009, 12),
             frequency = 12)
ts_df
str(ts_df)

autoplot(snaive(ts_df, h = 14), 
         series = 'Naive', PI = FALSE)




# ==========================weekly trend end=========================================

# ==========================monthly trend=========================================


# This is sum of monthly total 
df1_month = daily_df %>% group_by(month = month(date)) %>% 
  summarize(monthly_sales = sum(Daily_sales)) %>% 
  select(month, monthly_sales)

df2_month = unique_df2 %>% group_by(month = month(date)) %>% 
  summarize(monthly_sales = sum(Daily_sales)) %>% 
  select(month, monthly_sales)

autoplot(naive(df2_month, h = 11), 
         series = 'Naive', PI = FALSE)
# combine monthly dataframes 
combined_monthly = rbind(df1_month, df2_month)


# Monthly total time series 
ts
ts_df = ts(combined_monthly$monthly_sales, start = c(2009, 12), end = c(2011, 11),
           frequency = 12)
ts_df
str(ts_df)

autoplot(snaive(ts_df, h = 8), 
         series = 'Naive', PI = FALSE)



# what if average of monthly total 
avg_df1_month = daily_df %>% group_by(month = month(date)) %>% 
  summarize(monthly_sales = mean(Daily_sales)) %>% 
  select(month, monthly_sales)

avg_df2_month = unique_df2 %>% group_by(month = month(date)) %>% 
  summarize(monthly_sales = mean(Daily_sales)) %>% 
  select(month, monthly_sales)

combined_monthly = rbind(avg_df1_month, avg_df2_month)

# monthly average time sereis 
ts_df = ts(combined_monthly$monthly_sales, start = c(2009, 12), end = c(2011, 11),
           frequency = 12)
ts_df
str(ts_df)

autoplot(snaive(ts_df, h = 14), 
         series = 'Naive', PI = FALSE)










# ==========================weekly trend end =========================================


# Now group by week 

plot(daily_df)
plot(daily_df2)

autoplot(naive(daily_df, h = 11), 
          series = 'Naive', PI = FALSE)



# Calculate weekly total sales 

# This is sum of weekly total 
df_weekly = daily_df %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = sum(Daily_sales)) %>% 
  select(week, weekly_sales)

autoplot(naive(df_weekly, h = 11), 
         series = 'Naive', PI = FALSE)

# what if average of weekly total 
avg_weekly = daily_df %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = mean(Daily_sales)) %>% 
  select(week, weekly_sales)

autoplot(naive(avg_weekly, h = 11), 
         series = 'Naive', PI = FALSE)

# for 2010-2011 data 

# This is sum of weekly total 
df2_weekly = daily_df2 %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = sum(Daily_sales)) %>% 
  select(week, weekly_sales)

autoplot(naive(df2_weekly, h = 11), 
         series = 'Naive', PI = FALSE)

# what if average of weekly total 
avg2_weekly = daily_df2 %>% group_by(week = week(date)) %>% 
  summarize(weekly_sales = mean(Daily_sales)) %>% 
  select(week, weekly_sales)

autoplot(naive(avg2_weekly, h = 11), 
         series = 'Naive', PI = FALSE)


# ??? convert dataframe into time series 
library(xts)


# ts_dt = xts(avg_weekly, order.by = week)

str(avg_weekly)

# daily_df 
ts_dt = xts(daily_df, order.by = daily_df$date)

str(daily_df)
str(ts_dt)







  