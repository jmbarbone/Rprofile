#' Check Cran Status
#'
#' A wrapper
#'
#' @param email The email address to query CRAN
#' @seealso [dang::checkCranStatus]
#' @export
.CheckCranStatus <- function(email = NULL) {
  if (!mark::package_available("dang")) {
    return(invisible())
  }

  if (is.null(email)) {
    authors <- packageDescription(basename(normalizePath(".")))[["Authors@R"]]
    authors <- eval(parse(text = trimws(authors)))
    authors <- unclass(authors)
    email <- sapply(authors, `[[`, "email")
  }

  for (e in email) {
    res <- try(dang::checkCRANStatus(e), silent = TRUE)
    if (!inherits(res, "try-error")) {
      return(invisible())
    }
  }

  stop("Failed to find cran status for:\n", paste0(emails, collapse = "\n  "))
}
