#' Get .Rprofile
#'
#' @param update If `TRUE` will copy the .Rprofile from the Rprofile package
#' @param overwrite if attempting to update, also overwrite
#' @export
.Rprofile <- function(update = FALSE, overwrite = FALSE) {
  file <- "~/.Rprofile"
  if (update) {
    rfile <- sysfile(".Rprofile", check = TRUE)
    file.copy(rfile, file, overwrite = overwrite, copy.date = TRUE)
  } else {
    shell.exec(normalizePath(file, mustWork = TRUE))
  }
}

sysfile <- function(..., check = FALSE) {
  system.file(..., package = "Rprofile", mustWork = check)
}
