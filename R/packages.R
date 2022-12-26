#' Manage attached packages
#'
#' Clears out attached packages and properly loads
#'
#' @export
#' @name attached_packages
.SendAttachedPackagesToREnviron <- function() {
  x <- get_rprofile()
  attached <- grep("^package[:]", search(), value = TRUE)
  attached <- rev(gsub("^package[:]", "", attached))
  attached <- setdiff(attached, .default_packages)

  file <- ".Renviron"
  tag <- jtag()

  # If file exists, see if we need to remove the previous statement
  fe <- file.exists(file)

  if (fe) {
    remove_tag_and_save(file, tag, warn = FALSE)
  }

  defaults <- c(default_packages(), attached)
  x$op$defaultPackages <- defaults
  pkgs <- paste0(defaults, collapse = ",")
  line <- sprintf("%s\nR_DEFAULT_PACKAGES='%s'\n", tag, pkgs)
  cat(line, sep = "", file = file, append = fe)

  assign_rprofile(x)
  .RemoveAttachedPackages()
}

#' @export
#' @rdname attached_packages
#' @param attached A character vector of packages, defaulting to `search()`
.RemoveAttachedPackages <- function(attached = search()) {
  bad <- grep("^(package|org)[:]", attached, invert = TRUE)
  attached[bad] <- paste0("package:", attached[bad])

  fine <- default_packages()
  attached <- attached %wo% names(fine)

  for (a in attached) {
    tryCatch({
      unloadNamespace(a)
      detach(a, character.only = TRUE, force = TRUE)
    },
      error = function(e) {
        warning("`", a, "` was not found in `detach()`")
      }
    )
  }
}

#' @export
#' @rdname attached_packages
#' @family Rprofile
.AddAttachedPackagesToDefaultPackages <- function() {
  attached <- grep("^package[:]", search(), value = TRUE)
  e <- get_rprofile()
  names(attached) <- attached
  attached <- sub("^package[:]", "", attached)
  new <- unique(c(attached, e$op$defaultPackages, "base"), fromLast = TRUE)
  e$op$defaultPackages <- new
  assign_rprofile(e)
}

#' Open package url
#'
#' @param pkg A character vector of package names
#' @returns Nothing, used for its side-effects
#' @export
.OpenPackageUrl <- function(pkg) {
  names(pkg) <- pkg
  invisible(lapply(pkg, do_open_pkg_url))
}

do_open_pkg_url <- function(x) {
  if (!requireNamespace(x, quietly = TRUE)) {
    msg <- sprintf("no installation found for {%s}", x)
    message(msg)
    return(NULL)
  }

  urls <- utils::packageDescription(x)$URL

  if (is.null(urls)) {
    msg <- sprintf("no URL found for {%s}", x)
    warning(msg, call. = FALSE)
    return(NULL)
  }

  urls <- strsplit(urls, ",[[:space:]]+")[[1]]
  urls <- unique(urls)
  lapply(urls, utils::browseURL)
  urls
}
