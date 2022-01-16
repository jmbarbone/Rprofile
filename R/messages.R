
#' Utility messages
#'
#' This is exported only for use in `.Rprofile`
#'
#' @param msg The message code
#' @returns None, called for its side effects
#' @family Rprofile
#' @export
.UtilMessage <- function(msg) {
  switch(
    msg,
    source_rprofile = cat(crayon_cyan("Sourcing Rprofile/.Rprofile...\n")),
    stop("Not valid msg: ", msg)
  )

  invisible()
}
