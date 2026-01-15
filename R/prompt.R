#' Git branch prompt
#'
#' Applies a formatted prompt based on the git branch
#'
#' @returns The new prompt, invisibly.
#' @export
.GitBranchPrompt <- function() {
  if (!requireNamespace("prompt", quietly = TRUE)) {
    cat("Package {prompt} is required for .GitBranchPrompt\n")
    return(invisible())
  }

  if (!prompt::is_git_dir()) {
    return(prompt::set_prompt("> "))
  }

  git_prompt <- function(...) {
    sprintf(
      "[%s%s%s] > ",
      prompt::git_branch(),
      prompt::git_dirty(),
      prompt::git_arrows()
    )
  }

  prompt::set_prompt(git_prompt)
}
