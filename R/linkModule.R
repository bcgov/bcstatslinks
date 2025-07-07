# Copyright 2019 Province of British Columbia
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


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

      linkCSV <- load_link_csv()

      output$linkList <- shiny::renderUI({

        if(is.null(linkCSV)) {
          # Fallback message in dropdown when CSV cannot be loaded
          htmltools::div(
            shiny::selectInput(
              inputId = ns("link-list"),
              label = "",
              selected = "nothing",
              choices = c("View other BCStats' dashboards" = "nothing", "Links are currently unavailable. Please try again later."),
              width = "250px"))

        } else {
          links <- linkCSV$url
          names(links) <- linkCSV$name

          htmltools::div(
            shiny::selectInput(
              inputId = ns("link-list"),
              label = "",
              selected = "nothing",
              choices = c("View other BCStats' dashboards" = "nothing", links),
              width = "250px"),
            htmltools::tags$script(
              type='text/javascript',
              "{
              var urlMenu = document.getElementById('link-list');
              urlMenu.onchange = function() {
              var userOption = this.options[this.selectedIndex];
              if(userOption.value != 'nothing') {
              window.open(userOption.value, 'bcstats-shinyapps', '');
              }}}")
            )
      }})

    }
  )
}
