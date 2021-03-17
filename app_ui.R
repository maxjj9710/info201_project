# Load the libraries so they are available.
library(plotly)
library(shiny)
library(tidyverse)

# We will begin by defining some of the UI elements as variables. This helps
# keep the code organized and easier to debug.

# Create the widgets.
# For `interactive_page_one`:

# For `interactive_page_two`:

# For `interactive_page_three`:
date_input <- sliderInput(
  inputId = "date_range",
  label = "Date (year)",
  min = 2013,
  max = 2018,
  value = c(2013, 2018)
)
county_input <- selectInput(
  inputId = "select_county",
  label = "Select a county",
  choices = c(
    "Benton", "Chelan", "Clallam", "Clark", "Cowlitz", "Franklin", "Grant",
    "Grays Harbor", "Island", "King", "Kitsap", "Lewis", "Mason", "Pierce",
    "Skagit", "Snohomish", "Spokane", "Thurston", "Whatcom", "Yakima"
  ),
  selected = "Benton"
)

# Define a variable, `page_one`, for your first page. It should be a
# `tabPanel()` with a title, "Introduction", to represent the first tab. This
# layout will contain the following elements:
introductory_page <- tabPanel(
  "Introduction",          # Title of the page; what will appear as the tab name
      # Left side of the page
      # Insert widgets or text here -- their variable name(s), NOT the raw code
  mainPanel(                    # Typically where you place your plots and texts
      p("For our final project, we wanted to explore the relationship between
        air quality, race and the average household income per county. By
        looking at these three factors we are investigating whether income and
        race has an affect on both overall air quality and on the types of
        pollutants present."),
      
      tags$h1("Air Quality"),
      tags$p("The Air Quality Index runs from 0 to 500, the lower the value,
              the better the air quality. AQI values below 50 are considered good,
              values over 100 can be unhealthy for sensitive groups, while values over
              300 are considered hazardous. During the 2020 fire season, the
              Georgetown neighborhood of Seattle recorded an AQI of 314!"),
      tags$img(src = "AQI_Levels.png"),
      
      tags$h1("Sources of Pollution"),
      tags$p("The Air Quality Index tracks 5 major sources of air pollution,
                 ground-level ozone (O3), particle pollution, carbon monoxide (CO),
                 sulfur dioxide (SO3) and nitrogen dioxide (NO2). Each of these
                 pollutants is federally regulated by the Clean Air Act."),
      
      tags$h3("Particulate Pollution"),
      tags$p("Particulate pollution, refers to  microscopic particles suspended
             in the air. Sources of particulate pollution can be naturally
             occurring or human-made.
              
              Some naturally occurring sources of particulate pollution are:
              volcanoes, dust storms, wild fires and living vegetation.
              Human-made sources include: burning fossil fuels, power plants,
              road dust, industrial processes, construction, coal and aerosols."),
      
      tags$p("Particulate pollution is considered one of the most harmful to
                individual health as well as the health of the environment. Some
                European countries have designated all levels of particulate
                pollution as harmful to individual health with a clear correlations
                between increased particulate pollution and lung cancer. Globally,
                particulate pollution is the sixth leading risk factor for
                premature death."),
      
      tags$h3("Carbon Monoxide"),
      tags$h3("Sulfur Dioxide"),
      tags$h3("Nitrogen Dioxide"),
      tags$p("The primary source of human-made nitrogen dioxide is internal
                   combustion engines and the burning of fossil fuels. Indoors,
                   cigarettes and butane or kerosene heaters or stoves also
                   contribute to NO2 levels. Homes with gas stoves have
                   significantly higher levels of NO2 which can exacerbate asthma,
                   especially in children."),
      tags$p("Agricultural workers can also be exposed to large amounts of
            NO2 in grain-storage silos leading to detrimental health outcomes."),
      
      tags$h3("Ozone"),
      
      
      
      tags$h1("Household"),
      tags$p("Next, we wanted to see if there was a correlation between the
          air quality and the majority race and income for the county.
          What and where is the maximum income reported each year?
          As the most densely populated county, King County tops the list of highest income.
          WA Mean Household Income in 2018 By Race
          Next, we charted the annual household income by race.
          Finally, we charted income by county per year. By comparing the income
                 levels across counties, we're looking for potential correlations
                 between air quality and income. Our next steps will be to pair
                 this information with air quality")
  )
    # Insert chart and/or text here -- the variable name(s), NOT the code
)

# Create the other pages.
# Rona
# interactive_page_one <- tabPanel(
#   "Text",                 # Title of the page; what will appear as the tab name
#   sidebarLayout(             
#     sidebarPanel( 
#       "Text"
#       # Left side of the page 
#       # Insert widgets or text here -- their variable name(s), NOT the raw code
#     ),           
#     mainPanel(                  # Typically where you place your plots and texts
#       plotlyOutput(""),
#       p("Text")
#       # Insert chart and/or text here -- the variable name(s), NOT the code
# )))
# Max
interactive_page_two <- tabPanel(
  "Title",                 # Title of the page; what will appear as the tab name
  sidebarLayout(
    sidebarPanel(
      "Text"
      # Left side of the page
      # Insert widgets or text here -- their variable name(s), NOT the raw code
    ),
    mainPanel(                  # Typically where you place your plots and texts
      plotlyOutput(""),
      p("Text")
      # Insert chart and/or text here -- the variable name(s), NOT the code
    )))

# Vriana
interactive_page_three <- tabPanel(
  "Household Income",      # Title of the page; what will appear as the tab name
  sidebarLayout(
    sidebarPanel(
      # Left side of the page
      # Insert widgets or text here -- their variable name(s), NOT the raw code
      date_input,
      county_input
    ),
    mainPanel(                  # Typically where you place your plots and texts
      plotlyOutput("income_location_plot"),
      tags$h3("Purpose"),
      p("The interactive dot plot above can be utilized to investigate household
        income by county and race in Washington state. The question we
        ultimately hope to answer is: Does money have any relation to air
        quality? If so, what?"),
      tags$h3("Findings"),
      p("text")
      # Insert chart and/or text here -- the variable name(s), NOT the code
    )))

# concluding_page <- tabPanel(
#   "Conclusion",            # Title of the page; what will appear as the tab name
#   mainPanel(                    # Typically where you place your plots and texts
#       p("Our Findings"),
#       # Insert chart and/or text here -- the variable name(s), NOT the code
#       p("Text")
# ))

# Define the UI and what pages/tabs go into it. 
ui <- navbarPage(
  "Final Deliverable: Title",
  introductory_page,
  # Insert other pages here
  # interactive_page_one,
  # interactive_page_two,
  interactive_page_three
  # concluding_page
)
