#' Global handle
#'
#' See `rlang::global_handle()`
#'
#' @export
.GlobalHandle <- function() {
  reset_namespaces(rlang::global_handle())
}
