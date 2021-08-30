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
                                    linkModUI('links'))
                  )
      )
    )
  )
  })

server <- function(input, output) { linkModServer(id = 'links') }

shiny::shinyApp(ui = ui, server = server)

