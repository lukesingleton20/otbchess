
# ui component

login_ui <- function(id, title) {
  
  ns <- NS(id) # namespace id required for modules
  
  # define ui
  div(
    id = ns("login_screen"),
    style = "width: 500px; max-width: 100%; margin: 0 auto;",
    
    div(
      class = "well",
      h4(class = "text-center", title),
      
      textInput(
        inputId = ns("username"),
        label = tagList(icon("user"),
                        "User Name"),
        placeholder = "Enter user name"
      ),
      
      passwordInput(
        inputId = ns("password"),
        label = tagList(icon("unlock"),
                        "Password"),
        placeholder = "Enter password"
      ),
      
      div(
        class = "text-center",
        actionButton(
          inputId = ns("login_button"),
          label = "Log in",
          class = "btn-primray"
        )
      )
    )
  )
}

# server component

validate_password <- function(input, output, session){
  
  eventReactive(input$login_button, {
    
    db_try <- try(dbConnect(
      drv = RMariaDB::MariaDB(),
      dbname = input$username,
      user = input$username,
      host = "20.20.3.2",
      port = "63306",
      password = input$password
    ))
    
    if(class(db_try) == "MariaDBConnection"){
      shinyjs::hide(id = "login_screen")
    }
    
    dbDisconnect(db_try)
    
  })
  
}
