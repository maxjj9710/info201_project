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
  
  mainPanel(   
    img(src = "Hong_kong_haze_comparison.jpg", height = "75%", width = "75%"),
    h1("Introduction"),
    p("For our final project, we wanted to explore the relationship between
      air quality, race and the average household income per county. By
      looking at these three factors we are investigating whether income and
      race has an affect on both overall air quality and on the types of
      pollutants present."),
    
    h1("Data"),
      a(href = "https://www.kaggle.com/sogun3/uspollution?select=pollution_us_2000_2016.csv",
        "U.S. Pollution Data"),
        tags$ul(
          tags$li("The data was originally pulled from the United States Environmental 
          Protection Agency database then reshaped by the host to make it easier 
          for data scientists to analyze. It deals with four major pollutants in 
          the United States."),
          tags$li("About 1.4 million observations, 28 features."),
          tags$li("Used to answer: Pollution levels across the U.S. and the types of 
             major pollutants.")
        ),
    
    a(href = "https://aqs.epa.gov/aqsweb/airdata/download_files.html",
      "WA Annual Air Quality Index by County"),
      tags$ul(
        tags$li("Collected by the United States Environmental Protection Agency 
                and contains an annual summary of air quality by United States 
                counties using AirNow ratings."),
        tags$li("About 1000 observations per year, 19 features."),
        tags$li("Used to answer: Where and how air quality in Washington has changed.")
      ),
    
    a(href = "https://datausa.io/profile/geo/washington#:~:text=Households%20in%20Washington%20have%20a,represents%20a%204.36%25%20annual%20growth",
      "WA Income by Race and County"),
      tags$ul(
        tags$li("Collected by the United States Census."),
        tags$li("About 1000 observations per year, 10 features."),
        tags$li("Used to answer: If there is a correlation between race, income 
                and air quality.")
      ),
    
    h1("Air Quality"),
      p("The Air Quality Index runs from 0 to 500, the lower the value,
        the better the air quality. AQI values below 50 are considered good,
        values over 100 can be unhealthy for sensitive groups, while values over
        300 are considered hazardous. During the 2020 fire season, the
        Georgetown neighborhood of Seattle recorded an AQI of 314!"),
      img(src = "AQI_Levels.png"),
    
    h1("Sources of Pollution"),
      p("The Air Quality Index tracks 5 major sources of air pollution,
        ground-level ozone (O3), particle pollution, carbon monoxide (CO),
        sulfur dioxide (SO3) and nitrogen dioxide (NO2). Each of these
        pollutants is federally regulated by the Clean Air Act."),
    
    h3("Particulate Pollution"),
      p("Particulate pollution, refers to  microscopic particles suspended
        in the air. Sources of particulate pollution can be naturally
        occurring or human-made.
        
        Some naturally occurring sources of particulate pollution are:
        volcanoes, dust storms, wild fires and living vegetation.
        Human-made sources include: burning fossil fuels, power plants,
        road dust, industrial processes, construction, coal and aerosols."),
      
      p("Particulate pollution is considered one of the most harmful to
        individual health as well as the health of the environment. Some
        European countries have designated all levels of particulate
        pollution as harmful to individual health with a clear correlations
        between increased particulate pollution and lung cancer. Globally,
        particulate pollution is the sixth leading risk factor for
        premature death."),
    
    h3("Carbon Monoxide"),
      p("Carbon monoxide is released when things are burned like fossil 
        fuels or kerosene. Common indoor sources include gas space heaters, 
        furnaces, chimneys and gas stoves. Unhealthy levels of carbon monoxide 
        are most likely to occur indoors, in a closed environment."),
      p("Exposure to high levels of carbon monoxide can cause confusion, 
        dizziness, unconsciousness and death."),
    
    h3("Sulfur Dioxide"),
      p("The main sources of sulfur dioxide is the burning of fossil fuels and 
        industrial processes. Less significant sources include metal ore extraction 
        and heavy transportation like trains and ships. Sulfur dioxide is also 
        released into the atmosphere during volcanic eruptions."), 
      p("High levels of SO2 can harm the respiratory system and can damage 
        plant foliage, disrupt sensitive ecosystems and leads to the formation 
        of additional sulfur compounds which can lead to acid rain and 
        particulate pollution."),
    
    h3("Nitrogen Dioxide"),
      p("The primary source of human-made nitrogen dioxide is internal
        combustion engines and the burning of fossil fuels. Indoors,
        cigarettes and butane or kerosene heaters or stoves also
        contribute to NO2 levels. Homes with gas stoves have
        significantly higher levels of NO2 which can exacerbate asthma,
        especially in children."),
      p("Agricultural workers can also be exposed to large amounts of
        NO2 in grain-storage silos leading to detrimental health outcomes."),
    
    h3("Ozone"),
      p("Ground-level ozone is not emitted, but formed via chemical reactions 
        between volatile organic compounds and nitrogen oxides. Volatile 
        organic compounds (VOC) are emitted by a wide array of common products 
        including many cleaning, disinfection and degreasing products as well 
        as paints, moth repellents, air fresheners, dry-cleaned clothing, 
        copier machines, craft glues and permanent markers as well as cars 
        and industrial processes. Ozone is formed when these VOCs interact 
        with nitrogen oxides in the presence of sunlight."),
      p("Exposure to elevated levels of ozone can lead to respiratory distress, 
        decreased lung function and tissue damage. Ozone is capable of 
        traveling long distances, so the detrimental effects of this pollutant 
        may be felt by nearby communities."),
      
    h1("Household"),
      p("We wanted to see if there was a correlation between the air quality and 
      the majority race and income for the county. Minority groups and lower income 
      folks tend to bear the greatest burden of enviornmental damages and climate 
      change. By looking at race and income across counties in Washington, we're 
      looking to see if certain populations are most at risk for poor air quality.")
    )
    
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
