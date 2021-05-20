.onAttach <- function(libname, pkgname) {
  e <- new.env()
  e$op <- options()
  e$op$defaultPackages <- unique(c("Rprofile", e$op$defaultPackages))
  e$op$attachedPackages <- search()
  assign_rprofile(e)
}
