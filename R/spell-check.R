#' Spell check a file
#'
#' @param path A path to spell check; if `NULL` check the current file open in
#'   the RStudio editor
#' @export
.SpellCheckFile <- function(path = NULL) {
  fuj::require_namespace("spelling")
  if (is.null(path)) {
    fuj::require_namespace("rstudioapi")
    path <- rstudioapi::getSourceEditorContext()$path
  } else {
    path <- normalizePath(path, mustWork = TRUE)
  }

  spelling::spell_check_files(path)
}
