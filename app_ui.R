# Group 5: Vriana Gatdula, Rona Guo, Aubrey Jones, Max Wang
# INFO 201 A // AE
# Final Deliverable

# Load the libraries so they are available.
library(plotly)
library(shiny)
library(tidyverse)
source("app_server.R")

# We will begin by defining some of the UI elements as variables. This helps
# keep the code organized and easier to debug.

# Create the widgets.
month_input <- dateRangeInput(
  inputId = "month_range",
  label = "Date",
  start = "2015-04-25",
  end = "2016-04-25",
  format = "yyyy-mm-dd",
  startview = "month",
  weekstart = 0,
  language = "en",
  separator = " to "
)

stat_input <- selectInput(
  inputId = "stat",
  label = h3("Statistic"),
  choices = list("Max AQI" = "Max.AQI",
                 "90th Percentile AQI" = "X90th.Percentile.AQI",
                 "Median AQI" = "Median.AQI"),
  selected = "Max AQI"
)

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

introductory_page <- tabPanel(
  "Introduction",          # Title of the page; what will appear as the tab name
      # Left side of the page
      # Insert widgets or text here -- their variable name(s), NOT the raw code

  mainPanel(
    column(12, img(src = "Hong_kong_haze_comparison.jpg",
                   height = "75%", width = "75%"),
           align = "center"),

    h1("Introduction"),
    p("For our final project, we wanted to explore the relationship between
      air quality, race and the average household income per county. By
      looking at these three factors we are investigating whether income and
      race has an affect on both overall air quality and on the types of
      pollutants present."),

    h1("Data"),
      a(href = paste0("https://www.kaggle.com/sogun3/uspollution?select",
                      "=pollution_us_2000_2016.csv"),
        "U.S. Pollution Data"),
        tags$ul(
          tags$li("The data was originally pulled from the United States
          Environmental Protection Agency database then reshaped by the host to
          make it easier for data scientists to analyze. It deals with four
          major pollutants in the United States."),
          tags$li("About 1.4 million observations, 28 features."),
          tags$li("Used to answer: Pollution levels across the U.S. and the
                  types of major pollutants.")
        ),

    a(href = "https://aqs.epa.gov/aqsweb/airdata/download_files.html",
      "WA Annual Air Quality Index by County"),
      tags$ul(
        tags$li("Collected by the United States Environmental Protection Agency
                and contains an annual summary of air quality by United States
                counties using AirNow ratings."),
        tags$li("About 1000 observations per year, 19 features."),
        tags$li("Used to answer: Where and how air quality in Washington has
                changed.")
      ),

    a(href = paste0("https://datausa.io/profile/geo/washington#:~:text=",
                    "Households%20in%20Washington%20have%20a,",
                    "represents%20a%204.36%25%20annual%20growth"),
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
        industrial processes. Less significant sources include metal ore
        extraction and heavy transportation like trains and ships. Sulfur
        dioxide is also released into the atmosphere during volcanic
        eruptions."),
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

    h1("Household Income"),
      p("We wanted to see if there was a correlation between the air quality and
      the majority race and income for the county. Minority groups and lower
      income folks tend to bear the greatest burden of enviornmental damages and
      climate change. By looking at race and income across counties in
      Washington, we're looking to see if certain populations are most at risk
        for poor air quality.")
    )

    )

# Max
interactive_page_two <- tabPanel(
  "AQI Statistics",

  sidebarLayout(

    sidebarPanel(stat_input),

    mainPanel(
      plotlyOutput("stat_plot"),
      h3("Purpose"),
      p("The interactive map looks at air qualities in various counties in
        Washington state. Using different statistical numbers, we can see how
        each county performs on the AQI in different areas."),
      h3("Findings"),
      p("In terms of having worst AQIs, Yakima scored the highest in terms of
        Max and 90th Percentile AQI. We believe this could be due to wild fires
        which can drastically worsen air quality. However, in terms of Median
        AQI, the more urban counties like King win out. There, higher population
        and urbanicity would lead to consistently worse air quality.")
    )
  )
)

# Rona
interactive_page_one <- tabPanel(

  "Pollution by date in WA",

  sidebarLayout(

    sidebarPanel(
      month_input
    ),
    mainPanel(

      plotlyOutput("month_range_plot"),
      tags$h3("Purpose"),
      p("The plot above shows you the variation in mean pollution levels of CO,
        NO2, O3, SO2 in the Washington State over the course of a year. The date
        range widget allows you to select the date range to see how pollution
        level changes in different seasons/days. With this interactive plot you
        could also see the mean levels of pollution on each day."),
      tags$h3("Findings"),
      p("We found that Carbon Monoxide(CO) is the leading polluant and
         consistanly outperform the other sources of polluant over the year. CO
         is released when things containing carbpn is burned. The highest peaks
         of avg AQI by CO happened on July 8th and November 30th, when we had
         record heat in Washington and huge wildfires. We think the wildfires
         we had that year contributed to the large amount of CO.")
    )
  )
)

# Vriana
interactive_page_three <- tabPanel(
  "Household Income",
  sidebarLayout(
    sidebarPanel(
      date_input,
      county_input
    ),
    mainPanel(
      plotlyOutput("income_location_plot"),
      tags$h3("Purpose"),
      p("The interactive dot plot above can be utilized to investigate household
        income by county and race in Washington state. The question we
        ultimately hope to answer is: Does money have any relation to air
        quality? If so, what?"),
      tags$h3("Findings"),
      p("A trend that seems to appear commonly, especially in the more urban
      counties--King, Pierce, Snohomish, Spokane, and Clark--is Asians, Whites,
      and White Non-Hispanics being among the top earners of income. And, as
      previously discovered, these same counties ''win out'' in median AQI as a
        result of increasing population and urbanicity.")
    )
  )
)

concluding_page <- tabPanel(

  "Conclusion",

  mainPanel(
    h1("Our Findings"),
    p("In our analysis, we aimed to study if there is correlation between,
       income and air quality of counties in the Washington State. This topic
       resulted from the society's increasing awareness on the social inequality
       issues."),
    tags$ul(
      tags$li("We started by looking at the sources of pollution and their
               variation at different time between April of 2015 and April of
               2016. We found out that Carbon Monoxide is the predominate
               pollutant in the state of Washingotn and it is especially bad
               during the Wildfire season when we had record heat.Sulfur Dioxide
               ranks second while Ozone and Nitrogen Dioxide remains fairly low
               throughout the year"),
      tags$li("Nex, we looked at the air quality of different counties in the
              state. We found out that counties in the mountains had the worst
              AQI in 2016 but it is likely correlated to the bad fire outbreak
              in our national and state forests in 2016. However, urban areas
              like King county had the worst median AQI."),
      tags$li("Lastly, we studied the intersectionality of income and race in
              counties. Overall, it seems like that people of Asian or White
              have higher household income than people who are Native, Hispanic,
              or Black. If we focus on King County (the most populated county
              in WA, we can see the people who identify as Asian or White
              makes $111,609 and $100,298 respectively in 2018 while people
              whoe identify as Black makes $55,152, almost 50% less. It is
              also worth noting that people who are White Non-Hispanic is
              making almost $1000 more than people who identify as White."),
      p("Our analysis of these datasets offered us insights to the air quality
       and income disparity between the counties in Washington. There are an
       obvious gap in income between races, even for people that live in the
       same county. In addition, counties that are by the forest and in urban
       communities tend to have worse air qualities.")
    )
  )
)

# Define the UI and what pages/tabs go into it.
ui <- navbarPage(
  "Final Deliverable",
  introductory_page,
  interactive_page_one,
  interactive_page_two,
  interactive_page_three,
  concluding_page
)
