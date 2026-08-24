#' Wrapper for `{pak::pak}`
#'
#' @details If the envvar `R_LIBS_PAK` is set then it will be used as the
#' library path for `{pak}`
#'
#' @param ... Arguments passed to [pak::pak()].
#' @export
.Pak <- function(...) {
  require_namespace("pak")

  libs <- c(Sys.getenv("R_LIBS_PAK"), .libPaths())
  libs <- unique(libs)
  libs <- libs[dir.exists(libs)]
  libs <- Filter(\(lib) length(dir(lib)) > 0, libs)

  reset_namespaces({
    loadNamespace("pak", lib.loc = libs)
    pak::pak(...)
  })
}
