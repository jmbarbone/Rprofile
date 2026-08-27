assign_ <- function(...) {
  ("base" %::% "assign")(...)
}

ls_global_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

sf <- function(...) {
  reset_namespaces(("mark" %::% "make_sf")("Rprofile")(...))
}

.try <- function(expr) {
  tryCatch(expr, error = \(e) {
    invisible(structure(list(condition = e), class = "rprofile_error"))
  })
}

yes_no <- function(..., na = NULL) {
  # basically a rewrite of yesno::yesno()
  msg <- paste0(..., collapse = "")
  yes <- c("Yes", "You betcha", "Certainly", "Absolutely", "Of course")
  no <- c(
    "No",
    "Absolutely not",
    "Certainly not",
    "No way",
    "Not a chance",
    "Let me think about it",
    "Not sure",
    "I don't know"
  )

  choices <- c(
    sample(c(sample(yes, 1), sample(no, 2))),
    if (length(na)) sample(na, 1)
  )

  res <- utils::menu(title = msg, choices = choices)
  if (res == 0) {
    return(NA)
  }

  res <- choices[res]

  if (res %in% yes) {
    return(TRUE)
  }

  if (res %in% no) {
    return(FALSE)
  }

  NA
}

is_rprofile_error <- function(x) {
  inherits(x, "rprofile_error")
}

match_arg <- function(...) {
  reset_namespaces({
    expr <- substitute(fuj::match_arg(...))
    eval.parent(expr)
  })
}

# copied from fuj
`%out%` <- function(x, table) match(x, table, nomatch = 0L) == 0L
`%wo%` <- function(x, table) x[x %out% table]
`%::%` <- function(package, name) getExportedValue(asNamespace(package), name)

defer <- function(expr, frame = parent.frame(), after = FALSE) {
  thunk <- as.call(list(function() expr))
  do.call(on.exit, list(thunk, TRUE, after), envir = frame)
}

collapse <- function(..., sep = "") {
  paste0(unlist(...), collapse = sep)
}

is_windows <- function() {
  Sys.info()[["sysname"]] == "Windows"
}
