# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Final Deliverable

# Load the libraries so they are available.
library(ggplot2)
library(plotly)
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
# Note: file is too large to be included in github. Download from
# https://www.kaggle.com/sogun3/uspollution?select=pollution_us_2000_2016.csv
aqi_data <- read.csv("pollution_us_2000_2016.csv", header = TRUE)

# Rona's data:
wa_data <- aqi_data %>%
  filter(State == "Washington") %>%
  group_by(Date.Local) %>%
  summarise(mean_no2 = mean(NO2.Mean),
            mean_o3 = mean(O3.Mean),
            mean_so2 =  mean(SO2.Mean),
            mean_co = mean(CO.Mean))

# reshape it from wide to long
long_df <- pivot_longer(wa_data, cols = -Date.Local,
                        names_to = "metric", values_to = "value")

# Max's data:
# Filtering AQI data to only show the state of Washington.
aqi_wa <- aqi_county_data %>%
  filter(State == "Washington")

# Changing county names to all lower case to make the format same as map_data.
aqi_wa$County <- tolower(aqi_wa$County)

# Left joined the AQI data set with map_data to obtain coordinates.
aqi_counties <- map_data("county") %>%
  filter(region == "washington") %>%
  rename(County = subregion) %>%
  left_join(aqi_wa, by = "County")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # Remove axis lines
    axis.text = element_blank(),        # Remove axis labels
    axis.ticks = element_blank(),       # Remove axis ticks
    axis.title = element_blank(),       # Remove axis titles
    plot.background = element_blank(),  # Remove gray background
    panel.grid.major = element_blank(), # Remove major grid lines
    panel.grid.minor = element_blank(), # Remove minor grid lines
    panel.border = element_blank()      # Remove border around plot
  )

# Vriana's data:
wa_income_location <- income_county_data %>%
  filter(`ID.Race` >= "1", `ID.Race` <= "9") %>%
  mutate("County" = str_sub(Geography, 1, -12)) %>%
  select(Race, Year, `Household.Income.by.Race`, County)

# Define the server.
server <- function(input, output) {
  # Insert the code for the charts here.
  # Max's chart:
  output$stat_plot <- renderPlotly({

    ggplot(aqi_counties) +
      geom_polygon(
        mapping = aes_string(x = "long", y = "lat",
                             group = "group", fill = input$stat),
        color = "gray", size = 0.3
      ) +
      coord_map() +
      scale_fill_continuous(
        limits = c(0, max(aqi_counties[input$stat], na.rm = T)),
        na.value = "white", low = "green", high = "brown", name = "AQI") +
      blank_theme +
      ggtitle("2016 AQI Statistics in WA State by County")
  })

  # Rona's Chart
  output$month_range_plot <- renderPlotly({
    wa_data <- wa_data %>%
      filter(Date.Local >= input$month_range[1],
             Date.Local <= input$month_range[2]) %>%
      group_by(Date.Local)
    long_df <- pivot_longer(wa_data, cols = -Date.Local,
                            names_to = "metric", values_to = "value")
    ggplot(data = long_df) +
      geom_line(mapping = aes(x = Date.Local,
                              y = value, group = metric, color = metric)) +
      labs(title = "AQI from different sources") +
      labs(x = "2015/4/25 - 2016/4/25") +
      labs(y = "Average AQI")
  })

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