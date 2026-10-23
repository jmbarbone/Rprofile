#' Install Rprofile
#'
#' @param force If `TRUE`, removes the library first
#'
#' @export
.RprofileInstall <- function(force = FALSE) {
  require_namespace("pak")
  lib <- Sys.getenv("R_LIBS_RPROFILE", "~/R/rprofile-library")
  if (force) {
    unlink(lib, TRUE, TRUE)
  }
  dir.create(lib, FALSE, TRUE)
  safe <- file.path(lib, ".safe")
  file.create(safe)
  on.exit(unlink(safe), add = TRUE)
  pak::pkg_install(
    "github::jmbarbone/Rprofile",
    lib = lib,
    upgrade = TRUE,
    dependencies = TRUE
  )
  invisible(lib)
}
