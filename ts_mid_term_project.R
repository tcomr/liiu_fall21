
# Time series mid-term project 

# time series forecasting 

getwd()
library(tidyverse)
library(readxl)
library(lubridate)
df = read_excel("C:/Users/sts/Downloads/online_retail_II.xlsx")

str(df) # tibble [525,461 x 8]

# Create new colum of total sales of the each items
my_df = df %>% mutate(total_price = Quantity * Price) %>% 
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

# remove last 9 rows from daily_df2
daily_df2 = head(daily_df2, -9)


# Now group by week 




  