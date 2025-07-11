#' Open (as) File
#'
#' Open a file path or data as a file
#'
#' @param x A object.  If an existing file path, runs with `xopen::xopen`.
#' @param ... Not used
#' @return The path to the open file
#' @export
#' @name OpenFile
.OpenFile <- function(x, ...) {
  UseMethod(".OpenFile")
}

#' @export
#' @rdname OpenFile
.FileOpen <- .OpenFile

#' @export
#' @param force If `TRUE` ignores potential file path in `x`
#' @rdname OpenFile
.OpenFile.default <- function(x, force = FALSE, ...) {
  if (!force && isTRUE(.try(file.exists(x)))) {
    x <- normalizePath(x, "/")
    fuj::require_namespace("xopen")
    xopen::xopen(x)
    return(x)
  }

  fuj::require_namespace("readr")
  op <- options(readr.show_progress = FALSE)
  on.exit(options(op), add = TRUE)

  x <- as.character(x)
  tempfile <- tempfile(fileext = ".txt")
  readr::write_lines(x, tempfile)
  .OpenFile(tempfile)
}

#' @export
#' @rdname OpenFile
.OpenFile.data.frame <- function(x, ...) {
  fuj::require_namespace("readr")
  op <- options(readr.show_progress = FALSE)
  on.exit(options(op), add = TRUE)

  tempfile <- tempfile(fileext = ".csv")
  readr::write_csv(x, tempfile)
  .OpenFile(tempfile)
}

#' @export
#' @rdname OpenFile
.OpenFile.matrix <- function(x, ...) {
  .OpenFile(as.data.frame(x))
}
