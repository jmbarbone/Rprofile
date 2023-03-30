#' Lint a single file
#'
#' Use `lintr::lint()` to _lint_ a single file
#'
#' @param path The file path.  Default (`NULL`) checks for the current file open
#'   in the source editor in **RStudio**.
#' @param linters Passed to `linters` argument in `lintr::lint()`; however,
#'   when passing a character vector, finds all linters with that tag.
#' @param ... Additional arguments passed to `lintr::lint()`
#' @returns See `lintr::lint()`
#' @export
.LintFile <- function(path = NULL, linters = "default", ...) {
  fuj::require_namespace("lintr")

  if (is.null(path)) {
    fuj::require_namespace("rstudioapi")
    path <- rstudioapi::getSourceEditorContext()$path
  }

  if (is.character(linters)) {
    linters <- lintr::available_linters(tags = linters)$linter
    linters <- fuj::set_names(linters)
    linters <- lapply(linters, get, pos = asNamespace("lintr"))
  }

  path <- normalizePath(path, .Platform$file.sep, mustWork = TRUE)
  lintr::lint(path, linters = linters,  ...)
}
