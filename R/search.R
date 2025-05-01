#' Search print
#'
#' A more colorful way of printing [search()]
#'
#' @param pattern A regular expression to search for in the search path
#' @export
#' @returns Nothing, called for its side-effects
#' @family Rprofile
.Search <- function(pattern = ".") {
  x <- paste0(format(grep(pattern, search(), value = TRUE)), " ")
  n <- length(x)

  res <-
    if (n <= 2) {
      paste0(x, collapse = "")
    } else {
      nc <- nchar(x[1])
      by <- max(2, max(nc, getOption("width") - 2) %/% nc)
      s <- unique(c(seq(0, n, by = by), n))
      ends <- s[-1]
      starts <- s[-length(s)] + 1

      mapply(
        function(start, end) {
          paste0(x[seq.int(start, end)], collapse = "")
        },
        start = starts,
        end = ends
      )
    }

  cat(crayon_magenta(res), sep = "\n")
}
