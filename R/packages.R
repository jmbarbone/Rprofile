#' Manage attached packages
#'
#' Clears out attached packages and properly loads
#'
#' @param attached A character vector of packages - if NULL will find packages
#'
#' @export
#' @name attached_packages
.SendAttachedPackagesToREnviron <- function() {
  x <- get_rprofile()
  attached <- grep("^package[:]", search(), value = TRUE)
  attached2 <- rev(gsub("^package[:]", "", attached))
  attached2 <- setdiff(attached2, .default_packages)

  file <- ".Renviron"
  tag <- jtag()

  # If file exists, see if we need to remove the previous statement
  fe <- file.exists(file)

  if (fe) {
    remove_tag_and_save(file, tag, warn = FALSE)
  }

  defaults <- c(.default_packages, attached2)
  x$op$defaultPackages <- defaults
  pkgs <- jordan::collapse0(defaults, sep = ",")
  line <- sprintf("%s\nR_DEFAULT_PACKAGES='%s'\n", tag, pkgs)
  cat(line, sep = "", file = file, append = fe)

  assign_rprofile(x)
  .RemoveAttachedPackages()
}

#' @export
#' @rdname attached_packages
.RemoveAttachedPackages <- function(attached = NULL) {
  if (is.null(attached)) {
    attached <- grep("^package[:]", search(), value = TRUE)
  } else {
    bad <- grep("^package[:]", attached, invert = TRUE)
    attached[bad] <- paste0("package:", attached[bad])
  }

  fine <- c("package:Rprofile", rev(names(.default_packages)))
  attached <- setdiff(attached, fine)

  for (a in attached) {
    tryCatch({
      unloadNamespace(a)
      detach(a, character.only = TRUE, unload = TRUE)
    },
      error = function(e) {
        warning("`", a, "` was not found in `detach()`")
      }
    )
  }
}
