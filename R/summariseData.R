#' Summarise data to display in a data table
#' 
#'@aliases SummarizeData
#'
#'@param
#'df is data_total
#'groupBy is the column user want to summarise by
#'
#'@return 
#'A data table that contain the summarise data of cases for the variable that user 
#'choose to summarise.
#'

summariseData <- function(df, groupBy) {
  df %>%
    group_by({{groupBy}}) %>%
    summarise(
      "Confirmed"            = sum(confirmed, na.rm = T),
      "Estimated Recoveries" = sum(recovered, na.rm = T),
      "Deceased"             = sum(deceased, na.rm = T)
    ) %>%
    as.data.frame()
}
SummarizeData <- summariseData