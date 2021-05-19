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
    x <- jordan::read_clipboard()
  }

  lapply(x, function(x) {
    if (length(x) == 0) {
      return(NA_real_)
    }

    nm <- jordan::chr_split(x)
    jordan::set_names0(seq_along(nm), nm)
  })
}
