# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Exploratory Analysis 

# Setup ------------------------------------------------------------------------

# Load the necessary packages. 
library(tidyverse)
library(maps)
library(mapproj)
library(patchwork)

# Loading relevant data set. Note to go to Session > Set Working Direction to
# change to this folder to have the file path run properly.
aqi_2016 <- read.csv("annual_aqi_by_county_2016.csv")

# Filtering AQI data to only show the state of Washington.
aqi_wa <- aqi_2016 %>%
  filter(State == "Washington")

# Changing county names to all lower case to make the format same as map_data.
aqi_wa$County = tolower(aqi_wa$County)

# Left joined the AQI data set with map_data to obtain coordinates.
aqi_counties <- map_data("county") %>%
  filter(region == "washington") %>%
  rename(County = subregion) %>%
  left_join(aqi_wa, by="County") %>%
  rename('Max AQI' = Max.AQI)

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        # remove axis lines
    axis.text = element_blank(),        # remove axis labels
    axis.ticks = element_blank(),       # remove axis ticks
    axis.title = element_blank(),       # remove axis titles
    plot.background = element_blank(),  # remove gray background
    panel.grid.major = element_blank(), # remove major grid lines
    panel.grid.minor = element_blank(), # remove minor grid lines
    panel.border = element_blank()      # remove border around plot
  )

# Making the map for the max AQI in WA by county.
max_aqi_map <- ggplot(aqi_counties) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = 'Max AQI'),
    color = "gray", size = 0.3
  ) +
  coord_map() +
  scale_fill_continuous(limits = c(0, max('Max AQI')), na.value = "white", low="green", high="brown") +
  blank_theme +
  ggtitle("Max AQI In WA By County")
