# Copyright 2025 Province of British Columbia
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

#' Load the link list CSV from GitHub
#'
#' @return A data frame with columns `name` and `url`, or throws an error
#' @noRd
load_link_csv <- function() {

  tryCatch({

    list <- readr::read_csv(
      "https://raw.githubusercontent.com/bcgov/bcstatslinks/main/inst/extdata/bcstats_links.csv",
      show_col_types = FALSE
    )

    if(!all(c("name", "url") %in% names(list))) {
      stop("Link list is missing required columns: 'name' and/or 'url'")
    }

    return(list)
  },

  error = function(e) {
    warning("Failed to load link list from GitHub: ", conditionMessage(e))
    return(NULL)
  })

}

