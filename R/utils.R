
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

check_rprofile <- function() {
  if (!exists("rprofile_env", envir = globalenv(), mode = "environment")) {
    stop("rprofile_env is not found", call. = FALSE)
  }
}

assign_ <- function(...) {
  ("base" %colons% "assign")(...)
}

get_rprofile <- function() {
  get0("rprofile_env", envir = globalenv(), mode = "environment")
}

assign_rprofile <- function(x) {
  try(assign_("rprofile_env", x, envir = globalenv()))
}

ls_global_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

sf <- function(...) {
  ("mark" %colons% "make_sf")("Rprofile")(...)
}
