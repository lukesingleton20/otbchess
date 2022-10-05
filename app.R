
library(shiny)
library(shinyjs)
library(shinythemes)
library(DBI)
library(RMariaDB)

# Source Modules
source("login.R")

# Define UI
ui <- fluidPage(

  useShinyjs(),
  
  div(
    class = "container",
    
    column(
      width = 12,
      
      login_ui(id = "login", title = "Please login"),
      uiOutput(outputId = "dashboard")
      
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

  check_password <- callModule(
    module = validate_password,
    id = "login"
  )

  output$dashboard <- renderUI({
    
    req(check_password())
    
    div(
      class = "bg-success",
      id = "success",
      h4("Acces confirmed!"),
      p("You are now securely connected to the otbchess database.")
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
