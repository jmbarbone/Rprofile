use_color <- function() {
  available_namespace("crayon") &&
    reset_namespaces(getOption("crayon.enabled", crayon::has_color()))
}

# add more when used
crayon_ <- function(color) {
  function(x) {
    if (use_color()) {
      reset_namespaces(utils::getFromNamespace(color, asNamespace("crayon"))(x))
    } else {
      x
    }
  }
}

crayon_cyan <- crayon_("cyan")
crayon_yellow <- crayon_("yellow")
crayon_green <- crayon_("green")
crayon_blue <- crayon_("blue")
crayon_red <- crayon_("red")
crayon_magenta <- crayon_("magenta")
crayon_silver <- crayon_("silver")

crayon_strip <- function(x) {
  if (available_namespace("crayon")) {
    reset_namespaces(crayon::strip_style(x))
  } else {
    x
  }
}
