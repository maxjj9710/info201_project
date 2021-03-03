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

# read data filem
aqi_data <- read.csv("pollution_us_2000_2016.csv", header = TRUE)

# organize the data
wa_only <- aqi_data %>%
  filter(State == "Washington") %>%
  filter(Date.Local >= "2015-01-01", Date.Local <= "2016-01-01") %>%
  mutate(Months = format(as.Date(Date.Local,  format = "%Y-%m-%d"), "%m")) %>%
  group_by(Months) %>%
  select(County, Months, NO2.Mean, O3.Mean, SO2.Mean, CO.Mean) %>%
  summarise(mean_no2 = mean(NO2.Mean),
            mean_o3 = mean(O3.Mean),
            mean_so2 =  mean(SO2.Mean),
            mean_co = mean(CO.Mean)) 

# reshape it from wide to long
long_df <- pivot_longer(wa_only, cols=-Months, names_to = "metric", values_to = "value")

# graphing
sources_plots <- ggplot(data = long_df) +
  geom_line(mapping = aes(x = Months, y = value, group = metric, color = metric)) +
  labs(title = "AQI from different sources") +
  labs(x = "2015/1/1 - 2016/1/1") +
  labs(y = "Average AQI")
