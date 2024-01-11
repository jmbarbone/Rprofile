#' Read the clipboard
#'
#' Reads the clipboard and returns the contents as a character vector or table
#'
#' @details Essentially wraps `clipr::read_clip()`
#'
#' @param method The method to use.
#' - `"auto"`: (default) Parses contents either into a vector and applies some
#'   conversion; if multiple lines are detected, attempts to parse as a table
#' - `"none"`: Returns the contents as a string
#' - `"some"`: Returns the contents as a character vector and performs some
#'   parsing to possibly convert to a vector
#' - `"data.frame"`: Returns the contents as a data frame (via `clipr::read_clip_tbl()`)
#' - `"tibble"`: Returns the contents as a tibble (via `clipr::read_clip_tbl()`)
#' @param ... Additional arguments passed to [utils::read.table()] (defaults
#'   have been changed)
#' @export
.ReadClip <- function(
    convert = c("auto", "none", "some", "data.frame", "tibble"),
    ...
) {
  read_table <- function(...) {
    requireNamespace("mark")
    params <- list(...)
    default <- list(
      header           = TRUE,
      sep              = "\t",
      row.names        = NULL,
      na.strings       = c("", "NA", "N/A", "#N/A"),
      check.names      = FALSE,
      stringsAsFactors = FALSE,
      encoding         = "UTF-8",
      comment.char     = "",
      blank.lines.skip = TRUE,
      fill             = TRUE,
      strip.white      = TRUE
    )
    params <- mark::merge_list(default, params, keep = "y")
    params$text <- text
    do.call(utils::read.table, params)
  }

  requireNamespace("clipr")
  switch(
    match.arg(convert),
    none = clipr::read_clip(allow_non_interactive = TRUE),
    some = scan(text = .ReadClip("none"), what = "character", quiet = TRUE),
    data.frame = read_table(.ReadClip("none"), ...),
    tibble = {
      requireNamespace("tibble")
      tibble::as_tibble(.ReadClip("data.frame", ...))
    },
    auto = {
      text <- .ReadClip("none")
      if (length(text) == 1) {
        utils::type.convert(
          scan(text = text, what = "character", quiet = TRUE),
          as.is = TRUE,
          na.strings = c("", "NA")
        )
      } else {
        read_table(text = text, ...)
      }
    }
  )
}
