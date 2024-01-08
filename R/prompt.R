#' Git branch prompt
#'
#' Applies a formatted prompt based on the git branch
#'
#' @returns The new prompt, invisibly.
#' @export
.GitBranchPrompt <- function() {
  if (!require_namespace("prompt")) {
    message("prompt not available")
    return(invisible())
  }

  branch <- prompt::prompt_git()
  prompt <- getOption("prompt")

  if (branch != getOption("prompt", "> ") & branch != "> ") {
    prompt <- paste0("[", sub(" >", "] >", branch))
    prompt::set_prompt(prompt)
  }

  invisible(prompt)
}
