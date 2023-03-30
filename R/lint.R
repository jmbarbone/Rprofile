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
.LintFile <- function(path = NULL, linters = NULL, ...) {
  fuj::require_namespace("lintr")

  if (is.null(path)) {
    fuj::require_namespace("rstudioapi")
    path <- rstudioapi::getSourceEditorContext()$path
  }

  if (is.null(linters) && file.exists(".lintr") && getOption("verbose")) {
    message("Presumably reading from .lintr")
    writeLines(readLines(".lintr"))
  } else if (is.character(linters)) {
    linters <- lintr::linters_with_tags(linters)
  }

  path <- normalizePath(path, .Platform$file.sep, mustWork = TRUE)
  lintr::lint(path, linters = linters,  ...)
}
