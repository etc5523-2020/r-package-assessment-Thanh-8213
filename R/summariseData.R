#'Summarise data to fewer rows
#'@aliases summarizeData
#'
#'@description
#'Summarise data creates a new data frame. It will have one row for each combination 
#'of grouping variables. 
#'
#'@param
#'df is data_total
#'@param
#'groupBy is the column user want to summarise by
#'
#'@return 
#'A data table that contain the summarise data of cases for the variable that user 
#'choose to summarise.   
#'It will contain 4 columns: One for grouping variable, three for confirmed, estimated 
#'recovered and deceased cases
#'@examples
#'summariseData(data_total, date))


summariseData <- function(data, groupBy) {
  data %>%
    group_by({{groupBy}}) %>%
    summarise(
      "Confirmed"            = sum(confirmed, na.rm = T),
      "Deceased"             = sum(deceased, na.rm = T),
      "Estimated Recoveries" = sum(recovered, na.rm = T)
    ) %>%
    as.data.frame()
}

summarizeData <- summariseData


