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
# Income Calculations
# What is the total income each year?
yearly_total_income <- income_by_location %>% 
  filter(Race == "Total") %>% 
  group_by(Year) %>% 
  summarise("Household Income By Race" = sum(Household.Income.by.Race))

# Which county has the highest average income?
highest_county <- filter(income_by_location, Race == "Total") %>% 
  group_by(Geography) %>% 
  summarise(Household.Income.by.Race = mean(Household.Income.by.Race)) %>%
  arrange(desc(Household.Income.by.Race)) %>%
  head(n = 1L) %>%
  pull(Geography)

# What and where is the maximum income reported each year? 
yearly_maximum_income <- income_by_location %>% 
  filter(Race == "Total") %>% 
  group_by(Year) %>% 
  filter(Household.Income.by.Race == max(Household.Income.by.Race, na.rm = FALSE)) %>% 
  select(Year, Household.Income.by.Race, Geography)
  
# Air Quality Calculations
aqi_wa <- aqi_2016 %>%
  filter(State == "Washington")

# Which of the WA county had the highest amount of good days?
county_highest_good <- aqi_wa %>%
  filter(Good.Days == max(Good.Days), na.rm = TRUE) %>%
  pull(County)

# How many good days did that county have? 
days_highest_good <- aqi_wa %>%
  filter(Good.Days == max(Good.Days), na.rm = TRUE) %>%
  pull(Good.Days)

# Which of the WA county had the lowest amount of good days?
county_lowest_good <- aqi_wa %>%
  filter(Good.Days == min(Good.Days), na.rm = TRUE) %>%
  select(County)

# How many good days did that county have? 
days_lowest_good <- aqi_wa %>%
  filter(Good.Days == min(Good.Days), na.rm = TRUE) %>%
  select(Good.Days)


# What is the range between the highest max AQI and the lowest?
max_range <- range(aqi_wa$Max.AQI)

wa_only <- aqi_data %>%
  filter(State == "Washington") %>%
  filter(Date.Local >= "2015-01-01", Date.Local <= "2016-01-01")

# In which days of 2015 had the greatest mean of O3, and how much ppm?
highest_O3_mean <- wa_only %>%
  filter(NO2.Mean == max(NO2.Mean), na.rm = TRUE) %>%
  select(Date.Local, NO2.Mean) %>%
  head(1) %>%
  pull(NO2.Mean)

highest_O3_mean_date <- wa_only %>%
  filter(NO2.Mean == max(NO2.Mean), na.rm = TRUE) %>%
  select(Date.Local, NO2.Mean) %>%
  head(1) %>%
  pull(Date.Local)