#' Remove global conflicts
#' 
#' Removes all objects from the global environment that are in conflict with
#' objects in that environment
#' 
#' @export
.RemoveGlobalConflicts <- function() {
  remove(list = conflicts(".GlobalEnv"))
}
