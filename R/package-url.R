#' Open package url
#'
#' @param pkg A character vector of package names
#' @returns Nothing, used for its side-effects
#' @export
.OpenPackageUrl <- function(pkg) {
  names(pkg) <- pkg
  invisible(lapply(pkg, do_open_pkg_url))
}

do_open_pkg_url <- function(x) {
  if (!requireNamespace(x, quietly = TRUE)) {
    msg <- sprintf("no installation found for {%s}", x)
    message(msg)
    return(NULL)
  }

  urls <- utils::packageDescription(x)$URL

  if (is.null(urls)) {
    msg <- sprintf("no URL found for {%s}", x)
    warning(msg, call. = FALSE)
    return(NULL)
  }

  urls <- strsplit(urls, ",[[:space:]]+")[[1]]
  urls <- unique(urls)
  lapply(urls, utils::browseURL)
  urls
}
