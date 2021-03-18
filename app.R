# Setup ------------------------------------------------------------------------

# Load the libraries so they are available.
library(shiny)

# Use source() to execute the `app.ui.R` and `app_server.R` files. These will
# define the UI value and function, respectively.
source("app_ui.R")
source("app_server.R")

# Create a new shinyApp() using the loaded `ui` and `server` variables. 
shinyApp(ui = ui, server = server)