check_rprofile <- function() {
  if (!exists("rprofile_env", envir = globalenv(), mode = "environment")) {
    stop("rprofile_env is not found", call. = FALSE)
  }
}

`%colons%` <- function(package, name) {
  tryCatch(
    get(name, envir = asNamespace(package)),
    error = function(e) {
      stop(sprintf("`%s` not found in package `%s`", name, package), call. = FALSE)
    }
  )
}

ls_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

get_rprofile <- function() {
  get0("rprofile_env", envir = globalenv(), mode = "environment")
}

assign_rprofile <- function(x) {
  assign("rprofile_env", x, envir = globalenv())
}

