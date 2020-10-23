library(shiny)
library(testthat)
test_that("sliderDateinput create slider for date",{
  expect_equal(sliderDateinput("timeSlider", data_total$date),
               shiny::sliderInput(inputId = "timeSlider", 
                                  label = "Select date",
                                  min = min(data_total$date),
                                  max = max(data_total$date),
                                  value = max(data_total$date),
                                  width = "100%",
                                  timeFormat = "%d/%m/%Y")
  )
})