#' Add URLs to NEWS
#'
#' Include links to github on `NEWS.md`
#'
#' @param path The path to your package
#' @param ask Prompts updating `NEWS.md`
#' @param url Optional URL to set for bug reports
#' @returns Nothing, called for its side effects
#' @export
.NewsUrls <- function(path = ".", ask = interactive(), url = NULL) {
  stopifnot(length(path) == 1, is.character(path))

  path0 <- path

  if (is.null(url)) {
    url <- get_desc_url(path)
  }

  if (dir.exists(path)) {
    path <- "NEWS.md"
  }

  if (!file.exists(path)) {
    stop("Path not found: ", path)
  }

  x <- readLines(path)
  m <- regexpr("\\[\\#[0-9]+\\](?!\\(https)", x, perl = TRUE)
  mtext <- regmatches(x, m)

  regmatches(x, m) <- sprintf("%s(%s)", mtext, paste0(url, gsub("[^0-9]", "", mtext)))
  writeLines(path)
  writeLines(paste("| ", x))

  if (!isFALSE(ask)) switch(
    utils::menu(
      title = "\nOkay to update?",
      choices = c("yeah, sure", "no ..."
      )
    ),
    `1` = message("cool"),
    `2` = return(invisible())
  )

  writeLines(x, path)

  if (requireNamespace("urlchecker", quietly = TRUE)) {
    message("running urlchecker::url_check()")
    try(urlchecker::url_check(path = path0, progress = FALSE))
  }

  invisible()
}

get_desc_url <- function(x = ".") {
  path <- file.path(x, "DESCRIPTION")

  if (!file.exists(path)) {
    stop("DESCRIPTION not found")
  }

  desc <- as.list(as.data.frame(read.dcf(path)))
  url <- desc$URL

  if (is.null(url)) {
    stop("couldn't get URL from DESCRIPTION")
  }

  gh <- lapply(
    list(
      desc[["URL"]],
      desc[["URLs"]],
      desc[["BugReports"]]
    ),
    reg_extract_gh_account
  )

  gh <- unique(unlist(gh))
  n <- length(gh)

  if (n == 0) {
    stop("could not find github account name")
  }

  if (n > 2) {
    warning("multiple accounts detected from URLs.  Using first.")
    gh <- gh[1]
  }

  sprintf("https://github.com/%s/%s/issues/", gh, desc[["Package"]])
}

reg_extract_gh_account <- function(urls) {
  pattern_gh1 <- "(?<=github\\.com\\/)[[:alnum:]]+(?=\\/[[:alnum:]]+)"
  pattern_gh2 <- "(?<=\\/\\/)[[:alnum:]]+(?=\\.github\\.io\\/[[:alnum:]]+)"
  pattern <- paste0(pattern_gh1, "|", pattern_gh2)
  m <- gregexpr(pattern, urls, perl = TRUE)
  unique(unlist(regmatches(urls, m)))
}
