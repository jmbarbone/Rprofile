check_rprofile <- function() {
  if (!exists("rprofile_env", envir = globalenv(), mode = "environment")) {
    stop("rprofile_env is not found", call. = FALSE)
  }
}

get_rprofile <- function() {
  get0("rprofile_env", envir = globalenv(), mode = "environment")
}

assign_rprofile <- function(x) {
  assign("rprofile_env", x, envir = globalenv())
}

ls_global_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

sysfile <- function(..., check = FALSE) {
  system.file(..., package = "Rprofile", mustWork = check)
}
