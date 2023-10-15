
use_color <- function() {
  requireNamespace("crayon", quietly = TRUE) &&
    getOption("crayon.enabled", crayon::has_color())
}

# add more when used
crayon_cyan    <- function(x) if (use_color()) crayon::cyan(x)    else x
crayon_yellow  <- function(x) if (use_color()) crayon::yellow(x)  else x
crayon_green   <- function(x) if (use_color()) crayon::green(x)   else x
crayon_blue    <- function(x) if (use_color()) crayon::blue(x)    else x
crayon_red     <- function(x) if (use_color()) crayon::red(x)     else x
crayon_magenta <- function(x) if (use_color()) crayon::magenta(x) else x
crayon_silver  <- function(x) if (use_color()) crayon::silver(x)  else x

crayon_strip  <- function(x) {
  if (requireNamespace("crayon", quietly = TRUE)) crayon::strip_style(x) else x
}
