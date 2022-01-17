
#' Attach devtools
#'
#' Attached `devtools` without start up messages
#'
#' @returns None, called for its side effects
#' @export
#' @family Rprofile
.AttachDevtools <- function() {
  mark::require_namespace("devtools")
  # mimics cli::cli_inform()
  cat(crayon_cyan("i"), " Loading ", crayon_blue("devtools"), "\n", sep = "")
  # cheating to not use base::require()
  suppressPackageStartupMessages(("base" %colons% "require")("devtools"))
  invisible()
}
