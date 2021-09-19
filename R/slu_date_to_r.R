#' Converts dates stored on SQLIte to their original values
#'
#' @param date_sqlite the numbers that result from inserting dates on SQLite
#'
#' @return the dates that were originally inserted
#' @export
#'
#' @examples
#' data <- data.frame(date = as.Date("2021-09-18"))
#' con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
#' DBI::dbWriteTable(conn = con, name = "dates", value = data )
#' data_from_bd <- DBI::dbReadTable(conn = con, name = "dates")
#' original_date <- slu_date_to_r(data_from_bd$date)
#' DBI::dbDisconnect(con)
#'
slu_date_to_r <- function(date_sqlite){
  date_sqlite + as.Date("1970-1-1")
}

