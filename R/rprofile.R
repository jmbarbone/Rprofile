#' Get .Rprofile
#'
#' @returns
#' * `.Rprofile()` The `.Rprofile()` path, invisibly
#' @family Rprofile
#' @name Rprofile-file
NULL

#' @export
#' @rdname Rprofile-file
#' @param update If `TRUE` will copy the .Rprofile from the Rprofile package
#'   (defaults to the value of `overwrite`)
#' @param overwrite If `TRUE` and `update = TRUE` will overwrite .Rprofile if it
#'   exists; ignored if `update` is not `TRUE`
#' @param path The file location of your `.Rprofile`
.Rprofile <- function(
    update = overwrite,
    overwrite = FALSE,
    path = .FindRprofile()
) {
  requireNamespace("fs")
  stopifnot(is.character(path), length(path) == 1)
  old_path <- fs::path_expand_r(path)
  old_path <- fs::path_norm(old_path)

  if (update) {
    on.exit(try0(fs::file_chmod(old_path, "777")), add = TRUE)
    new_path <- sf("dot-Rprofile.R", check = TRUE)
    fs::file_copy(new_path, old_path, overwrite = overwrite)
  } else {
    if (!fs::file_exists(old_path)) {
      stop(
        sprintf(".Rprofile not found: %s (%s)", old_path, path),
        call. = FALSE
      )
    }

    cat("Opening", old_path, "\n")
    utils::file.edit(old_path)
    invisible(old_path)
  }
}

#' @export
#' @rdname Rprofile-file
#' @param quiet If `TRUE` silences messages, otherwise provides information
#'   about the location of `.Rprofile`
#' @returns
#' * `.FindRprofile()` (hopefully) a path to your `.Rprofile`
.FindRprofile <- function(quiet = FALSE) {
  msg <- if (quiet) {
    function(...) invisible()
  } else {
    match.fun("message")
  }

  path <- getOption("rprofile.rprofile")

  if (!is.null(path)) {
    msg("using .Rprofile from options")
    return(path)
  }

  path <- Sys.getenv("R_PROFILE", NA)
  if (!is.na(path)) {
    msg("using .Rprofile from envvar R_PROFILE")
    return(path)
  }

  msg("using default ~/.Rprofile")
  "~/.Rprofile"
}
