#' Launch the shiny app
#' @export
launch_app <- function() {
  appDir <- system.file("app", package = "icecovid19")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `icecovid19`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal")
}
