#' Lint a single file
#'
#' Use `lintr::lint_dir()` to _lint_ a single file
#'
#' @param path The file path.  Default (`NULL`) checks for the current file open
#'   in the source editor in **RStudio**.
#' @returns See `lintr::lint_dir()`
#' @export
.LintFile <- function(path = NULL) {
  fuj::require_namespace("lintr")

  if (is.null(path)) {
    fuj::require_namespace("rstudioapi")
    path <- rstudioapi::getSourceEditorContext()$path
  }

  path <- normalizePath(path, .Platform$file.sep, mustWork = TRUE)
  dir <- dirname(path)
  exclude_files <- list.files(dir, recursive = TRUE)
  exclude_files <- setdiff(exclude_files, basename(path))
  lintr::lint_dir(dir, exclusions = exclude_files)
}
