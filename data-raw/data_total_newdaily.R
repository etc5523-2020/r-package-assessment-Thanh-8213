## code to prepare `data_total_newdaily` dataset goes here
library(shiny)
library(dplyr)
library(ggplot2)
library(readr)
library(tidyr)
library(DT)
library(leaflet)
library(scales)
library(plotly)
# data
data_confirmed    <- read_csv(here::here("data/time_series_covid19_confirmed_global.csv"))
data_deceased     <- read_csv(here::here("data/time_series_covid19_deaths_global.csv"))
data_recovered    <- read_csv(here::here("data/time_series_covid19_recovered_global.csv"))

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
  select(c("Country/Region", "date", "Lat", "Long", "confirmed", "deceased", "recovered"))

# Daily new data
data_newcases <- data_total %>%     
  pivot_longer(names_to = "var", cols = c(confirmed, recovered, deceased)) %>%
  filter (var == "confirmed") %>%
  arrange(date) %>%
  group_by(`Country/Region`) %>%
  mutate(new_cases = value - lag(value, 1)) %>% 
  select(c("Country/Region", "date", "Lat", "Long", "new_cases"))


data_newdeaths <- data_total %>%     
  pivot_longer(names_to = "var", cols = c(confirmed, recovered, deceased)) %>%
  filter (var == "deceased") %>%
  arrange(date) %>%
  group_by(`Country/Region`) %>%
  mutate(new_deaths = value - lag(value, 1)) %>%
  select(c("Country/Region", "date", "Lat", "Long", "new_deaths"))

data_newrecover <- data_total %>%     
  pivot_longer(names_to = "var", cols = c(confirmed, recovered, deceased)) %>%
  filter (var == "recovered") %>%
  arrange(date) %>%
  group_by(`Country/Region`) %>%
  mutate(new_recovers = value - lag(value, 1)) %>%
  select(c("Country/Region", "date", "Lat", "Long", "new_recovers"))


data_total_newdaily <- data_total %>%
  left_join(data_newcases,  by = c("Country/Region", "date", "Lat", "Long")) %>%
  left_join(data_newdeaths,  by = c("Country/Region", "date", "Lat", "Long")) %>%
  left_join(data_newrecover,  by = c("Country/Region", "date", "Lat", "Long"))

data_total_newdaily <- data_total_newdaily %>%
  pivot_longer(names_to = "var", cols = c(confirmed, recovered, deceased, new_cases, new_deaths, new_recovers)) %>%
  ungroup()

# Change the name a bit
data_total_newdaily <- data_total_newdaily %>%
  mutate(var = recode(var,
                      "confirmed" = "Confirmed cases",
                      "recovered" = "Recovered cases",
                      "deceased"  = "Deceased cases",
                      "new_cases" = "New daily cases",
                      "new_deaths"= "New death cases",
                      "new_recovers"= "New recovered cases"))


usethis::use_data(data_total_newdaily, overwrite = TRUE)
