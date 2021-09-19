
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sqliteutils

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/sqliteutils)](https://CRAN.R-project.org/package=sqliteutils)
<!-- badges: end -->

The goal of sqliteutils is to provide utility functions to deal with
SQLite

## Installation

You can install sqliteutils from [Github](https://github.com) with:

``` r
devtools::install_github("crotman/sqliteutils")
```

## Example

SQLIte does not have a date type. When you insert dates in a SQLIte table using `DBI::dbWriteTable()`, for instance, they are converted to a numeric value.

Using `slu_date_to_r()` you can convert the value back to the original date.

``` r
library(sqliteutils)

data <- data.frame(date = c(as.Date("2021-09-18"), as.Date("2021-09-19"))
con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
DBI::dbWriteTable(conn = con, name = "dates", value = data )
data_from_bd <- DBI::dbReadTable(conn = con, name = "dates")
original_date <- slu_date_to_r(data_from_bd$date)
DBI::dbDisconnect(con)

print(original_date)

```

using `slu_date_to_sqlite()` you can make the inverse: convert a date to the number SQLite would store it if we called `DBI::dbWriteTable()`

``` r
con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
data <- data.frame(
  date = c(as.Date("2021-09-19"), as.Date("2021-09-20"))
)
DBI::dbWriteTable(conn = con, name = "dates", value = data )
data_from_bd <- dplyr::tbl(src = con, "dates") %>%  dplyr::collect()
data_with_sqlite_dates <- data %>%
dplyr::mutate(
  date = slu_date_to_sqlite(date)
)
DBI::dbDisconnect(con)

print(data_from_bd)
print(data_with_sqlite_dates)



```








