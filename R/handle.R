#' Global handle
#'
#' See [rlang::global_handle()]
#'
#' @export
.GlobalHandle <- function() {
  fuj::require_namespace("rlang")
  rlang::global_handle()
}
