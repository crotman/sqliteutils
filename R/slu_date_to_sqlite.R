#' Converts dates to the numeric values as which they would be stored on SQLite
#'
#' @param date_r dates as returned by as.Date() in R
#'
#' @return integers that correspond to the numbers that are stored on SQLite when `DBI:dbWriteTable` is used
#' @export
#'
#' @examples
#'
#' con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
#' data <- data.frame(
#'     date = as.Date("2021-09-19")
#' )
#' DBI::dbWriteTable(conn = con, name = "dates", value = data )
#' data_from_bd <- dplyr::tbl(src = con, "dates") %>%  dplyr::collect()
#' data_with_sqlite_dates <- data %>%
#' dplyr::mutate(
#'     date = slu_date_to_sqlite(date)
#' )
#' print(data_from_bd)
#' print(data_with_sqlite_dates)
#' DBI::dbDisconnect(con)
#'
#'
slu_date_to_sqlite <- function(date_r){
  as.integer(round((date_r - as.Date("1970-1-1"))))}

