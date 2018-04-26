
make_proj_folder <- function() {
  fs::dir_create('data')
  fs::dir_create('scripts')
  fs::dir_create('reports')
  fs::dir_create('figures')
  fs::dir_create('docs')
}



clean_names_to_file <- function (string,
                                 case = c(
                                   "snake",
                                   "lower_camel",
                                   "upper_camel",
                                   "screaming_snake",
                                   "lower_upper",
                                   "upper_lower",
                                   "all_caps",
                                   "small_camel",
                                   "big_camel",
                                   "old_janitor",
                                   "parsed",
                                   "mixed"
                                 ))
{
  case <- match.arg(case)

  old_names <- string
  new_names <- old_names %>% gsub("'", "", .) %>% gsub("\"",
                                                       "", .) %>% gsub("%", ".percent_", .) %>% gsub("#", ".number_",
                                                                                                     .) %>% gsub("^[[:space:][:punct:]]+", "", .) %>% make.names(.) %>%
    snakecase::to_any_case(
      case = case,
      sep_in = "\\.",
      transliterations = c("Latin-ASCII"),
      parsing_option = 4
    )

  return(new_names)
}
