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

# Loading relevant data set. Note to go to Session > Set Working Direction to
# change to this folder to have the file path run properly.
income_by_location <- read.csv("income_by_location.csv")

# Chart 2 ----------------------------------------------------------------------

wa_income_location <- income_by_location %>% 
  filter(Race == "Total") %>% 
  select(Race, Year, Household.Income.by.Race, Geography) 

ggplot(wa_income_location, aes(x = Year, y = Household.Income.by.Race)) +
  geom_bar(stat = "identity")