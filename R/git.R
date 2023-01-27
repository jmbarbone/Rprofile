#' Git prepare commit message
#'
#' Copies one of two git message preparation templates
#'
#' @param path The path directory of your package (with a `.git` folder inside)
#' @param method Either `"github"` or `"jira"`.  The `github` version looks for
#'   numeric starts to a branch name, and then appends that to the beginning of
#'   the message with an octothorp (e.g., 123-branch appends "#123 ").  The
#'   `jira` version looks for the alphanumeric code value of a ticket and
#'   appends that with square brackets (e.g., ABC-123 appends "\[ABC-123\] ").
#' @param overwrite If `TRUE`, overwrites the `.git/hooks/prepare-commit-msg`
#'   file, if it exists (passed to `fs::file_copy`)
#'
#' @export
.GitPrepareCommitMsg <- function(
    path = ".",
    method = c("github", "jira"),
    overwrite = FALSE
) {
  requireNamespace("mark")
  requireNamespace("fs")

  wd <- getwd()
  on.exit(setwd(wd))
  setwd(path)

  method <- mark::match_param(method)
  file <- sprintf("prepare-commit-msg-%s.sh", method)
  old <- system.file(file, package = "Rprofile", mustWork = TRUE)

  if (!fs::dir_exists(".git")) {
    stop("no .git directory found", .call = FALSE)
  }

  hook_dir <- fs::path(".git", "hooks")
  fs::dir_create(hook_dir)
  new <- fs::path(hook_dir, "prepare-commit-msg")
  cat("Copying files...\n  old  ", old, "\n  new  ", new, "\n", sep = "")

  if (isTRUE(fs::file_copy(old, new, overwrite = isTRUE(overwrite)))) {
    fs::file_chmod(new, "+x")
    writeLines(crayon_green("Success"))
  } else {
    writeLines(crayon_red("Failure"))
  }
}
