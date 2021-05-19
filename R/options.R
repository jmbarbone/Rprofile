#' Add options
#'
#' Adds options to `rprofile_env`
#'
#' @param ... options to set
#'
#' @export
.AddRprofileOptions <- function(...) {
  x <- get_rprofile()
  ls <- list(...)
  nm <- names(ls)

  for (i in seq_along(ls)) {
    x$op[[nm[i]]] <- ls[[i]]
  }

  options(x$op)
  assign_rprofile(x)
  invisible(NULL)
}
