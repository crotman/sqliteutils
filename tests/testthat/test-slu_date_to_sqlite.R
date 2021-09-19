test_that("slu_date_to_sqlite returns the date that would be stored on SQLIte", {

  n_dates <- 10000

  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

  dates <- sample( seq.Date(from = as.Date("1900-1-1"), to = as.Date("2100-1-1"), length.out = n_dates  ), size = n_dates, replace = FALSE)

  data <- data.frame(
    cod = 1:n_dates,
    date = dates
  )

  DBI::dbWriteTable(conn = con, name = "dates", value = data )

  data_from_bd <- dplyr::tbl(src = con, "dates") %>%  dplyr::collect()

  data_with_sqlite_dates <- data %>%
    dplyr::mutate(
      date = slu_date_to_sqlite(dates)
    )


  join <- data_from_bd %>%
    dplyr::inner_join(
      data_with_sqlite_dates,
      by = c("cod")
    ) %>%
    dplyr::mutate(
      equal = as.integer(round(date.x)) == date.y
    )

  expect_equal(object = join$date.x %>% round() %>% as.integer() , join$date.y )

  DBI::dbDisconnect(con)

})



