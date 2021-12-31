check_rprofile <- function() {
  if (!exists("rprofile_env", envir = globalenv(), mode = "environment")) {
    stop("rprofile_env is not found", call. = FALSE)
  }
}

assign_ <- function(...) {
  ("base" %colons% "assign")(...)
}

get_rprofile <- function() {
  get0("rprofile_env", envir = globalenv(), mode = "environment")
}

assign_rprofile <- function(x) {
  try(assign_("rprofile_env", x, envir = globalenv()))
}

ls_global_all <- function() {
  ls(all.names = TRUE, envir = globalenv(), sorted = FALSE)
}

sf <- mark::make_sf("Rprofile")
