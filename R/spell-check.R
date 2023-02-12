
#' Spell check a file
#'
#' @param path A path to spell check; if `NULL` check the current file open in
#'   the RStudio editor
#' @export
.SpellCheckFile <- function(path = NULL) {
  requireNamespace("spelling")
  if (is.null(path)) {
    requireNamespace("rstudioapi")
    path <- rstudioapi::getSourceEditorContext()$path
  } else {
    path <- normalizePath(path, mustWork = TRUE)
  }

  spelling::spell_check_files(path)
}
