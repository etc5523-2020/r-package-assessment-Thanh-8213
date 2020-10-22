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
#' @examples
#' 
#'library(shiny)
#' ui <-   fluidPage(
#'  fluidRow(
#'    column(
#'      sliderDateinput(inputId  = "timeSlider",x = data_total$date),
#'      width = 12)
#'  )
#')
#'server <- function(input, output) {
#'}
#' shinyApp(ui = ui, server = server)

sliderDateinput <- function(inputId, 
                            label = "Select date",
                            x, ...){
  shiny::sliderInput(inputId = inputId, 
                     label = label,
                     min = min(x),
                     max = max(x),
                     value = max(x),
                     width = "100%",
                     timeFormat = "%d/%m/%Y")
}
