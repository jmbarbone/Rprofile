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
  requireNamespace("fs")

  if (update) {
    on.exit(try(fs::file_chmod(file, "777"), silent = TRUE), add = TRUE)
    rfile <- sf("dot-Rprofile.R", check = TRUE)
    fs::file_copy(rfile, file, overwrite = overwrite)
  } else {
    file <- fs::path_norm(file)
    stopifnot(fs::file_exists(file))
    cat("Opening", file, "\n")
    utils::file.edit(file)
  }
}
