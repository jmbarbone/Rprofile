.onAttach <- function(libname, pkgname) {
  e <- new.env()
  e$op <- options()
  e$op$defaultPackages <- unique(c("Rprofile", e$op$defaultPackages))
  assign_rprofile(e)
}
