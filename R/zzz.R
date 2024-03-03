.onAttach <- function(libname, pkgname) {
  assign("..Rprofile", rprofile, envir = globalenv())
}
