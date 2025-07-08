#' Attach devtools
#'
#' Attached `devtools` without start up messages
#'
#' @returns None, called for its side effects
#' @export
#' @family Rprofile
.AttachDevtools <- function() {
  req <- function(x) {
    suppressPackageStartupMessages(("base" %:::% "require")(x))
  }

  invisible(c(
    usethis = req("usethis"),
    devtools = req("devtools"),
  ))
}
