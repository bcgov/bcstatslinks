[![img](https://img.shields.io/badge/Lifecycle-Experimental-339999)](https://github.com/bcgov/repomountie/blob/master/doc/lifecycle-badges.md)

# bcstatslinks

This package contains a shiny module to be incorporated into bcstats
shinyapps, to provide a drop down menu with links to other BCStats
shinyapps.

This repo also houses the csv file used to feed this drop down list, see
inst/extdata/bcstats_links.csv. This csv must remain in this location
with the two columns: name and url, but should be updated with new rows
as new apps are created.

### Installation

``` r

## install package
install.packages("remotes")
remotes::install_github("bcgov/bcstatslinks")

## load package
library(bcstatslinks)
```

Note: this package is a requirement for bcsapps. See
<https://github.com/bcgov/bcsapps> for more information.

#### Example

This is a basic example which shows you how to incorporate the drop down
list in your shiny app:

``` r
ui <- shiny::fluidPage(
  bcstatslinks::linkModUI(id = 'linkModule')
  )

server <- function(input, output) { 
  bcstatslinks::linkModServer(id = 'linkModule')
  }

shiny::shinyApp(ui = ui, server = server)
```

### Project Status

Experimental

### Getting Help or Reporting an Issue

To report bugs/issues/feature requests, please file an
[issue](https://github.com/bcgov/bcstatslinks/issues/).

### How to Contribute

If you would like to contribute to the package, please see our
[CONTRIBUTING](CONTRIBUTING.md) guidelines.

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.

### License

    Copyright 2021 Province of British Columbia

    Licensed under the Apache License, Version 2.0 (the &quot;License&quot;);
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an &quot;AS IS&quot; BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and limitations under the License.

------------------------------------------------------------------------

*This project was created using the
[bcgovr](https://github.com/bcgov/bcgovr) package.*
