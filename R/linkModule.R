
#' Module UI for clickable drop down list with links to BC Stats apps
#'
#' For examples run \code{simpleModuleDemo()} or \code{bcstatsHeaderDemo()}.
#' To see the underlying code for these examples run \code{simpleModuleDemoCode()}
#' or \code{bcstatsHeaderDemoCode()}.
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


appExampleLocations <- function() {

  list(
    simple = system.file("R","examples","minimalExample", package = "bcstatslinks"),
    header = system.file("R","examples","bcstatsHeaderExample", package = "bcstatslinks")
  )
}

#' Simple Module Demo

#' @export
simpleModuleDemo <- function(){

  shiny::shinyAppDir(appExampleLocations()$simple)
}

#' View code for the Simple Module Demo
#'
#' @export
simpleModuleDemoCode <- function() {

  cat(paste0(readLines(appExampleLocations()$simple), collapse="\n"))
}



#' Demo with the standard BC Stats header
#'
#' @export
bcstatsHeaderDemo <- function(){

  shiny::shinyAppDir(appExampleLocations()$header)

}

#' View code for the BCStats Header Demo
#'
#' @export
bcstatsHeaderDemoCode <- function(){

  cat(paste0(readLines(appExampleLocations()$header), collapse="\n"))

}

