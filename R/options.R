#' Add options
#'
#' Adds options to `rprofile_env`
#'
#' @param ... options to set
#'
#' @family Rprofile
#' @export
.AddRprofileOptions <- function(...) {
  new <- list(...)
  opts <- names(new)

  if (length(new) == 0) {
    return()
  }

  if (is.null(opts) || any(opts == "")) {
    stop("All options must have a name")
  }

  for (i in seq_along(new)) {
    assign(
      opts[i],
      new[[i]],
      envir = rprofile$options
    )
  }

  options(as.list(rprofile$options))
}
