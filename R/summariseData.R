#'Summarise data to fewer rows
#'@aliases summarizeData
#'
#'@description
#'Summarise data creates a new data frame. It will have one row for each combination 
#'of grouping variables. 
#'
#' @param data
#' data must contain confirmed, deceased and recovered columns
#' @param groupBy 
#'groupBy is the column user want to summarise by
#'
#'@return 
#'A data table that contain the summarise data of cases for the variable that user 
#'choose to summarise.   
#'It will contain 4 columns: One for grouping variable, three for confirmed, estimated 
#'recovered and deceased cases
#'@import
#'dplyr
#'magrittr
#'tibble
#'@examples summariseData(data_total, date)

#'@export
#'
#'

summariseData <- function(data, groupBy) {
  data %>%
    group_by({{groupBy}}) %>%
    summarise(
      "Confirmed"            = sum(confirmed, na.rm = T),
      "Deceased"             = sum(deceased, na.rm = T),
      "Estimated Recoveries" = sum(recovered, na.rm = T)
    ) %>%
    as_tibble()
}

summarizeData <- summariseData


