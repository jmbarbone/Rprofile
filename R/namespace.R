reset_namespaces <- function(expr) {
  set_equal <- function(x, y) {
    !anyNA(match(x, y)) && !anyNA(match(y, x))
  }

  loaded <- loadedNamespaces()
  paths <- .libPaths()
  on.exit(
    {
      .libPaths(paths)
      for (attempt in seq_len(100L)) {
        if (set_equal(loadedNamespaces(), loaded)) {
          break
        }

        for (ns in loadedNamespaces() %wo% loaded) {
          tryCatch(unloadNamespace(ns), error = \(e) NULL)
        }
      }

      if (attempt == 100L) {
        warning(
          "Failed to unload all namespaces after 100 attempts",
          call. = FALSE
        )
      }
    },
    add = TRUE
  )
  force(expr)
}

require_namespace <- function(package, ...) {
  require_fuj()
  reset_namespaces(fuj::require_namespace(package, ...))
}

available_namespace <- function(package, ...) {
  require_fuj()
  reset_namespaces(fuj::available_namespace(package, ...))
}


require_fuj <- function() {
  if (!"fuj" %in% .packages(all.available = TRUE, lib.loc = .libPaths())) {
    stop(errorCondition(
      "fuj is not installed",
      class = "namespace_error"
    ))
  }
}
