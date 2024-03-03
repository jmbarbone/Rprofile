
#' Attach devtools
#'
#' Attached `devtools` without start up messages
#'
#' @returns None, called for its side effects
#' @export
#' @family Rprofile
.AttachDevtools <- function() {
  invisible(c(
    usethis =
      suppressPackageStartupMessages(("base" %colons% "require")("usethis")),
    devtools =
      suppressPackageStartupMessages(("base" %colons% "require")("devtools"))
  ))
}
