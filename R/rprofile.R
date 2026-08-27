rprofile <- new.env()
local(envir = rprofile, {
  options <- new.env()
})
lockEnvironment(rprofile)

# we will prioritize this library path for functions inside .Rprofile
.Library.Rprofile <- Sys.getenv("R_LIBS_RPROFILE", "~/rprofile-library")

#' Get .Rprofile
#'
#' @returns
#' * `.Rprofile()` The `.Rprofile()` path, invisibly
#' @family Rprofile
#' @name Rprofile-file
NULL

#' @export
#' @rdname Rprofile-file
#' @param update If `TRUE` will copy the .Rprofile from the Rprofile package
#'   (defaults to the value of `overwrite`)
#' @param overwrite If `TRUE` and `update = TRUE` will overwrite .Rprofile if it
#'   exists; ignored if `update` is not `TRUE`
#' @param path The file location of your `.Rprofile`
.Rprofile <- function(
  update = overwrite,
  overwrite = FALSE,
  path = .FindRprofile()
) {
  stopifnot(is.character(path), length(path) == 1)
  old_path <- normalizePath(path, "/", mustWork = FALSE)

  if (update) {
    on.exit(.try(Sys.chmod(old_path)), add = TRUE)
    new_path <- sf("dot-Rprofile.R", check = TRUE)
    file.copy(new_path, old_path, overwrite = overwrite)
  } else {
    if (!file.exists(old_path)) {
      stop(
        sprintf(".Rprofile not found: %s (%s)", old_path, path),
        call. = FALSE
      )
    }

    cat("Opening", old_path, "\n")
    get("file.edit")(old_path)
    invisible(old_path)
  }
}

#' @export
#' @rdname Rprofile-file
#' @param quiet If `TRUE` silences messages, otherwise provides information
#'   about the location of `.Rprofile`
#' @returns
#' * `.FindRprofile()` (hopefully) a path to your `.Rprofile`
.FindRprofile <- function(quiet = FALSE) {
  msg <- if (quiet) {
    function(...) invisible()
  } else {
    match.fun("message")
  }

  path <- getOption("rprofile.rprofile")

  if (!is.null(path)) {
    msg("using .Rprofile from options")
    return(path)
  }

  path <- Sys.getenv("R_PROFILE", "")
  if (path != "") {
    msg("using .Rprofile from envvar R_PROFILE")
    return(path)
  }

  msg("using default ~/.Rprofile")
  "~/.Rprofile"
}

#' Jordan's Rprofile options
#'
#' @export
.RprofileJordan <- function() {
  .libPaths(c(
    .libPaths(),
    Sys.getenv("R_LIBS_PAK", "~/R/pak-library"),
    Sys.getenv("R_LIBS_SCRIBE", "~/R/scribe-library"),
    .Library.Rprofile
  ))

  .AttachDevtools()
  .AddAttachedPackagesToDefaultPackages()
  .GitBranchPrompt()
  .GlobalHandle()

  if (interactive()) {
    .UtilMessage("source_rprofile")
    .NiceMessage()
    .Todos(.quiet = FALSE, .space = TRUE)
    .CheckCranStatus()
    .Search()
  }

  jordan <-
    tolower(Sys.getenv("USER", Sys.getenv("USERNAME"))) %in%
    c("jordan", "jbarbone", "jmbarbone", "jmbar")

  # Loads devtools and usethis
  local({
    opts <- list(
      tidyverse.quiet = TRUE,
      testthat.progress.max_fails = 100
    )

    if (jordan) {
      opts <- c(
        opts,
        list(
          devtools.name = paste(person_jordan$given, person_jordan$family),
          # TODO can mark.author accept a person() object?
          mark.author = unclass(person_jordan)[[1L]],
          usethis.description = list(
            `Authors@R` = person_jordan,
            License = "MIT + file LICENSE",
            Language = "en-US"
          )
        )
      )
    }

    conflictRules(
      "fuj",
      mask.ok = list(
        testthat = "not",
        Rprofile = c(
          "%::%",
          "%out%",
          "%wo%",
          "match_arg",
          "require_namespace"
        )
      )
    )
    conflictRules(
      "cnd",
      mask.ok = list(
        fuj = c(
          "value_error",
          "class_error",
          "type_error",
          "input_error",
          "use_error",
          "duplicate_error",
          "defunct_error",
          "internal_error"
        )
      )
    )

    options(opts)
  })
}


person_jordan <- person(
  "Jordan Mark",
  "Barbone",
  email = "jmbarbone@gmail.com",
  role = c("aut", "cph", "cre"),
  comment = c(ORCID = "0000-0001-9788-3628")
)
