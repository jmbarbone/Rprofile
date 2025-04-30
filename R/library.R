#' Create a personal package library
#'
#' @export
.UsePackageLibrary <- function() {
  fuj::require_namespace("here")
  lib <- file.path("~", "R", paste0(basename(here::here()), "-library"))
  lib <- normalizePath(lib, "/", FALSE)
  .libPaths(c(lib, .libPaths()))
}
