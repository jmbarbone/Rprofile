#' Get .Rprofile
#'
#' @param update If `TRUE` will copy the .Rprofile from the Rprofile package
#'   (defaults to the value of `overwrite`)
#' @param overwrite If `TRUE` and `update = TRUE` will overwrite .Rprofile if it
#'   exists; ignored if `update` is not `TRUE`
#' @family Rprofile
#' @export
.Rprofile <- function(update = overwrite, overwrite = FALSE) {
  file <- "~/.Rprofile"
  if (update) {
    on.exit(try(Sys.chmod(file, "200"), silent = TRUE), add = TRUE)
    rfile <- sf(".Rprofile", check = TRUE)
    file.copy(rfile, file, overwrite = overwrite, copy.date = TRUE)
  } else {
    file <- normalizePath(file, mustWork = TRUE)
    cat("Opening", file, "\n")
    shell.exec(file)
  }
}
