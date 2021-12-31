#' TODOs and FIXMEs
#'
#' Get a list of TODOs and FIXMEs
#'
#' @export
#' @param ... additional arguments pass to [mark::todos]
#' @param .quiet If `TRUE` doesn't print result
#' @param .space If `TRUE` adds another `"\n"` to the output
#' @return See [mark::todos]
#' @name todos
.Todos <- function(..., .quiet = FALSE, .space = FALSE) {
  on.exit(if (.space) cat("\n"))
  do_todos("todo", ..., .quiet = .quiet)
}

#' @rdname todos
#' @export
.Fixmes <- function(..., .quiet = FALSE) {
  do_todos("fixme", ..., .quiet = .quiet)
}

do_todos <- function(type = c("todo", "fixme"), ..., .quiet = FALSE) {
  type <- mark::match_param(type)
  fun <- switch(type, todo = mark::todos, fixme = mark::fixmes)
  todo <- try(fun(...), silent = TRUE)
  if (!is.null(todo) && !.quiet && !inherits(todo, "try-error")) print(todo)
  invisible(todo)
}

