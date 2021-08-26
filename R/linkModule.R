linkModUI <- function(id) {
  ns <- shiny::NS(id)
  htmltools::tagList(
    shiny::fluidPage(

      shinyjs::useShinyjs(),
      shiny::uiOutput(ns("linkList"))

    ))
}

linkModServer <- function(id) {
  shiny::moduleServer(
    id,
    function(input, output, session) {
      ns <- session$ns

      linkCSV <- readr::read_csv("https://raw.githubusercontent.com/bcgov/bcstatslinks/main/inst/extdata/bcstats_links.csv")
      links <- linkCSV$url
      names(links) <- linkCSV$name

      output$linkList <- shiny::renderUI({

        htmltools::div(shiny::selectInput("link-list",
                    label = "",
                    selected = "nothing",
                    choices = c("More BCStats Statistics..." = "nothing", links)),
            htmltools::tags$script(type='text/javascript',
                    "{
                       var urlMenu = document.getElementById('link-list');
                       urlMenu.onchange = function() {
                         var userOption = this.options[this.selectedIndex];
                         if(userOption.value != 'nothing') {
                         window.open(userOption.value, 'bcstats-shinyapps', '');
                         }
                       }}"))



      })

    }
  )
}
#
# ui <- fluidPage(modUI('testModule'))
#
# server <- function(input, output) { mod("testModule") }
#
# shinyApp(ui = ui, server = server)
