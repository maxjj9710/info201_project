# Load the libraries so they are available.
library(dplyr)
library(ggplot2)
library(lintr)
library(stringr)
library(tidyverse)

# Load the dataset.
source("income_by_location.csv")

# Define the server.
server <- function(input, output){
  # Insert the code for the charts here.
  output$income_location_plot <- renderPlotly({
    wa_income_location <- filter(year >= input$date_range[1],
             year <= input$date_range[2]) %>%
      group_by()
    income_location_chart <- ggplot(data = wa_income_location) +
      geom_point(mapping = aes(x = Year, y = Household.Income.by.Race,
                               color = County)) +
      labs(
        title = "Washington State Income by Race",
        x = "Time (years)",
        y = "Household Income",
        color = "Race"
      )
  })
}