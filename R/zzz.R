.onAttach <- function(libname, pkgname) {
  get("assign", baseenv())("..Rprofile", rprofile, envir = globalenv())
}
