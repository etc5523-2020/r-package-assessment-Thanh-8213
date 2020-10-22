#' Add label for the leaflet map
#'
#' @description
#' This function create HTML label for the types of cases. When mouse is hovered
#' on leaflet map, the label will appear and give addition details.  
#'
#' @return
#' New column named "label" is created in the data table.
#' @param data 
#' Dataframe that contain Country/Region, confirmed, deceased and recovered columns
#' 
#' @export

addLabel <- function(data) {
  data$Label <- paste0(
    '<b>', data$`Country/Region`, '</b><br>
    <table style="width:120px;">
    <tr><td>Confirmed:</td><td align="right">', data$confirmed, '</td></tr>
    <tr><td>Deceased:</td><td align="right">', data$deceased, '</td></tr>
    <tr><td>Estimated Recoveries:</td><td align="right">', data$recovered, '</td></tr>
    </table>'
  )
  data$Label <- lapply(data$Label, HTML)
  
  return(data)
}

