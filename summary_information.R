# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Exploratory Analysis 

# Setup ------------------------------------------------------------------------

# Load the necessary packages. 
library(dplyr)
library(stringr)
library(tidyverse)

# Loading relevant data set. Note to go to Session > Set Working Direction to
# change to this folder to have the file path run properly.
income_by_location <- read.csv("income_by_location.csv")
aqi_2016 <- read.csv("annual_aqi_by_county_2016.csv")
# Note: file is too large to be included in github. Download from
# https://www.kaggle.com/sogun3/uspollution?select=pollution_us_2000_2016.csv
aqi_data <- read.csv("pollution_us_2000_2016.csv")

# Summary information ----------------------------------------------------------

# What is the total income each year?
yearly_total_income <- income_by_location %>% 
  filter(Race == "Total") %>% 
  group_by(Year) %>% 
  summarise(sum(`Household Income by Race`))

# What and where is the maximum income reported each year? 
yearly_maximum_income <- income_by_location %>% 
  filter(Race == "Total") %>% 
  group_by(Year) %>% 
  filter(`Household Income by Race` == max(`Household Income by Race`)) %>% 
  select(Year, `Household Income by Race`, Geography)

# What is the difference in maximum income reported each year? 
#yearly_maximum_income <- mutate(
#  yearly_maximum_income, 
#  "yearly maximum income difference" = 

aqi_wa <- aqi_2016 %>%
  filter(State == "Washington")

# Which of the WA county had the highest amount of good days, and how many?
highest_good <- aqi_wa %>%
  filter(Good.Days == max(Good.Days), na.rm = TRUE) %>%
  select(County, Good.Days)

# What is the range between the highest max AQI and the lowest?
max_range <- range(aqi_wa$Max.AQI)

wa_only <- aqi_data %>%
  filter(State == "Washington") %>%
  filter(Date.Local >= "2015-01-01", Date.Local <= "2016-01-01")

# In which days of 2015 had the greatest mean of O3, and how much ppm?
highest_O3_mean <- wa_only %>%
  filter(NO2.Mean == max(NO2.Mean), na.rm = TRUE) %>%
  select(Date.Local, NO2.Mean) %>%
  head(1)