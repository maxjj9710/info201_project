# Load the libraries so they are available.
library(plotly)
library(shiny)

# We will begin by defining some of the UI elements as variables. This helps
# keep the code organized and easier to debug. 

# Create the widgets. 

# Define a variable, `page_one`, for your first page. It should be a
# `tabPanel()` with a title, "Introduction", to represent the first tab. This
# layout will contain the following elements:
introductory_page <- tabPanel(
  "Title",                 # Title of the page; what will appear as the tab name
  sidebarLayout(             
    sidebarPanel( 
      "Text"
      # Left side of the page 
      # Insert widgets or text here -- their variable name(s), NOT the raw code
    ),           
    mainPanel(                  # Typically where you place your plots and texts
      p("Text")
      # Insert chart and/or text here -- the variable name(s), NOT the code
)))

# Create the other pages.
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
  "Title",                 # Title of the page; what will appear as the tab name
  sidebarLayout(             
    sidebarPanel( 
      "Text"
      # Left side of the page 
      # Insert widgets or text here -- their variable name(s), NOT the raw code
    ),           
    mainPanel(                  # Typically where you place your plots and texts
      p("Text")
      # Insert chart and/or text here -- the variable name(s), NOT the code
)))

# Define the UI and what pages/tabs go into it. 
ui <- navbarPage(
  "Title",
  introductory_page,
  # Insert other pages here
  interactive_page_one,
  interactive_page_two,
  interactive_page_three,
  concluding_page
)