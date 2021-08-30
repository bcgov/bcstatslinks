# Simple demo

ui <- shiny::fluidPage(
  linkModUI(id = 'links')
  )

server <- function(input, output) {
  linkModServer(id = 'links')
  }

shiny::shinyApp(ui = ui, server = server)


