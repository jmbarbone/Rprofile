
use_color <- function() {
  mark::package_available("crayon") && crayon::has_color()
}

# add more when used
crayon_cyan   <- function(x) if (use_color()) crayon::cyan(x)   else x
crayon_yellow <- function(x) if (use_color()) crayon::yellow(x) else x
crayon_blue   <- function(x) if (use_color()) crayon::blue(x)   else x
