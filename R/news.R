#' Add URLs to NEWS
#'
#' Include links to github on `NEWS.md`
#'
#' @details URLs are detected for GitHub issue.  For example, a line with "Fixes
#'   bug \[#123\]" will append the URL for the issue number 123.  The repository
#'   is picked up from the `DESCRIPTION` file.
#'
#' @param path The path to your package
#' @param ask Prompts updating `NEWS.md`
#' @param url Optional URL to set for bug reports
#' @returns Nothing, called for its side effects
#' @export
.NewsUrls <- function(
    path = ".",
    ask = interactive(),
    url = get_desc_url(path)
) {
  stopifnot(
    length(path) == 1,
    is.character(path),
    dir.exists(path)
  )

  news <- file.path(news, "NEWS.md")

  if (!file.exists(news)) {
    stop("NEWS.md not found: ", news)
  }

  force(url)
  old_copy <- new_copy <- old <- new <- readLines(news)
  m <- regexpr("\\[\\#[0-9]+\\](?!\\(https)", old, perl = TRUE)
  if (all(m == -1L)) {
    message("no URLs detected")
    return(invisible())
  }

  mtext <- regmatches(old, m)
  regmatches(old_copy, m) <- crayon_yellow(mtext)
  regmatches(new, m) <- sprintf("%s(%s)", mtext, paste0(url, gsub("[^0-9]", "", mtext)))
  regmatches(new_copy, m) <- crayon_cyan(sprintf("%s(%s)", mtext, paste0(url, gsub("[^0-9]", "", mtext))))
  lines <- which(m > 0)
  labels <- sprintf("[%s]: ", format(lines))
  cat(crayon_yellow("OLD\n"))
  cat(old_copy[lines], fill = TRUE, labels = labels)
  cat(crayon_cyan("\nNEW\n"))
  cat(new_copy[lines], fill = TRUE, labels = labels)

  if (!isFALSE(ask)) {
    switch(
      utils::menu(
        title = "\nOkay to update?",
        choices = c("yeah, sure", "no ..."
        )
      ),
      `1` = message("cool"),
      `2` = return(invisible())
    )
  }

  if (requireNamespace("urlchecker", quietly = TRUE)) {
    message("running urlchecker::url_check()")
    temp <- tempfile()
    on.exit(file.remove(temp))
    writeLines(new, temp)
    .try(urlchecker::url_check(path = temp, progress = FALSE))
  }

  writeLines(new, news)
}

get_desc_url <- function(x = ".") {
  path <- file.path(x, "DESCRIPTION")

  if (!file.exists(path)) {
    stop("DESCRIPTION not found")
  }

  # directly grabbing from read.dcf("DESCRIPTION")[, "URL"] may result in errors
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
