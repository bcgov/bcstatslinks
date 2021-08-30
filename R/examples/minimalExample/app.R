# Simple demo

ui <- shiny::fluidPage(linkModUI(id = 'testModule'))

server <- function(input, output) { linkModServer(id = 'testModule') }

shiny::shinyApp(ui = ui, server = server)


