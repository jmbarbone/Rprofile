#' Create a personal package library
#'
#' @export
.UsePackageLibrary <- function() {
  require_namespace("here")
  here <- reset_namespaces(here::here())
  lib <- file.path("~", "R", paste0(basename(here), "-library"))
  lib <- normalizePath(lib, "/", FALSE)
  .libPaths(c(lib, .libPaths()))
}
