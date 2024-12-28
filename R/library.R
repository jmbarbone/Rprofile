#' Create a personal package library
#' 
#' @export
.UsePackageLibrary <- function() {
  fuj::require_namespace("here")
  lib <- file.path("~", paste0(basename(here::here()), "-library"))
  lib <- normalizePath(lib, "/", FALSE)
  dir.create(lib, showWarnings = FALSE, recursive = TRUE)
  .libPaths(c(lib, .libPaths()))
}
