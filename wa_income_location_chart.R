# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Exploratory Analysis

# Setup ------------------------------------------------------------------------

# Load the necessary packages.
library(dplyr)
install.packages("ggplot2")
library(ggplot2)
library(stringr)
library(tidyverse)

# Loading the relevant dataset. Note: Go to Session > Set Working Direction to
# change to this folder to have the file path run properly.
income_by_location <- read.csv("income_by_location.csv")

# Chart 2 ----------------------------------------------------------------------

wa_income_location <- income_by_location %>%
  filter(`ID.Race` >= "1", `ID.Race` <= "9") %>%
  mutate("County" = str_sub(Geography, 1, -11)) %>%
  select(Race, Year, `Household.Income.by.Race`, County)
ggplot(data = wa_income_location) +
  geom_point(mapping = aes(x = Year, y = `Household.Income.by.Race`,
                           color = Race)) +
  labs(title = "Household Income by Race in Washington State Between 2013 and
       2018",
       x = "Time (years)",
       y = "Household Income")
ggplot(data = wa_income_location) +
  geom_point(mapping = aes(x = Year, y = `Household.Income.by.Race`,
                           color = County)) +
  labs(title = "Household Income by County in Washington State Between 2013 and
       2018",
       x = "Time (years)",
       y = "Household Income",
       color = "County")
