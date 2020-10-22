#'#' SummariseData_newdaily daily new cases
#' 
#'@aliases SummarizeData_newdaily
#'
#'@param data
#' Data must contain date and value columns.
#'
#'@return 
#'A data table that contain the summarise data of cases for the date variable.
#'
#'@import
#'dplyr
#'magrittr
#'
#'@export
summariseData_newdaily <- function(data){
  data %>%
    group_by(date) %>%
    summarise(value = sum(value))
}

SummarizeData_newdaily <- summariseData_newdaily
