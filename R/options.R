#' Add options
#'
#' Adds options to `rprofile_env`
#'
#' @param ... options to set
#'
#' @export
.AddRprofileOptions <- function(...) {
  x <- get_rprofile()
  new <- c(x$op, list(...))
  # unique() drops names
  x$op <-  new[!duplicated(new, fromLast = TRUE)]
  options(x$op)
  assign_rprofile(x)
  invisible(NULL)
}
