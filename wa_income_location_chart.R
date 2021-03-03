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

race_plot_data <- wa_income_location %>%
  group_by(Race, Year) %>%
  summarize(mean_race = mean(Household.Income.by.Race))

race_plot <- ggplot(data = race_plot_data) +
  geom_point(mapping = aes(x = Year, y = `mean_race`,
                           color = Race)) +
  labs(title = "Mean Household Income by Race in WA Between 2013 and 2018",
       x = "Year",
       y = "Household Income")

county_plot_data <- wa_income_location %>%
  group_by(County, Year) %>%
  summarize(mean_county = mean(Household.Income.by.Race))

county_plot <- ggplot(data = county_plot_data) +
  geom_point(mapping = aes(x = Year, y = `mean_county`,
                           color = County)) +
  labs(title = "Mean Household Income by County in WA Between 2013 and 2018",
       x = "Year",
       y = "Household Income",
       color = "County")
