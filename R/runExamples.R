#' See the code for an example shiny apps
#' @param example either "simple" or "bcstatsheader"

#' @export
seeExampleCode <- function(example) {
  # locate all the shiny app examples that exist
  validExamples <- list.files(system.file("examples", package = "bcstatslinks"))

  validExamplesMsg <-
    paste0(
      "Valid examples are: '",
      paste(validExamples, collapse = "', '"),
      "'")

  # if an invalid example is given, throw an error
  if (missing(example) || !nzchar(example) ||
      !example %in% validExamples) {
    stop(
      'Please run `seeExampleCode()` with a valid example app as an argument.\n',
      validExamplesMsg,
      call. = FALSE)
  }

  # find and launch the app
  appDir <- system.file("examples", example, package = "bcstatslinks")
  shiny::runApp(appDir, display.mode = "showcase")
}
