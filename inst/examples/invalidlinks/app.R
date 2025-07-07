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

# Demo with linkModule included in the standard BC Stats header

ui <- shiny::fluidPage({

  fluidRow(
    ## Header column ----
    column(
      width = 12,
      style = "background-color:#003366;
               border-bottom:2px solid #fcba19;
               position:fixed;
               z-index:10000",
      tags$header(class="header",
                  style="padding:0 0px 0 0px;
                         display:flex;
                         height:80px;
                         width:100%;",
                  tags$div(class="banner",
                           style="width:100%;
                                  display:flex;
                                  justify-content:flex-start;
                                  align-items:center;
                                  margin: 0 10px 0 10px",
                           a(href=
      "https://www2.gov.bc.ca/gov/content/data/about-data-management/bc-stats",
                             img(src = "bcstats_logo_rev.png",
                                 title = "BC Stats",
                                 height = "80px",
                                 alt = "British Columbia - BC Stats"),
                             onclick="gtag"),
                           h1("British Columbia - Labour Market Statistics",
                              style="font-weight:400;
                                     color:white;
                                     margin: 5px 5px 0 18px;"),
                           ## MODULE CODE
                           tags$div(style = "margin-left:auto;
                                             margin-right:0;",
                                    bcstatslinks::linkModUI('links'))
                  )
      )
    )
  )
  })

server <- function(input, output) {

  mock_link_loader <- function() {
    # Return NULL to simulate failure
    return(NULL)
  }

  bcstatslinks::linkModServer(id = 'links', data_loader = mock_link_loader)
  }

shiny::shinyApp(ui = ui, server = server)

