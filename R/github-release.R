#' Create a **GitHub** Release
#'
#' Wrapper for `usethis::use_github_release()`.
#'
#' @details When `prerelease` is `TRUE`, a facsimile of
#'   `usethis::use_github_release()` is employed to create a prerelease.  This
#'   assumes ...
#'   - the package is hosted on **GitHub**
#'   - the remote is named **origin**d
#'   - the branch is named **main**
#'   - the package has a **DESCRIPTION** file which contains an appropriate
#'   `Package` name and `Version`
#'   - you want to use the `generate_release_notes` feature of the
# nolint next: line_length_linter.
#'   [GitHub API](https://docs.github.com/en/rest/releases/releases?apiVersion=2022-11-28#create-a-release)
#'
#' @param publish Whether to publish the release or keep as a draft.  Default is
#'   `FALSE`.
#' @param prerelease Whether to create prerelease.  Default is `FALSE`.
#' @export
.GithubRelease <- function(publish = NULL, prerelease = NULL) {
  fuj::require_namespace("cli", "gh", "usethis")
  ask <- function() {
    if (!interactive()) {
      return(FALSE)
    }

    answer <- yes_no("Would you like to publish this release?", na = "CANCEL")

    if (is.na(answer)) {
      force_exit()
    }

    answer
  }

  force_exit <- function() {
    stop(fuj::new_condition("...", "forced_exit"))
  }


  if (is.null(prerelease)) {
    if (ask()) {
      prerelease <- yes_no("Is this a pre-release?")
    } else {
      prerelease <- FALSE
    }
  }

  prerelease <- isTRUE(prerelease)

  if (!prerelease) {
    fuj::require_namespace("usethis")
    return(tryCatch(
      usethis::use_github_release(publish = publish %||% ask()),
      forcedExitError = function(e) invisible(NULL)
    ))
  }

  # get all the fancy side effects of `usethis::use_github_release()` without
  # actually creating a release
  withCallingHandlers(
    .GithubRelease(publish = force_exit()),
    rlang_message = function(e) {
      # don't include not on publishing
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
      draft = !(publish %||% ask()),
      prerelease = TRUE,
      body = paste("Prerelease of", desc$Package),
      generate_release_notes = TRUE
    )
    cli::cli_text(sprintf("Release at {.url %s}", release$html_url))
    invisible(release)
  },
  forcedExitError = function(e) invisible(NULL))
}
