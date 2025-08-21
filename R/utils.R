assign_ <- function(...) {
  ("base" %::% "assign")(...)
}

ls_global_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

sf <- function(...) {
  ("mark" %::% "make_sf")("Rprofile")(...)
}

.try <- function(expr) {
  tryCatch(expr, error = function(e) {
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
