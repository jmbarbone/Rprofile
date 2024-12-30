#' Wrapper for `{pak::pak}`
#'
#' @details If the envvar `R_LIBS_PAK` is set then it will be used as the
#' library path for `{pak}`
#'
#' @param ... Arguments passed to [pak::pak()].
#' @export
.Pak <- function(...) {
  fuj::require_namespace("pak")
  fuj::require_namespace("withr")
  
  libs <- c(Sys.getenv("R_LIBS_PAK"), .libPaths())
  libs <- unique(libs)
  libs <- libs[dir.exists(libs)]
  libs <- Filter(\(lib) length(dir(lib)) > 0, libs)
  
  withr::with_package(
    package = "pak",
    lib.loc = libs,
    utils::getFromNamespace("pak", "pak")(...)
  )
}
