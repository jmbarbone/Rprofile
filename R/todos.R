#' TODOs and FIXMEs
#'
#' Get a list of TODOs and FIXMEs
#'
#' @export
#' @return See [mark::todos]
#' @name todos
.Todos <- function() {
  mark::todos()
}

#' @rdname todos
#' @export
.Fixmes <- function() {
  mark::fixmes()
}
