#' Lint a single file
#'
#' Use `lintr::lint()` to _lint_ a single file
#'
#' @param path The file path.  Default (`NULL`) checks for the current file open
#'   in the source editor in **RStudio**.
#' @param linters Passed to `linters` argument in `lintr::lint()`; however,
#'   when passing a character vector, finds all linters with that tag.
#' @param ... Additional arguments passed to `lintr::lint()`
#' @param config Global configuration file; when `NA` does nothing
#' @returns See `lintr::lint()`
#' @export
.LintFile <- function(
    path = NULL,
    linters = "default",
    ...,
    config = Sys.getenv("LINTR_GLOBAL_CONFIG", NA)
) {
  fuj::require_namespace("lintr")

  if (!is.na(config)) {
    stopifnot(fs::file_exists(config))
    op <- options(lintr.linter_file = config)
    on.exit(options(op), add = TRUE)
  }

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
