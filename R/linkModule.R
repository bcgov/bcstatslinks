
#' Module UI for clickable drop down list with links to BC Stats apps
#'
#' To see examples and the underlying code for these examples run
#'  \code{seeExampleCode("simple")} or \code{seeExampleCode("bcstatsheader")}.
#'
#' @param id character
#'
#' @return a UI element
#' @export
linkModUI <- function(id) {
  ns <- shiny::NS(id)
  htmltools::tagList(
    shiny::fluidPage(

      shinyjs::useShinyjs(),
      shiny::uiOutput(ns("linkList"))

    ))
}

#' Server-side of clickable drop down list module
#'
#' @param id character
#' @export
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
