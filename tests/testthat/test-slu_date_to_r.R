

test_that("slu_date_to_r returns the same date that was inserted", {

  n_dates <- 100000

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  dates <- sample( seq.Date(from = as.Date("1900-1-1"), to = as.Date("2090-1-1"), length.out = n_dates  ), size = n_dates, replace = FALSE)

  data <- data.frame(
    cod = 1:n_dates,
    date = dates
  )

  DBI::dbWriteTable(conn = con, name = "dates", value = data )

  data_from_bd <- dplyr::tbl(src = con, "dates") %>%  dplyr::collect()

  expect_equal(object = slu_date_to_r(data_from_bd$date), expected = dates )

  DBI::dbDisconnect(con)

})
