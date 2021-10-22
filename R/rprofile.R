#' Get .Rprofile
#'
#' @param update If `TRUE` will copy the .Rprofile from the Rprofile package
#'   (defaults to the value of `overwrite`)
#' @param overwrite If `TRUE` and `update = TRUE` will overwrite .Rprofile if it
#'   exists; ignored if `update` is not `TRUE`
#' @export
.Rprofile <- function(update = overwrite, overwrite = FALSE) {
  file <- "~/.Rprofile"
  if (update) {
    rfile <- sysfile(".Rprofile", check = TRUE)
    file.copy(rfile, file, overwrite = overwrite, copy.date = TRUE)
  } else {
    shell.exec(normalizePath(file, mustWork = TRUE))
  }
}