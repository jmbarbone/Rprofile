#' Character index
#'
#' Splits a vector into each character and shows the index
#'
#' @param x A character vector
#'
#' @references
#' Inspired by: https://www.r-bloggers.com/2020/12/little-helpers-character-index-counter/
#'
#' @examples
#' x <- c("Split this apart", "and count each character.")
#' .CharacterIndex(x)
#'
#' @export
.CharacterIndex <- function(x = NULL) {
  if (is.null(x)) {
    x <- mark::read_clipboard()
  }

  lapply(x, function(x) {
    if (length(x) == 0) {
      return(NA_real_)
    }

    nm <- mark::chr_split(x)
    mark::set_names0(seq_along(nm), nm)
  })
}
