#' Create a **GitHub** Release
#'
#' Wrapper for `usethis::use_github_release()`.
#'
#' @details When `prerelease` is `TRUE`, a facsimile of
#'   `usethis::use_github_release()` is employed to create a prerelease.  This
#'   assumes ...
#'   - the package is hosted on **GitHub**
#'   - the remote is named **origin**
#'   - the branch is named **main**
#'   - the package has a **DESCRIPTION** file which contains an appropriate
#'   `Package` name and `Version`
#'   - you want to use the `generate_release_notes` feature of the
# nolint next: line_length_linter.
#'   [GitHub API](https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#create-a-release)
#'
#' @param publish,prerelease Whether this release should be published and if it
#'   should be tagged as a **prerelease**. When [missing()] will prompt during
#'   an [interactive()] session, otherwise defaults to `FALSE`
#' @export
.GithubRelease <- function(publish = NULL, prerelease = NULL) {
  fuj::require_namespace("cli", "gh", "usethis")

  force_exit <- function() {
    stop(fuj::new_condition("...", "forced_exit"))
  }

  if (missing(prerelease)) {
    if (interactive()) {
      prerelease <- yes_no("Is this a pre-release?")
    } else {
      prerelease <- FALSE
    }
  }

  if (missing(publish)) {
    if (interactive()) {
      publish <- yes_no("Would you like to publish this release?")
    } else {
      publish <- FALSE
    }
  }

  if (isFALSE(prerelease)) {
    fuj::require_namespace("usethis")
    return(tryCatch(
      usethis::use_github_release(publish = publish),
      forcedExitError = function(e) invisible(NULL)
    ))
  }

  # we don't want to evaluate `publish` until after
  # usethis::use_github_release() is called so that when we pass our intentional
  # error, it breaks during that function call
  publish <- isTRUE(publish)

  # get all the fancy side effects of `usethis::use_github_release()` without
  # actually creating a release
  withCallingHandlers(
    .GithubRelease(publish = force_exit(), prerelease = FALSE),
    rlang_message = function(e) {
      # don't include note on publishing
      if (grepl("Publish", conditionMessage(e), fixed = TRUE)) {
        tryInvokeRestart("muffleMessage")
      }
    },
    forcedExitError = function(e) {
      print("woo")
      invisible(NULL)
    }
  )

  desc <- as.list(as.data.frame(read.dcf("DESCRIPTION")))
  git_repo <- system2("git", c("remote", "get-url", "origin"), stdout = TRUE)
  extract <- function(pattern) {
    regmatches(git_repo, regexpr(pattern, git_repo, perl = TRUE))
  }

  owner <- extract("(?<=github\\.com\\/)[[:alnum:]]+(?=\\/[[:alnum:]]+)")
  repo <- extract("[[:alnum:]]+(?=\\.git$)")

  stopifnot(nzchar(owner), nzchar(repo))

  tryCatch({
    release <- gh::gh(
      sprintf("POST /repos/%s/%s/releases", owner, repo),
      name = paste(desc$Package, desc$Version),
      tag_name = paste0("v", desc$Version),
      target_commitish = "main",
      draft = isFALSE(publish %||% yes_no("Is this a draft?")),
      prerelease = TRUE,
      body = paste("Prerelease of", desc$Package),
      generate_release_notes = TRUE
    )
    cli::cli_text(sprintf("Release at {.url %s}", release$html_url))
    invisible(release)
  },
  forcedExitError = function(e) invisible(NULL))
}
