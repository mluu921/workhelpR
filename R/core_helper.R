#' @title Download data from the internal CSMC biostats catalog
#'
#' @description Download data from the internal CSMC biostats catalog. A CSMC internal username and password is required for functionality.
#'
#' @param username Internal CSMC username
#' @param password Internal CSMC password
#'
#' @examples download_biostats_catalog(username = 'johndoe', password = '123456')
#'
#' @export

download_biostats_catalog <- function(username = NULL, password = NULL) {
  `%>%` <- magrittr::`%>%`

  if (is.null(username)) {
    warning('Please enter CSMC username')
    stop()
  }

  if (is.null(password)) {
    warning('Please enter CSMC password')
    stop()
  }

  url <- 'https://apps.csmc.edu/project-catalog/login.htm'

  s <- rvest::html_session(url)

  filled_form <- s %>%
    rvest::html_form() %>%
    .[[2]] %>%
    rvest::set_values(., userName = username, password = password)

  s <- rvest::submit_form(s, filled_form)

  data_object <- s %>% rvest::jump_to(., 'excelformat.htm')

  data <- readr::read_tsv(data_object$response$content)

  data <- janitor::clean_names(data)

  data[,stringr::str_detect(names(data),'dt')] <- purrr::modify(data[,stringr::str_detect(names(data),'dt')], ~ lubridate::dmy(.x))

  return(data)
}




