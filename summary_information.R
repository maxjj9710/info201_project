# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Exploratory Analysis 

# Setup ------------------------------------------------------------------------

# Load the necessary packages. 
library(dplyr)
library(stringr)
library(tidyverse)

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
yearly_maximum_income <- mutate(
  yearly_maximum_income, 
  "yearly maximum income difference" = 