
#' Attach devtools
#'
#' Attached `devtools` without start up messages
#'
#' @returns None, called for its side effects
#' @export
#' @family Rprofile
.AttachDevtools <- function() {
  mark::require_namespace("devtools")
  # cheating to not use base::require()
  suppressPackageStartupMessages(("base" %colons% "require")("devtools"))
  invisible()
}
