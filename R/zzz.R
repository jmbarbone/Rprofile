.onAttach <- function(libname, pkgname) {
  e <- get_rprofile()

  if (is.null(e)) {
    e <- new.env()
    e$op <- options()
    e$op$defaultPackages <- unique(c("Rprofile", e$op$defaultPackages))
    e$op$attachedPackages <- search()
  }

  options(e$op)
  assign_rprofile(e)
}
