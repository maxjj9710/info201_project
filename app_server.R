# Load the libraries so they are available.
library(dplyr)
library(ggplot2)
library(lintr)
library(mapproj)
library(maps)
library(patchwork)
library(shiny)
library(stringr)
library(tidyverse)

# Load the dataset.
income_county_data <- read.csv("income_by_location.csv")
aqi_county_data <- read.csv("annual_aqi_by_county_2016.csv")

# Rona's data:

# Max's data:
# Filtering AQI data to only show the state of Washington.
aqi_wa <- aqi_county_data %>%
  filter(State == "Washington")
# Changing county names to all lower case to make the format same as map_data.
aqi_wa$County = tolower(aqi_wa$County)
# Left joined the AQI data set with map_data to obtain coordinates.
aqi_counties <- map_data("county") %>%
  filter(region == "washington") %>%
  rename(County = subregion) %>%
  left_join(aqi_wa, by="County")

# Vriana's data:
wa_income_location <- income_county_data %>%
  filter(`ID.Race` >= "1", `ID.Race` <= "9") %>%
  mutate("County" = str_sub(Geography, 1, -12)) %>%
  select(Race, Year, `Household.Income.by.Race`, County)

# Define the server.
server <- function(input, output){
  # Insert the code for the charts here.
  # Rona's chart:
  
  # Max's chart:
  
  # Vriana's chart:
  output$income_location_plot <- renderPlotly({
    wa_income_location <- wa_income_location %>%
      filter(Year >= input$date_range[1], Year <= input$date_range[2]) %>% 
      filter(County == input$select_county) %>%
      group_by(Race)
    ggplot(data = wa_income_location) +
      geom_point(mapping = aes(x = Year, y = Household.Income.by.Race,
                               color = Race)) +
      labs(
        title = "Household Income Between 2013 and 2018",
        x = "Time (years)",
        y = "Household Income",
        color = "Race"
      )
  })
}