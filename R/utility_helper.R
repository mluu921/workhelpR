
make_proj_folder <- function() {
  fs::dir_create('data')
  fs::dir_create('scripts')
  fs::dir_create('reports')
  fs::dir_create('figures')
  fs::dir_create('docs')
}
