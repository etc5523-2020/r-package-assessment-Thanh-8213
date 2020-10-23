#' Function to draw the summary table
#' 
#' @param data 
#' Data need to be data_total
#' 
#' @param groupBy 
#' the variables that user want to group and summarise.
#'
#' @description This function create a summary data table that shows the detailed 
#' number of confirmed, deceased and Estimated recovered cases. 
#' 
#' @import 
#' DT
#' @return A summary data table will be created.
#'
#' @export


getSummaryDT <- function(data, groupBy) {
  datatable(
    na.omit(summariseData(data, {{groupBy}})),
    caption = htmltools::tags$caption("Summary of Worldwide COVID19", style = "color:#002366; font-size: 22px; text-align:left"),
    rownames  = FALSE,
    options   = list(
      order          = list(1, "desc"),
      scrollX        = TRUE,
      scrollY        = 200,
      scrollCollapse = T,
      paging         = FALSE
    ),
    selection = ifelse(selectable, "single", "none")
  )
}

