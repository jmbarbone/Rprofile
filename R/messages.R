#' Utility messages
#'
#' This is exported only for use in `.Rprofile`
#'
#' @param msg The message code
#' @returns None, called for its side effects
#' @family Rprofile
#' @export
.UtilMessage <- function(msg) {
  switch(
    msg,
    source_rprofile = cat(crayon_cyan("Sourcing Rprofile/.Rprofile...\n")),
    stop("Not valid msg: ", msg)
  )

  invisible()
}

#' Adds a nice message to the start
#'
#' @param x A vector of integers to select from.  If the package isn't available
#'   another random message is generated -- or not
#' @param space if `TRUE` adds another `"\n"` to the output
#'
#' @family Rprofile
#' @export
.NiceMessage <- function(x = 1:2, space = TRUE) {
  on.exit(if (space) cat("\n"))
  if (length(x) == 0L) return(invisible())
  x <- as.integer(x)

  switch(
    sample(x, 1),
    `1` = cat_praise(),
    `2` = cat_fortune()
  )
}

cat_praise <- function() {
  requireNamespace("praise")
  cat(crayon_yellow(praise::praise()), "\n")
}

cat_fortune <- function() {
  requireNamespace("fortunes")
  # setting width high as it is adjusted later
  x <- paste(utils::capture.output(fortunes::fortune(width = 1000)))
  x <- x[seq_along(x[-1])[-1]]
  x <- paste0(x, "\n")
  cat(crayon_yellow(x))
}
