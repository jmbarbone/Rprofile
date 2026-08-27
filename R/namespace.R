reset_namespaces <- function(expr) {
  # we specifically want to load in the namespaces from R_LIBS_RPROFILE
  set_equal <- function(x, y) !anyNA(match(x, y)) && !anyNA(match(y, x))
  loaded <- loadedNamespaces()
  old <- .libPaths()
  .libPaths(
    Sys.getenv("R_LIBS_RPROFILE", "~/R/rprofile-library"),
    include.site = TRUE
  )
  on.exit(
    {
      .libPaths(old)
      for (attempt in seq_len(10L)) {
        if (set_equal(loadedNamespaces(), loaded)) {
          break
        }

        for (ns in loadedNamespaces() %wo% loaded) {
          tryCatch(unloadNamespace(ns), error = \(e) NULL)
        }
      }

      if (attempt == 10L) {
        warning(
          "Failed to unload all namespaces after 10 attempts",
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
  # namespace() will load the namespace which we want to avoid within this
  # package
  lib <- .libPaths()
  if (!"fuj" %in% .packages(all.available = TRUE, lib.loc = lib)) {
    stop(errorCondition(
      "fuj is not installed",
      class = "namespace_error"
    ))
  }

  version <- utils::packageVersion("fuj", lib)
  if (version < "0.2.2.9005") {
    stop(errorCondition(
      sprintf("fuj >= 0.2.2.9005 required but got %s", format(version)),
      class = "namespace_version_error"
    ))
  }
}
