#' Reload
#'
#' Reloads your session
#'
#' @param remove_objects Logical, if `TRUE` will remove all objects found
#' @param loud Logical, if `TRUE` will present a message on removed objects
#'
#' @export
#' @name Reload
.Reload <- function(remove_objects = TRUE, loud = FALSE) {
  cat(crayon::cyan("Preparing Restart ...\n"))
  objs <- setdiff(ls_all(), "rprofile_env")

  if (remove_objects) {
    if (loud & length(objs) > 0L) {
      message("Removing all objects in the Global Environment:\n",
        mark::collapse0(objs, sep = " ... "))
    }
    rm(list = objs, envir = .GlobalEnv)
  }

  .RemoveAttachedPackages()
  .Restart()
  cat(crayon::cyan("Done!"))
}

#' @export
#' @rdname Reload
.Restart <- function() {
  mark::require_namespace("rstudioapi")
  .RemoveAll()
  rstudioapi::restartSession()
}

#' Reset options
#'
#' @param keep_prompt Logical, if `FALSE` will not reset the `prompt` option
#' @export
.ResetOptions <- function(keep_prompt = TRUE) {
  x <- get_rprofile()

  if (keep_prompt) {
    x$op$prompt <- .GitBranchPrompt()
  }

  assign_rprofile(x)
  options(x$op)
}

#' Remove all objects
#'
#' Removes all objects from the global environment
#'
#' @export
.RemoveAll <- function() {
  remove(list = ls_all(), envir = globalenv())
}


# helpers -----------------------------------------------------------------


.default_packages <- c("base", "datasets", "utils", "grDevices", "graphics", "stats", "methods")
names(.default_packages) <- paste0("package:", .default_packages)


#' Finds where tag is in file and removes the line and the line after
#' Assumes that the 'tag' is from this package and starts with
#'   '@jordan_'
#' setting "tag" to NULL will remove any instances
#' @param file A file path
#' @param tag A character tag
#' @param warn if `FALSE` will not produce a warning message
remove_tag_and_save <- function(file, tag, warn = TRUE) {
  x <- readLines(file)

  tag <- if (length(tag) == 0L) {
    jtag("")
  } else {
    jtag(tag)
  }

  line <- grep(paste0("^(", tag, ")"), x, fixed = FALSE)

  if (length(line) == 0L) {
    if (warn) {
      warning("Tag `", tag, "` not found in ", file, call. = FALSE)
    }
    return(invisible())
  }

  # Remove line of tag and next line
  out <- x[-c(line, line + 1L)]
  out <- mark::collapse0(out, sep = "\n")
  out <- gsub("\n?$", "\n", out)
  writeLines(out, file)
}

jtag <- function(x = NULL) {
  # Creates a tag using the system name
  if (is.null(x)) {
    x <- as.character(sys.call(1L))
    # Remove package name
    x <- sub("^.*[:]", "", x)

    if (length(x) == 0L) {
      stop("x has a length of 0", call. = FALSE)
    }
  }

  if (!is.character(x)) {
    stop("x must be a character", call. = FALSE)
  }

  if (!grepl("^# @jordan ", x)) {
    x <- paste0("# @jordan ", x)
  }

  x
}
