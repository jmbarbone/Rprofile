#' Check Cran Status
#'
#' A wrapper
#'
#' @param email The email address to query CRAN
#' @seealso [dang::checkCRANStatus]
#' @export
.CheckCranStatus <- function(email = NULL) {
  if (!mark::package_available("dang")) {
    return(invisible())
  }

  if (is.null(email)) {
   email <- get_description_emails()
  }

  for (e in email) {
    res <- try(dang::checkCRANStatus(e), silent = TRUE)
    if (!inherits(res, "try-error")) {
      return(invisible())
    }
  }

  stop("Failed to find cran status for:\n", paste0(email, collapse = "\n  "))
}

get_description_emails <- function() {
  authors <- utils::packageDescription(basename(normalizePath(".")))
  authors <- authors[["Authors@R"]]

  if (any(grepl("person", authors))) {
    require("utils", quietly = TRUE)
  }

  authors <- eval(parse(text = trimws(authors)))
  authors <- unclass(authors)
  unlist(lapply(authors, `[[`, "email"), use.names = FALSE)
}
