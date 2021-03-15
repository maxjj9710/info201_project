# Load the libraries so they are available.
library(plotly)
library(shiny)

# We will begin by defining some of the UI elements as variables. This helps
# keep the code organized and easier to debug. 

# Create the widgets.
# For `interactive_page_one`:

# For `interactive_page_two`:

# For `interactive_page_three`:


# Define a variable, `page_one`, for your first page. It should be a
# `tabPanel()` with a title, "Introduction", to represent the first tab. This
# layout will contain the following elements:
introductory_page <- tabPanel(
  "Introduction",          # Title of the page; what will appear as the tab name
  mainPanel(                    # Typically where you place your plots and texts
      p("Our Group"),
      p("Vriana Gatdula, Rona Guo, Aubrey Jones, and Max Wang"),
      p("INFO 201 A/AE"),
      p("Our Goals"),
      p("Text"),
      p("Our Data"),
      p("Text")
      # Insert chart and/or text here -- the variable name(s), NOT the code
))

# Create the other pages.
# Rona
interactive_page_one <- tabPanel(
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
concluding_page <- tabPanel(
  "Conclusion",            # Title of the page; what will appear as the tab name
  mainPanel(                    # Typically where you place your plots and texts
      p("Our Findings"),
      # Insert chart and/or text here -- the variable name(s), NOT the code
      p("Text")
))

# Define the UI and what pages/tabs go into it. 
ui <- navbarPage(
  "Final Deliverable: Title",
  introductory_page,
  # Insert other pages here
  interactive_page_one,
  interactive_page_two,
  interactive_page_three,
  concluding_page
)