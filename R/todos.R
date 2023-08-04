#' TODOs and FIXMEs
#'
#' Get a list of TODOs and FIXMEs
#'
#' @description `.Todos()` and `.Fixmes()` default to recursively searching the
#'   path `"."` and can be changed with setting `path` in `...`.  `.TodosHere()`
#'   and `.FixmesHere()` try to search the active file, found with the use of
#'   `Rstudio`.
#'
#' @export
#' @param ... additional arguments pass to `mark::todos``
#' @param .quiet If `TRUE` doesn't print result
#' @param .space If `TRUE` adds another `"\n"` to the output
#' @return See `?mark::todos`
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

#' @rdname todos
#' @export
.TodosHere <- function(..., .quiet = FALSE) {
  do_todo_here("todo", ..., .quiet = FALSE)
}

#' @rdname todos
#' @export
.FixmesHere <- function(..., .quiet = FALSE) {
  do_todo_here("fixme", ..., .quiet = FALSE)
}


# helpers -----------------------------------------------------------------

do_todos <- function(type = c("todo", "fixme"), ..., .quiet = FALSE) {
  if (!requireNamespace("mark", quietly = TRUE)) {
    message("mark is not available")
    return(invisible())
  }

  type <- mark::match_param(type)
  fun <- switch(type, todo = mark::todos, fixme = mark::fixmes)
  todo <- try0(fun(...))

  if (
    !is.null(todo) &&
    !.quiet &&
    !inherits(todo, "try-error")
  ) {
    print(todo)
  }

  invisible(todo)
}

do_todo_here <- function(type = c("todo", "fixme"), ..., .quiet = FALSE) {
  requireNamespace("rstudioapi")
  stopifnot(interactive(), "path" %out% ...names())
  path <- rstudioapi::getSourceEditorContext()$path
  do_todos(type = type, path = path, ..., .quiet = .quiet)
}
