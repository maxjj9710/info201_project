# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Exploratory Analysis 

# Setup ------------------------------------------------------------------------

# website ive been using for ggplot
#https://datacarpentry.org/R-ecology-lesson/04-visualization-ggplot2.html

# Load the necessary packages. 
library(dplyr)
library(ggplot2)
library(stringr)
library(tidyverse)
library(lubridate)

# read data filemo
# Note: file is too large to be included in github. Download from
# https://www.kaggle.com/sogun3/uspollution?select=pollution_us_2000_2016.csv
aqi_data <- read.csv("pollution_us_2000_2016.csv", header = TRUE)

month <- as.Date(aqi_data$Date.Local)
months(month)

# organize the data
wa_only <- aqi_data %>%
  filter(State == "Washington") %>%
  filter(Date.Local >= "2015-01-01", Date.Local <= "2016-01-01") %>%
  # tried to group it by month but not really working
  # mutate(Month = months(as.POSIXlt(aqi_data$Date.Local, format ="%d-%m-%y"))) %>%
  group_by(Date.Local) %>%
  select(County, Date.Local, NO2.Mean, O3.Mean, SO2.Mean, CO.Mean) %>% 
  summarise(mean_no2 = mean(NO2.Mean), 
            mean_o3 = mean(O3.Mean),
            mean_so2 = mean(SO2.Mean),
            mean_co = mean(CO.Mean)) 

# reshape it from wide to long
long_df <- wa_only %>%
  gather(Sources, AQI, 2:5)

# graphing
long_df %>% 
  ggplot(mapping = aes(x = Date.Local, y = AQI, group = Sources, color = Sources)) +
  geom_line() +
  labs(title = "AQI from different sources") +
  labs(x = "2015/1/1 - 2016/1/1") +
  labs(y = "Average AQI")
