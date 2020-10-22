library(dplyr)
library(readr)
library(tidyr)


## code to prepare `data_total` dataset goes here
data_confirmed    <- read_csv(here::here("data-raw/time_series_covid19_confirmed_global.csv"))
data_deceased     <- read_csv(here::here("data-raw/time_series_covid19_deaths_global.csv"))
data_recovered    <- read_csv(here::here("data-raw/time_series_covid19_recovered_global.csv"))

data_confirmed_sub <- data_confirmed %>%
  pivot_longer(names_to = "date", cols = 5:ncol(data_confirmed)) %>%
  group_by( `Country/Region`, date) %>%
  mutate(
    Lat  = na_if(Lat, 0),
    Long = na_if(Long, 0)
  ) %>%
  summarise("confirmed" = sum(value, na.rm = T),
            "Lat"       = round(mean(Lat, na.rm = T),4),
            "Long"      = round(mean(Long, na.rm = T),4))

data_recovered_sub <- data_recovered %>%
  pivot_longer(names_to = "date", cols = 5:ncol(data_recovered)) %>%
  group_by(`Country/Region`, date) %>%
  mutate(
    Lat  = na_if(Lat, 0),
    Long = na_if(Long, 0)
  ) %>%
  summarise("recovered" = sum(value, na.rm = T),
            "Lat"       = round(mean(Lat, na.rm = T),4),
            "Long"      = round(mean(Long, na.rm = T),4))

data_deceased_sub <- data_deceased %>%
  pivot_longer(names_to = "date", cols = 5:ncol(data_deceased)) %>%
  group_by( `Country/Region`, date) %>%
  mutate(
    Lat  = na_if(Lat, 0),
    Long = na_if(Long, 0)
  ) %>%
  summarise("deceased" = sum(value, na.rm = T),
            "Lat"       = round(mean(Lat, na.rm = T),4),
            "Long"      = round(mean(Long, na.rm = T),4))

data_total <- data_confirmed_sub %>%
  left_join(data_recovered_sub, by = c("Country/Region", "date")) %>%
  left_join(data_deceased_sub,  by = c("Country/Region", "date")) %>% 
  ungroup() %>%
  mutate(date = as.Date(date, "%m/%d/%y")) %>%
  select(c("Country/Region", "date", "Lat", "Long", "confirmed", "deceased", "recovered")) %>%
  as.tibble

usethis::use_data(data_total, overwrite = TRUE)
