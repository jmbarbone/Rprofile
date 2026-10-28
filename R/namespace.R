#' Unload namespaces
#'
#' @param x,... Namespaces
#'
#' @export
.UnloadNamepsace <- function(x, ...) {
  op <- options(useFancyQuotes = FALSE)
  on.exit(options(op))
  x <- unlist(c(x, ...))
  for (i in x) {
    cat("Unloading namespace '", i, "'\n", sep = "")
    tryCatch(
      unloadNamespace(i),
      simpleError = function(e) {
        if (grepl("is imported by", e$message, fixed = TRUE)) {
          msg <- sub("^.* is imported by ", "", e$message)
          m <- gregexpr("(?<=')[a-zA-z][a-zA-z0-9.]*(?=')", msg, perl = TRUE)
          pkgs <- regmatches(msg, m)[[1L]]
          return(.UnloadNamepsace(pkgs))
        }
        stop(e)
      }
    )
  }
}

reset_namespaces <- function(expr) {
  # we specifically want to load in the namespaces from R_LIBS_RPROFILE
  set_equal <- function(x, y) !anyNA(match(x, y)) && !anyNA(match(y, x))
  old <- .libPaths()
  loaded <- loadedNamespaces()
  on.exit({
    .libPaths(old)
    for (attempt in 1:10) {
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
  })
  r_libs_paths()
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

require_fuj <- local({
  ..available <- FALSE
  function(force = FALSE, version = NULL) {
    if (..available && !force) {
      return(invisible(TRUE))
    }

    # namespace() will load the namespace which we want to avoid within this
    # package
    old <- .libPaths()
    on.exit(.libPaths(old))
    r_libs_paths()
    if (!"fuj" %in% .packages(all.available = TRUE, lib.loc = lib)) {
      stop(errorCondition("fuj is not installed", class = "namespace_error"))
    }

    version <- utils::packageVersion("fuj", lib)
    if (version < "0.2.2.9005") {
      stop(errorCondition(
        sprintf("fuj >= 0.2.2.9005 required but got %s", format(version)),
        class = "namespace_version_error"
      ))
    }
    ..available <<- TRUE
  }
})

r_libs_paths <- function() {
  .libPaths(c(r_libs_profile(), .libPaths()))
}

r_libs_profile <- function(default = "~/R/rprofile-library") {
  Sys.getenv("R_LIBS_RPROFILE", default)
}
