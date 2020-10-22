#' This function create the slider input in shiny app
#' 
#' 
#' Title
#' @description
#' Constructs a slider widget to select a date value from a range of value.
#' @param inputId 
#' The input slot that will be used to access the value.
#'
#' @param x 
#' The variables that will be used to construct the range of value
#' @param ... 
#' Arguments passed to sliderInput().
#'
#' @return 
#' Export a slider input in Shiny app.
#'
#' @export

sliderDateinput <- function(inputId,
                            x, ...){
  shiny::sliderInput(inputId = inputId, 
                     label = "Select date",
                     min = min(x),
                     max = max(x),
                     value = max(x),
                     width = "100%",
                     timeFormat = "%d/%m/%Y")
}
