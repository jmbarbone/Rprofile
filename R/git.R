#' Git prepare commit message
#'
#' Copies one of two git message preparation templates
#'
#'
#' @param path The path directory of your package (with a `.git` folder inside)
#' @param method One of the following (see details for more info): `github`,
#'   `jira`, `github-start`, `github-end`, `jira-start`, `jira-end`.  The
#'   `github` versions looks for numeric starts to a branch name, and then
#'   either appends the branch number to the beginning of the message with an
#'   octothorp (e.g., 123-branch appends "#123 ") or at the end, wrapped in
#'   parenthesis.  The `jira` version looks for the alphanumeric code value of a
#'   ticket and appends that with square brackets (e.g., ABC-123 appends
#'   "\[ABC-123\] ") to the start or the end.  Appending to the _end_ is the
#'   default functionality got `github` but appending to the _start_ is the
#'   default for `jira`.
#' @param overwrite If `TRUE`, overwrites the `.git/hooks/prepare-commit-msg`
#'   file, if it exists (passed to `fs::file_copy`)
#'
#' @export
.GitPrepareCommitMsg <- function(
    path = ".",
    method = c("github", "jira", "github-start", "github-end", "jira-start", "jira-end"),
    overwrite = FALSE
) {
  requireNamespace("mark")
  requireNamespace("fs")

  wd <- getwd()
  on.exit(setwd(wd))
  setwd(path)

  method <- mark::match_param(method)
  switch(
    method,
    github = {
      method <- "github-end"
    },
    jira = {
      method <- "jira-start"
    }
  )

  file <- sprintf("prepare-commit-msg-%s.sh", method)
  old <- system.file(file, package = "Rprofile", mustWork = TRUE)

  if (!fs::dir_exists(".git")) {
    stop("no .git directory found", .call = FALSE)
  }

  hook_dir <- fs::path(".git", "hooks")
  fs::dir_create(hook_dir)
  new <- fs::path(hook_dir, "prepare-commit-msg")
  cat("Copying files...\n  old  ", old, "\n  new  ", new, "\n", sep = "")
  fs::file_copy(old, new, overwrite = isTRUE(overwrite))
  fs::file_chmod(new, "777")

  if (fuj::is_windows()) {
    # specifically for the GitHub desktop app
    writeLines(c("#!/usr/bin/env sh", readLines(new)[-1]), new)
  }

  if (fs::file_access(new, mode = "execute")) {
    writeLines(crayon_green("Success"))
  } else {
    writeLines(crayon_red("Failure"))
  }
}
