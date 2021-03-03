# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Exploratory Analysis 

# Setup ------------------------------------------------------------------------

# Load the necessary packages. 
library(tidyverse)
library(stringr)

# Note: file is too large to be included in github. Download from
# https://www.kaggle.com/sogun3/uspollution?select=pollution_us_2000_2016.csv
aqi_data <- read.csv("pollution_us_2000_2016.csv", header = TRUE)
aqi_2016 <- read.csv("annual_aqi_by_county_2016.csv")
income_by_location <- read.csv("income_by_location.csv")

# WA Mean Household Income in 2018 By Race
race_income <- income_by_location %>%
  filter(`ID.Race` >= "1", `ID.Race` <= "9") %>%
  filter(Year == 2018) %>%
  select(Race, `Household.Income.by.Race`) %>%
  group_by(Race) %>%
  summarize(mean = mean(Household.Income.by.Race)) %>%
  arrange(desc(mean)) %>%
  rename("Mean Income" = mean)

# WA Top 10 90th Percentile AQI Score By County
aqi_wa_90 <- aqi_2016 %>%
  filter(State == "Washington") %>%
  group_by(County) %>%
  select(X90th.Percentile.AQI) %>%
  arrange(desc(X90th.Percentile.AQI)) %>%
  head(n = 10L) %>%
  rename("90th Percentile AQI" = X90th.Percentile.AQI)

# King County WA Pollutant PPM Means in 2015 
pollution_table <- aqi_data %>%
  filter(State == "Washington") %>%
  filter(Date.Local >= "2015-01-01", Date.Local <= "2016-01-01") %>%
  group_by(County) %>%
  summarise("Mean NO2 (ppm)" = mean(NO2.Mean), 
            "Mean O3 (ppm)" = mean(O3.Mean),
            "Mean SO2 (ppm)" = mean(SO2.Mean),
            "Mean CO (ppm)" = mean(CO.Mean))
