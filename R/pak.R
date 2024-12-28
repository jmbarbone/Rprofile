#' Wrapper for `{pak::pak}`
#' 
#' @param ... Arguments passed to [pak::pak()].
#' @export
.Pak <- function(...) {
  fuj::require_namespace("pak")
  pak::pak(...)
}
