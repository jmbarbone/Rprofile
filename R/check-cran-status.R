#' Check Cran Status
#'
#' A wrapper
#'
#' @param email The email address to query CRAN
#' @seealso [dang::checkCRANStatus]
#' @export
.CheckCranStatus <- function(email = NULL) {
  op <- options(warn = -1) # get rid of warnings for now
  on.exit(options(op))

  if (!mark::package_available("dang")) {
    return(invisible())
  }

  if (is.null(email)) {
   email <- try(get_description_emails())
   if (inherits(email, "try-error")) {
     return(invisible())
   }
  }

  for (e in email) {
    cat("checking for", crayon_cyan(e), "\n")
    res <- try(dang::checkCRANStatus(e))
    if (!inherits(res, "try-error")) {
      return(invisible())
    }
  }

  stop("Failed to find cran status for:\n", paste0(email, collapse = "\n  "))
}

get_description_emails <- function() {
  pkg <- basename(normalizePath("."))

  authors <- suppressWarnings(utils::packageDescription(pkg))

  if (length(authors) == 1L && is.na(authors)) {
    stop("Package `", pkg, "` not found in installed", call. = FALSE)
  }

  authors <- authors$Authors # partial matching for Authors@R

  if (any(grepl("person", authors))) {
    authors <- gsub("(?<!utils::)person", "utils::person", authors, perl = TRUE)
    requireNamespace("utils", quietly = TRUE)
  }

  authors <- eval(parse(text = trimws(authors)))
  authors <- unclass(authors)
  unlist(lapply(authors, `[[`, "email"), use.names = FALSE)
}
