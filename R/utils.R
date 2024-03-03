`%||%` <- function(x, y) {
  if (is.null(x)) y else x
}

`%colons%` <- function(package, name) {
  # poor copy of fuj::`%colons%`
  stopifnot(
    length(package) == 1,
    is.character(package),
    length(name) == 1, is.character(name)
  )

  requireNamespace(package)
  get(name, envir = asNamespace(package))
}

`%out%` <- function(...) { ("fuj" %colons% "%out%")(...) }
`%wo%` <- function(...) { ("fuj" %colons% "%wo%")(...) }

assign_ <- function(...) {
  ("base" %colons% "assign")(...)
}

ls_global_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

sf <- function(...) {
  ("mark" %colons% "make_sf")("Rprofile")(...)
}

.try <- function(expr) {
  tryCatch(expr, error = force)
}
