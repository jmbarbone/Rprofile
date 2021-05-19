#' Loads the pipe from magrittr
#'
#' @export
.LoadPipe <- function() {
  if (!"%>%" %in% ls(envir = globalenv())) {
    assign("%>%", magrittr::`%>%`, envir = globalenv(), inherits = TRUE)
  }
}
