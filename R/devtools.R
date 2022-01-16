
#' Attach devtools
#'
#' Attached `devtools` without start up messages
#'
#' @returns None, called for its side effects
#' @export
#' @family Rprofile
.AttachDevtools <- function() {
  suppressPackageStartupMessages(library("devtools", character.only = TRUE))
  invisible()
}
