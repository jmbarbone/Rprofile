#' Git branch prompt
#'
#' Applies a formatted prompt based on the git branch
#'
#' @export
.GitBranchPrompt <- function() {
  mark::require_namespace("prompt")
  branch <- prompt::prompt_git()

  if (branch != getOption("prompt", "> ") & branch != "> ") {
    branch_prompt <- paste0("[", sub(" >", "] >", branch))
    prompt::set_prompt(branch_prompt)
  }

  invisible(NULL)
}
