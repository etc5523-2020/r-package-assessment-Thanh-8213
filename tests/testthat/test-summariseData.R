test_that("summariseDate work", {
  expect_equal(summariseData(data_total, date),
               data_total %>%
                 group_by(date) %>%
                 summarise(
                   "Confirmed"            = sum(confirmed, na.rm = T),
                   "Deceased"             = sum(deceased, na.rm = T),
                   "Estimated Recoveries" = sum(recovered, na.rm = T)
                 ) %>%
                 as_tibble()
  )
})
