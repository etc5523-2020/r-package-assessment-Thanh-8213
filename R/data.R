#'COVID19 data from 22/01/2020 to 06/10/2020
#'
#'A dataset contains the number of COVID19 cases worldwide from 22/01/2020 to 06/10/2020.
#'There are 3 type of cases: Confirmed, deceased and recovered
#'
#'@format A tibble with 48692 observations and 7 variables
#'
#'- **Country/Region**: Country/ Region name
#'- **date**: The date of observation, using `Date` class.
#'- **lat**: The latitude code.
#'- **long**: The longitude code.
#'- **confirmed**: The number of confirmed cases.
#'- **deceased**: The number of deceased cases.
#'- **recovered**: The number of recovered cases.
#'
#'@source [John Hopkins Github](https://github.com/CSSEGISandData/COVID-19)

"data_total"


#' Data for new cases of COVID19 from 22/01/2020 to 06/10/2020
#' 
#'#'#'A dataset contains the number of COVID19 cases worldwide from 22/01/2020 to 06/10/2020.
#'There are 6 type of cases: Confirmed, deceased, recovered, new daily confirmed,
#'new daily death and new daily recovered
#'
#'@format A tibble with 292152 observations and 6 variables
#'
#'- **Country/Region**: Country/ Region name
#'- **date**: The date of observation, using `Date` class.
#'- **lat**: The latitude code.
#'- **long**: The longitude code.
#'- **var**: The cases type, `c("Confirmed cases","Recovered cases","Deceased cases",
#'"New daily cases","New death cases","New recovered cases")`
#'- **value** - The number of cases
#'
#'@source [John Hopkins Github](https://github.com/CSSEGISandData/COVID-19)
#'
"data_total_newdaily"