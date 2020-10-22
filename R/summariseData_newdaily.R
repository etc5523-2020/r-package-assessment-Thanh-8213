#'#' SummariseData_newdaily daily new cases
#' 
#'@aliases SummarizeData_newdaily
#'
#'@param
#'data is data_total_newdaily
#'groupBy is the column user want to 
#'
#'@return 
#'A data table that contain the summarise data of cases for the variable that user 
#'choose to summarise.
#'


summariseData_newdaily <- function(data){
  data %>%
    group_by(date) %>%
    summarise(value = sum(value))
}

SummarizeData_newdaily <- summariseData_newdaily
